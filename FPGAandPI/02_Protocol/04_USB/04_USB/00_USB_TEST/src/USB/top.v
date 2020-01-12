/************************************************************************
 * Author        : Wen Chunyang
 * Email         : 1494640955@qq.com
 * Create time   : 2018-05-09 22:42
 * Last modified : 2018-05-09 22:42
 * Filename      : top.v
 * Description   : 
 * *********************************************************************/
module  top(
    //CLOCK 输入来自CY7C clkout --48MHz
        input                   CLCOK                     ,   
		  input                   rst_n                   ,
        //usb interface
        input                   flag_d                  ,
        input                   flag_a                  ,
        output  wire            slwr                    ,
        output  wire            slrd                    ,
        output  wire            sloe                    ,
        output  wire            pktend                  ,
        output  wire            ifclk                   ,
        output  wire [ 1: 0]    fifo_addr               ,
        inout   wire [15: 0]    usb_data                
);
//=====================================================================\
// ********** Define Parameter and Internal Signals *************
//=====================================================================/
wire                            clk_48m                         ;
reg                             rst_n1,rst_n2                   ; 

wire                            clk_48m_r                       ;
wire                            clk_24m                         ;
wire                            clk_96m                         ; 

wire                            cmd_flag    /*synthesis keep*/  ;
wire    [ 7: 0]                 cmd_data    /*synthesis keep*/  ; 
//======================================================================
// ***************      Main    Code    ****************
//======================================================================


always @(posedge CLCOK or negedge rst_n)begin
    if(!rst_n)begin
        rst_n1 <= 0;
		  rst_n2 <= 0;
    end
    else begin
        rst_n1 <= 1;
		  rst_n2 <= 1;
    end

end

pll_clk	pll_clk_inst (
        .inclk0                 (CLCOK                    ),
        .c0                     (clk_48m                ),
        .locked                 (rst_n                  )
);

usb usb_inst(
        .CLCOK                    (clk_48m                ),
        .rst_n                  (1'b1                  ),
        //usb interface
        .flag_d                 (flag_d                 ),
        .flag_a                 (flag_a                 ),
        .slwr                   (slwr                   ),
        .slrd                   (slrd                   ),
        .sloe                   (sloe                   ),
        .pktend                 (pktend                 ),
        .ifclk                  (ifclk                  ),
        .fifo_addr              (fifo_addr              ),
        .usb_data               (usb_data               ),
        //receive cmd from pc
        .cmd_flag               (cmd_flag               ),
        .cmd_data               (cmd_data               )
);




endmodule
