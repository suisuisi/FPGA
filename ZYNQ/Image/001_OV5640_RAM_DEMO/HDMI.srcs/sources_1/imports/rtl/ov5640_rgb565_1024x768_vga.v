//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-25 21:06:02
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-11-25 21:27:55
//# Description: 
//# @Modification History: 2019-10-27 20:05:13
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-10-27 20:05:13 正点原子
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//

module ov5640_rgb565_1024x768_vga(    
    input                 sys_clk     ,  //ç³»ç»Ÿæ—¶é’Ÿ
    input                 sys_rst_n   ,  //ç³»ç»Ÿå¤ä½ï¼Œä½Žç”µå¹³æœ‰æ•ˆ
    //æ‘„åƒå¤´æŽ¥å?
    input                 cam_pclk    ,  //cmos æ•°æ®åƒç´ æ—¶é’Ÿ
    input                 cam_vsync   ,  //cmos åœºåŒæ­¥ä¿¡å?
    input                 cam_href    ,  //cmos è¡ŒåŒæ­¥ä¿¡å?
    input        [7:0]    cam_data    ,  //cmos æ•°æ® 
    output                 cam_xclk   ,//cmos input clk 
    //output                cam_rst_n   ,  //cmos å¤ä½ä¿¡å·ï¼Œä½Žç”µå¹³æœ‰æ•ˆ
    //output                cam_pwdn    ,  //cmos ç”µæºä¼‘çœ æ¨¡å¼é€‰æ‹©ä¿¡å·
    output                cam_scl     ,  //cmos SCCB_SCLçº?
    inout                 cam_sda     ,  //cmos SCCB_SDAçº?
    output                TMDS_Clk_p,    // output wire TMDS_Clk_p
    output                TMDS_Clk_n,    // output wire TMDS_Clk_n
    output      [2:0]     TMDS_Data_p,  // output wire [2 : 0] TMDS_Data_p
    output      [2:0]     TMDS_Data_n  // output wire [2 : 0] TMDS_Data_n
    
    );

//parameter define
parameter  SLAVE_ADDR = 7'h3c         ;  //OV5640çš„å™¨ä»¶åœ°å?7'h3c
parameter  BIT_CTRL   = 1'b1          ;  //OV5640çš„å­—èŠ‚åœ°å?ä¸?16ä½?  0:8ä½? 1:16ä½?
parameter  CLK_FREQ   = 26'd65_000_000;  //i2c_driæ¨¡å—çš„é©±åŠ¨æ—¶é’Ÿé¢‘çŽ? 65MHz
parameter  I2C_FREQ   = 18'd250_000   ;  //I2Cçš„SCLæ—¶é’Ÿé¢‘çŽ‡,ä¸è¶…è¿?400KHz
parameter  CMOS_H_PIXEL = 24'd1024    ;  //CMOSæ°´å¹³æ–¹å‘åƒç´ ä¸ªæ•°,ç”¨äºŽè®¾ç½®SDRAMç¼“å­˜å¤§å°
parameter  CMOS_V_PIXEL = 24'd768     ;  //CMOSåž‚ç›´æ–¹å‘åƒç´ ä¸ªæ•°,ç”¨äºŽè®¾ç½®SDRAMç¼“å­˜å¤§å°


//wire define
wire                  clk_100m        ;  //100mhzæ—¶é’Ÿ,SDRAMæ“ä½œæ—¶é’Ÿ
wire                  clk_100m_shift  ;  //100mhzæ—¶é’Ÿ,SDRAMç›¸ä½åç§»æ—¶é’Ÿ
wire                  clk_65m         ;  //65mhzæ—¶é’Ÿ,æä¾›ç»™IICé©±åŠ¨æ—¶é’Ÿå’Œvgaé©±åŠ¨æ—¶é’Ÿ
wire                  locked          ;
wire                  rst_n           ;

wire                  i2c_exec        ;  //I2Cè§¦å‘æ‰§è¡Œä¿¡å·
wire   [23:0]         i2c_data        ;  //I2Cè¦é…ç½®çš„åœ°å€ä¸Žæ•°æ?(é«?8ä½åœ°å?,ä½?8ä½æ•°æ?)          
wire                  cam_init_done   ;  //æ‘„åƒå¤´åˆå§‹åŒ–å®Œæˆ
wire                  i2c_done        ;  //I2Cå¯„å­˜å™¨é…ç½®å®Œæˆä¿¡å?
wire                  i2c_dri_clk     ;  //I2Cæ“ä½œæ—¶é’Ÿ
                                      
wire                  wr_en           ;  //sdram_ctrlæ¨¡å—å†™ä½¿èƒ?
wire   [15:0]         wr_data         ;  //sdram_ctrlæ¨¡å—å†™æ•°æ?
wire                  rd_en           ;  //sdram_ctrlæ¨¡å—è¯»ä½¿èƒ?
wire   [15:0]         rd_data         ;  //sdram_ctrlæ¨¡å—è¯»æ•°æ?
wire                  sys_init_done   ;  //ç³»ç»Ÿåˆå§‹åŒ–å®Œæˆ?(sdramåˆå§‹åŒ?+æ‘„åƒå¤´åˆå§‹åŒ–)

//*****************************************************
//**                    main code
//*****************************************************

wire [10:0] pixel_xpos;
wire [10:0] pixel_ypos;

parameter  CMOS_L_PIXEL = 11'd0     ;
parameter  CMOS_R_PIXEL = 11'd1023     ;
parameter  CMOS_T_PIXEL = 11'd0     ;
parameter  CMOS_B_PIXEL = 11'd767     ;


wire [10:0] start_h_point;
wire [10:0] start_v_point;
wire [10:0] stop_h_point;
wire [10:0] stop_v_point;


wire clk_25m;

assign cam_xclk=clk_25m;

assign  rst_n = sys_rst_n & locked;
//ç³»ç»Ÿåˆå§‹åŒ–å®Œæˆï¼šSDRAMå’Œæ‘„åƒå¤´éƒ½åˆå§‹åŒ–å®Œæˆ
//é¿å…äº†åœ¨SDRAMåˆå§‹åŒ–è¿‡ç¨‹ä¸­å‘é‡Œé¢å†™å…¥æ•°æ?
assign  sys_init_done = cam_init_done;
//ä¸å¯¹æ‘„åƒå¤´ç¡¬ä»¶å¤ä½?,å›ºå®šé«˜ç”µå¹?
//assign  cam_rst_n = 1'b1;
//ç”µæºä¼‘çœ æ¨¡å¼é€‰æ‹© 0ï¼šæ­£å¸¸æ¨¡å¼? 1ï¼šç”µæºä¼‘çœ æ¨¡å¼?
//assign  cam_pwdn = 1'b0;

   clk_wiz_1 u_pll_clk
     (
      // Clock out ports
      .clk_out1(clk_65m),     // output clk_out1
      .clk_out2(clk_25m),     // output clk_out2
      // Status and control signals
      .reset(~sys_rst_n), // input reset
      .locked(locked),       // output locked
     // Clock in ports
      .clk_in1(sys_clk));      // input clk_in1

//I2Cé…ç½®æ¨¡å—
i2c_ov5640_rgb565_cfg 
   #(
     .CMOS_H_PIXEL      (CMOS_H_PIXEL),
     .CMOS_V_PIXEL      (CMOS_V_PIXEL)
    )   
   u_i2c_cfg(   
    .clk                (i2c_dri_clk),
    .rst_n              (rst_n),
    .i2c_done           (i2c_done),
    .i2c_exec           (i2c_exec),
    .i2c_data           (i2c_data),
    .init_done          (cam_init_done)
    );    

//I2Cé©±åŠ¨æ¨¡å—
i2c_dri 
   #(
    .SLAVE_ADDR         (SLAVE_ADDR),       //å‚æ•°ä¼ é??
    .CLK_FREQ           (CLK_FREQ  ),              
    .I2C_FREQ           (I2C_FREQ  )                
    )   
   u_i2c_dri(   
    .clk                (clk_65m   ),
    .rst_n              (rst_n     ),   
        
    .i2c_exec           (i2c_exec  ),   
    .bit_ctrl           (BIT_CTRL  ),   
    .i2c_rh_wl          (1'b0),             //å›ºå®šä¸?0ï¼Œåªç”¨åˆ°äº†IICé©±åŠ¨çš„å†™æ“ä½œ   
    .i2c_addr           (i2c_data[23:8]),   
    .i2c_data_w         (i2c_data[7:0]),   
    .i2c_data_r         (),   
    .i2c_done           (i2c_done  ),   
    .scl                (cam_scl   ),   
    .sda                (cam_sda   ),   
        
    .dri_clk            (i2c_dri_clk)       //I2Cæ“ä½œæ—¶é’Ÿ
);
wire vid_pVSync;
wire vid_pHSync;
//CMOSå›¾åƒæ•°æ®é‡‡é›†æ¨¡å—
cmos_capture_data u_cmos_capture_data(  //ç³»ç»Ÿåˆå§‹åŒ–å®Œæˆä¹‹åŽå†å¼?å§‹é‡‡é›†æ•°æ? 
    .rst_n              (rst_n & sys_init_done), 
        
    .cam_pclk           (cam_pclk),
    .cam_vsync          (cam_vsync),
    .cam_href           (cam_href),
    .cam_data           (cam_data),
        
        
    .cmos_frame_vsync   (),
    .cmos_frame_href    (),
    .cmos_frame_valid   (wr_en),       //æ•°æ®æœ‰æ•ˆä½¿èƒ½ä¿¡å·
    .cmos_frame_data    (wr_data)      //æœ‰æ•ˆæ•°æ® 
    );
    reg [19 : 0] addra;
    reg [19 : 0] addrb;
    reg wr_en_delay;
    wire wr_one_data;
    assign wr_one_data=(wr_data[15:11]>5'h10)?1:0;
reg wr_one_data_reg;

    always @(posedge cam_pclk, negedge rst_n) begin
        if(!rst_n) wr_en_delay<=0;
        else wr_en_delay<= wr_en;
    end
wire mid_out_wr_en;
wire mid_out_wr_data;

wire fifo_wr_en;
wire fifo_wr_data;


always @(posedge cam_pclk,negedge rst_n) begin
    if(~rst_n) begin
        addra<=0;
    end else begin
        if(wr_en) begin
            addra<=addra+1;
            if(addra==20'hc0000-1) addra<=0;
        end
    end
end
blk_mem_gen_0 mem (
  .clka(cam_pclk),    // input wire clka
  .wea(wr_en),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [19 : 0] addra
  .dina(wr_data),    // input wire [15 : 0] dina  //wr_data//{5'b11111,6'b000000,5'b00000}
  .clkb(clk_65m),    // input wire clkb
  .addrb(addrb),  // input wire [19 : 0] addrb
  .doutb(rd_data)  // output wire [15 : 0] doutb
);
reg [23:0] vid_pData;
reg vga_en_delay;
reg vid_pHSync_delay;
reg vid_pVSync_delay;
wire vga_en;
wire [23:0] gray;
always @(posedge clk_65m,negedge rst_n) begin
    if(~rst_n) begin
        vid_pData<=0;
        vga_en_delay<=0;
        vid_pHSync_delay<=0;
        vid_pVSync_delay<=0;
    end else begin
        vga_en_delay<=vga_en;
        vid_pHSync_delay<=vid_pHSync;
        vid_pVSync_delay<=vid_pVSync;
        vid_pData<={rd_data[15:11],3'b0,rd_data[4:0],3'b0,rd_data[10:5],2'b0};//{8'h00,8'hff,8'h00};
    end
end

always @(posedge clk_65m,negedge rst_n) begin
    if(~rst_n) begin
        addrb<=0;
    end else begin
        if(rd_en) begin
            addrb<=addrb+1;
            if(addrb==20'hc0000-1) addrb<=0;
        end
    end
end
    


vga_driver vga(
        .vga_clk(clk_65m),      //VGAé©±åŠ¨æ—¶é’Ÿ
        .sys_rst_n(rst_n),    //å¤ä½ä¿¡å·
        .vga_en(vga_en),
        .data_req           (rd_en),
        //VGAæŽ¥å£                          
        .vga_hs(vid_pHSync),       //è¡ŒåŒæ­¥ä¿¡å?
        .vga_vs(vid_pVSync),       //åœºåŒæ­¥ä¿¡å?
        .pixel_xpos(pixel_xpos),   //åƒç´ ç‚¹æ¨ªåæ ‡
        .pixel_ypos(pixel_ypos)    //åƒç´ ç‚¹çºµåæ ‡    
        ); 

rgb2dvi_1 myrgb (
     .TMDS_Clk_p(TMDS_Clk_p),    // output wire TMDS_Clk_p
     .TMDS_Clk_n(TMDS_Clk_n),    // output wire TMDS_Clk_n
     .TMDS_Data_p(TMDS_Data_p),  // output wire [2 : 0] TMDS_Data_p
     .TMDS_Data_n(TMDS_Data_n),  // output wire [2 : 0] TMDS_Data_n
     .aRst_n(rst_n),                // input wire aRst
     .vid_pData(vid_pData),      // input wire [23 : 0] vid_pData//vid_pData
     .vid_pVDE(vga_en_delay),        // input wire vid_pVDE
     .vid_pHSync(vid_pHSync_delay),    // input wire vid_pHSync
     .vid_pVSync(vid_pVSync_delay),    // input wire vid_pVSync
     .PixelClk(clk_65m)        // input wire PixelClk
   );
endmodule