`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:28:42 01/05/2015 
// Design Name: 
// Module Name:    hdmi_ddr_output 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module hdmi_ddr_output(
    input clk,
    input clk90,
    input [7:0] y,
    input [7:0] c,
    input hsync_in,
    input vsync_in,
    input de_in,
    output hdmi_clk,
    output hdmi_hsync,
    output hdmi_vsync,
    output [15:0] hdmi_d,
    output hdmi_de
    );
    
   reg  hdmi_hsync_r;
   reg  hdmi_vsync_r;
   
   assign hdmi_hsync = hdmi_hsync_r;
   assign hdmi_vsync = hdmi_vsync_r;
   
always@(posedge clk) begin
         hdmi_hsync_r <= hsync_in;
         hdmi_vsync_r <= vsync_in;
 end
 
assign hdmi_clk = clk90;
assign hdmi_de = de_in;
	 
   generate
	genvar i;
  for(i=0;i<=7;i=i+1) begin: inst_generate
	  ODDR#(
		  .DDR_CLK_EDGE("SAME_EDGE"), 
		  .INIT(1'b0),
		  .SRTYPE("SYNC")
		  )  ODDR_hdmi_d (
		  .C(clk),
		  .Q(hdmi_d[i+8]),  
		  .D1(y[i]), 
		  .D2(c[i]), 
		  .CE(1'b1), 
		  .R(1'b0), 
		  .S(1'b0)
		  );		
end		  

endgenerate 
  
assign hdmi_d[7:0] = 8'b0000_0000;

//assign hdmi_d[15:0] = 16'b1111_1111_1111_1111; //just fot test
//   -----------------------------------------------------------------------   
//   -- This sends the configuration register values to the HDMI transmitter
//   ----------------------------------------------------------------------- 
	
	
endmodule
