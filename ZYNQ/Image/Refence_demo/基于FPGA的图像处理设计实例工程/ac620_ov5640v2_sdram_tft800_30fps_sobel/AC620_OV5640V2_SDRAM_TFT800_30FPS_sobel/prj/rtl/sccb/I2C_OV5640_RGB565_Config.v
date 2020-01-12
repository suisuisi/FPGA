/*-----------------------------------------------------------------------
								 \\\|///
							   \\  - -  //
								(  @ @  )  
+-----------------------------oOOo-(_)-oOOo-----------------------------+
CONFIDENTIAL IN CONFIDENCE
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo (Thereturnofbingo).
In the event of publication, the following notice is applicable:
Copyright (C) 2012-20xx CrazyBingo Corporation
The entire notice above must be reproduced on all authorized copies.
Author				:		CrazyBingo
Technology blogs 	: 		www.crazyfpga.com
Email Address 		: 		crazyfpga@vip.qq.com
Filename			:		I2C_OV5640_RGB565_Config
Date				:		2012-05-11
Description			:		OV5640 I2C Config with RGB565 Format.
Modification History	:
Date			By			Version			Change Description
=========================================================================
12/05/11		CrazyBingo	1.0				Original
12/05/13		CrazyBingo	1.1				Modification
12/06/01		CrazyBingo	1.4				Modification
12/06/05		CrazyBingo	1.5				Modification
13/04/08		CrazyBingo	1.6				Modification
17/09/17		CrazyBingo	2.0				Modified for OV5640 RGB565
-------------------------------------------------------------------------
|                                     Oooo								|
+-------------------------------oooO--(   )-----------------------------+
                               (   )   ) /
                                \ (   (_/
                                 \_)
-----------------------------------------------------------------------*/

`timescale 1ns/1ns
module	I2C_OV5640_RGB565_Config
(
	input		[8:0]	LUT_INDEX,
	output	reg	[23:0]	LUT_DATA,
	output		[8:0]	LUT_SIZE
);
assign		LUT_SIZE = 9'd254;


localparam	SET_OV5640	=	2;			//SET_OV LUT Adderss

//-----------------------------------------------------------------
/////////////////////	Config Data LUT	  //////////////////////////	
always@(*)
begin
	case(LUT_INDEX)
		//15fps VGA YUV output
		// 24MHz input clock, 24MHz PCLK
		SET_OV5640 +  0  :   	LUT_DATA	= 	24'h3103_11; // system clock from pad, bit[1]
		SET_OV5640 +  1  :   	LUT_DATA	= 	24'h3008_82; // software reset, bit[7]
		SET_OV5640 +  2  :   	LUT_DATA	= 	24'h3008_42; // software power down, bit[6]
		SET_OV5640 +  3  :   	LUT_DATA	= 	24'h3103_03; // system clock from PLL, bit[1]
		SET_OV5640 +  4  :   	LUT_DATA	= 	24'h3017_ff; // FREX, Vsync, HREF, PCLK, D[9:6] output enable
		SET_OV5640 +  5  :   	LUT_DATA	= 	24'h3018_ff; // D[5:0], GPIO[1:0] output enable
		SET_OV5640 +  6  :   	LUT_DATA	= 	24'h3034_1a; // MIPI 10-bit
		SET_OV5640 +  7  :   	LUT_DATA	= 	24'h3037_13; // PLL root divider, bit[4], PLL pre-divider, bit[3:0]
		SET_OV5640 +  8  :   	LUT_DATA	= 	24'h3108_01; // PCLK root divider, bit[5:4], SCLK2x root divider, bit[3:2]
		SET_OV5640 +  9  :   	LUT_DATA	= 	24'h3630_36;// SCLK root divider, bit[1:0]
		SET_OV5640 +  10 :   	LUT_DATA	= 	24'h3631_0e;
		SET_OV5640 +  11 :   	LUT_DATA	= 	24'h3632_e2;
		SET_OV5640 +  12 :   	LUT_DATA	= 	24'h3633_12;
		SET_OV5640 +  13 :   	LUT_DATA	= 	24'h3621_e0;
		SET_OV5640 +  14 :   	LUT_DATA	= 	24'h3704_a0;
		SET_OV5640 +  15 :   	LUT_DATA	= 	24'h3703_5a;
		SET_OV5640 +  16 :   	LUT_DATA	= 	24'h3715_78;
		SET_OV5640 +  17 :   	LUT_DATA	= 	24'h3717_01;
		SET_OV5640 +  18 :   	LUT_DATA	= 	24'h370b_60;
		SET_OV5640 +  19 :   	LUT_DATA	= 	24'h3705_1a;
		SET_OV5640 +  20 :   	LUT_DATA	= 	24'h3905_02;
		SET_OV5640 +  21 :   	LUT_DATA	= 	24'h3906_10;
		SET_OV5640 +  22 :   	LUT_DATA	= 	24'h3901_0a;
		SET_OV5640 +  23 :   	LUT_DATA	= 	24'h3731_12;
		SET_OV5640 +  24 :   	LUT_DATA	= 	24'h3600_08; // VCM control
		SET_OV5640 +  25 :   	LUT_DATA	= 	24'h3601_33; // VCM control
		SET_OV5640 +  26 :   	LUT_DATA	= 	24'h302d_60; // system control
		SET_OV5640 +  27 :   	LUT_DATA	= 	24'h3620_52;
		SET_OV5640 +  28 :   	LUT_DATA	= 	24'h371b_20;
		SET_OV5640 +  29 :   	LUT_DATA	= 	24'h471c_50;
		SET_OV5640 +  30 :   	LUT_DATA	= 	24'h3a13_43; // pre-gain = 1.047x
		SET_OV5640 +  31 :   	LUT_DATA	= 	24'h3a18_00; // gain ceiling
		SET_OV5640 +  32 :   	LUT_DATA	= 	24'h3a19_f8; // gain ceiling = 15.5x
		SET_OV5640 +  33 :   	LUT_DATA	= 	24'h3635_13;
		SET_OV5640 +  34 :   	LUT_DATA	= 	24'h3636_03;
		SET_OV5640 +  35 :   	LUT_DATA	= 	24'h3634_40;
		SET_OV5640 +  36 :   	LUT_DATA	= 	24'h3622_01;
		// 50/60Hz detection 50/60Hz 灯光条纹过滤
		SET_OV5640 +  37 :   	LUT_DATA	= 	24'h3c01_34; // Band auto, bit[7]
		SET_OV5640 +  38 :   	LUT_DATA	= 	24'h3c04_28; // threshold low sum
		SET_OV5640 +  39 :   	LUT_DATA	= 	24'h3c05_98; // threshold high sum
		SET_OV5640 +  40 :   	LUT_DATA	= 	24'h3c06_00; // light meter 1 threshold[15:8]
		SET_OV5640 +  41 :   	LUT_DATA	= 	24'h3c07_08; // light meter 1 threshold[7:0]
		SET_OV5640 +  42 :   	LUT_DATA	= 	24'h3c08_00; // light meter 2 threshold[15:8]
		SET_OV5640 +  43 :   	LUT_DATA	= 	24'h3c09_1c; // light meter 2 threshold[7:0]
		SET_OV5640 +  44 :   	LUT_DATA	= 	24'h3c0a_9c; // sample number[15:8]
		SET_OV5640 +  45 :   	LUT_DATA	= 	24'h3c0b_40; // sample number[7:0]
		SET_OV5640 +  46 :   	LUT_DATA	= 	24'h3810_00; // Timing Hoffset[11:8]
		SET_OV5640 +  47 :   	LUT_DATA	= 	24'h3811_10; // Timing Hoffset[7:0]
		SET_OV5640 +  48 :   	LUT_DATA	= 	24'h3812_00; // Timing Voffset[10:8]
		SET_OV5640 +  49 :   	LUT_DATA	= 	24'h3708_64;
		SET_OV5640 +  50 :   	LUT_DATA	= 	24'h4001_02; // BLC start from line 2
		SET_OV5640 +  51 :   	LUT_DATA	= 	24'h4005_1a; // BLC always update
		SET_OV5640 +  52 :   	LUT_DATA	= 	24'h3000_00; // enable blocks
		SET_OV5640 +  53 :   	LUT_DATA	= 	24'h3004_ff; // enable clocks
		SET_OV5640 +  54 :   	LUT_DATA	= 	24'h300e_58; // MIPI power down, DVP enable
		SET_OV5640 +  55 :   	LUT_DATA	= 	24'h302e_00;
		SET_OV5640 +  56 :   	LUT_DATA	= 	24'h4300_61; // RGB565
		SET_OV5640 +  57 :   	LUT_DATA	= 	24'h501f_01; // RGB565
		SET_OV5640 +  58 :   	LUT_DATA	= 	24'h440e_00;
		SET_OV5640 +  59 :   	LUT_DATA	= 	24'h5000_a7; // Lenc on, raw gamma on, BPC on, WPC on, CIP on
		// AEC target 自动曝光控制
		SET_OV5640 +  60 :   	LUT_DATA	= 	24'h3a0f_30; // stable range in high
		SET_OV5640 +  61 :   	LUT_DATA	= 	24'h3a10_28; // stable range in low
		SET_OV5640 +  62 :   	LUT_DATA	= 	24'h3a1b_30; // stable range out high
		SET_OV5640 +  63 :   	LUT_DATA	= 	24'h3a1e_26; // stable range out low
		SET_OV5640 +  64 :   	LUT_DATA	= 	24'h3a11_60; // fast zone high
		SET_OV5640 +  65 :   	LUT_DATA	= 	24'h3a1f_14; // fast zone low
		// Lens correction for ? 镜头补偿
		SET_OV5640 +  66 :   	LUT_DATA	= 	24'h5800_23;
		SET_OV5640 +  67 :   	LUT_DATA	= 	24'h5801_14;
		SET_OV5640 +  68 :   	LUT_DATA	= 	24'h5802_0f;
		SET_OV5640 +  69 :   	LUT_DATA	= 	24'h5803_0f;
		SET_OV5640 +  70 :   	LUT_DATA	= 	24'h5804_12;
		SET_OV5640 +  71 :   	LUT_DATA	= 	24'h5805_26;
		SET_OV5640 +  72 :   	LUT_DATA	= 	24'h5806_0c;
		SET_OV5640 +  73 :   	LUT_DATA	= 	24'h5807_08;
		SET_OV5640 +  74 :   	LUT_DATA	= 	24'h5808_05;
		SET_OV5640 +  75 :   	LUT_DATA	= 	24'h5809_05;
		SET_OV5640 +  76 :   	LUT_DATA	= 	24'h580a_08;
		SET_OV5640 +  77 :   	LUT_DATA	= 	24'h580b_0d;
		SET_OV5640 +  78 :   	LUT_DATA	= 	24'h580c_08;
		SET_OV5640 +  79 :   	LUT_DATA	= 	24'h580d_03;
		SET_OV5640 +  80 :   	LUT_DATA	= 	24'h580e_00;
		SET_OV5640 +  81 :   	LUT_DATA	= 	24'h580f_00;
		SET_OV5640 +  82 :   	LUT_DATA	= 	24'h5810_03;
		SET_OV5640 +  83 :   	LUT_DATA	= 	24'h5811_09;
		SET_OV5640 +  84 :   	LUT_DATA	= 	24'h5812_07;
		SET_OV5640 +  85 :   	LUT_DATA	= 	24'h5813_03;
		SET_OV5640 +  86 :   	LUT_DATA	= 	24'h5814_00;
		SET_OV5640 +  87 :   	LUT_DATA	= 	24'h5815_01;
		SET_OV5640 +  88 :   	LUT_DATA	= 	24'h5816_03;
		SET_OV5640 +  89 :   	LUT_DATA	= 	24'h5817_08;
		SET_OV5640 +  90 :   	LUT_DATA	= 	24'h5818_0d;
		SET_OV5640 +  91 :   	LUT_DATA	= 	24'h5819_08;
		SET_OV5640 +  92 :   	LUT_DATA	= 	24'h581a_05;
		SET_OV5640 +  93 :   	LUT_DATA	= 	24'h581b_06;
		SET_OV5640 +  94 :   	LUT_DATA	= 	24'h581c_08;
		SET_OV5640 +  95 :   	LUT_DATA	= 	24'h581d_0e;
		SET_OV5640 +  96 :   	LUT_DATA	= 	24'h581e_29;
		SET_OV5640 +  97 :   	LUT_DATA	= 	24'h581f_17;
		SET_OV5640 +  98 :   	LUT_DATA	= 	24'h5820_11;
		SET_OV5640 +  99 :   	LUT_DATA	= 	24'h5821_11;
		SET_OV5640 +  100:   	LUT_DATA	= 	24'h5822_15;
		SET_OV5640 +  101:   	LUT_DATA	= 	24'h5823_28;
		SET_OV5640 +  102:   	LUT_DATA	= 	24'h5824_46;
		SET_OV5640 +  103:   	LUT_DATA	= 	24'h5825_26;
		SET_OV5640 +  104:   	LUT_DATA	= 	24'h5826_08;
		SET_OV5640 +  105:   	LUT_DATA	= 	24'h5827_26;
		SET_OV5640 +  106:   	LUT_DATA	= 	24'h5828_64;
		SET_OV5640 +  107:   	LUT_DATA	= 	24'h5829_26;
		SET_OV5640 +  108:   	LUT_DATA	= 	24'h582a_24;
		SET_OV5640 +  109:   	LUT_DATA	= 	24'h582b_22;
		SET_OV5640 +  110:   	LUT_DATA	= 	24'h582c_24;
		SET_OV5640 +  111:   	LUT_DATA	= 	24'h582d_24;
		SET_OV5640 +  112:   	LUT_DATA	= 	24'h582e_06;
		SET_OV5640 +  113:   	LUT_DATA	= 	24'h582f_22;
		SET_OV5640 +  114:   	LUT_DATA	= 	24'h5830_40;
		SET_OV5640 +  115:   	LUT_DATA	= 	24'h5831_42;
		SET_OV5640 +  116:   	LUT_DATA	= 	24'h5832_24;
		SET_OV5640 +  117:   	LUT_DATA	= 	24'h5833_26;
		SET_OV5640 +  118:   	LUT_DATA	= 	24'h5834_24;
		SET_OV5640 +  119:   	LUT_DATA	= 	24'h5835_22;
		SET_OV5640 +  120:   	LUT_DATA	= 	24'h5836_22;
		SET_OV5640 +  121:   	LUT_DATA	= 	24'h5837_26;
		SET_OV5640 +  122:   	LUT_DATA	= 	24'h5838_44;
		SET_OV5640 +  123:   	LUT_DATA	= 	24'h5839_24;
		SET_OV5640 +  124:   	LUT_DATA	= 	24'h583a_26;
		SET_OV5640 +  125:   	LUT_DATA	= 	24'h583b_28;
		SET_OV5640 +  126:   	LUT_DATA	= 	24'h583c_42;
		SET_OV5640 +  127:   	LUT_DATA	= 	24'h583d_ce; // lenc BR offset
		// AWB 自动白平衡
		SET_OV5640 +  128:   	LUT_DATA	= 	24'h5180_ff; // AWB B block
		SET_OV5640 +  129:   	LUT_DATA	= 	24'h5181_f2; // AWB control
		SET_OV5640 +  130:   	LUT_DATA	= 	24'h5182_00; // [7:4] max local counter, [3:0] max fast counter
		SET_OV5640 +  131:   	LUT_DATA	= 	24'h5183_14; // AWB advanced
		SET_OV5640 +  132:   	LUT_DATA	= 	24'h5184_25;
		SET_OV5640 +  133:   	LUT_DATA	= 	24'h5185_24;
		SET_OV5640 +  134:   	LUT_DATA	= 	24'h5186_09;
		SET_OV5640 +  135:   	LUT_DATA	= 	24'h5187_09;
		SET_OV5640 +  136:   	LUT_DATA	= 	24'h5188_09;
		SET_OV5640 +  137:   	LUT_DATA	= 	24'h5189_75;
		SET_OV5640 +  138:   	LUT_DATA	= 	24'h518a_54;
		SET_OV5640 +  139:   	LUT_DATA	= 	24'h518b_e0;
		SET_OV5640 +  140:   	LUT_DATA	= 	24'h518c_b2;
		SET_OV5640 +  141:   	LUT_DATA	= 	24'h518d_42;
		SET_OV5640 +  142:   	LUT_DATA	= 	24'h518e_3d;
		SET_OV5640 +  143:   	LUT_DATA	= 	24'h518f_56;
		SET_OV5640 +  144:   	LUT_DATA	= 	24'h5190_46;
		SET_OV5640 +  145:   	LUT_DATA	= 	24'h5191_f8; // AWB top limit
		SET_OV5640 +  146:   	LUT_DATA	= 	24'h5192_04; // AWB bottom limit
		SET_OV5640 +  147:   	LUT_DATA	= 	24'h5193_70; // red limit
		SET_OV5640 +  148:   	LUT_DATA	= 	24'h5194_f0; // green limit
		SET_OV5640 +  149:   	LUT_DATA	= 	24'h5195_f0; // blue limit
		SET_OV5640 +  150:   	LUT_DATA	= 	24'h5196_03; // AWB control
		SET_OV5640 +  151:   	LUT_DATA	= 	24'h5197_01; // local limit
		SET_OV5640 +  152:   	LUT_DATA	= 	24'h5198_04;
		SET_OV5640 +  153:   	LUT_DATA	= 	24'h5199_12;
		SET_OV5640 +  154:   	LUT_DATA	= 	24'h519a_04;
		SET_OV5640 +  155:   	LUT_DATA	= 	24'h519b_00;
		SET_OV5640 +  156:   	LUT_DATA	= 	24'h519c_06;
		SET_OV5640 +  157:   	LUT_DATA	= 	24'h519d_82;
		SET_OV5640 +  158:   	LUT_DATA	= 	24'h519e_38; // AWB control
		// Gamma 伽玛曲线
		SET_OV5640 +  159:   	LUT_DATA	= 	24'h5480_01; // Gamma bias plus on, bit[0]
		SET_OV5640 +  160:   	LUT_DATA	= 	24'h5481_08;
		SET_OV5640 +  161:   	LUT_DATA	= 	24'h5482_14;
		SET_OV5640 +  162:   	LUT_DATA	= 	24'h5483_28;
		SET_OV5640 +  163:   	LUT_DATA	= 	24'h5484_51;
		SET_OV5640 +  164:   	LUT_DATA	= 	24'h5485_65;
		SET_OV5640 +  165:   	LUT_DATA	= 	24'h5486_71;
		SET_OV5640 +  166:   	LUT_DATA	= 	24'h5487_7d;
		SET_OV5640 +  167:   	LUT_DATA	= 	24'h5488_87;
		SET_OV5640 +  168:   	LUT_DATA	= 	24'h5489_91;
		SET_OV5640 +  169:   	LUT_DATA	= 	24'h548a_9a;
		SET_OV5640 +  170:   	LUT_DATA	= 	24'h548b_aa;
		SET_OV5640 +  171:   	LUT_DATA	= 	24'h548c_b8;
		SET_OV5640 +  172:   	LUT_DATA	= 	24'h548d_cd;
		SET_OV5640 +  173:   	LUT_DATA	= 	24'h548e_dd;
		SET_OV5640 +  174:   	LUT_DATA	= 	24'h548f_ea;
		SET_OV5640 +  175:   	LUT_DATA	= 	24'h5490_1d;
		// color matrix 色彩矩阵
		SET_OV5640 +  176:   	LUT_DATA	= 	24'h5381_1e; // CMX1 for Y
		SET_OV5640 +  177:   	LUT_DATA	= 	24'h5382_5b; // CMX2 for Y
		SET_OV5640 +  178:   	LUT_DATA	= 	24'h5383_08; // CMX3 for Y
		SET_OV5640 +  179:   	LUT_DATA	= 	24'h5384_0a; // CMX4 for U
		SET_OV5640 +  180:   	LUT_DATA	= 	24'h5385_7e; // CMX5 for U
		SET_OV5640 +  181:   	LUT_DATA	= 	24'h5386_88; // CMX6 for U
		SET_OV5640 +  182:   	LUT_DATA	= 	24'h5387_7c; // CMX7 for V
		SET_OV5640 +  183:   	LUT_DATA	= 	24'h5388_6c; // CMX8 for V
		SET_OV5640 +  184:   	LUT_DATA	= 	24'h5389_10; // CMX9 for V
		SET_OV5640 +  185:   	LUT_DATA	= 	24'h538a_01; // sign[9]
		SET_OV5640 +  186:   	LUT_DATA	= 	24'h538b_98; // sign[8:1]
		// UV adjust UV 色彩饱和度调整
		SET_OV5640 +  187:   	LUT_DATA	= 	24'h5580_06; // saturation on, bit[1]
		SET_OV5640 +  188:   	LUT_DATA	= 	24'h5583_40;
		SET_OV5640 +  189:   	LUT_DATA	= 	24'h5584_10;
		SET_OV5640 +  190:   	LUT_DATA	= 	24'h5589_10;
		SET_OV5640 +  191:   	LUT_DATA	= 	24'h558a_00;
		SET_OV5640 +  192:   	LUT_DATA	= 	24'h558b_f8;
		SET_OV5640 +  193:   	LUT_DATA	= 	24'h501d_40; // enable manual offset of contrast
		// CIP 锐化和降噪
		SET_OV5640 +  194:   	LUT_DATA	= 	24'h5300_08; // CIP sharpen MT threshold 1
		SET_OV5640 +  195:   	LUT_DATA	= 	24'h5301_30; // CIP sharpen MT threshold 2
		SET_OV5640 +  196:   	LUT_DATA	= 	24'h5302_10; // CIP sharpen MT offset 1
		SET_OV5640 +  197:   	LUT_DATA	= 	24'h5303_00; // CIP sharpen MT offset 2
		SET_OV5640 +  198:   	LUT_DATA	= 	24'h5304_08; // CIP DNS threshold 1
		SET_OV5640 +  199:   	LUT_DATA	= 	24'h5305_30; // CIP DNS threshold 2
		SET_OV5640 +  200:   	LUT_DATA	= 	24'h5306_08; // CIP DNS offset 1
		SET_OV5640 +  201:   	LUT_DATA	= 	24'h5307_16; // CIP DNS offset 2
		SET_OV5640 +  202:   	LUT_DATA	= 	24'h5309_08; // CIP sharpen TH threshold 1
		SET_OV5640 +  203:   	LUT_DATA	= 	24'h530a_30; // CIP sharpen TH threshold 2
		SET_OV5640 +  204:   	LUT_DATA	= 	24'h530b_04; // CIP sharpen TH offset 1
		SET_OV5640 +  205:   	LUT_DATA	= 	24'h530c_06; // CIP sharpen TH offset 2
		SET_OV5640 +  206:   	LUT_DATA	= 	24'h5025_00;
		SET_OV5640 +  207:   	LUT_DATA	= 	24'h3008_02; // wake up from standby, bit[6]
                    

		// 12824'h720, 30fps
		// input clock 24Mhz, PCLK 42Mhz
		SET_OV5640 +  208:   	LUT_DATA	= 	24'h3035_21; // PLL	21:30fps  41:15fps	81:7.5fps
		SET_OV5640 +  209:   	LUT_DATA	= 	24'h3036_69; // PLL
		SET_OV5640 +  210:   	LUT_DATA	= 	24'h3c07_07; // lightmeter 1 threshold[7:0]
		SET_OV5640 +  211:   	LUT_DATA	= 	24'h3820_47; // flip
		SET_OV5640 +  212:   	LUT_DATA	= 	24'h3821_01; // no mirror
		SET_OV5640 +  213:   	LUT_DATA	= 	24'h3814_31; // timing X inc
		SET_OV5640 +  214:   	LUT_DATA	= 	24'h3815_31; // timing Y inc
		SET_OV5640 +  215:   	LUT_DATA	= 	24'h3800_00; // HS
		SET_OV5640 +  216:   	LUT_DATA	= 	24'h3801_00; // HS
		SET_OV5640 +  217:   	LUT_DATA	= 	24'h3802_00; // VS
		SET_OV5640 +  218:   	LUT_DATA	= 	24'h3803_fa; // VS
		SET_OV5640 +  219:   	LUT_DATA	= 	24'h3804_0a; // HW SET_OV5640 +  :   	LUT_DATA	= 	HE}
		SET_OV5640 +  220:   	LUT_DATA	= 	24'h3805_3f; // HW SET_OV5640 +  :   	LUT_DATA	= 	HE}
		SET_OV5640 +  221:   	LUT_DATA	= 	24'h3806_06; // VH SET_OV5640 +  :   	LUT_DATA	= 	VE}
		SET_OV5640 +  222:   	LUT_DATA	= 	24'h3807_a9; // VH SET_OV5640 +  :   	LUT_DATA	= 	VE}
		SET_OV5640 +  223:   	LUT_DATA	= 	24'h3808_03; // DVPHO	800
		SET_OV5640 +  224:   	LUT_DATA	= 	24'h3809_20; // DVPHO
		SET_OV5640 +  225:   	LUT_DATA	= 	24'h380a_01; // DVPVO	480
		SET_OV5640 +  226:   	LUT_DATA	= 	24'h380b_e0; // DVPVO
		SET_OV5640 +  227:   	LUT_DATA	= 	24'h380c_07; // HTS
		SET_OV5640 +  228:   	LUT_DATA	= 	24'h380d_64; // HTS
		SET_OV5640 +  229:   	LUT_DATA	= 	24'h380e_02; // VTS
		SET_OV5640 +  230:   	LUT_DATA	= 	24'h380f_e4; // VTS
		SET_OV5640 +  231:   	LUT_DATA	= 	24'h3813_04; // timing V offset
		SET_OV5640 +  232:   	LUT_DATA	= 	24'h3618_00;
		SET_OV5640 +  233:   	LUT_DATA	= 	24'h3612_29;
		SET_OV5640 +  234:   	LUT_DATA	= 	24'h3709_52;
		SET_OV5640 +  235:   	LUT_DATA	= 	24'h370c_03;
		SET_OV5640 +  236:   	LUT_DATA	= 	24'h3a02_02; // 60Hz max exposure
		SET_OV5640 +  237:   	LUT_DATA	= 	24'h3a03_e0; // 60Hz max exposure
		SET_OV5640 +  238:   	LUT_DATA	= 	24'h3a14_02; // 50Hz max exposure
		SET_OV5640 +  239:   	LUT_DATA	= 	24'h3a15_e0; // 50Hz max exposure
		SET_OV5640 +  240:   	LUT_DATA	= 	24'h4004_02; // BLC line number
		SET_OV5640 +  241:   	LUT_DATA	= 	24'h3002_1c; // reset JFIFO, SFIFO, JPG
		SET_OV5640 +  242:   	LUT_DATA	= 	24'h3006_c3; // disable clock of JPEG2x, JPEG
		SET_OV5640 +  243:   	LUT_DATA	= 	24'h4713_03; // JPEG mode 3
		SET_OV5640 +  244:   	LUT_DATA	= 	24'h4407_04; // Quantization scale
		SET_OV5640 +  245:   	LUT_DATA	= 	24'h460b_37;
		SET_OV5640 +  246:   	LUT_DATA	= 	24'h460c_20;
		SET_OV5640 +  247:   	LUT_DATA	= 	24'h4837_16; // MIPI global timing
		SET_OV5640 +  248:   	LUT_DATA	= 	24'h3824_04; // PCLK manual divider
		SET_OV5640 +  249:   	LUT_DATA	= 	24'h5001_83; // SDE on, CMX on, AWB on
		SET_OV5640 +  250:   	LUT_DATA	= 	24'h3503_00; // AEC/AGC on
                   
		SET_OV5640 +  251:   	LUT_DATA	= 	24'h4740_01; // VS 1
		
//		SET_OV5640 +  252:   	LUT_DATA	= 	24'h503d80; // color bar
//		SET_OV5640 +  253:   	LUT_DATA	= 	24'h474100; //
 
		default			:	LUT_DATA	=	0;
	endcase
end
endmodule
