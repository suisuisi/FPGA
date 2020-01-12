//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-06-26 21:41:06
//****************************************//
`timescale 1ns/ 1ns
module lcd1602_funcmod_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

// Inputs
    reg CallU1;
    wire DoneU2;
    reg [7:0] oDATA;

    // Outputs
    wire LCD1602_RS;
    wire LCD1602_RW;
    wire LCD1602_EN;
    wire [7:0] LCD1602_D;
  
lcd1602_funcmod dut
     (
         .CLOCK( clock ),
          .RST_n( reset ),
          .LCD1602_RS( LCD1602_RS ),   // > top
          .LCD1602_RW( LCD1602_RW ),         // > top
          .LCD1602_EN( LCD1602_EN ),         // <> top
          .LCD1602_D (LCD1602_D ),
          .iCall( CallU1 ),            // < U1
          .oDone( DoneU2 ),              // > U1
          .iDATA( oDATA )             // > U1
     );
    

initial begin   // 建立时钟
    clock = 0;
    forever #20 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
    CallU1 = 0;
//    DoneU2 = 1;
    oDATA = 8'h00;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;
    #5000000 $stop;
end

/***************************/
reg[7:0] i;
reg isDone;
/***************************/
    always @ ( posedge clock or negedge reset )
         if( !reset )
              begin
                    oDATA <= 8'h00;
                    CallU1 <= 0;
                    i  <= 8'd0;
                    isDone <= 1'b0;
                end
          else if ( 1'b1 )
              case( i )
//************************初始化操作*********************************//
                    0 :
                     if( DoneU2 ) begin CallU1 <= 1'b0; i <= i + 1'b1;  end
                     else begin CallU1 <= 1'b1;oDATA = 8'h09; end
                     
                     1 :
                     begin isDone <= 1'b1; i <= i + 1'b1; end
                     
                     2 :
                     begin isDone <= 1'b0; i <= i + 1'b1; end

                     3 :
                     if( DoneU2 ) begin CallU1 <= 1'b0; i <= i + 1'b1; end
                     else begin CallU1 <= 1'b1;oDATA = 8'h0a;  end
                     
                     4 :
                     begin isDone <= 1'b1; i <= i + 1'b1; end
                     
                     5 :
                     begin isDone <= 1'b0; i <= i + 1'b1; end

                    

/*                     8'd2 : // 扫描界限；8个数码管显示
                     begin oDATA0 = 8'h0b; oDATA1 = 8'h07; i <= i+1; end

                     8'd3 : // 掉电模式：0，普通模式：1
                     begin oDATA0 = 8'h0c; oDATA1 = 8'h01; i <= i+1; end
                
                     8'd4 : // 显示测试：1；测试结束，正常显示：0
                     begin oDATA0 = 8'h0f; oDATA1 = 8'h00; i <= i+1; end*/
//************************初始化操作结束******************************//   
//************************显示第一位*********************************//  
/*                    8'd5 : 
                     begin oDATA0 =8'h10; oDATA1 = 8'hFE; i <= i+1; end
                     
                    8'd6 : 
                     begin oDATA0 = 8'h92; oDATA1 = 8'h92; i <= i+1; end

                    8'd7 : 
                     begin oDATA0 = 8'hFE; oDATA1 = 8'h10; i <= i+1; end

                    8'd8 : 
                     begin oDATA0 = 8'h10; oDATA1 =8'h10; i <= i+1; end*/
                     
                    8'd6 : // 循环显示
                     begin i <= i;  end

                endcase
     

endmodule


