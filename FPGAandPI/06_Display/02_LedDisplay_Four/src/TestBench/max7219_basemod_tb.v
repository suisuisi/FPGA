//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-07-07 02:58:26
//****************************************//
`timescale 1ns/ 1ns
module max7219_basemod_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

// Inputs

    // Outputs
    wire MAX7219_CS;
    wire MAX7219_SCLK;
    wire MAX7219_DATA;

max7219_basemod dut
     (
         .CLOCK( clock ),
          .RST_n( reset ),

          .MAX7219_CS( MAX7219_CS ),   // > top
          .MAX7219_SCLK( MAX7219_SCLK ),         // > top
          .MAX7219_DATA( MAX7219_DATA ),         // <> top
          .iCall(1'b1),
          .oDone(oDone),
          .iData1({8'h7C,8'h10,8'h10,8'h10,8'h10,8'h10,8'h10,8'h7C}),
          .iData2({8'h7C,8'h10,8'h10,8'h10,8'h10,8'h10,8'h10,8'h7C}),
          .iData3({8'h7C,8'h10,8'h10,8'h10,8'h10,8'h10,8'h10,8'h7C}),
          .iData4({8'h7C,8'h10,8'h10,8'h10,8'h10,8'h10,8'h10,8'h7C})
        
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
    #500000000 $stop;
end

     

endmodule


