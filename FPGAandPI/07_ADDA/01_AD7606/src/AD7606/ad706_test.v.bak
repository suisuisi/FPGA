`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    ad706_test 
//////////////////////////////////////////////////////////////////////////////////
module ad706_test(
   input        clk,                  //50mhz
	input        rst_n,
	
	input [15:0] ad_data,            //ad7606 采样数据
	input        ad_busy,            //ad7606 忙标志位 
   input        first_data,         //ad7606 第一个数据标志位 	    
	output [2:0] ad_os,              //ad7606 过采样倍率选择
	output       ad_cs,              //ad7606 AD cs
	output       ad_rd,              //ad7606 AD data read
	output       ad_reset,           //ad7606 AD reset
	output       ad_convstab,         //ad7606 AD convert start
	
	input        rx,
	output       tx
		

    );


wire [15:0] ad_ch1;
wire [15:0] ad_ch2;
wire [15:0] ad_ch3;
wire [15:0] ad_ch4;
wire [15:0] ad_ch5;
wire [15:0] ad_ch6;
wire [15:0] ad_ch7;
wire [15:0] ad_ch8;

wire [19:0] ch1_dec;
wire [19:0] ch2_dec;
wire [19:0] ch3_dec;
wire [19:0] ch4_dec;
wire [19:0] ch5_dec;
wire [19:0] ch6_dec;
wire [19:0] ch7_dec;
wire [19:0] ch8_dec;

wire [7:0] ch1_sig;
wire [7:0] ch2_sig;
wire [7:0] ch3_sig;
wire [7:0] ch4_sig;
wire [7:0] ch5_sig;
wire [7:0] ch6_sig;
wire [7:0] ch7_sig;
wire [7:0] ch8_sig;


ad7606 u1(
	.clk              (clk),
	.rst_n            (rst_n),
	.ad_data          (ad_data),
	.ad_busy          (ad_busy),	
	.first_data       (first_data),	
	.ad_os            (ad_os),	
	.ad_cs            (ad_cs),
	.ad_rd            (ad_rd),	
	.ad_reset         (ad_reset),
	.ad_convstab      (ad_convstab),
	.ad_ch1           (ad_ch1),           //ch1 ad data 16bit
	.ad_ch2           (ad_ch2),           //ch2 ad data 16bit
	.ad_ch3           (ad_ch3),           //ch3 ad data 16bit
	.ad_ch4           (ad_ch4),           //ch4 ad data 16bit
	.ad_ch5           (ad_ch5),           //ch5 ad data 16bit
	.ad_ch6           (ad_ch6),           //ch6 ad data 16bit
	.ad_ch7           (ad_ch7),           //ch7 ad data 16bit
	.ad_ch8           (ad_ch8)            //ch8 ad data 16bit

	
    );

/**********电压转换程序***********/
volt_cal u2(
	.clk              (clk),
	.ad_reset         (ad_reset),
	.ad_ch1           (ad_ch1),           //ch1 ad data 16bit (input)
	.ad_ch2           (ad_ch2),           //ch2 ad data 16bit (input)
	.ad_ch3           (ad_ch3),           //ch3 ad data 16bit (input)
	.ad_ch4           (ad_ch4),           //ch4 ad data 16bit (input)
	.ad_ch5           (ad_ch5),           //ch5 ad data 16bit (input)
	.ad_ch6           (ad_ch6),           //ch6 ad data 16bit (input)
	.ad_ch7           (ad_ch7),           //ch7 ad data 16bit (input)
	.ad_ch8           (ad_ch8),           //ch8 ad data 16bit (input)
	
	.ch1_dec           (ch1_dec),         //ch1 ad voltage (output)
	.ch2_dec           (ch2_dec),         //ch2 ad voltage (output)
	.ch3_dec           (ch3_dec),         //ch3 ad voltage (output)
	.ch4_dec           (ch4_dec),         //ch4 ad voltage (output)
	.ch5_dec           (ch5_dec),         //ch5 ad voltage (output)
	.ch6_dec           (ch6_dec),         //ch6 ad voltage (output)
	.ch7_dec           (ch7_dec),         //ch7 ad voltage (output)
	.ch8_dec           (ch8_dec),         //ch8 ad voltage (output)
	
   .ch1_sig           (ch1_sig),         //ch1 ad 正负 (output)
	.ch2_sig           (ch2_sig),         //ch2 ad 正负 (output)
	.ch3_sig           (ch3_sig),         //ch3 ad 正负 (output)
	.ch4_sig           (ch4_sig),         //ch4 ad 正负 (output)
	.ch5_sig           (ch5_sig),         //ch5 ad 正负 (output)
	.ch6_sig           (ch6_sig),         //ch6 ad 正负 (output)
	.ch7_sig           (ch7_sig),         //ch7 ad 正负 (output)
	.ch8_sig           (ch8_sig)          //ch8 ad 正负 (output)
	
    );

/**********AD数据Uart串口发送程序***********/
uart u3(
		.clk50           		    (clk),	
		.reset_n           		 (rst_n),	

		.ch1_dec                 (ch1_dec),         //ad1 BCD voltage
		.ch2_dec                 (ch2_dec),         //ad2 BCD voltage
		.ch3_dec                 (ch3_dec),         //ad3 BCD voltage
		.ch4_dec                 (ch4_dec),         //ad4 BCD voltage
		.ch5_dec                 (ch5_dec),         //ad5 BCD voltage
		.ch6_dec                 (ch6_dec),         //ad6 BCD voltage
		.ch7_dec                 (ch7_dec),         //ad7 BCD voltage
		.ch8_dec                 (ch8_dec),         //ad8 BCD voltage		
	
		.ch1_sig                 (ch1_sig),          //ch1 ad 正负
		.ch2_sig                 (ch2_sig),          //ch2 ad 正负
		.ch3_sig                 (ch3_sig),          //ch3 ad 正负
		.ch4_sig                 (ch4_sig),          //ch4 ad 正负
		.ch5_sig                 (ch5_sig),          //ch5 ad 正负
		.ch6_sig                 (ch6_sig),          //ch6 ad 正负
		.ch7_sig                 (ch7_sig),          //ch7 ad 正负
		.ch8_sig                 (ch8_sig),          //ch8 ad 正负		
		
		.tx                      (tx)
		
	
    );   



endmodule
