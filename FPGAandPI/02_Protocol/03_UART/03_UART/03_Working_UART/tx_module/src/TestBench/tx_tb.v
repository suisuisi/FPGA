//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-05-03 03:05:59
//****************************************//
`timescale 1ns/ 1ps
module tx_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

    // Inputs
     reg [7:0]D1;
     reg isTX;


    // Outputs
    wire DoneU1;
    wire TXD;



// 申明UART协议设计单元
tx_module dut
    (
        .CLOCK( clock ),
        .RST_n( reset ),
        .TX_Data( D1 ),
        .TX_En_Sig( isTX ),
        .TX_Done_Sig( DoneU1 ),
        .TXD( TXD )
    );


initial begin   // 建立时钟
    clock = 0;
    forever #10 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
//    DoneU1 = 0;
//    TXD = 1;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;
    #500000 $stop;
end

/***************************/

    reg [3:0]i;

/***************************/
always @ ( posedge clock or negedge reset )
    if( !reset )
              begin
                     i <= 4'd0;
                     D1 <= 8'd0;
                     isTX <= 1'b0;
                end
    else
        case( i )
                
                    0:
                     if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
                     else begin isTX <= 1'b1; D1 <= 8'hAB; end
                     
                     1:
                     if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
                     else begin isTX <= 1'b1; D1 <= 8'hCD; end
                     
                     2:
                     if( DoneU1 ) begin isTX <= 1'b0; i <= i + 1'b1; end
                     else begin isTX <= 1'b1; D1 <= 8'hEF; end
                     
                     3: // Stop
                     i <= i;
                
         endcase

	

endmodule


