//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-25 21:06:02
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-11-25 21:27:00
//# Description: 
//# @Modification History: 2019-02-23 16:21:18
//# Date                By             Version             Change Description: 
//# ========================================================================= #
//# 2019-02-23 16:21:18 Digilent
//# ========================================================================= #
//# |                                                                       | #
//# |                                OpenFPGA                               | #
//****************************************************************************//

module i2c_dri
    #(// slave addressï¼ˆå™¨ä»¶åœ°å?ï¼‰ï¼Œæ”¾æ­¤å¤„æ–¹ä¾¿å‚æ•°ä¼ é€?
      parameter   SLAVE_ADDR =  7'b1010000   ,
      parameter   CLK_FREQ   = 26'd50_000_000,   // i2c_driæ¨¡å—çš„é©±åŠ¨æ—¶é’Ÿé¢‘çŽ?(CLK_FREQ)
      parameter   I2C_FREQ   = 18'd250_000       // I2Cçš„SCLæ—¶é’Ÿé¢‘çŽ‡
     )(
          //global clock
          input                clk        ,      // i2c_driæ¨¡å—çš„é©±åŠ¨æ—¶é’?(CLK_FREQ)
          input                rst_n      ,      // å¤ä½ä¿¡å·

          //i2c interface
          input                i2c_exec   ,      // I2Cè§¦å‘æ‰§è¡Œä¿¡å·
          input                bit_ctrl   ,      // å­—åœ°å?ä½æŽ§åˆ?(16b/8b)
          input                i2c_rh_wl  ,      // I2Cè¯»å†™æŽ§åˆ¶ä¿¡å·
          input        [15:0]  i2c_addr   ,      // I2Cå™¨ä»¶å†…åœ°å?
          input        [ 7:0]  i2c_data_w ,      // I2Cè¦å†™çš„æ•°æ?
          output  reg  [ 7:0]  i2c_data_r ,      // I2Cè¯»å‡ºçš„æ•°æ?
          output  reg          i2c_done   ,      // I2Cä¸?æ¬¡æ“ä½œå®Œæˆ?
          output  reg          scl        ,      // I2Cçš„SCLæ—¶é’Ÿä¿¡å·
          inout                sda        ,      // I2Cçš„SDAä¿¡å·

          //user interface
          output  reg          dri_clk           // é©±åŠ¨I2Cæ“ä½œçš„é©±åŠ¨æ—¶é’?
     );

//localparam define
localparam  st_idle     = 8'b0000_0001;          // ç©ºé—²çŠ¶æ??
localparam  st_sladdr   = 8'b0000_0010;          // å‘é?å™¨ä»¶åœ°å?(slave address)
localparam  st_addr16   = 8'b0000_0100;          // å‘é??16ä½å­—åœ°å€
localparam  st_addr8    = 8'b0000_1000;          // å‘é??8ä½å­—åœ°å€
localparam  st_data_wr  = 8'b0001_0000;          // å†™æ•°æ?(8 bit)
localparam  st_addr_rd  = 8'b0010_0000;          // å‘é?å™¨ä»¶åœ°å?è¯?
localparam  st_data_rd  = 8'b0100_0000;          // è¯»æ•°æ?(8 bit)
localparam  st_stop     = 8'b1000_0000;          // ç»“æŸI2Cæ“ä½œ

//reg define
reg            sda_dir     ;                     // I2Cæ•°æ®(SDA)æ–¹å‘æŽ§åˆ¶
reg            sda_out     ;                     // SDAè¾“å‡ºä¿¡å·
reg            st_done     ;                     // çŠ¶æ?ç»“æ?
reg            wr_flag     ;                     // å†™æ ‡å¿?
reg    [ 6:0]  cnt         ;                     // è®¡æ•°
reg    [ 7:0]  cur_state   ;                     // çŠ¶æ?æœºå½“å‰çŠ¶æ??
reg    [ 7:0]  next_state  ;                     // çŠ¶æ?æœºä¸‹ä¸€çŠ¶æ??
reg    [15:0]  addr_t      ;                     // åœ°å€
reg    [ 7:0]  data_r      ;                     // è¯»å–çš„æ•°æ?
reg    [ 7:0]  data_wr_t   ;                     // I2Céœ?å†™çš„æ•°æ®çš„ä¸´æ—¶å¯„å­?
reg    [ 9:0]  clk_cnt     ;                     // åˆ†é¢‘æ—¶é’Ÿè®¡æ•°

//wire define
wire          sda_in      ;                      // SDAè¾“å…¥ä¿¡å·
wire   [8:0]  clk_divide  ;                      // æ¨¡å—é©±åŠ¨æ—¶é’Ÿçš„åˆ†é¢‘ç³»æ•?

//*****************************************************
//**                    main code
//*****************************************************

//SDAæŽ§åˆ¶
assign  sda     = sda_dir ?  sda_out : 1'bz;     // SDAæ•°æ®è¾“å‡ºæˆ–é«˜é˜?
assign  sda_in  = sda ;                          // SDAæ•°æ®è¾“å…¥
assign  clk_divide = (CLK_FREQ/I2C_FREQ) >> 3;   // æ¨¡å—é©±åŠ¨æ—¶é’Ÿçš„åˆ†é¢‘ç³»æ•?

//ç”ŸæˆI2Cçš„SCLçš„å››å€é¢‘çŽ‡çš„é©±åŠ¨æ—¶é’Ÿç”¨äºŽé©±åŠ¨i2cçš„æ“ä½?
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        dri_clk <=  1'b1;
        clk_cnt <= 10'd0;
    end
    else if(clk_cnt == clk_divide - 1'd1) begin
        clk_cnt <= 10'd0;
        dri_clk <= ~dri_clk;
    end
    else
        clk_cnt <= clk_cnt + 1'b1;
end

//(ä¸‰æ®µå¼çŠ¶æ€æœº)åŒæ­¥æ—¶åºæè¿°çŠ¶æ?è½¬ç§?
always @(posedge dri_clk or negedge rst_n) begin
    if(!rst_n)
        cur_state <= st_idle;
    else
        cur_state <= next_state;
end

//ç»„åˆé€»è¾‘åˆ¤æ–­çŠ¶æ?è½¬ç§»æ¡ä»?
always @( * ) begin
//    next_state = st_idle;
    case(cur_state)
        st_idle: begin                           // ç©ºé—²çŠ¶æ??
           if(i2c_exec) begin
               next_state = st_sladdr;
           end
           else
               next_state = st_idle;
        end
        st_sladdr: begin
            if(st_done) begin
                if(bit_ctrl)                     // åˆ¤æ–­æ˜?16ä½è¿˜æ˜?8ä½å­—åœ°å€
                   next_state = st_addr16;
                else
                   next_state = st_addr8 ;
            end
            else
                next_state = st_sladdr;
        end
        st_addr16: begin                         // å†?16ä½å­—åœ°å€
            if(st_done) begin
                next_state = st_addr8;
            end
            else begin
                next_state = st_addr16;
            end
        end
        st_addr8: begin                          // 8ä½å­—åœ°å€
            if(st_done) begin
                if(wr_flag==1'b0)                // è¯»å†™åˆ¤æ–­
                    next_state = st_data_wr;
                else
                    next_state = st_addr_rd;
            end
            else begin
                next_state = st_addr8;
            end
        end
        st_data_wr: begin                        // å†™æ•°æ?(8 bit)
            if(st_done)
                next_state = st_stop;
            else
                next_state = st_data_wr;
        end
        st_addr_rd: begin                        // å†™åœ°å?ä»¥è¿›è¡Œè¯»æ•°æ®
            if(st_done) begin
                next_state = st_data_rd;
            end
            else begin
                next_state = st_addr_rd;
            end
        end
        st_data_rd: begin                        // è¯»å–æ•°æ®(8 bit)
            if(st_done)
                next_state = st_stop;
            else
                next_state = st_data_rd;
        end
        st_stop: begin                           // ç»“æŸI2Cæ“ä½œ
            if(st_done)
                next_state = st_idle;
            else
                next_state = st_stop ;
        end
        default: next_state= st_idle;
    endcase
end

//æ—¶åºç”µè·¯æè¿°çŠ¶æ?è¾“å‡?
always @(posedge dri_clk or negedge rst_n) begin
    //å¤ä½åˆå§‹åŒ?
    if(!rst_n) begin
        scl        <= 1'b1;
        sda_out    <= 1'b1;
        sda_dir    <= 1'b1;
        i2c_done   <= 1'b0;
        cnt        <= 1'b0;
        st_done    <= 1'b0;
        data_r     <= 1'b0;
        i2c_data_r <= 1'b0;
        wr_flag    <= 1'b0;
        addr_t     <= 1'b0;
        data_wr_t  <= 1'b0;
    end
    else begin
        st_done <= 1'b0 ;
        cnt     <= cnt +1'b1 ;
        case(cur_state)
             st_idle: begin                            // ç©ºé—²çŠ¶æ??
                scl     <= 1'b1;
                sda_out <= 1'b1;
                sda_dir <= 1'b1;
                i2c_done<= 1'b0;
                cnt     <= 7'b0;
                if(i2c_exec) begin
                    wr_flag   <= i2c_rh_wl ;
                    addr_t    <= i2c_addr  ;
                    data_wr_t <= i2c_data_w;
                end
            end
            st_sladdr: begin                           // å†™åœ°å?(å™¨ä»¶åœ°å€å’Œå­—åœ°å€)
                case(cnt)
                    7'd1 : sda_out <= 1'b0;            // å¼?å§‹I2C
                    7'd3 : scl <= 1'b0;
                    7'd4 : sda_out <= SLAVE_ADDR[6];   // ä¼ é?å™¨ä»¶åœ°å?
                    7'd5 : scl <= 1'b1;
                    7'd7 : scl <= 1'b0;
                    7'd8 : sda_out <= SLAVE_ADDR[5];
                    7'd9 : scl <= 1'b1;
                    7'd11: scl <= 1'b0;
                    7'd12: sda_out <= SLAVE_ADDR[4];
                    7'd13: scl <= 1'b1;
                    7'd15: scl <= 1'b0;
                    7'd16: sda_out <= SLAVE_ADDR[3];
                    7'd17: scl <= 1'b1;
                    7'd19: scl <= 1'b0;
                    7'd20: sda_out <= SLAVE_ADDR[2];
                    7'd21: scl <= 1'b1;
                    7'd23: scl <= 1'b0;
                    7'd24: sda_out <= SLAVE_ADDR[1];
                    7'd25: scl <= 1'b1;
                    7'd27: scl <= 1'b0;
                    7'd28: sda_out <= SLAVE_ADDR[0];
                    7'd29: scl <= 1'b1;
                    7'd31: scl <= 1'b0;
                    7'd32: sda_out <= 1'b0;            // 0:å†?
                    7'd33: scl <= 1'b1;
                    7'd35: scl <= 1'b0;
                    7'd36: begin
                        sda_dir <= 1'b0;               // ä»Žæœºåº”ç­”
                        sda_out <= 1'b1;
                    end
                    7'd37: scl     <= 1'b1;
                    7'd38: st_done <= 1'b1;
                    7'd39: begin
                        scl <= 1'b0;
                        cnt <= 1'b0;
                    end
                    default :  ;
                endcase
            end
            st_addr16: begin
                case(cnt)
                    7'd0 : begin
                        sda_dir <= 1'b1 ;
                        sda_out <= addr_t[15];         // ä¼ é?å­—åœ°å€
                    end
                    7'd1 : scl <= 1'b1;
                    7'd3 : scl <= 1'b0;
                    7'd4 : sda_out <= addr_t[14];
                    7'd5 : scl <= 1'b1;
                    7'd7 : scl <= 1'b0;
                    7'd8 : sda_out <= addr_t[13];
                    7'd9 : scl <= 1'b1;
                    7'd11: scl <= 1'b0;
                    7'd12: sda_out <= addr_t[12];
                    7'd13: scl <= 1'b1;
                    7'd15: scl <= 1'b0;
                    7'd16: sda_out <= addr_t[11];
                    7'd17: scl <= 1'b1;
                    7'd19: scl <= 1'b0;
                    7'd20: sda_out <= addr_t[10];
                    7'd21: scl <= 1'b1;
                    7'd23: scl <= 1'b0;
                    7'd24: sda_out <= addr_t[9];
                    7'd25: scl <= 1'b1;
                    7'd27: scl <= 1'b0;
                    7'd28: sda_out <= addr_t[8];
                    7'd29: scl <= 1'b1;
                    7'd31: scl <= 1'b0;
                    7'd32: begin
                        sda_dir <= 1'b0;               // ä»Žæœºåº”ç­”
                        sda_out <= 1'b1;
                    end
                    7'd33: scl     <= 1'b1;
                    7'd34: st_done <= 1'b1;
                    7'd35: begin
                        scl <= 1'b0;
                        cnt <= 1'b0;
                    end
                    default :  ;
                endcase
            end
            st_addr8: begin
                case(cnt)
                    7'd0: begin
                       sda_dir <= 1'b1 ;
                       sda_out <= addr_t[7];           // å­—åœ°å?
                    end
                    7'd1 : scl <= 1'b1;
                    7'd3 : scl <= 1'b0;
                    7'd4 : sda_out <= addr_t[6];
                    7'd5 : scl <= 1'b1;
                    7'd7 : scl <= 1'b0;
                    7'd8 : sda_out <= addr_t[5];
                    7'd9 : scl <= 1'b1;
                    7'd11: scl <= 1'b0;
                    7'd12: sda_out <= addr_t[4];
                    7'd13: scl <= 1'b1;
                    7'd15: scl <= 1'b0;
                    7'd16: sda_out <= addr_t[3];
                    7'd17: scl <= 1'b1;
                    7'd19: scl <= 1'b0;
                    7'd20: sda_out <= addr_t[2];
                    7'd21: scl <= 1'b1;
                    7'd23: scl <= 1'b0;
                    7'd24: sda_out <= addr_t[1];
                    7'd25: scl <= 1'b1;
                    7'd27: scl <= 1'b0;
                    7'd28: sda_out <= addr_t[0];
                    7'd29: scl <= 1'b1;
                    7'd31: scl <= 1'b0;
                    7'd32: begin
                        sda_dir <= 1'b0;               // ä»Žæœºåº”ç­”
                        sda_out <= 1'b1;
                    end
                    7'd33: scl     <= 1'b1;
                    7'd34: st_done <= 1'b1;
                    7'd35: begin
                        scl <= 1'b0;
                        cnt <= 1'b0;
                    end
                    default :  ;
                endcase
            end
            st_data_wr: begin                          // å†™æ•°æ?(8 bit)
                case(cnt)
                    7'd0: begin
                        sda_out <= data_wr_t[7];       // I2Cå†?8ä½æ•°æ?
                        sda_dir <= 1'b1;
                    end
                    7'd1 : scl <= 1'b1;
                    7'd3 : scl <= 1'b0;
                    7'd4 : sda_out <= data_wr_t[6];
                    7'd5 : scl <= 1'b1;
                    7'd7 : scl <= 1'b0;
                    7'd8 : sda_out <= data_wr_t[5];
                    7'd9 : scl <= 1'b1;
                    7'd11: scl <= 1'b0;
                    7'd12: sda_out <= data_wr_t[4];
                    7'd13: scl <= 1'b1;
                    7'd15: scl <= 1'b0;
                    7'd16: sda_out <= data_wr_t[3];
                    7'd17: scl <= 1'b1;
                    7'd19: scl <= 1'b0;
                    7'd20: sda_out <= data_wr_t[2];
                    7'd21: scl <= 1'b1;
                    7'd23: scl <= 1'b0;
                    7'd24: sda_out <= data_wr_t[1];
                    7'd25: scl <= 1'b1;
                    7'd27: scl <= 1'b0;
                    7'd28: sda_out <= data_wr_t[0];
                    7'd29: scl <= 1'b1;
                    7'd31: scl <= 1'b0;
                    7'd32: begin
                        sda_dir <= 1'b0;               // ä»Žæœºåº”ç­”
                        sda_out <= 1'b1;
                    end
                    7'd33: scl <= 1'b1;
                    7'd34: st_done <= 1'b1;
                    7'd35: begin
                        scl  <= 1'b0;
                        cnt  <= 1'b0;
                    end
                    default  :  ;
                endcase
            end
            st_addr_rd: begin                          // å†™åœ°å?ä»¥è¿›è¡Œè¯»æ•°æ®
                case(cnt)
                    7'd0 : begin
                        sda_dir <= 1'b1;
                        sda_out <= 1'b1;
                    end
                    7'd1 : scl <= 1'b1;
                    7'd2 : sda_out <= 1'b0;            // é‡æ–°å¼?å§?
                    7'd3 : scl <= 1'b0;
                    7'd4 : sda_out <= SLAVE_ADDR[6];   // ä¼ é?å™¨ä»¶åœ°å?
                    7'd5 : scl <= 1'b1;
                    7'd7 : scl <= 1'b0;
                    7'd8 : sda_out <= SLAVE_ADDR[5];
                    7'd9 : scl <= 1'b1;
                    7'd11: scl <= 1'b0;
                    7'd12: sda_out <= SLAVE_ADDR[4];
                    7'd13: scl <= 1'b1;
                    7'd15: scl <= 1'b0;
                    7'd16: sda_out <= SLAVE_ADDR[3];
                    7'd17: scl <= 1'b1;
                    7'd19: scl <= 1'b0;
                    7'd20: sda_out <= SLAVE_ADDR[2];
                    7'd21: scl <= 1'b1;
                    7'd23: scl <= 1'b0;
                    7'd24: sda_out <= SLAVE_ADDR[1];
                    7'd25: scl <= 1'b1;
                    7'd27: scl <= 1'b0;
                    7'd28: sda_out <= SLAVE_ADDR[0];
                    7'd29: scl <= 1'b1;
                    7'd31: scl <= 1'b0;
                    7'd32: sda_out <= 1'b1;            // 1:è¯?
                    7'd33: scl <= 1'b1;
                    7'd35: scl <= 1'b0;
                    7'd36: begin
                        sda_dir <= 1'b0;               // ä»Žæœºåº”ç­”
                        sda_out <= 1'b1;
                    end
                    7'd37: scl     <= 1'b1;
                    7'd38: st_done <= 1'b1;
                    7'd39: begin
                        scl <= 1'b0;
                        cnt <= 1'b0;
                    end
                    default : ;
                endcase
            end
            st_data_rd: begin                          // è¯»å–æ•°æ®(8 bit)
                case(cnt)
                    7'd0: sda_dir <= 1'b0;
                    7'd1: begin
                        data_r[7] <= sda_in;
                        scl       <= 1'b1;
                    end
                    7'd3: scl  <= 1'b0;
                    7'd5: begin
                        data_r[6] <= sda_in ;
                        scl       <= 1'b1   ;
                    end
                    7'd7: scl  <= 1'b0;
                    7'd9: begin
                        data_r[5] <= sda_in;
                        scl       <= 1'b1  ;
                    end
                    7'd11: scl  <= 1'b0;
                    7'd13: begin
                        data_r[4] <= sda_in;
                        scl       <= 1'b1  ;
                    end
                    7'd15: scl  <= 1'b0;
                    7'd17: begin
                        data_r[3] <= sda_in;
                        scl       <= 1'b1  ;
                    end
                    7'd19: scl  <= 1'b0;
                    7'd21: begin
                        data_r[2] <= sda_in;
                        scl       <= 1'b1  ;
                    end
                    7'd23: scl  <= 1'b0;
                    7'd25: begin
                        data_r[1] <= sda_in;
                        scl       <= 1'b1  ;
                    end
                    7'd27: scl  <= 1'b0;
                    7'd29: begin
                        data_r[0] <= sda_in;
                        scl       <= 1'b1  ;
                    end
                    7'd31: scl  <= 1'b0;
                    7'd32: begin
                        sda_dir <= 1'b1;              // éžåº”ç­?
                        sda_out <= 1'b1;
                    end
                    7'd33: scl     <= 1'b1;
                    7'd34: st_done <= 1'b1;
                    7'd35: begin
                        scl <= 1'b0;
                        cnt <= 1'b0;
                        i2c_data_r <= data_r;
                    end
                    default  :  ;
                endcase
            end
            st_stop: begin                            // ç»“æŸI2Cæ“ä½œ
                case(cnt)
                    7'd0: begin
                        sda_dir <= 1'b1;              // ç»“æŸI2C
                        sda_out <= 1'b0;
                    end
                    7'd1 : scl     <= 1'b1;
                    7'd3 : sda_out <= 1'b1;
                    7'd15: st_done <= 1'b1;
                    7'd16: begin
                        cnt      <= 1'b0;
                        i2c_done <= 1'b1;             // å‘ä¸Šå±‚æ¨¡å—ä¼ é€’I2Cç»“æŸä¿¡å·
                    end
                    default  : ;
                endcase
            end
        endcase
    end
end

endmodule