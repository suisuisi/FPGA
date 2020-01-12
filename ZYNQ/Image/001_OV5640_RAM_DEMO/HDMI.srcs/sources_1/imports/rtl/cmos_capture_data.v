//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-25 21:06:02
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-11-25 21:26:15
//# Description: 
//# @Modification History: 2019-10-27 21:23:14
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-10-27 21:23:14 Digilent
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//

module cmos_capture_data(
    input                 rst_n           ,  //å¤ä½ä¿¡å·
    //æ‘„åƒå¤´æŽ¥å?
    input                 cam_pclk        ,  //cmos æ•°æ®åƒç´ æ—¶é’Ÿ
    input                 cam_vsync       ,  //cmos åœºåŒæ­¥ä¿¡å?
    input                 cam_href        ,  //cmos è¡ŒåŒæ­¥ä¿¡å?
    input        [7:0]    cam_data        ,  //cmos æ•°æ®                             
    //ç”¨æˆ·æŽ¥å£
    output                cmos_frame_vsync,  //å¸§æœ‰æ•ˆä¿¡å?    
    output                cmos_frame_href ,  //è¡Œæœ‰æ•ˆä¿¡å?
    output                cmos_frame_valid,  //æ•°æ®æœ‰æ•ˆä½¿èƒ½ä¿¡å·
    output       [15:0]   cmos_frame_data    //æœ‰æ•ˆæ•°æ®        
    );

//å¯„å­˜å™¨å…¨éƒ¨é…ç½®å®ŒæˆåŽï¼Œå…ˆç­‰å¾…10å¸§æ•°æ?
//å¾…å¯„å­˜å™¨é…ç½®ç”Ÿæ•ˆåŽå†å¼?å§‹é‡‡é›†å›¾åƒ?
parameter  WAIT_FRAME = 4'd10  ;             //å¯„å­˜å™¨æ•°æ®ç¨³å®šç­‰å¾…çš„å¸§ä¸ªæ•?            

//reg define
reg             cam_vsync_d0   ;
reg             cam_vsync_d1   ;
reg             cam_href_d0    ;
reg             cam_href_d1    ;
reg    [3:0]    cmos_ps_cnt    ;             //ç­‰å¾…å¸§æ•°ç¨³å®šè®¡æ•°å™?
reg             frame_val_flag ;             //å¸§æœ‰æ•ˆçš„æ ‡å¿—

reg    [7:0]    cam_data_d0    ;             
reg    [15:0]   cmos_data_t    ;             //ç”¨äºŽ8ä½è½¬16ä½çš„ä¸´æ—¶å¯„å­˜å™?
reg             byte_flag      ;             
reg             byte_flag_d0   ;

//wire define
wire            pos_vsync      ;

//*****************************************************
//**                    main code
//*****************************************************

//é‡‡è¾“å…¥åœºåŒæ­¥ä¿¡å·çš„ä¸Šå‡æ²¿
assign pos_vsync = (~cam_vsync_d1) & cam_vsync_d0;  

//è¾“å‡ºå¸§æœ‰æ•ˆä¿¡å?
assign  cmos_frame_vsync = frame_val_flag  ?  cam_vsync_d1  :  1'b0; 
//è¾“å‡ºè¡Œæœ‰æ•ˆä¿¡å?
assign  cmos_frame_href  = frame_val_flag  ?  cam_href_d1   :  1'b0; 
//è¾“å‡ºæ•°æ®ä½¿èƒ½æœ‰æ•ˆä¿¡å·
assign  cmos_frame_valid = frame_val_flag  ?  byte_flag_d0  :  1'b0; 
//è¾“å‡ºæ•°æ®
assign  cmos_frame_data  = frame_val_flag  ?  cmos_data_t   :  1'b0; 

//é‡‡è¾“å…¥åœºåŒæ­¥ä¿¡å·çš„ä¸Šå‡æ²¿
always @(posedge cam_pclk or negedge rst_n) begin
    if(!rst_n) begin
        cam_vsync_d0 <= 1'b0;
        cam_vsync_d1 <= 1'b0;
        cam_href_d0 <= 1'b0;
        cam_href_d1 <= 1'b0;
    end
    else begin
        cam_vsync_d0 <= cam_vsync;
        cam_vsync_d1 <= cam_vsync_d0;
        cam_href_d0 <= cam_href;
        cam_href_d1 <= cam_href_d0;
    end
end

//å¯¹å¸§æ•°è¿›è¡Œè®¡æ•?
always @(posedge cam_pclk or negedge rst_n) begin
    if(!rst_n)
        cmos_ps_cnt <= 4'd0;
    else if(pos_vsync && (cmos_ps_cnt < WAIT_FRAME))
        cmos_ps_cnt <= cmos_ps_cnt + 4'd1;
end

//å¸§æœ‰æ•ˆæ ‡å¿?
always @(posedge cam_pclk or negedge rst_n) begin
    if(!rst_n)
        frame_val_flag <= 1'b0;
    else if((cmos_ps_cnt == WAIT_FRAME) && pos_vsync)
        frame_val_flag <= 1'b1;
    else;    
end            
/*
reg [7:0]cnt_test;
reg [8:0]cnt_temp;

reg [11:0]vcounter;
reg [15:0]vcnt=10'd0;
always@(posedge cam_pclk) begin
if(!rst_n) begin
    vcnt<=16'd0;
end else begin
    if(cam_vsync_d0) 
            vcounter <=12'd0;
            if(!vcnt[15])vcnt <= vcnt+1'b1;
     else if({cam_href_d0,cam_href}==2'b01)
             vcounter <= vcounter + 12'd1;
 end
end

reg [11:0]hcounter;
always@(posedge cam_pclk) begin
  if(!cmos_href_r) 
    hcounter <=12'd0;
  else 
    hcounter <= hcounter + 12'd1;
end

reg[7:0]	grid_data_1;
reg[7:0]	grid_data_2;
always @(posedge cam_pclk)//¸ñ×ÓÍ¼Ïñ
begin
	if((hcounter[2]==1'b1)^(vcounter[4]==1'b1))
	grid_data_1	<=	8'h00;
	else
	grid_data_1	<=	8'hff;
	
	if((hcounter[6]==1'b1)^(vcounter[6]==1'b1))
	grid_data_2	<=	8'h00;
	else
	grid_data_2	<=	8'hff;
end

*/


//8ä½æ•°æ®è½¬16ä½RGB565æ•°æ®        
always @(posedge cam_pclk or negedge rst_n) begin
    if(!rst_n) begin
        cmos_data_t <= 16'd0;
        cam_data_d0 <= 8'd0;
        byte_flag <= 1'b0;
    end
    else if(cam_href) begin
        byte_flag <= ~byte_flag;
        cam_data_d0 <= cam_data;
        if(byte_flag)
            cmos_data_t <= {cam_data_d0,cam_data};
            //cmos_data_t <= {5'b00000,6'b111111,5'b11111};
        else;   
    end
    else begin
        byte_flag <= 1'b0;
        cam_data_d0 <= 8'b0;
    end    
end        

//äº§ç”Ÿè¾“å‡ºæ•°æ®æœ‰æ•ˆä¿¡å·(cmos_frame_valid)
always @(posedge cam_pclk or negedge rst_n) begin
    if(!rst_n)
        byte_flag_d0 <= 1'b0;
    else
        byte_flag_d0 <= byte_flag;    
end          

endmodule 