// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale 1ns/1ps


program mem_checker(clk, ram_cs, ram_we_en, ram_we, ram_addr, ram_wdata, ram_rdata, flg_fail, flg_finish);
parameter RAM_AW = 11;
parameter RAM_CSW = 1;
parameter RAM_WEW = 8;
parameter RAM_WUNIT = 8;
parameter RAM_ECW = 0;
parameter RAM_NWE_UEC = 1;
parameter RAM_UNIT_WRITE_SUPPORT = 1;

parameter RAM_W2R_CYCLE = 0;
parameter RAM_CLK2Q_DELAY = 0.5;
parameter RAM_HOLD_DELAY = 0.3;
parameter RAM_HOLD_CYCLE = 3;

localparam RAM_EAW    = RAM_AW;
localparam RAM_DW     = RAM_ECW + RAM_WEW * RAM_WUNIT;
localparam RAM_EC_LSB = RAM_WEW * RAM_WUNIT;
localparam RAM_UECW   = (RAM_ECW > 0)? RAM_ECW /(RAM_WEW/RAM_NWE_UEC) : 1;

localparam DCLK_DELAY   = RAM_HOLD_DELAY;
localparam SAMPLE_DELAY = RAM_CLK2Q_DELAY - DCLK_DELAY;
localparam W2R_CYCLE    = RAM_W2R_CYCLE;

input                clk;
output [RAM_CSW-1:0] ram_cs;
output               ram_we_en;
output [RAM_WEW-1:0] ram_we;
output  [RAM_AW-1:0] ram_addr;
output  [RAM_DW-1:0] ram_wdata;
input   [RAM_DW-1:0] ram_rdata;

output bit      flg_fail;
output bit      flg_finish;

wire    dclk;

typedef enum {
        READ_WRITE_TEST,
        BIT_TOGGLE_TEST,
        UNIT_WRITE_TEST,
        DOUT_HOLD_TEST
} subtest_t;

event           e_fail;
event           e_pass;

bit [RAM_CSW-1:0]       _ram_cs;
bit [RAM_WEW-1:0]       _ram_we;
bit [RAM_EAW-1:0]       _ram_addr;
bit  [RAM_DW-1:0]       _ram_wdata;

typedef struct packed {
        bit [RAM_EAW-1:0]       addr;
        bit  [RAM_DW-1:0]       data;
} mem_entry_t;

typedef struct packed {
        bit [RAM_EAW-1:0]       addr;
        bit  [RAM_DW-1:0]       wdata;
        bit [RAM_WEW-1:0]       uwe;
} mem_wr_cmd_t;

bit [RAM_EAW-1:0]       rnd_base_addr;

mem_entry_t             vec_item[$];
mem_wr_cmd_t            rnd_wr_cmd;

subtest_t          fail_subtest;
bit [RAM_AW-1:0]   fail_addr;
bit [RAM_DW-1:0]   fail_rdata;
bit [RAM_DW-1:0]   fail_refdata;

assign #(DCLK_DELAY) dclk = clk;

reg dispmon_TEST_MEM_MACRO_0;
reg dispmon_TEST_MEM_MACRO_9;
initial begin
	dispmon_TEST_MEM_MACRO_0 = 1'b1;
	dispmon_TEST_MEM_MACRO_9 = 1'b1;

	if ($test$plusargs("mon+TEST_MEM_MACRO+0+off")) dispmon_TEST_MEM_MACRO_0 = 1'b0;
	if ($test$plusargs("mon+TEST_MEM_MACRO+9+off")) dispmon_TEST_MEM_MACRO_9 = 1'b0;
end

initial begin
        force_mem_inputs();
        void'(std::randomize(rnd_base_addr));
        vec_item.push_back('{rnd_base_addr, {RAM_DW{1'b0}}});

        for (int _bit=0; _bit<RAM_EAW; _bit+=1) begin
                vec_item.push_back('{vec_item[0].addr ^ ({{(RAM_EAW-1){1'b0}}, 1'b1} << _bit), {RAM_DW{1'b0}}});
        end

        reset_intf();

        @(posedge dclk);

        for (int _vit=0; _vit<vec_item.size(); _vit+=1) begin
                _ram_cs    = {RAM_CSW{1'b1}};
                _ram_we    = {RAM_WEW{1'b1}};
                _ram_addr  = vec_item[_vit].addr;
                _ram_wdata = {RAM_DW{1'b0}};
                @(posedge dclk);
                vec_item[_vit].data = {RAM_DW{1'b0}};
                reset_intf();
        end

        vec_item.shuffle();
        for (int _vit=0; _vit<vec_item.size(); _vit+=1) begin
                void'(std::randomize(rnd_wr_cmd));
                rnd_wr_cmd.addr = vec_item[_vit].addr;
                rnd_wr_cmd.uwe  = {RAM_DW{1'b1}};
                _ram_cs    = {RAM_CSW{1'b1}};
                _ram_we    = rnd_wr_cmd.uwe;
                _ram_addr  = rnd_wr_cmd.addr;
                _ram_wdata = rnd_wr_cmd.wdata;
                @(posedge dclk);
                vec_item[_vit].data = (vec_item[_vit].data & ~uwe2we(rnd_wr_cmd.uwe)) | (rnd_wr_cmd.wdata & uwe2we(rnd_wr_cmd.uwe));
                reset_intf();
        end
        vec_item.shuffle();
        for (int _vit=0; _vit<vec_item.size(); _vit+=1) begin
                _ram_cs    = {RAM_CSW{1'b1}};
                _ram_we    = {RAM_WEW{1'b0}};
                _ram_addr  = vec_item[_vit].addr;
                @(posedge dclk);
                reset_intf();

                #(SAMPLE_DELAY) check_result(ram_rdata, vec_item[_vit].data, vec_item[_vit].addr, READ_WRITE_TEST);

                if (RAM_HOLD_CYCLE > 1) begin
                        repeat (RAM_HOLD_CYCLE)
                                @(posedge dclk);
                        #(SAMPLE_DELAY) check_result(ram_rdata, vec_item[_vit].data, vec_item[_vit].addr, DOUT_HOLD_TEST);
                end
        end

        rnd_wr_cmd.uwe  = {RAM_DW{1'b1}};
        rnd_wr_cmd.addr = vec_item[0].addr;

        for (int _bit=0; _bit<RAM_DW; _bit+=1) begin
                rnd_wr_cmd.wdata = vec_item[0].data ^ ({{(RAM_DW-1){1'b0}}, 1'b1} << _bit);

                _ram_cs    = {RAM_CSW{1'b1}};
                _ram_we    = rnd_wr_cmd.uwe;
                _ram_addr  = rnd_wr_cmd.addr;
                _ram_wdata = rnd_wr_cmd.wdata;
                @(posedge dclk);
                vec_item[0].data = (vec_item[0].data & ~uwe2we(rnd_wr_cmd.uwe)) | (rnd_wr_cmd.wdata & uwe2we(rnd_wr_cmd.uwe));
                repeat (W2R_CYCLE) @(posedge dclk);
                _ram_cs    = {RAM_CSW{1'b1}};
                _ram_we    = {RAM_WEW{1'b0}};
                _ram_addr  = rnd_wr_cmd.addr;
                @(posedge dclk);
                reset_intf();

                #(SAMPLE_DELAY) check_result(ram_rdata, vec_item[0].data, vec_item[0].addr, BIT_TOGGLE_TEST);
        end

        if (RAM_UNIT_WRITE_SUPPORT) begin
                rnd_wr_cmd.addr = vec_item[0].addr;

                for (int _bit=0; _bit<RAM_WEW; _bit+=1) begin
                        rnd_wr_cmd.wdata = ~vec_item[0].data;
			if(RAM_WEW>1) begin
                        	rnd_wr_cmd.uwe   = {{(RAM_WEW-1){1'b0}}, 1'b1} << _bit;
			end
			else begin
                        	rnd_wr_cmd.uwe   = 1'b1 << _bit;
			end

                        _ram_cs    = {RAM_CSW{1'b1}};
                        _ram_we    = rnd_wr_cmd.uwe;
                        _ram_addr  = rnd_wr_cmd.addr;
                        _ram_wdata = rnd_wr_cmd.wdata;
                        @(posedge dclk);
                        vec_item[0].data = (vec_item[0].data & ~uwe2we(rnd_wr_cmd.uwe)) | (rnd_wr_cmd.wdata & uwe2we(rnd_wr_cmd.uwe));
                        repeat (W2R_CYCLE) @(posedge dclk);
                        _ram_cs    = {RAM_CSW{1'b1}};
                        _ram_we    = {RAM_WEW{1'b0}};
                        _ram_addr  = rnd_wr_cmd.addr;
                        @(posedge dclk);
                        reset_intf();

                        #(SAMPLE_DELAY) check_result(ram_rdata, vec_item[0].data, vec_item[0].addr, UNIT_WRITE_TEST);
                end
        end

        ->e_pass;
end

function void reset_intf;
begin
        _ram_cs          = {RAM_CSW{1'b0}};
        _ram_we          = {RAM_WEW{1'bx}};
        _ram_addr        = {RAM_EAW{1'bx}};
        _ram_wdata       = {RAM_DW{1'bx}};
end
endfunction : reset_intf

function void check_result(input [RAM_DW-1:0] data, ref_data, input [RAM_EAW-1:0] addr, input subtest_t subtest);
begin
        if (data !== ref_data) begin
                fail_addr                       = addr;
                fail_refdata                    = ref_data;
                fail_rdata                      = data;
                fail_subtest                    = subtest;
                -> e_fail;
        end
end
endfunction

function void force_mem_inputs();
        force ram_cs     = _ram_cs;
        force ram_we     = _ram_we;
	force ram_we_en  = |_ram_we;
        force ram_addr   = _ram_addr;
        force ram_wdata  = _ram_wdata;
endfunction

function void release_mem_inputs();
        release ram_cs;
        release ram_we;
        release ram_we_en;
        release ram_addr;
        release ram_wdata;
endfunction

function bit [RAM_DW-1:0] uwe2we(input [RAM_WEW-1:0] uwe);
        int _ofs;
        for (_ofs=0; _ofs<RAM_WEW; _ofs+=1) begin
                uwe2we[_ofs*RAM_WUNIT +: RAM_WUNIT] = {RAM_WUNIT{uwe[_ofs]}};
        end
	if (RAM_ECW != 0) begin: gen_extra_code
	        for (_ofs=0; _ofs<RAM_ECW; _ofs+=RAM_UECW) begin
	                uwe2we[_ofs+RAM_EC_LSB +: RAM_UECW] = {RAM_UECW{|uwe[_ofs*RAM_NWE_UEC +: RAM_NWE_UEC]}};
	        end
	end
endfunction

initial begin
	if (dispmon_TEST_MEM_MACRO_0) $display("%0t:TEST_MEM_MACRO:%m:Macro test start", $realtime);
        flg_fail = 0;
        flg_finish = 0;
        fork
        begin
                wait(e_fail.triggered);
                flg_fail = 1;
                if (dispmon_TEST_MEM_MACRO_9) begin $display("%0t:TEST_MEM_MACRO:ERROR:%m:%s failed", $realtime, fail_subtest.name()); end
		if (dispmon_TEST_MEM_MACRO_9) begin $display("%0t:TEST_MEM_MACRO:ERROR:%m:Read-back data incorrect @0x%x (rdata=0x%x, ref=0x%x)", $realtime, fail_addr, fail_rdata, fail_refdata); end
        end
        begin
                wait(e_pass.triggered);
		if (dispmon_TEST_MEM_MACRO_0) $display("%0t:TEST_MEM_MACRO:%m:Macro test finished", $realtime);
        end
        join_any
        flg_finish = 1;
        release_mem_inputs();
        #1 $exit;
end

endprogram

program dummy_program;
        initial $exit;
endprogram
