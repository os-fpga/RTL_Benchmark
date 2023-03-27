// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module nds_mux2 (O, A, B, S);
output  O;
input   A, B, S;

assign O = S ? B : A;
endmodule

module nds_mux3 (O, A, B, C, S0, S1);
output  O;
input   A, B, C, S0, S1;
reg     O;

always @(A or B or C or S0 or S1) begin
    case ({S1, S0})
        2'b00: O = A;
        2'b01: O = B;
        2'b10: O = C;
        2'b11: O = C;
	default: O = 1'bx;
    endcase
end
endmodule

module nds_mux4 (O, A, B, C, D, S0, S1);
output  O;
input   A, B, C, D;
input   S0, S1;
reg     O;

always @(A or B or C or D or S0 or S1) begin
    case ({S1, S0})
        2'b00: O = A;
        2'b01: O = B;
        2'b10: O = C;
        2'b11: O = D;
	default: O = 1'bx;
    endcase
end

endmodule

module nds_qdffsb (Q, D, CK, SB);
output  Q;
input   D;
input   CK, SB;
reg     Q;

always @(posedge CK or negedge SB) begin
    if (!SB)
        Q <= 1'b1;
    else
        Q <= D;
end

endmodule

module nds_qdffrb_2 (QB, D, CK, RB);
output  QB;
input   D;
input   CK, RB;
wire QB;
reg     Q;

assign QB = ~Q;
always @(posedge CK or negedge RB) begin
	    if (!RB)
		            Q <= 1'b0;
		        else
				        Q <= D;
			end

			endmodule


module nds_qdffrb (Q, D, CK, RB);
output  Q;
input   D;
input   CK, RB;
reg     Q;

always @(posedge CK or negedge RB) begin
    if (!RB)
        Q <= 1'b0;
    else
        Q <= D;
end

endmodule

module nds_qdffrsb (Q, D, RB, SB, CK);
output  Q;
input   D;
input   RB, SB;
input   CK;
reg     Q;

always @(posedge CK or negedge RB or negedge SB) begin
    if (!RB)
        Q <= 1'b0;
    else if (!SB)
        Q <= 1'b1;
    else
        Q <= D;
end

endmodule

module nds_dffsb (Q, QB, D, CK, SB);
output  Q, QB;
input   D;
input   CK, SB;
reg     Q;

assign QB = ~Q;
always @(posedge CK or negedge SB) begin
    if (!SB)
        Q <= 1'b1;
    else
        Q <= D;
end

endmodule

module nds_dffrb (Q, QB, D, CK, RB);
output  Q, QB;
input   D;
input   CK, RB;
reg     Q;

assign QB = ~Q;
always @(posedge CK or negedge RB) begin
    if (!RB)
        Q <= 1'b0;
    else
        Q <= D;
end
endmodule

module nds_an2 (O, I1, I2);
output  O;
input   I1, I2;

assign O = I1 & I2;

endmodule

module nds_an2b1 (O, I1, B1);
output  O;
input   I1, B1;

assign O = I1 & (!B1);

endmodule

module nds_or2 (O, I1, I2);
output  O;
input   I1, I2;

assign O = I1 || I2;

endmodule

module nds_or3 (O, I1, I2, I3);
output  O;
input   I1, I2, I3;

assign O = I1 || I2 || I3;

endmodule

module nds_buf (O, I);
output  O;
input   I;

assign O = I;

endmodule

module nds_inv (O, I);
output  O;
input   I;

assign O = ~I;

endmodule

