//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-25 21:06:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-12-15 03:15:44
//# Description: 
//# @Modification History: 2017-10-07 01:34:59
//# Date                By             Version             Change Description: 
//# ========================================================================= #
//# 2017-10-07 01:34:59
//# ========================================================================= #
//# |                                                                       | #
//# |                                OpenFPGA                               | #
//****************************************************************************//

`timescale 1ns / 1ps

module MIG_BURST_IMAGE#
(
   parameter ADDR_WIDTH      = 28
)
(
	output      [27:0]      app_addr,
	output      [2:0]       app_cmd,
	output                	app_en,
	output      [255:0]     app_wdf_data,
	output             	    app_wdf_end,
	output                 	app_wdf_wren,
	
	input       [255:0]     app_rd_data,
	input            	app_rd_data_valid,
	input            	app_rdy,
	input            	app_wdf_rdy,
	input            	ui_clk,
	input            	ui_rst,
  
	//Sensor video 640x480p -CH0_FIFO
	input               CH0_FS_i,
	input               CH0_wclk_i,
	input               CH0_wren_i,
	input       [31:0]  CH0_data_i,//rgb565
   
	//vga/hdmi output -CH6_FIFO 
	input CH6_FS_i,
	input CH6_rclk_i,
	input CH6_rden_i,
	output[31:0]CH6_data_o
    );


    parameter [ADDR_WIDTH-1'b0:0]CH0_RANGE        =28'd921600;//写一副图像的地址空间 			             
    parameter [ADDR_WIDTH-1'b0:0]CH0_BASE_ADDR0    =28'd0;
    parameter [ADDR_WIDTH-1'b0:0]CH0_BASE_ADDR1    =28'd921600;
    parameter [ADDR_WIDTH-1'b0:0]CH0_BASE_ADDR2    =28'd921600*2;
    
    parameter [ADDR_WIDTH-1'b0:0]CH6_RANGE		    =28'd921600;//读一副图像的地址空间 				
    parameter [ADDR_WIDTH-1'b0:0]CH6_BASE_ADDR0    =28'd0;
    parameter [ADDR_WIDTH-1'b0:0]CH6_BASE_ADDR1    =28'd921600;
    parameter [ADDR_WIDTH-1'b0:0]CH6_BASE_ADDR2    =28'd921600*2;
    
    parameter PIXEL_H =8'd78;//一行像素 
    parameter RD_BURST_LEN =8'd80;//一次burst 80x256=640 个像素画 也就是一行数据   
    parameter WR_BURST_LEN =8'd80;//一次burst 80x256=640 个像素画 也就是一行数据      
            
    wire rst_n_i;
    assign rst_n_i = ~ui_rst;
    //-------------------------- 控制信息FIFO信号 ------------------------------//
    reg  MSG_FIFO_WREN=1'b0;
    reg  [7:0]MSG_FIFO_WRDATA=10'b0;
    wire MSG_FIFO_CLK;
    reg  MSG_FIFO_RDEN=1'b0;
    wire [7:0]MSG_FIFO_RDDATA;
    wire MSG_FIFO_FULL;  
    wire [4:0]MSG_FIFO_USEDW;
    
    //------------------------- Sensor FIFO信号 ------------------------//
    reg        CH0_rden=1'b0;
    wire[255:0]CH0_data_o;
    wire[7:0]  CH0_rusdw_o;
    wire       CH0_rclk_i;  
    //------------------------- VGA FIFO信号  --------------------------//    
    reg        CH6_wren=1'b0;
    wire[255:0]CH6_data_i;
    wire[7:0]  CH6_wusdw_o;
    wire       CH6_wclk_i;    
    
    reg    [2:0] CH_CS=3'b0;
    
    //----------------------- sdram状态机读写状态定义 -------------------------//    
    parameter [2:0]M_S_MSG_FIFO0    =8'd0;
    parameter [2:0]M_S_MSG_FIFO1    =8'd1;
    parameter [2:0]M_S_MSG_FIFO2    =8'd2;
    parameter [2:0]M_S_RST_FIFO0    =8'd3;
    parameter [2:0]M_S_IDLE         =8'd4;
    parameter [2:0]M_S_RD           =8'd5;
    parameter [2:0]M_S_WR           =8'd6;
    //-------------------------- FIFO读写时钟处理 ----------------------------//
    assign CH6_wclk_i =  ui_clk;
    assign CH0_rclk_i =  ui_clk;
    assign MSG_FIFO_CLK = ui_clk;
    
    reg[4:0]rst_tem = 5'd0;
    
    //--------------------------- 复位信号同步化 -----------------------------//
    always@(posedge ui_clk)
    begin
        rst_tem <= {rst_tem[3:0],rst_n_i};
    end
    
    //-------------------------ch0_fs信号同步化滤波------------------------//
    reg[19:0]CH0_CNT_FS  =20'b0;
    reg[19:0]CH0_CNT_FS_n=20'b0;
    reg[3:0] CH0_FS_TEM  =4'b0;
    reg CH0_FS=1'b0;
    //----ch0_in_fs信号缓存-------//
    always@(posedge ui_clk)
    begin
        if(!rst_tem[4])
            begin
            CH0_FS_TEM <= 4'hf;
            end
        else 
            begin
            CH0_FS_TEM <= {CH0_FS_TEM[2:0],CH0_FS_i};
            end
    end
    //----CH0_CNT_FS信号电平计数 实际就是采样VS信号-------//
    always@(posedge ui_clk)
    begin
        if(!rst_tem[4])
            begin    
            CH0_CNT_FS      <= 20'd0;
            CH0_CNT_FS_n <= 20'd0;
            end
        else if(CH0_FS_TEM[3])
            begin
            CH0_CNT_FS      <= (CH0_CNT_FS<20'd50)?(CH0_CNT_FS+20'd1):20'd50;
            CH0_CNT_FS_n <= 20'd0;
            end
        else if(!CH0_FS_TEM[3])
            begin
            CH0_CNT_FS_n <= (CH0_CNT_FS_n<20'd50)?(CH0_CNT_FS_n+20'd1):20'd50;
            CH0_CNT_FS     <= 20'd0;
            end
        else;
    end
    //----ch0_in_fs信号滤波后缓存-------//
    always@(posedge ui_clk)
    begin
        if(!rst_tem[4])
            begin
            CH0_FS <= 1'b1;
            end
        else if(CH0_CNT_FS>=20'd30)
            begin
            CH0_FS <= 1'b1;
            end
        else if(CH0_CNT_FS_n>=20'd30)
            begin
            CH0_FS <= 1'b0;
            end
        else;
    end
    
    //-------------------------ch6_fs信号同步化滤波------------------------//
    reg[19:0]CH6_CNT_FS     =20'b0;
    reg[19:0]CH6_CNT_FS_n=20'b0;
    reg[3:0] CH6_FS_TEM  =4'b0;
    reg CH6_FS=1'b0;
    //----ch0_in_fs信号缓存-------//
    always@(posedge ui_clk)
    begin
        if(!rst_tem[4])
            begin
            CH6_FS_TEM <= 4'hf;
            end
        else 
            begin
            CH6_FS_TEM <= {CH6_FS_TEM[2:0],CH6_FS_i};
            end
    end
    //----CH6_CNT_FS信号电平计数 实际就是采样VS信号-------//
    always@(posedge ui_clk)
    begin
        if(!rst_tem[4])
            begin    
            CH6_CNT_FS      <= 20'd0;
            CH6_CNT_FS_n <= 20'd0;
            end
        else if(CH6_FS_TEM[3])
            begin
            CH6_CNT_FS      <= (CH6_CNT_FS<20'd50)?(CH6_CNT_FS+20'd1):20'd50;
            CH6_CNT_FS_n <= 20'd0;
            end
        else if(!CH6_FS_TEM[3])
            begin
            CH6_CNT_FS_n <= (CH6_CNT_FS_n<20'd50)?(CH6_CNT_FS_n+20'd1):20'd50;
            CH6_CNT_FS     <= 20'd0;
            end
        else;
    end
    //----ch6_fs信号滤波后缓存-------//
    always@(posedge ui_clk)
    begin
        if(!rst_tem[4])
            begin
            CH6_FS <= 1'b1;
            end
        else if(CH6_CNT_FS>=20'd30)
            begin
            CH6_FS <= 1'b1;
            end
        else if(CH6_CNT_FS_n>=20'd30)
            begin
            CH6_FS <= 1'b0;
            end
        else;
    end
    //------------------------- fs信号缓存 --------------------------//
    reg CH0_FS_r=1'b0;
    reg CH6_FS_r=1'b0;
    always@(posedge ui_clk)
    begin
        CH0_FS_r    <=(!rst_tem[4])?1'd1:CH0_FS;
        CH6_FS_r    <=(!rst_tem[4])?1'd1:CH6_FS;
    end
    
    //-------------------------写控制信号进入MSG_FIFO--------------------------//
    always@(posedge ui_clk)
    begin
    if(!rst_tem[4])//--ddr校准完成--//    
            begin
            MSG_FIFO_WREN    <=1'd0;
            MSG_FIFO_WRDATA    <=8'd0;
            end
        else
            begin
            MSG_FIFO_WREN    <=
            (
                ({CH0_FS_r,CH0_FS}==2'b01)||
                ({CH6_FS_r,CH6_FS}==2'b01)
            );
            MSG_FIFO_WRDATA    <=
            {
                ({CH0_FS_r,CH0_FS}==2'b01),
                ({CH6_FS_r,CH6_FS}==2'b01),
                1'b0,
                1'b0,
                1'b0,
                1'b0,
                1'b0,
                1'b0 
            };
            end
    end
    
    reg CH0_REQ =1'b0;
    reg CH6_REQ =1'b0;
    
    //-------------------------数据缓存FIFO满状态标识-------------------------//
    always@(posedge ui_clk)
    begin
        CH0_REQ    <= (CH0_rusdw_o   >=PIXEL_H);//--大于等于一行可以读FIFO 写入DDR 这个参数可以调整         
        CH6_REQ    <=(CH6_wusdw_o    <=PIXEL_H);//--不满一行开始读DDR写入FIFO 这个参数可以调整--//
    end
    //-------------------------数据缓存FIFO复位信号--------------------------//
    reg    CH0_FIFO_RST=1'b1;    
    reg    CH6_FIFO_RST=1'b1;    
    
    reg    [7:0]M_S = 8'd0;      
    reg    [4:0]rst_FIFO_cnt=5'b0;
  
    reg  [7:0]count_rden =8'd0;
    reg  [7:0]count_wren =8'd0;
    
    reg [27:0]    CH0_PTR=28'd0;
    reg [27:0]    CH6_PTR=28'd0;

    //------------------------地址空间--------------------------//    
    reg [1:0]CH0_Frame_buf=2'd0;
    reg [1:0]CH6_Frame_buf=2'd0; 
    reg [27:0]CH0_BASE_ADDR;
    reg [27:0]CH6_BASE_ADDR;
    
   always@(*)  begin
     case(CH0_Frame_buf)
        0:begin
            CH0_BASE_ADDR <= CH0_BASE_ADDR0;
        end
        1:begin
            CH0_BASE_ADDR <= CH0_BASE_ADDR1;
        end    
        2:begin
            CH0_BASE_ADDR <= CH0_BASE_ADDR2;
        end
        default: begin
            CH0_BASE_ADDR <= CH0_BASE_ADDR0;
        end
      endcase       
   end 
   
    always@(*)  begin
     case(CH6_Frame_buf)
        0:begin
            CH6_BASE_ADDR <= CH6_BASE_ADDR0;
        end
        1:begin
            CH6_BASE_ADDR <= CH6_BASE_ADDR1;
        end    
        2:begin
            CH6_BASE_ADDR <= CH6_BASE_ADDR2;
        end
        default: begin
            CH6_BASE_ADDR <= CH6_BASE_ADDR0;
        end
      endcase       
   end 
    //-------------------------sdram状态机--------------------------//
    //--包含sdram读测试/sdram写测试/sdram突发读/sdram突发写 模块--//
    always@(posedge ui_clk)
    begin
    if(!rst_tem[4])
            begin
            M_S            <=M_S_MSG_FIFO0;
            MSG_FIFO_RDEN<=1'd0;
            CH0_FIFO_RST<=1'd0;
            CH6_FIFO_RST<=1'd0;
            rst_FIFO_cnt<=5'd0;
            count_rden    <=8'd0;
            count_wren    <=8'd0;    
            CH0_PTR       <=28'd0;
            CH6_PTR       <=28'd0;  
            CH0_Frame_buf <=2'd0;  
            CH6_Frame_buf <=2'd0;  
            end
    else case(M_S)
    //------------------------读取FIFO的控制信号-------------------------//
    M_S_MSG_FIFO0://--FIFO有数据就读取--//
        begin
        M_S             <=({MSG_FIFO_FULL,MSG_FIFO_USEDW}!=5'd0)?M_S_MSG_FIFO1:M_S_IDLE;
        MSG_FIFO_RDEN   <=({MSG_FIFO_FULL,MSG_FIFO_USEDW}!=5'd0);
        CH0_FIFO_RST    <=1'd0;
        CH6_FIFO_RST    <=1'd0;
        rst_FIFO_cnt    <=5'd0;
        count_rden      <=8'd0;
        count_wren      <=8'd0;
        end
        
    M_S_MSG_FIFO1://--延迟1个时钟--//
        begin
        M_S              <=M_S_MSG_FIFO2;
        MSG_FIFO_RDEN    <=1'd0;
        end
      
    M_S_MSG_FIFO2://--相对地址处理--//
        begin
        M_S                <=M_S_RST_FIFO0;
           if(MSG_FIFO_RDDATA[7])begin 
            if(CH0_Frame_buf==2'd2)      
            CH0_Frame_buf=2'd0;
         else 
            CH0_Frame_buf=CH0_Frame_buf+1'b1;
         end
        
        if(MSG_FIFO_RDDATA[6])begin
             if(CH0_Frame_buf==2'd0) 
                     CH6_Frame_buf<=2'd2;
             else 
                     CH6_Frame_buf<=CH0_Frame_buf-1'b1;
        end      
        
        CH0_PTR            <=MSG_FIFO_RDDATA[7]? 30'd0: CH0_PTR;
        CH6_PTR            <=MSG_FIFO_RDDATA[6]? 30'd0: CH6_PTR;
        end
        
    //------------------------读取FIFO的控制信号-------------------------//
    M_S_RST_FIFO0:        
        begin
        M_S             <=(rst_FIFO_cnt>=5'd20)?M_S_IDLE:M_S;
        CH6_FIFO_RST    <=(rst_FIFO_cnt<=5'd8)&&MSG_FIFO_RDDATA[6];
        CH0_FIFO_RST    <=(rst_FIFO_cnt<=5'd8)&&MSG_FIFO_RDDATA[7];
        rst_FIFO_cnt    <=rst_FIFO_cnt+5'd1;
        end
        
    //-------------------------状态机空闲状态--------------------------//
    M_S_IDLE:            
        begin    
        count_rden        <=8'd0;
        count_wren        <=8'd0;
        casex    ({//-读写通道仲裁-//
                CH0_REQ&&1'd1,//ch0_输入信道
                1'b0,//ch1_预留信道
                1'b0,//ch2_预留信道
                1'b0,//ch3_预留信道
                1'b0,//ch4_预留信道
                1'b0,//ch5_预留信道
                CH6_REQ&&1'd1//ch6_输出信道
                })
        7'b1??????:    //-Sensor写数据-//    
            begin
            M_S          <=M_S_WR;
            end    
        7'b0000001:    //-vga读数据-//    
            begin
            M_S           <=M_S_RD;
            end
        default:        
            begin
            M_S           <=M_S_MSG_FIFO0;
            end    
        endcase
        end                    
    //-------------------------sdram读状态--------------------------//
    M_S_RD: //--读取数据--//        
        begin
        CH6_PTR         <= app_rdy ?(CH6_PTR+28'd8) : CH6_PTR ;//每次写入的数据地址
        M_S             <= app_rdy&&(count_rden==RD_BURST_LEN-1'b1)?M_S_MSG_FIFO0:M_S; //释放本次写权限   
        count_rden      <= app_rdy ? count_rden+1'd1:count_rden;//count_rden用来标记一次burst的数据量
        end
    //-------------------------sdram写状态--------------------------//
    M_S_WR://--写入数据--//            
        begin
        CH0_PTR         <= app_rdy&&app_wdf_rdy? (CH0_PTR+28'd8) : CH0_PTR ;//每次写入的数据地址
        M_S             <=app_rdy&&app_wdf_rdy&&(count_wren==WR_BURST_LEN-1'b1)?M_S_MSG_FIFO0:M_S;//释放本次写权限
        count_wren      <=app_rdy&&app_wdf_rdy ? count_wren+1'd1:count_wren;//count_wren用来标记一次burst的数据量
        end        
    default:                
        begin
        M_S              <=M_S_MSG_FIFO0;
        count_rden       <=8'd0;
        count_wren       <=8'd0;
        end    
    endcase                        
    end

    //-------------------------------DDR接口-----------------------------------//
    parameter    [2:0]CMD_WRITE   =3'd0;//write cmd
    parameter    [2:0]CMD_READ    =3'd1;//read cmd
    
    wire CH0_rden_i;
    wire CH6_wren_i;  

    assign    app_wdf_end       =app_wdf_wren;//两个相等即可
    assign    app_en            =(M_S==M_S_WR) ? (app_rdy&app_wdf_rdy) : ((M_S==M_S_RD)&app_rdy);//控制命令使能
    assign    app_cmd           =(M_S==M_S_WR) ? CMD_WRITE : CMD_READ;//控制命令
    assign    app_addr          =(M_S==M_S_WR) ? (CH0_PTR+CH0_BASE_ADDR) : (CH6_PTR+CH6_BASE_ADDR);//读写地址切换
    assign    app_wdf_data      =CH0_data_o;//写入的数据是计数器
    assign    app_wdf_wren      =(M_S==M_S_WR)&app_rdy&app_wdf_rdy;//写使能
    assign    CH0_rden_i = app_wdf_wren; //CH0-FIFO 读使能
    assign    CH6_data_i = app_rd_data; // CH6-FIFO 写入的数据
    assign    CH6_wren_i = app_rd_data_valid;//CH6-FIFO 写使能
    
    //----------------控制消息fifo接口--------------------//
    //MS_FIFO 是我们设计的一个消息缓存，用来存储请求命令
    MSG_FIFO MSG_FIFO_INST (
     .clk(MSG_FIFO_CLK),    // input wire clk
     .din(MSG_FIFO_WRDATA), // input wire [9 : 0] din
     .wr_en(MSG_FIFO_WREN), // input wire wr_en
     .rd_en(MSG_FIFO_RDEN), // input wire rd_en
     .dout(MSG_FIFO_RDDATA),// output wire [9 : 0] dout
     .full(MSG_FIFO_FULL),  // output wire full
     .empty(empty),         // output wire empty
     .data_count(MSG_FIFO_USEDW) // output wire [4 : 0] data_count
    );
    //----------------Sensor fifo接口--------------------//
    wire CH0_empty;
    CH0_FIFO CH0_FIFO_INST (
    .rst(CH0_FIFO_RST),  // input wire rst
    .wr_clk(CH0_wclk_i), // input wire wr_clk
    .rd_clk(CH0_rclk_i),// input wire rd_clk
    .din(CH0_data_i), // input wire [31 : 0] din
    .wr_en(CH0_wren_i), // input wire wr_en
    .rd_en(CH0_rden_i), // input wire rd_en
    .dout(CH0_data_o),  // output wire [255 : 0] dout
    .full(),  // output wire full
    .empty(CH0_empty), // output wire empty
    .rd_data_count(CH0_rusdw_o)  // output wire [7 : 0] rd_data_count
    );
    //----------------CH6 fifo接口--------------------//
    CH6_FIFO CH6_FIFO_INST (
    .rst(CH6_FIFO_RST),   // input wire rst
    .wr_clk(CH6_wclk_i),   // input wire wr_clk
    .rd_clk(CH6_rclk_i),   // input wire rd_clk
    .din(CH6_data_i),      // input wire [255 : 0] din
    .wr_en(CH6_wren_i),    // input wire wr_en
    .rd_en(CH6_rden_i),    // input wire rd_en
    .dout(CH6_data_o),     // output wire [31 : 0] dout
    .full(),              // output wire full
    .empty(),            // output wire empty
    .rd_data_count(),  // output wire [10 : 0] rd_data_count
    .wr_data_count(CH6_wusdw_o)  // output wire [7 : 0] wr_data_count
    );
/*
//以下是debug信号 
ila_1 debug_inst1 (
	.clk(CH6_rclk_i), // input wire clk
	.probe0(CH6_data_o), // input wire [31:0]  probe0  
	.probe1(CH6_rden_i), // input wire [0:0]  probe1
	.probe2(CH6_FS_i) // input wire [0:0]  probe1
);

ila_0 debug_inst0 (
	.clk(ui_clk), // input wire clk
	.probe0(CH0_data_o), // input wire [255:0]  probe0  
	.probe1(CH6_data_i), // input wire [31:0]  probe1
	.probe2(CH6_wren_i),
	.probe3(app_en),
	.probe4(CH0_rusdw_o[6:0]),
	.probe5(app_wdf_rdy),
	.probe6(app_wdf_wren),
	.probe7(count_wren[6:0]),
	.probe8(app_rdy),
	.probe9(count_rden[6:0]),
	.probe10(M_S)
);	
*/
endmodule
