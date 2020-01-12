 /* 
Filename    : Sobel.v
Compiler    : Quartus II 13.0
Description : implement Sobel Edge Detector 
*/

module sobel (
  input            iCLK,
  input            iRST_N,
  input      [7:0] iTHRESHOLD,
  input            iDVAL,
  input      [9:0] iDATA,
  output reg       oDVAL,
  output reg [9:0] oDATA
);

// mask x
parameter X1 = 8'hff, X2 = 8'h00, X3 = 8'h01;
parameter X4 = 8'hfe, X5 = 8'h00, X6 = 8'h02;
parameter X7 = 8'hff, X8 = 8'h00, X9 = 8'h01;

// mask y
parameter Y1 = 8'h01, Y2 = 8'h02, Y3 = 8'h01;
parameter Y4 = 8'h00, Y5 = 8'h00, Y6 = 8'h00;
parameter Y7 = 8'hff, Y8 = 8'hfe, Y9 = 8'hff;

wire  [7:0] Line0;
wire  [7:0] Line1;
wire  [7:0] Line2;

wire  [17:0]  Mac_x0;
wire  [17:0]  Mac_x1;
wire  [17:0]  Mac_x2;

wire  [17:0]  Mac_y0;
wire  [17:0]  Mac_y1;
wire  [17:0]  Mac_y2;

wire  [19:0]  Pa_x;
wire  [19:0]  Pa_y;

wire  [15:0]  Abs_mag;

LineBuffer LineBuffer_inst (
  .clken(iDVAL),
  .clock(iCLK),
  .shiftin(iDATA[9:2]),
  .taps0x(Line0),
  .taps1x(Line1),
  .taps2x(Line2)
);

// X
MAC_3 x0 (
  .aclr3(!iRST_N),
  .clock0(iCLK),
  .dataa_0(Line0),
  .datab_0(X9),
  .datab_1(X8),
  .datab_2(X7),
  .result(Mac_x0)
);

MAC_3 x1 (
  .aclr3(!iRST_N),
  .clock0(iCLK),
  .dataa_0(Line1),
  .datab_0(X6),
  .datab_1(X5),
  .datab_2(X4),
  .result(Mac_x1)
);

MAC_3 x2 (
  .aclr3(!iRST_N),
  .clock0(iCLK),
  .dataa_0(Line2),
  .datab_0(X3),
  .datab_1(X2),
  .datab_2(X1),
  .result(Mac_x2)
);

// Y
MAC_3 y0 (
  .aclr3(!iRST_N),
  .clock0(iCLK),
  .dataa_0(Line0),
  .datab_0(Y9),
  .datab_1(Y8),
  .datab_2(Y7),
  .result(Mac_y0)
);

MAC_3 y1 (
  .aclr3(!iRST_N),
  .clock0(iCLK),
  .dataa_0(Line1),
  .datab_0(Y6),
  .datab_1(Y5),
  .datab_2(Y4),
  .result(Mac_y1)
);

MAC_3 y2 (
  .aclr3(!iRST_N),
  .clock0(iCLK),
  .dataa_0(Line2),
  .datab_0(Y3),
  .datab_1(Y2),
  .datab_2(Y1),
  .result(Mac_y2)
);

PA_3 pa0 (
  .clock(iCLK),
  .data0x(Mac_x0),
  .data1x(Mac_x1),
  .data2x(Mac_x2),
  .result(Pa_x)
);

PA_3 pa1 (
  .clock(iCLK),
  .data0x(Mac_y0),
  .data1x(Mac_y1),
  .data2x(Mac_y2),
  .result(Pa_y)
);

SQRT sqrt0 (
  .clk(iCLK),
  .radical(Pa_x * Pa_x + Pa_y * Pa_y),
  .q(Abs_mag)
);

always@(posedge iCLK, negedge iRST_N) begin
  if (!iRST_N)
    oDVAL <= 0;
  else begin
    oDVAL <= iDVAL;
    
    if (iDVAL)
      oDATA <= (Abs_mag > iTHRESHOLD) ? 0 : 1023;
    else
      oDATA <= 0;
  end
end

endmodule 