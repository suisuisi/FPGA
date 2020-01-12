`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:10 01/09/2015 
// Design Name: 
// Module Name:    I2C_OV7670_RGB565_Config 
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
module I2C_OV7670_RGB565_Config(
			input		[7:0]	LUT_INDEX,
			output	reg	[15:0]	LUT_DATA
    );

/////////////////////	Config Data LUT	  //////////////////////////	
always@(*)
begin
	case(LUT_INDEX)
//	-- Powerup please!  reg_addr  value
	 0 	: 	LUT_DATA	= 	{8'h41, 8'h00};   //16'h4110; 	
// -- These valuse must be set as follows
	 1 	: 	LUT_DATA	= 	16'h9803;
	 2 	: 	LUT_DATA	= 	16'h9AE0;	
	 3 	: 	LUT_DATA	=	16'h9C30;	
	 4 	: 	LUT_DATA	= 	16'h9D61;	
	 5 	: 	LUT_DATA	= 	16'hA2A4;	
	 6 	: 	LUT_DATA	= 	16'hA3A4;	
	 7 	: 	LUT_DATA	= 	16'hE0D0;	
	 8 	: 	LUT_DATA	= 	16'h5512;	
	 9 	: 	LUT_DATA	= 	16'hF900;
//-- Input mode	 
	 10	: 	LUT_DATA	= 	16'h1506;  //input ID = 0x6 = 0110 = 8,10,12 bit YCbCr 4:2:2 (DDR with separate syncs) 
	 11	: 	LUT_DATA	= 	16'h4810;  // [4:3] = 01 = right justified 
	 12   : 	LUT_DATA	= 	16'h1637; // 0011_0111  OutputFormat = 4:4:4, 8 bit, style 2 , YCbCr 
	 13   : 	LUT_DATA	= 	16'h1700;	
	 14 : 	LUT_DATA	= 	16'hD03C;
//-- Output mode	 
	 15 : 	LUT_DATA	= 	16'hAF04;	
	 16 : 	LUT_DATA	= 	16'h4c04;	
	 17 : 	LUT_DATA	= 	16'h4000;
//-- Here is the YCrCb => RGB conversion, as per programming guide
//-- This is table 57 - HDTV YCbCr (16 to 255) to RGB (0 to 255)	 
// -- (Cr * A1       +      Y * A2       +     Cb * A3)/4096 +     A4    =  Red
	 18 : 	LUT_DATA	= 	16'h18E7;	
	 19 : 	LUT_DATA	= 	16'h1934;	
	 20 : 	LUT_DATA	= 	16'h1A04;
	 21 : 	LUT_DATA	= 	16'h1BAD;
	 22 : 	LUT_DATA	= 	16'h1C00;
	 23 : 	LUT_DATA	= 	16'h1D00;
	 24 : 	LUT_DATA	= 	16'h1E1C;
	 25 : 	LUT_DATA	= 	16'h1F1B;
//-- (Cr * B1  +      Y * B2       +     Cb * B3)/4096 +     B4    =  Green
	 26 : 	LUT_DATA	= 	16'h201D;
	 27 : 	LUT_DATA	= 	16'h21DC;
	 28 : 	LUT_DATA	= 	16'h2204;
	 29 : 	LUT_DATA	= 	16'h23AD;
	 30 : 	LUT_DATA	= 	16'h241F;
	 31 : 	LUT_DATA	= 	16'h2524;
	 32 : 	LUT_DATA	= 	16'h2601;
	 33 : 	LUT_DATA	= 	16'h2735;
//-- (Cr * C1   +      Y * C2       +     Cb * C3)/4096 +     C4    =  Blue
	 34 : 	LUT_DATA	= 	16'h2800;
	 35 : 	LUT_DATA	= 	16'h2900;
	 36 : 	LUT_DATA	= 	16'h2A04;
	 37 : 	LUT_DATA	= 	16'h2BAD;
	 38 : 	LUT_DATA	= 	16'h2C08;
	 39 : 	LUT_DATA	= 	16'h2D7C;
	 40 : 	LUT_DATA	= 	16'h2E1B;	
	 41 : 	LUT_DATA	= 	16'h2F77;	
//-- Extra space filled with FFFFs to signify end of data	 
	default:	LUT_DATA	=	16'hFFFF;
	endcase
end
endmodule
