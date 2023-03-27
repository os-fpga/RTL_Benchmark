`include "config.inc"
`include "ae350_const.vh"
`include "sample_ae350_smu_config.vh"
`include "sample_ae350_smu_const.vh"



module sample_ae350_smu_apbif (
		  mpd_por_rstn,
		  pclk,
		  presetn,
		  psel,
		  penable,
		  paddr,
		  pwdata,
		  pwrite,
		  prdata,
		  pready,
		  pslverr,
		  pcs0_rdata,
		  pcs1_rdata,
		  pcs2_rdata,
		  pcs3_rdata,
		  pcs4_rdata,
		  pcs5_rdata,
		  pcs6_rdata,
		  pcs7_rdata,
		  pcs8_rdata,
		  pcs9_rdata,
		  pcs10_rdata,
		  pcs0_reset_source,
		  pcs1_reset_source,
		  pcs2_reset_source,
		  pcs3_reset_source,
		  pcs4_reset_source,
		  pcs5_reset_source,
		  pcs6_reset_source,
		  pcs7_reset_source,
		  pcs8_reset_source,
		  pcs9_reset_source,
		  pcs10_reset_source,
		  pcs_sel,
		  pcs_wdata,
		  pcs_write,
		  pcs_sel_cfg,
		  pcs_sel_scratch,
		  pcs_sel_misc,
		  pcs_sel_misc2,
		  pcs_sel_we,
		  pcs_sel_ctl,
		  pcs_sel_status,
		  pcs_sel_cer,
		  pcs_hart_resetn,
	`ifdef NDS_FPGA
		  ddr3_latency,
		  ddr3_bw_ctrl,
	   `ifdef NDS_IO_PROBING
		  hart0_probe_current_pc,
		  hart0_probe_gpr_index,
		  hart0_probe_selected_gpr_value,
	   `endif
	`endif
		  smu_sw_rst,
		  core_reset_vectors,
		  system_clock_ratio
);

parameter	NDS_NHART = 1;

parameter	PCS_NUM    = 8;
parameter	SYS_TS     = 32'h0;
parameter	PRODUCT_ID = `AE350_PRODUCT_ID;
parameter	BOARD_ID   = `AE350_BOARD_ID;

input		mpd_por_rstn;
input		pclk;
input		presetn;
input		psel;
input		penable;
input	[9:2]	paddr;
input	[31:0]	pwdata;
input		pwrite;
output	[31:0]	prdata;
output		pready;
output		pslverr;


input	[31:0]	pcs0_rdata;
input	[31:0]	pcs1_rdata;
input	[31:0]	pcs2_rdata;
input	[31:0]	pcs3_rdata;
input	[31:0]	pcs4_rdata;
input	[31:0]	pcs5_rdata;
input	[31:0]	pcs6_rdata;
input	[31:0]	pcs7_rdata;
input	[31:0]	pcs8_rdata;
input	[31:0]	pcs9_rdata;
input	[31:0]	pcs10_rdata;

input	[4:0]	pcs0_reset_source;
input	[4:0]	pcs1_reset_source;
input	[4:0]	pcs2_reset_source;
input	[4:0]	pcs3_reset_source;
input	[4:0]	pcs4_reset_source;
input	[4:0]	pcs5_reset_source;
input	[4:0]	pcs6_reset_source;
input	[4:0]	pcs7_reset_source;
input	[4:0]	pcs8_reset_source;
input	[4:0]	pcs9_reset_source;
input	[4:0]	pcs10_reset_source;

output	[10:0]	pcs_sel;
output	[31:0]	pcs_wdata;
output		pcs_write;
output		pcs_sel_cfg;
output		pcs_sel_scratch;
output		pcs_sel_misc;
output		pcs_sel_misc2;
output		pcs_sel_we;
output		pcs_sel_ctl;
output		pcs_sel_status;
output		pcs_sel_cer;
output  [31:0]	pcs_hart_resetn;

`ifdef NDS_FPGA
output	[3:0]	ddr3_latency;
output  [1:0]	ddr3_bw_ctrl;
	`ifdef NDS_IO_PROBING
input  [31:0]   hart0_probe_current_pc;
output [12:0]   hart0_probe_gpr_index;
input  [31:0]   hart0_probe_selected_gpr_value;
	`endif
`endif

output reg	smu_sw_rst;

output	[64*8-1:0]	core_reset_vectors;

output reg [3:0] system_clock_ratio;


localparam	PCS_BATCH_SUPPORT = 0;
localparam	DVFS_SUPPORT = 0;
localparam	FIX_VOLTAGE = 1;

localparam	OFFSET_SYSTEMVER    	= 10'h00;
localparam	OFFSET_BOARDID     	= 10'h04;
localparam	OFFSET_SYSTEMCFG    	= 10'h08;
localparam	OFFSET_SMUVER       	= 10'h0c;
localparam	OFFSET_WAKEUPST     	= 10'h10;
localparam	OFFSET_SMUCR      	= 10'h14;
localparam	OFFSET_CLKEN		= 10'h20;
localparam	OFFSET_SYSTEMCR     	= 10'h24;
localparam	OFFSET_PCS_SEL      	= 10'h30;
localparam	OFFSET_PROBE_PC		= 10'h34;
localparam	OFFSET_PROBE_GPR  	= 10'h38;
localparam	OFFSET_PROBE_WR_INDEX  	= 10'h3c;
localparam	OFFSET_SYS_SCRATCH     	= 10'h40;
localparam	OFFSET_HART_RESET_CTL  	= 10'h44;

localparam	OFFSET_HART0_RST_VEC	= 10'h50;
localparam	OFFSET_HART1_RST_VEC	= 10'h54;
localparam	OFFSET_HART2_RST_VEC	= 10'h58;
localparam	OFFSET_HART3_RST_VEC	= 10'h5c;

localparam	OFFSET_HART0_RST_VEC_HI = 10'h60;
localparam	OFFSET_HART1_RST_VEC_HI = 10'h64;
localparam	OFFSET_HART2_RST_VEC_HI = 10'h68;
localparam	OFFSET_HART3_RST_VEC_HI = 10'h6c;

localparam	OFFSET_SYSTEMTS		= 10'h70;

localparam	OFFSET_CFG		= 10'h80;
localparam	OFFSET_SCRATCH		= 10'h84;
localparam	OFFSET_MISC		= 10'h88;
localparam	OFFSET_MISC2		= 10'h8c;
localparam	OFFSET_WE		= 10'h90;
localparam	OFFSET_CTL		= 10'h94;
localparam	OFFSET_STATUS		= 10'h98;

localparam	OFFSET_HART4_RST_VEC	= 10'h200;
localparam	OFFSET_HART5_RST_VEC	= 10'h204;
localparam	OFFSET_HART6_RST_VEC	= 10'h208;
localparam	OFFSET_HART7_RST_VEC	= 10'h20c;

localparam	OFFSET_HART4_RST_VEC_HI = 10'h210;
localparam	OFFSET_HART5_RST_VEC_HI = 10'h214;
localparam	OFFSET_HART6_RST_VEC_HI = 10'h218;
localparam	OFFSET_HART7_RST_VEC_HI = 10'h21c;

localparam	RESET_VECTOR_DEFAULT	= `SAMPLE_AE350_SMU_RESET_VECTOR_LO_DEFAULT;
localparam	RESET_VECTOR_HI_DEFAULT	= `SAMPLE_AE350_SMU_RESET_VECTOR_HI_DEFAULT;


localparam	OFFSET_DDR3_LATENCY    	= 10'h300;
localparam	OFFSET_SRAM_SIZE      	= 10'h304;

localparam	L2C_CACHE_SIZE_KB	= `NDS_L2C_CACHE_SIZE_KB;

wire	[7:0]	core_num = NDS_NHART[7:0];
wire		l2c_existence;
wire		dfs_support;
	assign dfs_support = 1'b0;

generate
	if (L2C_CACHE_SIZE_KB > 0) begin: gen_l2c_existence
		assign l2c_existence = 1'b1;
	end
	else begin : gen_non_l2c_existence
		assign l2c_existence = 1'b0;
	end
endgenerate



`ifdef NDS_FPGA
wire	[31:0]	ddr3_latency_reg_out;
wire	[31:0]	sram_size_reg_out;
`endif

assign		pcs_wdata = pwdata;
assign		pcs_write = pwrite & penable & psel;

assign		pcs_sel_cfg	= (paddr[4:2] == OFFSET_CFG[4:2]	);
assign		pcs_sel_scratch	= (paddr[4:2] == OFFSET_SCRATCH[4:2]	);
assign		pcs_sel_misc	= (paddr[4:2] == OFFSET_MISC[4:2]	);
assign		pcs_sel_misc2	= (paddr[4:2] == OFFSET_MISC2[4:2]	);
assign		pcs_sel_we	= (paddr[4:2] == OFFSET_WE[4:2]		);
assign		pcs_sel_ctl	= (paddr[4:2] == OFFSET_CTL[4:2]	);
assign		pcs_sel_status	= (paddr[4:2] == OFFSET_STATUS[4:2]	);
assign		pcs_sel_cer	= (paddr[9:2] == OFFSET_CLKEN[9:2]      ) & psel;

wire	[31:0]	prdata_pcs;
wire	[4:0]	pcs_reset_source;

generate
if (PCS_BATCH_SUPPORT) begin: gen_pcs_batch_mode
	assign pcs_sel = 0;
	assign prdata_pcs = 0;
	assign pcs_reset_source = 5'd0;
end
else begin: gen_pcs_singal_mode
	assign pcs_sel[0] = (PCS_NUM > 0) & (paddr[9:5] == 5'b00_100) & psel;
	assign pcs_sel[1] = (PCS_NUM > 1) & (paddr[9:5] == 5'b00_101) & psel;
	assign pcs_sel[2] = (PCS_NUM > 2) & (paddr[9:5] == 5'b00_110) & psel;
	assign pcs_sel[3] = (PCS_NUM > 3) & (paddr[9:5] == 5'b00_111) & psel;
	assign pcs_sel[4] = (PCS_NUM > 4) & (paddr[9:5] == 5'b01_000) & psel;
	assign pcs_sel[5] = (PCS_NUM > 5) & (paddr[9:5] == 5'b01_001) & psel;
	assign pcs_sel[6] = (PCS_NUM > 6) & (paddr[9:5] == 5'b01_010) & psel;
	assign pcs_sel[7] = (PCS_NUM > 7) & (paddr[9:5] == 5'b01_011) & psel;
	assign pcs_sel[8] = (PCS_NUM > 8) & (paddr[9:5] == 5'b01_100) & psel;
	assign pcs_sel[9] = (PCS_NUM > 9) & (paddr[9:5] == 5'b01_101) & psel;
	assign pcs_sel[10]= (PCS_NUM > 10)& (paddr[9:5] == 5'b01_110) & psel;

	assign prdata_pcs = ({32{pcs_sel[0]}} & pcs0_rdata)
			  | ({32{pcs_sel[1]}} & pcs1_rdata)
			  | ({32{pcs_sel[2]}} & pcs2_rdata)
			  | ({32{pcs_sel[3]}} & pcs3_rdata)
			  | ({32{pcs_sel[4]}} & pcs4_rdata)
			  | ({32{pcs_sel[5]}} & pcs5_rdata)
			  | ({32{pcs_sel[6]}} & pcs6_rdata)
			  | ({32{pcs_sel[7]}} & pcs7_rdata)
			  | ({32{pcs_sel[8]}} & pcs8_rdata)
			  | ({32{pcs_sel[9]}} & pcs9_rdata)
			  | ({32{pcs_sel[10]}}& pcs10_rdata)
                          ;

	wire	default_reset_source;
	assign default_reset_source = ~|pcs_sel[10:1];
	assign pcs_reset_source = ({5{default_reset_source}} & pcs0_reset_source)
			        | ({5{pcs_sel[1]}} & pcs1_reset_source)
			        | ({5{pcs_sel[2]}} & pcs2_reset_source)
			        | ({5{pcs_sel[3]}} & pcs3_reset_source)
			        | ({5{pcs_sel[4]}} & pcs4_reset_source)
			        | ({5{pcs_sel[5]}} & pcs5_reset_source)
			        | ({5{pcs_sel[6]}} & pcs6_reset_source)
			        | ({5{pcs_sel[7]}} & pcs7_reset_source)
			        | ({5{pcs_sel[8]}} & pcs8_reset_source)
			        | ({5{pcs_sel[9]}} & pcs9_reset_source)
			        | ({5{pcs_sel[10]}}& pcs10_reset_source)
                                ;
end
endgenerate

wire		sr_sel_pcs;
wire		sr_sel_systemver      = (paddr[9:2] == OFFSET_SYSTEMVER      [9:2]);
wire		sr_sel_boardid        = (paddr[9:2] == OFFSET_BOARDID        [9:2]);
wire		sr_sel_systemcfg      = (paddr[9:2] == OFFSET_SYSTEMCFG      [9:2]);
wire		sr_sel_smuver         = (paddr[9:2] == OFFSET_SMUVER         [9:2]);
wire		sr_sel_systemcr       = (paddr[9:2] == OFFSET_SYSTEMCR       [9:2]);
wire		sr_sel_sys_scratch    = (paddr[9:2] == OFFSET_SYS_SCRATCH    [9:2]);
wire		sr_sel_hart_reset_ctl = (paddr[9:2] == OFFSET_HART_RESET_CTL [9:2]);
wire		sr_sel_wakeup_rst_st  = (paddr[9:2] == OFFSET_WAKEUPST       [9:2]);
wire		sr_sel_clken          = (paddr[9:2] == OFFSET_CLKEN          [9:2]);
wire		sr_sel_systemts       = (paddr[9:2] == OFFSET_SYSTEMTS       [9:2]);

`ifdef NDS_FPGA
wire		sr_sel_ddr3_latency   = (paddr[9:2] == OFFSET_DDR3_LATENCY   [9:2]);
wire		sr_sel_sram_size      = (paddr[9:2] == OFFSET_SRAM_SIZE      [9:2]);
	`ifdef NDS_IO_PROBING
wire		sr_sel_probe_pc	      = (paddr[9:2] == OFFSET_PROBE_PC       [9:2]);
wire		sr_sel_probe_gpr      = (paddr[9:2] == OFFSET_PROBE_GPR      [9:2]);
wire		sr_sel_probe_wr_index = (paddr[9:2] == OFFSET_PROBE_WR_INDEX [9:2]);
	`endif
`endif

wire [7:0]	sr_sel_hart_rst_vec_lo = {(NDS_NHART > 7) & (paddr[9:2] == OFFSET_HART7_RST_VEC[9:2]),
                                          (NDS_NHART > 6) & (paddr[9:2] == OFFSET_HART6_RST_VEC[9:2]),
                                          (NDS_NHART > 5) & (paddr[9:2] == OFFSET_HART5_RST_VEC[9:2]),
                                          (NDS_NHART > 4) & (paddr[9:2] == OFFSET_HART4_RST_VEC[9:2]),
                                          (NDS_NHART > 3) & (paddr[9:2] == OFFSET_HART3_RST_VEC[9:2]),
				          (NDS_NHART > 2) & (paddr[9:2] == OFFSET_HART2_RST_VEC[9:2]),
				          (NDS_NHART > 1) & (paddr[9:2] == OFFSET_HART1_RST_VEC[9:2]),
				          (NDS_NHART > 0) & (paddr[9:2] == OFFSET_HART0_RST_VEC[9:2])};

wire [7:0]	sr_sel_hart_rst_vec_hi;
assign	sr_sel_hart_rst_vec_hi = {(NDS_NHART > 7) & (paddr[9:2] == OFFSET_HART7_RST_VEC_HI[9:2]),
			          (NDS_NHART > 6) & (paddr[9:2] == OFFSET_HART6_RST_VEC_HI[9:2]),
			          (NDS_NHART > 5) & (paddr[9:2] == OFFSET_HART5_RST_VEC_HI[9:2]),
			          (NDS_NHART > 4) & (paddr[9:2] == OFFSET_HART4_RST_VEC_HI[9:2]),
			          (NDS_NHART > 3) & (paddr[9:2] == OFFSET_HART3_RST_VEC_HI[9:2]),
			          (NDS_NHART > 2) & (paddr[9:2] == OFFSET_HART2_RST_VEC_HI[9:2]),
			          (NDS_NHART > 1) & (paddr[9:2] == OFFSET_HART1_RST_VEC_HI[9:2]),
			          (NDS_NHART > 0) & (paddr[9:2] == OFFSET_HART0_RST_VEC_HI[9:2])};

wire pwrite_valid = psel & pwrite & penable;

reg	[2:0] sr_cer;
wire	cer_wen = pwrite_valid & sr_sel_clken;
always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		sr_cer <= 3'b111;
	end
	else if (cer_wen) begin
		sr_cer <= pwdata[2:0];
	end
end

wire	smucr_wen = pwrite_valid & (paddr[9:2] == OFFSET_SMUCR[9:2]);
wire	smu_sw_rst_cmd = smucr_wen & (pwdata[7:0] == 8'h3c);
wire	smu_sw_rst_nx;
assign smu_sw_rst_nx = smu_sw_rst_cmd & ~smu_sw_rst;
always @(posedge pclk or negedge presetn)
begin
	if (!presetn) begin
		smu_sw_rst <= 1'b0;
	end
	else begin
		smu_sw_rst <= smu_sw_rst_nx;
	end
end

wire		update_systemcr = pwrite_valid & sr_sel_systemcr;
always @(posedge pclk or negedge presetn)
begin
	if (!presetn) begin
		system_clock_ratio <= `SAMPLE_AE350_SMU_CLKR_DEFAULT;
	end
	else if (update_systemcr) begin
		system_clock_ratio <= pwdata[3:0];
	end
end

wire		update_sys_scratch = pwrite_valid & sr_sel_sys_scratch;
reg [31:0]	system_scratch;
always @(posedge pclk or negedge presetn)
begin
	if (!presetn) begin
		system_scratch <= 32'h0;
	end
	else if (update_sys_scratch) begin
		system_scratch <= pwdata[31:0];
	end
end

wire	apor_rstn;
wire	mpor_rstn;
wire	hw_rstn;
wire	wdt_rstn;
wire	sw_rstn;

reg	apor_rstn_st;
reg	mpor_rstn_st;
reg	hw_rstn_st;
reg	wdt_rstn_st;
reg	sw_rstn_st;

assign apor_rstn = ~pcs_reset_source[0];
assign mpor_rstn = ~pcs_reset_source[4];
assign hw_rstn   = ~pcs_reset_source[3];
assign wdt_rstn  = ~pcs_reset_source[2];
assign sw_rstn   = ~pcs_reset_source[1];

wire	[31:0]	sr_systemver = PRODUCT_ID;
wire	[31:0]	sr_boardid   = BOARD_ID;
wire	[31:0]	sr_systemts = SYS_TS[31:0];
wire	[31:0]	sr_systemcfg = {22'b0, dfs_support, l2c_existence, core_num};
wire	[31:0]	sr_smuver = `SAMPLE_AE350_SMU_VERID;
wire	[31:0]	sr_systemcr = {28'b0, system_clock_ratio};
wire	[31:0]	sr_sys_scratch = system_scratch;
wire	[31:0] sr_wakeup_rst_st = {27'd0, sw_rstn_st, wdt_rstn_st, hw_rstn_st, mpor_rstn_st, apor_rstn_st};
wire	[31:0] sr_hart_rst_vec_lo [0:7];
wire	[31:0] sr_hart_rst_vec_hi [0:7];
wire	[31:0] sr_hart_reset_ctl;
wire	[63:0] sr_hart_rst_vec [0:7];

assign sr_hart_reset_ctl = {24'h0, 8'hff};

assign sr_hart_rst_vec[0] = {sr_hart_rst_vec_hi[0], sr_hart_rst_vec_lo[0]};
assign sr_hart_rst_vec[1] = {sr_hart_rst_vec_hi[1], sr_hart_rst_vec_lo[1]};
assign sr_hart_rst_vec[2] = {sr_hart_rst_vec_hi[2], sr_hart_rst_vec_lo[2]};
assign sr_hart_rst_vec[3] = {sr_hart_rst_vec_hi[3], sr_hart_rst_vec_lo[3]};
assign sr_hart_rst_vec[4] = {sr_hart_rst_vec_hi[4], sr_hart_rst_vec_lo[4]};
assign sr_hart_rst_vec[5] = {sr_hart_rst_vec_hi[5], sr_hart_rst_vec_lo[5]};
assign sr_hart_rst_vec[6] = {sr_hart_rst_vec_hi[6], sr_hart_rst_vec_lo[6]};
assign sr_hart_rst_vec[7] = {sr_hart_rst_vec_hi[7], sr_hart_rst_vec_lo[7]};

assign		core_reset_vectors = {sr_hart_rst_vec[7],
				      sr_hart_rst_vec[6],
				      sr_hart_rst_vec[5],
				      sr_hart_rst_vec[4],
				      sr_hart_rst_vec[3],
				      sr_hart_rst_vec[2],
				      sr_hart_rst_vec[1],
				      sr_hart_rst_vec[0]};

wire	clr_apor_rstn_st;
assign clr_apor_rstn_st = sr_sel_wakeup_rst_st & pwdata[0] & pwrite_valid;
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		apor_rstn_st <= 1'b1;
	end
	else if (clr_apor_rstn_st) begin
		apor_rstn_st <= 1'b0;
	end
end

wire	clr_mpor_rstn_st;
assign clr_mpor_rstn_st = sr_sel_wakeup_rst_st & pwdata[1] & pwrite_valid;
always @(posedge pclk or negedge mpor_rstn) begin
	if (!mpor_rstn) begin
		mpor_rstn_st <= 1'b1;
	end
	else if (clr_mpor_rstn_st) begin
		mpor_rstn_st <= 1'b0;
	end
end

wire	clr_hw_rstn_st;
wire	set_hw_rstn_st;
wire	hw_rstn_st_nx;
assign set_hw_rstn_st = !hw_rstn;
assign clr_hw_rstn_st = sr_sel_wakeup_rst_st & pwdata[2] & pwrite_valid;
assign hw_rstn_st_nx  = set_hw_rstn_st | (~clr_hw_rstn_st & hw_rstn_st);
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		hw_rstn_st <= 1'b0;
	end
	else begin
		hw_rstn_st <= hw_rstn_st_nx;
	end
end

wire	clr_wdt_rstn_st;
wire	set_wdt_rstn_st;
wire	wdt_rstn_st_nx;
assign set_wdt_rstn_st = !wdt_rstn;
assign clr_wdt_rstn_st = sr_sel_wakeup_rst_st & pwdata[3] & pwrite_valid;
assign wdt_rstn_st_nx  = set_wdt_rstn_st | (~clr_wdt_rstn_st & wdt_rstn_st);
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		wdt_rstn_st <= 1'b0;
	end
	else begin
		wdt_rstn_st <= wdt_rstn_st_nx;
	end
end

wire	clr_sw_rstn_st;
wire	set_sw_rstn_st;
wire	sw_rstn_st_nx;
assign set_sw_rstn_st = !sw_rstn;
assign clr_sw_rstn_st = sr_sel_wakeup_rst_st & pwdata[4] & pwrite_valid;
assign sw_rstn_st_nx  = set_sw_rstn_st | (~clr_sw_rstn_st & sw_rstn_st);
always @(posedge pclk or negedge apor_rstn) begin
	if (!apor_rstn) begin
		sw_rstn_st <= 1'b0;
	end
	else begin
		sw_rstn_st <= sw_rstn_st_nx;
	end
end

assign pcs_hart_resetn = sr_hart_reset_ctl;

reg	[31:2]	reg_sr_hart_rst_vec_lo [0:NDS_NHART-1];
reg	[31:0]	reg_sr_hart_rst_vec_hi [0:NDS_NHART-1];
genvar i;
generate
for (i = 0 ; i < 8 ; i = i + 1) begin: gen_rst_vectors_lo
	if (NDS_NHART > i) begin: gen_rst_vector_setup
		always @(negedge mpd_por_rstn or posedge pclk) begin
			if (!mpd_por_rstn)
				reg_sr_hart_rst_vec_lo[i] <= RESET_VECTOR_DEFAULT[31:2];
			else if (pwrite_valid & sr_sel_hart_rst_vec_lo[i])
				reg_sr_hart_rst_vec_lo[i] <= pwdata[31:2];
		end

		assign sr_hart_rst_vec_lo[i] = {reg_sr_hart_rst_vec_lo[i],2'b0};
	end
	else begin: gen_rst_vector_lo_default
		assign sr_hart_rst_vec_lo[i] = 32'b0;
	end
end
endgenerate

generate
for (i = 0 ; i < 8 ; i = i + 1) begin: gen_rst_vectors_hi
	if (NDS_NHART > i) begin: gen_rst_vector_hi_setup
		always @(negedge mpd_por_rstn or posedge pclk) begin
			if (!mpd_por_rstn)
				reg_sr_hart_rst_vec_hi[i] <= RESET_VECTOR_HI_DEFAULT[31:0];
			else if (pwrite_valid & sr_sel_hart_rst_vec_hi[i])
				reg_sr_hart_rst_vec_hi[i] <= pwdata[31:0];
		end

		assign sr_hart_rst_vec_hi[i] = {reg_sr_hart_rst_vec_hi[i]};
	end
	else begin: gen_rst_vector_hi_default
		assign sr_hart_rst_vec_hi[i] = 32'd0;
	end
end
endgenerate

assign sr_sel_pcs = |pcs_sel;

assign		prdata = ({32{sr_sel_systemver      }} & sr_systemver		   )
		       | ({32{sr_sel_boardid        }} & sr_boardid		   )
		       | ({32{sr_sel_systemts       }} & sr_systemts      	   )
		       | ({32{sr_sel_systemcfg      }} & sr_systemcfg     	   )
		       | ({32{sr_sel_smuver         }} & sr_smuver        	   )
		       | ({32{sr_sel_systemcr       }} & sr_systemcr      	   )
		       | ({32{sr_sel_sys_scratch    }} & sr_sys_scratch   	   )
		       | ({32{sr_sel_hart_reset_ctl }} & sr_hart_reset_ctl	   )
		       | ({32{sr_sel_wakeup_rst_st  }} & sr_wakeup_rst_st	   )
		       | ({32{sr_sel_clken          }} & {29'h0, sr_cer}	   )
		       | ({32{sr_sel_hart_rst_vec_lo[0]}} & sr_hart_rst_vec_lo[0]  )
		       | ({32{sr_sel_hart_rst_vec_lo[1]}} & sr_hart_rst_vec_lo[1]  )
		       | ({32{sr_sel_hart_rst_vec_lo[2]}} & sr_hart_rst_vec_lo[2]  )
		       | ({32{sr_sel_hart_rst_vec_lo[3]}} & sr_hart_rst_vec_lo[3]  )
		       | ({32{sr_sel_hart_rst_vec_lo[4]}} & sr_hart_rst_vec_lo[4]  )
		       | ({32{sr_sel_hart_rst_vec_lo[5]}} & sr_hart_rst_vec_lo[5]  )
		       | ({32{sr_sel_hart_rst_vec_lo[6]}} & sr_hart_rst_vec_lo[6]  )
		       | ({32{sr_sel_hart_rst_vec_lo[7]}} & sr_hart_rst_vec_lo[7]  )
		       | ({32{sr_sel_hart_rst_vec_hi[0]}} & sr_hart_rst_vec_hi[0]  )
		       | ({32{sr_sel_hart_rst_vec_hi[1]}} & sr_hart_rst_vec_hi[1]  )
		       | ({32{sr_sel_hart_rst_vec_hi[2]}} & sr_hart_rst_vec_hi[2]  )
		       | ({32{sr_sel_hart_rst_vec_hi[3]}} & sr_hart_rst_vec_hi[3]  )
		       | ({32{sr_sel_hart_rst_vec_hi[4]}} & sr_hart_rst_vec_hi[4]  )
		       | ({32{sr_sel_hart_rst_vec_hi[5]}} & sr_hart_rst_vec_hi[5]  )
		       | ({32{sr_sel_hart_rst_vec_hi[6]}} & sr_hart_rst_vec_hi[6]  )
		       | ({32{sr_sel_hart_rst_vec_hi[7]}} & sr_hart_rst_vec_hi[7]  )
`ifdef NDS_FPGA
		       | ({32{sr_sel_ddr3_latency}} & ddr3_latency_reg_out	    )
		       | ({32{sr_sel_sram_size	 }} & sram_size_reg_out		    )
	`ifdef NDS_IO_PROBING
		       | ({32{sr_sel_probe_pc	 }} & hart0_probe_current_pc	    )
		       | ({32{sr_sel_probe_gpr   }} & hart0_probe_selected_gpr_value)
	`endif
`endif
		       | ({32{sr_sel_pcs}} & prdata_pcs);

assign		pready = 1'b1;
assign		pslverr = 1'b0;

`ifdef NDS_FPGA
	`ifdef NDS_IO_PROBING
		wire update_sys_probe_index = pwrite_valid & sr_sel_probe_wr_index;
		reg [12:0] hart0_probe_gpr_index;
		always @(negedge presetn or posedge pclk)
		begin
		        if (!presetn) begin
		                hart0_probe_gpr_index <= 13'd0;
			end
		        else if (update_sys_probe_index) begin
		                hart0_probe_gpr_index <= pwdata[12:0];
			end
		end
	`endif
`endif


`ifdef NDS_FPGA
`ifdef _AE350_DDR_SUPPORT
	`ifdef AE350_DDR3_LATENCY
		reg	[3:0]	ddr3_latency_reg;
		reg     [1:0]   ddr3_bw_ctrl_reg;
		reg		ddr3_latency_en;
		always @(negedge presetn or posedge pclk)
		begin
		        if (!presetn) begin
		                ddr3_latency_reg <= 4'd0;
				ddr3_bw_ctrl_reg <= 2'd0;
		                ddr3_latency_en  <= 1'b0;
			end
		        else if (pwrite_valid & sr_sel_ddr3_latency) begin
		                ddr3_latency_reg <= pwdata[3:0];
				ddr3_bw_ctrl_reg <= pwdata[5:4];
				ddr3_latency_en  <= pwdata[31];
			end
		end

		assign ddr3_latency_reg_out = {ddr3_latency_en, 27'h0, ddr3_latency_reg};
		assign ddr3_latency = ddr3_latency_en ? ddr3_latency_reg : 4'b0;
		assign ddr3_bw_ctrl = ddr3_bw_ctrl_reg;
	`else
		assign ddr3_latency_reg_out = 32'h0;
		assign ddr3_latency = 4'h0;
		assign ddr3_bw_ctrl = 2'h0;
	`endif
`else
	assign ddr3_latency_reg_out = 32'h0;
	assign ddr3_latency = 4'h0;
	assign ddr3_bw_ctrl = 2'h0;
`endif
`endif

`ifdef NDS_FPGA
`ifdef AE350_RAMBRG200_SUPPORT

	`ifdef AE350_SRAM_1KB
		localparam SRAM_SIZE_KB = $clog2(1) + 1;
	`endif
	`ifdef AE350_SRAM_2KB
		localparam SRAM_SIZE_KB = $clog2(2) + 1;
	`endif
	`ifdef AE350_SRAM_4KB
		localparam SRAM_SIZE_KB = $clog2(4) + 1;
	`endif
	`ifdef AE350_SRAM_8KB
		localparam SRAM_SIZE_KB = $clog2(8) + 1;
	`endif
	`ifdef AE350_SRAM_16KB
		localparam SRAM_SIZE_KB = $clog2(16) + 1;
	`endif
	`ifdef AE350_SRAM_32KB
		localparam SRAM_SIZE_KB = $clog2(32) + 1;
	`endif
	`ifdef AE350_SRAM_64KB
		localparam SRAM_SIZE_KB = $clog2(64) + 1;
	`endif
	`ifdef AE350_SRAM_128KB
		localparam SRAM_SIZE_KB = $clog2(128) + 1;
	`endif
	`ifdef AE350_SRAM_256KB
		localparam SRAM_SIZE_KB = $clog2(256) + 1;
	`endif
	`ifdef AE350_SRAM_512KB
		localparam SRAM_SIZE_KB = $clog2(512) + 1;
	`endif
	`ifdef AE350_SRAM_1MB
		localparam SRAM_SIZE_KB = $clog2(1024) + 1;
	`endif
	`ifdef AE350_SRAM_2MB
		localparam SRAM_SIZE_KB = $clog2(2048) + 1;
	`endif
	`ifdef AE350_SRAM_4MB
		localparam SRAM_SIZE_KB = $clog2(4096) + 1;
	`endif
	assign sram_size_reg_out = SRAM_SIZE_KB ;
`else
	assign sram_size_reg_out = 32'h0;
`endif
`endif

endmodule
