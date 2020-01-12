//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-17 21:18:17
//# Description: 
//# @Modification History: 2010-08-07 14:36:26
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2010-08-07 14:36:26
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module ps2_funcmod
(
    CLOCK, RST_n,
	PS2_CLK,PS2_DAT,
	oTrig,
	oState,
	oData
);
    input CLOCK, RST_n;
	input PS2_CLK,PS2_DAT;
	output oTrig;
	output [7:0]oData;
	output [5:0]oState;
    /******************************************/
    wire isH2L,isL2H;

    detect_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .Pin_In( PS2_CLK ),    // input - from top
		  .H2L_Sig( isH2L ),   // output - to U2
		  .L2H_Sig( isL2H )    // output - to XX
	 );

    /******************************************/	
	ps2_decode_module U2
	(
		    .CLOCK( CLOCK ),
			.RST_n( RST_n ),
			.isH2L( isH2L ),
		    .PS2_DAT ( PS2_DAT ),    // input - from top
		    .oTrig ( oTrig ),        // output - to top
		    .oData ( oData ),         // output - to top
		    .oState( oState )        // output - to top
	);	 
	/******************************************/        

endmodule
