//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-18 23:59:39
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-21 03:53:37
//# Description: 
//# @Modification History: 2019-07-20 21:04:39
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-07-20 21:04:39
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module demo_control_module
(
    input CLOCK,
	 input RST_n,
	 output [23:0]Number_Sig
);
   
	 /******************************/
	 
	 parameter T100MS = 23'd4_999_999;
	 
	 /******************************/
	 
	 reg [22:0]C1;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      C1 <= 23'd0;
		  else if( C1 == T100MS )
		      C1 <= 23'd0;
		  else 
		      C1 <= C1 + 1'b1;
	
	  /*******************************************************/
	 
	 reg [3:0]i;
	 reg [23:0]rNum;
	 reg [23:0]rNumber;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	      if( !RST_n )
			    begin
			        i <= 4'd0;
					  rNum <= 24'd0;
					  rNumber <= 24'd0;
				 end
		   else
			    case( i )
				 
				     0:
					  if( C1 == T100MS ) begin rNum[3:0] <= rNum[3:0] + 1'b1; i <= i + 1'b1; end
					  
					  1:
					  if( rNum[3:0] > 4'd14 ) begin rNum[7:4] <= rNum[7:4] + 1'b1; rNum[3:0] <= 4'd0; i <= i + 1'b1; end
					  else i <= i + 1'b1; 
					  
					  2:
					  if( rNum[7:4] > 4'd14 ) begin rNum[11:8] <= rNum[11:8] + 1'b1; rNum[7:4] <= 4'd0; i <= i + 1'b1; end
					  else i <= i + 1'b1;
					  
					  3:
					  if( rNum[11:8] > 4'd14 ) begin rNum[15:12] <= rNum[15:12] + 1'b1; rNum[11:8] <= 4'd0; i <= i + 1'b1; end
					  else i <= i + 1'b1;
					  
					  4:
					  if( rNum[15:12] > 4'd14 ) begin rNum[19:16] <= rNum[19:16] + 1'b1; rNum[15:12] <= 4'd0; i <= i + 1'b1; end
			        else i <= i + 1'b1;
					  
					  5:
					  if( rNum[15:12] > 4'd14 ) begin rNum[19:16] <= rNum[19:16] + 1'b1; rNum[15:12] <= 4'd0; i <= i + 1'b1; end	
					  else i <= i + 1'b1;
					  
					  6:
					  if( rNum[19:16] > 4'd14 ) begin rNum[23:20] <= rNum[23:20] + 1'b1; rNum[19:16] <= 4'd0; end
					  else i <= i + 1'b1;
					  
					  7:
					  if( rNum[23:20] > 4'd14 ) begin rNum <= 24'd0; i <= i + 1'b1; end
					  else i <= i + 1'b1; 
					  
					  8:
					  begin rNumber <= rNum; i <= 4'd0; end
				 
				 endcase

    /*******************************************************/
	 
	 assign Number_Sig = rNumber;
	 
	 /*******************************************************/
	 
endmodule
