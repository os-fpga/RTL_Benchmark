/********************************
 * Module: 	map_box
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 * mapping box between Fabric and IO , supposed to be filled by VPR
********************************/

module map_box
#(
parameter PAR_GBOX_DWID  = 10 , 
parameter PAR_FAB_GBOX_NUM  = 380 , 
parameter PAR_A2F_BWID  = 5760 , 
parameter PAR_DEF_BWID = PAR_A2F_BWID * 2 ,
parameter PAR_FAB_IO_NUM = 380 ,
parameter PAR_FAB_GBOX_DWID  = PAR_GBOX_DWID * PAR_FAB_GBOX_NUM  
)
( 
   input logic cfg_done,    // 0: in configuration, set OEN = 1 to force IO HiZ
   input logic [PAR_A2F_BWID-1:0] io_f2a,      // from fabric
   input logic [PAR_A2F_BWID-1:0] io_f2a_clk,  // from fabric
   input logic [PAR_DEF_BWID-1:0] io_def0,     // from fabric default IO cell configuration 0
   input logic [PAR_DEF_BWID-1:0] io_def1,     // from fabric default IO cell configuration 1
   input logic [PAR_GBOX_DWID-1 : 0] gbox2f [PAR_FAB_GBOX_NUM-1 : 0] ,      // from GBOX
   ahb_if.tgt      fab_ahb_s0,
   axi_rd_if.init  fab_axi_m0_ar,
   axi_rd_if.init  fab_axi_m1_ar,
   axi_wr_if.init  fab_axi_m0_aw,
   axi_wr_if.init  fab_axi_m1_aw,
   input logic [11:0] a2f_irq_set, // 
   input logic [ 3:0] a2f_dma_ack, // 
//**************************
   output logic [15:0] f2a_irq_src,      // to  SoC from io_f2a
   output logic [ 3:0] f2a_dma_req,      // to  SoC from io_f2a
   output logic [PAR_GBOX_DWID-1 : 0] f2gbox [PAR_FAB_GBOX_NUM-1 : 0],      // to  GBOX  from io_f2a
   output logic [PAR_A2F_BWID-1:0] io_a2f,      // to Fabric from gbox2f
   output logic [PAR_FAB_GBOX_NUM-1:0] f2gbox_clk,  // to gbox   from fabric
   output logic [PAR_FAB_GBOX_NUM-1:0] fab_io_ie,   // to IO cell from fabric
   output logic [PAR_FAB_GBOX_NUM-1   : 0] fab_io_oe,   // to IO cell from fabric, needs to 0 to tri-state the IO output
   output logic [PAR_FAB_GBOX_NUM-1   : 0] fab_io_pe,   // 
   output logic [PAR_FAB_GBOX_NUM-1   : 0] fab_io_pud,   // 
   output logic [PAR_FAB_GBOX_NUM*2-1 : 0] fab_io_aic,   // 
   output logic [PAR_FAB_GBOX_NUM*2-1 : 0] fab_io_ds,   // 
   output logic [PAR_FAB_GBOX_NUM*2-1 : 0] fab_io_sr,   //
///   fab_io_por, 
   output logic [PAR_FAB_GBOX_NUM*2-1 : 0] fab_io_mc ) ;   //
//********************************************************************
//********************************************************************
//********************************************************************
//************** mapping --> supposed to be filled up by VPR
//********************************************************************
//********************************************************************
//********************************************************************
//****** route io_f2a data to gbox parallel bus
assign f2gbox = io_f2a[PAR_FAB_GBOX_DWID-1:0] ; // error ?? use function to convert 1d array to 2d array
//**********************************************
//**********************************************
//****** route gbox parallel bus to fabric
assign io_a2f[PAR_FAB_GBOX_DWID-1:0] = gbox2f ; // error ?? use function to convert 2d array to 1d array
assign io_a2f[PAR_A2F_BWID-1:PAR_FAB_GBOX_DWID] = '0 ;
//**********************************************
//**********************************************
//****** route clock from fabric gbox slow clock
assign f2gbox_clk = io_f2a_clk[PAR_FAB_GBOX_NUM-1:0] ;
//**********************************************
//**********************************************
//****** route f2a default data to IO configurable mode input 
///assign io_cfg_oen = io_def0[PAR_FAB_IO_NUM-1:0] ;
//**********************************************
assign fab_axi_m0_ar.araddr    = '0 ; // from Fab
assign fab_axi_m0_ar.arburst   = '0 ; // from Fab
assign fab_axi_m0_ar.arcache   = '0 ; // from Fab
assign fab_axi_m0_ar.arid      = '0 ; // from Fab
assign fab_axi_m0_ar.arlen     = '0 ; // from Fab
assign fab_axi_m0_ar.arlock    = '0 ; // from Fab
assign fab_axi_m0_ar.arprot    = '0 ; // from Fab
assign fab_axi_m0_ar.arsize    = '0 ; // from Fab
assign fab_axi_m0_ar.arvalid   = '0 ; // from Fab
assign fab_axi_m0_aw.awaddr    = '0 ; // from Fab
assign fab_axi_m0_aw.awburst   = '0 ; // from Fab
assign fab_axi_m0_aw.awcache   = '0 ; // from Fab
assign fab_axi_m0_aw.awid      = '0 ; // from Fab
assign fab_axi_m0_aw.awlen     = '0 ; // from Fab
assign fab_axi_m0_aw.awlock    = '0 ; // from Fab
assign fab_axi_m0_aw.awprot    = '0 ; // from Fab
assign fab_axi_m0_aw.awsize    = '0 ; // from Fab
assign fab_axi_m0_aw.awvalid   = '0 ; // from Fab
assign fab_axi_m0_aw.bready    = '0 ; // from Fab
assign fab_axi_m0_ar.rready    = '0 ; // from Fab
assign fab_axi_m0_aw.wdata     = '0 ; // from Fab
assign fab_axi_m0_aw.wlast     = '0 ; // from Fab
assign fab_axi_m0_aw.wstrb     = '0 ; // from Fab
assign fab_axi_m0_aw.wvalid    = '0 ; // from Fab

//* these are inputs to fab
//***    .fab_axi_m0_ar.arready   
//***    .fab_axi_m0_aw_ready       (fab_axi_m0_aw.wready ),
//***    .fab_axi_m0_b_id           (fab_axi_m0_aw.bid ),
//***    .fab_axi_m0_b_resp         (fab_axi_m0_aw.bresp ),
//***    .fab_axi_m0_b_valid        (fab_axi_m0_aw.bvalid ),
//***    .fab_axi_m0_r_data         (fab_axi_m0_ar.rdata ),
//***    .fab_axi_m0_r_id           (fab_axi_m0_ar.rid ),
//***    .fab_axi_m0_r_last         (fab_axi_m0_ar.rlast ),
//***    .fab_axi_m0_r_resp         (fab_axi_m0_ar.rresp ),
//***    .fab_axi_m0_r_valid        (fab_axi_m0_ar.rvalid ),
//***    .fab_axi_m0_w_ready        (fab_axi_m0_aw.wready ),
//**********************************************
assign fab_ahb_s0.hrdata  = '0 ; // from Fab
assign fab_ahb_s0.hready  = '0 ; // from Fab
assign fab_ahb_s0.hresp   = '0 ; // from Fab

//* these are inputs to fab
//***    .fpga_ahb_s0_haddr          (fpga_ahb_s0.haddr ), 
//***    .fpga_ahb_s0_hburst         (fpga_ahb_s0.hburst ),
//***    .fpga_ahb_s0_hmastlock      (fpga_ahb_s0.hmastlock ),
//***    .fpga_ahb_s0_hprot          (fpga_ahb_s0.hprot ),
//***    .fpga_ahb_s0_hrdata         (fpga_ahb_s0.hrdata  ), // from Fab
//***    .fpga_ahb_s0_hready         (fpga_ahb_s0.hready  ), // from Fab
//***    .fpga_ahb_s0_hresp          (fpga_ahb_s0.hresp  ), // from Fab
//***    .fpga_ahb_s0_hsel           (fpga_ahb_s0.hsel ),
//***    .fpga_ahb_s0_hsize          (fpga_ahb_s0.hsize ),
//***    .fpga_ahb_s0_htrans         (fpga_ahb_s0.htrans ),
//***    .fpga_ahb_s0_hwbe           (fpga_ahb_s0.hwbe ),
//***    .fpga_ahb_s0_hwdata         (fpga_ahb_s0.hwdata ),
//***    .fpga_ahb_s0_hwrite         (fpga_ahb_s0.hwrite ),
//**********************************************
assign fab_io_oe = cfg_done ?  io_def0[PAR_FAB_IO_NUM-1:0] : '0 ;
//**********************************************

endmodule
