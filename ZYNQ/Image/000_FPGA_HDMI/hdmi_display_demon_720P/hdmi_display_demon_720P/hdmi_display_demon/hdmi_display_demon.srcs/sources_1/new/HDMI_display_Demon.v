//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-25 21:58:59
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-12-11 20:26:10
//# Description: 
//# @Modification History: 2019-10-09 22:17:36
//# Date                By             Version             Change Description: 
//# ========================================================================= #
//# 2019-10-09 22:17:36
//# ========================================================================= #
//# |                                                                       | #
//# |                                OpenFPGA                               | #
//****************************************************************************//

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module HDMI_display_Demon(
    input       clk_100M,
    input       KEY,
    
    output HDMI1_CLK_P,
    output HDMI1_CLK_N,
    output HDMI1_D2_P,
    output HDMI1_D2_N,
    output HDMI1_D1_P,
    output HDMI1_D1_N,
    output HDMI1_D0_P,
    output HDMI1_D0_N,
    
    output HDMI2_CLK_P,
    output HDMI2_CLK_N,
    output HDMI2_D2_P,
    output HDMI2_D2_N,
    output HDMI2_D1_P,
    output HDMI2_D1_N,
    output HDMI2_D0_P,
    output HDMI2_D0_N,
    
    output  [3:0]   LED
);

wire pixclk;
wire[7:0]   R,G,B;
wire HS,VS,DE;
assign VGA_HS   =   HS;
assign VGA_VS   =   VS;
assign  VGA_D   =   {R[7:4],G[7:2],B[7:4]};
hdmi_data_gen u0_hdmi_data_gen
(
    .pix_clk            (pixclk),
    .turn_mode          (KEY),
    .VGA_R              (R),
    .VGA_G              (G),
    .VGA_B              (B),
    .VGA_HS             (HS),
    .VGA_VS             (VS),
    .VGA_DE             (DE),
    .mode                (LED)
);

wire pixclk_X5;
//wire i2c_clk;
wire lock;
wire[23:0]  RGB;
assign RGB={R,G,B};
hdmi_display_0  u1_hdmi_display_0
(
   // .i2c_clk            (i2c_clk),
    .PXLCLK_I            (pixclk),
    .PXLCLK_5X_I         (pixclk_X5),
    .LOCKED_I           (lock),
    .RST_N              (lock),
    .VGA_RGB             (RGB),
    .VGA_HS           (HS),
    .VGA_VS           (VS),
    .VGA_DE              (DE),
    .HDMI_CLK_P           (HDMI1_CLK_P),
    .HDMI_CLK_N         (HDMI1_CLK_N),
    .HDMI_D2_P         (HDMI1_D2_P),
    .HDMI_D2_N         (HDMI1_D2_N),
    .HDMI_D1_P         (HDMI1_D1_P),
    .HDMI_D1_N         (HDMI1_D1_N),
    .HDMI_D0_P         (HDMI1_D0_P),
    .HDMI_D0_N         (HDMI1_D0_N)
);

hdmi_display_0  u2_hdmi_display_1
(
   // .i2c_clk            (i2c_clk),
    .PXLCLK_I            (pixclk),
    .PXLCLK_5X_I         (pixclk_X5),
    .LOCKED_I           (lock),
    .RST_N              (lock),
    .VGA_RGB             (RGB),
    .VGA_HS           (HS),
    .VGA_VS           (VS),
    .VGA_DE              (DE),
    .HDMI_CLK_P        (HDMI2_CLK_P),
    .HDMI_CLK_N        (HDMI2_CLK_N),
    .HDMI_D2_P         (HDMI2_D2_P),
    .HDMI_D2_N         (HDMI2_D2_N),
    .HDMI_D1_P         (HDMI2_D1_P),
    .HDMI_D1_N         (HDMI2_D1_N),
    .HDMI_D0_P         (HDMI2_D0_P),
    .HDMI_D0_N         (HDMI2_D0_N)
);

clk_wiz_0   u3_clk
(
    .clk_in1            (clk_100M),
    .resetn             (1'b1),
    .clk_out1           (pixclk),
    .clk_out2           (pixclk_X5),
   // .clk_out3           (i2c_clk),
    .locked             (lock)
);
endmodule
