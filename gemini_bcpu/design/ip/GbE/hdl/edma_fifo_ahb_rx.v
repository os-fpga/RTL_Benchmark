//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_fifo_ahb_rx.v
//   Module Name:        edma_fifo_ahb_rx
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
//   Description :      The edma_rx module controls the storing of received
//                      data from the receive FIFO to the AHB memory device.
//
//                      Data storage is arranged into fixed length buffers with
//                      length defined by `rx_buffer_length.
//                      Each buffer may only contain data from a single frame,
//                      but a single frame may be spread between multiple
//                      buffers.
//
//                      Individual buffers are described by a pair of
//                      descriptors, contained in a separate queue. As each
//                      buffer is used the associated descriptors are updated
//                      to mark them as used and to writeback status for the
//                      frame contained in the buffer. The descriptor queue
//                      then moves onto the next pair of descriptors. This
//                      queue is referenced from a base address setup in the
//                      configuration registers.
//
//                      This module instantiates the receive FIFO which is
//                      written to by the gem_rx module. Once a valid buffer
//                      is available, the level of this FIFO is monitored until
//                      there is enough data in the FIFO to perform a fixed
//                      length burst to the AHB. At this point a request is made
//                      to the edma_ahb module, which arbitrates between
//                      RX and TX DMA operations and forms the correct AHB
//                      burst protocol.
//
//                      Once access to the AHB is granted, data is popped from
//                      the FIFO and passed to the AHB module. If an offset
//                      is specified, the data is first passed through an
//                      alignment buffer to introduce the offset before
//                      writing to memory. This request grant operation is
//                      repeated until all data in a frame is transferred.
//
//                      If an error occurs during this operation, no more
//                      AHB requests are made and the rest of the frame is
//                      flushed from the FIFO. This way when the next frame
//                      comes along the same buffer can be recovered and
//                      re-used. All errors are reported back to the PCLK
//                      domain registers block for status and statistics
//                      gathering.
//
//------------------------------------------------------------------------------
//   Limitations    :   Buffers depth affects latency. Configurable through
//                      `define according to system requirements
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_fifo_ahb_rx (

 // Inputs

 // global clk & reset
   n_hreset,                       // ahb domain reset
   hclk,                           // ahb clock
   rx_w_clk,                       // mac rx clock
   rx_w_rst_n,                     // mac rx clock domain reset

   // inputs coming from gem_mac (gem_rx - fifo interface).
   rx_w_wr,                        // fifo write strobe
   rx_w_data,                      // fifo write data (validated by rx_w_wr)
   rx_w_mod,                       // valid bytes of rx_w_data @ rx_w_eop
   rx_w_sop,                       // flag that rx_w_data has sop in first byte
   rx_w_eop,                       // flag that rx_w_data has eop
   rx_w_err,                       // flag that current packet is corrupted
   rx_w_flush,                     // fifo flush from the mac

   // inputs coming from the gem_mac (gem_rx - status), via hclk_syncs
   rx_w_bad_frame_hclk,            // Good/bad frame indication
   rx_w_ext_match1_hclk,           // external address recognized
   rx_w_ext_match2_hclk,           // external address recognized
   rx_w_ext_match3_hclk,           // external address recognized
   rx_w_ext_match4_hclk,           // external address recognized
   rx_w_add_match1_hclk,           // specific address 1 recognized
   rx_w_add_match2_hclk,           // specific address 2 recognized
   rx_w_add_match3_hclk,           // specific address 3 recognized
   rx_w_add_match4_hclk,           // specific address 4 recognized
   rx_w_type_mtch1_hclk,           // type id status field
   rx_w_type_mtch2_hclk,           // type id status field
   rx_w_type_mtch3_hclk,           // type id status field
   rx_w_type_mtch4_hclk,           // type id status field
   rx_w_frm_lngth_hclk,            // frame length field
   rx_w_vlan_tag_hclk,             // vlan tag status field
   rx_w_prty_tag_hclk,             // vlan priority field
   rx_w_tci_hclk,                  // vlan tci field
   rx_w_broadcast_hclk,            // broadcast address recognized
   rx_w_mult_hash_hclk,            // multi hash destination address recognition
   rx_w_uni_hash_hclk,             // uni hash destination address recognition
   rx_w_cksumi_ok_hclk,            // IP checksum checked and was OK.
   rx_w_cksumt_ok_hclk,            // TCP checksum checked and was OK.
   rx_w_cksumu_ok_hclk,            // UDP checksum checked and was OK.
   rx_w_snap_frame_hclk,           // Frame was SNAP encapsulated and valid VLAN
   rx_w_crc_error_hclk,            // Frame had FCS error

 // inputs coming from the bus interface (edma_ahb)
   rx_last_addr_ph,                // hready corresponding to last rx addr phase
   rx_last_data_ph,                // hready corresp to last rx data phase
   rx_dma_data_in,                 // incoming data (effectively hrdata)
   bus_idle,                       // no ahb activity, bus not requested
   rx_addr_inc_strobe,             // hready for rx addr phase
   rx_addr_strobe,                 // hready for rx addr phase
   rx_data_strobe,                 // hready for rx data phase
   rx_burst_error,                 // slave err while rx burst
   rx_addr_bus_owned,              // rx is driving the address on dma bus

 // signals coming from the hclk_syncs block
   enable_rx_hclk,                 // reception enabled - rx module operating
   new_rx_q_ptr_pulse,             // buffer queue base address updated
   rx_frame_end_pulse,             // flag indicating end of current frame
   rx_stat_capt_pulse,             // dma_rx status has been captured
   rx_buff_not_rdy_clr,            // pulse to clear rx_buff_not_rdy

 // signals coming from the register block
   rx_buff_q_base_addr,            // buffer queue (descriptor list) base addr
   rx_buffer_size,                 // buffer depth (in x64 bytes)
   rx_buffer_offset,               // offset of the data from buffer beginning
   dma_bus_width,                  // width of dma data bus
   ahb_burst_length,               // AHB burst length control
   rx_toe_enable,                  // Enable RX TCP Offload Engine.
   rx_no_crc_check,                // Ignore RX FCS check
   jumbo_enable,                   // Enable jumbo frames

 // Outputs

 // outputs going to gem_mac (gem_rx - fifo interface)
   rx_w_overflow,                  // overflow flag from fifo (write side)

 // outputs going to RX packet buffer if included
//   rx_w_fifo_count,                // number of locations occupied in fifo

 // outputs going to the bus interface
   rx_dma_state_man_wr,            // rx dma state management (descriptor) write
   rx_dma_state_man_rd,            // rx dma state management (descriptor) read
   rx_dma_state_data,              // rx dma state data (frame) storage
   rx_dma_bus_req,                 // rx dma bus request
   rx_dma_flow_error,              // rx dma data flow error
   rx_dma_burst_addr,              // rx next dma transfer address
   rx_dma_data_out,                // rx dma output data
   rx_data_burst_break,            // rx data burst must end next cycle
   rx_dma_eop_burst,               // rx dma initiated eop burst
   rx_dma_next_data,               // rx dma next state is data
   rx_dma_next_man_wr,             // rx dma next state is management write
   rx_dma_next_man_rd,             // rx dma next state is management read

 // outputs going to the gem_mac (gem_rx block)
   dma_rx_status_tog,              // descriptor write for last buffer done

 // outputs doing to the pclk_synch block
   rx_dma_stable_tog,              // Toggle indicating signals going to pclk
                                   // register are stable for sampling
 // outputs going to registers block (gem_registers)
   rx_dma_buff_not_rdy,            // used buffer descriptor read
   rx_dma_complete_ok,             // good frame is successfully stored
   rx_dma_resource_err,            // no buffers available for storage
   rx_dma_hresp_notok,             // hresp error during RX DMA
   rx_dma_descr_ptr,               // Current descriptor value for debug
   rx_dma_ptr_up_tog               // handshake for rx_dma_descr_ptr

 );


//-------------------------------------------
// Inputs declaration
//-------------------------------------------

 // global clk & reset
   input          n_hreset;            // global reset
   input          hclk;                // global clock
   input          rx_w_clk;            // mac rx clock
   input          rx_w_rst_n;          // mac rx clock domain reset

 // inputs coming from gem_mac (gem_rx - fifo interface).
   input          rx_w_wr;             // fifo write strobe
   input  [`edma_bus_width-1:0]     //
                  rx_w_data;           // fifo write data (validated by rx_w_wr)
   input    [3:0] rx_w_mod;            // valid bytes of rx_w_data @ rx_w_eop
   input          rx_w_sop;            // rx_w_data has sop in first byte
   input          rx_w_eop;            // rx_w_data has eop
   input          rx_w_err;            // current packet is corrupted
   input          rx_w_flush;          // fifo flush from the mac

 // inputs coming from the gem_mac (gem_rx - status).
   input          rx_w_bad_frame_hclk; // Good/bad frame indication
   input   [13:0] rx_w_frm_lngth_hclk; // frame length field
   input          rx_w_ext_match1_hclk;// external address 1 recognized
   input          rx_w_ext_match2_hclk;// external address 2 recognized
   input          rx_w_ext_match3_hclk;// external address 3 recognized
   input          rx_w_ext_match4_hclk;// external address 4 recognized
   input          rx_w_add_match1_hclk;// specific address 1 recognized
   input          rx_w_add_match2_hclk;// specific address 2 recognized
   input          rx_w_add_match3_hclk;// specific address 3 recognized
   input          rx_w_add_match4_hclk;// specific address 4 recognized
   input          rx_w_type_mtch1_hclk;// Type ID 1 recognized
   input          rx_w_type_mtch2_hclk;// Type ID 2 recognized
   input          rx_w_type_mtch3_hclk;// Type ID 3 recognized
   input          rx_w_type_mtch4_hclk;// Type ID 4 recognized
   input          rx_w_broadcast_hclk; // broadcast address recognized
   input          rx_w_mult_hash_hclk; // multi hash address recognition
   input          rx_w_uni_hash_hclk;  // uni hash address recognition
   input          rx_w_vlan_tag_hclk;  // vlan tag status field
   input          rx_w_prty_tag_hclk;  // priority field
   input    [3:0] rx_w_tci_hclk;       // tci field
   input          rx_w_cksumi_ok_hclk; // IP checksum checked and was OK.
   input          rx_w_cksumt_ok_hclk; // TCP checksum checked and was OK.
   input          rx_w_cksumu_ok_hclk; // UDP checksum checked and was OK.
   input          rx_w_snap_frame_hclk;// SNAP encapsulated & valid VLAN
   input          rx_w_crc_error_hclk; // Frame had FCS error

 // inputs coming from the bus interface
   input          rx_last_data_ph;     // hready corresp to last rx addr phase
   input          rx_last_addr_ph;     // hready corresp to last rx data phase
   input   [31:0] rx_dma_data_in;      // incoming data (effectively hrdata)
   input          bus_idle;            // no ahb activity, bus not requested
   input          rx_addr_inc_strobe;  // hready for rx addr phase
   input          rx_addr_strobe;      // hready for rx addr phase
   input          rx_data_strobe;      // hready for rx data phase
   input          rx_burst_error;      // slave err while rx burst
   input          rx_addr_bus_owned;   // rx is driving the address on dma bus

 // signals coming from the hclk_syncs block
   input          enable_rx_hclk;      // reception enabled
   input          new_rx_q_ptr_pulse;  // buffer queue base address updated
   input          rx_frame_end_pulse;  // flag indicating end of current frame
   input          rx_stat_capt_pulse;  // dma_rx status has been captured
   input          rx_buff_not_rdy_clr; // pulse to clear corresponding flag

 // signals coming from the register block
   input   [31:2] rx_buff_q_base_addr; // buffer queue base addr
   input    [7:0] rx_buffer_size;      // buffer depth (in x64 bytes)
   input    [1:0] rx_buffer_offset;    // offset of the data from buffer start
   input    [1:0] dma_bus_width;       // width of dma data bus
   input    [4:0] ahb_burst_length;    // AHB burst length control
   input          rx_toe_enable;       // Enable RX TCP Offload Engine.
   input          rx_no_crc_check;     // Ignore RX FCS check.
   input          jumbo_enable;        // Enable jumbo packets.

//-------------------------------------------
// Ouputs declaration
//-------------------------------------------

 // outputs going to the bus interface
   output         rx_dma_state_man_wr; // rx dma state descriptor write
   output         rx_dma_state_man_rd; // rx dma state descriptor read
   output         rx_dma_state_data;   // rx dma state frame storage
   output         rx_dma_bus_req;      // rx dma bus request
   output         rx_dma_flow_error;   // rx dma data flow error
   output  [31:2] rx_dma_burst_addr;   // rx next dma transfer address
   output [127:0] rx_dma_data_out;     // rx dma output data
   output         rx_data_burst_break; // rx data burst must end next cycle
   output         rx_dma_next_data;    // rx dma next state is data
   output         rx_dma_next_man_wr;  // rx dma next state is management wr
   output         rx_dma_next_man_rd;  // rx dma next state is management rd
   output         rx_dma_eop_burst;    // rx dma initiated eop burst

 // outputs going to gem_mac (gem_rx - fifo interface)
   output         rx_w_overflow;       // overflow flag from fifo (write side)

 // outputs going to RX packet buffer if included
//   output[(`edma_rx_fifo_cnt_width-1):0]// number of locations occupied
//                  rx_w_fifo_count;     // in fifo

 // outputs going to the rx block
   output         dma_rx_status_tog;   // last buffer descriptor write done

 // outputs doing to the pclk_synch block
   output         rx_dma_stable_tog;   // Toggles to indicate that signals
                                       // going to pclk register are stable
                                       // for sampling
 // outputs going to registers block (pclk)
   output         rx_dma_buff_not_rdy; // used buffer descriptor read
   output         rx_dma_complete_ok;  // good frame is successfully stored
   output         rx_dma_resource_err; // no buffers available for storage
   output         rx_dma_hresp_notok;  // hresp error during RX DMA
   output  [31:2] rx_dma_descr_ptr;    // current buffer descriptor address
   output         rx_dma_ptr_up_tog;   // handshake for rx_dma_descr_ptr


//-------------------------------------------
// Internal signals declaration
//-------------------------------------------

   // Main state machine
   reg      [2:0] rx_dma_state;        // current rx dma state
   reg      [2:0] rx_dma_next;         // next rx dma state
   wire           rx_dma_state_wait;   // waiting for new buffer request
   wire           rx_dma_state_data;   // storing frame data
   wire           rx_dma_state_man_rd; // reading buffer descriptor
   wire           rx_dma_state_man_wr; // writing buffer status in descriptor

   // buffer length calculations
   reg            rx_buffer_required;  // new buffer descriptor must be read
   reg            rx_buffer_available; // set if pointed to buffer not used
   reg     [30:0] rx_buff_depth;       // buffer depth (in 32-bit words)
   wire    [30:0] rx_buff_left;        // free word locations in current buffer
   wire           nxt_left_lt_zero;    // next rx_buff_left less than 0
   wire           rx_buffer_full;      // no free word locations in buffer

   // AHB request logic
   wire [`edma_rx_fifo_cnt_width+4:0]   //
                  burst_length;        // Programmed burst length expanded
   wire [`edma_rx_fifo_cnt_width-1:0]   //
                  max_burst_length;    // Maximum possible AHB burst from FIFO
   reg            data_available;      // frame data available for storage
   reg            storage_in_progress; // current frame is being stored to mem
   reg            rx_bus_required;     // rx dma must perform a dma transfer
   reg            waiting_for_ahb;     // rx dma waiting for a dma transfer
   wire           rx_dma_bus_req;      // request to AHB for a dma transfer
   reg            rx_data_burst_break; // burst must end after next transfer

   // AHB address generation - Descriptor Queue
   reg            rx_buffer_wrap;      // wrap descriptor queue pointer
   reg     [31:2] rx_buffer_descr_ptr; // current buffer descriptor address
   wire    [31:2] rx_descr_wd1_addr;   // wd1 of current buffer descriptor
   wire    [31:2] rx_descr_next_addr;  // next buffer descriptor address
   wire           rx_descr_ptr_update; // change address of buffer descriptor
   reg            rx_dma_ptr_up_tog;   // handhshake for rx_dma_descr_ptr

   // AHB address generation - Buffer data address
   reg     [31:2] rx_buffer_start_addr;// start address of the current buffer
   reg     [31:2] rx_data_next_addr;   // next data location to be written to
   reg     [31:2] rx_data_store_addr;  // data location to be written to

   // AHB address generation - Output generation
   reg     [31:2] rx_dma_burst_addr;   // next dma transfer address

   // AHB data generation
   reg            rx_type_match_flag;  // type id recognised flag
   reg      [1:0] rx_type_match_code;  // encoded type id number
   wire           rx_add_match_flag;   // specific address recognized flag
   wire     [1:0] rx_add_match_code;   // encoded specific address number
   wire           rx_ext_match_flag;   // external address recognised
   reg            rx_sof;              // frame field sof transferred to memory
   reg    [127:0] rx_dma_data_out;     // output data for the current transfer

   // Data offset alignment logic
   reg    [127:0] rx_adj_data_out;     // frame data popped from fifo and
                                       // adjusted according to buffer offset
   reg     [23:0] offset_data_residue; // leftover after data popped from fifo
                                       // is offset (1, 2 or 3 bytes)
   wire     [4:0] number_in_residue;   // number of bytes in residue
   reg            residue_left;        // flag indicating the last data popped
                                       // from fifo + residue from penultimate
                                       // fifo pop overflows the data bus width

   // AHB decoding
   wire           rx_man_rd_data_strb; // hready @ data phase of descr. read
   wire           rx_man_wr_data_strb1;// data phase of 1st descriptor write
   wire           rx_man_wr_data_strb2;// data phase of 2nd descriptor write
   wire           rx_man_wr_data_strb; // data phase of either descriptor write
   wire           rx_man_wr_done;      // descriptor write done

   // Detect EOP
   wire           eof_transfer;        // address phase of eof transfer
   wire           last_data_to_buffer; // last data transferred to buffer
   reg            rx_fifo_eop_dly;     // delayed rx_fifo_eop
   reg            eop_in_residue;      // detect when EOP is in offset buffer
   reg            rx_dma_eop_burst;    // rx dma initiated last burst in buffer

   // Status and Error reporting - gem_rx handshaking
   reg            dma_rx_status_tog;   // Handshaking toggle back to gem_rx
   reg            rx_frame_end_flag;   // flag indicates end of frame received
   reg            rx_good_end_flag;    // flag indicates good frame received

   // Status and Error reporting - Detect & store error conditions
   wire           rx_buffer_used_bit;  // Descr. read shows buffer already used.
   reg            rx_resource_err;     // internal flag for lack of resources
   reg            rx_hresp_notok;      // internal flag for hresp error

   // Status and Error reporting - Update status to PCLK
   reg            rx_eof_written;      // frame field eof transferred to memory
   reg            last_man_wr_complete;// last management write successful
   reg            update_status;       // pulse to trigger PCLK status update
   reg            rx_dma_stable_tog;   // Toggles to indicate that signals
                                       // going to pclk register are stable
                                       // for sampling
   reg            rx_dma_status_stable;// flag preventing status outputs
                                       // changing before they are sampled.
   reg            rx_dma_resource_err; // status flag - lack of resources
   reg            rx_dma_complete_ok;  // status flag - stored successfully
   reg            rx_dma_hresp_notok;  // status flag - hresp error
   reg            rx_dma_buff_not_rdy; // used buffer descriptor read

   // FIFO POP logic
   wire           drop_frame;          // drop frame if no resources available
                                       // to store it
   reg            frame_not_cleared;   // flag indicating eop not cleared,
                                       // whilst popping until empty
   wire           clear_frame;         // clear frame from FIFO.
   reg            rx_fifo_pop_to_clear;// hold clear_frame until complete.
   reg            delay_pop_to_clear;  // delay rx_fifo_pop_to_clear and
                                       // control rate at which FIFO is popped.
   wire           rx_fifo_pop;         // pulse to pop data from fifo
   reg            rx_fifo_pop_del;     // delayed rx_fifo_pop for count detect

   // RX FIFO instantiation
   wire           rx_fifo_valid;       // qualifies outputs from FIFO.
   wire           rx_fifo_eop;         // eop is output from fifo (last valid B)
   wire           rx_fifo_sop;         // sop is output from fifo (1st byte)
   wire     [3:0] rx_fifo_mod;         // number of valid bytes in FIFO data
   wire           rx_fifo_err;         // corrupted packet is output from fifo
   wire   [128:0] rx_fifo_data_out;    // output data from rx fifo
   wire  [`edma_bus_width-1:0]      //
                  rx_fifo_data_out_pad;// temporary output data from rx fifo
   wire  [(`edma_rx_fifo_cnt_width-1):0]// number of valid read
                  rx_fifo_count;       // locations in FIFO
   wire           rx_fifo_pkt_comp;    // a complete packet is in fifo
//   wire [(`edma_rx_fifo_cnt_width-1):0] // number of locations occupied
//                  rx_w_fifo_count;     // in fifo (only used by packet buffer)
   reg            rx_astrobe_in_manwr; // En for 2nd rx_addr_strobe in man wr
   wire           astrobe_manwr_2nd;   // 2nd addr strobe in man_wr state
   wire           setup_manrd_add;     // hold man_rd descr address onto
                                       // dma_burst_addr
   reg            wait4manrdreqph;     // Wait for man_rd request phase to begin
   reg            wait4manrdaddph;     // high on end of man_wr, low on man_rd
                                       // add phase
   reg            nxtdstrobeis2ndmanwr;// last dma state was man_wr

   reg            rx_w_vlan_tag_eop;
   reg            rx_w_prty_tag_eop;
   reg  [3:0]     rx_w_tci_eop;



//-------------------------------------------
// Parameters declaration
//-------------------------------------------

   // dma_rx_sm state lables
   parameter
      RX_DMA_IDLE          = 3'b000,    // RX disabled
      RX_DMA_WAIT_BUFF_REQ = 3'b001,    // wait for rx_buffer_required
      RX_DMA_MAN_RD        = 3'b010,    // Management read
      RX_DMA_DATA_STORE    = 3'b011,    // Data store
      RX_DMA_MAN_WR        = 3'b100;    // Management write



//******************************************************************************
// Main state machine
//******************************************************************************

   // rx_dma_state - current state of the state machine
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            rx_dma_state <= RX_DMA_IDLE;
            nxtdstrobeis2ndmanwr <= 1'b0;
         end
      else
         begin
            rx_dma_state <= rx_dma_next;
            if (rx_data_strobe)
               nxtdstrobeis2ndmanwr  <= (rx_dma_state == RX_DMA_MAN_WR) &
                                        ~rx_burst_error;
         end
   //------------------------------------------------


   // rx_dma_next - next state evaluation for the dma_rx state machine
   //------------------------------------------------
   always@(rx_dma_state or enable_rx_hclk or rx_buffer_required or
           rx_buffer_used_bit or rx_data_strobe or bus_idle or
           rx_burst_error or last_data_to_buffer or clear_frame or
           astrobe_manwr_2nd or rx_man_wr_data_strb2)

      case (rx_dma_state)

         // RX_DMA_WAIT_BUFF_REQ:
         // wait for new buffer request; no ahb activity
         //---------------------------------------------------------------------
         RX_DMA_WAIT_BUFF_REQ:

            // If receive is disabled return to idle
            if (~enable_rx_hclk)
               rx_dma_next = RX_DMA_IDLE;

            // new buffer required and bus is now idle
            else if (rx_buffer_required & bus_idle)
               rx_dma_next = RX_DMA_MAN_RD;

            // Otherwise wait for rx_buffer_required
            else
               rx_dma_next = RX_DMA_WAIT_BUFF_REQ;


         // RX_DMA_MAN_RD:
         // read current buffer descriptor word_0; ahb read burst and transition
         // according to the state of the ownership bit:
         //   0 (buffer not used) - go to data state
         //   1 (buffer used) - go to wait buff req state
         //---------------------------------------------------------------------
         RX_DMA_MAN_RD:

            // If receive is disabled return to idle
            if (~enable_rx_hclk)
               rx_dma_next = RX_DMA_IDLE;

            // bus err or buffer used
            else if (rx_burst_error | rx_buffer_used_bit)
               rx_dma_next = RX_DMA_WAIT_BUFF_REQ;

            // not used so go to data state
            else if (rx_data_strobe & ~rx_man_wr_data_strb2)
               rx_dma_next = RX_DMA_DATA_STORE;

            // buffer descriptor not read yet
            else
               rx_dma_next = RX_DMA_MAN_RD;


         // RX_DMA_DATA_STORE:
         // if enough data for a burst, then store it while space in current
         // buffer available; if error discard frame & recover buffer
         //---------------------------------------------------------------------
         RX_DMA_DATA_STORE:

            // If receive is disabled return to idle
            if (~enable_rx_hclk)
               rx_dma_next = RX_DMA_IDLE;

            // current buffer full or whole frame transferred and last addr
            // phase of the bus transaction
            else if (last_data_to_buffer)
               rx_dma_next = RX_DMA_MAN_WR;

            // more frame data to be transferred and space is available
            else
               rx_dma_next = RX_DMA_DATA_STORE;


         // write back the buffer descriptor according to the frame storage
         // status ahb write burst
         //---------------------------------------------------------------------
         RX_DMA_MAN_WR:

            // If receive is disabled return to idle
            if (~enable_rx_hclk)
               rx_dma_next = RX_DMA_IDLE;

            // hresp or other error in writeback, can't recover buffer.
            else if (rx_burst_error | clear_frame)
               rx_dma_next = RX_DMA_WAIT_BUFF_REQ;

            // last descriptor write back address taken
            else if (astrobe_manwr_2nd)
               rx_dma_next = RX_DMA_MAN_RD;

            // status for current buff not written yet
            else
               rx_dma_next = RX_DMA_MAN_WR;


         // RX_DMA_IDLE:
         // reception not enabled; no ahb activity
         //---------------------------------------------------------------------
         default: //RX_DMA_IDLE:

            // stay in idle whilst receive is disabled
            if (~enable_rx_hclk)
               rx_dma_next = RX_DMA_IDLE;

            // enabled so request buffer
            else
               rx_dma_next = RX_DMA_WAIT_BUFF_REQ;

      endcase
   //------------------------------------------------


   //decoding of the current and next state
   //------------------------------------------------
   assign rx_dma_state_wait   = rx_dma_state==RX_DMA_WAIT_BUFF_REQ;
   assign rx_dma_state_data   = rx_dma_state==RX_DMA_DATA_STORE;
   assign rx_dma_state_man_rd = rx_dma_state==RX_DMA_MAN_RD;
   assign rx_dma_state_man_wr = rx_dma_state==RX_DMA_MAN_WR;
   assign rx_dma_next_man_rd  = rx_dma_next==RX_DMA_MAN_RD;
   assign rx_dma_next_man_wr  = rx_dma_next==RX_DMA_MAN_WR;
   assign rx_dma_next_data    = rx_dma_next==RX_DMA_DATA_STORE;
   //------------------------------------------------

//******************************************************************************
// Detect the address strobe on the second man write
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            rx_astrobe_in_manwr <= 1'b0;
         end
      else if (~rx_dma_state_man_wr)
         begin
            rx_astrobe_in_manwr <= 1'b0;
         end
      else
         begin
            if (rx_addr_strobe)
               rx_astrobe_in_manwr <= 1'b1;
         end

assign astrobe_manwr_2nd = rx_dma_state_man_wr &
                          ((rx_data_strobe & rx_addr_strobe) |
                           (rx_astrobe_in_manwr & rx_addr_strobe));

// If rx_addr_inc_strobe is low on the 2nd man_wr add strobe cycle,
// then set this signal high until rx_addr_inc_strobe gets set (i.e. the
// man_rd access begins)
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         wait4manrdreqph <= 1'b0;
      else if (rx_addr_inc_strobe | rx_burst_error)
         wait4manrdreqph <= 1'b0;
      else if (astrobe_manwr_2nd)
         wait4manrdreqph <= 1'b1;

assign setup_manrd_add = (astrobe_manwr_2nd | wait4manrdreqph);


//******************************************************************************
// buffer length calculations
//******************************************************************************

   // rx_buffer_required  - indicates when a new buffer is required, and is
   //                       used to force a management read.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_buffer_required <= 1'b1;

      // when first enabled we always need a new buffer
      else if (~enable_rx_hclk)
         rx_buffer_required <= 1'b1;

      // descriptor read complete, have a new buffer
      else if (rx_man_rd_data_strb)
         rx_buffer_required <= 1'b0;

      // no buffer was available for last frame, so wait until end of
      // next frame before trying for a new buffer
      else if (rx_dma_state_wait & rx_fifo_eop & rx_fifo_valid)
         rx_buffer_required <= 1'b1;

      // buffer filled completely with data of one frame, so need a new one.
      else if (rx_dma_state_data & rx_buffer_full &
               rx_addr_strobe & ~clear_frame)
         rx_buffer_required <= 1'b1;

      // hresp error during management writeback. Current buffer cannot be
      // recovered, so get a new one.
      else if (rx_man_wr_data_strb & rx_burst_error)
         rx_buffer_required <= 1'b1;

      // Else maintain value
      else
         rx_buffer_required <= rx_buffer_required;
   //------------------------------------------------


   // rx_buffer_available - set when descriptor is read and buffer_used bit
   //                       is low;
   //                       cleared upon reset and when a buffer is filled and
   //                       no error, because at this point buffer
   //                       is recovered;
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_buffer_available <= 1'b0;

      // If receive is disabled reset
      else if (~enable_rx_hclk)
         rx_buffer_available <= 1'b0;

      // sample used bit on last data phase of rx_descriptor wd0 read
      else if (rx_man_rd_data_strb)
         rx_buffer_available <= ~rx_dma_data_in[0];

      // reset when buffer is full and there is not an error popped
      // from the fifo.
      else if (rx_addr_strobe & rx_buffer_full & rx_dma_state_data &
               ~clear_frame)
         rx_buffer_available <= 1'b0;

      // Else maintain value
      else
         rx_buffer_available <= rx_buffer_available;
   //------------------------------------------------


   // rx_buffer_depth - this is the depth of the buffer, expressed in
   //                   number of 32-bit words. One access worth of words
   //                   is subtracted to make decoding the buffer full easier.
   //------------------------------------------------
   always @(dma_bus_width or rx_buffer_size)
      case (dma_bus_width)
         2'b00  : rx_buff_depth = {19'd0,rx_buffer_size[7:0],4'd0}-31'h00000001;
         2'b01  : rx_buff_depth = {19'd0,rx_buffer_size[7:0],4'd0}-31'h00000002;
         default: rx_buff_depth = {19'd0,rx_buffer_size[7:0],4'd0}-31'h00000004;
      endcase
   //------------------------------------------------


   // Detect if next buffer left count is going to be less than zero.
   // If this is the case the count should be zeroed.
   //------------------------------------------------
   wire [30:0] rx_buffer_start_addr_p_buff_depth;
   assign      rx_buffer_start_addr_p_buff_depth =
               (rx_buffer_start_addr[31:2] +
                rx_buff_depth[29:0]);
   
   assign nxt_left_lt_zero =
         (rx_data_store_addr[31:2] > rx_buffer_start_addr_p_buff_depth[29:0]);
              
   //------------------------------------------------


   // rx_buff_left indicates how many 32-bit words are available in the buffer
   //------------------------------------------------
   assign rx_buff_left = (nxt_left_lt_zero)? 31'h00000000 :
                                             rx_buffer_start_addr[31:2] +
                                             rx_buff_depth[29:0] -
                                             rx_data_store_addr[31:2];
   //------------------------------------------------


   // rx_buffer_full is set when there is no space left in the rx buffer
   //------------------------------------------------
   assign rx_buffer_full = (rx_buff_left == 31'h00000000);
   //------------------------------------------------



//******************************************************************************
// AHB request logic
//******************************************************************************

   // burst_length  - Expand programmed ahb_burst_length to make compare easy
   //                 and to prevent out of range compile error for
   //                 `edma_rx_fifo_cnt_width > 4.
   //------------------------------------------------
   assign burst_length = {{`edma_rx_fifo_cnt_width{1'b0}},ahb_burst_length[4:0]};
   //------------------------------------------------

   // max_burst_length - Pick off required bits from burst_length
   //                    NOTE: programmed burst length must be less than the
   //                          depth of the FIFO.
   //------------------------------------------------
   assign max_burst_length = burst_length[`edma_rx_fifo_cnt_width-1:0];
   //------------------------------------------------


   // data_available - indicates enough valid locations in the fifo, so a burst
   //                  can be initiated to transfer them in the storage buffer.
   //------------------------------------------------
   always @(clear_frame or rx_fifo_count or rx_last_addr_ph
            or rx_dma_state_data or rx_fifo_eop_dly
            or eop_in_residue or rx_fifo_pkt_comp or rx_fifo_pop_del
            or max_burst_length)

      // reset when there is an error with the frame
      if (clear_frame)
         data_available = 1'b0;

      // set at the end of a burst and there is enough data for new transfer
      else if (rx_dma_state_data & rx_last_addr_ph &
               (rx_fifo_count > max_burst_length))
         data_available = 1'b1;

      // set when there is enough data for new transfer and not doing a burst
      else if (~rx_fifo_pop_del & (rx_fifo_count >= max_burst_length))
         data_available = 1'b1;

      // set when the EOP has been written into the FIFO
      else if (rx_fifo_pkt_comp)
         data_available = 1'b1;

      // Keep set if the EOP is in the offset buffer
      else if ((rx_fifo_eop_dly & rx_dma_state_data) | eop_in_residue)
         data_available = 1'b1;

      // Otherwise there's not enough data to transfer
      else
         data_available = 1'b0;
   //------------------------------------------------


   // storage_in_progress - indicating the storage of the current frame has
   //                       been initiated - at least one buffer is available
   //                       and data transfer has started; cleared when the
   //                       last frame data is to be popped from the fifo or
   //                       if any error reported from the bus or rx path;
   //                       also cleared if rx is disabled & frame discarded
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         storage_in_progress <= 1'b0;
      else if (~enable_rx_hclk)
         storage_in_progress <= 1'b0;
      else if (clear_frame | eof_transfer)
         storage_in_progress <= 1'b0;
      else if (rx_buffer_available & rx_dma_state_data & rx_addr_strobe)
         storage_in_progress <= 1'b1;
      else
         storage_in_progress <= storage_in_progress;
   //------------------------------------------------


   // rx_bus_required- signal indicating the dma_rx blocks requires some kind
   //                  of data transfer through the dma interface;
   //------------------------------------------------
   always @(rx_dma_state_wait or rx_buffer_required or
            rx_man_rd_data_strb or rx_buffer_used_bit or
            data_available or rx_dma_state_man_wr or rx_dma_state_data or
            rx_last_addr_ph or last_data_to_buffer or
            rx_addr_bus_owned or rx_dma_flow_error)

      // don't request if disabled or a flow error
      if (rx_dma_flow_error)
         rx_bus_required = 1'b0;

      // about to do a management read and we haven't just done a writeback
      // This only happens when we have just been enabled, or when there
      // was a problem with the previous buffer read (used bit read or
      // hresp error)
      else if (rx_dma_state_wait & rx_buffer_required)
         rx_bus_required = 1'b1;

      // Got a good buffer from management read, so start requesting for
      // the data if it's available immediately.
      else if (rx_man_rd_data_strb & ~rx_buffer_used_bit & data_available)
         rx_bus_required = 1'b1;

      // Trying to do a writeback, but not on the bus yet, so keep requesting.
      // The AHB does this as a burst of three including the next managment
      // read.
      else if (rx_dma_state_man_wr & ~rx_addr_bus_owned)
         rx_bus_required = 1'b1;

      // More data available to write, so keep requesting
      else if (rx_dma_state_data & data_available)
         rx_bus_required = 1'b1;

      // last data in buffer so request for management writeback. The AHB
      // does this as a burst of three including the next managment read.
      else if (rx_dma_state_data & rx_last_addr_ph & last_data_to_buffer)
         rx_bus_required = 1'b1;

      // Otherwise we don't need the bus
      else
         rx_bus_required = 1'b0;
   //------------------------------------------------


   // waiting_for_ahb - set we require the bus and used to hold request to AHB
   //                   until we own the address bus.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         waiting_for_ahb <= 1'b0;

      // terminate request if receive is disabled
      else if (~enable_rx_hclk)
         waiting_for_ahb <= 1'b0;

      // error on access so terminate request
      else if (rx_dma_flow_error)
         waiting_for_ahb <= 1'b0;

      // we now own the address bus so it is safe to deassert request
      else if (rx_addr_bus_owned)
         waiting_for_ahb <= 1'b0;

      // bus required so hold request
      else if (rx_bus_required)
         waiting_for_ahb <= 1'b1;

      // else maintain value
      else
         waiting_for_ahb <= waiting_for_ahb;
   //------------------------------------------------


   // rx_dma_bus_req - request to AHB DMA for access to the bus. Held until
   //                  we know that we have the bus, or there is an error.
   //------------------------------------------------
   assign rx_dma_bus_req = enable_rx_hclk & ~rx_dma_flow_error &
                           (rx_bus_required |
                            (waiting_for_ahb & ~rx_addr_bus_owned));
   //------------------------------------------------


   // rx_data_burst_break - signal indicating this is the last fifo location
   //                       holding data of the current frame and causing
   //                       the ongoing burst for storing it into memory to
   //                       terminate after transfering this location;
   //------------------------------------------------
   always @(rx_dma_state_data or rx_addr_strobe or rx_fifo_eop or
            rx_fifo_valid or rx_fifo_eop_dly or eop_in_residue or
            rx_buffer_full or residue_left or storage_in_progress)

      // Burst is on-going and EOP popped, so next access is last.
      if (rx_dma_state_data & rx_addr_strobe & rx_fifo_eop & rx_fifo_valid)
         rx_data_burst_break = 1'b1;

      // Burst is on-going and EOP is in the residue, so next access is last.
      else if (rx_dma_state_data & rx_addr_strobe &
                 (rx_fifo_eop_dly | eop_in_residue))
         rx_data_burst_break = 1'b1;

      // buffer will be filled on next access
      else if (rx_buffer_full)
         rx_data_burst_break = 1'b1;

      // Burst is on-going, but no break conditions
      else if (rx_dma_state_data & rx_addr_strobe)
         rx_data_burst_break = 1'b0;

      // One to transfer and EOP popped and no offset residue
      else if (rx_fifo_eop & rx_fifo_valid & ~residue_left &
               storage_in_progress)
         rx_data_burst_break = 1'b1;

      // One to transfer and last offset buffer
      else if (rx_fifo_eop_dly & storage_in_progress)
         rx_data_burst_break = 1'b1;

      // Otherwise no break
      else
         rx_data_burst_break = 1'b0;
   //------------------------------------------------



//******************************************************************************
// AHB address generation - Descriptor Queue
//******************************************************************************

   // rx_buffer_wrap - indicates the current buffer is the last one in the
   //                  descriptor list, and the queue should now wrap.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_buffer_wrap <= 1'b0;
      else if (~enable_rx_hclk)
         rx_buffer_wrap <= 1'b0;
      else if (rx_man_rd_data_strb)
         rx_buffer_wrap <= rx_dma_data_in[1];
      else
         rx_buffer_wrap <= rx_buffer_wrap;
   //------------------------------------------------


   // rx_buffer_descr_ptr - indicates the position in the receive buffer
   //                       descriptor list.
   // rx_dma_ptr_up_tog   - Toggle signal to indicate rx_buffer_descr_ptr
   //                       has been updated and is to be sampled into pclk.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            rx_buffer_descr_ptr <= 30'd0;
            rx_dma_ptr_up_tog   <= 1'b0;
         end

      // Reset to base address if the base of the descriptor list is modified
      // or last entry in the list is successfully updated
      else if (new_rx_q_ptr_pulse | (rx_descr_ptr_update & rx_buffer_wrap))
         begin
            rx_buffer_descr_ptr <= rx_buff_q_base_addr;
            rx_dma_ptr_up_tog   <= ~rx_dma_ptr_up_tog;
         end

      // current buffer descriptor successfully updated and not last in
      // the list
      else if (rx_descr_ptr_update)
         begin
            rx_buffer_descr_ptr <= rx_descr_next_addr[31:2];
            rx_dma_ptr_up_tog   <= ~rx_dma_ptr_up_tog;
         end

      // Else maintain value
      else
         begin
            rx_buffer_descr_ptr <= rx_buffer_descr_ptr;
            rx_dma_ptr_up_tog   <= rx_dma_ptr_up_tog;
         end
   //------------------------------------------------


   // Decode addresses of descriptors for easy referencing
   //------------------------------------------------
   wire [30:0] rx_buffer_descr_ptr_p2;
   assign      rx_buffer_descr_ptr_p2 = rx_buffer_descr_ptr + 30'h00000002;
   
   assign rx_descr_wd1_addr[31:2]  = rx_buffer_descr_ptr + 30'h00000001;
   assign rx_descr_next_addr[31:2] = rx_buffer_descr_ptr_p2[29:0];
   //------------------------------------------------


// Detect twhen the address strobe of the man_rd following a man wr is high
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         wait4manrdaddph <= 1'b0;
      else if (rx_addr_strobe | rx_burst_error)
         wait4manrdaddph <= 1'b0;
      else if (rx_man_wr_done)
         wait4manrdaddph <= 1'b1;


   // rx_descr_ptr_update - enable signal for increment or wrap of
   //                       rx_buffer_descr_ptr. This happens after the man_wr
   //                       of the previous packet
   //------------------------------------------------
   assign rx_descr_ptr_update = (rx_man_wr_done | wait4manrdaddph) &
                                 (rx_addr_strobe | rx_burst_error);
   //------------------------------------------------


   // rx_dma_descr_ptr - Assign value going back to register block
   //                    for reading in test debug
   //------------------------------------------------
   assign rx_dma_descr_ptr = rx_buffer_descr_ptr;
   //------------------------------------------------



//******************************************************************************
// AHB address generation - Buffer data address
//******************************************************************************

   // rx_buffer_start_addr - start address of the current buffer; saved so that
   //                        it can be written in the descriptor status when
   //                        current buffer is dealt with. Also used for
   //                        calculating how many locations are left in buffer.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_buffer_start_addr <= 30'd0;
      else if (~enable_rx_hclk)
         rx_buffer_start_addr <= 30'd0;
      else if (rx_man_rd_data_strb)
         rx_buffer_start_addr <= rx_dma_data_in[31:2];
      else
         rx_buffer_start_addr <= rx_buffer_start_addr;
   //------------------------------------------------


   // rx_data_next_addr - increments by the size of the bus access
   //------------------------------------------------
   
   // This is done for LINT purposes
   wire [30:0] rx_data_store_addr_31_2_p2;
   wire [30:0] rx_data_store_addr_31_2_p4;
   assign      rx_data_store_addr_31_2_p2 = rx_data_store_addr[31:2] + 30'h00000002;
   assign      rx_data_store_addr_31_2_p4 = rx_data_store_addr[31:2] + 30'h00000004;
   
   always @ *
      case (dma_bus_width)
         // dma bus width 32 bits
         2'b00  : rx_data_next_addr[31:2] = rx_data_store_addr[31:2] + 30'h00000001;
         // dma bus width 64 bits
         2'b01  : rx_data_next_addr[31:2] = rx_data_store_addr_31_2_p2[29:0];
         // dma bus width 128 bits
         default: rx_data_next_addr[31:2] = rx_data_store_addr_31_2_p4[29:0];
      endcase
   //------------------------------------------------


   // rx_data_store_addr - the word address of the next storage location
   //                      within the current buffer.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_data_store_addr <= 30'd0;
      else if (~enable_rx_hclk)
         rx_data_store_addr <= 30'd0;

      // If an error and the buffer is being recovered load with saved address
      else if (clear_frame)
         rx_data_store_addr <= rx_buffer_start_addr;

       // sample and hold start address during management read.
      else if (rx_man_rd_data_strb)
         rx_data_store_addr  <= rx_dma_data_in[31:2];

      // Take new incremented value on every address strobe (look ahead version)
      else if (rx_dma_state_data & rx_addr_inc_strobe)
         rx_data_store_addr[31:2] <= rx_data_next_addr[31:2];

      // Else maintain value
      else
         rx_data_store_addr  <= rx_data_store_addr;
   //------------------------------------------------



//******************************************************************************
// AHB address generation - Output generation
//******************************************************************************

   // rx_dma_burst_addr - burst address to the AHB module.
   //------------------------------------------------
   always @(rx_dma_state_data or rx_data_store_addr or
            rx_dma_state_man_wr or setup_manrd_add or
            rx_buffer_wrap or rx_buff_q_base_addr or
            rx_descr_next_addr or rx_addr_bus_owned or
            rx_descr_wd1_addr or rx_buffer_descr_ptr or
            rx_astrobe_in_manwr)

      // Storing data
      if (rx_dma_state_data)
         rx_dma_burst_addr = rx_data_store_addr;

      // Setup address for next management read if wrapping
      else if (setup_manrd_add & rx_buffer_wrap)
         rx_dma_burst_addr = rx_buff_q_base_addr;

      // Setup address for next management read if not wrapping
      else if (setup_manrd_add)
         rx_dma_burst_addr = rx_descr_next_addr[31:2];

      // Setup address for management write of word 1
      else if (rx_dma_state_man_wr & ~rx_addr_bus_owned &
               ~rx_astrobe_in_manwr)
         rx_dma_burst_addr = rx_descr_wd1_addr[31:2];

      // Setup address for management write of word 0
      else
         rx_dma_burst_addr = rx_buffer_descr_ptr;
   //------------------------------------------------



//******************************************************************************
// AHB data generation
//******************************************************************************

   // rx_add_match_flag  - Detect when any of the local match signals are set.
   // rx_add_match_code  - Encode match signals for writeback.
   //------------------------------------------------
   assign rx_add_match_flag = rx_w_add_match1_hclk | rx_w_add_match2_hclk |
                              rx_w_add_match3_hclk | rx_w_add_match4_hclk;

   assign rx_add_match_code = rx_w_add_match4_hclk ? 2'b11 :
                              rx_w_add_match3_hclk ? 2'b10 :
                              rx_w_add_match2_hclk ? 2'b01 :
                                                     2'b00 ;
                              //rx_w_add_match1_hclk or all 0 then 00
   //------------------------------------------------


   // rx_type_match_flag - If TOE is disabled detect when any local type
   //                      matches. If TOE is enabled then set this flag when
   //                      detected frame was SNAP encapsulated.
   // rx_type_match_code - If TOE is disabled then encode type matches into
   //                      bits[32:22] of descriptor. If TOE is enabled then
   //                      encode IP checksum matches into these bits.
   //------------------------------------------------
   always @(rx_toe_enable or rx_w_type_mtch1_hclk or rx_w_type_mtch2_hclk or
            rx_w_type_mtch3_hclk or rx_w_type_mtch4_hclk or
            rx_w_cksumi_ok_hclk or rx_w_cksumt_ok_hclk or
            rx_w_cksumu_ok_hclk or rx_w_snap_frame_hclk)
      // RX TCP Offload Engine not enabled
      if (~rx_toe_enable)
         begin
            rx_type_match_flag = rx_w_type_mtch1_hclk | rx_w_type_mtch2_hclk |
                                 rx_w_type_mtch3_hclk | rx_w_type_mtch4_hclk;
            rx_type_match_code = rx_w_type_mtch4_hclk ? 2'b11 :
                                 rx_w_type_mtch3_hclk ? 2'b10 :
                                 rx_w_type_mtch2_hclk ? 2'b01 :
                                                        2'b00 ;
                               //rx_w_type_mtch1_hclk or all 0 then 00
         end

      // RX TCP Offload Engine enabled
      else
         begin
            rx_type_match_flag = rx_w_snap_frame_hclk;
            rx_type_match_code = rx_w_cksumu_ok_hclk ? 2'b11 :
                                 rx_w_cksumt_ok_hclk ? 2'b10 :
                                 rx_w_cksumi_ok_hclk ? 2'b01 :
                                                       2'b00 ;
         end
   //------------------------------------------------


   // rx_ext_match_flag - Detect when any external match signals are set.
   //------------------------------------------------
   assign rx_ext_match_flag = rx_w_ext_match1_hclk | rx_w_ext_match2_hclk |
                              rx_w_ext_match3_hclk | rx_w_ext_match4_hclk;
   //------------------------------------------------


   // rx_sof - Detect when SOP has been written to a buffer. Used for
   //          setting the start of frame bit in descriptor.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_sof <= 1'b0;
      else if (~enable_rx_hclk)
         rx_sof <= 1'b0;
      else if (rx_man_wr_done)
         rx_sof <= 1'b0;
      else if (rx_fifo_sop & rx_fifo_valid)
         rx_sof <= 1'b1;
      else
         rx_sof <= rx_sof;
   //------------------------------------------------

   always@(posedge rx_w_clk or negedge rx_w_rst_n)
      if (~rx_w_rst_n)
         begin
            rx_w_vlan_tag_eop <= 1'b0;
            rx_w_prty_tag_eop <= 1'b0;
            rx_w_tci_eop      <= 4'h0;
         end
      else
         begin
            if (rx_w_eop & rx_w_wr)
               begin
                  rx_w_vlan_tag_eop <= rx_w_vlan_tag_hclk;
                  rx_w_prty_tag_eop <= rx_w_prty_tag_hclk;
                  rx_w_tci_eop      <= rx_w_tci_hclk;
               end
            else
               begin
                  rx_w_vlan_tag_eop <= rx_w_vlan_tag_eop;
                  rx_w_prty_tag_eop <= rx_w_prty_tag_eop;
                  rx_w_tci_eop      <= rx_w_tci_eop     ;
               end
         end

   // rx_dma_data_out - Write data to the AHB
   //------------------------------------------------
   always @(*)
      // provide the frame data during data storage state
      if (rx_dma_state_data)
         rx_dma_data_out = rx_adj_data_out[127:0];

      // provide the buffer base address and set buffer_used_bit during
      // the second access of a man_wr state
      else if (astrobe_manwr_2nd)
         rx_dma_data_out = {96'd0,
                            rx_buffer_start_addr,
                            rx_buffer_wrap,
                            1'b1};

      // provide data for descriptor wd_1 after whole frame has been stored
      // in the memory.
      // If not doing jumbo frames the top bit of the length field is borrowed
      // for indicating a frame which was copied but had bad CRC (in ignore
      // FCS mode).
      else if (rx_dma_state_man_wr & rx_eof_written)
         rx_dma_data_out = {96'd0,
                            rx_w_broadcast_hclk,
                            rx_w_mult_hash_hclk,
                            rx_w_uni_hash_hclk,
                            rx_ext_match_flag,
                            rx_add_match_flag,
                            rx_add_match_code,
                            rx_type_match_flag,
                            rx_type_match_code,
                            rx_w_vlan_tag_eop,
                            rx_w_prty_tag_eop,
                            rx_w_tci_eop[3:0],
                            rx_eof_written,
                            rx_sof,
                            ((~jumbo_enable & rx_no_crc_check)?
                                 rx_w_crc_error_hclk :
                                 rx_w_frm_lngth_hclk[13]),
                            rx_w_frm_lngth_hclk[12:0]};

      // provide data for descriptor wd_1 but the buffer is not the last
      // one for current frame
      else
         rx_dma_data_out = {96'd0,
                            17'd0,
                            rx_sof,
                            14'd0};
   //------------------------------------------------



//******************************************************************************
// Data offset alignment logic
//******************************************************************************

   // rx_adj_data_out -    This is a register holding the last data popped from
   //                      fifo after this has been offset by the appropriate
   //                      number of bytes, according to rx_buffer_offset.
   //                      At beginning of the frame, this is loaded with data
   //                      being offset and the offset locations are all 0
   // offset_data_residue -The leftover from offset is stored in
   //                      offset_data_residue and is afterwards put in the
   //                      offset locations at the beginning of rx_adj_data_out.
   //                      This register must be preloaded in advance of any ahb
   //                      activity, so that when ahb bus is granted, the very
   //                      first data is ready to be registered in hwdata during
   //                      the first address phase.
   //                      If the frame is to be dropped (clear_frame), this
   //                      buffer is also cleared.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            offset_data_residue  <= 24'd0;
            rx_adj_data_out      <= 128'd0;
         end

      else if (~enable_rx_hclk | clear_frame)
         begin
            offset_data_residue  <= 24'd0;
            rx_adj_data_out      <= 128'd0;
         end

      else if (rx_fifo_valid)
         case (rx_buffer_offset)

            2'b01 :             // one byte offset
                   begin
                    rx_adj_data_out[7:0]        <=  offset_data_residue[7:0];
                    rx_adj_data_out[127:8]      <=  rx_fifo_data_out[119:0];

                    offset_data_residue[23:8]   <=  16'h0000;
                    case (dma_bus_width)
                       2'b00 :  offset_data_residue[7:0]
                                                <=  rx_fifo_data_out[31:24];
                       2'b01 :  offset_data_residue[7:0]
                                                <=  rx_fifo_data_out[63:56];
                       default : offset_data_residue[7:0]
                                                <=  rx_fifo_data_out[127:120];
                    endcase
                   end

            2'b10 :             // two bytes offset
                   begin
                    rx_adj_data_out[15:0]       <=  offset_data_residue[15:0];
                    rx_adj_data_out[127:16]     <=  rx_fifo_data_out[111:0];

                    offset_data_residue[23:16]  <=  8'h00;
                    case (dma_bus_width)
                       2'b00 :  offset_data_residue[15:0]
                                                <=  rx_fifo_data_out[31:16];
                       2'b01 :  offset_data_residue[15:0]
                                                <=  rx_fifo_data_out[63:48];
                       default : offset_data_residue[15:0]
                                                <=  rx_fifo_data_out[127:112];
                    endcase
                   end

            2'b11 :             // three bytes offset
                   begin
                    rx_adj_data_out[23:0]       <=  offset_data_residue[23:0];
                    rx_adj_data_out[127:24]     <=  rx_fifo_data_out[103:0];

                    case (dma_bus_width)
                       2'b00 :  offset_data_residue[23:0]
                                                <=  rx_fifo_data_out[31:8];
                       2'b01 :  offset_data_residue[23:0]
                                                <=  rx_fifo_data_out[63:40];
                       default : offset_data_residue[23:0]
                                                <=  rx_fifo_data_out[127:104];
                    endcase
                   end

            default :           // no offset
                   begin
                    rx_adj_data_out             <=  rx_fifo_data_out[127:0];
                    offset_data_residue         <=  24'h000000;
                   end

         endcase

      else if (rx_frame_end_flag & rx_dma_state_data & rx_addr_inc_strobe)
        begin
         offset_data_residue     <=  24'h000000;
         case (rx_buffer_offset)

            2'b01 :             // one byte offset
                   begin
                    rx_adj_data_out[7:0]        <=  offset_data_residue[7:0];
                    rx_adj_data_out[127:8]      <=  120'd0;
                   end

            2'b10 :             // two bytes offset
                   begin
                    rx_adj_data_out[15:0]       <=  offset_data_residue[15:0];
                    rx_adj_data_out[127:16]     <=  112'd0;
                   end

            default :           // three bytes offset
                   begin
                    rx_adj_data_out[23:0]       <=  offset_data_residue[23:0];
                    rx_adj_data_out[127:24]     <=  104'd0;
                   end
         endcase
        end

      else
         begin
            offset_data_residue  <= offset_data_residue;
            rx_adj_data_out      <= rx_adj_data_out;
         end
   //------------------------------------------------


   // number_in_residue - Number of bytes that will be in the residue
   //------------------------------------------------
   assign number_in_residue[4:0] = {1'b0,   rx_fifo_mod[3:0]} +
                                   {3'b000, rx_buffer_offset[1:0]};


   // residue_left - Detect when there will be one or more bytes left in
   //                the residue after the current access has completed.
   //------------------------------------------------
   always @(rx_fifo_mod or rx_buffer_offset or dma_bus_width or
            number_in_residue)
      if (rx_fifo_mod == 4'h0 & (rx_buffer_offset != 2'b00))
         residue_left = 1'b1;
      else
         case (dma_bus_width)

          2'b00 : // 32 bits
             residue_left = (number_in_residue[4:0] > 5'd4);

          2'b01 : // 64 bits
             residue_left = (number_in_residue[4:0] > 5'd8);

          default : //128 bits
             residue_left = (number_in_residue[4:0] > 5'd16);
         endcase
   //------------------------------------------------



//******************************************************************************
// AHB decoding
//******************************************************************************

   // rx_man_rd_data_strb - indicates a successful rx_dma_man_rd has been
   //                       performed and the descriptor value must be
   //                       captured on the coming hclk edge
   //------------------------------------------------
   assign rx_man_rd_data_strb = rx_dma_state_man_rd & rx_last_data_ph;
   //------------------------------------------------


   // rx_man_wr_data_strb1- indicates when the 1st data phase of the two phase
   //                       rx_dma_man_wr has been performed.
   //------------------------------------------------
   assign rx_man_wr_data_strb1 =
                 (rx_dma_state_man_wr & rx_data_strobe & rx_astrobe_in_manwr);
   //------------------------------------------------


   // rx_man_wr_data_strb2- indicates when the 2nd data phase of the two phase
   //                       rx_dma_man_wr has been performed.
   //                       Since we always go to management read state after
   //                       a successful management write, the writeback
   //                       actually happens in the read state.
   //                       Also indicate if the management write is not
   //                       successful because of a burst error.
   //------------------------------------------------
   assign rx_man_wr_data_strb2 =
                 (nxtdstrobeis2ndmanwr & rx_data_strobe & rx_dma_state_man_rd);
   //------------------------------------------------


   // rx_man_wr_data_strb - indicates when the either data phase of the two
   //                       phase rx_dma_man_wr has been performed.
   //------------------------------------------------
   assign rx_man_wr_data_strb =  rx_man_wr_data_strb1 | rx_man_wr_data_strb2;
   //------------------------------------------------


   // rx_man_wr_done- indicates when rx_dma_man_wr has been performed.
   //------------------------------------------------
   assign rx_man_wr_done = rx_man_wr_data_strb2 |
                           (rx_man_wr_data_strb1 & rx_burst_error);
   //------------------------------------------------



//******************************************************************************
// Detect EOP
//******************************************************************************

   // eof_transfer - indicate the eof is to be popped from fifo and
   //                transferred on the following cycle
   //------------------------------------------------
   assign eof_transfer = rx_dma_state_data & rx_last_addr_ph &
                         rx_fifo_eop_dly;
   //------------------------------------------------


   // last_data_to_buffer - indicate the last data transfer to the current
   //                       buffer is to be done; this will happen if this is
   //                       the last free location in the buffer or if it is
   //                       the eof to be transferred
   //------------------------------------------------
   assign last_data_to_buffer = rx_last_addr_ph &
                                (eof_transfer | rx_buffer_required);


   // rx_fifo_eop_dly - delayed version of rx_fifo_eop
   //                   rx_fifo_eop is registerred when rx_fifo_pop is high
   // eop_in_residue  - due to nonzero rx buffer offset, the eop is in the
   //                   offset_data_residue buffer, therefore, one more than
   //                   the usual number of transfers.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            rx_fifo_eop_dly <= 1'b0;
            eop_in_residue  <= 1'b0;
         end
      else if (~enable_rx_hclk)
         begin
            rx_fifo_eop_dly <= 1'b0;
            eop_in_residue  <= 1'b0;
         end
      else if (eof_transfer | clear_frame)
         begin
            rx_fifo_eop_dly <= 1'b0;
            eop_in_residue  <= 1'b0;
         end
      else if (rx_fifo_valid & rx_fifo_eop)
         begin
            rx_fifo_eop_dly <= ~residue_left;
            eop_in_residue  <= residue_left;
         end
      else if (rx_addr_strobe & rx_dma_state_data & eop_in_residue)
         begin
            rx_fifo_eop_dly <= 1'b1;
            eop_in_residue  <= 1'b0;
         end
      else
         begin
            rx_fifo_eop_dly <= rx_fifo_eop_dly;
            eop_in_residue  <= eop_in_residue;
         end
   //------------------------------------------------


   // rx_dma_eop_burst - Flag indicating the burst transferring the end of
   //                    the current frame is initiated.
   //                    This happens when eop is in the fifo as indicated by
   //                    rx_fifo_pkt_comp and there is no more data than for
   //                    one burst only. It can happen though, due to rx buffer
   //                    offset that the remaining data and offset residue
   //                    cannot be transferred in one burst only. In this case
   //                    the two corresponding bursts will have hburst
   //                    indicating unlimited incremental
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_dma_eop_burst <= 1'b0;
      else if (~enable_rx_hclk)
         rx_dma_eop_burst <= 1'b0;
      else if (eof_transfer | clear_frame)
         rx_dma_eop_burst <= 1'b0;
      else if (rx_fifo_pkt_comp & (rx_fifo_count <= max_burst_length))
         rx_dma_eop_burst <= 1'b1;
      else
         rx_dma_eop_burst <= rx_dma_eop_burst;
   //------------------------------------------------



//******************************************************************************
// Status and Error reporting - gem_rx handshaking
//******************************************************************************

   // dma_rx_status_tog - Handshaking toggle signal back to gem_rx to indicate
   //                     that the DMA has completed to associated frame
   //                     by attempting to writeback the descriptor and
   //                     updating status to the pclk domain.
   // rx_frame_end_flag - This internal flag is used to cope with an EOP
   //                     write from the offset buffer
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            dma_rx_status_tog <= 1'b0;
            rx_frame_end_flag <= 1'b0;
            rx_good_end_flag  <= 1'b0;
         end

      // Reset when receive is disabled
      else if (~enable_rx_hclk)
         begin
            dma_rx_status_tog <= 1'b0;
            rx_frame_end_flag <= 1'b0;
            rx_good_end_flag  <= 1'b0;
         end

      // Signal complete to gem_rx once update to pclk has completed
      else if (rx_stat_capt_pulse)
         begin
            dma_rx_status_tog <= ~dma_rx_status_tog;
            rx_frame_end_flag <= 1'b0;
            rx_good_end_flag  <= 1'b0;
         end

      // Set end flag when rx_frame_end_pulse received from gem_rx
      else if (rx_frame_end_pulse)
         begin
            dma_rx_status_tog <= dma_rx_status_tog;
            rx_frame_end_flag <= 1'b1;
            rx_good_end_flag  <= ~rx_w_bad_frame_hclk;
         end

      // Else maintain value
      else
         begin
            dma_rx_status_tog <= dma_rx_status_tog;
            rx_frame_end_flag <= rx_frame_end_flag;
            rx_good_end_flag  <= rx_good_end_flag;
         end
   //------------------------------------------------



//******************************************************************************
// Status and Error reporting - Detect & store error conditions
//******************************************************************************

   // rx_buffer_used_bit  - this is the value read from buffer descriptor
   //                       bit[0] of word_0.
   //------------------------------------------------
   assign rx_buffer_used_bit = rx_man_rd_data_strb & rx_dma_data_in[0];
   //------------------------------------------------


   // rx_resource_err - Detects when a frame which should otherwise be
   //                   successfully stored is dropped due a DMA problem
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_resource_err <= 1'b0;
      else if (~enable_rx_hclk)
         rx_resource_err <= 1'b0;
      else if ((clear_frame & rx_fifo_eop & ~rx_fifo_err & rx_fifo_valid) |
               (rx_man_wr_data_strb & rx_burst_error))
         rx_resource_err <= 1'b1;
      else if (update_status)
         rx_resource_err <= 1'b0;
      else
         rx_resource_err <= rx_resource_err;
   //------------------------------------------------


   // rx_hresp_notok -  flag to incicate an hresp error has occurred during
   //                   a frame; set when rx_burst_error seen from AHB;
   //                   cleared when update_status is signalled;
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_hresp_notok <= 1'b0;
      else if (~enable_rx_hclk)
         rx_hresp_notok <= 1'b0;
      else if (rx_burst_error)
         rx_hresp_notok <= 1'b1;
      else if (update_status)
         rx_hresp_notok <= 1'b0;
      else
         rx_hresp_notok <= rx_hresp_notok;
   //------------------------------------------------



//******************************************************************************
// Status and Error reporting - Update status to PCLK
//******************************************************************************

   // rx_eof_written       - Flag indicating that eof has been written to
   //                        memory. Set on eof_transfer, reset after writeback.
   // last_man_wr_complete - flag indicating that last management writeback
   //                        completed successfully.
   //                        Set @ last buffer descriptor write back & no error.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            last_man_wr_complete <= 1'b0;
            rx_eof_written       <= 1'b0;
         end
      else if (~enable_rx_hclk)
         begin
            last_man_wr_complete <= 1'b0;
            rx_eof_written       <= 1'b0;
         end
      else if (clear_frame | update_status)
         begin
            last_man_wr_complete <= 1'b0;
            rx_eof_written       <= 1'b0;
         end
      else if (eof_transfer)
         begin
            last_man_wr_complete <= 1'b0;
            rx_eof_written       <= 1'b1;
         end
      else if (rx_man_wr_done & rx_eof_written)
         begin
            last_man_wr_complete <= ~rx_burst_error; // hresp error on writeback
            rx_eof_written       <= 1'b0;
         end
      else
         begin
            last_man_wr_complete <= last_man_wr_complete;
            rx_eof_written       <= rx_eof_written;
         end
   //------------------------------------------------


   // update_status - pulse used to update the status flags output from
   //                 dma_rx block;
   //                 formed by a register which outputs high for one cycle
   //                 only;
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         update_status <= 1'b0;

      else if (~enable_rx_hclk)
         update_status <= 1'b0;

      // last man wr complete
      else if (rx_man_wr_done & rx_eof_written)
         update_status <= 1'b1;

      // resource error
      else if (clear_frame & rx_fifo_eop & ~rx_fifo_err & rx_fifo_valid)
         update_status <= 1'b1;

      // frame that MAC has signalled as OK but is errored (normally this
      // condition is because of an overflow in the FIFO on the EOP write)
      else if (rx_good_end_flag & rx_fifo_eop & rx_fifo_err & rx_fifo_valid)
         update_status <= 1'b1;

      else
         update_status <= 1'b0;
   //------------------------------------------------


   // rx_dma_stable_tog    - Toggle to the pclk_synch domain indicating
   //                        status output from dma_rx block is set and won't
   //                        change until sampled in the pclk domain;
   // rx_dma_status_stable - Internal flag which ensures that the status outputs
   //                        do not change state whilst an update in on-going.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            rx_dma_stable_tog    <= 1'b0;
            rx_dma_status_stable <= 1'b0;
         end
      else if (update_status & ~rx_dma_status_stable)
         begin
            rx_dma_stable_tog    <= ~rx_dma_stable_tog;
            rx_dma_status_stable <= 1'b1;
         end
      else if (rx_stat_capt_pulse)
         begin
            rx_dma_stable_tog    <= rx_dma_stable_tog;
            rx_dma_status_stable <= 1'b0;
         end
      else
         begin
            rx_dma_stable_tog    <= rx_dma_stable_tog;
            rx_dma_status_stable <= rx_dma_status_stable;
         end
   //------------------------------------------------


   // rx_dma_complete_ok  - status flag going out of the dma_rx block
   //                       Set when frame is stored successfully and
   //                       the writeback completes successfully.
   // rx_dma_resource_err - status flag going out of the dma_rx block
   //                       Set when an otherwise good frame is dropped
   //                       due to a DMA problem.
   // rx_dma_hresp_notok  - status flag going out of the dma_rx block
   //                       Set when a frame is dropped due to an hresp not
   //                       ok response from the AHB during either RX data
   //                       or RX management accesses.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            rx_dma_complete_ok  <= 1'b0;
            rx_dma_resource_err <= 1'b0;
            rx_dma_hresp_notok  <= 1'b0;
         end
      else if (~enable_rx_hclk)
         begin
            rx_dma_complete_ok  <= 1'b0;
            rx_dma_resource_err <= 1'b0;
            rx_dma_hresp_notok  <= 1'b0;
         end
      else if (update_status & ~rx_dma_status_stable)
         begin
            rx_dma_complete_ok  <= last_man_wr_complete & ~rx_resource_err
                                                        & ~rx_hresp_notok;
            rx_dma_resource_err <= rx_resource_err;
            rx_dma_hresp_notok  <= rx_hresp_notok;
         end
      else
         begin
            rx_dma_complete_ok  <= rx_dma_complete_ok;
            rx_dma_resource_err <= rx_dma_resource_err;
            rx_dma_hresp_notok  <= rx_dma_hresp_notok;
         end
   //------------------------------------------------


   // rx_dma_buff_not_rdy - flag in the status register indicating used buffer
   //                       descriptor has been read; cleared when a handshake
   //                       from pclk domain indicates pclk register is updated
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_dma_buff_not_rdy  <= 1'b0;
      else if (~enable_rx_hclk)
         rx_dma_buff_not_rdy  <= 1'b0;
      else if (rx_buffer_used_bit)
         rx_dma_buff_not_rdy  <= 1'b1;
      else if (rx_buff_not_rdy_clr)
         rx_dma_buff_not_rdy  <= 1'b0;
      else
         rx_dma_buff_not_rdy  <= rx_dma_buff_not_rdy;
   //------------------------------------------------



//******************************************************************************
// FIFO POP logic
//******************************************************************************

   // drop_frame - frame must be dropped and resource error signalled if
   //              no buffer available and storage of a multibuffer frame
   //              is ongoing, or if new frame is pending in the fifo
   //              and buffer_used bit was read -> the frame can't be
   //              stored, therefore must be cleared to avoid overflow.
   //------------------------------------------------
   assign drop_frame =   (rx_buffer_used_bit & storage_in_progress) |
                         (~storage_in_progress & ~rx_buffer_required &
                             ~rx_buffer_available & rx_dma_state_wait);
   //------------------------------------------------


   // clear_frame - active when an error has occurred and the rest of a
   //               frame has to be cleared from the FIFO.
   //------------------------------------------------
   assign clear_frame = drop_frame |
                        (rx_burst_error & ~rx_man_wr_data_strb) |
                        (rx_fifo_eop & rx_fifo_err & rx_fifo_valid) |
                        frame_not_cleared;
   //------------------------------------------------


   // frame_not_cleared - Used to hold clear_frame until errored frame has been
   //                     cleared
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         frame_not_cleared <= 1'b0;
      else if (~enable_rx_hclk)
         frame_not_cleared <= 1'b0;
      else if (rx_fifo_eop & rx_fifo_valid)
         frame_not_cleared <= 1'b0;
      else if ((rx_burst_error & ~rx_man_wr_data_strb) | drop_frame)
         frame_not_cleared <= 1'b1;
      else
         frame_not_cleared <= frame_not_cleared;
   //------------------------------------------------


   // rx_fifo_pop_to_clear - Used to force a pop from the FIFO when clearing
   //                        an errored frame. Delayed version is used
   //                        to control rate of popping.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_fifo_pop_to_clear <= 1'b0;
      else if (~enable_rx_hclk)
         rx_fifo_pop_to_clear <= 1'b0;
      else if (clear_frame &
               ~(rx_fifo_eop & rx_fifo_err & rx_fifo_valid) &
               (rx_fifo_count >= {{(`edma_rx_fifo_cnt_width - 1){1'b0}}, 1'b1}) &
               ~rx_fifo_pop_to_clear & ~delay_pop_to_clear)
         rx_fifo_pop_to_clear <= 1'b1;
      else
         rx_fifo_pop_to_clear <= 1'b0;
   //------------------------------------------------


   // delay_pop_to_clear - delayed veriosn of rx_fifo_pop_to_clear which
   //                      is used to control rate of popping.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         delay_pop_to_clear <= 1'b0;
      else if (~enable_rx_hclk)
         delay_pop_to_clear <= 1'b0;
      else
         delay_pop_to_clear <= rx_fifo_pop_to_clear;
   //------------------------------------------------


   // rx_fifo_pop - pulse used to pop next read data from FIFO.
   //               Popped on every address phase until EOP is popped.
   //               rx_fifo_pop_to_clear is used to force pops when frame
   //               is being dropped.
   //------------------------------------------------
   assign rx_fifo_pop = (rx_dma_state_data & rx_addr_inc_strobe &
                            ~rx_fifo_eop_dly & ~eop_in_residue) |
                         rx_fifo_pop_to_clear;
   //------------------------------------------------


   // rx_fifo_pop - pulse used to pop next read data from FIFO.
   //               Popped on every address phase until EOP is popped.
   //               rx_fifo_pop_to_clear is used to force pops when frame
   //               is being dropped.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         rx_fifo_pop_del <= 1'b0;
      else
         rx_fifo_pop_del <= rx_fifo_pop;
   //------------------------------------------------


   // rx_dma_flow_error - signal indicating an error has been
   //                     encounterred during reception and due to that,
   //                     current ahb activity must be cancelled
   //------------------------------------------------
   assign rx_dma_flow_error = ~enable_rx_hclk |
                              (rx_dma_state_data & clear_frame);
   //------------------------------------------------



//******************************************************************************
// RX FIFO instantiation
//******************************************************************************

   // RX FIFO instantiation
   //------------------------------------------------
   gem_fifo #(.DEPTH(`edma_rx_fifo_size),            // DEPTH
              .WIDTH(`edma_bus_width),               // WIDTH
              .CNT_WIDTH(`edma_rx_fifo_cnt_width),   // CNT_WIDTH
              .BASE2_DEPTH(`edma_rx_base2_fifo_size))// BASE2_DEPTH
      i_gem_frx (

      // w_clk domain signals.
         .w_clk(rx_w_clk),
         .w_rst_n(rx_w_rst_n),
         .w_wr(rx_w_wr),
         .w_data(rx_w_data),
         .w_eop(rx_w_eop),
         .w_sop(rx_w_sop),
         .w_mod(rx_w_mod),
         .w_err(rx_w_err),
         .w_flush(rx_w_flush),
         .w_control(1'b0),               // Not used in RX DMA
         .w_overflow(rx_w_overflow),
//         .w_fifo_count(rx_w_fifo_count), // Only used in packet buffer
         .w_fifo_count(),
         .w_flushing(),

      // r_clk domain signals.
         .r_clk(hclk),
         .r_rst_n(n_hreset),
         .r_rd(rx_fifo_pop),
         .r_valid(rx_fifo_valid),
         .r_data(rx_fifo_data_out_pad),
         .r_eop(rx_fifo_eop),
         .r_sop(rx_fifo_sop),
         .r_mod(rx_fifo_mod),
         .r_err(rx_fifo_err),
         .r_flushed(),
         .r_underflow(),
         .r_fifo_count(rx_fifo_count),
         .r_pkt_comp(rx_fifo_pkt_comp),
         .r_control()
      );


   // Pad RX FIFO data up to 128-bits (use 129 bits to avoid 0 length concat)
   assign rx_fifo_data_out = {{129-`edma_bus_width{1'b0}},
                              rx_fifo_data_out_pad};
   //------------------------------------------------

endmodule

