module initial_control_module
(
    CLK, RSTn,
	 Start_Sig,
	 SPI_Done_Sig,
	 SPI_Start_Sig,
	 SPI_Data,
	 Done_Sig
);

    input CLK;
	 input RSTn;
	 input Start_Sig;
	 input SPI_Done_Sig;
	 output SPI_Start_Sig;
	 output [9:0]SPI_Data;
	 output Done_Sig;
	 
	 /************************/
	 
	 reg [3:0]i;
	 reg [9:0]rData;
	 reg isSPI_Start;
	 reg isDone;
	 
	 always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )
		      begin
		          i <= 4'd0;
				    rData <= { 2'b11, 8'h2f };
					 isSPI_Start <= 1'b0;
					 isDone <= 1'b0;
				end	 

		  else if( Start_Sig )
		      case( i )
				
                4'd0: 
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'haf }; isSPI_Start <= 1'b1; end
					 
					 4'd1:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h40 }; isSPI_Start <= 1'b1; end
					 
					 4'd2:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha6 }; isSPI_Start <= 1'b1; end
					 
					 4'd3:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha0 }; isSPI_Start <= 1'b1; end
					 
					 4'd4: 
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'hc8 }; isSPI_Start <= 1'b1; end
					 
					 4'd5:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha4 }; isSPI_Start <= 1'b1; end
					 
					 4'd6:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'ha2 }; isSPI_Start <= 1'b1; end
					 
					 4'd7:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h2f }; isSPI_Start <= 1'b1; end
					 
					 4'd8:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h24 }; isSPI_Start <= 1'b1; end
					 
					 4'd9:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h81 }; isSPI_Start <= 1'b1; end
					 
					 4'd10:
					 if( SPI_Done_Sig ) begin isSPI_Start <= 1'b0; i <= i + 1'b1; end
					 else begin rData <= { 2'b00, 8'h24 }; isSPI_Start <= 1'b1; end
					 
					 4'd11:
					 begin rData <= { 2'b11, 8'h2f }; isDone <= 1'b1; i <= i + 1'b1; end
					 
					 4'd12:
					 begin isDone <= 1'b0; i <= 4'd0; end 
		
				endcase
				
	 /***********************************/
	 
	 assign Done_Sig = isDone;
	 assign SPI_Start_Sig = isSPI_Start;
	 assign SPI_Data = rData;
	 
	 /*************************************/
	 
endmodule
