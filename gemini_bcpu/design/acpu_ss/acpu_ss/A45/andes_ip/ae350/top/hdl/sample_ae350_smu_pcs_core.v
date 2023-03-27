`include "config.inc"
`include "sample_ae350_smu_config.vh"
`include "sample_ae350_smu_const.vh"
module sample_ae350_smu_pcs_core (
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
output		pcs_slvp_resetn,
output	[3:0]	pcs_mem_init,
input	[4:0]	pcs_reset_source
);

localparam	ST_ACTIVE_RUN 	= 4'b0000;
localparam	ST_RESET 	= 4'b0001;
localparam	ST_ACTIVE_WFI 	= 4'b0010;
localparam	ST_LIGHT_SLEEP 	= 4'b0100;
localparam	ST_DEEP_SLEEP 	= 4'b1000;

localparam	PWR_ON	=	2'b00;
localparam	PWR_UP	=	2'b01;
localparam	PWR_DN	=	2'b10;
localparam	PWR_OFF	=	2'b11;

wire	[31:0]	pcs_cfg		= 32'h0000_000d;
wire	[31:0]	pcs_scratch	;
wire	[31:0]	pcs_we	;
wire	[31:0]	pcs_ctl		;

wire	[31:0]	pcs_status	;

wire	[31:0]	pcs_reserved	= 32'h0;

wire		core_clkon	;
wire		hclkon		;
wire		pclkon		;
wire		aclkon		;

wire		pcs_vol_scale_ack_sync;
wire		pcs_frq_scale_ack_sync;

wire		pcs_write_valid	;
wire		update_cer	;

reg	[3:0]	clkon_for_cer	;

reg		reg_vol_scale_req;
wire		set_reg_vol_scale_req;
wire		clr_reg_vol_scale_req;
wire		reg_vol_scale_req_nx;

reg		reg_frq_scale_req;
wire		set_reg_frq_scale_req;
wire		clr_reg_frq_scale_req;
wire		reg_frq_scale_req_nx;

reg		pcs_core_clkon;
reg		pcs_lm_clkon;
reg		pcs_dc_clkon;

wire		pcs_core_clkon_nx;
wire		pcs_lm_clkon_nx;
wire		pcs_dc_clkon_nx;

reg		pcs_core_gated;
reg		pcs_lm_gated;
reg		pcs_dc_gated;

reg	[31:0]	pcs_scratch_reg;
reg	[31:0]	pcs_we_reg;
reg	[7:0]	pcs_ctl_reg;
reg		pcs_write_ctl_valid;

reg	[3:0]	pcs_tar_state;
wire		pcs_cur_state_en;
reg	[3:0]	pcs_cur_state;
reg	[3:0]	pcs_cur_state_nx;
reg	[4:0]	pcs_reset_cnt;
wire		pcs_reset_cnt_match;
reg		pcs_core_reset_assert;
reg		pcs_slvp_reset_assert;

reg		pcs_pwr_off_sync;
reg		pcs_pwr_off;
wire		pcs_pwr_off_nx;
wire		pcs_isolated;

reg	[1:0]	pcs_pwr_state;
reg	[1:0]	pcs_pwr_state_nx;

wire		pcs_shutdn_event_sync;
wire	[31:1]	pcs_wakeup_event_root;
wire	[31:1]	pcs_wakeup_event_sync;
wire	[31:1]	pcs_wakeup_event_sync_mask;
wire		pcs_wakeup_event_final;
wire		pcs_wakeup_event_wfi;
reg	[4:0]	pcs_wakeup_vec;
wire	[31:1]	pcs_wakeup_event_sync_mask_onehot;
wire	[4:0]	pcs_wakeup_vec_nx;
wire		pcs_wait;
wire		pcs_busy;

assign	pcs_rdata 	= ({32{pcs_sel & pcs_sel_cfg}}		& pcs_cfg	)
			| ({32{pcs_sel & pcs_sel_scratch}}	& pcs_scratch	)
			| ({32{pcs_sel & pcs_sel_misc}}		& pcs_reserved	)
			| ({32{pcs_sel & pcs_sel_misc2}}	& pcs_reserved	)
			| ({32{pcs_sel & pcs_sel_we}}		& pcs_we	)
			| ({32{pcs_sel & pcs_sel_ctl}}		& pcs_ctl	)
			| ({32{pcs_sel & pcs_sel_status}}	& pcs_status	)
			;
assign	pcs_int 		= 1'b0;
assign	pcs_wakeup		= (pcs_ctl_reg == 8'b00001_000);
assign	pcs_standby_req		= 1'b0;
assign	pcs_vol_scale_req	= reg_vol_scale_req;
assign	pcs_vol_scale		= {2'b00, !pcs_pwr_off_nx};
assign	pcs_iso			= pcs_isolated;
assign	pcs_reten		= 1'b0;
assign	pcs_resetn		= pcs_hart_rst & !pcs_core_reset_assert;
assign	pcs_slvp_resetn		= !pcs_slvp_reset_assert;
assign	pcs_mem_init 		= 4'b1111;

assign	core_clkon	= clkon_for_cer[0];
assign	hclkon		= clkon_for_cer[1];
assign	pclkon		= clkon_for_cer[2];
assign	aclkon		= clkon_for_cer[3];

assign	pcs_write_valid = pcs_sel & pcs_write;
assign	update_cer = pcs_sel_cer & pcs_write;

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		clkon_for_cer <= 4'hf;
	end
	else if (update_cer) begin
		clkon_for_cer <= {pcs_wdata[11], pcs_wdata[2:0]};
	end
end

wire nds_unused_pcs_frq_rising_edge_pulse;
wire nds_unused_pcs_frq_falling_edge_pulse;
wire nds_unused_pcs_frq_edge_pulse;

nds_sync_l2l #(
	.RESET_VALUE			(1'b0		)
) frq_scale_ack_sync (
	.b_reset_n			(presetn	                      ),
	.b_clk				(pclk		                      ),
	.a_signal			(pcs_frq_scale_ack                    ),
	.b_signal			(pcs_frq_scale_ack_sync               ),
	.b_signal_rising_edge_pulse	(nds_unused_pcs_frq_rising_edge_pulse ),
	.b_signal_falling_edge_pulse	(nds_unused_pcs_frq_falling_edge_pulse),
	.b_signal_edge_pulse		(nds_unused_pcs_frq_edge_pulse        )
);

assign		pcs_frq_scale_req = reg_frq_scale_req;
assign		pcs_frq_scale = 3'b1;

assign		pcs_frq_clkon[0]  = (pcs_core_clkon_nx | (|pcs_wakeup_event_root));
assign		pcs_frq_clkon[1]  = hclkon;
assign		pcs_frq_clkon[2]  = pclkon;
assign		pcs_frq_clkon[11] = aclkon;
assign		pcs_frq_clkon[12] = (pcs_lm_clkon_nx | (|pcs_wakeup_event_root));
assign		pcs_frq_clkon[13] = (pcs_dc_clkon_nx | (|pcs_wakeup_event_root));
assign		pcs_frq_clkon[10:3]  = 8'h0;
assign		pcs_frq_clkon[31:14] = 18'h0;

wire nds_unused_pcs_vol_rising_edge_pulse;
wire nds_unused_pcs_vol_falling_edge_pulse;
wire nds_unused_pcs_vol_edge_pulse;

nds_sync_l2l #(
	.RESET_VALUE			(1'b0		)
) vol_scale_ack_sync (
	.b_reset_n			(presetn	                      ),
	.b_clk				(pclk		                      ),
	.a_signal			(pcs_vol_scale_ack                    ),
	.b_signal			(pcs_vol_scale_ack_sync               ),
	.b_signal_rising_edge_pulse	(nds_unused_pcs_vol_rising_edge_pulse ),
	.b_signal_falling_edge_pulse	(nds_unused_pcs_vol_falling_edge_pulse),
	.b_signal_edge_pulse		(nds_unused_pcs_vol_edge_pulse        )
);


always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		reg_vol_scale_req <= 1'b0;
	end
	else begin
		reg_vol_scale_req <= reg_vol_scale_req_nx;
	end
end

assign set_reg_vol_scale_req = ~pcs_vol_scale_ack_sync;
assign clr_reg_vol_scale_req = pcs_vol_scale_ack_sync;
assign reg_vol_scale_req_nx  = set_reg_vol_scale_req | (~clr_reg_vol_scale_req & reg_vol_scale_req);

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_pwr_off <= 1'b1;
	end
	else if (!reg_vol_scale_req & !pcs_vol_scale_ack_sync) begin
		pcs_pwr_off <= pcs_pwr_off_nx;
	end
end

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_pwr_off_sync <= 1'b1;
	end
	else if (!reg_vol_scale_req & !pcs_vol_scale_ack_sync) begin
		pcs_pwr_off_sync <= pcs_pwr_off;
	end
end


always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_pwr_state <= PWR_OFF;
	end
	else begin
		pcs_pwr_state <= pcs_pwr_state_nx;
	end
end

always @* begin
	case(pcs_pwr_state)
		PWR_ON: begin
			if ((pcs_cur_state == ST_DEEP_SLEEP) & (pcs_tar_state == ST_DEEP_SLEEP) & (!pcs_pwr_off_sync))
				pcs_pwr_state_nx = PWR_DN;
			else
				pcs_pwr_state_nx = pcs_pwr_state;
		end
		PWR_UP: begin
			if (!pcs_pwr_off_sync)
				pcs_pwr_state_nx = PWR_ON;
			else
				pcs_pwr_state_nx = pcs_pwr_state;
		end
		PWR_DN: begin
			if (pcs_pwr_off_sync)
				pcs_pwr_state_nx = PWR_OFF;
			else
				pcs_pwr_state_nx = pcs_pwr_state;
		end
		PWR_OFF: begin
			if ((pcs_tar_state == ST_ACTIVE_RUN) & pcs_pwr_off_sync)
				pcs_pwr_state_nx = PWR_UP;
			else
				pcs_pwr_state_nx = pcs_pwr_state;
		end
	endcase
end


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



always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_core_clkon <= 1'b0;
	end
	else if (!reg_frq_scale_req & !pcs_frq_scale_ack_sync) begin
		pcs_core_clkon <= pcs_core_clkon_nx;
	end
end

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_core_gated <= 1'b1;
	end
	else if (pcs_frq_scale_ack_sync) begin
		pcs_core_gated <= ~pcs_core_clkon;
	end
end

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_dc_clkon <= 1'b0;
	end
	else if (!reg_frq_scale_req & !pcs_frq_scale_ack_sync) begin
		pcs_dc_clkon <= pcs_dc_clkon_nx;
	end
end

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_dc_gated <= 1'b1;
	end
	else if (pcs_frq_scale_ack_sync) begin
		pcs_dc_gated <= ~pcs_dc_clkon;
	end
end

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_lm_clkon <= 1'b0;
	end
	else if (!reg_frq_scale_req & !pcs_frq_scale_ack_sync) begin
		pcs_lm_clkon <= pcs_lm_clkon_nx;
	end
end

always @ (posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_lm_gated <= 1'b1;
	end
	else if (pcs_frq_scale_ack_sync) begin
		pcs_lm_gated <= ~pcs_lm_clkon;
	end
end

assign pcs_core_clkon_nx 	= !(
				(pcs_cur_state == ST_DEEP_SLEEP)
				| ((pcs_cur_state == ST_LIGHT_SLEEP) & (pcs_tar_state != ST_ACTIVE_RUN))
				| ((pcs_cur_state == ST_ACTIVE_WFI) & (!pcs_wakeup_event_wfi) & pcs_standby_ok)
				);
assign pcs_dc_clkon_nx 	= !(
				(pcs_cur_state == ST_DEEP_SLEEP)
				| ((pcs_cur_state == ST_LIGHT_SLEEP) & (pcs_tar_state != ST_ACTIVE_RUN))
				);
assign pcs_lm_clkon_nx 	= !(
				(pcs_cur_state == ST_DEEP_SLEEP)
				| ((pcs_cur_state == ST_LIGHT_SLEEP) & (pcs_tar_state != ST_ACTIVE_RUN))
				);

wire nds_unused_pcs_shutdn_rising_edge_pulse;
wire nds_unused_pcs_shutdn_falling_edge_pulse;
wire nds_unused_pcs_shutdn_edge_pulse;

nds_sync_l2l #(
	.RESET_VALUE			(1'b0			)
) set_pcs_power_down_sync (
	.b_reset_n			(presetn		                 ),
	.b_clk				(pclk			                 ),
	.a_signal			(pcs_standby_ok		                 ),
	.b_signal			(pcs_shutdn_event_sync	                 ),
	.b_signal_rising_edge_pulse	(nds_unused_pcs_shutdn_rising_edge_pulse ),
	.b_signal_falling_edge_pulse	(nds_unused_pcs_shutdn_falling_edge_pulse),
	.b_signal_edge_pulse		(nds_unused_pcs_shutdn_edge_pulse        )
);


assign	pcs_wakeup_event_root[31:1] = (pcs_wakeup_event[31:1] & pcs_we_reg[31:1]);

generate
genvar i;
for ( i = 1 ; i <= 31 ; i = i + 1) begin : gen_wakeup_event_sync
	wire nds_unused_pcs_wakeup_rising_edge_pulse;
	wire nds_unused_pcs_wakeup_falling_edge_pulse;
	wire nds_unused_pcs_wakeup_edge_pulse;
	nds_sync_l2l #(
		.RESET_VALUE			(1'b0				)
	) set_pcs_power_up_sync (
		.b_reset_n			(presetn			         ),
		.b_clk				(pclk				         ),
		.a_signal			(pcs_wakeup_event[i]	                 ),
		.b_signal			(pcs_wakeup_event_sync[i]	         ),
		.b_signal_rising_edge_pulse	(nds_unused_pcs_wakeup_rising_edge_pulse ),
		.b_signal_falling_edge_pulse	(nds_unused_pcs_wakeup_falling_edge_pulse),
		.b_signal_edge_pulse		(nds_unused_pcs_wakeup_edge_pulse        )
	);
end
endgenerate

assign pcs_wakeup_event_sync_mask = pcs_wakeup_event_sync[31:1] & pcs_we_reg[31:1];

assign pcs_wakeup_event_final = |pcs_wakeup_event_sync_mask;
assign pcs_wakeup_event_wfi = |pcs_wakeup_event_sync[31:27];

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_scratch_reg <= 32'h0;
	end
	else if (pcs_sel & pcs_write & pcs_sel_scratch) begin
		pcs_scratch_reg <= pcs_wdata;
	end
end

assign	pcs_scratch = pcs_scratch_reg;

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_we_reg <= 32'hffffffff;
	end
	else if (pcs_sel & pcs_write & pcs_sel_we) begin
		pcs_we_reg <= pcs_wdata;
	end
end

assign	pcs_we = pcs_we_reg;


always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_ctl_reg <= 8'h0;
	end
	else if (pcs_sel & pcs_write & pcs_sel_ctl & pcs_write_ctl_valid) begin
		pcs_ctl_reg <= pcs_wdata[7:0];
	end
	else if (pcs_wakeup_event_final & (pcs_cur_state == ST_DEEP_SLEEP)) begin
		pcs_ctl_reg <= 8'b0;
	end
	else if (pcs_wakeup_event_final & ((pcs_cur_state == ST_LIGHT_SLEEP) & (pcs_tar_state != ST_DEEP_SLEEP))) begin
		pcs_ctl_reg <= 8'b0;
	end
	else if (pcs_wakeup_event_wfi & (pcs_cur_state == ST_ACTIVE_WFI)) begin
		pcs_ctl_reg <= 8'b0;
	end
	else if (pcs_reset_cnt_match & (pcs_cur_state == ST_RESET)) begin
		pcs_ctl_reg <= 8'b0;
	end
end

always @* begin
	casez(pcs_wdata[7:0])
		8'b00001_000: begin
			pcs_write_ctl_valid = (pcs_cur_state == ST_DEEP_SLEEP) | (pcs_cur_state == ST_LIGHT_SLEEP) | (pcs_cur_state == ST_ACTIVE_WFI);
		end
		8'b?????_001,
		8'b0000?_011: begin
			pcs_write_ctl_valid = (pcs_cur_state == ST_ACTIVE_RUN);
		end
		default: begin
			pcs_write_ctl_valid = 1'b0;
		end
	endcase
end

assign	pcs_ctl = {24'h0, pcs_ctl_reg};

always @* begin
	casez(pcs_ctl_reg)
		8'b0000?_000: begin
			pcs_tar_state = ST_ACTIVE_RUN;
		end
		8'b?????_001: begin
			pcs_tar_state = ST_RESET;
		end
		8'b00000_011: begin
			pcs_tar_state = ST_LIGHT_SLEEP;
		end
		8'b00001_011: begin
			pcs_tar_state = ST_DEEP_SLEEP;
		end
		default: begin
			pcs_tar_state = 4'bxxxx;
		end
	endcase
end

assign	pcs_cur_state_en	= (pcs_cur_state != pcs_tar_state)
				| pcs_wakeup_event_final
				| pcs_wakeup_event_wfi
				| pcs_shutdn_event_sync
				;
always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_cur_state <= ST_DEEP_SLEEP;
	end
	else if (pcs_cur_state_en) begin
		pcs_cur_state <= pcs_cur_state_nx;
	end
end

assign	pcs_wait = ((pcs_tar_state == ST_RESET      ) & ((pcs_cur_state == ST_ACTIVE_RUN ) | (pcs_cur_state == ST_ACTIVE_RUN )))
		 | ((pcs_tar_state == ST_LIGHT_SLEEP) & ((pcs_cur_state == ST_ACTIVE_RUN ) | (pcs_cur_state == ST_ACTIVE_RUN )))
		 | ((pcs_tar_state == ST_DEEP_SLEEP ) & ((pcs_cur_state == ST_ACTIVE_RUN ) | (pcs_cur_state == ST_ACTIVE_RUN )))
		 ;
assign	pcs_busy = ((pcs_cur_state == ST_RESET      ) & (!pcs_reset_cnt_match))
                 | ((pcs_cur_state == ST_LIGHT_SLEEP) & (!pcs_core_gated | !pcs_dc_gated | !pcs_lm_gated))
                 | ((pcs_cur_state == ST_DEEP_SLEEP ) & ((pcs_pwr_state == PWR_UP) | (pcs_pwr_state == PWR_DN)))
                 ;
assign	pcs_status[7:0]	= ({8{(pcs_cur_state == ST_ACTIVE_RUN ) & (!pcs_wait) & (!pcs_busy)}} 	& {pcs_wakeup_vec, 3'b000})
			| ({8{(pcs_cur_state == ST_ACTIVE_WFI ) & (!pcs_wait) & (!pcs_busy)}} 	& {pcs_wakeup_vec, 3'b000})
			| ({8{(pcs_cur_state == ST_RESET      ) & (!pcs_wait) & (!pcs_busy)}}	& 8'b00100_001)
			| ({8{(pcs_cur_state == ST_LIGHT_SLEEP) & (!pcs_wait) & (!pcs_busy)}} 	& 8'b00000_010)
			| ({8{(pcs_cur_state == ST_DEEP_SLEEP ) & (!pcs_wait) & (!pcs_busy)}} 	& 8'b10000_010)
			| ({8{(pcs_cur_state == ST_DEEP_SLEEP ) & (!pcs_wait) & (!pcs_busy)}} 	& 8'b10000_010)
			| ({8{(pcs_tar_state == ST_RESET      ) & ( pcs_wait) & (!pcs_busy)}} 	& 8'b00000_011)
			| ({8{(pcs_tar_state == ST_LIGHT_SLEEP) & ( pcs_wait) & (!pcs_busy)}} 	& 8'b00010_011)
			| ({8{(pcs_tar_state == ST_DEEP_SLEEP ) & ( pcs_wait) & (!pcs_busy)}} 	& 8'b00011_011)
			| ({8{(pcs_cur_state == ST_RESET      ) & (!pcs_wait) & ( pcs_busy)}} 	& 8'b10000_011)
			| ({8{(pcs_cur_state == ST_LIGHT_SLEEP) & (!pcs_wait) & ( pcs_busy)}} 	& 8'b10010_011)
			| ({8{(pcs_cur_state == ST_DEEP_SLEEP ) & (!pcs_wait) & ( pcs_busy)}} 	& 8'b10011_011)
			;
assign pcs_status[29:8]	= 22'h0;
assign pcs_status[30]	= pcs_wakeup_event_final;
assign pcs_status[31]	= (|pcs_wakeup_event_sync[31:1]);



always @* begin
	case(pcs_cur_state)
		ST_ACTIVE_RUN: begin
			if (pcs_shutdn_event_sync)
				if (pcs_tar_state == ST_RESET)
					pcs_cur_state_nx = ST_RESET;
				else if ((pcs_tar_state == ST_LIGHT_SLEEP) & !(pcs_wakeup_event_final))
					pcs_cur_state_nx = ST_LIGHT_SLEEP;
				else if (pcs_tar_state == ST_DEEP_SLEEP)
					pcs_cur_state_nx = ST_LIGHT_SLEEP;
				else if (!pcs_wakeup_event_wfi)
					pcs_cur_state_nx = ST_ACTIVE_WFI;
				else
					pcs_cur_state_nx = ST_ACTIVE_RUN;
			else
				pcs_cur_state_nx = ST_ACTIVE_RUN;
		end
		ST_RESET: begin
			if ((pcs_tar_state == ST_ACTIVE_RUN) & !pcs_shutdn_event_sync)
				pcs_cur_state_nx = ST_ACTIVE_RUN;
			else
				pcs_cur_state_nx = ST_RESET;
		end
		ST_ACTIVE_WFI: begin
			if (pcs_wakeup_event_wfi | !pcs_shutdn_event_sync)
				pcs_cur_state_nx = ST_ACTIVE_RUN;
			else
				pcs_cur_state_nx = ST_ACTIVE_WFI;
		end
		ST_LIGHT_SLEEP: begin
			if ((pcs_tar_state == ST_ACTIVE_RUN) & ((pcs_wakeup_event_final) | ({pcs_core_gated, pcs_dc_gated, pcs_lm_gated} == 3'b000)))
				pcs_cur_state_nx = ST_ACTIVE_RUN;
			else if ((pcs_tar_state == ST_DEEP_SLEEP) & ({pcs_core_gated, pcs_dc_gated, pcs_lm_gated} == 3'b111))
				pcs_cur_state_nx = ST_DEEP_SLEEP;
			else
				pcs_cur_state_nx = ST_LIGHT_SLEEP;
		end
		ST_DEEP_SLEEP: begin
			if ((pcs_tar_state == ST_ACTIVE_RUN) & (pcs_pwr_state == PWR_ON))
				pcs_cur_state_nx = ST_LIGHT_SLEEP;
			else
				pcs_cur_state_nx = pcs_cur_state;
		end
		default: begin
			pcs_cur_state_nx = 4'bxxxx;
		end
	endcase
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_wakeup_vec <= 5'b0;
	end
	else if ((pcs_cur_state == ST_LIGHT_SLEEP)
		|(pcs_cur_state == ST_DEEP_SLEEP))begin
		pcs_wakeup_vec <= pcs_wakeup_vec_nx;
	end
end

assign pcs_wakeup_event_sync_mask_onehot = pcs_wakeup_event_sync_mask & (~pcs_wakeup_event_sync_mask + 31'b1);


assign pcs_wakeup_vec_nx[0] =   pcs_wakeup_event_sync_mask_onehot[1] | pcs_wakeup_event_sync_mask_onehot[3] | pcs_wakeup_event_sync_mask_onehot[5] | pcs_wakeup_event_sync_mask_onehot[7] | pcs_wakeup_event_sync_mask_onehot[9] | pcs_wakeup_event_sync_mask_onehot[11] | pcs_wakeup_event_sync_mask_onehot[13] | pcs_wakeup_event_sync_mask_onehot[15] | pcs_wakeup_event_sync_mask_onehot[17] | pcs_wakeup_event_sync_mask_onehot[19] | pcs_wakeup_event_sync_mask_onehot[21] | pcs_wakeup_event_sync_mask_onehot[23] | pcs_wakeup_event_sync_mask_onehot[25] | pcs_wakeup_event_sync_mask_onehot[27] | pcs_wakeup_event_sync_mask_onehot[29] | pcs_wakeup_event_sync_mask_onehot[31];
assign pcs_wakeup_vec_nx[1] =   pcs_wakeup_event_sync_mask_onehot[2] | pcs_wakeup_event_sync_mask_onehot[3] | pcs_wakeup_event_sync_mask_onehot[6] | pcs_wakeup_event_sync_mask_onehot[7] | pcs_wakeup_event_sync_mask_onehot[10] | pcs_wakeup_event_sync_mask_onehot[11] | pcs_wakeup_event_sync_mask_onehot[14] | pcs_wakeup_event_sync_mask_onehot[15] | pcs_wakeup_event_sync_mask_onehot[18] | pcs_wakeup_event_sync_mask_onehot[19] | pcs_wakeup_event_sync_mask_onehot[22] | pcs_wakeup_event_sync_mask_onehot[23] | pcs_wakeup_event_sync_mask_onehot[26] | pcs_wakeup_event_sync_mask_onehot[27] | pcs_wakeup_event_sync_mask_onehot[30] | pcs_wakeup_event_sync_mask_onehot[31];
assign pcs_wakeup_vec_nx[2] =   pcs_wakeup_event_sync_mask_onehot[4] | pcs_wakeup_event_sync_mask_onehot[5] | pcs_wakeup_event_sync_mask_onehot[6] | pcs_wakeup_event_sync_mask_onehot[7] | pcs_wakeup_event_sync_mask_onehot[12] | pcs_wakeup_event_sync_mask_onehot[13] | pcs_wakeup_event_sync_mask_onehot[14] | pcs_wakeup_event_sync_mask_onehot[15] | pcs_wakeup_event_sync_mask_onehot[20] | pcs_wakeup_event_sync_mask_onehot[21] | pcs_wakeup_event_sync_mask_onehot[22] | pcs_wakeup_event_sync_mask_onehot[23] | pcs_wakeup_event_sync_mask_onehot[28] | pcs_wakeup_event_sync_mask_onehot[29] | pcs_wakeup_event_sync_mask_onehot[30] | pcs_wakeup_event_sync_mask_onehot[31];
assign pcs_wakeup_vec_nx[3] =   pcs_wakeup_event_sync_mask_onehot[8] | pcs_wakeup_event_sync_mask_onehot[9] | pcs_wakeup_event_sync_mask_onehot[10] | pcs_wakeup_event_sync_mask_onehot[11] | pcs_wakeup_event_sync_mask_onehot[12] | pcs_wakeup_event_sync_mask_onehot[13] | pcs_wakeup_event_sync_mask_onehot[14] | pcs_wakeup_event_sync_mask_onehot[15] | pcs_wakeup_event_sync_mask_onehot[24] | pcs_wakeup_event_sync_mask_onehot[25] | pcs_wakeup_event_sync_mask_onehot[26] | pcs_wakeup_event_sync_mask_onehot[27] | pcs_wakeup_event_sync_mask_onehot[28] | pcs_wakeup_event_sync_mask_onehot[29] | pcs_wakeup_event_sync_mask_onehot[30] | pcs_wakeup_event_sync_mask_onehot[31];
assign pcs_wakeup_vec_nx[4] =   pcs_wakeup_event_sync_mask_onehot[16] | pcs_wakeup_event_sync_mask_onehot[17] | pcs_wakeup_event_sync_mask_onehot[18] | pcs_wakeup_event_sync_mask_onehot[19] | pcs_wakeup_event_sync_mask_onehot[20] | pcs_wakeup_event_sync_mask_onehot[21] | pcs_wakeup_event_sync_mask_onehot[22] | pcs_wakeup_event_sync_mask_onehot[23] | pcs_wakeup_event_sync_mask_onehot[24] | pcs_wakeup_event_sync_mask_onehot[25] | pcs_wakeup_event_sync_mask_onehot[26] | pcs_wakeup_event_sync_mask_onehot[27] | pcs_wakeup_event_sync_mask_onehot[28] | pcs_wakeup_event_sync_mask_onehot[29] | pcs_wakeup_event_sync_mask_onehot[30] | pcs_wakeup_event_sync_mask_onehot[31];


assign	pcs_pwr_off_nx	= (pcs_pwr_state == PWR_DN) | (pcs_pwr_state == PWR_OFF);
assign	pcs_isolated = (pcs_cur_state == ST_DEEP_SLEEP);

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_reset_cnt <= 5'b0;
	end
	else if ((pcs_cur_state == ST_RESET) & !pcs_reset_cnt_match) begin
		pcs_reset_cnt <= pcs_reset_cnt + 5'b1;
	end
	else begin
		pcs_reset_cnt <= 5'b0;
	end
end

assign	pcs_reset_cnt_match = (pcs_reset_cnt == pcs_ctl_reg[7:3]) & (pcs_cur_state == ST_RESET);


always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_core_reset_assert <= 1'b1;
	end
	else if ((pcs_cur_state == ST_RESET) | (pcs_cur_state == ST_DEEP_SLEEP)) begin
		pcs_core_reset_assert <= 1'b1;
	end
	else if ((pcs_cur_state == ST_ACTIVE_RUN) & ({pcs_core_gated, pcs_dc_gated, pcs_lm_gated} == 3'b000) & pcs_core_reset_assert) begin
		pcs_core_reset_assert <= 1'b0;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		pcs_slvp_reset_assert <= 1'b1;
	end
	else if (pcs_cur_state == ST_DEEP_SLEEP) begin
		pcs_slvp_reset_assert <= 1'b1;
	end
	else if ((pcs_cur_state == ST_ACTIVE_RUN) & ({pcs_core_gated, pcs_dc_gated, pcs_lm_gated} == 3'b000) & pcs_slvp_reset_assert) begin
		pcs_slvp_reset_assert <= 1'b0;
	end
end


endmodule


