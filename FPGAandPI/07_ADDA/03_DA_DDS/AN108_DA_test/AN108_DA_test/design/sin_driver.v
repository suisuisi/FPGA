module sin_driver (
   input wire sclk,
   input wire rst_n,
   input key_f,
   input key_p,
   
   output wire [7:0] o_wave,
   output wire clk_DA,
	 output wire led0

);

   wire [29:0] fc_word;
   wire [29:0] pc_word;
   //wire clk_DA;
  // wire pd;
   

	key_ctrl key_ctrl_inst (
      .sclk(sclk),
      .rst_n(rst_n),
      .key_f(key_f),
      .key_p(key_p),
      .fc_word(fc_word),
      .pc_word(pc_word),
		.led0(led0)
);


  DDS DDS_inst	(
					.sclk(sclk),
					.rst_n(rst_n),
					.fc_word(fc_word),
					.pc_word(pc_word),
					.o_wave(o_wave),
					.clk_DA(clk_DA),
					
);
										
									
endmodule