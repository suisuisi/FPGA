`timescale 1ns/1ps
module write_tb;
reg clk_1m;
reg rst_n;
reg write_data_start;

wire [3:0] spi_out;
wire write_done;

oled_module u_oled_module(
		
		.clk_1m(clk_1m),
		.rst_n(rst_n),
		.spi_out(spi_out),
		.res_oled(res_oled)
		);
		
parameter PERIOD = 1000;
initial
begin
	clk_1m = 0 ;
	forever
	#(PERIOD/2) clk_1m = ~ clk_1m;
end

initial
begin
	rst_n = 0;
	#100 rst_n = 1;
end
/*
initial
begin
	write_data_start = 1;
end
*/
endmodule

