//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-12 16:32:52
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-04 17:18:38
//# Description: 
//# @Modification History: 2019-05-12 20:00:32
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-12 20:00:32
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module rx_control_module
(
    CLOCK, RST_n,
	 H2L_Sig, 
	 RXD, 
	 BPS_CLK, 
	 RX_En_Sig,
    BPS_En_Sig, 
	 RX_Data, 
	 RX_Done_Sig
	 
);

    input CLOCK;
	input RST_n;
	 
	input H2L_Sig;
	input RX_En_Sig;
	input RXD;
	input BPS_CLK;
	 
	output BPS_En_Sig;
	output [7:0]RX_Data;
	output RX_Done_Sig;
	 
	 
	 /********************************************************/
    //sync the rxd data: rxd_sync
    reg	rxd_sync;				
    always@(posedge CLOCK or negedge RST_n)
    begin
	if(!RST_n)
		rxd_sync <= 1;
	else
		rxd_sync <= RXD;
    end


	 /********************************************************/

	 reg [3:0]i;
	 reg [7:0]rData;
	 reg isCount;
	 reg isDone;
	
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin 
		          i <= 4'd0;
					 rData <= 8'd0;
					 isCount <= 1'b0;
					 isDone <= 1'b0;	 
				end
		  else if( RX_En_Sig )
		      case ( i )
				
			       4'd0 :
					 if( H2L_Sig ) begin i <= i + 1'b1; isCount <= 1'b1; end
					 
					 4'd1 : 
					 if( BPS_CLK ) begin i <= i + 1'b1; end
					 
					 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9 :
					 if( BPS_CLK ) begin i <= i + 1'b1; rData[ i - 2 ] <= rxd_sync; end
					 
					 4'd10 :
					 if( BPS_CLK ) begin i <= i + 1'b1; end
					 
					 4'd11 :
					 if( BPS_CLK ) begin i <= i + 1'b1; end
					 
					 4'd12 :
					 begin i <= i + 1'b1; isDone <= 1'b1; isCount <= 1'b0; end
					 
					 4'd13 :
					 begin i <= 4'd0; isDone <= 1'b0; end
				 
				endcase
				
    /********************************************************/
	 
	 assign BPS_En_Sig = isCount;
	 assign RX_Data = rData;
	 assign RX_Done_Sig = isDone;
	 
	 
	 /*********************************************************/
	 
endmodule

