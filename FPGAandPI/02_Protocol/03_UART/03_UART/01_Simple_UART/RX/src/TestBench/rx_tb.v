//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-04-23 22:48:14
//****************************************//
`timescale 1ns/ 1ps
module rx_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

    // Inputs

     reg isRX;


    // Outputs
    wire DoneU1;
    wire RXD;
    wire [7:0]DataU1;




// 申明UART协议设计单元
rx_funcmod dut
	 (
	    .CLOCK( clock ),
		.RESET( reset ),
		.RXD( RXD ),         // < top
		.iCall( isRX ),     // < core
		.oDone( DoneU1 ),    // > core
		.oData( DataU1 )     // > core
	 );

/***************************/

    reg [4:0]i,Go;
	reg [10:0]D1;
	reg [8:0]C1;
	reg rRXD;
//	reg isRX;
	parameter B115K2 = 9'd434,TXFUNC = 5'd16;
/***************************/	
    

initial begin   // 建立时钟
    clock = 0;
    forever #10 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
	D1 = 11'd0;
    C1 = 9'd0;
	i  = 0;
	Go = 0;
	rRXD =0 ;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;
    #500000 $stop;
end

	 
always @ ( posedge clock or negedge reset )
	     if( !reset )
		      begin
				     i <= 4'd0;
					 D1 <= 8'd0;
					 isRX <= 1'b0;
					 C1 <= 9'd0;
				end
		  else
		      case( i )
				
				     0:
   			         begin   isRX <= 1'b0; D1 <= { 2'b11,8'hAB,1'b0 }; i <= TXFUNC; Go <= 5'd0;  end
	//				 if( DoneU1 ) begin   isRX <= 1'b0; D1 <= { 2'b11,8'hAB,1'b0 }; i <= TXFUNC; Go <= 5'd0;  end
	//				 else  

					 16,17,18,19,20,21,22,23,24,25,26:
					 if( C1 == B115K2 -1 ) begin C1 <= 8'd0; isRX <= 1'b1;i <= i + 1'b1; end
					 else begin isRX <= 1'b1;rRXD <= D1[i - 16]; C1 <= C1 + 1'b1; end

					 27: // Return
					 i <= Go;   //i<=i  Stop
				
				endcase

	
assign RXD=rRXD;
endmodule


