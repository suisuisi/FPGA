//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-07-02 20:46:20
//****************************************//
`timescale 1ns/ 1ps
module spi
(
    input CLOCK, RST_n,// 全局时钟50MHz/复位信号，低电平有效
    input               I_rx_en     , // 读使能信号
    input               I_tx_en     , // 发送使能信号
    input        [7:0]  iData   , // 要发送的数据
    output  reg  [7:0]  oData  , // 接收到的数据
    output  reg         iDone   , // 发送一个字节完毕标志位
    output  reg         oDone   , // 接收一个字节完毕标志位
    
    // 四线标准SPI信号定义
    input               I_spi_miso  , // SPI串行输入，用来接收从机的数据
    output  reg         O_spi_sck   , // SPI时钟
    output  reg         O_spi_cs    , // SPI片选信号
    output  reg         O_spi_mosi    // SPI输出，用来给从机发送数据
);
//****************************************//

reg [3:0]   R_tx_state      ; 
reg [3:0]   R_rx_state      ;

//****************************************//
always @(posedge CLOCK or negedge RST_n)
begin
    if(!RST_n)
        begin
            R_tx_state  <=  4'd0    ;
            R_rx_state  <=  4'd0    ;
            O_spi_cs    <=  1'b1    ;
            O_spi_sck   <=  1'b0    ;
            O_spi_mosi  <=  1'b0    ;
            iDone   <=  1'b0    ;
            oDone   <=  1'b0    ;
            oData  <=  8'd0    ;
        end 
    else if(I_tx_en) // 发送使能信号打开的情况下
        begin
            O_spi_cs    <=  1'b0    ; // 把片选CS拉低
            case(R_tx_state)
                4'd1, 4'd3 , 4'd5 , 4'd7  , 
                4'd9, 4'd11, 4'd13, 4'd15 : //整合奇数状态
                    begin
                        O_spi_sck   <=  1'b1                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end
                4'd0:    // 发送第7位
                    begin
                        O_spi_mosi  <=  iData[7]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end
                4'd2:    // 发送第6位
                    begin
                        O_spi_mosi  <=  iData[6]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end
                4'd4:    // 发送第5位
                    begin
                        O_spi_mosi  <=  iData[5]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end 
                4'd6:    // 发送第4位
                    begin
                        O_spi_mosi  <=  iData[4]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end 
                4'd8:    // 发送第3位
                    begin
                        O_spi_mosi  <=  iData[3]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end                            
                4'd10:    // 发送第2位
                    begin
                        O_spi_mosi  <=  iData[2]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end 
                4'd12:    // 发送第1位
                    begin
                        O_spi_mosi  <=  iData[1]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b0                ;
                    end 
                4'd14:    // 发送第0位
                    begin
                        O_spi_mosi  <=  iData[0]        ;
                        O_spi_sck   <=  1'b0                ;
                        R_tx_state  <=  R_tx_state + 1'b1   ;
                        iDone   <=  1'b1                ;
                    end
                default:R_tx_state  <=  4'd0                ;   
            endcase 
        end
    else if(I_rx_en) // 接收使能信号打开的情况下
        begin
            O_spi_cs    <=  1'b0        ; // 拉低片选信号CS
            case(R_rx_state)
                4'd0, 4'd2 , 4'd4 , 4'd6  ,  4'd8, 4'd10, 4'd12, 4'd14 : //整合偶数状态
                    begin
                        O_spi_sck   <=  1'b0;
                        R_rx_state  <=  R_rx_state + 1'b1;
                        oDone   <=  1'b0;
                    end
                4'd1:    // 接收第7位
                    begin                       
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b0                ;
                        oData[7]   <=  I_spi_miso          ;   
                    end
                4'd3:    // 接收第6位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b0                ;
                        oData[6]   <=  I_spi_miso          ; 
                    end
                4'd5:    // 接收第5位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b0                ;
                        oData[5]   <=  I_spi_miso          ; 
                    end 
                4'd7:    // 接收第4位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b0                ;
                        oData[4]   <=  I_spi_miso          ; 
                    end 
                4'd9:    // 接收第3位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b0                ;
                        oData[3]   <=  I_spi_miso          ; 
                    end                            
                4'd11:    // 接收第2位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b0                ;
                        oData[2]   <=  I_spi_miso          ; 
                    end 
                4'd13:    // 接收第1位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b0                ;
                        oData[1]   <=  I_spi_miso          ; 
                    end 
                4'd15:    // 接收第0位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        R_rx_state      <=  R_rx_state + 1'b1   ;
                        oDone       <=  1'b1                ;
                        oData[0]   <=  I_spi_miso          ; 
                    end
                default:R_rx_state  <=  4'd0                    ;   
            endcase 
        end    
    else
        begin
            R_tx_state  <=  4'd0    ;
            R_rx_state  <=  4'd0    ;
            iDone   <=  1'b0    ;
            oDone   <=  1'b0    ;
            O_spi_cs    <=  1'b1    ;
            O_spi_sck   <=  1'b0    ;
            O_spi_mosi  <=  1'b0    ;
            oData  <=  8'd0    ;
        end      
end

endmodule