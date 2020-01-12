//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-12 20:22:33
//****************************************//
module rx_module
(
    CLOCK, RST_n,
    RXD, 
    RX_En_Sig,
	RX_Done_Sig, 
	RX_Data
);

    input CLOCK;
	 input RST_n;
	 
	 input RXD;
	 input RX_En_Sig;
	 
	 output [7:0]RX_Data;
	 output RX_Done_Sig;
	 
	 
	 /**********************************/
	 
	 wire H2L_Sig;
	 
	 detect_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .RXD( RXD ),    // input - from top
		  .H2L_Sig( H2L_Sig )         // output - to U3
	 );
	 
	 /**********************************/
	 
	 wire RX_BPS_CLK;
	 wire RX_BPS_CLKen;
	 
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
			.En_Sig( BPS_En_Sig ),    // input - from U2
			.BPS_CLK( RX_BPS_CLK ),  // output - to X
			.BPS_CLKen( RX_BPS_CLKen ) // output - to U2
	); 
	 
	 /**********************************/
	 
	 wire Count_Sig;
	 
	 rx_control_module U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  
		  .H2L_Sig( H2L_Sig ),      // input - from U1
		  .RX_En_Sig( RX_En_Sig ),  // input - from top
		  .RXD( RXD ),  // input - from top
		  .RX_BPS_CLK( RX_BPS_CLKen ),      // input - from U2
		  
		  .BPS_En_Sig( BPS_En_Sig ),    // output - to U2
		  .RX_Data( RX_Data ),        // output - to top
		  .RX_Done_Sig( RX_Done_Sig ) // output - to top
		  
	 );
	 
	 /************************************/
	 

endmodule
