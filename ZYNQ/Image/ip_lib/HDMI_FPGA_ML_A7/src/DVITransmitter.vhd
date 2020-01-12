--------------------------------------------------------------------------------
--
--  File:
--      DVITransmitter.vhd
--
--  Module:
--      DVITransmitter
--
--  Author:
--      Elod Gyorgy
--
--  Date:
--      04/06/2011
--
--  Description:
--      DVITransmitter takes 24-bit RGB video data with proper sync
--      signals and transmits them on a DVI or HDMI port. The encoding and serialization
--      is done according to the Digital Visual Interface (DVI) specifications Rev 1.0.
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

--library digilent;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity DVITransmitter is
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
end DVITransmitter;

architecture Behavioral of DVITransmitter is
signal intTmdsRed, intTmdsGreen, intTmdsBlue : std_logic_vector(9 downto 0);
signal tmds_p, tmds_n : std_logic_vector(3 downto 0);
signal int_rst, SerClk : std_logic;

constant CLKIN_PERIOD : REAL := 13.468; --ns = 74.25MHz (maximum supported pixel clock)
constant N : NATURAL := 10; --serialization factor
constant PLLO0 : NATURAL := 1;	-- SERCLK = PCLK * N
constant PLLO2 : NATURAL := PLLO0 * N; -- PCLK = PCLK * N / N
constant PLLO3 : NATURAL := PLLO0 * N / 2;	-- PCLK_X2 = PLCK * N / (N/2)
signal intfb, intfb_buf, intpllout_x2, pllout_xs, pllout_x1, pllout_x2: std_logic;
signal PClk, PClk_x2, PllLckd, PllRst, intRst, BufPllLckd, SerStb : std_logic;

component SerializerN_1 is
	 Generic ( 	N : NATURAL := 10;
					FAMILY : STRING := "spartan6");
    Port ( DP_I : in  STD_LOGIC_VECTOR (N-1 downto 0);
           CLKDIV_I : in  STD_LOGIC; --parallel slow clock
           CLKDIV_X2_I : in  STD_LOGIC; --double parallel slow clock (CLKDIV_I x 2) REQUIRED ONLY FOR Spartan-6
			  SERCLK_I : in STD_LOGIC; --serial fast clock (CLK_I = CLKDIV_I x N / 2)
			  SERSTB_I : in STD_LOGIC; -- REQUIRED ONLY FOR Spartan-6
			  RST_I : in STD_LOGIC; --async reset
           DSP_O : out  STD_LOGIC;
           DSN_O : out  STD_LOGIC);
end component;

component TMDSEncoder is
    Port ( D_I : in  STD_LOGIC_VECTOR (7 downto 0);
           C0_I : in  STD_LOGIC;
           C1_I : in  STD_LOGIC;
           DE_I : in  STD_LOGIC;
			  CLK_I: in STD_LOGIC;
			  RST_I: in STD_LOGIC;
           D_O : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

begin

PllRst <= RST_I;

family_s6: if FAMILY = "spartan6" generate
begin
----------------------------------------------------------------------------------
-- Serialization PLL
-- This PLL generates the x2 and x10 pixel clock needed for TMDS serialization
----------------------------------------------------------------------------------

Inst_10_1_pll : PLL_BASE generic map(
      BANDWIDTH			=> "OPTIMIZED",  		-- "high", "low" or "optimized"
      CLKFBOUT_MULT		=> N,       			-- multiplication factor for all output clocks
		COMPENSATION		=> "INTERNAL",			-- "SYSTEM_SYNCHRONOUS", "SOURCE_SYNCHRONOUS", "INTERNAL", "EXTERNAL", "DCM2PLL", "PLL2DCM"
      DIVCLK_DIVIDE		=> 1,       			-- division factor for all clocks (1 to 52)
      CLKFBOUT_PHASE		=> 0.0,     			-- phase shift (degrees) of all output clocks
		CLK_FEEDBACK		=> "CLKFBOUT",
      CLKIN_PERIOD		=> CLKIN_PERIOD,  		-- clock period (ns) of input clock on clkin1
      CLKOUT0_DIVIDE		=> PLLO0,       			-- division factor for clkout0 (1 to 128)
      CLKOUT2_DIVIDE		=> PLLO2,   			-- division factor for clkout2 (1 to 128)
      CLKOUT3_DIVIDE		=> PLLO3,   			-- division factor for clkout3 (1 to 128)
      REF_JITTER		=> 0.025)       		-- input reference jitter (0.000 to 0.999 ui%)
port map (
      CLKFBOUT			=> intfb,              		-- general output feedback signal
		CLKFBIN			=> intfb_buf,			-- clock feedback input
      CLKOUT0			=> pllout_xs,      		-- x10 clock for transmitter
      CLKOUT1			=> open,
      CLKOUT2			=> pllout_x1,              	-- x1 clock for BUFG
      CLKOUT3			=> pllout_x2,              	-- x2 clock for BUFG
      CLKOUT4			=> open,              		-- one of six general clock output signals
      CLKOUT5			=> open,              		-- one of six general clock output signals
      LOCKED			=> PllLckd,        		-- active high pll lock signal
      CLKIN				=> PCLK_I,	     		-- primary clock input
      RST				=> PllRst);               	-- asynchronous pll reset

intfb_buf <= intfb;
----------------------------------------------------------------------------------
-- Route the pixel clock and 2x pixel clock through the global clock network
----------------------------------------------------------------------------------
   BUFG_inst1 : BUFG port map ( O => PClk, I => pllout_x1 );
	BUFG_inst2 : BUFG port map ( O => intpllout_x2, I => pllout_x2 );
	PClk_x2 <= intpllout_x2;
	
----------------------------------------------------------------------------------
-- Route High-Speed serialization clock to OSERDES2 primitives in the whole bank
----------------------------------------------------------------------------------

BUFPLL_inst : BUFPLL
   generic map (
      DIVIDE => N/2,         -- DIVCLK divider (1-8)
      ENABLE_SYNC => TRUE  -- Enable synchrnonization between PLL and GCLK (TRUE/FALSE)
   )
   port map (
      IOCLK => SerClk,               -- 1-bit Output I/O clock
      LOCK => BufPllLckd,                 -- 1-bit Synchronized LOCK output
      SERDESSTROBE => SerStb, -- 1-bit Output SERDES strobe (connect to ISERDES/OSERDES)
      GCLK => intpllout_x2,                 -- 1-bit BUFG clock input
      LOCKED => PllLckd,           -- 1-bit LOCKED input from PLL
      PLLIN => pllout_xs            -- 1-bit Clock input from PLL
   );

intRst <= not BufPllLckd or not PllLckd;

end generate family_s6;

family_7: if FAMILY = "kintex7" or FAMILY = "artix7" or FAMILY = "virtex7" generate
begin
----------------------------------------------------------------------------------
-- Serialization PLL
-- This PLL generates the x5 pixel clock needed for TMDS serialization on series-7
-- architectures.
----------------------------------------------------------------------------------
--   PLLE2_BASE_inst : PLLE2_BASE
--   generic map (
--      BANDWIDTH => "OPTIMIZED",  -- Jitter programming (OPTIMIZED, HIGH, LOW)
--		STARTUP_WAIT => "FALSE",      -- Delays DONE until MMCM is locked (FALSE, TRUE)
--		
--      CLKFBOUT_MULT => 10,    -- Multiply value for all CLKOUT (2.000-64.000).
--      CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB (-360.000-360.000).
--		DIVCLK_DIVIDE => 1,        -- Master division value (1-106)
--      CLKIN1_PERIOD => 9.259,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
-- 		
--      CLKOUT0_DIVIDE     => 2,
--		CLKOUT0_PHASE      => 0.000,
--		CLKOUT0_DUTY_CYCLE => 0.500,
--		CLKOUT1_DIVIDE     => 10,
--		CLKOUT1_PHASE      => 0.000,
--		CLKOUT1_DUTY_CYCLE => 0.500,
--	
--      REF_JITTER1 => 0.010        -- Reference input jitter in UI (0.000-0.999).
--   )
--   port map (
--      -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
--      CLKOUT0 => pllout_xs,     -- Serial Clock = Parallel Clock x 5 (DDR)
--      CLKOUT1 => pllout_x1,     -- Parallel Clock Buffered, Phase-aligned with Serial Clock
--      CLKOUT2 => open,     -- 1-bit output: CLKOUT2
--      CLKOUT3 => open,     -- 1-bit output: CLKOUT3
--      CLKOUT4 => open,     -- 1-bit output: CLKOUT4
--      CLKOUT5 => open,     -- 1-bit output: CLKOUT5
--      -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
--      CLKFBOUT => intfb,   -- 1-bit output: Feedback clock
--      -- Status Ports: 1-bit (each) output: MMCM status ports
--      LOCKED => PllLckd,       -- 1-bit output: LOCK
--      -- Clock Inputs: 1-bit (each) input: Clock input
--      CLKIN1 => PCLK_I,       -- 1-bit input: Clock
--      -- Control Ports: 1-bit (each) input: MMCM control ports
--      PWRDWN => '0',       -- 1-bit input: Power-down
--      RST => PllRst,             -- 1-bit input: Reset
--      -- Feedback Clocks: 1-bit (each) input: Clock feedback ports
--      CLKFBIN => intfb_buf      -- 1-bit input: Feedback clock
--   );
--  -- Output buffering
--  -------------------------------------
--  clkf_buf : BUFG
--  port map
--   (O => intfb_buf,
--    I => intfb);
--
--
--  clkout0_buf : BUFG
--  port map
--   (O   => SerClk,
--    I   => pllout_xs);
--
--
--
--  clkout1_buf : BUFG
--  port map
--   (O   => PClk,
--    I   => pllout_x1);
--
--intRst <= not PllLckd;
PClk <= PCLK_I;
SerClk <= PCLK_X5_I;
intRst <= RST_I;
end generate family_7;

----------------------------------------------------------------------------------
-- DVI Encoder; DVI 1.0 Specifications
-- This component encodes 24-bit RGB video frames with sync signals into 10-bit
-- TMDS characters.
----------------------------------------------------------------------------------
	Inst_TMDSEncoder_red: TMDSEncoder PORT MAP(
		D_I => RED_I,
		C0_I => '0',
		C1_I => '0',
		DE_I => VDE_I,
		CLK_I => PClk,
		RST_I => intRst,
		D_O => intTmdsRed
	);
	Inst_TMDSEncoder_green: TMDSEncoder PORT MAP(
		D_I => GREEN_I,
		C0_I => '0',
		C1_I => '0',
		DE_I => VDE_I,
		CLK_I => PClk,
		RST_I => intRst,
		D_O => intTmdsGreen
	);
	Inst_TMDSEncoder_blue: TMDSEncoder PORT MAP(
		D_I => BLUE_I,
		C0_I => HS_I,
		C1_I => VS_I,
		DE_I => VDE_I,
		CLK_I => PClk,
		RST_I => intRst,
		D_O => intTmdsBlue
	);
	
----------------------------------------------------------------------------------
-- TMDS serializer; ratio of 10:1; 3 data & 1 clock channel
-- Since the TMDS clock's period is character-long (10-bit periods), the
-- serialization of "1111100000" will result in a 10-bit long clock period.
----------------------------------------------------------------------------------

	Inst_clk_serializer_10_1: SerializerN_1 GENERIC MAP (10, FAMILY)
	PORT MAP(
		DP_I => "1111100000",
		CLKDIV_I => PClk,
		CLKDIV_X2_I => PClk_x2,
		SERCLK_I => SerClk,
		SERSTB_I => SerStb,
		RST_I => intRst,
		DSP_O => TMDS_TX_CLK_P,
		DSN_O => TMDS_TX_CLK_N
	);
	Inst_d2_serializer_10_1: SerializerN_1 GENERIC MAP (10, FAMILY)
	PORT MAP(
		DP_I => intTmdsRed,
		CLKDIV_I => PClk,
		CLKDIV_X2_I => PClk_x2,
		SERCLK_I => SerClk,
		SERSTB_I => SerStb,
		RST_I => intRst,
		DSP_O => TMDS_TX_2_P,
		DSN_O => TMDS_TX_2_N
	);
	Inst_d1_serializer_10_1: SerializerN_1 GENERIC MAP (10, FAMILY)
	PORT MAP(
		DP_I => intTmdsGreen,
		CLKDIV_I => PClk,
		CLKDIV_X2_I => PClk_x2,
		SERCLK_I => SerClk,
		SERSTB_I => SerStb,
		RST_I => intRst,
		DSP_O => TMDS_TX_1_P,
		DSN_O => TMDS_TX_1_N
	);
	Inst_d0_serializer_10_1: SerializerN_1 GENERIC MAP (10, FAMILY)
	PORT MAP(
		DP_I => intTmdsBlue,
		CLKDIV_I => PClk,
		CLKDIV_X2_I => PClk_x2,
		SERCLK_I => SerClk,
		SERSTB_I => SerStb,
		RST_I => intRst,
		DSP_O => TMDS_TX_0_P,
		DSN_O => TMDS_TX_0_N
	);

end Behavioral;

