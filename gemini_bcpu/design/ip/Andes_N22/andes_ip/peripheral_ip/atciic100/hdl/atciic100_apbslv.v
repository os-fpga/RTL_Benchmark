// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atciic100_config.vh"
`include "atciic100_const.vh"

module atciic100_apbslv(
	  pclk,
	  presetn,
	  psel,
	  penable,
	  pwrite,
	  paddr,
	  pwdata,
	  prdata,
	  sda,
	  scl,
	  i2c_int,
	  st_gencall,
	  st_busbusy,
	  st_ack,
	  nx_rdwt,
	  nx_datacnt,
	  cmpl_trig,
	  byterecv_trig,
	  bytetrans_trig,
	  start_cond,
	  stop_cond,
	  arblose_trig,
	  addrhit_trig,
	  fifo_rd_data,
	  fifo_empty,
	  fifo_full,
	  fifo_half_full,
	  fifo_half_empty,
	  slv_hit,
	  addr,
	  int_en_byterecv,
	  int_st_cmpl,
	  iic_rst,
	  fifo_clr,
	  do_ack,
	  do_nack,
	  trans,
	  fifo_wr,
	  fifo_rd,
	  fifo_wr_data,
	  phase_S,
	  phase_adr,
	  phase_dat,
	  phase_P,
	  rdwt,
	  datacnt,
	  t_sp,
	  t_hddat,
	  t_sudat,
	  t_high,
	  t_low,
	  addressing,
	  master,
	  dma_en,
	  iic_en,
	  tpm
);

parameter	CMD_IIC_RST		= 3'b101;
parameter	CMD_FIFO_CLR		= 3'b100;
parameter	CMD_DO_NACK		= 3'b011;
parameter	CMD_DO_ACK		= 3'b010;
parameter	CMD_TRANS		= 3'b001;

input			pclk;
input			presetn;
input			psel;
input			penable;
input			pwrite;
input		[5:2]	paddr;
input		[31:0]	pwdata;
output		[31:0]	prdata;

input			sda;
input			scl;
output			i2c_int;

input			st_gencall;
input			st_busbusy;
input			st_ack;
input			nx_rdwt;
input		[8:0]	nx_datacnt;
input			cmpl_trig;
input			byterecv_trig;
input			bytetrans_trig;
input			start_cond;
input			stop_cond;
input			arblose_trig;
input			addrhit_trig;
input		[7:0]	fifo_rd_data;
input			fifo_empty;
input			fifo_full;
input			fifo_half_full;
input			fifo_half_empty;
input			slv_hit;

output		[9:0]	addr;
output			int_en_byterecv;
output			int_st_cmpl;
output			iic_rst;
output			fifo_clr;
output			do_ack;
output			do_nack;
output			trans;
output			fifo_wr;
output			fifo_rd;
output		[7:0]	fifo_wr_data;
output			phase_S;
output			phase_adr;
output			phase_dat;
output			phase_P;
output			rdwt;
output		[8:0]	datacnt;
output		[2:0]	t_sp;
output		[4:0]	t_hddat;
output		[4:0]	t_sudat;
output		[9:0]	t_high;
output		[9:0]	t_low;
output			addressing;
output			master;
output			dma_en;
output			iic_en;
output		[4:0]	tpm;
reg			s0;
reg			int_en_byterecv;
reg			s1;
reg			s2;
reg			s3;
reg			s4;
reg			s5;
reg			s6;
reg			s7;
reg			s8;

reg			int_st_cmpl;
reg			s9;
reg			s10;
reg			s11;
reg			s12;
reg			s13;
reg			s14;

reg			phase_S;
reg			phase_adr;
reg			phase_dat;
reg			phase_P;
reg			rdwt;
reg		[8:0]	datacnt;

reg			trans;

reg		[2:0]	t_sp;
reg		[4:0]	t_hddat;
reg		[4:0]	t_sudat;
reg	    		s15;
reg		[8:0]	s16;
reg			dma_en;
reg			master;
reg			addressing;
reg			iic_en;

reg		[9:0]	addr;
reg		[7:0]	s17;

reg		[4:0]	tpm;

wire			s18;
wire			s19;
wire			s20;
wire			s21;
wire			s22;
wire			s23;
wire			s24;
wire			s25;
wire			s26;
wire			s27;

wire			s28;

wire		[31:0]	s29;
wire		[1:0]	s30;
wire		[9:0]	s31;
wire		[9:0]	s32;
wire		[4:0]	s33;
wire		[12:0]	s34;
wire		[28:0]	s35;
wire		[9:0]	t_high;
wire		[9:0]	t_low;
wire 			s36;

assign	s29	= `ATCIIC100_PRODUCT_ID;
assign	s30	= `ATCIIC100_FIFO_CONFIG;
assign	s31	= {s0, int_en_byterecv, s1, s2, s3, s4,
				   s5, s6, s7, s8};
assign	s32	= {int_st_cmpl, s9, s10, s11, s12, s13,
				   s14, s36, fifo_full, fifo_empty};
assign	s33	= {sda, scl, st_gencall, st_busbusy, st_ack};
assign	s34	= {phase_S, phase_adr, phase_dat, phase_P, rdwt, datacnt[7:0]};
assign	s35	= {t_sudat, t_sp, t_hddat, 2'b0, s15, s16, dma_en, master, addressing, iic_en};

assign	s18		= psel & ({paddr[5:2], 2'b0} == 6'h00);
assign	s19		= psel & ({paddr[5:2], 2'b0} == 6'h10);
assign	s20	= psel & ({paddr[5:2], 2'b0} == 6'h14);
assign	s21	= psel & ({paddr[5:2], 2'b0} == 6'h18);
assign	s22	= psel & ({paddr[5:2], 2'b0} == 6'h1C);
assign	s23	= psel & ({paddr[5:2], 2'b0} == 6'h20);
assign	s24	= psel & ({paddr[5:2], 2'b0} == 6'h24);
assign	s25		= psel & ({paddr[5:2], 2'b0} == 6'h28);
assign	s26	= psel & ({paddr[5:2], 2'b0} == 6'h2C);
assign	s27		= psel & ({paddr[5:2], 2'b0} == 6'h30);

assign s28 = penable & pwrite;

always @(posedge pclk or negedge presetn)
	if (!presetn) begin
		s0		<= 1'b0;
		int_en_byterecv 	<= 1'b0;
		s1 	<= 1'b0;
		s2		<= 1'b0;
		s3		<= 1'b0;
		s4		<= 1'b0;
		s5		<= 1'b0;
		s6		<= 1'b0;
		s7		<= 1'b0;
		s8		<= 1'b0;
	end
	else if (iic_rst) begin
		s0		<= 1'b0;
		int_en_byterecv 	<= 1'b0;
		s1 	<= 1'b0;
		s2		<= 1'b0;
		s3		<= 1'b0;
		s4		<= 1'b0;
		s5		<= 1'b0;
		s6		<= 1'b0;
		s7		<= 1'b0;
		s8		<= 1'b0;
	end
	else if (s28 & s20) begin
		s0		<= pwdata[9];
		int_en_byterecv 	<= pwdata[8];
		s1 	<= pwdata[7];
		s2		<= pwdata[6];
		s3		<= pwdata[5];
		s4		<= pwdata[4];
		s5		<= pwdata[3];
		s6		<= pwdata[2];
		s7		<= pwdata[1];
		s8		<= pwdata[0];
	end


assign 	i2c_int =
	(fifo_full & s7) |
	(fifo_empty & s8) |
	(s36 & s6) |
	(s14 & s5) |
	(s13 & s4) |
	(s12 & s3) |
	(s11 & s2) |
	(s10 & s1) |
	(s9 & int_en_byterecv) |
	(int_st_cmpl & s0);

always @(posedge pclk or negedge presetn)
	if (!presetn)
		int_st_cmpl <= 1'b0;
	else if (iic_rst | (s28 & s21 & pwdata[9]))
		int_st_cmpl <= 1'b0;
	else if (cmpl_trig)
		int_st_cmpl <= 1'b1;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		s9 <= 1'b0;
	else if (iic_rst | (s28 & s21 & pwdata[8]))
		s9 <= 1'b0;
	else if (byterecv_trig)
		s9 <= 1'b1;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		s10 <= 1'b0;
	else if (iic_rst | (s28 & s21 & pwdata[7]))
		s10 <= 1'b0;
	else if (bytetrans_trig)
		s10 <= 1'b1;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		s11 <= 1'b0;
	else if (iic_rst | (s28 & s21 & pwdata[6]))
		s11 <= 1'b0;
	else if (start_cond)
		s11 <= 1'b1;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		s12 <= 1'b0;
	else if (iic_rst | slv_hit | (s28 & s21 & pwdata[5]))
		s12 <= 1'b0;
	else if (stop_cond)
		s12 <= 1'b1;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		s13 <= 1'b0;
	else if (iic_rst | (s28 & s21 & pwdata[4]))
		s13 <= 1'b0;
	else if (arblose_trig)
		s13 <= 1'b1;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		s14 <= 1'b0;
	else if (iic_rst | (s28 & s21 & pwdata[3]))
		s14 <= 1'b0;
	else if (addrhit_trig)
		s14 <= 1'b1;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		addr <= 10'b0;
	else if (s28 & s22)
		addr <= pwdata[9:0];

assign	fifo_wr			= s28 & s23 & !fifo_full;
assign	fifo_wr_data	= pwdata[7:0];
assign	fifo_rd			= ~pwrite & penable & s23 & !fifo_empty;
assign 	s36		= (master ^ rdwt) ? fifo_half_empty : fifo_half_full;

always @(posedge pclk or negedge presetn)
	if (!presetn) begin
		phase_S		<= 1'b1;
		phase_adr	<= 1'b1;
		phase_dat	<= 1'b1;
		phase_P		<= 1'b1;
	end
	else if (s28 & s24) begin
		phase_S		<= pwdata[12];
		phase_adr	<= pwdata[11];
		phase_dat	<= pwdata[10];
		phase_P		<= pwdata[9];
	end

always @(posedge pclk or negedge presetn)
	if (!presetn)
		rdwt	<= 1'b0;
	else if (s28 & s24)
		rdwt	<= pwdata[8];
	else
		rdwt	<= nx_rdwt;

always @(posedge pclk or negedge presetn)
	if (!presetn)
		datacnt	<= 9'h0;
	else if (s28 & s24)
		datacnt	<= {pwdata[7:0] == 8'h0, pwdata[7:0]};
	else
		datacnt	<= nx_datacnt;


assign fifo_clr	= (s28 && s25 && (pwdata[2:0] == CMD_FIFO_CLR)) | iic_rst;
assign do_nack	=  s28 && s25 && (pwdata[2:0] == CMD_DO_NACK);
assign do_ack	=  s28 && s25 && (pwdata[2:0] == CMD_DO_ACK);
assign iic_rst	=  s28 && s25 && (pwdata[2:0] == CMD_IIC_RST);

always @(posedge pclk or negedge presetn)
	if (!presetn)
		trans <= 1'b0;
	else if (s28 && s25 && (pwdata[2:0] == CMD_TRANS))
		trans <= 1'b1;
	else if (cmpl_trig || arblose_trig)
		trans <= 1'b0;

assign	t_high	= {1'b0, s16};
assign	t_low	= s15 ? {s16, 1'b1} : {1'b0, s16};

always @(posedge pclk or negedge presetn)
	if (!presetn) begin
		t_sudat		<= 5'h05;
		t_sp		<= 3'h1;
		t_hddat		<= 5'h05;
		s15	<= 1'h1;
		s16		<= 9'h010;
		dma_en		<= 1'b0;
		master		<= 1'b0;
		addressing	<= 1'b0;
		iic_en		<= 1'b0;
	end
	else if (s28 & s26) begin
		t_sudat		<= pwdata[28:24];
		t_sp		<= pwdata[23:21];
		t_hddat		<= pwdata[20:16];
		s15	<= pwdata[13];
		s16		<= pwdata[12:4];
		dma_en		<= pwdata[3];
		master		<= pwdata[2];
		addressing	<= pwdata[1];
		iic_en		<= pwdata[0];
	end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		tpm <= 5'h00;
	end
	else if (s28 & s27) begin
		tpm <= pwdata[4:0];
	end
end

assign	prdata = {32{~pwrite}} & (
		{       {32{s18}}     & s29} |
		{30'h0, { 2{s19}}    & s30} |
		{22'h0, {10{s20}} & s31} |
		{17'h0, {15{s21}}  & {s33, s32}} |
		{22'h0, {10{s22}}   & addr} |
		{24'h0, { 8{s23 & !fifo_empty}} & fifo_rd_data} |
		{19'h0, {13{s24}}   & s34} |
		{31'h0, s25          & trans} |
		{3'h0,  {29{s26}}   & s35} |
		{27'h0, {5{s27}}     & tpm});

endmodule
