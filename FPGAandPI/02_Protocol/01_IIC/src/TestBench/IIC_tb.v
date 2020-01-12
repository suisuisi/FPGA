//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-04-17 21:23:14
//****************************************//
`timescale 1 ns/ 1 ns
module IIC_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号
wire       SCL;
wire      SDA;
wire [7:0]DataU1;
wire      DoneU1;
reg [7:0] D1,D2;
reg [1:0]isCall;
// 申明IIC协议设计单元
iic dut
	 (
	    .CLOCK( clock ),
		.RESET( reset ),
		.SCL( SCL ),         // 
		.SDA( SDA ),         // 
		.iCall( isCall ),  // Call/Done 有两位，即表示该模块有读功能还有写功能
		.oDone( DoneU1 ),    // 产生完成信号
		.iAddr( D1 ),        // 写入地址 iAddr
		.iData( D2 ),        // 写入数据 iData
		.oData( DataU1 )     // 读出数据 oData
	 );

initial begin   // 建立时钟
    clock = 0;
    forever #50 clock = ~clock;
end

initial begin   // 提供激励
    reset = 0;
    #200
    reset = 1;
    #5000000 $stop;
end

/***************************/

    reg [3:0]i;
	reg [23:0]D3;

/***************************/
always@(posedge clock or negedge reset)// core
	if (!reset)
		begin
			i <= 4'd0;
			{ D1,D2 } <= { 8'd0,8'd0 };
			D3 <= 24'd0;
			isCall <= 2'b00;
		end
	else

		case( i )
				
				     0:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd0; D2 <= 8'hAB; end
					 
					 1:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd1; D2 <= 8'hCD; end
					 
					 2:
					 if( DoneU1 ) begin isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b10; D1 <= 8'd2; D2 <= 8'hEF; end
					 
					 /*3:
					 if( DoneU1 ) begin D3[23:16] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd0; end
					 
					 4:
                     if( DoneU1 ) begin D3[15:8] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd1; end
					 
					 5:
					 if( DoneU1 ) begin D3[7:0] <= DataU1; isCall <= 2'b00; i <= i + 1'b1; end
					 else begin isCall <= 2'b01; D1 <= 8'd2; end*/
					 
					 3:
					 i <= i;
		
		endcase

	

endmodule


