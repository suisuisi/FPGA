module vga_control_module
(
    CLK, RSTn,
	 Ready_Sig, Frame_Sig, Column_Addr_Sig, Row_Addr_Sig,
	 Rom_Data, Rom_Addr,
	 Red_Sig, Green_Sig, Blue_Sig
);
    input CLK;
	 input RSTn;
	 input Ready_Sig;
	 input Frame_Sig;
	 input [10:0]Column_Addr_Sig;
	 input [10:0]Row_Addr_Sig;
	 
	 input [15:0]Rom_Data;
	 output [6:0]Rom_Addr;
	 
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	 
	 /************************************/
	 
	 reg [4:0]m;
	
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      m <= 5'd0;
		  else if( Ready_Sig && Row_Addr_Sig < 16 )
		      m = Row_Addr_Sig[4:0] ;
		  else
		      m = 5'd0;
				
	 reg [4:0]n;
	
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      n <= 5'd0;
		  else if( Ready_Sig && Column_Addr_Sig > 2 && Column_Addr_Sig < 19 )
		      n = Column_Addr_Sig[4:0] - 5'd3;
		  else
		      n = 5'd0;
			  
	 /**********************************/
	 
	 parameter FRAME = 10'd60;
	 
	 /**********************************/
	 
	 reg [9:0]Count_Frame;

	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
            Count_Frame <= 10'd0;
		  else if( Count_Frame == FRAME )
		      Count_Frame <= 10'd0;
		  else if( Frame_Sig )
		      Count_Frame <= Count_Frame + 1'b1;
	
    /************************************/	
		      
	 reg [6:0]rAddr;
	 reg [3:0]i;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
		          rAddr <= 7'd0;
					 i <= 4'd0;
			   end
		  else
		      case ( i )
				
				    4'd0 : 
					 if( Count_Frame == FRAME ) i <= 4'd1; 
					 else rAddr <= 7'd0;
					 
					 4'd1 :
					 if( Count_Frame == FRAME ) i <= 4'd2;
					 else rAddr <= 7'd16;
					 
					 4'd2 :
					 if( Count_Frame == FRAME ) i <= 4'd3;
					 else rAddr <= 7'd32;
					 
					 4'd3 :
					 if( Count_Frame == FRAME ) i <= 4'd4;
					 else rAddr <= 7'd48;
				    
					 4'd4 :
					 if( Count_Frame == FRAME ) i <= 4'd5;
					 else rAddr <= 7'd48;
					 
					 4'd5 :
					 if( Count_Frame == FRAME ) i <= 4'd6;
					 else rAddr <= 7'd64;
					 
					 4'd6 :
					 if( Count_Frame == FRAME ) i <= 4'd0;
					 else rAddr <= 7'd80;
					 
				endcase
				
	 /************************************/
	
    assign Rom_Addr = rAddr + m;
	
	 assign Red_Sig = Ready_Sig ? Rom_Data[ 5'd15 - n ] : 1'b0;
	 assign Green_Sig = Ready_Sig ? Rom_Data[ 5'd15 - n ] : 1'b0;
	 assign Blue_Sig = Ready_Sig ? Rom_Data[ 5'd15 - n ] : 1'b0;
	 
	/***********************************/
	 

endmodule
