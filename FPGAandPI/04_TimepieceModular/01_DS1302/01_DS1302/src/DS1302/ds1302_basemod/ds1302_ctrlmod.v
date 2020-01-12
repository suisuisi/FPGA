//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:55:44
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-05-19 21:05:49
//# Description: 
//# @Modification History: 2019-05-19 20:58:05
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:05
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module ds1302_ctrlmod
(
    input CLOCK, RST_n,	 
	 input [7:0]iCall,
	 output oDone,
	 input [7:0]iData,
	 output [1:0]oCall,
	 input iDone,
	 output [7:0]oAddr, oData
);	 
	 reg [7:0]D1,D2;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    D1 <= 8'd0;
					 D2 <= 8'd0;
				end
		  else 
		      case( iCall[7:0] )
				
				    8'b1000_0000 : // Write unprotect
					 begin D1 = 8'h8E; D2 = 8'b0000_0000; end
					
				    8'b0100_0000 : // Write hour
					 begin D1 = 8'h84; D2 = iData; end
					 
					 8'b0010_0000 : // Write minit
					 begin D1 = 8'h82; D2 = iData; end
					 
					 8'b0001_0000 : // Write second
					 begin D1 = 8'h80; D2 = iData; end
					 
					 8'b0000_1000 : // Write protect
					 begin D1 = 8'h8E; D2 = 8'b1000_0000; end
					 
					 8'b0000_0100 : // Read hour
					 begin D1 = 8'h85; end
					 
					 8'b0000_0010 : // Read minit
					 begin D1 = 8'h83; end
					 
					 8'b0000_0001 : // Read second  
					 begin D1 = 8'h81; end
				
				endcase
	 
	 reg [1:0]i;
	 reg [1:0]isCall;
	 reg isDone;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				     i <= 2'd0;
					 isCall <= 2'b00;
					 isDone <= 1'b0;
				end
		  else if( iCall[7:3] ) // Write action
		      case( i )
				
				    0 :
					 if( iDone ) begin isCall[1] <= 1'b0; i <= i + 1'b1; end
					 else begin isCall[1] <= 1'b1; end
					 
					 1 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 2 :
					 begin isDone <= 1'b0; i <= 2'd0; end
					  
				endcase
		  else if( iCall[2:0] ) // Read action
		      case( i )
				
				    0 :
					 if( iDone ) begin isCall[0] <= 1'b0; i <= i + 1'b1; end
					 else begin isCall[0] <= 1'b1; end
					 
					 1 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 2 :
					 begin isDone <= 1'b0; i <= 2'd0; end
					  
				endcase
	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oAddr = D1;
	  assign oData = D2;

endmodule
