//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-03 02:18:37
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-04 17:18:42
//# Description: 
//# @Modification History: 2019-05-06 21:38:04
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-06 21:38:04
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module tx_module_demo
(
    CLOCK, RST_n,
	TXD
);

   input CLOCK;
	input RST_n;
	output TXD;
	 
/***************************/
	reg [7:0]rData;	
	reg isTX; 
    wire DoneU1;
/****************************/


	
tx_module dut
    (
        .CLOCK( CLOCK),
        .RST_n( RST_n ),
        .TX_Data( rData ),
        .TX_En_Sig( isTX ),
        .TX_Done_Sig( DoneU1 ),
        .TXD( TXD )
    );
	
/*******************************/

    reg [3:0]i;


/**************************/
	 
	 parameter T1S = 26'd49_999_999;
	 
/***************************
	 
	 reg [25:0]Count_Sec;
	 
always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      Count_Sec <= 26'd0;
		  else if( Count_Sec == T1S )
		      Count_Sec <= 26'd0;
		  else
		      Count_Sec <= Count_Sec + 1'b1;
				
/********************************


always @ ( posedge CLOCK or negedge RST_n )
        if( !RST_n )
	 	     begin
	 		   isTX <= 1'b0;
				rData <= 8'h00;
		     end	
		  else if( DoneU1 )
		     begin
			      isTX <= 1'b0;
			      rData <= 8'hAB;				
			  end
		  else if( Count_Sec == T1S )
		      isTX <= 1'b1;
/******************************/
	
	
/******************************/

always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				     i <= 4'd0;
					 rData <= 8'd0;
					 isTX <= 1'b0;
				end
		  else
		      case( i )
				
				    0:
					 if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
					 else begin isTX <= 1'b1; rData <= 8'hAB; end
					 
					 1:
					 if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
					 else begin isTX <= 1'b1; rData <= 8'hCD; end
					 
					 2:
					 if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
					 else begin isTX <= 1'b1; rData <= 8'hEF; end
					 
					 3: // Stop
					 i <= i;
				
				endcase
/******************************/

endmodule
