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
	     .inclk0( CLK ),   // input - from top
		  .c0( CLK_40Mhz )  // output - inter globak
	 );
	 
	 /**************************************/
	 
	 wire [10:0]Column_Addr_Sig;
	 wire [10:0]Row_Addr_Sig;
	 wire Ready_Sig;
	 
	 sync_module U2
	 (
	     .CLK( CLK_40Mhz ),
		  .RSTn( RSTn ),
		  .VSYNC_Sig( VSYNC_Sig ),  // input - from top
		  .HSYNC_Sig( HSYNC_Sig ),  // input - from top
		  .Column_Addr_Sig( Column_Addr_Sig ), // output - to U6
		  .Row_Addr_Sig( Row_Addr_Sig ),       // output - to U6
		  .Ready_Sig( Ready_Sig )              // output - to U6
	 );
	 
	 /******************************************/
	 
	 wire [63:0]Red_Rom_Data;
	 
	 red_rom_module U3
	 (
	     .clock( CLK_40Mhz ),
	     .address( Rom_Addr ),   // input - from U6
		  .q( Red_Rom_Data )      // output - to U6
	 );
	 
	 /******************************************/
	 
	 wire [63:0]Green_Rom_Data;
	 
	 green_rom_module U4
	 (
	     .clock( CLK_40Mhz ),
	     .address( Rom_Addr ),   // input - from U6
		  .q( Green_Rom_Data )    // output - to U6
	 );
	 
	 /******************************************/
	 
	 wire [63:0]Blue_Rom_Data;
	 
	 blue_rom_module U5
	 (
	     .clock( CLK_40Mhz ),
	     .address( Rom_Addr ), // input - from U6
		  .q( Blue_Rom_Data )   // output - to U6
	 );
	 
	 /******************************************/
	 
	 wire [5:0]Rom_Addr;
	 
	 vga_control_module U6
	 (
	     .CLK( CLK_40Mhz ),
		  .RSTn( RSTn ),
		  .Ready_Sig( Ready_Sig ),   // input - from U2
		  .Column_Addr_Sig( Column_Addr_Sig ), // input - from U2
		  .Row_Addr_Sig( Row_Addr_Sig ),       // input - from U2
		  .Red_Rom_Data( Red_Rom_Data ),       // input - from U3
		  .Green_Rom_Data( Green_Rom_Data ),   // input - from U4
		  .Blue_Rom_Data( Blue_Rom_Data ),     // input - from U5
		  .Rom_Addr( Rom_Addr ),   // output - to U3, U4, U5
		  .Red_Sig( Red_Sig ),     // output - to top
		  .Green_Sig( Green_Sig ), // output - to top
		  .Blue_Sig( Blue_Sig )    // output - to top
	 );
	 
	 /*******************************************/

endmodule
