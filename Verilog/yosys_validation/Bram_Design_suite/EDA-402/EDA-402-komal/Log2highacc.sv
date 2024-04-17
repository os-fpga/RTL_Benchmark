module Log2highacc

/* 
A fast base-2 logarithm function, 24 bits (22 used) in, 12 bits out.
Designed and coded by: Michael Dunn, http://www.cantares.on.ca/
(more info at the web site - see "Extras")
Executes every cycle, with a latency of 3.

Compared to previous versions, this one has a larger, higher resolution
lookup table. This provides a smoother and more accurate output, though
a downside of having higher LUT resolution than the LUT depth fully
supports is that there are missing codes in the output. If this is a problem,
the lower 2 or 3 output bits can be ignored. In most cases, use all the
bits you can!

Valid input range = 000100 - FFFFFF. In effect, there is a binary point:
xxxx.yy. Logs of inputs below 1.00 are negative, and not handled by this design.

License: Free to use & modify, but please keep this header intact.
August 2, 2010, Kitchener, Ontario, Canada
*/

(
	input [23:0]	DIN,
	input			clk,

	output	[11:0]	DOUT
);


// Comprises 4 main blocks: priority encoder, barrel shifter, LUT, and adder.

reg	[3:0]	priencout1;
reg	[3:0]	priencout2;
reg	[3:0]	priencout3;
reg	[5:0]	barrelout;
reg	[20:0]	barrelin;
reg	[7:0]	LUTout;

assign	DOUT	=	{priencout3, LUTout};	// Basic top-level connectivity

always @(posedge clk) 					
begin
	priencout2	<=	priencout1;
	priencout3	<=	priencout2;
	barrelin	<=	DIN[22:2];
end


wire [20:0] tmp1 =	(barrelin << ~priencout1);	// Barrel shifter - OMG, it's a primitive in Verilog!
always @(posedge clk)
begin
	barrelout	<=	tmp1[20:15];
end


wire	[15:0]	priencin = DIN[23:8];

always @(posedge clk)						// Priority encoder

casex (priencin)

	16'b1xxxxxxxxxxxxxxx:	priencout1	<=	15;
	16'b01xxxxxxxxxxxxxx:	priencout1	<=	14;
	16'b001xxxxxxxxxxxxx:	priencout1	<=	13;	
	16'b0001xxxxxxxxxxxx:	priencout1	<=	12;	
	16'b00001xxxxxxxxxxx:	priencout1	<=	11;	
	16'b000001xxxxxxxxxx:	priencout1	<=	10;	
	16'b0000001xxxxxxxxx:	priencout1	<=	9;	
	16'b00000001xxxxxxxx:	priencout1	<=	8;	
	16'b000000001xxxxxxx:	priencout1	<=	7;	
	16'b0000000001xxxxxx:	priencout1	<=	6;	
	16'b00000000001xxxxx:	priencout1	<=	5;	
	16'b000000000001xxxx:	priencout1	<=	4;	
	16'b0000000000001xxx:	priencout1	<=	3;	
	16'b00000000000001xx:	priencout1	<=	2;	
	16'b000000000000001x:	priencout1	<=	1;	
	16'b000000000000000x:	priencout1	<=	0;
	
endcase



/*
LUT for log fraction lookup
 - can be done with array or case:

case (addr)
0:out=0;
.
31:out=15;
endcase

	OR
	
wire [3:0] lut [0:31];
assign lut[0] = 0;
.
assign lut[31] = 15;


Are there any better ways?
*/

// Let's try "case".
// The equation is: output = log2(1+input/64)*256
// For larger tables, better to generate a separate data file using a program!
// wire [3:0] LUTout [0:31];

// assign LUTout[0]	=	0;
// assign LUTout[1]	=	6;
// assign LUTout[2]	=	11;
// assign LUTout[3]	=	17;
// assign LUTout[4]	=	22;
// assign LUTout[5]	=	28;
// assign LUTout[6]	=	33;
// assign LUTout[7]	=	38;
// assign LUTout[8]	=	44;
// assign LUTout[9]	=	49;
// assign LUTout[10]	=	54;
// assign LUTout[11]	=	59;
// assign LUTout[12]	=	63;
// assign LUTout[13]	=	68;
// assign LUTout[14]	=	73;
// assign LUTout[15]	=	78;
// assign LUTout[16]	=	82;
// assign LUTout[17]	=	87;
// assign LUTout[18]	=	92;
// assign LUTout[19]	=	96;
// assign LUTout[20]	=	100;
// assign LUTout[21]	=	105;
// assign LUTout[22]	=	109;
// assign LUTout[23]	=	113;
// assign LUTout[24]	=	118;
// assign LUTout[25]	=	122;
// assign LUTout[26]	=	126;
// assign LUTout[27]	=	130;
// assign LUTout[28]	=	134;
// assign LUTout[29]	=	138;
// assign LUTout[30]	=	142;
// assign LUTout[31]	=	146;
// assign LUTout[32]	=	150;
// assign LUTout[33]	=	154;
// assign LUTout[34]	=	157;
// assign LUTout[35]	=	161;
// assign LUTout[36]	=	165;
// assign LUTout[37]	=	169;
// assign LUTout[38]	=	172;
// assign LUTout[39]	=	176;
// assign LUTout[40]	=	179;
// assign LUTout[41]	=	183;
// assign LUTout[42]	=	186;
// assign LUTout[43]	=	190;
// assign LUTout[44]	=	193;
// assign LUTout[45]	=	197;
// assign LUTout[46]	=	200;
// assign LUTout[47]	=	203;
// assign LUTout[48]	=	207;
// assign LUTout[49]	=	210;
// assign LUTout[50]	=	213;
// assign LUTout[51]	=	216;
// assign LUTout[52]	=	220;
// assign LUTout[53]	=	223;
// assign LUTout[54]	=	226;
// assign LUTout[55]	=	229;
// assign LUTout[56]	=	232;
// assign LUTout[57]	=	235;
// assign LUTout[58]	=	238;
// assign LUTout[59]	=	241;
// assign LUTout[60]	=	244;
// assign LUTout[61]	=	247;
// assign LUTout[62]	=	250;
// assign LUTout[63]	=	253;

always @(posedge clk)
case (barrelout)

	0:	LUTout	<=	0;
	1:	LUTout	<=	6;
	2:	LUTout	<=	11;
	3:	LUTout	<=	17;
	4:	LUTout	<=	22;
	5:	LUTout	<=	28;
	6:	LUTout	<=	33;
	7:	LUTout	<=	38;
	8:	LUTout	<=	44;
	9:	LUTout	<=	49;
	10:	LUTout	<=	54;
	11:	LUTout	<=	59;
	12:	LUTout	<=	63;
	13:	LUTout	<=	68;
	14:	LUTout	<=	73;
	15:	LUTout	<=	78;
	16:	LUTout	<=	82;
	17:	LUTout	<=	87;
	18:	LUTout	<=	92;
	19:	LUTout	<=	96;
	20:	LUTout	<=	100;
	21:	LUTout	<=	105;
	22:	LUTout	<=	109;
	23:	LUTout	<=	113;
	24:	LUTout	<=	118;
	25:	LUTout	<=	122;
	26:	LUTout	<=	126;
	27:	LUTout	<=	130;
	28:	LUTout	<=	134;
	29:	LUTout	<=	138;
	30:	LUTout	<=	142;
	31:	LUTout	<=	146;
	32:	LUTout	<=	150;
	33:	LUTout	<=	154;
	34:	LUTout	<=	157;
	35:	LUTout	<=	161;
	36:	LUTout	<=	165;
	37:	LUTout	<=	169;
	38:	LUTout	<=	172;
	39:	LUTout	<=	176;
	40:	LUTout	<=	179;
	41:	LUTout	<=	183;
	42:	LUTout	<=	186;
	43:	LUTout	<=	190;
	44:	LUTout	<=	193;
	45:	LUTout	<=	197;
	46:	LUTout	<=	200;
	47:	LUTout	<=	203;
	48:	LUTout	<=	207;
	49:	LUTout	<=	210;
	50:	LUTout	<=	213;
	51:	LUTout	<=	216;
	52:	LUTout	<=	220;
	53:	LUTout	<=	223;
	54:	LUTout	<=	226;
	55:	LUTout	<=	229;
	56:	LUTout	<=	232;
	57:	LUTout	<=	235;
	58:	LUTout	<=	238;
	59:	LUTout	<=	241;
	60:	LUTout	<=	244;
	61:	LUTout	<=	247;
	62:	LUTout	<=	250;
	63:	LUTout	<=	253;

endcase

endmodule
