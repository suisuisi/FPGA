module ps2mouse_basemod
(
     input CLOCK, RST_n,
	 inout PS2_CLK, PS2_DAT,
	 output oTrig,
	 output [31:0]oData
);
    wire [1:0]EnU1;

     ps2_init_funcmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .PS2_CLK( PS2_CLK ), // < top
		  .PS2_DAT( PS2_DAT ), // < top
		  .oEn( EnU1 ) // > U2
	 );
	 
	  ps2_read_funcmod U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .PS2_CLK( PS2_CLK ), // < top
		  .PS2_DAT( PS2_DAT ), // < top
		  .iEn( EnU1 ),      // < U1
		  .oTrig( oTrig ),  // > top
		  .oData( oData )  // > top
	 );
		 		     
endmodule