// Address and Data Bus Sizes
//SDRAM MT48LC4M32B2P-6/HY57V283220T
//1M * 4 * 32Bit =(4096 * 256) * 4 * 32Bit = 128MBit

`define	ROWSIZE			12		//Rows width in one bank
`define	COLSIZE			8		//Column width in one bank
`define DSIZE			24      //32Bit SDRAM data
`define	BANKSIZE		2		//4 Banks in one SDRAM

`define ASIZE			`COLSIZE + `ROWSIZE + `BANKSIZE    //SDRAM Total address

// Address Space Parameters -> The new code addres: {Bank, Row, Column}
`define COLSTART		0						
`define ROWSTART      	`COLSIZE      			
`define BANKSTART		`COLSIZE + `ROWSIZE		

//assign   coladdr   = SADDR[`COLSTART + `COLSIZE - 1:`COLSTART];		//assignment of the column address bits
//assign   rowaddr   = SADDR[`ROWSTART + `ROWSIZE - 1: `ROWSTART];    //assignment of the row address bits from SDRAM
//assign   bankaddr  = SADDR[`BANKSTART + `BANKSIZE - 1:`BANKSTART];  //assignment of the bank address bits



//Default read/write address parameter
//`define	DEFAULT_MAX_ADDR	{(`ASIZE - 1'b1){1'b1}}		//Rows * Columns - 1 = 1 Bank
//`define	DEFAULT_BST_LENGTH	9'd256						//Brust Lenght = 1 page

//WR & RD FIFO Depth
`define	FIFO_DEPTH		10

//---------------------------------------
//SDRAM Init paramter setting	
`define		ROW4096_100MHz
//`define		ROW4096_125MHz
//`define		ROW4096_133MHz


`ifdef	ROW4096_133MHz
//	Controller Parameter for 4096 Rows @ 133MHz
parameter	INIT_PER	=	16'd26600;
parameter	REF_PER		=	16'd2078;	//2078.125
parameter	SC_CL		=	3;
parameter	SC_RCD		=	3;
parameter	SC_PM		=	1;
parameter	SC_BL		=	1;
`endif

`ifdef	ROW4096_125MHz
//	Controller Parameter for 4096 Rows @ 125MHz
parameter	INIT_PER	=	16'd25000;
parameter	REF_PER		=	16'd1953;	//1953.125
parameter	SC_CL		=	3;
parameter	SC_RCD		=	3;
parameter	SC_PM		=	1;
parameter	SC_BL		=	1;
`endif

`ifdef	ROW4096_100MHz
//	Controller Parameter for 8192 Rows @ 133MHz
parameter	INIT_PER	=	16'd20000;
parameter	REF_PER		=	16'd1562;	//1562.5
parameter	SC_CL		=	3;
parameter	SC_RCD		=	3;
parameter	SC_PM		=	1;
parameter	SC_BL		=	1;
`endif


//-----------------------------------------------------------
//	SDRAM Parameter
parameter	SDR_BL	=	(SC_PM == 1)?	3'b111	:	//Page 256
						(SC_BL == 1)?	3'b000	:	//1
						(SC_BL == 2)?	3'b001	:	//2
						(SC_BL == 4)?	3'b010	:	//4
										3'b011	;	//8
parameter	SDR_BT	=	1'b0;	//	Sequential
					//	1'b1:	//	Interteave
					
parameter	SDR_CL	=	(SC_CL == 2)?	3'b10:
										3'b11;
 	
