//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-12 22:54:31
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-14 22:17:47
//# Description: 
//# @Modification History: 2019-06-12 23:41:12
//# Date                By             Version             Change Description: 
//# ========================================================================= #
//# 2019-06-12 23:41:12
//# ========================================================================= #
//# |                                                                       | #
//# |                                OpenFPGA                               | #
//****************************************************************************//
`timescale 1 ns/ 1 ps
module counter_10clk_tb; // 申明TestBench名称

reg       clock;
reg       reset; // 申明信号
reg       en;
wire      dout;


// 申明设计单元
counter_10clk dut
	 (
	    .CLOCK( clock ),
		.RST_n( reset ),
		.en( en ),         // 
		.dout( dout )
	 );

initial begin   // 建立时钟
    clock = 0;
    forever #20 clock = ~clock;
end

initial begin   // 提供激励
    reset = 0;
    en    = 0;
    #200
    reset = 1;
    en    = 1;
    #210
    en    = 0;
    #50000 $stop;
end

endmodule


