//****************************************************************************//
//# @Author: 碎碎�?
//# @Date:   2019-11-03 01:23:11
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-11-03 01:25:41
//# Description: 
//# @Modification History: 2017-04-22 09:19:50
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2017-04-22 09:19:50 CrazyBingo	1.0	
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
`timescale 1ns/1ns
module Image_YCbCr444_RGB888
(
	//global clock
	input				clk,  				//cmos video pixel clock
	input				rst_n,				//global reset

	//CMOS YCbCr444 data output
	input				per_frame_vsync,	//Prepared Image data vsync valid signal
	input				per_frame_href,		//Prepared Image data href vaild  signal
	input				per_frame_clken,	//Prepared Image data output/capture enable clock	
	input		[7:0]	per_img_Y,			//Prepared Image data of Y
	input		[7:0]	per_img_Cb,			//Prepared Image data of Cb
	input		[7:0]	per_img_Cr,			//Prepared Image data of Cr

	
	//CMOS RGB888 data output
	output				post_frame_vsync,	//Processed Image data vsync valid signal
	output				post_frame_href,	//Processed Image data href vaild  signal
	output				post_frame_clken,	//Processed Image data output/capture enable clock
	output		[7:0]	post_img_red,		//Prepared Image green data to be processed	
	output		[7:0]	post_img_green,		//Prepared Image green data to be processed
	output		[7:0]	post_img_blue		//Prepared Image blue data to be processed
);

//--------------------------------------------
/*********************************************
	R = 1.164(Y-16) + 1.596(Cr-128)
	G = 1.164(Y-16) - 0.391(Cb-128) - 0.813(Cr-128)
	B = 1.164(Y-16) + 2.018(Cb-128)
	->
	R = 1.164Y + 1.596Cr - 222.912
	G = 1.164Y - 0.391Cb - 0.813Cr + 135.488
	B = 1.164Y + 2.018Cb - 276.928
	->
	R << 9 = 596Y				+ 	817Cr	-	114131
	G << 9 = 596Y	-	200Cb	-	416Cr	+	69370
	B << 9 = 596Y	+	1033Cb				-	141787
**********************************************/
reg	[19:0]	img_Y_r1; 				//8 + 9 + 1 = 18Bit
reg	[19:0]	img_Cb_r1, img_Cb_r2; 
reg	[19:0]	img_Cr_r1, img_Cr_r2;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		img_Y_r1 <= 0;
		img_Cb_r1 <= 0;	img_Cb_r2 <= 0;	
		img_Cr_r1 <= 0; img_Cr_r2 <= 0;
		end
	else
		begin
		img_Y_r1	<= 	per_img_Y * 18'd596;
		img_Cb_r1 	<= 	per_img_Cb * 18'd200;	
		img_Cb_r2	<=	per_img_Cb * 18'd1033;	
		img_Cr_r1 	<= 	per_img_Cr * 18'd817;	
		img_Cr_r2	<=	per_img_Cr * 18'd416;
		end
end

//--------------------------------------------
/**********************************************
	R << 9 = 596Y				+ 	817Cr	-	114131
	G << 9 = 596Y	-	200Cb	-	416Cr	+	69370
	B << 9 = 596Y	+	1033Cb				-	141787
**********************************************/
reg	[19:0]	XOUT; 	
reg	[19:0]	YOUT; 
reg	[19:0]	ZOUT;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		XOUT <= 0; 	
		YOUT <= 0; 
		ZOUT <= 0;
		end
	else
		begin
		XOUT <= (img_Y_r1 + img_Cr_r1 - 20'd114131)>>9; 	
		YOUT <= (img_Y_r1 - img_Cb_r1 - img_Cr_r2 + 20'd69370)>>9; 
		ZOUT <= (img_Y_r1 + img_Cb_r2 - 20'd141787)>>9;
		end
end

//------------------------------------------
//Divide 512 and get the result
//{xx[19:11], xx[10:0]}
reg	[7:0]	R, G, B;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		R <= 0;
		G <= 0;
		B <= 0;
		end
	else
		begin
		R <= XOUT[10] ? 8'd0 : (XOUT[9:0] > 9'd255) ? 8'd255 : XOUT[7:0];
		G <= YOUT[10] ? 8'd0 : (YOUT[9:0] > 9'd255) ? 8'd255 : YOUT[7:0];
		B <= ZOUT[10] ? 8'd0 : (ZOUT[9:0] > 9'd255) ? 8'd255 : ZOUT[7:0];
		end
end

//------------------------------------------
//lag n clocks signal sync  	 
reg	[2:0]	post_frame_vsync_r;
reg	[2:0]	post_frame_href_r;
reg	[2:0]	post_frame_clken_r;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		post_frame_vsync_r 	<= 	0;
		post_frame_href_r 	<= 	0;
		post_frame_clken_r 	<= 	0;
		end
	else
		begin
		post_frame_vsync_r 	<= 	{post_frame_vsync_r[1:0], per_frame_vsync};
		post_frame_href_r 	<= 	{post_frame_href_r[1:0], 	per_frame_href};
		post_frame_clken_r 	<= 	{post_frame_clken_r[1:0], per_frame_clken};
		end
end
assign	post_frame_vsync 	= 	post_frame_vsync_r[2];
assign	post_frame_href 	= 	post_frame_href_r[2];
assign	post_frame_clken 	= 	post_frame_clken_r[2];
assign	post_img_red	=	post_frame_href ? R : 8'd0;
assign  post_img_green	=	post_frame_href ? G : 8'd0;
assign  post_img_blue	=	post_frame_href ? B : 8'd0;

endmodule
