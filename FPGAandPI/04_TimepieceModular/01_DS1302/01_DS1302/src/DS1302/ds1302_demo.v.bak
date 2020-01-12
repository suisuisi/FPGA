module ds1302_demo
(
    input CLOCK, RESET,
	 output RTC_NRST, RTC_SCLK, 
	 inout RTC_DATA,
	 output [7:0]DIG,
	 output [5:0]SEL
);
	 wire DoneU1;
	 wire [7:0]DataU1;
	 
	 ds1302_basemod U1
    (
        .CLOCK( CLOCK ), 
	     .RESET( RESET ),
		  .RTC_NRST( RTC_NRST ),
	     .RTC_SCLK( RTC_SCLK ),
	     .RTC_DATA( RTC_DATA ),
	     .iCall( isCall ),
	     .oDone( DoneU1 ),
	     .iData( D1 ),
	     .oData( DataU1 )
    );
	 
	 smg_basemod U2
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RESET ),
		  .DIG( DIG ),          // > top
		  .SEL( SEL ),          // > top
		  .iData( D2 )          // < core
	 );

   reg [3:0]i;
	reg [7:0]isCall;
	reg [7:0]D1;
	reg [23:0]D2;
	
	always @ ( posedge CLOCK or negedge RESET )
	    if( !RESET )
		     begin
			      i <= 4'd0;
			      isCall <= 8'd0;
					D1 <= 8'd0;
					D2 <= 24'd0;
			  end
		 else 
		     case( i )
			  
			      0:
					if( DoneU1 ) begin isCall[7] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[7] <= 1'b1; D1 <= 8'h00; end
					
					1:
					if( DoneU1 ) begin isCall[6] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[6] <= 1'b1; D1 <= { 4'd2, 4'd1 }; end
					
					2:
					if( DoneU1 ) begin isCall[5] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[5] <= 1'b1; D1 <= { 4'd5, 4'd9 }; end
					
					3:
					if( DoneU1 ) begin isCall[4] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[4] <= 1'b1; D1 <= { 4'd5, 4'd0 }; end
					
					/*************/
					
					4:
					if( DoneU1 ) begin D2[7:0] <= DataU1; isCall[0] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[0] <= 1'b1; end
					
					5:
					if( DoneU1 ) begin D2[15:8] <= DataU1; isCall[1] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[1] <= 1'b1; end
					
					6:
					if( DoneU1 ) begin D2[23:16] <= DataU1; isCall[2] <= 1'b0; i <= 4'd4; end
					else begin isCall[2] <= 1'b1; end
					
					
			  endcase

endmodule
