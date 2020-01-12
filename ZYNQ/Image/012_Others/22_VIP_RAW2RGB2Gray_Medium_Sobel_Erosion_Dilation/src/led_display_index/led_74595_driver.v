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
Filename			:		led_74595_driver.v
Date				:		2013-03-04
Description			:		The driver of led via serial ic 74hc595.
Modification History	:
Date			By			Version			Change Description
=========================================================================
13/03/04		CrazyBingo	1.0				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module led_74595_driver
(
	//global clock
	input			clk,  			//50MHz
	input			rst_n,			//global reset

	//74hc595 interface
	output			led595_dout,	//74hc595 serial data input	
	output			led595_clk,		//74hc595 shift clock (rising edge)
	output			led595_latch,	//74hc595 latch clock (rising edge)

	//user interface
	input	[7:0]	led_data		//led data input	
);


//---------------------------------------
//update led display when led_data is update
reg	[7:0]	led_data_r = 8'h00;
reg	update_flag;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		led_data_r <= 0;
		update_flag <= 1;	//when reset, update the data
		end
	else
		begin
		led_data_r <= led_data;
		update_flag <= (led_data_r != led_data) ? 1'b1 : 1'b0;
		end
end

//-------------------------------------------------
//74hc595 clk delay for enough setup time
localparam	DELAY_CNT	=	3'd7;
reg	[2:0]	delay_cnt;                  
reg	shift_state;	//led scan state	 
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		delay_cnt <= 0;
	else if(shift_state == 1'b1)
		delay_cnt <= (delay_cnt < DELAY_CNT) ? delay_cnt + 1'b1 : 3'd0;
	else
		delay_cnt <= 0;
end
wire	shift_flag = (delay_cnt ==  DELAY_CNT) ? 1'b1 : 1'b0;
wire	shift_clk = (delay_cnt > DELAY_CNT/2) ? 1'b1 : 1'b0;


//----------------------------------------------
//74hc595 shift data output state
reg	[3:0]	led_cnt;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		shift_state <= 0;
		led_cnt <= 0;
		end
	else 
		begin
		case(shift_state)
		0:	begin
			led_cnt <= 0;
			if(update_flag)
				shift_state <= 1;
			else
				shift_state <= 0;
			end
		1:	begin
			if(shift_flag)
				begin
				if(led_cnt < 4'd8)
					begin
					led_cnt <=  led_cnt + 1'b1;
					shift_state <= 1'd1;
					end
				else
					begin
					led_cnt <= 0;
					shift_state <= 0;
					end
				end
			else
				begin
				led_cnt <= led_cnt;
				shift_state <= shift_state;
				end
			end
		endcase
		end
end
assign	led595_dout = (shift_state == 1'b1 && led_cnt < 4'd8) ? led_data[3'd7 - led_cnt] : 1'b0; 
assign	led595_clk = (shift_state == 1'b1 && led_cnt < 4'd8) ? shift_clk : 1'b0; 
assign	led595_latch = (shift_state == 1'b1 && led_cnt == 4'd8) ? 1'b1 : 1'b0; 

endmodule
