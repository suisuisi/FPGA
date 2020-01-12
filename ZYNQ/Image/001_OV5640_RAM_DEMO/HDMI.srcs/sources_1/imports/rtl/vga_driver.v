//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-25 21:06:02
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-11-25 21:28:36
//# Description: vga_driver.v //
//# @Modification History: 2019-05-24 20:03:24
//# Date                By             Version             Change Description: 
//# ========================================================================= #
//# 2019-05-24 20:03:24 正点原子
//# ========================================================================= #
//# |                                                                       | #
//# |                                OpenFPGA                               | #
//****************************************************************************//

module vga_driver(
    input           vga_clk,      //VGAé©±åŠ¨æ—¶é’Ÿ
    input           sys_rst_n,    //å¤ä½ä¿¡å·
    //VGAæŽ¥å£                          
    output          vga_hs,       //è¡ŒåŒæ­¥ä¿¡å?
    output          vga_vs,       //åœºåŒæ­¥ä¿¡å?
    output          vga_en,
    output  [15:0]  vga_rgb,      //çº¢ç»¿è“ä¸‰åŽŸè‰²è¾“å‡º

    input   [15:0]  pixel_data,   //åƒç´ ç‚¹æ•°æ?
    output          data_req  ,   //è¯·æ±‚åƒç´ ç‚¹é¢œè‰²æ•°æ®è¾“å…? 
    output  [10:0]  pixel_xpos,   //åƒç´ ç‚¹æ¨ªåæ ‡
    output  [10:0]  pixel_ypos    //åƒç´ ç‚¹çºµåæ ‡    
    );                             

//parameter define  
/*
//640*480 60FPS_25MHz
parameter  H_SYNC   =  10'd96;    //è¡ŒåŒæ­?
parameter  H_BACK   =  10'd48;    //è¡Œæ˜¾ç¤ºåŽæ²?
parameter  H_DISP   =  10'd640;   //è¡Œæœ‰æ•ˆæ•°æ?
parameter  H_FRONT  =  10'd16;    //è¡Œæ˜¾ç¤ºå‰æ²?
parameter  H_TOTAL  =  10'd800;   //è¡Œæ‰«æå‘¨æœ?

parameter  V_SYNC   =  10'd2;     //åœºåŒæ­?
parameter  V_BACK   =  10'd33;    //åœºæ˜¾ç¤ºåŽæ²?
parameter  V_DISP   =  10'd480;   //åœºæœ‰æ•ˆæ•°æ?
parameter  V_FRONT  =  10'd10;    //åœºæ˜¾ç¤ºå‰æ²?
parameter  V_TOTAL  =  10'd525;   //åœºæ‰«æå‘¨æœ?
*/

//1024*768 60FPS_65MHz
parameter  H_SYNC   =  11'd136;   //è¡ŒåŒæ­?     
parameter  H_BACK   =  11'd160;   //è¡Œæ˜¾ç¤ºåŽæ²?
parameter  H_DISP   =  11'd1024;  //è¡Œæœ‰æ•ˆæ•°æ?
parameter  H_FRONT  =  11'd24;    //è¡Œæ˜¾ç¤ºå‰æ²?
parameter  H_TOTAL  =  11'd1344;  //è¡Œæ‰«æå‘¨æœ?  æ³¨æ„ä½å®½é•¿åº¦,éœ?è¦?11ä½çš„ä½å®½

parameter  V_SYNC   =  11'd6;     //åœºåŒæ­?
parameter  V_BACK   =  11'd29;    //åœºæ˜¾ç¤ºåŽæ²?
parameter  V_DISP   =  11'd768;   //åœºæœ‰æ•ˆæ•°æ?
parameter  V_FRONT  =  11'd3;     //åœºæ˜¾ç¤ºå‰æ²?
parameter  V_TOTAL  =  11'd806;   //åœºæ‰«æå‘¨æœ?

//reg define                                     
reg  [10:0] cnt_h;               
reg  [10:0] cnt_v;


//*****************************************************
//**                    main code
//*****************************************************
//VGAè¡ŒåœºåŒæ­¥ä¿¡å·
assign vga_hs  = (cnt_h >= H_DISP+H_FRONT) && (cnt_h <= H_DISP+H_FRONT+H_SYNC - 1'b1) ? 1'b1 : 1'b0;
assign vga_vs  = (cnt_v >= V_DISP+V_FRONT) && (cnt_v <= V_DISP+V_FRONT+V_SYNC - 1'b1) ? 1'b1 : 1'b0;

//ä½¿èƒ½RGB565æ•°æ®è¾“å‡º
assign vga_en  = ((cnt_h < H_DISP)&&(cnt_v < V_DISP)) ?  1'b1 : 1'b0;
                 
//RGB565æ•°æ®è¾“å‡º                 
assign vga_rgb = vga_en ? pixel_data : 16'd0;

//è¯·æ±‚åƒç´ ç‚¹é¢œè‰²æ•°æ®è¾“å…?                
assign data_req = ((cnt_h < H_DISP) && (cnt_v < V_DISP)) ?  1'b1 : 1'b0;

//åƒç´ ç‚¹åæ ?                
assign pixel_xpos = data_req ? cnt_h - 1'b1 : 10'd0;
assign pixel_ypos = data_req ? cnt_v - 1'b1 : 10'd0;

//è¡Œè®¡æ•°å™¨å¯¹åƒç´ æ—¶é’Ÿè®¡æ•?
always @(posedge vga_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)
        cnt_h <= 10'd0;                                  
    else begin
        if(cnt_h < H_TOTAL - 1'b1)                                               
            cnt_h <= cnt_h + 1'b1;                               
        else 
            cnt_h <= 10'd0;  
    end
end

//åœºè®¡æ•°å™¨å¯¹è¡Œè®¡æ•°
always @(posedge vga_clk or negedge sys_rst_n) begin         
    if (!sys_rst_n)
        cnt_v <= 10'd0;                                  
    else if(cnt_h == H_TOTAL - 1'b1) begin
        if(cnt_v < V_TOTAL - 1'b1)                                               
            cnt_v <= cnt_v + 1'b1;                               
        else 
            cnt_v <= 10'd0;  
    end
end

endmodule 