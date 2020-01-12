module DA(CLK, DA_CLK, DA_A);

   input CLK; 
   output DA_CLK; 
   output[8:0] DA_A; 
   reg[8:0] DA_A;

   reg[8:0] COUNT; 

   assign DA_CLK = CLK ;		//da ±÷”

   always @(posedge CLK)
   begin
         COUNT <= COUNT + 1 ; 
         DA_A <= COUNT[8:0] ;  
   end 
endmodule