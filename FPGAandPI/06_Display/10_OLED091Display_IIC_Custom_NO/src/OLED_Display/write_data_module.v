module write_data_module(
  input CLOCK,
//  input RST_n,
  input write_data_start,
  
  output OLED_SCL,
  inout OLED_SDA,

  output write_done
);

wire DoneU2;
wire [1:0]CallU2;

wire clk_1m;

wire sys_rst_n;
assign sys_rst_n = RST_n;
PLL u_PLL(
		.inclk0(CLOCK),
		.c0(clk_1m),
		.locked(sys_rst_n)
		);


wire [9:0]rom_addr;
wire [7:0]rom_data;
wire [7:0]AddrU1, DataU1;


ROM u0_ROM(
		.clock(clk_1m),
		.address(rom_addr),
		.q(rom_data)
		);

write_data u1_write_data(
                .CLOCK(clk_1m),
                .RST_n(sys_rst_n),
                .write_data_start(write_data_start),
                .iDone(DoneU2),
				        .rom_data(rom_data),
				
                .oCall(CallU2),
                .write_done(write_done),
				        .oAddr(AddrU1),
                .oData(DataU1),
				        .rom_addr(rom_addr)
              );
iic u2_iic
   (
       .CLOCK( CLOCK ),
      .RST_n( RST_n ),
      .SCL( OLED_SCL ),   // > top
      .SDA( OLED_SDA ),         // <> top
      .iCall( CallU2 ),            // < U1
      .oDone( DoneU2 ),              // > U1
      .iAddr( AddrU1 ),              // > U1
      .iData( DataU1 ),              // > U1
      .oData(  )                // > top
   );

endmodule


