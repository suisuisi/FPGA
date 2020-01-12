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
Filename			:		lcd1602_driver.v
Date				:		2011-06-25
Description			:		Driver of LCD 1602.
Modification History	:
Date			By			Version			Change Description
=========================================================================
11/06/25		CrazyBingo	1.0				Original
13/10/28		CrazyBingo	2.0				Modification
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module lcd1602_driver
(
	//global clock
	input				clk,
	input				rst_n,

	//lcd1602 interface
	output  			lcd_en,		//LCD1602 Chip enable signal
	output 	reg			lcd_rs,		//H: Data; L: Instruction code
	output				lcd_rw,		//H: Read; L: Write
	output	reg	[7:0]	lcd_data,	//LCD1602 Data interface
	
	//user interface
	input		[127:0]	line_rom1,	//LCD1602 1th row display
	input		[127:0]	line_rom2	//LCD1602 2th row display
); 

//-----------------------------------
//Delay for 20ms
localparam DELAY_TOP = 1000_000;
//localparam DELAY_TOP = 20'd1000;		//Just for test
reg	[19:0]	delay_cnt;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		delay_cnt <= 0;
	else if(delay_cnt < DELAY_TOP - 1'b1)
		delay_cnt <= delay_cnt + 1'b1;
	else
		delay_cnt <= delay_cnt;
end
wire	delay_done = (delay_cnt == DELAY_TOP - 1'b1) ? 1'b1 : 1'b0;


//--------------------------------------
localparam DELAY_TOP2 = 20'd100_000;   //2ms(500Hz)
//localparam DELAY_TOP2 = 20'hf;        //Just for test
reg [19:0]  delay_cnt2;
always @ (posedge clk or negedge rst_n)
begin
    if(!rst_n)
        delay_cnt2 <= 0;
    else if(delay_done)
        begin
        if(delay_cnt2 < DELAY_TOP2 - 1'b1)
            delay_cnt2 <= delay_cnt2 + 1'b1;
        else
            delay_cnt2 <= 0;
        end
    else
        delay_cnt2 <= 0;
end
assign  lcd_rw = 1'b0;      //write only, never read
//lcd enable,keep same time
assign  lcd_en = (delay_cnt2 >= DELAY_TOP2/2) ? 1'b0 : 1'b1;    
//write data when negedge        
wire    lcd_write_flag = (delay_cnt2 == DELAY_TOP2 - 1'b1) ? 1'b1 : 1'b0;   

//---------------------------------------                              
//Gray code : 40 states
localparam 	IDLE		= 	8'h00;	//IDLE
//LCD1602 init
localparam	DISP_SET	= 	8'h01;	//Display mode
localparam 	DISP_OFF	= 	8'h03;	//Display off
localparam 	CLR_SCR 	= 	8'h02;	//Clear the LCD
localparam 	CURSOR_SET1 = 	8'h06;	//Set Cursor
localparam 	CURSOR_SET2 = 	8'h07;	//Display on
//Display 1th line	
localparam 	ROW1_ADDR	= 	8'h05;	//Line1's first address	
localparam 	ROW1_0		= 	8'h04;
localparam 	ROW1_1		= 	8'h0C;
localparam 	ROW1_2		= 	8'h0D;
localparam 	ROW1_3		= 	8'h0F;
localparam 	ROW1_4		= 	8'h0E;
localparam 	ROW1_5		= 	8'h0A;
localparam 	ROW1_6		= 	8'h0B;
localparam 	ROW1_7		= 	8'h09;
localparam 	ROW1_8		=	8'h08;
localparam 	ROW1_9		= 	8'h18;
localparam 	ROW1_A		= 	8'h19;
localparam 	ROW1_B		= 	8'h1B;
localparam 	ROW1_C		= 	8'h1A;
localparam 	ROW1_D		= 	8'h1E;
localparam 	ROW1_E		= 	8'h1F;
localparam 	ROW1_F		= 	8'h1D;
//Display 2th line
localparam 	ROW2_ADDR	= 	8'h1C;	//Line2's first address	
localparam 	ROW2_0		= 	8'h14;
localparam 	ROW2_1		= 	8'h15;
localparam 	ROW2_2		= 	8'h17;
localparam 	ROW2_3		= 	8'h16;
localparam 	ROW2_4		= 	8'h12;
localparam 	ROW2_5		= 	8'h13;
localparam 	ROW2_6		= 	8'h11;
localparam 	ROW2_7		= 	8'h10;
localparam 	ROW2_8		= 	8'h30;
localparam 	ROW2_9		= 	8'h31;
localparam 	ROW2_A		= 	8'h33;
localparam 	ROW2_B		= 	8'h32;
localparam 	ROW2_C		= 	8'h36;
localparam 	ROW2_D		= 	8'h37;
localparam 	ROW2_E		= 	8'h35;
localparam 	ROW2_F		= 	8'h34;

//---------------------------------------
// FSM: always1
reg [7:0] current_state, next_state;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		current_state <= IDLE;
	else if(lcd_write_flag)
		current_state <= next_state;
	else
		current_state <= current_state;
end

//---------------------------------------
// FSM: always2
always@(*)
begin
	case(current_state)
	//LCD1602 init
	IDLE        	: 	next_state = DISP_SET;		//5'h00
	DISP_SET    	: 	next_state = DISP_OFF;      //5'h01
	DISP_OFF    	: 	next_state = CLR_SCR;       //5'h03
	CLR_SCR     	:	next_state = CURSOR_SET1;   //5'h02
	CURSOR_SET1		: 	next_state = CURSOR_SET2;   //5'h06
	CURSOR_SET2		: 	next_state = ROW1_ADDR;     //5'h07
	//Display 1th line	
	ROW1_ADDR   	: 	next_state = ROW1_0;		//5'h05;
	ROW1_0      	: 	next_state = ROW1_1;	    //5'h04;
	ROW1_1      	: 	next_state = ROW1_2;        //5'h0C;
	ROW1_2      	: 	next_state = ROW1_3;        //5'h0D;
	ROW1_3      	: 	next_state = ROW1_4;        //5'h0F;
	ROW1_4      	: 	next_state = ROW1_5;        //5'h0E;
	ROW1_5      	: 	next_state = ROW1_6;        //5'h0A;
	ROW1_6      	: 	next_state = ROW1_7;        //5'h0B;
	ROW1_7      	: 	next_state = ROW1_8;        //5'h09;
	ROW1_8      	: 	next_state = ROW1_9;        //5'h08;
	ROW1_9      	: 	next_state = ROW1_A;        //5'h18;
	ROW1_A      	: 	next_state = ROW1_B;        //5'h19;
	ROW1_B      	: 	next_state = ROW1_C;        //5'h1B;
	ROW1_C      	: 	next_state = ROW1_D;        //5'h1A;
	ROW1_D      	: 	next_state = ROW1_E;        //5'h1E;
	ROW1_E      	: 	next_state = ROW1_F;        //5'h1F;
	ROW1_F      	: 	next_state = ROW2_ADDR;     //5'h1D;
	//Display 2th line	
	ROW2_ADDR   	: 	next_state = ROW2_0; 		//5'h1C;
	ROW2_0      	: 	next_state = ROW2_1;        //5'h14;
	ROW2_1      	: 	next_state = ROW2_2;        //5'h15;
	ROW2_2      	: 	next_state = ROW2_3;        //5'h17;
	ROW2_3      	:	next_state = ROW2_4;        //5'h16;
	ROW2_4      	: 	next_state = ROW2_5;        //5'h12;
	ROW2_5      	: 	next_state = ROW2_6;        //5'h13;
	ROW2_6      	: 	next_state = ROW2_7;        //5'h11;
	ROW2_7      	: 	next_state = ROW2_8;        //5'h10;
	ROW2_8      	: 	next_state = ROW2_9;        //5'h30;
	ROW2_9      	: 	next_state = ROW2_A;        //5'h31;
	ROW2_A      	: 	next_state = ROW2_B;        //5'h33;
	ROW2_B      	: 	next_state = ROW2_C;        //5'h32;
	ROW2_C      	: 	next_state = ROW2_D;        //5'h36;
	ROW2_D      	: 	next_state = ROW2_E;        //5'h37;
	ROW2_E      	: 	next_state = ROW2_F;        //5'h35;
	ROW2_F      	: 	next_state = ROW1_ADDR;     //5'h34;
	default     	: 	next_state = IDLE ;
	endcase
end

//---------------------------------------
// FSM: always3-1
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		lcd_rs <= 0;
	else if(lcd_write_flag)
		begin
		if(	next_state	==	IDLE 		|| 
			next_state 	==	DISP_SET 	||
			next_state 	==	DISP_OFF	||
			next_state	==	CLR_SCR		||
			next_state	==	CURSOR_SET1	||
			next_state	==	CURSOR_SET2	||
			next_state	== 	ROW1_ADDR 	|| 
			next_state	==	ROW2_ADDR)
			lcd_rs <= 0;	//L: Instruction
		else
			lcd_rs <= 1;	//H: Data
		end
	else
		lcd_rs <= lcd_rs;
end


//---------------------------------------
// FSM: always3-2
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		lcd_data <= 8'h00;
	else if(lcd_write_flag)
		begin
		//write lcd_data
		case(next_state)
		IDLE        	: 	lcd_data <= 8'hxx;
		//LCD1602 init
		DISP_SET    	: 	lcd_data <= 8'h38;		//Display mode: Set 16X2,5X8, 8 bits data
		DISP_OFF    	: 	lcd_data <= 8'h08;		//Display off
		CLR_SCR     	: 	lcd_data <= 8'h01;		//Clear LCD
		CURSOR_SET1		: 	lcd_data <= 8'h06;		//Set Cursor
		CURSOR_SET2		: 	lcd_data <= 8'h0C;		//Display on 
		//Display 1th line	
		ROW1_ADDR   	: 	lcd_data <= 8'h80;
		ROW1_0      	: 	lcd_data <= line_rom1[127:120];
		ROW1_1      	: 	lcd_data <= line_rom1[119:112];
		ROW1_2      	: 	lcd_data <= line_rom1[111:104];
		ROW1_3      	: 	lcd_data <= line_rom1[103: 96];
		ROW1_4      	: 	lcd_data <= line_rom1[ 95: 88];
		ROW1_5      	: 	lcd_data <= line_rom1[ 87: 80];
		ROW1_6      	: 	lcd_data <= line_rom1[ 79: 72];
		ROW1_7      	: 	lcd_data <= line_rom1[ 71: 64];
		ROW1_8      	: 	lcd_data <= line_rom1[ 63: 56];
		ROW1_9      	: 	lcd_data <= line_rom1[ 55: 48];
		ROW1_A      	: 	lcd_data <= line_rom1[ 47: 40];
		ROW1_B      	: 	lcd_data <= line_rom1[ 39: 32];
		ROW1_C      	: 	lcd_data <= line_rom1[ 31: 24];
		ROW1_D      	: 	lcd_data <= line_rom1[ 23: 16]; 
		ROW1_E      	: 	lcd_data <= line_rom1[ 15:  8];
		ROW1_F      	: 	lcd_data <= line_rom1[  7:  0];
		//Display 2th line	
		ROW2_ADDR   	: 	lcd_data <= 8'hC0;	
		ROW2_0      	: 	lcd_data <= line_rom2[127:120];
		ROW2_1      	: 	lcd_data <= line_rom2[119:112];
		ROW2_2      	: 	lcd_data <= line_rom2[111:104];
		ROW2_3      	: 	lcd_data <= line_rom2[103: 96];
		ROW2_4      	: 	lcd_data <= line_rom2[ 95: 88];
		ROW2_5      	: 	lcd_data <= line_rom2[ 87: 80];
		ROW2_6      	: 	lcd_data <= line_rom2[ 79: 72];
		ROW2_7      	: 	lcd_data <= line_rom2[ 71: 64];
		ROW2_8      	: 	lcd_data <= line_rom2[ 63: 56];
		ROW2_9      	: 	lcd_data <= line_rom2[ 55: 48];
		ROW2_A      	: 	lcd_data <= line_rom2[ 47: 40];
		ROW2_B      	: 	lcd_data <= line_rom2[ 39: 32];
		ROW2_C      	: 	lcd_data <= line_rom2[ 31: 24];
		ROW2_D      	: 	lcd_data <= line_rom2[ 23: 16];
		ROW2_E      	: 	lcd_data <= line_rom2[ 15:  8];
		ROW2_F      	: 	lcd_data <= line_rom2[  7:  0];
		endcase 
		end 
	else
		lcd_data <= lcd_data;
end

endmodule
