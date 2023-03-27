//------------------------------------------------------------------------------
// Copyright (c) 2006-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_axi_fe_tx.v
//   Module Name:        edma_pbuf_axi_fe_tx
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description       :  AXI front end driver for TX
//
//------------------------------------------------------------------------------


module edma_pbuf_axi_fe_tx #(

  parameter p_edma_lso      = 1'b0,
  parameter p_num_queues    = 32'd1,
  parameter p_num_queues_m1 = p_num_queues - 32'd1,

  // The following parameter defines the number of bits used to describe
  // the depth of the FIFO that is needed to keep track of the number
  // of aw or ar accesses being triggered before the accompanying data busses
  parameter p_axi_access_pipeline_bits    = 4'd2,
  parameter p_axi_access_pipeline_depth   = 2**p_axi_access_pipeline_bits,

  parameter p_axi_tx_descr_rd_buff_bits   = 4'd2,
  parameter p_axi_tx_descr_rd_buff_depth  = 2**p_axi_tx_descr_rd_buff_bits,

  parameter p_axi_tx_descr_wr_buff_bits   = 4'd2,
  parameter p_axi_tx_descr_wr_buff_depth  = 2**p_axi_tx_descr_wr_buff_bits,

  parameter p_edma_tx_pbuf_addr = 32'd64,
  parameter p_edma_bus_width    = 32'd64,
  parameter p_edma_bus_pwid     = p_edma_bus_width/8,
  parameter p_edma_addr_width   = 32'd64,
  parameter p_edma_tx_pbuf_data = 32'd64,
  parameter p_edma_tsu          = 1'b1,

  // ASF - parameter for TX datapath protection
  parameter p_edma_asf_dap_prot = 1'b0

) (

  input                         aclk,
  input                         n_areset,

  // Constants
  input       [(p_edma_tx_pbuf_addr*p_num_queues)-1:0]
                                TX_PBUF_MAX_FILL_LVL,

  output                        cur_descr_rd_valid,   // Next descriptor is available
  input                         cur_descr_rd_rdy,     // This module can consume the descriptor
  output      [96:0]            cur_descr_rd,         // The actual descriptor
  output      [12:0]            cur_descr_rd_par,     // Parity for above
  output      [31:0]            cur_descr_rd_add,     // The memory address where the descriptor is located
  output      [3:0]             cur_descr_rd_add_par, // Parity
  output      [3:0]             cur_descr_rd_queue,   // The queue the traffic belongs to
  output                        buff_stripe_vld,      // Packet data is available
  input                         buff_stripe_rdy,      // This module can consume the data
  output                        buff_stripe_last,     // This is the last stripe of the packet
  output      [127:0]           buff_stripe,          // the actual data
  output      [15:0]            buff_stripe_par,

  // Dedicated interface for TX descriptor writebacks
  // AHB 01 is for discriptor reads only
  input                         tx_descr_wr_vld,
  output  reg                   tx_descr_wr_rdy,
  input       [63:0]            tx_descr_wr_data,
  input       [7:0]             tx_descr_wr_data_par,
  input       [41:0]            tx_descr_wr_ts,       // TX timestamp
  input       [5:0]             tx_descr_wr_ts_par,   // Parity for timestamp
  input       [9:0]             tx_descr_wr_sts,
  output  reg [9:0]             reflected_tx_sts,
  output  reg                   reflected_tx_sts_vld,

  //---------------------------------------------
  // AXI signaling
  // Top level AXI signaling and status from AXI arbiter
  //---------------------------------------------
  input                           rvalid_descr,
  input                           rvalid_data,
  output                          rready_descr,
  output                          rready_data,
  input       [p_edma_bus_width-1:0]
                                  rdata,
  input       [p_edma_bus_pwid-1:0]
                                  rdata_par,
  input       [1:0]               rresp,
  input                           rlast,

  output                          awvalid_descr,
  input                           awready_descr,
  input                           wvalid_descr,
  input                           wready_descr,
  input       [1:0]               bresp,
  input                           bvalid_descr,
  input                           bready_descr,

  output  reg                     arvalid_descr,        // TX descriptor read request
  input                           arready_descr,        // TX descriptor read request AR channel grant
  output      [63:0]              araddr_descr,         // TX descriptor read araddr
  output      [7:0]               araddr_descr_par,     // Parity
  output      [7:0]               arlen_descr,          // TX descriptor read arlen
  output      [2:0]               arsize_descr,         // TX descriptor read arsize

  output  reg                     arvalid_data,         // TX data read request
  input                           arready_data,         // TX descriptor read request AR channel grant
  output  reg [63:0]              araddr_data,          // TX data read araddr
  output      [7:0]               araddr_data_par,      // Parity
  output      [7:0]               arlen_data,           // TX data read arlen
  output      [2:0]               arsize_data,          // TX data read arsize



  output      [63:0]              awaddr_descr,
  output      [7:0]               awaddr_descr_par,
  output  reg [7:0]               awlen_descr,
  output  reg [2:0]               awsize_descr,
  output  reg [127:0]             wdata_descr,
  output  reg [15:0]              wdata_descr_par,
  output      [3:0]               aw_queue_descr,
  output                          wlast_descr,

  // config
  input       [1:0]               dma_bus_width,
  input       [1:0]               endian_swap,
  input       [4:0]               burst_length,
  input       [31:0]              upper_tx_q_base_addr,
  input       [3:0]               upper_tx_q_base_par,
  input                           enable_tx,
  input                           new_tx_q_ptr_pulse,  // New queue pointer written
  input                           trigger_dma_tx_start,
  input                           tx_start_pulse,
  input                           tx_stop_pulse,
  input       [(32*p_num_queues)-1:0]
                                  tx_buff_base_addr,  // tx descriptor list base addresses (list per queue)
  input       [(4*p_num_queues)-1:0]
                                  tx_buff_base_par,
  input                           force_max_ahb_burst_tx,
  input                           tx_extended_bd_mode_en, // enable extended BD mode, which is used to Descriptor TS insertion
  input                           tx_cutthru,
  input       [p_num_queues-1:0]  tx_disable_queue,

  // buffer memory status
  input       [p_num_queues-1:0]  buffer_full_q,
  input       [(p_num_queues-1)*8+7:0]  num_pkts_in_buf,
  input       [(p_edma_tx_pbuf_addr*p_num_queues)-1:0]
                                  dpram_fill_lvl,

  input                           dma_has_seen_err,
  input       [p_edma_tx_pbuf_addr-1:0]
                                  axi_tx_full_adj_0,
  input       [p_edma_tx_pbuf_addr-1:0]
                                  axi_tx_full_adj_1,
  output  reg                     disable_tx,           // identifies a major error


  //---------------------------------------------
  // Common
  //---------------------------------------------

  input       [3:0]               r_num_pad,
  input                           flush_tx_wr_fifos,
  input                           flush_tx_rd_fifos,
  input                           addressing_64b,
  input       [3:0]               r_araddr,

  output      [12:0]              num_tx_beats_remaining,
  output                          ar_tcp_hdr,
  output                          ar_udp_hdr,
  output                          ar_ahb_less_beats,
  output      [3:0]               ar_queue_data,
  output      [3:0]               ar_queue_descr,
  output                          ar_first_req_of_buf,
  output                          ar_last_req_of_buf,

  input                           r_tcp_hdr,
  input                           r_udp_hdr,
  input                           r_ahb_less_beats,
  input       [3:0]               r_queue,
  input                           r_first_burst_of_buf,
  input                           r_last_burst_of_buf,

  output      [(p_num_queues*32)-1:0]
                                  axi_tx_dma_descr_ptr,   // Debug
  output  reg                     axi_tx_dma_descr_ptr_tog,

  output  reg                     frame_too_large,

  // ASF - signals going to gem_reg_top
  output                          asf_dap_axi_tx_err,

  // Lockup detection
  output      [p_num_queues-1:0]  full_pkt_inc,
  output      [p_num_queues-1:0]  used_bit_vec,
  output                          lockup_flush


);


  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // INTERNAL SIGNALS
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------

  // If 64b addressing = 0 and ext bd = 0, then the descriptor is 64bits in size
  // If 64b addressing = 1 and ext bd = 0, then the descriptor is 96bits in size
  // If 64b addressing = 0 and ext bd = 1, then the descriptor is 97bits in size
  // If 64b addressing = 1 and ext bd = 1, then the descriptor is 129bits in size
  localparam p_descr_width   = 32 + p_edma_addr_width + (33 * p_edma_tsu);
  localparam p_descr_pwidth  = (p_descr_width+7)/8;

  // If parity protecting address, then tag parity to address width
  localparam p_awid_par  = (p_edma_asf_dap_prot == 1)  ? 36  : 32;

  // Internal representation of base address array
  wire  [p_awid_par-1:0]                tx_base_addr_arr[15:0];

  reg   [31:0]                          cur_descr_ptr_inc;
  reg    [1:0]                          aw_tx_descr_cnt_r;

  // AXI ready and valid
  wire                                  arrv_descr;
  wire                                  arrv_data;
  wire                                  rrv_descr;
  wire                                  rrv_data;
  wire                                  awrv_descr;
  wire                                  wrv_descr;
  wire                                  brv_descr;

  wire [p_num_queues-1:0]               arrv_data_q;
  wire [p_num_queues-1:0]               rrv_data_q;

  // Ratio of buffer memory width to data bus width
  reg   [1:0]                           tx_fill_lvl_multiplier;

  // Array to de-concatenate multi queue buffer memory fill level input signal
  wire  [p_edma_tx_pbuf_addr+1:0]        dpram_fill_lvl_array [15:0];

  // Array to de-concatenate multi queue buffer memory max fill level input signal
  wire  [p_edma_tx_pbuf_addr+1:0]        TX_PBUF_MAX_FILL_LVL_ARRAY [15:0];

  // Capture tx_stop_pulse until main state machine returns to idle state
  reg                                   stop_tx_asap;
  reg                                   stop_tx_now;

  reg   [4:0]                           descr_rd_pend_cnt; // Number of descriptor requests for which a
                                                           // response has not been received

  reg   [p_awid_par-1:0]                tx_descr_ptr_req [p_num_queues-1:0];
  reg   [p_awid_par-1:0]                tx_descr_ptr_resp [p_num_queues-1:0];
  wire  [p_awid_par-1:0]                tx_descr_ptr_req_pad [15:0];
  wire  [p_awid_par-1:0]                tx_descr_ptr_resp_pad [15:0];
  wire  [35:0]                          ar_tx_descr_ptr_req_inc;
  wire  [35:0]                          cur_tx_descr_ptr_resp_inc;

  reg   [63:0]                          rdata_descr;
  reg   [7:0]                           rdata_descr_par;

  reg   [p_num_queues-1:0]              ignore_remaining_desc_rds;
  wire  [15:0]                          ignore_remaining_desc_rds_pad;

  reg   [p_num_queues-1:0]              first_buffer;
  wire  [15:0]                          first_buffer_pad;

  reg   [128:0]                         db1_in_hold;      // Top bit holds response error
  wire  [15:0]                          db1_in_par_hold;  // Parity for above excludes response error bit
  reg                                   db1_in_used_all_q_was_detected;
  reg                                   db1_in_err_was_detected;
  reg                                   db1_in_wrap_was_detected;
  reg                                   db1_in_used_was_detected;
  reg                                   db1_in_last_bit;
  reg                                   db1_in_used_bit;
  reg                                   db1_in_wrap_bit;
  reg  [p_num_queues-1:0]               db1_in_used_bits_read;
  wire [15:0]                           db1_in_used_bits_read_pad;
  reg                                   tx_start_pending;

  wire                                  db1_in_used_all_q;
  wire                                  db1_in_zero_len_buff_err;
  wire                                  db1_in_used_buff_err;
  wire                                  db1_in_buff_err;
  // Primary descriptor buffer input
  // Single input as only one buffer can be pushed by
  // an AXI descriptor fetch at a time
  reg   [128:0]                         db1_in_129;
  reg   [16:0]                          db1_in_129_par; // Includes top bit (launch time enable)
  wire  [p_descr_width-1:0]             db1_in;
  wire  [p_descr_pwidth-1:0]            db1_in_par;

  // Primary descriptor buffer control
  wire                                  db1_push;
  wire  [p_num_queues-1:0]              db1_push_q;

  // Primary descriptor buffer full status per queue
  wire  [15:0]                          db1_full_q;


  reg                                   descr_rd_trig;

  reg                                   descr_rd_req_end;    // last AR request for a descriptor
                                                             // fetch has been accepted by AXI
                                                             //  - may be the same as descr_rd_req_start
                                                             // if data bus is wide enough for descriptor
  wire  [p_num_queues-1:0]              descr_rd_req_end_q;

  wire                                  descr_rd_resp_end;   // last R response for a descriptor
                                                             // fetch has been delivered by AXI
                                                             //  - may be the same as descr_rd_resp_start
                                                             // if data bus is wide enough for descriptor
  wire  [p_num_queues-1:0]              descr_rd_resp_end_q;


  // TX data read request signals

  reg                                   arvalid_data_hold;
  reg                                   arvalid_descr_hold;
  reg   [8:0]                           data_len_burst;  // AXI read burst in beats before 4k check
  reg   [10:0]                          data_len_4k;     // Beats to next 4kbyte boundary
  reg   [8:0]                           data_len;        // AXI read burst in beats with 4k check
  wire                                  all_data_for_txbuf_requested;

  integer                               int_a, int_c, int_d, int_e,     
                                        int_f, int_h, int_i, int_j,
                                        int_k, int_m, int_n,
                                        int_q, int_r, int_s, int_t, 
                                        int_u, int_v, int_w, int_x;
                                        

  wire  [p_awid_par-1:0]                cur_descr_ptr;
  wire  [13:0]                          cur_db2_out_axi_len_field;
  wire                                  cur_db2_out_axi_zero_len_buff;

  // signals to calculate the number of beats required to read the data specified in the descriptor
  reg   [3:0]                           alignment_addr;           // Determines how many vld bytes on 1st beat
  reg   [12:0]                          num_beats_al;             // Number of beats required to read data
  wire  [12:0]                          num_beats_al_32;          // Number of beats requred for 32-bit data bus
  wire  [12:0]                          num_beats_al_64;          // Number of beats requred for 64-bit data bus
  wire  [12:0]                          num_beats_al_128;         // Number of beats requred for 128-bit data bus
  wire  [4:0]                           num_beats_plus1_sum_128;  // Do we add 1 to the number of beats
  wire  [4:0]                           num_beats_plus1_sum_64;   // Do we add 1 to the number of beats
  wire  [4:0]                           num_beats_plus1_sum_32;   // Do we add 1 to the number of beats

  wire  [12:0]                          num_beats_ahb;           // Number of beats required to read data
  wire  [13:0]                          num_beats_ahb_32;        // Number of beats requred for 32-bit data bus
  wire  [13:0]                          num_beats_ahb_64;        // Number of beats requred for 64-bit data bus
  wire  [13:0]                          num_beats_ahb_128;       // Number of beats requred for 128-bit data bus

  wire  [13:0]                          cur_db2_out_axi_len_field_minus1; // Descriptor Length Field Minus 1

  reg   [3:0]                           r_ctr;              // Counts number of read requets after frame data read
  wire                                  r_is_pad;           // Data being read is after that required for frame
  wire                                  r_last_before_pad;  // Last valid data before padding

  reg   [p_edma_bus_width-1:0]          rdata_slice;  // TX frame read data
  wire  [p_edma_bus_pwid-1:0]           rdata_slice_par;
  reg                                   rdata_slice_full;                     // Indicates read data available for AHB interface
  reg                                   rdata_slice_last_beat_of_buf;
  wire                                  rdata_slice_push;
  wire                                  rdata_slice_pop;
  wire                                  rdata_slice_ready;


  reg   [12:0]                          tx_buf_beat_req_ctr; // Counts the number read request beats made for the current frame


  // Seconday descriptor buffer control
  // - 2 read ports for AXi and DMA
  wire                                  db2_pop_axi;
  wire [p_num_queues-1:0]               db2_pop_axi_q;
  wire                                  db2_pop_dma;
  wire [p_num_queues-1:0]               db2_pop_dma_q;

  // Secondary descriptor buffer output
  // 2 output ports
  wire  [p_descr_width+3:0]             db2_out_axi[15:0];
  wire  [p_descr_pwidth-1:0]            db2_out_axi_par[15:0];
  wire  [p_descr_width+3:0]             db2_out_nxt_axi[15:0];
  wire  [p_descr_pwidth-1:0]            db2_out_nxt_axi_par[15:0];
  wire  [p_descr_width+3:0]             db2_out_dma[15:0];
  wire  [p_descr_pwidth-1:0]            db2_out_dma_par[15:0];
  wire  [p_descr_width+3:0]             cur_db2_out_dma_sel;
  wire  [p_descr_pwidth-1:0]            cur_db2_out_dma_sel_par;

  // Seconday descriptor buffer status per queue - AXI read port realated
  wire  [p_axi_tx_descr_rd_buff_bits:0] db2_fill_axi_q[15:0];
  wire  [15:0]                          db2_empty_axi_q;

  // Seconday descriptor buffer status per queue - DMA read port realated
  wire  [15:0]                          db2_empty_dma_q;

  // Seconday descriptor buffer status for current queue - AXI read port related
  wire  [p_axi_tx_descr_rd_buff_bits:0] db2_fill_axi;
  wire                                  db2_empty_axi;
  wire                                  db2_avail_axi;

  // Seconday descriptor buffer status for current queue - DMA read port related
  wire                                  db2_empty_dma;

  // current descriptor outputs from seconday descriptor buffer
  reg   [129:0]                         cur_db2_out_dma;
  wire  [16:0]                          cur_db2_out_dma_par;
  wire                                  cur_db2_out_dma_last_bit;
  wire                                  cur_db2_out_dma_used_bit;
  wire                                  cur_db2_out_dma_gh;
  wire                                  cur_db2_out_dma_lh;
  wire  [3:0]                           ahb_addr_align;

  reg   [95:0]                          cur_db2_out_axi;
  reg   [11:0]                          cur_db2_out_axi_par;
  wire                                  cur_db2_out_axi_gh;
  wire                                  cur_db2_out_axi_fh;
  wire                                  cur_db2_out_axi_lh;
  wire                                  cur_db2_out_axi_last_bit;
  wire                                  cur_db2_out_axi_used_bit;

  reg   [95:0]                          cur_db2_out_nxt_axi;
  reg   [11:0]                          cur_db2_out_nxt_axi_par;

  reg   [63:0]                          araddr_data_inc;
  wire  [63:0]                          araddr_data_nxt;
  wire  [7:0]                           araddr_data_nxt_par;

  reg   [p_edma_tx_pbuf_addr+1:0]       requested_axi_data[p_num_queues-1:0];
  wire  [p_edma_tx_pbuf_addr+1:0]       requested_axi_data_pad[15:0];
  reg   [p_edma_tx_pbuf_addr+1:0]       cur_q_dpram_space_total;
  wire  [p_edma_tx_pbuf_addr+1:0]       cur_q_dpram_space;
  wire  [p_edma_tx_pbuf_addr+1:0]       q0_dpram_space;
  reg   [p_edma_tx_pbuf_addr+1:0]       q0_dpram_space_total;
  reg   [31:0]                          al_dpram_data;
  reg   [31:0]                          rdata_slice_dpram_data;
  wire  [p_edma_tx_pbuf_addr+2:0]       pipe_dpram_data;

  reg   [19:0]                          requesting_axi_data;
  reg   [19:0]                          received_axi_data;

  reg  [31:0]                           tx_next_descr_ptr_inc;
  wire  [3:0]                           cur_db2_dma_queue;
  reg   [3:0]                           cur_db2_axi_queue;
  reg   [3:0]                           cur_db2_axi_queue_hold;
  reg   [3:0]                           track_db2_axi_queue_for_mb;
  reg                                   hold_db2_axi_queue_for_mb_op;

  reg                                   dpram_full;
  reg                                   cur_q_dpram_full;
  wire                                  q0_dpram_full;
  reg   [8:0]                           prog_data_len_burst;
  wire                                  dpram_b2b_space;

  wire  [127:0]                         rdata_pad;           // rdata bus padded to 128 bits
  wire  [15:0]                          rdata_pad_par;       // parity for rdata_pad
  reg   [127:0]                         rdata_pad_swap;      // swizzled version of rdata_pad for endian swap
  reg   [15:0]                          rdata_pad_swap_par;  // parity for rdata_pad_swap
  wire  [127:0]                         rdata_descr_le;      // Little endian version of rdata for descriptor processing
  wire  [15:0]                          rdata_descr_le_par;  // Parity
  wire  [127:0]                         rdata_data_le;       // Little endian version of rdata for data processing
  wire  [15:0]                          rdata_data_le_par;   // parity for rdata_data_le

  reg   [63:0]                          tx_descr_wr_data_clean;
  wire  [7:0]                           tx_descr_wr_data_par_clean;
  reg   [41:0]                          tx_timestamp;
  reg   [5:0]                           tx_timestamp_par;

  wire                                  db1_in_rresp_err;
  wire                                  ar2al_push;
  wire                                  ar2al_pop;
  wire                                  tcp_parse_enable;
  wire                                  write_back_mask;
  
  //==============================================================
  // Writeback signals
  //==============================================================

  wire  [p_awid_par-1:0]                tx_descr_wb_addr; // Extracted from tx_descr_wr_data_clean with optional parity

  wire                                  wb_fifo_push;

  wire                                  wb_data_fifo_pop;
  wire                                  wb_data_fifo_full;

  wire  [31:0]                          wb_data;
  wire  [3:0]                           wb_data_par;
  wire  [41:0]                          wb_timestamp;
  wire  [5:0]                           wb_timestamp_par;

  reg                                   wb_addr_fifo_pop;
  wire                                  wb_addr_fifo_full;
  wire                                  wb_addr_fifo_empty;
  wire  [p_awid_par-1:0]                wb_addr_fifo_out;
  reg   [32:0]                          wb_addr_fifo_op;  // top bit 0 = subtract, 1 = add, remaining 32-bits = op amount


  wire                                  wb_int_fifo_pop;
  wire                                  wb_int_fifo_full;
  wire                                  wb_int_fifo_empty;
  wire  [9:0]                           wb_int_fifo_out;
  wire  [9:0]                           wb_int_fifo_in;

  wire [p_axi_tx_descr_wr_buff_bits:0]  wb_int_fifo_fill;

  reg   [1:0]                           aw_tx_descr_cnt;
  reg   [1:0]                           w_tx_descr_cnt;

  reg   [127:0]                         wdata_int;
  reg   [15:0]                          wdata_par_int;

  reg   [1:0]                           tx_descr_writebacks_num;

  wire [p_edma_tx_pbuf_addr+1:0]        axi_tx_full_adj_0_shft;
  wire [p_edma_tx_pbuf_addr+1:0]        axi_tx_full_adj_1_shft;

  // AXI management read state machine current and next state vectors and state definitions
  reg   [1:0] mrd_sm_cs;
  reg   [1:0] mrd_sm_ns;
  localparam
    MRD_IDLE  = 2'b00, // Idle state
    MRD_REQ   = 2'b01, // Issue requests
    MRD_CHECK = 2'b10, // Check for buffer capacity
    MRD_WAIT  = 2'b11; // Wait for outstanding responses

  // AXI management request state machine current/next state vectors and state definitions
  // State machine is only active if multiple AXI reads are required per descriptor
  reg   [2:0] mreq_sm_cs;
  reg   [2:0] mreq_sm_ns;
  localparam
    MREQ_IDLE    = 3'b000,
    MREQ_WORD1   = 3'b001,
    MREQ_WORD0   = 3'b010,
    MREQ_WORD2   = 3'b011,
    MREQ_WORD3_5 = 3'b100,
    MREQ_WORD4   = 3'b101;

  // AXI management response state machine current/next state vectors and state definitions
  // State machine is only active if multiple AXI reads are required per descriptor
  reg   [2:0] mresp_sm_cs;
  reg   [2:0] mresp_sm_ns;
  localparam
    MRESP_IDLE    = 3'b000,
    MRESP_WORD1   = 3'b001,
    MRESP_WORD0   = 3'b010,
    MRESP_WORD2   = 3'b011,
    MRESP_WORD3_5 = 3'b100,
    MRESP_WORD4   = 3'b101;

  // main tx data read state machine current/next state vectors and state definitions
  reg   [1:0] drd_sm_cs;
  reg   [1:0] drd_sm_ns;
  localparam
    DRD_IDLE      = 2'b00, // idle state, reset and flush fifo
    DRD_CHK_DESCR = 2'b01, // Check if descriptor requires data fetches
    DRD_PKTDATA   = 2'b10; // Read TX data from AXI



  reg           r_1st_beat;
  wire          r_1st_beat_of_buf;
  reg   [11:0]  al_ms_word_id;
  reg   [11:0]  al_ls_word_id;

  wire  [3:0]   byte15_12_trig;
  wire  [7:0]   byte12;
  wire  [7:0]   byte12_hdr;
  reg   [7:0]   byte12_r;
  wire  [7:0]   byte13;
  wire  [7:0]   byte13_hdr;
  reg   [7:0]   byte13_r;

  wire  [3:0]   byte19_16_trig;
  wire  [7:0]   byte16;
  wire  [7:0]   byte16_hdr;
  reg   [7:0]   byte16_r;
  wire  [7:0]   byte17;
  wire  [7:0]   byte17_hdr;
  reg   [7:0]   byte17_r;

  wire  [3:0]   byte23_20_trig;
  wire  [7:0]   byte20;
  wire  [7:0]   byte20_hdr;
  reg   [7:0]   byte20_r;
  wire  [7:0]   byte21;
  wire  [7:0]   byte21_hdr;
  reg   [7:0]   byte21_r;

  reg   [15:0]  ethertype;
  reg   [3:0]   ethertype_trig;

  wire  [12:0]  ipv6_hdr_nh_pstn;
  wire  [7:0]   ipv6_hdr_nh;
  wire  [3:0]   ipv6_hdr_nh_trig;

  reg   [11:0]  ipv6_ehdr_pstn;
  wire  [3:0]   ipv6_ehdr_trig;
  wire  [7:0]   ipv6_ehdr_nh;
  wire  [7:0]   ipv6_ehdr_ehl;
  wire  [3:0]   ipv6_ehdr2_trig;
  wire  [7:0]   ipv6_ehdr2_nh;
  wire  [7:0]   ipv6_ehdr2_ehl;

  wire          ipv6_ehdr2_valid;
  reg           ipv6_ehdr;
  wire          ipv6_ehdr_seq_num;

  reg           ipv4;
  reg           ipv6;
  wire          vlan;
  wire          svlan;

  reg           ipv4_r;
  reg           ipv6_r;
  reg           vlan_r;
  reg           svlan_r;

  wire  [11:0]  ipv4_ihl_pstn;
  wire  [3:0]   ipv4_ihl_trig;
  wire  [7:0]   ipv4_ihl;

  wire  [11:0]  ipv4_tl_pstn;
  wire  [3:0]   ipv4_tl_trig;

  wire  [12:0]  ipv4_fo_pstn;
  wire  [3:0]   ipv4_fo_trig;
  wire  [7:0]   ipv4_fo_byte1_hdr;

  wire  [11:0]  ipv6_pl_pstn;
  wire  [3:0]   ipv6_pl_trig;

  reg   [11:0]  tcp_sn_byte3_2_pstn;
  reg   [11:0]  tcp_sn_byte1_0_pstn;
  wire  [3:0]   tcp_sn_byte3_2_trig;
  wire  [3:0]   tcp_sn_byte1_0_trig;

  wire  [7:0]   tcp_sn_byte3_hdr;
  wire  [7:0]   tcp_sn_byte2_hdr;
  wire  [7:0]   tcp_sn_byte1_hdr;
  wire  [7:0]   tcp_sn_byte0_hdr;

  reg   [11:0]  tcp_fl_pstn;
  wire  [3:0]   tcp_fl_trig;
  wire  [7:0]   tcp_fl_byte1_hdr;
  wire  [7:0]   tcp_fl_byte0_hdr;

  reg   [11:0]  eth_hdr_len;
  reg   [11:0]  ipv4_hdr_len;
  wire  [11:0]  ipv6_hdr_len;
  reg   [11:0]  ipv6_ttl_ehdr_len;
  wire  [11:0]  ipv6_ehdr_len;
  wire  [11:0]  ipv6_ehdr2_len;


  reg   [31:0]  seq_num_st0_ctr [p_num_queues-1:0];
  reg   [31:0]  seq_num_st1_ctr [p_num_queues-1:0];
  reg   [31:0]  seq_num_st2_ctr [p_num_queues-1:0];
  reg   [31:0]  seq_num_st3_ctr [p_num_queues-1:0];
  wire  [31:0]  seq_num_st0_ctr_pad [15:0];
  wire  [31:0]  seq_num_st1_ctr_pad [15:0];
  wire  [31:0]  seq_num_st2_ctr_pad [15:0];
  wire  [31:0]  seq_num_st3_ctr_pad [15:0];


  reg           fo_inc;
  reg           sn_inc;
  reg   [3:0]   sn_fo_inc_queue;
  reg   [1:0]   sn_inc_st_id;
  reg   [13:0]  sn_fo_inc_pyld_len;

  reg   [127:0] rdata_hmod;
  wire  [15:0]  rdata_hmod_par;  // parity of rdata_hmod

  reg   [12:0]  ipv4_fo_cnt [p_num_queues-1:0];
  wire  [12:0]  ipv4_fo_cnt_pad [15:0];

  wire          db2_dma_qid_push;
  wire          db2_dma_qid_full;
  wire          db2_dma_qid_empty;

  reg  [128:0]  rdata_al_c;
  reg  [p_edma_bus_width-1:0]  rdata_al_r;
  wire [128:0]  rdata_al;
  wire [16:0]   rdata_al_par;  // parity of rdata_al
  reg           al_full;
  wire          al_push;
  wire          al_pop;
  wire          al_ready;

  reg  [120:0]  rdata_res_c;
  reg  [(p_edma_bus_width-9):0]  rdata_res_r;
  wire [120:0]  rdata_res;
  wire [15:0]   rdata_res_par;  // parity of rdata_res
  reg           res_full;
  wire          res_push;
  wire          res_pop;
  reg           res_only;

  wire          rdata_align;


  wire    [13:0]    ar_hdr_len;
  wire    [13:0]    ar_pyld_len;
  wire    [1:0]     ar_tcp_st_id;
  wire              ar_tcp_sn_sel;
  wire              ar_1st_hdr;
  wire              ar_last_hdr;

  wire    [13:0]    al_hdr_len;
  wire    [13:0]    al_pyld_len;
  wire    [1:0]     al_tcp_st_id;
  wire              al_tcp_sn_sel;
  wire              al_1st_hdr;
  wire              al_last_hdr;
  wire    [3:0]     al_queue;

  reg               al_1st_beat;
  reg               al_last;
  reg               al_first_burst_of_buf;
  reg               al_last_burst_of_buf;
  wire              al_last_beat_of_buf;
  reg               al_tcp_hdr;
  reg               al_udp_hdr;

  reg               res_first_burst_of_buf;
  reg               res_1st_beat_of_buf;
  reg               res_last_burst_of_buf;
  reg               res_tcp_hdr;
  reg               res_udp_hdr;
  reg               res_last;


  wire  [7:0]       unused0;
  wire  [7:0]       unused1;
  wire  [7:0]       unused2;
  wire  [7:0]       unused3;
  wire  [7:0]       unused4;
  wire  [7:0]       unused5;
  wire  [7:0]       unused6;
  wire  [7:0]       unused7;
  wire  [7:0]       unused8;
  wire  [7:0]       unused9;
  wire  [7:0]       unused10;
  wire  [7:0]       unused11;
  wire  [7:0]       unused12;
  wire  [7:0]       unused13;
  wire  [7:0]       unused14;
  wire  [7:0]       unused15;
  wire  [7:0]       unused16;
  wire  [7:0]       unused17;
  wire  [7:0]       unused18;
  wire  [7:0]       unused19;
  wire  [7:0]       unused20;
  wire  [7:0]       unused21;
  wire  [7:0]       unused22;
  wire  [7:0]       unused23;
  wire  [7:0]       unused24;

  wire              do_descr_read;
  wire              queue_active;

  reg   [p_awid_par-1:0]    db2_descr_ptr      [p_num_queues-1:0];
  wire  [35:0]              db2_descr_ptr_inc  [p_num_queues-1:0];
  reg   [p_num_queues-1:0]  db2_first_buffer;
  reg   [p_awid_par-1:0]    db2_1st_descr_addr [p_num_queues-1:0];
  reg   [p_awid_par-1:0]    db2_descr_wb_addr  [15:0];

  wire  [p_num_queues-1:0]  single_frame_too_big;

  reg                             q0_num_used_all;
  wire  [p_edma_tx_pbuf_addr-1:0] q0_num_used_all_pad;

  // ASF parity error detection
  wire  dap_err_cur_db2_out_dma;
  wire  dap_err_ar2al_fifo;
  wire  dap_err_rdata_al;
  wire  dap_err_tx_descr_wr_data;
  wire  [p_num_queues-1:0]  dap_err_db1_out;
  wire  [p_num_queues-1:0]  dap_err_db2_out;
  wire  [15:0]              tx_disable_queue_pad;

  //==================================================================================================
  // AXI ready valid combo for each channel
  //==================================================================================================
  assign arrv_descr = arvalid_descr && arready_descr;
  assign arrv_data  = arvalid_data  && arready_data;

  assign rrv_descr  = rvalid_descr && rready_descr;
  assign rrv_data   = rvalid_data  && rready_data;

  assign awrv_descr = awvalid_descr && awready_descr;
  assign wrv_descr  = wvalid_descr && wready_descr;
  assign brv_descr  = bvalid_descr && bready_descr;

  //==================================================================================================
  // Calculate buffer to data bus width ratio
  // When using 128-bit buffers in AHB DMA, multiple AXI stripes are packed into each RAM location
  // when data bus width is 32-bit or 64-bit. For 64-bit or 32-bit SRAM, one AXI stripe is written to
  // each SRAM location
  //==================================================================================================
  always @*
  begin
    if (p_edma_tx_pbuf_data == 32'd128)
      case (dma_bus_width)
        2'd0    : tx_fill_lvl_multiplier = 2'd2; // Four 32b words per 128b word
        2'd1    : tx_fill_lvl_multiplier = 2'd1; // Two 64b words per 128b word
        default : tx_fill_lvl_multiplier = 2'd0;
      endcase
    else
      tx_fill_lvl_multiplier = 2'd0;
  end


  //==================================================================================================
  // dpram_fill_lvl and TX_PBUF_MAX_FILL_LVL are concatenated signals containing the value for each queue
  // Split these into arrays where each entry is the value for one queue
  // Level is dependent on ratio of data bus size to dpram width and indicates the number of AXI stripes
  // tat the buffer can accomodate in the unused space
  //==================================================================================================
  genvar g2;
  generate for (g2 = 0; g2 < p_num_queues; g2 = g2 + 1)
  begin : gen_tx_dpram_fill_lvl
    wire [p_edma_tx_pbuf_addr+1:0] tx_pbuf_max_fill_lvl_shifted;
    
    assign tx_pbuf_max_fill_lvl_shifted = ({2'd0, TX_PBUF_MAX_FILL_LVL[((g2+32'd1)*p_edma_tx_pbuf_addr)-1:g2*p_edma_tx_pbuf_addr]} << tx_fill_lvl_multiplier);
    
    assign dpram_fill_lvl_array[g2] =
      dpram_fill_lvl[((g2+32'd1)*p_edma_tx_pbuf_addr)-1:g2*p_edma_tx_pbuf_addr] << tx_fill_lvl_multiplier;

    assign TX_PBUF_MAX_FILL_LVL_ARRAY[g2] = tx_pbuf_max_fill_lvl_shifted | {{p_edma_tx_pbuf_addr{1'b0}}, 2'd3};

  end
  endgenerate

assign axi_tx_full_adj_0_shft = axi_tx_full_adj_0 << tx_fill_lvl_multiplier;
assign axi_tx_full_adj_1_shft = axi_tx_full_adj_1 << tx_fill_lvl_multiplier;

  wire hw_dma_tx_start;
  edma_sync_toggle_detect i_edma_sync_toggle_detect_trigger_dma_tx_start (
    .clk      (aclk),
    .reset_n  (n_areset),
    .din      (trigger_dma_tx_start),
    .rise_edge(),
    .fall_edge(),
    .any_edge (hw_dma_tx_start));

  //========================================================================
  // Code that monitors tx_stop_pulse and stops the descriptor read state
  // machine from issuing new TX descriptor reads
  // Wait until current descriptor fetch is finished, and if descriptor
  // is for a multi buffer frame wait until all descriptors for the frame
  //========================================================================
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      stop_tx_asap  <= 1'b0;
      stop_tx_now   <= 1'b0;
    end
    else
    begin
      if (~enable_tx)
      begin
        stop_tx_asap  <= 1'b0;
        stop_tx_now   <= 1'b0;
      end
      else
      begin
        if ((mrd_sm_cs == MRD_IDLE) || tx_start_pulse || hw_dma_tx_start)
          stop_tx_asap  <= 1'b0;
        else
          if (tx_stop_pulse)
            stop_tx_asap  <= 1'b1;

        if ((mrd_sm_cs == MRD_IDLE) || tx_start_pulse || hw_dma_tx_start)
          stop_tx_now  <= 1'b0;
        else
          if ((tx_stop_pulse || stop_tx_asap) && descr_rd_resp_end && (db1_in_last_bit || (db1_in[45:32] == 14'd0)) )
            stop_tx_now  <= 1'b1;
      end
    end
  end


  //==================================================================================
  // For priority queues, we need a descriptor read counter that will decrement from
  // the highest queue in multi buffer operation,
  // it might be the case that we end the DATA state and
  // need to get a new TX descriptor for that queue. In this case, we don't want to
  // do a full descriptor sweep and just do the single queue
  // Seperate counters implemented for request and response so
  // ar_queue_descr indicates the priority queue that the current deiscriptor read
  // request is for
  //==================================================================================

  assign do_descr_read = ~db1_full_q[ar_queue_descr] && ~db1_in_used_bits_read_pad[ar_queue_descr] & ~tx_disable_queue_pad[ar_queue_descr];

  generate
    if (p_num_queues > 32'd1) begin : gen_queues_ar_queue_descr
      reg   [3:0]       ar_queue_descr_i;
      always @ (posedge aclk or negedge n_areset)
      begin
        if  (~n_areset)
          ar_queue_descr_i <= p_num_queues_m1[3:0]; //reset to highest queue
        else
        begin
          if ((~enable_tx || flush_tx_rd_fifos) && ~(arvalid_descr && ~arready_descr))
            ar_queue_descr_i <= p_num_queues_m1[3:0]; //reset to highest queue
          else
            if ((mrd_sm_cs == MRD_REQ) &&
               ((arvalid_descr && descr_rd_req_end) || (~arvalid_descr && (mreq_sm_cs == MREQ_WORD1))))
            begin
              if (ar_queue_descr_i == 4'h0)
                ar_queue_descr_i <= p_num_queues_m1[3:0];
               else
                 ar_queue_descr_i <= ar_queue_descr_i - 4'h1;
            end

        end
      end

      assign ar_queue_descr = ar_queue_descr_i;

    end else begin : gen_no_queues_ar_queue_descr
      assign ar_queue_descr = 4'h0;
    end
  endgenerate


  //============================================================================
  // AXI management read state machine
  // Triggers activity on AXI descriptor requests and AXI descriptor response state
  // machines if more than 1 read request is required per descriptor due to
  // descriptor size and data bus width.
  //============================================================================

  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      mrd_sm_cs <= MRD_IDLE;
    else
      if ((~enable_tx || flush_tx_rd_fifos) && ~(arvalid_descr && ~arready_descr))
        mrd_sm_cs <= MRD_IDLE;
      else
        mrd_sm_cs <= mrd_sm_ns;
  end

  // check it is OK to get more descriptors
  assign queue_active = (db1_full_q[p_num_queues-1:0] | tx_disable_queue) != {p_num_queues{1'b1}};

  // next state logic
  always @ *
  begin
    // Default behaviour is to stay in current state
    mrd_sm_ns = mrd_sm_cs;

    case (mrd_sm_cs)

      MRD_REQ:
        // Issue 1 descriptor read request for each queue
        // Proceed to MRD_CHECK when request is issued for queue 0
        if ( (descr_rd_req_end  && (ar_queue_descr == 4'd0)) ||
             (~do_descr_read && ~arvalid_descr_hold && (mreq_sm_cs == MREQ_WORD1) && (ar_queue_descr == 4'd0)) )
          mrd_sm_ns = MRD_CHECK;

      MRD_CHECK:
      begin
        // If wrap bit or error has been seen in incoming descriptors then proceed to MRD_WAIT
        // so all outstanding reads can complete and descriptor req pointer can then be aligned to
        // descriptor resp pointer
        // Otherwise return to MRD_REQ once there is capacity in the primary descriptor
        // buffers of any queue
        if (db1_in_used_all_q_was_detected ||
            db1_in_err_was_detected ||
            db1_in_wrap_was_detected ||
            db1_in_used_was_detected ||
            ((db1_in_used_all_q || db1_in_buff_err) && descr_rd_resp_end)
           )
          mrd_sm_ns = MRD_WAIT;
        else
          if (tx_stop_pulse || stop_tx_asap)
            mrd_sm_ns = MRD_WAIT;
          else
            if (queue_active) // get more descriptors
              mrd_sm_ns = MRD_REQ ;
      end

      MRD_WAIT:
        // Once all outstanding requests are complete, descriptor pointer will have been updated
        // Move to IDLE state on error (used bit, mid frame zero length buffer) as SW
        // update of descriptors is required
        // Otherwise return to MRD_REQ once there is capacity in the primary descriptor
        // buffers of any queue?
        if (descr_rd_pend_cnt == 5'd0)
        begin
          if (db1_in_used_all_q_was_detected || db1_in_err_was_detected || stop_tx_now)
            mrd_sm_ns = MRD_IDLE;
          else
            if (queue_active) // get more descriptors
              mrd_sm_ns = MRD_REQ ;
        end


      default: //MRD_IDLE:
        // Start requesting descriptors on start pulse, providing there is space in
        // at least 1 descriptor buffer and there isn't a pending error
        if ( (tx_start_pulse || hw_dma_tx_start || tx_start_pending) &&
              ~db1_in_err_was_detected &&
              (queue_active)
           )
          mrd_sm_ns = MRD_REQ;

    endcase
  end

  // assert descr_rd_trig as management read state machine starts a new
  // sweep
  always @ *
  begin

    case (mrd_sm_cs)

      MRD_REQ:
          descr_rd_trig = 1'b0;

      MRD_CHECK:
      begin
        if (db1_in_used_all_q_was_detected ||
            db1_in_err_was_detected ||
            db1_in_wrap_was_detected ||
            db1_in_used_was_detected ||
            ((db1_in_used_all_q || db1_in_buff_err) && descr_rd_resp_end)
           )
          descr_rd_trig = 1'b0;
        else
          if (tx_stop_pulse || stop_tx_asap)
            descr_rd_trig = 1'b0;
          else
            if (queue_active) // get more descriptors
              descr_rd_trig = 1'b1;
            else
              descr_rd_trig = 1'b0;
      end

      MRD_WAIT:
        if (descr_rd_pend_cnt == 5'd0)
        begin
          if (db1_in_used_all_q_was_detected || db1_in_err_was_detected || stop_tx_now)
            descr_rd_trig = 1'b0;
          else
            if (queue_active) // get more descriptors
              descr_rd_trig = 1'b1;
            else
              descr_rd_trig = 1'b0;
        end
        else
          descr_rd_trig = 1'b0;

      default: //MRD_IDLE:
        if ( (tx_start_pulse || hw_dma_tx_start || tx_start_pending) &&
              ~db1_in_err_was_detected &&
              (queue_active)
           )
          descr_rd_trig = 1'b1;
        else
          descr_rd_trig = 1'b0;

    endcase
  end

  //============================================================================
  // TX descriptor request state machine
  // Words 0 and 1 of descriptor must be fetched for 32-bit addressing and
  // words 0,1 and 2 for 64-bit addressing. It is not necessary to fetch the
  // timestamp words for extended descriptors
  // For a 64-bit or 128 bit data bus, words 0 and 1 are requested with the
  // 1st access and word 2 (if required) is requested with a 2nd access
  // For a 32-bit dat bus, word 1 is requested with the 1st access, word 0 with
  // the 2nd access and word 2 (if required) is requested with a 3rd access
  //============================================================================

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      mreq_sm_cs <= MREQ_IDLE;
    else
      if ((~enable_tx || flush_tx_rd_fifos) && ~(arvalid_descr && ~arready_descr))
        mreq_sm_cs <= MREQ_IDLE;
      else
        mreq_sm_cs <= mreq_sm_ns;
  end

  // next state logic
  always @ *
  begin
    mreq_sm_ns  = mreq_sm_cs;

    case (mreq_sm_cs)
      MREQ_WORD1:
        // Get words 0 and 1 for 64/128 bit data bus or word 1 for 32-bit data bus
        if (arrv_descr)
        begin
          if (dma_bus_width == 2'd0)  // 32 bit data bus
            mreq_sm_ns  = MREQ_WORD0;
          else
          begin // 64/128 bit data bus
            if (addressing_64b | tx_extended_bd_mode_en) // need word 2 in 64bit addressing/ext BD
              mreq_sm_ns = MREQ_WORD2;
            else
            begin
              if (ar_queue_descr == 4'd0)
                mreq_sm_ns  = MREQ_IDLE;
              else
                mreq_sm_ns  = MREQ_WORD1;
            end
          end
        end
        else
          if (~do_descr_read && ~arvalid_descr_hold && (ar_queue_descr == 4'd0) )
            mreq_sm_ns  = MREQ_IDLE;

      MREQ_WORD0:
        // get word 0 - only for 32-bit data bus
        if (arrv_descr)
        begin
          if (addressing_64b | tx_extended_bd_mode_en)
            mreq_sm_ns = MREQ_WORD2;
          else
            if (ar_queue_descr == 4'd0)
              mreq_sm_ns  = MREQ_IDLE;
            else
              mreq_sm_ns  = MREQ_WORD1;
        end

      MREQ_WORD2:
        // get word 2 - for all data bus widths
        // this is the lower 32bits of the launch time when no 64bit addressing and databus = 32 bits
        // or all bits of the launch time when no 64bit addressing and databus = 64/128 bits
        // or the upper data buffer address bits when 64bit addressing = 1
        if (arrv_descr)
        begin
          if (addressing_64b && tx_extended_bd_mode_en)
            mreq_sm_ns = MREQ_WORD4; // Get launch time
          else if (dma_bus_width == 2'd0 && tx_extended_bd_mode_en)
            mreq_sm_ns = MREQ_WORD3_5; // Get upper half of the launch time
          else if (ar_queue_descr == 4'd0)
            mreq_sm_ns  = MREQ_IDLE;
          else
            mreq_sm_ns  = MREQ_WORD1;
        end

      MREQ_WORD3_5:
        // get word 3 or 5 - only valid for 32 bit datapaths and tx_extended_bd_mode_en and 32bit addressing
        // this is the upper 32bits of the launch time
        if (arrv_descr)
        begin
          if (ar_queue_descr == 4'd0)
            mreq_sm_ns  = MREQ_IDLE;
          else
            mreq_sm_ns  = MREQ_WORD1;
        end

      MREQ_WORD4:
        // get word 4 - only valid for tx_extended_bd_mode_en and 64bit addressing
        // this is the launch time
        if (arrv_descr)
        begin
          if (dma_bus_width == 2'd0)
            mreq_sm_ns  = MREQ_WORD3_5;
          else if (ar_queue_descr == 4'd0)
            mreq_sm_ns  = MREQ_IDLE;
          else
            mreq_sm_ns  = MREQ_WORD1;
        end

      default: //MREQ_IDLE:
        if (descr_rd_trig)
          mreq_sm_ns = MREQ_WORD1;

    endcase
  end


  //============================================================================
  // TX descriptor response state machine next state logic
  // State changes depending on bus width and whether 64b addressing is enabled
  //============================================================================

  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      mresp_sm_cs <= MRESP_WORD1;
    else
      if (~enable_tx || flush_tx_rd_fifos)
        mresp_sm_cs <= MRESP_WORD1;
      else
        mresp_sm_cs <= mresp_sm_ns;
  end


  always @ *
  begin
    mresp_sm_ns = mresp_sm_cs;

    case (mresp_sm_cs)

      MRESP_WORD0:
      // Receiving Word 0 - only for 32-bit data bus
      begin
        if (rrv_descr)
        begin
          if (addressing_64b | tx_extended_bd_mode_en)
            // word 2 still required
            mresp_sm_ns  = MRESP_WORD2;
          else
            //descriptor read complete
            mresp_sm_ns  = MRESP_WORD1;
        end
      end

      MRESP_WORD2:
      // get word 2 - for all data bus widths
      // this is the lower 32bits of the launch time when 32bit addressing and databus = 32 bits
      // or all bits of the launch time when no 64bit addressing and databus = 64/128 bits
      // or the upper data buffer address bits when 64bit addressing = 1
      begin
        if (rrv_descr && addressing_64b && tx_extended_bd_mode_en)
          mresp_sm_ns = MRESP_WORD4; // Get launch time
        else if (rrv_descr && dma_bus_width == 2'd0 && tx_extended_bd_mode_en)
          mresp_sm_ns = MRESP_WORD3_5; // Get upper half of the launch time
        else if (rrv_descr)
          mresp_sm_ns  = MRESP_WORD1;
      end

      MRESP_WORD3_5:
      // get word 3 or 5 - only valid for 32 bit datapaths and tx_extended_bd_mode_en and 32bit addressing
      // this is the upper 32bits of the launch time
      begin
        if (rrv_descr)
          mresp_sm_ns  = MRESP_WORD1;
      end

      MRESP_WORD4:
      // get word 4 - only valid for tx_extended_bd_mode_en and 64bit addressing
      // this is the launch time
      begin
        if (rrv_descr && dma_bus_width == 2'd0)
          mresp_sm_ns  = MRESP_WORD3_5;
        else if (rrv_descr)
          mresp_sm_ns  = MRESP_WORD1;
      end

      default //MRESP_WORD1:
      // Receive word 0 and 1 for 64/128 bit data bus or word 1 for 32-but data bus
      begin
        if (rrv_descr)
        begin
          if (dma_bus_width == 2'd0)
            // 32 bit data bus - word 0 still required
            mresp_sm_ns  = MRESP_WORD0;
          else
            if (addressing_64b || tx_extended_bd_mode_en)
              // 64/128 bit data bus - word 2 still required
              mresp_sm_ns  = MRESP_WORD2;
            else
              // 64/128 bit data bus - descriptor read complete
              mresp_sm_ns   = MRESP_WORD1;
        end
      end

    endcase
  end

  // Flag detection of used bit
  // if DMA has consummed all previosly read
  // descriptors
  // For multi queue operation, flag is only set
  // if the used bit is observed for all queues

  generate
    if (p_num_queues > 32'd1)
    begin : gen_queues_descr_resp_vec
      reg  [p_num_queues-1:0] used_bit_vec_reg;
      wire [p_num_queues-1:0] descr_resp_vec;

      assign descr_resp_vec = {{(p_num_queues-1){1'b0}}, 1'b1} << r_queue;

      always @(*)
        if (descr_rd_resp_end && db1_in_used_bit)
          used_bit_vec_reg = descr_resp_vec;
        else
          used_bit_vec_reg = {p_num_queues{1'b0}};

      assign used_bit_vec = used_bit_vec_reg;
      assign db1_in_used_all_q = descr_rd_resp_end && ((db1_in_used_bits_read | used_bit_vec) == {p_num_queues{1'b1}});
    end
    else
    begin : gen_no_queues_descr_resp_vec
      assign used_bit_vec      = descr_rd_resp_end && db1_in_used_bit;
      assign db1_in_used_all_q = descr_rd_resp_end && db1_in_used_bit;
    end
  endgenerate

  // Flag detection of used bit in incoming descriptor
  // for each queue
  // When bit is set no further descriptor fetches will
  // be made for that queue until bit is cleared
  // Bit is cleared when SW issues a new tx_start_pulse
  // or HW issues a new hw_dma_tx_start pulse
  // tx_start_pending keeps queue active where descriptor word 1 was
  // read before SW update but word 0 and/or word 2 were read after
  // SW update
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      db1_in_used_bits_read <= {(p_num_queues){1'b0}};
    else
      if (mrd_sm_cs == MRD_IDLE || tx_start_pulse || hw_dma_tx_start)
        db1_in_used_bits_read <= {(p_num_queues){1'b0}} | tx_disable_queue[p_num_queues-1:0];
      else
        for (int_f=0; int_f<p_num_queues; int_f=int_f+1)
          if (descr_rd_resp_end && ~ignore_remaining_desc_rds[int_f] && db1_in_used_bit && int_f == {{28{1'b0}},r_queue})
            db1_in_used_bits_read[int_f] <= 1'b1;
  end

  // Capture tx_start until end of current / next descriptor fetch
  // so a SW update and tx_start pulse is not lost during a multi stripe
  // descriptor fetch
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      tx_start_pending <= 1'b0;
    else
      if (~enable_tx || flush_tx_rd_fifos || tx_stop_pulse)
        tx_start_pending <= 1'b0;
      else
        if ((tx_start_pulse || hw_dma_tx_start) && mrd_sm_cs != MRD_IDLE)
          // if the start happened while we are already in the middle of sending a request, then we must not
          tx_start_pending <= 1'b1;
        else
          if (mrd_sm_cs == MRD_IDLE && mrd_sm_ns == MRD_REQ)
//          if (descr_rd_resp_end)
            tx_start_pending <= 1'b0;
  end


  // Indicate when incoming descriptor should be ignored
  // due to previous read of wrap or used bit, or for
  // a descriptor read error for the same queue
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      ignore_remaining_desc_rds     <= {p_num_queues{1'b0}};
    else
      if (~enable_tx || flush_tx_rd_fifos)
        ignore_remaining_desc_rds   <= {p_num_queues{1'b0}};
      else
        if ((mrd_sm_cs == MRD_WAIT) && (descr_rd_pend_cnt == 5'd0))
          ignore_remaining_desc_rds <= {p_num_queues{1'b0}};
        else
          for (int_d=0; int_d<p_num_queues; int_d=int_d+1)
            if (descr_rd_resp_end && int_d == {{28{1'b0}},r_queue})
            begin
              if (db1_in_used_bit || db1_in_wrap_bit || db1_in_zero_len_buff_err)
                ignore_remaining_desc_rds[int_d] <= 1'b1;
            end
  end


  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      first_buffer <= {p_num_queues{1'b1}};
    else
      if (~enable_tx || flush_tx_rd_fifos)
        first_buffer <= {p_num_queues{1'b1}};
      else
        for (int_n = 0; int_n < p_num_queues; int_n = int_n + 1)
          if (db1_push && int_n == {{28{1'b0}},r_queue})
            first_buffer[int_n] <= db1_in_last_bit || db1_in_used_bit || db1_in_zero_len_buff_err;
  end


  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      db1_in_used_all_q_was_detected <= 1'b0;
      db1_in_err_was_detected        <= 1'b0;
      db1_in_wrap_was_detected       <= 1'b0;
      db1_in_used_was_detected       <= 1'b0;
    end
    else
      if (~enable_tx || flush_tx_rd_fifos)
      begin
        db1_in_used_all_q_was_detected <= 1'b0;
        db1_in_err_was_detected        <= 1'b0;
        db1_in_wrap_was_detected       <= 1'b0;
        db1_in_used_was_detected       <= 1'b0;
      end
      else
      begin
        // Used bits detected on all queues
        // - not a critical error, but
        // need to go back to IDLE and wait for start
        if (mrd_sm_cs == MRD_IDLE)
          db1_in_used_all_q_was_detected <= 1'b0;
        else
          if (db1_in_used_all_q)
            db1_in_used_all_q_was_detected <= 1'b1;

        // db1_in_err_was_detected is used to bigger error events
        // 1. used bit read mid frame
        // 2. zero length buffer mid frame
        // These will cause
        // the underlying DMA to wind back its descriptor pointer.
        // When these happen, we need to stop what we're doing, go back to IDLE state
        // and wait for the underlying module to see the flush
        if (dma_has_seen_err)
          db1_in_err_was_detected <= 1'b0;
        else
          if (db1_in_buff_err && descr_rd_resp_end)
            db1_in_err_was_detected <= 1'b1;

        // Wrap detect set if wrap bit seen in incomming descriptors
        // Cleared when main state machine enters MRD_WAIT state as
        // descriptor req pointer is then on track to be loaded
        // with descriptor resp pointer value.
        if (mrd_sm_cs == MRD_WAIT)
          db1_in_wrap_was_detected <= 1'b0;
        else
          if (db1_in_wrap_bit && descr_rd_resp_end)
            db1_in_wrap_was_detected <= 1'b1;

        // Used detect set if used bit seen in incomming descriptors
        // Cleared when main state machine enters MRD_WAIT state as
        // descriptor req pointer is then on track to be loaded
        // with descriptor resp pointer value.
        if (mrd_sm_cs == MRD_WAIT)
          db1_in_used_was_detected <= 1'b0;
        else
          if (db1_in_used_bit && descr_rd_resp_end)
            db1_in_used_was_detected <= 1'b1;
      end
  end

  // Drive descriptor read request signaling from mrd_req state machine

  assign  arlen_descr = 8'h00;
  assign  cur_descr_ptr = tx_descr_ptr_req_pad[ar_queue_descr];
  assign  arsize_descr  = (dma_bus_width == 2'b00) ? 3'd2 : 3'd3;

  always @ *
  begin
    cur_descr_ptr_inc = 32'd0;

    case (mreq_sm_cs)
      MREQ_WORD1:
      // Get words 0 and 1 for 64/128 bit data bus or word 1 for 32-bit data bus
      begin
        if (|dma_bus_width) // 128b/64b data bus
        begin
          // send request for words 0 and 1
          arvalid_descr        = do_descr_read || arvalid_descr_hold;
        end
        else  // 32-bit data bus
        begin
          // send request for word 1 only
          // Use an adder for address generation to ensure we
          // support descriptor pointers that are not 64b aligned
          arvalid_descr       = do_descr_read || arvalid_descr_hold;
          cur_descr_ptr_inc   = 32'd4;
        end
      end

      MREQ_WORD0:
      // get word 0 - only for 32-bit data bus
      begin
        arvalid_descr        = 1'b1;
      end

      MREQ_WORD2:
      // get word 2 - for all data bus widths
      begin
        arvalid_descr       = 1'b1;
        cur_descr_ptr_inc   = 32'd8;
      end

      MREQ_WORD3_5:
      // get word 3/5 - for 32 bit DPs only (must be getting launch times here)
      begin
        arvalid_descr        = 1'b1;
        if (addressing_64b) // must be requesting word 5
          cur_descr_ptr_inc = 32'h00000014;
        else
          cur_descr_ptr_inc = 32'h0000000c;
      end

      MREQ_WORD4:
      // get word 4 - for obtaining first word of launch time (must be in 64b addressing)
      begin
        arvalid_descr       = 1'b1;
        cur_descr_ptr_inc   = 32'h00000010;
      end

      default: //MREQ_IDLE - no access
      begin
        arvalid_descr        = 1'b0;
      end

    endcase
  end

  assign araddr_descr[63:32]    = addressing_64b  ? upper_tx_q_base_addr  : 32'h00000000;
  assign araddr_descr_par[7:4]  = (addressing_64b && (p_edma_asf_dap_prot > 0)) ? upper_tx_q_base_par : 4'h0;

  // The lower address is sum of cur_descr_ptr and cur_descr_ptr_inc.
  // Note that if there was no parity, the in_par to the following module isn't really valid
  // but will be ignored anyway.
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_araddr_descr (
    .in_val (cur_descr_ptr[31:0]),
    .in_par (cur_descr_ptr[p_awid_par-1:p_awid_par-4]),
    .op_val (cur_descr_ptr_inc),
    .op_add (1'b1),
    .out_val(araddr_descr[31:0]),
    .out_par(araddr_descr_par[3:0])
  );

  //============================================================================
  // Pad AXI rdata to 128 bits and swizzle for descriptor reads with and without
  // endian swap
  //============================================================================
  generate if (p_edma_bus_width == 32'd128) begin : gen_nopad_rdata
      assign rdata_pad      = rdata;
      assign rdata_pad_par  = rdata_par;
  end else begin : gen_pad_rdata
      assign rdata_pad      = {{(128-p_edma_bus_width){1'b0}},rdata};
      assign rdata_pad_par  = {{(16-p_edma_bus_pwid){1'b0}},rdata_par};
  end
  endgenerate


  always @ *
  begin
    case (dma_bus_width)

      2'b00 : begin // 32-bit
        rdata_pad_swap = {96'd0,
                          rdata_pad[7:0],     rdata_pad[15:8],
                          rdata_pad[23:16],   rdata_pad[31:24]};
        rdata_pad_swap_par = {12'd0,
                          rdata_pad_par[0],   rdata_pad_par[1],
                          rdata_pad_par[2],   rdata_pad_par[3]};
        end
      2'b01 : begin // 64-bit
        rdata_pad_swap = {64'd0,
                          rdata_pad[7:0],     rdata_pad[15:8],
                          rdata_pad[23:16],   rdata_pad[31:24],
                          rdata_pad[39:32],   rdata_pad[47:40],
                          rdata_pad[55:48],   rdata_pad[63:56]};
        rdata_pad_swap_par = {8'd0,
                          rdata_pad_par[0],   rdata_pad_par[1],
                          rdata_pad_par[2],   rdata_pad_par[3],
                          rdata_pad_par[4],   rdata_pad_par[5],
                          rdata_pad_par[6],   rdata_pad_par[7]};
        end

      default : begin // 128-bit
        rdata_pad_swap = {rdata_pad[7:0],     rdata_pad[15:8],
                          rdata_pad[23:16],   rdata_pad[31:24],
                          rdata_pad[39:32],   rdata_pad[47:40],
                          rdata_pad[55:48],   rdata_pad[63:56],
                          rdata_pad[71:64],   rdata_pad[79:72],
                          rdata_pad[87:80],   rdata_pad[95:88],
                          rdata_pad[103:96],  rdata_pad[111:104],
                          rdata_pad[119:112], rdata_pad[127:120]};
        rdata_pad_swap_par = {rdata_pad_par[0],   rdata_pad_par[1],
                          rdata_pad_par[2],   rdata_pad_par[3],
                          rdata_pad_par[4],   rdata_pad_par[5],
                          rdata_pad_par[6],   rdata_pad_par[7],
                          rdata_pad_par[8],   rdata_pad_par[9],
                          rdata_pad_par[10],  rdata_pad_par[11],
                          rdata_pad_par[12],  rdata_pad_par[13],
                          rdata_pad_par[14],  rdata_pad_par[15]};
        end
    endcase
  end


  assign rdata_descr_le     = endian_swap[0] ? rdata_pad_swap     : rdata_pad;
  assign rdata_descr_le_par = endian_swap[0] ? rdata_pad_swap_par : rdata_pad_par;
  assign rdata_data_le      = endian_swap[1] ? rdata_pad_swap     : rdata_pad;
  assign rdata_data_le_par  = endian_swap[1] ? rdata_pad_swap_par : rdata_pad_par;

  //====================================================
  // Copy descriptor data from rdata bus
  // Position of data on bus depends on bus width,
  // descriptor word(s) being read and endianism
  //====================================================
  always @ *
  begin
    case (mresp_sm_cs)
      MRESP_WORD1:
      // MRESP_WORD1 - Receiving word 0 and 1 for 64/128 bit data bus or word 1 for 32-but data bus
      //
      begin
        if (dma_bus_width[1] && r_araddr[3])
        begin
          // 128 bit data bus with raddr[3] == 1
          // BD word 1 is in 127:96, BD word 0 is in 95:64
          rdata_descr     = rdata_descr_le[127:64];
          rdata_descr_par = rdata_descr_le_par[15:8];
        end
        else
          if (dma_bus_width[1] && ~r_araddr[3])
          begin
            // 128 bit data bus with raddr[3] == 0
            // BD word 1 is in 63:32, BD word 0 is in 31:0
            rdata_descr     = rdata_descr_le[63:0];
            rdata_descr_par = rdata_descr_le_par[7:0];
          end
          else
            if (dma_bus_width == 2'b01)
            begin
              // 64 bit data bus
              // BD word 1 is in 63:32, BD word 0 is in 31:0
              rdata_descr     = rdata_descr_le[63:0];
              rdata_descr_par = rdata_descr_le_par[7:0];
            end
            else
              // 32 bit data bus
              // BD word 1 is in 31:0
              begin
                rdata_descr[63:32]= rdata_descr_le[31:0];
                rdata_descr[31:0] = 32'd0;
                rdata_descr_par   = {rdata_descr_le_par[3:0],4'h0};
              end
      end

      MRESP_WORD2, MRESP_WORD4 :
      // MRESP_WORD2 :
      // get word 2 - for all data bus widths
      // this is the lower 32bits of the launch time when 32bit addressing and databus = 32 bits
      // or all bits of the launch time when no 64bit addressing and databus = 64/128 bits
      // or the upper data buffer address bits when 64bit addressing = 1
      //
      // MRESP_WORD4
      // get word 4 - only valid for tx_extended_bd_mode_en and 64bit addressing
      // this is the launch time
      begin
        if (dma_bus_width[1] && r_araddr[3])
        begin
          // 128 bit data bus with raddr[3] == 1
          // BD word 2 & 3 is in 127:64
          rdata_descr     = rdata_descr_le[127:64];
          rdata_descr_par = rdata_descr_le_par[15:8];
        end
        else
          if (dma_bus_width[1] && ~r_araddr[3])
          begin
            // 128 bit data bus with raddr[3] == 0
            // BD word 2 & 3 is in 63:0
            rdata_descr     = rdata_descr_le[63:0];
            rdata_descr_par = rdata_descr_le_par[7:0];
          end
          else
            if (dma_bus_width == 2'b01)
            begin
              // 64 bit data bus
              // BD word 2 & 3 is in 63:0
              rdata_descr     = rdata_descr_le[63:0];
              rdata_descr_par = rdata_descr_le_par[7:0];
            end
            else
            begin
              // 32 bit data bus
              // BD word 2 is in 31:0
              rdata_descr[63:32]= 32'd0;
              rdata_descr[31:0] = rdata_descr_le[31:0];
              rdata_descr_par   = {4'h0,rdata_descr_le_par[3:0]};
            end

      end

//      MRESP_WORD0,MRESP_WORD3_5:
      default:
      // receive word 0, MRESP_WORD3_5 - valid only for 32-bit data bus
      begin
        rdata_descr[63:32]= 32'd0;
        rdata_descr[31:0] = rdata_descr_le[31:0];
        rdata_descr_par   = {4'h0,rdata_descr_le_par[3:0]};
      end

    endcase
  end

  //====================================================
  // Assert descr_rd_req_end when AR request is
  // accepted for last word of descriptor read request
  //====================================================
  always @ *
  begin
    case (mreq_sm_cs)
      MREQ_WORD1:
        // Last word unless 32-bit data bus or 64 bit addressing
        descr_rd_req_end = arrv_descr && (dma_bus_width != 2'd0) && ~(addressing_64b | tx_extended_bd_mode_en);

      MREQ_WORD0:
        // Last word unless 64 bit addressing
        descr_rd_req_end = arrv_descr && ~(addressing_64b | tx_extended_bd_mode_en);

      MREQ_WORD2:
        // 64 bit addressing or bd_extended
        descr_rd_req_end = arrv_descr && ((dma_bus_width != 2'd0 && tx_extended_bd_mode_en && !addressing_64b) || (addressing_64b && !tx_extended_bd_mode_en));

      MREQ_WORD3_5:
        // bd_extended only - always finish
        descr_rd_req_end = arrv_descr;

      MREQ_WORD4:
        // bd_extended only, only finish if not 32 bit
        descr_rd_req_end = arrv_descr && dma_bus_width != 2'd0;

      default: //MREQ_IDLE:
        // No access in this state
        descr_rd_req_end = 1'b0;

    endcase
  end


  //====================================================
  // Assert descr_rd_resp_end when rvalid is asserted for
  // last word of descriptor read response
  //====================================================
  assign descr_rd_resp_end = rrv_descr && (mresp_sm_ns == MRESP_WORD1);


  //========================================================
  // Store partial descriptor in holding register when it is
  // read via multiple read requests
  //========================================================
  wire db1_in_hold_nxt_128;
  assign db1_in_hold_nxt_128 = (db1_in_hold[128] || (rresp != 2'b00));
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      db1_in_hold <= 129'd0;
    else
      if (~enable_tx || flush_tx_rd_fifos)
        db1_in_hold <= 129'd0;
      else
        case (mresp_sm_cs)

          MRESP_WORD0:
          // receiving word 0 - valid only for 32-bit data bus
          // Need to keep previously loaded word 1
            if (rrv_descr)
              db1_in_hold <= {db1_in_hold_nxt_128,
                              {64{1'b0}},
                              db1_in_hold[63:32],
                              rdata_descr[31:0]};

          MRESP_WORD2:
          // receive word 2 or 4
            if (rrv_descr)
              db1_in_hold <= {db1_in_hold_nxt_128,
                              rdata_descr,
                              db1_in_hold[63:0]};

          MRESP_WORD3_5,MRESP_WORD4:
          // receive word 3 or 5 (only need to buffer in extended bd mode, 32 bit datapaths ..)
          // receive word 4 (only buffer the lower 32 bits in case we are in 32bit mode). If in 64/128, we'll finish here
            if (rrv_descr)
              db1_in_hold <= {db1_in_hold_nxt_128,
                              rdata_descr[31:0],
                              db1_in_hold[95:0]};

          default:  // MRESP_WORD1
          // Receiving word 0 and 1 for 64/128 bit data bus or word 1 for 32-but data bus
          // Always store whether last word of descriptor or not so that used, last and wrap
          // status is captured
            if (rrv_descr)
                db1_in_hold <= {(rresp != 2'b00),{64{1'b0}}, rdata_descr};

        endcase
  end

  //====================================================
  // Assemble descriptor for storage in buffer
  // Build from rdata_descr and holding register depending
  // on descriptor size,  address bus width
  //====================================================
  always @ *
  begin
    case (mresp_sm_cs)
      MRESP_WORD1:
      begin
      // Pass words 0 and 1 to buffer
        db1_in_129  = {65'd0,
                      rdata_descr};
        db1_in_129_par  = {9'h000,rdata_descr_par};
      end

      MRESP_WORD0:
      begin
      // Pass word 0 and previously read word 1 to buffer
      // Only valid for 32-bit data bus
        db1_in_129  = {65'd0,
                      db1_in_hold[63:32],
                      rdata_descr[31:0]};
        db1_in_129_par  = {9'h000,
                            db1_in_par_hold[7:4],
                            rdata_descr_par[3:0]};
      end

      MRESP_WORD2:
        // if 64 bit addressing enabled, bits 95:64 are the upper address bits ..
        // otherwise, bits 95:64 are the launch time and bit 96 is the launch time enable ..
        if (addressing_64b)
        begin
          db1_in_129      = {33'd0,
                             rdata_descr[31:0],
                             db1_in_hold[63:0]};
          db1_in_129_par  = {5'd0,
                            rdata_descr_par[3:0],
                            db1_in_par_hold[7:0]};
        end
        else
        begin
          db1_in_129      = {32'd0,
                             rdata_descr[63],
                             rdata_descr[31:0],
                             db1_in_hold[63:0]};
          db1_in_129_par  = {4'h0,
                            rdata_descr[63],
                            rdata_descr_par[3:0],
                            db1_in_par_hold[7:0]};
        end
      MRESP_WORD3_5:
        // we are finishing up here, tx_extended_bd_mode_en must be set..
        // if addressing_64b = 1, bits 95:64 are the upper address bits, 127:96 is the launch time
        //  and bit 128 is the launch time enable (taken from bit 31 of current bus) ..
        // if addressing_64b = 0, bits 95:64 is the launch time
        //  and bit 96 is the launch time enable (taken from bit 31 of current bus) ..
        if (addressing_64b)
        begin
          db1_in_129  = {rdata_descr[31],     // launch time enable
                         db1_in_hold[127:0]};
          db1_in_129_par  = {rdata_descr[31],
                            db1_in_par_hold[15:0]};
        end
        else
        begin
          db1_in_129  = {32'd0,
                         rdata_descr[31],     // launch time enable
                         db1_in_hold[95:0]};
          db1_in_129_par  = {4'h0,
                            rdata_descr[31],
                            db1_in_par_hold[11:0]};
        end
      default: // MRESP_WORD4
      begin
        // bits 95:64 are the upper address bits ..
        // 127:96 is the launch time
        // and bit 128 is the launch time enable
          db1_in_129  = {rdata_descr[63],     // launch time enable
                         rdata_descr[31:0],   // launch time
                         db1_in_hold[95:0]};
          db1_in_129_par  = {rdata_descr[63],
                            rdata_descr_par[3:0],
                            db1_in_par_hold[11:0]};
      end
    endcase
  end
  // Automatically shorten the bus depending on the congifuration choices
  // If 64b addressing = 0 and ext bd = 0, then the descriptor is 64bits in size
  // If 64b addressing = 1 and ext bd = 0, then the descriptor is 96bits in size
  // If 64b addressing = 0 and ext bd = 1, then the descriptor is 97bits in size
  // If 64b addressing = 1 and ext bd = 1, then the descriptor is 129bits in size
  assign db1_in     = db1_in_129[p_descr_width-1:0];
  assign db1_in_par = db1_in_129_par[p_descr_pwidth-1:0];

  assign db1_in_rresp_err = (mresp_sm_cs == MRESP_WORD1) ? (rresp != 2'b00)
                                                         : (db1_in_hold[128] || (rresp != 2'b00));


  //====================================================
  // Extract used, wrap and last status bits from descriptor
  // word 1 as it is read from AXI
  // Status must be valid as last descriptor word is read,
  // which may or may not be word 1 - depending on bus width
  // and addressing mode - so extract status from input
  // to primary descriptor buffer or from holding register
  // as required
  //====================================================
  always @ *
  begin
    if (rrv_descr && (mresp_sm_cs == MRESP_WORD1))
    //reading word 1
    begin
      db1_in_used_bit = db1_in[63] && ~ignore_remaining_desc_rds_pad[r_queue];
      db1_in_wrap_bit = db1_in[62] && ~db1_in_used_bit && ~ignore_remaining_desc_rds_pad[r_queue];
      db1_in_last_bit = db1_in[47] && ~db1_in_used_bit && ~ignore_remaining_desc_rds_pad[r_queue];
    end
    else
    begin
      db1_in_used_bit = db1_in_hold[63] && ~ignore_remaining_desc_rds_pad[r_queue];
      db1_in_wrap_bit = db1_in_hold[62] && ~db1_in_used_bit && ~ignore_remaining_desc_rds_pad[r_queue];
      db1_in_last_bit = db1_in_hold[47] && ~db1_in_used_bit && ~ignore_remaining_desc_rds_pad[r_queue];
    end
  end


  //====================================================
  // Calculate descriptor address increment
  // Descriptor can be 2, 4 or 6 words
  // legacy is 32'd8                         = 2 BD words
  // addr64 AND extended BD will be 32'd24   = 6 BD words
  // addr64 exOR extended BD will be 32'd16  = 4 BD words
  //====================================================
  always @ *
  begin
    if (~addressing_64b && ~tx_extended_bd_mode_en)
      tx_next_descr_ptr_inc = 32'h00000008;
    else
      if (addressing_64b && tx_extended_bd_mode_en)
        tx_next_descr_ptr_inc = 32'h00000018;
      else
        tx_next_descr_ptr_inc = 32'h00000010;

  end


  //====================================================
  // Track the number of outstanding descriptor read
  // requests
  //  - increment on request, decrement on response
  //  - a descriptor fetch can consist of several separate
  //    requests/responses depending on descriptor size
  //    and data bus width, so increment on the last
  //    request and decrement on the last response
  //====================================================

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      descr_rd_pend_cnt <= 5'd0;
    else
      if (~enable_tx || flush_tx_rd_fifos)
        descr_rd_pend_cnt <= 5'd0;
      else
        if (descr_rd_req_end && ~descr_rd_resp_end)
          descr_rd_pend_cnt <= descr_rd_pend_cnt + 5'd1;
        else
          if (~descr_rd_req_end && descr_rd_resp_end)
            descr_rd_pend_cnt <= descr_rd_pend_cnt - 5'd1;
  end

  //====================================================
  // Manage the descriptor pointers for each queue
  // When we issue a request, increment the current req pointer.
  // When we get a  response, increment the current resp pointer.
  // If any of these valid responses have the wrap bit set, then we need to reset
  // the pointers.  A valid response is one that doesnt have ignore_remaining_desc_rds
  // bit set or used bit set
  //====================================================
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      for (int_a = 0; int_a < p_num_queues; int_a = int_a + 1)
      begin
        tx_descr_ptr_req[int_a]  <= {p_awid_par{1'b0}};
        tx_descr_ptr_resp[int_a] <= {p_awid_par{1'b0}};
      end
    end
    else
      if (((~enable_tx || flush_tx_rd_fifos) && ~(arvalid_descr && ~arready_descr)) ||
          (new_tx_q_ptr_pulse && (mrd_sm_cs == MRD_IDLE)))
      // initialise pointers to config reg base values
      begin
        for (int_e = 0; int_e < p_num_queues; int_e = int_e + 1)
        begin
          tx_descr_ptr_req[int_e] <= tx_base_addr_arr[int_e];
          tx_descr_ptr_resp[int_e]<= tx_base_addr_arr[int_e];
        end
      end
      else
      begin
        for (int_k = 0; int_k < p_num_queues; int_k = int_k + 1)
        begin
          if (int_k == {{28{1'b0}},r_queue})
          begin
            if (descr_rd_resp_end)
            // Response pointer returns to base when wrap bit is observed, and does not increment if used bit
            // is observed or there has been an illegal descriptor
            // Otherwise, increment on each descriptor response
            begin
              if (~db1_in_used_bit && ~ignore_remaining_desc_rds_pad[r_queue] && ~db1_in_zero_len_buff_err)
              begin
                if (db1_in_wrap_bit)
                  tx_descr_ptr_resp[int_k]  <= tx_base_addr_arr[int_k];
                else
                  tx_descr_ptr_resp[int_k]  <= cur_tx_descr_ptr_resp_inc[p_awid_par-1:0];
              end
            end
          end

          if ((mrd_sm_cs == MRD_WAIT) && (descr_rd_pend_cnt == 5'd0))
          // If main descriptor read state machine enters MRD_WAIT state then there has been a wrap bit, used bit or an
          // illegal descriptor - so align req pointer with resp pointer
            tx_descr_ptr_req[int_k] <= tx_descr_ptr_resp[int_k];
          else
            if (descr_rd_req_end && int_k == {{28{1'b0}},ar_queue_descr})
            // Otherwise increment pointer when each request is output
              tx_descr_ptr_req[int_k]  <= ar_tx_descr_ptr_req_inc[p_awid_par-1:0];
        end
      end
  end

  // following is for LINT
  genvar q_cnt_1;
  generate for (q_cnt_1=0; q_cnt_1<p_num_queues; q_cnt_1 = q_cnt_1+1) begin : gen_pad_sigs
    assign ipv4_fo_cnt_pad[q_cnt_1] = ipv4_fo_cnt[q_cnt_1];
    assign ignore_remaining_desc_rds_pad[q_cnt_1] = ignore_remaining_desc_rds[q_cnt_1];
    assign first_buffer_pad[q_cnt_1] = first_buffer[q_cnt_1];
    assign db1_in_used_bits_read_pad[q_cnt_1] = db1_in_used_bits_read[q_cnt_1];
    assign tx_disable_queue_pad[q_cnt_1] = tx_disable_queue[q_cnt_1];
    assign tx_descr_ptr_resp_pad[q_cnt_1] = tx_descr_ptr_resp[q_cnt_1];
    assign requested_axi_data_pad[q_cnt_1] = requested_axi_data[q_cnt_1];
    assign tx_descr_ptr_req_pad[q_cnt_1] = tx_descr_ptr_req[q_cnt_1];
    assign seq_num_st0_ctr_pad[q_cnt_1] = seq_num_st0_ctr[q_cnt_1];
    assign seq_num_st1_ctr_pad[q_cnt_1] = seq_num_st1_ctr[q_cnt_1];
    assign seq_num_st2_ctr_pad[q_cnt_1] = seq_num_st2_ctr[q_cnt_1];
    assign seq_num_st3_ctr_pad[q_cnt_1] = seq_num_st3_ctr[q_cnt_1];
  end
  endgenerate

  genvar q_cnt;
  generate for (q_cnt=p_num_queues; q_cnt<16; q_cnt = q_cnt+1)
  begin : set_unused_sigs
    wire zero = 1'b0;
    always@(*)
    begin
      db2_descr_wb_addr[q_cnt] = {p_awid_par{zero}};
    end
    assign ipv4_fo_cnt_pad[q_cnt] = 13'd0;
    assign ignore_remaining_desc_rds_pad[q_cnt] = 1'b0;
    assign first_buffer_pad[q_cnt] = {p_awid_par{1'b0}};
    assign db1_in_used_bits_read_pad[q_cnt] = 1'b0;
    assign tx_descr_ptr_resp_pad[q_cnt] = {p_awid_par{1'b0}};
    assign tx_descr_ptr_req_pad[q_cnt] = {p_awid_par{1'b0}};
    assign db1_full_q[q_cnt] = 1'b0;
    assign tx_disable_queue_pad[q_cnt] = 1'b0;
    assign tx_base_addr_arr[q_cnt] = {p_awid_par{1'b0}};
    assign db2_out_dma[q_cnt] = {p_descr_width+4{1'b0}};
    assign db2_out_dma_par[q_cnt] = {p_descr_pwidth{1'b0}};
    assign db2_out_axi[q_cnt] = {p_descr_width+4{1'b0}};
    assign db2_out_axi_par[q_cnt] = {p_descr_pwidth{1'b0}};
    assign db2_out_nxt_axi[q_cnt] = {p_descr_width+4{1'b0}};
    assign db2_out_nxt_axi_par[q_cnt] = {p_descr_pwidth{1'b0}};
    assign db2_fill_axi_q[q_cnt] = {p_axi_tx_descr_rd_buff_bits+1{1'b0}};
    assign dpram_fill_lvl_array[q_cnt] = {p_edma_tx_pbuf_addr+2{1'b0}};
    assign TX_PBUF_MAX_FILL_LVL_ARRAY[q_cnt] = {p_edma_tx_pbuf_addr+2{1'b0}};
    assign requested_axi_data_pad[q_cnt] = {p_edma_tx_pbuf_addr+2{1'b0}};
    assign seq_num_st0_ctr_pad[q_cnt] = {32{1'b0}};
    assign seq_num_st1_ctr_pad[q_cnt] = {32{1'b0}};
    assign seq_num_st2_ctr_pad[q_cnt] = {32{1'b0}};
    assign seq_num_st3_ctr_pad[q_cnt] = {32{1'b0}};
  end
  endgenerate

  // Calculations handling parity as well
  // cur_tx_descr_ptr_resp_inc = tx_descr_ptr_resp[r_queue] + tx_next_descr_ptr_inc;
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_cur_tx_descr_ptr_resp (
    .in_val (tx_descr_ptr_resp_pad[r_queue][31:0]),
    .in_par (tx_descr_ptr_resp_pad[r_queue][p_awid_par-1:p_awid_par-4]),
    .op_val (tx_next_descr_ptr_inc),
    .op_add (1'b1),
    .out_val(cur_tx_descr_ptr_resp_inc[31:0]),
    .out_par(cur_tx_descr_ptr_resp_inc[35:32])
  );
  // ar_tx_descr_ptr_req_inc = tx_descr_ptr_req[ar_queue_descr] + tx_next_descr_ptr_inc;
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_ar_tx_descr_ptr_req (
    .in_val (tx_descr_ptr_req_pad[ar_queue_descr][31:0]),
    .in_par (tx_descr_ptr_req_pad[ar_queue_descr][p_awid_par-1:p_awid_par-4]),
    .op_val (tx_next_descr_ptr_inc),
    .op_add (1'b1),
    .out_val(ar_tx_descr_ptr_req_inc[31:0]),
    .out_par(ar_tx_descr_ptr_req_inc[35:32])
  );

  // Push descriptor to descriptor buffer when descriptor fetch response is received, unless the descriptor is
  // ignored due to a previous descriptor with used, wrap or error
  // Push descriptors with error conditions (multi buffer used bit or zero length last) so AHB will flag
  // relevant interrupt
  // Descriptors with used bit set are not pushed unless db1_in_used_all_q is set - therefore only 1 descriptor
  // with a used bit is pushed in a multi queue config when no queues have available descriptors
  // Descriptor is not pushed if an AXI response error was received for part or all of the descriptor
  assign db1_push = descr_rd_resp_end && ~ignore_remaining_desc_rds_pad[r_queue] &&
                    (~db1_in_used_bit || (db1_in_used_all_q && !q0_num_used_all) || db1_in_buff_err) && ~db1_in_rresp_err;


  // ======================================================================================
  // Descriptor buffer per queue
  // Module contains primary and secondary descriptor buffers and descriptor
  // generatot logic
  // Secondary descriptor buffer has separate read ports for AXI and AHB DMAs. AXI port
  // supplies values for current and next read pointer location
  // AHB memory fill level si for use by descriptor generatot logic
  // ======================================================================================
  genvar gv_db;
  generate
    for (gv_db = 0; gv_db < p_num_queues; gv_db = gv_db + 1)

    begin : tx_descr_buff
      wire [p_edma_tx_pbuf_addr+1:0]    axi_tx_full_adj_tmp;
      wire                              sram_full;
      wire [p_edma_tx_pbuf_addr+2:0]    axi_tx_full_adj_0_shift_p_adj_1_shift;
      
      
      assign db1_push_q[gv_db]          = db1_push && (r_queue == gv_db[3:0]);
      assign descr_rd_req_end_q[gv_db]  = descr_rd_req_end && (ar_queue_descr == gv_db[3:0]);
      assign descr_rd_resp_end_q[gv_db] = descr_rd_resp_end && (r_queue == gv_db[3:0]);

      assign db2_pop_axi_q[gv_db] = db2_pop_axi && (cur_db2_axi_queue == gv_db[3:0]);
      assign db2_pop_dma_q[gv_db] = db2_pop_dma && (cur_db2_dma_queue == gv_db[3:0]);
      
      assign axi_tx_full_adj_0_shift_p_adj_1_shift = axi_tx_full_adj_0_shft + axi_tx_full_adj_1_shft;
      assign axi_tx_full_adj_tmp  = gv_db == 0 ? axi_tx_full_adj_0_shift_p_adj_1_shift[p_edma_tx_pbuf_addr+1:0] : axi_tx_full_adj_0_shft;

      edma_pbuf_axi_fe_desc_buff #(

        .p_edma_lso                   (p_edma_lso),
        .p_edma_asf_dap_prot          (p_edma_asf_dap_prot),
        .p_axi_tx_descr_rd_buff_depth (p_axi_tx_descr_rd_buff_depth),
        .p_axi_tx_descr_rd_buff_bits  (p_axi_tx_descr_rd_buff_bits),
        .p_descr_width                (p_descr_width),
        .p_num_queues                 (p_num_queues),
        .p_edma_tx_pbuf_addr          (p_edma_tx_pbuf_addr),
        .p_edma_tx_pbuf_data          (p_edma_tx_pbuf_data),
        .p_this_queue                 (gv_db)

      ) i_tx_descr_buff (

        .aclk                   (aclk),
        .n_areset               (n_areset),

        .enable_tx              ((enable_tx && ~flush_tx_rd_fifos) || (arvalid_data && ~arready_data)),

        .db1_in                 (db1_in),
        .db1_in_par             (db1_in_par),
        .db1_push               (db1_push_q[gv_db]),
        .descr_rd_req_end       (descr_rd_req_end_q[gv_db]),
        .descr_rd_resp_end      (descr_rd_resp_end_q[gv_db]),
        .db1_full               (db1_full_q[gv_db[3:0]]),

        .db2_out_axi            (db2_out_axi[gv_db]),
        .db2_out_axi_par        (db2_out_axi_par[gv_db]),
        .db2_out_nxt_axi        (db2_out_nxt_axi[gv_db]),
        .db2_out_nxt_axi_par    (db2_out_nxt_axi_par[gv_db]),
        .db2_pop_axi            (db2_pop_axi_q[gv_db]),
        .db2_fill_axi           (db2_fill_axi_q[gv_db]),
        .db2_empty_axi          (db2_empty_axi_q[gv_db]),

        .db2_out_dma            (db2_out_dma[gv_db]),
        .db2_out_dma_par        (db2_out_dma_par[gv_db]),
        .db2_pop_dma            (db2_pop_dma_q[gv_db]),
        .db2_empty_dma          (db2_empty_dma_q[gv_db]),

        .sram_fill_lvl          (dpram_fill_lvl_array[gv_db] & TX_PBUF_MAX_FILL_LVL_ARRAY[gv_db]),
        .sram_max_fill_lvl      (TX_PBUF_MAX_FILL_LVL_ARRAY[gv_db]),
        .sram_full              (sram_full),
        .q0_dpram_full          (q0_dpram_full),
        .num_pkts_in_buf        (num_pkts_in_buf[8*gv_db+7:8*gv_db]),
        .dma_bus_width          (dma_bus_width),
        .tx_cutthru             (tx_cutthru),
        .requested_axi_data     (requested_axi_data[gv_db]),
        .axi_tx_full_adj_0      (axi_tx_full_adj_tmp),
        .ahb_dma_queue_ptr      (cur_db2_axi_queue_hold),

        .single_frame_too_big   (single_frame_too_big[gv_db]),
        .db1_out_par_err        (dap_err_db1_out[gv_db]),
        .db2_out_par_err        (dap_err_db2_out[gv_db])
      );

      // Block packet if SRAM buffer is full or if Q0 is running low in space as Q0 needs space for
      // writebacks to happen otherwise the internal AHB DMA will stall...
      assign sram_full = buffer_full_q[gv_db];

    end


    // Secondary descriptor buffer empty status is always 16 bits regardless of the number of queues,
    //  - mark non existent buffers as always empty
    for (gv_db = p_num_queues; gv_db < 16; gv_db = gv_db + 1)
    begin : ignore
      assign db2_empty_axi_q[gv_db] = 1'b1;
      assign db2_empty_dma_q[gv_db] = 1'b1;
    end
  endgenerate

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      frame_too_large <= 1'b0;
    else
      frame_too_large <= |single_frame_too_big;
  end

  // Arbitration scheme selects the highest numbered queue which has a non-empty secondary descriptor
  // buffer. However, for multi buffer operation need to keep arbiter on current queue until a
  // descripor with the last bit or used bit set is processed
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      track_db2_axi_queue_for_mb    <= 4'h0;
      hold_db2_axi_queue_for_mb_op  <= 1'b0;
    end
    else
    begin
      if ((~enable_tx || flush_tx_rd_fifos) && ~(arvalid_data && ~arready_data))
      begin
        track_db2_axi_queue_for_mb    <= 4'h0;
        hold_db2_axi_queue_for_mb_op  <= 1'b0;
      end
      else
        if (db2_pop_axi)
        begin
          if (~(cur_db2_out_axi_last_bit || cur_db2_out_axi_used_bit))
          begin
            track_db2_axi_queue_for_mb    <= cur_db2_axi_queue;
            hold_db2_axi_queue_for_mb_op  <= 1'b1;
          end
          else
            hold_db2_axi_queue_for_mb_op  <= 1'b0;
      end
    end
  end


  //=====================================================================
  // Calculate current secondary descriptor buffer queue
  //  - Highest priority queue for which a descrptor exists in the
  //    secondary descriptor buffer, unless locked due to a multi
  //    buffer frame
  //  - Rearbitration only takes place when data read state machine is
  //    in the IDLE state so once a queue is selected all the assocoated
  //    buffer data for the descriptor will be requested
  //=====================================================================
  always @ *
  begin
    if (drd_sm_cs != DRD_IDLE)
      cur_db2_axi_queue = cur_db2_axi_queue_hold;
    else
      if (hold_db2_axi_queue_for_mb_op)
        cur_db2_axi_queue = track_db2_axi_queue_for_mb;
      else
        cur_db2_axi_queue = ~db2_empty_axi_q[15] ? 4'hf :
                            ~db2_empty_axi_q[14] ? 4'he :
                            ~db2_empty_axi_q[13] ? 4'hd :
                            ~db2_empty_axi_q[12] ? 4'hc :
                            ~db2_empty_axi_q[11] ? 4'hb :
                            ~db2_empty_axi_q[10] ? 4'ha :
                            ~db2_empty_axi_q[9]  ? 4'h9 :
                            ~db2_empty_axi_q[8]  ? 4'h8 :
                            ~db2_empty_axi_q[7]  ? 4'h7 :
                            ~db2_empty_axi_q[6]  ? 4'h6 :
                            ~db2_empty_axi_q[5]  ? 4'h5 :
                            ~db2_empty_axi_q[4]  ? 4'h4 :
                            ~db2_empty_axi_q[3]  ? 4'h3 :
                            ~db2_empty_axi_q[2]  ? 4'h2 :
                            ~db2_empty_axi_q[1]  ? 4'h1 :
                                                   4'h0;
  end

  // Capture queue ID when the descriptor processing starts
  // As the ID is also pushed to the AHB DMA queue ID FIFO at this point
  // use the FIFO push signal as the capture strobe
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      cur_db2_axi_queue_hold <= 4'h0;
    else
      if (db2_dma_qid_push)
        cur_db2_axi_queue_hold <= cur_db2_axi_queue;
  end

  // If the descriptor buffer holds a generated header descriptor then this cannot be
  // processed until the next descriptr (the payload descriptor) is also available
  // - therefore there must be at least 2 entries in the buffer in this case
  // If the descriptor is not for a generated header then no addtional descriptors are
  // required
  assign db2_avail_axi = cur_db2_out_axi_gh ? |db2_fill_axi[p_axi_tx_descr_rd_buff_bits:1]
                                            : ~db2_empty_axi;


  // When AXI DMA starts using a descriptor push the queue ID into a
  // FIFO. FIFO is used to supply the queue ID for the AHB DMA to
  // ensure that AXI and AHB DMAs are operating on the same descriptor
  // from the same queue even when new descriptors are being pushed
  // into the FIFOs

  assign db2_dma_qid_push = (drd_sm_cs == DRD_IDLE) && db2_avail_axi && ~db2_dma_qid_full;

  edma_gen_fifo #(
    .FIFO_WIDTH       (4),
    .FIFO_DEPTH       (p_axi_tx_descr_rd_buff_depth),
    .FIFO_ADDR_WIDTH  (p_axi_tx_descr_rd_buff_bits)
  ) i_dma_qid_buff (

    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .flush      (~enable_tx || flush_tx_rd_fifos),

    .qempty     (db2_dma_qid_empty),
    .qfull      (db2_dma_qid_full),
    .qlevel     (),

    .push       (db2_dma_qid_push),
    .din        (cur_db2_axi_queue),

    .pop        (db2_pop_dma),
    .qout       (cur_db2_dma_queue)

  );


  //=====================================================================
  // Get descriptor for AXI and AHB DMA from buffer output
  // Descriptor is 64 or 96 bits depending on 64/32 bit addressing
  // and header modifier bits are the top 4 bits
  //  - {Generated Header, First Header, Last Header, No Increment)

  // For AHB DMA, if descriptor is for a generated header, invert the last
  // header flag and map to descriptor word 1 bit 14. This is returned in
  // the writeback value and is used by the writeback filtering logic.
  // Override the bottom 4 bits of buffer address field as the data will
  // be aligned before passing to AHB DMA - address is therefore modified
  // so AHB DMA will expect data to start in byte lane 0
  //=====================================================================
  assign ahb_addr_align = (dma_bus_width == 2'b00) ? {cur_db2_out_dma_sel[3:2], 2'd0} :
                          (dma_bus_width == 2'b01) ? {cur_db2_out_dma_sel[3],   3'd0} :
                                                     4'd0;

  assign cur_db2_out_dma_sel      = db2_out_dma[cur_db2_dma_queue];
  assign cur_db2_out_dma_sel_par  = db2_out_dma_par[cur_db2_dma_queue];
  always @ *
  begin
    if (cur_db2_out_dma_gh)
      // Generated header
      cur_db2_out_dma = {{(130-p_descr_width){1'b0}},
                         cur_db2_out_dma_sel[p_descr_width-1:47],
                         ~cur_db2_out_dma_lh, // last header bit
                         cur_db2_out_dma_sel[45:4],
                         ahb_addr_align};
    else
      cur_db2_out_dma = {{(130-p_descr_width){1'b0}},
                         cur_db2_out_dma_sel[p_descr_width-1:4],
                         ahb_addr_align};
  end

  generate if (p_edma_asf_dap_prot == 1) begin : gen_cur_db2_out_dma_par
    // Terminate and regenerate parity for cur_db2_out_dma looking at cur_db2_out_dma_sel[p_descr_width-1:0]
    // and associated parity.
    gem_par_chk_regen #(.p_chk_dwid(p_descr_width), .p_new_dwid(129)) i_regen_par (
      .odd_par  (1'b0),
      .chk_dat  (cur_db2_out_dma_sel[p_descr_width-1:0]),
      .chk_par  (cur_db2_out_dma_sel_par),
      .new_dat  (cur_db2_out_dma[128:0]),
      .dat_out  (),
      .par_out  (cur_db2_out_dma_par),
      .chk_err  (dap_err_cur_db2_out_dma)
    );
  end else begin : gen_no_cur_db2_out_dma_par
    assign cur_db2_out_dma_par      = {17{1'b0}};
    assign dap_err_cur_db2_out_dma  = 1'b0;
  end
  endgenerate

  assign cur_db2_out_dma_gh       = cur_db2_out_dma_sel[p_descr_width+3];
  assign cur_db2_out_dma_lh       = cur_db2_out_dma_sel[p_descr_width+1];
  assign cur_db2_out_dma_last_bit = cur_db2_out_dma[47];
  assign cur_db2_out_dma_used_bit = cur_db2_out_dma[63];

  // new downstream TX WR block I/F
  assign cur_descr_rd_valid = !db2_empty_dma && !db2_dma_qid_empty;
  assign db2_pop_dma        = cur_descr_rd_rdy;
  // The downstream TX WR block only needs launch time and word 0/1 of descriptor, so drop the upper databuffer address bits in 64-bit mode.
  // If 64-bit these are bits 95:64. 128 is launch time enable and 127:96 is the launch time
  // If 32-bit, 128:97 is 0. 96 is launch time enable and 95:64 is the launch time.
  generate if (p_edma_tsu == 1) begin : gen_cur_descr_rd_with_launch
    assign cur_descr_rd     = addressing_64b  ? {cur_db2_out_dma[128:96],cur_db2_out_dma[63:0]}
                                              : {cur_db2_out_dma[96:64],cur_db2_out_dma[63:0]};
    assign cur_descr_rd_par = addressing_64b  ? {cur_db2_out_dma_par[16:12],cur_db2_out_dma_par[7:0]}
                                              : cur_db2_out_dma_par[12:0];
  end else begin  : gen_cur_descr_rd_no_launch
    assign cur_descr_rd     = {33'd0, cur_db2_out_dma[63:0]};
    assign cur_descr_rd_par = {5'd0,cur_db2_out_dma_par[7:0]};
  end
  endgenerate
  assign cur_descr_rd_add   = db2_descr_wb_addr[cur_db2_dma_queue][31:0];

  assign cur_descr_rd_queue = cur_db2_dma_queue;

  // The AXI block doesnt need the launch time so drop it
  always @(*)
  begin
    if (p_edma_addr_width == 32'd64 && addressing_64b)
    begin
      cur_db2_out_axi         = db2_out_axi[cur_db2_axi_queue][31+p_edma_addr_width:0];  // AXI doesnt need the launch time
      cur_db2_out_axi_par     = db2_out_axi_par[cur_db2_axi_queue][3+(p_edma_addr_width/8):0];
      cur_db2_out_nxt_axi     = db2_out_nxt_axi[cur_db2_axi_queue][31+p_edma_addr_width:0];
      cur_db2_out_nxt_axi_par = db2_out_nxt_axi_par[cur_db2_axi_queue][3+(p_edma_addr_width/8):0];
    end
    else
    begin
      cur_db2_out_axi         = {{32{1'b0}},db2_out_axi[cur_db2_axi_queue][63:0]};
      cur_db2_out_axi_par     = {4'h0,db2_out_axi_par[cur_db2_axi_queue][7:0]};
      cur_db2_out_nxt_axi     = {{32{1'b0}},db2_out_nxt_axi[cur_db2_axi_queue][63:0]};
      cur_db2_out_nxt_axi_par = {4'h0,db2_out_nxt_axi_par[cur_db2_axi_queue][7:0]};
    end
  end
  assign cur_db2_out_axi_gh            = db2_out_axi[cur_db2_axi_queue][p_descr_width+3];
  assign cur_db2_out_axi_fh            = db2_out_axi[cur_db2_axi_queue][p_descr_width+2];
  assign cur_db2_out_axi_lh            = db2_out_axi[cur_db2_axi_queue][p_descr_width+1];
  assign cur_db2_out_axi_last_bit      = cur_db2_out_axi[47];
  assign cur_db2_out_axi_used_bit      = cur_db2_out_axi[63];
  assign cur_db2_out_axi_len_field     = cur_db2_out_axi[45:32];
  assign cur_db2_out_axi_zero_len_buff = (cur_db2_out_axi_len_field[13:0] == 14'h0000);




  //=====================================================================
  // Secondary descriptor buffer fill status for current queue
  //=====================================================================
  assign db2_empty_axi = db2_empty_axi_q[cur_db2_axi_queue];
  assign db2_empty_dma = db2_empty_dma_q[cur_db2_dma_queue];
  assign db2_fill_axi  = db2_fill_axi_q[cur_db2_axi_queue];

  assign db2_pop_axi = all_data_for_txbuf_requested;


  //============================================================================
  // Main AXI Data read state machine
  // Controls fetching of transmit data
  // This state machine does not wait for AXI responses - it issues data reads
  // up to the maximum allowed pipeline depth.
  //============================================================================

  // state vector
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      drd_sm_cs <= DRD_IDLE;
    else
    begin
      if ((~enable_tx || flush_tx_rd_fifos) && ~(arvalid_data && ~arready_data))
        drd_sm_cs <= DRD_IDLE;
      else
        drd_sm_cs <= drd_sm_ns;
    end
  end

  // next state logic
  always @ *
  begin

    drd_sm_ns = drd_sm_cs;

    case (drd_sm_cs)

      DRD_CHK_DESCR:
      begin
        // If there is no data associated with descriptor then return to idle state
        // Otherwise proceed to packet data state when first read request has been accepetd by
        // system bus fabric
        if (cur_db2_out_axi_zero_len_buff || cur_db2_out_axi_used_bit)
          drd_sm_ns = DRD_IDLE;
        else
          if (arrv_data)
            drd_sm_ns = DRD_PKTDATA;
      end

      DRD_PKTDATA:
      begin
        // Return to idle state when all data assocoated with the descriptor has been requested
        if (all_data_for_txbuf_requested)
            drd_sm_ns = DRD_IDLE;
      end

      default:  //DRD_IDLE:
        // begin processing available descriptor if there is space in the AHB DMA queue ID FIFO
        if (db2_avail_axi && ~db2_dma_qid_full)
          drd_sm_ns = DRD_CHK_DESCR;

    endcase
  end

  // Assert ARVALID for AXI data requests
  always @ *
  begin

    if ((drd_sm_cs == DRD_CHK_DESCR) && ~cur_db2_out_axi_zero_len_buff && ~cur_db2_out_axi_used_bit)
      arvalid_data  = ~dpram_full || arvalid_data_hold;
    else
      if ((drd_sm_cs == DRD_PKTDATA) && ~all_data_for_txbuf_requested)
        arvalid_data  = ~dpram_full || arvalid_data_hold;
      else
        arvalid_data  = arvalid_data_hold;
  end

  // Keep descriptor and data ARVALID asserted until accepted by bus fabric
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      arvalid_data_hold  <= 1'b0;
      arvalid_descr_hold <= 1'b0;
    end
    else
    begin
      if (arvalid_data && ~arready_data)
        arvalid_data_hold <= 1'b1;
      else
        if (arready_data)
          arvalid_data_hold <= 1'b0;

      if (arvalid_descr && ~arready_descr)
        arvalid_descr_hold <= 1'b1;
      else
        if (arready_descr)
          arvalid_descr_hold <= 1'b0;
    end
  end


  //=====================================================================
  // Generate address for data reads
  // Load from descriptor as main state machine transitions to data state,
  // then increment by burst length as each request is output
  // Maintain lower bits of address obtained from descriptor for all
  // reads generated from a descriptor. These are zeroed by top level
  // arbiter in edma_pbuf_axi_fe before going out on AXI bus,
  // but are passed through the ar2r FIFO unmodified for use by the read
  // data alignment logic
  //=====================================================================
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      araddr_data  <= 64'h00000000_00000000;
    else
      if ((drd_sm_cs == DRD_IDLE) && ~db2_empty_axi)
        araddr_data <= {cur_db2_out_axi[95:64],cur_db2_out_axi[31:0]};
      else
        if (arrv_data)
          araddr_data <= araddr_data_nxt;
  end

  // Increment amount based on last length and bus width
  always@(*)
  begin
    case (dma_bus_width)
      2'b00   : araddr_data_inc = {53'd0, data_len, 2'd0};
      2'b01   : araddr_data_inc = {52'd0, data_len, 3'd0};
      default : araddr_data_inc = {51'd0, data_len, 4'd0};
    endcase
  end

  // Add araddr_data and araddr_data_inc
  edma_arith_par #(
    .p_dwidth (64),
    .p_pwidth (8),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_cur_descr_rd_add_p4 (
    .in_val (araddr_data),
    .in_par (araddr_data_par),
    .op_val (araddr_data_inc),
    .op_add (1'b1),
    .out_val(araddr_data_nxt),
    .out_par(araddr_data_nxt_par)
  );

  //=====================================================================
  // ARSIZE for data reads - always read full stripe
  //=====================================================================
  assign arsize_data = (dma_bus_width == 2'b00) ? 3'h2 : // 32-bit
                       (dma_bus_width == 2'b01) ? 3'h3 : // 64-bit
                                                  3'h4;  // 128-bit



  // ===========================================================================
  // Calculate if there is enough space in the AHB DMA buffer to accomodate the
  // data that will be returned with the next AXI burst
  // Available space is obtained by taking the current buffer space and subtracting
  // the AXI data that has already been requested.
  // The incoming data will decrement the requested data counter some time before
  // it decrements the current buffer space, due to data pipeleining. The data
  // present in this pipeline is accounted for in the axi_tx_full_threshold value
  // ===========================================================================


  // Calculate the amount of data (in AXI beats) the current AXI request will return.
  // When data is written to SRAM there are additional status words written per
  // buffer - so add 4 beats for the last request of each buffer
  always @(*)
  begin
    if (ar_last_req_of_buf)
      requesting_axi_data = {11'd0, data_len} + (18'd4 << tx_fill_lvl_multiplier);
    else
      requesting_axi_data = {11'd0, data_len};
  end


  // Calculate the amount of data (in AXI beats) the current incoming response beat carries
  // This will normaly be 1, but beacuse 4 beats were added to the counter for
  // the buffer status words for the last request of the buffer, 4 beats are
  // also added to the last beat of the buffer
  always @(*)
  begin
    if (r_last_burst_of_buf && rlast)
      received_axi_data = (20'd1 + (18'd4 << tx_fill_lvl_multiplier));
    else
      received_axi_data = 20'd1;
  end

  // Count requested AXI data in beats per queue
  // Add requests as they are accepted
  // Subrtract resonse beats as they are received
  genvar gv_rad;
  generate
    for (gv_rad = 0; gv_rad < p_num_queues; gv_rad = gv_rad + 1)

    begin : req_axi_data

      assign arrv_data_q[gv_rad] = arrv_data && (ar_queue_data == gv_rad[3:0]);
      assign rrv_data_q[gv_rad]  = rrv_data  && (r_queue == gv_rad[3:0]);
      
      wire [p_edma_tx_pbuf_addr+2:0] requested_axi_data_1;
      wire [p_edma_tx_pbuf_addr+2:0] requested_axi_data_2;
      
      assign requested_axi_data_1 = requested_axi_data[gv_rad] - received_axi_data[p_edma_tx_pbuf_addr+1:0] + requesting_axi_data[p_edma_tx_pbuf_addr+1:0];
      assign requested_axi_data_2 = requested_axi_data[gv_rad] + requesting_axi_data[p_edma_tx_pbuf_addr+1:0];
      
      always @ (posedge aclk or negedge n_areset)
      begin
        if (~n_areset)
          requested_axi_data[gv_rad] <= {p_edma_tx_pbuf_addr+2{1'b0}};
        else
          if (~enable_tx || flush_tx_rd_fifos)
            requested_axi_data[gv_rad] <= {p_edma_tx_pbuf_addr+2{1'b0}};
          else
            if (arrv_data_q[gv_rad] && rrv_data_q[gv_rad])
              requested_axi_data[gv_rad] <= requested_axi_data_1[p_edma_tx_pbuf_addr+1:0];
            else
              if (arrv_data_q[gv_rad])
                requested_axi_data[gv_rad] <= requested_axi_data_2[p_edma_tx_pbuf_addr+1:0];
              else
                if (rrv_data_q[gv_rad])
                  requested_axi_data[gv_rad] <= requested_axi_data[gv_rad] - received_axi_data[p_edma_tx_pbuf_addr+1:0];
      end

    end
  endgenerate

  // Select dpram space available for current queue and for queue 0
  assign cur_q_dpram_space = dpram_fill_lvl_array[cur_db2_axi_queue] & TX_PBUF_MAX_FILL_LVL_ARRAY[cur_db2_axi_queue];
  assign q0_dpram_space    = dpram_fill_lvl_array[0]                 & TX_PBUF_MAX_FILL_LVL_ARRAY[0];


  // Calculate data in AXI DMA pipeline
  // - al register and rdata_slice register
  always @ *
  begin
    if (al_full)
    begin
      if (al_last_beat_of_buf)
        al_dpram_data = (32'd1 + (30'd4 << tx_fill_lvl_multiplier));
      else
        al_dpram_data = 32'd1;
    end
    else
      al_dpram_data = 32'd0;

    if (rdata_slice_full)
    begin
      if (rdata_slice_last_beat_of_buf)
        rdata_slice_dpram_data = (32'd1 + (30'd4 << tx_fill_lvl_multiplier));
      else
        rdata_slice_dpram_data = 32'd1;
    end
    else
      rdata_slice_dpram_data = 32'd0;
  end
  
  // Looking above it is evident that pipe_dpram_data can never overflow, but AFL is moaning because it is not clever
  // enough to understand that the result of this operation is not going to overflow, so we want to make the tool happy
  // and we will add a bit to the result.
  assign pipe_dpram_data = al_dpram_data[p_edma_tx_pbuf_addr+1:0] + rdata_slice_dpram_data[p_edma_tx_pbuf_addr+1:0];

  // Q0 is a special queue that holds "status only frames". These consume 2-3 locations of Q0's region every time
  // there is a used_bit_read_all event. Since we are adding used_bit_read_events to the descriptors up front
  // (way before the actual 2-3 SRAM locations are written to), we need to take that into account when
  // issuing new AR requests to avoid issuing a request that the underlying DMA wont eventually be able to
  // accept due to Q0 being full fue to status words.
  // basically we will only allow one used bit read event through the DMA at any one time.
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      q0_num_used_all <= 1'd0;
    end
    else
    begin
      if (~enable_tx || flush_tx_rd_fifos)
      begin
        q0_num_used_all <= 1'd0;
      end
      else
      begin
        // Used bits detected on all queues
        if (db1_in_used_all_q && !db1_in_used_all_q_was_detected)
        begin
          if (!(tx_descr_wr_vld && tx_descr_wr_sts[5]))
            q0_num_used_all <= 1'b1;
        end
        else if (tx_descr_wr_vld && tx_descr_wr_sts[5])
          q0_num_used_all <= 1'b0;
      end
    end
  end
  assign q0_num_used_all_pad = {{p_edma_tx_pbuf_addr-1{1'b0}},q0_num_used_all};


  // Calculate dpram space from current level value, AXI data already requested and AXI data for current request
  // If requested and current AXI data exceeds space then set to zero
  // This consists of a number of airthmetic operations, each one done separately for LINT reasons ..
  wire  [p_edma_tx_pbuf_addr+2:0] calc_space_a1;
  wire  [p_edma_tx_pbuf_addr+3:0] calc_space_a2;
  wire  [p_edma_tx_pbuf_addr+3:0] calc_space_a3;
  assign calc_space_a1 = requested_axi_data_pad[ar_queue_data] + axi_tx_full_adj_0_shft;
  assign calc_space_a2 = calc_space_a1 + {1'd0,pipe_dpram_data[p_edma_tx_pbuf_addr+1:0]};
  assign calc_space_a3 = {2'b00,cur_q_dpram_space} - calc_space_a2;

  always @ *
  begin
    if (calc_space_a2 < {2'd0,cur_q_dpram_space})
      cur_q_dpram_space_total = calc_space_a3[p_edma_tx_pbuf_addr+1:0];
    else
      cur_q_dpram_space_total = {p_edma_tx_pbuf_addr+2{1'b0}};
  end

  wire [p_edma_tx_pbuf_addr+2:0] calc_space_b1;
  wire [p_edma_tx_pbuf_addr+3:0] calc_space_b2;
  wire [p_edma_tx_pbuf_addr+3:0] calc_space_b3;
  assign calc_space_b1 = requested_axi_data[0] + axi_tx_full_adj_0_shft;
  assign calc_space_b2 = calc_space_b1 + {1'b0,pipe_dpram_data[p_edma_tx_pbuf_addr+1:0]};
  assign calc_space_b3 = {2'd0,q0_dpram_space} - calc_space_b2;
  
  always @ *
  begin
    if (calc_space_b2 < {2'd0,q0_dpram_space})
      q0_dpram_space_total = calc_space_b3[p_edma_tx_pbuf_addr+1:0];
    else
      q0_dpram_space_total = {p_edma_tx_pbuf_addr+2{1'b0}};
  end
  
  wire  [p_edma_tx_pbuf_addr+2:0] 
         requesting_axi_data_p_q0_num_used_all_x4;
  assign requesting_axi_data_p_q0_num_used_all_x4 = (requesting_axi_data[p_edma_tx_pbuf_addr+1:0] + {q0_num_used_all_pad[p_edma_tx_pbuf_addr-1:0],2'b00});  
  
  always @ *
  begin
    if (ar_queue_data == 4'd0)
      cur_q_dpram_full = (requesting_axi_data_p_q0_num_used_all_x4[p_edma_tx_pbuf_addr+1:0] > cur_q_dpram_space_total) & tx_cutthru;
    else
      cur_q_dpram_full = (requesting_axi_data[p_edma_tx_pbuf_addr+1:0] > cur_q_dpram_space_total) & tx_cutthru;
  end

  // Claim q0 is full if there isnt enough space in Q0 for all the status only frames that have been requested (max 1)
  // Fix 4 locations for the max 1 used bit read event that could be going through the system
  // We should use this to block any queue from committing the underlying DMA to a frame unless there is space in Q0
  assign q0_dpram_full = {{(p_edma_tx_pbuf_addr-1){1'b0}},3'd4} > q0_dpram_space_total;

  // Calculate if DPRAM space can accomodate 4 worst case AXI bursts - if so back to back read requests will be permitted
  // without insterting a delay to allow full status to update
  always @ *
  begin
    if (burst_length[4]) // 16 beats
      prog_data_len_burst = 9'd16;
    else
      if (burst_length[3]) // 8 beats
        prog_data_len_burst = 9'd8;
      else
        if (burst_length[2]) // 4 beats
          prog_data_len_burst = 9'd4;
        else
          if (|burst_length[1:0]) // single beat
            prog_data_len_burst = 9'd1;
          else // 256 beats
            prog_data_len_burst = 9'd256;
  end

  // about four_shifted_by_mult_p_prog_data_len_burst = prog_data_len_burst + {4'd0,four_shifted_by_mult};
  // we can say that: prog_data_len_burst in the worst case is 9'd256 and the other addend is 000010000 = 16
  // therefore the addition will be on 9 bits. Having said that, AFL says that there should be a bit more in 
  // the result because it is not clever enough to detect the maximum value the operation result can assume
  // so we want to make it happy adding an extra bit to the result
  wire  [4:0] four_shifted_by_mult;
  wire  [9:0] four_shifted_by_mult_p_prog_data_len_burst;
  wire [10:0] four_shifted_by_mult_p_prog_data_len_burst_x4;

  assign      four_shifted_by_mult                          = 3'd4 << tx_fill_lvl_multiplier;
  assign      four_shifted_by_mult_p_prog_data_len_burst    = prog_data_len_burst + {4'd0,four_shifted_by_mult};
  assign      four_shifted_by_mult_p_prog_data_len_burst_x4 = {four_shifted_by_mult_p_prog_data_len_burst[8:0], 2'b00};
    
  // cur_q_dpram_space_total maximum width is is p_edma_tx_pbuf_addr + 2 = 16+2 = 18 bits
  // prog_data_len_burst is 9 bits
  // 3'd4 << tx_fill_lvl_multiplier is maximum 5 bits (value 16)
  // the sum between prog_data_len_burst and (16'd4 << tx_fill_lvl_multiplier) is still 9 bits
  // 4 * sum = 11 bits.
  
  // cur_q_dpram_space_total (p_edma_tx_pbuf_addr + 2) has to be compared to four_shifted_by_mult_p_prog_data_len_burst_x4 (11 bits)
  // So if p_edma_tx_pbuf_addr + 2 > 11 we need to pad four_shifted_by_mult_p_prog_data_len_burst_x4, otherwise we will pad cur_q_dpram_space_total
  // to 11 
  generate if (p_edma_tx_pbuf_addr > 32'd9) begin: gen_dpram_b2b_space_pad1
    assign dpram_b2b_space = (cur_q_dpram_space_total > {{(p_edma_tx_pbuf_addr-9){1'b0}},four_shifted_by_mult_p_prog_data_len_burst_x4});
  end else if(p_edma_tx_pbuf_addr == 32'd9) begin: gen_dpram_b2b_space_nopad
    assign dpram_b2b_space = (cur_q_dpram_space_total > four_shifted_by_mult_p_prog_data_len_burst_x4);
  end else begin: gen_dpram_b2b_space_pad2 // p_edma_tx_pbuf_addr < 32'd9
    assign dpram_b2b_space = ({{(9-p_edma_tx_pbuf_addr){1'b0}},cur_q_dpram_space_total} > four_shifted_by_mult_p_prog_data_len_burst_x4);
  end
  endgenerate
    
  // DPRAM full flag
  // Assert when DPRAM cannot accept another AXI burst
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      dpram_full  <= 1'b0;
    else
    begin
      if (~enable_tx || flush_tx_rd_fifos)
        dpram_full <= 1'b0;
      else
        dpram_full  <= (arrv_data && ~dpram_b2b_space) || cur_q_dpram_full;
    end
  end


  // Obtain some information about the buffer being read
  // This is needed to issue the data reads
  always @ *
  begin
    case (dma_bus_width)
      2'b00   : alignment_addr = {2'b00, cur_db2_out_axi[1:0]};
      2'b01   : alignment_addr = {1'b0, cur_db2_out_axi[2:0]};
      default : alignment_addr = cur_db2_out_axi[3:0];
    endcase
  end

  // Calculate the number of AXI beats required to read the current buffer
  //  - dependent on the buffer length, the data bus width and the start address
  // Calucate if the lower bits of the descriptor length field, plus
  // the address alignments passes into the next word. If this
  // is the case we add 1 to the total number of words needing read.

  assign cur_db2_out_axi_len_field_minus1 = cur_db2_out_axi_len_field - 14'd1;
  assign num_beats_plus1_sum_128          = {{1'b0,alignment_addr}            + ((cur_db2_out_axi_len_field[4:0] - 5'd1) & 5'b01111)};
  assign num_beats_plus1_sum_64           = {1'b0,{{1'd0,alignment_addr[2:0]} + ((cur_db2_out_axi_len_field[3:0] - 4'd1) & 4'b0111)}};
  assign num_beats_plus1_sum_32           = {2'd0,{{1'd0,alignment_addr[1:0]} + ((cur_db2_out_axi_len_field[2:0] - 3'd1) & 3'b011)}};
  
  assign num_beats_al_128                 = {2'd0,{{cur_db2_out_axi_len_field_minus1[13:4] + {5'd0,num_beats_plus1_sum_128[4]}} + 11'd1}};
  assign num_beats_al_64                  = {1'b0,{1'd0,cur_db2_out_axi_len_field_minus1[13:3]}  + {6'd0,num_beats_plus1_sum_64[3]}  + 12'd1};
  assign num_beats_al_32                  = {cur_db2_out_axi_len_field_minus1[13:2]        + {7'd0,num_beats_plus1_sum_32[2]}} + 12'd1;

  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      num_beats_al <= 13'd0;
    else
    begin
      if (dma_bus_width[1])
        num_beats_al <= num_beats_al_128;
      else if (dma_bus_width[0])
        num_beats_al <= num_beats_al_64;
      else
        num_beats_al <= num_beats_al_32;
    end
  end

  // Caluculate numbe of beats required for the AHB DMA to read data when data is aligned to byte
  // 0 of data bus
  assign num_beats_ahb_128 = cur_db2_out_axi_len_field[13:4] + {13'd0, |cur_db2_out_axi_len_field[3:0]};
  assign num_beats_ahb_64  = cur_db2_out_axi_len_field[13:3] + {13'd0, |cur_db2_out_axi_len_field[2:0]};
  assign num_beats_ahb_32  = cur_db2_out_axi_len_field[13:2] + {13'd0, |cur_db2_out_axi_len_field[1:0]};

  assign num_beats_ahb = dma_bus_width[1]       ? num_beats_ahb_128[12:0] :
                         dma_bus_width == 2'b01 ? num_beats_ahb_64[12:0]  :
                                                  num_beats_ahb_32[12:0]  ;

  // Indicate if AHB will require less beats than AXI due to alignment logic
  assign ar_ahb_less_beats = (num_beats_al != num_beats_ahb);


  // Calucualte data still to be requested - we have the number of beats to
  // read in num_beats_al. tx_buf_beat_req_ctr is a running beat counter. data_len
  // will identify the length of the current burst being careful not to break the
  // 4K boundary rule and using the burst_length register contents (from gem_registers)
  assign num_tx_beats_remaining = (num_beats_al - tx_buf_beat_req_ctr);

  // Calculate the burst length in beats from the programmed burst_length value
  // If force_max_ahb_burst_tx is low, truncate burst if remaiing data is less
  // than programmed burst length
  // If force_max_ahb_burst_tx is high use programmed burst length regardless
  // of data availability - note force_max_ahb_burst_tx is not supported for
  // programmed burst length of 256
  // Set to max burst length when data read state machine is in idle state
  // so DPRAM space can be checked against worst case burst before actual
  // burst length is available
  always @ *
  begin
    if (burst_length[4]) // 16 beats
    begin
      if (force_max_ahb_burst_tx || (|num_tx_beats_remaining[12:4]) || (drd_sm_cs == DRD_IDLE))
        data_len_burst = 9'd16;
      else
        data_len_burst = {5'h00, num_tx_beats_remaining[3:0]};
    end
    else
      if (burst_length[3]) // 8 beats
      begin
        if (force_max_ahb_burst_tx || (|num_tx_beats_remaining[12:3]) || (drd_sm_cs == DRD_IDLE))
          data_len_burst = 9'd8;
        else
          data_len_burst = {6'h00, num_tx_beats_remaining[2:0]};
      end
      else
        if (burst_length[2]) // 4 beats
        begin
          if (force_max_ahb_burst_tx || (|num_tx_beats_remaining[12:2]) || (drd_sm_cs == DRD_IDLE))
            data_len_burst = 9'd4;
          else
            data_len_burst = {7'h00, num_tx_beats_remaining[1:0]};
        end
        else
          if (|burst_length[1:0]) // single beat
            data_len_burst = 9'd1;
          else // 256 beats - ignore force_max_ahb_burst_tx
          begin
            if (|num_tx_beats_remaining[12:8] || (drd_sm_cs == DRD_IDLE))
              data_len_burst = 9'd256;
            else
              data_len_burst = {1'b0, num_tx_beats_remaining[7:0]};
          end
  end

  // Calculate the number of beats from current address to a 4K boundary.
  // Dependent on data bus width, equal to (4096 - address[11:0]) / bytes_per_beat
  always @ *
  begin
    case (dma_bus_width)
      2'b00   : data_len_4k = 11'h400 - {1'b0, araddr_data[11:2]};
      2'b01   : data_len_4k = 11'h200 - {2'b00, araddr_data[11:3]};
      default : data_len_4k = 11'h100 - {3'b000, araddr_data[11:4]};
    endcase
  end

  // Use burst length which doesn't break a 4K boundary
  // Subtract 1 for ARLEN encoding
  // When data read state machine is in the idle state ignore 4K boundary as it takes a clock cycle for
  // the address counter to update from the new descriptor - this can cause the synchronous DPRAM full
  // flag to use a burst lenght value that is too small
  always @(*)
  begin
    if ((({2'b00, data_len_burst} > data_len_4k) && (|data_len_4k)) && (drd_sm_cs != DRD_IDLE))
    begin
      if (force_max_ahb_burst_tx)
        data_len  = 9'h001;
      else
        data_len  = data_len_4k[8:0];
    end
    else
      data_len  = data_len_burst;
  end

  assign arlen_data  = data_len[7:0] - 8'd1;

  wire [13:0] tx_buf_beat_req_ctr_p_data_len;
  assign      tx_buf_beat_req_ctr_p_data_len = tx_buf_beat_req_ctr + {4'h0, data_len};
  
  // Count the number of read request beats made for the current descriptor
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      tx_buf_beat_req_ctr <= 13'd0;
    else
    begin
      if ((~enable_tx || flush_tx_rd_fifos) && ~(arvalid_data && ~arready_data))
        tx_buf_beat_req_ctr <= 13'd0;
      else
        if (all_data_for_txbuf_requested)
          tx_buf_beat_req_ctr <= 13'd0;
        else
          if (arrv_data)
            tx_buf_beat_req_ctr <= tx_buf_beat_req_ctr_p_data_len[12:0];
    end
  end


  // Capture AXI RDATA for data reads
  // rdata_slice_full indicates data has not yet been delivered to AHB
  // and prevents acceptance of more data from AXI R channel
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      rdata_slice                  <= {p_edma_bus_width{1'b0}};
      rdata_slice_full             <= 1'b0;
      rdata_slice_last_beat_of_buf <= 1'b0;
    end
    else
    begin
      if (~enable_tx || flush_tx_rd_fifos)
      begin
        rdata_slice                  <= {p_edma_bus_width{1'b0}};
        rdata_slice_full             <= 1'b0;
        rdata_slice_last_beat_of_buf <= 1'b0;
      end
      else
      begin
        if (rdata_slice_pop && ~rdata_slice_push)
          rdata_slice_full  <= 1'b0;
        else
          if (rdata_slice_push)
          begin
            rdata_slice                  <= rdata_hmod[p_edma_bus_width-1:0];
            rdata_slice_full             <= 1'b1;
            rdata_slice_last_beat_of_buf <= al_last_beat_of_buf;
          end
      end
    end
  end

  generate if (p_edma_asf_dap_prot == 1) begin : gen_rdata_slice_par
    reg [p_edma_bus_pwid-1:0] rdata_slice_par_r;
    always@(posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        rdata_slice_par_r <= {p_edma_bus_pwid{1'b0}};
      else if (~enable_tx || flush_tx_rd_fifos)
        rdata_slice_par_r <= {p_edma_bus_pwid{1'b0}};
      else if (~(rdata_slice_pop && ~rdata_slice_push) && rdata_slice_push)
        rdata_slice_par_r <= rdata_hmod_par[p_edma_bus_pwid-1:0];
    end
    assign rdata_slice_par  = rdata_slice_par_r;
  end else begin : gen_no_rdata_slice_par
    assign rdata_slice_par  = {p_edma_bus_pwid{1'b0}};
  end
  endgenerate

  assign rdata_slice_push  = al_full && rdata_slice_ready;
  assign rdata_slice_pop   = rdata_slice_full && buff_stripe_rdy;
  assign rdata_slice_ready = ~rdata_slice_full || rdata_slice_pop;

  generate if (p_edma_bus_width < 32'd128) begin : gen_buff_stripe_pad
    assign buff_stripe      = {{(128-p_edma_bus_width){1'b0}},rdata_slice};
    if (p_edma_asf_dap_prot == 1) begin : gen_par
      assign buff_stripe_par  = {{(16-p_edma_bus_pwid){1'b0}},rdata_slice_par};
    end else begin : gen_no_par
      assign buff_stripe_par  = 16'h0000;
    end
  end else begin : gen_no_buff_stripe_pad
    assign buff_stripe      = rdata_slice;
    if (p_edma_asf_dap_prot == 1) begin : gen_par
      assign buff_stripe_par  = rdata_slice_par;
    end else begin : gen_no_par
      assign buff_stripe_par  = 16'h0000;
    end
  end
  endgenerate

  assign buff_stripe_vld      = rdata_slice_full;
  assign buff_stripe_last     = rdata_slice_last_beat_of_buf;

  // Count AXI R channel beats in last burst of frame
  // Only active when force_max_ahb_burst_tx is asserted
  // Used to identify data in excess of that required for the TX frame
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      r_ctr <= 4'h0;
    else
      if (~enable_tx || flush_tx_rd_fifos)
        r_ctr <= 4'h0;
      else
        if (force_max_ahb_burst_tx)
        begin
          if (rrv_data && r_last_burst_of_buf)
          begin
            if (rlast)
              r_ctr <= 4'h0;
            else
              r_ctr <= r_ctr + 4'h1;
          end
        end
        else
          r_ctr <= 4'h0;
  end

  // Indicate when reading padded data - i.e. data in excess of that required for frame
  // r_num_pad is bottom 4 bits of num_tx_beats_remaining at point where burst was issued
  // on AR channel, retimed to AXI R channel
  assign r_is_pad          = (r_ctr >= r_num_pad) && r_last_burst_of_buf && (|r_num_pad);
  assign r_last_before_pad = (r_ctr == (r_num_pad - 4'd1)) && r_last_burst_of_buf && (|r_num_pad) && (|burst_length);


  // Indicate when all data for TX frame has been requested
  //  - will be asserted for descriptors which require no data
  assign all_data_for_txbuf_requested = (({tx_buf_beat_req_ctr} >= num_beats_al) && (|tx_buf_beat_req_ctr)) ||
                                         ((cur_db2_out_axi_zero_len_buff || cur_db2_out_axi_used_bit) && (drd_sm_cs == DRD_CHK_DESCR));

  // Indicate when incoming descriptor is part of a multi buffer set and has the last bit set and a
  // zero length field
  // This is an error condition as there is no further buffer to supply data
  assign db1_in_zero_len_buff_err = (db1_in[45:32] == 14'h0000) && ~first_buffer_pad[r_queue] && db1_in_last_bit;

  // Indicate when incoming descriptor is part of a multi buffer set and has the used bit set
  // This is an error condition as there is no further buffer to supply data
  assign db1_in_used_buff_err = db1_in_used_bit && ~first_buffer_pad[r_queue];

  // Indicate when incoming descriptor has an error
  assign db1_in_buff_err = db1_in_zero_len_buff_err || db1_in_used_buff_err;

  // Drive AXI RREADY for descriptor and data fetches
  //  - always high for descriptor fetches as descriptor request is only made if there
  //    is capacity in descriptor buffer
  //  - drive low for data fecth if there is already data in alignment registers
  assign rready_descr = 1'b1;

  assign rready_data = ~res_only && al_ready;

  // Counters to track addresses of descriptors output to AHB DMA

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      for (int_m = 0; int_m < p_num_queues; int_m = int_m + 1)
        db2_descr_ptr[int_m] <= {p_awid_par{1'b0}};
    end
    else
      if (~enable_tx || flush_tx_rd_fifos || (new_tx_q_ptr_pulse && (mrd_sm_cs == MRD_IDLE)))
      // initialise pointers to config reg base values
      begin
        for (int_m = 0; int_m < p_num_queues; int_m = int_m + 1)
          db2_descr_ptr[int_m]  <= tx_base_addr_arr[int_m];
      end
      else
      begin
        for (int_m = 0; int_m < p_num_queues; int_m = int_m + 1)
        begin
          if ((db2_pop_dma_q[int_m]) && ~db2_out_dma[int_m][p_descr_width]) //~no increment bit
          begin
            if (~db2_out_dma[int_m][63]) // ~used bit
            begin
              if (db2_out_dma[int_m][62]) // wrap bit
                // load from base address register
                db2_descr_ptr[int_m]  <= tx_base_addr_arr[int_m];
              else
                db2_descr_ptr[int_m]  <= db2_descr_ptr_inc[int_m][p_awid_par-1:0];
            end
          end
        end
      end
  end

  // Build array of address update results.
  // Each entry of array db2_descr_ptr_inc is db2_descr_ptr + tx_next_descr_ptr_inc
  genvar g_loop_2;
  generate for (g_loop_2=0;g_loop_2<p_num_queues;g_loop_2=g_loop_2+1) begin : gen_db2_loop
    edma_arith_par #(
      .p_dwidth (32),
      .p_pwidth (4),
      .p_has_par(p_edma_asf_dap_prot)
    ) i_arith_db2_descr_ptr (
      .in_val (db2_descr_ptr[g_loop_2][31:0]),
      .in_par (db2_descr_ptr[g_loop_2][p_awid_par-1:p_awid_par-4]),
      .op_val (tx_next_descr_ptr_inc),
      .op_add (1'b1),
      .out_val(db2_descr_ptr_inc[g_loop_2][31:0]),
      .out_par(db2_descr_ptr_inc[g_loop_2][35:32])
    );
  end
  endgenerate

  // Flag first descriptor of frame in descriptors output to AHB
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      db2_first_buffer <= {p_num_queues{1'b1}};
    else
      if (~enable_tx || flush_tx_rd_fifos)
        db2_first_buffer <= {p_num_queues{1'b1}};
      else
        for (int_x = 0; int_x < p_num_queues; int_x = int_x + 1)
          if (db2_pop_dma && int_x[3:0] == cur_db2_dma_queue)
            db2_first_buffer[int_x] <= cur_db2_out_dma_last_bit || cur_db2_out_dma_used_bit;
  end

  // Capture address of first descriptor of the frame for
  // descriptors output to AHB DMA
  // For segmented/fragmented frames this will be the address
  // of the header descriptor supplied by SW
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      for (int_v = 0; int_v < p_num_queues; int_v = int_v + 1)
        db2_1st_descr_addr[int_v] <= {p_awid_par{1'b0}};
    end
    else
      if (~enable_tx || flush_tx_rd_fifos)
        for (int_w = 0; int_w < p_num_queues; int_w = int_w + 1)
          db2_1st_descr_addr[int_w] <= {p_awid_par{1'b0}};
        else
          for (int_q = 0; int_q < p_num_queues; int_q = int_q + 1)
            if ( (db2_pop_dma_q[int_q] && db2_first_buffer[int_q] && ~db2_out_dma[int_q][p_descr_width+3]) ||
                 (db2_pop_dma_q[int_q] && db2_first_buffer[int_q] && db2_out_dma[int_q][p_descr_width+3] && db2_out_dma[int_q][p_descr_width+2]) )
              db2_1st_descr_addr[int_q] <= db2_descr_ptr[int_q];
  end

  // Drive writeback address from counter or storage register
  // - dependend on whether counter holds the address of the first descriptor in a multi buffer frame

  always @ *
  begin
    for (int_r = 0; int_r < p_num_queues; int_r = int_r + 1)
      if ( (db2_first_buffer[int_r] && ~db2_out_dma[int_r][p_descr_width+3]) ||
           (db2_first_buffer[int_r] && db2_out_dma[int_r][p_descr_width+3] && db2_out_dma[int_r][p_descr_width+2]) )
        db2_descr_wb_addr[int_r] = db2_descr_ptr[int_r];
      else
        db2_descr_wb_addr[int_r] = db2_1st_descr_addr[int_r];
  end

  // Concatenate descriptor pointers and writeback addresses into single busses for transfer to AHB DMA
  genvar g;
  generate for (g = 0; g < p_num_queues; g = g + 1)
  begin : gen_axi_tx_dma_descr_ptr
    assign axi_tx_dma_descr_ptr[(g*32)+31:g*32] = db2_descr_ptr[g][31:0];
  end
  endgenerate

  // Generate toggle signal when axi_tx_dma_descr_ptr changes
  //  - i.e. when db2 is popped
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      axi_tx_dma_descr_ptr_tog <= 1'b0;
    else
      if (db2_pop_dma)
        axi_tx_dma_descr_ptr_tog <= ~axi_tx_dma_descr_ptr_tog;
  end


  //=============================================================
  // Align incoming rdata to byte 0 of data bus
  // - For data reads only - descriptor reads are not affected
  //=============================================================
  always @ (*)
  begin
    rdata_res_c = rdata_res;
    rdata_al_c  = rdata_al;
    if (res_push)
    begin
      case (dma_bus_width)
        // Note - res_push will not be active for aligned address, so
        // default branches in case statements are for highest
        // misaligned addresses
        2'b00 :
        begin
          case (r_araddr[1:0])
            2'b01   : rdata_res_c[23:0] = rdata_data_le[31:8];
            2'b10   : rdata_res_c[15:0] = rdata_data_le[31:16];
            default : rdata_res_c[7:0]  = rdata_data_le[31:24];
          endcase
        end
        2'b01 :
        begin
          case (r_araddr[2:0])
            3'b001  : rdata_res_c[55:0] = rdata_data_le[63:8];
            3'b010  : rdata_res_c[47:0] = rdata_data_le[63:16];
            3'b011  : rdata_res_c[39:0] = rdata_data_le[63:24];
            3'b100  : rdata_res_c[31:0] = rdata_data_le[63:32];
            3'b101  : rdata_res_c[23:0] = rdata_data_le[63:40];
            3'b110  : rdata_res_c[15:0] = rdata_data_le[63:48];
            default : rdata_res_c[7:0]  = rdata_data_le[63:56];
          endcase
        end
        default :
        begin
          rdata_res_c[120] = 1'b0;
          case (r_araddr[3:0])
            4'b0001 : rdata_res_c[119:0] = rdata_data_le[127:8];
            4'b0010 : rdata_res_c[111:0] = rdata_data_le[127:16];
            4'b0011 : rdata_res_c[103:0] = rdata_data_le[127:24];
            4'b0100 : rdata_res_c[95:0]  = rdata_data_le[127:32];
            4'b0101 : rdata_res_c[87:0]  = rdata_data_le[127:40];
            4'b0110 : rdata_res_c[79:0]  = rdata_data_le[127:48];
            4'b0111 : rdata_res_c[71:0]  = rdata_data_le[127:56];
            4'b1000 : rdata_res_c[63:0]  = rdata_data_le[127:64];
            4'b1001 : rdata_res_c[55:0]  = rdata_data_le[127:72];
            4'b1010 : rdata_res_c[47:0]  = rdata_data_le[127:80];
            4'b1011 : rdata_res_c[39:0]  = rdata_data_le[127:88];
            4'b1100 : rdata_res_c[31:0]  = rdata_data_le[127:96];
            4'b1101 : rdata_res_c[23:0]  = rdata_data_le[127:104];
            4'b1110 : rdata_res_c[15:0]  = rdata_data_le[127:112];
            default : rdata_res_c[7:0]   = rdata_data_le[127:120];
          endcase
        end
      endcase
    end

    if (al_push && ~res_only)
    begin
      case (dma_bus_width)
        2'b00 :
        begin
          rdata_al_c[128:32] = {97{1'b0}};
          case (r_araddr[1:0])
            2'b01   : rdata_al_c[31:0] = {rdata_data_le[7:0],  rdata_res[23:0]};
            2'b10   : rdata_al_c[31:0] = {rdata_data_le[15:0], rdata_res[15:0]};
            2'b11   : rdata_al_c[31:0] = {rdata_data_le[23:0], rdata_res[7:0]};
            default : rdata_al_c[31:0] =  rdata_data_le[31:0];
          endcase
        end

        2'b01 :
        begin
          rdata_al_c[128:64] = {65{1'b0}};
          case (r_araddr[2:0])
            3'b001  : rdata_al_c[63:0] = {rdata_data_le[7:0],  rdata_res[55:0]};
            3'b010  : rdata_al_c[63:0] = {rdata_data_le[15:0], rdata_res[47:0]};
            3'b011  : rdata_al_c[63:0] = {rdata_data_le[23:0], rdata_res[39:0]};
            3'b100  : rdata_al_c[63:0] = {rdata_data_le[31:0], rdata_res[31:0]};
            3'b101  : rdata_al_c[63:0] = {rdata_data_le[39:0], rdata_res[23:0]};
            3'b110  : rdata_al_c[63:0] = {rdata_data_le[47:0], rdata_res[15:0]};
            3'b111  : rdata_al_c[63:0] = {rdata_data_le[55:0], rdata_res[7:0]};
            default : rdata_al_c[63:0] =  rdata_data_le[63:0];
          endcase
        end

        default :
        begin
          rdata_al_c[128] = 1'b0;
          case (r_araddr[3:0])
            4'b0001 : rdata_al_c[127:0] = {rdata_data_le[7:0],   rdata_res[119:0]};
            4'b0010 : rdata_al_c[127:0] = {rdata_data_le[15:0],  rdata_res[111:0]};
            4'b0011 : rdata_al_c[127:0] = {rdata_data_le[23:0],  rdata_res[103:0]};
            4'b0100 : rdata_al_c[127:0] = {rdata_data_le[31:0],  rdata_res[95:0]};
            4'b0101 : rdata_al_c[127:0] = {rdata_data_le[39:0],  rdata_res[87:0]};
            4'b0110 : rdata_al_c[127:0] = {rdata_data_le[47:0],  rdata_res[79:0]};
            4'b0111 : rdata_al_c[127:0] = {rdata_data_le[55:0],  rdata_res[71:0]};
            4'b1000 : rdata_al_c[127:0] = {rdata_data_le[63:0],  rdata_res[63:0]};
            4'b1001 : rdata_al_c[127:0] = {rdata_data_le[71:0],  rdata_res[55:0]};
            4'b1010 : rdata_al_c[127:0] = {rdata_data_le[79:0],  rdata_res[47:0]};
            4'b1011 : rdata_al_c[127:0] = {rdata_data_le[87:0],  rdata_res[39:0]};
            4'b1100 : rdata_al_c[127:0] = {rdata_data_le[95:0],  rdata_res[31:0]};
            4'b1101 : rdata_al_c[127:0] = {rdata_data_le[103:0], rdata_res[23:0]};
            4'b1110 : rdata_al_c[127:0] = {rdata_data_le[111:0], rdata_res[15:0]};
            4'b1111 : rdata_al_c[127:0] = {rdata_data_le[119:0], rdata_res[7:0]};
            default : rdata_al_c[127:0] =  rdata_data_le[127:0];
          endcase
        end
      endcase
    end
    else if (al_push && res_only)
      rdata_al_c = {{(129-p_edma_bus_width+8){1'b0}}, rdata_res_r};
  end

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      rdata_res_r <= {(p_edma_bus_width-8){1'b0}};
      rdata_al_r  <= {p_edma_bus_width{1'b0}};
      al_full   <= 1'b0;
      res_full  <= 1'b0;
      res_only  <= 1'b0;
    end
    else
      if (~enable_tx || flush_tx_rd_fifos)
      begin
        al_full   <= 1'b0;
        res_full  <= 1'b0;
        res_only  <= 1'b0;
      end
      else
      begin
        rdata_res_r <= rdata_res_c[(p_edma_bus_width-9):0];
        rdata_al_r  <= rdata_al_c[(p_edma_bus_width-1):0];

        if (al_pop && ~al_push)
          al_full  <= 1'b0;
        else
          if (al_push)
            al_full  <= 1'b1;

        if (res_pop && ~res_push)
          res_full  <= 1'b0;
        else
          if (res_push)
            res_full  <= 1'b1;

        if (res_push && (rlast || r_last_before_pad) && r_last_burst_of_buf)
          res_only  <= 1'b1;
        else
          if (res_pop)
            res_only  <= 1'b0;

      end
  end
  assign rdata_res = {{(129-p_edma_bus_width){1'b0}}, rdata_res_r};
  assign rdata_al  =  {{(129-p_edma_bus_width){1'b0}}, rdata_al_r};

  //=============================================================
  //  ASF - Align the parirty of incoming rdata
  //=============================================================
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_rdata_res_al
    reg [15:0]  rdata_res_par_c;
    reg [16:0]  rdata_al_par_c;
    reg [p_edma_bus_width/8-2:0]  rdata_res_par_r;
    reg [p_edma_bus_width/8-1:0]  rdata_al_par_r;

    always @ (*)
    begin
      rdata_res_par_c = {{(1+(128-p_edma_bus_width)/8){1'b0}}, rdata_res_par_r};
      rdata_al_par_c  = {{(1+(128-p_edma_bus_width)/8){1'b0}}, rdata_al_par_r};
      if (res_push)
        case (dma_bus_width)
          // Note - res_push will not be active for aligned address, so
          // default branches in case statements are for highest
          // misaligned addresses
          2'b00 :
            case (r_araddr[1:0])
              2'b01   : rdata_res_par_c[2:0] = rdata_data_le_par[3:1];
              2'b10   : rdata_res_par_c[1:0] = rdata_data_le_par[3:2];
              default : rdata_res_par_c[0]   = rdata_data_le_par[3];
            endcase
          2'b01 :
            case (r_araddr[2:0])
              3'b001  : rdata_res_par_c[6:0] = rdata_data_le_par[7:1];
              3'b010  : rdata_res_par_c[5:0] = rdata_data_le_par[7:2];
              3'b011  : rdata_res_par_c[4:0] = rdata_data_le_par[7:3];
              3'b100  : rdata_res_par_c[3:0] = rdata_data_le_par[7:4];
              3'b101  : rdata_res_par_c[2:0] = rdata_data_le_par[7:5];
              3'b110  : rdata_res_par_c[1:0] = rdata_data_le_par[7:6];
              default : rdata_res_par_c[0]   = rdata_data_le_par[7];
            endcase
          default :
            case (r_araddr[3:0])
              4'b0001 : rdata_res_par_c[14:0]  = rdata_data_le_par[15:1];
              4'b0010 : rdata_res_par_c[13:0]  = rdata_data_le_par[15:2];
              4'b0011 : rdata_res_par_c[12:0]  = rdata_data_le_par[15:3];
              4'b0100 : rdata_res_par_c[11:0]  = rdata_data_le_par[15:4];
              4'b0101 : rdata_res_par_c[10:0]  = rdata_data_le_par[15:5];
              4'b0110 : rdata_res_par_c[9:0]   = rdata_data_le_par[15:6];
              4'b0111 : rdata_res_par_c[8:0]   = rdata_data_le_par[15:7];
              4'b1000 : rdata_res_par_c[7:0]   = rdata_data_le_par[15:8];
              4'b1001 : rdata_res_par_c[6:0]   = rdata_data_le_par[15:9];
              4'b1010 : rdata_res_par_c[5:0]   = rdata_data_le_par[15:10];
              4'b1011 : rdata_res_par_c[4:0]   = rdata_data_le_par[15:11];
              4'b1100 : rdata_res_par_c[3:0]   = rdata_data_le_par[15:12];
              4'b1101 : rdata_res_par_c[2:0]   = rdata_data_le_par[15:13];
              4'b1110 : rdata_res_par_c[1:0]   = rdata_data_le_par[15:14];
              default : rdata_res_par_c[0]     = rdata_data_le_par[15];
            endcase
        endcase

      if (al_push && ~res_only)
      begin
        case (dma_bus_width)
          2'b00 :
            case (r_araddr[1:0])
              2'b01   : rdata_al_par_c[3:0]  = {rdata_data_le_par[0],   rdata_res_par[2:0]};
              2'b10   : rdata_al_par_c[3:0]  = {rdata_data_le_par[1:0], rdata_res_par[1:0]};
              2'b11   : rdata_al_par_c[3:0]  = {rdata_data_le_par[2:0], rdata_res_par[0]};
              default : rdata_al_par_c[3:0]  =  rdata_data_le_par[3:0];
            endcase

          2'b01 :
            case (r_araddr[2:0])
              3'b001  : rdata_al_par_c[7:0] = {rdata_data_le_par[0],   rdata_res_par[6:0]};
              3'b010  : rdata_al_par_c[7:0] = {rdata_data_le_par[1:0], rdata_res_par[5:0]};
              3'b011  : rdata_al_par_c[7:0] = {rdata_data_le_par[2:0], rdata_res_par[4:0]};
              3'b100  : rdata_al_par_c[7:0] = {rdata_data_le_par[3:0], rdata_res_par[3:0]};
              3'b101  : rdata_al_par_c[7:0] = {rdata_data_le_par[4:0], rdata_res_par[2:0]};
              3'b110  : rdata_al_par_c[7:0] = {rdata_data_le_par[5:0], rdata_res_par[1:0]};
              3'b111  : rdata_al_par_c[7:0] = {rdata_data_le_par[6:0], rdata_res_par[0]};
              default : rdata_al_par_c[7:0] =  rdata_data_le_par[7:0];
            endcase

          default :
            case (r_araddr[3:0])
              4'b0001 : rdata_al_par_c[15:0] = {rdata_data_le_par[0],    rdata_res_par[14:0]};
              4'b0010 : rdata_al_par_c[15:0] = {rdata_data_le_par[1:0],  rdata_res_par[13:0]};
              4'b0011 : rdata_al_par_c[15:0] = {rdata_data_le_par[2:0],  rdata_res_par[12:0]};
              4'b0100 : rdata_al_par_c[15:0] = {rdata_data_le_par[3:0],  rdata_res_par[11:0]};
              4'b0101 : rdata_al_par_c[15:0] = {rdata_data_le_par[4:0],  rdata_res_par[10:0]};
              4'b0110 : rdata_al_par_c[15:0] = {rdata_data_le_par[5:0],  rdata_res_par[9:0]};
              4'b0111 : rdata_al_par_c[15:0] = {rdata_data_le_par[6:0],  rdata_res_par[8:0]};
              4'b1000 : rdata_al_par_c[15:0] = {rdata_data_le_par[7:0],  rdata_res_par[7:0]};
              4'b1001 : rdata_al_par_c[15:0] = {rdata_data_le_par[8:0],  rdata_res_par[6:0]};
              4'b1010 : rdata_al_par_c[15:0] = {rdata_data_le_par[9:0],  rdata_res_par[5:0]};
              4'b1011 : rdata_al_par_c[15:0] = {rdata_data_le_par[10:0], rdata_res_par[4:0]};
              4'b1100 : rdata_al_par_c[15:0] = {rdata_data_le_par[11:0], rdata_res_par[3:0]};
              4'b1101 : rdata_al_par_c[15:0] = {rdata_data_le_par[12:0], rdata_res_par[2:0]};
              4'b1110 : rdata_al_par_c[15:0] = {rdata_data_le_par[13:0], rdata_res_par[1:0]};
              4'b1111 : rdata_al_par_c[15:0] = {rdata_data_le_par[14:0], rdata_res_par[0]};
              default : rdata_al_par_c[15:0] =  rdata_data_le_par[15:0];
            endcase
        endcase
      end
      else
        if (al_push && res_only)
          rdata_al_par_c = {{(1+(128-p_edma_bus_width+8)/8){1'b0}}, rdata_res_par_r};

    end

    always @ (posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
      begin
        rdata_res_par_r <= {p_edma_bus_width/8-1{1'b0}};
        rdata_al_par_r  <= {p_edma_bus_width/8{1'b0}};
      end
      else
        if(enable_tx && ~flush_tx_rd_fifos)
        begin
          rdata_res_par_r <= rdata_res_par_c[(p_edma_bus_width/8-2):0];
          rdata_al_par_r  <= rdata_al_par_c[(p_edma_bus_width/8-1):0];
        end
    end
    assign rdata_al_par   = {{(1+(128-p_edma_bus_width)/8){1'b0}}, rdata_al_par_r};
    assign rdata_res_par  = {{(1+(128-p_edma_bus_width)/8){1'b0}}, rdata_res_par_r};
  end else begin : gen_no_par_rdata_res_al
    assign rdata_res_par  = 16'd0;
    assign rdata_al_par   = 17'd0;
  end
  endgenerate

  assign rdata_align = ((dma_bus_width == 2'b00) && (r_araddr[1:0] == 2'b00)) ||
                       ((dma_bus_width == 2'b01) && (r_araddr[2:0] == 3'b000)) ||
                       (dma_bus_width[1] && (r_araddr[3:0] == 4'b0000));

  // Push data into residue buffer if masaligned - apart from the last stripe when the number of AHB beats is less
  // than the number of AXI beats
  assign res_push  = rrv_data && ~r_is_pad && ~rdata_align && ~(r_ahb_less_beats && (rlast || r_last_before_pad) && r_last_burst_of_buf);
  assign res_pop   = al_push;


  // Push data into rdata_al
  //  - Push on all incoming beats apart from first beat of unaligned access
  //     - First beat of unaligned access goes completely to residue register
  //  - Push if res_only flag is set
  //     - Will occur for unaligned accesses where aligned burst has less beats than unaligned burst
  assign al_push   = (rrv_data && ~r_is_pad && ~(r_1st_beat_of_buf && ~rdata_align)) ||
                     (res_only && al_ready);

  assign al_pop    = rdata_slice_push;
  assign al_ready  = (~al_full || al_pop);


  // Status bits which accompany data through rdata_res and rdata_al registers
  generate if (p_edma_lso == 1'b1) begin : gen_res_lso
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      res_first_burst_of_buf <= 1'b0;
      res_1st_beat_of_buf    <= 1'b0;
      res_tcp_hdr            <= 1'b0;
      res_udp_hdr            <= 1'b0;

      al_first_burst_of_buf  <= 1'b0;
      al_tcp_hdr             <= 1'b0;
      al_udp_hdr             <= 1'b0;
    end
    else
      if (~enable_tx || flush_tx_rd_fifos)
      begin
        res_first_burst_of_buf <= 1'b0;
        res_1st_beat_of_buf    <= 1'b0;
        res_tcp_hdr            <= 1'b0;
        res_udp_hdr            <= 1'b0;

        al_first_burst_of_buf  <= 1'b0;
        al_tcp_hdr             <= 1'b0;
        al_udp_hdr             <= 1'b0;
      end
      else
      begin
        if (res_push)
        begin
          res_first_burst_of_buf <= r_first_burst_of_buf;
          res_1st_beat_of_buf    <= r_1st_beat_of_buf;
          res_tcp_hdr            <= r_tcp_hdr;
          res_udp_hdr            <= r_udp_hdr;
        end

        if (al_push)
        begin
          if (res_only) // Data only coming from residue register
          begin
            al_first_burst_of_buf <= res_first_burst_of_buf;
            al_tcp_hdr            <= res_tcp_hdr;
            al_udp_hdr            <= res_udp_hdr;
          end
          else
            if (res_full) // Data coming from residue register and AXI bus
            begin
              al_first_burst_of_buf <= res_first_burst_of_buf;  // 1st burst may be single beat
              al_tcp_hdr            <= r_tcp_hdr;
              al_udp_hdr            <= r_udp_hdr;
            end
            else  // Data coming from AXI bus only
            begin
              al_first_burst_of_buf <= r_first_burst_of_buf;
              al_tcp_hdr            <= r_tcp_hdr;
              al_udp_hdr            <= r_udp_hdr;
            end
        end
      end
  end
  end else begin : gen_no_res_lso
    wire zero;
    assign zero = 1'b0;
    always @(zero)
    begin
      res_first_burst_of_buf  = zero;
      res_1st_beat_of_buf     = zero;
      res_tcp_hdr             = zero;
      res_udp_hdr             = zero;
      al_first_burst_of_buf   = zero;
      al_tcp_hdr              = zero;
      al_udp_hdr              = zero;
    end
  end
  endgenerate

  // same process as above but always there ..
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      res_last_burst_of_buf  <= 1'b0;
      res_last               <= 1'b0;

      al_last_burst_of_buf   <= 1'b0;
      al_last                <= 1'b0;
    end
    else
      if (~enable_tx || flush_tx_rd_fifos)
      begin
        res_last_burst_of_buf  <= 1'b0;
        res_last               <= 1'b0;

        al_last_burst_of_buf   <= 1'b0;
        al_last                <= 1'b0;
      end
      else
      begin
        if (res_push)
        begin
          res_last_burst_of_buf  <= r_last_burst_of_buf;
          res_last               <= rlast || r_last_before_pad;
        end

        if (al_push)
        begin
          if (res_only) // Data only coming from residue register
          begin
            al_last_burst_of_buf  <= res_last_burst_of_buf;
            al_last               <= res_last;
          end
          else
            if (res_full) // Data coming from residue register and AXI bus
            begin
              al_last_burst_of_buf  <= r_last_burst_of_buf;     // Last burst may be single beat
              al_last               <= (rlast || r_last_before_pad) && ~res_push;
            end
            else  // Data coming from AXI bus only
            begin
              al_last_burst_of_buf  <= r_last_burst_of_buf;
              al_last               <= (rlast || r_last_before_pad);
            end
        end
      end
  end

  assign al_last_beat_of_buf = al_last_burst_of_buf && al_last;

  // Parameterise the FIFO width for ASF protection
  localparam p_ar2al_dwidth  = 14+14+2+1+1+1+4;
  localparam p_ar2al_pwidth  = (p_ar2al_dwidth+7) / 8;
  localparam p_ar2al_width   = (p_edma_asf_dap_prot == 1)  ? p_ar2al_dwidth + p_ar2al_pwidth : p_ar2al_dwidth;

  wire  [p_ar2al_width-1:0] ar2al_fifo_in, ar2al_fifo_out;

  assign ar2al_fifo_in[p_ar2al_dwidth-1:0]  = {ar_hdr_len, ar_pyld_len, ar_tcp_st_id, ar_tcp_sn_sel, ar_1st_hdr, ar_last_hdr, ar_queue_data};
  assign {al_hdr_len, al_pyld_len, al_tcp_st_id,
          al_tcp_sn_sel, al_1st_hdr, al_last_hdr,
          al_queue} = ar2al_fifo_out[p_ar2al_dwidth-1:0];

  // Optional parity protection
  generate if ((p_edma_asf_dap_prot == 1) && (p_edma_lso == 1'b1)) begin : gen_ar2al_par
    // Check and generate new parity for ar2al_fifo_in.
    gem_par_chk_regen #(.p_chk_dwid (48),.p_new_dwid(p_ar2al_dwidth)) i_regen_par_wb_word1 (
      .odd_par  (1'b0),
      .chk_dat  ({cur_db2_out_axi[63:32],cur_db2_out_nxt_axi[47:32]}),
      .chk_par  ({cur_db2_out_axi_par[7:4],cur_db2_out_nxt_axi_par[5:4]}),
      .new_dat  (ar2al_fifo_in[p_ar2al_dwidth-1:0]),
      .dat_out  (),
      .par_out  (ar2al_fifo_in[p_ar2al_width-1:p_ar2al_dwidth]),
      .chk_err  ()
    );
    
    // Check parity of ar2al_fifo_out.
    cdnsdru_asf_parity_check_v1 #(
      .p_data_width (p_ar2al_dwidth)
    ) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (ar2al_fifo_out[p_ar2al_dwidth-1:0]),
      .parity_in  (ar2al_fifo_out[p_ar2al_width-1:p_ar2al_dwidth]),
      .parity_err (dap_err_ar2al_fifo)
    );
  end else begin : gen_no_ar2al_par
    assign dap_err_ar2al_fifo = 1'b0;
  end
  endgenerate
  
  generate if (p_edma_lso == 1'b1) begin: gen_ar2al_fifo
    edma_gen_fifo #( .FIFO_WIDTH(p_ar2al_width),
                   .FIFO_DEPTH(p_axi_access_pipeline_depth),
                   .FIFO_ADDR_WIDTH(p_axi_access_pipeline_bits)
                  ) i_ar_to_al_fifo (
      .qout       (ar2al_fifo_out),
      .qempty     (),
      .qfull      (),
      .qlevel     (),
      .clk_pcie   (aclk),
      .rst_n      (n_areset),
      .din        (ar2al_fifo_in),
      .push       (ar2al_push),
      .flush      (~enable_tx || flush_tx_rd_fifos),
      .pop        (ar2al_pop)
    );
  end else begin: no_gen_ar2al_fifo
    assign ar2al_fifo_out = {p_ar2al_width{1'b0}};
  end
  endgenerate  

  assign ar2al_push = arrv_data && (ar_tcp_hdr || ar_udp_hdr) && ar_first_req_of_buf;

  assign ar2al_pop  = al_pop && (al_tcp_hdr || al_udp_hdr) && al_last_burst_of_buf && al_last;



  // Pass parameters for use by header modification logic to AR2R FIFO
  assign  ar_hdr_len          = cur_db2_out_axi[45:32];
  assign  ar_pyld_len         = cur_db2_out_nxt_axi[45:32];
  assign  ar_udp_hdr          = cur_db2_out_axi_gh && (cur_db2_out_axi[50:49] == 2'b01);
  assign  ar_tcp_hdr          = cur_db2_out_axi_gh && cur_db2_out_axi[50];
  assign  ar_tcp_st_id        = cur_db2_out_axi[57:56];
  assign  ar_tcp_sn_sel       = cur_db2_out_axi[51];
  assign  ar_1st_hdr          = cur_db2_out_axi_fh;
  assign  ar_last_hdr         = cur_db2_out_axi_lh;
  assign  ar_queue_data       = cur_db2_axi_queue;
  assign  ar_first_req_of_buf = drd_sm_cs == DRD_CHK_DESCR;
  assign  ar_last_req_of_buf  = (num_tx_beats_remaining <= {4'h0, data_len});


  // Mark first beat of burst in incoming data
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      r_1st_beat <= 1'd1;
    else
      if (~enable_tx || flush_tx_rd_fifos)
        r_1st_beat <= 1'd1;
      else
        if (rrv_data)
          r_1st_beat <= rlast;
  end

  // Mark first beat of buffer in incoming data
  assign r_1st_beat_of_buf = r_1st_beat && r_first_burst_of_buf;

  // Mark first beat of burst in rdata_al register
  generate if (p_edma_lso == 1'b1) begin : gen_al_1st_beat
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      al_1st_beat <= 1'd1;
    else
      if (~enable_tx || flush_tx_rd_fifos)
        al_1st_beat <= 1'd1;
      else
        if (al_pop)
          al_1st_beat <= al_last;
  end

  // Calculate number of 32-bit words in 1st beat of read data
  // - dependent on data bus width
  // - value is number of words - 1, and is therefore
  //   byte number of ms word in beat
  reg   [11:0]  words_1st_beat;
  always @ *
  begin
    case (dma_bus_width)
      2'b00   : words_1st_beat = 12'd0;
      2'b01   : words_1st_beat = 12'd1;
      default : words_1st_beat = 12'd3;
    endcase
  end

  // Count incoming rdata_al bytes
  // Separate counters for byte ID of MS and LS bytes in stripe
  
  wire [12:0] al_ms_word_id_p1;
  wire [12:0] al_ms_word_id_p2;
  wire [12:0] al_ms_word_id_p4;
  wire [12:0] al_ls_word_id_p1;
  wire [12:0] al_ls_word_id_p2;
  wire [12:0] al_ls_word_id_p4;
  assign      al_ms_word_id_p1 = al_ms_word_id + 12'd1;
  assign      al_ms_word_id_p2 = al_ms_word_id + 12'd2;
  assign      al_ms_word_id_p4 = al_ms_word_id + 12'd4;
  assign      al_ls_word_id_p1 = al_ls_word_id + 12'd1;
  assign      al_ls_word_id_p2 = al_ls_word_id + 12'd2;
  assign      al_ls_word_id_p4 = al_ls_word_id + 12'd4;
  
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      al_ms_word_id <= 12'd0;
      al_ls_word_id <= 12'd0;
    end
    else
      if (~enable_tx || flush_tx_rd_fifos)
      begin
        al_ms_word_id <= 12'd0;
        al_ls_word_id <= 12'd0;
      end
      else
      if (al_push && ((r_1st_beat_of_buf && rdata_align && ~res_full) || (res_1st_beat_of_buf && res_full)))
      begin
        if (r_tcp_hdr || r_udp_hdr)
        begin
          al_ms_word_id <= words_1st_beat;
          al_ls_word_id <= 12'd0;
        end
        else
        begin
          al_ms_word_id <= 12'd0;
          al_ls_word_id <= 12'd0;
        end
      end
      else
        if ((al_push && ~res_only && (r_tcp_hdr || r_udp_hdr)) ||
            (al_push && res_only && (res_tcp_hdr || res_udp_hdr)))
        begin
          case (dma_bus_width)
            2'b00   : al_ms_word_id <= al_ms_word_id_p1[11:0];
            2'b01   : al_ms_word_id <= al_ms_word_id_p2[11:0];
            default : al_ms_word_id <= al_ms_word_id_p4[11:0];
          endcase

          case (dma_bus_width)
            2'b00   : al_ls_word_id <= al_ls_word_id_p1[11:0];
            2'b01   : al_ls_word_id <= al_ls_word_id_p2[11:0];
            default : al_ls_word_id <= al_ls_word_id_p4[11:0];
          endcase
        end
  end

  // Calculate word positions and get values of of fields of interest in incoming
  // header
  // Fields which have an effect on other fields may or may not be
  // in the same beat depending on bus width so must use immediate and stored
  // versions of values and flags and select accordingly
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      byte12_r <= 8'd0;
      byte13_r <= 8'd0;
      byte16_r <= 8'd0;
      byte17_r <= 8'd0;
      byte20_r <= 8'd0;
      byte21_r <= 8'd0;
    end
    else
    begin
      if (|byte15_12_trig && al_pop)
        {byte12_r, byte13_r}  <= {byte12, byte13};

      if (|byte19_16_trig && al_pop)
        {byte16_r, byte17_r}  <= {byte16, byte17};

      if (|byte23_20_trig && al_pop)
        {byte20_r, byte21_r}  <= {byte20, byte21};
    end
  end
  end else begin : gen_no_bytes
    wire zero;
    assign zero = 1'b0;
    always @(zero)
    begin
      byte12_r = {8{zero}};
      byte13_r = {8{zero}};
      byte16_r = {8{zero}};
      byte17_r = {8{zero}};
      byte20_r = {8{zero}};
      byte21_r = {8{zero}};
      al_1st_beat = zero;
      al_ls_word_id = {12{zero}};
      al_ms_word_id = {12{zero}};
    end
  end
  endgenerate

  assign byte12 = |byte15_12_trig ? byte12_hdr : byte12_r;
  assign byte13 = |byte15_12_trig ? byte13_hdr : byte13_r;

  assign byte16 = |byte19_16_trig ? byte16_hdr : byte16_r;
  assign byte17 = |byte19_16_trig ? byte17_hdr : byte17_r;

  assign byte20 = |byte23_20_trig ? byte20_hdr : byte20_r;
  assign byte21 = |byte23_20_trig ? byte21_hdr : byte21_r;

  assign vlan   = |byte15_12_trig ? ({byte12, byte13} == 16'h8100) : vlan_r;

  assign svlan  = |byte15_12_trig ? ({byte12, byte13} == 16'h88a8) : svlan_r;


  generate if (p_edma_lso == 1'b1) begin : gen_vlan
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      vlan_r    <= 1'd0;
      svlan_r   <= 1'd0;
    end
    else
    if (|byte15_12_trig  && al_pop)
    begin
      vlan_r   <= vlan;
      svlan_r  <= svlan;
    end
  end
  end else begin : gen_no_vlan
    wire zero;
    assign zero = 1'b0;
    always @(zero)
    begin
      vlan_r = zero;
      svlan_r = zero;
    end
  end
  endgenerate

  always @ *
  begin
    if (vlan && ~svlan)
    // vlan only
    begin
      ethertype_trig = byte19_16_trig;
      eth_hdr_len    = 12'd3  + 12'd1;
      ethertype      = {byte16, byte17};
    end
    else
      if (svlan)
      // svlan only
      begin
        ethertype_trig = byte23_20_trig;
        eth_hdr_len    = 12'd3  + 12'd2;
        ethertype      = {byte20, byte21};
      end
      else // no vlsn or svlan
      begin
        ethertype_trig = byte15_12_trig;
        eth_hdr_len    = 12'd3;
        ethertype      = {byte12, byte13};
      end
  end

  // Detect IPv4 or IPv6 from ethertype
  always @ *
  begin
    if (|ethertype_trig)
    begin
      ipv4 = (ethertype == 16'h0800);
      ipv6 = (ethertype == 16'h86dd);
    end
    else
    begin
      ipv4 = ipv4_r;
      ipv6 = ipv6_r;
    end
  end

  generate if (p_edma_lso == 1'b1) begin : gen_ip
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      ipv4_r <= 1'd0;
      ipv6_r <= 1'd0;
    end
    else
    begin
      if (|ethertype_trig && al_pop)
      begin
        ipv4_r <= ipv4;
        ipv6_r <= ipv6;
      end
    end
  end
  end else begin : gen_no_ip
    wire zero;
    assign zero = 1'b0;
    always @(zero)
    begin
      ipv4_r = zero;
      ipv6_r = zero;
    end
  end
  endgenerate


  // Calculate IPv4 field positions from ethernet header length
  // Positions are for 32-bit words
  assign ipv4_ihl_pstn    = eth_hdr_len;
  assign ipv4_tl_pstn     = eth_hdr_len + 12'd1;
  assign ipv4_fo_pstn     = eth_hdr_len + 12'd2;

  // Capture ipv4 header length value
  // No conversion required as already relates to 32-bit words
  generate if (p_edma_lso == 1'b1) begin : gen_ipv4_hdr_len
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      ipv4_hdr_len <= 12'd5;
    else
      if (al_pop && al_first_burst_of_buf && al_1st_beat && ~|ipv4_ihl_trig)
        // Load with default value at start of each data buffer
        ipv4_hdr_len <= 12'd5;
      else
        if (|ipv4_ihl_trig && al_pop)
          ipv4_hdr_len <= {8'd0, ipv4_ihl[3:0]};
  end
  end else begin : gen_no_gen_ipv4_hdr_len
    wire zero;
    assign zero = 1'b0;
    always @(zero) ipv4_hdr_len = {12{zero}};
  end
  endgenerate

  // Calculate IPv6 field positions from ethernet header length
  // Positions are for 32-bit words
  assign ipv6_pl_pstn     = eth_hdr_len + 12'd1;
  assign ipv6_hdr_nh_pstn = eth_hdr_len + 12'd2;
  assign ipv6_hdr_len     = 12'd10;


  // Calculate TCP field positions from ethernet header length
  // and IPv4/IPv6 header length
  // Positions are for 32-bit words
  // Need to consider case where IPv6 has header extensions and last header extension is
  // 8 bytes long - in this case the header extension and upper half of the sequence number can occur
  // in the same stripe if the data bus width is 128 bits
  
  wire [12:0] eth_hdr_len_p_ipv4_hdr_len;
  wire [12:0] eth_hdr_len_p_ipv6_hdr_len;
  wire [13:0] eth_hdr_len_p_ipv6_ttl_hdr_len;
    
  wire [13:0] eth_hdr_len_p_ipv4_hdr_len_p1;
  wire [13:0] eth_hdr_len_p_ipv4_hdr_len_p2;
  wire [13:0] eth_hdr_len_p_ipv4_hdr_len_p3;
  
  wire [14:0] eth_hdr_len_p_ipv6_ttl_hdr_len_p1;
  wire [14:0] eth_hdr_len_p_ipv6_ttl_hdr_len_p2;
  wire [14:0] eth_hdr_len_p_ipv6_ttl_hdr_len_p3;
  wire [14:0] eth_hdr_len_p_ipv6_ttl_hdr_len_p4;
  wire [14:0] eth_hdr_len_p_ipv6_ttl_hdr_len_p5;
  
  assign      eth_hdr_len_p_ipv4_hdr_len        = eth_hdr_len + ipv4_hdr_len;
  assign      eth_hdr_len_p_ipv4_hdr_len_p1     = eth_hdr_len_p_ipv4_hdr_len + 13'd1;
  assign      eth_hdr_len_p_ipv4_hdr_len_p2     = eth_hdr_len_p_ipv4_hdr_len + 13'd2;
  assign      eth_hdr_len_p_ipv4_hdr_len_p3     = eth_hdr_len_p_ipv4_hdr_len + 13'd3;
  
  assign      eth_hdr_len_p_ipv6_hdr_len        = eth_hdr_len + ipv6_hdr_len;
  assign      eth_hdr_len_p_ipv6_ttl_hdr_len    = eth_hdr_len_p_ipv6_hdr_len + {1'b0,ipv6_ttl_ehdr_len};
  
  assign      eth_hdr_len_p_ipv6_ttl_hdr_len_p1 = eth_hdr_len_p_ipv6_ttl_hdr_len + 14'd1;
  assign      eth_hdr_len_p_ipv6_ttl_hdr_len_p2 = eth_hdr_len_p_ipv6_ttl_hdr_len + 14'd2;
  assign      eth_hdr_len_p_ipv6_ttl_hdr_len_p3 = eth_hdr_len_p_ipv6_ttl_hdr_len + 14'd3;
  assign      eth_hdr_len_p_ipv6_ttl_hdr_len_p4 = eth_hdr_len_p_ipv6_ttl_hdr_len + 14'd4;
  assign      eth_hdr_len_p_ipv6_ttl_hdr_len_p5 = eth_hdr_len_p_ipv6_ttl_hdr_len + 14'd5;
  
  always @(*)
  begin
    if (ipv4)
    begin
      tcp_sn_byte3_2_pstn = eth_hdr_len_p_ipv4_hdr_len_p1[11:0];
      tcp_sn_byte1_0_pstn = eth_hdr_len_p_ipv4_hdr_len_p2[11:0];
      tcp_fl_pstn         = eth_hdr_len_p_ipv4_hdr_len_p3[11:0];
    end
    else if (ipv6_ehdr_seq_num)
    begin
      tcp_sn_byte3_2_pstn = eth_hdr_len_p_ipv6_ttl_hdr_len_p3[11:0];
      tcp_sn_byte1_0_pstn = eth_hdr_len_p_ipv6_ttl_hdr_len_p4[11:0];
      tcp_fl_pstn         = eth_hdr_len_p_ipv6_ttl_hdr_len_p5[11:0];
    end
    else
    begin
      tcp_sn_byte3_2_pstn = eth_hdr_len_p_ipv6_ttl_hdr_len_p1[11:0];
      tcp_sn_byte1_0_pstn = eth_hdr_len_p_ipv6_ttl_hdr_len_p2[11:0];
      tcp_fl_pstn         = eth_hdr_len_p_ipv6_ttl_hdr_len_p3[11:0];
    end
  end

  //==========================================================
  // Generate trigger signal when 32-bit word of interest is
  // present in current read data beat.
  // 4-bit trigger indicates which word lane of the data bus the
  // word of interest is in.
  // Only bottom bit of trigger is active for 32-bit data bus and
  // only bottom 2 bits of trigger are active for 64-bit data bus
  // Also output values of words which are required for
  // header decode or loading sequence number counters
  // various byte of the output words are of no interest
  //  - these connect to the unused* signals
  //==========================================================

  // Ethernet header fields
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_byte15_12 (
    .enable         (1'b1),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (12'd3),
    .trig           (byte15_12_trig),
    .data_word      ({unused1, unused0, byte13_hdr, byte12_hdr})
  );

  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_byte19_16 (
    .enable         (1'b1),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (12'd4),
    .trig           (byte19_16_trig),
    .data_word      ({unused3, unused2, byte17_hdr, byte16_hdr})
  );

  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_byte23_20 (
    .enable         (1'b1),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (12'd5),
    .trig           (byte23_20_trig),
    .data_word      ({unused5, unused4, byte21_hdr, byte20_hdr})
  );

  // IPv4 Internet Header Length
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_ipv4_ihl (
    .enable         (ipv4),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (ipv4_ihl_pstn),
    .trig           (ipv4_ihl_trig),
    .data_word      ({unused8, ipv4_ihl, unused7, unused6})

  );

  // IPv4 Total Length
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_ipv4_tl (
    .enable         (ipv4),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (ipv4_tl_pstn),
    .trig           (ipv4_tl_trig),
    .data_word      ()

  );

  // IPv4 Fragment Offset
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_ipv4_fo (
    .enable         (ipv4),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (ipv4_fo_pstn[11:0]),
    .trig           (ipv4_fo_trig),
    .data_word      ({unused11, unused10, unused9, ipv4_fo_byte1_hdr})

  );

  // IPv6 Payload Length
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_ipv6_pl (
    .enable         (ipv6),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (ipv6_pl_pstn),
    .trig           (ipv6_pl_trig),
    .data_word      ()

  );

  // TCP Sequence Number - upper 16 bits
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_tcp_sn_3_2 (
    .enable         (tcp_parse_enable),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (tcp_sn_byte3_2_pstn),
    .trig           (tcp_sn_byte3_2_trig),
    .data_word      ({tcp_sn_byte2_hdr, tcp_sn_byte3_hdr, unused13, unused12})

  );

  // TCP Sequence Number - lower 16 bits
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_tcp_sn_1_0 (
    .enable         (tcp_parse_enable),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (tcp_sn_byte1_0_pstn),
    .trig           (tcp_sn_byte1_0_trig),
    .data_word      ({unused15, unused14, tcp_sn_byte0_hdr, tcp_sn_byte1_hdr})

  );

  // TCP Flags
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_tcp_sn (
    .enable         (tcp_parse_enable),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (tcp_fl_pstn),
    .trig           (tcp_fl_trig),
    .data_word      ({tcp_fl_byte0_hdr, tcp_fl_byte1_hdr, unused17, unused16})

  );

  // IPv6 Next Header field in main header
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_ipv6_hdr_nh (
    .enable         (ipv6),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (ipv6_hdr_nh_pstn[11:0]),
    .trig           (ipv6_hdr_nh_trig),
    .data_word      ({unused20, unused19, unused18, ipv6_hdr_nh})

  );

  // IPv6 Extension header next header and header length fields
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_ehdr (
    .enable         (ipv6_ehdr),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (ipv6_ehdr_pstn),
    .trig           (ipv6_ehdr_trig),
    .data_word      ({ipv6_ehdr_ehl, ipv6_ehdr_nh, unused22, unused21})

  );

  // IPv6 speculative Extension header next header and header length fields
  // Required for 128bit data bus as 2 extension headers can be contained within
  // the same stripe
  edma_pbuf_axi_fe_hdr_parse i_hdr_parse_ehdr2 (
    .enable         (ipv6_ehdr),
    .rdata          (rdata_al[127:0]),
    .dma_bus_width  (dma_bus_width),
    .ls_word_id     (al_ls_word_id),
    .ms_word_id     (al_ms_word_id),
    .word_pstn      (ipv6_ehdr_pstn + 12'd2),
    .trig           (ipv6_ehdr2_trig),
    .data_word      ({ipv6_ehdr2_ehl, ipv6_ehdr2_nh, unused24, unused23})

  );

  //============================================================================
  // IPv6 header extensions
  //============================================================================

  // Validate output from second extension header parser
  // Only valid if main extrension header parser indicated a length of 8
  // bytes and that the next header was another extension header
  assign ipv6_ehdr2_valid = |ipv6_ehdr_trig &&
                            (ipv6_ehdr_nh != 8'd06) &&
                            (ipv6_ehdr_ehl == 8'd0);

  // IPv6 Extension header flag
  // Set when next header field in IPv6 header indciates non-TCP header
  // Clear when next header field in extension header indciates TCP header
  generate if (p_edma_lso == 1'b1) begin : gen_ipv6
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      ipv6_ehdr <= 1'd0;
    else
      if (al_pop && al_first_burst_of_buf && al_1st_beat)
        // clear at start of header
        // can only occur if previous header was errored
        //  - had extension headers but no next header field with TCP value
        ipv6_ehdr <= 1'd0;
      else
        if (|ipv6_hdr_nh_trig && al_pop && ipv6_hdr_nh != 8'd06)
          // set if IPv6 header next header flag isn't TCP
          ipv6_ehdr <= 1'd1;
        else
          if (|ipv6_ehdr_trig && al_pop && ipv6_ehdr_nh == 8'd06)
            // clear if IPv6 extension header next header flag is TCP
            ipv6_ehdr <= 1'd0;
          else
            if (ipv6_ehdr2_valid && |ipv6_ehdr2_trig && al_pop && ipv6_ehdr2_nh == 8'd06)
              // clear if 2 IPv6 extension headers in stripe and
              // next header field of second extension header is TCP
              ipv6_ehdr <= 1'd0;
  end

  // IPv6 Extension header start position
  
  wire [12:0] eth_hdr_len_p10;
  wire [12:0] ipv6_ehdr_pstn_p2;
  wire [13:0] ipv6_ehdr_pstn_p2_p_ehdr2_len;
  wire [12:0] ipv6_ehdr_pstn_p_ehdr_len;
  
  assign      eth_hdr_len_p10               = eth_hdr_len       + 12'd10;
  assign      ipv6_ehdr_pstn_p2             = ipv6_ehdr_pstn    + 12'd2;
  assign      ipv6_ehdr_pstn_p2_p_ehdr2_len = ipv6_ehdr_pstn_p2 + {1'b0,ipv6_ehdr2_len};
  assign      ipv6_ehdr_pstn_p_ehdr_len     = ipv6_ehdr_pstn    + ipv6_ehdr_len;
  
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      ipv6_ehdr_pstn <= 12'hfff;
    end
    else
      if (al_pop && al_first_burst_of_buf && al_1st_beat)
        // Set to max value at start of packet so
        // parser will not trigger until IPv6 header parsed
        ipv6_ehdr_pstn <= 12'hfff;
      else
        if (al_pop && |ipv6_hdr_nh_trig && ipv6_hdr_nh != 8'd06)
          // Set to end of IPv6 header if next header field does not
          // indiocate IPv4
          ipv6_ehdr_pstn <= eth_hdr_len_p10[11:0];
        else
          // Add on both extension header lengths if 2 extension headers start in the same stripe
          if (al_pop && ipv6_ehdr && ipv6_ehdr2_valid && |ipv6_ehdr2_trig)
            ipv6_ehdr_pstn  <= ipv6_ehdr_pstn_p2_p_ehdr2_len[11:0];
          else
            // Add on extension header length at start of extension header
            if (al_pop && |ipv6_ehdr_trig)
              ipv6_ehdr_pstn  <= ipv6_ehdr_pstn_p_ehdr_len[11:0];
  end
  
  wire [13:0] ipv6_ttl_ehdr_len_1;
  wire [12:0] ipv6_ttl_ehdr_len_2;
  assign      ipv6_ttl_ehdr_len_1 = ipv6_ttl_ehdr_len + ipv6_ehdr_len + ipv6_ehdr2_len;
  assign      ipv6_ttl_ehdr_len_2 = ipv6_ttl_ehdr_len + ipv6_ehdr_len;
  
  // IPv6 Extension header total length count
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      ipv6_ttl_ehdr_len  <= 12'd0;
    else
      if (al_pop && al_first_burst_of_buf && al_1st_beat)
        // clear at start of buffer data
        ipv6_ttl_ehdr_len <= 12'd0;
      else
        if (al_pop && ipv6_ehdr && ipv6_ehdr2_valid && |ipv6_ehdr2_trig)
          // Add length of both extension headers
          ipv6_ttl_ehdr_len <= ipv6_ttl_ehdr_len_1[11:0];
        else
          if (al_pop && ipv6_ehdr && |ipv6_ehdr_trig)
            // Add length of extension headers
            ipv6_ttl_ehdr_len <= ipv6_ttl_ehdr_len_2[11:0];
  end
  end else begin : gen_no_ipv6
    wire   zero;
    assign zero = 1'b0;
    always @(*)
    begin
      ipv6_ttl_ehdr_len = {12{zero}};
      ipv6_ehdr_pstn    = {12{zero}};
      ipv6_ehdr         = zero;
    end
  end
  endgenerate
  
  wire [8:0] ipv6_ehdr_ehl_p1;
  wire [8:0] ipv6_ehdr2_ehl_p1;
  wire [9:0] ipv6_ehdr_ehl_p1_shifted;
  wire [9:0] ipv6_ehdr2_ehl_p1_shifted;
  
  assign ipv6_ehdr_ehl_p1          = ipv6_ehdr_ehl  + 8'd1;
  assign ipv6_ehdr2_ehl_p1         = ipv6_ehdr2_ehl + 8'd1;
  assign ipv6_ehdr_ehl_p1_shifted  = {ipv6_ehdr_ehl_p1,1'b0};  
  assign ipv6_ehdr2_ehl_p1_shifted = {ipv6_ehdr2_ehl_p1,1'b0};
  
  assign ipv6_ehdr_len  = {2'd0, ipv6_ehdr_ehl_p1_shifted};
  assign ipv6_ehdr2_len = {2'd0, ipv6_ehdr2_ehl_p1_shifted};

  // Flag if final extension header is 8 bytes and sequence number is contained in
  // the same stripe on 128-bit data bus. Extension header must start in 1st word
  // of data bus
  assign ipv6_ehdr_seq_num = (ipv6_ehdr_trig == 4'd1) &&
                             (ipv6_ehdr_nh  == 8'd06) &&
                             (ipv6_ehdr_ehl == 8'd0);


  // generate enable for TCP sequence number and flags parsers
  assign tcp_parse_enable = ipv4 || (ipv6 && (~ipv6_ehdr || ipv6_ehdr_seq_num));

  // Sequence number counters
  // 1 counter per stream, 4 streams per queue
  // The counter load and increment events cannot occur simultaneously as the sequence
  // number is in at least the 3rd beat of the header
  generate if (p_edma_lso == 1'b1) begin : gen_seq_num_st
    wire [32:0] seq_num_st0_ctr_tmp [15:0];
    wire [32:0] seq_num_st1_ctr_tmp [15:0];
    wire [32:0] seq_num_st2_ctr_tmp [15:0];
    wire [32:0] seq_num_st3_ctr_tmp [15:0];
    
    genvar gen_a;
    for (gen_a = 0; gen_a < p_num_queues; gen_a = gen_a + 1) begin: gen_seq_num_st_ctr
      assign seq_num_st0_ctr_tmp[gen_a] = seq_num_st0_ctr_pad[gen_a] + {18'd0,sn_fo_inc_pyld_len};
      assign seq_num_st1_ctr_tmp[gen_a] = seq_num_st1_ctr_pad[gen_a] + {18'd0,sn_fo_inc_pyld_len};
      assign seq_num_st2_ctr_tmp[gen_a] = seq_num_st2_ctr_pad[gen_a] + {18'd0,sn_fo_inc_pyld_len};
      assign seq_num_st3_ctr_tmp[gen_a] = seq_num_st3_ctr_pad[gen_a] + {18'd0,sn_fo_inc_pyld_len};
    end
  
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      for (int_u = 0; int_u < p_num_queues; int_u = int_u + 1)
      begin
        seq_num_st0_ctr[int_u] <= 32'd0;
        seq_num_st1_ctr[int_u] <= 32'd0;
        seq_num_st2_ctr[int_u] <= 32'd0;
        seq_num_st3_ctr[int_u] <= 32'd0;
      end
    else
      if (~enable_tx || flush_tx_rd_fifos)
      for (int_u = 0; int_u < p_num_queues; int_u = int_u + 1)
      begin
        seq_num_st0_ctr[int_u] <= 32'd0;
        seq_num_st1_ctr[int_u] <= 32'd0;
        seq_num_st2_ctr[int_u] <= 32'd0;
        seq_num_st3_ctr[int_u] <= 32'd0;
      end
      else
        if (al_tcp_hdr && al_1st_hdr && ~al_tcp_sn_sel && al_pop)
        begin
          for (int_u = 0; int_u < p_num_queues; int_u = int_u + 1)
            if (int_u[3:0] == al_queue)
            // Load counter from header field value
            case (al_tcp_st_id)
              2'd0 :
              begin
                if (|tcp_sn_byte1_0_trig)
                  seq_num_st0_ctr[int_u][15:0]  <= {tcp_sn_byte1_hdr, tcp_sn_byte0_hdr};

                if (|tcp_sn_byte3_2_trig)
                  seq_num_st0_ctr[int_u][31:16] <= {tcp_sn_byte3_hdr, tcp_sn_byte2_hdr};
              end

              2'd1 :
              begin
                if (|tcp_sn_byte1_0_trig)
                  seq_num_st1_ctr[int_u][15:0]  <= {tcp_sn_byte1_hdr, tcp_sn_byte0_hdr};

                if (|tcp_sn_byte3_2_trig)
                  seq_num_st1_ctr[int_u][31:16] <= {tcp_sn_byte3_hdr, tcp_sn_byte2_hdr};
              end

              2'd2 :
              begin
                if (|tcp_sn_byte1_0_trig)
                  seq_num_st2_ctr[int_u][15:0]  <= {tcp_sn_byte1_hdr, tcp_sn_byte0_hdr};

                if (|tcp_sn_byte3_2_trig)
                  seq_num_st2_ctr[int_u][31:16] <= {tcp_sn_byte3_hdr, tcp_sn_byte2_hdr};
              end

              default :
              begin
                if (|tcp_sn_byte1_0_trig)
                  seq_num_st3_ctr[int_u][15:0]  <= {tcp_sn_byte1_hdr, tcp_sn_byte0_hdr};

                if (|tcp_sn_byte3_2_trig)
                  seq_num_st3_ctr[int_u][31:16] <= {tcp_sn_byte3_hdr, tcp_sn_byte2_hdr};
              end
            endcase
        end
        else
          for (int_u = 0; int_u < p_num_queues; int_u = int_u + 1)
            if (sn_inc && int_u[3:0] == sn_fo_inc_queue)
              // Increment counter with payload length value
              case (sn_inc_st_id)
                2'd0    : seq_num_st0_ctr[int_u] <= seq_num_st0_ctr_tmp[int_u][31:0];
                2'd1    : seq_num_st1_ctr[int_u] <= seq_num_st1_ctr_tmp[int_u][31:0];
                2'd2    : seq_num_st2_ctr[int_u] <= seq_num_st2_ctr_tmp[int_u][31:0];
                default : seq_num_st3_ctr[int_u] <= seq_num_st3_ctr_tmp[int_u][31:0];
              endcase
    end
  end else begin : gen_no_seq_num_st
    wire zero;
    assign zero = 1'b0;
    always @(zero)
    begin
      for (int_u = 0; int_u < p_num_queues; int_u = int_u + 1)
      begin
        seq_num_st0_ctr[int_u]  = {32{zero}};
        seq_num_st1_ctr[int_u]  = {32{zero}};
        seq_num_st2_ctr[int_u]  = {32{zero}};
        seq_num_st3_ctr[int_u]  = {32{zero}};
      end
    end
  end
  endgenerate

  // Depending on data bus widths and header extensions, TCP sequence number and IPv4 fragment
  // offset fields field may or may not be in the last beat of the data read from the header buffer.
  // Therefore, delay the increment of the sequence number and fragmant offset counters
  // for 1 clock cycle to avoid inserting incremented counter values into current header
  generate if (p_edma_lso == 1'b1) begin : gen_sn_inc
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      sn_inc              <= 1'b0;
      fo_inc              <= 1'b0;
      sn_fo_inc_queue     <= 4'd0;
      sn_inc_st_id        <= 2'd0;
      sn_fo_inc_pyld_len  <= 14'd0;
    end
    else
      if (al_pop && al_last && (al_tcp_hdr || al_udp_hdr) && al_last_burst_of_buf)
      begin
        sn_inc              <= al_tcp_hdr;
        sn_inc_st_id        <= al_tcp_st_id;
        fo_inc              <= al_udp_hdr;
        sn_fo_inc_queue     <= al_queue;
        sn_fo_inc_pyld_len  <= al_pyld_len;
      end
      else
      begin
        sn_inc  <= 1'b0;
        fo_inc  <= 1'b0;
      end
  end
  end else begin : gen_no_sn_inc
    wire zero;
    assign zero = 1'b0;
    always @(zero)
    begin
      sn_inc              = zero;
      sn_inc_st_id        = {2{zero}};
      fo_inc              = 1'b0;
      sn_fo_inc_queue     = 4'd0;
      sn_fo_inc_pyld_len  = 14'd0;
    end
  end
  endgenerate


  //============================================================================
  // Calculate IPv4 Fragment Offset and Flags value
  // Required for UFO only
  // The fragment counter clear and increment events can occur simultaneously for
  // different queues as header buffers for different queues can be read
  // consecutively. The events cannot occur simultaneously for the same queue
  // as there must be a data buffer read between 2 header buffer reads
  //============================================================================

  // Fragment offset counter
  // Zero when start of 1st UFO header from large UFO frame is received,
  // then increment by payload length at end of each header
  generate if (p_edma_lso == 1'b1) begin : gen_ipv4_fo_cnt
  reg   [13:0]  ipv4_fo_cnt_nxt [p_num_queues-1:0];
  integer int_g;
  integer int_h;
  always @ (*)
  begin
    for (int_g = 0; int_g < p_num_queues; int_g = int_g + 1)
    begin
      if (fo_inc && int_g == {{28{1'b0}},sn_fo_inc_queue}) // Increment event for queue int_g
        ipv4_fo_cnt_nxt[int_g] = ipv4_fo_cnt[int_g] + (sn_fo_inc_pyld_len >> 3);
      else if (al_udp_hdr && al_1st_hdr && al_first_burst_of_buf && al_pop && (int_g == {{28{1'b0}},al_queue})) // Counter clear event for queue int_g
        ipv4_fo_cnt_nxt[int_g] = 14'd0;
      else
        ipv4_fo_cnt_nxt[int_g] = {1'b0,ipv4_fo_cnt[int_g]};
    end
  end
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      for (int_c = 0; int_c < p_num_queues; int_c = int_c + 1)
        ipv4_fo_cnt[int_c] <= 13'd0;
    end
    else
    begin
      for (int_h = 0; int_h < p_num_queues; int_h = int_h + 1)
        ipv4_fo_cnt[int_h] <= ipv4_fo_cnt_nxt[int_h][12:0];
    end
  end
  end else begin : gen_no_ipv4_fo_cnt
    wire zero;
    assign zero = 1'b0;
    always @(zero)
    begin
      for (int_c = 0; int_c < p_num_queues; int_c = int_c + 1)
        ipv4_fo_cnt[int_c]  = {13{zero}};
    end
  end
  endgenerate


  //========================================================================
  // Modify data stream - TCP sequence number, TCP Flags, IPv4 Total Length,
  // IPv4 Fragment Offset, IPv4 Flags, IPv6 Payload Length
  // Fields can be in 1 of 4 32-bit word positions
  // Offset within 32-bit word does not change as all ethernet,
  // IPv4 and IUPv6 header options/extensions are a mutiple of 4 bytes
  //========================================================================


  // Substitute header fields in incoming data stream
  // Substitute strobes are mutually exclusive so use sum of products to improve
  // timing by avoiding prioroity encoding of case statement or if-then-else
  // Data stream is processed 32 bits at a time, so some bytes are always unmodified
  // Substitution is only active when LSO is enabled via p_edma_lso - therefore
  // when disabled, synthesis will optimise out all logic which generates the
  // alternative values and the substitute strobes

  generate

    if (p_edma_lso == 1)
    begin : gen_lso_hm
      reg  [31:0] rdata_al_word;
      reg  [31:0] cur_seq_num_ctr;
      wire  [3:0] no_sub;
      wire [15:0] ipv4_tl;
      wire [15:0] ipv4_fo;
      wire [15:0] ipv6_pl;
      wire [15:0] tcp_fl;
      wire  [3:0] sub_tcp_sn_byte1_0;
      wire  [3:0] sub_tcp_sn_byte3_2;
      wire  [3:0] sub_tcp_fl;
      wire  [3:0] sub_ipv4_tl;
      wire  [3:0] sub_ipv4_fo;
      wire  [3:0] sub_ipv6_pl;
      wire        mod_tcp_sn;
      wire        mod_tcp_fl;
      wire        mod_ipv4_tl;
      wire        mod_ipv4_fo;
      wire        mod_ipv6_pl;
      integer     int_b;
      
      // Flag which headers require TCP sequence number field modification
      //  - all headers with TSO flag set, except the first header where
      //    sequence number select is low
      assign mod_tcp_sn = al_tcp_hdr && ~(~al_tcp_sn_sel && al_1st_hdr);

      // Flag which headers require TCP flag field modification
      //  - all headers with TSO flag set, except the last header
      assign mod_tcp_fl = al_tcp_hdr && ~al_last_hdr;

      // Flag which heacders require IPv4 total length field modification
      // All IPv4 headers with TSO or UFO flag set
      assign mod_ipv4_tl = ipv4 && (al_tcp_hdr || al_udp_hdr);

      // Flag which heacders required IPv4 fragment offset and flags field modification
      //  - all IPv4 headers with UFO flag set
      assign mod_ipv4_fo = ipv4 && al_udp_hdr;

      // Flag which heacders required IPv6 payload length field modification
      //  - all IPv6 headers with TSO flag set
      assign mod_ipv6_pl = ipv6 && al_tcp_hdr;


      // Clear TCP PSH and FIN flags
      assign tcp_fl  = {tcp_fl_byte1_hdr[7:0], tcp_fl_byte0_hdr[7:4], 1'b0, tcp_fl_byte0_hdr[2:1], 1'b0};

      // Combine triggers and modify flags to create word-specific substitute strobes
      //  - also create word-specific no-substitute signal where no modification is
      //    required for any byte in the 32-bit word
      assign sub_tcp_sn_byte1_0  = tcp_sn_byte1_0_trig & {4{mod_tcp_sn}};
      assign sub_tcp_sn_byte3_2  = tcp_sn_byte3_2_trig & {4{mod_tcp_sn}};
      assign sub_tcp_fl          = tcp_fl_trig         & {4{mod_tcp_fl}};
      assign sub_ipv4_tl         = ipv4_tl_trig        & {4{mod_ipv4_tl}};
      assign sub_ipv4_fo         = ipv4_fo_trig        & {4{mod_ipv4_fo}};
      assign sub_ipv6_pl         = ipv6_pl_trig        & {4{mod_ipv6_pl}};

      assign no_sub = ~sub_tcp_sn_byte1_0  &
                ~sub_tcp_sn_byte3_2  &
                ~sub_tcp_fl          &
                ~sub_ipv4_tl         &
                ~sub_ipv4_fo         &
                ~sub_ipv6_pl;

      //============================================================================
      // Calculate IPv4 Total Length value
      // Required for TSO and UFO
      // Value includes the IP header and IP payload and is in bytes
      // In the case of TSO:
      //  = IP header + TCP header + TCP payload
      //  = (header buffer length - ethernet header length) + payload buffer length
      // In the case of UFO:
      //  = IP header + IP fragment
      //  = (header buffer length - ethernet header length) + payload buffer length
      //============================================================================
      assign ipv4_tl = {2'd0, al_hdr_len} - ((eth_hdr_len[9:0] << 2) + 12'd2) + {2'd0, al_pyld_len};


      //============================================================================
      // Calculate IPv6 Payload Length value
      // Required for TSO only
      // Value includes the IPv6 extension headers and IP payload only and is in bytes
      // In the case of TSO:
      //  = (IPv6 extension headers + TCP header) + TCP payload
      //  = (header buffer length - ethernet header length - main ipv6 header length) + payload buffer length
      //============================================================================
      assign ipv6_pl = {2'd0, al_hdr_len} - ((eth_hdr_len[9:0] << 2) + 12'd2) - 14'd40 + {2'd0, al_pyld_len};


      // Combine fragent offset and flags into 16-bit field
      // MF flag is set for all headers apart from last, DF and RSVD flags are unmodified
      assign ipv4_fo = al_last_hdr ? {ipv4_fo_byte1_hdr[7:5], ipv4_fo_cnt_pad[al_queue]} :
                                 {ipv4_fo_byte1_hdr[7:6], 1'b1,  ipv4_fo_cnt_pad[al_queue]};

      always@(*)
      begin
        // Select sequence number counter for current header using stream and queue ID
        case (al_tcp_st_id)
          2'd0    : cur_seq_num_ctr = seq_num_st0_ctr_pad[al_queue];
          2'd1    : cur_seq_num_ctr = seq_num_st1_ctr_pad[al_queue];
          2'd2    : cur_seq_num_ctr = seq_num_st2_ctr_pad[al_queue];
          default : cur_seq_num_ctr = seq_num_st3_ctr_pad[al_queue];
        endcase
      end

      always@(*)
      begin
        for (int_b = 0; int_b < 4; int_b = int_b + 1)
        begin
          rdata_al_word = rdata_al[32*int_b +: 32];
          rdata_hmod[32*int_b +: 32] = // Lower 16 bits of TCP sequence number
                                       ({rdata_al_word[31:16],
                                         cur_seq_num_ctr[7:0],
                                         cur_seq_num_ctr[15:8]} & {32{sub_tcp_sn_byte1_0[int_b]}}) |

                                       // Upper 16 bits of TCP sequence number
                                       ({cur_seq_num_ctr[23:16],
                                         cur_seq_num_ctr[31:24],
                                         rdata_al_word[15:0]}   & {32{sub_tcp_sn_byte3_2[int_b]}}) |

                                       // TCP flags
                                       ({tcp_fl[7:0],
                                         tcp_fl[15:8],
                                         rdata_al_word[15:0]}   & {32{sub_tcp_fl[int_b]}}) |

                                       // IPv4 Total Length
                                       ({rdata_al_word[31:16],
                                         ipv4_tl[7:0],
                                         ipv4_tl[15:8]}         & {32{sub_ipv4_tl[int_b]}}) |

                                       // IPv4 Fragment Offset and Flags
                                       ({rdata_al_word[31:16],
                                         ipv4_fo[7:0],
                                         ipv4_fo[15:8]}         & {32{sub_ipv4_fo[int_b]}}) |

                                       // IPv6 Payload Length
                                       ({ipv6_pl[7:0],
                                         ipv6_pl[15:8],
                                         rdata_al_word[15:0]}   & {32{sub_ipv6_pl[int_b]}}) |

                                       // No substitution
                                       (rdata_al_word           & {32{no_sub[int_b]}});
        end
      end

    end else begin : gen_no_lso_hm
      always@(*)
      begin
        rdata_hmod = rdata_al[127:0];
      end
    end

    // Check and regenerate parity for rdata_hmod, can only really base on
    // rdata_al as most other fields are not protected.
    if (p_edma_asf_dap_prot == 1) begin : gen_rdata_hmod_par
      gem_par_chk_regen #(.p_chk_dwid (128)) i_regen_rdata_hmod_par (
        .odd_par  (1'b0),
        .chk_dat  (rdata_al[127:0]),
        .chk_par  (rdata_al_par[15:0]),
        .new_dat  (rdata_hmod),
        .dat_out  (),
        .par_out  (rdata_hmod_par),
        .chk_err  (dap_err_rdata_al)
      );
    end else begin : gen_no_rdata_hmod_par
      assign rdata_hmod_par   = 16'h0000;
      assign dap_err_rdata_al = 1'b0;
    end

  endgenerate



  //============================================================================
  // Separate writeback buffers for data, address and interrupt
  // Separate buffers are required as pops are independent, although push is common
  // All 3 buffers are pushed at the same time (when the writeback is accepted
  // from the AHB DMA), but are popped independently
  //   - address FIFO : when the address for the last AXI write of the writeback
  //     is accepted by the AW channel
  //   - data FIFO : when the data for the last AXI write of the writeback
  //     is accepted by the W channel
  // For TSO and UFO frames discard writebacks which bit 14 of word 1 set
  //  - this bit is set for all generated frames apart from the last
  //  - Therefore SW will only see the writeback for the last generated fram from
  //    the large TCP or UDP frame
  //============================================================================

  assign write_back_mask = |tx_descr_wr_data[51:49] && tx_descr_wr_data[46];


  // Clear fragmented packet status for checksum gen when UFO enabled
  // AHB DMA warns that fragment was received, but this isexpected for UDP
  // fragmentation so is not passed back to SW
  always @ *
  begin
    // tx_descr_wr_data orginally contained the following busses ...
    //  assign tx_descr_wr_data = { tx_timestamp,
    //                              descriptor_wb_word1,
    //                              status_word_rd_1}; // ie timestamp, bd word1, bd word0[31:0]
    //
    // Extract timestamp bits out to make life simpler ..
    // Currently, we only protect the timestamp, which is the 42 bits ...
    // i.e. parity in tx_descr_wr_ts_par protects tx_descr_wr_ts
    tx_timestamp       = tx_descr_wr_ts;
    tx_timestamp_par   = tx_descr_wr_ts_par;

    if (tx_descr_wr_data[49] && (tx_descr_wr_data[54:52] == 3'd5))
      tx_descr_wr_data_clean = {tx_descr_wr_data[63:55],
                                3'd0,
                                tx_descr_wr_data[51:0]};
    else
      tx_descr_wr_data_clean = tx_descr_wr_data[63:0];
  end

  // Special case to cope with status that doesnt require a writeback ..
  wire dma_ignore_wb;
  assign dma_ignore_wb = {tx_descr_wr_sts[9:5],tx_descr_wr_sts[0]} == 6'b000010;

  // If writeback is to be discarded don't care about FIFO status
  always @(*)
  begin
    if (flush_tx_wr_fifos)
      tx_descr_wr_rdy = 1'b0;

    // special case to cope with status that doesnt require a writeback ..
    else if (dma_ignore_wb && !wb_int_fifo_empty)
      tx_descr_wr_rdy = 1'b0;

    else
      tx_descr_wr_rdy =     write_back_mask ||
                            (~wb_addr_fifo_full && ~wb_data_fifo_full && ~wb_int_fifo_full) ||
                            (wb_int_fifo_empty && dma_ignore_wb);
  end

  assign wb_fifo_push = tx_descr_wr_vld && tx_descr_wr_rdy && ~write_back_mask && !dma_ignore_wb;

  assign wb_data_fifo_pop = wrv_descr && (w_tx_descr_cnt == (tx_descr_writebacks_num-2'd1));

  assign wb_int_fifo_pop  = brv_descr;

  // Writeback address buffer

  // Assign lower 32-bits of the address. the parity bits are
  // assigned later.
  assign tx_descr_wb_addr[31:0] = tx_descr_wr_data_clean[31:0];

  edma_gen_fifo #(
    .FIFO_WIDTH       (p_awid_par+4),
    .FIFO_DEPTH       (p_axi_tx_descr_wr_buff_depth),
    .FIFO_ADDR_WIDTH  (p_axi_tx_descr_wr_buff_bits)
  ) i_tx_descr_wr_add_fifo (
    .qout       ({aw_queue_descr, wb_addr_fifo_out}),
    .qempty     (wb_addr_fifo_empty),
    .qfull      (wb_addr_fifo_full),
    .qlevel     (),
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        ({tx_descr_wr_sts[4:1],tx_descr_wb_addr}),
    .push       (wb_fifo_push),
    .flush      ((~enable_tx || flush_tx_wr_fifos) && ~(awvalid_descr && ~awready_descr)),
    .pop        (wb_addr_fifo_pop)
  );

  // Writeback data buffer
  // Work out how many bits are required for the writeback buffer. This buffer stores the writeback data and
  // optional timestamp value. If p_edma_asf_dap_prot is set to 1 then these buses will also have parity.
  localparam p_wb_data_bits  = (p_edma_asf_dap_prot == 1)  ? 36  : 32;
  localparam p_wb_ts_bits    = (p_edma_asf_dap_prot == 1)  ? 48  : 42;
  localparam p_wb_buffer_wid = (p_edma_tsu == 1)           ? p_wb_data_bits + p_wb_ts_bits
                                                          : p_wb_data_bits;

  wire  [p_wb_buffer_wid-1:0] wb_data_fifo_in, wb_data_fifo_out;

  // Bottom data bits always exists
  assign wb_data_fifo_in[31:0]  = tx_descr_wr_data_clean[63:32];
  assign wb_data                = wb_data_fifo_out[31:0];

  generate // The optional bits

  // Parity bits for wb_data
  if (p_edma_asf_dap_prot == 1) begin : gen_par
    assign wb_data_fifo_in[35:32] = tx_descr_wr_data_par_clean[7:4];
    assign wb_data_par  = wb_data_fifo_out[35:32];
  end else begin : gen_no_par
    assign wb_data_par  = 4'd0;
  end

  // Timestamp bits
  if (p_edma_tsu == 1) begin : gen_wb_timestamp
    assign wb_data_fifo_in[p_wb_data_bits+41:p_wb_data_bits]  = tx_timestamp;
    assign wb_timestamp = wb_data_fifo_out[p_wb_data_bits+41:p_wb_data_bits];
    if (p_edma_asf_dap_prot == 1) begin : gen_par
      assign wb_data_fifo_in[p_wb_data_bits+47:p_wb_data_bits+42] = tx_timestamp_par;
      assign wb_timestamp_par = wb_data_fifo_out[p_wb_data_bits+47:p_wb_data_bits+42];
    end else begin : gen_no_par
      assign wb_timestamp_par = 6'd0;
    end
  end else begin : gen_no_wb_timestamp
    assign wb_timestamp     = {42{1'b0}};
    assign wb_timestamp_par = 6'd0;
  end
  endgenerate

  edma_gen_fifo #(
    .FIFO_WIDTH       (p_wb_buffer_wid),
    .FIFO_DEPTH       (p_axi_tx_descr_wr_buff_depth),
    .FIFO_ADDR_WIDTH  (p_axi_tx_descr_wr_buff_bits)
  ) i_tx_descr_wr_dat_fifo (
    .qout       (wb_data_fifo_out),
    .qempty     (),
    .qfull      (wb_data_fifo_full),
    .qlevel     (),
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        (wb_data_fifo_in),
    .push       (wb_fifo_push),
    .flush      ((~enable_tx || flush_tx_wr_fifos) && ~(wvalid_descr && ~wready_descr)),
    .pop        (wb_data_fifo_pop)
  );

  // Writeback interrupt buffer
  edma_gen_fifo #(
    .FIFO_WIDTH       (10),
    .FIFO_DEPTH       (p_axi_tx_descr_wr_buff_depth),
    .FIFO_ADDR_WIDTH  (p_axi_tx_descr_wr_buff_bits)
  ) i_tx_descr_wr_int_fifo (
    .qout       (wb_int_fifo_out),
    .qempty     (wb_int_fifo_empty),
    .qfull      (wb_int_fifo_full),
    .qlevel     (wb_int_fifo_fill), // NOTE: This is probed inside tb_sv_coverage, so cannot be deleted even though this is not used in the design
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        (wb_int_fifo_in),
    .push       (wb_fifo_push),
    .flush      (~enable_tx || flush_tx_wr_fifos),
    .pop        (wb_int_fifo_pop)
  );


  //===================================================================================
  // Determine how many AXI writes are required for a descriptor writeback based on
  // extended descriptors, 32/64 bit addressing and data bus width.
  // Also drive writeback data based on the current count.
  // 1 descriptor word must be written for normal descriptors, 3 for extended
  // Address of timestamp words change for 64 vs 32 bit addressing
  //===================================================================================
  always @ *
  begin
    awlen_descr       = 8'h00;

    if (~tx_extended_bd_mode_en)
    begin
      // Note in extended buffer descriptor mode - write 1 descriptor word
      tx_descr_writebacks_num = 2'd1;
      wdata_int         = {4{wb_data}};
      wdata_par_int     = {4{wb_data_par}};
      awsize_descr      = 3'h2;
      wb_addr_fifo_op   = 33'd0;
    end
    else
      // In extended buffer descriptor mode - write 3 descriptor words
      case ({addressing_64b, dma_bus_width})

        3'b0_00 : // extended buffer descriptor, 32-bit addressing, 32-bit data bus
        begin
          tx_descr_writebacks_num = 2'd3;
          case (w_tx_descr_cnt)
            2'd0 :
            begin
              wdata_int     = {4{22'd0, wb_timestamp[41:32]}};  // Timestamp (upper 10 bits)
              wdata_par_int = {4{2'b00,wb_timestamp_par[5:4]}};
            end
            2'd1 :
            begin
              wdata_int     = {4{wb_timestamp[31:0]}};          // Timestamp (lower 32 bits)
              wdata_par_int = {4{wb_timestamp_par[3:0]}};
            end
            default :
            begin
              wdata_int     = {4{wb_data[31:0]}};
              wdata_par_int = {4{wb_data_par}};
            end
          endcase

          case (aw_tx_descr_cnt_r)
            2'd0 :
            begin
              wb_addr_fifo_op    = 33'h100000008;
              awsize_descr       = 3'h2;
            end
            2'd1 :
            begin
              wb_addr_fifo_op    = 33'h100000004;
              awsize_descr       = 3'h2;
            end
            default :
            begin
              wb_addr_fifo_op    = 33'h000000000;
              awsize_descr       = 3'h2;
            end
          endcase

        end

        3'b0_01 : // extended buffer descriptor, 32-bit addressing, 64-bit data bus
        begin
          tx_descr_writebacks_num = 2'd2;
          case (w_tx_descr_cnt)
            2'd0 :
            begin
              wdata_int     = {2{22'd0,wb_timestamp[41:0]}};  // Timestamp (42 bits) padded to 64bits
              wdata_par_int = {2{2'b00,wb_timestamp_par}};
            end
            default :
            begin
              wdata_int     = {4{wb_data[31:0]}};
              wdata_par_int = {4{wb_data_par}};
            end
          endcase

          case (aw_tx_descr_cnt_r)
            2'd0 :
            begin
              wb_addr_fifo_op    = 33'h100000004;
              awsize_descr       = 3'h3;
            end
            default :
            begin
              wb_addr_fifo_op    = 33'h000000000;
              awsize_descr       = 3'h2;
            end
          endcase

        end

        3'b0_10, 3'b0_11 : // extended buffer descriptor, 32-bit addressing, 128-bit data bus
        begin
          tx_descr_writebacks_num = 2'd1;
          wdata_int       = {22'd0, wb_timestamp, // Timestamp 64bits
                            wb_data[31:0],32'd0   // Writeback data
                            };
          wdata_par_int   = {2'b00,wb_timestamp_par,wb_data_par,4'd0};
          wb_addr_fifo_op = 33'h000000004;
          awsize_descr    = 3'h4;

        end

        3'b1_00 : // extended buffer descriptor, 64-bit addressing, 32-bit data bus
        begin
          tx_descr_writebacks_num = 2'd3;
          case (w_tx_descr_cnt)
            2'd0 :
            begin
              wdata_int     = {4{22'd0, wb_timestamp[41:32]}};  // Timestamp (upper 10 bits)
              wdata_par_int = {4{2'b00,wb_timestamp_par[5:4]}};
            end
            2'd1 :
            begin
              wdata_int     = {4{wb_timestamp[31:0]}};          // Timestamp (lower 32 bits)
              wdata_par_int = {4{wb_timestamp_par[3:0]}};
            end
            default :
            begin
              wdata_int     = {4{wb_data[31:0]}};
              wdata_par_int = {4{wb_data_par}};
            end
          endcase

          case (aw_tx_descr_cnt_r)
            2'd0    :
            begin
              wb_addr_fifo_op    = 33'h100000010;
              awsize_descr       = 3'h2;
            end
            2'd1    :
            begin
              wb_addr_fifo_op    = 33'h10000000c;
              awsize_descr       = 3'h2;
            end
            default :
            begin
              wb_addr_fifo_op    = 33'h000000000;
              awsize_descr       = 3'h2;
            end
          endcase

        end

        3'b1_01 : // extended buffer descriptor, 64-bit addressing, 64-bit data bus
        begin
          tx_descr_writebacks_num = 2'd2;
          case (w_tx_descr_cnt)
            2'd0 :
            begin
              wdata_int     = {2{22'd0,wb_timestamp[41:0]}};  // Timestamp (42 bits) padded to 64bits
              wdata_par_int = {2{2'b00,wb_timestamp_par}};
            end
            default :
            begin
              wdata_int     = {4{wb_data[31:0]}};
              wdata_par_int = {4{wb_data_par}};
            end
          endcase

          case (aw_tx_descr_cnt_r)
            2'd0    :
            begin
              wb_addr_fifo_op    = 33'h10000000c;
              awsize_descr       = 3'h3;
            end
            default :
            begin
              wb_addr_fifo_op    = 33'h000000000;
              awsize_descr       = 3'h2;
            end
          endcase
        end

        default : // extended buffer descriptor, 64-bit addressing, 128-bit data bus
        begin  // 3'b1_10
          tx_descr_writebacks_num = 2'd2;
          case (w_tx_descr_cnt)
            2'd0 :
            begin
              wdata_int     = {2{22'd0,wb_timestamp[41:0]}};  // Timestamp (42 bits) padded to 64bits
              wdata_par_int = {2{2'b00,wb_timestamp_par}};
            end
            default :
            begin
              wdata_int     = {4{wb_data[31:0]}};
              wdata_par_int = {4{wb_data_par}};
            end
          endcase

          case (aw_tx_descr_cnt_r)
            2'd0    :
            begin
              wb_addr_fifo_op    = 33'h10000000c;
              awsize_descr       = 3'h3;
            end
            default :
            begin
              wb_addr_fifo_op    = 33'h000000000;
              awsize_descr       = 3'h2;
            end
          endcase
        end

      endcase
  end
  assign awaddr_descr[63:32]    = addressing_64b ? upper_tx_q_base_addr : 32'd0;
  assign awaddr_descr_par[7:4]  = (addressing_64b && (p_edma_asf_dap_prot > 0)) ? upper_tx_q_base_par : 4'h0;

  // The lower address is sum of wb_addr_fifo_out[31:0] and wb_addr_fifo_op.
  // Note that if there was no parity, the in_par to the following module isn't really valid
  // but will be ignored anyway.
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_awaddr_descr (
    .in_val (wb_addr_fifo_out[31:0]),
    .in_par (wb_addr_fifo_out[p_awid_par-1:p_awid_par-4]),
    .op_val (wb_addr_fifo_op[31:0]),
    .op_add (wb_addr_fifo_op[32]),
    .out_val(awaddr_descr[31:0]),
    .out_par(awaddr_descr_par[3:0])
  );

  //Swizzle writeback wdata for endian swap
  always @ *
  begin
    if (endian_swap[0])
      case (dma_bus_width)

        2'b00 : // 32-bit
        begin
          wdata_descr     = {96'd0,
                              wdata_int[7:0],   wdata_int[15:8],
                              wdata_int[23:16], wdata_int[31:24]};
          wdata_descr_par = {12'h000,
                              wdata_par_int[0], wdata_par_int[1],
                              wdata_par_int[2], wdata_par_int[3]};
        end
        2'b01 : // 64-bit
        begin
          wdata_descr     = {64'd0,
                              wdata_int[7:0],   wdata_int[15:8],
                              wdata_int[23:16], wdata_int[31:24],
                              wdata_int[39:32], wdata_int[47:40],
                              wdata_int[55:48], wdata_int[63:56]};
          wdata_descr_par = {8'h00,
                              wdata_par_int[0], wdata_par_int[1],
                              wdata_par_int[2], wdata_par_int[3],
                              wdata_par_int[4], wdata_par_int[5],
                              wdata_par_int[6], wdata_par_int[7]};
        end
        default : // 128-bit
        begin
          wdata_descr     = { wdata_int[7:0],     wdata_int[15:8],
                              wdata_int[23:16],   wdata_int[31:24],
                              wdata_int[39:32],   wdata_int[47:40],
                              wdata_int[55:48],   wdata_int[63:56],
                              wdata_int[71:64],   wdata_int[79:72],
                              wdata_int[87:80],   wdata_int[95:88],
                              wdata_int[103:96],  wdata_int[111:104],
                              wdata_int[119:112], wdata_int[127:120]};
          wdata_descr_par = { wdata_par_int[0],   wdata_par_int[1],
                              wdata_par_int[2],   wdata_par_int[3],
                              wdata_par_int[4],   wdata_par_int[5],
                              wdata_par_int[6],   wdata_par_int[7],
                              wdata_par_int[8],   wdata_par_int[9],
                              wdata_par_int[10],  wdata_par_int[11],
                              wdata_par_int[12],  wdata_par_int[13],
                              wdata_par_int[14],  wdata_par_int[15]};
        end
      endcase
    else
    begin
      wdata_descr     = wdata_int;
      wdata_descr_par = wdata_par_int;
    end
  end

  assign wlast_descr = 1'b1;

  // Registered state members
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      aw_tx_descr_cnt_r <= 2'b00;
    else
      if ((~enable_tx || flush_tx_wr_fifos) && ~(awvalid_descr && ~awready_descr))
        aw_tx_descr_cnt_r <= 2'b00;
      else
        aw_tx_descr_cnt_r <= aw_tx_descr_cnt;
  end

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      w_tx_descr_cnt    <= 2'b00;
    else
      if ((~enable_tx || flush_tx_wr_fifos) && ~(wvalid_descr && ~wready_descr))
        w_tx_descr_cnt    <= 2'b00;
      else
        if (tx_extended_bd_mode_en)
        begin
          if (wrv_descr)
          begin
            if (w_tx_descr_cnt == (tx_descr_writebacks_num-2'd1))
              w_tx_descr_cnt <= 2'b00;
            else
              w_tx_descr_cnt <= w_tx_descr_cnt + 2'b01;
          end
        end
        else
          w_tx_descr_cnt <= 2'b00;
  end


  // Generate pop for the writeback address FIFO
  always @ *
  begin
    // Add defaults to reduce codebase and keep it tidy
    wb_addr_fifo_pop  = 1'b0;
    aw_tx_descr_cnt   = aw_tx_descr_cnt_r;

    // Count how many aw access have occurred and pop on the last aw access.
    if (awrv_descr)
    begin
      wb_addr_fifo_pop = (aw_tx_descr_cnt_r == (tx_descr_writebacks_num-2'd1));
      if (aw_tx_descr_cnt == (tx_descr_writebacks_num-2'd1))
        aw_tx_descr_cnt  = 2'b00;
      else
        aw_tx_descr_cnt  = aw_tx_descr_cnt_r + 2'b01;
    end

  end


  // Writeback signals to AXI arbiter
  assign awvalid_descr = ~wb_addr_fifo_empty;


  // TX Interrupt Generation
  // The signal "tx_descr_wr_vld && tx_descr_wr_rdy" is set to validate the DMA interrupt signals
  // If tx_descr_wr_vld && tx_descr_wr_rdy is set together with the dataphase of a descriptor write, then we buffer
  // the interrupt details into the TX descriptor write buffer.  Further interrupts signalled
  // when we are not writing to the buffer are sampled and stored locally. When the AXI writeback
  // has completed, the buffer is popped and we can issue all the interrupts


  assign wb_int_fifo_in = {tx_descr_wr_sts[9:5],tx_descr_wr_sts[0],tx_descr_wr_sts[4:1]};

  always @(*)
  begin
    if (wb_int_fifo_empty && tx_descr_wr_vld && {tx_descr_wr_sts[9:5],tx_descr_wr_sts[0]} == 6'b000010)
    begin
      reflected_tx_sts_vld = tx_descr_wr_vld;
      reflected_tx_sts     = tx_descr_wr_sts;
    end
    else
    begin
      reflected_tx_sts_vld = wb_int_fifo_pop;
      reflected_tx_sts     = {wb_int_fifo_out[9:5],wb_int_fifo_out[3:0],wb_int_fifo_out[4]};
    end
  end

  // Handling AXI BRESP/RRESP errors
  // Simply pass to gem_registers, signal an interrupt and disable RX / TX
  // Do not forward to AHB
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      disable_tx    <= 1'b0;
    else
      if (~enable_tx)
        disable_tx  <= 1'b0;
      else
        disable_tx  <= disable_tx ||
                       (brv_descr && bresp != 2'b00) ||
                       ((rrv_descr && rresp != 2'b00) && ~ignore_remaining_desc_rds_pad[r_queue]) ||
                       (rrv_data  && rresp != 2'b00);
  end


// -----------------------------------------------------------------------------
// ASF - End to end data path parity protection
// -----------------------------------------------------------------------------


  /////////////////////////////////////////////////
  // ASF - end to end parity check
  genvar g_loop_1;
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_parity
    reg   [15:0]  db1_in_par_hold_r;
    reg   [7:0]   araddr_data_par_r;

    // Store parity bits for db1_in_hold.
    always @ (posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        db1_in_par_hold_r <= 16'h0000;
      else
        if (~enable_tx || flush_tx_rd_fifos)
          db1_in_par_hold_r <= 16'h0000;
        else
          case (mresp_sm_cs)
            MRESP_WORD0 :
              if (rrv_descr)
                db1_in_par_hold_r <= {8'h00,db1_in_par_hold_r[7:4],rdata_descr_par[3:0]};
            MRESP_WORD2 :
              if (rrv_descr)
                db1_in_par_hold_r <= {rdata_descr_par,db1_in_par_hold_r[7:0]};
            MRESP_WORD3_5,
            MRESP_WORD4 :
              if (rrv_descr && tx_extended_bd_mode_en)
                db1_in_par_hold_r <= {rdata_descr_par[3:0],db1_in_par_hold_r[11:0]};
            default     :
              if (rrv_descr)
                db1_in_par_hold_r <= {8'h00,rdata_descr_par};
          endcase
    end

    // Build base address into array for easier access with optional parity protection
    for (g_loop_1=0; g_loop_1 < p_num_queues; g_loop_1 = g_loop_1 + 1)
    begin : gen_base_addr_arr
      assign tx_base_addr_arr[g_loop_1] = {tx_buff_base_par[(g_loop_1*4)+3:(g_loop_1*4)],
                                            tx_buff_base_addr[(g_loop_1*32)+31:(g_loop_1*32)]};
    end

    assign cur_descr_rd_add_par = db2_descr_wb_addr[cur_db2_dma_queue][35:32];

    // tx_descr_wr_data_par_clean is a combinatorial re-gen based on tx_descr_wr_data_clean
    // which is a transform of tx_descr_wr_data.
    gem_par_chk_regen #(.p_chk_dwid (64)) i_regen_tx_descr_wr_data_par (
      .odd_par  (1'b0),
      .chk_dat  (tx_descr_wr_data),
      .chk_par  (tx_descr_wr_data_par),
      .new_dat  (tx_descr_wr_data_clean),
      .dat_out  (),
      .par_out  (tx_descr_wr_data_par_clean),
      .chk_err  (dap_err_tx_descr_wr_data)
    );
    assign tx_descr_wb_addr[35:32] = tx_descr_wr_data_par_clean[3:0];

    assign db1_in_par_hold = db1_in_par_hold_r;

    always @ (posedge aclk or negedge n_areset)
    begin
      if  (~n_areset)
        araddr_data_par_r <= 8'h00;
      else
        if ((drd_sm_cs == DRD_IDLE) && ~db2_empty_axi)
          araddr_data_par_r <= {cur_db2_out_axi_par[11:8],cur_db2_out_axi_par[3:0]};
        else
          if (arrv_data)
            araddr_data_par_r <= araddr_data_nxt_par;
    end
    assign araddr_data_par  = araddr_data_par_r;

  end else begin : gen_no_dp_parity
    for (g_loop_1=0; g_loop_1 < p_num_queues[31:0]; g_loop_1 = g_loop_1 + 1)
    begin : gen_base_addr_arr
      assign tx_base_addr_arr[g_loop_1] = tx_buff_base_addr[(g_loop_1*p_awid_par[31:0])+p_awid_par[31:0]-32'd1:(g_loop_1*p_awid_par[31:0])];
    end
    assign cur_descr_rd_add_par       = 4'h0;
    assign tx_descr_wr_data_par_clean = 8'h00;
    assign dap_err_tx_descr_wr_data   = 1'b0;
    assign db1_in_par_hold            = 16'h0000;
    assign araddr_data_par            = 8'h00;
  end
  endgenerate

  // Signals for lockup detection
  // Generate 1-bit per queue signal to indicate used bit read and full packet written
  genvar g_loop_q;
  generate for (g_loop_q = 0; g_loop_q<p_num_queues[31:0];g_loop_q=g_loop_q+1) begin : gen_lockup_sigs
    assign full_pkt_inc[g_loop_q] = buff_stripe_vld && buff_stripe_last && buff_stripe_rdy &&
                                    cur_descr_rd[47] && (cur_descr_rd_queue == g_loop_q[3:0]);
  end
  endgenerate
  assign lockup_flush = flush_tx_wr_fifos;

  // Gather together ASF fault signals.
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dap_par_chk
    wire  dap_err_cur_descr_rd_add;
    wire  dap_err_wb_addr_fifo_out;
    wire  dap_err_db1_in_hold;
    wire  dap_err_db1_in;
    wire  dap_err_wb_data;
    wire  dap_err_wb_timestamp;
    wire  dap_err_buff_stripe;
    reg   asf_dap_axi_tx_err_r;

    // Parity checkers
    cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk_cur_descr_rd_add (
      .odd_par    (1'b0),
      .data_in    (cur_descr_rd_add),
      .parity_in  (cur_descr_rd_add_par),
      .parity_err (dap_err_cur_descr_rd_add)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk_wb_addr_fifo_out (
      .odd_par    (1'b0),
      .data_in    (wb_addr_fifo_out[31:0]),
      .parity_in  (wb_addr_fifo_out[35:32]),
      .parity_err (dap_err_wb_addr_fifo_out)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_par_chk_db1_in_hold (
      .odd_par    (1'b0),
      .data_in    (db1_in_hold[127:0]),
      .parity_in  (db1_in_par_hold),
      .parity_err (dap_err_db1_in_hold)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_descr_width)) i_par_chk_db1_in (
      .odd_par    (1'b0),
      .data_in    (db1_in),
      .parity_in  (db1_in_par),
      .parity_err (dap_err_db1_in)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk_wb_data (
      .odd_par    (1'b0),
      .data_in    (wb_data),
      .parity_in  (wb_data_par),
      .parity_err (dap_err_wb_data)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(42)) i_par_chk_wb_timestamp (
      .odd_par    (1'b0),
      .data_in    (wb_timestamp),
      .parity_in  (wb_timestamp_par),
      .parity_err (dap_err_wb_timestamp)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_par_chk_ (
      .odd_par    (1'b0),
      .data_in    (buff_stripe),
      .parity_in  (buff_stripe_par),
      .parity_err (dap_err_buff_stripe)
    );

    // Combine and register the DAP error sources.
    always@(posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        asf_dap_axi_tx_err_r  <= 1'b0;
      else
        asf_dap_axi_tx_err_r  <= dap_err_cur_db2_out_dma    |
                                  dap_err_ar2al_fifo        |
                                  dap_err_rdata_al          |
                                  dap_err_tx_descr_wr_data  |
                                  (|dap_err_db1_out)        |
                                  (|dap_err_db2_out)        |
                                  dap_err_cur_descr_rd_add  |
                                  dap_err_wb_addr_fifo_out  |
                                  dap_err_db1_in_hold       |
                                  (dap_err_db1_in &
                                    db1_push)               |
                                  dap_err_wb_data           |
                                  dap_err_wb_timestamp      |
                                  (dap_err_buff_stripe &
                                    buff_stripe_vld);
    end

    assign asf_dap_axi_tx_err = asf_dap_axi_tx_err_r;
  end else begin : gen_no_dap_par_chk
    // This is to avoid synthesis warnings for these unused vectors
    // where the tool sometimes ties them together..
    // All bits of the vectors are tied to 0 in the descriptor buffer
    // module when no ASF parity is configured.
    assign asf_dap_axi_tx_err = |{dap_err_db1_out,dap_err_db2_out};
  end
  endgenerate

// -----------------------------------------------------------------------------

`ifdef ABV_ON

  generate if (p_num_queues > 32'd1) begin : gen_stall_assertion
  // Ensure that dpram_full not set for long period of time indicating potential stalling of the DMA.
  reg [9:0] dpram_full_err_cnt;

  // Inform the underlying DMA when we have a descriptor in the TX descriptor FIFO.
  wire   tx_descr_available;
  assign tx_descr_available = ~db2_empty_dma;


  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      dpram_full_err_cnt  <= 10'h000;
    else
      if (~tx_cutthru && dpram_full && (drd_sm_cs != DRD_IDLE) && tx_descr_available)
        dpram_full_err_cnt  <= dpram_full_err_cnt + 10'h001;
      else
        dpram_full_err_cnt  <= 10'h000;
  end
  property dpram_full_stall_chk;
    @(posedge (aclk))
      dpram_full_err_cnt  < 10'h100;
  endproperty
  AP_dpram_full_stall_chk : assert property (dpram_full_stall_chk);
  end
  endgenerate
`endif

endmodule //edma_pbuf_axi_fe_tx
