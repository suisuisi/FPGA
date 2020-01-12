`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    uarttx //
//////////////////////////////////////////////////////////////////////////////////
module uarttx(clk, datain, wrsig, idle, tx);
input clk;                //UART时钟
input [7:0] datain;       //需要发送的数据
input wrsig;              //发送命令，上升沿有效
output idle;              //线路状态指示，高为线路忙，低为线路空闲
output tx;                //发送数据信号
reg idle, tx;
reg send;
reg wrsigbuf, wrsigrise;
reg presult;
reg[7:0] cnt;             //计数器
parameter paritymode = 1'b0;

//检测发送命令是否有效
always @(posedge clk)
begin
   wrsigbuf <= wrsig;
   wrsigrise <= (~wrsigbuf) & wrsig;
end

always @(posedge clk)
begin
  if (wrsigrise &&  (~idle))  //当发送命令有效且线路为空闲时，启动新的数据发送进程
  begin
     send <= 1'b1;
  end
  else if(cnt == 8'd168)      //一帧资料发送结束
  begin
     send <= 1'b0;
  end
end

always @(posedge clk)
begin
  if(send == 1'b1)  begin
    case(cnt)                 //产生起始位
    8'd0: begin
         tx <= 1'b0;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd16: begin
         tx <= datain[0];    //发送数据0位
         presult <= datain[0]^paritymode;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd32: begin
         tx <= datain[1];    //发送数据1位
         presult <= datain[1]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd48: begin
         tx <= datain[2];    //发送数据2位
         presult <= datain[2]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd64: begin
         tx <= datain[3];    //发送数据3位
         presult <= datain[3]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd80: begin 
         tx <= datain[4];    //发送数据4位
         presult <= datain[4]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd96: begin
         tx <= datain[5];    //发送数据5位
         presult <= datain[5]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd112: begin
         tx <= datain[6];    //发送数据6位
         presult <= datain[6]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd128: begin 
         tx <= datain[7];    //发送数据7位
         presult <= datain[7]^presult;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd144: begin
         tx <= presult;      //发送奇偶校验位
         presult <= datain[0]^paritymode;
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd160: begin
         tx <= 1'b1;         //发送停止位             
         idle <= 1'b1;
         cnt <= cnt + 8'd1;
    end
    8'd168: begin
         tx <= 1'b1;             
         idle <= 1'b0;       //一帧资料发送结束
         cnt <= cnt + 8'd1;
    end
    default: begin
          cnt <= cnt + 8'd1;
    end
   endcase
  end
  else  begin
    tx <= 1'b1;
    cnt <= 8'd0;
    idle <= 1'b0;
  end
end
endmodule

