module vga_control_module
(
    CLK, RSTn,
	 Ready_Sig, Column_Addr_Sig, Row_Addr_Sig,
	 Red_Sig, Green_Sig, Blue_Sig
);
    input CLK;
	 input RSTn;
	 input Ready_Sig;
	 input [10:0]Column_Addr_Sig;
	 input [10:0]Row_Addr_Sig;
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	 
	 /**********************************/
	 
	 reg isRectangle;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      isRectangle <= 1'b0;
		  else if( Column_Addr_Sig > 11'd0 && Row_Addr_Sig < 11'd100 )
            isRectangle <= 1'b1;
		  else
		      isRectangle <= 1'b0;
				
	/************************************/
				
	 assign Red_Sig = Ready_Sig && isRectangle ? 1'b1 : 1'b0;
	 assign Green_Sig = Ready_Sig && isRectangle ? 1'b1 : 1'b0;
	 assign Blue_Sig = Ready_Sig && isRectangle ? 1'b1 : 1'b0;
	 
	/***********************************/
	 

endmodule
