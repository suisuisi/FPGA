//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-03 01:23:11
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-11-03 01:25:15
//# Description: 
//# @Modification History: 2017-04-22 09:19:50
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2017-04-22 09:19:50 CrazyBingo     V1
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//

`timescale 1ns/1ns
module Video_Image_Processor
(
	//global clock
	input				clk,  				//cmos video pixel clock
	input				rst_n,				//global reset

	//Image data prepred to be processd
	input				per_frame_vsync,	//Prepared Image data vsync valid signal
	input				per_frame_href,		//Prepared Image data href vaild  signal
	input				per_frame_clken,	//Prepared Image data output/capture enable clock
	input		[15:0]	per_frame_YCbCr,	//Prepared Image data of YCbCr 4:2:2 {CbY} {CrY}

	//Image data has been processd
	output				post_frame_vsync,	//Processed Image data vsync valid signal
	output				post_frame_href,	//Processed Image data href vaild  signal
	output				post_frame_clken,	//Processed Image data output/capture enable clock
	output		[7:0]	post_img_red,		//Processed Image Red output
	output		[7:0]	post_img_green,		//Processed Image Green output
	output		[7:0]	post_img_blue		//Processed Image Blue output
);


//-------------------------------------
//Convert the YCbCr4:2:2 format to YCbCr4:4:4 format.
	//CMOS YCbCr444 data output
wire			post1_frame_vsync;	//Processed Image data vsync valid signal
wire			post1_frame_href;	//Processed Image data href vaild  signal
wire			post1_frame_clken;	//Processed Image data output/capture enable clock	
wire	[7:0]	post1_img_Y;		//Processed Image data of YCbCr 4:4:4
wire	[7:0]	post1_img_Cb;		//Processed Image data of YCbCr 4:4:4
wire	[7:0]	post1_img_Cr;		//Processed Image data of YCbCr 4:4:4
Image_YCbCr422_YCbCr444	u_VIP_YCbCr422_YCbCr444
(
	//global clock
	.clk					(clk),					//cmos video pixel clock
	.rst_n					(rst_n),				//system reset

	//Image data prepred to be processd
	.per_frame_vsync		(per_frame_vsync),		//Prepared Image data vsync valid signal
	.per_frame_href			(per_frame_href),		//Prepared Image data href vaild  signal
	.per_frame_clken		(per_frame_clken),		//Prepared Image data output/capture enable clock
	.per_frame_YCbCr		(per_frame_YCbCr),		//Prepared Image red data to be processed


	//Image data has been processd
	.post_frame_vsync		(post1_frame_vsync),	//Processed Image data vsync valid signal
	.post_frame_href		(post1_frame_href),		//Processed Image data href vaild  signal
	.post_frame_clken		(post1_frame_clken),	//Processed Image data output/capture enable clock
	.post_img_Y				(post1_img_Y),			//Processed Image brightness output
	.post_img_Cb			(post1_img_Cb),			//Processed Image blue shading output
	.post_img_Cr			(post1_img_Cr)			//Processed Image red shading output
);
//-------------------------------------
//Convert the YCbCr444 format to RGB888 format.
Image_YCbCr444_RGB888	u_VIP_YCbCr444_RGB888
(
	//global clock
	.clk					(clk),					//cmos video pixel clock
	.rst_n					(rst_n),				//system reset

	//Image data prepred to be processd
	.per_frame_vsync		(post1_frame_vsync),	//Prepared Image data vsync valid signal
	.per_frame_href			(post1_frame_href),		//Prepared Image data href vaild  signal
	.per_frame_clken		(post1_frame_clken),	//Prepared Image data output/capture enable clock
	.per_img_Y				(post1_img_Y),			//Prepared Image data of Y
	.per_img_Cb				(post1_img_Cb),			//Prepared Image data of Cb
	.per_img_Cr				(post1_img_Cr),			//Prepared Image data of Cr
	
	//Image data has been processd
	.post_frame_vsync		(post_frame_vsync),		//Processed Image data vsync valid signal
	.post_frame_href		(post_frame_href),		//Processed Image data href vaild  signal
	.post_frame_clken		(post_frame_clken),		//Processed Image data output/capture enable clock
	.post_img_red			(post_img_red),			//Prepared Image green data to be processed	
	.post_img_green			(post_img_green),		//Prepared Image green data to be processed
	.post_img_blue			(post_img_blue)			//Prepared Image blue data to be processed
);

endmodule
