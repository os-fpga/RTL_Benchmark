/*
Copyright ? 2012 JeffLieu-lieumychuong@gmail.com
	This file is part of SGMII-IP-Core.
    SGMII-IP-Core is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    SGMII-IP-Core is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with SGMII-IP-Core.  If not, see <http://www.gnu.org/licenses/>.
File		:
Description	:
Remarks		:
Revision	:
	Date	Author		Description
02/09/12	Jefflieu
*/
`timescale 1ns/1ps
module mDec8b10bMem(
	output 	reg [7:0] o8_Dout,		//HGFEDCBA
	output 	reg o_Kout,
	output 	reg o_DErr,
	output 	reg o_KErr,
	output 	reg o_DpErr,
	input 	i_ForceDisparity,
	input 	i_Disparity,		//1 Is negative, 0 is positive
	input 	[9:0] i10_Din,	//abcdeifghj
	output 	o_Rd,
	input   i_Clk,
	input   i_ARst_L,
	input	soft_reset_i,
    //SP
    input   i_enable
    );

	parameter pNEG = 2'b01;
	parameter pPOS = 2'b10;
	parameter pNEU = 2'b00;
	parameter pERR = 2'b11;
	parameter pD = 2'b01;
	parameter pK = 2'b10;
	parameter pDK = 2'b11;

    parameter TP = 'd1;


	reg r_Disp;
	reg [8:0] w9_5bDecode;
	reg [6:0] w7_3bDecode;
	wire w_Disp,w_jDisp,w_iDisp;
	wire w_iDpErr,w_jDpErr;
	wire w_iDErr,w_jDErr;
	wire [7:0] w8_ABCDEFGH;
	wire wa,wb,wc,wd,we,wi,wf,wg,wh,wj;
	wire w_K28;
	reg 	w_Kx;
	wire w_cdeihj;
	assign w_Disp = i_ForceDisparity?i_Disparity:r_Disp;
	assign {wa,wb,wc,wd,we,wi,wf,wg,wh,wj} = i10_Din;


	always@(*)
		case(i10_Din[9:4])
		6'b011000	: w9_5bDecode <= #TP  {5'b00000,pD,pPOS};
		6'b100111	: w9_5bDecode <= #TP  {5'b00000,pD,pNEG};
		6'b100010	: w9_5bDecode <= #TP  {5'b10000,pD,pPOS};
		6'b011101	: w9_5bDecode <= #TP  {5'b10000,pD,pNEG};
		6'b010010	: w9_5bDecode <= #TP  {5'b01000,pD,pPOS};
		6'b101101	: w9_5bDecode <= #TP  {5'b01000,pD,pNEG};
		6'b110001	: w9_5bDecode <= #TP  {5'b11000,pD,pNEU};
		6'b001010	: w9_5bDecode <= #TP  {5'b00100,pD,pPOS};
		6'b110101	: w9_5bDecode <= #TP  {5'b00100,pD,pNEG};
		6'b101001	: w9_5bDecode <= #TP  {5'b10100,pD,pNEU};
		6'b011001	: w9_5bDecode <= #TP  {5'b01100,pD,pNEU};
		6'b111000	: w9_5bDecode <= #TP  {5'b11100,pD,pNEG};
		6'b000111	: w9_5bDecode <= #TP  {5'b11100,pD,pPOS};
		6'b000110	: w9_5bDecode <= #TP  {5'b00010,pD,pPOS};
		6'b111001	: w9_5bDecode <= #TP  {5'b00010,pD,pNEG};
		6'b100101	: w9_5bDecode <= #TP  {5'b10010,pD,pNEU};
		6'b010101	: w9_5bDecode <= #TP  {5'b01010,pD,pNEU};
		6'b110100	: w9_5bDecode <= #TP  {5'b11010,pD,pNEU};
		6'b001101	: w9_5bDecode <= #TP  {5'b00110,pD,pNEU};
		6'b101100	: w9_5bDecode <= #TP  {5'b10110,pD,pNEU};
		6'b011100	: w9_5bDecode <= #TP  {5'b01110,pD,pNEU};
		6'b101000	: w9_5bDecode <= #TP  {5'b11110,pD,pPOS};
		6'b010111	: w9_5bDecode <= #TP  {5'b11110,pD,pNEG};
		6'b011011	: w9_5bDecode <= #TP  {5'b00001,pD,pNEG};
		6'b100100	: w9_5bDecode <= #TP  {5'b00001,pD,pPOS};
		6'b100011	: w9_5bDecode <= #TP  {5'b10001,pD,pNEU};
		6'b010011	: w9_5bDecode <= #TP  {5'b01001,pD,pNEU};
		6'b110010	: w9_5bDecode <= #TP  {5'b11001,pD,pNEU};
		6'b001011	: w9_5bDecode <= #TP  {5'b00101,pD,pNEU};
		6'b101010	: w9_5bDecode <= #TP  {5'b10101,pD,pNEU};
		6'b011010	: w9_5bDecode <= #TP  {5'b01101,pD,pNEU};
		6'b111010	: w9_5bDecode <= #TP  {5'b11101,pDK,pNEG};
		6'b000101	: w9_5bDecode <= #TP  {5'b11101,pDK,pPOS};
		6'b001100	: w9_5bDecode <= #TP  {5'b00011,pD,pPOS};
		6'b110011	: w9_5bDecode <= #TP  {5'b00011,pD,pNEG};
		6'b100110	: w9_5bDecode <= #TP  {5'b10011,pD,pNEU};
		6'b010110	: w9_5bDecode <= #TP  {5'b01011,pD,pNEU};
		6'b110110	: w9_5bDecode <= #TP  {5'b11011,pDK,pNEG};
		6'b001001	: w9_5bDecode <= #TP  {5'b11011,pDK,pPOS};

		6'b001110	: w9_5bDecode <= #TP  {5'b00111,pD,pNEU};
		6'b001111	: w9_5bDecode <= #TP  {5'b00111,pK,pNEG};    //K28
		6'b110000	: w9_5bDecode <= #TP  {5'b00111,pK,pPOS};    //K28

		6'b101110	: w9_5bDecode <= #TP  {5'b10111,pDK,pNEG};
		6'b010001	: w9_5bDecode <= #TP  {5'b10111,pDK,pPOS};
		6'b011110	: w9_5bDecode <= #TP  {5'b01111,pDK,pNEG};
		6'b100001	: w9_5bDecode <= #TP  {5'b01111,pDK,pPOS};
		6'b101011	: w9_5bDecode <= #TP  {5'b11111,pDK,pNEG};
		6'b010100	: w9_5bDecode <= #TP  {5'b11111,pDK,pPOS};
		//default 	: w9_5bDecode <= #TP  {5'b11111,pERR,pERR};
        //SP
        default 	: w9_5bDecode <= #TP  {5'b00000,pERR,pERR};
		endcase



	assign w_iDpErr = 	(w9_5bDecode[1:0]==pNEG && w_Disp==1'b1) | (w9_5bDecode[1:0]==pPOS && w_Disp==1'b0);
	assign w_iDErr	= (w9_5bDecode[1:0]==pERR)?1'b1:1'b0;
	assign w_iDisp 	= (w9_5bDecode[1:0]==pERR||w9_5bDecode[1:0]==pNEU||i10_Din[9:4]==6'b111000||i10_Din[9:4]==6'b000111)?w_Disp:~w9_5bDecode[1];

	assign w_jDpErr = 	(w7_3bDecode[1:0]==pNEG && w_iDisp==1'b1) | (w7_3bDecode[1:0]==pPOS && w_iDisp==1'b0);

	assign w_jDisp 	= (w7_3bDecode[1:0]==pERR||w7_3bDecode[1:0]==pNEU||i10_Din[3:0]==4'b1100||i10_Din[3:0]==4'b0011)?w_iDisp:~w_iDisp;
	assign w_jDErr	= (w7_3bDecode[1:0]==pERR)?1'b1:1'b0;
	assign w_cdeihj = (~(|{wc,wd,we,wi}))&(wh^wj);
	always@(*)
		case(i10_Din[3:0])
		4'b0100	:	w7_3bDecode <= #TP  {3'b000,pDK,pPOS};
		4'b1011	:	w7_3bDecode <= #TP  {3'b000,pDK,pNEG};
		4'b1001	:	if(w_cdeihj)
						w7_3bDecode <= #TP  {3'b011,pK,pNEU};    //K.x.6
					else
						w7_3bDecode <= #TP  {3'b100,pDK,pNEU};   //K.x.1
		4'b0110	: 	if(w_cdeihj)
						w7_3bDecode <= #TP  {3'b100,pK,pNEU};    //K.x.1
					else
						w7_3bDecode <= #TP  {3'b011,pDK,pNEU};   //K.x.6
		4'b0101	:	if(w_cdeihj)
						w7_3bDecode <= #TP  {3'b101,pK,pNEU};    //K.x.5
					else
						w7_3bDecode <= #TP  {3'b010,pDK,pNEU};   //K.x.2
		4'b1010	:	if(w_cdeihj)
						w7_3bDecode <= #TP  {3'b010,pK,pNEU};    //K.x.2
					else
						w7_3bDecode <= #TP  {3'b101,pDK,pNEU};   //K.x.5
		4'b1100	:	w7_3bDecode <= #TP  {3'b110,pDK,pNEG};
		4'b0011	:	w7_3bDecode <= #TP  {3'b110,pDK,pPOS};
		4'b0010	:	w7_3bDecode <= #TP  {3'b001,pDK,pPOS};
		4'b1101	:	w7_3bDecode <= #TP  {3'b001,pDK,pNEG};
		//4'b1010	:
		//4'b0101	:
		//4'b0110	:
		//4'b1001	:
		4'b1110	:	w7_3bDecode <= #TP  {3'b111,pD,pNEG};
		4'b0001	:	w7_3bDecode <= #TP  {3'b111,pD,pPOS};
		4'b0111	:	w7_3bDecode <= #TP  {3'b111,pDK,pNEG};
		4'b1000	:	w7_3bDecode <= #TP  {3'b111,pDK,pPOS};
		//default : 	w7_3bDecode <= #TP  {3'b111,pERR,pERR};
        //SP
        default : 	w7_3bDecode <= #TP  {3'b000,pERR,pERR};

		endcase

	assign w8_ABCDEFGH = {w9_5bDecode[8:4],w7_3bDecode[6:4]};

	integer I;
	always@(posedge i_Clk or negedge i_ARst_L) begin
	if(~i_ARst_L)
		begin
			o_DErr 	<= #TP  1'b1;
			o_DpErr	<= #TP  1'b0;
			o_KErr 	<= #TP  1'b0;
			o_Kout	<= #TP  1'b0;
			o8_Dout <= #TP  8'h0;
			r_Disp <= #TP  1'b0;
		end
	else begin
		if(soft_reset_i) begin
			o_DErr 	<= #TP  1'b1;
			o_DpErr	<= #TP  1'b0;
			o_KErr 	<= #TP  1'b0;
			o_Kout	<= #TP  1'b0;
			o8_Dout <= #TP  8'h0;
			r_Disp <= #TP  1'b0;
		end
		else if(i_enable)
			begin
				o_DErr 	<= #TP  w_jDErr|w_iDErr;
				o_DpErr <= #TP  w_jDpErr|w_iDpErr;
				o_KErr	<= #TP  ~(|(w9_5bDecode[3:2]&w7_3bDecode[3:2]));
				o_Kout	<= #TP  ((w9_5bDecode[3:2]==pK)&(w7_3bDecode[3]))|((w9_5bDecode[3:2]==pDK)&(w7_3bDecode[3])&(w7_3bDecode[6:4]==3'b111));
				r_Disp 	<= #TP  w_jDisp;
				for(I=0;I<8;I=I+1)
					o8_Dout[7-I] <= #TP  w8_ABCDEFGH[I];
			end
	end
	end
	assign o_Rd = r_Disp;

endmodule 
