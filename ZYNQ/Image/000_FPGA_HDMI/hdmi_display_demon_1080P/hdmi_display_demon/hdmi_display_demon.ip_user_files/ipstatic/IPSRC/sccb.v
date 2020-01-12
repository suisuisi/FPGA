`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:58:40 01/09/2015 
// Design Name: 
// Module Name:    sccb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
	module sccb(
		input clk,

		output sccb_sclk,
		inout sccb_data,
		output LUT_DATA_r
		 );
		 
	//-------------------------------------------
	//  100MHZ产生100khz 时钟
	//-------------------------------------------
	 reg[15:0] sccb_cnt = 16'd0;
	 reg       sclk_100k = 0;

	always@(posedge clk) 
	begin 
			 if(sccb_cnt < 1000)
				 sccb_cnt <= sccb_cnt+1'b1;		
			 else     
				 begin 
					 sclk_100k  <= ~sclk_100k;
					 sccb_cnt   <=0;
				 end
	end
		
	//-------------------------------------
	reg	i2c_en_r0 = 0, i2c_en_r1 = 0;
	always@(posedge clk)begin
			i2c_en_r0 <= sclk_100k;
			i2c_en_r1 <= i2c_en_r0;
	end


	wire	i2c_negclk = ((i2c_en_r1) & (~i2c_en_r0)) ? 1'b1 : 1'b0;		//negedge i2c_sclk transfer data

	//--------------------------------------------------
	//--------------------------------------------------
	reg[7:0]    initial_INDEX = 8'd0;


	parameter	initial_SIZE =	64;
	reg sccb_EN = 0;
	reg sccb_state = 0;
	wire ack;
	wire trans_finished;

	wire [15:0]	LUT_DATA;
	assign LUT_DATA_r = LUT_DATA;
	
	I2C_OV7670_RGB565_Config  my_I2C_OV7670_RGB565_Config
	(
		.LUT_INDEX(initial_INDEX),
		.LUT_DATA(LUT_DATA)
	);

	sccb_control my_sccb_control(
		.clk(clk),
		.sclk_100k(sclk_100k),
		.i2c_negclk(i2c_negclk),
		.EN(sccb_EN),
		.wr_data({8'h72,LUT_DATA}),

		.trans_finished(trans_finished),
		.ack(ack),
		.sccb_sclk(sccb_sclk),
		.sccb_data(sccb_data)
	);

	always@(posedge clk) begin
	if(i2c_negclk) begin 
				 if(initial_INDEX < initial_SIZE)
					 begin
					  case(sccb_state)
							 0: begin
									if(trans_finished)    // 一次传输完成跳转状态1
										 begin
											sccb_EN <=1'd0;  
											if(~ack)
											sccb_state <=1;
											else
											sccb_state <=0;
										end    
									else begin               // 未完成继续传输
										 sccb_state <=0;
										 sccb_EN <=1'd1;
										 end
								  end
								
							 1:begin                //addr ++
									initial_INDEX <= initial_INDEX + 1'd1;
									sccb_state <=0;
									sccb_EN <=1'd0;
								 end
							 endcase
						 end			
			  else begin 
					initial_INDEX 	<= initial_INDEX;
					sccb_state <=0;
					sccb_EN <=1'd0;
					end
			end
	end
	endmodule
