//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-12 21:36:15
//****************************************//
module rx_module_demo
(
    CLOCK, RST_n,
	 RXD,
	 LED
);

    input CLOCK;
	 input RST_n;
	 input RXD;
    output [3:0]LED;	
	 
	 /**********************************/
	 
	 wire RX_Done_Sig;
	 wire [7:0]RX_Data;
	 

	 rx_module U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .RXD( RXD ),   // input - from top
		  .RX_En_Sig( RX_En_Sig ),   // input - from U2
		  .RX_Done_Sig( RX_Done_Sig ),  // output - to U2
		  .RX_Data( RX_Data )           // output - to U2
	 );
	 
	 /***********************************/
	 
	 wire RX_En_Sig;
	 wire [7:0]Output_Data;
	 
	 control_module U2
	 (
	     .CLOCK( CLOCK ),
	     .RST_n( RST_n ),
		  .RX_Done_Sig( RX_Done_Sig ),  // input - from U1
		  .RX_Data( RX_Data ),          // input - from U1
		  .RX_En_Sig( RX_En_Sig ),      // output - to U1
		  .Number_Data( Output_Data )   // output - to top
	 );
	 
	 /***********************************/

	 assign LED = Output_Data[3:0];
	 
endmodule
