//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 21:06:32
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-01 21:19:16
//# Description: 
//# @Modification History: 2019-05-19 20:58:19
//# Date			    By			   VerDATAn			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:19
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module lcd1602_funcmod
(
    input CLOCK, RST_n,

	//lcd1602 interface
	output 				LCD1602_RS,		//H: Data; L: Instruction code
	output				LCD1602_RW,		//H: Read; L: Write
	output  			LCD1602_EN,		//LCD1602 Chip enable signal
	output		[7:0]	LCD1602_D,		//LCD1602 Data interface

	input		[127:0]	line_rom1,	//LCD1602 1th row display
	input		[127:0]	line_rom2,	//LCD1602 2th row display
	//Signal
	input iCall,
	output oDone
);	 
	 parameter DELAY_TIME = 1000_000;   //Delay for 20ms
	 //localparam DELAY_TIME = 20'd1000;		//Just for test
	 parameter FCLK = 20'd100_000, FHALF = 20'd50_000; // 500hz,(1/500hz)/(1/50Mhz) FCLK 为一个周期
	 //localparam FCLK = 20'd100, FHALF = 20'd50;        //Just for test
	 parameter FF_Write = 8'd120;//FHALF 为半周期  //tsp1的延时
	 //localparam FF_Write = 20'd16;        //Just for test

reg [7:0] data_character1  [7:0];    //this is 心形   00H
reg [7:0] data_character2 [7:0];    //生           01H
reg [7:0] data_character3 [7:0];   //日           02H
reg [7:0] data_character4 [7:0];   //年           03H
reg [7:0] data_character5 [7:0];   //月           04H
reg [7:0] data_character6 [7:0];   //三           05H
reg [7:0] data_character7 [7:0];   //坦克           06H
reg [7:0] data_character8 [7:0];   //节           07H


always @(posedge CLOCK )
begin
    data_character1[0] <= 8'h00;//this is 心形   00H
    data_character1[1] <= 8'h00;
    data_character1[2] <= 8'h00;
    data_character1[3] <= 8'h0a;
    data_character1[4] <= 8'h15;
    data_character1[5] <= 8'h0a;
    data_character1[6] <= 8'h04;
    data_character1[7] <= 8'h00;
	 
    data_character2[0] <= 8'h04;//生           01H
    data_character2[1] <= 8'h14;
    data_character2[2] <= 8'h1f;
    data_character2[3] <= 8'h14;
    data_character2[4] <= 8'h0e;
    data_character2[5] <= 8'h04;
    data_character2[6] <= 8'h1f;
    data_character2[7] <= 8'h00;
	
    data_character3[0] <= 8'h00;//日           02H
    data_character3[1] <= 8'h1F;
    data_character3[2] <= 8'h11;
    data_character3[3] <= 8'h11;
    data_character3[4] <= 8'h1f;
    data_character3[5] <= 8'h11;
    data_character3[6] <= 8'h11;
    data_character3[7] <= 8'h1f;

    data_character4[0] <= 8'h02;//年           03H
    data_character4[1] <= 8'h04;
    data_character4[2] <= 8'h0f;
    data_character4[3] <= 8'h12;
    data_character4[4] <= 8'h0f;
    data_character4[5] <= 8'h0a;
    data_character4[6] <= 8'h1f;
    data_character4[7] <= 8'h02;

    data_character5[0] <= 8'h0f;//月           04H
    data_character5[1] <= 8'h09;
    data_character5[2] <= 8'h0f;
    data_character5[3] <= 8'h09;
    data_character5[4] <= 8'h0f;
    data_character5[5] <= 8'h09;
    data_character5[6] <= 8'h09;
    data_character5[7] <= 8'h11;

    data_character6[0] <= 8'h00;//三           05H
    data_character6[1] <= 8'h1F;
    data_character6[2] <= 8'h00;
    data_character6[3] <= 8'h0e;
    data_character6[4] <= 8'h00;
    data_character6[5] <= 8'h1f;
    data_character6[6] <= 8'h00;
    data_character6[7] <= 8'h00;

    data_character7[0] <= 8'h00;//坦克           06H
    data_character7[1] <= 8'h04;
    data_character7[2] <= 8'h15;
    data_character7[3] <= 8'h0e;
    data_character7[4] <= 8'h1f;
    data_character7[5] <= 8'h0e;
    data_character7[6] <= 8'h11;
    data_character7[7] <= 8'h00;

    data_character8[0] <= 8'h0A;//节           07H
    data_character8[1] <= 8'h1f;
    data_character8[2] <= 8'h0A;
    data_character8[3] <= 8'h1f;
    data_character8[4] <= 8'h05;
    data_character8[5] <= 8'h05;
    data_character8[6] <= 8'h05;
    data_character8[7] <= 8'h04;

end
	
	 
	 assign LCD1602_RW=1'b0;
	 reg [19:0]C1,C2;
    reg [7:0]i,Go;
	 reg [7:0]T; //D1 为暂存读取结果 T 为伪函数的操作空间
	 reg rRS, rEN; 
	 reg [7:0]rDATA;
	 reg isDone; //isQ 为 IO 的控制输出
	 
//LCD1602 init
localparam	DISP_SET	= 	8'h38;	//Display mode: Set 16X2,5X8, 8 bits data
localparam 	DISP_OFF	= 	8'h08;	//Display off
localparam 	CLR_SCR 	= 	8'h01;	//Clear the LCD
localparam 	CURSOR_SET1 = 	8'h06;	//Set Cursor
localparam 	CURSOR_SET2 = 	8'h0C;	//Display on

//CGRAM 指令操作
localparam  CGRAM_SET  = 8'h40;

//CGRAM 00H address
localparam  CGRAM0_ADDR  = 8'h48;

//CGRAM 01H address
localparam  CGRAM1_ADDR  = 8'h50;

//CGRAM 02H address
localparam  CGRAM2_ADDR  = 8'h80;

//Display 1th line	
localparam 	ROW1_ADDR	= 	8'h80;	//Line1's first address	

//Display 2th line
localparam 	ROW2_ADDR	= 	8'hC0;	//Line2's first address	

    always @ ( posedge CLOCK or negedge RST_n )	
	     if( !RST_n )
		      begin
				    { C1,C2 } <={ 20'd0,20'd0 };
				    { i,Go } <= { 8'd0,6'd0 };
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

					10://write CGRAM
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;CGRAM_SET 
					11:
						begin T <= CGRAM_SET; i <= FF_Write; Go <= i + 1'b1; end	//CGRAM0_ADDR
					12:
						begin rRS <=1'b1; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;					
					13:
					    i <= i + 1'b1;

					14,15,16,17,18,19,20,21 ://write CGRAM0
						begin T <= data_character1[i-14]; i <= FF_Write; Go <= i + 1'b1; end
					22,23,24,25,26,27,28,29 ://write CGRAM1
					    begin T <= data_character2[i-22]; i <= FF_Write; Go <= i + 1'b1; end 
					30,31,32,33,34,35,36,37 ://write CGRAM2
					    begin T <= data_character3[i-30]; i <= FF_Write; Go <= i + 1'b1; end 
					38,39,40,41,42,43,44,45 ://write CGRAM3
					    begin T <= data_character4[i-38]; i <= FF_Write; Go <= i + 1'b1; end 
					46,47,48,49,50,51,52,53 ://write CGRAM4
					    begin T <= data_character5[i-46]; i <= FF_Write; Go <= i + 1'b1; end 
					54,55,56,57,58,59,60,61 ://write CGRAM5
					    begin T <= data_character6[i-54]; i <= FF_Write; Go <= i + 1'b1; end 
					62,63,64,65,66,67,68,69 ://write CGRAM6
					    begin T <= data_character7[i-62]; i <= FF_Write; Go <= i + 1'b1; end 
					70,71,72,73,74,75,76,77 ://write CGRAM7
					    begin T <= data_character8[i-70]; i <= FF_Write; Go <= i + 1'b1; end 

					78:
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					79:
						 begin T <= ROW1_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					80:
					    begin rRS <=1'b1; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
						 
					81:
						 begin T <= line_rom1[127:120]; i <= FF_Write; Go <= i + 1'b1; end
					82:
						 begin T <= line_rom1[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					83:
						 begin T <= line_rom1[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					84:
						 begin T <= line_rom1[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					85:
						 begin T <= line_rom1[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					86:
						 begin T <= line_rom1[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					87:
						 begin T <= line_rom1[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					88:
						 begin T <= line_rom1[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					89:
						 begin T <= line_rom1[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					90:
						 begin T <= line_rom1[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					91:
						 begin T <= line_rom1[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					92:
						 begin T <= line_rom1[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					93:
						 begin T <= line_rom1[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					94:
						 begin T <= line_rom1[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					95:
						 begin T <= line_rom1[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					96:
						 begin T <= line_rom1[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end

				    /**********************************************************************/
					97:
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					98:
						 begin T <= ROW2_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					99:
					    begin  rRS <=1'b1;i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
				    100:
						i <= i + 1'b1;
					101:
						begin T <= line_rom2[127:120]; i <= FF_Write; Go <= i + 1'b1; end
				    102:
						begin T <= line_rom2[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					103:
						begin T <= line_rom2[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					104:
						begin T <= line_rom2[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					105:
						begin T <= line_rom2[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					106:
						begin T <= line_rom2[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					107:
						begin T <= line_rom2[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					108:
						begin T <= line_rom2[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					109:
						begin T <= line_rom2[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					110:
						begin T <= line_rom2[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					111:
						begin T <= line_rom2[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					112:
						begin T <= line_rom2[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					113:
						begin T <= line_rom2[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					114:
						begin T <= line_rom2[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					115:
						begin T <= line_rom2[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					116:
						begin T <= line_rom2[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end//Go <= i + 1'b1;
					117:
					    begin { rRS,rEN } <= 2'b01; i <= i + 1'b1; end 

					118:
					  begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					119:
					  begin isDone <= 1'b0; i <= 8'd78; end//
					  
					  /******************/
					  
					  120:
					  begin

					      rDATA <= T;//
							
						if( C1 == 0 ) rEN <= 1'b1;
 					    else if( C1 == FHALF ) rEN <= 1'b0;
					  
					    if( C1 == FCLK -1) begin C1 <= 20'd0; i <= i + 1'b1; end
						else C1 <= C1 + 1'b1;
					  end
					  
					 121:
					  i <= Go;
					  
				 endcase
       
/***********************************************************************
以下内容为相关输出驱动声明，其中 rDATA 驱动 LCD1602_D_DATA， D 驱动 oData	。
***********************************************************************/
		assign { LCD1602_RS,LCD1602_EN } = { rRS,rEN };
		assign LCD1602_D = rDATA ;  //isQ ? rDATA : 1'bz;
		assign oDone = isDone;

endmodule