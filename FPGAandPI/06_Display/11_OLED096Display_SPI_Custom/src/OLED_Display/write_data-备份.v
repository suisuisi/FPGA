/*--------------------------------------------------------------*\
	Filename	:	write_data.v
	Author		:	Cwang
	Description	:	
	Revision History	:	2017-10-116
							Revision 1.0
	Email		:	wangcp@hitrobotgroup.com
	Company		:	Micro nano institute
	Copyright(c) 2017,Micro nano institute,All right resered
\*---------------------------------------------------------------*/
module write_data(
	input clk_1m,
	input rst_n,
	input write_data_start,
	input spi_write_done,
	input [7:0] rom_data,
	
	output spi_write_start,
	output write_done,
	output [9:0]spi_data,
	output [9:0] rom_addr
	
);


	reg [7:0] x;
	reg [3:0] y;		//y是清屏时用，页地址
	reg [1:0] z;		//z是从rom写数据时用，页地址
	reg [5:0] i;
	reg [9:0] data;
	reg start;
	reg isdone;
	

	always @(posedge clk_1m or negedge rst_n)
	begin
		if(!rst_n)
		begin
			i <= 5'd0;
			x <= 8'd00;
			y <= 4'd0;
			z <= 2'd0;
			data <= {2'b11,8'h00};
			start <= 1'b0;
			isdone <= 1'b0;
		end
		else	
		begin
			if(write_data_start)
				case(i)
				//----------------------------------------------------
				//清屏
				  6'd0,6'd4,6'd8,6'd12,6'd16,6'd20,6'd24,6'd28:
					if(spi_write_done) 
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//列高位		
					6'd1,6'd5,6'd9,6'd13,6'd17,6'd21,6'd25,6'd29:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h1,4'h0}; start <= 1'b1; end
				//列低位
					6'd2,6'd6,6'd10,6'd14,6'd18,6'd22,6'd26,6'd30:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end

					6'd3,6'd7,6'd11,6'd15,6'd19,6'd23,6'd27,6'd31:
					if(x==8'd128)
						begin y <= y + 1'b1; x <= 8'd0; i <= i + 1'b1; end
					else 
						if(spi_write_done)
							begin start <= 1'b0; x <= x + 1'b1; end
						else	
							begin data <= {2'b01,8'd00}; start <= 1'b1; end  
				//---------------------------------------------------------------		
				6'd32:
					begin y <= 4'h0; i <= i + 1'b1; end
					
				//设置页地址0
					6'd33,6'd37:
					if(spi_write_done) 
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
					6'd34,6'd38:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h1,4'h0}; start <= 1'b1; end
				//低地址	
					6'd35,6'd39:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//填充8次		
					6'd36,6'd40:
					if(x==8'd7)
						begin y <= y + 1'b1; x <= 8'd0; i <= i + 1'b1; end
					else 
						if(spi_write_done)
							begin start <= 1'b0; x <= x + 1'b1; end
						else	
							begin data <= {2'b01,rom_data}; start <= 1'b1; end
		//----------------------------------------------------------------------------			
					6'd41:
						begin data <= {2'b01,8'd00}; y <= 4'd0; z <= 2'd0; isdone <= 1'b1; i <= i + 1'b1; end
					6'd42:
						begin isdone <= 1'b0; i <= 6'd0; end					
				endcase		
		end
	end
	
	/*
	always @(posedge clk_1m or negedge rst_n)
	begin
		if(!rst_n)
		begin
			i <= 6'd0;
			x <= 8'd0;
			y <= 4'd0;
			data <= {2'b11,8'h00};
			start <= 1'b0;
			isdone <= 1'b0;
		end
		else
		
		begin
			if(write_data_start)
				case(i)
				//PAGE
					6'd0,6'd4:
					if(spi_write_done) 
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//列高位		
					6'd1,6'd5:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h1,4'h0}; start <= 1'b1; end
				//列低位
					6'd2,6'd6:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//开始写数据-128列开始填充数据
					6'd3,6'd7:
					if(x==8'd7)
						begin y <= y + 1'b1; x <= 8'd0; i <= i + 1'b1; end
					else 
						if(spi_write_done)
							begin start <= 1'b0; x <= x + 1'b1; end
						else	
							begin data <= {2'b01,rom_data}; start <= 1'b1; end
					
		//----------------------------------------------------------------------------			
					6'd32:
						begin data <= {2'b01,8'd00}; y <= 4'd0; isdone <= 1'b1; i <= i + 1'b1; end
					6'd33:
						begin isdone <= 1'b0; i <= 6'd0; end					
				endcase		
		end
	end
	*/
	assign rom_addr = x + (y << 3);
	assign write_done = isdone;
	assign spi_data = data;
	assign spi_write_start = start;
	
endmodule

	
	