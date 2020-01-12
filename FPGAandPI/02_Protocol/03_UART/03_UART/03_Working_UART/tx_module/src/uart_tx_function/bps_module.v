//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-03 01:32:40
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-04 17:18:48
//# Description: 
//# @Modification History: 2019-05-06 21:22:18
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-06 21:22:18
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
/***********************************************************************
	fc	:	Refrence clock = 50MHz = 50*10^6
	fo	:	Output	clock
	K	:	Counter Step
	fo	=	fc*[K/(2^32)]
100MHz	K	=	fo*(2^32)/fc = fo*(2^32)/(100*10^6)	= 42.94967296 * fo
50MHz 	K	=	fo*(2^32)/fc = fo*(2^32)/(50*10^6)	= 85.89934592 * fo
***********************************************************************/
`timescale 1ns/1ps
module	bps_module
#(
	//BPS_CNT = 85.89934592 * fo    for 50Mhz
//	parameter		BPS_CNT = 32'd21990233	//256000bps 21990233
//	parameter		BPS_CNT = 32'd10995116	//128000bps 10995116
//	parameter		BPS_CNT = 32'd9895605	//115200bps 9895605  
	parameter		BPS_CNT = 32'd824634//9600bps 824634	
  //BPS_CNT = 42.949 67296 * fo    for 100Mhz
//	parameter		BPS_CNT = 32'd175921860	//256000bps 
//	parameter		BPS_CNT = 32'd87960930	//128000bps 
//	parameter		BPS_CNT = 32'd79164837	//115200bps 
//	parameter		BPS_CNT = 32'd412317	//9600bps 
)
(
	//global clock
	input			CLOCK,
	input			RST_n,
	
	//user interface
	input          En_Sig,
	output			BPS_CLK,
	output			BPS_CLKen
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
		cnt <= cnt + BPS_CNT;		
end

//------------------------------------------------------
//RTL2: Equal division of the Frequency division clock
reg	cnt_equal;
always@(posedge CLOCK or negedge RST_n)
begin
	if(!RST_n)
		cnt_equal <= 0;
	else if(En_Sig)
	begin
		if(cnt < 32'h7FFF_FFFF)
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

assign	BPS_CLKen = (~cnt_equal_r & cnt_equal) ? 1'b1 : 1'b0; 
assign	BPS_CLK = cnt_equal_r;

endmodule
