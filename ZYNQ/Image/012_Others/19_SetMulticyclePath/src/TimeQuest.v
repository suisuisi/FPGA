`timescale 1ns/1ns
module TimeQuest
(
	input				clk,
	input				rst_n,
	input		[31:0]	sig,
	output reg 	[31:0]	reg1,
	output reg 	[31:0]	reg2
);
	always @(posedge clk or negedge rst_n)
		if(!rst_n) reg1 <= 32'd0;
		else reg1 <= sig + 1'b1;

	wire[31:0] temp = reg1 / 32'd99995;

	always @(posedge clk or negedge rst_n)
		if(!rst_n) reg2 <= 32'd0;
		else reg2 <= temp + reg1;

endmodule
