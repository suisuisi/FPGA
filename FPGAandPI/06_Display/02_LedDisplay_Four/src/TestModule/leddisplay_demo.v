//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 01:42:42
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-06 15:49:11
//# Description: 
//# @Modification History: 2019-05-19 01:52:19
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 01:52:19
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
`timescale 1ns/ 1ns
module leddisplay_demo
(
    input CLOCK, RST_n,
	 output MAX7219_CS, MAX7219_SCLK, 
	 output MAX7219_DATA
);
//****************************************************************************//
//   取模数据
//****************************************************************************//
parameter   data_0 = {8'h3C,8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h3C},//0 
			data_1 = {8'h10,8'h18,8'h14,8'h10,8'h10,8'h10,8'h10,8'h10},//1
	 		data_2 = {8'h7E,8'h02,8'h02,8'h7E,8'h40,8'h40,8'h40,8'h7E},//2
	 		data_3 = {8'h3E,8'h02,8'h02,8'h3E,8'h02,8'h02,8'h3E,8'h00},//3
	 		data_4 =     {8'h8,8'h18,8'h28,8'h48,8'hFE,8'h8,8'h8,8'h8},//4 
	 		data_5 =    {8'h3C,8'h20,8'h20,8'h3C,8'h4,8'h4,8'h3C,8'h0},//5 
			data_6 =  {8'h3C,8'h20,8'h20,8'h3C,8'h24,8'h24,8'h3C,8'h0},//6 
			data_7 =       {8'h3E,8'h22,8'h4,8'h8,8'h8,8'h8,8'h8,8'h8},//7 
			data_8 =  {8'h0,8'h3E,8'h22,8'h22,8'h3E,8'h22,8'h22,8'h3E},//8
			data_9 =    {8'h3E,8'h22,8'h22,8'h3E,8'h2,8'h2,8'h2,8'h3E},//9 
			data_A =  {8'h8,8'h14,8'h22,8'h3E,8'h22,8'h22,8'h22,8'h22},//A
			data_B =  {8'h3C,8'h22,8'h22,8'h3E,8'h22,8'h22,8'h3C,8'h0},//B
			data_C =  {8'h3C,8'h40,8'h40,8'h40,8'h40,8'h40,8'h3C,8'h0},//C
			data_D =  {8'h7C,8'h42,8'h42,8'h42,8'h42,8'h42,8'h7C,8'h0},//D
			data_E = {8'h7C,8'h40,8'h40,8'h7C,8'h40,8'h40,8'h40,8'h7C},//E
			data_F = {8'h7C,8'h40,8'h40,8'h7C,8'h40,8'h40,8'h40,8'h40},//F
			data_G = {8'h3C,8'h40,8'h40,8'h40,8'h40,8'h44,8'h44,8'h3C},//G
			data_H = {8'h44,8'h44,8'h44,8'h7C,8'h44,8'h44,8'h44,8'h44},//H
			data_I = {8'h7C,8'h10,8'h10,8'h10,8'h10,8'h10,8'h10,8'h7C},//I
			data_J =      {8'h3C,8'h8,8'h8,8'h8,8'h8,8'h8,8'h48,8'h30},//J
			data_K =  {8'h0,8'h24,8'h28,8'h30,8'h20,8'h30,8'h28,8'h24},//K
			data_L = {8'h40,8'h40,8'h40,8'h40,8'h40,8'h40,8'h40,8'h7C},//L
			data_M = {8'h81,8'hC3,8'hA5,8'h99,8'h81,8'h81,8'h81,8'h81},//M
			data_N =  {8'h0,8'h42,8'h62,8'h52,8'h4A,8'h46,8'h42,8'h00},//N
			data_O = {8'h3C,8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h3C},//O
			data_P = {8'h3C,8'h22,8'h22,8'h22,8'h3C,8'h20,8'h20,8'h20},//P
			data_Q = {8'h1C,8'h22,8'h22,8'h22,8'h22,8'h26,8'h22,8'h1D},//Q
			data_R = {8'h3C,8'h22,8'h22,8'h22,8'h3C,8'h24,8'h22,8'h21},//R
			data_S =    {8'h0,8'h1E,8'h20,8'h20,8'h3E,8'h2,8'h2,8'h3C},//S
			data_T =        {8'h0,8'h3E,8'h8,8'h8,8'h8,8'h8,8'h8,8'h8},//T
			data_U = {8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h22,8'h1C},//U
			data_V = {8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h24,8'h18},//V
			data_W =   {8'h0,8'h49,8'h49,8'h49,8'h49,8'h2A,8'h1C,8'h0},//W
			data_X =   {8'h0,8'h41,8'h22,8'h14,8'h8,8'h14,8'h22,8'h41},//X
			data_Y =      {8'h41,8'h22,8'h14,8'h8,8'h8,8'h8,8'h8,8'h8},//Y
			data_Z =     {8'h0,8'h7F,8'h2,8'h4,8'h8,8'h10,8'h20,8'h7F},//Z
			data_zhong = {8'h8,8'h7F,8'h49,8'h49,8'h7F,8'h8,8'h8,8'h8},//中
			data_guo = {8'hFE,8'hBA,8'h92,8'hBA,8'h92,8'h9A,8'hBA,8'hFE};//国
	parameter Time_1s = 26'd5000_0000;
	wire DoneU1;	 
	reg isCall;
	reg [63:0]D1,D2,D3,D4;

max7219_basemod U1
    (
      .CLOCK( CLOCK ), 
	   .RST_n( RST_n ),
		.MAX7219_CS( MAX7219_CS ),   // > top
		.MAX7219_SCLK( MAX7219_SCLK ),         // > top
		.MAX7219_DATA( MAX7219_DATA ),         // <> top
	   .iCall( 1'b1 ),//isCall
	   .oDone( DoneU1 ),
	   .iData1( {8'h3C,8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h3C} ),//data_OD1
	   .iData2( {8'h10,8'h18,8'h14,8'h10,8'h10,8'h10,8'h10,8'h10} ),
	   .iData3( {8'h7E,8'h02,8'h02,8'h7E,8'h40,8'h40,8'h40,8'h7E} ),
	   .iData4( {8'h3E,8'h02,8'h02,8'h3E,8'h02,8'h02,8'h3E,8'h00} )
    );

wire clock_div_1s;
clock_div //BPS 
#(//DEVICE_CNT = 85.89934592 * fo    for 50Mhz
//	parameter		DEVICE_CNT = 32'd43	//0.5Hz   
	.DEVICE_CNT(32'd86)    // 1Hz
//	parameter		DEVICE_CNT = 32'd172	//2Hz
)
U2_clock_div
(
	   .CLOCK( CLOCK ),
		.RST_n( RST_n ),
		.En_Sig( 1'b1 ),    // 
		.clock_div_1s( clock_div_1s ) // output - to top
);
   reg [3:0]i;

	//reg [5:0]D1;

//	reg [25:0]C1;
	
	/*always @ ( posedge clock_div_1s or negedge RST_n )
	    if( !RST_n )
		     begin
			      i <= 4'd0;
			      isCall <= 1'b0;
				  {D1,D2,D3,D4} <= {64'd1,64'd1,64'd1,64'd1};
			  end
		 else 
		     case( i )
			      0:
					//if( DoneU1 ) begin
					   // isCall <= 1'b0; i <= i + 1'b1;end
						 //else
					begin isCall <= 1'b1;D1 <= data_L; D2 <= data_P;D3 <= data_L;D4 <= data_K; i <= i + 1'b1; end
											      	
					/*1:
					//if( DoneU1 ) begin 
					//    isCall <= 1'b0; i <= i + 1'b1; end
					begin isCall <= 1'b1;D1 <= data_O; D2 <= data_P;D3 <= data_G;D4 <= data_N; i <= i + 1'b1; end
						
					
					2:
					//if( DoneU1 ) begin 
					 //   isCall <= 1'b0; i <= i + 1'b1; end
				   begin isCall <= 1'b1;D1 <= data_O; D2 <= data_P;D3 <= data_G;D4 <= data_N; i <= i + 1'b1; end
					
					3:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1;D1 <= data_O; D2 <= data_P;D3 <= data_G;D4 <= data_N; i <= i + 1'b1; end
					
									
					/*4:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1;i <= i + 1'b1;D1 <= data_F;  end
						 
					
					5:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1; i <= i + 1'b1;D1 <= data_P; end
					
					6:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1; i <= i + 1'b1;D1 <= data_G; end
					
					7:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1;i <= i + 1'b1;D1 <= data_A;  end

					1:
					i <= 4'd0;
					
					default:
					 i <= i;
					
			  endcase*/

endmodule
