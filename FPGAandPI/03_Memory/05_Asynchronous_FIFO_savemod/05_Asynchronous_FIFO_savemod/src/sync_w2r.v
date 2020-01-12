//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-07 03:20:23
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-25 01:13:50
//# Description: 
//# @Modification History: 2018-05-29 09:30:29
//# Date          By         Version         Change Description: 
//# ========================================================================= #
//# 2018-05-29 09:30:29
//# ========================================================================= #
//# |                                                         | #
//# |                                OpenFPGA                   | #
//****************************************************************************//
`timescale 1ns / 1ps

module sync_w2r
#(parameter ADDRSIZE = 4)
(
    output reg [ADDRSIZE:0] rq2_wptr, //写指针同步到读时钟域
    input      [ADDRSIZE:0] wptr,     //格雷码形式的写指针
    input                   rclk, rrst_n
);
 
reg [ADDRSIZE:0] rq1_wptr;
 
  always @(posedge rclk or negedge rrst_n)   
      if (!rrst_n)
		begin
          rq1_wptr <= 0;
          rq2_wptr <= 0;
      end 
      else 
		begin
			rq1_wptr <= wptr;
			rq2_wptr <= rq1_wptr;
      end
        
endmodule
