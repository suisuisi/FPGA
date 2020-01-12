--------------------------------------------------------------------------------
--
--  File:
--      HDMI_FPGA_ML.vhd
--
--  Module:
--      HDMI Transmitter
--
--  Author:
--      Sam Bobrowicz
--
--  Date:
--      2/10/2014
--
--  Description:
--      Converts a 24-bit color VGA stream to an HDMI stream
--
--  TODO:
--      1) Bring Family Parameter up to user
--      2) Add sound encoding capability (low priority)
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity HDMI_FPGA_ML is
	Port (
		PXLCLK_I : in STD_LOGIC;
		PXLCLK_5X_I : in STD_LOGIC;
		LOCKED_I : in STD_LOGIC;
		RST_N : in STD_LOGIC;
		
		--VGA
		VGA_HS : in std_logic;
		VGA_VS : in std_logic;
		VGA_DE : in std_logic;
		VGA_RGB : in std_logic_vector(23 downto 0);
	  --VGA_R : in std_logic_vector(7 downto 0);
	  --VGA_G : in std_logic_vector(7 downto 0);
	  --VGA_B : in std_logic_vector(7 downto 0);

		--HDMI
		HDMI_CLK_P : out  STD_LOGIC;
		HDMI_CLK_N : out  STD_LOGIC;
		HDMI_D2_P : out  STD_LOGIC;
		HDMI_D2_N : out  STD_LOGIC;
		HDMI_D1_P : out  STD_LOGIC;
		HDMI_D1_N : out  STD_LOGIC;
		HDMI_D0_P : out  STD_LOGIC;
		HDMI_D0_N : out  STD_LOGIC
	);
			  
end HDMI_FPGA_ML;

architecture Behavioral of HDMI_FPGA_ML is

component DVITransmitter is
	 Generic (FAMILY : STRING := "spartan6");
    Port ( RED_I : in  STD_LOGIC_VECTOR (7 downto 0);
           GREEN_I : in  STD_LOGIC_VECTOR (7 downto 0);
           BLUE_I : in  STD_LOGIC_VECTOR (7 downto 0);
           HS_I : in  STD_LOGIC;
           VS_I : in  STD_LOGIC;
           VDE_I : in  STD_LOGIC;
			  RST_I : in STD_LOGIC;
           PCLK_I : in  STD_LOGIC;
           PCLK_X5_I : in  STD_LOGIC;
           TMDS_TX_CLK_P : out  STD_LOGIC;
           TMDS_TX_CLK_N : out  STD_LOGIC;
           TMDS_TX_2_P : out  STD_LOGIC;
           TMDS_TX_2_N : out  STD_LOGIC;
           TMDS_TX_1_P : out  STD_LOGIC;
           TMDS_TX_1_N : out  STD_LOGIC;
           TMDS_TX_0_P : out  STD_LOGIC;
           TMDS_TX_0_N : out  STD_LOGIC);
end component;

signal SysRst : std_logic;

begin

SysRst <= not(RST_N) or not(LOCKED_I);

----------------------------------------------------------------------------------
-- DVI/HDMI Transmitter
----------------------------------------------------------------------------------		
	Inst_DVITransmitter: DVITransmitter 
	GENERIC MAP ("artix7")
	PORT MAP(
		RED_I => VGA_RGB(23 downto 16),
		GREEN_I => VGA_RGB(15 downto 8),
		BLUE_I => VGA_RGB(7 downto 0),
		HS_I => VGA_HS,
		VS_I => VGA_VS,
		VDE_I => VGA_DE,
		RST_I => SysRst,
		PCLK_I => PXLCLK_I,
		PCLK_X5_I => PXLCLK_5X_I,
		TMDS_TX_CLK_P => HDMI_CLK_P,
		TMDS_TX_CLK_N => HDMI_CLK_N,
		TMDS_TX_2_P => HDMI_D2_P,
		TMDS_TX_2_N => HDMI_D2_N,
		TMDS_TX_1_P => HDMI_D1_P,
		TMDS_TX_1_N => HDMI_D1_N,
		TMDS_TX_0_P => HDMI_D0_P,
		TMDS_TX_0_N => HDMI_D0_N 
	);
	
end Behavioral;

