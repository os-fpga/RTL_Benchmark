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
//   Filename:           cdnsusbhs_adma_logic.v
//   Module Name:        cdnsusbhs_adma_logic
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
//   DMA Endpoints logic in uP(system) clock domain
//   M.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"

module cdnsusbhs_adma_logic (


  upclk,
  uprst,




  ocp_cfgrst,

  ocp_dtrans,

  ocp_dir,
  ocp_epno,

  ocp_traddr_read,
  ocp_traddr_read_ack,

  ocp_traddr_write,
  ocp_traddr_read_req,
  ocp_traddr_write_req,

  ocp_epdtrans_write,
  ocp_epdtrans_write_req,
  ocp_epdtrans_read,
  ocp_ep_cfg_write,
  ocp_ependian_write,
  ocp_enable_write,

  ocp_ependian_read,

  ocp_enable_read,

  ocp_drdy,
  ocp_dflush,
  ocp_eprst,


  ocp_isoerr_ack,
  ocp_outsmm_ack,
  ocp_insp_ack,
  ocp_outsp_ack,
  ocp_ownerr_ack,
  ocp_inmis_ack,
  ocp_outmis_ack,
  ocp_incmpl_ack,
  ocp_outcmpl_ack,


  ocp_isoerr,
  ocp_outsmm,
  ocp_insp,
  ocp_outsp,
  ocp_ownerr,
  ocp_inmis,
  ocp_outmis,
  ocp_descmis,
  ocp_incmpl,
  ocp_outcmpl,
  ocp_dbusy,
  ocp_dbusy_2,


  ocp_isoerr_en_ch,
  ocp_outsmm_en_ch,
  ocp_ownerr_en_ch,
  ocp_descmis_en_ch,
  ep_sts_en_wr,
  ocp_isoerr_en,
  ocp_outsmm_en,
  ocp_ownerr_en,
  ocp_descmis_en,


  ocp_drbl,
  ocp_drbl_req,

  ocp_drbl_ch,

  ocp_epists,


  dma_epsts,
  dma_do_busy,
  dma_do_done,
  dma_do_epnum,
  dma_do_epdir,
  dma_do_rdtrb,
  dma_do_cmd,
  dma_do_data_endianess,
  dma_do,
  dma_do_mult,


  dma_epnum,
  dma_epdir,
  dma_epptr,
  dma_pktaddr,
  dma_dataw,
  dma_pktsize_in,

  dma_last,
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  dma_abort,
  `endif
  dma_we,
  dma_re,
  dma_re_data,
  dma_int_sync,
  dma_error_outsmm,
  dma_error_own,
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  dma_error_stid,
  `endif
  dma_isp,
  dma_ioc,
  dma_datar,
  dma_pktsize_out,
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  dma_stid_out,
  `endif
  dma_ack,
  dma_buf_xferlength,
  dma_buf_xferlength_val,
  dma_buf_pre_val,
  dma_trb,


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




  fifooutmaxpck,
  fifoinmaxpck,

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
  episoout,
  episoin,
  upstrenup,
  dmasof,
  innak,
  innak_no,
  fiforst,

  dmabdatard,
  dmabdatawr,
  dmabwr,
  dmabaddr,
  dmabrd
  );





  `include "cdnsusbhs_adma_params.v"






  input                         upclk;
  input                         uprst;




  input                         ocp_cfgrst;

  input                         ocp_dtrans;

  input                         ocp_dir;
  input                   [3:0] ocp_epno;


  output                 [31:0] ocp_traddr_read;
  wire                   [31:0] ocp_traddr_read;
  output                        ocp_traddr_read_ack;
  wire                          ocp_traddr_read_ack;


  input                  [31:0] ocp_traddr_write;
  input                         ocp_traddr_read_req;
  input                         ocp_traddr_write_req;

  input                         ocp_epdtrans_write;
  input                         ocp_epdtrans_write_req;
  output                        ocp_epdtrans_read;
  wire                          ocp_epdtrans_read;
  input                         ocp_ep_cfg_write;
  input                         ocp_ependian_write;
  input                         ocp_enable_write;


  output                        ocp_ependian_read;
  wire                          ocp_ependian_read;


  output                        ocp_enable_read;
  wire                          ocp_enable_read;

  input                         ocp_drdy;
  input                         ocp_dflush;
  input                         ocp_eprst;

  input                         ocp_isoerr_ack;
  input                         ocp_outsmm_ack;
  input                         ocp_insp_ack;
  input                         ocp_outsp_ack;
  input                         ocp_ownerr_ack;
  input                         ocp_inmis_ack;
  input                         ocp_outmis_ack;
  input                         ocp_incmpl_ack;
  input                         ocp_outcmpl_ack;


  output                        ocp_isoerr;
  wire                          ocp_isoerr;
  output                        ocp_outsmm;
  wire                          ocp_outsmm;
  output                        ocp_insp;
  wire                          ocp_insp;
  output                        ocp_outsp;
  wire                          ocp_outsp;
  output                        ocp_ownerr;
  wire                          ocp_ownerr;
  output                        ocp_inmis;
  wire                          ocp_inmis;
  output                        ocp_outmis;
  wire                          ocp_outmis;
  output                 [31:0] ocp_descmis;
  wire                   [31:0] ocp_descmis;
  output                        ocp_incmpl;
  wire                          ocp_incmpl;
  output                        ocp_outcmpl;
  wire                          ocp_outcmpl;
  output                        ocp_dbusy;
  wire                          ocp_dbusy;
  output                  [1:0] ocp_dbusy_2;
  wire                    [1:0] ocp_dbusy_2;



  input                         ocp_isoerr_en_ch;
  input                         ocp_outsmm_en_ch;
  input                         ocp_ownerr_en_ch;
  input                         ocp_descmis_en_ch;
  input                         ep_sts_en_wr;
  output                        ocp_isoerr_en;
  wire                          ocp_isoerr_en;
  output                        ocp_outsmm_en;
  wire                          ocp_outsmm_en;
  output                        ocp_ownerr_en;
  wire                          ocp_ownerr_en;
  output                        ocp_descmis_en;
  wire                          ocp_descmis_en;

  input                  [31:0] ocp_drbl;
  input                         ocp_drbl_req;
  output                 [31:0] ocp_drbl_ch;
  reg                    [31:0] ocp_drbl_ch;

  output                 [31:0] ocp_epists;
  reg                    [31:0] ocp_epists;



  input                  [31:0] dma_epsts;
  input                         dma_do_busy;
  input                         dma_do_done;
  output                  [3:0] dma_do_epnum;
  reg                     [3:0] dma_do_epnum;
  output                        dma_do_epdir;
  reg                           dma_do_epdir;
  output                        dma_do_rdtrb;
  reg                           dma_do_rdtrb;
  output                  [1:0] dma_do_cmd;
  reg                     [1:0] dma_do_cmd;
  output                        dma_do_data_endianess;
  wire                          dma_do_data_endianess;
  output                        dma_do;
  reg                           dma_do;
  output                        dma_do_mult;
  wire                          dma_do_mult;


  input                   [3:0] dma_epnum;
  input                         dma_epdir;
  input                         dma_epptr;
  input                   [2:0] dma_pktaddr;
  input        [DATA_WIDTH-1:0] dma_dataw;
  input   [PKTLENGTH_WIDTH-1:0] dma_pktsize_in;

  input                         dma_last;
   `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  input                         dma_abort;
  `endif
  input                         dma_we;
  input                         dma_re;
  input                         dma_re_data;
  input                         dma_int_sync;
  input                         dma_error_outsmm;
  input                         dma_error_own;
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  input                         dma_error_stid;
  `endif
  input                         dma_isp;
  input                         dma_ioc;
  output       [DATA_WIDTH-1:0] dma_datar;
  wire         [DATA_WIDTH-1:0] dma_datar;
  output  [PKTLENGTH_WIDTH-1:0] dma_pktsize_out;
  reg     [PKTLENGTH_WIDTH-1:0] dma_pktsize_out;
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  output       [STID_WIDTH-1:0] dma_stid_out;
  reg          [STID_WIDTH-1:0] dma_stid_out;
  `endif
  output                        dma_ack;
  reg                           dma_ack;
  input  [XFERLENGTH_WIDTH-1:0] dma_buf_xferlength;
  input                         dma_buf_xferlength_val;
  input                         dma_buf_pre_val;
  input                         dma_trb;



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






  input    [16*11-1:0]                 fifooutmaxpck;
  input    [16*11-1:0]                 fifoinmaxpck;


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
  input    [15:0]                      episoout;
  input    [15:0]                      episoin;
  input                                upstrenup;
  input    [31:0]                      dmasof;
  input                                innak;
  input    [3:0]                       innak_no;

  output   [16*2-1:0]                  fiforst;
  wire     [16*2-1:0]                  fiforst;


  input    [31:0]                      dmabdatard;
  output   [31:0]                      dmabdatawr;
  wire     [31:0]                      dmabdatawr;
  output                               dmabwr;
  wire                                 dmabwr;
  output   [MEMADDRWIDTH-1:0]          dmabaddr;
  wire     [MEMADDRWIDTH-1:0]          dmabaddr;
  output                               dmabrd;
  wire                                 dmabrd;





  parameter EP_DMA_IDLE           = 2'b00;
  parameter EP_DMA_CTRL_RD        = 2'b01;
  parameter EP_DMA_DATA           = 2'b10;
  parameter EP_DMA_CTRL_WR        = 2'b11;




  parameter EPIN_POINTER_0        = 32'd`CDNSUSBHS_EPIN_POINTER_0;
  parameter EPIN_POINTER_1        = 32'd`CDNSUSBHS_EPIN_POINTER_1;
  parameter EPIN_POINTER_2        = 32'd`CDNSUSBHS_EPIN_POINTER_2;
  parameter EPIN_POINTER_3        = 32'd`CDNSUSBHS_EPIN_POINTER_3;
  parameter EPIN_POINTER_4        = 32'd`CDNSUSBHS_EPIN_POINTER_4;
  parameter EPIN_POINTER_5        = 32'd`CDNSUSBHS_EPIN_POINTER_5;
  parameter EPIN_POINTER_6        = 32'd`CDNSUSBHS_EPIN_POINTER_6;
  parameter EPIN_POINTER_7        = 32'd`CDNSUSBHS_EPIN_POINTER_7;
  parameter EPIN_POINTER_8        = 32'd`CDNSUSBHS_EPIN_POINTER_8;
  parameter EPIN_POINTER_9        = 32'd`CDNSUSBHS_EPIN_POINTER_9;
  parameter EPIN_POINTER_10       = 32'd`CDNSUSBHS_EPIN_POINTER_10;
  parameter EPIN_POINTER_11       = 32'd`CDNSUSBHS_EPIN_POINTER_11;
  parameter EPIN_POINTER_12       = 32'd`CDNSUSBHS_EPIN_POINTER_12;
  parameter EPIN_POINTER_13       = 32'd`CDNSUSBHS_EPIN_POINTER_13;
  parameter EPIN_POINTER_14       = 32'd`CDNSUSBHS_EPIN_POINTER_14;
  parameter EPIN_POINTER_15       = 32'd`CDNSUSBHS_EPIN_POINTER_15;

  parameter EPOUT_POINTER_0       = 32'd`CDNSUSBHS_EPOUT_POINTER_0;
  parameter EPOUT_POINTER_1       = 32'd`CDNSUSBHS_EPOUT_POINTER_1;
  parameter EPOUT_POINTER_2       = 32'd`CDNSUSBHS_EPOUT_POINTER_2;
  parameter EPOUT_POINTER_3       = 32'd`CDNSUSBHS_EPOUT_POINTER_3;
  parameter EPOUT_POINTER_4       = 32'd`CDNSUSBHS_EPOUT_POINTER_4;
  parameter EPOUT_POINTER_5       = 32'd`CDNSUSBHS_EPOUT_POINTER_5;
  parameter EPOUT_POINTER_6       = 32'd`CDNSUSBHS_EPOUT_POINTER_6;
  parameter EPOUT_POINTER_7       = 32'd`CDNSUSBHS_EPOUT_POINTER_7;
  parameter EPOUT_POINTER_8       = 32'd`CDNSUSBHS_EPOUT_POINTER_8;
  parameter EPOUT_POINTER_9       = 32'd`CDNSUSBHS_EPOUT_POINTER_9;
  parameter EPOUT_POINTER_10      = 32'd`CDNSUSBHS_EPOUT_POINTER_10;
  parameter EPOUT_POINTER_11      = 32'd`CDNSUSBHS_EPOUT_POINTER_11;
  parameter EPOUT_POINTER_12      = 32'd`CDNSUSBHS_EPOUT_POINTER_12;
  parameter EPOUT_POINTER_13      = 32'd`CDNSUSBHS_EPOUT_POINTER_13;
  parameter EPOUT_POINTER_14      = 32'd`CDNSUSBHS_EPOUT_POINTER_14;
  parameter EPOUT_POINTER_15      = 32'd`CDNSUSBHS_EPOUT_POINTER_15;





  reg                    [3:0] epoutqueue;
  reg                    [3:0] epoutqueue_v;
  wire                         epoutqueueempty;
  reg                          epoutqueue_req;
  reg                          epoutqueue_req_v;
  reg                          epoutqueue_ack;
  reg                          xfer_soft_abort;
  wire                  [15:0] epibuffull_c;
  reg                   [15:0] epibuffull;
  reg                          dma_last_req;

  reg                   [31:0] traddr [31:0];
  reg                          fifooutfull_r;
  reg                          epoutqueueempty_r;
  reg                          dma_re_r;
  reg                          epoutqueueemptylast_r;

  reg                          fifooutwait_r;

  reg   [DMADATAWIDTH - 1:0]   fifoindatai0_r;
  reg   [DMADATAWIDTH - 1:0]   fifoindatai1_r;
  reg   [DMADATAWIDTH - 1:0]   fifoindatai2_r;
  reg   [DMADATAWIDTH - 1:0]   fifoindatai3_r;

  reg                          fifoinfull0_r;
  reg                          fifoinfull1_r;
  reg                          fifoinfull2_r;
  reg                          fifoinfull3_r;
  reg  [DMADATAWIDTH/8 - 1:0]  fifoindvi_r;
  wire                         fifoinfullalone;

  reg  [31:0]                  ocp_epdtrans_r;
  wire [31:0]                  ocp_epdtrans;
  wire                         dtrans;

  reg [15:0]                   rd_nxt_trb_en_r;
  wire [15:0]                  rd_nxt_trb_en;

  reg [16*2-1:0]               fiforst_r;
  reg                          dma_trb_r;



  wire                          cfgrst;


  reg                           ocp_drbl_req_ff_r;
  wire                          ocp_drbl_req_re;
  reg                           ocp_drdy_ff_r;
  wire                          ocp_drdy_re;
  wire                    [4:0] ocp_ep;
  reg                    [31:0] epen_r;
  wire                   [31:0] epen;
  reg                    [31:0] ependian_r;
  wire                   [31:0] ependian;
  reg                    [15:0] epidrdy_r;

  wire                   [15:0] epidrdy;
  reg                    [15:0] epodrdy_r;
  wire                   [15:0] epodrdy;
  reg                    [15:0] epodrdy_set;
  reg                    [15:0] epodrdy_clr;
  reg                    [15:0] epooutsmm_en_r;
  wire                   [15:0] epooutsmm_en;
  reg                    [15:0] epooutsmm_r;
  wire                   [15:0] epooutsmm;
  reg                    [31:0] epownerr_en_r;
  wire                   [31:0] epownerr_en;
  reg                    [31:0] epownerr_r;
  wire                   [31:0] epownerr;




















  reg                    [31:0] episoerr_en_r;
  wire                   [31:0] episoerr_en;
  reg                    [15:0] epoisoerr_r;
  reg                    [15:0] epoisoerr_aux_r;
  wire                   [15:0] epoisoerr_aux;
  reg                    [15:0] epiisoerr_r;
  wire                   [31:0] episoerr;
  reg                    [15:0] epiisoerr_aux_r;
  wire                   [15:0] epiisoerr_aux;
  reg                    [31:0] epdescmis_en_r;
  wire                   [31:0] epdescmis_en;
  reg                    [15:0] epiinmis_r;
  wire                   [15:0] epiinmis;
  reg                    [15:0] epooutmis_set;
  reg                    [15:0] epooutmis_clr;
  reg                    [15:0] epooutmis_r;
  wire                   [15:0] epooutmis;
  reg                    [15:0] epiincmpl_r;
  wire                   [15:0] epiincmpl;
  reg                    [15:0] epooutcmpl_r;
  wire                   [15:0] epooutcmpl;
  reg                    [15:0] epiinsp_r;
  wire                   [15:0] epiinsp;
  reg                    [15:0] epooutsp_r;
  wire                   [15:0] epooutsp;
  reg                    [31:0] dbusy;
  reg                    [31:0] dbusy_;
  reg                    [31:0] dpending_;
  wire                   [15:0] epoisotype;
  wire                   [15:0] epiisotype;


  reg                    [10:0] maxp_r     [31:0];








  reg                           dma_epptr_ff_r;
  reg                           dma_rd_r;
  reg                           dma_wr_r;
  reg                           dma_do_done_ff_r;
  reg                           dma_do_busy_ff_r;




  reg                           dma_last_ff_r;


  reg                    [15:0] ep_to_service_r;
  reg                    [15:0] epserviced_v;
  reg                           do_in_xfer;
  reg                           do_in_xfer_r;
  reg                    [15:0] do_in_xfer_vect;
  reg                     [3:0] do_in_xfer_vect_r;
  reg                           do_in_xfer_iso_cont;
  reg                     [1:0] do_in_xfer_cmd_iso_cont;
  reg                    [15:0] do_in_xfer_vect_iso_cont;



  reg                           do_in_xfer_cont;
  reg                     [1:0] do_in_xfer_cmd_cont;
  reg                    [15:0] do_in_xfer_vect_cont;
  reg                           do_in_xfer_new;
  reg                     [1:0] do_in_xfer_cmd_new;
  reg                    [15:0] do_in_xfer_vect_new;
  reg                           do_abort_xfer;
  reg                           do_abort_xfer_dir;
  reg                     [1:0] do_abort_xfer_cmd;
  reg                    [15:0] do_abort_xfer_vect;
  reg                    [10:0] dma_pktsize_in_r;






  reg                           epoutqueue_req_ff_r;
  wire                          epoutqueue_req_re;
  wire                          epoutqueue_val;






  reg                           dma_performs_iso_in_r;
  reg                           dma_aborting_r;
  wire                          xfer_before_abort;
  wire                          xfer_new_start_permission;
  wire                          ocp_eprst_int;
  reg                           ocp_eprst_int_r;
  reg                           eprst_abort_r;
  reg                     [1:0] dma_fsm_st;
  reg                     [1:0] dma_fsm_nxt;
  wire                    [4:0] dma_epdir_epnum;

  wire              [32*11-1:0] epmaxpck;

  reg  [16-1:0]                 trbreqv_r;
  reg                           trbreq_r;
  reg                           trbreq_v;
  reg  [3:0]                    trbreqep_r;
  reg  [3:0]                    trbreqep_v;

  reg    [10:0]                 fifooutbc_r;
  wire   [10:0]                 fifooutbc_c;
  wire                          fifooutempty_dma;
  reg    [DMADATAWIDTH - 1:0]   fifooutdatao_r;
  reg                           fifooutdatao_r_sel;

  wire   [MEMADDRWIDTH-3:0]     dmabaddr_ptr_in;
  wire   [MEMADDRWIDTH-3:0]     dmabaddr_ptr_out;
  wire   [MEMADDRWIDTH-3:0]     dmabaddr_ptr;
  wire   [31:0]                 dmasof_i;















  assign ocp_eprst_int = (ocp_eprst || (ocp_dflush));




  assign cfgrst = ocp_cfgrst;








  assign ocp_ep = {ocp_dir, ocp_epno};




  assign dma_epdir_epnum = {dma_epdir, dma_epnum};












  assign dmasof_i = dmasof & IMPLEMENT_EP;




  always @(epen        or epooutmis      or
           epiinmis    or epdescmis_en   or
           epownerr    or epownerr_en    or
           epooutcmpl  or epiincmpl      or
           epooutsp    or epiinsp        or
           episoerr    or episoerr_en    or
           epooutsmm   or epooutsmm_en   )
  begin : OCP_EPISTS_PROC
    ocp_epists[0]  = ( epen[0] &
                       ( (epooutmis[0] & epdescmis_en[0]) |
                         (epownerr[0] & epownerr_en[0]) |
                         (epooutcmpl[0]) |
                         (epooutsp[0])   |
                         (epooutsmm[0] & epooutsmm_en[0])
                       )
                     );
    ocp_epists[16] = ( epen[16] &
                       ( (epiinmis[0]  & epdescmis_en[16])  |
                         (epownerr[16] & epownerr_en[16]) |
                         (epiincmpl[0]) |
                         (epiinsp[0])
                        )
                     );
    begin : OCP_EPISTS_LOOP
      integer i;
      for (i = 1; i < 16; i = i + 1)
        begin
          ocp_epists[i]    = (epen[i] &
                               ( (epooutmis[i] & epdescmis_en[i]) |
                                 (epownerr[i] & epownerr_en[i]) |
                                 (epooutcmpl[i]) |
                                 (epooutsp[i])   |
                                 (episoerr[i] & episoerr_en[i]) |
                                 (epooutsmm[i] & epooutsmm_en[i])
                               )
                             );
          ocp_epists[i+16] = (epen[i+16] &
                               ( (epiinmis[i] & epdescmis_en[i+16])  |
                                 (epownerr[i+16] & epownerr_en[i+16]) |
                                 (episoerr[i+16] & episoerr_en[i+16]) |
                                 (epiincmpl[i]) |
                                 (epiinsp[i])
                               )
                             );
        end
    end
  end












  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPDESCMIS_EN_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epdescmis_en_r <= {32{1'b0}};
    else
      begin : EPDESCMIS_EN_R_LOOP
        integer i;
        for (i = 0; i < 32; i = i + 1)
          begin
            if (cfgrst)
              epdescmis_en_r[i] <= 1'b0;
            else if (ep_sts_en_wr && ocp_ep == i)
              epdescmis_en_r[i] <= ocp_descmis_en_ch;
          end
      end
  end




  assign epdescmis_en = epdescmis_en_r & IMPLEMENT_EP;




  assign ocp_descmis_en = epdescmis_en[ocp_ep];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPIINMIS_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epiinmis_r <= {16{1'b0}};
    else
      begin : EPIINMIS_R_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
        begin
          if (  (cfgrst) ||
                (ocp_dir && ocp_epno == i && (ocp_inmis_ack || ocp_eprst)) ||
                (ocp_dir && ocp_epno == i && ocp_drdy_re)   ||
                (ocp_drbl[i+16] && ocp_drbl_req_re)
              )
            epiinmis_r[i] <= 1'b0;
          else if ( !epidrdy[i] &&
                    !(innak==1'b0) && (innak_no == i) &&
                    !(dma_do_busy && dma_epnum == i && dma_epdir) &&
                    !(dma_epsts[i+16]) &&  epiisotype[i] == 1'b0
             )
            epiinmis_r[i] <= 1'b1;
        end
      end
  end




  assign epiinmis = epiinmis_r & IMPLEMENT_EP[31:16];




  assign ocp_inmis = ocp_dir & epiinmis[ocp_epno] & epdescmis_en[ocp_ep];




  assign ocp_descmis = ({epiinmis, epooutmis} & epdescmis_en);




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPIINCMPL_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epiincmpl_r <= {16{1'b0}};
    else
      begin : EPIINCMPL_R_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
          begin
            if (  (cfgrst) ||
                  ((ocp_incmpl_ack || ocp_eprst) && ocp_dir && ocp_epno == i) )
              epiincmpl_r[i] <= 1'b0;
            else if (dma_ioc && !eprst_abort_r && dma_epdir && dma_epnum == i &&
                     !(xfer_before_abort && dma_do_epdir && dma_do_epnum == i)
                    )
              epiincmpl_r[i] <= 1'b1;
          end
      end
  end




  assign epiincmpl = epiincmpl_r & IMPLEMENT_EP[31:16];




  assign ocp_incmpl = ocp_dir & epiincmpl[ocp_epno];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPIINSP_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      epiinsp_r <= {16{1'b0}};
    else
      begin : EPIINSP_R_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
          begin
            if (  (cfgrst) ||
                  ((ocp_insp_ack || ocp_eprst) && ocp_dir && ocp_epno == i) )
              epiinsp_r[i] <= 1'b0;
            else if (dma_isp && !eprst_abort_r && dma_epdir && dma_epnum == i &&
                     !(xfer_before_abort && dma_do_epdir && dma_do_epnum == i)
                    )
              epiinsp_r[i] <= 1'b1;
          end
      end
  end




  assign epiinsp = epiinsp_r & IMPLEMENT_EP[31:16];




  assign ocp_insp = ocp_dir & epiinsp[ocp_epno];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOOUTSMM_EN_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epooutsmm_en_r <= {16{1'b0}};
    else
      if (cfgrst)
        epooutsmm_en_r[15:1] <= {15{1'b0}};
      else if(ep_sts_en_wr & (!ocp_dir) )
        epooutsmm_en_r [ocp_epno] <= ocp_outsmm_en_ch;
  end




  assign epooutsmm_en = epooutsmm_en_r & IMPLEMENT_EP[15:0];




  assign ocp_outsmm_en = !ocp_dir & epooutsmm_en[ocp_epno];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOOUTSMM_PROC
    if `CDNSUSBHS_RESET(uprst)
      epooutsmm_r <= {16{1'b0}};
    else
      if (cfgrst)
        epooutsmm_r <= {16{1'b0}};
      else if(dma_error_outsmm)
        epooutsmm_r [dma_epnum] <= 1'b1;
      else if((ocp_outsmm_ack || ocp_eprst) & (!ocp_dir) )
        epooutsmm_r [ocp_epno] <= 1'b0;
  end




  assign epooutsmm = epooutsmm_r & IMPLEMENT_EP[15:0];




  assign ocp_outsmm = !ocp_dir & epooutsmm[ocp_epno] & epooutsmm_en[ocp_epno];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOWNERR_EN_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epownerr_en_r <= {32{1'b0}};
    else
      begin : EPOWNERR_EN_R_LOOP
        integer i;
        for (i = 0; i < 32; i = i + 1)
          begin
            if (cfgrst)
              epownerr_en_r[i] <= 1'b0;
            else if (ep_sts_en_wr && ocp_ep == i)
              epownerr_en_r[i] <= ocp_ownerr_en_ch;
          end
      end
  end




  assign epownerr_en = epownerr_en_r & IMPLEMENT_EP;




  assign ocp_ownerr_en = epownerr_en[ocp_ep];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOWNERR_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epownerr_r <= {32{1'b0}};
    else
      begin : EPOWNERR_R_LOOP
        integer i;
        for (i = 0; i < 32; i = i + 1)
          begin
            if (  (cfgrst) ||
                  ((ocp_ownerr_ack || ocp_eprst) && ocp_ep == i) )
              epownerr_r[i] <= 1'b0;
            else if (dma_error_own && dma_epdir_epnum == i)
              epownerr_r[i] <= 1'b1;
          end
      end
  end




  assign epownerr = epownerr_r & IMPLEMENT_EP;




  assign ocp_ownerr =  epownerr[ocp_ep] & ocp_ownerr_en;




  always @(epodrdy_r         or dma_epsts   or
           epoutqueue_req_re or epoutqueue  or
           epoutqueueempty   or dma_do_busy or
           dma_epnum         or dma_epdir )
  begin : EPOOUTMIS_SET_PROC
    begin : EPOOUTMIS_SET_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
        begin
          if (!epodrdy_r[i] && !dma_epsts[i] &&
             !(dma_do_busy && dma_epnum == i && !dma_epdir ) &&
              ((epoutqueue_req_re && !epoutqueueempty && epoutqueue == i)
               )
              )
            epooutmis_set[i] = 1'b1;
          else
            epooutmis_set[i] = 1'b0;
        end
    end
  end




  always @(ocp_dir        or ocp_epno        or
           ocp_outmis_ack or ocp_drdy_re     or
           ocp_drbl       or ocp_drbl_req_re or
           ocp_eprst)
  begin : EPOOUTMIS_CLR_PROC
    begin : EPOOUTMIS_CLR_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
        begin
          if ( (!ocp_dir && ocp_epno == i && (ocp_eprst|| ocp_outmis_ack)) ||
               (!ocp_dir && ocp_epno == i && ocp_drdy_re) ||
               (ocp_drbl[i] && ocp_drbl_req_re) )
            epooutmis_clr[i] = 1'b1;
          else
            epooutmis_clr[i] = 1'b0;
        end
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOOUTMIS_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      epooutmis_r <= {16{1'b0}};
    else
      begin : EPOOUTMIS_R_LOOP
        integer i;
        for (i = 0; i < 16; i = i + 1)
          begin
            if ( cfgrst || epooutmis_clr[i] )
              epooutmis_r[i] <= 1'b0;
            else if ( epooutmis_set[i] )
              epooutmis_r[i] <= 1'b1;
          end
      end
  end

































  assign epooutmis = epooutmis_r & IMPLEMENT_EP[15:0];




  assign ocp_outmis = !ocp_dir & epooutmis[ocp_epno] & epdescmis_en[ocp_ep];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOOUTCMPL_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      epooutcmpl_r <= {16{1'b0}};
    else
      begin : EPOOUTCMPL_R_LOOP
        integer i;
        for (i = 0; i < 16; i = i + 1)
          begin
            if ( (cfgrst) ||
               ((ocp_outcmpl_ack || ocp_eprst) && !ocp_dir && ocp_epno == i) )
              epooutcmpl_r[i] <= 1'b0;
            else if (dma_ioc && !eprst_abort_r && !dma_epdir && dma_epnum == i &&
                     !(xfer_before_abort && !dma_do_epdir && dma_do_epnum == i)
                    )
              epooutcmpl_r[i] <= 1'b1;
          end
      end
  end




  assign epooutcmpl = epooutcmpl_r & IMPLEMENT_EP[15:0];




  assign ocp_outcmpl = !ocp_dir & epooutcmpl[ocp_epno];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOOUTSP_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      epooutsp_r <= {16{1'b0}};
    else
      begin : EPOOUTSP_R_LOOP
        integer i;
        for (i = 0; i < 16; i = i + 1)
          begin
            if ( (cfgrst) ||
                 ((ocp_outsp_ack || ocp_eprst) && !ocp_dir && ocp_epno == i) )
              epooutsp_r[i] <= 1'b0;
            else if (dma_isp && !eprst_abort_r && !dma_epdir && dma_epnum == i &&
                     !(xfer_before_abort && !dma_do_epdir && dma_do_epnum == i)
                    )
              epooutsp_r[i] <= 1'b1;
          end
      end
  end




  assign epooutsp = epooutsp_r & IMPLEMENT_EP[15:0];




  assign ocp_outsp = !ocp_dir & epooutsp[ocp_epno];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : ISOERR_EN_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      episoerr_en_r <= {32{1'b0}};
    else
      begin : EPISOERR_EN_R_LOOP
        integer i;


        for (i = 0; i < 32; i = i + 1)
          begin
            if (cfgrst)
              episoerr_en_r[i] <= 1'b0;
            else if (ep_sts_en_wr && ocp_ep == i)
              episoerr_en_r[i] <= ocp_isoerr_en_ch;
          end
      end
  end




  assign episoerr_en = episoerr_en_r & IMPLEMENT_EP_ISO[31:0] &
                       32'b1111_1111_1111_1110_1111_1111_1111_1110;




  assign ocp_isoerr_en = episoerr_en[ocp_ep];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOISOERR_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epoisoerr_r <= {16{1'b0}};
    else
      begin
        begin : EPOISOERR_R_LOOP
          integer i;
          for (i = 0; i < 16; i = i + 1)
          begin
            if (cfgrst ||
                  ((ocp_isoerr_ack || ocp_eprst) && !ocp_dir && ocp_epno == i) )
                epoisoerr_r[i] <= 1'b0;
            else
                if (epoisoerr_aux[i] && dma_int_sync && dma_aborting_r &&
                    !dma_epdir && dma_epnum == i)
                  epoisoerr_r[i] <= 1'b1;
            end
        end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOISOERR_AUX_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epoisoerr_aux_r <= {16{1'b0}};
    else
      begin
        begin : EPOISOERR_AUX_R_LOOP
          integer i;
          for (i = 0; i < 16; i = i + 1)
            begin
              if (cfgrst || (ocp_eprst_int && !ocp_dir && ocp_epno == i))
                epoisoerr_aux_r[i] <= 1'b0;







              else if (dmasof_i[i] & epoisotype[i] &
                        ((!fifooutempty[i] & !dbusy[i])|
                        (dbusy[i])))
                epoisoerr_aux_r[i] <= 1'b1;
              else if (dma_int_sync && dma_aborting_r &&
                       !dma_epdir && dma_epnum == i)
                epoisoerr_aux_r[i] <= 1'b0;
            end
        end
      end
  end




  assign epoisoerr_aux = epoisoerr_aux_r & IMPLEMENT_EP_ISO[15:0] &
                       16'b1111_1111_1111_1110;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPIISOERR_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epiisoerr_r <= {16{1'b0}};
    else
      begin
        begin : EPIISOERR_R_LOOP
          integer i;
          for (i = 0; i < 16; i = i + 1)
              begin
              if (cfgrst ||
                  ((ocp_isoerr_ack || ocp_eprst) && ocp_dir && ocp_epno == i) )
                epiisoerr_r[i] <= 1'b0;
              else
                if (  (epiisoerr_aux[i] && dma_int_sync && (dma_aborting_r || !dma_epsts[i+16]) &&
                    dma_epdir && dma_epnum == i )
                   )
                  epiisoerr_r[i] <= 1'b1;
              end
          end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPIISOERR_AUX_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      epiisoerr_aux_r <= {16{1'b0}};
    else
      begin
        begin : EPIISOERR_AUX_R_LOOP
          integer i;
          for (i = 0; i < 16; i = i + 1)
            begin
              if (cfgrst || (ocp_eprst_int && ocp_dir && ocp_epno == i))
                epiisoerr_aux_r[i] <= 1'b0;


              else if (dmasof_i[i+16] & epiisotype[i] &

                        ((rd_nxt_trb_en[i] & epidrdy[i]) | dbusy[i+16]))
                epiisoerr_aux_r[i] <= 1'b1;
              else if (  (dma_int_sync && (dma_aborting_r || !dma_epsts[i+16]) &&
                       dma_epdir && dma_epnum == i)
                      )

                epiisoerr_aux_r[i] <= 1'b0;
            end
        end
      end
  end




  assign epiisoerr_aux = epiisoerr_aux_r & IMPLEMENT_EP_ISO[31:16] &
                       16'b1111_1111_1111_1110;




  assign episoerr = {epiisoerr_r,epoisoerr_r} & IMPLEMENT_EP_ISO[31:0] &
                       32'b1111_1111_1111_1110_1111_1111_1111_1110;




  assign ocp_isoerr = episoerr[ocp_ep] && ocp_isoerr_en;




  always @(dma_epsts or dma_do_busy_ff_r or
           dma_epdir_epnum)
  begin : DBUSY_PROC
    begin : DBUSY_LOOP
        integer i;
        for (i = 0; i < 32; i = i + 1)
          begin
          if (dma_epsts[i] ||
              (dma_do_busy_ff_r && dma_epdir_epnum == i))
            dbusy[i] = 1'b1;
          else
            dbusy[i] = 1'b0;
          end
      end
  end




  always @(dma_do_busy_ff_r or dma_epdir_epnum)
  begin : DBUSY__PROC
    begin : DBUSY__LOOP
        integer i;
        for (i = 0; i < 32; i = i + 1)
          begin
          if (dma_do_busy_ff_r && dma_epdir_epnum == i)
            dbusy_[i] = 1'b1;
          else
            dbusy_[i] = 1'b0;
          end
      end
  end




  always @(dma_epsts)
  begin : DPENDING__PROC
    begin : DPENDING__LOOP
        integer i;
        for (i = 0; i < 32; i = i + 1)
          begin
          if (dma_epsts[i])
            dpending_[i] = 1'b1;
          else
            dpending_[i] = 1'b0;
          end
      end
  end




  assign  ocp_dbusy = dbusy[ocp_ep];




  assign  ocp_dbusy_2 = {dbusy_[ocp_ep], dpending_[ocp_ep]};



















  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPEN_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)

      epen_r <= 32'b00000000_00000000_00000000_00000000;
    else
      if (cfgrst)

        epen_r <= 32'b00000000_00000000_00000000_00000000;
      else if (ocp_eprst)
        epen_r[ocp_ep] <= 1'b0;
      else if (ocp_ep_cfg_write)
        epen_r[ocp_ep] <= ocp_enable_write;
  end




  assign epen = epen_r & IMPLEMENT_EP;




  assign ocp_enable_read = epen[ocp_ep];









  assign epoisotype = episoout;
  assign epiisotype = episoin;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPENDIAN_SYNC_PROC
  if `CDNSUSBHS_RESET(uprst)
    ependian_r <= {32{1'b0}};
  else
    if (cfgrst)
      ependian_r <= {32{1'b0}};
    else if (ocp_ep_cfg_write)
      ependian_r[ocp_ep]  <= ocp_ependian_write;
  end

  assign ependian = ependian_r & IMPLEMENT_EP;




  assign ocp_ependian_read = ependian[ocp_ep];












  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPIDRDY_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
        begin
        epidrdy_r <= {16{1'b0}};

        end
    else
      begin : EPIDRDY_R_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
          begin

            if ( (cfgrst) ||
                 (dma_do_done && (dma_do_cmd != 2'b00) && dma_do_epdir &&
                    ep_to_service_r[i] && !dtrans && !dma_epsts[i+16]) ||
                 (epownerr[i+16] || (dma_error_own && dma_epdir && dma_epnum == i)) ||
                 (ocp_dir && ocp_epno == i && ocp_eprst_int ) )
              epidrdy_r[i] <= 1'b0;
            else if (
                      (ocp_dir && ocp_epno == i && ocp_drdy_re ) ||
                      (ocp_drbl[i+16] && ocp_drbl_req_re)
                    )
              epidrdy_r[i] <= 1'b1;
          end
      end
  end




  assign epidrdy = epidrdy_r & IMPLEMENT_EP[31:16];




  always @(ocp_dir         or ocp_epno  or
           ocp_drdy_re     or ocp_drbl  or
           ocp_drbl_req_re )
  begin : EPODRDY_SET_PROC
    begin : EPODRDY_SET_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
        begin
          if (
             ((!ocp_dir && ocp_epno == i && ocp_drdy_re) || (ocp_drbl[i] && ocp_drbl_req_re))
             )
            epodrdy_set[i] = 1'b1;
          else
            epodrdy_set[i] = 1'b0;
        end
    end
  end




  always @(ocp_dir       or ocp_epno         or
           ocp_eprst_int or dma_do_done      or
           epownerr      or ep_to_service_r  or
           dtrans        or dma_do_epdir     or
           dma_epsts     or dma_do_cmd       or
           dma_epnum     or dma_epdir        or
           dma_error_own or dma_do_rdtrb)
  begin : EPODRDY_CLR_PROC
    begin : EPODRDY_CLR_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
        begin
          if ( (dma_do_done && (dma_do_cmd != 2'b00) && dma_do_rdtrb == 1'b0 &&
                !dma_do_epdir && ep_to_service_r[i] && !dtrans && !dma_epsts[i]) ||
               (!ocp_dir && ocp_epno == i && ocp_eprst_int) ||
               (epownerr[i] || (dma_error_own && !dma_epdir && dma_epnum == i) )
              )
            epodrdy_clr[i] = 1'b1;
          else
            epodrdy_clr[i] = 1'b0;
        end
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPODRDY_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      epodrdy_r <= {16{1'b0}};
    else
      begin : EPODRDY_R_LOOP
        integer i;
        for (i = 0; i < 16; i = i + 1)
          begin
            if ( cfgrst || epodrdy_clr[i] )
              epodrdy_r[i] <= 1'b0;
            else if ( epodrdy_set[i] )
              epodrdy_r[i] <= 1'b1;
          end
      end
  end




  assign epodrdy = epodrdy_r & IMPLEMENT_EP[15:0];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_DRDY_FF_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_drdy_ff_r <= 1'b0;
    else
      ocp_drdy_ff_r <= ocp_drdy;
  end




  assign ocp_drdy_re = ocp_drdy && !ocp_drdy_ff_r;












  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_DRBL_REQ_FF_R_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_drbl_req_ff_r <= 1'b0;
    else
      ocp_drbl_req_ff_r <= ocp_drbl_req;
  end




  assign ocp_drbl_req_re = ocp_drbl_req && !ocp_drbl_req_ff_r;




  always @(epidrdy or epodrdy)
  begin : OCP_DRBL_CH_PROC
    begin : OCP_DRBL_CH_LOOP
      integer i;
      for (i = 0; i < 16; i = i + 1)
        begin
          ocp_drbl_ch[i]    = (epodrdy[i]);
          ocp_drbl_ch[i+16] = (epidrdy[i]);
        end
    end
  end








  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_FF_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
        dma_do_busy_ff_r          <= 1'b0;
        dma_last_ff_r             <= 1'b0;
        dma_epptr_ff_r            <= 1'b0;
        dma_do_done_ff_r          <= 1'b0;



        epoutqueue_req_ff_r       <= 1'b0;


      end
    else
      begin
        dma_do_busy_ff_r          <= dma_do_busy;
        dma_last_ff_r             <= dma_last;
        dma_epptr_ff_r            <= dma_epptr;
        dma_do_done_ff_r          <= dma_do_done;



        epoutqueue_req_ff_r       <= epoutqueue_req;


      end
  end





  assign epoutqueue_req_re = epoutqueue_req && !epoutqueue_req_ff_r;




  assign epoutqueue_val = epoutqueue_req && !epoutqueue_ack;

























  assign dma_datar        = (dma_epptr &
                              dma_pktaddr[0] &
                              dma_pktaddr[2]    ) ? {{21{1'b0}},maxp_r[dma_epdir_epnum]} :
                             (dma_epptr &
                              dma_pktaddr[2]    ) ? traddr[dma_epdir_epnum] :
                             (dma_epptr) ? dmabdatard :
                             (fifooutdatao_r_sel) ?
                                           fifooutdatao_r :
                                           fifooutdatao;


















  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : dma_re_r_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
        dma_re_r  <= 1'b0;
      end
    else
      begin
        dma_re_r  <= dma_re;
      end
  end




















































  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : XFER_SOFT_ABORT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      xfer_soft_abort <= 1'b0;
    else
      if  (!dma_last_ff_r && dma_epptr && !dma_epptr_ff_r &&
             (dma_fsm_st == EP_DMA_CTRL_WR || dma_fsm_st == EP_DMA_DATA) )
        xfer_soft_abort  <= 1'b1;
      else
        xfer_soft_abort  <= 1'b0;
  end









    `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK




    `else

    `endif





  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOUTQUEUE_ACK_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      epoutqueue_ack <= 1'b0;
    else
      if (!epoutqueue_req
         )
        epoutqueue_ack  <= 1'b0;
      else if (epoutqueue_req &&
                (dma_do_done && (dma_do_cmd == 2'b01 || dma_do_cmd == 2'b10) &&
                 !dma_do_epdir && dma_do_epnum == epoutqueue)
               )
        epoutqueue_ack  <= 1'b1;




  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_RD_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      dma_rd_r  <= 1'b0;
    else
      if (dma_do && dma_do_done && dma_do_cmd!=2'b00)
        dma_rd_r <= 1'b1;
      else if (
                (!dma_epptr && dma_epptr_ff_r && dma_epdir)
                ||
                (dma_last_ff_r && dma_epptr)
                 ||
                xfer_soft_abort
              )
        dma_rd_r <= 1'b0;
      else if (!dma_do_busy)
        dma_rd_r <= 1'b0;
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_WR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      dma_wr_r  <= 1'b0;
    else
      if (!dma_do_busy)
        dma_wr_r <= 1'b0;
      else if (
                (!dma_epptr && dma_epptr_ff_r && dma_epdir)
                ||
                (dma_last_ff_r && dma_epptr)
                ||
                xfer_soft_abort
                )
        dma_wr_r <= 1'b1;
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_LAST_REQ_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      dma_last_req  <= 1'b0;
    else
      if (dma_last & !dma_last_ff_r & dma_epdir)
        dma_last_req <= 1'b1;
      else if ((!fifoinwr & !fifoinwait) || cfgrst)
        dma_last_req <= 1'b0;
  end













































  always @(dma_fsm_st or dma_do_done or dma_do_cmd or
           dma_epptr or dma_epptr_ff_r or dma_do_busy)
  begin : DMA_FSM_COMB_PROC
      case (dma_fsm_st)

      EP_DMA_IDLE:
        begin
        if (dma_do_done && dma_do_cmd!=2'b00)
          dma_fsm_nxt = EP_DMA_CTRL_RD;
        else
          dma_fsm_nxt = EP_DMA_IDLE;
        end

      EP_DMA_CTRL_RD:
        begin
        if (!dma_epptr && dma_epptr_ff_r)
          dma_fsm_nxt = EP_DMA_DATA;
        else
          dma_fsm_nxt = dma_fsm_st;
        end

      EP_DMA_DATA:
        begin
        if (!dma_do_busy)
          dma_fsm_nxt = EP_DMA_IDLE;
        else if (dma_epptr && !dma_epptr_ff_r)
          dma_fsm_nxt = EP_DMA_CTRL_WR;
        else
          dma_fsm_nxt = dma_fsm_st;
        end

      default:
        begin
        if ((!dma_epptr && dma_epptr_ff_r)||(!dma_do_busy))
          dma_fsm_nxt = EP_DMA_IDLE;
        else
          dma_fsm_nxt = dma_fsm_st;
        end

      endcase
  end

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_FSM_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      dma_fsm_st <= EP_DMA_IDLE;
    else
      if (cfgrst)
        dma_fsm_st <= EP_DMA_IDLE;
      else
        dma_fsm_st <= dma_fsm_nxt;
  end

  assign xfer_new_start_permission =
                                     !xfer_soft_abort &&


                                     !dma_aborting_r &&
                                     !xfer_before_abort;









  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_DO_SYNC_PROC

    if `CDNSUSBHS_RESET(uprst)
      begin
        dma_do <= 1'b0;
        dma_do_epdir <= 1'b0;
        dma_do_cmd <= 2'b00;
        dma_do_rdtrb <= 1'b0;
        ep_to_service_r <= {16{1'b0}};
      end
    else
      begin
      if (dma_do_done_ff_r || xfer_soft_abort || cfgrst)
        dma_do <= 1'b0;
      else if ((dma_fsm_st == EP_DMA_CTRL_RD || dma_fsm_st == EP_DMA_DATA) && !dma_do_busy)
      begin
        dma_do <= 1'b1;
        dma_do_epdir <= 1'b0;
        dma_do_cmd <= 2'b00;
        dma_do_rdtrb <= 1'b0;
      end

      else if (do_abort_xfer && xfer_new_start_permission)
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= do_abort_xfer_dir;
          dma_do_cmd   <= do_abort_xfer_cmd;
          dma_do_rdtrb <= 1'b0;
        end
      else if (  (!(dma_epnum == epoutqueue && !dma_epdir && dma_do_busy)) &&
                 epen[epoutqueue] &&  xfer_new_start_permission && !dma_performs_iso_in_r &&
                 (epoutqueue_val && !epoutqueueempty &&
                 (epodrdy[epoutqueue]||dma_epsts[epoutqueue]) )
              )
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b0;
          dma_do_cmd <= 2'b01;
          dma_do_rdtrb <= 1'b0;
        end
      else if ( xfer_new_start_permission && !dma_epdir && !dma_do && dma_do_busy &&
                ( (
                    ((


                      epoutqueueempty) ||

                      (
                     !epoutqueueempty && dma_epnum != epoutqueue && (!(epodrdy[epoutqueue]||dma_epsts[epoutqueue])))

                    )
                  )

                )
              )
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b0;
          dma_do_cmd <= 2'b00;
          dma_do_rdtrb <= 1'b0;
        end
      else if ( xfer_new_start_permission && epibuffull[dma_epnum] && dma_epdir && dma_do_busy)
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b1;
          dma_do_cmd <= 2'b00;
          dma_do_rdtrb <= 1'b0;
        end
      else if (do_in_xfer_iso_cont && xfer_new_start_permission)
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b1;
          dma_do_cmd <= do_in_xfer_cmd_iso_cont;
          dma_do_rdtrb <= 1'b0;
        end






      else if (do_in_xfer && xfer_new_start_permission && !dma_performs_iso_in_r)
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b1;
          dma_do_cmd <= 2'b01;
          dma_do_rdtrb <= 1'b0;
        end
      else if (do_in_xfer_cont && xfer_new_start_permission && !dma_performs_iso_in_r)
            begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b1;
          dma_do_cmd <= do_in_xfer_cmd_cont;
          dma_do_rdtrb <= 1'b0;
        end
      else if (do_in_xfer_new && xfer_new_start_permission && !dma_performs_iso_in_r)
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b1;
          dma_do_cmd <= do_in_xfer_cmd_new;
          dma_do_rdtrb <= 1'b0;
        end
      else if (  (!(dma_epnum == trbreqep_r && !dma_epdir && dma_do_busy)) &&
                 epen[trbreqep_r] &&  xfer_new_start_permission && !dma_performs_iso_in_r &&
                 (trbreq_r &&
                 (epodrdy[trbreqep_r]||dma_epsts[trbreqep_r]) )
              )
        begin
          dma_do <= 1'b1;
          dma_do_epdir <= 1'b0;
          dma_do_cmd <= 2'b01;
          dma_do_rdtrb <= 1'b1;
        end




         ep_to_service_r <= epserviced_v;
      end
  end



  always @(   ep_to_service_r
           or dma_fsm_st
           or dma_do_busy
           or do_abort_xfer
           or xfer_new_start_permission
           or do_abort_xfer_vect
           or dma_epnum
           or epoutqueue
           or dma_epdir
           or epen
           or dma_performs_iso_in_r
           or epoutqueue_val
           or epoutqueueempty
           or epodrdy
           or dma_epsts
           or dma_do
           or epibuffull
           or trbreqep_r
           or trbreq_r
           or do_in_xfer_iso_cont
           or do_in_xfer
           or do_in_xfer_cont
           or do_in_xfer_new
           or do_in_xfer_vect_iso_cont
           or do_in_xfer_vect
           or do_in_xfer_vect_cont
           or do_in_xfer_vect_new)

  begin : DMA_DO_COMB_PROC
    integer    i;

      epserviced_v = ep_to_service_r;

      if ((dma_fsm_st == EP_DMA_CTRL_RD || dma_fsm_st == EP_DMA_DATA) && !dma_do_busy)
      begin
        epserviced_v = {16{1'b0}};
      end

      else if (do_abort_xfer && xfer_new_start_permission)
        begin
          epserviced_v =  do_abort_xfer_vect;
        end
      else if (  (!(dma_epnum == epoutqueue && !dma_epdir && dma_do_busy)) &&
                 epen[epoutqueue] &&  xfer_new_start_permission && !dma_performs_iso_in_r &&
                 (epoutqueue_val && !epoutqueueempty &&
                 (epodrdy[epoutqueue]||dma_epsts[epoutqueue]) )
              )
        begin
          for (i = 0; i < 16; i = i + 1)
            begin
            if (epoutqueue == i)
              epserviced_v[i] = 1'b1;
            else
              epserviced_v[i] = 1'b0;
            end
        end
      else if ( xfer_new_start_permission && !dma_epdir && !dma_do && dma_do_busy &&
                ( (
                    ((


                      epoutqueueempty) ||

                      (
                     !epoutqueueempty && dma_epnum != epoutqueue && (!(epodrdy[epoutqueue]||dma_epsts[epoutqueue])))

                    )
                  )

                )
              )
        begin
          epserviced_v = {16{1'b0}};
        end
      else if ( xfer_new_start_permission && epibuffull[dma_epnum] && dma_epdir && dma_do_busy)
        begin
          epserviced_v = {16{1'b0}};
        end
      else if (do_in_xfer_iso_cont && xfer_new_start_permission)
        begin
          epserviced_v = do_in_xfer_vect_iso_cont;
        end




      else if (do_in_xfer && xfer_new_start_permission && !dma_performs_iso_in_r)
        begin
          epserviced_v = do_in_xfer_vect;
        end
      else if (do_in_xfer_cont && xfer_new_start_permission && !dma_performs_iso_in_r)
        begin
          epserviced_v = do_in_xfer_vect_cont;
        end
      else if (do_in_xfer_new && xfer_new_start_permission && !dma_performs_iso_in_r)
        begin
          epserviced_v = do_in_xfer_vect_new;
        end
      else if (  (!(dma_epnum == trbreqep_r && !dma_epdir && dma_do_busy)) &&
                 epen[trbreqep_r] &&  xfer_new_start_permission && !dma_performs_iso_in_r &&
                 (trbreq_r &&
                 (epodrdy[trbreqep_r]||dma_epsts[trbreqep_r]) )
              )
        begin
          for (i = 0; i < 16; i = i + 1)
            begin
            if (trbreqep_r == i)
              epserviced_v[i] = 1'b1;
            else
              epserviced_v[i] = 1'b0;
            end
        end
      else if (!dma_do_busy && !dma_do)
         epserviced_v = {16{1'b0}};
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DO_IN_XFER_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      do_in_xfer_r  <= 1'b0;
      do_in_xfer_vect_r <= 4'b0000;
      end
    else
      if (innak == 1'b1)
         begin
         do_in_xfer_r <= 1'b1;
         do_in_xfer_vect_r <= innak_no;
         end
      else if (do_in_xfer  || cfgrst)
         begin
         do_in_xfer_r <= 1'b0;
         do_in_xfer_vect_r <= 4'b0000;
         end
  end




  always @(epoutqueue_val or epoutqueueempty   or
           epiisotype     or do_in_xfer_vect_r or
           do_in_xfer_r   or dma_epsts or
           epidrdy        or epibuffull        or
           dma_epnum      or dma_epdir         or
           dma_last_ff_r  or dma_do_busy       or
           dma_do         or epen)
  begin : DO_IN_XFER_PROC
    reg disable_loop;
    integer i;
      begin : DO_IN_XFER_LOOP
        disable_loop = 1'b0;
        do_in_xfer = 1'b0;
        do_in_xfer_vect = 16'b0000_0000_0000_0000;
        for (i = 0; i < 16; i = i + 1)
          begin
            if (!disable_loop && epen[i+16] && !epiisotype[i] &&
                ((do_in_xfer_r==1'b1) && (do_in_xfer_vect_r == i) &&
                 (epidrdy[i] || dma_epsts[i+16]) && ~epibuffull[i]) &&
                (!(dma_epnum == i && dma_epdir && dma_do_busy)) &&
                (( dma_last_ff_r && (!(epoutqueue_val && !epoutqueueempty))) || (!dma_do_busy && !dma_do))
               )
              begin
                do_in_xfer = 1'b1;
                do_in_xfer_vect[i] = 1'b1;
                disable_loop = 1'b1;
              end
          end
      end
  end





  always @(epoutqueue_val  or epoutqueueempty or
           dma_epsts       or
           epibuffull      or epen            or
           epiisotype      or dma_do          or
           dma_do_busy     or dma_last_ff_r   or
           dma_epnum       or dma_epdir)
  begin : DO_IN_XFER_ISO_CONT_PROC
    reg disable_loop;
    integer i;
      begin : DO_IN_XFER_ISO_CONT_LOOP
        disable_loop = 1'b0;
        do_in_xfer_iso_cont = 1'b0;
        do_in_xfer_cmd_iso_cont  = 2'b10;
        do_in_xfer_vect_iso_cont = 16'b0000_0000_0000_0000;
        for (i = 0; i < 16; i = i + 1)
          begin
            if (!disable_loop && epen[i+16] && epiisotype[i] &&
                dma_epsts[i+16] && ~epibuffull[i] &&
                (!(dma_epnum == i && dma_epdir && dma_do_busy)) &&
                ((dma_last_ff_r && (!(epoutqueue_val && !epoutqueueempty))) || (!dma_do_busy && !dma_do))
               )
              begin
                do_in_xfer_iso_cont = 1'b1;
                do_in_xfer_cmd_iso_cont = 2'b10;
                do_in_xfer_vect_iso_cont[i] = 1'b1;
                disable_loop = 1'b1;
              end
          end
      end
  end








































  always @(dma_epsts       or epiisotype    or
           epibuffull      or epen          or
           dma_do          or dma_do_busy)
  begin : DO_IN_XFER_CONT_PROC
    reg disable_loop;
    integer i;
      begin : DO_IN_XFER_CONT_LOOP
        disable_loop = 1'b0;
        do_in_xfer_cont = 1'b0;
        do_in_xfer_cmd_cont  = 2'b01;
        do_in_xfer_vect_cont = 16'b0000_0000_0000_0000;
        for (i = 0; i < 16; i = i + 1)
          begin
            if (!disable_loop && epen[i+16] && !epiisotype[i] &&
                dma_epsts[i+16] && ~epibuffull[i] &&
                !dma_do_busy && !dma_do
               )
              begin
                do_in_xfer_cont = 1'b1;
                do_in_xfer_vect_cont[i] = 1'b1;
                disable_loop = 1'b1;
                do_in_xfer_cmd_cont = 2'b01;
              end
          end
      end
  end




  always @(epidrdy          or dma_epsts     or
           epibuffull       or rd_nxt_trb_en or
           epiisotype       or dma_do        or
           dma_do_busy      or epen)
  begin : DO_IN_XFER_NEW_PROC
    reg disable_loop;
    integer i;
      begin : DO_IN_XFER_CONT_LOOP
        disable_loop = 1'b0;
        do_in_xfer_new = 1'b0;
        do_in_xfer_cmd_new  = 2'b00;
        do_in_xfer_vect_new = 16'b0000_0000_0000_0000;
          for (i = 0; i < 16; i = i + 1)
            begin
            if (!disable_loop && epen[i+16] &&
                epidrdy[i] && !dma_epsts[i+16] && ~epibuffull[i] && (rd_nxt_trb_en[i] || !epiisotype[i]) &&
                !dma_do_busy && !dma_do
               )
              begin
                do_in_xfer_new = 1'b1;
                do_in_xfer_vect_new[i] = 1'b1;
                disable_loop =1'b1;
                if (!epiisotype[i])
                  do_in_xfer_cmd_new = 2'b01;
                else
                  do_in_xfer_cmd_new = 2'b10;
            end
        end
      end
  end




  always @(dma_epsts          or ocp_eprst_int      or
           epoisotype         or epiisotype         or
           eprst_abort_r      or
           epoisoerr_aux      or ocp_ep             or
           epiisoerr_aux      or epen)
  begin : DO_ABORT_XFER_PROC
    reg       disable_loop;
    reg       do_dir_v;
    reg [3:0] do_no_v;
    integer i;
      begin : DO_ABORT_XFER_LOOP
        disable_loop = 1'b0;
        do_abort_xfer = 1'b0;
        do_abort_xfer_dir = 1'b0;
        do_abort_xfer_cmd  = 2'b11;
        do_abort_xfer_vect = 16'b0000_0000_0000_0000;
          for (i = 0; i < 32; i = i + 1)
            begin
            {do_dir_v, do_no_v} = i;

              if (!disable_loop && dma_epsts[i] &&
                   ocp_eprst_int && ocp_ep == i &&
                   !eprst_abort_r
                  )
                begin
                  do_abort_xfer = 1'b1;
                  do_abort_xfer_dir = do_dir_v;
                  do_abort_xfer_vect[do_no_v] = 1'b1;
                  do_abort_xfer_cmd = 2'b11;
                  disable_loop = 1'b1;
                end
              else if (!disable_loop && epen[i] &&
                  !ocp_eprst_int &&
                  do_dir_v && epiisotype[do_no_v] &&
                  epiisoerr_aux[do_no_v] &&
                  dma_epsts[i]
                  )
                begin
                  do_abort_xfer = 1'b1;
                  do_abort_xfer_dir = do_dir_v;
                  do_abort_xfer_vect[do_no_v] = 1'b1;
                  do_abort_xfer_cmd = 2'b11;
                  disable_loop = 1'b1;
                end
              else if (!disable_loop && epen[i] &&
                       !(ocp_eprst_int && !eprst_abort_r) &&
                       !do_dir_v && epoisotype[do_no_v] &&
                       epoisoerr_aux[do_no_v]
                      )
                begin
                  do_abort_xfer = 1'b1;
                  do_abort_xfer_dir = do_dir_v;
                  do_abort_xfer_vect[do_no_v] = 1'b1;
                  do_abort_xfer_cmd = 2'b11;
                  disable_loop = 1'b1;
                end
        end
      end
  end





















  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_ABORTING_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      dma_aborting_r <= 1'b0;
    else
      if (dma_do_done && dma_do_cmd == 2'b11)
        dma_aborting_r <= 1'b1;
      else if (!dma_do_busy)
        dma_aborting_r <= 1'b0;
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_PERFORMS_ISO_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      dma_performs_iso_in_r <= 1'b0;
    else
      if (dma_do_done && dma_do_epdir && dma_do_cmd == 2'b10)
        dma_performs_iso_in_r <= 1'b1;
      else if (!dma_do_busy)
        dma_performs_iso_in_r <= 1'b0;
  end




  assign xfer_before_abort = dma_do && dma_do_cmd == 2'b11 && !dma_aborting_r;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_EPRST_INT_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_eprst_int_r <= 1'b0;
    else
      if (ocp_eprst_int)
        ocp_eprst_int_r <= 1'b1;
      else if (eprst_abort_r || cfgrst)
        ocp_eprst_int_r <= 1'b0;
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPRST_ABORT_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      eprst_abort_r <= 1'b0;
    else
      if ((ocp_eprst_int || ocp_eprst_int_r) &&
          dma_do_done && dma_do_cmd == 2'b11)
        eprst_abort_r <= 1'b1;
      else if (!ocp_eprst_int || cfgrst)
        eprst_abort_r <= 1'b0;
  end


















  always @(ep_to_service_r)
  begin : DMA_DO_EPNUM_PROC
    begin : DMA_DO_EPNUM_LOOP
      integer i;
      dma_do_epnum = 4'b0000;
      for (i = 0; i < 16; i = i + 1)
        begin
          if (ep_to_service_r[i])
            dma_do_epnum = i;
        end
    end
  end




  assign dma_do_data_endianess = ependian[{dma_do_epdir,dma_do_epnum}];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
   begin : DMA_PKTSIZE_OUT_SYNC_PROC
     if `CDNSUSBHS_RESET(uprst)
       dma_pktsize_out <= {PKTLENGTH_WIDTH{1'b0}};
     else
       dma_pktsize_out <= fifooutbc;










   end





  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPL_EPD_IN_XFER_CNT_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      dma_pktsize_in_r <= {11{1'b0}};
    else
        if (dma_last & dma_epdir)
          dma_pktsize_in_r <= dma_pktsize_in;
  end




  always @(dma_rd_r          or dma_wr_r      or dma_re_r        or
           fifoinfull0_r     or fifoinfull1_r or fifoinfull2_r   or fifoinfull3_r or
           fifoinwait        or fifooutwait_r or fifoinfullalone or
           epoutqueueempty_r or
           dma_epptr         or fifooutfull_r or
           dma_last_ff_r     or
           xfer_soft_abort   or
           fifooutdatao_r_sel or
           dma_epptr)
  begin : DMA_DATAACK_PROC
    if (
        (dma_rd_r & !dma_epptr & epoutqueueempty_r) ||
        (dma_wr_r & !dma_epptr & (fifoinfull0_r | fifoinfull1_r | fifoinfull2_r | fifoinfull3_r) & (!fifoinfullalone | fifoinwait)) |

        (dma_rd_r & !dma_epptr & fifooutwait_r & !fifooutdatao_r_sel) |
        (dma_rd_r & !dma_epptr & !fifooutfull_r) |
        xfer_soft_abort ||
        dma_last_ff_r)
      dma_ack = 1'b0;
    else if (
            (dma_wr_r & !dma_epptr) |
            (dma_wr_r & dma_epptr) |
            (dma_rd_r & dma_epptr && dma_re_r) |
            (dma_rd_r & !dma_epptr & fifooutfull_r) |
            (dma_rd_r & !dma_epptr )
            )
      dma_ack = 1'b1;
    else
      dma_ack = 1'b0;
  end



  always @(   epen
           or fifooutempty
           or dma_do_busy
           or dma_do
           or epoutqueue_ack
           or epoutqueue
           or dbusy
           or epodrdy_r
           or epooutmis
           or epdescmis_en
           or epoutqueue_req)
  begin : EPOUTQUEUE_V_PROC
    integer i;
    reg     disable_loop;

    epoutqueue_v = epoutqueue;
    epoutqueue_req_v = epoutqueue_req;
    disable_loop = 1'b0;

    for (i = 0; i < 16; i = i + 1)
      begin
      if (!disable_loop &
          (dbusy[i] | epodrdy_r[i] | (epdescmis_en[i] & !epooutmis[i])) &
           (!epoutqueue_req | epoutqueue_ack) &
          epen[i] & !fifooutempty[i] & !dma_do_busy & !dma_do)
         begin
         epoutqueue_v     = i;
         epoutqueue_req_v = !epoutqueue_ack;
         disable_loop     = 1'b1;
         end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOUTQUEUE_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      epoutqueue     <= {4{1'b0}};
      epoutqueue_req <= 1'b0;
      end
    else
      begin
      if (cfgrst)
        begin
        epoutqueue <= {4{1'b0}};
        epoutqueue_req <= 1'b0;
        end
      else
        begin
        if (!((epen[epoutqueue]) &
              (!epoutqueueempty) &
              (epodrdy[epoutqueue] | dma_epsts[epoutqueue] |
              (epdescmis_en[epoutqueue] & !epooutmis[epoutqueue]))
             )
           )
          begin
          epoutqueue <= epoutqueue_v;
          epoutqueue_req <= 1'b0;
          end
        else
          begin
          epoutqueue <= epoutqueue_v;
          epoutqueue_req <= epoutqueue_req_v;
          end
        end
      end
  end





































  assign epoutqueueempty = fifooutempty[epoutqueue];




  assign epibuffull_c    = (dma_do_busy & !dma_epptr)? fifoinafull :
                                                       fifoinfull;



  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPIBUFFULL_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      epibuffull     <= {16{1'b0}};
      end
    else
      begin
      epibuffull <= epibuffull_c;
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : TRADDR_R_PROC
    integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
        for (i = 0; i < 32; i = i + 1)
          begin
          traddr[i] <= {32{1'b0}};
          end
      end
    else
      begin
      for (i = 0; i < 32; i = i + 1)
        begin
          if (!IMPLEMENT_EP[i])
            begin
            traddr[i] <= {32{1'b0}};
            end
          else if (ocp_traddr_write_req & ocp_ep==i)
            begin
            traddr[i] <= ocp_traddr_write;
            end
          else if (dma_epptr & dma_we & dma_pktaddr[2] &
                   i==dma_epdir_epnum)
            begin
            traddr[i] <= dma_dataw;
            end
        end
      end


  end


  assign  ocp_traddr_read = traddr[ocp_ep];
  assign  ocp_traddr_read_ack = ocp_traddr_read_req;





  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_EPDTRANS_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_epdtrans_r <= 32'b00000000_00000000_00000000_00000000;
    else
      if (cfgrst)
        ocp_epdtrans_r <= 32'b00000000_00000000_00000000_00000000;
      else if (ocp_eprst)
        ocp_epdtrans_r[ocp_ep] <= 1'b0;
      else if (ocp_epdtrans_write_req)
        ocp_epdtrans_r[ocp_ep] <= ocp_epdtrans_write;
  end


  assign ocp_epdtrans = ocp_epdtrans_r & IMPLEMENT_EP;

  assign ocp_epdtrans_read = ocp_epdtrans[ocp_ep];

  assign dtrans = ocp_dtrans | ocp_epdtrans[{dma_do_epdir, dma_do_epnum}];

  assign dma_do_mult = ocp_dtrans | ocp_epdtrans[{dma_do_epdir, dma_do_epnum}];





  assign dmabaddr_ptr = (dma_epdir == 1'b0) ? dmabaddr_ptr_out :
                                              dmabaddr_ptr_in ;



  assign dmabaddr_ptr_out =
                            `ifdef CDNSUSBHS_EPOUT_EXIST_15
                            (dma_epnum == 4'hF) ? EPOUT_POINTER_15[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_14
                            (dma_epnum == 4'hE) ? EPOUT_POINTER_14[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_13
                            (dma_epnum == 4'hD) ? EPOUT_POINTER_13[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_12
                            (dma_epnum == 4'hC) ? EPOUT_POINTER_12[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_11
                            (dma_epnum == 4'hB) ? EPOUT_POINTER_11[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_10
                            (dma_epnum == 4'hA) ? EPOUT_POINTER_10[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_9
                            (dma_epnum == 4'h9) ? EPOUT_POINTER_9[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_8
                            (dma_epnum == 4'h8) ? EPOUT_POINTER_8[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_7
                            (dma_epnum == 4'h7) ? EPOUT_POINTER_7[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_6
                            (dma_epnum == 4'h6) ? EPOUT_POINTER_6[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_5
                            (dma_epnum == 4'h5) ? EPOUT_POINTER_5[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_4
                            (dma_epnum == 4'h4) ? EPOUT_POINTER_4[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_3
                            (dma_epnum == 4'h3) ? EPOUT_POINTER_3[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_2
                            (dma_epnum == 4'h2) ? EPOUT_POINTER_2[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPOUT_EXIST_1
                            (dma_epnum == 4'h1) ? EPOUT_POINTER_1[MEMADDRWIDTH-3:0] :
                            `endif
                                                  EPOUT_POINTER_0[MEMADDRWIDTH-3:0];



  assign dmabaddr_ptr_in =
                            `ifdef CDNSUSBHS_EPIN_EXIST_15
                            (dma_epnum == 4'hF) ? EPIN_POINTER_15[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_14
                            (dma_epnum == 4'hE) ? EPIN_POINTER_14[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_13
                            (dma_epnum == 4'hD) ? EPIN_POINTER_13[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_12
                            (dma_epnum == 4'hC) ? EPIN_POINTER_12[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_11
                            (dma_epnum == 4'hB) ? EPIN_POINTER_11[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_10
                            (dma_epnum == 4'hA) ? EPIN_POINTER_10[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_9
                            (dma_epnum == 4'h9) ? EPIN_POINTER_9[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_8
                            (dma_epnum == 4'h8) ? EPIN_POINTER_8[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_7
                            (dma_epnum == 4'h7) ? EPIN_POINTER_7[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_6
                            (dma_epnum == 4'h6) ? EPIN_POINTER_6[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_5
                            (dma_epnum == 4'h5) ? EPIN_POINTER_5[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_4
                            (dma_epnum == 4'h4) ? EPIN_POINTER_4[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_3
                            (dma_epnum == 4'h3) ? EPIN_POINTER_3[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_2
                            (dma_epnum == 4'h2) ? EPIN_POINTER_2[MEMADDRWIDTH-3:0] :
                            `endif
                            `ifdef CDNSUSBHS_EPIN_EXIST_1
                            (dma_epnum == 4'h1) ? EPIN_POINTER_1[MEMADDRWIDTH-3:0] :
                            `endif
                                                  EPIN_POINTER_0[MEMADDRWIDTH-3:0];






  assign dmabdatawr = dma_dataw;

  assign dmabwr     = dma_epptr & dma_we & !dma_pktaddr[2];

  assign dmabaddr   =
                     (dma_re_r) ? ({dmabaddr_ptr, dma_pktaddr[1:0]}+1'b1) :
                                   {dmabaddr_ptr, dma_pktaddr[1:0]};

  assign dmabrd     = dma_epptr & dma_re;



  assign epmaxpck = {fifoinmaxpck, fifooutmaxpck};




   always @(epmaxpck)
   begin : MAXP_R_PROC
       begin : FIFOMAXPCK_R_LOOP
         integer i;
         integer j;
         reg [10:0] maxp_v;

         for (i = 0; i < 32; i = i + 1)
           begin
           for (j = 0; j < 11; j = j + 1)
             maxp_v[j] = epmaxpck[11*i+j];

           maxp_r[i] = maxp_v;
           end
       end
   end











   assign fifooutrd = !fifooutwait &
                      (!dma_epptr & (dma_re_data | dma_re) &
                      !fifooutempty_dma &
                      !epoutqueueemptylast_r)
                       ;











  assign fifoaddr  = dma_epnum;









  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOOUTFULL_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifooutfull_r  <= 1'b0;
      end
    else
      begin
         if (cfgrst)
            begin
             fifooutfull_r <= 1'b0;
           end
         else if (fifooutrd)

           begin
             fifooutfull_r <= 1'b1;
           end
         else if (dma_re)
           begin
             fifooutfull_r <= 1'b0;
           end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOUTQUEUEEMPTY_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      epoutqueueempty_r <= 1'b0;
      fifooutwait_r     <= 1'b0;
      end
    else
      begin
      fifooutwait_r <= fifooutwait;

      if (dma_re | dma_re_data)
        epoutqueueempty_r <= epoutqueueempty;
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOOUTDATAO_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifooutdatao_r_sel<= 1'b0;
      fifooutdatao_r    <= {DMADATAWIDTH{1'b0}};
      end
    else
      begin
      fifooutdatao_r  <= fifooutdatao;
      if (fifooutwait== 1'b1 && dma_re==1'b0 && dma_ack==1'b1)
        fifooutdatao_r_sel<= 1'b1;
      else
        fifooutdatao_r_sel<= 1'b0;
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPOUTQUEUEEMPTYLAST_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      epoutqueueemptylast_r <= 1'b0;
      end
    else
      begin
      if (dma_re | dma_epptr | dma_last)
        epoutqueueemptylast_r <= 1'b0;
      else if (epoutqueueempty)
        epoutqueueemptylast_r <= 1'b1;
      end
  end







  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOINDATAI_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoindatai0_r <= {DMADATAWIDTH{1'b0}};
      fifoindatai1_r <= {DMADATAWIDTH{1'b0}};
      fifoindatai2_r <= {DMADATAWIDTH{1'b0}};
      fifoindatai3_r <= {DMADATAWIDTH{1'b0}};
      end
    else
      begin
      if (!dma_epptr & dma_we)
        begin
        if (fifoinwr | !fifoinfull0_r)
          begin
          fifoindatai0_r <= dma_dataw;
          end
        if (!fifoinfull1_r)
          begin
          fifoindatai1_r <= dma_dataw;
          end
        if (!fifoinfull2_r)
          begin
          fifoindatai2_r <= dma_dataw;
          end
        if (!fifoinfull3_r)
          begin
          fifoindatai3_r <= dma_dataw;
          end
        end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOINFULL0_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoinfull0_r <= 1'b0;
      end
    else
      begin
      if (cfgrst)
        begin
        fifoinfull0_r <= 1'b0;
        end

      else if (!dma_epptr & dma_we &
               (!(fifoinfull1_r | fifoinfull2_r | fifoinfull2_r)|
               (fifoinfullalone & !fifoinwait)))
        begin
        fifoinfull0_r <= 1'b1;
        end
      else if ((fifoinwr & !fifoinfull3_r) ||
               (fifoinwr & fifoinfull0_r & fifoinfull1_r & fifoinfull2_r & fifoinfull3_r))
        begin
        fifoinfull0_r <= 1'b0;
        end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOINFULL1_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoinfull1_r <= 1'b0;
      end
    else
      begin
      if (cfgrst)
        begin
        fifoinfull1_r <= 1'b0;
        end
      else if (!dma_epptr & dma_we & fifoinfull0_r & fifoinwait)
        begin
        fifoinfull1_r <= 1'b1;
        end
      else if (fifoinwr & !fifoinfull0_r)
        begin
        fifoinfull1_r <= 1'b0;
        end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOINFULL2_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoinfull2_r <= 1'b0;
      end
    else
      begin
      if (cfgrst)
        begin
        fifoinfull2_r <= 1'b0;
        end
      else if (!dma_epptr & dma_we & fifoinfull1_r & (!fifoinfullalone | fifoinwait))
        begin
        fifoinfull2_r <= 1'b1;
        end
      else if (fifoinwr & !fifoinfull1_r)
        begin
        fifoinfull2_r <= 1'b0;
        end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOINFULL3_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoinfull3_r <= 1'b0;
      end
    else
      begin
      if (cfgrst)
        begin
        fifoinfull3_r <= 1'b0;
        end
      else if (!dma_epptr & dma_we & fifoinfull2_r & (!fifoinfullalone | fifoinwait))
        begin
        fifoinfull3_r <= 1'b1;
        end
      else if (fifoinwr & !fifoinfull2_r)
        begin
        fifoinfull3_r <= 1'b0;
        end
      end
  end




  assign fifoinwr    = (!dma_epptr & dma_we & !fifoinwait &
                        (fifoinfull0_r | fifoinfull1_r |
                         fifoinfull2_r | fifoinfull3_r)) |
                       (dma_last_req & !fifoinwait &
                         (fifoinfull0_r | fifoinfull1_r |
                          fifoinfull2_r | fifoinfull3_r)) |



                       (!fifoinwait & !dma_we & !dma_ack & !fifoinfullalone &
                        (fifoinfull0_r | fifoinfull1_r |
                         fifoinfull2_r | fifoinfull3_r));




  assign fifoindatai = (fifoinfull0_r & !fifoinfull1_r & fifoinfull3_r) ? fifoindatai3_r :
                       (fifoinfull0_r) ? fifoindatai0_r :
                       (fifoinfull1_r) ? fifoindatai1_r :
                       (fifoinfull2_r) ? fifoindatai2_r :
                                         fifoindatai3_r;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOINDVI_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoindvi_r <= {DMADATAWIDTH/8{1'b0}};
      end
    else
      begin
      if (dma_last)
        begin
        case (dma_pktsize_in[1:0])
          2'b11 :
            begin
            fifoindvi_r <= 4'b0111;
            end
          2'b10 :
            begin
            fifoindvi_r <= 4'b0011;
            end
          2'b01 :
            begin
            fifoindvi_r <= 4'b0001;
            end
          default :
            begin
            fifoindvi_r <= 4'b1111;
            end
        endcase
        end
      end
  end




   assign fifoindvi   = (dma_last_req & fifoinfullalone & !fifoinwait)
                            ? fifoindvi_r :
                              {(DMADATAWIDTH/8){1'b1}};




   assign fifoinend   = (dma_last_req & fifoinfullalone & !fifoinwait)
                            ? 1'b1 :
                        (dma_last_req & dma_pktsize_in_r=={11{1'b0}} & !fifoinwait)
                            ? 1'b1 :
                              1'b0;

   assign fifoinfullalone = (
                        (!fifoinfull0_r & !fifoinfull1_r & !fifoinfull2_r &fifoinfull3_r) |
                        (!fifoinfull0_r & !fifoinfull1_r & fifoinfull2_r &!fifoinfull3_r) |
                        (!fifoinfull0_r & fifoinfull1_r & !fifoinfull2_r &!fifoinfull3_r) |
                        (fifoinfull0_r & !fifoinfull1_r & !fifoinfull2_r &!fifoinfull3_r))
                            ? 1'b1 :
                              1'b0;

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : RD_NXT_TRB_EN_PROC
    integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
        for (i = 0; i < 16; i = i + 1)
          begin
          rd_nxt_trb_en_r[i] <= 1'b0;
          end
      end
    else
      begin
        for (i = 0; i < 16; i = i + 1)
          begin

          if ( cfgrst || (!dma_trb & dma_trb_r &
                          (dma_do_busy & (dma_epnum == i) & dma_epdir)) )
          rd_nxt_trb_en_r[i] <= 1'b0;
          else if (dmasof_i[i+16])
          rd_nxt_trb_en_r[i] <= 1'b1;
          end
      end
  end

  assign rd_nxt_trb_en = rd_nxt_trb_en_r & IMPLEMENT_EP[31:16];

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DMA_TRB_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      dma_trb_r <= 1'b0;
      end
    else
      begin
      dma_trb_r <= dma_trb;
      end
  end

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFORST_PROC
    integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
        for (i = 0; i < 32; i = i + 1)
          begin
          fiforst_r[i] <= 1'b0;
          end
      end
    else
      begin
        for (i = 0; i < 32; i = i + 1)
          begin
          if ( ocp_dflush & ocp_ep==i)
          fiforst_r[i] <= 1'b1;
          else
          fiforst_r[i] <= 1'b0;
          end
      end
  end

  assign fiforst = fiforst_r & IMPLEMENT_EP[31:0];








  reg  [3:0]                       buf_enable_r [0:15];
  reg  [4-1:0]                     buf_enable_nxt;
  wire [3:0]                       buf_enable_0_;

  reg  [11-1:0]                    fifooutmaxpck_r;
  reg  [13-1:0]                    fifooutmaxpck_x3;
  reg  [13-1:0]                    dcnt_sfr_nxt;
  reg  [13-1:0]                    dcnt_sfr_r;
  wire                             cnt_count;
  reg                              count_en_r;
  reg                              pre_en_r;



  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  assign buf_enable_15 = buf_enable_r[15];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  assign buf_enable_14 = buf_enable_r[14];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  assign buf_enable_13 = buf_enable_r[13];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  assign buf_enable_12 = buf_enable_r[12];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  assign buf_enable_11 = buf_enable_r[11];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  assign buf_enable_10 = buf_enable_r[10];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  assign buf_enable_9  = buf_enable_r[9];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  assign buf_enable_8  = buf_enable_r[8];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  assign buf_enable_7  = buf_enable_r[7];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  assign buf_enable_6  = buf_enable_r[6];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  assign buf_enable_5  = buf_enable_r[5];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  assign buf_enable_4  = buf_enable_r[4];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  assign buf_enable_3  = buf_enable_r[3];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  assign buf_enable_2  = buf_enable_r[2];
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  assign buf_enable_1  = buf_enable_r[1];
  `endif
  assign buf_enable_0_ = buf_enable_r[0];
  assign buf_enable_0  = buf_enable_0_[0];

  assign cnt_count = fifooutrd;

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DCNT_SFR_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
       dcnt_sfr_r <= 13'b0_0000_0000_0000;
      end
    else
      begin
      if ((dma_buf_xferlength_val) &
          (dma_do_busy | dma_do_busy_ff_r) &
          (|dma_buf_xferlength[XFERLENGTH_WIDTH-1:13]))
        dcnt_sfr_r <= 13'b1_1111_1111_1111;
      else if ((dma_buf_xferlength_val) &
               (dma_do_busy | dma_do_busy_ff_r))
        dcnt_sfr_r <= dma_buf_xferlength[12:0];
      else if (cnt_count == 1'b1)
        dcnt_sfr_r <= dcnt_sfr_nxt;
      end
  end

  always @(dcnt_sfr_r)
  begin : DCNT_SFR_NXT_PROC
    if (dcnt_sfr_r[12 : 2] == 11'b000_0000_0000)
      begin
      dcnt_sfr_nxt = 13'b0_0000_0000_0000;
      end
    else
      begin
      dcnt_sfr_nxt[13-1 : 2] = dcnt_sfr_r[13-1 : 2] - 1'b1;
      dcnt_sfr_nxt[1 : 0]  = dcnt_sfr_r[1 : 0];
      end
  end




  always @(dcnt_sfr_nxt or dcnt_sfr_r or pre_en_r or

           cnt_count or
           fifooutmaxpck_r or fifooutmaxpck_x3 or fifooutbc_c)
    begin : BUF_ENABLE_PROC
      if ((fifooutmaxpck_r > fifooutbc_c) && pre_en_r==1'b0)
         buf_enable_nxt = 4'b0000;
      else if (
          cnt_count == 1'b1)
        begin

        if (dcnt_sfr_nxt[13 - 1:0] > {13{1'b0}})
          begin
          buf_enable_nxt[0] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[0] = 1'b0;
          end

        if ((dcnt_sfr_nxt[13 - 1:11] > {(13-11){1'b0}}) ||
            (dcnt_sfr_nxt[10:0] > fifooutmaxpck_r))
          begin
          buf_enable_nxt[1] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[1] = 1'b0;
          end

        if ((dcnt_sfr_nxt[13 - 1:12] > {(13-12){1'b0}}) ||
            (dcnt_sfr_nxt[11:1] > fifooutmaxpck_r))
          begin
          buf_enable_nxt[2] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[2] = 1'b0;
          end

        if (
            (dcnt_sfr_nxt[12:0] > fifooutmaxpck_x3))
          begin
          buf_enable_nxt[3] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[3] = 1'b0;
          end
        end
      else
        begin

        if (dcnt_sfr_r[13 - 1:0] > {13{1'b0}})
          begin
          buf_enable_nxt[0] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[0] = 1'b0;
          end

        if ((dcnt_sfr_r[13 - 1:11] > {(13-11){1'b0}}) ||
            (dcnt_sfr_r[10:0] > fifooutmaxpck_r))
          begin
          buf_enable_nxt[1] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[1] = 1'b0;
          end

        if ((dcnt_sfr_r[13 - 1:12] > {(13-12){1'b0}}) ||
            (dcnt_sfr_r[11:1] > fifooutmaxpck_r))
          begin
          buf_enable_nxt[2] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[2] = 1'b0;
          end

        if (
            (dcnt_sfr_r[12:0] > fifooutmaxpck_x3))
          begin
          buf_enable_nxt[3] = 1'b1;
          end
        else
          begin
          buf_enable_nxt[3] = 1'b0;
          end
        end
    end





  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOOUTMAXPCK_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifooutmaxpck_r       <= 11'b00000000000;
      fifooutmaxpck_x3      <= 13'b0000000000000;
      end
    else
      begin
      fifooutmaxpck_r <= maxp_r[dma_epdir_epnum];

      fifooutmaxpck_x3 <= {1'b0,fifooutmaxpck_r,1'b0} + fifooutmaxpck_r;
      end
    end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : BUF_ENABLE_R_PROC
    integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      for (i = 0; i < 16; i = i + 1)
        buf_enable_r[i] <= 4'h0;
      end
    else
      begin : BUF_ENABLE_R_LOOP
        for (i = 0; i < 16; i = i + 1)
          begin
            if ((cfgrst) || !IMPLEMENT_EP[i])
              begin
              buf_enable_r[i] <= 4'h0;
              end
            else if (dma_epnum == i &&
                     dma_epdir == 1'b0 &&
                     count_en_r == 1'b1)
              begin
              if (pre_en_r == 1'b1)
                 buf_enable_r[i] <= buf_enable_nxt | 4'h1;
              else
                 buf_enable_r[i] <= buf_enable_nxt;
              end
            else if (epodrdy[i]==1'b1 && buf_enable_r[i]==4'h0)
              begin
              if (epoisotype[i]==1'b1)
                 buf_enable_r[i] <= 4'h1;
              else
                 buf_enable_r[i] <= 4'h0;
              end
          end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : TRBREQV_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      trbreqv_r <= {16{1'b0}};
      end
    else
      begin : TRBREQV_R_LOOP
        integer i;
        for (i = 0; i < 16; i = i + 1)
           begin
             if ((cfgrst) || (upstrenup) || !IMPLEMENT_EP[i])
               begin
               trbreqv_r[i] <= 1'b0;
               end
             else if (dma_epdir == 1'b0 && dma_epnum == i &&
                      count_en_r ==1'b1)
               begin
               trbreqv_r[i] <= 1'b0;
               end
             else if (epodrdy[i]==1'b1 && buf_enable_r[i]==4'h0)
               begin
                 if (epoisotype[i]==1'b1)
                 begin
                 trbreqv_r[i] <= 1'b0;
                 end
                 else
                 begin
                 trbreqv_r[i] <= 1'b1;
                 end
               end
             else
               begin
               trbreqv_r[i] <= 1'b0;
               end
          end
      end
  end








































  always @(   epen
           or fifooutempty
           or dma_do_busy
           or dma_do_busy_ff_r
           or dma_do
           or trbreqv_r
           or trbreqep_r
           or trbreq_r)
  begin : TRBREQ_V_PROC
    integer i;

  trbreqep_v   = trbreqep_r;
  trbreq_v     = trbreq_r;

  for (i = 0; i < 16; i = i + 1)
    begin
    if (!trbreq_v &
        epen[i] & fifooutempty[i] &
        !dma_do_busy & !dma_do_busy_ff_r & !dma_do &
        trbreqv_r[i])
      begin
      trbreqep_v   = i;
      trbreq_v     = 1'b1;
      end
    end
  end





  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : TRBREQ_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      trbreqep_r     <= {4{1'b0}};
      trbreq_r       <= 1'b0;
      end
    else
      begin
      if (cfgrst)
        begin
        trbreqep_r <= {4{1'b0}};
        trbreq_r   <= 1'b0;
        end
      else if (dma_do_done | dma_do_busy)
        begin
        trbreqep_r <= {4{1'b0}};
        trbreq_r   <= 1'b0;
        end
      else
        begin
        trbreqep_r <= trbreqep_v;
        trbreq_r   <= trbreq_v;
        end
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : COUNT_EN_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
       count_en_r <= 1'b0;
      end
    else
      begin
      if ((dma_buf_xferlength_val | dma_buf_pre_val) &
          (dma_do_busy | dma_do_busy_ff_r))
        count_en_r <= 1'b1;
      else if (!dma_do_busy)
        count_en_r <= 1'b0;
      end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : PRE_EN_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      pre_en_r <= 1'b0;
      end
    else
      begin
      if ((dma_buf_pre_val) &
          (dma_do_busy | dma_do_busy_ff_r))
        pre_en_r <= 1'b1;
      else if (!dma_do_busy)
        pre_en_r <= 1'b0;
      end
  end




  assign fifooutempty_dma = fifooutempty[dma_epnum];




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : FIFOOUTBC_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifooutbc_r <= {11{1'b0}};
      end
    else
      begin
      if (!fifooutempty_dma)
        fifooutbc_r <= fifooutbc;
      end
  end




  assign fifooutbc_c = (fifooutempty_dma) ? fifooutbc_r : fifooutbc;

endmodule


