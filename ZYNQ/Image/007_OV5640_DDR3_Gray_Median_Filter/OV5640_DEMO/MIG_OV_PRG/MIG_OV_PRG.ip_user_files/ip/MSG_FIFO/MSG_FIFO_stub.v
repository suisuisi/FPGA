// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sat Oct 19 23:08:00 2019
// Host        : LAPTOP-8E6RLG3I running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               F:/FILE/FPGA/ZYNQ/zynq_7035/TEST/CH04_OV5640_DEMO/OV5640_TS_DATA/MIG_OV_PRG/MIG_OV_PRG.srcs/sources_1/ip/MSG_FIFO/MSG_FIFO_stub.v
// Design      : MSG_FIFO
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ffg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_1,Vivado 2017.4" *)
module MSG_FIFO(clk, din, wr_en, rd_en, dout, full, empty, data_count)
/* synthesis syn_black_box black_box_pad_pin="clk,din[7:0],wr_en,rd_en,dout[7:0],full,empty,data_count[4:0]" */;
  input clk;
  input [7:0]din;
  input wr_en;
  input rd_en;
  output [7:0]dout;
  output full;
  output empty;
  output [4:0]data_count;
endmodule
