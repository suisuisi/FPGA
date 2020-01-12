`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: milinker corperation
// WEB:www.milinker.com
// BBS:www.osrc.cn
// Engineer:
// Create Date:    07:28:50 11/30/2015 
// Design Name: 	 OV7725_TOP
// Module Name:    OV7725_TOP
// Project Name: 	 OV7725_TOP
// Target Devices: www.osrc.cn
// Tool versions:  avivado2016.4
// Description: 	 OV7725_TOP
// Revision: 		 V1.0
// Additional Comments: 
//1) _i PIN input  
//2) _o PIN output
//3) _n PIN active low
//4) _dg debug signal 
//5) _r  reg delay
//6) _s M_S machine
//
// ch0_in_FIFO------------->DDR---------------->ch6_out_FIFO
//                      M_S_machine     
module OV5640_TOP#(
  //***************************************************************************
  // Traffic Gen related parameters
  //***************************************************************************
  parameter PORT_MODE             = "BI_MODE",
  parameter DATA_MODE             = 4'b0010,
  parameter TST_MEM_INSTR_MODE    = "R_W_INSTR_MODE",
  parameter EYE_TEST              = "FALSE",
                                    // set EYE_TEST = "TRUE" to probe memory
                                    // signals. Traffic Generator will only
                                    // write to one single location and no
                                    // read transactions will be generated.
  parameter DATA_PATTERN          = "DGEN_ALL",
                                     // For small devices, choose one only.
                                     // For large device, choose "DGEN_ALL"
                                     // "DGEN_HAMMER", "DGEN_WALKING1",
                                     // "DGEN_WALKING0","DGEN_ADDR","
                                     // "DGEN_NEIGHBOR","DGEN_PRBS","DGEN_ALL"
  parameter CMD_PATTERN           = "CGEN_ALL",
                                     // "CGEN_PRBS","CGEN_FIXED","CGEN_BRAM",
                                     // "CGEN_SEQUENTIAL", "CGEN_ALL"
  parameter CMD_WDT               = 'h3FF,
  parameter WR_WDT                = 'h1FFF,
  parameter RD_WDT                = 'h3FF,
  parameter SEL_VICTIM_LINE       = 0,
  parameter BEGIN_ADDRESS         = 32'h00000000,
  parameter END_ADDRESS           = 32'h00ffffff,
  parameter PRBS_EADDR_MASK_POS   = 32'hff000000,

  //***************************************************************************
  // The following parameters refer to width of various ports
  //***************************************************************************
  parameter CK_WIDTH              = 1,
                                    // # of CK/CK# outputs to memory.
  parameter nCS_PER_RANK          = 1,
                                    // # of unique CS outputs per rank for phy
  parameter CKE_WIDTH             = 1,
                                    // # of CKE outputs to memory.
  parameter DM_WIDTH              = 4,
                                    // # of DM (data mask)
  parameter ODT_WIDTH             = 1,
                                    // # of ODT outputs to memory.
  parameter BANK_WIDTH            = 3,
                                    // # of memory Bank Address bits.
  parameter COL_WIDTH             = 10,
                                    // # of memory Column Address bits.
  parameter CS_WIDTH              = 1,
                                    // # of unique CS outputs to memory.
  parameter DQ_WIDTH              = 32,
                                    // # of DQ (data)
  parameter DQS_WIDTH             = 4,
  parameter DQS_CNT_WIDTH         = 2,
                                    // = ceil(log2(DQS_WIDTH))
  parameter DRAM_WIDTH            = 8,
                                    // # of DQ per DQS
  parameter ECC                   = "OFF",
  parameter ECC_TEST              = "OFF",
  //parameter nBANK_MACHS           = 4,
  parameter nBANK_MACHS           = 4,
  parameter RANKS                 = 1,
                                    // # of Ranks.
  parameter ROW_WIDTH             = 14,
                                    // # of memory Row Address bits.
  parameter ADDR_WIDTH            = 28,
                                    // # = RANK_WIDTH + BANK_WIDTH
                                    //     + ROW_WIDTH + COL_WIDTH;
                                    // Chip Select is always tied to low for
                                    // single rank devices
  //***************************************************************************
  // The following parameters are mode register settings
  //***************************************************************************
  parameter BURST_MODE            = "8",
                                    // DDR3 SDRAM:
                                    // Burst Length (Mode Register 0).
                                    // # = "8", "4", "OTF".
                                    // DDR2 SDRAM:
                                    // Burst Length (Mode Register).
                                    // # = "8", "4".
  //***************************************************************************
  // The following parameters are multiplier and divisor factors for PLLE2.
  // Based on the selected design frequency these parameters vary.
  //***************************************************************************
  parameter CLKIN_PERIOD          = 5000,
                                    // Input Clock Period
  parameter CLKFBOUT_MULT         = 4,
                                    // write PLL VCO multiplier
  parameter DIVCLK_DIVIDE         = 1,
                                    // write PLL VCO divisor
  parameter CLKOUT0_PHASE         = 0.0,
                                    // Phase for PLL output clock (CLKOUT0)
  parameter CLKOUT0_DIVIDE        = 1,
                                    // VCO output divisor for PLL output clock (CLKOUT0)
  parameter CLKOUT1_DIVIDE        = 2,
                                    // VCO output divisor for PLL output clock (CLKOUT1)
  parameter CLKOUT2_DIVIDE        = 32,
                                    // VCO output divisor for PLL output clock (CLKOUT2)
  parameter CLKOUT3_DIVIDE        = 8,
                                    // VCO output divisor for PLL output clock (CLKOUT3)
  parameter MMCM_VCO              = 800,
                                    // Max Freq (MHz) of MMCM VCO
  parameter MMCM_MULT_F           = 8,
                                    // write MMCM VCO multiplier
  parameter MMCM_DIVCLK_DIVIDE    = 1,
                                    // write MMCM VCO divisor
  //***************************************************************************
  // Simulation parameters
  //***************************************************************************
  parameter SIMULATION            = "FALSE",
                                    // Should be TRUE during design simulations and
                                    // FALSE during implementations
  //***************************************************************************
  // IODELAY and PHY related parameters
  //***************************************************************************
  parameter TCQ                   = 100,
  
  parameter DRAM_TYPE             = "DDR3",
  //***************************************************************************
  // System clock frequency parameters
  //***************************************************************************
  parameter nCK_PER_CLK           = 4,
                                    // # of memory CKs per fabric CLK
  //***************************************************************************
  // Debug parameters
  //***************************************************************************
  parameter DEBUG_PORT            = "OFF",
                                    // # = "ON" Enable debug signals/controls.
                                    //   = "OFF" Disable debug signals/controls.
  parameter RST_ACT_LOW           = 0
                                    // =1 for active low reset,
                                    // =0 for active high.
  )
 (
  // Inouts
  inout [31:0]                 ddr3_dq,
  inout [3:0]                  ddr3_dqs_n,
  inout [3:0]                  ddr3_dqs_p,
  // Outputs
  output [13:0]                ddr3_addr,
  output [2:0]                 ddr3_ba,
  output                       ddr3_ras_n,
  output                       ddr3_cas_n,
  output                       ddr3_we_n,
  output                       ddr3_reset_n,
  output [0:0]                 ddr3_ck_p,
  output [0:0]                 ddr3_ck_n,
  output [0:0]                 ddr3_cke,
  output [0:0]                 ddr3_cs_n,
  output [3:0]                 ddr3_dm,
  output [0:0]                 ddr3_odt,
  
  output		               cmos_sclk_o,	//cmos i2c clock
  inout                        cmos_sdat_io,    //cmos i2c data
  input                        cmos_vsync_i,    //cmos vsync
  input                        cmos_href_i,    //cmos hsync refrence
  input                        cmos_pclk_i,    //cmos pxiel clock
  output                       cmos_xclk_o,    //cmos externl clock
  input[7:0]                   cmos_data_i,    //cmos data
  	
//----------------------------- VGA/HDMI hardware interface ----------------------------/
output                         HDMI1_CLK_P, 
output                         HDMI1_CLK_N, 
output                         HDMI1_D2_P,  
output                         HDMI1_D2_N,  
output                         HDMI1_D1_P,  
output                         HDMI1_D1_N,  
output                         HDMI1_D0_P,  
output                         HDMI1_D0_N,  

output                         init_calib_complete,
input                          clk50m_i,
input                          rst_key
);


wire sys_rst;
wire locked;
wire clk_ref_i;
wire sys_clk_i;
wire clk_200m,clk_100m,clk_25m,clk_50m_hmdi;   
assign sys_rst = ~rst_key;//复位信号
assign clk_ref_i = clk_200m;//200M的参考时钟
assign sys_clk_i = clk_200m;//200M的系统时钟

//时钟管理产生DDR需要的时钟   
clk_wiz_sys CLK_WIZ_DDR( .clk_out1(clk_200m),.clk_out2(clk_25m),.clk_out3(clk_50m_hmdi),.reset(sys_rst),.locked(locked),.clk_in1(clk50m_i)); 

 wire serclk;
 wire pixclk;
 wire hdmi_clk_locked;
clk_wiz_hdmi clk_wiz_hdmi_inst(.clk_out1(pixclk), .clk_out2(serclk), .reset(sys_rst),.locked(hdmi_clk_locked), .clk_in1(clk_50m_hmdi));   
//----------------------ov7725视频输出解码模块---------------------------//

function integer clogb2 (input integer size);
    begin
      size = size - 1;
      for (clogb2=1; size>1; clogb2=clogb2+1)
        size = size >> 1;
    end
  endfunction // clogb2

  function integer STR_TO_INT;
    input [7:0] in;
    begin
      if(in == "8")
        STR_TO_INT = 8;
      else if(in == "4")
        STR_TO_INT = 4;
      else
        STR_TO_INT = 0;
    end
  endfunction


  localparam DATA_WIDTH            = 32;
  localparam RANK_WIDTH = clogb2(RANKS);
  localparam PAYLOAD_WIDTH         = (ECC_TEST == "OFF") ? DATA_WIDTH : DQ_WIDTH;
  localparam BURST_LENGTH          = STR_TO_INT(BURST_MODE);
  localparam APP_DATA_WIDTH        = 2 * nCK_PER_CLK * PAYLOAD_WIDTH;
  localparam APP_MASK_WIDTH        = APP_DATA_WIDTH / 8;

  //***************************************************************************
  // Traffic Gen related parameters (derived)
  //***************************************************************************
  localparam  TG_ADDR_WIDTH = ((CS_WIDTH == 1) ? 0 : RANK_WIDTH)
                                 + BANK_WIDTH + ROW_WIDTH + COL_WIDTH;
  localparam MASK_SIZE             = DATA_WIDTH/8;
      
  // Wire declarations
      
  wire [(2*nCK_PER_CLK)-1:0]            app_ecc_multiple_err;
  wire [(2*nCK_PER_CLK)-1:0]            app_ecc_single_err;
  wire [ADDR_WIDTH-1:0]                 app_addr;
  wire [2:0]                            app_cmd;
  wire                                  app_en;
  wire                                  app_rdy;
  wire [APP_DATA_WIDTH-1:0]             app_rd_data;
  wire                                  app_rd_data_end;
  wire                                  app_rd_data_valid;
  wire [APP_DATA_WIDTH-1:0]             app_wdf_data;
  wire                                  app_wdf_end;
  wire [APP_MASK_WIDTH-1:0]             app_wdf_mask;
  wire                                  app_wdf_rdy;
  wire                                  app_sr_active;
  wire                                  app_ref_ack;
  wire                                  app_zq_ack;
  wire                                  app_wdf_wren;
  wire [(64+(2*APP_DATA_WIDTH))-1:0]    error_status;
  wire [(PAYLOAD_WIDTH/8)-1:0] cumlative_dq_lane_error;
  wire                                  mem_pattern_init_done;
  wire [47:0]                           tg_wr_data_counts;
  wire [47:0]                           tg_rd_data_counts;
  wire                                  modify_enable_sel;
  wire [2:0]                            data_mode_manual_sel;
  wire [2:0]                            addr_mode_manual_sel;
  wire [APP_DATA_WIDTH-1:0]             cmp_data;
  reg [63:0]                            cmp_data_r;
  wire                                  cmp_data_valid;
  reg                                   cmp_data_valid_r;
  wire                                  cmp_error;
  wire [(PAYLOAD_WIDTH/8)-1:0]          dq_error_bytelane_cmp;

  wire                                  clk;
  wire                                  rst;
  wire [11:0]                           device_temp;
  

// Start of User Design top instance
//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

 mig_7series_0 u_mig_7series_0
      (
// Memory interface ports
       .ddr3_addr                      (ddr3_addr),
       .ddr3_ba                        (ddr3_ba),
       .ddr3_cas_n                     (ddr3_cas_n),
       .ddr3_ck_n                      (ddr3_ck_n),
       .ddr3_ck_p                      (ddr3_ck_p),
       .ddr3_cke                       (ddr3_cke),
       .ddr3_ras_n                     (ddr3_ras_n),
       .ddr3_we_n                      (ddr3_we_n),
       .ddr3_dq                        (ddr3_dq),
       .ddr3_dqs_n                     (ddr3_dqs_n),
       .ddr3_dqs_p                     (ddr3_dqs_p),
       .ddr3_reset_n                   (ddr3_reset_n),
       .init_calib_complete            (init_calib_complete),
       .ddr3_cs_n                      (ddr3_cs_n),
       .ddr3_dm                        (ddr3_dm),
       .ddr3_odt                       (ddr3_odt),
// Application interface ports
       .app_addr                       (app_addr),
       .app_cmd                        (app_cmd),
       .app_en                         (app_en),
       .app_wdf_data                   (app_wdf_data),
       .app_wdf_end                    (app_wdf_end),
       .app_wdf_wren                   (app_wdf_wren),
       .app_rd_data                    (app_rd_data),
       .app_rd_data_end                (app_rd_data_end),
       .app_rd_data_valid              (app_rd_data_valid),
       .app_rdy                        (app_rdy),
       .app_wdf_rdy                    (app_wdf_rdy),
       .app_sr_req                     (1'b0),
       .app_ref_req                    (1'b0),
       .app_zq_req                     (1'b0),
       .app_sr_active                  (app_sr_active),
       .app_ref_ack                    (app_ref_ack),
       .app_zq_ack                     (app_zq_ack),
       .ui_clk                         (ui_clk),
       .ui_clk_sync_rst                (ui_rst),
      
       .app_wdf_mask                   (32'd0),
      
// System Clock Ports
       .sys_clk_i                      (sys_clk_i),
// Reference Clock Ports
       .clk_ref_i                      (clk_ref_i),
       .device_temp                    (device_temp),
       .sys_rst                        (locked)
       );
       
wire RESETn_i2c;
       
//----------------------上电计数复位模块---------------------------//   
count_resetn#(
           .num(20'hffff0)
       )(
           .clk_i(clk_25m),
           .rst_o(RESETn_i2c)
       );    
       
wire	 [9:0]	  i2c_config_index;
wire    [23:0]   i2c_config_data;
wire    [9:0]    i2c_config_size;      
wire    [7:0]    i2c_rdata;        //i2c register data
   
       
//----------------------i2c时序模块---------------------------//
i2c_timing_ctrl
#(
	.CLK_FREQ	(25_000_000),	//100 MHz
	.I2C_FREQ	(100_000)		//10 KHz(<= 400KHz)
)
u_i2c_timing_ctrl
(
	.clk				(clk_25m),
	.rst_n				(RESETn_i2c&&locked),
			
	.i2c_sclk(cmos_sclk_o),//			(cmos_sclk),	
	.i2c_sdat(cmos_sdat_io),//			(cmos_sdat),

	.i2c_config_index	(i2c_config_index),	//i2c config reg index, read 2 reg and write xx reg
	.i2c_config_data	({8'h78, i2c_config_data}),	//i2c config data
	.i2c_config_size	(i2c_config_size),	//i2c config data counte
	.i2c_config_done	(i2c_config_done)	//i2c config timing complete
//	.i2c_rdata			(i2c_rdata)			//i2c register data while read i2c slave
);
       
//----------------------ov7725初始化配置模块---------------------------//
       
I2C_OV5640_RGB565_Config	u_I2C_OV5640_RGB565_Config
(
	.LUT_INDEX		(i2c_config_index),
	.LUT_DATA		(i2c_config_data),
	.LUT_SIZE		(i2c_config_size)
);       
       
wire CH0_FS_i;
wire CH0_wclk_i;
wire CH0_wren_i;
wire [31:0]CH0_data_i;
wire [31:0]CH6_data_o;    
wire cmos_frame_clken;

sensor_decode sensor_decode_inst(
	.cmos_clk_i(clk_25m),//cmos senseor clock.
	.rst_n_i(RESETn_i2c),//system reset.active low.
	.cmos_pclk_i(cmos_pclk_i),//input pixel clock.
	.cmos_href_i(cmos_href_i),//input pixel hs signal.
	.cmos_vsync_i(cmos_vsync_i),//input pixel vs signal.
	.cmos_data_i(cmos_data_i),//data.
	.cmos_xclk_o(cmos_xclk_o),//output clock to cmos sensor.
	.hs_o(),//hs signal.
	.vs_o(CH0_FS_i),//vs signal.
	.rgb_o(CH0_data_i[23:0]),//data output
	.cmos_frame_clken(cmos_frame_clken),
	.clk_ce(CH0_wren_i)
    );
//----------------------vga/hdmi驱动模块---------------------------//  
wire [7:0] rgb_r_i;
wire [7:0] rgb_g_i;
wire [7:0] rgb_b_i;
wire vga_de_o;
wire vga_hs_o;
wire vga_vs_o;
wire[7:0]vga_rgb_r_o;
wire[7:0]vga_rgb_g_o;
wire[7:0]vga_rgb_b_o;
wire vga_req_o,vga_fs_o;

vga_lcd_driver vga_lcd_driver_u0(
    .clk(pixclk),
    .r_i(rgb_r_i),//rgb_r_i
    .g_i(rgb_g_i),//rgb_g_i
    .b_i(rgb_b_i),//rgb_b_i
    .r_o(vga_rgb_r_o[7:0]),
    .g_o(vga_rgb_g_o[7:0]),
    .b_o(vga_rgb_b_o[7:0]),
    .de(vga_de_o),
    .vsync(vga_vs_o),
    .hsync(vga_hs_o)
       ); 

 wire[23:0]  RGB;
 assign RGB={vga_rgb_r_o,vga_rgb_g_o,vga_rgb_b_o};
 HDMI_FPGA_ML_A7_0 u_HDMI1
 (
     .PXLCLK_I           (pixclk),
     .PXLCLK_5X_I        (serclk),
     .LOCKED_I           (hdmi_clk_locked),
     .RST_N              (1'b1),
     .VGA_HS             (vga_hs_o),
     .VGA_VS             (vga_vs_o),
     .VGA_DE             (vga_de_o),
     .VGA_RGB            (RGB),
     .HDMI_CLK_P         (HDMI1_CLK_P),
     .HDMI_CLK_N         (HDMI1_CLK_N),
     .HDMI_D2_P          (HDMI1_D2_P),
     .HDMI_D2_N          (HDMI1_D2_N),
     .HDMI_D1_P          (HDMI1_D1_P),
     .HDMI_D1_N          (HDMI1_D1_N),
     .HDMI_D0_P          (HDMI1_D0_P),
     .HDMI_D0_N          (HDMI1_D0_N)
 );
  
 
//----------------------------------------------------
 //Video Image processor module.
 //Image data prepred to be processd
 wire            per_frame_vsync   =   CH0_FS_i;//CH0_data_i[23:0];    //Prepared Image data vsync valid signal
 wire            per_frame_href    =    cmos_href_i;    //Prepared Image data href vaild  signal
 wire            per_frame_clken    =    CH0_wren_i;    //Prepared Image data output/capture enable clock
 wire    [7:0]    per_img_red        =    {CH0_data_i[15:11], CH0_data_i[15:13]};    //Prepared Image red data to be processed
 wire    [7:0]    per_img_green    =    {CH0_data_i[10:5], CH0_data_i[10:9]};        //Prepared Image green data to be processed
 wire    [7:0]    per_img_blue    =    {CH0_data_i[4:0], CH0_data_i[4:2]};        //Prepared Image blue data to be processed
 wire            post_frame_vsync;    //Processed Image data vsync valid signal
 wire            post_frame_href;    //Processed Image data href vaild  signal
 wire            post_frame_clken;    //Processed Image data output/capture enable clock
 wire    [7:0]    post_img_Y;            //Processed Image brightness output
 wire    [7:0]    post_img_Cb;            //Processed Image blue shading output
 wire    [7:0]    post_img_Cr;            //Processed Image red shading output
 Video_Image_Processor    u_Video_Image_Processor
 (
     //global clock
     .clk                    (cmos_pclk_i),              //cmos video pixel clock
     .rst_n                    (RESETn_i2c),            //global reset
 
     //Image data prepred to be processd
     .per_frame_vsync        (per_frame_vsync),        //Prepared Image data vsync valid signal
     .per_frame_href            (per_frame_href),        //Prepared Image data href vaild  signal
     .per_frame_clken        (per_frame_clken),        //Prepared Image data output/capture enable clock
     .per_img_red            (per_img_red),            //Prepared Image red data to be processed
     .per_img_green            (per_img_green),        //Prepared Image green data to be processed
     .per_img_blue            (per_img_blue),            //Prepared Image blue data to be processed
 
     //Image data has been processd
     .post_frame_vsync        (post_frame_vsync),        //Processed Image data vsync valid signal
     .post_frame_href        (post_frame_href),        //Processed Image data href vaild  signal
     .post_frame_clken        (post_frame_clken),        //Processed Image data output/capture enable clock
     .post_img_Y                (post_img_Y),            //Processed Image brightness output
     .post_img_Cb            (post_img_Cb),            //Processed Image blue shading output
     .post_img_Cr            (post_img_Cr)            //Processed Image red shading output
 );
 
 
 //--------------------------------------------------------------------------------------------------------
 //--------------------------------------------------------------------------------------------------------
 //--------------------------------------------------------------------------------------------------------
 //Sdram_Control_2Port module     
 //sdram write port
// wire            clk_write    =    cmos_pclk_i;    //Change with input signal                                            
 wire    [23:0]    sys_data_in =     {post_img_Y, post_img_Y, post_img_Y};
 wire            sys_we         =      cmos_frame_clken;
 //sdram read port
 //wire            clk_read    =    CH6_rclk_i;    //Change with vga timing    
 //wire    [23:0]    sys_data_out;
//wire            sys_rd;
 //wire            sdram_init_done;            //sdram init done 
 
  
 wire CH6_rclk_i;
 wire CH6_rden_i;
 wire CH6_FS_i;
assign CH0_wclk_i = cmos_pclk_i;
assign rgb_r_i = CH6_data_o[23:16];
assign rgb_g_i = CH6_data_o[15:8];
assign rgb_b_i = CH6_data_o[7:0];
assign CH6_rclk_i = pixclk;
assign CH6_rden_i = vga_de_o;
assign CH6_FS_i   = vga_vs_o;


 
MIG_BURST_IMAGE#
(
   .ADDR_WIDTH(28)
)
MIG_BURST_IMAGEP_inst
(
	.app_addr(app_addr),
	.app_cmd(app_cmd),
	.app_en(app_en),
	.app_wdf_data(app_wdf_data),
	.app_wdf_end(app_wdf_end),
	.app_wdf_wren(app_wdf_wren),
	
	.app_rd_data(app_rd_data),
	.app_rd_data_valid(app_rd_data_valid),
	.app_rdy(app_rdy),
	.app_wdf_rdy(app_wdf_rdy),
	.ui_clk(ui_clk),
	.ui_rst(ui_rst|(!init_calib_complete)),
  
	//Sensor video 640x480p
	.CH0_FS_i(post_frame_vsync),//post_frame_vsync//CH0_FS_i
	.CH0_wclk_i(CH0_wclk_i),
	.CH0_wren_i(post_frame_clken),//CH0_wren_i//post_frame_clken
	.CH0_data_i({8'd0,sys_data_in[23:0]}),//rgb565////CH0_data_i[23:0]}//sys_data_in[23:0]8'hff,8'h00,8'h00}
	//vga/hdmi output 1280x720p
	.CH6_FS_i(CH6_FS_i),
	.CH6_rclk_i(CH6_rclk_i),
	.CH6_rden_i(CH6_rden_i),
	.CH6_data_o(CH6_data_o)
    );
   
endmodule
