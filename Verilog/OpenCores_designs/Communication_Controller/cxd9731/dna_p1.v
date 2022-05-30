`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:48:37 03/14/2009 
// Design Name: 
// Module Name:    dna_p1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dna_p1(
    input ATV,					// Active and arm signal
    input CLK4,				// very fast clock
    output [63:0] DNA_64,		// 64 bit DNA code with check bits
    output reg DNA_Valid	// the code now is valid
);

reg 		dna_read,dna_shift,dna_clk;
wire 		dna_out;
reg	[5:0]	dna_counter;	// a six bit counter for the dna
reg	[3:0]	dna_ST;		// 4 bit state machine
reg	[5:0]	Adder1;		// a six bit result of bit adding
reg	Parity;				// a one bit result of parity
reg	[56:0] DNA_R;


parameter DnIdle	= 4'b0000;
parameter Dn01		= 4'b0001;
parameter Dn02		= 4'b0011;
parameter Dn03		= 4'b0010;
parameter Dn04		= 4'b0110;
parameter Dn10		= 4'b0111;
parameter Dn11		= 4'b0101;
parameter Dn12		= 4'b0100;
parameter Dn13		= 4'b1100;
parameter Dn20		= 4'b1101;
parameter Dn99		= 4'b1111;


assign	DNA_64[63:7] = DNA_R[56:0];
assign	DNA_64[6:1]	 = Adder1[5:0];
assign	DNA_64[0]	 = Parity;

always @(posedge CLK4) begin
if (ATV == 1'b0) begin
	dna_read		<= 0;
	dna_shift	<= 0;
	dna_clk		<= 0;
	dna_counter	<= 6'b00_0000;
	Adder1		<= 6'b00_0000;
	Parity		<= 1'b0;
	DNA_Valid	<= 1'b0;			// always not valid yet
	dna_ST		<= DnIdle;		// always idle now
end else begin
//// ========= State machine default state ======
	case (dna_ST)
	DnIdle: begin
		dna_read		<= 0;
		dna_shift	<= 0;
		dna_clk		<= 0;
		dna_counter	<= 6'b00_0000;
		Adder1		<= 6'b00_0000;
		Parity		<= 1'b0;
		DNA_Valid	<= 1'b0;			// always not valid yet
		dna_ST		<= Dn01;
	end
	Dn01	: begin
		dna_read		<= 1;			// raise the read port
		dna_ST		<= Dn02;
	end
	Dn02	: begin
		dna_clk		<= 1;			// rising edge of pulse, will clock the DNA port
		dna_ST		<= Dn03;
	end
	Dn03	: begin
		dna_clk		<= 0;			// remove clock pulse
		dna_ST		<= Dn04;
	end
	Dn04	: begin
		dna_read		<= 0;			// remove read signal, bit 57 will be in the output port
		dna_shift	<= 1;			// enable shift signal
		dna_ST		<= Dn10;
	end
//// =========== shift the DNA raw data now =======================
	Dn10	: begin
		DNA_R[55:0]	<= DNA_R[56:1];	// shift the register
		DNA_R[56]	<= dna_out;			// shift the register
		if (dna_out == 1'b1) begin
			Adder1	<= Adder1 + 1;
			Parity	<= ~Parity;
		end
		dna_ST		<= Dn11;
	end
	Dn11	: begin
		dna_counter	<= dna_counter + 1;		// add the counter
		dna_ST		<= Dn12;
	end
	Dn12	: begin
		dna_clk		<= 1'b1;			// rising edge
		dna_ST		<= Dn13;
	end
	Dn13	: begin
		dna_clk		<= 1'b0;			// falling edge
		if (dna_counter == 6'b11_1001) begin		// check 57 for 57 data
			dna_ST	<= Dn20;
		end else begin
			dna_ST	<= Dn10;					// loop back for the data
		end
	end
//// =========== compute final Parity now =======================
	Dn20	: begin
		Parity		<= Parity ^ Adder1[5] ^ Adder1[4] ^ Adder1[3] ^ Adder1[2] ^ Adder1[1] ^ Adder1[0];
		dna_ST		<= Dn99;
	end
//// =========== parity out now =======================
	Dn99	: begin
		DNA_Valid	<= 1'b1;			// say valid
		dna_ST		<= Dn99;			// loop forever
	end
//// ============================================
	default: begin
		dna_ST 		<= DnIdle;		// jump to idle for rouge states
	end
	endcase
end // ATV
end // clock edges
	
endmodule
