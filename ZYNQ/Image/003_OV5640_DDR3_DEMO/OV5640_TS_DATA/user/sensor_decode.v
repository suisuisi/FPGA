`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: milinker corperation
// WEB:www.milinker.com
// BBS:www.osrc.cn
// Engineer:
// Create Date:    07:28:50 11/30/2015 
// Design Name: 	 sensor_decode
// Module Name:    sensor_decode
// Project Name: 	 sensor_decode
// Target Devices: www.osrc.cn
// Tool versions:  avivado2016.4
// Description: 	 sensor_decode
// Revision: 		 V1.0
// Additional Comments: 
//1) _i PIN input  
//2) _o PIN output
//3) _n PIN active low
//4) _dg debug signal 
//5) _r  reg delay
//6) _s state machine
//
// 
//////////////////////////////////////////////////////////////////////////////////


module sensor_decode(
	input cmos_clk_i,//cmos senseor clock.
	input rst_n_i,//system reset.active low.
	input cmos_pclk_i,//input pixel clock.
	input cmos_href_i,//input pixel hs signal.
	input cmos_vsync_i,//input pixel vs signal.
	input  [7:0]cmos_data_i,//data.
	output cmos_xclk_o,//output clock to cmos sensor.
	output hs_o,//hs signal.
	output vs_o,//vs signal.
	output [23:0] rgb_o,//data output
	output clk_ce
    );
    
assign cmos_xclk_o = cmos_clk_i;    
parameter[5:0]CMOS_FRAME_WAITCNT = 4'd15;    
reg[4:0] rst_n_reg = 5'd0;    
reg cmos_href_r;
reg cmos_vsync_r;
reg [7:0]cmos_data_r;
    
always@(posedge cmos_pclk_i)
begin
       cmos_data_r <= cmos_data_i;
       cmos_href_r <= cmos_href_i;
       cmos_vsync_r<= ~cmos_vsync_i;
end    
    
//reset signal deal with.
always@(posedge cmos_clk_i)
begin
	rst_n_reg <= {rst_n_reg[3:0],rst_n_i};
end

reg[1:0]vsync_d;
reg[1:0]href_d;
wire vsync_start;
wire vsync_end;
//vs signal deal with.
always@(posedge cmos_pclk_i)
begin
	vsync_d <= {vsync_d[0],cmos_vsync_r};
	href_d  <= {href_d[0],cmos_href_r};
end

assign vsync_end  =  vsync_d[1]&(!vsync_d[0]);
assign vsync_start  = (!vsync_d[1])&vsync_d[0];

reg[6:0]cmos_fps;
//frame count.
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		begin
		cmos_fps <= 7'd0;
		end
	else if(vsync_start)
		begin
		cmos_fps <= cmos_fps + 7'd1;
		end
	else if(cmos_fps >= CMOS_FRAME_WAITCNT)
		begin
		cmos_fps <= CMOS_FRAME_WAITCNT;
		end
end
//wait frames and output enable.
reg out_en;
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		begin
		out_en <= 1'b0;
		end
	else if(cmos_fps >= CMOS_FRAME_WAITCNT)
		begin
		out_en <= 1'b1;
		end
	else
		begin
		out_en <= out_en;
		end
end

//output data 8bit changed into 16bit in rgb565.
reg	[7:0] cmos_data_d0;
reg	[15:0]cmos_rgb565_d0;
reg	byte_flag;

always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		byte_flag <= 0;
	else if(cmos_href_r)
		byte_flag <= ~byte_flag;
	else
		byte_flag <= 0;
end

reg	byte_flag_r0;
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		byte_flag_r0 <= 0;
	else 
		byte_flag_r0 <= byte_flag;
end

always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		cmos_data_d0 <= 8'd0;
	else if(cmos_href_r)
		cmos_data_d0 <= cmos_data_r;	//MSB -> LSB
	else if(~cmos_href_r) 
		cmos_data_d0 <= 8'd0;
end

reg [15:0] rgb565;
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		rgb565 <= 16'd0;
	else if(cmos_href_r&byte_flag)
		rgb565 <= {cmos_data_d0,cmos_data_r};	//MSB -> LSB
	else if(~cmos_href_r) 
		rgb565 <= 8'd0;
end


	
	

	
reg [7:0]cnt_test;
reg [8:0]cnt_temp;

reg [11:0]vcounter;
reg [15:0]vcnt=10'd0;
always@(posedge cmos_pclk_i) begin
if(!rst_n_reg[4]) begin
    vcnt<=16'd0;
end else begin
    if(vsync_start) 
            vcounter <=12'd0;
            if(!vcnt[15])vcnt <= vcnt+1'b1;
     else if({href_d[0],cmos_href_r}==2'b01)
             vcounter <= vcounter + 12'd1;
 end
end

reg [11:0]hcounter;
always@(posedge cmos_pclk_i) begin
  if(!cmos_href_r) 
    hcounter <=12'd0;
  else 
    hcounter <= hcounter + 12'd1;
end


reg[7:0]	grid_data_1;
reg[7:0]	grid_data_2;
always @(posedge cmos_pclk_i)//¸ñ×ÓÍ¼Ïñ
begin
	if((hcounter[2]==1'b1)^(vcounter[4]==1'b1))
	grid_data_1	<=	8'h00;
	else
	grid_data_1	<=	8'hff;
	
	if((hcounter[6]==1'b1)^(vcounter[6]==1'b1))
	grid_data_2	<=	8'h00;
	else
	grid_data_2	<=	8'hff;
end

//assign rgb_o = {rgb565[15:11],3'd0 ,rgb565[10:5] ,2'd0,rgb565[4:0],3'd0};

assign rgb_o = {grid_data_2,grid_data_2,grid_data_2};
assign	clk_ce =out_en? byte_flag_r0:1'b0;
assign	vs_o = out_en ? vsync_d[1] : 1'b0;
assign	hs_o = out_en ? href_d[1] : 1'b0;

ila_2 sensor_sg (
	.clk(cmos_pclk_i), // input wire clk
	.probe0(vs_o), // input wire [0:0]  probe0  
	.probe1(hs_o), // input wire [0:0]  probe1 
	.probe2(clk_ce), // input wire [0:0]  probe2 
	.probe3(vcounter[9:0]), // input wire [0:0]  probe3 
	.probe4(grid_data_2), // input wire [0:0]  probe4 
	.probe5(hcounter[10:0])
);
endmodule
