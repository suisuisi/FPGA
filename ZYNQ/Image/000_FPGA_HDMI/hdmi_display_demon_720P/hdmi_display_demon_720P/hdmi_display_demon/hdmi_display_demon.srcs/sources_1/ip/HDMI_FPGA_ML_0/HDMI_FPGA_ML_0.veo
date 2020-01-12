// (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: xilinx.com:user:HDMI_FPGA_ML:1.0
// IP Revision: 2

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
HDMI_FPGA_ML_0 your_instance_name (
  .PXLCLK_I(PXLCLK_I),        // input wire PXLCLK_I
  .PXLCLK_5X_I(PXLCLK_5X_I),  // input wire PXLCLK_5X_I
  .LOCKED_I(LOCKED_I),        // input wire LOCKED_I
  .RST_N(RST_N),              // input wire RST_N
  .VGA_HS(VGA_HS),            // input wire VGA_HS
  .VGA_VS(VGA_VS),            // input wire VGA_VS
  .VGA_DE(VGA_DE),            // input wire VGA_DE
  .VGA_RGB(VGA_RGB),          // input wire [23 : 0] VGA_RGB
  .HDMI_CLK_P(HDMI_CLK_P),    // output wire HDMI_CLK_P
  .HDMI_CLK_N(HDMI_CLK_N),    // output wire HDMI_CLK_N
  .HDMI_D2_P(HDMI_D2_P),      // output wire HDMI_D2_P
  .HDMI_D2_N(HDMI_D2_N),      // output wire HDMI_D2_N
  .HDMI_D1_P(HDMI_D1_P),      // output wire HDMI_D1_P
  .HDMI_D1_N(HDMI_D1_N),      // output wire HDMI_D1_N
  .HDMI_D0_P(HDMI_D0_P),      // output wire HDMI_D0_P
  .HDMI_D0_N(HDMI_D0_N)      // output wire HDMI_D0_N
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file HDMI_FPGA_ML_0.v when simulating
// the core, HDMI_FPGA_ML_0. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

