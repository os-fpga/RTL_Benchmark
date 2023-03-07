// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



`timescale 1ns/1ps

module i2c_slave_model (
	  scl,
	  sda,
	  smbsus,
	  smbalert,
	  resetn
);

parameter DEVICE_ADDR = 7'h50;
parameter DEVICE_10B_ADDR = 10'h1a7;
parameter ADDR_WIDTH = 15;

parameter OUT_DELAY = 1.0;

parameter ST_IDLE = 3'h0;
parameter ST_START = 3'h1;
parameter ST_GC = 3'h2;
parameter ST_ADDR1 = 3'h3;
parameter ST_ADDR2 = 3'h4;
parameter ST_WRITE = 3'h5;
parameter ST_READ = 3'h6;
parameter ST_10B_ADDR = 3'h7;

parameter GC_ADDR= 8'h0;
parameter SB_ADDR= 8'h1;
parameter AL_ADDR= 8'h19;

parameter ERR_DEV_ADDR1 = 7'h52;
parameter ERR_DEV_ADDR2 = 7'h54;
parameter ERR_ADDR2 	= 8'hcc;

input		scl;
inout		sda;
input		smbsus;
inout		smbalert;
input		resetn;

reg [31:0]	nds_unused_r32;

wire		sda_out;
reg		smbalert_out;
reg		acked, assert_ack;
reg		gc_acked;
reg		frame_start;
reg		frame_stop;
reg [7:0]	sr_in;
reg [7:0]	sr_out;

wire		pos_ack;
wire		pos_8b;
wire		pos_7b;
wire		cnt4_rst;
reg [3:0]	bit_cnt4;

reg [1:0]	addressing;
reg [6:0]	req_id;
reg [9:0]	req_id_10b;
reg		req_rw;
reg [15:0]	req_addr;

wire		alert_resp_flag_set;
wire		alert_resp_flag_clr;
reg		alert_resp_flag;

reg [2:0]	frame_cs;

reg [7:0]	mem [0:(1 << ADDR_WIDTH) - 1];

integer		debug_flag;
reg [31:0]	seed;


initial begin
	debug_flag = $test$plusargs("nds_debug_i2c");
end

`include "sync_tasks.vh"

initial begin
	if ($value$plusargs("seed=%d", seed))
		seed = seed ^ 32'h162b3d13 ^ MODEL_ID;
	else
		seed = 32'h162b3d13 ^ MODEL_ID;
end

always @(negedge resetn or sda)
	if (~resetn) begin
		frame_start <= 1'b0;
		frame_stop <= 1'b1;
	end
	else if (scl) begin
		frame_start <= ~sda;
		frame_stop <= sda;
	end

always @(posedge scl)
	frame_start <= 1'b0;


always @(negedge resetn or posedge scl)
	if (~resetn)
		sr_in <= 8'h0;
	else
		sr_in <= {sr_in[6:0], sda};


assign pos_ack = (bit_cnt4 == 4'h8);
assign pos_8b = (bit_cnt4 == 4'h7);
assign pos_7b = (bit_cnt4 == 4'h6);
assign cnt4_rst = frame_start || pos_ack;

always @(negedge resetn or posedge scl)
	if (~resetn)
		bit_cnt4 <= 4'h0;
	else if (cnt4_rst)
		bit_cnt4 <= 4'h0;
	else if (~frame_stop)
		bit_cnt4 <= bit_cnt4 + 4'h1;


always @(negedge resetn or posedge scl or posedge frame_start or posedge frame_stop)
	if (~resetn)
		frame_cs <= ST_IDLE;
	else begin
		case (frame_cs)
		ST_START:
			if (pos_8b) begin
				if (addressing[0]) begin
					if (~req_rw)
						frame_cs <= ST_10B_ADDR;
					else if ( (req_id_10b == DEVICE_10B_ADDR) & addressing[1])
						frame_cs <= ST_READ;
					else
						frame_cs <= ST_IDLE;
				end
				else if (req_id == DEVICE_ADDR || req_id == ERR_DEV_ADDR2) begin
					if (req_rw)
						frame_cs <= ST_READ;
					else
						frame_cs <= ST_ADDR1;
				end
				else if ({req_id, req_rw} == GC_ADDR) begin
					frame_cs <= ST_GC;
				end
				else if (alert_resp_flag_set) begin
					frame_cs <= ST_READ;
				end
				else begin
					frame_cs <= ST_IDLE;
				end
			end

		ST_GC:
			if (frame_stop || ~gc_acked)
				frame_cs <= ST_IDLE;

		ST_READ:
			if (pos_8b && sda)
				frame_cs <= ST_IDLE;

		ST_ADDR1:
			if (frame_start)
				frame_cs <= ST_START;
			else if (pos_8b) begin
				if (~|sr_in[7:(ADDR_WIDTH - 8)])
					frame_cs <= ST_ADDR2;
				else
					frame_cs <= ST_IDLE;
			end

		ST_ADDR2:
			if (pos_8b)
				frame_cs <= ST_WRITE;

		ST_WRITE:
			if (frame_start)
				frame_cs <= ST_START;
			else if (frame_stop)
				frame_cs <= ST_IDLE;

		ST_10B_ADDR:
			if (pos_8b) begin
				if (req_id_10b == DEVICE_10B_ADDR) begin
					frame_cs <= ST_ADDR1;
				end
				else begin
					frame_cs <= ST_IDLE;
				end
			end

		default:
			if (frame_start)
				frame_cs <= ST_START;

		endcase
	end


always @(posedge scl)
	if ((frame_cs == ST_START) && pos_7b)  begin
		req_id <= sr_in[6:0];
		req_rw <= sda;
	end

always @(negedge resetn or scl)
	if (~resetn)  begin
		addressing <= 2'h0;
	end else if ((frame_cs == ST_START) && pos_7b) begin
		addressing[0] <= sr_in[6:2] == 5'h1e;
		addressing[1] <= addressing[1];
	end else if ((frame_cs == ST_10B_ADDR) && pos_8b) begin
		addressing[0] <= addressing[0];
		addressing[1] <= (req_id_10b == DEVICE_10B_ADDR);
	end else if (((frame_cs == ST_ADDR1)|(frame_cs == ST_READ)) && pos_8b) begin
		addressing <= 2'h0;
	end

always @(posedge scl)
	if ((frame_cs == ST_START) && pos_7b)  begin
		req_id_10b[9:8] <= sr_in[1:0];
		req_id_10b[7:0] <= req_id_10b[7:0];
	end
	else if ((frame_cs == ST_10B_ADDR) && pos_7b)  begin
		req_id_10b[9:8] <= req_id_10b[9:8];
		req_id_10b[7:0] <= {sr_in[6:0], sda};
	end


always @(posedge scl)
	if (pos_8b) begin
		case (frame_cs)
		ST_ADDR1:
			req_addr[15:8] <= sr_in;

		ST_ADDR2:
			req_addr[7:0] <= sr_in;

		ST_WRITE:
			req_addr <= req_addr + 16'h1;

		ST_READ:
			req_addr <= req_addr + 16'h1;

		endcase
	end


always @(posedge scl)
	if ((frame_cs == ST_WRITE) && pos_8b)
		mem[req_addr[ADDR_WIDTH-1:0]] <= sr_in;


always @(negedge resetn or negedge scl)
	if (~resetn)
		sr_out <= 8'hff;
	else if (frame_cs == ST_READ) begin
		if (pos_ack)
			if (alert_resp_flag)
				sr_out <= {DEVICE_ADDR, 1'b0};
			else
				sr_out <= mem[req_addr[ADDR_WIDTH-1:0]];
		else
			sr_out <= {sr_out[6:0], 1'b1};
	end


always @(frame_cs or sr_in or req_id or req_rw or gc_acked or alert_resp_flag_set) begin
`ifndef  NDS_I2C_NACK_TEST
	if ((frame_cs == ST_ADDR1) && (~|sr_in[7:(ADDR_WIDTH - 8)]))
		assert_ack = 1'b1;
	else if ((frame_cs == ST_ADDR2) || (frame_cs == ST_WRITE))
		assert_ack = 1'b1;
	else if ((frame_cs == ST_START) && ((req_id == DEVICE_ADDR)|addressing[0]))
		assert_ack = 1'b1;
	else if ((frame_cs == ST_10B_ADDR) && (req_id_10b == DEVICE_10B_ADDR))
		assert_ack = 1'b1;
	else if (alert_resp_flag_set)
		assert_ack = 1'b1;
	else if ((frame_cs == ST_GC) || ((frame_cs == ST_START) && ({req_id, req_rw} == GC_ADDR)))
		assert_ack = gc_acked;
	else
		assert_ack = 1'b0;
`else
	if ((frame_cs == ST_ADDR1) && (~|sr_in[7:(ADDR_WIDTH - 8)]))
		assert_ack = 1'b1;
	else if ((frame_cs == ST_ADDR2) && (sr_in != ERR_ADDR2))
		assert_ack = 1'b1;
	else if (frame_cs == ST_WRITE)
		assert_ack = 1'b1;
	else if ((frame_cs == ST_START) && ((req_id == DEVICE_ADDR)|addressing[0]))
		assert_ack = 1'b1;
	else if ((frame_cs == ST_10B_ADDR) && (req_id_10b == DEVICE_10B_ADDR))
		assert_ack = 1'b1;
	else if ((frame_cs == ST_START) && (req_id == ERR_DEV_ADDR2) && (req_rw == 1'b0))
		assert_ack = 1'b1;
	else if (alert_resp_flag_set)
		assert_ack = 1'b1;
	else if ((frame_cs == ST_GC) || ((frame_cs == ST_START) && ({req_id, req_rw} == GC_ADDR)))
		assert_ack = gc_acked;
	else
		assert_ack = 1'b0;
`endif
end

always@(frame_cs) begin
	$display("[I2C Slave]: CS = %h", frame_cs);
end

always @(negedge resetn or posedge scl) begin
	if (~resetn) begin
		gc_acked <= 1'b0;
	end
	else if ((frame_cs == ST_START) && pos_7b && ({sr_in[6:0], sda} == GC_ADDR)) begin
		nds_unused_r32 = {$random(seed)};
		gc_acked <= nds_unused_r32[0];
	end
end

always @(negedge resetn or negedge scl)
	if (~resetn)
		acked <= 1'b0;
	else if (pos_8b)
		acked <= assert_ack;
	else
		acked <= 1'b0;

always @(negedge resetn or posedge scl) begin
	if (~resetn) begin
		smbalert_out <= 1'b1;
	end
	else if (alert_resp_flag_clr) begin
		smbalert_out <= 1'b1;
	end
end

assign alert_resp_flag_set = (smbalert_out == 1'b0) && (frame_cs == ST_START) && ({req_id, req_rw} == AL_ADDR);
assign alert_resp_flag_clr = alert_resp_flag && (frame_cs == ST_READ) && (pos_8b && sda);

always @(negedge resetn or posedge scl) begin
	if (~resetn) begin
		alert_resp_flag <= 1'b0;
	end
	else if (alert_resp_flag_set) begin
		alert_resp_flag <= 1'b1;
	end
	else if (alert_resp_flag_clr) begin
		alert_resp_flag <= 1'b0;
	end
end

assign sda_out = ((frame_cs == ST_READ) ? sr_out[7] : 1'b1) && ~acked;
assign #(OUT_DELAY) sda = sda_out ? 1'bz : 1'b0;
assign #(OUT_DELAY) smbalert = smbalert_out ? 1'bz : 1'b0;


always @(posedge scl)
	if (debug_flag && pos_8b) begin
		case (frame_cs)
		ST_WRITE:
			$display("%t:%m:Write 0x%h to addr=0x%h", $time, sr_in, req_addr[ADDR_WIDTH-1:0]);
		ST_READ:
			$display("%t:%m:Read 0x%h from addr=0x%h", $time, sr_in, req_addr[ADDR_WIDTH-1:0]);
		endcase
	end

endmodule
