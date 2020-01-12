module lcd_control_module
(
    CLK, RSTn,
	 Init_Done_Sig, Draw_Done_Sig,
	 Init_Start_Sig, Draw_Start_Sig
);

    input CLK;
	 input RSTn;
	 input Init_Done_Sig, Draw_Done_Sig;
	 output Init_Start_Sig, Draw_Start_Sig;

	 /***************************************/
	 
	 reg [3:0]i;
	 reg isInit;
	 reg isDraw;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
				    i <= 4'd0;
					 isInit <= 1'b0;
					 isDraw <= 1'b0;
				end
		   else 
			    case( i )
				     
					  4'd0:
					  if( Init_Done_Sig ) begin isInit <= 1'b0; i <= i + 1'b1; end
					  else isInit <= 1'b1;
					  
					  4'd1:
					  if( Draw_Done_Sig ) begin isDraw <= 1'b0; i <= i + 1'b1; end
					  else isDraw <= 1'b1;
					  
					  4'd2:
					  i <= 4'd2;
					  
				 endcase
				 
    /*********************************/
	 
	 assign Init_Start_Sig = isInit;
	 assign Draw_Start_Sig = isDraw;
	 
	 /*********************************/
	 
endmodule
