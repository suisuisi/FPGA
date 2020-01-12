//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-09 04:34:28
//# Description: 
//# @Modification History: 2010-08-07 14:36:26
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2010-08-07 14:36:26
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module Dipswitch_test_module
(
    CLOCK, RST_n, 
	dipkey_in,      
	LED,
	SMG_Data,
	Scan_Sig
);
    
	input CLOCK;
	input RST_n;
   input  [3:0] dipkey_in;
	output [3:0] LED;
	output [7:0]SMG_Data;
	output [5:0]Scan_Sig;

	/**************************/
	 
	wire [3:0]Pin_Out;

Dipswichfuncmod_module U1
	 (
	    .CLOCK( CLOCK ),
		.RST_n( RST_n ),
		.dipkey_in( dipkey_in ),   // input - from top
		.LED(LED),
		.Pin_Out( Pin_Out )      // < core
	 );
	 
	 /**************************/
	 smg_interface U2
	 (
	     .CLOCK( CLOCK ),
		 .RST_n( RST_n ),
		 .SMG_Data( SMG_Data ),          // output - to top
		 .Scan_Sig( Scan_Sig ),          // output - to top
		 .Number_Sig( Number_Sig )          // < core
	 );

	reg [23:0]Number_Sig;
	
	always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		     begin
			    Number_Sig[7:0] <= 8'h16;
			  end
		 else 
		     case( Pin_Out )
			    0:
			    	Number_Sig[7:0] <= 8'h00; 
				 1:
					Number_Sig[7:0] <= 8'h01;
				 2:
					Number_Sig[7:0] <= 8'h02;
				 3:
					Number_Sig[7:0] <= 8'h03;
				 4:
					Number_Sig[7:0] <= 8'h04;
				 5:
					Number_Sig[7:0] <= 8'h05;
				 6:
					Number_Sig[7:0] <= 8'h06;
				 7:
					Number_Sig[7:0] <= 8'h07;
				 8:
					Number_Sig[7:0] <= 8'h08;
				 9:
					Number_Sig[7:0] <= 8'h09;
				 10:
					Number_Sig[7:0] <= 8'h10;
				 11:
					Number_Sig[7:0] <= 8'h11;
				 12:
					Number_Sig[7:0] <= 8'h12;
				 13:
					Number_Sig[7:0] <= 8'h13;
				 14:
					Number_Sig[7:0] <= 8'h14;
				 15:
					Number_Sig[7:0] <= 8'h15;
					
				default:
				   Number_Sig[7:0]<=8'h16;

			  endcase

endmodule