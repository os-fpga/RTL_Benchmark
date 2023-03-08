// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module ae350_cpu_subsystem (
	  arid,
	  araddr,
	  arlen,
	  arsize,
	  arburst,
	  arlock,
	  arcache,
	  arprot,
	  arvalid,
	  arready,
	  awid,
	  awaddr,
	  awlen,
	  awsize,
	  awburst,
	  awlock,
	  awcache,
	  awprot,
	  awvalid,
	  awready,
	  wdata,
	  wstrb,
	  wlast,
	  wvalid,
	  wready,
	  bid,
	  bresp,
	  bvalid,
	  bready,
	  rid,
	  rdata,
	  rresp,
	  rlast,
	  rvalid,
	  rready,
	  axi_bus_clk_en,
	  core_clk,
	  core_resetn,
	  dbg_srst_req,
	  dc_clk,
	  hart0_wakeup_event,
	  lm_clk,
	  test_rstn,
	  aclk,
	  aresetn,
	  scan_enable,
	  test_mode,
	  int_src,
	  mtime_clk,
	  por_rstn,
	  slvp_resetn,
	  hart0_reset_vector,
	  hart0_icache_disable_init,
	  hart0_dcache_disable_init,
	  hart0_core_wfi_mode,
	  hart0_nmi,
      jtag_tck,
      jtag_tdi,
      jtag_tdo,
      jtag_tms  
);


output [ 3:0] arid                     ;
output [31:0] araddr                   ;
output [ 7:0] arlen                    ;
output [ 2:0] arsize                   ;
output [ 1:0] arburst                  ;
output        arlock                   ;
output [ 3:0] arcache                  ;
output [ 2:0] arprot                   ;
output        arvalid                  ;
input         arready                  ;
output [ 3:0] awid                     ;
output [31:0] awaddr                   ;
output [ 7:0] awlen                    ;
output [ 2:0] awsize                   ;
output [ 1:0] awburst                  ;
output        awlock                   ;
output [ 3:0] awcache                  ;
output [ 2:0] awprot                   ;
output        awvalid                  ;
input         awready                  ;
output [63:0] wdata                    ;
output [ 7:0] wstrb                    ;
output        wlast                    ;
output        wvalid                   ;
input         wready                   ;
input  [ 3:0] bid                      ;
input  [ 1:0] bresp                    ;
input         bvalid                   ;
output        bready                   ;
input  [ 3:0] rid                      ;
input  [63:0] rdata                    ;
input  [ 1:0] rresp                    ;
input         rlast                    ;
input         rvalid                   ;
output        rready                   ;
input         axi_bus_clk_en           ;
input         core_clk                 ;
input         core_resetn              ;
output        dbg_srst_req             ;
input         dc_clk                   ;
output [ 5:0] hart0_wakeup_event       ;
input         lm_clk                   ;
input         test_rstn                ;
input         aclk                     ;
input         aresetn                  ;
input         scan_enable              ;
input         test_mode                ;
input  [31:1] int_src                  ;
input         mtime_clk                ;
input         por_rstn                 ;
input         slvp_resetn              ;
input  [31:0] hart0_reset_vector       ;
input         hart0_icache_disable_init;
input         hart0_dcache_disable_init;
output        hart0_core_wfi_mode      ;
input         hart0_nmi                ;
input         jtag_tck                 ;
input         jtag_tdi                 ;
output        jtag_tdo                 ;
input         jtag_tms                 ;


assign arid                = 'h0;
assign araddr              = 'h0;
assign arlen               = 'h0;
assign arsize              = 'h0;
assign arburst             = 'h0;
assign arlock              = 'h0;
assign arcache             = 'h0;
assign arprot              = 'h0;
assign arvalid             = 'h0;
assign awid                = 'h0;
assign awaddr              = 'h0;
assign awlen               = 'h0;
assign awsize              = 'h0;
assign awburst             = 'h0;
assign awlock              = 'h0;
assign awcache             = 'h0;
assign awprot              = 'h0;
assign awvalid             = 'h0;
assign wdata               = 'h0;
assign wstrb               = 'h0;
assign wlast               = 'h0;
assign wvalid              = 'h0;
assign bready              = 'h0;
assign rready              = 'h0;
assign dbg_srst_req        = 'h0;
assign hart0_wakeup_event  = 'h0;
assign hart0_core_wfi_mode = 'h0;
assign jtag_tdo            = 'h0;


endmodule
