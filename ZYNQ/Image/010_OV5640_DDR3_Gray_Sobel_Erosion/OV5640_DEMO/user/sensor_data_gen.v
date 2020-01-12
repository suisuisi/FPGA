`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/06/12 13:20:12
// Design Name: 
// Module Name: sensor_data_gen
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

module  sensor_data_gen (
    input clk,
    output [7:0] r,
    output [7:0] g,
    output [7:0] b,
    output de,
    output vsync,
    output hsync
    );

   reg  [23:0] colour=24'd0;
   reg  [11:0] hcounter=12'd0;
   reg  [11:0] vcounter=12'd0;
    
// Colours converted using The RGB -> YCbCr converter app found on Google Gadgets 
                                //   Y    Cb   Cr
   `define C_BLACK 24'h000000;  //  16   128  128
   `define C_RED   24'hFF0000;  //  81   90   240
   `define C_GREEN 24'h00FF00;  //  172  42   27
   `define C_BLUE  24'h0000FF;  //  32   240  118
   `define C_WHITE 24'hFFFFFF;  //  234  128  128
	
	
//	-- Set the video mode to 1920x1080x60Hz (150MHz pixel clock needed)
 /*    parameter hVisible  = 1920;
   parameter hStartSync = 1920+88;
   parameter hEndSync   = 1920+88+44;
   parameter hMax       = 1920+88+44+148; //2200
   
   parameter vVisible    = 1080;
   parameter vStartSync  = 1080+4;
   parameter vEndSync    = 1080+4+5;
   parameter vMax        = 1080+4+5+36; //1125
	*/
	
//	-- Set the video mode to 1440x900x60Hz (106.47MHz pixel clock needed)
/*   parameter hVisible   = 1440;
   parameter hStartSync = 1440+80;
   parameter hEndSync   = 1440+80+152;
   parameter hMax       = 1440+80+152+232; //1904
   
   parameter vVisible    = 900;
   parameter vStartSync  = 900+1;
   parameter vEndSync    = 900+1+3;
   parameter vMax        = 900+1+3+28; //932
   */

    
//	-- Set the video mode to 1280x720x60Hz (75MHz pixel clock needed)
  /*parameter hVisible   = 1280;
   parameter hStartSync = 1280+72;
   parameter hEndSync   = 1280+72+80;
   parameter hMax       = 1280+72+80+216; //1647
   
   parameter vVisible    = 720;
   parameter vStartSync  = 720+3;
   parameter vEndSync    = 720+3+5;
   parameter vMax        = 720+3+5+22; //749
	*/
	
//	-- Set the video mode to 800x600x60Hz (40MHz pixel clock needed)
/*   parameter hVisible   = 800;
   parameter hStartSync = 840; //800+40
   parameter hEndSync   = 968; //800+40+128
   parameter hMax       = 1056; //800+40+128+88
   
   parameter vVisible    = 600;
   parameter vStartSync  = 601; //600+1
   parameter vEndSync    = 605; //600+1+4
   parameter vMax        = 628; //600+1+4+23      
*/


//	-- Set the video mode to 640x480x60Hz (25MHz pixel clock needed)
 
   parameter hVisible   = 640;
   parameter hStartSync = 656; //640+16
   parameter hEndSync   = 752; //640+16+96
   parameter hMax       = 800; //640+16+96+48
   
   parameter vVisible    = 480;
   parameter vStartSync  = 490; //480+10
   parameter vEndSync    = 492; //480+10+2
   parameter vMax        = 525; //480+10+2+33

//------------------------------------------
//v_sync counter & generator 
 
always@(posedge clk) begin
if(hcounter < hMax - 12'd1)        //line over
	hcounter <= hcounter + 12'd1;
else
	hcounter <= 12'd0; 
end
 
always@(posedge clk) begin
if(hcounter == hMax - 12'd1) begin
	if(vcounter < vMax - 12'd1)  //frame over
		vcounter <= vcounter + 12'd1;
	else
		vcounter <= 12'd0;
	end
end

assign hsync = ((hcounter >= (hStartSync - 2'd2))&&(hcounter < (hEndSync - 2'd2)))? 1'b0:1'b1;  //Generate the hSync Pulses
assign vsync = ((vcounter >= (vStartSync - 1'b1))&&(vcounter < (vEndSync - 1'b1)))? 1'b0:1'b1; //Generate the vSync Pulses
  
        
 always@(posedge clk) begin
    if (hcounter <= hVisible/5) begin colour <= `C_RED; end
    else if(hcounter <= 2*hVisible/5) begin colour <= `C_GREEN; end
    else if(hcounter <= 3*hVisible/5) begin colour <= `C_BLUE; end
    else if(hcounter <= 4*hVisible/5) begin colour <= `C_WHITE; end
    else  begin colour <= `C_BLACK; end
 end
/*	 
  assign r = colour[23:16];
  assign g = colour[15:8];
  assign b = colour[7:0];
  */

reg [7:0]VGA_R_reg;
reg [7:0]VGA_G_reg;
reg [7:0]VGA_B_reg;
reg [10:0] dis_mode;
always @(posedge clk) begin
    if((vcounter == vMax - 12'd1)&&(hcounter == hMax - 12'd1))
        dis_mode <= dis_mode +1'b1;

end

reg[7:0]	grid_data_1;
reg[7:0]	grid_data_2;
always @(posedge clk)			//格子图像
begin
	if((hcounter[4]==1'b1)^(vcounter[4]==1'b1))
	grid_data_1	<=	8'h00;
	else
	grid_data_1	<=	8'hff;
	
	if((hcounter[6]==1'b1)^(vcounter[6]==1'b1))
	grid_data_2	<=	8'h00;
	else
	grid_data_2	<=	8'hff;
end

reg[23:0]	color_bar;
always @(posedge clk)
begin
	if(hcounter==260)
	color_bar	<=	24'hff0000;
	else if(hcounter==420)
	color_bar	<=	24'h00ff00;
	else if(hcounter==580)
	color_bar	<=	24'h0000ff;
	else if(hcounter==740)
	color_bar	<=	24'hff00ff;
	else if(hcounter==900)
	color_bar	<=	24'hffff00;
	else if(hcounter==1060)
	color_bar	<=	24'h00ffff;
	else if(hcounter==1220)
	color_bar	<=	24'hffffff;
	else if(hcounter==1380)
	color_bar	<=	24'h000000;
	else
	color_bar	<=	color_bar;
end

always @(posedge clk)
begin  
	if(1'b0) 
		begin 
	   VGA_R_reg<=0; 
	   VGA_G_reg<=0;
	   VGA_B_reg<=0;		 
		end
   else
   VGA_R_reg<=hcounter[7:0];
   VGA_G_reg<=hcounter[7:0];
   VGA_B_reg<=hcounter[7:0];
  
     case(dis_mode[10:7])
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
			     VGA_R_reg<=hcounter[7:0];                //LCD显示水平渐变色
                 VGA_G_reg<=hcounter[7:0];
                 VGA_B_reg<=hcounter[7:0];
			 end
		     4'd8:begin     
			     VGA_R_reg<=vcounter[8:1];                 //LCD显示垂直渐变色
                 VGA_G_reg<=hcounter[8:1];
                 VGA_B_reg<=hcounter[8:1];
			end
		     4'd9:begin     
			     VGA_R_reg<=hcounter[7:0];                 //LCD显示红水平渐变色
                 VGA_G_reg<=0;
                 VGA_B_reg<=0;
			end
		     4'd10:begin     
			     VGA_R_reg<=0;                          //LCD显示绿水平渐变色
                 VGA_G_reg<=hcounter[7:0];
                 VGA_B_reg<=0;
			end
		     4'd11:begin     
			     VGA_R_reg<=0;                          //LCD显示蓝水平渐变色
                 VGA_G_reg<=0;
                 VGA_B_reg<=hcounter[7:0];			
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

  assign de = (vcounter >= vVisible || hcounter >= hVisible) ? 1'b0 : 1'b1;
  assign r = VGA_R_reg; 
  assign g = VGA_G_reg; 
  assign b = VGA_B_reg; 
  
 endmodule
 