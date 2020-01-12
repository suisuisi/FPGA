module lcd_module
(
    CLK, RSTn,
	 SPI_Out
);

    input CLK;
	 input RSTn;
	 output [3:0]SPI_Out;
	 
	 /******************************/
	 
	 wire Init_Start_Sig;
	 wire Draw_Start_Sig;
	 
	 lcd_control_module U1
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Init_Done_Sig( Init_Done_Sig ),    // input - from U2
		  .Draw_Done_Sig( Draw_Done_Sig ),    // input - from U3
		  .Init_Start_Sig( Init_Start_Sig ),  // output - to U2
		  .Draw_Start_Sig( Draw_Start_Sig )   // output - to U3
  	 );

	 /********************************/
	 
	 wire Init_Done_Sig;
	 wire [3:0]Init_SPI_Out;
	 
	 initial_module U2
	 (
	     .CLK( CLK ),
        .RSTn( RSTn ),
        .Start_Sig( Init_Start_Sig ),    // input - from U1
        .Done_Sig( Init_Done_Sig ),      // output - to U1
        .SPI_Out( Init_SPI_Out )		     // output - to selector
	 );
	 
	 /********************************/
	 
	 wire Draw_Done_Sig;
	 wire [3:0]Draw_SPI_Out;
	 
	 draw_module U3
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Start_Sig( Draw_Start_Sig ),   // input - from U1
		  .Done_Sig( Draw_Done_Sig ),     // output - to U1
		  .SPI_Out( Draw_SPI_Out )          // output - to selector
	 );
	 
	 /********************************/
	 
	 reg [3:0]SPI_Out;
	 
	 always @ ( * )
	     if( Init_Start_Sig ) SPI_Out = Init_SPI_Out;      // drive by U2
		  else if( Draw_Start_Sig ) SPI_Out = Draw_SPI_Out; // drive by U3
		  else SPI_Out <= 3'bx;
		  
	 /********************************/
	 
endmodule
