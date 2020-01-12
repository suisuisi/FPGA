module smg_funcmod
(
    input CLOCK, RESET,
	 input [23:0]iData,
	 output [9:0]oData
);
	 parameter T100US = 13'd5000;
	 
	 reg [3:0]i;
	 reg [12:0]C1;
	 reg [3:0]D1;
	 reg [5:0]D2;
	 
	 always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin
		          i <= 4'd0;
					 C1 <= 13'd0;
			    	 D1 <= 4'd0;
					 D2 <= 6'b111_110;
				end
		  else 
		      case( i )
				
				    0:
					 if( C1 == T100US -1 ) begin C1 <= 13'd0; i <= i + 1'b1; end
				    else begin C1 <= C1 + 1'b1; D1 <= iData[23:20]; D2 <= 6'b111_110; end
					 
					 1:
					 if( C1 == T100US -1 ) begin C1 <= 13'd0; i <= i + 1'b1; end
				    else begin C1 <= C1 + 1'b1; D1 <= iData[19:16]; D2 <= 6'b111_101; end
					 
					 2:
					 if( C1 == T100US -1 ) begin C1 <= 13'd0; i <= i + 1'b1; end
				    else begin C1 <= C1 + 1'b1; D1 <= iData[15:12]; D2 <= 6'b111_011; end
					 
					 3:
					 if( C1 == T100US -1 ) begin C1 <= 13'd0; i <= i + 1'b1; end
				    else begin C1 <= C1 + 1'b1; D1 <= iData[11:8]; D2 <= 6'b110_111; end
					 
					 4:
					 if( C1 == T100US -1 ) begin C1 <= 13'd0; i <= i + 1'b1; end
				    else begin C1 <= C1 + 1'b1; D1 <= iData[7:4]; D2 <= 6'b101_111; end
					 
					 5:
					 if( C1 == T100US -1 ) begin C1 <= 13'd0; i <= 4'd0; end
				    else begin C1 <= C1 + 1'b1; D1 <= iData[3:0]; D2 <= 6'b011_111; end
					 
				endcase
	 
	 assign oData = {D1,D2};
	 
endmodule
