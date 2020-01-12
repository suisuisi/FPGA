//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-12 22:32:32
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-12 23:32:26
//****************************************//
module rx_tx_interface_demo
(
    input CLOCK,
	 input RST_n,
	 
	 input RXD,
	 output [3:0]LED,
	 output TXD
);

    /******************************/
	 
	 wire [7:0]RX_Data;
	 wire RX_Done_Sig;
	 wire RX_En_Sig;
	 

	rx_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .RXD( RXD ),   // input - from top
		  .RX_En_Sig( RX_En_Sig ),   // input - from U2
		  .RX_Done_Sig( RX_Done_Sig ),  // output - to U2
		  .RX_Data( RX_Data )           // output - to U2
	 );

	 
	  /******************************/
	  
	  wire TX_En_Sig;
	  wire [7:0]TX_Data;
	  wire TX_Done_Sig;	
		 	 
	  /******************************/		 
	  inter_control_module U2
	  (
	    .CLOCK( CLOCK ),
		.RST_n( RST_n ),
		.TX_Done_Sig( TX_Done_Sig ),                 // input - from U1
		.TX_Data( TX_Data ),   // input - from U1
		.TX_En_Sig( TX_En_Sig ),       // output - to U1
		.RX_Done_Sig( RX_Done_Sig ),               // input - from U3
		.RX_Data( RX_Data ), // output - to U3
		.RX_En_Sig( RX_En_Sig )	    // output - to U3
	  );
	  
	  /******************************/
	  reg isTX_En_Sig;
	  
    tx_module U3
    (
        .CLOCK( CLOCK),
        .RST_n( RST_n ),
        .TX_Data( TX_Data ),// input - from U2
        .TX_En_Sig( TX_En_Sig ),// input - from U2
        .TX_Done_Sig( TX_Done_Sig ),// output - to U2
        .TXD( TXD )// output - to top
    );	  
	  
	  /******************************/
	  
	  assign LED = RX_Data[3:0];
	  
	  /******************************/

endmodule
