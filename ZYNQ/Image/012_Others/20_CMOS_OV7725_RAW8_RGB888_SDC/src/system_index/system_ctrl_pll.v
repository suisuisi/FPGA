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
Filename			:		system_ctrl_pll.v
Date				:		2011-6-25
Description			:		sync global clock and reset signal
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

/***************************************************************************
//----------------------------------
//sync global clock and reset signal
wire	clk_ref;
wire	sys_rst_n;
system_ctrl_pll	u_system_ctrl_pll
(
	.clk			(clk),			//50MHz
	.rst_n			(rst_n),		//global reset

	.clk_ref		(clk_ref),		//clock output	
	.sys_rst_n		(sys_rst_n)		//system reset
);
***************************************************************************/

`timescale 1 ns / 1 ns
module system_ctrl_pll
(
	//globol clock
	input				clk,
	input				rst_n,

	//synced signal
	output 				sys_rst_n,	//system reset
	output 				clk_c0,		//clock output	
	output 				clk_c1,		//clock output
	output 				clk_c2,		//clock output
	output				clk_c3		//clock output
//	output				clk_c4		//clock output
);

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
wire	pll_rst = ~delay_done;// ? ~locked : 1'b1;	//PLL reset, H valid


//-----------------------------------
//system pll module
wire	locked;
sys_pll	u_sys_pll 
(
	.inclk0		(clk),
	.areset		(pll_rst),
	.locked		(locked),
	.c0			(clk_c0),
	.c1			(clk_c1),
	.c2			(clk_c2),
	.c3			(clk_c3)
//	.c4			(clk_c4)
);

wire	clk_ref = clk_c0;
//----------------------------------------------
//rst_n sync, only controlled by the main clk
reg     rst_nr1, rst_nr2;
always @(posedge clk_ref)
begin
	if(!rst_n)
		begin
		rst_nr1 <= 1'b0;
		rst_nr2 <= 1'b0;
		end
	else
		begin
		rst_nr1 <= 1'b1;
		rst_nr2 <= rst_nr1;
		end
end
assign	sys_rst_n = rst_nr2 & locked;	//active low

endmodule

