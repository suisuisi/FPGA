//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-06 21:22:12
//****************************************//
`timescale 1ns/ 1ps
module bps_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

    // Inputs
    reg isTX;
	wire BPS_CLOCK;
	wire BPS_CLOCKen;





bps_module 
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
	   .CLOCK( clock ),
		.RST_n( reset ),
		.En_Sig( isTX ),    // input - from U2
		.BPS_CLK( BPS_CLOCK ),  // output - to X
		.BPS_CLKen( BPS_CLOCKen ) // output - to U2
);


initial begin   // 建立时钟
    clock = 0;
    forever #20 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
//    DoneU1 = 0;
//    TXD = 1;
    isTX=0;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;
    isTX=1;
    #5000000 $stop;
end


	

endmodule


