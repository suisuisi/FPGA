module control_interface(
	CLK,
	RESET_N,
	CMD,
	ADDR,
	REF_ACK,
	INIT_ACK,
	CM_ACK,
	NOP,
	READA,
	WRITEA,
	REFRESH,
	PRECHARGE,
	LOAD_MODE,
	SADDR,
	REF_REQ,
	INIT_REQ,
	CMD_ACK
);

`include        "Sdram_Params.h"

	input                   CLK;        // SDRAM控制器工作时钟
	input                   RESET_N;    // SDRAM控制器复位输入信号
	input   [2:0]           CMD;        // 命令，输入
	input   [`ASIZE-1:0]    ADDR;       // 地址输入，该地址宽度为SDRAM行地址、列地址、bank地址之和
	input                   REF_ACK;    // 刷新请求的响应信号
	input							INIT_ACK;	// 初始化请求响应信号
	input                   CM_ACK;     // 命令响应信号
	output                  NOP;        // 输出NOP命令
	output                  READA;      // 输出读数据READA命令
	output                  WRITEA;     // 输出写数据WRITEA命令
	output                  REFRESH;    // 输出自刷新REFRESH命令
	output                  PRECHARGE;  // 输出预充电PRECHARGE命令
	output                  LOAD_MODE;  // 输出加载模式寄存器LOAD_MODE命令
	output  [`ASIZE-1:0]    SADDR;      // 地址输出，该地址宽度为SDRAM行地址、列地址、bank地址之和
	output                  REF_REQ;    // 刷新请求输出
	output                  INIT_REQ;   // 初始化请求输出
	output                  CMD_ACK;    // 命令响应输出

	reg                     NOP;
	reg                     READA;
	reg                     WRITEA;
	reg                     REFRESH;
	reg                     PRECHARGE;
	reg                     LOAD_MODE;
	reg     [`ASIZE-1:0]    SADDR;
	reg                     REF_REQ;
	reg                     INIT_REQ;
	reg                     CMD_ACK;

	// Internal signals
	reg     [15:0]          timer;
	reg		[15:0]			init_timer;

	//对地址进行寄存
	always @(posedge CLK or negedge RESET_N)
	if (RESET_N == 0)
		SADDR <= 0;
	else
		SADDR <= ADDR; 

	//对指令进行译码并得到指令控制信号输出
	always @(posedge CLK or negedge RESET_N)
	if (RESET_N == 0) begin
		NOP    <= 0;
		READA  <= 0;
		WRITEA <= 0;
	end
	else begin
		if (CMD == 3'b000)                              // NOP command
			NOP <= 1;
		else
			NOP <= 0;
	
		if (CMD == 3'b001)                              // READA command
			READA <= 1;
		else
			READA <= 0;
	
		if (CMD == 3'b010)                              // WRITEA command
			WRITEA <= 1;
		else
			WRITEA <= 0;
	end
	
	//  产生CMD_ACK
	always @(posedge CLK or negedge RESET_N)
	if (RESET_N == 0)
		CMD_ACK <= 0;
	else if ((CM_ACK == 1) & (CMD_ACK == 0))
		CMD_ACK <= 1;
	else
		CMD_ACK <= 0;

	// 刷新定时器
	always @(posedge CLK or negedge RESET_N)
	if (RESET_N == 0) begin
		timer           <= 0;
		REF_REQ         <= 0;
	end
	else begin
		if (REF_ACK == 1) begin
			timer <= REF_PER;
			REF_REQ	<=0;
		end
		else if (INIT_REQ == 1) begin
			timer <= REF_PER+8'd200;
			REF_REQ	<=0;
		end
		else
			timer <= timer - 1'b1;
	
		if (timer==0)
			REF_REQ    <= 1;
	end


// 初始化定时器
	always @(posedge CLK or negedge RESET_N)
    if (RESET_N == 0) begin
        init_timer      <= 0;
        REFRESH         <= 0;
        PRECHARGE      	<= 0;
        LOAD_MODE		<= 0;
        INIT_REQ		<= 0;
    end
    else begin
        if (init_timer < (INIT_PER+201))
            init_timer 	<= init_timer+1'b1;

        if (init_timer < INIT_PER) begin
            REFRESH		<=0;
            PRECHARGE	<=0;
            LOAD_MODE	<=0;
            INIT_REQ	<=1;
        end
        else if(init_timer == (INIT_PER+20)) begin
            REFRESH		<=0;
            PRECHARGE	<=1;
            LOAD_MODE	<=0;
            INIT_REQ	<=0;
        end
        else if( 	(init_timer == (INIT_PER+40))	||
                  (init_timer == (INIT_PER+60))	||
                  (init_timer == (INIT_PER+80))	||
                  (init_timer == (INIT_PER+100))	||
                  (init_timer == (INIT_PER+120))	||
                  (init_timer == (INIT_PER+140))	||
                  (init_timer == (INIT_PER+160))	||
                  (init_timer == (INIT_PER+180))	) begin
            REFRESH		<=1;
            PRECHARGE	<=0;
            LOAD_MODE	<=0;
            INIT_REQ	<=0;
        end
        else if(init_timer == (INIT_PER+200)) begin
            REFRESH		<=0;
            PRECHARGE	<=0;
            LOAD_MODE	<=1;
            INIT_REQ	<=0;
        end
        else begin
            REFRESH		<=0;
            PRECHARGE	<=0;
            LOAD_MODE	<=0;
            INIT_REQ	<=0;
        end
    end

endmodule

