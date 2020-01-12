-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
-- Date        : Wed Oct 04 22:45:04 2017
-- Host        : DESKTOP-NK9IJDR running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               e:/MIA701SRC/S02_CH11/S02_CH10_640_480_DDR_HDMI_3/MIG_OV_PRG/MIG_OV_PRG.srcs/sources_1/ip/OV_Sensor_ML_0/OV_Sensor_ML_0_sim_netlist.vhdl
-- Design      : OV_Sensor_ML_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tfgg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity OV_Sensor_ML_0_cmos_decode is
  port (
    rgb_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    hs_o : out STD_LOGIC;
    vs_o : out STD_LOGIC;
    vid_clk_ce : out STD_LOGIC;
    \cnt_reg[13]\ : in STD_LOGIC;
    CLK_i : in STD_LOGIC;
    cmos_pclk_i : in STD_LOGIC;
    cmos_href_r : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    D : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of OV_Sensor_ML_0_cmos_decode : entity is "cmos_decode";
end OV_Sensor_ML_0_cmos_decode;

architecture STRUCTURE of OV_Sensor_ML_0_cmos_decode is
  signal byte_flag : STD_LOGIC;
  signal byte_flag_i_1_n_0 : STD_LOGIC;
  signal byte_flag_r0 : STD_LOGIC;
  signal cmos_data_d0 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \cmos_data_d0[0]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_data_d0[1]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_data_d0[2]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_data_d0[3]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_data_d0[4]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_data_d0[5]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_data_d0[6]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_data_d0[7]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps[0]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps[1]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps[2]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps[2]_i_2_n_0\ : STD_LOGIC;
  signal \cmos_fps[3]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps[3]_i_2_n_0\ : STD_LOGIC;
  signal \cmos_fps[3]_i_3_n_0\ : STD_LOGIC;
  signal \cmos_fps[3]_i_4_n_0\ : STD_LOGIC;
  signal \cmos_fps[3]_i_5_n_0\ : STD_LOGIC;
  signal \cmos_fps[3]_i_6_n_0\ : STD_LOGIC;
  signal \cmos_fps[4]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps[5]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps[6]_i_1_n_0\ : STD_LOGIC;
  signal \cmos_fps_reg_n_0_[0]\ : STD_LOGIC;
  signal \cmos_fps_reg_n_0_[1]\ : STD_LOGIC;
  signal \cmos_fps_reg_n_0_[2]\ : STD_LOGIC;
  signal \cmos_fps_reg_n_0_[3]\ : STD_LOGIC;
  signal \cmos_fps_reg_n_0_[4]\ : STD_LOGIC;
  signal \cmos_fps_reg_n_0_[5]\ : STD_LOGIC;
  signal \cmos_fps_reg_n_0_[6]\ : STD_LOGIC;
  signal \href_d_reg_n_0_[0]\ : STD_LOGIC;
  signal out_en : STD_LOGIC;
  signal out_en_i_1_n_0 : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal \rgb565_o[0]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[10]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[11]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[12]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[13]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[14]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[15]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[15]_i_2_n_0\ : STD_LOGIC;
  signal \rgb565_o[1]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[2]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[3]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[4]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[5]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[6]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[7]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[8]_i_1_n_0\ : STD_LOGIC;
  signal \rgb565_o[9]_i_1_n_0\ : STD_LOGIC;
  signal rst_n_reg : STD_LOGIC_VECTOR ( 4 to 4 );
  signal \rst_n_reg_reg[3]_srl5_n_0\ : STD_LOGIC;
  signal \vsync_d_reg_n_0_[0]\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \cmos_data_d0[0]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \cmos_data_d0[1]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \cmos_data_d0[2]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \cmos_data_d0[3]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \cmos_data_d0[4]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \cmos_data_d0[5]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \cmos_data_d0[6]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \cmos_data_d0[7]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \cmos_fps[2]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \cmos_fps[3]_i_4\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \cmos_fps[3]_i_5\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \cmos_fps[3]_i_6\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \cmos_fps[4]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \cmos_fps[5]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of hs_o_INST_0 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of out_en_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \rgb565_o[0]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \rgb565_o[10]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \rgb565_o[11]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \rgb565_o[12]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \rgb565_o[13]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \rgb565_o[14]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rgb565_o[15]_i_2\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \rgb565_o[1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \rgb565_o[2]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \rgb565_o[3]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rgb565_o[4]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rgb565_o[5]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \rgb565_o[6]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \rgb565_o[7]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \rgb565_o[8]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \rgb565_o[9]_i_1\ : label is "soft_lutpair8";
  attribute srl_bus_name : string;
  attribute srl_bus_name of \rst_n_reg_reg[3]_srl5\ : label is "\inst/cmos_decode_u0/rst_n_reg_reg ";
  attribute srl_name : string;
  attribute srl_name of \rst_n_reg_reg[3]_srl5\ : label is "\inst/cmos_decode_u0/rst_n_reg_reg[3]_srl5 ";
  attribute SOFT_HLUTNM of vid_clk_ce_INST_0 : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of vs_o_INST_0 : label is "soft_lutpair14";
begin
byte_flag_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => byte_flag,
      I1 => rst_n_reg(4),
      I2 => cmos_href_r,
      O => byte_flag_i_1_n_0
    );
byte_flag_r0_reg: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => byte_flag,
      Q => byte_flag_r0,
      R => \cmos_fps[3]_i_1_n_0\
    );
byte_flag_reg: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => byte_flag_i_1_n_0,
      Q => byte_flag,
      R => '0'
    );
\cmos_data_d0[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(0),
      O => \cmos_data_d0[0]_i_1_n_0\
    );
\cmos_data_d0[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(1),
      O => \cmos_data_d0[1]_i_1_n_0\
    );
\cmos_data_d0[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(2),
      O => \cmos_data_d0[2]_i_1_n_0\
    );
\cmos_data_d0[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(3),
      O => \cmos_data_d0[3]_i_1_n_0\
    );
\cmos_data_d0[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(4),
      O => \cmos_data_d0[4]_i_1_n_0\
    );
\cmos_data_d0[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(5),
      O => \cmos_data_d0[5]_i_1_n_0\
    );
\cmos_data_d0[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(6),
      O => \cmos_data_d0[6]_i_1_n_0\
    );
\cmos_data_d0[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => cmos_href_r,
      I1 => Q(7),
      O => \cmos_data_d0[7]_i_1_n_0\
    );
\cmos_data_d0_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[0]_i_1_n_0\,
      Q => cmos_data_d0(0),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_data_d0_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[1]_i_1_n_0\,
      Q => cmos_data_d0(1),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_data_d0_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[2]_i_1_n_0\,
      Q => cmos_data_d0(2),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_data_d0_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[3]_i_1_n_0\,
      Q => cmos_data_d0(3),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_data_d0_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[4]_i_1_n_0\,
      Q => cmos_data_d0(4),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_data_d0_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[5]_i_1_n_0\,
      Q => cmos_data_d0(5),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_data_d0_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[6]_i_1_n_0\,
      Q => cmos_data_d0(6),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_data_d0_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_data_d0[7]_i_1_n_0\,
      Q => cmos_data_d0(7),
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_fps[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA8AAAAFFFFFFFF"
    )
        port map (
      I0 => \cmos_fps[3]_i_5_n_0\,
      I1 => \cmos_fps_reg_n_0_[4]\,
      I2 => \cmos_fps_reg_n_0_[5]\,
      I3 => \cmos_fps_reg_n_0_[6]\,
      I4 => \cmos_fps[3]_i_4_n_0\,
      I5 => \cmos_fps_reg_n_0_[0]\,
      O => \cmos_fps[0]_i_1_n_0\
    );
\cmos_fps[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F6FF6666F6FFF6FF"
    )
        port map (
      I0 => \cmos_fps_reg_n_0_[1]\,
      I1 => \cmos_fps_reg_n_0_[0]\,
      I2 => \vsync_d_reg_n_0_[0]\,
      I3 => p_1_in,
      I4 => \cmos_fps[2]_i_2_n_0\,
      I5 => \cmos_fps[3]_i_4_n_0\,
      O => \cmos_fps[1]_i_1_n_0\
    );
\cmos_fps[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"A8FFFFFFFF888888"
    )
        port map (
      I0 => \cmos_fps[3]_i_5_n_0\,
      I1 => \cmos_fps[2]_i_2_n_0\,
      I2 => \cmos_fps_reg_n_0_[3]\,
      I3 => \cmos_fps_reg_n_0_[1]\,
      I4 => \cmos_fps_reg_n_0_[0]\,
      I5 => \cmos_fps_reg_n_0_[2]\,
      O => \cmos_fps[2]_i_1_n_0\
    );
\cmos_fps[2]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \cmos_fps_reg_n_0_[6]\,
      I1 => \cmos_fps_reg_n_0_[5]\,
      I2 => \cmos_fps_reg_n_0_[4]\,
      O => \cmos_fps[2]_i_2_n_0\
    );
\cmos_fps[3]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => rst_n_reg(4),
      O => \cmos_fps[3]_i_1_n_0\
    );
\cmos_fps[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFEFFFFFFFEFF"
    )
        port map (
      I0 => \cmos_fps_reg_n_0_[4]\,
      I1 => \cmos_fps_reg_n_0_[5]\,
      I2 => \cmos_fps_reg_n_0_[6]\,
      I3 => \cmos_fps[3]_i_4_n_0\,
      I4 => p_1_in,
      I5 => \vsync_d_reg_n_0_[0]\,
      O => \cmos_fps[3]_i_2_n_0\
    );
\cmos_fps[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFAAA8AAAAFFFF"
    )
        port map (
      I0 => \cmos_fps[3]_i_5_n_0\,
      I1 => \cmos_fps_reg_n_0_[4]\,
      I2 => \cmos_fps_reg_n_0_[5]\,
      I3 => \cmos_fps_reg_n_0_[6]\,
      I4 => \cmos_fps_reg_n_0_[3]\,
      I5 => \cmos_fps[3]_i_6_n_0\,
      O => \cmos_fps[3]_i_3_n_0\
    );
\cmos_fps[3]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \cmos_fps_reg_n_0_[2]\,
      I1 => \cmos_fps_reg_n_0_[0]\,
      I2 => \cmos_fps_reg_n_0_[1]\,
      I3 => \cmos_fps_reg_n_0_[3]\,
      O => \cmos_fps[3]_i_4_n_0\
    );
\cmos_fps[3]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => \vsync_d_reg_n_0_[0]\,
      I1 => p_1_in,
      O => \cmos_fps[3]_i_5_n_0\
    );
\cmos_fps[3]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => \cmos_fps_reg_n_0_[1]\,
      I1 => \cmos_fps_reg_n_0_[0]\,
      I2 => \cmos_fps_reg_n_0_[2]\,
      O => \cmos_fps[3]_i_6_n_0\
    );
\cmos_fps[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0082"
    )
        port map (
      I0 => rst_n_reg(4),
      I1 => \cmos_fps[3]_i_4_n_0\,
      I2 => \cmos_fps_reg_n_0_[4]\,
      I3 => \cmos_fps[3]_i_5_n_0\,
      O => \cmos_fps[4]_i_1_n_0\
    );
\cmos_fps[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000082A0"
    )
        port map (
      I0 => rst_n_reg(4),
      I1 => \cmos_fps[3]_i_4_n_0\,
      I2 => \cmos_fps_reg_n_0_[5]\,
      I3 => \cmos_fps_reg_n_0_[4]\,
      I4 => \cmos_fps[3]_i_5_n_0\,
      O => \cmos_fps[5]_i_1_n_0\
    );
\cmos_fps[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000082A0A0A0"
    )
        port map (
      I0 => rst_n_reg(4),
      I1 => \cmos_fps[3]_i_4_n_0\,
      I2 => \cmos_fps_reg_n_0_[6]\,
      I3 => \cmos_fps_reg_n_0_[5]\,
      I4 => \cmos_fps_reg_n_0_[4]\,
      I5 => \cmos_fps[3]_i_5_n_0\,
      O => \cmos_fps[6]_i_1_n_0\
    );
\cmos_fps_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \cmos_fps[3]_i_2_n_0\,
      D => \cmos_fps[0]_i_1_n_0\,
      Q => \cmos_fps_reg_n_0_[0]\,
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_fps_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \cmos_fps[3]_i_2_n_0\,
      D => \cmos_fps[1]_i_1_n_0\,
      Q => \cmos_fps_reg_n_0_[1]\,
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_fps_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \cmos_fps[3]_i_2_n_0\,
      D => \cmos_fps[2]_i_1_n_0\,
      Q => \cmos_fps_reg_n_0_[2]\,
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_fps_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \cmos_fps[3]_i_2_n_0\,
      D => \cmos_fps[3]_i_3_n_0\,
      Q => \cmos_fps_reg_n_0_[3]\,
      R => \cmos_fps[3]_i_1_n_0\
    );
\cmos_fps_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_fps[4]_i_1_n_0\,
      Q => \cmos_fps_reg_n_0_[4]\,
      R => '0'
    );
\cmos_fps_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_fps[5]_i_1_n_0\,
      Q => \cmos_fps_reg_n_0_[5]\,
      R => '0'
    );
\cmos_fps_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \cmos_fps[6]_i_1_n_0\,
      Q => \cmos_fps_reg_n_0_[6]\,
      R => '0'
    );
\href_d_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_href_r,
      Q => \href_d_reg_n_0_[0]\,
      R => '0'
    );
\href_d_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \href_d_reg_n_0_[0]\,
      Q => p_0_in,
      R => '0'
    );
hs_o_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => out_en,
      I1 => p_0_in,
      O => hs_o
    );
out_en_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFD"
    )
        port map (
      I0 => \cmos_fps[3]_i_4_n_0\,
      I1 => \cmos_fps_reg_n_0_[6]\,
      I2 => \cmos_fps_reg_n_0_[5]\,
      I3 => \cmos_fps_reg_n_0_[4]\,
      I4 => out_en,
      O => out_en_i_1_n_0
    );
out_en_reg: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => out_en_i_1_n_0,
      Q => out_en,
      R => \cmos_fps[3]_i_1_n_0\
    );
\rgb565_o[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(0),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[0]_i_1_n_0\
    );
\rgb565_o[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(2),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[10]_i_1_n_0\
    );
\rgb565_o[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(3),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[11]_i_1_n_0\
    );
\rgb565_o[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(4),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[12]_i_1_n_0\
    );
\rgb565_o[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(5),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[13]_i_1_n_0\
    );
\rgb565_o[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(6),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[14]_i_1_n_0\
    );
\rgb565_o[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F7"
    )
        port map (
      I0 => cmos_href_r,
      I1 => rst_n_reg(4),
      I2 => byte_flag,
      O => \rgb565_o[15]_i_1_n_0\
    );
\rgb565_o[15]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(7),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[15]_i_2_n_0\
    );
\rgb565_o[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(1),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[1]_i_1_n_0\
    );
\rgb565_o[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(2),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[2]_i_1_n_0\
    );
\rgb565_o[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(3),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[3]_i_1_n_0\
    );
\rgb565_o[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(4),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[4]_i_1_n_0\
    );
\rgb565_o[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(5),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[5]_i_1_n_0\
    );
\rgb565_o[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(6),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[6]_i_1_n_0\
    );
\rgb565_o[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => Q(7),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[7]_i_1_n_0\
    );
\rgb565_o[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(0),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[8]_i_1_n_0\
    );
\rgb565_o[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cmos_data_d0(1),
      I1 => cmos_href_r,
      I2 => rst_n_reg(4),
      O => \rgb565_o[9]_i_1_n_0\
    );
\rgb565_o_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[0]_i_1_n_0\,
      Q => rgb_o(0),
      R => '0'
    );
\rgb565_o_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[10]_i_1_n_0\,
      Q => rgb_o(10),
      R => '0'
    );
\rgb565_o_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[11]_i_1_n_0\,
      Q => rgb_o(11),
      R => '0'
    );
\rgb565_o_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[12]_i_1_n_0\,
      Q => rgb_o(12),
      R => '0'
    );
\rgb565_o_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[13]_i_1_n_0\,
      Q => rgb_o(13),
      R => '0'
    );
\rgb565_o_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[14]_i_1_n_0\,
      Q => rgb_o(14),
      R => '0'
    );
\rgb565_o_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[15]_i_2_n_0\,
      Q => rgb_o(15),
      R => '0'
    );
\rgb565_o_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[1]_i_1_n_0\,
      Q => rgb_o(1),
      R => '0'
    );
\rgb565_o_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[2]_i_1_n_0\,
      Q => rgb_o(2),
      R => '0'
    );
\rgb565_o_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[3]_i_1_n_0\,
      Q => rgb_o(3),
      R => '0'
    );
\rgb565_o_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[4]_i_1_n_0\,
      Q => rgb_o(4),
      R => '0'
    );
\rgb565_o_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[5]_i_1_n_0\,
      Q => rgb_o(5),
      R => '0'
    );
\rgb565_o_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[6]_i_1_n_0\,
      Q => rgb_o(6),
      R => '0'
    );
\rgb565_o_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[7]_i_1_n_0\,
      Q => rgb_o(7),
      R => '0'
    );
\rgb565_o_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[8]_i_1_n_0\,
      Q => rgb_o(8),
      R => '0'
    );
\rgb565_o_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => \rgb565_o[15]_i_1_n_0\,
      D => \rgb565_o[9]_i_1_n_0\,
      Q => rgb_o(9),
      R => '0'
    );
\rst_n_reg_reg[3]_srl5\: unisim.vcomponents.SRL16E
    generic map(
      INIT => X"0000"
    )
        port map (
      A0 => '0',
      A1 => '0',
      A2 => '1',
      A3 => '0',
      CE => '1',
      CLK => CLK_i,
      D => \cnt_reg[13]\,
      Q => \rst_n_reg_reg[3]_srl5_n_0\
    );
\rst_n_reg_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \rst_n_reg_reg[3]_srl5_n_0\,
      Q => rst_n_reg(4),
      R => '0'
    );
vid_clk_ce_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B0"
    )
        port map (
      I0 => byte_flag_r0,
      I1 => p_0_in,
      I2 => out_en,
      O => vid_clk_ce
    );
vs_o_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => out_en,
      I1 => p_1_in,
      O => vs_o
    );
\vsync_d_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => D(0),
      Q => \vsync_d_reg_n_0_[0]\,
      R => '0'
    );
\vsync_d_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => \vsync_d_reg_n_0_[0]\,
      Q => p_1_in,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity OV_Sensor_ML_0_count_reset_v1 is
  port (
    \rst_n_reg_reg[4]\ : out STD_LOGIC;
    CLK_i : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of OV_Sensor_ML_0_count_reset_v1 : entity is "count_reset_v1";
end OV_Sensor_ML_0_count_reset_v1;

architecture STRUCTURE of OV_Sensor_ML_0_count_reset_v1 is
  signal clear : STD_LOGIC;
  signal \cnt[0]_i_10_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_11_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_7_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_8_n_0\ : STD_LOGIC;
  signal \cnt[0]_i_9_n_0\ : STD_LOGIC;
  signal \cnt[12]_i_2_n_0\ : STD_LOGIC;
  signal \cnt[12]_i_3_n_0\ : STD_LOGIC;
  signal \cnt[12]_i_4_n_0\ : STD_LOGIC;
  signal \cnt[12]_i_5_n_0\ : STD_LOGIC;
  signal \cnt[16]_i_2_n_0\ : STD_LOGIC;
  signal \cnt[16]_i_3_n_0\ : STD_LOGIC;
  signal \cnt[16]_i_4_n_0\ : STD_LOGIC;
  signal \cnt[16]_i_5_n_0\ : STD_LOGIC;
  signal \cnt[4]_i_2_n_0\ : STD_LOGIC;
  signal \cnt[4]_i_3_n_0\ : STD_LOGIC;
  signal \cnt[4]_i_4_n_0\ : STD_LOGIC;
  signal \cnt[4]_i_5_n_0\ : STD_LOGIC;
  signal \cnt[8]_i_2_n_0\ : STD_LOGIC;
  signal \cnt[8]_i_3_n_0\ : STD_LOGIC;
  signal \cnt[8]_i_4_n_0\ : STD_LOGIC;
  signal \cnt[8]_i_5_n_0\ : STD_LOGIC;
  signal cnt_reg : STD_LOGIC_VECTOR ( 19 downto 0 );
  signal \cnt_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \cnt_reg[0]_i_2_n_1\ : STD_LOGIC;
  signal \cnt_reg[0]_i_2_n_2\ : STD_LOGIC;
  signal \cnt_reg[0]_i_2_n_3\ : STD_LOGIC;
  signal \cnt_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \cnt_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \cnt_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \cnt_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_1\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_2\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \cnt_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \cnt_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \cnt_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \cnt_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \cnt_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_1\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_2\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \NLW_cnt_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
\cnt[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
        port map (
      I0 => \cnt[0]_i_3_n_0\,
      I1 => \cnt[0]_i_4_n_0\,
      I2 => \cnt[0]_i_5_n_0\,
      I3 => \cnt[0]_i_6_n_0\,
      I4 => \cnt[0]_i_7_n_0\,
      O => clear
    );
\cnt[0]_i_10\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(1),
      O => \cnt[0]_i_10_n_0\
    );
\cnt[0]_i_11\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => cnt_reg(0),
      O => \cnt[0]_i_11_n_0\
    );
\cnt[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cnt_reg(18),
      I1 => cnt_reg(14),
      I2 => cnt_reg(17),
      I3 => cnt_reg(9),
      O => \cnt[0]_i_3_n_0\
    );
\cnt[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cnt_reg(15),
      I1 => cnt_reg(12),
      I2 => cnt_reg(10),
      I3 => cnt_reg(11),
      O => \cnt[0]_i_4_n_0\
    );
\cnt[0]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => cnt_reg(13),
      I1 => cnt_reg(19),
      I2 => cnt_reg(16),
      O => \cnt[0]_i_5_n_0\
    );
\cnt[0]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => cnt_reg(1),
      I1 => cnt_reg(3),
      I2 => cnt_reg(2),
      I3 => cnt_reg(0),
      O => \cnt[0]_i_6_n_0\
    );
\cnt[0]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"7FFFFFFF"
    )
        port map (
      I0 => cnt_reg(4),
      I1 => cnt_reg(5),
      I2 => cnt_reg(7),
      I3 => cnt_reg(6),
      I4 => cnt_reg(8),
      O => \cnt[0]_i_7_n_0\
    );
\cnt[0]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(3),
      O => \cnt[0]_i_8_n_0\
    );
\cnt[0]_i_9\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(2),
      O => \cnt[0]_i_9_n_0\
    );
\cnt[12]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(15),
      O => \cnt[12]_i_2_n_0\
    );
\cnt[12]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(14),
      O => \cnt[12]_i_3_n_0\
    );
\cnt[12]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(13),
      O => \cnt[12]_i_4_n_0\
    );
\cnt[12]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(12),
      O => \cnt[12]_i_5_n_0\
    );
\cnt[16]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(19),
      O => \cnt[16]_i_2_n_0\
    );
\cnt[16]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(18),
      O => \cnt[16]_i_3_n_0\
    );
\cnt[16]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(17),
      O => \cnt[16]_i_4_n_0\
    );
\cnt[16]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(16),
      O => \cnt[16]_i_5_n_0\
    );
\cnt[4]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(7),
      O => \cnt[4]_i_2_n_0\
    );
\cnt[4]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(6),
      O => \cnt[4]_i_3_n_0\
    );
\cnt[4]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(5),
      O => \cnt[4]_i_4_n_0\
    );
\cnt[4]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(4),
      O => \cnt[4]_i_5_n_0\
    );
\cnt[8]_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(11),
      O => \cnt[8]_i_2_n_0\
    );
\cnt[8]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(10),
      O => \cnt[8]_i_3_n_0\
    );
\cnt[8]_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(9),
      O => \cnt[8]_i_4_n_0\
    );
\cnt[8]_i_5\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => cnt_reg(8),
      O => \cnt[8]_i_5_n_0\
    );
\cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[0]_i_2_n_7\,
      Q => cnt_reg(0),
      R => clear
    );
\cnt_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \cnt_reg[0]_i_2_n_0\,
      CO(2) => \cnt_reg[0]_i_2_n_1\,
      CO(1) => \cnt_reg[0]_i_2_n_2\,
      CO(0) => \cnt_reg[0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \cnt_reg[0]_i_2_n_4\,
      O(2) => \cnt_reg[0]_i_2_n_5\,
      O(1) => \cnt_reg[0]_i_2_n_6\,
      O(0) => \cnt_reg[0]_i_2_n_7\,
      S(3) => \cnt[0]_i_8_n_0\,
      S(2) => \cnt[0]_i_9_n_0\,
      S(1) => \cnt[0]_i_10_n_0\,
      S(0) => \cnt[0]_i_11_n_0\
    );
\cnt_reg[10]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_5\,
      Q => cnt_reg(10),
      S => clear
    );
\cnt_reg[11]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_4\,
      Q => cnt_reg(11),
      S => clear
    );
\cnt_reg[12]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[12]_i_1_n_7\,
      Q => cnt_reg(12),
      S => clear
    );
\cnt_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cnt_reg[8]_i_1_n_0\,
      CO(3) => \cnt_reg[12]_i_1_n_0\,
      CO(2) => \cnt_reg[12]_i_1_n_1\,
      CO(1) => \cnt_reg[12]_i_1_n_2\,
      CO(0) => \cnt_reg[12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cnt_reg[12]_i_1_n_4\,
      O(2) => \cnt_reg[12]_i_1_n_5\,
      O(1) => \cnt_reg[12]_i_1_n_6\,
      O(0) => \cnt_reg[12]_i_1_n_7\,
      S(3) => \cnt[12]_i_2_n_0\,
      S(2) => \cnt[12]_i_3_n_0\,
      S(1) => \cnt[12]_i_4_n_0\,
      S(0) => \cnt[12]_i_5_n_0\
    );
\cnt_reg[13]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[12]_i_1_n_6\,
      Q => cnt_reg(13),
      S => clear
    );
\cnt_reg[14]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[12]_i_1_n_5\,
      Q => cnt_reg(14),
      S => clear
    );
\cnt_reg[15]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[12]_i_1_n_4\,
      Q => cnt_reg(15),
      S => clear
    );
\cnt_reg[16]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[16]_i_1_n_7\,
      Q => cnt_reg(16),
      S => clear
    );
\cnt_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cnt_reg[12]_i_1_n_0\,
      CO(3) => \NLW_cnt_reg[16]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \cnt_reg[16]_i_1_n_1\,
      CO(1) => \cnt_reg[16]_i_1_n_2\,
      CO(0) => \cnt_reg[16]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cnt_reg[16]_i_1_n_4\,
      O(2) => \cnt_reg[16]_i_1_n_5\,
      O(1) => \cnt_reg[16]_i_1_n_6\,
      O(0) => \cnt_reg[16]_i_1_n_7\,
      S(3) => \cnt[16]_i_2_n_0\,
      S(2) => \cnt[16]_i_3_n_0\,
      S(1) => \cnt[16]_i_4_n_0\,
      S(0) => \cnt[16]_i_5_n_0\
    );
\cnt_reg[17]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[16]_i_1_n_6\,
      Q => cnt_reg(17),
      S => clear
    );
\cnt_reg[18]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[16]_i_1_n_5\,
      Q => cnt_reg(18),
      S => clear
    );
\cnt_reg[19]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[16]_i_1_n_4\,
      Q => cnt_reg(19),
      S => clear
    );
\cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[0]_i_2_n_6\,
      Q => cnt_reg(1),
      R => clear
    );
\cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[0]_i_2_n_5\,
      Q => cnt_reg(2),
      R => clear
    );
\cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[0]_i_2_n_4\,
      Q => cnt_reg(3),
      R => clear
    );
\cnt_reg[4]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_7\,
      Q => cnt_reg(4),
      S => clear
    );
\cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cnt_reg[0]_i_2_n_0\,
      CO(3) => \cnt_reg[4]_i_1_n_0\,
      CO(2) => \cnt_reg[4]_i_1_n_1\,
      CO(1) => \cnt_reg[4]_i_1_n_2\,
      CO(0) => \cnt_reg[4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cnt_reg[4]_i_1_n_4\,
      O(2) => \cnt_reg[4]_i_1_n_5\,
      O(1) => \cnt_reg[4]_i_1_n_6\,
      O(0) => \cnt_reg[4]_i_1_n_7\,
      S(3) => \cnt[4]_i_2_n_0\,
      S(2) => \cnt[4]_i_3_n_0\,
      S(1) => \cnt[4]_i_4_n_0\,
      S(0) => \cnt[4]_i_5_n_0\
    );
\cnt_reg[5]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_6\,
      Q => cnt_reg(5),
      S => clear
    );
\cnt_reg[6]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_5\,
      Q => cnt_reg(6),
      S => clear
    );
\cnt_reg[7]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[4]_i_1_n_4\,
      Q => cnt_reg(7),
      S => clear
    );
\cnt_reg[8]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_7\,
      Q => cnt_reg(8),
      S => clear
    );
\cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \cnt_reg[4]_i_1_n_0\,
      CO(3) => \cnt_reg[8]_i_1_n_0\,
      CO(2) => \cnt_reg[8]_i_1_n_1\,
      CO(1) => \cnt_reg[8]_i_1_n_2\,
      CO(0) => \cnt_reg[8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \cnt_reg[8]_i_1_n_4\,
      O(2) => \cnt_reg[8]_i_1_n_5\,
      O(1) => \cnt_reg[8]_i_1_n_6\,
      O(0) => \cnt_reg[8]_i_1_n_7\,
      S(3) => \cnt[8]_i_2_n_0\,
      S(2) => \cnt[8]_i_3_n_0\,
      S(1) => \cnt[8]_i_4_n_0\,
      S(0) => \cnt[8]_i_5_n_0\
    );
\cnt_reg[9]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_i,
      CE => '1',
      D => \cnt_reg[8]_i_1_n_6\,
      Q => cnt_reg(9),
      S => clear
    );
\rst_n_reg_reg[3]_srl5_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000010000000"
    )
        port map (
      I0 => \cnt[0]_i_3_n_0\,
      I1 => \cnt[0]_i_4_n_0\,
      I2 => cnt_reg(13),
      I3 => cnt_reg(19),
      I4 => cnt_reg(16),
      I5 => \cnt[0]_i_7_n_0\,
      O => \rst_n_reg_reg[4]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity OV_Sensor_ML_0_OV_Sensor_ML is
  port (
    rgb_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    hs_o : out STD_LOGIC;
    vs_o : out STD_LOGIC;
    vid_clk_ce : out STD_LOGIC;
    CLK_i : in STD_LOGIC;
    cmos_href_i : in STD_LOGIC;
    cmos_pclk_i : in STD_LOGIC;
    cmos_vsync_i : in STD_LOGIC;
    cmos_data_i : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of OV_Sensor_ML_0_OV_Sensor_ML : entity is "OV_Sensor_ML";
end OV_Sensor_ML_0_OV_Sensor_ML;

architecture STRUCTURE of OV_Sensor_ML_0_OV_Sensor_ML is
  signal cmos_data_r : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal cmos_href_r : STD_LOGIC;
  signal cmos_vsync_r : STD_LOGIC;
  signal nolabel_line70_n_0 : STD_LOGIC;
begin
\cmos_data_r_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(0),
      Q => cmos_data_r(0),
      R => '0'
    );
\cmos_data_r_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(1),
      Q => cmos_data_r(1),
      R => '0'
    );
\cmos_data_r_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(2),
      Q => cmos_data_r(2),
      R => '0'
    );
\cmos_data_r_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(3),
      Q => cmos_data_r(3),
      R => '0'
    );
\cmos_data_r_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(4),
      Q => cmos_data_r(4),
      R => '0'
    );
\cmos_data_r_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(5),
      Q => cmos_data_r(5),
      R => '0'
    );
\cmos_data_r_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(6),
      Q => cmos_data_r(6),
      R => '0'
    );
\cmos_data_r_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_data_i(7),
      Q => cmos_data_r(7),
      R => '0'
    );
cmos_decode_u0: entity work.OV_Sensor_ML_0_cmos_decode
     port map (
      CLK_i => CLK_i,
      D(0) => cmos_vsync_r,
      Q(7 downto 0) => cmos_data_r(7 downto 0),
      cmos_href_r => cmos_href_r,
      cmos_pclk_i => cmos_pclk_i,
      \cnt_reg[13]\ => nolabel_line70_n_0,
      hs_o => hs_o,
      rgb_o(15 downto 0) => rgb_o(15 downto 0),
      vid_clk_ce => vid_clk_ce,
      vs_o => vs_o
    );
cmos_href_r_reg: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_href_i,
      Q => cmos_href_r,
      R => '0'
    );
cmos_vsync_r_reg: unisim.vcomponents.FDRE
     port map (
      C => cmos_pclk_i,
      CE => '1',
      D => cmos_vsync_i,
      Q => cmos_vsync_r,
      R => '0'
    );
nolabel_line70: entity work.OV_Sensor_ML_0_count_reset_v1
     port map (
      CLK_i => CLK_i,
      \rst_n_reg_reg[4]\ => nolabel_line70_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity OV_Sensor_ML_0 is
  port (
    CLK_i : in STD_LOGIC;
    cmos_vsync_i : in STD_LOGIC;
    cmos_href_i : in STD_LOGIC;
    cmos_pclk_i : in STD_LOGIC;
    cmos_xclk_o : out STD_LOGIC;
    cmos_data_i : in STD_LOGIC_VECTOR ( 7 downto 0 );
    hs_o : out STD_LOGIC;
    vs_o : out STD_LOGIC;
    rgb_o : out STD_LOGIC_VECTOR ( 23 downto 0 );
    vid_clk_ce : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of OV_Sensor_ML_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of OV_Sensor_ML_0 : entity is "OV_Sensor_ML_0,OV_Sensor_ML,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of OV_Sensor_ML_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of OV_Sensor_ML_0 : entity is "OV_Sensor_ML,Vivado 2016.4";
end OV_Sensor_ML_0;

architecture STRUCTURE of OV_Sensor_ML_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^clk_i\ : STD_LOGIC;
  signal \^rgb_o\ : STD_LOGIC_VECTOR ( 23 downto 3 );
begin
  \^clk_i\ <= CLK_i;
  cmos_xclk_o <= \^clk_i\;
  rgb_o(23 downto 19) <= \^rgb_o\(23 downto 19);
  rgb_o(18) <= \<const0>\;
  rgb_o(17) <= \<const0>\;
  rgb_o(16) <= \<const0>\;
  rgb_o(15 downto 10) <= \^rgb_o\(15 downto 10);
  rgb_o(9) <= \<const0>\;
  rgb_o(8) <= \<const0>\;
  rgb_o(7 downto 3) <= \^rgb_o\(7 downto 3);
  rgb_o(2) <= \<const0>\;
  rgb_o(1) <= \<const0>\;
  rgb_o(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.OV_Sensor_ML_0_OV_Sensor_ML
     port map (
      CLK_i => \^clk_i\,
      cmos_data_i(7 downto 0) => cmos_data_i(7 downto 0),
      cmos_href_i => cmos_href_i,
      cmos_pclk_i => cmos_pclk_i,
      cmos_vsync_i => cmos_vsync_i,
      hs_o => hs_o,
      rgb_o(15 downto 11) => \^rgb_o\(23 downto 19),
      rgb_o(10 downto 5) => \^rgb_o\(15 downto 10),
      rgb_o(4 downto 0) => \^rgb_o\(7 downto 3),
      vid_clk_ce => vid_clk_ce,
      vs_o => vs_o
    );
end STRUCTURE;
