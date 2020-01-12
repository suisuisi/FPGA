//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-11-04 20:33:38
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-12-18 21:23:45
//# Description: 
//# @Modification History: 2017-04-22 09:19:50
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2017-04-22 09:19:50
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//

`timescale 1ns/1ns

module	Sort3
(
	input				clk,
	input				rst_n,
	
	input		[7:0]	data1, data2, data3,
	output	reg	[7:0]	max_data, mid_data, min_data
);

//-----------------------------------
//Sort of 3 datas	
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		max_data <= 0;
		mid_data <= 0;
		min_data <= 0;
		end
	else
		begin
		//get the max value
		if(data1 >= data2 && data1 >= data3)
			max_data <= data1;
		else if(data2 >= data1 && data2 >= data3)
			max_data <= data2;
		else//(data3 >= data1 && data3 >= data2)
			max_data <= data3;

		//get the mid value
		if((data1 >= data2 && data1 <= data3) || (data1 >= data3 && data1 <= data2))
			mid_data <= data1;
		else if((data2 >= data1 && data2 <= data3) || (data2 >= data3 && data2 <= data1))
			mid_data <= data2;
		else//((data3 >= data1 && data3 <= data2) || (data3 >= data2 && data3 <= data1))
			mid_data <= data3;
			
		//ge the min value
		if(data1 <= data2 && data1 <= data3)
			min_data <= data1;
		else if(data2 <= data1 && data2 <= data3)
			min_data <= data2;
		else//(data3 <= data1 && data3 <= data2)
			min_data <= data3;
		
		end
end

endmodule
