// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "pldm_define.vh"

integer ir_nbits_pretarget;
integer ir_nbits_posttarget;
integer dr_nbits_pretarget;
integer dr_nbits_posttarget;
integer ir_nbits_target;

integer                 tap_chain_len;
integer                 tap_select;
integer                 ir_len_list [0:MAX_CHAIN_LEN-1];
reg [MAX_IR_LEN-1:0]    tap_ir_list [0:MAX_CHAIN_LEN-1];

task jtag_detect_chain_length;
reg    [MAX_CHAIN_LEN*MAX_IR_LEN-1:0]       ir_data;
reg    [MAX_CHAIN_LEN:0]                dr_data;
begin
        tap_chain_len = -1;
        ir_data = {MAX_CHAIN_LEN{IR_BYPASS}};
        dr_data = {{(MAX_CHAIN_LEN){1'b0}}, 1'b1};
        scan_ir(MAX_CHAIN_LEN*MAX_IR_LEN, ir_data, ir_data);
        scan_dr(MAX_CHAIN_LEN+1, dr_data, dr_data);

        while (dr_data != {MAX_CHAIN_LEN{1'b0}}) begin
                tap_chain_len = tap_chain_len + 1;
                dr_data = dr_data >> 1;
        end

        if (tap_chain_len < 1) begin
		if (dispmon_JTAG_0) $display("%0t:JTAG:No TAP detected on JTAG chain", $realtime);
        end else begin
		if (dispmon_JTAG_0) $display("%0t:JTAG:Total %0d TAP on JTAG chain", $realtime, tap_chain_len);
        end
end
endtask

task jtag_detect_chain_info;
reg     [(MAX_CHAIN_LEN*DR_LEN_IDCODE)-1:0]  dr_data;
integer         tap_id;
integer         ir_len;
reg     [DR_LEN_IDCODE-1:0]     idcode;
reg     [3:0]                   version;
reg     [15:0]                  part_number;
reg     [10:0]                  manuf_id;
reg                             is_idcode;
begin
        scan_reset;
        scan_dr(tap_chain_len*DR_LEN_IDCODE, {(MAX_CHAIN_LEN*DR_LEN_IDCODE){1'b0}}, dr_data);
        for(tap_id = 0; tap_id < tap_chain_len; tap_id = tap_id + 1) begin
                idcode = dr_data[DR_LEN_IDCODE-1:0];
                {version, part_number, manuf_id, is_idcode} = idcode;

                casez ({is_idcode, manuf_id, part_number})
                        {1'b1, 11'h31e, 16'h0005}: begin
                                ir_len = 5;
                                if (dispmon_JTAG_0) $display("%0t:JTAG:Detect TAP#%0d, IDCODE=0x%08x: Andes V5 JDTM (IR LEN = %0d)", $realtime, tap_id, idcode, ir_len);
                        end
                        {1'b1, 11'h31e, 16'h0000}: begin
                                ir_len = 4;
                                if (dispmon_JTAG_0) $display("%0t:JTAG:Detect TAP#%0d, IDCODE=0x%08x: Andes V3 EDM (IR LEN = %0d)", $realtime, tap_id, idcode, ir_len);
                        end
                        default: begin
                                ir_len = 5;
                                if (dispmon_JTAG_0) $display("%0t:JTAG:Detect TAP#%0d, IDCODE=0x%08x: Unknown TAP (use default IR LEN = %0d)", $realtime, tap_id, idcode, ir_len);
                        end
                endcase
                ir_len_list[tap_id] = ir_len;

                dr_data = dr_data >> DR_LEN_IDCODE;
        end
        for(tap_id = tap_chain_len; tap_id < MAX_CHAIN_LEN; tap_id = tap_id + 1) begin
                ir_len_list[tap_id] = 0;
        end
end
endtask

task jtag_select_tap;
input   tap_id;
integer tap_id;
integer it;
begin
	if (dispmon_JTAG_0) $display("%0t:JDTM:Select jtag tap %0d", $realtime, tap_id);
        tap_select = tap_id;
        ir_nbits_target         = ir_len_list[tap_id];
        ir_nbits_pretarget      = 0;
        ir_nbits_posttarget     = 0;
        dr_nbits_pretarget      = tap_id;
        dr_nbits_posttarget     = tap_chain_len - tap_id - 1;
        for (it = 0; it < tap_id; it = it + 1) begin
                ir_nbits_pretarget = ir_nbits_pretarget + ir_len_list[it];
        end
        for (it = tap_id + 1; it < tap_chain_len; it = it + 1) begin
                ir_nbits_posttarget = ir_nbits_posttarget + ir_len_list[it];
        end
        if (dispmon_JTAG_0) begin
                $display("%0t:JTAG:Select TAP#%0d (total %0d TAPs on chain)", $realtime, tap_select, tap_chain_len);
	        $display("%0t:JTAG:\tIR: target bit: %1d, pre target bit: %0d, post target bit: %0d", $realtime, ir_nbits_target, ir_nbits_pretarget, ir_nbits_posttarget);
	        $display("%0t:JTAG:\tDR:                pre target bit: %0d, post target bit: %0d", $realtime, dr_nbits_pretarget, dr_nbits_posttarget);
        end
end
endtask

task check_dmi_state;
output	[1:0]	state;
reg	[31:0]	scan_din;
reg	[31:0]	scan_dout;
begin
	access_dtmcontrol(scan_din, scan_dout);
	state	= scan_dout[11:10];

	if (state == 2'b11) begin
		idle_cycle	= idle_cycle + idle_cycle_step;
		if (dispmon_JDTM_0) $display("%0t:JDTM:DMI is busy (dtmcontrol=%2b, idle_cycle=%0d->%0d)", $realtime, state, idle_cycle-idle_cycle_step, idle_cycle);
	end
	else if (state != 2'b00) begin
		if (dispmon_JDTM_0) $display("%0t:JDTM:DMI state is unexpected (dtmcontrol=%2b)", $realtime, state);
	end
end
endtask

task access_dtmcontrol;
input              [31:0] wdtmcontrol;
output             [31:0] rdtmcontrol;
reg    [MAX_SCAN_LEN-1:0] ir_out;
reg    [MAX_SCAN_LEN-1:0] dr_out;
reg    [MAX_SCAN_LEN-1:0] ir_data;
reg    [MAX_SCAN_LEN-1:0] dr_data;
begin
        scan_ir(_ir_chain_len(ir_nbits_target), _ir_chain(IR_DTMCONTROL), ir_out);
        scan_dr(_dr_chain_len(32), _dr_chain(wdtmcontrol), dr_out);
        rdtmcontrol = _extract_dr_from_chain(dr_out, 32);
end
endtask

task check_dtmcontrol;
reg  [31:0]	rdata;
reg  [1:0]	state;
reg  [31:0]	scan_out;
begin
	if (dispmon_JDTM_0) $display("%0t:JDTM:Check DTM control", $realtime);
	access_dtmcontrol(32'h0, rdata);
	if (dispmon_JDTM_0) $display("%0t:JDTM:check_dtmcontrol():dtmcontrol=0x%x", $realtime, rdata);

	if (dispmon_JDTM_0) $display("%0t:JDTM:set dmi wait cycle to %0d", $realtime, idle_cycle);

	if (rdata == 0)
		if (dispmon_JDTM_9) begin $display("%0t:JDTM:ERROR:dtmcontrol is 0. Check JTAG connectivity/board power.", $realtime); #1 $finish; end
	if (rdata[3:0] != 4'h1)
		if (dispmon_JDTM_9) begin $display("%0t:JDTM:ERROR:Unsupported DTM version %d. (dtmcontrol=0x%x)", $realtime, rdata[3:0], rdata); #1 $finish; end
end
endtask

task dmi_read;
input	[DMI_ABITS-1:0]		addr;
output	[31:0]			data_out;
reg	[1:0]			op;
reg     [DMI_ABITS+33:0]        dmi_cmd;
reg	[MAX_SCAN_LEN-1:0]	scan_dout;
reg	[MAX_SCAN_LEN-1:0]	scan_din;
begin
	op		= DMI_JTAG_READ;
	dmi_cmd         = {addr, 32'h00000000, op};

	if (ir_reg != IR_DMIACCESS)
                scan_ir(_ir_chain_len(ir_nbits_target), _ir_chain(IR_DMIACCESS), scan_dout);
        scan_dr(_dr_chain_len(DMI_ABITS+34), _dr_chain(dmi_cmd), scan_dout);
	jtag_delay(idle_cycle);
        scan_dr(_dr_chain_len(DMI_ABITS+34), _dr_chain({MAX_SCAN_LEN{1'b0}}), scan_dout);
        scan_dout = _extract_dr_from_chain(scan_dout, DMI_ABITS+34);
        data_out = scan_dout[33:2];
end
endtask

task dmi_write;
input	[DMI_ABITS-1:0]		addr;
input	[31:0]			data_in;
reg	[1:0]			op;
reg	[MAX_SCAN_LEN-1:0]	scan_dout;
reg	[MAX_SCAN_LEN-1:0]	scan_din;
begin
	op		= DMI_JTAG_WRITE;
	scan_din	= {addr, data_in, op};

	if (ir_reg != IR_DMIACCESS)
                scan_ir(_ir_chain_len(ir_nbits_target), _ir_chain(IR_DMIACCESS), scan_dout);
        scan_dr(_dr_chain_len(DMI_ABITS+34), _dr_chain(scan_din), scan_dout);
	jtag_delay(idle_cycle);
end
endtask

task dmi_reset;
reg	[31:0]	scan_din;
reg	[MAX_SCAN_LEN-1:0]	scan_dout;
begin
	scan_din	= 32'h00010000;

	if (ir_reg != IR_DTMCONTROL)
                scan_ir(_ir_chain_len(ir_nbits_target), _ir_chain(IR_DTMCONTROL), scan_dout);
        scan_dr(_dr_chain_len(32), _dr_chain(scan_din), scan_dout);
end
endtask

function integer _ir_chain_len;
input integer ir_len;
begin
        _ir_chain_len = ir_len + (ir_nbits_pretarget + ir_nbits_posttarget);
end
endfunction

function integer _dr_chain_len;
input integer dr_len;
begin
        _dr_chain_len = dr_len + (dr_nbits_pretarget + dr_nbits_posttarget);
end
endfunction

function [MAX_SCAN_LEN-1:0] _ir_chain;
input [MAX_IR_LEN-1:0] ir;
reg   [MAX_IR_LEN-1:0] ir_mask;
integer itap;
begin
        for (itap = tap_chain_len - 1; itap >= 0; itap = itap - 1) begin
                tap_ir_list[itap] = (itap == tap_select) ? ir : ~({MAX_IR_LEN{1'b1}} << ir_len_list[itap]);
        end

        _ir_chain = {MAX_IR_LEN{1'b0}};
        for (itap = tap_chain_len - 1; itap >= 0; itap = itap - 1) begin
                ir_mask   = ~({MAX_IR_LEN{1'b1}} << ir_len_list[itap]);
                _ir_chain = (_ir_chain << ir_len_list[itap])
                          | (tap_ir_list[itap] & ir_mask);
        end
end
endfunction

function [MAX_SCAN_LEN-1:0] _dr_chain;
input [MAX_DR_LEN-1:0] dr;
begin
        _dr_chain = dr << dr_nbits_pretarget;
end
endfunction

function [MAX_SCAN_LEN-1:0] _extract_dr_from_chain;
input [MAX_SCAN_LEN-1:0] dr_chain;
input [MAX_DR_LEN-1:0]   dr_len;
begin
        _extract_dr_from_chain = (dr_chain >> dr_nbits_pretarget) & (({{MAX_DR_LEN{1'b0}}, 1'b1} << dr_len) - 1);
end
endfunction

integer i;
initial begin
        tap_chain_len = 0;
        tap_select = 0;
        for(i = 0; i < MAX_CHAIN_LEN; i = i + 1) begin
                ir_len_list[i] = 0;
                tap_ir_list[i] = {MAX_IR_LEN{1'b1}};
        end
end
