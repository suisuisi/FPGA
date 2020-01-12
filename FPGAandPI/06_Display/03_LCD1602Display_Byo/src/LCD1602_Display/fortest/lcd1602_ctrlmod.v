//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:55:44
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-27 21:03:59
//# Description: 
//# @Modification History: 2019-05-19 20:58:05
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:05
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module lcd1602_ctrlmod
(
    input CLOCK, RST_n,	 
	 input iCall,
	 output oDone,
	 	 //lcd1602 interface
	output 				LCD1602_RS,		//H: Data; L: Instruction code
	output				LCD1602_RW,		//H: Read; L: Write
	output  			LCD1602_EN,		//LCD1602 Chip enable signal
	output		[7:0]	LCD1602_D,		//LCD1602 Data interface

	input		[127:0]	line_rom1,	//LCD1602 1th row display
	input		[127:0]	line_rom2,	//LCD1602 2th row display
	 output oCall,
 //   input iDone,
	 output [7:0]oDATA
);	 
wire iDone;
//LCD1602 init
localparam	DISP_SET	= 	8'h38;	//Display mode: Set 16X2,5X8, 8 bits data
localparam 	DISP_OFF	= 	8'h08;	//Display off
localparam 	CLR_SCR 	= 	8'h01;	//Clear the LCD
localparam 	CURSOR_SET1 = 	8'h06;	//Set Cursor
localparam 	CURSOR_SET2 = 	8'h0C;	//Display on
//Display 1th line	
localparam 	ROW1_ADDR	= 	8'h05;	//Line1's first address	

//Display 2th line
localparam 	ROW2_ADDR	= 	8'h1C;	//Line2's first address	

	 lcd1602_funcmod U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .LCD1602_RS( LCD1602_RS ),   // > top
		  .LCD1602_RW( LCD1602_RW ),         // > top
		  .LCD1602_EN( LCD1602_EN ),         // <> top
		  .LCD1602_D(LCD1602_D),
		  .iCall( oCall ),            // < U1
		  .oDone( iDone ),              // > U1
		  .iDATA( oDATA )             // > U1

	 );

//---------------------------------------

//	 reg [63:0]iData;
	 reg [7:0]D1;
	 reg [7:0]i;
	 reg isCall;
	 reg isDone;
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    D1 <= 8'd0;
					i  <= 8'd0;
					//iData <= 64'd0;
				end
		  else if ( iCall )
		      case( i )
//************************初始化操作*********************************//
					 0 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= DISP_SET; end
					 else begin isCall <= 1'b1; end//Display mode
					 
					 1 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= DISP_OFF; end
					 else begin isCall <= 1'b1; end//Display off
					 
					 2 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= CLR_SCR ; end
					 else begin isCall <= 1'b1; end//Clear the LCD
				
					3 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= CURSOR_SET1;  end
					 else begin isCall <= 1'b1; end//Set Cursor
					 
					 4 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= CURSOR_SET2;  end
					 else begin isCall <= 1'b1; end//Display on

					 5 :	
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 6 :
					 begin isDone <= 1'b0; i <= i + 1'b1; end//初始化完成 
					//Display 1th line	

					7 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= 8'h80; end
					 else begin isCall <= 1'b1; end////Line1's first address	

					 8 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[127:120]; end
					 else begin isCall <= 1'b1; end
					 		 
					 9 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[119:112]; end
					 else begin isCall <= 1'b1; end
					 
					 10 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[111:104]; end
					 else begin isCall <= 1'b1; end

					 11 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[103: 96]; end
					 else begin isCall <= 1'b1; end
					 
					 12 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 95: 88]; end
					 else begin isCall <= 1'b1; end

					 13 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 87: 80]; end
					 else begin isCall <= 1'b1; end

					 14 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 79: 72]; end
					 else begin isCall <= 1'b1; end

					 15 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 71: 64]; end
					 else begin isCall <= 1'b1; end

					 16 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 63: 56]; end
					 else begin isCall <= 1'b1; end

					 17 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 55: 48]; end
					 else begin isCall <= 1'b1; end

					 18 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 47: 40]; end
					 else begin isCall <= 1'b1; end

					 19 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 39: 32]; end
					 else begin isCall <= 1'b1; end

					 20 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 31: 24]; end
					 else begin isCall <= 1'b1; end

					 21 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 23: 16]; end
					 else begin isCall <= 1'b1; end

					 22 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[ 15:  8]; end
					 else begin isCall <= 1'b1; end

					 23 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom1[  7:  0]; end
					 else begin isCall <= 1'b1; end//
		//Display 2th line

					24 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= 8'hC0; end
					 else begin isCall <= 1'b1; end//Line2's first address	
					 25 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[127:120]; end
					 else begin isCall <= 1'b1; end
					 		 
					 26 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[119:112]; end
					 else begin isCall <= 1'b1; end
					 
					 27 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[111:104]; end
					 else begin isCall <= 1'b1; end

					 28 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[103: 96]; end
					 else begin isCall <= 1'b1; end
					 
					 29 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 95: 88]; end
					 else begin isCall <= 1'b1; end

					 30 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 87: 80]; end
					 else begin isCall <= 1'b1; end

					 31 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 79: 72]; end
					 else begin isCall <= 1'b1; end

					 32 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 71: 64]; end
					 else begin isCall <= 1'b1; end

					 33 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 63: 56]; end
					 else begin isCall <= 1'b1; end

					 34 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 55: 48]; end
					 else begin isCall <= 1'b1; end

					 35 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 47: 40]; end
					 else begin isCall <= 1'b1; end

					 36 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 39: 32]; end
					 else begin isCall <= 1'b1; end

					 37 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 31: 24]; end
					 else begin isCall <= 1'b1; end

					 38 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 23: 16]; end
					 else begin isCall <= 1'b1; end

					 39 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[ 15:  8]; end
					 else begin isCall <= 1'b1; end

					 40 :
					 if( iDone ) begin isCall <= 1'b0; i <= i + 1'b1;D1 <= line_rom2[  7:  0]; end
					 else begin isCall <= 1'b1; end//


					 41:
					 i <= 8'd7;
		endcase

	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oDATA = D1;

endmodule
