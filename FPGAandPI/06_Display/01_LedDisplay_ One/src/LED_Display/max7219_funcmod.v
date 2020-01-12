//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 21:06:32
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-23 00:59:41
//# Description: 
//# @Modification History: 2019-05-19 20:58:19
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:19
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module max7219_funcmod
(
    input CLOCK, RST_n,
	 output MAX7219_CS,MAX7219_SCLK,
	 output MAX7219_DATA,
	 input iCall,
	 output oDone,
	 input [7:0]iDATA0,iDATA1

);	 
	 parameter FCLK = 6'd25, FHALF = 6'd12; // 2Mhz,(1/2Mhz)/(1/50Mhz) FCLK 为一个周期
	 parameter FF_Write = 6'd16, FF_Read = 6'd32;//FHALF 为半周期
	 
	 reg [5:0]C1;
    reg [5:0]i,Go;
	 reg [7:0]D1,T; //D1 为暂存读取结果 T 为伪函数的操作空间
	 reg rCS, rSCLK, rSIO; 
	 reg isQ,isDone; //isQ 为 IO 的控制输出
	 
    always @ ( posedge CLOCK or negedge RST_n )	
	     if( !RST_n )
		      begin
				    C1 <= 6'd0;
				    { i,Go } <= { 6'd0,6'd0 };
					 { D1,T } <= { 8'd0,8'd0 };
					 { rCS, rSCLK, rSIO } <= 3'b000;
					 { isQ, isDone } <= 2'b00;
				end
/***********************************************************************
下面步骤是写一个字节的伪函数。步骤 0 拉高片选，准备访问字节，并且进入伪函数。
步骤 1 准备写入数据并且进入伪函数。
步骤 2 拉低片选，步骤 3~4 则是用来产生完成信号。
***********************************************************************/
		   else if( iCall )
			    case( i )
				     
					  0:
					  begin { rCS,rSCLK } <= 2'b00; T <= iDATA0; i <= FF_Write; Go <= i + 1'b1; end
					  
					  1:
					  begin T <= iDATA1; i <= FF_Write; Go <= i + 1'b1; end
					  
					  2:
					  begin { rCS,rSCLK } <= 2'b10; i <= i + 1'b1; end
					  
					  3:
					  begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					  4:
					  begin isDone <= 1'b0; i <= 6'd0; end
					  
					  /******************/
					  
					  16,17,18,19,20,21,22,23:
					  begin
					      isQ = 1'b1;
					      rSIO <= T[23-i];//i-16
							
							if( C1 == 0 ) rSCLK <= 1'b0;
 					      else if( C1 == FHALF ) rSCLK <= 1'b1;
					  
					      if( C1 == FCLK -1) begin C1 <= 6'd0; i <= i + 1'b1; end
							else C1 <= C1 + 1'b1;
					  end
					  
					  24:
					  i <= Go;
					  
				 endcase
       
/***********************************************************************
以下内容为相关输出驱动声明，其中 rSIO 驱动 MAX7219_DATA， D 驱动 oData	。
***********************************************************************/
		assign { MAX7219_CS,MAX7219_SCLK } = { rCS,rSCLK };
		assign MAX7219_DATA = rSIO ;  //isQ ? rSIO : 1'bz;
		assign oDone = isDone;

endmodule