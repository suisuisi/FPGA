//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-06-23 12:16:18
//****************************************//
`timescale 1ns/ 1ps
module clock_div_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

    // Inputs





wire clock_div_1s;
reg En_Sig;
clock_div //BPS 
#(//DEVICE_CNT = 85.89934592 * fo    for 50Mhz
//	parameter		DEVICE_CNT = 32'd43	//0.5Hz   
	.DEVICE_CNT(32'd86)    // 1Hz
//	parameter		DEVICE_CNT = 32'd172	//2Hz
)
U2_clock_div
(
	   .CLOCK( clock ),
		.RST_n( reset ),
		.En_Sig( En_Sig ),    // 
		.clock_div_1s( clock_div_1s ) // output - to top
);


initial begin   // 建立时钟
    clock = 0;
    forever #20 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
    En_Sig=0;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;
    En_Sig=1;
    #4294967280 $stop;
end


	

endmodule


