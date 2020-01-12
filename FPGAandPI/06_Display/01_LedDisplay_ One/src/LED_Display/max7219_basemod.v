//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:56:01
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-22 20:31:33
//# Description: 
//# @Modification History: 2019-05-19 20:57:52
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:57:52
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module max7219_basemod
(
    input CLOCK, RST_n,
	 output MAX7219_CS, MAX7219_SCLK,
	 output MAX7219_DATA,
	 input iCall,
	 output oDone,
	 input [5:0]iData

);

//****************************************************************************//
//   取模数据
//****************************************************************************//
reg [63:0]oData;

always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      begin
					oData  <= 64'd0;
				end
		  else if( iCall )
		      case( iData )
					0:
					oData <= {8'h3C,8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h3C};//0
					1:
					oData <= {8'h10,8'h18,8'h14,8'h10,8'h10,8'h10,8'h10,8'h10};//1
					2:
					oData <= {8'h7E,8'h2,8'h2,8'h7E,8'h40,8'h40,8'h40,8'h7E};//2
					3:
					oData <={8'h3E,8'h2,8'h2,8'h3E,8'h2,8'h2,8'h3E,8'h0};//3  
					4:
					oData <={8'h8,8'h18,8'h28,8'h48,8'hFE,8'h8,8'h8,8'h8};//4 
					5:
					oData <={8'h3C,8'h20,8'h20,8'h3C,8'h4,8'h4,8'h3C,8'h0};//5 
					6:
					oData <={8'h3C,8'h20,8'h20,8'h3C,8'h24,8'h24,8'h3C,8'h0};//6 
					7:
					oData <={8'h3E,8'h22,8'h4,8'h8,8'h8,8'h8,8'h8,8'h8};//7 
					8:
					oData <={8'h0,8'h3E,8'h22,8'h22,8'h3E,8'h22,8'h22,8'h3E};//8
					9:
					oData <={8'h3E,8'h22,8'h22,8'h3E,8'h2,8'h2,8'h2,8'h3E};//9  
					10:
					oData <={8'h8,8'h14,8'h22,8'h3E,8'h22,8'h22,8'h22,8'h22};//A
					11:
					oData <={8'h3C,8'h22,8'h22,8'h3E,8'h22,8'h22,8'h3C,8'h0};//B
					12:
					oData <={8'h3C,8'h40,8'h40,8'h40,8'h40,8'h40,8'h3C,8'h0};//C
					13:
					oData <={8'h7C,8'h42,8'h42,8'h42,8'h42,8'h42,8'h7C,8'h0};//D
					14:
					oData <={8'h7C,8'h40,8'h40,8'h7C,8'h40,8'h40,8'h40,8'h7C};//E
					15:
					oData <={8'h7C,8'h40,8'h40,8'h7C,8'h40,8'h40,8'h40,8'h40};//F
					16:
					oData<={8'h3C,8'h40,8'h40,8'h40,8'h40,8'h44,8'h44,8'h3C};//G
					17:
					oData<={8'h44,8'h44,8'h44,8'h7C,8'h44,8'h44,8'h44,8'h44};//H
					18:
					oData<={8'h7C,8'h10,8'h10,8'h10,8'h10,8'h10,8'h10,8'h7C};//I
					19:
					oData<={8'h3C,8'h8,8'h8,8'h8,8'h8,8'h8,8'h48,8'h30};//J
					20:
					oData<={8'h0,8'h24,8'h28,8'h30,8'h20,8'h30,8'h28,8'h24};//K
					21:
					oData<={8'h40,8'h40,8'h40,8'h40,8'h40,8'h40,8'h40,8'h7C};//L
					22:
					oData<={8'h81,8'hC3,8'hA5,8'h99,8'h81,8'h81,8'h81,8'h81};//M
					23:
					oData<={8'h0,8'h42,8'h62,8'h52,8'h4A,8'h46,8'h42,8'h00};//N
					24:
					oData<={8'h3C,8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h3C};//O
					25:
					oData<={8'h3C,8'h22,8'h22,8'h22,8'h3C,8'h20,8'h20,8'h20};//P
					26:
					oData<={8'h1C,8'h22,8'h22,8'h22,8'h22,8'h26,8'h22,8'h1D};//Q
					27:
					oData<={8'h3C,8'h22,8'h22,8'h22,8'h3C,8'h24,8'h22,8'h21};//R
					28:
					oData<={8'h0,8'h1E,8'h20,8'h20,8'h3E,8'h2,8'h2,8'h3C};//S
					29:
					oData<={8'h0,8'h3E,8'h8,8'h8,8'h8,8'h8,8'h8,8'h8};//T
					30:
					oData<={8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h22,8'h1C};//U
					31:
					oData<={8'h42,8'h42,8'h42,8'h42,8'h42,8'h42,8'h24,8'h18};//V
					32:
					oData<={8'h0,8'h49,8'h49,8'h49,8'h49,8'h2A,8'h1C,8'h0};//W
					33:
					oData<={8'h0,8'h41,8'h22,8'h14,8'h8,8'h14,8'h22,8'h41};//X
					34:
					oData<={8'h41,8'h22,8'h14,8'h8,8'h8,8'h8,8'h8,8'h8};//Y
					35:
					oData<={8'h0,8'h7F,8'h2,8'h4,8'h8,8'h10,8'h20,8'h7F};//Z
					36:
					oData<= {8'h8,8'h7F,8'h49,8'h49,8'h7F,8'h8,8'h8,8'h8};//中
					37:
					oData<={8'hFE,8'hBA,8'h92,8'hBA,8'h92,8'h9A,8'hBA,8'hFE};//国
					default:
					oData<={8'h8,8'h7F,8'h49,8'h49,8'h7F,8'h8,8'h8,8'h8};//中
				endcase

//***************************************************************************//
wire CallU1,DoneU2;
wire [7:0] oDATA0, oDATA1; 
	 max7219_ctrlmod U1
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .iCall( iCall ),  // < top
		  .oDone( oDone ),    // > top
		  .iData( oData ),    // > top
		  .oCall( CallU1 ),  // > U2
		  .iDone( DoneU2 ),    // < U2
		  .oDATA0( oDATA0 ),    // > U2
		  .oDATA1( oDATA1 )     // > U2
	 );

	 
	 max7219_funcmod U2
	 (
	     .CLOCK( CLOCK ),
		  .RST_n( RST_n ),
		  .MAX7219_CS( MAX7219_CS ),   // > top
		  .MAX7219_SCLK( MAX7219_SCLK ),         // > top
		  .MAX7219_DATA( MAX7219_DATA ),         // <> top
		  .iCall( CallU1 ),            // < U1
		  .oDone( DoneU2 ),              // > U1
		  .iDATA0( oDATA0 ),              // > U1
		  .iDATA1( oDATA1 )              // > U1
	 );

endmodule
