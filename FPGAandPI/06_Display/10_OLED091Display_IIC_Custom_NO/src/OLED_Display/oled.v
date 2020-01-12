module oled(
  input CLOCK,
  input RST_n,
  output reg OLED_SCL,
  inout OLED_SDA
);

wire init_start_sig;
wire write_start_sig;
wire init_done_sig;
wire write_done_sig;
wire  init_OLED_SCL;
wire  write_OLED_SCL;
//wire [9:0] write_spi_out;

//wire CLOCK;
//wire RST_n;
//PLL u_PLL(
//		.inclk0(CLK_50M),
//		.c0(CLOCK),
//		.locked(RST_n)
//		);

oled_control_module u_oled_control_module(
                                      .CLOCK(CLOCK),
                                      .RST_n(RST_n),
                                      .init_done_sig(init_done_sig),
                                      .write_done_sig(write_done_sig),
                                      .init_start_sig(init_start_sig),
                                      .write_start_sig(write_start_sig)
                                      );

init_module u_init_module(
                        .CLOCK(CLOCK),
                        //.RST_n(RST_n),
                        .initial_start(init_start_sig),
                        .oDone(init_done_sig),
                        .OLED_SCL(init_OLED_SCL),
                        .OLED_SDA(OLED_SDA)
                        );
                  
write_data_module u_write_data_module(
                                    .CLOCK(CLOCK),
                                    //.RST_n(RST_n),
                                    .write_data_start(write_start_sig),
                                    .write_done(write_done_sig),
                                    .OLED_SCL(write_OLED_SCL),
                                    .OLED_SDA(OLED_SDA)
                                    );
//reg  OLED_SCL;
always @(*)
begin
  if(init_start_sig) 
    OLED_SCL = init_OLED_SCL;
  else
    if(write_start_sig)
     OLED_SCL = write_OLED_SCL;
    else
      OLED_SCL <= 1'bx;
end                                  

endmodule           