//------------------------------------------------------------------------------
// Copyright (c) 2019 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           cdnsusbhs_adma_top.v
//   Module Name:        cdnsusbhs_adma_top
//
//   Release Revision:   R128_F015
//   Release SVN Tag:    USBHS_DUS1301_R128_F015_H03X32T08A32
//
//   IP Name:            USBHS-OTG
//   IP Part Number:     IP4010E
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          USB
//   Technology:         N/A
//   Protocol:           USB2
//   Architecture:       OTGCTL
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description:
//   DMA Top level architecture
//   M.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



module cdnsusbhs_adma_top
  (
  upclk,
  uprst,

  intreq,


  scmdaccept_m,
  sdata_m,
  sresp_m,
  mcmd_m,
  maddr_m,
  mbyteen_m,
  mburstlength_m,
  mburstseq_m,
  mburstprecise_m,
  mdata_m,
  mreqlast_m,

  fifoaddr,

  fifoinwait,
  fifoinfull,
  fifoinafull,
  fifoinend,
  fifoindvi,
  fifoindatai,
  fifoinwr,

  fifooutwait,
  fifooutbc,
  fifooutdatao,
  fifooutempty,

  fifooutrd,





  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  buf_enable_15,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  buf_enable_14,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  buf_enable_13,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  buf_enable_12,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  buf_enable_11,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  buf_enable_10,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  buf_enable_9,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  buf_enable_8,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  buf_enable_7,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  buf_enable_6,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  buf_enable_5,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  buf_enable_4,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  buf_enable_3,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  buf_enable_2,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  buf_enable_1,
  `endif
  buf_enable_0,
  dmasof,
  innak,
  innak_no,
  fiforst,
  fifooutmaxpck,
  fifoinmaxpck,
  episoout,
  episoin,
  upstrenup,

  dma_upaddr,
  dma_uprd,
  dma_upwr,
  dma_upbe_wr,
  dma_upbe_rd,
  dma_upwdata,
  dma_uprdata,

  axi_idle,
  axi_serror,
  axi_derror,
  axi_id_wr,
  axi_id_rd,
  axi_lock_wr,
  axi_cache_wr,
  axi_prot_wr,
  axi_lock_rd,
  axi_cache_rd,
  axi_prot_rd,

  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  axi_b_max,
  axi_wot,
  axi_rot,
  `endif

  dmabdatard,
  dmabdatawr,
  dmabwr,
  dmabaddr,
  dmabrd
  );





  `include "cdnsusbhs_adma_params.v"







  input                                upclk;
  input                                uprst;



  output                               intreq;
  wire                                 intreq;



  input                                scmdaccept_m;
  input               [DATA_WIDTH-1:0] sdata_m;
  input           [OCP_RESP_WIDTH-1:0] sresp_m;

  output           [OCP_CMD_WIDTH-1:0] mcmd_m;
  output          [OCP_ADDR_WIDTH-1:0] maddr_m;
  output          [(DATA_WIDTH/8)-1:0] mbyteen_m;
  output   [OCP_BURSTLENGTH_WIDTH-1:0] mburstlength_m;
  output      [OCP_BURSTSEQ_WIDTH-1:0] mburstseq_m;
  output                               mburstprecise_m;
  output              [DATA_WIDTH-1:0] mdata_m;
  output                               mreqlast_m;



  output   [3:0]                       fifoaddr;
  wire     [3:0]                       fifoaddr;

  input                                fifoinwait;
  input    [15:0]                      fifoinfull;
  input    [15:0]                      fifoinafull;
  output                               fifoinend;
  wire                                 fifoinend;
  output   [DMADATAWIDTH / 8 - 1:0]    fifoindvi;
  wire     [DMADATAWIDTH / 8 - 1:0]    fifoindvi;
  output   [DMADATAWIDTH - 1:0]        fifoindatai;
  wire     [DMADATAWIDTH - 1:0]        fifoindatai;
  output                               fifoinwr;
  wire                                 fifoinwr;

  input                                fifooutwait;
  input    [10:0]                      fifooutbc;
  input    [DMADATAWIDTH - 1:0]        fifooutdatao;
  input    [15:0]                      fifooutempty;


  output                               fifooutrd;
  wire                                 fifooutrd;








  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  output   [3:0]                       buf_enable_15;
  wire     [3:0]                       buf_enable_15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  output   [3:0]                       buf_enable_14;
  wire     [3:0]                       buf_enable_14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  output   [3:0]                       buf_enable_13;
  wire     [3:0]                       buf_enable_13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  output   [3:0]                       buf_enable_12;
  wire     [3:0]                       buf_enable_12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  output   [3:0]                       buf_enable_11;
  wire     [3:0]                       buf_enable_11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  output   [3:0]                       buf_enable_10;
  wire     [3:0]                       buf_enable_10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  output   [3:0]                       buf_enable_9;
  wire     [3:0]                       buf_enable_9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  output   [3:0]                       buf_enable_8;
  wire     [3:0]                       buf_enable_8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  output   [3:0]                       buf_enable_7;
  wire     [3:0]                       buf_enable_7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  output   [3:0]                       buf_enable_6;
  wire     [3:0]                       buf_enable_6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  output   [3:0]                       buf_enable_5;
  wire     [3:0]                       buf_enable_5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  output   [3:0]                       buf_enable_4;
  wire     [3:0]                       buf_enable_4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  output   [3:0]                       buf_enable_3;
  wire     [3:0]                       buf_enable_3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  output   [3:0]                       buf_enable_2;
  wire     [3:0]                       buf_enable_2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  output   [3:0]                       buf_enable_1;
  wire     [3:0]                       buf_enable_1;
  `endif
  output                               buf_enable_0;
  wire                                 buf_enable_0;
  input    [31:0]                      dmasof;
  input                                innak;
  input    [3:0]                       innak_no;
  output   [16*2-1:0]                  fiforst;
  wire     [16*2-1:0]                  fiforst;
  input    [16*11-1:0]                 fifooutmaxpck;
  input    [16*11-1:0]                 fifoinmaxpck;
  input    [15:0]                      episoout;
  input    [15:0]                      episoin;
  input                                upstrenup;



  input    [SFR_ADDR_WIDTH-3:0]        dma_upaddr;
  input                                dma_uprd;
  input                                dma_upwr;
  input    [3:0]                       dma_upbe_rd;
  input    [3:0]                       dma_upbe_wr;
  input    [31:0]                      dma_upwdata;
  output   [31:0]                      dma_uprdata;
  wire     [31:0]                      dma_uprdata;


  input                               axi_idle;
  input                               axi_serror;
  input                               axi_derror;
  output   [MAXI_ID_WIDTH-1:0]        axi_id_wr;
  wire     [MAXI_ID_WIDTH-1:0]        axi_id_wr;
  output   [MAXI_ID_WIDTH-1:0]        axi_id_rd;
  wire     [MAXI_ID_WIDTH-1:0]        axi_id_rd;

  output   [1:0]                      axi_lock_wr;
  wire     [1:0]                      axi_lock_wr;
  output   [M_CACHE_WIDTH-1:0]        axi_cache_wr;
  wire     [M_CACHE_WIDTH-1:0]        axi_cache_wr;
  output   [2:0]                      axi_prot_wr;
  wire     [2:0]                      axi_prot_wr;
  output   [1:0]                      axi_lock_rd;
  wire     [1:0]                      axi_lock_rd;
  output   [M_CACHE_WIDTH-1:0]        axi_cache_rd;
  wire     [M_CACHE_WIDTH-1:0]        axi_cache_rd;
  output   [2:0]                      axi_prot_rd;
  wire     [2:0]                      axi_prot_rd;

  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  output   [M_LEN_WIDTH-1:0]          axi_b_max;
  wire     [M_LEN_WIDTH-1:0]          axi_b_max;
  output   [AXI_OT_W-1:0]             axi_wot;
  wire     [AXI_OT_W-1:0]             axi_wot;
  output   [AXI_OT_W-1:0]             axi_rot;
  wire     [AXI_OT_W-1:0]             axi_rot;
  `endif


  input    [31:0]                      dmabdatard;
  output   [31:0]                      dmabdatawr;
  wire     [31:0]                      dmabdatawr;
  output                               dmabwr;
  wire                                 dmabwr;
  output   [MEMADDRWIDTH-1:0]          dmabaddr;
  wire     [MEMADDRWIDTH-1:0]          dmabaddr;
  output                               dmabrd;
  wire                                 dmabrd;








  wire             [EPNUM_WIDTH-1:0] dma_do_epnum;
  wire                               dma_do_epdir;
  wire                               dma_do_rdtrb;
  wire                         [1:0] dma_do_cmd;
  wire                               dma_do_data_endianess;
  wire                               dma_do;
  wire                               dma_do_busy;
  wire                               dma_do_done;



`ifdef CDNSUSBHS_CONT_BURST_PROTECTION
  wire                  [F0AWIDTH:0] dma_fifow_lvl;
  wire                  [F1AWIDTH:0] dma_fifor_lvl;
  wire                               dma_xfer_finished;
`endif
  wire              [DATA_WIDTH-1:0] dma_datar;
  wire                               dma_ack;
  wire             [EPNUM_WIDTH-1:0] dma_epnum;
  wire                               dma_epdir;
  wire                               dma_epptr;
  wire           [PKTADDR_WIDTH-1:0] dma_pktaddr;
  wire              [DATA_WIDTH-1:0] dma_dataw;
  wire                        [31:0] dma_epsts;
  wire                        [31:0] dma_epccs;
  wire         [PKTLENGTH_WIDTH-1:0] dma_pktsize_in;

  wire                               dma_last;
  wire                               dma_we;
  wire                               dma_re;
  wire                               dma_re_data;
  wire         [PKTLENGTH_WIDTH-1:0] dma_pktsize_out;
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  wire              [STID_WIDTH-1:0] dma_stid_out;
  wire                               dma_abort;
  wire                               dma_error_stid;
  `endif
  wire                               dma_int_sync;
  wire                               dma_error_outsmm;
  wire                               dma_error_trb;
  wire                               dma_isp;
  wire                               dma_ioc;







  wire                               ocp_cfgrst;





  wire                               ocp_dtrans;
  wire                               dma_do_mult;


  wire                               ocp_dir;
  wire                         [3:0] ocp_epno;


  wire                        [31:0] ocp_traddr_read;
  wire                               ocp_traddr_read_ack;

  wire                        [31:0] ocp_traddr_write;
  wire                               ocp_traddr_read_req;
  wire                               ocp_traddr_write_req;



  wire                               ocp_epdtrans_write;
  wire                               ocp_epdtrans_write_req;
  wire                               ocp_epdtrans_read;


  wire                               ocp_ep_cfg_write;

  wire                               ocp_ependian_read;

  wire                               ocp_enable_read;
  wire                               ocp_ependian_write;
  wire                               ocp_enable_write;





  wire                               ocp_drdy;
  wire                               ocp_eprst;
  wire                               ocp_dflush;



  wire                               ocp_isoerr;
  wire                               ocp_outsmm;

  wire                               ocp_trberr;
  wire                               ocp_inmis;
  wire                               ocp_outmis;
  wire                        [31:0] ocp_descmis;
  wire                               ocp_insp;
  wire                               ocp_outsp;
  wire                               ocp_incmpl;
  wire                               ocp_outcmpl;
  wire                               ocp_dbusy;
  wire                         [1:0] ocp_dbusy_2;

  wire                               ocp_isoerr_ack;
  wire                               ocp_outsmm_ack;
  wire                               ocp_trberr_ack;
  wire                               ocp_inmis_ack;
  wire                               ocp_outmis_ack;
  wire                               ocp_insp_ack;
  wire                               ocp_outsp_ack;
  wire                               ocp_incmpl_ack;
  wire                               ocp_outcmpl_ack;


  wire                        [31:0] ocp_drbl_ch;
  wire                        [31:0] ocp_drbl;
  wire                               ocp_drbl_req;


  wire                        [31:0] ocp_epists;


  wire                               ocp_isoerr_en;
  wire                               ocp_outsmm_en;
  wire                               ocp_trberr_en;
  wire                               ocp_descmis_en;
  wire                               ocp_isoerr_en_ch;
  wire                               ocp_outsmm_en_ch;
  wire                               ocp_trberr_en_ch;
  wire                               ocp_descmis_en_ch;
  wire                               ep_sts_en_wr;

  wire        [XFERLENGTH_WIDTH-1:0] dma_buf_xferlength;
  wire                               dma_buf_xferlength_val;
  wire                               dma_buf_pre_val;

  wire                               dma_trb;








  cdnsusbhs_adma
  U_CDNSUSBHS_ADMA
    (
    `ifdef CDNSUSBHS_IMPLEMENT_DEBUG
    .debug_dma                          (debug_dma),
    `endif
    .clk                                (upclk),
    .rst_n                              (uprst),


    .dma_trb                            (dma_trb),
    .scmdaccept_m                       (scmdaccept_m),
    .sdata_m                            (sdata_m),
    .sresp_m                            (sresp_m),
    .mcmd_m                             (mcmd_m),
    .maddr_m                            (maddr_m),
    .mburstlength_m                     (mburstlength_m),
    .mbyteen_m                          (mbyteen_m),
    .mburstseq_m                        (mburstseq_m),
    .mburstprecise_m                    (mburstprecise_m),
    .mdata_m                            (mdata_m),
    .mreqlast_m                         (mreqlast_m),



    .dma_do_cfgrst                      (ocp_cfgrst),
    .dma_do_epnum                       (dma_do_epnum),
    .dma_do_epdir                       (dma_do_epdir),
    .dma_do_rdtrb                       (dma_do_rdtrb),
    .dma_do_cmd                         (dma_do_cmd),
    .dma_do_data_endianess              (dma_do_data_endianess),

    .dma_do_mult                        (dma_do_mult),
    .dma_do                             (dma_do),
    .dma_do_busy                        (dma_do_busy),
    .dma_do_done                        (dma_do_done),

    .dma_buf_xferlength                 (dma_buf_xferlength),
    .dma_buf_xferlength_val             (dma_buf_xferlength_val),
    .dma_buf_pre_val                    (dma_buf_pre_val),


  `ifdef CDNSUSBHS_CONT_BURST_PROTECTION
    .dma_fifow_lvl                      (dma_fifow_lvl),
    .dma_fifor_lvl                      (dma_fifor_lvl),
    .dma_xfer_finished                  (dma_xfer_finished),
  `endif
    .dma_datar                          (dma_datar),
    .dma_ack                            (dma_ack),
    .dma_epnum                          (dma_epnum),
    .dma_epdir                          (dma_epdir),
    .dma_epptr                          (dma_epptr),
    .dma_pktaddr                        (dma_pktaddr),
    .dma_dataw                          (dma_dataw),
    .dma_epsts                          (dma_epsts),
    .dma_epccs                          (dma_epccs),
    .dma_pktsize_in                     (dma_pktsize_in),

    .dma_last                           (dma_last),
    .dma_we                             (dma_we),
    .dma_re                             (dma_re),
    .dma_re_data                        (dma_re_data),
    .dma_pktsize_out                    (dma_pktsize_out),
    `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
    .dma_stid_out                       (dma_stid_out),
    .dma_abort                          (dma_abort),
    .dma_error_stid                     (dma_error_stid),
    `endif
    .dma_int_sync                       (dma_int_sync),
    .dma_error_outsmm                   (dma_error_outsmm),
    .dma_error_trb                      (dma_error_trb),
    .dma_isp                            (dma_isp),
    .dma_ioc                            (dma_ioc)
  );

`ifdef CDNSUSBHS_CONT_BURST_PROTECTION
  assign dma_fifow_lvl = {(F0AWIDTH+1){1'b0}} ;
  assign dma_fifor_lvl = {(F1AWIDTH+1){1'b0}} ;
  assign dma_xfer_finished = 1'b1;
`endif




  cdnsusbhs_adma_sfr
  U_CDNSUSBHS_ADMA_SFR
    (


    .upclk                              (upclk),
    .uprst                              (uprst),



    .intreq                             (intreq),



    .dma_upaddr                         (dma_upaddr),
    .dma_uprd                           (dma_uprd),
    .dma_upwr                           (dma_upwr),
    .dma_upbe_wr                        (dma_upbe_wr),
    .dma_upbe_rd                        (dma_upbe_rd),
    .dma_upwdata                        (dma_upwdata),
    .dma_uprdata                        (dma_uprdata),

    `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
    .axi_b_max                          (axi_b_max),
    .axi_wot                            (axi_wot),
    .axi_rot                            (axi_rot),
    `endif

    .axi_idle                           (axi_idle),
    .axi_serror                         (axi_serror),
    .axi_derror                         (axi_derror),
    .axi_id_wr                          (axi_id_wr),
    .axi_id_rd                          (axi_id_rd),
    .axi_lock_wr                        (axi_lock_wr),
    .axi_cache_wr                       (axi_cache_wr),
    .axi_prot_wr                        (axi_prot_wr),
    .axi_lock_rd                        (axi_lock_rd),
    .axi_cache_rd                       (axi_cache_rd),
    .axi_prot_rd                        (axi_prot_rd),





    .ocp_cfgrst                         (ocp_cfgrst),




    .ocp_dtrans                         (ocp_dtrans),


    .ocp_dir                            (ocp_dir),
    .ocp_epno                           (ocp_epno),


    .ocp_traddr_read                    (ocp_traddr_read),
    .ocp_traddr_read_ack                (ocp_traddr_read_ack),

    .ocp_traddr_write                   (ocp_traddr_write),
    .ocp_traddr_read_req                (ocp_traddr_read_req),
    .ocp_traddr_write_req               (ocp_traddr_write_req),


    .ocp_epdtrans_write                 (ocp_epdtrans_write),
    .ocp_epdtrans_write_req             (ocp_epdtrans_write_req),
    .ocp_epdtrans_read                  (ocp_epdtrans_read),


    .ocp_ep_cfg_write                   (ocp_ep_cfg_write),

    .ocp_ependian_read                  (ocp_ependian_read),

    .ocp_enable_read                    (ocp_enable_read),
    .ocp_ependian_write                 (ocp_ependian_write),
    .ocp_enable_write                   (ocp_enable_write),


    .ocp_eprst_ack                      (ocp_eprst),
    .ocp_dflush_ack                     (ocp_dflush),
    .ocp_drdy                           (ocp_drdy),
    .ocp_eprst                          (ocp_eprst),
    .ocp_dflush                         (ocp_dflush),



    .ocp_isoerr                         (ocp_isoerr),
    .ocp_outsmm                         (ocp_outsmm),
    .ocp_ccs                            (dma_epccs),

    .ocp_trberr                         (ocp_trberr),
    .ocp_inmis                          (ocp_inmis),
    .ocp_outmis                         (ocp_outmis),
    .ocp_descmis                        (ocp_descmis),
    .ocp_insp                           (ocp_insp),
    .ocp_outsp                          (ocp_outsp),
    .ocp_incmpl                         (ocp_incmpl),
    .ocp_outcmpl                        (ocp_outcmpl),
    .ocp_dbusy                          (ocp_dbusy),
    .ocp_dbusy_2                        (ocp_dbusy_2),

    .ocp_isoerr_ack                     (ocp_isoerr_ack),
    .ocp_outsmm_ack                     (ocp_outsmm_ack),
    .ocp_trberr_ack                     (ocp_trberr_ack),
    .ocp_inmis_ack                      (ocp_inmis_ack),
    .ocp_outmis_ack                     (ocp_outmis_ack),
    .ocp_insp_ack                       (ocp_insp_ack),
    .ocp_outsp_ack                      (ocp_outsp_ack),
    .ocp_incmpl_ack                     (ocp_incmpl_ack),
    .ocp_outcmpl_ack                    (ocp_outcmpl_ack),


    .ocp_isoerr_en                      (ocp_isoerr_en),
    .ocp_outsmm_en                      (ocp_outsmm_en),
    .ocp_trberr_en                      (ocp_trberr_en),
    .ocp_descmis_en                     (ocp_descmis_en),
    .ocp_isoerr_en_ch                   (ocp_isoerr_en_ch),
    .ocp_outsmm_en_ch                   (ocp_outsmm_en_ch),
    .ocp_trberr_en_ch                   (ocp_trberr_en_ch),
    .ocp_descmis_en_ch                  (ocp_descmis_en_ch),
    .ep_sts_en_wr                       (ep_sts_en_wr),


    .ocp_drbl_ch                        (ocp_drbl_ch),
    .ocp_drbl                           (ocp_drbl),
    .ocp_drbl_req                       (ocp_drbl_req),


    .ocp_epists                         (ocp_epists)
  );




  cdnsusbhs_adma_logic
  U_CDNSUSBHS_ADMA_LOGIC
    (


    .upclk                              (upclk),
    .uprst                              (uprst),



    .ocp_cfgrst                         (ocp_cfgrst),

    .ocp_dtrans                         (ocp_dtrans),


    .ocp_dir                            (ocp_dir),
    .ocp_epno                           (ocp_epno),

    .ocp_traddr_read                    (ocp_traddr_read),
    .ocp_traddr_read_ack                (ocp_traddr_read_ack),

    .ocp_traddr_write                   (ocp_traddr_write),
    .ocp_traddr_read_req                (ocp_traddr_read_req),
    .ocp_traddr_write_req               (ocp_traddr_write_req),


    .ocp_epdtrans_write                 (ocp_epdtrans_write),
    .ocp_epdtrans_write_req             (ocp_epdtrans_write_req),
    .ocp_epdtrans_read                  (ocp_epdtrans_read),
    .ocp_ep_cfg_write                   (ocp_ep_cfg_write),
    .ocp_ependian_write                 (ocp_ependian_write),
    .ocp_enable_write                   (ocp_enable_write),

    .ocp_ependian_read                  (ocp_ependian_read),

    .ocp_enable_read                    (ocp_enable_read),

    .ocp_drdy                           (ocp_drdy),
    .ocp_dflush                         (ocp_dflush),
    .ocp_eprst                          (ocp_eprst),

    .ocp_isoerr_ack                     (ocp_isoerr_ack),
    .ocp_outsmm_ack                     (ocp_outsmm_ack),
    .ocp_insp_ack                       (ocp_insp_ack),
    .ocp_outsp_ack                      (ocp_outsp_ack),
    .ocp_ownerr_ack                     (ocp_trberr_ack),
    .ocp_inmis_ack                      (ocp_inmis_ack),
    .ocp_outmis_ack                     (ocp_outmis_ack),
    .ocp_incmpl_ack                     (ocp_incmpl_ack),
    .ocp_outcmpl_ack                    (ocp_outcmpl_ack),

    .ocp_isoerr                         (ocp_isoerr),
    .ocp_outsmm                         (ocp_outsmm),
    .ocp_insp                           (ocp_insp),
    .ocp_outsp                          (ocp_outsp),
    .ocp_ownerr                         (ocp_trberr),
    .ocp_inmis                          (ocp_inmis),
    .ocp_outmis                         (ocp_outmis),
    .ocp_descmis                        (ocp_descmis),
    .ocp_incmpl                         (ocp_incmpl),
    .ocp_outcmpl                        (ocp_outcmpl),
    .ocp_dbusy                          (ocp_dbusy),
    .ocp_dbusy_2                        (ocp_dbusy_2),


    .ocp_isoerr_en                      (ocp_isoerr_en),
    .ocp_outsmm_en                      (ocp_outsmm_en),
    .ocp_ownerr_en                      (ocp_trberr_en),
    .ocp_descmis_en                     (ocp_descmis_en),
    .ocp_isoerr_en_ch                   (ocp_isoerr_en_ch),
    .ocp_outsmm_en_ch                   (ocp_outsmm_en_ch),
    .ocp_ownerr_en_ch                   (ocp_trberr_en_ch),
    .ocp_descmis_en_ch                  (ocp_descmis_en_ch),
    .ep_sts_en_wr                       (ep_sts_en_wr),

    .ocp_drbl                           (ocp_drbl),
    .ocp_drbl_req                       (ocp_drbl_req),
    .ocp_drbl_ch                        (ocp_drbl_ch),

    .ocp_epists                         (ocp_epists),


    .dma_epsts                          (dma_epsts),
    .dma_do_busy                        (dma_do_busy),
    .dma_do_done                        (dma_do_done),
    .dma_do_epnum                       (dma_do_epnum),
    .dma_do_epdir                       (dma_do_epdir),
    .dma_do_rdtrb                       (dma_do_rdtrb),
    .dma_do_cmd                         (dma_do_cmd),
    .dma_do_data_endianess              (dma_do_data_endianess),
    .dma_do                             (dma_do),
    .dma_do_mult                        (dma_do_mult),


    .dma_epnum                          (dma_epnum),
    .dma_epdir                          (dma_epdir),
    .dma_epptr                          (dma_epptr),
    .dma_pktaddr                        (dma_pktaddr[2:0]),
    .dma_dataw                          (dma_dataw),
    .dma_pktsize_in                     (dma_pktsize_in),

    .dma_last                           (dma_last),
    .dma_we                             (dma_we),
    .dma_re                             (dma_re),
    .dma_re_data                        (dma_re_data),
    .dma_int_sync                       (dma_int_sync),
    .dma_error_outsmm                   (dma_error_outsmm),
    .dma_error_own                      (dma_error_trb),
    .dma_isp                            (dma_isp),
    .dma_ioc                            (dma_ioc),
    .dma_datar                          (dma_datar),
    .dma_pktsize_out                    (dma_pktsize_out),
    .dma_ack                            (dma_ack),
    .dma_buf_xferlength                 (dma_buf_xferlength),
    .dma_buf_xferlength_val             (dma_buf_xferlength_val),
    .dma_buf_pre_val                    (dma_buf_pre_val),
    .dma_trb                            (dma_trb),
    `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
    .dma_stid_out                       (dma_stid_out),
    .dma_abort                          (dma_abort),
    .dma_error_stid                     (dma_error_stid),
    `endif
    .fifoaddr                           (fifoaddr),

    .fifoinwait                         (fifoinwait),
    .fifoinfull                         (fifoinfull),
    .fifoinafull                        (fifoinafull),
    .fifoinend                          (fifoinend),
    .fifoindvi                          (fifoindvi),
    .fifoindatai                        (fifoindatai),
    .fifoinwr                           (fifoinwr),

    .fifooutwait                        (fifooutwait),
    .fifooutbc                          (fifooutbc),
    .fifooutdatao                       (fifooutdatao),
    .fifooutempty                       (fifooutempty),

    .fifooutrd                          (fifooutrd),





    `ifdef CDNSUSBHS_EPOUT_EXIST_15
    .buf_enable_15                      (buf_enable_15),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_14
    .buf_enable_14                      (buf_enable_14),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_13
    .buf_enable_13                      (buf_enable_13),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_12
    .buf_enable_12                      (buf_enable_12),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_11
    .buf_enable_11                      (buf_enable_11),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_10
    .buf_enable_10                      (buf_enable_10),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_9
    .buf_enable_9                       (buf_enable_9),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_8
    .buf_enable_8                       (buf_enable_8),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_7
    .buf_enable_7                       (buf_enable_7),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_6
    .buf_enable_6                       (buf_enable_6),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_5
    .buf_enable_5                       (buf_enable_5),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_4
    .buf_enable_4                       (buf_enable_4),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_3
    .buf_enable_3                       (buf_enable_3),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_2
    .buf_enable_2                       (buf_enable_2),
    `endif
    `ifdef CDNSUSBHS_EPOUT_EXIST_1
    .buf_enable_1                       (buf_enable_1),
    `endif
    .buf_enable_0                       (buf_enable_0),
    .dmasof                             (dmasof),
    .innak                              (innak),
    .innak_no                           (innak_no),
    .fiforst                            (fiforst),
    .fifooutmaxpck                      (fifooutmaxpck),
    .fifoinmaxpck                       (fifoinmaxpck),
    .episoout                           (episoout),
    .episoin                            (episoin),
    .upstrenup                          (upstrenup),

    .dmabdatawr                         (dmabdatawr),
    .dmabwr                             (dmabwr),
    .dmabdatard                         (dmabdatard),
    .dmabaddr                           (dmabaddr),
    .dmabrd                             (dmabrd)
  );

endmodule
