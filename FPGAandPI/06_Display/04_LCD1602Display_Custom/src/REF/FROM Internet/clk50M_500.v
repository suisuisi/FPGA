//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-25 20:45:54
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-25 20:46:23
//# Description: 
//# @Modification History: 2019-06-25 20:45:54
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-06-25 20:45:54
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
//data: 2014-04-28
//addr: kb129
//info: change the clk 50Mhz to 500Hz
module clk50M_500(
      clk_50M,
      rst,
      clk_500
 );
input         clk_50M;
input         rst;
output      clk_500;

reg    [8:0] cnt_1;
reg    [7:0] cnt_2;
reg           clk_500hz;
always@(posedge clk_50M)
begin
      if(!rst)
           begin
                 clk_500hz <= 0;
                     cnt_1   <= 0;
                     cnt_2   <= 0;
            end
 else if(cnt_2==8'd199)
            begin
                    cnt_2 <= 0;
                    if(cnt_1==9'd499)
                          begin
                                cnt_1   <= 0;
                                clk_500hz <= ~clk_500hz;
                           end
                  else
                         cnt_1   <= cnt_1+1;
             end
        else    cnt_2   <= cnt_2+1;
end 
assign clk_500 = clk_500hz;
endmodule