/*-----------------------------------------------------------------------
								 \\\|///
							    \\  - -  //
								(  @ @  )
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2013-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		www.crazyfpga.com
Email Address 		: 		crazyfpga@vip.qq.com
Filename			:		led_addr_display.v
Date				:		2012-07-04
Description			:		led display with self-addr module.
Modification History	:
Date			By			Version			Change Description
=========================================================================
12/07/04		CrazyBingo	1.0				Original
12/08/09		CrazyBingo	1.1				Complete
13/01/16		CrazyBingo	2.1				Modification
13/01/31		CrazyBingo	2.2				Modification
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module	led_addr_display
#(
	parameter LED_WIDTH = 8
)
(
	//global clock
	input						clk,
	input						rst_n,

	//user led output
	output	reg	[LED_WIDTH-1:0]	led_data
);

//-----------------------------------
//Delay for 0.3s
localparam DELAY_TOP = 24'hff_ffff;
//localparam DELAY_TOP = 24'hf;		//Just for test
reg	[23:0]	delay_cnt;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		delay_cnt <= 0;
	else if(delay_cnt < DELAY_TOP)
		delay_cnt <= delay_cnt + 1'b1;
	else
		delay_cnt <= 0;
end
wire	delay_done = (delay_cnt == DELAY_TOP) ? 1'b1 : 1'b0;

//-----------------------------------
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		led_data  <= 0;
	else if(delay_done)
		led_data <= led_data + 1'b1;
	else
		led_data <= led_data;
end


endmodule
