module vga_interface
(
	 input RSTn,
	 
	 input Write_En_Sig,
	 input [3:0]Write_Addr_Sig,
	 input [15:0]Write_Data,
	 
	 input VGA_CLK,  // 40MHz
	 output VSYNC_Sig,
	 output HSYNC_Sig,
	 output Red_Sig,
	 output Green_Sig,
	 output Blue_Sig
	 	 
);

	 /******************************************/
	 
    wire Ready_Sig;
	 wire [10:0]Column_Addr_Sig;
	 wire [10:0]Row_Addr_Sig; 

	 sync_module U1
	 (
	     .CLK( VGA_CLK ),            // input - from top
		  .RSTn( RSTn ),                        
		  .VSYNC_Sig( VSYNC_Sig ),    // output - to top
		  .HSYNC_Sig( HSYNC_Sig ),    // output - to top
		  .Ready_Sig( Ready_Sig ),    // output - to U2
		  .Column_Addr_Sig( Column_Addr_Sig ), // output - to U2
	     .Row_Addr_Sig( Row_Addr_Sig )  // output - to U2
	 );
	 
	 /*********************************************/
	 
	 wire [3:0]Read_Addr_Sig;
	 
	 vga_control_module U2
	 (
	     .CLK( VGA_CLK ),    // input - from top
		  .RSTn( RSTn ),
		  .Ready_Sig( Ready_Sig ),  // input - from U1
		  .Column_Addr_Sig( Column_Addr_Sig ), // input - from U1
		  .Row_Addr_Sig( Row_Addr_Sig ),       // input - from U1
		  .Ram_Data( Read_Data ),              // output - to U3
		  .Ram_Addr( Read_Addr_Sig ),          // output - to U3 
		  .Red_Sig( Red_Sig ),                 // output - top
		  .Green_Sig( Green_Sig ),             // output - top 
		  .Blue_Sig( Blue_Sig )                // output - top
	 );
	 
	 /*********************************************/
	 
	 wire [15:0]Read_Data;
	 
    ram_module U3
	 ( 
	     .CLK( VGA_CLK ),  // input - from top
		  .RSTn( RSTn ),
	     .Write_En_Sig( Write_En_Sig ),     // input - from top
		  .Write_Addr_Sig( Write_Addr_Sig ), // input - from top
 	     .Write_Data( Write_Data ),         // input - from top
		  .Read_Addr_Sig( Read_Addr_Sig ),   // input - from U2
		  .Read_Data( Read_Data )            // output - to U2
	 );
	
    /*********************************************/
	 
endmodule
