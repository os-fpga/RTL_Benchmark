// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module ae250_smu_pd (
		  clk,
		  rstn,
		  smu_pwr_ctrl_cmd_we,
		  smu_pwr_ctrl_cmd,
		  smu_iso_cyc_we,
		  smu_iso_cyc,
		  smu_ret_cyc_we,
		  smu_ret_cyc,
		  smu_wakeup_enable_we,
		  smu_wakeup_enable,
		  smu_pwr_ctrl_int_en_we,
		  smu_pwr_ctrl_int_en,
		  smu_pwr_ctrl_int_pending_we,
		  smu_pwr_ctrl_int_pending_clr,
		  smu_pwr_ctrl_int_pending,
		  smu_pwr_ctrl_cmd_pending,
		  smu_pwr_status,
		  smu_wakeup_record,
		  pd_standby,
		  pd_clk_stable,
		  pd_pwr_stable,
		  pd_wakeup_event,
		  pd_ret_en,
		  pd_iso_en,
		  pd_clk_off,
		  pd_pwr_off,
		  pd_rstn,
		  smu_interrupt_pd
);

parameter	CYCLE_WIDTH     = 32'd4;
parameter       WAKEUP_WIDTH    = 32'd7;

parameter 	ST_ACTIVE	= 3'd0;
parameter	ST_DVFS  	= 3'd1;
parameter	ST_ISOLATION	= 3'd2;
parameter	ST_RETENTION	= 3'd3;
parameter	ST_LIGHTSLEEP	= 3'd4;
parameter	ST_DEEPSLEEP	= 3'd5;
parameter	ST_RESET	= 3'd6;

parameter	CMD_NO_ACTION   = 3'd0;
parameter	CMD_DVFS        = 3'd1;
parameter	CMD_LIGHTSLEEP  = 3'd2;
parameter	CMD_DEEPSLEEP   = 3'd3;

localparam	CYCLE_WIDTH_MINUS_1 = CYCLE_WIDTH - 32'd1;

input				clk;
input				rstn;

input	 			smu_pwr_ctrl_cmd_we;
input	[2:0]			smu_pwr_ctrl_cmd;
input	 			smu_iso_cyc_we;
input	[CYCLE_WIDTH-1:0]	smu_iso_cyc;
input				smu_ret_cyc_we;
input	[CYCLE_WIDTH-1:0]	smu_ret_cyc;
input				smu_wakeup_enable_we;
input	[WAKEUP_WIDTH-1:0]	smu_wakeup_enable;
input				smu_pwr_ctrl_int_en_we;
input				smu_pwr_ctrl_int_en;
input				smu_pwr_ctrl_int_pending_we;
input				smu_pwr_ctrl_int_pending_clr;
output				smu_pwr_ctrl_int_pending;
output	[2:0]			smu_pwr_ctrl_cmd_pending;
output	[2:0]			smu_pwr_status;
output	[WAKEUP_WIDTH-1:0]	smu_wakeup_record;
output				smu_interrupt_pd;

input				pd_standby;
input				pd_clk_stable;
input				pd_pwr_stable;
input	[WAKEUP_WIDTH-1:0]	pd_wakeup_event;

output		pd_ret_en;
output		pd_iso_en;
output		pd_clk_off;
output		pd_pwr_off;
output		pd_rstn;

reg				goto_deepsleep;
reg				leave_deepsleep;
reg	[2:0]			pwr_state;
reg	[2:0]			pwr_state_ns;
reg	[2:0]			pwr_ctrl_cmd;
reg	[CYCLE_WIDTH-1:0]	cnt;
reg	[CYCLE_WIDTH-1:0]	iso_cyc;
reg	[CYCLE_WIDTH-1:0]	ret_cyc;
reg	[1:0]			rstn_cnt;
reg	[WAKEUP_WIDTH-1:0]	pd_wakeup_enable;
reg	[WAKEUP_WIDTH-1:0]	pd_wakeup_record;
reg				pd_ctrl_int_en;
reg				pd_ctrl_int_pending;

wire	[CYCLE_WIDTH-1:0]	rst_cyc;
wire				assert_smu_interrupt_pd;
wire	[CYCLE_WIDTH-1:0]	cnt_add_1;
wire	[1:0]			rstn_cnt_add_1;
wire				goto_lightsleep;
wire				wakeup_req;
wire				pd_ret_en;
wire				pd_iso_en;
wire				pd_clk_off;
wire				pd_pwr_off;
wire				pd_rstn;
wire	[2:0]			smu_pwr_ctrl_cmd_pending;
wire	[2:0]			smu_pwr_status;
wire	[WAKEUP_WIDTH-1:0]	smu_wakeup_record;
wire				smu_pwr_ctrl_int_en_we;
wire				smu_pwr_ctrl_int_en;
wire				smu_pwr_ctrl_int_pending_we;
wire				smu_pwr_ctrl_int_pending_clr;
wire				smu_pwr_ctrl_int_pending;
wire				smu_interrupt_pd;
wire				is_active;
wire				is_dvfs;
wire				is_retention;
wire				is_isolation;
wire				is_lightsleep;
wire				is_deepsleep;
wire				is_reset;
wire				cmd_is_lightsleep;
wire				cmd_is_deepsleep;
wire				cnt_is_ret_cyc;
wire				cnt_is_iso_cyc;
wire				cnt_is_rst_cyc;

assign is_active         = (pwr_state == ST_ACTIVE);
assign is_dvfs           = (pwr_state == ST_DVFS);
assign is_retention      = (pwr_state == ST_RETENTION);
assign is_isolation      = (pwr_state == ST_ISOLATION);
assign is_lightsleep     = (pwr_state == ST_LIGHTSLEEP);
assign is_deepsleep      = (pwr_state == ST_DEEPSLEEP);
assign is_reset	         = (pwr_state == ST_RESET);
assign cmd_is_lightsleep = (pwr_ctrl_cmd == CMD_LIGHTSLEEP);
assign cmd_is_deepsleep  = (pwr_ctrl_cmd == CMD_DEEPSLEEP);
assign cnt_is_ret_cyc    = (cnt == ret_cyc);
assign cnt_is_iso_cyc    = (cnt == iso_cyc);
assign cnt_is_rst_cyc    = (cnt == rst_cyc);

assign rst_cyc = {{CYCLE_WIDTH{1'b0}}, {2'b10}};

assign wakeup_req = (|(pd_wakeup_event & pd_wakeup_enable)) & pd_clk_stable & pd_pwr_stable;

assign assert_smu_interrupt_pd = pd_ctrl_int_en & (is_lightsleep | is_deepsleep);

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		pd_ctrl_int_en <= 1'b0;
	else if (smu_pwr_ctrl_int_en_we)
		pd_ctrl_int_en <= smu_pwr_ctrl_int_en;
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		pd_ctrl_int_pending <= 1'b0;
	else if (smu_pwr_ctrl_int_pending_we | assert_smu_interrupt_pd)
		pd_ctrl_int_pending <= 1'b1;
	else if (smu_pwr_ctrl_int_pending_clr)
		pd_ctrl_int_pending <= 1'b0;
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		iso_cyc <= {CYCLE_WIDTH{1'b0}};
	else if (smu_iso_cyc_we)
		iso_cyc <= smu_iso_cyc;
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		ret_cyc <= {CYCLE_WIDTH{1'b0}};
	else if (smu_ret_cyc_we)
		ret_cyc <= smu_ret_cyc;
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		pd_wakeup_enable <= {WAKEUP_WIDTH{1'b1}};
	else if (smu_wakeup_enable_we)
		pd_wakeup_enable <= smu_wakeup_enable;
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		pd_wakeup_record <= {WAKEUP_WIDTH{1'b0}};
	else if (wakeup_req)
		pd_wakeup_record <= pd_wakeup_event & pd_wakeup_enable;
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		pwr_ctrl_cmd <= 3'b0;
	else if (smu_pwr_ctrl_cmd_we)
		pwr_ctrl_cmd <= smu_pwr_ctrl_cmd;
	else if (wakeup_req)
		pwr_ctrl_cmd <= 3'b0;
end

assign goto_lightsleep = cmd_is_lightsleep & is_active & pd_standby;

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		goto_deepsleep <= 1'b0;
	else if (cmd_is_deepsleep && is_active && pd_standby)
		goto_deepsleep <= 1'b1;
	else if (is_deepsleep)
		goto_deepsleep <= 1'b0;
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		leave_deepsleep <= 1'b0;
	else if (wakeup_req && is_deepsleep)
		leave_deepsleep <= 1'b1;
	else if (is_active && (pwr_state_ns == ST_ACTIVE))
		leave_deepsleep <= 1'b0;
end

assign cnt_add_1 = cnt + {{CYCLE_WIDTH_MINUS_1{1'b0}}, 1'b1};

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		cnt <= {CYCLE_WIDTH{1'b0}};
	else if (pwr_state_ns != pwr_state)
		cnt <= {CYCLE_WIDTH{1'b0}};
	else if (is_retention || is_isolation || is_reset)
		cnt <= cnt_add_1;
end

assign rstn_cnt_add_1 = rstn_cnt + 2'b1;

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		rstn_cnt <= 2'b0;
	else if (is_isolation && (pwr_state_ns == ST_ACTIVE))
		rstn_cnt <= 2'b1;
	else if (rstn_cnt != 2'b0)
		rstn_cnt <= rstn_cnt_add_1;
end

always @* begin
	pwr_state_ns = pwr_state;
	case (pwr_state)
		ST_ACTIVE:
			pwr_state_ns =  goto_lightsleep ? ST_LIGHTSLEEP :
					goto_deepsleep  ? ST_ISOLATION  :
							  ST_ACTIVE     ;
		ST_ISOLATION:
			if (leave_deepsleep && cnt_is_iso_cyc)
				pwr_state_ns = ST_RESET;
			else if (goto_deepsleep && cnt_is_iso_cyc)
				pwr_state_ns = ST_RETENTION;
		ST_RETENTION:
			if (leave_deepsleep && cnt_is_ret_cyc)
				pwr_state_ns = ST_ISOLATION;
			else if (goto_deepsleep && cnt_is_ret_cyc)
				pwr_state_ns = ST_DEEPSLEEP;
		ST_LIGHTSLEEP:
			pwr_state_ns = wakeup_req ? ST_ACTIVE : ST_LIGHTSLEEP;
		ST_DEEPSLEEP:
			pwr_state_ns = wakeup_req ? ST_RETENTION : ST_DEEPSLEEP;
		ST_RESET:
			pwr_state_ns = cnt_is_rst_cyc ? ST_ACTIVE : ST_RESET;
		default:
			pwr_state_ns = 3'bx;
	endcase
end

always @ (posedge clk or negedge rstn) begin
	if (!rstn)
		pwr_state <= ST_ACTIVE;
	else
		pwr_state <= pwr_state_ns;
end

assign pd_ret_en    = is_deepsleep  ||
                      is_retention;
assign pd_iso_en    = is_deepsleep  ||
                      is_retention  ||
		      is_isolation;
assign pd_clk_off   = is_dvfs       ||
	              is_retention  ||
		      is_isolation  ||
		      is_lightsleep ||
		      is_deepsleep;
assign pd_pwr_off   = is_deepsleep;
assign pd_rstn      = ~(is_reset | is_retention | is_isolation | is_deepsleep);

assign smu_pwr_status = pwr_state;

assign smu_pwr_ctrl_cmd_pending = pwr_ctrl_cmd;

assign smu_wakeup_record = pd_wakeup_record;

assign smu_pwr_ctrl_int_pending = pd_ctrl_int_pending;

assign smu_interrupt_pd = pd_ctrl_int_pending;

endmodule
