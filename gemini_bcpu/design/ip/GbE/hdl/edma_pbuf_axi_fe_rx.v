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
//   Filename:           edma_pbuf_axi_fe_rx.v
//   Module Name:        edma_pbuf_axi_fe_rx
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
//   Description       :      AXI front end driver for RX
//
//------------------------------------------------------------------------------


module edma_pbuf_axi_fe_rx # (

  parameter p_edma_rsc      = 1'b0,
  parameter p_num_queues    = 32'd1,
  parameter p_num_queues_m1 = p_num_queues - 32'd1,

  // The following parameter defines the number of bits used to describe
  // the depth of the FIFO that is needed to keep track of the number
  // of aw or ar accesses being triggered before the accompanying data
  // busses
  //

  parameter p_axi_rx_descr_rd_buff_bits = 4'd2,
  parameter p_axi_rx_descr_rd_buff_depth = 2**p_axi_rx_descr_rd_buff_bits,

  parameter p_axi_rx_descr_wr_buff_bits = 4'd2,
  parameter p_axi_rx_descr_wr_buff_depth = 2**p_axi_rx_descr_wr_buff_bits,

  parameter p_edma_rx_pbuf_addr           = 32'd64,
  parameter p_edma_bus_width              = 32'd64,
  parameter p_edma_bus_pwid               = p_edma_bus_width/8,
  parameter p_edma_addr_width             = 32'd64,
  parameter p_edma_addr_pwid              = p_edma_addr_width/8,
  parameter p_edma_rx_pbuf_data           = 32'd64,

  // RAS - parameters
  parameter p_edma_asf_dap_prot           = 1'b0

) (

  // Constaints
  input                                 aclk,
  input                                 n_areset,

  // AHB RX interfaces
  // 00 - descriptor
  // 02 - data
  // common response signals
  output                         hgrant_00,  //hgrant for master 00
  input  [2:0]                   hburst_00,  //hburst for master 00
  input  [1:0]                   htrans_00,  //htrans for master 00
  input  [2:0]                   hsize_00,   //hsize for master 00
  input                          hwrite_00,  //hwrite for master 00
  input  [p_edma_addr_width-1:0] haddr_00,   //haddr for master 00
  input  [p_edma_addr_pwid-1:0]  haddr_00_par,
  input  [p_edma_bus_width-1:0]  hwdata_00,  //hwdata for master 00
  input  [p_edma_bus_pwid-1:0]   hwdata_00_par,

  input                          hbusreq_02,  //hbusreq for master 02
  output                         hgrant_02,   //hgrant for master 02
  input  [2:0]                   hburst_02,   //hburst for master 02
  input  [1:0]                   htrans_02,   //htrans for master 02
  input  [2:0]                   hsize_02,    //hsize for master 02
  input                          hwrite_02,   //hwrite for master 02
  input  [p_edma_addr_width-1:0] haddr_02,    //haddr for master 02
  input  [p_edma_addr_pwid-1:0]  haddr_02_par,

  output [p_edma_bus_width-1:0]  hrdata_rx,
  output [p_edma_bus_pwid-1:0]   hrdata_rx_par,

  output [1:0]                   hresp_rx,
  output                         hready_rx,


  //---------------------------------------------
  // RX
  //---------------------------------------------
  input                                  last_data_to_buff_dph,
  input  [13:0]                          full_pkt_size,
  input                                  enable_rx,
  input                                  rx_descr_ptr_reset,
  input                                  from_rx_dma_used_bit_read,
  input  [3:0]                           from_rx_dma_queue_ptr,
  input  [(32*p_num_queues)-1:0]         from_rx_dma_descr_ptr,
  input  [(4*p_num_queues)-1:0]          from_rx_dma_descr_ptr_par,
  input  [11:0]                          from_rx_dma_buff_depth,
  input  [(32*p_num_queues)-1:0]         rx_buff_base_addr,
  input  [(4*p_num_queues)-1:0]          rx_buff_base_par,
  input                                  rx_stat_capt_pulse,      // dma_rx status has been captured
  input                                  force_max_ahb_burst_rx,
  input                                  rx_cutthru,
  input                                  rx_extended_bd_mode_en,  // enable extended BD mode, which is used to Descriptor TS insertion
  input                                  new_descr_fetch_trig,
  input                                  part_pkt_written,
  input  [3:0]                           queue_ptr_rx_aph,    // Identifies queue (AHB address phase timed)
  input  [3:0]                           queue_ptr_rx_dph,    // Identifies which (AHB data phase timed)
  input  [3:0]                           queue_ptr_rx_mod,    // Identifies which (AHB address phase timed + 1 cycle with a delay when RSC updates are happening)

  // outputs going to registers block (pclk) for interrupt generation
  output reg                             rx_dma_stable_tog,   //
  output                                 rx_dma_buff_not_rdy, // used buffer descriptor read
  output reg                             rx_dma_complete_ok,  // good frame is successfully stored
  output reg                             rx_dma_resource_err, // no buffers available for storage

  output reg        disable_rx,          // identifies a major error


  //---------------------------------------------
  // Common
  //---------------------------------------------
  input  [1:0]                           dma_bus_width,
  input                                  endian_swap,
  input  [4:0]                           burst_length,
  input  [31:0]                          upper_rx_q_base_addr,
  input  [3:0]                           upper_rx_q_base_par,
  input                                  dma_addr_bus_width,
  input  [p_num_queues-1:0]              rx_disable_queue,

  input                                  arvalid,
  input                                  arready,
  input                                  rvalid,
  input                                  rready,
  input  [p_edma_bus_width-1:0]          rdata,
  input  [p_edma_bus_pwid-1:0]           rdata_par,
  input  [1:0]                           rresp,

  input                                  awvalid,
  input                                  awready,
  input                                  wvalid,
  input                                  wready,
  input                                  wlast,
  input  [1:0]                           bresp,
  input                                  bvalid,
  input                                  bready,

  output  [3:0]                          rx_descr_add_wr_queue,
  output  [3:0]                          rx_descr_wr_queue,
  output  [3:0]                          rx_rsc_wr_queue,

  input                                  argrant,
  input   [2:0]                          awgrant,
  input   [2:0]                          awgrant_hold,

  input                                  flush_rx_wr_fifos,
  input                                  flush_rx_rd_fifos,
  input                                  r_is_tx,
  input                                  r_is_descr,
  input                                  w_is_tx,
  input [3:0]                            w_num_pad,
  input                                  w_is_descr,
  input                                  w_is_rsc_update,
  input                                  w_last_burst_of_buf,
  input                                  b_is_tx,
  input                                  b_is_descr,
  input                                  w2b_pipeline_full,
  input                                  raddr_bit3,
  input [3:0]                            current_rx_queue_resp,
  input                                  aw_is_rx_descr,
  input                                  aw_is_rx_data,
  input                                  b_is_last,

  output reg  [127:0]                    rx_descr_wr_data,
  output reg  [15:0]                     rx_descr_wr_data_par,
  output reg                             rx_descr_wr_req,
  output reg   [p_num_queues-1:0]        rx_descr_rd_req_issued,
  output reg   [1:0]                     rx_descr_wr_cnt,
  output wire                            last_data_to_buff,
  output reg                             rx_eof_written,

  output reg  [2:0]                      hburst_rx,              //hburst for master rx
  output reg  [2:0]                      hsize_rx,               //hsize for master rx
  output reg  [p_edma_addr_width-1:0]    haddr_rx,//haddr for master rx
  output reg  [p_edma_addr_pwid-1:0]     haddr_rx_par,
  output  [31:0]                         rx_descr_wr_fifo_add_out,
  output  [3:0]                          rx_descr_wr_fifo_add_par_out,
  output  [7:0]                          rx_descr_len,
  output  [63:0]                         rx_descr_addr,
  output  [7:0]                          rx_descr_addr_par,
  output  [2:0]                          rx_descr_size,
  output                                 aw_last_burst_of_buf,
  output reg [1:0]                       rx_descr_wr_pop_state,
  output reg                             rx_descr_wr_fifo_dat_pop,
  output  [p_edma_addr_width-1:0]        rx_data_addr,
  output  [p_edma_addr_pwid-1:0]         rx_data_addr_par,
  output reg                             rx_data_wr_req,
  output                                 rx_descr_rd_req,
  output reg [8:0]                       rx_data_len,
  output                                 w_is_pad,
  output  [11:0]                         num_rx_beats_remaining,

  // RSC specific ports
  input  [p_edma_addr_width-1:0]         next_buffer_start_add,
  input  [p_edma_addr_pwid-1:0]          next_buffer_start_add_par,
  input                                  host_update_buf_add,
  input                                  rsc_coalescing_ended,

  // Memory Update interface
  input                                  rsc_update_valid_i,
  output                                 rsc_update_ready_o,
  input                                  rsc_update_last_i,
  input                                  rsc_update_descr_i,
  input  [p_edma_addr_width-1:0]         rsc_update_addr_i,
  input  [p_edma_addr_pwid-1:0]          rsc_update_addr_par_i,
  input  [31:0]                          rsc_update_data_i,
  input  [3:0]                           rsc_update_data_par_i,
  input  [15:0]                          rsc_update_ben_i,

  output                                 rsc_update_valid_o,
  output                                 rsc_update_descr_o,
  output                                 rsc_update_last_o,
  output     [p_edma_addr_width-1:0]     rsc_update_addr_o,
  output     [p_edma_addr_pwid-1:0]      rsc_update_addr_par_o,
  output reg [127:0]                     rsc_update_data_o,
  output reg [15:0]                      rsc_update_data_par_o,
  output     [15:0]                      rsc_update_ben_o,

  input        [3:0]                     b_rx_queue,
  output reg   [3:0]                     rx_dma_int_queue,    // Identifies which queue the interupt is destined
  output       [3:0]                     current_rx_queue_req,

  // ASF fault signalling
  output                                 asf_dap_axi_rx_err


  );

  // Widen address for holding parity, this makes things easier for pipelining
  // the optional parity
  localparam p_awid_par  = (p_edma_asf_dap_prot == 1)  ? 36  : 32;

  // Similarly width of data stored in descriptor buffers
  localparam p_descr_addr_with_p = p_edma_addr_width + p_edma_addr_pwid;
  localparam p_descr_rd_fifo_w   = (p_edma_asf_dap_prot == 0)  ? p_edma_addr_width : p_descr_addr_with_p;

  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // INTERNAL SIGNALS
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------

  //-----------------------------------------------------------------------------
  // RX
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  wire   [p_awid_par-1:0] rx_base_addr_arr[p_num_queues-1:0];  // Array for easier access
  wire   [p_awid_par-1:0] from_rx_dma_descr_arr[p_num_queues-1:0];

  wire   [2:0]   hburst_rx_c;              //hburst for master rx
  wire   [1:0]   htrans_rx_c;              //htrans for master rx
  wire   [2:0]   hsize_rx_c;               //hsize for master rx
  wire           hwrite_rx_c;              //hwrite for master rx
  wire   [p_edma_addr_width-1:0]  haddr_rx_c;//haddr for master rx
  wire   [p_edma_addr_pwid-1:0]   haddr_rx_par_c;
  wire           ahb_rx_is_descr_c;         //
  reg    [1:0]   htrans_rx;              //htrans for master rx
  reg            hwrite_rx;              //hwrite for master rx
  reg            ahb_rx_is_descr;              //
  reg            using_rx_reg;
  reg    [2:0]   hburst_rx_r;
  reg    [2:0]   hsize_rx_r;
  reg    [1:0]   htrans_rx_r;
  reg    [p_edma_addr_width-1:0]  haddr_rx_r;
  wire   [p_edma_addr_pwid-1:0]   haddr_rx_par_r;
  reg            hwrite_rx_r;
  reg            ahb_rx_is_descr_r;              //

  // RX descriptor write signal declarations ...
  reg   [2:0]                               nxt_rx_descr_wr_push_state;
  reg   [1:0]                               nxt_rx_descr_wr_pop_state;
  reg   [95:0]                              nxt_rx_descr_wr_databuf;
  reg   [11:0]                              nxt_rx_descr_wr_databuf_par;
  wire                                      rx_descr_wr_fifo_add_empty;
  wire                                      rx_descr_wr_fifo_add_full;
  wire                                      rx_descr_wr_fifo_dat_full;
  wire                                      rx_descr_wr_fifo_dat_empty;
  reg   [p_axi_rx_descr_wr_buff_bits+1:0]   num_axi_descr_wr_needed;
  reg   [127:0]                             rx_descr_wr_fifo_in;
  reg   [15:0]                              rx_descr_wr_fifo_par_in;

  reg   [95:0]                              rx_descr_wr_databuf;
  wire  [11:0]                              rx_descr_wr_databuf_par;

  wire  [127:0]                             rx_descr_wr_fifo_out;
  wire  [15:0]                              rx_descr_wr_fifo_par_out;

  reg   [2:0]                               rx_descr_wr_push_state;
  wire                                      rx_rsc_wr_fifo_dat_full;
  reg                                       wait_for_data_buffer_push;
  wire  [31:0]                              rsc_wr_fifo_data_out; // Write data from optional RSC write FIFO
  wire  [3:0]                               rsc_wr_fifo_data_par_out;

  // RX descriptor read signal declarations (most are declared below in the generate statement)
  reg [15:0] rx_descr_rd_req_int;
  reg [p_num_queues-1:0] rx_descr_rd_resp;
  wire [p_num_queues-1:0] rx_descr_used_bit_detected;
  wire [p_num_queues-1:0] rx_descr_wrap_bit_detected;
  reg   [15:0] block_rx_descr_rd_resps;
  reg   [7:0]   rx_descr_len_int [15:0];
  reg   [63:0]  rx_descr_addr_int [15:0];
  reg   [7:0]   rx_descr_addr_par_int [15:0];
  reg   [2:0]   rx_descr_size_int [15:0];
  reg   [p_awid_par-1:0]  nxt_rx_descr_ptr_req [p_num_queues-1:0];
  reg   [p_awid_par-1:0]  nxt_rx_descr_ptr_resp [p_num_queues-1:0];
  reg   [p_awid_par-1:0]  rx_descr_ptr_req [p_num_queues-1:0];
  reg   [p_awid_par-1:0]  rx_descr_ptr_resp [p_num_queues-1:0];
  reg   [15:0]            rx_descr_rd_fifo_pop;
  wire  [p_edma_addr_width-1:0] rx_descr_rd_fifo_out[15:0];
  wire  [p_edma_addr_pwid-1:0]  rx_descr_rd_fifo_out_par[15:0];
  wire          rx_descr_rd_fifo_empty[15:0];
  wire [p_axi_rx_descr_rd_buff_bits:0] rx_descr_rd_fifo_fill[p_num_queues-1:0];


  // RX descriptor write signal declarations
  reg           rx_descr_wr_fifo_add_push;
  reg           rx_descr_wr_fifo_dat_push;
  reg           rx_descr_wr_fifo_add_pop;
  reg           rx_rsc_wr_fifo_dat_pop;
  reg           rx_rsc_wr_fifo_dat_push;

  reg   [10:0]  rx_data_len_4k;
  reg   [8:0]   rx_data_len_burst;
  reg   [8:0]   rx_data_len_max;
  reg   [8:0]   rx_data_len_passed_down;
  wire          all_data_for_rxbuf_requested;
  wire          all_data_for_rxpkt_requested;
  reg   [p_num_queues-1:0] need_to_complete_descr_rd;

  integer       int_o;

  reg           rx_descr_rd_dph;
  reg           rx_descr_wr_dph;
  reg           rx_descr_rd_dph_cnt;

  reg           block_n_rx_ns_req;
  reg           rx_data_wr_dph;

  wire [127:0]  hwdata_00_pad; // Pad to 128-bits to avoid lint issues
  wire  [15:0]  hwdata_00_par_pad;

  wire hready_rx_cutthru_rst_ptr;
  wire hready_rx_idle;
  wire hready_rx_descr_rd;
  wire hready_rx_data_wr;
  wire hready_rx_descr_wr;
  wire r_descr_rd;
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  // Common
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------


  wire [127:0]  hrdata_rx_pad;
  wire  [15:0]  hrdata_rx_par_pad;
  wire          addressing_64b;
  reg   [3:0]   w_ctr;
  reg           rxdma_inactive;

  wire  [11:0]  rx_pkt_req_ctr [15:0];   // Multi Queue values
  reg   [11:0]  rx_buf_req_ctr;
  wire  [11:0]  num_rx_beats_rem_pkt;
  wire  [11:0]  num_rx_beats_rem_buf;
  reg           ok_to_write_data;
  reg           last_data_to_buff_hold;

  wire                                int_source;
  reg                                 wait_for_capt;
  reg                                 complete_ok_str;
  reg                                 buff_not_rdy_str;
  wire                                pclk_has_captured_stat;  // Interrupt Status captured by reg

  reg   [1:0]                         axi_rx_descr_wr_cnt;
  reg   [1:0]                         axi_rx_descr_wr_cnt_done;

  wire                                rx_descr_wr_done;
  reg                                 rx_eof_written_in;

  reg  [31:0]                         rx_next_descr_ptr_inc;

  wire  [127:0]                       rdata_pad;
  wire  [15:0]                        rdata_par_pad;
  wire                                multiple_ints_diff_queue;

  // ASF fault signalling
  wire  [p_num_queues-1:0]            dap_err_rd_fifo_in;


   localparam
      DESCR_IDLE      = 3'b000,
      DESCR_WORD0     = 3'b001,
      DESCR_WORD2     = 3'b010,
      DESCR_WORD3     = 3'b011,
      DESCR_WORD4     = 3'b100;
   localparam
      RX_DESCR_WR_IDLE      = 2'b00,
      RX_DESCR_WR_WORD1     = 2'b01,
      RX_DESCR_WR_WORD2     = 2'b10,
      RX_DESCR_WR_WORD3     = 2'b11;
   localparam
      RX_DESCR_RD_IDLE       = 2'b00,
      RX_DESCR_RD_FILL_FIFO  = 2'b01,
      RX_DESCR_RD_WAIT_RESPS = 2'b10;


  genvar g_loop_1;
  generate if (p_edma_asf_dap_prot == 1) begin : gen_base_arr_par
    // Build base address into array for easier access with optional parity protection
    for (g_loop_1=0; g_loop_1 < p_num_queues; g_loop_1 = g_loop_1 + 1)
    begin : gen_base_addr_arr
      assign rx_base_addr_arr[g_loop_1]       = {rx_buff_base_par[(g_loop_1*4)+3:(g_loop_1*4)],
                                                  rx_buff_base_addr[(g_loop_1*32)+31:(g_loop_1*32)]};
      assign from_rx_dma_descr_arr[g_loop_1]  = {from_rx_dma_descr_ptr_par[(g_loop_1*4)+3:(g_loop_1*4)],
                                                  from_rx_dma_descr_ptr[(g_loop_1*32)+31:(g_loop_1*32)]};
    end
  end else begin : gen_no_base_arr_par
    for (g_loop_1=0; g_loop_1 < p_num_queues; g_loop_1 = g_loop_1 + 1)
    begin : gen_base_addr_arr
      assign rx_base_addr_arr[g_loop_1]       = rx_buff_base_addr[(g_loop_1*p_awid_par)+p_awid_par-1:(g_loop_1*p_awid_par)];
      assign from_rx_dma_descr_arr[g_loop_1]  = from_rx_dma_descr_ptr[(g_loop_1*p_awid_par)+p_awid_par-1:(g_loop_1*p_awid_par)];
    end
  end
  endgenerate

  // Pad the rdata if required to 128-bits for easier working
  generate if (p_edma_bus_width < 32'd128) begin : gen_rdata_pad
    assign rdata_pad      = {{(128 - p_edma_bus_width){1'b0}},rdata};
    assign rdata_par_pad  = {{(16 - p_edma_bus_pwid){1'b0}},rdata_par};
  end else begin : gen_no_rdata_pad
    assign rdata_pad      = rdata;
    assign rdata_par_pad  = rdata_par;
  end
  endgenerate

  assign addressing_64b = dma_addr_bus_width;

  // AXI is point to point, so we can just tie the hgrants high
  // and ignore the hbusreq's
  assign hgrant_00    = 1'b1;
  assign hgrant_02    = 1'b1;

  // Identify when the RXDMA is idle - that is it does not
  // wish to perform any accesses ...
  // This will be used to drive the hready back to the core immediately
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      rxdma_inactive    <= 1'b1;
    else
    begin
      if (~enable_rx)
        rxdma_inactive  <= 1'b1;
      else
        if (hready_rx)
        begin
          if (htrans_00[1] | htrans_02[1])
            rxdma_inactive  <= 1'b0;
          else
            rxdma_inactive  <= 1'b1;
        end
    end
  end

  // Port 0 and 2 never overlap, call this port_tx
  // Port 1 and 3 never overlap, call this port_rx
  assign htrans_rx_c    = (htrans_00 | htrans_02) ;
  assign hburst_rx_c    = htrans_00[1]  ? hburst_00     : hburst_02 ;
  assign hsize_rx_c     = htrans_00[1]  ? hsize_00      : hsize_02 ;
  assign hwrite_rx_c    = htrans_00[1]  ? hwrite_00     : hwrite_02 ;
  assign haddr_rx_c     = htrans_00[1]  ? haddr_00      : haddr_02 ;
  assign haddr_rx_par_c = htrans_00[1]  ? haddr_00_par  : haddr_02_par;

  assign ahb_rx_is_descr_c = htrans_00[1];

  // We want to change the AHB characteristics.
  // so that the AHB phase doesnt necessarily proceed
  // when hready is HIGH.  It will be done more asynchronously
  // so that the address remains valid until hready goes high
  // again. This is for cases where the access cannot get out onto
  // the AXI aw or ar bus immediately
  // So first register the address phase signals ...
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      haddr_rx_r    <= {p_edma_addr_width{1'b0}};
      hsize_rx_r    <= 3'b000;
      hwrite_rx_r   <= 1'h0;
      htrans_rx_r   <= 2'h0;
      hburst_rx_r   <= 3'h0;
      ahb_rx_is_descr_r <= 1'b0;
    end
    else
    begin
      if (~using_rx_reg & hready_rx)
      begin
        haddr_rx_r    <= haddr_rx_c;
        hsize_rx_r    <= hsize_rx_c;
        hburst_rx_r   <= hburst_rx_c;
        hwrite_rx_r   <= hwrite_rx_c;
        htrans_rx_r   <= htrans_rx_c;
        ahb_rx_is_descr_r <= ahb_rx_is_descr_c;
      end
    end
  end

  // Register the parity for haddr_rx_c if optional parity protection
  // is configured.
  generate if (p_edma_asf_dap_prot == 1) begin : gen_haddr_rx_par
    reg   [p_edma_addr_pwid-1:0] haddr_rx_par_int;
    always @ (posedge aclk or negedge n_areset)
    begin
      if  (~n_areset)
        haddr_rx_par_int  <= {p_edma_addr_pwid{1'b0}};
      else if (~using_rx_reg & hready_rx)
        haddr_rx_par_int  <= haddr_rx_par_c;
    end
    assign haddr_rx_par_r = haddr_rx_par_int;
  end else begin : gen_no_haddr_rx_par
    assign haddr_rx_par_r = {p_edma_addr_pwid{1'b0}};
  end
  endgenerate

  // We need to use the buffered version of the AHB signals if ...
  //  1) if htrans is active, but the arbiter
  //     has selected a different port - we need to drive hready to
  //     keep the pipeline going, so we need to buffer the address
  //  2) if arready is low at the point arvalid
  //     is set (we will want to push the AHB address phase on, so
  //     we will lose the current address shining from the AHB ports
  //  3) For RX descriptor writeback followed by descriptor read
  //     then if axi_no_wr_rd_depend is set we need to delay the read
  //     until the writeback has completed, however this writeback
  //     completion will cause AHB to move on so we must latch the
  //     read request.

  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
      using_rx_reg  <= 1'b0;
    else
    begin

      if (hready_rx | using_rx_reg)
      begin
        if (rx_data_wr_req & rx_cutthru)
          using_rx_reg  <= ~(|awgrant) | ~awready | aw_is_rx_descr; // Only needed for RX data writes
        else
          using_rx_reg  <= 1'b0;
      end

    end
  end

  // If htrans is suggesting there is a valid access, but hready is low, then we can
  // go ahead and output that request on the AXI ar and aw busses, but we have
  // to block out htrans until hready goes high again to avoid acting on the same
  // request twice.  It is useful to act on this immediately so we make the most
  // of the AXI pipeline.  This will effectively cause pipelined accesses on the AR and
  // AW bus
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      block_n_rx_ns_req <= 1'b1;
    end
    else
    begin
      if (hready_rx)
        block_n_rx_ns_req <= 1'b1;
      else if (using_rx_reg)  // Dont block the access because we are waiting to use
                              // a previously accepted one ...
        block_n_rx_ns_req <= block_n_rx_ns_req;
      else if (awvalid & awready & (|awgrant) & aw_is_rx_data & rx_cutthru)
        block_n_rx_ns_req <= 1'b0;
    end
  end

  always @(*)
  begin
    if (using_rx_reg & block_n_rx_ns_req)
    begin
      htrans_rx        = htrans_rx_r ;
      hburst_rx        = hburst_rx_r ;
      hsize_rx         = hsize_rx_r  ;
      hwrite_rx        = hwrite_rx_r ;
      haddr_rx         = haddr_rx_r  ;
      haddr_rx_par     = haddr_rx_par_r;
      ahb_rx_is_descr  = ahb_rx_is_descr_r;
    end
    else
    begin
      htrans_rx        = htrans_rx_c;
      hburst_rx        = hburst_rx_c ;
      hsize_rx         = hsize_rx_c ;
      hwrite_rx        = hwrite_rx_c ;
      haddr_rx         = haddr_rx_c ;
      haddr_rx_par     = haddr_rx_par_c;
      ahb_rx_is_descr  = ahb_rx_is_descr_c;
    end
  end



  // RX DESCRIPTOR WRITE/ RSC Update BUFFER
  // this buffer has 2 uses.
  //
  // 1. DESCRIPTOR WRITE BUFFER
  // We need to buffer the descriptor writes locally in order to fully decouple AW from B
  // the descriptors will be 64 bits (*** not 64bit address) in total.
  // To cope with all data bus widths and to minimize local area
  // the buffer will be just 32bits in width, and will require a minimum of
  // 2 writes to fill a 64-bit descriptor
  // Implement a state machine to control the pushing of this FIFO - controlled
  // from the AHB port 0 (RX descriptor write)
  //
  // 2. RSC Update Buffer
  // When the RSC feature is enabled, it goes through update cycles after every TCP segment
  // is coalesced.  There will be fewer descriptor writes when this feature is enabled
  // so the idea is that we should reuse this buffer to cater for them
  assign rsc_update_ready_o = ~rx_rsc_wr_fifo_dat_full;
  generate if (p_edma_bus_width < 32'd128) begin : gen_hwdata_00_pad
    assign hwdata_00_pad      = {{(128-p_edma_bus_width){1'b0}},hwdata_00};
    assign hwdata_00_par_pad  = {{(16-p_edma_bus_pwid){1'b0}},hwdata_00_par};
  end else begin : gen_no_hwdata_00_pad
    assign hwdata_00_pad      = hwdata_00;
    assign hwdata_00_par_pad  = hwdata_00_par;
  end
  endgenerate


  always@(*)
  begin
    // Add defaults to reduce codebase and keep it tidy
    nxt_rx_descr_wr_push_state  = rx_descr_wr_push_state;
    rx_descr_wr_fifo_dat_push   = 1'b0;
    rx_descr_wr_fifo_add_push   = 1'b0;
    rx_descr_wr_fifo_in         = {4{hwdata_00_pad[31:0]}};
    rx_descr_wr_fifo_par_in     = {4{hwdata_00_par_pad[3:0]}};
    nxt_rx_descr_wr_databuf     = rx_descr_wr_databuf;
    nxt_rx_descr_wr_databuf_par = rx_descr_wr_databuf_par;

    if (rsc_update_valid_i & ~rx_rsc_wr_fifo_dat_full)  // Valid only when RSC present
      rx_rsc_wr_fifo_dat_push   = 1'b1;
    else
      rx_rsc_wr_fifo_dat_push   = 1'b0;

    case (rx_descr_wr_push_state)
      DESCR_IDLE:  // IDLE state
      begin
        if (htrans_00[1] & hwrite_00 & hready_rx & ~rx_descr_wr_fifo_add_full)
        begin
          rx_descr_wr_fifo_add_push   = 1'b1;  // write address to fifo once per BD writeback
          nxt_rx_descr_wr_push_state = DESCR_WORD0;
        end
      end
      DESCR_WORD0:
      begin
//        if (rx_descr_wr_dph & ~rx_descr_wr_fifo_dat_full) // Note : These terms cannot be true due to the state
//                                                                    transition from IDLE - the add FIFO and the data FIFO are
//                                                                    equally sized so it will never be full here.
        begin
          if (~rx_extended_bd_mode_en)
          begin
            // addr bit 3, and in 128b data bus width, means the BD words must be in the upper 64b of the data bus
            if (dma_bus_width == 2'b00) begin // 32b so 2 writes
              nxt_rx_descr_wr_databuf[31:0]     = hwdata_00_pad[31:0];
              nxt_rx_descr_wr_databuf_par[3:0]  = hwdata_00_par_pad[3:0];
            end else if (haddr_rx_r[3] & dma_bus_width[1]) begin
              rx_descr_wr_fifo_in[63:0]     = hwdata_00_pad[127:64];
              rx_descr_wr_fifo_par_in[7:0]  = hwdata_00_par_pad[15:8];
            end else begin // otherwise the BD words must be in the lower 64b of the data bus
              rx_descr_wr_fifo_in[63:0]     = hwdata_00_pad[63:0];
              rx_descr_wr_fifo_par_in[7:0]  = hwdata_00_par_pad[7:0];
            end
            nxt_rx_descr_wr_push_state    = dma_bus_width == 2'b00 ? DESCR_WORD2 : DESCR_IDLE;
            rx_descr_wr_fifo_dat_push     = dma_bus_width != 2'b00;
          end
          else
          begin
            if (dma_bus_width == 2'b00) begin  // 32b so 4 writes
              nxt_rx_descr_wr_databuf[95:64]    = hwdata_00_pad[31:0];
              nxt_rx_descr_wr_databuf_par[11:8] = hwdata_00_par_pad[3:0];
            end else if (haddr_rx_r[3] & dma_bus_width[1]) begin
              nxt_rx_descr_wr_databuf[95:32]    = hwdata_00_pad[127:64];
              nxt_rx_descr_wr_databuf_par[11:4] = hwdata_00_par_pad[15:8];
            end else begin // 64b writes for 64b and 128b data bus width
              nxt_rx_descr_wr_databuf[95:32]    = hwdata_00_pad[63:0];
              nxt_rx_descr_wr_databuf_par[11:4] = hwdata_00_par_pad[7:0];
            end
            nxt_rx_descr_wr_push_state = DESCR_WORD2;
          end
        end
      end
      DESCR_WORD2:
      begin
        begin
          if (~rx_extended_bd_mode_en)  // Must be 32 bit to be here
          begin
            rx_descr_wr_fifo_dat_push = 1'b1;
            rx_descr_wr_fifo_in       = {{64{1'b0}},hwdata_00_pad[31:0],rx_descr_wr_databuf[31:0]};
            rx_descr_wr_fifo_par_in   = {8'h00,hwdata_00_par_pad[3:0],rx_descr_wr_databuf_par[3:0]};
            nxt_rx_descr_wr_push_state   = DESCR_IDLE;
          end
          else
          begin
            if (dma_bus_width == 2'b00)  // 32b so 2nd of 4 writes
            begin
              nxt_rx_descr_wr_databuf[63:32]    = hwdata_00_pad[31:0];
              nxt_rx_descr_wr_databuf_par[7:4]  = hwdata_00_par_pad[3:0];
              nxt_rx_descr_wr_push_state = DESCR_WORD3;
            end
            else if (haddr_rx_r[3] & dma_bus_width[1])
            begin
              rx_descr_wr_fifo_dat_push   = 1'b1;
              rx_descr_wr_fifo_in         = {nxt_rx_descr_wr_databuf[95:32], hwdata_00_pad[127:64]};
              rx_descr_wr_fifo_par_in     = {nxt_rx_descr_wr_databuf_par[11:4], hwdata_00_par_pad[15:8]};
              nxt_rx_descr_wr_push_state  = DESCR_IDLE;
            end
            else // 64b writes for 64b and 128b data bus width so last write
            begin
              rx_descr_wr_fifo_dat_push   = 1'b1;
              rx_descr_wr_fifo_in         = {nxt_rx_descr_wr_databuf[95:32], hwdata_00_pad[63:0]};
              rx_descr_wr_fifo_par_in     = {nxt_rx_descr_wr_databuf_par[11:4], hwdata_00_par_pad[7:0]};
              nxt_rx_descr_wr_push_state  = DESCR_IDLE;
            end
          end
        end
      end
      DESCR_WORD3: // only in this stae for 32b data bus and extended bd mode
      begin
//        if ( ~rx_descr_wr_fifo_dat_full) // Note : the add FIFO and the data FIFO are equally sized so it will never be full here.
        begin
          nxt_rx_descr_wr_databuf[31:0]     = hwdata_00_pad[31:0];
          nxt_rx_descr_wr_databuf_par[3:0]  = hwdata_00_par_pad[3:0];
          nxt_rx_descr_wr_push_state = DESCR_WORD4;
        end
      end

      default: // DESCR_WORD4 - last write for 32b data bus and extended bd mode
      begin
          rx_descr_wr_fifo_dat_push   = 1'b1;
          rx_descr_wr_fifo_in         = {nxt_rx_descr_wr_databuf[95:0], hwdata_00_pad[31:0]};
          rx_descr_wr_fifo_par_in     = {nxt_rx_descr_wr_databuf_par[11:0], hwdata_00_par_pad[3:0]};
          nxt_rx_descr_wr_push_state  = DESCR_IDLE;
      end

    endcase
  end


  always @ *
  begin
    // define the number of rx descriptor writes that occur for each mode
    casex ({rx_extended_bd_mode_en, addressing_64b, dma_bus_width})
      4'b1_0_1x:  axi_rx_descr_wr_cnt_done  = 2'h1;  // 2 access

      4'b1_1_1x:  axi_rx_descr_wr_cnt_done  = 2'h1;  // 2 access

      4'b1_x_00:  axi_rx_descr_wr_cnt_done  = 2'h3;  // 4 access
      4'b1_x_01:  axi_rx_descr_wr_cnt_done  = 2'h1;  // 2 access

      4'b0_x_00:  axi_rx_descr_wr_cnt_done  = 2'h1; // 2 access
      default  :  axi_rx_descr_wr_cnt_done  = 2'h0; // 1 access
    endcase
  end


  // And another state to control the popping and the request on AXI
  always @ *
  begin
    // Add defaults to reduce codebase and keep it tidy
    nxt_rx_descr_wr_pop_state     = rx_descr_wr_pop_state;
    rx_descr_wr_fifo_add_pop      = 1'b0;
    rx_descr_wr_req               = 1'b0;

    casex (rsc_update_ben_o)
      16'bxxxxxxxxxxxxxxx1  :   rsc_update_data_o[127:0] = {96'h000000000000000000000000,rsc_wr_fifo_data_out};
      16'bxxxxxxxxxxxxxx10  :   rsc_update_data_o[127:0] = {88'h0000000000000000000000,rsc_wr_fifo_data_out,  8'h00};
      16'bxxxxxxxxxxxxx100  :   rsc_update_data_o[127:0] = {80'h00000000000000000000,rsc_wr_fifo_data_out, 16'h0000};
      16'bxxxxxxxxxxxx1000  :   rsc_update_data_o[127:0] = {72'h000000000000000000,rsc_wr_fifo_data_out, 24'h000000};
      16'bxxxxxxxxxxx10000  :   rsc_update_data_o[127:0] = {64'h0000000000000000,rsc_wr_fifo_data_out, 32'h00000000};
      16'bxxxxxxxxxx100000  :   rsc_update_data_o[127:0] = {56'h00000000000000,rsc_wr_fifo_data_out, 40'h0000000000};
      16'bxxxxxxxxx1000000  :   rsc_update_data_o[127:0] = {48'h000000000000,rsc_wr_fifo_data_out, 48'h000000000000};
      16'bxxxxxxxx10000000  :   rsc_update_data_o[127:0] = {40'h0000000000,rsc_wr_fifo_data_out, 56'h00000000000000};
      16'bxxxxxxx100000000  :   rsc_update_data_o[127:0] = {32'h00000000,rsc_wr_fifo_data_out, 64'h0000000000000000};
      16'bxxxxxx1000000000  :   rsc_update_data_o[127:0] = {24'h000000,rsc_wr_fifo_data_out, 72'h000000000000000000};
      16'bxxxxx10000000000  :   rsc_update_data_o[127:0] = {16'h0000,rsc_wr_fifo_data_out, 80'h00000000000000000000};
      16'bxxxx100000000000  :   rsc_update_data_o[127:0] = { 8'h00,rsc_wr_fifo_data_out, 88'h0000000000000000000000};
      16'bxxx1000000000000  :   rsc_update_data_o[127:0] = {rsc_wr_fifo_data_out[31:0],      96'h000000000000000000000000};
      16'bxx10000000000000  :   rsc_update_data_o[127:0] = {rsc_wr_fifo_data_out[23:0],   104'h00000000000000000000000000};
      16'bx100000000000000  :   rsc_update_data_o[127:0] = {rsc_wr_fifo_data_out[15:0], 112'h0000000000000000000000000000};
      default               :   rsc_update_data_o[127:0] = {rsc_wr_fifo_data_out[7:0],120'h000000000000000000000000000000};
    endcase
    // Similarly for the optional parity
    casex (rsc_update_ben_o)
      16'bxxxxxxxxxxxxxxx1  :   rsc_update_data_par_o[15:0] = {12'd0, rsc_wr_fifo_data_par_out};
      16'bxxxxxxxxxxxxxx10  :   rsc_update_data_par_o[15:0] = {11'd0, rsc_wr_fifo_data_par_out, 1'd0};
      16'bxxxxxxxxxxxxx100  :   rsc_update_data_par_o[15:0] = {10'd0, rsc_wr_fifo_data_par_out, 2'd0};
      16'bxxxxxxxxxxxx1000  :   rsc_update_data_par_o[15:0] = {9'd0,  rsc_wr_fifo_data_par_out, 3'd0};
      16'bxxxxxxxxxxx10000  :   rsc_update_data_par_o[15:0] = {8'd0,  rsc_wr_fifo_data_par_out, 4'd0};
      16'bxxxxxxxxxx100000  :   rsc_update_data_par_o[15:0] = {7'd0,  rsc_wr_fifo_data_par_out, 5'd0};
      16'bxxxxxxxxx1000000  :   rsc_update_data_par_o[15:0] = {6'd0,  rsc_wr_fifo_data_par_out, 6'd0};
      16'bxxxxxxxx10000000  :   rsc_update_data_par_o[15:0] = {5'd0,  rsc_wr_fifo_data_par_out, 7'd0};
      16'bxxxxxxx100000000  :   rsc_update_data_par_o[15:0] = {4'd0,  rsc_wr_fifo_data_par_out, 8'd0};
      16'bxxxxxx1000000000  :   rsc_update_data_par_o[15:0] = {3'd0,  rsc_wr_fifo_data_par_out, 9'd0};
      16'bxxxxx10000000000  :   rsc_update_data_par_o[15:0] = {2'd0,  rsc_wr_fifo_data_par_out, 10'd0};
      16'bxxxx100000000000  :   rsc_update_data_par_o[15:0] = {1'd0,  rsc_wr_fifo_data_par_out, 11'd0};
      16'bxxx1000000000000  :   rsc_update_data_par_o[15:0] = {rsc_wr_fifo_data_par_out[3:0],   12'd0};
      16'bxx10000000000000  :   rsc_update_data_par_o[15:0] = {rsc_wr_fifo_data_par_out[2:0],   13'd0};
      16'bx100000000000000  :   rsc_update_data_par_o[15:0] = {rsc_wr_fifo_data_par_out[1:0],   14'd0};
      default               :   rsc_update_data_par_o[15:0] = {rsc_wr_fifo_data_par_out[0],     15'd0};
    endcase

    rx_rsc_wr_fifo_dat_pop   = (wvalid & wready & w_is_rsc_update); // w_is_rsc_update only if RSC present
    rx_descr_wr_fifo_dat_pop = (wvalid & wready & w_is_descr & ~w_is_tx & (axi_rx_descr_wr_cnt == axi_rx_descr_wr_cnt_done));

    case (rx_descr_wr_pop_state)
      RX_DESCR_WR_IDLE :
      begin
        rx_descr_wr_cnt              = 2'h0; // used to sequence through rx descr write addresses
        // wait for the actual FIFO to load
        if (~rx_descr_wr_fifo_add_empty & ~rx_descr_wr_fifo_dat_empty & (|num_axi_descr_wr_needed) &
           (~wait_for_data_buffer_push))
        begin
          rx_descr_wr_req              = 1'b1;
          if (awgrant[2] & awready)
          begin
            if (dma_bus_width == 2'b00)
              nxt_rx_descr_wr_pop_state     = RX_DESCR_WR_WORD1;
            else
            begin // single write access
              if (~rx_extended_bd_mode_en)
              begin
                rx_descr_wr_fifo_add_pop      = 1'b1;
                nxt_rx_descr_wr_pop_state     = RX_DESCR_WR_IDLE;
              end
              else
                nxt_rx_descr_wr_pop_state     = RX_DESCR_WR_WORD1;
            end
          end
        end
      end

      RX_DESCR_WR_WORD1 : //  32 bit mode or 64 bit extended bd mode
      begin
        rx_descr_wr_cnt                 = 2'h1; // used to sequence through rx descr write addresses
        rx_descr_wr_req                 = 1'b1;
        if (awgrant[2] & awready)
        begin
          if (~rx_extended_bd_mode_en)  // 32 bit mode, 2nd write
            begin
              rx_descr_wr_fifo_add_pop    = 1'b1;
              nxt_rx_descr_wr_pop_state   = RX_DESCR_WR_IDLE;
            end
          else
          begin
            if (|dma_bus_width)
            begin  // 128b / 64b last write
              rx_descr_wr_fifo_add_pop    = 1'b1;
              nxt_rx_descr_wr_pop_state   = RX_DESCR_WR_IDLE;
            end
            else  // 32b 3rd write
              nxt_rx_descr_wr_pop_state   = RX_DESCR_WR_WORD2;
          end
        end
      end

      RX_DESCR_WR_WORD2 : // only entered in 32 bit mode extended bd mode
      begin
        rx_descr_wr_cnt                 = 2'h2; // used to sequence through rx descr write addresses
        rx_descr_wr_req                 = 1'b1;
        if (awgrant[2] & awready)
          nxt_rx_descr_wr_pop_state   = RX_DESCR_WR_WORD3;
      end

      default : // only entered in 32 bit mode extended bd mode
      begin
        rx_descr_wr_cnt                 = 2'h3; // used to sequence through rx descr write addresses
        rx_descr_wr_req                 = 1'b1;
        if (awgrant[2] & awready)
        begin
          rx_descr_wr_fifo_add_pop    = 1'b1;
          nxt_rx_descr_wr_pop_state   = RX_DESCR_WR_IDLE;
        end
      end
    endcase
  end

  always@(*)
  begin
    if (rx_extended_bd_mode_en) // NOT RSC related - data in FIFO is a descriptor write
    begin
      case ({|dma_bus_width, axi_rx_descr_wr_cnt})
        3'b1_00:  begin
                    rx_descr_wr_data      = {2{rx_descr_wr_fifo_out[127:64]}};
                    rx_descr_wr_data_par  = {2{rx_descr_wr_fifo_par_out[15:8]}};
                  end
        3'b1_01:  begin
                    rx_descr_wr_data      = {2{rx_descr_wr_fifo_out[63:0]}};
                    rx_descr_wr_data_par  = {2{rx_descr_wr_fifo_par_out[7:0]}};
                  end
        3'b0_00:  begin
                    rx_descr_wr_data      = {4{rx_descr_wr_fifo_out[127:96]}};
                    rx_descr_wr_data_par  = {4{rx_descr_wr_fifo_par_out[15:12]}};
                  end
        3'b0_01:  begin
                    rx_descr_wr_data      = {4{rx_descr_wr_fifo_out[95:64]}};
                    rx_descr_wr_data_par  = {4{rx_descr_wr_fifo_par_out[11:8]}};
                  end
        3'b0_10:  begin
                    rx_descr_wr_data      = {4{rx_descr_wr_fifo_out[63:32]}};
                    rx_descr_wr_data_par  = {4{rx_descr_wr_fifo_par_out[7:4]}};
                  end
        3'b0_11:  begin
                    rx_descr_wr_data      = {4{rx_descr_wr_fifo_out[31:0]}};
                    rx_descr_wr_data_par  = {4{rx_descr_wr_fifo_par_out[3:0]}};
                  end
        default:  begin
                    rx_descr_wr_data      = {128{1'b0}};
                    rx_descr_wr_data_par  = {16{1'b0}};
                  end
      endcase
    end
    else
    begin
      if (dma_bus_width == 2'b00)
      begin
        if (axi_rx_descr_wr_cnt[0])
        begin
          rx_descr_wr_data      = {4{rx_descr_wr_fifo_out[63:32]}};
          rx_descr_wr_data_par  = {4{rx_descr_wr_fifo_par_out[7:4]}};
        end
        else
        begin
          rx_descr_wr_data      = {4{rx_descr_wr_fifo_out[31:0]}};
          rx_descr_wr_data_par  = {4{rx_descr_wr_fifo_par_out[3:0]}};
        end
      end
      else
      begin
        rx_descr_wr_data      = {2{rx_descr_wr_fifo_out[63:0]}};
        rx_descr_wr_data_par  = {2{rx_descr_wr_fifo_par_out[7:0]}};
      end
    end
  end

  // Registered state members
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      rx_descr_wr_push_state    <= DESCR_IDLE;
      rx_descr_wr_pop_state     <= RX_DESCR_WR_IDLE;
      rx_descr_wr_databuf       <= 96'd0;
      axi_rx_descr_wr_cnt       <= 2'b00;
      num_axi_descr_wr_needed   <= {p_axi_rx_descr_wr_buff_bits+2{1'b0}};
      wait_for_data_buffer_push <= 1'b0;
    end
    else
    begin
      if ((~enable_rx & awready & wready) | flush_rx_wr_fifos)
      begin
        rx_descr_wr_push_state    <= DESCR_IDLE;
        rx_descr_wr_pop_state     <= RX_DESCR_WR_IDLE;
        rx_descr_wr_databuf       <= 96'd0;
        if (wready)
          axi_rx_descr_wr_cnt     <= 2'b00;
        num_axi_descr_wr_needed   <= {p_axi_rx_descr_wr_buff_bits+2{1'b0}};
        wait_for_data_buffer_push <= 1'b0;
      end
      else
      begin
        // the AXI descrip[tor buffer consists of 2 parts, the address buffer and the data buffer.
        // When the address buffer moves from an empty state to a non-empty state, we need to wait
        // until the data buffer does the same before we can kick off the state machine above. This
        // is to avoid the situation where the data buffer still has something in it from a previous
        // descriptor write and the state machine kicks off prematurely as soon as the addres buffer
        // gets pushed.
        if (rx_descr_wr_fifo_add_empty & rx_descr_wr_fifo_add_push)
          wait_for_data_buffer_push <= 1'b1;
        else if (rx_descr_wr_fifo_dat_push)
          wait_for_data_buffer_push <= 1'b0;

        // num_axi_descr_wr_needed is a signal used to hold off the descriptor writes from being issued
        // until the packet data is fully written to main memory. Fully written means we have the write response
        // guaranteeting the completion of that last write. We also use this to hold off RSC update cycles.
        // Note that RSC descriptor updates do not need to be held off, as they always follow a descriptor write or
        // an RSC update both of which are already held off.
        if (bvalid & bready & b_is_last & ~b_is_descr & ~b_is_tx)
        begin
          if (~rx_descr_wr_fifo_add_pop)
            num_axi_descr_wr_needed <= num_axi_descr_wr_needed + {{p_axi_rx_descr_wr_buff_bits{1'b0}},1'b1};
        end
        else if (rx_descr_wr_fifo_add_pop                                              // pop for normal descriptor writes
                 | (rsc_update_valid_o & rsc_update_last_o & ~rsc_update_descr_o & rx_rsc_wr_fifo_dat_pop) // pop for rsc updates only if RSC present
                )
          num_axi_descr_wr_needed   <= num_axi_descr_wr_needed - {{p_axi_rx_descr_wr_buff_bits{1'b0}},1'b1};


        // counter used for rx data fifo popping
        // the .._cnt_done value is set depending on operating mode and bus width
        if (wvalid & wready & w_is_descr & ~w_is_tx)
        begin
          if (rx_descr_wr_fifo_dat_pop)  // reset count after pop
            axi_rx_descr_wr_cnt   <= 2'b00;
          else
            axi_rx_descr_wr_cnt   <= axi_rx_descr_wr_cnt + 2'b01;
        end


        rx_descr_wr_push_state    <= nxt_rx_descr_wr_push_state;
        rx_descr_wr_pop_state     <= nxt_rx_descr_wr_pop_state;
        rx_descr_wr_databuf       <= nxt_rx_descr_wr_databuf;
      end
    end
  end

  // Store rx_descr_wr_databuf_par if required
  generate if (p_edma_asf_dap_prot == 1) begin : gen_rx_descr_wr_databuf_par
    reg [11:0]  rx_descr_wr_databuf_par_r;
    always@(posedge aclk or negedge n_areset)
    begin
      if (~n_areset)
        rx_descr_wr_databuf_par_r <= 12'h000;
      else if ((~enable_rx & awready & wready) | flush_rx_wr_fifos)
        rx_descr_wr_databuf_par_r <= 12'h000;
      else
        rx_descr_wr_databuf_par_r <= nxt_rx_descr_wr_databuf_par;
    end
    assign rx_descr_wr_databuf_par  = rx_descr_wr_databuf_par_r;
  end else begin : gen_no_rx_descr_wr_databuf
    assign rx_descr_wr_databuf_par  = 12'h000;
  end
  endgenerate

  // Implement the RX Descriptor Write buffer, address
  localparam p_wr_add_fifo_w = (p_edma_asf_dap_prot == 0)  ? 32  : 36;
  wire  [p_wr_add_fifo_w-1:0] wr_add_fifo_in, wr_add_fifo_out;

  assign wr_add_fifo_in[31:0]     = haddr_00[31:0];
  assign rx_descr_wr_fifo_add_out = wr_add_fifo_out[31:0];

  generate if (p_edma_asf_dap_prot == 1) begin : gen_wr_add_fifo_par
    assign wr_add_fifo_in[35:32]        = haddr_00_par[3:0];
    assign rx_descr_wr_fifo_add_par_out = wr_add_fifo_out[35:32];
  end else begin : gen_no_wr_add_fifo_par
    assign rx_descr_wr_fifo_add_par_out = 4'h0;
  end
  endgenerate

  edma_gen_fifo #( .FIFO_WIDTH(p_wr_add_fifo_w+4),
                   .FIFO_DEPTH(p_axi_rx_descr_wr_buff_depth),
                   .FIFO_ADDR_WIDTH(p_axi_rx_descr_wr_buff_bits)
                 ) i_rx_descr_wr_add_fifo (

    .qout       ({rx_descr_add_wr_queue,wr_add_fifo_out}),
    .qempty     (rx_descr_wr_fifo_add_empty),
    .qfull      (rx_descr_wr_fifo_add_full),
    .qlevel     (),
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        ({from_rx_dma_queue_ptr,wr_add_fifo_in}),
    .push       (rx_descr_wr_fifo_add_push),
    .flush      (~enable_rx | flush_rx_wr_fifos),
    .pop        (rx_descr_wr_fifo_add_pop)
  );


  // Implement the RX Descriptor Write buffer, data
  localparam p_wr_dat_fifo_w = (p_edma_asf_dap_prot == 0)  ? 132 : 148;
  wire  [p_wr_dat_fifo_w-1:0] wr_dat_fifo_in, wr_dat_fifo_out;

  generate if (p_edma_asf_dap_prot == 1) begin : gen_wr_dat_fifo_par
    assign wr_dat_fifo_in           = {from_rx_dma_queue_ptr,rx_descr_wr_fifo_par_in,rx_descr_wr_fifo_in};
    assign {rx_descr_wr_queue,
            rx_descr_wr_fifo_par_out,
            rx_descr_wr_fifo_out}   = wr_dat_fifo_out;
  end else begin : gen_no_wr_dat_fifo_par
    assign wr_dat_fifo_in           = {from_rx_dma_queue_ptr,rx_descr_wr_fifo_in};
    assign {rx_descr_wr_queue,
            rx_descr_wr_fifo_out}   = wr_dat_fifo_out;
    assign rx_descr_wr_fifo_par_out = 16'h0000;
  end
  endgenerate

  edma_gen_fifo #( .FIFO_WIDTH(p_wr_dat_fifo_w),
                   .FIFO_DEPTH(p_axi_rx_descr_wr_buff_depth),
                   .FIFO_ADDR_WIDTH(p_axi_rx_descr_wr_buff_bits)
                 ) i_rx_descr_wr_dat_fifo (

    .qout       (wr_dat_fifo_out),
    .qempty     (rx_descr_wr_fifo_dat_empty),
    .qfull      (rx_descr_wr_fifo_dat_full),
    .qlevel     (),
    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .din        (wr_dat_fifo_in),
    .push       (rx_descr_wr_fifo_dat_push),
    .flush      (~enable_rx | flush_rx_wr_fifos),
    .pop        (rx_descr_wr_fifo_dat_pop)
  );

  generate if (p_edma_rsc == 1) begin : gen_rsc
    // The RSC update FIFO width depends on address width and optionally parity.
    localparam p_rsc_upd_fifo_dw = p_edma_addr_width + 2 + 16 + 32;
    localparam p_rsc_upd_fifo_pw = (p_edma_asf_dap_prot == 0)  ? p_rsc_upd_fifo_dw                         // Data only
                                                              : p_rsc_upd_fifo_dw + 4 + p_edma_addr_pwid; // With parity protection of address/data
    wire  rsc_update_valid_int;
    wire  [p_rsc_upd_fifo_pw-1:0] rx_rsc_wr_fifo_in;
    wire  [p_rsc_upd_fifo_pw-1:0] rx_rsc_wr_fifo_out;
    wire                          rx_rsc_wr_fifo_dat_empty;

    if (p_edma_asf_dap_prot == 1) begin : gen_rsc_par
      assign rx_rsc_wr_fifo_in  = {rsc_update_last_i,       // 1
                                    rsc_update_descr_i,     // 1
                                    rsc_update_ben_i,       // 16
                                    rsc_update_addr_par_i,  // 4 or 8
                                    rsc_update_addr_i,      // 32 or 64
                                    rsc_update_data_par_i,  // 4
                                    rsc_update_data_i};     // 32 bits
      assign {rsc_update_last_o,
              rsc_update_descr_o,
              rsc_update_ben_o,
              rsc_update_addr_par_o,
              rsc_update_addr_o,
              rsc_wr_fifo_data_par_out,
              rsc_wr_fifo_data_out} = rx_rsc_wr_fifo_out;
    end else begin : gen_no_rsc_par
      assign rx_rsc_wr_fifo_in  = { rsc_update_last_i,      // 1
                                    rsc_update_descr_i,     // 1
                                    rsc_update_ben_i,       // 16
                                    rsc_update_addr_i,      // 32 or 64
                                    rsc_update_data_i};     // 32 bits
      assign {rsc_update_last_o,
              rsc_update_descr_o,
              rsc_update_ben_o,
              rsc_update_addr_o,
              rsc_wr_fifo_data_out}   = rx_rsc_wr_fifo_out;
      assign rsc_update_addr_par_o    = {p_edma_addr_pwid{1'b0}};
      assign rsc_wr_fifo_data_par_out = 4'h0;

    end

    // Implement the RX RSC Write buffer
    edma_gen_fifo #(
      .FIFO_WIDTH(5+p_rsc_upd_fifo_pw),
      .FIFO_DEPTH(4),
      .FIFO_ADDR_WIDTH(4'd2)
    ) i_rx_rsc_wr_dat_fifo (
      .qout       ({rx_rsc_wr_queue,rsc_update_valid_int,rx_rsc_wr_fifo_out}),
      .qempty     (rx_rsc_wr_fifo_dat_empty),
      .qfull      (rx_rsc_wr_fifo_dat_full),
      .qlevel     (),
      .clk_pcie   (aclk),
      .rst_n      (n_areset),
      .din        ({from_rx_dma_queue_ptr,rsc_update_valid_i,rx_rsc_wr_fifo_in}),
      .push       (rx_rsc_wr_fifo_dat_push),
      .flush      (~enable_rx | flush_rx_wr_fifos),
      .pop        (rx_rsc_wr_fifo_dat_pop)
    );

    // Only allow the RSC valid to propagate to the arbiter on the level above if ...
    // 1. the actual FIFO is not empty - if it's empty then rsc_update_valid_int means nothing
    // 2. If there has been packet data written, then we must wait until we are sure that packet data has
    //    been completely written to main memory before we issue the update cycles - this is monitored by
    //    num_axi_descr_wr_needed
    // 3. For cases where there has been an rsc stop, there will be a descriptor update only - no update cycle.
    //    These will always follow either a descriptor write, or an update cycle, which both indivually wait for
    //    previous data to be written.  Therefore, we dont need to wait for anything can just allow propagtion
    //    immediately (identified by rsc_update_descr_o).
    // 4. If there is anything in the descriptor FIFO, allow this to propagate out first to avoid any race conditions
    //    between RSC and Descriptors
    assign rsc_update_valid_o = rsc_update_valid_int &
                                ~rx_rsc_wr_fifo_dat_empty &
                                (|num_axi_descr_wr_needed | rsc_update_descr_o) &
                                rx_descr_wr_fifo_dat_empty;
  end else begin : gen_no_rsc
    assign rsc_update_last_o        = 1'b0;
    assign rsc_update_descr_o       = 1'b0;
    assign rsc_update_ben_o         = 16'h0000;
    assign rsc_update_addr_par_o    = {p_edma_addr_pwid{1'b0}};
    assign rsc_update_addr_o        = {p_edma_addr_width{1'b0}};
    assign rsc_wr_fifo_data_par_out = 4'h0;
    assign rsc_wr_fifo_data_out     = 32'h00000000;
    assign rx_rsc_wr_queue          = 4'h0;
    assign rsc_update_valid_o       = 1'b0;
    assign rx_rsc_wr_fifo_dat_full  = 1'b0;
  end
  endgenerate


  always @ *
  begin
    if (~rx_extended_bd_mode_en)
    begin
      rx_eof_written_in = |dma_bus_width ? rx_descr_wr_fifo_in[47] & rx_descr_wr_fifo_in[0]
                                         : rx_descr_wr_fifo_in[15] & rx_descr_wr_fifo_in[32];
      rx_eof_written    = |dma_bus_width ? rx_descr_wr_fifo_out[47] & rx_descr_wr_fifo_out[0]
                                         : rx_descr_wr_fifo_out[15] & rx_descr_wr_fifo_out[32];
    end
    else
    begin
      rx_eof_written_in = rx_descr_wr_fifo_in[47] & rx_descr_wr_fifo_in[0];
      rx_eof_written    = rx_descr_wr_fifo_out[47] & rx_descr_wr_fifo_out[0];
    end
  end


// ----------------------------------------------------------------

  // RX DESCRIPTOR READ
  // The following code multiplies up depending on the number of queues.  It handles the RX descriptor
  // read buffers, of which there is one per queue
  assign rx_descr_rd_req = |rx_descr_rd_req_int;

  generate if (p_num_queues > 32'd1) begin : gen_set_priq
    reg [3:0] current_rx_queue_req_r;
    reg [3:0] current_rx_queue_req_c;
    always @ (posedge aclk or negedge n_areset)
    begin
      if  (~n_areset)
        current_rx_queue_req_r <= 4'h0;
      else
        current_rx_queue_req_r <= current_rx_queue_req;
    end

    always @ (*)
    begin
        if (rx_descr_rd_req_int[15] & p_num_queues > 32'd15)
          current_rx_queue_req_c = 4'd15;
        else if (rx_descr_rd_req_int[14] & p_num_queues > 32'd14)
          current_rx_queue_req_c = 4'd14;
        else if (rx_descr_rd_req_int[13] & p_num_queues > 32'd13)
          current_rx_queue_req_c = 4'd13;
        else if (rx_descr_rd_req_int[12] & p_num_queues > 32'd12)
          current_rx_queue_req_c = 4'd12;
        else if (rx_descr_rd_req_int[11] & p_num_queues > 32'd11)
          current_rx_queue_req_c = 4'd11;
        else if (rx_descr_rd_req_int[10] & p_num_queues > 32'd10)
          current_rx_queue_req_c = 4'd10;
        else if (rx_descr_rd_req_int[9] & p_num_queues > 32'd9)
          current_rx_queue_req_c = 4'd9;
        else if (rx_descr_rd_req_int[8] & p_num_queues > 32'd8)
          current_rx_queue_req_c = 4'd8;
        else if (rx_descr_rd_req_int[7] & p_num_queues > 32'd7)
          current_rx_queue_req_c = 4'd7;
        else if (rx_descr_rd_req_int[6] & p_num_queues > 32'd6)
          current_rx_queue_req_c = 4'd6;
        else if (rx_descr_rd_req_int[5] & p_num_queues > 32'd5)
          current_rx_queue_req_c = 4'd5;
        else if (rx_descr_rd_req_int[4] & p_num_queues > 32'd4)
          current_rx_queue_req_c = 4'd4;
        else if (rx_descr_rd_req_int[3] & p_num_queues > 32'd3)
          current_rx_queue_req_c = 4'd3;
        else if (rx_descr_rd_req_int[2] & p_num_queues > 32'd2)
          current_rx_queue_req_c = 4'd2;
        else if (rx_descr_rd_req_int[1] & p_num_queues > 32'd1)
          current_rx_queue_req_c = 4'd1;
        else
          current_rx_queue_req_c = 4'd0;
    end
    assign current_rx_queue_req = |need_to_complete_descr_rd ? current_rx_queue_req_r
                                                             : current_rx_queue_req_c;
  end else begin  : gen_no_priq
    assign current_rx_queue_req = 4'd0;
  end
  endgenerate

  assign rx_descr_len       = rx_descr_len_int[current_rx_queue_req];
  assign rx_descr_size      = rx_descr_size_int[current_rx_queue_req];
  assign rx_descr_addr      = rx_descr_addr_int[current_rx_queue_req];
  assign rx_descr_addr_par  = rx_descr_addr_par_int[current_rx_queue_req];
  assign r_descr_rd         = rvalid & rready & r_is_descr & ~r_is_tx;

  genvar rx_rd_q_cnt;
  generate
  for (rx_rd_q_cnt=0; rx_rd_q_cnt<p_num_queues; rx_rd_q_cnt = rx_rd_q_cnt+1)
  begin : rx_descr_reads

    // RX descriptor read signal declarations ...
    reg   [1:0]   nxt_rx_descr_rd_state ;
    reg   [2:0]   nxt_rx_descr_req_state;
    reg   [2:0]   nxt_rx_descr_resp_state;
    reg   [1:0]   rx_descr_rd_state ;
    reg   [2:0]   rx_descr_req_state;
    reg   [2:0]   rx_descr_resp_state;
    reg   [p_axi_rx_descr_rd_buff_bits:0]   rx_descr_rd_req_cnt;
    reg   [p_axi_rx_descr_rd_buff_bits:0]   rx_descr_rd_resp_cnt;
    wire          rx_descr_rd_fifo_push;
    reg   [63:0]  rx_descr_rd_fifo_in;
    reg   [7:0]   rx_descr_rd_fifo_in_par;
    reg           rx_descr_rd_req_done;
    reg   [31:0]  nxt_prev_rdata_descr_rd;
    reg   [3:0]   nxt_prev_rdata_descr_rd_par;
    reg   [31:0]  prev_rdata_descr_rd;
    wire  [3:0]   prev_rdata_descr_rd_par;
    wire          rx_descr_rd_fifo_full;
    reg           ahb_trig_already_tried;
    wire  [31:0]  rx_descr_ptr_req_cur;       // Based on rx_rd_q_cnt
    wire  [3:0]   rx_descr_ptr_req_cur_par;   // Based on rx_rd_q_cnt
    wire  [31:0]  rx_descr_ptr_req_cur_p8;    // Based on rx_rd_q_cnt + 8
    wire  [3:0]   rx_descr_ptr_req_cur_p8_par;// Based on rx_rd_q_cnt

    wire  [35:0]  rx_descr_ptr_req_cur_inc;   // Based on rx_rd_q_cnt + rx_next_descr_ptr_inc
    wire  [31:0]  rx_descr_ptr_resp_cur;      // Based on rx_rd_q_cnt
    wire  [3:0]   rx_descr_ptr_resp_cur_par;  // Based on rx_rd_q_cnt
    wire  [35:0]  rx_descr_ptr_resp_cur_inc;  // Based on rx_rd_q_cnt + rx_next_descr_ptr_inc


    always @ (posedge aclk or negedge n_areset)
    begin
      if  (~n_areset)
        ahb_trig_already_tried <= 1'b0;
      else if (htrans_00[1] & ~hwrite_00 &
               rx_descr_rd_state == RX_DESCR_RD_IDLE & nxt_rx_descr_rd_state == RX_DESCR_RD_FILL_FIFO)
        ahb_trig_already_tried <= 1'b1;
      else if (hready_rx)
        ahb_trig_already_tried <= 1'b0;
    end

    wire new_descr_fetch_trig_en;
    assign new_descr_fetch_trig_en = new_descr_fetch_trig && enable_rx;

    // It is triggered as late as possible to ensure as much time as possible for
    // FW to free up buffers, but early enough to ensure we dont hold up the underlying DMA.
    // new_descr_fetch_trig is used as the trigger
    always @ *
    begin
      // Add defaults to reduce codebase and keep it tidy
      rx_descr_rd_req_int[rx_rd_q_cnt] = 1'b0;
      nxt_rx_descr_rd_state = rx_descr_rd_state;

      case (rx_descr_rd_state)
        RX_DESCR_RD_IDLE:  // IDLE state
        begin
          if (flush_rx_rd_fifos | rx_disable_queue[rx_rd_q_cnt])
          begin
            nxt_rx_descr_rd_state = RX_DESCR_RD_IDLE;
            rx_descr_rd_req_issued[rx_rd_q_cnt] = 1'b0;
          end
          else
            if  (~rx_descr_rd_fifo_full &
              (new_descr_fetch_trig_en | part_pkt_written |
              (htrans_00[1] & ~hwrite_00 & ~ahb_trig_already_tried))) // no need for hready here - it actually causes a nasty timing path from wready thru hready_rx to araddr
            begin
              rx_descr_rd_req_int[rx_rd_q_cnt] = 1'b1;
              nxt_rx_descr_rd_state = RX_DESCR_RD_FILL_FIFO;
              rx_descr_rd_req_issued[rx_rd_q_cnt] = 1'b1;
            end
            else
              rx_descr_rd_req_issued[rx_rd_q_cnt] = 1'b0;
        end

        RX_DESCR_RD_FILL_FIFO:
        begin
          if (need_to_complete_descr_rd[rx_rd_q_cnt])
          begin
            nxt_rx_descr_rd_state = rx_descr_rd_state;
            rx_descr_rd_req_issued[rx_rd_q_cnt] = 1'b1;
            rx_descr_rd_req_int[rx_rd_q_cnt] = 1'b1;
          end

          // Issue enough requests to potentially fill the RX descriptor buffer
          // Stop issuing requests if one of the responses has returned and had the
          // used/wrap bit set (meaning there is no point in sending more)
          else
            if ((rx_descr_rd_fifo_full  & rx_descr_req_state == DESCR_IDLE) |
                (rx_descr_rd_req_cnt == p_axi_rx_descr_rd_buff_depth[p_axi_rx_descr_rd_buff_bits:0]) |
                (block_rx_descr_rd_resps[rx_rd_q_cnt] & rx_descr_req_state == DESCR_IDLE))
            begin
              rx_descr_rd_req_int[rx_rd_q_cnt] = 1'b0;
              nxt_rx_descr_rd_state = RX_DESCR_RD_WAIT_RESPS;
              rx_descr_rd_req_issued[rx_rd_q_cnt] = 1'b1;
            end
            else
            begin
              rx_descr_rd_req_int[rx_rd_q_cnt] = 1'b1;
              rx_descr_rd_req_issued[rx_rd_q_cnt] = 1'b1;
            end
        end

        default :
        begin
          rx_descr_rd_req_issued[rx_rd_q_cnt] = 1'b1;
          rx_descr_rd_req_int[rx_rd_q_cnt] = 1'b0;
          if (rx_descr_rd_resp_cnt == rx_descr_rd_req_cnt)
          begin
            nxt_rx_descr_rd_state = RX_DESCR_RD_IDLE;
          end
        end
      endcase
    end

    // Look up rx_descr_ptr_req array and separate address and parity
    assign rx_descr_ptr_req_cur     = rx_descr_ptr_req[rx_rd_q_cnt][31:0];
    assign rx_descr_ptr_req_cur_par = (p_edma_asf_dap_prot == 0)  ? 4'h0  : rx_descr_ptr_req[rx_rd_q_cnt][p_awid_par-1:p_awid_par-4];

    // This state machine handles the actual RX descriptor read transfers on the AXI bus
    // The RX descriptor read is usually completed in 1 AXI read
    // That is unless 64b addressing is enabled, and data_width == 32bit or 64bit
    // always 32b accesses, for all data bus widths
    always @ *
    begin
      // Add defaults to reduce codebase and keep it tidy
      nxt_rx_descr_req_state              = rx_descr_req_state;
      rx_descr_rd_req_done                = 1'b0;
      rx_descr_len_int[rx_rd_q_cnt]       = 8'h00;
      rx_descr_addr_int[rx_rd_q_cnt]      = {(upper_rx_q_base_addr & {32{addressing_64b}}),rx_descr_ptr_req_cur};
      rx_descr_addr_par_int[rx_rd_q_cnt]  = {(upper_rx_q_base_par & {4{addressing_64b}}),rx_descr_ptr_req_cur_par};
      rx_descr_size_int[rx_rd_q_cnt]      = 3'b000;
      case (rx_descr_req_state)
        DESCR_IDLE:  // IDLE state
        begin
          if (rx_descr_rd_req_int[rx_rd_q_cnt] & argrant & current_rx_queue_req == rx_rd_q_cnt[3:0])
          begin  // 32/64/128 bit data mode
            // SEND REQUEST FOR WORD 0 first
            rx_descr_len_int[rx_rd_q_cnt]       = 8'h00;
            rx_descr_size_int[rx_rd_q_cnt]      = 3'h2;
            rx_descr_addr_int[rx_rd_q_cnt]      = {(upper_rx_q_base_addr & {32{addressing_64b}}),rx_descr_ptr_req_cur};
            rx_descr_addr_par_int[rx_rd_q_cnt]  = {(upper_rx_q_base_par & {4{addressing_64b}}),rx_descr_ptr_req_cur_par};
            if (arready & addressing_64b)
              nxt_rx_descr_req_state  = DESCR_WORD2;
            else if (arready)
            begin
              rx_descr_rd_req_done = 1'b1;
              nxt_rx_descr_req_state  = DESCR_IDLE;
            end
          end
        end

        default:  // Send Word 2, always 32 bit access and 64bit addressing
        begin
          rx_descr_len_int[rx_rd_q_cnt]       = 8'h00;
          rx_descr_size_int[rx_rd_q_cnt]      = 3'h2;
          rx_descr_addr_int[rx_rd_q_cnt]      = {upper_rx_q_base_addr,rx_descr_ptr_req_cur_p8};
          rx_descr_addr_par_int[rx_rd_q_cnt]  = {upper_rx_q_base_par,rx_descr_ptr_req_cur_p8_par};
          if (argrant & arready & current_rx_queue_req == rx_rd_q_cnt[3:0])
          begin
            nxt_rx_descr_req_state  = DESCR_IDLE;
            rx_descr_rd_req_done  = 1'b1;
          end
        end
      endcase
    end

    // Increment of rx_descr_ptr_req_cur by 8 taking into account optional parity
    edma_arith_par #(
      .p_dwidth (32),
      .p_pwidth (4),
      .p_has_par(p_edma_asf_dap_prot)
    ) i_arith_rx_descr_ptr_req_cur (
      .in_val (rx_descr_ptr_req_cur[31:0]),
      .in_par (rx_descr_ptr_req_cur_par),
      .op_val (32'd8),
      .op_add (1'b1),
      .out_val(rx_descr_ptr_req_cur_p8),
      .out_par(rx_descr_ptr_req_cur_p8_par)
    );

    // This state machine handles the RX descriptor read responses on the AXI bus

    always @ *
    begin
      // Add defaults to reduce codebase and keep it tidy
      rx_descr_rd_resp[rx_rd_q_cnt] = 1'b0;
      nxt_rx_descr_resp_state = rx_descr_resp_state;
      nxt_prev_rdata_descr_rd = prev_rdata_descr_rd;
      nxt_prev_rdata_descr_rd_par = prev_rdata_descr_rd_par;
      rx_descr_rd_fifo_in     = rdata_pad[63:0];
      rx_descr_rd_fifo_in_par = rdata_par_pad[7:0];
      case (rx_descr_resp_state)
        DESCR_IDLE:  // IDLE state
        begin
          if (r_descr_rd && current_rx_queue_resp == rx_rd_q_cnt[3:0])
          begin // 32/64/128 bit data modes
            if (addressing_64b)
            begin
              nxt_rx_descr_resp_state  = DESCR_WORD2;
              rx_descr_rd_resp[rx_rd_q_cnt] = 1'b0;
              if (endian_swap)
              begin
                casex ({dma_bus_width, raddr_bit3})
                  3'b1x_0  :
                  begin
                    nxt_prev_rdata_descr_rd     = {rdata_pad[103:96],rdata_pad[111:104],rdata_pad[119:112],rdata_pad[127:120]};
                    nxt_prev_rdata_descr_rd_par = {rdata_par_pad[12],rdata_par_pad[13],rdata_par_pad[14],rdata_par_pad[15]};
                  end
                  3'b1x_1,
                  3'b01_x  :
                  begin
                    nxt_prev_rdata_descr_rd     = {rdata_pad[39:32],rdata_pad[47:40],rdata_pad[55:48],rdata_pad[63:56]};
                    nxt_prev_rdata_descr_rd_par = {rdata_par_pad[4],rdata_par_pad[5],rdata_par_pad[6],rdata_par_pad[7]};
                  end
                  default  :
                  begin
                    nxt_prev_rdata_descr_rd     = {rdata_pad[7:0],rdata_pad[15:8],rdata_pad[23:16],rdata_pad[31:24]};
                    nxt_prev_rdata_descr_rd_par = {rdata_par_pad[0],rdata_par_pad[1],rdata_par_pad[2],rdata_par_pad[3]};
                  end
                endcase
              end
              else
              begin
                casex ({dma_bus_width, raddr_bit3})
                  3'b1x_1  :
                  begin
                    nxt_prev_rdata_descr_rd     = rdata_pad[95:64];
                    nxt_prev_rdata_descr_rd_par = rdata_par_pad[11:8];
                  end
                  default  :
                  begin
                    nxt_prev_rdata_descr_rd     = rdata_pad[31:0];
                    nxt_prev_rdata_descr_rd_par = rdata_par_pad[3:0];
                  end
                endcase
              end
            end

            else
            begin
              nxt_rx_descr_resp_state  = DESCR_IDLE;
              rx_descr_rd_resp[rx_rd_q_cnt] = 1'b1;
              if (endian_swap)
              begin
                casex ({dma_bus_width, raddr_bit3})
                  3'b1x_0  :
                  begin
                    rx_descr_rd_fifo_in     = {2{rdata_pad[103:96],rdata_pad[111:104],rdata_pad[119:112],rdata_pad[127:120]}};
                    rx_descr_rd_fifo_in_par = {2{rdata_par_pad[12],rdata_par_pad[13],rdata_par_pad[14],rdata_par_pad[15]}};
                  end
                  3'b1x_1,
                  3'b01_x  :
                  begin
                    rx_descr_rd_fifo_in     = {2{rdata_pad[39:32],rdata_pad[47:40],rdata_pad[55:48],rdata_pad[63:56]}};
                    rx_descr_rd_fifo_in_par = {2{rdata_par_pad[4],rdata_par_pad[5],rdata_par_pad[6],rdata_par_pad[7]}};
                  end
                  default  :
                  begin
                    rx_descr_rd_fifo_in     = {2{rdata_pad[7:0],rdata_pad[15:8],rdata_pad[23:16],rdata_pad[31:24]}};
                    rx_descr_rd_fifo_in_par = {2{rdata_par_pad[0],rdata_par_pad[1],rdata_par_pad[2],rdata_par_pad[3]}};
                  end
                endcase
              end
              else
              begin
                casex ({dma_bus_width, raddr_bit3})
                  3'b1x_1  :
                  begin
                    rx_descr_rd_fifo_in     = {2{rdata_pad[95:64]}};
                    rx_descr_rd_fifo_in_par = {2{rdata_par_pad[11:8]}};
                  end
                  default  :
                  begin
                    rx_descr_rd_fifo_in     = {2{rdata_pad[31:0]}};
                    rx_descr_rd_fifo_in_par = {2{rdata_par_pad[3:0]}};
                  end
                endcase
              end
            end
          end
        end

        default :
        begin
          if (r_descr_rd && current_rx_queue_resp == rx_rd_q_cnt[3:0])
          begin
            nxt_rx_descr_resp_state  = DESCR_IDLE;
            rx_descr_rd_resp[rx_rd_q_cnt] = 1'b1;
            if (endian_swap)
            begin
              casex ({dma_bus_width, raddr_bit3})
                3'b1x_0  :
                begin
                  rx_descr_rd_fifo_in     = {rdata_pad[103:96],rdata_pad[111:104],rdata_pad[119:112],rdata_pad[127:120],prev_rdata_descr_rd};
                  rx_descr_rd_fifo_in_par = {rdata_par_pad[12],rdata_par_pad[13],rdata_par_pad[14],rdata_par_pad[15],prev_rdata_descr_rd_par[3:0]};
                end
                3'b1x_1,
                3'b01_x  :
                begin
                  rx_descr_rd_fifo_in     = {rdata_pad[39:32],rdata_pad[47:40],rdata_pad[55:48],rdata_pad[63:56],prev_rdata_descr_rd};
                  rx_descr_rd_fifo_in_par = {rdata_par_pad[4],rdata_par_pad[5],rdata_par_pad[6],rdata_par_pad[7],prev_rdata_descr_rd_par[3:0]};
                end
                default  :
                begin
                  rx_descr_rd_fifo_in     = {rdata_pad[7:0],rdata_pad[15:8],rdata_pad[23:16],rdata_pad[31:24],prev_rdata_descr_rd};
                  rx_descr_rd_fifo_in_par = {rdata_par_pad[0],rdata_par_pad[1],rdata_par_pad[2],rdata_par_pad[3],prev_rdata_descr_rd_par[3:0]};
                end
              endcase
            end
            else
            begin
              casex ({dma_bus_width, raddr_bit3})
                3'b1x_1  :
                begin
                  rx_descr_rd_fifo_in     = {rdata_pad[95:64],prev_rdata_descr_rd};
                  rx_descr_rd_fifo_in_par = {rdata_par_pad[11:8],prev_rdata_descr_rd_par[3:0]};
                end
                default  :
                begin
                  rx_descr_rd_fifo_in     = {rdata_pad[31:0],prev_rdata_descr_rd};
                  rx_descr_rd_fifo_in_par = {rdata_par_pad[3:0],prev_rdata_descr_rd_par[3:0]};
                end
              endcase
            end
          end
        end
      endcase
    end
    assign rx_descr_used_bit_detected[rx_rd_q_cnt]  = rx_descr_rd_fifo_in[0];
    assign rx_descr_wrap_bit_detected[rx_rd_q_cnt]  = rx_descr_rd_fifo_in[1];
    
    wire [p_axi_rx_descr_rd_buff_bits+1:0] rx_descr_rd_fifo_fill_p_req_done;
    assign                                 rx_descr_rd_fifo_fill_p_req_done = rx_descr_rd_fifo_fill[rx_rd_q_cnt] + {{p_axi_rx_descr_rd_buff_bits{1'b0}},rx_descr_rd_req_done};

    // Registered state members
    always @ (posedge aclk or negedge n_areset)
    begin
      if  (~n_areset)
      begin
        rx_descr_rd_state           <= RX_DESCR_RD_IDLE;
        rx_descr_req_state          <= DESCR_IDLE;
        rx_descr_resp_state         <= DESCR_IDLE;
        rx_descr_ptr_req[rx_rd_q_cnt]   <= {p_awid_par{1'b0}};
        rx_descr_ptr_resp[rx_rd_q_cnt]  <= {p_awid_par{1'b0}};
        rx_descr_rd_req_cnt         <= {p_axi_rx_descr_rd_buff_bits+1{1'b0}};
        rx_descr_rd_resp_cnt        <= {p_axi_rx_descr_rd_buff_bits+1{1'b0}};
        block_rx_descr_rd_resps[rx_rd_q_cnt] <= 1'b0;
        prev_rdata_descr_rd         <= 32'h00000000;
        need_to_complete_descr_rd[rx_rd_q_cnt]   <= 1'b0;
      end
      else
      begin
        need_to_complete_descr_rd[rx_rd_q_cnt]   <= rx_descr_rd_req & arvalid & ~arready;
        if ((~enable_rx | flush_rx_rd_fifos) & ~need_to_complete_descr_rd[rx_rd_q_cnt] & ~(rx_descr_rd_req & ~arready))
        begin
          rx_descr_ptr_req[rx_rd_q_cnt]   <= from_rx_dma_descr_arr[rx_rd_q_cnt];
          rx_descr_ptr_resp[rx_rd_q_cnt]  <= from_rx_dma_descr_arr[rx_rd_q_cnt];
        end

        else
        begin
          rx_descr_ptr_req[rx_rd_q_cnt]  <= nxt_rx_descr_ptr_req[rx_rd_q_cnt];
          rx_descr_ptr_resp[rx_rd_q_cnt] <= nxt_rx_descr_ptr_resp[rx_rd_q_cnt];
        end

        if (~enable_rx & arready)
        begin
          rx_descr_rd_state           <= RX_DESCR_RD_IDLE;
          rx_descr_req_state          <= DESCR_IDLE;
          rx_descr_resp_state         <= DESCR_IDLE;
          rx_descr_rd_req_cnt         <= {p_axi_rx_descr_rd_buff_bits+1{1'b0}};
          rx_descr_rd_resp_cnt        <= {p_axi_rx_descr_rd_buff_bits+1{1'b0}};
          block_rx_descr_rd_resps[rx_rd_q_cnt] <= 1'b0;
          prev_rdata_descr_rd         <= 32'h00000000;
        end
        else
        begin
          rx_descr_rd_state       <= nxt_rx_descr_rd_state;
          rx_descr_req_state      <= nxt_rx_descr_req_state;
          rx_descr_resp_state     <= nxt_rx_descr_resp_state;

          prev_rdata_descr_rd     <= nxt_prev_rdata_descr_rd;

          // Keep track of the number of descriptor requests issued and the number of responses collected
          // The state machines above control when the requests are issued.  These can only happen when the
          // fill level of the descriptor buffer is not full
          // We need to stop issuing requests when the response to those requests willc ause the buffer to become full
          // The number of requests to issue is therefore dependent on the fill level at the time we start requesting.
          //
          // Note that we can guarantee that we will not be requesting any new RX descriptors the cycle after
          // the last response is returned.
          //
          if (rx_descr_rd_state == RX_DESCR_RD_IDLE)
          begin
            // rather than set to the fill level, it might be better to use the pop signal from the buffer
            // and decrement these counts (req_cnt shouldnt dec if rx_descr_rd_req_done is high)
            rx_descr_rd_req_cnt     <= rx_descr_rd_fifo_fill_p_req_done[p_axi_rx_descr_rd_buff_bits:0];
            rx_descr_rd_resp_cnt    <= rx_descr_rd_fifo_fill[rx_rd_q_cnt];
            block_rx_descr_rd_resps[rx_rd_q_cnt]<= 1'b0;
          end
          else
          begin
            if (rx_descr_rd_req_done)
              rx_descr_rd_req_cnt     <= rx_descr_rd_req_cnt + {{p_axi_rx_descr_rd_buff_bits{1'b0}},1'b1};

            if (rx_descr_rd_resp[rx_rd_q_cnt])
            begin
              rx_descr_rd_resp_cnt    <= rx_descr_rd_resp_cnt + {{p_axi_rx_descr_rd_buff_bits{1'b0}},1'b1};
              if (rx_descr_wrap_bit_detected[rx_rd_q_cnt] | rx_descr_used_bit_detected[rx_rd_q_cnt])
                block_rx_descr_rd_resps[rx_rd_q_cnt]<= 1'b1;
            end
          end
        end
      end
    end

    // Optional parity pipeline of nxt_prev_rdata_descr_rd_par to prev_rdata_descr_rd_par
    if (p_edma_asf_dap_prot == 1) begin : gen_prev_rdata_descr_rd_par
      reg [3:0] prev_rdata_descr_rd_par_r;
      always @ (posedge aclk or negedge n_areset)
      begin
        if  (~n_areset)
          prev_rdata_descr_rd_par_r <= 4'h0;
        else if (~enable_rx & arready)
          prev_rdata_descr_rd_par_r <= 4'h0;
        else
          prev_rdata_descr_rd_par_r <= nxt_prev_rdata_descr_rd_par;
      end
      assign prev_rdata_descr_rd_par  = prev_rdata_descr_rd_par_r;
    end else begin : gen_no_prev_rdata_descr_rd_par
      assign prev_rdata_descr_rd_par  = 4'h0;
    end

    // Look up rx_descr_ptr_req array and separate address and parity
    assign rx_descr_ptr_resp_cur      = rx_descr_ptr_resp[rx_rd_q_cnt][31:0];
    assign rx_descr_ptr_resp_cur_par  = (p_edma_asf_dap_prot == 0)  ? 4'h0  : rx_descr_ptr_resp[rx_rd_q_cnt][p_awid_par-1:p_awid_par-4];

    // Increment with optional parity
    edma_arith_par #(
      .p_dwidth (32),
      .p_pwidth (4),
      .p_has_par(p_edma_asf_dap_prot)
    ) i_arith_rx_descr_ptr_resp_inc (
      .in_val (rx_descr_ptr_resp_cur),
      .in_par (rx_descr_ptr_resp_cur_par),
      .op_val (rx_next_descr_ptr_inc),
      .op_add (1'b1),
      .out_val(rx_descr_ptr_resp_cur_inc[31:0]),
      .out_par(rx_descr_ptr_resp_cur_inc[35:32])
    );
    edma_arith_par #(
      .p_dwidth (32),
      .p_pwidth (4),
      .p_has_par(p_edma_asf_dap_prot)
    ) i_arith_rx_descr_ptr_req_inc (
      .in_val (rx_descr_ptr_req_cur),
      .in_par (rx_descr_ptr_req_cur_par),
      .op_val (rx_next_descr_ptr_inc),
      .op_add (1'b1),
      .out_val(rx_descr_ptr_req_cur_inc[31:0]),
      .out_par(rx_descr_ptr_req_cur_inc[35:32])
    );

    // Manage the descriptor pointers
    always @ *
    begin
      nxt_rx_descr_ptr_req[rx_rd_q_cnt]     = rx_descr_ptr_req[rx_rd_q_cnt];
      nxt_rx_descr_ptr_resp[rx_rd_q_cnt]    = rx_descr_ptr_resp[rx_rd_q_cnt];

      // If we issue a request, we want to increment the request count and
      // the current req pointer.

      // If we get a response, we want to increment the response count and
      // the current resp pointer.

      // Once a response has been collected, we will not issue any new descriptor requests
      // until all the outstanding responses are in.
      // If any of these VALID responses have the wrap bit set, then we need to reset
      // the pointers.  A valid response is one that doesnt have ignore_remaining_desc_rds set or used bit set
      //
      if (rx_descr_rd_resp[rx_rd_q_cnt] & ~rx_descr_used_bit_detected[rx_rd_q_cnt] & ~block_rx_descr_rd_resps[rx_rd_q_cnt] & current_rx_queue_resp == rx_rd_q_cnt[3:0])
      begin
        if (rx_descr_wrap_bit_detected[rx_rd_q_cnt])
          nxt_rx_descr_ptr_resp[rx_rd_q_cnt]  = rx_base_addr_arr[rx_rd_q_cnt];
        else
          nxt_rx_descr_ptr_resp[rx_rd_q_cnt]  = rx_descr_ptr_resp_cur_inc[p_awid_par-1:0];
      end

      if (rx_descr_rd_state == RX_DESCR_RD_WAIT_RESPS) // Cycle after the last response
        nxt_rx_descr_ptr_req[rx_rd_q_cnt]  = rx_descr_ptr_resp[rx_rd_q_cnt];
      else if (rx_descr_rd_req_done)
        nxt_rx_descr_ptr_req[rx_rd_q_cnt]  = rx_descr_ptr_req_cur_inc[p_awid_par-1:0];
    end

    // Implement the RX Descriptor Read buffer
    // Push all valid RX descriptor reads that we receive
    // We can also push descriptors that have used bits set in them, so that we report used bit read errors ehere appropriate as long as the FIFO
    // is empty at the time those descriptors were received.
    // If the same descriptor that was read with used bit set is then re-read on the AXI side in the future before the underlying DMA has popped the
    // descriptor from the buffer, then we should ditch the stale descriptor and replace it with the new one, if the new one has the used bit clear.
    // This is important in priority queue implementations where
    // it is likely used bits will often be read on queues that the DMA is not currently receiving any traffic on, but which will
    // shortly after software will free that descriptor. In these cases, we want to ditch the stale data we read in.
    // may
    assign rx_descr_rd_fifo_push = rx_descr_rd_resp[rx_rd_q_cnt] & ~block_rx_descr_rd_resps[rx_rd_q_cnt] &
                                  (~rx_descr_used_bit_detected[rx_rd_q_cnt] | rx_descr_rd_resp_cnt == {p_axi_rx_descr_rd_buff_bits+1{1'b0}});

    wire  [p_descr_rd_fifo_w-1:0] descr_rd_fifo_in_int, descr_rd_fifo_out_int;

    // Always present assignments
    assign descr_rd_fifo_in_int[p_edma_addr_width-1:0]  = rx_descr_rd_fifo_in[p_edma_addr_width-1:0];
    assign rx_descr_rd_fifo_out[rx_rd_q_cnt]            = descr_rd_fifo_out_int[p_edma_addr_width-1:0];

    // Assign FIFO I/O taking into account optional parity
    if (p_edma_asf_dap_prot == 1) begin : gen_descr_rd_fifo_par
      wire  dap_err_rd_fifo_int;
      assign descr_rd_fifo_in_int[p_descr_rd_fifo_w-1:p_edma_addr_width]  = rx_descr_rd_fifo_in_par[p_edma_addr_pwid-1:0];
      assign rx_descr_rd_fifo_out_par[rx_rd_q_cnt]  = descr_rd_fifo_out_int[p_descr_rd_fifo_w-1:p_edma_addr_width];

      // Also check the parity...
      cdnsdru_asf_parity_check_v1 #(.p_data_width(64)) i_par_chk_rd_fifo_in (
        .odd_par(1'b0),
        .data_in(rx_descr_rd_fifo_in),
        .parity_in(rx_descr_rd_fifo_in_par),
        .parity_err(dap_err_rd_fifo_int)
      );

      // Only care when pushing
      assign dap_err_rd_fifo_in[rx_rd_q_cnt]  = rx_descr_rd_fifo_push ? dap_err_rd_fifo_int : 1'b0;

    end else begin : gen_no_descr_rd_fifo_par
      assign rx_descr_rd_fifo_out_par[rx_rd_q_cnt]  = {p_edma_addr_pwid{1'b0}};
      assign dap_err_rd_fifo_in[rx_rd_q_cnt]        = 1'b0;
    end


    edma_gen_fifo #( .FIFO_WIDTH(p_descr_rd_fifo_w),
                     .FIFO_DEPTH(p_axi_rx_descr_rd_buff_depth),
                     .FIFO_ADDR_WIDTH(p_axi_rx_descr_rd_buff_bits)
                   ) i_rx_descr_rd_fifo (

      .qout       (descr_rd_fifo_out_int),
      .qempty     (rx_descr_rd_fifo_empty[rx_rd_q_cnt]),
      .qfull      (),
      .qlevel     (rx_descr_rd_fifo_fill[rx_rd_q_cnt]),
      .clk_pcie   (aclk),
      .rst_n      (n_areset),

      .din        (descr_rd_fifo_in_int),
      .push       (rx_descr_rd_fifo_push),
      .flush      (~enable_rx | flush_rx_rd_fifos),
      .pop        (rx_descr_rd_fifo_pop[rx_rd_q_cnt] | (rx_descr_rd_fifo_push & rx_descr_rd_fifo_out[rx_rd_q_cnt][0] & ~rx_descr_rd_fifo_empty[rx_rd_q_cnt] & ~rx_descr_rd_dph))
    );

    // Assume the descriptor buffer is full if it is actually full, or
    // if the fill level is equal to the descriptor buffer ring.
    /// note this restriction actually means there is no point in
    // having a buffer bigger than the buffer ring
    assign rx_descr_rd_fifo_full = (rx_descr_rd_fifo_fill[rx_rd_q_cnt] == p_axi_rx_descr_rd_buff_depth[p_axi_rx_descr_rd_buff_bits:0]) |
                                    (|rx_descr_rd_fifo_fill[rx_rd_q_cnt] &
                                      rx_descr_ptr_req_cur == from_rx_dma_descr_arr[rx_rd_q_cnt][31:0]);

  end
  for (rx_rd_q_cnt=p_num_queues; rx_rd_q_cnt<16; rx_rd_q_cnt = rx_rd_q_cnt+1)
  begin : set_unused_sigs
    wire zero = 1'b0;
    always@(*)
    begin
      rx_descr_rd_req_int[rx_rd_q_cnt] = zero;
      rx_descr_len_int[rx_rd_q_cnt] = 8'h00;
      rx_descr_addr_int[rx_rd_q_cnt] = 64'd0;
      rx_descr_addr_par_int[rx_rd_q_cnt] = 8'd0;
      rx_descr_size_int[rx_rd_q_cnt] = 3'd0;
      block_rx_descr_rd_resps[rx_rd_q_cnt] = 1'b0;
    end
    assign rx_descr_rd_fifo_empty[rx_rd_q_cnt] = 1'b0;
    assign rx_descr_rd_fifo_out[rx_rd_q_cnt] = {p_edma_addr_width{1'b0}};
    assign rx_descr_rd_fifo_out_par[rx_rd_q_cnt]  = {p_edma_addr_pwid{1'b0}};
  end
  endgenerate

  // define next RX BD increment depending on mode
  always @ *
  begin
    // legacy is 32'd8                            = 2 BD words
    // addr64 AND extended BD will be 32'd24      = 6 BD words
    // addr64 exOR extended BD will be 32'd16     = 4 BD words
    if (~addressing_64b & ~rx_extended_bd_mode_en)
      rx_next_descr_ptr_inc = 32'h00000008;
    else if (!(addressing_64b && rx_extended_bd_mode_en))
      rx_next_descr_ptr_inc = 32'h00000010;
    else
      rx_next_descr_ptr_inc = 32'h00000018;
  end


  always @ *
  begin
    for (int_o = 0;int_o < 16;int_o=int_o+1)
    begin
      if (int_o[3:0] == queue_ptr_rx_dph)
        rx_descr_rd_fifo_pop[int_o] = (addressing_64b) ? ~rx_descr_rd_dph_cnt & rx_descr_rd_dph & hready_rx & ~rx_descr_rd_fifo_empty[int_o]
                                                       : rx_descr_rd_dph & hready_rx & ~rx_descr_rd_fifo_empty[int_o];
      else
        rx_descr_rd_fifo_pop[int_o] = 1'b0;
    end
  end


  //----------------------------------------------------------------


  // Determine when the AHB dataphase of the RX descriptor read is
  // Also determine when the underlying AHB port has read all of the descriptor
  // read.  It depends on whether 64 bit addressing is enabled, and the datawidth
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      rx_descr_rd_dph    <= 1'b0;
      rx_data_wr_dph     <= 1'b0;
      rx_descr_wr_dph    <= 1'b0;
      rx_descr_rd_dph_cnt <= 1'b0;
      last_data_to_buff_hold <= 1'b0;
    end
    else
    begin
      if (~enable_rx)
      begin
        rx_data_wr_dph     <= 1'b0;
        rx_descr_wr_dph    <= 1'b0;
        last_data_to_buff_hold <= 1'b0;
      end
      else
      begin
        if (last_data_to_buff_dph & ~wlast)
          last_data_to_buff_hold <= 1'b1;
        else if (wvalid & wready & wlast)
          last_data_to_buff_hold <= 1'b0;  // Holds until end of burst to ensure this works for force burst mode

        if (hready_rx)
        begin
          rx_data_wr_dph  <= htrans_02[1] & hwrite_02;
          rx_descr_wr_dph <= htrans_00[1] & hwrite_00;
        end
      end

      if (~enable_rx)
      begin
        rx_descr_rd_dph    <= 1'b0;
        rx_descr_rd_dph_cnt   <= 1'b0;
      end
      else
      begin
        if (hready_rx)
        begin
          if (htrans_00[1] & ~hwrite_00)
          begin
            rx_descr_rd_dph <= 1'b1;
            if (addressing_64b)
              rx_descr_rd_dph_cnt <= ~rx_descr_rd_dph_cnt;
            else
              rx_descr_rd_dph_cnt <= 1'b0;
          end
          else
          begin
            rx_descr_rd_dph <= 1'b0;
            rx_descr_rd_dph_cnt <= 1'b0;
          end
        end
      end
    end
  end

  assign last_data_to_buff = last_data_to_buff_hold | last_data_to_buff_dph;


  // Now repeat for the RX
  assign num_rx_beats_rem_pkt   = (full_pkt_size[11:0] - rx_pkt_req_ctr[queue_ptr_rx_aph]);

  assign num_rx_beats_rem_buf   = (from_rx_dma_buff_depth - rx_buf_req_ctr);
  assign num_rx_beats_remaining = num_rx_beats_rem_buf < num_rx_beats_rem_pkt ? num_rx_beats_rem_buf : num_rx_beats_rem_pkt;

  always @ *
  begin
    casex (burst_length)
      5'b1xxxx            : rx_data_len_burst = 9'd16;
      5'b01xxx            : rx_data_len_burst = 9'd8;
      5'b001xx            : rx_data_len_burst = 9'd4;
      5'b0001x,5'b00001   : rx_data_len_burst = 9'd1;  // single
      default             : rx_data_len_burst = 9'h100;
    endcase
  end

  // First identify the maximum possible access length as specified by burst_length input
  // this is a really tight timing path so we can try optimize it a bit by
  // registering what we can
  reg [7:0] burst_length_mask;
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      burst_length_mask <= 8'h00;
    end
    else
    begin
      casex (burst_length)
        5'b1xxxx            : burst_length_mask <= 8'hf0;
        5'b01xxx            : burst_length_mask <= 8'hf8;
        5'b001xx            : burst_length_mask <= 8'hfc;
        5'b0001x,5'b00001   : burst_length_mask <= 8'hfe;
        default             : burst_length_mask <= 8'h00;
      endcase
    end
  end

  always @ *
  begin
    if (|(num_rx_beats_remaining & {{4{1'b1}},burst_length_mask}))
      rx_data_len_max = rx_data_len_burst;
    else
      rx_data_len_max = {1'b0,num_rx_beats_remaining[7:0]};
  end


  always @(*)
  begin
    if (force_max_ahb_burst_rx)
    begin
      // If breaks 4K
      if (({2'b00,rx_data_len_burst} > rx_data_len_4k) & (|rx_data_len_4k))
        rx_data_len = 9'h001;
      else
        rx_data_len = rx_data_len_burst;
    end
    else
    begin
      // If breaks 4K
      if (({2'b00,rx_data_len_max} > rx_data_len_4k) & (|rx_data_len_4k))
        rx_data_len = rx_data_len_4k[8:0];
      else
        rx_data_len = rx_data_len_max;
    end
  end

  // rx_data_len_passed_down is the same as rx_data_len except that
  // at the end of a packet, or buffer, it exactly matches the number
  // of words left, rather than the max-forced burst if force_max_ahb_burst_rx
  // mode is enabled.  This is used in the main control counters and
  // simplifies the code a bit, avoiding the need for more gates in
  // already complex code.
  // Note that if force max burst mode is enabled, and we are about
  // to break a 4K burst, then we still need to mimic rx_data_len and
  // just apply single bursts.
  always @(*)
  begin
    if (force_max_ahb_burst_rx)
    begin
      // If breaks 4K
      if (({2'b00,rx_data_len_burst} > rx_data_len_4k) & (|rx_data_len_4k))
        rx_data_len_passed_down = 9'h001;
      else
        rx_data_len_passed_down = rx_data_len_max;
    end
    else if (({2'b00,rx_data_len_max} > rx_data_len_4k) & (|rx_data_len_4k))
      rx_data_len_passed_down = rx_data_len_4k[8:0];
    else
      rx_data_len_passed_down = rx_data_len_max;
  end

  // Look up current descriptor from buffer array.
  wire [p_edma_addr_width-1:0]      curr_rx_descr_rd_out;
  wire [p_edma_addr_pwid-1:0] curr_rx_descr_rd_out_par;

  assign curr_rx_descr_rd_out     = rx_descr_rd_fifo_out[queue_ptr_rx_dph];
  assign curr_rx_descr_rd_out_par = rx_descr_rd_fifo_out_par[queue_ptr_rx_dph];

  // Separate out operations on buses with parity protection so parity can be
  // regenerated and seamlessly pipelined.
  reg   [p_edma_addr_width-1:0]   rx_data_addr_inc_val;     // Amount to increment rx_data_addr by
  wire  [p_descr_addr_with_p-1:0] nxt_rx_data_addr_p;       // Incremented with optional parity
  reg   [p_edma_addr_width-1:0]   curr_rx_descr_rd_out_s;   // Shift based on dma_bus_width
  wire  [p_descr_rd_fifo_w-1:0]   curr_rx_descr_rd_out_sp;  // With optional parity
  reg   [p_edma_addr_width-1:0]   next_buffer_start_add_s;  // Shift based on dma_bus_width
  wire  [p_descr_rd_fifo_w-1:0]   next_buffer_start_add_sp; // With optional parity

  reg   [p_descr_rd_fifo_w-1:0] rx_data_addr_int;
  always @ *
  begin
    if (dma_bus_width == 2'b00)
    begin
      rx_data_addr_inc_val    = {{p_edma_addr_width-11{1'b0}},rx_data_len_passed_down,2'd0};
      curr_rx_descr_rd_out_s  = {curr_rx_descr_rd_out[p_edma_addr_width-1:2],2'd0};
      next_buffer_start_add_s = {next_buffer_start_add[p_edma_addr_width-1:2],2'd0};
    end
    else if (dma_bus_width == 2'b01)
    begin
      rx_data_addr_inc_val    = {{p_edma_addr_width-12{1'b0}},rx_data_len_passed_down,3'd0};
      curr_rx_descr_rd_out_s  = {curr_rx_descr_rd_out[p_edma_addr_width-1:3],3'd0};
      next_buffer_start_add_s = {next_buffer_start_add[p_edma_addr_width-1:3],3'd0};
    end
    else
    begin
      rx_data_addr_inc_val    = {{p_edma_addr_width-13{1'b0}},rx_data_len_passed_down,4'd0};
      curr_rx_descr_rd_out_s  = {curr_rx_descr_rd_out[p_edma_addr_width-1:4],4'd0};
      next_buffer_start_add_s = {next_buffer_start_add[p_edma_addr_width-1:4],4'd0};
    end
  end

  // Incrementer for nxt_rx_data_addr_p
  edma_arith_par #(
    .p_dwidth (p_edma_addr_width),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_rx_data_addr (
    .in_val (rx_data_addr),
    .in_par (rx_data_addr_par),
    .op_val (rx_data_addr_inc_val),
    .op_add (1'b1),
    .out_val(nxt_rx_data_addr_p[p_edma_addr_width-1:0]),
    .out_par(nxt_rx_data_addr_p[p_descr_addr_with_p-1:p_edma_addr_width])
  );

  assign curr_rx_descr_rd_out_sp[p_edma_addr_width-1:0]   = curr_rx_descr_rd_out_s;
  assign next_buffer_start_add_sp[p_edma_addr_width-1:0]  = next_buffer_start_add_s;

  // Regenerate parity bits
  generate if (p_edma_asf_dap_prot == 1) begin : gen_rx_data_addr_misc_par
    gem_par_chk_regen #(.p_chk_dwid (2*p_edma_addr_width)) i_regen_par (
      .odd_par  (1'b0),
      .chk_dat  ({curr_rx_descr_rd_out,next_buffer_start_add}),
      .chk_par  ({curr_rx_descr_rd_out_par,next_buffer_start_add_par}),
      .new_dat  ({curr_rx_descr_rd_out_s,next_buffer_start_add_s}),
      .dat_out  (),
      .par_out  ({curr_rx_descr_rd_out_sp[p_descr_rd_fifo_w-1:p_edma_addr_width],
                  next_buffer_start_add_sp[p_descr_rd_fifo_w-1:p_edma_addr_width]}),
      .chk_err  ()
    );
  end
  endgenerate
  
  wire [12:0] rx_buf_req_ctr_p_len_passed_down;
  assign      rx_buf_req_ctr_p_len_passed_down = rx_buf_req_ctr + {3'h0,rx_data_len_passed_down};
  
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      rx_buf_req_ctr        <= 12'h000;
      rx_data_addr_int      <= {(p_descr_rd_fifo_w){1'b0}};
      ok_to_write_data      <= 1'b0;
      w_ctr                 <= 4'h0;
      rx_data_len_4k        <= 11'd0;
    end
    else
    begin
      if (~enable_rx)
      begin
        if (awready)
        begin
          rx_buf_req_ctr        <= 12'h000;
          rx_data_addr_int      <= {(p_descr_rd_fifo_w){1'b0}};
          ok_to_write_data      <= 1'b0;
          rx_data_len_4k        <= 11'd0;
        end
        if (wready)
          w_ctr                 <= 4'h0;
      end
      else
      begin
        if (all_data_for_rxbuf_requested | all_data_for_rxpkt_requested)
          ok_to_write_data    <= 1'b0;
        else if (hbusreq_02)
          ok_to_write_data    <= 1'b1;

        if (rsc_coalescing_ended) // Will only be set if RSC is present.
          rx_buf_req_ctr <= 12'h000;
        else if (rx_descr_wr_fifo_dat_push | rx_rsc_wr_fifo_dat_push)
          rx_buf_req_ctr <= 12'h000;
        else if (rx_data_wr_req & aw_is_rx_data & ~awgrant_hold[0] & awvalid)
          rx_buf_req_ctr <= rx_buf_req_ctr_p_len_passed_down[11:0];

        if (force_max_ahb_burst_rx)
        begin
          if (wvalid & wready & ~w_is_descr & w_last_burst_of_buf)
          begin
            if (wlast)
              w_ctr <= 4'h0;
            else
              w_ctr <= w_ctr + 4'h1;
          end
        end

        // Initialize rx_data_addr when underlying DMA completes a RX descriptor read request ...
        if (rx_descr_rd_fifo_pop[queue_ptr_rx_dph])
        begin
          rx_data_addr_int  <= curr_rx_descr_rd_out_sp[p_descr_rd_fifo_w-1:0];

          // Now calculate the number of accesses to 4K boundary.
          // Regarding 4K boundary.  A burst will cross the 4K boundary if the
          // addressable location targeted crosses from anything to address = 12'h000
          // with a 32 bit datapath, there are potentially 1024 accesses allowed before we break the 4K rule
          // Maximum length in AXI4 is 256, so it is ONLY possible to break the 4K if bits 11:10 of address = 2'b11
          // So if max_burst_len + address[11:0] causes bits 11:10 to change to something other than 2'b11
          // then the 4k boundary has been broken
          if (dma_bus_width == 2'b00)
            rx_data_len_4k   <= 11'h400 - {1'b0,curr_rx_descr_rd_out[11:2]};
          else if (dma_bus_width == 2'b01)
            rx_data_len_4k   <= 11'h200 - {2'b00,curr_rx_descr_rd_out[11:3]};
          else
            rx_data_len_4k   <= 11'h100 - {3'b000,curr_rx_descr_rd_out[11:4]};
        end

        else if (host_update_buf_add) // guaranteed not to occur at same time as else code below and only happens when RSC present
        begin
          rx_data_addr_int  <= next_buffer_start_add_sp[p_descr_rd_fifo_w-1:0];

          if (dma_bus_width == 2'b00)
            rx_data_len_4k   <= 11'h400 - {1'b0,next_buffer_start_add[11:2]};
          else if (dma_bus_width == 2'b01)
            rx_data_len_4k   <= 11'h200 - {2'b00,next_buffer_start_add[11:3]};
          else
            rx_data_len_4k   <= 11'h100 - {3'b000,next_buffer_start_add[11:4]};
        end

        else if (awvalid & ~awgrant_hold[0] & aw_is_rx_data)
        begin
          rx_data_addr_int  <= nxt_rx_data_addr_p[p_descr_rd_fifo_w-1:0];

          if (dma_bus_width == 2'b00)
            rx_data_len_4k   <= 11'h400 - {1'b0,nxt_rx_data_addr_p[11:2]};
          else if (dma_bus_width == 2'b01)
            rx_data_len_4k   <= 11'h200 - {2'b00,nxt_rx_data_addr_p[11:3]};
          else
            rx_data_len_4k   <= 11'h100 - {3'b000,nxt_rx_data_addr_p[11:4]};
        end
      end
    end
  end

  assign rx_data_addr     = rx_data_addr_int[p_edma_addr_width-1:0];
  assign rx_data_addr_par = (p_edma_asf_dap_prot  == 0) ? {p_edma_addr_pwid{1'b0}}
                                                        : rx_data_addr_int[p_descr_rd_fifo_w-1:p_descr_rd_fifo_w-p_edma_addr_pwid];

//------------------------------------------------------------------------------
// We seem to need this counter for each queue.
// So removed this from the above process allowing it to be used in a generate
//------------------------------------------------------------------------------
//
generate
  genvar gv1_i;
  for (gv1_i=0; gv1_i<p_num_queues; gv1_i=gv1_i+1) begin : gen_rx_pkt_req_ctr_r
    reg  [11:0] rx_pkt_req_ctr_local;
    wire [12:0] rx_pkt_req_ctr_local_p_len_passed_down;
    assign      rx_pkt_req_ctr_local_p_len_passed_down = rx_pkt_req_ctr_local + {3'h0,rx_data_len_passed_down};
    
    always @ (posedge aclk or negedge n_areset)
    begin
      if  (~n_areset)
      begin
        rx_pkt_req_ctr_local <= 12'h000;
      end
      else
      begin
        if (~enable_rx & awready)
        begin
          rx_pkt_req_ctr_local <= 12'h000;
        end
        else
        begin
          if (rsc_coalescing_ended & gv1_i == {{28{1'b0}},queue_ptr_rx_mod}) // RSC only
            rx_pkt_req_ctr_local <= 12'h000;
          else if (rx_descr_wr_fifo_dat_push & rx_eof_written_in & gv1_i == {{28{1'b0}},queue_ptr_rx_dph})
            rx_pkt_req_ctr_local <= 12'h000;
          else if (rx_data_wr_req & aw_is_rx_data & ~awgrant_hold[0] & awvalid & gv1_i == {{28{1'b0}},queue_ptr_rx_aph})
            rx_pkt_req_ctr_local <= rx_pkt_req_ctr_local_p_len_passed_down[11:0];
        end
      end
    end
    assign rx_pkt_req_ctr[gv1_i] = rx_pkt_req_ctr_local;
  end // gen_rx_pkt_req_ctr_r

  for (gv1_i=p_num_queues; gv1_i<16; gv1_i = gv1_i+1) begin : gen_rx_pkt_req_ctr_unused
    assign rx_pkt_req_ctr[gv1_i] = 12'h000;
  end

endgenerate


  // If using cut-thru operation, it is very complex to determine how much data to request in advance. For cut-thru therefore
  // we currently just take the request from AHB
  always @ *
  begin
    if (rx_cutthru)
      rx_data_wr_req  = (htrans_rx == 2'b10 | (htrans_rx[1] & ~(|hburst_rx[2:1]))) & hwrite_rx & ~ahb_rx_is_descr & block_n_rx_ns_req;
    else
      rx_data_wr_req  = ok_to_write_data & ~all_data_for_rxbuf_requested & ~all_data_for_rxpkt_requested;
  end

  assign all_data_for_rxbuf_requested = ((rx_buf_req_ctr >= from_rx_dma_buff_depth) & (|rx_buf_req_ctr));
  assign all_data_for_rxpkt_requested = (({2'b00,rx_pkt_req_ctr[queue_ptr_rx_dph]} >= full_pkt_size) & (|rx_pkt_req_ctr[queue_ptr_rx_dph]));


  assign aw_last_burst_of_buf = num_rx_beats_remaining <= {3'h0,rx_data_len};
  assign w_is_pad             = w_ctr >= w_num_pad & w_last_burst_of_buf & (|w_num_pad);

  assign hready_rx_cutthru_rst_ptr = (rx_descr_rd_dph & (flush_rx_rd_fifos | rx_descr_ptr_reset) & rx_cutthru);   // underlying DMA has reset pointers.
  assign hready_rx_idle = rxdma_inactive & ~rx_descr_wr_fifo_add_full;
  assign hready_rx_descr_rd = (rx_descr_rd_dph & ~rx_descr_rd_fifo_empty[queue_ptr_rx_dph] & ~rx_descr_wr_fifo_add_full); // RX descriptor reads come from the descriptor FIFO
  assign hready_rx_data_wr  = (rx_data_wr_dph  & wvalid & wready & ~w_is_descr & ~w_is_rsc_update & ~w2b_pipeline_full & ~rx_descr_wr_fifo_add_full);
  assign hready_rx_descr_wr = (rx_descr_wr_dph & ~rx_descr_wr_fifo_dat_full);

  assign hready_rx = hready_rx_cutthru_rst_ptr ||
                      (~w_is_pad && (hready_rx_idle || hready_rx_descr_rd || hready_rx_data_wr || hready_rx_descr_wr));


  wire [127:0] curr_rx_descr_rd_pad;
  wire  [15:0] curr_rx_descr_rd_par_pad;
  generate if (p_edma_addr_width == 32'd64) begin : gen_set_64_add_to_dma
    assign curr_rx_descr_rd_pad     = {2{curr_rx_descr_rd_out[63:0]}};
    assign curr_rx_descr_rd_par_pad = {2{curr_rx_descr_rd_out_par[7:0]}};
  end else begin  : gen_set_32_add_to_dma
    assign curr_rx_descr_rd_pad     = {4{curr_rx_descr_rd_out[31:0]}};
    assign curr_rx_descr_rd_par_pad = {4{curr_rx_descr_rd_out_par[3:0]}};
  end
  endgenerate
  // If an error occurs and we are flushing, then just force the data to all 1's which will have effect of forcing
  // used bit to appear set and halt the RX. In this case, the parity will just be 0.
  assign hrdata_rx_pad      = ((flush_rx_rd_fifos | rx_descr_ptr_reset) & rx_cutthru) ? {128{1'b1}} : curr_rx_descr_rd_pad;
  assign hrdata_rx_par_pad  = ((flush_rx_rd_fifos | rx_descr_ptr_reset) & rx_cutthru) ? {16{1'b0}}  : curr_rx_descr_rd_par_pad;
  assign hrdata_rx          = hrdata_rx_pad[p_edma_bus_width-1:0];
  assign hrdata_rx_par      = hrdata_rx_par_pad[p_edma_bus_pwid-1:0];

  // RX Interrupt Generation
  // This occurs once a descriptor writeback has finished.

  localparam WAIT      = 1'b1;
  localparam DONT_WAIT = 1'b0;

  assign pclk_has_captured_stat = (rx_stat_capt_pulse & wait_for_capt);


  generate if (p_num_queues > 32'd1) begin : gen_set_int_q
  reg  [3:0]  rx_dma_int_q_str ;
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      rx_dma_int_queue    <= 4'h0;
      rx_dma_int_q_str    <= 4'h0;
    end
    else
    begin
      if (~enable_rx)
      begin
        rx_dma_int_queue    <= 4'h0;
        rx_dma_int_q_str    <= 4'h0;
      end
      else
      begin
        // Interrupt information has been captured by PCLK ?
        if (wait_for_capt)
        begin
          if (pclk_has_captured_stat)
          begin
            if (complete_ok_str | buff_not_rdy_str)
            begin
              rx_dma_int_queue  <= rx_dma_int_q_str;
              if (int_source)
              begin
                if (rx_descr_wr_done)
                  rx_dma_int_q_str <= b_rx_queue;
                else
                  rx_dma_int_q_str <= from_rx_dma_queue_ptr;
              end
            end

            else if (int_source)
            begin
              if (multiple_ints_diff_queue)
              begin
                rx_dma_int_queue    <= b_rx_queue;
                rx_dma_int_q_str <= from_rx_dma_queue_ptr;
              end
              else
                rx_dma_int_queue  <= rx_descr_wr_done ? b_rx_queue : from_rx_dma_queue_ptr;
            end
          end

          else if (int_source)
            rx_dma_int_q_str <= rx_descr_wr_done ? b_rx_queue : from_rx_dma_queue_ptr;
        end

        else if (int_source)
        begin
          if (multiple_ints_diff_queue)
          begin
            rx_dma_int_queue <= b_rx_queue;
            rx_dma_int_q_str <= from_rx_dma_queue_ptr;
          end
          else
            rx_dma_int_queue  <= rx_descr_wr_done ? b_rx_queue : from_rx_dma_queue_ptr;
        end
      end
    end
  end
  end else begin : gen_no_int_queue
  wire zero;
  assign zero = 1'b0;
  always @(*) rx_dma_int_queue = {4{zero}};
  end
  endgenerate

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      rx_dma_stable_tog   <= 1'b0;
      wait_for_capt       <= DONT_WAIT;
      rx_dma_complete_ok  <= 1'b0;
      rx_dma_resource_err <= 1'b0;
      buff_not_rdy_str    <= 1'b0;
      complete_ok_str     <= 1'b0;
    end
    else
    begin
      if (~enable_rx)
      begin
        complete_ok_str     <= 1'b0;
        buff_not_rdy_str    <= 1'b0;
        rx_dma_stable_tog   <= 1'b0;
        wait_for_capt       <= DONT_WAIT;
        rx_dma_complete_ok  <= 1'b0;
        rx_dma_resource_err <= 1'b0;
      end
      else
      begin
        // Interrupt information has been captured by PCLK ?
        if (wait_for_capt)
        begin
          if (pclk_has_captured_stat)
          begin
            if (complete_ok_str | buff_not_rdy_str)
            begin
              wait_for_capt       <= WAIT;
              rx_dma_stable_tog   <= ~rx_dma_stable_tog;
              rx_dma_complete_ok  <= complete_ok_str;
              rx_dma_resource_err <= buff_not_rdy_str;
              if (int_source)
              begin
                buff_not_rdy_str <= from_rx_dma_used_bit_read;
                complete_ok_str  <= rx_descr_wr_done;
              end
              else
              begin
                buff_not_rdy_str <= 1'b0;
                complete_ok_str  <= 1'b0;
              end
            end

            else if (int_source)
            begin
              wait_for_capt       <= WAIT;
              rx_dma_stable_tog   <= ~rx_dma_stable_tog;
              if (multiple_ints_diff_queue)
              begin
                rx_dma_complete_ok  <= 1'b1;
                rx_dma_resource_err <= 1'b0;
                buff_not_rdy_str <= from_rx_dma_used_bit_read;
                complete_ok_str  <= 1'b0;
              end
              else
              begin
                rx_dma_complete_ok  <= rx_descr_wr_done;
                rx_dma_resource_err <= from_rx_dma_used_bit_read;
              end
            end
            else
            begin
              wait_for_capt <= DONT_WAIT;
              rx_dma_resource_err <= 1'b0;
              rx_dma_complete_ok  <= 1'b0;
            end
          end

          else if (int_source)
          begin
            buff_not_rdy_str <= from_rx_dma_used_bit_read;
            complete_ok_str  <= rx_descr_wr_done;
          end
        end

        else if (int_source)
        begin
          wait_for_capt <= WAIT;
          rx_dma_stable_tog <= ~rx_dma_stable_tog;
          if (multiple_ints_diff_queue)
          begin
            rx_dma_complete_ok  <= 1'b1;
            rx_dma_resource_err <= 1'b0;
            buff_not_rdy_str <= from_rx_dma_used_bit_read;
            complete_ok_str  <= 1'b0;
          end
          else
          begin
            rx_dma_complete_ok  <= rx_descr_wr_done;
            rx_dma_resource_err <= from_rx_dma_used_bit_read;
          end
        end
      end
    end
  end

  assign multiple_ints_diff_queue = ((p_num_queues > 32'd1) &&
                                     ( rx_descr_wr_done &
                                      (from_rx_dma_used_bit_read) &
                                      (from_rx_dma_queue_ptr != b_rx_queue)));

  assign rx_dma_buff_not_rdy = rx_dma_resource_err;

  // Condition to generate interrupt
  // Generate interrupt once the writeback for the packet has finished ...
  // or when a buffer was requested but is not available
  // or when there is an AHB error (now handled directly in registers)

  assign rx_descr_wr_done = (bvalid & bready & ~b_is_tx & b_is_descr & b_is_last);
  assign int_source = (rx_descr_wr_done | from_rx_dma_used_bit_read);


  // Handling BRESP/RRESP errors
  // Simply pass to gem_registers, signal an interrupt and disable RX / TX
  always @ (posedge aclk or negedge n_areset)
  begin
    if  (~n_areset)
    begin
      disable_rx    <= 1'b0;
    end
    else
    begin
      if (~enable_rx)
        disable_rx  <= 1'b0;
      else
        disable_rx  <= disable_rx |
                       (bvalid & bready & ~b_is_tx & (bresp != 2'b00)) |
                       (rvalid & rready & ~r_is_tx & (rresp != 2'b00) & ~block_rx_descr_rd_resps[current_rx_queue_resp]);

    end
  end

  assign hresp_rx  = 2'b00;

  // Parity check of various internal buses if ASF DAP protection is configured.
  generate if (p_edma_asf_dap_prot == 1) begin : gen_asf_dap_chk
    wire  [p_num_queues-1:0]  dap_err_rd_fifo_out;
    wire                      dap_err_descr_addr;
    wire                      dap_err_data_addr;
    wire                      dap_err_wr_fifo_out;
    wire                      dap_err_hrdata_rx;
    reg                       asf_dap_axi_rx_err_r;

    genvar  loop_q;
    // There is a separate rx_descr_rd_fifo_out for each queue
    for (loop_q=0;loop_q<p_num_queues;loop_q=loop_q+1) begin : gen_rd_fifo_out_q
      cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_addr_width)) i_par_chk_rd_fifo_out (
        .odd_par(1'b0),
        .data_in(rx_descr_rd_fifo_out[loop_q]),
        .parity_in(rx_descr_rd_fifo_out_par[loop_q]),
        .parity_err(dap_err_rd_fifo_out[loop_q])
      );
    end

    cdnsdru_asf_parity_check_v1 #(.p_data_width(64)) i_par_chk_descr_addr (
      .odd_par(1'b0),
      .data_in(rx_descr_addr),
      .parity_in(rx_descr_addr_par),
      .parity_err(dap_err_descr_addr)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_addr_width)) i_par_chk_data_addr (
      .odd_par(1'b0),
      .data_in(rx_data_addr),
      .parity_in(rx_data_addr_par),
      .parity_err(dap_err_data_addr)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_par_chk_wr_fifo_out (
      .odd_par(1'b0),
      .data_in(rx_descr_wr_fifo_out),
      .parity_in(rx_descr_wr_fifo_par_out),
      .parity_err(dap_err_wr_fifo_out)
    );
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_edma_bus_width)) i_par_chk_hrdata (
      .odd_par(1'b0),
      .data_in(hrdata_rx),
      .parity_in(hrdata_rx_par),
      .parity_err(dap_err_hrdata_rx)
    );

    always @ (posedge aclk or negedge n_areset)
    begin
      if  (~n_areset)
        asf_dap_axi_rx_err_r  <= 1'b0;
      else
        asf_dap_axi_rx_err_r  <= (|dap_err_rd_fifo_out) |
                                  (|dap_err_rd_fifo_in) |
                                  dap_err_descr_addr    |
                                  dap_err_data_addr     |
                                  dap_err_wr_fifo_out   |
                                  dap_err_hrdata_rx;
    end
    assign asf_dap_axi_rx_err = asf_dap_axi_rx_err_r;
  end else begin : gen_no_asf_dap_chk
    assign asf_dap_axi_rx_err = 1'b0;
  end
  endgenerate


endmodule

