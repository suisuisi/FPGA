//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:55:44
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-07 02:12:54
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
	 input [63:0]iData1,iData2,iData3,iData4,
	 output oCall,
	 input iDone,
	 output MAX7219_CS,
	 output [7:0]oDATA0, oDATA1
);	 
//wire [7:0]oDATA0, oDATA1;
//wire oCall,iDone;
//wire oDone;
parameter FCLK = 23'd2500_000; // 10hz,(1/10hz)/(1/50Mhz) FCLK 为一个周期

//	 reg [63:0]iData;
	 reg [7:0]D1,D2;
	 reg [9:0]i;
	 reg isCall;
	 reg isDone;
	 reg rCS;
	 reg [22:0]C1;
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    D1 <= 8'd0;
					D2 <= 8'd0;
					i  <= 10'd0;
					rCS <= 1'b1;
					//iData <= 64'd0;
				end
		  else if ( iCall )
		      case( i )
//************************初始化操作*********************************//
				0 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end//第一片初始化			
				1 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h09; D2 = 8'h00; end//第一片初始化
					 else begin isCall <= 1'b1; end
				2 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end//第一片初始化
				3 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end//第一片初始化					 	
				4 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h09; D2 = 8'h00; end//第二片初始化
					 else begin isCall <= 1'b1; end
				5 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				6 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end//第一片初始化	
				7 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end//第一片初始化						 	
				8 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h09; D2 = 8'h00; end//第三片初始化
					 else begin isCall <= 1'b1; end
				9 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				10 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				11 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end//第一片初始化	
				12 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end//第一片初始化	
				13 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h09; D2 = 8'h00; end//第四片初始化
					 else begin isCall <= 1'b1; end
				14 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				15 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				16 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				17 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end//第一片初始化	
				18  :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
				19  :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//译码方式：BCD码
				20 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end//第一片初始化						 	
				
				21  :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0a; D2 = 8'h03; end//第一片初始化
					 else begin isCall <= 1'b1; end
				22 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end
				23 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end					 					 	
				24  :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0a; D2 = 8'h03; end//第二片初始化
					 else begin isCall <= 1'b1; end		 	
				25  :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				26 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				27 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 					 	
				28  :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0a; D2 = 8'h03; end//第三片初始化
					 else begin isCall <= 1'b1; end
				29 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				30 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end	
				31 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				32 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 				 	
				33 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0a; D2 = 8'h03; end//第四片初始化
					 else begin isCall <= 1'b1; end
				34 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				35 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				36 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				37 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	

				38 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
				39 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//亮度 
				40 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	

				41 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0b; D2 = 8'h07; end//第一片初始化
					 else begin isCall <= 1'b1; end
				42 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				43 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 					 	
				44 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0b; D2 = 8'h07; end//第二片初始化
					 else begin isCall <= 1'b1; end
				45 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				46 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				47 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 					 	
				48 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0b; D2 = 8'h07; end//第三片初始化
					 else begin isCall <= 1'b1; end
				49 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				50 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				51 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				52 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				53 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0b; D2 = 8'h07; end//第四片初始化
					 else begin isCall <= 1'b1; end
				54 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				55 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end					 					 	
				56 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				57 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	

				58 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
				59 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//扫描界限；8个数码管显示
				60 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	

				61 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0c; D2 = 8'h01; end//第一片初始化
					 else begin isCall <= 1'b1; end
				62 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				63 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 					 	
				64 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0c; D2 = 8'h01; end//第二片初始化
					 else begin isCall <= 1'b1; end
				65 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				66 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				67 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 					 	
				68 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0c; D2 = 8'h01; end//第三片初始化
					 else begin isCall <= 1'b1; end
				69 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				70 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				71 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				72 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				73 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0c; D2 = 8'h01; end//第四片初始化
					 else begin isCall <= 1'b1; end
				74 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end					 	
				75 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				76 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				77 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end						 	

				78 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
				79 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//掉电模式：0，普通模式：1

				80 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
				81 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0f; D2 = 8'h00; end//第一片初始化
					 else begin isCall <= 1'b1; end
				82 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				83 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				84 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0f; D2 = 8'h00; end//第二片初始化
					 else begin isCall <= 1'b1; end
				85 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				86 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				87 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				88 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0f; D2 = 8'h00; end//第三片初始化
					 else begin isCall <= 1'b1; end
				89 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				90 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				91 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				92 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
				93 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h0f; D2 = 8'h00; end//第四片初始化
					 else begin isCall <= 1'b1; end
				94 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				95 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				96 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				97 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	

				98 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
				99 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//显示测试：1；测试结束，正常显示：0
				100 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
//************		      60********初始化操作结束******************************//	
//************		       61********显示第一位*********************************//
				101 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h01; D2 = iData1[7:0]; end//第一片数据
					 else begin isCall <= 1'b1; end
				102 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				103 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 					 	
				104 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h01; D2 = iData2[7:0]; end//第二片数据
					 else begin isCall <= 1'b1; end
				105 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h00; D2 = 8'h00;       end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				106 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				107 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				108 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h01; D2 = iData3[7:0]; end//第三片数据
					 else begin isCall <= 1'b1; end
				109 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h00; D2 = 8'h00;       end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				110 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h00; D2 = 8'h00;       end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				111 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				112 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				113 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h01; D2 = iData4[7:0]; end//第四片数据
					 else begin isCall <= 1'b1; end
				114 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h01; D2 = 8'h00;       end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				115 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h00; D2 = 8'h00;       end//第二片写入0x0000
					 else begin isCall <= 1'b1; end					 	
				116 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 =8'h00; D2 = 8'h00;       end//第三片写入0x0000
					 else begin isCall <= 1'b1; end	
				117 :
					 if( C1 == FCLK -1) begin C1 <= 23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;						 					 	

				118 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end		 
				119 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

				120 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
				121 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h02; D2 = iData1[15:8]; end//第一片数据
					 else begin isCall <= 1'b1; end
				122 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				123 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				124 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h02; D2 = iData2[15:8]; end//第二片数据
					 else begin isCall <= 1'b1; end
				125 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				126 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				127 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				128 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h02; D2 = iData3[15:8]; end//第三片数据
					 else begin isCall <= 1'b1; end
				129 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				130 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end	
				131 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				132 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 				 	
				133 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h02; D2 = iData4[15:8]; end//第四片数据
					 else begin isCall <= 1'b1; end
				134 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				135 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				136 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				137 :
					 if( C1 == FCLK -1) begin C1 <= 23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;							 	

				138 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end					 
				139 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

				140 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
			    141 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h03; D2 = iData1[23:16]; end//第一片数据
					 else begin isCall <= 1'b1; end
				142 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				143 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
			    144 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h03; D2 = iData2[23:16]; end//第二片数据
					 else begin isCall <= 1'b1; end
			    145 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				146 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				147 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
			    148 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h03; D2 = iData3[23:16]; end//第三片数据
					 else begin isCall <= 1'b1; end
			    149 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
			    150 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				151 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				152 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
			    153 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h03; D2 = iData4[23:16]; end//第四片数据
					 else begin isCall <= 1'b1; end
			    154 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end					 
			    155 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
			    156 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 = 8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				157 :
					 if( C1 == FCLK -1) begin C1 <= 23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;	

				158 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end					 
				159 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

				160 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
				161 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h04; D2 =iData1[31:24]; end//第一片数据
					 else begin isCall <= 1'b1; end
				162 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				163 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 					 	
				164 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h04; D2 =iData2[31:24]; end//第二片数据
					 else begin isCall <= 1'b1; end
				165 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				166 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				167 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				168 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h04; D2 =iData3[31:24]; end//第三片数据
					 else begin isCall <= 1'b1; end
				169 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				170 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				171 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				172	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				173 :
					 	if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h04; D2 =iData4[31:24]; end//第四片数据
					 	else begin isCall <= 1'b1; end					 	
				174 :
					 	if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 	else begin isCall <= 1'b1; end
				175 :
					 	if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
						 else begin isCall <= 1'b1; end
				176 :
					 	if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第三片写入0x0000
						 else begin isCall <= 1'b1; end

				177	 :
					 if( C1 == FCLK -1) begin C1 <= 23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;	
				178 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end					 
				179 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

				180	 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
				181 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h05; D2 =iData1[39:32]; end//第一片数据
					 else begin isCall <= 1'b1; end
				182	 :
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				183	 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				184 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h05; D2 =iData2[39:32]; end//第二片数据
					 else begin isCall <= 1'b1; end
				185 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				186	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				187	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	 	

				188 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h05; D2 =iData3[39:32]; end//第三片数据
					 else begin isCall <= 1'b1; end
				189 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				190 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				191	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				192	 :
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				193 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h05; D2 =iData4[39:32]; end//第四片数据
					 else begin isCall <= 1'b1; end
				194 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				195 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end					 	
				196 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end			 	

				197	 :
					 if( C1 == FCLK -1) begin C1 <= 23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;						 
				198 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end					 
				199 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

				200	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
				201 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h06; D2 =iData1[47:40]; end//第一片数据
					 else begin isCall <= 1'b1; end
				202	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				203	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				204 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h06; D2 =iData2[47:40]; end//第二片数据
					 else begin isCall <= 1'b1; end
				205 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				206	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				207	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				208 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h06; D2 =iData3[47:40]; end//第三片数据
					 else begin isCall <= 1'b1; end
				209 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				210 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				211	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				212	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				213 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h06; D2 =iData4[47:40]; end//第四片数据
					 else begin isCall <= 1'b1; end
				214 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				215 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				216 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end			 	
				217	:
					 if( C1 == FCLK -1) begin C1 <= 23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;							 
				218 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end					 
				219 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

				220	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end	
				221 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h07; D2 =iData1[55:48]; end//第一片数据
					 else begin isCall <= 1'b1; end
				222	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				223	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				224 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h07; D2 =iData2[55:48]; end//第二片数据
					 else begin isCall <= 1'b1; end
				225 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				226	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				227	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				228 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h07; D2 =iData3[55:48]; end//第三片数据
					 else begin isCall <= 1'b1; end
				229 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				230 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				231	:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				232	:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				233 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h07; D2 =iData4[55:48]; end//第四片数据
					 else begin isCall <= 1'b1; end
				234 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				235 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				236 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end	
				237	:
					 if( C1 == FCLK -1) begin C1 <=23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;						 	 					 	


				238 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end					 
				239 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end
				240:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	

				241 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h08; D2 =iData1[63:56]; end//第一片数据
					 else begin isCall <= 1'b1; end
				242:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	

				243 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h08; D2 =iData2[63:56]; end//第二片数据
					 else begin isCall <= 1'b1; end
				244 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				245:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				246:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				247 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h08; D2 =iData3[63:56]; end//第三片数据
					 else begin isCall <= 1'b1; end
				248 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				249 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				250 :	 i <= i + 1'b1;
				251:
					 begin rCS  <= 1'b1; i <= i + 1'b1; end	
				252:
					 begin rCS  <= 1'b0; i <= i + 1'b1; end						 	
				253 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h08; D2 =iData4[63:56]; end//第四片数据
					 else begin isCall <= 1'b1; end
				254 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第一片写入0x0000
					 else begin isCall <= 1'b1; end
				255 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第二片写入0x0000
					 else begin isCall <= 1'b1; end
				256 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 = 8'h00; D2 =8'h00; end//第三片写入0x0000
					 else begin isCall <= 1'b1; end
				257:
					 if( C1 == FCLK -1) begin C1 <= 23'd0;rCS  <= 1'b1; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;	
					 
				258 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end					 
				259 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end

				260:
					 i <=10'd100;//
		endcase

	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oDATA0 = D1;
	  assign oDATA1 = D2;
	  assign MAX7219_CS = rCS;

endmodule
