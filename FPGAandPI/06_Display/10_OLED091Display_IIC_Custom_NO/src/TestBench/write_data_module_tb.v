//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-07-14 18:37:17
//****************************************//
`timescale 1ns/ 1ns
module write_data_module_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

// Inputs

    // Outputs
    wire OLED_SCL;
    wire OLED_SDA;
    wire oDone;

write_data_module dut
     (
         .CLOCK( clock ),
          .RST_n( reset ),
          .write_data_start(1'b1),
          .write_done(oDone),
          .OLED_SCL( OLED_SCL ),   // > top
          .OLED_SDA( OLED_SDA )         // > top

        
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


