`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/26 10:52:47
// Design Name: 
// Module Name: hdmi_data_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module hdmi_data_gen
	(
	input				pix_clk,
	input				turn_mode,
	output [7:0]	VGA_R,
	output [7:0]	VGA_G,
	output [7:0]	VGA_B,
	output			VGA_HS,
	output			VGA_VS,
	output			VGA_DE,
	output [3:0]    mode
	);
/*
parameter H_Total		=	1344; //2200
parameter H_Sync		=	136;
parameter H_Back		=	160;//2-4
parameter H_Active	=	1024;   //1920
parameter H_Front		=	24;
parameter H_Start		=	296; //2-3
parameter H_End		=	1320;
//-------------------------------//
// 垂直扫描参数的设定1024*600	60HZ  	
//-------------------------------//
parameter V_Total		=	628;  //1125
parameter V_Sync		=	4;
parameter V_Back		=	4;
parameter V_Active	=	600;   //1080
parameter V_Front		=	0;
parameter V_Start		=	8;
parameter V_End		=	628;
*/
/*
//---------------------------------//
// 水平扫描参数的设定1280*720  60HZ
//--------------------------------//
parameter H_Total		=	1650; //2200
parameter H_Sync		=	40; //44
parameter H_Back		=	220;//148
parameter H_Active	=	1280;   //1920
parameter H_Front		=	110; //88
parameter H_Start		=	260; //192
parameter H_End		=	1540;  //2112
//-------------------------------//
// 垂直扫描参数的设定1280*720	60HZ  	
//-------------------------------//
parameter V_Total		=	750;  //1125
parameter V_Sync		=	5;   //5
parameter V_Back		=	20; //37
parameter V_Active	=	720;  //1080
parameter V_Front		=	5; //3
parameter V_Start		=	25; //42
parameter V_End		=	745;  //1122
*/
//---------------------------------//
// 水平扫描参数的设定1980*1080  60HZ
//--------------------------------//
parameter H_Total		=	2200; //2200
parameter H_Sync		=	44; //44
parameter H_Back		=	148;//148
parameter H_Active	=	1920;   //1920
parameter H_Front		=	88; //88
parameter H_Start		=	192; //192
parameter H_End		=	2112;  //2112
//-------------------------------//
// 垂直扫描参数的设定1920*1080	60HZ  	
//-------------------------------//
parameter V_Total		=	1125;  //1125
parameter V_Sync		=	5;   //5
parameter V_Back		=	37; //37
parameter V_Active	=	1080;  //1080
parameter V_Front		=	3; //3
parameter V_Start		=	42; //42
parameter V_End		=	1122;  //1122
reg[11:0]	x_cnt;
always @(posedge pix_clk)		//水平计数
begin
	if(1'b0)
	x_cnt	<=	1;
	else if(x_cnt==H_Total)
	x_cnt	<=	1;
	else
	x_cnt	<=	x_cnt	+	1;
end

reg	hsync_r;
reg	hs_de;
always @(posedge pix_clk)
begin
	if(1'b0)
	hsync_r	<=	1'b1;
	else if(x_cnt==1)
	hsync_r	<=	1'b0;
	else if(x_cnt==H_Sync)
	hsync_r	<=	1'b1;
	
	if(1'b0)
	hs_de	<=	1'b0;
	else if(x_cnt==H_Start)
	hs_de	<=	1'b1;
	else if(x_cnt==H_End)
	hs_de	<=	1'b0;
end

reg[11:0]	y_cnt;
always @(posedge pix_clk)
begin
	if(1'b0)
	y_cnt	<=	1;
	else if(y_cnt==V_Total)
	y_cnt	<=	1;
	else if(x_cnt==H_Total)
	y_cnt	<=	y_cnt	+	1;
end

reg	vsync_r;
reg	vs_de;
always @(posedge pix_clk)
begin
	if(1'b0)
	vsync_r	<=	1'b1;
	else if(y_cnt==1)
	vsync_r	<=	1'b0;
	else if(y_cnt==V_Sync)
	vsync_r	<=	1'b1;
	
	if(1'b0)
	vs_de	<=	1'b0;
	else if(y_cnt==V_Start)
	vs_de	<=	1'b1;
	else if(y_cnt==V_End)
	vs_de	<=	1'b0;
end

reg[7:0]	grid_data_1;
reg[7:0]	grid_data_2;
always @(posedge pix_clk)			//格子图像
begin
	if((x_cnt[4]==1'b1)^(y_cnt[4]==1'b1))
	grid_data_1	<=	8'h00;
	else
	grid_data_1	<=	8'hff;
	
	if((x_cnt[6]==1'b1)^(y_cnt[6]==1'b1))
	grid_data_2	<=	8'h00;
	else
	grid_data_2	<=	8'hff;
end

reg[23:0]	color_bar;
always @(posedge pix_clk)
begin
	if(x_cnt==192)
	color_bar	<=	24'hff0000;
	else if(x_cnt==432)
	color_bar	<=	24'h00ff00;
	else if(x_cnt==672)
	color_bar	<=	24'h0000ff;
	else if(x_cnt==912)
	color_bar	<=	24'hff00ff;
	else if(x_cnt==1152)
	color_bar	<=	24'hffff00;
	else if(x_cnt==1392)
	color_bar	<=	24'h00ffff;
	else if(x_cnt==1632)
	color_bar	<=	24'hffffff;
	else if(x_cnt==1872)
	color_bar	<=	24'h000000;
	else
	color_bar	<=	color_bar;
end

reg[16:0] key_counter;
reg[3:0]	dis_mode;
assign mode=dis_mode;
always @(posedge pix_clk)		//按键处理程序
begin
	if(turn_mode==1'b0)
	key_counter	<=	14'b0;
	else if((turn_mode==1'b1)&(key_counter<=17'h11704))
	key_counter	<=	key_counter	+	1'b1;
	
	if(key_counter==17'h11704)
	begin
			if(dis_mode==4'd12)
			dis_mode	<=	4'd0;
			else
			dis_mode	<=	dis_mode	+ 1'b1;
	end
end

reg[7:0]	VGA_R_reg;
reg[7:0]	VGA_G_reg;
reg[7:0]	VGA_B_reg;
always @(posedge pix_clk)
begin  
	if(1'b0) 
		begin 
		VGA_R_reg<=0; 
	   VGA_G_reg<=0;
	   VGA_B_reg<=0;		 
		end
   else
     case(dis_mode)
         4'd0:begin
			        VGA_R_reg<=0;            //LCD显示彩色条
                 VGA_G_reg<=0;
                 VGA_B_reg<=0;
			end
			4'd1:begin
			        VGA_R_reg<=8'b11111111;                 //LCD显示全白
                 VGA_G_reg<=8'b11111111;
                 VGA_B_reg<=8'b11111111;
			end
			4'd2:begin
			        VGA_R_reg<=8'b11111111;                //LCD显示全红
                 VGA_G_reg<=0;
                 VGA_B_reg<=0;  
         end			  
	      4'd3:begin
			        VGA_R_reg<=0;                          //LCD显示全绿
                 VGA_G_reg<=8'b11111111;
                 VGA_B_reg<=0; 
         end					  
         4'd4:begin     
			        VGA_R_reg<=0;                         //LCD显示全蓝
                 VGA_G_reg<=0;
                 VGA_B_reg<=8'b11111111;
			end
         4'd5:begin     
			        VGA_R_reg<=grid_data_1;               // LCD显示方格1
                 VGA_G_reg<=grid_data_1;
                 VGA_B_reg<=grid_data_1;
         end					  
         4'd6:begin     
			        VGA_R_reg<=grid_data_2;               // LCD显示方格2
                 VGA_G_reg<=grid_data_2;
                 VGA_B_reg<=grid_data_2;
			end
		   4'd7:begin     
			        VGA_R_reg<=x_cnt[7:0];                //LCD显示水平渐变色
                 VGA_G_reg<=x_cnt[7:0];
                 VGA_B_reg<=x_cnt[7:0];
			end
		   4'd8:begin     
			        VGA_R_reg<=y_cnt[8:1];                 //LCD显示垂直渐变色
                 VGA_G_reg<=y_cnt[8:1];
                 VGA_B_reg<=y_cnt[8:1];
			end
		   4'd9:begin     
			        VGA_R_reg<=x_cnt[7:0];                 //LCD显示红水平渐变色
                 VGA_G_reg<=0;
                 VGA_B_reg<=0;
			end
		   4'd10:begin     
			        VGA_R_reg<=0;                          //LCD显示绿水平渐变色
                 VGA_G_reg<=x_cnt[7:0];
                 VGA_B_reg<=0;
			end
		   4'd11:begin     
			        VGA_R_reg<=0;                          //LCD显示蓝水平渐变色
                 VGA_G_reg<=0;
                 VGA_B_reg<=x_cnt[7:0];			
			end
		   4'd12:begin     
			        VGA_R_reg<=color_bar[23:16];            //LCD显示彩色条
                 VGA_G_reg<=color_bar[15:8];
                 VGA_B_reg<=color_bar[7:0];			
			end
		   default:begin
			        VGA_R_reg<=8'b11111111;                //LCD显示全白
                 VGA_G_reg<=8'b11111111;
                 VGA_B_reg<=8'b11111111;
			end					  
         endcase
end

assign VGA_HS	=	hsync_r;
assign VGA_VS	=	vsync_r;
assign VGA_DE	=	hs_de	&	vs_de;
assign VGA_R	=	(hs_de & vs_de)?VGA_R_reg:8'h0;
assign VGA_G	=	(hs_de & vs_de)?VGA_G_reg:8'h0;
assign VGA_B	=	(hs_de & vs_de)?VGA_B_reg:8'h0;
endmodule
