`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:59 01/09/2015 
// Design Name: 
// Module Name:    sccb_control 
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
module sccb_control(
	input clk,  //25mhz
	input sclk_100k,
	input i2c_negclk,
	input EN,
	input[23:0] wr_data,

	output reg trans_finished,
	output ack,
	output sccb_sclk,
	inout  sccb_data
    );

//---------------------------------------------
//  计数器
//---------------------------------------------
reg[5:0] sccb_count = 0;
always@(posedge clk) begin
	if(i2c_negclk)
		begin
      if(EN==0 || trans_finished == 1) 
		sccb_count<=6'd0; 
		else if(sccb_count< 6'd63) 
         sccb_count <= sccb_count+1'b1;
		end
	else 
      sccb_count <= sccb_count; 
end


always@(posedge clk) begin
//I2C Write: ID-Address + SUB-Address + W-Data
if(i2c_negclk)
	 begin
	  if(EN)	
				begin 
               case(sccb_count)
						6'd0 :	begin            //idle
									sccb_sclk_reg <= 1;
									sccb_data_reg <= 1;
									wr_ack_1 <= 1;
									wr_ack_2 <= 1;
									wr_ack_3 <= 1;
									trans_finished <= 0;
									end								
						6'd1  :	sccb_data_reg <= 0;
						6'd2  : 	sccb_sclk_reg <= 0;	 //start
							  
						6'd3  :	sccb_data_reg <= wr_data[23]; //start wr id	addr 
						6'd4  :	sccb_data_reg <= wr_data[22];	 	  
						6'd5  :	sccb_data_reg <= wr_data[21];
						6'd6  :	sccb_data_reg <= wr_data[20];	 				
						6'd7  :	sccb_data_reg <= wr_data[19];
						6'd8  :	sccb_data_reg <= wr_data[18];	 	
						6'd9  :	sccb_data_reg <= wr_data[17];
						6'd10 :	sccb_data_reg <= wr_data[16];
						6'd11 : 	sccb_data_reg <= 1'd0;									
				    //6'd12 :	wr_ack_1      <= sccb_data;		
					 6'd12 :	wr_ack_1      <= 1'd0;
						6'd13 :	sccb_data_reg <= 1'd0;
						
						6'd14  :	sccb_data_reg <= wr_data[15]; //start wr sub addr
						6'd15  :	sccb_data_reg <= wr_data[14];	  	  
						6'd16  :	sccb_data_reg <= wr_data[13];
						6'd17  :	sccb_data_reg <= wr_data[12];	 				
						6'd18  :	sccb_data_reg <= wr_data[11];
						6'd19  :	sccb_data_reg <= wr_data[10];	 	
						6'd20  :	sccb_data_reg <= wr_data[9];
						6'd21  :	sccb_data_reg <= wr_data[8];
						6'd22 :	sccb_data_reg <= 1'd0;
					//	6'd23  :	wr_ack_2      <= sccb_data;	
					   6'd23  :	wr_ack_2      <= 1'd0;
						6'd24  :	sccb_data_reg <= 1'd0;
						
						6'd25  :	sccb_data_reg <= wr_data[7]; //start wr reg value
						6'd26  :	sccb_data_reg <= wr_data[6];
						6'd27  :	sccb_data_reg <= wr_data[5];
						6'd28  :	sccb_data_reg <= wr_data[4];
						6'd29  :	sccb_data_reg <= wr_data[3];
						6'd30  :	sccb_data_reg <= wr_data[2];
						6'd31 :	sccb_data_reg <= wr_data[1];
						6'd32  :	sccb_data_reg <= wr_data[0];
						6'd33 :	sccb_data_reg <= 1'd0;
									
					//	6'd34 :	wr_ack_3      <= sccb_data;
                  6'd34 :	wr_ack_3      <= 1'd0;					
						6'd35  :	sccb_data_reg <= 1'd0;
								
						6'd36  :	begin 
									sccb_data_reg <= 0; 	
									sccb_sclk_reg <= 0; 
									end
						6'd37  :	sccb_sclk_reg <= 1;
						6'd38  : begin 
						         sccb_data_reg  <= 1;	 //stop
						         trans_finished <= 1;
									end
					  default : begin sccb_sclk_reg <= 1; sccb_data_reg <= 1; end
			        endcase
					  end
	   else begin
				sccb_sclk_reg <= 1;
				sccb_data_reg <= 1;
				trans_finished <= 0;
				end 
		end
end


//---------------------------------------------
//---------------------------------------------
reg sccb_data_reg = 0;
reg sccb_sclk_reg = 0;
reg wr_ack_1 = 0,wr_ack_2 = 0,wr_ack_3 = 0;


assign 	sccb_sclk = ((sccb_count>= 4  &&  sccb_count <=11)|| (sccb_count == 13) ||	
					 (sccb_count>= 15 &&  sccb_count <=22) || (sccb_count == 24) ||
					 (sccb_count>= 26 &&  sccb_count <=33) || (sccb_count == 35)) ? sclk_100k : sccb_sclk_reg;
											 																 
assign   sccb_data = ((sccb_count == 12|| sccb_count == 13 )||
                   (sccb_count == 23|| sccb_count == 24 )||
						 (sccb_count == 34|| sccb_count == 35 )) ? 1'bz : sccb_data_reg;
						 
						 						 														 
//assign 	sccb_sclk = (sccb_count>= 4  &&  sccb_count <= 30) ? sclk_100k : sccb_sclk_reg;
						 
//assign   sccb_data = ((sccb_count == 12)||(sccb_count == 21)||(sccb_count == 30))? 1'bz : sccb_data_reg;
						 
	
assign   ack = (wr_ack_1|wr_ack_2|wr_ack_3) ;  //一轮寄存器写是否完成

endmodule
