// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
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


// IP VLNV: xilinx.com:user:OV_Sensor_ML:1.0
// IP Revision: 2

(* X_CORE_INFO = "OV_Sensor_ML,Vivado 2016.4" *)
(* CHECK_LICENSE_TYPE = "OV_Sensor_ML_0,OV_Sensor_ML,{}" *)
(* CORE_GENERATION_INFO = "OV_Sensor_ML_0,OV_Sensor_ML,{x_ipProduct=Vivado 2016.4,x_ipVendor=xilinx.com,x_ipLibrary=user,x_ipName=OV_Sensor_ML,x_ipVersion=1.0,x_ipCoreRevision=2,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module OV_Sensor_ML_0 (
  CLK_i,
  cmos_vsync_i,
  cmos_href_i,
  cmos_pclk_i,
  cmos_xclk_o,
  cmos_data_i,
  hs_o,
  vs_o,
  rgb_o,
  vid_clk_ce
);

input wire CLK_i;
input wire cmos_vsync_i;
input wire cmos_href_i;
input wire cmos_pclk_i;
output wire cmos_xclk_o;
input wire [7 : 0] cmos_data_i;
output wire hs_o;
output wire vs_o;
output wire [23 : 0] rgb_o;
output wire vid_clk_ce;

  OV_Sensor_ML inst (
    .CLK_i(CLK_i),
    .cmos_vsync_i(cmos_vsync_i),
    .cmos_href_i(cmos_href_i),
    .cmos_pclk_i(cmos_pclk_i),
    .cmos_xclk_o(cmos_xclk_o),
    .cmos_data_i(cmos_data_i),
    .hs_o(hs_o),
    .vs_o(vs_o),
    .rgb_o(rgb_o),
    .vid_clk_ce(vid_clk_ce)
  );
endmodule
