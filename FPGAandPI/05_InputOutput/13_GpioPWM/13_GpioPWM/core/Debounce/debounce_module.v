//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-05 21:15:43
//# Description: 
//# @Modification History: 2010-08-07 14:36:26
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2010-08-07 14:36:26
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module debounce_module
(
    CLOCK, RST_n, Pin_In, Pin_Out
);
    
	 input CLOCK;
	 input RST_n;
	 input Pin_In;
	 output Pin_Out;
	 
	 /**************************/
	 
	 wire H2L_Sig;
	 wire L2H_Sig;
	 
	 detect_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Pin_In( Pin_In ),   // input - from top
		  .H2L_Sig( H2L_Sig ), // output - to U2
		  .L2H_Sig( L2H_Sig )  // output - to U2
	 );
	 
	 /**************************/
	 
	 delay_module U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .H2L_Sig( H2L_Sig ), // input - from U1
		  .L2H_Sig( L2H_Sig ), // input - from U1
		  .Pin_Out( Pin_Out )  // output - to top
	 );
	 
	 /*******************************/

endmodule