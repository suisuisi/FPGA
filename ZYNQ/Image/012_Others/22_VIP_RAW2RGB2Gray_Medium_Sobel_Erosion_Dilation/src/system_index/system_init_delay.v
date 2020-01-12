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
Filename			:		system_init_delay.v
Date				:		2011-6-25
Description			:		system init delay when power on
Modification History	:
Date			By			Version			Change Description
=========================================================================
11/06/25		CrazyBingo	1.0				Original
12/03/12		CrazyBingo	1.1				Modification
12/06/01		CrazyBingo	1.4				Modification
12/11/18		CrazyBingo	2.0				Modification
13/10/24		CrazyBingo	2.1				Modification
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/
/************************************************************************
//----------------------------------
//component instantiation for system_delay
wire	delay_done;	//system init delay has done
system_init_delay
#(
	.SYS_DELAY_TOP	(24'd2500000)
//	.SYS_DELAY_TOP	(24'd256)	//Just for test
)
u_system_init_delay
(
	//global clock
	.clk		(clk),
	.rst_n		(1'b1),			//It don't depend on rst_n when power up
	//system interface
	.delay_done	(delay_done)
);
************************************************************************/

`timescale 1 ns / 1 ns
module system_init_delay
#(
	parameter	SYS_DELAY_TOP = 24'd2500000	//50ms system init delay
)
(
	//global clock
	input	clk,		//50MHz
	input	rst_n,
	
	//system interface
	output	delay_done
);

//------------------------------------------
//Delay 50ms for steady state when power on
reg	[23:0] delay_cnt = 24'd0;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		delay_cnt <= 0;
	else if(delay_cnt < SYS_DELAY_TOP - 1'b1)
		delay_cnt <= delay_cnt + 1'b1;
	else
		delay_cnt <= SYS_DELAY_TOP - 1'b1;
end
assign	delay_done = (delay_cnt == SYS_DELAY_TOP - 1'b1)? 1'b1 : 1'b0;

endmodule
