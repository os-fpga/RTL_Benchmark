// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include        "jtag_dmi_seq_lib.v"
`include        "debug_seq_lib.v"

`ifdef NDS_JTAG_TCK_KHZ
localparam JTAG_TCK_KHZ = `NDS_JTAG_TCK_KHZ;
`else
localparam JTAG_TCK_KHZ = 10000;
`endif

`ifdef NDS_JTAG_IDLE_CYCLE
localparam JTAG_IDLE_CYCLE = `NDS_JTAG_IDLE_CYCLE;
`else
localparam JTAG_IDLE_CYCLE = 1000;
`endif

`ifdef DM_TAP_ID
localparam DM_TAP_ID = `DM_TAP_ID;
`else
        `ifdef PLATFORM_DM_TAP_ID
        localparam DM_TAP_ID = `PLATFORM_DM_TAP_ID;
        `else
        localparam DM_TAP_ID = 0;
        `endif
`endif

integer         test_tap  = DM_TAP_ID;

`ifdef NDS_AE350_MULTI_HART
	`ifdef NDS_HART1_RUN
        localparam      SUPPORTED_HART = 1;
	`elsif NDS_HART2_RUN
        localparam      SUPPORTED_HART = 2;
	`elsif NDS_HART3_RUN
        localparam      SUPPORTED_HART = 3;
	`else
        localparam      SUPPORTED_HART = 0;
	`endif
`else
        localparam      SUPPORTED_HART = 0;
`endif

`ifdef NDS_L2C_COHERENCE_PORT
localparam NDS_L2_COHERENCE = `NDS_L2C_COHERENCE_PORT;
`else
localparam NDS_L2_COHERENCE = "no";
`endif
integer test_hart = (NDS_L2_COHERENCE == "yes") ? SUPPORTED_HART : 0;

reg     [4:0]   program_size;
reg     [4:0]   datareg_count;
reg     [15:0]  autoexec_progbuf;
reg     [11:0]  autoexec_datareg;
reg             sysbus_access;
reg     [2:0]   sysbus_version;
reg     [6:0]   sysbus_addr_width;
reg     [4:0]   sysbus_width;
reg     [3:0]   serial_count;
reg             hart_array;
reg             impebreak;

localparam      TEST_BUFLEN     = 128*8;

localparam          M_MODE_CSR_CNT = 2;
localparam          U_MODE_CSR_CNT = 1;
localparam          S_MODE_CSR_CNT = 2;
localparam          TEST_ACCESS_CSR_CNT = M_MODE_CSR_CNT + U_MODE_CSR_CNT + S_MODE_CSR_CNT;

reg [11:0]  M_MODE_CSR_LIST [M_MODE_CSR_CNT-1:0];
reg [11:0]  U_MODE_CSR_LIST [U_MODE_CSR_CNT-1:0];
reg [11:0]  S_MODE_CSR_LIST [S_MODE_CSR_CNT-1:0];

reg [11:0]  TEST_ACCESS_CSR_LIST [TEST_ACCESS_CSR_CNT-1:0];
integer i_m, i_l;



reg     flg_dm_busy     = 1'b0;
reg     u_mode_support    = 1'b0;
reg     s_mode_support    = 1'b0;

reg dispmon_ext_debugger_0;
reg dispmon_ext_debugger_9;
initial begin
        dispmon_ext_debugger_0 = 1'b1;
        dispmon_ext_debugger_9 = 1'b1;

        if ($test$plusargs("mon+ext_debugger+0+off")) dispmon_ext_debugger_0 = 1'b0;
        if ($test$plusargs("mon+ext_debugger+9+off")) dispmon_ext_debugger_9 = 1'b0;
end

reg [31:0]      rnd_seed;
initial begin
        if ($value$plusargs("seed=%d", rnd_seed))
                rnd_seed = rnd_seed ^ 32'h8f385027;
        else
                rnd_seed = 32'h8f385027;
end

initial begin
    M_MODE_CSR_LIST [0] = REG_MSTATUS;
    M_MODE_CSR_LIST [1] = REG_MSCRATCH;

    U_MODE_CSR_LIST [0] = REG_USTATUS;

    S_MODE_CSR_LIST [0] = REG_SATP;
    S_MODE_CSR_LIST [1] = REG_SSTATUS;

    for(i_l=0;i_l<M_MODE_CSR_CNT;i_l=i_l+1) begin
        TEST_ACCESS_CSR_LIST[i_l] = M_MODE_CSR_LIST[i_l];
    end
    for(i_l=0;i_l<U_MODE_CSR_CNT;i_l=i_l+1) begin
        TEST_ACCESS_CSR_LIST[i_l+M_MODE_CSR_CNT] = U_MODE_CSR_LIST[i_l];
    end
    for(i_l=0;i_l<S_MODE_CSR_CNT;i_l=i_l+1) begin
        TEST_ACCESS_CSR_LIST[i_l+M_MODE_CSR_CNT+U_MODE_CSR_CNT] = S_MODE_CSR_LIST[i_l];
    end
end

reg [31:0] prog_ready_magic_number;

initial begin
	prog_ready_magic_number = 32'h89abcdef;
        wait(`NDS_SIM_CONTROL.temp7 === prog_ready_magic_number);
        init_target(JTAG_TCK_KHZ, JTAG_IDLE_CYCLE);
        jtag_select_tap(test_tap);

        check_dtmcontrol;

        init_dm;

        check_dm_support(program_size, datareg_count, autoexec_progbuf, autoexec_datareg,
                         sysbus_access, sysbus_version, sysbus_addr_width, sysbus_width,
                         serial_count, hart_array, impebreak);
        dbg_select_hart(test_hart);

        detect_xlen;
        detect_flen;

        test_check_progbuff_size(program_size);

	dbg_break;

        chk_privilege;

        $display("Test access CSR_CNT = %d", TEST_ACCESS_CSR_CNT);
        for(i_m=0;i_m<TEST_ACCESS_CSR_CNT;i_m=i_m+1) begin
            test_seq_csr_access(TEST_ACCESS_CSR_LIST[i_m]);
        end

        test_seq_gpr_access(GPR_A0);
        if (flen > 0) begin
                test_seq_fpr_access(FPR_FA0);
        end

        test_seq_step;

        test_seq_trigger (64'h80);

        if (program_size >= 8) begin
                test_seq_byte_access (TEST_MEM_BASE+1, 0, 0);
                test_seq_hword_access(TEST_MEM_BASE+2, 0, 0);
                test_seq_word_access (TEST_MEM_BASE+4, 0, 0);
                if (xlen >= 64) begin
                        test_seq_dword_access(TEST_MEM_BASE, 0, 0);
                end
                if (autoexec_datareg[0]) begin
                        test_seq_postincr_access(TEST_MEM_BASE, 128, xlen, xlen, 1'b0);

                        test_seq_auto_execution;
                end
        end

        dbg_continue;

        if (sysbus_access) begin
                if (sysbus_width[0]) begin
                        test_seq_byte_access (TEST_MEM_BASE+1, 1, 0);
                end
                if (sysbus_width[1]) begin
                        test_seq_hword_access(TEST_MEM_BASE+2, 1, 0);
                end
                if (sysbus_width[2]) begin
                        test_seq_word_access (TEST_MEM_BASE+4, 1, 0);
                end
                if (sysbus_width[3]) begin
                        test_seq_dword_access(TEST_MEM_BASE, 1, 0);
                end
                casez (sysbus_width)
                        5'b1????:       test_seq_postincr_access(TEST_MEM_BASE, 128, sysbus_addr_width, 128, 1'b1);
                        5'b01???:       test_seq_postincr_access(TEST_MEM_BASE, 128, sysbus_addr_width, 64,  1'b1);
                        5'b001??:       test_seq_postincr_access(TEST_MEM_BASE, 128, sysbus_addr_width, 32,  1'b1);
                        5'b0001?:       test_seq_postincr_access(TEST_MEM_BASE, 128, sysbus_addr_width, 16,  1'b1);
                        5'b00001:       test_seq_postincr_access(TEST_MEM_BASE, 128, sysbus_addr_width, 8,   1'b1);
                endcase

                test_systembus_error;
        end

        if (program_size >= 8) begin
                test_seq_byte_access (TEST_MEM_BASE+1, 0, 1);
                test_seq_hword_access(TEST_MEM_BASE+2, 0, 1);
                test_seq_word_access (TEST_MEM_BASE+4, 0, 1);
                if (xlen >= 64) begin
                        test_seq_dword_access(TEST_MEM_BASE, 0, 1);
                end
        end

        $display("%0t:ext_debugger:Start test halt-on-reset function", $realtime);
        test_seq_halt_on_reset;

        dbg_break;


        dbg_continue;

        deinit_target;

        dbg_exit(DBG_PASS);
end

task chk_privilege;
reg     [15:0]  addr;
reg     [MAXLEN-1:0]    rdata;
begin

        addr    = {4'h0, REG_MISA};
        dbg_get_csr(addr, rdata, CMD_NOPOSTEXEC);
        u_mode_support = rdata[13];
        s_mode_support = rdata[18];
end
endtask

task test_check_progbuff_size;
input   [4:0]   size;
reg     [4:0]   expect_size;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test check program buffer size", $realtime);

`ifdef PROGBUF_SIZE
        expect_size = `PROGBUF_SIZE;
`else
        `ifdef PLATFORM_PLDM_PROGBUF_SIZE
                expect_size = `PLATFORM_PLDM_PROGBUF_SIZE;
        `else
                `ifdef AE250_PLDM_PROGBUF_SUPPORT
                        expect_size = 8;
                `else
                        expect_size = 2;
                `endif
        `endif
`endif

        if (size != expect_size) begin
                if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:program buffer size is %0x, but expect size should be %0x", $realtime, size, expect_size); #1 $finish; end
                dbg_exit(DBG_FAIL);
        end
end
endtask

task test_seq_step;
reg [MAXLEN-1:0]        pre_pc;
reg [MAXLEN-1:0]        cur_pc;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test single step", $realtime);
        dbg_get_current_pc(pre_pc);
        dbg_step(0);
        dbg_get_current_pc(cur_pc);

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:step: pc:%0x->%0x", $realtime, pre_pc, cur_pc);
end
endtask

task test_seq_trigger;
input   [MAXLEN-1:0]    addr;
reg     [MAXLEN-1:0]    addr;
reg     [MAXLEN-1:0]    trig_addr;
reg     [MAXLEN-1:0]    resume_pc;
integer                 trig_count;
integer                 trig_id;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test trigger", $realtime);
        dbg_trigger_count(trig_count);
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Trigger Count = %0d", $realtime, trig_count);
        if (trig_count != 0) begin
                trig_id = $random % trig_count;
                dbg_add_breakpoint(trig_id, addr);
                dbg_get_current_pc(resume_pc);
                dbg_set_return_pc(addr);
                dbg_continue;
                dbg_wait;
                dbg_remove_breakpoint(trig_id);
                dbg_get_current_pc(trig_addr);
                dbg_set_return_pc(resume_pc);

                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:breakpoint: expect_pc=%0x,trigger_pc=%0x", $realtime, addr, trig_addr);

                if ((!flg_dm_busy) && (addr != trig_addr)) begin
                        dbg_exit(DBG_FAIL);
                end
        end
        else begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:No trigger support (trigger count=%0d)", $realtime, trig_count);
        end
end
endtask

task test_seq_byte_access;
input   [MAXLEN-1:0]    addr;
input                   direct_access;
input                   quick_access;
reg     [MAXLEN-1:0]    addr;
reg     [7:0]           data[0:2];
begin
        if(direct_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test byte access by direct systembus", $realtime);
        end else if(quick_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test byte access by quick access", $realtime);
        end else begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test byte access by command program buffer", $realtime);
        end

        data[1] = urandom32(rnd_seed) & 32'h000000ff;
        dbg_load_byte   (addr, data[0], direct_access, quick_access);
        dbg_store_byte  (addr, data[1], direct_access, quick_access);
        if (!direct_access) begin
                dmi_write_arg0  (xlen, 0);
        end
        dbg_load_byte   (addr, data[2], direct_access, quick_access);

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:load/store_byte: R:%0x->W:%0x->R:%0x @%0x (direct:%b,quick:%b)", $realtime, data[0], data[1], data[2], addr, direct_access, quick_access);

        if (!flg_dm_busy) begin
                if (data[2] !== data[1]) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_byte result is not expected", $realtime); #1 $finish; end
                end
        end
        else begin
                if (data[2] !== 8'h0) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_byte result is not expected", $realtime); #1 $finish; end
                end
        end
end
endtask

task test_seq_hword_access;
input   [MAXLEN-1:0]    addr;
input                   direct_access;
input                   quick_access;
reg     [MAXLEN-1:0]    addr;
reg     [15:0]          data[0:2];
begin
        if(direct_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test halfword access by direct systembus", $realtime);
        end else if(quick_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test halfword access by quick access", $realtime);
        end else begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test halfword access by command program buffer", $realtime);
        end

        data[1] = urandom32(rnd_seed) & 32'h0000ffff;
        dbg_load_hword  (addr, data[0], direct_access, quick_access);
        dbg_store_hword (addr, data[1], direct_access, quick_access);
        if (!direct_access) begin
                dmi_write_arg0  (xlen, 0);
        end

        dbg_load_hword  (addr, data[2], direct_access, quick_access);

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:load/store_hword: R:%0x->W:%0x->R:%0x @%0x (direct:%b,quick:%b)", $realtime, data[0], data[1], data[2], addr, direct_access, quick_access);

        if (!flg_dm_busy) begin
                if (data[2] !== data[1]) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_hword result is not expected", $realtime); #1 $finish; end
                end
        end
        else begin
                if (data[2] !== 16'h0) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_hword result is not expected", $realtime); #1 $finish; end
                end
        end
end
endtask

task test_seq_word_access;
input   [MAXLEN-1:0]    addr;
input                   direct_access;
input                   quick_access;
reg     [MAXLEN-1:0]    addr;
reg     [31:0]          data[0:2];
begin
        if(direct_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test word access by direct systembus", $realtime);
        end else if(quick_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test word access by quick access", $realtime);
        end else begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test word access by command program buffer", $realtime);
        end

        data[1] = urandom32(rnd_seed) & 32'hffffffff;
        dbg_load_word  (addr, data[0], direct_access, quick_access);
        dbg_store_word (addr, data[1], direct_access, quick_access);
        if (!direct_access) begin
                dmi_write_arg0  (xlen, 0);
        end

        dbg_load_word  (addr, data[2], direct_access, quick_access);

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:load/store_word: R:%0x->W:%0x->R:%0x @%0x (direct:%b,quick:%b)", $realtime, data[0], data[1], data[2], addr, direct_access, quick_access);

        if (!flg_dm_busy) begin
                if (data[2] !== data[1]) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_word result is not expected", $realtime); #1 $finish; end
                end
        end
        else begin
                if (data[2] !== 32'h0) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_word result is not expected", $realtime); #1 $finish; end
                end
        end

end
endtask

task test_seq_dword_access;
input   [MAXLEN-1:0]    addr;
input                   direct_access;
input                   quick_access;
reg     [MAXLEN-1:0]    addr;
reg     [63:0]          data[0:2];
reg     [63:0]          refdata;
begin
        if(direct_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test double word access by direct systembus", $realtime);
        end else if(quick_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test double word access by quick access", $realtime);
        end else begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test double word access by command program buffer", $realtime);
        end

        data[1] = urandom64(rnd_seed) & 64'hffffffff_ffffffff;
        dbg_load_dword  (addr, data[0], direct_access, quick_access);
        dbg_store_dword (addr, data[1], direct_access, quick_access);
        if (!direct_access) begin
                dmi_write_arg0  (xlen, 0);
        end
        dbg_load_dword  (addr, data[2], direct_access, quick_access);

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:load/store_dword: R:%0x->W:%0x->R:%0x @%0x (direct:%b,quick:%b)", $realtime, data[0], data[1], data[2], addr, direct_access, quick_access);

        if (!flg_dm_busy) begin
                if (data[2] !== data[1]) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_dword result is not expected", $realtime); #1 $finish; end
                end
        end
        else begin
                if (data[2] !== 64'h0) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: load/store_dword result is not expected", $realtime); #1 $finish; end
                end
        end

end
endtask

task test_seq_csr_access;
input   [11:0]          csrid;
reg     [11:0]          csrid;
reg     [15:0]          addr;
reg     [15:0]          gpr_addr;
reg     [MAXLEN-1:0]    rdata;
reg     [MAXLEN-1:0]    data[0:2];
reg     [MAXLEN-1:0]    data_temp[0:1];
reg     [MAXLEN-1:0]    cmpmask;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test access CSR: %x", $realtime, csrid);

        gpr_addr    = {8'h10, 3'h0, 5'h8};
        addr    = {4'h0, csrid};

        cmpmask = ({{(MAXLEN-1){1'b0}}, 1'b1} << xlen) - {{(MAXLEN-1){1'b0}}, 1'b1};
        data[1] = (urandom64(rnd_seed)) & cmpmask;

        dbg_get_gpr(gpr_addr, data_temp[0], CMD_NOPOSTEXEC);

        dbg_get_csr(addr, rdata, CMD_NOPOSTEXEC);
        chk_access_csr(csrid);
        data[0] = rdata;
        dbg_set_csr(addr, data[1], CMD_NOPOSTEXEC);
        chk_access_csr(csrid);
        dmi_write_arg0(xlen, 0);
        dbg_get_csr(addr, rdata, CMD_NOPOSTEXEC);
        chk_access_csr(csrid);
        data[2] = rdata;

        dbg_get_gpr(gpr_addr, data_temp[1], CMD_NOPOSTEXEC);

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:CSR access: R:%0x->W:%0x->R:%0x @%0x", $realtime, data[0], data[1], data[2], addr);

        chk_seq_csr_access(csrid, data[1], data[2], data_temp[0], data_temp[1]);

        dbg_set_csr(addr, data[0], CMD_NOPOSTEXEC);
        chk_access_csr(csrid);
        dmi_write_arg0(xlen, 0);
end
endtask

task chk_seq_csr_access;
input   [11:0]  csrid;
input   [MAXLEN-1:0]    wdata;
input   [MAXLEN-1:0]    rdata;
input   [MAXLEN-1:0]    gpr_data0;
input   [MAXLEN-1:0]    gpr_data1;
reg     [MAXLEN-1:0]    check_mask;
begin

        check_mask = (csrid==REG_MSCRATCH) ? {MAXLEN{1'b1}} : {MAXLEN{1'b0}};

        if (gpr_data0 !== gpr_data1) begin
                if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: gpr s0 after csr r/w is not expected", $realtime); #1 $finish; end
        end

        if (!flg_dm_busy) begin
                if (((rdata^wdata) & check_mask) > 0) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: read/write_csr result is not expected", $realtime); #1 $finish; end
                end
        end
        else begin
                if (rdata !== {MAXLEN{1'b0}}) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: read/write_csr result is not expected", $realtime); #1 $finish; end
                end
        end

end
endtask

task chk_access_csr;
input   [11:0]  csrid;
reg     [31:0]  dmi_abstractcs;
reg     [ 2:0]  dmi_cmderr;
reg             access_illegal_csr;
integer         i_t;
begin

        access_illegal_csr = 0;

        for(i_t=0;i_t<U_MODE_CSR_CNT;i_t=i_t+1) begin
            if(csrid==U_MODE_CSR_LIST[i_t])
                access_illegal_csr = ~u_mode_support;
        end
        for(i_t=0;i_t<S_MODE_CSR_CNT;i_t=i_t+1) begin
            if(csrid==S_MODE_CSR_LIST[i_t])
                access_illegal_csr = ~s_mode_support;
        end

        dmi_read(DMI_ABSTRACTCS, dmi_abstractcs);
        dmi_cmderr = dmi_abstractcs[10: 8];
        if (access_illegal_csr & (dmi_cmderr!==3)) begin
                if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: r/w illegal csr without raising exception", $realtime); #1 $finish; end
        end
        else begin
                dmi_write(DMI_ABSTRACTCS, dmi_abstractcs);
        end
end
endtask

task test_seq_gpr_access;
input   [4:0]           gprid;
reg     [4:0]           gprid;
reg     [15:0]          addr;
reg     [MAXLEN-1:0]    rdata;
reg     [MAXLEN-1:0]    data[0:2];
reg     [MAXLEN-1:0]    cmpmask;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test access GPR: %x", $realtime, gprid);
        addr    = {8'h10, 3'h0, gprid};

        cmpmask = ({{(MAXLEN-1){1'b0}}, 1'b1} << xlen) - {{(MAXLEN-1){1'b0}}, 1'b1};
        data[1] = (urandom64(rnd_seed)) & cmpmask;

        dbg_get_gpr(addr, rdata, CMD_NOPOSTEXEC);
        data[0] = rdata;
        dbg_set_gpr(addr, data[1], CMD_NOPOSTEXEC);
        dmi_write_arg0(xlen, 0);
        dbg_get_gpr(addr, rdata, CMD_NOPOSTEXEC);
        data[2] = rdata;

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:GPR access: R:%0x->W:%0x->R:%0x @%0x", $realtime, data[0], data[1], data[2], addr);

        if (!flg_dm_busy) begin
                if (data[2] !== data[1]) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: read/write_gpr result is not expected", $realtime); #1 $finish; end
                end
        end
        else begin
                if (data[2] !== {MAXLEN{1'b0}}) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: read/write_gpr result is not expected", $realtime); #1 $finish; end
                end
        end
end
endtask

task test_seq_fpr_access;
input   [4:0]           fprid;
reg     [4:0]           fprid;
reg     [15:0]          addr;
reg     [MAXLEN-1:0]    rdata;
reg     [MAXLEN-1:0]    data[0:2];
reg     [MAXLEN-1:0]    cmpmask;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test access FPR: %x", $realtime, fprid);
        addr    = {8'h10, 3'h0, fprid};

        dbg_setb_csr(REG_MSTATUS, 64'h00000000_00002000);

        dbg_set_fpr(addr, 0, CMD_NOPOSTEXEC);

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:test_seq_fpr_access(addr=0x%x)", $realtime, addr);

        cmpmask = ({{(MAXLEN-1){1'b0}}, 1'b1} << flen) - {{(MAXLEN-1){1'b0}}, 1'b1};
        data[1] = (urandom64(rnd_seed)) & cmpmask;

        dbg_get_fpr(addr, rdata, CMD_NOPOSTEXEC);
        data[0] = rdata;
        dbg_set_fpr(addr, data[1], CMD_NOPOSTEXEC);
        dmi_write_arg0(flen, 0);
        dbg_get_fpr(addr, rdata, CMD_NOPOSTEXEC);
        data[2] = rdata;

        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:FPR access: R:%0x->W:%0x->R:%0x @%0x", $realtime, data[0], data[1], data[2], addr);

        if (!flg_dm_busy) begin
                if (data[2] !== data[1]) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: read/write_fpr result is not expected", $realtime); #1 $finish; end
                end
        end
        else begin
                if (data[2] !== {MAXLEN{1'b0}}) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:ERROR: read/write_fpr result is not expected", $realtime); #1 $finish; end
                end
        end
end
endtask

task test_seq_auto_execution;
reg     [15:0]          regno;
reg     [31:0]          command;
reg     [31:0]          inst_store;
reg     [MAXLEN-1:0]    wdata;
reg     [MAXLEN-1:0]    rdata;
reg     [MAXLEN-1:0]    cmpmask;
reg     [2:0]           state;
integer                 iteration;
integer                 it;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test abstract command auto execution", $realtime);

        iteration       = 10;
        regno           = 16'h1000 | {11'b0, GPR_S0};

        command         = _cmd(CMD_ACCESS_REG, _cmd_size(xlen), CMD_POSTEXEC, CMD_ABSCMD, CMD_WRITE, regno);
        inst_store      = (xlen>=64)? 32'h0c803023 : 32'h0c802023;

        cmpmask = ({{(MAXLEN-1){1'b0}}, 1'b1} << xlen) - {{(MAXLEN-1){1'b0}}, 1'b1};

        dmi_write(DMI_PROGBUF0, 32'h00100073);
        dmi_write(DMI_PROGBUF1, 32'hffffffff);
        dmi_write(DMI_COMMAND,  command);
        wait_execute_finish(!BUS_ACCESS, MAYBE_CHECK_BUSY);

        dmi_write(DMI_PROGBUF0, 32'h00140413);
        dmi_write(DMI_PROGBUF1, inst_store);
        dmi_write(DMI_PROGBUF2, 32'h0ff0000f);
        dmi_write(DMI_PROGBUF3, 32'h7b202473);
        dmi_write(DMI_PROGBUF4, 32'h00100073);
        dmi_write(DMI_PROGBUF5, 32'hffffffff);

        set_absauto_exe(32'h00000001);

        wdata   = urandom64(rnd_seed) & cmpmask;
        dmi_write_arg0(xlen, wdata);

        for (it=0; it<iteration; it=it+1) begin
                wait_execute_finish(BUS_ACCESS, MAYBE_CHECK_BUSY);
                dmi_read_arg0(xlen, rdata);
                if (rdata != (wdata + it + 1)) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:Auto execution result is unexpected (expect 0x%0x, get 0x%0x, iterattion=%0d)", $realtime, (wdata + it + 1), rdata, it); #1 $finish; end
                end
        end

        wait_execute_finish(BUS_ACCESS, MAYBE_CHECK_BUSY);
        clr_absauto_exe;

        check_abstractcs_state(state);
end
endtask

task test_seq_postincr_access;
input   [MAXLEN-1:0]            base_addr;
input   [9:0]                   size;
input   [7:0]                   alen;
input   [7:0]                   dlen;
input                           direct_access;
reg     [TEST_BUFLEN-1:0]       rbuffer;
reg     [TEST_BUFLEN-1:0]       wbuffer;
integer                         it;
begin
        if(direct_access) begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test post increment access by direct systembus", $realtime);
        end else begin
                if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test post increment access by program buffer", $realtime);
        end

        rbuffer = {(TEST_BUFLEN){1'b0}};
        wbuffer = {(TEST_BUFLEN){1'b0}};

        if (((size << 3) > TEST_BUFLEN) || ((size << 3) > BUFLEN)) begin
                if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:Memory postincr access size is larger than buffer size", $realtime); #1 $finish; end
        end

        if (((xlen==64) && (size[2:0]!=3'b000)) || ((xlen==32) && (size[1:0]!=2'b00))) begin
                if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:Memory postincr access size should be aligned to XLEN", $realtime); #1 $finish; end
        end

        if (((xlen==64) && (base_addr[2:0]!=3'b000)) || ((xlen==32) && (base_addr[1:0]!=2'b00))) begin
                if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:Memory postincr access base should be aligned to XLEN", $realtime); #1 $finish; end
        end

        for (it=0; it<size; it=it+4) begin
                wbuffer = wbuffer | ({{(TEST_BUFLEN-32){1'b0}}, urandom32(rnd_seed)} << (it << 3));
        end

        dbg_post_incr_store(base_addr, wbuffer, size, alen, dlen, direct_access);
        dbg_post_incr_load (base_addr, rbuffer, size, alen, dlen, direct_access);

        if (rbuffer != wbuffer) begin
                if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR:Memory postincr load/store failed (rbuffer=0x%0x, wbuffer=0x%0x, diff=0x%0x, direct=%0b)", $realtime, rbuffer, wbuffer, rbuffer^wbuffer, direct_access); #1 $finish; end
        end
end
endtask

task test_seq_halt_on_reset;
reg     [31:0]  dmi_dmstatus;
reg             anyhalted;
reg             anyhavereset;
reg             halt_on_reset_success;
integer         count;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test halt on reset", $realtime);

        dbg_setresethaltreq;

        dbg_assert_ndmreset;
        dbg_deassert_ndmreset;

        halt_on_reset_success = 1'b0;
        count = 0;
        while (!halt_on_reset_success) begin
                if (count > 200) begin
                        if (dispmon_ext_debugger_9) begin $display("%0t:ext_debugger:ERROR: halt_on_reset failed (anyhalted=0x%0x, anyhavereset=0x%0x)", $realtime, anyhalted, anyhavereset); #1 $finish; end
                end

                dmi_read(DMI_DMSTATUS, dmi_dmstatus);
                anyhalted    = dmi_dmstatus[8];
                anyhavereset = dmi_dmstatus[18];
                halt_on_reset_success = anyhalted & anyhavereset;

                count = count +1;
        end

        dbg_clrresethaltreq;

end

endtask


task test_systembus_error;
reg [31:0] tmp;
reg [14:12] sberror;
localparam SBERROR_NOERROR  = 3'h0;
localparam SBERROR_BADADDR  = 3'h2;
localparam NONEXSIST_ADDR   = 32'hFFFF_FFF4;
localparam BMC_CONTROL_ADDR = 32'hE000_0014;
begin
        if (dispmon_ext_debugger_0) $display("%0t:ext_debugger:Test access error by system bus", $realtime);

`ifdef AE250_PLDM_SYS_BUS_ACCESS
        dbg_store_word (BMC_CONTROL_ADDR, 32'h1, 0, 1);
`endif

        dbg_store_word (NONEXSIST_ADDR, 32'h1, 1, 0);

        dmi_read(DMI_SBCS, tmp);
        sberror = tmp[14:12];

        if (sberror != SBERROR_BADADDR && dispmon_ext_debugger_9) begin
                $display("%0t:ext_debugger:ERROR: @sberror should be 0x%x, but current value is : 0x%x", $realtime, SBERROR_BADADDR, sberror);
                #1 $finish;
        end

        dmi_write(DMI_SBCS, tmp);

        dmi_read(DMI_SBCS, tmp);
        sberror = tmp[14:12];

        if (sberror != SBERROR_NOERROR && dispmon_ext_debugger_9) begin
                $display("%0t:ext_debugger:ERROR: #sberror should be 0x%x, but current value is : 0x%x", $realtime, SBERROR_NOERROR, sberror);
                #100 $finish;
        end
end
endtask
