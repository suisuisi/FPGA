module smg_encode_immdmod
(
	 input [3:0]iData,
	 output [7:0]oData
);
	 parameter _0 = 8'b1100_0000, _1 = 8'b1111_1001, _2 = 8'b1010_0100, 
	           _3 = 8'b1011_0000, _4 = 8'b1001_1001, _5 = 8'b1001_0010, 
				  _6 = 8'b1000_0010, _7 = 8'b1111_1000, _8 = 8'b1000_0000,
				  _9 = 8'b1001_0000, _A = 8'b1000_1000, _B = 8'b1000_0011,
				  _C = 8'b1100_0110, _D = 8'b1010_0001, _E = 8'b1000_0110,
				  _F = 8'b1000_1110;
	 
	 reg [7:0]D = 8'b1111_1111;
	 
	 always @ ( * )
	     if( iData == 4'd0 ) D = _0;
		  else if( iData == 4'd1 ) D = _1;
		  else if( iData == 4'd2 ) D = _2;
		  else if( iData == 4'd3 ) D = _3;
		  else if( iData == 4'd4 ) D = _4;
		  else if( iData == 4'd5 ) D = _5;
		  else if( iData == 4'd6 ) D = _6;
		  else if( iData == 4'd7 ) D = _7;
		  else if( iData == 4'd8 ) D = _8;
		  else if( iData == 4'd9 ) D = _9;
		  else if( iData == 4'hA ) D = _A;
		  else if( iData == 4'hB ) D = _B;
		  else if( iData == 4'hC ) D = _C;
		  else if( iData == 4'hD ) D = _D;
		  else if( iData == 4'hE ) D = _E;
		  else if( iData == 4'hF ) D = _F;
		  else D = 8'dx;
	 
	 assign oData = D;

endmodule
