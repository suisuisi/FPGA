//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-25 20:46:38
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-25 20:48:58
//# Description: 
//# @Modification History: 2019-06-25 20:46:38
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-06-25 20:46:38
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module lcd_1602(
         CLOCK,
         RST_n,
         LCD1602_EN,
         LCD1602_RS,
         LCD1602_RW,
        LCD1602_D
 );
input      CLOCK;
input      RST_n;
output    LCD1602_EN;
output    LCD1602_RS;
output    LCD1602_RW;
output    [7:0] LCD1602_D;
wire        clk_500;
clk50M_500   u_clk50M_500
(
    .clk_50M(CLOCK),
    .rst(RST_n),
    .clk_500(clk_500)
 ); 
lcd_show u_lcd_show
(
     .clk_LCD(clk_500),
     .rst(RST_n),
     .en(LCD1602_EN),
     .RS(LCD1602_RS),
     .RW(LCD1602_RW),
     .data(LCD1602_D)
 );
 
endmodule