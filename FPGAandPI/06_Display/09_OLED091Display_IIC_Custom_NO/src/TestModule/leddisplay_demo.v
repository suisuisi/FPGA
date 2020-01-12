//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 01:42:42
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-23 11:12:36
//# Description: 
//# @Modification History: 2019-05-19 01:52:19
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 01:52:19
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module leddisplay_demo
(
    input CLOCK, RST_n,
	 output MAX7219_CS, MAX7219_SCLK, 
	 output MAX7219_DATA
);

	 parameter  data_0 = 6'd0, data_1 = 6'd1, data_2 = 6'd2, 
	            data_3 = 6'd3,  data_4= 6'd4, data_5 = 6'd5, 
			    data_6 = 6'd6,  data_7= 6'd7,  data_8= 6'd8,
				data_9  = 6'd9,data_A = 6'd10,data_B = 6'd11,
				data_C = 6'd12,data_D = 6'd13,data_E = 6'd14,
				data_F = 6'd15,data_G = 6'd16,data_H = 6'd17,
				data_I = 6'd18,data_J = 6'd19,data_K = 6'd20,
				data_L = 6'd21,data_M = 6'd22,data_N = 6'd23,
				data_O = 6'd24,data_P = 6'd25,data_Q = 6'd26,
				data_R = 6'd27,data_S = 6'd28,data_T = 6'd29,
				data_U = 6'd30,data_V = 6'd31,data_W = 6'd32,
				data_X = 6'd33,data_Y = 6'd34,data_Z = 6'd35,
				data_zhong = 6'd36,data_guo = 6'd37;
	parameter Time_1s = 26'd5000_0000;
	wire DoneU1;	 
	reg isCall;


	 max7219_basemod U1
    (
      .CLOCK( CLOCK ), 
	   .RST_n( RST_n ),
		.MAX7219_CS( MAX7219_CS ),   // > top
		.MAX7219_SCLK( MAX7219_SCLK ),         // > top
		.MAX7219_DATA( MAX7219_DATA ),         // <> top
	   .iCall( isCall ),//isCall
	   .oDone( DoneU1 ),
	   .iData( D1 )//data_O
    );

wire clock_div_1s;
clock_div //BPS 
#(//DEVICE_CNT = 85.89934592 * fo    for 50Mhz
//	parameter		DEVICE_CNT = 32'd43	//0.5Hz   
	.DEVICE_CNT(32'd86)    // 1Hz
//	parameter		DEVICE_CNT = 32'd172	//2Hz
)
U2_clock_div
(
	   .CLOCK( CLOCK ),
		.RST_n( RST_n ),
		.En_Sig( 1'b1 ),    // 
		.clock_div_1s( clock_div_1s ) // output - to top
);
   reg [3:0]i;

	reg [5:0]D1;

//	reg [25:0]C1;
	
	always @ ( posedge clock_div_1s or negedge RST_n )
	    if( !RST_n )
		     begin
			      i <= 4'd0;
			      isCall <= 1'b0;
				   D1 <= 6'd1;
			  end
		 else 
		     case( i )
			      0:
					//if( DoneU1 ) begin
					   // isCall <= 1'b0; i <= i + 1'b1;end
						 //else
					begin isCall <= 1'b1;D1 <= data_O; i <= i + 1'b1;  end
											      	
					1:
					//if( DoneU1 ) begin 
					//    isCall <= 1'b0; i <= i + 1'b1; end
					begin isCall <= 1'b1;i <= i + 1'b1; D1 <= data_P; end
						
					
					2:
					//if( DoneU1 ) begin 
					 //   isCall <= 1'b0; i <= i + 1'b1; end
				   begin isCall <= 1'b1;i <= i + 1'b1; D1 <= data_E;end 
					
					3:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1;i <= i + 1'b1;D1 <= data_N; end
					
									
					4:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1;i <= i + 1'b1;D1 <= data_F;  end
						 
					
					5:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1; i <= i + 1'b1;D1 <= data_P; end
					
					6:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1; i <= i + 1'b1;D1 <= data_G; end
					
					7:
					//if( DoneU1 ) begin 
					//	isCall <= 1'b0;  end
					begin isCall <= 1'b1;i <= i + 1'b1;D1 <= data_A;  end

					8:
					i <= 4'd0;
					
					default:
					 i <= i;
					
			  endcase

endmodule
