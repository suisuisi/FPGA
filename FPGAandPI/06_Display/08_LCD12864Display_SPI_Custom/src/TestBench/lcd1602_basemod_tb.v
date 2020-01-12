//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-06-29 17:46:16
//****************************************//
`timescale 1ns/ 1ns
module lcd1602_basemod_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

// Inputs

    // Outputs
    wire LCD1602_RS;
    wire LCD1602_RW;
    wire LCD1602_EN;
    wire [7:0] LCD1602_D;
   
lcd1602_basemod dut
     (
         .CLOCK( clock ),
          .RST_n( reset ),

          .LCD1602_RS( LCD1602_RS ),   // > top
          .LCD1602_RW( LCD1602_RW ),         // > top
          .LCD1602_EN( LCD1602_EN ),         // <> top
          .LCD1602_D (LCD1602_D )
        
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


