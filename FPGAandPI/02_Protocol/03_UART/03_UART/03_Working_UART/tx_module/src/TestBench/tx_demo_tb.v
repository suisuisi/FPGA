//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-03 19:40:12
//****************************************//
`timescale 1ns/ 1ps
module tx_module_demo
(
    CLOCK, RST_n,
	TXD
);

   input CLOCK;
input RST_n;
	output TXD;


	wire TXD;


tx_module_demo dut
(
    .CLOCK( clock ),
    .RST_n( reset ),
    .TXD(TXD)
);



initial begin   // 建立时钟
    clock = 0;
    forever #20 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
//    DoneU1 = 0;
//    TXD = 1;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;

    #50000 $stop;
end


	

endmodule


