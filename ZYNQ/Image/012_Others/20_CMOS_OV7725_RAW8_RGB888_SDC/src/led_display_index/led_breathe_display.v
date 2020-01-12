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
Filename			:		led_breathe_display.v
Date				:		2013-02-10
Description			:		Breathe led display analog by FPGA RTL.
Modification History	:
Date			By			Version			Change Description
=========================================================================
13/02/10		CrazyBingo	1.0				Original
13/10/25		CrazyBingo	1.1				Modification
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module led_breathe_display
#(
	parameter LED_WIDTH = 8
)
(
	//global clock
	input				clk,  		//50MHz
	input				rst_n,		//global reset

	output		[LED_WIDTH - 1:0]	led_data	//led data output	
);

//---------------------------------------
//generate for 1us delay signal		
 localparam	DELAY_TOP1 = 6'd50;	//1us
//localparam	DELAY_TOP1 = 6'd1;	//1us
reg [5:0]	delay_cnt1;	
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) 
		delay_cnt1 <= 0; 
	else if(delay_cnt1 < DELAY_TOP1 - 1'b1)
		delay_cnt1 <= delay_cnt1 + 1'b1;
	else
		delay_cnt1 <= 0;
end
//counter for 1us delay is completed
wire	delay_1us = (delay_cnt1 == DELAY_TOP1 - 1'b1) ? 1'b1 : 1'b0;	
 
//---------------------------------------
//generate for 1ms delay signal			
localparam	DELAY_TOP2 = 10'd1000;	//1ms
//localparam	DELAY_TOP2 = 10'd16;	//1ms
reg [9:0]	delay_cnt2;	
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) 
		delay_cnt2 <= 0; 
	else if(delay_1us)
		begin
		if(delay_cnt2 < DELAY_TOP2 - 1'b1)
			delay_cnt2 <= delay_cnt2 + 1'b1;
		else
			delay_cnt2 <= 0;
		end
	else
		delay_cnt2 <= delay_cnt2;
end
//counter for 1ms delay is completed
wire	delay_1ms = (delay_1us == 1'b1 && delay_cnt2 == DELAY_TOP2 - 1'b1) ? 1'b1 : 1'b0;

//---------------------------------------
//generate for 1s delay signal			
localparam	DELAY_TOP3 = 10'd1000;	//1s
//localparam	DELAY_TOP3 = 10'd16;	//1s
reg [9:0]	delay_cnt3;	
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) 
		delay_cnt3 <= 0; 
	else if(delay_1ms)
		begin
		if(delay_cnt3 < DELAY_TOP3 - 1'b1)
			delay_cnt3 <= delay_cnt3 + 1'b1;
		else
			delay_cnt3 <= 0;
		end
	else
		delay_cnt3 <= delay_cnt3;
end
//counter for 1s delay is completed
wire	delay_1s = (delay_1ms == 1'b1 && delay_cnt3 == DELAY_TOP3 - 1'b1) ? 1'b1 : 1'b0;

//--------------------------------
//Breathe led rtl disign
wire	[9:0]	pulse_cnt = delay_cnt2;		//1ms with 1000 steps counter(1ms)
wire	[9:0]	display_cnt = delay_cnt3;	//led display pulse count(1s)

	
//---------------------------------------
//generate pwm up/down display mode 
reg	display_mode;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		display_mode <= 0;
	else if(delay_1s)
		display_mode <= ~display_mode;
	else
		display_mode <= display_mode;
end

//---------------------------------------
//The high pulse of the display period 
reg	pwm_on;	
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		pwm_on <= 0;
	else 
		begin
		case(display_mode)
		1'b0:	pwm_on <= (pulse_cnt < display_cnt) ? 1'b1 : 1'b0;
		1'b1:	pwm_on <= (pulse_cnt < display_cnt) ? 1'b0 : 1'b1;
		endcase
		end
end
assign	led_data = {LED_WIDTH{pwm_on}};	//pwm led display output

endmodule
