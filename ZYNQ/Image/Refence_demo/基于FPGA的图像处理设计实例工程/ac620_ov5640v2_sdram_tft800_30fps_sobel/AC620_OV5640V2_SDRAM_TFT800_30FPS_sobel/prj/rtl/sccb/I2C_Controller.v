/*-----------------------------------------------------------------------
								 \\\|///
							   \\  - -  //
								(  @ @  )
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from ZhangZhen (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2012-20xx ZhangZhen Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		ZhangZhen
Technology blogs 	: 		http://blog.chinaaet.com/crazybingo
Email Address 		: 		thereturnofbingo@gmail.com
Filename			:		I2C_Controller.v
Data				:		2012-03-18
Description			:		The Driver and display of OV5642.
Modification History	:
Data			By			Version			Change Description
=========================================================================
14/06/01		ZhangZhen	1.0				Original
-------------------------------------------------------------------------
|                                     Oooo								|
+------------------------------oooO--(   )-----------------------------+
                              (   )   ) /
                               \ (   (_/
                                \_)
----------------------------------------------------------------------*/ 
`timescale 1ns/1ns
module I2C_Controller 
(
	//Global clk
	input			clk,		
	input			rst_n,		
	
	//I2C transfer
	input			i2c_clk,	//DATA Transfer Enable
	input			i2c_en,		//I2C DATA ENABLE
	input	[39:0]	i2c_wdata,	//DATA:[SLAVE_ADDR, SUB_ADDR, DATA]
	output			i2c_sclk,	//I2C clk
 	inout			i2c_sdat,	//I2C DATA
	input			wr,     	//Write | Read
	input			trans,      	//start transfor
	output			ack,      	//ack
	output	reg		i2c_end,     	//i2c_end transfor 
	output	reg	[7:0]	i2c_rdata	//I2C Data read
);

//------------------------------------
//I2C Signal
reg			i2c_bit;
reg 		sclk;	//I2C Free Clock
reg	[6:0]	sd_counter;

//Write: ID-Address + SUB-Address + W-Data
wire 	i2c_sclk1 = 	(trans == 1 &&
						((sd_counter >= 5 && sd_counter <=12 || sd_counter == 14) ||	
						(sd_counter >= 16 && sd_counter <=23 || sd_counter == 25) ||
						(sd_counter >= 27 && sd_counter <=34 || sd_counter == 36) ||
						(sd_counter >= 38 && sd_counter <=45 || sd_counter == 47))) ? i2c_clk : sclk;

//I2C Read: {ID-Address + SUB-Address} + {ID-Address + R-Data}						
wire 	i2c_sclk2 = 	(trans == 1 &&
						((sd_counter >= 5 && sd_counter <=12 || sd_counter == 14) ||
						(sd_counter >= 16 && sd_counter <=23 || sd_counter == 25) ||
						(sd_counter >= 27 && sd_counter <=34 || sd_counter == 36) ||
						(sd_counter >= 44 && sd_counter <=52 || sd_counter == 54) ||
						(sd_counter >= 56 && sd_counter <=63 || sd_counter == 65))) ? i2c_clk : sclk;		
						
assign	i2c_sclk = wr ? i2c_sclk1 : i2c_sclk2;	

wire	sdo1	=		((sd_counter == 13 || sd_counter == 14) || 
						 (sd_counter == 24 || sd_counter == 25) || 
						 (sd_counter == 35 || sd_counter == 36) ||
						 (sd_counter == 46 || sd_counter == 47)) ? 1'b0 : 1'b1;		//input | output
						
wire	sdo2	=		((sd_counter == 13 || sd_counter == 14)|| 
						(sd_counter == 24 || sd_counter == 25) || 
						(sd_counter == 35 || sd_counter == 36) ||
						(sd_counter == 53 || sd_counter == 54) ||
						(sd_counter >= 55 && sd_counter <= 63)) ? 1'b0 : 1'b1;		//input | output
						
wire	SDO = wr ? sdo1 : sdo2;

assign	i2c_sdat = SDO ? i2c_bit : 1'bz;



//------------------------------------
//Write ack | Read ack
reg	ackw1, ackw2, ackw3,ackw4;		//0 AVTIVE
reg 	ackr1, ackr2, ackr3,ackr4;		//0 ACTIVE
assign	ack = wr ? (ackw1 | ackw2 | ackw3 | ackw4) : (ackr1 | ackr2 | ackr3 | ackr4);


//------------------------------------
//I2C COUNTER
always @(posedge clk or negedge rst_n) 
begin
	if (!rst_n) 
		sd_counter <= 7'b0;
	else if(i2c_en)
		begin
		if (trans == 0 || i2c_end == 1) 
			sd_counter <= 7'b0;
		else if (sd_counter < 7'd70) 
			sd_counter <= sd_counter + 7'd1;	
		end
	else
		sd_counter <= sd_counter;
end

//------------------------------------
//I2C Transfer
always @(posedge clk or negedge rst_n) 
begin
    if(!rst_n) 
		begin 
		sclk <= 1;
		i2c_bit <= 1; 
		ackw1 <= 1; ackw2 <= 1; ackw3 <= 1;ackw4 <= 1; 
		ackr1 <= 1; ackr2 <= 1; ackr3 <= 1;ackr4 <= 1;
		i2c_end <= 0;
		i2c_rdata <= 8'h0;	
		end
	else if(i2c_en)		//data change enable
		begin
		if(trans)
			begin
			if(wr)		//I2C Write: ID-Address + SUB-Address + W-Data
				begin
				case(sd_counter)
				//IDLE
				7'd0 :begin
						sclk <= 1;
						i2c_bit <= 1;
						ackw1 <= 1; ackw2 <= 1; ackw3 <= 1; ackw4 <= 1;
						ackr1 <= 1; ackr2 <= 1; ackr3 <= 1; ackr4 <= 1;
						i2c_end <= 0;
						end
				//Start
				7'd1 :	begin 
						sclk <= 1;
						i2c_bit <= 1;
						ackw1 <= 1; ackw2 <= 1; ackw3 <= 1;ackw4<=1;
						i2c_end <= 0;
						end
				7'd2  : i2c_bit <= 0;		//i2c_sdat = 0
				7'd3  : sclk <= 0;			//i2c_sclk = 0
				
				//SLAVE ADDR
				7'd4  : i2c_bit <= i2c_wdata[31];	//Bit8
				7'd5  : i2c_bit <= i2c_wdata[30];	//Bit7
				7'd6  : i2c_bit <= i2c_wdata[29];	//Bit6
				7'd7  : i2c_bit <= i2c_wdata[28];	//Bit5
				7'd8  : i2c_bit <= i2c_wdata[27];	//Bit4
				7'd9  : i2c_bit <= i2c_wdata[26];	//Bit3
				7'd10 : i2c_bit <= i2c_wdata[25];	//Bit2
				7'd11 : i2c_bit <= i2c_wdata[24];	//Bit1
				7'd12 : i2c_bit <= 0;					//High-Z, Input
				7'd13 : ackw1 	<= i2c_sdat;			//ACK1
				7'd14 : i2c_bit <= 0;					//Delay
				
				//SUB ADDR
				7'd15 : i2c_bit <= i2c_wdata[23];	//Bit15
				7'd16 : i2c_bit <= i2c_wdata[22];	//Bit14
				7'd17 : i2c_bit <= i2c_wdata[21];	//Bit13
				7'd18 : i2c_bit <= i2c_wdata[20];	//Bit12
				7'd19 : i2c_bit <= i2c_wdata[19];	//Bit11
				7'd20 : i2c_bit <= i2c_wdata[18];	//Bit10
				7'd21 : i2c_bit <= i2c_wdata[17];   //Bit9
				7'd22 : i2c_bit <= i2c_wdata[16];	//Bit8
				7'd23 : i2c_bit <= 0;					//High-Z, Input
				7'd24 : ackw2 	<= i2c_sdat;			//ACK2
				7'd25 : i2c_bit <= 0;					//Delay
				
				7'd26 : i2c_bit <= i2c_wdata[15];	//Bit7
				7'd27 : i2c_bit <= i2c_wdata[14];	//Bit6
				7'd28 : i2c_bit <= i2c_wdata[13];	//Bit5
				7'd29 : i2c_bit <= i2c_wdata[12];	//Bit4
				7'd30 : i2c_bit <= i2c_wdata[11];	//Bit3
				7'd31 : i2c_bit <= i2c_wdata[10];	//Bit2
				7'd32 : i2c_bit <= i2c_wdata[9];		//Bit1
				7'd33 : i2c_bit <= i2c_wdata[8];		//Bit0
				7'd34 : i2c_bit <= 0;					//High-Z, Input
				7'd35 : ackw3 	<= i2c_sdat;			//ACK3
				7'd36 : i2c_bit <= 0;					//Delay
				
				//Send data
				7'd37 : i2c_bit <= i2c_wdata[7];		//Bit8 
				7'd38 : i2c_bit <= i2c_wdata[6];		//Bit7
				7'd39 : i2c_bit <= i2c_wdata[5];		//Bit6
				7'd40 : i2c_bit <= i2c_wdata[4];		//Bit5
				7'd41 : i2c_bit <= i2c_wdata[3];		//Bit4
				7'd42 : i2c_bit <= i2c_wdata[2];		//Bit3
				7'd43 : i2c_bit <= i2c_wdata[1];		//Bit2
				7'd44 : i2c_bit <= i2c_wdata[0];		//Bit1
				7'd45 : i2c_bit <= 0;					//High-Z, Input
				7'd46 : ackw4 	<= i2c_sdat;			//ACK4
				7'd47 : i2c_bit <= 0;					//Delay

				//Stop
				7'd48 : begin	sclk <= 0; i2c_bit <= 0; end
				7'd49 : sclk <= 1;	
				7'd50 : begin i2c_bit <= 1; i2c_end <= 1; end 
				default : begin i2c_bit <= 1; sclk <= 1; end
				endcase
				end
			else		//I2C Read: {ID-Address + SUB-Address} + {ID-Address + R-Data}
				begin
				case(sd_counter)
				//IDLE
				7'd0 :begin
						sclk <= 1;
						i2c_bit <= 1;
						ackw1 <= 1; ackw2 <= 1; ackw3 <= 1; ackw4 <= 1;
						ackr1 <= 1; ackr2 <= 1; ackr3 <= 1; ackr4 <= 1; 
						i2c_end <= 0;
						end
				//I2C Read1: {ID-Address + SUB-Address}
				//Start
				7'd1 :begin 
						sclk <= 1;
						i2c_bit <= 1;
						ackr1 <= 1; ackr2 <= 1; ackr3 <= 1; ackr4 <= 1;
						i2c_end <= 0;
						end
				7'd2  : i2c_bit <= 0;		//i2c_sdat = 0
				7'd3  : sclk <= 0;			//i2c_sclk = 0
				
				//SLAVE ADDR   //78H
				7'd4  : i2c_bit <= i2c_wdata[31];	//Bit8
				7'd5  : i2c_bit <= i2c_wdata[30];	//Bit7
				7'd6  : i2c_bit <= i2c_wdata[29];	//Bit6
				7'd7  : i2c_bit <= i2c_wdata[28];	//Bit5
				7'd8  : i2c_bit <= i2c_wdata[27];	//Bit4
				7'd9  : i2c_bit <= i2c_wdata[26];	//Bit3
				7'd10 : i2c_bit <= i2c_wdata[25];	//Bit2
				7'd11 : i2c_bit <= i2c_wdata[24];	//Bit1
				7'd12 : i2c_bit <= 0;					//High-Z, Input
				7'd13 : ackr1 	<= i2c_sdat;			//ACK1
				7'd14 : i2c_bit <= 0;					//Delay
				
				//SUB ADDR
				7'd15 : i2c_bit <= i2c_wdata[23];	//Bit15
				7'd16 : i2c_bit <= i2c_wdata[22];	//Bit14
				7'd17 : i2c_bit <= i2c_wdata[21];	//Bit13
				7'd18 : i2c_bit <= i2c_wdata[20];	//Bit12
				7'd19 : i2c_bit <= i2c_wdata[19];	//Bit11
				7'd20 : i2c_bit <= i2c_wdata[18];	//Bit10
				7'd21 : i2c_bit <= i2c_wdata[17];   //Bit9
				7'd22 : i2c_bit <= i2c_wdata[16];	//Bit8
				7'd23 : i2c_bit <= 0;					//High-Z, Input
				7'd24 : ackr2 	<= i2c_sdat;			//ACK2
				7'd25 : i2c_bit <= 0;					//Delay

				7'd26 : i2c_bit <= i2c_wdata[15];	//Bit7
				7'd27 : i2c_bit <= i2c_wdata[14];	//Bit6
				7'd28 : i2c_bit <= i2c_wdata[13];	//Bit5
				7'd29 : i2c_bit <= i2c_wdata[12];	//Bit4
				7'd30 : i2c_bit <= i2c_wdata[11];	//Bit3
				7'd31 : i2c_bit <= i2c_wdata[10];	//Bit2
				7'd32 : i2c_bit <= i2c_wdata[9];		//Bit1
				7'd33 : i2c_bit <= i2c_wdata[8];		//Bit0
				7'd34 : i2c_bit <= 0;					//High-Z, Input
				7'd35 : ackr3 	<= i2c_sdat;			//ACK3
				7'd36 : i2c_bit <= 0;					//Delay
				
				//Stop
				7'd37 : begin	sclk <= 0; i2c_bit <= 0; end
				7'd38 : sclk <= 1;	
				7'd39 : begin i2c_bit <= 1; /*i2c_end <= 1;*/end 

				//I2C Read2: {ID-Address + R-Data}
				//Start
				7'd40 :	begin 
						sclk <= 1;
						i2c_bit <= 1;
						end
				7'd41 : i2c_bit <= 0;		//i2c_sdat = 0
				7'd42 : sclk <= 0;			//i2c_sclk = 0
				
				//SLAVE ADDR
				7'd43 : i2c_bit <= i2c_wdata[39];	//Bit8
				7'd44 : i2c_bit <= i2c_wdata[38];	//Bit7
				7'd45 : i2c_bit <= i2c_wdata[37];	//Bit6
				7'd46 : i2c_bit <= i2c_wdata[36];	//Bit5
				7'd47 : i2c_bit <= i2c_wdata[35];	//Bit4
				7'd48 : i2c_bit <= i2c_wdata[34];	//Bit3
				7'd49 : i2c_bit <= i2c_wdata[33];	//Bit2
				7'd50 : i2c_bit <= i2c_wdata[32];	//Bit1
				7'd51 : i2c_bit <= 1'b1;				//Bit1	Read Data Flag
				7'd52 : i2c_bit <= 0;					//High-Z, Input
				7'd53 : ackr4 	<= i2c_sdat;			//ACK4
				7'd54 : i2c_bit <= 0;					//Delay
				
				//Read DATA
				7'd55 : i2c_bit 	  <= 0;			//High-Z, Input
				7'd56 : i2c_rdata[7] <= i2c_sdat;	//Bit8	, Input
				7'd57 : i2c_rdata[6] <= i2c_sdat;	//Bit7	, Input 
				7'd58 : i2c_rdata[5] <= i2c_sdat;	//Bit6	, Input 
				7'd59 : i2c_rdata[4] <= i2c_sdat;	//Bit5	, Input 
				7'd60 : i2c_rdata[3] <= i2c_sdat;	//Bit4	, Input 
				7'd61 : i2c_rdata[2] <= i2c_sdat;	//Bit3	, Input 
				7'd62 : i2c_rdata[1] <= i2c_sdat;	//Bit2	, Input 
				7'd63 : i2c_rdata[0] <= i2c_sdat;	//Bit1	, Input 	
				7'd64 : i2c_bit 	  <= 1;			//Output //ACK4 NACK
				7'd65 : i2c_bit 	  <= 0;			//Delay
				
				//Stop
				7'd66 : begin	sclk <= 0; i2c_bit <= 0; end
				7'd67 : sclk <= 1;	
				7'd68 : begin i2c_bit <= 1; i2c_end <= 1; end 
				endcase
				end
			end
		else
			begin
			sclk <= 1;
			i2c_bit <= 1; 
			ackw1 <= 1; ackw2 <= 1; ackw3 <= 1; ackw4<=1;
			ackr1 <= 1; ackr2 <= 1; ackr3 <= 1; ackr4<=1;
			i2c_end <= 0;
			i2c_rdata <= i2c_rdata;
			end
		end
end
		
endmodule
