// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale	1ns/1ps
module ext_debugger (
		  X_tckc,
		  X_tmsc,
		  X_trst,
		  X_tck,
		  X_tms,
		  X_tdi,
		  X_tdo,
		  X_srst
);
parameter  DEBUG_INTERFACE = "jtag";
parameter  MAX_SCAN_LEN  = 256;
parameter  MAX_IR_LEN = 5;
parameter  MAX_DR_LEN = 64;
parameter  UNLOCK_CODE_LEN = 128;

parameter  TEST_MEM_BASE = 64'h0040_0000;

inout           X_tckc;
inout           X_tmsc;
inout		X_trst;
inout		X_tck;
inout		X_tms;
inout		X_tdi;
inout		X_tdo;

inout		X_srst;

reg dispmon_CLOCK_GEN_0;
reg dispmon_JDTM_0;
reg dispmon_JDTM_9;
reg dispmon_JTAG_0;
initial begin
	dispmon_CLOCK_GEN_0 = 1'b1;
	dispmon_JDTM_0 = 1'b1;
	dispmon_JDTM_9 = 1'b1;
	dispmon_JTAG_0 = 1'b1;

	if ($test$plusargs("mon+CLOCK_GEN+0+off")) dispmon_CLOCK_GEN_0 = 1'b0;
	if ($test$plusargs("mon+JDTM+0+off")) dispmon_JDTM_0 = 1'b0;
	if ($test$plusargs("mon+JDTM+9+off")) dispmon_JDTM_9 = 1'b0;
	if ($test$plusargs("mon+JTAG+0+off")) dispmon_JTAG_0 = 1'b0;
end

localparam DR_LEN_IDCODE = 32;

localparam MAX_CHAIN_LEN = MAX_SCAN_LEN/MAX_IR_LEN;

localparam TAP_RESET     = 4'b0000;
localparam RUN_TEST_IDLE = 4'b1000;
localparam SEL_DR        = 4'b1001;
localparam CAPTURE_DR    = 4'b1010;
localparam SHIFT_DR      = 4'b1011;
localparam EXIT1_DR      = 4'b1100;
localparam PAUSE_DR      = 4'b1101;
localparam EXIT2_DR      = 4'b1110;
localparam UPDATE_DR     = 4'b1111;
localparam SEL_IR        = 4'b0001;
localparam CAPTURE_IR    = 4'b0010;
localparam SHIFT_IR      = 4'b0011;
localparam EXIT1_IR      = 4'b0100;
localparam PAUSE_IR      = 4'b0101;
localparam EXIT2_IR      = 4'b0110;
localparam UPDATE_IR     = 4'b0111;

localparam IR_BYPASS     = 5'b11111;
localparam IR_IDCODE     = 5'b00001;
localparam IR_DTMCONTROL = 5'b10000;
localparam IR_DMIACCESS  = 5'b10001;

localparam DBUS_DMCONTROL = 5'h10;
localparam DBUS_DMINFO    = 5'h11;
localparam DBUS_NOP       = 2'b00;
localparam DBUS_READ      = 2'b01;
localparam DBUS_WRITE     = 2'b10;

reg		trst_out_en;
reg		tck_out_en;
reg		tms_out_en;
reg		tdi_out_en;
reg		tdo_out_en;
reg		trst_out;
wire		tck_out;
reg		tms_out;
reg		tdi_out;
reg		tdo_out;
reg		tck_gen;

wire            tmsc_out_en;
wire            tmsc_out;
wire            tmsc_in;
wire		tdo_in;
reg		tdo_in_en;
reg		attached;
reg		during_unlock;


wire		tap_ctr_en;
reg       [3:0] tap_ctr_cs;
reg       [3:0] tap_ctr_ns;

reg       [4:0] ir_reg;

integer	tck_half_period		= 50;
reg      [31:0] idle_cycle	= 1000;
reg      [31:0] idle_cycle_step = 1;

assign	X_tckc 	= tck_out_en  ? tck_out  : 1'bz;
assign	X_tmsc 	= tmsc_out_en ? tmsc_out : 1'bz;
assign	tmsc_in	= X_tmsc;
assign	tdo_in	= (tdo_in_en)? tmsc_in : 1'bz;
assign	tmsc_out_en	= tms_out_en | tdi_out_en;
assign	tmsc_out 	= (tms_out_en)? tms_out :
			  (tdi_out_en)? tdi_out :
			                1'bz    ;
assign X_trst  	= trst_out_en ? trst_out : 1'bz;
assign X_tck   	= tck_out_en  ? tck_out  : 1'bz;
assign X_tms   	= tms_out_en  ? tms_out  : 1'bz;
assign X_tdi   	= tdi_out_en  ? tdi_out  : 1'bz;
assign X_tdo   	= tdo_out_en  ? tdo_out  : 1'bz;

assign	tck_out	= tck_gen;

initial begin
	trst_out_en = 1'b0;
	tck_out_en  = 1'b0;
	tms_out_en  = 1'b0;
	tdi_out_en  = 1'b0;
	tdo_out_en  = 1'b0;

	tdo_out = 1'bx;
	tdo_in_en = 1'bx;

	ir_reg	= IR_IDCODE;

	during_unlock = 1'b0;
end

initial begin
	tck_gen	= 1'b0;
	forever	#(tck_half_period)	tck_gen	= ~tck_gen;
end

task	tck_disable;
begin
	@(posedge tck_out);
	force	tck_out	= 1'b1;

	if (dispmon_CLOCK_GEN_0) $display("%0t:CLOCK_GEN:Disable JTAG tck", $realtime);
end
endtask

task	tck_enable;
begin
	wait(tck_gen);
	release	tck_out;

	if (dispmon_CLOCK_GEN_0) $display("%0t:CLOCK_GEN:Enable JTAG tck", $realtime);
end
endtask

always @(posedge tck_out or negedge trst_out) begin
	if (!trst_out)
		tap_ctr_cs <= TAP_RESET;
	else if (tap_ctr_en)
		tap_ctr_cs <= tap_ctr_ns;
end

always @* begin
	case (tap_ctr_cs)
	TAP_RESET:     tap_ctr_ns = tms_out ? TAP_RESET : RUN_TEST_IDLE;
	RUN_TEST_IDLE: tap_ctr_ns = tms_out ? SEL_DR    : RUN_TEST_IDLE;
	SEL_DR:        tap_ctr_ns = tms_out ? SEL_IR    : CAPTURE_DR;
	CAPTURE_DR:    tap_ctr_ns = tms_out ? EXIT1_DR  : SHIFT_DR;
	SHIFT_DR:      tap_ctr_ns = tms_out ? EXIT1_DR  : SHIFT_DR;
	EXIT1_DR:      tap_ctr_ns = tms_out ? UPDATE_DR : PAUSE_DR;
	PAUSE_DR:      tap_ctr_ns = tms_out ? EXIT2_DR  : PAUSE_DR;
	EXIT2_DR:      tap_ctr_ns = tms_out ? UPDATE_DR : SHIFT_DR;
	UPDATE_DR:     tap_ctr_ns = tms_out ? SEL_DR    : RUN_TEST_IDLE;

	SEL_IR:        tap_ctr_ns = tms_out ? TAP_RESET : CAPTURE_IR;
	CAPTURE_IR:    tap_ctr_ns = tms_out ? EXIT1_IR  : SHIFT_IR;
	SHIFT_IR:      tap_ctr_ns = tms_out ? EXIT1_IR  : SHIFT_IR;
	EXIT1_IR:      tap_ctr_ns = tms_out ? UPDATE_IR : PAUSE_IR;
	PAUSE_IR:      tap_ctr_ns = tms_out ? EXIT2_IR  : PAUSE_IR;
	EXIT2_IR:      tap_ctr_ns = tms_out ? UPDATE_IR : SHIFT_IR;
	UPDATE_IR:     tap_ctr_ns = tms_out ? SEL_DR    : RUN_TEST_IDLE;
	default:       tap_ctr_ns = 4'bx;
	endcase
end

generate
if (DEBUG_INTERFACE == "serial") begin : tap_ctr_serial
reg [2:0]	scan_phase;
reg [3:0]       tap_ctr_cs_negedge;
always @(negedge tck_out) begin
	tap_ctr_cs_negedge	<= tap_ctr_cs;
	case (tap_ctr_cs)
		SHIFT_IR, SHIFT_DR:
			scan_phase	<= {scan_phase[1:0], scan_phase[2]};
		default:
			scan_phase	<= 3'b100;
	endcase
end

always @* begin
	case (tap_ctr_cs_negedge)
		SHIFT_IR, SHIFT_DR:
			{tdo_in_en, tms_out_en, tdi_out_en}	= (attached)? scan_phase[2:0] : 3'b000;
		default:
			{tdo_in_en, tms_out_en, tdi_out_en}	= (attached)? 3'b010 : 3'b000;
	endcase
end
assign	tap_ctr_en	= during_unlock ? 1'b0 :
                          ((tap_ctr_cs_negedge == SHIFT_IR) || (tap_ctr_cs_negedge == SHIFT_DR)) ? scan_phase[2] : 1'b1;
end
else begin : tag_ctr_jtag
assign	tap_ctr_en	= 1'b1;
end
endgenerate

task da_attach_target_connector;
begin
	tck_out_en  = 1'b1;
	if (DEBUG_INTERFACE == "serial") begin
		attached    = 1'b1;
	end
	else begin
		trst_out_en = 1'b1;
		tms_out_en  = 1'b1;
		tdi_out_en  = 1'b1;
		tdo_out_en  = 1'b0;
	end
	tap_ctr_cs  = TAP_RESET;
end
endtask

task da_set_tck_khz;
input integer  freq_khz;
begin
	tck_half_period = 500000 / freq_khz;
end
endtask

task da_set_idle_cycle;
input reg [31:0] cycle;
begin
        idle_cycle = cycle;
end
endtask

task da_set_idle_cycle_step;
input reg [31:0] cycle_step;
begin
        idle_cycle_step = cycle_step;
end
endtask

task da_unlock;
input reg [UNLOCK_CODE_LEN-1:0] unlock_code;
integer i, j;
begin
	$display("%0t:ext_debugger: starting to unlock ncedbglock100...", $realtime);
	@(negedge tck_out);
        during_unlock <= 1'b1;
	for (j=0; j<9; j=j+1) begin
		@(negedge tck_out);
		tms_out <= 1'b1;
	end
	for (i=0; i<UNLOCK_CODE_LEN/8; i=i+1) begin
	        for (j=0; j<8; j=j+1) begin
	        	@(negedge tck_out);
	        	tms_out <= unlock_code[i*8 + 7 - j];
	        end
		@(negedge tck_out);
		tms_out <= 1'b0;
	end
	for (j=0; j<9; j=j+1) begin
		@(negedge tck_out);
		tms_out <= 1'b1;
	end
	@(negedge tck_out);
        during_unlock <= 1'b0;
end
endtask

task goto_state;
input	[3:0]	state;
begin
	while (tap_ctr_cs != state) begin : goto_state_block
		@(negedge tck_out);
		case (tap_ctr_cs)
		TAP_RESET: begin
			 tms_out <= 1'b0;
		end
		RUN_TEST_IDLE: begin
			tms_out <= 1'b1;
		end
		SEL_DR: begin
			tms_out <= (state == SEL_IR)
			         | (state == CAPTURE_IR)
			         | (state == SHIFT_IR)
			         | (state == EXIT1_IR)
			         | (state == PAUSE_IR)
			         | (state == EXIT2_IR)
			         | (state == UPDATE_IR)
			         | (state == TAP_RESET)
			         | (state == RUN_TEST_IDLE);
		end
		CAPTURE_DR: begin
			tms_out <= (state != SHIFT_DR);
		end
		SHIFT_DR: begin
			tms_out <= 1'b1;
		end
		EXIT1_DR: begin
			tms_out <= (state != PAUSE_DR) &
			           (state != EXIT2_DR) &
				   (state != SHIFT_DR);
		end
		PAUSE_DR: begin
			tms_out <= 1'b1;
		end
		EXIT2_DR: begin
			tms_out <= (state != SHIFT_DR) &
			           (state != EXIT1_DR) &
				   (state != PAUSE_DR);
		end
		UPDATE_DR: begin
			tms_out <= (state != RUN_TEST_IDLE);
		end
		SEL_IR: begin
			tms_out <= (state == SEL_DR)
			         | (state == CAPTURE_DR)
			         | (state == SHIFT_DR)
			         | (state == EXIT1_DR)
			         | (state == PAUSE_DR)
			         | (state == EXIT2_DR)
			         | (state == UPDATE_DR)
			         | (state == TAP_RESET)
			         | (state == RUN_TEST_IDLE);
		end
		CAPTURE_IR: begin
			tms_out <= (state != SHIFT_IR);
		end
		SHIFT_IR: begin
			tms_out <= 1'b1;
		end
		EXIT1_IR: begin
			tms_out <= (state != PAUSE_IR) &
			           (state != EXIT2_IR) &
				   (state != SHIFT_IR);
		end
		PAUSE_IR: begin
			tms_out <= 1'b1;
		end
		EXIT2_IR: begin
			tms_out <= (state != SHIFT_IR) &
			           (state != EXIT1_IR) &
				   (state != PAUSE_IR);
		end
		UPDATE_IR: begin
			tms_out <= (state != RUN_TEST_IDLE);
		end
		endcase

		@(posedge tck_out);
		tap_ctr_cs	= (tap_ctr_en)? tap_ctr_ns : tap_ctr_cs;
	end
end
endtask

task da_detatch_target_connector;
begin
	tck_out_en  = 1'b0;
	if (DEBUG_INTERFACE == "serial") begin
		attached    = 1'b0;
	end
	else begin
		trst_out_en = 1'b0;
		tms_out_en  = 1'b0;
		tdi_out_en  = 1'b0;
		tdo_out_en  = 1'b0;
	end
end
endtask

task da_do_trst;
begin
	trst_out = 1'b0;
	tms_out = 1'b1;
	#1000;
	@(negedge tck_out);
	trst_out <= 1'b1;
	repeat (200) @(posedge tck_out);
	@(negedge tck_out);
	tms_out  <= 1'b0;
	repeat (10) @(negedge tck_out);
end
endtask

task da_shift;
input             integer len;
input  [MAX_SCAN_LEN-1:0] scan_data_in;
output [MAX_SCAN_LEN-1:0] scan_data_out;
integer                   i;
begin
	if (DEBUG_INTERFACE == "serial") begin
		for (i=0; i<len; i=i+1) begin
			@(negedge tck_out);
			tdi_out <= scan_data_in[i];
			tms_out <= (i==(len-1));
			@(negedge tck_out);
			@(negedge tck_out);
			@(posedge tck_out);
			scan_data_out[i] = tdo_in;
		end
	end
	else begin
		for (i=0; i<len; i=i+1) begin
			@(negedge tck_out);
			tdi_out <= scan_data_in[i];
			tms_out <= (i==(len-1));
			@(posedge tck_out);
			scan_data_out[i] = X_tdo;
		end
	end
end
endtask

task scan_dr;
input             integer len;
input  [MAX_SCAN_LEN-1:0] scan_data_in;
output [MAX_SCAN_LEN-1:0] scan_data_out;
begin
	goto_state(SHIFT_DR);
	da_shift(len, scan_data_in, scan_data_out);
	goto_state(RUN_TEST_IDLE);
end
endtask

task scan_ir;
input             integer len;
input  [MAX_SCAN_LEN-1:0] scan_data_in;
output [MAX_SCAN_LEN-1:0] scan_data_out;
begin
	goto_state(SHIFT_IR);
	da_shift(len, scan_data_in, scan_data_out);
	goto_state(RUN_TEST_IDLE);
	ir_reg	= {scan_data_in, ir_reg[4:0]} >> len;
end
endtask

task scan_reset;
begin
        da_do_trst;
end
endtask

task jtag_delay;
input [31:0]	ncycle;
begin
	goto_state(RUN_TEST_IDLE);
	repeat(ncycle)
		@(posedge tck_out);
end
endtask

`ifdef NDS_EXT_DEBUGGER_SEQ
`include "ext_debugger_seq.v"
`endif

`ifdef _PLDM_DEFINE_VH_
`undef _PLDM_DEFINE_VH_
`endif

`ifdef _REG_MAP_VH_
`undef _REG_MAP_VH_
`endif

endmodule

