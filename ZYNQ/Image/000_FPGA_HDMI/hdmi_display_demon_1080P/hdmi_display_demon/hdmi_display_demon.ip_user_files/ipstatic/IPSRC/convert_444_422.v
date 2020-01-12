`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:05 01/05/2015 
// Design Name: 
// Module Name:    convert_444_422 
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
module convert_444_422(
//input signal 
    input clk,
    input [7:0] r_in,           //  R
    input [7:0] g_in,           // G
    input [7:0] b_in,           // B
    input hsync_in,
    input vsync_in,
    input de_in,
    
//output signal 
    output [8:0] r1_out,
    output [8:0] g1_out,
    output [8:0] b1_out,
    output [8:0] r2_out,
    output [8:0] g2_out,
    output [8:0] b2_out,
    output pair_start_out,
    output hsync_out,
    output vsync_out,
    output de_out
    );
    reg [8:0] r1_out_r;
    reg [8:0] g1_out_r;
    reg [8:0] b1_out_r;
    reg [8:0] r2_out_r;
    reg [8:0] g2_out_r;
    reg [8:0] b2_out_r;
    reg pair_start_out_r;
    reg hsync_out_r;
    reg vsync_out_r;
    reg de_out_r;
     
    reg [7:0] r_a;
    reg [7:0] g_a;
    reg [7:0] b_a;
    reg h_a;
    reg v_a;
    reg d_a;
    reg d_a_last;
 
    reg flag;    //flag is used to work out which pairs of pixels to sum.
    
 always@(posedge clk) begin
 //sync pairs to the de_in going high (if a scan line has odd pixel count)
      if ((d_a == 1'b1 & d_a_last == 1'b0) || flag == 1'b1) begin
//  ok	将 r_a ,g_a, b_a 都扩大 2倍， 采用后面补零的方式扩大	
		   r2_out_r <= {r_a,1'b0};
         g2_out_r <= {g_a,1'b0};
         b2_out_r <= {b_a,1'b0};
			
// ok  同样是将 r_a ,g_a, b_a 都扩大 2倍，只是采用相加的方式
//       r2_out_r <= {1'b0,r_a} +  {1'b0,r_in};  
       //r2_out_r <= {1'b0,r_a} +  {1'b0,r_a}; 
       //r2_out_r <= {1'b0,r_in} +  {1'b0,r_in};  
		 
//       g2_out_r <= {1'b0,g_a} +  {1'b0,g_in};
//       b2_out_r <= {1'b0,b_a} +  {1'b0,b_in};		

// ok but colour is light
//         r2_out_r <= {1'b0,r_a} ;//+  {1'b0,r_in};
//         g2_out_r <= {1'b0,g_a} ;//+  {1'b0,g_in};
//         b2_out_r <= {1'b0,b_a};// +  {1'b0,b_in};		
			
         flag   <= 1'b0;
         pair_start_out_r <= 1'b1;
      end
      else begin
         flag <= 1'b1;
         pair_start_out_r <= 1'b0;
      end
      
		//  r1 & g1 & b1 都扩大了两倍
      r1_out_r    <= {r_a,1'b0};
      g1_out_r    <= {g_a,1'b0};
      b1_out_r    <= {b_a,1'b0};
		
      hsync_out_r <= h_a;
      vsync_out_r <= v_a;
      de_out_r    <= d_a;
      d_a_last    <= d_a;
   
      r_a <= r_in;
      g_a <= g_in;
      b_a <= b_in;
      h_a <= hsync_in;
      v_a <= vsync_in;
      d_a <= de_in;
          
 end   
 
 assign   r1_out = r1_out_r;
 assign   g1_out = g1_out_r;
 assign   b1_out = b1_out_r;
 assign   r2_out = r2_out_r;
 assign   g2_out = g2_out_r;
 assign   b2_out = b2_out_r;
 assign   pair_start_out = pair_start_out_r;
 assign   hsync_out = hsync_out_r;
 assign   vsync_out = vsync_out_r;
 assign   de_out = de_out_r;
    
endmodule
