//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-09-08 19:55:15
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-09-14 03:33:37
//# Description: 
//# @Modification History: 2019-09-14 01:00:31
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-09-14 01:00:31
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module iic_mcp4725_demo
(
    input CLOCK, RESET,
	 output SCL,
	 inout SDA,
	 output [7:0]DIG,
	 output [5:0]SEL
);
    wire [7:0]DataU1;
	 wire DoneU1;

    iic_mcp4725 U1
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
					 else begin isCall <= 2'b10; D1 <= 8'hFF; D2 <= 8'hF0; end
					 
					 
					 1:
					 i <= i;
		
				endcase

endmodule
