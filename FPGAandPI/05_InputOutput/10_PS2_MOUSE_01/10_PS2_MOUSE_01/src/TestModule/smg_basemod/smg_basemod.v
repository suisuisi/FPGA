module smg_basemod
(
     input CLOCK, RST_n,
	 input [23:0]iData,
	 output [7:0]SMG_Data,
	 output [5:0]Scan_Sig
); 
    wire [9:0]DataU1;

    smg_funcmod U1
    (
	      .CLOCK( CLOCK ),
		  .RESET( RST_n ),
	      .iData( iData ), // < top
		  .oData( DataU1 )  // > U2
	 );
	 
	 assign Scan_Sig = DataU1[5:0];
	 
	 smg_encode_immdmod U2
	 (
		  .iData( DataU1[9:6] ),  // < U1
		  .oData( SMG_Data )        // > top
	 );
	 
endmodule
