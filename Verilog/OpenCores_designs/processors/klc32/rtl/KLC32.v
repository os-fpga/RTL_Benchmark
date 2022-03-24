// ============================================================================
// (C) 2011 Robert Finch
// All Rights Reserved.
// robfinch<remove>@opencores.org
//
// KLC32.v
//  - 32 bit CPU
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
//
`define STACK_VECTOR	32'h00000000
`define RESET_VECTOR	32'h00000004
`define NMI_VECTOR		32'h0000007C
`define IRQ_VECTOR		32'h00000064
`define TRAP_VECTOR		32'h00000080
`define TRAPV_VECTOR	32'h0000001C
`define TRACE_VECTOR	32'h00000024
`define BUS_ERR_VECTOR	32'h00000008
`define ILLEGAL_INSN	32'h00000010
`define PRIVILEGE_VIOLATION	32'h00000020

`define MISC	6'd0
`define JMP32		6'd32
`define JSR32		6'd33
`define RTS			6'd34
`define RTI			6'd35
`define TRACE_ON	6'd48
`define TRACE_OFF	6'd49
`define USER_MODE	6'd50
`define SET_IM		6'd51
`define RST			6'd52
`define STOP		6'd53
`define R		6'd1
`define ABS			6'd1
`define SGN			6'd2
`define NEG			6'd3
`define NOT			6'd4
`define EXTB		6'd5
`define EXTH		6'd6
`define UNLK		6'd24
`define MTSPR		6'd32
`define MFSPR		6'd33
`define MOV_CRn2CRn	6'd48
`define MOV_CRn2REG	6'd49
`define MOV_REG2CRn	6'd50
`define EXEC		6'd63
`define RR		6'd2
`define ADD			6'd4
`define SUB			6'd5
`define CMP			6'd6
`define AND			6'd8
`define OR			6'd9
`define EOR			6'd10
`define ANDC		6'd11
`define NAND		6'd12
`define NOR			6'd13
`define ENOR		6'd14
`define ORC			6'd15
`define SHL			6'd16
`define SHR			6'd17
`define ROL			6'd18
`define ROR			6'd19
`define JMP_RR		6'd20
`define JSR_RR		6'd21
`define MAX			6'd22
`define MIN			6'd23
`define MULU		6'd24
`define MULUH		6'd25
`define MULS		6'd26
`define MULSH		6'd27
`define DIVU		6'd28
`define DIVS		6'd29
`define MODU		6'd30
`define MODS		6'd31
`define LWX			6'd48
`define LHX			6'd49
`define LBX			6'd50
`define LHUX		6'd51
`define LBUX		6'd52
`define SWX			6'd56
`define SHX			6'd57
`define SBX			6'd58
`define BCDADD		6'd60
`define BCDSUB		6'd61
`define RRR		6'd3
`define ADDI	6'd4
`define SUBI	6'd5
`define CMPI	6'd6
`define ANDI	6'd8
`define ORI		6'd9
`define EORI	6'd10
`define MULUI	6'd12
`define MULSI	6'd13
`define DIVUI	6'd14
`define DIVSI	6'd15
`define Bcc		6'd16
`define BRA			4'd0
`define BRN			4'd1
`define BHI			4'd2
`define BLS			4'd3
`define BHS			4'd4
`define BLO			4'd5
`define BNE			4'd6
`define BEQ			4'd7
`define BVC			4'd8
`define BVS			4'd9
`define BPL			4'd10
`define BMI			4'd11
`define BGE			4'd12
`define BLT			4'd13
`define BGT			4'd14
`define BLE			4'd15
`define TRAPcc	6'd17
`define TRAP		4'd0
`define TRN			4'd1
`define THI			4'd2
`define TLS			4'd3
`define THS			4'd4
`define TLO			4'd5
`define TNE			4'd6
`define TEQ			4'd7
`define TVC			4'd8
`define TVS			4'd9
`define TPL			4'd10
`define TMI			4'd11
`define TGE			4'd12
`define TLT			4'd13
`define TGT			4'd14
`define TLE			4'd15
`define SETcc	6'd18
`define SET			4'd0
`define STN			4'd1
`define SHI			4'd2
`define SLS			4'd3
`define SHS			4'd4
`define SLO			4'd5
`define SNE			4'd6
`define SEQ			4'd7
`define SVC			4'd8
`define SVS			4'd9
`define SPL			4'd10
`define SMI			4'd11
`define SGE			4'd12
`define SLT			4'd13
`define SGT			4'd14
`define SLE			4'd15
`define CRxx	6'd19
`define ANDI_CCR	5'd8
`define ORI_CCR		5'd9
`define EORI_CCR	5'd10
`define CROR		10'd449
`define CRORC		10'd417
`define CRAND		10'd257
`define CRANDC		10'd129
`define CRXOR		10'd193
`define CRNOR		10'd33
`define CRNAND		10'd225
`define CRXNOR		10'd289
`define JMP		6'd20
`define JSR		6'd21

`define TAS		6'd46
`define LW		6'd48
`define LH		6'd49
`define LB		6'd50
`define LHU		6'd51
`define LBU		6'd52
`define POP		6'd53
`define LINK	6'd54
`define PEA		6'd55
`define SW		6'd56
`define SH		6'd57
`define SB		6'd58
`define PUSH	6'd59
`define NOP		6'd60

module KLC32(rst_i, clk_i, ipl_i, vpa_i, halt_i, inta_o, fc_o, rst_o, cyc_o, stb_o, ack_i, err_i, sel_o, we_o, adr_o, dat_i, dat_o);
parameter IFETCH = 8'd1;
parameter REGFETCHA = 8'd2;
parameter REGFETCHB = 8'd3;
parameter EXECUTE = 8'd4;
parameter MEMORY1 = 8'd5;
parameter MEMORY1_ACK = 8'd6;
parameter WRITEBACK = 8'd7;
parameter JSR1 = 8'd10;
parameter JSR2 = 8'd11;
parameter JSRShort = 8'd12;
parameter RTS = 8'd13;
parameter JMP = 8'd14;
parameter LOAD_SP = 8'd15;
parameter VECTOR = 8'd16;
parameter INTA = 8'd20;
parameter FETCH_VECTOR = 8'd21;
parameter TRAP1 = 8'd22;
parameter TRAP2 = 8'd23;
parameter TRAP3 = 8'd24;
parameter RTI1 = 8'd25;
parameter RTI2 = 8'd26;
parameter RTI3 = 8'd27;
parameter TRAP = 8'd28;
parameter RESET = 8'd29;
parameter JSR32 = 8'd30;
parameter JMP32 = 8'd31;
parameter WRITE_FLAGS = 8'd32;
parameter FETCH_IMM32 = 8'd33;
parameter REGFETCHC = 8'd34;
parameter PUSH1 = 8'd35;
parameter PUSH2 = 8'd36;
parameter PUSH3 = 8'd37;
parameter POP1 = 8'd38;
parameter POP2 = 8'd39;
parameter POP3 = 8'd40;
parameter LINK = 8'd41;
parameter UNLK = 8'd42;
parameter TAS = 8'd43;
parameter TAS2 = 8'd44;
parameter PEA = 8'd45;
parameter MULTDIV1 = 8'd49;
parameter MULTDIV2 = 8'd50;
parameter MULT1 = 8'd51;
parameter MULT2 = 8'd52;
parameter MULT3 = 8'd53;
parameter MULT4 = 8'd54;
parameter MULT5 = 8'd55;
parameter MULT6 = 8'd56;
parameter MULT7 = 8'd57;
parameter DIV1 = 8'd61;
parameter DIV2 = 8'd62;
input rst_i;
input clk_i;
input [2:0] ipl_i;
input vpa_i;
input halt_i;
output inta_o;
reg inta_o;
output [2:0] fc_o;
reg [2:0] fc_o;
output rst_o;
output cyc_o;
reg cyc_o;
output stb_o;
reg stb_o;
input ack_i;
input err_i;
output we_o;
reg we_o;
output [3:0] sel_o;
reg [3:0] sel_o;
output [31:0] adr_o;
reg [31:0] adr_o;
input [31:0] dat_i;
output [31:0] dat_o;
reg [31:0] dat_o;

reg cpu_clk_en;
reg clk_en;
wire clk;

reg [7:0] state;
reg [31:0] ir;
reg tf,sf;
reg [31:0] pc;
reg [31:0] usp,ssp;
reg [31:0] ctr;
wire [5:0] opcode=ir[31:26];
reg Rcbit;
reg [5:0] mopcode;
wire [5:0] func=ir[5:0];
wire [9:0] func1=ir[10:1];
wire [3:0] cond=ir[19:16];
wire [31:0] brdisp = {{16{ir[15]}},ir[15:2],2'b0};
reg [4:0] Rn;
reg [31:0] regfile [31:0];
wire [31:0] rfo1 = regfile[Rn];
wire [31:0] rfo = (Rn==5'd0) ? 32'd0 : (Rn==5'd31) ? (sf ? ssp : usp) : rfo1;
reg vf,nf,cf,zf;
reg xer_ov,xer_ca,xer_so;
reg [2:0] im;
reg [2:0] iplr;
reg [7:0] vecnum;
reg [31:0] vector;
reg [31:0] ea;
reg [15:0] rstsh;
assign rst_o = rstsh[15];
reg prev_nmi;
reg nmi_edge;
reg [31:0] sr1;
reg [31:0] tgt;
reg [31:0] a,b,c,imm,aa,bb;
wire signed [31:0] as = a;
wire signed [31:0] bs = b;
reg [31:0] res;
reg [3:0] cr0,cr1,cr2,cr3,cr4,cr5,cr6,cr7;
wire [31:0] cr = {cr7,cr6,cr5,cr4,cr3,cr2,cr1,cr0};
wire [31:0] sr = {tf,1'b0,sf,2'b00,im,16'd0};
reg [31:0] tick;
reg [31:0] be_addr;

reg [5:0] cnt;
reg [31:0] div_r0;
reg [31:0] div_q0;
reg [31:0] div_q,div_r;
wire [32:0] div_dif = div_r0 - bb;

wire IsSubi = opcode==`SUBI;
wire IsCmpi = opcode==`CMPI;
wire IsSub = opcode==`RR && func==`SUB;
wire IsCmp = opcode==`RR && func==`CMP;
wire IsNeg = opcode==`R && func==`NEG;
wire IsDivi = opcode==`DIVUI || opcode==`DIVSI;
wire IsDivu = opcode==`DIVUI || (opcode==`RR && (func==`DIVU || func==`MODU));
wire IsMult = opcode==`MULUI || opcode==`MULSI || (opcode==`RR && (func==`MULU || func==`MULS || func==`MULUH || func==`MULSH));
wire IsDiv = opcode==`DIVUI || opcode==`DIVSI || (opcode==`RR && (func==`DIVU || func==`DIVS || func==`MODU || func==`MODS));

wire hasConst16 = 
	opcode==`ADDI || opcode==`SUBI || opcode==`CMPI ||
	opcode==`ANDI || opcode==`ORI || opcode==`EORI ||
	opcode==`LW || opcode==`LH || opcode==`LB || opcode==`LHU || opcode==`LBU ||
	opcode==`SW || opcode==`SH || opcode==`SB ||
	opcode==`PEA || opcode==`TAS || opcode==`LINK
	;
wire isStop =
	opcode==`MISC && (func==`STOP)
	;

wire c_ri,c_rr;
wire v_ri,v_rr;
carry u1 (.op(IsSubi|IsCmpi), .a(a[31]), .b(imm[31]), .s(res[31]), .c(c_ri));
carry u2 (.op(IsSub|IsCmp|IsNeg), .a(a[31]), .b(b[31]), .s(res[31]), .c(c_rr));
overflow u3 (.op(IsSubi|IsCmpi), .a(a[31]), .b(imm[31]), .s(res[31]), .v(v_ri));
overflow u4 (.op(IsSub|IsCmp|IsNeg), .a(a[31]), .b(b[31]), .s(res[31]), .v(v_rr));

wire [7:0] bcdaddo,bcdsubo;
wire bcdaddc,bcdsubc;
BCDAdd u5 (.ci(cr0[0]),.a(a[7:0]),.b(b[7:0]),.o(bcdaddo),.c(bcdaddc));
BCDSub u6 (.ci(cr0[0]),.a(a[7:0]),.b(b[7:0]),.o(bcdsubo),.c(bcdsubc));

wire [63:0] shlo = {32'd0,a} << b[4:0];
wire [63:0] shro = {a,32'd0} >> b[4:0];

reg res_sgn;
wire [31:0] mp0 = aa[15:0] * bb[15:0];
wire [31:0] mp1 = aa[15:0] * bb[31:16];
wire [31:0] mp2 = aa[31:16] * bb[15:0];
wire [31:0] mp3 = aa[31:16] * bb[31:16];
reg [63:0] prod;
wire divByZero;

function GetCrBit;
input [4:0] Rn;
begin
	case(Rn[4:2])
	3'd0:	GetCrBit = cr0[Rn[1:0]];
	3'd1:	GetCrBit = cr1[Rn[1:0]];
	3'd2:	GetCrBit = cr2[Rn[1:0]];
	3'd3:	GetCrBit = cr3[Rn[1:0]];
	3'd4:	GetCrBit = cr4[Rn[1:0]];
	3'd5:	GetCrBit = cr5[Rn[1:0]];
	3'd6:	GetCrBit = cr6[Rn[1:0]];
	3'd7:	GetCrBit = cr7[Rn[1:0]];
	endcase
end
endfunction

function [3:0] GetCr;
input [2:0] Rn;
begin
	case(Rn)
	3'd0:	GetCr = cr0;
	3'd1:	GetCr = cr1;
	3'd2:	GetCr = cr2;
	3'd3:	GetCr = cr3;
	3'd4:	GetCr = cr4;
	3'd5:	GetCr = cr5;
	3'd6:	GetCr = cr6;
	3'd7:	GetCr = cr7;
	endcase
end
endfunction

wire [3:0] crc = GetCr(Rn[4:2]);
wire cr_zf = crc[2];
wire cr_nf = crc[3];
wire cr_cf = crc[0];
wire cr_vf = crc[1];

//-----------------------------------------------------------------------------
// Clock control
// - reset or NMI reenables the clock
// - this circuit must be under the clk_i domain
//-----------------------------------------------------------------------------
//
//BUFGCE u20 (.CE(cpu_clk_en), .I(clk_i), .O(clk) );

always @(posedge clk_i)
if (rst_i) begin
	cpu_clk_en <= 1'b1;
end
else begin
	if (ipl_i==3'd7)
		cpu_clk_en <= 1'b1;
	else
		cpu_clk_en <= clk_en;
end


//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

always @(posedge clk)
if (rst_i) begin
	prev_nmi <= 1'b0;
	nmi_edge <= 1'b0;
	state <= RESET;
	im <= 3'b111;
	sf <= 1'b1;
	tf <= 1'b0;
	inta_o <= 1'b0;
	cyc_o <= 1'b0;
	stb_o <= 1'b0;
	sel_o <= 4'b0000;
	we_o <= 1'b0;
	clk_en <= 1'b1;
	tick <= 32'd0;
	rstsh <= 16'hFFFF;
end
else begin
tick <= tick + 32'd1;
clk_en <= 1'b1;
rstsh <= {rstsh,1'b0};
prev_nmi <= ipl_i==3'd7;
if (!prev_nmi && (ipl_i==3'd7))
	nmi_edge <= 1'b1;

case(state)
EXECUTE:
	begin
		state <= WRITEBACK;
		case(opcode)
		`R:
			begin
				case(func)
				`ABS:	res <= a[31] ? -a : a;
				`SGN:	res <= a[31] ? 32'hFFFFFFFF : |a;
				`NEG:	res <= -a;
				`NOT:	res <= ~a;
				`EXTB:	res <= {{24{a[7]}},a[7:0]};
				`EXTH:	res <= {{16{a[15]}},a[15:0]};
				`MFSPR:
					casex(ir[25:21])
					5'b00xxx:	res <= GetCr(ir[23:21]);
					5'b01000:	res <= cr;
					5'b01001:	res <= usp;
					5'b01010:	
							if (!sf) begin
								vector <= `PRIVILEGE_VIOLATION;
								state <= TRAP;
							end
							else begin
								res <= im;
							end
					5'b01011:	res <= be_addr;
					5'b01111:	res <= tick;
					endcase
				`MTSPR:
					casex(ir[20:16])
					5'b00xxx:	// MTSPR CRn,Rn
						begin
							state <= IFETCH;
							case(ir[18:16])
							3'd0:	cr0 <= a[3:0];
							3'd1:	cr1 <= a[3:0];
							3'd2:	cr2 <= a[3:0];
							3'd3:	cr3 <= a[3:0];
							3'd4:	cr4 <= a[3:0];
							3'd5:	cr5 <= a[3:0];
							3'd6:	cr6 <= a[3:0];
							3'd7:	cr7 <= a[3:0];
							endcase
						end
					5'b01000:	// MTSPR CR,Rn
						begin
							state <= IFETCH;
							cr0 <= a[3:0];
							cr1 <= a[7:4];
							cr2 <= a[11:8];
							cr3 <= a[15:12];
							cr4 <= a[19:16];
							cr5 <= a[23:20];
							cr6 <= a[27:24];
							cr7 <= a[31:28];
						end
					5'b01001:	usp <= a;	// MTSPR USP,Rn
					5'b01010:
							if (!sf) begin
								vector <= `PRIVILEGE_VIOLATION;
								state <= TRAP;
							end
							else begin
								im <= a[2:0];
								state <= IFETCH;
							end
					endcase
				`EXEC:
					begin
					ir <= a;
					Rn <= a[25:21];
					state <= REGFETCHA;
					end
				`MOV_CRn2CRn:
					begin
					state <= IFETCH;
					case(ir[18:16])
					3'd0:	cr0 <= GetCr(ir[23:21]);
					3'd1:	cr1 <= GetCr(ir[23:21]);
					3'd2:	cr2 <= GetCr(ir[23:21]);
					3'd3:	cr3 <= GetCr(ir[23:21]);
					3'd4:	cr4 <= GetCr(ir[23:21]);
					3'd5:	cr5 <= GetCr(ir[23:21]);
					3'd6:	cr6 <= GetCr(ir[23:21]);
					3'd7:	cr7 <= GetCr(ir[23:21]);
					endcase
					end
				default:	res <= 32'd0;
				endcase
			end
		`RR:
			begin
				case(func)
				`ADD:	res <= a + b;
				`SUB:	res <= a - b;
				`CMP:	res <= a - b;
				`AND:	res <= a & b;
				`ANDC:	res <= a & ~b;
				`OR:	res <= a | b;
				`ORC:	res <= a | ~b;
				`EOR:	res <= a ^ b;
				`NAND:	res <= ~(a & b);
				`NOR:	res <= ~(a | b);
				`ENOR:	res <= ~(a ^ b);
				`SHL:	res <= shlo[31: 0];
				`SHR:	res <= shro[63:32];
				`ROL:	res <= shlo[31:0]|shlo[63:32];
				`ROR:	res <= shro[31:0]|shro[63:32];
				`MIN:	res <= as < bs ? as : bs;
				`MAX:	res <= as < bs ? bs : as;
				`BCDADD:	res <= bcdaddo;
				`BCDSUB:	res <= bcdsubo;
				default:	res <= 32'd0;
				endcase
				if (func==`JMP_RR) begin
					pc <= a + b;
					pc[1:0] <= 2'b00;
					state <= IFETCH;
				end
				else if (func==`JSR_RR) begin
					tgt <= a + b;
					tgt[1:0] <= 2'b00;
					state <= JSR1;
				end
				case(func)
				`LWX:	begin ea <= a + b; mopcode <= `LW; state <= MEMORY1; end
				`LHX:	begin ea <= a + b; mopcode <= `LH; state <= MEMORY1; end
				`LHUX:	begin ea <= a + b; mopcode <= `LHU; state <= MEMORY1; end
				`LBX:	begin ea <= a + b; mopcode <= `LB; state <= MEMORY1; end
				`LBUX:	begin ea <= a + b; mopcode <= `LBU; state <= MEMORY1; end
				`SBX:	begin ea <= a + b; mopcode <= `SB; b <= c; state <= MEMORY1; end
				`SHX:	begin ea <= a + b; mopcode <= `SH; b <= c; state <= MEMORY1; end
				`SWX:	begin ea <= a + b; mopcode <= `SW; b <= c; state <= MEMORY1; end

				`MULU:	state <= MULTDIV1;
				`MULS:	state <= MULTDIV1;
				`MULUH:	state <= MULTDIV1;
				`MULSH:	state <= MULTDIV1;
				`DIVU:	state <= MULTDIV1;
				`DIVS:  state <= MULTDIV1;
				`MODU:	state <= MULTDIV1;
				`MODS:	state <= MULTDIV1;
				endcase
			end
		`SETcc:
			begin
				case(cond)
				`SET:	res <= 32'd1;
				`SEQ:	res <=  cr_zf;
				`SNE:	res <= !cr_zf;
				`SMI:	res <= ( cr_nf);
				`SPL:	res <= (!cr_zf);
				`SHI:	res <= (!cr_cf & !cr_zf);
				`SLS:	res <= (cf |zf);
				`SHS:	res <= (!cr_cf);
				`SLO:	res <= ( cr_cf);
				`SGT:	res <= ((cr_nf & cr_vf & !cr_zf)|(!cr_nf & !cr_vf & !cr_zf));
				`SLE:	res <= (cr_zf | (cr_nf & !cr_vf) | (!cr_nf & cr_vf));
				`SGE:	res <= ((cr_nf & cr_vf)|(!cr_nf & !cr_vf));
				`SLT:	res <= ((cr_nf & !cr_vf)|(!cr_nf & cr_vf));
				`SVS:	res <= ( cr_vf);
				`SVC:	res <= (!cr_vf);
				endcase
			end
		`ADDI:	res <= a + imm;
		`SUBI:	res <= a - imm;
		`CMPI:	res <= a - imm;
		`ANDI:	res <= a & imm;
		`ORI:	res <= a | imm;
		`EORI:	res <= a ^ imm;
/*
			case(ir[20:16])
			`ORI_CCR:
				begin
					state <= IFETCH;
					cr0 <= cr0 | imm[3:0];
					cr1 <= cr1 | imm[7:4];
					cr2 <= cr2 | imm[11:8];
					cr3 <= cr3 | imm[15:12];
					cr4 <= cr4 | imm[19:16];
					cr5 <= cr5 | imm[23:20];
					cr6 <= cr6 | imm[27:24];
					cr7 <= cr7 | imm[31:28];
				end
			`ANDI_CCR:
				begin
					state <= IFETCH;
					cr0 <= cr0 & imm[3:0];
					cr1 <= cr1 & imm[7:4];
					cr2 <= cr2 & imm[11:8];
					cr3 <= cr3 & imm[15:12];
					cr4 <= cr4 & imm[19:16];
					cr5 <= cr5 & imm[23:20];
					cr6 <= cr6 & imm[27:24];
					cr7 <= cr7 & imm[31:28];
				end
			`EORI_CCR:
				begin
					state <= IFETCH;
					cr0 <= cr0 ^ imm[3:0];
					cr1 <= cr1 ^ imm[7:4];
					cr2 <= cr2 ^ imm[11:8];
					cr3 <= cr3 ^ imm[15:12];
					cr4 <= cr4 ^ imm[19:16];
					cr5 <= cr5 ^ imm[23:20];
					cr6 <= cr6 ^ imm[27:24];
					cr7 <= cr7 ^ imm[31:28];
				end
			endcase
*/
		`LINK:	state <= LINK;
		`MULUI:	state <= MULTDIV1;
		`MULSI:	state <= MULTDIV1;
		`DIVUI:	state <= MULTDIV1;
		`DIVSI:	state <= MULTDIV1;
		default:	res <= 32'd0;
		endcase
		case(opcode)
		`TAS:	begin ea <= a + imm; mopcode <= opcode; state <= TAS; end
		`LW:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`LH:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`LB:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`LHU:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`LBU:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`SW:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`SH:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`SB:	begin ea <= a + imm; mopcode <= opcode; state <= MEMORY1; end
		`PEA:	begin ea <= a + imm; mopcode <= opcode; state <= PEA; end
		default:	ea <= 32'd0;
		endcase
	end
LOAD_SP:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= vector;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		ssp[31:2] <= dat_i[31:2];
		ssp[1:0] <= 2'b00;
		vector <= `RESET_VECTOR;
		state <= VECTOR;
	end
	// Pointless to check for bus error here
VECTOR:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= vector;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		pc[31:2] <= dat_i[31:2];
		pc[1:0] <= 2'b00;
		state <= IFETCH;
	end
IFETCH:
	if (!cyc_o) begin
		if (halt_i) begin
			// empty - do nothing until non-halted
		end
		else if (nmi_edge) begin
			sr1 <= sr;
			im <= ipl_i;
			tf <= 1'b0;
			sf <= 1'b1;
			iplr <= ipl_i;
			state <= INTA;
			nmi_edge <= 1'b0;
		end
		else if (ipl_i > im) begin
			sr1 <= sr;
			im <= ipl_i;
			tf <= 1'b0;
			sf <= 1'b1;
			iplr <= ipl_i;
			state <= INTA;
		end
		else if (tf) begin
			sr1 <= sr;
			tf <= 1'b0;
			sf <= 1'b1;
			vector <= `TRACE_VECTOR;
			state <= TRAP;
		end
		else begin
			fc_o <= {sf,2'b10};
			cyc_o <= 1'b1;
			stb_o <= 1'b1;
			sel_o <= 4'b1111;
			adr_o <= pc;
		end
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		pc <= pc + 32'd4;
		ir <= dat_i;
		Rn <= dat_i[25:21];
		state <= REGFETCHA;
	end
REGFETCHA:
	begin
		Rcbit <= 1'b0;
		a <= rfo;
		b <= 32'd0;
		Rn <= ir[20:16];
		// RIX format ?
		if (hasConst16 && ir[15:0]==16'h8000)
			state <= FETCH_IMM32;
		else begin
			case(opcode)
			`ANDI:	imm <= {16'hFFFF,ir[15:0]};
			`ORI:	imm <= {16'h0000,ir[15:0]};
			`EORI:	imm <= {16'h0000,ir[15:0]};
			default:	imm <= {{16{ir[15]}},ir[15:0]};
			endcase
			state <= EXECUTE;
		end
		case(opcode)
		`MISC:
			case(func)
			`TRACE_ON:
					if (!sf) begin
						vector <= `PRIVILEGE_VIOLATION;
						state <= TRAP;
					end
					else begin
						tf <= 1'b1;
						state <= IFETCH;
					end
			`TRACE_OFF:
					if (!sf) begin
						vector <= `PRIVILEGE_VIOLATION;
						state <= TRAP;
					end
					else begin
						tf <= 1'b0;
						state <= IFETCH;
					end
			`SET_IM:
					if (!sf) begin
						vector <= `PRIVILEGE_VIOLATION;
						state <= TRAP;
					end
					else begin
						im <= ir[2:0];
						state <= IFETCH;
					end
			`USER_MODE: begin sf <= 1'b0; state <= IFETCH; end
			`JMP32:	state <= JMP32;
			`JSR32:	state <= JSR32;
			`RTS: state <= RTS;
			`RTI:
				if (!sf) begin
					vector <= `PRIVILEGE_VIOLATION;
					state <= TRAP;
				end
				else
					state <= RTI1;
			`RST:
				if (!sf) begin
					vector <= `PRIVILEGE_VIOLATION;
					state <= TRAP;
				end
				else begin
					rstsh <= 16'hFFFF;
					state <= IFETCH;
				end
			`STOP:
				if (!sf) begin
					vector <= `PRIVILEGE_VIOLATION;
					state <= TRAP;
				end
				else begin
					im <= ir[8:6];
					tf <= ir[9];
					sf <= ir[10];
					clk_en <= 1'b0;
					state <= IFETCH;
				end
			default:
				begin
				vector <= `ILLEGAL_INSN;
				state <= TRAP;
				end
			endcase

		`R:
			begin
				Rcbit <= ir[6];
				case(func)
				`UNLK:	state <= UNLK;
				`ABS,`SGN,`NEG,`NOT,
				`EXTB,`EXTH,
				`MFSPR,`MTSPR,
				`MOV_CRn2CRn,
				`EXEC:
					;
				default:
					begin
					vector <= `ILLEGAL_INSN;
					state <= TRAP;
					end
				endcase
			end

		`NOP: state <= IFETCH;
		`JSR: begin tgt <= {pc[31:26],ir[25:2],2'b00}; state <= JSR1; end
		`JMP: begin pc[25:2] <= ir[25:2]; state <= IFETCH; end
		`Bcc:
			case(cond)
			`BRA:	begin pc <= pc + brdisp; state <= IFETCH; end
			`BRN:	begin state <= IFETCH; end
			`BEQ:	begin if ( cr_zf) pc <= pc + brdisp; state <= IFETCH; end
			`BNE:	begin if (!cr_zf) pc <= pc + brdisp; state <= IFETCH; end
			`BMI:	begin if ( cr_nf) pc <= pc + brdisp; state <= IFETCH; end
			`BPL:	begin if (!cr_zf) pc <= pc + brdisp; state <= IFETCH; end
			`BHI:	begin if (!cr_cf & !cr_zf) pc <= pc + brdisp; state <= IFETCH; end
			`BLS:	begin if (cf |zf) pc <= pc + brdisp; state <= IFETCH; end
			`BHS:	begin if (!cr_cf) pc <= pc + brdisp; state <= IFETCH; end
			`BLO:	begin if ( cr_cf) pc <= pc + brdisp; state <= IFETCH; end
			`BGT:	begin if ((cr_nf & cr_vf & !cr_zf)|(!cr_nf & !cr_vf & !cr_zf)) pc <= pc + brdisp; state <= IFETCH; end
			`BLE:	begin if (cr_zf | (cr_nf & !cr_vf) | (!cr_nf & cr_vf)) pc <= pc + brdisp; state <= IFETCH; end
			`BGE:	begin if ((cr_nf & cr_vf)|(!cr_nf & !cr_vf)) pc <= pc + brdisp; state <= IFETCH; end
			`BLT:	begin if ((cr_nf & !cr_vf)|(!cr_nf & cr_vf)) pc <= pc + brdisp; state <= IFETCH; end
			`BVS:	begin if ( cr_vf) pc <= pc + brdisp; state <= IFETCH; end
			`BVC:	begin if (!cr_vf) pc <= pc + brdisp; state <= IFETCH; end
			endcase
		`TRAPcc:
			case(cond)
			`TRAP:	begin vector <= `TRAP_VECTOR + {ir[3:0],2'b00}; state <= TRAP; end
			`TEQ:	begin if ( cr_zf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TNE:	begin if (!cr_zf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TMI:	begin if ( cr_nf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TPL:	begin if (!cr_zf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`THI:	begin if (!cr_cf & !cr_zf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TLS:	begin if (cf |zf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`THS:	begin if (!cr_cf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TLO:	begin if ( cr_cf) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TGT:	begin if ((cr_nf & cr_vf & !cr_zf)|(!cr_nf & !cr_vf & !cr_zf)) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TLE:	begin if (cr_zf | (cr_nf & !cr_vf) | (!cr_nf & cr_vf)) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TGE:	begin if ((cr_nf & cr_vf)|(!cr_nf & !cr_vf)) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TLT:	begin if ((cr_nf & !cr_vf)|(!cr_nf & cr_vf)) begin vector <= `TRAP_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TVS:	begin if ( cr_vf) begin vector <= `TRAPV_VECTOR; state <= TRAP; end else state <= IFETCH; end
			`TVC:	begin if (!cr_vf) begin vector <= `TRAPV_VECTOR; state <= TRAP; end else state <= IFETCH; end
			endcase
		`SETcc:	Rn <= ir[15:11];
		`PUSH:	state <= PUSH1;
		`POP:	state <= POP1;

		`RR:
			begin
				state <= REGFETCHB;
				Rcbit <= ir[6];
				case(func)
				`JSR_RR,`JMP_RR,
				`ADD,`SUB,`CMP,
				`BCDADD,`BCDSUB,
				`AND,`OR,`EOR,`NAND,`NOR,`ENOR,
				`SHL,`SHR,`ROL,`ROR,
				`MULU,`MULS,`MULUH,`MULSH,`DIVU,`DIVS,`MODU,`MODS,
				`LWX,`LHX,`LBX,`LHUX,`LBUX,`SWX,`SHX,`SBX,
				`MIN,`MAX:
					;
				default:
					begin
					vector <= `ILLEGAL_INSN;
					state <= TRAP;
					end
				endcase
			end
			
		`RRR:
			state <= REGFETCHB;

		`CRxx:
			case(func1)
			`CROR:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					3'd1:	cr1[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					3'd2:	cr2[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					3'd3:	cr3[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					3'd4:	cr4[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					3'd5:	cr5[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					3'd6:	cr6[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					3'd7:	cr7[ir[12:11]] <= GetCrBit(ir[25:21])| GetCrBit(ir[20:16]);
					endcase
				end
			`CRORC:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					3'd1:	cr1[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					3'd2:	cr2[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					3'd3:	cr3[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					3'd4:	cr4[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					3'd5:	cr5[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					3'd6:	cr6[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					3'd7:	cr7[ir[12:11]] <= GetCrBit(ir[25:21])| ~GetCrBit(ir[20:16]);
					endcase
				end
			`CRAND:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					3'd1:	cr1[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					3'd2:	cr2[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					3'd3:	cr3[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					3'd4:	cr4[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					3'd5:	cr5[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					3'd6:	cr6[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					3'd7:	cr7[ir[12:11]] <= GetCrBit(ir[25:21])& GetCrBit(ir[20:16]);
					endcase
				end
			`CRANDC:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					3'd1:	cr1[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					3'd2:	cr2[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					3'd3:	cr3[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					3'd4:	cr4[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					3'd5:	cr5[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					3'd6:	cr6[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					3'd7:	cr7[ir[12:11]] <= GetCrBit(ir[25:21])& ~GetCrBit(ir[20:16]);
					endcase
				end
			`CRXOR:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					3'd1:	cr1[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					3'd2:	cr2[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					3'd3:	cr3[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					3'd4:	cr4[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					3'd5:	cr5[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					3'd6:	cr6[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					3'd7:	cr7[ir[12:11]] <= GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]);
					endcase
				end
			`CRNOR:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					3'd1:	cr1[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					3'd2:	cr2[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					3'd3:	cr3[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					3'd4:	cr4[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					3'd5:	cr5[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					3'd6:	cr6[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					3'd7:	cr7[ir[12:11]] <= ~(GetCrBit(ir[25:21])| GetCrBit(ir[20:16]));
					endcase
				end
			`CRNAND:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					3'd1:	cr1[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					3'd2:	cr2[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					3'd3:	cr3[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					3'd4:	cr4[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					3'd5:	cr5[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					3'd6:	cr6[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					3'd7:	cr7[ir[12:11]] <= ~(GetCrBit(ir[25:21])& GetCrBit(ir[20:16]));
					endcase
				end
			`CRXNOR:
				begin
					state <= IFETCH;
					case(ir[15:13])
					3'd0:	cr0[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					3'd1:	cr1[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					3'd2:	cr2[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					3'd3:	cr3[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					3'd4:	cr4[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					3'd5:	cr5[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					3'd6:	cr6[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					3'd7:	cr7[ir[12:11]] <= ~(GetCrBit(ir[25:21])^ GetCrBit(ir[20:16]));
					endcase
				end
			default:
				begin
				vector <= `ILLEGAL_INSN;
				state <= TRAP;
				end
			endcase
		`ADDI,`SUBI,`CMPI,
		`ANDI,`ORI,`EORI,
		`MULUI,`MULSI,`DIVUI,`DIVSI,
		`PEA,`LINK,`TAS,
		`LB,`LH,`LW,`LBU,`LHU:
			;	/* do nothing at this point */
		`SB,`SH,`SW:
			state <= REGFETCHB;
		default:
			begin
			vector <= `ILLEGAL_INSN;
			state <= TRAP;
			end
		endcase
	end

REGFETCHB:
	begin
		b <= rfo;
		Rn <= ir[15:11];
		if (opcode==`RRR || (opcode==`RR && (func==`SWX||func==`SHX||func==`SBX)))
			state <= REGFETCHC;
		else begin
			// RIX format ?
			if (hasConst16 && ir[15:0]==16'h8000)
				state <= FETCH_IMM32;
			else begin
				case(opcode)
				`ANDI:	imm <= {16'hFFFF,ir[15:0]};
				`ORI:	imm <= {16'h0000,ir[15:0]};
				`EORI:	imm <= {16'h0000,ir[15:0]};
				default:	imm <= {{16{ir[15]}},ir[15:0]};
				endcase
				state <= EXECUTE;
			end
		end
	end
REGFETCHC:
	begin
		c <= rfo;
		Rn <= ir[10:6];
		state <= EXECUTE;
	end

FETCH_IMM32:
	if (!cyc_o) begin
		fc_o <= {sf,2'b10};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= pc;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		imm <= dat_i;
		pc <= pc + 32'd4;
		state <= EXECUTE;
	end

MEMORY1:
	begin
		case(mopcode)
		`LW:	begin
				fc_o <= {sf,2'b01};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= 4'b1111;
				adr_o <= ea;
				state <= MEMORY1_ACK;
				end
		`LH,`LHU:
				begin
				fc_o <= {sf,2'b01};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				sel_o <= ea[1] ? 4'b1100 : 4'b0011;
				adr_o <= ea;
				state <= MEMORY1_ACK;
				end
		`LB,`LBU:
				begin
				fc_o <= {sf,2'b01};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				case(ea[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= ea;
				state <= MEMORY1_ACK;
				end
		`SW:	begin
				fc_o <= {sf,2'b01};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= 4'b1111;
				adr_o <= ea;
				dat_o <= b;
				state <= MEMORY1_ACK;
				end
		`SH:	begin
				fc_o <= {sf,2'b01};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				sel_o <= ea[1] ? 4'b1100 : 4'b0011;
				adr_o <= ea;
				dat_o <= {2{b[15:0]}};
				state <= MEMORY1_ACK;
				end
		`SB:	begin
				fc_o <= {sf,2'b01};
				cyc_o <= 1'b1;
				stb_o <= 1'b1;
				we_o <= 1'b1;
				case(ea[1:0])
				2'd0:	sel_o <= 4'b0001;
				2'd1:	sel_o <= 4'b0010;
				2'd2:	sel_o <= 4'b0100;
				2'd3:	sel_o <= 4'b1000;
				endcase
				adr_o <= ea;
				dat_o <= {4{b[7:0]}};
				state <= MEMORY1_ACK;
				end
		endcase
	end
MEMORY1_ACK:
	if (ack_i) begin
		case(mopcode)
		`LW:	begin
				cyc_o <= 1'b0;
				stb_o <= 1'b0;
				sel_o <= 4'b0000;
				res <= dat_i;
				state <= WRITEBACK;
				end
		`LH:	begin
				cyc_o <= 1'b0;
				stb_o <= 1'b0;
				sel_o <= 4'b0000;
				if (sel_o==4'b0011)
					res <= {{16{dat_i[15]}},dat_i[15:0]};
				else
					res <= {{16{dat_i[31]}},dat_i[31:16]};
				state <= WRITEBACK;
				end
		`LHU:	begin
				cyc_o <= 1'b0;
				stb_o <= 1'b0;
				sel_o <= 4'b0000;
				if (sel_o==4'b0011)
					res <= {16'd0,dat_i[15:0]};
				else
					res <= {16'd0,dat_i[31:16]};
				state <= WRITEBACK;
				end
		`LB:	begin
				cyc_o <= 1'b0;
				stb_o <= 1'b0;
				sel_o <= 4'b0000;
				case(sel_o)
				4'b0001:	res <= {{24{dat_i[7]}},dat_i[7:0]};
				4'b0010:	res <= {{24{dat_i[15]}},dat_i[15:8]};
				4'b0100:	res <= {{24{dat_i[23]}},dat_i[23:16]};
				4'b1000:	res <= {{24{dat_i[31]}},dat_i[31:24]};
				endcase
				state <= WRITEBACK;
				end
		`LBU:	begin
				cyc_o <= 1'b0;
				stb_o <= 1'b0;
				sel_o <= 4'b0000;
				case(sel_o)
				4'b0001:	res <= {24'd0,dat_i[7:0]};
				4'b0010:	res <= {24'd0,dat_i[15:8]};
				4'b0100:	res <= {24'd0,dat_i[23:16]};
				4'b1000:	res <= {24'd0,dat_i[31:24]};
				endcase
				state <= WRITEBACK;
				end
		`SW,`SH,`SB:
				begin
				cyc_o <= 1'b0;
				stb_o <= 1'b0;
				we_o <= 1'b0;
				sel_o <= 4'b0000;
				state <= IFETCH;
				end
		endcase
	end

TAS:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= ea;
	end
	else if (ack_i) begin
		cyc_o <= ~dat_i[31];
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		res <= dat_i;
		state <= TAS2;
	end
TAS2:
	if (!res[31]) begin
		if (!stb_o) begin
			fc_o <= {sf,2'b01};
			cyc_o <= 1'b1;
			stb_o <= 1'b1;
			we_o <= 1'b1;
			sel_o <= 4'b1111;
			adr_o <= ea;
			dat_o <= {1'b1,res[30:0]};
		end
		else if (ack_i) begin
			cyc_o <= 1'b0;
			stb_o <= 1'b0;
			we_o <= 1'b0;
			sel_o <= 4'b0000;
			state <= WRITEBACK;
		end
	end
	else begin
		cyc_o <= 1'b0;
		state <= WRITEBACK;
	end
PUSH1:
	if (ir[25:1]==25'd0)
		state <= IFETCH;
	else begin
		Rn <= ir[25:21];
		ir[25:0] <= {ir[20:1],6'b0};
		if (ir[25:21]!=5'd0)
			state <= PUSH2;
	end
PUSH2:
	begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= sf ? ssp - 32'd4 : usp - 32'd4;
		dat_o <= rfo;
		state <= PUSH3;
	end
PUSH3:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'b0000;
		if (sf)
			ssp <= ssp - 32'd4;
		else
			usp <= usp - 32'd4;
		state <= PUSH1;
	end

PEA:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= sf ? ssp - 32'd4 : usp - 32'd4;
		dat_o <= ea;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'b0000;
		if (sf)
			ssp <= ssp - 32'd4;
		else
			usp <= usp - 32'd4;
		state <= IFETCH;
	end

LINK:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= sf ? ssp - 32'd4 : usp - 32'd4;
		dat_o <= a;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'b0000;
		if (sf) begin
			ssp <= ssp - 32'd4;
			res <= ssp - 32'd4;
		end
		else begin
			usp <= usp - 32'd4;
			res <= usp - 32'd4;
		end
		state <= WRITEBACK;
	end

POP1:
	if (ir[25:1]==25'd0)
		state <= IFETCH;
	else begin
		Rn <= ir[25:21];
		ir[25:0] <= {ir[20:1],6'b0};
		if (ir[25:21]!=5'd0)
			state <= POP2;
	end
POP2:
	begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= sf ? ssp : usp;
		state <= POP3;
	end
POP3:
	if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		if (sf)
			ssp <= ssp + 32'd4;
		else
			usp <= usp + 32'd4;
		res <= dat_i;
		state <= WRITEBACK;
	end

UNLK:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= a;
		if (sf)
			ssp <= a;
		else
			usp <= a;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		if (sf)
			ssp <= ssp + 32'd4;
		else
			usp <= usp + 32'd4;
		res <= dat_i;
		state <= WRITEBACK;
	end

WRITEBACK:
	begin
		state <= WRITE_FLAGS;
		if (opcode!=`CMPI && !(opcode==`RR && func==`CMP)) begin
			regfile[Rn] <= res;
			if (Rn==5'd31) begin
				if (sf) ssp <= res;
				else usp <= res;
			end
		end
		case(opcode)
		`R:
			case(func)
			`ABS:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= res[31];
				cf <= 1'b0;
				nf <= res[31];
				zf <= res==32'd0;
				end
			`SGN,`NOT,`EXTB,`EXTH:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= 1'b0;
				cf <= 1'b0;
				nf <= res[31];
				zf <= res==32'd0;
				end
			`NEG:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= v_rr;
				cf <= c_rr;
				nf <= res[31];
				zf <= res==32'd0;
				end
			endcase
		`RR:
			case(func)
			`ADD,`SUB:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= v_rr;
				cf <= c_rr;
				nf <= res[31];
				zf <= res==32'd0;
				end
			`CMP:
				begin
				state <= WRITE_FLAGS;
				vf <= 1'b0;
				cf <= c_rr;
				nf <= res[31];
				zf <= res==32'd0;
				end
			`AND,`OR,`EOR,`NAND,`NOR,`ENOR,`MIN,`MAX,
			`LWX,`LHX,`LBX,`LHUX,`LBUX:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= 1'b0;
				cf <= 1'b0;
				nf <= res[31];
				zf <= res==32'd0;
				end
			`SHL,`ROL:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= 1'b0;
				cf <= shlo[32];
				nf <= res[31];
				zf <= res==32'd0;
				end
			`SHR,`ROR:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= 1'b0;
				cf <= shro[31];
				nf <= res[31];
				zf <= res==32'd0;
				end
			`BCDADD:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= 1'b0;
				cf <= bcdaddc;
				nf <= res[7];
				zf <= res[7:0]==8'd0;
				end
			`BCDSUB:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= 1'b0;
				cf <= bcdsubc;
				nf <= res[7];
				zf <= res[7:0]==8'd0;
				end
			`DIVU,`DIVS,`MODU,`MODS:
				begin
				if (!Rcbit) state <= IFETCH;
				vf <= divByZero;
				cf <= divByZero;
				nf <= res[31];
				zf <= res==32'd0;
				end
			`MULU,`MULS,`MULUH,`MULSH:
				begin
				if (!Rcbit) state <= IFETCH;
				cf <= vf;
				nf <= res[31];
				zf <= res==32'd0;
				end
			endcase
		`ADDI,`SUBI:
			begin
			vf <= v_ri;
			cf <= c_ri;
			nf <= res[31];
			zf <= res==32'd0;
			end
		`CMPI:
			begin
			vf <= 1'b0;
			cf <= c_ri;
			nf <= res[31];
			zf <= res==32'd0;
			end
		`ANDI,`ORI,`EORI,`LW,`LH,`LB,`LHU,`LBU,`POP,`TAS:
			begin
			vf <= 1'b0;
			cf <= 1'b0;
			nf <= res[31];
			zf <= res==32'd0;
			end
		`DIVSI,`DIVUI:
			begin
			vf <= divByZero;
			cf <= divByZero;
			nf <= res[31];
			zf <= res==32'd0;
			end
		`MULSI,`MULUI:
			begin
			cf <= vf;
			nf <= res[31];
			zf <= res==32'd0;
			end
		`POP:	state <= POP1;
		`LINK:
			begin
				state <= IFETCH;
				if (sf)
					ssp <= ssp - imm;
				else
					usp <= usp - imm;
			end
		endcase
	end
WRITE_FLAGS:
	begin
		state <= IFETCH;
		if (opcode==`CMPI || (opcode==`RR && func==`CMP)) begin
			$display("Writing flags to Cr%d",Rn[4:2]);
			case(Rn[4:2])
			3'd0:	cr0 <= {nf,zf,vf,cf};
			3'd1:	cr1 <= {nf,zf,vf,cf};
			3'd2:	cr2 <= {nf,zf,vf,cf};
			3'd3:	cr3 <= {nf,zf,vf,cf};
			3'd4:	cr4 <= {nf,zf,vf,cf};
			3'd5:	cr5 <= {nf,zf,vf,cf};
			3'd6:	cr6 <= {nf,zf,vf,cf};
			3'd7:	cr7 <= {nf,zf,vf,cf};
			endcase
		end
		else begin
			case(opcode)
			`R:
				case(func)
				`ABS,`SGN,`NEG,`NOT,`EXTB,`EXTH:
					if (Rcbit) cr0 <= {nf,zf,vf,cf};
				default:	;
				endcase
			`RR:
				case(func)
				`MULU,`MULS,`MULUH,`MULSH,`DIVU,`DIVS,`MODU,`MODS,
				`ADD,`SUB,`AND,`ANDC,`OR,`ORC,`EOR,`NAND,`NOR,`ENOR,
				`MIN,`MAX,
				`BCDADD,`BCDSUB,
				`SHL,`SHR,`ROL,`ROR,
				`LWX,`LHX,`LBX,`LHUX,`LBUX:
					if (Rcbit) cr0 <= {nf,zf,vf,cf};
				default:	;
			endcase
			`MULUI,`MULSI,`DIVUI,`DIVSI,
			`ADDI,`SUBI,`ANDI,`ORI,`EORI,`LW,`LH,`LB,`LHU,`LBU,`TAS:
				cr0 <= {nf,zf,vf,cf};
			default:	;
			endcase
		end
	end
JMP32:
	if (!cyc_o) begin
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= pc;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		pc <= dat_i;
		state <= IFETCH;
	end
JSR32:
	if (!cyc_o) begin
		fc_o <= {sf,2'b10};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= pc;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		pc <= pc + 32'd4;
		tgt <= dat_i;
		state <= JSR1;
	end
JSR1:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'b1111;
		if (sf)
			adr_o <= ssp - 32'd4;
		else
			adr_o <= usp - 32'd4;
		dat_o <= pc;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'b0000;
		if (sf)
			ssp <= ssp - 32'd4;
		else
			usp <= usp - 32'd4;
		pc <= tgt;
		state <= IFETCH;
	end
RTS:
	if (!cyc_o) begin
		fc_o <= {sf,2'b01};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= sf ? ssp : usp;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		if (sf)
			ssp <= ssp + 32'd4 + ir[21:6];
		else
			usp <= usp + 32'd4 + ir[21:6];
		pc <= {dat_i[31:2],2'b00}+{ir[25:22],2'b00};
		state <= IFETCH;
	end

INTA:
	if (!cyc_o) begin
		fc_o <= 3'b111;
		inta_o <= 1'b1;
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b0001;
		adr_o <= {27'h7FFFFFF,iplr,2'b00};
	end
	else if (vpa_i) begin
		inta_o <= 1'b0;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		vecnum <= 32'd24 + iplr;
		state <= FETCH_VECTOR;
	end
	else if (ack_i) begin
		inta_o <= 1'b0;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		vecnum <= dat_i[7:0];
		state <= FETCH_VECTOR;
	end
	else if (err_i) begin
		inta_o <= 1'b0;
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		vecnum <= 32'd24;		// Spurious interrupt
		state <= FETCH_VECTOR;
	end
FETCH_VECTOR:
	if (!cyc_o) begin
		fc_o <= 3'b101;
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= {vecnum,2'b00};
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		vector <= dat_i;
		state <= TRAP1;
	end
	// I don't bother with bus error checking here because if the cpu can't read the
	// vector table, bus error processing won't help.
TRAP1:
	if (!cyc_o) begin
		fc_o <= {3'b101};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= ssp - 32'd4;
		dat_o <= pc;
	end
	else if (ack_i) begin
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'b0000;
		sr1 <= sr;
		sf <= 1'b1;
		tf <= 1'b0;
		ssp <= ssp - 32'd4;
		state <= TRAP2;
	end
TRAP2:
	if (!stb_o) begin
		fc_o <= {3'b101};
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= ssp - 32'd4;
		dat_o <= cr;
	end
	else if (ack_i) begin
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'b0000;
		ssp <= ssp - 32'd4;
		state <= TRAP3;
	end
TRAP3:
	if (!stb_o) begin
		fc_o <= {3'b101};
		stb_o <= 1'b1;
		we_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= ssp - 32'd4;
		dat_o <= sr1;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		we_o <= 1'b0;
		sel_o <= 4'b0000;
		ssp <= ssp - 32'd4;
		state <= VECTOR;
	end
RTI1:
	if (!cyc_o) begin
		fc_o <= {3'b101};
		cyc_o <= 1'b1;
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= ssp;
	end
	else if (ack_i) begin
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		im <= dat_i[18:16];
		sf <= dat_i[21];
		tf <= dat_i[23];
		ssp <= ssp + 32'd4;
		state <= RTI2;
	end
RTI2:
	if (!stb_o) begin
		fc_o <= {3'b101};
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= ssp;
	end
	else if (ack_i) begin
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		cr0 <= dat_i[3:0];
		cr1 <= dat_i[7:4];
		cr2 <= dat_i[11:8];
		cr3 <= dat_i[15:12];
		cr4 <= dat_i[19:16];
		cr5 <= dat_i[23:20];
		cr6 <= dat_i[27:24];
		cr7 <= dat_i[31:28];
		ssp <= ssp + 32'd4;
		state <= RTI3;
	end
RTI3:
	if (!stb_o) begin
		fc_o <= {3'b101};
		stb_o <= 1'b1;
		sel_o <= 4'b1111;
		adr_o <= ssp;
	end
	else if (ack_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		pc <= dat_i;
		ssp <= ssp + 32'd4;
		state <= IFETCH;
	end
MULTDIV1:
	begin
		state <= IsMult ? MULT1 : DIV1;
		cnt <= 6'd0;
		case(opcode)
		`RR:	// RR
			case(func)
			`MULS,`MULSH,`DIVS,`MODS:
				begin
					aa <= a[31] ? -a : a;
					bb <= b[31] ? -b : b;
					res_sgn <= a[31] ^ b[31];
				end
			`MULU,`MULUH,`DIVU,`MODU:
				begin
					aa <= a;
					bb <= b;
					res_sgn <= 1'b0;
				end
			endcase
		`MULSI,`DIVSI:
			begin
				aa <= a[31] ? -a : a;
				bb <= imm[31] ? -imm : imm;
				res_sgn <= a[31] ^ imm[31];
			end
		`MULUI,`DIVUI:
			begin
				aa <= a;
				bb <= imm;
				res_sgn <= 1'b0;
			end
		endcase
	end

MULT1:  begin prod <= {mp3,mp0} + {mp1,16'd0}; state <= MULT2; end
MULT2:	begin prod <= prod + {mp2,16'd0}; state <= res_sgn ? MULT6 : MULTDIV2; end
MULT6:
	begin
		state <= MULTDIV2;
		prod <= -prod;
	end

// Non-restoring divide
DIV1:
	if (cnt <= 32) begin
		cnt <= cnt + 8'd1;
		aa[0] <= ~div_dif[31];		// get test result
		aa[31:1] <= aa[30:0];			// shift quotient
		div_r0[0] <= aa[31];			// shift bit into test area (remainder)
		if (~div_dif[31])
			div_r0[31:1] <= div_dif[31:0];
		else
			div_r0[31:1] <= div_r0[30:0];
	end
	else
		state <= DIV2;
DIV2:
	begin
		state <= MULTDIV2;
		if (res_sgn) begin
			div_q <= -aa;
			div_r <= -div_r0;
		end
		else begin
			div_q <= aa;
			div_r <= div_r0;
		end
	end

MULTDIV2:
	begin
		state <= WRITEBACK;
		case(opcode)
		`RR:
			case(func)
			`MULU:	begin res <= prod[31:0]; vf <= |prod[63:32]; end
			`MULS:	begin res <= prod[31:0]; vf <= prod[31] ? ~&prod[63:32] : |prod[63:32]; end
			`MULUH:	begin res <= prod[63:32]; end
			`MULSH:	begin res <= prod[63:32]; end
			`DIVS:	res <= div_q;
			`DIVU:	res <= div_q;
			`MODS:	res <= div_r;
			`MODU:	res <= div_r;
			endcase
		`MULSI:	begin res <= prod[31:0]; vf <= prod[31] ? ~&prod[63:32] : |prod[63:32]; end
		`MULUI: begin res <= prod[31:0]; vf <= |prod[63:32]; end
		`DIVUI:	res <= div_q;
		`DIVSI:	res <= div_q;
		endcase
	end


endcase

	if (cyc_o & err_i) begin
		cyc_o <= 1'b0;
		stb_o <= 1'b0;
		sel_o <= 4'b0000;
		we_o <= 1'b0;
		inta_o <= 1'b0;
		be_addr <= adr_o;
		vector <= `BUS_ERR_VECTOR;
		state <= TRAP;
	end

end

endmodule


module BCDAdd(ci,a,b,o,c);
input ci;		// carry input
input [7:0] a;
input [7:0] b;
output [7:0] o;
output c;

wire c0,c1;

wire [4:0] hsN0 = a[3:0] + b[3:0] + ci;
wire [4:0] hsN1 = a[7:4] + b[7:4] + c0;

BCDAddAdjust u1 (hsN0,o[3:0],c0);
BCDAddAdjust u2 (hsN1,o[7:4],c);

endmodule

module BCDSub(ci,a,b,o,c);
input ci;		// carry input
input [7:0] a;
input [7:0] b;
output [7:0] o;
output c;

wire c0,c1;

wire [4:0] hdN0 = a[3:0] - b[3:0] - ci;
wire [4:0] hdN1 = a[7:4] - b[7:4] - c0;

BCDSubAdjust u1 (hdN0,o[3:0],c0);
BCDSubAdjust u2 (hdN1,o[7:4],c);

endmodule

module BCDAddAdjust(i,o,c);
input [4:0] i;
output [3:0] o;
reg [3:0] o;
output c;
reg c;
always @(i)
case(i)
5'h0: begin o = 4'h0; c = 1'b0; end
5'h1: begin o = 4'h1; c = 1'b0; end
5'h2: begin o = 4'h2; c = 1'b0; end
5'h3: begin o = 4'h3; c = 1'b0; end
5'h4: begin o = 4'h4; c = 1'b0; end
5'h5: begin o = 4'h5; c = 1'b0; end
5'h6: begin o = 4'h6; c = 1'b0; end
5'h7: begin o = 4'h7; c = 1'b0; end
5'h8: begin o = 4'h8; c = 1'b0; end
5'h9: begin o = 4'h9; c = 1'b0; end
5'hA: begin o = 4'h0; c = 1'b1; end
5'hB: begin o = 4'h1; c = 1'b1; end
5'hC: begin o = 4'h2; c = 1'b1; end
5'hD: begin o = 4'h3; c = 1'b1; end
5'hE: begin o = 4'h4; c = 1'b1; end
5'hF: begin o = 4'h5; c = 1'b1; end
5'h10:	begin o = 4'h6; c = 1'b1; end
5'h11:	begin o = 4'h7; c = 1'b1; end
5'h12:	begin o = 4'h8; c = 1'b1; end
default:	begin o = 4'h9; c = 1'b1; end
endcase
endmodule

module BCDSubAdjust(i,o,c);
input [4:0] i;
output [3:0] o;
reg [3:0] o;
output c;
reg c;
always @(i)
case(i)
5'h0: begin o = 4'h0; c = 1'b0; end
5'h1: begin o = 4'h1; c = 1'b0; end
5'h2: begin o = 4'h2; c = 1'b0; end
5'h3: begin o = 4'h3; c = 1'b0; end
5'h4: begin o = 4'h4; c = 1'b0; end
5'h5: begin o = 4'h5; c = 1'b0; end
5'h6: begin o = 4'h6; c = 1'b0; end
5'h7: begin o = 4'h7; c = 1'b0; end
5'h8: begin o = 4'h8; c = 1'b0; end
5'h9: begin o = 4'h9; c = 1'b0; end
5'h17: begin o = 4'h1; c = 1'b1; end
5'h18: begin o = 4'h2; c = 1'b1; end
5'h19: begin o = 4'h3; c = 1'b1; end
5'h1A: begin o = 4'h4; c = 1'b1; end
5'h1B: begin o = 4'h5; c = 1'b1; end
5'h1C: begin o = 4'h6; c = 1'b1; end
5'h1D: begin o = 4'h7; c = 1'b1; end
5'h1E: begin o = 4'h8; c = 1'b1; end
5'h1F: begin o = 4'h9; c = 1'b1; end
default: begin o = 4'h9; c = 1'b1; end
endcase
endmodule
module carry(op, a, b, s, c);

	input op;	// 0=add,1=sub
	input a;
	input b;
	input s;	// sum
	output c;

	assign c = op? (~a&b)|(s&~a)|(s&b) : (a&b)|(a&~s)|(b&~s);

endmodule
module overflow(op, a, b, s, v);

	input op;	// 0=add,1=sub
	input a;
	input b;
	input s;	// sum
	output v;

	// Overflow:
	// Add: the signs of the inputs are the same, and the sign of the
	// sum is different
	// Sub: the signs of the inputs are different, and the sign of
	// the sum is the same as B
	assign v = (op ^ s ^ b) & (~op ^ a ^ b);

endmodule