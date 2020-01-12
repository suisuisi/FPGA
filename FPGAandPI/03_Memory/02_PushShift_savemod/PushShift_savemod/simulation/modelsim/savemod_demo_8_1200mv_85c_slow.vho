-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 17.0.0 Build 595 04/25/2017 SJ Standard Edition"

-- DATE "03/31/2019 22:06:40"

-- 
-- Device: Altera EP4CE15F17C8 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	savemod_demo IS
    PORT (
	CLOCK : IN std_logic;
	RESET : IN std_logic;
	DIG : OUT std_logic_vector(7 DOWNTO 0);
	SEL : OUT std_logic_vector(5 DOWNTO 0)
	);
END savemod_demo;

-- Design Ports Information
-- DIG[0]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIG[1]	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIG[2]	=>  Location: PIN_P9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIG[3]	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIG[4]	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIG[5]	=>  Location: PIN_M10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIG[6]	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- DIG[7]	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEL[0]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEL[1]	=>  Location: PIN_P8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEL[2]	=>  Location: PIN_M7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEL[3]	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEL[4]	=>  Location: PIN_P6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SEL[5]	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLOCK	=>  Location: PIN_R9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RESET	=>  Location: PIN_M1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF savemod_demo IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLOCK : std_logic;
SIGNAL ww_RESET : std_logic;
SIGNAL ww_DIG : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_SEL : std_logic_vector(5 DOWNTO 0);
SIGNAL \RESET~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \CLOCK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \DIG[0]~output_o\ : std_logic;
SIGNAL \DIG[1]~output_o\ : std_logic;
SIGNAL \DIG[2]~output_o\ : std_logic;
SIGNAL \DIG[3]~output_o\ : std_logic;
SIGNAL \DIG[4]~output_o\ : std_logic;
SIGNAL \DIG[5]~output_o\ : std_logic;
SIGNAL \DIG[6]~output_o\ : std_logic;
SIGNAL \DIG[7]~output_o\ : std_logic;
SIGNAL \SEL[0]~output_o\ : std_logic;
SIGNAL \SEL[1]~output_o\ : std_logic;
SIGNAL \SEL[2]~output_o\ : std_logic;
SIGNAL \SEL[3]~output_o\ : std_logic;
SIGNAL \SEL[4]~output_o\ : std_logic;
SIGNAL \SEL[5]~output_o\ : std_logic;
SIGNAL \CLOCK~input_o\ : std_logic;
SIGNAL \CLOCK~inputclkctrl_outclk\ : std_logic;
SIGNAL \i[2]~0_combout\ : std_logic;
SIGNAL \RESET~input_o\ : std_logic;
SIGNAL \RESET~inputclkctrl_outclk\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Decoder0~0_combout\ : std_logic;
SIGNAL \U1|RAM~2feeder_combout\ : std_logic;
SIGNAL \isEn~feeder_combout\ : std_logic;
SIGNAL \isEn~q\ : std_logic;
SIGNAL \U1|comb~0_combout\ : std_logic;
SIGNAL \U1|RAM~2_q\ : std_logic;
SIGNAL \U1|D1[2]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[6]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|Add0~0_combout\ : std_logic;
SIGNAL \U2|U1|D1[2]~4_combout\ : std_logic;
SIGNAL \U2|U1|Add0~1\ : std_logic;
SIGNAL \U2|U1|Add0~2_combout\ : std_logic;
SIGNAL \U2|U1|Add0~3\ : std_logic;
SIGNAL \U2|U1|Add0~4_combout\ : std_logic;
SIGNAL \U2|U1|Add0~5\ : std_logic;
SIGNAL \U2|U1|Add0~6_combout\ : std_logic;
SIGNAL \U2|U1|Mux9~0_combout\ : std_logic;
SIGNAL \U2|U1|Add0~7\ : std_logic;
SIGNAL \U2|U1|Add0~8_combout\ : std_logic;
SIGNAL \U2|U1|Add0~9\ : std_logic;
SIGNAL \U2|U1|Add0~10_combout\ : std_logic;
SIGNAL \U2|U1|Add0~11\ : std_logic;
SIGNAL \U2|U1|Add0~12_combout\ : std_logic;
SIGNAL \U2|U1|Add0~13\ : std_logic;
SIGNAL \U2|U1|Add0~14_combout\ : std_logic;
SIGNAL \U2|U1|Mux5~0_combout\ : std_logic;
SIGNAL \U2|U1|Add0~15\ : std_logic;
SIGNAL \U2|U1|Add0~16_combout\ : std_logic;
SIGNAL \U2|U1|Mux4~0_combout\ : std_logic;
SIGNAL \U2|U1|Equal0~1_combout\ : std_logic;
SIGNAL \U2|U1|Add0~17\ : std_logic;
SIGNAL \U2|U1|Add0~18_combout\ : std_logic;
SIGNAL \U2|U1|Mux3~0_combout\ : std_logic;
SIGNAL \U2|U1|Add0~19\ : std_logic;
SIGNAL \U2|U1|Add0~20_combout\ : std_logic;
SIGNAL \U2|U1|Add0~21\ : std_logic;
SIGNAL \U2|U1|Add0~22_combout\ : std_logic;
SIGNAL \U2|U1|Add0~23\ : std_logic;
SIGNAL \U2|U1|Add0~24_combout\ : std_logic;
SIGNAL \U2|U1|Mux0~0_combout\ : std_logic;
SIGNAL \U2|U1|Equal0~0_combout\ : std_logic;
SIGNAL \U2|U1|Equal0~2_combout\ : std_logic;
SIGNAL \U2|U1|Equal0~3_combout\ : std_logic;
SIGNAL \U2|U1|Mux14~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux15~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux16~2_combout\ : std_logic;
SIGNAL \U2|U1|D1[2]~0_combout\ : std_logic;
SIGNAL \U1|D1[10]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[14]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[18]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|Mux18~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux18~1_combout\ : std_logic;
SIGNAL \U2|U1|Mux26~2_combout\ : std_logic;
SIGNAL \D2[1]~2_combout\ : std_logic;
SIGNAL \U1|RAM~1feeder_combout\ : std_logic;
SIGNAL \U1|RAM~1_q\ : std_logic;
SIGNAL \U1|D1[1]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[5]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|D1[1]~1_combout\ : std_logic;
SIGNAL \U1|D1[13]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[17]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|Mux19~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux19~1_combout\ : std_logic;
SIGNAL \D2[0]~0_combout\ : std_logic;
SIGNAL \U1|RAM~0_q\ : std_logic;
SIGNAL \U1|D1[0]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[4]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|D1[0]~2_combout\ : std_logic;
SIGNAL \U1|D1[12]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[16]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|Mux20~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux20~1_combout\ : std_logic;
SIGNAL \Decoder0~1_combout\ : std_logic;
SIGNAL \U1|RAM~3feeder_combout\ : std_logic;
SIGNAL \U1|RAM~3_q\ : std_logic;
SIGNAL \U1|D1[3]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[7]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|D1[3]~3_combout\ : std_logic;
SIGNAL \U1|D1[15]~feeder_combout\ : std_logic;
SIGNAL \U1|D1[19]~feeder_combout\ : std_logic;
SIGNAL \U2|U1|Mux17~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux17~1_combout\ : std_logic;
SIGNAL \U2|U2|oData[0]~0_combout\ : std_logic;
SIGNAL \U2|U2|oData[1]~1_combout\ : std_logic;
SIGNAL \U2|U2|oData[2]~2_combout\ : std_logic;
SIGNAL \U2|U2|oData[3]~3_combout\ : std_logic;
SIGNAL \U2|U2|oData[4]~4_combout\ : std_logic;
SIGNAL \U2|U2|oData[5]~5_combout\ : std_logic;
SIGNAL \U2|U2|oData[6]~6_combout\ : std_logic;
SIGNAL \U2|U1|Mux26~3_combout\ : std_logic;
SIGNAL \U2|U1|Mux26~5_combout\ : std_logic;
SIGNAL \U2|U1|Mux26~4_combout\ : std_logic;
SIGNAL \U2|U1|Mux25~2_combout\ : std_logic;
SIGNAL \U2|U1|Mux25~4_combout\ : std_logic;
SIGNAL \U2|U1|Mux25~3_combout\ : std_logic;
SIGNAL \U2|U1|Mux24~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux24~1_combout\ : std_logic;
SIGNAL \U2|U1|Mux23~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux23~1_combout\ : std_logic;
SIGNAL \U2|U1|Mux22~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux22~1_combout\ : std_logic;
SIGNAL \U2|U1|Mux21~0_combout\ : std_logic;
SIGNAL \U2|U1|Mux21~1_combout\ : std_logic;
SIGNAL \U2|U1|D1\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \U1|D1\ : std_logic_vector(23 DOWNTO 0);
SIGNAL \U2|U1|D2\ : std_logic_vector(5 DOWNTO 0);
SIGNAL \U2|U1|i\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \U2|U1|C1\ : std_logic_vector(12 DOWNTO 0);
SIGNAL i : std_logic_vector(3 DOWNTO 0);
SIGNAL D2 : std_logic_vector(3 DOWNTO 0);
SIGNAL \U2|U1|ALT_INV_i\ : std_logic_vector(2 DOWNTO 2);
SIGNAL \U2|U1|ALT_INV_D2\ : std_logic_vector(5 DOWNTO 1);
SIGNAL \U2|U2|ALT_INV_oData[6]~6_combout\ : std_logic;

BEGIN

ww_CLOCK <= CLOCK;
ww_RESET <= RESET;
DIG <= ww_DIG;
SEL <= ww_SEL;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\RESET~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \RESET~input_o\);

\CLOCK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLOCK~input_o\);
\U2|U1|ALT_INV_i\(2) <= NOT \U2|U1|i\(2);
\U2|U1|ALT_INV_D2\(5) <= NOT \U2|U1|D2\(5);
\U2|U1|ALT_INV_D2\(4) <= NOT \U2|U1|D2\(4);
\U2|U1|ALT_INV_D2\(3) <= NOT \U2|U1|D2\(3);
\U2|U1|ALT_INV_D2\(2) <= NOT \U2|U1|D2\(2);
\U2|U1|ALT_INV_D2\(1) <= NOT \U2|U1|D2\(1);
\U2|U2|ALT_INV_oData[6]~6_combout\ <= NOT \U2|U2|oData[6]~6_combout\;

-- Location: IOOBUF_X19_Y0_N9
\DIG[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U2|oData[0]~0_combout\,
	devoe => ww_devoe,
	o => \DIG[0]~output_o\);

-- Location: IOOBUF_X16_Y0_N16
\DIG[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U2|oData[1]~1_combout\,
	devoe => ww_devoe,
	o => \DIG[1]~output_o\);

-- Location: IOOBUF_X30_Y0_N23
\DIG[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U2|oData[2]~2_combout\,
	devoe => ww_devoe,
	o => \DIG[2]~output_o\);

-- Location: IOOBUF_X23_Y0_N9
\DIG[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U2|oData[3]~3_combout\,
	devoe => ww_devoe,
	o => \DIG[3]~output_o\);

-- Location: IOOBUF_X23_Y0_N16
\DIG[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U2|oData[4]~4_combout\,
	devoe => ww_devoe,
	o => \DIG[4]~output_o\);

-- Location: IOOBUF_X35_Y0_N23
\DIG[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U2|oData[5]~5_combout\,
	devoe => ww_devoe,
	o => \DIG[5]~output_o\);

-- Location: IOOBUF_X37_Y0_N30
\DIG[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U2|ALT_INV_oData[6]~6_combout\,
	devoe => ww_devoe,
	o => \DIG[6]~output_o\);

-- Location: IOOBUF_X35_Y0_N16
\DIG[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \DIG[7]~output_o\);

-- Location: IOOBUF_X19_Y0_N2
\SEL[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U1|D2\(0),
	devoe => ww_devoe,
	o => \SEL[0]~output_o\);

-- Location: IOOBUF_X21_Y0_N30
\SEL[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U1|ALT_INV_D2\(1),
	devoe => ww_devoe,
	o => \SEL[1]~output_o\);

-- Location: IOOBUF_X14_Y0_N16
\SEL[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U1|ALT_INV_D2\(2),
	devoe => ww_devoe,
	o => \SEL[2]~output_o\);

-- Location: IOOBUF_X7_Y0_N9
\SEL[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U1|ALT_INV_D2\(3),
	devoe => ww_devoe,
	o => \SEL[3]~output_o\);

-- Location: IOOBUF_X14_Y0_N23
\SEL[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U1|ALT_INV_D2\(4),
	devoe => ww_devoe,
	o => \SEL[4]~output_o\);

-- Location: IOOBUF_X7_Y0_N16
\SEL[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \U2|U1|ALT_INV_D2\(5),
	devoe => ww_devoe,
	o => \SEL[5]~output_o\);

-- Location: IOIBUF_X21_Y0_N8
\CLOCK~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK,
	o => \CLOCK~input_o\);

-- Location: CLKCTRL_G17
\CLOCK~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLOCK~inputclkctrl_outclk\);

-- Location: LCCOMB_X8_Y7_N28
\i[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \i[2]~0_combout\ = (i(2)) # ((i(0) & i(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i(0),
	datac => i(2),
	datad => i(1),
	combout => \i[2]~0_combout\);

-- Location: IOIBUF_X0_Y14_N22
\RESET~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RESET,
	o => \RESET~input_o\);

-- Location: CLKCTRL_G3
\RESET~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \RESET~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \RESET~inputclkctrl_outclk\);

-- Location: FF_X8_Y7_N29
\i[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \i[2]~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(2));

-- Location: LCCOMB_X8_Y7_N22
\Mux2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux2~0_combout\ = ((i(1) & i(2))) # (!i(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i(1),
	datac => i(0),
	datad => i(2),
	combout => \Mux2~0_combout\);

-- Location: FF_X8_Y7_N23
\i[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \Mux2~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(0));

-- Location: LCCOMB_X8_Y7_N26
\Mux1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (i(0) & ((i(2)) # (!i(1)))) # (!i(0) & (i(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i(0),
	datac => i(1),
	datad => i(2),
	combout => \Mux1~0_combout\);

-- Location: FF_X8_Y7_N27
\i[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \Mux1~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => i(1));

-- Location: LCCOMB_X8_Y7_N6
\Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = i(1) $ (i(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => i(1),
	datad => i(2),
	combout => \Mux4~0_combout\);

-- Location: LCCOMB_X8_Y7_N16
\Decoder0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Decoder0~0_combout\ = ((!i(2)) # (!i(1))) # (!i(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => i(0),
	datac => i(1),
	datad => i(2),
	combout => \Decoder0~0_combout\);

-- Location: FF_X8_Y7_N7
\D2[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \Mux4~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \Decoder0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(2));

-- Location: LCCOMB_X7_Y6_N30
\U1|RAM~2feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|RAM~2feeder_combout\ = D2(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => D2(2),
	combout => \U1|RAM~2feeder_combout\);

-- Location: LCCOMB_X8_Y7_N24
\isEn~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \isEn~feeder_combout\ = \Decoder0~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Decoder0~0_combout\,
	combout => \isEn~feeder_combout\);

-- Location: FF_X8_Y7_N25
isEn : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \isEn~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \isEn~q\);

-- Location: LCCOMB_X7_Y6_N26
\U1|comb~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|comb~0_combout\ = (\RESET~input_o\ & \isEn~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RESET~input_o\,
	datad => \isEn~q\,
	combout => \U1|comb~0_combout\);

-- Location: FF_X7_Y6_N31
\U1|RAM~2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|RAM~2feeder_combout\,
	ena => \U1|comb~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|RAM~2_q\);

-- Location: LCCOMB_X7_Y6_N18
\U1|D1[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[2]~feeder_combout\ = \U1|RAM~2_q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U1|RAM~2_q\,
	combout => \U1|D1[2]~feeder_combout\);

-- Location: FF_X7_Y6_N19
\U1|D1[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[2]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(2));

-- Location: LCCOMB_X7_Y6_N20
\U1|D1[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[6]~feeder_combout\ = \U1|D1\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(2),
	combout => \U1|D1[6]~feeder_combout\);

-- Location: FF_X7_Y6_N21
\U1|D1[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[6]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(6));

-- Location: LCCOMB_X10_Y6_N4
\U2|U1|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~0_combout\ = \U2|U1|C1\(0) $ (VCC)
-- \U2|U1|Add0~1\ = CARRY(\U2|U1|C1\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|C1\(0),
	datad => VCC,
	combout => \U2|U1|Add0~0_combout\,
	cout => \U2|U1|Add0~1\);

-- Location: LCCOMB_X11_Y6_N4
\U2|U1|D1[2]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|D1[2]~4_combout\ = (!\U2|U1|i\(1)) # (!\U2|U1|i\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U2|U1|i\(2),
	datad => \U2|U1|i\(1),
	combout => \U2|U1|D1[2]~4_combout\);

-- Location: FF_X10_Y6_N5
\U2|U1|C1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(0));

-- Location: LCCOMB_X10_Y6_N6
\U2|U1|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~2_combout\ = (\U2|U1|C1\(1) & (!\U2|U1|Add0~1\)) # (!\U2|U1|C1\(1) & ((\U2|U1|Add0~1\) # (GND)))
-- \U2|U1|Add0~3\ = CARRY((!\U2|U1|Add0~1\) # (!\U2|U1|C1\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(1),
	datad => VCC,
	cin => \U2|U1|Add0~1\,
	combout => \U2|U1|Add0~2_combout\,
	cout => \U2|U1|Add0~3\);

-- Location: FF_X10_Y6_N7
\U2|U1|C1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~2_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(1));

-- Location: LCCOMB_X10_Y6_N8
\U2|U1|Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~4_combout\ = (\U2|U1|C1\(2) & (\U2|U1|Add0~3\ $ (GND))) # (!\U2|U1|C1\(2) & (!\U2|U1|Add0~3\ & VCC))
-- \U2|U1|Add0~5\ = CARRY((\U2|U1|C1\(2) & !\U2|U1|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|C1\(2),
	datad => VCC,
	cin => \U2|U1|Add0~3\,
	combout => \U2|U1|Add0~4_combout\,
	cout => \U2|U1|Add0~5\);

-- Location: FF_X10_Y6_N9
\U2|U1|C1[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~4_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(2));

-- Location: LCCOMB_X10_Y6_N10
\U2|U1|Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~6_combout\ = (\U2|U1|C1\(3) & (!\U2|U1|Add0~5\)) # (!\U2|U1|C1\(3) & ((\U2|U1|Add0~5\) # (GND)))
-- \U2|U1|Add0~7\ = CARRY((!\U2|U1|Add0~5\) # (!\U2|U1|C1\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|C1\(3),
	datad => VCC,
	cin => \U2|U1|Add0~5\,
	combout => \U2|U1|Add0~6_combout\,
	cout => \U2|U1|Add0~7\);

-- Location: LCCOMB_X11_Y6_N8
\U2|U1|Mux9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux9~0_combout\ = (!\U2|U1|Equal0~3_combout\ & \U2|U1|Add0~6_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~3_combout\,
	datad => \U2|U1|Add0~6_combout\,
	combout => \U2|U1|Mux9~0_combout\);

-- Location: FF_X11_Y6_N9
\U2|U1|C1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux9~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(3));

-- Location: LCCOMB_X10_Y6_N12
\U2|U1|Add0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~8_combout\ = (\U2|U1|C1\(4) & (\U2|U1|Add0~7\ $ (GND))) # (!\U2|U1|C1\(4) & (!\U2|U1|Add0~7\ & VCC))
-- \U2|U1|Add0~9\ = CARRY((\U2|U1|C1\(4) & !\U2|U1|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(4),
	datad => VCC,
	cin => \U2|U1|Add0~7\,
	combout => \U2|U1|Add0~8_combout\,
	cout => \U2|U1|Add0~9\);

-- Location: FF_X10_Y6_N13
\U2|U1|C1[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~8_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(4));

-- Location: LCCOMB_X10_Y6_N14
\U2|U1|Add0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~10_combout\ = (\U2|U1|C1\(5) & (!\U2|U1|Add0~9\)) # (!\U2|U1|C1\(5) & ((\U2|U1|Add0~9\) # (GND)))
-- \U2|U1|Add0~11\ = CARRY((!\U2|U1|Add0~9\) # (!\U2|U1|C1\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|C1\(5),
	datad => VCC,
	cin => \U2|U1|Add0~9\,
	combout => \U2|U1|Add0~10_combout\,
	cout => \U2|U1|Add0~11\);

-- Location: FF_X10_Y6_N15
\U2|U1|C1[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~10_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(5));

-- Location: LCCOMB_X10_Y6_N16
\U2|U1|Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~12_combout\ = (\U2|U1|C1\(6) & (\U2|U1|Add0~11\ $ (GND))) # (!\U2|U1|C1\(6) & (!\U2|U1|Add0~11\ & VCC))
-- \U2|U1|Add0~13\ = CARRY((\U2|U1|C1\(6) & !\U2|U1|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|C1\(6),
	datad => VCC,
	cin => \U2|U1|Add0~11\,
	combout => \U2|U1|Add0~12_combout\,
	cout => \U2|U1|Add0~13\);

-- Location: FF_X10_Y6_N17
\U2|U1|C1[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~12_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(6));

-- Location: LCCOMB_X10_Y6_N18
\U2|U1|Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~14_combout\ = (\U2|U1|C1\(7) & (!\U2|U1|Add0~13\)) # (!\U2|U1|C1\(7) & ((\U2|U1|Add0~13\) # (GND)))
-- \U2|U1|Add0~15\ = CARRY((!\U2|U1|Add0~13\) # (!\U2|U1|C1\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(7),
	datad => VCC,
	cin => \U2|U1|Add0~13\,
	combout => \U2|U1|Add0~14_combout\,
	cout => \U2|U1|Add0~15\);

-- Location: LCCOMB_X11_Y6_N6
\U2|U1|Mux5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux5~0_combout\ = (!\U2|U1|Equal0~3_combout\ & \U2|U1|Add0~14_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~3_combout\,
	datad => \U2|U1|Add0~14_combout\,
	combout => \U2|U1|Mux5~0_combout\);

-- Location: FF_X11_Y6_N7
\U2|U1|C1[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux5~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(7));

-- Location: LCCOMB_X10_Y6_N20
\U2|U1|Add0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~16_combout\ = (\U2|U1|C1\(8) & (\U2|U1|Add0~15\ $ (GND))) # (!\U2|U1|C1\(8) & (!\U2|U1|Add0~15\ & VCC))
-- \U2|U1|Add0~17\ = CARRY((\U2|U1|C1\(8) & !\U2|U1|Add0~15\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|C1\(8),
	datad => VCC,
	cin => \U2|U1|Add0~15\,
	combout => \U2|U1|Add0~16_combout\,
	cout => \U2|U1|Add0~17\);

-- Location: LCCOMB_X11_Y6_N0
\U2|U1|Mux4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux4~0_combout\ = (!\U2|U1|Equal0~3_combout\ & \U2|U1|Add0~16_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~3_combout\,
	datad => \U2|U1|Add0~16_combout\,
	combout => \U2|U1|Mux4~0_combout\);

-- Location: FF_X11_Y6_N1
\U2|U1|C1[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux4~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(8));

-- Location: LCCOMB_X10_Y6_N30
\U2|U1|Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Equal0~1_combout\ = (\U2|U1|C1\(7) & (\U2|U1|C1\(8) & (!\U2|U1|C1\(5) & !\U2|U1|C1\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(7),
	datab => \U2|U1|C1\(8),
	datac => \U2|U1|C1\(5),
	datad => \U2|U1|C1\(6),
	combout => \U2|U1|Equal0~1_combout\);

-- Location: LCCOMB_X10_Y6_N22
\U2|U1|Add0~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~18_combout\ = (\U2|U1|C1\(9) & (!\U2|U1|Add0~17\)) # (!\U2|U1|C1\(9) & ((\U2|U1|Add0~17\) # (GND)))
-- \U2|U1|Add0~19\ = CARRY((!\U2|U1|Add0~17\) # (!\U2|U1|C1\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(9),
	datad => VCC,
	cin => \U2|U1|Add0~17\,
	combout => \U2|U1|Add0~18_combout\,
	cout => \U2|U1|Add0~19\);

-- Location: LCCOMB_X11_Y6_N20
\U2|U1|Mux3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux3~0_combout\ = (!\U2|U1|Equal0~3_combout\ & \U2|U1|Add0~18_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~3_combout\,
	datad => \U2|U1|Add0~18_combout\,
	combout => \U2|U1|Mux3~0_combout\);

-- Location: FF_X11_Y6_N21
\U2|U1|C1[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux3~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(9));

-- Location: LCCOMB_X10_Y6_N24
\U2|U1|Add0~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~20_combout\ = (\U2|U1|C1\(10) & (\U2|U1|Add0~19\ $ (GND))) # (!\U2|U1|C1\(10) & (!\U2|U1|Add0~19\ & VCC))
-- \U2|U1|Add0~21\ = CARRY((\U2|U1|C1\(10) & !\U2|U1|Add0~19\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|C1\(10),
	datad => VCC,
	cin => \U2|U1|Add0~19\,
	combout => \U2|U1|Add0~20_combout\,
	cout => \U2|U1|Add0~21\);

-- Location: FF_X10_Y6_N25
\U2|U1|C1[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~20_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(10));

-- Location: LCCOMB_X10_Y6_N26
\U2|U1|Add0~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~22_combout\ = (\U2|U1|C1\(11) & (!\U2|U1|Add0~21\)) # (!\U2|U1|C1\(11) & ((\U2|U1|Add0~21\) # (GND)))
-- \U2|U1|Add0~23\ = CARRY((!\U2|U1|Add0~21\) # (!\U2|U1|C1\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(11),
	datad => VCC,
	cin => \U2|U1|Add0~21\,
	combout => \U2|U1|Add0~22_combout\,
	cout => \U2|U1|Add0~23\);

-- Location: FF_X10_Y6_N27
\U2|U1|C1[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Add0~22_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(11));

-- Location: LCCOMB_X10_Y6_N28
\U2|U1|Add0~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Add0~24_combout\ = \U2|U1|Add0~23\ $ (!\U2|U1|C1\(12))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \U2|U1|C1\(12),
	cin => \U2|U1|Add0~23\,
	combout => \U2|U1|Add0~24_combout\);

-- Location: LCCOMB_X10_Y6_N0
\U2|U1|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux0~0_combout\ = (!\U2|U1|Equal0~3_combout\ & \U2|U1|Add0~24_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|Equal0~3_combout\,
	datad => \U2|U1|Add0~24_combout\,
	combout => \U2|U1|Mux0~0_combout\);

-- Location: FF_X10_Y6_N1
\U2|U1|C1[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux0~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|C1\(12));

-- Location: LCCOMB_X11_Y6_N30
\U2|U1|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Equal0~0_combout\ = (\U2|U1|C1\(12) & (\U2|U1|C1\(9) & (!\U2|U1|C1\(11) & !\U2|U1|C1\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(12),
	datab => \U2|U1|C1\(9),
	datac => \U2|U1|C1\(11),
	datad => \U2|U1|C1\(10),
	combout => \U2|U1|Equal0~0_combout\);

-- Location: LCCOMB_X11_Y6_N2
\U2|U1|Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Equal0~2_combout\ = (\U2|U1|C1\(2) & (!\U2|U1|C1\(3) & (\U2|U1|C1\(1) & !\U2|U1|C1\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|C1\(2),
	datab => \U2|U1|C1\(3),
	datac => \U2|U1|C1\(1),
	datad => \U2|U1|C1\(4),
	combout => \U2|U1|Equal0~2_combout\);

-- Location: LCCOMB_X10_Y6_N2
\U2|U1|Equal0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Equal0~3_combout\ = (\U2|U1|Equal0~1_combout\ & (\U2|U1|C1\(0) & (\U2|U1|Equal0~0_combout\ & \U2|U1|Equal0~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~1_combout\,
	datab => \U2|U1|C1\(0),
	datac => \U2|U1|Equal0~0_combout\,
	datad => \U2|U1|Equal0~2_combout\,
	combout => \U2|U1|Equal0~3_combout\);

-- Location: LCCOMB_X11_Y6_N26
\U2|U1|Mux14~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux14~0_combout\ = (\U2|U1|i\(0) & ((\U2|U1|Equal0~3_combout\ & (\U2|U1|i\(1))) # (!\U2|U1|Equal0~3_combout\ & ((\U2|U1|i\(2)))))) # (!\U2|U1|i\(0) & (((\U2|U1|i\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(0),
	datab => \U2|U1|i\(1),
	datac => \U2|U1|i\(2),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux14~0_combout\);

-- Location: FF_X11_Y6_N27
\U2|U1|i[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux14~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|i\(2));

-- Location: LCCOMB_X11_Y6_N16
\U2|U1|Mux15~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux15~0_combout\ = \U2|U1|i\(1) $ (((\U2|U1|i\(0) & (!\U2|U1|i\(2) & \U2|U1|Equal0~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(0),
	datab => \U2|U1|i\(2),
	datac => \U2|U1|i\(1),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux15~0_combout\);

-- Location: FF_X11_Y6_N17
\U2|U1|i[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux15~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|i\(1));

-- Location: LCCOMB_X11_Y6_N14
\U2|U1|Mux16~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux16~2_combout\ = \U2|U1|i\(0) $ (((\U2|U1|Equal0~3_combout\ & ((!\U2|U1|i\(2)) # (!\U2|U1|i\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000011111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(1),
	datab => \U2|U1|i\(2),
	datac => \U2|U1|i\(0),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux16~2_combout\);

-- Location: FF_X11_Y6_N15
\U2|U1|i[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux16~2_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|i\(0));

-- Location: LCCOMB_X9_Y6_N8
\U2|U1|D1[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|D1[2]~0_combout\ = (\U2|U1|i\(0) & ((\U1|D1\(2)))) # (!\U2|U1|i\(0) & (\U1|D1\(6)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|D1\(6),
	datab => \U1|D1\(2),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|D1[2]~0_combout\);

-- Location: LCCOMB_X7_Y6_N22
\U1|D1[10]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[10]~feeder_combout\ = \U1|D1\(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(6),
	combout => \U1|D1[10]~feeder_combout\);

-- Location: FF_X7_Y6_N23
\U1|D1[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[10]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(10));

-- Location: LCCOMB_X7_Y6_N10
\U1|D1[14]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[14]~feeder_combout\ = \U1|D1\(10)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U1|D1\(10),
	combout => \U1|D1[14]~feeder_combout\);

-- Location: FF_X7_Y6_N11
\U1|D1[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[14]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(14));

-- Location: LCCOMB_X7_Y6_N4
\U1|D1[18]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[18]~feeder_combout\ = \U1|D1\(14)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(14),
	combout => \U1|D1[18]~feeder_combout\);

-- Location: FF_X7_Y6_N5
\U1|D1[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[18]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(18));

-- Location: FF_X7_Y6_N17
\U1|D1[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \U1|D1\(18),
	clrn => \RESET~inputclkctrl_outclk\,
	sload => VCC,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(22));

-- Location: LCCOMB_X7_Y6_N16
\U2|U1|Mux18~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux18~0_combout\ = (\U2|U1|i\(1) & ((\U1|D1\(14)) # ((\U2|U1|i\(0))))) # (!\U2|U1|i\(1) & (((\U1|D1\(22) & !\U2|U1|i\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|D1\(14),
	datab => \U2|U1|i\(1),
	datac => \U1|D1\(22),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|Mux18~0_combout\);

-- Location: LCCOMB_X7_Y6_N28
\U2|U1|Mux18~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux18~1_combout\ = (\U2|U1|i\(0) & ((\U2|U1|Mux18~0_combout\ & ((\U1|D1\(10)))) # (!\U2|U1|Mux18~0_combout\ & (\U1|D1\(18))))) # (!\U2|U1|i\(0) & (((\U2|U1|Mux18~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(0),
	datab => \U1|D1\(18),
	datac => \U1|D1\(10),
	datad => \U2|U1|Mux18~0_combout\,
	combout => \U2|U1|Mux18~1_combout\);

-- Location: LCCOMB_X9_Y6_N22
\U2|U1|Mux26~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux26~2_combout\ = (!\U2|U1|Equal0~3_combout\ & ((!\U2|U1|i\(2)) # (!\U2|U1|i\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(1),
	datac => \U2|U1|i\(2),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux26~2_combout\);

-- Location: FF_X9_Y6_N9
\U2|U1|D1[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|D1[2]~0_combout\,
	asdata => \U2|U1|Mux18~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	sload => \U2|U1|ALT_INV_i\(2),
	ena => \U2|U1|Mux26~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D1\(2));

-- Location: LCCOMB_X8_Y7_N8
\D2[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \D2[1]~2_combout\ = !i(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => i(1),
	combout => \D2[1]~2_combout\);

-- Location: FF_X8_Y7_N9
\D2[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D2[1]~2_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \Decoder0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(1));

-- Location: LCCOMB_X7_Y6_N8
\U1|RAM~1feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|RAM~1feeder_combout\ = D2(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => D2(1),
	combout => \U1|RAM~1feeder_combout\);

-- Location: FF_X7_Y6_N9
\U1|RAM~1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|RAM~1feeder_combout\,
	ena => \U1|comb~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|RAM~1_q\);

-- Location: LCCOMB_X8_Y6_N16
\U1|D1[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[1]~feeder_combout\ = \U1|RAM~1_q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|RAM~1_q\,
	combout => \U1|D1[1]~feeder_combout\);

-- Location: FF_X8_Y6_N17
\U1|D1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[1]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(1));

-- Location: LCCOMB_X8_Y6_N18
\U1|D1[5]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[5]~feeder_combout\ = \U1|D1\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(1),
	combout => \U1|D1[5]~feeder_combout\);

-- Location: FF_X8_Y6_N19
\U1|D1[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[5]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(5));

-- Location: LCCOMB_X9_Y6_N14
\U2|U1|D1[1]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|D1[1]~1_combout\ = (\U2|U1|i\(0) & (\U1|D1\(1))) # (!\U2|U1|i\(0) & ((\U1|D1\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|D1\(1),
	datab => \U1|D1\(5),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|D1[1]~1_combout\);

-- Location: FF_X8_Y6_N1
\U1|D1[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \U1|D1\(5),
	clrn => \RESET~inputclkctrl_outclk\,
	sload => VCC,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(9));

-- Location: LCCOMB_X8_Y6_N2
\U1|D1[13]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[13]~feeder_combout\ = \U1|D1\(9)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(9),
	combout => \U1|D1[13]~feeder_combout\);

-- Location: FF_X8_Y6_N3
\U1|D1[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[13]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(13));

-- Location: LCCOMB_X8_Y6_N22
\U1|D1[17]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[17]~feeder_combout\ = \U1|D1\(13)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(13),
	combout => \U1|D1[17]~feeder_combout\);

-- Location: FF_X8_Y6_N23
\U1|D1[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[17]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(17));

-- Location: FF_X8_Y6_N21
\U1|D1[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \U1|D1\(17),
	clrn => \RESET~inputclkctrl_outclk\,
	sload => VCC,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(21));

-- Location: LCCOMB_X8_Y6_N20
\U2|U1|Mux19~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux19~0_combout\ = (\U2|U1|i\(1) & ((\U1|D1\(13)) # ((\U2|U1|i\(0))))) # (!\U2|U1|i\(1) & (((\U1|D1\(21) & !\U2|U1|i\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(1),
	datab => \U1|D1\(13),
	datac => \U1|D1\(21),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|Mux19~0_combout\);

-- Location: LCCOMB_X8_Y6_N0
\U2|U1|Mux19~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux19~1_combout\ = (\U2|U1|i\(0) & ((\U2|U1|Mux19~0_combout\ & ((\U1|D1\(9)))) # (!\U2|U1|Mux19~0_combout\ & (\U1|D1\(17))))) # (!\U2|U1|i\(0) & (((\U2|U1|Mux19~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|D1\(17),
	datab => \U2|U1|i\(0),
	datac => \U1|D1\(9),
	datad => \U2|U1|Mux19~0_combout\,
	combout => \U2|U1|Mux19~1_combout\);

-- Location: FF_X9_Y6_N15
\U2|U1|D1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|D1[1]~1_combout\,
	asdata => \U2|U1|Mux19~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	sload => \U2|U1|ALT_INV_i\(2),
	ena => \U2|U1|Mux26~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D1\(1));

-- Location: LCCOMB_X8_Y7_N30
\D2[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \D2[0]~0_combout\ = !\Mux2~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \Mux2~0_combout\,
	combout => \D2[0]~0_combout\);

-- Location: FF_X8_Y7_N31
\D2[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D2[0]~0_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \Decoder0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(0));

-- Location: FF_X7_Y6_N27
\U1|RAM~0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => D2(0),
	sload => VCC,
	ena => \U1|comb~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|RAM~0_q\);

-- Location: LCCOMB_X8_Y6_N12
\U1|D1[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[0]~feeder_combout\ = \U1|RAM~0_q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \U1|RAM~0_q\,
	combout => \U1|D1[0]~feeder_combout\);

-- Location: FF_X8_Y6_N13
\U1|D1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[0]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(0));

-- Location: LCCOMB_X8_Y6_N30
\U1|D1[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[4]~feeder_combout\ = \U1|D1\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(0),
	combout => \U1|D1[4]~feeder_combout\);

-- Location: FF_X8_Y6_N31
\U1|D1[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[4]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(4));

-- Location: LCCOMB_X9_Y6_N4
\U2|U1|D1[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|D1[0]~2_combout\ = (\U2|U1|i\(0) & (\U1|D1\(0))) # (!\U2|U1|i\(0) & ((\U1|D1\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|D1\(0),
	datab => \U1|D1\(4),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|D1[0]~2_combout\);

-- Location: FF_X8_Y6_N7
\U1|D1[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \U1|D1\(4),
	clrn => \RESET~inputclkctrl_outclk\,
	sload => VCC,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(8));

-- Location: LCCOMB_X7_Y6_N24
\U1|D1[12]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[12]~feeder_combout\ = \U1|D1\(8)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(8),
	combout => \U1|D1[12]~feeder_combout\);

-- Location: FF_X7_Y6_N25
\U1|D1[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[12]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(12));

-- Location: LCCOMB_X8_Y6_N8
\U1|D1[16]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[16]~feeder_combout\ = \U1|D1\(12)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(12),
	combout => \U1|D1[16]~feeder_combout\);

-- Location: FF_X8_Y6_N9
\U1|D1[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[16]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(16));

-- Location: FF_X8_Y6_N25
\U1|D1[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \U1|D1\(16),
	clrn => \RESET~inputclkctrl_outclk\,
	sload => VCC,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(20));

-- Location: LCCOMB_X8_Y6_N24
\U2|U1|Mux20~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux20~0_combout\ = (\U2|U1|i\(1) & (((\U2|U1|i\(0))))) # (!\U2|U1|i\(1) & ((\U2|U1|i\(0) & (\U1|D1\(16))) # (!\U2|U1|i\(0) & ((\U1|D1\(20))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(1),
	datab => \U1|D1\(16),
	datac => \U1|D1\(20),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|Mux20~0_combout\);

-- Location: LCCOMB_X8_Y6_N6
\U2|U1|Mux20~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux20~1_combout\ = (\U2|U1|i\(1) & ((\U2|U1|Mux20~0_combout\ & ((\U1|D1\(8)))) # (!\U2|U1|Mux20~0_combout\ & (\U1|D1\(12))))) # (!\U2|U1|i\(1) & (((\U2|U1|Mux20~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(1),
	datab => \U1|D1\(12),
	datac => \U1|D1\(8),
	datad => \U2|U1|Mux20~0_combout\,
	combout => \U2|U1|Mux20~1_combout\);

-- Location: FF_X9_Y6_N5
\U2|U1|D1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|D1[0]~2_combout\,
	asdata => \U2|U1|Mux20~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	sload => \U2|U1|ALT_INV_i\(2),
	ena => \U2|U1|Mux26~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D1\(0));

-- Location: LCCOMB_X8_Y7_N20
\Decoder0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Decoder0~1_combout\ = (!i(2)) # (!i(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => i(1),
	datad => i(2),
	combout => \Decoder0~1_combout\);

-- Location: FF_X8_Y7_N21
\D2[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \Decoder0~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \Decoder0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(3));

-- Location: LCCOMB_X7_Y6_N12
\U1|RAM~3feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|RAM~3feeder_combout\ = D2(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => D2(3),
	combout => \U1|RAM~3feeder_combout\);

-- Location: FF_X7_Y6_N13
\U1|RAM~3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|RAM~3feeder_combout\,
	ena => \U1|comb~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|RAM~3_q\);

-- Location: LCCOMB_X8_Y6_N28
\U1|D1[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[3]~feeder_combout\ = \U1|RAM~3_q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|RAM~3_q\,
	combout => \U1|D1[3]~feeder_combout\);

-- Location: FF_X8_Y6_N29
\U1|D1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[3]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(3));

-- Location: LCCOMB_X8_Y6_N14
\U1|D1[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[7]~feeder_combout\ = \U1|D1\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(3),
	combout => \U1|D1[7]~feeder_combout\);

-- Location: FF_X8_Y6_N15
\U1|D1[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[7]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(7));

-- Location: LCCOMB_X9_Y6_N26
\U2|U1|D1[3]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|D1[3]~3_combout\ = (\U2|U1|i\(0) & ((\U1|D1\(3)))) # (!\U2|U1|i\(0) & (\U1|D1\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|D1\(7),
	datab => \U1|D1\(3),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|D1[3]~3_combout\);

-- Location: FF_X8_Y6_N27
\U1|D1[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \U1|D1\(7),
	clrn => \RESET~inputclkctrl_outclk\,
	sload => VCC,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(11));

-- Location: LCCOMB_X7_Y6_N14
\U1|D1[15]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[15]~feeder_combout\ = \U1|D1\(11)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(11),
	combout => \U1|D1[15]~feeder_combout\);

-- Location: FF_X7_Y6_N15
\U1|D1[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[15]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(15));

-- Location: LCCOMB_X8_Y6_N4
\U1|D1[19]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \U1|D1[19]~feeder_combout\ = \U1|D1\(15)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \U1|D1\(15),
	combout => \U1|D1[19]~feeder_combout\);

-- Location: FF_X8_Y6_N5
\U1|D1[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U1|D1[19]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(19));

-- Location: FF_X8_Y6_N11
\U1|D1[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \U1|D1\(19),
	clrn => \RESET~inputclkctrl_outclk\,
	sload => VCC,
	ena => \isEn~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U1|D1\(23));

-- Location: LCCOMB_X8_Y6_N10
\U2|U1|Mux17~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux17~0_combout\ = (\U2|U1|i\(1) & (((\U2|U1|i\(0))))) # (!\U2|U1|i\(1) & ((\U2|U1|i\(0) & (\U1|D1\(19))) # (!\U2|U1|i\(0) & ((\U1|D1\(23))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(1),
	datab => \U1|D1\(19),
	datac => \U1|D1\(23),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|Mux17~0_combout\);

-- Location: LCCOMB_X8_Y6_N26
\U2|U1|Mux17~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux17~1_combout\ = (\U2|U1|i\(1) & ((\U2|U1|Mux17~0_combout\ & ((\U1|D1\(11)))) # (!\U2|U1|Mux17~0_combout\ & (\U1|D1\(15))))) # (!\U2|U1|i\(1) & (((\U2|U1|Mux17~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U1|D1\(15),
	datab => \U2|U1|i\(1),
	datac => \U1|D1\(11),
	datad => \U2|U1|Mux17~0_combout\,
	combout => \U2|U1|Mux17~1_combout\);

-- Location: FF_X9_Y6_N27
\U2|U1|D1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|D1[3]~3_combout\,
	asdata => \U2|U1|Mux17~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	sload => \U2|U1|ALT_INV_i\(2),
	ena => \U2|U1|Mux26~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D1\(3));

-- Location: LCCOMB_X17_Y2_N20
\U2|U2|oData[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U2|oData[0]~0_combout\ = (\U2|U1|D1\(2) & (!\U2|U1|D1\(1) & (\U2|U1|D1\(0) $ (!\U2|U1|D1\(3))))) # (!\U2|U1|D1\(2) & (\U2|U1|D1\(0) & (\U2|U1|D1\(1) $ (!\U2|U1|D1\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000000010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D1\(2),
	datab => \U2|U1|D1\(1),
	datac => \U2|U1|D1\(0),
	datad => \U2|U1|D1\(3),
	combout => \U2|U2|oData[0]~0_combout\);

-- Location: LCCOMB_X17_Y2_N26
\U2|U2|oData[1]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U2|oData[1]~1_combout\ = (\U2|U1|D1\(1) & ((\U2|U1|D1\(0) & ((\U2|U1|D1\(3)))) # (!\U2|U1|D1\(0) & (\U2|U1|D1\(2))))) # (!\U2|U1|D1\(1) & (\U2|U1|D1\(2) & (\U2|U1|D1\(0) $ (\U2|U1|D1\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D1\(2),
	datab => \U2|U1|D1\(1),
	datac => \U2|U1|D1\(0),
	datad => \U2|U1|D1\(3),
	combout => \U2|U2|oData[1]~1_combout\);

-- Location: LCCOMB_X17_Y2_N0
\U2|U2|oData[2]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U2|oData[2]~2_combout\ = (\U2|U1|D1\(2) & (\U2|U1|D1\(3) & ((\U2|U1|D1\(1)) # (!\U2|U1|D1\(0))))) # (!\U2|U1|D1\(2) & (\U2|U1|D1\(1) & (!\U2|U1|D1\(0) & !\U2|U1|D1\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D1\(2),
	datab => \U2|U1|D1\(1),
	datac => \U2|U1|D1\(0),
	datad => \U2|U1|D1\(3),
	combout => \U2|U2|oData[2]~2_combout\);

-- Location: LCCOMB_X17_Y2_N6
\U2|U2|oData[3]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U2|oData[3]~3_combout\ = (\U2|U1|D1\(1) & ((\U2|U1|D1\(2) & (\U2|U1|D1\(0))) # (!\U2|U1|D1\(2) & (!\U2|U1|D1\(0) & \U2|U1|D1\(3))))) # (!\U2|U1|D1\(1) & (!\U2|U1|D1\(3) & (\U2|U1|D1\(2) $ (\U2|U1|D1\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010010010010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D1\(2),
	datab => \U2|U1|D1\(1),
	datac => \U2|U1|D1\(0),
	datad => \U2|U1|D1\(3),
	combout => \U2|U2|oData[3]~3_combout\);

-- Location: LCCOMB_X17_Y2_N12
\U2|U2|oData[4]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U2|oData[4]~4_combout\ = (\U2|U1|D1\(1) & (((\U2|U1|D1\(0) & !\U2|U1|D1\(3))))) # (!\U2|U1|D1\(1) & ((\U2|U1|D1\(2) & ((!\U2|U1|D1\(3)))) # (!\U2|U1|D1\(2) & (\U2|U1|D1\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000011110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D1\(2),
	datab => \U2|U1|D1\(1),
	datac => \U2|U1|D1\(0),
	datad => \U2|U1|D1\(3),
	combout => \U2|U2|oData[4]~4_combout\);

-- Location: LCCOMB_X17_Y2_N30
\U2|U2|oData[5]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U2|oData[5]~5_combout\ = (\U2|U1|D1\(2) & (\U2|U1|D1\(0) & (\U2|U1|D1\(1) $ (\U2|U1|D1\(3))))) # (!\U2|U1|D1\(2) & (!\U2|U1|D1\(3) & ((\U2|U1|D1\(1)) # (\U2|U1|D1\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000011010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D1\(2),
	datab => \U2|U1|D1\(1),
	datac => \U2|U1|D1\(0),
	datad => \U2|U1|D1\(3),
	combout => \U2|U2|oData[5]~5_combout\);

-- Location: LCCOMB_X17_Y2_N24
\U2|U2|oData[6]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U2|oData[6]~6_combout\ = (\U2|U1|D1\(0) & ((\U2|U1|D1\(3)) # (\U2|U1|D1\(2) $ (\U2|U1|D1\(1))))) # (!\U2|U1|D1\(0) & ((\U2|U1|D1\(1)) # (\U2|U1|D1\(2) $ (\U2|U1|D1\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110101101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D1\(2),
	datab => \U2|U1|D1\(1),
	datac => \U2|U1|D1\(0),
	datad => \U2|U1|D1\(3),
	combout => \U2|U2|oData[6]~6_combout\);

-- Location: LCCOMB_X9_Y6_N16
\U2|U1|Mux26~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux26~3_combout\ = (\U2|U1|i\(2)) # ((\U2|U1|i\(1)) # (\U2|U1|i\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(2),
	datac => \U2|U1|i\(1),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|Mux26~3_combout\);

-- Location: LCCOMB_X9_Y6_N10
\U2|U1|Mux26~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux26~5_combout\ = (\U2|U1|D2\(0) & (\U2|U1|Equal0~3_combout\ & ((!\U2|U1|i\(1)) # (!\U2|U1|i\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D2\(0),
	datab => \U2|U1|i\(2),
	datac => \U2|U1|i\(1),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux26~5_combout\);

-- Location: LCCOMB_X9_Y6_N12
\U2|U1|Mux26~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux26~4_combout\ = (\U2|U1|Mux26~5_combout\) # ((\U2|U1|Mux26~3_combout\ & \U2|U1|Mux26~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|Mux26~3_combout\,
	datac => \U2|U1|Mux26~2_combout\,
	datad => \U2|U1|Mux26~5_combout\,
	combout => \U2|U1|Mux26~4_combout\);

-- Location: FF_X9_Y6_N13
\U2|U1|D2[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux26~4_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D2\(0));

-- Location: LCCOMB_X9_Y6_N18
\U2|U1|Mux25~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux25~2_combout\ = (!\U2|U1|i\(2) & (!\U2|U1|i\(1) & \U2|U1|i\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(2),
	datac => \U2|U1|i\(1),
	datad => \U2|U1|i\(0),
	combout => \U2|U1|Mux25~2_combout\);

-- Location: LCCOMB_X9_Y6_N20
\U2|U1|Mux25~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux25~4_combout\ = (!\U2|U1|D2\(1) & (\U2|U1|Equal0~3_combout\ & ((!\U2|U1|i\(1)) # (!\U2|U1|i\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D2\(1),
	datab => \U2|U1|i\(2),
	datac => \U2|U1|i\(1),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux25~4_combout\);

-- Location: LCCOMB_X9_Y6_N30
\U2|U1|Mux25~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux25~3_combout\ = (!\U2|U1|Mux25~4_combout\ & ((\U2|U1|Mux25~2_combout\) # (!\U2|U1|Mux26~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \U2|U1|Mux25~2_combout\,
	datac => \U2|U1|Mux26~2_combout\,
	datad => \U2|U1|Mux25~4_combout\,
	combout => \U2|U1|Mux25~3_combout\);

-- Location: FF_X9_Y6_N31
\U2|U1|D2[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux25~3_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D2\(1));

-- Location: LCCOMB_X11_Y6_N10
\U2|U1|Mux24~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux24~0_combout\ = (!\U2|U1|i\(2) & ((\U2|U1|Equal0~3_combout\ & ((!\U2|U1|D2\(2)))) # (!\U2|U1|Equal0~3_combout\ & (\U2|U1|i\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(0),
	datab => \U2|U1|D2\(2),
	datac => \U2|U1|i\(2),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux24~0_combout\);

-- Location: LCCOMB_X11_Y6_N28
\U2|U1|Mux24~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux24~1_combout\ = (!\U2|U1|Mux24~0_combout\ & ((\U2|U1|i\(1)) # ((\U2|U1|Equal0~3_combout\ & \U2|U1|D2\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~3_combout\,
	datab => \U2|U1|i\(1),
	datac => \U2|U1|D2\(2),
	datad => \U2|U1|Mux24~0_combout\,
	combout => \U2|U1|Mux24~1_combout\);

-- Location: FF_X11_Y6_N29
\U2|U1|D2[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux24~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D2\(2));

-- Location: LCCOMB_X11_Y6_N24
\U2|U1|Mux23~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux23~0_combout\ = (!\U2|U1|i\(2) & ((\U2|U1|Equal0~3_combout\ & ((!\U2|U1|D2\(3)))) # (!\U2|U1|Equal0~3_combout\ & (!\U2|U1|i\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(0),
	datab => \U2|U1|i\(2),
	datac => \U2|U1|D2\(3),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux23~0_combout\);

-- Location: LCCOMB_X11_Y6_N18
\U2|U1|Mux23~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux23~1_combout\ = (!\U2|U1|Mux23~0_combout\ & ((\U2|U1|i\(1)) # ((\U2|U1|Equal0~3_combout\ & \U2|U1|D2\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~3_combout\,
	datab => \U2|U1|i\(1),
	datac => \U2|U1|D2\(3),
	datad => \U2|U1|Mux23~0_combout\,
	combout => \U2|U1|Mux23~1_combout\);

-- Location: FF_X11_Y6_N19
\U2|U1|D2[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux23~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D2\(3));

-- Location: LCCOMB_X11_Y6_N22
\U2|U1|Mux22~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux22~0_combout\ = (\U2|U1|Equal0~3_combout\ & (!\U2|U1|D2\(4) & ((!\U2|U1|i\(2)) # (!\U2|U1|i\(1))))) # (!\U2|U1|Equal0~3_combout\ & (((!\U2|U1|i\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|D2\(4),
	datab => \U2|U1|i\(1),
	datac => \U2|U1|i\(2),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux22~0_combout\);

-- Location: LCCOMB_X11_Y6_N12
\U2|U1|Mux22~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux22~1_combout\ = (!\U2|U1|Mux22~0_combout\ & (((\U2|U1|i\(1)) # (\U2|U1|Equal0~3_combout\)) # (!\U2|U1|i\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(0),
	datab => \U2|U1|i\(1),
	datac => \U2|U1|Mux22~0_combout\,
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux22~1_combout\);

-- Location: FF_X11_Y6_N13
\U2|U1|D2[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux22~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D2\(4));

-- Location: LCCOMB_X9_Y6_N24
\U2|U1|Mux21~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux21~0_combout\ = (\U2|U1|Equal0~3_combout\ & (!\U2|U1|D2\(5) & ((!\U2|U1|i\(2)) # (!\U2|U1|i\(1))))) # (!\U2|U1|Equal0~3_combout\ & (((!\U2|U1|i\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|i\(1),
	datab => \U2|U1|D2\(5),
	datac => \U2|U1|i\(2),
	datad => \U2|U1|Equal0~3_combout\,
	combout => \U2|U1|Mux21~0_combout\);

-- Location: LCCOMB_X9_Y6_N28
\U2|U1|Mux21~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \U2|U1|Mux21~1_combout\ = (!\U2|U1|Mux21~0_combout\ & ((\U2|U1|Equal0~3_combout\) # ((\U2|U1|i\(0)) # (\U2|U1|i\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \U2|U1|Equal0~3_combout\,
	datab => \U2|U1|i\(0),
	datac => \U2|U1|i\(1),
	datad => \U2|U1|Mux21~0_combout\,
	combout => \U2|U1|Mux21~1_combout\);

-- Location: FF_X9_Y6_N29
\U2|U1|D2[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \U2|U1|Mux21~1_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \U2|U1|D1[2]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \U2|U1|D2\(5));

ww_DIG(0) <= \DIG[0]~output_o\;

ww_DIG(1) <= \DIG[1]~output_o\;

ww_DIG(2) <= \DIG[2]~output_o\;

ww_DIG(3) <= \DIG[3]~output_o\;

ww_DIG(4) <= \DIG[4]~output_o\;

ww_DIG(5) <= \DIG[5]~output_o\;

ww_DIG(6) <= \DIG[6]~output_o\;

ww_DIG(7) <= \DIG[7]~output_o\;

ww_SEL(0) <= \SEL[0]~output_o\;

ww_SEL(1) <= \SEL[1]~output_o\;

ww_SEL(2) <= \SEL[2]~output_o\;

ww_SEL(3) <= \SEL[3]~output_o\;

ww_SEL(4) <= \SEL[4]~output_o\;

ww_SEL(5) <= \SEL[5]~output_o\;
END structure;


