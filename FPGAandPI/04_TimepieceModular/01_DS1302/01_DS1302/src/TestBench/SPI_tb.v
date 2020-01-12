//***************************************//
//# @Author: 碎碎思
//# @Date:   2019-04-06 22:44:48
//# @Last Modified by:   zlk
//# @Last Modified time: 2019-04-18 22:01:22
//****************************************//
`timescale 1ns/ 1ps
module SPI_tb; // 申明TestBench名称
reg       clock;
reg       reset; // 申明信号

// Inputs
    reg I_rx_en;
    reg I_tx_en;
    reg [7:0] I_data_in;
    reg I_spi_miso;

    // Outputs
    wire [7:0] O_data_out;
    wire O_tx_done;
    wire O_rx_done;
    wire O_spi_sck;
    wire O_spi_cs;
    wire O_spi_mosi;




// 申明SPI协议设计单元
 spi dut (
        .CLOCK(clock), 
        .RESET(reset), 
        .I_rx_en(I_rx_en), 
        .I_tx_en(I_tx_en), 
        .iData(I_data_in), 
        .oData(O_data_out), 
        .iDone(O_tx_done), 
        .oDone(O_rx_done), 
        .I_spi_miso(I_spi_miso), 
        .O_spi_sck(O_spi_sck), 
        .O_spi_cs(O_spi_cs), 
        .O_spi_mosi(O_spi_mosi)
    );

    

initial begin   // 建立时钟
    clock = 0;
    forever #10 clock = ~clock;
end

initial begin   // 提供激励
	clock = 0;
    I_rx_en = 0;
    I_tx_en = 1;
    I_data_in = 8'h00;
    I_spi_miso = 0;
    reset = 0;
    #200 // Wait 200 ns for global reset to finish
    reset = 1;
    #5000000 $stop;
end

/***************************/



/***************************/
always @(posedge clock or negedge reset)
    begin
         if(!reset)
            I_data_in <= 8'h00;
         else if(I_data_in == 8'hff)
            begin
                I_data_in <= 8'hff;
                I_tx_en <= 0;
            end
         else if(O_tx_done)
            I_data_in <= I_data_in + 1'b1 ;            
    end

	

endmodule


