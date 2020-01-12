//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-21 21:14:51
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-04 02:48:17
//# Description: 
//# @Modification History: 2014-05-10 13:42:27
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2014-05-10 13:42:27
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module tx_funcmod
(
    input CLOCK, RESET,
	 output TXD,
	 input iCall,
	 output oDone,
	 input [7:0]iData
);
	 parameter B115K2 = 9'd434; // formula : ( 1/115200 )/( 1/50E+6 )	 

	 reg [3:0]i;
	 reg [8:0]C1;
	 reg [10:0]D1;
	 reg rTXD;
	 reg isDone;
	 
	 always @( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin
		          i <= 4'd0;
		          C1 <= 9'd0;
			       D1 <= 11'd0;
					 rTXD <= 1'b1; 
					 isDone <= 1'b0;
		      end
		  else if( iCall )
		      case( i )
				
				    0:
					 begin D1 <= { 2'b11 , iData , 1'b0 }; i <= i + 1'b1; end
					 
					 1,2,3,4,5,6,7,8,9,10,11:	  
					 if( C1 == B115K2 -1 ) begin C1 <= 8'd0; i <= i + 1'b1; end
					 else begin rTXD <= D1[i - 1]; C1 <= C1 + 1'b1; end

				    12:
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 13:
					 begin isDone <= 1'b0; i <= 4'd0; end
				
				endcase
	
	assign TXD = rTXD;
	assign oDone = isDone;
	
endmodule
