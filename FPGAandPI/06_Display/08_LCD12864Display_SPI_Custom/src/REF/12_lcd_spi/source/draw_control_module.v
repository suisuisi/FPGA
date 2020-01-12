module draw_control_module
(
    CLK, RSTn,
	 Start_Sig,
	 Draw_Data,
	 SPI_Done_Sig,
	 SPI_Start_Sig,
	 SPI_Data,
	 Rom_Addr,
	 Done_Sig
);

    input CLK, RSTn;
	 input Start_Sig;
	 input [7:0]Draw_Data;
	 input SPI_Done_Sig;
	 output SPI_Start_Sig;
	 output [9:0]SPI_Data;
	 output [9:0]Rom_Addr;
	 output Done_Sig;
	 
	 /********************************/
	 
	 reg [5:0]i;
	 reg [7:0]x;
	 reg [3:0]y;
	 reg [9:0]rData;
	 reg isSPI_Start;
	 reg isDone;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		       begin 
				     i <= 6'd0;
					  x <= 8'd0;
					  y <= 4'd0;
					  rData <= { 2'b11, 8'h00 };
					  isSPI_Start <= 1'b0;
					  isDone <= 1'b0;
			    end
			else if( Start_Sig )
			    case( i )
				 
				    6'd0, 6'd4, 6'd8, 6'd12, 6'd16, 6'd20, 6'd24, 6'd28:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 4'hb, y }; isSPI_Start <= 1'b1; end

					 6'd1, 6'd5, 6'd9, 6'd13, 6'd17, 6'd21, 6'd25, 6'd29:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 4'h1, 4'h0 }; isSPI_Start <= 1'b1; end
					 
					 6'd2, 6'd6, 6'd10, 6'd14, 6'd18, 6'd22, 6'd26, 6'd30:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 4'h0, 4'h0 }; isSPI_Start <= 1'b1; end
					 
					 6'd3, 6'd7, 6'd11, 6'd15, 6'd19, 6'd23, 6'd27, 6'd31:
					 if( x == 8'd128 ) begin y <= y + 1'b1; x <= 8'd0; i <= i + 1'b1; end
                else if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; x <= x + 1'b1; end
					 else begin rData <= { 2'b01, Draw_Data }; isSPI_Start <= 1'b1; end
					 
                6'd32:
                begin rData <= { 2'b11, 8'd0 }; y <= 4'd0; isDone <= 1'b1; i <= i + 1'b1; end			
			
                6'd33:
			       begin isDone <= 1'b0; i <= 6'd0; end		 
					
				 endcase
				 
    /*****************************/
	 
	 assign SPI_Start_Sig = isSPI_Start;
	 assign Rom_Addr = x + (y << 7);
	 assign SPI_Data = rData;
	 assign Done_Sig = isDone;
				     	 
	 /******************************/

endmodule
