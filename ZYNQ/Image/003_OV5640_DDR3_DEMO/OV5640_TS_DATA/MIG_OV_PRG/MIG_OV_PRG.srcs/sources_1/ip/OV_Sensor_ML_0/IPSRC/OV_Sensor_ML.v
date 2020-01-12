`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: milinker
// Engineer:tangjinyuan 
// 
// Create Date:    15:54:59 11/21/2015 
// Design Name: 
// Module Name:    OV7725_IP_ML
// Project Name: OV7725_IP_ML
// Target Devices: ZYNQ
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module OV_Sensor_ML(
    input CLK_i,
//---------------------------- CMOS sensor hardware interface --------------------------/
	input		cmos_vsync_i,	//cmos vsync
	input		cmos_href_i,	//cmos hsync refrence
	input		cmos_pclk_i,	//cmos pxiel clock
	output		cmos_xclk_o,	//cmos externl clock
	input[7:0]	cmos_data_i,	//cmos data
	output hs_o,//hs signal.
    output vs_o,//vs signal.
   // output de_o,//data enable.
    output [23:0] rgb_o,//data output,
    output vid_clk_ce
);
//----------------------视频输出解码模块---------------------------//
wire  [15:0]rgb_o_r;
//assign rgb_o = {rgb_o_r[4:0]   ,3'd0 ,rgb_o_r[10:5]     ,2'd0,rgb_o_r[15:11],3'd0};
assign rgb_o = {rgb_o_r[15:11],3'd0 ,rgb_o_r[10:5] ,2'd0,rgb_o_r[4:0],3'd0};
reg [7:0]cmos_data_r;
reg cmos_href_r;
reg cmos_vsync_r;

always@(posedge cmos_pclk_i)
begin
   cmos_data_r <= cmos_data_i;
   cmos_href_r <= cmos_href_i;
   cmos_vsync_r<= cmos_vsync_i;
end 
//assign rgb_o = 24'b11111111_00000000_11111111;
cmos_decode cmos_decode_u0(
	//system signal.
	.cmos_clk_i(CLK_i),//cmos senseor clock.
	.rst_n_i(RESETn_i2c),//system reset.active low.
	//cmos sensor hardware interface.
	.cmos_pclk_i(cmos_pclk_i),//(cmos_pclk),//input pixel clock.
	.cmos_href_i(cmos_href_r),//(cmos_href),//input pixel hs signal.
	.cmos_vsync_i(cmos_vsync_r),//(cmos_vsync),//input pixel vs signal.
	.cmos_data_i(cmos_data_r),//(cmos_data),//data.
	.cmos_xclk_o(cmos_xclk_o),//(cmos_xclk),//output clock to cmos sensor.
	//user interface.
	.hs_o(hs_o),//hs signal.
	.vs_o(vs_o),//vs signal.
//	.de_o(de_o),//data enable.
	.rgb565_o(rgb_o_r),//data output
	.vid_clk_ce(vid_clk_ce)
    );
    
count_reset_v1#(
        .num(20'hffff0)
    )(
        .clk_i(CLK_i),
        .rst_o(RESETn_i2c)
    );    
		
endmodule
