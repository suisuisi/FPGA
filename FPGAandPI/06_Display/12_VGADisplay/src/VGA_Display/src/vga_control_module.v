module vga_control_module
(
    CLK, RSTn,
	 Ready_Sig, Column_Addr_Sig, Row_Addr_Sig,
	 Ram_Data, Ram_Addr,
	 Red_Sig, Green_Sig, Blue_Sig
);
    input CLK;
	 input RSTn;
	 
	 input Ready_Sig;
	 input [10:0]Column_Addr_Sig;
	 input [10:0]Row_Addr_Sig;
	 
	 input [15:0]Ram_Data;
	 output [3:0]Ram_Addr;
	 
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	 
	 /************************************/
	 
	 reg [4:0]m;
	
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      m <= 5'd0;
		  else if( Ready_Sig && Row_Addr_Sig > 1 && Row_Addr_Sig < 18 )
		      m <= Row_Addr_Sig[4:0] - 5'd2;
		  else
		      m <= 5'd0;
				
	 reg [4:0]n;
	
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      n <= 5'd0;
		  else if( Ready_Sig && Column_Addr_Sig > 2 && Column_Addr_Sig < 19 )
		      n <= Column_Addr_Sig[4:0] - 5'd3;
		  else
		      n <= 5'd0;	
				
	 /**********************************/
	 
	 reg isSize;
   
    always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn )
		    isSize <= 1'b0;
		 else if( ( Row_Addr_Sig > 1 && Row_Addr_Sig < 18 ) && 
		          ( Column_Addr_Sig > 2 && Column_Addr_Sig < 19 ) )
		    isSize <= 1'b1;
		 else 
		    isSize <= 1'b0; 
    
    /**********************************/	 	
	
    assign Ram_Addr =  m[3:0] ;
	
	 assign Red_Sig = Ready_Sig && isSize ? Ram_Data[ 5'd15 - n ] : 1'b0;
	 assign Green_Sig = Ready_Sig && isSize ? Ram_Data[ 5'd15 - n ] : 1'b0;
	 assign Blue_Sig = Ready_Sig && isSize ? Ram_Data[ 5'd15 - n ] : 1'b0;
	 
	/***********************************/
	 

endmodule
