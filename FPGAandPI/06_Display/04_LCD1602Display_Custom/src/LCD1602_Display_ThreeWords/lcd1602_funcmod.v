//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 21:06:32
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-30 22:59:30
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
reg [7:0] data_character2 [7:0];    //节           01H
reg [7:0] data_character3 [7:0];   //日           02H
always @(posedge CLOCK )
begin
    data_character1[0] <= 8'h00;
    data_character1[1] <= 8'h00;
    data_character1[2] <= 8'h00;
    data_character1[3] <= 8'h0a;
    data_character1[4] <= 8'h15;
    data_character1[5] <= 8'h0a;
    data_character1[6] <= 8'h04;
    data_character1[7] <= 8'h00;
	 
    data_character2[0] <= 8'h04;
    data_character2[1] <= 8'h14;
    data_character2[2] <= 8'h1f;
    data_character2[3] <= 8'h14;
    data_character2[4] <= 8'h0e;
    data_character2[5] <= 8'h04;
    data_character2[6] <= 8'h1f;
    data_character2[7] <= 8'h00;
	
    data_character3[0] <= 8'h00;
    data_character3[1] <= 8'h1F;
    data_character3[2] <= 8'h11;
    data_character3[3] <= 8'h11;
    data_character3[4] <= 8'h1f;
    data_character3[5] <= 8'h11;
    data_character3[6] <= 8'h11;
    data_character3[7] <= 8'h1f;
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
						 i <= i + 1'b1;//begin T <= CGRAM_SET; i <= FF_Write; Go <= i + 1'b1; end
					12:
						 begin T <= CGRAM_SET; i <= FF_Write; Go <= i + 1'b1; end	//CGRAM0_ADDR					
					13:
					    begin rRS <=1'b1; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;

					14,15,16,17,18,19,20,21 :
						 begin T <= data_character1[i-14]; i <= FF_Write; Go <= i + 1'b1; end

					22://write CGRAM
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;CGRAM_SET 
					23:
						 begin T <= CGRAM0_ADDR; i <= FF_Write; Go <= i + 1'b1; end						
					24:
					    begin rRS <=1'b1; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
					25,26,27,28,29,30,31,32 :
						 begin T <= data_character2[i-25]; i <= FF_Write; Go <= i + 1'b1; end

					33://write CGRAM
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;CGRAM_SET 
					34:
						 begin T <= CGRAM1_ADDR; i <= FF_Write; Go <= i + 1'b1; end						
					35:
					    begin rRS <=1'b1; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
					36,37,38,39,40,41,42,43 :
						 begin T <= data_character3[i-36]; i <= FF_Write; Go <= i + 1'b1; end

					44:
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					45:
						 begin T <= ROW1_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					46:
					    begin rRS <=1'b1; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
						 
					47:
						 begin T <= line_rom1[127:120]; i <= FF_Write; Go <= i + 1'b1; end
					48:
						 begin T <= line_rom1[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					49:
						 begin T <= line_rom1[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					50:
						 begin T <= line_rom1[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					51:
						 begin T <= line_rom1[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					52:
						 begin T <= line_rom1[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					53:
						 begin T <= line_rom1[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					54:
						 begin T <= line_rom1[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					55:
						 begin T <= line_rom1[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					56:
						 begin T <= line_rom1[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					57:
						 begin T <= line_rom1[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					58:
						 begin T <= line_rom1[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					59:
						 begin T <= line_rom1[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					60:
						 begin T <= line_rom1[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					61:
						 begin T <= line_rom1[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					62:
						 begin T <= line_rom1[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end

				    /**********************************************************************/
					63:
					    begin rRS <=1'b0; i <= i + 1'b1; end//{ rRS,rEN } <= 2'b00;
					64:
						 begin T <= ROW2_ADDR; i <= FF_Write; Go <= i + 1'b1; end
					65:
					    begin  rRS <=1'b1;i <= i + 1'b1; end//{ rRS,rEN } <= 2'b11;
				   66:
						i <= i + 1'b1;
					67:
						begin T <= line_rom2[127:120]; i <= FF_Write; Go <= i + 1'b1; end
				   68:
						begin T <= line_rom2[119:112]; i <= FF_Write; Go <= i + 1'b1; end
					69:
						begin T <= line_rom2[111:104]; i <= FF_Write; Go <= i + 1'b1; end							
					70:
						begin T <= line_rom2[103: 96]; i <= FF_Write; Go <= i + 1'b1; end
					71:
						begin T <= line_rom2[ 95: 88]; i <= FF_Write; Go <= i + 1'b1; end
					72:
						begin T <= line_rom2[ 87: 80]; i <= FF_Write; Go <= i + 1'b1; end
					73:
						begin T <= line_rom2[ 79: 72]; i <= FF_Write; Go <= i + 1'b1; end
					74:
						begin T <= line_rom2[ 71: 64]; i <= FF_Write; Go <= i + 1'b1; end
					75:
						begin T <= line_rom2[ 63: 56]; i <= FF_Write; Go <= i + 1'b1; end
					76:
						begin T <= line_rom2[ 55: 48]; i <= FF_Write; Go <= i + 1'b1; end
					77:
						begin T <= line_rom2[ 47: 40]; i <= FF_Write; Go <= i + 1'b1; end
					78:
						begin T <= line_rom2[ 39: 32]; i <= FF_Write; Go <= i + 1'b1; end
					79:
						begin T <= line_rom2[ 31: 24]; i <= FF_Write; Go <= i + 1'b1; end
					80:
						begin T <= line_rom2[ 23: 16]; i <= FF_Write; Go <= i + 1'b1; end
					81:
						begin T <= line_rom2[ 15:  8]; i <= FF_Write; Go <= i + 1'b1; end
					82:
						begin T <= line_rom2[  7:  0]; i <= FF_Write; Go <= i + 1'b1; end//Go <= i + 1'b1;
					83:
					    begin { rRS,rEN } <= 2'b01; i <= i + 1'b1; end 

					84:
					  begin isDone <= 1'b1; i <= i + 1'b1; end
					  
					85:
					  begin isDone <= 1'b0; i <= 8'd44; end//
					  
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