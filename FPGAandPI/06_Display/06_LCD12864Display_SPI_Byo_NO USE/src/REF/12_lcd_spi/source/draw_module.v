module draw_module
(
    CLK, RSTn,
	 Start_Sig,
	 SPI_Out,
	 Done_Sig
);

    input CLK; 
	 input RSTn;
	 input Start_Sig;
	 output [3:0]SPI_Out;
	 output Done_Sig;
	 
	 /****************************/
	 
	 wire SPI_Start_Sig;
	 wire [9:0]SPI_Data;
	 wire [9:0]Rom_Addr;
	 
	 draw_control_module U1
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( Start_Sig ),         // input - from top
		  .Draw_Data( Draw_Data ),         // input - from U2
		  .SPI_Done_Sig( SPI_Done_Sig ),   // input - from U3
		  .SPI_Start_Sig( SPI_Start_Sig ), // output - to U3
		  .SPI_Data( SPI_Data ),  // output - to U3      
		  .Rom_Addr( Rom_Addr ),  // output - to U2
		  .Done_Sig( Done_Sig )   // output - to top 
	 );
	 
	 /**************************/
	 
	 wire [7:0]Draw_Data;
	 
	 pika_rom_module U2
	 (
	     .clock( CLK ),
		  .address( Rom_Addr ),    // input - from U1
		  .q( Draw_Data )          // output - to U1
	 );
	 
	 /**************************/
	 
	 wire SPI_Done_Sig;
	 
	 spi_write_module U3
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( SPI_Start_Sig ),  // input - from U1
		  .SPI_Data( SPI_Data ),        // input - from U1
		  .Done_Sig( SPI_Done_Sig ),    // output - to U1
		  .SPI_Out( SPI_Out )           // output - to tp[
	 );
	 
	 /**************************/
	 
endmodule
