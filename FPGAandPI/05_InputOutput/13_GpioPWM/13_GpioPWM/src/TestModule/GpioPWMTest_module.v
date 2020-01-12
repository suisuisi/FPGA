//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-09 20:07:34
//# Description: 
//# @Modification History: 2010-08-07 14:36:26
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2010-08-07 14:36:26
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module GpioPWMTest_module
(
    input CLOCK,
	 input RST_n,
	 input [2:0]Key_In,
	 output LED
);

    /******************************************/
    
	 wire [2:0]Key_Out;

    Key_interface_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .KEY_IN( Key_In ),    // input - from top
		  .KEY_OUT( Key_Out )   // output - to U2
	 );

    /******************************************/	
	 
gpiopwm_module //BPS 
#(
	//DEVICE_CNT = 85.89934592 * fo    for 50Mhz
//	parameter		DEVICE_CNT = 32'd942950	//500Hz  
	.DEVICE_CNT(32'd85899)    // 1KHz
//	parameter		DEVICE_CNT = 32'd171799	//2KHz	
)
U2_gpiopwm_module
(
	   .CLOCK( CLOCK ),
		.RST_n( RST_n ),
		.En_Sig( 1'b1 ),    // 
		.Option_Key( Key_Out ),  // input - from U1
		.GPIO_PWM( LED ) // output - to top
);
	 
	/******************************************/        

endmodule
