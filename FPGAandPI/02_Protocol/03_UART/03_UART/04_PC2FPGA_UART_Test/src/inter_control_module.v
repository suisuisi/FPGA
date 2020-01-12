//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-12 22:32:32
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-12 23:25:55
//****************************************//
module inter_control_module
(
    input CLOCK,
	input RST_n,
	 
	 //TX control signal
	 input TX_Done_Sig,
	 output TX_En_Sig,
	 output [7:0]TX_Data,
	 //RX control signal
	 input RX_Done_Sig,
	 output RX_En_Sig,
	 input [7:0]RX_Data
);

    /********************************/
	 
	 reg [2:0]i;
	 reg isTX_En_Sig;
	 reg isRX_En_Sig;	
	 reg [7:0]isRX_Data;
	 reg [7:0]isTX_Data;
	 
	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
				    i <= 3'd0;
					 isRX_En_Sig <= 1'b0;
					 isTX_En_Sig <= 1'b0;
				end
		  else 
		      case( i )
				
				    0:
					 if( RX_Done_Sig ) begin isRX_En_Sig <= 1'b0;i <= i + 1'b1; end
     				 else begin isRX_En_Sig <= 1'b1;isRX_Data <= RX_Data;   end
					 
				    1:
					 if( TX_Done_Sig  ) begin isTX_En_Sig <= 1'b0; i <= i + 1'b1; end
					 else begin isTX_En_Sig <= 1'b1; isTX_Data<=isRX_Data; end					 
					 
					 2:
					 begin isRX_En_Sig <= 1'b0; i <= 3'd0; end
					 
				
				endcase 
				
    /********************************/
	 
	 assign RX_En_Sig = isRX_En_Sig;
	 assign TX_En_Sig= isTX_En_Sig;
	 assign TX_Data = isTX_Data;
	 
	 /********************************/
	 
endmodule
