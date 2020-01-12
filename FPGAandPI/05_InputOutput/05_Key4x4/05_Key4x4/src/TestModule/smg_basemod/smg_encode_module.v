//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-18 23:59:39
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-19 01:27:10
//****************************************//
module smg_encode_module
(
	 input CLOCK,
	 input RST_n,
	 input [3:0]Number_Data,
	 output [7:0]SMG_Data
);

	 /***************************************/
	 
	 parameter _0 = 8'b1100_0000, _1 = 8'b1111_1001, _2 = 8'b1010_0100, 
	           _3 = 8'b1011_0000, _4 = 8'b1001_1001, _5 = 8'b1001_0010, 
				  _6 = 8'b1000_0010, _7 = 8'b1111_1000, _8 = 8'b1000_0000,
				  _9 = 8'b1001_0000;
	 
	 /***************************************/
	 
	 reg [7:0]rSMG;

	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    rSMG <= 8'b1111_1111;
				end
        else 
		       case( Number_Data )
		           
					  4'd0 : rSMG <= _0;
					  4'd1 : rSMG <= _1;
					  4'd2 : rSMG <= _2;
					  4'd3 : rSMG <= _3;
					  4'd4 : rSMG <= _4;
					  4'd5 : rSMG <= _5;
					  4'd6 : rSMG <= _6;
					  4'd7 : rSMG <= _7;
					  4'd8 : rSMG <= _8;
					  4'd9 : rSMG <= _9;
					  
				 endcase
		      
	 /***************************************/
	 
	 assign SMG_Data = rSMG;
	 
	 /***************************************/
			  
endmodule
