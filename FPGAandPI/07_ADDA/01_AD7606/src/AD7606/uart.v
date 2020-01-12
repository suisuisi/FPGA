`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module uart(
           input clk50,                     //50Mhz clock
			  input reset_n,
			  
			  input [19:0] ch1_dec,
			  input [19:0] ch2_dec,
			  input [19:0] ch3_dec,
			  input [19:0] ch4_dec,
			  input [19:0] ch5_dec,
			  input [19:0] ch6_dec,
			  input [19:0] ch7_dec,
			  input [19:0] ch8_dec,			  
				
           input [7:0] ch1_sig,
           input [7:0] ch2_sig,
           input [7:0] ch3_sig,
           input [7:0] ch4_sig,
           input [7:0] ch5_sig,
           input [7:0] ch6_sig,
           input [7:0] ch7_sig,
           input [7:0] ch8_sig,
			  

           output tx			  
    );


/********************************************/
//存储待发送的串口信息
/********************************************/
reg [7:0] uart_ad [113:0];                        //存储发送的ASIC字符

always @(clk)
begin     //定义发送的字符
   if(uart_stat==3'b000) begin
		 uart_ad[0]<=65;                           //存储字符 A 
		 uart_ad[1]<=68;                           //存储字符 D
		 uart_ad[2]<=49;                           //存储字符 1
		 uart_ad[3]<=58;                           //存储字符 : 
		 uart_ad[4]<=ch1_sig;                      //存储字符 正负   	 
		 uart_ad[5]<=ch1_dec[19:16] + 48;          //存储字符 个位                          
		 uart_ad[6]<=46;                           //存储字符 . 
		 uart_ad[7]<=ch1_dec[15:12] + 48;          //存储字符 小数点后一位
		 uart_ad[8]<=ch1_dec[11:8] + 48;           //存储字符 小数点后二位
		 uart_ad[9]<=ch1_dec[7:4] + 48;            //存储字符 小数点后三位
		 uart_ad[10]<=ch1_dec[3:0] + 48;            //存储字符 小数点后四位
		 uart_ad[11]<=86;                          //存储字符 V
		 uart_ad[12]<=32;                          //存储字符 空格
		 uart_ad[13]<=32;                          //存储字符 空格
		 
		 uart_ad[14]<=65;                           //存储字符 A 
		 uart_ad[15]<=68;                           //存储字符 D
		 uart_ad[16]<=50;                           //存储字符 2
		 uart_ad[17]<=58;                           //存储字符 : 
		 uart_ad[18]<=ch2_sig;                      //存储字符 正负   	 
		 uart_ad[19]<=ch2_dec[19:16] + 48;          //存储字符 个位                          
		 uart_ad[20]<=46;                           //存储字符 . 
		 uart_ad[21]<=ch2_dec[15:12] + 48;          //存储字符 小数点后一位
		 uart_ad[22]<=ch2_dec[11:8] + 48;           //存储字符 小数点后二位
		 uart_ad[23]<=ch2_dec[7:4] + 48;            //存储字符 小数点后三位
		 uart_ad[24]<=ch2_dec[3:0] + 48;            //存储字符 小数点后四位
		 uart_ad[25]<=86;                           //存储字符 V
		 uart_ad[26]<=32;                           //存储字符 空格
		 uart_ad[27]<=32;                           //存储字符 空格
		 
		 uart_ad[28]<=65;                           //存储字符 A 
		 uart_ad[29]<=68;                           //存储字符 D
		 uart_ad[30]<=51;                           //存储字符 3
		 uart_ad[31]<=58;                           //存储字符 : 
		 uart_ad[32]<=ch3_sig;                      //存储字符 正负   	 
		 uart_ad[33]<=ch3_dec[19:16] + 48;          //存储字符 个位                          
		 uart_ad[34]<=46;                           //存储字符 . 
		 uart_ad[35]<=ch3_dec[15:12] + 48;          //存储字符 小数点后一位
		 uart_ad[36]<=ch3_dec[11:8] + 48;           //存储字符 小数点后二位
		 uart_ad[37]<=ch3_dec[7:4] + 48;            //存储字符 小数点后三位
		 uart_ad[38]<=ch3_dec[3:0] + 48;            //存储字符 小数点后四位
		 uart_ad[39]<=86;                           //存储字符 V
		 uart_ad[40]<=32;                           //存储字符 空格
		 uart_ad[41]<=32;                           //存储字符 空格	 
		 
		 uart_ad[42]<=65;                           //存储字符 A 
		 uart_ad[43]<=68;                           //存储字符 D
		 uart_ad[44]<=52;                           //存储字符 4
		 uart_ad[45]<=58;                           //存储字符 : 
		 uart_ad[46]<=ch4_sig;                      //存储字符 正负   	 
		 uart_ad[47]<=ch4_dec[19:16] + 48;          //存储字符 个位                          
		 uart_ad[48]<=46;                           //存储字符 . 
		 uart_ad[49]<=ch4_dec[15:12] + 48;          //存储字符 小数点后一位
		 uart_ad[50]<=ch4_dec[11:8] + 48;           //存储字符 小数点后二位
		 uart_ad[51]<=ch4_dec[7:4] + 48;            //存储字符 小数点后三位
		 uart_ad[52]<=ch4_dec[3:0] + 48;            //存储字符 小数点后四位
		 uart_ad[53]<=86;                           //存储字符 V
		 uart_ad[54]<=32;                           //存储字符 空格
		 uart_ad[55]<=32;                           //存储字符 空格
		 
		 uart_ad[56]<=65;                           //存储字符 A 
		 uart_ad[57]<=68;                           //存储字符 D
		 uart_ad[58]<=53;                           //存储字符 5
		 uart_ad[59]<=58;                           //存储字符 : 
		 uart_ad[60]<=ch5_sig;                      //存储字符 正负   	 
		 uart_ad[61]<=ch5_dec[19:16] + 48;          //存储字符 个位                          
		 uart_ad[62]<=46;                           //存储字符 . 
		 uart_ad[63]<=ch5_dec[15:12] + 48;          //存储字符 小数点后一位
		 uart_ad[64]<=ch5_dec[11:8] + 48;           //存储字符 小数点后二位
		 uart_ad[65]<=ch5_dec[7:4] + 48;            //存储字符 小数点后三位
		 uart_ad[66]<=ch5_dec[3:0] + 48;            //存储字符 小数点后四位
		 uart_ad[67]<=86;                           //存储字符 V
		 uart_ad[68]<=32;                           //存储字符 空格
		 uart_ad[69]<=32;                           //存储字符 空格
		 
		 uart_ad[70]<=65;                           //存储字符 A 
		 uart_ad[71]<=68;                           //存储字符 D
		 uart_ad[72]<=54;                           //存储字符 6
		 uart_ad[73]<=58;                           //存储字符 : 
		 uart_ad[74]<=ch6_sig;                      //存储字符 正负   	 
		 uart_ad[75]<=ch6_dec[19:16] + 48;          //存储字符 个位                          
		 uart_ad[76]<=46;                           //存储字符 . 
		 uart_ad[77]<=ch6_dec[15:12] + 48;          //存储字符 小数点后一位
		 uart_ad[78]<=ch6_dec[11:8] + 48;           //存储字符 小数点后二位
		 uart_ad[79]<=ch6_dec[7:4] + 48;            //存储字符 小数点后三位
		 uart_ad[80]<=ch6_dec[3:0] + 48;            //存储字符 小数点后四位
		 uart_ad[81]<=86;                           //存储字符 V
		 uart_ad[82]<=32;                           //存储字符 空格
		 uart_ad[83]<=32;                           //存储字符 空格

		 uart_ad[84]<=65;                           //存储字符 A 
		 uart_ad[85]<=68;                           //存储字符 D
		 uart_ad[86]<=55;                           //存储字符 7
		 uart_ad[87]<=58;                           //存储字符 : 
		 uart_ad[88]<=ch7_sig;                      //存储字符 正负   	 
		 uart_ad[89]<=ch7_dec[19:16] + 48;          //存储字符 个位                          
		 uart_ad[90]<=46;                           //存储字符 . 
		 uart_ad[91]<=ch7_dec[15:12] + 48;          //存储字符 小数点后一位
		 uart_ad[92]<=ch7_dec[11:8] + 48;           //存储字符 小数点后二位
		 uart_ad[93]<=ch7_dec[7:4] + 48;            //存储字符 小数点后三位
		 uart_ad[94]<=ch7_dec[3:0] + 48;            //存储字符 小数点后四位
		 uart_ad[95]<=86;                           //存储字符 V
		 uart_ad[96]<=32;                           //存储字符 空格
		 uart_ad[97]<=32;                           //存储字符 空格	

		 uart_ad[98]<=65;                           //存储字符 A 
		 uart_ad[99]<=68;                           //存储字符 D
		 uart_ad[100]<=56;                          //存储字符 8
		 uart_ad[101]<=58;                          //存储字符 : 
		 uart_ad[102]<=ch8_sig;                     //存储字符 正负   	 
		 uart_ad[103]<=ch8_dec[19:16] + 48;         //存储字符 个位                          
		 uart_ad[104]<=46;                          //存储字符 . 
		 uart_ad[105]<=ch8_dec[15:12] + 48;         //存储字符 小数点后一位
		 uart_ad[106]<=ch8_dec[11:8] + 48;          //存储字符 小数点后二位
		 uart_ad[107]<=ch8_dec[7:4] + 48;           //存储字符 小数点后三位
		 uart_ad[108]<=ch8_dec[3:0] + 48;           //存储字符 小数点后四位
		 uart_ad[109]<=86;                          //存储字符 V
		 uart_ad[110]<=32;                          //存储字符 空格
		 uart_ad[111]<=32;                          //存储字符 空格		

		 uart_ad[112]<=10;                          //换行符
		 uart_ad[113]<=13;                          //回车符 
	end	 
end 

/********************************************/
//串口发送时间字符串
/********************************************/
reg [15:0] uart_cnt;
reg [2:0] uart_stat;

reg  [7:0]  txdata;             //串口发送字符
reg         wrsig;               //串口发送有效信号

reg [8:0] k;

reg [15:0] Time_wait;                  

always @(posedge clk )
begin
  if(!reset_n) begin   
		uart_cnt<=0;
		uart_stat<=3'b000;	
		k<=0;
  end
  else begin
  	 case(uart_stat)
	 3'b000: begin               
       if (Time_wait == 16'hffff) begin          //如果秒数据有变化
		    uart_stat<=3'b001; 
			 Time_wait<=0;
		 end
		 else begin
			 uart_stat<=3'b000; 
			 Time_wait<=Time_wait + 1'b1;
		 end
	 end	
	 3'b001: begin                        
         if (k == 113 ) begin          	//发送第112个字符 	 
				 if(uart_cnt ==0) begin
					txdata <= uart_ad[113]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                			
				 end	
				 else if(uart_cnt ==254) begin
					uart_cnt <= 0;
					wrsig <= 1'b0; 				
					uart_stat <= 3'b010; 
					k <= 0;
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig <= 1'b0;  
				 end
		 end
	    else begin                      //发送前111个字符 
				 if(uart_cnt ==0) begin      
					txdata <= uart_ad[k]; 
					uart_cnt <= uart_cnt + 1'b1;
					wrsig <= 1'b1;                			
				 end	
				 else if(uart_cnt ==254) begin
					uart_cnt <= 0;
					wrsig <= 1'b0; 
					k <= k + 1'b1;				
				 end
				 else	begin			
					 uart_cnt <= uart_cnt + 1'b1;
					 wrsig <= 1'b0;  
				 end
		 end	 
	 end
	 3'b010: begin       //发送finish	 
		 	uart_stat <= 3'b000; 
	 end
	 default:uart_stat <= 3'b000;
    endcase 
  end
end

/**********产生串口时钟***********/
clkdiv u0 (
		.clk50                   (clk50),                           
		.clkout                  (clk)             //串口发送时钟                 
 );

/*************串口发送程序************/
uarttx u1 (
		.clk                     (clk),                           
		.datain                  (txdata),
      .wrsig                   (wrsig), 
      .idle                    (idle), 	
	   .tx                      (tx)		
 );



endmodule
