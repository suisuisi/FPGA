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
Filename			:		I2C_OV5640_Init.v
Date				:		2017-09-17
Description			:		The Driver and display of OV5640.
Modification History	:
Date			By			Version			Change Description
=========================================================================
17/09/17		CrazyBingo	2.0				Modified by CrazyBingo
-------------------------------------------------------------------------
|                                     Oooo								|
+------------------------------oooO--(   )-----------------------------+
                              (   )   ) /
                               \ (   (_/
                                \_)
----------------------------------------------------------------------*/ 
`timescale 1ns/1ns
module I2C_OV5640_Init_RGB565
(
	//Global clock
	input		clk,		//100MHz
	input		rst_n,		//Global Reset
	
	//I2C Side
	output		i2c_sclk,	//I2C CLOCK
	inout		i2c_sdat,	//I2C DATA
	
	output		config_done//Config Done
);
reg   Config_done;


/////////////////////	I2C Control Clock	////////////////////////
//	Clock Setting
parameter	CLK_Freq	=	100_000000;	//100 MHz
parameter	I2C_Freq	=	100_000;		//400 KHz
reg	[15:0]	i2c_clk_div;				//CLK DIV
reg			i2c_ctrl_clk;				//I2C Control Clock
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		i2c_clk_div	<=	0;
		i2c_ctrl_clk	<=	0;
		end
	else
		begin
		 if( i2c_clk_div	< (CLK_Freq/I2C_Freq)/2)
			 i2c_clk_div	<=	i2c_clk_div + 1'd1;
		 else
			 begin
			 i2c_clk_div	<=	0;
			i2c_ctrl_clk	<=	~i2c_ctrl_clk;
			end
		end
end


//-------------------------------------
reg	i2c_en_r0, i2c_en_r1;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		i2c_en_r0 <= 0;
		i2c_en_r1 <= 0;
		end
	else
		begin
		i2c_en_r0 <= i2c_ctrl_clk;
		i2c_en_r1 <= i2c_en_r0;
		end
end
wire	i2c_negclk = (i2c_en_r1 & ~i2c_en_r0) ? 1'b1 : 1'b0;		//negedge i2c_sclk transfer data

//////////////////////	Config Control	////////////////////////////
// Internal Registers/Wires
wire		i2c_end;		//I2C Transfer End
wire		i2c_ack;		//I2C Transfer ACK
reg	[8:0]	lut_index;		//LUT Index
reg	[1:0]	setup_state;		//State Machine
reg			i2c_trans;			//I2C Transfer Start
reg			i2c_wr;			//I2C Write / Read Data
wire	[23:0]	lut_data;		//ID-Address，SUB-Address，Data}
reg	[39:0]	i2c_data;

wire	[8:0]	LUT_SIZE;
always@(posedge clk or negedge rst_n)		//25MHz	i2c_ctrl_clk
begin
	if(!rst_n)
		begin
		Config_done <= 0;
		lut_index	<=	0;
		setup_state	<=	0;
		i2c_trans		<=	0;
		i2c_wr     <=	0;	
		end
	else if(i2c_negclk)
		begin
		if(lut_index < LUT_SIZE)
			begin
			Config_done <= 0;
			case(setup_state)
			0:	begin						//IDLE State
				if(~i2c_end)				//END Transfer
					setup_state	<=	1;		
				else						//Transfe ing
					setup_state	<=	0;				
					i2c_trans		<=	1;			//Go Transfer
				if(lut_index < 12'd2)
					begin
					i2c_wr <= 0;			//Read Data
					i2c_data<={8'h79,8'h78,lut_data};
					end
				else
				begin
					i2c_wr <= 1;			//Write Data
					i2c_data<={8'h00,8'h78,lut_data};
				end
				end
			1:	
				begin						//Write data
				if(i2c_end)
					begin
					i2c_wr <= 0;
					i2c_trans <= 0;
					if(~i2c_ack)			//ACK ACTIVE
						setup_state	<=	2;	//INDEX ++
					else
						setup_state	<=	0;	//Repeat Transfer						
					end
				end
			2:	begin						//Address Add
				lut_index	<= lut_index + 1'd1;
				setup_state	<= 0;
				i2c_trans	<= 0;
				i2c_wr      <= 0;
				end
			endcase
			end
		else
			begin
			Config_done <= 1'b1;
			lut_index 	<= lut_index;
			setup_state	<= 0;
			i2c_trans	<= 0;
			i2c_wr      <= 0;
			end
	end
end

assign config_done=Config_done;



	I2C_Controller 	u_I2C_Controller	
	(	
		.clk			(clk),
		.rst_n			(rst_n),
								
		.i2c_clk		(i2c_ctrl_clk),	//	Controller Work Clock
		.i2c_en			(i2c_negclk),		//	I2C DATA ENABLE
		.i2c_wdata		(i2c_data),//	DATA:[SLAVE_ADDR,SUB_ADDR,DATA]
		.i2c_sclk		(i2c_sclk),			//	I2C CLOCK
		.i2c_sdat		(i2c_sdat),			//	I2C DATA
		
		.trans			(i2c_trans),			//	Go Transfer
		.wr				(i2c_wr),      	//	END transfor
		.ack			(i2c_ack),			//	ACK
		.i2c_end		(i2c_end),			//	END transfor 
		.i2c_rdata		(/*I2C_RDATA*/)			//	ID
	);


			
	////////////////////////////////////////////////////////////////////
	I2C_OV5640_RGB565_Config	u_I2C_OV5640_RGB565_Config
	(
		.LUT_INDEX		(lut_index	),
		.LUT_DATA		(lut_data	),
		.LUT_SIZE		(LUT_SIZE	)
	);



endmodule

