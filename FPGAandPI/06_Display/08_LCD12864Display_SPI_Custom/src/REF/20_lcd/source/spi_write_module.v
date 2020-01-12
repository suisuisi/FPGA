module spi_write_module
(
    CLK, RSTn,
	 Start_Sig,
	 SPI_Data,
	 Done_Sig,
	 SPI_Out
);

    input CLK;
	 input RSTn;
	 input Start_Sig;
	 input [9:0]SPI_Data;
	 output Done_Sig;
	 output [3:0]SPI_Out; // [3]CS [2]A0 [1]CLK [0]DO
	 
	 /*****************************/
	 
	 parameter T0P5US = 5'd24;
	 
	 /*****************************/
	 
	 reg [4:0]Count1;
	 
	 always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )
		      Count1 <= 5'd0;
		  else if( Count1 == T0P5US )  
		      Count1 <= 5'd0;
		  else if( Start_Sig )
		      Count1 <= Count1 + 1'b1;
		  else
		      Count1 <= 5'd0;
 	 
	 /*****************************/
	 
	 reg [4:0]i;
	 reg rCLK;
	 reg rDO;
	 reg isDone;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      begin
		           i <= 5'd0;
					  rCLK <= 1'b1;
					  rDO <= 1'b0;
					  isDone <= 1'b0;
			   end
		  else if( Start_Sig )
		      case( i )
				    
					 5'd0, 5'd2, 5'd4, 5'd6, 5'd8, 5'd10, 5'd12, 5'd14:
					 if( Count1 == T0P5US ) begin rCLK <= 1'b0; rDO <= SPI_Data[ 7 - ( i >> 1) ]; i <= i + 1'b1; end
					
					 5'd1, 5'd3, 5'd5, 5'd7, 5'd9, 5'd11, 5'd13, 5'd15 :
					 if( Count1 == T0P5US ) begin rCLK <= 1'b1; i <= i + 1'b1; end
					 
					 5'd16:
					 begin isDone <= 1'b1; i <= i + 1'b1; end
					 
					 5'd17:
					 begin isDone <= 1'b0; i <= 5'd0; end
				
				endcase
				
    /*******************************************/
	 
	 assign Done_Sig = isDone;
    assign SPI_Out = { SPI_Data[9], SPI_Data[8], rCLK, rDO };
	 
	 /*******************************************/
	 
endmodule
