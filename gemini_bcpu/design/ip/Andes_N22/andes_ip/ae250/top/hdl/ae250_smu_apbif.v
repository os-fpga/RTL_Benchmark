// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_smu_config.vh"
`include "ae250_smu_const.vh"

module ae250_smu_apbif (
	  pclk,
	  presetn,
	  psel,
	  penable,
	  paddr,
	  pwdata,
	  pwrite,
	  prdata,
	  mpd_por_b_psync,
	  wrsr_wen,
	  wr_mask_wen,
	  wr_mask_reg,
	  wrsr_apor,
	  wrsr_mpor,
	  wrsr_hw,
	  wrsr_wdt,
	  wrsr_sw,
	  wrsr_extw,
	  wrsr_alm,
	  wrsr_dbg,
`ifdef AE250_SMU_SCRATCH_SUPPORT
	  scratch_wen,
	  scratch_reg,
`endif
`ifdef NDS_BOARD_CF1
	  cf1_pinmux_ctrl0,
	  cf1_pinmux_ctrl1,
`endif
	  core2smu_wfi_mode,
	  smu2core_wakeup_ok,
	  standby_cmd_reg,
	  standby_cmd_clr,
	  sw_rstn,
	  mpd_pwr_dis_wr_reg,
	  clock_ratio_reg,
	  smu_core_clk_en,
	  smu_hclk_en,
	  smu_pclk_en,
	  reset_vector,
	  icache_disable_init,
	  dcache_disable_init,
	  smu_pwr_ctrl_cmd_we,
	  smu_pwr_ctrl_cmd,
	  smu_iso_cyc_we,
	  smu_iso_cyc,
	  smu_ret_cyc_we,
	  smu_ret_cyc,
	  smu_wakeup_enable_we,
	  smu_wakeup_enable,
	  smu_pwr_ctrl_cmd_pending,
	  smu_pwr_status,
	  smu_wakeup_record,
	  smu_pwr_ctrl_int_en_we,
	  smu_pwr_ctrl_int_en,
	  smu_pwr_ctrl_int_pending_we,
	  smu_pwr_ctrl_int_pending_clr,
	  smu_pwr_ctrl_int_pending,
	  dbg_wakeup_req
);
parameter       CYCLE_WIDTH        = 32'd4;
parameter       DISALBE_INIT_WIDTH = 32'd2;
parameter       WAKEUP_WIDTH       = 32'd7;

input				pclk;
input				presetn;
input				psel;
input				penable;
input	[12:2]			paddr;
input	[31:0]			pwdata;
input				pwrite;
output	[31:0]			prdata;

input                           mpd_por_b_psync;

output				wrsr_wen;
output				wr_mask_wen;
input	[10:8]			wr_mask_reg;
input				wrsr_apor;
input				wrsr_mpor;
input				wrsr_hw;
input				wrsr_wdt;
input				wrsr_sw;
input				wrsr_extw;
input				wrsr_alm;
input				wrsr_dbg;
`ifdef AE250_SMU_SCRATCH_SUPPORT
output				scratch_wen;
input	[`AE250_SMU_SCRATCH_BIT-1:0]	scratch_reg;
`endif


`ifdef NDS_BOARD_CF1
output	[31:0]			cf1_pinmux_ctrl0;
output	[31:0]			cf1_pinmux_ctrl1;
`endif

input				core2smu_wfi_mode;
input				smu2core_wakeup_ok;
output				standby_cmd_reg;
input				standby_cmd_clr;

output				sw_rstn;
output				mpd_pwr_dis_wr_reg;

output	[3:0]			clock_ratio_reg;
output				smu_core_clk_en;
output				smu_hclk_en;
output	[8:0]			smu_pclk_en;
output  [31:0]			reset_vector;
output  			icache_disable_init;
output  			dcache_disable_init;

output	 			smu_pwr_ctrl_cmd_we;
output	[2:0]			smu_pwr_ctrl_cmd;
output	 			smu_iso_cyc_we;
output	[CYCLE_WIDTH-1:0]	smu_iso_cyc;
output				smu_ret_cyc_we;
output	[CYCLE_WIDTH-1:0]	smu_ret_cyc;
output				smu_wakeup_enable_we;
output	[WAKEUP_WIDTH-1:0]	smu_wakeup_enable;

input	[2:0]			smu_pwr_ctrl_cmd_pending;
input	[2:0]			smu_pwr_status;
input	[WAKEUP_WIDTH-1:0]	smu_wakeup_record;

output                          smu_pwr_ctrl_int_en_we;
output                          smu_pwr_ctrl_int_en;
output                          smu_pwr_ctrl_int_pending_we;
output                          smu_pwr_ctrl_int_pending_clr;
input                           smu_pwr_ctrl_int_pending;

input                           dbg_wakeup_req;
wire		wrsr_reg_sel;
wire		smucr_reg_sel;
`ifdef AE250_SMU_SCRATCH_SUPPORT
wire		scratch_reg_sel;
wire	[32:0]	scratch_reg_out;
`endif
wire		wr_mask_reg_sel;
wire		cer_reg_sel;
wire		crr_reg_sel;
`ifdef AE250_SMU_USERDR0_SUPPORT
wire		userdr0_reg_sel;
wire	[32:0]	userdr0_reg_out;
`endif
`ifdef AE250_SMU_USERDR1_SUPPORT
wire		userdr1_reg_sel;
wire	[32:0]	userdr1_reg_out;
`endif

wire		pwrite_valid;
reg	[31:0]	prdata;

reg		standby_cmd_reg;
reg		swrst_reg;
reg		mpd_pwr_dis_wr_reg;

reg	[10:0]	clock_en_reg;
wire		core2smu_wfi_mode_pclk_pulse;
reg		smu_core_clk_en_r;
reg		smu_hclk_en_r;
reg		smu_pclk_en_r;

wire		reset_vector_reg_sel;
reg	[31:0]	reset_vector;

`ifdef NDS_BOARD_CF1
wire		cf1_pinmux_ctrl0_reg_sel;
reg	[31:0]	cf1_pinmux_ctrl0_reg;
wire		cf1_pinmux_ctrl1_reg_sel;
reg	[31:0]	cf1_pinmux_ctrl1_reg;
`endif

reg	[3:0]	clock_ratio_reg;

`ifdef AE250_SMU_USERDR0_SUPPORT
reg	[`AE250_SMU_USERDR0_BIT-1:0]		userdr0_reg;
`endif
`ifdef AE250_SMU_USERDR1_SUPPORT
reg	[`AE250_SMU_USERDR1_BIT-1:0]		userdr1_reg;
`endif

wire pmcr_reg_sel       = ({paddr, 2'b0} == 13'h100);
wire pmdir_reg_sel      = ({paddr, 2'b0} == 13'h104);
wire pdsr_reg_sel       = ({paddr, 2'b0} == 13'h108);
wire psr_reg_sel        = ({paddr, 2'b0} == 13'h10c);
wire pwrr_reg_sel       = ({paddr, 2'b0} == 13'h110);
wire wer_reg_sel        = ({paddr, 2'b0} == 13'h114);
wire pcr_reg_sel        = ({paddr, 2'b0} == 13'h118);
wire pir_reg_sel        = ({paddr, 2'b0} == 13'h11c);

wire [31:0] pmcr_reg_out;
wire [31:0] pmdir_reg_out;
wire [31:0] pdsr_reg_out;
wire [31:0] psr_reg_out;
wire [31:0] pwrr_reg_out;
wire [31:0] wer_reg_out;
wire [31:0] pcr_reg_out;
wire [31:0] pir_reg_out;

reg [CYCLE_WIDTH-1:0]        ret_cyc_reg;
reg [CYCLE_WIDTH-1:0]        iso_cyc_reg;
reg [DISALBE_INIT_WIDTH-1:0] disable_init_reg;
reg [WAKEUP_WIDTH-1:0]       pd_wakeup_en_reg;
wire [3:0]		     pd_ctrl_frq_reg = 4'b0;
wire [3:0]		     pd_ctrl_vol_reg = 4'b0;
reg 			     pd_ctrl_int_en_reg;

wire          [31:0]  core_resetn_reg_out;
wire                  dbg_wakeup_req_pclk_pulse;
wire 		      core_resetn_reg_sel = ({paddr, 2'b0} == 13'h044);

assign core_resetn_reg_out[0] = 1'b1;
assign core_resetn_reg_out[31:2] = 30'd0;

assign core_resetn_reg_out[1] = 1'b0;

assign wrsr_reg_sel	= ({paddr, 2'b0} == 13'h010);
assign smucr_reg_sel	= ({paddr, 2'b0} == 13'h014);
assign wr_mask_reg_sel  = ({paddr, 2'b0} == 13'h01c);
assign cer_reg_sel	= ({paddr, 2'b0} == 13'h020);
assign crr_reg_sel	= ({paddr, 2'b0} == 13'h024);
`ifdef AE250_SMU_USERDR0_SUPPORT
assign userdr0_reg_sel	= ({paddr, 2'b0} == 13'h030);
`endif
`ifdef AE250_SMU_USERDR1_SUPPORT
assign userdr1_reg_sel	= ({paddr, 2'b0} == 13'h034);
`endif
`ifdef AE250_SMU_SCRATCH_SUPPORT
assign scratch_reg_sel  = ({paddr, 2'b0} == 13'h040);
`endif

assign reset_vector_reg_sel = ({paddr, 2'b0} == 13'h050);

`ifdef NDS_BOARD_CF1
assign cf1_pinmux_ctrl0_reg_sel = ({paddr, 2'b0} == 13'h1000);
assign cf1_pinmux_ctrl1_reg_sel = ({paddr, 2'b0} == 13'h1004);
`endif

wire   smu_clock_standby_rstn;


assign pwrite_valid = psel & pwrite & penable;
assign icache_disable_init = disable_init_reg[0];
assign dcache_disable_init = disable_init_reg[1];

always @*
begin
	if (psel & (~pwrite))
		case(paddr)
			11'h00:	prdata = `AE250_PRODUCT_ID;
			11'h01:	prdata = `AE250_BOARD_ID;
			11'h04:	prdata = {21'h0, wrsr_dbg, wrsr_alm, wrsr_extw, 3'h0, wrsr_sw, wrsr_wdt, wrsr_hw, wrsr_mpor, wrsr_apor};
			11'h07:	prdata = {21'h0, wr_mask_reg, 8'h0};
			11'h08:	prdata = {21'h0, clock_en_reg};
			11'h09:	prdata = {28'h0, clock_ratio_reg};
			`ifdef AE250_SMU_USERDR0_SUPPORT
			11'h0c:	prdata = userdr0_reg_out[31:0];
			`endif
			`ifdef AE250_SMU_USERDR1_SUPPORT
			11'h0d:	prdata = userdr1_reg_out[31:0];
			`endif
`ifdef AE250_SMU_SCRATCH_SUPPORT
			11'h10:	prdata = scratch_reg_out[31:0];
`endif
			11'h11:  prdata = core_resetn_reg_out;
			11'h14:	prdata = reset_vector[31:0];
			11'h40:	prdata = pmcr_reg_out;
			11'h41:	prdata = pmdir_reg_out;
			11'h42:	prdata = pdsr_reg_out;
			11'h43:	prdata = psr_reg_out;
			11'h44:	prdata = pwrr_reg_out;
			11'h45:	prdata = wer_reg_out;
			11'h46:	prdata = pcr_reg_out;
			11'h47:	prdata = pir_reg_out;
`ifdef NDS_BOARD_CF1
			11'h400:prdata = cf1_pinmux_ctrl0_reg;
			11'h401:prdata = cf1_pinmux_ctrl1_reg;
`endif
			default:	prdata = 32'h0000;
		endcase
	else
		prdata = 32'h0000;
end


assign wrsr_wen = pwrite_valid & wrsr_reg_sel;

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		standby_cmd_reg <= 1'b0;
	else if (pwrite_valid & smucr_reg_sel)
		standby_cmd_reg <= (pwdata[7:0] == 8'h55);
	else if (standby_cmd_clr)
		standby_cmd_reg <= 1'b0;
	else
		standby_cmd_reg <= standby_cmd_reg;
end


always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		swrst_reg <= 1'b0;
	else if (pwrite_valid & smucr_reg_sel)
		swrst_reg <= (pwdata[7:0] == 8'h3c);
	else
		swrst_reg <= swrst_reg;
end

assign sw_rstn = ~swrst_reg;

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		mpd_pwr_dis_wr_reg <= 1'b0;
	else if (pwrite_valid & smucr_reg_sel)
		mpd_pwr_dis_wr_reg <= (pwdata[7:0] == 8'h5a);
	else
		mpd_pwr_dis_wr_reg <= mpd_pwr_dis_wr_reg;
end

`ifdef AE250_SMU_SCRATCH_SUPPORT
assign scratch_wen = pwrite_valid & scratch_reg_sel;
assign scratch_reg_out = {{(33-`AE250_SMU_SCRATCH_BIT){1'b0}}, scratch_reg};
`endif

assign wr_mask_wen = (pwrite_valid & wr_mask_reg_sel);

nds_sync_l2l core2smu_wfi_mode_pclk_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(core2smu_wfi_mode),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(core2smu_wfi_mode_pclk_pulse),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		clock_en_reg <= `AE250_SMU_CLKE_DEFAULT;
	else if (core2smu_wfi_mode_pclk_pulse)
		clock_en_reg <= {clock_en_reg[10:3], `AE250_SMU_PCLKE_DEFAULT, `AE250_SMU_HCLKE_DEFAULT, `AE250_SMU_CCLKE_DEFAULT};
	else if (pwrite_valid & cer_reg_sel)
		clock_en_reg <= pwdata[10:0];
	else
		clock_en_reg <= clock_en_reg;
end

nds_sync_l2l dbg_wakeup_req_pclk_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(dbg_wakeup_req),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(dbg_wakeup_req_pclk_pulse),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

assign smu_clock_standby_rstn = presetn & (~smu2core_wakeup_ok);
always @(negedge smu_clock_standby_rstn or posedge pclk)
begin
	if (!smu_clock_standby_rstn) begin
		smu_core_clk_en_r <= `AE250_SMU_CCLKE_DEFAULT;
		smu_hclk_en_r     <= `AE250_SMU_HCLKE_DEFAULT;
		smu_pclk_en_r     <= `AE250_SMU_PCLKE_DEFAULT;
	end else if (core2smu_wfi_mode_pclk_pulse) begin
		smu_core_clk_en_r <= clock_en_reg[0];
		smu_hclk_en_r     <= clock_en_reg[1];
		smu_pclk_en_r     <= clock_en_reg[2];
	end else if (dbg_wakeup_req_pclk_pulse) begin
		smu_hclk_en_r     <= 1'b1;
		smu_pclk_en_r     <= 1'b1;
	end
end

assign smu_core_clk_en	= smu_core_clk_en_r;
assign smu_hclk_en	= smu_hclk_en_r;
assign smu_pclk_en	= {clock_en_reg[10:3], smu_pclk_en_r};

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		clock_ratio_reg <= `AE250_SMU_CLKR_DEFAULT;
	else if (pwrite_valid & crr_reg_sel)
		clock_ratio_reg <= pwdata[3:0];
	else
		clock_ratio_reg <= clock_ratio_reg;
end

always @(negedge mpd_por_b_psync or posedge pclk)
begin
        if (!mpd_por_b_psync)
                reset_vector <= `AE250_SMU_RESET_VECTOR_DEFAULT;
        else if (pwrite_valid & reset_vector_reg_sel)
                reset_vector <= pwdata[31:0];
end

`ifdef AE250_SMU_USERDR0_SUPPORT
always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		userdr0_reg <= `AE250_SMU_USERDR0_DEFAULT;
	else if (pwrite_valid & userdr0_reg_sel)
		userdr0_reg <= pwdata[`AE250_SMU_USERDR0_BIT-1:0];
	else
		userdr0_reg <= userdr0_reg;
end

assign userdr0_reg_out = {{(33-`AE250_SMU_USERDR0_BIT){1'b0}}, userdr0_reg};
`endif

`ifdef AE250_SMU_USERDR1_SUPPORT
always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		userdr1_reg <= `AE250_SMU_USERDR1_DEFAULT;
	else if (pwrite_valid & userdr1_reg_sel)
		userdr1_reg <= pwdata[`AE250_SMU_USERDR1_BIT-1:0];
	else
		userdr1_reg <= userdr1_reg;
end

assign userdr1_reg_out = {{(33-`AE250_SMU_USERDR1_BIT){1'b0}}, userdr1_reg};
`endif

assign pmcr_reg_out = {{(16-CYCLE_WIDTH){1'b0}}, iso_cyc_reg, {(16-CYCLE_WIDTH){1'b0}}, ret_cyc_reg};

assign smu_ret_cyc_we = pwrite_valid & pmcr_reg_sel;
assign smu_ret_cyc    = pwdata[CYCLE_WIDTH-1:0];
assign smu_iso_cyc_we = pwrite_valid & pmcr_reg_sel;
assign smu_iso_cyc    = pwdata[CYCLE_WIDTH+15:16];

always @(negedge presetn or posedge pclk)
begin
        if (!presetn)
                ret_cyc_reg <= {CYCLE_WIDTH{1'b0}};
        else if (pwrite_valid & pmcr_reg_sel)
                ret_cyc_reg <= pwdata[CYCLE_WIDTH-1:0];
	else
		ret_cyc_reg <= ret_cyc_reg;
end

always @(negedge presetn or posedge pclk)
begin
        if (!presetn)
                iso_cyc_reg <= {CYCLE_WIDTH{1'b0}};
        else if (pwrite_valid & pmcr_reg_sel)
                iso_cyc_reg <= pwdata[CYCLE_WIDTH+15:16];
	else
		iso_cyc_reg <= iso_cyc_reg;
end

assign pmdir_reg_out = {{(32-DISALBE_INIT_WIDTH){1'b0}}, disable_init_reg};

always @(negedge presetn or posedge pclk)
begin
        if (!presetn)
                disable_init_reg <= {DISALBE_INIT_WIDTH{1'b0}};
        else if (pwrite_valid & pmdir_reg_sel)
                disable_init_reg <= pwdata[DISALBE_INIT_WIDTH-1:0];
	else
		disable_init_reg <= disable_init_reg;
end

assign pdsr_reg_out = {28'b0, 4'b0};

assign psr_reg_out = {29'b0, smu_pwr_status};

generate
if (WAKEUP_WIDTH >= 32) begin:  gen_pwrr_reg_out_width_ge_32
    assign pwrr_reg_out = smu_wakeup_record;
end
else begin:     gen_pwrr_reg_out_size_less_32
    assign pwrr_reg_out = {{(32-WAKEUP_WIDTH){1'b0}}, smu_wakeup_record};
end
endgenerate

generate
if (WAKEUP_WIDTH >= 32) begin:  gen_pd_wakeup_en_reg_width_ge_32
    assign wer_reg_out = pd_wakeup_en_reg;
end
else begin:     gen_pd_wakeup_en_reg_width_less_32
    assign wer_reg_out = {{(32-WAKEUP_WIDTH){1'b0}}, pd_wakeup_en_reg};
end
endgenerate

assign smu_wakeup_enable_we = pwrite_valid & wer_reg_sel;
assign smu_wakeup_enable    = pwdata[WAKEUP_WIDTH-1:0];

always @(negedge presetn or posedge pclk)
begin
        if (!presetn)
                pd_wakeup_en_reg <= {WAKEUP_WIDTH{1'b1}};
        else if (pwrite_valid & wer_reg_sel)
                pd_wakeup_en_reg <= pwdata[WAKEUP_WIDTH-1:0];
	else
		pd_wakeup_en_reg <= pd_wakeup_en_reg;
end

assign pcr_reg_out = {21'b0, pd_ctrl_vol_reg, pd_ctrl_frq_reg, smu_pwr_ctrl_cmd_pending};

assign smu_pwr_ctrl_cmd_we = pwrite_valid & pcr_reg_sel;
assign smu_pwr_ctrl_cmd    = pwdata[2:0];

assign pir_reg_out = {30'b0, smu_pwr_ctrl_int_pending, pd_ctrl_int_en_reg};

assign smu_pwr_ctrl_int_en_we      = pwrite_valid & pir_reg_sel;
assign smu_pwr_ctrl_int_pending_we = pwrite_valid & pir_reg_sel;
assign smu_pwr_ctrl_int_en 	   = pwdata[0];
assign smu_pwr_ctrl_int_pending_clr= ~pwdata[1];

always @(negedge presetn or posedge pclk)
begin
        if (!presetn)
                pd_ctrl_int_en_reg <= 1'b0;
        else if (pwrite_valid & pir_reg_sel)
                pd_ctrl_int_en_reg <= pwdata[0];
	else
		pd_ctrl_int_en_reg <= pd_ctrl_int_en_reg;

end

`ifdef NDS_BOARD_CF1
always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		cf1_pinmux_ctrl0_reg <= `AE250_SMU_CF1_PINMUX_CTRL0_DEFAULT;
	else if (pwrite_valid && cf1_pinmux_ctrl0_reg_sel)
		cf1_pinmux_ctrl0_reg <= pwdata[31:0];
	else
		cf1_pinmux_ctrl0_reg <= cf1_pinmux_ctrl0_reg;
end

assign cf1_pinmux_ctrl0 = cf1_pinmux_ctrl0_reg;

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		cf1_pinmux_ctrl1_reg <= `AE250_SMU_CF1_PINMUX_CTRL1_DEFAULT;
	else if (pwrite_valid && cf1_pinmux_ctrl1_reg_sel)
		cf1_pinmux_ctrl1_reg <= pwdata[31:0];
	else
		cf1_pinmux_ctrl1_reg <= cf1_pinmux_ctrl1_reg;
end

assign cf1_pinmux_ctrl1 = cf1_pinmux_ctrl1_reg;

`endif

endmodule

