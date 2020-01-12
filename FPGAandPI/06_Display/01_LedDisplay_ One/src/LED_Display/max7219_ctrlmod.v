//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:55:44
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-23 03:47:46
//# Description: 
//# @Modification History: 2019-05-19 20:58:05
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:05
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module max7219_ctrlmod
(
    input CLOCK, RST_n,	 
	 input iCall,
	 output oDone,
	 input [63:0]iData,
	 output oCall,
	 input iDone,
	 output MAX7219_CS, MAX7219_SCLK,
	 output MAX7219_DATA,
	 output [7:0]oDATA0, oDATA1
);	 
//wire [7:0]oDATA0, oDATA1;
//wire oCall,iDone;
//wire oDone;

//	 reg [63:0]iData;
	 reg [7:0]D1,D2;
	 reg [7:0]i;
	 reg isCall;
	 reg isDone;
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    D1 <= 8'd0;
					D2 <= 8'd0;
					i  <= 8'd0;
					//iData <= 64'd0;
				end
		  else if ( iCall )
		      case( i )
//************************初始化操作*********************************//
					 0 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h09; D2 = 8'h00; end
					 else begin isCall <= 1'b1; end
					 
					 1 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 2 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//译码方式：BCD码
				
					3 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0a; D2 = 8'h03; end
					 else begin isCall <= 1'b1; end
					 
					 4 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 5 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//亮度 

					 6 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0b; D2 = 8'h07; end
					 else begin isCall <= 1'b1; end
					 
					 7 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 8 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//扫描界限；8个数码管显示

					 9 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0c; D2 = 8'h01; end
					 else begin isCall <= 1'b1; end
					 
					 10 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 11 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//掉电模式：0，普通模式：1

					 12 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0f; D2 = 8'h00; end
					 else begin isCall <= 1'b1; end
					 
					 13 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 14 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//显示测试：1；测试结束，正常显示：0
//************************初始化操作结束******************************//	
//************************显示第一位*********************************//
					 15 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h01; D2 = iData[7:0]; end
					 else begin isCall <= 1'b1; end
					 
					 16 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 17 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

					 18 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h02; D2 = iData[15:8]; end
					 else begin isCall <= 1'b1; end
					 
					 19 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 20 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

			         21 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h03; D2 = iData[23:16]; end
					 else begin isCall <= 1'b1; end
					 
					 22 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 23 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

					 24 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h04; D2 =iData[31:24]; end
					 else begin isCall <= 1'b1; end
					 
					 25 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 26 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

					 27 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h05; D2 =iData[39:32]; end
					 else begin isCall <= 1'b1; end
					 
					 28 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 29 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

					 30 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h06; D2 =iData[47:40]; end
					 else begin isCall <= 1'b1; end
					 
					 31 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 32 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

					 33 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h07; D2 =iData[55:48]; end
					 else begin isCall <= 1'b1; end
					 
					 34 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 35 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

					 36 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h08; D2 =iData[63:56]; end
					 else begin isCall <= 1'b1; end
					 
					 37 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 38 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

					 39:
					 i <= 8'd15;
		endcase

	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oDATA0 = D1;
	  assign oDATA1 = D2;

endmodule
