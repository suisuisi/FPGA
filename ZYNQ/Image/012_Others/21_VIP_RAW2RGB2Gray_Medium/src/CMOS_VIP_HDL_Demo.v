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
Filename			:		CMOS_VIP_HDL_Demo.v
Date				:		2014-05-16
Description			:		Convert RAW to RGB888 -> YUV422 -> Median.
Modification History	:
Date			By			Version			Change Description
=========================================================================
14/05/18		CrazyBingo	1.0				Original
17/04/21		CrazyBingo	3.0				Perfect some bugs and details
-------------------------------------------------------------------------
|                                     Oooo								|
+------------------------------oooO--(   )-----------------------------+
                              (   )   ) /
                               \ (   (_/
                                \_)
----------------------------------------------------------------------*/ 

`timescale 1ns / 1ns
module CMOS_VIP_HDL_Demo
(
	//global clock 50MHz
	input				clk,			//50MHz
	input				rst_n,			//global reset
	
	//sdram control
	output				sdram_clk,		//sdram clock
	output				sdram_cke,		//sdram clock enable
	output				sdram_cs_n,		//sdram chip select
	output				sdram_we_n,		//sdram write enable
	output				sdram_cas_n,	//sdram column address strobe
	output				sdram_ras_n,	//sdram row address strobe
//	output		[3:0]	sdram_dqm,		//sdram data enable
	output		[1:0]	sdram_ba,		//sdram bank address
	output		[11:0]	sdram_addr,		//sdram address
	inout		[23:0]	sdram_data,		//sdram data
	
	//lcd port
	output				lcd_dclk,		//lcd pixel clock			
	output				lcd_hs,			//lcd horizontal sync 
	output				lcd_vs,			//lcd vertical sync
//	output				lcd_sync,		//lcd sync
//	output				lcd_blank,		//lcd blank(L:blank)
	output				lcd_de,			//lcd data enable
	output		[7:0]	lcd_red,		//lcd red data
	output		[7:0]	lcd_green,		//lcd green data
	output		[7:0]	lcd_blue,		//lcd blue data

	//cmos interface
	output				cmos_sclk,		//cmos i2c clock
	inout				cmos_sdat,		//cmos i2c data
	input				cmos_pclk,		//cmos pxiel clock
	output				cmos_xclk,		//cmos externl clock
	input				cmos_vsync,		//cmos vsync
	input				cmos_href,		//cmos hsync refrence
	input		[7:0]	cmos_data,		//cmos data
	output				cmos_ctl0,
	output				cmos_ctl1,		//cmos fsin
	output				cmos_ctl2,		//cmos pwdn	
	
	//74595 led interface
	output				led595_dout,	//74hc595 serial data input	
	output				led595_clk,		//74hc595 shift clock (rising edge)
	output				led595_latch	//74hc595 latch clock (rising edge)
);
assign	cmos_ctl0 = 1'b0;
assign	cmos_ctl1 = 1'b0;	//cmos fsin
assign	cmos_ctl2 = 1'b0;	//cmos pwdn

//---------------------------------------------
//system global clock control
wire	sys_rst_n;		//global reset
wire	clk_ref;		//sdram ctrl clock
wire	clk_refout;		//sdram clock output
wire	clk_vga;		//vga clock
wire	clk_cmos;		//24MHz cmos clock
wire	clk_48M;		//48MHz SignalTap II Clock
system_ctrl_pll	u_system_ctrl_pll
(
	.clk				(clk),			//global clock
	.rst_n				(rst_n),		//external reset
	
	.sys_rst_n			(sys_rst_n),	//global reset
	.clk_c0				(clk_ref),		//100MHz 
	.clk_c1				(clk_refout),	//100MHz -90deg
	.clk_c2				(clk_vga),		//25MHz
	.clk_c3				(clk_cmos)		//24MHz
//	.clk_c4				(clk_48M)		//48MHz SignalTap II Clock
);
localparam	CLOCK_MAIN	=	100_000000;
localparam	CLOCK_CMOS	=	24_000000;

//----------------------------------------------
//i2c timing controller module
wire	[7:0]	i2c_config_index;
wire	[15:0]	i2c_config_data;
wire	[7:0]	i2c_config_size;
wire			i2c_config_done;
wire	[7:0]	i2c_rdata;		//i2c register data
i2c_timing_ctrl
#(
	.CLK_FREQ	(CLOCK_MAIN),	//100 MHz
	.I2C_FREQ	(100_000)		//100 kHz(<= 400KHz)
)
u_i2c_timing_ctrl
(
	//global clock
	.clk				(clk_ref),		//100MHz
	.rst_n				(sys_rst_n),	//system reset
			
	//i2c interface
	.i2c_sclk			(cmos_sclk),	//i2c clock
	.i2c_sdat			(cmos_sdat),	//i2c data for bidirection

	//i2c config data
	.i2c_config_index	(i2c_config_index),	//i2c config reg index, read 2 reg and write xx reg
	.i2c_config_data	({8'h42, i2c_config_data}),	//i2c config data
	.i2c_config_size	(i2c_config_size),	//i2c config data counte
	.i2c_config_done	(i2c_config_done),	//i2c config timing complete
	.i2c_rdata			(i2c_rdata)			//i2c register data while read i2c slave
);

//----------------------------------------------
//I2C Configure Data of OV7725
//I2C_OV7725_RGB565_Config	u_I2C_OV7725_RGB565_Config
I2C_OV7725_RAW_Config	u_I2C_OV7725_RAW_Config
(
	.LUT_INDEX		(i2c_config_index),
	.LUT_DATA		(i2c_config_data),
	.LUT_SIZE		(i2c_config_size)
);


//assign	cmos_xclk = clk_cmos;
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
//cmos video image capture
wire			cmos_init_done = i2c_config_done & sdram_init_done;	///cmos camera init done
wire			cmos_frame_vsync;	//cmos frame data vsync valid signal
wire			cmos_frame_href;	//cmos frame data href vaild  signal
wire	[7:0]	cmos_frame_RAW;		//cmos frame data output: 8 Bit raw data
wire	[7:0]	cmos_fps_rate;		//cmos image output rate
CMOS_Capture_RAW_Gray	
#(
	.CMOS_FRAME_WAITCNT		(4'd10)				//Wait n fps for steady(OmniVision need 10 Frame)
)
u_CMOS_Capture_RAW_Gray
(
	//global clock
	.clk_cmos				(clk_cmos),			//24MHz CMOS Driver clock input
	.rst_n					(sys_rst_n & cmos_init_done),	//global reset

	//CMOS Sensor Interface
	.cmos_pclk				(cmos_pclk),  		//24MHz CMOS Pixel clock input
	.cmos_xclk				(cmos_xclk),		//24MHz drive clock
	.cmos_data				(cmos_data),		//8 bits cmos data input
	.cmos_vsync				(cmos_vsync),		//L: vaild, H: invalid
	.cmos_href				(cmos_href),		//H: vaild, L: invalid
	
	//CMOS SYNC Data output
	.cmos_frame_vsync		(cmos_frame_vsync),	//cmos frame data vsync valid signal
	.cmos_frame_href		(cmos_frame_href),	//cmos frame data href vaild  signal
	.cmos_frame_data		(cmos_frame_RAW),	//cmos frame data output: 8 Bit raw data
	
	//user interface
	.cmos_fps_rate			(cmos_fps_rate)		//cmos image output rate
);
wire	[7:0]	led_data = cmos_fps_rate;
//wire	[7:0]	led_data = LUT_INDEX;
//wire	[7:0]	led_data = i2c_rdata;

//----------------------------------------------------
//Video Image processor module.
//Image data prepred to be processd
wire			per_frame_vsync	=	cmos_frame_vsync;	//Prepared Image data vsync valid signal
wire			per_frame_href	=	cmos_frame_href;	//Prepared Image data href vaild  signal
wire	[7:0]	per_img_RAW	=	cmos_frame_RAW;		//Prepared Image data 8 Bit RAW Data
wire			post_frame_vsync;	//Processed Image data vsync valid signal
wire			post_frame_href;	//Processed Image data href vaild  signal
wire	[7:0]	post_img_Gray;		//Processed Image Gray output
Video_Image_Processor	
#(
	.IMG_HDISP	(640),	//640*480
	.IMG_VDISP	(480)
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
	.post_img_Gray			(post_img_Gray)			//Processed Image Gray output
);


//--------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
//Sdram_Control_2Port module 	
//sdram write port
wire			clk_write	=	cmos_pclk;	//Change with input signal											
wire	[23:0]	sys_data_in = 	{post_img_Gray, post_img_Gray, post_img_Gray};
wire			sys_we 		= 	 post_frame_href;
//sdram read port
wire			clk_read	=	clk_vga;	//Change with vga timing	
wire	[23:0]	sys_data_out;
wire			sys_rd;
wire			sdram_init_done;			//sdram init done
Sdram_Control_2Port	u_Sdram_Control_2Port
(
	//	HOST Side
	.REF_CLK			(clk_ref),			//sdram module clock
	.OUT_CLK			(clk_refout),		//sdram clock input
	.RESET_N			(sys_rst_n),		//sdram module reset

	//	SDRAM Side
	.SDR_CLK			(sdram_clk),		//sdram clock
	.CKE				(sdram_cke),		//sdram clock enable
	.CS_N				(sdram_cs_n),		//sdram chip select
	.WE_N				(sdram_we_n),		//sdram write enable
	.CAS_N				(sdram_cas_n),		//sdram column address strobe
	.RAS_N				(sdram_ras_n),		//sdram row address strobe
	.DQM				(),//(sdram_dqm),		//sdram data output enable
	.BA					(sdram_ba),			//sdram bank address
	.SA					(sdram_addr),		//sdram address
	.DQ					(sdram_data),		//sdram data

	//	FIFO Write Side
	.WR_CLK				(clk_write),		//write fifo clock
	.WR_LOAD			(1'b0),				//write register load & fifo clear
	.WR_DATA			(sys_data_in),		//write data input
	.WR					(sys_we),			//write data request
	.WR_MIN_ADDR		(22'd0),			//write start address
	.WR_MAX_ADDR		(22'd640 * 22'd480),	//write max address
	.WR_LENGTH			(9'd256),			//write burst length

	//	FIFO Read Side
	.RD_CLK				(clk_read),			//read fifo clock
	.RD_LOAD			(1'b0),				//read register load & fifo clear
	.RD_DATA			(sys_data_out),		//read data output
	.RD					(sys_rd),			//read request
	.RD_MIN_ADDR		(22'd0),            //read start address
	.RD_MAX_ADDR		(22'd640 * 22'd480),	//read max address
	.RD_LENGTH			(9'd128),			//read length
	
	//User interface add by CrazyBingo
	.Sdram_Init_Done	(sdram_init_done),	//SDRAM init done signal
	.Sdram_Read_Valid	(1'b1),				//Enable to read
	.Sdram_PingPong_EN	(1'b1)				//SDRAM PING-PONG operation enable
);


//-------------------------------------
//LCD driver timing
wire	[23:0]	lcd_data_in;		//lcd data input
lcd_driver u_lcd_driver
(
	//global clock
	.clk			(clk_vga),		
	.rst_n			(sys_rst_n), 
	 
	 //lcd interface
	.lcd_dclk		(lcd_dclk),
	.lcd_blank		(),//lcd_blank
	.lcd_sync		(),		    	
	.lcd_hs			(lcd_hs),		
	.lcd_vs			(lcd_vs),
	.lcd_en			(lcd_de),		
	.lcd_rgb		({lcd_red, lcd_green ,lcd_blue}),

	
	//user interface
	.lcd_request	(sys_rd),
	.lcd_data		(sys_data_out),	
	.lcd_xpos		(),	
	.lcd_ypos		()
);


//---------------------------
//The driver of 74HC595
led_74595_driver	u_led_74595_driver
(
	//global clock
	.clk				(clk_ref),
	.rst_n				(sys_rst_n),

	//74hc595 interface
	.led595_dout		(led595_dout),	//74hc595 serial data input	
	.led595_clk			(led595_clk),	//74hc595 shift clock (rising edge)
	.led595_latch		(led595_latch),	//74hc595 latch clock (risign edge)

	//user interface
	.led_data			(led_data)	//led data input	
);
endmodule
