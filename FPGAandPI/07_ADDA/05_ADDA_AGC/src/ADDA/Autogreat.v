module Autogreat(clkin_50MHz,ADCclk_25MHz,DACclk_25MHz,ADCin,DACout);
//50MHz 分频 25MHz， ADCin 读入 8 位 ADC 数据， DACout 发送 8 位转换数据，进行 DAC 转换
input clkin_50MHz;
input [7:0]ADCin;
output reg ADCclk_25MHz;
output reg DACclk_25MHz;
output reg[7:0]DACout;
reg[3:0]counter;
reg[8:0]cnt500;//2^9=512，采集 500 次，进行冒泡
//reg [7:0]max,tmp;//冒泡使用
reg [7:0]tmp;
reg [7:0]great;//定义增益使用
reg [7:0]great1;//接受 great 的高八位
reg [15:0]tmp16;
reg [7:0]realgreat;//真正增益，相当于 great 右移 8 位
//---@分频开始@---//
always@(posedge clkin_50MHz)
	begin
		if(counter==1)
		begin
			ADCclk_25MHz<=~ADCclk_25MHz;
			DACclk_25MHz<=~DACclk_25MHz;
			counter<=0;
		end
		else if(counter==0)
		begin
			counter<=counter+1;
		end
	end
//---@分频结束@---//
//---@获取自动增益，并调整输出电压开始@---//
always@(posedge DACclk_25MHz)
	begin
		tmp16<=(ADCin-128)*great1;//ADCin-128,取中线上面部分，
//128 即 1000_0000 为正电压中心线，乘以增益，单边放大
		realgreat<=tmp16[15:8];//取得 tmp 高 8 位，即浮点数整数部分
		DACout<=128+realgreat;//真正 DAC 输出部分
//---@实验成功语句@---//
//---@DACout<=(ADCin-128)*1+128;@---//
//---@实验成功语句@---//
	end
//---@对 ADCin 进行处理@---//
always@(posedge ADCclk_25MHz)
	begin
//---@冒泡取大开始@---//
		if(cnt500>=500)
		begin
			cnt500<=0;
//max<=tmp;//取得 500 次采样最大值
//great<=(64*256)/(max-128);//64 为设定电压值，相当于放大倍数，
//64 乘以 256 相当于左移 8 位，需要 16 位储存， max-8'b10000000
			great<=(36*256)/(tmp-128);//此时 great 为 16 位，需要其高八位,
//64 为 0100_0000，当设置输出为正负 2.5V 时用 64，比较时运用差值
			great1<=great[7:0];
		end
		else if(cnt500<500)//在两个信号周期内采样
	begin
		if(tmp<=ADCin)//当前 tmp 小于等于 ADCin
		begin
			tmp<=ADCin;//冒泡取得比当前大的值
		end
		else
		begin
			tmp<=tmp;//保持当前值
		end
			cnt500<=cnt500+1;//cnt500 自增
		end
//---@冒泡取大结束@---//
	end
//---@获取自动增益，并调整输出电压结束@---//
endmodule