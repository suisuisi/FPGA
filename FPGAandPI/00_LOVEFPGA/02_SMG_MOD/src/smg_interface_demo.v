//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-18 23:59:39
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-21 03:49:46
//# Description: 
//# @Modification History: 2019-05-19 01:41:52
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 01:41:52
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module smg_interface_demo
(
    input CLOCK,
	 input RST_n,
	 output [7:0]SMG_Data,
	 output [5:0]Scan_Sig
);

    /******************************/ 
 
    wire [23:0]Number_Sig;
	 
    demo_control_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Number_Sig( Number_Sig ) // output - to U2
	 );
	 
	 /******************************/ 
	 
	 smg_interface U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Number_Sig( Number_Sig ), // input - from U1
		  .SMG_Data( SMG_Data ),     // output - to top
		  .Scan_Sig( Scan_Sig )      // output - to top
	 );
	 
    /******************************/ 

endmodule
