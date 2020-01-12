/*-----------------------------------------------------------------------
								 \\\|///
							   \\  - -  //
								(  @ @  )  
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2012-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		www.crazyfpga.com
Email Address 		: 		crazyfpga@vip.qq.com
Filename			:		KEY_Scan_Design.v
Date				:		2011-06-25 00:51
Description			:		led data input with enable signal.
Modification History	:
Date			By			Version			Change Description
=========================================================================
11/06/25		CrazyBingo	1.1				Original
13/01/16		CrazyBingo	2.0				Modification
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/
`timescale 1ns/1ns
module led_input_display
#(
	parameter LED_WIDTH = 8
)
(
	//global clock
	input						clk,
	input						rst_n,
	
	//user interface
	input						led_en,
	input		[LED_WIDTH-1:0]	led_value,
	
	//led interface	
	output	reg	[LED_WIDTH-1:0]	led_data
);

//--------------------------------------
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		led_data <= {LED_WIDTH{1'b0}};
	else if(led_en)
		led_data <= led_value;
	else
		led_data <= led_data;
end

endmodule
