// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module ae250_cpu_subsystem (
    int_src,
    dbg_wakeup_req,
    test_mode,
    hart0_nmi,
    dbg_srst_req,
    dbg_tck,
    mtime_clk,
    pin_tdi_in,
    pin_tdi_out,
    pin_tdi_out_en,
    pin_tdo_in,
    pin_tdo_out,
    pin_tdo_out_en,
    pin_tms_in,
    pin_tms_out,
    pin_tms_out_en,
    pin_trst_in,
    pin_trst_out,
    pin_trst_out_en,
    por_rstn,
    core_clk,
    hart0_core_reset_n,
    hart0_core_wfi_mode,
    hart0_reset_vector,
    hart0_icache_disable_init,
    hart0_dcache_disable_init,
    ahb_bus_clk_en,
    hclk,
    hresetn,
    hrdata,
    hready,
    hresp,
    haddr,
    hsel,
    hburst,
    hprot,
    hsize,
    htrans,
    hwdata,
    hwrite
);
parameter NDS_CORE_PROGBUF_SIZE = 8;
parameter NDS_CORE_DEBUG_INTERFACE = "jtag";
parameter DEVICE_REGION0_BASE = 32'hffffffff;
parameter DEVICE_REGION0_MASK = 32'h00000000;
parameter WRITETHROUGH_REGION0_BASE = 32'h40000000;
parameter WRITETHROUGH_REGION0_MASK = 32'hc0000000;
parameter DEVICE_REGION1_BASE = 32'hffffffff;
parameter DEVICE_REGION1_MASK = 32'h00000000;
parameter WRITETHROUGH_REGION1_BASE = 32'hffffffff;
parameter WRITETHROUGH_REGION1_MASK = 32'h00000000;
parameter DEVICE_REGION2_BASE = 32'h00000000;
parameter DEVICE_REGION2_MASK = 32'hffffffff;
parameter WRITETHROUGH_REGION2_BASE = 32'hffffffff;
parameter WRITETHROUGH_REGION2_MASK = 32'h00000000;
parameter DEVICE_REGION3_BASE = 32'h00000000;
parameter DEVICE_REGION3_MASK = 32'hffffffff;
parameter WRITETHROUGH_REGION3_BASE = 32'hffffffff;
parameter WRITETHROUGH_REGION3_MASK = 32'h00000000;
parameter DEVICE_REGION4_BASE = 32'h00000000;
parameter DEVICE_REGION4_MASK = 32'hffffffff;
parameter WRITETHROUGH_REGION4_BASE = 32'hffffffff;
parameter WRITETHROUGH_REGION4_MASK = 32'h00000000;
parameter DEVICE_REGION5_BASE = 32'h00000000;
parameter DEVICE_REGION5_MASK = 32'hffffffff;
parameter WRITETHROUGH_REGION5_BASE = 32'hffffffff;
parameter WRITETHROUGH_REGION5_MASK = 32'h00000000;
parameter DEVICE_REGION6_BASE = 32'h00000000;
parameter DEVICE_REGION6_MASK = 32'hffffffff;
parameter WRITETHROUGH_REGION6_BASE = 32'hffffffff;
parameter WRITETHROUGH_REGION6_MASK = 32'h00000000;
parameter DEVICE_REGION7_BASE = 32'h00000000;
parameter DEVICE_REGION7_MASK = 32'hffffffff;
parameter WRITETHROUGH_REGION7_BASE = 32'hffffffff;
parameter WRITETHROUGH_REGION7_MASK = 32'h00000000;
parameter N22_DEBUG_BASE_ADDR = 32'he6800000;
parameter N22_ILM_BASE_ADDR = 32'hFFFB0000;
parameter N22_DLM_BASE_ADDR = 32'hfffD0000;
parameter N22_PPI_BASE_ADDR = 32'hf2100000;
parameter N22_FIO_BASE_ADDR = 32'hf2200000;
parameter N22_TMR_BASE_ADDR = 32'he6000000;
parameter N22_CLIC_BASE_ADDR = 32'he2000000;
localparam CLIC_EXT_IRQ_NUM = 32;
localparam CLIC_IRQ_TOP = 30;

input  [  31:1] int_src                  ;
output          dbg_wakeup_req           ;
input           test_mode                ;
input           hart0_nmi                ;
output          dbg_srst_req             ;
input           dbg_tck                  ;
input           mtime_clk                ;
input           pin_tdi_in               ;
output          pin_tdi_out              ;
output          pin_tdi_out_en           ;
input           pin_tdo_in               ;
output          pin_tdo_out              ;
output          pin_tdo_out_en           ;
input           pin_tms_in               ;
output          pin_tms_out              ;
output          pin_tms_out_en           ;
input           pin_trst_in              ;
output          pin_trst_out             ;
output          pin_trst_out_en          ;
input           por_rstn                 ;
input           core_clk                 ;
input           hart0_core_reset_n       ;
output          hart0_core_wfi_mode      ;
input  [32-1:0] hart0_reset_vector       ;
input           hart0_icache_disable_init;
input           hart0_dcache_disable_init;
input           ahb_bus_clk_en           ;
input           hclk                     ;
input           hresetn                  ;
input  [  31:0] hrdata                   ;
input           hready                   ;
input  [   1:0] hresp                    ;
output [32-1:0] haddr                    ;
output          hsel                     ;
output [   2:0] hburst                   ;
output [   3:0] hprot                    ;
output [   2:0] hsize                    ;
output [   1:0] htrans                   ;
output [  31:0] hwdata                   ;
output          hwrite                   ;


reg             mtime_toggle_a  ;
wire [(32-1):0] clic_irq_r      ;
wire            dmactive_private;
wire            dmactive        ;
wire [(32-1):0] hart0_hart_id   ;
wire [     0:0] debugint        ;
wire            meip            ;
wire            msip            ;
wire [     0:0] mtip            ;
wire [     0:0] resethaltreq    ;
wire [     0:0] hart_halted     ;
wire [     0:0] hart_unavail    ;
wire [     0:0] hart_under_reset;
wire [(32)-1:0] hl2h_haddr      ;
wire [     2:0] hl2h_hburst     ;
wire            hl2h_hmastlock  ;
wire [     3:0] hl2h_hprot      ;
wire [     2:0] hl2h_hsize      ;
wire [     1:0] hl2h_htrans     ;
wire            hl2h_hwrite     ;
wire            stoptime        ;
wire [    31:0] uncore_hwdata   ;
wire            meip_r          ;
wire            hart0_nmi_r     ;
wire            hl2h_hready     ;
wire            hl2h_hresp      ;

logic [   31:0] rom_hrdata      ;
wire            rom_hreadyout   ;
wire [     1:0] rom_hresp       ;
wire            rom_hsel        ;
reg             rom_hsel_d1     ;
wire            rom_hsel_nxt    ;
reg             rsnoc_hsel_d1   ;
wire            rsnoc_hsel_nxt  ;
wire [    13:0] rombrg_addr     ;
wire [     3:0] rombrg_web      ;
wire            rombrg_csb      ;
wire            us_hready       ;
wire [     1:0] us_hresp        ;
wire [    31:0] us_hrdata       ;


assign dbg_wakeup_req = 1'b0;
assign hart0_hart_id = {32{1'b0}};
always @(posedge mtime_clk or negedge hart0_core_reset_n) begin
    if (!hart0_core_reset_n) begin
        mtime_toggle_a <= 1'b0;
    end
    else begin
        mtime_toggle_a <= ~mtime_toggle_a;
    end
end

assign pin_tdi_out_en = 1'b0;
assign pin_tdi_out = 1'b0;
assign pin_tms_out_en = 1'b0;
assign pin_tms_out = 1'b0;
assign pin_trst_out_en = 1'b0;
assign pin_trst_out = 1'b0;

generate
    genvar clic_irq_source;
    for (clic_irq_source = 0; clic_irq_source < CLIC_EXT_IRQ_NUM; clic_irq_source = clic_irq_source + 1) begin:gen_clic_irq_synchronizer
        if (clic_irq_source > CLIC_IRQ_TOP) begin:gen_clic_irq_gt_irq_top
            assign clic_irq_r[clic_irq_source] = 1'b0;
        end
        else begin:gen_clic_irq_le_ire_top
            nds_sync_l2l nds_sync_l2l_clic_irq (
                .b_reset_n                  (hart0_core_reset_n          ),
                .b_clk                      (core_clk                    ),
                .a_signal                   (int_src[clic_irq_source + 1]),
                .b_signal                   (clic_irq_r[clic_irq_source] ),
                .b_signal_rising_edge_pulse (                            ),
                .b_signal_falling_edge_pulse(                            ),
                .b_signal_edge_pulse        (                            )
            );
        end
    end
endgenerate

assign hwdata           = uncore_hwdata;
assign dmactive         = 1'b0 | dmactive_private;
assign hart_unavail     = 1'bx;
assign hart_under_reset = 1'bx;
assign stoptime         = 1'bx;
assign mtip             = 1'b0;
assign msip             = 1'b0;
assign debugint         = 1'b0;
assign resethaltreq     = 1'b0;
assign meip             = 1'b0;

n22_core_top #(
    .DEBUG_INTERFACE    (NDS_CORE_DEBUG_INTERFACE),
    .DEVICE_REGION0_BASE(DEVICE_REGION0_BASE     ),
    .DEVICE_REGION1_BASE(DEVICE_REGION1_BASE     ),
    .DEVICE_REGION2_BASE(DEVICE_REGION2_BASE     ),
    .DEVICE_REGION3_BASE(DEVICE_REGION3_BASE     ),
    .DEVICE_REGION4_BASE(DEVICE_REGION4_BASE     ),
    .DEVICE_REGION5_BASE(DEVICE_REGION5_BASE     ),
    .DEVICE_REGION6_BASE(DEVICE_REGION6_BASE     ),
    .DEVICE_REGION7_BASE(DEVICE_REGION7_BASE     ),
    .N22_CLIC_BASE_ADDR (N22_CLIC_BASE_ADDR      ),
    .N22_DEBUG_BASE_ADDR(N22_DEBUG_BASE_ADDR     ),
    .N22_DLM_BASE_ADDR  (N22_DLM_BASE_ADDR       ),
    .N22_FIO_BASE_ADDR  (N22_FIO_BASE_ADDR       ),
    .N22_ILM_BASE_ADDR  (N22_ILM_BASE_ADDR       ),
    .N22_PPI_BASE_ADDR  (N22_PPI_BASE_ADDR       ),
    .N22_TMR_BASE_ADDR  (N22_TMR_BASE_ADDR       ),
    .PROGBUF_SIZE       (NDS_CORE_PROGBUF_SIZE   )
) n22_core_top (
    .hart_halted         (hart_halted        ),
    .mtime_toggle_a      (mtime_toggle_a     ),
    .int_src             (clic_irq_r         ),
    .hlock               (hl2h_hmastlock     ),
    .hresp               (hl2h_hresp         ),
    .master              (                   ),
    .hrdata              (us_hrdata          ),
    .hready              (hl2h_hready        ),
    .haddr               (hl2h_haddr         ),
    .hburst              (hl2h_hburst        ),
    .hprot               (hl2h_hprot         ),
    .hsize               (hl2h_hsize         ),
    .htrans              (hl2h_htrans        ),
    .hwdata              (uncore_hwdata      ),
    .hwrite              (hl2h_hwrite        ),
    .dbg_srst_req        (dbg_srst_req       ),
    .disable_ext_debugger(1'b0               ),
    .dmactive            (dmactive_private   ),
    .jtag_tck            (dbg_tck            ),
    .jtag_tdi            (pin_tdi_in         ),
    .jtag_tdo            (pin_tdo_out        ),
    .jtag_tdo_en         (pin_tdo_out_en     ),
    .jtag_tms            (pin_tms_in         ),
    .clkgate_bypass      (1'b0               ),
    .core_sleep_value    (                   ),
    .hart_id             (hart0_hart_id      ),
    .meip                (meip_r             ),
    .reset_bypass        (1'b0               ),
    .rx_evt              (1'b0               ),
    .tx_evt              (                   ),
    .por_rstn            (por_rstn           ),
    .core_clk            (core_clk           ),
    .core_clk_aon        (core_clk           ),
    .core_reset_n        (hart0_core_reset_n ),
    .core_wfi_mode       (hart0_core_wfi_mode),
    .reset_vector        (hart0_reset_vector ),
    .nmi                 (hart0_nmi_r        )
);
nds_sync_l2l nds_sync_l2l_nmi (
    .b_reset_n                  (hart0_core_reset_n),
    .b_clk                      (core_clk          ),
    .a_signal                   (hart0_nmi         ),
    .b_signal                   (hart0_nmi_r       ),
    .b_signal_rising_edge_pulse (                  ),
    .b_signal_falling_edge_pulse(                  ),
    .b_signal_edge_pulse        (                  )
);
nds_sync_l2l nds_sync_l2l_meip (
    .b_reset_n                  (hart0_core_reset_n),
    .b_clk                      (core_clk          ),
    .a_signal                   (meip              ),
    .b_signal                   (meip_r            ),
    .b_signal_rising_edge_pulse (                  ),
    .b_signal_falling_edge_pulse(                  ),
    .b_signal_edge_pulse        (                  )
);
atchl2h200 #(.ADDR_WIDTH(32)) u_hl2h (
    .hclk        (hclk          ),
    .hresetn     (hresetn       ),
    .us_haddr    (hl2h_haddr    ),
    .us_hburst   (hl2h_hburst   ),
    .us_hprot    (hl2h_hprot    ),
    .us_hsize    (hl2h_hsize    ),
    .us_htrans   (hl2h_htrans   ),
    .us_hmastlock(hl2h_hmastlock),
    .ds_hlock    (              ),
    .ds_hmastlock(              ),
    .us_hwrite   (hl2h_hwrite   ),
    .us_hreadyout(hl2h_hready   ),
    .us_hresp    (hl2h_hresp    ),
    .ds_hbusreq  (              ),
    .ds_hgrant   (1'b1          ),
    .us_hready   (1'b1          ),
    .us_hsel     (1'h1          ),
    .ds_haddr    (haddr         ),
    .ds_htrans   (htrans        ),
    .ds_hwrite   (hwrite        ),
    .ds_hsize    (hsize         ),
    .ds_hburst   (hburst        ),
    .ds_hprot    (hprot         ),
    .ds_hready   (us_hready     ),
    .ds_hresp    (us_hresp      )
);


assign rom_hsel = (htrans == 2'b0) ? 1'b0 : (haddr[31:16] ==  16'hFFFF);


assign  rom_hsel_nxt = (us_hready) ? rom_hsel : rom_hsel_d1;

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) rom_hsel_d1 <= 1'b0;
    else          rom_hsel_d1 <= rom_hsel_nxt;
end      

assign hsel =  (htrans == 2'b0) ? 1'b0 : (haddr[31:16] <  16'hFFFF);

assign  rsnoc_hsel_nxt = (us_hready) ? hsel : rsnoc_hsel_d1;

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) rsnoc_hsel_d1 <= 1'b0;
    else          rsnoc_hsel_d1 <= rsnoc_hsel_nxt;
end      


assign us_hready =     (rom_hsel_d1   & rom_hreadyout) |     (rsnoc_hsel_d1   & hready) | ~(rom_hsel_d1 | rsnoc_hsel_d1);
assign us_hresp  =  ({2{rom_hsel_d1}} & rom_hresp)     |  ({2{rsnoc_hsel_d1}} & hresp);
assign us_hrdata = ({32{rom_hsel_d1}} & rom_hrdata)    | ({32{rsnoc_hsel_d1}} & hrdata);

assign rom_hresp[1] = 1'b0;

atcrambrg200 #(
    .DATA_WIDTH     (32    ),
    .MIN_WDATA_WIDTH(32    ),
    .ADDR_WIDTH     (20    ),
    .MEM_SIZE_KB    (64'd64),
    .OOR_ERR_EN     (0     )
) rom_bridge (
    .hclk     (hclk         ),
    .hresetn  (hresetn      ),
    .hsel     (rom_hsel     ),
    .hready   (rom_hreadyout),
    .haddr    (haddr[19:0]  ),
    .hwrite   (hwrite       ),
    .htrans   (htrans       ),
    .hsize    (hsize        ),
    .hburst   (hburst       ),
    .hprot    (hprot        ),
    .hreadyout(rom_hreadyout),
    .hresp    (rom_hresp[0] ),
    .mem_csb  (rombrg_csb   ),
    .mem_web  (rombrg_web   ),
    .mem_addr (rombrg_addr  )
);


dti_rom_tm16ffcll_16384x32_t321xoe_m_a n22_rom (
    .VDD   (1'b1       ),
    .VSS   (1'b0       ),
    .DO    (rom_hrdata ),
    .A     (rombrg_addr),
    .T_A   (12'h0      ),
    .T_BE_N(1'b1       ),
    .CE_N  (~rombrg_csb),
    .T_CE_N(1'b1       ),
    .T_OE_N(1'b1       ),
    .OE_N  (1'b0       ),
    .T_RM  (3'b011     ),
    .CLK   (hclk       )
);


endmodule
