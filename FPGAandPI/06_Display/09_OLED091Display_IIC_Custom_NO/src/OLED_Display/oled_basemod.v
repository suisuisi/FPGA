module oled_basemod
(
    input CLOCK, RST_n,
	 output OLED_SCL,
	 inout OLED_SDA
	 //input [7:0]iCall,
	 //output oDone,
	 //input [7:0]iData,
	 //output [7:0]oData
);

//常用ASCII表
//偏移量32
//ASCII字符集
//偏移量32
//大小:12*6
/************************************6*8的点阵************************************/

parameter data_sp = {8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00};// sp
parameter data_00 = {8'h00, 8'h00, 8'h00, 8'h2f, 8'h00, 8'h00};// !
parameter data_01 = {8'h00, 8'h00, 8'h07, 8'h00, 8'h07, 8'h00};// "
parameter data_02 = {8'h00, 8'h14, 8'h7f, 8'h14, 8'h7f, 8'h14};// #
parameter data_03 = {8'h00, 8'h24, 8'h2a, 8'h7f, 8'h2a, 8'h12};// $
parameter data_04 = {8'h00, 8'h62, 8'h64, 8'h08, 8'h13, 8'h23};// %
parameter data_05 = {8'h00, 8'h36, 8'h49, 8'h55, 8'h22, 8'h50};// &
parameter data_06 = {8'h00, 8'h00, 8'h05, 8'h03, 8'h00, 8'h00};// '
parameter data_07 = {8'h00, 8'h00, 8'h1c, 8'h22, 8'h41, 8'h00};// (
parameter data_08 = {8'h00, 8'h00, 8'h41, 8'h22, 8'h1c, 8'h00};// )
parameter data_09 = {8'h00, 8'h14, 8'h08, 8'h3E, 8'h08, 8'h14};// *
parameter data_10 = {8'h00, 8'h08, 8'h08, 8'h3E, 8'h08, 8'h08};// +
parameter data_11 = {8'h00, 8'h00, 8'h00, 8'hA0, 8'h60, 8'h00};// ,
parameter data_12 = {8'h00, 8'h08, 8'h08, 8'h08, 8'h08, 8'h08};// -
parameter data_13 = {8'h00, 8'h00, 8'h60, 8'h60, 8'h00, 8'h00};// .
parameter data_14 = {8'h00, 8'h20, 8'h10, 8'h08, 8'h04, 8'h02};// /
parameter data_0 = {8'h00, 8'h3E, 8'h51, 8'h49, 8'h45, 8'h3E};// 0
parameter data_1 = {8'h00, 8'h00, 8'h42, 8'h7F, 8'h40, 8'h00};// 1
parameter data_2 = {8'h00, 8'h42, 8'h61, 8'h51, 8'h49, 8'h46};// 2
parameter data_3 = {8'h00, 8'h21, 8'h41, 8'h45, 8'h4B, 8'h31};// 3
parameter data_4 = {8'h00, 8'h18, 8'h14, 8'h12, 8'h7F, 8'h10};// 4
parameter data_5 = {8'h00, 8'h27, 8'h45, 8'h45, 8'h45, 8'h39};// 5
parameter data_6 = {8'h00, 8'h3C, 8'h4A, 8'h49, 8'h49, 8'h30};// 6
parameter data_7 = {8'h00, 8'h01, 8'h71, 8'h09, 8'h05, 8'h03};// 7
parameter data_8 = {8'h00, 8'h36, 8'h49, 8'h49, 8'h49, 8'h36};// 8
parameter data_9 = {8'h00, 8'h06, 8'h49, 8'h49, 8'h29, 8'h1E};// 9
parameter data_15 = {8'h00, 8'h00, 8'h36, 8'h36, 8'h00, 8'h00};// :
parameter data_16 = {8'h00, 8'h00, 8'h56, 8'h36, 8'h00, 8'h00};// ;
parameter data_17 = {8'h00, 8'h08, 8'h14, 8'h22, 8'h41, 8'h00};// <
parameter data_18 = {8'h00, 8'h14, 8'h14, 8'h14, 8'h14, 8'h14};// =
parameter data_19 = {8'h00, 8'h00, 8'h41, 8'h22, 8'h14, 8'h08};// >
parameter data_20 = {8'h00, 8'h02, 8'h01, 8'h51, 8'h09, 8'h06};// ?
parameter data_21 = {8'h00, 8'h32, 8'h49, 8'h59, 8'h51, 8'h3E};// @
parameter data_A = {8'h00, 8'h7C, 8'h12, 8'h11, 8'h12, 8'h7C};// A
parameter data_B = {8'h00, 8'h7F, 8'h49, 8'h49, 8'h49, 8'h36};// B
parameter data_C = {8'h00, 8'h3E, 8'h41, 8'h41, 8'h41, 8'h22};// C
parameter data_D = {8'h00, 8'h7F, 8'h41, 8'h41, 8'h22, 8'h1C};// D
parameter data_E = {8'h00, 8'h7F, 8'h49, 8'h49, 8'h49, 8'h41};// E
parameter data_F = {8'h00, 8'h7F, 8'h09, 8'h09, 8'h09, 8'h01};// F
parameter data_G = {8'h00, 8'h3E, 8'h41, 8'h49, 8'h49, 8'h7A};// G
parameter data_H = {8'h00, 8'h7F, 8'h08, 8'h08, 8'h08, 8'h7F};// H
parameter data_I = {8'h00, 8'h00, 8'h41, 8'h7F, 8'h41, 8'h00};// I
parameter data_J = {8'h00, 8'h20, 8'h40, 8'h41, 8'h3F, 8'h01};// J
parameter data_K = {8'h00, 8'h7F, 8'h08, 8'h14, 8'h22, 8'h41};// K
parameter data_L = {8'h00, 8'h7F, 8'h40, 8'h40, 8'h40, 8'h40};// L
parameter data_M = {8'h00, 8'h7F, 8'h02, 8'h0C, 8'h02, 8'h7F};// M
parameter data_N = {8'h00, 8'h7F, 8'h04, 8'h08, 8'h10, 8'h7F};// N
parameter data_O = {8'h00, 8'h3E, 8'h41, 8'h41, 8'h41, 8'h3E};// O
parameter data_P = {8'h00, 8'h7F, 8'h09, 8'h09, 8'h09, 8'h06};// P
parameter data_Q = {8'h00, 8'h3E, 8'h41, 8'h51, 8'h21, 8'h5E};// Q
parameter data_R = {8'h00, 8'h7F, 8'h09, 8'h19, 8'h29, 8'h46};// R
parameter data_S = {8'h00, 8'h46, 8'h49, 8'h49, 8'h49, 8'h31};// S
parameter data_T = {8'h00, 8'h01, 8'h01, 8'h7F, 8'h01, 8'h01};// T
parameter data_U = {8'h00, 8'h3F, 8'h40, 8'h40, 8'h40, 8'h3F};// U
parameter data_V = {8'h00, 8'h1F, 8'h20, 8'h40, 8'h20, 8'h1F};// V
parameter data_W = {8'h00, 8'h3F, 8'h40, 8'h38, 8'h40, 8'h3F};// W
parameter data_X = {8'h00, 8'h63, 8'h14, 8'h08, 8'h14, 8'h63};// X
parameter data_Y = {8'h00, 8'h07, 8'h08, 8'h70, 8'h08, 8'h07};// Y
parameter data_Z = {8'h00, 8'h61, 8'h51, 8'h49, 8'h45, 8'h43};// Z
parameter data_22 = {8'h00, 8'h00, 8'h7F, 8'h41, 8'h41, 8'h00};// [
parameter data_55 = {8'h00, 8'h55, 8'h2A, 8'h55, 8'h2A, 8'h55};// 55
parameter data_23 = {8'h00, 8'h00, 8'h41, 8'h41, 8'h7F, 8'h00};// ]
parameter data_24 = {8'h00, 8'h04, 8'h02, 8'h01, 8'h02, 8'h04};// ^
parameter data_25 = {8'h00, 8'h40, 8'h40, 8'h40, 8'h40, 8'h40};// _
parameter data_26 = {8'h00, 8'h00, 8'h01, 8'h02, 8'h04, 8'h00};// '
parameter data_1a = {8'h00, 8'h20, 8'h54, 8'h54, 8'h54, 8'h78};// a
parameter data_1b = {8'h00, 8'h7F, 8'h48, 8'h44, 8'h44, 8'h38};// b
parameter data_1c = {8'h00, 8'h38, 8'h44, 8'h44, 8'h44, 8'h20};// c
parameter data_1d = {8'h00, 8'h38, 8'h44, 8'h44, 8'h48, 8'h7F};// d
parameter data_1e = {8'h00, 8'h38, 8'h54, 8'h54, 8'h54, 8'h18};// e
parameter data_1f = {8'h00, 8'h08, 8'h7E, 8'h09, 8'h01, 8'h02};// f
parameter data_1g = {8'h00, 8'h18, 8'hA4, 8'hA4, 8'hA4, 8'h7C};// g
parameter data_1h = {8'h00, 8'h7F, 8'h08, 8'h04, 8'h04, 8'h78};// h
parameter data_1i = {8'h00, 8'h00, 8'h44, 8'h7D, 8'h40, 8'h00};// i
parameter data_1j = {8'h00, 8'h40, 8'h80, 8'h84, 8'h7D, 8'h00};// j
parameter data_1k = {8'h00, 8'h7F, 8'h10, 8'h28, 8'h44, 8'h00};// k
parameter data_1l = {8'h00, 8'h00, 8'h41, 8'h7F, 8'h40, 8'h00};// l
parameter data_1m = {8'h00, 8'h7C, 8'h04, 8'h18, 8'h04, 8'h78};// m
parameter data_1n = {8'h00, 8'h7C, 8'h08, 8'h04, 8'h04, 8'h78};// n
parameter data_1o = {8'h00, 8'h38, 8'h44, 8'h44, 8'h44, 8'h38};// o
parameter data_1p = {8'h00, 8'hFC, 8'h24, 8'h24, 8'h24, 8'h18};// p
parameter data_1q = {8'h00, 8'h18, 8'h24, 8'h24, 8'h18, 8'hFC};// q
parameter data_1r = {8'h00, 8'h7C, 8'h08, 8'h04, 8'h04, 8'h08};// r
parameter data_1s = {8'h00, 8'h48, 8'h54, 8'h54, 8'h54, 8'h20};// s
parameter data_1t = {8'h00, 8'h04, 8'h3F, 8'h44, 8'h40, 8'h20};// t
parameter data_1u = {8'h00, 8'h3C, 8'h40, 8'h40, 8'h20, 8'h7C};// u
parameter data_1v = {8'h00, 8'h1C, 8'h20, 8'h40, 8'h20, 8'h1C};// v
parameter data_1w = {8'h00, 8'h3C, 8'h40, 8'h30, 8'h40, 8'h3C};// w
parameter data_1x = {8'h00, 8'h44, 8'h28, 8'h10, 8'h28, 8'h44};// x
parameter data_1y = {8'h00, 8'h1C, 8'hA0, 8'hA0, 8'hA0, 8'h7C};// y
parameter data_1z = {8'h00, 8'h44, 8'h64, 8'h54, 8'h4C, 8'h44};// z
parameter data_horizlines = {8'h14, 8'h14, 8'h14, 8'h14, 8'h14, 8'h14};// horiz lines

/****************************************8*16的点阵************************************/
parameter data_F8X16_1= {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};// 0
parameter data_F8X16_2= {8'h00,8'h00,8'h00,8'hF8,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h33,8'h30,8'h00,8'h00,8'h00};//! 1
parameter data_F8X16_3= {8'h00,8'h10,8'h0C,8'h06,8'h10,8'h0C,8'h06,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};//" 2
parameter data_F8X16_4= {8'h40,8'hC0,8'h78,8'h40,8'hC0,8'h78,8'h40,8'h00,8'h04,8'h3F,8'h04,8'h04,8'h3F,8'h04,8'h04,8'h00};//# 3
parameter data_F8X16_5= {8'h00,8'h70,8'h88,8'hFC,8'h08,8'h30,8'h00,8'h00,8'h00,8'h18,8'h20,8'hFF,8'h21,8'h1E,8'h00,8'h00};//$ 4
parameter data_F8X16_6= {8'hF0,8'h08,8'hF0,8'h00,8'hE0,8'h18,8'h00,8'h00,8'h00,8'h21,8'h1C,8'h03,8'h1E,8'h21,8'h1E,8'h00};//% 5
parameter data_F8X16_7= {8'h00,8'hF0,8'h08,8'h88,8'h70,8'h00,8'h00,8'h00,8'h1E,8'h21,8'h23,8'h24,8'h19,8'h27,8'h21,8'h10};//& 6
parameter data_F8X16_8= {8'h10,8'h16,8'h0E,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};//' 7
parameter data_F8X16_9= {8'h00,8'h00,8'h00,8'hE0,8'h18,8'h04,8'h02,8'h00,8'h00,8'h00,8'h00,8'h07,8'h18,8'h20,8'h40,8'h00};//( 8
parameter data_F8X16_10= {8'h00,8'h02,8'h04,8'h18,8'hE0,8'h00,8'h00,8'h00,8'h00,8'h40,8'h20,8'h18,8'h07,8'h00,8'h00,8'h00};//) 9
parameter data_F8X16_11 = {8'h40,8'h40,8'h80,8'hF0,8'h80,8'h40,8'h40,8'h00,8'h02,8'h02,8'h01,8'h0F,8'h01,8'h02,8'h02,8'h00};//* 10
parameter data_F8X16_12 = {8'h00,8'h00,8'h00,8'hF0,8'h00,8'h00,8'h00,8'h00,8'h01,8'h01,8'h01,8'h1F,8'h01,8'h01,8'h01,8'h00};//+ 11
parameter data_F8X16_13 = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h80,8'hB0,8'h70,8'h00,8'h00,8'h00,8'h00,8'h00};//, 12
parameter data_F8X16_14 = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01,8'h01};//- 13
parameter data_F8X16_15 = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h30,8'h30,8'h00,8'h00,8'h00,8'h00,8'h00};//. 14
parameter data_F8X16_16 = {8'h00,8'h00,8'h00,8'h00,8'h80,8'h60,8'h18,8'h04,8'h00,8'h60,8'h18,8'h06,8'h01,8'h00,8'h00,8'h00};/// 15
parameter data_F8X16_17 = {8'h00,8'hE0,8'h10,8'h08,8'h08,8'h10,8'hE0,8'h00,8'h00,8'h0F,8'h10,8'h20,8'h20,8'h10,8'h0F,8'h00};//0 16
parameter data_F8X16_18 = {8'h00,8'h10,8'h10,8'hF8,8'h00,8'h00,8'h00,8'h00,8'h00,8'h20,8'h20,8'h3F,8'h20,8'h20,8'h00,8'h00};//1 17
parameter data_F8X16_19 = {8'h00,8'h70,8'h08,8'h08,8'h08,8'h88,8'h70,8'h00,8'h00,8'h30,8'h28,8'h24,8'h22,8'h21,8'h30,8'h00};//2 18
parameter data_F8X16_20 = {8'h00,8'h30,8'h08,8'h88,8'h88,8'h48,8'h30,8'h00,8'h00,8'h18,8'h20,8'h20,8'h20,8'h11,8'h0E,8'h00};//3 19
parameter data_F8X16_21 = {8'h00,8'h00,8'hC0,8'h20,8'h10,8'hF8,8'h00,8'h00,8'h00,8'h07,8'h04,8'h24,8'h24,8'h3F,8'h24,8'h00};//4 20
parameter data_F8X16_22 = {8'h00,8'hF8,8'h08,8'h88,8'h88,8'h08,8'h08,8'h00,8'h00,8'h19,8'h21,8'h20,8'h20,8'h11,8'h0E,8'h00};//5 21
parameter data_F8X16_23 = {8'h00,8'hE0,8'h10,8'h88,8'h88,8'h18,8'h00,8'h00,8'h00,8'h0F,8'h11,8'h20,8'h20,8'h11,8'h0E,8'h00};//6 22
parameter data_F8X16_24 = {8'h00,8'h38,8'h08,8'h08,8'hC8,8'h38,8'h08,8'h00,8'h00,8'h00,8'h00,8'h3F,8'h00,8'h00,8'h00,8'h00};//7 23
parameter data_F8X16_25 = {8'h00,8'h70,8'h88,8'h08,8'h08,8'h88,8'h70,8'h00,8'h00,8'h1C,8'h22,8'h21,8'h21,8'h22,8'h1C,8'h00};//8 24
parameter data_F8X16_26 = {8'h00,8'hE0,8'h10,8'h08,8'h08,8'h10,8'hE0,8'h00,8'h00,8'h00,8'h31,8'h22,8'h22,8'h11,8'h0F,8'h00};//9 25
parameter data_F8X16_27 = {8'h00,8'h00,8'h00,8'hC0,8'hC0,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h30,8'h30,8'h00,8'h00,8'h00};//: 26
parameter data_F8X16_28 = {8'h00,8'h00,8'h00,8'h80,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h80,8'h60,8'h00,8'h00,8'h00,8'h00};//; 27
parameter data_F8X16_29 = {8'h00,8'h00,8'h80,8'h40,8'h20,8'h10,8'h08,8'h00,8'h00,8'h01,8'h02,8'h04,8'h08,8'h10,8'h20,8'h00};//< 28
parameter data_F8X16_30 = {8'h40,8'h40,8'h40,8'h40,8'h40,8'h40,8'h40,8'h00,8'h04,8'h04,8'h04,8'h04,8'h04,8'h04,8'h04,8'h00};//= 29
parameter data_F8X16_31 = {8'h00,8'h08,8'h10,8'h20,8'h40,8'h80,8'h00,8'h00,8'h00,8'h20,8'h10,8'h08,8'h04,8'h02,8'h01,8'h00};//> 30
parameter data_F8X16_32 = {8'h00,8'h70,8'h48,8'h08,8'h08,8'h08,8'hF0,8'h00,8'h00,8'h00,8'h00,8'h30,8'h36,8'h01,8'h00,8'h00};//? 31
parameter data_F8X16_33 = {8'hC0,8'h30,8'hC8,8'h28,8'hE8,8'h10,8'hE0,8'h00,8'h07,8'h18,8'h27,8'h24,8'h23,8'h14,8'h0B,8'h00};//@ 32
parameter data_F8X16_34 = {8'h00,8'h00,8'hC0,8'h38,8'hE0,8'h00,8'h00,8'h00,8'h20,8'h3C,8'h23,8'h02,8'h02,8'h27,8'h38,8'h20};//A 33
parameter data_F8X16_35 = {8'h08,8'hF8,8'h88,8'h88,8'h88,8'h70,8'h00,8'h00,8'h20,8'h3F,8'h20,8'h20,8'h20,8'h11,8'h0E,8'h00};//B 34
parameter data_F8X16_36 = {8'hC0,8'h30,8'h08,8'h08,8'h08,8'h08,8'h38,8'h00,8'h07,8'h18,8'h20,8'h20,8'h20,8'h10,8'h08,8'h00};//C 35
parameter data_F8X16_37 = {8'h08,8'hF8,8'h08,8'h08,8'h08,8'h10,8'hE0,8'h00,8'h20,8'h3F,8'h20,8'h20,8'h20,8'h10,8'h0F,8'h00};//D 36
parameter data_F8X16_38 = {8'h08,8'hF8,8'h88,8'h88,8'hE8,8'h08,8'h10,8'h00,8'h20,8'h3F,8'h20,8'h20,8'h23,8'h20,8'h18,8'h00};//E 37
parameter data_F8X16_39 = {8'h08,8'hF8,8'h88,8'h88,8'hE8,8'h08,8'h10,8'h00,8'h20,8'h3F,8'h20,8'h00,8'h03,8'h00,8'h00,8'h00};//F 38
parameter data_F8X16_40 = {8'hC0,8'h30,8'h08,8'h08,8'h08,8'h38,8'h00,8'h00,8'h07,8'h18,8'h20,8'h20,8'h22,8'h1E,8'h02,8'h00};//G 39
parameter data_F8X16_41 = {8'h08,8'hF8,8'h08,8'h00,8'h00,8'h08,8'hF8,8'h08,8'h20,8'h3F,8'h21,8'h01,8'h01,8'h21,8'h3F,8'h20};//H 40
parameter data_F8X16_42 = {8'h00,8'h08,8'h08,8'hF8,8'h08,8'h08,8'h00,8'h00,8'h00,8'h20,8'h20,8'h3F,8'h20,8'h20,8'h00,8'h00};//I 41
parameter data_F8X16_43 = {8'h00,8'h00,8'h08,8'h08,8'hF8,8'h08,8'h08,8'h00,8'hC0,8'h80,8'h80,8'h80,8'h7F,8'h00,8'h00,8'h00};//J 42
parameter data_F8X16_44 = {8'h08,8'hF8,8'h88,8'hC0,8'h28,8'h18,8'h08,8'h00,8'h20,8'h3F,8'h20,8'h01,8'h26,8'h38,8'h20,8'h00};//K 43
parameter data_F8X16_45 = {8'h08,8'hF8,8'h08,8'h00,8'h00,8'h00,8'h00,8'h00,8'h20,8'h3F,8'h20,8'h20,8'h20,8'h20,8'h30,8'h00};//L 44
parameter data_F8X16_46 = {8'h08,8'hF8,8'hF8,8'h00,8'hF8,8'hF8,8'h08,8'h00,8'h20,8'h3F,8'h00,8'h3F,8'h00,8'h3F,8'h20,8'h00};//M 45
parameter data_F8X16_47 = {8'h08,8'hF8,8'h30,8'hC0,8'h00,8'h08,8'hF8,8'h08,8'h20,8'h3F,8'h20,8'h00,8'h07,8'h18,8'h3F,8'h00};//N 46
parameter data_F8X16_48 = {8'hE0,8'h10,8'h08,8'h08,8'h08,8'h10,8'hE0,8'h00,8'h0F,8'h10,8'h20,8'h20,8'h20,8'h10,8'h0F,8'h00};//O 47
parameter data_F8X16_49 = {8'h08,8'hF8,8'h08,8'h08,8'h08,8'h08,8'hF0,8'h00,8'h20,8'h3F,8'h21,8'h01,8'h01,8'h01,8'h00,8'h00};//P 48
parameter data_F8X16_50 = {8'hE0,8'h10,8'h08,8'h08,8'h08,8'h10,8'hE0,8'h00,8'h0F,8'h18,8'h24,8'h24,8'h38,8'h50,8'h4F,8'h00};//Q 49
parameter data_F8X16_51 = {8'h08,8'hF8,8'h88,8'h88,8'h88,8'h88,8'h70,8'h00,8'h20,8'h3F,8'h20,8'h00,8'h03,8'h0C,8'h30,8'h20};//R 50
parameter data_F8X16_52 = {8'h00,8'h70,8'h88,8'h08,8'h08,8'h08,8'h38,8'h00,8'h00,8'h38,8'h20,8'h21,8'h21,8'h22,8'h1C,8'h00};//S 51
parameter data_F8X16_53 = {8'h18,8'h08,8'h08,8'hF8,8'h08,8'h08,8'h18,8'h00,8'h00,8'h00,8'h20,8'h3F,8'h20,8'h00,8'h00,8'h00};//T 52
parameter data_F8X16_54 = {8'h08,8'hF8,8'h08,8'h00,8'h00,8'h08,8'hF8,8'h08,8'h00,8'h1F,8'h20,8'h20,8'h20,8'h20,8'h1F,8'h00};//U 53
parameter data_F8X16_55 = {8'h08,8'h78,8'h88,8'h00,8'h00,8'hC8,8'h38,8'h08,8'h00,8'h00,8'h07,8'h38,8'h0E,8'h01,8'h00,8'h00};//V 54
parameter data_F8X16_56 = {8'hF8,8'h08,8'h00,8'hF8,8'h00,8'h08,8'hF8,8'h00,8'h03,8'h3C,8'h07,8'h00,8'h07,8'h3C,8'h03,8'h00};//W 55
parameter data_F8X16_57 = {8'h08,8'h18,8'h68,8'h80,8'h80,8'h68,8'h18,8'h08,8'h20,8'h30,8'h2C,8'h03,8'h03,8'h2C,8'h30,8'h20};//X 56
parameter data_F8X16_58 = {8'h08,8'h38,8'hC8,8'h00,8'hC8,8'h38,8'h08,8'h00,8'h00,8'h00,8'h20,8'h3F,8'h20,8'h00,8'h00,8'h00};//Y 57
parameter data_F8X16_59 = {8'h10,8'h08,8'h08,8'h08,8'hC8,8'h38,8'h08,8'h00,8'h20,8'h38,8'h26,8'h21,8'h20,8'h20,8'h18,8'h00};//Z 58
parameter data_F8X16_60 = {8'h00,8'h00,8'h00,8'hFE,8'h02,8'h02,8'h02,8'h00,8'h00,8'h00,8'h00,8'h7F,8'h40,8'h40,8'h40,8'h00};//[ 59
parameter data_F8X16_61 = {8'h00,8'h0C,8'h30,8'hC0,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h01,8'h06,8'h38,8'hC0,8'h00};//\ 60
parameter data_F8X16_62 = {8'h00,8'h02,8'h02,8'h02,8'hFE,8'h00,8'h00,8'h00,8'h00,8'h40,8'h40,8'h40,8'h7F,8'h00,8'h00,8'h00};//] 61
parameter data_F8X16_63 = {8'h00,8'h00,8'h04,8'h02,8'h02,8'h02,8'h04,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};//^ 62
parameter data_F8X16_64 = {8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h80,8'h80,8'h80,8'h80};//_ 63
parameter data_F8X16_65 = {8'h00,8'h02,8'h02,8'h04,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};//` 64
parameter data_F8X16_66 = {8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h00,8'h00,8'h00,8'h19,8'h24,8'h22,8'h22,8'h22,8'h3F,8'h20};//a 65
parameter data_F8X16_67 = {8'h08,8'hF8,8'h00,8'h80,8'h80,8'h00,8'h00,8'h00,8'h00,8'h3F,8'h11,8'h20,8'h20,8'h11,8'h0E,8'h00};//b 66
parameter data_F8X16_68 = {8'h00,8'h00,8'h00,8'h80,8'h80,8'h80,8'h00,8'h00,8'h00,8'h0E,8'h11,8'h20,8'h20,8'h20,8'h11,8'h00};//c 67
parameter data_F8X16_69 = {8'h00,8'h00,8'h00,8'h80,8'h80,8'h88,8'hF8,8'h00,8'h00,8'h0E,8'h11,8'h20,8'h20,8'h10,8'h3F,8'h20};//d 68
parameter data_F8X16_70 = {8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h00,8'h00,8'h00,8'h1F,8'h22,8'h22,8'h22,8'h22,8'h13,8'h00};//e 69
parameter data_F8X16_71 = {8'h00,8'h80,8'h80,8'hF0,8'h88,8'h88,8'h88,8'h18,8'h00,8'h20,8'h20,8'h3F,8'h20,8'h20,8'h00,8'h00};//f 70
parameter data_F8X16_72 = {8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h80,8'h00,8'h00,8'h6B,8'h94,8'h94,8'h94,8'h93,8'h60,8'h00};//g 71
parameter data_F8X16_73 = {8'h08,8'hF8,8'h00,8'h80,8'h80,8'h80,8'h00,8'h00,8'h20,8'h3F,8'h21,8'h00,8'h00,8'h20,8'h3F,8'h20};//h 72
parameter data_F8X16_74 = {8'h00,8'h80,8'h98,8'h98,8'h00,8'h00,8'h00,8'h00,8'h00,8'h20,8'h20,8'h3F,8'h20,8'h20,8'h00,8'h00};//i 73
parameter data_F8X16_75 = {8'h00,8'h00,8'h00,8'h80,8'h98,8'h98,8'h00,8'h00,8'h00,8'hC0,8'h80,8'h80,8'h80,8'h7F,8'h00,8'h00};//j 74
parameter data_F8X16_76 = {8'h08,8'hF8,8'h00,8'h00,8'h80,8'h80,8'h80,8'h00,8'h20,8'h3F,8'h24,8'h02,8'h2D,8'h30,8'h20,8'h00};//k 75
parameter data_F8X16_77 = {8'h00,8'h08,8'h08,8'hF8,8'h00,8'h00,8'h00,8'h00,8'h00,8'h20,8'h20,8'h3F,8'h20,8'h20,8'h00,8'h00};//l 76
parameter data_F8X16_78 = {8'h80,8'h80,8'h80,8'h80,8'h80,8'h80,8'h80,8'h00,8'h20,8'h3F,8'h20,8'h00,8'h3F,8'h20,8'h00,8'h3F};//m 77
parameter data_F8X16_79 = {8'h80,8'h80,8'h00,8'h80,8'h80,8'h80,8'h00,8'h00,8'h20,8'h3F,8'h21,8'h00,8'h00,8'h20,8'h3F,8'h20};//n 78
parameter data_F8X16_80 = {8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h00,8'h00,8'h00,8'h1F,8'h20,8'h20,8'h20,8'h20,8'h1F,8'h00};//o 79
parameter data_F8X16_81 = {8'h80,8'h80,8'h00,8'h80,8'h80,8'h00,8'h00,8'h00,8'h80,8'hFF,8'hA1,8'h20,8'h20,8'h11,8'h0E,8'h00};//p 80
parameter data_F8X16_82 = {8'h00,8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h00,8'h00,8'h0E,8'h11,8'h20,8'h20,8'hA0,8'hFF,8'h80};//q 81
parameter data_F8X16_83 = {8'h80,8'h80,8'h80,8'h00,8'h80,8'h80,8'h80,8'h00,8'h20,8'h20,8'h3F,8'h21,8'h20,8'h00,8'h01,8'h00};//r 82
parameter data_F8X16_84 = {8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h80,8'h00,8'h00,8'h33,8'h24,8'h24,8'h24,8'h24,8'h19,8'h00};//s 83
parameter data_F8X16_85 = {8'h00,8'h80,8'h80,8'hE0,8'h80,8'h80,8'h00,8'h00,8'h00,8'h00,8'h00,8'h1F,8'h20,8'h20,8'h00,8'h00};//t 84
parameter data_F8X16_86 = {8'h80,8'h80,8'h00,8'h00,8'h00,8'h80,8'h80,8'h00,8'h00,8'h1F,8'h20,8'h20,8'h20,8'h10,8'h3F,8'h20};//u 85
parameter data_F8X16_87 = {8'h80,8'h80,8'h80,8'h00,8'h00,8'h80,8'h80,8'h80,8'h00,8'h01,8'h0E,8'h30,8'h08,8'h06,8'h01,8'h00};//v 86
parameter data_F8X16_88 = {8'h80,8'h80,8'h00,8'h80,8'h00,8'h80,8'h80,8'h80,8'h0F,8'h30,8'h0C,8'h03,8'h0C,8'h30,8'h0F,8'h00};//w 87
parameter data_F8X16_89 = {8'h00,8'h80,8'h80,8'h00,8'h80,8'h80,8'h80,8'h00,8'h00,8'h20,8'h31,8'h2E,8'h0E,8'h31,8'h20,8'h00};//x 88
parameter data_F8X16_90 = {8'h80,8'h80,8'h80,8'h00,8'h00,8'h80,8'h80,8'h80,8'h80,8'h81,8'h8E,8'h70,8'h18,8'h06,8'h01,8'h00};//y 89
parameter data_F8X16_91 = {8'h00,8'h80,8'h80,8'h80,8'h80,8'h80,8'h80,8'h00,8'h00,8'h21,8'h30,8'h2C,8'h22,8'h21,8'h30,8'h00};//z 90
parameter data_F8X16_92 = {8'h00,8'h00,8'h00,8'h00,8'h80,8'h7C,8'h02,8'h02,8'h00,8'h00,8'h00,8'h00,8'h00,8'h3F,8'h40,8'h40};//{ 91
parameter data_F8X16_93 = {8'h00,8'h00,8'h00,8'h00,8'hFF,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'hFF,8'h00,8'h00,8'h00};//| 92
parameter data_F8X16_94 = {8'h00,8'h02,8'h02,8'h7C,8'h80,8'h00,8'h00,8'h00,8'h00,8'h40,8'h40,8'h3F,8'h00,8'h00,8'h00,8'h00};//} 93
parameter data_F8X16_95 = {8'h00,8'h06,8'h01,8'h01,8'h02,8'h02,8'h04,8'h04,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};//~ 94



parameter data_Hzk_zhong  = { 8'h00,8'h00,8'hF0,8'h10,8'h10,8'h10,8'h10,8'hFF,8'h10,8'h10,8'h10,8'h10,8'hF0,8'h00,8'h00,8'h00,
                              8'h00,8'h00,8'h0F,8'h04,8'h04,8'h04,8'h04,8'hFF,8'h04,8'h04,8'h04,8'h04,8'h0F,8'h00,8'h00,8'h00};/*"中",0*/
parameter data_Hzk_dian  = {  8'h00,8'h00,8'hF8,8'h88,8'h88,8'h88,8'h88,8'hFF,8'h88,8'h88,8'h88,8'h88,8'hF8,8'h00,8'h00,8'h00,
                              8'h00,8'h00,8'h1F,8'h08,8'h08,8'h08,8'h08,8'h7F,8'h88,8'h88,8'h88,8'h88,8'h9F,8'h80,8'hF0,8'h00};/*"电",3*/
parameter data_Hzk_zi  =  {   8'h80,8'h82,8'h82,8'h82,8'h82,8'h82,8'h82,8'hE2,8'hA2,8'h92,8'h8A,8'h86,8'h82,8'h80,8'h80,8'h00,
                              8'h00,8'h00,8'h00,8'h00,8'h00,8'h40,8'h80,8'h7F,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00,8'h00};/*"子",4*/
parameter data_Hzk_ke  = {    8'h24,8'h24,8'hA4,8'hFE,8'hA3,8'h22,8'h00,8'h22,8'hCC,8'h00,8'h00,8'hFF,8'h00,8'h00,8'h00,8'h00,
                              8'h08,8'h06,8'h01,8'hFF,8'h00,8'h01,8'h04,8'h04,8'h04,8'h04,8'h04,8'hFF,8'h02,8'h02,8'h02,8'h00};/*"科",5*/
parameter data_Hzk_ji  = {   8'h10,8'h10,8'h10,8'hFF,8'h10,8'h90,8'h08,8'h88,8'h88,8'h88,8'hFF,8'h88,8'h88,8'h88,8'h08,8'h00,
                              8'h04,8'h44,8'h82,8'h7F,8'h01,8'h80,8'h80,8'h40,8'h43,8'h2C,8'h10,8'h28,8'h46,8'h81,8'h80,8'h00};/*"技",6*/
	wire [7:0]AddrU1;
	wire [7:0]DataU1;
	wire [1:0]CallU1;
	wire DoneU2;
oled_ctrlmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .iCall( 1'b1 ),  // < top
		  .oDone( oDone ),    // > top
		  .iData1( {data_0,data_1,data_2 ,data_3,data_4,data_5,data_6,data_7 } ),    // > top
 		  .iData2( {data_0,data_1,data_2 ,data_3,data_4,data_5,data_6,data_7 } ),    // > top
		  .iData3( {data_0,data_1,data_2 ,data_3,data_4,data_5,data_6,data_7 } ),    // > top
		  .iData4( {data_0,data_1,data_2 ,data_3,data_4,data_5,data_6,data_7 } ),    // > top
		  .oCall( CallU1 ),  // > U2
		  .iDone( DoneU2 ),    // < U2
		  .oAddr( AddrU1 ),    // > U2
		  .oData( DataU1 )     // > U2
	 );

	 
iic U2
	 (
	     .CLOCK( CLOCK ),
		  .RESET( RST_n ),
		  .SCL( OLED_SCL ),   // > top
		  .SDA( OLED_SDA ),         // <> top
		  .iCall( CallU1 ),            // < U1
		  .oDone( DoneU2 ),              // > U1
		  .iAddr( AddrU1 ),              // > U1
		  .iData( DataU1 ),              // > U1
		  .oData( oData )                // > top
	 );

endmodule
