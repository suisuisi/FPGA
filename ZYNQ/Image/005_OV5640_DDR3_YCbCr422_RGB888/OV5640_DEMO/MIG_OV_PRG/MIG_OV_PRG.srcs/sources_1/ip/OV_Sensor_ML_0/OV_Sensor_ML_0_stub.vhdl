-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
-- Date        : Wed Oct 04 22:45:04 2017
-- Host        : DESKTOP-NK9IJDR running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/MIA701SRC/S02_CH11/S02_CH10_640_480_DDR_HDMI_3/MIG_OV_PRG/MIG_OV_PRG.srcs/sources_1/ip/OV_Sensor_ML_0/OV_Sensor_ML_0_stub.vhdl
-- Design      : OV_Sensor_ML_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tfgg484-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OV_Sensor_ML_0 is
  Port ( 
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

end OV_Sensor_ML_0;

architecture stub of OV_Sensor_ML_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK_i,cmos_vsync_i,cmos_href_i,cmos_pclk_i,cmos_xclk_o,cmos_data_i[7:0],hs_o,vs_o,rgb_o[23:0],vid_clk_ce";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "OV_Sensor_ML,Vivado 2016.4";
begin
end;
