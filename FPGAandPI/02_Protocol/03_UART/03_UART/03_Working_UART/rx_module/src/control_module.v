//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-12 21:11:18
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-04 17:18:34
//# Description: 
//# @Modification History: 2019-05-12 21:26:44
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-12 21:26:44
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module control_module
(
    CLOCK, RST_n,
	 RX_Done_Sig,
	 RX_Data,
	 RX_En_Sig,
	 Number_Data
);

    input CLOCK;
	 input RST_n;
	 input RX_Done_Sig;
	 input [7:0]RX_Data;
	 output RX_En_Sig;
	 output [7:0]Number_Data;
	 
	 /******************************/
	 
	 reg [7:0]rData;
	 reg isEn;
	 
    always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      rData <= 8'd0;
		  else if( RX_Done_Sig )     
		      begin rData <= RX_Data; isEn <= 1'b0; end
		  else isEn <= 1'b1;

	/*********************************/
	
	assign Number_Data = rData;
	assign RX_En_Sig = isEn;
	
	/*********************************/
	 
endmodule
