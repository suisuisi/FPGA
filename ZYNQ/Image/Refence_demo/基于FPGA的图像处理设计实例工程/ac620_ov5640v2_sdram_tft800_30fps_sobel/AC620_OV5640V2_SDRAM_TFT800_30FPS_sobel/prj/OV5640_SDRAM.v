module OV5640_SDRAM(
	input		clk,
	input		reset_n,

	//摄像头模块I/O
	output		cmos_sclk,
	inout			cmos_sdat,
	input			cmos_vsync,
	input			cmos_href,
	input			cmos_pclk,
	output		cmos_xclk,
	input	[7:0]	cmos_data,
	output		cmos_rst_n,	
	output		cmos_pwdn,	
	
	//SDRAM存储器I/O
	output			sdram_clk,	//SDRAM 同步时钟信号
	output			sdram_cke,	//SDRAM 时钟使能	
	output			sdram_cs_n,	//SDRAM 片选信号
	output			sdram_we_n,	//SDRAM 写请求信号
	output			sdram_cas_n,//SDRAM 列选中信号	
	output			sdram_ras_n,//SDRAM 行选中信号	
	output	[1:0]	sdram_dqm,	//SDRAM 数据总线高低字节屏蔽信号	
	output	[1:0]	sdram_ba,	//SDRAM bank地址线	
	output	[12:0]sdram_addr,	//SDRAM 地址线
	inout		[15:0]sdram_dq,	//SDRAM 双向数据总线	
	
	//TFT显示屏I/O
	output			TFT_VCLK,		
	output			TFT_HS,		 
	output			TFT_VS,	
	output			TFT_DE,
	output	[15:0]TFT_RGB,		
	output 			TFT_BL
);

	assign TFT_BL = 1;	//TFT显示屏背光控制脚，默认常亮
	
	assign cmos_pwdn = 1'b0;	//CMOS摄像头掉电控制脚，为0则不掉电，正常工作
	assign cmos_rst_n = 1'b1;	//CMOS摄像头复位请求，高电平正常工作，低电平摄像头模块复位

	wire clk_sdr_ctrl;	//SDRAM控制器工作时钟
	wire clk_cmos;			//摄像头模块驱动时钟
	wire clk_tft;			//TFT显示屏和TFT控制器工作时钟
	
	wire tft_data_req;		//TFT显示屏请求读SDRAM数据信号
	wire [15:0]rgb_data_in;	//TFT屏待显示数据

	//采集模块数据输出信号
	wire			cmos_frame_vsync;	//图像数据场有效信号
	wire			cmos_frame_href;	//图像数据行有效信号
	wire	[15:0]cmos_frame_data;	//16位像素数据输出{cmos_data[7:0]<<8, cmos_data[7:0]}	
	wire			cmos_frame_clken;	//图像数据输出有效信号
	wire	[7:0]	cmos_fps_rate;		//图像输出帧率
	
	wire cmos_init_flag;				//摄像头初始化完成标志信号
	
	pll pll(
		.inclk0(clk),
		.c0(clk_sdr_ctrl),
		.c1(sdram_clk),
		.c2(clk_tft),
		.c3(clk_cmos)
	);

	wire	i2c_config_done;
	I2C_OV5640_Init_RGB565	u_I2C_OV5640_Init_RGB565
	(
		.clk				(clk),			//50MHz
		.rst_n			(reset_n),		//Global Reset
		.i2c_sclk		(cmos_sclk),	//I2C CLOCK
		.i2c_sdat		(cmos_sdat),	//I2C DATA
			
		.config_done	(cmos_init_flag)	//配置完成标志信号
	);

	CMOS_Capture_RGB565	
	#(
		.CMOS_FRAME_WAITCNT		(4'd10) //开始工作后，需要忽略的n帧数据（刚开始的几帧图像不稳定）
	)
	u_CMOS_Capture_RGB565
	(
		//global clock
		.clk_cmos				(clk_cmos),			//24MHz 摄像头模块驱动时钟输入
		.rst_n					(reset_n & cmos_init_flag),	//global reset

		//摄像头接口
		.cmos_pclk				(cmos_pclk),  		//84MHz 摄像头PCLK信号，由摄像头模块输入
		.cmos_xclk				(cmos_xclk),		//24MHz 摄像头参考时钟输出，由FPGA输出给摄像头
		.cmos_din				(cmos_data),		//8位摄像头输入数据线
		.cmos_vsync				(cmos_vsync),		//摄像头场有效信号，L: vaild, H: invalid
		.cmos_href				(cmos_href),		//摄像头行有效信号，H: vaild, L: invalid
		
		//采集模块数据输出端口
		.cmos_frame_vsync		(cmos_frame_vsync),	//图像数据场有效信号
		.cmos_frame_href		(cmos_frame_href),	//图像数据行有效信号
		.cmos_frame_data		(cmos_frame_data),	//16位像素数据输出{{R[4:0],G[5:3]}, {G2:0}, B[4:0]}	
		.cmos_frame_clken		(cmos_frame_clken),	//图像数据输出有效信号
		//user interface
		.cmos_fps_rate			(cmos_fps_rate)		//图像输出帧率
	);

	Sdram_Control_4Port Sdram_Control_4Port(
		//	HOST Side
		.CTRL_CLK(clk_sdr_ctrl),	//输入参考时钟，默认100M，如果为其他频率，请修改sdram_pll核设置
		.RESET_N(reset_n),			//复位输入，低电平复位

		//	FIFO Write Side 1
		.WR1_DATA(cmos_frame_data),	//写入端口1的数据输入端，16bit
		.WR1(cmos_frame_clken),				//写入端口1的写使能端，高电平写入
		.WR1_ADDR(0),				//写入端口1的写起始地址
		.WR1_MAX_ADDR(800*480),	//写入端口1的写入最大地址
		.WR1_LENGTH(256),			//一次性写入数据长度
		.WR1_LOAD((~reset_n) &(~cmos_init_flag)),			//写入端口1清零请求，高电平清零写入地址和fifo
		.WR1_CLK(cmos_pclk),	//写入端口1 fifo写入时钟
		.WR1_FULL(),			//写入端口1 fifo写满信号
		.WR1_USE(),				//写入端口1 fifo已经写入的数据长度

		//	FIFO Write Side 2
		.WR2_DATA(),			//写入端口2的数据输入端，16bit
		.WR2(1'b0),				//写入端口2的写使能端，高电平写入
		.WR2_ADDR(0),			//写入端口2的写起始地址
		.WR2_MAX_ADDR(800*480),		//写入端口2的写入最大地址
		.WR2_LENGTH(8),		//一次性写入数据长度
		.WR2_LOAD(1'b0),		//写入端口2清零请求，高电平清零写入地址和fifo
		.WR2_CLK(1'b0),		//写入端口2 fifo写入时钟
		.WR2_FULL(),			//写入端口2 fifo写满信号
		.WR2_USE(),				//写入端口2 fifo已经写入的数据长度

		//	FIFO Read Side 1
		.RD1_DATA(rgb_data_in),	//读出端口1的数据输出端，16bit
		.RD1(tft_data_req),		//读出端口1的读使能端，高电平读出
		.RD1_ADDR(0),				//读出端口1的读起始地址
		.RD1_MAX_ADDR(800*480),	//读出端口1的读出最大地址
		.RD1_LENGTH(256),			//一次性读出数据长度
		.RD1_LOAD((~reset_n) & (~cmos_init_flag)),			//读出端口1 清零请求，高电平清零读出地址和fifo
		.RD1_CLK(clk_tft),	//读出端口1 fifo读取时钟
		.RD1_EMPTY(),			//读出端口1 fifo读空信号
		.RD1_USE(),				//读出端口1 fifo已经还可以读取的数据长度

		//	FIFO Read Side 2
		.RD2_DATA(),			//读出端口2的数据输出端，16bit
		.RD2(1'b0),				//读出端口2的读使能端，高电平读出
		.RD2_ADDR(),			//读出端口2的读起始地址
		.RD2_MAX_ADDR(),		//读出端口2的读出最大地址
		.RD2_LENGTH(),			//一次性读出数据长度
		.RD2_LOAD(),			//读出端口2清零请求，高电平清零读出地址和fifo
		.RD2_CLK(1'b0),		//读出端口2 fifo读取时钟
		.RD2_EMPTY(),			//读出端口2 fifo读空信号
		.RD2_USE(),				//读出端口2 fifo已经还可以读取的数据长度

		//	SDRAM Side
		.SA(sdram_addr),		//SDRAM 地址线，
		.BA(sdram_ba),			//SDRAM bank地址线
		.CS_N(sdram_cs_n),	//SDRAM 片选信号
		.CKE(sdram_cke),		//SDRAM 时钟使能
		.RAS_N(sdram_ras_n),	//SDRAM 行选中信号
		.CAS_N(sdram_cas_n),	//SDRAM 列选中信号
		.WE_N(sdram_we_n),	//SDRAM 写请求信号
		.DQ(sdram_dq),			//SDRAM 双向数据总线
		.DQM(sdram_dqm)		//SDRAM 数据总线高低字节屏蔽信号
	);		
	
	wire [15:0]TFT_RGB565;	//TFT驱动模块输出的待显示数据
	wire [9:0] sobel_data;
	
	//定义三个颜色分量
	wire [4:0]TFT_R;
	wire [5:0]TFT_G;
	wire [4:0]TFT_B;
	
	TFT_CTRL_800_480_16bit TFT_CTRL_800_480_16bit(
		.Clk33M(clk_tft),	//系统输入时钟33MHZ
		.Rst_n(reset_n & cmos_init_flag),	//复位输入，低电平复位
		.data_in(rgb_data_in),	//待显示数据
		.hcount(),		//TFT行扫描计数器
		.vcount(),		//TFT场扫描计数器
		.TFT_RGB(TFT_RGB565),	//TFT数据输出
		.TFT_HS(TFT_HS),		//TFT行同步信号
		.TFT_VS(TFT_VS),		//TFT场同步信号
		.TFT_BLANK(),
		.TFT_VCLK(TFT_VCLK),
		.TFT_DE(TFT_DE)
	);
	
	//使用TFT屏的数据有效信号作为SDRAM数据读取请求信号
	assign tft_data_req = TFT_DE;
	
	//从TFT待显示数据中分离出R、G、B分量
	assign TFT_R = {TFT_RGB565[15:11]};
	assign TFT_G = {TFT_RGB565[10:5]};
	assign TFT_B = {TFT_RGB565[4:0]};
	
	sobel  sobel_inst(
       .iCLK(clk_tft),
       .iRST_N(reset_n & cmos_init_flag),
       .iTHRESHOLD(8'd6),
       .iDVAL(TFT_DE),
       .iDATA({4'd0,TFT_G}),
       .oDVAL(),
       .oDATA(sobel_data)
		 );
		
	assign TFT_RGB = {sobel_data[5:1],sobel_data[5:0],sobel_data[5:1]};
	
endmodule
