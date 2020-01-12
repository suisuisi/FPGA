/*--------------------------------------------------------------*\
	Filename	:	initial_control_module.v
	Author		:	Cwang
	Description	:	
	Revision History	:	2017-10-116
							Revision 1.0
	Email		:	wangcp@hitrobotgroup.com
	Company		:	Micro nano institute
	Copyright(c) 2017,Micro nano institute,All right resered
\*---------------------------------------------------------------*/
module initial_control(
    input CLOCK, RST_n,	 
	 input init_start_sig,
	 output oDone,
	 output [1:0]oCall,
	 input iDone,
	 output [7:0]oAddr, oData
);	 

parameter     WR_CMD   = 8'b0000_0000;        //写命令控制字write_command
parameter     DATA_CMD = 8'b0100_0000;      //写数据控制字write_data



																																										    	
	 reg [7:0]D1,D2;
	 reg [7:0] i;
	 reg  [1:0] isCall;
	 reg isDone;
	 always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		      begin
				    D1 <= 8'd0;
					 D2 <= 8'd0;
					 i <= 8'd0;
					 //isData1 <= iData1;
					//isData2 <= iData2;
					//isData3 <= iData3;
					//isData4 <= iData4;
				end
		else if( init_start_sig )
		    case( i )
//# ========================================================================= #
//# |                                初始化开始    							| #
//****************************************************************************//
				0  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hAE;end////关闭显示	
				1  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h00;end//---set low column address
				2  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h10;end//---set high column address
				3  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h40;end//*set display start line*/						
				4 :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h81;end///设置对比度
				5 :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hCF;end///设置对比度
				6 :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hA1;end//段重定向设置/*set segment remap*/
				7 :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end//
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hC8;end//*set page address*/						
				8 :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10;D1 = WR_CMD;  D2 <= 8'hA6; end//段重定向设置/*normal / reverse*/
				9 :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hA8;end//设置驱动路数/*multiplex ratio*/
				10  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;end
					else begin isCall <= 2'b10;D1 = WR_CMD;  D2 <= 8'h3f;  end//设置驱动路数/*duty = 1/32*/
				11  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10;D1 = WR_CMD;  D2 <= 8'hD3; end//设置驱动路数/*set display offset*/
				12  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h00;end//设置驱动路数
				13  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hD5;end//设置驱动路数/*set osc division*/
				14  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h80;end//设置驱动路数
				15  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hD9;end//设置驱动路数/*set pre-charge period*/
				16  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hf1; end//设置驱动路数
				17  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hDA;end//设置驱动路数/*set COM pins*/
				18  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h12;end//设置驱动路数
				19  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'hdb;end//设置驱动路数/*set vcomh*/
				20  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h40;end//设置驱动路数
				21  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h20;end//设置驱动路数/*set charge pump enable*/
				22  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1;end
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h02; end//设置驱动路数8d 14 a4 a6		
				23  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end//
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h8d;end//设置驱动路数/*Com scan direction*/
				24  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end//
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'h14;end//设置驱动路数/*Com scan direction*/
				25  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end//
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'ha4;end//设置驱动路数/*Com scan direction*/	
				26  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end//
					else begin isCall <= 2'b10; D1 = WR_CMD;  D2 <= 8'ha6;end//设置驱动路数/*Com scan direction*/														
				27  :
					if( iDone ) begin isCall <= 2'b00; i <= i + 1'b1; end
					else begin isCall <= 2'b10;D1 = WR_CMD;  D2 <= 8'haf; end//设置驱动路数/*display ON*/
				28  :
					begin isDone <= 1'b1; i <= i + 1'b1; end
					 
				29  :
					begin isDone <= 1'b0; i <= 8'd0; end						
//# ==========			=============================================================== #
//# |         					             初始化结束 开始写数据   							| #
//************			****************************************************************//
				

			endcase
	  
	  assign oDone = isDone;
	  assign oCall = isCall;
	  assign oAddr = D1;
	  assign oData = D2;

endmodule

	
	
	
	
	