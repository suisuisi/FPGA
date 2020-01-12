`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/28 16:13:32
// Design Name: 
// Module Name: OV7725_Tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module OV7725_Tb(

    );
        
wire  [27:0]      app_addr;
wire  [2:0]       app_cmd;
wire              app_en;
wire  [255:0]     app_wdf_data;
wire              app_wdf_end;
wire              app_wdf_wren;
            
reg   [255:0]     app_rd_data;
reg               app_rd_data_valid;
reg               app_rdy;
reg               app_wdf_rdy;
        //------------------------------ ddr hardware interface ------------------------------//
wire vga_clk_o;
wire vga_blank_o;
wire vga_hs_o;
wire vga_vs_o;
wire[7:0]vga_rgb_r_o;
wire[7:0]vga_rgb_g_o;
wire[7:0]vga_rgb_b_o;
        
reg       clk50m_i;
reg       rst_key;
           
OV7725_TOP OV7725_TOP_inst
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
    //----------------------------- VGA/HDMI hardware interface ----------------------------/
    .vga_clk_o(vga_clk_o),
    .vga_blank_o(vga_blank_o),
    .vga_hs_o(vga_hs_o),
    .vga_vs_o(vga_vs_o),
    .vga_rgb_r_o(vga_rgb_r_o),
    .vga_rgb_g_o(vga_rgb_g_o),
    .vga_rgb_b_o(vga_rgb_b_o),
    
    .clk50m_i(clk50m_i),
    .rst_key(rst_key)
    );    
    
  initial begin
      rst_key = 1'b0;
      #10000
        rst_key = 1'b1;
     end
  
     
 initial  clk50m_i = 1'b0;
       
 always #5 clk50m_i =  ~clk50m_i;    

 
 always @(posedge clk50m_i )
  if(rst_key==1'b0) begin
  app_rd_data=256'd0;
  app_rd_data_valid=1'b0;
  app_rdy=1'b0;
  app_wdf_rdy=1'b0;
 end
else begin
  app_rd_data=app_rd_data+1'b1;;
  app_rd_data_valid=1'b1;
  app_rdy=1'b1;
  app_wdf_rdy=1'b1;
 end  
endmodule
