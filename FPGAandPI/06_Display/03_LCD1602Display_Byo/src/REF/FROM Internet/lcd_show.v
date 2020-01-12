//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-25 20:44:54
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-25 20:45:32
//# Description: 
//# @Modification History: 2019-06-25 20:44:54
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-06-25 20:44:54
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
//module: lcd_show.v
//data:2014-04-30
//addr: kb129         
//info: this is all the lcd module ,can show 8 zhongwen .
module lcd_show(
        clk_LCD,
        rst,
        en,
        RS,
        RW,
        data
);
input        clk_LCD;  // 500Hz
input        rst;      
output     en,RS,RW;
output   reg  [7:0]  data;
reg                 RS,en_sel;
reg      [4:0]    disp_count;
reg      [4:0]   wrtie_count;
reg      [2:0]   num;
reg      [3:0]   state;
parameter   clear_lcd           = 4'b0000,                    //清屏并光标复位
                  set_disp_mode   = 4'b0001,                    //设置显示模式：8位2行5x7点阵   
                  disp_on             = 4'b0010,                   //显示器开、光标不显示、光标不允许闪烁
                      shift_down    = 4'b0011,                    //文字不动，光标自动右移
                    write_cgram    = 4'b0100,                    //写中文进入CGRAM，以显示中文  
                  write_data_first  = 4'b0101,                    //写入第一行显示的数据
             write_data_second  = 4'b0110,                    //写入第二行显示的数据
                                 idel     = 4'b0111;                    //空闲状态   
assign  RW = 1'b0;                            //RW=0时对LCD模块执行写操作
assign  en = en_sel ? clk_LCD : 1'b0;
   
reg [7:0] data_character  [7:0];    //this is 五   00H
reg [7:0] data_character2 [7:0];    //节           01H
reg [7:0] data_character3 [7:0];   //日           02H
always @(posedge clk_LCD )
begin
    data_character[0] <= 8'h00;
    data_character[1] <= 8'h1e;
    data_character[2] <= 8'h08;
    data_character[3] <= 8'h1e;
    data_character[4] <= 8'h0a;
    data_character[5] <= 8'h0a;
    data_character[6] <= 8'h1F;
    data_character[7] <= 8'h00;
    data_character2[0] <= 8'h0A;
    data_character2[1] <= 8'h1f;
    data_character2[2] <= 8'h0A;
    data_character2[3] <= 8'h1f;
    data_character2[4] <= 8'h05;
    data_character2[5] <= 8'h05;
    data_character2[6] <= 8'h05;
    data_character2[7] <= 8'h04;
    data_character3[0] <= 8'h00;
    data_character3[1] <= 8'h1F;
    data_character3[2] <= 8'h11;
    data_character3[3] <= 8'h11;
    data_character3[4] <= 8'h1f;
    data_character3[5] <= 8'h11;
    data_character3[6] <= 8'h11;
    data_character3[7] <= 8'h1f;
end

reg [7:0]     data_first_line      [15:0];  //first line show data
reg [7:0]     data_second_line [15:0];  //second line show data
always @(posedge clk_LCD )
begin
   data_first_line[0] <= 8'h54;
   data_first_line[1] <= 8'h6F;
   data_first_line[2] <= 8'h20;
   data_first_line[3] <= 8'h6d;
   data_first_line[4] <= 8'h79;
   data_first_line[5] <= 8'h20;
   data_first_line[6] <= 8'h66;
   data_first_line[7] <= 8'h72;
   data_first_line[8] <= 8'h69;
   data_first_line[9] <= 8'h65;
   data_first_line[10] <= 8'h6e;
   data_first_line[11] <= 8'h64;
   data_first_line[12] <= 8'h73;
   data_first_line[13] <= 8'h8a;
 data_second_line[1] <= 8'h00;
 data_second_line[2] <= 8'h2d;
 data_second_line[3] <= 8'h01;
 data_second_line[4] <= 8'h02;
 data_second_line[5] <= 8'h68;
 data_second_line[6] <= 8'h61;
 data_second_line[7] <= 8'h70;
 data_second_line[8] <= 8'h70;
 data_second_line[9] <= 8'h79;
end

always @(posedge clk_LCD or negedge rst)
begin
   if(!rst)
      begin
          state         <= clear_lcd;             //复位：清屏并光标复位  
          RS             <= 1'b0;                  //复位：RS=0时为写指令；                      
          data          <= 8'b0;                  //复位：使DB8总线输出全0
          en_sel        <= 1'b1;                  //复位：开启夜晶使能信号
          disp_count <= 5'b0;
                 num   <= 3'b0;
        wrtie_count <= 5'b0;
      end
   else
      case(state)
      clear_lcd:                               //初始化LCD模块
             begin          //清屏并光标复位
                state  <= set_disp_mode;
                data  <= 8'h01;               
             end
      set_disp_mode:        //设置显示模式：8位2行5x8点阵 
             begin
                state  <= disp_on;
                data  <= 8'h38;                              
             end
      disp_on:            //显示器开、光标不显示、光标不允许闪烁
             begin
                state  <= shift_down;
                data  <= 8'h0c;                           
             end
      shift_down:        //文字不动，光标自动右移 
            begin
                state  <= write_cgram;
                data  <= 8'h06;                         
            end
      write_cgram:       //写CGRAM
            begin
    case(num)
    0:begin
             data  <= 8'h40;        //the first character addr
             num   <= num+1;
             state <= write_cgram;
      end
    1:begin
             if(wrtie_count==8)
                  begin
                        data <= 8'h48;  //the second character addr
                        RS   <= 1'b0;
                        num  <= num+1;
                        state<= write_cgram;
                        wrtie_count <= 0;
                 end
           else
                 begin
                        data <= data_character[wrtie_count];
                        RS   <= 1'b1;
                        wrtie_count <= wrtie_count + 1'b1;
                        state     <= write_cgram;
                   end          
      end
    2:begin
            if(wrtie_count==8)
                  begin
                          data <= 8'h50;  //the second character addr
                          RS   <= 1'b0;
                          num  <= num+1;
                          state<= write_cgram;
                          wrtie_count <= 0;
                   end
             else
                   begin
                        data <= data_character2[wrtie_count];
                        RS   <= 1'b1;
                        wrtie_count <= wrtie_count + 1'b1;
                        state     <= write_cgram;
                 end      
      end
    3:begin
            if(wrtie_count==8)
                   begin
                           data <= 8'h80;  //the DDROM first line start addr
                           RS   <= 1'b0;

                           state<= write_data_first;
                          wrtie_count <= 0;
                   end
           else
                   begin
                         data <= data_character3[wrtie_count];
                         RS   <= 1'b1;
                         wrtie_count <= wrtie_count + 1'b1;
                        state     <= write_cgram;
                   end      
      end
       endcase
   end
      write_data_first:              //显示第一行                         
            begin
                if(disp_count == 14)                      
                    begin
                        data    <= 8'hc2;               
                        RS     <= 1'b0;
                        disp_count   <= 4'b0;
                        state    <= write_data_second;        
                    end
                else
                    begin
                        data    <= data_first_line[disp_count];
                        RS     <= 1'b1;                  
                        disp_count   <= disp_count + 1'b1;
                        state    <= write_data_first;
                    end
            end
      write_data_second:                      //显示第二行
            begin
                if(disp_count == 9)
                    begin
                        en_sel   <= 1'b0;
                        RS    <= 1'b0;
                        disp_count  <= 4'b0;
                        state   <= idel;                     
                    end
                else
                    begin
                        data    <= data_second_line[disp_count+1];
                        RS     <= 1'b1;
                        disp_count   <= disp_count + 1'b1;
                        state    <= write_data_second;
                    end             
            end
      idel:            //写完进入空闲状态
            begin
                state <=  idel;             //在Idel状态循环 
            end
      default:  state <= clear_lcd;         //若state为其他值，则将state置为Clear_Lcd
      endcase
end
endmodule