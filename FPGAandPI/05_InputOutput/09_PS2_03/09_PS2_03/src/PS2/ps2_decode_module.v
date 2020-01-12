//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-15 00:15:16
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-17 21:18:21
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
	oData,
	oState
);
    input CLOCK, RST_n;
    input isH2L;
	 input PS2_DAT;
	 output oTrig;
	 output [7:0]oData;
	 output [5:0]oState;
	 
	parameter MLSHIFT = 24'h00_00_12, MLCTRL = 24'h00_00_14, MLALT = 24'h00_00_11;
	parameter BLSHIFT = 24'h00_F0_12, BLCTRL = 24'h00_F0_14, BLALT = 24'h00_F0_11;
	parameter MRSHIFT = 24'h00_00_59, MRCTRL = 24'hE0_00_14, MRALT = 24'hE0_00_11;
	parameter BRSHIFT = 24'h00_F0_59, BRCTRL = 24'hE0_F0_14, BRALT = 24'hE0_F0_11;
	parameter BREAK = 8'hF0;
	parameter FF_Read = 5'd8, DONE = 5'd6, SET = 5'd4, CLEAR = 5'd5;

	 reg [7:0]T;
	 reg [23:0]D1;
	 reg [5:0]isTag; // [2]isRShift, [1]isRCtrl, [0]isRAlt, [2]isLShift, [1]isLCtrl, [0]isLAlt;
	 reg [4:0]i,Go;
	 reg isDone;
	 
	 always @ ( posedge CLOCK or negedge RST_n)
	     if( !RST_n )
		      begin
				    T <= 8'd0;
				    D1 <= 24'd0;
					 isTag <= 6'd0;
					 i <= 5'd0;
					 Go <= 5'd0;
					 isDone <= 1'b0;
				end
		   else
			    case( i )
					  
					  0: // Read Make
					  begin i <= FF_Read; Go <= i + 1'b1; end
					  
					  1: // E0_xx_xx & E0_F0_xx Check
					  if( T == 8'hE0 ) begin D1[23:16] <= T; i <= FF_Read; Go <= i; end
					  else if( D1[23:16] == 8'hE0 && T == 8'hF0 ) begin D1[15:8] <= T; i <= FF_Read; Go <= i; end
					  else if( D1[23:8] == 16'hE0_F0 ) begin D1[7:0] <= T; i <= CLEAR; end
					  else if( D1[23:16] == 8'hE0 && T != 8'hF0 ) begin D1[15:0] <= {8'd0, T}; i <= SET; end
					  else i <= i + 1'b1;
					  
					  2: // 00_F0_xx Check
					  if( T == BREAK ) begin D1[23:8] <= {8'd0,T}; i <= FF_Read; Go <= i; end
					  else if( D1[23:8] == 16'h00_F0 ) begin D1[7:0] <= T; i <= CLEAR; end
		           else i <= i + 1'b1;
		 
					  3: // 00_00_xx Check
					  begin D1 <= {16'd0,T}; i <= SET; end
					
					  4: // Set state
					  if( D1 == MRSHIFT ) begin isTag[5] <= 1'b1; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == MRCTRL ) begin isTag[4] <= 1'b1; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == MRALT ) begin isTag[3] <= 1'b1; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == MLSHIFT ) begin isTag[2] <= 1'b1; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == MLCTRL ) begin isTag[1] <= 1'b1; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == MLALT ) begin isTag[0] <= 1'b1; D1 <= 24'd0; i <= 5'd0; end
					  else i <= DONE;
					  
					  5: // Clear state
					  if( D1 == BRSHIFT ) begin isTag[5] <= 1'b0; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == BRCTRL ) begin isTag[4] <= 1'b0; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == BRALT ) begin isTag[3] <= 1'b0; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == BLSHIFT ) begin isTag[2] <= 1'b0; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == BLCTRL ) begin isTag[1] <= 1'b0; D1 <= 24'd0; i <= 5'd0; end
					  else if( D1 == BLALT ) begin isTag[0] <= 1'b0; D1 <= 24'd0; i <= 5'd0; end
					  else begin D1 <= 24'd0; i <= 5'd0; end
					  
					  6: // DONE
					  begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					  7:
					  begin isDone <= 1'b0; i <= 5'd0; end

					  /****************/ // PS2 Read Function
					  
					  8:  // Start bit
					  if( isH2L ) i <= i + 1'b1; 
					  
					  9,10,11,12,13,14,15,16:  // Data byte
					  if( isH2L ) begin i <= i + 1'b1; T[ i-9 ] <= PS2_DAT; end
					  
					  17: // Parity bit
					  if( isH2L ) i <= i + 1'b1;
					  
					  18: // Stop bit
					  if( isH2L ) i <= Go;
					    
				 endcase
	 
	 assign oTrig = isDone;
	 assign oData = D1[7:0];
	 assign oState = isTag;
	 
endmodule