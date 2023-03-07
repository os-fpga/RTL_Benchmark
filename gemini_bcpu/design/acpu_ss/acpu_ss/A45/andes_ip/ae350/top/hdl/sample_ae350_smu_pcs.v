`include "config.inc"
`include "sample_ae350_smu_config.vh"
`include "sample_ae350_smu_const.vh"
module sample_ae350_smu_pcs (
input		pclk,
input		presetn,

output	[31:0]	pcs_rdata,
input		pcs_sel,
input	[31:0]	pcs_wdata,
input		pcs_write,
input		pcs_sel_cfg,
input		pcs_sel_scratch,
input		pcs_sel_misc,
input		pcs_sel_misc2,
input		pcs_sel_we,
input		pcs_sel_ctl,
input		pcs_sel_status,
input		pcs_sel_cer,
input		pcs_hart_rst,

input	[31:1]	pcs_wakeup_event,

output		pcs_int,
output		pcs_wakeup,
output		pcs_standby_req,
input		pcs_standby_ok,
output		pcs_frq_scale_req,
output	[2:0]	pcs_frq_scale,
output	[31:0]	pcs_frq_clkon,
input		pcs_frq_scale_ack,
output		pcs_vol_scale_req,
output	[2:0]	pcs_vol_scale,
input		pcs_vol_scale_ack,
output		pcs_iso,
output		pcs_reten,
output		pcs_resetn,
output	[3:0]	pcs_mem_init,
input	[4:0]	pcs_reset_source
);

assign	pcs_rdata 		= 32'b0;
assign	pcs_int 		= 1'b0;
assign	pcs_wakeup		= 1'b0;
assign	pcs_standby_req		= 1'b0;
assign	pcs_vol_scale_req	= 1'b0;
assign	pcs_vol_scale		= 3'b0;
assign	pcs_iso			= 1'b0;
assign	pcs_reten		= 1'b0;
assign	pcs_resetn		= pcs_hart_rst;
assign	pcs_mem_init 		= 4'b1111;

wire pcs_write_valid = pcs_sel & pcs_write;
wire update_cer = pcs_write_valid & pcs_sel_cer;

reg [3:0] clkon_for_cer;
always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		clkon_for_cer <= 4'hf;
	end
	else if (update_cer) begin
		clkon_for_cer <= {pcs_wdata[11], pcs_wdata[2:0]};
	end
end

wire		core_clkon	= clkon_for_cer[0];
wire		hclkon		= clkon_for_cer[1];
wire		pclkon		= clkon_for_cer[2];
wire		aclkon		= clkon_for_cer[3];

wire		pcs_frq_scale_ack_sync;

wire		nds_unused_rising_edge_pulse;
wire		nds_unused_falling_edge_pulse;
wire		nds_unused_edge_pulse;
nds_sync_l2l #(
	.RESET_VALUE			(1'b0		)
) frq_scale_ack_sync (
	.b_reset_n			(presetn	              ),
	.b_clk				(pclk		              ),
	.a_signal			(pcs_frq_scale_ack            ),
	.b_signal			(pcs_frq_scale_ack_sync       ),
	.b_signal_rising_edge_pulse	(nds_unused_rising_edge_pulse ),
	.b_signal_falling_edge_pulse	(nds_unused_falling_edge_pulse),
	.b_signal_edge_pulse		(nds_unused_edge_pulse	      )
);

reg	reg_frq_scale_req;
wire	set_reg_frq_scale_req;
wire	clr_reg_frq_scale_req;
wire	reg_frq_scale_req_nx;

assign		pcs_frq_scale_req = reg_frq_scale_req;
assign		pcs_frq_scale = 3'b1;

assign		pcs_frq_clkon[0]  = core_clkon;
assign		pcs_frq_clkon[1]  = hclkon;
assign		pcs_frq_clkon[2]  = pclkon;
assign		pcs_frq_clkon[11] = aclkon;
assign		pcs_frq_clkon[12] = 1'b1;
assign		pcs_frq_clkon[13] = 1'b1;
assign		pcs_frq_clkon[10:3]  = 8'h0;
assign		pcs_frq_clkon[31:14] = 18'h0;

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		reg_frq_scale_req <= 1'b0;
	end
	else begin
		reg_frq_scale_req <= reg_frq_scale_req_nx;
	end
end

assign set_reg_frq_scale_req = ~pcs_frq_scale_ack_sync;
assign clr_reg_frq_scale_req = pcs_frq_scale_ack_sync;
assign reg_frq_scale_req_nx  = set_reg_frq_scale_req | (~clr_reg_frq_scale_req & reg_frq_scale_req);

endmodule


