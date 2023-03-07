// Copyright (C) 2020, Andes Technology Corp. Confidential Proprietary
`timescale 1ps / 1ps
`include "config.inc"
`include "xmr.vh"

`ifndef NDS_IPIPE_TIMEOUT
	`define NDS_IPIPE_TIMEOUT 200000
`endif


module instn_simple_pipe_mon;
parameter XLEN		= `NDS_XLEN;
parameter PALEN		= `NDS_BIU_ADDR_WIDTH;
parameter VALEN		= `NDS_VALEN;
parameter EXTVALEN	= ((`NDS_MMU_SCHEME != "bare") && (XLEN > VALEN)) ? VALEN+1 : VALEN;

wire              [63:0] HART_ID		= `NDS_CORE.hart_id;
wire                     core_reset_n		= `NDS_IPIPE.core_reset_n;
wire                     core_clk		= `NDS_IPIPE.core_clk;
wire              [31:0] wb_i0_instr		= `NDS_IPIPE.wb_i0_instr;
wire              [31:0] wb_i1_instr		= `NDS_IPIPE.wb_i1_instr;
wire                     core_wfi_mode		= `NDS_IPIPE.core_wfi_mode;
wire         [XLEN-1:0]  wb_i0_pc;
wire         [XLEN-1:0]  wb_i1_pc;
wire                     i0_inst_retire;
wire                     i1_inst_retire;

assign i0_inst_retire = `NDS_CSR.ipipe_csr_inst_retire[0];
assign i1_inst_retire = `NDS_CSR.ipipe_csr_inst_retire[1];

kv_sign_ext #(.OW(XLEN), .IW(EXTVALEN)) u_wb_i0_pc_sext      (.out(wb_i0_pc),      .in(`NDS_IPIPE.wb_i0_pc));
kv_sign_ext #(.OW(XLEN), .IW(EXTVALEN)) u_wb_i1_pc_sext      (.out(wb_i1_pc),      .in(`NDS_IPIPE.wb_i1_pc));

always @(posedge core_clk) begin
	if (i0_inst_retire) begin
            $display("%0t:ipipe:%0d:@%h=%h",$time, HART_ID, wb_i0_pc, wb_i0_instr);
        end
	if (i1_inst_retire) begin
            $display("%0t:ipipe:%0d:@%h=%h",$time, HART_ID, wb_i1_pc, wb_i1_instr);
        end
end


integer instn_count; initial instn_count = 0;
integer cpu_cycles;  initial cpu_cycles  = 0;
integer idle_counter;
integer pc_counter;

always @(posedge core_clk) begin
	cpu_cycles <= cpu_cycles + 1;
end

always @(posedge core_clk or negedge core_reset_n) begin
	if (~core_reset_n) begin
                idle_counter <= 0;
	end
        else if (i0_inst_retire) begin
		instn_count  <= instn_count + 1;
                idle_counter <= 0;
        end
        else begin
                if (!core_wfi_mode) begin
			idle_counter <= idle_counter + 1;
		end
                if (idle_counter >= `NDS_IPIPE_TIMEOUT) begin
                        $display("%0t:ipipe:%0d:ERROR:%0d cpu cycles passed without instruction retirement", $time, HART_ID, idle_counter);
                        wrapup();
                end
        end
end

`ifdef NDS_V5MP_TEST
	`ifndef NDS_ACTIVE_NHART
        	`define NDS_ACTIVE_NHART `NDS_NHART
	`endif
`else
        `define NDS_ACTIVE_NHART 1
`endif

integer finish_counter = 0;

always @(`NDS_SIM_CONTROL.event_finish) begin
	finish_counter ++;
	if (finish_counter == `NDS_ACTIVE_NHART) begin
		$display("%0t:simple_ipipe:%0d:---- simulated in %0d cpu cycles", $time, HART_ID, instn_simple_pipe_mon.cpu_cycles);
	end
end

event end_of_simulation;

task wrapup;
        ->end_of_simulation;
        #10 $finish;
endtask

endmodule

