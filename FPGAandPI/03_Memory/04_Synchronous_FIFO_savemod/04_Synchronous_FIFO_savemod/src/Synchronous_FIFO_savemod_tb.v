//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-04-07 01:17:11
//****************************************//
module Synchronous_FIFO_savemod_tb; // 申明TestBench名称
reg clock;
reg reset; // 申明信号
reg [1:0]oEn;
wire [3:0]oData;
reg [3:0]iData;
wire [1:0]iTag;


// 申明同步FIFO设计单元
Synchronous_FIFO_savemod dut
(
	.CLOCK(clock),
	.RESET(reset),
	.iEn(oEn),
	.iData(iData),
	.oData(oData),
	.oTag(iTag)
	);

initial begin   // 建立时钟
    clock = 0;
    forever #50 clock = ~clock;
end

initial begin   // 提供激励
    reset = 0;
	 oEn=2'b00;
    #200
    reset = 1;
    #5000 $stop;
end

reg [0:3] i;

always@(posedge clock or negedge reset)
	if (!reset)
		begin
			i <= 0;
		end
	else begin
		case( i ) // Core
		0:
			if( !iTag[1] ) begin oEn[1] <= 1'b1; iData <= 4'hA; i <= i + 1'b1; end
		1:
			if( !iTag[1] ) begin oEn[1] <= 1'b1; iData <= 4'hB; i <= i + 1'b1; end
		2:	
			if( !iTag[1] ) begin oEn[1] <= 1'b1; iData <= 4'hC; i <= i + 1'b1; end
		3:
			if( !iTag[1] ) begin oEn[1] <= 1'b1; iData <= 4'hD; i <= i + 1'b1; end
		4:
			begin oEn[1] <= 1'b0; i <= i + 1'b1; end
		5:
			if( !iTag[0] ) begin oEn[0] <= 1'b1; i <= i + 1'b1; end
		6:
			if( !iTag[0] ) begin oEn[0] <= 1'b1; i <= i + 1'b1; end
		7:
			if( !iTag[0] ) begin oEn[0] <= 1'b1; i <= i + 1'b1; end
		8:	
			if( !iTag[0] ) begin oEn[0] <= 1'b1; i <= i + 1'b1; end
		9:
			begin oEn[0] <= 1'b0; i <= i + 1'b1; end
		10:
			begin i <= 0; end
		default:;
	endcase

	end

endmodule


