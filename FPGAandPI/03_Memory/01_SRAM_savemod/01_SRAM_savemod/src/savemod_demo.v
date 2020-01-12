module savemod_demo
(
    CLOCK,
	 RESET,
	 LED,
	 
	 
	 SRAM_A,
	 SRAM_DB,
	 SRAM_WE_N,
	 SRAM_OE_N,
	 SRAM_UB_N,
	 SRAM_LB_N,
	 SRAM_CE_N
	 
	 
);   
    
	 
	 
	 input CLOCK,RESET;
	
	 output reg [3:0]LED;


	 
	 output reg[17:0]SRAM_A;  //2^18 == 256K
    inout [15:0]SRAM_DB;
    output SRAM_WE_N;  //sram write enable
	 output SRAM_OE_N;  //sram output enable
	 output SRAM_UB_N;  //sram Upper-byte control(IO15-IO8)
	 output SRAM_LB_N;  //sram Lower-byte control(IO7-IO0)
	 output SRAM_CE_N;  //sram Chip enable

////////////////////////////////////////////
reg[25:0] delay;	//延时计数器，不断计数，周期约为1.34s，用于产生定时信号。

always @ (posedge CLOCK or negedge RESET)
	if(!RESET) delay <= 26'd0;
	else delay <= delay+1;	
	
////////////////////////////////////////////
wire sram_wr_req;	// SRAM写请求信号，高电平有效，用于状态机控制。
wire sram_rd_req;	// SRAM读请求信号，高电平有效，用于状态机控制。


reg[15:0] wr_data;	// SRAM写入数据寄存器。
reg[15:0] rd_data;	// SRAM读出数据寄存器。


assign sram_wr_req = (delay == 26'd9999);	//产生写请求信号
assign sram_rd_req = (delay == 26'd19999);	//产生读请求信号
	
always @ (posedge CLOCK or negedge RESET)	//写入数据每1.34s自增1。
	if(!RESET) wr_data <= 16'd0;
	else if(delay == 26'd29999) wr_data <= wr_data+1'b1;	
	
always @ (posedge CLOCK or negedge RESET)	//写入地址每1.34s自增1。
	if(!RESET) SRAM_A <= 18'd0;
	else if(delay == 26'd29999) SRAM_A <= SRAM_A+1'b1;	
	
always @ (posedge CLOCK or negedge RESET)	//每1.34s比较一次同一地址写入和读出的数据。
	if(!RESET) LED[0] <= 1'b0;
	else if(delay == 26'd20099) begin
		if(wr_data == rd_data) LED[0] <= 1'b1;	//写入和读出数据一致，LED点亮
		else LED[0] <= 1'b0;			//写入和读出数据不同，LED熄灭
	end


////////////////////////////////////////////
//状态机控制SRAM的读或写操作。
parameter	IDLE	= 4'd0,
			WRT0	= 4'd1,
			WRT1	= 4'd2,
			REA0	= 4'd3,
			REA1	= 4'd4;

reg[3:0] cstate,nstate;	

////////////////////////////////////////////
`define	DELAY_80NS		(cnt==3'd7)		//用于产生SRAM读写时序所需要的延时。

reg[2:0] cnt;	//延时计数器

always @ (posedge CLOCK or negedge RESET)
	if(!RESET) cnt <= 3'd0;
	else if(cstate == IDLE) cnt <= 3'd0;
	else cnt <= cnt+1'b1;
	
////////////////////////////////////////////
always @ (posedge CLOCK or negedge RESET)	//时序逻辑控制状态变迁。
	if(!RESET) cstate <= IDLE;
	else cstate <= nstate;

always @ (cstate or sram_wr_req or sram_rd_req or cnt) begin	//组合逻辑控制不同状态的转换。
	case (cstate)
		IDLE: if(sram_wr_req) nstate <= WRT0;		//进入写状态。
			  else if(sram_rd_req) nstate <= REA0;	//进入读状态。
			  else nstate <= IDLE;
		WRT0: if(`DELAY_80NS) nstate <= WRT1;
			  else nstate <= WRT0;			
		WRT1: nstate <= IDLE;		
		REA0: if(`DELAY_80NS) nstate <= REA1;
			  else nstate <= REA0;		
		REA1: nstate <= IDLE;		
		default: nstate <= IDLE;
	endcase
end

////////////////////////////////////////////			
//SRAM读写数据的控制。
reg sdlink;				// SRAM数据总线方向控制信号，改值取1为输出，取0为输入。

always @ (posedge CLOCK or negedge RESET)		//在状态REA1时执行SRAM读数据操作。
	if(!RESET) rd_data <= 16'd0;
	else if(cstate == REA1) rd_data <= SRAM_DB;

always @ (posedge CLOCK or negedge RESET)		//控制不同状态下SRAM数据总线的方向。SRAM只有在执行写操作时为输出，其他时候均为输入。
	if(!RESET) sdlink <=1'b0;
	else begin
		case (cstate)
			IDLE: if(sram_wr_req) sdlink <= 1'b1;
				  else if(sram_rd_req) sdlink <= 1'b0;
				  else sdlink <= 1'b0;
			WRT0: sdlink <= 1'b1;
			default: sdlink <= 1'b0;
		endcase
	end

assign SRAM_DB = sdlink ? wr_data : 16'hzzzz;			
//assign SRAM_WE_N = ~sdlink;



assign SRAM_UB_N = 1'b0;
assign SRAM_LB_N = 1'b0;
assign SRAM_CE_N = 1'b0;
assign SRAM_WE_N = (~sdlink ? 1'b1 : 1'b0);
assign SRAM_OE_N = (~sdlink ? 1'b0 : 1'b1);
/*SRAM读写结束*/

endmodule
