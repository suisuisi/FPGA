-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 32-bit"
-- VERSION "Version 12.1 Build 177 11/07/2012 SJ Full Version"

-- DATE "10/04/2013 12:39:15"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	pushshift_savemod IS
    PORT (
	CLOCK : IN std_logic;
	RESET : IN std_logic;
	iEn : IN std_logic;
	iAddr : IN std_logic_vector(3 DOWNTO 0);
	iData : IN std_logic_vector(3 DOWNTO 0);
	oData : OUT std_logic_vector(3 DOWNTO 0)
	);
END pushshift_savemod;

-- Design Ports Information
-- oData[0]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- oData[1]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- oData[2]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- oData[3]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLOCK	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RESET	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iEn	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iAddr[1]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iAddr[0]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iAddr[3]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iAddr[2]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[0]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[1]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[2]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- iData[3]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF pushshift_savemod IS
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
SIGNAL ww_iEn : std_logic;
SIGNAL ww_iAddr : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_iData : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_oData : std_logic_vector(3 DOWNTO 0);
SIGNAL \RESET~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \CLOCK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \RAM~57_q\ : std_logic;
SIGNAL \RAM~6_q\ : std_logic;
SIGNAL \RAM~23_q\ : std_logic;
SIGNAL \RAM~51_q\ : std_logic;
SIGNAL \RAM~31_q\ : std_logic;
SIGNAL \RAM~108_combout\ : std_logic;
SIGNAL \RAM~110_combout\ : std_logic;
SIGNAL \RAM~122_combout\ : std_logic;
SIGNAL \RAM~124_combout\ : std_logic;
SIGNAL \RAM~126_combout\ : std_logic;
SIGNAL \RAM~57feeder_combout\ : std_logic;
SIGNAL \RAM~6feeder_combout\ : std_logic;
SIGNAL \RAM~51feeder_combout\ : std_logic;
SIGNAL \RAM~23feeder_combout\ : std_logic;
SIGNAL \oData[0]~output_o\ : std_logic;
SIGNAL \oData[1]~output_o\ : std_logic;
SIGNAL \oData[2]~output_o\ : std_logic;
SIGNAL \oData[3]~output_o\ : std_logic;
SIGNAL \CLOCK~input_o\ : std_logic;
SIGNAL \CLOCK~inputclkctrl_outclk\ : std_logic;
SIGNAL \iData[0]~input_o\ : std_logic;
SIGNAL \RAM~44feeder_combout\ : std_logic;
SIGNAL \RESET~input_o\ : std_logic;
SIGNAL \iEn~input_o\ : std_logic;
SIGNAL \RAM~111_combout\ : std_logic;
SIGNAL \RAM~44_q\ : std_logic;
SIGNAL \iAddr[2]~input_o\ : std_logic;
SIGNAL \iAddr[3]~input_o\ : std_logic;
SIGNAL \iAddr[0]~input_o\ : std_logic;
SIGNAL \RAM~104_combout\ : std_logic;
SIGNAL \RAM~105_combout\ : std_logic;
SIGNAL \RAM~40_q\ : std_logic;
SIGNAL \RAM~109_combout\ : std_logic;
SIGNAL \RAM~32_q\ : std_logic;
SIGNAL \RAM~36feeder_combout\ : std_logic;
SIGNAL \RAM~106_combout\ : std_logic;
SIGNAL \RAM~107_combout\ : std_logic;
SIGNAL \RAM~36_q\ : std_logic;
SIGNAL \RAM~64_combout\ : std_logic;
SIGNAL \RAM~65_combout\ : std_logic;
SIGNAL \RAM~52feeder_combout\ : std_logic;
SIGNAL \RAM~128_combout\ : std_logic;
SIGNAL \RAM~129_combout\ : std_logic;
SIGNAL \RAM~52_q\ : std_logic;
SIGNAL \RAM~134_combout\ : std_logic;
SIGNAL \RAM~135_combout\ : std_logic;
SIGNAL \RAM~60_q\ : std_logic;
SIGNAL \iAddr[1]~input_o\ : std_logic;
SIGNAL \RAM~132_combout\ : std_logic;
SIGNAL \RAM~133_combout\ : std_logic;
SIGNAL \RAM~48_q\ : std_logic;
SIGNAL \RAM~130_combout\ : std_logic;
SIGNAL \RAM~131_combout\ : std_logic;
SIGNAL \RAM~56_q\ : std_logic;
SIGNAL \RAM~71_combout\ : std_logic;
SIGNAL \RAM~72_combout\ : std_logic;
SIGNAL \RAM~120_combout\ : std_logic;
SIGNAL \RAM~121_combout\ : std_logic;
SIGNAL \RAM~8_q\ : std_logic;
SIGNAL \RAM~127_combout\ : std_logic;
SIGNAL \RAM~12_q\ : std_logic;
SIGNAL \RAM~123_combout\ : std_logic;
SIGNAL \RAM~4_q\ : std_logic;
SIGNAL \RAM~125_combout\ : std_logic;
SIGNAL \RAM~0_q\ : std_logic;
SIGNAL \RAM~68_combout\ : std_logic;
SIGNAL \RAM~69_combout\ : std_logic;
SIGNAL \RAM~20feeder_combout\ : std_logic;
SIGNAL \RAM~112_combout\ : std_logic;
SIGNAL \RAM~113_combout\ : std_logic;
SIGNAL \RAM~20_q\ : std_logic;
SIGNAL \RAM~118_combout\ : std_logic;
SIGNAL \RAM~119_combout\ : std_logic;
SIGNAL \RAM~28_q\ : std_logic;
SIGNAL \RAM~116_combout\ : std_logic;
SIGNAL \RAM~117_combout\ : std_logic;
SIGNAL \RAM~16_q\ : std_logic;
SIGNAL \RAM~114_combout\ : std_logic;
SIGNAL \RAM~115_combout\ : std_logic;
SIGNAL \RAM~24_q\ : std_logic;
SIGNAL \RAM~66_combout\ : std_logic;
SIGNAL \RAM~67_combout\ : std_logic;
SIGNAL \RAM~70_combout\ : std_logic;
SIGNAL \RAM~73_combout\ : std_logic;
SIGNAL \RESET~inputclkctrl_outclk\ : std_logic;
SIGNAL \D2[0]~feeder_combout\ : std_logic;
SIGNAL \D3[0]~feeder_combout\ : std_logic;
SIGNAL \iData[1]~input_o\ : std_logic;
SIGNAL \RAM~25_q\ : std_logic;
SIGNAL \RAM~41_q\ : std_logic;
SIGNAL \RAM~9_q\ : std_logic;
SIGNAL \RAM~74_combout\ : std_logic;
SIGNAL \RAM~75_combout\ : std_logic;
SIGNAL \RAM~37_q\ : std_logic;
SIGNAL \RAM~53_q\ : std_logic;
SIGNAL \RAM~5_q\ : std_logic;
SIGNAL \RAM~21_q\ : std_logic;
SIGNAL \RAM~76_combout\ : std_logic;
SIGNAL \RAM~77_combout\ : std_logic;
SIGNAL \RAM~17feeder_combout\ : std_logic;
SIGNAL \RAM~17_q\ : std_logic;
SIGNAL \RAM~49_q\ : std_logic;
SIGNAL \RAM~1_q\ : std_logic;
SIGNAL \RAM~33feeder_combout\ : std_logic;
SIGNAL \RAM~33_q\ : std_logic;
SIGNAL \RAM~78_combout\ : std_logic;
SIGNAL \RAM~79_combout\ : std_logic;
SIGNAL \RAM~80_combout\ : std_logic;
SIGNAL \RAM~45feeder_combout\ : std_logic;
SIGNAL \RAM~45_q\ : std_logic;
SIGNAL \RAM~61_q\ : std_logic;
SIGNAL \RAM~13_q\ : std_logic;
SIGNAL \RAM~29feeder_combout\ : std_logic;
SIGNAL \RAM~29_q\ : std_logic;
SIGNAL \RAM~81_combout\ : std_logic;
SIGNAL \RAM~82_combout\ : std_logic;
SIGNAL \RAM~83_combout\ : std_logic;
SIGNAL \D2[1]~feeder_combout\ : std_logic;
SIGNAL \D3[1]~feeder_combout\ : std_logic;
SIGNAL \iData[2]~input_o\ : std_logic;
SIGNAL \RAM~58feeder_combout\ : std_logic;
SIGNAL \RAM~58_q\ : std_logic;
SIGNAL \RAM~62_q\ : std_logic;
SIGNAL \RAM~50_q\ : std_logic;
SIGNAL \RAM~54_q\ : std_logic;
SIGNAL \RAM~91_combout\ : std_logic;
SIGNAL \RAM~92_combout\ : std_logic;
SIGNAL \RAM~14_q\ : std_logic;
SIGNAL \RAM~2_q\ : std_logic;
SIGNAL \RAM~10feeder_combout\ : std_logic;
SIGNAL \RAM~10_q\ : std_logic;
SIGNAL \RAM~88_combout\ : std_logic;
SIGNAL \RAM~89_combout\ : std_logic;
SIGNAL \RAM~38_q\ : std_logic;
SIGNAL \RAM~46_q\ : std_logic;
SIGNAL \RAM~34_q\ : std_logic;
SIGNAL \RAM~42feeder_combout\ : std_logic;
SIGNAL \RAM~42_q\ : std_logic;
SIGNAL \RAM~86_combout\ : std_logic;
SIGNAL \RAM~87_combout\ : std_logic;
SIGNAL \RAM~90_combout\ : std_logic;
SIGNAL \RAM~18_q\ : std_logic;
SIGNAL \RAM~22_q\ : std_logic;
SIGNAL \RAM~84_combout\ : std_logic;
SIGNAL \RAM~30_q\ : std_logic;
SIGNAL \RAM~26feeder_combout\ : std_logic;
SIGNAL \RAM~26_q\ : std_logic;
SIGNAL \RAM~85_combout\ : std_logic;
SIGNAL \RAM~93_combout\ : std_logic;
SIGNAL \D2[2]~feeder_combout\ : std_logic;
SIGNAL \D3[2]~feeder_combout\ : std_logic;
SIGNAL \iData[3]~input_o\ : std_logic;
SIGNAL \RAM~63_q\ : std_logic;
SIGNAL \RAM~47_q\ : std_logic;
SIGNAL \RAM~15feeder_combout\ : std_logic;
SIGNAL \RAM~15_q\ : std_logic;
SIGNAL \RAM~101_combout\ : std_logic;
SIGNAL \RAM~102_combout\ : std_logic;
SIGNAL \RAM~55_q\ : std_logic;
SIGNAL \RAM~7_q\ : std_logic;
SIGNAL \RAM~39feeder_combout\ : std_logic;
SIGNAL \RAM~39_q\ : std_logic;
SIGNAL \RAM~94_combout\ : std_logic;
SIGNAL \RAM~95_combout\ : std_logic;
SIGNAL \RAM~35feeder_combout\ : std_logic;
SIGNAL \RAM~35_q\ : std_logic;
SIGNAL \RAM~3_q\ : std_logic;
SIGNAL \RAM~19_q\ : std_logic;
SIGNAL \RAM~98_combout\ : std_logic;
SIGNAL \RAM~99_combout\ : std_logic;
SIGNAL \RAM~43feeder_combout\ : std_logic;
SIGNAL \RAM~43_q\ : std_logic;
SIGNAL \RAM~59feeder_combout\ : std_logic;
SIGNAL \RAM~59_q\ : std_logic;
SIGNAL \RAM~11_q\ : std_logic;
SIGNAL \RAM~27feeder_combout\ : std_logic;
SIGNAL \RAM~27_q\ : std_logic;
SIGNAL \RAM~96_combout\ : std_logic;
SIGNAL \RAM~97_combout\ : std_logic;
SIGNAL \RAM~100_combout\ : std_logic;
SIGNAL \RAM~103_combout\ : std_logic;
SIGNAL \D2[3]~feeder_combout\ : std_logic;
SIGNAL \D3[3]~feeder_combout\ : std_logic;
SIGNAL D3 : std_logic_vector(3 DOWNTO 0);
SIGNAL D2 : std_logic_vector(3 DOWNTO 0);
SIGNAL D1 : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_CLOCK <= CLOCK;
ww_RESET <= RESET;
ww_iEn <= iEn;
ww_iAddr <= iAddr;
ww_iData <= iData;
oData <= ww_oData;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\RESET~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \RESET~input_o\);

\CLOCK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLOCK~input_o\);

-- Location: FF_X31_Y25_N13
\RAM~57\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~57feeder_combout\,
	ena => \RAM~131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~57_q\);

-- Location: FF_X27_Y26_N9
\RAM~6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~6feeder_combout\,
	ena => \RAM~123_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~6_q\);

-- Location: FF_X30_Y24_N17
\RAM~23\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~23feeder_combout\,
	ena => \RAM~113_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~23_q\);

-- Location: FF_X32_Y26_N11
\RAM~51\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~51feeder_combout\,
	ena => \RAM~133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~51_q\);

-- Location: FF_X30_Y25_N5
\RAM~31\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~119_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~31_q\);

-- Location: LCCOMB_X29_Y25_N12
\RAM~108\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~108_combout\ = (!\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & (\iAddr[3]~input_o\ & !\iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~108_combout\);

-- Location: LCCOMB_X29_Y25_N2
\RAM~110\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~110_combout\ = (\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & (\iAddr[3]~input_o\ & \iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~110_combout\);

-- Location: LCCOMB_X29_Y26_N22
\RAM~122\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~122_combout\ = (!\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & (!\iAddr[3]~input_o\ & \iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~122_combout\);

-- Location: LCCOMB_X29_Y25_N16
\RAM~124\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~124_combout\ = (!\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & (!\iAddr[3]~input_o\ & !\iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~124_combout\);

-- Location: LCCOMB_X29_Y26_N10
\RAM~126\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~126_combout\ = (\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & (!\iAddr[3]~input_o\ & \iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~126_combout\);

-- Location: LCCOMB_X31_Y25_N12
\RAM~57feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~57feeder_combout\ = \iData[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[1]~input_o\,
	combout => \RAM~57feeder_combout\);

-- Location: LCCOMB_X27_Y26_N8
\RAM~6feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~6feeder_combout\ = \iData[2]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[2]~input_o\,
	combout => \RAM~6feeder_combout\);

-- Location: LCCOMB_X32_Y26_N10
\RAM~51feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~51feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~51feeder_combout\);

-- Location: LCCOMB_X30_Y24_N16
\RAM~23feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~23feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~23feeder_combout\);

-- Location: IOOBUF_X29_Y31_N2
\oData[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => D3(0),
	devoe => ww_devoe,
	o => \oData[0]~output_o\);

-- Location: IOOBUF_X33_Y24_N2
\oData[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => D3(1),
	devoe => ww_devoe,
	o => \oData[1]~output_o\);

-- Location: IOOBUF_X31_Y31_N9
\oData[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => D3(2),
	devoe => ww_devoe,
	o => \oData[2]~output_o\);

-- Location: IOOBUF_X29_Y31_N9
\oData[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => D3(3),
	devoe => ww_devoe,
	o => \oData[3]~output_o\);

-- Location: IOIBUF_X16_Y0_N15
\CLOCK~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK,
	o => \CLOCK~input_o\);

-- Location: CLKCTRL_G17
\CLOCK~inputclkctrl\ : cycloneiv_clkctrl
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

-- Location: IOIBUF_X33_Y28_N8
\iData[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(0),
	o => \iData[0]~input_o\);

-- Location: LCCOMB_X30_Y27_N26
\RAM~44feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~44feeder_combout\ = \iData[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[0]~input_o\,
	combout => \RAM~44feeder_combout\);

-- Location: IOIBUF_X16_Y0_N22
\RESET~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_RESET,
	o => \RESET~input_o\);

-- Location: IOIBUF_X33_Y22_N1
\iEn~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iEn,
	o => \iEn~input_o\);

-- Location: LCCOMB_X30_Y25_N20
\RAM~111\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~111_combout\ = (\RAM~110_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~110_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~111_combout\);

-- Location: FF_X30_Y27_N27
\RAM~44\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~44feeder_combout\,
	ena => \RAM~111_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~44_q\);

-- Location: IOIBUF_X31_Y31_N1
\iAddr[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iAddr(2),
	o => \iAddr[2]~input_o\);

-- Location: IOIBUF_X33_Y25_N1
\iAddr[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iAddr(3),
	o => \iAddr[3]~input_o\);

-- Location: IOIBUF_X33_Y27_N8
\iAddr[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iAddr(0),
	o => \iAddr[0]~input_o\);

-- Location: LCCOMB_X29_Y25_N20
\RAM~104\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~104_combout\ = (\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & (\iAddr[3]~input_o\ & !\iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~104_combout\);

-- Location: LCCOMB_X29_Y25_N6
\RAM~105\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~105_combout\ = (\RAM~104_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~104_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~105_combout\);

-- Location: FF_X29_Y27_N17
\RAM~40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~105_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~40_q\);

-- Location: LCCOMB_X30_Y25_N18
\RAM~109\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~109_combout\ = (\RAM~108_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~108_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~109_combout\);

-- Location: FF_X29_Y27_N3
\RAM~32\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~109_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~32_q\);

-- Location: LCCOMB_X30_Y27_N28
\RAM~36feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~36feeder_combout\ = \iData[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[0]~input_o\,
	combout => \RAM~36feeder_combout\);

-- Location: LCCOMB_X29_Y25_N8
\RAM~106\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~106_combout\ = (!\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & (\iAddr[3]~input_o\ & \iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~106_combout\);

-- Location: LCCOMB_X29_Y25_N22
\RAM~107\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~107_combout\ = (\RAM~106_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~106_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~107_combout\);

-- Location: FF_X30_Y27_N29
\RAM~36\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~36feeder_combout\,
	ena => \RAM~107_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~36_q\);

-- Location: LCCOMB_X29_Y27_N2
\RAM~64\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~64_combout\ = (\iAddr[1]~input_o\ & (\iAddr[0]~input_o\)) # (!\iAddr[1]~input_o\ & ((\iAddr[0]~input_o\ & ((\RAM~36_q\))) # (!\iAddr[0]~input_o\ & (\RAM~32_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[0]~input_o\,
	datac => \RAM~32_q\,
	datad => \RAM~36_q\,
	combout => \RAM~64_combout\);

-- Location: LCCOMB_X29_Y27_N16
\RAM~65\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~65_combout\ = (\iAddr[1]~input_o\ & ((\RAM~64_combout\ & (\RAM~44_q\)) # (!\RAM~64_combout\ & ((\RAM~40_q\))))) # (!\iAddr[1]~input_o\ & (((\RAM~64_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \RAM~44_q\,
	datac => \RAM~40_q\,
	datad => \RAM~64_combout\,
	combout => \RAM~65_combout\);

-- Location: LCCOMB_X29_Y25_N26
\RAM~52feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~52feeder_combout\ = \iData[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[0]~input_o\,
	combout => \RAM~52feeder_combout\);

-- Location: LCCOMB_X29_Y25_N14
\RAM~128\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~128_combout\ = (!\iAddr[1]~input_o\ & (\iAddr[2]~input_o\ & (\iAddr[3]~input_o\ & \iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~128_combout\);

-- Location: LCCOMB_X29_Y25_N24
\RAM~129\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~129_combout\ = (\RAM~128_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~128_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~129_combout\);

-- Location: FF_X29_Y25_N27
\RAM~52\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~52feeder_combout\,
	ena => \RAM~129_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~52_q\);

-- Location: LCCOMB_X29_Y25_N0
\RAM~134\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~134_combout\ = (\iAddr[1]~input_o\ & (\iAddr[2]~input_o\ & (\iAddr[3]~input_o\ & \iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~134_combout\);

-- Location: LCCOMB_X29_Y25_N10
\RAM~135\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~135_combout\ = (\RAM~134_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~134_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~135_combout\);

-- Location: FF_X30_Y26_N21
\RAM~60\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~135_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~60_q\);

-- Location: IOIBUF_X33_Y25_N8
\iAddr[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iAddr(1),
	o => \iAddr[1]~input_o\);

-- Location: LCCOMB_X32_Y26_N24
\RAM~132\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~132_combout\ = (!\iAddr[0]~input_o\ & (!\iAddr[1]~input_o\ & (\iAddr[2]~input_o\ & \iAddr[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \iAddr[2]~input_o\,
	datad => \iAddr[3]~input_o\,
	combout => \RAM~132_combout\);

-- Location: LCCOMB_X32_Y26_N22
\RAM~133\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~133_combout\ = (\RAM~132_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~132_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~133_combout\);

-- Location: FF_X32_Y26_N13
\RAM~48\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~48_q\);

-- Location: LCCOMB_X29_Y25_N18
\RAM~130\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~130_combout\ = (\iAddr[1]~input_o\ & (\iAddr[2]~input_o\ & (\iAddr[3]~input_o\ & !\iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~130_combout\);

-- Location: LCCOMB_X30_Y25_N16
\RAM~131\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~131_combout\ = (\RAM~130_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~130_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~131_combout\);

-- Location: FF_X31_Y25_N11
\RAM~56\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~56_q\);

-- Location: LCCOMB_X32_Y26_N12
\RAM~71\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~71_combout\ = (\iAddr[0]~input_o\ & (\iAddr[1]~input_o\)) # (!\iAddr[0]~input_o\ & ((\iAddr[1]~input_o\ & ((\RAM~56_q\))) # (!\iAddr[1]~input_o\ & (\RAM~48_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \RAM~48_q\,
	datad => \RAM~56_q\,
	combout => \RAM~71_combout\);

-- Location: LCCOMB_X30_Y26_N20
\RAM~72\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~72_combout\ = (\iAddr[0]~input_o\ & ((\RAM~71_combout\ & ((\RAM~60_q\))) # (!\RAM~71_combout\ & (\RAM~52_q\)))) # (!\iAddr[0]~input_o\ & (((\RAM~71_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \RAM~52_q\,
	datac => \RAM~60_q\,
	datad => \RAM~71_combout\,
	combout => \RAM~72_combout\);

-- Location: LCCOMB_X32_Y26_N16
\RAM~120\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~120_combout\ = (!\iAddr[0]~input_o\ & (\iAddr[1]~input_o\ & (!\iAddr[2]~input_o\ & !\iAddr[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \iAddr[2]~input_o\,
	datad => \iAddr[3]~input_o\,
	combout => \RAM~120_combout\);

-- Location: LCCOMB_X32_Y26_N6
\RAM~121\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~121_combout\ = (\RAM~120_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~120_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~121_combout\);

-- Location: FF_X31_Y26_N5
\RAM~8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~121_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~8_q\);

-- Location: LCCOMB_X29_Y26_N12
\RAM~127\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~127_combout\ = (\RAM~126_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~126_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~127_combout\);

-- Location: FF_X29_Y26_N27
\RAM~12\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~127_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~12_q\);

-- Location: LCCOMB_X29_Y26_N4
\RAM~123\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~123_combout\ = (\RAM~122_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~122_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~123_combout\);

-- Location: FF_X27_Y26_N17
\RAM~4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~123_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~4_q\);

-- Location: LCCOMB_X30_Y25_N22
\RAM~125\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~125_combout\ = (\RAM~124_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~124_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~125_combout\);

-- Location: FF_X27_Y26_N3
\RAM~0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~125_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~0_q\);

-- Location: LCCOMB_X27_Y26_N16
\RAM~68\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~68_combout\ = (\iAddr[1]~input_o\ & (\iAddr[0]~input_o\)) # (!\iAddr[1]~input_o\ & ((\iAddr[0]~input_o\ & (\RAM~4_q\)) # (!\iAddr[0]~input_o\ & ((\RAM~0_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[0]~input_o\,
	datac => \RAM~4_q\,
	datad => \RAM~0_q\,
	combout => \RAM~68_combout\);

-- Location: LCCOMB_X29_Y26_N26
\RAM~69\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~69_combout\ = (\iAddr[1]~input_o\ & ((\RAM~68_combout\ & ((\RAM~12_q\))) # (!\RAM~68_combout\ & (\RAM~8_q\)))) # (!\iAddr[1]~input_o\ & (((\RAM~68_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \RAM~8_q\,
	datac => \RAM~12_q\,
	datad => \RAM~68_combout\,
	combout => \RAM~69_combout\);

-- Location: LCCOMB_X29_Y25_N28
\RAM~20feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~20feeder_combout\ = \iData[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[0]~input_o\,
	combout => \RAM~20feeder_combout\);

-- Location: LCCOMB_X29_Y25_N4
\RAM~112\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~112_combout\ = (!\iAddr[1]~input_o\ & (\iAddr[2]~input_o\ & (!\iAddr[3]~input_o\ & \iAddr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \iAddr[3]~input_o\,
	datad => \iAddr[0]~input_o\,
	combout => \RAM~112_combout\);

-- Location: LCCOMB_X29_Y25_N30
\RAM~113\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~113_combout\ = (\RAM~112_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~112_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~113_combout\);

-- Location: FF_X29_Y25_N29
\RAM~20\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~20feeder_combout\,
	ena => \RAM~113_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~20_q\);

-- Location: LCCOMB_X32_Y26_N28
\RAM~118\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~118_combout\ = (\iAddr[0]~input_o\ & (\iAddr[1]~input_o\ & (\iAddr[2]~input_o\ & !\iAddr[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \iAddr[2]~input_o\,
	datad => \iAddr[3]~input_o\,
	combout => \RAM~118_combout\);

-- Location: LCCOMB_X32_Y26_N26
\RAM~119\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~119_combout\ = (\RAM~118_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~118_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~119_combout\);

-- Location: FF_X30_Y25_N3
\RAM~28\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~119_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~28_q\);

-- Location: LCCOMB_X32_Y26_N4
\RAM~116\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~116_combout\ = (!\iAddr[0]~input_o\ & (!\iAddr[1]~input_o\ & (\iAddr[2]~input_o\ & !\iAddr[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \iAddr[2]~input_o\,
	datad => \iAddr[3]~input_o\,
	combout => \RAM~116_combout\);

-- Location: LCCOMB_X32_Y26_N2
\RAM~117\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~117_combout\ = (\RAM~116_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~116_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~117_combout\);

-- Location: FF_X30_Y25_N13
\RAM~16\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~117_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~16_q\);

-- Location: LCCOMB_X32_Y26_N0
\RAM~114\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~114_combout\ = (\iAddr[2]~input_o\ & (\iAddr[1]~input_o\ & (!\iAddr[0]~input_o\ & !\iAddr[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \iAddr[0]~input_o\,
	datad => \iAddr[3]~input_o\,
	combout => \RAM~114_combout\);

-- Location: LCCOMB_X32_Y26_N30
\RAM~115\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~115_combout\ = (\RAM~114_combout\ & (\RESET~input_o\ & \iEn~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \RAM~114_combout\,
	datac => \RESET~input_o\,
	datad => \iEn~input_o\,
	combout => \RAM~115_combout\);

-- Location: FF_X31_Y25_N25
\RAM~24\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[0]~input_o\,
	sload => VCC,
	ena => \RAM~115_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~24_q\);

-- Location: LCCOMB_X30_Y25_N12
\RAM~66\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~66_combout\ = (\iAddr[1]~input_o\ & ((\iAddr[0]~input_o\) # ((\RAM~24_q\)))) # (!\iAddr[1]~input_o\ & (!\iAddr[0]~input_o\ & (\RAM~16_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[0]~input_o\,
	datac => \RAM~16_q\,
	datad => \RAM~24_q\,
	combout => \RAM~66_combout\);

-- Location: LCCOMB_X30_Y25_N2
\RAM~67\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~67_combout\ = (\iAddr[0]~input_o\ & ((\RAM~66_combout\ & ((\RAM~28_q\))) # (!\RAM~66_combout\ & (\RAM~20_q\)))) # (!\iAddr[0]~input_o\ & (((\RAM~66_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \RAM~20_q\,
	datac => \RAM~28_q\,
	datad => \RAM~66_combout\,
	combout => \RAM~67_combout\);

-- Location: LCCOMB_X29_Y26_N28
\RAM~70\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~70_combout\ = (\iAddr[3]~input_o\ & (\iAddr[2]~input_o\)) # (!\iAddr[3]~input_o\ & ((\iAddr[2]~input_o\ & ((\RAM~67_combout\))) # (!\iAddr[2]~input_o\ & (\RAM~69_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~69_combout\,
	datad => \RAM~67_combout\,
	combout => \RAM~70_combout\);

-- Location: LCCOMB_X29_Y26_N18
\RAM~73\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~73_combout\ = (\iAddr[3]~input_o\ & ((\RAM~70_combout\ & ((\RAM~72_combout\))) # (!\RAM~70_combout\ & (\RAM~65_combout\)))) # (!\iAddr[3]~input_o\ & (((\RAM~70_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \RAM~65_combout\,
	datac => \RAM~72_combout\,
	datad => \RAM~70_combout\,
	combout => \RAM~73_combout\);

-- Location: CLKCTRL_G19
\RESET~inputclkctrl\ : cycloneiv_clkctrl
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

-- Location: FF_X29_Y26_N19
\D1[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~73_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D1(0));

-- Location: LCCOMB_X29_Y26_N6
\D2[0]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D2[0]~feeder_combout\ = D1(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => D1(0),
	combout => \D2[0]~feeder_combout\);

-- Location: FF_X29_Y26_N7
\D2[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D2[0]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(0));

-- Location: LCCOMB_X30_Y26_N0
\D3[0]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D3[0]~feeder_combout\ = D2(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => D2(0),
	combout => \D3[0]~feeder_combout\);

-- Location: FF_X30_Y26_N1
\D3[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D3[0]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D3(0));

-- Location: IOIBUF_X33_Y27_N1
\iData[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(1),
	o => \iData[1]~input_o\);

-- Location: FF_X32_Y25_N1
\RAM~25\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~115_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~25_q\);

-- Location: FF_X32_Y25_N3
\RAM~41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~105_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~41_q\);

-- Location: FF_X31_Y26_N31
\RAM~9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~121_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~9_q\);

-- Location: LCCOMB_X32_Y25_N2
\RAM~74\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~74_combout\ = (\iAddr[2]~input_o\ & (\iAddr[3]~input_o\)) # (!\iAddr[2]~input_o\ & ((\iAddr[3]~input_o\ & (\RAM~41_q\)) # (!\iAddr[3]~input_o\ & ((\RAM~9_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \iAddr[3]~input_o\,
	datac => \RAM~41_q\,
	datad => \RAM~9_q\,
	combout => \RAM~74_combout\);

-- Location: LCCOMB_X32_Y25_N0
\RAM~75\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~75_combout\ = (\iAddr[2]~input_o\ & ((\RAM~74_combout\ & (\RAM~57_q\)) # (!\RAM~74_combout\ & ((\RAM~25_q\))))) # (!\iAddr[2]~input_o\ & (((\RAM~74_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~57_q\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~25_q\,
	datad => \RAM~74_combout\,
	combout => \RAM~75_combout\);

-- Location: FF_X32_Y24_N19
\RAM~37\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~107_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~37_q\);

-- Location: FF_X31_Y24_N15
\RAM~53\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~129_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~53_q\);

-- Location: FF_X31_Y24_N13
\RAM~5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~123_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~5_q\);

-- Location: FF_X30_Y24_N29
\RAM~21\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~113_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~21_q\);

-- Location: LCCOMB_X31_Y24_N12
\RAM~76\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~76_combout\ = (\iAddr[3]~input_o\ & (\iAddr[2]~input_o\)) # (!\iAddr[3]~input_o\ & ((\iAddr[2]~input_o\ & ((\RAM~21_q\))) # (!\iAddr[2]~input_o\ & (\RAM~5_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~5_q\,
	datad => \RAM~21_q\,
	combout => \RAM~76_combout\);

-- Location: LCCOMB_X31_Y24_N14
\RAM~77\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~77_combout\ = (\iAddr[3]~input_o\ & ((\RAM~76_combout\ & ((\RAM~53_q\))) # (!\RAM~76_combout\ & (\RAM~37_q\)))) # (!\iAddr[3]~input_o\ & (((\RAM~76_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \RAM~37_q\,
	datac => \RAM~53_q\,
	datad => \RAM~76_combout\,
	combout => \RAM~77_combout\);

-- Location: LCCOMB_X32_Y27_N8
\RAM~17feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~17feeder_combout\ = \iData[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[1]~input_o\,
	combout => \RAM~17feeder_combout\);

-- Location: FF_X32_Y27_N9
\RAM~17\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~17feeder_combout\,
	ena => \RAM~117_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~17_q\);

-- Location: FF_X32_Y26_N19
\RAM~49\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~49_q\);

-- Location: FF_X31_Y26_N13
\RAM~1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~125_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~1_q\);

-- Location: LCCOMB_X31_Y27_N8
\RAM~33feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~33feeder_combout\ = \iData[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[1]~input_o\,
	combout => \RAM~33feeder_combout\);

-- Location: FF_X31_Y27_N9
\RAM~33\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~33feeder_combout\,
	ena => \RAM~109_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~33_q\);

-- Location: LCCOMB_X31_Y26_N12
\RAM~78\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~78_combout\ = (\iAddr[2]~input_o\ & (\iAddr[3]~input_o\)) # (!\iAddr[2]~input_o\ & ((\iAddr[3]~input_o\ & ((\RAM~33_q\))) # (!\iAddr[3]~input_o\ & (\RAM~1_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \iAddr[3]~input_o\,
	datac => \RAM~1_q\,
	datad => \RAM~33_q\,
	combout => \RAM~78_combout\);

-- Location: LCCOMB_X32_Y26_N18
\RAM~79\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~79_combout\ = (\iAddr[2]~input_o\ & ((\RAM~78_combout\ & ((\RAM~49_q\))) # (!\RAM~78_combout\ & (\RAM~17_q\)))) # (!\iAddr[2]~input_o\ & (((\RAM~78_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \RAM~17_q\,
	datac => \RAM~49_q\,
	datad => \RAM~78_combout\,
	combout => \RAM~79_combout\);

-- Location: LCCOMB_X32_Y26_N8
\RAM~80\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~80_combout\ = (\iAddr[0]~input_o\ & ((\iAddr[1]~input_o\) # ((\RAM~77_combout\)))) # (!\iAddr[0]~input_o\ & (!\iAddr[1]~input_o\ & ((\RAM~79_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \RAM~77_combout\,
	datad => \RAM~79_combout\,
	combout => \RAM~80_combout\);

-- Location: LCCOMB_X30_Y27_N20
\RAM~45feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~45feeder_combout\ = \iData[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[1]~input_o\,
	combout => \RAM~45feeder_combout\);

-- Location: FF_X30_Y27_N21
\RAM~45\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~45feeder_combout\,
	ena => \RAM~111_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~45_q\);

-- Location: FF_X30_Y26_N11
\RAM~61\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~135_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~61_q\);

-- Location: FF_X29_Y26_N15
\RAM~13\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[1]~input_o\,
	sload => VCC,
	ena => \RAM~127_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~13_q\);

-- Location: LCCOMB_X30_Y25_N0
\RAM~29feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~29feeder_combout\ = \iData[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[1]~input_o\,
	combout => \RAM~29feeder_combout\);

-- Location: FF_X30_Y25_N1
\RAM~29\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~29feeder_combout\,
	ena => \RAM~119_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~29_q\);

-- Location: LCCOMB_X29_Y26_N14
\RAM~81\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~81_combout\ = (\iAddr[2]~input_o\ & ((\iAddr[3]~input_o\) # ((\RAM~29_q\)))) # (!\iAddr[2]~input_o\ & (!\iAddr[3]~input_o\ & (\RAM~13_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \iAddr[3]~input_o\,
	datac => \RAM~13_q\,
	datad => \RAM~29_q\,
	combout => \RAM~81_combout\);

-- Location: LCCOMB_X30_Y26_N10
\RAM~82\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~82_combout\ = (\iAddr[3]~input_o\ & ((\RAM~81_combout\ & ((\RAM~61_q\))) # (!\RAM~81_combout\ & (\RAM~45_q\)))) # (!\iAddr[3]~input_o\ & (((\RAM~81_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \RAM~45_q\,
	datac => \RAM~61_q\,
	datad => \RAM~81_combout\,
	combout => \RAM~82_combout\);

-- Location: LCCOMB_X32_Y26_N14
\RAM~83\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~83_combout\ = (\iAddr[1]~input_o\ & ((\RAM~80_combout\ & ((\RAM~82_combout\))) # (!\RAM~80_combout\ & (\RAM~75_combout\)))) # (!\iAddr[1]~input_o\ & (((\RAM~80_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100001011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \RAM~75_combout\,
	datac => \RAM~80_combout\,
	datad => \RAM~82_combout\,
	combout => \RAM~83_combout\);

-- Location: FF_X32_Y26_N15
\D1[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~83_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D1(1));

-- Location: LCCOMB_X32_Y26_N20
\D2[1]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D2[1]~feeder_combout\ = D1(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => D1(1),
	combout => \D2[1]~feeder_combout\);

-- Location: FF_X32_Y26_N21
\D2[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D2[1]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(1));

-- Location: LCCOMB_X32_Y24_N20
\D3[1]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D3[1]~feeder_combout\ = D2(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => D2(1),
	combout => \D3[1]~feeder_combout\);

-- Location: FF_X32_Y24_N21
\D3[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D3[1]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D3(1));

-- Location: IOIBUF_X33_Y28_N1
\iData[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(2),
	o => \iData[2]~input_o\);

-- Location: LCCOMB_X31_Y25_N0
\RAM~58feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~58feeder_combout\ = \iData[2]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[2]~input_o\,
	combout => \RAM~58feeder_combout\);

-- Location: FF_X31_Y25_N1
\RAM~58\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~58feeder_combout\,
	ena => \RAM~131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~58_q\);

-- Location: FF_X30_Y26_N13
\RAM~62\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~135_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~62_q\);

-- Location: FF_X31_Y27_N15
\RAM~50\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~133_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~50_q\);

-- Location: FF_X32_Y27_N7
\RAM~54\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~129_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~54_q\);

-- Location: LCCOMB_X31_Y27_N14
\RAM~91\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~91_combout\ = (\iAddr[0]~input_o\ & ((\iAddr[1]~input_o\) # ((\RAM~54_q\)))) # (!\iAddr[0]~input_o\ & (!\iAddr[1]~input_o\ & (\RAM~50_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \RAM~50_q\,
	datad => \RAM~54_q\,
	combout => \RAM~91_combout\);

-- Location: LCCOMB_X30_Y26_N12
\RAM~92\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~92_combout\ = (\iAddr[1]~input_o\ & ((\RAM~91_combout\ & ((\RAM~62_q\))) # (!\RAM~91_combout\ & (\RAM~58_q\)))) # (!\iAddr[1]~input_o\ & (((\RAM~91_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \RAM~58_q\,
	datac => \RAM~62_q\,
	datad => \RAM~91_combout\,
	combout => \RAM~92_combout\);

-- Location: FF_X29_Y26_N9
\RAM~14\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~127_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~14_q\);

-- Location: FF_X31_Y26_N17
\RAM~2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~125_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~2_q\);

-- Location: LCCOMB_X31_Y26_N2
\RAM~10feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~10feeder_combout\ = \iData[2]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[2]~input_o\,
	combout => \RAM~10feeder_combout\);

-- Location: FF_X31_Y26_N3
\RAM~10\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~10feeder_combout\,
	ena => \RAM~121_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~10_q\);

-- Location: LCCOMB_X31_Y26_N16
\RAM~88\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~88_combout\ = (\iAddr[1]~input_o\ & ((\iAddr[0]~input_o\) # ((\RAM~10_q\)))) # (!\iAddr[1]~input_o\ & (!\iAddr[0]~input_o\ & (\RAM~2_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[0]~input_o\,
	datac => \RAM~2_q\,
	datad => \RAM~10_q\,
	combout => \RAM~88_combout\);

-- Location: LCCOMB_X29_Y26_N8
\RAM~89\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~89_combout\ = (\iAddr[0]~input_o\ & ((\RAM~88_combout\ & ((\RAM~14_q\))) # (!\RAM~88_combout\ & (\RAM~6_q\)))) # (!\iAddr[0]~input_o\ & (((\RAM~88_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~6_q\,
	datab => \iAddr[0]~input_o\,
	datac => \RAM~14_q\,
	datad => \RAM~88_combout\,
	combout => \RAM~89_combout\);

-- Location: FF_X30_Y27_N3
\RAM~38\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~107_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~38_q\);

-- Location: FF_X30_Y27_N17
\RAM~46\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~111_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~46_q\);

-- Location: FF_X29_Y27_N15
\RAM~34\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~109_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~34_q\);

-- Location: LCCOMB_X29_Y27_N0
\RAM~42feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~42feeder_combout\ = \iData[2]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[2]~input_o\,
	combout => \RAM~42feeder_combout\);

-- Location: FF_X29_Y27_N1
\RAM~42\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~42feeder_combout\,
	ena => \RAM~105_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~42_q\);

-- Location: LCCOMB_X29_Y27_N14
\RAM~86\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~86_combout\ = (\iAddr[1]~input_o\ & ((\iAddr[0]~input_o\) # ((\RAM~42_q\)))) # (!\iAddr[1]~input_o\ & (!\iAddr[0]~input_o\ & (\RAM~34_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[0]~input_o\,
	datac => \RAM~34_q\,
	datad => \RAM~42_q\,
	combout => \RAM~86_combout\);

-- Location: LCCOMB_X30_Y27_N16
\RAM~87\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~87_combout\ = (\iAddr[0]~input_o\ & ((\RAM~86_combout\ & ((\RAM~46_q\))) # (!\RAM~86_combout\ & (\RAM~38_q\)))) # (!\iAddr[0]~input_o\ & (((\RAM~86_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \RAM~38_q\,
	datac => \RAM~46_q\,
	datad => \RAM~86_combout\,
	combout => \RAM~87_combout\);

-- Location: LCCOMB_X29_Y26_N30
\RAM~90\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~90_combout\ = (\iAddr[3]~input_o\ & ((\iAddr[2]~input_o\) # ((\RAM~87_combout\)))) # (!\iAddr[3]~input_o\ & (!\iAddr[2]~input_o\ & (\RAM~89_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~89_combout\,
	datad => \RAM~87_combout\,
	combout => \RAM~90_combout\);

-- Location: FF_X29_Y24_N7
\RAM~18\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~117_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~18_q\);

-- Location: FF_X29_Y24_N1
\RAM~22\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~113_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~22_q\);

-- Location: LCCOMB_X29_Y24_N6
\RAM~84\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~84_combout\ = (\iAddr[1]~input_o\ & (\iAddr[0]~input_o\)) # (!\iAddr[1]~input_o\ & ((\iAddr[0]~input_o\ & ((\RAM~22_q\))) # (!\iAddr[0]~input_o\ & (\RAM~18_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \iAddr[0]~input_o\,
	datac => \RAM~18_q\,
	datad => \RAM~22_q\,
	combout => \RAM~84_combout\);

-- Location: FF_X30_Y24_N3
\RAM~30\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[2]~input_o\,
	sload => VCC,
	ena => \RAM~119_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~30_q\);

-- Location: LCCOMB_X31_Y25_N18
\RAM~26feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~26feeder_combout\ = \iData[2]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[2]~input_o\,
	combout => \RAM~26feeder_combout\);

-- Location: FF_X31_Y25_N19
\RAM~26\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~26feeder_combout\,
	ena => \RAM~115_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~26_q\);

-- Location: LCCOMB_X30_Y24_N2
\RAM~85\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~85_combout\ = (\iAddr[1]~input_o\ & ((\RAM~84_combout\ & (\RAM~30_q\)) # (!\RAM~84_combout\ & ((\RAM~26_q\))))) # (!\iAddr[1]~input_o\ & (\RAM~84_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[1]~input_o\,
	datab => \RAM~84_combout\,
	datac => \RAM~30_q\,
	datad => \RAM~26_q\,
	combout => \RAM~85_combout\);

-- Location: LCCOMB_X29_Y26_N0
\RAM~93\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~93_combout\ = (\iAddr[2]~input_o\ & ((\RAM~90_combout\ & (\RAM~92_combout\)) # (!\RAM~90_combout\ & ((\RAM~85_combout\))))) # (!\iAddr[2]~input_o\ & (((\RAM~90_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \RAM~92_combout\,
	datac => \RAM~90_combout\,
	datad => \RAM~85_combout\,
	combout => \RAM~93_combout\);

-- Location: FF_X29_Y26_N1
\D1[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~93_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D1(2));

-- Location: LCCOMB_X29_Y26_N16
\D2[2]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D2[2]~feeder_combout\ = D1(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => D1(2),
	combout => \D2[2]~feeder_combout\);

-- Location: FF_X29_Y26_N17
\D2[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D2[2]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(2));

-- Location: LCCOMB_X29_Y26_N24
\D3[2]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D3[2]~feeder_combout\ = D2(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => D2(2),
	combout => \D3[2]~feeder_combout\);

-- Location: FF_X29_Y26_N25
\D3[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D3[2]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D3(2));

-- Location: IOIBUF_X33_Y24_N8
\iData[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_iData(3),
	o => \iData[3]~input_o\);

-- Location: FF_X30_Y26_N5
\RAM~63\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~135_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~63_q\);

-- Location: FF_X30_Y27_N31
\RAM~47\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~111_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~47_q\);

-- Location: LCCOMB_X29_Y26_N20
\RAM~15feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~15feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~15feeder_combout\);

-- Location: FF_X29_Y26_N21
\RAM~15\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~15feeder_combout\,
	ena => \RAM~127_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~15_q\);

-- Location: LCCOMB_X30_Y26_N2
\RAM~101\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~101_combout\ = (\iAddr[3]~input_o\ & ((\iAddr[2]~input_o\) # ((\RAM~47_q\)))) # (!\iAddr[3]~input_o\ & (!\iAddr[2]~input_o\ & ((\RAM~15_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~47_q\,
	datad => \RAM~15_q\,
	combout => \RAM~101_combout\);

-- Location: LCCOMB_X30_Y26_N4
\RAM~102\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~102_combout\ = (\iAddr[2]~input_o\ & ((\RAM~101_combout\ & ((\RAM~63_q\))) # (!\RAM~101_combout\ & (\RAM~31_q\)))) # (!\iAddr[2]~input_o\ & (((\RAM~101_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~31_q\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~63_q\,
	datad => \RAM~101_combout\,
	combout => \RAM~102_combout\);

-- Location: FF_X31_Y24_N27
\RAM~55\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~129_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~55_q\);

-- Location: FF_X31_Y24_N1
\RAM~7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~123_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~7_q\);

-- Location: LCCOMB_X32_Y24_N28
\RAM~39feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~39feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~39feeder_combout\);

-- Location: FF_X32_Y24_N29
\RAM~39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~39feeder_combout\,
	ena => \RAM~107_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~39_q\);

-- Location: LCCOMB_X31_Y24_N0
\RAM~94\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~94_combout\ = (\iAddr[3]~input_o\ & ((\iAddr[2]~input_o\) # ((\RAM~39_q\)))) # (!\iAddr[3]~input_o\ & (!\iAddr[2]~input_o\ & (\RAM~7_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~7_q\,
	datad => \RAM~39_q\,
	combout => \RAM~94_combout\);

-- Location: LCCOMB_X31_Y24_N26
\RAM~95\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~95_combout\ = (\iAddr[2]~input_o\ & ((\RAM~94_combout\ & ((\RAM~55_q\))) # (!\RAM~94_combout\ & (\RAM~23_q\)))) # (!\iAddr[2]~input_o\ & (((\RAM~94_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~23_q\,
	datab => \iAddr[2]~input_o\,
	datac => \RAM~55_q\,
	datad => \RAM~94_combout\,
	combout => \RAM~95_combout\);

-- Location: LCCOMB_X31_Y27_N16
\RAM~35feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~35feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~35feeder_combout\);

-- Location: FF_X31_Y27_N17
\RAM~35\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~35feeder_combout\,
	ena => \RAM~109_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~35_q\);

-- Location: FF_X31_Y26_N1
\RAM~3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~125_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~3_q\);

-- Location: FF_X30_Y25_N15
\RAM~19\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~117_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~19_q\);

-- Location: LCCOMB_X31_Y26_N0
\RAM~98\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~98_combout\ = (\iAddr[2]~input_o\ & ((\iAddr[3]~input_o\) # ((\RAM~19_q\)))) # (!\iAddr[2]~input_o\ & (!\iAddr[3]~input_o\ & (\RAM~3_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \iAddr[3]~input_o\,
	datac => \RAM~3_q\,
	datad => \RAM~19_q\,
	combout => \RAM~98_combout\);

-- Location: LCCOMB_X31_Y26_N10
\RAM~99\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~99_combout\ = (\iAddr[3]~input_o\ & ((\RAM~98_combout\ & (\RAM~51_q\)) # (!\RAM~98_combout\ & ((\RAM~35_q\))))) # (!\iAddr[3]~input_o\ & (((\RAM~98_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \RAM~51_q\,
	datab => \iAddr[3]~input_o\,
	datac => \RAM~35_q\,
	datad => \RAM~98_combout\,
	combout => \RAM~99_combout\);

-- Location: LCCOMB_X29_Y27_N20
\RAM~43feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~43feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~43feeder_combout\);

-- Location: FF_X29_Y27_N21
\RAM~43\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~43feeder_combout\,
	ena => \RAM~105_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~43_q\);

-- Location: LCCOMB_X31_Y25_N8
\RAM~59feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~59feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~59feeder_combout\);

-- Location: FF_X31_Y25_N9
\RAM~59\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~59feeder_combout\,
	ena => \RAM~131_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~59_q\);

-- Location: FF_X31_Y26_N7
\RAM~11\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	asdata => \iData[3]~input_o\,
	sload => VCC,
	ena => \RAM~121_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~11_q\);

-- Location: LCCOMB_X31_Y25_N2
\RAM~27feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~27feeder_combout\ = \iData[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \iData[3]~input_o\,
	combout => \RAM~27feeder_combout\);

-- Location: FF_X31_Y25_N3
\RAM~27\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~27feeder_combout\,
	ena => \RAM~115_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \RAM~27_q\);

-- Location: LCCOMB_X31_Y26_N6
\RAM~96\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~96_combout\ = (\iAddr[2]~input_o\ & ((\iAddr[3]~input_o\) # ((\RAM~27_q\)))) # (!\iAddr[2]~input_o\ & (!\iAddr[3]~input_o\ & (\RAM~11_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[2]~input_o\,
	datab => \iAddr[3]~input_o\,
	datac => \RAM~11_q\,
	datad => \RAM~27_q\,
	combout => \RAM~96_combout\);

-- Location: LCCOMB_X30_Y26_N6
\RAM~97\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~97_combout\ = (\iAddr[3]~input_o\ & ((\RAM~96_combout\ & ((\RAM~59_q\))) # (!\RAM~96_combout\ & (\RAM~43_q\)))) # (!\iAddr[3]~input_o\ & (((\RAM~96_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[3]~input_o\,
	datab => \RAM~43_q\,
	datac => \RAM~59_q\,
	datad => \RAM~96_combout\,
	combout => \RAM~97_combout\);

-- Location: LCCOMB_X30_Y26_N28
\RAM~100\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~100_combout\ = (\iAddr[0]~input_o\ & (\iAddr[1]~input_o\)) # (!\iAddr[0]~input_o\ & ((\iAddr[1]~input_o\ & ((\RAM~97_combout\))) # (!\iAddr[1]~input_o\ & (\RAM~99_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \iAddr[1]~input_o\,
	datac => \RAM~99_combout\,
	datad => \RAM~97_combout\,
	combout => \RAM~100_combout\);

-- Location: LCCOMB_X30_Y26_N22
\RAM~103\ : cycloneiv_lcell_comb
-- Equation(s):
-- \RAM~103_combout\ = (\iAddr[0]~input_o\ & ((\RAM~100_combout\ & (\RAM~102_combout\)) # (!\RAM~100_combout\ & ((\RAM~95_combout\))))) # (!\iAddr[0]~input_o\ & (((\RAM~100_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \iAddr[0]~input_o\,
	datab => \RAM~102_combout\,
	datac => \RAM~95_combout\,
	datad => \RAM~100_combout\,
	combout => \RAM~103_combout\);

-- Location: FF_X30_Y26_N23
\D1[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \RAM~103_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D1(3));

-- Location: LCCOMB_X30_Y26_N24
\D2[3]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D2[3]~feeder_combout\ = D1(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => D1(3),
	combout => \D2[3]~feeder_combout\);

-- Location: FF_X30_Y26_N25
\D2[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D2[3]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D2(3));

-- Location: LCCOMB_X30_Y26_N26
\D3[3]~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \D3[3]~feeder_combout\ = D2(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => D2(3),
	combout => \D3[3]~feeder_combout\);

-- Location: FF_X30_Y26_N27
\D3[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK~inputclkctrl_outclk\,
	d => \D3[3]~feeder_combout\,
	clrn => \RESET~inputclkctrl_outclk\,
	ena => \iEn~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => D3(3));

ww_oData(0) <= \oData[0]~output_o\;

ww_oData(1) <= \oData[1]~output_o\;

ww_oData(2) <= \oData[2]~output_o\;

ww_oData(3) <= \oData[3]~output_o\;
END structure;


