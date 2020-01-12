//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-03 02:56:00
//****************************************//
/**************************************************************************
..IDLE...Start...............UART DATA........................End...IDLE...
________													 ______________
        |____< D0 >< D1 >< D2 >< D3 >< D4 >< D5 >< D6 >< D7 >
		Bit0  Bit1  Bit2  Bit3  Bit4  Bit5  Bit6  Bit7  Bit8  Bit9
**************************************************************************/
module tx_control_module
(
    CLOCK, RST_n,
	TX_En_Sig, 
	TX_Data, 
	BPS_CLK, 
    TX_Done_Sig, 
    TXD
	 
);

    input CLOCK;
	input RST_n;
	 
	input TX_En_Sig;
	input [7:0]TX_Data;
	input BPS_CLK;
	 
	output TX_Done_Sig;
	output TXD;
	 
	/********************************************************/

	 reg [3:0]i;
	 reg rTX;
	 reg isDone;
	
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
		         i <= 4'd0;
					rTX <= 1'b1;
					isDone 	<= 1'b0;
				end
		  else if( TX_En_Sig )
		      case ( i )
				
			       4'd0 :
					 if( BPS_CLK ) begin i <= i + 1'b1; rTX <= 1'b1; end
					 4'd1 :
					 if( BPS_CLK ) begin i <= i + 1'b1; rTX <= 1'b0; end
					 
					 4'd2, 4'd3, 4'd4, 4'd5, 4'd6, 4'd7, 4'd8, 4'd9 :
					 if( BPS_CLK ) begin i <= i + 1'b1; rTX <= TX_Data[ i - 2 ]; end
					 
					 4'd10 :
					 if( BPS_CLK ) begin i <= i + 1'b1; rTX <= 1'b1; end
					 			 
					 4'd11 :
					 if( BPS_CLK ) begin i <= i + 1'b1; rTX <= 1'b1; end
					 
					 4'd12 :
					 if( BPS_CLK ) begin i <= i + 1'b1; isDone <= 1'b1; end
					 
					 4'd13 :
					 begin i <= 4'd0; isDone <= 1'b0; end
					 
					 //default:i <= 4'd0;
				 
				endcase
				
    /********************************************************/
	 
	 assign TXD = rTX;
	 assign TX_Done_Sig = isDone;
	 
	 /*********************************************************/
	 
endmodule

