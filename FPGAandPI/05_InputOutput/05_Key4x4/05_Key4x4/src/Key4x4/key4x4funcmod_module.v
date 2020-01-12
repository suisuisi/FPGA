//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-09 03:52:48
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-26 22:06:43
//# Description: 
//# @Modification History: 2019-06-10 19:40:30
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-06-10 19:40:30
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
`timescale 1ns / 1ps
module key4x4funcmod_module 
(
   CLOCK, 
	RST_n,            // 开发板上复位按键
	key_in_y,         // 输入矩阵键盘的列信号(KEY0~KEY3)
	key_out_x,        // 输出矩阵键盘的行信号(KEY4~KEY7)	
   LED,	
	Pin_Out           // 输出LED灯,用于矩阵键盘板上16个LED(LED1~LED16)
	
);

//========================================================
// PORT declarations
//========================================================						
input        CLOCK; 
input        RST_n;
input  [3:0] key_in_y;
output reg [3:0] key_out_x;
output [3:0] Pin_Out;
output reg[3:0] LED;

//寄存器定义
reg [19:0] count;

//==============================================
// 输出矩阵键盘的行信号，20ms扫描矩阵键盘一次,采样频率小于按键毛刺频率，相当于滤除掉了高频毛刺信号。
//==============================================
always @(posedge CLOCK or negedge RST_n)     //检测时钟的上升沿和复位的下降沿
begin
   if(!RST_n) begin               //复位信号低有效
      count <= 20'd0;        //计数器清0
      key_out_x <= 4'b1111;  
   end		
   else begin
	       if(count == 20'd0)           //0ms扫描第一行矩阵键盘
            begin
               key_out_x <= 4'b1110;   //开始扫描第一行矩阵键盘,第一行输出0
					count <= count + 20'b1; //计数器加1
            end
         else if(count == 20'd249_999) //5ms扫描第二行矩阵键盘,5ms计数(50M/200-1=249_999)
            begin
               key_out_x <= 4'b1101;   //开始扫描第二行矩阵键盘,第二行输出0
					count <= count + 20'b1; //计数器加1
            end				
			else if(count ==20'd499_999)   //10ms扫描第三行矩阵键盘,10ms计数(50M/100-1=499_999)
            begin
               key_out_x <= 4'b1011;   //扫描第三行矩阵键盘,第三行输出0
					count <= count + 20'b1; //计数器加1
            end	
			else if(count ==20'd749_999)   //15ms扫描第四行矩阵键盘,15ms计数(50M/67.7-1=749_999)
            begin
               key_out_x <= 4'b0111;   //扫描第四行矩阵键盘,第四行输出0
					count <= count + 20'b1; //计数器加1
            end				
         else if(count ==20'd999_999)  //20ms计数(50M/50-1=999_999)
			   begin
               count <= 0;             //计数器为0
            end	
	      else
				count <= count + 20'b1;    //计数器加1
			
     end
end
//====================================================
// 采样列的按键信号
//====================================================
reg [3:0] key_h1_scan;    //第一行按键扫描值KEY
reg [3:0] key_h1_scan_r;  //第一行按键扫描值寄存器KEY
reg [3:0] key_h2_scan;    //第二行按键扫描值KEY
reg [3:0] key_h2_scan_r;  //第二行按键扫描值寄存器KEY
reg [3:0] key_h3_scan;    //第三行按键扫描值KEY
reg [3:0] key_h3_scan_r;  //第三行按键扫描值寄存器KEY
reg [3:0] key_h4_scan;    //第四行按键扫描值KEY
reg [3:0] key_h4_scan_r;  //第四行按键扫描值寄存器KEY
always @(posedge CLOCK)
	begin
		if(!RST_n) begin               //复位信号低有效
			key_h1_scan <= 4'b1111;     
			key_h2_scan <= 4'b1111;          
			key_h3_scan <= 4'b1111;          
			key_h4_scan <= 4'b1111;        
		end		
		else begin
		  if(count == 20'd124_999)           //2.5ms扫描第一行矩阵键盘值
			   key_h1_scan<=key_in_y;         //扫描第一行的矩阵键盘值
		  else if(count == 20'd374_999)      //7.5ms扫描第二行矩阵键盘值
			   key_h2_scan<=key_in_y;         //扫描第二行的矩阵键盘值
		  else if(count == 20'd624_999)      //12.5ms扫描第三行矩阵键盘值
			   key_h3_scan<=key_in_y;         //扫描第三行的矩阵键盘值
		  else if(count == 20'd874_999)      //17.5ms扫描第四行矩阵键盘值
			   key_h4_scan<=key_in_y;         //扫描第四行的矩阵键盘值 
		end
end

//====================================================
// 按键信号锁存一个时钟节拍
//====================================================
always @(posedge CLOCK)
   begin
		 key_h1_scan_r <= key_h1_scan;   	
		 key_h2_scan_r <= key_h2_scan; 
		 key_h3_scan_r <= key_h3_scan; 
		 key_h4_scan_r <= key_h4_scan;  
	end 
   
wire [3:0] flag_h1_key = key_h1_scan_r[3:0] & (~key_h1_scan[3:0]);  //当检测到按键有下降沿变化时，代表该按键被按下，按键有效 
wire [3:0] flag_h2_key = key_h2_scan_r[3:0] & (~key_h2_scan[3:0]);  //当检测到按键有下降沿变化时，代表该按键被按下，按键有效 
wire [3:0] flag_h3_key = key_h3_scan_r[3:0] & (~key_h3_scan[3:0]);  //当检测到按键有下降沿变化时，代表该按键被按下，按键有效 
wire [3:0] flag_h4_key = key_h4_scan_r[3:0] & (~key_h4_scan[3:0]);  //当检测到按键有下降沿变化时，代表该按键被按下，按键有效 
//=====================================================
// 方便封装，将按键值进行赋值
//=====================================================
reg [3:0] rPin_Out;
always @ (posedge CLOCK or negedge RST_n)      //检测时钟的上升沿和复位的下降沿
begin
    if (!RST_n)                 //复位信号低有效
         rPin_Out <= 4'd0;     //
    else
         begin            
             if ( flag_h1_key[0] ) begin LED<=4'b0000;rPin_Out <= 4'd0;  end  //按键第一行的KEY1值变化时，LED1将做亮灭翻转
             if ( flag_h1_key[1] ) begin LED<=4'b0001;rPin_Out <= 4'd1; end   //按键第一行的KEY2值变化时，LED2将做亮灭翻转
             if ( flag_h1_key[2] ) begin LED<=4'b0010;rPin_Out <= 4'd2;  end  //按键第一行的KEY3值变化时，LED3将做亮灭翻转
             if ( flag_h1_key[3] ) begin LED<=4'b0011;rPin_Out <= 4'd3;  end  //按键第一行的KEY4值变化时，LED4将做亮灭翻转
			 
			 if ( flag_h2_key[0] ) begin LED<=4'b0100;rPin_Out <= 4'd4; end   //按键第二行的KEY5值变化时，LED5做亮灭翻转
             if ( flag_h2_key[1] ) begin LED<=4'b0101;rPin_Out <= 4'd5;  end  //按键第二行的KEY6值变化时，LED6将做亮灭翻转
             if ( flag_h2_key[2] ) begin LED<=4'b0110;rPin_Out <= 4'd6;  end  //按键第二行的KEY7值变化时，LED7将做亮灭翻转
             if ( flag_h2_key[3] ) begin LED<=4'b0111;rPin_Out <= 4'd7;  end  //按键第二行的KEY8值变化时，LED8将做亮灭翻转
			 
			 if ( flag_h3_key[0] ) begin LED<=4'b1000;rPin_Out <= 4'd8;  end  //按键第三行的KEY9值变化时，LED9将做亮灭翻转
             if ( flag_h3_key[1] ) begin LED<=4'b1001; rPin_Out <= 4'd9;  end  //按键第三行的KEY10值变化时，LED10将做亮灭翻转
             if ( flag_h3_key[2] ) begin LED<=4'b1010;rPin_Out <= 4'd10; end   //按键第三行的KEY11值变化时，LED11将做亮灭翻转
             if ( flag_h3_key[3] ) begin LED<=4'b1011;rPin_Out <= 4'd11; end   //按键第三行的KEY12值变化时，LED12将做亮灭翻转
			
			 if ( flag_h4_key[0] ) begin LED<=4'b1100;rPin_Out <= 4'd12;   end //按键第四行的KEY13值变化时，LED13将做亮灭翻转
             if ( flag_h4_key[1] ) begin LED<=4'b1101;rPin_Out <= 4'd13;  end  //按键第四行的KEY14值变化时，LED14将做亮灭翻转
             if ( flag_h4_key[2] ) begin LED<=4'b1110;rPin_Out <= 4'd14;  end  //按键第四行的KEY15值变化时，LED15将做亮灭翻转
             if ( flag_h4_key[3] ) begin LED<=4'b1111;rPin_Out <= 4'd15; end   //按键第四行的KEY16值变化时，LED16将做亮灭翻转
         end
end
//====================================================
// 输出引脚
//====================================================
 
assign Pin_Out = rPin_Out;
           
endmodule