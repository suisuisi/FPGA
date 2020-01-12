//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-07 03:20:23
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-25 01:12:38
//# Description: 
//# @Modification History: 2018-05-28 20:25:05
//# Date          By         Version         Change Description: 
//# ========================================================================= #
//# 2018-05-28 20:25:05
//# ========================================================================= #
//# |                                                         | #
//# |                                OpenFPGA                   | #
//****************************************************************************//
`timescale 1ns / 1ps
module fifomem
#(
    parameter  DATASIZE = 8, // Memory data word width               
    parameter  ADDRSIZE = 4  // 深度为8即地址为3位即可，这里多定义一位的原因是用来判断是空还是满，详细在后文讲到
) // Number of mem address bits
(
    output [DATASIZE-1:0] rdata, 
    input  [DATASIZE-1:0] wdata, 
    input  [ADDRSIZE-1:0] waddr, raddr, 
    input                 wclken, wfull, wclk
);
 
`ifdef RAM   //可以调用一个RAM IP核
// instantiation of a vendor's dual-port RAM 
my_ram  mem
      (
          .dout(rdata),
          .din(wdata),     
          .waddr(waddr),
          .raddr(raddr),   
          .wclken(wclken), 
          .wclken_n(wfull),
          .clk(wclk)
      );
  `else  //用数组生成存储体
 // RTL Verilog memory model
localparam DEPTH = 1<<ADDRSIZE;   // 左移相当于乘法，2^4
reg [DATASIZE-1:0] mem [0:DEPTH-1]; //生成2^4个位宽位8的数组
assign rdata = mem[raddr];
always @(posedge wclk)  //当写使能有效且还未写满的时候将数据写入存储实体中，注意这里是与wclk同步的
    if (wclken && !wfull)
        mem[waddr] <= wdata;
 `endif
 endmodule