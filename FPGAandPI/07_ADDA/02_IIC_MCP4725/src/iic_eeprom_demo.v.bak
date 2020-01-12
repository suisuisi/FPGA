module iic_demo
(
    input CLOCK, RESET,
	 output SCL,
	 inout SDA,
	 output [7:0]DIG,
	 output [5:0]SEL
);
    wire [7:0]DataU1;
	 wire DoneU1;

    iic_savemod U1
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RESET ),
		  .SCL( SCL ),         // > top
		  .SDA( SDA ),         // <> top
		  .iCall( isCall ),  // < core
		  .oDone( DoneU1 ),    // > core
		  .iAddr( D1 ),        // < core
		  .iData( D2 ),        // < core
		  .oData( DataU1 )     // > core
	 );
	 
	 smg_basemod U2
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RESET ),
		  .DIG( DIG ),          // > top
		  .SEL( SEL ),          // > top
		  .iData( D3 )          // < core
	 );
	 
	 /***************************/

    reg [3:0]i;
	 reg [7:0]D1,D2;
	 reg [23:0]D3;
	 reg [1:0]isCall;
	  
    always @ ( posedge CLOCK or negedge RESET )	// core
	     if( !RESET )
		      begin
				    i <= 4'd0;
					 { D1,D2 } <= { 8'd0,8'd0 };
					 D3 <= 24'd0;
					 isCall <= 2'b00;
				end
		  else
		      case( i )
				
				    0:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd0; D2 <= 8'hAB; end
					 
					 1:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd1; D2 <= 8'hCD; end
					 
					 2:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd2; D2 <= 8'hEF; end
					 
					 3:
					 if( DoneU1 ) begin D3[23:16] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd0; end
					 
					 4:
                if( DoneU1 ) begin D3[15:8] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd1; end
					 
					 5:
					 if( DoneU1 ) begin D3[7:0] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd2; end
					 
					 6:
					 i <= i;
		
				endcase

endmodule
