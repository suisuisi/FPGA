`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: milinker corperation
// WEB:www.milinker.com
// BBS:www.osrc.cn
// Engineer:sanliuyaoling.
// Create Date:    07:28:50 12/04/2015 
// Design Name:    count_reset_v1
// Module Name:    count_reset_v1
// Project Name: 	 count_reset_v1
// Target Devices: XC6SLX25-FTG256 Mis603
// Tool versions:  ISE14.7
// Description: 	 count_reset_v1
// Revision: 		 V1.0
// Additional Comments: 
//1) _i PIN input  
//2) _o PIN output
//3) _n PIN active low
//4) _dg debug signal 
//5) _r  reg delay
//6) _s state machine
//////////////////////////////////////////////////////////////////////////////
module count_reset_v1#
(
	parameter[19:0]num = 20'hffff0
)(
	input clk_i,
	output rst_o
    );

reg[19:0] cnt = 20'd0;
reg rst_d0;

/*count for clock*/
always@(posedge clk_i)
begin
	cnt <= ( cnt <= num)?( cnt + 20'd1 ):num;
end

/*generate output signal*/
always@(posedge clk_i)
begin
	rst_d0 <= ( cnt >= num)?1'b1:1'b0;
end	

assign rst_o = rst_d0;

endmodule

