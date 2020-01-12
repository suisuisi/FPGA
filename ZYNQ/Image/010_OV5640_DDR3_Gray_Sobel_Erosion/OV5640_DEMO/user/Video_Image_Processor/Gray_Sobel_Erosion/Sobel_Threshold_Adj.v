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
Filename			:		Sobel_Threshold_Adj.v
Date				:		2013-05-26
Description			:		Sobel Threshold adjust with key.
Modification History	:
Date			By			Version			Change Description
=========================================================================
13/05/25		CrazyBingo	1.0				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/   

`timescale 1ns/1ns
module Sobel_Threshold_Adj
(
	//global clock
	input				clk,  		//100MHz
	input				rst_n,		//global reset
	
	//user interface
	input				key_flag,		//key down flag
	input		[1:0]	key_value,		//key control data
	
	output	reg	[3:0]	Sobel_Grade,	//Sobel Grade output
	output	reg	[7:0]	Sobel_Threshold	//lcd pwn signal, l:valid
);

//---------------------------------
//Sobel Threshold adjust with key.
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		Sobel_Grade	<= 4'd8;
	else if(key_flag)
		begin
		case(key_value)	//{Sobel_Threshold--, Sobel_Threshold++}
		2'b01:	Sobel_Grade <= (Sobel_Grade == 4'd0)  ? 4'd0  : Sobel_Grade - 1'b1;
		2'b10:	Sobel_Grade <= (Sobel_Grade == 4'd15) ? 4'd15 : Sobel_Grade + 1'b1;
		default:;
		endcase
		end
	else
		Sobel_Grade <= Sobel_Grade;
end


//---------------------------------
//Sobel Grade Mapping with Sobel Threshold
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		Sobel_Threshold <= 35;
	else
		case(Sobel_Grade)
		4'h0:	Sobel_Threshold <= 20;
		4'h1:	Sobel_Threshold <= 25;
		4'h2:	Sobel_Threshold <= 30;
		4'h3:	Sobel_Threshold <= 35;
		4'h5:	Sobel_Threshold <= 40;
		4'h6:	Sobel_Threshold <= 45;
		4'h7:	Sobel_Threshold <= 50;
		4'h8:	Sobel_Threshold <= 55;
		
		4'h9:	Sobel_Threshold <= 60;
		4'ha:	Sobel_Threshold <= 65;
		4'hb:	Sobel_Threshold <= 70;
		4'hc:	Sobel_Threshold <= 75;
		4'hd:	Sobel_Threshold <= 80;
		4'he:	Sobel_Threshold <= 85;
		4'hf:	Sobel_Threshold <= 90;
		default:;
		endcase
end


endmodule
