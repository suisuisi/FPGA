//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-12 16:32:52
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-04 17:18:40
//# Description: 
//# @Modification History: 2019-05-12 20:00:33
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-12 20:00:33
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module detect_module 
(
    CLOCK, RST_n,
	 RXD,
	 H2L_Sig
);
    input CLOCK;
	input RST_n;
	input RXD;
	output H2L_Sig;
	 

	/******************************/
    //sync the rxd data: rxd_sync
    reg	rxd_sync;				
    always@(posedge CLOCK or negedge RST_n)
    begin
	if(!RST_n)
		rxd_sync <= 1;
	else
		rxd_sync <= RXD;
    end

	/******************************/
	 
	 reg H2L_F1;
	 reg H2L_F2;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    H2L_F1 <= 1'b1;
					 H2L_F2 <= 1'b1;
				end
		  else
		      begin
				    H2L_F1 <= rxd_sync;
					H2L_F2 <= H2L_F1;
				end
				
	/***************************************/
	
	assign H2L_Sig = H2L_F2 & !H2L_F1;
	
	/***************************************/
	
endmodule


	 