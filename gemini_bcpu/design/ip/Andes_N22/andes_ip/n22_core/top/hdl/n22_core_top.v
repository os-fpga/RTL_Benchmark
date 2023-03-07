// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module n22_core_top (
    hart_halted,
    mtime_toggle_a,
    int_src,
    hlock,
    hresp,
    master,
    hrdata,
    hready,
    haddr,
    hburst,
    hprot,
    hsize,
    htrans,
    hwdata,
    hwrite,
    dbg_srst_req,
    disable_ext_debugger,
    dmactive,
    jtag_tck,
    jtag_tdi,
    jtag_tdo,
    jtag_tdo_en,
    jtag_tms,
    clkgate_bypass,
    core_sleep_value,
    hart_id,
    meip,
    reset_bypass,
    rx_evt,
    tx_evt,
    por_rstn,
    core_clk,
    core_clk_aon,
    core_reset_n,
    core_wfi_mode,
    reset_vector,
    nmi
);
parameter PALEN = 32;
parameter DEVICE_REGION0_BASE = 32'hffffffff;
parameter DEVICE_REGION0_MASK = 32'h00000000;
parameter DEVICE_REGION1_BASE = 32'hffffffff;
parameter DEVICE_REGION1_MASK = 32'h00000000;
parameter DEVICE_REGION2_BASE = 32'h00000000;
parameter DEVICE_REGION2_MASK = 32'hffffffff;
parameter DEVICE_REGION3_BASE = 32'h00000000;
parameter DEVICE_REGION3_MASK = 32'hffffffff;
parameter DEVICE_REGION4_BASE = 32'h00000000;
parameter DEVICE_REGION4_MASK = 32'hffffffff;
parameter DEVICE_REGION5_BASE = 32'h00000000;
parameter DEVICE_REGION5_MASK = 32'hffffffff;
parameter DEVICE_REGION6_BASE = 32'h00000000;
parameter DEVICE_REGION6_MASK = 32'hffffffff;
parameter DEVICE_REGION7_BASE = 32'h00000000;
parameter DEVICE_REGION7_MASK = 32'hffffffff;
parameter N22_DEBUG_BASE_ADDR = 32'he6800000;
parameter N22_ILM_BASE_ADDR = 32'hFFFB0000;
parameter N22_DLM_BASE_ADDR = 32'hfffD0000;
parameter N22_PPI_BASE_ADDR = 32'hf2100000;
parameter N22_FIO_BASE_ADDR = 32'hf2200000;
parameter N22_TMR_BASE_ADDR = 32'he6000000;
parameter N22_CLIC_BASE_ADDR = 32'he2000000;
parameter DEBUG_INTERFACE = "jtag";
parameter PROGBUF_SIZE = 8;
localparam CLIC_EXT_IRQ_NUM = 32;
output hart_halted;
input mtime_toggle_a;
input [32 - 1:0] int_src;
output hlock;
input hresp;
output [1:0] master;
input [32 - 1:0] hrdata;
input hready;
output [32 - 1:0] haddr;
output [2:0] hburst;
output [3:0] hprot;
output [2:0] hsize;
output [1:0] htrans;
output [32 - 1:0] hwdata;
output hwrite;
output dbg_srst_req;
input disable_ext_debugger;
output dmactive;
input jtag_tck;
input jtag_tdi;
output jtag_tdo;
output jtag_tdo_en;
input jtag_tms;
input clkgate_bypass;
output core_sleep_value;
input [(32 - 1):0] hart_id;
input meip;
input reset_bypass;
input rx_evt;
output tx_evt;
input por_rstn;
input core_clk;
input core_clk_aon;
input core_reset_n;
output core_wfi_mode;
input [32 - 1:0] reset_vector;
input nmi;


wire bus_clk_en = 1'b1;
wire clk_ilm_ram;
wire [(15 - 2) - 1:0] ilm_addr;
wire [(4) - 1:0] ilm_byte_we;
wire ilm_cs;
wire [(32) - 1:0] ilm_wdata;
wire [(32) - 1:0] ilm_rdata;
wire clk_dlm_ram;
wire [(15 - 2) - 1:0] dlm_addr;
wire [(4) - 1:0] dlm_byte_we;
wire dlm_cs;
wire [(32) - 1:0] dlm_wdata;
wire [(32) - 1:0] dlm_rdata;
n22_core #(
    .DEBUG_INTERFACE(DEBUG_INTERFACE),
    .N22_CLIC_BASE_ADDR(N22_CLIC_BASE_ADDR),
    .N22_DEBUG_BASE_ADDR(N22_DEBUG_BASE_ADDR),
    .N22_DEVICE_REGION0_BASE(DEVICE_REGION0_BASE),
    .N22_DEVICE_REGION1_BASE(DEVICE_REGION1_BASE),
    .N22_DEVICE_REGION2_BASE(DEVICE_REGION2_BASE),
    .N22_DEVICE_REGION3_BASE(DEVICE_REGION3_BASE),
    .N22_DEVICE_REGION4_BASE(DEVICE_REGION4_BASE),
    .N22_DEVICE_REGION5_BASE(DEVICE_REGION5_BASE),
    .N22_DEVICE_REGION6_BASE(DEVICE_REGION6_BASE),
    .N22_DEVICE_REGION7_BASE(DEVICE_REGION7_BASE),
    .N22_DLM_BASE_ADDR(N22_DLM_BASE_ADDR),
    .N22_FIO_BASE_ADDR(N22_FIO_BASE_ADDR),
    .N22_ILM_BASE_ADDR(N22_ILM_BASE_ADDR),
    .N22_PPI_BASE_ADDR(N22_PPI_BASE_ADDR),
    .N22_TMR_BASE_ADDR(N22_TMR_BASE_ADDR),
    .PROGBUF_SIZE(PROGBUF_SIZE)
) n22_core (
    .dmactive(dmactive),
    .jtag_tck(jtag_tck),
    .jtag_tms(jtag_tms),
    .jtag_tdi(jtag_tdi),
    .jtag_tdo(jtag_tdo),
    .jtag_tdo_en(jtag_tdo_en),
    .disable_ext_debugger(disable_ext_debugger),
    .dbg_srst_req(dbg_srst_req),
    .hart_halted(hart_halted),
    .core_clk_aon(core_clk_aon),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .por_reset_n(por_rstn),
    .reset_bypass(reset_bypass),
    .clkgate_bypass(clkgate_bypass),
    .nmi(nmi),
    .meip(meip),
    .mtime_toggle_a(mtime_toggle_a),
    .clic_irq(int_src),
    .ilm_cs(ilm_cs),
    .ilm_addr(ilm_addr),
    .ilm_byte_we(ilm_byte_we),
    .ilm_wdata(ilm_wdata),
    .ilm_rdata(ilm_rdata),
    .clk_ilm_ram(clk_ilm_ram),
    .dlm_cs(dlm_cs),
    .dlm_addr(dlm_addr),
    .dlm_byte_we(dlm_byte_we),
    .dlm_wdata(dlm_wdata),
    .dlm_rdata(dlm_rdata),
    .clk_dlm_ram(clk_dlm_ram),
    .htrans(htrans),
    .hwrite(hwrite),
    .haddr(haddr),
    .hsize(hsize),
    .hburst(hburst),
    .hmastlock(hlock),
    .hwdata(hwdata),
    .hprot(hprot),
    .master(master),
    .hrdata(hrdata),
    .hresp({1'b0,hresp}),
    .hready(hready),
    .tx_evt(tx_evt),
    .rx_evt(rx_evt),
    .hart_id(hart_id),
    .reset_vector(reset_vector[32 - 1:0]),
    .core_wfi_mode(core_wfi_mode),
    .core_sleep_value(core_sleep_value)
);
n22_ilm_ram #(
    .ILM_ECC_TYPE("none"),
    .ILM_RAM_AW((15 - 2)),
    .ILM_RAM_BWEW(4),
    .ILM_RAM_DW(32)
) n22_ilm_ram (
    .core_clk(clk_ilm_ram),
    .ilm_cs(ilm_cs),
    .ilm_addr(ilm_addr),
    .ilm_byte_we(ilm_byte_we),
    .ilm_wdata(ilm_wdata),
    .ilm_rdata(ilm_rdata)
);
n22_dlm_ram #(
    .DLM_ECC_TYPE("none"),
    .DLM_RAM_AW((15 - 2)),
    .DLM_RAM_BWEW(4),
    .DLM_RAM_DW(32)
) n22_dlm_ram (
    .core_clk(clk_dlm_ram),
    .dlm_cs(dlm_cs),
    .dlm_byte_we(dlm_byte_we),
    .dlm_addr(dlm_addr),
    .dlm_wdata(dlm_wdata),
    .dlm_rdata(dlm_rdata)
);
endmodule

