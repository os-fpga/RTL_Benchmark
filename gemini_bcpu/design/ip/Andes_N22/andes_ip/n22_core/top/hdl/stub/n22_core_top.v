module n22_core_top (

	  hart_halted,

	  mtime_toggle_a,

	  int_src,

	  icache_disable_init,

	  fio_cmd_addr,
	  fio_cmd_dmode,
	  fio_cmd_mmode,
	  fio_cmd_read,
	  fio_cmd_valid,
	  fio_cmd_wdata,
	  fio_cmd_wmask,
	  fio_rsp_err,
	  fio_rsp_rdata,

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

	  dlm_haddr,
	  dlm_hburst,
	  dlm_hmastlock,
	  dlm_hprot,
	  dlm_hrdata,
	  dlm_hready,
	  dlm_hresp,
	  dlm_hsize,
	  dlm_htrans,
	  dlm_hwdata,
	  dlm_hwrite,
	  dlm_master,

	  ppi_dmode,
	  ppi_paddr,
	  ppi_penable,
	  ppi_pprot,
	  ppi_prdata,
	  ppi_pready,
	  ppi_psel,
	  ppi_pslverr,
	  ppi_pstrobe,
	  ppi_pwdata,
	  ppi_pwrite,

	  jtag_tck,
	  jtag_tdi,
	  jtag_tdo,
	  jtag_tms,
 
	  clkgate_bypass,
	  core_sleep_value,
	  hart_id,
	  reset_bypass,
	  rx_evt,
	  tx_evt,
	  meip,
	  por_rstn,
	  core_clk,
	  core_clk_aon,
	  core_reset_n,
	  core_wfi_mode,
	  reset_vector,
	  nmi
);



output        hart_halted         ;
input         mtime_toggle_a      ;
input         mtip                ;
input  [31:0] int_src             ;
input         icache_disable_init ;
output [13:0] fio_cmd_addr        ;
output        fio_cmd_dmode       ;
output        fio_cmd_mmode       ;
output        fio_cmd_read        ;
output        fio_cmd_valid       ;
output [31:0] fio_cmd_wdata       ;
output [ 3:0] fio_cmd_wmask       ;
input         fio_rsp_err         ;
input  [31:0] fio_rsp_rdata       ;
output        hlock               ;
input         hresp               ;
output [ 1:0] master              ;
input  [31:0] hrdata              ;
input         hready              ;
output [31:0] haddr               ;
output [ 2:0] hburst              ;
output [ 3:0] hprot               ;
output [ 2:0] hsize               ;
output [ 1:0] htrans              ;
output [31:0] hwdata              ;
output        hwrite              ;
output        dbg_srst_req        ;
input         disable_ext_debugger;
output [14:0] dlm_haddr           ;
output [ 2:0] dlm_hburst          ;
output        dlm_hmastlock       ;
output [ 3:0] dlm_hprot           ;
input  [31:0] dlm_hrdata          ;
input         dlm_hready          ;
input  [ 1:0] dlm_hresp           ;
output [ 2:0] dlm_hsize           ;
output [ 1:0] dlm_htrans          ;
output [31:0] dlm_hwdata          ;
output        dlm_hwrite          ;
output [ 1:0] dlm_master          ;
output        ppi_dmode           ;
output [13:0] ppi_paddr           ;
output        ppi_penable         ;
output [ 2:0] ppi_pprot           ;
input  [31:0] ppi_prdata          ;
input         ppi_pready          ;
output        ppi_psel            ;
input         ppi_pslverr         ;
output [ 3:0] ppi_pstrobe         ;
output [31:0] ppi_pwdata          ;
output        ppi_pwrite          ;
input         jtag_tck            ;
input         jtag_tdi            ;
output        jtag_tdo            ;
input         jtag_tms            ;
input         clkgate_bypass      ;
output        core_sleep_value    ;
input  [31:0] hart_id             ;
input         reset_bypass        ;
input         rx_evt              ;
output        tx_evt              ;
input         meip                ;
input         por_rstn            ;
input         core_clk            ;
input         core_clk_aon        ;
input         core_reset_n        ;
output        core_wfi_mode       ;
input  [31:0] reset_vector        ;
input         nmi                 ;


endmodule
