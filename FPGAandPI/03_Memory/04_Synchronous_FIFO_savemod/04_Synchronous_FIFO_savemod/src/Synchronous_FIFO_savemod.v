//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 23:22:19
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-25 01:11:56
//# Description: 
//# @Modification History: 2019-04-07 03:21:08
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-04-07 03:21:08
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module Synchronous_FIFO_savemod
(
	input CLOCK, RESET,
	input [1:0]iEn,     //写、读使能
	input [3:0]iData,
	output [3:0]oData,
	output [1:0]oTag    //空满标志位
	);
reg [3:0] RAM [3:0];
reg [3:0]D1;
reg [2:0]C1,C2; // N+1

always @ ( posedge CLOCK or negedge RESET )
	if( !RESET )
		begin
			C1 <= 3'd0;
		end
	else if( iEn[1] )
		begin
			RAM[ C1[1:0] ] <= iData;
			C1 <= C1 + 1'b1;
	end
	
always @ ( posedge CLOCK or negedge RESET )
	if( !RESET )
		begin
			D1 <= 4'd0;
			C2 <= 3'd0;
		end
	else if( iEn[0] )
		begin
			D1 <= RAM[ C2[1:0] ];
			C2 <= C2 + 1'b1;
		end

assign oData = D1;
assign oTag[1] = ( C1[2]^C2[2] & C1[1:0] == C2[1:0] ); // Full
assign oTag[0] = ( C1 == C2 ); // Empty

endmodule
