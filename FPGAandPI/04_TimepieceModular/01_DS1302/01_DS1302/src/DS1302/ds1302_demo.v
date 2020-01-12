//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 01:42:42
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-05-19 21:39:15
//# Description: 
//# @Modification History: 2019-05-19 01:52:19
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 01:52:19
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module ds1302_demo
(
    input CLOCK, RST_n,
	 output RTC_NRST, RTC_SCLK, 
	 inout RTC_DATA,
	 output [7:0]SMG_Data,
	 output [5:0]Scan_Sig
);
	 wire DoneU1;
	 wire [7:0]DataU1;

	 
	 ds1302_basemod U1
    (
        .CLOCK( CLOCK ), 
	     .RST_n( RST_n ),
		  .RTC_NRST( RTC_NRST ),
	     .RTC_SCLK( RTC_SCLK ),
	     .RTC_DATA( RTC_DATA ),
	     .iCall( isCall ),
	     .oDone( DoneU1 ),
	     .iData( D1 ),
	     .oData( DataU1 )
    );
	 
	 smg_interface U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .SMG_Data( SMG_Data ),          // > top
		  .Scan_Sig( Scan_Sig ),          // > top
		  .Number_Sig( Number_Sig )          // < core
	 );

   reg [3:0]i;
	reg [7:0]isCall;
	reg [7:0]D1;
	reg [23:0]Number_Sig;
	
	always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		     begin
			      i <= 4'd0;
			      isCall <= 8'd0;
					D1 <= 8'd0;
					Number_Sig <= 24'd0;
			  end
		 else 
		     case( i )
/***********************************************************************
以下内容为核心操作的部分内容，步骤 0 关闭写保护，步骤 1 初始化时钟，步骤 2 初始
化分钟，步骤 3 初始化秒钟并且开启计时。
***********************************************************************/
			      0:
					if( DoneU1 ) begin isCall[7] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[7] <= 1'b1; D1 <= 8'h00; end
					
					1:
					if( DoneU1 ) begin isCall[6] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[6] <= 1'b1; D1 <= { 4'd2, 4'd1 }; end
					
					2:
					if( DoneU1 ) begin isCall[5] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[5] <= 1'b1; D1 <= { 4'd5, 4'd9 }; end
					
					3:
					if( DoneU1 ) begin isCall[4] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[4] <= 1'b1; D1 <= { 4'd5, 4'd0 }; end
					
/***********************************************************************
步骤 4 读取秒钟然后暂存至 D2[7:0]，步骤 5 读取分钟然后暂存至 D2[15:8]，步骤 6 读
取时钟然后暂存至 D2[23:16]。
***********************************************************************/					
					4:
					if( DoneU1 ) begin Number_Sig[7:0] <= DataU1; isCall[0] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[0] <= 1'b1; end
					
					5:
					if( DoneU1 ) begin Number_Sig[15:8] <= DataU1; isCall[1] <= 1'b0; i <= i + 1'b1; end
					else begin isCall[1] <= 1'b1; end
					
					6:
					if( DoneU1 ) begin Number_Sig[23:16] <= DataU1; isCall[2] <= 1'b0; i <= 4'd4; end
					else begin isCall[2] <= 1'b1; end
					
					
			  endcase

endmodule
