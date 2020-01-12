module lcd_interface_demo
(
    input CLK,
	 input RSTn,
	 
	 output [3:0]SPI_Out
);

    /****************************/
    
	 parameter T1MS = 16'd49999;

	 /*****************************/
	 
	 reg [15:0]C1;
	 
	 always @ ( posedge CLK	or negedge RSTn )
	     if( !RSTn )
		      C1 <= 16'd0;
		  else if( C1 == T1MS )
		      C1 <= 16'd0;
		  else if( isCount )
		      C1 <= C1 + 1'b1;
		  else 
		      C1 <= 16'd0;
				
	 /*****************************/
	 
	 reg [9:0]CMS;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      CMS <= 10'd0;
		  else if( CMS == rTimes )
		      CMS <= 10'd0;
		  else if( C1 == T1MS )
		      CMS <= CMS + 1'b1;
	 
	 /*****************************/
	 
	 reg [1:0]Z;
	 
	 always @ ( posedge CLK or negedge RSTn )
	     if( !RSTn )
		      Z <= 2'd0;
		  else 
		      case ( i )
				
				    0: Z <= 2'd0;
				    2: Z <= 2'd1;
				
				endcase
	 
	 /*****************************/
	 
	 reg [3:0]i;
	 reg [10:0]rAddr;
	 reg [9:0]rTimes;
	 reg isWrite;
	 reg isCount;
	 reg [8:0]X;
	 reg [3:0]Y;
	 
	 always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )    
            begin 
				    i <= 4'd0;
					 rAddr <= 11'd0;
					 rTimes <= 10'd100;
		          isWrite <= 1'b0;
					 isCount <= 1'b0;
					 X <= 9'd0;
					 Y <= 4'd0;
		      end
		  else
		      case( i )
				    
					 0, 2:
					 if( Y == 8 ) begin Y <= 4'd0; i <= i + 1'b1; isWrite <= 1'b0; end 
					 else if( X == 128 ) begin X <= 8'd0; Y <= Y + 1'b1; end
					 else begin rAddr = X + ( Y << 7 ) + ( Z << 10) ; X <= X + 1'b1; isWrite <= 1'b1; end
					 
					 1, 3:
					 if( CMS == rTimes ) begin isCount <= 1'b0; i <= i + 1'b1; end
					 else begin isCount <= 1'b1; rTimes <= 10'd500; end
					 
					 4:
					 i <= 4'd0;
					 
				endcase
	 
	 /******************************************/
	 
	 wire [7:0]Rom_Data;
	 
	 lcd_rom_module U1
	 (
	     .clock( CLK ),
		  .address( rAddr ),
		  .q( Rom_Data )
	 );
	 
	 /******************************************/
	 
	 lcd_interface U2
	 (
	     .CLK( CLK ),
		  .RSTn( RSTn ),
		  .Write_En_Sig( isWrite ),
		  .Write_Addr_Sig( rAddr[9:0] ),
		  .Write_Data( Rom_Data ),
		  .SPI_Out( SPI_Out )
	 );
	 
	 /******************************************/
	 
endmodule
