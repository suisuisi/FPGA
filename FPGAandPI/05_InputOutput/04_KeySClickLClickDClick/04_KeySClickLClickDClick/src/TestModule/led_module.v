//****************************************************************************//
//# @Author: ����˼
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-09 03:24:19
//# Description: 
//# @Modification History: 2012-10-03 16:35:17
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2012-10-03 16:35:17
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module led_module 
(
    CLOCK, RST_n, 
    Pin_In,
    LED
);

    input CLOCK;
	input RST_n;
	input [2:0]Pin_In;
	output [2:0]LED;

	 
	/*************************/ // sub demo		
	
	reg [2:0]rLED;
	
	always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		     rLED <= 2'b00;
		 else if( Pin_In[2] )
		     rLED[2] <= ~rLED[2];
	    else if( Pin_In[1] )		 
		     rLED[1] <= ~rLED[1]; 
		else if( Pin_In[0] )
		     rLED[0] <= ~rLED[0];
			  
	/***************************/

	assign LED=rLED;
	 
endmodule

	     
	 