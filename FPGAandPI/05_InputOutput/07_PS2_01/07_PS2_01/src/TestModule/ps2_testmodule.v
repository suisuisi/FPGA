//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-15 00:35:19
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-15 00:50:06
//# Description: 
//# @Modification History: 2019-06-15 00:48:57
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-06-15 00:48:57
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module ps2_testmodule
(
    CLOCK, RST_n,
	PS2_CLK, PS2_DAT,
	SMG_Data,
	Scan_Sig 
);
    input CLOCK, RST_n;
	 input PS2_CLK, PS2_DAT;
	 output [7:0]SMG_Data;
	 output [5:0]Scan_Sig;


     wire [7:0]DataU1;

     ps2_funcmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .PS2_CLK( PS2_CLK ), // input - from top
		  .PS2_DAT( PS2_DAT ), // input - from top
		  .oData( DataU1 ),  // output - to U2
		  .oTrig()
	 );

	smg_basemod U2
	(
	   .CLOCK( CLOCK ),
	   .RST_n( RST_n ),
		.SMG_Data( SMG_Data ),  // output - to  top
		.Scan_Sig( Scan_Sig ),  // output - to  top
		.iData( { 16'hFFFF, DataU1 } ) // input - from U1
	);
		     
endmodule
