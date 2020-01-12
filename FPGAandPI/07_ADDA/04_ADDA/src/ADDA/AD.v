module AD(CLK, AD_IN,AD_CLK, AD_OUT,);

   input CLK; 
	input[7:0] AD_IN;
   output AD_CLK; 
   output[7:0] AD_OUT; 
   reg[7:0] AD_OUT;

   assign AD_CLK = CLK ;		//da ±÷”

   always @(posedge CLK)
   begin
         AD_OUT <= AD_IN ;  
   end 
endmodule