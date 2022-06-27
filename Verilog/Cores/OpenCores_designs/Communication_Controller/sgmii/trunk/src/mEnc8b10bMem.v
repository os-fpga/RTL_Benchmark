/*
Copyright � 2012 JeffLieu-lieumychuong@gmail.com
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
//suppress_messages 10036
module mEnc8b10bMem(
	input 	[7:0] i8_Din,		//HGFEDCBA
	input 	i_Kin,
	input 	i_ForceDisparity,
	input 	i_Disparity,		//1 Is negative, 0 is positive	
	output 	reg [9:0] o10_Dout,	//abcdeifghj
	output 	o_Rd,
	output 	o_KErr,
	input i_Clk,
	input i_ARst_L);
	
	
	
	reg [9:0] 	r10_6bDCode;
	reg [9:0] 	r10_6bKCode;
	reg [7:0] 	r8_4bDCode;
	reg [7:0] 	r8_4bKCode;
	
	reg r_jDisp;
	reg w_jDisp,w_iDisp;
	reg w_Compl6b,w_Compl4b;
	wire w_cDisp;
	wire w_A7;
	reg r_KErr;
	wire w_K23,w_K27,w_K28,w_K29,w_K30;
	
	parameter pNEG = 2'b01;
	parameter pPOS = 2'b10;
	parameter pNEU = 2'b00;
	parameter pERR = 2'b11;
	
	always@(posedge i_Clk or negedge i_ARst_L)	
	if(~i_ARst_L) begin 
			r_jDisp <= 1'b0;//Negative
			o10_Dout <= 10'b0;
			end
		else begin 
			r_jDisp <= w_jDisp;
				if(i_Kin)
					o10_Dout <= {r10_6bKCode[7:2]^{6{w_Compl6b}},r8_4bKCode[5:2]^{4{w_Compl4b}}};
				else 
					o10_Dout <= {r10_6bDCode[7:2]^{6{w_Compl6b}},r8_4bDCode[5:2]^{4{w_Compl4b}}};
			r_KErr <= i_Kin & ((r10_6bKCode[1:0]==pERR)|((w_K23|w_K27|w_K29|w_K30)&&(~&i8_Din[7:5])));
			end
	
	assign w_K23 = i_Kin & (i8_Din[4:0]==5'b10111);
	assign w_K27 = i_Kin & (i8_Din[4:0]==5'b11011);
	assign w_K28 = i_Kin & (i8_Din[4:0]==5'b11100);
	assign w_K29 = i_Kin & (i8_Din[4:0]==5'b11101);
	assign w_K30 = i_Kin & (i8_Din[4:0]==5'b11110);
	
	
	assign w_cDisp = i_ForceDisparity?i_Disparity:r_jDisp;
	assign o_Rd = w_cDisp;
	assign o_KErr = r_KErr;
	always@(*)
		begin 
			case(i8_Din[4:0])
			5'b00000: r10_6bDCode<={pPOS,6'b011000,pNEG};
			5'b00001: r10_6bDCode<={pPOS,6'b100010,pNEG};
			5'b00010: r10_6bDCode<={pPOS,6'b010010,pNEG};
			5'b00011: r10_6bDCode<={pNEU,6'b110001,pNEU};
			5'b00100: r10_6bDCode<={pPOS,6'b001010,pNEG};
			5'b00101: r10_6bDCode<={pNEU,6'b101001,pNEU};
			5'b00110: r10_6bDCode<={pNEU,6'b011001,pNEU};
			5'b00111: r10_6bDCode<={pNEG,6'b111000,pNEU};
			5'b01000: r10_6bDCode<={pPOS,6'b000110,pNEG};
			5'b01001: r10_6bDCode<={pNEU,6'b100101,pNEU};
			5'b01010: r10_6bDCode<={pNEU,6'b010101,pNEU};
			5'b01011: r10_6bDCode<={pNEU,6'b110100,pNEU};
			5'b01100: r10_6bDCode<={pNEU,6'b001101,pNEU};
			5'b01101: r10_6bDCode<={pNEU,6'b101100,pNEU};
			5'b01110: r10_6bDCode<={pNEU,6'b011100,pNEU};
			5'b01111: r10_6bDCode<={pPOS,6'b101000,pNEG};
			5'b10000: r10_6bDCode<={pNEG,6'b011011,pPOS};
			5'b10001: r10_6bDCode<={pNEU,6'b100011,pNEU};
			5'b10010: r10_6bDCode<={pNEU,6'b010011,pNEU};
			5'b10011: r10_6bDCode<={pNEU,6'b110010,pNEU};
			5'b10100: r10_6bDCode<={pNEU,6'b001011,pNEU};
			5'b10101: r10_6bDCode<={pNEU,6'b101010,pNEU};
			5'b10110: r10_6bDCode<={pNEU,6'b011010,pNEU};
			5'b10111: r10_6bDCode<={pNEG,6'b111010,pPOS};
			5'b11000: r10_6bDCode<={pPOS,6'b001100,pNEG};
			5'b11001: r10_6bDCode<={pNEU,6'b100110,pNEU};
			5'b11010: r10_6bDCode<={pNEU,6'b010110,pNEU};
			5'b11011: r10_6bDCode<={pNEG,6'b110110,pPOS};
			5'b11100: r10_6bDCode<={pNEU,6'b001110,pNEU};
			5'b11101: r10_6bDCode<={pNEG,6'b101110,pPOS};
			5'b11110: r10_6bDCode<={pNEG,6'b011110,pPOS};
			5'b11111: r10_6bDCode<={pNEG,6'b101011,pPOS};
			endcase	
			
			case(i8_Din[4:0])
			5'b10111: r10_6bKCode<={pNEG,6'b111010,pPOS};
			5'b11011: r10_6bKCode<={pNEG,6'b110110,pPOS};
			5'b11100: r10_6bKCode<={pNEG,6'b001111,pPOS};
			5'b11101: r10_6bKCode<={pNEG,6'b101110,pPOS};
			5'b11110: r10_6bKCode<={pNEG,6'b011110,pPOS};
			default	: r10_6bKCode<={pERR,6'h3F,pERR};
			endcase
			
			if(i_Kin)
				begin 
					if(w_cDisp)	//Positive
						begin
							w_Compl6b <= 1'b1;
							w_iDisp <= 1'b0;
						end
					else 		//Negative
						begin
							w_Compl6b <= 1'b0;
							w_iDisp <= 1'b1;	//Positive					
						end				
				end
			else 
				begin
					if(w_cDisp)	//Positive
						begin
							w_Compl6b 	<= (r10_6bDCode[9:8]==pPOS||r10_6bDCode[9:8]==pNEU)?1'b0:1'b1;
							w_iDisp 	<= r10_6bDCode[1:0]==pNEU?1'b1:1'b0;
						end
					else 		//Negative
						begin
							w_Compl6b 	<= (r10_6bDCode[9:8]==pNEG||r10_6bDCode[9:8]==pNEU)?1'b0:1'b1;
							w_iDisp 	<= r10_6bDCode[1:0]==pNEU?1'b0:1'b1;
						end					
				end			
		end
		
		assign w_A7 = i_Kin|((r10_6bDCode[7]^w_Compl6b)&(r10_6bDCode[6]^w_Compl6b)&~w_iDisp)|(((~r10_6bDCode[7])^w_Compl6b)&((~r10_6bDCode[6])^w_Compl6b)&w_iDisp);
		
		always@(*)
		begin 
			if(w_A7 && i8_Din[7:5]==3'b111)
				r8_4bDCode<={pNEG,4'b0111,pPOS};
			else
			case(i8_Din[7:5])
			3'b000: r8_4bDCode<={pPOS,4'b0100,pNEG};
			3'b001: r8_4bDCode<={pNEU,4'b1001,pNEU};
			3'b010: r8_4bDCode<={pNEU,4'b0101,pNEU};
			3'b011: r8_4bDCode<={pNEG,4'b1100,pNEU};
			3'b100: r8_4bDCode<={pPOS,4'b0010,pNEG};
			3'b101: r8_4bDCode<={pNEU,4'b1010,pNEU};
			3'b110: r8_4bDCode<={pNEU,4'b0110,pNEU};
			3'b111: r8_4bDCode<={pNEG,4'b1110,pPOS};			
			endcase	
			
			if(w_A7 && i8_Din[7:5]==3'b111)
				r8_4bKCode<={pNEG,4'b0111,pPOS};
			else
			case(i8_Din[7:5])
			3'b000: r8_4bKCode<={pPOS,4'b0100,pNEG};
			3'b001: r8_4bKCode<={pPOS,4'b1001,pNEU};
			3'b010: r8_4bKCode<={pPOS,4'b0101,pNEU};
			3'b011: r8_4bKCode<={pNEG,4'b1100,pNEU};
			3'b100: r8_4bKCode<={pPOS,4'b0010,pNEG};
			3'b101: r8_4bKCode<={pPOS,4'b1010,pNEU};
			3'b110: r8_4bKCode<={pPOS,4'b0110,pNEU};
			3'b111: r8_4bKCode<={pNEG,4'b0111,pPOS};			
			default	: r8_4bKCode<={pERR,4'hF,pERR};
			endcase
			
			if(i_Kin)
				begin 
					if(w_iDisp)	//Positive
						begin
							w_Compl4b 	<= (r8_4bKCode[7:6]==pNEU||r8_4bKCode[7:6]==pPOS)?1'b0:1'b1;
							w_jDisp 	<= r8_4bKCode[1:0]==pNEU?1'b1:1'b0;
						end
					else 		//Negative
						begin
							w_Compl4b 	<= (r8_4bKCode[7:6]==pNEU||r8_4bKCode[7:6]==pNEG)?1'b0:1'b1;
							w_jDisp 	<= r8_4bKCode[1:0]==pNEU?1'b0:1'b1;		
						end				
					
				end
			else 
				begin
					if(w_iDisp)	//Positive
						begin
							w_Compl4b 	<= (r8_4bDCode[7:6]==pNEU||r8_4bDCode[7:6]==pPOS)?1'b0:1'b1;
							w_jDisp 	<= r8_4bDCode[1:0]==pNEU?1'b1:1'b0;
						end
					else 		//Negative
						begin
							w_Compl4b 	<= (r8_4bDCode[7:6]==pNEU||r8_4bDCode[7:6]==pNEG)?1'b0:1'b1;
							w_jDisp 	<= r8_4bDCode[1:0]==pNEU?1'b0:1'b1;
						end					
				end			
		end


endmodule 
