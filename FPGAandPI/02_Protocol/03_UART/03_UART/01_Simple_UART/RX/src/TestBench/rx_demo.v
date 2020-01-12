module rx_demo
(
    input CLOCK, RESET, 
	 input RXD,
	 output TXD
);
     wire DoneU1;
	 wire [7:0]DataU1;
    
    rx_funcmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RESET ),
		  .RXD( RXD ),         // < top
		  .iCall( isRX ),     // < core
		  .oDone( DoneU1 ),    // > core
		  .oData( DataU1 )     // > core
	 );
	 
	 parameter B115K2 = 9'd434, TXFUNC = 5'd16;
	 
	 reg [4:0]i,Go;
	 reg [8:0]C1;
	 reg [10:0]D1;
	 reg rTXD;
	 reg isRX;
	 
	 always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin 
				    i <= 5'd0;
					 C1 <= 9'd0;
					 D1 <= 11'd0;
					 rTXD <= 1'b1;
					 isRX<= 1'b0;
				end
		  else
		      case( i )
				
				    0:
					 if( DoneU1 ) begin isRX <= 1'b0; D1 <= { 2'b11,DataU1,1'b0 }; i <= TXFUNC; Go <= 5'd0; end
					 else isRX <= 1'b1; 
					 
					 /**********/
					 
					 16,17,18,19,20,21,22,23,24,25,26:
					 if( C1 == B115K2 -1 ) begin C1 <= 8'd0; i <= i + 1'b1; end
					 else begin rTXD <= D1[i - 16]; C1 <= C1 + 1'b1; end
					 
					 27:
					 i <= Go;
					
				endcase
				
	assign TXD = rTXD;
		      			 
endmodule
