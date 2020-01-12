//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-12 19:21:45
//****************************************//
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


	 