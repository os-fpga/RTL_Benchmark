// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atciic100_config.vh"
`include "atciic100_const.vh"

module atciic100_ctrl(
		  pclk,
		  presetn,
		  scl,
		  sda,
		  scl_falling,
		  scl_rising,
		  sda_falling,
		  sda_rising,
		  scl_o,
		  sda_o,
		  addr,
		  int_en_byterecv,
		  iic_rst,
		  do_ack,
		  do_nack,
		  trans,
		  phase_S,
		  phase_adr,
		  phase_dat,
		  phase_P,
		  rdwt,
		  datacnt,
		  t_hddat,
		  t_sudat,
		  t_high,
		  t_low,
		  dma_en,
		  master,
		  addressing,
		  iic_en,
		  dma_ack,
		  fifo_rd_data,
		  fifo_full,
		  fifo_empty,
		  fifo_entries,
		  int_st_cmpl,
		  tpm,
		  timing_parameter_scaling_pulse,
		  dma_req,
		  st_busbusy,
		  st_ack,
		  start_cond,
		  stop_cond,
		  st_gencall,
		  nx_datacnt,
		  nx_rdwt,
		  cmpl_trig,
		  byterecv_trig,
		  bytetrans_trig,
		  arblose_trig,
		  addrhit_trig,
		  fifo_wr_data,
		  fifo_wr,
		  fifo_rd,
		  fifo_clr,
		  slv_hit
);

parameter [4:0]	ST_IDLE		= 5'd0,
				ST_S_S		= 5'd1,
				ST_S_ADR7	= 5'd2,
				ST_S_ACK7	= 5'd3,
				ST_S_ADR10	= 5'd4,
				ST_S_ACK10	= 5'd5,
				ST_S_DAT_T	= 5'd6,
				ST_S_ACK_T	= 5'd7,
				ST_S_DAT_R	= 5'd8,
				ST_S_ACK_R	= 5'd9,
				ST_M_INIT	= 5'd16,
				ST_M_S		= 5'd17,
				ST_M_ADR7	= 5'd18,
				ST_M_ACK7	= 5'd19,
				ST_M_ADR10	= 5'd20,
				ST_M_ACK10	= 5'd21,
				ST_M_DAT_T	= 5'd22,
				ST_M_ACK_T	= 5'd23,
				ST_M_DAT_R	= 5'd24,
				ST_M_ACK_R	= 5'd25,
				ST_M_P		= 5'd26;

parameter TEN_BIT_ADR	= 5'b11110;
parameter IIC_ACK		= 1'b0;
parameter IIC_NACK		= 1'b1;

localparam TPM_CNTR_ZERO = 5'd0;

input			pclk;
input			presetn;

input			scl;
input			sda;
input			scl_falling;
input			scl_rising;
input			sda_falling;
input			sda_rising;

output			scl_o;
output			sda_o;

input	[9:0]	addr;
input			int_en_byterecv;
input			iic_rst;
input			do_ack;
input			do_nack;
input			trans;
input			phase_S;
input			phase_adr;
input			phase_dat;
input			phase_P;
input			rdwt;
input	[8:0]	datacnt;
input	[4:0]	t_hddat;
input	[4:0]	t_sudat;
input	[9:0]	t_high;
input	[9:0]	t_low;
input			dma_en;
input			master;
input			addressing;
input			iic_en;
input			dma_ack;
input	[7:0]	fifo_rd_data;
input			fifo_full;
input			fifo_empty;
input	[`ATCIIC100_INDEX_WIDTH-1:0]	fifo_entries;
input			int_st_cmpl;
input	[4:0]	tpm;

output			timing_parameter_scaling_pulse;
output			dma_req;
output			st_busbusy;
output			st_ack;
output			start_cond;
output			stop_cond;
output			st_gencall;
output	[8:0]	nx_datacnt;
output			nx_rdwt;
output			cmpl_trig;
output			byterecv_trig;
output			bytetrans_trig;
output			arblose_trig;
output			addrhit_trig;
output	[7:0]	fifo_wr_data;
output			fifo_wr;
output			fifo_rd;
output			fifo_clr;
output			slv_hit;

reg				scl_o;
reg				sda_o;
reg				s0;
reg				s1;

reg				st_busbusy;
reg				s2;
reg				st_ack;
reg				st_gencall;
reg				s3;
reg		[8:0]	nx_datacnt;
reg				nx_rdwt;

reg		[9:0]	s4;
reg		[7:0]	s5;
reg		[2:0]	s6;

reg				s7;
reg				s8;

reg		[4:0]	s9;
reg		[4:0]	s10;

wire			cmpl_trig;
wire			byterecv_trig;
wire			bytetrans_trig;
wire			arblose_trig;
wire			addrhit_trig;
reg				dma_req;


wire			start_cond;
wire			stop_cond;
wire			s11;
wire			s12;
wire			s13;
wire			s14;
wire			s15;
wire			s16;
wire			s17;
wire			s18;
wire			slv_hit;
reg				s19;
reg				s20;

wire			s21;
wire			s22;
wire			fifo_wr;
wire			fifo_rd;

reg				timing_parameter_scaling_pulse;
reg		[4:0]	s23;
wire			s24;
wire	[4:0]	s25;

assign	start_cond	= sda_falling & scl & !scl_falling & !scl_rising;
assign	stop_cond	= sda_rising  & scl & !scl_falling & !scl_rising;

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		st_busbusy <= 1'b0;
	else if (iic_rst | stop_cond)
		st_busbusy <= 1'b0;
	else if (start_cond)
		st_busbusy <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s2 <= 1'b0;
	else if (iic_rst | stop_cond | arblose_trig)
		s2 <= 1'b0;
	else if ((s9 == ST_M_S) && start_cond)
		s2 <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s20 <= 1'b0;
	else if (!master && s13 && s7 && s8)
		s20 <= 1'b1;
	else if (scl_rising)
		s20 <= 1'b0;
end

assign 	s11	=  scl && (s4 == t_high) && timing_parameter_scaling_pulse;
assign 	s12	= !scl && (s4 == t_low)  && timing_parameter_scaling_pulse;
assign	s13	= !scl && (s4 == {5'b0, t_hddat}) && !s20 && timing_parameter_scaling_pulse;
assign 	s14	= !scl && (s4 == {5'b0, t_sudat}) && s20  && timing_parameter_scaling_pulse;

assign	s15	= !addressing && (s5[7:1] == addr[6:0]);
assign	s16	= addressing && (s5[7:1] == {5'b11110, addr[9:8]}) && (s5[0] == s3);
assign	s17	= addressing && (s5[7:0] == addr[7:0]);
assign	s18	= s5[7:1] == 7'b0;

always @* begin
	if (stop_cond || iic_rst || arblose_trig)
		s10 = ST_IDLE;
	else begin
		s10 = s9;
		case (s9)
			ST_S_S:
				if (scl_falling)							s10 = ST_S_ADR7;
			ST_S_ADR7:
				if (scl_falling && (s6 == 3'h0)) begin
					if (s18 || s15 || s16)	s10 = ST_S_ACK7;
					else									s10 = ST_IDLE;
				end
			ST_S_ACK7:
				if (scl_falling) begin
					if (s3 | rdwt)					s10 = ST_S_DAT_T;
					else if (addressing && !s18)	s10 = ST_S_ADR10;
					else									s10 = ST_S_DAT_R;
				end
			ST_S_ADR10:
				if (scl_falling && (s6 == 3'h0)) begin
					if (s17)						s10 = ST_S_ACK10;
					else									s10 = ST_IDLE;
				end
			ST_S_ACK10:
				if (scl_falling)							s10 = ST_S_DAT_R;
			ST_S_DAT_T:
				if (scl_falling && (s6 == 3'b0))			s10 = ST_S_ACK_T;
			ST_S_ACK_T:
				if (scl_falling) begin
					if (st_ack)								s10 = ST_S_DAT_T;
					else 									s10 = ST_IDLE;
				end
			ST_S_DAT_R:
				if (start_cond)								s10 = ST_S_S;
				else if (scl_falling && (s6 == 3'b0))  	s10 = ST_S_ACK_R;
			ST_S_ACK_R:
				if (scl_falling) begin
					if (st_ack)								s10 = ST_S_DAT_R;
					else									s10 = ST_IDLE;
				end
			ST_M_INIT:
				if (!scl)									s10 = phase_adr ? ST_M_ADR7 : phase_dat ? rdwt ? ST_M_DAT_R : ST_M_DAT_T : ST_M_P;
			ST_M_S:
				if (scl_falling) 							s10 = phase_adr ? ST_M_ADR7 : phase_dat ? rdwt ? ST_M_DAT_R : ST_M_DAT_T : phase_P ? ST_M_P : ST_IDLE;
			ST_M_ADR7:
				if (scl_falling && (s6 == 3'b0))			s10 = ST_M_ACK7;
			ST_M_ACK7:
				if (scl_falling) begin
					if (st_ack) begin
						if (s3 | !addressing)		s10 = phase_dat ? rdwt ? ST_M_DAT_R : ST_M_DAT_T : phase_P ? ST_M_P : ST_IDLE;
						else								s10 = ST_M_ADR10;
					end
					else									s10 = phase_P ? ST_M_P : ST_IDLE;
				end
			ST_M_ADR10:
				if (scl_falling && (s6 == 3'b0)) 			s10 = ST_M_ACK10;
			ST_M_ACK10:
				if (scl_falling) begin
					if (st_ack) begin
						if (!rdwt)							s10 = phase_dat ? ST_M_DAT_T : phase_P ? ST_M_P : ST_IDLE;
						else								s10 = ST_M_S;
					end
					else									s10 = phase_P ? ST_M_P : ST_IDLE;
				end
			ST_M_DAT_T:
				if (scl_falling && (s6 == 3'b0)) 			s10 = ST_M_ACK_T;
			ST_M_ACK_T:
				if (scl_falling) begin
					if (!st_ack || (datacnt == 9'h0))		s10 = phase_P ? ST_M_P : ST_IDLE;
					else 									s10 = ST_M_DAT_T;
				end
			ST_M_DAT_R:
				if (scl_falling && (s6 == 3'b0)) 			s10 = ST_M_ACK_R;
			ST_M_ACK_R:
				if (scl_falling) begin
					if (st_ack)								s10 = ST_M_DAT_R;
					else 									s10 = phase_P ? ST_M_P : ST_IDLE;
				end
			ST_M_P:
				if ((s11 && scl && sda) || scl_falling)	s10 = ST_IDLE;
			default:
				if (!master && start_cond && iic_en) 		s10 = ST_S_S;
				else if (master && trans && iic_en && (!st_busbusy || s2))			s10 = phase_S ? ST_M_S : ST_M_INIT;
		endcase
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s9 <= ST_IDLE;
	else
		s9 <= s10;
end

always @* begin
	s0 = scl_o;
	case (s9)
		ST_M_INIT:
			s0 = 1'b0;
		ST_M_S:
			if (s12)
				s0 = 1'b1;
			else if ((s11 || scl_falling) && !sda_o)
				s0 = 1'b0;
		ST_S_ACK7:
			if (!int_st_cmpl || addressing)
				s0 = 1'b1;
			else
				s0 = 1'b0;
		ST_S_ACK10:
			if (!int_st_cmpl)
				s0 = 1'b1;
			else
				s0 = 1'b0;
		ST_S_DAT_T:
			if (!s7)
				s0 = 1'b0;
			else if (s14)
				s0 = 1'b1;
		ST_S_ACK_R:
			if (!s8 || !s7)
				s0 = 1'b0;
			else if (s14)
				s0 = 1'b1;
		ST_M_ADR7, ST_M_ACK7, ST_M_ADR10, ST_M_ACK10,
			ST_M_DAT_T, ST_M_ACK_T, ST_M_DAT_R, ST_M_ACK_R:
			if (s12)
				s0 = 1'b1;
			else if (s11 || scl_falling)
				s0 = 1'b0;
		ST_M_P:
			if (s12)
				s0 = 1'b1;
		default:
				s0 = scl_o;
	endcase
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		scl_o <= 1'b1;
	else if (iic_rst || arblose_trig)
		scl_o <= 1'b1;
	else if (timing_parameter_scaling_pulse)
		scl_o <= s0;
end

always @* begin
	s1 = sda_o;
	case(s9)
		ST_M_S:
			if (s13)
				s1 = 1'b1;
			else if(s11)
				s1 = 1'b0;
		ST_S_DAT_T, ST_M_ADR7, ST_M_ADR10, ST_M_DAT_T:
			if (s13)
				s1 = s5[7];
		ST_S_ACK7, ST_S_ACK10, ST_S_ACK_R, ST_M_ACK_R:
			if (s13)
				s1 = st_ack ? IIC_ACK : IIC_NACK;
		ST_S_ADR10, ST_S_DAT_R, ST_S_ACK_T, ST_M_ACK7, ST_M_ACK10, ST_M_DAT_R, ST_M_ACK_T:
			if (s13)
				s1 = 1'b1;
		ST_M_P:
			if (s13)
				s1 = 1'b0;
			else if (s11)
				s1 = 1'b1;
		default:
			s1 = sda_o;
	endcase
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		sda_o <= 1'b1;
	else if (iic_rst || arblose_trig)
		sda_o <= 1'b1;
	else if (timing_parameter_scaling_pulse)
		sda_o <= s1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s6 <= 3'h7;
	else if (s9 == ST_IDLE)
		s6 <= 3'h7;
    else if (((s9 == ST_S_ADR7) || (s9 == ST_S_ADR10) || (s9 == ST_S_DAT_T) || (s9 == ST_S_DAT_R) ||
			  (s9 == ST_M_ADR7) || (s9 == ST_M_ADR10) || (s9 == ST_M_DAT_T) || (s9 == ST_M_DAT_R)) && scl_falling)
		s6 <= s6 - 3'h1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s5 <= 8'b0;
	else if (fifo_rd)
		s5 <= fifo_rd_data;
	else if ((s9 != ST_M_ADR7) && (s10 == ST_M_ADR7))
		s5 <= addressing ? {TEN_BIT_ADR, addr[9:8], s3} : {addr[6:0], rdwt};
	else if ((s9 == ST_M_ACK7) && (s10 == ST_M_ADR10))
		s5 <= addr[7:0];
	else if (((s9 == ST_M_ADR7) || (s9 == ST_M_ADR10) || (s9 == ST_M_DAT_T) || (s9 == ST_S_DAT_T) ||
		(s9 == ST_S_ADR7)  || (s9 == ST_S_ADR10) ||	(s9 == ST_S_DAT_R) || (s9 == ST_M_DAT_R))
		&& scl_rising)
		s5 <= {s5[6:0], sda};
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s3 <= 1'b0;
	else if (s9 == ST_IDLE)
		s3 <= 1'b0;
	else if ((s9 == ST_S_ADR10) && (s10 == ST_S_ACK10) && s17)
		s3 <= 1'b1;
	else if ((s9 == ST_M_ACK10) && scl_rising && !sda)
		s3 <= 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s7 <= 1'b1;
	else if (iic_rst | (s10 == ST_IDLE))
		s7 <= 1'b1;
	else if ((((s9 == ST_S_ACK_R) || (s9 == ST_M_ACK_R)) && !fifo_full) ||
			 (((s9 == ST_S_DAT_T) || (s9 == ST_M_DAT_T)) && !fifo_empty))
		s7 <= 1'b1;
	else if ((((s9 == ST_S_DAT_R) && (s10 == ST_S_ACK_R)) || ((s9 == ST_M_DAT_R) && (s10 == ST_M_ACK_R))) && fifo_full)
		s7 <= 1'b0;
	else if ((((s9 != ST_S_DAT_T) && (s10 == ST_S_DAT_T)) || ((s9 != ST_M_DAT_T) && (s10 == ST_M_DAT_T))) && fifo_empty)
		s7 <= 1'b0;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s8 <= 1'b1;
	else if (do_ack | do_nack | iic_rst | (s10 == ST_IDLE))
		s8 <= 1'b1;
	else if ((((s9 == ST_S_DAT_R) && (s10 == ST_S_ACK_R)) || ((s9 == ST_M_DAT_R) && (s10 == ST_M_ACK_R))) && int_en_byterecv)
		s8 <= 1'b0;
end

assign s21 = (master && (scl_o != scl)) || !s7 || !s8 || (s9 == ST_M_INIT);
assign s22 = scl_falling || scl_rising || iic_rst || (s9 == ST_IDLE) ||
					(((s9 == ST_M_P) || (s9 == ST_M_S)) && s11) ||
					(!master && s13 && !s20);

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s4 <= 10'h0;
	else if (s22 && timing_parameter_scaling_pulse)
		s4 <= 10'h0;
	else if (!s21 && timing_parameter_scaling_pulse)
		s4 <= s4 + 10'h001;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		s19 <= 1'b0;
	else if (s9 == ST_IDLE)
		s19 <= 1'b0;
	else if ((s9 == ST_S_ACK10) && (s10 == ST_S_DAT_R))
		s19 <= 1'b1;
	else if ((s9 == ST_S_DAT_R) && scl_falling && (s6 == 3'h7))
		s19 <= 1'b0;
end

assign slv_hit = ((s9 == ST_S_ACK7) && scl_rising && (s18 || !addressing || s3)) ||
				((s9 == ST_S_DAT_R) && scl_falling && (s6 == 3'h7) && s19);
always @* begin
	if (slv_hit & !dma_en)
		nx_datacnt = 9'h0;
	else if (fifo_rd | fifo_wr)
		nx_datacnt = (master | dma_en) ? (datacnt - 9'h001) : (datacnt + 9'h001);
	else
		nx_datacnt = datacnt;
end

always @* begin
	if ((s9 == ST_S_ADR7) && (s10 == ST_S_ACK7))
		nx_rdwt = s5[0];
	else
		nx_rdwt = rdwt;
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		st_gencall <= 1'b0;
	else if (iic_rst)
		st_gencall <= 1'b0;
	else if (slv_hit) begin
		if ((s9 == ST_S_ACK7) && scl_rising && s18)
			st_gencall <= 1'b1;
		else
			st_gencall <= 1'b0;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		st_ack <= 1'b0;
	else if (iic_rst)
		st_ack <= 1'b0;
	else if ((s9 == ST_M_DAT_R) && (s10 == ST_M_ACK_R))
		st_ack <= (datacnt != 9'h001);
	else if ((s9 == ST_S_DAT_R) && (s10 == ST_S_ACK_R))
		st_ack <= 1'b1;
	else if (((s9 == ST_S_ACK_R) || (s9 == ST_M_ACK_R)) && !s8) begin
		if (do_ack)
			st_ack <= 1'b1;
		else if (do_nack)
			st_ack <= 1'b0;
	end
	else if (s9 == ST_S_ADR7) begin
		if (s10 == ST_S_ACK7)
			st_ack <= 1'b1;
		else if (s10 == ST_IDLE)
			st_ack <= 1'b0;
	end
	else if (s9 == ST_S_ADR10) begin
		if (s10 == ST_S_ACK10)
			st_ack <= 1'b1;
		else if (s10 == ST_IDLE)
			st_ack <= 1'b0;
	end
	else if (((s9 == ST_M_ACK7) || (s9 == ST_M_ACK10) ||
			(s9 == ST_M_ACK_T) || (s9 == ST_S_ACK_T)) && scl_rising)
		st_ack <= (sda == IIC_ACK);
end

assign arblose_trig =
	((s9 == ST_M_S) && s11 && sda_o && !sda) ||
	(((s9 == ST_M_ADR7) || (s9 == ST_M_ADR10) || (s9 == ST_M_DAT_T) || (s9 == ST_M_ACK_R)) &&
		((scl_rising && sda_o && !sda) || start_cond || stop_cond)) ||
	(((s9 == ST_M_DAT_R) || (s9 == ST_M_ACK_T)) && (start_cond || stop_cond));

assign byterecv_trig =
	((s9 == ST_S_DAT_R) && (s10 == ST_S_ACK_R)) ||
	((s9 == ST_M_DAT_R) && (s10 == ST_M_ACK_R));

assign bytetrans_trig =
	((s9 == ST_M_ACK_T) || (s9 == ST_S_ACK_T)) && scl_falling;

assign addrhit_trig =
	slv_hit ||
	((s9 == ST_M_ACK7) && scl_rising && (sda == IIC_ACK) && (s3 | !addressing | s18)) ||
	((s9 == ST_M_ACK10) && scl_rising && (sda == IIC_ACK) && !rdwt);

assign cmpl_trig =
	(master && !arblose_trig && (s9 != ST_IDLE) && (s10 == ST_IDLE)) ||
	(((s9 == ST_S_DAT_R) || (s9 == ST_S_DAT_T) || (s9 == ST_S_ACK_T) || (s9 == ST_S_ACK_R)) && (s10 == ST_IDLE)) ||
	((s9 == ST_S_DAT_R) && (s10 == ST_S_S));

always @(posedge pclk or negedge presetn) begin
	if (!presetn)
		dma_req <= 1'b0;
	else if (dma_ack | iic_rst | !dma_en | !iic_en)
		dma_req <= 1'b0;
	else if (master && rdwt && !fifo_empty)
		dma_req <= 1'b1;
	else if (master && !rdwt && !fifo_full && (s9 != ST_IDLE) &&
				({{9-`ATCIIC100_INDEX_WIDTH{1'b0}}, fifo_entries} < datacnt))
		dma_req	<= 1'b1;
	else if (!master && !rdwt && !fifo_empty)
		dma_req <= 1'b1;
	else if (!master && rdwt && !fifo_full && ((s9 == ST_S_DAT_T) || (s9 == ST_S_ACK_T)) &&
				({{9-`ATCIIC100_INDEX_WIDTH{1'b0}}, fifo_entries} < datacnt))
		dma_req <= 1'b1;
end

assign	fifo_wr = (((s9 == ST_S_DAT_R) && (s10 == ST_S_ACK_R)) || ((s9 == ST_M_DAT_R) && (s10 == ST_M_ACK_R)) ||
					(((s9 == ST_S_ACK_R) || (s9 == ST_M_ACK_R)) && !s7)) && !fifo_full;
assign	fifo_rd = (((s9 != ST_S_DAT_T) && (s10 == ST_S_DAT_T)) || ((s9 != ST_M_DAT_T) && (s10 == ST_M_DAT_T)) ||
					(((s9 == ST_S_DAT_T) || (s9 == ST_M_DAT_T)) && !s7)) && !fifo_empty;

assign	fifo_wr_data = s5[7:0];

assign	fifo_clr = (((s9 == ST_IDLE) || (s9 == ST_M_S) || (s9 == ST_M_ACK7)) && (s10 == ST_M_DAT_R)) ||
					(((s9 == ST_S_ACK7) || (s9 == ST_S_ACK10)) && (s10 == ST_S_DAT_R));

assign s25 = (!iic_en) ? tpm
                                            : ((s23 == TPM_CNTR_ZERO) ? tpm
											: (s23 - 5'd1));

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		s23 <= 5'd0;
	end
	else if (iic_en) begin
		s23 <= s25;
	end
end

assign s24 = (s23 == TPM_CNTR_ZERO);

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		timing_parameter_scaling_pulse <= 1'b1;
	end
	else begin
		timing_parameter_scaling_pulse <= s24;
	end
end


endmodule
