module tx_demo
(
    input CLOCK, RESET,
	 output TXD
);
    wire DoneU1;

    tx_funcmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RESET ),
		  .TXD( TXD ),
		  .iCall( isTX ),
		  .oDone( DoneU1 ),
	     .iData( D1 )
	 );

     reg [3:0]i;
	 reg [7:0]D1;
	 reg isTX;
	 
	 always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin
				     i <= 4'd0;
					 D1 <= 8'd0;
					 isTX <= 1'b0;
				end
		  else
		      case( i )
				
				    0:
					 if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
					 else begin isTX <= 1'b1; D1 <= 8'hA1; end
					 
					 1:
					 if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
					 else begin isTX <= 1'b1; D1 <= 8'hA2; end
					 
					 2:
					 if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
					 else begin isTX <= 1'b1; D1 <= 8'hA3; end
					 
					 3: // Stop
					 i <= i;
				
				endcase

endmodule
