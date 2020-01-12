`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/19 16:19:31
// Design Name: 
// Module Name: HDMI_display_Demon
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HDMI_display_Demon(
    input       clk_50M,
    input       KEY,
    
    output      HDMI1_CLK_P,
    output      HDMI1_CLK_N,
    output      HDMI1_D2_P,
    output      HDMI1_D2_N,
    output      HDMI1_D1_P,
    output      HDMI1_D1_N,
    output      HDMI1_D0_P,
    output      HDMI1_D0_N,
    
    output      HDMI2_CLK_P,
    output      HDMI2_CLK_N,
    output      HDMI2_D2_P,
    output      HDMI2_D2_N,
    output      HDMI2_D1_P,
    output      HDMI2_D1_N,
    output      HDMI2_D0_P,
    output      HDMI2_D0_N,
    output  [3:0]   LED
);

wire pixclk;
wire[7:0]   R,G,B;
wire HS,VS,DE;
hdmi_data_gen u_hdmi_data_gen
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

wire serclk;
wire lock;
wire[23:0]  RGB;
assign RGB={R,G,B};
HDMI_FPGA_ML_A7_0 u_HDMI1
(
    .PXLCLK_I           (pixclk),
    .PXLCLK_5X_I        (serclk),
    .LOCKED_I           (lock),
    .RST_N              (1'b1),
    .VGA_HS             (HS),
    .VGA_VS             (VS),
    .VGA_DE             (DE),
    .VGA_RGB            (RGB),
    .HDMI_CLK_P         (HDMI1_CLK_P),
    .HDMI_CLK_N         (HDMI1_CLK_N),
    .HDMI_D2_P          (HDMI1_D2_P),
    .HDMI_D2_N          (HDMI1_D2_N),
    .HDMI_D1_P          (HDMI1_D1_P),
    .HDMI_D1_N          (HDMI1_D1_N),
    .HDMI_D0_P          (HDMI1_D0_P),
    .HDMI_D0_N          (HDMI1_D0_N)
); 

HDMI_FPGA_ML_A7_0 u_HDMI2
(
    .PXLCLK_I           (pixclk),
    .PXLCLK_5X_I        (serclk),
    .LOCKED_I           (lock),
    .RST_N              (1'b1),
    .VGA_HS             (HS),
    .VGA_VS             (VS),
    .VGA_DE             (DE),
    .VGA_RGB            (RGB),
    .HDMI_CLK_P         (HDMI2_CLK_P),
    .HDMI_CLK_N         (HDMI2_CLK_N),
    .HDMI_D2_P          (HDMI2_D2_P),
    .HDMI_D2_N          (HDMI2_D2_N),
    .HDMI_D1_P          (HDMI2_D1_P),
    .HDMI_D1_N          (HDMI2_D1_N),
    .HDMI_D0_P          (HDMI2_D0_P),
    .HDMI_D0_N          (HDMI2_D0_N)
);


 clk_wiz_hdmi clk_wiz_hdmi_inst
   (
    .clk_out1(pixclk),     // output clk_out1
    .clk_out2(serclk),     // output clk_out2
    .reset(1'b0),
    .locked(lock),       // output locked
    .clk_in1(clk_50M)
    );      // input clk_in1

endmodule

