//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-05-19 20:55:44
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-07-13 01:36:17
//# Description: 
//# @Modification History: 2019-05-19 20:58:05
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2019-05-19 20:58:05
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module oled_ctrlmod
(
    input CLOCK, RST_n,	 
	 input iCall,
	 output oDone,
	 input [1023:0]iData1,
	 input [1023:0]iData2,
	 input [1023:0]iData3,
	 input [1023:0]iData4,
	 output [1:0]oCall,
	 input iDone,
	 output [7:0]oAddr, oData
);	 

parameter     WR_CMD   = 8'b0000_0000;        //写命令控制字write_command
parameter     DATA_CMD = 8'b0100_0000;      //写数据控制字write_data
//parameter    psub_address2=8'b0000_0011;       //PCF8563 的分寄存器的地址
//parameter    psub_address3=8'b0000_0100;       //PCF8563 的时寄存器的地址
parameter    page_1st  = 8'hb0;//第一page地址
parameter    page_2nd  = 8'hb1;//第二page地址
parameter    page_3rd  = 8'hb2;//第三page地址
parameter    page_4th  = 8'hb3;//第四page地址

parameter    TIME_100ms = 16'd50_000;//(100E-3)/(1/50E+6)

reg [7:0]isData1[127:0];
reg [7:0]isData2[127:0];
reg [7:0]isData3[127:0];
reg [7:0]isData4[127:0];

/*reg [1023:0]isData1;
reg [1023:0]isData2;
reg [1023:0]isData3;
reg [1023:0]isData4;*/

	  always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		      begin
		//				isData1 <= 0;
	//				isData2 <= 0;
	//				isData3 <= 0;
	//				isData4 <= 0;
				end
		else if( iCall )
			begin 
					isData1[ 0 ]   <= iData1   [ 7  :    0 ];
					isData1[ 1 ]   <= iData1   [ 15 :    8 ];
					isData1[ 2 ]   <= iData1   [ 23 :    16 ];
					isData1[ 3 ]   <= iData1   [ 31 :    24 ];
					isData1[ 4 ]   <= iData1   [ 39 :    32 ];
					isData1[ 5 ]   <= iData1   [ 47 :    40 ];
					isData1[ 6 ]   <= iData1   [ 55 :    48 ];
					isData1[ 7 ]   <= iData1   [ 63 :    56 ];
					isData1[ 8 ]   <= iData1   [ 71 :    64 ];
					isData1[ 9 ]   <= iData1   [ 79 :    72 ];
					isData1[ 10 ]  <= iData1  [ 87 :    80 ];
					isData1[ 11 ]  <= iData1  [ 95 :    88 ];
					isData1[ 12 ]  <= iData1  [ 103  :  96 ];
					isData1[ 13 ]  <= iData1  [ 111  :  104 ];					
					isData1[ 14 ]  <= iData1  [ 119  :  112 ];
					isData1[ 15 ]  <= iData1  [ 127  :  120 ];
					isData1[ 16 ]  <= iData1  [ 135  :  128 ];
					isData1[ 17 ]  <= iData1  [ 143  :  136 ];
					isData1[ 18 ]  <= iData1  [ 151  :  144 ];
					isData1[ 19 ]  <= iData1  [ 159  :  152 ];
					isData1[ 20 ]  <= iData1  [ 167  :  160 ];
					isData1[ 21 ]  <= iData1  [ 175  :  168 ];
					isData1[ 22 ]  <= iData1  [ 183  :  176 ];
					isData1[ 23 ]  <= iData1  [ 191  :  184 ];
					isData1[ 24 ]  <= iData1  [ 199  :  192 ];
					isData1[ 25 ]  <= iData1  [ 207  :  200 ];
					isData1[ 26 ]  <= iData1  [ 215  :  208 ];
					isData1[ 27 ]  <= iData1  [ 223  :  216 ];
					isData1[ 28 ]  <= iData1  [ 231  :  224 ];
					isData1[ 29 ]  <= iData1  [ 239  :  232 ];
					isData1[ 30 ]  <= iData1  [ 247  :  240 ];
					isData1[ 31 ]  <= iData1  [ 255  :  248 ];
					isData1[ 32 ]  <= iData1  [ 263  :  256 ];
					isData1[ 33 ]  <= iData1  [ 271  :  264 ];
					isData1[ 34 ]  <= iData1  [ 279  :  272 ];
					isData1[ 35 ]  <= iData1  [ 287  :  280 ];
					isData1[ 36 ]  <= iData1  [ 295  :  288 ];
					isData1[ 37 ]  <= iData1  [ 303  :  296 ];
					isData1[ 38 ]  <= iData1  [ 311  :  304 ];
					isData1[ 39 ]  <= iData1  [ 319  :  312 ];
					isData1[ 40 ]  <= iData1  [ 327  :  320 ];
					isData1[ 41 ]  <= iData1  [ 335  :  328 ];
					isData1[ 42 ]  <= iData1  [ 343  :  336 ];
					isData1[ 43 ]  <= iData1  [ 351  :  344 ];
					isData1[ 44 ]  <= iData1  [ 359  :  352 ];
					isData1[ 45 ]  <= iData1  [ 367  :  360 ];
					isData1[ 46 ]  <= iData1  [ 375  :  368 ];
					isData1[ 47 ]  <= iData1  [ 383  :  376 ];
					isData1[ 48 ]  <= iData1  [ 391  :  384 ];
					isData1[ 49 ]  <= iData1  [ 399  :  392 ];
					isData1[ 50 ]  <= iData1  [ 407  :  400 ];
					isData1[ 51 ]  <= iData1  [ 415  :  408 ];
					isData1[ 52 ]  <= iData1  [ 423  :  416 ];
					isData1[ 53 ]  <= iData1  [ 431  :  424 ];
					isData1[ 54 ]  <= iData1  [ 439  :  432 ];
					isData1[ 55 ]  <= iData1  [ 447  :  440 ];
					isData1[ 56 ]  <= iData1  [ 455  :  448 ];
					isData1[ 57 ]  <= iData1  [ 463  :  456 ];
					isData1[ 58 ]  <= iData1  [ 471  :  464 ];
					isData1[ 59 ]  <= iData1  [ 479  :  472 ];
					isData1[ 60 ]  <= iData1  [ 487  :  480 ];
					isData1[ 61 ]  <= iData1  [ 495  :  488 ];
					isData1[ 62 ]  <= iData1  [ 503  :  496 ];
					isData1[ 63 ]  <= iData1  [ 511  :  504 ];
					isData1[ 64 ]  <= iData1  [ 519  :  512 ];
					isData1[ 65 ]  <= iData1  [ 527  :  520 ];
					isData1[ 66 ]  <= iData1  [ 535  :  528 ];
					isData1[ 67 ]  <= iData1  [ 543  :  536 ];
					isData1[ 68 ]  <= iData1  [ 551  :  544 ];
					isData1[ 69 ]  <= iData1  [ 559  :  552 ];
					isData1[ 70 ]  <= iData1  [ 567  :  560 ];
					isData1[ 71 ]  <= iData1  [ 575  :  568 ];
					isData1[ 72 ]  <= iData1  [ 583  :  576 ];
					isData1[ 73 ]  <= iData1  [ 591  :  584 ];
					isData1[ 74 ]  <= iData1  [ 599  :  592 ];
					isData1[ 75 ]  <= iData1  [ 607  :  600 ];
					isData1[ 76 ]  <= iData1  [ 615  :  608 ];
					isData1[ 77 ]  <= iData1  [ 623  :  616 ];
					isData1[ 78 ]  <= iData1  [ 631  :  624 ];
					isData1[ 79 ]  <= iData1  [ 639  :  632 ];
					isData1[ 80 ]  <= iData1  [ 647  :  640 ];
					isData1[ 81 ]  <= iData1  [ 655  :  648 ];
					isData1[ 82 ]  <= iData1  [ 663  :  656 ];
					isData1[ 83 ]  <= iData1  [ 671  :  664 ];
					isData1[ 84 ]  <= iData1  [ 679  :  672 ];
					isData1[ 85 ]  <= iData1  [ 687  :  680 ];
					isData1[ 86 ]  <= iData1  [ 695  :  688 ];
					isData1[ 87 ]  <= iData1  [ 703  :  696 ];
					isData1[ 88 ]  <= iData1  [ 711  :  704 ];
					isData1[ 89 ]  <= iData1  [ 719  :  712 ];
					isData1[ 90 ]  <= iData1  [ 727  :  720 ];
					isData1[ 91 ]  <= iData1  [ 735  :  728 ];
					isData1[ 92 ]  <= iData1  [ 743  :  736 ];
					isData1[ 93 ]  <= iData1  [ 751  :  744 ];
					isData1[ 94 ]  <= iData1  [ 759  :  752 ];
					isData1[ 95 ]  <= iData1  [ 767  :  760 ];
					isData1[ 96 ]  <= iData1  [ 775  :  768 ];
					isData1[ 97 ]  <= iData1  [ 783  :  776 ];
					isData1[ 98 ]  <= iData1  [ 791  :  784 ];
					isData1[ 99 ]  <= iData1  [ 799  :  792 ];
					isData1[ 100 ] <= iData1  [ 807  :  800 ];
					isData1[ 101 ] <= iData1  [ 815  :  808 ];
					isData1[ 102 ] <= iData1  [ 823  :  816 ];
					isData1[ 103 ] <= iData1  [ 831  :  824 ];
					isData1[ 104 ] <= iData1  [ 839  :  832 ];
					isData1[ 105 ] <= iData1  [ 847  :  840 ];
					isData1[ 106 ] <= iData1  [ 855  :  848 ];
					isData1[ 107 ] <= iData1  [ 863  :  856 ];
					isData1[ 108 ] <= iData1  [ 871  :  864 ];
					isData1[ 109 ] <= iData1  [ 879  :  872 ];
					isData1[ 110 ] <= iData1  [ 887  :  880 ];
					isData1[ 111 ] <= iData1  [ 895  :  888 ];
					isData1[ 112 ] <= iData1  [ 903  :  896 ];
					isData1[ 113 ] <= iData1  [ 911  :  904 ];
					isData1[ 114 ] <= iData1  [ 919  :  912 ];
					isData1[ 115 ] <= iData1  [ 927  :  920 ];
					isData1[ 116 ] <= iData1  [ 935  :  928 ];
					isData1[ 117 ] <= iData1  [ 943  :  936 ];
					isData1[ 118 ] <= iData1  [ 951  :  944 ];
					isData1[ 119 ] <= iData1  [ 959  :  952 ];
					isData1[ 120 ] <= iData1  [ 967  :  960 ];
					isData1[ 121 ] <= iData1  [ 975  :  968 ];
					isData1[ 122 ] <= iData1  [ 983  :  976 ];
					isData1[ 123 ] <= iData1  [ 991  :  984 ];
					isData1[ 124 ] <= iData1  [ 999  :  992 ];
					isData1[ 125 ] <= iData1  [ 1007 :  1000 ];
					isData1[ 126 ] <= iData1  [ 1015 :  1008 ];
					isData1[ 127 ] <= iData1  [ 1023 :  1016 ];


					isData2[ 0 ]   <= iData2   [ 7  :    0 ];
					isData2[ 1 ]   <= iData2   [ 15 :    8 ];
					isData2[ 2 ]   <= iData2   [ 23 :    16 ];
					isData2[ 3 ]   <= iData2   [ 31 :    24 ];
					isData2[ 4 ]   <= iData2   [ 39 :    32 ];
					isData2[ 5 ]   <= iData2   [ 47 :    40 ];
					isData2[ 6 ]   <= iData2   [ 55 :    48 ];
					isData2[ 7 ]   <= iData2   [ 63 :    56 ];
					isData2[ 8 ]   <= iData2   [ 71 :    64 ];
					isData2[ 9 ]   <= iData2   [ 79 :    72 ];
					isData2[ 10 ]  <= iData2  [ 87 :    80 ];
					isData2[ 11 ]  <= iData2  [ 95 :    88 ];
					isData2[ 12 ]  <= iData2  [ 103  :  96 ];
					isData2[ 13 ]  <= iData2  [ 111  :  104 ];					
					isData2[ 14 ]  <= iData2  [ 119  :  112 ];
					isData2[ 15 ]  <= iData2  [ 127  :  120 ];
					isData2[ 16 ]  <= iData2  [ 135  :  128 ];
					isData2[ 17 ]  <= iData2  [ 143  :  136 ];
					isData2[ 18 ]  <= iData2  [ 151  :  144 ];
					isData2[ 19 ]  <= iData2  [ 159  :  152 ];
					isData2[ 20 ]  <= iData2  [ 167  :  160 ];
					isData2[ 21 ]  <= iData2  [ 175  :  168 ];
					isData2[ 22 ]  <= iData2  [ 183  :  176 ];
					isData2[ 23 ]  <= iData2  [ 191  :  184 ];
					isData2[ 24 ]  <= iData2  [ 199  :  192 ];
					isData2[ 25 ]  <= iData2  [ 207  :  200 ];
					isData2[ 26 ]  <= iData2  [ 215  :  208 ];
					isData2[ 27 ]  <= iData2  [ 223  :  216 ];
					isData2[ 28 ]  <= iData2  [ 231  :  224 ];
					isData2[ 29 ]  <= iData2  [ 239  :  232 ];
					isData2[ 30 ]  <= iData2  [ 247  :  240 ];
					isData2[ 31 ]  <= iData2  [ 255  :  248 ];
					isData2[ 32 ]  <= iData2  [ 263  :  256 ];
					isData2[ 33 ]  <= iData2  [ 271  :  264 ];
					isData2[ 34 ]  <= iData2  [ 279  :  272 ];
					isData2[ 35 ]  <= iData2  [ 287  :  280 ];
					isData2[ 36 ]  <= iData2  [ 295  :  288 ];
					isData2[ 37 ]  <= iData2  [ 303  :  296 ];
					isData2[ 38 ]  <= iData2  [ 311  :  304 ];
					isData2[ 39 ]  <= iData2  [ 319  :  312 ];
					isData2[ 40 ]  <= iData2  [ 327  :  320 ];
					isData2[ 41 ]  <= iData2  [ 335  :  328 ];
					isData2[ 42 ]  <= iData2  [ 343  :  336 ];
					isData2[ 43 ]  <= iData2  [ 351  :  344 ];
					isData2[ 44 ]  <= iData2  [ 359  :  352 ];
					isData2[ 45 ]  <= iData2  [ 367  :  360 ];
					isData2[ 46 ]  <= iData2  [ 375  :  368 ];
					isData2[ 47 ]  <= iData2  [ 383  :  376 ];
					isData2[ 48 ]  <= iData2  [ 391  :  384 ];
					isData2[ 49 ]  <= iData2  [ 399  :  392 ];
					isData2[ 50 ]  <= iData2  [ 407  :  400 ];
					isData2[ 51 ]  <= iData2  [ 415  :  408 ];
					isData2[ 52 ]  <= iData2  [ 423  :  416 ];
					isData2[ 53 ]  <= iData2  [ 431  :  424 ];
					isData2[ 54 ]  <= iData2  [ 439  :  432 ];
					isData2[ 55 ]  <= iData2  [ 447  :  440 ];
					isData2[ 56 ]  <= iData2  [ 455  :  448 ];
					isData2[ 57 ]  <= iData2  [ 463  :  456 ];
					isData2[ 58 ]  <= iData2  [ 471  :  464 ];
					isData2[ 59 ]  <= iData2  [ 479  :  472 ];
					isData2[ 60 ]  <= iData2  [ 487  :  480 ];
					isData2[ 61 ]  <= iData2  [ 495  :  488 ];
					isData2[ 62 ]  <= iData2  [ 503  :  496 ];
					isData2[ 63 ]  <= iData2  [ 511  :  504 ];
					isData2[ 64 ]  <= iData2  [ 519  :  512 ];
					isData2[ 65 ]  <= iData2  [ 527  :  520 ];
					isData2[ 66 ]  <= iData2  [ 535  :  528 ];
					isData2[ 67 ]  <= iData2  [ 543  :  536 ];
					isData2[ 68 ]  <= iData2  [ 551  :  544 ];
					isData2[ 69 ]  <= iData2  [ 559  :  552 ];
					isData2[ 70 ]  <= iData2  [ 567  :  560 ];
					isData2[ 71 ]  <= iData2  [ 575  :  568 ];
					isData2[ 72 ]  <= iData2  [ 583  :  576 ];
					isData2[ 73 ]  <= iData2  [ 591  :  584 ];
					isData2[ 74 ]  <= iData2  [ 599  :  592 ];
					isData2[ 75 ]  <= iData2  [ 607  :  600 ];
					isData2[ 76 ]  <= iData2  [ 615  :  608 ];
					isData2[ 77 ]  <= iData2  [ 623  :  616 ];
					isData2[ 78 ]  <= iData2  [ 631  :  624 ];
					isData2[ 79 ]  <= iData2  [ 639  :  632 ];
					isData2[ 80 ]  <= iData2  [ 647  :  640 ];
					isData2[ 81 ]  <= iData2  [ 655  :  648 ];
					isData2[ 82 ]  <= iData2  [ 663  :  656 ];
					isData2[ 83 ]  <= iData2  [ 671  :  664 ];
					isData2[ 84 ]  <= iData2  [ 679  :  672 ];
					isData2[ 85 ]  <= iData2  [ 687  :  680 ];
					isData2[ 86 ]  <= iData2  [ 695  :  688 ];
					isData2[ 87 ]  <= iData2  [ 703  :  696 ];
					isData2[ 88 ]  <= iData2  [ 711  :  704 ];
					isData2[ 89 ]  <= iData2  [ 719  :  712 ];
					isData2[ 90 ]  <= iData2  [ 727  :  720 ];
					isData2[ 91 ]  <= iData2  [ 735  :  728 ];
					isData2[ 92 ]  <= iData2  [ 743  :  736 ];
					isData2[ 93 ]  <= iData2  [ 751  :  744 ];
					isData2[ 94 ]  <= iData2  [ 759  :  752 ];
					isData2[ 95 ]  <= iData2  [ 767  :  760 ];
					isData2[ 96 ]  <= iData2  [ 775  :  768 ];
					isData2[ 97 ]  <= iData2  [ 783  :  776 ];
					isData2[ 98 ]  <= iData2  [ 791  :  784 ];
					isData2[ 99 ]  <= iData2  [ 799  :  792 ];
					isData2[ 100 ] <= iData2  [ 807  :  800 ];
					isData2[ 101 ] <= iData2  [ 815  :  808 ];
					isData2[ 102 ] <= iData2  [ 823  :  816 ];
					isData2[ 103 ] <= iData2  [ 831  :  824 ];
					isData2[ 104 ] <= iData2  [ 839  :  832 ];
					isData2[ 105 ] <= iData2  [ 847  :  840 ];
					isData2[ 106 ] <= iData2  [ 855  :  848 ];
					isData2[ 107 ] <= iData2  [ 863  :  856 ];
					isData2[ 108 ] <= iData2  [ 871  :  864 ];
					isData2[ 109 ] <= iData2  [ 879  :  872 ];
					isData2[ 110 ] <= iData2  [ 887  :  880 ];
					isData2[ 111 ] <= iData2  [ 895  :  888 ];
					isData2[ 112 ] <= iData2  [ 903  :  896 ];
					isData2[ 113 ] <= iData2  [ 911  :  904 ];
					isData2[ 114 ] <= iData2  [ 919  :  912 ];
					isData2[ 115 ] <= iData2  [ 927  :  920 ];
					isData2[ 116 ] <= iData2  [ 935  :  928 ];
					isData2[ 117 ] <= iData2  [ 943  :  936 ];
					isData2[ 118 ] <= iData2  [ 951  :  944 ];
					isData2[ 119 ] <= iData2  [ 959  :  952 ];
					isData2[ 120 ] <= iData2  [ 967  :  960 ];
					isData2[ 121 ] <= iData2  [ 975  :  968 ];
					isData2[ 122 ] <= iData2  [ 983  :  976 ];
					isData2[ 123 ] <= iData2  [ 991  :  984 ];
					isData2[ 124 ] <= iData2  [ 999  :  992 ];
					isData2[ 125 ] <= iData2  [ 1007 :  1000 ];
					isData2[ 126 ] <= iData2  [ 1015 :  1008 ];
					isData2[ 127 ] <= iData2  [ 1023 :  1016 ];

					isData3[ 0 ]   <= iData3   [ 7  :    0 ];
					isData3[ 1 ]   <= iData3   [ 15 :    8 ];
					isData3[ 2 ]   <= iData3   [ 23 :    16 ];
					isData3[ 3 ]   <= iData3   [ 31 :    24 ];
					isData3[ 4 ]   <= iData3   [ 39 :    32 ];
					isData3[ 5 ]   <= iData3   [ 47 :    40 ];
					isData3[ 6 ]   <= iData3   [ 55 :    48 ];
					isData3[ 7 ]   <= iData3   [ 63 :    56 ];
					isData3[ 8 ]   <= iData3   [ 71 :    64 ];
					isData3[ 9 ]   <= iData3   [ 79 :    72 ];
					isData3[ 10 ]  <= iData3  [ 87 :    80 ];
					isData3[ 11 ]  <= iData3  [ 95 :    88 ];
					isData3[ 12 ]  <= iData3  [ 103  :  96 ];
					isData3[ 13 ]  <= iData3  [ 111  :  104 ];					
					isData3[ 14 ]  <= iData3  [ 119  :  112 ];
					isData3[ 15 ]  <= iData3  [ 127  :  120 ];
					isData3[ 16 ]  <= iData3  [ 135  :  128 ];
					isData3[ 17 ]  <= iData3  [ 143  :  136 ];
					isData3[ 18 ]  <= iData3  [ 151  :  144 ];
					isData3[ 19 ]  <= iData3  [ 159  :  152 ];
					isData3[ 20 ]  <= iData3  [ 167  :  160 ];
					isData3[ 21 ]  <= iData3  [ 175  :  168 ];
					isData3[ 22 ]  <= iData3  [ 183  :  176 ];
					isData3[ 23 ]  <= iData3  [ 191  :  184 ];
					isData3[ 24 ]  <= iData3  [ 199  :  192 ];
					isData3[ 25 ]  <= iData3  [ 207  :  200 ];
					isData3[ 26 ]  <= iData3  [ 215  :  208 ];
					isData3[ 27 ]  <= iData3  [ 223  :  216 ];
					isData3[ 28 ]  <= iData3  [ 231  :  224 ];
					isData3[ 29 ]  <= iData3  [ 239  :  232 ];
					isData3[ 30 ]  <= iData3  [ 247  :  240 ];
					isData3[ 31 ]  <= iData3  [ 255  :  248 ];
					isData3[ 32 ]  <= iData3  [ 263  :  256 ];
					isData3[ 33 ]  <= iData3  [ 271  :  264 ];
					isData3[ 34 ]  <= iData3  [ 279  :  272 ];
					isData3[ 35 ]  <= iData3  [ 287  :  280 ];
					isData3[ 36 ]  <= iData3  [ 295  :  288 ];
					isData3[ 37 ]  <= iData3  [ 303  :  296 ];
					isData3[ 38 ]  <= iData3  [ 311  :  304 ];
					isData3[ 39 ]  <= iData3  [ 319  :  312 ];
					isData3[ 40 ]  <= iData3  [ 327  :  320 ];
					isData3[ 41 ]  <= iData3  [ 335  :  328 ];
					isData3[ 42 ]  <= iData3  [ 343  :  336 ];
					isData3[ 43 ]  <= iData3  [ 351  :  344 ];
					isData3[ 44 ]  <= iData3  [ 359  :  352 ];
					isData3[ 45 ]  <= iData3  [ 367  :  360 ];
					isData3[ 46 ]  <= iData3  [ 375  :  368 ];
					isData3[ 47 ]  <= iData3  [ 383  :  376 ];
					isData3[ 48 ]  <= iData3  [ 391  :  384 ];
					isData3[ 49 ]  <= iData3  [ 399  :  392 ];
					isData3[ 50 ]  <= iData3  [ 407  :  400 ];
					isData3[ 51 ]  <= iData3  [ 415  :  408 ];
					isData3[ 52 ]  <= iData3  [ 423  :  416 ];
					isData3[ 53 ]  <= iData3  [ 431  :  424 ];
					isData3[ 54 ]  <= iData3  [ 439  :  432 ];
					isData3[ 55 ]  <= iData3  [ 447  :  440 ];
					isData3[ 56 ]  <= iData3  [ 455  :  448 ];
					isData3[ 57 ]  <= iData3  [ 463  :  456 ];
					isData3[ 58 ]  <= iData3  [ 471  :  464 ];
					isData3[ 59 ]  <= iData3  [ 479  :  472 ];
					isData3[ 60 ]  <= iData3  [ 487  :  480 ];
					isData3[ 61 ]  <= iData3  [ 495  :  488 ];
					isData3[ 62 ]  <= iData3  [ 503  :  496 ];
					isData3[ 63 ]  <= iData3  [ 511  :  504 ];
					isData3[ 64 ]  <= iData3  [ 519  :  512 ];
					isData3[ 65 ]  <= iData3  [ 527  :  520 ];
					isData3[ 66 ]  <= iData3  [ 535  :  528 ];
					isData3[ 67 ]  <= iData3  [ 543  :  536 ];
					isData3[ 68 ]  <= iData3  [ 551  :  544 ];
					isData3[ 69 ]  <= iData3  [ 559  :  552 ];
					isData3[ 70 ]  <= iData3  [ 567  :  560 ];
					isData3[ 71 ]  <= iData3  [ 575  :  568 ];
					isData3[ 72 ]  <= iData3  [ 583  :  576 ];
					isData3[ 73 ]  <= iData3  [ 591  :  584 ];
					isData3[ 74 ]  <= iData3  [ 599  :  592 ];
					isData3[ 75 ]  <= iData3  [ 607  :  600 ];
					isData3[ 76 ]  <= iData3  [ 615  :  608 ];
					isData3[ 77 ]  <= iData3  [ 623  :  616 ];
					isData3[ 78 ]  <= iData3  [ 631  :  624 ];
					isData3[ 79 ]  <= iData3  [ 639  :  632 ];
					isData3[ 80 ]  <= iData3  [ 647  :  640 ];
					isData3[ 81 ]  <= iData3  [ 655  :  648 ];
					isData3[ 82 ]  <= iData3  [ 663  :  656 ];
					isData3[ 83 ]  <= iData3  [ 671  :  664 ];
					isData3[ 84 ]  <= iData3  [ 679  :  672 ];
					isData3[ 85 ]  <= iData3  [ 687  :  680 ];
					isData3[ 86 ]  <= iData3  [ 695  :  688 ];
					isData3[ 87 ]  <= iData3  [ 703  :  696 ];
					isData3[ 88 ]  <= iData3  [ 711  :  704 ];
					isData3[ 89 ]  <= iData3  [ 719  :  712 ];
					isData3[ 90 ]  <= iData3  [ 727  :  720 ];
					isData3[ 91 ]  <= iData3  [ 735  :  728 ];
					isData3[ 92 ]  <= iData3  [ 743  :  736 ];
					isData3[ 93 ]  <= iData3  [ 751  :  744 ];
					isData3[ 94 ]  <= iData3  [ 759  :  752 ];
					isData3[ 95 ]  <= iData3  [ 767  :  760 ];
					isData3[ 96 ]  <= iData3  [ 775  :  768 ];
					isData3[ 97 ]  <= iData3  [ 783  :  776 ];
					isData3[ 98 ]  <= iData3  [ 791  :  784 ];
					isData3[ 99 ]  <= iData3  [ 799  :  792 ];
					isData3[ 100 ] <= iData3  [ 807  :  800 ];
					isData3[ 101 ] <= iData3  [ 815  :  808 ];
					isData3[ 102 ] <= iData3  [ 823  :  816 ];
					isData3[ 103 ] <= iData3  [ 831  :  824 ];
					isData3[ 104 ] <= iData3  [ 839  :  832 ];
					isData3[ 105 ] <= iData3  [ 847  :  840 ];
					isData3[ 106 ] <= iData3  [ 855  :  848 ];
					isData3[ 107 ] <= iData3  [ 863  :  856 ];
					isData3[ 108 ] <= iData3  [ 871  :  864 ];
					isData3[ 109 ] <= iData3  [ 879  :  872 ];
					isData3[ 110 ] <= iData3  [ 887  :  880 ];
					isData3[ 111 ] <= iData3  [ 895  :  888 ];
					isData3[ 112 ] <= iData3  [ 903  :  896 ];
					isData3[ 113 ] <= iData3  [ 911  :  904 ];
					isData3[ 114 ] <= iData3  [ 919  :  912 ];
					isData3[ 115 ] <= iData3  [ 927  :  920 ];
					isData3[ 116 ] <= iData3  [ 935  :  928 ];
					isData3[ 117 ] <= iData3  [ 943  :  936 ];
					isData3[ 118 ] <= iData3  [ 951  :  944 ];
					isData3[ 119 ] <= iData3  [ 959  :  952 ];
					isData3[ 120 ] <= iData3  [ 967  :  960 ];
					isData3[ 121 ] <= iData3  [ 975  :  968 ];
					isData3[ 122 ] <= iData3  [ 983  :  976 ];
					isData3[ 123 ] <= iData3  [ 991  :  984 ];
					isData3[ 124 ] <= iData3  [ 999  :  992 ];
					isData3[ 125 ] <= iData3  [ 1007 :  1000 ];
					isData3[ 126 ] <= iData3  [ 1015 :  1008 ];
					isData3[ 127 ] <= iData3  [ 1023 :  1016 ];


      			isData4[ 0 ]   <= iData4   [ 7  :    0 ];
					isData4[ 1 ]   <= iData4   [ 15 :    8 ];
					isData4[ 2 ]   <= iData4   [ 23 :    16 ];
					isData4[ 3 ]   <= iData4   [ 31 :    24 ];
					isData4[ 4 ]   <= iData4   [ 39 :    32 ];
					isData4[ 5 ]   <= iData4   [ 47 :    40 ];
					isData4[ 6 ]   <= iData4   [ 55 :    48 ];
					isData4[ 7 ]   <= iData4   [ 63 :    56 ];
					isData4[ 8 ]   <= iData4   [ 71 :    64 ];
					isData4[ 9 ]   <= iData4   [ 79 :    72 ];
					isData4[ 10 ]  <= iData4  [ 87 :    80 ];
					isData4[ 11 ]  <= iData4  [ 95 :    88 ];
					isData4[ 12 ]  <= iData4  [ 103  :  96 ];
					isData4[ 13 ]  <= iData4  [ 111  :  104 ];					
					isData4[ 14 ]  <= iData4  [ 119  :  112 ];
					isData4[ 15 ]  <= iData4  [ 127  :  120 ];
					isData4[ 16 ]  <= iData4  [ 135  :  128 ];
					isData4[ 17 ]  <= iData4  [ 143  :  136 ];
					isData4[ 18 ]  <= iData4  [ 151  :  144 ];
					isData4[ 19 ]  <= iData4  [ 159  :  152 ];
					isData4[ 20 ]  <= iData4  [ 167  :  160 ];
					isData4[ 21 ]  <= iData4  [ 175  :  168 ];
					isData4[ 22 ]  <= iData4  [ 183  :  176 ];
					isData4[ 23 ]  <= iData4  [ 191  :  184 ];
					isData4[ 24 ]  <= iData4  [ 199  :  192 ];
					isData4[ 25 ]  <= iData4  [ 207  :  200 ];
					isData4[ 26 ]  <= iData4  [ 215  :  208 ];
					isData4[ 27 ]  <= iData4  [ 223  :  216 ];
					isData4[ 28 ]  <= iData4  [ 231  :  224 ];
					isData4[ 29 ]  <= iData4  [ 239  :  232 ];
					isData4[ 30 ]  <= iData4  [ 247  :  240 ];
					isData4[ 31 ]  <= iData4  [ 255  :  248 ];
					isData4[ 32 ]  <= iData4  [ 263  :  256 ];
					isData4[ 33 ]  <= iData4  [ 271  :  264 ];
					isData4[ 34 ]  <= iData4  [ 279  :  272 ];
					isData4[ 35 ]  <= iData4  [ 287  :  280 ];
					isData4[ 36 ]  <= iData4  [ 295  :  288 ];
					isData4[ 37 ]  <= iData4  [ 303  :  296 ];
					isData4[ 38 ]  <= iData4  [ 311  :  304 ];
					isData4[ 39 ]  <= iData4  [ 319  :  312 ];
					isData4[ 40 ]  <= iData4  [ 327  :  320 ];
					isData4[ 41 ]  <= iData4  [ 335  :  328 ];
					isData4[ 42 ]  <= iData4  [ 343  :  336 ];
					isData4[ 43 ]  <= iData4  [ 351  :  344 ];
					isData4[ 44 ]  <= iData4  [ 359  :  352 ];
					isData4[ 45 ]  <= iData4  [ 367  :  360 ];
					isData4[ 46 ]  <= iData4  [ 375  :  368 ];
					isData4[ 47 ]  <= iData4  [ 383  :  376 ];
					isData4[ 48 ]  <= iData4  [ 391  :  384 ];
					isData4[ 49 ]  <= iData4  [ 399  :  392 ];
					isData4[ 50 ]  <= iData4  [ 407  :  400 ];
					isData4[ 51 ]  <= iData4  [ 415  :  408 ];
					isData4[ 52 ]  <= iData4  [ 423  :  416 ];
					isData4[ 53 ]  <= iData4  [ 431  :  424 ];
					isData4[ 54 ]  <= iData4  [ 439  :  432 ];
					isData4[ 55 ]  <= iData4  [ 447  :  440 ];
					isData4[ 56 ]  <= iData4  [ 455  :  448 ];
					isData4[ 57 ]  <= iData4  [ 463  :  456 ];
					isData4[ 58 ]  <= iData4  [ 471  :  464 ];
					isData4[ 59 ]  <= iData4  [ 479  :  472 ];
					isData4[ 60 ]  <= iData4  [ 487  :  480 ];
					isData4[ 61 ]  <= iData4  [ 495  :  488 ];
					isData4[ 62 ]  <= iData4  [ 503  :  496 ];
					isData4[ 63 ]  <= iData4  [ 511  :  504 ];
					isData4[ 64 ]  <= iData4  [ 519  :  512 ];
					isData4[ 65 ]  <= iData4  [ 527  :  520 ];
					isData4[ 66 ]  <= iData4  [ 535  :  528 ];
					isData4[ 67 ]  <= iData4  [ 543  :  536 ];
					isData4[ 68 ]  <= iData4  [ 551  :  544 ];
					isData4[ 69 ]  <= iData4  [ 559  :  552 ];
					isData4[ 70 ]  <= iData4  [ 567  :  560 ];
					isData4[ 71 ]  <= iData4  [ 575  :  568 ];
					isData4[ 72 ]  <= iData4  [ 583  :  576 ];
					isData4[ 73 ]  <= iData4  [ 591  :  584 ];
					isData4[ 74 ]  <= iData4  [ 599  :  592 ];
					isData4[ 75 ]  <= iData4  [ 607  :  600 ];
					isData4[ 76 ]  <= iData4  [ 615  :  608 ];
					isData4[ 77 ]  <= iData4  [ 623  :  616 ];
					isData4[ 78 ]  <= iData4  [ 631  :  624 ];
					isData4[ 79 ]  <= iData4  [ 639  :  632 ];
					isData4[ 80 ]  <= iData4  [ 647  :  640 ];
					isData4[ 81 ]  <= iData4  [ 655  :  648 ];
					isData4[ 82 ]  <= iData4  [ 663  :  656 ];
					isData4[ 83 ]  <= iData4  [ 671  :  664 ];
					isData4[ 84 ]  <= iData4  [ 679  :  672 ];
					isData4[ 85 ]  <= iData4  [ 687  :  680 ];
					isData4[ 86 ]  <= iData4  [ 695  :  688 ];
					isData4[ 87 ]  <= iData4  [ 703  :  696 ];
					isData4[ 88 ]  <= iData4  [ 711  :  704 ];
					isData4[ 89 ]  <= iData4  [ 719  :  712 ];
					isData4[ 90 ]  <= iData4  [ 727  :  720 ];
					isData4[ 91 ]  <= iData4  [ 735  :  728 ];
					isData4[ 92 ]  <= iData4  [ 743  :  736 ];
					isData4[ 93 ]  <= iData4  [ 751  :  744 ];
					isData4[ 94 ]  <= iData4  [ 759  :  752 ];
					isData4[ 95 ]  <= iData4  [ 767  :  760 ];
					isData4[ 96 ]  <= iData4  [ 775  :  768 ];
					isData4[ 97 ]  <= iData4  [ 783  :  776 ];
					isData4[ 98 ]  <= iData4  [ 791  :  784 ];
					isData4[ 99 ]  <= iData4  [ 799  :  792 ];
					isData4[ 100 ] <= iData4  [ 807  :  800 ];
					isData4[ 101 ] <= iData4  [ 815  :  808 ];
					isData4[ 102 ] <= iData4  [ 823  :  816 ];
					isData4[ 103 ] <= iData4  [ 831  :  824 ];
					isData4[ 104 ] <= iData4  [ 839  :  832 ];
					isData4[ 105 ] <= iData4  [ 847  :  840 ];
					isData4[ 106 ] <= iData4  [ 855  :  848 ];
					isData4[ 107 ] <= iData4  [ 863  :  856 ];
					isData4[ 108 ] <= iData4  [ 871  :  864 ];
					isData4[ 109 ] <= iData4  [ 879  :  872 ];
					isData4[ 110 ] <= iData4  [ 887  :  880 ];
					isData4[ 111 ] <= iData4  [ 895  :  888 ];
					isData4[ 112 ] <= iData4  [ 903  :  896 ];
					isData4[ 113 ] <= iData4  [ 911  :  904 ];
					isData4[ 114 ] <= iData4  [ 919  :  912 ];
					isData4[ 115 ] <= iData4  [ 927  :  920 ];
					isData4[ 116 ] <= iData4  [ 935  :  928 ];
					isData4[ 117 ] <= iData4  [ 943  :  936 ];
					isData4[ 118 ] <= iData4  [ 951  :  944 ];
					isData4[ 119 ] <= iData4  [ 959  :  952 ];
					isData4[ 120 ] <= iData4  [ 967  :  960 ];
					isData4[ 121 ] <= iData4  [ 975  :  968 ];
					isData4[ 122 ] <= iData4  [ 983  :  976 ];
					isData4[ 123 ] <= iData4  [ 991  :  984 ];
					isData4[ 124 ] <= iData4  [ 999  :  992 ];
					isData4[ 125 ] <= iData4  [ 1007 :  1000 ];
					isData4[ 126 ] <= iData4  [ 1015 :  1008 ];
					isData4[ 127 ] <= iData4  [ 1023 :  1016 ];

			end										
																																										    	
	 reg [7:0]D1,D2;
	 reg [7:0] i,j,k;
	 reg  [1:0] isCall;
	 reg isDone;
	 always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		      begin
				    D1 <= 8'd0;
					 D2 <= 8'd0;
					 i <= 8'd0;
					 j <= 8'd0;
					 k <= 8'd0;
					 isCall <= 2'b00;
					 //isData1 <= iData1;
					//isData2 <= iData2;
					//isData3 <= iData3;
					//isData4 <= iData4;
				end
		else if( iCall )
		    case( i )
//# ========================================================================= #
//# |                                初始化开始    							| #
//****************************************************************************//
				0  :
					if ( k ==125 ) //TIME_100ms
        					begin
 
            					k <= 8'd0;
            					i <= i + 1'b1;
 
        					end
 
    				else
 
        					begin
 
            					k <= k + 1'd1;
 
        					end				
				1  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hAF; end
					else begin isCall <= 2'b10; end////关闭显示	
				2  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h40; end
					else begin isCall <= 2'b10; end//---set low column address
				3  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hB0; end
					else begin isCall <= 2'b10; end//---set high column address
				4  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hC8; end
					else begin isCall <= 2'b10; end//*set display start line*/			
				5  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h81; end
					else begin isCall <= 2'b10; end///设置对比度
				6  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hFF; end
					else begin isCall <= 2'b10; end///设置对比度
				7  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hA1; end
					else begin isCall <= 2'b10; end//段重定向设置/*set segment remap*/
				8  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hA6; end
					else begin isCall <= 2'b10; end//段重定向设置/*normal / reverse*/
				9  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hA8; end
					else begin isCall <= 2'b10; end//设置驱动路数/*multiplex ratio*/
				10  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h1f; end
					else begin isCall <= 2'b10; end//设置驱动路数/*duty = 1/32*/
				11  :
					i <= i + 1'b1;
					/*if( iDone ) begin isCall <= 2'b00; D1 = WR_CMD;  D2 <= 8'hC8; end
					else begin isCall <= 2'b10; end//设置驱动路数/*Com scan direction*/
				12  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hD3; end
					else begin isCall <= 2'b10; end//设置驱动路数/*set display offset*/		
				13  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h00; end
					else begin isCall <= 2'b10; end//设置驱动路数
				14  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hD5; end
					else begin isCall <= 2'b10; end//设置驱动路数/*set osc division*/
				15  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hF0; end
					else begin isCall <= 2'b10; end//设置驱动路数
				16  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hD9; end
					else begin isCall <= 2'b10; end//设置驱动路数/*set pre-charge period*/
				17  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h22; end
					else begin isCall <= 2'b10; end//设置驱动路数
				18  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hDA; end
					else begin isCall <= 2'b10; end//设置驱动路数/*set COM pins*/
				19  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h02; end
					else begin isCall <= 2'b10; end//设置驱动路数
				20  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'hdb; end
					else begin isCall <= 2'b10; end//设置驱动路数/*set vcomh*/
				21  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h49; end
					else begin isCall <= 2'b10; end//设置驱动路数
				22  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h8d; end
					else begin isCall <= 2'b10; end//设置驱动路数/*set charge pump enable*/
				23  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'h14; end
					else begin isCall <= 2'b10; end//设置驱动路数						
				24  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = WR_CMD;  D2 <= 8'haf; end
					else begin isCall <= 2'b10; end//设置驱动路数/*display ON*/
				25  :
					begin isDone <= 1'b1; i <= i + 1'b1; end
					 
				26  :
					begin isDone <= 1'b0; i <= i + 1'b1; end						
//# ==========			=============================================================== #
//# |         					             初始化结束 开始写数据   							| #
//************			****************************************************************//
				27  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= page_1st; end
					else begin isCall <= 2'b10; end					
				28  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h00; end
					else begin isCall <= 2'b10; end
				29  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h10; end
					else begin isCall <= 2'b10; end	
				30  :
					if( iDone ) begin
						if ( j == 127 ) 
        					begin
 
            					j <= 8'd0;
            					i <= i + 1'b1;
 
        					end
 
    					else
 
        					begin
 
            					j <= j + 1'd1;
            					isCall <= 2'b00;
            					D1 = DATA_CMD;  
            					D2 <= isData1[j];
 
        					end				
					end
					else begin isCall <= 2'b10; end
				31  :
					begin isDone <= 1'b1; i <= i + 1'b1; end
					 
				32  :
					begin isDone <= 1'b0; i <= i + 1'b1; end							
				33  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= page_2nd; end
					else begin isCall <= 2'b10; end					
				34  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h00; end
					else begin isCall <= 2'b10; end
				35  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h10; end
					else begin isCall <= 2'b10; end
				36  :
					if( iDone ) begin
						if ( j == 127 ) 
        					begin
 
            					j <= 8'd0;
            					i <= i + 1'b1;
 
        					end
 
    					else
 
        					begin
 
            					j <= j + 1'b1;
            					isCall <= 2'b00;
            					D1 = DATA_CMD;  
            					D2 <= isData2[j];
 
        					end				
					end
					else begin isCall <= 2'b10; end		
				37  :
					begin isDone <= 1'b1; i <= i + 1'b1; end
					 
				38  :
					begin isDone <= 1'b0; i <= i + 1'b1; end										
				39  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= page_3rd; end
					else begin isCall <= 2'b10; end					
				40  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h00; end
					else begin isCall <= 2'b10; end
				41  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h10; end
					else begin isCall <= 2'b10; end
				42  :
					if( iDone ) begin
						if ( j == 127 ) 
        					begin
 
            					j <= 8'd0;
            					i <= i + 1'b1;
 
        					end
 
    					else
 
        					begin
 
            					j <= j + 1'b1;
            					isCall <= 2'b00;
            					D1 = DATA_CMD;  
            					D2 <= isData3[j];
 
        					end				
					end
					else begin isCall <= 2'b10; end	
				43  :
					begin isDone <= 1'b1; i <= i + 1'b1; end
					 
				44  :
					begin isDone <= 1'b0; i <= i + 1'b1; end											
				45  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= page_4th; end
					else begin isCall <= 2'b10; end					
				46  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h00; end
					else begin isCall <= 2'b10; end
				47  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;D1 = DATA_CMD;  D2 <= 8'h10; end
					else begin isCall <= 2'b10; end						
				48  :
					if( iDone ) begin
						if ( j == 127 ) 
        					begin
 
            					j <= 8'd0;
            					i <= i + 1'b1;
 
        					end
 
    					else
 
        					begin
 
            					j <= j + 1'b1;
            					isCall <= 2'b00;
            					D1 = DATA_CMD;  
            					D2 <= isData4[j];
 
        					end				
					end
					else begin isCall <= 2'b10; end
				49  :
					begin isDone <= 1'b1; i <= i + 1'b1; end
					 
				50  :
					begin isDone <= 1'b0; i <= 8'd27; end	

			endcase
	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oAddr = D1;
	  assign oData = D2;

endmodule
