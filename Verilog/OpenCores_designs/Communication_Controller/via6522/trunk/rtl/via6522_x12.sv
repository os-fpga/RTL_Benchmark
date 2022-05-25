// ============================================================================
//        __
//   \\__/ o\    (C) 2004-2022  Robert Finch, Waterloo
//    \  __ /    All rights reserved.
//     \/_//     robfinch<remove>@finitron.ca
//       ||
//
//	via6522_x12.sv
//
// This source file is free software: you can redistribute it and/or modify 
// it under the terms of the GNU Lesser General Public License as published 
// by the Free Software Foundation, either version 3 of the License, or     
// (at your option) any later version.                                      
//                                                                          
// This source file is distributed in the hope that it will be useful,      
// but WITHOUT ANY WARRANTY; without even the implied warranty of           
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            
// GNU General Public License for more details.                             
//                                                                          
// You should have received a copy of the GNU General Public License        
// along with this program.  If not, see <http://www.gnu.org/licenses/>.    
//                                                                          
// ============================================================================

`define PB		5'd0
`define PA		5'd1
`define DDRB	5'd2
`define DDRA	5'd3
`define T1CL	5'd4
`define T1CH	5'd5
`define T1LL	5'd6
`define T1LH	5'd7
`define T2CL	5'd8
`define T2CH	5'd9
`define SR		5'd10
`define ACR		5'd11
`define PCR		5'd12
`define IFR		5'd13
`define IER		5'd14
`define ORA		5'd15
`define T3CL	5'd16
`define T3CH	5'd17
`define T3LL	5'd18
`define T3LH	5'd19
`define T3CMPL	5'd20
`define T3CMPH	5'd21

module via6522_x12 (rst_i, clk_i, wc_clk_i, irq_o, cs_i,
	cyc_i, stb_i, ack_o, we_i, adr_i, dat_i, dat_o, 
	ca1, ca2_i, ca2_o, ca2_t, cb1_i, cb1_o, cb1_t, cb2_i, cb2_o, cb2_t,
	pa_i, pb_i, pa_o, pb_o, pa_t, pb_t,
	t1_if, t2_if, t3_if
	);
parameter pBitsPerByte=12;
input rst_i;
input clk_i;
input wc_clk_i;
output reg irq_o;
input cs_i;
input cyc_i;
input stb_i;
output ack_o;
input we_i;
input [4:0] adr_i;
input [pBitsPerByte-1:0] dat_i;
output reg [pBitsPerByte-1:0] dat_o;

input ca1;
input ca2_i;
output ca2_o;
output ca2_t;
input cb1_i;
output cb1_o;
output cb1_t;
input cb2_i;
output cb2_o;
output cb2_t;
input [pBitsPerByte-1:0] pa_i;
input [pBitsPerByte-1:0] pb_i;
output [pBitsPerByte-1:0] pa_o;
output [pBitsPerByte-1:0] pb_o;
output reg [pBitsPerByte-1:0] pa_t;
output reg [pBitsPerByte-1:0] pb_t;

output reg t1_if;							// timer 1 interrupt flag
output reg t2_if;							// timer 2 interrupt flag
output reg t3_if;							// timer 3 interrupt flag

integer n;

wire cs = cs_i & cyc_i & stb_i;

ack_gen #(
	.READ_STAGES(2),
	.WRITE_STAGES(0),
	.REGISTER_OUTPUT(1)
) uag1
(
	.rst_i(rst_i),
	.clk_i(clk_i),
	.ce_i(1'b1),
	.i(cs),
	.we_i(cs & we_i),
	.o(ack_o),
	.rid_i(0),
	.wid_i(0),
	.rid_o(),
	.wid_o()
);

reg [5:0] ie_delay;
reg [8:0] ier, ierd;	  // interrupt enable register / delayed interrupt enable register
reg [pBitsPerByte-1:0] pai, pbi;		// input registers
reg [pBitsPerByte-1:0] pao, pbo;		// output latches
reg [pBitsPerByte-1:0] pal, pbl;		// input latches
reg pa_le, pb_le;				// latching enable
reg [pBitsPerByte-1:0] ddra, ddrb;	// data direction registers
reg cb1o, cb2o, ca2o;
reg [1:0] t1_mode;
reg t2_mode;
reg t3_mode;
reg [pBitsPerByte*2-1:0] t1, t2, t3;	// 24 bit timers
reg [pBitsPerByte*2-1:0] t3cmp;
reg t3_access;
reg t1_64, t2_64;
reg [pBitsPerByte*2-1:0] t1l;
reg [pBitsPerByte*2-1:0] t2l;
reg [pBitsPerByte*2-1:0] t3l;
wire ca1_trans, ca2_trans;	// active transitions
wire cb1_trans, cb2_trans;
reg ca1_mode;
reg cb1_mode;
reg [2:0] ca2_mode;
reg [2:0] cb2_mode;
reg [4:0] sr_cnt;				// shift register counter
reg [pBitsPerByte-1:0] sr;					// shift register
reg sr_32;							// shift register 32 bit mode
reg [2:0] sr_mode;			// shift register mode
reg sr_if;
wire ca1_pe, ca1_ne, ca1_ee;
wire ca2_pe, ca2_ne, ca2_ee;
wire cb1_pe, cb1_ne, cb1_ee;
reg ca1_if, cb1_if;
reg ca2_if, cb2_if;
wire pb6_ne;
reg ca1_irq, ca2_irq;
reg cb1_irq, cb2_irq;
reg t1_irq, t2_irq, t3_irq;
reg sr_irq;
wire pe_t1z, pe_t2z, pe_t3z;

edge_det ued1 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(ca1), .pe(ca1_pe), .ne(ca1_ne), .ee(ca1_ee));
edge_det ued2 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(ca2_i), .pe(ca2_pe), .ne(ca2_ne), .ee(ca2_ee));
edge_det ued3 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(cb1_i), .pe(cb1_pe), .ne(cb1_ne), .ee(cb1_ee));
edge_det ued4 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(cb2_i), .pe(cb2_pe), .ne(cb2_ne), .ee(cb2_ee));
edge_det ued5 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(pb_i[10]), .pe(), .ne(pb6_ne), .ee());
edge_det ued6 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(t3=={pBitsPerByte*2{1'd0}}), .pe(pe_t3z), .ne(), .ee());
edge_det ued7 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(t2=={pBitsPerByte*2{1'd0}}), .pe(pe_t2z), .ne(), .ee());
edge_det ued8 (.rst(rst_i), .clk(clk_i), .ce(1'b1), .i(t1=={pBitsPerByte*2{1'd0}}), .pe(pe_t1z), .ne(), .ee());


assign ca1_trans = (ca1_mode & ca1_pe) | (~ca1_mode & ca1_ne);
assign ca2_trans = (ca2_mode[2:1]==2'b00&&ca2_ne)||(ca2_mode[2:1]==2'b01&&ca2_pe);
assign cb1_trans = (cb1_mode & cb1_pe) | (~cb1_mode & cb1_ne);
assign cb2_trans = (cb2_mode[2:1]==2'b00&&cb2_ne)||(cb2_mode[2:1]==2'b01&&cb2_pe);

reg wr_t3;

always @(posedge wc_clk_i)
if (rst_i)
	t3 <= {pBitsPerByte*2{1'd1}};
else begin
	t3 <= t3 + 2'd1;
	if (wr_t3)
		t3 <= t3l;
end

always @(posedge clk_i)
if (rst_i) begin
	ddra <= {pBitsPerByte{1'd0}};
	ddrb <= {pBitsPerByte{1'd0}};
	ca1_irq <= 1'b0;
	ca2_irq <= 1'b0;
	cb1_irq <= 1'b0;
	cb2_irq <= 1'b0;
	ca2o <= 1'b0;
	cb1o <= 1'b0;
	cb2o <= 1'b0;
	t1_64 <= 1'b0;
	t2_64 <= 1'b0;
	sr_mode <= 3'b000;
	sr_32 <= 1'b0;
	sr_if <= 1'b0;
	t1 <= {pBitsPerByte*2{1'd1}};
	t1_if <= 1'b0;
	t2 <= {pBitsPerByte*2{1'd1}};
	t2_if <= 1'b0;
	t3_if <= 1'b0;
	t3_access <= 1'b0;
	wr_t3 <= 1'b0;
	ier <= 9'h00;
	ie_delay <= 6'h00;
end
else begin
  
  if (ie_delay!=6'h00)
    ie_delay <= ie_delay - 2'd1;
  if (ie_delay==6'h01)
    ier <= ierd;

	// Port A,B input latching
	// Port A input latches always reflect the input pins.
	if (pa_le) begin
		if (ca1_trans)
			pai <= pa_i;
	end
	else
		pai <= pa_i;

	// Port B input latches reflect the contents of the output register if the
	// port pin direction is an output.
	if (pb_le) begin
		if (cb1_trans)
			for (n = 0; n < 12; n = n + 1)
				pbi <= ddrb[n] ? pbo[n] : pb_i[n];
	end
	else begin
		for (n = 0; n < 12; n = n + 1)
			pbi <= ddrb[n] ? pbo[n] : pb_i[n];
	end

 	// Bring ca2 back high on pulse output mode
 	if (ca2_mode==3'b100 && ca1_trans)
 		ca2o <= 1'b1;
 	else if (ca2_mode==3'b101)
 		ca2o <= 1'b1;
	
	t1 <= t1 - 2'd1;
	if (pe_t1z) begin
		t1_if <= 1'b1;
		case(t1_mode)
		2'd1:	t1 <= t1l;
		2'd2:	
			begin
				pbo[pBitsPerByte-1] <= 1'b1;
				ier[5] <= 1'b0;
			end
		2'd3:	
			begin
				pbo[pBitsPerByte-1] <= ~pbo[pBitsPerByte-1];
				t1 <= t1l;
			end
		default:	;
		endcase
	end

	case(t2_mode)
	1'd0:	t2 <= t2 - 2'd1;
	1'd1:	if (pb6_ne) t2 <= t2 - 2'd1;
	endcase
	if (pe_t2z) begin
		t2_if <= 1'b1;
		if (t2_mode==1'b0)
			ier[6] <= 1'b0;
	end

	// If counting up interrupt on count greater than or equal to compare
	// register.
	if (t3cmp <= t3) begin
		if (t3_mode==1'b0 && pBitsPerByte > 8)
			ier[7] <= 1'b0;
		t3_if <= 1'b1;
	end
	else
		t3_if <= 1'b0;
		
	if (wr_t3) begin
		if (t3==t3l)
			wr_t3 <= 1'b0;
	end

	case(sr_mode)
	3'b000:	;
	3'b001:
		begin
			if (cb1_ne) begin
				sr_cnt <= sr_cnt - 2'd1;
				sr <= {sr[pBitsPerByte-2:0],cb2_i};
				if (sr_cnt==5'd0)
					sr_if <= 1'b1;
			end
		end
	3'b010:
		begin
			if (cb1_ne) begin
				sr_cnt <= sr_cnt - 2'd1;
				sr <= {sr[pBitsPerByte-2:0],cb2_i};
				if (sr_cnt==5'd0)
					sr_if <= 1'b1;
			end
		end
	3'b011:
		begin
			if (cb1_ne) begin
				sr_cnt <= sr_cnt - 2'd1;
				sr <= {sr[pBitsPerByte-2:0],cb2_i};
				if (sr_cnt==5'd0)
					sr_if <= 1'b1;
			end
		end
	3'b100:
		if (t2[11:0]==12'h00) begin
			if (cb1_ne) begin
				sr <= {sr[pBitsPerByte-2:0],sr[pBitsPerByte-1]};
			end
		end
	3'b101:
		if (t2[11:0]==12'h00) begin
			if (sr_cnt != 5'd0) begin
				if (cb1_ne) begin
					sr_cnt <= sr_cnt - 2'd1;
					sr <= {sr[pBitsPerByte-2:0],sr[pBitsPerByte-1]};
					if (sr_cnt==5'd1)
						sr_if <= 1'b1;
				end
			end
		end
	3'b110:
		if (sr_cnt != 5'd0) begin
			if (cb1_ne) begin
				sr_cnt <= sr_cnt - 2'd1;
				sr <= {sr[pBitsPerByte-2:0],sr[pBitsPerByte-1]};
				if (sr_cnt==5'd1)
					sr_if <= 1'b1;
			end
		end
	3'b111:
		if (cb1_ne) begin
			sr_cnt <= sr_cnt - 2'd1;
			sr <= {sr[pBitsPerByte-2:0],sr[pBitsPerByte-1]};
			if (sr_cnt==5'd1)
				sr_if <= 1'b1;
		end
	endcase

	// CB1 output
	case(sr_mode)
	3'b000:	;
	3'b001:
		if (t2[pBitsPerByte-1:0]=={pBitsPerByte{1'b0}})
			cb1o <= ~cb1o;
	3'b010:	cb1o <= ~cb1o;
	3'b011:	;	// used as input
	3'b100:
		if (t2[pBitsPerByte-1:0]=={pBitsPerByte{1'b0}})
			cb1o <= ~cb1o;
	3'b101:
		if (t2[pBitsPerByte-1:0]=={pBitsPerByte{1'b0}}) begin
			if (sr_cnt != 5'd0)
				cb1o <= ~cb1o;
		end
	3'b110:
		if (sr_cnt != 5'd0)
			cb1o <= ~cb1o;
	3'b111:	;	// used as input
	endcase

	// CB2 output
	case(sr_mode)
	3'b000,3'b001,3'b010,3'b011:
	 	if (cb2_mode==3'b100 && cb1_trans)
	 		cb2o <= 1'b1;
	 	else if (cb2_mode==3'b101)
	 		cb2o <= 1'b1;
	3'b100:
		if (t2[pBitsPerByte-1:0]=={pBitsPerByte{1'b0}}) begin
			if (cb1_ne)
				cb2o <= sr[pBitsPerByte-1];
		end
	3'b101:
		if (t2[pBitsPerByte-1:0]=={pBitsPerByte{1'b0}}) begin
			if (sr_cnt != 5'd0) begin
				if (cb1_ne)
					cb2o <= sr[pBitsPerByte-1];
			end
			if (sr_cnt==5'd0)
				cb2o <= cb2_mode[0];
		end
	3'b110:
		if (sr_cnt != 5'd0) begin
			if (cb1_ne)
				cb2o <= sr[pBitsPerByte-1];
		end
	3'b111:
		if (cb1_ne)
			cb2o <= sr[pBitsPerByte-1];
	endcase

	if (cs) begin
		if (we_i) begin
			case(adr_i)
			`PA:
				begin
					pao <= dat_i;
			 		if (ca2_mode==3'b100||ca2_mode==3'b101)
			 			ca2o <= 1'b0;
			 		ca1_if <= 1'b0;
			 		ca2_if <= 1'b0;
				end
			`PB:
				begin
					pbo <= dat_i;
			 		if (cb2_mode==3'b100||cb2_mode==3'b101)
			 			cb2o <= 1'b0;
			 		cb1_if <= 1'b0;
			 		cb2_if <= 1'b0;
				end
			`DDRA:	
				begin
					ddra <= dat_i;
				end
			`DDRB:	
				begin
					ddrb <= dat_i;
				end
			`T1CL:
				begin
					t1l[pBitsPerByte-1:0] <= dat_i;
				end
			`T1CH:
				begin
					t1 <= {dat_i[pBitsPerByte-1:0],t1l[pBitsPerByte-1:0]};
					t1_if <= 1'b0;
					if (t1_mode[1]==1'b1)
						pbo[11] <= 1'b0;
				end	
			`T1LL:
				begin
					t1l[pBitsPerByte-1:0] <= dat_i;
				end
			`T1LH:
				begin
					t1l[pBitsPerByte*2-1:pBitsPerByte] <= {{pBitsPerByte{1'd0}},dat_i};
					t1_if <= 1'b0;
				end
			`T2CL:
				begin
					t2l[pBitsPerByte-1:0] <= dat_i;
				end
			`T2CH:
				begin
					t2 <= {dat_i,t2l[pBitsPerByte-1:0]};
					t2_if <= 1'b0;
				end	
			`PCR:
				begin
					ca1_mode <= dat_i[0];
					ca2_mode <= dat_i[3:1];
			 		cb1_mode <= dat_i[4];
			 		cb2_mode <= dat_i[7:5];
		 		end
			`SR:
				begin	
					sr <= dat_i;
					sr_cnt <= 5'd11;
					if (sr_mode==3'b001)
						cb1o <= 1'b1;
					sr_if <= 1'b0;						
				end
			`ACR:
				begin
					pa_le <= dat_i[0];
					pb_le <= dat_i[1];
					sr_mode <= dat_i[4:2];
					t2_mode <= dat_i[5];
					t1_mode <= dat_i[7:6];
					if (pBitsPerByte > 8)
						t3_mode <= dat_i[8];
				end
			`IER:
				begin
					if (pBitsPerByte==8) begin
						if (dat_i[pBitsPerByte-1])
							ierd[6:0] <= ier[6:0] | dat_i[6:0];
						else
							ierd[6:0] <= ier[6:0] & ~dat_i[6:0];
					end
					else begin
						if (dat_i[pBitsPerByte-1])
							ierd[7:0] <= ier[7:0] | dat_i[7:0];
						else
							ierd[7:0] <= ier[7:0] & ~dat_i[7:0];
					end
					ier[pBitsPerByte-1] <= 1'b0;
				  ie_delay <= 6'h01;
				end
			`ORA:
				begin
					pao <= dat_i;
				end
			`T3CL:	;
			`T3CH:	;
			`T3LL:
				begin
					t3l[pBitsPerByte-1:0] <= dat_i;
				end
			`T3LH:
				begin
					t3l[pBitsPerByte*2-1:pBitsPerByte] <= dat_i;
					wr_t3 <= 1'b1;
					t3_if <= 1'b0;
				end
			`T3CMPL:
				begin
					t3cmp[pBitsPerByte-1:0] <= dat_i;
				end
			`T3CMPH:
				begin
					t3cmp[pBitsPerByte*2-1:pBitsPerByte] <= dat_i;
				end
			endcase
			dat_o <= {pBitsPerByte{1'h0}};
		end	
		else begin
			case(adr_i)
			`PA:
				begin
					dat_o <= pai;
			 		if (ca2_mode==3'b100||ca2_mode==3'b101)
			 			ca2o <= 1'b0;
			 		ca1_if <= 1'b0;
			 		ca2_if <= 1'b0;
				end
			`PB:	
				begin
					dat_o <= pbi;
					cb1_if <= 1'b0;
					cb2_if <= 1'b0;
				end
			`DDRA:	dat_o <= ddra;
			`DDRB:	dat_o <= ddrb;
			`T1CL:
				begin
					dat_o <= t1[pBitsPerByte-1:0];
					t1_if <= 1'b0;
				end
			`T1CH:
				dat_o <= t1[pBitsPerByte*2-1:pBitsPerByte];
			`T1LL:	
				dat_o <= t1l[pBitsPerByte-1:0];
			`T1LH:
				dat_o <= t1l[pBitsPerByte*2-1:pBitsPerByte];
			`T2CL:	
				begin
					dat_o <= t2[pBitsPerByte-1:0];
					t2_if <= 1'b0;
				end
			`T2CH:
				dat_o <= t2[pBitsPerByte*2-1:pBitsPerByte];
			`PCR:	dat_o <= {4'd0,cb2_mode,cb1_mode,ca2_mode,ca1_mode};
			`SR:
				begin	
					dat_o <= sr;
					if (sr_mode==3'b001)
						cb1o <= 1'b1;
					sr_cnt <= 5'd11;
					sr_if <= 1'b0;
				end
			`ACR:	dat_o <= pBitsPerByte==8 ? {t1_mode,t2_mode,sr_mode,pb_le,pa_le} : {3'd0,t3_mode,t1_mode,t2_mode,sr_mode,pb_le,pa_le};
			`IFR:	dat_o <= pBitsPerByte==8 ? {irq_o,t2_irq,t1_irq,cb1_irq,cb2_irq,sr_irq,ca1_irq,ca2_irq} :
																			 {irq_o,3'd0,t3_irq,t2_irq,t1_irq,cb1_irq,cb2_irq,sr_irq,ca1_irq,ca2_irq};
			`IER:	dat_o <= {3'd0,ier};
			`ORA:	dat_o <= pai;
			`T3CL:
				begin	
					dat_o <= t3[pBitsPerByte-1:0];
					t3_if <= 1'b0;
				end
			`T3CH:
				dat_o <= t3[pBitsPerByte*2-1:pBitsPerByte];
			`T3LL:	
				dat_o <= t3l[pBitsPerByte-1:0];
			`T3LH:
				dat_o <= t3l[pBitsPerByte*2-1:pBitsPerByte];
			`T3CMPL:
				dat_o <= t3cmp[pBitsPerByte-1:0];
			`T3CMPH:
				dat_o <= t3cmp[pBitsPerByte*2-1:pBitsPerByte];
			default:	dat_o <= {pBitsPerByte{1'h0}};
			endcase
		end
	end
	// Allows wire-or of data bus
	else
		dat_o <= {pBitsPerByte{1'h0}};

	ca2_irq <= ca2_trans & ier[0];
	ca1_irq <= ca1_trans & ier[1];
	sr_irq <= sr_if & ier[2];
	cb2_irq <= cb2_trans & ier[3];
	cb1_irq <= cb1_trans & ier[4];
	t1_irq <= t1_if & ier[5];
	t2_irq <= t2_if & ier[6];
	if (pBitsPerByte > 8)
		t3_irq <= t3_if & ier[7];
	else
		t3_irq <= 1'b0;

	irq_o <=
		  (ca2_trans & ier[0])
		| (ca1_trans & ier[1])
		| (sr_if & ier[2])
		| (cb2_trans & ier[3])
		| (cb1_trans & ier[4])
		| (t1_if & ier[5])
		| (t2_if & ier[6])
		| ((t3_if & ier[7]) && pBitsPerByte > 8)
		;
end

// Outputs

genvar g;
generate begin : gPorts
	for (g = 0; g < pBitsPerByte; g = g + 1) begin
		assign pa_t[g] = ddra[g];
	end
		
	for (g = 0; g < pBitsPerByte; g = g + 1) begin
		assign pb_t[g] = ddrb[g];
	end
end
endgenerate

// CA1 is always an input

// CA2,CB1,CB2 output enables

assign ca2_t = ca2_mode[2]==1'b0;
assign ca2_o = ca2_mode==3'b100 ? ca2o :
						 	ca2_mode==3'b101 ? ca2o :
						 	ca2_mode==3'b110 ? 1'b0 :
						 	1'b1;

assign cb1_t = sr_mode==3'b000 || sr_mode==3'b011 || sr_mode==3'b111;
assign cb1_o = cb1o;

assign cb2_t = sr_mode[2]==1'b0 && cb2_mode[2]==1'b0;
assign cb2_o = sr_mode[2]==1'b0 ? (
							cb2_mode[2]==1'b0 ? 1'b1 :
							cb2_mode==3'b100 ? cb2o :
							cb2_mode==3'b101 ? cb2o :
							cb2_mode==3'b110 ? 1'b0 :
							1'b1) :
							cb2o;

assign pa_o = pao;
assign pb_o = pbo;
							
endmodule
