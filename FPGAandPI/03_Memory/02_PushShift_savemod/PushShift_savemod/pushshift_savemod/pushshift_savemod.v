module pushshift_savemod
(
    input CLOCK,RESET,
	 input iEn,
	 input [3:0]iAddr,
	 input [3:0]iData,
	 output [23:0]oData
);
    reg [3:0] RAM [15:0];
	 reg [23:0] D1;

    always @ ( posedge CLOCK or negedge RESET )
	     if( !RESET )
		      begin
				    D1 <=  24'd0; 
				end
		  else if( iEn )
		      begin
				    RAM[ iAddr ] <= iData;
					 D1[3:0] <= RAM[ iAddr ];
					 D1[7:4] <= D1[3:0];
					 D1[11:8] <= D1[7:4];
					 D1[15:12] <= D1[11:8];
					 D1[19:16] <= D1[15:12];
					 D1[23:20] <= D1[19:16];
				end
				
	assign oData = D1;
	
endmodule
