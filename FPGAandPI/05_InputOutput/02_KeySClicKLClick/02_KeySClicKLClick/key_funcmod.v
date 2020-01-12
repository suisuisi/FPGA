module key_funcmod
(
    input CLOCK, RESET,
	 input KEY,
	 output [1:0]LED
);
    parameter T10MS	 	= 28'd500_000;
	 parameter T100MS 	= 28'd5_000_000; 
	 parameter T200MS 	= 28'd10_000_000; 
	 parameter T300MS 	= 28'd15_000_000; 
	 parameter T400MS 	= 28'd20_000_000; 
	 parameter T500MS 	= 28'd25_000_000; 
	 
	 /**********************************/ //sub
	 
	 reg F2,F1;
		 
	 always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET ) 
		      { F2, F1 } <= 2'b11;
		  else 
		      { F2, F1 } <= { F1, KEY };
				
	 /**********************************/ //core
	
	 wire isH2L = ( F2 == 1 && F1 == 0 );
	 wire isL2H = ( F2 == 0 && F1 == 1 );
	 reg [3:0]i;
	 reg isDClick,isSClick;
	 reg [1:0]isTag;
	 reg [27:0]C1;
	 
	 always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		       begin
				    i <= 4'd0;
					 isDClick <= 1'd0;
					 isSClick <= 1'b0;
					 isTag <= 2'd0;
					 C1 <= 28'd0;
				 end
		  else
		      case(i)
					 
					 0: // Wait H2L
					 if( isH2L ) begin i <= i + 1'b1; end
					 
					 1: // H2L debounce
					 if( C1 == T10MS -1 ) begin C1 <= 28'd0; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;
					 
					 2: // Wait L2H
					 if( isL2H ) i <= i + 1'b1;
					 
					 3: // L2H debounce
					 if( C1 == T10MS -1 ) begin C1 <= 28'd0; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;
					 
					 4: // Key Tag Check	 
					 if( isH2L && C1 <= T100MS -1 ) begin isTag <= 2'd2; C1 <= 28'd0; i <= i + 1'b1; end
					 else if( C1 >= T100MS -1) begin isTag <= 2'd1; C1 <= 28'd0; i <= i + 1'b1; end
					 else C1 <= C1 + 1'b1;	
					 
					 5: // Key trigger press up
					 if( isTag == 2'd2 ) begin isDClick <= 1'b1; i <= i + 1'b1; end
					 else if( isTag == 2'd1 ) begin isSClick <= 1'b1; i <= i + 1'b1; end
					 
					 6: // Key trigger pree down
					 begin { isSClick , isDClick } <= 2'b00; i <= i + 1'b1; end
					 
					 7: // L2H deounce check
					 if( isTag == 2'd1 ) begin isTag <= 2'd0; i <= 4'd0; end
					 else if( isTag == 2'd2 ) begin isTag <= 2'd0; i <= i + 1'b1; end
					 
					 8: // Wait L2H
					 if( isL2H ) begin i <= i + 1'b1; end
						 
				    9: // L2H debounce
					 if( C1 == T10MS -1 ) begin C1 <= 28'd0; i <= 4'd0; end
					 else C1 <= C1 + 1'b1;
					 
				endcase
				
	 /*************************/ // sub-demo			
	
	reg [1:0]D1;
	
	always @ ( posedge CLOCK or negedge RESET )
	    if( !RESET )
		     D1 <= 2'd0;
		 else if( isDClick )
		     D1[1] <= ~D1[1];
		 else if( isSClick )
		     D1[0] <= ~D1[0];
			  
	/***************************/
		 
	assign LED = D1;

endmodule
