// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_ram.v
// Description	: a time-multiplexing SRAM module, which serves as the building block
//				  of the grouped-share-memory system.
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version			: 
//	-- 2011-06-16 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`include "timescale.v"

module gsm_ram
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	DWIDTH	= 128,	// data width = 16 bytes
	parameter	AWIDTH	= 9		// 2 BRAM = total 512 cells
)
(
	// global
	input wire	clk,
	input wire	rst_n,
	input wire	clr,

	// input port
	input wire	i_wr_en,
	input wire	[AWIDTH-1:0]	i_wr_addr,
	input wire	[DWIDTH-1:0]	i_wr_data,
	input wire	[MWIDTH-1:0]	i_multicast,

	// output port
	input wire	[MWIDTH-1:0]	i_egress_stall,
	output wire [MWIDTH-1:0]	o_egress_sel,
	output wire	[DWIDTH-1:0]	o_egress_data,

	// buffer free
	output wire o_buf_free,
	output wire [AWIDTH-1:0] o_buf_free_addr
	
	//output wire [MWIDTH-1:0]	temp
);

`include "c_functions.v"
localparam LOG_MWIDTH = clogb(MWIDTH);
localparam BRAM_RD_DELAY = 2;

//******************************
// signal declaration
//******************************
genvar i;
reg	[MWIDTH-1:0] fsm_opq_sel;
//wire [MWIDTH-1:0] opq_empty, opq_full;
wire [MWIDTH-1:0]  opq_valid, opq_rd_en;
wire [MWIDTH*AWIDTH-1:0] opq_dout;

wire [MWIDTH+DWIDTH-1:0] gsm_rd_data;
reg [MWIDTH-1:0] gsm_rd_sel;
reg [MWIDTH-1:0] gsm_rd_sel_delay[BRAM_RD_DELAY-1:0];
reg [BRAM_RD_DELAY-1:0] gsm_rd_valid_delay;
reg [AWIDTH-1:0] gsm_rd_addr;

//******************************
// logics starts here
//******************************

// finite state machine
always@(posedge clk )begin
	if(clr)
		fsm_opq_sel <= 1;
	else
		fsm_opq_sel <= {fsm_opq_sel,fsm_opq_sel[MWIDTH-1]};
end

// output pointer queues
assign opq_rd_en = fsm_opq_sel & (~i_egress_stall);// | ~opq_valid;

generate
	for(i=0; i<MWIDTH; i=i+1) begin: OPQ_GEN
		fifo_16 #(.AWIDTH(AWIDTH))
		opq(
		  .clk(clk),
		  .rst(clr),
		  .din(i_wr_addr),
		  .wr_en(i_wr_en & i_multicast[i]),
		  .rd_en(opq_rd_en[i]),
		  .dout(opq_dout[(i+1)*AWIDTH-1:i*AWIDTH]),
		  .full(),
		  .empty(),
		  .valid(opq_valid[i])
		);
	end
endgenerate

wire [AWIDTH-1:0] gsm_rd_addr_mux; 
c_select_1ofn
#(
    .num_ports(MWIDTH),
    .width(AWIDTH)
)
rd_addr_mux_inst
(
    .select(opq_valid),
    .data_in(opq_dout),
    .data_out(gsm_rd_addr_mux)
);
// central memory read address
always@(posedge clk )begin
    if(clr)
        gsm_rd_addr <= 0;
    else 
        gsm_rd_addr <= gsm_rd_addr_mux;
end

// gsm read enable, read select signal and delayed signal
always@(posedge clk )begin
	if(clr)
		gsm_rd_sel <= 0;
	else 
		gsm_rd_sel <= opq_valid;//(fsm_opq_sel & (~i_egress_stall) & opq_valid);
end

// centralized share memory for data

infer_sdpram
#(
	.DWIDTH(MWIDTH+DWIDTH),	// data width of the SRAM, 36 bit when configured to be SDP BRAM, otherwise 18 bit wide
	.AWIDTH(AWIDTH)		// address width of the SRAM
) central_mem
(
	// global
	.clk_a(clk),
	.clk_b(clk),
	
	// port a interface
	.en_a(i_wr_en),
	.write_a(i_wr_en),
	.wr_data_a({i_multicast,i_wr_data}),
	.addr_a(i_wr_addr),
	
	// port b interface
	.en_b(1'b1),
	.addr_b(gsm_rd_addr),
	.rd_data_b(gsm_rd_data)
	
);

//
///*gsm_sram central_mem(
//  .clka(clk),
//  .wea(i_wr_en),
//  .addra(i_wr_addr),
//  .dina({i_multicast,i_wr_data}),
//  .clkb(clk),
//  .addrb(gsm_rd_addr),
//  .doutb(gsm_rd_data)
//);*/

always@(posedge clk )begin
	if(clr)
		gsm_rd_sel_delay[0] <= 0;
	else 
		gsm_rd_sel_delay[0] <= gsm_rd_sel;
end

generate 
	for(i=1;i<BRAM_RD_DELAY; i=i+1) begin: GSM_RD_SEL_DELAY
		always@(posedge clk )begin
			if(clr)
				gsm_rd_sel_delay[i] <= 0;
			else 
				gsm_rd_sel_delay[i] <= gsm_rd_sel_delay[i-1];
		end
	end
endgenerate


always@(posedge clk )begin
	if(clr)
		gsm_rd_valid_delay <= 0;
	else 
		gsm_rd_valid_delay <= {gsm_rd_valid_delay,|gsm_rd_sel};
end
//**************************************************************
// hardware malloc core logic
// implemented using a single BRAM, with a 1-bit write port
// a 4-bit write port and 4-bit read port. it works as follows:
//   1. in each clk cycle, the 1-bit write port will be enabled
//      if there is a valid data sent to the output link. the 
//      address will be the same of the data being sent
//   2. the 4-bit read port is set to "WRITE_FITST" mode, so that
//      after each write, the 4-bit vector of that data can be
//      compared with its multicast vector, if the multicast task
//      for that data is done, a reset signal will be asserted
//   3. when there is a reset signal, the 4-bit write port will
//      be used to reset a specific 4-bit vector in the BRAM
//**************************************************************
reg [AWIDTH-1:0] m_addr;
reg [LOG_MWIDTH-1:0] m_sel_enc;
reg m_wr;
wire m_reset;
reg [AWIDTH-1:0] m_rst_addr[BRAM_RD_DELAY-1:0];
wire [MWIDTH-1:0] m_vec;
reg [MWIDTH-1:0] gsm_vec;
reg [BRAM_RD_DELAY-1:0] m_valid_delay;

wire [LOG_MWIDTH-1:0] m_sel_encode;
c_encode
#(
    .num_ports(MWIDTH)
)
m_select_encode
(
    .data_in(gsm_rd_sel),
    .data_out(m_sel_encode)
);
always@(posedge clk )begin
	if(clr)
		m_sel_enc <= 0;
	else 
        m_sel_enc <= m_sel_encode;
end

always@(posedge clk )begin
	if(clr)begin
		m_addr <= 0;
		m_wr <= 0;
		gsm_vec <= 0;
	end
	else begin
		m_addr <= gsm_rd_addr;
		m_wr <= |gsm_rd_sel;
		gsm_vec <= gsm_rd_data[DWIDTH+MWIDTH-1:DWIDTH];
	end
end

always@(posedge clk )begin
	if(clr)
		m_valid_delay <= 0;
	else 
		m_valid_delay <= {m_valid_delay,m_wr};
end

always@(posedge clk )begin
	if(clr)
		m_rst_addr[0] <= 0;
	else 
		m_rst_addr[0] <= m_addr;
end

generate 
	for(i=1;i<BRAM_RD_DELAY; i=i+1) begin: MULTICAST_COUNTER_ADDR_DELAY
		always@(posedge clk )begin
			if(clr)
				m_rst_addr[i] <= 0;
			else 
				m_rst_addr[i] <= m_rst_addr[i-1];
		end
	end
endgenerate

///*
//malloc_core	m_counter(
//  .clka(clk),
//  .wea(m_reset),
//  .addra({1'b0,m_rst_addr[BRAM_RD_DELAY-1]}),
//  .dina(4'b0000), // reset the counter to all 0s
//  .douta(),
//  .clkb(clk),
//  .rstb(clr),
//  .web(m_wr), // 
//  .addrb({1'b0,m_addr,m_sel_enc}),
//  .dinb(1'b1),
//  .doutb(m_vec)
//);
//*/

malloc_core_infer#(
    .DWIDTH_A(MWIDTH),
    .DWIDTH_B(1),
    .AWIDTH_A(AWIDTH),
    .AWIDTH_B(AWIDTH+LOG_MWIDTH)
)
m_counter(
  .clka(clk),
  .wea(m_reset),
  .addra(m_rst_addr[BRAM_RD_DELAY-1]),
  .dina({MWIDTH{1'b0}}), // reset the counter to all 0s
  //.douta(temp),
  .clkb(clk),
  .rstb(clr),
  .web(m_wr), // 
  .addrb({m_addr,m_sel_enc}),
  .dinb(1'b1),
  .doutb(m_vec)
);

assign m_reset = m_valid_delay[BRAM_RD_DELAY-1] & (m_vec == gsm_vec);

// output port signals
assign o_buf_free = m_reset;
assign o_buf_free_addr = m_rst_addr[BRAM_RD_DELAY-1];

assign o_egress_data = gsm_rd_data[DWIDTH-1:0];
assign o_egress_sel = gsm_rd_sel_delay[BRAM_RD_DELAY-1];

endmodule
