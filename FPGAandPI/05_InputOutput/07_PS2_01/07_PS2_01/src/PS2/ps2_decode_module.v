//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-15 00:15:16
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-15 00:32:45
//# Description: 
//# @Modification History: 2014-05-09 17:16:16
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2014-05-09 17:16:16
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module ps2_decode_module
(
    CLOCK, RST_n,
    isH2L,
	PS2_DAT,
	oTrig,
	oData
);
    input CLOCK, RST_n;
    input isH2L;
	 input PS2_DAT;
	 output oTrig;
	 output [7:0]oData;

    parameter BREAK = 8'hF0;
	parameter FF_Read = 5'd4;
	 
	 /******************/ // core

	 reg [7:0]D1;
	 reg [4:0]i,Go;
	 reg isDone;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    D1 <= 8'd0;
					 i <= 5'd0;
					 Go <= 5'd0;
					 isDone <= 1'b0;
				end
		   else
			    case( i )
				 
				     0:
					  begin i <= FF_Read; Go <= i + 1'b1; end
				  
				     1:
					  if( D1 == BREAK ) begin i <= FF_Read; Go <= 5'd0; end
					  else i <= i + 1'b1;
					  
					  2:
					  begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					  3:
					  begin isDone <= 1'b0; i <= 5'd0; end
					  
					  /*************/ // PS2 read function
					  
					  4:  // Start bit
					  if( isH2L ) i <= i + 1'b1; 
					  
					  5,6,7,8,9,10,11,12:  // Data byte
					  if( isH2L ) begin D1[ i-5 ] <= PS2_DAT; i <= i + 1'b1; end
					  
					  13: // Parity bit
					  if( isH2L ) i <= i + 1'b1;
					  
					  14: // Stop bit
					  if( isH2L ) i <= Go;

				 endcase
				 
    /************************************/
	 
	 assign oTrig = isDone;
	 assign oData = D1;
	 
	 /*************************************/
  
endmodule
