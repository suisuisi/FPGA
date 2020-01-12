`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:50 01/05/2015 
// Design Name: 
// Module Name:    colour_space_conversion 
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
module colour_space_conversion(
//input signal
    input clk,
    input [8:0] r1_in,
    input [8:0] g1_in,
    input [8:0] b1_in,
    input [8:0] r2_in,
    input [8:0] g2_in,
    input [8:0] b2_in,
    input pair_start_in,
    input de_in,
	 input hsync_in,
    input vsync_in,
	 
//output signal	 
    output [7:0] y_out,
    output [7:0] c_out,
    output de_out,
    output hsync_out,
    output vsync_out
    );
	 
        reg [3:0] hs_delay;
		  reg [3:0] vs_delay;
		  reg [3:0] de_delay;  
        reg [7:0] y_out_r;
        reg [7:0] c_out_r;
        reg de_out_r;
        reg hsync_out_r;
        reg vsync_out_r;
        
        assign y_out   =  y_out_r;
        assign c_out   =  c_out_r;
        assign de_out  =  de_out_r;
        assign hsync_out =  hsync_out_r;
        assign vsync_out =  vsync_out_r;
		  
/********************************************    计算 Y  ***********************************************
	   条件： 32768 = 2^15;	
	         r1_in = 2 * r ,      g1_in = 2 * g,        b1_in = 2 * b;
				a_r1 = (2^15)*r1_in, a_g1 = (2^15)*g1_in,  a_b1 = (2^15)*b1_in
				b_r1 =(2^2)*8432,    b_g1 = (2^2)*16425,   b_b1 = (2^2)*3176					 
	
 y = ( 8432 * r + 16425 * g +  3176 * b) / 32768 + 16 = 0.2573*r + 0.5013*g + 0.0969b + 16
 
(2^15)*Y = ( 8432 * r + 16425 * g +  3176 * b) + 2^4*2^15 =  ( 8432 * r + 16425 * g +  3176 * B) + 2^19
(2^15)*Y*2 = ( 8432 * r1_in + 16425 * g1_in +  3176 * b1_in) + 2^19*2
(2^16)*Y = ( 8432 * r1_in + 16425 * g1_in +  3176 * b1_in) + 2^20
((2^16)*(2^2)*(2^15))*Y  = (b_r1*a_r1 + b_g1*a_g1 + b_b1*a_b1)+ (2^20)*(2^2)*(2^15)

 (2^33)*Y =  (b_r1*a_r1 + b_g1*a_g1 + b_b1*a_b1) + 2^37
 (2^33)*Y =  (b_r1*a_r1 + b_g1*a_g1 + b_b1*a_b1) + c1
 
******************************************************************************************************/

/********************************************  计算 Cb Cr *********************************************
     条件： 32768 = 2^15;	
	        r2_in = 2*r,           g2_in = 2*g,            b2_in = 2*b
           a_r2 = (2^15)*r2_in    a_g2 = (2^15)*g2_in     a_b2 = (2^15)*b2_in
			  r, g, b 前面的系数都扩大了 4 倍
  
  
 cb = (-4818 * r -  9527 * g + 14345 * B) / 32768 + 128 = -0.147*r - 0.2907*g + 0.4378*b + 128
 cr = (14345 * r - 12045 * g -  2300 * B) / 32768 + 128 = 0.4378*r - 0.3676*g - 0.0702*b + 128
 
 (2^15)*Cb = (-4818 * r -  9527 * g + 14345 * B) + (2^15)*(2^7)
 (2^15)*Cb = (-4818 * r -  9527 * g + 14345 * B) + (2^22)
 (2^15)*Cb*(2^2)*(2*2^15) = (b_r2 * a_r2 + b_g2 *a_g2 + b_b2 *a_b2) + (2^22)*(2^2)*(2*2^15)
 
 (2^33)*Cb = (b_r2 * a_r2 + b_g2 *a_g2 + b_b2 *a_b2) + (2^40)
 (2^33)*Cb = (b_r2 * a_r2 + b_g2 *a_g2 + b_b2 *a_b2) + c2
 
*******************************************************************************************************/ 

    wire [47:0] pc_r1, pc_g1, p_b1;
    wire [47:0] pc_r2, pc_g2, p_b2;
            
    wire [29:0] a_r1,  a_g1,  a_b1;
	 wire [29:0] a_r2,  a_g2,  a_b2;
    wire [17:0] b_r2,  b_g2,  b_b2;


// Y 的系数  （系数都扩大4（2^2）倍）
localparam  b_r1 = {16'h20F0,2'b00}; //8432 = 16'h20F0
localparam  b_g1 = {16'h4029,2'b00}; //16425 = 16'h4029
localparam  b_b1 = {16'h0C68,2'b00}; //3176 = 16'h0C68
// Cb & Cr 系数(1，这里取负数的补码        2，系数扩大 4（2^2）倍)   -4818 -> 60718,  14345  -> 14345 and so on
assign  b_r2 = (pair_start_in)?{16'hED2E,2'b00}:{16'h3809,2'b00}; //60718 or 14345 ** -4818 or 14345
assign  b_g2 = (pair_start_in)?{16'hDAC9,2'b00}:{16'hD0F3,2'b00}; //56009 or 53491 ** -9527 or -12045
assign  b_b2 = (pair_start_in)?{16'h3809,2'b00}:{16'hF704,2'b00}; //14345 or 63236 ** 14345 or -2300



	 
//  RGB 参数都扩大 2^15倍 
assign  a_r1 = {6'b000000,r1_in,12'h000,3'b000}; 
assign  a_g1 = {6'b000000,g1_in,12'h000,3'b000};
assign  a_b1 = {6'b000000,b1_in,12'h000,3'b000};
assign  a_r2 = {6'b000000,r2_in,12'h000,3'b000};
assign  a_g2 = {6'b000000,g2_in,12'h000,3'b000};
assign  a_b2 = {6'b000000,b2_in,12'h000,3'b000};
 
localparam  c1   = 48'h002000000000;  //2^37
localparam  c2   = 48'h010000000000;  //2^40


 
always@(posedge clk)
     begin
           hsync_out_r <= hs_delay[3];
           vsync_out_r <= vs_delay[3];
           de_out_r    <= de_delay[3];
            
           hs_delay  <= {hs_delay[2:0],hsync_in};				
           vs_delay  <= {vs_delay[2:0],vsync_in};
			  de_delay  <= {de_delay[2:0],de_in};
  
           y_out_r <= p_b1[40:33];    // DSP48E1 计算出来的 y,由于之前扩大了 （2^33）倍，所以右移 33位
           c_out_r <= p_b2[40:33];   // DSP48E1 计算出来的 Cb or Cr ，由于之前扩大了 （2^33）倍，所以右移 33位  
     end
      
 
 
 //////////////////////////////////////////////////////  To Get Y //////////////////////////////////////////////////////

 // The  First DSP48E1 
DSP48E1 #(
 //      -- Feature Control Attributes: Data Path Selection
       .A_INPUT("DIRECT"),               //-- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
       .B_INPUT("DIRECT"),               //-- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
       .USE_DPORT("FALSE"),                //-- Select D port usage (TRUE or FALSE)
       .USE_MULT("MULTIPLY"),            //-- Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
       .USE_SIMD("ONE48"),               //-- SIMD selection ("ONE48", "TWO24", "FOUR12")
 //      -- Pattern Detector Attributes: Pattern Detection Configuration
       .AUTORESET_PATDET("NO_RESET"),    //-- "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
       .MASK(48'h3FFFFFFFFFFF),           //-- 48-bit mask value for pattern detect (1=ignore)
       .PATTERN(48'h000000000000),        //-- 48-bit pattern match for pattern detect
       .SEL_MASK("MASK"),                //-- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
       .SEL_PATTERN("PATTERN"),          //-- Select pattern value ("PATTERN" or "C")
       .USE_PATTERN_DETECT("NO_PATDET"), //-- Enable pattern detect ("PATDET" or "NO_PATDET")
  //     -- Register Control Attributes: Pipeline Register Configuration
       .ACASCREG(1'b0),                     //-- Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
       .ADREG(1'b0),                        //-- Number of pipeline stages for pre-adder (0 or 1)
       .ALUMODEREG (1'b1),                   //-- Number of pipeline stages for ALUMODE (0 or 1)
       .AREG (1'b0),                         //-- Number of pipeline stages for A (0, 1 or 2)
       .BCASCREG (1'b0),                     //-- Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
       .BREG (1'b0),                         //-- Number of pipeline stages for B (0, 1 or 2)
       .CARRYINREG (1'b1),                   //-- Number of pipeline stages for CARRYIN (0 or 1)
       .CARRYINSELREG (1'b1),                //-- Number of pipeline stages for CARRYINSEL (0 or 1)
       .CREG (1'b0),                         //-- Number of pipeline stages for C (0 or 1)
       .DREG (1'b0),                         //-- Number of pipeline stages for D (0 or 1)
       .INMODEREG (1'b1),                    //-- Number of pipeline stages for INMODE (0 or 1)
       .MREG (1'b1),                         //-- Number of multiplier pipeline stages (0 or 1)
       .OPMODEREG (1'b1),                    //-- Number of pipeline stages for OPMODE (0 or 1)
       .PREG (1'b1)                          //-- Number of pipeline stages for P (0 or 1)
    ) mult_r1(
   //    -- Cascade: 30-bit (each) output: Cascade Ports
       .ACOUT        ( ),    //-- 30-bit output: A port cascade output
       .BCOUT        ( ),    //-- 18-bit output: B port cascade output
       .CARRYCASCOUT ( ),    //-- 1-bit output: Cascade carry output
       .MULTSIGNOUT  ( ),    //-- 1-bit output: Multiplier sign cascade output
       .PCOUT        ( pc_r1),   //-- 48-bit output: Cascade output                    /////////////// 8432*r
   //    -- Control: 1-bit (each) output: Control Inputs/Status Bits
       .OVERFLOW       ( ),  //-- 1-bit output: Overflow in add/acc output
       .PATTERNBDETECT ( ),  //-- 1-bit output: Pattern bar detect output
       .PATTERNDETECT  ( ),  //-- 1-bit output: Pattern detect output
       .UNDERFLOW      ( ),  //-- 1-bit output: Underflow in add/acc output
   //    -- Data: 4-bit (each) output: Data Ports
       .CARRYOUT       ( ),  //-- 4-bit output: Carry output
       .P              ( ),  //-- 48-bit output: Primary data output
  //     -- Cascade: 30-bit (each) input: Cascade Ports
       .ACIN        (30'd0), //-- 30-bit input: A cascade data input
       .BCIN        (18'd0), //-- 18-bit input: B cascade input
       .CARRYCASCIN (1'b0),             //-- 1-bit input: Cascade carry input
       .MULTSIGNIN  (1'b0),             //-- 1-bit input: Multiplier sign input
       .PCIN        (48'd0), //-- 48-bit input: P cascade input
   //    -- Control: 4-bit (each) input: Control Inputs/Status Bits
       .CLK        (clk),        //-- 1-bit input: Clock input
       .ALUMODE    (4'b0000),     //-- 4-bit input: ALU control input
       .CARRYINSEL (3'b000),      //-- 3-bit input: Carry select input
       .CEINMODE   (1'b1),        //-- 1-bit input: Clock enable input for INMODEREG
       .INMODE     (5'b00000),    //-- 5-bit input: INMODE control input
       .OPMODE     (7'b0110101),  //-- 7-bit input: Operation mode input
       .RSTINMODE  (1'b0),           //-- 1-bit input: Reset input for INMODEREG
  //     -- Data: 30-bit (each) input: Data Ports
       .A (a_r1),      //-- 30-bit input: A data input     assign  a_r1 = {6'b000000,r1_in,12'h000,3'b000}; 
       .B (b_r1),      // -- 18-bit input: B data input    localparam  b_r1 = {16'h20F0,2'b00}; //8432
       .C (c1),        //-- 48-bit input: C data input     localparam  c1   = 48'h002000000000;  //2^37
       .CARRYIN (1'b0),   //-- 1-bit input: Carry input signal
       .D (25'd0),       //-- 25-bit input: D data input
 //      -- Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
       .CEA1 (1'b0),                   //  -- 1-bit input: Clock enable input for 1st stage AREG
       .CEA2 (1'b0),                   //  -- 1-bit input: Clock enable input for 2nd stage AREG
       .CEAD (1'b0),                   //  -- 1-bit input: Clock enable input for ADREG
       .CEALUMODE (1'b1),           //-- 1-bit input: Clock enable input for ALUMODE
       .CEB1 (1'b0),                    // -- 1-bit input: Clock enable input for 1st stage BREG
       .CEB2 (1'b0),                    // -- 1-bit input: Clock enable input for 2nd stage BREG
       .CEC (1'b0),                     //  -- 1-bit input: Clock enable input for CREG
       .CECARRYIN (1'b1),          // -- 1-bit input: Clock enable input for CARRYINREG
       .CECTRL ( 1'b1),                 //-- 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
       .CED (1'b0),                      // -- 1-bit input: Clock enable input for DREG
       .CEM (1'b1),                      // -- 1-bit input: Clock enable input for MREG
       .CEP (1'b1),                      // -- 1-bit input: Clock enable input for PREG
       .RSTA (1'b0),                    // -- 1-bit input: Reset input for AREG
       .RSTALLCARRYIN (1'b0),   //-- 1-bit input: Reset input for CARRYINREG
       .RSTALUMODE (1'b0),        // -- 1-bit input: Reset input for ALUMODEREG
       .RSTB (1'b0),                     //-- 1-bit input: Reset input for BREG
       .RSTC (1'b0),                     //-- 1-bit input: Reset input for CREG
       .RSTCTRL (1'b0),               //-- 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
       .RSTD (1'b0),                    // -- 1-bit input: Reset input for DREG and ADREG
       .RSTM (1'b0),                    // -- 1-bit input: Reset input for MREG
       .RSTP (1'b0)                      //-- 1-bit input: Reset input for PREG
    );   
    
//   The Second DSP48E1  
        DSP48E1 #(
     //      -- Feature Control Attributes: Data Path Selection
           .A_INPUT("DIRECT"),               //-- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
           .B_INPUT("DIRECT"),               //-- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
           .USE_DPORT("FALSE"),                //-- Select D port usage (TRUE or FALSE)
           .USE_MULT("MULTIPLY"),            //-- Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
           .USE_SIMD("ONE48"),               //-- SIMD selection ("ONE48", "TWO24", "FOUR12")
     //      -- Pattern Detector Attributes: Pattern Detection Configuration
           .AUTORESET_PATDET("NO_RESET"),    //-- "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
           .MASK(48'h3FFFFFFFFFFF),           //-- 48-bit mask value for pattern detect (1=ignore)
           .PATTERN(48'h000000000000),        //-- 48-bit pattern match for pattern detect
           .SEL_MASK("MASK"),                //-- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
           .SEL_PATTERN("PATTERN"),          //-- Select pattern value ("PATTERN" or "C")
           .USE_PATTERN_DETECT("NO_PATDET"), //-- Enable pattern detect ("PATDET" or "NO_PATDET")
      //     -- Register Control Attributes: Pipeline Register Configuration
           .ACASCREG(1'b1),                     //-- Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
           .ADREG(1'b0),                        //-- Number of pipeline stages for pre-adder (0 or 1)
           .ALUMODEREG ( 1'b1),                   //-- Number of pipeline stages for ALUMODE (0 or 1)
           .AREG ( 1'b1),                         //-- Number of pipeline stages for A (0, 1 or 2)
           .BCASCREG ( 1'b1),                     //-- Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
           .BREG ( 1'b1),                         //-- Number of pipeline stages for B (0, 1 or 2)
           .CARRYINREG ( 1'b1),                   //-- Number of pipeline stages for CARRYIN (0 or 1)
           .CARRYINSELREG ( 1'b1),                //-- Number of pipeline stages for CARRYINSEL (0 or 1)
           .CREG ( 1'b0),                         //-- Number of pipeline stages for C (0 or 1)
           .DREG ( 1'b0),                         //-- Number of pipeline stages for D (0 or 1)
           .INMODEREG ( 1'b1),                    //-- Number of pipeline stages for INMODE (0 or 1)
           .MREG ( 1'b1),                         //-- Number of multiplier pipeline stages (0 or 1)
           .OPMODEREG ( 1'b1),                    //-- Number of pipeline stages for OPMODE (0 or 1)
           .PREG ( 1'b1)                          //-- Number of pipeline stages for P (0 or 1)
        ) mult_g1(
       //    -- Cascade: 30-bit (each) output: Cascade Ports
           .ACOUT        ( ),    //-- 30-bit output: A port cascade output
           .BCOUT        ( ),    //-- 18-bit output: B port cascade output
           .CARRYCASCOUT ( ),    //-- 1-bit output: Cascade carry output
           .MULTSIGNOUT  ( ),    //-- 1-bit output: Multiplier sign cascade output
           .PCOUT        (pc_g1),   //-- 48-bit output: Cascade output
       //    -- Control: 1-bit (each) output: Control Inputs/Status Bits
           .OVERFLOW       ( ),  //-- 1-bit output: Overflow in add/acc output
           .PATTERNBDETECT ( ),  //-- 1-bit output: Pattern bar detect output
           .PATTERNDETECT  ( ),  //-- 1-bit output: Pattern detect output
           .UNDERFLOW      ( ),  //-- 1-bit output: Underflow in add/acc output
       //    -- Data: 4-bit (each) output: Data Ports
           .CARRYOUT       ( ),  //-- 4-bit output: Carry output
           .P              ( ),  //-- 48-bit output: Primary data output
      //     -- Cascade: 30-bit (each) input: Cascade Ports
           .ACIN        (30'd0), //-- 30-bit input: A cascade data input
           .BCIN        (18'd0), //-- 18-bit input: B cascade input
           .CARRYCASCIN (1'b0),             //-- 1-bit input: Cascade carry input
           .MULTSIGNIN  (1'b0),             //-- 1-bit input: Multiplier sign input
           .PCIN        (pc_r1), //-- 48-bit input: P cascade input
       //    -- Control: 4-bit (each) input: Control Inputs/Status Bits
           .CLK        (clk),        //-- 1-bit input: Clock input
           .ALUMODE    (4'b0000),     //-- 4-bit input: ALU control input
           .CARRYINSEL (3'b000),      //-- 3-bit input: Carry select input
           .CEINMODE   (1'b1),        //-- 1-bit input: Clock enable input for INMODEREG
           .INMODE     (5'b00000),    //-- 5-bit input: INMODE control input
           .OPMODE     (7'b0010101),  //-- 7-bit input: Operation mode input
           .RSTINMODE  (1'b0),           //-- 1-bit input: Reset input for INMODEREG
      //     -- Data: 30-bit (each) input: Data Ports
           .A ( a_g1),      //-- 30-bit input: A data input
           .B ( b_g1),   // -- 18-bit input: B data input    localparam  b_g1 = {16'h4029,2'b00}; //16425 = 16'h4029
           .C ( 48'd0),              //-- 48-bit input: C data input
           .CARRYIN ( 1'b0),                   //-- 1-bit input: Carry input signal
           .D ( 25'd0),              //-- 25-bit input: D data input
     //      -- Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
           .CEA1 ( 1'b0),                   //  -- 1-bit input: Clock enable input for 1st stage AREG
           .CEA2 ( 1'b1),                   //  -- 1-bit input: Clock enable input for 2nd stage AREG
           .CEAD ( 1'b1),                   //  -- 1-bit input: Clock enable input for ADREG
           .CEALUMODE ( 1'b1),           //-- 1-bit input: Clock enable input for ALUMODE
           .CEB1 ( 1'b0),                    // -- 1-bit input: Clock enable input for 1st stage BREG
           .CEB2 ( 1'b1),                    // -- 1-bit input: Clock enable input for 2nd stage BREG
           .CEC ( 1'b0),                     //  -- 1-bit input: Clock enable input for CREG
           .CECARRYIN ( 1'b1),          // -- 1-bit input: Clock enable input for CARRYINREG
           .CECTRL ( 1'b1),                 //-- 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
           .CED ( 1'b0),                      // -- 1-bit input: Clock enable input for DREG
           .CEM ( 1'b1),                      // -- 1-bit input: Clock enable input for MREG
           .CEP ( 1'b1),                      // -- 1-bit input: Clock enable input for PREG
           .RSTA ( 1'b0),                    // -- 1-bit input: Reset input for AREG
           .RSTALLCARRYIN ( 1'b0),   //-- 1-bit input: Reset input for CARRYINREG
           .RSTALUMODE ( 1'b0),        // -- 1-bit input: Reset input for ALUMODEREG
           .RSTB ( 1'b0),                     //-- 1-bit input: Reset input for BREG
           .RSTC ( 1'b0),                     //-- 1-bit input: Reset input for CREG
           .RSTCTRL ( 1'b0),               //-- 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
           .RSTD ( 1'b0),                    // -- 1-bit input: Reset input for DREG and ADREG
           .RSTM ( 1'b0),                    // -- 1-bit input: Reset input for MREG
           .RSTP ( 1'b0)                      //-- 1-bit input: Reset input for PREG
        );  
        
        
//  The Third DSP48E1        
           DSP48E1 #(
         //      -- Feature Control Attributes: Data Path Selection
               .A_INPUT("DIRECT"),               //-- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
               .B_INPUT("DIRECT"),               //-- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
               .USE_DPORT("FALSE"),                //-- Select D port usage (TRUE or FALSE)
               .USE_MULT("MULTIPLY"),            //-- Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
               .USE_SIMD("ONE48"),               //-- SIMD selection ("ONE48", "TWO24", "FOUR12")
         //      -- Pattern Detector Attributes: Pattern Detection Configuration
               .AUTORESET_PATDET("NO_RESET"),    //-- "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
               .MASK(48'h3fffffffffff),           //-- 48-bit mask value for pattern detect (1=ignore)
               .PATTERN(48'h000000000000),        //-- 48-bit pattern match for pattern detect
               .SEL_MASK("MASK"),                //-- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
               .SEL_PATTERN("PATTERN"),          //-- Select pattern value ("PATTERN" or "C")
               .USE_PATTERN_DETECT("NO_PATDET"), //-- Enable pattern detect ("PATDET" or "NO_PATDET")
          //     -- Register Control Attributes: Pipeline Register Configuration
               .ACASCREG(2),                     //-- Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
               .ADREG(0),                        //-- Number of pipeline stages for pre-adder (0 or 1)
               .ALUMODEREG ( 1),                   //-- Number of pipeline stages for ALUMODE (0 or 1)
               .AREG (2),                         //-- Number of pipeline stages for A (0, 1 or 2)
               .BCASCREG (1),                     //-- Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
               .BREG (1),                         //-- Number of pipeline stages for B (0, 1 or 2)
               .CARRYINREG (1),                   //-- Number of pipeline stages for CARRYIN (0 or 1)
               .CARRYINSELREG (1),                //-- Number of pipeline stages for CARRYINSEL (0 or 1)
               .CREG (0),                         //-- Number of pipeline stages for C (0 or 1)
               .DREG (0),                         //-- Number of pipeline stages for D (0 or 1)
               .INMODEREG (1),                    //-- Number of pipeline stages for INMODE (0 or 1)
               .MREG (1),                         //-- Number of multiplier pipeline stages (0 or 1)
               .OPMODEREG (1),                    //-- Number of pipeline stages for OPMODE (0 or 1)
               .PREG (1)                          //-- Number of pipeline stages for P (0 or 1)
            ) mult_b1(
           //    -- Cascade: 30-bit (each) output: Cascade Ports
               .ACOUT        ( ),    //-- 30-bit output: A port cascade output
               .BCOUT        ( ),    //-- 18-bit output: B port cascade output
               .CARRYCASCOUT ( ),    //-- 1-bit output: Cascade carry output
               .MULTSIGNOUT  ( ),    //-- 1-bit output: Multiplier sign cascade output
               .PCOUT        ( ),   //-- 48-bit output: Cascade output
           //    -- Control: 1-bit (each) output: Control Inputs/Status Bits
               .OVERFLOW       ( ),  //-- 1-bit output: Overflow in add/acc output
               .PATTERNBDETECT ( ),  //-- 1-bit output: Pattern bar detect output
               .PATTERNDETECT  ( ),  //-- 1-bit output: Pattern detect output
               .UNDERFLOW      ( ),  //-- 1-bit output: Underflow in add/acc output
           //    -- Data: 4-bit (each) output: Data Ports
               .CARRYOUT       ( ),  //-- 4-bit output: Carry output
               .P              (p_b1),  //-- 48-bit output: Primary data output    算出 Y
          //     -- Cascade: 30-bit (each) input: Cascade Ports
               .ACIN        ( 30'd0), //-- 30-bit input: A cascade data input
               .BCIN        ( 18'd0), //-- 18-bit input: B cascade input
               .CARRYCASCIN ( 1'b0),             //-- 1-bit input: Cascade carry input
               .MULTSIGNIN  ( 1'b0),             //-- 1-bit input: Multiplier sign input
               .PCIN        ( pc_g1), //-- 48-bit input: P cascade input
           //    -- Control: 4-bit (each) input: Control Inputs/Status Bits
               .CLK        ( clk),        //-- 1-bit input: Clock input
               .ALUMODE    ( 4'b0000),     //-- 4-bit input: ALU control input
               .CARRYINSEL ( 3'b000),      //-- 3-bit input: Carry select input
               .CEINMODE   ( 1'b1),        //-- 1-bit input: Clock enable input for INMODEREG
               .INMODE     ( 5'b00000),    //-- 5-bit input: INMODE control input
               .OPMODE     ( 7'b0010101),  //-- 7-bit input: Operation mode input
               .RSTINMODE  (1'b0),           //-- 1-bit input: Reset input for INMODEREG
          //     -- Data: 30-bit (each) input: Data Ports
               .A ( a_b1),      //-- 30-bit input: A data input
               .B ( b_b1),      // -- 18-bit input: B data input   localparam  b_b1 = {16'h0C68,2'b00}; //3176 = 16'h0C68
               .C ( 48'd0),    //-- 48-bit input: C data input
               .CARRYIN ( 1'b0),   //-- 1-bit input: Carry input signal
               .D ( 25'd0),              //-- 25-bit input: D data input
         //      -- Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
               .CEA1 ( 1'b1),                   //  -- 1-bit input: Clock enable input for 1st stage AREG
               .CEA2 ( 1'b1),                   //  -- 1-bit input: Clock enable input for 2nd stage AREG
               .CEAD ( 1'b0),                   //  -- 1-bit input: Clock enable input for ADREG
               .CEALUMODE ( 1'b1),           //-- 1-bit input: Clock enable input for ALUMODE
               .CEB1 ( 1'b0),                    // -- 1-bit input: Clock enable input for 1st stage BREG
               .CEB2 ( 1'b1),                    // -- 1-bit input: Clock enable input for 2nd stage BREG
               .CEC ( 1'b0),                     //  -- 1-bit input: Clock enable input for CREG
               .CECARRYIN ( 1'b1),          // -- 1-bit input: Clock enable input for CARRYINREG
               .CECTRL ( 1'b1),                 //-- 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
               .CED ( 1'b0),                      // -- 1-bit input: Clock enable input for DREG
               .CEM ( 1'b1),                      // -- 1-bit input: Clock enable input for MREG
               .CEP ( 1'b1),                      // -- 1-bit input: Clock enable input for PREG
               .RSTA ( 1'b0),                    // -- 1-bit input: Reset input for AREG
               .RSTALLCARRYIN ( 1'b0),   //-- 1-bit input: Reset input for CARRYINREG
               .RSTALUMODE ( 1'b0),        // -- 1-bit input: Reset input for ALUMODEREG
               .RSTB ( 1'b0),                     //-- 1-bit input: Reset input for BREG
               .RSTC ( 1'b0),                     //-- 1-bit input: Reset input for CREG
               .RSTCTRL ( 1'b0),               //-- 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
               .RSTD ( 1'b0),                    // -- 1-bit input: Reset input for DREG and ADREG
               .RSTM ( 1'b0),                    // -- 1-bit input: Reset input for MREG
               .RSTP ( 1'b0)                      //-- 1-bit input: Reset input for PREG
            );    
  
////////////////////////////////////////////////  To get C /////////////////////////////////////////////////////////////
//  The Fourth  DSP48E1
 
   DSP48E1 #(
   //      -- Feature Control Attributes: Data Path Selection
         .A_INPUT("DIRECT"),               //-- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
         .B_INPUT("DIRECT"),               //-- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
         .USE_DPORT("FALSE"),                //-- Select D port usage (TRUE or FALSE)
         .USE_MULT("MULTIPLY"),            //-- Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
         .USE_SIMD("ONE48"),               //-- SIMD selection ("ONE48", "TWO24", "FOUR12")
   //      -- Pattern Detector Attributes: Pattern Detection Configuration
         .AUTORESET_PATDET("NO_RESET"),    //-- "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
         .MASK(48'h3fffffffffff),           //-- 48-bit mask value for pattern detect (1=ignore)
         .PATTERN(48'h000000000000),        //-- 48-bit pattern match for pattern detect
         .SEL_MASK("MASK"),                //-- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
         .SEL_PATTERN("PATTERN"),          //-- Select pattern value ("PATTERN" or "C")
         .USE_PATTERN_DETECT("NO_PATDET"), //-- Enable pattern detect ("PATDET" or "NO_PATDET")
    //     -- Register Control Attributes: Pipeline Register Configuration
         .ACASCREG(1'b0),                     //-- Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
         .ADREG(0),                        //-- Number of pipeline stages for pre-adder (0 or 1)
         .ALUMODEREG ( 1'b1),                   //-- Number of pipeline stages for ALUMODE (0 or 1)
         .AREG ( 1'b0),                         //-- Number of pipeline stages for A (0, 1 or 2)
         .BCASCREG ( 1'b0),                     //-- Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
         .BREG ( 1'b0),                         //-- Number of pipeline stages for B (0, 1 or 2)
         .CARRYINREG ( 1'b1),                   //-- Number of pipeline stages for CARRYIN (0 or 1)
         .CARRYINSELREG ( 1'b1),                //-- Number of pipeline stages for CARRYINSEL (0 or 1)
         .CREG ( 1'b0),                         //-- Number of pipeline stages for C (0 or 1)
         .DREG ( 1'b0),                         //-- Number of pipeline stages for D (0 or 1)
         .INMODEREG ( 1'b1),                    //-- Number of pipeline stages for INMODE (0 or 1)
         .MREG ( 1'b1),                         //-- Number of multiplier pipeline stages (0 or 1)
         .OPMODEREG ( 1'b1),                    //-- Number of pipeline stages for OPMODE (0 or 1)
         .PREG ( 1'b1)                          //-- Number of pipeline stages for P (0 or 1)
      ) mult_r2(
     //    -- Cascade: 30-bit (each) output: Cascade Ports
         .ACOUT        ( ),    //-- 30-bit output: A port cascade output
         .BCOUT        ( ),    //-- 18-bit output: B port cascade output
         .CARRYCASCOUT ( ),    //-- 1-bit output: Cascade carry output
         .MULTSIGNOUT  ( ),    //-- 1-bit output: Multiplier sign cascade output
         .PCOUT        ( pc_r2),   //-- 48-bit output: Cascade output
     //    -- Control: 1-bit (each) output: Control Inputs/Status Bits
         .OVERFLOW       ( ),  //-- 1-bit output: Overflow in add/acc output
         .PATTERNBDETECT ( ),  //-- 1-bit output: Pattern bar detect output
         .PATTERNDETECT  ( ),  //-- 1-bit output: Pattern detect output
         .UNDERFLOW      ( ),  //-- 1-bit output: Underflow in add/acc output
     //    -- Data: 4-bit (each) output: Data Ports
         .CARRYOUT       ( ),  //-- 4-bit output: Carry output
         .P              ( ),  //-- 48-bit output: Primary data output
    //     -- Cascade: 30-bit (each) input: Cascade Ports
         .ACIN        ( 30'd0), //-- 30-bit input: A cascade data input
         .BCIN        ( 18'd0), //-- 18-bit input: B cascade input
         .CARRYCASCIN ( 1'b0),             //-- 1-bit input: Cascade carry input
         .MULTSIGNIN  ( 1'b0),             //-- 1-bit input: Multiplier sign input
         .PCIN        ( 48'd0), //-- 48-bit input: P cascade input
     //    -- Control: 4-bit (each) input: Control Inputs/Status Bits
         .CLK        ( clk),        //-- 1-bit input: Clock input
         .ALUMODE    ( 4'b0000),     //-- 4-bit input: ALU control input
         .CARRYINSEL ( 3'b000),      //-- 3-bit input: Carry select input
         .CEINMODE   ( 1'b1),        //-- 1-bit input: Clock enable input for INMODEREG
         .INMODE     ( 5'b00000),    //-- 5-bit input: INMODE control input
         .OPMODE     ( 7'b0110101),  //-- 7-bit input: Operation mode input
         .RSTINMODE  ( 1'b0),           //-- 1-bit input: Reset input for INMODEREG
    //     -- Data: 30-bit (each) input: Data Ports
         .A ( a_r2),    //-- 30-bit input: A data input
         .B ( b_r2),    // -- 18-bit input: B data input
         .C (c2),     //-- 48-bit input: C data input     
         .CARRYIN ( 1'b0),  //-- 1-bit input: Carry input signal
         .D ( 25'd0),       //-- 25-bit input: D data input
   //      -- Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
         .CEA1 ( 1'b0),        //  -- 1-bit input: Clock enable input for 1st stage AREG
         .CEA2 ( 1'b0),     //  -- 1-bit input: Clock enable input for 2nd stage AREG
         .CEAD ( 1'b0),      //  -- 1-bit input: Clock enable input for ADREG
         .CEALUMODE ( 1'b1),  //-- 1-bit input: Clock enable input for ALUMODE
         .CEB1 ( 1'b0),         // -- 1-bit input: Clock enable input for 1st stage BREG
         .CEB2 ( 1'b0),        // -- 1-bit input: Clock enable input for 2nd stage BREG
         .CEC ( 1'b0),          //  -- 1-bit input: Clock enable input for CREG
         .CECARRYIN ( 1'b1),    // -- 1-bit input: Clock enable input for CARRYINREG
         .CECTRL ( 1'b1),     //-- 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
         .CED ( 1'b0),         // -- 1-bit input: Clock enable input for DREG
         .CEM ( 1'b1),      // -- 1-bit input: Clock enable input for MREG
         .CEP ( 1'b1),     // -- 1-bit input: Clock enable input for PREG
         .RSTA ( 1'b0),    // -- 1-bit input: Reset input for AREG
         .RSTALLCARRYIN ( 1'b0),   //-- 1-bit input: Reset input for CARRYINREG
         .RSTALUMODE ( 1'b0),        // -- 1-bit input: Reset input for ALUMODEREG
         .RSTB ( 1'b0),                     //-- 1-bit input: Reset input for BREG
         .RSTC ( 1'b0),                     //-- 1-bit input: Reset input for CREG
         .RSTCTRL ( 1'b0),               //-- 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
         .RSTD ( 1'b0),                    // -- 1-bit input: Reset input for DREG and ADREG
         .RSTM ( 1'b0),                    // -- 1-bit input: Reset input for MREG
         .RSTP ( 1'b0)                      //-- 1-bit input: Reset input for PREG
      );    
    
// The Fifth DSP48E1  
          DSP48E1 #(
       //      -- Feature Control Attributes: Data Path Selection
             .A_INPUT("DIRECT"),               //-- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
             .B_INPUT("DIRECT"),               //-- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
             .USE_DPORT("FALSE"),                //-- Select D port usage (TRUE or FALSE)
             .USE_MULT("MULTIPLY"),            //-- Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
             .USE_SIMD("ONE48"),               //-- SIMD selection ("ONE48", "TWO24", "FOUR12")
       //      -- Pattern Detector Attributes: Pattern Detection Configuration
             .AUTORESET_PATDET("NO_RESET"),    //-- "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
             .MASK(48'h3fffffffffff),           //-- 48-bit mask value for pattern detect (1=ignore)
             .PATTERN(48'h000000000000),        //-- 48-bit pattern match for pattern detect
             .SEL_MASK("MASK"),                //-- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
             .SEL_PATTERN("PATTERN"),          //-- Select pattern value ("PATTERN" or "C")
             .USE_PATTERN_DETECT("NO_PATDET"), //-- Enable pattern detect ("PATDET" or "NO_PATDET")
        //     -- Register Control Attributes: Pipeline Register Configuration
             .ACASCREG(1'b1),                     //-- Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
             .ADREG(0),                        //-- Number of pipeline stages for pre-adder (0 or 1)
             .ALUMODEREG ( 1'b1),                   //-- Number of pipeline stages for ALUMODE (0 or 1)
             .AREG ( 1'b1),                         //-- Number of pipeline stages for A (0, 1 or 2)
             .BCASCREG ( 1'b1),                     //-- Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
             .BREG ( 1'b1),                         //-- Number of pipeline stages for B (0, 1 or 2)
             .CARRYINREG ( 1'b1),                   //-- Number of pipeline stages for CARRYIN (0 or 1)
             .CARRYINSELREG ( 1'b1),                //-- Number of pipeline stages for CARRYINSEL (0 or 1)
             .CREG ( 1'b0),                         //-- Number of pipeline stages for C (0 or 1)
             .DREG ( 1'b0),                         //-- Number of pipeline stages for D (0 or 1)
             .INMODEREG ( 1'b1),                    //-- Number of pipeline stages for INMODE (0 or 1)
             .MREG ( 1'b1),                         //-- Number of multiplier pipeline stages (0 or 1)
             .OPMODEREG ( 1'b1),                    //-- Number of pipeline stages for OPMODE (0 or 1)
             .PREG ( 1'b1)                          //-- Number of pipeline stages for P (0 or 1)
          ) mult_g2(
         //    -- Cascade: 30-bit (each) output: Cascade Ports
             .ACOUT        ( ),    //-- 30-bit output: A port cascade output
             .BCOUT        ( ),    //-- 18-bit output: B port cascade output
             .CARRYCASCOUT ( ),    //-- 1-bit output: Cascade carry output
             .MULTSIGNOUT  ( ),    //-- 1-bit output: Multiplier sign cascade output
             .PCOUT        ( pc_g2),   //-- 48-bit output: Cascade output
         //    -- Control: 1-bit (each) output: Control Inputs/Status Bits
             .OVERFLOW       ( ),  //-- 1-bit output: Overflow in add/acc output
             .PATTERNBDETECT ( ),  //-- 1-bit output: Pattern bar detect output
             .PATTERNDETECT  ( ),  //-- 1-bit output: Pattern detect output
             .UNDERFLOW      ( ),  //-- 1-bit output: Underflow in add/acc output
         //    -- Data: 4-bit (each) output: Data Ports
             .CARRYOUT       ( ),  //-- 4-bit output: Carry output
             .P              ( ),  //-- 48-bit output: Primary data output
        //     -- Cascade: 30-bit (each) input: Cascade Ports
             .ACIN        ( 30'd0), //-- 30-bit input: A cascade data input
             .BCIN        ( 18'd0), //-- 18-bit input: B cascade input
             .CARRYCASCIN ( 1'b0),             //-- 1-bit input: Cascade carry input
             .MULTSIGNIN  ( 1'b0),             //-- 1-bit input: Multiplier sign input
             .PCIN        ( pc_r2), //-- 48-bit input: P cascade input
         //    -- Control: 4-bit (each) input: Control Inputs/Status Bits
             .CLK        ( clk),        //-- 1-bit input: Clock input
             .ALUMODE    ( 4'b0000),     //-- 4-bit input: ALU control input
             .CARRYINSEL ( 3'b000),      //-- 3-bit input: Carry select input
             .CEINMODE   ( 1'b1),        //-- 1-bit input: Clock enable input for INMODEREG
             .INMODE     ( 5'b00000),    //-- 5-bit input: INMODE control input
             .OPMODE     ( 7'b0010101),  //-- 7-bit input: Operation mode input
             .RSTINMODE  ( 1'b0),           //-- 1-bit input: Reset input for INMODEREG
        //     -- Data: 30-bit (each) input: Data Ports
             .A ( a_g2),      //-- 30-bit input: A data input
             .B ( b_g2),                       // -- 18-bit input: B data input
             .C ( 48'd0),              //-- 48-bit input: C data input
             .CARRYIN ( 1'b0),                   //-- 1-bit input: Carry input signal
             .D ( 25'd0),              //-- 25-bit input: D data input
       //      -- Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
             .CEA1 ( 1'b0),                   //  -- 1-bit input: Clock enable input for 1st stage AREG
             .CEA2 ( 1'b1),                   //  -- 1-bit input: Clock enable input for 2nd stage AREG
             .CEAD ( 1'b0),                   //  -- 1-bit input: Clock enable input for ADREG
             .CEALUMODE ( 1'b1),           //-- 1-bit input: Clock enable input for ALUMODE
             .CEB1 ( 1'b0),                    // -- 1-bit input: Clock enable input for 1st stage BREG
             .CEB2 ( 1'b1),                    // -- 1-bit input: Clock enable input for 2nd stage BREG
             .CEC ( 1'b0),                     //  -- 1-bit input: Clock enable input for CREG
             .CECARRYIN ( 1'b1),          // -- 1-bit input: Clock enable input for CARRYINREG
             .CECTRL ( 1'b1),                 //-- 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
             .CED ( 1'b0),                      // -- 1-bit input: Clock enable input for DREG
             .CEM ( 1'b1),                      // -- 1-bit input: Clock enable input for MREG
             .CEP ( 1'b1),                      // -- 1-bit input: Clock enable input for PREG
             .RSTA ( 1'b0),                    // -- 1-bit input: Reset input for AREG
             .RSTALLCARRYIN ( 1'b0),   //-- 1-bit input: Reset input for CARRYINREG
             .RSTALUMODE ( 1'b0),        // -- 1-bit input: Reset input for ALUMODEREG
             .RSTB ( 1'b0),                     //-- 1-bit input: Reset input for BREG
             .RSTC ( 1'b0),                     //-- 1-bit input: Reset input for CREG
             .RSTCTRL ( 1'b0),               //-- 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
             .RSTD ( 1'b0),                    // -- 1-bit input: Reset input for DREG and ADREG
             .RSTM ( 1'b0),                    // -- 1-bit input: Reset input for MREG
             .RSTP ( 1'b0)                      //-- 1-bit input: Reset input for PREG
          );   
          
// The sixth DSP48E1         
     DSP48E1 #(
           //      -- Feature Control Attributes: Data Path Selection
                 .A_INPUT("DIRECT"),               //-- Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
                 .B_INPUT("DIRECT"),               //-- Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
                 .USE_DPORT("FALSE"),                //-- Select D port usage (TRUE or FALSE)
                 .USE_MULT("MULTIPLY"),            //-- Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
                 .USE_SIMD("ONE48"),               //-- SIMD selection ("ONE48", "TWO24", "FOUR12")
           //      -- Pattern Detector Attributes: Pattern Detection Configuration
                 .AUTORESET_PATDET("NO_RESET"),    //-- "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH" 
                 .MASK(48'h3fffffffffff),           //-- 48-bit mask value for pattern detect (1=ignore)
                 .PATTERN(48'h000000000000),        //-- 48-bit pattern match for pattern detect
                 .SEL_MASK("MASK"),                //-- "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2" 
                 .SEL_PATTERN("PATTERN"),          //-- Select pattern value ("PATTERN" or "C")
                 .USE_PATTERN_DETECT("NO_PATDET"), //-- Enable pattern detect ("PATDET" or "NO_PATDET")
            //     -- Register Control Attributes: Pipeline Register Configuration
                 .ACASCREG(2),                     //-- Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
                 .ADREG(0),                        //-- Number of pipeline stages for pre-adder (0 or 1)
                 .ALUMODEREG (1),                   //-- Number of pipeline stages for ALUMODE (0 or 1)
                 .AREG (2),                         //-- Number of pipeline stages for A (0, 1 or 2)
                 .BCASCREG (2),                     //-- Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
                 .BREG (2),                         //-- Number of pipeline stages for B (0, 1 or 2)
                 .CARRYINREG (1),                   //-- Number of pipeline stages for CARRYIN (0 or 1)
                 .CARRYINSELREG (1),                //-- Number of pipeline stages for CARRYINSEL (0 or 1)
                 .CREG (0),                         //-- Number of pipeline stages for C (0 or 1)
                 .DREG (0),                         //-- Number of pipeline stages for D (0 or 1)
                 .INMODEREG (1),                    //-- Number of pipeline stages for INMODE (0 or 1)
                 .MREG (1),                         //-- Number of multiplier pipeline stages (0 or 1)
                 .OPMODEREG (1),                    //-- Number of pipeline stages for OPMODE (0 or 1)
                 .PREG (1)                          //-- Number of pipeline stages for P (0 or 1)
              ) mult_b2(
             //    -- Cascade: 30-bit (each) output: Cascade Ports
                 .ACOUT        ( ),    //-- 30-bit output: A port cascade output
                 .BCOUT        ( ),    //-- 18-bit output: B port cascade output
                 .CARRYCASCOUT ( ),    //-- 1-bit output: Cascade carry output
                 .MULTSIGNOUT  ( ),    //-- 1-bit output: Multiplier sign cascade output
                 .PCOUT        ( ),   //-- 48-bit output: Cascade output
             //    -- Control: 1-bit (each) output: Control Inputs/Status Bits
                 .OVERFLOW       ( ),  //-- 1-bit output: Overflow in add/acc output
                 .PATTERNBDETECT ( ),  //-- 1-bit output: Pattern bar detect output
                 .PATTERNDETECT  ( ),  //-- 1-bit output: Pattern detect output
                 .UNDERFLOW      ( ),  //-- 1-bit output: Underflow in add/acc output
             //    -- Data: 4-bit (each) output: Data Ports
                 .CARRYOUT       ( ),  //-- 4-bit output: Carry output
                 .P              (p_b2),  //-- 48-bit output: Primary data output
            //     -- Cascade: 30-bit (each) input: Cascade Ports
                 .ACIN        ( 30'd0), //-- 30-bit input: A cascade data input
                 .BCIN        ( 18'd0), //-- 18-bit input: B cascade input
                 .CARRYCASCIN ( 1'b0),             //-- 1-bit input: Cascade carry input
                 .MULTSIGNIN  ( 1'b0),             //-- 1-bit input: Multiplier sign input
                 .PCIN        ( pc_g2), //-- 48-bit input: P cascade input
             //    -- Control: 4-bit (each) input: Control Inputs/Status Bits
                 .CLK        ( clk),        //-- 1-bit input: Clock input
                 .ALUMODE    ( 4'b0000),     //-- 4-bit input: ALU control input
                 .CARRYINSEL ( 3'b000),      //-- 3-bit input: Carry select input
                 .CEINMODE   ( 1'b1),        //-- 1-bit input: Clock enable input for INMODEREG
                 .INMODE     ( 5'b00000),    //-- 5-bit input: INMODE control input
                 .OPMODE     ( 7'b0010101),  //-- 7-bit input: Operation mode input
                 .RSTINMODE  ( 1'b0),           //-- 1-bit input: Reset input for INMODEREG
            //     -- Data: 30-bit (each) input: Data Ports
                 .A ( a_b2),      //-- 30-bit input: A data input
                 .B ( b_b2),                       // -- 18-bit input: B data input
                 .C (48'b0),              //-- 48-bit input: C data input
                 .CARRYIN ( 1'b0),                   //-- 1-bit input: Carry input signal
                 .D ( 25'b0),              //-- 25-bit input: D data input
           //      -- Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
                 .CEA1 ( 1'b1),                   //  -- 1-bit input: Clock enable input for 1st stage AREG
                 .CEA2 ( 1'b1),                   //  -- 1-bit input: Clock enable input for 2nd stage AREG
                 .CEAD ( 1'b0),                   //  -- 1-bit input: Clock enable input for ADREG
                 .CEALUMODE ( 1'b1),           //-- 1-bit input: Clock enable input for ALUMODE
                 .CEB1 ( 1'b1),                    // -- 1-bit input: Clock enable input for 1st stage BREG
                 .CEB2 ( 1'b1),                    // -- 1-bit input: Clock enable input for 2nd stage BREG
                 .CEC ( 1'b0),                     //  -- 1-bit input: Clock enable input for CREG
                 .CECARRYIN ( 1'b1),          // -- 1-bit input: Clock enable input for CARRYINREG
                 .CECTRL ( 1'b1),                 //-- 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
                 .CED ( 1'b0),                      // -- 1-bit input: Clock enable input for DREG
                 .CEM ( 1'b1),                      // -- 1-bit input: Clock enable input for MREG
                 .CEP ( 1'b1),                      // -- 1-bit input: Clock enable input for PREG
                 .RSTA ( 1'b0),                    // -- 1-bit input: Reset input for AREG
                 .RSTALLCARRYIN ( 1'b0),   //-- 1-bit input: Reset input for CARRYINREG
                 .RSTALUMODE ( 1'b0),        // -- 1-bit input: Reset input for ALUMODEREG
                 .RSTB ( 1'b0),                     //-- 1-bit input: Reset input for BREG
                 .RSTC ( 1'b0),                     //-- 1-bit input: Reset input for CREG
                 .RSTCTRL ( 1'b0),               //-- 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
                 .RSTD ( 1'b0),                    // -- 1-bit input: Reset input for DREG and ADREG
                 .RSTM ( 1'b0),                    // -- 1-bit input: Reset input for MREG
                 .RSTP ( 1'b0)                      //-- 1-bit input: Reset input for PREG
              );   
endmodule
