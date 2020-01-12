// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Sat Jul 22 14:09:16 2017
// Host        : LB-201704111542 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               f:/A7_Demo/S01_CH02_HDMI/HDMI_Display_Demon/HDMI_Display_Demon.srcs/sources_1/ip/HDMI_FPGA_ML_A7_0/HDMI_FPGA_ML_A7_0_stub.v
// Design      : HDMI_FPGA_ML_A7_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "HDMI_FPGA_ML_A7,Vivado 2016.4" *)
module HDMI_FPGA_ML_A7_0(PXLCLK_I, PXLCLK_5X_I, LOCKED_I, RST_N, VGA_HS, 
  VGA_VS, VGA_DE, VGA_RGB, HDMI_CLK_P, HDMI_CLK_N, HDMI_D2_P, HDMI_D2_N, HDMI_D1_P, HDMI_D1_N, 
  HDMI_D0_P, HDMI_D0_N)
/* synthesis syn_black_box black_box_pad_pin="PXLCLK_I,PXLCLK_5X_I,LOCKED_I,RST_N,VGA_HS,VGA_VS,VGA_DE,VGA_RGB[23:0],HDMI_CLK_P,HDMI_CLK_N,HDMI_D2_P,HDMI_D2_N,HDMI_D1_P,HDMI_D1_N,HDMI_D0_P,HDMI_D0_N" */;
  input PXLCLK_I;
  input PXLCLK_5X_I;
  input LOCKED_I;
  input RST_N;
  input VGA_HS;
  input VGA_VS;
  input VGA_DE;
  input [23:0]VGA_RGB;
  output HDMI_CLK_P;
  output HDMI_CLK_N;
  output HDMI_D2_P;
  output HDMI_D2_N;
  output HDMI_D1_P;
  output HDMI_D1_N;
  output HDMI_D0_P;
  output HDMI_D0_N;
endmodule
