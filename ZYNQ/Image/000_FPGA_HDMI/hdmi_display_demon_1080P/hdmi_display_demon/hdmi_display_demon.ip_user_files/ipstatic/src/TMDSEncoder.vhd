--------------------------------------------------------------------------------
--
--  File:
--      TMDSEncoder.vhd
--
--  Module:
--      TMDSEncoder
--
--  Author:
--      Elod Gyorgy
--
--  Date:
--      10/28/2010
--
--  Description:
--      This module encodes 8 bit data and 2 control signals into 10 bit TMDS symbols
--
--  Copyright notice:
--      Copyright (C) 2014 Digilent Inc.
--
--  License:
--      This program is free software; distributed under the terms of 
--      BSD 3-clause license ("Revised BSD License", "New BSD License", or "Modified BSD License")
--
--      Redistribution and use in source and binary forms, with or without modification,
--      are permitted provided that the following conditions are met:
--
--      1.    Redistributions of source code must retain the above copyright notice, this
--             list of conditions and the following disclaimer.
--      2.    Redistributions in binary form must reproduce the above copyright notice,
--             this list of conditions and the following disclaimer in the documentation
--             and/or other materials provided with the distribution.
--      3.    Neither the name(s) of the above-listed copyright holder(s) nor the names
--             of its contributors may be used to endorse or promote products derived
--             from this software without specific prior written permission.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--      ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--      WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
--      IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
--      INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
--      BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
--      LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
--      OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
--      OF THE POSSIBILITY OF SUCH DAMAGE.
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TMDSEncoder is
    Port ( D_I : in  STD_LOGIC_VECTOR (7 downto 0);
           C0_I : in  STD_LOGIC;
           C1_I : in  STD_LOGIC;
           DE_I : in  STD_LOGIC;
			  CLK_I: in STD_LOGIC;
			  RST_I: in STD_LOGIC;
           D_O : out  STD_LOGIC_VECTOR (9 downto 0));
end TMDSEncoder;

architecture Behavioral of TMDSEncoder is
signal d_d : std_logic_vector(7 downto 0);
signal q_m, q_m_xor, q_m_xnor, q_m_d: std_logic_vector(8 downto 0);
signal control_token, q_out, q_out_d: std_logic_vector(9 downto 0);
signal n1_d, n1_q_m, n0_q_m, int_n1_q_m : std_logic_vector(4 downto 0); --range 0-8 + sign
signal dc_bias, cnt_t_1, cnt_t : std_logic_vector(4 downto 0) := "00000"; --range -8 - +8 + sign
signal c0_d, c1_d, de_d, c0_dd, c1_dd, de_dd : std_logic;
signal cond_not_balanced, cond_balanced : std_logic;
begin

----------------------------------------------------------------------------------
-- DVI 1.0 Specs Figure 3-5
-- Pipeline stage 1, minimise transitions
----------------------------------------------------------------------------------
process(CLK_I)
begin
	if Rising_Edge(CLK_I) then
		de_d <= DE_I;

		n1_d <= CONV_STD_LOGIC_VECTOR(0, n1_d'Length) + D_I(0) + D_I(1) + D_I(2) + D_I(3) + D_I(4) + D_I(5) + D_I(6) + D_I(7);
		d_d <= D_I; --insert data into the pipeline;
		c0_d <= C0_I; --insert control into the pipeline;
		c1_d <= C1_I;
	end if;
end process;

----------------------------------------------------------------------------------
-- Choose one of the two encoding options based on n1_d
----------------------------------------------------------------------------------
q_m_xor(0) <= d_d(0);
encode1: for i in 1 to 7 generate
	q_m_xor(i) <= q_m_xor(i-1) xor d_d(i);
end generate;
q_m_xor(8) <= '1';

q_m_xnor(0) <= d_d(0);
encode2: for i in 1 to 7 generate
	q_m_xnor(i) <= q_m_xnor(i-1) xnor d_d(i);
end generate;
q_m_xnor(8) <= '0';

q_m <= 	q_m_xnor when n1_d > 4 or (n1_d = 4 and d_d(0) = '0') else
			q_m_xor;
			
----------------------------------------------------------------------------------
-- Pipeline stage 2, balance DC
----------------------------------------------------------------------------------
int_n1_q_m <= CONV_STD_LOGIC_VECTOR(0, n1_q_m'Length) + q_m(0) + q_m(1) + q_m(2) + q_m(3) + q_m(4) + q_m(5) + q_m(6) + q_m(7);
process(CLK_I)
begin
	if Rising_Edge(CLK_I) then
		n1_q_m <= int_n1_q_m;
		n0_q_m <= CONV_STD_LOGIC_VECTOR(8, n0_q_m'Length) - int_n1_q_m;
		q_m_d <= q_m;
		c0_dd <= c0_d; --insert control into the pipeline;
		c1_dd <= c1_d;
		de_dd <= de_d;
	end if;
end process;

cond_balanced <= 	'1' when cnt_t_1 = 0 or n1_q_m = n0_q_m else -- DC balanced output
						'0';
cond_not_balanced	<=	'1' when (cnt_t_1 > 0 and n1_q_m > n0_q_m) or -- too many 1's
										(cnt_t_1 < 0 and n0_q_m > n1_q_m) else -- too many 0's
							'0';

control_token <= 	"1101010100" when c1_dd = '0' and c0_dd = '0' else
						"0010101011" when c1_dd = '0' and c0_dd = '1' else
						"0101010100" when c1_dd = '1' and c0_dd = '0' else
						"1010101011";
							
q_out <= control_token												when de_dd = '0' else	--control period
			not q_m_d(8) & q_m_d(8) & not q_m_d(7 downto 0) when cond_balanced = '1' and q_m_d(8) = '0' else
			not q_m_d(8) & q_m_d(8) & q_m_d(7 downto 0) 		when cond_balanced = '1' and q_m_d(8) = '1' else
			'1' & q_m_d(8) & not q_m_d(7 downto 0)				when cond_not_balanced = '1' else
			'0' & q_m_d(8) & q_m_d(7 downto 0);	--DC balanced

dc_bias <= n0_q_m - n1_q_m;

cnt_t <= CONV_STD_LOGIC_VECTOR(0, cnt_t'Length)				when de_dd = '0' else	--control period
			cnt_t_1 + dc_bias											when cond_balanced = '1' and q_m_d(8) = '0' else
			cnt_t_1 - dc_bias											when cond_balanced = '1' and q_m_d(8) = '1' else
			cnt_t_1 + EXT(q_m(8) & '0', cnt_t'Length) + dc_bias	when cond_not_balanced = '1' else
			cnt_t_1 - EXT(not q_m(8) & '0', cnt_t'Length) - dc_bias;
			
----------------------------------------------------------------------------------
-- Pipeline stage 3, registered output
----------------------------------------------------------------------------------
process(CLK_I)
begin
	if Rising_Edge(CLK_I) then
		cnt_t_1 <= cnt_t;
		q_out_d <= q_out;	
	end if;
end process;

D_O <= q_out_d;

end Behavioral;

