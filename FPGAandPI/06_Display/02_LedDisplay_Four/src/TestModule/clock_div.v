//****************************************************************************//
//# @Author: ����˼
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-23 12:01:57
//# Description: 
//# @Modification History: 2012-10-03 16:26:17
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2012-10-03 16:26:17
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
/***********************************************************************
	fc	:	Refrence clock = 50MHz = 50*10^6
	fo	:	Output	clock
	K	:	Counter Step
	fo	=	fc*[K/(2^32)]
100MHz:	K	=	fo*(2^32)/fc = fo*(2^32)/(100*10^6)	= 42.94967296 * fo
50MHz : K	=	fo*(2^32)/fc = fo*(2^32)/(50*10^6)	= 85.89934592 * fo
***********************************************************************/

`timescale 1ns/1ps
module	clock_div
#(
	//DEVICE_CNT = 85.89934592 * fo    for 50Mhz
//	parameter		DEVICE_CNT = 32'd43	//0.5Hz  
	parameter		DEVICE_CNT = 32'd86// 1Hz
//	parameter		DEVICE_CNT = 32'd172	//2Hz
//	parameter      DEVICE_CNT = 32'd171798691  //2MHz
)
(
	//global clock
	input			CLOCK,
	input			RST_n,
	//input			[2:0]Option_Key,
	//user interface
	input           En_Sig,
	output			clock_div_1s
);


/********************************/

//------------------------------------------------------
//RTL1: Precise fractional frequency for uart bps clock 
reg	[31:0]	cnt;
always@(posedge CLOCK or negedge RST_n)
begin
	if(!RST_n)
		cnt <= 0;
	else if(En_Sig)
		cnt <= cnt + DEVICE_CNT;		
end

//------------------------------------------------------
//RTL2: Equal division of the Frequency division clock
reg	cnt_equal;
//reg	[31:0]	Option_Seg;
always@(posedge CLOCK or negedge RST_n)
begin
	if(!RST_n)
		cnt_equal <= 0;
	else if(En_Sig)
	begin
		if(cnt < 32'h7FFF_FFFF)    //2147483647 //Option_Seg
			cnt_equal <= 0;
		else
			cnt_equal <= 1;
	end
end

//------------------------------------------------------
//RTL3: Generate enable clock for clock
reg	cnt_equal_r;
always@(posedge CLOCK or negedge RST_n)
begin
	if(!RST_n)
		cnt_equal_r <= 0;
	else if(En_Sig)
		cnt_equal_r <= cnt_equal;
end

assign	clock_div_1s = cnt_equal_r;

		   
    /******************************************/


endmodule