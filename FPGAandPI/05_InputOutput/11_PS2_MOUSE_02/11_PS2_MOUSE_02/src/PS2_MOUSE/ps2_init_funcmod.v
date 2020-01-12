module ps2_init_funcmod
(
    input CLOCK, RST_n,
	 inout PS2_CLK, 
	 inout PS2_DAT,
	 output [1:0]oEn
);  
    parameter T100US = 13'd5000;
	 parameter FF_Write = 7'd32;

	 /*******************************/ // sub1
	 
    reg F2,F1; 
	 
    always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      { F2,F1 } <= 2'b11;
		  else 
		      { F2, F1 } <= { F1, PS2_CLK };

	 /*******************************/ // core
	 
	 wire isH2L = ( F2 == 1'b1 && F1 == 1'b0 );
	 reg [8:0]T;
	 reg [6:0]i,Go;
	 reg [12:0]C1;
	 reg rCLK,rDAT;
	 reg isQ1,isQ2,isEx;
	 reg [1:0]isEn;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
					 T <= 9'd0;
					 C1 <= 13'd0;
					 { i,Go } <= { 7'd0,7'd0 };
					 { rCLK,rDAT } <= 2'b11;
					 { isQ1,isQ2,isEx } <= 3'b000;
					 isEn <= 2'b00;
				end
		   else  /// odd 0 , even 1
			    case( i )
				 
				     /***********/ // INIT Mouse 
					  
					  0: // Send F3  1111_0011
					  begin T <= { 1'b1, 8'hF3 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  1: // Send C8  1100_1000
					  begin T <= { 1'b0, 8'hC8 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  2: // Send F3 1111_0011
					  begin T <= { 1'b1, 8'hF3 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  3: // Send 64 0110_1000
					  begin T <= { 1'b0, 8'h64 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  4: // Send F3 1111_0011
					  begin T <= { 1'b1, 8'hF3 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  5: // Send 50 0101_0000
					  begin T <= { 1'b1, 8'h50 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  6: // Send F2  1111_0010
					  begin T <= { 1'b0, 8'hF2 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  7: // Check Mouse ID 00(normal), 03(extend)
					  if( T[7:0] == 8'h03 ) begin isEx <= 1'b1; i <= i + 1'b1; end
					  else if( T[7:0] == 8'h00 ) begin isEx <= 1'b0; i <= i + 1'b1; end
					
					  8: // Send F4 1111_0100
					  begin T <= { 1'b0, 8'hF4 }; i <= FF_Write; Go <= i + 1'b1; end
					  
					  9:
					  if( isEx ) isEn[1] <= 1'b1;
					  else if( !isEx ) isEn[0] <= 1'b1;
					  
					  /****************/ // PS2 Write Function
					  
					  32: // Press low PS2_CLK 100us
					  if( C1 == T100US -1 ) begin C1 <= 13'd0; i <= i + 1'b1; end
					  else begin isQ1 = 1'b1; rCLK <= 1'b0; C1 <= C1 + 1'b1; end
					  
					  33: // release PS2_CLK and set in ,PS2_DAT set out
					  begin isQ1 <= 1'b0; rCLK <= 1'b1; isQ2 <= 1'b1; i <= i + 1'b1; end
					  
					  34: // start bit 1
					  begin rDAT <= 1'b0; i <= i + 1'b1; end
					  
					  35,36,37,38,39,40,41,42,43:  // data bit 9
					  if( isH2L ) begin rDAT <= T[ i-35 ]; i <= i + 1'b1; end
					  
					  44: // stop bit 1
					  if( isH2L ) begin rDAT <= 1'b1; i <= i + 1'b1; end
					  
					  45: // Ack bit
					  if( isH2L ) begin i <= i + 1'b1; end
					  
					  46: // PS2_DAT set in
					  begin isQ2 <= 1'b0; i <= i + 1'b1; end
					  
					  /***********/ // Receive 1st Frame
					 
					  47,48,49,50,51,52,53,54,55,56,57: // Ingnore 
					  if( isH2L ) i <= i + 1'b1;
					  
					  58: // Check comd F2
					  if( T[7:0] == 8'hF2 ) i <= i + 1'b1;
					  else i <= Go;
					  
					  /***********/ // Receive 2nd Frame
					  
					  59:  // Start bit 1
					  if( isH2L ) i <= i + 1'b1; 
					  
					  60,61,62,63,64,65,66,67,68: // Data bit 9
					  if( isH2L ) begin T[i-60] <= PS2_DAT; i <= i + 1'b1; end
					  
					  69: // Stop bit 1
					  if( isH2L ) i <= Go;
					  				    
				 endcase
	 
	 assign PS2_CLK = isQ1 ? rCLK : 1'bz;
	 assign PS2_DAT = isQ2 ? rDAT : 1'bz;
	 assign oEn = isEn;
  
endmodule
