module detect_module 
(
    CLK, RSTn, Pin_In, H2L_Sig, L2H_Sig
);

    input CLK;
	 input RSTn;
	 input Pin_In;
	 output H2L_Sig;
	 output L2H_Sig;
	 
	 /**********************************/
	 
	 parameter T100US = 11'd4_999;//DB4CE15开发板使用的晶振为50MHz，50M*0.0001-1=4_999
	 
	 /**********************************/
	 
	 reg [10:0]Count1;
	 reg isEn;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
		          Count1 <= 11'd0;
		          isEn <= 1'b0;
				end
	     else if( Count1 == T100US )
				isEn <= 1'b1;
		  else
		      Count1 <= Count1 + 1'b1;
				
    /********************************************/
	 
	 reg H2L_F1;
	 reg H2L_F2;
	 reg L2H_F1;
	 reg L2H_F2;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
				    H2L_F1 <= 1'b1;
					 H2L_F2 <= 1'b1;
					 L2H_F1 <= 1'b0;
					 L2H_F2 <= 1'b0;
			   end
		  else
		      begin
					 H2L_F1 <= Pin_In; 
					 H2L_F2 <= H2L_F1;
					 L2H_F1 <= Pin_In;
					 L2H_F2 <= L2H_F1;
				end
				
    /***********************************/
	 

	 assign H2L_Sig = isEn ? ( H2L_F2 & !H2L_F1 ) : 1'b0;
	 assign L2H_Sig = isEn ? ( !L2H_F2 & L2H_F1 ) : 1'b0;

	 
	 /***********************************/
	 
endmodule

	     
	 