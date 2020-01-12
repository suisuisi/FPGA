`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date:    11:25:28 01/05/2015 
// Design Name: 
// Module Name:    hdmi_display 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module hdmi_display(
    input i2c_clk,
    input vga_clk,
    input vga_clk_90,
    
    input [23:0]rgb_in,
    input hsync_in,
    input vsync_in,
    input de_in,
    
    output hdmi_clk,
    output hdmi_hsync,
    output hdmi_vsync,
    output [15:0] hdmi_d,
    output hdmi_de,
    output hdmi_scl,
    inout hdmi_sda
    );  
	
	//  -- signals from the VGA generator
	
   wire [7:0] r_in;
   wire [7:0] g_in;
   wire [7:0] b_in;
   
   assign r_in = rgb_in[23:16];
   assign g_in = rgb_in[15:8];
   assign b_in = rgb_in[7:0];
  /* wire hsync_in;
   wire hvsync_in;
   wire de_in;*/
 //  -- Signals from the pixel pair convertor
   wire [8:0] c422_r1;
   wire [8:0] c422_g1;
   wire [8:0] c422_b1;
   wire [8:0] c422_r2;
   wire [8:0] c422_g2;
   wire [8:0] c422_b2;
   wire c422_pair_start;
   wire c422_hsync;
   wire c422_vsync;
   wire c422_de;
	
convert_444_422 my_convert_444_422 
(
//input signal
        .clk(vga_clk),   
        .r_in(r_in),
        .g_in(g_in),
        .b_in(b_in),
        .hsync_in(hsync_in),
        .vsync_in(vsync_in),
        .de_in(de_in),
 //output signal     
        .r1_out(c422_r1),
        .g1_out(c422_g1),
        .b1_out(c422_b1),
        .r2_out(c422_r2),
        .g2_out(c422_g2),
        .b2_out(c422_b2),
        .pair_start_out(c422_pair_start),
        .hsync_out(c422_hsync),
        .vsync_out(c422_vsync),
        .de_out(c422_de)
);
 //  -- Signals from the colour space convertor
   wire [7:0] csc_y;
   wire [7:0] csc_c;
   wire csc_hsync;
   wire csc_vsync;
   wire csc_de;
colour_space_conversion my_colour_space_conversion
(
//input signal
    .clk(vga_clk),
    .r1_in(c422_r1),
    .g1_in(c422_g1),
    .b1_in(c422_b1),
    .r2_in(c422_r2),
    .g2_in(c422_g2),
    .b2_in(c422_b2),
    .pair_start_in(c422_pair_start),
    .vsync_in(c422_vsync),
    .hsync_in(c422_hsync),
    .de_in(c422_de),
	 
//output signal
    .y_out(csc_y),
    .c_out(csc_c),
    .hsync_out(csc_hsync),
    .vsync_out(csc_vsync),
    .de_out(csc_de) 
   );
hdmi_ddr_output my_hdmi_ddr_output
(
//input signal
        .clk(vga_clk),
        .clk90(vga_clk_90),
        .y(csc_y),
        .c(csc_c),                             //   .c(128),    gray picture
        .hsync_in(csc_hsync),
        .vsync_in(csc_vsync),
        .de_in(csc_de),
//output signal		  
        .hdmi_clk(hdmi_clk),
        .hdmi_hsync(hdmi_hsync),
        .hdmi_vsync(hdmi_vsync),
        .hdmi_d(hdmi_d),
        .hdmi_de(hdmi_de)
        );     
sccb  my_sccb(
            .clk(i2c_clk),    
            .sccb_sclk(hdmi_scl),
            .sccb_data(hdmi_sda)
        );    
endmodule
