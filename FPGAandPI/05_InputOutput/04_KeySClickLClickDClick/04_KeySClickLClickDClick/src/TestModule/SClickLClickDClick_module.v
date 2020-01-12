//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-09 03:25:32
//# Description: 
//# @Modification History: 2010-08-07 14:36:26
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2010-08-07 14:36:26
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module SClickLClickDClick_module
(
    CLOCK, RST_n, 
	 KEY, 
	 LED
);
    
	 input CLOCK;
	 input RST_n;
	 input KEY;
	 output [2:0]LED;
	 
	 /**************************/
	 
	 wire [2:0]Pin_In;
//	 wire L2H_Sig;

	 keyfuncmod_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .KEY( KEY ),   // input - from top
		  .Pin_Out( Pin_In ) // output - to U2
	 );
	 
	 /**************************/

	 led_module U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Pin_In( Pin_In ), // input - from U1
		  .LED( LED )  // output - to top
	 );
	 
	 /*******************************/

endmodule