// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module ace (
	core_clk,
        core_reset_n,
	ace_cmd_valid,
	ace_cmd_inst,
	ace_cmd_pc,
	ace_cmd_rs1,
	ace_cmd_rs2,
	ace_cmd_rs3,
	ace_cmd_rs4,
	ace_cmd_ready,
	ace_error,
	ace_acr_dirty_set,
	ace_standby_ready,
	ace_xrf_rd1_ready,
	ace_xrf_rd1_valid,
	ace_xrf_rd1_index,
	ace_xrf_rd1_data,
	ace_xrf_rd1_status,
	ace_xrf_rd2_ready,
	ace_xrf_rd2_valid,
	ace_xrf_rd2_index,
	ace_xrf_rd2_data,
	ace_xrf_rd2_status,
	ace_sync_req,
	ace_sync_type,
	ace_sync_ack,
	ace_sync_ack_status,
	ace_interrupt
);

parameter XLEN	= 32;
parameter VALEN	= 32;

input				core_clk;
input				core_reset_n;
input				ace_cmd_valid;
input	[31:7]			ace_cmd_inst;
input	[VALEN-1:0]		ace_cmd_pc;
input	[XLEN-1:0]		ace_cmd_rs1;
input	[XLEN-1:0]		ace_cmd_rs2;
input	[XLEN-1:0]		ace_cmd_rs3;
input	[XLEN-1:0]		ace_cmd_rs4;
output				ace_cmd_ready;

output				ace_acr_dirty_set;

output				ace_error;
output				ace_standby_ready;

input				ace_xrf_rd1_ready;
output				ace_xrf_rd1_valid;
output	[4:0]			ace_xrf_rd1_index;
output	[XLEN-1:0]		ace_xrf_rd1_data;
output				ace_xrf_rd1_status;

input				ace_xrf_rd2_ready;
output				ace_xrf_rd2_valid;
output	[4:0]			ace_xrf_rd2_index;
output	[XLEN-1:0]		ace_xrf_rd2_data;
output				ace_xrf_rd2_status;

input                           ace_interrupt;
output                          ace_sync_ack;
output                          ace_sync_ack_status;
input                           ace_sync_req;
input                    [31:0] ace_sync_type;

assign ace_sync_ack             = 1'b0;
assign ace_sync_ack_status      = 1'b0;

assign ace_cmd_ready		= 1'b0;

assign ace_error		= 1'b0;

assign ace_acr_dirty_set        = 1'b0;
assign ace_standby_ready	= 1'b1;

assign ace_xrf_rd1_valid	= 1'b0;
assign ace_xrf_rd1_index	= 5'b0;
assign ace_xrf_rd1_data		= {XLEN{1'b0}};
assign ace_xrf_rd1_status	= 1'b0;

assign ace_xrf_rd2_valid	= 1'b0;
assign ace_xrf_rd2_index	= 5'b0;
assign ace_xrf_rd2_data		= {XLEN{1'b0}};
assign ace_xrf_rd2_status	= 1'b0;


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
wire nds_unused_ace_cmd_valid = ace_cmd_valid;
wire [31:7] nds_unused_ace_cmd_inst = ace_cmd_inst;
wire [VALEN-1:0] nds_unused_ace_cmd_pc = ace_cmd_pc;
wire [XLEN-1:0] nds_unused_ace_cmd_rs1 = ace_cmd_rs1;
wire [XLEN-1:0] nds_unused_ace_cmd_rs2 = ace_cmd_rs2;
wire [XLEN-1:0] nds_unused_ace_cmd_rs3 = ace_cmd_rs3;
wire [XLEN-1:0] nds_unused_ace_cmd_rs4 = ace_cmd_rs4;
wire nds_unused_ace_xrf_rd1_ready = ace_xrf_rd1_ready;
wire nds_unused_ace_xrf_rd2_ready = ace_xrf_rd2_ready;
wire nds_unused_ace_interrupt = ace_interrupt;
wire nds_unused_ace_sync_req = ace_sync_req;
wire [31:0] nds_unused_ace_sync_type = ace_sync_type;
endmodule
