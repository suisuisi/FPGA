//****************************************************************************//
//# @Author: 碎碎思
//# @Date:   2019-06-05 21:05:29
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-06-05 21:15:41
//# Description: 
//# @Modification History: 2012-10-03 16:26:17
//# Date			    By			   Version			   Change Description: 
//# ========================================================================= #
//# 2012-10-03 16:26:17
//# ========================================================================= #
//# |                                          								| #
//# |                                OpenFPGA     							| #
//****************************************************************************//
module delay_module 
(
    CLOCK, RST_n, H2L_Sig, L2H_Sig, Pin_Out
);

    input CLOCK;
	 input RST_n;
	 input H2L_Sig;
	 input L2H_Sig;
	 output Pin_Out;
	 
	 /****************************************/
	 
	 parameter T1MS = 16'd49_999;//DB4CE15开发板使用的晶振为50MHz，50M*0.001-1=49_999
	 
	 /***************************************/
	 
	 reg [15:0]Count1;

	 always @ ( posedge CLOCK or negedge RST_n )
	     if( !RST_n )
		      Count1 <= 16'd0;
		  else if( isCount && Count1 == T1MS )
		      Count1 <= 16'd0;
		  else if( isCount )
		      Count1 <= Count1 + 1'b1;
		  else if( !isCount )
		      Count1 <= 16'd0;
	
    /****************************************/	
				
    reg [3:0]Count_MS;
	    
	 always @ ( posedge CLOCK or negedge RST_n )
        if( !RST_n )
		      Count_MS <= 4'd0;
		  else if( isCount && Count1 == T1MS )
		      Count_MS <= Count_MS + 1'b1;
		  else if( !isCount )
		      Count_MS <= 4'd0;
	
	/******************************************/
	
	reg isCount;
	reg rPin_Out;
	reg [1:0]i;
	
	always @ ( posedge CLOCK or negedge RST_n )
	    if( !RST_n )
		     begin
		         isCount <= 1'b0;
					rPin_Out <= 1'b0;
					i <= 2'd0;
			  end
		 else
		      case ( i )
				
				    2'd0 : 
					 if( H2L_Sig ) i <= 2'd1;
					 else if( L2H_Sig ) i <= 2'd2;
					
				    2'd1 : 
					 if( Count_MS == 4'd10 ) begin isCount <= 1'b0; rPin_Out <= 1'b1; i <= 2'd0; end
				    else	isCount <= 1'b1;
					 
					 2'd2 :
					 if( Count_MS == 4'd10 ) begin isCount <= 1'b0; rPin_Out <= 1'b0; i <= 2'd0; end
				    else	isCount <= 1'b1;
					   
				
				endcase
				
    /********************************************/
	 
	 assign Pin_Out = rPin_Out;
	 
	 /********************************************/
		      


endmodule
