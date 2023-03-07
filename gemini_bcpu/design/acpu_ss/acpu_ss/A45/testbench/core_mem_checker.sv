// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale 1ns/1ps

module core_mem_checker(clk, ilm_clk, dlm_clk);

parameter  ISA_BASE = "rv64i";

parameter  LM_INTERFACE = "ram";

parameter  ILM_RAM_AW = 1;
parameter  ILM_RAM_DW = 0;
parameter  ILM_RAM_CSW = 1;
parameter  ILM_RAM_WEW = 0;
parameter  ILM_RAM_WUNIT = 1;
parameter  ILM_ECC_TYPE = "none";
parameter  ILM_ECCW = 0;
parameter  ILM_WAIT_CYCLE = 0;

parameter  NUM_DLM_BANKS = 1;
parameter  DLM_RAM_AW = 1;
parameter  DLM_RAM_DW = 0;
parameter  DLM_RAM_CSW = 1;
parameter  DLM_RAM_WEW = 0;
parameter  DLM_RAM_WUNIT = 1;
parameter  DLM_ECC_TYPE = "none";
parameter  DLM_ECCW = 0;
parameter  DLM_WAIT_CYCLE = 0;

parameter  BTB_BANK = 0;
parameter  BTB_RAM_AW = 1;
parameter  BTB_RAM_DW = 0;
parameter  BTB_RAM_CSW = 1;
parameter  BTB_RAM_WEW = 0;
parameter  BTB_RAM_WUNIT = 1;

parameter  ICACHE_WAY = 0;
parameter  ICACHE_ECC_TYPE = "none";
parameter  ICACHE_TAG_RAM_AW = 1;
parameter  ICACHE_TAG_RAM_DW = 0;
parameter  ICACHE_TAG_RAM_CSW = 1;
parameter  ICACHE_TAG_RAM_WEW = 0;
parameter  ICACHE_TAG_RAM_WUNIT = 1;
parameter  ICACHE_TAG_ECCW = 0;
parameter  ICACHE_DATA_RAM_AW = 1;
parameter  ICACHE_DATA_RAM_DW = 0;
parameter  ICACHE_DATA_RAM_CSW = 1;
parameter  ICACHE_DATA_RAM_WEW = 0;
parameter  ICACHE_DATA_RAM_WUNIT = 1;
parameter  ICACHE_DATA_ECCW = 0;

parameter  DCACHE_WAY = 0;
parameter  DCACHE_ECC_TYPE = "none";
parameter  DCACHE_TAG_RAM_AW = 1;
parameter  DCACHE_TAG_RAM_DW = 0;
parameter  DCACHE_TAG_RAM_CSW = 1;
parameter  DCACHE_TAG_RAM_WEW = 0;
parameter  DCACHE_TAG_RAM_WUNIT = 1;
parameter  DCACHE_TAG_ECCW = 0;
parameter  DCACHE_DATA_RAM_AW = 1;
parameter  DCACHE_DATA_RAM_DW = 0;
parameter  DCACHE_DATA_RAM_CSW = 1;
parameter  DCACHE_DATA_RAM_WEW = 0;
parameter  DCACHE_DATA_RAM_WUNIT = 1;
parameter  DCACHE_DATA_ECCW = 0;

parameter  DCACHE_WPT_RAM_AW = 1;
parameter  DCACHE_WPT_RAM_DW = 0;
parameter  DCACHE_WPT_RAM_CSW = 1;
parameter  DCACHE_WPT_RAM_WEW = 0;
parameter  DCACHE_WPT_RAM_WUNIT = 1;
parameter  DCACHE_WPT_ECCW = 0;

parameter  STLB_WAY = 0;
parameter  STLB_ECC_TYPE = 0;
parameter  STLB_RAM_AW = 1;
parameter  STLB_RAM_DW = 1;
parameter  STLB_TAG_RAM_DW = 0;
parameter  STLB_DATA_RAM_DW = 0;
parameter  STLB_RAM_CSW = 1;
parameter  STLB_RAM_WEW = 0;
parameter  STLB_RAM_WUNIT = 1;
parameter  STLB_TAG_RAM_WUNIT = 1;
parameter  STLB_DATA_RAM_WUNIT = 1;

localparam ILM_RAM_EXIST =    (LM_INTERFACE == "ram" && ILM_RAM_AW > 1 && ILM_WAIT_CYCLE == 0)? "yes" : "no";
localparam DLM_RAM_EXIST =    (LM_INTERFACE == "ram" && DLM_RAM_AW > 1 && DLM_WAIT_CYCLE == 0)? "yes" : "no";
localparam BTB_RAM_EXIST =    (BTB_RAM_AW > 1)? "yes" : "no";
localparam ICACHE_RAM_EXIST = (ICACHE_TAG_RAM_AW > 1)? "yes" : "no";
localparam DCACHE_RAM_EXIST = (DCACHE_TAG_RAM_AW > 1)? "yes" : "no";
localparam STLB_RAM_EXIST   = (STLB_RAM_AW > 1)?   "yes" : "no";
localparam DCACHE_WPT_EXIST = (DCACHE_WPT_RAM_AW > 1)? "yes" : "no";

localparam ILM_ECW = (ILM_ECC_TYPE == "none")? 0 : ILM_ECCW;
localparam ILM_NWE_UEC = (ILM_ECC_TYPE == "ecc")? ILM_RAM_WEW : 1;
localparam DLM_ECW = (DLM_ECC_TYPE == "none")? 0 : DLM_ECCW;
localparam DLM_NWE_UEC = (DLM_ECC_TYPE == "ecc")? DLM_RAM_WEW : 1;
localparam ICACHE_TAG_ECW = (ICACHE_ECC_TYPE == "none")? 0 : ICACHE_TAG_ECCW;
localparam ICACHE_TAG_NWE_UEC = (ICACHE_ECC_TYPE == "ecc")? ICACHE_TAG_RAM_WEW : 1;
localparam ICACHE_DATA_ECW = (ICACHE_ECC_TYPE == "none")? 0 : ICACHE_DATA_ECCW;
localparam ICACHE_DATA_NWE_UEC = (ICACHE_ECC_TYPE == "ecc")? ICACHE_DATA_RAM_WEW : 1;
localparam DCACHE_TAG_ECW = (DCACHE_ECC_TYPE == "none")? 0 : DCACHE_TAG_ECCW;
localparam DCACHE_TAG_NWE_UEC = (DCACHE_ECC_TYPE == "ecc")? DCACHE_TAG_RAM_WEW : 1;
localparam DCACHE_DATA_ECW = (DCACHE_ECC_TYPE == "none")? 0 : DCACHE_DATA_ECCW;
localparam DCACHE_DATA_NWE_UEC = (DCACHE_ECC_TYPE == "ecc")? DCACHE_DATA_RAM_WEW : 1;
localparam DCACHE_WPT_ECW = 0;
localparam DCACHE_WPT_NWE_UEC = 1;

input   clk;
input   ilm_clk;
input   dlm_clk;

event   e_fail;

generate
if ((ILM_RAM_EXIST == "yes") && (ILM_ECC_TYPE == "ecc")) begin : gen_ilm0_ecc_mem_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(ILM_RAM_AW),
                .RAM_WEW(1),
                .RAM_CSW(ILM_RAM_CSW),
                .RAM_WUNIT(ILM_RAM_DW),
                .RAM_ECW(ILM_ECW),
                .RAM_NWE_UEC(ILM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
        ) mem_checker (
                .clk       (ilm_clk),
                .ram_cs    (u_ilm_ram0.ilm_cs),
                .ram_we    (u_ilm_ram0.ilm_we),
                .ram_addr  (u_ilm_ram0.ilm_addr),
                .ram_wdata (u_ilm_ram0.ilm_wdata),
                .ram_rdata (u_ilm_ram0.ilm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((ILM_RAM_EXIST == "yes") && (ILM_ECC_TYPE != "ecc")) begin : gen_ilm0_mem_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(ILM_RAM_AW),
                .RAM_WEW(ILM_RAM_WEW),
                .RAM_CSW(ILM_RAM_CSW),
                .RAM_WUNIT(ILM_RAM_WUNIT),
                .RAM_ECW(ILM_ECW),
                .RAM_NWE_UEC(ILM_NWE_UEC)
        ) mem_checker (
                .clk       (ilm_clk),
                .ram_cs    (u_ilm_ram0.ilm_cs),
                .ram_we_en (u_ilm_ram0.ilm_we),
                .ram_we    (u_ilm_ram0.ilm_byte_we),
                .ram_addr  (u_ilm_ram0.ilm_addr),
                .ram_wdata (u_ilm_ram0.ilm_wdata),
                .ram_rdata (u_ilm_ram0.ilm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end


if ((ILM_RAM_EXIST == "yes") && (ISA_BASE != "rv64i") && (ILM_ECC_TYPE == "ecc")) begin : gen_ilm1_ecc_mem_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(ILM_RAM_AW),
                .RAM_WEW(1),
                .RAM_CSW(ILM_RAM_CSW),
                .RAM_WUNIT(ILM_RAM_DW),
                .RAM_ECW(ILM_ECW),
                .RAM_NWE_UEC(ILM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
        ) mem_checker (
                .clk       (ilm_clk),
                .ram_cs    (u_ilm_ram1.ilm_cs),
                .ram_we    (u_ilm_ram1.ilm_we),
                .ram_addr  (u_ilm_ram1.ilm_addr),
                .ram_wdata (u_ilm_ram1.ilm_wdata),
                .ram_rdata (u_ilm_ram1.ilm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((ILM_RAM_EXIST == "yes") && (ISA_BASE != "rv64i") && (ILM_ECC_TYPE != "ecc")) begin : gen_ilm1_mem_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(ILM_RAM_AW),
                .RAM_WEW(ILM_RAM_WEW),
                .RAM_CSW(ILM_RAM_CSW),
                .RAM_WUNIT(ILM_RAM_WUNIT),
                .RAM_ECW(ILM_ECW),
                .RAM_NWE_UEC(ILM_NWE_UEC)
        ) mem_checker (
                .clk       (ilm_clk),
                .ram_cs    (u_ilm_ram1.ilm_cs),
                .ram_we_en (u_ilm_ram1.ilm_we),
                .ram_we    (u_ilm_ram1.ilm_byte_we),
                .ram_addr  (u_ilm_ram1.ilm_addr),
                .ram_wdata (u_ilm_ram1.ilm_wdata),
                .ram_rdata (u_ilm_ram1.ilm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end


if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc")) begin : gen_dlm_ecc_mem0_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_CSW(DLM_RAM_CSW),
                .RAM_WEW(1),
                .RAM_WUNIT(DLM_RAM_DW),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram0.dlm_cs),
                .ram_we    (u_dlm_ram0.dlm_we),
                .ram_addr  (u_dlm_ram0.dlm_addr),
                .ram_wdata (u_dlm_ram0.dlm_wdata),
                .ram_rdata (u_dlm_ram0.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc")) begin : gen_dlm_mem0_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_CSW(DLM_RAM_CSW),
                .RAM_WEW(DLM_RAM_WEW),
                .RAM_WUNIT(DLM_RAM_WUNIT),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram0.dlm_cs),
                .ram_we_en (u_dlm_ram0.dlm_we),
                .ram_we    (u_dlm_ram0.dlm_byte_we),
                .ram_addr  (u_dlm_ram0.dlm_addr),
                .ram_wdata (u_dlm_ram0.dlm_wdata),
                .ram_rdata (u_dlm_ram0.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (NUM_DLM_BANKS == 4)) begin : gen_dlm_ecc_mem1_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_CSW(DLM_RAM_CSW),
                .RAM_WEW(1),
                .RAM_WUNIT(DLM_RAM_DW),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram1.dlm_cs),
                .ram_we    (u_dlm_ram1.dlm_we),
                .ram_addr  (u_dlm_ram1.dlm_addr),
                .ram_wdata (u_dlm_ram1.dlm_wdata),
                .ram_rdata (u_dlm_ram1.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (NUM_DLM_BANKS == 4)) begin : gen_dlm_mem1_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_CSW(DLM_RAM_CSW),
                .RAM_WEW(DLM_RAM_WEW),
                .RAM_WUNIT(DLM_RAM_WUNIT),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram1.dlm_cs),
                .ram_we_en (u_dlm_ram1.dlm_we),
                .ram_we    (u_dlm_ram1.dlm_byte_we),
                .ram_addr  (u_dlm_ram1.dlm_addr),
                .ram_wdata (u_dlm_ram1.dlm_wdata),
                .ram_rdata (u_dlm_ram1.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (NUM_DLM_BANKS == 4)) begin : gen_dlm_ecc_mem2_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_CSW(DLM_RAM_CSW),
                .RAM_WEW(1),
                .RAM_WUNIT(DLM_RAM_DW),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram2.dlm_cs),
                .ram_we    (u_dlm_ram2.dlm_we),
                .ram_addr  (u_dlm_ram2.dlm_addr),
                .ram_wdata (u_dlm_ram2.dlm_wdata),
                .ram_rdata (u_dlm_ram2.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (NUM_DLM_BANKS == 4)) begin : gen_dlm_mem2_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_CSW(DLM_RAM_CSW),
                .RAM_WEW(DLM_RAM_WEW),
                .RAM_WUNIT(DLM_RAM_WUNIT),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram2.dlm_cs),
                .ram_we_en (u_dlm_ram2.dlm_we),
                .ram_we    (u_dlm_ram2.dlm_byte_we),
                .ram_addr  (u_dlm_ram2.dlm_addr),
                .ram_wdata (u_dlm_ram2.dlm_wdata),
                .ram_rdata (u_dlm_ram2.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (NUM_DLM_BANKS == 4)) begin : gen_dlm_ecc_mem3_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_CSW(DLM_RAM_CSW),
                .RAM_WEW(1),
                .RAM_WUNIT(DLM_RAM_DW),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram3.dlm_cs),
                .ram_we    (u_dlm_ram3.dlm_we),
                .ram_addr  (u_dlm_ram3.dlm_addr),
                .ram_wdata (u_dlm_ram3.dlm_wdata),
                .ram_rdata (u_dlm_ram3.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (NUM_DLM_BANKS == 4)) begin : gen_dlm_mem3_checker
        bit     flg_fail;
        bit     flg_finish;
        mem_checker #(
                .RAM_AW(DLM_RAM_AW),
                .RAM_WEW(DLM_RAM_WEW),
                .RAM_WUNIT(DLM_RAM_WUNIT),
                .RAM_ECW(DLM_ECW),
                .RAM_NWE_UEC(DLM_NWE_UEC)
        ) mem_checker (
                .clk       (dlm_clk),
		.ram_cs    (u_dlm_ram3.dlm_cs),
                .ram_we_en (u_dlm_ram3.dlm_we),
                .ram_we    (u_dlm_ram3.dlm_byte_we),
                .ram_addr  (u_dlm_ram3.dlm_addr),
                .ram_wdata (u_dlm_ram3.dlm_wdata),
                .ram_rdata (u_dlm_ram3.dlm_rdata),
                .flg_fail  (flg_fail),
                .flg_finish(flg_finish)
        );
        always @* if (flg_fail) -> e_fail;
end

if (BTB_RAM_EXIST == "yes") begin : gen_btb_mem_checker

if (BTB_RAM_EXIST == "yes" && BTB_BANK > 0) begin : gen_btb0_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW(BTB_RAM_AW),
            .RAM_CSW(BTB_RAM_CSW),
            .RAM_WEW(BTB_RAM_WEW),
            .RAM_WUNIT(BTB_RAM_WUNIT)
    ) bank0_mem_checker (
            .clk       (clk),
            .ram_cs    (u_btb_ram0.btb_cs),
            .ram_we    (u_btb_ram0.btb_we),
            .ram_addr  (u_btb_ram0.btb_addr),
            .ram_wdata (u_btb_ram0.btb_wdata),
            .ram_rdata (u_btb_ram0.btb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (BTB_RAM_EXIST == "yes" && BTB_BANK > 1) begin : gen_btb1_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW(BTB_RAM_AW),
            .RAM_CSW(BTB_RAM_CSW),
            .RAM_WEW(BTB_RAM_WEW),
            .RAM_WUNIT(BTB_RAM_WUNIT)
    ) bank1_mem_checker (
            .clk       (clk),
            .ram_cs    (u_btb_ram1.btb_cs),
            .ram_we    (u_btb_ram1.btb_we),
            .ram_addr  (u_btb_ram1.btb_addr),
            .ram_wdata (u_btb_ram1.btb_wdata),
            .ram_rdata (u_btb_ram1.btb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
end


if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 0) begin : gen_icache_tag0_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag0_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram0.icache_tag_cs),
            .ram_we    (u_icache_tag_ram0.icache_tag_we),
            .ram_addr  (u_icache_tag_ram0.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram0.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram0.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 1) begin : gen_icache_tag1_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag1_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram1.icache_tag_cs),
            .ram_we    (u_icache_tag_ram1.icache_tag_we),
            .ram_addr  (u_icache_tag_ram1.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram1.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram1.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 2) begin : gen_icache_tag2_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag2_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram2.icache_tag_cs),
            .ram_we    (u_icache_tag_ram2.icache_tag_we),
            .ram_addr  (u_icache_tag_ram2.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram2.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram2.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 3) begin : gen_icache_tag3_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag3_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram3.icache_tag_cs),
            .ram_we    (u_icache_tag_ram3.icache_tag_we),
            .ram_addr  (u_icache_tag_ram3.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram3.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram3.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 4) begin : gen_icache_tag4_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag4_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram4.icache_tag_cs),
            .ram_we    (u_icache_tag_ram4.icache_tag_we),
            .ram_addr  (u_icache_tag_ram4.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram4.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram4.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 5) begin : gen_icache_tag5_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag5_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram5.icache_tag_cs),
            .ram_we    (u_icache_tag_ram5.icache_tag_we),
            .ram_addr  (u_icache_tag_ram5.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram5.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram5.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 6) begin : gen_icache_tag6_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag6_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram6.icache_tag_cs),
            .ram_we    (u_icache_tag_ram6.icache_tag_we),
            .ram_addr  (u_icache_tag_ram6.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram6.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram6.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes" && ICACHE_WAY > 7) begin : gen_icache_tag7_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_TAG_RAM_AW),
            .RAM_CSW    (ICACHE_TAG_RAM_CSW),
            .RAM_WEW    (ICACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (ICACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (ICACHE_TAG_ECW),
            .RAM_NWE_UEC(ICACHE_TAG_NWE_UEC)
    ) tag7_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_tag_ram7.icache_tag_cs),
            .ram_we    (u_icache_tag_ram7.icache_tag_we),
            .ram_addr  (u_icache_tag_ram7.icache_tag_addr),
            .ram_wdata (u_icache_tag_ram7.icache_tag_wdata),
            .ram_rdata (u_icache_tag_ram7.icache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data0_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data0_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram0.icache_data_cs),
            .ram_we    (u_icache_data_ram0.icache_data_we),
            .ram_addr  (u_icache_data_ram0.icache_data_addr),
            .ram_wdata (u_icache_data_ram0.icache_data_wdata),
            .ram_rdata (u_icache_data_ram0.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data1_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data1_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram1.icache_data_cs),
            .ram_we    (u_icache_data_ram1.icache_data_we),
            .ram_addr  (u_icache_data_ram1.icache_data_addr),
            .ram_wdata (u_icache_data_ram1.icache_data_wdata),
            .ram_rdata (u_icache_data_ram1.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data2_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data2_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram2.icache_data_cs),
            .ram_we    (u_icache_data_ram2.icache_data_we),
            .ram_addr  (u_icache_data_ram2.icache_data_addr),
            .ram_wdata (u_icache_data_ram2.icache_data_wdata),
            .ram_rdata (u_icache_data_ram2.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data3_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data3_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram3.icache_data_cs),
            .ram_we    (u_icache_data_ram3.icache_data_we),
            .ram_addr  (u_icache_data_ram3.icache_data_addr),
            .ram_wdata (u_icache_data_ram3.icache_data_wdata),
            .ram_rdata (u_icache_data_ram3.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data4_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data4_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram4.icache_data_cs),
            .ram_we    (u_icache_data_ram4.icache_data_we),
            .ram_addr  (u_icache_data_ram4.icache_data_addr),
            .ram_wdata (u_icache_data_ram4.icache_data_wdata),
            .ram_rdata (u_icache_data_ram4.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data5_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data5_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram5.icache_data_cs),
            .ram_we    (u_icache_data_ram5.icache_data_we),
            .ram_addr  (u_icache_data_ram5.icache_data_addr),
            .ram_wdata (u_icache_data_ram5.icache_data_wdata),
            .ram_rdata (u_icache_data_ram5.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data6_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data6_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram6.icache_data_cs),
            .ram_we    (u_icache_data_ram6.icache_data_we),
            .ram_addr  (u_icache_data_ram6.icache_data_addr),
            .ram_wdata (u_icache_data_ram6.icache_data_wdata),
            .ram_rdata (u_icache_data_ram6.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if (ICACHE_RAM_EXIST == "yes") begin : gen_icache_data7_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (ICACHE_DATA_RAM_AW),
            .RAM_CSW    (ICACHE_DATA_RAM_CSW),
            .RAM_WEW    (ICACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (ICACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (ICACHE_DATA_ECW),
            .RAM_NWE_UEC(ICACHE_DATA_NWE_UEC)
    ) data7_mem_checker (
            .clk       (clk),
            .ram_cs    (u_icache_data_ram7.icache_data_cs),
            .ram_we    (u_icache_data_ram7.icache_data_we),
            .ram_addr  (u_icache_data_ram7.icache_data_addr),
            .ram_wdata (u_icache_data_ram7.icache_data_wdata),
            .ram_rdata (u_icache_data_ram7.icache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end


if (DCACHE_RAM_EXIST == "yes" && DCACHE_WAY > 0) begin : gen_dcache_tag0_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_TAG_RAM_AW),
            .RAM_CSW    (DCACHE_TAG_RAM_CSW),
            .RAM_WEW    (DCACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (DCACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (DCACHE_TAG_ECW),
            .RAM_NWE_UEC(DCACHE_TAG_NWE_UEC)
    ) tag0_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_tag_ram0.dcache_tag_cs),
            .ram_we    (u_dcache_tag_ram0.dcache_tag_we),
            .ram_addr  (u_dcache_tag_ram0.dcache_tag_addr),
            .ram_wdata (u_dcache_tag_ram0.dcache_tag_wdata),
            .ram_rdata (u_dcache_tag_ram0.dcache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (DCACHE_RAM_EXIST == "yes" && DCACHE_WAY > 1) begin : gen_dcache_tag1_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_TAG_RAM_AW),
            .RAM_CSW    (DCACHE_TAG_RAM_CSW),
            .RAM_WEW    (DCACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (DCACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (DCACHE_TAG_ECW),
            .RAM_NWE_UEC(DCACHE_TAG_NWE_UEC)
    ) tag1_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_tag_ram1.dcache_tag_cs),
            .ram_we    (u_dcache_tag_ram1.dcache_tag_we),
            .ram_addr  (u_dcache_tag_ram1.dcache_tag_addr),
            .ram_wdata (u_dcache_tag_ram1.dcache_tag_wdata),
            .ram_rdata (u_dcache_tag_ram1.dcache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (DCACHE_RAM_EXIST == "yes" && DCACHE_WAY > 2) begin : gen_dcache_tag2_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_TAG_RAM_AW),
            .RAM_CSW    (DCACHE_TAG_RAM_CSW),
            .RAM_WEW    (DCACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (DCACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (DCACHE_TAG_ECW),
            .RAM_NWE_UEC(DCACHE_TAG_NWE_UEC)
    ) tag2_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_tag_ram2.dcache_tag_cs),
            .ram_we    (u_dcache_tag_ram2.dcache_tag_we),
            .ram_addr  (u_dcache_tag_ram2.dcache_tag_addr),
            .ram_wdata (u_dcache_tag_ram2.dcache_tag_wdata),
            .ram_rdata (u_dcache_tag_ram2.dcache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (DCACHE_RAM_EXIST == "yes" && DCACHE_WAY > 3) begin : gen_dcache_tag3_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_TAG_RAM_AW),
            .RAM_CSW    (DCACHE_TAG_RAM_CSW),
            .RAM_WEW    (DCACHE_TAG_RAM_WEW),
            .RAM_WUNIT  (DCACHE_TAG_RAM_WUNIT),
            .RAM_ECW    (DCACHE_TAG_ECW),
            .RAM_NWE_UEC(DCACHE_TAG_NWE_UEC)
    ) tag3_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_tag_ram3.dcache_tag_cs),
            .ram_we    (u_dcache_tag_ram3.dcache_tag_we),
            .ram_addr  (u_dcache_tag_ram3.dcache_tag_addr),
            .ram_wdata (u_dcache_tag_ram3.dcache_tag_wdata),
            .ram_rdata (u_dcache_tag_ram3.dcache_tag_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE == "ecc")) begin : gen_dcache_data0_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (1),
            .RAM_WUNIT  (DCACHE_DATA_RAM_DW),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC),
            .RAM_UNIT_WRITE_SUPPORT(0)
    ) data0_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram0.dcache_data_cs),
            .ram_we    (u_dcache_data_ram0.dcache_data_we),
            .ram_addr  (u_dcache_data_ram0.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram0.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram0.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE != "ecc")) begin : gen_dcache_data0_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (DCACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (DCACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC)
    ) data0_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram0.dcache_data_cs),
            .ram_we_en (u_dcache_data_ram0.dcache_data_we),
            .ram_we    (u_dcache_data_ram0.dcache_data_byte_we),
            .ram_addr  (u_dcache_data_ram0.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram0.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram0.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE == "ecc")) begin : gen_dcache_data1_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (1),
            .RAM_WUNIT  (DCACHE_DATA_RAM_DW),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC),
            .RAM_UNIT_WRITE_SUPPORT(0)
    ) data1_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram1.dcache_data_cs),
            .ram_we    (u_dcache_data_ram1.dcache_data_we),
            .ram_addr  (u_dcache_data_ram1.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram1.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram1.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE != "ecc")) begin : gen_dcache_data1_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (DCACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (DCACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC)
    ) data1_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram1.dcache_data_cs),
            .ram_we_en (u_dcache_data_ram1.dcache_data_we),
            .ram_we    (u_dcache_data_ram1.dcache_data_byte_we),
            .ram_addr  (u_dcache_data_ram1.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram1.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram1.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE == "ecc")) begin : gen_dcache_data2_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (1),
            .RAM_WUNIT  (DCACHE_DATA_RAM_DW),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC),
            .RAM_UNIT_WRITE_SUPPORT(0)
    ) data2_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram2.dcache_data_cs),
            .ram_we    (u_dcache_data_ram2.dcache_data_we),
            .ram_addr  (u_dcache_data_ram2.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram2.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram2.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE != "ecc")) begin : gen_dcache_data2_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (DCACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (DCACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC)
    ) data2_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram2.dcache_data_cs),
            .ram_we_en (u_dcache_data_ram2.dcache_data_we),
            .ram_we    (u_dcache_data_ram2.dcache_data_byte_we),
            .ram_addr  (u_dcache_data_ram2.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram2.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram2.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE == "ecc")) begin : gen_dcache_data3_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (1),
            .RAM_WUNIT  (DCACHE_DATA_RAM_DW),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC),
            .RAM_UNIT_WRITE_SUPPORT(0)
    ) data3_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram3.dcache_data_cs),
            .ram_we    (u_dcache_data_ram3.dcache_data_we),
            .ram_addr  (u_dcache_data_ram3.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram3.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram3.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_RAM_EXIST == "yes") && (DCACHE_ECC_TYPE != "ecc")) begin : gen_dcache_data3_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_DATA_RAM_AW),
            .RAM_CSW    (DCACHE_DATA_RAM_CSW),
            .RAM_WEW    (DCACHE_DATA_RAM_WEW),
            .RAM_WUNIT  (DCACHE_DATA_RAM_WUNIT),
            .RAM_ECW    (DCACHE_DATA_ECW),
            .RAM_NWE_UEC(DCACHE_DATA_NWE_UEC)
    ) data3_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_data_ram3.dcache_data_cs),
            .ram_we_en (u_dcache_data_ram3.dcache_data_we),
            .ram_we    (u_dcache_data_ram3.dcache_data_byte_we),
            .ram_addr  (u_dcache_data_ram3.dcache_data_addr),
            .ram_wdata (u_dcache_data_ram3.dcache_data_wdata),
            .ram_rdata (u_dcache_data_ram3.dcache_data_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end
if ((DCACHE_WPT_EXIST == "yes")) begin : gen_dcache_wpt_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW     (DCACHE_WPT_RAM_AW),
            .RAM_CSW    (DCACHE_WPT_RAM_CSW),
            .RAM_WEW    (DCACHE_WPT_RAM_WEW),
            .RAM_WUNIT  (DCACHE_WPT_RAM_WUNIT),
            .RAM_ECW    (DCACHE_WPT_ECW),
            .RAM_NWE_UEC(DCACHE_WPT_NWE_UEC)
    ) dcache_wpt_mem_checker (
            .clk       (clk),
            .ram_cs    (u_dcache_wpt_ram.dcache_wpt_cs),
            .ram_we_en (u_dcache_wpt_ram.dcache_wpt_we),
            .ram_we    (u_dcache_wpt_ram.dcache_wpt_byte_we),
            .ram_addr  (u_dcache_wpt_ram.dcache_wpt_addr),
            .ram_wdata (u_dcache_wpt_ram.dcache_wpt_wdata),
            .ram_rdata (u_dcache_wpt_ram.dcache_wpt_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail) -> e_fail;
end



if (STLB_RAM_EXIST == "yes" && STLB_WAY > 0 && STLB_ECC_TYPE == 0) begin : gen_stlb0_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_RAM_WUNIT)
    ) stlb0_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_ram0.stlb_cs),
            .ram_we    (u_stlb_ram0.stlb_we),
            .ram_addr  (u_stlb_ram0.stlb_addr),
            .ram_wdata (u_stlb_ram0.stlb_wdata),
            .ram_rdata (u_stlb_ram0.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 0 && STLB_ECC_TYPE == 1) begin : gen_stlb_tag0_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_TAG_RAM_WUNIT)
    ) stlb_tag0_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_tag_ecc_ram0.stlb_cs),
            .ram_we    (u_stlb_tag_ecc_ram0.stlb_we),
            .ram_addr  (u_stlb_tag_ecc_ram0.stlb_addr),
            .ram_wdata (u_stlb_tag_ecc_ram0.stlb_wdata),
            .ram_rdata (u_stlb_tag_ecc_ram0.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 0 && STLB_ECC_TYPE == 1) begin : gen_stlb_data0_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_DATA_RAM_WUNIT)
    ) stlb_data0_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_data_ecc_ram0.stlb_cs),
            .ram_we    (u_stlb_data_ecc_ram0.stlb_we),
            .ram_addr  (u_stlb_data_ecc_ram0.stlb_addr),
            .ram_wdata (u_stlb_data_ecc_ram0.stlb_wdata),
            .ram_rdata (u_stlb_data_ecc_ram0.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 1 && STLB_ECC_TYPE == 0) begin : gen_stlb1_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_RAM_WUNIT)
    ) stlb1_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_ram1.stlb_cs),
            .ram_we    (u_stlb_ram1.stlb_we),
            .ram_addr  (u_stlb_ram1.stlb_addr),
            .ram_wdata (u_stlb_ram1.stlb_wdata),
            .ram_rdata (u_stlb_ram1.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 1 && STLB_ECC_TYPE == 1) begin : gen_stlb_tag1_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_TAG_RAM_WUNIT)
    ) stlb_tag1_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_tag_ecc_ram1.stlb_cs),
            .ram_we    (u_stlb_tag_ecc_ram1.stlb_we),
            .ram_addr  (u_stlb_tag_ecc_ram1.stlb_addr),
            .ram_wdata (u_stlb_tag_ecc_ram1.stlb_wdata),
            .ram_rdata (u_stlb_tag_ecc_ram1.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 1 && STLB_ECC_TYPE == 1) begin : gen_stlb_data1_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_DATA_RAM_WUNIT)
    ) stlb_data1_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_data_ecc_ram1.stlb_cs),
            .ram_we    (u_stlb_data_ecc_ram1.stlb_we),
            .ram_addr  (u_stlb_data_ecc_ram1.stlb_addr),
            .ram_wdata (u_stlb_data_ecc_ram1.stlb_wdata),
            .ram_rdata (u_stlb_data_ecc_ram1.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 2 && STLB_ECC_TYPE == 0) begin : gen_stlb2_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_RAM_WUNIT)
    ) stlb2_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_ram2.stlb_cs),
            .ram_we    (u_stlb_ram2.stlb_we),
            .ram_addr  (u_stlb_ram2.stlb_addr),
            .ram_wdata (u_stlb_ram2.stlb_wdata),
            .ram_rdata (u_stlb_ram2.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 2 && STLB_ECC_TYPE == 1) begin : gen_stlb_tag2_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_TAG_RAM_WUNIT)
    ) stlb_tag2_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_tag_ecc_ram2.stlb_cs),
            .ram_we    (u_stlb_tag_ecc_ram2.stlb_we),
            .ram_addr  (u_stlb_tag_ecc_ram2.stlb_addr),
            .ram_wdata (u_stlb_tag_ecc_ram2.stlb_wdata),
            .ram_rdata (u_stlb_tag_ecc_ram2.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 2 && STLB_ECC_TYPE == 1) begin : gen_stlb_data2_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_DATA_RAM_WUNIT)
    ) stlb_data2_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_data_ecc_ram2.stlb_cs),
            .ram_we    (u_stlb_data_ecc_ram2.stlb_we),
            .ram_addr  (u_stlb_data_ecc_ram2.stlb_addr),
            .ram_wdata (u_stlb_data_ecc_ram2.stlb_wdata),
            .ram_rdata (u_stlb_data_ecc_ram2.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 3 && STLB_ECC_TYPE == 0) begin : gen_stlb3_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_RAM_WUNIT)
    ) stlb3_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_ram3.stlb_cs),
            .ram_we    (u_stlb_ram3.stlb_we),
            .ram_addr  (u_stlb_ram3.stlb_addr),
            .ram_wdata (u_stlb_ram3.stlb_wdata),
            .ram_rdata (u_stlb_ram3.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 3 && STLB_ECC_TYPE == 1) begin : gen_stlb_tag3_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_TAG_RAM_WUNIT)
    ) stlb_tag3_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_tag_ecc_ram3.stlb_cs),
            .ram_we    (u_stlb_tag_ecc_ram3.stlb_we),
            .ram_addr  (u_stlb_tag_ecc_ram3.stlb_addr),
            .ram_wdata (u_stlb_tag_ecc_ram3.stlb_wdata),
            .ram_rdata (u_stlb_tag_ecc_ram3.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
if (STLB_RAM_EXIST == "yes" && STLB_WAY > 3 && STLB_ECC_TYPE == 1) begin : gen_stlb_data3_ecc_mem_checker
    bit     flg_fail;
    bit     flg_finish;
    mem_checker #(
            .RAM_AW   (STLB_RAM_AW),
            .RAM_CSW  (STLB_RAM_CSW),
            .RAM_WEW  (STLB_RAM_WEW),
            .RAM_WUNIT(STLB_DATA_RAM_WUNIT)
    ) stlb_data3_ecc_mem_checker (
            .clk       (clk),
            .ram_cs    (u_stlb_data_ecc_ram3.stlb_cs),
            .ram_we    (u_stlb_data_ecc_ram3.stlb_we),
            .ram_addr  (u_stlb_data_ecc_ram3.stlb_addr),
            .ram_wdata (u_stlb_data_ecc_ram3.stlb_wdata),
            .ram_rdata (u_stlb_data_ecc_ram3.stlb_rdata),
            .flg_fail  (flg_fail),
            .flg_finish(flg_finish)
    );
    always @* if (flg_fail)  -> e_fail;
end
endgenerate

endmodule
