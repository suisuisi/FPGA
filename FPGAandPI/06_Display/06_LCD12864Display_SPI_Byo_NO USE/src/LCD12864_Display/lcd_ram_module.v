module lcd_ram_module
(
    input CLOCK,
	 input RST_n,
	 
	 input Write_En_Sig,
	 input [9:0]Write_Addr_Sig,
	 input [7:0]Write_Data,
	 
	 input [9:0]Read_Addr_Sig,
	 output [7:0]Read_Data
);

    /*************************************/

	 (* ramstyle = " no_rw_check, m9k " , ram_init_file = " pikachu.mif " *) reg [7:0] RAM [1023:0];
	 
	 reg [7:0]rData;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      rData <= 8'd0;
		  else if( Write_En_Sig )
		      RAM[ Write_Addr_Sig ] <= Write_Data;
		  else 
		      rData <= RAM[ Read_Addr_Sig ];
	 
	 /******************************************/
	
    assign Read_Data = rData;
	
    /******************************************/ 

endmodule
