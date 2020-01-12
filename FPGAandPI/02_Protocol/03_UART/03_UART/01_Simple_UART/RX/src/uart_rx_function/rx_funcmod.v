//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-21 22:46:15
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-04 03:21:38
//# Description: 
//# @Modification History: 2014-05-10 13:44:28
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2014-05-10 13:44:28
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module rx_funcmod
(
    input CLOCK, RESET, 
	 input RXD,
	 input iCall,
	 output oDone, 
	 output [7:0]oData
);
    parameter BPS115K2 = 9'd434, SAMPLE = 9'd108;
	  
    reg [3:0]i;
	 reg [8:0]C1;
	 reg [7:0]D1;
	 reg isDone;
	 
	 always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin
				    i <= 4'd0;
					 C1 <= 9'd0;
					 D1 <= 8'd0;
					 isDone <= 1'b0;
				end
		  else if( iCall )
		      case( i )
					 
					 0: 
					 if( RXD == 1'b0 ) begin i <= i + 1'b1; C1 <= C1 + 4'd1; end 
					 
					 1: // start bit
					 if( C1 == BPS115K2 -1 ) begin C1 <= 8'd0; i <= i + 1'b1; end 
					 else C1 <= C1 + 1'b1;
					 
					 2,3,4,5,6,7,8,9: //stalk and count 1~8 data's bit , sample data at 1/2 for bps
					 begin
						if( C1 == SAMPLE ) D1[i-2] <= RXD;
					    if( C1 == BPS115K2 -1 ) begin C1 <= 8'd0; i <= i + 1'b1; end
				        else C1 <= C1 + 1'b1; 		  
					 end
					 
					 10,11: // parity bit & stop bit
					 if( C1 == BPS115K2 -1 ) begin C1 <= 8'd0; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;
					 
					 12:
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 13:
					 begin isDone <= 1'b0; i <= 4'd0; end
				
				endcase
				
	assign oDone = isDone;
	assign oData = D1;
	
endmodule
