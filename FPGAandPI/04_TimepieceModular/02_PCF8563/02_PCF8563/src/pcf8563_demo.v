module iic_demo
(
    input CLOCK, RST_n,
	 output RTC_SCL,
	 inout RTC_SDA,
	 output [7:0]SMG_Data,
	 output [5:0]Scan_Sig
);
    wire [7:0]DataU1;
	 wire DoneU1;

    iic U1
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RST_n ),
		  .SCL( RTC_SCL ),         // > top
		  .SDA( RTC_SDA ),         // <> top
		  .iCall( isCall ),  // < core
		  .oDone( DoneU1 ),    // > core
		  .iAddr( D1 ),        // < core
		  .iData( D2 ),        // < core
		  .oData( DataU1 )     // > core
	 );
	 
	 smg_interface U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .SMG_Data( SMG_Data ),          // > top
		  .Scan_Sig( Scan_Sig ),          // > top
		  .Number_Sig( Number_Sig )          // < core
	 );
	 
	 /***************************/
	reg [23:0]Number_Sig;
    reg [3:0]i;
	 reg [7:0]D1,D2;
	 reg [23:0]D3;
	 reg [1:0]isCall;
	  
    always @ ( posedge CLOCK or negedge RST_n )	// core
	     if( !RST_n )
		      begin
				    i <= 4'd0;
					 { D1,D2 } <= { 8'd0,8'd0 };
					 D3 <= 24'd0;
					 isCall <= 2'b00;
				end
		  else
		      case( i )
				
				    0:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1;end
					 else begin isCall <= 2'b10; D1 <= 8'd0; D2 <= 8'h00; end
					 
					 
					 1:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd2; D2 <= 8'b00100100; end
					 
					 2:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd3; D2 <= 8'b01010111; end

					 3:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd4; D2 <= 8'b00000111; end


					 4:
					 if( DoneU1 ) begin Number_Sig[7:0] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd2; end
					 
					 5:
                if( DoneU1 ) begin Number_Sig[15:8] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd3; end
					 
					 6:
					 if( DoneU1 ) begin Number_Sig[23:16] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd4; end
					 
					 7:
					 i <= 4;
		
				endcase

endmodule
