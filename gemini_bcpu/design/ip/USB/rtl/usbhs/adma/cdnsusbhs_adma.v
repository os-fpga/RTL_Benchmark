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
//   Filename:           cdnsusbhs_adma.v
//   Module Name:        cdnsusbhs_adma
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
//   Direct Memory Access controller
//   P.E.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"






module cdnsusbhs_adma (


  clk,
  rst_n,


  dma_trb,
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



  dma_do_cfgrst,
  dma_do_epnum,
  dma_do_epdir,
  dma_do_rdtrb,
  dma_do_cmd,
  dma_do_data_endianess,

  dma_do_mult,
  dma_do,
  dma_do_busy,
  dma_do_done,


  dma_buf_xferlength,
  dma_buf_xferlength_val,
  dma_buf_pre_val,

  `ifdef CDNSUSBHS_CONT_BURST_PROTECTION
  dma_fifow_lvl,
  dma_fifor_lvl,
  dma_xfer_finished,
  `endif
  dma_datar,
  dma_ack,
  dma_epnum,
  dma_epdir,
  dma_epptr,
  dma_pktaddr,
  dma_dataw,
  dma_epsts,
  dma_epccs,
  dma_pktsize_in,

  dma_last,
  dma_we,
  dma_re,
  dma_re_data,
  dma_pktsize_out,
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  dma_stid_out,
  dma_abort,
  dma_error_stid,
  `endif
  dma_int_sync,
  dma_error_outsmm,
  dma_error_trb,
  dma_isp,
  `ifdef CDNSUSBHS_IMPLEMENT_DEBUG
  dma_ioc,
  debug_dma
  `else
  dma_ioc
  `endif
  );





  `include "cdnsusbhs_adma_params.v"






  input                              clk;
  input                              rst_n;


  output                             dma_trb;
  input                              scmdaccept_m;
  input             [DATA_WIDTH-1:0] sdata_m;
  input         [OCP_RESP_WIDTH-1:0] sresp_m;

  output         [OCP_CMD_WIDTH-1:0] mcmd_m;
  wire           [OCP_CMD_WIDTH-1:0] mcmd_m;
  output        [OCP_ADDR_WIDTH-1:0] maddr_m;
  reg           [OCP_ADDR_WIDTH-1:0] maddr_m;
  output        [(DATA_WIDTH/8)-1:0] mbyteen_m;
  output [OCP_BURSTLENGTH_WIDTH-1:0] mburstlength_m;
  output    [OCP_BURSTSEQ_WIDTH-1:0] mburstseq_m;
  reg       [OCP_BURSTSEQ_WIDTH-1:0] mburstseq_m;
  output                             mburstprecise_m;
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
  reg                                mburstprecise_m;
`endif
  output            [DATA_WIDTH-1:0] mdata_m;
  reg               [DATA_WIDTH-1:0] mdata_m;
  output                             mreqlast_m;



  input                              dma_do_cfgrst;
  input            [EPNUM_WIDTH-1:0] dma_do_epnum;
  input                              dma_do_epdir;
  input                              dma_do_rdtrb;
  input                        [1:0] dma_do_cmd;
  input                              dma_do_data_endianess;

  input                              dma_do_mult;
  input                              dma_do;
  output                             dma_do_busy;
  output                             dma_do_done;


`ifdef CDNSUSBHS_CONT_BURST_PROTECTION
  input                 [F0AWIDTH:0] dma_fifow_lvl;
  input                 [F1AWIDTH:0] dma_fifor_lvl;
  input                              dma_xfer_finished;
`endif
  input             [DATA_WIDTH-1:0] dma_datar;
  input                              dma_ack;
  output           [EPNUM_WIDTH-1:0] dma_epnum;
  output                             dma_epdir;
  output                             dma_epptr;
  output         [PKTADDR_WIDTH-1:0] dma_pktaddr;
  reg            [PKTADDR_WIDTH-1:0] dma_pktaddr;
  output            [DATA_WIDTH-1:0] dma_dataw;
  reg               [DATA_WIDTH-1:0] dma_dataw;
  output                      [31:0] dma_epsts;
  output                      [31:0] dma_epccs;
  output       [PKTLENGTH_WIDTH-1:0] dma_pktsize_in;

  output                             dma_last;
  output                             dma_we;
  output                             dma_re;
  output                             dma_re_data;
  input        [PKTLENGTH_WIDTH-1:0] dma_pktsize_out;
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  input             [STID_WIDTH-1:0] dma_stid_out;
  output                             dma_abort;
  output                             dma_error_stid;
  `endif
  output                             dma_int_sync;
  output                             dma_error_outsmm;
  output                             dma_error_trb;
  output                             dma_isp;
  output                             dma_ioc;

  output      [XFERLENGTH_WIDTH-1:0] dma_buf_xferlength;
  output                             dma_buf_xferlength_val;
  output                             dma_buf_pre_val;


  parameter DMA_CMD_NOP           = 2'b00;

  parameter DMA_CMD_ISO_XFER      = 2'b10;
  parameter DMA_CMD_ABORT         = 2'b11;



  parameter OCP_CMD_IDLE          = 3'b000;
  parameter OCP_CMD_WR            = 3'b001;
  parameter OCP_CMD_RD            = 3'b010;








  parameter OCP_BURST_INCR        = 3'b000;




  parameter OCP_BURST_STRM        = 3'b101;






  parameter OCP_RESP_DVA          = 2'b01;




  parameter OCP_BE_0000           = 4'b0000;
  parameter OCP_BE_0001           = 4'b0001;
  parameter OCP_BE_0010           = 4'b0010;
  parameter OCP_BE_0011           = 4'b0011;
  parameter OCP_BE_0100           = 4'b0100;
  parameter OCP_BE_1000           = 4'b1000;
  parameter OCP_BE_1100           = 4'b1100;
  parameter OCP_BE_1111           = 4'b1111;



















  parameter DMA_FSM_IDLE          = 5'b00000;
  parameter DMA_FSM_RD_PTR        = 5'b00001;
  parameter DMA_FSM_RD_MAX        = 5'b00010;
  parameter DMA_FSM_RD_DESC       = 5'b00011;
  parameter DMA_FSM_XFER          = 5'b00100;

  parameter DMA_FSM_ADV_PTR       = 5'b00110;
  parameter DMA_FSM_REL_BUF       = 5'b00111;
  parameter DMA_FSM_RD_AGAIN      = 5'b01000;
  parameter DMA_FSM_WR_DESC       = 5'b01001;
  parameter DMA_FSM_STORE         = 5'b01010;
  parameter DMA_FSM_RESTORE       = 5'b01011;
  parameter DMA_FSM_MULT          = 5'b01100;
  parameter DMA_FSM_WR_PTR        = 5'b01101;
  parameter DMA_FSM_ZERO          = 5'b01110;
  parameter DMA_FSM_DELAY         = 5'b01111;
  parameter DMA_FSM_HOST_PRE      = 5'b10000;



  parameter DMA_ADDR_BYTES        = 3'b000;
  parameter DMA_ADDR_LENGTH       = 3'b001;
  parameter DMA_ADDR_DESC_PTR     = 3'b010;
  parameter DMA_ADDR_DATA_PTR     = 3'b011;
  parameter DMA_ADDR_DEQUEUE      = 3'b100;
  parameter DMA_ADDR_MAX          = 3'b101;







  reg                          [4:0] dma_fsm_st_r;
  reg                          [4:0] dma_fsm_nxt;

  wire                               dma_fsm_xfer_;
  wire                               dma_fsm_rd_desc_;
  wire                               dma_fsm_wr_desc_;
  wire                               dma_fsm_adv_desc_;
  wire                               dma_fsm_rd_ocp_;
  wire                               dma_fsm_wr_ocp_;
  wire                               dma_fsm_rd_ptr_;
  wire                               dma_fsm_wr_ptr_;
  wire                               dma_fsm_rd_max_;
  wire                               dma_fsm_rel_buf_;
  wire                               dma_fsm_rd_again_;
  wire                               dma_fsm_store_;
  wire                               dma_fsm_restore_;
  reg                                dma_fsm_restore_r;
  wire                               dma_fsm_zero_;
  wire                               dma_fsm_mult_;

  wire                        [31:0] dma_fsm_ep_st;
  reg                         [31:0] dma_fsm_ep_st_r;
  reg                                dma_fsm_ep_st_abort_r;
  reg                          [2:0] dma_fsm_cnt_r;
  wire                               dma_fsm_addr_byt;
  wire                               dma_fsm_addr_len;
  wire                               dma_fsm_addr_des;
  wire                               dma_fsm_addr_dat;
  wire                               dma_fsm_addr_deq;
  wire                               dma_fsm_addr_max;
  wire                               dma_fsm_own;
  reg                                dma_fsm_trb_r;
  reg                                dma_fsm_trb_check_r;
  wire                               dma_fsm_trb_error;
  reg                                dma_fsm_rd_conf_r;
  wire                               dma_fsm_non_zero;
  wire                               dma_fsm_link;
  wire                               dma_fsm_normal;
  wire                               dma_fsm_chain;
  wire                               dma_fsm_max;
  wire                               dma_fsm_sp;
  wire                               dma_fsm_usp;
  reg                                dma_fsm_usp_r;
  wire                               dma_fsm_smm;
  reg                                dma_fsm_smm_r;


  reg              [EPNUM_WIDTH-1:0] dma_buf_epnum_r;
  reg                                dma_buf_epdir_r;
  reg                                dma_buf_data_end_r;

  reg          [PKTLENGTH_WIDTH-1:0] dma_buf_maxpktsize_r;
  reg                                dma_buf_iso_r;
  reg                                dma_buf_abort_r;
  reg                                dma_buf_mult_r;

  reg               [STID_WIDTH-1:0] dma_buf_stid_r;
  reg                          [5:0] dma_buf_tdtype_r;
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
  reg                                dma_buf_stid_err_r;
  `endif
  reg                                dma_buf_ioc_r;
  reg                                dma_buf_f_r;
  reg                                dma_buf_ch_r;
  reg                                dma_buf_isp_r;
  wire                        [31:0] dma_buf_tc;
  reg                         [31:0] dma_buf_tc_r;
  reg                                dma_buf_c_r;
  reg         [XFERLENGTH_WIDTH-1:0] dma_buf_xferlength_r;
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
  reg                          [7:0] dma_buf_burstlength_r;
`endif
  reg               [ADDR_WIDTH-1:0] dma_buf_ptr_r;
  reg               [DATA_WIDTH-1:0] dma_buf_data_r;
  reg               [ADDR_WIDTH-1:0] dma_buf_desc_ptr_r;
  reg               [ADDR_WIDTH-1:0] dma_buf_prev_ptr_r;
  reg               [ADDR_WIDTH-1:0] dma_buf_deq_ptr_r;
  reg          [PKTLENGTH_WIDTH-1:0] dma_buf_pktsize_r;
  reg          [PKTLENGTH_WIDTH-1:0] dma_buf_pktsize;
  reg          [PKTLENGTH_WIDTH-1:0] dma_buf_pktbytes_r;
  reg          [PKTLENGTH_WIDTH-1:0] dma_buf_pktbytes;
  wire         [PKTLENGTH_WIDTH-1:0] dma_buf_pktbytes_nxt;
  reg         [XFERLENGTH_WIDTH-1:0] dma_buf_bytes_r;
  reg         [XFERLENGTH_WIDTH-1:0] dma_buf_bytes;
  reg         [XFERLENGTH_WIDTH-1:0] dma_buf_length_r;
  reg         [XFERLENGTH_WIDTH-1:0] dma_buf_length;
  wire          [XFERLENGTH_WIDTH:0] dma_buf_part_left;
  wire          [XFERLENGTH_WIDTH:0] dma_buf_total_left;
  wire                               dma_buf_zero_left;
  wire                               dma_buf_pkt_start;
  wire                               dma_buf_pkt_cmpl;


  wire                               dma_ocp_ack;
  reg                                dma_ocp_ack_r;
  reg                                dma_ocp_ack_hold_r;
  reg                          [1:0] dma_ocp_cmd_acc_r;
  wire                         [1:0] dma_ocp_cmd_limit;
  reg                                dma_ocp_fst_r;
  reg           [(DATA_WIDTH/8)-1:0] dma_ocp_be_r;
  reg           [(DATA_WIDTH/8)-1:0] dma_ocp_be_nxt;
  reg           [(DATA_WIDTH/8)-1:0] dma_ocp_prev_be_r;
  reg           [(DATA_WIDTH/8)-1:0] dma_ocp_rd_be_r;
  reg                          [1:0] dma_ocp_rd_be_fifo_ptr;
  reg           [(DATA_WIDTH/8)-1:0] dma_ocp_rd_be_fifo_0_r;
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
  reg           [(DATA_WIDTH/8)-1:0] dma_ocp_rd_be_fifo_1_r;
`endif
  reg           [(DATA_WIDTH/8)-1:0] dma_ocp_rd_be_fifo_out;
  reg                          [2:0] dma_ocp_rd_be_decode;
  wire                         [1:0] dma_ocp_base_mis;
  reg                          [1:0] dma_ocp_base_mis_r;
  reg          [PKTLENGTH_WIDTH-1:0] dma_ocp_bytes_r;
  reg          [PKTLENGTH_WIDTH-1:0] dma_ocp_rd_bytes_r;
  reg          [PKTLENGTH_WIDTH-1:0] dma_ocp_bytes_nxt;
  reg          [PKTLENGTH_WIDTH-1:0] dma_ocp_bytes_prev;
  reg          [PKTLENGTH_WIDTH-1:0] dma_ocp_xferlength_r;
  wire          [XFERLENGTH_WIDTH:0] dma_ocp_xferlength_cond;
  wire                               dma_ocp_xfer_step;
  wire                               dma_ocp_next_re;
  wire         [PKTLENGTH_WIDTH-1:0] dma_ocp_left_nxt;
  wire                               dma_ocp_zero_left;
  wire                               dma_ocp_zero_left_nxt;
  reg           [OCP_ADDR_WIDTH-1:0] dma_ocp_base_addr_r;
  reg           [OCP_ADDR_WIDTH-1:0] dma_ocp_addr;
  wire                               dma_ocp_resp_dva;
  reg                                dma_ocp_resp_dva_r;
  reg                                dma_ocp_atomic_r;
  reg                                dma_ocp_wr_desc_r;
  reg                                dma_ocp_hold_r;
  wire                               dma_ocp_hold_n;
  reg                                dma_ocp_reqlast_r;
  reg                                dma_ocp_clear_r;
  wire                               dma_ocp_clear;
  wire                               dma_ocp_scmdaccept;
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
  reg                          [7:0] dma_ocp_mburstlength_r;
  reg                          [7:0] dma_ocp_burst_cnt_r;
`else
  reg                          [1:0] dma_ocp_mburstlength_r;
`endif
  reg            [OCP_CMD_WIDTH-1:0] dma_ocp_mcmd_m_r;


  wire                               dma_do_clear_all_n;


  wire                               dma_trb_abort;
  wire                               dma_we_ok;
  wire              [DATA_WIDTH-1:0] dma_dataw_in;
  wire                               dma_re_ok;
  reg                                dma_re_queue_r;
  reg                                dma_isp_r;
  reg                          [1:0] dma_ack_prev_r;
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
  reg                                dma_ack_prev_r1;
`endif
  reg            [PKTADDR_WIDTH-1:0] dma_pktaddr_r;
  wire           [PKTADDR_WIDTH-1:0] dma_pktaddr_nxt;
  wire                               dma_out_overhead;
  wire                               dma_in_overhead;
  reg                                dma_in_overhead_r;
  wire                               dma_in_overhead_ack;


`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
  reg           [(DATA_WIDTH-8)-1:0] dma_mis_buf_r;
`endif
  reg               [DATA_WIDTH-1:0] dma_mis_out;
  wire                               dma_end_type;

`ifdef CDNSUSBHS_IMPLEMENT_DMA_FIFO


  reg                          [1:0] dma_fifo_cnt_r;
  reg                                dma_fifo_p_r;
`ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
  reg                          [1:0] dma_fifo_rd_r;
  reg                          [1:0] dma_fifo_wr_r;
  reg               [DATA_WIDTH-1:0] dma_fifo0_r;
  reg               [DATA_WIDTH-1:0] dma_fifo1_r;
  reg               [DATA_WIDTH-1:0] dma_fifo2_r;
`endif
`ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
  reg               [DATA_WIDTH-1:0] dma_fifo;
`endif
  wire                               dma_fifo_empty;
  wire                               dma_fifo_full;
  wire                               dma_fifo_step;
`endif

`ifdef CDNSUSBHS_IMPLEMENT_DEBUG
  output                 [32*32-1:0] debug_dma;
`endif

`ifdef CDNSUSBHS_CONT_BURST_PROTECTION
  reg                                block_ocp_cmd_r;
  reg                                block_first_ocp_cmd_r;
  reg                                dma_epptr_trb_r;
  wire                               dma_fifor_aligned;
`endif

  reg                                dma_do_rdtrb_r;











  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_REG_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_st_r                     <= DMA_FSM_IDLE;
    else
      dma_fsm_st_r                     <= dma_fsm_nxt;
  end




  always
  @(
    dma_fsm_addr_dat or
    dma_fsm_addr_max or
    dma_ack or
    dma_buf_abort_r or
    dma_buf_ch_r or
    dma_buf_epdir_r or
    dma_buf_epnum_r or
    dma_buf_iso_r or
    dma_buf_mult_r or
    `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
      dma_buf_stid_err_r or
    `endif
    dma_buf_zero_left or
    dma_do or
    dma_do_clear_all_n or
    dma_do_cmd or
    dma_do_epdir or
    dma_do_epnum or
    dma_fsm_addr_deq or
    dma_fsm_chain or
    dma_fsm_ep_st or
    dma_fsm_max or
    dma_fsm_non_zero or
    dma_fsm_normal or
    dma_fsm_smm or
    dma_fsm_st_r or
    dma_fsm_trb_error or
    dma_fsm_usp or
    dma_do_rdtrb_r or
    dma_ocp_ack_r or
    dma_ocp_clear or
    dma_ocp_hold_r
  )
  begin : DMA_FSM_COMB_PROC
    if(~dma_do_clear_all_n)
      dma_fsm_nxt                      = DMA_FSM_IDLE;
    else
    begin
      dma_fsm_nxt                      = dma_fsm_st_r;
      case(dma_fsm_st_r)
        DMA_FSM_RD_PTR :
          if(dma_ack & dma_fsm_addr_deq)
            dma_fsm_nxt                = DMA_FSM_RD_MAX;

        DMA_FSM_RD_MAX :
          if(dma_ack & dma_fsm_addr_max)
          begin
            if(dma_buf_abort_r)
              dma_fsm_nxt              = DMA_FSM_DELAY;
            else if(dma_fsm_ep_st[ {dma_buf_epdir_r, dma_buf_epnum_r} ])
            begin
              if(dma_buf_zero_left)
                dma_fsm_nxt            = DMA_FSM_ADV_PTR;
              else
                dma_fsm_nxt            = DMA_FSM_XFER;
            end
            else
              dma_fsm_nxt              = DMA_FSM_RD_DESC;
          end

        DMA_FSM_ADV_PTR :
          if(dma_ocp_ack_r)
          begin
            if(dma_fsm_trb_error)
              dma_fsm_nxt              = DMA_FSM_WR_PTR;
            else if(dma_fsm_normal)
            begin
              if (dma_do_rdtrb_r)
                dma_fsm_nxt            = DMA_FSM_HOST_PRE;
              else
                   if(dma_fsm_non_zero)
                dma_fsm_nxt            = DMA_FSM_XFER;
              else if(~dma_fsm_chain)
                dma_fsm_nxt            = DMA_FSM_ZERO;
            end
            else
              dma_fsm_nxt              = DMA_FSM_ADV_PTR;
          end

        DMA_FSM_RD_DESC :
          if(dma_ocp_ack_r)
          begin
            if(dma_fsm_trb_error)
              dma_fsm_nxt              = DMA_FSM_IDLE;
            else if(dma_fsm_normal)
            begin
              if (dma_do_rdtrb_r)
                dma_fsm_nxt            = DMA_FSM_HOST_PRE;
              else
                   if(dma_fsm_non_zero)
                dma_fsm_nxt            = DMA_FSM_XFER;
              else if(~dma_fsm_chain)
                dma_fsm_nxt            = DMA_FSM_ZERO;
            end
            else
              dma_fsm_nxt              = DMA_FSM_ADV_PTR;
          end

        DMA_FSM_XFER :
          if(dma_ocp_ack_r)
            dma_fsm_nxt                = DMA_FSM_DELAY;

        DMA_FSM_DELAY :
          if(dma_buf_abort_r & dma_buf_epdir_r)
            dma_fsm_nxt                = DMA_FSM_WR_PTR;
          else if
          (
            `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
              dma_buf_stid_err_r |
            `endif
            dma_buf_abort_r | dma_fsm_max | ~dma_buf_ch_r | (~dma_buf_epdir_r & (dma_fsm_usp | dma_fsm_smm))
          )
            dma_fsm_nxt                = DMA_FSM_REL_BUF;
          else
            dma_fsm_nxt                = DMA_FSM_ADV_PTR;

        DMA_FSM_ZERO :
          if(dma_ack)
            dma_fsm_nxt                = DMA_FSM_REL_BUF;

        DMA_FSM_REL_BUF :
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
            if(dma_buf_stid_err_r)
              dma_fsm_nxt              = DMA_FSM_WR_PTR;
            else
          `endif
          if(dma_fsm_usp | dma_buf_abort_r)
            dma_fsm_nxt                = DMA_FSM_RD_AGAIN;
          else if(dma_do & (~dma_buf_zero_left | dma_buf_ch_r | ((dma_do_cmd == DMA_CMD_ABORT) & (dma_do_epnum == dma_buf_epnum_r) & (dma_do_epdir == dma_buf_epdir_r))))
            dma_fsm_nxt                = DMA_FSM_STORE;
          else if(dma_buf_zero_left)
          begin
            if(~dma_buf_ch_r)
            begin
              if(dma_buf_mult_r & ~dma_do & ~dma_buf_iso_r)
                dma_fsm_nxt            = DMA_FSM_MULT;
              else
                dma_fsm_nxt            = DMA_FSM_WR_PTR;
            end
            else
              dma_fsm_nxt              = DMA_FSM_ADV_PTR;
          end
          else
            dma_fsm_nxt                = DMA_FSM_XFER;

        DMA_FSM_RD_AGAIN :
          if(dma_ocp_ack_r)
            dma_fsm_nxt                = DMA_FSM_WR_DESC;

        DMA_FSM_WR_DESC :
          if(dma_ocp_ack_r)
            dma_fsm_nxt                = DMA_FSM_WR_PTR;

        DMA_FSM_WR_PTR,
        DMA_FSM_STORE :
          if(dma_ack & dma_fsm_addr_deq)
            dma_fsm_nxt                = DMA_FSM_IDLE;

        DMA_FSM_HOST_PRE :
            dma_fsm_nxt                = DMA_FSM_IDLE;

        DMA_FSM_RESTORE :
          if(dma_fsm_addr_dat)
            dma_fsm_nxt                = DMA_FSM_RD_MAX;

        DMA_FSM_MULT :
          dma_fsm_nxt                  = DMA_FSM_RD_DESC;

        default :
          if(~dma_ocp_clear & ~dma_ocp_hold_r & dma_do & (dma_do_cmd != DMA_CMD_NOP))
          begin
            if( dma_fsm_ep_st[ {dma_do_epdir, dma_do_epnum} ] )
              dma_fsm_nxt              = DMA_FSM_RESTORE;
            else
              dma_fsm_nxt              = DMA_FSM_RD_PTR;
          end
      endcase
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_CNT_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_cnt_r                    <= 3'b000;
    else
    begin
      if
        (
          ~dma_do_busy |
          dma_ocp_ack_r |
          (dma_fsm_rel_buf_ & (dma_do | (~dma_buf_ch_r & dma_buf_zero_left)))
        )
        dma_fsm_cnt_r                  <= 3'b000;
      else if(dma_ack & (dma_re | dma_we))
        dma_fsm_cnt_r                  <= dma_fsm_cnt_r + 1'b1;
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_EP_ST_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_ep_st_r                  <= {32{1'b0}};
    else
    begin
      if(~dma_do_clear_all_n)
        dma_fsm_ep_st_r                <= {32{1'b0}};
      else if((dma_fsm_st_r == DMA_FSM_IDLE) & dma_do & (dma_do_cmd == DMA_CMD_ABORT))
        dma_fsm_ep_st_r[{dma_do_epdir, dma_do_epnum}] <= 1'b0;
      else if
        (
          (dma_fsm_nxt == DMA_FSM_WR_PTR) |
          dma_error_outsmm |
          dma_error_trb |
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
            dma_error_stid |
          `endif
          (dma_fsm_nxt == DMA_FSM_MULT)
        )
        dma_fsm_ep_st_r[{dma_buf_epdir_r, dma_buf_epnum_r}] <= 1'b0;
      else if(dma_fsm_rel_buf_ & (~dma_buf_zero_left | dma_buf_ch_r))
        dma_fsm_ep_st_r[{dma_buf_epdir_r, dma_buf_epnum_r}] <= 1'b1;
    end
  end

  assign dma_fsm_ep_st = dma_fsm_ep_st_r & IMPLEMENT_EP;




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_EP_ST_ABORT_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_ep_st_abort_r            <= 1'b0;
    else
    begin
      if(~dma_do_clear_all_n)
        dma_fsm_ep_st_abort_r          <= 1'b0;
      else if((dma_fsm_st_r == DMA_FSM_IDLE) & dma_do & (dma_do_cmd == DMA_CMD_ABORT))
        dma_fsm_ep_st_abort_r <= ~dma_fsm_ep_st_r[{dma_do_epdir, dma_do_epnum}];
      else if (~dma_do_busy)
        dma_fsm_ep_st_abort_r          <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_TRB_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_trb_r                    <= 1'b0;
    else
    begin
      if(~dma_do_busy)
        dma_fsm_trb_r                  <= 1'b1;
      else if(dma_fsm_rd_desc_ & dma_ocp_ack_r)
        dma_fsm_trb_r                  <= dma_fsm_own & (dma_fsm_link | dma_fsm_normal);
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_TRB_CHECK_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_trb_check_r              <= 1'b0;
    else
    begin
      if(dma_fsm_rd_ptr_ | dma_fsm_xfer_)
        dma_fsm_trb_check_r            <= 1'b1;
      else if(dma_fsm_rel_buf_ & dma_buf_zero_left & ~dma_buf_ch_r & dma_buf_mult_r)
        dma_fsm_trb_check_r            <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_RD_CONF_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_rd_conf_r                <= 1'b0;
    else
    begin
      if(dma_do_done & (dma_do_cmd != DMA_CMD_NOP))
        dma_fsm_rd_conf_r              <= 1'b1;
      else if(dma_ack & dma_fsm_addr_max)
        dma_fsm_rd_conf_r              <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_DO_RDTRB_R_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_do_rdtrb_r                <= 1'b0;
    else
    begin
      if(dma_do_done & (dma_do_cmd != DMA_CMD_NOP))
        dma_do_rdtrb_r              <= dma_do_rdtrb;
      else if(dma_fsm_st_r == DMA_FSM_IDLE)
        dma_do_rdtrb_r              <= 1'b0;
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_SMM_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_smm_r                    <= 1'b0;
    else
    begin
      if(~dma_do_busy)
        dma_fsm_smm_r                  <= 1'b0;
      else if(dma_fsm_rel_buf_ & dma_fsm_smm & ~dma_epdir)
        dma_fsm_smm_r                  <= 1'b1;
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_USP_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_usp_r                    <= 1'b0;
    else
    begin
      if(~dma_do_busy)
        dma_fsm_usp_r                  <= 1'b0;
      else if(dma_fsm_rel_buf_ & dma_fsm_usp & ~dma_epdir)
        dma_fsm_usp_r                  <= 1'b1;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_FSM_RESTORE_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_fsm_restore_r                <= 1'b0;
    else if(dma_fsm_restore_)
      dma_fsm_restore_r                <= 1'b1;
    else if(dma_fsm_rd_max_ & dma_fsm_addr_max & dma_ack)
      dma_fsm_restore_r                <= 1'b0;
  end


  assign dma_fsm_xfer_     = (dma_fsm_st_r == DMA_FSM_XFER);
  assign dma_fsm_rd_desc_  =
    (
      (dma_fsm_st_r == DMA_FSM_RD_DESC) |
      dma_fsm_adv_desc_ |
      dma_fsm_rd_again_
    );
  assign dma_fsm_wr_desc_  = (dma_fsm_st_r == DMA_FSM_WR_DESC);
  assign dma_fsm_adv_desc_ = (dma_fsm_st_r == DMA_FSM_ADV_PTR);
  assign dma_fsm_rd_ocp_   = dma_fsm_xfer_ &  dma_buf_epdir_r;
  assign dma_fsm_wr_ocp_   = dma_fsm_xfer_ & ~dma_buf_epdir_r;
  assign dma_fsm_rd_ptr_   = (dma_fsm_st_r == DMA_FSM_RD_PTR);
  assign dma_fsm_wr_ptr_   = (dma_fsm_st_r == DMA_FSM_WR_PTR);
  assign dma_fsm_rd_max_   = (dma_fsm_st_r == DMA_FSM_RD_MAX);
  assign dma_fsm_rel_buf_  = (dma_fsm_st_r == DMA_FSM_REL_BUF);
  assign dma_fsm_rd_again_ = (dma_fsm_st_r == DMA_FSM_RD_AGAIN);
  assign dma_fsm_store_    = (dma_fsm_st_r == DMA_FSM_STORE);
  assign dma_fsm_restore_  = (dma_fsm_st_r == DMA_FSM_RESTORE);
  assign dma_fsm_zero_     = (dma_fsm_st_r == DMA_FSM_ZERO);
  assign dma_fsm_mult_     = (dma_fsm_st_r == DMA_FSM_MULT);


  assign dma_fsm_own       = (dma_buf_tc[{dma_buf_epdir_r, dma_buf_epnum_r}] == dma_mis_out[0]);
  assign dma_fsm_addr_byt  = (dma_fsm_cnt_r == DMA_ADDR_BYTES);
  assign dma_fsm_addr_len  = (dma_fsm_cnt_r == DMA_ADDR_LENGTH);
  assign dma_fsm_addr_des  = (dma_fsm_cnt_r == DMA_ADDR_DESC_PTR);
  assign dma_fsm_addr_dat  = (dma_fsm_cnt_r == DMA_ADDR_DATA_PTR);
  assign dma_fsm_addr_deq  = (dma_fsm_cnt_r == DMA_ADDR_DEQUEUE);
  assign dma_fsm_addr_max  = (dma_fsm_cnt_r == DMA_ADDR_MAX);
  assign dma_fsm_non_zero  = (dma_buf_xferlength_r != {XFERLENGTH_WIDTH{1'b0}});
  assign dma_fsm_link      = (dma_mis_out[15:10] == TRB_LINK) & dma_fsm_rd_desc_;
  assign dma_fsm_normal    = (dma_mis_out[15:10] == TRB_NORMAL) & dma_fsm_rd_desc_;
  assign dma_fsm_chain     = dma_mis_out[4];
  assign dma_fsm_max       = (dma_buf_pktbytes_r == dma_buf_maxpktsize_r);
  assign dma_fsm_sp        = (dma_buf_pktbytes_r != dma_buf_maxpktsize_r);
  assign dma_fsm_usp       = dma_fsm_sp & ~dma_buf_zero_left;
  assign dma_fsm_smm       = (dma_buf_pktbytes_r != dma_buf_pktsize_r);
  assign dma_fsm_trb_error = (~dma_fsm_own | (~dma_fsm_link & ~dma_fsm_normal));












  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_CMD_PROC
    if `CDNSUSBHS_RESET(rst_n)
    begin
      dma_buf_iso_r                    <= 1'b0;
      dma_buf_abort_r                  <= 1'b0;
    end
    else
    begin
      if(~dma_do_busy & dma_do)
      begin
        dma_buf_iso_r                  <= (dma_do_cmd == DMA_CMD_ISO_XFER);
        dma_buf_abort_r                <= (dma_do_cmd == DMA_CMD_ABORT);
      end
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_DO_MULT_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_mult_r                   <= 1'b0;
    else
    begin
      if(~dma_do_busy & dma_do)
        dma_buf_mult_r                 <= dma_do_mult;
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_MAXPKTSIZE_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_maxpktsize_r             <= {PKTLENGTH_WIDTH{1'b0}};
    else
    begin
      if(dma_ack & dma_fsm_rd_max_ & dma_fsm_addr_max)
        dma_buf_maxpktsize_r           <= dma_datar[10:0];
    end
  end










  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_DESC_PTR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_desc_ptr_r               <= {ADDR_WIDTH{1'b0}};
    else
    begin
      if(dma_ack & ((dma_fsm_rd_ptr_  & dma_fsm_addr_deq) | (dma_fsm_restore_ & dma_fsm_addr_des)))
        dma_buf_desc_ptr_r             <= dma_datar;
      else if(dma_fsm_rd_max_ & ~dma_fsm_restore_r & dma_fsm_addr_max & dma_ack & dma_buf_abort_r)
        dma_buf_desc_ptr_r             <= dma_buf_desc_ptr_r + 32'd12;
      else if(dma_fsm_rd_desc_ & dma_ocp_ack_r)
      begin
        if(dma_fsm_link)
          dma_buf_desc_ptr_r           <= dma_buf_ptr_r;
        else if(dma_fsm_own & ~dma_fsm_rd_again_ & (~dma_fsm_adv_desc_ | dma_buf_ch_r | ~dma_fsm_non_zero))
          dma_buf_desc_ptr_r           <= dma_buf_desc_ptr_r + 32'd12;
      end
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_DO_PROC
    if `CDNSUSBHS_RESET(rst_n)
    begin
      dma_buf_epnum_r                  <= {EPNUM_WIDTH{1'b0}};
      dma_buf_epdir_r                  <= 1'b0;
      dma_buf_data_end_r               <= 1'b0;

    end
    else
    begin
      if
      (
        dma_do & ~dma_do_busy & dma_do_clear_all_n & ~dma_ocp_clear &
        (dma_do_cmd != DMA_CMD_NOP)
      )
      begin
        dma_buf_epnum_r                <= dma_do_epnum;
        dma_buf_epdir_r                <= dma_do_epdir;
        dma_buf_data_end_r             <= dma_do_data_endianess;

      end
    end
  end







  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_LENGTH_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_length_r                 <= {XFERLENGTH_WIDTH{1'b0}};
    else if((dma_fsm_st_r == DMA_FSM_RD_DESC) & dma_fsm_link)
      dma_buf_length_r                 <= {XFERLENGTH_WIDTH{1'b0}};
    else
      dma_buf_length_r                 <= dma_buf_length;
  end




  always
  @(
    dma_ack or
    dma_buf_ch_r or
    dma_buf_length_r or
    dma_buf_xferlength_r or
    dma_datar or
    dma_fsm_addr_len or
    dma_fsm_adv_desc_ or
    dma_fsm_normal or
    dma_fsm_rd_again_ or
    dma_fsm_rd_desc_ or
    dma_fsm_restore_ or
    dma_ocp_ack_r
  )
  begin : DMA_BUF_LENGTH_COMB_PROC
    dma_buf_length                     = dma_buf_length_r;
    if(dma_ack & dma_fsm_restore_ & dma_fsm_addr_len)
      dma_buf_length                   = dma_datar[16:00];
    else if(dma_fsm_rd_desc_ & dma_ocp_ack_r & dma_fsm_normal)
    begin
      if(dma_fsm_adv_desc_ & dma_buf_ch_r)
        dma_buf_length                 = dma_buf_length_r + dma_buf_xferlength_r;
      else
      if(~dma_fsm_rd_again_)
        dma_buf_length                 = dma_buf_xferlength_r;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_PARAMS_PROC
    if `CDNSUSBHS_RESET(rst_n)
    begin
      dma_buf_tdtype_r                 <= {6{1'b0}};
      dma_buf_c_r                      <= 1'b0;
    end
    else
    begin
      if(dma_fsm_rd_desc_ & dma_ocp_ack_r)
      begin
        dma_buf_tdtype_r               <= dma_mis_out[15:10];
        dma_buf_c_r                    <= dma_mis_out[0];
      end
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_STID_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_stid_r                   <= {STID_WIDTH{1'b0}};
    else
    begin
      if(dma_fsm_rd_desc_ & dma_ocp_ack_r)
        dma_buf_stid_r                 <= dma_mis_out[31:32-STID_WIDTH];
      else if(dma_fsm_restore_)
      begin
        if(dma_fsm_addr_byt)
          dma_buf_stid_r[15:8]         <= dma_datar[31:24];
        else if(dma_fsm_addr_len)
          dma_buf_stid_r[7:0]          <= dma_datar[31:24];
      end
    end
  end

  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK



    `CDNSUSBHS_ALWAYS(clk,rst_n)
    begin : DMA_BUF_STID_ERR_PROC
      if `CDNSUSBHS_RESET(rst_n)
        dma_buf_stid_err_r             <= 1'b0;
      else
      begin
        if(~dma_epptr & dma_buf_pkt_start & dma_ack & dma_re)
          dma_buf_stid_err_r           <= dma_buf_stid_err_r & (dma_buf_stid_r != dma_stid_out);
        else if(dma_do & ~dma_do_busy)
          dma_buf_stid_err_r           <= ~dma_do_epdir & (dma_do_cmd != DMA_CMD_ABORT);
      end
    end
  `endif




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_TC_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_tc_r                     <= 32'hFFFFFFFF;
    else
    begin
      if(~dma_do_clear_all_n)
        dma_buf_tc_r                   <= 32'hFFFFFFFF;
      else if(dma_fsm_rd_desc_ & dma_ocp_ack_r & dma_fsm_link & dma_fsm_own)
        dma_buf_tc_r[{dma_buf_epdir_r, dma_buf_epnum_r}] <=
          ( dma_buf_tc_r[{dma_buf_epdir_r, dma_buf_epnum_r}] ^ dma_mis_out[1] );
    end
  end

  assign dma_buf_tc = dma_buf_tc_r & IMPLEMENT_EP;





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_IOC_ISP_F_PROC
    if `CDNSUSBHS_RESET(rst_n)
    begin
      dma_buf_ioc_r                    <= 1'b0;
      dma_buf_isp_r                    <= 1'b0;
      dma_buf_f_r                      <= 1'b0;
    end
    else
    begin
      if(dma_fsm_rd_desc_ & dma_ocp_ack_r)
      begin
        dma_buf_ioc_r                  <= dma_mis_out[5];
        dma_buf_isp_r                  <= dma_mis_out[2];
        dma_buf_f_r                    <= dma_mis_out[3];
      end
      else if(dma_fsm_restore_ & dma_ack & dma_fsm_addr_byt)
      begin
        dma_buf_isp_r                  <= dma_datar[22];
        dma_buf_ioc_r                  <= dma_datar[21];
        dma_buf_f_r                    <= dma_datar[20];
      end
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_CH_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_ch_r                     <= 1'b0;
    else
    begin
      if(dma_fsm_rd_desc_ & dma_ocp_ack_r)
        dma_buf_ch_r                   <= dma_mis_out[4];
      else if(dma_fsm_restore_ & dma_ack & dma_fsm_addr_byt)
        dma_buf_ch_r                   <= dma_datar[23];
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_PREV_PTR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_prev_ptr_r               <= {ADDR_WIDTH{1'b0}};
    else
    begin
      if(dma_fsm_rd_desc_ & dma_ocp_ack_r & ~dma_fsm_rd_again_)
        dma_buf_prev_ptr_r             <= dma_buf_desc_ptr_r;

      else if(dma_ack & dma_fsm_addr_deq & (dma_fsm_rd_max_ |
                (dma_fsm_rd_ptr_ & dma_buf_abort_r)))
        dma_buf_prev_ptr_r             <= dma_datar[31:0];
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_DEQ_PTR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_deq_ptr_r                <= {ADDR_WIDTH{1'b0}};
    else
    begin

      if(dma_ack & dma_fsm_addr_deq & (dma_fsm_rd_ptr_ | dma_fsm_rd_max_))
        dma_buf_deq_ptr_r              <= dma_datar;
      else if((dma_fsm_rd_desc_ | dma_fsm_adv_desc_) & dma_ocp_ack_r & ~dma_fsm_trb_error & dma_fsm_link)
        dma_buf_deq_ptr_r              <= dma_buf_ptr_r;
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_XFERLENGTH_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_xferlength_r             <= {XFERLENGTH_WIDTH{1'b0}};
    else
    begin
      if
      (
        dma_fsm_rd_desc_ & dma_ocp_resp_dva_r &
        (
          (dma_ocp_base_mis_r == 2'd0)
            ? (dma_ocp_rd_bytes_r < 11'd12)
            : ((dma_ocp_rd_bytes_r + dma_ocp_base_mis_r) < 11'd13)
        )
      )
        dma_buf_xferlength_r           <= dma_mis_out[XFERLENGTH_WIDTH-1:0];
    end
  end


  assign dma_buf_xferlength = dma_buf_total_left[XFERLENGTH_WIDTH-1:0];
  assign dma_buf_xferlength_val = (!dma_fsm_xfer_ & (dma_fsm_nxt == DMA_FSM_XFER))|
                                  (!dma_fsm_zero_ & (dma_fsm_nxt == DMA_FSM_ZERO));
  assign dma_buf_pre_val = (dma_fsm_nxt == DMA_FSM_HOST_PRE);

`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_BURSTLENGTH_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_burstlength_r            <= 8'd0;
    else
    begin
      if
      (
        dma_fsm_rd_desc_ & dma_ocp_resp_dva_r &
        (
          (dma_ocp_base_mis_r == 2'd0)
            ? (dma_ocp_rd_bytes_r < 11'd12)
            : ((dma_ocp_rd_bytes_r + dma_ocp_base_mis_r) < 11'd13)
        )
      )
        dma_buf_burstlength_r          <= dma_mis_out[31:24];
      else if(dma_fsm_restore_)
      begin
        if(dma_fsm_addr_byt)
          dma_buf_burstlength_r[7]            <= dma_datar[19];
        else if(dma_fsm_addr_len)
          dma_buf_burstlength_r[6:0]   <= dma_datar[23:17];
      end
    end
  end
`endif








  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_PTR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_ptr_r                    <= {ADDR_WIDTH{1'b0}};
    else
    begin
      if(dma_fsm_restore_ & dma_ack & dma_fsm_addr_dat)
        dma_buf_ptr_r                  <= dma_datar;
      else if(dma_fsm_rd_desc_ & dma_ocp_resp_dva_r & (dma_ocp_rd_bytes_r < 11'd8))
        dma_buf_ptr_r                  <= dma_mis_out;
      else if
      (
        ~dma_buf_f_r &
        (
          (~dma_buf_epdir_r & dma_ocp_ack_r) |
          (
            dma_buf_epdir_r & dma_ocp_ack_r &
            (dma_ocp_zero_left | (dma_fsm_rel_buf_ & (~dma_buf_zero_left | dma_buf_ch_r)))
          )
        )
      )
        dma_buf_ptr_r                  <= dma_buf_ptr_r + dma_ocp_bytes_nxt;
    end
  end










  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_BYTES_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_bytes_r                  <= {XFERLENGTH_WIDTH{1'b0}};
    else
      dma_buf_bytes_r                  <= dma_buf_bytes;
  end




  always
  @(
    dma_ack or
    dma_buf_abort_r or
    dma_buf_bytes_r or
    dma_buf_pktbytes_r or
    dma_datar or
    dma_fsm_addr_byt or
    dma_fsm_st_r
  )
  begin : DMA_BUF_BYTES_COMB_PROC
    dma_buf_bytes                      = dma_buf_bytes_r;
    case(dma_fsm_st_r)
      DMA_FSM_MULT :
        dma_buf_bytes                  = {XFERLENGTH_WIDTH{1'b0}};

      DMA_FSM_REL_BUF :
        dma_buf_bytes                  = dma_buf_bytes_r + dma_buf_pktbytes_r;

      DMA_FSM_RD_PTR :
        if(dma_buf_abort_r)
        begin
          if(dma_ack & dma_fsm_addr_byt)
            dma_buf_bytes              = dma_datar[16:0];
        end
        else
          dma_buf_bytes                = {XFERLENGTH_WIDTH{1'b0}};

      DMA_FSM_RESTORE :
        if(dma_ack & dma_fsm_addr_byt)
          dma_buf_bytes                = dma_datar[16:0];

      default :
        dma_buf_bytes                  = dma_buf_bytes_r;
    endcase
  end







  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_PKTSIZE_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_pktsize_r                <= {PKTLENGTH_WIDTH{1'b0}};
    else
      dma_buf_pktsize_r                <= dma_buf_pktsize;
  end




  always
  @(
    dma_fsm_addr_max or
    dma_ack or
    dma_buf_epdir_r or
    dma_buf_pkt_start or
    dma_buf_pktsize_r or
    dma_datar or
    dma_do_busy or
    dma_epptr or
    dma_fsm_rd_max_ or
    dma_fsm_rel_buf_ or
    dma_pktsize_out or
    dma_re
  )
  begin : DMA_BUF_PKTSIZE_COMB_PROC
    dma_buf_pktsize                    = dma_buf_pktsize_r;
    if(~dma_do_busy | (~dma_buf_epdir_r & dma_fsm_rel_buf_))
      dma_buf_pktsize                  = {PKTLENGTH_WIDTH{1'b0}};
    else if(~dma_buf_epdir_r)
    begin
      if(~dma_epptr & dma_buf_pkt_start & dma_ack & dma_re)
        dma_buf_pktsize                = dma_pktsize_out;
    end
    else if(dma_ack & dma_fsm_rd_max_
      & dma_fsm_addr_max)
      dma_buf_pktsize                  = dma_datar[10:0];
  end







  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_PKTBYTES_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_pktbytes_r               <= {PKTLENGTH_WIDTH{1'b0}};
    else
      dma_buf_pktbytes_r               <= dma_buf_pktbytes;
  end




  always
  @(
    dma_buf_pktbytes_nxt or
    dma_buf_pktbytes_r or
    dma_fsm_rd_ptr_ or
    dma_fsm_rel_buf_ or
    dma_fsm_restore_ or
    dma_fsm_xfer_ or
    dma_ocp_ack_r or
    dma_ocp_zero_left
  )
  begin : DMA_BUF_PKTBYTES_COMB_PROC
    dma_buf_pktbytes                   = dma_buf_pktbytes_r;
    if(dma_fsm_rd_ptr_ | dma_fsm_restore_ | dma_fsm_rel_buf_)
      dma_buf_pktbytes                 = {PKTLENGTH_WIDTH{1'b0}};
    else if(dma_ocp_ack_r & dma_ocp_zero_left & dma_fsm_xfer_)
      dma_buf_pktbytes                 = dma_buf_pktbytes_nxt;
  end

  assign dma_buf_pktbytes_nxt = dma_buf_pktbytes_r + dma_ocp_xferlength_r;






  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_BUF_DATA_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_buf_data_r                   <= {DATA_WIDTH{1'b0}};
    else
    begin
      if((dma_fsm_rd_desc_ | dma_fsm_rd_ocp_) & dma_ocp_resp_dva)
      begin
        if(dma_ocp_rd_be_fifo_out[3])
          dma_buf_data_r[31:24]        <= sdata_m[31:24];
        if(dma_ocp_rd_be_fifo_out[2])
          dma_buf_data_r[23:16]        <= sdata_m[23:16];
        if(dma_ocp_rd_be_fifo_out[1])
          dma_buf_data_r[15:08]        <= sdata_m[15:08];
        if(dma_ocp_rd_be_fifo_out[0])
          dma_buf_data_r[07:00]        <= sdata_m[07:00];
      end
      else if(dma_fsm_wr_ocp_ & dma_ack & dma_re)
        dma_buf_data_r                 <= dma_datar;
      else if(dma_fsm_nxt == DMA_FSM_WR_DESC)
      begin
        if((~dma_ocp_wr_desc_r) | ((dma_ocp_be_r == 4'h2) & ~dma_ocp_scmdaccept))
          dma_buf_data_r               <= dma_buf_ptr_r;
        else if((dma_ocp_be_r == 4'h2) | ((dma_ocp_bytes_r == 11'd0) & ~dma_ocp_scmdaccept))
        if( dma_fsm_ep_st_abort_r )
          dma_buf_data_r               <=
            {
              {32{1'b0}}
            };
        else
          dma_buf_data_r               <=
            {
              {15{1'b0}},
              (dma_buf_xferlength_r - dma_buf_length_r + dma_buf_bytes_r)
            };
        else
        if(dma_ocp_scmdaccept)
          dma_buf_data_r               <=
            {
              dma_buf_stid_r,
              dma_buf_tdtype_r,
              4'b0000,
              dma_buf_ioc_r,
              dma_buf_ch_r,
              dma_buf_f_r,
              dma_buf_isp_r,
              1'b0,
              dma_buf_c_r
            };
      end
    end
  end








  assign dma_buf_zero_left  = (dma_buf_length_r == (dma_buf_bytes_r + dma_buf_pktbytes_r));
  assign dma_buf_pkt_start  = (dma_pktaddr_r == {PKTADDR_WIDTH{1'b0}});
  assign dma_buf_pkt_cmpl   = ({dma_pktaddr_r,2'b00} >= dma_buf_pktsize_r);
  assign dma_buf_part_left  = dma_buf_length - dma_buf_bytes;
  assign dma_buf_total_left = dma_buf_part_left - dma_buf_pktbytes;







  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_CMD_ACC_R_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_cmd_acc_r                <= 2'd0;
    else
    begin
      if(dma_ocp_scmdaccept & (dma_ocp_mcmd_m_r == OCP_CMD_RD))
      begin
        if(~dma_ocp_resp_dva)
          dma_ocp_cmd_acc_r            <= dma_ocp_cmd_acc_r + 2'd1;
      end
      else if(dma_ocp_resp_dva)
        dma_ocp_cmd_acc_r              <= dma_ocp_cmd_acc_r - 2'd1;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_FST_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_fst_r                    <= 1'b0;
    else
      dma_ocp_fst_r                    <= ~((~|dma_ocp_be_r) & (&dma_ocp_be_nxt) & dma_fsm_xfer_);
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_HOLD_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_hold_r                   <= 1'b0;
    else
    begin
      if((dma_ocp_mcmd_m_r != OCP_CMD_IDLE) & ~dma_ocp_scmdaccept)
        dma_ocp_hold_r                 <= 1'b1;
      else if(dma_ocp_scmdaccept)
        dma_ocp_hold_r                 <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_REQLAST_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_reqlast_r                <= 1'b1;
    else
    begin
      if(dma_ocp_mcmd_m_r != OCP_CMD_IDLE)
        dma_ocp_reqlast_r              <= mreqlast_m;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_CLEAR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_clear_r                  <= 1'b0;
    else
    begin
      if
      (
        ~dma_do_clear_all_n & (~dma_ocp_reqlast_r | ~mreqlast_m) &
        ((dma_fsm_st_r != DMA_FSM_IDLE) | dma_ocp_hold_r)
      )
        dma_ocp_clear_r                <= 1'b1;
      else if(dma_ocp_scmdaccept & mreqlast_m)
        dma_ocp_clear_r                <= 1'b0;
    end
  end




  `ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
    assign dma_ocp_cmd_limit = 2'd2;
  `else
    assign dma_ocp_cmd_limit = 2'd1;
  `endif
  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : MCMD_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_mcmd_m_r                           <= OCP_CMD_IDLE;
    else if(~dma_do_clear_all_n & ~dma_ocp_hold_n & ~dma_ocp_clear)
      dma_ocp_mcmd_m_r                           <= OCP_CMD_IDLE;
    else
    begin
      if(dma_ocp_hold_n | dma_ocp_clear)
        dma_ocp_mcmd_m_r                         <= dma_ocp_mcmd_m_r;
      else if
      (
        ( (|dma_ocp_be_r) | (dma_ocp_xfer_step & ~dma_ocp_ack_hold_r)) &
        (~dma_ocp_zero_left_nxt | ~dma_ocp_scmdaccept)
      )
      begin
        if
        (
          (
            ~dma_ocp_zero_left &
            (
              (dma_ocp_cmd_acc_r < dma_ocp_cmd_limit) |
              (
                (dma_ocp_cmd_acc_r == dma_ocp_cmd_limit) &
                (~dma_ocp_scmdaccept | dma_ocp_resp_dva)
              )
            )
          ) &
          (
            dma_fsm_rd_desc_ |
            (
              dma_fsm_rd_ocp_ &
              (
                (
                  (dma_ack | (dma_ocp_bytes_nxt == 11'd0)) &
                  (
                    ~dma_ocp_scmdaccept |
                    dma_ocp_resp_dva |
                    (dma_ocp_cmd_acc_r == 2'b00)
                  )
                ) |
                (
                  dma_ack_prev_r[0] &
                  (dma_ack | ~dma_ocp_scmdaccept) &
                  `ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
                    ((~dma_we_ok | dma_ack) | ((dma_we_ok & ~dma_ack) & dma_ocp_resp_dva))
                  `else
                    (~dma_we_ok | (dma_we_ok & dma_ocp_resp_dva))
                  `endif
                )
              )
            )
          )
        )
          dma_ocp_mcmd_m_r                       <= OCP_CMD_RD;
        else if
        (
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
            ~dma_buf_stid_err_r &
          `endif
          (
            (
              dma_fsm_wr_desc_ &
              dma_ocp_wr_desc_r &
              ~dma_ocp_scmdaccept &
              ~dma_ocp_ack
            ) |
            (
              dma_fsm_wr_ocp_ &
              ~dma_ocp_ack_r &
              (dma_ack | dma_buf_pkt_cmpl) &
              (dma_out_overhead | (dma_ocp_base_mis_r > 2'b01)) &
              (dma_ocp_fst_r | ~dma_ocp_scmdaccept)
            )
          )
        )
          dma_ocp_mcmd_m_r                       <= OCP_CMD_WR;
        else
          dma_ocp_mcmd_m_r                       <= OCP_CMD_IDLE;
      end
      else
        dma_ocp_mcmd_m_r                         <= OCP_CMD_IDLE;
    end
  end

`ifdef CDNSUSBHS_CONT_BURST_PROTECTION





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_EPPTR_TRB_R_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_epptr_trb_r <= 1'b0;
    else
      dma_epptr_trb_r <= dma_epptr || dma_trb;
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : BLOCK_FIRST_OCP_CMD_R_PROC
    if `CDNSUSBHS_RESET(rst_n)
      block_first_ocp_cmd_r <= 1'b0;
    else

      if (mburstprecise_m && mreqlast_m && dma_ocp_scmdaccept && mburstlength_m[7:1] != 7'd0 &&
     `ifdef CDNSUSBHS_DATA_SYNC0_DEPTH_FULL
            ((dma_fifor_lvl <= 4'd5 && ~dma_epdir) ||
             (dma_fifow_lvl <= 4'd5 && dma_epdir))
         )
      `else
            ((dma_fifor_lvl <= 4'd3 && ~dma_epdir) ||
             (dma_fifow_lvl <= 4'd3 && dma_epdir))
         )
      `endif
        block_first_ocp_cmd_r <= 1'b1;

      else if (dma_ack || (dma_pktsize_out == 11'd0 && ~dma_epdir))
        block_first_ocp_cmd_r <= 1'b0;

      else if (dma_last ||
                (!(dma_trb || dma_epptr) && dma_epptr_trb_r && ~dma_epdir)
         )
        block_first_ocp_cmd_r <= 1'b1;

  end




  assign dma_fifor_aligned = (dma_ocp_xferlength_r[3:0]== 4'd0)? 1'b1:1'b0;





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : BLOCK_OCP_CMD_R_PROC
    if `CDNSUSBHS_RESET(rst_n)
      block_ocp_cmd_r <= 1'b0;
    else
      if (block_first_ocp_cmd_r)
        block_ocp_cmd_r <= 1'b1;
     `ifdef CDNSUSBHS_DATA_SYNC0_DEPTH_FULL
      else if (mburstprecise_m && mreqlast_m && dma_ocp_scmdaccept && mburstlength_m[7:1] != 7'd0 &&
                 ((dma_fifor_lvl <= 4'd5 && ~dma_epdir) ||
                  (dma_fifow_lvl <= 4'd5 && dma_epdir))
              )
        block_ocp_cmd_r <= 1'b1;
      else if
        (dma_trb ||
          (dma_ocp_mcmd_m_r != OCP_CMD_IDLE && mburstlength_m[7:1] == 7'd0) ||
          (                             dma_pktsize_out >= 11'd69 && dma_fifor_lvl >= 4'd6 && ~dma_epdir) ||
          (dma_pktsize_out <= 11'd80 && dma_pktsize_out >  11'd64 && dma_fifor_lvl == 4'd5 && ~dma_epdir &&  dma_fifor_aligned) ||
          (dma_pktsize_out <  11'd80 && dma_pktsize_out >= 11'd53 && dma_fifor_lvl == 4'd5 && ~dma_epdir && ~dma_fifor_aligned) ||
          (dma_pktsize_out <= 11'd64 && dma_pktsize_out >  11'd48 && dma_fifor_lvl == 4'd4 && ~dma_epdir &&  dma_fifor_aligned) ||
          (dma_pktsize_out <  11'd64 && dma_pktsize_out >= 11'd37 && dma_fifor_lvl == 4'd4 && ~dma_epdir && ~dma_fifor_aligned) ||
          (dma_pktsize_out <= 11'd48 && dma_pktsize_out >  11'd32 && dma_fifor_lvl == 4'd3 && ~dma_epdir &&  dma_fifor_aligned) ||
          (dma_pktsize_out <  11'd48 && dma_pktsize_out >= 11'd21 && dma_fifor_lvl == 4'd3 && ~dma_epdir && ~dma_fifor_aligned) ||
          (dma_xfer_finished         && dma_ack               && ~dma_epdir) ||
          (dma_fifow_lvl >= 4'd6 && dma_epdir)
        )
        block_ocp_cmd_r <= 1'b0;
     `else
      else if (mburstprecise_m && mreqlast_m && dma_ocp_scmdaccept && mburstlength_m[7:1] != 7'd0 &&
                 ((dma_fifor_lvl <= 4'd3 && ~dma_epdir) ||
                  (dma_fifow_lvl <= 4'd3 && dma_epdir))
              )
        block_ocp_cmd_r <= 1'b1;
      else if
        (dma_trb ||
          (dma_ocp_mcmd_m_r != OCP_CMD_IDLE && mburstlength_m[7:1] == 7'd0) ||
          (                             dma_pktsize_out >= 11'd37 && dma_fifor_lvl >= 4'd4 && ~dma_epdir) ||
          (dma_pktsize_out <= 11'd48 && dma_pktsize_out >  11'd32 && dma_fifor_lvl == 4'd3 && ~dma_epdir &&  dma_fifor_aligned) ||
          (dma_pktsize_out <  11'd48 && dma_pktsize_out >= 11'd21 && dma_fifor_lvl == 4'd3 && ~dma_epdir && ~dma_fifor_aligned) ||
          (dma_xfer_finished         && dma_ack                   && ~dma_epdir) ||
          (dma_fifow_lvl >= 4'd4 && dma_epdir)
        )
        block_ocp_cmd_r <= 1'b0;
      `endif
  end





  assign mcmd_m = (block_ocp_cmd_r) ? 2'b00 : dma_ocp_mcmd_m_r;

`else



  assign mcmd_m = dma_ocp_mcmd_m_r;
`endif




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : MADDR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      maddr_m                          <= {OCP_ADDR_WIDTH{1'b0}};
    else
    begin
      if(~dma_ocp_hold_n)
        maddr_m                        <= {dma_ocp_addr[OCP_ADDR_WIDTH-1:2], 2'd0};
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : MDATA_PROC
    if `CDNSUSBHS_RESET(rst_n)
      mdata_m                          <= {DATA_WIDTH{1'b0}};
    else
    begin
      if ((dma_fsm_wr_ocp_ | dma_fsm_wr_desc_) & dma_ocp_next_re)
        mdata_m                        <= dma_mis_out;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_MBURSTLENGTH_PROC
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
    if `CDNSUSBHS_RESET(rst_n)
    begin
      dma_ocp_mburstlength_r           <= 8'd1;
      dma_ocp_burst_cnt_r              <= 8'd1;
    end
    else
    begin
      if(dma_fsm_xfer_)
      begin
        if(dma_ocp_xfer_step)
        begin
          if(dma_buf_burstlength_r == 8'd0)
          begin
            if( (dma_ocp_be_nxt != OCP_BE_1111) | (dma_ocp_left_nxt < 11'd8) | dma_ocp_clear_r)
            begin
              dma_ocp_mburstlength_r   <= 8'd1;
              dma_ocp_burst_cnt_r      <= 8'd1;
            end
            else
            begin
              dma_ocp_mburstlength_r   <= 8'd2;
              dma_ocp_burst_cnt_r      <= 8'd2;
            end
          end
          else
          begin
            if(dma_ocp_burst_cnt_r == 8'd1)
            begin
              if
              (
                (dma_ocp_be_nxt == OCP_BE_1111) &&
                (dma_ocp_left_nxt[PKTLENGTH_WIDTH-1:2] >= {1'b0, dma_buf_burstlength_r}) &&
                (dma_ocp_addr[11:6]!=6'b111111 || dma_ocp_addr[5:0]==6'b000000) &&
                ~dma_ocp_clear_r
              )
              begin
                dma_ocp_mburstlength_r <= dma_buf_burstlength_r;
                dma_ocp_burst_cnt_r    <= dma_buf_burstlength_r;
              end
              else
              begin
                dma_ocp_mburstlength_r <= 8'd1;
                dma_ocp_burst_cnt_r    <= 8'd1;
              end
            end
            else
               dma_ocp_burst_cnt_r  <= dma_ocp_burst_cnt_r - 8'd1;
          end
        end
      end
      else
      begin
        dma_ocp_mburstlength_r         <= 8'd1;
        dma_ocp_burst_cnt_r            <= 8'd1;
      end
    end
`else
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_mburstlength_r           <= 2'b00;
    else
    begin
      if(dma_ocp_xfer_step)
      begin
        if( (dma_ocp_be_nxt != OCP_BE_1111) | (dma_ocp_left_nxt < 11'd8) | dma_ocp_clear_r)
          dma_ocp_mburstlength_r       <= 2'b01;
        else
          dma_ocp_mburstlength_r       <= 2'b10;
      end
    end
`endif
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_ACK_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_ack_r                    <= 1'b0;
    else
      dma_ocp_ack_r                    <= dma_ocp_ack;
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_ACK_HOLD_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_ack_hold_r               <= 1'b0;
    else
    begin
      if(dma_ocp_ack)
        dma_ocp_ack_hold_r             <= 1'b1;
      else if((dma_fsm_nxt != dma_fsm_st_r) | dma_fsm_rd_desc_)
        dma_ocp_ack_hold_r             <= 1'b0;
    end
  end




  always
  @(
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
    dma_ocp_zero_left_nxt or
`endif
    dma_ocp_base_mis or
    dma_ocp_be_r or
    dma_ocp_left_nxt or
    dma_ocp_wr_desc_r or
    dma_ocp_zero_left or
    dma_fsm_wr_desc_
  )
  begin : DMA_OCP_BE_NXT_COMB_PROC
    dma_ocp_be_nxt                     = dma_ocp_be_r;
    if(~dma_ocp_zero_left & (dma_ocp_wr_desc_r | ~dma_fsm_wr_desc_) )
      case(dma_ocp_be_r)
        OCP_BE_0000 :
          case(dma_ocp_base_mis)
              `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
                2'd3 :
                  dma_ocp_be_nxt       = OCP_BE_1000;

                2'd2 :
                  if(dma_ocp_left_nxt == 11'd1)
                    dma_ocp_be_nxt     = OCP_BE_0100;
                  else if(~dma_ocp_zero_left_nxt)
                    dma_ocp_be_nxt      = OCP_BE_1100;

                2'd1 :
                  dma_ocp_be_nxt       = OCP_BE_0010;
              `endif
              default :
                if( dma_ocp_left_nxt > 11'd3 )
                  dma_ocp_be_nxt       = OCP_BE_1111;
                else if((dma_ocp_left_nxt == 11'd2) | (dma_ocp_left_nxt == 11'd3))
                  dma_ocp_be_nxt       = OCP_BE_0011;
                else if(dma_ocp_left_nxt == 11'd1)
                  dma_ocp_be_nxt       = OCP_BE_0001;
          endcase

       `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
          OCP_BE_0010 :
            if(dma_ocp_left_nxt == 11'd1)
              dma_ocp_be_nxt           = OCP_BE_0100;
            else if(~dma_ocp_zero_left_nxt)
              dma_ocp_be_nxt           = OCP_BE_1100;
            else
              dma_ocp_be_nxt           = OCP_BE_0000;
        `endif
        OCP_BE_0011 :
          if(dma_ocp_left_nxt == 11'd1)
            dma_ocp_be_nxt             = OCP_BE_0100;
          else
            dma_ocp_be_nxt             = OCP_BE_0000;

       `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
          OCP_BE_1000,
          OCP_BE_1100,
        `endif
        OCP_BE_1111 :
          if(dma_ocp_left_nxt > 11'd3)
            dma_ocp_be_nxt             = OCP_BE_1111;
          else if(dma_ocp_left_nxt == 11'd1)
            dma_ocp_be_nxt             = OCP_BE_0001;
          else if((dma_ocp_left_nxt == 11'd2) | (dma_ocp_left_nxt == 11'd3))
            dma_ocp_be_nxt             = OCP_BE_0011;
          else
            dma_ocp_be_nxt             = OCP_BE_0000;

        default:
          dma_ocp_be_nxt               = OCP_BE_0000;
      endcase
  end






  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_BE_PROC
    if `CDNSUSBHS_RESET(rst_n)
    begin
      dma_ocp_be_r                     <= {DATA_WIDTH/8{1'b0}};
      dma_ocp_prev_be_r                <= {DATA_WIDTH/8{1'b0}};
    end
    else
    begin
      if(~dma_do_clear_all_n & ~dma_ocp_hold_n & ~dma_ocp_clear)
      begin
        dma_ocp_be_r                   <= {DATA_WIDTH/8{1'b0}};
        dma_ocp_prev_be_r              <= {DATA_WIDTH/8{1'b0}};
      end
      else if(dma_fsm_xfer_ | dma_fsm_rd_desc_ | dma_fsm_wr_desc_)
      begin
        if(dma_ocp_ack_hold_r)
        begin
          dma_ocp_be_r                 <= {DATA_WIDTH/8{1'b0}};
          dma_ocp_prev_be_r            <= {DATA_WIDTH/8{1'b0}};
        end
        else if(dma_ocp_xfer_step)
        begin
          dma_ocp_be_r                 <= dma_ocp_be_nxt;
          dma_ocp_prev_be_r            <= dma_ocp_be_r;
        end
      end
      else if(~dma_ocp_hold_n)
      begin
        dma_ocp_be_r                   <= {DATA_WIDTH/8{1'b0}};
        dma_ocp_prev_be_r              <= {DATA_WIDTH/8{1'b0}};
      end
    end
  end











  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_BYTES_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_bytes_r                  <= {PKTLENGTH_WIDTH{1'b0}};
    else
    begin
      if
      (
        (dma_ocp_ack_r & (dma_fsm_rd_ocp_  | dma_fsm_wr_ocp_ | dma_fsm_wr_desc_)) |
        (dma_ocp_ack   & (dma_fsm_rd_desc_)) | (~dma_do_busy & ~dma_ocp_clear)
      )
        dma_ocp_bytes_r                <= {PKTLENGTH_WIDTH{1'b0}};
      else if
      (
        dma_ocp_scmdaccept & (dma_ocp_mcmd_m_r != OCP_CMD_IDLE) &
        (
          dma_fsm_wr_ocp_ | dma_fsm_wr_desc_ |
          dma_fsm_rd_ocp_ | dma_fsm_rd_desc_
        )
      )
        dma_ocp_bytes_r                <= dma_ocp_bytes_nxt;
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_RD_BE_FIFO_PROC
    if `CDNSUSBHS_RESET(rst_n)
    begin
      dma_ocp_rd_be_fifo_0_r           <= {DATA_WIDTH/8{1'b0}};
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
      dma_ocp_rd_be_fifo_1_r           <= {DATA_WIDTH/8{1'b0}};
`endif
      dma_ocp_rd_be_fifo_ptr           <= 2'd0;
    end
    else
    case(dma_ocp_cmd_acc_r)
      2'd1:
        if(dma_ocp_scmdaccept)
        begin
          if(dma_ocp_resp_dva)
            dma_ocp_rd_be_fifo_ptr     <= 2'd0;
          else
          begin
            dma_ocp_rd_be_fifo_0_r     <= dma_ocp_prev_be_r;
            dma_ocp_rd_be_fifo_ptr     <= 2'd1;
          end
        end
        else
        if(dma_ocp_resp_dva)
          dma_ocp_rd_be_fifo_ptr       <= 2'd0;
      2'd2:
        if(dma_ocp_scmdaccept)
        begin
          if(dma_ocp_resp_dva)
          begin
            dma_ocp_rd_be_fifo_0_r     <= dma_ocp_prev_be_r;
            dma_ocp_rd_be_fifo_ptr     <= 2'd1;
          end
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
            else
            begin
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
              dma_ocp_rd_be_fifo_1_r   <= dma_ocp_rd_be_fifo_0_r;
`endif
              dma_ocp_rd_be_fifo_0_r   <= dma_ocp_prev_be_r;
              dma_ocp_rd_be_fifo_ptr   <= 2'd2;
            end
          `endif
        end
        else
        if(dma_ocp_resp_dva)
          dma_ocp_rd_be_fifo_ptr       <= 2'd0;
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
        2'd3:
          if(dma_ocp_resp_dva)
            dma_ocp_rd_be_fifo_ptr     <= 2'd1;
      `endif
      default:
        begin
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
          dma_ocp_rd_be_fifo_1_r       <= {DATA_WIDTH/8{1'b0}};
`endif
          dma_ocp_rd_be_fifo_0_r       <= {DATA_WIDTH/8{1'b0}};
          dma_ocp_rd_be_fifo_ptr       <= 2'd0;
        end
    endcase
  end
  always
  @(
    dma_ocp_prev_be_r or
    dma_ocp_rd_be_fifo_0_r or
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
    dma_ocp_rd_be_fifo_1_r or
`endif
    dma_ocp_rd_be_fifo_ptr
  )
  begin : DMA_OCP_RD_BE_FIFO_OUT_COMB_PROC
    case(dma_ocp_rd_be_fifo_ptr)
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
        2'd2:  dma_ocp_rd_be_fifo_out  = dma_ocp_rd_be_fifo_1_r;
      `endif
      2'd1:    dma_ocp_rd_be_fifo_out  = dma_ocp_rd_be_fifo_0_r;
      default: dma_ocp_rd_be_fifo_out  = dma_ocp_prev_be_r;
    endcase
  end
  always @(dma_ocp_rd_be_fifo_out)
  begin : DMA_OCP_RD_BE_DECODE_COMB_PROC
    case(dma_ocp_rd_be_fifo_out)
      4'h0:   dma_ocp_rd_be_decode     = 3'd0;
      4'h1,
      4'h2,
      4'h4,
      4'h8:   dma_ocp_rd_be_decode     = 3'd1;
      4'h3,
      4'hC:   dma_ocp_rd_be_decode     = 3'd2;
      default: dma_ocp_rd_be_decode    = 3'd4;
    endcase
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_RD_BYTES_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_rd_bytes_r               <= {PKTLENGTH_WIDTH{1'b0}};
    else
    begin
      if(dma_ocp_ack_r)
        dma_ocp_rd_bytes_r             <= {PKTLENGTH_WIDTH{1'b0}};
      else
      if(dma_ocp_resp_dva)
        dma_ocp_rd_bytes_r             <= dma_ocp_rd_bytes_r + {{(PKTLENGTH_WIDTH-3){1'b0}},dma_ocp_rd_be_decode};
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_RD_BE_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_rd_be_r                  <= {(DATA_WIDTH/8){1'b0}};
    else
    begin
      if(dma_ocp_cmd_acc_r == 2'd0)
        dma_ocp_rd_be_r                <= dma_ocp_be_r;
      else if(dma_ocp_resp_dva)
      begin
        if(dma_ocp_cmd_acc_r == 2'd1)
          dma_ocp_rd_be_r              <= dma_ocp_be_r;
        else
          dma_ocp_rd_be_r              <= dma_ocp_prev_be_r;
      end
    end
  end





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_BASE_MIS_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_base_mis_r               <= 2'b00;
    else
    begin
      if
      (
        (~dma_fsm_xfer_ & (~|dma_ocp_rd_be_r)) |
        ~dma_ocp_atomic_r |
        ((dma_ocp_bytes_prev == 11'd0) & ~dma_buf_zero_left)
      )
        dma_ocp_base_mis_r             <= dma_ocp_base_mis;
    end
  end








  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_XFERLENGTH_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_xferlength_r             <= {PKTLENGTH_WIDTH{1'b0}};
    else
    begin
      if
      (
        (dma_fsm_nxt != dma_fsm_st_r) |
        (~dma_epptr & dma_ack & dma_re & dma_buf_pkt_start)
      )
        case(dma_fsm_nxt)
          DMA_FSM_WR_DESC,
          DMA_FSM_RD_DESC,
          DMA_FSM_RD_AGAIN,
          DMA_FSM_ADV_PTR :
            dma_ocp_xferlength_r       <= DMA_TRB_LENGTH;
          default :
            if( ~dma_ocp_xferlength_cond[XFERLENGTH_WIDTH] )
              dma_ocp_xferlength_r     <= (dma_buf_pktsize - dma_buf_pktbytes);
            else
              dma_ocp_xferlength_r     <= dma_buf_total_left[PKTLENGTH_WIDTH-1:0];
        endcase
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_BASE_ADDR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_base_addr_r              <= {OCP_ADDR_WIDTH{1'b0}};
    else
    begin
      case(dma_fsm_nxt)
        DMA_FSM_WR_DESC,
        DMA_FSM_RD_AGAIN :
          dma_ocp_base_addr_r          <= dma_buf_prev_ptr_r;

        DMA_FSM_RD_DESC,
        DMA_FSM_ADV_PTR :
          if(dma_ocp_ack_r & dma_fsm_link)
            dma_ocp_base_addr_r        <= dma_buf_ptr_r;
          else if
          (
            (dma_ocp_ack | dma_ocp_ack_r) &
            dma_fsm_normal & dma_fsm_chain & ~dma_fsm_non_zero
          )
            dma_ocp_base_addr_r        <= dma_ocp_addr;
          else
            dma_ocp_base_addr_r        <= dma_buf_desc_ptr_r;

        default :
          if(~dma_ocp_clear_r & dma_do_clear_all_n)
            dma_ocp_base_addr_r        <= dma_buf_ptr_r;
      endcase
    end
  end




  always
  @(
    dma_buf_f_r or
    dma_do_clear_all_n or
    dma_fsm_rd_desc_ or
    dma_fsm_rd_ocp_ or
    dma_fsm_wr_desc_ or
    dma_fsm_wr_ocp_ or
    dma_ocp_base_addr_r or
    dma_ocp_bytes_nxt or
    dma_ocp_bytes_r or
    dma_ocp_clear_r or
    dma_ocp_scmdaccept
  )
  begin : DMA_OCP_ADDR_COMB_PROC
    if((dma_fsm_wr_ocp_ | dma_fsm_rd_ocp_) & dma_buf_f_r)
      dma_ocp_addr                     = dma_ocp_base_addr_r;
    else if
    (
      dma_ocp_scmdaccept &
      (
       dma_fsm_wr_ocp_ | dma_fsm_wr_desc_ |
       dma_fsm_rd_ocp_ | dma_fsm_rd_desc_ |
       ~dma_do_clear_all_n  | dma_ocp_clear_r
      )
    )
      dma_ocp_addr                     = dma_ocp_base_addr_r + dma_ocp_bytes_nxt;
    else
      dma_ocp_addr                     = dma_ocp_base_addr_r + dma_ocp_bytes_r;
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_ATOMIC_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_atomic_r                 <= 1'b0;
    else
    begin
      if
      (
        (dma_fsm_nxt != dma_fsm_st_r) |
        (~dma_epptr & dma_ack & dma_re & dma_buf_pkt_start)
      )
        case(dma_fsm_nxt)
          DMA_FSM_WR_DESC,
          DMA_FSM_RD_DESC,
          DMA_FSM_RD_AGAIN,
          DMA_FSM_ADV_PTR :
            dma_ocp_atomic_r           <= 1'b0;
          default :
            if(dma_buf_part_left > {7'd0, dma_buf_pktsize})
              dma_ocp_atomic_r         <= (dma_buf_pktsize - dma_buf_pktbytes) < 11'd5;
            else
              dma_ocp_atomic_r         <= dma_buf_total_left < 18'd5;
        endcase
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_WR_DESC_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_wr_desc_r                <= 1'b0;
    else
    begin
      if(dma_fsm_wr_desc_ & dma_ack)
        dma_ocp_wr_desc_r              <= 1'b1;
      else if(~dma_fsm_wr_desc_)
        dma_ocp_wr_desc_r              <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_OCP_RESP_DVA_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ocp_resp_dva_r               <= 1'b0;
    else
      dma_ocp_resp_dva_r               <= dma_ocp_resp_dva;
  end




  assign dma_ocp_left_nxt        = dma_ocp_xferlength_r - dma_ocp_bytes_nxt;
  assign dma_ocp_zero_left       = (dma_ocp_xferlength_r == dma_ocp_bytes_r);
  assign dma_ocp_zero_left_nxt   = (dma_ocp_left_nxt == 11'd0);
  assign dma_ocp_xferlength_cond = dma_buf_part_left - {7'd0, dma_buf_pktsize};
  assign dma_ocp_ack             =
    (
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
        dma_fifo_empty &
      `endif
      ((dma_fsm_rd_desc_ & (dma_ocp_mcmd_m_r == OCP_CMD_IDLE)) | (dma_fsm_rd_ocp_ & ({dma_pktaddr, 2'd0} >= dma_buf_pktbytes_nxt) ) ) &
      (dma_ocp_cmd_acc_r == 2'd0) & dma_ocp_zero_left
    ) |
    (
      (dma_fsm_wr_desc_ | dma_fsm_wr_ocp_) &
      (
        (dma_ocp_scmdaccept & dma_ocp_zero_left_nxt) |
        (
          (
            `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
              dma_buf_stid_err_r |
            `endif
            (dma_buf_pktsize == {PKTLENGTH_WIDTH{1'b0}})
          ) & ~dma_buf_pkt_start
        )
      )
    );

  `ifdef CDNSUSBHS_SUPPORT_MISALIGNED_ADDRESSES
    assign dma_ocp_base_mis      = dma_ocp_base_addr_r[1:0];
  `else
    assign dma_ocp_base_mis      = 2'd0;
  `endif




  always @(dma_ocp_bytes_r or dma_ocp_prev_be_r)
  begin : DMA_OCP_BYTES_PREV_COMB_PROC
    case(dma_ocp_prev_be_r)
      OCP_BE_1111:
        dma_ocp_bytes_prev       = dma_ocp_bytes_r + 11'd4;
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
        OCP_BE_1100,
      `endif
      OCP_BE_0011:
        dma_ocp_bytes_prev       = dma_ocp_bytes_r + 11'd2;
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
        OCP_BE_1000,
        OCP_BE_0010,
      `endif
      OCP_BE_0100,
      OCP_BE_0001:
        dma_ocp_bytes_prev       = dma_ocp_bytes_r + 11'd1;
      default:
        dma_ocp_bytes_prev       = dma_ocp_bytes_r;
    endcase
  end




  always @(dma_ocp_bytes_r or dma_ocp_be_r)
  begin : DMA_OCP_BYTES_NXT_COMB_PROC
    case(dma_ocp_be_r)
      OCP_BE_1111:
        dma_ocp_bytes_nxt        = dma_ocp_bytes_r + 11'd4;
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
        OCP_BE_1100,
      `endif
      OCP_BE_0011:
        dma_ocp_bytes_nxt        = dma_ocp_bytes_r + 11'd2;
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
        OCP_BE_1000,
        OCP_BE_0010,
      `endif
      OCP_BE_0100,
      OCP_BE_0001:
        dma_ocp_bytes_nxt        = dma_ocp_bytes_r + 11'd1;
      default:
        dma_ocp_bytes_nxt        = dma_ocp_bytes_r;
    endcase
  end

  assign dma_ocp_resp_dva        = (sresp_m == OCP_RESP_DVA) & (dma_ocp_cmd_acc_r != 2'd0);
  assign dma_ocp_xfer_step       =
    (
      (
        (
          (~dma_ocp_atomic_r & (dma_ocp_bytes_r == {PKTLENGTH_WIDTH{1'b0}})) |
          (dma_ocp_bytes_prev == {PKTLENGTH_WIDTH{1'b0}})
        ) &
        (~|dma_ocp_be_r) &
        (~dma_fsm_xfer_ | (dma_buf_pktsize_r > dma_buf_pktbytes_r))
      ) |
      dma_ocp_scmdaccept
    );
  assign dma_ocp_next_re         = ((dma_ocp_be_r == 4'h0) | (dma_ocp_scmdaccept & (dma_ocp_be_r != 4'h2)));
  assign dma_ocp_hold_n          = ((dma_ocp_hold_r | (dma_ocp_mcmd_m_r != OCP_CMD_IDLE)) & ~dma_ocp_scmdaccept);
  assign dma_ocp_clear           = (dma_ocp_clear_r & ~(dma_ocp_scmdaccept & mreqlast_m));
  assign dma_ocp_scmdaccept      = scmdaccept_m & (dma_ocp_mcmd_m_r != OCP_CMD_IDLE);




  assign dma_do_clear_all_n      = ~dma_do_cfgrst;




  assign dma_we_ok               =
    (
      dma_fsm_store_ | dma_fsm_wr_ptr_ |
      (dma_fsm_rd_ocp_ & (dma_in_overhead | dma_in_overhead_r) & dma_in_overhead_ack)
    );




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_IN_OVERHEAD_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_in_overhead_r                <= 1'b0;
    else
    begin
      if(dma_in_overhead & ~dma_in_overhead_ack)
        dma_in_overhead_r              <= 1'b1;
      else if(dma_in_overhead_ack)
        dma_in_overhead_r              <= 1'b0;
    end
  end

  assign dma_in_overhead_ack     = (dma_ack | (|dma_ack_prev_r) | dma_fsm_rd_desc_);
  assign dma_re_ok               =
    (
      dma_fsm_wr_ocp_ & dma_ocp_next_re &
      ((dma_buf_pktsize_r == 11'd0) | ~dma_buf_pkt_cmpl) &
      (dma_buf_pktbytes_r != dma_buf_maxpktsize_r)
    );





  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_RE_QUEUE_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_re_queue_r                   <= 1'b0;
    else
    begin
      if(dma_re)
        dma_re_queue_r                 <= 1'b0;
      else if(dma_re_ok & ~dma_ack)
        dma_re_queue_r                 <= 1'b1;
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_ISP_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_isp_r                        <= 1'b0;
    else
    begin
      if(dma_last)
      begin
        if(dma_fsm_sp & dma_buf_isp_r)
          dma_isp_r                    <= 1'b1;
        else
          dma_isp_r                    <= 1'b0;
      end
    end
  end




  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_ACK_PREV_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ack_prev_r                   <= 2'b00;
    else
    begin
      if(dma_we_ok | dma_fsm_wr_ocp_ | dma_buf_pkt_start)
      begin
        dma_ack_prev_r[0]              <= dma_ack;
        dma_ack_prev_r[1]              <= dma_ack_prev_r[0];
      end
    end
  end

`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_ACK_PREV1_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_ack_prev_r1                   <= 1'b0;
    else
    begin
      if(dma_we_ok | dma_buf_pkt_start |
         (
          (dma_fsm_wr_ocp_ | dma_fsm_wr_desc_) & dma_ocp_next_re &
          (dma_ack | dma_ack_prev_r[0] | ((dma_ocp_left_nxt < 11'd5) & (dma_ocp_mcmd_m_r != OCP_CMD_IDLE)))
         ))
      begin
        dma_ack_prev_r1                 <= dma_ack;
      end
    end
  end
`endif







  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_PKTADDR_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_pktaddr_r                    <= {PKTADDR_WIDTH{1'b0}};
    else
    begin
      if
      (
        ((dma_fsm_rd_desc_ & ~dma_fsm_adv_desc_) | dma_fsm_rel_buf_) |
        (dma_fsm_restore_ & dma_ack & dma_fsm_addr_dat & dma_buf_zero_left & dma_buf_ch_r)
      )
        dma_pktaddr_r                  <= {PKTADDR_WIDTH{1'b0}};
      else if
      (
        (dma_fsm_wr_ocp_ & dma_re & dma_ack & (~dma_buf_pkt_cmpl | dma_buf_pkt_start)) |
        (dma_fsm_rd_ocp_ & dma_we)
      )
        dma_pktaddr_r                  <= dma_pktaddr_nxt;
    end
  end




  assign dma_pktaddr_nxt  = dma_pktaddr_r + 1'b1;
  assign dma_out_overhead =
    (
      (({dma_pktaddr_r, 2'd0} - dma_ocp_bytes_r) >= 11'd1) &
      ({dma_pktaddr_r, 2'd0} >= dma_ocp_bytes_nxt)
    );
  assign dma_in_overhead  =
    (
      (
        dma_ocp_resp_dva_r
        `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
          |
          (
            (dma_ocp_rd_bytes_r == dma_ocp_xferlength_r) &
            ((dma_buf_pktbytes_r + dma_ocp_rd_bytes_r) > {dma_pktaddr_r, 2'd0})
          )
        `endif
      ) &
      (
        ((dma_buf_pktbytes_r + dma_ocp_rd_bytes_r) >= {dma_pktaddr_nxt, 2'd0}) |
        ((dma_ocp_cmd_acc_r == 2'd0) & dma_ocp_zero_left)
      )
    );








`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : DMA_MIS_BUF_PROC
    if `CDNSUSBHS_RESET(rst_n)
      dma_mis_buf_r                    <= {(DATA_WIDTH-8){1'b0}};
    else
    begin
      if((dma_fsm_rd_ocp_ | dma_fsm_rd_desc_) & dma_ocp_resp_dva)
      begin
        dma_mis_buf_r                  <= dma_buf_data_r[DATA_WIDTH-1:8];
      end
      else if
      (
        (dma_fsm_wr_ocp_ | dma_fsm_wr_desc_) & dma_ocp_next_re &
        (dma_ack | dma_ack_prev_r1 | ((dma_ocp_left_nxt < 11'd5) & (dma_ocp_mcmd_m_r != OCP_CMD_IDLE)))
      )
      begin
        if(dma_end_type)
          dma_mis_buf_r                <= dma_buf_data_r[DATA_WIDTH-9:0];
        else
          dma_mis_buf_r                <= dma_buf_data_r[DATA_WIDTH-1:8];
      end
    end
  end
`endif































  always
  @(
    dma_buf_pktbytes_nxt or
    dma_end_type or
    dma_fsm_wr_desc_ or
    dma_fsm_wr_ocp_ or
    dma_ocp_atomic_r or
    dma_ocp_cmd_acc_r or
    dma_ocp_zero_left or
    dma_pktaddr or
    dma_buf_data_r or
`ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
    dma_mis_buf_r or
`endif
    dma_ocp_base_mis_r
  )
  begin : DMA_MIS_OUT_COMB_PROC
    dma_mis_out = dma_buf_data_r;
    if(dma_fsm_wr_ocp_ | dma_fsm_wr_desc_)
    begin
      if(dma_end_type)
      begin
        case(dma_ocp_base_mis_r)
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
            2'd3:
              dma_mis_out =
                {
                  dma_buf_data_r[31:24],
                  dma_mis_buf_r [07:00],
                  dma_mis_buf_r [15:08],
                  dma_mis_buf_r [23:16]
                };

            2'd2:
              dma_mis_out =
                {
                  dma_buf_data_r[23:16],
                  dma_buf_data_r[31:24],
                  dma_mis_buf_r [07:00],
                  dma_mis_buf_r [15:08]
                };

            2'd1:
              dma_mis_out =
                {
                  dma_buf_data_r[15:08],
                  dma_buf_data_r[23:16],
                  dma_buf_data_r[31:24],
                  dma_mis_buf_r [07:00]
                };
          `endif

          default:
            dma_mis_out   =
              {
                dma_buf_data_r[07:00],
                dma_buf_data_r[15:08],
                dma_buf_data_r[23:16],
                dma_buf_data_r[31:24]
              };
        endcase
      end
      else
      begin
        case(dma_ocp_base_mis_r)
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
            2'd3:
              dma_mis_out =
                {
                  dma_buf_data_r[07:00],
                  dma_mis_buf_r [23:00]
                };

            2'd2:
              dma_mis_out =
                {
                  dma_buf_data_r[15:00],
                  dma_mis_buf_r [23:08]
                };

            2'd1:
              dma_mis_out =
                {
                  dma_buf_data_r[23:00],
                  dma_mis_buf_r [23:16]
                };
          `endif
          default:
            dma_mis_out   = dma_buf_data_r;
        endcase
      end
    end
    else
    begin
      if(dma_end_type)
      begin
        case(dma_ocp_base_mis_r)
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
            2'd3:
              dma_mis_out =
                {
                  dma_mis_buf_r [23:16],
                  dma_buf_data_r[07:00],
                  dma_buf_data_r[15:08],
                  dma_buf_data_r[23:16]
                };

            2'd2:
              dma_mis_out =
                {
                  dma_mis_buf_r [15:08],
                  dma_mis_buf_r [23:16],
                  dma_buf_data_r[07:00],
                  dma_buf_data_r[15:08]
                };

            2'd1:
              dma_mis_out =
                {
                  dma_mis_buf_r [07:00],
                  dma_mis_buf_r [15:08],
                  dma_mis_buf_r [23:16],
                  dma_buf_data_r[07:00]
                };
          `endif
          default:
            dma_mis_out   =
              {
                dma_buf_data_r[07:00],
                dma_buf_data_r[15:08],
                dma_buf_data_r[23:16],
                dma_buf_data_r[31:24]
              };
        endcase
      end
      else
      begin
        if
        (
          dma_ocp_atomic_r |
          (
            (dma_ocp_cmd_acc_r == 2'd0) & dma_ocp_zero_left &
            (dma_buf_pktbytes_nxt[PKTLENGTH_WIDTH-1:2] == dma_pktaddr)
          )
        )
          case(dma_ocp_base_mis_r)
            `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
              2'd3:
                dma_mis_out =
                  {
                    dma_buf_data_r[23:00],
                    dma_buf_data_r[31:24]
                  };

              2'd2:
                dma_mis_out =
                  {
                    dma_buf_data_r[15:00],
                    dma_buf_data_r[31:16]
                  };

              2'd1:
                dma_mis_out =
                  {
                    dma_buf_data_r[07:00],
                    dma_buf_data_r[31:08]
                  };
            `endif
            default:
              dma_mis_out = dma_buf_data_r;
          endcase
        else
          case(dma_ocp_base_mis_r)
            `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
              2'd3:
                dma_mis_out =
                  {
                    dma_buf_data_r[23:00],
                    dma_mis_buf_r [23:16]
                  };

              2'd2:
                dma_mis_out =
                  {
                    dma_buf_data_r[15:00],
                    dma_mis_buf_r [23:08]
                  };

              2'd1:
                dma_mis_out =
                  {
                    dma_buf_data_r[07:00],
                    dma_mis_buf_r [23:00]
                  };
            `endif
            default:
              dma_mis_out = dma_buf_data_r;
          endcase
      end
    end
  end

  `ifdef CDNSUSBHS_SUPPORT_ENDIANESS_CONV
    assign dma_end_type   =
      (
        (dma_fsm_wr_ocp_ | dma_fsm_rd_ocp_)
          ? dma_buf_data_end_r :

          1'b0
      );
  `else
    assign dma_end_type   = 1'b0;
  `endif

`ifdef CDNSUSBHS_IMPLEMENT_DMA_FIFO






    `CDNSUSBHS_ALWAYS(clk,rst_n)
    begin : DMA_FIFO_CNT_PROC
      if `CDNSUSBHS_RESET(rst_n)
        dma_fifo_cnt_r                 <= 2'd0;
      else if(dma_fsm_rd_ocp_)
      begin
        if(~dma_fifo_full & (dma_fifo_step | dma_fifo_p_r) & ~dma_we)
          dma_fifo_cnt_r               <= dma_fifo_cnt_r + 2'd1;
        else if(~dma_fifo_empty & dma_we & ~dma_fifo_step & ~dma_fifo_p_r)
          dma_fifo_cnt_r               <= dma_fifo_cnt_r - 2'd1;
      end
      else
        dma_fifo_cnt_r                 <= 2'd0;
    end




    `CDNSUSBHS_ALWAYS(clk,rst_n)
    begin : DMA_FIFO_P_PROC
      if `CDNSUSBHS_RESET(rst_n)
        dma_fifo_p_r                   <= 1'b0;
      else
      begin
        if(~dma_we & dma_fifo_full & dma_fifo_step)
          dma_fifo_p_r                 <= 1'b1;
        else if(dma_we)
          dma_fifo_p_r                 <= 1'b0;
      end
    end

`ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA



    `CDNSUSBHS_ALWAYS(clk,rst_n)
    begin : DMA_FIFO_RD_PROC
      if `CDNSUSBHS_RESET(rst_n)
        dma_fifo_rd_r                  <= 2'd0;
      else
      begin
        if((dma_fsm_rd_ocp_ | (dma_fsm_st_r == DMA_FSM_DELAY)) & dma_we)
        begin
          if(dma_fifo_rd_r == 2'd2)
            dma_fifo_rd_r              <= 2'd0;
          else
            dma_fifo_rd_r              <= dma_fifo_rd_r + 2'd1;
        end
      end
    end
`endif

`ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA



    `CDNSUSBHS_ALWAYS(clk,rst_n)
    begin : DMA_FIF0_PROC
      if `CDNSUSBHS_RESET(rst_n)
      begin
        dma_fifo0_r                    <= {DATA_WIDTH{1'b0}};
        dma_fifo1_r                    <= {DATA_WIDTH{1'b0}};
        dma_fifo2_r                    <= {DATA_WIDTH{1'b0}};
        dma_fifo_wr_r                  <= 2'b00;
      end
      else if(dma_fsm_rd_ocp_ & ((dma_fifo_step | dma_fifo_p_r) & (~dma_fifo_full | dma_we)))
      begin
        case(dma_fifo_wr_r)
          2'b00:   dma_fifo0_r         <= dma_mis_out;
          2'b01:   dma_fifo1_r         <= dma_mis_out;
          default: dma_fifo2_r         <= dma_mis_out;
        endcase
        begin
          if(dma_fifo_wr_r == 2'd2)
            dma_fifo_wr_r              <= 2'd0;
          else
            dma_fifo_wr_r              <= dma_fifo_wr_r + 2'd1;
        end
      end
    end
`endif

`ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA



    always
    @(
      dma_fifo0_r or
      dma_fifo1_r or
      dma_fifo2_r or
      dma_fifo_rd_r
    )
    begin : DMA_FIFO_COMB_PROC
      case(dma_fifo_rd_r)
        2'd0:    dma_fifo              = dma_fifo0_r;
        2'd1:    dma_fifo              = dma_fifo1_r;
        default: dma_fifo              = dma_fifo2_r;
      endcase
    end
`endif

    assign dma_fifo_empty = (dma_fifo_cnt_r == 2'd0);
    assign dma_fifo_full  = (dma_fifo_cnt_r == 2'd3);
    assign dma_fifo_step  =
      dma_in_overhead &
      (
        (dma_ocp_xferlength_r[1:0] != 2'd3) |
        (dma_ocp_rd_bytes_r[PKTLENGTH_WIDTH-1:2] != dma_ocp_xferlength_r[PKTLENGTH_WIDTH-1:2]) |
        (dma_ocp_rd_bytes_r[1] == dma_ocp_rd_bytes_r[0])
      );
`endif





  assign dma_trb = dma_fsm_rd_desc_ | dma_fsm_wr_desc_;







  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : MBURSTSEQ_PROC
    if `CDNSUSBHS_RESET(rst_n)
      mburstseq_m                      <= OCP_BURST_INCR;
    else
    begin
      if(dma_fsm_xfer_)
      begin
        if(dma_buf_f_r)
          mburstseq_m                  <= OCP_BURST_STRM;
        else
          mburstseq_m                  <= OCP_BURST_INCR;
      end
      else
        mburstseq_m                    <= OCP_BURST_INCR;
    end
  end

  assign mbyteen_m        = dma_ocp_be_r;
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
  assign mburstlength_m   = dma_ocp_mburstlength_r;
`else
  assign mburstlength_m   = {6'd0, dma_ocp_mburstlength_r};
`endif
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
  `CDNSUSBHS_ALWAYS(clk,rst_n)
  begin : MBURSTPRECISE_PROC
    if `CDNSUSBHS_RESET(rst_n)
      mburstprecise_m                  <= 1'b0;
    else
      mburstprecise_m                  <= dma_fsm_xfer_ & (dma_buf_burstlength_r != 8'd0);
  end
`else
  assign mburstprecise_m  = 1'b0;
`endif
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
  assign mreqlast_m       = (dma_ocp_burst_cnt_r == 8'd1);
`else
  assign mreqlast_m       = mburstlength_m[0];
`endif




  assign dma_do_busy      = (dma_fsm_st_r != DMA_FSM_IDLE) & (dma_fsm_nxt != DMA_FSM_IDLE);
  assign dma_do_done      = dma_do & (dma_fsm_st_r == DMA_FSM_IDLE);







  always
  @(
    dma_fsm_cnt_r or
    dma_fsm_st_r or
    dma_pktaddr_r
  )
  begin : DMA_PKTADDR_COMB_PROC
    case(dma_fsm_st_r)
      DMA_FSM_WR_PTR,
      DMA_FSM_RESTORE,
      DMA_FSM_RD_PTR,
      DMA_FSM_RD_MAX,
      DMA_FSM_STORE:
        dma_pktaddr       = {{(PKTADDR_WIDTH-3){1'b0}}, dma_fsm_cnt_r};

      default:
        dma_pktaddr       = dma_pktaddr_r;
    endcase
  end

  `ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
    assign dma_dataw_in   = dma_fifo;
  `else
    assign dma_dataw_in   = dma_mis_out;
  `endif




  always
  @(
`ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
    dma_buf_burstlength_r or
`endif
    dma_buf_bytes_r or
    dma_buf_ch_r or
    dma_buf_deq_ptr_r or
    dma_buf_desc_ptr_r or
    dma_buf_f_r or
    dma_buf_ioc_r or
    dma_buf_isp_r or
    dma_buf_length_r or
    dma_buf_prev_ptr_r or
    dma_buf_ptr_r or
    dma_buf_stid_r or
    dma_dataw_in or
    dma_fsm_cnt_r or
    dma_fsm_st_r or
    dma_fsm_trb_r
  )
  begin : DMA_DATAW_COMB_PROC
    case(dma_fsm_st_r)
      DMA_FSM_WR_PTR,
      DMA_FSM_STORE :
        case(dma_fsm_cnt_r)
          DMA_ADDR_BYTES :
            dma_dataw     =
              {
                dma_buf_stid_r[15:8],
                dma_buf_ch_r,
                dma_buf_isp_r,
                dma_buf_ioc_r,
                dma_buf_f_r,
                `ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
                  dma_buf_burstlength_r[7],
                  {2{1'b0}},
                `else
                  {3{1'b0}},
                `endif
                dma_buf_bytes_r
              };

          DMA_ADDR_LENGTH :
            dma_dataw     =
              {
                dma_buf_stid_r[7:0],
                `ifdef CDNSUSBHS_IMPLEMENT_DMA_PRECISE_BURSTS
                  dma_buf_burstlength_r[6:0],
                `else
                  {7{1'b0}},
                `endif
                dma_buf_length_r
              };

          DMA_ADDR_DESC_PTR :
            dma_dataw     = dma_buf_desc_ptr_r;

          DMA_ADDR_DATA_PTR :
            dma_dataw     = dma_buf_ptr_r;

          default :
            if(dma_fsm_st_r == DMA_FSM_WR_PTR)
            begin
              if(dma_fsm_trb_r)
                dma_dataw = dma_buf_desc_ptr_r;
              else
                dma_dataw = dma_buf_prev_ptr_r;
            end
            else
              dma_dataw   = dma_buf_deq_ptr_r;
        endcase

      default :
        dma_dataw         = dma_dataw_in;
    endcase
  end

  assign dma_epsts        = dma_fsm_ep_st;
  assign dma_epccs        = dma_buf_tc;
  assign dma_epnum        = dma_buf_epnum_r;
  assign dma_epdir        = dma_buf_epdir_r;
  assign dma_epptr        =
    (
      dma_fsm_restore_ |
      dma_fsm_store_ |
      dma_fsm_rd_ptr_ |
      dma_fsm_wr_ptr_ |
      dma_fsm_rd_max_ |
      dma_fsm_rd_again_ |
      dma_fsm_wr_desc_
    );
  assign dma_pktsize_in   = dma_buf_pktbytes_r;

  assign dma_last         = dma_fsm_rel_buf_;
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
    assign dma_we         = (dma_fsm_store_ | dma_fsm_wr_ptr_ | (~dma_fifo_empty & dma_in_overhead_ack));
  `else
    assign dma_we         = dma_we_ok;
  `endif
  assign dma_re           =
    (
      dma_fsm_rd_conf_r |
      (dma_ack & (dma_re_ok | dma_re_queue_r)) |
      (dma_fsm_zero_ & ~dma_epdir)
    );
  assign dma_re_data           =
    (

      (
        (dma_re_ok | dma_re_queue_r))

    );
  `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
    assign dma_abort      = dma_fsm_rel_buf_ & dma_buf_stid_err_r;
    assign dma_error_stid = ~dma_trb_abort & dma_int_sync & dma_buf_stid_err_r;
  `endif
  assign dma_int_sync     = dma_fsm_mult_ | ((dma_fsm_store_ | dma_fsm_wr_ptr_) & dma_fsm_addr_deq);
  assign dma_error_outsmm =
    (
      dma_int_sync &
      `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
        ~dma_buf_stid_err_r &
      `endif
      (dma_fsm_usp_r | dma_fsm_smm_r)
    );
  assign dma_error_trb    = ((dma_fsm_st_r == DMA_FSM_RD_DESC) & dma_ocp_ack_r & dma_fsm_trb_error) |
    (dma_int_sync & ~dma_fsm_trb_r & dma_fsm_trb_check_r);
  assign dma_trb_abort    = (dma_do & (dma_do_cmd == DMA_CMD_ABORT) & (dma_do_epdir == dma_buf_epdir_r) & (dma_do_epnum == dma_buf_epnum_r));
  assign dma_isp          = ~dma_trb_abort & dma_int_sync & dma_isp_r & ~dma_error_trb;
  assign dma_ioc          = ~dma_trb_abort & dma_int_sync & dma_buf_ioc_r & dma_buf_zero_left & ~dma_error_trb;

  `ifdef CDNSUSBHS_IMPLEMENT_DEBUG
      wire [31:0] debug_ocp_0;
      assign debug_ocp_0 = {dma_ocp_mcmd_m_r, scmdaccept_m, 1'b0, sresp_m, mbyteen_m, mburstlength_m, mburstprecise_m};
      wire [31:0] debug_ocp_1;
      assign debug_ocp_1 = { dma_ocp_be_nxt, dma_ocp_prev_be_r, dma_ocp_rd_be_r, dma_ocp_resp_dva_r, dma_ocp_atomic_r, dma_ocp_wr_desc_r, dma_ocp_hold_r, dma_ocp_hold_n, dma_ocp_reqlast_r, dma_ocp_clear_r, dma_ocp_clear};
      wire [31:0] debug_ocp_2;
      assign debug_ocp_2 =
        {
          dma_ocp_ack, dma_ocp_ack_r, dma_ocp_ack_hold_r, dma_ocp_cmd_acc_r, dma_ocp_cmd_limit, dma_ocp_fst_r, dma_ocp_rd_be_fifo_ptr,
            `ifdef CDNSUSBHS_IMPLEMENT_DMA_OCP
            dma_ocp_rd_be_fifo_0_r, dma_ocp_rd_be_fifo_1_r, dma_ocp_rd_be_fifo_out, dma_ocp_rd_be_decode, 1'b0, dma_ocp_base_mis, 1'b0, dma_ocp_base_mis_r,
            `else
            dma_ocp_rd_be_fifo_0_r, 2'd0, dma_ocp_rd_be_fifo_out, dma_ocp_rd_be_decode, 1'b0, dma_ocp_base_mis, 1'b0, dma_ocp_base_mis_r,
            `endif
          dma_ocp_xferlength_cond[XFERLENGTH_WIDTH]
        };
      wire [31:0] debug_ocp_3;
      assign debug_ocp_3 = {dma_ocp_bytes_r, dma_ocp_rd_bytes_r};
      wire [31:0] debug_ocp_4;
      assign debug_ocp_4 = {dma_ocp_zero_left, dma_ocp_zero_left_nxt, dma_ocp_xfer_step, dma_ocp_next_re, dma_ocp_resp_dva, dma_ocp_xferlength_r, dma_ocp_left_nxt};
      wire [31:0] debug_do;

      assign debug_do = {dma_do, dma_do_cmd, dma_do_busy, dma_do_done, 1'b1, dma_do_clear_all_n, dma_do_epdir, dma_do_epnum, dma_do_data_endianess, 1'b0, dma_do_mult, dma_do_cfgrst, dma_buf_stid_r};
      wire [31:0] debug_ep;
      assign debug_ep = {dma_we, dma_re, dma_ack, dma_last, dma_epdir, dma_epnum, dma_epptr, dma_pktsize_in, dma_pktsize_out};
      wire [31:0] debug_misc_0;
      assign debug_misc_0 =
        {
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
            dma_stid_out, dma_abort, dma_error_stid,
           `endif
           dma_int_sync, dma_error_outsmm, dma_error_trb, dma_isp, dma_ioc
        };
      wire [31:0] debug_misc_1;
      assign debug_misc_1 =
        {
          dma_trb_abort, dma_we_ok, dma_re_ok, dma_re_queue_r, dma_isp_r, dma_out_overhead, dma_in_overhead, dma_in_overhead_r, dma_in_overhead_ack,
            dma_ack_prev_r, dma_pktaddr_r, dma_pktaddr_nxt
        };
      wire [31:0] debug_fsm;
      assign  debug_fsm =
        {
              dma_fsm_cnt_r, dma_fsm_addr_byt, dma_fsm_addr_len, dma_fsm_addr_des, dma_fsm_addr_dat, dma_fsm_addr_deq, dma_fsm_addr_max,
          dma_fsm_own, dma_fsm_trb_r, dma_fsm_trb_check_r, dma_fsm_trb_error, dma_fsm_rd_conf_r, dma_fsm_non_zero, dma_fsm_link, dma_fsm_normal, dma_fsm_chain, dma_fsm_max, dma_fsm_sp, dma_fsm_usp, dma_fsm_usp_r, dma_fsm_smm, dma_fsm_smm_r, dma_fsm_st_r
        };
      wire [31:0] debug_buf_0;
      assign debug_buf_0 =
        {
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_SID_CHECK
            dma_buf_stid_err_r,
          `endif
          dma_buf_mult_r, dma_buf_abort_r, dma_buf_iso_r, dma_buf_maxpktsize_r, dma_buf_tdtype_r, dma_buf_ioc_r, dma_buf_f_r, dma_buf_ch_r, dma_buf_isp_r, dma_buf_c_r, dma_buf_zero_left, dma_buf_pkt_start, dma_buf_pkt_cmpl
        };
      wire [31:0] debug_buf_1;
      assign debug_buf_1 = {dma_buf_pktsize_r, dma_buf_xferlength_r};
      wire [31:0] debug_buf_2;
      assign debug_buf_2 = {dma_buf_pktbytes_r, dma_buf_bytes_r};
      wire [31:0] debug_buf_3;
      assign debug_buf_3 = dma_buf_length_r;
      wire [31:0] debug_buf_4;
      assign debug_buf_4 = dma_buf_part_left;
      wire [31:0] debug_buf_5;
      assign debug_buf_5 = dma_buf_total_left;
      wire [31:0] debug_fifo;
      assign debug_fifo =
        {
          `ifdef CDNSUSBHS_IMPLEMENT_DMA_FIFO
            `ifdef CDNSUSBHS_IMPLEMENT_DMA_AMBA
            dma_fifo_cnt_r, dma_fifo_p_r, dma_fifo_rd_r, dma_fifo_wr_r, dma_fifo_empty, dma_fifo_full, dma_fifo_step,
            `else
            dma_fifo_cnt_r, dma_fifo_p_r, 2'b00,         2'b00,         dma_fifo_empty, dma_fifo_full, dma_fifo_step,
            `endif
          `endif
          1'b0
        };
      assign debug_dma =
        {
            32'd0,
          mdata_m[31:0],
            32'd0,
          sdata_m[31:0],
          debug_ocp_0,
          debug_ocp_1,
          debug_ocp_2,
          debug_ocp_3,
          debug_ocp_4,
          maddr_m,
          debug_do,
          dma_epsts,
          dma_epccs,
          debug_ep,
          debug_misc_0,
          debug_misc_1,
          debug_fsm,
          debug_fifo,
          debug_buf_0,
          debug_buf_1,
          debug_buf_2,
          debug_buf_3,
          debug_buf_4,
          debug_buf_5,
          dma_buf_ptr_r,
          dma_buf_desc_ptr_r,
          dma_buf_prev_ptr_r,
          dma_buf_deq_ptr_r,
          32'd0,
          32'd0,
          32'd0,
          32'd0
        };
  `endif
endmodule


