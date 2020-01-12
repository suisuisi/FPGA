//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 21:06:32
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-07 17:28:02
//# Description: 
//# @Modification History: 2019-05-19 20:58:19
//# Date			    By			   VerDATAn			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:19
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module lcd_funcmod
(
    input CLOCK, RST_n,

	//lcd1602 interface
	output 				LCD_RS,		//H: Data; L: Instruction code
	output				LCD_RW,		//H: Read; L: Write
	output  			LCD_EN,		//LCD1602 Chip enable signal
	output		[7:0]	LCD_D,		//LCD1602 Data interface

	input		[127:0]	line_rom1,	//LCD1602 1th row display
	input		[127:0]	line_rom2,	//LCD1602 2th row display
	input		[127:0]	line_rom3,	//LCD1602 2th row display
	input		[127:0]	line_rom4,	//LCD1602 2th row display
	//Signal
	input iCall,
	output oDone
);	 
	 parameter DELAY_TIME = 1000_000;   //Delay for 20ms
	 //localparam DELAY_TIME = 20'd1000;		//Just for test
	 parameter FCLK = 20'd100_000, FHALF = 20'd50_000; // 500hz,(1/500hz)/(1/50Mhz) FCLK 为一个周期
	 //localparam FCLK = 20'd100, FHALF = 20'd50;        //Just for test
	 parameter FF_Write = 8'd125;//FHALF 为半周期  //tsp1的延时
	 //localparam FF_Write = 20'd16;        //Just for test
	
	 
	 assign LCD1602_RW=1'b0;
	 reg [19:0]C1,C2;
    reg [7:0]i,Go;
	 reg [7:0]T; //D1 为暂存读取结果 T 为伪函数的操作空间
	 reg rRS, rEN; 
	 reg [7:0]rDATA;
	 reg isDone; //isQ 为 IO 的控制输出
	 
//LCD1602 init
localparam	DISP_SET	= 	8'h30;	//Display mode: Set 16X2,5X8, 8 bits data
localparam 	DISP_OFF	= 	8'h08;	//Display off
localparam 	CLR_SCR 	= 	8'h01;	//Clear the LCD
localparam 	CURSOR_SET1 = 	8'h06;	//Set Cursor
localparam 	CURSOR_SET2 = 	8'h0C;	//Display on
//Display 1th line	
localparam 	ROW1_ADDR	= 	8'h80;	//Line1's first address	

//Display 2th line
localparam 	ROW2_ADDR	= 	8'h90;	//Line2's first address	

//Display 3th line
localparam 	ROW3_ADDR	= 	8'h88;	//Line3's first address	

//Display 4th line
localparam 	ROW4_ADDR	= 	8'h98;	//Line4's first address	

    always @ ( posedge CLOCK or negedge RST_n )	
	     if( !RST_n )
		      begin
				    { C1,C2 } <={ 20'd0,20'd0 };
				    { i,Go } <= { 8'd0,8'd0 };
					 T  <= 8'd0;
					 { rRS, rEN, rDATA } <= 3'b000;
					  isDone <= 1'b0;
				end
/***********************************************************************
下面步骤是写一个字节的伪函数。步骤 0 拉高片选，准备访问字节，并且进入伪函数。
步骤 1 准备写入数据并且进入伪函数。
步骤 2 拉低片选，步骤 3~4 则是用来产生完成信号。
***********************************************************************/
		   else if( iCall )
			    case( i )
				     
					0://延时20ms
					    begin 
					    	{ rRS,rEN } <= 2'b01; 
					  		if( C2 == DELAY_TIME -1) begin C2 <= 20'd0; i <= i + 1'b1; end
							else C2 <= C2 + 1'b1;
					    end
				
					1:
					    begin  rRS <=1'b0;i <= i + 1'b1; end //{ rRS,rEN } <= 2'b01;
						 
					2:
					    begin T <= 8'h00; i <= FF_Write; Go <= i + 1'b1; end   //IDLE

					3:
					    begin T <= DISP_SET; i <= FF_Write; Go <= i + 1'b1; end

					4:
					    begin T <= DISP_OFF; i <= FF_Write; Go <= i + 1'b1; end

					5:
					    begin T <= CLR_SCR; i <= FF_Write; Go <= i + 1'b1; end

					6:
					    begin T <= CURSOR_SET1; i <= FF_Write; Go <= i + 1'b1; end

					7:
						 begin T <= CURSOR_SET2; i <= FF_Write; Go <= i + 1'b1; end
						
						
					8:
					    begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					9:
					    begin isDone <= 1'b0; i <= i + 1'b1; end

					10:
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					11:
						 begin T <= ROW1_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					12:
					    begin rRS <=1'b1; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
						 
					13:
						 begin T <= line_rom1[127:120]; i <= FF_Write; Go <= i + 1'b1; end
					14:
						 begin T <= line_rom1[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					15:
						 begin T <= line_rom1[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					16:
						 begin T <= line_rom1[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					17:
						 begin T <= line_rom1[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					18:
						 begin T <= line_rom1[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					19:
						 begin T <= line_rom1[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					20:
						 begin T <= line_rom1[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					21:
						 begin T <= line_rom1[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					22:
						 begin T <= line_rom1[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					23:
						 begin T <= line_rom1[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					24:
						 begin T <= line_rom1[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					25:
						 begin T <= line_rom1[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					26:
						 begin T <= line_rom1[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					27:
						 begin T <= line_rom1[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					28:
						 begin T <= line_rom1[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end

				    /**********************************************************************/
					29:
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					30:
						 begin T <= ROW2_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					31:
					    begin  rRS <=1'b1;i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
				    32:
						i <= i + 1'b1;
					33:
						begin T <= line_rom2[127:120]; i <= FF_Write; Go <= i + 1'b1; end
				    34:
						begin T <= line_rom2[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					35:
						begin T <= line_rom2[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					36:
						begin T <= line_rom2[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					37:
						begin T <= line_rom2[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					38:
						begin T <= line_rom2[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					39:
						begin T <= line_rom2[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					40:
						begin T <= line_rom2[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					41:
						begin T <= line_rom2[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					42:
						begin T <= line_rom2[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					43:
						begin T <= line_rom2[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					44:
						begin T <= line_rom2[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					45:
						begin T <= line_rom2[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					46:
						begin T <= line_rom2[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					47:
						begin T <= line_rom2[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					48:
						begin T <= line_rom2[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end//Go <= i + 1'b1;
					49:
					    begin { rRS,rEN } <= 2'b01; i <= i + 1'b1; end 

					50:
					  begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					51:
					  begin isDone <= 1'b0; i <= i + 1'b1; end//
					  
/************				**********************************************************/
					52:
						begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					53:
						begin T <= ROW3_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					54:
						begin  rRS <=1'b1;i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
				    55:
						i <= i + 1'b1;
					56:
						begin T <= line_rom3[127:120]; i <= FF_Write; Go <= i + 1'b1; end
				    57:
						begin T <= line_rom3[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					58:
						begin T <= line_rom3[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					59:
						begin T <= line_rom3[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					60:
						begin T <= line_rom3[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					61:
						begin T <= line_rom3[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					62:
						begin T <= line_rom3[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					63:
						begin T <= line_rom3[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					64:
						begin T <= line_rom3[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					65:
						begin T <= line_rom3[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					66:
						begin T <= line_rom3[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					67:
						begin T <= line_rom3[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					68:
						begin T <= line_rom3[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					69:
						begin T <= line_rom3[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					70:
						begin T <= line_rom3[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					71:
						begin T <= line_rom3[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end//Go <= i + 1'b1;
					72:
					   begin { rRS,rEN } <= 2'b01; i <= i + 1'b1; end 
					73:i <= i + 1'b1;

					74:
						begin isDone <= 1'b1; i <= i + 1'b1; end
						
					75:
						begin isDone <= 1'b0; i <= i + 1'b1; end//

/***************			*******************************************************/
					76:
						begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					77:
						begin T <= ROW4_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					78:
						begin  rRS <=1'b1;i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
				    79:
						i <= i + 1'b1;
					80:
						begin T <= line_rom4[127:120]; i <= FF_Write; Go <= i + 1'b1; end
				    81:
						begin T <= line_rom4[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					82:
						begin T <= line_rom4[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					83:
						begin T <= line_rom4[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					84:
						begin T <= line_rom4[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					85:
						begin T <= line_rom4[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					86:
						begin T <= line_rom4[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					87:
						begin T <= line_rom4[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					88:
						begin T <= line_rom4[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					89:
						begin T <= line_rom4[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					90:
						begin T <= line_rom4[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					91:
						begin T <= line_rom4[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					92:
						begin T <= line_rom4[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					93:
						begin T <= line_rom4[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					94:
						begin T <= line_rom4[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					95:
						begin T <= line_rom4[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end//Go <= i + 1'b1;
					96:
						begin { rRS,rEN } <= 2'b01; i <= i + 1'b1; end 

					97:
						begin isDone <= 1'b1; i <= i + 1'b1; end
					
					98:
						begin isDone <= 1'b0; i <= 8'd10; end//					  	

					  /******************/
					  
					125:
					  begin

					      rDATA <= T;//
							
						if( C1 == 0 ) rEN <= 1'b1;
 					    else if( C1 == FHALF ) rEN <= 1'b0;
					  
					    if( C1 == FCLK -1) begin C1 <= 20'd0; i <= i + 1'b1; end
						else C1 <= C1 + 1'b1;
					  end
					  
					126:
					  i <= Go;
					  
				 endcase
       
/***********************************************************************
以下内容为相关输出驱动声明，其中 rDATA 驱动 LCD1602_D_DATA， D 驱动 oData	。
***********************************************************************/
		assign { LCD_RS,LCD_EN } = { rRS,rEN };
		assign LCD_D = rDATA ;  //isQ ? rDATA : 1'bz;
		assign oDone = isDone;

endmodule