//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-10 22:51:49
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-26 22:06:39
//# Description: 
//# @Modification History: 2019-06-11 21:37:04
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-06-11 21:37:04
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
`timescale 1ns / 1ps
module Dipswichfuncmod_module 
(
    CLOCK, 
	RST_n,            // 开发板上复位按键
	dipkey_in,         // 输入DIP信号(DIP0~DIP3)
    LED,	
	Pin_Out           // 输出LED灯,用于矩阵键盘板上16个LED(LED1~LED16)
	
);

//========================================================
// PORT declarations
//========================================================						
input        CLOCK; 
input        RST_n;
input  [3:0] dipkey_in;
output [3:0] Pin_Out;
output reg[3:0] LED;

//=====================================================
// 方便封装，将按键值进行赋值
//=====================================================
reg [3:0] rPin_Out;
always @ (posedge CLOCK or negedge RST_n)      //检测时钟的上升沿和复位的下降沿
begin
    if (!RST_n)                 //复位信号低有效
         rPin_Out <= 4'd0;     //
    else
         case(dipkey_in)
					 
					 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15: 
					 begin rPin_Out <= dipkey_in;LED<=dipkey_in; end
					 
					 default:
					 begin rPin_Out <= 4'hf;LED<=4'hf; end
					 
				endcase
end
//====================================================
// 输出引脚
//====================================================
 
assign Pin_Out = rPin_Out;
           
endmodule