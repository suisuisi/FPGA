module vga_module
(
    CLK, RSTn,
    VSYNC_Sig, HSYNC_Sig,
	 Red_Sig, Green_Sig, Blue_Sig 
);

    input CLK;
	 input RSTn;
	 output VSYNC_Sig;
	 output HSYNC_Sig;
	 output Red_Sig;
	 output Green_Sig;
	 output Blue_Sig;
	 
	 /*************************************/
	 
	 wire CLK_40Mhz;
	 
	 pll_module U1
	 (
	     .inclk0( CLK ),  // input - from top
		  .c0( CLK_40Mhz ) // output - to inter global
	 );
	 
	 /**************************************/
	 
	 wire Frame_Sig;
	 wire [10:0]Column_Addr_Sig;
	 wire [10:0]Row_Addr_Sig;
	 wire Ready_Sig;
	 
	 sync_module U2
	 (
	     .CLK( CLK_40Mhz ),  
		  .RSTn( RSTn ),
		  .VSYNC_Sig( VSYNC_Sig ),  // input - from top
		  .HSYNC_Sig( HSYNC_Sig ),  // input - from top
		  .Frame_Sig( Frame_Sig ),  // output - to U4
		  .Column_Addr_Sig( Column_Addr_Sig ), // output - to U4
		  .Row_Addr_Sig( Row_Addr_Sig ),       // output - to U4
		  .Ready_Sig( Ready_Sig )              // output - to U4
	 );
	 
	 /******************************************/
	 
	 wire [15:0]Rom_Data;
	 
	 greenman_rom_module U3
	 (
	     .clock( CLK_40Mhz ),    
	     .address( Rom_Addr ),  // input - from U4
		  .q( Rom_Data )         // output - to U4
	 );
	 
	 /******************************************/
	 
	 wire [6:0]Rom_Addr;
	 
	 vga_control_module U4
	 (
	     .CLK( CLK_40Mhz ),
		  .RSTn( RSTn ),
		  .Ready_Sig( Ready_Sig ),  // input - from U2
		  .Frame_Sig( Frame_Sig ),  // input - from U2
		  .Column_Addr_Sig( Column_Addr_Sig ),  // input - from U2
		  .Row_Addr_Sig( Row_Addr_Sig ),        // input - from U2
		  .Rom_Data( Rom_Data ),   // input - from U3
		  .Rom_Addr( Rom_Addr ),   // output - to U3
		  .Red_Sig( Red_Sig ),     // output - to top
		  .Green_Sig( Green_Sig ), // output - to top
		  .Blue_Sig( Blue_Sig )    // output - to top
	 );
	 
	 /*******************************************/

endmodule
