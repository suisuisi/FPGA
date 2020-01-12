//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-08-14 20:31:26
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-18 02:12:07
//# Description: 
//# @Modification History: 2019-08-14 20:43:45
//# Date                By             Version             Change Description: 
//# ========================================================================= #
//# 2019-08-14 20:43:45
//# ========================================================================= #
//# |                                                                       | #
//# |                                OpenFPGA                               | #
//****************************************************************************//
//flag_a,flag_d都是默认低电平有效的，flag_a是ep2的EF信号，flag_d是ep6的FF信号
//flag_a为低时表示ep2里的fifo为空，也就是没有数据过来，为高则表示非空，表示有数据过来了
//flag_d为低时表示ep6里的fifo写满了，这时cypress芯片就会自己打包数据然后去发送pc,为高则表示没有写满，表示可以往ep6的fifo里写数据
module  usb(
        input                   CLCOK                     ,
        input                   rst_n                   ,
        //usb interface
        input                   flag_d                  ,
        input                   flag_a                  ,
        output  reg             slwr                    ,
        output  reg             slrd                    ,
        output  reg             sloe                    ,
        output  wire            pktend                  ,
        output  wire            ifclk                   ,
        output  reg  [ 1: 0]    fifo_addr               ,
        inout   wire [15: 0]    usb_data                ,
        //receive cmd from pc
        output  wire            cmd_flag                ,
        output  wire  [15: 0]   cmd_data                
);
//=====================================================================\
// ********** Define Parameter and Internal Signals *************
//=====================================================================/
parameter   CNT_END     =       256                             ; 
parameter   IDLE        =       3'b001                          ;
parameter   READ        =       3'b010                          ;
parameter   WRITE       =       3'b100                          ;
reg     [ 2: 0]                 state_c  /*synthesis noprune*/  ;
reg     [ 2: 0]                 state_n  /*synthesis noprune*/  ; 
//cnt
reg     [ 7: 0]                 cnt                             ;
wire                            add_cnt                         ;
wire                            end_cnt                         ; 
//======================================================================
// ***************      Main    Code    ****************
//======================================================================
assign  ifclk       =       ~CLCOK;
assign  pktend      =       1'b1;
assign  usb_data    =       (state_c[2] == 1'b1) ? {cnt,8'h00} : 16'hzzzz;//先发送低字节，然后再发送高字节

//cnt  产生写usb数据，从0-255
always @(posedge CLCOK or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(add_cnt)begin
        if(end_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
    else begin
        cnt <= 0;
    end
end

assign  add_cnt     =       state_c[2];       
assign  end_cnt     =       add_cnt && cnt == 256-1;   

//state_c
always@(posedge CLCOK or negedge rst_n)begin
    if(!rst_n)begin
        state_c <= IDLE;
    end
    else begin
        state_c <= state_n;
    end
end

//state_n
always@(*)begin
    case(state_c)
        IDLE:begin
            if(flag_a == 1'b1)begin //ep2非空，说明有数据来了，进入读状态
                state_n = READ;
            end
            else if(flag_d == 1'b1)begin  //flag_d是EP6的FF，低有效，为高时表示该fifo现在空闲，往ep6写数据
                state_n = WRITE;
            end
            else begin
                state_n = state_c;
            end
        end
        READ:begin
            if(flag_a == 1'b0)begin //flag_a位低，说明数据已经读完了，进入空闲状态
                state_n = IDLE;
            end
            else begin
                state_n = state_c;
            end
        end
        WRITE:begin
            if(flag_d == 1'b0)begin  //flag_d为低，说明写满了，进入空闲状态，这时cypress自己就会把这些数据打包好，然后发送给pc，
                state_n = IDLE;
            end
            else begin
                state_n = state_c;
            end
        end
        default:begin
            state_n = IDLE;
        end
    endcase
end

//fifo_addr,sloe
always  @(posedge CLCOK or negedge rst_n)begin
    if(rst_n == 1'b0)begin
        fifo_addr   =   2'b10;
        sloe        =   1'b1;
    end
    else if(state_n[1])begin
        fifo_addr   =   2'b00;
        sloe        =   1'b0;
    end
    else begin
        fifo_addr   =   2'b10;
        sloe        =   1'b1;
    end
end

//slwr
always  @(posedge CLCOK or negedge rst_n)begin
    if(rst_n==1'b0)begin
        slwr    <=  1'b1;
    end
    else if(state_n[2])begin
        slwr    <=  1'b0;
    end
    else begin
        slwr    <=  1'b1;
    end
end

//slrd
always  @(posedge CLCOK or negedge rst_n)begin
    if(rst_n==1'b0)begin
        slrd    <=  1'b1;
    end
    else if(state_n[1])begin
        slrd    <=  1'b0;
    end
    else begin
        slrd    <=  1'b1;
    end
end

//cmd_flag
assign  cmd_flag    =   state_c[1] && flag_a;
assign  cmd_data    =   usb_data;

reg     [ 9: 0]                 cnt0    /*synthesis noprune*/   ;
wire                            add_cnt0                        ;
wire                            end_cnt0                        ;
//cnt0  用来标记读的数据的个数，注意数据是16位的
always @(posedge CLCOK or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1;
    end
    else begin
        cnt0 <= 0;
    end
end

assign  add_cnt0        =       cmd_flag;       
assign  end_cnt0        =       add_cnt0 && cnt0 == 1024-1;

endmodule