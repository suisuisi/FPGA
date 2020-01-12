/*--------------------------------------------------------------*\
	Filename	:	spi_write_module.v
	Author		:	Cwang
	Description	:	
	Revision History	:	2017-10-116
							Revision 1.0
	Email		:	wangcp@hitrobotgroup.com
	Company		:	Micro nano institute
	Copyright(c) 2017,Micro nano institute,All right resered
\*---------------------------------------------------------------*/
/*
	spi_out:	3	2	1	0
				CS	DC	SCL(D0)	SDA(D1)
*/
module spi_write(
	clk_1m,
	RST_n,
	spi_write_start,
	spi_data,
	
	spi_write_done,
	spi_out
	);
	
	input clk_1m;
	input RST_n;
	input spi_write_start;
	input [9:0] spi_data;
	
	output spi_write_done;
	output [3:0]spi_out;
	
	parameter TIME5US = 4'd9;
	reg [3:0] count;
	always @(posedge clk_1m or negedge RST_n)
	begin
		if(!RST_n)
			count <= 4'd0;
		else
			if(count == TIME5US)
				count <= 4'd0;
			else
				if(spi_write_start)
					count <= count + 1'b1;
				else
					count <= 4'd0;
	end
	
	reg [4:0] i;
	reg scl;
	reg sda;
	reg done;
	
	always @(posedge clk_1m or negedge RST_n)
	begin
		if(!RST_n)
		begin
			i <= 5'd0;
			scl  <= 1'b1;
			sda  <= 1'b0;
			done <= 1'b0;
		end
		else
		begin
			if(spi_write_start)
				case(i)
					5'd0,5'd2,5'd4,5'd6,5'd8,5'd10,5'd12,5'd14:
					begin
						if(count == TIME5US)
						begin
							scl <= 1'b0;			//scl下降沿设置数据
							sda <= spi_data[7 - (i>>1) ];
							i <= i + 1'b1;
						end
					end
					5'd1,5'd3,5'd5,5'd7,5'd9,5'd11,5'd13,5'd15:
					begin
						if(count == TIME5US)
						begin
							scl <= 1'b1;			//scl上升沿锁存数据
							i <= i + 1'b1;
						end
					end
					5'd16:
					begin
						done <= 1'b1;
						i <= i + 1'b1;
					end
					5'd17:
					begin
						done <= 1'b0;
						i <= 5'd0;
					end
				endcase
		end
	end
	
	assign spi_write_done = done;
	assign spi_out = {spi_data[9],spi_data[8],scl,sda};
	
	endmodule
	
