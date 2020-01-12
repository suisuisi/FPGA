//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-06 22:13:07
//****************************************//
module tx_module
(
    CLOCK, RST_n,
	TX_Data, 
	TX_En_Sig,
	TX_Done_Sig, 
	TXD
);
 
   input CLOCK;
	input RST_n;
	input [7:0]TX_Data;
	input TX_En_Sig;
	output TX_Done_Sig;
	output TXD;
	  
/********************************/
	  
	wire BPS_CLOCK;
	wire BPS_CLOCKen; 
	
bps_module //BPS 
#(
	//BPS_CNT = 85.89934592 * fo    for 50Mhz
//	.BPS_CNT(32'd21990233)	//256000bps
//	.BPS_CNT(32'd10995116)	//128000bps
//	.BPS_CNT(32'd9895605)	//115200bps
	.BPS_CNT(32'd824634)	//9600bps * 16 824634
  //BPS_CNT = 42.949 67296 * fo    for 100Mhz
//	.BPS_CNT(32'd10995116)	//256000bps 10995116
//	.BPS_CNT(32'd5497558)	//128000bps 5497558
//	.BPS_CNT(32'd4947802)	//115200bps 4947802
//	.BPS_CNT(32'd412317)	//9600bps   412317
)
U1_bps_module
(
	   .CLOCK( CLOCK ),
		.RST_n( RST_n ),
		.En_Sig( TX_En_Sig ),    // input - from U2
		.BPS_CLK( BPS_CLOCK ),  // output - to X
		.BPS_CLKen( BPS_CLOCKen ) // output - to U2
);  
/*********************************/
	  
tx_control_module U2_tx_control_module
	(
	   .CLOCK( CLOCK ),
		.RST_n( RST_n ),
		.TX_En_Sig( TX_En_Sig ),    // input - from top
		.TX_Data( TX_Data ),        // input - from top
		.BPS_CLK( BPS_CLOCKen ),  // input - from U2
		.TX_Done_Sig( TX_Done_Sig ), // output - to top
		.TXD( TXD )     // output - to top
	);
/***********************************/

endmodule

