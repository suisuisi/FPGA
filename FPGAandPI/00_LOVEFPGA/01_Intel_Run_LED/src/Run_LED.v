//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-14 19:54:50
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-04-14 21:36:06
//****************************************//
module Run_LED
(
   CLOCK,
	RESET,
	LED 
);   
    
	 
////////////////////////////////////////////	 
	input CLOCK,RESET;
	
	output reg [3:0]LED;
////////////////////////////////////////////
//
//首先定义一个时间计数寄存器counter，每当达到预定的100ms时，
//计数寄存器就清零，否则的话寄存器就加1。
//然后计算计数器计数的最大值。时钟频率为50MHZ，
//也就是周期为1/50M 为20ns，要计数的最大值为T100MS= 100ms/20ns-1 = 4999_999。
//

reg[25:0] counter;
parameter T100MS = 23'd5_000_000;

always @ (posedge CLOCK or negedge RESET)

if(!RESET)      //高电平复位

	counter<=25'd0;

else if(counter==T100MS)

	counter<=25'd0;

else

	counter<=counter+1'b1;
////////////////////////////////////////////
always @ (posedge CLOCK or negedge RESET)

if(!RESET)

	LED<=4'b0001;        //初值，最低位led[0]灯亮

else if(counter==T100MS)

	begin

		if(LED==4'b0000)      //当溢出最高位时

			LED<=4'b0001;    //回到复位时的状态

		else

			LED<=LED<<1;     //循环左移一位

	end

endmodule // Run_LED