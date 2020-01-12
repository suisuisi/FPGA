module init_module (
	input clk_1m,
	input RST_n,
	
	input initial_start,
	
	output [3:0] spi_out,
	output initial_done,
	output res_oled
	
);

wire sys_RST_n;
wire spi_write_start;
wire spi_write_done;
wire [9:0] data_bus;

assign sys_RST_n = RST_n;

initial_control u_init(
						.clk_1m(clk_1m),
						.RST_n(sys_RST_n),
						.initial_start(initial_start),
						.spi_write_done(spi_write_done),
						.spi_write_start(spi_write_start),
						.spi_data(data_bus),
						.initial_done(initial_done),
						.res_oled(res_oled)			
					);
					
spi_write u_spi(
					.clk_1m(clk_1m),
					.RST_n(sys_RST_n),
					.spi_write_start(spi_write_start),
					.spi_data(data_bus),
					.spi_write_done(spi_write_done),
					.spi_out(spi_out)
					);
endmodule

