// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "pldm_define.vh"
`include "reg_map.vh"

`ifdef NDS_JTAG_TCK_KHZ
localparam TCK_KHZ = `NDS_JTAG_TCK_KHZ;
localparam CHECK_BUSY_TYPE = (TCK_KHZ < 50000) ? MAYBE_CHECK_BUSY : FORCE_CHECK_BUSY;
`else
localparam TCK_KHZ = 100000;
localparam CHECK_BUSY_TYPE = FORCE_CHECK_BUSY;
`endif

parameter	MAXLEN		= 128;
parameter	BUFLEN		= 128*8;
parameter	MAX_RETRY	= 400;
parameter	MAX_HART	= 1024;
parameter	DBG_PASS	= 0;
parameter	DBG_FAIL	= 1;
parameter	DBG_SKIP        = 2;
parameter       CHECK_BUSY_DELAY_CYCLE = 7;

reg     check_busy_bus;
reg     check_busy_others;

integer	xlen;
integer flen;

integer fg_hart;

reg             bg_hart_sel;

reg [2:0]       _sb_version;

reg dispmon_DBG_API_0;
reg dispmon_DBG_API_9;
initial begin
	dispmon_DBG_API_0 = 1'b1;
	dispmon_DBG_API_9 = 1'b1;

	if ($test$plusargs("mon+DBG_API+0+off")) dispmon_DBG_API_0 = 1'b0;
	if ($test$plusargs("mon+DBG_API+9+off")) dispmon_DBG_API_9 = 1'b0;
end

localparam      NDMRESET_BIT = 1;

task init_target_regular;
input tck_khz;
input idle_cycle;
reg  [31:0]  tck_khz;
reg  [31:0]  idle_cycle;
reg  [31:0]  scan_out;
reg  [1:0]   state;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Initial target, tck:%dkhz, idle cyle:%d", $realtime, tck_khz, idle_cycle);
	#100;
	#100000;

	da_set_tck_khz(tck_khz);
        da_set_idle_cycle(idle_cycle);
	da_attach_target_connector;
	da_do_trst;
	#100;

        jtag_detect_chain_length;
        jtag_detect_chain_info;
        jtag_select_tap(0);
end
endtask

task init_target;
input tck_khz;
input idle_cycle;
reg  [31:0]  tck_khz;
reg  [31:0]  idle_cycle;
reg  [31:0]  scan_out;
reg  [1:0]   state;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Initial target, tck:%dkhz, idle cyle:%d", $realtime, tck_khz, idle_cycle);
	#100;
	#100000;

	da_set_tck_khz(tck_khz);
        da_set_idle_cycle(idle_cycle);
	da_attach_target_connector;
	`ifdef PLATFORM_NCEDBGLOCK100_PASSWD_MODE
		da_unlock(128'h52495343_2d564041_6e646573_54656368);
	`endif
	da_do_trst;
	#100;

        jtag_detect_chain_length;
        jtag_detect_chain_info;
        jtag_select_tap(0);
end
endtask

task deinit_target;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Deinit target", $realtime);
	#10000;
	da_detatch_target_connector;
	#100;
end
endtask

task check_dm_support;
output	  	program_size;
output	  	datareg_count;
output		autoexec_progbuf;
output		autoexec_datareg;
output		sysbus_access;
output		sysbus_version;
output		sysbus_addr_width;
output	  	sysbus_width;
output	  	serial_count;
output		hart_array;
output		impebreak;

reg	[4:0]	program_size;
reg	[4:0]	datareg_count;
reg	[15:0]	autoexec_progbuf;
reg	[11:0]	autoexec_datareg;
reg		sysbus_access;
reg     [2:0]   sysbus_version;
reg	[6:0]	sysbus_addr_width;
reg	[4:0]	sysbus_width;
reg	[3:0]	serial_count;
reg		hart_array;
reg	[31:0]	rdata;
reg	[31:0]	wdata;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Check DM support", $realtime);

	dmi_read (DMI_DMSTATUS, rdata);
	if (rdata[3:0] != 4'h2) begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR: DM is not conform to version 0.13 spec", $realtime); #1 $finish; end
	end
	impebreak		= rdata[22];

	dmi_read (DMI_DMCONTROL, rdata);
	dmi_write(DMI_DMCONTROL, rdata | 32'h04000000);
	dmi_read (DMI_DMCONTROL, rdata);
	hart_array		= rdata[26];
	dmi_write(DMI_DMCONTROL, rdata & 32'hfbffffff);

	dmi_read (DMI_HARTINFO, rdata);

	dmi_read (DMI_SBCS, rdata);
        sysbus_version          = rdata[31:29];
	sysbus_addr_width	= rdata[11:5];
	sysbus_width		= rdata[4:0];
	sysbus_access		= (sysbus_addr_width != 7'h0);
        _sb_version     = sysbus_version;

	dmi_read (DMI_ABSTRACTCS, rdata);
	program_size		= rdata[28:24];
	datareg_count		= rdata[4:0];

        set_absauto_exe(32'hffffffff);
	dmi_read (DMI_ABSTRACTAUTO, rdata);
        clr_absauto_exe;
	autoexec_progbuf	= rdata[31:16];
	autoexec_datareg	= rdata[11:00];

	dmi_read (DMI_SERCS, rdata);
	serial_count		= rdata[31:28];
end
endtask

task detect_xlen;
reg  [1:0]	state;
reg  [31:0]	wdata;
begin
	dbg_break;

	if (dispmon_DBG_API_0) $display("%0t:DBG_API:dbg_detect_xlen()", $realtime);

        wdata = _cmd(CMD_ACCESS_REG, CMD_SIZE_64, CMD_NOPOSTEXEC, CMD_ABSCMD, CMD_READ, 16'h1008);
	dmi_write(DMI_COMMAND, wdata);
        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);
	check_abstractcs_state(state);

	if(state) xlen = 32;
	else      xlen = 64;

	if (dispmon_DBG_API_0) $display("%0t:DBG_API:XLEN=%0d", $realtime, xlen);

	dbg_continue;
	dbg_wait_resume;
end
endtask

task detect_flen;
reg  [63:0]	rdata;
reg  [1:0]      state;
begin
	dbg_break;

	if (dispmon_DBG_API_0) $display("%0t:DBG_API:dbg_detect_flen()", $realtime);

        dbg_get_csr(REG_MISA, rdata, CMD_NOPOSTEXEC);

        case ({rdata[3], rdata[5]})
                2'b00:          flen = 0;
                2'b01:          flen = 32;
                2'b11:          flen = 64;
                default:        flen = 0;
        endcase

	if (dispmon_DBG_API_0) $display("%0t:DBG_API:FLEN=%0d", $realtime, flen);

	dbg_continue;
        dbg_wait_resume;
end
endtask

task init_dm;
reg	[31:0]	rdata;
reg	[1:0]	state;
reg	[31:0]	abstractcs;
reg	[31:0]	progbuf_addr;
reg		allhalted;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Initialize Debug Module", $realtime);

	dmi_read (DMI_DMSTATUS, rdata);

	dmi_write(DMI_DMCONTROL, 32'h00000000);
	dmi_write(DMI_DMCONTROL, 32'h00000001);
	dmi_read (DMI_DMCONTROL, rdata);

end
endtask

task check_hart_connected;
output		hart_count;
input		max_probe;
reg	[10:0]	hart_count;
reg	[10:0]	max_probe;
reg	[19:0]	hartid;
reg		existent;
begin
	existent = 1;
	for (hartid=0; (hartid<MAX_HART) && (hartid<max_probe) && (existent); hartid=hartid+1) begin
		dbg_probe_hart(existent, hartid);
		if (dispmon_DBG_API_0) $display("%0t:DBG_API:Probe hart =%0d, existence=%b", $realtime, hartid, existent);
	end
	hart_count = (existent)? hartid : hartid-1;
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Connected hart count=%0d", $realtime, hart_count);
end
endtask

task check_hart_halted;
output	[MAX_HART-1:0]	hart_halted;
reg	[31:0]	halt_sum;
reg	[31:0]	rdata;
reg	[31:0]	halt_warp;
integer	ite;
begin
	dmi_read (DMI_HALTSUM, halt_sum);
	for (ite=31; ite>=0; ite=ite-1) begin
		if (~halt_sum[ite]) begin
			halt_warp	= 32'h0;
		end
		else begin
			dmi_read(DMI_HALTREGION_BASE+ite, halt_warp);
		end
		hart_halted		= hart_halted << 32;
		hart_halted[31:0]	= halt_warp;
	end
end
endtask

task detect_s_u_mode;
output  smode_support;
output  umode_support;
reg     [31:0]          misa;
reg                     smode_support;
reg                     umode_support;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:detect_s_u_mode()", $realtime);

        dbg_get_csr(REG_MISA,     misa[31:0],     CMD_NOPOSTEXEC);

        if (misa[20] == 1) begin
                umode_support = 1'b1;
	        if (dispmon_DBG_API_0) $display("%0t:DBG_API:U-Mode is supported", $realtime);
        end
        else begin
                umode_support = 1'b0;
        end

        if (misa[18] == 1) begin
                smode_support = 1'b1;
	        if (dispmon_DBG_API_0) $display("%0t:DBG_API:S-Mode is supported", $realtime);
        end
        else begin
                smode_support = 1'b0;
        end
end
endtask

task detect_pfm_support;
output  pfm_support;
reg     [31:0]          mmsc_cfg;
reg                     pfm_support;
reg                     mmsc_cfg_pmnds;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:detect_pfm_support", $realtime);

        dbg_get_csr(REG_MMSC_CFG, mmsc_cfg[31:0], CMD_NOPOSTEXEC);
        mmsc_cfg_pmnds = mmsc_cfg[15];

        if (mmsc_cfg_pmnds == 1) begin
                pfm_support = 1'b1;
	        if (dispmon_DBG_API_0) $display("%0t:DBG_API:Performance Monitor is supported", $realtime);
        end
        else begin
                pfm_support = 1'b0;
        end
end
endtask

task dbg_select_hart;
input		hartid;
integer		hartid;
reg [31:0]	wdata;
reg        	haltreq;
reg        	resumereq;
reg        	hartreset;
reg        	hasel;
reg [19:0]  	hartsel;
reg             dmactive;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Select hart:%d", $realtime, hartid);

	haltreq   = 1'b0;
	resumereq = 1'b0;
	hartreset = 1'b0;
	hasel     = 1'b0;
	hartsel   = hartid[19:0];
        dmactive  = 1'b1;

        wdata = _dmcontrol(haltreq, resumereq, hartreset, 1'b0, hasel, hartsel[9:0], hartsel[19:10], 1'b0, 1'b0, 1'b0, dmactive);
	dmi_write(DMI_DMCONTROL, wdata);

        fg_hart = hartid;
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Select hart %0d", $realtime, fg_hart[9:0]);
end
endtask

task dbg_probe_hart;
output		exist;
input		hartid;
reg [19:0]	hartid;
reg [31:0]	wdata;
reg [31:0]	rdata;
reg        	haltreq;
reg        	resumereq;
reg        	hartreset;
reg        	hasel;
reg [19:0]  	hartsel;
reg             dmactive;
reg		exist;
begin
	haltreq   = 1'b0;
	resumereq = 1'b0;
	hartreset = 1'b0;
	hasel     = 1'b0;
	hartsel   = hartid[19:0];
        dmactive  = 1'b1;

        wdata = _dmcontrol(haltreq, resumereq, hartreset, 1'b0, hasel, hartsel[9:0], hartsel[19:10], 1'b0, 1'b0, 1'b0, dmactive);
	dmi_write(DMI_DMCONTROL, wdata);
	dmi_read (DMI_DMSTATUS,  rdata);
	exist	= ~rdata[14];
end
endtask

task dbg_assert_ndmreset;
reg [31:0]	wdata;
begin
        dmi_read(DMI_DMCONTROL, wdata);
        wdata[NDMRESET_BIT] = 1;
	dmi_write(DMI_DMCONTROL, wdata);
end
endtask

task dbg_deassert_ndmreset;
reg [31:0]	wdata;
begin
        dmi_read(DMI_DMCONTROL, wdata);
        wdata[NDMRESET_BIT]	= 0;
	dmi_write(DMI_DMCONTROL, wdata);
end
endtask

task dbg_setresethaltreq;
reg [31:0]	wdata;
reg [31:0]	rdata;
reg             hasel;
reg [19:0]      hartsel;
reg             setresethaltreq;
reg             dmactive;
begin
        hasel   = bg_hart_sel;
        hartsel = fg_hart[19:0];
        setresethaltreq = 1'b1;
        dmactive = 1'b1;

        wdata   = _dmcontrol(1'b0, 1'b0, 1'b0, 1'b0, hasel, hartsel[9:0], hartsel[19:10], setresethaltreq, 1'b0, 1'b0, dmactive);

	dmi_read (DMI_DMCONTROL, rdata);
	dmi_write(DMI_DMCONTROL, wdata);
end
endtask

task dbg_clrresethaltreq;
reg [31:0]	wdata;
reg [31:0]	rdata;
reg [19:0]      hartsel;
reg             clrresethaltreq;
reg             hasel;
reg             dmactive;
begin
        hasel   = bg_hart_sel;
        hartsel = fg_hart[19:0];
        clrresethaltreq = 1'b1;
        dmactive = 1'b1;

        wdata   = _dmcontrol(1'b0, 1'b0, 1'b0, 1'b0, hasel, hartsel[9:0], hartsel[19:10], 1'b0, clrresethaltreq, 1'b0, dmactive);

	dmi_read (DMI_DMCONTROL, rdata);
	dmi_write(DMI_DMCONTROL, wdata);
end
endtask

task dbg_break;
reg [31:0] wdata;
reg [31:0] rdata;
reg [1:0]  state;
reg [19:0] hartsel;
reg        haltreq;
reg        hasel;
reg        dmactive;
reg        sel_any;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Set the selected hart enter debug mode", $realtime);

	haltreq   = 1'b1;
	hasel     = bg_hart_sel;
	hartsel   = fg_hart;
        dmactive  = 1'b1;
        sel_any   = 1'b0;

        wdata = _dmcontrol(haltreq, 1'b0, 1'b0, 1'b0, hasel, hartsel[9:0], hartsel[19:10], 1'b0, 1'b0, 1'b0, dmactive);
	rdata = 32'b0;

	dmi_write(DMI_DMCONTROL, wdata);
        dbg_wait_halted(sel_any, hartsel[9:0], hartsel[19:10]);

end
endtask

task dbg_continue;
reg [31:0] wdata;
reg [31:0] rdata;
reg [1:0]  state;
reg        resumereq;
reg        hasel;
reg [19:0] hartsel;
reg        dmactive;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Set the selected hart exit debug mode", $realtime);

	resumereq = 1'b1;
        hasel     = bg_hart_sel;
	hartsel   = fg_hart;
        dmactive  = 1'b1;

        wdata = _dmcontrol(1'b0, resumereq, 1'b0, 1'b0, hasel, hartsel[9:0], hartsel[19:10], 1'b0, 1'b0, 1'b0, dmactive);
	rdata = 32'b0;
	dmi_write(DMI_DMCONTROL, wdata);
end
endtask

task dbg_wait_halted;
input           sel_any;
input   [9:0]   hart_sello;
input   [9:0]   hart_selhi;
reg     [19:0]  hart_sel;
reg             anynonexistent;
reg             allhalted;
reg             anyhalted;
reg     [31:0]  rdata;
reg     [31:0]  wdata;
integer         count;
begin
	allhalted = 1'b0;
        anyhalted = 1'b0;
	count = 0;

        hart_sel = {hart_selhi, hart_sello};

	while ((!sel_any && !allhalted) | (sel_any && !anyhalted)) begin
		if (count > MAX_RETRY) begin
			if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Timeout waiting for hart %d to stop", $realtime, $time, hart_sel[19:0]); #1 $finish; end
		end
		dmi_read(DMI_DMSTATUS, rdata);
		anynonexistent = rdata[14];
		allhalted      = rdata[9];
                anyhalted      = rdata[8];

		if (anynonexistent) begin
			if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Invalid hart: %d", $realtime, $time, hart_sel[19:0]); #1 $finish; end
		end

		count = count + 1;
	end
end
endtask

task dbg_wait_resume;
reg [31:0] wdata;
reg [31:0] rdata;
reg        anyhalted;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Wait the selected hart exit debug mode", $realtime);

        dmi_read(DMI_DMSTATUS, rdata);
        anyhalted = rdata[8];

        while (anyhalted) begin
                dmi_read(DMI_DMSTATUS, rdata);
                anyhalted = rdata[8];
        end
end
endtask

task dbg_step;
input			flg_quick_access;
reg [MAXLEN-1:0]	wdata;
begin

        dbg_setb_csr(REG_DCSR, 'h4);

	dbg_continue;

	dbg_wait;

	dbg_clrb_csr(REG_DCSR, 'h4);
end
endtask

task dbg_wait;
integer		count;
reg [31:0]	scan_din;
reg [31:0]	scan_dout;
reg [1:0]	state;
begin
	count = 0;
	dmi_read (DMI_DMCONTROL, scan_dout);

	scan_din	= scan_dout;
	scan_din[26]	= 1'b0;
	scan_din[25:16]	= fg_hart[9:0];

	dmi_write(DMI_DMCONTROL, scan_din);

	scan_dout = 32'h0;
	while (scan_dout[9] == 1'b0) begin
		if (count > MAX_RETRY) begin
			if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Timeout waiting for DMSTATUS.allhalted", $realtime); #1 $finish; end
		end

		dmi_read (DMI_DMSTATUS, scan_dout);
		count = count + 1;
	end
end
endtask

task dbg_get_hart_info;
input	[31:0]	hartid;
output		nscratch;
output		dataaccess;
output		datasize;
output		dataaddr;
reg	[3:0]	nscractch;
reg		dataaccess;
reg	[3:0]	datasize;
reg	[11:0]	dataaddr;
reg	[31:0]	rdata;
begin
	dbg_select_hart(hartid);

	dmi_read (DMI_HARTINFO, rdata);

	nscratch	= rdata[23:20];
	dataaccess	= rdata[16];
	datasize	= rdata[15:12];
	dataaddr	= rdata[11:0];
end
endtask

task dbg_exit;
input [31:0]	pass_fail;
reg   [2:0]     state;
begin
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Debug exit", $realtime);
	$display("%0t:%m:", $time);
        if (pass_fail == DBG_PASS)
		$display("%0t: ---- SIMULATION PASSED ----", $time);
        else if (pass_fail == DBG_FAIL)
		$display("%0t: ---- SIMULATION FAILED ----", $time);
        else if (pass_fail == DBG_SKIP)
		$display("%0t: ---- SIMULATION SKIPPED ----", $time);

	#100;
	$finish;
end
endtask


task dbg_trigger_count;
output			trig_count;
integer			trig_count;
reg	[MAXLEN-1:0]	rdata;
reg     [2:0]           cmderr;
begin : trig_count_test_flow
	for (trig_count=0; trig_count<8; trig_count=trig_count+1) begin
		dbg_set_csr(REG_TSELECT, trig_count, CMD_NOPOSTEXEC);
		dbg_get_csr(REG_TSELECT, rdata, CMD_NOPOSTEXEC);
		if (trig_count != rdata) begin
			disable trig_count_test_flow;
                end else if (trig_count == 0) begin
                        dbg_get_csr(REG_TINFO, rdata, CMD_NOPOSTEXEC);
                        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);
                        check_abstractcs_state(cmderr);
                        if (cmderr == 3'd0 && rdata == 1) begin
                                disable trig_count_test_flow;
                        end else if (cmderr == 3'd3) begin
                                dbg_get_csr(REG_TDATA1, rdata, CMD_NOPOSTEXEC);
                                if (rdata == 0) begin
                                        disable trig_count_test_flow;
                                end
                        end
                end
	end
end
endtask

task dbg_add_breakpoint;
input [2:0]		trig_id;
input [MAXLEN-1:0]	trig_addr;
reg   [MAXLEN-1:0]	trig_ctrl;
begin
	if (xlen === 32) begin
		trig_ctrl = {{(MAXLEN-32){1'b0}}, 32'h2800107c};
	end
	else if (xlen === 64) begin
		trig_ctrl = {{(MAXLEN-64){1'b0}}, 64'h28000000_0000107c};
	end
	dbg_set_csr(REG_TSELECT, trig_id, CMD_NOPOSTEXEC);
	dbg_set_csr(REG_TDATA2, trig_addr, CMD_NOPOSTEXEC);
	dbg_set_csr(REG_TDATA1, trig_ctrl, CMD_NOPOSTEXEC);
end
endtask

task dbg_add_watchpoint;
input [2:0]		trig_id;
reg   [MAXLEN-1:0]	trig_ctrl;
input [MAXLEN-1:0]	trig_addr;
begin
	if (xlen === 32) begin
		trig_ctrl = {{(MAXLEN-32){1'b0}}, 32'h2800107c};
	end
	else if (xlen === 64) begin
		trig_ctrl = {{(MAXLEN-64){1'b0}}, 64'h28000000_0000107c};
	end
	dbg_set_csr(REG_TSELECT, trig_id, CMD_NOPOSTEXEC);
	dbg_set_csr(REG_TDATA2, trig_addr, CMD_NOPOSTEXEC);
	dbg_set_csr(REG_TDATA1, trig_ctrl, CMD_NOPOSTEXEC);
end
endtask

task dbg_remove_breakpoint;
input	[2:0]		trig_id;
begin
	dbg_remove_triggerpoint(trig_id);
end
endtask

task dbg_remove_watchpoint;
input	[2:0]		trig_id;
begin
	dbg_remove_triggerpoint(trig_id);
end
endtask

task dbg_remove_triggerpoint;
input [2:0]		trig_id;
reg   [MAXLEN-1:0]	trig_ctrl;
reg   [MAXLEN-1:0]	trig_addr;
begin
	if (xlen === 32) begin
		trig_ctrl	= {{(MAXLEN-32){1'b0}}, 32'h00000000};
		trig_addr	= {{(MAXLEN-32){1'b0}}, 32'h00000000};
	end
	else if (xlen === 64) begin
		trig_ctrl	= {{(MAXLEN-64){1'b0}}, 64'h00000000_00000000};
		trig_addr	= {{(MAXLEN-64){1'b0}}, 64'h00000000_00000000};
	end

	dbg_set_csr(REG_TSELECT, trig_id, CMD_NOPOSTEXEC);
	dbg_set_csr(REG_TDATA1, trig_ctrl, CMD_NOPOSTEXEC);
	dbg_set_csr(REG_TDATA2, trig_addr, CMD_NOPOSTEXEC);
end
endtask

task dbg_load_byte;
input	[MAXLEN-1:0]	addr;
output	[7:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[7:0]		data;
reg	[31:0]		rdata;
reg	[31:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00100000);
                        dmi_write_sbaddress(xlen, addr);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(32, rdata);
                        data	= rdata[7:0];
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00100000);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(32, rdata);
                        data	= rdata[7:0];
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803403 : 32'h0c402403;

		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, 32'h00040403);
		dmi_write(DMI_PROGBUF3, 32'h0c802023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
		dmi_write(DMI_PROGBUF5, 32'h7b202473);
		dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end

                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);

		dmi_read_arg0(xlen, rdata);
		data	= rdata[7:0];
	end
end
endtask


task dbg_load_hword;
input	[MAXLEN-1:0]	addr;
output	[15:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[15:0]		data;
reg	[31:0]		rdata;
reg	[31:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00120000);
                        dmi_write_sbaddress(xlen, addr);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(32, rdata);
                        data	= rdata[15:0];
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00120000);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(32, rdata);
                        data	= rdata[15:0];
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803403 : 32'h0c402403;

		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, 32'h00041403);
                dmi_write(DMI_PROGBUF3, 32'h0c802023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
                dmi_write(DMI_PROGBUF5, 32'h7b202473);
                dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end

                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);

		dmi_read_arg0(xlen, rdata);
		data	= rdata[15:0];
	end
end
endtask


task dbg_load_word;
input	[MAXLEN-1:0]	addr;
output	[31:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[31:0]		data;
reg	[31:0]		rdata;
reg	[31:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00140000);
                        dmi_write_sbaddress(xlen, addr);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(32, rdata);
                        data	= rdata[31:0];
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00140000);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(32, rdata);
                        data	= rdata[31:0];
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803403 : 32'h0c402403;

		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, 32'h00042403);
		dmi_write(DMI_PROGBUF3, 32'h0c802023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
                dmi_write(DMI_PROGBUF5, 32'h7b202473);
		dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end

                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);

		dmi_read_arg0(xlen, rdata);
		data	= rdata[31:0];
	end
end
endtask

task dbg_load_dword;
input	[MAXLEN-1:0]	addr;
output	[63:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[63:0]		data;
reg	[63:0]		rdata;
reg	[63:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00160000);
                        dmi_write_sbaddress(xlen, addr);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(64, rdata);
                        data	= rdata[63:0];
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00160000);
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
                        dmi_read_sbdata(64, rdata);
                        data	= rdata[63:0];
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803403 : 32'h0c402403;

		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, 32'h00043403);
		dmi_write(DMI_PROGBUF3, 32'h0c803023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
                dmi_write(DMI_PROGBUF5, 32'h7b202473);
                dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end

                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);

		dmi_read_arg0(xlen, rdata);
		data	= rdata[63:0];
	end
end
endtask

task dbg_store_byte;
input	[MAXLEN-1:0]	addr;
input	[7:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[7:0]		data;
reg	[31:0]		rdata;
reg	[31:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
reg	[31:0]		inst_get_data;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00000000);
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write_sbdata(32, data);
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00000000);
                        dmi_write_sbdata(32, data);
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803483 : 32'h0c402483;
		inst_get_data	= (xlen >= 64)?	32'h0c003403 : 32'h0c002403;

		dmi_write_arg0(xlen, data);
		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, inst_get_data);
		dmi_write(DMI_PROGBUF3, 32'h00848023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
                dmi_write(DMI_PROGBUF5, 32'h7b202473);
		dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end
                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);
	end
end
endtask

task dbg_store_hword;
input	[MAXLEN-1:0]	addr;
input	[15:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[15:0]		data;
reg	[31:0]		rdata;
reg	[31:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
reg	[31:0]		inst_get_data;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00020000);
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write_sbdata(32, data);
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00020000);
                        dmi_write_sbdata(32, data);
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803483 : 32'h0c402483;
		inst_get_data	= (xlen >= 64)?	32'h0c003403 : 32'h0c002403;

		dmi_write_arg0(xlen, data);
		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, inst_get_data);
		dmi_write(DMI_PROGBUF3, 32'h00849023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
                dmi_write(DMI_PROGBUF5, 32'h7b202473);
		dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end
                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);
	end
end
endtask

task dbg_store_word;
input	[MAXLEN-1:0]	addr;
input	[31:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[31:0]		data;
reg	[31:0]		rdata;
reg	[31:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
reg	[31:0]		inst_get_data;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00040000);
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write_sbdata(32, data);
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00040000);
                        dmi_write_sbdata(32, data);
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803483 : 32'h0c402483;
		inst_get_data	= (xlen >= 64)?	32'h0c003403 : 32'h0c002403;

		dmi_write_arg0(xlen, data);
		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, inst_get_data);
		dmi_write(DMI_PROGBUF3, 32'h0084a023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
                dmi_write(DMI_PROGBUF5, 32'h7b202473);
		dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end
                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);
	end
end
endtask

task dbg_store_dword;
input	[MAXLEN-1:0]	addr;
input	[63:0]		data;
input			flg_direct_access;
input			flg_quick_access;
reg	[63:0]		data;
reg	[63:0]		rdata;
reg	[63:0]		wdata;
reg	[1:0]		state;
reg	[31:0]		inst_get_addr;
reg	[31:0]		inst_get_data;
begin
	if (flg_direct_access===1'b1) begin
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
                if (_sb_version==SB_VER_DRAFT18) begin
                        dmi_write(DMI_SBCS, 32'h00060000);
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write_sbdata(64, data);
                end
                else if (_sb_version==SB_VER_DRAFT17) begin
                        dmi_write_sbaddress(xlen, addr);
                        dmi_write(DMI_SBCS, 32'h00060000);
                        dmi_write_sbdata(64, data);
                end
	end
	else begin
		inst_get_addr	= (xlen >= 64)?	32'h0c803483 : 32'h0c402483;
		inst_get_data	= (xlen >= 64)?	32'h0c003403 : 32'h0c002403;

		dmi_write_arg0(xlen, data);
		dmi_write_arg1(xlen, addr);

                dmi_write(DMI_PROGBUF0, 32'h7b241073);
		dmi_write(DMI_PROGBUF1, inst_get_addr);
		dmi_write(DMI_PROGBUF2, inst_get_data);
		dmi_write(DMI_PROGBUF3, 32'h0084b023);
		dmi_write(DMI_PROGBUF4, 32'h0ff0000f);
                dmi_write(DMI_PROGBUF5, 32'h7b202473);
		dmi_write(DMI_PROGBUF6, 32'h00100073);
		dmi_write(DMI_PROGBUF7, 32'hffffffff);

		if (flg_quick_access === 1'b1) begin
			quick_access;
		end
		else begin
			execute_progbuf;
		end
                wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);
	end
end
endtask

task dbg_post_incr_load;
input	[MAXLEN-1:0]	base_addr;
output	[BUFLEN-1:0]	rbuffer;
input	[9:0]		size;
input   [7:0]           alen;
input   [7:0]           dlen;
input			direct_access;
reg	[31:0]		it_step;
reg	[31:0]		it;
reg	[31:0]		cmd_waddr;
reg	[31:0]		cmd_rdata;
reg	[31:0]		sb_control;
reg     [2:0]           sb_accsize;
reg	[MAXLEN-1:0]	rdata;
reg     [MAXLEN-1:0]    s0_backup;
begin
	rbuffer	= {BUFLEN{1'b0}};
	if (direct_access) begin
                case (dlen)
                        8'd128:         sb_accsize = SB_SIZE_128;
                        8'd64:          sb_accsize = SB_SIZE_64;
                        8'd32:          sb_accsize = SB_SIZE_32;
                        8'd16:          sb_accsize = SB_SIZE_16;
                        8'd8:           sb_accsize = SB_SIZE_8;
                        default:        sb_accsize = 3'hx;
                endcase
                sb_control	= _sbcs(SB_READONADDR, sb_accsize, SB_AUTOINCREMENT, SB_READONDATA, SB_KEEPBUSYERROR, SB_KEEPERROR);
                it_step         = dlen / 8;

                wait_sbbusy_clr(CHECK_BUSY_TYPE);
		dmi_write(DMI_SBCS, sb_control);
		dmi_write_sbaddress(alen, base_addr);

		for (it=0; it+it_step<size; it=it+it_step) begin
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
			dmi_read_sbdata(dlen, rdata);
			rbuffer	= rbuffer | ({{(BUFLEN-MAXLEN){1'b0}}, rdata} << (it << 3));
		end
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
		dmi_write(DMI_SBCS, 32'h00000000);
		dmi_read_sbdata(dlen, rdata);
		rbuffer	= rbuffer | ({{(BUFLEN-MAXLEN){1'b0}}, rdata} << (it << 3));
	end
	else begin
                dbg_get_gpr(GPR_S0, s0_backup, 1'b0);
		if (dlen == 64) begin
			dmi_write(DMI_PROGBUF0, 32'h00043483);
			dmi_write(DMI_PROGBUF1, 32'h00840413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd8;
		end else if (dlen == 32) begin
			dmi_write(DMI_PROGBUF0, 32'h00042483);
			dmi_write(DMI_PROGBUF1, 32'h00440413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd4;
		end else if (dlen == 16) begin
			dmi_write(DMI_PROGBUF0, 32'h00041483);
			dmi_write(DMI_PROGBUF1, 32'h00240413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd2;
		end else if (dlen == 8) begin
			dmi_write(DMI_PROGBUF0, 32'h00040483);
			dmi_write(DMI_PROGBUF1, 32'h00140413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd1;
                end else begin
			if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported access width (width=%0d) for dbg_post_incr_store", $realtime, dlen); #1 $finish; end
                end

		cmd_waddr	= _cmd(CMD_ACCESS_REG, _cmd_size(alen), CMD_POSTEXEC, CMD_ABSCMD, CMD_WRITE, (16'h1000 | {11'b0, GPR_S0}));
		cmd_rdata	= _cmd(CMD_ACCESS_REG, _cmd_size(dlen), CMD_POSTEXEC, CMD_ABSCMD, CMD_READ,  (16'h1000 | {11'b0, GPR_S1}));

		dmi_write_arg0(alen, base_addr);
		dmi_write(DMI_COMMAND, cmd_waddr);
                wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);
		dmi_write(DMI_COMMAND, cmd_rdata);
                wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);

                set_absauto_exe(32'h00000001);

		for (it=0; it+it_step<size; it=it+it_step) begin
			dmi_read_arg0(dlen, rdata);
			rbuffer	= rbuffer | ({{(BUFLEN-MAXLEN){1'b0}}, rdata} << (it << 3));
                        wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);
		end

                clr_absauto_exe;
		dmi_read_arg0(dlen, rdata);
                dbg_set_gpr(GPR_S0, s0_backup, 1'b0);

		rbuffer	= rbuffer | ({{(BUFLEN-MAXLEN){1'b0}}, rdata} << (it << 3));
	end
end
endtask

task dbg_post_incr_store;
input	[MAXLEN-1:0]	base_addr;
input	[BUFLEN-1:0]	wbuffer;
input	[9:0]		size;
input   [7:0]           alen;
input   [7:0]           dlen;
input			direct_access;
reg	[32:0]		it_step;
reg	[32:0]		it;
reg	[31:0]		cmd_waddr;
reg	[31:0]		cmd_wdata;
reg	[31:0]		sb_control;
reg     [2:0]           sb_accsize;
reg	[MAXLEN-1:0]	wdata;
reg	[BUFLEN-1:0]	wmask;
reg     [MAXLEN-1:0]    s0_backup;
begin
	if (direct_access) begin
                case (dlen)
                        8'd128:         sb_accsize = SB_SIZE_128;
                        8'd64:          sb_accsize = SB_SIZE_64;
                        8'd32:          sb_accsize = SB_SIZE_32;
                        8'd16:          sb_accsize = SB_SIZE_16;
                        8'd8:           sb_accsize = SB_SIZE_8;
                        default:        sb_accsize = 3'hx;
                endcase
                sb_control	= _sbcs(SB_NOREADONADDR, sb_accsize, SB_AUTOINCREMENT, SB_NOREADONDATA, SB_KEEPBUSYERROR, SB_KEEPERROR);
                it_step         = dlen / 8;
                wmask           = (1 << dlen) - 1;

                wait_sbbusy_clr(CHECK_BUSY_TYPE);
		dmi_write(DMI_SBCS, sb_control);
		dmi_write_sbaddress(alen, base_addr);

		for (it=0; it<size; it=it+it_step) begin
                        wait_sbbusy_clr(CHECK_BUSY_TYPE);
			wdata	= wbuffer & wmask;
			wbuffer	= wbuffer >> (it_step << 3);
			dmi_write_sbdata(dlen, wdata);
		end

                wait_sbbusy_clr(CHECK_BUSY_TYPE);
		dmi_write(DMI_SBCS, 32'h00000000);
	end
	else begin
                dbg_get_gpr(GPR_S0, s0_backup, 1'b0);
		if (dlen == 64) begin
			dmi_write(DMI_PROGBUF0, 32'h00943023);
			dmi_write(DMI_PROGBUF1, 32'h00840413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd8;
			wmask	= {{(BUFLEN-64){1'b0}}, 64'hffffffff_ffffffff};
		end else if (dlen == 32) begin
			dmi_write(DMI_PROGBUF0, 32'h00942023);
			dmi_write(DMI_PROGBUF1, 32'h00440413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd4;
			wmask	= {{(BUFLEN-32){1'b0}}, 32'hffffffff};
		end else if (dlen == 16) begin
			dmi_write(DMI_PROGBUF0, 32'h00941023);
			dmi_write(DMI_PROGBUF1, 32'h00240413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd2;
			wmask	= {{(BUFLEN-16){1'b0}}, 16'hffff};
		end else if (dlen == 8) begin
			dmi_write(DMI_PROGBUF0, 32'h00940023);
			dmi_write(DMI_PROGBUF1, 32'h00140413);
			dmi_write(DMI_PROGBUF2, 32'h00100073);
			it_step	= 32'd1;
			wmask	= {{(BUFLEN-8){1'b0}}, 8'hff};
                end else begin
			if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported access width (width=%0d) for dbg_post_incr_store", $realtime, dlen); #1 $finish; end
                end

		cmd_waddr	= _cmd(CMD_ACCESS_REG, _cmd_size(alen), CMD_NOPOSTEXEC, CMD_ABSCMD, CMD_WRITE, (16'h1000 | {11'b0, GPR_S0}));
		cmd_wdata	= _cmd(CMD_ACCESS_REG, _cmd_size(dlen), CMD_POSTEXEC,   CMD_ABSCMD, CMD_WRITE, (16'h1000 | {11'b0, GPR_S1}));

		dmi_write_arg0(alen, base_addr);
		dmi_write(DMI_COMMAND, cmd_waddr);
                wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);

		wdata	= wbuffer & wmask;
		wbuffer	= wbuffer >> (it_step << 3);
		dmi_write_arg0(dlen, wdata);
		dmi_write(DMI_COMMAND, cmd_wdata);
                wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);

                set_absauto_exe(32'h00000001);

		for (it=it_step; it<size; it=it+it_step) begin
			wdata	= wbuffer & wmask;
			wbuffer	= wbuffer >> (it_step << 3);
			dmi_write_arg0(dlen, wdata);
                        wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);
		end

                clr_absauto_exe;
                dbg_set_gpr(GPR_S0, s0_backup, 1'b0);
	end
end
endtask

task dbg_get_csr;
input  [11:0]     csr_addr;
output [MAXLEN-1:0] csr_data;
input             postexec;
reg    [15:0]     regno;
reg    [31:0]     wdata;
reg    [31:0]     rdata;
reg    [1:0]      state;
begin
	regno = {4'b0,csr_addr};
        wdata = _cmd(CMD_ACCESS_REG, _cmd_size(xlen), postexec, CMD_ABSCMD, CMD_READ, regno);
	dmi_write(DMI_COMMAND, wdata);
        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);
	dmi_read_arg0(xlen, csr_data);
end
endtask

task dbg_set_csr;
input [11:0]     csr_addr;
input [MAXLEN-1:0] csr_data;
input            postexec;
reg   [15:0]     regno;
reg   [31:0]     wdata;
reg   [31:0]     rdata;
reg   [1:0]      state;
begin
	dmi_write_arg0(xlen, csr_data);

	regno = {4'b0, csr_addr};
        wdata = _cmd(CMD_ACCESS_REG, _cmd_size(xlen), postexec, CMD_ABSCMD, CMD_WRITE, regno);

	dmi_write(DMI_COMMAND, wdata);
        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);

end
endtask

task dbg_setb_csr;
input [11:0]     csr_addr;
input [MAXLEN-1:0] csr_data;

reg   [15:0]     regno;
reg   [31:0]     wdata;
reg   [MAXLEN-1:0]     rdata;
reg   [1:0]      state;
begin
        dbg_get_csr(csr_addr, rdata, CMD_NOPOSTEXEC);
	rdata = rdata | csr_data;
        dbg_set_csr(csr_addr, rdata, CMD_NOPOSTEXEC);
end
endtask

task dbg_clrb_csr;
input [11:0]     csr_addr;
input [MAXLEN-1:0] csr_data;

reg   [15:0]     regno;
reg   [31:0]     wdata;
reg   [31:0]     rdata;
reg   [1:0]      state;
begin
        dbg_get_csr(csr_addr, rdata, CMD_NOPOSTEXEC);
	rdata = rdata & (~csr_data);
        dbg_set_csr(csr_addr, rdata, CMD_NOPOSTEXEC);
end
endtask

task dbg_get_current_pc;
output [MAXLEN-1:0]	pc;
begin
	dbg_get_csr(REG_DPC, pc, CMD_NOPOSTEXEC);
end
endtask

task dbg_set_return_pc;
input [MAXLEN-1:0]	pc;
begin
	dbg_set_csr(REG_DPC, pc, CMD_NOPOSTEXEC);
end
endtask

task dbg_get_gpr;
input  [4:0]		index;
output [MAXLEN-1:0]	gpr_data;
input                   postexec;
reg   [15:0] regno;
reg   [31:0] wdata;
reg   [31:0] rdata;
reg   [1:0]  state;
begin
	regno = 16'h1000 | {11'b0, index};
	wdata = _cmd(CMD_ACCESS_REG, _cmd_size(xlen), postexec, CMD_ABSCMD, CMD_READ, regno);
	dmi_write(DMI_COMMAND, wdata);
        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);

	dmi_read_arg0(xlen, gpr_data);
end
endtask

task dbg_set_gpr;
input [4:0] 		index;
input [MAXLEN-1:0] 	reg_data;
input                   postexec;
reg   [15:0]     regno;
reg   [31:0]     wdata;
reg   [31:0]     rdata;
reg   [1:0]      state;
begin
	dmi_write_arg0(xlen, reg_data);

	regno = 16'h1000 | {11'b0, index};
        wdata = _cmd(CMD_ACCESS_REG, _cmd_size(xlen), postexec, CMD_ABSCMD, CMD_WRITE, regno);
	dmi_write(DMI_COMMAND, wdata);
        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);
end
endtask

task dbg_get_fpr;
input  [4:0]		index;
output [MAXLEN-1:0]	fpr_data;
input                   postexec;
reg   [15:0] regno;
reg   [31:0] wdata;
reg   [31:0] rdata;
reg   [1:0]  state;
begin
	regno = 16'h1020 | {11'b0, index};
        wdata = _cmd(CMD_ACCESS_REG, _cmd_size(flen), postexec, CMD_ABSCMD, CMD_READ, regno);
	dmi_write(DMI_COMMAND, wdata);
        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);

        fpr_data = {MAXLEN{1'b0}};

        dmi_read_arg0(flen, fpr_data);

end
endtask

task dbg_set_fpr;
input [4:0] 		index;
input [MAXLEN-1:0] 	reg_data;
input                   postexec;
reg   [15:0]     regno;
reg   [31:0]     wdata;
reg   [31:0]     rdata;
reg   [1:0]      state;
begin
	dmi_write_arg0(flen, reg_data);

	regno = 16'h1020 | {11'b0, index};
        wdata = _cmd(CMD_ACCESS_REG, _cmd_size(flen), (postexec)? CMD_POSTEXEC : CMD_NOPOSTEXEC, CMD_ABSCMD, CMD_WRITE, regno);
	dmi_write(DMI_COMMAND, wdata);
        wait_execute_finish(!BUS_ACCESS, CHECK_BUSY_TYPE);
end
endtask

function [31:0] _cmd;
input [7:0]  cmdtype;
input [2:0]  size;
input        postexec;
input        transfer;
input        write;
input [15:0] regno;

begin
	_cmd = {cmdtype, 1'b0, size, 1'b0, postexec, transfer, write, regno};
end
endfunction

function [2:0]	_cmd_size;
input integer	_xlen;
begin
	_cmd_size	= (_xlen == 128) ? CMD_SIZE_128 :
	(_xlen == 64)	 ? CMD_SIZE_64 :
	CMD_SIZE_32 ;
end
endfunction

function [31:0] _dmcontrol;
input           haltreq;
input           resumereq;
input           hartreset;
input           ackhavereset;
input           hasel;
input   [9:0]   hartsello;
input   [9:0]   hartselhi;
input           setresethaltreq;
input           clrresethaltreq;
input           ndmreset;
input           dmactive;
begin
        _dmcontrol = {haltreq, resumereq, hartreset, ackhavereset, 1'b0, hasel, hartsello, hartselhi, 2'b0, setresethaltreq, clrresethaltreq, ndmreset, dmactive};
end
endfunction

function [31:0]	_sbcs;
input           sbreadonaddr;
input	[2:0]	sbaccess;
input		sbautoincrement;
input		sbreadondata;
input		sbbusyerror_clr;
input	[2:0]	sberror_clr;
begin
        _sbcs   = {9'h000, sbbusyerror_clr, 1'b0, sbreadonaddr, sbaccess, sbautoincrement, sbreadondata, sberror_clr, 12'h000};
end
endfunction

task dmi_read_arg0;
input			acc_size;
output	[MAXLEN-1:0]	dataout;

integer			acc_size;
reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	wdata = 32'b0;
	dataout	= {MAXLEN{1'b0}};

	if (acc_size === 32) begin
		dmi_read(DMI_DATA0, dataout[31:00]);
	end
	else if (acc_size === 64) begin
		dmi_read(DMI_DATA1, dataout[63:32]);
		dmi_read(DMI_DATA0, dataout[31:00]);
	end
	else if (acc_size === 128) begin
		dmi_read(DMI_DATA3, dataout[127:96]);
		dmi_read(DMI_DATA2, dataout[95 :64]);
		dmi_read(DMI_DATA1, dataout[63 :32]);
		dmi_read(DMI_DATA0, dataout[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported read_arg width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_write_arg0;
input			acc_size;
input [MAXLEN-1:0]	reg_data;

integer			acc_size;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	if (acc_size === 32) begin
		dmi_write(DMI_DATA0, reg_data[31: 0]);
	end
	else if (acc_size === 64) begin
		dmi_write(DMI_DATA1, reg_data[63:32]);
		dmi_write(DMI_DATA0, reg_data[31: 0]);
	end
	else if (acc_size === 128) begin
		dmi_write(DMI_DATA3, reg_data[127:96]);
		dmi_write(DMI_DATA2, reg_data[96 :64]);
		dmi_write(DMI_DATA1, reg_data[63 :32]);
		dmi_write(DMI_DATA0, reg_data[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported write_arg width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_read_arg1;
input			acc_size;
output	[MAXLEN-1:0]	dataout;

integer			acc_size;
reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	wdata	= 32'b0;
	dataout	= {MAXLEN{1'b0}};


	if (acc_size === 32) begin
		dmi_read(DMI_DATA1, dataout[31:00]);
	end
	else if (acc_size === 64) begin
		dmi_read(DMI_DATA3, dataout[63:32]);
		dmi_read(DMI_DATA2, dataout[31:00]);
	end
	else if (acc_size === 128) begin
		dmi_read(DMI_DATA7, dataout[127:96]);
		dmi_read(DMI_DATA6, dataout[95 :64]);
		dmi_read(DMI_DATA5, dataout[63 :32]);
		dmi_read(DMI_DATA4, dataout[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported read_arg width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_write_arg1;
input			acc_size;
input	[MAXLEN-1:0]	reg_data;

integer			acc_size;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	if (acc_size === 32) begin
		dmi_write(DMI_DATA1, reg_data[31: 0]);
	end
	else if (acc_size === 64) begin
		dmi_write(DMI_DATA3, reg_data[63:32]);
		dmi_write(DMI_DATA2, reg_data[31: 0]);
	end
	else if (acc_size === 128) begin
		dmi_write(DMI_DATA7, reg_data[127:96]);
		dmi_write(DMI_DATA6, reg_data[96 :64]);
		dmi_write(DMI_DATA5, reg_data[63 :32]);
		dmi_write(DMI_DATA4, reg_data[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported write_arg width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_read_arg2;
input			acc_size;
output [MAXLEN-1:0]	dataout;

integer			acc_size;
reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	wdata	= 32'b0;
	dataout	= {MAXLEN{1'b0}};

	if (acc_size === 32) begin
		dmi_read(DMI_DATA2, dataout[31:00]);
	end
	else if (acc_size === 64) begin
		dmi_read(DMI_DATA5, dataout[63:32]);
		dmi_read(DMI_DATA4, dataout[31:00]);
	end
	else if (acc_size === 128) begin
		dmi_read(DMI_DATA11, dataout[127:96]);
		dmi_read(DMI_DATA10, dataout[95 :64]);
		dmi_read(DMI_DATA9, dataout[63 :32]);
		dmi_read(DMI_DATA8, dataout[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported read_arg width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_write_arg2;
input			acc_size;
input	[MAXLEN-1:0]	reg_data;

integer			acc_size;
reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	if (acc_size === 32) begin
		dmi_write(DMI_DATA2, reg_data[31: 0]);
	end
	else if (acc_size === 64) begin
		dmi_write(DMI_DATA5, reg_data[63:32]);
		dmi_write(DMI_DATA4, reg_data[31: 0]);
	end
	else if (acc_size === 128) begin
		dmi_write(DMI_DATA11, reg_data[127:96]);
		dmi_write(DMI_DATA10, reg_data[96 :64]);
		dmi_write(DMI_DATA9,  reg_data[63 :32]);
		dmi_write(DMI_DATA8,  reg_data[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported write_arg width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_read_sbaddress;
input   integer         abit;
output	[MAXLEN-1:0]	addr;

reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	addr	= {MAXLEN{1'b0}};
	wdata	= 32'h0;
	if (abit <= 32) begin
		dmi_read(DMI_SBADDRESS0, addr[31:00]);
	end
	else if (abit <= 64) begin
		dmi_read(DMI_SBADDRESS1, addr[63:32]);
		dmi_read(DMI_SBADDRESS0, addr[31:00]);
	end
	else if (abit <= 96) begin
		dmi_read(DMI_SBADDRESS2, addr[95 :64]);
		dmi_read(DMI_SBADDRESS1, addr[63 :32]);
		dmi_read(DMI_SBADDRESS0, addr[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Bus address should not exceed 96 bits (width=%0d)", $realtime, abit); #1 $finish; end
	end
end
endtask

task dmi_write_sbaddress;
input	integer         abit;
input	[MAXLEN-1:0]	addr;

reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	if (abit <= 32) begin
		dmi_write(DMI_SBADDRESS0, addr[31:00]);
	end
	else if (abit <= 64) begin
		dmi_write(DMI_SBADDRESS1, addr[63:32]);
		dmi_write(DMI_SBADDRESS0, addr[31:00]);
	end
	else if (abit <= 128) begin
		dmi_write(DMI_SBADDRESS2, addr[95 :64]);
		dmi_write(DMI_SBADDRESS1, addr[63 :32]);
		dmi_write(DMI_SBADDRESS0, addr[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Bus address should not exceed 96 bits (width=%0d)", $realtime, abit); #1 $finish; end
	end
end
endtask

task dmi_read_sbdata;
input			acc_size;
output	[MAXLEN-1:0]	data;

integer			acc_size;
reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	data	= {MAXLEN{1'b0}};
	wdata	= 32'h0;
	if (acc_size === 32) begin
		dmi_read(DMI_SBDATA0, data[31:00]);
	end
	else if (acc_size === 64) begin
		dmi_read(DMI_SBDATA1, data[63:32]);
		dmi_read(DMI_SBDATA0, data[31:00]);
	end
	else if (acc_size === 128) begin
		dmi_read(DMI_SBDATA3, data[127:96]);
		dmi_read(DMI_SBDATA2, data[95 :64]);
		dmi_read(DMI_SBDATA1, data[63 :32]);
		dmi_read(DMI_SBDATA0, data[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported bus data width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_write_sbdata;
input			acc_size;
input	[MAXLEN-1:0]	data;

integer			acc_size;
reg	[31:0]		wdata;
reg	[31:0]		rdata;
reg	[1:0]		state;
begin
	if (acc_size === 32) begin
		dmi_write(DMI_SBDATA0, data[31:00]);
	end
	else if (acc_size === 64) begin
		dmi_write(DMI_SBDATA1, data[63:32]);
		dmi_write(DMI_SBDATA0, data[31:00]);
	end
	else if (acc_size === 128) begin
		dmi_write(DMI_SBDATA3, data[127:96]);
		dmi_write(DMI_SBDATA2, data[95 :64]);
		dmi_write(DMI_SBDATA1, data[63 :32]);
		dmi_write(DMI_SBDATA0, data[31 :00]);
	end
	else begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Unsupported bus data width (width=%0d)", $realtime, acc_size); #1 $finish; end
	end
end
endtask

task dmi_write_serial;
input		channel;
input	[31:0]	data_in;
integer		channel;
reg	[31:0]	din;
reg	[31:0]	dout;
begin
	dmi_read (DMI_SERCS, dout);
	if (channel >= dout[31:28]) begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Non-exist channel %0d is selected (supported channel count: %0d)", $realtime, channel, dout[31:28]); #1 $finish; end
	end
	else begin
		din		= 32'h0;
		din[26:24]	= channel[2:0];
		dmi_write(DMI_SERCS, din);
		dmi_write(DMI_SERRX, data_in);
	end
end
endtask

task dmi_read_serial;
input		channel;
output	[31:0]	data_out;
integer		channel;
reg	[31:0]	din;
reg	[31:0]	dout;
begin
	dmi_read (DMI_SERCS, dout);
	if (channel >= dout[31:28]) begin
		if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Non-exist channel %0d is selected (supported channel count: %0d)", $realtime, channel, dout[31:28]); #1 $finish; end
	end
	else begin
		din		= 32'h0;
		din[26:24]	= channel[2:0];
		dmi_write(DMI_SERCS, din);
		dmi_read(DMI_SERTX, data_out);
	end
end
endtask

task execute_progbuf;
reg [31:0]	dout;
reg [2:0]	pre_state;
reg [2:0]	post_state;
begin
	dmi_read (DMI_ABSTRACTCS, dout);
	pre_state	= dout[10:8];
	dmi_write(DMI_COMMAND,    32'h00241000);
	dmi_read (DMI_ABSTRACTCS, dout);
	post_state	= dout[10:8];
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Execute program buffer: pre_exec_state=%0b, post_exec_state=%0b", $realtime, pre_state, post_state);
end
endtask

task quick_access;
reg [31:0]	dout;
reg [3:0]	pre_state;
reg [3:0]	post_state;
begin
	dmi_read (DMI_ABSTRACTCS, dout);
	pre_state	= dout[10:8];
	dmi_write(DMI_COMMAND, 32'h01000000);
	dmi_read (DMI_ABSTRACTCS, dout);
	post_state	= dout[10:8];
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Quick access: pre_exec_state=%0b, post_exec_state=%0b", $realtime, pre_state, post_state);
end
endtask

task set_absauto_exe;
input [31:0] autoexe_in;
reg   [40:0] scan_out;
begin
	dmi_write(DMI_ABSTRACTAUTO, autoexe_in);
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Set auto execution: abstractauto=%0x", $realtime, autoexe_in);
end
endtask

task clr_absauto_exe;
begin
	dmi_write(DMI_ABSTRACTAUTO, 32'h0);
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:Clear auto execution: abstractauto=0", $realtime);
end
endtask

task check_reset_state;
output	allhavereset;
output	anyhavereset;
reg	[31:0]	rdata;
begin
	dmi_read (DMI_DMSTATUS, rdata);
	allhavereset	= rdata[19];
	anyhavereset	= rdata[18];
	dmi_write(DMI_DMCONTROL, 32'h10000001);
end
endtask

task check_abstractcs_state;
output	[2:0]	state;
reg	[31:0]	din;
reg	[31:0]	dout;
begin
	dmi_read(DMI_ABSTRACTCS, dout);
	state	= dout[10:8];
	if (state != 3'b000) begin
		din		= dout;
		din[10:8]	= 3'b111;
		dmi_write(DMI_ABSTRACTCS, din);
		if (dispmon_DBG_API_0) $display("%0t:DBG_API:abstracts.state=%3b", $realtime, state);
	end
end
endtask

task check_sbcs_state;
output	[2:0]	state;
reg	[31:0]	din;
reg	[31:0]	dout;
begin

	dmi_read(DMI_SBCS, dout);
	state	= dout[14:12];
	if (state != 3'b000) begin
		din		= dout;
		din[14:12]	= 3'b111;
                wait_sbbusy_clr(CHECK_BUSY_TYPE);
		dmi_write(DMI_SBCS, din);
		if (dispmon_DBG_API_0) $display("%0t:DBG_API:sbcs.state=%3b", $realtime, state);
	end
end
endtask

task check_sercs_state;
input	[2:0]	port;
output	[2:0]	state;
reg	[31:0]	din;
reg	[31:0]	dout;
begin
	dmi_read(DMI_SERCS, dout);
	state	= (dout >> (port * 3)) & 32'h7;
	if (state[2] != 1'b0) begin
		din	= dout & (32'h07000000 | (32'h00000004 << (port*3)));
		dmi_write(DMI_SERCS, din);
		if (dispmon_DBG_API_0) $display("%0t:DBG_API:sercs.state=%3b", $realtime, state);
	end
end
endtask

task wait_sbbusy_clr;
input           force_check_busy;
reg             check_busy;
reg             busy;
reg     [31:0]  dout;
integer         retry_cnt;
begin
        check_busy = check_busy_bus;
        if (check_busy === 1'bx) begin
                check_busy = 1'b1;
        end

        if (force_check_busy) begin
                check_busy = 1'b1;
        end

        if (!check_busy) begin
                jtag_delay(CHECK_BUSY_DELAY_CYCLE);
        end
        else begin
	        busy      = 1'b1;
	        retry_cnt = 0;

                while(busy) begin
                        if (retry_cnt > MAX_RETRY) begin
                                if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Timeout waiting for system bus master idle", $realtime); #1 $finish; end
                        end
                        dmi_read(DMI_SBCS, dout);
                        busy   = dout[21];

                        if (retry_cnt == 0 && !busy) begin
                                check_busy = 1'b0;
                        end

                        retry_cnt = retry_cnt + 1;
                end
        end

        check_busy_bus = check_busy;
end
endtask

task wait_execute_finish;
input           access_type;
input           force_check_busy;
reg             check_busy;
reg		busy;
reg	[31:0]	dout;
integer 	retry_cnt;
begin

        if (access_type == BUS_ACCESS) begin
                check_busy = check_busy_bus;
        end
        else begin
                check_busy = check_busy_others;
        end

        if (check_busy === 1'bx) begin
                check_busy = 1'b1;
        end

        if (force_check_busy) begin
                check_busy = 1'b1;
        end

        if (!check_busy) begin
                jtag_delay(CHECK_BUSY_DELAY_CYCLE);
        end
        else begin
                busy      = 1'b1;
                retry_cnt = 0;
                while (busy) begin

	                $display("%0t: DBG TEST3", $realtime);
                        if (retry_cnt > MAX_RETRY) begin
                                if (dispmon_DBG_API_9) begin $display("%0t:DBG_API:ERROR:ERROR:Timeout waiting for abstract command execution", $realtime); #1 $finish; end
                        end
                        dmi_read(DMI_ABSTRACTCS, dout);
                        busy   = dout[12];

                        if (retry_cnt == 0 && !busy) begin
                                check_busy = 1'b0;
                        end

                        retry_cnt  = retry_cnt + 1;
                end
        end

        if (access_type == BUS_ACCESS) begin
                check_busy_bus = check_busy;
        end
        else begin
                check_busy_others = check_busy;
        end
end
endtask

task detect_HALTGROUP_MAX;
output [4:0] haltgroup_max;
reg [4:0] haltgroup;
integer i;
begin
	dbg_select_hart(0);
	for(i=0; i<33; i=i+1) begin
		dmi_dmcs2_write_haltgroup(i);
		dmi_dmcs2_read_haltgroup(haltgroup);
		if (i != haltgroup) begin
			haltgroup_max = i-1;
			i = 33;
		end
	end
	dmi_dmcs2_write_haltgroup(0);
	if (dispmon_DBG_API_0) $display("%0t:DBG_API:HaltGroupMax is :%0d", $realtime, haltgroup_max);
end
endtask

task dmi_dmcs2_write_haltgroup;
reg   [10:7] exttrigger;
input [ 6:2] haltgroup;
reg          hgwrite;
reg          hgselect;
reg   [31:0] tmp;
begin
	exttrigger = 0;
	hgwrite    = 1;
	hgselect   = 0;
	dmi_dmcs2_write(exttrigger, haltgroup, hgwrite, hgselect);
end
endtask

task dmi_dmcs2_write;
input [10:7] exttrigger;
input [ 6:2] haltgroup;
input        hgwrite;
input        hgselect;
reg   [31:0] tmp;
begin
	tmp = { 21'h0, exttrigger, haltgroup, hgwrite, hgselect} ;
	dmi_write(DMI_DMCS2, tmp);
end
endtask

task dmi_dmcs2_read_haltgroup;
reg    [10:7] exttrigger;
output [ 6:2] haltgroup;
reg           hgselect;
begin
	dmi_dmcs2_read(exttrigger, haltgroup, hgselect);
end
endtask

task dmi_dmcs2_read;
output [10:7] exttrigger;
output [ 6:2] haltgroup;
output        hgselect;
reg    [31:0] tmp;
begin
	dmi_read(DMI_DMCS2, tmp);
	exttrigger = tmp[10:7];
	haltgroup  = tmp[ 6:2];
	hgselect   = tmp[0];
end
endtask

task dbg_set_word_mem;
input [63:0] addr;
input [63:0] data;
reg   [31:0] tmp;
begin

	dmi_write_arg0(xlen, data);
	dmi_write_arg1(xlen, addr);

        tmp = {CMD_QUICK_MEM, 1'h0, 3'h2, 1'h0, 2'h0, 1'h1, 16'h0};
	dmi_write(DMI_COMMAND, tmp);
        wait_execute_finish(BUS_ACCESS, CHECK_BUSY_TYPE);
end
endtask

function [31:0] urandom32;
input [31:0]    seed;
begin
        urandom32 = {$random(seed)};
end
endfunction

function [63:0] urandom64;
input [31:0]    seed;
begin
        urandom64 = {urandom32(seed), urandom32(seed)};
end
endfunction

function [31:0] urandom32_range;
input [31:0]    arg0;
input [31:0]    arg1;
input [31:0]    seed;
reg [31:0]      min;
reg [31:0]      max;
begin
        min = (arg0 < arg1) ? arg0 : arg1;
        max = (arg0 > arg1) ? arg0 : arg1;
        urandom32_range = (urandom32(seed) % (max - min + 1)) + min;
end
endfunction

initial begin
        fg_hart      = 0;
        bg_hart_sel  = 1'b0;
end

