/********************************
 * Module: 	castor_top
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
********************************/
`include "castor_define.sv"
`include "ahb_if.sv"
`include "axi_rd_if.sv"
`include "axi_wr_if.sv"
module castor_top (
  input rst_n,
  input cfg_rst_n,
  input scan_rst_n,
  input cfg_tbufen_reset_n,
  input scan_en,
  input scan_mode,
  input scan_clk,
  input [3:0] clk,
  input scan_read,
  input scan_write,
  input [`SCAN_NUM-1:0] scan_i,
  input scan_cfg_done,
  input cfg_blsr_region_0_wen,
  input cfg_blsr_region_0_ren,
  input cfg_blsr_region_0_clk,
  input cfg_wlsr_region_0_ren,
  input cfg_wlsr_region_0_wen,
  input cfg_wlsr_region_0_clk,
  input [19:0] cfg_blsr_head_region_0,
  input        cfg_wlsr_head_region_0,
  input cfg_done,
  input cfg_tbufen_set_n,
  input cfg_wlen_r,
  input	pl_init	,
  input	pl_ena	,
  input	[1:0]	pl_wen,
  input	pl_ren	,
  input	[31:0]	pl_addr,
  input	[35:0]	pl_data,
  input [11:0] a2f_irq_set, // from SoC 
  input [ 3:0] a2f_dma_ack, // from SoC 
  input [`GBOX_DWID-1 : 0] gbox2fab_dbus [0: `FAB_GBOX_NUM-1], // from gbox
   ahb_if.tgt      fab_ahb_s0,
   axi_rd_if.init  fab_axi_m0_ar,
   axi_rd_if.init  fab_axi_m1_ar,
   axi_wr_if.init  fab_axi_m0_aw,
   axi_wr_if.init  fab_axi_m1_aw,
//**************************
  output logic [35:0] pl_data_out	 ,
  output logic [15:0] f2a_irq_src, // to SoC 
  output logic [ 3:0] f2a_dma_req, // to SoC 
  output logic [`GBOX_DWID-1 : 0] fab2gbox_dbus [0: `FAB_GBOX_NUM-1], // to gbox
  output logic [`FAB_GBOX_NUM-1:0] f2gbox_clk,   // to gbox
  output logic [`FAB_GBOX_NUM-1   : 0] fab_io_ie,  // to IO cell
  output logic [`FAB_GBOX_NUM-1   : 0] fab_io_oe,  // to IO cell
  output logic [`FAB_GBOX_NUM-1   : 0] fab_io_pe, // to IO cell
  output logic [`FAB_GBOX_NUM-1   : 0] fab_io_pud, // to IO cell
  output logic [`FAB_GBOX_NUM*2-1 : 0] fab_io_aic, // to IO cell
  output logic [`FAB_GBOX_NUM*2-1 : 0] fab_io_ds, // to IO cell
  output logic [`FAB_GBOX_NUM*2-1 : 0] fab_io_sr, // to IO cell
  output logic [`FAB_GBOX_NUM*2-1 : 0] fab_io_mc, // to IO cell
//  output logic [`FAB_GBOX_NUM/2-1 : 0] fab_io_por, // to IO cell
  output logic w_blsr_tail ,
  output logic cfg_blsr_tail_region_0 ,
  output logic cfg_wlsr_tail_region_0 ,
  output logic [`SCAN_NUM-1:0] scan_o
) ;
//*****************************************************************************
  logic [`A2F_BWID-1:0] gfpga_io_a2f;
  logic [`A2F_BWID-1 :0 ] gfpga_pad_io_f2a ;              
  logic [`DEF_BWID/2-1:0] gfpga_pad_io_def0 ;              
  logic [`DEF_BWID/2-1:0] gfpga_pad_io_def1 ;              
  logic [0:`A2F_BWID-1] gfpga_pad_io_f2a_clk ;              
//*****************************************************************************
 assign gfpga_pad_io_f2a_clk = '0 ; // missing in efpga_top_66x78
//*****************************************************************************
efpga_top  u_efpga_top( 
      .rst_ni         		(rst_n),                
      .cfg_rst_ni     		(cfg_rst_n),             
      .scan_rst_ni    		(scan_rst_n),
      .cfg_tbufen_reset_ni    	(cfg_tbufen_reset_n),
      .scan_en_i      		(scan_en),             
      .scan_mode_i    		(scan_mode),           
      .scan_clk_i     		(scan_clk),            
      .clk_i          		(clk),            
      .scan_read_i    		(scan_read),          
      .scan_write_i   		(scan_write),         
      .scan_i         		(scan_i[`SCAN_NUM-1:0]),           
      .scan_cfg_done_i   	(scan_cfg_done),         
      .gfpga_io_a2f_i    	(gfpga_io_a2f),              
      .cfg_blsr_region_0_wen_i	(cfg_blsr_region_0_wen), 
      .cfg_blsr_region_0_ren_i	(cfg_blsr_region_0_ren), 
      .cfg_blsr_region_0_clk_i	(cfg_blsr_region_0_clk), 
      .cfg_wlsr_region_0_ren_i	(cfg_wlsr_region_0_ren), 
      .cfg_wlsr_region_0_wen_i	(cfg_wlsr_region_0_wen), 
      .cfg_wlsr_region_0_clk_i	(cfg_wlsr_region_0_clk), 
      .cfg_blsr_region_0_i	(cfg_blsr_head_region_0), 
      .cfg_wlsr_region_0_i	(cfg_wlsr_head_region_0), 
      .cfg_done_i     		(cfg_done),              
      .cfg_tbufen_set_ni  	(cfg_tbufen_set_n),              
      .cfg_wlen_r_i    		(cfg_wlen_r),              
      .pl_init_i 		(pl_init),
      .pl_ena_i 		(pl_ena),
      .pl_weni 			(pl_wen),
      .pl_ren_i 		(pl_ren),
      .pl_addri 		(pl_addr),
      .pl_datai 		(pl_data),
//*************************
      .pl_data_o 		(pl_data_out),
      .cfg_blsr_region_0_o	(cfg_blsr_tail_region_0), 
      .cfg_wlsr_region_0_o	(cfg_wlsr_tail_region_0),
      .gfpga_pad_io_f2a_o	(gfpga_pad_io_f2a),              
      .gfpga_pad_io_def0_o	(gfpga_pad_io_def0),              
      .gfpga_pad_io_def1_o	(gfpga_pad_io_def1),              
//      .gfpga_pad_io_f2a_clk_o	(gfpga_pad_io_f2a_clk),              
      .scan_o			(scan_o[`SCAN_NUM-1:0]) ) ;          
//*****************************************************************************
map_box  #(.PAR_GBOX_DWID(`GBOX_DWID), 
           .PAR_FAB_GBOX_NUM(`FAB_GBOX_NUM),
           .PAR_A2F_BWID(`A2F_BWID),
		   .PAR_DEF_BWID(`DEF_BWID), 
		   .PAR_FAB_IO_NUM(`FAB_IO_NUM) ) u_map_box
( 
   .cfg_done      (cfg_done),    			// 0: in configuration, set OEN = 1 to force IO HiZ
   .io_f2a	  (gfpga_pad_io_f2a ),    // from fabric
   .io_f2a_clk	  (gfpga_pad_io_f2a_clk), // from fabric
   .io_def0	  (gfpga_pad_io_def0),    // from fabric default IO cell configuration 0
   .io_def1	  (gfpga_pad_io_def1 ),   // from fabric default IO cell configuration 1
   .gbox2f	  (gbox2fab_dbus),      // from GBOX
   .fab_ahb_s0    (fab_ahb_s0),
   .fab_axi_m0_ar (fab_axi_m0_ar),
   .fab_axi_m1_ar (fab_axi_m1_ar),
   .fab_axi_m0_aw (fab_axi_m0_aw),
   .fab_axi_m1_aw (fab_axi_m1_aw),
   .a2f_irq_set   (a2f_irq_set),
   .a2f_dma_ack   (a2f_dma_ack),
//**************************
   .f2a_irq_src (f2a_irq_src),
   .f2a_dma_req (f2a_dma_req),
   .f2gbox	(fab2gbox_dbus),      // to  GBOX  from io_f2a
   .io_a2f	(gfpga_io_a2f),     // to Fabric from gbox2f
   .f2gbox_clk	(f2gbox_clk), // slow clock to gbox   from fabric
   .fab_io_ie	(fab_io_ie), 
   .fab_io_oe	(fab_io_oe), //combine with dynamic OEN from logic and connected to IO cell
   .fab_io_pe	(fab_io_pe), 
   .fab_io_pud	(fab_io_pud), 
   .fab_io_aic	(fab_io_aic), 
   .fab_io_ds	(fab_io_ds), 
   .fab_io_sr	(fab_io_sr), 
///   .fab_io_por	(fab_io_por),
   .fab_io_mc	(fab_io_mc) ) ; 
//*****************************************************************************

endmodule 
