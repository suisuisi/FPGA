//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-06-27 21:24:42
//****************************************//
`timescale 1ns/ 1ns
module lcd1602_ctrlmod_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

// Inputs
    wire CallU1;
    wire DoneU2;
    wire [7:0] oDATA;
localparam  [127:0] line_rom1 = "Hello World*^_^*";
localparam  [127:0] line_rom2 = "I am CrazyBingo!"; 
    // Outputs
    wire LCD1602_RS;
    wire LCD1602_RW;
    wire LCD1602_EN;
    wire [7:0] LCD1602_D;
   
lcd1602_ctrlmod dut
     (
         .CLOCK( clock ),
          .RST_n( reset ),
          .iCall(1'b1),
          .LCD1602_RS( LCD1602_RS ),   // > top
          .LCD1602_RW( LCD1602_RW ),         // > top
          .LCD1602_EN( LCD1602_EN ),         // <> top
          .LCD1602_D (LCD1602_D ),
          .line_rom1(line_rom1),        // < U1
          .line_rom2(line_rom2),
          .oDone( DoneU2),              // > U1
          .oCall( CallU1 ),
 //        .iDone(),
          .oDATA( oDATA )             // > U1
     );
    

initial begin   // 建立时钟
    clock = 0;
    forever #20 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
//    CallU1 = 0;
//    DoneU2 = 1;
 //   oDATA = 8'h00;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;
    #5000000 $stop;
end

     

endmodule


