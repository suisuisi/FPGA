module savemod_demo
(
    input CLOCK,RESET,
	 output [7:0]DIG,
	 output [5:0]SEL
);   
	 reg [3:0]i;
	 reg [3:0]D1,D2;  // D1 for Address, D2 for Data
	 reg isEn;
	 
    always @ ( posedge CLOCK or negedge RESET ) // Core
	     if( !RESET )
		      begin
				    i <= 4'd0;
					 { D1,D2 } <= 8'd0;
					 isEn <= 1'b0;
				end
		  else
		      case( i )
				    
					 0:
					 begin isEn <= 1'b1; D1 <= 4'd0; D2 <= 4'hA; i <= i + 1'b1; end
				
			    	 1:
					 begin isEn <= 1'b1; D1 <= 4'd0; D2 <= 4'hB; i <= i + 1'b1; end
					 
					 2:
					 begin isEn <= 1'b1; D1 <= 4'd0; D2 <= 4'hC; i <= i + 1'b1; end
					 
					 3:
					 begin isEn <= 1'b1; D1 <= 4'd0; D2 <= 4'hD; i <= i + 1'b1; end
					 
					 4:
					 begin isEn <= 1'b1; D1 <= 4'd0; D2 <= 4'hE; i <= i + 1'b1; end
					 
					 5:
					 begin isEn <= 1'b1; D1 <= 4'd0; D2 <= 4'hF; i <= i + 1'b1; end
					 
					 6:
					 begin isEn <= 1'b1; D1 <= 4'd0; D2 <= 4'h0; i <= i + 1'b1; end
					 
					 7:
					 begin isEn <= 1'b0; i <= i; end
				
				endcase
				
	 wire [23:0]DataU1;
				
    pushshift_savemod U1
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RESET ),
		  .iEn( isEn ),  // < Core
		  .iAddr( D1 ),  // < Core
		  .iData( D2 ),  // < Core
		  .oData( DataU1 ) // > U2
	 );
	 
	 smg_basemod U2
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RESET ),
		  .DIG( DIG ),     // top
		  .SEL( SEL ),     // top
		  .iData( DataU1 )  // < U1
	 );

endmodule
