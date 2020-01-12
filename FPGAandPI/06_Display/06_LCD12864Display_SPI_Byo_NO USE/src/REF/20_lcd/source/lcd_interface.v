module lcd_interface
(
    input CLK,
	 input RSTn,
	 
	 input Write_En_Sig,
	 input [9:0]Write_Addr_Sig,
	 input [7:0]Write_Data,
	 
	 output [3:0]SPI_Out // [3]CS [2]A0 [1]SCLK [0]SDA
);

    /********************************/
	 
	 wire [7:0]Read_Data;
	 
	 lcd_ram_module U1
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Write_En_Sig( Write_En_Sig ),       // input - from top
		  .Write_Addr_Sig( Write_Addr_Sig ),   // input - from top
		  .Write_Data( Write_Data ),           // input - from top
		  .Read_Addr_Sig( Read_Addr_Sig ),     // input - from U2
		  .Read_Data( Read_Data )              // output - to U2
	 );
	 
	 /*********************************/
	 
	 wire [9:0]Read_Addr_Sig;
	 wire SPI_Start_Sig;
	 wire [9:0]SPI_Data;
	 
	 lcd_control_module U2
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Read_Data( Read_Data ),           // input - from U1
		  .Read_Addr_Sig( Read_Addr_Sig ),   // output - to U1
		  .SPI_Done_Sig( SPI_Done_Sig ),     // input - from U3
		  .SPI_Start_Sig( SPI_Start_Sig ),   // output - to U3
		  .SPI_Data( SPI_Data )              // output - to U3
	 );
	 
	 /************************************/
	 
	 wire SPI_Done_Sig;
	 
	 spi_write_module U3
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( SPI_Start_Sig ),   // input - from U2
		  .SPI_Data( SPI_Data ),         // input - from U2
		  .Done_Sig( SPI_Done_Sig ),     // output - to U2
		  .SPI_Out( SPI_Out )            // output - to top
	 );
	 
	 /************************************/

endmodule
