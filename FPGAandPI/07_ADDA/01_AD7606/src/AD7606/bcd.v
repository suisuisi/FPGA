module bcd(clk,
          hex,
          dec);

input  clk;
input  [16:0] hex;
output [19:0] dec;

wire [15:0] rrhex;
reg [3:0] rhex[3:0];

reg [18:0] rhexd;
reg [13:0] rhexc;
reg [9:0] rhexb;
reg [3:0] rhexa;

reg [5:0] resa,resb,resc,resd;
reg [3:0] rese;

assign rrhex = hex[16] ? ~hex[15:0]+1'b1 : hex[15:0];         //去符号
assign dec = {rese,resd[3:0],resc[3:0],resb[3:0],resa[3:0]};

always@(posedge clk)                 //第一级寄存器
begin
    rhex[3] <= rrhex[15:12];
    rhex[2] <= rrhex[11:8];
    rhex[1] <= rrhex[7:4];
    rhex[0] <= rrhex[3:0];
end

always@(posedge clk)                  //高4bit译码
begin
    case(rhex[3])
        4'h0: rhexd <= 19'h00000;
        4'h1: rhexd <= 19'h04096;            //0x1000 -> 4096 (十进制)
        4'h2: rhexd <= 19'h08192;            //0x2000 -> 8192 (十进制)
        4'h3: rhexd <= 19'h12288;            //0x3000 -> 12288 (十进制)
        4'h4: rhexd <= 19'h16384;            //0x4000 -> 16384 (十进制)
        4'h5: rhexd <= 19'h20480;            //0x5000 -> 20480 (十进制)
        4'h6: rhexd <= 19'h24576;            //0x6000 -> 24576 (十进制)
        4'h7: rhexd <= 19'h28672;            //0x7000 -> 28672 (十进制)
		  4'h8: rhexd <= 19'h32768;            //0x8000 -> 32768 (十进制)
		  4'h9: rhexd <= 19'h36864;            //0x9000 -> 36864 (十进制)
		  4'ha: rhexd <= 19'h40960;            //0xa000 -> 40960 (十进制)
		  4'hb: rhexd <= 19'h45056;            //0xb000 -> 45056 (十进制)
		  4'hc: rhexd <= 19'h49152;            //0xc000 -> 49152 (十进制)
		  4'hd: rhexd <= 19'h53248;            //0xd000 -> 53248 (十进制)
		  4'he: rhexd <= 19'h57344;            //0xe000 -> 57344 (十进制)		
		  4'hf: rhexd <= 19'h61440;            //0xf000 -> 61440 (十进制)			  
        default: rhexd <= 19'h00000;
    endcase
end

always@(posedge clk)                //次高4bit译码
begin
    case(rhex[2]) 
        4'h0: rhexc <= 14'h0000;
        4'h1: rhexc <= 14'h0256;           //0x100 -> 256 (十进制)
        4'h2: rhexc <= 14'h0512;           //0x200 -> 512 (十进制)
        4'h3: rhexc <= 14'h0768;           //0x300 -> 768 (十进制)
        4'h4: rhexc <= 14'h1024;           //0x400 -> 1024 (十进制)
        4'h5: rhexc <= 14'h1280;           //0x500 -> 1280 (十进制)
        4'h6: rhexc <= 14'h1536;           //0x600 -> 1536 (十进制)
        4'h7: rhexc <= 14'h1792;           //0x700 -> 1792 (十进制)
        4'h8: rhexc <= 14'h2048;           //0x800 -> 2048 (十进制)
        4'h9: rhexc <= 14'h2304;           //0x900 -> 2304 (十进制)
        4'ha: rhexc <= 14'h2560;           //0xA00 -> 2560 (十进制)
        4'hb: rhexc <= 14'h2816;           //0xB00 -> 2816 (十进制)
        4'hc: rhexc <= 14'h3072;           //0xC00 -> 3072 (十进制)
        4'hd: rhexc <= 14'h3328;           //0xD00 -> 3328 (十进制)
        4'he: rhexc <= 14'h3584;           //0xE00 -> 3584 (十进制)
        4'hf: rhexc <= 14'h3840;           //0xF00 -> 3840 (十进制)
        default: rhexc <= 14'h0000;
    endcase
end 

always@(posedge clk)
begin
    case(rhex[1])
        4'h0: rhexb <= 10'h000;
        4'h1: rhexb <= 10'h016;
        4'h2: rhexb <= 10'h032;
        4'h3: rhexb <= 10'h048;
        4'h4: rhexb <= 10'h064;
        4'h5: rhexb <= 10'h080;
        4'h6: rhexb <= 10'h096;
        4'h7: rhexb <= 10'h112;
        4'h8: rhexb <= 10'h128;
        4'h9: rhexb <= 10'h144;
        4'ha: rhexb <= 10'h160;
        4'hb: rhexb <= 10'h176;
        4'hc: rhexb <= 10'h192;
        4'hd: rhexb <= 10'h208;
        4'he: rhexb <= 10'h224;
        4'hf: rhexb <= 10'h240;
        default: rhexb <= 10'h000;
    endcase
end 

always@(posedge clk)
begin
    rhexa <= rhex[0];
end

always@(posedge clk) //每个结果按同级单个bcd码相加,高一级的bcd码要加上低一级的进位,也就是高出4位的部分
begin   
    resa = addbcd4(rhexa[3:0],rhexb[3:0],rhexc[3:0],  rhexd[3:0]);
    resb = addbcd4(resa[5:4], rhexb[7:4],rhexc[7:4],  rhexd[7:4]);
    resc = addbcd4(resb[5:4], rhexb[9:8],rhexc[11:8], rhexd[11:8]);
    resd = addbcd4(resc[5:4], 4'h0,      rhexc[13:12],rhexd[15:12]);
    rese = resd[5:4] + rhexd[18:16];
end

function [5:0] addbcd4; 
input [3:0] add1,add2,add3,add4;
begin
    addbcd4 = add1 + add2 + add3 + add4;
    if(addbcd4 > 6'h1d)               //>29 最低有一个可能出现0xf,但由二进制转换而来的数在这里不会出现大于40的情况
        addbcd4 = addbcd4 + 5'h12;
    else if(addbcd4 > 5'h13)          //>19对结果加12
        addbcd4 = addbcd4 + 4'hc;
    else if(addbcd4 > 4'h9)           //>9对结果加6
        addbcd4 = addbcd4 + 4'h6;
end
endfunction




endmodule

