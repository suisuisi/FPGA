//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-15 00:35:19
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-18 21:48:46
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
	Scan_Sig,
	LED
);

    input CLOCK, RST_n;
	 inout PS2_CLK, PS2_DAT;
	 output [7:0]SMG_Data;
	 output [5:0]Scan_Sig;
	 output [2:0]LED;

	 wire [23:0]DataU2;

ps2mouse_basemod	U1
(
	.CLOCK( CLOCK ),
	.RST_n( RST_n ),
	.PS2_CLK( PS2_CLK ), // inout - from  top
	.PS2_DAT( PS2_DAT ), // inout - from  top
    .oTrig(),
    .oData( DataU2 )    // output - to  U2
);

	 // immediate proses
	 wire[7:0] X = DataU2[4] ? (~DataU2[15:8] + 1'b1) : DataU2[15:8];
	 wire[7:0] Y = DataU2[5] ? (~DataU2[23:16] + 1'b1) : DataU2[23:16];
	 
   smg_basemod U2
	(
	   .CLOCK( CLOCK ),
	   .RST_n( RST_n ),
	   .SMG_Data( SMG_Data ),  // output - to  top
	   .Scan_Sig( Scan_Sig ),  // output - to  top
		.iData( { 3'd0,DataU2[5],Y,3'd0,DataU2[4],X }) // // input - from  U1
	);
	
	assign LED = {DataU2[1], DataU2[2], DataU2[0]};
		 		     
endmodule
