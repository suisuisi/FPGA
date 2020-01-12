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
Filename			:		lcd_driver.v
Date				:		2012-02-18
Description			:		LCD/VGA driver.
Modification History	:
Date			By			Version			Change Description
=========================================================================
12/02/18		CrazyBingo	1.0				Original
12/03/19		CrazyBingo	1.1				Modification
12/03/21		CrazyBingo	1.2				Modification
12/05/13		CrazyBingo	1.3				Modification
13/11/07		CrazyBingo	2.1				Modification
17/04/02		CrazyBingo	3.0				Modify for 12bit width logic
-------------------------------------------------------------------------
|                                     Oooo							|
+------------------------------oooO--(   )-----------------------------+
                              (   )   ) /
                               \ (   (_/
                                \_)
----------------------------------------------------------------------*/   

`timescale 1ns/1ns
module lcd_driver
(  	
	//global clock
	input			clk,			//system clock
	input			rst_n,     		//sync reset
	
	//lcd interface
	output			lcd_dclk,   	//lcd pixel clock
	output			lcd_blank,		//lcd blank
	output			lcd_sync,		//lcd sync
	output			lcd_hs,	    	//lcd horizontal sync
	output			lcd_vs,	    	//lcd vertical sync
	output			lcd_en,			//lcd display enable
	output	[23:0]	lcd_rgb,		//lcd display data

	//user interface
	output			lcd_request,	//lcd data request
	output	[11:0]	lcd_xpos,		//lcd horizontal coordinate
	output	[11:0]	lcd_ypos,		//lcd vertical coordinate
	input	[23:0]	lcd_data		//lcd data
);	 
`include "lcd_para.v" 

/*******************************************
		SYNC--BACK--DISP--FRONT
*******************************************/
//------------------------------------------
//h_sync counter & generator
reg [11:0] hcnt; 
always @ (posedge clk or negedge rst_n)
begin
	if (!rst_n)
		hcnt <= 12'd0;
	else
		begin
        if(hcnt < `H_TOTAL - 1'b1)		//line over			
            hcnt <= hcnt + 1'b1;
        else
            hcnt <= 12'd0;
		end
end 
assign	lcd_hs = (hcnt <= `H_SYNC - 1'b1) ? 1'b0 : 1'b1;

//------------------------------------------
//v_sync counter & generator
reg [11:0] vcnt;
always@(posedge clk or negedge rst_n)
begin
	if (!rst_n)
		vcnt <= 12'b0;
	else if(hcnt == `H_TOTAL - 1'b1)		//line over
		begin
		if(vcnt < `V_TOTAL - 1'b1)		//frame over
			vcnt <= vcnt + 1'b1;
		else
			vcnt <= 12'd0;
		end
end
assign	lcd_vs = (vcnt <= `V_SYNC - 1'b1) ? 1'b0 : 1'b1;

//------------------------------------------
//LCELL	LCELL(.in(clk),.out(lcd_dclk));
assign	lcd_dclk = ~clk;
assign	lcd_blank = lcd_hs & lcd_vs;		
assign	lcd_sync = 1'b0;


//-----------------------------------------
assign	lcd_en		=	(hcnt >= `H_SYNC + `H_BACK  && hcnt < `H_SYNC + `H_BACK + `H_DISP) &&
						(vcnt >= `V_SYNC + `V_BACK  && vcnt < `V_SYNC + `V_BACK + `V_DISP) 
						? 1'b1 : 1'b0;
assign	lcd_rgb 	= 	lcd_en ? lcd_data : 24'h000000;	//ffffff;



//------------------------------------------
//ahead x clock
localparam	H_AHEAD = 	12'd1;


assign	lcd_request	=	(hcnt >= `H_SYNC + `H_BACK - H_AHEAD && hcnt < `H_SYNC + `H_BACK + `H_DISP - H_AHEAD) &&
						(vcnt >= `V_SYNC + `V_BACK && vcnt < `V_SYNC + `V_BACK + `V_DISP) 
						? 1'b1 : 1'b0;
//lcd xpos & ypos
assign	lcd_xpos	= 	lcd_request ? (hcnt - (`H_SYNC + `H_BACK - H_AHEAD)) : 11'd0;
assign	lcd_ypos	= 	lcd_request ? (vcnt - (`V_SYNC + `V_BACK)) : 12'd0;



endmodule
