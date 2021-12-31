`include "sys.h"
`include "iop.h"
`include "sctag.h"

module sctag (/*AUTOARG*/
   // Outputs
   sctag_cpx_req_cq, sctag_cpx_atom_cq, sctag_cpx_data_ca, 
   sctag_pcx_stall_pq, sctag_jbi_por_req, sctag_scdata_way_sel_c2, 
   sctag_scdata_rd_wr_c2, sctag_scdata_set_c2, 
   sctag_scdata_col_offset_c2, sctag_scdata_word_en_c2, 
   sctag_scdata_fbrd_c3, sctag_scdata_fb_hit_c3, 
   sctag_scdata_stdecc_c2, sctag_scbuf_stdecc_c3, 
   sctag_scbuf_fbrd_en_c3, sctag_scbuf_fbrd_wl_c3, 
   sctag_scbuf_fbwr_wen_r2, sctag_scbuf_fbwr_wl_r2, 
   sctag_scbuf_fbd_stdatasel_c3, sctag_scbuf_wbwr_wen_c6, 
   sctag_scbuf_wbwr_wl_c6, sctag_scbuf_wbrd_en_r0, 
   sctag_scbuf_wbrd_wl_r0, sctag_scbuf_ev_dword_r0, 
   sctag_scbuf_evict_en_r0, sctag_scbuf_rdma_wren_s2, 
   sctag_scbuf_rdma_wrwl_s2, sctag_scbuf_rdma_rdwl_r0, 
   sctag_scbuf_rdma_rden_r0, sctag_scbuf_ctag_en_c7, 
   sctag_scbuf_ctag_c7, sctag_scbuf_word_c7, sctag_scbuf_req_en_c7, 
   sctag_scbuf_word_vld_c7, sctag_dram_rd_req, 
   sctag_dram_rd_dummy_req, sctag_dram_rd_req_id, sctag_dram_addr, 
   sctag_dram_wr_req, sctag_jbi_iq_dequeue, sctag_jbi_wib_dequeue, 
   sctag_dbgbus_out, sctag_clk_tr, sctag_ctu_mbistdone, 
   sctag_ctu_mbisterr, sctag_ctu_scanout, sctag_scbuf_scanout, 
   sctag_efc_fuse_data, 
   // Inputs
   pcx_sctag_data_rdy_px1, pcx_sctag_data_px2, pcx_sctag_atm_px1, 
   cpx_sctag_grant_cx, scdata_sctag_decc_c6, scbuf_sctag_ev_uerr_r5, 
   scbuf_sctag_ev_cerr_r5, scbuf_sctag_rdma_uerr_c10, 
   scbuf_sctag_rdma_cerr_c10, dram_sctag_rd_ack, dram_sctag_wr_ack, 
   dram_sctag_chunk_id_r0, dram_sctag_data_vld_r0, 
   dram_sctag_rd_req_id_r0, dram_sctag_secc_err_r2, 
   dram_sctag_mecc_err_r2, dram_sctag_scb_mecc_err, 
   dram_sctag_scb_secc_err, jbi_sctag_req_vld, jbi_sctag_req, arst_l, 
   grst_l, adbginit_l, gdbginit_l, cluster_cken, cmp_gclk, 
   global_shift_enable, ctu_sctag_mbisten, ctu_sctag_scanin, 
   scdata_sctag_scanout, ctu_tst_macrotest, ctu_tst_pre_grst_l, 
   ctu_tst_scan_disable, ctu_tst_scanmode, ctu_tst_short_chain, 
   efc_sctag_fuse_clk1, efc_sctag_fuse_clk2, efc_sctag_fuse_ashift, 
   efc_sctag_fuse_dshift, efc_sctag_fuse_data
   );

//////////////////////////////////////////////////////////////////////////////
// CCX interface
//////////////////////////////////////////////////////////////////////////////

output [7:0]             sctag_cpx_req_cq;   // sctag to processor request
output                   sctag_cpx_atom_cq;
output [`CPX_WIDTH-1:0]  sctag_cpx_data_ca;  // sctag to cpx data pkt
output                   sctag_pcx_stall_pq; // sctag to pcx IQ_full stall
output  		sctag_jbi_por_req ;

input			pcx_sctag_data_rdy_px1;
input [`PCX_WIDTH-1:0]   pcx_sctag_data_px2;   // pcx to sctag packet
input			pcx_sctag_atm_px1; // indicates that the current packet is atm with the next 
input	[7:0]		cpx_sctag_grant_cx;

//////////////////////////////////////////////////////////////////////////////
// Interface with scdata
//////////////////////////////////////////////////////////////////////////////

output	[11:0]	sctag_scdata_way_sel_c2;
output	      	sctag_scdata_rd_wr_c2;
output	[9:0]	sctag_scdata_set_c2;
output	[3:0]	sctag_scdata_col_offset_c2;
output	[15:0]	sctag_scdata_word_en_c2;
// output 	[3:0]	sctag_scdata_l2d_cbit;// self time margin programmable parameter REMOVED POST_4.0
output          sctag_scdata_fbrd_c3;   // From arbctl of sctag_arbctl.v
output          sctag_scdata_fb_hit_c3; // bypass data from Fb 
output [77:0]   sctag_scdata_stdecc_c2;// store data. 

input [155:0]   scdata_sctag_decc_c6;    // From data of scdata_data.v

//////////////////////////////////////////////////////////////////////////////
// Interface with scbuf
//////////////////////////////////////////////////////////////////////////////

output [77:0]   sctag_scbuf_stdecc_c3;// store data. staged version to scbuf
output		sctag_scbuf_fbrd_en_c3; // rd en for a fill operation or fb bypass
output	[2:0]	sctag_scbuf_fbrd_wl_c3 ; // read entry
output	[15:0]	sctag_scbuf_fbwr_wen_r2 ; // dram Fill or store in OFF mode.
output	[2:0]	sctag_scbuf_fbwr_wl_r2 ; // dram Fill entry.
output		sctag_scbuf_fbd_stdatasel_c3; // select store data in OFF mode

output	[3:0]	sctag_scbuf_wbwr_wen_c6; // write en
output	[2:0]	sctag_scbuf_wbwr_wl_c6; // from wbctl
output		sctag_scbuf_wbrd_en_r0; // triggerred by a wr_ack from dram
output	[2:0]	sctag_scbuf_wbrd_wl_r0; 

output	[2:0]	sctag_scbuf_ev_dword_r0;
output          sctag_scbuf_evict_en_r0;// From wbctl of sctag_wbctl.v
input		scbuf_sctag_ev_uerr_r5;
input		scbuf_sctag_ev_cerr_r5;



// START interface with scbuf for handling rdma  reads and writes
output	[15:0]	sctag_scbuf_rdma_wren_s2; // may be all 1s
output	[1:0]	sctag_scbuf_rdma_wrwl_s2;
output	[1:0]	sctag_scbuf_rdma_rdwl_r0;
output		sctag_scbuf_rdma_rden_r0;

output		sctag_scbuf_ctag_en_c7 ;
output	[14:0]	sctag_scbuf_ctag_c7 ; // { byte_addr<1:0>, r/wbar, ctag<11:0> }
output	[3:0]	sctag_scbuf_word_c7 ; //
output		sctag_scbuf_req_en_c7 ;	// This signal is s one cycle pulse
output		sctag_scbuf_word_vld_c7; // This signal is high for 16 signals.

input		scbuf_sctag_rdma_uerr_c10;
input		scbuf_sctag_rdma_cerr_c10;

// END interface with scbuf for handling snoops

//////////////////////////////////////////////////////////////////////////////
// Interface with the btu/DRAM 
//////////////////////////////////////////////////////////////////////////////


output			sctag_dram_rd_req;
output			sctag_dram_rd_dummy_req;
output [2:0]  		sctag_dram_rd_req_id;
output [39:5] 		sctag_dram_addr;
output        		sctag_dram_wr_req;

input         		dram_sctag_rd_ack;
input         		dram_sctag_wr_ack;
input  [1:0]   		dram_sctag_chunk_id_r0;
input         		dram_sctag_data_vld_r0;
input  [2:0]   		dram_sctag_rd_req_id_r0;
input			dram_sctag_secc_err_r2 ;
input			dram_sctag_mecc_err_r2 ;
input			dram_sctag_scb_mecc_err;
input			dram_sctag_scb_secc_err;
 

//////////////////////////////////////////////////////////////////////////////
// Snoop / RDMA  interface.
//////////////////////////////////////////////////////////////////////////////

input			jbi_sctag_req_vld ; 
input	[31:0]		jbi_sctag_req;
output			sctag_jbi_iq_dequeue; // implies that  an instruction has been issued
output			sctag_jbi_wib_dequeue; // implies that an entry in the rdma array has freed.



//////////////////////////////////////////////////////////////////////////////
// Global IOs
//////////////////////////////////////////////////////////////////////////////
input         	arst_l;
input         	grst_l;
input	       	adbginit_l;
input	       	gdbginit_l;
input		cluster_cken;
input 		cmp_gclk;                // global clock input to cluster header
input 		global_shift_enable;     //scan shift enable signal


output  [40:0]  sctag_dbgbus_out ; // 40 bit output

output		sctag_clk_tr;



//////////////////////////////////////////////////////////////////////////////
// Test interface signals
//////////////////////////////////////////////////////////////////////////////

output 		sctag_ctu_mbistdone;     //sctag bist done
output 		sctag_ctu_mbisterr;      //sctag bist err
input 		ctu_sctag_mbisten;        //sctag bist enable

output 		sctag_ctu_scanout;       //scan chain output
input 		ctu_sctag_scanin;         //scan chain input 

output                sctag_scbuf_scanout;
input           scdata_sctag_scanout;   // To test_stub of test_stub_bist.v





input           ctu_tst_macrotest;      // To test_stub of test_stub_bist.v
input           ctu_tst_pre_grst_l;     // To test_stub of test_stub_bist.v
input           ctu_tst_scan_disable;   // To test_stub of test_stub_bist.v
input           ctu_tst_scanmode;       // To test_stub of test_stub_bist.v
input           ctu_tst_short_chain;    // To test_stub of test_stub_bist.v




//////////////////////////////////////////////////////////////////////////////
// Efuse interface signals
//////////////////////////////////////////////////////////////////////////////
output   sctag_efc_fuse_data;   // From red_hdr of cmp_sram_redhdr.v
input    efc_sctag_fuse_clk1;
input    efc_sctag_fuse_clk2;
input    efc_sctag_fuse_ashift;
input    efc_sctag_fuse_dshift;
input    efc_sctag_fuse_data;

/*AUTOOUTPUT*/
// Beginning of automatic outputs (from unused autoinst outputs)
// End of automatics
/*AUTOINPUT*/
// Beginning of automatic inputs (from unused autoinst inputs)
// End of automatics

wire	mux_drive_disable;
wire	areset_l_0_buf_f, areset_l_1_buf_f;
wire	scan_enable_0_buf_f, scan_enable_1_buf_f;
wire	sehold_0_buf_f, sehold_1_buf_f;
wire	mux_drive_disable_0_buf_f, mux_drive_disable_1_buf_f;
wire	mem_write_disable_0_buf_f, mem_write_disable_1_buf_f;

wire	areset_l_0_buf_c , areset_l_1_buf_c ;
wire	scan_enable_0_buf_c , scan_enable_1_buf_c;
wire	sehold_0_buf_c , sehold_1_buf_c;
wire	mux_drive_disable_0_buf_c , mux_drive_disable_1_buf_c;
wire	mem_write_disable_0_buf_c , mem_write_disable_1_buf_c;

wire	areset_l_0_buf_d;
wire	scan_enable_0_buf_d;
wire	sehold_0_buf_d; 
wire	sehold_1_buf_d;
wire	mux_drive_disable_0_buf_d; 
wire	mem_write_disable_0_buf_d; 

wire	areset_l_0_buf_b, areset_l_1_buf_b ;
wire	scan_enable_0_buf_b, scan_enable_1_buf_b;
wire	sehold_0_buf_b, sehold_1_buf_b;
wire	mux_drive_disable_0_buf_b, mux_drive_disable_1_buf_b;
wire	mem_write_disable_0_buf_b, mem_write_disable_1_buf_b;

wire	areset_l_0_buf_a , areset_l_1_buf_a ;
wire	scan_enable_0_buf_a , scan_enable_1_buf_a ;
wire	sehold_0_buf_a , sehold_1_buf_a ;
wire	mux_drive_disable_0_buf_a , mux_drive_disable_1_buf_a ;
wire	mem_write_disable_0_buf_a , mem_write_disable_1_buf_a ;

wire    areset_l_0_buf_g , areset_l_1_buf_g ;
wire    greset_l_0_buf_g ; 
wire    scan_enable_0_buf_g , scan_enable_1_buf_g ;
wire    sehold_0_buf_g , sehold_1_buf_g ;
wire    mux_drive_disable_0_buf_g , mux_drive_disable_1_buf_g ;
wire    mem_write_disable_0_buf_g , mem_write_disable_1_buf_g ;


wire    areset_l_0_buf_h , areset_l_1_buf_h ;
wire    scan_enable_0_buf_h , scan_enable_1_buf_h ;
wire    sehold_0_buf_h , sehold_1_buf_h ;
wire    mux_drive_disable_0_buf_h , mux_drive_disable_1_buf_h ;
wire    mem_write_disable_0_buf_h , mem_write_disable_1_buf_h ;
wire	greset_l_0_buf_h;

wire    areset_l_0_buf_i , areset_l_1_buf_i ;
wire    scan_enable_0_buf_i , scan_enable_1_buf_i ;
wire    sehold_0_buf_i , sehold_1_buf_i ;
wire    mux_drive_disable_0_buf_i , mux_drive_disable_1_buf_i ;
wire    mem_write_disable_0_buf_i , mem_write_disable_1_buf_i ;
wire    greset_l_0_buf_i;

wire    areset_l_0_buf_j , areset_l_1_buf_j ;
wire    scan_enable_0_buf_j , scan_enable_1_buf_j ;
wire    sehold_0_buf_j , sehold_1_buf_j ;
wire    mux_drive_disable_0_buf_j , mux_drive_disable_1_buf_j ;
wire    mem_write_disable_0_buf_j , mem_write_disable_1_buf_j ;
wire    greset_l_0_buf_j;

wire    areset_l_0_buf_k , areset_l_1_buf_k ;
wire    scan_enable_0_buf_k , scan_enable_1_buf_k ;
wire    sehold_0_buf_k , sehold_1_buf_k ;
wire    mux_drive_disable_0_buf_k , mux_drive_disable_1_buf_k ;
wire    mem_write_disable_0_buf_k , mem_write_disable_1_buf_k ;
wire    greset_l_0_buf_k;

wire    areset_l_0_buf_l , areset_l_1_buf_l ;
wire    scan_enable_0_buf_l , scan_enable_1_buf_l ;
wire    sehold_0_buf_l , sehold_1_buf_l ;
wire    mux_drive_disable_0_buf_l , mux_drive_disable_1_buf_l ;
wire    mem_write_disable_0_buf_l , mem_write_disable_1_buf_l ;
wire    greset_l_0_buf_l;

wire    areset_l_0_buf_m , areset_l_1_buf_m ;
wire    scan_enable_0_buf_m , scan_enable_1_buf_m ;
wire    sehold_0_buf_m , sehold_1_buf_m ;
wire    mux_drive_disable_0_buf_m , mux_drive_disable_1_buf_m ;
wire    mem_write_disable_0_buf_m , mem_write_disable_1_buf_m ;

wire    areset_l_0_buf_n , areset_l_1_buf_n ;
wire    scan_enable_0_buf_n , scan_enable_1_buf_n ;
wire    sehold_0_buf_n , sehold_1_buf_n ;
wire    mux_drive_disable_0_buf_n , mux_drive_disable_1_buf_n ;
wire    mem_write_disable_0_buf_n , mem_write_disable_1_buf_n ;


wire	cluster_grst_l;
wire	testmode_l;
wire	mem_write_disable;
wire	sehold;
wire	se;
wire	scanin_buf;

wire	mbdata_wr_en_c8_minbuf;
wire	[3:0]	mbctl_mbentry_c8_minbuf;
wire	mbctl_tecc_c8_minbuf;
wire	mbctl_dep_c8_minbuf;
wire	mbctl_evict_c8_minbuf;
wire	[5:0]	mbdata_ecc_minbuf ;

 wire	scannet_0,  scannet_1,  scannet_2, scannet_3, scannet_4 ;
 wire	scannet_5,  scannet_6,  scannet_7, scannet_8, scannet_9 ;
 wire	scannet_10,  scannet_11,  scannet_12, scannet_13, scannet_14 ;
 wire	scannet_15,  scannet_16,  scannet_17, scannet_18, scannet_19 ;
 wire	scannet_20,  scannet_21,  scannet_22, scannet_23, scannet_24 ;
 wire	scannet_25,  scannet_26,  scannet_27, scannet_28, scannet_29 ;
 wire	scannet_30,  scannet_31,  scannet_32, scannet_33, scannet_34 ;
 wire	scannet_35,  scannet_36,  scannet_37, scannet_38, scannet_39 ;
 wire	scannet_40,  scannet_41,  scannet_42, scannet_43, scannet_44 ;
 wire	scannet_45,  scannet_46,  scannet_47, scannet_48, scannet_49 ;
 wire	scannet_50,  scannet_51,  scannet_52, scannet_53, scannet_54 ;
 wire	scannet_55,  scannet_56,  scannet_57, scannet_58, scannet_59 ;
 wire	scannet_60,  scannet_61,  scannet_62, scannet_63, scannet_64 ;
 wire	scannet_65,  scannet_66,  scannet_67, scannet_68, scannet_69 ;
 wire	scannet_70,  scannet_71,  scannet_72, scannet_73, scannet_74 ;
 wire	scannet_75,  scannet_76,  scannet_77, scannet_78, scannet_79 ;
 wire	scannet_80,  scannet_81,  scannet_82, scannet_83, scannet_84 ;
 wire	scannet_85,  scannet_86,  scannet_87, scannet_88, scannet_89 ;
 wire	scannet_90,  scannet_91,  scannet_92, scannet_93, scannet_94 ;
 wire	scannet_95,  scannet_96,  scannet_97, scannet_98, scannet_99 ;
 wire	scannet_100,  scannet_101,  scannet_102, scannet_103, scannet_104 ;
 wire	scannet_105,  scannet_106,  scannet_107, scannet_108, scannet_109 ;
 wire	scannet_109_buf, scannet_110;
 wire	scannet_86_a, scannet_92_a ;
wire	scannet_86_d3, scannet_86_d2, scannet_86_d1 ;


wire	cluster_grst_l_buf_g, cluster_grst_l_buf_i;
wire	cluster_grst_l_buf_h, cluster_grst_l_buf_j;
wire	cluster_grst_l_buf_l, cluster_grst_l_buf_k;

wire	dbginit_l ;
//wire	grst_l_in_buf1, grst_l_in_buf2;
//wire	adbginit_l_in_buf1, adbginit_l_in_buf2;
//wire	gdbginit_l_in_buf1, gdbginit_l_in_buf2;
//wire	cluster_cken_in_buf1, cluster_cken_in_buf2 ;

wire	global_shift_enable_buf1, ctu_tst_scan_disable_buf1 ;
wire	ctu_tst_scanmode_buf1, ctu_tst_macrotest_buf1, ctu_tst_short_chain_buf1; 
wire	ctu_sctag_mbisten_buf1 ;
wire	ctu_tst_pre_grst_l_buf1;
wire	ctu_sctag_scanin_buf1;
wire	sctag_ctu_mbisterr_prev, sctag_ctu_mbistdone_prev, sctag_ctu_scanout_prev ;

wire [10:0]           csr_bist_read_data;     // From test_stub of test_stub_bist.v
wire [3:0]             ic_cam_en_row0;         // To ic_row0 of dcm_row.v
wire [3:0]             ic_cam_en_row1;         // To ic_row1 of dcm_row.v
wire [3:0]             ic_cam_en_row2;         // To ic_row2 of dcm_row.v
wire [3:0]             ic_cam_en_row3;         // To ic_row3 of dcm_row.v
wire [3:0]             ic_rd_en_row0;          // To ic_row0 of dcm_row.v
wire [3:0]             ic_rd_en_row1;          // To ic_row1 of dcm_row.v
wire [3:0]             ic_rd_en_row2;          // To ic_row2 of dcm_row.v
wire [3:0]             ic_rd_en_row3;          // To ic_row3 of dcm_row.v
wire [3:0]             ic_wr_en_row0;          // To ic_row0 of dcm_row.v
wire [3:0]             ic_wr_en_row1;          // To ic_row1 of dcm_row.v
wire [3:0]             ic_wr_en_row2;          // To ic_row2 of dcm_row.v
wire [3:0]             ic_wr_en_row3;          // To ic_row3 of dcm_row.v

wire	[3:0]	ic_lkup_en_c4_buf_row0;
wire	[3:0]	ic_lkup_en_c4_buf_row1;
wire	[3:0]	ic_lkup_en_c4_buf_row2;
wire	[3:0]	ic_lkup_en_c4_buf_row3;

wire	[3:0]	ic_rw_dec_c4_buf_row0;
wire	[3:0]	ic_rw_dec_c4_buf_row1;
wire	[3:0]	ic_rw_dec_c4_buf_row2;
wire	[3:0]	ic_rw_dec_c4_buf_row3;

wire [3:0]             dc_cam_en_row0;         // To dc_row0 of dcm_row.v
wire [3:0]             dc_cam_en_row1;         // To dc_row1 of dcm_row.v
wire [3:0]             dc_cam_en_row2;         // To dc_row2 of dcm_row.v
wire [3:0]             dc_cam_en_row3;         // To dc_row3 of dcm_row.v
wire [3:0]             dc_rd_en_row0;          // To dc_row0 of dcm_row.v
wire [3:0]             dc_rd_en_row1;          // To dc_row1 of dcm_row.v
wire [3:0]             dc_rd_en_row2;          // To dc_row2 of dcm_row.v
wire [3:0]             dc_rd_en_row3;          // To dc_row3 of dcm_row.v
wire [3:0]             dc_wr_en_row0;          // To dc_row0 of dcm_row.v
wire [3:0]             dc_wr_en_row1;          // To dc_row1 of dcm_row.v
wire [3:0]             dc_wr_en_row2;          // To dc_row2 of dcm_row.v
wire [3:0]             dc_wr_en_row3;          // To dc_row3 of dcm_row.v
wire	[3:0]	dc_lkup_en_c4_buf_row0;
wire	[3:0]	dc_lkup_en_c4_buf_row1;
wire	[3:0]	dc_lkup_en_c4_buf_row2;
wire	[3:0]	dc_lkup_en_c4_buf_row3;

wire	[3:0]	dc_rw_dec_c4_buf_row0;
wire	[3:0]	dc_rw_dec_c4_buf_row1;
wire	[3:0]	dc_rw_dec_c4_buf_row2;
wire	[3:0]	dc_rw_dec_c4_buf_row3;
wire	[6:0]	csr_bist_wr_data_c8;
wire		rclk;
wire	[33:0]	arbdata_wr_data_c2 ;
wire 	[25:0]  vuad_dp_diag_data_c7_buf;   

wire	[51:0] write_data_top, write_data_bottom ;

wire	[5:2]		arbdp_dbg_addr_c3;
wire                  arbctl_mb_camen_px2;    // 
wire [39:0]           arbdp_cam_addr_px2;     // 
wire			arbctl_inst_vld_c1;

wire [3:0]            parity_c4;              // From vuad_dpm of sctag_vuad_dpm.v
wire [`JBI_HDR_SZ-1:0] snpq_arbdp_inst_px2;    // From snpdp of sctag_snpdp.v

wire [`L2_POISON:`L2_SZ_LO]arbdp_inst_c8;   // 

wire                  fbctl_buf_rd_en;        // 
wire [7:0]            fbctl_fbtag_rd_ptr;     // 
wire                  fbctl_fbtag_wr_en;      // 
wire [7:0]            fbctl_fbtag_wr_ptr;     // 

wire                  iq_array_rd_en;         // 
wire [3:0]            iq_array_rd_wl;         // 
wire                  iq_array_wr_en;         // 
wire [3:0]            iq_array_wr_wl;         // 

wire [15:0]           mb_write_wl;            // 
wire                  mbctl_dep_c8;           // 
wire                  mbctl_evict_c8;         // 
wire [3:0]            mbctl_mbentry_c8;       // 
wire                  mbctl_tecc_c8;          // 
wire [63:0]           mbdata_inst_data_c8;    // 
wire [5:0]            mbdata_inst_tecc_c8;    // 
wire                  mbtag_wr_en_c2;         // 
wire	[15:0]  mb_read_wl ;    
wire    [15:0]  mb_data_write_wl;
wire 		mbdata_wr_en_c8;     


wire [144:0] oq_array_data_in;       // 
wire                  oqarray_rd_en;          // 
wire [3:0]            oqarray_rd_ptr;         // 
wire                  oqarray_wr_en;          // 
wire [3:0]            oqarray_wr_ptr;         // 


wire	[39:0] rdma_read_data;
wire [39:0]            wb_read_data;           // To arbaddrdp of sctag_arbaddrdp.v

wire [15:0]             fb_cam_match;           // To fbctl of sctag_fbctl.v
wire [39:0]            fb_read_data;           // To arbaddrdp of sctag_arbaddrdp.v

wire [124:0]           iqdp_iqarray_data_in;    // iqdp to iqarray
wire [159:0]           iq_array_rd_data_c1;    // To iqdp of sctag_iqdp.v
wire [15:0]            mb_cam_match;           // To mbctl of sctag_mbctl.v
wire [15:0]            mb_cam_match_idx;           // To mbctl of sctag_mbctl.v
wire [39:0]            mb_read_data;           // To arbaddrdp of sctag_arbaddrdp.v
wire [159:0]  oq_array_data_out;      // To oqdp of sctag_oqdp.v

wire [15:0]             wb_cam_match_c2;        // To wbctl of sctag_wbctl.v
// wire [31:0]            wr_data;                // To icdir of sctag_dirblock.v, ...
wire	[15:0]	rdmat_cam_match_c2;
wire	[3:0]	rdmat_wr_wl_s2;
wire	[39:6]	rdmatag_wr_addr_s2;
wire		rdmatag_wr_en_s2;
wire	[3:0]	rdmat_read_wl;
wire		rdmat_read_en;

wire [127:0]            ic_cam_hit;             // 
wire                    ic_inval_vld_c7;        // 

wire [127:0]            dc_cam_hit;             // 
wire                    dc_inval_vld_c7;        // 

// test related.
wire	mbist_start;
wire	mbist_userdata_mode;
wire	mbist_bisi_mode;
wire	mbist_loop_mode;
wire	mbist_loop_on_address;
wire	mbist_stop_on_fail;
wire	mbist_done;
wire	mbist_l2vuad_fail;
wire	mbist_l2tag_fail;
wire	mbist_l2data_fail;


wire	mb_data_write_wl_9_rep1;
wire	mb_data_write_wl_1_rep1;
wire	mbctl_buf_rd_en_rep1;
wire	mb_write_wl_15_rep1;
wire	mb_write_wl_12_rep1;
wire	mb_write_wl_11_rep1;
wire	mb_write_wl_7_rep1;
wire	mb_write_wl_6_rep1;
wire	tagctl_nonmem_comp_c6_rep1;
wire	tagctl_rdma_wr_comp_c4_rep1;
wire	fbctl_fbtag_rd_ptr_5_rep1;
wire	wb_read_wl_3_rep1;
wire	wb_read_wl_7_rep1;
wire	scannet_92_a_rep1;
wire	adbginit_l_rep1;

wire [2:0]              lkup_row_addr_icd_c3;   // 
wire [2:0]              lkup_row_addr_dcd_c3;   // 
wire [39:10]          	tagdp_lkup_addr_c4;     // From tagdp of sctag_tagdp.v
wire [39:0]           mb_write_addr;          // 
wire [39:8]           lkup_addr_c1;           // 

wire                  wb_read_en;             // 
wire [7:0]            wb_read_wl;             // 
wire [39:0]           wb_write_addr;          // 
wire                  wbtag_write_en_c4;    // 
wire [7:0]            wbtag_write_wl_c4;      // 

wire	[127:0]	retdp_data_c6_tmp;
wire	[27:0]	retdp_ecc_c6_tmp;
wire	[127:0]	retdp_data_c7_buf;
wire	[27:0]	retdp_ecc_c7_buf;
wire [127:0]           retdp_data_c7;          // To deccdp of sctag_deccdp.v
wire [27:0]            retdp_ecc_c7;           // To deccdp of sctag_deccdp.v

wire	sctag_fuse_data;
wire	evict_vld_c2_buf1, evict_vld_c2_buf2, evict_vld_c2_buf3;
wire	mbctl_buf_rd_en_buf, mbdata_wr_en_c8_buf;
wire	[15:0]	mb_data_write_wl_buf;
wire	[15:0]	mb_read_wl_buf;
wire		mbctl_buf_rd_en;
// End of automatics
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire                    alloc_rd_parity_c2;     // From ua_dp of sctag_ua_dp.v
wire                    alloc_rst_cond_c3;      // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    alloc_set_cond_c3;      // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    alt_tagctl_miss_unqual_c3;// From tagctl of sctag_tagctl.v
wire                    arbaddr_addr22_c2;      // From arbaddrdp of sctag_arbaddrdp.v
wire [9:0]              arbaddr_idx_c3;         // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbaddrdp_addr2_c8;     // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbctl_acc_ua_c2;       // From arbctl of sctag_arbctl.v
wire                    arbctl_acc_vd_c2;       // From arbctl of sctag_arbctl.v
wire                    arbctl_coloff_inst_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_csr_rd_en_c3;    // From arbctl of sctag_arbctl.v
wire                    arbctl_csr_rd_en_c7;    // From arbctl of sctag_arbctl.v
wire                    arbctl_csr_st_c2;       // From arbctl of sctag_arbctl.v
wire                    arbctl_csr_wr_en_c3;    // From arbctl of sctag_arbctl.v
wire                    arbctl_csr_wr_en_c7;    // From arbctl of sctag_arbctl.v
wire                    arbctl_data_diag_st_c2; // From arbctl of sctag_arbctl.v
wire                    arbctl_data_ecc_active_c3;// From csr_ctl of sctag_csr_ctl.v
wire                    arbctl_dbgdp_inst_vld_c3;// From arbctl of sctag_arbctl.v
wire                    arbctl_dbginit_l;       // From csr_ctl of sctag_csr_ctl.v
wire                    arbctl_dc_rd_en_c3;     // From arbctl of sctag_arbctl.v
wire                    arbctl_dc_wr_en_c3;     // From arbctl of sctag_arbctl.v
wire                    arbctl_decc_data_sel_c9;// From arbctl of sctag_arbctl.v
wire                    arbctl_diag_complete_c3;// From arbctl of sctag_arbctl.v
wire [4:0]              arbctl_dir_panel_dcd_c3;// From arbctl of sctag_arbctl.v
wire [4:0]              arbctl_dir_panel_icd_c3;// From arbctl of sctag_arbctl.v
wire                    arbctl_dir_vld_c3_l;    // From arbctl of sctag_arbctl.v
wire                    arbctl_dir_wr_en_c4;    // From arbctl of sctag_arbctl.v
wire                    arbctl_evict_c3;        // From arbctl of sctag_arbctl.v
wire                    arbctl_evict_c4;        // From arbctl of sctag_arbctl.v
wire                    arbctl_evict_c5;        // From arbctl of sctag_arbctl.v
wire                    arbctl_evict_tecc_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_fbctl_fbsel_c1;  // From arbctl of sctag_arbctl.v
wire                    arbctl_fbctl_hit_off_c1;// From arbctl of sctag_arbctl.v
wire                    arbctl_fbctl_inst_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_fill_vld_c2;     // From arbctl of sctag_arbctl.v
wire                    arbctl_ic_rd_en_c3;     // From arbctl of sctag_arbctl.v
wire                    arbctl_ic_wr_en_c3;     // From arbctl of sctag_arbctl.v
wire                    arbctl_imiss_hit_c10;   // From arbctl of sctag_arbctl.v
wire                    arbctl_imiss_hit_c4;    // From arbctl of sctag_arbctl.v
wire                    arbctl_imiss_vld_c2;    // From arbctl of sctag_arbctl.v
wire                    arbctl_inst_diag_c1;    // From arbctl of sctag_arbctl.v
wire                    arbctl_inst_diag_c2;    // From arbctl of sctag_arbctl.v
wire                    arbctl_inst_l2data_vld_c6;// From arbctl of sctag_arbctl.v
wire                    arbctl_inst_l2tag_vld_c6;// From arbctl of sctag_arbctl.v
wire                    arbctl_inst_l2vuad_vld_c3;// From arbctl of sctag_arbctl.v
wire                    arbctl_inst_l2vuad_vld_c6;// From arbctl of sctag_arbctl.v
wire                    arbctl_inst_vld_c2;     // From arbctl of sctag_arbctl.v
wire                    arbctl_inval_inst_c2;   // From arbctl of sctag_arbctl.v
wire [7:0]              arbctl_inval_mask_dcd_c3;// From arbctl of sctag_arbctl.v
wire [7:0]              arbctl_inval_mask_icd_c3;// From arbctl of sctag_arbctl.v
wire                    arbctl_iqsel_px2;       // From arbctl of sctag_arbctl.v
wire                    arbctl_l2tag_vld_c4;    // From arbctl of sctag_arbctl.v
wire [3:0]              arbctl_lkup_bank_ena_dcd_c3;// From arbctl of sctag_arbctl.v
wire [3:0]              arbctl_lkup_bank_ena_icd_c3;// From arbctl of sctag_arbctl.v
wire                    arbctl_mbctl_cas1_hit_c8;// From arbctl of sctag_arbctl.v
wire                    arbctl_mbctl_ctrue_c9;  // From arbctl of sctag_arbctl.v
wire                    arbctl_mbctl_hit_off_c1;// From arbctl of sctag_arbctl.v
wire                    arbctl_mbctl_inst_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_mbctl_inval_inst_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_mbctl_mbsel_c1;  // From arbctl of sctag_arbctl.v
wire                    arbctl_normal_tagacc_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_pst_ctrue_en_c8; // From arbctl of sctag_arbctl.v
wire                    arbctl_rdwr_inst_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_snpsel_c1;       // From arbctl of sctag_arbctl.v
wire                    arbctl_tag_rd_px2;      // From arbctl of sctag_arbctl.v
wire                    arbctl_tag_rd_px2_buf;  // From tagdp of sctag_tagdp.v
wire [11:0]             arbctl_tag_way_px2;     // From arbctl of sctag_arbctl.v
wire [11:0]             arbctl_tag_way_px2_buf; // From tagdp of sctag_tagdp.v
wire                    arbctl_tag_wr_px2;      // From arbctl of sctag_arbctl.v
wire                    arbctl_tag_wr_px2_buf;  // From tagdp of sctag_tagdp.v
wire                    arbctl_tagctl_inst_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_tagctl_pst_with_ctrue_c1;// From arbctl of sctag_arbctl.v
wire                    arbctl_tagdp_perr_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_tagdp_tecc_c2;   // From arbctl of sctag_arbctl.v
wire                    arbctl_tecc_c2;         // From arbctl of sctag_arbctl.v
wire [3:0]              arbctl_tecc_way_c2;     // From arbctl of sctag_arbctl.v
wire                    arbctl_vuad_acc_px2;    // From arbctl of sctag_arbctl.v
wire                    arbctl_vuad_idx2_sel_px2_n;// From arbctl of sctag_arbctl.v
wire                    arbctl_waysel_gate_c2;  // From arbctl of sctag_arbctl.v
wire                    arbctl_waysel_inst_vld_c2;// From arbctl of sctag_arbctl.v
wire                    arbctl_wbctl_hit_off_c1;// From arbctl of sctag_arbctl.v
wire                    arbctl_wbctl_inst_vld_c2;// From arbctl of sctag_arbctl.v
wire [4:0]              arbctl_wr_dc_dir_entry_c3;// From arbctl of sctag_arbctl.v
wire [4:0]              arbctl_wr_ic_dir_entry_c3;// From arbctl of sctag_arbctl.v
wire [14:0]             arbdec_ctag_c6;         // From arbdecdp of sctag_arbdecdp.v
wire [8:0]              arbdec_dbgdp_inst_c3;   // From arbdecdp of sctag_arbdecdp.v
wire [7:4]              arbdp_addr11to8_c3;     // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_addr22_c7;        // From arbaddrdp of sctag_arbaddrdp.v
wire [1:0]              arbdp_addr3to2_c1;      // From arbaddrdp of sctag_arbaddrdp.v
wire [1:0]              arbdp_addr5to4_c1;      // From arbaddrdp of sctag_arbaddrdp.v
wire [1:0]              arbdp_addr5to4_c2;      // From arbaddrdp of sctag_arbaddrdp.v
wire [1:0]              arbdp_addr5to4_c3;      // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_addr_c1c2comp_c1; // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_addr_c1c3comp_c1; // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_addr_start_c2;    // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_async_bit_c8;     // From arbdecdp of sctag_arbdecdp.v
wire [1:0]              arbdp_byte_addr_c6;     // From arbaddrdp of sctag_arbaddrdp.v
wire [2:0]              arbdp_cpuid_c3;         // From arbdecdp of sctag_arbdecdp.v
wire [2:0]              arbdp_cpuid_c4;         // From arbdecdp of sctag_arbdecdp.v
wire [2:0]              arbdp_cpuid_c5;         // From arbdecdp of sctag_arbdecdp.v
wire [2:0]              arbdp_cpuid_c6;         // From arbdecdp of sctag_arbdecdp.v
wire [39:4]             arbdp_csr_addr_c9;      // From arbaddrdp of sctag_arbaddrdp.v
wire [3:0]              arbdp_diag_wr_way_c2;   // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_dir_wr_par_c3;    // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_dword_st_c2;      // From arbctl of sctag_arbctl.v
wire                    arbdp_evict_c1;         // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_bufid1_c1;   // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_bufidhi_c1;  // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_bufidlo_c2;  // From arbdecdp of sctag_arbdecdp.v
wire [2:0]              arbdp_inst_byte_addr_c7;// From arbaddrdp of sctag_arbaddrdp.v
wire [2:0]              arbdp_inst_cpuid_c7;    // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_ctrue_c1;    // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_dep_c2;      // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_fb_c1;       // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_fb_c2;       // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_fb_c3;       // From arbdecdp of sctag_arbdecdp.v
wire [1:0]              arbdp_inst_l1way_c7;    // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_mb_c1;       // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_mb_c2;       // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_mb_c3;       // From arbdecdp of sctag_arbdecdp.v
wire [3:0]              arbdp_inst_mb_entry_c1; // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_nc_c1;       // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_nc_c3;       // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_nc_c7;       // From arbdecdp of sctag_arbdecdp.v
wire [`L2_RQTYP_HI:`L2_RQTYP_LO]arbdp_inst_rqtyp_c1;// From arbdecdp of sctag_arbdecdp.v
wire [`L2_RQTYP_HI:`L2_RQTYP_LO]arbdp_inst_rqtyp_c2;// From arbdecdp of sctag_arbdecdp.v
wire [`L2_RQTYP_HI:`L2_RQTYP_LO]arbdp_inst_rqtyp_c6;// From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_rsvd_c1;     // From arbdecdp of sctag_arbdecdp.v
wire [`L2_SZ_HI:`L2_SZ_LO]arbdp_inst_size_c1;   // From arbdecdp of sctag_arbdecdp.v
wire [2:0]              arbdp_inst_size_c7;     // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_inst_tecc_c3;     // From arbdecdp of sctag_arbdecdp.v
wire [1:0]              arbdp_inst_tid_c7;      // From arbdecdp of sctag_arbdecdp.v
wire [3:0]              arbdp_inst_way_c1;      // From arbdecdp of sctag_arbdecdp.v
wire [3:0]              arbdp_inst_way_c2;      // From arbdecdp of sctag_arbdecdp.v
wire [3:0]              arbdp_inst_way_c3;      // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_int_bcast_c5;     // From arbdecdp of sctag_arbdecdp.v
wire [39:32]            arbdp_ioaddr_c1;        // From arbaddrdp of sctag_arbaddrdp.v
wire [1:0]              arbdp_l1way_c3;         // From arbdecdp of sctag_arbdecdp.v
wire [5:4]              arbdp_line_addr_c7;     // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_mbctl_pst_no_ctrue_c2;// From arbctl of sctag_arbctl.v
wire [1:0]              arbdp_new_addr5to4_px2; // From arbaddrdp of sctag_arbaddrdp.v
wire [17:0]             arbdp_oqdp_int_ret_c7;  // From arbdatadp of sctag_arbdatadp.v
wire [11:6]             arbdp_oqdp_l1_index_c7; // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_poison_c1;        // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_pst_with_ctrue_c2;// From arbctl of sctag_arbctl.v
wire [1:0]              arbdp_rdma_entry_c3;    // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_rdma_inst_c1;     // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_rdma_inst_c2;     // From arbdecdp of sctag_arbdecdp.v
wire [5:2]              arbdp_rdmatctl_addr_c6; // From arbaddrdp of sctag_arbaddrdp.v
wire [77:0]             arbdp_store_data_c2;    // From arbdatadp of sctag_arbdatadp.v
wire [77:0]             arbdp_store_data_c2_buf;// From stdatarep1 of sctag_stdatarep.v
wire [9:0]              arbdp_tag_idx_px2;      // From arbaddrdp of sctag_arbaddrdp.v
wire [9:0]              arbdp_tag_idx_px2_buf;  // From tagdp of sctag_tagdp.v
wire                    arbdp_tagctl_pst_no_ctrue_c2;// From arbctl of sctag_arbctl.v
wire [27:6]             arbdp_tagdata_px2;      // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_tecc_c1;          // From arbdecdp of sctag_arbdecdp.v
wire                    arbdp_tecc_inst_mb_c8;  // From arbctl of sctag_arbctl.v
wire [9:0]              arbdp_vuad_idx1_px2;    // From arbaddrdp of sctag_arbaddrdp.v
wire [9:0]              arbdp_vuad_idx2_px2;    // From arbaddrdp of sctag_arbaddrdp.v
wire                    arbdp_vuadctl_pst_no_ctrue_c2;// From arbctl of sctag_arbctl.v
wire [1:0]              arbdp_waddr_c6;         // From arbaddrdp of sctag_arbaddrdp.v
wire [1:0]              arbdp_word_addr_c1;     // From arbaddrdp of sctag_arbaddrdp.v
wire [2:0]              arbdp_word_addr_c6;     // From arbaddrdp of sctag_arbaddrdp.v
wire                    atm_inst_ack_c7;        // From oqctl of sctag_oqctl.v
wire                    atomic_req_c3;          // From arbctl of sctag_arbctl.v
wire                    bist_or_diag_acc_c1;    // From arbctl of sctag_arbctl.v
wire [9:0]              bist_vuad_index;        // From tagdp_ctl of sctag_tagdp_ctl.v
wire                    bist_vuad_vd;           // From tagdp_ctl of sctag_tagdp_ctl.v
wire [7:0]              bist_vuad_wr_data;      // From tagdp_ctl of sctag_tagdp_ctl.v
wire                    bist_vuad_write;        // From tagdp_ctl of sctag_tagdp_ctl.v
wire [25:0]             bistordiag_ua_data;     // From vuad_dpm of sctag_vuad_dpm.v
wire [25:0]             bistordiag_vd_data;     // From vuad_dpm of sctag_vuad_dpm.v
wire                    bistordiag_wr_ua_c4;    // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    bistordiag_wr_vd_c4;    // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    c1_addr_eq_wb_c4;       // From arbaddrdp of sctag_arbaddrdp.v
wire                    cerr_ack_tmp_c4;        // From tagctl of sctag_tagctl.v
wire [5:0]              check0_c7;              // From deccdp of sctag_deccdp.v
wire [5:0]              check1_c7;              // From deccdp of sctag_deccdp.v
wire [5:0]              check2_c7;              // From deccdp of sctag_deccdp.v
wire [5:0]              check3_c7;              // From deccdp of sctag_deccdp.v
wire                    csr_addr_wr_en;         // From csr_ctl of sctag_csr_ctl.v
wire                    csr_async_wr_en;        // From csr_ctl of sctag_csr_ctl.v
wire                    csr_bist_wr_en_c8;      // From csr_ctl of sctag_csr_ctl.v
wire                    csr_ctl_wr_en_c8;       // From csr_ctl of sctag_csr_ctl.v
wire                    csr_dbginit_l;          // From csr_ctl of sctag_csr_ctl.v
wire                    csr_erren_wr_en_c8;     // From csr_ctl of sctag_csr_ctl.v
wire                    csr_errinj_wr_en_c8;    // From csr_ctl of sctag_csr_ctl.v
wire                    csr_errstate_wr_en_c8;  // From csr_ctl of sctag_csr_ctl.v
wire                    csr_fbctl_l2off;        // From csr of sctag_csr.v
wire                    csr_fbctl_scrub_ready;  // From csr of sctag_csr.v
wire [63:0]             csr_inst_wr_data_c8;    // From arbdatadp of sctag_arbdatadp.v
wire                    csr_mbctl_l2off;        // From csr of sctag_csr.v
wire [63:0]             csr_rd_data_c8;         // From csr of sctag_csr.v
wire [3:0]              csr_rd_mux1_sel_c7;     // From csr_ctl of sctag_csr_ctl.v
wire                    csr_rd_mux2_sel_c7;     // From csr_ctl of sctag_csr_ctl.v
wire [1:0]              csr_rd_mux3_sel_c7;     // From csr_ctl of sctag_csr_ctl.v
wire                    csr_synd_wr_en;         // From csr_ctl of sctag_csr_ctl.v
wire                    csr_tagctl_l2off;       // From csr of sctag_csr.v
wire                    csr_tid_wr_en;          // From csr_ctl of sctag_csr_ctl.v
wire                    csr_vuad_l2off;         // From csr of sctag_csr.v
wire                    csr_wbctl_l2off;        // From csr of sctag_csr.v
wire                    csr_wr_dirpinj_en;      // From csr of sctag_csr.v
wire                    data_ecc_active_c3;     // From tagctl of sctag_tagctl.v
wire [9:0]              data_ecc_idx;           // From arbaddrdp of sctag_arbaddrdp.v
wire                    data_ecc_idx_en;        // From arbctl of sctag_arbctl.v
wire                    data_ecc_idx_reset;     // From arbctl of sctag_arbctl.v
wire [107:0]            data_in_h_r0;           // From subarray_0 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r1;           // From subarray_1 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r10;          // From subarray_10 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r11;          // From subarray_11 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r12;          // From subarray_12 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r13;          // From subarray_13 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r14;          // From subarray_14 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r15;          // From subarray_15 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r2;           // From subarray_2 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r3;           // From subarray_3 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r4;           // From subarray_4 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r5;           // From subarray_5 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r6;           // From subarray_6 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r7;           // From subarray_7 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r8;           // From subarray_8 of bw_r_rf32x108.v
wire [107:0]            data_in_h_r9;           // From subarray_9 of bw_r_rf32x108.v
wire [25:0]             data_out_col_r0;        // From vuadcol_0 of sctag_vuadcol_dp.v
wire [25:0]             data_out_col_r10;       // From vuadcol_10 of sctag_vuadcol_dp.v
wire [25:0]             data_out_col_r12;       // From vuadcol_12 of sctag_vuadcol_dp.v
wire [25:0]             data_out_col_r14;       // From vuadcol_14 of sctag_vuadcol_dp.v
wire [25:0]             data_out_col_r2;        // From vuadcol_2 of sctag_vuadcol_dp.v
wire [25:0]             data_out_col_r4;        // From vuadcol_4 of sctag_vuadcol_dp.v
wire [25:0]             data_out_col_r6;        // From vuadcol_6 of sctag_vuadcol_dp.v
wire [25:0]             data_out_col_r8;        // From vuadcol_8 of sctag_vuadcol_dp.v
wire                    dc_dir_clear_c4;        // From dirrep of sctag_dirrep.v
wire                    dc_dir_clear_c4_buf_row0;// From dc_buf_row0 of sctag_dirl_buf.v
wire                    dc_dir_clear_c4_buf_row2;// From dc_buf_row1 of sctag_dirl_buf.v
wire [7:0]              dc_inv_mask_0145;       // From dc_ctl_0145 of sctag_dir_ctl.v
wire [7:0]              dc_inv_mask_2367;       // From dc_ctl_2367 of sctag_dir_ctl.v
wire [7:0]              dc_inv_mask_89cd;       // From dc_ctl_89cd of sctag_dir_ctl.v
wire [7:0]              dc_inv_mask_abef;       // From dc_ctl_abef of sctag_dir_ctl.v
wire [7:0]              dc_inv_mask_c4_buf_row0;// From dc_buf_row0 of sctag_dirl_buf.v
wire [7:0]              dc_inv_mask_c4_buf_row2;// From dc_buf_row1 of sctag_dirl_buf.v
wire [3:0]              dc_lkup_panel_dec_c4;   // From dirrep of sctag_dirrep.v
wire [3:0]              dc_lkup_row_dec_c4;     // From dirrep of sctag_dirrep.v
wire [32:0]             dc_lkup_wr_data_c4_row0;// From dc_buf_row0 of sctag_dirl_buf.v
wire [32:0]             dc_lkup_wr_data_c4_row2;// From dc_buf_row1 of sctag_dirl_buf.v
wire [2:0]              dc_parity_in;           // From dc_out_col0 of sctag_dir_out.v, ...
wire [3:0]              dc_parity_out;          // From dc_out_col3 of sctag_dir_out.v, ...
wire [31:0]             dc_rd_data04_row0;      // From dc_row0 of bw_r_dcm.v
wire [31:0]             dc_rd_data04_row1;      // From dc_row1 of bw_r_dcm.v
wire [31:0]             dc_rd_data15_row0;      // From dc_row0 of bw_r_dcm.v
wire [31:0]             dc_rd_data15_row1;      // From dc_row1 of bw_r_dcm.v
wire [31:0]             dc_rd_data26_row0;      // From dc_row0 of bw_r_dcm.v
wire [31:0]             dc_rd_data26_row1;      // From dc_row1 of bw_r_dcm.v
wire [31:0]             dc_rd_data37_row0;      // From dc_row0 of bw_r_dcm.v
wire [31:0]             dc_rd_data37_row1;      // From dc_row1 of bw_r_dcm.v
wire [31:0]             dc_rd_data8c_row2;      // From dc_row2 of bw_r_dcm.v
wire [31:0]             dc_rd_data8c_row3;      // From dc_row3 of bw_r_dcm.v
wire [31:0]             dc_rd_data9d_row2;      // From dc_row2 of bw_r_dcm.v
wire [31:0]             dc_rd_data9d_row3;      // From dc_row3 of bw_r_dcm.v
wire                    dc_rd_data_sel_0;       // From dc_ctl_0145 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_04;      // From dc_ctl_0145 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_1;       // From dc_ctl_0145 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_15;      // From dc_ctl_0145 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_2;       // From dc_ctl_2367 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_26;      // From dc_ctl_2367 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_3;       // From dc_ctl_2367 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_37;      // From dc_ctl_2367 of sctag_dir_ctl.v
wire                    dc_rd_data_sel_8;       // From dc_ctl_89cd of sctag_dir_ctl.v
wire                    dc_rd_data_sel_8c;      // From dc_ctl_89cd of sctag_dir_ctl.v
wire                    dc_rd_data_sel_9;       // From dc_ctl_89cd of sctag_dir_ctl.v
wire                    dc_rd_data_sel_9d;      // From dc_ctl_89cd of sctag_dir_ctl.v
wire                    dc_rd_data_sel_a;       // From dc_ctl_abef of sctag_dir_ctl.v
wire                    dc_rd_data_sel_ae;      // From dc_ctl_abef of sctag_dir_ctl.v
wire                    dc_rd_data_sel_b;       // From dc_ctl_abef of sctag_dir_ctl.v
wire                    dc_rd_data_sel_bf;      // From dc_ctl_abef of sctag_dir_ctl.v
wire [31:0]             dc_rd_dataae_row2;      // From dc_row2 of bw_r_dcm.v
wire [31:0]             dc_rd_dataae_row3;      // From dc_row3 of bw_r_dcm.v
wire [31:0]             dc_rd_databf_row2;      // From dc_row2 of bw_r_dcm.v
wire [31:0]             dc_rd_databf_row3;      // From dc_row3 of bw_r_dcm.v
wire                    dc_rd_en_c4;            // From dirrep of sctag_dirrep.v
wire                    dc_rd_en_c4_buf_row0;   // From dc_buf_row0 of sctag_dirl_buf.v
wire                    dc_rd_en_c4_buf_row2;   // From dc_buf_row1 of sctag_dirl_buf.v
wire [31:0]             dc_rddata_out_04;       // From dc_in_04 of sctag_dir_in.v
wire [31:0]             dc_rddata_out_15;       // From dc_in_15 of sctag_dir_in.v
wire [31:0]             dc_rddata_out_26;       // From dc_in_26 of sctag_dir_in.v
wire [31:0]             dc_rddata_out_37;       // From dc_in_37 of sctag_dir_in.v
wire [31:0]             dc_rddata_out_8c;       // From dc_in_8c of sctag_dir_in.v
wire [31:0]             dc_rddata_out_9d;       // From dc_in_9d of sctag_dir_in.v
wire [31:0]             dc_rddata_out_ae;       // From dc_in_ae of sctag_dir_in.v
wire [31:0]             dc_rddata_out_bf;       // From dc_in_bf of sctag_dir_in.v
wire [3:0]              dc_rdwr_panel_dec_c4;   // From dirrep of sctag_dirrep.v
wire [3:0]              dc_rdwr_row_en_c4;      // From dirrep of sctag_dirrep.v
wire [5:0]              dc_rw_addr_0145;        // From dc_ctl_0145 of sctag_dir_ctl.v
wire [5:0]              dc_rw_addr_2367;        // From dc_ctl_2367 of sctag_dir_ctl.v
wire [5:0]              dc_rw_addr_89cd;        // From dc_ctl_89cd of sctag_dir_ctl.v
wire [5:0]              dc_rw_addr_abef;        // From dc_ctl_abef of sctag_dir_ctl.v
wire [5:0]              dc_rw_entry_c4_buf_row0;// From dc_buf_row0 of sctag_dirl_buf.v
wire [5:0]              dc_rw_entry_c4_buf_row2;// From dc_buf_row1 of sctag_dirl_buf.v
wire                    dc_warm_rst_0145;       // From dc_ctl_0145 of sctag_dir_ctl.v
wire                    dc_warm_rst_2367;       // From dc_ctl_2367 of sctag_dir_ctl.v
wire                    dc_warm_rst_89cd;       // From dc_ctl_89cd of sctag_dir_ctl.v
wire                    dc_warm_rst_abef;       // From dc_ctl_abef of sctag_dir_ctl.v
wire [32:0]             dc_wr_data04;           // From dc_in_04 of sctag_dir_in.v
wire [32:0]             dc_wr_data15;           // From dc_in_15 of sctag_dir_in.v
wire [32:0]             dc_wr_data26;           // From dc_in_26 of sctag_dir_in.v
wire [32:0]             dc_wr_data37;           // From dc_in_37 of sctag_dir_in.v
wire [32:0]             dc_wr_data8c;           // From dc_in_8c of sctag_dir_in.v
wire [32:0]             dc_wr_data9d;           // From dc_in_9d of sctag_dir_in.v
wire [32:0]             dc_wr_dataae;           // From dc_in_ae of sctag_dir_in.v
wire [32:0]             dc_wr_databf;           // From dc_in_bf of sctag_dir_in.v
wire                    dc_wr_en_c4;            // From dirrep of sctag_dirrep.v
wire                    dc_wr_en_c4_buf_row0;   // From dc_buf_row0 of sctag_dirl_buf.v
wire                    dc_wr_en_c4_buf_row2;   // From dc_buf_row1 of sctag_dirl_buf.v
wire                    decc_bscd_corr_err_c8;  // From decc_ctl of sctag_decc_ctl.v
wire                    decc_bscd_uncorr_err_c8;// From decc_ctl of sctag_decc_ctl.v
wire                    decc_data_ecc_active_c3;// From csr_ctl of sctag_csr_ctl.v
wire                    decc_scrd_corr_err_c8;  // From decc_ctl of sctag_decc_ctl.v
wire                    decc_scrd_uncorr_err_c8;// From decc_ctl of sctag_decc_ctl.v
wire                    decc_spcd_corr_err_c8;  // From decc_ctl of sctag_decc_ctl.v
wire                    decc_spcd_uncorr_err_c8;// From decc_ctl of sctag_decc_ctl.v
wire                    decc_spcfb_corr_err_c8; // From decc_ctl of sctag_decc_ctl.v
wire                    decc_spcfb_uncorr_err_c8;// From decc_ctl of sctag_decc_ctl.v
wire                    decc_tag_acc_en_px2;    // From tagctl of sctag_tagctl.v
wire                    decc_uncorr_err_c8;     // From decc_ctl of sctag_decc_ctl.v
wire [63:0]             deccdp_arbdp_data_c8;   // From deccdp of sctag_deccdp.v
wire                    decdp_atm_inst_c6;      // From arbctl of sctag_arbctl.v
wire                    decdp_bis_inst_c3;      // From arbctl of sctag_arbctl.v
wire                    decdp_cas1_inst_c2;     // From arbctl of sctag_arbctl.v
wire                    decdp_cas2_from_mb_c2;  // From arbctl of sctag_arbctl.v
wire                    decdp_cas2_from_mb_ctrue_c2;// From arbctl of sctag_arbctl.v
wire                    decdp_cas2_inst_c2;     // From arbctl of sctag_arbctl.v
wire                    decdp_fwd_req_c2;       // From arbctl of sctag_arbctl.v
wire                    decdp_imiss_inst_c2;    // From arbctl of sctag_arbctl.v
wire                    decdp_inst_int_c1;      // From arbctl of sctag_arbctl.v
wire                    decdp_inst_int_c2;      // From arbctl of sctag_arbctl.v
wire                    decdp_ld64_inst_c1;     // From arbctl of sctag_arbctl.v
wire                    decdp_ld64_inst_c2;     // From arbctl of sctag_arbctl.v
wire                    decdp_ld_inst_c2;       // From arbctl of sctag_arbctl.v
wire                    decdp_pf_inst_c5;       // From arbctl of sctag_arbctl.v
wire                    decdp_pst_inst_c2;      // From arbctl of sctag_arbctl.v
wire                    decdp_rmo_st_c3;        // From arbctl of sctag_arbctl.v
wire                    decdp_st_inst_c2;       // From arbctl of sctag_arbctl.v
wire                    decdp_st_inst_c3;       // From arbctl of sctag_arbctl.v
wire                    decdp_st_with_ctrue_c2; // From arbctl of sctag_arbctl.v
wire                    decdp_strld_inst_c6;    // From arbctl of sctag_arbctl.v
wire                    decdp_strst_inst_c2;    // From arbctl of sctag_arbctl.v
wire                    decdp_swap_inst_c2;     // From arbctl of sctag_arbctl.v
wire                    decdp_tagctl_wr_c1;     // From arbctl of sctag_arbctl.v
wire                    decdp_wr64_inst_c2;     // From arbctl of sctag_arbctl.v
wire                    decdp_wr8_inst_c2;      // From arbctl of sctag_arbctl.v
wire                    diag_or_tecc_write_px2; // From arbctl of sctag_arbctl.v
wire [25:0]             diag_rd_ua_out;         // From ua_dp of sctag_ua_dp.v
wire [25:0]             diag_rd_vd_out;         // From vd_dp of sctag_vd_dp.v
wire                    diag_wr_en;             // From csr_ctl of sctag_csr_ctl.v
wire [10:0]             dir_addr_c9;            // From arbctl of sctag_arbctl.v
wire [39:8]             dir_cam_addr_c3;        // From arbaddrdp of sctag_arbaddrdp.v
wire                    dir_error_c8;           // From dirrep of sctag_dirrep.v
wire                    dir_vld_c4_l;           // From dirrep of sctag_dirrep.v
wire [111:0]            dirdp_inval_pckt_c7;    // From dirvec_dp of sctag_dirvec_dp.v
wire [7:0]              dirdp_req_vec_c6;       // From dirvec_dp of sctag_dirvec_dp.v
wire [2:0]              dirdp_way_info_c7;      // From dirvec_dp of sctag_dirvec_dp.v
wire                    dirrep_dir_wr_par_c4;   // From dirrep of sctag_dirrep.v
wire                    dirty_evict_c3;         // From vd_dp of sctag_vd_dp.v
wire                    dirty_rd_parity_c2;     // From vd_dp of sctag_vd_dp.v
wire                    dram_scb_mecc_err_d1;   // From fbctl of sctag_fbctl.v
wire                    dram_scb_secc_err_d1;   // From fbctl of sctag_fbctl.v
wire [1:0]              dram_sctag_chunk_id_r1; // From fbctl of sctag_fbctl.v
wire                    dram_sctag_data_vld_r1; // From fbctl of sctag_fbctl.v
wire [7:0]              dword_mask_c8;          // From arbctl of sctag_arbctl.v
wire                    dword_sel_c7;           // From decc_ctl of sctag_decc_ctl.v
wire [`ERR_LDAC:`ERR_VEU]err_state_in;          // From csr_ctl of sctag_csr_ctl.v
wire                    err_state_in_mec;       // From csr_ctl of sctag_csr_ctl.v
wire                    err_state_in_meu;       // From csr_ctl of sctag_csr_ctl.v
wire                    err_state_in_rw;        // From csr_ctl of sctag_csr_ctl.v
wire                    error_ceen;             // From csr of sctag_csr.v
wire                    error_nceen;            // From csr of sctag_csr.v
wire                    error_rw_en;            // From csr_ctl of sctag_csr_ctl.v
wire                    error_status_vec;       // From csr of sctag_csr.v
wire                    error_status_veu;       // From csr of sctag_csr.v
wire                    ev_cerr_r6;             // From rdmatctl of sctag_rdmatctl.v
wire                    ev_uerr_r6;             // From rdmatctl of sctag_rdmatctl.v
wire [39:6]             evict_addr;             // From evicttag of sctag_evicttag_dp.v
wire                    evict_c3;               // From tagdp_ctl of sctag_tagdp_ctl.v
wire [39:0]             evicttag_addr_px2;      // From evicttag of sctag_evicttag_dp.v
wire                    fb_count_eq_0;          // From fbctl of sctag_fbctl.v
wire                    fbctl_arb_l2rd_en;      // From fbctl of sctag_fbctl.v
wire                    fbctl_arbctl_vld_px1;   // From fbctl of sctag_fbctl.v
wire [2:0]              fbctl_arbdp_entry_px2;  // From fbctl of sctag_fbctl.v
wire                    fbctl_arbdp_tecc_px2;   // From fbctl of sctag_fbctl.v
wire [3:0]              fbctl_arbdp_way_px2;    // From fbctl of sctag_fbctl.v
wire                    fbctl_bsc_corr_err_c12; // From fbctl of sctag_fbctl.v
wire                    fbctl_corr_err_c8;      // From fbctl of sctag_fbctl.v
wire                    fbctl_dbginit_l;        // From csr_ctl of sctag_csr_ctl.v
wire                    fbctl_decc_bscd_corr_err_c8;// From csr_ctl of sctag_csr_ctl.v
wire                    fbctl_decc_bscd_uncorr_err_c8;// From csr_ctl of sctag_csr_ctl.v
wire                    fbctl_decc_scrd_corr_err_c8;// From csr_ctl of sctag_csr_ctl.v
wire                    fbctl_decc_scrd_uncorr_err_c8;// From csr_ctl of sctag_csr_ctl.v
wire                    fbctl_dis_cerr_c3;      // From fbctl of sctag_fbctl.v
wire                    fbctl_dis_uerr_c3;      // From fbctl of sctag_fbctl.v
wire                    fbctl_fbd_rd_en_c2;     // From fbctl of sctag_fbctl.v
wire [2:0]              fbctl_fbd_rd_entry_c2;  // From fbctl of sctag_fbctl.v
wire [2:0]              fbctl_fbd_wr_entry_r1;  // From fbctl of sctag_fbctl.v
wire                    fbctl_l2_dir_map_on;    // From csr_ctl of sctag_csr_ctl.v
wire                    fbctl_ld64_fb_hit_c12;  // From fbctl of sctag_fbctl.v
wire                    fbctl_mbctl_entry_avail;// From fbctl of sctag_fbctl.v
wire [2:0]              fbctl_mbctl_fbid_d2;    // From fbctl of sctag_fbctl.v
wire                    fbctl_mbctl_match_c2;   // From fbctl of sctag_fbctl.v
wire                    fbctl_mbctl_nofill_d2;  // From fbctl of sctag_fbctl.v
wire                    fbctl_mbctl_stinst_match_c2;// From fbctl of sctag_fbctl.v
wire                    fbctl_spc_corr_err_c7;  // From fbctl of sctag_fbctl.v
wire                    fbctl_spc_rd_vld_c7;    // From fbctl of sctag_fbctl.v
wire                    fbctl_spc_uncorr_err_c7;// From fbctl of sctag_fbctl.v
wire                    fbctl_tagctl_hit_c2;    // From fbctl of sctag_fbctl.v
wire                    fbctl_uncorr_err_c8;    // From fbctl of sctag_fbctl.v
wire                    fbctl_vuad_bypassed_c3; // From fbctl of sctag_fbctl.v
wire [3:0]              fbf_enc_dep_mbid_c4;    // From fbctl of sctag_fbctl.v
wire [3:0]              fbf_enc_ld_mbid_r1;     // From fbctl of sctag_fbctl.v
wire                    fbf_ready_miss_r1;      // From fbctl of sctag_fbctl.v
wire                    fbf_st_or_dep_rdy_c4;   // From fbctl of sctag_fbctl.v
wire [11:0]             fill_way_c3;            // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire [1:0]              fuse_l2t_repair_en;     // From red_hdr of cmp_sram_redhdr.v
wire [7:0]              fuse_l2t_repair_value;  // From red_hdr of cmp_sram_redhdr.v
wire [5:0]              fuse_l2t_rid;           // From red_hdr of cmp_sram_redhdr.v
wire                    fuse_l2t_wren;          // From red_hdr of cmp_sram_redhdr.v
wire                    fwd_req_ret_c7;         // From oqctl of sctag_oqctl.v
wire [11:0]             hit_wayvld_c3;          // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    ic_dir_clear_c4;        // From dirrep of sctag_dirrep.v
wire                    ic_dir_clear_c4_buf_row0;// From ic_buf_row0 of sctag_dirl_buf.v
wire                    ic_dir_clear_c4_buf_row2;// From ic_buf_row1 of sctag_dirl_buf.v
wire [7:0]              ic_inv_mask_0145;       // From ic_ctl_0145 of sctag_dir_ctl.v
wire [7:0]              ic_inv_mask_2367;       // From ic_ctl_2367 of sctag_dir_ctl.v
wire [7:0]              ic_inv_mask_89cd;       // From ic_ctl_89cd of sctag_dir_ctl.v
wire [7:0]              ic_inv_mask_abef;       // From ic_ctl_abef of sctag_dir_ctl.v
wire [7:0]              ic_inv_mask_c4_buf_row0;// From ic_buf_row0 of sctag_dirl_buf.v
wire [7:0]              ic_inv_mask_c4_buf_row2;// From ic_buf_row1 of sctag_dirl_buf.v
wire [3:0]              ic_lkup_panel_dec_c4;   // From dirrep of sctag_dirrep.v
wire [3:0]              ic_lkup_row_dec_c4;     // From dirrep of sctag_dirrep.v
wire [32:0]             ic_lkup_wr_data_c4_row0;// From ic_buf_row0 of sctag_dirl_buf.v
wire [32:0]             ic_lkup_wr_data_c4_row2;// From ic_buf_row1 of sctag_dirl_buf.v
wire [2:0]              ic_parity_in;           // From out_col0 of sctag_dir_out.v, ...
wire [3:0]              ic_parity_out;          // From out_col3 of sctag_dir_out.v, ...
wire [31:0]             ic_rd_data04_row0;      // From ic_row0 of bw_r_dcm.v
wire [31:0]             ic_rd_data04_row1;      // From ic_row1 of bw_r_dcm.v
wire [31:0]             ic_rd_data15_row0;      // From ic_row0 of bw_r_dcm.v
wire [31:0]             ic_rd_data15_row1;      // From ic_row1 of bw_r_dcm.v
wire [31:0]             ic_rd_data26_row0;      // From ic_row0 of bw_r_dcm.v
wire [31:0]             ic_rd_data26_row1;      // From ic_row1 of bw_r_dcm.v
wire [31:0]             ic_rd_data37_row0;      // From ic_row0 of bw_r_dcm.v
wire [31:0]             ic_rd_data37_row1;      // From ic_row1 of bw_r_dcm.v
wire [31:0]             ic_rd_data8c_row2;      // From ic_row2 of bw_r_dcm.v
wire [31:0]             ic_rd_data8c_row3;      // From ic_row3 of bw_r_dcm.v
wire [31:0]             ic_rd_data9d_row2;      // From ic_row2 of bw_r_dcm.v
wire [31:0]             ic_rd_data9d_row3;      // From ic_row3 of bw_r_dcm.v
wire                    ic_rd_data_sel_0;       // From ic_ctl_0145 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_04;      // From ic_ctl_0145 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_1;       // From ic_ctl_0145 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_15;      // From ic_ctl_0145 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_2;       // From ic_ctl_2367 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_26;      // From ic_ctl_2367 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_3;       // From ic_ctl_2367 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_37;      // From ic_ctl_2367 of sctag_dir_ctl.v
wire                    ic_rd_data_sel_8;       // From ic_ctl_89cd of sctag_dir_ctl.v
wire                    ic_rd_data_sel_8c;      // From ic_ctl_89cd of sctag_dir_ctl.v
wire                    ic_rd_data_sel_9;       // From ic_ctl_89cd of sctag_dir_ctl.v
wire                    ic_rd_data_sel_9d;      // From ic_ctl_89cd of sctag_dir_ctl.v
wire                    ic_rd_data_sel_a;       // From ic_ctl_abef of sctag_dir_ctl.v
wire                    ic_rd_data_sel_ae;      // From ic_ctl_abef of sctag_dir_ctl.v
wire                    ic_rd_data_sel_b;       // From ic_ctl_abef of sctag_dir_ctl.v
wire                    ic_rd_data_sel_bf;      // From ic_ctl_abef of sctag_dir_ctl.v
wire [31:0]             ic_rd_dataae_row2;      // From ic_row2 of bw_r_dcm.v
wire [31:0]             ic_rd_dataae_row3;      // From ic_row3 of bw_r_dcm.v
wire [31:0]             ic_rd_databf_row2;      // From ic_row2 of bw_r_dcm.v
wire [31:0]             ic_rd_databf_row3;      // From ic_row3 of bw_r_dcm.v
wire                    ic_rd_en_c4;            // From dirrep of sctag_dirrep.v
wire                    ic_rd_en_c4_buf_row0;   // From ic_buf_row0 of sctag_dirl_buf.v
wire                    ic_rd_en_c4_buf_row2;   // From ic_buf_row1 of sctag_dirl_buf.v
wire [31:0]             ic_rddata_out_04;       // From ic_in_04 of sctag_dir_in.v
wire [31:0]             ic_rddata_out_15;       // From ic_in_15 of sctag_dir_in.v
wire [31:0]             ic_rddata_out_26;       // From ic_in_26 of sctag_dir_in.v
wire [31:0]             ic_rddata_out_37;       // From ic_in_37 of sctag_dir_in.v
wire [31:0]             ic_rddata_out_8c;       // From ic_in_8c of sctag_dir_in.v
wire [31:0]             ic_rddata_out_9d;       // From ic_in_9d of sctag_dir_in.v
wire [31:0]             ic_rddata_out_ae;       // From ic_in_ae of sctag_dir_in.v
wire [31:0]             ic_rddata_out_bf;       // From ic_in_bf of sctag_dir_in.v
wire [3:0]              ic_rdwr_panel_dec_c4;   // From dirrep of sctag_dirrep.v
wire [3:0]              ic_rdwr_row_en_c4;      // From dirrep of sctag_dirrep.v
wire [5:0]              ic_rw_addr_0145;        // From ic_ctl_0145 of sctag_dir_ctl.v
wire [5:0]              ic_rw_addr_2367;        // From ic_ctl_2367 of sctag_dir_ctl.v
wire [5:0]              ic_rw_addr_89cd;        // From ic_ctl_89cd of sctag_dir_ctl.v
wire [5:0]              ic_rw_addr_abef;        // From ic_ctl_abef of sctag_dir_ctl.v
wire [5:0]              ic_rw_entry_c4_buf_row0;// From ic_buf_row0 of sctag_dirl_buf.v
wire [5:0]              ic_rw_entry_c4_buf_row2;// From ic_buf_row1 of sctag_dirl_buf.v
wire                    ic_warm_rst_0145;       // From ic_ctl_0145 of sctag_dir_ctl.v
wire                    ic_warm_rst_2367;       // From ic_ctl_2367 of sctag_dir_ctl.v
wire                    ic_warm_rst_89cd;       // From ic_ctl_89cd of sctag_dir_ctl.v
wire                    ic_warm_rst_abef;       // From ic_ctl_abef of sctag_dir_ctl.v
wire [32:0]             ic_wr_data04;           // From ic_in_04 of sctag_dir_in.v
wire [32:0]             ic_wr_data15;           // From ic_in_15 of sctag_dir_in.v
wire [32:0]             ic_wr_data26;           // From ic_in_26 of sctag_dir_in.v
wire [32:0]             ic_wr_data37;           // From ic_in_37 of sctag_dir_in.v
wire [32:0]             ic_wr_data8c;           // From ic_in_8c of sctag_dir_in.v
wire [32:0]             ic_wr_data9d;           // From ic_in_9d of sctag_dir_in.v
wire [32:0]             ic_wr_dataae;           // From ic_in_ae of sctag_dir_in.v
wire [32:0]             ic_wr_databf;           // From ic_in_bf of sctag_dir_in.v
wire                    ic_wr_en_c4;            // From dirrep of sctag_dirrep.v
wire                    ic_wr_en_c4_buf_row0;   // From ic_buf_row0 of sctag_dirl_buf.v
wire                    ic_wr_en_c4_buf_row2;   // From ic_buf_row1 of sctag_dirl_buf.v
wire                    idx_c1c2comp_c1;        // From arbaddrdp of sctag_arbaddrdp.v
wire                    idx_c1c3comp_c1;        // From arbaddrdp of sctag_arbaddrdp.v
wire                    idx_c1c4comp_c1;        // From arbaddrdp of sctag_arbaddrdp.v
wire                    idx_c1c5comp_c1;        // From arbaddrdp of sctag_arbaddrdp.v
wire                    inc_tag_ecc_cnt_c3_n;   // From arbctl of sctag_arbctl.v
wire [7:0]              inval_mask_dcd_c4;      // From dirrep of sctag_dirrep.v
wire [7:0]              inval_mask_icd_c4;      // From dirrep of sctag_dirrep.v
wire                    invalid_evict_c3;       // From tagdp_ctl of sctag_tagdp_ctl.v
wire                    iq_arbctl_atm_px2;      // From iqdp of sctag_iqdp.v
wire                    iq_arbctl_csr_px2;      // From iqdp of sctag_iqdp.v
wire                    iq_arbctl_st_px2;       // From iqdp of sctag_iqdp.v
wire                    iq_arbctl_vbit_px2;     // From iqdp of sctag_iqdp.v
wire                    iq_arbctl_vld_px2;      // From iqctl of sctag_iqctl.v
wire [39:0]             iq_arbdp_addr_px2;      // From iqdp of sctag_iqdp.v
wire [63:0]             iq_arbdp_data_px2;      // From iqdp of sctag_iqdp.v
wire [18:0]             iq_arbdp_inst_px2;      // From iqdp of sctag_iqdp.v
wire                    iqctl_hold_rd;          // From iqctl of sctag_iqctl.v
wire                    iqctl_sel_c1;           // From iqctl of sctag_iqctl.v
wire                    iqctl_sel_pcx;          // From iqctl of sctag_iqctl.v
wire                    l2_bypass_mode_on;      // From csr of sctag_csr.v
wire                    l2_dbg_en;              // From csr of sctag_csr.v
wire                    l2_dir_map_on;          // From csr of sctag_csr.v
wire [4:0]              l2_steering_tid;        // From csr of sctag_csr.v
wire [1:0]              l2t_fuse_repair_en;     // From tag of bw_r_l2t.v
wire [6:0]              l2t_fuse_repair_value;  // From tag of bw_r_l2t.v
wire [27:0]             lda_syndrome_c9;        // From deccdp of sctag_deccdp.v
wire                    lkup_addr8_c4;          // From dirrep of sctag_dirrep.v
wire [`TAG_WIDTH-1:1]   lkup_tag_c1;            // From tagdp of sctag_tagdp.v
wire [32:0]             lkup_wr_data_dn_buf;    // From dirg_buf of sctag_dirg_buf.v
wire [32:0]             lkup_wr_data_up_buf;    // From dirg_buf of sctag_dirg_buf.v
wire [11:0]             lru_way_c3;             // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire [11:0]             lru_way_sel_c3;         // From tagdp_ctl of sctag_tagdp_ctl.v
wire [127:0]            mb_data_read_data;      // From mbdata of bw_r_rf16x128d.v
wire                    mbctl_arb_dramrd_en;    // From mbctl of sctag_mbctl.v
wire                    mbctl_arb_l2rd_en;      // From mbctl of sctag_mbctl.v
wire                    mbctl_arbctl_cnt12_px2_prev;// From mbctl of sctag_mbctl.v
wire                    mbctl_arbctl_hit_c3;    // From mbctl of sctag_mbctl.v
wire                    mbctl_arbctl_snp_cnt8_px1;// From mbctl of sctag_mbctl.v
wire                    mbctl_arbctl_vld_px1;   // From mbctl of sctag_mbctl.v
wire                    mbctl_arbdp_ctrue_px2;  // From mbctl of sctag_mbctl.v
wire                    mbctl_corr_err_c2;      // From mbctl of sctag_mbctl.v
wire                    mbctl_dbginit_l;        // From csr_ctl of sctag_csr_ctl.v
wire                    mbctl_decc_spcd_corr_err_c8;// From csr_ctl of sctag_csr_ctl.v
wire                    mbctl_decc_spcfb_corr_err_c8;// From csr_ctl of sctag_csr_ctl.v
wire                    mbctl_fbctl_dram_pick;  // From mbctl of sctag_mbctl.v
wire [2:0]              mbctl_fbctl_fbid;       // From mbctl of sctag_mbctl.v
wire [3:0]              mbctl_fbctl_next_link_c4;// From mbctl of sctag_mbctl.v
wire                    mbctl_fbctl_next_vld_c4;// From mbctl of sctag_mbctl.v
wire [3:0]              mbctl_fbctl_way;        // From mbctl of sctag_mbctl.v
wire                    mbctl_fbctl_way_fbid_vld;// From mbctl of sctag_mbctl.v
wire                    mbctl_hit_c3;           // From mbctl of sctag_mbctl.v
wire                    mbctl_hit_c4;           // From mbctl of sctag_mbctl.v
wire                    mbctl_l2_dir_map_on;    // From csr_ctl of sctag_csr_ctl.v
wire                    mbctl_nondep_fbhit_c3;  // From mbctl of sctag_mbctl.v
wire                    mbctl_rdma_reg_vld_c2;  // From tagctl of sctag_tagctl.v
wire                    mbctl_tagctl_hit_unqual_c2;// From mbctl of sctag_mbctl.v
wire                    mbctl_uncorr_err_c2;    // From mbctl of sctag_mbctl.v
wire [3:0]              mbctl_wbctl_mbid_c4;    // From mbctl of sctag_mbctl.v
wire                    mbctl_wr64_miss_comp_c3;// From mbctl of sctag_mbctl.v
wire                    mbf_delete_c4;          // From mbctl of sctag_mbctl.v
wire                    mbf_insert_c4;          // From mbctl of sctag_mbctl.v
wire [3:0]              mbf_insert_mbid_c4;     // From mbctl of sctag_mbctl.v
wire                    mbist_arb_l2d_en;       // From mbist of sctag_mbist.v
wire                    mbist_arb_l2d_write;    // From mbist of sctag_mbist.v
wire                    mbist_arbctl_l2t_write; // From mbist of sctag_mbist.v
wire                    mbist_l2d_en;           // From mbist of sctag_mbist.v
wire [9:0]              mbist_l2d_index;        // From mbist of sctag_mbist.v
wire [3:0]              mbist_l2d_way;          // From mbist of sctag_mbist.v
wire [3:0]              mbist_l2d_word_sel;     // From mbist of sctag_mbist.v
wire                    mbist_l2d_write;        // From mbist of sctag_mbist.v
wire [11:0]             mbist_l2t_dec_way;      // From mbist of sctag_mbist.v
wire [11:0]             mbist_l2t_dec_way_buf;  // From tagdp of sctag_tagdp.v
wire [9:0]              mbist_l2t_index;        // From mbist of sctag_mbist.v
wire [9:0]              mbist_l2t_index_buf;    // From tagdp of sctag_tagdp.v
wire                    mbist_l2t_read;         // From mbist of sctag_mbist.v
wire                    mbist_l2t_read_buf;     // From tagdp of sctag_tagdp.v
wire [3:0]              mbist_l2t_way;          // From mbist of sctag_mbist.v
wire                    mbist_l2t_write;        // From mbist of sctag_mbist.v
wire                    mbist_l2t_write_buf;    // From tagdp of sctag_tagdp.v
wire [9:0]              mbist_l2v_index;        // From mbist of sctag_mbist.v
wire                    mbist_l2v_read;         // From mbist of sctag_mbist.v
wire                    mbist_l2v_vd;           // From mbist of sctag_mbist.v
wire                    mbist_l2v_write;        // From mbist of sctag_mbist.v
wire                    mbist_stop_on_next_fail;// From test_stub of test_stub_bist.v
wire [7:0]              mbist_write_data;       // From mbist of sctag_mbist.v
wire [7:0]              mbist_write_data_buf;   // From tagdp of sctag_tagdp.v
wire [3:0]              mux1_addr_sel;          // From csr_ctl of sctag_csr_ctl.v
wire [3:0]              mux1_h_sel_r0;          // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux1_h_sel_r2;          // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux1_h_sel_r4;          // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux1_h_sel_r6;          // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux1_l_sel_r0;          // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux1_l_sel_r2;          // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux1_l_sel_r4;          // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux1_l_sel_r6;          // From vuad_ctl of sctag_vuad_ctl.v
wire                    mux1_mbsel_px1;         // From arbctl of sctag_arbctl.v
wire                    mux1_mbsel_px2;         // From arbctl of sctag_arbctl.v
wire [3:0]              mux1_sel_data_c7;       // From oqctl of sctag_oqctl.v
wire [1:0]              mux1_synd_sel;          // From csr_ctl of sctag_csr_ctl.v
wire [2:0]              mux2_addr_sel;          // From csr_ctl of sctag_csr_ctl.v
wire                    mux2_sel_r0;            // From vuad_ctl of sctag_vuad_ctl.v
wire                    mux2_sel_r2;            // From vuad_ctl of sctag_vuad_ctl.v
wire                    mux2_sel_r4;            // From vuad_ctl of sctag_vuad_ctl.v
wire                    mux2_sel_r6;            // From vuad_ctl of sctag_vuad_ctl.v
wire                    mux2_snpsel_px2;        // From arbctl of sctag_arbctl.v
wire [1:0]              mux2_synd_sel;          // From csr_ctl of sctag_csr_ctl.v
wire                    mux3_bufsel_px2;        // From arbctl of sctag_arbctl.v
wire                    mux4_c1sel_px2;         // From arbctl of sctag_arbctl.v
wire                    mux_csr_sel_c7;         // From oqctl of sctag_oqctl.v
wire [3:0]              mux_sel;                // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              mux_vec_sel_c6;         // From oqctl of sctag_oqctl.v
wire                    oneshot_dir_clear_c3;   // From csr of sctag_csr.v
wire                    oqctl_arbctl_full_px2;  // From oqctl of sctag_oqctl.v
wire                    oqctl_cerr_ack_c7;      // From oqctl of sctag_oqctl.v
wire                    oqctl_diag_acc_c8;      // From oqctl of sctag_oqctl.v
wire                    oqctl_imiss_hit_c8;     // From oqctl of sctag_oqctl.v
wire                    oqctl_int_ack_c7;       // From oqctl of sctag_oqctl.v
wire                    oqctl_l2_miss_c7;       // From oqctl of sctag_oqctl.v
wire                    oqctl_pf_ack_c7;        // From oqctl of sctag_oqctl.v
wire                    oqctl_rmo_st_c7;        // From oqctl of sctag_oqctl.v
wire [3:0]              oqctl_rqtyp_rtn_c7;     // From oqctl of sctag_oqctl.v
wire                    oqctl_st_complete_c7;   // From oqctl of sctag_oqctl.v
wire                    oqctl_uerr_ack_c7;      // From oqctl of sctag_oqctl.v
wire [4:0]              oqdp_tid_c8;            // From oqdp of sctag_oqdp.v
wire                    or_rdmat_valid;         // From rdmatctl of sctag_rdmatctl.v
wire [2:0]              out_mux1_sel_c7;        // From oqctl of sctag_oqctl.v
wire [2:0]              out_mux2_sel_c7;        // From oqctl of sctag_oqctl.v
wire                    parity0_c7;             // From deccdp of sctag_deccdp.v
wire                    parity1_c7;             // From deccdp of sctag_deccdp.v
wire                    parity2_c7;             // From deccdp of sctag_deccdp.v
wire                    parity3_c7;             // From deccdp of sctag_deccdp.v
wire                    pcx_sctag_atm_px2_p;    // From iqctl of sctag_iqctl.v
wire                    prim_req_c3;            // From arbctl of sctag_arbctl.v
wire [4:0]              rd_addr1_r0;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr1_r1;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr1_r2;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr1_r3;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr1_r4;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr1_r5;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr1_r6;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr1_r7;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r0;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r1;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r2;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r3;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r4;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r5;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r6;            // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              rd_addr2_r7;            // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r0;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r1;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r2;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r3;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r4;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r5;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r6;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_addr_sel_r7;         // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r0;               // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r1;               // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r2;               // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r3;               // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r4;               // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r5;               // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r6;               // From vuad_ctl of sctag_vuad_ctl.v
wire                    rd_en_r7;               // From vuad_ctl of sctag_vuad_ctl.v
wire [1:0]              rdmad_wr_entry_s2;      // From snpctl of sctag_snpctl.v
wire [39:6]             rdmard_addr_c12;        // From arbaddrdp of sctag_arbaddrdp.v
wire                    rdmard_cerr_c12;        // From rdmatctl of sctag_rdmatctl.v
wire                    rdmard_uerr_c12;        // From rdmatctl of sctag_rdmatctl.v
wire [3:0]              rdmat_pick_vec;         // From rdmatctl of sctag_rdmatctl.v
wire [1:0]              rdmat_wr_entry_s1;      // From rdmatctl of sctag_rdmatctl.v
wire                    rdmatctl_hit_unqual_c2; // From rdmatctl of sctag_rdmatctl.v
wire [3:0]              rdmatctl_mbctl_dep_mbid;// From rdmatctl of sctag_rdmatctl.v
wire                    rdmatctl_mbctl_dep_rdy_en;// From rdmatctl of sctag_rdmatctl.v
wire [77:0]             rep_store_data_c2;      // From stdatarep2 of sctag_stdatarep.v
wire [3:0]              reset_rdmat_vld;        // From wbctl of sctag_wbctl.v
wire [127:0]            retdp_data_c8;          // From deccdp of sctag_deccdp.v
wire [38:0]             retdp_diag_data_c7;     // From deccdp of sctag_deccdp.v
wire [2:0]              retdp_err_c8;           // From decc_ctl of sctag_decc_ctl.v
wire                    scbuf_fbd_stdatasel_c3; // From tagctl of sctag_tagctl.v
wire [15:0]             scbuf_fbwr_wen_r2;      // From tagctl of sctag_tagctl.v
wire [3:0]              scdata_col_offset_c2;   // From tagctl of sctag_tagctl.v
wire                    scdata_fb_hit_c3;       // From fbctl of sctag_fbctl.v
wire                    scdata_fbrd_c3;         // From arbctl of sctag_arbctl.v
wire                    scdata_rd_wr_c2;        // From tagctl of sctag_tagctl.v
wire [9:0]              scdata_set_c2;          // From arbaddrdp of sctag_arbaddrdp.v
wire [11:0]             scdata_way_sel_c2;      // From tagctl of sctag_tagctl.v
wire [15:0]             scdata_word_en_c2;      // From tagctl of sctag_tagctl.v
wire [3:0]              scrub_addr_way;         // From tagctl of sctag_tagctl.v
wire                    sctag_por_req;          // From csr_ctl of sctag_csr_ctl.v
wire                    sel_array_out_l;        // From oqctl of sctag_oqctl.v
wire                    sel_c1reg_over_iqarray; // From iqctl of sctag_iqctl.v
wire                    sel_c2_stall_idx_c1;    // From arbctl of sctag_arbctl.v
wire                    sel_decc_addr_px2;      // From arbctl of sctag_arbctl.v
wire                    sel_decc_or_bist_idx;   // From arbctl of sctag_arbctl.v
wire                    sel_diag0_data_wr_c3;   // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    sel_diag1_data_wr_c3;   // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    sel_diag_addr_px2;      // From arbctl of sctag_arbctl.v
wire                    sel_diag_tag_addr_px2;  // From arbctl of sctag_arbctl.v
wire                    sel_higher_dword_c7;    // From decc_ctl of sctag_decc_ctl.v
wire                    sel_higher_word_c7;     // From decc_ctl of sctag_decc_ctl.v
wire                    sel_inval_c7;           // From oqctl of sctag_oqctl.v
wire                    sel_lkup_stalled_tag_px2;// From arbctl of sctag_arbctl.v
wire [3:0]              sel_mux1_c6;            // From oqctl of sctag_oqctl.v
wire [3:0]              sel_mux2_c6;            // From oqctl of sctag_oqctl.v
wire                    sel_mux3_c6;            // From oqctl of sctag_oqctl.v
wire                    sel_rdma_inval_vec_c5;  // From tagctl of sctag_tagctl.v
wire                    sel_tecc_addr_px2;      // From arbctl of sctag_arbctl.v
wire                    sel_ua_wr_data_byp;     // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    sel_vd_wr_data_byp;     // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    sel_vuad_bist_px2;      // From arbctl of sctag_arbctl.v
wire                    sel_way_px2;            // From arbctl of sctag_arbctl.v
wire                    set_async_c9;           // From csr_ctl of sctag_csr_ctl.v
wire [3:0]              set_rdmat_acked;        // From wbctl of sctag_wbctl.v
wire [1:0]              size_field_c8;          // From arbdecdp of sctag_arbdecdp.v
wire                    snp_data1_wen0_s2;      // From snpctl of sctag_snpctl.v
wire                    snp_data1_wen1_s2;      // From snpctl of sctag_snpctl.v
wire                    snp_data2_wen0_s3;      // From snpctl of sctag_snpctl.v
wire                    snp_data2_wen1_s3;      // From snpctl of sctag_snpctl.v
wire                    snp_hdr1_wen0_s0;       // From snpctl of sctag_snpctl.v
wire                    snp_hdr1_wen1_s0;       // From snpctl of sctag_snpctl.v
wire                    snp_hdr2_wen0_s1;       // From snpctl of sctag_snpctl.v
wire                    snp_hdr2_wen1_s1;       // From snpctl of sctag_snpctl.v
wire                    snpctl_rd_ptr;          // From snpctl of sctag_snpctl.v
wire                    snpctl_wr_ptr;          // From snpctl of sctag_snpctl.v
wire                    snpdp_rq_winv_s1;       // From snpdp of sctag_snpdp.v
wire                    snpq_arbctl_vld_px1;    // From snpctl of sctag_snpctl.v
wire [39:0]             snpq_arbdp_addr_px2;    // From snpdp of sctag_snpdp.v
wire [63:0]             snpq_arbdp_data_px2;    // From snpdp of sctag_snpdp.v
wire                    spc_rd_cond_c3;         // From tagctl of sctag_tagctl.v
wire                    st_to_data_array_c3;    // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    store_err_c8;           // From arbctl of sctag_arbctl.v
wire                    str_ld_hit_c7;          // From oqctl of sctag_oqctl.v
wire                    strst_ack_c7;           // From oqctl of sctag_oqctl.v
wire                    tag_error_c8;           // From tagdp_ctl of sctag_tagdp_ctl.v
wire [11:0]             tag_parity_c2;          // From tagl_dp_1 of sctag_tagl_dp.v, ...
wire [3:0]              tag_quad_muxsel_c3;     // From tagdp_ctl of sctag_tagdp_ctl.v
wire [`TAG_WIDTH-1:0]   tag_triad0_c3;          // From tagl_dp_1 of sctag_tagl_dp.v
wire [`TAG_WIDTH-1:0]   tag_triad1_c3;          // From tagl_dp_1 of sctag_tagl_dp.v
wire [`TAG_WIDTH-1:0]   tag_triad2_c3;          // From tagl_dp_2 of sctag_tagl_dp.v
wire [`TAG_WIDTH-1:0]   tag_triad3_c3;          // From tagl_dp_2 of sctag_tagl_dp.v
wire [27:0]             tag_way0_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way10_tag_c2;       // From tag of bw_r_l2t.v
wire [27:0]             tag_way11_tag_c2;       // From tag of bw_r_l2t.v
wire [27:0]             tag_way1_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way2_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way3_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way4_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way5_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way6_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way7_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way8_tag_c2;        // From tag of bw_r_l2t.v
wire [27:0]             tag_way9_tag_c2;        // From tag of bw_r_l2t.v
wire [11:0]             tag_way_sel_c2;         // From tag of bw_r_l2t.v
wire [27:0]             tag_wrdata_px2;         // From arbaddrdp of sctag_arbaddrdp.v
wire [27:0]             tag_wrdata_px2_buf;     // From tagdp of sctag_tagdp.v
wire                    tagctl_bsc_rd_vld_c7;   // From tagctl of sctag_tagctl.v
wire                    tagctl_cerr_ack_c5;     // From tagctl of sctag_tagctl.v
wire                    tagctl_dbginit_l;       // From csr_ctl of sctag_csr_ctl.v
wire                    tagctl_decc_addr3_c7;   // From tagctl of sctag_tagctl.v
wire                    tagctl_decc_data_sel_c8;// From tagctl of sctag_tagctl.v
wire                    tagctl_fwd_req_ld_c6;   // From tagctl of sctag_tagctl.v
wire                    tagctl_fwd_req_ret_c5;  // From tagctl of sctag_tagctl.v
wire                    tagctl_hit_c3;          // From tagctl of sctag_tagctl.v
wire                    tagctl_hit_c5;          // From tagctl of sctag_tagctl.v
wire                    tagctl_hit_l2orfb_c3;   // From tagctl of sctag_tagctl.v
wire                    tagctl_hit_not_comp_c3; // From tagctl of sctag_tagctl.v
wire                    tagctl_hit_unqual_c2;   // From tagctl of sctag_tagctl.v
wire [11:0]             tagctl_hit_way_vld_c3;  // From tagctl of sctag_tagctl.v
wire                    tagctl_imiss_hit_c5;    // From tagctl of sctag_tagctl.v
wire                    tagctl_inc_rdma_cnt_c4; // From tagctl of sctag_tagctl.v
wire                    tagctl_inst_mb_c5;      // From tagctl of sctag_tagctl.v
wire                    tagctl_int_ack_c5;      // From tagctl of sctag_tagctl.v
wire                    tagctl_jbi_req_en_c6;   // From tagctl of sctag_tagctl.v
wire                    tagctl_ld_hit_c5;       // From tagctl of sctag_tagctl.v
wire [3:0]              tagctl_lru_way_c4;      // From tagctl of sctag_tagctl.v
wire                    tagctl_mbctl_par_err_c3;// From tagctl of sctag_tagctl.v
wire                    tagctl_miss_unqual_c2;  // From tagctl of sctag_tagctl.v
wire                    tagctl_nonmem_comp_c6;  // From tagctl of sctag_tagctl.v
wire                    tagctl_rd64_complete_c11;// From tagctl of sctag_tagctl.v
wire                    tagctl_rdma_ev_en_c4;   // From tagctl of sctag_tagctl.v
wire                    tagctl_rdma_gate_off_c2;// From tagctl of sctag_tagctl.v
wire                    tagctl_rdma_vld_px0_p;  // From tagctl of sctag_tagctl.v
wire                    tagctl_rdma_vld_px1;    // From tagctl of sctag_tagctl.v
wire                    tagctl_rdma_wr_comp_c4; // From tagctl of sctag_tagctl.v
wire                    tagctl_rmo_st_ack_c5;   // From tagctl of sctag_tagctl.v
wire                    tagctl_scrub_rd_vld_c7; // From tagctl of sctag_tagctl.v
wire                    tagctl_set_rdma_reg_vld_c4;// From tagctl of sctag_tagctl.v
wire                    tagctl_spc_rd_vld_c7;   // From tagctl of sctag_tagctl.v
wire                    tagctl_st_ack_c5;       // From tagctl of sctag_tagctl.v
wire                    tagctl_st_req_c5;       // From tagctl of sctag_tagctl.v
wire                    tagctl_st_to_data_array_c3;// From tagctl of sctag_tagctl.v
wire                    tagctl_store_inst_c5;   // From tagctl of sctag_tagctl.v
wire                    tagctl_strst_ack_c5;    // From tagctl of sctag_tagctl.v
wire                    tagctl_uerr_ack_c5;     // From tagctl of sctag_tagctl.v
wire                    tagdp_arbctl_par_err_c3;// From tagdp_ctl of sctag_tagdp_ctl.v
wire                    tagdp_ctl_dbginit_l;    // From csr_ctl of sctag_csr_ctl.v
wire [`TAG_WIDTH-1:0]   tagdp_diag_data_c7;     // From tagdp of sctag_tagdp.v
wire [`TAG_WIDTH-1:0]   tagdp_evict_tag_c4;     // From tagdp of sctag_tagdp.v
wire [`TAG_WIDTH-1:6]   tagdp_evict_tag_c4_buf; // From arbaddrdp of sctag_arbaddrdp.v
wire                    tagdp_l2_dir_map_on;    // From csr_ctl of sctag_csr_ctl.v
wire                    tagdp_lkup_addr11_c4;   // From tagdp of sctag_tagdp.v
wire                    tagdp_lkup_addr11_c5;   // From dirrep of sctag_dirrep.v
wire                    tagdp_mbctl_par_err_c3; // From tagdp_ctl of sctag_tagdp_ctl.v
wire                    tagdp_tagctl_par_err_c3;// From tagdp_ctl of sctag_tagdp_ctl.v
wire [11:0]             tagdp_way_sel_c2;       // From tag of bw_r_l2t.v
wire [2:0]              triad0_muxsel_c3;       // From tagdp_ctl of sctag_tagdp_ctl.v
wire [2:0]              triad1_muxsel_c3;       // From tagdp_ctl of sctag_tagdp_ctl.v
wire [2:0]              triad2_muxsel_c3;       // From tagdp_ctl of sctag_tagdp_ctl.v
wire [2:0]              triad3_muxsel_c3;       // From tagdp_ctl of sctag_tagdp_ctl.v
wire                    uerr_ack_tmp_c4;        // From tagctl of sctag_tagctl.v
wire                    used_rd_parity_c2;      // From ua_dp of sctag_ua_dp.v
wire                    valid_rd_parity_c2;     // From vd_dp of sctag_vd_dp.v
wire [51:0]             vuad_array_rd_data_c1;  // From io_left of sctag_vuad_io.v, ...
wire [51:0]             vuad_array_wr_data_c4;  // From vd_dp of sctag_vd_dp.v, ...
wire                    vuad_array_wr_en0_c4;   // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuad_array_wr_en1_c4;   // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire [11:0]             vuad_dp_alloc_c2;       // From ua_dp of sctag_ua_dp.v
wire [25:0]             vuad_dp_diag_data_c7;   // From vuad_dpm of sctag_vuad_dpm.v
wire [11:0]             vuad_dp_used_c2;        // From ua_dp of sctag_ua_dp.v
wire [11:0]             vuad_dp_valid_c2;       // From vd_dp of sctag_vd_dp.v
wire                    vuad_error_c8;          // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuad_evict_c3;          // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire [9:0]              vuad_idx_c3;            // From evicttag of sctag_evicttag_dp.v
wire [9:0]              vuad_idx_c4;            // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuad_sel_c2;            // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuad_sel_c2_d1;         // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuad_sel_c2orc3;        // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuad_sel_c4;            // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuad_sel_rd;            // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire [3:0]              vuad_syndrome_c9;       // From vuad_dpm of sctag_vuad_dpm.v
wire                    vuad_tagdp_sel_c2_d1;   // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    vuadctl_no_bypass_px2;  // From arbctl of sctag_arbctl.v
wire                    wb_or_rdma_wr_req_en;   // From wbctl of sctag_wbctl.v
wire                    wbctl_arbctl_full_px1;  // From wbctl of sctag_wbctl.v
wire                    wbctl_dbginit_l;        // From csr_ctl of sctag_csr_ctl.v
wire                    wbctl_hit_unqual_c2;    // From wbctl of sctag_wbctl.v
wire [3:0]              wbctl_mbctl_dep_mbid;   // From wbctl of sctag_wbctl.v
wire                    wbctl_mbctl_dep_rdy_en; // From wbctl of sctag_wbctl.v
wire                    wbctl_wr_addr_sel;      // From wbctl of sctag_wbctl.v
wire [3:0]              word_en_r0;             // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              word_en_r1;             // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              word_en_r2;             // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              word_en_r3;             // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              word_en_r4;             // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              word_en_r5;             // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              word_en_r6;             // From vuad_ctl of sctag_vuad_ctl.v
wire [3:0]              word_en_r7;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    word_lower_cmp_c8;      // From arbdatadp of sctag_arbdatadp.v
wire                    word_upper_cmp_c8;      // From arbdatadp of sctag_arbdatadp.v
wire                    wr64_inst_c3;           // From vuaddp_ctl of sctag_vuaddp_ctl.v
wire                    wr8_inst_no_ctrue_c1;   // From arbctl of sctag_arbctl.v
wire [4:0]              wr_addr_r0;             // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              wr_addr_r1;             // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              wr_addr_r2;             // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              wr_addr_r3;             // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              wr_addr_r4;             // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              wr_addr_r5;             // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              wr_addr_r6;             // From vuad_ctl of sctag_vuad_ctl.v
wire [4:0]              wr_addr_r7;             // From vuad_ctl of sctag_vuad_ctl.v
wire [5:0]              wr_dc_dir_entry_c4;     // From dirrep of sctag_dirrep.v
wire                    wr_en_r0c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r0c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r1c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r1c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r2c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r2c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r3c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r3c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r4c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r4c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r5c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r5c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r6c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r6c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r7c0;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_en_r7c1;             // From vuad_ctl of sctag_vuad_ctl.v
wire                    wr_enable_tid_c9;       // From csr_ctl of sctag_csr_ctl.v
wire [5:0]              wr_ic_dir_entry_c4;     // From dirrep of sctag_dirrep.v
wire                    write_req_c3;           // From arbctl of sctag_arbctl.v
wire			unused;
wire [1:0]		unused2;
// End of automatics











// Repeater F is located right on the left of dirrep and receives all the signals directly from 
// the test stub.

sctag_slow_rptr	slow_rep_f	(
                       .areset_l_0_buf    (areset_l_0_buf_f),
                       .areset_l_1_buf    (areset_l_1_buf_f),
                       .greset_l_0_buf    (),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_f),
                       .scan_enable_1_buf(scan_enable_1_buf_f),
                       .sehold_0_buf    (sehold_0_buf_f),
                       .sehold_1_buf    (sehold_1_buf_f),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_f),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_f),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_f),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_f),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (arst_l),
                       .areset_l_1        (arst_l),
                       .greset_l_0        (1'b0),
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (se),
                       .scan_enable_1   (se),
                       .sehold_0        (sehold),
                       .sehold_1        (sehold),
                       .mux_drive_disable_0(mux_drive_disable),
                       .mux_drive_disable_1(mux_drive_disable),
                       .mem_write_disable_0(mem_write_disable),
                       .mem_write_disable_1(mem_write_disable),
                       .sig0            (1'b0),
                       .sig1            (1'b0),
                       .sig2            (1'b0),
                       .sig3            (1'b0)); // not used


// C connects to F at one end and D at the other.
sctag_slow_rptr slow_rep_c      (
                       .areset_l_0_buf    (areset_l_0_buf_c),
                       .areset_l_1_buf    (areset_l_1_buf_c),
                       .greset_l_0_buf    (),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_c),
                       .scan_enable_1_buf(scan_enable_1_buf_c),
                       .sehold_0_buf    (sehold_0_buf_c),
                       .sehold_1_buf    (sehold_1_buf_c),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_c),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_c),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_c),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_c),
                       .sig0_buf        (scanin_buf),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_f),
                       .areset_l_1        (areset_l_1_buf_f),
                       .greset_l_0        (1'b0), // not used
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_f),
                       .scan_enable_1   (scan_enable_1_buf_f),
                       .sehold_0        (sehold_1_buf_f),
                       .sehold_1        (sehold_1_buf_f),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_f),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_f),
                       .mem_write_disable_0(mem_write_disable_1_buf_f),
                       .mem_write_disable_1(mem_write_disable_1_buf_f),
                       .sig0            (ctu_sctag_scanin_buf1),
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used


// D connects to C at one end and NOTHING at the other.
sctag_slow_rptr slow_rep_d      (
                       .areset_l_0_buf    (areset_l_0_buf_d),
                       .areset_l_1_buf    (),
                       .greset_l_0_buf    (),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_d),
                       .scan_enable_1_buf(),
                       .sehold_0_buf    (sehold_0_buf_d),
                       .sehold_1_buf    (sehold_1_buf_d),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_d),
                       .mux_drive_disable_1_buf(),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_d),
                       .mem_write_disable_1_buf(),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_c),
                       .areset_l_1        (1'b0),
                       .greset_l_0        (1'b0), // not used
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_c),
                       .scan_enable_1   (1'b0),
                       .sehold_0        (sehold_1_buf_c),
                       .sehold_1        (sehold_1_buf_c),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_c),
                       .mux_drive_disable_1(1'b0),
                       .mem_write_disable_0(mem_write_disable_1_buf_c),
                       .mem_write_disable_1(1'b0),
                       .sig0            (1'b0), // not used
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used



// B connects to F at one end and A at the other.
sctag_slow_rptr slow_rep_b      (
                       .areset_l_0_buf    (areset_l_0_buf_b),
                       .areset_l_1_buf    (areset_l_1_buf_b),
                       .greset_l_0_buf    (),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_b),
                       .scan_enable_1_buf(scan_enable_1_buf_b),
                       .sehold_0_buf    (sehold_0_buf_b),
                       .sehold_1_buf    (sehold_1_buf_b),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_b),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_b),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_b),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_b),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_f),
                       .areset_l_1        (areset_l_1_buf_f),
                       .greset_l_0        (1'b0), // not used
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_f),
                       .scan_enable_1   (scan_enable_1_buf_f),
                       .sehold_0        (sehold_0_buf_f),
                       .sehold_1        (sehold_0_buf_f),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_f),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_f),
                       .mem_write_disable_0(mem_write_disable_1_buf_f),
                       .mem_write_disable_1(mem_write_disable_1_buf_f),
                       .sig0            (1'b0), // not used
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used

// A connects to B at one end and G at the other.
sctag_slow_rptr slow_rep_a      (
                       .areset_l_0_buf    (areset_l_0_buf_a),
                       .areset_l_1_buf    (areset_l_1_buf_a),
                       .greset_l_0_buf    (),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_a),
                       .scan_enable_1_buf(scan_enable_1_buf_a),
                       .sehold_0_buf    (sehold_0_buf_a),
                       .sehold_1_buf    (sehold_1_buf_a),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_a),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_a),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_a),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_a),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_b),
                       .areset_l_1        (areset_l_1_buf_b),
                       .greset_l_0        (1'b0), // not used
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_b),
                       .scan_enable_1   (scan_enable_1_buf_b),
                       .sehold_0        (sehold_1_buf_b),
                       .sehold_1        (sehold_1_buf_b),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_b),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_b),
                       .mem_write_disable_0(mem_write_disable_1_buf_b),
                       .mem_write_disable_1(mem_write_disable_1_buf_b),
                       .sig0            (1'b0), // not used
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used


// G connects to A at one end and I at the other.
// notice that G connects to grst_l
sctag_slow_rptr slow_rep_g      (
                       .areset_l_0_buf    (areset_l_0_buf_g),
                       .areset_l_1_buf    (areset_l_1_buf_g),
                       .greset_l_0_buf    (greset_l_0_buf_g),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_g),
                       .scan_enable_1_buf(scan_enable_1_buf_g),
                       .sehold_0_buf    (sehold_0_buf_g),
                       .sehold_1_buf    (sehold_1_buf_g),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_g),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_g),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_g),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_g),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_a),
                       .areset_l_1        (areset_l_1_buf_a),
                       .greset_l_0        (cluster_grst_l_buf_g), // not used
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_a),
                       .scan_enable_1   (scan_enable_1_buf_a),
                       .sehold_0        (sehold_1_buf_a),
                       .sehold_1        (sehold_1_buf_a),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_a),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_a),
                       .mem_write_disable_0(mem_write_disable_1_buf_a),
                       .mem_write_disable_1(mem_write_disable_1_buf_a),
                       .sig0            (1'b0), // not used
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used


// H connects to F at one end and M at the other.
sctag_slow_rptr slow_rep_h      (
                       .areset_l_0_buf    (areset_l_0_buf_h),
                       .areset_l_1_buf    (areset_l_1_buf_h),
                       .greset_l_0_buf    (greset_l_0_buf_h),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_h),
                       .scan_enable_1_buf(scan_enable_1_buf_h),
                       .sehold_0_buf    (sehold_0_buf_h),
                       .sehold_1_buf    (sehold_1_buf_h),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_h),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_h),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_h),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_h),
                       .sig0_buf        (scannet_86_d1),
                       .sig1_buf        (scannet_86_d2),
                       .sig2_buf        (scannet_86_d3),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_f),
                       .areset_l_1        (areset_l_1_buf_f),
                       .greset_l_0        (cluster_grst_l_buf_h), 
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_f),
                       .scan_enable_1   (scan_enable_1_buf_f),
                       .sehold_0        (sehold_1_buf_f),
                       .sehold_1        (sehold_1_buf_f),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_f),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_f),
                       .mem_write_disable_0(mem_write_disable_1_buf_f),
                       .mem_write_disable_1(mem_write_disable_1_buf_f),
                       .sig0            (scannet_86), 
                       .sig1            (scannet_86_d1),
                       .sig2            (scannet_86_d2), 
                       .sig3            (1'b0)); // not used


//**
// I connects to G at one end and J at the other.
sctag_slow_rptr slow_rep_i      (
                       .areset_l_0_buf    (areset_l_0_buf_i),
                       .areset_l_1_buf    (areset_l_1_buf_i),
                       .greset_l_0_buf    (greset_l_0_buf_i),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_i),
                       .scan_enable_1_buf(scan_enable_1_buf_i),
                       .sehold_0_buf    (sehold_0_buf_i),
                       .sehold_1_buf    (sehold_1_buf_i),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_i),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_i),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_i),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_i),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_g),
                       .areset_l_1        (areset_l_1_buf_g),
                       .greset_l_0        (cluster_grst_l_buf_i), 
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_g),
                       .scan_enable_1   (scan_enable_1_buf_g),
                       .sehold_0        (sehold_1_buf_g),
                       .sehold_1        (sehold_1_buf_g),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_g),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_g),
                       .mem_write_disable_0(mem_write_disable_1_buf_g),
                       .mem_write_disable_1(mem_write_disable_1_buf_g),
                       .sig0            (1'b0), // not used
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used



// J connects to I at one end and K at the other.
sctag_slow_rptr slow_rep_j      (
                       .areset_l_0_buf    (areset_l_0_buf_j),
                       .areset_l_1_buf    (areset_l_1_buf_j),
                       .greset_l_0_buf    (greset_l_0_buf_j),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_j),
                       .scan_enable_1_buf(scan_enable_1_buf_j),
                       .sehold_0_buf    (sehold_0_buf_j),
                       .sehold_1_buf    (sehold_1_buf_j),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_j),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_j),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_j),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_j),
                       .sig0_buf        (),
                       .sig1_buf        (),
                    	.sig2_buf(tagctl_nonmem_comp_c6_rep1),
                    	.sig3_buf(tagctl_rdma_wr_comp_c4_rep1),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_i),
                       .areset_l_1        (areset_l_1_buf_i),
                       .greset_l_0        (cluster_grst_l_buf_j), 
                       .greset_l_1        (1'b0), // input greset to cluster
                       .scan_enable_0   (scan_enable_1_buf_i),
                       .scan_enable_1   (scan_enable_1_buf_i),
                       .sehold_0        (sehold_1_buf_i),
                       .sehold_1        (sehold_1_buf_i),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_i),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_i),
                       .mem_write_disable_0(mem_write_disable_1_buf_i),
                       .mem_write_disable_1(mem_write_disable_1_buf_i),
                       	.sig0            (1'b0),
                       	.sig1            (1'b0),
                    	.sig2(tagctl_nonmem_comp_c6),
                    	.sig3(tagctl_rdma_wr_comp_c4));


// K connects to J at one end and L at the other.
sctag_slow_rptr slow_rep_k      (
                       .areset_l_0_buf    (areset_l_0_buf_k),
                       .areset_l_1_buf    (areset_l_1_buf_k),
                       .greset_l_0_buf    (greset_l_0_buf_k),
                       .greset_l_1_buf    (adbginit_l_rep1),
                       .scan_enable_0_buf(scan_enable_0_buf_k),
                       .scan_enable_1_buf(scan_enable_1_buf_k),
                       .sehold_0_buf    (sehold_0_buf_k),
                       .sehold_1_buf    (sehold_1_buf_k),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_k),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_k),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_k),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_k),
                       .sig0_buf        (scannet_109_buf),
                       .sig1_buf        (wb_read_wl_3_rep1),
                       .sig2_buf        (wb_read_wl_7_rep1),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_j),
                       .areset_l_1        (areset_l_1_buf_j),
                       .greset_l_0        (cluster_grst_l_buf_k), 
                       .greset_l_1        (adbginit_l),
                       .scan_enable_0   (scan_enable_1_buf_j),
                       .scan_enable_1   (scan_enable_1_buf_j),
                       .sehold_0        (sehold_1_buf_j),
                       .sehold_1        (sehold_1_buf_j),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_j),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_j),
                       .mem_write_disable_0(mem_write_disable_1_buf_j),
                       .mem_write_disable_1(mem_write_disable_1_buf_j),
                       .sig0            (scannet_109),
                       .sig1            (wb_read_wl[3]), // not used
                       .sig2            (wb_read_wl[7]), // not used
                       .sig3            (1'b0)); // not used

// L connects to K at one end and M at the other.
sctag_slow_rptr slow_rep_l      (
                       .areset_l_0_buf    (areset_l_0_buf_l),
                       .areset_l_1_buf    (areset_l_1_buf_l),
                       .greset_l_0_buf    (greset_l_0_buf_l),
                       .greset_l_1_buf    (scannet_92_a_rep1),
                       .scan_enable_0_buf(scan_enable_0_buf_l),
                       .scan_enable_1_buf(scan_enable_1_buf_l),
                       .sehold_0_buf    (sehold_0_buf_l),
                       .sehold_1_buf    (sehold_1_buf_l),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_l),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_l),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_l),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_l),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_k),
                       .areset_l_1        (areset_l_1_buf_k),
                       .greset_l_0        (cluster_grst_l_buf_l),
                       .greset_l_1        (scannet_92_a),
                       .scan_enable_0   (scan_enable_1_buf_k),
                       .scan_enable_1   (scan_enable_1_buf_k),
                       .sehold_0        (sehold_1_buf_k),
                       .sehold_1        (sehold_1_buf_k),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_k),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_k),
                       .mem_write_disable_0(mem_write_disable_1_buf_k),
                       .mem_write_disable_1(mem_write_disable_1_buf_k),
                       .sig0            (1'b0), // not used
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used



// M connects to L at one end and M at the other.
sctag_slow_rptr slow_rep_m      (
                       .areset_l_0_buf    (areset_l_0_buf_m),
                       .areset_l_1_buf    (areset_l_1_buf_m),
                       .greset_l_0_buf    (cluster_grst_l_buf_g),
                       .greset_l_1_buf    (cluster_grst_l_buf_i),
                       .scan_enable_0_buf(scan_enable_0_buf_m),
                       .scan_enable_1_buf(scan_enable_1_buf_m),
                       .sehold_0_buf    (sehold_0_buf_m),
                       .sehold_1_buf    (sehold_1_buf_m),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_m),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_m),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_m),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_m),
                       .sig0_buf        (cluster_grst_l_buf_h),
                       .sig1_buf        (cluster_grst_l_buf_j),
                       .sig2_buf        (cluster_grst_l_buf_l),
                       .sig3_buf        (cluster_grst_l_buf_k),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_l),
                       .areset_l_1        (areset_l_1_buf_l),
                       .greset_l_0        (cluster_grst_l),
                       .greset_l_1        (cluster_grst_l), 
                       .scan_enable_0   (scan_enable_1_buf_l),
                       .scan_enable_1   (scan_enable_1_buf_l),
                       .sehold_0        (sehold_1_buf_l),
                       .sehold_1        (sehold_1_buf_l),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_l),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_l),
                       .mem_write_disable_0(mem_write_disable_1_buf_l),
                       .mem_write_disable_1(mem_write_disable_1_buf_l),
                       .sig0            (cluster_grst_l), 
                       .sig1            (cluster_grst_l), 
                       .sig2            (cluster_grst_l), 
                       .sig3            (cluster_grst_l)); 

// N connects to M at one end and nothing at the other.
sctag_slow_rptr slow_rep_n      (
                       .areset_l_0_buf    (areset_l_0_buf_n),
                       .areset_l_1_buf    (areset_l_1_buf_n),
                       .greset_l_0_buf    (),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(scan_enable_0_buf_n),
                       .scan_enable_1_buf(scan_enable_1_buf_n),
                       .sehold_0_buf    (sehold_0_buf_n),
                       .sehold_1_buf    (sehold_1_buf_n),
                       .mux_drive_disable_0_buf(mux_drive_disable_0_buf_n),
                       .mux_drive_disable_1_buf(mux_drive_disable_1_buf_n),
                       .mem_write_disable_0_buf(mem_write_disable_0_buf_n),
                       .mem_write_disable_1_buf(mem_write_disable_1_buf_n),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (areset_l_1_buf_m),
                       .areset_l_1        (areset_l_1_buf_m),
                       .greset_l_0        (1'b0),
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (scan_enable_1_buf_m),
                       .scan_enable_1   (scan_enable_1_buf_m),
                       .sehold_0        (sehold_1_buf_m),
                       .sehold_1        (sehold_1_buf_m),
                       .mux_drive_disable_0(mux_drive_disable_1_buf_m),
                       .mux_drive_disable_1(mux_drive_disable_1_buf_m),
                       .mem_write_disable_0(mem_write_disable_1_buf_m),
                       .mem_write_disable_1(mem_write_disable_1_buf_m),
                       .sig0            (1'b0), // not used
                       .sig1            (1'b0), // not used
                       .sig2            (1'b0), // not used
                       .sig3            (1'b0)); // not used






























bw_clk_cl_sctag_cmp 	header(.cluster_grst_l(cluster_grst_l),
   			.gclk(cmp_gclk), 
			.se(scan_enable_0_buf_l), 
			.si(scannet_92), 
                        .so              (scannet_92_a),
                       	.rclk             (rclk),
                             .dbginit_l (dbginit_l),
                             // Inputs
                             .cluster_cken(cluster_cken),
                             .arst_l    (areset_l_1_buf_l),
                             .grst_l    (grst_l),
                             .adbginit_l(adbginit_l_rep1),
                             .gdbginit_l(gdbginit_l)); 


sctag_sig_rptr	 sig_rptr_1 ( 
.fast_sig_buf({unused,fbctl_fbtag_rd_ptr_5_rep1, mb_read_wl_buf[15:0],mb_data_write_wl_buf[15:0],mbdata_wr_en_c8_buf,mbctl_buf_rd_en_buf,evict_vld_c2_buf1,evict_vld_c2_buf2,evict_vld_c2_buf3,sctag_efc_fuse_data}),
.fast_sig({1'b0, fbctl_fbtag_rd_ptr[5], mb_read_wl[15:0],mb_data_write_wl[15:10],mb_data_write_wl_9_rep1,mb_data_write_wl[8:2],mb_data_write_wl_1_rep1,mb_data_write_wl[0],mbdata_wr_en_c8,mbctl_buf_rd_en,arbctl_evict_vld_c2,arbctl_evict_vld_c2,arbctl_evict_vld_c2,sctag_fuse_data}));



			

/*	sctag_stdatarep AUTO_TEMPLATE (
				.rep_store_data_c2(),
				.sctag_scdata_stdecc_c2(arbdp_store_data_c2_buf[77:0]),
				.arbdp_store_data_c2(arbdp_store_data_c2[77:0]));
*/

sctag_stdatarep	 	stdatarep1(/*AUTOINST*/
                             // Outputs
                             .rep_store_data_c2(),               // Templated
                             .sctag_scdata_stdecc_c2(arbdp_store_data_c2_buf[77:0]), // Templated
                             // Inputs
                             .arbdp_store_data_c2(arbdp_store_data_c2[77:0])); // Templated

/*	sctag_stdatarep AUTO_TEMPLATE (
				.rep_store_data_c2(rep_store_data_c2[77:0]),
				.sctag_scdata_stdecc_c2(sctag_scdata_stdecc_c2[77:0]),
				.arbdp_store_data_c2(arbdp_store_data_c2_buf[77:0]));
*/


sctag_stdatarep	 	stdatarep2(/*AUTOINST*/
                             // Outputs
                             .rep_store_data_c2(rep_store_data_c2[77:0]), // Templated
                             .sctag_scdata_stdecc_c2(sctag_scdata_stdecc_c2[77:0]), // Templated
                             // Inputs
                             .arbdp_store_data_c2(arbdp_store_data_c2_buf[77:0])); // Templated

sctag_tagctlrep		tagctlrep(/*AUTOINST*/
                            // Outputs
                            .sctag_scdata_set_c2(sctag_scdata_set_c2[9:0]),
                            .sctag_scdata_way_sel_c2(sctag_scdata_way_sel_c2[11:0]),
                            .sctag_scdata_col_offset_c2(sctag_scdata_col_offset_c2[3:0]),
                            .sctag_scdata_rd_wr_c2(sctag_scdata_rd_wr_c2),
                            .sctag_scdata_word_en_c2(sctag_scdata_word_en_c2[15:0]),
                            .sctag_scdata_fbrd_c3(sctag_scdata_fbrd_c3),
                            .sctag_scdata_fb_hit_c3(sctag_scdata_fb_hit_c3),
                            // Inputs
                            .scdata_set_c2(scdata_set_c2[9:0]),
                            .scdata_way_sel_c2(scdata_way_sel_c2[11:0]),
                            .scdata_col_offset_c2(scdata_col_offset_c2[3:0]),
                            .scdata_rd_wr_c2(scdata_rd_wr_c2),
                            .scdata_word_en_c2(scdata_word_en_c2[15:0]),
                            .scdata_fbrd_c3(scdata_fbrd_c3),
                            .scdata_fb_hit_c3(scdata_fb_hit_c3));


/*	sctag_vuaddp_ctl AUTO_TEMPLATE (
                        .bist_vuad_wr_en(bist_vuad_write),
                        .bist_vuad_idx_c3(bist_vuad_index[9:0]),
	 		.l2_bypass_mode_on(csr_vuad_l2off),
			.bist_wr_vd_c3(bist_vuad_vd));
*/
			
/*	sctag_vuad_dpm AUTO_TEMPLATE (
			.bist_vuad_data_in(bist_vuad_wr_data[7:0]));
*/

sctag_vuaddp_ctl	vuaddp_ctl(.so             (scannet_92),
                        .si             (scannet_91),
                        .se             (scan_enable_0_buf_l),
                             .parity_c4 ({parity_c4[3:2],1'b0,parity_c4[0]}),
                             .sehold    (sehold_0_buf_l),
			/*AUTOINST*/
                             // Outputs
                             .vuad_sel_c2(vuad_sel_c2),
                             .vuad_sel_c2_d1(vuad_sel_c2_d1),
                             .vuad_sel_c2orc3(vuad_sel_c2orc3),
                             .vuad_sel_c4(vuad_sel_c4),
                             .vuad_sel_rd(vuad_sel_rd),
                             .vuad_tagdp_sel_c2_d1(vuad_tagdp_sel_c2_d1),
                             .st_to_data_array_c3(st_to_data_array_c3),
                             .wr64_inst_c3(wr64_inst_c3),
                             .vuad_evict_c3(vuad_evict_c3),
                             .alloc_set_cond_c3(alloc_set_cond_c3),
                             .alloc_rst_cond_c3(alloc_rst_cond_c3),
                             .vuad_error_c8(vuad_error_c8),
                             .hit_wayvld_c3(hit_wayvld_c3[11:0]),
                             .fill_way_c3(fill_way_c3[11:0]),
                             .lru_way_c3(lru_way_c3[11:0]),
                             .bistordiag_wr_vd_c4(bistordiag_wr_vd_c4),
                             .bistordiag_wr_ua_c4(bistordiag_wr_ua_c4),
                             .sel_ua_wr_data_byp(sel_ua_wr_data_byp),
                             .sel_vd_wr_data_byp(sel_vd_wr_data_byp),
                             .sel_diag0_data_wr_c3(sel_diag0_data_wr_c3),
                             .sel_diag1_data_wr_c3(sel_diag1_data_wr_c3),
                             .vuad_array_wr_en0_c4(vuad_array_wr_en0_c4),
                             .vuad_array_wr_en1_c4(vuad_array_wr_en1_c4),
                             .vuad_idx_c4(vuad_idx_c4[9:0]),
                             // Inputs
                             .rclk      (rclk),
                             .bist_vuad_idx_c3(bist_vuad_index[9:0]), // Templated
                             .vuad_idx_c3(vuad_idx_c3[9:0]),
                             .bist_wr_vd_c3(bist_vuad_vd),       // Templated
                             .tagctl_hit_way_vld_c3(tagctl_hit_way_vld_c3[11:0]),
                             .lru_way_sel_c3(lru_way_sel_c3[11:0]),
                             .tagctl_st_to_data_array_c3(tagctl_st_to_data_array_c3),
                             .decdp_wr64_inst_c2(decdp_wr64_inst_c2),
                             .evict_c3  (evict_c3),
                             .arbctl_acc_vd_c2(arbctl_acc_vd_c2),
                             .arbctl_acc_ua_c2(arbctl_acc_ua_c2),
                             .idx_c1c2comp_c1(idx_c1c2comp_c1),
                             .idx_c1c3comp_c1(idx_c1c3comp_c1),
                             .idx_c1c4comp_c1(idx_c1c4comp_c1),
                             .idx_c1c5comp_c1(idx_c1c5comp_c1),
                             .decdp_inst_int_c1(decdp_inst_int_c1),
                             .l2_bypass_mode_on(csr_vuad_l2off), // Templated
                             .arbctl_inst_diag_c1(arbctl_inst_diag_c1),
                             .bist_vuad_wr_en(bist_vuad_write),  // Templated
                             .arbctl_inst_vld_c2(arbctl_inst_vld_c2),
                             .arbctl_inst_l2vuad_vld_c3(arbctl_inst_l2vuad_vld_c3),
                             .decdp_st_inst_c3(decdp_st_inst_c3),
                             .arbdp_inst_fb_c2(arbdp_inst_fb_c2),
                             .arbdp_inst_way_c2(arbdp_inst_way_c2[3:0]),
                             .arbdp_vuadctl_pst_no_ctrue_c2(arbdp_vuadctl_pst_no_ctrue_c2),
                             .decdp_cas1_inst_c2(decdp_cas1_inst_c2),
                             .arbdp_pst_with_ctrue_c2(arbdp_pst_with_ctrue_c2),
                             .decdp_cas2_inst_c2(decdp_cas2_inst_c2),
                             .arbdp_inst_mb_c2(arbdp_inst_mb_c2),
                             .vuadctl_no_bypass_px2(vuadctl_no_bypass_px2));

sctag_vuad_dpm		vuad_dpm(	.so             (scannet_90),
                        .si             (scannet_89),
                        .se             (scan_enable_0_buf_l),
                           .parity_c4   (parity_c4[3:0]),
			/*AUTOINST*/
                           // Outputs
                           .bistordiag_ua_data(bistordiag_ua_data[25:0]),
                           .bistordiag_vd_data(bistordiag_vd_data[25:0]),
                           .vuad_dp_diag_data_c7(vuad_dp_diag_data_c7[25:0]),
                           .vuad_syndrome_c9(vuad_syndrome_c9[3:0]),
                           // Inputs
                           .rclk        (rclk),
                           .diag_rd_ua_out(diag_rd_ua_out[25:0]),
                           .diag_rd_vd_out(diag_rd_vd_out[25:0]),
                           .arbctl_acc_ua_c2(arbctl_acc_ua_c2),
                           .valid_rd_parity_c2(valid_rd_parity_c2),
                           .dirty_rd_parity_c2(dirty_rd_parity_c2),
                           .used_rd_parity_c2(used_rd_parity_c2),
                           .alloc_rd_parity_c2(alloc_rd_parity_c2),
                           .arbdata_wr_data_c2(arbdata_wr_data_c2[25:0]),
                           .bist_vuad_data_in(bist_vuad_wr_data[7:0]), // Templated
                           .sel_diag1_data_wr_c3(sel_diag1_data_wr_c3),
                           .sel_diag0_data_wr_c3(sel_diag0_data_wr_c3));

sctag_vd_dp		vd_dp(	.so             (scannet_91),
                        .si             (scannet_90),
                        .se             (scan_enable_0_buf_l),
		/*AUTOINST*/
                    // Outputs
                    .vuad_array_wr_data_c4(vuad_array_wr_data_c4[25:0]),
                    .dirty_evict_c3     (dirty_evict_c3),
                    .vuad_dp_valid_c2   (vuad_dp_valid_c2[11:0]),
                    .valid_rd_parity_c2 (valid_rd_parity_c2),
                    .dirty_rd_parity_c2 (dirty_rd_parity_c2),
                    .diag_rd_vd_out     (diag_rd_vd_out[25:0]),
                    // Inputs
                    .rclk               (rclk),
                    .lru_way_c3         (lru_way_c3[11:0]),
                    .fill_way_c3        (fill_way_c3[11:0]),
                    .hit_wayvld_c3      (hit_wayvld_c3[11:0]),
                    .bistordiag_vd_data (bistordiag_vd_data[25:0]),
                    .vuad_evict_c3      (vuad_evict_c3),
                    .wr64_inst_c3       (wr64_inst_c3),
                    .st_to_data_array_c3(st_to_data_array_c3),
                    .vuad_sel_c2        (vuad_sel_c2),
                    .vuad_sel_c2orc3    (vuad_sel_c2orc3),
                    .vuad_sel_c4        (vuad_sel_c4),
                    .vuad_sel_rd        (vuad_sel_rd),
                    .vuad_sel_c2_d1     (vuad_sel_c2_d1),
                    .bistordiag_wr_vd_c4(bistordiag_wr_vd_c4),
                    .sel_vd_wr_data_byp (sel_vd_wr_data_byp),
                    .vuad_array_rd_data_c1(vuad_array_rd_data_c1[25:0]));

sctag_ua_dp		ua_dp(	.so             (scannet_89),
                        .si             (scannet_88),
                        .se             (scan_enable_0_buf_l),
		/*AUTOINST*/
                    // Outputs
                    .vuad_array_wr_data_c4(vuad_array_wr_data_c4[51:26]),
                    .vuad_dp_used_c2    (vuad_dp_used_c2[11:0]),
                    .vuad_dp_alloc_c2   (vuad_dp_alloc_c2[11:0]),
                    .used_rd_parity_c2  (used_rd_parity_c2),
                    .alloc_rd_parity_c2 (alloc_rd_parity_c2),
                    .diag_rd_ua_out     (diag_rd_ua_out[25:0]),
                    // Inputs
                    .rclk               (rclk),
                    .lru_way_sel_c3     (lru_way_sel_c3[11:0]),
                    .fill_way_c3        (fill_way_c3[11:0]),
                    .hit_wayvld_c3      (hit_wayvld_c3[11:0]),
                    .bistordiag_ua_data (bistordiag_ua_data[25:0]),
                    .vuad_evict_c3      (vuad_evict_c3),
                    .wr64_inst_c3       (wr64_inst_c3),
                    .vuad_sel_c2        (vuad_sel_c2),
                    .vuad_sel_c2orc3    (vuad_sel_c2orc3),
                    .vuad_sel_c4        (vuad_sel_c4),
                    .vuad_sel_rd        (vuad_sel_rd),
                    .vuad_sel_c2_d1     (vuad_sel_c2_d1),
                    .bistordiag_wr_ua_c4(bistordiag_wr_ua_c4),
                    .sel_ua_wr_data_byp (sel_ua_wr_data_byp),
                    .alloc_set_cond_c3  (alloc_set_cond_c3),
                    .alloc_rst_cond_c3  (alloc_rst_cond_c3),
                    .fbctl_vuad_bypassed_c3(fbctl_vuad_bypassed_c3),
                    .vuad_array_rd_data_c1(vuad_array_rd_data_c1[51:26]));


////////////////////////////
// tag array template
///////////////////////////

/*	bw_r_l2t AUTO_TEMPLATE		(
              // Outputs
              .fuse_scanout   (),
              .way_sel         	(tag_way_sel_c2[11:0]),
              .way_sel_1         (tagdp_way_sel_c2[11:0]),
              // Inputs
              .index        	(arbdp_tag_idx_px2_buf[9:0]),
              .rd_en       	(arbctl_tag_rd_px2_buf),
              .way       	(arbctl_tag_way_px2_buf[11:0]),
              .wr_en        	(arbctl_tag_wr_px2_buf),
              .wrdata0       	(tag_wrdata_px2_buf[27:0]),
              .wrdata1       	(tag_wrdata_px2_buf[27:0]),
              .lkup_tag_d1      (lkup_tag_c1[`TAG_WIDTH-1:1]),
              .rclk             (rclk),
              .bist_index       (mbist_l2t_index_buf[9:0]),   
              .bist_wr_en       (mbist_l2t_write_buf),     
              .bist_way         (mbist_l2t_dec_way_buf[11:0]), 
              .bist_rd_en       (mbist_l2t_read_buf),        
	      .bist_wrdata0	(mbist_write_data_buf[7:0]),
	      .bist_wrdata1	(mbist_write_data_buf[7:0]),
              .tag_way0         (tag_way0_tag_c2[27:0]),
              .tag_way1         (tag_way1_tag_c2[27:0]),
              .tag_way2         (tag_way2_tag_c2[27:0]),
              .tag_way3         (tag_way3_tag_c2[27:0]),
              .tag_way4         (tag_way4_tag_c2[27:0]),
              .tag_way5         (tag_way5_tag_c2[27:0]),
              .tag_way6         (tag_way6_tag_c2[27:0]),
              .tag_way7         (tag_way7_tag_c2[27:0]),
              .tag_way8         (tag_way8_tag_c2[27:0]),
              .tag_way9         (tag_way9_tag_c2[27:0]),
              .tag_way10        (tag_way10_tag_c2[27:0]),
              .tag_way11        (tag_way11_tag_c2[27:0]));
*/



	bw_r_l2t        tag(
                      .so               (scannet_86_a),
                      .si               (scannet_86_d3),
                      .se               (scan_enable_0_buf_h),
                      .rst_tri_en       (mem_write_disable_0_buf_h),
                      .arst_l           (areset_l_0_buf_h),
                      .sehold           (sehold_0_buf_h),
			/*AUTOINST*/
                      // Outputs
                      .l2t_fuse_repair_value(l2t_fuse_repair_value[6:0]),
                      .l2t_fuse_repair_en(l2t_fuse_repair_en[1:0]),
                      .way_sel          (tag_way_sel_c2[11:0]),  // Templated
                      .way_sel_1        (tagdp_way_sel_c2[11:0]), // Templated
                      .tag_way0         (tag_way0_tag_c2[27:0]), // Templated
                      .tag_way1         (tag_way1_tag_c2[27:0]), // Templated
                      .tag_way2         (tag_way2_tag_c2[27:0]), // Templated
                      .tag_way3         (tag_way3_tag_c2[27:0]), // Templated
                      .tag_way4         (tag_way4_tag_c2[27:0]), // Templated
                      .tag_way5         (tag_way5_tag_c2[27:0]), // Templated
                      .tag_way6         (tag_way6_tag_c2[27:0]), // Templated
                      .tag_way7         (tag_way7_tag_c2[27:0]), // Templated
                      .tag_way8         (tag_way8_tag_c2[27:0]), // Templated
                      .tag_way9         (tag_way9_tag_c2[27:0]), // Templated
                      .tag_way10        (tag_way10_tag_c2[27:0]), // Templated
                      .tag_way11        (tag_way11_tag_c2[27:0]), // Templated
                      // Inputs
                      .index            (arbdp_tag_idx_px2_buf[9:0]), // Templated
                      .bist_index       (mbist_l2t_index_buf[9:0]), // Templated
                      .rd_en            (arbctl_tag_rd_px2_buf), // Templated
                      .bist_rd_en       (mbist_l2t_read_buf),    // Templated
                      .way              (arbctl_tag_way_px2_buf[11:0]), // Templated
                      .bist_way         (mbist_l2t_dec_way_buf[11:0]), // Templated
                      .wr_en            (arbctl_tag_wr_px2_buf), // Templated
                      .bist_wr_en       (mbist_l2t_write_buf),   // Templated
                      .wrdata0          (tag_wrdata_px2_buf[27:0]), // Templated
                      .bist_wrdata0     (mbist_write_data_buf[7:0]), // Templated
                      .wrdata1          (tag_wrdata_px2_buf[27:0]), // Templated
                      .bist_wrdata1     (mbist_write_data_buf[7:0]), // Templated
                      .lkup_tag_d1      (lkup_tag_c1[`TAG_WIDTH-1:1]), // Templated
                      .rclk             (rclk),                  // Templated
                      .fuse_l2t_wren    (fuse_l2t_wren),
                      .fuse_l2t_rid     (fuse_l2t_rid[5:0]),
                      .fuse_l2t_repair_value(fuse_l2t_repair_value[6:0]),
                      .fuse_l2t_repair_en(fuse_l2t_repair_en[1:0]),
                      .efc_sctag_fuse_clk1(efc_sctag_fuse_clk1));


////////////////////////////
// tag dp template
///////////////////////////

/* 	sctag_tagl_dp	AUTO_TEMPLATE(
                  .so                   (),
                  .si                   (),
                  .se                   (se),
                  .parity_c2      (tag_parity_c2[5:0]),
                  .tag_triad0_c3   (tag_triad0_c3[`TAG_WIDTH-1:0]),
                  .tag_triad1_c3   (tag_triad1_c3[`TAG_WIDTH-1:0]),
                  .way0_tag_c2    (tag_way0_tag_c2[`TAG_WIDTH-1:0]),
                  .way1_tag_c2    (tag_way1_tag_c2[`TAG_WIDTH-1:0]),
                  .way2_tag_c2    (tag_way2_tag_c2[`TAG_WIDTH-1:0]),
                  .way3_tag_c2    (tag_way3_tag_c2[`TAG_WIDTH-1:0]),
                  .way4_tag_c2    (tag_way4_tag_c2[`TAG_WIDTH-1:0]),
                  .way5_tag_c2    (tag_way5_tag_c2[`TAG_WIDTH-1:0]),
                  .triad0_muxsel_c3(triad0_muxsel_c3[2:0]),
                  .triad1_muxsel_c3(triad1_muxsel_c3[2:0]));
*/

sctag_tagl_dp tagl_dp_1(
                  .so                   (scannet_85),
                  .si                   (scannet_84),
                  .se                   (scan_enable_0_buf_h),
			/*AUTOINST*/
                        // Outputs
                        .parity_c2      (tag_parity_c2[5:0]),    // Templated
                        .tag_triad0_c3  (tag_triad0_c3[`TAG_WIDTH-1:0]), // Templated
                        .tag_triad1_c3  (tag_triad1_c3[`TAG_WIDTH-1:0]), // Templated
                        // Inputs
                        .way0_tag_c2    (tag_way0_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way1_tag_c2    (tag_way1_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way2_tag_c2    (tag_way2_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way3_tag_c2    (tag_way3_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way4_tag_c2    (tag_way4_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way5_tag_c2    (tag_way5_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .rclk           (rclk),
                        .triad0_muxsel_c3(triad0_muxsel_c3[2:0]), // Templated
                        .triad1_muxsel_c3(triad1_muxsel_c3[2:0])); // Templated

/* 	sctag_tagl_dp	AUTO_TEMPLATE(
                  .so                   (),
                  .si                   (),
                  .se                   (se),
                  .parity_c2      (tag_parity_c2[11:6]),
                  .tag_triad0_c3   (tag_triad2_c3[`TAG_WIDTH-1:0]),
                  .tag_triad1_c3   (tag_triad3_c3[`TAG_WIDTH-1:0]),
                  .way0_tag_c2    (tag_way6_tag_c2[`TAG_WIDTH-1:0]),
                  .way1_tag_c2    (tag_way7_tag_c2[`TAG_WIDTH-1:0]),
                  .way2_tag_c2    (tag_way8_tag_c2[`TAG_WIDTH-1:0]),
                  .way3_tag_c2    (tag_way9_tag_c2[`TAG_WIDTH-1:0]),
                  .way4_tag_c2    (tag_way10_tag_c2[`TAG_WIDTH-1:0]),
                  .way5_tag_c2    (tag_way11_tag_c2[`TAG_WIDTH-1:0]),
                  .triad0_muxsel_c3(triad2_muxsel_c3[2:0]),
                  .triad1_muxsel_c3(triad3_muxsel_c3[2:0]));
*/

sctag_tagl_dp tagl_dp_2(
                  .so                   (scannet_87),
                  .si                   (scannet_86_a),
                  .se                   (scan_enable_0_buf_h),
			/*AUTOINST*/
                        // Outputs
                        .parity_c2      (tag_parity_c2[11:6]),   // Templated
                        .tag_triad0_c3  (tag_triad2_c3[`TAG_WIDTH-1:0]), // Templated
                        .tag_triad1_c3  (tag_triad3_c3[`TAG_WIDTH-1:0]), // Templated
                        // Inputs
                        .way0_tag_c2    (tag_way6_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way1_tag_c2    (tag_way7_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way2_tag_c2    (tag_way8_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way3_tag_c2    (tag_way9_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way4_tag_c2    (tag_way10_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .way5_tag_c2    (tag_way11_tag_c2[`TAG_WIDTH-1:0]), // Templated
                        .rclk           (rclk),
                        .triad0_muxsel_c3(triad2_muxsel_c3[2:0]), // Templated
                        .triad1_muxsel_c3(triad3_muxsel_c3[2:0])); // Templated


/*	sctag_tagdp_ctl	AUTO_TEMPLATE	 (
                .tag_way_sel_c2(tagdp_way_sel_c2[11:0]),
              	.bist_wr_enable_px        (mbist_l2t_write),
              	.bist_way_px              (mbist_l2t_way[3:0]),
                     .dbginit_l         (tagdp_ctl_dbginit_l),
                          .l2_dir_map_on(tagdp_l2_dir_map_on),
              	.bist_enable_px           (mbist_l2t_read));
*/

sctag_tagdp_ctl	tagdp_ctl(
                          .so           (scannet_84),
                          .si           (scannet_83),
                          .se           (scan_enable_0_buf_h),
                          .grst_l       (greset_l_0_buf_h),
                          .arst_l       (areset_l_0_buf_h),
                          .rst_tri_en   (mux_drive_disable_0_buf_h),
			  .vuad_dp_diag_data_c7_buf(vuad_dp_diag_data_c7_buf[25:0]),
                          .arbctl_evict_vld_c2(evict_vld_c2_buf1),
				/*AUTOINST*/
                          // Outputs
                          .triad0_muxsel_c3(triad0_muxsel_c3[2:0]),
                          .triad1_muxsel_c3(triad1_muxsel_c3[2:0]),
                          .triad2_muxsel_c3(triad2_muxsel_c3[2:0]),
                          .triad3_muxsel_c3(triad3_muxsel_c3[2:0]),
                          .tag_quad_muxsel_c3(tag_quad_muxsel_c3[3:0]),
                          .bist_vuad_wr_data(bist_vuad_wr_data[7:0]),
                          .bist_vuad_index(bist_vuad_index[9:0]),
                          .bist_vuad_vd (bist_vuad_vd),
                          .bist_vuad_write(bist_vuad_write),
                          .tagdp_mbctl_par_err_c3(tagdp_mbctl_par_err_c3),
                          .tagdp_tagctl_par_err_c3(tagdp_tagctl_par_err_c3),
                          .tagdp_arbctl_par_err_c3(tagdp_arbctl_par_err_c3),
                          .tag_error_c8 (tag_error_c8),
                          .lru_way_sel_c3(lru_way_sel_c3[11:0]),
                          .evict_c3     (evict_c3),
                          .invalid_evict_c3(invalid_evict_c3),
                          // Inputs
                          .vuad_dp_valid_c2(vuad_dp_valid_c2[11:0]),
                          .tag_parity_c2(tag_parity_c2[11:0]),
                          .tag_way_sel_c2(tagdp_way_sel_c2[11:0]), // Templated
                          .vuad_tagdp_sel_c2_d1(vuad_tagdp_sel_c2_d1),
                          .bist_way_px  (mbist_l2t_way[3:0]),    // Templated
                          .bist_enable_px(mbist_l2t_read),       // Templated
                          .arbdp_diag_wr_way_c2(arbdp_diag_wr_way_c2[3:0]),
                          .arbctl_tecc_way_c2(arbctl_tecc_way_c2[3:0]),
                          .arbctl_normal_tagacc_c2(arbctl_normal_tagacc_c2),
                          .arbctl_tagdp_tecc_c2(arbctl_tagdp_tecc_c2),
                          .arbctl_tagdp_perr_vld_c2(arbctl_tagdp_perr_vld_c2),
                          .mbctl_hit_c3 (mbctl_hit_c3),
                          .l2_dir_map_on(tagdp_l2_dir_map_on),   // Templated
                          .arbctl_l2tag_vld_c4(arbctl_l2tag_vld_c4),
                          .mbist_write_data(mbist_write_data[7:0]),
                          .mbist_l2v_index(mbist_l2v_index[9:0]),
                          .mbist_l2v_vd (mbist_l2v_vd),
                          .mbist_l2v_write(mbist_l2v_write),
                          .vuad_dp_diag_data_c7(vuad_dp_diag_data_c7[25:0]),
                          .rclk         (rclk),
                          .dbginit_l    (tagdp_ctl_dbginit_l),   // Templated
                          .vuad_dp_used_c2(vuad_dp_used_c2[11:0]),
                          .vuad_dp_alloc_c2(vuad_dp_alloc_c2[11:0]));


		
sctag_tagdp	tagdp(

                  .mbdata_inst_tecc_c8  (mbdata_inst_tecc_c8[5:0]),
                  .so                   (scannet_86),
                  .si                   (scannet_85),
                  .se                   (scan_enable_0_buf_h),
                  .tagdp_lkup_addr_c4   (tagdp_lkup_addr_c4[39:10]),
                  .sehold               (sehold_0_buf_h),
                  
                  /*AUTOINST*/
                  // Outputs
                  .tagdp_evict_tag_c4   (tagdp_evict_tag_c4[`TAG_WIDTH-1:0]),
                  .tagdp_diag_data_c7   (tagdp_diag_data_c7[`TAG_WIDTH-1:0]),
                  .lkup_row_addr_dcd_c3 (lkup_row_addr_dcd_c3[2:0]),
                  .lkup_row_addr_icd_c3 (lkup_row_addr_icd_c3[2:0]),
                  .tagdp_lkup_addr11_c4 (tagdp_lkup_addr11_c4),
                  .lkup_tag_c1          (lkup_tag_c1[`TAG_WIDTH-1:1]),
                  .arbdp_tag_idx_px2_buf(arbdp_tag_idx_px2_buf[9:0]),
                  .mbist_l2t_index_buf  (mbist_l2t_index_buf[9:0]),
                  .arbctl_tag_way_px2_buf(arbctl_tag_way_px2_buf[11:0]),
                  .mbist_l2t_dec_way_buf(mbist_l2t_dec_way_buf[11:0]),
                  .arbctl_tag_rd_px2_buf(arbctl_tag_rd_px2_buf),
                  .mbist_l2t_read_buf   (mbist_l2t_read_buf),
                  .arbctl_tag_wr_px2_buf(arbctl_tag_wr_px2_buf),
                  .mbist_l2t_write_buf  (mbist_l2t_write_buf),
                  .tag_wrdata_px2_buf   (tag_wrdata_px2_buf[27:0]),
                  .mbist_write_data_buf (mbist_write_data_buf[7:0]),
                  // Inputs
                  .dir_cam_addr_c3      (dir_cam_addr_c3[39:8]),
                  .arbaddr_idx_c3       (arbaddr_idx_c3[9:0]),
                  .arbdp_tagdata_px2    (arbdp_tagdata_px2[`TAG_WIDTH-1:6]),
                  .tag_triad0_c3        (tag_triad0_c3[`TAG_WIDTH-1:0]),
                  .tag_triad1_c3        (tag_triad1_c3[`TAG_WIDTH-1:0]),
                  .tag_triad2_c3        (tag_triad2_c3[`TAG_WIDTH-1:0]),
                  .tag_triad3_c3        (tag_triad3_c3[`TAG_WIDTH-1:0]),
                  .tag_quad_muxsel_c3   (tag_quad_muxsel_c3[3:0]),
                  .arbdp_tag_idx_px2    (arbdp_tag_idx_px2[9:0]),
                  .mbist_l2t_index      (mbist_l2t_index[9:0]),
                  .arbctl_tag_way_px2   (arbctl_tag_way_px2[11:0]),
                  .mbist_l2t_dec_way    (mbist_l2t_dec_way[11:0]),
                  .arbctl_tag_rd_px2    (arbctl_tag_rd_px2),
                  .mbist_l2t_read       (mbist_l2t_read),
                  .arbctl_tag_wr_px2    (arbctl_tag_wr_px2),
                  .mbist_l2t_write      (mbist_l2t_write),
                  .tag_wrdata_px2       (tag_wrdata_px2[27:0]),
                  .mbist_write_data     (mbist_write_data[7:0]),
                  .arbctl_evict_c3      (arbctl_evict_c3),
                  .rclk                 (rclk));


/* sctag_mbist	AUTO_TEMPLATE(
                  // Outputs
                  .mbist_l2data_read       (mbist_l2d_read),
                  .mbist_l2data_write      (mbist_l2d_write),
                  .mbist_l2data_index      (mbist_l2d_index[9:0]),
                  .mbist_l2data_way        (mbist_l2d_way[3:0]),
                  .mbist_l2data_word   (mbist_l2d_word_sel[3:0]),
                  .mbist_write_data (mbist_write_data[7:0]),
                  .mbist_l2tag_read       (mbist_l2t_read),
                  .mbist_l2tag_write      (mbist_l2t_write),
                  .mbist_l2tag_index      (mbist_l2t_index[9:0]),
                  .mbist_l2tag_way        (mbist_l2t_way[3:0]),
                  .mbist_l2tag_dec_way        (mbist_l2t_dec_way[11:0]),
                  .mbist_l2vuad_read       (mbist_l2v_read),
                  .mbist_l2vuad_write      (mbist_l2v_write),
                  .mbist_l2vuad_index      (mbist_l2v_index[9:0]),
                  .mbist_l2vuad_vd         (mbist_l2v_vd),
                  // Inputs
                  .mbist_l2data_data_in    (retdp_diag_data_c7[38:0]),
                  .mbist_l2tag_data_in    (tagdp_evict_tag_c4[27:0]));
		*/



// slow repeater ctu is used for all signals going to and from the 
// test stub to the ctu.
sctag_slow_rptr slow_rep_ctu      (
                       .areset_l_0_buf    (ctu_tst_pre_grst_l_buf1),
                       .areset_l_1_buf    (global_shift_enable_buf1),
                       .greset_l_0_buf    (ctu_tst_scan_disable_buf1),
                       .greset_l_1_buf    (ctu_tst_scanmode_buf1),
                       .scan_enable_0_buf(ctu_tst_macrotest_buf1),
                       .scan_enable_1_buf(ctu_tst_short_chain_buf1),
                       .sehold_0_buf    (ctu_sctag_mbisten_buf1),
                       .sehold_1_buf    (sctag_ctu_mbistdone),
                       .mux_drive_disable_0_buf(sctag_ctu_mbisterr),
                       .mux_drive_disable_1_buf(sctag_ctu_scanout),
                       .mem_write_disable_0_buf(),
                       .mem_write_disable_1_buf(ctu_sctag_scanin_buf1),
                       .sig0_buf        (),
                       .sig1_buf        (),
                       .sig2_buf        (),
                       .sig3_buf        (),
                       // Inputs
                       .areset_l_0        (ctu_tst_pre_grst_l),
                       .areset_l_1        (global_shift_enable),
                       .greset_l_0        (ctu_tst_scan_disable),
                       .greset_l_1        (ctu_tst_scanmode),
                       .scan_enable_0   (ctu_tst_macrotest),
                       .scan_enable_1   (ctu_tst_short_chain),
                       .sehold_0        (ctu_sctag_mbisten),
                       .sehold_1        (sctag_ctu_mbistdone_prev),
                       .mux_drive_disable_0(sctag_ctu_mbisterr_prev),
                       .mux_drive_disable_1(sctag_ctu_scanout_prev),
                       .mem_write_disable_0(1'b0),
                       .mem_write_disable_1(ctu_sctag_scanin),
                       .sig0            (1'b0),
                       .sig1            (1'b0),
                       .sig2            (1'b0),
                       .sig3            (1'b0));



/*
	mux_drive_disable -> rst_tri en for ctl/dp muxes
	mem_write_disable -> wen_disable for SRAMs
	sehold -> 
	testmode_l-> not used in cmp.
	mem_bypass -> Used if a bypass path is provided

*/


	

/* test_stub_bist AUTO_TEMPLATE(
                         .mem_bypass    (),
                         .so_1          (),
                         .so_2          (),
                         .short_chain_so_0(),
                         .long_chain_so_1(),
                         .short_chain_so_1(),
                         .long_chain_so_2(),
                         .short_chain_so_2(),
                         .mbist_data_mode(mbist_userdata_mode),
                         .bist_ctl_reg_in(csr_bist_wr_data_c8[6:0]),
                         .bist_ctl_reg_wr_en(csr_bist_wr_en_c8));
*/

test_stub_bist	test_stub(
                         .ctu_tst_scanmode(ctu_tst_scanmode_buf1),
                         .ctu_tst_macrotest(ctu_tst_macrotest_buf1),
                         .ctu_tst_short_chain(ctu_tst_short_chain_buf1),
                         .ctu_tst_mbist_enable(ctu_sctag_mbisten_buf1),
                         .tst_ctu_mbist_done(sctag_ctu_mbistdone_prev),
                         .tst_ctu_mbist_fail(sctag_ctu_mbisterr_prev),
                         .so_0      (sctag_ctu_scanout_prev),
                         .ctu_tst_pre_grst_l(ctu_tst_pre_grst_l_buf1),
                         .global_shift_enable(global_shift_enable_buf1),
                         .ctu_tst_scan_disable(ctu_tst_scan_disable_buf1),
                         .mux_drive_disable(mux_drive_disable),
                         .mem_write_disable(mem_write_disable),
                         .sehold        (sehold),
                         .se            (se),
                         .arst_l        (areset_l_0_buf_h),
                         .cluster_grst_l(greset_l_0_buf_h),
                         .mbist_err     ({mbist_l2vuad_fail,mbist_l2tag_fail,mbist_l2data_fail}),
                         .bist_ctl_reg_out(csr_bist_read_data[10:0]),
                         .testmode_l(testmode_l),
                         .long_chain_so_0(scannet_110),
                         .so        (scannet_110),
                         .si        (scannet_109_buf),
                          .mbist_loop_on_addr(mbist_loop_on_address),
				/*AUTOINST*/
                          // Outputs
                          .mem_bypass   (),                      // Templated
                          .so_1         (),                      // Templated
                          .so_2         (),                      // Templated
                          .mbist_bisi_mode(mbist_bisi_mode),
                          .mbist_stop_on_next_fail(mbist_stop_on_next_fail),
                          .mbist_stop_on_fail(mbist_stop_on_fail),
                          .mbist_loop_mode(mbist_loop_mode),
                          .mbist_data_mode(mbist_userdata_mode), // Templated
                          .mbist_start  (mbist_start),
                          // Inputs
                          .short_chain_so_0(1'b0),                   // Templated
                          .long_chain_so_1(1'b0),                    // Templated
                          .short_chain_so_1(1'b0),                   // Templated
                          .long_chain_so_2(1'b0),                    // Templated
                          .short_chain_so_2(1'b0),                   // Templated
                          .rclk         (rclk),
                          .bist_ctl_reg_in(csr_bist_wr_data_c8[6:0]), // Templated
                          .bist_ctl_reg_wr_en(csr_bist_wr_en_c8), // Templated
                          .mbist_done   (mbist_done));            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated            // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)           // Templated)

 sctag_mbist	mbist	(
								   // by the test stub
//                  .so                   (scannet_54),
//                  .si                   (scannet_55),
                  .so                   (scannet_55),
                  .si                   (scannet_54),
                  .se                   (scan_enable_0_buf_g),
                     .arst_l            (areset_l_0_buf_g	),
                     .grst_l            (greset_l_0_buf_g),

                  .mbist_l2vuad_data_in    (vuad_dp_diag_data_c7[25:0]),
                     .mbist_l2data_fail (mbist_l2data_fail),
                     .mbist_l2tag_fail  (mbist_l2tag_fail),
                     .mbist_l2vuad_fail (mbist_l2vuad_fail),
			/*AUTOINST*/
                     // Outputs
                     .mbist_l2data_write(mbist_l2d_write),       // Templated
                     .mbist_l2tag_read  (mbist_l2t_read),        // Templated
                     .mbist_l2tag_write (mbist_l2t_write),       // Templated
                     .mbist_arbctl_l2t_write(mbist_arbctl_l2t_write),
                     .mbist_l2vuad_read (mbist_l2v_read),        // Templated
                     .mbist_l2vuad_write(mbist_l2v_write),       // Templated
                     .mbist_l2data_index(mbist_l2d_index[9:0]),  // Templated
                     .mbist_l2data_way  (mbist_l2d_way[3:0]),    // Templated
                     .mbist_l2data_word (mbist_l2d_word_sel[3:0]), // Templated
                     .mbist_l2tag_index (mbist_l2t_index[9:0]),  // Templated
                     .mbist_l2tag_way   (mbist_l2t_way[3:0]),    // Templated
                     .mbist_l2tag_dec_way(mbist_l2t_dec_way[11:0]), // Templated
                     .mbist_l2vuad_index(mbist_l2v_index[9:0]),  // Templated
                     .mbist_l2vuad_vd   (mbist_l2v_vd),          // Templated
                     .mbist_write_data  (mbist_write_data[7:0]), // Templated
                     .mbist_done        (mbist_done),
                     .mbist_arb_l2d_en  (mbist_arb_l2d_en),
                     .mbist_arb_l2d_write(mbist_arb_l2d_write),
                     .mbist_l2d_en      (mbist_l2d_en),
                     // Inputs
                     .rclk              (rclk),
                     .mbist_start       (mbist_start),
                     .mbist_userdata_mode(mbist_userdata_mode),
                     .mbist_bisi_mode   (mbist_bisi_mode),
                     .mbist_loop_mode   (mbist_loop_mode),
                     .mbist_loop_on_address(mbist_loop_on_address),
                     .mbist_stop_on_fail(mbist_stop_on_fail),
                     .mbist_stop_on_next_fail(mbist_stop_on_next_fail),
                     .mbist_l2data_data_in(retdp_diag_data_c7[38:0]), // Templated
                     .mbist_l2tag_data_in(tagdp_evict_tag_c4[27:0])); // Templated


/* sctag_tagctl	AUTO_TEMPLATE (
                      .bist_data_enc_way_sel_c1(mbist_l2d_way[3:0]),
                      .bist_data_enable_c1(mbist_l2d_en),
                      .bist_data_wr_enable_c1(mbist_l2d_write),
                      .bist_data_waddr_c1(mbist_l2d_word_sel[3:0]),
                     .dbginit_l         (tagctl_dbginit_l),
                      .decc_scrd_uncorr_err_c8(fbctl_decc_scrd_uncorr_err_c8),
	 	.l2_bypass_mode_on(csr_tagctl_l2off)) ;  

*/

sctag_tagctl	tagctl (
                      .si               (scannet_79),
                      .se               (scan_enable_0_buf_l),
                      .so               (scannet_80),
			.grst_l		(greset_l_0_buf_l),
			.arst_l		(areset_l_0_buf_l),
                          .arbctl_evict_vld_c2(evict_vld_c2_buf2),
			/*AUTOINST*/
                      // Outputs
                      .tagctl_hit_way_vld_c3(tagctl_hit_way_vld_c3[11:0]),
                      .tagctl_st_to_data_array_c3(tagctl_st_to_data_array_c3),
                      .tagctl_hit_l2orfb_c3(tagctl_hit_l2orfb_c3),
                      .tagctl_miss_unqual_c2(tagctl_miss_unqual_c2),
                      .tagctl_hit_unqual_c2(tagctl_hit_unqual_c2),
                      .tagctl_hit_c3    (tagctl_hit_c3),
                      .tagctl_lru_way_c4(tagctl_lru_way_c4[3:0]),
                      .tagctl_rdma_vld_px0_p(tagctl_rdma_vld_px0_p),
                      .tagctl_hit_not_comp_c3(tagctl_hit_not_comp_c3),
                      .alt_tagctl_miss_unqual_c3(alt_tagctl_miss_unqual_c3),
                      .mbctl_rdma_reg_vld_c2(mbctl_rdma_reg_vld_c2),
                      .scbuf_fbwr_wen_r2(scbuf_fbwr_wen_r2[15:0]),
                      .scbuf_fbd_stdatasel_c3(scbuf_fbd_stdatasel_c3),
                      .scdata_way_sel_c2(scdata_way_sel_c2[11:0]),
                      .scdata_col_offset_c2(scdata_col_offset_c2[3:0]),
                      .scdata_rd_wr_c2  (scdata_rd_wr_c2),
                      .scdata_word_en_c2(scdata_word_en_c2[15:0]),
                      .tagctl_decc_addr3_c7(tagctl_decc_addr3_c7),
                      .decc_tag_acc_en_px2(decc_tag_acc_en_px2),
                      .data_ecc_active_c3(data_ecc_active_c3),
                      .tagctl_decc_data_sel_c8(tagctl_decc_data_sel_c8),
                      .tagctl_scrub_rd_vld_c7(tagctl_scrub_rd_vld_c7),
                      .tagctl_spc_rd_vld_c7(tagctl_spc_rd_vld_c7),
                      .tagctl_bsc_rd_vld_c7(tagctl_bsc_rd_vld_c7),
                      .scrub_addr_way   (scrub_addr_way[3:0]),
                      .tagctl_imiss_hit_c5(tagctl_imiss_hit_c5),
                      .tagctl_ld_hit_c5 (tagctl_ld_hit_c5),
                      .tagctl_strst_ack_c5(tagctl_strst_ack_c5),
                      .tagctl_st_ack_c5 (tagctl_st_ack_c5),
                      .tagctl_st_req_c5 (tagctl_st_req_c5),
                      .tagctl_nonmem_comp_c6(tagctl_nonmem_comp_c6),
                      .tagctl_uerr_ack_c5(tagctl_uerr_ack_c5),
                      .tagctl_cerr_ack_c5(tagctl_cerr_ack_c5),
                      .tagctl_int_ack_c5(tagctl_int_ack_c5),
                      .tagctl_fwd_req_ret_c5(tagctl_fwd_req_ret_c5),
                      .sel_rdma_inval_vec_c5(sel_rdma_inval_vec_c5),
                      .tagctl_rdma_wr_comp_c4(tagctl_rdma_wr_comp_c4),
                      .tagctl_rmo_st_ack_c5(tagctl_rmo_st_ack_c5),
                      .tagctl_inst_mb_c5(tagctl_inst_mb_c5),
                      .tagctl_hit_c5    (tagctl_hit_c5),
                      .tagctl_store_inst_c5(tagctl_store_inst_c5),
                      .tagctl_fwd_req_ld_c6(tagctl_fwd_req_ld_c6),
                      .tagctl_rdma_gate_off_c2(tagctl_rdma_gate_off_c2),
                      .tagctl_rd64_complete_c11(tagctl_rd64_complete_c11),
                      .uerr_ack_tmp_c4  (uerr_ack_tmp_c4),
                      .cerr_ack_tmp_c4  (cerr_ack_tmp_c4),
                      .spc_rd_cond_c3   (spc_rd_cond_c3),
                      .tagctl_rdma_vld_px1(tagctl_rdma_vld_px1),
                      .tagctl_rdma_ev_en_c4(tagctl_rdma_ev_en_c4),
                      .tagctl_inc_rdma_cnt_c4(tagctl_inc_rdma_cnt_c4),
                      .tagctl_set_rdma_reg_vld_c4(tagctl_set_rdma_reg_vld_c4),
                      .tagctl_jbi_req_en_c6(tagctl_jbi_req_en_c6),
                      .tagctl_mbctl_par_err_c3(tagctl_mbctl_par_err_c3),
                      // Inputs
                      .tag_way_sel_c2   (tag_way_sel_c2[11:0]),
                      .vuad_dp_valid_c2 (vuad_dp_valid_c2[11:0]),
                      .lru_way_sel_c3   (lru_way_sel_c3[11:0]),
                      .tagdp_tagctl_par_err_c3(tagdp_tagctl_par_err_c3),
                      .bist_data_enc_way_sel_c1(mbist_l2d_way[3:0]), // Templated
                      .bist_data_enable_c1(mbist_l2d_en),        // Templated
                      .bist_data_wr_enable_c1(mbist_l2d_write),  // Templated
                      .bist_data_waddr_c1(mbist_l2d_word_sel[3:0]), // Templated
                      .arbdp_addr5to4_c1(arbdp_addr5to4_c1[1:0]),
                      .arbdp_addr3to2_c1(arbdp_addr3to2_c1[1:0]),
                      .arbaddr_addr22_c2(arbaddr_addr22_c2),
                      .arbdp_diag_wr_way_c2(arbdp_diag_wr_way_c2[3:0]),
                      .arbdp_inst_way_c3(arbdp_inst_way_c3[3:0]),
                      .decdp_tagctl_wr_c1(decdp_tagctl_wr_c1),
                      .decdp_cas2_from_mb_ctrue_c2(decdp_cas2_from_mb_ctrue_c2),
                      .decdp_cas2_from_mb_c2(decdp_cas2_from_mb_c2),
                      .decdp_strst_inst_c2(decdp_strst_inst_c2),
                      .arbdp_dword_st_c2(arbdp_dword_st_c2),
                      .decdp_rmo_st_c3  (decdp_rmo_st_c3),
                      .arbdp_rdma_inst_c1(arbdp_rdma_inst_c1),
                      .decdp_ld64_inst_c1(decdp_ld64_inst_c1),
                      .decdp_wr64_inst_c2(decdp_wr64_inst_c2),
                      .decdp_wr8_inst_c2(decdp_wr8_inst_c2),
                      .arbctl_tagctl_pst_with_ctrue_c1(arbctl_tagctl_pst_with_ctrue_c1),
                      .l2_bypass_mode_on(csr_tagctl_l2off),      // Templated
                      .bist_or_diag_acc_c1(bist_or_diag_acc_c1),
                      .arbctl_fill_vld_c2(arbctl_fill_vld_c2),
                      .arbctl_imiss_vld_c2(arbctl_imiss_vld_c2),
                      .arbctl_tagctl_inst_vld_c2(arbctl_tagctl_inst_vld_c2),
                      .arbctl_waysel_gate_c2(arbctl_waysel_gate_c2),
                      .arbctl_data_diag_st_c2(arbctl_data_diag_st_c2),
                      .arbctl_csr_wr_en_c3(arbctl_csr_wr_en_c3),
                      .arbctl_csr_rd_en_c3(arbctl_csr_rd_en_c3),
                      .arbctl_diag_complete_c3(arbctl_diag_complete_c3),
                      .decc_scrd_uncorr_err_c8(fbctl_decc_scrd_uncorr_err_c8), // Templated
                      .mbctl_tagctl_hit_unqual_c2(mbctl_tagctl_hit_unqual_c2),
                      .mbctl_uncorr_err_c2(mbctl_uncorr_err_c2),
                      .mbctl_corr_err_c2(mbctl_corr_err_c2),
                      .mbctl_wr64_miss_comp_c3(mbctl_wr64_miss_comp_c3),
                      .decdp_swap_inst_c2(decdp_swap_inst_c2),
                      .arbdp_tagctl_pst_no_ctrue_c2(arbdp_tagctl_pst_no_ctrue_c2),
                      .decdp_cas1_inst_c2(decdp_cas1_inst_c2),
                      .decdp_ld_inst_c2 (decdp_ld_inst_c2),
                      .arbdp_inst_mb_c2 (arbdp_inst_mb_c2),
                      .arbdp_inst_dep_c2(arbdp_inst_dep_c2),
                      .decdp_st_inst_c2 (decdp_st_inst_c2),
                      .decdp_st_with_ctrue_c2(decdp_st_with_ctrue_c2),
                      .decdp_inst_int_c2(decdp_inst_int_c2),
                      .decdp_fwd_req_c2 (decdp_fwd_req_c2),
                      .arbctl_inst_diag_c2(arbctl_inst_diag_c2),
                      .arbctl_inval_inst_c2(arbctl_inval_inst_c2),
                      .arbctl_waysel_inst_vld_c2(arbctl_waysel_inst_vld_c2),
                      .arbctl_coloff_inst_vld_c2(arbctl_coloff_inst_vld_c2),
                      .arbctl_rdwr_inst_vld_c2(arbctl_rdwr_inst_vld_c2),
                      .wr8_inst_no_ctrue_c1(wr8_inst_no_ctrue_c1),
                      .fbctl_tagctl_hit_c2(fbctl_tagctl_hit_c2),
                      .dram_sctag_chunk_id_r1(dram_sctag_chunk_id_r1[1:0]),
                      .dram_sctag_data_vld_r1(dram_sctag_data_vld_r1),
                      .fbctl_dis_cerr_c3(fbctl_dis_cerr_c3),
                      .fbctl_dis_uerr_c3(fbctl_dis_uerr_c3),
                      .oqctl_st_complete_c7(oqctl_st_complete_c7),
                      .arbdp_tecc_c1    (arbdp_tecc_c1),
                      .dbginit_l        (tagctl_dbginit_l),      // Templated
                      .rclk             (rclk),
                      .error_nceen      (error_nceen),
                      .error_ceen       (error_ceen),
                      .tagdp_mbctl_par_err_c3(tagdp_mbctl_par_err_c3));



/*sctag_mbctl        AUTO_TEMPLATE(
                   .decc_spcd_corr_err_c8(mbctl_decc_spcd_corr_err_c8),
                   .decc_spcfb_corr_err_c8(mbctl_decc_spcfb_corr_err_c8),
                     .dbginit_l         (mbctl_dbginit_l),
                          .l2_dir_map_on(mbctl_l2_dir_map_on),
	 	.l2_bypass_mode_on(csr_mbctl_l2off)) ;  */


sctag_mbctl	mbctl (
                   .mb_write_wl         (mb_write_wl[15:0]),
                   .mbctl_dep_c8        (mbctl_dep_c8),
                   .mbctl_evict_c8      (mbctl_evict_c8),
                   .mbctl_mbentry_c8    (mbctl_mbentry_c8[3:0]),
                   .mbctl_tecc_c8       (mbctl_tecc_c8),
                   .mbtag_wr_en_c2      (mbtag_wr_en_c2),
                   .mb_read_wl          (mb_read_wl[15:0]),
                   .mb_data_write_wl    (mb_data_write_wl[15:0]),
                   .mbdata_wr_en_c8     (mbdata_wr_en_c8),
                   .mb_cam_match        (mb_cam_match[15:0]),
                   .mb_cam_match_idx        (mb_cam_match_idx[15:0]),
                   .mbctl_buf_rd_en     (mbctl_buf_rd_en),
                   .so                  (scannet_79),
                   .si                  (scannet_78),
                   .se                  (scan_enable_0_buf_k),
                   .rst_tri_en          (mux_drive_disable_0_buf_k),     
			.grst_l		(greset_l_0_buf_k),
			.arst_l		(areset_l_0_buf_k),
                          .arbctl_evict_vld_c2(evict_vld_c2_buf3),
			/*AUTOINST*/
                   // Outputs
                   .mbctl_arbctl_cnt12_px2_prev(mbctl_arbctl_cnt12_px2_prev),
                   .mbctl_arbctl_snp_cnt8_px1(mbctl_arbctl_snp_cnt8_px1),
                   .mbctl_arbctl_vld_px1(mbctl_arbctl_vld_px1),
                   .mbctl_nondep_fbhit_c3(mbctl_nondep_fbhit_c3),
                   .mbctl_hit_c3        (mbctl_hit_c3),
                   .mbctl_arbctl_hit_c3 (mbctl_arbctl_hit_c3),
                   .mbctl_arbdp_ctrue_px2(mbctl_arbdp_ctrue_px2),
                   .mbctl_arb_l2rd_en   (mbctl_arb_l2rd_en),
                   .mbctl_arb_dramrd_en (mbctl_arb_dramrd_en),
                   .mbctl_tagctl_hit_unqual_c2(mbctl_tagctl_hit_unqual_c2),
                   .mbctl_corr_err_c2   (mbctl_corr_err_c2),
                   .mbctl_uncorr_err_c2 (mbctl_uncorr_err_c2),
                   .mbctl_wr64_miss_comp_c3(mbctl_wr64_miss_comp_c3),
                   .mbctl_wbctl_mbid_c4 (mbctl_wbctl_mbid_c4[3:0]),
                   .mbf_insert_mbid_c4  (mbf_insert_mbid_c4[3:0]),
                   .mbf_insert_c4       (mbf_insert_c4),
                   .mbctl_hit_c4        (mbctl_hit_c4),
                   .mbf_delete_c4       (mbf_delete_c4),
                   .mbctl_fbctl_next_vld_c4(mbctl_fbctl_next_vld_c4),
                   .mbctl_fbctl_next_link_c4(mbctl_fbctl_next_link_c4[3:0]),
                   .mbctl_fbctl_dram_pick(mbctl_fbctl_dram_pick),
                   .mbctl_fbctl_fbid    (mbctl_fbctl_fbid[2:0]),
                   .mbctl_fbctl_way     (mbctl_fbctl_way[3:0]),
                   .mbctl_fbctl_way_fbid_vld(mbctl_fbctl_way_fbid_vld),
                   .sctag_dram_rd_req   (sctag_dram_rd_req),
                   .sctag_dram_rd_dummy_req(sctag_dram_rd_dummy_req),
                   // Inputs
                   .tagctl_miss_unqual_c2(tagctl_miss_unqual_c2),
                   .tagctl_hit_unqual_c2(tagctl_hit_unqual_c2),
                   .tagctl_hit_c3       (tagctl_hit_c3),
                   .tagctl_lru_way_c4   (tagctl_lru_way_c4[3:0]),
                   .tagctl_rdma_vld_px0_p(tagctl_rdma_vld_px0_p),
                   .mbctl_rdma_reg_vld_c2(mbctl_rdma_reg_vld_c2),
                   .tagctl_hit_not_comp_c3(tagctl_hit_not_comp_c3),
                   .alt_tagctl_miss_unqual_c3(alt_tagctl_miss_unqual_c3),
                   .arbdp_pst_with_ctrue_c2(arbdp_pst_with_ctrue_c2),
                   .arbdp_mbctl_pst_no_ctrue_c2(arbdp_mbctl_pst_no_ctrue_c2),
                   .decdp_cas2_inst_c2  (decdp_cas2_inst_c2),
                   .arbdp_inst_mb_c2    (arbdp_inst_mb_c2),
                   .decdp_pst_inst_c2   (decdp_pst_inst_c2),
                   .decdp_cas1_inst_c2  (decdp_cas1_inst_c2),
                   .arbdp_inst_mb_entry_c1(arbdp_inst_mb_entry_c1[3:0]),
                   .arbdp_tecc_inst_mb_c8(arbdp_tecc_inst_mb_c8),
                   .arbdp_rdma_inst_c1  (arbdp_rdma_inst_c1),
                   .decdp_ld64_inst_c2  (decdp_ld64_inst_c2),
                   .decdp_wr64_inst_c2  (decdp_wr64_inst_c2),
                   .decdp_bis_inst_c3   (decdp_bis_inst_c3),
                   .arbctl_csr_st_c2    (arbctl_csr_st_c2),
                   .arbctl_mbctl_inst_vld_c2(arbctl_mbctl_inst_vld_c2),
                   .arbctl_pst_ctrue_en_c8(arbctl_pst_ctrue_en_c8),
                   .arbctl_mbctl_hit_off_c1(arbctl_mbctl_hit_off_c1),
                   .arbctl_evict_tecc_vld_c2(arbctl_evict_tecc_vld_c2),
                   .arbdp_inst_dep_c2   (arbdp_inst_dep_c2),
                   .arbdp_addr_c1c2comp_c1(arbdp_addr_c1c2comp_c1),
                   .arbdp_addr_c1c3comp_c1(arbdp_addr_c1c3comp_c1),
                   .idx_c1c2comp_c1     (idx_c1c2comp_c1),
                   .idx_c1c3comp_c1     (idx_c1c3comp_c1),
                   .arbctl_mbctl_cas1_hit_c8(arbctl_mbctl_cas1_hit_c8),
                   .arbctl_mbctl_ctrue_c9(arbctl_mbctl_ctrue_c9),
                   .arbctl_mbctl_mbsel_c1(arbctl_mbctl_mbsel_c1),
                   .decc_uncorr_err_c8  (decc_uncorr_err_c8),
                   .decc_spcd_corr_err_c8(mbctl_decc_spcd_corr_err_c8), // Templated
                   .decc_spcfb_corr_err_c8(mbctl_decc_spcfb_corr_err_c8), // Templated
                   .fbctl_mbctl_match_c2(fbctl_mbctl_match_c2),
                   .fbctl_mbctl_stinst_match_c2(fbctl_mbctl_stinst_match_c2),
                   .fbctl_mbctl_entry_avail(fbctl_mbctl_entry_avail),
                   .fbf_ready_miss_r1   (fbf_ready_miss_r1),
                   .fbf_enc_ld_mbid_r1  (fbf_enc_ld_mbid_r1[3:0]),
                   .fbf_st_or_dep_rdy_c4(fbf_st_or_dep_rdy_c4),
                   .fbf_enc_dep_mbid_c4 (fbf_enc_dep_mbid_c4[3:0]),
                   .fb_count_eq_0       (fb_count_eq_0),
                   .fbctl_mbctl_fbid_d2 (fbctl_mbctl_fbid_d2[2:0]),
                   .fbctl_mbctl_nofill_d2(fbctl_mbctl_nofill_d2),
                   .wbctl_hit_unqual_c2 (wbctl_hit_unqual_c2),
                   .wbctl_mbctl_dep_rdy_en(wbctl_mbctl_dep_rdy_en),
                   .wbctl_mbctl_dep_mbid(wbctl_mbctl_dep_mbid[3:0]),
                   .rdmatctl_hit_unqual_c2(rdmatctl_hit_unqual_c2),
                   .rdmatctl_mbctl_dep_mbid(rdmatctl_mbctl_dep_mbid[3:0]),
                   .rdmatctl_mbctl_dep_rdy_en(rdmatctl_mbctl_dep_rdy_en),
                   .tagctl_mbctl_par_err_c3(tagctl_mbctl_par_err_c3),
                   .dram_sctag_rd_ack   (dram_sctag_rd_ack),
                   .l2_bypass_mode_on   (csr_mbctl_l2off),       // Templated
                   .l2_dir_map_on       (mbctl_l2_dir_map_on),   // Templated
                   .rclk                (rclk),
                   .dbginit_l           (mbctl_dbginit_l),       // Templated
                   .arbctl_tecc_c2      (arbctl_tecc_c2),
                   .arbctl_mbctl_inval_inst_c2(arbctl_mbctl_inval_inst_c2));



/* bw_r_rf16x128d    AUTO_TEMPLATE(
              		   .dout        (mb_data_read_data[127:0]),
                           // Inputs
      .din         ({28'b0,mbdata_inst_tecc_c8[5:0],mbctl_evict_c8,mbctl_dep_c8,mbctl_tecc_c8,mbctl_mbentry_c8[3:0],arbdp_inst_c8[`L2_POISON:`L2_SZ_LO],mbdata_inst_data_c8[63:0]}),
                           .rclk         (rclk));
*/


sctag_min_rptr  min_rptr_1(
	.sig({2'b0,mb_data_read_data[`MBD_ECC_HI:`MBD_ECC_LO],mbctl_evict_c8,mbctl_dep_c8,mbctl_tecc_c8,mbctl_mbentry_c8[3:0],mbdata_wr_en_c8_buf}),
	.sig_buf({unused2,mbdata_ecc_minbuf[5:0],mbctl_evict_c8_minbuf,mbctl_dep_c8_minbuf,mbctl_tecc_c8_minbuf,mbctl_mbentry_c8_minbuf[3:0],mbdata_wr_en_c8_minbuf}));

bw_r_rf16x128d	mbdata(
                     .so                (scannet_62),
                     .si                (scannet_61) ,                   
                     .se                (scan_enable_0_buf_i)  ,                  
                           .reset_l     (areset_l_0_buf_i),
                       .rst_tri_en      (mem_write_disable_0_buf_i),
                           .sehold      (sehold_0_buf_i),
                           .rd_wl      (mb_read_wl_buf[15:0]),
                           .wr_wl      (mb_data_write_wl_buf[15:0]),
                           .read_en     (mbctl_buf_rd_en_buf),
                           .wr_en       (mbdata_wr_en_c8_minbuf),
		     /*AUTOINST*/
                       // Outputs
                       .dout            (mb_data_read_data[127:0]), // Templated
                       // Inputs
                       .din             ({28'b0,mbdata_inst_tecc_c8[5:0],mbctl_evict_c8_minbuf,mbctl_dep_c8_minbuf,mbctl_tecc_c8_minbuf,mbctl_mbentry_c8_minbuf[3:0],arbdp_inst_c8[`L2_POISON:`L2_SZ_LO],mbdata_inst_data_c8[63:0]}), // Templated
                       .rclk            (rclk));                  // Templated



bw_r_cm16x40       mbtag   ( .dout(mb_read_data[39:0]),
                .match(mb_cam_match[15:0]),
                .match_idx(mb_cam_match_idx[15:0]),
                .adr_w({mb_write_wl_15_rep1,mb_write_wl[14:13],mb_write_wl_12_rep1,mb_write_wl_11_rep1,mb_write_wl[10:8],mb_write_wl_7_rep1,mb_write_wl_6_rep1,mb_write_wl[5:0]}),
                .din(mb_write_addr[39:0]), // C3 PH1 write.
                .write_en(mbtag_wr_en_c2),
                .adr_r(mb_read_wl[15:0]),
                .lookup_en(arbctl_mb_camen_px2),
                .key(arbdp_cam_addr_px2[39:8]),
		.sehold(sehold_0_buf_j),
                .rclk(rclk),
                .rst_tri_en(mem_write_disable_0_buf_j),
                .read_en(mbctl_buf_rd_en_rep1),
                .se(scan_enable_0_buf_j),
                .si(scannet_77),
                .so(scannet_78), 
                .rst_l(areset_l_0_buf_j));

// 16 extra repeaters for making ECO fixes,
sctag_slow_rptr	slow_rep_extra	(
                       .areset_l_0_buf    (),
                       .areset_l_1_buf    (),
                       .greset_l_0_buf    (),
                       .greset_l_1_buf    (),
                       .scan_enable_0_buf(),
                       .scan_enable_1_buf(),
                       .sehold_0_buf    (),
                       .sehold_1_buf    (),
                       .mux_drive_disable_0_buf(mb_data_write_wl_9_rep1),
                       .mux_drive_disable_1_buf(mb_data_write_wl_1_rep1),
                       .mem_write_disable_0_buf(mbctl_buf_rd_en_rep1),
                       .mem_write_disable_1_buf(mb_write_wl_15_rep1),
                       .sig0_buf        (mb_write_wl_12_rep1),
                       .sig1_buf        (mb_write_wl_11_rep1),
                       .sig2_buf        (mb_write_wl_7_rep1),
                       .sig3_buf        (mb_write_wl_6_rep1),
                       // Inputs
                       .areset_l_0        (1'b0),
                       .areset_l_1        (1'b0),
                       .greset_l_0        (1'b0),
                       .greset_l_1        (1'b0), // not used
                       .scan_enable_0   (1'b0),
                       .scan_enable_1   (1'b0),
                       .sehold_0        (1'b0),
                       .sehold_1        (1'b0),
                       .mux_drive_disable_0(mb_data_write_wl[9]),
                       .mux_drive_disable_1(mb_data_write_wl[1]),
                       .mem_write_disable_0(mbctl_buf_rd_en),
                       .mem_write_disable_1(mb_write_wl[15]),
                       .sig0            (mb_write_wl[12]),
                       .sig1            (mb_write_wl[11]),
                       .sig2            (mb_write_wl[7]),
                       .sig3            (mb_write_wl[6])); // not used


			
/*sctag_fbctl        AUTO_TEMPLATE(
                  .arbdp_inst_mb_entry_c1(arbdp_inst_mb_entry_c1[2:0]),
                     .dbginit_l         (fbctl_dbginit_l),
                  .decc_scrd_corr_err_c8(fbctl_decc_scrd_corr_err_c8),
                  .decc_scrd_uncorr_err_c8(fbctl_decc_scrd_uncorr_err_c8),
                  .decc_bscd_corr_err_c8(fbctl_decc_bscd_corr_err_c8),
                  .decc_bscd_uncorr_err_c8(fbctl_decc_bscd_uncorr_err_c8),
                          .l2_dir_map_on(fbctl_l2_dir_map_on),
	 	.l2_bypass_mode_on(csr_fbctl_l2off)) ;  */


sctag_fbctl	fbctl(
                  .fbctl_fbtag_wr_ptr   (fbctl_fbtag_wr_ptr[7:0]),
                  .fbctl_fbtag_wr_en    (fbctl_fbtag_wr_en),
                  .fbctl_buf_rd_en      (fbctl_buf_rd_en),
                  .fbctl_fbtag_rd_ptr   (fbctl_fbtag_rd_ptr[7:0]),
                  .fb_cam_match         (fb_cam_match[7:0]),
                  .mbdata_fbctl_mbf_entry(mb_data_read_data[`MBD_ENTRY_HI:`MBD_ENTRY_LO]),
                  .mbdata_fbctl_rqtyp_d1(mb_data_read_data[`MBD_RQ_HI:`MBD_RQ_LO]),
                  .mbdata_fbctl_rsvd_d1(mb_data_read_data[`MBD_RSVD]),
                  .rst_tri_en           (mux_drive_disable_0_buf_k),     
                  .so                   (scannet_74),
                  .si                   (scannet_73),
                  .se                   (scan_enable_0_buf_k),
			.grst_l		(greset_l_0_buf_k),
			.arst_l		(areset_l_0_buf_k),
                  /*AUTOINST*/
                  // Outputs
                  .fbctl_tagctl_hit_c2  (fbctl_tagctl_hit_c2),
                  .fbctl_fbd_rd_en_c2   (fbctl_fbd_rd_en_c2),
                  .fbctl_fbd_rd_entry_c2(fbctl_fbd_rd_entry_c2[2:0]),
                  .dram_sctag_chunk_id_r1(dram_sctag_chunk_id_r1[1:0]),
                  .dram_sctag_data_vld_r1(dram_sctag_data_vld_r1),
                  .fbctl_fbd_wr_entry_r1(fbctl_fbd_wr_entry_r1[2:0]),
                  .sctag_dram_rd_req_id (sctag_dram_rd_req_id[2:0]),
                  .fb_count_eq_0        (fb_count_eq_0),
                  .fbctl_mbctl_entry_avail(fbctl_mbctl_entry_avail),
                  .fbctl_mbctl_match_c2 (fbctl_mbctl_match_c2),
                  .fbctl_mbctl_fbid_d2  (fbctl_mbctl_fbid_d2[2:0]),
                  .fbf_enc_ld_mbid_r1   (fbf_enc_ld_mbid_r1[3:0]),
                  .fbf_ready_miss_r1    (fbf_ready_miss_r1),
                  .fbf_enc_dep_mbid_c4  (fbf_enc_dep_mbid_c4[3:0]),
                  .fbf_st_or_dep_rdy_c4 (fbf_st_or_dep_rdy_c4),
                  .fbctl_mbctl_nofill_d2(fbctl_mbctl_nofill_d2),
                  .fbctl_mbctl_stinst_match_c2(fbctl_mbctl_stinst_match_c2),
                  .scdata_fb_hit_c3     (scdata_fb_hit_c3),
                  .fbctl_vuad_bypassed_c3(fbctl_vuad_bypassed_c3),
                  .fbctl_arb_l2rd_en    (fbctl_arb_l2rd_en),
                  .fbctl_arbdp_way_px2  (fbctl_arbdp_way_px2[3:0]),
                  .fbctl_arbdp_tecc_px2 (fbctl_arbdp_tecc_px2),
                  .fbctl_arbdp_entry_px2(fbctl_arbdp_entry_px2[2:0]),
                  .fbctl_arbctl_vld_px1 (fbctl_arbctl_vld_px1),
                  .fbctl_corr_err_c8    (fbctl_corr_err_c8),
                  .fbctl_uncorr_err_c8  (fbctl_uncorr_err_c8),
                  .dram_scb_mecc_err_d1 (dram_scb_mecc_err_d1),
                  .dram_scb_secc_err_d1 (dram_scb_secc_err_d1),
                  .fbctl_spc_corr_err_c7(fbctl_spc_corr_err_c7),
                  .fbctl_spc_uncorr_err_c7(fbctl_spc_uncorr_err_c7),
                  .fbctl_spc_rd_vld_c7  (fbctl_spc_rd_vld_c7),
                  .fbctl_bsc_corr_err_c12(fbctl_bsc_corr_err_c12),
                  .fbctl_ld64_fb_hit_c12(fbctl_ld64_fb_hit_c12),
                  .fbctl_dis_cerr_c3    (fbctl_dis_cerr_c3),
                  .fbctl_dis_uerr_c3    (fbctl_dis_uerr_c3),
                  // Inputs
                  .rdmard_cerr_c12      (rdmard_cerr_c12),
                  .rdmard_uerr_c12      (rdmard_uerr_c12),
                  .ev_cerr_r6           (ev_cerr_r6),
                  .ev_uerr_r6           (ev_uerr_r6),
                  .mbctl_fbctl_next_vld_c4(mbctl_fbctl_next_vld_c4),
                  .mbctl_fbctl_next_link_c4(mbctl_fbctl_next_link_c4[3:0]),
                  .mbf_delete_c4        (mbf_delete_c4),
                  .mbctl_hit_c4         (mbctl_hit_c4),
                  .mbf_insert_c4        (mbf_insert_c4),
                  .mbctl_fbctl_dram_pick(mbctl_fbctl_dram_pick),
                  .mbctl_fbctl_fbid     (mbctl_fbctl_fbid[2:0]),
                  .mbctl_fbctl_way      (mbctl_fbctl_way[3:0]),
                  .mbctl_fbctl_way_fbid_vld(mbctl_fbctl_way_fbid_vld),
                  .mbf_insert_mbid_c4   (mbf_insert_mbid_c4[3:0]),
                  .decdp_imiss_inst_c2  (decdp_imiss_inst_c2),
                  .arbdp_inst_mb_entry_c1(arbdp_inst_mb_entry_c1[2:0]), // Templated
                  .decdp_cas1_inst_c2   (decdp_cas1_inst_c2),
                  .arbdp_rdma_inst_c1   (arbdp_rdma_inst_c1),
                  .mbctl_rdma_reg_vld_c2(mbctl_rdma_reg_vld_c2),
                  .decc_scrd_uncorr_err_c8(fbctl_decc_scrd_uncorr_err_c8), // Templated
                  .decc_scrd_corr_err_c8(fbctl_decc_scrd_corr_err_c8), // Templated
                  .decc_bscd_corr_err_c8(fbctl_decc_bscd_corr_err_c8), // Templated
                  .decc_bscd_uncorr_err_c8(fbctl_decc_bscd_uncorr_err_c8), // Templated
                  .tag_error_c8         (tag_error_c8),
                  .tagctl_rd64_complete_c11(tagctl_rd64_complete_c11),
                  .cerr_ack_tmp_c4      (cerr_ack_tmp_c4),
                  .uerr_ack_tmp_c4      (uerr_ack_tmp_c4),
                  .spc_rd_cond_c3       (spc_rd_cond_c3),
                  .csr_fbctl_scrub_ready(csr_fbctl_scrub_ready),
                  .arbctl_fbctl_fbsel_c1(arbctl_fbctl_fbsel_c1),
                  .arbctl_fill_vld_c2   (arbctl_fill_vld_c2),
                  .arbctl_fbctl_hit_off_c1(arbctl_fbctl_hit_off_c1),
                  .arbctl_fbctl_inst_vld_c2(arbctl_fbctl_inst_vld_c2),
                  .decdp_wr8_inst_c2    (decdp_wr8_inst_c2),
                  .arbdp_inst_mb_c2     (arbdp_inst_mb_c2),
                  .decdp_ld64_inst_c2   (decdp_ld64_inst_c2),
                  .l2_bypass_mode_on    (csr_fbctl_l2off),       // Templated
                  .l2_dir_map_on        (fbctl_l2_dir_map_on),   // Templated
                  .dram_sctag_data_vld_r0(dram_sctag_data_vld_r0),
                  .dram_sctag_rd_req_id_r0(dram_sctag_rd_req_id_r0[2:0]),
                  .dram_sctag_chunk_id_r0(dram_sctag_chunk_id_r0[1:0]),
                  .dram_sctag_secc_err_r2(dram_sctag_secc_err_r2),
                  .dram_sctag_mecc_err_r2(dram_sctag_mecc_err_r2),
                  .dram_sctag_scb_mecc_err(dram_sctag_scb_mecc_err),
                  .dram_sctag_scb_secc_err(dram_sctag_scb_secc_err),
                  .tagctl_rdma_gate_off_c2(tagctl_rdma_gate_off_c2),
                  .dbginit_l            (fbctl_dbginit_l),       // Templated
                  .rclk                 (rclk));


bw_r_cm16x40b       fbtag   ( .dout(fb_read_data[39:0]),
                .match(fb_cam_match[15:0]),
                .match_idx(),
                .adr_w({8'b0, fbctl_fbtag_wr_ptr[7:0]}),
                .din({mb_read_data[39:6], mbdata_ecc_minbuf[5:0]}),
                .write_en(fbctl_fbtag_wr_en),
                .adr_r({8'b0,fbctl_fbtag_rd_ptr[7:6],fbctl_fbtag_rd_ptr_5_rep1,fbctl_fbtag_rd_ptr[4:0]}),
                .lookup_en(arbctl_inst_vld_c1),
                .key(lkup_addr_c1[39:8]),
                .rst_tri_en(mem_write_disable_0_buf_j),
                .rclk(rclk),
                .read_en(fbctl_buf_rd_en),
		.sehold(sehold_0_buf_j),
                .se(scan_enable_0_buf_j),
                .si(scannet_76),
                .so(scannet_77),
                .rst_l(areset_l_0_buf_j));

/*sctag_arbdatadp        AUTO_TEMPLATE(
	 	.bist_data_data_c1(mbist_write_data[7:0]),
                .bist_data_enable_c1(mbist_arb_l2d_write)) ;  */



sctag_arbdatadp	arbdatadp (
                           .mbdata_inst_data_c8(mbdata_inst_data_c8[63:0]),
                           .so          (scannet_58),
                           .si          (scannet_57),
                           .se          (scan_enable_0_buf_j),
                           .arbdata_wr_data_c2(arbdata_wr_data_c2[33:0]),
                           .csr_bist_wr_data_c8(csr_bist_wr_data_c8[6:0]),
			   /*AUTOINST*/
                           // Outputs
                           .arbdp_oqdp_int_ret_c7(arbdp_oqdp_int_ret_c7[17:0]),
                           .arbdp_store_data_c2(arbdp_store_data_c2[77:0]),
                           .csr_inst_wr_data_c8(csr_inst_wr_data_c8[63:0]),
                           .word_lower_cmp_c8(word_lower_cmp_c8),
                           .word_upper_cmp_c8(word_upper_cmp_c8),
                           // Inputs
                           .iq_arbdp_data_px2(iq_arbdp_data_px2[63:0]),
                           .snpq_arbdp_data_px2(snpq_arbdp_data_px2[63:0]),
                           .mb_data_read_data(mb_data_read_data[63:0]),
                           .mbctl_arb_l2rd_en(mbctl_arb_l2rd_en),
                           .mux2_snpsel_px2(mux2_snpsel_px2),
                           .mux3_bufsel_px2(mux3_bufsel_px2),
                           .mux4_c1sel_px2(mux4_c1sel_px2),
                           .arbctl_decc_data_sel_c9(arbctl_decc_data_sel_c9),
                           .bist_or_diag_acc_c1(bist_or_diag_acc_c1),
                           .arbdp_poison_c1(arbdp_poison_c1),
                           .bist_data_data_c1(mbist_write_data[7:0]), // Templated
                           .bist_data_enable_c1(mbist_arb_l2d_write), // Templated
                           .deccdp_arbdp_data_c8(deccdp_arbdp_data_c8[63:0]),
                           .dword_mask_c8(dword_mask_c8[7:0]),
                           .rclk        (rclk));

/*sctag_arbaddrdp        AUTO_TEMPLATE(
                        .sctag_scdata_set_c2(scdata_set_c2[9:0]),
                           .bist_vuad_idx_px1(mbist_l2v_index[9:0]),
	 		.bist_data_set_c1(mbist_l2d_index[9:0]),
                	.bist_data_enable_c1(mbist_arb_l2d_en)) ;
	*/

sctag_arbaddrdp	arbaddrdp (
                           .arbdp_cam_addr_px2(arbdp_cam_addr_px2[39:0]),
                           .so          (scannet_59),
                           .si          (scannet_58),
                           .se          (scan_enable_0_buf_j),
                           .arbdp_dbg_addr_c3(arbdp_dbg_addr_c3[5:2]),
                           .arbdata_wr_data_c2(arbdata_wr_data_c2[27:0]),
				/*AUTOINST*/
                           // Outputs
                           .tagdp_evict_tag_c4_buf(tagdp_evict_tag_c4_buf[`TAG_WIDTH-1:6]),
                           .arbdp_tag_idx_px2(arbdp_tag_idx_px2[9:0]),
                           .arbdp_vuad_idx1_px2(arbdp_vuad_idx1_px2[9:0]),
                           .arbdp_vuad_idx2_px2(arbdp_vuad_idx2_px2[9:0]),
                           .arbdp_tagdata_px2(arbdp_tagdata_px2[27:6]),
                           .arbdp_new_addr5to4_px2(arbdp_new_addr5to4_px2[1:0]),
                           .arbdp_addr_c1c2comp_c1(arbdp_addr_c1c2comp_c1),
                           .arbdp_addr_c1c3comp_c1(arbdp_addr_c1c3comp_c1),
                           .idx_c1c2comp_c1(idx_c1c2comp_c1),
                           .idx_c1c3comp_c1(idx_c1c3comp_c1),
                           .idx_c1c4comp_c1(idx_c1c4comp_c1),
                           .idx_c1c5comp_c1(idx_c1c5comp_c1),
                           .arbdp_word_addr_c1(arbdp_word_addr_c1[1:0]),
                           .arbdp_ioaddr_c1(arbdp_ioaddr_c1[39:32]),
                           .arbdp_addr5to4_c1(arbdp_addr5to4_c1[1:0]),
                           .arbdp_addr3to2_c1(arbdp_addr3to2_c1[1:0]),
                           .arbdp_diag_wr_way_c2(arbdp_diag_wr_way_c2[3:0]),
                           .sctag_scdata_set_c2(scdata_set_c2[9:0]), // Templated
                           .arbaddr_addr22_c2(arbaddr_addr22_c2),
                           .arbdp_addr5to4_c2(arbdp_addr5to4_c2[1:0]),
                           .arbdp_addr_start_c2(arbdp_addr_start_c2),
                           .arbaddr_idx_c3(arbaddr_idx_c3[9:0]),
                           .dir_cam_addr_c3(dir_cam_addr_c3[39:8]),
                           .arbdp_dir_wr_par_c3(arbdp_dir_wr_par_c3),
                           .arbdp_addr11to8_c3(arbdp_addr11to8_c3[7:4]),
                           .arbdp_addr5to4_c3(arbdp_addr5to4_c3[1:0]),
                           .c1_addr_eq_wb_c4(c1_addr_eq_wb_c4),
                           .arbdp_rdmatctl_addr_c6(arbdp_rdmatctl_addr_c6[5:2]),
                           .arbdp_waddr_c6(arbdp_waddr_c6[1:0]),
                           .arbdp_word_addr_c6(arbdp_word_addr_c6[2:0]),
                           .arbdp_byte_addr_c6(arbdp_byte_addr_c6[1:0]),
                           .arbdp_addr22_c7(arbdp_addr22_c7),
                           .arbdp_csr_addr_c9(arbdp_csr_addr_c9[39:4]),
                           .rdmard_addr_c12(rdmard_addr_c12[39:6]),
                           .arbdp_line_addr_c7(arbdp_line_addr_c7[5:4]),
                           .arbdp_inst_byte_addr_c7(arbdp_inst_byte_addr_c7[2:0]),
                           .arbdp_oqdp_l1_index_c7(arbdp_oqdp_l1_index_c7[11:6]),
                           .arbaddrdp_addr2_c8(arbaddrdp_addr2_c8),
                           .data_ecc_idx(data_ecc_idx[9:0]),
                           .tag_wrdata_px2(tag_wrdata_px2[27:0]),
                           // Inputs
                           .iq_arbdp_addr_px2(iq_arbdp_addr_px2[39:0]),
                           .snpq_arbdp_addr_px2(snpq_arbdp_addr_px2[39:0]),
                           .evicttag_addr_px2(evicttag_addr_px2[39:0]),
                           .tagdp_evict_tag_c4(tagdp_evict_tag_c4[`TAG_WIDTH-1:0]),
                           .csr_wr_dirpinj_en(csr_wr_dirpinj_en),
                           .mux2_snpsel_px2(mux2_snpsel_px2),
                           .mux3_bufsel_px2(mux3_bufsel_px2),
                           .mux4_c1sel_px2(mux4_c1sel_px2),
                           .inc_tag_ecc_cnt_c3_n(inc_tag_ecc_cnt_c3_n),
                           .data_ecc_idx_reset(data_ecc_idx_reset),
                           .data_ecc_idx_en(data_ecc_idx_en),
                           .sel_vuad_bist_px2(sel_vuad_bist_px2),
                           .sel_decc_or_bist_idx(sel_decc_or_bist_idx),
                           .sel_diag_addr_px2(sel_diag_addr_px2),
                           .sel_tecc_addr_px2(sel_tecc_addr_px2),
                           .sel_decc_addr_px2(sel_decc_addr_px2),
                           .sel_diag_tag_addr_px2(sel_diag_tag_addr_px2),
                           .sel_lkup_stalled_tag_px2(sel_lkup_stalled_tag_px2),
                           .arbctl_imiss_hit_c10(arbctl_imiss_hit_c10),
                           .tagctl_rd64_complete_c11(tagctl_rd64_complete_c11),
                           .arbctl_imiss_hit_c4(arbctl_imiss_hit_c4),
                           .sel_c2_stall_idx_c1(sel_c2_stall_idx_c1),
                           .bist_data_set_c1(mbist_l2d_index[9:0]), // Templated
                           .bist_data_enable_c1(mbist_arb_l2d_en), // Templated
                           .bist_vuad_idx_px1(mbist_l2v_index[9:0]), // Templated
                           .rclk        (rclk),
                           .diag_or_tecc_write_px2(diag_or_tecc_write_px2),
                           .sel_way_px2 (sel_way_px2));

/*sctag_arbctl        AUTO_TEMPLATE(
		.arbdp_ioaddr_c1_39to37   (arbdp_ioaddr_c1[39:37]),
		.arbdp_ioaddr_c1_35to33   (arbdp_ioaddr_c1[35:33]),
	 	.bist_acc_vd_px1(mbist_l2v_vd),
                     .bist_vuad_rd_en_px1(mbist_l2v_read),
	 	.bist_data_rd_en_c1(mbist_l2d_read),
                .arbdp_addr11to8_c3(arbdp_addr11to8_c3[7:4]),
                     .arbdp_addr5to4_c2 (arbdp_addr5to4_c2[1:1]),
                     .dbginit_l         (arbctl_dbginit_l),
                     .data_ecc_active_c3(arbctl_data_ecc_active_c3),
                .bist_data_wr_en_c1(mbist_arb_l2d_write)) ; */

sctag_arbctl	arbctl(
                     .so                (scannet_61),
                     .si                (scannet_60),
                     .se                (scan_enable_0_buf_j),
                     .sehold            (sehold_0_buf_j),
                     .arbctl_mb_camen_px2(arbctl_mb_camen_px2),
		     .grst_l		(greset_l_0_buf_j),
		     .arst_l		(areset_l_0_buf_j),
                     .arbctl_inst_vld_c1(arbctl_inst_vld_c1),
                     .arbctl_evict_vld_c2(arbctl_evict_vld_c2),
                     /*AUTOINST*/
                     // Outputs
                     .arbctl_mbctl_inval_inst_c2(arbctl_mbctl_inval_inst_c2),
                     .arbctl_acc_vd_c2  (arbctl_acc_vd_c2),
                     .arbctl_acc_ua_c2  (arbctl_acc_ua_c2),
                     .mux1_mbsel_px2    (mux1_mbsel_px2),
                     .mux2_snpsel_px2   (mux2_snpsel_px2),
                     .mux3_bufsel_px2   (mux3_bufsel_px2),
                     .mux4_c1sel_px2    (mux4_c1sel_px2),
                     .data_ecc_idx_en   (data_ecc_idx_en),
                     .data_ecc_idx_reset(data_ecc_idx_reset),
                     .sel_tecc_addr_px2 (sel_tecc_addr_px2),
                     .sel_decc_addr_px2 (sel_decc_addr_px2),
                     .sel_diag_addr_px2 (sel_diag_addr_px2),
                     .sel_diag_tag_addr_px2(sel_diag_tag_addr_px2),
                     .inc_tag_ecc_cnt_c3_n(inc_tag_ecc_cnt_c3_n),
                     .sel_lkup_stalled_tag_px2(sel_lkup_stalled_tag_px2),
                     .bist_or_diag_acc_c1(bist_or_diag_acc_c1),
                     .sel_decc_or_bist_idx(sel_decc_or_bist_idx),
                     .sel_vuad_bist_px2 (sel_vuad_bist_px2),
                     .arbctl_mbctl_inst_vld_c2(arbctl_mbctl_inst_vld_c2),
                     .arbctl_fbctl_inst_vld_c2(arbctl_fbctl_inst_vld_c2),
                     .arbctl_inst_vld_c2(arbctl_inst_vld_c2),
                     .arbctl_tagctl_inst_vld_c2(arbctl_tagctl_inst_vld_c2),
                     .arbctl_wbctl_inst_vld_c2(arbctl_wbctl_inst_vld_c2),
                     .arbctl_imiss_hit_c10(arbctl_imiss_hit_c10),
                     .arbctl_imiss_hit_c4(arbctl_imiss_hit_c4),
                     .arbctl_evict_c3   (arbctl_evict_c3),
                     .arbctl_evict_c4   (arbctl_evict_c4),
                     .sel_c2_stall_idx_c1(sel_c2_stall_idx_c1),
                     .arbctl_vuad_acc_px2(arbctl_vuad_acc_px2),
                     .arbctl_tag_wr_px2 (arbctl_tag_wr_px2),
                     .arbctl_vuad_idx2_sel_px2_n(arbctl_vuad_idx2_sel_px2_n),
                     .arbctl_fbctl_fbsel_c1(arbctl_fbctl_fbsel_c1),
                     .arbctl_mbctl_mbsel_c1(arbctl_mbctl_mbsel_c1),
                     .arbctl_iqsel_px2  (arbctl_iqsel_px2),
                     .arbctl_inst_diag_c1(arbctl_inst_diag_c1),
                     .scdata_fbrd_c3    (scdata_fbrd_c3),
                     .arbctl_mbctl_ctrue_c9(arbctl_mbctl_ctrue_c9),
                     .arbctl_mbctl_cas1_hit_c8(arbctl_mbctl_cas1_hit_c8),
                     .arbctl_decc_data_sel_c9(arbctl_decc_data_sel_c9),
                     .arbctl_tecc_way_c2(arbctl_tecc_way_c2[3:0]),
                     .arbctl_l2tag_vld_c4(arbctl_l2tag_vld_c4),
                     .dword_mask_c8     (dword_mask_c8[7:0]),
                     .arbctl_fill_vld_c2(arbctl_fill_vld_c2),
                     .arbctl_imiss_vld_c2(arbctl_imiss_vld_c2),
                     .arbctl_normal_tagacc_c2(arbctl_normal_tagacc_c2),
                     .arbctl_tagdp_tecc_c2(arbctl_tagdp_tecc_c2),
                     .arbctl_dir_vld_c3_l(arbctl_dir_vld_c3_l),
                     .arbctl_dc_rd_en_c3(arbctl_dc_rd_en_c3),
                     .arbctl_ic_rd_en_c3(arbctl_ic_rd_en_c3),
                     .arbctl_dc_wr_en_c3(arbctl_dc_wr_en_c3),
                     .arbctl_ic_wr_en_c3(arbctl_ic_wr_en_c3),
                     .arbctl_dir_panel_dcd_c3(arbctl_dir_panel_dcd_c3[4:0]),
                     .arbctl_dir_panel_icd_c3(arbctl_dir_panel_icd_c3[4:0]),
                     .arbctl_lkup_bank_ena_dcd_c3(arbctl_lkup_bank_ena_dcd_c3[3:0]),
                     .arbctl_lkup_bank_ena_icd_c3(arbctl_lkup_bank_ena_icd_c3[3:0]),
                     .arbctl_inval_mask_dcd_c3(arbctl_inval_mask_dcd_c3[7:0]),
                     .arbctl_inval_mask_icd_c3(arbctl_inval_mask_icd_c3[7:0]),
                     .arbctl_wr_dc_dir_entry_c3(arbctl_wr_dc_dir_entry_c3[4:0]),
                     .arbctl_wr_ic_dir_entry_c3(arbctl_wr_ic_dir_entry_c3[4:0]),
                     .dir_addr_c9       (dir_addr_c9[10:0]),
                     .arbctl_dir_wr_en_c4(arbctl_dir_wr_en_c4),
                     .arbctl_csr_wr_en_c7(arbctl_csr_wr_en_c7),
                     .arbctl_csr_rd_en_c7(arbctl_csr_rd_en_c7),
                     .arbctl_evict_c5   (arbctl_evict_c5),
                     .arbctl_waysel_gate_c2(arbctl_waysel_gate_c2),
                     .arbctl_data_diag_st_c2(arbctl_data_diag_st_c2),
                     .arbctl_inval_inst_c2(arbctl_inval_inst_c2),
                     .arbctl_inst_diag_c2(arbctl_inst_diag_c2),
                     .decdp_ld64_inst_c1(decdp_ld64_inst_c1),
                     .arbctl_waysel_inst_vld_c2(arbctl_waysel_inst_vld_c2),
                     .arbctl_coloff_inst_vld_c2(arbctl_coloff_inst_vld_c2),
                     .arbctl_rdwr_inst_vld_c2(arbctl_rdwr_inst_vld_c2),
                     .ic_inval_vld_c7   (ic_inval_vld_c7),
                     .dc_inval_vld_c7   (dc_inval_vld_c7),
                     .arbctl_inst_l2data_vld_c6(arbctl_inst_l2data_vld_c6),
                     .arbctl_csr_wr_en_c3(arbctl_csr_wr_en_c3),
                     .arbctl_csr_rd_en_c3(arbctl_csr_rd_en_c3),
                     .arbctl_diag_complete_c3(arbctl_diag_complete_c3),
                     .arbctl_tagctl_pst_with_ctrue_c1(arbctl_tagctl_pst_with_ctrue_c1),
                     .arbctl_csr_st_c2  (arbctl_csr_st_c2),
                     .arbctl_mbctl_hit_off_c1(arbctl_mbctl_hit_off_c1),
                     .arbctl_pst_ctrue_en_c8(arbctl_pst_ctrue_en_c8),
                     .arbctl_evict_tecc_vld_c2(arbctl_evict_tecc_vld_c2),
                     .arbctl_fbctl_hit_off_c1(arbctl_fbctl_hit_off_c1),
                     .arbctl_wbctl_hit_off_c1(arbctl_wbctl_hit_off_c1),
                     .arbctl_inst_l2vuad_vld_c6(arbctl_inst_l2vuad_vld_c6),
                     .arbctl_inst_l2tag_vld_c6(arbctl_inst_l2tag_vld_c6),
                     .arbctl_snpsel_c1  (arbctl_snpsel_c1),
                     .arbctl_dbgdp_inst_vld_c3(arbctl_dbgdp_inst_vld_c3),
                     .decdp_tagctl_wr_c1(decdp_tagctl_wr_c1),
                     .decdp_pst_inst_c2 (decdp_pst_inst_c2),
                     .decdp_fwd_req_c2  (decdp_fwd_req_c2),
                     .decdp_swap_inst_c2(decdp_swap_inst_c2),
                     .decdp_imiss_inst_c2(decdp_imiss_inst_c2),
                     .decdp_inst_int_c2 (decdp_inst_int_c2),
                     .decdp_inst_int_c1 (decdp_inst_int_c1),
                     .decdp_ld64_inst_c2(decdp_ld64_inst_c2),
                     .decdp_bis_inst_c3 (decdp_bis_inst_c3),
                     .decdp_rmo_st_c3   (decdp_rmo_st_c3),
                     .decdp_strst_inst_c2(decdp_strst_inst_c2),
                     .decdp_wr8_inst_c2 (decdp_wr8_inst_c2),
                     .decdp_wr64_inst_c2(decdp_wr64_inst_c2),
                     .decdp_st_inst_c2  (decdp_st_inst_c2),
                     .decdp_st_inst_c3  (decdp_st_inst_c3),
                     .decdp_st_with_ctrue_c2(decdp_st_with_ctrue_c2),
                     .decdp_ld_inst_c2  (decdp_ld_inst_c2),
                     .arbdp_dword_st_c2 (arbdp_dword_st_c2),
                     .arbdp_pst_with_ctrue_c2(arbdp_pst_with_ctrue_c2),
                     .decdp_cas1_inst_c2(decdp_cas1_inst_c2),
                     .decdp_cas2_inst_c2(decdp_cas2_inst_c2),
                     .decdp_cas2_from_mb_c2(decdp_cas2_from_mb_c2),
                     .decdp_cas2_from_mb_ctrue_c2(decdp_cas2_from_mb_ctrue_c2),
                     .arbctl_inst_l2vuad_vld_c3(arbctl_inst_l2vuad_vld_c3),
                     .write_req_c3      (write_req_c3),
                     .atomic_req_c3     (atomic_req_c3),
                     .prim_req_c3       (prim_req_c3),
                     .decdp_pf_inst_c5  (decdp_pf_inst_c5),
                     .decdp_strld_inst_c6(decdp_strld_inst_c6),
                     .decdp_atm_inst_c6 (decdp_atm_inst_c6),
                     .store_err_c8      (store_err_c8),
                     .arbdp_tecc_inst_mb_c8(arbdp_tecc_inst_mb_c8),
                     .arbctl_tagdp_perr_vld_c2(arbctl_tagdp_perr_vld_c2),
                     .arbdp_tagctl_pst_no_ctrue_c2(arbdp_tagctl_pst_no_ctrue_c2),
                     .arbdp_mbctl_pst_no_ctrue_c2(arbdp_mbctl_pst_no_ctrue_c2),
                     .arbdp_vuadctl_pst_no_ctrue_c2(arbdp_vuadctl_pst_no_ctrue_c2),
                     .arbctl_tecc_c2    (arbctl_tecc_c2),
                     .vuadctl_no_bypass_px2(vuadctl_no_bypass_px2),
                     .sel_way_px2       (sel_way_px2),
                     .diag_or_tecc_write_px2(diag_or_tecc_write_px2),
                     .arbctl_tag_rd_px2 (arbctl_tag_rd_px2),
                     .arbctl_tag_way_px2(arbctl_tag_way_px2[11:0]),
                     .mux1_mbsel_px1    (mux1_mbsel_px1),
                     .wr8_inst_no_ctrue_c1(wr8_inst_no_ctrue_c1),
                     // Inputs
                     .oqctl_arbctl_full_px2(oqctl_arbctl_full_px2),
                     .mbctl_arbctl_vld_px1(mbctl_arbctl_vld_px1),
                     .mbctl_arbctl_cnt12_px2_prev(mbctl_arbctl_cnt12_px2_prev),
                     .mbctl_arbctl_snp_cnt8_px1(mbctl_arbctl_snp_cnt8_px1),
                     .wbctl_arbctl_full_px1(wbctl_arbctl_full_px1),
                     .mbctl_arbctl_hit_c3(mbctl_arbctl_hit_c3),
                     .fbctl_arbctl_vld_px1(fbctl_arbctl_vld_px1),
                     .iq_arbctl_vld_px2 (iq_arbctl_vld_px2),
                     .iq_arbctl_vbit_px2(iq_arbctl_vbit_px2),
                     .iq_arbctl_atm_px2 (iq_arbctl_atm_px2),
                     .iq_arbctl_csr_px2 (iq_arbctl_csr_px2),
                     .iq_arbctl_st_px2  (iq_arbctl_st_px2),
                     .snpq_arbctl_vld_px1(snpq_arbctl_vld_px1),
                     .tagctl_decc_data_sel_c8(tagctl_decc_data_sel_c8),
                     .tagctl_rdma_vld_px1(tagctl_rdma_vld_px1),
                     .data_ecc_active_c3(arbctl_data_ecc_active_c3), // Templated
                     .decc_tag_acc_en_px2(decc_tag_acc_en_px2),
                     .mbctl_nondep_fbhit_c3(mbctl_nondep_fbhit_c3),
                     .mbist_arb_l2d_en  (mbist_arb_l2d_en),
                     .bist_vuad_rd_en_px1(mbist_l2v_read),       // Templated
                     .arbdp_inst_fb_c2  (arbdp_inst_fb_c2),
                     .arbdp_ioaddr_c1_39to37(arbdp_ioaddr_c1[39:37]), // Templated
                     .arbdp_ioaddr_c1_35to33(arbdp_ioaddr_c1[35:33]), // Templated
                     .size_field_c8     (size_field_c8[1:0]),
                     .word_lower_cmp_c8 (word_lower_cmp_c8),
                     .word_upper_cmp_c8 (word_upper_cmp_c8),
                     .arbaddrdp_addr2_c8(arbaddrdp_addr2_c8),
                     .arbdp_inst_size_c7(arbdp_inst_size_c7[2:0]),
                     .arbdp_diag_wr_way_c2(arbdp_diag_wr_way_c2[3:0]),
                     .arbdp_inst_byte_addr_c7(arbdp_inst_byte_addr_c7[2:0]),
                     .arbdp_inst_way_c1 (arbdp_inst_way_c1[3:0]),
                     .arbdp_tecc_c1     (arbdp_tecc_c1),
                     .fbctl_arbdp_way_px2(fbctl_arbdp_way_px2[3:0]),
                     .arbdp_inst_mb_c2  (arbdp_inst_mb_c2),
                     .arbdp_inst_fb_c1  (arbdp_inst_fb_c1),
                     .arbdp_inst_dep_c2 (arbdp_inst_dep_c2),
                     .tagctl_hit_l2orfb_c3(tagctl_hit_l2orfb_c3),
                     .tagdp_arbctl_par_err_c3(tagdp_arbctl_par_err_c3),
                     .invalid_evict_c3  (invalid_evict_c3),
                     .arbdp_inst_nc_c3  (arbdp_inst_nc_c3),
                     .arbdp_cpuid_c3    (arbdp_cpuid_c3[2:0]),
                     .arbdp_cpuid_c4    (arbdp_cpuid_c4[2:0]),
                     .arbdp_cpuid_c5    (arbdp_cpuid_c5[2:0]),
                     .arbdp_cpuid_c6    (arbdp_cpuid_c6[2:0]),
                     .arbdp_l1way_c3    (arbdp_l1way_c3[1:0]),
                     .arbdp_addr11to8_c3(arbdp_addr11to8_c3[7:4]), // Templated
                     .arbdp_new_addr5to4_px2(arbdp_new_addr5to4_px2[1:0]),
                     .arbdp_addr5to4_c1 (arbdp_addr5to4_c1[1:0]),
                     .arbdp_addr5to4_c2 (arbdp_addr5to4_c2[1:1]), // Templated
                     .arbdp_addr5to4_c3 (arbdp_addr5to4_c3[1:0]),
                     .arbdp_inst_fb_c3  (arbdp_inst_fb_c3),
                     .arbdp_inst_mb_c3  (arbdp_inst_mb_c3),
                     .arbdp_inst_tecc_c3(arbdp_inst_tecc_c3),
                     .arbdp_inst_bufidhi_c1(arbdp_inst_bufidhi_c1),
                     .arbdp_inst_bufid1_c1(arbdp_inst_bufid1_c1),
                     .arbdp_inst_mb_c1  (arbdp_inst_mb_c1),
                     .arbdp_evict_c1    (arbdp_evict_c1),
                     .arbdp_inst_rqtyp_c1(arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO]),
                     .arbdp_inst_rsvd_c1(arbdp_inst_rsvd_c1),
                     .arbdp_inst_nc_c1  (arbdp_inst_nc_c1),
                     .arbdp_word_addr_c1(arbdp_word_addr_c1[1:0]),
                     .arbdp_inst_ctrue_c1(arbdp_inst_ctrue_c1),
                     .arbdp_inst_size_c1(arbdp_inst_size_c1[`L2_SZ_HI:`L2_SZ_LO]),
                     .arbdp_addr_start_c2(arbdp_addr_start_c2),
                     .arbdp_rdma_inst_c2(arbdp_rdma_inst_c2),
                     .arbdp_inst_bufidlo_c2(arbdp_inst_bufidlo_c2),
                     .arbdp_inst_rqtyp_c2(arbdp_inst_rqtyp_c2[`L2_RQTYP_HI:`L2_RQTYP_LO]),
                     .arbdp_inst_rqtyp_c6(arbdp_inst_rqtyp_c6[`L2_RQTYP_HI:`L2_RQTYP_LO]),
                     .arbaddr_addr22_c2 (arbaddr_addr22_c2),
                     .bist_acc_vd_px1   (mbist_l2v_vd),          // Templated
                     .mbist_arbctl_l2t_write(mbist_arbctl_l2t_write),
                     .l2_bypass_mode_on (l2_bypass_mode_on),
                     .rclk              (rclk),
                     .dbginit_l         (arbctl_dbginit_l));      // Templated

sctag_arbdecdp	arbdecdp(
                         .arbdp_inst_c8 (arbdp_inst_c8[`L2_POISON:`L2_SZ_LO]),
                         .so            (scannet_60),
                         .snpq_arbdp_inst_px2({snpq_arbdp_inst_px2[`JBI_HDR_SZ-1:4],1'b1,snpq_arbdp_inst_px2[2:0]}),
                         .si            (scannet_59),
                         .se            (scan_enable_0_buf_j),
	 		 /*AUTOINST*/
                         // Outputs
                         .arbdp_inst_way_c1(arbdp_inst_way_c1[3:0]),
                         .arbdp_tecc_c1 (arbdp_tecc_c1),
                         .arbdp_poison_c1(arbdp_poison_c1),
                         .arbdp_inst_mb_entry_c1(arbdp_inst_mb_entry_c1[3:0]),
                         .arbdp_inst_fb_c1(arbdp_inst_fb_c1),
                         .arbdp_inst_mb_c1(arbdp_inst_mb_c1),
                         .arbdp_evict_c1(arbdp_evict_c1),
                         .arbdp_inst_rqtyp_c1(arbdp_inst_rqtyp_c1[`L2_RQTYP_HI:`L2_RQTYP_LO]),
                         .arbdp_inst_rsvd_c1(arbdp_inst_rsvd_c1),
                         .arbdp_inst_nc_c1(arbdp_inst_nc_c1),
                         .arbdp_inst_size_c1(arbdp_inst_size_c1[`L2_SZ_HI:`L2_SZ_LO]),
                         .arbdp_inst_bufidhi_c1(arbdp_inst_bufidhi_c1),
                         .arbdp_inst_bufid1_c1(arbdp_inst_bufid1_c1),
                         .arbdp_inst_ctrue_c1(arbdp_inst_ctrue_c1),
                         .arbdp_inst_fb_c2(arbdp_inst_fb_c2),
                         .arbdp_inst_mb_c2(arbdp_inst_mb_c2),
                         .arbdp_rdma_entry_c3(arbdp_rdma_entry_c3[1:0]),
                         .arbdp_rdma_inst_c1(arbdp_rdma_inst_c1),
                         .arbdp_rdma_inst_c2(arbdp_rdma_inst_c2),
                         .arbdp_inst_dep_c2(arbdp_inst_dep_c2),
                         .arbdp_inst_way_c2(arbdp_inst_way_c2[3:0]),
                         .arbdp_inst_rqtyp_c2(arbdp_inst_rqtyp_c2[`L2_RQTYP_HI:`L2_RQTYP_LO]),
                         .arbdp_inst_bufidlo_c2(arbdp_inst_bufidlo_c2),
                         .arbdp_inst_rqtyp_c6(arbdp_inst_rqtyp_c6[`L2_RQTYP_HI:`L2_RQTYP_LO]),
                         .arbdp_inst_way_c3(arbdp_inst_way_c3[3:0]),
                         .arbdp_inst_fb_c3(arbdp_inst_fb_c3),
                         .arbdp_inst_mb_c3(arbdp_inst_mb_c3),
                         .arbdp_inst_tecc_c3(arbdp_inst_tecc_c3),
                         .arbdp_inst_nc_c3(arbdp_inst_nc_c3),
                         .arbdp_l1way_c3(arbdp_l1way_c3[1:0]),
                         .arbdec_dbgdp_inst_c3(arbdec_dbgdp_inst_c3[8:0]),
                         .arbdp_cpuid_c3(arbdp_cpuid_c3[2:0]),
                         .arbdp_cpuid_c4(arbdp_cpuid_c4[2:0]),
                         .arbdp_cpuid_c5(arbdp_cpuid_c5[2:0]),
                         .arbdp_cpuid_c6(arbdp_cpuid_c6[2:0]),
                         .arbdp_int_bcast_c5(arbdp_int_bcast_c5),
                         .arbdp_inst_l1way_c7(arbdp_inst_l1way_c7[1:0]),
                         .arbdp_inst_size_c7(arbdp_inst_size_c7[2:0]),
                         .arbdp_inst_tid_c7(arbdp_inst_tid_c7[1:0]),
                         .arbdp_inst_cpuid_c7(arbdp_inst_cpuid_c7[2:0]),
                         .arbdp_inst_nc_c7(arbdp_inst_nc_c7),
                         .arbdec_ctag_c6(arbdec_ctag_c6[14:0]),
                         .arbdp_async_bit_c8(arbdp_async_bit_c8),
                         .size_field_c8 (size_field_c8[1:0]),
                         // Inputs
                         .iq_arbdp_inst_px2(iq_arbdp_inst_px2[18:0]),
                         .mb_data_read_data(mb_data_read_data[`MBD_EVICT:`MBD_SZ_LO]),
                         .mbctl_arbdp_ctrue_px2(mbctl_arbdp_ctrue_px2),
                         .mbctl_arb_l2rd_en(mbctl_arb_l2rd_en),
                         .fbctl_arbdp_entry_px2(fbctl_arbdp_entry_px2[2:0]),
                         .fbctl_arbdp_tecc_px2(fbctl_arbdp_tecc_px2),
                         .l2_steering_tid(l2_steering_tid[4:0]),
                         .fbctl_arbdp_way_px2(fbctl_arbdp_way_px2[3:0]),
                         .mux1_mbsel_px2(mux1_mbsel_px2),
                         .mux2_snpsel_px2(mux2_snpsel_px2),
                         .mux3_bufsel_px2(mux3_bufsel_px2),
                         .mux4_c1sel_px2(mux4_c1sel_px2),
                         .prim_req_c3   (prim_req_c3),
                         .write_req_c3  (write_req_c3),
                         .atomic_req_c3 (atomic_req_c3),
                         .rclk          (rclk),
                         .arbdp_byte_addr_c6(arbdp_byte_addr_c6[1:0]));

/*sctag_wbctl        AUTO_TEMPLATE(
		 .dbginit_l(wbctl_dbginit_l),
	 	.l2_bypass_mode_on(csr_wbctl_l2off)) ;  */

sctag_wbctl	wbctl(
                    .rst_tri_en         (mux_drive_disable_0_buf_k),
                  .wb_cam_match_c2      (wb_cam_match_c2[7:0]),
                  .wbtag_write_wl_c4    (wbtag_write_wl_c4[7:0]),
                  .wbtag_write_en_c4    (wbtag_write_en_c4),
                  .wb_read_wl           (wb_read_wl[7:0]),
                  .wb_read_en           (wb_read_en),
                  .rdmat_read_wl        (rdmat_read_wl[3:0]),
                  .rdmat_read_en        (rdmat_read_en),
			.grst_l		(greset_l_0_buf_k),
			.arst_l		(areset_l_0_buf_k),
		.so    (scannet_72),
                         .si    (scannet_71),
                         .se    (scan_enable_0_buf_k),

		   /*AUTOINST*/
                  // Outputs
                  .sctag_scbuf_wbwr_wl_c6(sctag_scbuf_wbwr_wl_c6[2:0]),
                  .sctag_scbuf_wbwr_wen_c6(sctag_scbuf_wbwr_wen_c6[3:0]),
                  .sctag_scbuf_wbrd_wl_r0(sctag_scbuf_wbrd_wl_r0[2:0]),
                  .sctag_scbuf_wbrd_en_r0(sctag_scbuf_wbrd_en_r0),
                  .sctag_scbuf_ev_dword_r0(sctag_scbuf_ev_dword_r0[2:0]),
                  .sctag_scbuf_evict_en_r0(sctag_scbuf_evict_en_r0),
                  .sctag_dram_wr_req    (sctag_dram_wr_req),
                  .wbctl_hit_unqual_c2  (wbctl_hit_unqual_c2),
                  .wbctl_mbctl_dep_rdy_en(wbctl_mbctl_dep_rdy_en),
                  .wbctl_mbctl_dep_mbid (wbctl_mbctl_dep_mbid[3:0]),
                  .wbctl_arbctl_full_px1(wbctl_arbctl_full_px1),
                  .wbctl_wr_addr_sel    (wbctl_wr_addr_sel),
                  .wb_or_rdma_wr_req_en (wb_or_rdma_wr_req_en),
                  .sctag_scbuf_rdma_rdwl_r0(sctag_scbuf_rdma_rdwl_r0[1:0]),
                  .sctag_scbuf_rdma_rden_r0(sctag_scbuf_rdma_rden_r0),
                  .reset_rdmat_vld      (reset_rdmat_vld[3:0]),
                  .set_rdmat_acked      (set_rdmat_acked[3:0]),
                  .sctag_jbi_wib_dequeue(sctag_jbi_wib_dequeue),
                  // Inputs
                  .rclk                 (rclk),
                  .dbginit_l            (wbctl_dbginit_l),       // Templated
                  .dirty_evict_c3       (dirty_evict_c3),
                  .arbdp_inst_fb_c2     (arbdp_inst_fb_c2),
                  .mbctl_wbctl_mbid_c4  (mbctl_wbctl_mbid_c4[3:0]),
                  .mbctl_hit_c4         (mbctl_hit_c4),
                  .mbctl_fbctl_dram_pick(mbctl_fbctl_dram_pick),
                  .l2_bypass_mode_on    (csr_wbctl_l2off),       // Templated
                  .c1_addr_eq_wb_c4     (c1_addr_eq_wb_c4),
                  .arbctl_wbctl_hit_off_c1(arbctl_wbctl_hit_off_c1),
                  .arbctl_wbctl_inst_vld_c2(arbctl_wbctl_inst_vld_c2),
                  .dram_sctag_wr_ack    (dram_sctag_wr_ack),
                  .rdmat_pick_vec       (rdmat_pick_vec[3:0]),
                  .or_rdmat_valid       (or_rdmat_valid));

bw_r_cm16x40b       wbtag   ( .dout(wb_read_data[39:0]),
                .match(wb_cam_match_c2[15:0]),
                .match_idx(),
                .adr_w({8'b0, wbtag_write_wl_c4[7:0]}),
                .din(wb_write_addr[39:0]), // generated in arbaddrdp
                .write_en(wbtag_write_en_c4),
                .adr_r({8'b0,wb_read_wl_7_rep1,wb_read_wl[6:4],wb_read_wl_3_rep1,wb_read_wl[2:0]}),
                .lookup_en(arbctl_inst_vld_c1),
                .key(lkup_addr_c1[39:8]),
                .rst_tri_en(mem_write_disable_0_buf_k),
                .rclk(rclk),
                .read_en(wb_read_en),
		.sehold(sehold_0_buf_k),
                .se(scan_enable_0_buf_k),
                .si(scannet_74),
                .so(scannet_75),
                .rst_l(areset_l_0_buf_k));



sctag_iqdp	iqdp(
                 .iq_array_rd_data_c1   (iq_array_rd_data_c1[124:0]),
                 .iqdp_iqarray_data_in   (iqdp_iqarray_data_in[124:0]),
                 .so                    (scannet_66),
                 .se                    (scan_enable_0_buf_i),
                 .si                    (scannet_65),
		  /*AUTOINST*/
                 // Outputs
                 .iq_arbdp_data_px2     (iq_arbdp_data_px2[63:0]),
                 .iq_arbdp_addr_px2     (iq_arbdp_addr_px2[39:0]),
                 .iq_arbdp_inst_px2     (iq_arbdp_inst_px2[18:0]),
                 .iq_arbctl_atm_px2     (iq_arbctl_atm_px2),
                 .iq_arbctl_csr_px2     (iq_arbctl_csr_px2),
                 .iq_arbctl_st_px2      (iq_arbctl_st_px2),
                 .iq_arbctl_vbit_px2    (iq_arbctl_vbit_px2),
                 // Inputs
                 .rclk                  (rclk),
                 .pcx_sctag_data_px2    (pcx_sctag_data_px2[123:0]),
                 .pcx_sctag_atm_px2_p   (pcx_sctag_atm_px2_p),
                 .iqctl_sel_pcx         (iqctl_sel_pcx),
                 .iqctl_sel_c1          (iqctl_sel_c1),
                 .iqctl_hold_rd         (iqctl_hold_rd),
                 .sel_c1reg_over_iqarray(sel_c1reg_over_iqarray));

sctag_iqctl	iqctl(
                  .iq_array_wr_en       (iq_array_wr_en),
                  .iq_array_wr_wl       (iq_array_wr_wl[3:0]),
                  .iq_array_rd_en       (iq_array_rd_en),
                  .iq_array_rd_wl       (iq_array_rd_wl[3:0]),
                 .so                    (scannet_65),
                 .se                    (scan_enable_0_buf_i),
                 .si                    (scannet_64),
			.grst_l		(greset_l_0_buf_i),
			.arst_l		(areset_l_0_buf_i),
                  .sehold               (sehold_0_buf_i),
		/*AUTOINST*/
                  // Outputs
                  .sctag_pcx_stall_pq   (sctag_pcx_stall_pq),
                  .iq_arbctl_vld_px2    (iq_arbctl_vld_px2),
                  .pcx_sctag_atm_px2_p  (pcx_sctag_atm_px2_p),
                  .iqctl_sel_pcx        (iqctl_sel_pcx),
                  .iqctl_sel_c1         (iqctl_sel_c1),
                  .iqctl_hold_rd        (iqctl_hold_rd),
                  .sel_c1reg_over_iqarray(sel_c1reg_over_iqarray),
                  // Inputs
                  .rclk                 (rclk),
                  .pcx_sctag_data_rdy_px1(pcx_sctag_data_rdy_px1),
                  .pcx_sctag_atm_px1    (pcx_sctag_atm_px1),
                  .arbctl_iqsel_px2     (arbctl_iqsel_px2));




bw_r_rf16x160    iqarray(
                           // Outputs
              .dout        (iq_array_rd_data_c1[159:0]),
                           .si_r          (scannet_62),
                           .so_r          (scannet_63),
                           .si_w          (scannet_63),
                           .so_w          (scannet_64),
                           // Inputs
      .din         ({35'b0,iqdp_iqarray_data_in[124:0]}),
                           .rd_adr      (iq_array_rd_wl[3:0]),
                           .wr_adr      (iq_array_wr_wl[3:0]),
                           .read_en     (iq_array_rd_en),
                           .wr_en       (iq_array_wr_en),
                           .word_wen    (4'b1111),
                           .byte_wen    (20'b11111111111111111111),
                           .rd_clk         (rclk),
                           .rst_tri_en         (mem_write_disable_0_buf_i),
                           .wr_clk         (rclk),
                           .se          (scan_enable_0_buf_i),
                           .reset_l     (areset_l_0_buf_i),
                           .sehold      (sehold_0_buf_i));




sctag_oqctl		oqctl(
                    .oqarray_wr_en      (oqarray_wr_en),
                    .oqarray_rd_en      (oqarray_rd_en),
                    .oqarray_wr_ptr     (oqarray_wr_ptr[3:0]),
                    .oqarray_rd_ptr     (oqarray_rd_ptr[3:0]),
                    .lkup_bank_ena_dcd_c4(dc_lkup_row_dec_c4[3:0]),
                    .lkup_bank_ena_icd_c4(ic_lkup_row_dec_c4[3:0]),
                    .rst_tri_en         (mux_drive_disable_0_buf_g),
                    .si                 (scannet_51),
                    .se                 (scan_enable_0_buf_g),
                    .so                 (scannet_52),
			.grst_l		(greset_l_0_buf_g),
			.arst_l		(areset_l_0_buf_g),
                    .sehold             (sehold_0_buf_g),
                    .tagctl_nonmem_comp_c6(tagctl_nonmem_comp_c6_rep1),
                    .tagctl_rdma_wr_comp_c4(tagctl_rdma_wr_comp_c4_rep1),
		    /*AUTOINST*/
                    // Outputs
                    .sctag_cpx_req_cq   (sctag_cpx_req_cq[7:0]),
                    .sctag_cpx_atom_cq  (sctag_cpx_atom_cq),
                    .oqctl_diag_acc_c8  (oqctl_diag_acc_c8),
                    .oqctl_rqtyp_rtn_c7 (oqctl_rqtyp_rtn_c7[3:0]),
                    .oqctl_cerr_ack_c7  (oqctl_cerr_ack_c7),
                    .oqctl_uerr_ack_c7  (oqctl_uerr_ack_c7),
                    .str_ld_hit_c7      (str_ld_hit_c7),
                    .fwd_req_ret_c7     (fwd_req_ret_c7),
                    .atm_inst_ack_c7    (atm_inst_ack_c7),
                    .strst_ack_c7       (strst_ack_c7),
                    .oqctl_int_ack_c7   (oqctl_int_ack_c7),
                    .oqctl_imiss_hit_c8 (oqctl_imiss_hit_c8),
                    .oqctl_pf_ack_c7    (oqctl_pf_ack_c7),
                    .oqctl_rmo_st_c7    (oqctl_rmo_st_c7),
                    .oqctl_l2_miss_c7   (oqctl_l2_miss_c7),
                    .mux1_sel_data_c7   (mux1_sel_data_c7[3:0]),
                    .mux_csr_sel_c7     (mux_csr_sel_c7),
                    .sel_inval_c7       (sel_inval_c7),
                    .out_mux1_sel_c7    (out_mux1_sel_c7[2:0]),
                    .out_mux2_sel_c7    (out_mux2_sel_c7[2:0]),
                    .sel_array_out_l    (sel_array_out_l),
                    .sel_mux1_c6        (sel_mux1_c6[3:0]),
                    .sel_mux2_c6        (sel_mux2_c6[3:0]),
                    .sel_mux3_c6        (sel_mux3_c6),
                    .mux_vec_sel_c6     (mux_vec_sel_c6[3:0]),
                    .oqctl_arbctl_full_px2(oqctl_arbctl_full_px2),
                    .oqctl_st_complete_c7(oqctl_st_complete_c7),
                    // Inputs
                    .arbdp_cpuid_c5     (arbdp_cpuid_c5[2:0]),
                    .arbdp_int_bcast_c5 (arbdp_int_bcast_c5),
                    .decdp_strld_inst_c6(decdp_strld_inst_c6),
                    .decdp_atm_inst_c6  (decdp_atm_inst_c6),
                    .decdp_pf_inst_c5   (decdp_pf_inst_c5),
                    .arbctl_evict_c5    (arbctl_evict_c5),
                    .dirdp_req_vec_c6   (dirdp_req_vec_c6[7:0]),
                    .tagctl_imiss_hit_c5(tagctl_imiss_hit_c5),
                    .tagctl_ld_hit_c5   (tagctl_ld_hit_c5),
                    .tagctl_st_ack_c5   (tagctl_st_ack_c5),
                    .tagctl_strst_ack_c5(tagctl_strst_ack_c5),
                    .tagctl_uerr_ack_c5 (tagctl_uerr_ack_c5),
                    .tagctl_cerr_ack_c5 (tagctl_cerr_ack_c5),
                    .tagctl_int_ack_c5  (tagctl_int_ack_c5),
                    .tagctl_st_req_c5   (tagctl_st_req_c5),
                    .tagctl_fwd_req_ret_c5(tagctl_fwd_req_ret_c5),
                    .sel_rdma_inval_vec_c5(sel_rdma_inval_vec_c5),
                    .tagctl_store_inst_c5(tagctl_store_inst_c5),
                    .tagctl_fwd_req_ld_c6(tagctl_fwd_req_ld_c6),
                    .tagctl_rmo_st_ack_c5(tagctl_rmo_st_ack_c5),
                    .tagctl_inst_mb_c5  (tagctl_inst_mb_c5),
                    .tagctl_hit_c5      (tagctl_hit_c5),
                    .arbctl_inst_l2data_vld_c6(arbctl_inst_l2data_vld_c6),
                    .arbctl_inst_l2tag_vld_c6(arbctl_inst_l2tag_vld_c6),
                    .arbctl_inst_l2vuad_vld_c6(arbctl_inst_l2vuad_vld_c6),
                    .arbctl_csr_rd_en_c7(arbctl_csr_rd_en_c7),
                    .cpx_sctag_grant_cx (cpx_sctag_grant_cx[7:0]),
                    .rclk               (rclk));


bw_r_rf16x160    oqarray(
                           // Outputs
                           .dout        (oq_array_data_out[159:0]),
                           .si_r          (scannet_48),
                           .so_r          (scannet_49),
                           .si_w          (scannet_49),
                           .so_w          (scannet_50),
                           // Inputs
                           .din         ({15'b0,oq_array_data_in[`CPX_WIDTH-1:0]}),
                           .rd_adr      (oqarray_rd_ptr[3:0]),
                           .rst_tri_en         (mem_write_disable_0_buf_g),
                           .wr_adr      (oqarray_wr_ptr[3:0]),
                           .read_en     (oqarray_rd_en),
                           .wr_en       (oqarray_wr_en),
                           .word_wen    (4'b1111),
                           .byte_wen    (20'b11111111111111111111),
                           .rd_clk         (rclk),
                           .wr_clk         (rclk),
                           .se          (scan_enable_0_buf_g),
                           .reset_l     (areset_l_0_buf_g),
                           .sehold      (sehold_0_buf_g));


sctag_oqdp		oqdp(
                   .oq_array_data_out   (oq_array_data_out[`CPX_WIDTH-1:0]),
                   .oq_array_data_in    (oq_array_data_in[`CPX_WIDTH-1:0]),
			.so    (scannet_51),
                         .si    (scannet_50),
                         .se    (scan_enable_0_buf_g),
                   .vuad_dp_diag_data_c7({8'b0,vuad_dp_diag_data_c7_buf[25:0]}),
                    .rst_tri_en         (mux_drive_disable_0_buf_g),
                   .arbdp_inst_size_c7  (arbdp_inst_size_c7[2:1]),

                   /*AUTOINST*/
                   // Outputs
                   .sctag_cpx_data_ca   (sctag_cpx_data_ca[`CPX_WIDTH-1:0]),
                   .oqdp_tid_c8         (oqdp_tid_c8[4:0]),
                   // Inputs
                   .arbdp_inst_l1way_c7 (arbdp_inst_l1way_c7[1:0]),
                   .arbdp_inst_tid_c7   (arbdp_inst_tid_c7[1:0]),
                   .arbdp_inst_nc_c7    (arbdp_inst_nc_c7),
                   .arbdp_inst_cpuid_c7 (arbdp_inst_cpuid_c7[2:0]),
                   .oqctl_rqtyp_rtn_c7  (oqctl_rqtyp_rtn_c7[3:0]),
                   .dirdp_way_info_c7   (dirdp_way_info_c7[2:0]),
                   .strst_ack_c7        (strst_ack_c7),
                   .arbdp_oqdp_int_ret_c7(arbdp_oqdp_int_ret_c7[17:0]),
                   .fwd_req_ret_c7      (fwd_req_ret_c7),
                   .oqctl_int_ack_c7    (oqctl_int_ack_c7),
                   .arbdp_oqdp_l1_index_c7(arbdp_oqdp_l1_index_c7[11:6]),
                   .oqctl_imiss_hit_c8  (oqctl_imiss_hit_c8),
                   .retdp_data_c8       (retdp_data_c8[127:0]),
                   .retdp_err_c8        (retdp_err_c8[2:0]),
                   .dirdp_inval_pckt_c7 (dirdp_inval_pckt_c7[111:0]),
                   .retdp_diag_data_c7  (retdp_diag_data_c7[38:0]),
                   .tagdp_diag_data_c7  (tagdp_diag_data_c7[27:0]),
                   .oqctl_pf_ack_c7     (oqctl_pf_ack_c7),
                   .oqctl_rmo_st_c7     (oqctl_rmo_st_c7),
                   .atm_inst_ack_c7     (atm_inst_ack_c7),
                   .str_ld_hit_c7       (str_ld_hit_c7),
                   .oqctl_diag_acc_c8   (oqctl_diag_acc_c8),
                   .oqctl_cerr_ack_c7   (oqctl_cerr_ack_c7),
                   .oqctl_uerr_ack_c7   (oqctl_uerr_ack_c7),
                   .mux1_sel_data_c7    (mux1_sel_data_c7[3:0]),
                   .sel_array_out_l     (sel_array_out_l),
                   .mux_csr_sel_c7      (mux_csr_sel_c7),
                   .sel_inval_c7        (sel_inval_c7),
                   .out_mux1_sel_c7     (out_mux1_sel_c7[2:0]),
                   .out_mux2_sel_c7     (out_mux2_sel_c7[2:0]),
                   .arbdp_line_addr_c7  (arbdp_line_addr_c7[5:4]),
                   .dc_inval_vld_c7     (dc_inval_vld_c7),
                   .ic_inval_vld_c7     (ic_inval_vld_c7),
                   .csr_rd_data_c8      (csr_rd_data_c8[63:0]),
                   .oqctl_l2_miss_c7    (oqctl_l2_miss_c7),
                   .rclk                (rclk));


sctag_dirvec_dp		dirvec_dp(
				.so    (scannet_56),
                         .si    (scannet_55),
                         .se    (scan_enable_0_buf_h),

				/*AUTOINST*/
                            // Outputs
                            .dirdp_req_vec_c6(dirdp_req_vec_c6[7:0]),
                            .dirdp_way_info_c7(dirdp_way_info_c7[2:0]),
                            .dirdp_inval_pckt_c7(dirdp_inval_pckt_c7[111:0]),
                            // Inputs
                            .ic_cam_hit (ic_cam_hit[127:0]),
                            .dc_cam_hit (dc_cam_hit[127:0]),
                            .tagdp_lkup_addr11_c5(tagdp_lkup_addr11_c5),
                            .sel_mux1_c6(sel_mux1_c6[3:0]),
                            .sel_mux2_c6(sel_mux2_c6[3:0]),
                            .sel_mux3_c6(sel_mux3_c6),
                            .mux_vec_sel_c6(mux_vec_sel_c6[3:0]),
                            .rclk       (rclk));

/*sctag_decc_ctl	AUTO_TEMPLATE(
                .bist_data_enable_c1(mbist_l2d_en),
                     .data_ecc_active_c3(decc_data_ecc_active_c3),
		.bist_data_waddr_c1(mbist_l2d_word_sel[1:0])) ;*/

sctag_decc_ctl	decc_ctl(.so	(scannet_53),
			 .si	(scannet_52),
			 .se	(scan_enable_0_buf_g),
			/*AUTOINST*/
                         // Outputs
                         .decc_bscd_corr_err_c8(decc_bscd_corr_err_c8),
                         .decc_bscd_uncorr_err_c8(decc_bscd_uncorr_err_c8),
                         .decc_spcd_corr_err_c8(decc_spcd_corr_err_c8),
                         .decc_spcd_uncorr_err_c8(decc_spcd_uncorr_err_c8),
                         .decc_scrd_corr_err_c8(decc_scrd_corr_err_c8),
                         .decc_scrd_uncorr_err_c8(decc_scrd_uncorr_err_c8),
                         .decc_spcfb_corr_err_c8(decc_spcfb_corr_err_c8),
                         .decc_spcfb_uncorr_err_c8(decc_spcfb_uncorr_err_c8),
                         .decc_uncorr_err_c8(decc_uncorr_err_c8),
                         .sel_higher_word_c7(sel_higher_word_c7),
                         .sel_higher_dword_c7(sel_higher_dword_c7),
                         .dword_sel_c7  (dword_sel_c7),
                         .retdp_err_c8  (retdp_err_c8[2:0]),
                         // Inputs
                         .tagctl_decc_addr3_c7(tagctl_decc_addr3_c7),
                         .arbctl_inst_l2data_vld_c6(arbctl_inst_l2data_vld_c6),
                         .data_ecc_active_c3(decc_data_ecc_active_c3), // Templated
                         .bist_data_enable_c1(mbist_l2d_en),     // Templated
                         .bist_data_waddr_c1(mbist_l2d_word_sel[1:0]), // Templated
                         .arbdp_addr22_c7(arbdp_addr22_c7),
                         .arbdp_waddr_c6(arbdp_waddr_c6[1:0]),
                         .error_ceen    (error_ceen),
                         .error_nceen   (error_nceen),
                         .tagctl_spc_rd_vld_c7(tagctl_spc_rd_vld_c7),
                         .tagctl_bsc_rd_vld_c7(tagctl_bsc_rd_vld_c7),
                         .tagctl_scrub_rd_vld_c7(tagctl_scrub_rd_vld_c7),
                         .fbctl_spc_corr_err_c7(fbctl_spc_corr_err_c7),
                         .fbctl_spc_uncorr_err_c7(fbctl_spc_uncorr_err_c7),
                         .fbctl_spc_rd_vld_c7(fbctl_spc_rd_vld_c7),
                         .rclk          (rclk),
                         .check0_c7     (check0_c7[5:0]),
                         .check1_c7     (check1_c7[5:0]),
                         .check2_c7     (check2_c7[5:0]),
                         .check3_c7     (check3_c7[5:0]),
                         .parity0_c7    (parity0_c7),
                         .parity1_c7    (parity1_c7),
                         .parity2_c7    (parity2_c7),
                         .parity3_c7    (parity3_c7));


sctag_deccdp		deccdp(

                       .so              (scannet_54),
                       .si              (scannet_53),
                       .se              (scan_enable_0_buf_g),
                       .retdp_data_c7   (retdp_data_c7[127:0]),
                       .retdp_ecc_c7    (retdp_ecc_c7[27:0]),
			/*AUTOINST*/
                       // Outputs
                       .retdp_data_c8   (retdp_data_c8[127:0]),
                       .deccdp_arbdp_data_c8(deccdp_arbdp_data_c8[63:0]),
                       .retdp_diag_data_c7(retdp_diag_data_c7[38:0]),
                       .lda_syndrome_c9 (lda_syndrome_c9[27:0]),
                       .check0_c7       (check0_c7[5:0]),
                       .check1_c7       (check1_c7[5:0]),
                       .check2_c7       (check2_c7[5:0]),
                       .check3_c7       (check3_c7[5:0]),
                       .parity0_c7      (parity0_c7),
                       .parity1_c7      (parity1_c7),
                       .parity2_c7      (parity2_c7),
                       .parity3_c7      (parity3_c7),
                       // Inputs
                       .sel_higher_word_c7(sel_higher_word_c7),
                       .sel_higher_dword_c7(sel_higher_dword_c7),
                       .dword_sel_c7    (dword_sel_c7),
                       .rclk            (rclk));

/*sctag_csr	AUTO_TEMPLATE(
                .dbginit_l(csr_dbginit_l)); */

sctag_csr	csr (
               .so                      (scannet_83),
               .si                      (scannet_82),
               .se                      (scan_enable_0_buf_h),
			.grst_l		(greset_l_0_buf_h),
			.arst_l		(areset_l_0_buf_h),
               .csr_bist_read_data      ({2'b0,csr_bist_read_data[10:0]}),
               .sctag_clk_tr            (sctag_clk_tr),
               /*AUTOINST*/
               // Outputs
               .csr_fbctl_scrub_ready   (csr_fbctl_scrub_ready),
               .l2_bypass_mode_on       (l2_bypass_mode_on),
               .csr_fbctl_l2off         (csr_fbctl_l2off),
               .csr_tagctl_l2off        (csr_tagctl_l2off),
               .csr_wbctl_l2off         (csr_wbctl_l2off),
               .csr_mbctl_l2off         (csr_mbctl_l2off),
               .csr_vuad_l2off          (csr_vuad_l2off),
               .l2_dir_map_on           (l2_dir_map_on),
               .l2_dbg_en               (l2_dbg_en),
               .l2_steering_tid         (l2_steering_tid[4:0]),
               .error_nceen             (error_nceen),
               .error_ceen              (error_ceen),
               .csr_wr_dirpinj_en       (csr_wr_dirpinj_en),
               .oneshot_dir_clear_c3    (oneshot_dir_clear_c3),
               .csr_rd_data_c8          (csr_rd_data_c8[63:0]),
               .error_status_veu        (error_status_veu),
               .error_status_vec        (error_status_vec),
               // Inputs
               .csr_inst_wr_data_c8     (csr_inst_wr_data_c8[63:0]),
               .dbginit_l               (csr_dbginit_l),         // Templated
               .rclk                    (rclk),
               .csr_erren_wr_en_c8      (csr_erren_wr_en_c8),
               .csr_ctl_wr_en_c8        (csr_ctl_wr_en_c8),
               .csr_errstate_wr_en_c8   (csr_errstate_wr_en_c8),
               .csr_errinj_wr_en_c8     (csr_errinj_wr_en_c8),
               .csr_rd_mux1_sel_c7      (csr_rd_mux1_sel_c7[3:0]),
               .csr_rd_mux2_sel_c7      (csr_rd_mux2_sel_c7),
               .csr_rd_mux3_sel_c7      (csr_rd_mux3_sel_c7[1:0]),
               .arbdp_csr_addr_c9       (arbdp_csr_addr_c9[39:4]),
               .evict_addr              (evict_addr[39:6]),
               .rdmard_addr_c12         (rdmard_addr_c12[39:6]),
               .dir_addr_c9             (dir_addr_c9[10:0]),
               .scrub_addr_way          (scrub_addr_way[3:0]),
               .data_ecc_idx            (data_ecc_idx[9:0]),
               .err_state_in_rw         (err_state_in_rw),
               .err_state_in_mec        (err_state_in_mec),
               .err_state_in_meu        (err_state_in_meu),
               .err_state_in            (err_state_in[`ERR_LDAC:`ERR_VEU]),
               .mux1_synd_sel           (mux1_synd_sel[1:0]),
               .mux2_synd_sel           (mux2_synd_sel[1:0]),
               .csr_synd_wr_en          (csr_synd_wr_en),
               .vuad_syndrome_c9        (vuad_syndrome_c9[3:0]),
               .lda_syndrome_c9         (lda_syndrome_c9[27:0]),
               .wr_enable_tid_c9        (wr_enable_tid_c9),
               .csr_tid_wr_en           (csr_tid_wr_en),
               .csr_async_wr_en         (csr_async_wr_en),
               .set_async_c9            (set_async_c9),
               .error_rw_en             (error_rw_en),
               .diag_wr_en              (diag_wr_en),
               .mux1_addr_sel           (mux1_addr_sel[3:0]),
               .mux2_addr_sel           (mux2_addr_sel[2:0]),
               .csr_addr_wr_en          (csr_addr_wr_en),
               .arbctl_dir_wr_en_c4     (arbctl_dir_wr_en_c4),
               .oqdp_tid_c8             (oqdp_tid_c8[4:0]));

sctag_csr_ctl	csr_ctl (
                    .rst_tri_en         (mux_drive_disable_0_buf_l),
                       .so              (scannet_81),
                       .si              (scannet_80),
                       .se              (scan_enable_0_buf_l),
			/*AUTOINST*/
                       // Outputs
                       .fbctl_decc_scrd_corr_err_c8(fbctl_decc_scrd_corr_err_c8),
                       .fbctl_decc_scrd_uncorr_err_c8(fbctl_decc_scrd_uncorr_err_c8),
                       .mbctl_decc_spcfb_corr_err_c8(mbctl_decc_spcfb_corr_err_c8),
                       .mbctl_decc_spcd_corr_err_c8(mbctl_decc_spcd_corr_err_c8),
                       .fbctl_decc_bscd_corr_err_c8(fbctl_decc_bscd_corr_err_c8),
                       .fbctl_decc_bscd_uncorr_err_c8(fbctl_decc_bscd_uncorr_err_c8),
                       .arbctl_data_ecc_active_c3(arbctl_data_ecc_active_c3),
                       .decc_data_ecc_active_c3(decc_data_ecc_active_c3),
                       .tagdp_l2_dir_map_on(tagdp_l2_dir_map_on),
                       .mbctl_l2_dir_map_on(mbctl_l2_dir_map_on),
                       .fbctl_l2_dir_map_on(fbctl_l2_dir_map_on),
                       .arbctl_dbginit_l(arbctl_dbginit_l),
                       .mbctl_dbginit_l (mbctl_dbginit_l),
                       .fbctl_dbginit_l (fbctl_dbginit_l),
                       .tagctl_dbginit_l(tagctl_dbginit_l),
                       .tagdp_ctl_dbginit_l(tagdp_ctl_dbginit_l),
                       .csr_dbginit_l   (csr_dbginit_l),
                       .wbctl_dbginit_l (wbctl_dbginit_l),
                       .csr_ctl_wr_en_c8(csr_ctl_wr_en_c8),
                       .csr_erren_wr_en_c8(csr_erren_wr_en_c8),
                       .csr_errstate_wr_en_c8(csr_errstate_wr_en_c8),
                       .csr_errinj_wr_en_c8(csr_errinj_wr_en_c8),
                       .err_state_in_rw (err_state_in_rw),
                       .err_state_in_mec(err_state_in_mec),
                       .err_state_in_meu(err_state_in_meu),
                       .err_state_in    (err_state_in[`ERR_LDAC:`ERR_VEU]),
                       .csr_synd_wr_en  (csr_synd_wr_en),
                       .mux1_synd_sel   (mux1_synd_sel[1:0]),
                       .mux2_synd_sel   (mux2_synd_sel[1:0]),
                       .wr_enable_tid_c9(wr_enable_tid_c9),
                       .csr_tid_wr_en   (csr_tid_wr_en),
                       .csr_async_wr_en (csr_async_wr_en),
                       .set_async_c9    (set_async_c9),
                       .error_rw_en     (error_rw_en),
                       .diag_wr_en      (diag_wr_en),
                       .mux1_addr_sel   (mux1_addr_sel[3:0]),
                       .mux2_addr_sel   (mux2_addr_sel[2:0]),
                       .csr_addr_wr_en  (csr_addr_wr_en),
                       .csr_rd_mux1_sel_c7(csr_rd_mux1_sel_c7[3:0]),
                       .csr_rd_mux2_sel_c7(csr_rd_mux2_sel_c7),
                       .csr_rd_mux3_sel_c7(csr_rd_mux3_sel_c7[1:0]),
                       .sctag_por_req   (sctag_por_req),
                       .csr_bist_wr_en_c8(csr_bist_wr_en_c8),
                       // Inputs
                       .arbctl_csr_wr_en_c7(arbctl_csr_wr_en_c7),
                       .arbdp_word_addr_c6(arbdp_word_addr_c6[2:0]),
                       .rclk            (rclk),
                       .vuad_error_c8   (vuad_error_c8),
                       .dir_error_c8    (dir_error_c8),
                       .decc_spcd_corr_err_c8(decc_spcd_corr_err_c8),
                       .decc_spcd_uncorr_err_c8(decc_spcd_uncorr_err_c8),
                       .decc_scrd_corr_err_c8(decc_scrd_corr_err_c8),
                       .decc_scrd_uncorr_err_c8(decc_scrd_uncorr_err_c8),
                       .decc_spcfb_corr_err_c8(decc_spcfb_corr_err_c8),
                       .decc_spcfb_uncorr_err_c8(decc_spcfb_uncorr_err_c8),
                       .decc_bscd_corr_err_c8(decc_bscd_corr_err_c8),
                       .decc_bscd_uncorr_err_c8(decc_bscd_uncorr_err_c8),
                       .tag_error_c8    (tag_error_c8),
                       .data_ecc_active_c3(data_ecc_active_c3),
                       .l2_dir_map_on   (l2_dir_map_on),
                       .dbginit_l       (dbginit_l),
                       .dram_scb_secc_err_d1(dram_scb_secc_err_d1),
                       .dram_scb_mecc_err_d1(dram_scb_mecc_err_d1),
                       .fbctl_uncorr_err_c8(fbctl_uncorr_err_c8),
                       .fbctl_corr_err_c8(fbctl_corr_err_c8),
                       .fbctl_bsc_corr_err_c12(fbctl_bsc_corr_err_c12),
                       .fbctl_ld64_fb_hit_c12(fbctl_ld64_fb_hit_c12),
                       .ev_uerr_r6      (ev_uerr_r6),
                       .ev_cerr_r6      (ev_cerr_r6),
                       .rdmard_uerr_c12 (rdmard_uerr_c12),
                       .rdmard_cerr_c12 (rdmard_cerr_c12),
                       .error_status_vec(error_status_vec),
                       .error_status_veu(error_status_veu),
                       .store_err_c8    (store_err_c8),
                       .arbdp_async_bit_c8(arbdp_async_bit_c8),
                       .str_ld_hit_c7   (str_ld_hit_c7));


sctag_snpctl	snpctl(
                     .so                (scannet_69),
                     .si                (scannet_68),
                     .se                (scan_enable_0_buf_i),
                     .rdmatag_wr_en_s2  (rdmatag_wr_en_s2),
			.grst_l		(greset_l_0_buf_i),
			.arst_l		(areset_l_0_buf_i),
                     .jbi_req_vld_buf   (jbi_sctag_req_vld),
			/*AUTOINST*/
                     // Outputs
                     .sctag_jbi_por_req (sctag_jbi_por_req),
                     .sctag_jbi_iq_dequeue(sctag_jbi_iq_dequeue),
                     .snpq_arbctl_vld_px1(snpq_arbctl_vld_px1),
                     .snp_hdr1_wen0_s0  (snp_hdr1_wen0_s0),
                     .snp_hdr2_wen0_s1  (snp_hdr2_wen0_s1),
                     .snp_data1_wen0_s2 (snp_data1_wen0_s2),
                     .snp_data2_wen0_s3 (snp_data2_wen0_s3),
                     .snp_hdr1_wen1_s0  (snp_hdr1_wen1_s0),
                     .snp_hdr2_wen1_s1  (snp_hdr2_wen1_s1),
                     .snp_data1_wen1_s2 (snp_data1_wen1_s2),
                     .snp_data2_wen1_s3 (snp_data2_wen1_s3),
                     .snpctl_wr_ptr     (snpctl_wr_ptr),
                     .snpctl_rd_ptr     (snpctl_rd_ptr),
                     .rdmad_wr_entry_s2 (rdmad_wr_entry_s2[1:0]),
                     .sctag_scbuf_rdma_wren_s2(sctag_scbuf_rdma_wren_s2[15:0]),
                     .sctag_scbuf_rdma_wrwl_s2(sctag_scbuf_rdma_wrwl_s2[1:0]),
                     // Inputs
                     .arbctl_snpsel_c1  (arbctl_snpsel_c1),
                     .snpdp_rq_winv_s1  (snpdp_rq_winv_s1),
                     .rdmat_wr_entry_s1 (rdmat_wr_entry_s1[1:0]),
                     .sctag_por_req     (sctag_por_req),
                     .rclk              (rclk));


sctag_snpdp	snpdp(
                  .so                   (scannet_67),
                  .si                   (scannet_66),
                  .se                   (scan_enable_0_buf_i),
                  .rdmatag_wr_addr_s2   (rdmatag_wr_addr_s2[39:6]),
                  .snpq_arbdp_inst_px2  (snpq_arbdp_inst_px2[`JBI_HDR_SZ-1:0]),
                  .jbi_req_buf          (jbi_sctag_req[31:0]),
		  /*AUTOINST*/
                  // Outputs
                  .snpq_arbdp_addr_px2  (snpq_arbdp_addr_px2[39:0]),
                  .snpq_arbdp_data_px2  (snpq_arbdp_data_px2[63:0]),
                  .snpdp_rq_winv_s1     (snpdp_rq_winv_s1),
                  // Inputs
                  .rclk                 (rclk),
                  .snp_hdr1_wen0_s0     (snp_hdr1_wen0_s0),
                  .snp_hdr2_wen0_s1     (snp_hdr2_wen0_s1),
                  .snp_data1_wen0_s2    (snp_data1_wen0_s2),
                  .snp_data2_wen0_s3    (snp_data2_wen0_s3),
                  .snp_hdr1_wen1_s0     (snp_hdr1_wen1_s0),
                  .snp_hdr2_wen1_s1     (snp_hdr2_wen1_s1),
                  .snp_data1_wen1_s2    (snp_data1_wen1_s2),
                  .snp_data2_wen1_s3    (snp_data2_wen1_s3),
                  .snpctl_wr_ptr        (snpctl_wr_ptr),
                  .snpctl_rd_ptr        (snpctl_rd_ptr),
                  .rdmad_wr_entry_s2    (rdmad_wr_entry_s2[1:0]));


/* sctag_evicttag_dp	AUTO_TEMPLATE (
			.tagdp_evict_tag_c4(tagdp_evict_tag_c4_buf[`TAG_WIDTH-1:6]));
*/

sctag_evicttag_dp	evicttag(
                           .so          (scannet_76),
                           .si          (scannet_75),
                           .se          (scan_enable_0_buf_k),
                           .sehold      (sehold_0_buf_k),
                           .wb_read_data(wb_read_data[39:6]),
                           .rdma_read_data(rdma_read_data[39:6]),
                           .lkup_addr_c1(lkup_addr_c1[39:8]),
                           .mb_write_addr(mb_write_addr[39:0]),
                           .wb_write_addr(wb_write_addr[39:0]),
                           /*AUTOINST*/
                           // Outputs
                           .evicttag_addr_px2(evicttag_addr_px2[39:0]),
                           .evict_addr  (evict_addr[39:6]),
                           .sctag_dram_addr(sctag_dram_addr[39:5]),
                           .vuad_idx_c3 (vuad_idx_c3[9:0]),
                           // Inputs
                           .mb_read_data(mb_read_data[39:0]),
                           .fb_read_data(fb_read_data[39:0]),
                           .arbdp_cam_addr_px2(arbdp_cam_addr_px2[39:0]),
                           .tagdp_evict_tag_c4(tagdp_evict_tag_c4_buf[`TAG_WIDTH-1:6]), // Templated
                           .wbctl_wr_addr_sel(wbctl_wr_addr_sel),
                           .wb_or_rdma_wr_req_en(wb_or_rdma_wr_req_en),
                           .mbctl_arb_l2rd_en(mbctl_arb_l2rd_en),
                           .mbctl_arb_dramrd_en(mbctl_arb_dramrd_en),
                           .fbctl_arb_l2rd_en(fbctl_arb_l2rd_en),
                           .mux1_mbsel_px1(mux1_mbsel_px1),
                           .arbctl_evict_c4(arbctl_evict_c4),
                           .rclk        (rclk));

bw_r_cm16x40b       rdmatag   ( .dout(rdma_read_data[39:0]),
                .match(rdmat_cam_match_c2[15:0]),
                .match_idx(),
                .adr_w({12'b0, rdmat_wr_wl_s2[3:0]}),
                .din({rdmatag_wr_addr_s2[39:6],6'b0}), 
                .write_en(rdmatag_wr_en_s2),
                .adr_r({12'b0,rdmat_read_wl[3:0]}),
                .lookup_en(arbctl_inst_vld_c1),
                .key(lkup_addr_c1[39:8]),
                .rst_tri_en(mem_write_disable_0_buf_k),
                .rclk(rclk),
                .read_en(rdmat_read_en),
		.sehold(sehold_0_buf_k),
                .se(scan_enable_0_buf_k),
                .si(scannet_69),
                .so(scannet_70),
                .rst_l(areset_l_0_buf_k));


sctag_rdmatctl	 rdmatctl(
                          .so           (scannet_73),
                          .si           (scannet_72),
                    .rst_tri_en         (mux_drive_disable_0_buf_k),
                          .se           (scan_enable_0_buf_k),
                          .rdmatag_wr_en_s2(rdmatag_wr_en_s2),
                          .rdmat_cam_match_c2(rdmat_cam_match_c2[3:0]),
                          .rdmat_wr_wl_s2(rdmat_wr_wl_s2[3:0]),
			.grst_l		(greset_l_0_buf_k),
			.arst_l		(areset_l_0_buf_k),
				/*AUTOINST*/
                          // Outputs
                          .rdmat_wr_entry_s1(rdmat_wr_entry_s1[1:0]),
                          .or_rdmat_valid(or_rdmat_valid),
                          .rdmat_pick_vec(rdmat_pick_vec[3:0]),
                          .rdmatctl_hit_unqual_c2(rdmatctl_hit_unqual_c2),
                          .rdmatctl_mbctl_dep_rdy_en(rdmatctl_mbctl_dep_rdy_en),
                          .rdmatctl_mbctl_dep_mbid(rdmatctl_mbctl_dep_mbid[3:0]),
                          .sctag_scbuf_fbwr_wl_r2(sctag_scbuf_fbwr_wl_r2[2:0]),
                          .sctag_scbuf_fbrd_en_c3(sctag_scbuf_fbrd_en_c3),
                          .sctag_scbuf_fbrd_wl_c3(sctag_scbuf_fbrd_wl_c3[2:0]),
                          .sctag_scbuf_word_vld_c7(sctag_scbuf_word_vld_c7),
                          .sctag_scbuf_ctag_en_c7(sctag_scbuf_ctag_en_c7),
                          .sctag_scbuf_req_en_c7(sctag_scbuf_req_en_c7),
                          .sctag_scbuf_word_c7(sctag_scbuf_word_c7[3:0]),
                          .rdmard_cerr_c12(rdmard_cerr_c12),
                          .rdmard_uerr_c12(rdmard_uerr_c12),
                          .ev_uerr_r6   (ev_uerr_r6),
                          .ev_cerr_r6   (ev_cerr_r6),
                          .sctag_scbuf_fbwr_wen_r2(sctag_scbuf_fbwr_wen_r2[15:0]),
                          .sctag_scbuf_fbd_stdatasel_c3(sctag_scbuf_fbd_stdatasel_c3),
                          .sctag_scbuf_ctag_c7(sctag_scbuf_ctag_c7[14:0]),
                          // Inputs
                          .reset_rdmat_vld(reset_rdmat_vld[3:0]),
                          .set_rdmat_acked(set_rdmat_acked[3:0]),
                          .arbctl_wbctl_inst_vld_c2(arbctl_wbctl_inst_vld_c2),
                          .arbctl_wbctl_hit_off_c1(arbctl_wbctl_hit_off_c1),
                          .arbdp_rdma_entry_c3(arbdp_rdma_entry_c3[1:0]),
                          .mbctl_wbctl_mbid_c4(mbctl_wbctl_mbid_c4[3:0]),
                          .mbctl_hit_c4 (mbctl_hit_c4),
                          .tagctl_rdma_ev_en_c4(tagctl_rdma_ev_en_c4),
                          .scbuf_fbd_stdatasel_c3(scbuf_fbd_stdatasel_c3),
                          .scbuf_fbwr_wen_r2(scbuf_fbwr_wen_r2[15:0]),
                          .rclk         (rclk),
                          .scbuf_sctag_rdma_cerr_c10(scbuf_sctag_rdma_cerr_c10),
                          .scbuf_sctag_rdma_uerr_c10(scbuf_sctag_rdma_uerr_c10),
                          .scbuf_sctag_ev_uerr_r5(scbuf_sctag_ev_uerr_r5),
                          .scbuf_sctag_ev_cerr_r5(scbuf_sctag_ev_cerr_r5),
                          .arbdec_ctag_c6(arbdec_ctag_c6[14:0]),
                          .tagctl_inc_rdma_cnt_c4(tagctl_inc_rdma_cnt_c4),
                          .tagctl_set_rdma_reg_vld_c4(tagctl_set_rdma_reg_vld_c4),
                          .tagctl_jbi_req_en_c6(tagctl_jbi_req_en_c6),
                          .arbdp_rdmatctl_addr_c6(arbdp_rdmatctl_addr_c6[5:2]),
                          .fbctl_fbd_rd_en_c2(fbctl_fbd_rd_en_c2),
                          .fbctl_fbd_rd_entry_c2(fbctl_fbd_rd_entry_c2[2:0]),
                          .fbctl_fbd_wr_entry_r1(fbctl_fbd_wr_entry_r1[2:0]));


sctag_dbgdp		dbgdp(
				.so           (scannet_68),
                          	.si           (scannet_67),
                          	.se           (scan_enable_0_buf_i),
                    .arbdp_dbg_addr_c3  ({dir_cam_addr_c3[33:8], arbdp_dbg_addr_c3[5:2]}),
				/*AUTOINST*/
                    // Outputs
                    .sctag_dbgbus_out   (sctag_dbgbus_out[40:0]),
                    // Inputs
                    .arbdec_dbgdp_inst_c3(arbdec_dbgdp_inst_c3[8:0]),
                    .arbctl_dbgdp_inst_vld_c3(arbctl_dbgdp_inst_vld_c3),
                    .l2_dbg_en          (l2_dbg_en),
                    .rclk               (rclk));


sctag_retbuf		retbuf1(
                        // Outputs
                        .retdp_data_c7  (retdp_data_c6_tmp[127:0]),
                        .retdp_ecc_c7   (retdp_ecc_c6_tmp[27:0]),
                        // Inputs
                        .retdp_data_c7_buf({scdata_sctag_decc_c6[155:124],scdata_sctag_decc_c6[116:85],scdata_sctag_decc_c6[77:46],scdata_sctag_decc_c6[38:7]}),
                        .retdp_ecc_c7_buf({scdata_sctag_decc_c6[123:117],scdata_sctag_decc_c6[84:78],scdata_sctag_decc_c6[45:39],scdata_sctag_decc_c6[6:0]}));

sctag_retdp		retdp(
				.so           (scannet_82),
                          	.si           (scannet_81),
                          	.se           (scan_enable_0_buf_h),
                    // Outputs
                    .retdp_data_c7_buf  (retdp_data_c7_buf[127:0]),
                    .retdp_ecc_c7_buf   (retdp_ecc_c7_buf[27:0]),
                    // Inputs
                    .scdata_sctag_decc_c6({retdp_data_c6_tmp[127:96],retdp_ecc_c6_tmp[27:21],retdp_data_c6_tmp[95:64],retdp_ecc_c6_tmp[20:14],retdp_data_c6_tmp[63:32],retdp_ecc_c6_tmp[13:7],retdp_data_c6_tmp[31:0],retdp_ecc_c6_tmp[6:0]}),
                    .rclk               (rclk));


sctag_retbuf		retbuf2(
                        // Outputs
                        .retdp_data_c7  (retdp_data_c7[127:0]),
                        .retdp_ecc_c7   (retdp_ecc_c7[27:0]),
                        // Inputs
                        .retdp_data_c7_buf(retdp_data_c7_buf[127:0]),
                        .retdp_ecc_c7_buf(retdp_ecc_c7_buf[27:0]));



sctag_scbufrep		scbufrep(
                           .so          (scannet_71),
                           .si          (scannet_70),
                           .se          (scan_enable_0_buf_k),
				/*AUTOINST*/
                           // Outputs
                           .sctag_scbuf_stdecc_c3(sctag_scbuf_stdecc_c3[77:0]),
                           // Inputs
                           .rep_store_data_c2(rep_store_data_c2[77:0]),
                           .rclk        (rclk));

sctag_dirrep		dirrep(
                           .so          (scannet_57),
                           .si          (scannet_56),
                           .se          (scan_enable_0_buf_h),
                           .sehold          (sehold_0_buf_h),
				/*AUTOINST*/
                       // Outputs
                       .dirrep_dir_wr_par_c4(dirrep_dir_wr_par_c4),
                       .dir_vld_c4_l    (dir_vld_c4_l),
                       .dc_rd_en_c4     (dc_rd_en_c4),
                       .dc_wr_en_c4     (dc_wr_en_c4),
                       .inval_mask_dcd_c4(inval_mask_dcd_c4[7:0]),
                       .dc_rdwr_row_en_c4(dc_rdwr_row_en_c4[3:0]),
                       .dc_rdwr_panel_dec_c4(dc_rdwr_panel_dec_c4[3:0]),
                       .dc_lkup_row_dec_c4(dc_lkup_row_dec_c4[3:0]),
                       .dc_lkup_panel_dec_c4(dc_lkup_panel_dec_c4[3:0]),
                       .wr_dc_dir_entry_c4(wr_dc_dir_entry_c4[5:0]),
                       .dc_dir_clear_c4 (dc_dir_clear_c4),
                       .ic_rd_en_c4     (ic_rd_en_c4),
                       .ic_wr_en_c4     (ic_wr_en_c4),
                       .inval_mask_icd_c4(inval_mask_icd_c4[7:0]),
                       .ic_rdwr_row_en_c4(ic_rdwr_row_en_c4[3:0]),
                       .ic_rdwr_panel_dec_c4(ic_rdwr_panel_dec_c4[3:0]),
                       .ic_lkup_row_dec_c4(ic_lkup_row_dec_c4[3:0]),
                       .ic_lkup_panel_dec_c4(ic_lkup_panel_dec_c4[3:0]),
                       .wr_ic_dir_entry_c4(wr_ic_dir_entry_c4[5:0]),
                       .ic_dir_clear_c4 (ic_dir_clear_c4),
                       .lkup_addr8_c4   (lkup_addr8_c4),
                       .dir_error_c8    (dir_error_c8),
                       .tagdp_lkup_addr11_c5(tagdp_lkup_addr11_c5),
                       // Inputs
                       .ic_parity_out   (ic_parity_out[3:0]),
                       .dc_parity_out   (dc_parity_out[3:0]),
                       .arbdp_dir_wr_par_c3(arbdp_dir_wr_par_c3),
                       .arbctl_dir_vld_c3_l(arbctl_dir_vld_c3_l),
                       .arbctl_ic_rd_en_c3(arbctl_ic_rd_en_c3),
                       .arbctl_dc_rd_en_c3(arbctl_dc_rd_en_c3),
                       .arbctl_ic_wr_en_c3(arbctl_ic_wr_en_c3),
                       .arbctl_dc_wr_en_c3(arbctl_dc_wr_en_c3),
                       .arbctl_dir_panel_dcd_c3(arbctl_dir_panel_dcd_c3[4:0]),
                       .arbctl_dir_panel_icd_c3(arbctl_dir_panel_icd_c3[4:0]),
                       .arbctl_lkup_bank_ena_dcd_c3(arbctl_lkup_bank_ena_dcd_c3[3:0]),
                       .arbctl_lkup_bank_ena_icd_c3(arbctl_lkup_bank_ena_icd_c3[3:0]),
                       .arbctl_inval_mask_dcd_c3(arbctl_inval_mask_dcd_c3[7:0]),
                       .arbctl_inval_mask_icd_c3(arbctl_inval_mask_icd_c3[7:0]),
                       .arbctl_wr_dc_dir_entry_c3(arbctl_wr_dc_dir_entry_c3[4:0]),
                       .arbctl_wr_ic_dir_entry_c3(arbctl_wr_ic_dir_entry_c3[4:0]),
                       .lkup_row_addr_dcd_c3(lkup_row_addr_dcd_c3[2:0]),
                       .lkup_row_addr_icd_c3(lkup_row_addr_icd_c3[2:0]),
                       .oneshot_dir_clear_c3(oneshot_dir_clear_c3),
                       .tagdp_lkup_addr11_c4(tagdp_lkup_addr11_c4),
                       .rclk            (rclk));


///////////////////////////
// VUAD array coded here
///////////////////////////



// ROW 0
/*	bw_r_rf32x108	AUTO_TEMPLATE(
                           // Outputs
                           .dout        (data_in_h_r@[107:0]),
                           // Inputs
                           .din         ( {4'b0,write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[26],write_data_top[26],write_data_top[26],write_data_top[26]}),
                           .rd_adr1     (rd_addr1_r@[4:0]),
                           .rd_adr2     (rd_addr2_r@[4:0]),
                           .sel_rdaddr1 (rd_addr_sel_r@),
                           .wr_adr      (wr_addr_r@[4:0]),
                           .read_en     (rd_en_r@),
                           .wr_en       (wr_en_r@c0),
                           .word_wen    (word_en_r@[3:0])); */


	bw_r_rf32x108 	subarray_0(
                             .so        (scannet_93),                      
                             .rst_tri_en(mem_write_disable_0_buf_m),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_m),
                             .si        (scannet_92_a_rep1),
                             .reset_l   (areset_l_0_buf_m),
                             .sehold(sehold_0_buf_m),
			/*AUTOINST*/
                             // Outputs
                             .dout      (data_in_h_r0[107:0]),   // Templated
                             // Inputs
                             .din       ( {4'b0,write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[26],write_data_top[26],write_data_top[26],write_data_top[26]}), // Templated
                             .rd_adr1   (rd_addr1_r0[4:0]),      // Templated
                             .rd_adr2   (rd_addr2_r0[4:0]),      // Templated
                             .sel_rdaddr1(rd_addr_sel_r0),       // Templated
                             .wr_adr    (wr_addr_r0[4:0]),       // Templated
                             .read_en   (rd_en_r0),              // Templated
                             .wr_en     (wr_en_r0c0),            // Templated
                             .word_wen  (word_en_r0[3:0]));       // Templated

/*
	sctag_vuadcol_dp	AUTO_TEMPLATE(
                              .mux1_h_sel(mux1_h_sel_r@[3:0]),
                              .mux1_l_sel(mux1_l_sel_r@[3:0]),
                              .mux2_sel (mux2_sel_r@),
			      .data_out_col(data_out_col_r@[25:0]),
			.data_in_h(data_in_h_r@[103:0]),
			.data_in_l(data_in_h_r@"(+ 1 @)"[103:0]));
*/

	sctag_vuadcol_dp  vuadcol_0(/*AUTOINST*/
                              // Outputs
                              .data_out_col(data_out_col_r0[25:0]), // Templated
                              // Inputs
                              .data_in_l(data_in_h_r1[103:0]),   // Templated
                              .data_in_h(data_in_h_r0[103:0]),   // Templated
                              .mux1_h_sel(mux1_h_sel_r0[3:0]),   // Templated
                              .mux1_l_sel(mux1_l_sel_r0[3:0]),   // Templated
                              .mux2_sel (mux2_sel_r0));           // Templated

	bw_r_rf32x108 	subarray_1(
                             .so        (scannet_94),                      
                             .rst_tri_en(mem_write_disable_0_buf_m),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_m),
                             .si        (scannet_93),
                             .reset_l   (areset_l_0_buf_m),
                             .sehold(sehold_0_buf_m),
                                /*AUTOINST*/
                             // Outputs
                             .dout      (data_in_h_r1[107:0]),   // Templated
                             // Inputs
                             .din       ( {4'b0,write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[26],write_data_top[26],write_data_top[26],write_data_top[26]}), // Templated
                             .rd_adr1   (rd_addr1_r1[4:0]),      // Templated
                             .rd_adr2   (rd_addr2_r1[4:0]),      // Templated
                             .sel_rdaddr1(rd_addr_sel_r1),       // Templated
                             .wr_adr    (wr_addr_r1[4:0]),       // Templated
                             .read_en   (rd_en_r1),              // Templated
                             .wr_en     (wr_en_r1c0),            // Templated
                             .word_wen  (word_en_r1[3:0]));       // Templated



// ROW 2

	bw_r_rf32x108 	subarray_2(
			     .so        (scannet_95),
                             .rst_tri_en(mem_write_disable_1_buf_m),
                             .rclk      (rclk),
                             .se        (scan_enable_1_buf_m),
                             .si        (scannet_94),
                             .reset_l   (areset_l_1_buf_m),
                             .sehold(sehold_1_buf_m),
			      /*AUTOINST*/
                             // Outputs
                             .dout      (data_in_h_r2[107:0]),   // Templated
                             // Inputs
                             .din       ( {4'b0,write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[26],write_data_top[26],write_data_top[26],write_data_top[26]}), // Templated
                             .rd_adr1   (rd_addr1_r2[4:0]),      // Templated
                             .rd_adr2   (rd_addr2_r2[4:0]),      // Templated
                             .sel_rdaddr1(rd_addr_sel_r2),       // Templated
                             .wr_adr    (wr_addr_r2[4:0]),       // Templated
                             .read_en   (rd_en_r2),              // Templated
                             .wr_en     (wr_en_r2c0),            // Templated
                             .word_wen  (word_en_r2[3:0]));       // Templated
	sctag_vuadcol_dp  vuadcol_2(/*AUTOINST*/
                              // Outputs
                              .data_out_col(data_out_col_r2[25:0]), // Templated
                              // Inputs
                              .data_in_l(data_in_h_r3[103:0]),   // Templated
                              .data_in_h(data_in_h_r2[103:0]),   // Templated
                              .mux1_h_sel(mux1_h_sel_r2[3:0]),   // Templated
                              .mux1_l_sel(mux1_l_sel_r2[3:0]),   // Templated
                              .mux2_sel (mux2_sel_r2));           // Templated
	bw_r_rf32x108 	subarray_3(
			     .so        (scannet_96),
                             .rst_tri_en(mem_write_disable_1_buf_m),
                             .rclk      (rclk),
                             .se        (scan_enable_1_buf_m),
                             .si        (scannet_95),
                             .reset_l   (areset_l_1_buf_m),
                             .sehold(sehold_1_buf_m),
			/*AUTOINST*/
                             // Outputs
                             .dout      (data_in_h_r3[107:0]),   // Templated
                             // Inputs
                             .din       ( {4'b0,write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[51],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[50],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[49],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[48],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[47],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[46],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[45],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[44],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[43],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[42],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[41],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[40],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[39],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[38],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[37],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[36],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[35],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[34],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[33],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[32],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[31],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[30],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[29],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[28],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[27],write_data_top[26],write_data_top[26],write_data_top[26],write_data_top[26]}), // Templated
                             .rd_adr1   (rd_addr1_r3[4:0]),      // Templated
                             .rd_adr2   (rd_addr2_r3[4:0]),      // Templated
                             .sel_rdaddr1(rd_addr_sel_r3),       // Templated
                             .wr_adr    (wr_addr_r3[4:0]),       // Templated
                             .read_en   (rd_en_r3),              // Templated
                             .wr_en     (wr_en_r3c0),            // Templated
                             .word_wen  (word_en_r3[3:0]));       // Templated

/*
	sctag_vuad_io	AUTO_TEMPLATE(
		.data_out_col1(data_out_col_r0[25:0]),
		.data_out_col2(data_out_col_r2[25:0]),
		.data_out_col3(data_out_col_r4[25:0]),
		.data_out_col4(data_out_col_r6[25:0]),
		.array_data_in(vuad_array_wr_data_c4[51:26]),
                .data_out_io  (vuad_array_rd_data_c1[51:26])) ;
*/


	sctag_vuad_io 	io_left(
                           .array_data_in_buf_bottom(write_data_bottom[51:26]), 
                           .array_data_in_buf_top(write_data_top[51:26]), 
                           /*AUTOINST*/
                          // Outputs
                          .data_out_io  (vuad_array_rd_data_c1[51:26]), // Templated
                          // Inputs
                          .data_out_col1(data_out_col_r0[25:0]), // Templated
                          .data_out_col2(data_out_col_r2[25:0]), // Templated
                          .data_out_col3(data_out_col_r4[25:0]), // Templated
                          .data_out_col4(data_out_col_r6[25:0]), // Templated
                          .array_data_in(vuad_array_wr_data_c4[51:26]), // Templated
                          .mux_sel      (mux_sel[3:0]));

/*	bw_r_rf32x108	AUTO_TEMPLATE(
                           // Outputs
                           .dout        (data_in_h_r@[107:0]),
                           // Inputs
                           .din         ( {4'b0,write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26]}),
                           .rd_adr1     (rd_addr1_r@[4:0]),
                           .rd_adr2     (rd_addr2_r@[4:0]),
                           .sel_rdaddr1 (rd_addr_sel_r@),
                           .wr_adr      (wr_addr_r@[4:0]),
                           .read_en     (rd_en_r@),
                           .wr_en       (wr_en_r@c0),
                           .word_wen    (word_en_r@[3:0])); */


// ROw 4 

        bw_r_rf32x108   subarray_4(
			     .so        (scannet_97),                      
                             .rst_tri_en(mem_write_disable_0_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_n),
                             .si        (scannet_96),
                             .reset_l   (areset_l_0_buf_n),
                             .sehold(sehold_0_buf_n),
                              /*AUTOINST*/
                                   // Outputs
                                   .dout(data_in_h_r4[107:0]),   // Templated
                                   // Inputs
                                   .din ( {4'b0,write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26]}), // Templated
                                   .rd_adr1(rd_addr1_r4[4:0]),   // Templated
                                   .rd_adr2(rd_addr2_r4[4:0]),   // Templated
                                   .sel_rdaddr1(rd_addr_sel_r4), // Templated
                                   .wr_adr(wr_addr_r4[4:0]),     // Templated
                                   .read_en(rd_en_r4),           // Templated
                                   .wr_en(wr_en_r4c0),           // Templated
                                   .word_wen(word_en_r4[3:0]));   // Templated
        sctag_vuadcol_dp  vuadcol_4(/*AUTOINST*/
                                    // Outputs
                                    .data_out_col(data_out_col_r4[25:0]), // Templated
                                    // Inputs
                                    .data_in_l(data_in_h_r5[103:0]), // Templated
                                    .data_in_h(data_in_h_r4[103:0]), // Templated
                                    .mux1_h_sel(mux1_h_sel_r4[3:0]), // Templated
                                    .mux1_l_sel(mux1_l_sel_r4[3:0]), // Templated
                                    .mux2_sel(mux2_sel_r4));      // Templated
        bw_r_rf32x108   subarray_5(
			     .so        (scannet_98),                      
                             .rst_tri_en(mem_write_disable_0_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_n),
                             .si        (scannet_97),
                             .reset_l   (areset_l_0_buf_n),
                             .sehold(sehold_0_buf_n),
                              /*AUTOINST*/
                                   // Outputs
                                   .dout(data_in_h_r5[107:0]),   // Templated
                                   // Inputs
                                   .din ( {4'b0,write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26]}), // Templated
                                   .rd_adr1(rd_addr1_r5[4:0]),   // Templated
                                   .rd_adr2(rd_addr2_r5[4:0]),   // Templated
                                   .sel_rdaddr1(rd_addr_sel_r5), // Templated
                                   .wr_adr(wr_addr_r5[4:0]),     // Templated
                                   .read_en(rd_en_r5),           // Templated
                                   .wr_en(wr_en_r5c0),           // Templated
                                   .word_wen(word_en_r5[3:0]));   // Templated


// Row 6 
        bw_r_rf32x108   subarray_6(
			     .so        (scannet_99),                      
                             .rst_tri_en(mem_write_disable_1_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_1_buf_n),
                             .si        (scannet_98),
                             .reset_l   (areset_l_1_buf_n),
                             .sehold(sehold_1_buf_n),
                              /*AUTOINST*/
                                   // Outputs
                                   .dout(data_in_h_r6[107:0]),   // Templated
                                   // Inputs
                                   .din ( {4'b0,write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26]}), // Templated
                                   .rd_adr1(rd_addr1_r6[4:0]),   // Templated
                                   .rd_adr2(rd_addr2_r6[4:0]),   // Templated
                                   .sel_rdaddr1(rd_addr_sel_r6), // Templated
                                   .wr_adr(wr_addr_r6[4:0]),     // Templated
                                   .read_en(rd_en_r6),           // Templated
                                   .wr_en(wr_en_r6c0),           // Templated
                                   .word_wen(word_en_r6[3:0]));   // Templated
        sctag_vuadcol_dp  vuadcol_6(/*AUTOINST*/
                                    // Outputs
                                    .data_out_col(data_out_col_r6[25:0]), // Templated
                                    // Inputs
                                    .data_in_l(data_in_h_r7[103:0]), // Templated
                                    .data_in_h(data_in_h_r6[103:0]), // Templated
                                    .mux1_h_sel(mux1_h_sel_r6[3:0]), // Templated
                                    .mux1_l_sel(mux1_l_sel_r6[3:0]), // Templated
                                    .mux2_sel(mux2_sel_r6));      // Templated
        bw_r_rf32x108   subarray_7(
			     .so        (scannet_100),                      
                             .rst_tri_en(mem_write_disable_1_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_1_buf_n),
                             .si        (scannet_99),
                             .reset_l   (areset_l_1_buf_n),
                             .sehold(sehold_1_buf_n),
					/*AUTOINST*/
                                   // Outputs
                                   .dout(data_in_h_r7[107:0]),   // Templated
                                   // Inputs
                                   .din ( {4'b0,write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[51],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[50],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[49],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[48],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[47],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[46],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[45],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[44],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[43],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[42],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[41],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[40],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[39],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[38],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[37],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[36],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[35],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[34],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[33],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[32],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[31],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[30],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[29],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[28],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[27],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26],write_data_bottom[26]}), // Templated
                                   .rd_adr1(rd_addr1_r7[4:0]),   // Templated
                                   .rd_adr2(rd_addr2_r7[4:0]),   // Templated
                                   .sel_rdaddr1(rd_addr_sel_r7), // Templated
                                   .wr_adr(wr_addr_r7[4:0]),     // Templated
                                   .read_en(rd_en_r7),           // Templated
                                   .wr_en(wr_en_r7c0),           // Templated
                                   .word_wen(word_en_r7[3:0]));   // Templated



// ROW 0 col1
/*      bw_r_rf32x108   AUTO_TEMPLATE(
                           // Outputs
                           .dout        (data_in_h_r@[107:0]),
                           // Inputs
                           .din         ({4'b0,write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[0],write_data_top[0],write_data_top[0],write_data_top[0]}),
                           .rd_adr1     (rd_addr1_r@"(- @ 8)"[4:0]),
                           .rd_adr2     (rd_addr2_r@"(- @ 8)"[4:0]),
                           .sel_rdaddr1 (rd_addr_sel_r@"(- @ 8)"),
                           .wr_adr      (wr_addr_r@"(- @ 8)"[4:0]),
                           .read_en     (rd_en_r@"(- @ 8)"),
                           .wr_en       (wr_en_r@"(- @ 8)"c1),
                           .word_wen    (word_en_r@"(- @ 8)"[3:0]));
*/

        bw_r_rf32x108   subarray_8(
                             .so        (scannet_102),                      
                             .rst_tri_en(mem_write_disable_0_buf_m),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_m),
                             .si        (scannet_101),
                             .reset_l   (areset_l_0_buf_m),
                             .sehold(sehold_0_buf_m),
			/*AUTOINST*/
                                   // Outputs
                                   .dout(data_in_h_r8[107:0]),   // Templated
                                   // Inputs
                                   .din ({4'b0,write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[0],write_data_top[0],write_data_top[0],write_data_top[0]}), // Templated
                                   .rd_adr1(rd_addr1_r0[4:0]),   // Templated
                                   .rd_adr2(rd_addr2_r0[4:0]),   // Templated
                                   .sel_rdaddr1(rd_addr_sel_r0), // Templated
                                   .wr_adr(wr_addr_r0[4:0]),     // Templated
                                   .read_en(rd_en_r0),           // Templated
                                   .wr_en(wr_en_r0c1),           // Templated
                                   .word_wen(word_en_r0[3:0]));   // Templated

/*
	sctag_vuadcol_dp	AUTO_TEMPLATE(
                              .mux1_h_sel(mux1_h_sel_r@"(- @ 8)"[3:0]),
                              .mux1_l_sel(mux1_l_sel_r@"(- @ 8)"[3:0]),
                              .mux2_sel (mux2_sel_r@"(- @ 8)"),
			      .data_out_col(data_out_col_r@[25:0]),
			.data_in_h(data_in_h_r@[103:0]),
			.data_in_l(data_in_h_r@"(+ 1 @)"[103:0]));
*/

        sctag_vuadcol_dp  vuadcol_8(/*AUTOINST*/
                                    // Outputs
                                    .data_out_col(data_out_col_r8[25:0]), // Templated
                                    // Inputs
                                    .data_in_l(data_in_h_r9[103:0]), // Templated
                                    .data_in_h(data_in_h_r8[103:0]), // Templated
                                    .mux1_h_sel(mux1_h_sel_r0[3:0]), // Templated
                                    .mux1_l_sel(mux1_l_sel_r0[3:0]), // Templated
                                    .mux2_sel(mux2_sel_r0));      // Templated

        bw_r_rf32x108   subarray_9(
                             .so        (scannet_103),                      
                             .rst_tri_en(mem_write_disable_0_buf_m),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_m),
                             .si        (scannet_102),
                             .reset_l   (areset_l_0_buf_m),
                             .sehold(sehold_0_buf_m),
                              /*AUTOINST*/
                                   // Outputs
                                   .dout(data_in_h_r9[107:0]),   // Templated
                                   // Inputs
                                   .din ({4'b0,write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[0],write_data_top[0],write_data_top[0],write_data_top[0]}), // Templated
                                   .rd_adr1(rd_addr1_r1[4:0]),   // Templated
                                   .rd_adr2(rd_addr2_r1[4:0]),   // Templated
                                   .sel_rdaddr1(rd_addr_sel_r1), // Templated
                                   .wr_adr(wr_addr_r1[4:0]),     // Templated
                                   .read_en(rd_en_r1),           // Templated
                                   .wr_en(wr_en_r1c1),           // Templated
                                   .word_wen(word_en_r1[3:0]));   // Templated


// ROW 2 col1

        bw_r_rf32x108   subarray_10(
			     .so        (scannet_104),
                             .rst_tri_en(mem_write_disable_1_buf_m),
                             .rclk      (rclk),
                             .se        (scan_enable_1_buf_m),
                             .si        (scannet_103),
                             .reset_l   (areset_l_1_buf_m),
                             .sehold(sehold_1_buf_m),
                              /*AUTOINST*/
                                    // Outputs
                                    .dout(data_in_h_r10[107:0]), // Templated
                                    // Inputs
                                    .din({4'b0,write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[0],write_data_top[0],write_data_top[0],write_data_top[0]}), // Templated
                                    .rd_adr1(rd_addr1_r2[4:0]),  // Templated
                                    .rd_adr2(rd_addr2_r2[4:0]),  // Templated
                                    .sel_rdaddr1(rd_addr_sel_r2), // Templated
                                    .wr_adr(wr_addr_r2[4:0]),    // Templated
                                    .read_en(rd_en_r2),          // Templated
                                    .wr_en(wr_en_r2c1),          // Templated
                                    .word_wen(word_en_r2[3:0]));  // Templated
        sctag_vuadcol_dp  vuadcol_10(/*AUTOINST*/
                                     // Outputs
                                     .data_out_col(data_out_col_r10[25:0]), // Templated
                                     // Inputs
                                     .data_in_l(data_in_h_r11[103:0]), // Templated
                                     .data_in_h(data_in_h_r10[103:0]), // Templated
                                     .mux1_h_sel(mux1_h_sel_r2[3:0]), // Templated
                                     .mux1_l_sel(mux1_l_sel_r2[3:0]), // Templated
                                     .mux2_sel(mux2_sel_r2));     // Templated
        bw_r_rf32x108   subarray_11(
			     .so        (scannet_105),
                             .rst_tri_en(mem_write_disable_1_buf_m),
                             .rclk      (rclk),
                             .se        (scan_enable_1_buf_m),
                             .si        (scannet_104),
                             .reset_l   (areset_l_1_buf_m),
                             .sehold(sehold_1_buf_m),

                              /*AUTOINST*/
                                    // Outputs
                                    .dout(data_in_h_r11[107:0]), // Templated
                                    // Inputs
                                    .din({4'b0,write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[25],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[24],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[23],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[22],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[21],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[20],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[19],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[18],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[17],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[16],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[15],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[14],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[13],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[12],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[11],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[10],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[9],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[8],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[7],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[6],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[5],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[4],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[3],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[2],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[1],write_data_top[0],write_data_top[0],write_data_top[0],write_data_top[0]}), // Templated
                                    .rd_adr1(rd_addr1_r3[4:0]),  // Templated
                                    .rd_adr2(rd_addr2_r3[4:0]),  // Templated
                                    .sel_rdaddr1(rd_addr_sel_r3), // Templated
                                    .wr_adr(wr_addr_r3[4:0]),    // Templated
                                    .read_en(rd_en_r3),          // Templated
                                    .wr_en(wr_en_r3c1),          // Templated
                                    .word_wen(word_en_r3[3:0]));  // Templated

/*
	sctag_vuad_io	AUTO_TEMPLATE(
		.data_out_col1(data_out_col_r8[25:0]),
		.data_out_col2(data_out_col_r10[25:0]),
		.data_out_col3(data_out_col_r12[25:0]),
		.data_out_col4(data_out_col_r14[25:0]),
		.array_data_in(vuad_array_wr_data_c4[25:0]),
                .data_out_io  (vuad_array_rd_data_c1[25:0])) ;
*/
	sctag_vuad_io 	io_right(
                           .array_data_in_buf_bottom(write_data_bottom[25:0]), 
                           .array_data_in_buf_top(write_data_top[25:0]), 
                           /*AUTOINST*/
                           // Outputs
                           .data_out_io (vuad_array_rd_data_c1[25:0]), // Templated
                           // Inputs
                           .data_out_col1(data_out_col_r8[25:0]), // Templated
                           .data_out_col2(data_out_col_r10[25:0]), // Templated
                           .data_out_col3(data_out_col_r12[25:0]), // Templated
                           .data_out_col4(data_out_col_r14[25:0]), // Templated
                           .array_data_in(vuad_array_wr_data_c4[25:0]), // Templated
                           .mux_sel     (mux_sel[3:0]));

/*      bw_r_rf32x108   AUTO_TEMPLATE(
                           // Outputs
                           .dout        (data_in_h_r@[107:0]),
                           // Inputs
                           .din         ({4'b0,write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0]}),
                           .rd_adr1     (rd_addr1_r@"(- @ 8)"[4:0]),
                           .rd_adr2     (rd_addr2_r@"(- @ 8)"[4:0]),
                           .sel_rdaddr1 (rd_addr_sel_r@"(- @ 8)"),
                           .wr_adr      (wr_addr_r@"(- @ 8)"[4:0]),
                           .read_en     (rd_en_r@"(- @ 8)"),
                           .wr_en       (wr_en_r@"(- @ 8)"c1),
                           .word_wen    (word_en_r@"(- @ 8)"[3:0]));
*/
// ROW 4 col1

        bw_r_rf32x108   subarray_12(
			     .so        (scannet_106),                      
                             .rst_tri_en(mem_write_disable_0_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_n),
                             .si        (scannet_105),
                             .reset_l   (areset_l_0_buf_n),
                             .sehold(sehold_0_buf_n),
                              /*AUTOINST*/
                                    // Outputs
                                    .dout(data_in_h_r12[107:0]), // Templated
                                    // Inputs
                                    .din({4'b0,write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0]}), // Templated
                                    .rd_adr1(rd_addr1_r4[4:0]),  // Templated
                                    .rd_adr2(rd_addr2_r4[4:0]),  // Templated
                                    .sel_rdaddr1(rd_addr_sel_r4), // Templated
                                    .wr_adr(wr_addr_r4[4:0]),    // Templated
                                    .read_en(rd_en_r4),          // Templated
                                    .wr_en(wr_en_r4c1),          // Templated
                                    .word_wen(word_en_r4[3:0]));  // Templated
        sctag_vuadcol_dp  vuadcol_12(/*AUTOINST*/
                                     // Outputs
                                     .data_out_col(data_out_col_r12[25:0]), // Templated
                                     // Inputs
                                     .data_in_l(data_in_h_r13[103:0]), // Templated
                                     .data_in_h(data_in_h_r12[103:0]), // Templated
                                     .mux1_h_sel(mux1_h_sel_r4[3:0]), // Templated
                                     .mux1_l_sel(mux1_l_sel_r4[3:0]), // Templated
                                     .mux2_sel(mux2_sel_r4));     // Templated
        bw_r_rf32x108   subarray_13(
			     .so        (scannet_107),                      
                             .rst_tri_en(mem_write_disable_0_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_0_buf_n),
                             .si        (scannet_106),
                             .reset_l   (areset_l_0_buf_n),
                             .sehold(sehold_0_buf_n),
                              /*AUTOINST*/
                                    // Outputs
                                    .dout(data_in_h_r13[107:0]), // Templated
                                    // Inputs
                                    .din({4'b0,write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0]}), // Templated
                                    .rd_adr1(rd_addr1_r5[4:0]),  // Templated
                                    .rd_adr2(rd_addr2_r5[4:0]),  // Templated
                                    .sel_rdaddr1(rd_addr_sel_r5), // Templated
                                    .wr_adr(wr_addr_r5[4:0]),    // Templated
                                    .read_en(rd_en_r5),          // Templated
                                    .wr_en(wr_en_r5c1),          // Templated
                                    .word_wen(word_en_r5[3:0]));  // Templated


// ROW 6 col1

        bw_r_rf32x108   subarray_14(
			     .so        (scannet_108),                      
                             .rst_tri_en(mem_write_disable_1_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_1_buf_n),
                             .si        (scannet_107),
                             .reset_l   (areset_l_1_buf_n),
                             .sehold(sehold_1_buf_n),
                              /*AUTOINST*/
                                    // Outputs
                                    .dout(data_in_h_r14[107:0]), // Templated
                                    // Inputs
                                    .din({4'b0,write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0]}), // Templated
                                    .rd_adr1(rd_addr1_r6[4:0]),  // Templated
                                    .rd_adr2(rd_addr2_r6[4:0]),  // Templated
                                    .sel_rdaddr1(rd_addr_sel_r6), // Templated
                                    .wr_adr(wr_addr_r6[4:0]),    // Templated
                                    .read_en(rd_en_r6),          // Templated
                                    .wr_en(wr_en_r6c1),          // Templated
                                    .word_wen(word_en_r6[3:0]));  // Templated
        sctag_vuadcol_dp  vuadcol_14(/*AUTOINST*/
                                     // Outputs
                                     .data_out_col(data_out_col_r14[25:0]), // Templated
                                     // Inputs
                                     .data_in_l(data_in_h_r15[103:0]), // Templated
                                     .data_in_h(data_in_h_r14[103:0]), // Templated
                                     .mux1_h_sel(mux1_h_sel_r6[3:0]), // Templated
                                     .mux1_l_sel(mux1_l_sel_r6[3:0]), // Templated
                                     .mux2_sel(mux2_sel_r6));     // Templated
        bw_r_rf32x108   subarray_15(
			     .so        (scannet_109),                      
                             .rst_tri_en(mem_write_disable_1_buf_n),
                             .rclk      (rclk),                 
                             .se        (scan_enable_1_buf_n),
                             .si        (scannet_108),
                             .reset_l   (areset_l_1_buf_n),
                             .sehold(sehold_1_buf_n),
                              /*AUTOINST*/
                                    // Outputs
                                    .dout(data_in_h_r15[107:0]), // Templated
                                    // Inputs
                                    .din({4'b0,write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[25],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[24],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[23],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[22],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[21],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[20],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[19],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[18],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[17],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[16],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[15],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[14],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[13],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[12],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[11],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[10],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[9],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[8],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[7],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[6],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[5],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[4],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[3],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[2],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[1],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0],write_data_bottom[0]}), // Templated
                                    .rd_adr1(rd_addr1_r7[4:0]),  // Templated
                                    .rd_adr2(rd_addr2_r7[4:0]),  // Templated
                                    .sel_rdaddr1(rd_addr_sel_r7), // Templated
                                    .wr_adr(wr_addr_r7[4:0]),    // Templated
                                    .read_en(rd_en_r7),          // Templated
                                    .wr_en(wr_en_r7c1),          // Templated
                                    .word_wen(word_en_r7[3:0]));  // Templated

/*	
	sctag_vuad_ctl 	AUTO_TEMPLATE(
		.rd_addr1(arbdp_vuad_idx1_px2[9:0]),	
		.rd_addr2(arbdp_vuad_idx2_px2[9:0]),
		.rd_addr_sel(arbctl_vuad_idx2_sel_px2_n),
		.wr_addr(vuad_idx_c4[9:0]),
		.wr_en0(vuad_array_wr_en0_c4),
		.wr_en1(vuad_array_wr_en1_c4),
		.array_rd_en(arbctl_vuad_acc_px2));
*/

	sctag_vuad_ctl	  vuad_ctl(
                             .so   (scannet_101),
                             .si   (scannet_100),
                             .se   (scan_enable_0_buf_m),
                             .sehold    (sehold_0_buf_m),
				/*AUTOINST*/
                             // Outputs
                             .rd_addr1_r0(rd_addr1_r0[4:0]),
                             .rd_addr2_r0(rd_addr2_r0[4:0]),
                             .rd_addr_sel_r0(rd_addr_sel_r0),
                             .wr_addr_r0(wr_addr_r0[4:0]),
                             .word_en_r0(word_en_r0[3:0]),
                             .wr_en_r0c0(wr_en_r0c0),
                             .wr_en_r0c1(wr_en_r0c1),
                             .mux1_h_sel_r0(mux1_h_sel_r0[3:0]),
                             .mux1_l_sel_r0(mux1_l_sel_r0[3:0]),
                             .mux2_sel_r0(mux2_sel_r0),
                             .rd_en_r0  (rd_en_r0),
                             .rd_addr1_r1(rd_addr1_r1[4:0]),
                             .rd_addr2_r1(rd_addr2_r1[4:0]),
                             .rd_addr_sel_r1(rd_addr_sel_r1),
                             .wr_addr_r1(wr_addr_r1[4:0]),
                             .word_en_r1(word_en_r1[3:0]),
                             .wr_en_r1c0(wr_en_r1c0),
                             .wr_en_r1c1(wr_en_r1c1),
                             .rd_en_r1  (rd_en_r1),
                             .rd_addr1_r2(rd_addr1_r2[4:0]),
                             .rd_addr2_r2(rd_addr2_r2[4:0]),
                             .rd_addr_sel_r2(rd_addr_sel_r2),
                             .wr_addr_r2(wr_addr_r2[4:0]),
                             .word_en_r2(word_en_r2[3:0]),
                             .wr_en_r2c0(wr_en_r2c0),
                             .wr_en_r2c1(wr_en_r2c1),
                             .mux1_h_sel_r2(mux1_h_sel_r2[3:0]),
                             .mux1_l_sel_r2(mux1_l_sel_r2[3:0]),
                             .mux2_sel_r2(mux2_sel_r2),
                             .rd_en_r2  (rd_en_r2),
                             .rd_addr1_r3(rd_addr1_r3[4:0]),
                             .rd_addr2_r3(rd_addr2_r3[4:0]),
                             .rd_addr_sel_r3(rd_addr_sel_r3),
                             .wr_addr_r3(wr_addr_r3[4:0]),
                             .word_en_r3(word_en_r3[3:0]),
                             .wr_en_r3c0(wr_en_r3c0),
                             .wr_en_r3c1(wr_en_r3c1),
                             .rd_en_r3  (rd_en_r3),
                             .rd_addr1_r4(rd_addr1_r4[4:0]),
                             .rd_addr2_r4(rd_addr2_r4[4:0]),
                             .rd_addr_sel_r4(rd_addr_sel_r4),
                             .wr_addr_r4(wr_addr_r4[4:0]),
                             .word_en_r4(word_en_r4[3:0]),
                             .wr_en_r4c0(wr_en_r4c0),
                             .wr_en_r4c1(wr_en_r4c1),
                             .mux1_h_sel_r4(mux1_h_sel_r4[3:0]),
                             .mux1_l_sel_r4(mux1_l_sel_r4[3:0]),
                             .mux2_sel_r4(mux2_sel_r4),
                             .rd_en_r4  (rd_en_r4),
                             .rd_addr1_r5(rd_addr1_r5[4:0]),
                             .rd_addr2_r5(rd_addr2_r5[4:0]),
                             .rd_addr_sel_r5(rd_addr_sel_r5),
                             .wr_addr_r5(wr_addr_r5[4:0]),
                             .word_en_r5(word_en_r5[3:0]),
                             .wr_en_r5c0(wr_en_r5c0),
                             .wr_en_r5c1(wr_en_r5c1),
                             .rd_en_r5  (rd_en_r5),
                             .rd_addr1_r6(rd_addr1_r6[4:0]),
                             .rd_addr2_r6(rd_addr2_r6[4:0]),
                             .rd_addr_sel_r6(rd_addr_sel_r6),
                             .wr_addr_r6(wr_addr_r6[4:0]),
                             .word_en_r6(word_en_r6[3:0]),
                             .wr_en_r6c0(wr_en_r6c0),
                             .wr_en_r6c1(wr_en_r6c1),
                             .mux1_h_sel_r6(mux1_h_sel_r6[3:0]),
                             .mux1_l_sel_r6(mux1_l_sel_r6[3:0]),
                             .mux2_sel_r6(mux2_sel_r6),
                             .rd_en_r6  (rd_en_r6),
                             .rd_addr1_r7(rd_addr1_r7[4:0]),
                             .rd_addr2_r7(rd_addr2_r7[4:0]),
                             .rd_addr_sel_r7(rd_addr_sel_r7),
                             .wr_addr_r7(wr_addr_r7[4:0]),
                             .word_en_r7(word_en_r7[3:0]),
                             .wr_en_r7c0(wr_en_r7c0),
                             .wr_en_r7c1(wr_en_r7c1),
                             .rd_en_r7  (rd_en_r7),
                             .mux_sel   (mux_sel[3:0]),
                             // Inputs
                             .rd_addr1  (arbdp_vuad_idx1_px2[9:0]), // Templated
                             .rd_addr2  (arbdp_vuad_idx2_px2[9:0]), // Templated
                             .rd_addr_sel(arbctl_vuad_idx2_sel_px2_n), // Templated
                             .wr_addr   (vuad_idx_c4[9:0]),      // Templated
                             .wr_en0    (vuad_array_wr_en0_c4),  // Templated
                             .wr_en1    (vuad_array_wr_en1_c4),  // Templated
                             .array_rd_en(arbctl_vuad_acc_px2),  // Templated
                             .rclk      (rclk));

	
	



////////////////////////////////////////
// DIRECTORY
////////////////////////////////////////


/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (ic_cam_hit[31:0]),
                 .rd_data\(.*\)         (ic_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (ic_wr_data\1_row@[32:0]),
                 .wr_en         	(ic_wr_en_row@[3:0]),
                 .rd_en         	(ic_rd_en_row@[3:0]),
                 .cam_en         	(ic_cam_en_row@[3:0]),
                 .rw_addr0              (ic_rw_addr_0145[5:0]),          
                 .rw_addr1              (ic_rw_addr_0145[5:0]),          
                 .rw_addr2              (ic_rw_addr_2367[5:0]),          
                 .rw_addr3              (ic_rw_addr_2367[5:0]),
                 .inv_mask0             (ic_inv_mask_0145[7:0]),          
                 .inv_mask1             (ic_inv_mask_0145[7:0]),          
                 .inv_mask2             (ic_inv_mask_2367[7:0]),          
                 .inv_mask3             (ic_inv_mask_2367[7:0]),
                 .wr_data0              (ic_wr_data04[32:0]),   
                 .wr_data1              (ic_wr_data15[32:0]),   
                 .wr_data2              (ic_wr_data26[32:0]),   
                 .wr_data3              (ic_wr_data37[32:0]),   
                 .wr_data0_l            (ic_wr_data04_l[32:0]), 
                 .wr_data1_l            (ic_wr_data15_l[32:0]), 
                 .wr_data2_l            (ic_wr_data26_l[32:0]), 
                 .wr_data3_l            (ic_wr_data37_l[32:0]),
                 .rd_data0              (ic_rd_data04_row@[31:0]),   
                 .rd_data1              (ic_rd_data15_row@[31:0]),   
                 .rd_data2              (ic_rd_data26_row@[31:0]),   
                 .rd_data3              (ic_rd_data37_row@[31:0]),   
		        .rst_warm_0(ic_warm_rst_0145),
		        .rst_warm_1(ic_warm_rst_2367),
		 );          
*/

// panels 0,1,2,3 
bw_r_dcm		ic_row0	(
                        .si_0(scannet_46),
                        .so_0(scannet_47),
                        .si_1(scannet_47),
                        .so_1(scannet_48),
			.se_0(scan_enable_0_buf_a),
			.se_1(scan_enable_0_buf_a),
                        .rclk             (rclk),
		        .sehold_0(sehold_0_buf_a),
		        .sehold_1(sehold_0_buf_a),
		        .rst_l_0(areset_l_0_buf_a),
		        .rst_l_1(areset_l_0_buf_a),
		        .rst_tri_en_0(mem_write_disable_0_buf_a),
		        .rst_tri_en_1(mem_write_disable_0_buf_a),

			/*AUTOINST*/
                     // Outputs
                     .row_hit           (ic_cam_hit[31:0]),      // Templated
                     .rd_data0          (ic_rd_data04_row0[31:0]), // Templated
                     .rd_data1          (ic_rd_data15_row0[31:0]), // Templated
                     .rd_data2          (ic_rd_data26_row0[31:0]), // Templated
                     .rd_data3          (ic_rd_data37_row0[31:0]), // Templated
                     // Inputs
                     .cam_en            (ic_cam_en_row0[3:0]),   // Templated
                     .inv_mask0         (ic_inv_mask_0145[7:0]), // Templated
                     .inv_mask1         (ic_inv_mask_0145[7:0]), // Templated
                     .inv_mask2         (ic_inv_mask_2367[7:0]), // Templated
                     .inv_mask3         (ic_inv_mask_2367[7:0]), // Templated
                     .rd_en             (ic_rd_en_row0[3:0]),    // Templated
                     .rw_addr0          (ic_rw_addr_0145[5:0]),  // Templated
                     .rw_addr1          (ic_rw_addr_0145[5:0]),  // Templated
                     .rw_addr2          (ic_rw_addr_2367[5:0]),  // Templated
                     .rw_addr3          (ic_rw_addr_2367[5:0]),  // Templated
                     .rst_warm_0        (ic_warm_rst_0145),      // Templated
                     .rst_warm_1        (ic_warm_rst_2367),      // Templated
                     .wr_en             (ic_wr_en_row0[3:0]),    // Templated
                     .wr_data0          (ic_wr_data04[32:0]),    // Templated
                     .wr_data1          (ic_wr_data15[32:0]),    // Templated
                     .wr_data2          (ic_wr_data26[32:0]),    // Templated
                     .wr_data3          (ic_wr_data37[32:0]));    // Templated




		
			
/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({ic_cam_en_row1[1:0],ic_cam_en_row0[1:0]}),
                       .rd_data_en_c4   ({ic_rd_en_row1[1:0],ic_rd_en_row0[1:0]}),
                       .wr_data_en_c4   ({ic_wr_en_row1[1:0],ic_wr_en_row0[1:0]}),
                       .rw_entry_c4     (ic_rw_addr_@[5:0]),
                       .inval_mask_c4   (ic_inv_mask_@[7:0]),

                       .rd_data_sel0_c5 (ic_rd_data_sel_0),
                       .rd_data_sel1_c5 (ic_rd_data_sel_1),
                       .rd_data_sel_right_c6(ic_rd_data_sel_15),
                       .rd_data_sel_left_c6(ic_rd_data_sel_04),
		       .dir_clear_c4_buf(ic_dir_clear_c4_buf_row0),
		       .warm_rst_c4(ic_warm_rst_0145),

                       .lkup_en_c4_buf  ({ic_lkup_en_c4_buf_row1[1:0],ic_lkup_en_c4_buf_row0[1:0]}),
                       .rw_dec_c4_buf   ({ic_rw_dec_c4_buf_row1[1:0],ic_rw_dec_c4_buf_row0[1:0]}),
                       .inval_mask_c4_buf(ic_inv_mask_c4_buf_row0[7:0]),
                       .rd_en_c4_buf    (ic_rd_en_c4_buf_row0),
                       .wr_en_c4_buf    (ic_wr_en_c4_buf_row0),
                       .rw_entry_c4_buf (ic_rw_entry_c4_buf_row0[5:0]));
*/
			


sctag_dir_ctl	ic_ctl_0145(
			.se(scan_enable_0_buf_a),
                        .si(scannet_41),
                        .so              (scannet_42),
                          .sehold       (sehold_0_buf_a),
                        .rclk             (rclk),

			/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({ic_rd_en_row1[1:0],ic_rd_en_row0[1:0]}), // Templated
                          .wr_data_en_c4({ic_wr_en_row1[1:0],ic_wr_en_row0[1:0]}), // Templated
                          .cam_en_c4    ({ic_cam_en_row1[1:0],ic_cam_en_row0[1:0]}), // Templated
                          .rw_entry_c4  (ic_rw_addr_0145[5:0]),  // Templated
                          .inval_mask_c4(ic_inv_mask_0145[7:0]), // Templated
                          .warm_rst_c4  (ic_warm_rst_0145),      // Templated
                          .rd_data_sel0_c5(ic_rd_data_sel_0),    // Templated
                          .rd_data_sel1_c5(ic_rd_data_sel_1),    // Templated
                          .rd_data_sel_right_c6(ic_rd_data_sel_15), // Templated
                          .rd_data_sel_left_c6(ic_rd_data_sel_04), // Templated
                          // Inputs
                          .lkup_en_c4_buf({ic_lkup_en_c4_buf_row1[1:0],ic_lkup_en_c4_buf_row0[1:0]}), // Templated
                          .inval_mask_c4_buf(ic_inv_mask_c4_buf_row0[7:0]), // Templated
                          .rw_dec_c4_buf({ic_rw_dec_c4_buf_row1[1:0],ic_rw_dec_c4_buf_row0[1:0]}), // Templated
                          .rd_en_c4_buf (ic_rd_en_c4_buf_row0),  // Templated
                          .wr_en_c4_buf (ic_wr_en_c4_buf_row0),  // Templated
                          .rw_entry_c4_buf(ic_rw_entry_c4_buf_row0[5:0]), // Templated
                          .dir_clear_c4_buf(ic_dir_clear_c4_buf_row0)); // Templated


/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({ic_cam_en_row1[3:2],ic_cam_en_row0[3:2]}),
                       .rd_data_en_c4   ({ic_rd_en_row1[3:2],ic_rd_en_row0[3:2]}),
                       .wr_data_en_c4   ({ic_wr_en_row1[3:2],ic_wr_en_row0[3:2]}),
                       .rw_entry_c4     (ic_rw_addr_@[5:0]),
                       .inval_mask_c4   (ic_inv_mask_@[7:0]),

                       .rd_data_sel0_c5 (ic_rd_data_sel_2),
                       .rd_data_sel1_c5 (ic_rd_data_sel_3),
                       .rd_data_sel_right_c6(ic_rd_data_sel_37),
                       .rd_data_sel_left_c6(ic_rd_data_sel_26),
		       .dir_clear_c4_buf(ic_dir_clear_c4_buf_row0),
		       .warm_rst_c4(ic_warm_rst_2367),

                       .lkup_en_c4_buf  ({ic_lkup_en_c4_buf_row1[3:2],ic_lkup_en_c4_buf_row0[3:2]}),
                       .rw_dec_c4_buf   ({ic_rw_dec_c4_buf_row1[3:2],ic_rw_dec_c4_buf_row0[3:2]}),
                       .inval_mask_c4_buf(ic_inv_mask_c4_buf_row0[7:0]),
                       .rd_en_c4_buf    (ic_rd_en_c4_buf_row0),
                       .wr_en_c4_buf    (ic_wr_en_c4_buf_row0),
                       .rw_entry_c4_buf (ic_rw_entry_c4_buf_row0[5:0]));
*/

sctag_dir_ctl	ic_ctl_2367(
			.se(scan_enable_0_buf_a),
                        .si(scannet_44),
                        .so              (scannet_45),
                          .sehold       (sehold_0_buf_a),
                        .rclk             (rclk),

			/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({ic_rd_en_row1[3:2],ic_rd_en_row0[3:2]}), // Templated
                          .wr_data_en_c4({ic_wr_en_row1[3:2],ic_wr_en_row0[3:2]}), // Templated
                          .cam_en_c4    ({ic_cam_en_row1[3:2],ic_cam_en_row0[3:2]}), // Templated
                          .rw_entry_c4  (ic_rw_addr_2367[5:0]),  // Templated
                          .inval_mask_c4(ic_inv_mask_2367[7:0]), // Templated
                          .warm_rst_c4  (ic_warm_rst_2367),      // Templated
                          .rd_data_sel0_c5(ic_rd_data_sel_2),    // Templated
                          .rd_data_sel1_c5(ic_rd_data_sel_3),    // Templated
                          .rd_data_sel_right_c6(ic_rd_data_sel_37), // Templated
                          .rd_data_sel_left_c6(ic_rd_data_sel_26), // Templated
                          // Inputs
                          .lkup_en_c4_buf({ic_lkup_en_c4_buf_row1[3:2],ic_lkup_en_c4_buf_row0[3:2]}), // Templated
                          .inval_mask_c4_buf(ic_inv_mask_c4_buf_row0[7:0]), // Templated
                          .rw_dec_c4_buf({ic_rw_dec_c4_buf_row1[3:2],ic_rw_dec_c4_buf_row0[3:2]}), // Templated
                          .rd_en_c4_buf (ic_rd_en_c4_buf_row0),  // Templated
                          .wr_en_c4_buf (ic_wr_en_c4_buf_row0),  // Templated
                          .rw_entry_c4_buf(ic_rw_entry_c4_buf_row0[5:0]), // Templated
                          .dir_clear_c4_buf(ic_dir_clear_c4_buf_row0)); // Templated


/* sctag_dir_in	AUTO_TEMPLATE	(
                    .lkup_wr_data_c5    (ic_wr_data@[32:0]),
                    .rddata_out_c6      (ic_rddata_out_@[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_0),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (ic_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (ic_rd_data@_row1[31:0]));
*/

sctag_dir_in	ic_in_04(
			.se(scan_enable_0_buf_a),
                       .sehold          (sehold_0_buf_a),
                        .si(scannet_40),
                        .so              (scannet_41),
                        .rclk             (rclk),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_data04[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_04[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_data04_row0[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_data04_row1[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_0));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE(
                    .lkup_wr_data_c5    (ic_wr_data@[32:0]),
                    .lkup_wr_data_c5_l  (ic_wr_data@_l[32:0]),
                    .rddata_out_c6      (ic_rddata_out_@[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_1),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (ic_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (ic_rd_data@_row1[31:0]));
*/

sctag_dir_in	ic_in_15(
			.se(scan_enable_0_buf_a),
                       .sehold          (sehold_0_buf_a),
                        .si(scannet_42),
                        .so              (scannet_43),
                        .rclk             (rclk),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_data15[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_15[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_data15_row0[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_data15_row1[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_1));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (ic_wr_data@[32:0]),
                    .lkup_wr_data_c5_l  (ic_wr_data@_l[32:0]),
                    .rddata_out_c6      (ic_rddata_out_@[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_2),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (ic_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (ic_rd_data@_row1[31:0]));
*/

sctag_dir_in	ic_in_26(
			.se(scan_enable_0_buf_a),
                        .sehold          (sehold_0_buf_a),
                        .si(scannet_43),
                        .so              (scannet_44),
                        .rclk             (rclk),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_data26[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_26[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_data26_row0[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_data26_row1[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_2));      // Templated

/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (ic_wr_data@[32:0]),
                    .lkup_wr_data_c5_l  (ic_wr_data@_l[32:0]),
                    .rddata_out_c6      (ic_rddata_out_@[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_3),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (ic_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (ic_rd_data@_row1[31:0]));
*/

sctag_dir_in	ic_in_37(	
			.se(scan_enable_0_buf_a),
                        .sehold          (sehold_0_buf_a),
                        .si(scannet_45),
                        .so              (scannet_46),
                        .rclk             (rclk),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_data37[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_37[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_data37_row0[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_data37_row1[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_3));      // Templated


/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (ic_cam_hit[63:32]),
                 .rd_data\(.*\)         (ic_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (ic_wr_data\1_row@[32:0]),
                 .wr_en         	(ic_wr_en_row@[3:0]),
                 .rd_en         	(ic_rd_en_row@[3:0]),
                 .cam_en         	(ic_cam_en_row@[3:0]),
                 .rw_addr0              (ic_rw_addr_0145[5:0]),          
                 .rw_addr1              (ic_rw_addr_0145[5:0]),          
                 .rw_addr2              (ic_rw_addr_2367[5:0]),          
                 .rw_addr3              (ic_rw_addr_2367[5:0]),
                 .inv_mask0             (ic_inv_mask_0145[7:0]),          
                 .inv_mask1             (ic_inv_mask_0145[7:0]),          
                 .inv_mask2             (ic_inv_mask_2367[7:0]),          
                 .inv_mask3             (ic_inv_mask_2367[7:0]),
                 .wr_data0              (ic_wr_data04[32:0]),   
                 .wr_data1              (ic_wr_data15[32:0]),   
                 .wr_data2              (ic_wr_data26[32:0]),   
                 .wr_data3              (ic_wr_data37[32:0]),   
                 .rd_data0              (ic_rd_data04_row@[31:0]),   
                 .rd_data1              (ic_rd_data15_row@[31:0]),   
                 .rd_data2              (ic_rd_data26_row@[31:0]),   
                 .rd_data3              (ic_rd_data37_row@[31:0]),   
		        .rst_warm_0(ic_warm_rst_0145),
		        .rst_warm_1(ic_warm_rst_2367),
		 );          
*/

bw_r_dcm		ic_row1	(	
                        .si_0(scannet_38),
                        .so_0(scannet_39),
                        .si_1(scannet_39),
                        .so_1(scannet_40),
			.se_0(scan_enable_0_buf_a),
			.se_1(scan_enable_0_buf_a),
                        .rclk             (rclk),
		        .sehold_0(sehold_1_buf_a),
		        .sehold_1(sehold_1_buf_a),
		        .rst_l_0(areset_l_0_buf_a),
		        .rst_l_1(areset_l_0_buf_a),
		        .rst_tri_en_0(mem_write_disable_0_buf_a),
		        .rst_tri_en_1(mem_write_disable_0_buf_a),

			/*AUTOINST*/
                     // Outputs
                     .row_hit           (ic_cam_hit[63:32]),     // Templated
                     .rd_data0          (ic_rd_data04_row1[31:0]), // Templated
                     .rd_data1          (ic_rd_data15_row1[31:0]), // Templated
                     .rd_data2          (ic_rd_data26_row1[31:0]), // Templated
                     .rd_data3          (ic_rd_data37_row1[31:0]), // Templated
                     // Inputs
                     .cam_en            (ic_cam_en_row1[3:0]),   // Templated
                     .inv_mask0         (ic_inv_mask_0145[7:0]), // Templated
                     .inv_mask1         (ic_inv_mask_0145[7:0]), // Templated
                     .inv_mask2         (ic_inv_mask_2367[7:0]), // Templated
                     .inv_mask3         (ic_inv_mask_2367[7:0]), // Templated
                     .rd_en             (ic_rd_en_row1[3:0]),    // Templated
                     .rw_addr0          (ic_rw_addr_0145[5:0]),  // Templated
                     .rw_addr1          (ic_rw_addr_0145[5:0]),  // Templated
                     .rw_addr2          (ic_rw_addr_2367[5:0]),  // Templated
                     .rw_addr3          (ic_rw_addr_2367[5:0]),  // Templated
                     .rst_warm_0        (ic_warm_rst_0145),      // Templated
                     .rst_warm_1        (ic_warm_rst_2367),      // Templated
                     .wr_en             (ic_wr_en_row1[3:0]),    // Templated
                     .wr_data0          (ic_wr_data04[32:0]),    // Templated
                     .wr_data1          (ic_wr_data15[32:0]),    // Templated
                     .wr_data2          (ic_wr_data26[32:0]),    // Templated
                     .wr_data3          (ic_wr_data37[32:0]));    // Templated



/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (),
                       .parity_vld      (ic_parity_in[0]),
                       // Inputs
                       .rddata_out_c6_top(ic_rddata_out_04[31:0]),
                       .rddata_out_c6_bottom(ic_rddata_out_8c[31:0]),
                       .rd_data_sel_c6_top(ic_rd_data_sel_04),
                       .rd_data_sel_c6_bottom(ic_rd_data_sel_8c),
                       .parity_vld_in   (3'b0));
*/

sctag_dir_out	      out_col0	(	
				.se(scan_enable_1_buf_b),
                        .si(scannet_34),
                        .so              (scannet_35),
                        .rclk             (rclk),

				/*AUTOINST*/
                               // Outputs
                               .parity_vld_out(),                // Templated
                               .parity_vld(ic_parity_in[0]),     // Templated
                               // Inputs
                               .rddata_out_c6_top(ic_rddata_out_04[31:0]), // Templated
                               .rddata_out_c6_bottom(ic_rddata_out_8c[31:0]), // Templated
                               .rd_data_sel_c6_top(ic_rd_data_sel_04), // Templated
                               .rd_data_sel_c6_bottom(ic_rd_data_sel_8c), // Templated
                               .parity_vld_in(3'b0));             // Templated

/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (),
                       .parity_vld      (ic_parity_in[1]),
                       // Inputs
                       .rddata_out_c6_top(ic_rddata_out_15[31:0]),
                       .rddata_out_c6_bottom(ic_rddata_out_9d[31:0]),
                       .rd_data_sel_c6_top(ic_rd_data_sel_15),
                       .rd_data_sel_c6_bottom(ic_rd_data_sel_9d),
                       .parity_vld_in   (3'b0));
*/

sctag_dir_out	      out_col1	(	
				.se(scan_enable_1_buf_b),
                        .si(scannet_35),
                        .so              (scannet_36),
                        .rclk             (rclk),

				/*AUTOINST*/
                               // Outputs
                               .parity_vld_out(),                // Templated
                               .parity_vld(ic_parity_in[1]),     // Templated
                               // Inputs
                               .rddata_out_c6_top(ic_rddata_out_15[31:0]), // Templated
                               .rddata_out_c6_bottom(ic_rddata_out_9d[31:0]), // Templated
                               .rd_data_sel_c6_top(ic_rd_data_sel_15), // Templated
                               .rd_data_sel_c6_bottom(ic_rd_data_sel_9d), // Templated
                               .parity_vld_in(3'b0));             // Templated

/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (),
                       .parity_vld      (ic_parity_in[2]),
                       // Inputs
                       .rddata_out_c6_top(ic_rddata_out_26[31:0]),
                       .rddata_out_c6_bottom(ic_rddata_out_ae[31:0]),
                       .rd_data_sel_c6_top(ic_rd_data_sel_26),
                       .rd_data_sel_c6_bottom(ic_rd_data_sel_ae),
                       .parity_vld_in   (3'b0));
*/

sctag_dir_out	      out_col2	(
				.se(scan_enable_1_buf_b),
                        .si(scannet_36),
                        .so              (scannet_37),
                        .rclk             (rclk),

				/*AUTOINST*/
                               // Outputs
                               .parity_vld_out(),                // Templated
                               .parity_vld(ic_parity_in[2]),     // Templated
                               // Inputs
                               .rddata_out_c6_top(ic_rddata_out_26[31:0]), // Templated
                               .rddata_out_c6_bottom(ic_rddata_out_ae[31:0]), // Templated
                               .rd_data_sel_c6_top(ic_rd_data_sel_26), // Templated
                               .rd_data_sel_c6_bottom(ic_rd_data_sel_ae), // Templated
                               .parity_vld_in(3'b0));             // Templated

/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (ic_parity_out[3:1]),
                       .parity_vld      (ic_parity_out[0]),
                       // Inputs
                       .rddata_out_c6_top(ic_rddata_out_37[31:0]),
                       .rddata_out_c6_bottom(ic_rddata_out_bf[31:0]),
                       .rd_data_sel_c6_top(ic_rd_data_sel_37),
                       .rd_data_sel_c6_bottom(ic_rd_data_sel_bf),
                       .parity_vld_in   (ic_parity_in[2:0]));
*/

sctag_dir_out	      out_col3	(
				.se(scan_enable_1_buf_b),
                        .si(scannet_37),
                        .so              (scannet_38),
                        .rclk             (rclk),

				/*AUTOINST*/
                               // Outputs
                               .parity_vld_out(ic_parity_out[3:1]), // Templated
                               .parity_vld(ic_parity_out[0]),    // Templated
                               // Inputs
                               .rddata_out_c6_top(ic_rddata_out_37[31:0]), // Templated
                               .rddata_out_c6_bottom(ic_rddata_out_bf[31:0]), // Templated
                               .rd_data_sel_c6_top(ic_rd_data_sel_37), // Templated
                               .rd_data_sel_c6_bottom(ic_rd_data_sel_bf), // Templated
                               .parity_vld_in(ic_parity_in[2:0])); // Templated




// Row01 repeater.
/*	sctag_dirl_buf	 	AUTO_TEMPLATE	(
                                   // Outputs
                .lkup_en_c4_buf({ic_lkup_en_c4_buf_row1[3:0],ic_lkup_en_c4_buf_row0[3:0]}),
              	.rw_dec_c4_buf({ic_rw_dec_c4_buf_row1[3:0],ic_rw_dec_c4_buf_row0[3:0]}),
               	.inval_mask_c4_buf(ic_inv_mask_c4_buf_row0[7:0]),
                                   .rd_en_c4_buf(ic_rd_en_c4_buf_row0),
                                   .wr_en_c4_buf(ic_wr_en_c4_buf_row0),
                                   .rw_entry_c4_buf(ic_rw_entry_c4_buf_row0[5:0]),
                                   .lkup_wr_data_c4_buf(ic_lkup_wr_data_c4_row0[32:0]),
                                   // Inputs
                                   .rd_en_c4(ic_rd_en_c4),
                                   .wr_en_c4(ic_wr_en_c4),
				   .dir_clear_c4_buf(ic_dir_clear_c4_buf_row0),
				   .dir_clear_c4(ic_dir_clear_c4),
                                   .inval_mask_c4(inval_mask_icd_c4[7:0]),
                                   .rw_panel_en_c4(ic_rdwr_panel_dec_c4[3:0]),
                                   .rw_entry_c4(wr_ic_dir_entry_c4[5:0]),
                                   .rw_row_en_c4(ic_rdwr_row_en_c4[1:0]),
                                   .lkup_row_en_c4(ic_lkup_row_dec_c4[1:0]),
                                   .lkup_panel_en_c4(ic_lkup_panel_dec_c4[3:0]),
                                   .lkup_wr_data_c4(lkup_wr_data_up_buf[32:0]));
*/
sctag_dirl_buf 	ic_buf_row0	(

				/*AUTOINST*/
                             // Outputs
                             .lkup_en_c4_buf({ic_lkup_en_c4_buf_row1[3:0],ic_lkup_en_c4_buf_row0[3:0]}), // Templated
                             .inval_mask_c4_buf(ic_inv_mask_c4_buf_row0[7:0]), // Templated
                             .rw_dec_c4_buf({ic_rw_dec_c4_buf_row1[3:0],ic_rw_dec_c4_buf_row0[3:0]}), // Templated
                             .rd_en_c4_buf(ic_rd_en_c4_buf_row0), // Templated
                             .wr_en_c4_buf(ic_wr_en_c4_buf_row0), // Templated
                             .rw_entry_c4_buf(ic_rw_entry_c4_buf_row0[5:0]), // Templated
                             .lkup_wr_data_c4_buf(ic_lkup_wr_data_c4_row0[32:0]), // Templated
                             .dir_clear_c4_buf(ic_dir_clear_c4_buf_row0), // Templated
                             // Inputs
                             .rd_en_c4  (ic_rd_en_c4),           // Templated
                             .wr_en_c4  (ic_wr_en_c4),           // Templated
                             .inval_mask_c4(inval_mask_icd_c4[7:0]), // Templated
                             .rw_row_en_c4(ic_rdwr_row_en_c4[1:0]), // Templated
                             .rw_panel_en_c4(ic_rdwr_panel_dec_c4[3:0]), // Templated
                             .rw_entry_c4(wr_ic_dir_entry_c4[5:0]), // Templated
                             .lkup_row_en_c4(ic_lkup_row_dec_c4[1:0]), // Templated
                             .lkup_panel_en_c4(ic_lkup_panel_dec_c4[3:0]), // Templated
                             .lkup_wr_data_c4(lkup_wr_data_up_buf[32:0]), // Templated
                             .dir_clear_c4(ic_dir_clear_c4));     // Templated
// Row23 repeater
/*      sctag_dirl_buf          AUTO_TEMPLATE   (
                                   // Outputs

                .lkup_en_c4_buf({ic_lkup_en_c4_buf_row3[3:0],ic_lkup_en_c4_buf_row2[3:0]}),
              	.rw_dec_c4_buf({ic_rw_dec_c4_buf_row3[3:0],ic_rw_dec_c4_buf_row2[3:0]}),
               	.inval_mask_c4_buf(ic_inv_mask_c4_buf_row2[7:0]),
                                   .rd_en_c4_buf(ic_rd_en_c4_buf_row2),
                                   .wr_en_c4_buf(ic_wr_en_c4_buf_row2),
                                   .rw_entry_c4_buf(ic_rw_entry_c4_buf_row2[5:0]),
                                   .lkup_wr_data_c4_buf(ic_lkup_wr_data_c4_row2[32:0]),
                                   // Inputs
				   .dir_clear_c4_buf(ic_dir_clear_c4_buf_row2),
				   .dir_clear_c4(ic_dir_clear_c4),
                                   .rd_en_c4(ic_rd_en_c4),
                                   .wr_en_c4(ic_wr_en_c4),
                                   .inval_mask_c4(inval_mask_icd_c4[7:0]),
                                   .rw_row_en_c4(ic_rdwr_row_en_c4[3:2]),
                                   .lkup_row_en_c4(ic_lkup_row_dec_c4[3:2]),
                                   .rw_panel_en_c4(ic_rdwr_panel_dec_c4[3:0]),
                                   .rw_entry_c4(wr_ic_dir_entry_c4[5:0]),
                                   .lkup_panel_en_c4(ic_lkup_panel_dec_c4[3:0]),
                                   .lkup_wr_data_c4(lkup_wr_data_up_buf[32:0]));
*/


sctag_dirl_buf 	ic_buf_row1	(

				/*AUTOINST*/
                             // Outputs
                             .lkup_en_c4_buf({ic_lkup_en_c4_buf_row3[3:0],ic_lkup_en_c4_buf_row2[3:0]}), // Templated
                             .inval_mask_c4_buf(ic_inv_mask_c4_buf_row2[7:0]), // Templated
                             .rw_dec_c4_buf({ic_rw_dec_c4_buf_row3[3:0],ic_rw_dec_c4_buf_row2[3:0]}), // Templated
                             .rd_en_c4_buf(ic_rd_en_c4_buf_row2), // Templated
                             .wr_en_c4_buf(ic_wr_en_c4_buf_row2), // Templated
                             .rw_entry_c4_buf(ic_rw_entry_c4_buf_row2[5:0]), // Templated
                             .lkup_wr_data_c4_buf(ic_lkup_wr_data_c4_row2[32:0]), // Templated
                             .dir_clear_c4_buf(ic_dir_clear_c4_buf_row2), // Templated
                             // Inputs
                             .rd_en_c4  (ic_rd_en_c4),           // Templated
                             .wr_en_c4  (ic_wr_en_c4),           // Templated
                             .inval_mask_c4(inval_mask_icd_c4[7:0]), // Templated
                             .rw_row_en_c4(ic_rdwr_row_en_c4[3:2]), // Templated
                             .rw_panel_en_c4(ic_rdwr_panel_dec_c4[3:0]), // Templated
                             .rw_entry_c4(wr_ic_dir_entry_c4[5:0]), // Templated
                             .lkup_row_en_c4(ic_lkup_row_dec_c4[3:2]), // Templated
                             .lkup_panel_en_c4(ic_lkup_panel_dec_c4[3:0]), // Templated
                             .lkup_wr_data_c4(lkup_wr_data_up_buf[32:0]), // Templated
                             .dir_clear_c4(ic_dir_clear_c4));     // Templated

// Second half
/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (ic_cam_hit[95:64]),
                 .rd_data\(.*\)         (ic_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (ic_wr_data\1_row@[32:0]),
                 .wr_en         	(ic_wr_en_row@[3:0]),
                 .rd_en         	(ic_rd_en_row@[3:0]),
                 .cam_en         	(ic_cam_en_row@[3:0]),
                 .rw_addr0              (ic_rw_addr_89cd[5:0]),          
                 .rw_addr1              (ic_rw_addr_89cd[5:0]),          
                 .rw_addr2              (ic_rw_addr_abef[5:0]),          
                 .rw_addr3              (ic_rw_addr_abef[5:0]),
                 .inv_mask0             (ic_inv_mask_89cd[7:0]),          
                 .inv_mask1             (ic_inv_mask_89cd[7:0]),          
                 .inv_mask2             (ic_inv_mask_abef[7:0]),          
                 .inv_mask3             (ic_inv_mask_abef[7:0]),
                 .wr_data0              (ic_wr_data8c[32:0]),   
                 .wr_data1              (ic_wr_data9d[32:0]),   
                 .wr_data2              (ic_wr_dataae[32:0]),   
                 .wr_data3              (ic_wr_databf[32:0]),   
                 .rd_data0              (ic_rd_data8c_row@[31:0]),   
                 .rd_data1              (ic_rd_data9d_row@[31:0]),   
                 .rd_data2              (ic_rd_dataae_row@[31:0]),   
                 .rd_data3              (ic_rd_databf_row@[31:0]),   
		        .rst_warm_0(ic_warm_rst_89cd),
		        .rst_warm_1(ic_warm_rst_abef),
		 )          
*/

bw_r_dcm		ic_row2	(
                        .si_0(scannet_32),
                        .so_0(scannet_33),
                        .si_1(scannet_33),
                        .so_1(scannet_34),
			.se_0(scan_enable_0_buf_b),
			.se_1(scan_enable_0_buf_b),
                        .rclk             (rclk),
		        .sehold_0(sehold_0_buf_b),
		        .sehold_1(sehold_0_buf_b),
		        .rst_l_0(areset_l_0_buf_b),
		        .rst_l_1(areset_l_0_buf_b),
		        .rst_tri_en_0(mem_write_disable_0_buf_b),
		        .rst_tri_en_1(mem_write_disable_0_buf_b),

			/*AUTOINST*/
                     // Outputs
                     .row_hit           (ic_cam_hit[95:64]),     // Templated
                     .rd_data0          (ic_rd_data8c_row2[31:0]), // Templated
                     .rd_data1          (ic_rd_data9d_row2[31:0]), // Templated
                     .rd_data2          (ic_rd_dataae_row2[31:0]), // Templated
                     .rd_data3          (ic_rd_databf_row2[31:0]), // Templated
                     // Inputs
                     .cam_en            (ic_cam_en_row2[3:0]),   // Templated
                     .inv_mask0         (ic_inv_mask_89cd[7:0]), // Templated
                     .inv_mask1         (ic_inv_mask_89cd[7:0]), // Templated
                     .inv_mask2         (ic_inv_mask_abef[7:0]), // Templated
                     .inv_mask3         (ic_inv_mask_abef[7:0]), // Templated
                     .rd_en             (ic_rd_en_row2[3:0]),    // Templated
                     .rw_addr0          (ic_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr1          (ic_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr2          (ic_rw_addr_abef[5:0]),  // Templated
                     .rw_addr3          (ic_rw_addr_abef[5:0]),  // Templated
                     .rst_warm_0        (ic_warm_rst_89cd),      // Templated
                     .rst_warm_1        (ic_warm_rst_abef),      // Templated
                     .wr_en             (ic_wr_en_row2[3:0]),    // Templated
                     .wr_data0          (ic_wr_data8c[32:0]),    // Templated
                     .wr_data1          (ic_wr_data9d[32:0]),    // Templated
                     .wr_data2          (ic_wr_dataae[32:0]),    // Templated
                     .wr_data3          (ic_wr_databf[32:0]));    // Templated


			
/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({ic_cam_en_row3[1:0],ic_cam_en_row2[1:0]}),
                       .rd_data_en_c4   ({ic_rd_en_row3[1:0],ic_rd_en_row2[1:0]}),
                       .wr_data_en_c4   ({ic_wr_en_row3[1:0],ic_wr_en_row2[1:0]}),
                       .rw_entry_c4     (ic_rw_addr_89cd[5:0]),
                       .inval_mask_c4   (ic_inv_mask_89cd[7:0]),

                       .rd_data_sel0_c5 (ic_rd_data_sel_8),
                       .rd_data_sel1_c5 (ic_rd_data_sel_9),
                       .rd_data_sel_right_c6(ic_rd_data_sel_9d),
                       .rd_data_sel_left_c6(ic_rd_data_sel_8c),
		       .dir_clear_c4_buf(ic_dir_clear_c4_buf_row2),
		       .warm_rst_c4(ic_warm_rst_89cd),

                       .lkup_en_c4_buf  ({ic_lkup_en_c4_buf_row3[1:0],ic_lkup_en_c4_buf_row2[1:0]}),
                       .rw_dec_c4_buf   ({ic_rw_dec_c4_buf_row3[1:0],ic_rw_dec_c4_buf_row2[1:0]}),
                       .inval_mask_c4_buf(ic_inv_mask_c4_buf_row2[7:0]),
                       .rd_en_c4_buf    (ic_rd_en_c4_buf_row2),
                       .wr_en_c4_buf    (ic_wr_en_c4_buf_row2),
                       .rw_entry_c4_buf (ic_rw_entry_c4_buf_row2[5:0]));
*/
			

sctag_dir_ctl	ic_ctl_89cd(
			.se(scan_enable_0_buf_b),
                          .sehold       (sehold_0_buf_b),
                        .si(scannet_27),
                        .so              (scannet_28),
                        .rclk             (rclk),

			/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({ic_rd_en_row3[1:0],ic_rd_en_row2[1:0]}), // Templated
                          .wr_data_en_c4({ic_wr_en_row3[1:0],ic_wr_en_row2[1:0]}), // Templated
                          .cam_en_c4    ({ic_cam_en_row3[1:0],ic_cam_en_row2[1:0]}), // Templated
                          .rw_entry_c4  (ic_rw_addr_89cd[5:0]),  // Templated
                          .inval_mask_c4(ic_inv_mask_89cd[7:0]), // Templated
                          .warm_rst_c4  (ic_warm_rst_89cd),      // Templated
                          .rd_data_sel0_c5(ic_rd_data_sel_8),    // Templated
                          .rd_data_sel1_c5(ic_rd_data_sel_9),    // Templated
                          .rd_data_sel_right_c6(ic_rd_data_sel_9d), // Templated
                          .rd_data_sel_left_c6(ic_rd_data_sel_8c), // Templated
                          // Inputs
                          .lkup_en_c4_buf({ic_lkup_en_c4_buf_row3[1:0],ic_lkup_en_c4_buf_row2[1:0]}), // Templated
                          .inval_mask_c4_buf(ic_inv_mask_c4_buf_row2[7:0]), // Templated
                          .rw_dec_c4_buf({ic_rw_dec_c4_buf_row3[1:0],ic_rw_dec_c4_buf_row2[1:0]}), // Templated
                          .rd_en_c4_buf (ic_rd_en_c4_buf_row2),  // Templated
                          .wr_en_c4_buf (ic_wr_en_c4_buf_row2),  // Templated
                          .rw_entry_c4_buf(ic_rw_entry_c4_buf_row2[5:0]), // Templated
                          .dir_clear_c4_buf(ic_dir_clear_c4_buf_row2)); // Templated


/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({ic_cam_en_row3[3:2],ic_cam_en_row2[3:2]}),
                       .rd_data_en_c4   ({ic_rd_en_row3[3:2],ic_rd_en_row2[3:2]}),
                       .wr_data_en_c4   ({ic_wr_en_row3[3:2],ic_wr_en_row2[3:2]}),
                       .rw_entry_c4     (ic_rw_addr_abef[5:0]),
                       .inval_mask_c4   (ic_inv_mask_abef[7:0]),

                       .rd_data_sel0_c5 (ic_rd_data_sel_a),
                       .rd_data_sel1_c5 (ic_rd_data_sel_b),
                       .rd_data_sel_right_c6(ic_rd_data_sel_bf),
                       .rd_data_sel_left_c6(ic_rd_data_sel_ae),
		       .dir_clear_c4_buf(ic_dir_clear_c4_buf_row2),
		       .warm_rst_c4(ic_warm_rst_abef),

                       .lkup_en_c4_buf  ({ic_lkup_en_c4_buf_row3[3:2],ic_lkup_en_c4_buf_row2[3:2]}),
                       .rw_dec_c4_buf   ({ic_rw_dec_c4_buf_row3[3:2],ic_rw_dec_c4_buf_row2[3:2]}),
                       .inval_mask_c4_buf(ic_inv_mask_c4_buf_row2[7:0]),
                       .rd_en_c4_buf    (ic_rd_en_c4_buf_row2),
                       .wr_en_c4_buf    (ic_wr_en_c4_buf_row2),
                       .rw_entry_c4_buf (ic_rw_entry_c4_buf_row2[5:0]));
*/

sctag_dir_ctl	ic_ctl_abef(
			.se(scan_enable_0_buf_b),
                          .sehold       (sehold_0_buf_b),
                        .si(scannet_30),
                        .so              (scannet_31),
                        .rclk             (rclk),

				/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({ic_rd_en_row3[3:2],ic_rd_en_row2[3:2]}), // Templated
                          .wr_data_en_c4({ic_wr_en_row3[3:2],ic_wr_en_row2[3:2]}), // Templated
                          .cam_en_c4    ({ic_cam_en_row3[3:2],ic_cam_en_row2[3:2]}), // Templated
                          .rw_entry_c4  (ic_rw_addr_abef[5:0]),  // Templated
                          .inval_mask_c4(ic_inv_mask_abef[7:0]), // Templated
                          .warm_rst_c4  (ic_warm_rst_abef),      // Templated
                          .rd_data_sel0_c5(ic_rd_data_sel_a),    // Templated
                          .rd_data_sel1_c5(ic_rd_data_sel_b),    // Templated
                          .rd_data_sel_right_c6(ic_rd_data_sel_bf), // Templated
                          .rd_data_sel_left_c6(ic_rd_data_sel_ae), // Templated
                          // Inputs
                          .lkup_en_c4_buf({ic_lkup_en_c4_buf_row3[3:2],ic_lkup_en_c4_buf_row2[3:2]}), // Templated
                          .inval_mask_c4_buf(ic_inv_mask_c4_buf_row2[7:0]), // Templated
                          .rw_dec_c4_buf({ic_rw_dec_c4_buf_row3[3:2],ic_rw_dec_c4_buf_row2[3:2]}), // Templated
                          .rd_en_c4_buf (ic_rd_en_c4_buf_row2),  // Templated
                          .wr_en_c4_buf (ic_wr_en_c4_buf_row2),  // Templated
                          .rw_entry_c4_buf(ic_rw_entry_c4_buf_row2[5:0]), // Templated
                          .dir_clear_c4_buf(ic_dir_clear_c4_buf_row2)); // Templated


/* sctag_dir_in	AUTO_TEMPLATE	(
                    .lkup_wr_data_c5    (ic_wr_data8c[32:0]),
                    .rddata_out_c6      (ic_rddata_out_8c[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_8),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (ic_rd_data8c_row2[31:0]),
                    .rd_data2_out_c5    (ic_rd_data8c_row3[31:0]));
*/

sctag_dir_in	ic_in_8c(
				.se(scan_enable_0_buf_b),
                       .sehold          (sehold_0_buf_b),
                        .si(scannet_26),
                        .so              (scannet_27),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_data8c[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_8c[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_data8c_row2[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_data8c_row3[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_8));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE(
                    .lkup_wr_data_c5    (ic_wr_data9d[32:0]),
                    .rddata_out_c6      (ic_rddata_out_9d[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_9),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (ic_rd_data9d_row2[31:0]),
                    .rd_data2_out_c5    (ic_rd_data9d_row3[31:0]));
*/

sctag_dir_in	ic_in_9d(
				.se(scan_enable_0_buf_b),
                       .sehold          (sehold_0_buf_b),
                        .si(scannet_28),
                        .so              (scannet_29),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_data9d[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_9d[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_data9d_row2[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_data9d_row3[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_9));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (ic_wr_dataae[32:0]),
                    .rddata_out_c6      (ic_rddata_out_ae[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_a),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (ic_rd_dataae_row2[31:0]),
                    .rd_data2_out_c5    (ic_rd_dataae_row3[31:0]));
*/

sctag_dir_in	ic_in_ae(
				.se(scan_enable_0_buf_b),
                       .sehold          (sehold_0_buf_b),
                        .si(scannet_29),
                        .so              (scannet_30),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_dataae[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_ae[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_dataae_row2[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_dataae_row3[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_a));      // Templated

/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (ic_wr_databf[32:0]),
                    .rddata_out_c6      (ic_rddata_out_bf[31:0]),
                    .rd_enable1_c5      (ic_rd_data_sel_b),
                    // Inputs
                    .lkup_wr_data_c4    (ic_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (ic_rd_databf_row2[31:0]),
                    .rd_data2_out_c5    (ic_rd_databf_row3[31:0]));
*/

sctag_dir_in	ic_in_bf(
			.se(scan_enable_0_buf_b),
                       .sehold          (sehold_0_buf_b),
                        .si(scannet_31),
                        .so              (scannet_32),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (ic_wr_databf[32:0]),    // Templated
                       .rddata_out_c6   (ic_rddata_out_bf[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (ic_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (ic_rd_databf_row2[31:0]), // Templated
                       .rd_data2_out_c5 (ic_rd_databf_row3[31:0]), // Templated
                       .rd_enable1_c5   (ic_rd_data_sel_b));      // Templated


/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (ic_cam_hit[127:96]),
                 .rd_data\(.*\)         (ic_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (ic_wr_data\1_row@[32:0]),
                 .wr_en         	(ic_wr_en_row@[3:0]),
                 .rd_en         	(ic_rd_en_row@[3:0]),
                 .cam_en         	(ic_cam_en_row@[3:0]),
                 .rw_addr0              (ic_rw_addr_89cd[5:0]),          
                 .rw_addr1              (ic_rw_addr_89cd[5:0]),          
                 .rw_addr2              (ic_rw_addr_abef[5:0]),          
                 .rw_addr3              (ic_rw_addr_abef[5:0]),
                 .inv_mask0             (ic_inv_mask_89cd[7:0]),          
                 .inv_mask1             (ic_inv_mask_89cd[7:0]),          
                 .inv_mask2             (ic_inv_mask_abef[7:0]),          
                 .inv_mask3             (ic_inv_mask_abef[7:0]),
                 .wr_data0              (ic_wr_data8c[32:0]),   
                 .wr_data1              (ic_wr_data9d[32:0]),   
                 .wr_data2              (ic_wr_dataae[32:0]),   
                 .wr_data3              (ic_wr_databf[32:0]),   
                 .rd_data0              (ic_rd_data8c_row@[31:0]),   
                 .rd_data1              (ic_rd_data9d_row@[31:0]),   
                 .rd_data2              (ic_rd_dataae_row@[31:0]),   
                 .rd_data3              (ic_rd_databf_row@[31:0]),   
		        .rst_warm_0(ic_warm_rst_89cd),
		        .rst_warm_1(ic_warm_rst_abef),
		 );          
*/

bw_r_dcm		ic_row3	(
                        .si_0(scannet_24),
                        .so_0(scannet_25),
                        .si_1(scannet_25),
                        .so_1(scannet_26),
			.se_0(scan_enable_0_buf_b),
			.se_1(scan_enable_0_buf_b),
                        .rclk             (rclk),
		        .sehold_0(sehold_1_buf_b),
		        .sehold_1(sehold_1_buf_b),
		        .rst_l_0(areset_l_0_buf_b),
		        .rst_l_1(areset_l_0_buf_b),
		        .rst_tri_en_0(mem_write_disable_0_buf_b),
		        .rst_tri_en_1(mem_write_disable_0_buf_b),
			/*AUTOINST*/
                     // Outputs
                     .row_hit           (ic_cam_hit[127:96]),    // Templated
                     .rd_data0          (ic_rd_data8c_row3[31:0]), // Templated
                     .rd_data1          (ic_rd_data9d_row3[31:0]), // Templated
                     .rd_data2          (ic_rd_dataae_row3[31:0]), // Templated
                     .rd_data3          (ic_rd_databf_row3[31:0]), // Templated
                     // Inputs
                     .cam_en            (ic_cam_en_row3[3:0]),   // Templated
                     .inv_mask0         (ic_inv_mask_89cd[7:0]), // Templated
                     .inv_mask1         (ic_inv_mask_89cd[7:0]), // Templated
                     .inv_mask2         (ic_inv_mask_abef[7:0]), // Templated
                     .inv_mask3         (ic_inv_mask_abef[7:0]), // Templated
                     .rd_en             (ic_rd_en_row3[3:0]),    // Templated
                     .rw_addr0          (ic_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr1          (ic_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr2          (ic_rw_addr_abef[5:0]),  // Templated
                     .rw_addr3          (ic_rw_addr_abef[5:0]),  // Templated
                     .rst_warm_0        (ic_warm_rst_89cd),      // Templated
                     .rst_warm_1        (ic_warm_rst_abef),      // Templated
                     .wr_en             (ic_wr_en_row3[3:0]),    // Templated
                     .wr_data0          (ic_wr_data8c[32:0]),    // Templated
                     .wr_data1          (ic_wr_data9d[32:0]),    // Templated
                     .wr_data2          (ic_wr_dataae[32:0]),    // Templated
                     .wr_data3          (ic_wr_databf[32:0]));    // Templated


///////////////////////////////////////////
// D$ directory starts here.
///////////////////////////////////////////

/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (dc_cam_hit[31:0]),
                 .rd_data\(.*\)         (dc_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (dc_wr_data\1_row@[32:0]),
                 .wr_en         	(dc_wr_en_row@[3:0]),
                 .rd_en         	(dc_rd_en_row@[3:0]),
                 .cam_en         	(dc_cam_en_row@[3:0]),
                 .rw_addr0              (dc_rw_addr_0145[5:0]),          
                 .rw_addr1              (dc_rw_addr_0145[5:0]),          
                 .rw_addr2              (dc_rw_addr_2367[5:0]),          
                 .rw_addr3              (dc_rw_addr_2367[5:0]),
                 .inv_mask0             (dc_inv_mask_0145[7:0]),          
                 .inv_mask1             (dc_inv_mask_0145[7:0]),          
                 .inv_mask2             (dc_inv_mask_2367[7:0]),          
                 .inv_mask3             (dc_inv_mask_2367[7:0]),
                 .wr_data0              (dc_wr_data04[32:0]),   
                 .wr_data1              (dc_wr_data15[32:0]),   
                 .wr_data2              (dc_wr_data26[32:0]),   
                 .wr_data3              (dc_wr_data37[32:0]),   
                 .rd_data0              (dc_rd_data04_row@[31:0]),   
                 .rd_data1              (dc_rd_data15_row@[31:0]),   
                 .rd_data2              (dc_rd_data26_row@[31:0]),   
                 .rd_data3              (dc_rd_data37_row@[31:0]),   
		        .rst_warm_0(dc_warm_rst_0145),
		        .rst_warm_1(dc_warm_rst_2367),
		 );          
*/

// panels 0,1,2,3 
bw_r_dcm		dc_row0	(
                        .si_0(scannet_22),
                        .so_0(scannet_23),
                        .si_1(scannet_23),
                        .so_1(scannet_24),
			.se_0(scan_enable_0_buf_c),
			.se_1(scan_enable_0_buf_c),
                        .rclk             (rclk),
		        .sehold_0(sehold_0_buf_c),
		        .sehold_1(sehold_0_buf_c),
		        .rst_l_0(areset_l_0_buf_c),
		        .rst_l_1(areset_l_0_buf_c),
		        .rst_tri_en_0(mem_write_disable_0_buf_c),
		        .rst_tri_en_1(mem_write_disable_0_buf_c),

			/*AUTOINST*/
                     // Outputs
                     .row_hit           (dc_cam_hit[31:0]),      // Templated
                     .rd_data0          (dc_rd_data04_row0[31:0]), // Templated
                     .rd_data1          (dc_rd_data15_row0[31:0]), // Templated
                     .rd_data2          (dc_rd_data26_row0[31:0]), // Templated
                     .rd_data3          (dc_rd_data37_row0[31:0]), // Templated
                     // Inputs
                     .cam_en            (dc_cam_en_row0[3:0]),   // Templated
                     .inv_mask0         (dc_inv_mask_0145[7:0]), // Templated
                     .inv_mask1         (dc_inv_mask_0145[7:0]), // Templated
                     .inv_mask2         (dc_inv_mask_2367[7:0]), // Templated
                     .inv_mask3         (dc_inv_mask_2367[7:0]), // Templated
                     .rd_en             (dc_rd_en_row0[3:0]),    // Templated
                     .rw_addr0          (dc_rw_addr_0145[5:0]),  // Templated
                     .rw_addr1          (dc_rw_addr_0145[5:0]),  // Templated
                     .rw_addr2          (dc_rw_addr_2367[5:0]),  // Templated
                     .rw_addr3          (dc_rw_addr_2367[5:0]),  // Templated
                     .rst_warm_0        (dc_warm_rst_0145),      // Templated
                     .rst_warm_1        (dc_warm_rst_2367),      // Templated
                     .wr_en             (dc_wr_en_row0[3:0]),    // Templated
                     .wr_data0          (dc_wr_data04[32:0]),    // Templated
                     .wr_data1          (dc_wr_data15[32:0]),    // Templated
                     .wr_data2          (dc_wr_data26[32:0]),    // Templated
                     .wr_data3          (dc_wr_data37[32:0]));    // Templated




		
			
/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({dc_cam_en_row1[1:0],dc_cam_en_row0[1:0]}),
                       .rd_data_en_c4   ({dc_rd_en_row1[1:0],dc_rd_en_row0[1:0]}),
                       .wr_data_en_c4   ({dc_wr_en_row1[1:0],dc_wr_en_row0[1:0]}),
                       .rw_entry_c4     (dc_rw_addr_@[5:0]),
                       .inval_mask_c4   (dc_inv_mask_@[7:0]),

                       .rd_data_sel0_c5 (dc_rd_data_sel_0),
                       .rd_data_sel1_c5 (dc_rd_data_sel_1),
                       .rd_data_sel_right_c6(dc_rd_data_sel_15),
                       .rd_data_sel_left_c6(dc_rd_data_sel_04),
		       .dir_clear_c4_buf(dc_dir_clear_c4_buf_row0),
		       .warm_rst_c4(dc_warm_rst_0145),

                       .lkup_en_c4_buf  ({dc_lkup_en_c4_buf_row1[1:0],dc_lkup_en_c4_buf_row0[1:0]}),
                       .rw_dec_c4_buf   ({dc_rw_dec_c4_buf_row1[1:0],dc_rw_dec_c4_buf_row0[1:0]}),
                       .inval_mask_c4_buf(dc_inv_mask_c4_buf_row0[7:0]),
                       .rd_en_c4_buf    (dc_rd_en_c4_buf_row0),
                       .wr_en_c4_buf    (dc_wr_en_c4_buf_row0),
                       .rw_entry_c4_buf (dc_rw_entry_c4_buf_row0[5:0]));
*/
			


sctag_dir_ctl	dc_ctl_0145(
			.se(scan_enable_0_buf_c),
                        .si(scannet_17),
                        .so              (scannet_18),
                        .rclk             (rclk),
                         .sehold       (sehold_0_buf_c),

			/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({dc_rd_en_row1[1:0],dc_rd_en_row0[1:0]}), // Templated
                          .wr_data_en_c4({dc_wr_en_row1[1:0],dc_wr_en_row0[1:0]}), // Templated
                          .cam_en_c4    ({dc_cam_en_row1[1:0],dc_cam_en_row0[1:0]}), // Templated
                          .rw_entry_c4  (dc_rw_addr_0145[5:0]),  // Templated
                          .inval_mask_c4(dc_inv_mask_0145[7:0]), // Templated
                          .warm_rst_c4  (dc_warm_rst_0145),      // Templated
                          .rd_data_sel0_c5(dc_rd_data_sel_0),    // Templated
                          .rd_data_sel1_c5(dc_rd_data_sel_1),    // Templated
                          .rd_data_sel_right_c6(dc_rd_data_sel_15), // Templated
                          .rd_data_sel_left_c6(dc_rd_data_sel_04), // Templated
                          // Inputs
                          .lkup_en_c4_buf({dc_lkup_en_c4_buf_row1[1:0],dc_lkup_en_c4_buf_row0[1:0]}), // Templated
                          .inval_mask_c4_buf(dc_inv_mask_c4_buf_row0[7:0]), // Templated
                          .rw_dec_c4_buf({dc_rw_dec_c4_buf_row1[1:0],dc_rw_dec_c4_buf_row0[1:0]}), // Templated
                          .rd_en_c4_buf (dc_rd_en_c4_buf_row0),  // Templated
                          .wr_en_c4_buf (dc_wr_en_c4_buf_row0),  // Templated
                          .rw_entry_c4_buf(dc_rw_entry_c4_buf_row0[5:0]), // Templated
                          .dir_clear_c4_buf(dc_dir_clear_c4_buf_row0)); // Templated


/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({dc_cam_en_row1[3:2],dc_cam_en_row0[3:2]}),
                       .rd_data_en_c4   ({dc_rd_en_row1[3:2],dc_rd_en_row0[3:2]}),
                       .wr_data_en_c4   ({dc_wr_en_row1[3:2],dc_wr_en_row0[3:2]}),
                       .rw_entry_c4     (dc_rw_addr_@[5:0]),
                       .inval_mask_c4   (dc_inv_mask_@[7:0]),

                       .rd_data_sel0_c5 (dc_rd_data_sel_2),
                       .rd_data_sel1_c5 (dc_rd_data_sel_3),
                       .rd_data_sel_right_c6(dc_rd_data_sel_37),
                       .rd_data_sel_left_c6(dc_rd_data_sel_26),

		       .dir_clear_c4_buf(dc_dir_clear_c4_buf_row0),
		       .warm_rst_c4(dc_warm_rst_2367),
                       .lkup_en_c4_buf  ({dc_lkup_en_c4_buf_row1[3:2],dc_lkup_en_c4_buf_row0[3:2]}),
                       .rw_dec_c4_buf   ({dc_rw_dec_c4_buf_row1[3:2],dc_rw_dec_c4_buf_row0[3:2]}),
                       .inval_mask_c4_buf(dc_inv_mask_c4_buf_row0[7:0]),
                       .rd_en_c4_buf    (dc_rd_en_c4_buf_row0),
                       .wr_en_c4_buf    (dc_wr_en_c4_buf_row0),
                       .rw_entry_c4_buf (dc_rw_entry_c4_buf_row0[5:0]));
*/

sctag_dir_ctl	dc_ctl_2367(
			.se(scan_enable_0_buf_c),
                        .si(scannet_20),
                        .so              (scannet_21),
                        .rclk             (rclk),
                         .sehold       (sehold_0_buf_c),

			/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({dc_rd_en_row1[3:2],dc_rd_en_row0[3:2]}), // Templated
                          .wr_data_en_c4({dc_wr_en_row1[3:2],dc_wr_en_row0[3:2]}), // Templated
                          .cam_en_c4    ({dc_cam_en_row1[3:2],dc_cam_en_row0[3:2]}), // Templated
                          .rw_entry_c4  (dc_rw_addr_2367[5:0]),  // Templated
                          .inval_mask_c4(dc_inv_mask_2367[7:0]), // Templated
                          .warm_rst_c4  (dc_warm_rst_2367),      // Templated
                          .rd_data_sel0_c5(dc_rd_data_sel_2),    // Templated
                          .rd_data_sel1_c5(dc_rd_data_sel_3),    // Templated
                          .rd_data_sel_right_c6(dc_rd_data_sel_37), // Templated
                          .rd_data_sel_left_c6(dc_rd_data_sel_26), // Templated
                          // Inputs
                          .lkup_en_c4_buf({dc_lkup_en_c4_buf_row1[3:2],dc_lkup_en_c4_buf_row0[3:2]}), // Templated
                          .inval_mask_c4_buf(dc_inv_mask_c4_buf_row0[7:0]), // Templated
                          .rw_dec_c4_buf({dc_rw_dec_c4_buf_row1[3:2],dc_rw_dec_c4_buf_row0[3:2]}), // Templated
                          .rd_en_c4_buf (dc_rd_en_c4_buf_row0),  // Templated
                          .wr_en_c4_buf (dc_wr_en_c4_buf_row0),  // Templated
                          .rw_entry_c4_buf(dc_rw_entry_c4_buf_row0[5:0]), // Templated
                          .dir_clear_c4_buf(dc_dir_clear_c4_buf_row0)); // Templated


/* sctag_dir_in	AUTO_TEMPLATE	(
                    .lkup_wr_data_c5    (dc_wr_data@[32:0]),
                    .rddata_out_c6      (dc_rddata_out_@[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_0),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (dc_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (dc_rd_data@_row1[31:0]));
*/

sctag_dir_in	dc_in_04(
			.se(scan_enable_0_buf_c),
                        .si(scannet_16),
                        .so              (scannet_17),
                        .rclk             (rclk),
                       .sehold          (sehold_0_buf_c),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_data04[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_04[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_data04_row0[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_data04_row1[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_0));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE(
                    .lkup_wr_data_c5    (dc_wr_data@[32:0]),
                    .rddata_out_c6      (dc_rddata_out_@[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_1),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (dc_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (dc_rd_data@_row1[31:0]));
*/

sctag_dir_in	dc_in_15(
			.se(scan_enable_0_buf_c),
                        .si(scannet_18),
                        .so              (scannet_19),
                        .rclk             (rclk),
                       .sehold          (sehold_0_buf_c),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_data15[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_15[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_data15_row0[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_data15_row1[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_1));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (dc_wr_data@[32:0]),
                    .rddata_out_c6      (dc_rddata_out_@[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_2),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (dc_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (dc_rd_data@_row1[31:0]));
*/

sctag_dir_in	dc_in_26(
			.se(scan_enable_0_buf_c),
                        .si(scannet_19),
                        .so              (scannet_20),
                        .rclk             (rclk),
                       .sehold          (sehold_0_buf_c),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_data26[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_26[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_data26_row0[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_data26_row1[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_2));      // Templated

/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (dc_wr_data@[32:0]),
                    .rddata_out_c6      (dc_rddata_out_@[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_3),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row0[32:0]),
                    .rd_data1_out_c5    (dc_rd_data@_row0[31:0]),
                    .rd_data2_out_c5    (dc_rd_data@_row1[31:0]));
*/

sctag_dir_in	dc_in_37(	
			.se(scan_enable_0_buf_c),
                        .si(scannet_21),
                        .so              (scannet_22),
                        .rclk             (rclk),
                       .sehold          (sehold_0_buf_c),

			/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_data37[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_37[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row0[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_data37_row0[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_data37_row1[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_3));      // Templated


/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (dc_cam_hit[63:32]),
                 .rd_data\(.*\)         (dc_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (dc_wr_data\1_row@[32:0]),
                 .wr_en         	(dc_wr_en_row@[3:0]),
                 .rd_en         	(dc_rd_en_row@[3:0]),
                 .cam_en         	(dc_cam_en_row@[3:0]),
                 .rw_addr0              (dc_rw_addr_0145[5:0]),          
                 .rw_addr1              (dc_rw_addr_0145[5:0]),          
                 .rw_addr2              (dc_rw_addr_2367[5:0]),          
                 .rw_addr3              (dc_rw_addr_2367[5:0]),
                 .inv_mask0             (dc_inv_mask_0145[7:0]),          
                 .inv_mask1             (dc_inv_mask_0145[7:0]),          
                 .inv_mask2             (dc_inv_mask_2367[7:0]),          
                 .inv_mask3             (dc_inv_mask_2367[7:0]),
                 .wr_data0              (dc_wr_data04[32:0]),   
                 .wr_data1              (dc_wr_data15[32:0]),   
                 .wr_data2              (dc_wr_data26[32:0]),   
                 .wr_data3              (dc_wr_data37[32:0]),   
                 .rd_data0              (dc_rd_data04_row@[31:0]),   
                 .rd_data1              (dc_rd_data15_row@[31:0]),   
                 .rd_data2              (dc_rd_data26_row@[31:0]),   
                 .rd_data3              (dc_rd_data37_row@[31:0]),   
		        .rst_warm_0(dc_warm_rst_0145),
		        .rst_warm_1(dc_warm_rst_2367),
		 );          
*/

bw_r_dcm		dc_row1	(	
                        .si_0(scannet_14),
                        .so_0(scannet_15),
                        .si_1(scannet_15),
                        .so_1(scannet_16),
			.se_0(scan_enable_0_buf_c),
			.se_1(scan_enable_0_buf_c),
                        .rclk             (rclk),
		        .sehold_0(sehold_1_buf_c),
		        .sehold_1(sehold_1_buf_c),
		        .rst_l_0(areset_l_0_buf_c),
		        .rst_l_1(areset_l_0_buf_c),
		        .rst_tri_en_0(mem_write_disable_0_buf_c),
		        .rst_tri_en_1(mem_write_disable_0_buf_c),

			/*AUTOINST*/
                     // Outputs
                     .row_hit           (dc_cam_hit[63:32]),     // Templated
                     .rd_data0          (dc_rd_data04_row1[31:0]), // Templated
                     .rd_data1          (dc_rd_data15_row1[31:0]), // Templated
                     .rd_data2          (dc_rd_data26_row1[31:0]), // Templated
                     .rd_data3          (dc_rd_data37_row1[31:0]), // Templated
                     // Inputs
                     .cam_en            (dc_cam_en_row1[3:0]),   // Templated
                     .inv_mask0         (dc_inv_mask_0145[7:0]), // Templated
                     .inv_mask1         (dc_inv_mask_0145[7:0]), // Templated
                     .inv_mask2         (dc_inv_mask_2367[7:0]), // Templated
                     .inv_mask3         (dc_inv_mask_2367[7:0]), // Templated
                     .rd_en             (dc_rd_en_row1[3:0]),    // Templated
                     .rw_addr0          (dc_rw_addr_0145[5:0]),  // Templated
                     .rw_addr1          (dc_rw_addr_0145[5:0]),  // Templated
                     .rw_addr2          (dc_rw_addr_2367[5:0]),  // Templated
                     .rw_addr3          (dc_rw_addr_2367[5:0]),  // Templated
                     .rst_warm_0        (dc_warm_rst_0145),      // Templated
                     .rst_warm_1        (dc_warm_rst_2367),      // Templated
                     .wr_en             (dc_wr_en_row1[3:0]),    // Templated
                     .wr_data0          (dc_wr_data04[32:0]),    // Templated
                     .wr_data1          (dc_wr_data15[32:0]),    // Templated
                     .wr_data2          (dc_wr_data26[32:0]),    // Templated
                     .wr_data3          (dc_wr_data37[32:0]));    // Templated



/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (),
                       .parity_vld      (dc_parity_in[0]),
                       // Inputs
                       .rddata_out_c6_top(dc_rddata_out_04[31:0]),
                       .rddata_out_c6_bottom(dc_rddata_out_8c[31:0]),
                       .rd_data_sel_c6_top(dc_rd_data_sel_04),
                       .rd_data_sel_c6_bottom(dc_rd_data_sel_8c),
                       .parity_vld_in   (3'b0));
*/

sctag_dir_out	      dc_out_col0	(	
				.se(scan_enable_1_buf_c),
                        .si(scannet_10),
                        .so              (scannet_11),
                        .rclk             (rclk),

				/*AUTOINST*/
                                 // Outputs
                                 .parity_vld_out(),              // Templated
                                 .parity_vld(dc_parity_in[0]),   // Templated
                                 // Inputs
                                 .rddata_out_c6_top(dc_rddata_out_04[31:0]), // Templated
                                 .rddata_out_c6_bottom(dc_rddata_out_8c[31:0]), // Templated
                                 .rd_data_sel_c6_top(dc_rd_data_sel_04), // Templated
                                 .rd_data_sel_c6_bottom(dc_rd_data_sel_8c), // Templated
                                 .parity_vld_in(3'b0));           // Templated

/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (),
                       .parity_vld      (dc_parity_in[1]),
                       // Inputs
                       .rddata_out_c6_top(dc_rddata_out_15[31:0]),
                       .rddata_out_c6_bottom(dc_rddata_out_9d[31:0]),
                       .rd_data_sel_c6_top(dc_rd_data_sel_15),
                       .rd_data_sel_c6_bottom(dc_rd_data_sel_9d),
                       .parity_vld_in   (3'b0));
*/

sctag_dir_out	      dc_out_col1	(	
				.se(scan_enable_1_buf_c),
                        .si(scannet_11),
                        .so              (scannet_12),
                        .rclk             (rclk),

				/*AUTOINST*/
                                 // Outputs
                                 .parity_vld_out(),              // Templated
                                 .parity_vld(dc_parity_in[1]),   // Templated
                                 // Inputs
                                 .rddata_out_c6_top(dc_rddata_out_15[31:0]), // Templated
                                 .rddata_out_c6_bottom(dc_rddata_out_9d[31:0]), // Templated
                                 .rd_data_sel_c6_top(dc_rd_data_sel_15), // Templated
                                 .rd_data_sel_c6_bottom(dc_rd_data_sel_9d), // Templated
                                 .parity_vld_in(3'b0));           // Templated

/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (),
                       .parity_vld      (dc_parity_in[2]),
                       // Inputs
                       .rddata_out_c6_top(dc_rddata_out_26[31:0]),
                       .rddata_out_c6_bottom(dc_rddata_out_ae[31:0]),
                       .rd_data_sel_c6_top(dc_rd_data_sel_26),
                       .rd_data_sel_c6_bottom(dc_rd_data_sel_ae),
                       .parity_vld_in   (3'b0));
*/

sctag_dir_out	      dc_out_col2	(
				.se(scan_enable_1_buf_c),
                        .si(scannet_12),
                        .so              (scannet_13),
                        .rclk             (rclk),

				/*AUTOINST*/
                                 // Outputs
                                 .parity_vld_out(),              // Templated
                                 .parity_vld(dc_parity_in[2]),   // Templated
                                 // Inputs
                                 .rddata_out_c6_top(dc_rddata_out_26[31:0]), // Templated
                                 .rddata_out_c6_bottom(dc_rddata_out_ae[31:0]), // Templated
                                 .rd_data_sel_c6_top(dc_rd_data_sel_26), // Templated
                                 .rd_data_sel_c6_bottom(dc_rd_data_sel_ae), // Templated
                                 .parity_vld_in(3'b0));           // Templated

/* sctag_dir_out	AUTO_TEMPLATE 	 (
                       // Outputs
                       .parity_vld_out  (dc_parity_out[3:1]),
                       .parity_vld      (dc_parity_out[0]),
                       // Inputs
                       .rddata_out_c6_top(dc_rddata_out_37[31:0]),
                       .rddata_out_c6_bottom(dc_rddata_out_bf[31:0]),
                       .rd_data_sel_c6_top(dc_rd_data_sel_37),
                       .rd_data_sel_c6_bottom(dc_rd_data_sel_bf),
                       .parity_vld_in   (dc_parity_in[2:0]));
*/

sctag_dir_out	      dc_out_col3	(
				.se(scan_enable_1_buf_c),
                        .si(scannet_13),
                        .so              (scannet_14),
                        .rclk             (rclk),

				/*AUTOINST*/
                                 // Outputs
                                 .parity_vld_out(dc_parity_out[3:1]), // Templated
                                 .parity_vld(dc_parity_out[0]),  // Templated
                                 // Inputs
                                 .rddata_out_c6_top(dc_rddata_out_37[31:0]), // Templated
                                 .rddata_out_c6_bottom(dc_rddata_out_bf[31:0]), // Templated
                                 .rd_data_sel_c6_top(dc_rd_data_sel_37), // Templated
                                 .rd_data_sel_c6_bottom(dc_rd_data_sel_bf), // Templated
                                 .parity_vld_in(dc_parity_in[2:0])); // Templated




// Row01 repeater.
/*	sctag_dirl_buf	 	AUTO_TEMPLATE	(
                                   // Outputs
                .lkup_en_c4_buf({dc_lkup_en_c4_buf_row1[3:0],dc_lkup_en_c4_buf_row0[3:0]}),
              	.rw_dec_c4_buf({dc_rw_dec_c4_buf_row1[3:0],dc_rw_dec_c4_buf_row0[3:0]}),
               	.inval_mask_c4_buf(dc_inv_mask_c4_buf_row0[7:0]),
                                   .rd_en_c4_buf(dc_rd_en_c4_buf_row0),
                                   .wr_en_c4_buf(dc_wr_en_c4_buf_row0),
                                   .rw_entry_c4_buf(dc_rw_entry_c4_buf_row0[5:0]),
                                   .lkup_wr_data_c4_buf(dc_lkup_wr_data_c4_row0[32:0]),
                                   // Inputs
				   .dir_clear_c4_buf(dc_dir_clear_c4_buf_row0),
				   .dir_clear_c4(dc_dir_clear_c4),
                                   .rd_en_c4(dc_rd_en_c4),
                                   .wr_en_c4(dc_wr_en_c4),
                                   .inval_mask_c4(inval_mask_dcd_c4[7:0]),
                                   .rw_row_en_c4(dc_rdwr_row_en_c4[1:0]),
                                   .rw_panel_en_c4(dc_rdwr_panel_dec_c4[3:0]),
                                   .rw_entry_c4(wr_dc_dir_entry_c4[5:0]),
                                   .lkup_row_en_c4(dc_lkup_row_dec_c4[1:0]),
                                   .lkup_panel_en_c4(dc_lkup_panel_dec_c4[3:0]),
                                   .lkup_wr_data_c4(lkup_wr_data_dn_buf[32:0]));
*/
sctag_dirl_buf 	dc_buf_row0	(

				/*AUTOINST*/
                             // Outputs
                             .lkup_en_c4_buf({dc_lkup_en_c4_buf_row1[3:0],dc_lkup_en_c4_buf_row0[3:0]}), // Templated
                             .inval_mask_c4_buf(dc_inv_mask_c4_buf_row0[7:0]), // Templated
                             .rw_dec_c4_buf({dc_rw_dec_c4_buf_row1[3:0],dc_rw_dec_c4_buf_row0[3:0]}), // Templated
                             .rd_en_c4_buf(dc_rd_en_c4_buf_row0), // Templated
                             .wr_en_c4_buf(dc_wr_en_c4_buf_row0), // Templated
                             .rw_entry_c4_buf(dc_rw_entry_c4_buf_row0[5:0]), // Templated
                             .lkup_wr_data_c4_buf(dc_lkup_wr_data_c4_row0[32:0]), // Templated
                             .dir_clear_c4_buf(dc_dir_clear_c4_buf_row0), // Templated
                             // Inputs
                             .rd_en_c4  (dc_rd_en_c4),           // Templated
                             .wr_en_c4  (dc_wr_en_c4),           // Templated
                             .inval_mask_c4(inval_mask_dcd_c4[7:0]), // Templated
                             .rw_row_en_c4(dc_rdwr_row_en_c4[1:0]), // Templated
                             .rw_panel_en_c4(dc_rdwr_panel_dec_c4[3:0]), // Templated
                             .rw_entry_c4(wr_dc_dir_entry_c4[5:0]), // Templated
                             .lkup_row_en_c4(dc_lkup_row_dec_c4[1:0]), // Templated
                             .lkup_panel_en_c4(dc_lkup_panel_dec_c4[3:0]), // Templated
                             .lkup_wr_data_c4(lkup_wr_data_dn_buf[32:0]), // Templated
                             .dir_clear_c4(dc_dir_clear_c4));     // Templated
// Row23 repeater
/*      sctag_dirl_buf          AUTO_TEMPLATE   (
                                   // Outputs

                .lkup_en_c4_buf({dc_lkup_en_c4_buf_row3[3:0],dc_lkup_en_c4_buf_row2[3:0]}),
              	.rw_dec_c4_buf({dc_rw_dec_c4_buf_row3[3:0],dc_rw_dec_c4_buf_row2[3:0]}),
               	.inval_mask_c4_buf(dc_inv_mask_c4_buf_row2[7:0]),
                                   .rd_en_c4_buf(dc_rd_en_c4_buf_row2),
                                   .wr_en_c4_buf(dc_wr_en_c4_buf_row2),
                                   .rw_entry_c4_buf(dc_rw_entry_c4_buf_row2[5:0]),
                                   .lkup_wr_data_c4_buf(dc_lkup_wr_data_c4_row2[32:0]),
				   .dir_clear_c4_buf(dc_dir_clear_c4_buf_row2),
				   .dir_clear_c4(dc_dir_clear_c4),
                                   // Inputs
                                   .rd_en_c4(dc_rd_en_c4),
                                   .wr_en_c4(dc_wr_en_c4),
                                   .inval_mask_c4(inval_mask_dcd_c4[7:0]),
                                   .rw_row_en_c4(dc_rdwr_row_en_c4[3:2]),
                                   .rw_panel_en_c4(dc_rdwr_panel_dec_c4[3:0]),
                                   .rw_entry_c4(wr_dc_dir_entry_c4[5:0]),
                                   .lkup_row_en_c4(dc_lkup_row_dec_c4[3:2]),
                                   .lkup_panel_en_c4(dc_lkup_panel_dec_c4[3:0]),
                                   .lkup_wr_data_c4(lkup_wr_data_dn_buf[32:0]));
*/


sctag_dirl_buf 	dc_buf_row1	(

				/*AUTOINST*/
                             // Outputs
                             .lkup_en_c4_buf({dc_lkup_en_c4_buf_row3[3:0],dc_lkup_en_c4_buf_row2[3:0]}), // Templated
                             .inval_mask_c4_buf(dc_inv_mask_c4_buf_row2[7:0]), // Templated
                             .rw_dec_c4_buf({dc_rw_dec_c4_buf_row3[3:0],dc_rw_dec_c4_buf_row2[3:0]}), // Templated
                             .rd_en_c4_buf(dc_rd_en_c4_buf_row2), // Templated
                             .wr_en_c4_buf(dc_wr_en_c4_buf_row2), // Templated
                             .rw_entry_c4_buf(dc_rw_entry_c4_buf_row2[5:0]), // Templated
                             .lkup_wr_data_c4_buf(dc_lkup_wr_data_c4_row2[32:0]), // Templated
                             .dir_clear_c4_buf(dc_dir_clear_c4_buf_row2), // Templated
                             // Inputs
                             .rd_en_c4  (dc_rd_en_c4),           // Templated
                             .wr_en_c4  (dc_wr_en_c4),           // Templated
                             .inval_mask_c4(inval_mask_dcd_c4[7:0]), // Templated
                             .rw_row_en_c4(dc_rdwr_row_en_c4[3:2]), // Templated
                             .rw_panel_en_c4(dc_rdwr_panel_dec_c4[3:0]), // Templated
                             .rw_entry_c4(wr_dc_dir_entry_c4[5:0]), // Templated
                             .lkup_row_en_c4(dc_lkup_row_dec_c4[3:2]), // Templated
                             .lkup_panel_en_c4(dc_lkup_panel_dec_c4[3:0]), // Templated
                             .lkup_wr_data_c4(lkup_wr_data_dn_buf[32:0]), // Templated
                             .dir_clear_c4(dc_dir_clear_c4));     // Templated

// Second half
/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (dc_cam_hit[95:64]),
                 .rd_data\(.*\)         (dc_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (dc_wr_data\1_row@[32:0]),
                 .wr_en         	(dc_wr_en_row@[3:0]),
                 .rd_en         	(dc_rd_en_row@[3:0]),
                 .cam_en         	(dc_cam_en_row@[3:0]),
                 .rw_addr0              (dc_rw_addr_89cd[5:0]),          
                 .rw_addr1              (dc_rw_addr_89cd[5:0]),          
                 .rw_addr2              (dc_rw_addr_abef[5:0]),          
                 .rw_addr3              (dc_rw_addr_abef[5:0]),
                 .inv_mask0             (dc_inv_mask_89cd[7:0]),          
                 .inv_mask1             (dc_inv_mask_89cd[7:0]),          
                 .inv_mask2             (dc_inv_mask_abef[7:0]),          
                 .inv_mask3             (dc_inv_mask_abef[7:0]),
                 .wr_data0              (dc_wr_data8c[32:0]),   
                 .wr_data1              (dc_wr_data9d[32:0]),   
                 .wr_data2              (dc_wr_dataae[32:0]),   
                 .wr_data3              (dc_wr_databf[32:0]),   
                 .rd_data0              (dc_rd_data8c_row@[31:0]),   
                 .rd_data1              (dc_rd_data9d_row@[31:0]),   
                 .rd_data2              (dc_rd_dataae_row@[31:0]),   
                 .rd_data3              (dc_rd_databf_row@[31:0]),   
		        .rst_warm_0(dc_warm_rst_89cd),
		        .rst_warm_1(dc_warm_rst_abef),
		 )          
*/

bw_r_dcm		dc_row2	(
                        .si_0(scannet_8),
                        .so_0(scannet_9),
                        .si_1(scannet_9),
                        .so_1(scannet_10),
			.se_0(scan_enable_0_buf_d),
			.se_1(scan_enable_0_buf_d),
                        .rclk             (rclk),
		        .sehold_0(sehold_0_buf_d),
		        .sehold_1(sehold_0_buf_d),
		        .rst_l_0(areset_l_0_buf_d),
		        .rst_l_1(areset_l_0_buf_d),
		        .rst_tri_en_0(mem_write_disable_0_buf_d),
		        .rst_tri_en_1(mem_write_disable_0_buf_d),

			/*AUTOINST*/
                     // Outputs
                     .row_hit           (dc_cam_hit[95:64]),     // Templated
                     .rd_data0          (dc_rd_data8c_row2[31:0]), // Templated
                     .rd_data1          (dc_rd_data9d_row2[31:0]), // Templated
                     .rd_data2          (dc_rd_dataae_row2[31:0]), // Templated
                     .rd_data3          (dc_rd_databf_row2[31:0]), // Templated
                     // Inputs
                     .cam_en            (dc_cam_en_row2[3:0]),   // Templated
                     .inv_mask0         (dc_inv_mask_89cd[7:0]), // Templated
                     .inv_mask1         (dc_inv_mask_89cd[7:0]), // Templated
                     .inv_mask2         (dc_inv_mask_abef[7:0]), // Templated
                     .inv_mask3         (dc_inv_mask_abef[7:0]), // Templated
                     .rd_en             (dc_rd_en_row2[3:0]),    // Templated
                     .rw_addr0          (dc_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr1          (dc_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr2          (dc_rw_addr_abef[5:0]),  // Templated
                     .rw_addr3          (dc_rw_addr_abef[5:0]),  // Templated
                     .rst_warm_0        (dc_warm_rst_89cd),      // Templated
                     .rst_warm_1        (dc_warm_rst_abef),      // Templated
                     .wr_en             (dc_wr_en_row2[3:0]),    // Templated
                     .wr_data0          (dc_wr_data8c[32:0]),    // Templated
                     .wr_data1          (dc_wr_data9d[32:0]),    // Templated
                     .wr_data2          (dc_wr_dataae[32:0]),    // Templated
                     .wr_data3          (dc_wr_databf[32:0]));    // Templated


			
/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({dc_cam_en_row3[1:0],dc_cam_en_row2[1:0]}),
                       .rd_data_en_c4   ({dc_rd_en_row3[1:0],dc_rd_en_row2[1:0]}),
                       .wr_data_en_c4   ({dc_wr_en_row3[1:0],dc_wr_en_row2[1:0]}),
                       .rw_entry_c4     (dc_rw_addr_89cd[5:0]),
                       .inval_mask_c4   (dc_inv_mask_89cd[7:0]),

                       .rd_data_sel0_c5 (dc_rd_data_sel_8),
                       .rd_data_sel1_c5 (dc_rd_data_sel_9),
                       .rd_data_sel_right_c6(dc_rd_data_sel_9d),
                       .rd_data_sel_left_c6(dc_rd_data_sel_8c),

		       .dir_clear_c4_buf(dc_dir_clear_c4_buf_row2),
		       .warm_rst_c4(dc_warm_rst_89cd),
                       .lkup_en_c4_buf  ({dc_lkup_en_c4_buf_row3[1:0],dc_lkup_en_c4_buf_row2[1:0]}),
                       .rw_dec_c4_buf   ({dc_rw_dec_c4_buf_row3[1:0],dc_rw_dec_c4_buf_row2[1:0]}),
                       .inval_mask_c4_buf(dc_inv_mask_c4_buf_row2[7:0]),
                       .rd_en_c4_buf    (dc_rd_en_c4_buf_row2),
                       .wr_en_c4_buf    (dc_wr_en_c4_buf_row2),
                       .rw_entry_c4_buf (dc_rw_entry_c4_buf_row2[5:0]));
*/
			

sctag_dir_ctl	dc_ctl_89cd(
			.se(scan_enable_0_buf_d),
                        .si(scannet_3),
                        .sehold       (sehold_0_buf_d),
                        .so              (scannet_4),
                        .rclk             (rclk),

			/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({dc_rd_en_row3[1:0],dc_rd_en_row2[1:0]}), // Templated
                          .wr_data_en_c4({dc_wr_en_row3[1:0],dc_wr_en_row2[1:0]}), // Templated
                          .cam_en_c4    ({dc_cam_en_row3[1:0],dc_cam_en_row2[1:0]}), // Templated
                          .rw_entry_c4  (dc_rw_addr_89cd[5:0]),  // Templated
                          .inval_mask_c4(dc_inv_mask_89cd[7:0]), // Templated
                          .warm_rst_c4  (dc_warm_rst_89cd),      // Templated
                          .rd_data_sel0_c5(dc_rd_data_sel_8),    // Templated
                          .rd_data_sel1_c5(dc_rd_data_sel_9),    // Templated
                          .rd_data_sel_right_c6(dc_rd_data_sel_9d), // Templated
                          .rd_data_sel_left_c6(dc_rd_data_sel_8c), // Templated
                          // Inputs
                          .lkup_en_c4_buf({dc_lkup_en_c4_buf_row3[1:0],dc_lkup_en_c4_buf_row2[1:0]}), // Templated
                          .inval_mask_c4_buf(dc_inv_mask_c4_buf_row2[7:0]), // Templated
                          .rw_dec_c4_buf({dc_rw_dec_c4_buf_row3[1:0],dc_rw_dec_c4_buf_row2[1:0]}), // Templated
                          .rd_en_c4_buf (dc_rd_en_c4_buf_row2),  // Templated
                          .wr_en_c4_buf (dc_wr_en_c4_buf_row2),  // Templated
                          .rw_entry_c4_buf(dc_rw_entry_c4_buf_row2[5:0]), // Templated
                          .dir_clear_c4_buf(dc_dir_clear_c4_buf_row2)); // Templated


/*	sctag_dir_ctl	AUTO_TEMPLATE	(
		       .cam_en_c4 	({dc_cam_en_row3[3:2],dc_cam_en_row2[3:2]}),
                       .rd_data_en_c4   ({dc_rd_en_row3[3:2],dc_rd_en_row2[3:2]}),
                       .wr_data_en_c4   ({dc_wr_en_row3[3:2],dc_wr_en_row2[3:2]}),
                       .rw_entry_c4     (dc_rw_addr_abef[5:0]),
                       .inval_mask_c4   (dc_inv_mask_abef[7:0]),

                       .rd_data_sel0_c5 (dc_rd_data_sel_a),
                       .rd_data_sel1_c5 (dc_rd_data_sel_b),
                       .rd_data_sel_right_c6(dc_rd_data_sel_bf),
                       .rd_data_sel_left_c6(dc_rd_data_sel_ae),

		       .dir_clear_c4_buf(dc_dir_clear_c4_buf_row2),
		       .warm_rst_c4(dc_warm_rst_abef),
                       .lkup_en_c4_buf  ({dc_lkup_en_c4_buf_row3[3:2],dc_lkup_en_c4_buf_row2[3:2]}),
                       .rw_dec_c4_buf   ({dc_rw_dec_c4_buf_row3[3:2],dc_rw_dec_c4_buf_row2[3:2]}),
                       .inval_mask_c4_buf(dc_inv_mask_c4_buf_row2[7:0]),
                       .rd_en_c4_buf    (dc_rd_en_c4_buf_row2),
                       .wr_en_c4_buf    (dc_wr_en_c4_buf_row2),
                       .rw_entry_c4_buf (dc_rw_entry_c4_buf_row2[5:0]));
*/

sctag_dir_ctl	dc_ctl_abef(
				.se(scan_enable_0_buf_d),
                        .si(scannet_6),
                        .so              (scannet_7),
                          .sehold       (sehold_0_buf_d),
                        .rclk             (rclk),

				/*AUTOINST*/
                          // Outputs
                          .rd_data_en_c4({dc_rd_en_row3[3:2],dc_rd_en_row2[3:2]}), // Templated
                          .wr_data_en_c4({dc_wr_en_row3[3:2],dc_wr_en_row2[3:2]}), // Templated
                          .cam_en_c4    ({dc_cam_en_row3[3:2],dc_cam_en_row2[3:2]}), // Templated
                          .rw_entry_c4  (dc_rw_addr_abef[5:0]),  // Templated
                          .inval_mask_c4(dc_inv_mask_abef[7:0]), // Templated
                          .warm_rst_c4  (dc_warm_rst_abef),      // Templated
                          .rd_data_sel0_c5(dc_rd_data_sel_a),    // Templated
                          .rd_data_sel1_c5(dc_rd_data_sel_b),    // Templated
                          .rd_data_sel_right_c6(dc_rd_data_sel_bf), // Templated
                          .rd_data_sel_left_c6(dc_rd_data_sel_ae), // Templated
                          // Inputs
                          .lkup_en_c4_buf({dc_lkup_en_c4_buf_row3[3:2],dc_lkup_en_c4_buf_row2[3:2]}), // Templated
                          .inval_mask_c4_buf(dc_inv_mask_c4_buf_row2[7:0]), // Templated
                          .rw_dec_c4_buf({dc_rw_dec_c4_buf_row3[3:2],dc_rw_dec_c4_buf_row2[3:2]}), // Templated
                          .rd_en_c4_buf (dc_rd_en_c4_buf_row2),  // Templated
                          .wr_en_c4_buf (dc_wr_en_c4_buf_row2),  // Templated
                          .rw_entry_c4_buf(dc_rw_entry_c4_buf_row2[5:0]), // Templated
                          .dir_clear_c4_buf(dc_dir_clear_c4_buf_row2)); // Templated


/* sctag_dir_in	AUTO_TEMPLATE	(
                    .lkup_wr_data_c5    (dc_wr_data8c[32:0]),
                    .rddata_out_c6      (dc_rddata_out_8c[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_8),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (dc_rd_data8c_row2[31:0]),
                    .rd_data2_out_c5    (dc_rd_data8c_row3[31:0]));
*/

sctag_dir_in	dc_in_8c(
				.se(scan_enable_0_buf_d),
                        .si(scannet_2),
                        .so (scannet_3),
                       .sehold          (sehold_0_buf_d),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_data8c[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_8c[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_data8c_row2[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_data8c_row3[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_8));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE(
                    .lkup_wr_data_c5    (dc_wr_data9d[32:0]),
                    .rddata_out_c6      (dc_rddata_out_9d[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_9),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (dc_rd_data9d_row2[31:0]),
                    .rd_data2_out_c5    (dc_rd_data9d_row3[31:0]));
*/

sctag_dir_in	dc_in_9d(
			.se(scan_enable_0_buf_d),
                        .si(scannet_4),
                        .so              (scannet_5),
                       .sehold          (sehold_0_buf_d),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_data9d[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_9d[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_data9d_row2[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_data9d_row3[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_9));      // Templated



/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (dc_wr_dataae[32:0]),
                    .rddata_out_c6      (dc_rddata_out_ae[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_a),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (dc_rd_dataae_row2[31:0]),
                    .rd_data2_out_c5    (dc_rd_dataae_row3[31:0]));
*/

sctag_dir_in	dc_in_ae(
			.se(scan_enable_0_buf_d),
                        .si(scannet_5),
                        .so              (scannet_6),
                       .sehold          (sehold_0_buf_d),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_dataae[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_ae[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_dataae_row2[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_dataae_row3[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_a));      // Templated

/* 	sctag_dir_in	AUTO_TEMPLATE (
                    .lkup_wr_data_c5    (dc_wr_databf[32:0]),
                    .rddata_out_c6      (dc_rddata_out_bf[31:0]),
                    .rd_enable1_c5      (dc_rd_data_sel_b),
                    // Inputs
                    .lkup_wr_data_c4    (dc_lkup_wr_data_c4_row2[32:0]),
                    .rd_data1_out_c5    (dc_rd_databf_row2[31:0]),
                    .rd_data2_out_c5    (dc_rd_databf_row3[31:0]));
*/

sctag_dir_in	dc_in_bf(
				.se(scan_enable_0_buf_d),
                        .si(scannet_7),
                        .so              (scannet_8),
                       .sehold          (sehold_0_buf_d),
                        .rclk             (rclk),

				/*AUTOINST*/
                       // Outputs
                       .lkup_wr_data_c5 (dc_wr_databf[32:0]),    // Templated
                       .rddata_out_c6   (dc_rddata_out_bf[31:0]), // Templated
                       // Inputs
                       .lkup_wr_data_c4 (dc_lkup_wr_data_c4_row2[32:0]), // Templated
                       .rd_data1_out_c5 (dc_rd_databf_row2[31:0]), // Templated
                       .rd_data2_out_c5 (dc_rd_databf_row3[31:0]), // Templated
                       .rd_enable1_c5   (dc_rd_data_sel_b));      // Templated


/*bw_r_dcm	AUTO_TEMPLATE	(
		 .row_hit               (dc_cam_hit[127:96]),
                 .rd_data\(.*\)         (dc_rd_data\1_row@[31:0]),
                 .wr_data\(.*\)         (dc_wr_data\1_row@[32:0]),
                 .wr_en         	(dc_wr_en_row@[3:0]),
                 .rd_en         	(dc_rd_en_row@[3:0]),
                 .cam_en         	(dc_cam_en_row@[3:0]),
                 .rw_addr0              (dc_rw_addr_89cd[5:0]),          
                 .rw_addr1              (dc_rw_addr_89cd[5:0]),          
                 .rw_addr2              (dc_rw_addr_abef[5:0]),          
                 .rw_addr3              (dc_rw_addr_abef[5:0]),
                 .inv_mask0             (dc_inv_mask_89cd[7:0]),          
                 .inv_mask1             (dc_inv_mask_89cd[7:0]),          
                 .inv_mask2             (dc_inv_mask_abef[7:0]),          
                 .inv_mask3             (dc_inv_mask_abef[7:0]),
                 .wr_data0              (dc_wr_data8c[32:0]),   
                 .wr_data1              (dc_wr_data9d[32:0]),   
                 .wr_data2              (dc_wr_dataae[32:0]),   
                 .wr_data3              (dc_wr_databf[32:0]),   
                 .rd_data0              (dc_rd_data8c_row@[31:0]),   
                 .rd_data1              (dc_rd_data9d_row@[31:0]),   
                 .rd_data2              (dc_rd_dataae_row@[31:0]),   
                 .rd_data3              (dc_rd_databf_row@[31:0]),   
		        .rst_warm_0(dc_warm_rst_89cd),
		        .rst_warm_1(dc_warm_rst_abef),
		 );          
*/


bw_r_dcm		dc_row3	(
                        .si_0(scanin_buf),
                        .so_0(scannet_1),
                        .si_1(scannet_1),
                        .so_1(scannet_2),
			.se_0(scan_enable_0_buf_d),
			.se_1(scan_enable_0_buf_d),
                        .rclk             (rclk),
		        .sehold_0(sehold_1_buf_d),
		        .sehold_1(sehold_1_buf_d),
		        .rst_l_0(areset_l_0_buf_d),
		        .rst_l_1(areset_l_0_buf_d),
		        .rst_tri_en_0(mem_write_disable_0_buf_d),
		        .rst_tri_en_1(mem_write_disable_0_buf_d),
			/*AUTOINST*/
                     // Outputs
                     .row_hit           (dc_cam_hit[127:96]),    // Templated
                     .rd_data0          (dc_rd_data8c_row3[31:0]), // Templated
                     .rd_data1          (dc_rd_data9d_row3[31:0]), // Templated
                     .rd_data2          (dc_rd_dataae_row3[31:0]), // Templated
                     .rd_data3          (dc_rd_databf_row3[31:0]), // Templated
                     // Inputs
                     .cam_en            (dc_cam_en_row3[3:0]),   // Templated
                     .inv_mask0         (dc_inv_mask_89cd[7:0]), // Templated
                     .inv_mask1         (dc_inv_mask_89cd[7:0]), // Templated
                     .inv_mask2         (dc_inv_mask_abef[7:0]), // Templated
                     .inv_mask3         (dc_inv_mask_abef[7:0]), // Templated
                     .rd_en             (dc_rd_en_row3[3:0]),    // Templated
                     .rw_addr0          (dc_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr1          (dc_rw_addr_89cd[5:0]),  // Templated
                     .rw_addr2          (dc_rw_addr_abef[5:0]),  // Templated
                     .rw_addr3          (dc_rw_addr_abef[5:0]),  // Templated
                     .rst_warm_0        (dc_warm_rst_89cd),      // Templated
                     .rst_warm_1        (dc_warm_rst_abef),      // Templated
                     .wr_en             (dc_wr_en_row3[3:0]),    // Templated
                     .wr_data0          (dc_wr_data8c[32:0]),    // Templated
                     .wr_data1          (dc_wr_data9d[32:0]),    // Templated
                     .wr_data2          (dc_wr_dataae[32:0]),    // Templated
                     .wr_data3          (dc_wr_databf[32:0]));    // Templated

sctag_dirg_buf          dirg_buf(
                                /*AUTOINST*/
                                 // Outputs
                                 .lkup_wr_data_up_buf(lkup_wr_data_up_buf[32:0]),
                                 .lkup_wr_data_dn_buf(lkup_wr_data_dn_buf[32:0]),
                                 // Inputs
                                 .dirrep_dir_wr_par_c4(dirrep_dir_wr_par_c4),
                                 .dir_vld_c4_l(dir_vld_c4_l),
                                 .lkup_addr8_c4(lkup_addr8_c4),
                                 .tagdp_lkup_addr_c4(tagdp_lkup_addr_c4[39:10]));



/*cmp_sram_redhdr		AUTO_TEMPLATE(
                           // Outputs
                           .fuse_ary_wren(fuse_l2t_wren),
                           .fuse_ary_rid(fuse_l2t_rid[5:0]),
                           .fuse_ary_repair_value(fuse_l2t_repair_value[7:0]),
                           .fuse_ary_repair_en(fuse_l2t_repair_en[1:0]),
                           // Inputs
                           .efc_spc_fuse_clk1(efc_sctag_fuse_clk1),
                           .efc_spc_fuse_clk2(efc_sctag_fuse_clk2),
                           .efc_spc_xfuse_data(efc_sctag_fuse_data),
                           .efc_spc_xfuse_ashift(efc_sctag_fuse_ashift),
                           .efc_spc_xfuse_dshift(efc_sctag_fuse_dshift),
                           .ary_fuse_repair_value(l2t_fuse_repair_value[6:0]),
                           .ary_fuse_repair_en(l2t_fuse_repair_en[1:0]));

*/

cmp_sram_redhdr red_hdr (
                           .spc_efc_xfuse_data(sctag_fuse_data),
                           .se          (scan_enable_0_buf_h),
                           .scanin      (scannet_87),
                           .scanout     (scannet_88),
                           .rclk        (rclk),
                           .arst_l      (areset_l_0_buf_h),
                           .testmode_l  (testmode_l), // only block receiving testmode_l
			/*AUTOINST*/
                         // Outputs
                         .fuse_ary_wren (fuse_l2t_wren),         // Templated
                         .fuse_ary_rid  (fuse_l2t_rid[5:0]),     // Templated
                         .fuse_ary_repair_value(fuse_l2t_repair_value[7:0]), // Templated
                         .fuse_ary_repair_en(fuse_l2t_repair_en[1:0]), // Templated
                         // Inputs
                         .efc_spc_fuse_clk1(efc_sctag_fuse_clk1), // Templated
                         .efc_spc_fuse_clk2(efc_sctag_fuse_clk2), // Templated
                         .efc_spc_xfuse_data(efc_sctag_fuse_data), // Templated
                         .efc_spc_xfuse_ashift(efc_sctag_fuse_ashift), // Templated
                         .efc_spc_xfuse_dshift(efc_sctag_fuse_dshift), // Templated
                         .ary_fuse_repair_value({1'b0, l2t_fuse_repair_value[6:0]}), // Templated
                         .ary_fuse_repair_en(l2t_fuse_repair_en[1:0])); // Templated

endmodule


// Local Variables:
// verilog-library-directories:("." "../../srams/rtl" "../../common/rtl" )
// End:


