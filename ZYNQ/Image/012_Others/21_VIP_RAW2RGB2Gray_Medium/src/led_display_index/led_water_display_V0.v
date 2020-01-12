/*-------------------------------------------------------------------------
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2011-2012 CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		www.crazyfpga.com
Eamil Address 		: 		crazyfpga@vip.qq.com
Filename			:		led_display.v
Date				:		2012-07-04
Version				:		1.0
Description			:		Water led display module.
Modification History	:
Date			By			Version			Change Description
===========================================================================
12/07/04		CrazyBingo	1.0				Original
12/08/09		CrazyBingo	1.1				Complete
13/01/16		CrazyBingo	2.1				Modification
13/01/31		CrazyBingo	2.2				Modification
--------------------------------------------------------------------------*/
`timescale 1ns/1ns
module	led_water_display_V0
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
localparam DELAY_TOP = 24'hff_ffff;
//localparam DELAY_TOP = 24'hf;
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
reg	[2:0]	led_cnt;			//led count
reg		left_done, right_done;	//led water done edge
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		led_data  <= 1;
		led_cnt <= 0;
		{left_done, right_done} <= 2'b10;
		end
	else if(delay_done)
		begin
		led_cnt <= (led_cnt < LED_WIDTH - 2'd2) ? led_cnt + 1'b1 : 3'd0;
		
		//water edge exchange
		if(led_cnt == LED_WIDTH - 2'd2)
			{left_done, right_done} <= ~{left_done, right_done};
		else
			{left_done, right_done} <= {left_done, right_done};
		
		//water led exchange
		case({left_done, right_done})
		2'b10:	led_data <= (led_data << 1);
		2'b01:	led_data <= (led_data >> 1);
		default:;
		endcase
		end
	else
		begin
		led_data <= led_data;
		led_cnt <= led_cnt;
		{left_done, right_done} <= {left_done, right_done};
		end
end


endmodule
