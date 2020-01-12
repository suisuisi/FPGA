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
	input RST_n,
	input write_data_start,
	input spi_write_done,
	input [7:0] rom_data,
	
	output spi_write_start,
	output write_done,
	output [9:0]spi_data,
	output  [9:0] rom_addr
	
);

	reg [7:0] x;
	reg [3:0] y;		
	reg [7:0] i;
	reg [9:0] data;
	reg start;
	reg isdone;
	
	reg [27:0] cnt;
	reg [15:0]  num;
	always @(posedge clk_1m or negedge RST_n)
	begin
		if(!RST_n)
		begin
			cnt <= 28'd0;
			num <= 16'd43400;
		end
		else
			if(cnt == 28'h4C4B40)
			begin
				num <= num + 1'b1;
				cnt <= 28'd0;
			end
			else
				if(num == 16'd45000)
					num <= 16'd44000;
				else
					cnt <= cnt + 1'b1;				
	end
//-----------------------------------------------------
	reg [3:0] ge;
	reg [3:0] shi;
	reg [3:0] bai;
	reg [3:0] qian;
	reg [3:0] wan;
	always @(posedge clk_1m or negedge RST_n)
	begin
		if(!RST_n)
		begin
			ge  <= 4'd0;
			shi <= 4'd0;
			bai <= 4'd0;
			qian<= 4'd0;
			wan <= 4'd0;
		end
		else
		begin
			ge  <= num % 10;
			shi <= num / 10    % 10;
			bai <= num / 100   % 10;
			qian<= num / 1000  % 10;
			wan <= num / 10000;
		end
	end
//-----------------------------------------------------	
	reg [3:0] j;
	reg ge_flag, shi_flag, bai_flag, qian_flag, wan_flag;
	reg F_flag, r_flag, e_flag, q_flag, maohao_flag;
	reg H_flag, z_flag;
	
	always @(posedge clk_1m or negedge RST_n)
	begin
		if(!RST_n)
		begin
			i <= 8'd0;
			j <= 4'd0;
			x <= 8'd0;
			y <= 4'd0;
			data <= {2'b11,8'h00};
			start <= 1'b0;
			isdone <= 1'b0;
			F_flag		<= 1'b0;
			r_flag		<= 1'b0;
			e_flag		<= 1'b0;
			q_flag		<= 1'b0;
			maohao_flag	<= 1'b0;
			H_flag      <= 1'b0;
			z_flag      <= 1'b0;
			ge_flag  	<= 1'b0;
			shi_flag 	<= 1'b0;
			bai_flag	<= 1'b0;
			qian_flag	<= 1'b0;
			wan_flag	<= 1'b0;
		end
		else	
		begin
			if(write_data_start)
				case(i)
				
				//----------------------------------------------------
				//清屏
				  8'd0,8'd4,8'd8,8'd12,8'd16,8'd20,8'd24,8'd28:
					if(spi_write_done) 
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//列高位		
					8'd1,8'd5,8'd9,8'd13,8'd17,8'd21,8'd25,8'd29:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h1,4'h0}; start <= 1'b1; end
				//列低位
					6'd2,8'd6,8'd10,8'd14,8'd18,8'd22,8'd26,8'd30:
					if(spi_write_done)
						begin start <= 1'b0; i <= i + 1'b1; end
					else
						begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end

					8'd3,8'd7,8'd11,8'd15,8'd19,8'd23,8'd27,8'd31:
					if(x==8'd128)
						begin y <= y + 1'b1; x <= 8'd0; i <= i + 1'b1; end
					else 
						if(spi_write_done)
							begin start <= 1'b0; x <= x + 1'b1; end
						else	
							begin data <= {2'b01,8'd00}; start <= 1'b1; end  
				//---------------------------------------------------------------
						
				8'd32:
					begin y <= 4'h0; i <= i + 1'b1; end
		//----------------------------------------------------------------------------	
				8'd33:
					begin F_flag <= 1'b1; i <= i + 1'b1; end
				8'd34:			//'F'
					case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h0}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0;  i <= i + 1'b1; end
							endcase
				8'd35:
					begin F_flag <= 1'b0; r_flag <= 1'b1; i <= i + 1'b1; end 
				8'd36:			//'r'
					case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h0}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h8}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0;  i <= i + 1'b1; end
							endcase
				8'd37:
					begin r_flag <= 1'b0; e_flag <= 1'b1; i <= i + 1'b1; end 
				8'd38:			//'e'
					case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h1}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0;  i <= i + 1'b1; end
							endcase
				8'd39:			
					begin e_flag <= 1'b0; q_flag <= 1'b1; i <= i + 1'b1; end 
				8'd40:			//'q'
					case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h1}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h8}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0;  i <= i + 1'b1; end
							endcase
				8'd41:
					begin q_flag <= 1'b0; maohao_flag <= 1'b1; i <= i + 1'b1; end 
				8'd42:			//':'
					case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h2}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0;  i <= i + 1'b1; end
							endcase
				8'd43:
					begin maohao_flag <= 1'b0; H_flag <= 1'b1; i <= i + 1'b1; end 
				8'd44:			//'H'
					case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h5}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0;  i <= i + 1'b1; end
							endcase
				8'd45:
					begin H_flag <= 1'b0; z_flag <= 1'b1; i <= i + 1'b1; end 	
				8'd46:			//'z'
					case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h5}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h8}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0;  i <= i + 1'b1; end
							endcase
				8'd47:
					begin z_flag <= 1'b0; ge_flag <= 1'b1; i <= i + 1'b1; end 	
				8'd48:
					case(ge)	
						4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9:
							case(j)
				//设置页地址			
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h4}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h6}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0; i <= i + 1'b1; end
							endcase
						default: ;
					endcase
				8'd49:
					begin ge_flag <= 1'b0; shi_flag <= 1'b1; i <= i + 1'b1; end
		//-------------------------------------------------------------------------------------			
				8'd50:
					case(shi)	
						4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9:
							case(j)
				//设置页地址
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h4}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0; i <= i + 1'b1; end								
							endcase
						default: ;
					endcase
				8'd51:
					begin shi_flag <= 1'b0; bai_flag <= 1'b1; i <= i + 1'b1; end
				8'd52:
					case(bai)	
						4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9:
							case(j)
				//设置页地址
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h3}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h8}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0; i <= i + 1'b1; end								
							endcase
						default: ;
					endcase
				8'd53:
					begin bai_flag <= 1'b0; qian_flag <= 1'b1; i <= i + 1'b1; end
				8'd54:
					case(qian)	
						4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9:
							case(j)
				//设置页地址
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h3}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h0}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0; i <= i + 1'b1; end								
							endcase
						default: ;
					endcase
				8'd55:
					begin qian_flag <= 1'b0; wan_flag <= 1'b1; i <= i + 1'b1; end
				8'd56:
					case(wan)	
						4'd0,4'd1,4'd2,4'd3,4'd4,4'd5,4'd6,4'd7,4'd8,4'd9:
							case(j)
				//设置页地址
							6'd0,6'd4:
								if(spi_write_done) 
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'hb,y}; start <= 1'b1; end
				//高地址	
							6'd1,6'd5:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h1,4'h2}; start <= 1'b1; end
				//低地址	
							6'd2,6'd6:
								if(spi_write_done)
									begin start <= 1'b0; j <= j + 1'b1; end
								else
									begin data <= {2'b00,4'h0,4'h8}; start <= 1'b1; end
				//填充8次		
							6'd3,6'd7:
								if(x==8'd7)
									begin y <= y + 1'b1; x <= 8'd0; j <= j + 1'b1; end
								else 
									if(spi_write_done)
										begin start <= 1'b0; x <= x + 1'b1; end
									else	
										begin data <= {2'b01,rom_data}; start <= 1'b1; end
							6'd8:
								begin y <= 4'h0; j <= 6'd0; i <= i + 1'b1; end								
							endcase
						default: ;
					endcase
				8'd57:
					begin wan_flag <= 1'b0;  i <= i + 1'b1; end			
				8'd58:
					i <= 6'd47;
				8'd59:
						begin data <= {2'b01,8'd00}; y <= 4'd0; isdone <= 1'b1; i <= i + 1'b1; end
				8'd60:
						begin isdone <= 1'b0; i <= 6'd33; end	
				endcase		
		end
	end
	
	assign rom_addr = 	F_flag  ? (y ? (x + 8'd168) : (x + 8'd160)) : //F
						(r_flag ? (y ? (x + 8'd184) : (x + 8'd176)) : 
						(e_flag ? (y ? (x + 8'd200) : (x + 8'd192)) : 
						(q_flag ? (y ? (x + 8'd216) : (x + 8'd208)) : 
						(maohao_flag ? (y ? (x + 8'd232) : (x + 8'd224)) :
						(H_flag ? (y ? (x + 8'd248) : (x + 8'd240))	:
						(z_flag ? (y ? (x + 12'd264) : (x + 12'd256))	:
						(ge_flag   ? (y ?  (x + (ge   << 4) + 4'd8) : (x + (ge   << 4))): 
						(shi_flag  ? (y ?  (x + (shi  << 4) + 4'd8) : (x + (shi  << 4))):
						(bai_flag  ? (y ?  (x + (bai  << 4) + 4'd8) : (x + (bai  << 4))):
						(qian_flag ? (y ?  (x + (qian << 4) + 4'd8) : (x + (qian << 4))):
						(y ? (x + (wan << 4) + 4'd8) : (x + (wan << 4))))))))))))); 
						
	assign write_done = isdone;
	assign spi_data = data;
	assign spi_write_start = start;
	
endmodule

	
	