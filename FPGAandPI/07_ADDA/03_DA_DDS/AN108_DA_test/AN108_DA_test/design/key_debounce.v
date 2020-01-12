
//按键消抖模块

module key_debounce (

 input wire sclk,
 input wire rst_n,
 input wire key_in,
 
 output wire key_out
);

 parameter T100US = 13'd4_999;
 parameter T1MS   = 16'd49_999;
 
 reg [12:0] count1;
 reg count_r;
 reg en_r;
// reg h2l_sign_r;
 //reg l2h_sign_r;
 wire h2l_sign;
 wire l2h_sign;
 
 reg key_out_r;

 //--------------------------- detect module -----------------------------------
 
 always @ (posedge sclk,negedge rst_n)
    if (!rst_n) begin 
    	count1 <= 11'd0;
    	en_r <= 1'b0;
    end
    else if (count1 == T100US)  
    	en_r <= 1'b1;
    else count1 <= count1 + 1'b1;
    
 //==============================边沿检测========================================
 
 reg h2l_r1;
 reg h2l_r2;
 reg l2h_r1;
 reg l2h_r2;
 
 always @ (posedge sclk,negedge rst_n)
    if (!rst_n) 
       {h2l_r1,h2l_r2,l2h_r1,l2h_r2} <= 4'd0;
    else begin 
    	 h2l_r1 <= key_in;
    	 h2l_r2 <= h2l_r1;
    	 l2h_r1 <= key_in;
    	 l2h_r2 <= l2h_r1;
    end 

  
    assign h2l_sign = en_r? (h2l_r2 & !h2l_r1):1'b0; //negedge h2l_sign = 1
    assign l2h_sign = en_r? (l2h_r1 & !l2h_r2):1'b0;//posedge l2h_sign = 1
  
  
//=============================延时消抖============================================
//1ms延时
//count_r为反馈信号，检测到边沿之后，拉高该寄存器，使能延时计数器
 reg [15:0] count_1ms;
 always @ (posedge sclk,negedge rst_n)
  if (!rst_n) 
     count_1ms <= 16'd0;
  else if (count_r && count_1ms == T1MS) 
     count_1ms <= 16'd0;
  else if (count_r)
     count_1ms <= count_1ms + 1'b1; // 使能，延时开始
  else if (!count_r)
     count_1ms <= 16'd0;
  
 //10ms延时
 
 reg [3:0] count_10ms;
 
 always @ (posedge sclk,negedge rst_n)
  if (!rst_n)
     count_10ms <= 4'd0;
  else if (count_r && count_1ms == T1MS)
     count_10ms <= count_10ms + 1'b1;
  else if (!count_r)
     count_10ms <= 4'd0;
     
//===============================按键按下产生高脉冲===================================
 
 reg [1:0] i;
 
 always @ (posedge sclk,negedge rst_n)
  if (!rst_n) begin 
  	count_r <= 1'b0;
  	key_out_r <= 1'b0;
  	i <= 3'd0;
  end 
  else 
     case (i)
     2'd0: if (h2l_sign) //negedge
              i <= 2'd1; 
//           else if (l2h_sign) //posedge 
//              i <= 2'd2; 
              
     2'd1: if (count_10ms == 4'd10) begin //延时完成
     	        count_r <= 1'b0;
     	        key_out_r <= 1'b1;
     	        i <= 2'd0;end 
     	     else begin  
     	        count_r <= 1'b1;//检测到下降沿后，拉高pin_out
     	        key_out_r <= 1'b0;
     	      end 
     	        
     2'd2: if (count_10ms == 4'd10) begin //延时完成
     	        count_r <= 1'b0;
     	        key_out_r <= 1'b0;
     	        i <= 2'd0;end 
     	     else
     	        count_r <=  1'b1;
    
   endcase
 
 assign key_out = key_out_r;
   
endmodule 
