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
Filename			:		Video_Image_Processor_TB.v
Date				:		2013-11-08
Description			:		The testbench of cmos data of Video_Image_Processor Module.
Modification History	:
Date			By			Version			Change Description
=========================================================================
13/11/08		CrazyBingo	1.0				Original
14/05/03		CrazyBingo	1.1				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module Video_Image_Processor_TB;

//------------------------------------------
//Generate 24MHz driver clock
reg	clk; 
localparam PERIOD2 = 41;		//24MHz
initial	
begin
	clk = 0;
	forever	#(PERIOD2/2)	
	clk = ~clk;
end

//------------------------------------------
//Generate global reset
reg	rst_n;
task task_reset;
begin
	rst_n = 0;
	repeat(2) @(negedge clk);
	rst_n = 1;
end
endtask
wire	clk_cmos = clk;		//24MHz
wire	sys_rst_n = rst_n;	

localparam	[9:0]	IMG_HDISP = 10'd16;	
localparam	[9:0]	IMG_VDISP = 10'd4;
//-----------------------------------------
//CMOS Camera interface and data output simulation
wire			cmos_xclk;				//24MHz drive clock
wire			cmos_pclk;				//24MHz CMOS Pixel clock input
wire			cmos_vsync;				//L: vaild, H: invalid
wire			cmos_href;				//H: vaild, L: invalid
wire	[7:0]	cmos_data;				//8 bits cmos data input
Video_Image_Simulate_CMOS	
#(
	.CMOS_VSYNC_VALID	(1'b1),     //VSYNC = 1
	.IMG_HDISP	(IMG_HDISP),	//640*480
	.IMG_VDISP	(IMG_VDISP)
)
u_Video_Image_Simulate_CMOS
(
	//global reset
	.rst_n				(sys_rst_n),	
	
	//CMOS Camera interface and data output simulation
	.cmos_xclk			(clk_cmos),			//25MHz cmos clock
	.cmos_pclk			(cmos_pclk),		//25MHz when rgb output
	.cmos_vsync			(cmos_vsync),		//L: vaild, H: invalid
	.cmos_href			(cmos_href),		//H: vaild, L: invalid
	.cmos_data			(cmos_data)			//8 bits cmos data input
);
wire	cmos_frame_vsync = cmos_vsync;
wire	cmos_frame_href = cmos_href;
wire	[7:0]	cmos_frame_data = cmos_data;

//----------------------------------------------------
//Video Image processor module.
//Image data prepred to be processd
wire			per_frame_vsync	=	cmos_frame_vsync;	//Prepared Image data vsync valid signal
wire			per_frame_href	=	cmos_frame_href;	//Prepared Image data href vaild  signal
wire	[7:0]	per_img_RAW	=	cmos_frame_data;		//Prepared Image data 8 Bit RAW Data
wire			post_frame_vsync;	//Processed Image data vsync valid signal
wire			post_frame_href;	//Processed Image data href vaild  signal
wire	[7:0]	post_img_red;		//Processed Image Red output
wire	[7:0]	post_img_green;		//Processed Image Green output
wire	[7:0]	post_img_blue;		//Processed Image Blue output
Video_Image_Processor	
#(
	.IMG_HDISP	(IMG_HDISP),	//640*480
	.IMG_VDISP	(IMG_VDISP)
)
u_Video_Image_Processor
(
	//global clock
	.clk					(cmos_pclk),  			//cmos video pixel clock
	.rst_n					(sys_rst_n),			//global reset

	//Image data prepred to be processd
	.per_frame_vsync		(per_frame_vsync),		//Prepared Image data vsync valid signal
	.per_frame_href			(per_frame_href),		//Prepared Image data href vaild  signal
	.per_img_RAW			(per_img_RAW),			//Prepared Image data 8 Bit RAW Data


	//Image data has been processd
	.post_frame_vsync		(post_frame_vsync),		//Processed Image data vsync valid signal
	.post_frame_href		(post_frame_href),		//Processed Image data href vaild  signal
	.post_img_red			(post_img_red),			//Processed Image Red output
	.post_img_green			(post_img_green),		//Processed Image Green output
	.post_img_blue			(post_img_blue)			//Processed Image Blue output
);


//---------------------------------------------
//testbench of the RTL
task task_sysinit;
begin
end
endtask

//----------------------------------------------
initial
begin
	task_sysinit;
	task_reset;

end

endmodule

