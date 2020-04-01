//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:55:44
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-05-29 20:56:25
//# Description: 
//# @Modification History: 2019-05-19 20:58:05
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:05
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module pcf8563_ctrlmod
(
    input CLOCK, RST_n,	 
	 input [7:0]iCall,
	 output oDone,
	 input [7:0]iData,
	 output [1:0]oCall,
	 input iDone,
	 output [7:0]oAddr, oData
);	 

parameter    psub_address=8'b0000_0000;        //PCF8563 第一个控制寄存器的地址
parameter    psub_address1=8'b0000_0010;      //PCF8563 的秒寄存器的地址
parameter    psub_address2=8'b0000_0011;       //PCF8563 的分寄存器的地址
parameter    psub_address3=8'b0000_0100;       //PCF8563 的时寄存器的地址

	 
	 reg [7:0]D1,D2;

	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    D1 <= 8'd0;
					 D2 <= 8'd0;
				end
		  else 
		      case( iCall[7:0] )
				
				    8'b1000_0000 : // psub_address & control_data
					 begin D1 <s= psub_address;  D2 <= iData; end  //D2 <= 8'b0000_0000;
					
				    8'b0100_0000 : // Write second
					 begin D1 <= psub_address1; D2 <= iData; end //8'b00100100
					 
					 8'b0010_0000 : // Write minit
					 begin D1 <= psub_address2; D2 <= iData; end//8'b01010111
					 
					 8'b0001_0000 : // Write hour
					 begin D1 <= psub_address3; D2 <= iData; end//8'b00000111

					 8'b0000_0100 : // Read second 
					 begin D1 = psub_address1; end
					 
					 8'b0000_0010 : // Read minit
					 begin D1 = psub_address2; end
					 
					 8'b0000_0001 : // Read hour  
					 begin D1 = psub_address3; end

				
				endcase
	 
	 reg [1:0]i;
	 reg [1:0]isCall;
	 reg isDone;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				     i <= 2'd0;
					 isCall <= 2'b00;
					 isDone <= 1'b0;
				end
		  else if( iCall[7:4] ) // Write action
		      case( i )
				
				    0 :
					 if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; end
					 
					 1 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 2 :
					 begin isDone <= 1'b0; i <= 2'd0; end
					  
				endcase
		  else if( iCall[2:0] ) // Read action
		      case( i )
				
				    0 :
					 if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; end
					 
					 1 :
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 2 :
					 begin isDone <= 1'b0; i <= 2'd0; end
					  
				endcase
	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oAddr = D1;
	  assign oData = D2;

endmodule
