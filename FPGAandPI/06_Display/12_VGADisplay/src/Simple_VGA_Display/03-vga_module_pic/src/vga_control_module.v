module vga_control_module
(
    CLK, RSTn,
	 Ready_Sig, Column_Addr_Sig, Row_Addr_Sig,
	 Rom_Data, Rom_Addr,
	 Red_Sig, Green_Sig, Blue_Sig
);
    input CLK;
	 input RSTn;
	 input Ready_Sig;
	 input [10:0]Column_Addr_Sig;
	 input [10:0]Row_Addr_Sig;
	 
	 input [63:0]Rom_Data;
	 output [5:0]Rom_Addr;
	 
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	
	 /**********************************/
	 
	 reg [5:0]m;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      m <= 6'd0; 
		  else if( Ready_Sig && Row_Addr_Sig < 64 )
		      m <= Row_Addr_Sig[5:0];
				
	/************************************/
	
	reg [5:0]n;
	
	always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn )
		     n <= 6'd0;
		 else if( Ready_Sig && Column_Addr_Sig < 64 )
		     n <= Column_Addr_Sig[5:0];			  
				
	/************************************/
	
    assign Rom_Addr = m;
	
	 assign Red_Sig =  Ready_Sig ? Rom_Data[ 6'd63 - n ] : 1'b0;
	 assign Green_Sig = Ready_Sig ? Rom_Data[ 6'd63 - n ] : 1'b0;
	 assign Blue_Sig = Ready_Sig ? Rom_Data[ 6'd63 - n ] : 1'b0;
	 
	/***********************************/
	 

endmodule
