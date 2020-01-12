//*****************************************************************************
// (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 4.0
//  \   \         Application        : MIG
//  /   /         Filename           : example_top.v
// /___/   /\     Date Last Modified : $Date: 2011/06/02 08:35:03 $
// \   \  /  \    Date Created       : Tue Sept 21 2010
//  \___\/\___\
//
// Device           : 7 Series
// Design Name      : DDR3 SDRAM
// Purpose          :
//   Top-level  module. This module serves as an example,
//   and allows the user to synthesize a self-contained design,
//   which they can be used to test their hardware.
//   In addition to the memory controller, the module instantiates:
//     1. Synthesizable testbench - used to model user's backend logic
//        and generate different traffic patterns
// Reference        :
// Revision History :
//*****************************************************************************

//`define SKIP_CALIB
`timescale 1ps/1ps

module example_top #
  (
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
   
   output                       tg_compare_error,
   output                       init_calib_complete,
   input                        clk50m_i,
   input                        rst_key
   );

wire sys_rst;
wire locked;
wire clk_ref_i;
wire sys_clk_i;
wire clk_200;
   
assign sys_rst = ~rst_key;//复位信号
assign clk_ref_i = clk_200;//200M的参考时钟
assign sys_clk_i = clk_200;//200M的系统时钟

//时钟管理产生DDR需要的时钟   
clk_wiz_0 CLK_WIZ_DDR( .clk_out1(clk_200),.reset(sys_rst),.locked(locked),.clk_in1(clk50m_i)); 

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
       .ui_clk                         (clk),
       .ui_clk_sync_rst                (rst),
      
       .app_wdf_mask                   (32'd0),
      
// System Clock Ports
       .sys_clk_i                      (sys_clk_i),
// Reference Clock Ports
       .clk_ref_i                      (clk_ref_i),
       .device_temp                    (device_temp),
       .sys_rst                        (locked)
       );
       
//以下是读写测试       
// End of User Design top instance
parameter	[2:0]CMD_WRITE	=3'd0;
parameter	[2:0]CMD_READ	=3'd1;
//parameter TEST_DATA_RANGE=24'd16777215;//全地址测试
parameter TEST_DATA_RANGE=24'd2000;//部分测试

(*mark_debug="true"*)	wire init_calib_complete;
(*mark_debug="true"*)	reg	[3:0]state=0;
(*mark_debug="true"*)	reg	[23:0]Count_64=0;// 128M*2*16/256
(*mark_debug="true"*)	reg	[23:0]Count_64_1=0;
(*mark_debug="true"*)	reg	ProsessIn=0;//表示读写操作的包络
(*mark_debug="true"*)	reg	WriteSign=0;//表示是写操作
(*mark_debug="true"*)	reg	ProsessIn1=0;//表示写操作的包络
reg	[ADDR_WIDTH-1:0]app_addr_begin=0;
reg	[29:0]CountWrite_tem=0;
reg	[29:0]CountRead_tem=0;


(*mark_debug="true"*)	reg	[29:0]						CountWrite=0;
(*mark_debug="true"*)	reg	[29:0]						CountRead=0;
(*mark_debug="true"*)	reg								error_rddata=0;

assign	app_wdf_end						=app_wdf_wren;//两个相等即可
assign	app_en							=ProsessIn?(WriteSign?app_rdy&&app_wdf_rdy:app_rdy):1'd0;//控制命令使能
assign	app_cmd							=WriteSign?CMD_WRITE:CMD_READ;
assign	app_addr						=app_addr_begin;
assign	app_wdf_data					=Count_64_1;//写入的数据是计数器
assign	app_wdf_wren					=ProsessIn1?app_rdy&&app_wdf_rdy:1'd0;
always@(posedge clk)
	if(rst&!init_calib_complete)//
		begin
		state							<=4'd0;
		app_addr_begin					<=28'd0;
		WriteSign						<=1'd0;
		ProsessIn						<=1'd0;
		Count_64						<=24'd0;
		end
else case(state)
4'd0:	begin
		state							<=4'd1;
		app_addr_begin					<=28'd0;
		WriteSign						<=1'd0;
		ProsessIn						<=1'd0;
		Count_64						<=24'd0;
		CountWrite_tem					<=30'd0;//??0
		CountRead_tem					<=30'd0;
		CountWrite						<=CountWrite_tem;//?¨?D?
		CountRead						<=CountRead_tem;
		end
4'd1:	begin
		state							<=4'd2;
		WriteSign						<=1'd1;
		ProsessIn						<=1'd1;	
		Count_64						<=24'd0;	
		app_addr_begin					<=28'd0;
		CountWrite_tem					<=CountWrite_tem+30'd1;
		end
4'd2:	begin//写整片的DDR3
		state							<=(Count_64==TEST_DATA_RANGE)&&app_rdy&&app_wdf_rdy?4'd3:4'd2;//最后一个地址写完之后跳出状态
		WriteSign						<=(Count_64==TEST_DATA_RANGE)&&app_rdy&&app_wdf_rdy?1'd0:1'd1;//写数据使能
		ProsessIn						<=(Count_64==TEST_DATA_RANGE)&&app_rdy&&app_wdf_rdy?1'd0:1'd1;//写命令使能
		Count_64						<=app_rdy&&app_wdf_rdy?(Count_64+24'd1):Count_64;	
		app_addr_begin					<=app_rdy&&app_wdf_rdy?(app_addr_begin+28'd8):app_addr_begin;//跳到下一个（8*32=256）bit数据地址
		CountWrite_tem					<=CountWrite_tem+30'd1;
		end
4'd3:	begin
		state							<=(state1==4'd0)?4'd4:state;
		WriteSign						<=1'd0;
		ProsessIn						<=(state1==4'd0)?1'd1:1'd0;
		Count_64						<=24'd0;	
		app_addr_begin					<=28'd0;	
		CountWrite_tem					<=CountWrite_tem+30'd1;
		end
4'd4:	begin//读整片的DDR3
		state							<=(Count_64==TEST_DATA_RANGE)&&app_rdy?4'd0:state;
		WriteSign						<=1'd0;
		ProsessIn						<=(Count_64==TEST_DATA_RANGE)&&app_rdy?1'd0:1'd1;	
		Count_64						<=app_rdy?(Count_64+24'd1):Count_64;	
		app_addr_begin					<=app_rdy?(app_addr_begin+28'd8):app_addr_begin;
		CountRead_tem					<=CountRead_tem+30'd1;
		end
default:begin
		state							<=4'd1;
		app_addr_begin					<=28'd0;
		WriteSign						<=1'd0;
		ProsessIn						<=1'd0;
		Count_64						<=24'd0;
		end		
	endcase
	
(*mark_debug="true"*)	reg	[3:0]state1=0;
always@(posedge clk)//单独将写操作从上面的状态机提出来，当然也可以和上面的状态机合并到一起
	if(rst&!init_calib_complete)//
		begin
		state1							<=4'd0;
		ProsessIn1						<=1'd0;
		end
else case(state1)
4'd0:	begin
		state1							<=(state==4'd1)?4'd1:4'd0;
		ProsessIn1						<=(state==4'd1)?1'd1:1'd0;
		Count_64_1						<=24'd0;
		end
4'd1:	begin
		state1							<=(Count_64_1==TEST_DATA_RANGE)&&app_rdy&&app_wdf_rdy?4'd0:4'd1;
		ProsessIn1						<=(Count_64_1==TEST_DATA_RANGE)&&app_rdy&&app_wdf_rdy?1'd0:1'd1;	
		Count_64_1						<=app_rdy&&app_wdf_rdy?(Count_64_1+24'd1):Count_64_1;	
		end
default:begin
		state1							<=(state==4'd1)?4'd1:4'd0;
		ProsessIn1						<=(state==4'd1)?1'd1:1'd0;
		Count_64_1						<=24'd0;
		end
		endcase
	
(*mark_debug="true"*)	reg	[255:0]app_rd_data_tem=0;
always@(posedge clk)
	begin
	app_rd_data_tem				<=app_rd_data_valid?app_rd_data:app_rd_data_tem;//暂存上一个数据，用来做错误判断
	// error_rddata				<=app_rd_data_valid?(((app_rd_data-app_rd_data_tem)!=256'd1)&&(app_rd_data!=256'd0))||((app_rd_data==256'd0)?(app_rd_data_tem!=256'd16777215):1'd0):1'd0;
	error_rddata				<=app_rd_data_valid&&
				(
				(((app_rd_data-app_rd_data_tem)!=256'd1)&&(app_rd_data!=256'd0))||((app_rd_data==256'd0)&&(app_rd_data_tem!=TEST_DATA_RANGE))
				);//判断读出的数据是否是递增数据
	end
	
assign tg_compare_error = error_rddata;
wire [255:0]diff;
assign diff=app_rd_data-app_rd_data_tem;
wire diff_sign0;
assign diff_sign0=(((app_rd_data-app_rd_data_tem)!=256'd1)&&(app_rd_data!=256'd0));
wire diff_sign1;
assign diff_sign1=((app_rd_data-app_rd_data_tem)!=256'd1);
wire diff_sign2;
assign diff_sign2=(((app_rd_data-app_rd_data_tem)!=256'd1)&&(app_rd_data!=256'd0))||((app_rd_data==256'd0)&&(app_rd_data_tem!=TEST_DATA_RANGE));

endmodule
