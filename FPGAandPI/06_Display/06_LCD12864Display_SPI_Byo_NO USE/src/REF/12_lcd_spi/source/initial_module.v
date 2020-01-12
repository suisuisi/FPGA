module initial_module
(
    CLK, RSTn,
	 Start_Sig,
	 Done_Sig,
	 SPI_Out
);

    input CLK;
	 input RSTn;
	 input Start_Sig;
	 output Done_Sig;
	 output [3:0]SPI_Out; // [3]CS [2]A0 [1]CLK [0]DO

	 /*******************************/
	 
	 wire SPI_Start_Sig;
	 wire [9:0]SPI_Data;
	 
	 initial_control_module U1
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( Start_Sig ),          // input - from top
		  .SPI_Done_Sig( SPI_Done_Sig ),    // input - from U2
		  .SPI_Start_Sig( SPI_Start_Sig ),  // output - to U2
		  .SPI_Data( SPI_Data ),           // output - to U2
		  .Done_Sig( Done_Sig )             // output - to top
	 );
	 
	 /********************************/
	 
	 wire SPI_Done_Sig;
	 
	 spi_write_module U2
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( SPI_Start_Sig ),    // input - from U1
		  .SPI_Data( SPI_Data ),          // input - from U1
		  .Done_Sig( SPI_Done_Sig ),  // output - to U1
		  .SPI_Out( SPI_Out )             // output - to top
	 );
	 
	 /***********************************/


endmodule
