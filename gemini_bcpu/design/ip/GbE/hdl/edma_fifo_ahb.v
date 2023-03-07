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
//   Filename:           edma_fifo_ahb.v
//   Module Name:        edma_fifo_ahb
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
//   Description :      This module represents the ahb interface of the gem.
//                      It is instantiated on same level as dma_rx and dma_tx.
//                      It is a simple ahb transactor supporting unspecified
//                      length locked burst transfers with a maximum length
//                      defined in the gem_gxl_defs.v file.
//                      The statemachine is in idle until a request from the
//                      upper level (dma data flow state machine) is issued.
//                      The burst sequences are different for the different
//                      data flow states:
//                      -during dma_state_data, the burst is sequential up
//                       to the max lenght;
//                      -during dma_man_wr, the burst is nonseq, because wd0
//                       of the descriptor is always written after wd1 (for rx),
//                       therefore the two addresses appear to be nonseq; there
//                      is only one word written (wd1) for tx;
//                      -during dma_man_rd, only wd0 or both wd0 & wd1 are read
//                       according to whether the burst is for rx or tx man_rd
//                       respectively.
//                      There is a priority scheme between rx and tx to
//                      determine who will own the ahb interface:
//                      1. First come - first go;
//                      2. If management and data requests arrive at the same
//                         time, then management request is serviced first;
//                      3. If rx and tx requests of equal priority (both man or
//                         both data) arrive at the same time, then rx is
//                         serviced first;
//                      Not OKAY response from the slave during a burst will
//                      lead a status register extended flag to be set:
//                      rx_buffer_not_ready;
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_fifo_ahb (

 // Inputs

 // global clk & reset
   n_hreset,                       // global reset
   hclk,                           // global clock

 // ahb input interface
   hgrant,                         // ahb grant
   hready,                         // slave ready to complete current transfer
   hresp,                          // slave unable to perform current transfer
   hrdata,                         // dma input data

 // inputs from dma_rx block
   rx_dma_state_man_wr,            // rx dma state management (descriptor) write
   rx_dma_state_man_rd,            // rx dma state management (descriptor) read
   rx_dma_state_data,              // rx dma state data (frame) storage
   rx_dma_bus_req,                 // rx dma bus request
   rx_dma_flow_error,              // rx dma data flow error
   rx_dma_burst_addr,              // rx next dma transfer address
   rx_dma_data_out,                // rx dma output data
   rx_data_burst_break,            // rx data burst must end next cycle
   rx_dma_next_data,               // rx dma next state is data
   rx_dma_next_man_wr,             // rx dma next state is management write
   rx_dma_next_man_rd,             // rx dma next state is management read
   rx_dma_eop_burst,               // rx dma initiated eof burst

 // inputs from dma_tx block
   tx_dma_state_man_wr,            // tx dma state management (descriptor) write
   tx_dma_state_man_rd,            // tx dma state management (descriptor) read
   tx_dma_state_data,              // tx dma state data (frame) load
   tx_dma_bus_req,                 // tx dma bus request
   tx_dma_flow_error,              // tx dma data flow error
   tx_dma_burst_addr,              // tx next dma transfer address
   tx_dma_data_out,                // tx dma output data
   tx_data_burst_break,            // tx data burst must end next cycle
   tx_dma_next_data,               // tx dma next state is data
   tx_dma_next_man_wr,             // tx dma next state is management write
   tx_dma_next_man_rd,             // tx dma next state is management read
   tx_dma_eop_burst,               // tx dma initiated eof burst

 // inputs from apb registers
   dma_bus_width,                  // the encoded dma data bus width
   ahb_burst_length,               // AHB burst length control
   endian_swap,                    // Endian swap control


 // Outputs

 // outputs to dma_rx module
   rx_last_addr_ph,                // hready corresponding to last rx addr phase
   rx_last_data_ph,                // hready corresp to last rx data phase
   rx_addr_inc_strobe,                 // hready for rx addr phase
   rx_addr_strobe,                 // hready for rx addr phase
   rx_data_strobe,                 // hready for rx data phase
   rx_addr_bus_owned,              // rx is driving the address on dma bus
   rx_burst_error,                 // slave err while rx burst

 // outputs to dma_tx module
   tx_last_data_ph,                // hready corresp to last tx data phase
   tx_addr_inc_strobe,             // hready for tx addr phase
   tx_addr_strobe,                 // hready for tx addr phase
   tx_data_strobe,                 // hready for tx data phase
   tx_addr_bus_owned,              // tx is driving the address on dma bus
   tx_burst_error,                 // slave err while tx burst

 // outputs to both dma_rx & dma_tx blocks
   dma_data_rd,                    // incoming data (effectively hrdata)
   bus_idle,                       // no ahb activity, bus not requested

 // ahb output interface
   htrans,                         // current ahb transfer
   hburst,                         // type of burst
   hsize,                          // size of the transfer (32, 64 or 128)
   hwrite,                         // direction of the transfer
   hbusreq,                        // ahb requested
   hlock,                          // burst not to be interrupted
   haddr,                          // transfer address
   hwdata,                         // ahb output data
   hprot                           // burst meaning - not used

 );

// -----------------------------------------------------------------------------
// Input declarations
// -----------------------------------------------------------------------------

  // system inputs
   input           n_hreset;             // global reset
   input           hclk;                 // global clock for this module

 // ahb input interface
   input           hgrant;               // ahb grant
   input           hready;               // slave ready to complete transfer
   input    [1:0]  hresp;                // slave unable to perform transfer
   input  [127:0]  hrdata;               // dma input data

 // inputs from dma_rx block
   input           rx_dma_state_man_wr;  // dma descriptor write
   input           rx_dma_state_man_rd;  // dma descriptor read
   input           rx_dma_state_data;    // dma data transfer (write)
   input           rx_dma_bus_req;       // asserted if rx must perform dma
   input           rx_dma_flow_error;    // asserted if dma encounters rx error
   input  [31:2]   rx_dma_burst_addr;    // address of the following transfer
   input  [127:0]  rx_dma_data_out;      // data for the current transfer
   input           rx_data_burst_break;  // burst ends after following transfer
   input           rx_dma_next_data;     // next dma state is data transfer
   input           rx_dma_next_man_wr;   // next dma state is management write
   input           rx_dma_next_man_rd;   // next dma state is management read
   input           rx_dma_eop_burst;     // rx dma initiated eop burst

 // inputs from dma_tx block
   input           tx_dma_state_man_wr;  // dma descriptor write
   input           tx_dma_state_man_rd;  // dma descriptor read
   input           tx_dma_state_data;    // dma data transfer (read)
   input           tx_dma_bus_req;       // asserted if tx must perform dma
   input           tx_dma_flow_error;    // asserted if dma encounters tx error
   input  [31:2]   tx_dma_burst_addr;    // address of the following transfer
   input  [127:0]  tx_dma_data_out;      // data for the current transfer
   input           tx_data_burst_break;  // burst ends after following transfer
   input           tx_dma_next_data;     // next dma state is data transfer
   input           tx_dma_next_man_wr;   // next dma state is management write
   input           tx_dma_next_man_rd;   // next dma state is management read
   input           tx_dma_eop_burst;     // tx dma initiated eop burst

 // inputs from apb registers
   input  [1:0]    dma_bus_width;        // encoded width of the data bus
   input  [4:0]    ahb_burst_length;     // AHB burst length control
   input  [1:0]    endian_swap;          // Endian swap control


// -----------------------------------------------------------------------------
// Output declarations
// -----------------------------------------------------------------------------

 // outputs to dma_rx module
   output          rx_last_addr_ph;      // hready @ last address phase rx burst
   output          rx_last_data_ph;      // hready @ last data phase of rx burst
   output          rx_addr_inc_strobe;       // hready @ rx_burst address phase
   output          rx_addr_strobe;       // hready @ rx_burst address phase
   output          rx_data_strobe;       // hready @ rx burst data phase
   output          rx_addr_bus_owned;    // address bus owned by rx dma
   output          rx_burst_error;       // notok resp from slave while rx burst

 // outputs to dma_tx module
   output          tx_last_data_ph;      // hready @ last data phase of tx burst
   output          tx_addr_inc_strobe;   // hready @ tx_burst address phase
   output          tx_addr_strobe;       // hready @ tx_burst address phase
   output          tx_data_strobe;       // hready @ tx burst data phase
   output          tx_addr_bus_owned;    // address bus owned by tx dma
   output          tx_burst_error;       // notok resp from slave while tx burst

 // outputs to both dma_rx & dma_tx blocks
   output  [127:0] dma_data_rd;          // effectively hrdata
   output          bus_idle;             // no ahb activity, bus not requested

 // ahb output interface
   output  [1:0]   htrans;               // current ahb transfer
   output  [2:0]   hburst;               // type of burst
   output  [2:0]   hsize;                // size of the transfer (32, 64 or 128)
   output          hwrite;               // direction of the transfer
   output          hbusreq;              // ahb requested
   output          hlock;                // burst not to be interrupted
   output  [31:0]  haddr;                // transfer address
   output  [127:0] hwdata;               // ahb output data
   output  [3:0]   hprot;                // burst meaning - not used


// -----------------------------------------------------------------------------
// Internal signals declaration
// -----------------------------------------------------------------------------

   // State machine signals
   reg  [2:0]   ahb_state;             // current state ahb sequencer
   reg  [2:0]   ahb_next;              // next state ahb sequencer
   wire         ahb_state_req;         // no ahb activity, bus requested
   wire         ahb_state_nonseq;      // nonseq address place on ahb
   wire         ahb_state_seq;         // sequential phase of burst
   wire         ahb_state_hold_off;    // hold off between DMA bursts
   wire         ahb_next_state_idle;   // no ahb activity, bus not requested
   wire         ahb_next_state_req;    // no ahb activity, bus requested
   wire         ahb_next_state_nseq;   // nonseq address place on ahb
   wire         ahb_next_state_seq;    // sequential phase of burst
   wire         ahb_next_state_hold;   // hold off between DMA bursts

   // DMA arbitration signals
   wire         bus_req;               // combined request signal from rx | tx
   reg          dma_bus_owner;         // 1-rx request serviced; 0-tx serviced
   reg          prev_dma_bus_owner;    // owner for previous address phase
                                       // used to store owner of data phase
   reg          dma_burst_done;        // Current DMA burst is about to complete
   wire         more_dma_to_do;        // More DMA required
   wire         seq_access;            // detect it next access is sequential
   reg          not_seq_access;        // save 1K boundary crossed condition

   // Burst breaking signals
   reg  [4:0]   burst_cnt;             // number of transfers initiated so far
                                       // from the beginning of a burst
   wire [5:0]   next_burst_cnt;        // burst_cnt + 1
   reg  [4:0]   burst_limit;           // max no of transfers within curr burst
   wire         one_to_burst_limit;    // penultimate address is placed on ahb
   reg  [7:0]   ahb_burst_maskh;       // address comparison mask upper bits
   wire         breaks_1k_boundary;    // next burst will break 1K AHB boundary

   // AHB phase decoding signals
   reg          ahb_addr_owned;        // ahb address owned by the mac
   reg          ahb_data_owned;        // ahb data owned by the mac
   reg          bus_addr_inc_strobe;   // strobe to advance address counters
   wire         bus_addr_strobe;       // hready @ mac burst address phase
   wire         bus_data_strobe;       // hready @ mac burst data phase
   wire         last_burst_addr_ph;    // hready @ last address of mac burst
   wire         last_burst_data_ph;    // hready @ last data of mac burst
   reg          stopburstdue2grant;    // lost grant

   // Outputs to RX DMA
   reg          rx_last_addr_ph;       // hready @ last address phase rx burst
   reg          rx_last_data_ph;       // hready @ last data phase of rx burst
   reg          rx_addr_inc_strobe;        // hready @ rx_burst address phase
   reg          rx_addr_strobe;        // hready @ rx_burst address phase
   reg          rx_data_strobe;        // hready @ rx burst data phase
   reg          rx_addr_bus_owned;     // address bus owned by rx dma
   reg          rx_burst_error;        // notok resp from slave while rx burst

   // Outputs to TX DMA
   reg          tx_last_data_ph;       // hready @ last data phase of tx burst
   reg          tx_addr_strobe;        // hready @ tx_burst address phase
   reg          tx_addr_inc_strobe;    // hready @ tx_burst address phase
   reg          tx_data_strobe;        // hready @ tx burst data phase
   reg          tx_addr_bus_owned;     // address bus owned by tx dma
   reg          tx_burst_error;        // notok resp from slave while tx burst

   // AHB output register signals
   reg          hbusreq;               // AHB bus request
   reg  [31:0]  haddr;                 // ahb address output
   reg  [1:0]   htrans;                // ahb htrans output
   reg  [2:0]   hsize;                 // ahb hsize output
   reg          hwrite;                // ahb hwrite output
   reg  [2:0]   hburst;                // ahb hburst output
   reg  [127:0] hwdata;                // ahb output data

   // multiplexed RX & TX DMA current state signals
   reg  [31:2]  dma_burst_addr;        // next burst address
   reg  [127:0] dma_data_out;          // current transfer output data
   reg          dma_state_man_rd;      // dma descriptor read ongoing
   reg          dma_state_man_wr;      // dma descriptor write ongoing
   reg          dma_state_data;        // dma data (frame) transfer ongoing
   reg          data_burst_break;      // dma ends @ next transfer
   reg          bus_abort;             // ahb activity must be aborted
   reg          eop_burst;             // dma initiated eop burst

   // data phase control signals
   reg  [1:0]   sel_word_lane;         // detect which word lane is to be used
   reg  [1:0]   rd_enable_word;        // delayed sel_word_lane for data phase
   reg  [127:0] dma_data_out_endian;   // write data after endian swap
   reg  [127:0] dma_data_rd_endian;    // read data before endian swap
   reg  [127:0] dma_data_rd;           // read data output
   wire         hresp_not_ok;          // internal flag for hresp not OK
   wire         endian_swap_now;       // indicates endian swap required
   reg          rd_endian_swap_now;    // endian_swap_now saved for read data
   reg          man_rd_after_man_wr;   // Man Read Follows Man Write


// -----------------------------------------------------------------------------
// Parameters declaration
// -----------------------------------------------------------------------------

   // dma_ahb state encoding
   parameter
      p_ahb_idle      = 3'b000,        // State machine is idle.
      p_ahb_bus_req   = 3'b001,        // State machine is requesting bus
      p_ahb_nseq      = 3'b010,        // State machine is performing NONSEQ
      p_ahb_seq       = 3'b011,        // State machine is performing SEQ
      p_ahb_hold_off  = 3'b100;        // State machine is holding off before
                                       // next access

   // htrans encoding
   parameter
      p_htrans_idle   = 2'b00,         // AHB IDLE access
      p_htrans_nseq   = 2'b10,         // AHB NONSEQ access
      p_htrans_seq    = 2'b11;         // AHB SEQ access

   // hsize encoding
   parameter
      p_hsize_32b    = 3'b010,         // AHB 32-bit access
      p_hsize_64b    = 3'b011,         // AHB 64-bit access
      p_hsize_128b   = 3'b100;         // AHB 128-bit access

   // hburst encoding
   parameter
      p_hburst_single  = 3'b000,       // AHB single access
      p_hburst_incr    = 3'b001,       // AHB INCR access
      p_hburst_incr_4  = 3'b011,       // AHB INCR4 access
      p_hburst_incr_8  = 3'b101,       // AHB INCR8 access
      p_hburst_incr_16 = 3'b111;       // AHB INCR16 access


   // hresp encoding
   parameter
      p_hresp_ok   = 2'b00;            // AHB OK response


// -----------------------------------------------------------------------------
// edma_ahb architecture
// -----------------------------------------------------------------------------



// -----------------------------------------------------------------------------
// AHB state machine
// -----------------------------------------------------------------------------

   // dma_ahb - currents state of the state machine
   //           synch process
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         ahb_state <= p_ahb_idle;
      else
         ahb_state <= ahb_next;
    end


   // ahb_next - next state evaluation
   //           for the dma_ahb state machine
   //------------------------------------------------
   always@(ahb_state or bus_abort or hgrant or hready or hresp_not_ok or
           dma_burst_done or more_dma_to_do or bus_req or seq_access)
    begin
      case (ahb_state)

         p_ahb_bus_req:           // ahb requested& waiting for grant.

            // ahb transaction cancelled
            if (bus_abort)
               ahb_next = p_ahb_idle;

            // ahb granted to the dma
            else if (hgrant & hready)
               ahb_next = p_ahb_nseq;

            // wait for hgrant
            else
               ahb_next = p_ahb_bus_req;


         p_ahb_nseq:             // first address within a burst

            // error, return to idle and request again
            if (bus_abort | hresp_not_ok)
               ahb_next = p_ahb_idle;

            // no more accesses required so return to idle & wait for request
            else if (hready & dma_burst_done & ~more_dma_to_do)
               ahb_next = p_ahb_idle;

            // DMA blocks still requesting, but need time to form the next
            // burst, so go to hold off state
            else if (hready & (dma_burst_done | ~hgrant))
               ahb_next = p_ahb_hold_off;

            // current access accomplished another sequential access to do
            // and DMA blocks ready to service it.
            else if (hready & seq_access)
               ahb_next = p_ahb_seq;

            // stay where we are for another non-sequential access, DMA blocks
            // are ready to service it.
            else
               ahb_next = p_ahb_nseq;


         p_ahb_seq:              // sequential addresses

            // error, return to idle and request again
            if (bus_abort | hresp_not_ok)
               ahb_next = p_ahb_idle;

            // no more accesses required so return to idle & wait for request
            else if (hready & dma_burst_done & ~more_dma_to_do)
               ahb_next = p_ahb_idle;

            // DMA blocks still requesting, but need time to form the next
            // burst, so go to hold off state
            else if (hready & (dma_burst_done | ~hgrant))
               ahb_next = p_ahb_hold_off;

            // stay where we are for another sequential access, DMA blocks
            // are ready to service it.
            else
               ahb_next = p_ahb_seq;


         p_ahb_hold_off:         // more DMA but need to hold off for setup

            // error, return to idle and request again
            if (bus_abort | hresp_not_ok)
               ahb_next = p_ahb_idle;

            // if still granted then return to non-seq state
            else if (hready & hgrant)
               ahb_next = p_ahb_nseq;

            // Else if waiting for grant again remain in this state
            else
               ahb_next = p_ahb_hold_off;


         default: //p_ahb_idle:  // no ahb activity ongoing or requested

            // ahb transaction requested
            if (bus_req & hready)
               ahb_next = p_ahb_bus_req;

            else
               ahb_next = p_ahb_idle;


      endcase
    end
   //------------------------------------------------


   // Decode signals from current state to ease referencing
   //------------------------------------------------
   assign ahb_state_req       = (ahb_state == p_ahb_bus_req);
   assign ahb_state_nonseq    = (ahb_state == p_ahb_nseq);
   assign ahb_state_seq       = (ahb_state == p_ahb_seq);
   assign ahb_state_hold_off  = (ahb_state == p_ahb_hold_off);
   assign ahb_next_state_req  = (ahb_next  == p_ahb_bus_req);
   assign ahb_next_state_nseq = (ahb_next  == p_ahb_nseq);
   assign ahb_next_state_seq  = (ahb_next  == p_ahb_seq);
   assign ahb_next_state_hold = (ahb_next  == p_ahb_hold_off);
   assign ahb_next_state_idle = ~ahb_next_state_req & ~ahb_next_state_nseq &
                                ~ahb_next_state_seq & ~ahb_next_state_hold;
   //------------------------------------------------


// -----------------------------------------------------------------------------
// Burst request/done logic
// -----------------------------------------------------------------------------

   // bus_req - Determines when either of thr TX or RX DMA blocks requires
   //           access to the bus. Blocked if a flow error occurs.
   //           Only look at request once full information of type of access
   //           is available.
   //------------------------------------------------
   assign bus_req = (rx_dma_bus_req & ~rx_dma_flow_error &
                        (rx_dma_next_man_wr |
                         rx_dma_next_man_rd |
                         rx_dma_next_data))
                  | (tx_dma_bus_req & ~tx_dma_flow_error &
                        (tx_dma_next_man_wr |
                         tx_dma_next_man_rd |
                         tx_dma_next_data));
   //------------------------------------------------


   // dma_burst_done - detect when about to finish a burst
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         dma_burst_done <= 1'b0;

      // at bus_addr_inc_strobe sample value of burst breaking signals
      // to determine if burst is about to finish
      else if (bus_addr_inc_strobe)
         dma_burst_done <= ((data_burst_break & dma_state_data) |
                            one_to_burst_limit);

      // Else Clear again when last address phase (dma_burst_done has been seen)
      else if (last_burst_addr_ph)
         dma_burst_done <= 1'b0;

      // Else maintain value
      else
         dma_burst_done <= dma_burst_done;
    end
   //------------------------------------------------


   // more_dma_to_do - determine at end of current burst of we have more to do
   //------------------------------------------------
   assign more_dma_to_do = dma_burst_done & bus_req;
   //------------------------------------------------



// -----------------------------------------------------------------------------
// Sequential access detection
// -----------------------------------------------------------------------------

   // seq_access - determine if the next access is to be sequential from the
   //              current one. This is true in data reads or writes and not
   //              about to break 1K boundary
   //              or do an EOP burst.
   //------------------------------------------------
   assign seq_access = ~not_seq_access &
                       (dma_state_data);

   // not a sequential access if 1k boundary is crossed
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         not_seq_access <= 1'b0;
      else if (ahb_state_req | ahb_state_hold_off)
         not_seq_access <= breaks_1k_boundary | eop_burst;
    end



// -----------------------------------------------------------------------------
// Burst limit calculations
// -----------------------------------------------------------------------------

   // burst_cnt      - burst counter - counts the number of burst transfers
   //                  to be accomplished; increments on hready during dma if
   //                  no errors are encountered from ahb or dma data flow
   //                  any error will clear the counter;
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         burst_cnt <= 5'h00;

      // reset value when an error occurs
      else if (bus_abort | hresp_not_ok)
         burst_cnt <= 5'h00;

      // reset value when new access beginning
      else if (last_burst_addr_ph)
         burst_cnt <= 5'h00;

      // whilst access is on-going increment burst count, on every access
      // i.e. burst_cnt <= burst_cnt + 1
      else if (bus_addr_inc_strobe)
         burst_cnt <= next_burst_cnt[4:0];

      // Else maintain value
      else
         burst_cnt <= burst_cnt;
    end
   //------------------------------------------------


   // next_burst_cnt
   //------------------------------------------------
   assign next_burst_cnt = burst_cnt + 5'h01;
   //------------------------------------------------


   // one_to_burst_limit (i.e. burst_limit - 1)
   //------------------------------------------------
   assign one_to_burst_limit = (burst_cnt == (burst_limit - 5'h01));
   //------------------------------------------------

   always@(posedge hclk or negedge n_hreset)
      begin
         if (~n_hreset)
            man_rd_after_man_wr <= 1'b0;
         else if (rx_dma_next_man_rd & rx_dma_state_man_wr)
            man_rd_after_man_wr <= 1'b1;
         else if (~rx_dma_next_man_rd)
            man_rd_after_man_wr <= 1'b0;
      end

   //burst_limit     - max number of transfers to be done within the current
   //                  burst
   //------------------------------------------------
   always @(dma_bus_owner or dma_state_man_rd or dma_state_man_wr or
            ahb_burst_length or man_rd_after_man_wr)
    begin
      // If RX management write then do three transfers (2 write, one read)
      if (dma_bus_owner & (dma_state_man_wr | man_rd_after_man_wr))
         begin
            burst_limit = 5'h03;
         end

      // If RX management read (one that does not follow a man wr)
      // or TX management write then only do a single transfer
      else if ((dma_bus_owner & dma_state_man_rd) |
               (~dma_bus_owner & dma_state_man_wr))
         begin
            burst_limit = 5'h01;
         end

      // Else if TX management read then do two transfers
      else if (dma_state_man_rd)
         begin
            burst_limit = 5'h02;
         end

      // Else must be data so aim to do ahb_burst_length unless burst is broken
      else
         begin
            burst_limit = ahb_burst_length;
         end
    end
   //------------------------------------------------



// -----------------------------------------------------------------------------
// 1K burst boundary limit calculations
// -----------------------------------------------------------------------------

   // Convert ahb_burst_length to a mask to make it easier to select
   // correct bits for 1K boundary address comparison
   // Note that by this stage ahb_burst_length is one-hot.
   always @ (dma_bus_width or ahb_burst_length)
    begin
      case (dma_bus_width[1:0])
         2'b00   : begin // 32-bit wide access
                   ahb_burst_maskh = {3'b111,
                                      |(ahb_burst_length[4:0]),
                                      |(ahb_burst_length[3:0]),
                                      |(ahb_burst_length[2:0]),
                                      |(ahb_burst_length[1:0]),
                                      ahb_burst_length[0]};
                   end

         2'b01   : begin // 64-bit wide access
                   ahb_burst_maskh = {2'b11,
                                      |(ahb_burst_length[4:0]),
                                      |(ahb_burst_length[3:0]),
                                      |(ahb_burst_length[2:0]),
                                      |(ahb_burst_length[1:0]),
                                      ahb_burst_length[0],
                                      1'b0};
                   end

         default : begin // 128-bit wide access
                   ahb_burst_maskh = {1'b1,
                                      |(ahb_burst_length[4:0]),
                                      |(ahb_burst_length[3:0]),
                                      |(ahb_burst_length[2:0]),
                                      |(ahb_burst_length[1:0]),
                                      ahb_burst_length[0],
                                      2'b00};
                   end
      endcase
    end
   //------------------------------------------------


   // breaks_1k_boundary - Detect if next planned burst access will break the
   //                      1K AHB address boundary.
   //                      Look to see if all upper bits in the burst address
   //                      are set. If so then we will break the burst boundary
   //                      if any of the lower bits are set.
   //                      Also if only doing single accesses always indicate
   //                      boundary break.
   //------------------------------------------------
   assign breaks_1k_boundary = ahb_burst_length[0] |
                (((dma_burst_addr[9:2] &  ahb_burst_maskh) == ahb_burst_maskh) &
                 ((dma_burst_addr[9:2] & ~ahb_burst_maskh) != 8'h00));
   //------------------------------------------------



// -----------------------------------------------------------------------------
// Detect AHB address and data phases
// -----------------------------------------------------------------------------

   // ahb_addr_owned - Detects when the MAC owns the AHB address phase.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         ahb_addr_owned <= 1'b0;

      // reset when an error occurs
      else if (bus_abort | hresp_not_ok)
         ahb_addr_owned <= 1'b0;

      // Set if granted and waiting with new request
      else if (bus_addr_inc_strobe)
         ahb_addr_owned <= 1'b1;

      // Reset when burst is about to finish
      else if (hready)
         ahb_addr_owned <= 1'b0;

      // Else maintain value
      else
         ahb_addr_owned <= ahb_addr_owned;
    end
   //------------------------------------------------


   // ahb_data_owned - Detects when the MAC owns the AHB data phase.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         ahb_data_owned <= 1'b0;

      // if we own the address bus when hready is high, we will own
      // the next data phase
      else if (hready)
         ahb_data_owned <= ahb_addr_owned;

      // Else maintain value
      else
         ahb_data_owned <= ahb_data_owned;
    end
   //------------------------------------------------


   // Indicate when bus is Iidle or active.
   //------------------------------------------------
   assign bus_idle = ~(ahb_addr_owned | ahb_data_owned);
   //------------------------------------------------


   // bus_addr_inc_strobe - pulse to increment the internal address counters
   //                       for rx & tx dma at the point that the MAC is
   //                       granted access and is ready to perform it.
   //------------------------------------------------
   always @(hready or hgrant or ahb_state_hold_off or ahb_state_req or
            ahb_state_nonseq or ahb_state_seq or dma_burst_done or hresp_not_ok)
    begin
      // set high if about to get access to the AHB address bus
      if (hready & hgrant & (ahb_state_hold_off | ahb_state_req))
         bus_addr_inc_strobe = 1'b1;

      // also set high in the data state if we are in a burst
      else if (hready & hgrant & ~(dma_burst_done | hresp_not_ok) &
               (ahb_state_nonseq|ahb_state_seq))
         bus_addr_inc_strobe = 1'b1;

      // otherwise low
      else
         bus_addr_inc_strobe = 1'b0;
    end
   //------------------------------------------------


   // bus_addr_strobe - strobe to indicate that the mac is seeing the end of
   //                   a valid AHB address phase that it owns
   //------------------------------------------------
   assign bus_addr_strobe = ahb_addr_owned & hready;
   //------------------------------------------------


   // bus_data_strobe - strobe to indicate that the mac is seeing the end of
   //                   a valid AHB data phase that it owns
   //------------------------------------------------
   assign bus_data_strobe = ahb_data_owned & hready;
   //------------------------------------------------


   // last_burst_addr_ph - strobe to indicate that the mac is seeing the end of
   //                      a valid AHB address phase that it owns, and it is
   //                      the last it is performing in the current burst.
   //------------------------------------------------
   assign last_burst_addr_ph = bus_addr_strobe &
                                (dma_burst_done | hresp_not_ok);
    //------------------------------------------------

   always@(posedge hclk or negedge n_hreset)
      begin
        if (~n_hreset)
           stopburstdue2grant <= 1'b0;
        else if (ahb_next_state_hold & ~ahb_state_hold_off)
           stopburstdue2grant <= ~hgrant & ~dma_burst_done;
        else if (~ahb_next_state_hold)
           stopburstdue2grant <= 1'b0;
      end

   // last_burst_data_ph - strobe to indicate that the mac is seeing the end of
   //                      a valid AHB data phase that it owns, and it is
   //                      the last it is performing in the current burst.
   //------------------------------------------------
   assign last_burst_data_ph = bus_data_strobe &
                              ~bus_addr_strobe &
                              ~stopburstdue2grant;
    //------------------------------------------------



// -----------------------------------------------------------------------------
// RX DMA and TX DMA arbitration logic
// -----------------------------------------------------------------------------

   // dma_bus_owner     - signal indicating the next DMA block to have
   //                     control over the dma bus interface as follows:
   //                        1 - rx dma,
   //                        0 - tx dma;
   //                     Decision for the driving this signal is based on the
   //                     following arbitration rules:
   //                     1. management request has priority over data request
   //                     2. rx_dma request has priority over rx_dma request
   //                     New owner is granted only when in the ahb_state_req
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         begin
            dma_bus_owner      <= 1'b1;
         end

      // only change owner when entering hold off or req state
      else if (ahb_next_state_hold | ahb_next_state_req)
         begin

            // RX management transfer has highest priority
            if (rx_dma_bus_req & (rx_dma_next_man_wr | rx_dma_next_man_rd))
               dma_bus_owner <= 1'b1;

            // TX management transfer has next highest priority
            else if (tx_dma_bus_req & (tx_dma_next_man_rd | tx_dma_next_man_wr))
               dma_bus_owner <= 1'b0;

            // RX data transfer has next highest priority
            else if (rx_dma_bus_req & rx_dma_next_data)
               dma_bus_owner <= 1'b1;

            // TX data transfer has lowest priority
            else if (tx_dma_bus_req & tx_dma_next_data)
               dma_bus_owner <= 1'b0;

            // Else hold current owner
            else
               dma_bus_owner <= dma_bus_owner;
         end

      // Else hold current owner
      else
         begin
            dma_bus_owner <= dma_bus_owner;
         end
    end
   //------------------------------------------------


   // prev_dma_bus_owner- Previous bus owner for muxing data phase signals.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         prev_dma_bus_owner <= 1'b1;

      // sample previous owner at hready
      else if (hready)
         prev_dma_bus_owner <= dma_bus_owner;

      // Else hold current owner
      else
         prev_dma_bus_owner <= prev_dma_bus_owner;
    end
   //------------------------------------------------


   // multiplexing inputs between rx and tx according to
   // which is the current bus owner (dma_bus_owner)
   //------------------------------------------------
   always@(dma_bus_owner
           or rx_dma_state_man_wr or rx_dma_state_man_rd or rx_dma_state_data
           or rx_data_burst_break or rx_dma_burst_addr or rx_dma_flow_error
           or rx_dma_data_out or rx_dma_eop_burst
           or tx_dma_state_man_wr or tx_dma_state_man_rd or tx_dma_state_data
           or tx_data_burst_break or tx_dma_burst_addr or tx_dma_flow_error
           or tx_dma_data_out or tx_dma_eop_burst or hready or hgrant)
    begin
      if (dma_bus_owner)      // rx owns the bus interface
         begin
            dma_state_man_wr = rx_dma_state_man_wr;
            dma_state_man_rd = rx_dma_state_man_rd;
            dma_state_data   = rx_dma_state_data;
            data_burst_break = rx_data_burst_break | (hready & ~hgrant);
            dma_burst_addr   = rx_dma_burst_addr;
            bus_abort        = rx_dma_flow_error;
            dma_data_out     = rx_dma_data_out;
            eop_burst        = rx_dma_eop_burst;
         end
      else                        // tx owns the bus interface
         begin
            dma_state_man_wr = tx_dma_state_man_wr;
            dma_state_man_rd = tx_dma_state_man_rd;
            dma_state_data   = tx_dma_state_data;
            data_burst_break = tx_data_burst_break | (hready & ~hgrant);
            dma_burst_addr   = tx_dma_burst_addr;
            bus_abort        = tx_dma_flow_error;
            dma_data_out     = tx_dma_data_out;
            eop_burst        = tx_dma_eop_burst;
         end
    end
   //------------------------------------------------


   // demultiplexing address phase outputs for rx and tx according to the
   // current bus owner (dma_bus_owner)
   //------------------------------------------------
   always@(dma_bus_owner or last_burst_addr_ph or bus_addr_strobe or
           ahb_addr_owned or bus_addr_inc_strobe)
    begin
      if (dma_bus_owner)
         begin
            rx_last_addr_ph    = last_burst_addr_ph;
            rx_addr_strobe     = bus_addr_strobe;
            rx_addr_bus_owned  = ahb_addr_owned;
            rx_addr_inc_strobe = bus_addr_inc_strobe;

            tx_addr_strobe     = 1'b0;
            tx_addr_bus_owned  = 1'b0;
            tx_addr_inc_strobe = 1'b0;
         end
      else
         begin
            rx_last_addr_ph    = 1'b0;
            rx_addr_strobe     = 1'b0;
            rx_addr_bus_owned  = 1'b0;
            rx_addr_inc_strobe = 1'b0;

            tx_addr_strobe     = bus_addr_strobe;
            tx_addr_bus_owned  = ahb_addr_owned;
            tx_addr_inc_strobe = bus_addr_inc_strobe;
         end
    end
   //------------------------------------------------


   // demultiplexing data phase outputs for rx and tx according to the
   // previous bus owner (prev_dma_bus_owner)
   //------------------------------------------------
   always@(prev_dma_bus_owner or last_burst_data_ph or bus_data_strobe or
           hresp_not_ok)
    begin
      if (prev_dma_bus_owner)
         begin
            rx_last_data_ph    = last_burst_data_ph;
            rx_data_strobe     = bus_data_strobe;
            rx_burst_error     = hresp_not_ok;

            tx_last_data_ph    = 1'b0;
            tx_data_strobe     = 1'b0;
            tx_burst_error     = 1'b0;
         end
      else
         begin
            rx_last_data_ph    = 1'b0;
            rx_data_strobe     = 1'b0;
            rx_burst_error     = 1'b0;

            tx_last_data_ph    = last_burst_data_ph;
            tx_data_strobe     = bus_data_strobe;
            tx_burst_error     = hresp_not_ok;
         end
    end
   //------------------------------------------------



// -----------------------------------------------------------------------------
// AHB control outputs
// -----------------------------------------------------------------------------

   // hbusreq - output to AHB top request access to the bus
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         hbusreq <= 1'b0;

      // If going to idle then there's nothing more to do
      else if (ahb_next_state_idle)
         hbusreq <= 1'b0;

      // If in req or hold off states, request the bus
      else if (ahb_next_state_req | ahb_next_state_hold)
         hbusreq <= 1'b1;

      // Else if a burst is about to complete and there's nothing more to do
      // then drop request
      else if (~bus_req & bus_addr_inc_strobe &
                  ((data_burst_break & dma_state_data) |
                   one_to_burst_limit))
         hbusreq <= 1'b0;

      // Else mainatain value
      else
         hbusreq <= hbusreq;
    end
   //------------------------------------------------



   // htrans - output for AHB transfer sequence indication.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         htrans <= p_htrans_idle ;

      // if about to do a non-sequential access then indicate NONSEQ
      else if (ahb_next_state_nseq)
         htrans <= p_htrans_nseq ;

      // Else if about to do a sequential access then indicate SEQ
      else if (ahb_next_state_seq)
         htrans <= p_htrans_seq ;

      // Else nothing to do so must indicate idle
      else
         htrans <= p_htrans_idle ;
    end
   //------------------------------------------------


   // hsize - output for AHB transfer size indication.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         hsize <= p_hsize_32b;

      // if not accessing the bus then reset hsize signal
      else if (~ahb_next_state_nseq & ~ahb_next_state_seq)
         hsize <= p_hsize_32b;

      // if the DMA block that owns the bus is doing data then decode size
      // from the dma_bus_width configuration information
      else if (dma_state_data)
         case (dma_bus_width)
            2'b00   : hsize <= p_hsize_32b;
            2'b01   : hsize <= p_hsize_64b;
            default : hsize <= p_hsize_128b;
         endcase

      // For all management accesses it's always 32 bits.
      else
         hsize <= p_hsize_32b;
    end
   //------------------------------------------------


   // hwrite - output for AHB transfer direction indication.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         hwrite <= 1'b0;

      // if not accessing the bus then reset hwrite signal
      else if (~ahb_next_state_nseq & ~ahb_next_state_seq)
         hwrite <= 1'b0;

      // Setup for RX management read on last address phase of RX management wr.
      else if (rx_dma_next_man_rd & dma_bus_owner)
         hwrite <= 1'b0;

      // Set if the RX DMA is writing data or either DMA is doing a
      // management writeback
      else if ((dma_bus_owner & rx_dma_state_data) | dma_state_man_wr)
         hwrite <= 1'b1;

      // Else it must be a read
      else
         hwrite <= 1'b0;
    end
   //------------------------------------------------


   // hburst - output for AHB transfer burst length indication.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         hburst <= p_hburst_single;

      // Reset when state machine is idle
      else if (ahb_next_state_idle | ahb_next_state_hold)
         hburst <= p_hburst_single;

      // setup hburst before the beginning of a burst
      else if (ahb_next_state_nseq & ~ahb_state_nonseq)
         begin
            // If we are doing data then set value to indicate the configured
            // maximum burst length.
            // However if it's the last data in the buffer it may  be less
            // than a standard burst length (eop_burst is high).
            // Also if the data burst will break a 1K boundary, then also do as
            // single transfer
            if (dma_state_data & ~eop_burst & ~breaks_1k_boundary)
               case (ahb_burst_length[4:0])
                  5'd1    : hburst <= p_hburst_single;
                  5'd4    : hburst <= p_hburst_incr_4;
                  5'd8    : hburst <= p_hburst_incr_8;
                  5'd16   : hburst <= p_hburst_incr_16;
                  default : hburst <= p_hburst_incr;
               endcase

            // Otherwise must be doing a management read or write or
            // we cannot burst full data length so do a single transfer
            else
               hburst <= p_hburst_single;

         end

      // Maintain value once into the burst
      else
         hburst <= hburst;
    end
   //------------------------------------------------


   // haddr - ahb address output register
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         haddr <= {32{1'b0}};

      // if not accessing the bus then reset haddr signal
      else if (~ahb_next_state_nseq & ~ahb_next_state_seq)
         haddr <= {32{1'b0}};

      // else update the value of haddr on every hready
      else if (hready)
         haddr <= {dma_burst_addr,2'b00};

      // else maintain value
      else
         haddr <= haddr;
    end
   //------------------------------------------------


   // hlock - output to indicate to the AHB that the sequence of transfers
   //         must not be broken. In this implementation we lock the
   //         bus whenver hbusreq is set, although the user may decide
   //         not to connect this
   //------------------------------------------------
   assign hlock  = hbusreq;
   //------------------------------------------------


   // hprot - output for AHB transfer protection indication.
   //         assign to `gem_hprot_value define from gem_gxl_defs.v
   //------------------------------------------------
   assign hprot  = `edma_hprot_value;
   //------------------------------------------------



// -----------------------------------------------------------------------------
// AHB response decoding
// -----------------------------------------------------------------------------

   // hresp_not_ok - indicates that the response of the accessed slave  was
   //                either RETRY (unsupported) or ERROR.
   //------------------------------------------------
   assign hresp_not_ok = (hresp != p_hresp_ok) & hready & ahb_data_owned;
   //------------------------------------------------



// -----------------------------------------------------------------------------
// AHB read and write databus handling
// -----------------------------------------------------------------------------

   // Work out whether to endian swap on this access depending on the programmed
   // mode. endian_swap[0] indicates the desired endianism for management
   // operations and endian_swap[1] indicates the endianism for data operations.
   assign endian_swap_now = ((endian_swap[0] & ~dma_state_data) |
                             (endian_swap[1] &  dma_state_data));


   // dma_data_out_endian - Byte endian swapped version of write data.
   //                       Bytes only swapped within each 32-bit word
   //                       and then each word is later aligned to correct
   //                       word within the wider bus.
   //                         byte 0  => byte 3
   //                         byte 1  => byte 2
   //                         byte 2  => byte 1
   //                         byte 3  => byte 0
   //                         byte 4  => byte 7
   //                         byte 5  => byte 6
   //                         byte 6  => byte 5
   //                         byte 7  => byte 4
   //                         byte 8  => byte 11
   //                         byte 9  => byte 10
   //                         byte 10 => byte 9
   //                         byte 11 => byte 8
   //                         byte 12 => byte 15
   //                         byte 13 => byte 14
   //                         byte 14 => byte 13
   //                         byte 15 => byte 12
   //------------------------------------------------
   always @(endian_swap_now or dma_data_out)
    begin
      if (endian_swap_now)
       begin
         dma_data_out_endian = {dma_data_out[103:96],
                                dma_data_out[111:104],
                                dma_data_out[119:112],
                                dma_data_out[127:120],
                                dma_data_out[71:64],
                                dma_data_out[79:72],
                                dma_data_out[87:80],
                                dma_data_out[95:88],
                                dma_data_out[39:32],
                                dma_data_out[47:40],
                                dma_data_out[55:48],
                                dma_data_out[63:56],
                                dma_data_out[7:0],
                                dma_data_out[15:8],
                                dma_data_out[23:16],
                                dma_data_out[31:24]};
       end
      else
       begin
         dma_data_out_endian = dma_data_out[127:0];
       end
    end
   //------------------------------------------------


   // sel_word_lane - bus lane corresponding to the accessed words
   //------------------------------------------------
   always@(haddr or dma_bus_width or endian_swap_now)
    begin
    if (endian_swap_now)
     begin
      // Big endian order: least significant word @ highest address
      casex ({dma_bus_width, haddr[3:2]})

         4'b1x00 :                      // 128 bit bus; 00 word offset
                 sel_word_lane = 2'b11; // enable data[127:96]

         4'b1x01 :                      // 128 bit bus; 01 word offset
                 sel_word_lane = 2'b10; // enable data[95:64]

         4'b1x10 :                      // 128 bit bus; 10 word offset
                 sel_word_lane = 2'b01; // enable data[63:32]

         4'b01x0 :                      // 64 bit bus; x0 word offset
                 sel_word_lane = 2'b01; // enable data[63:32]

         default :                      // 32 bit bus or
                                        // 128 bit bus; 11 word offset
                                        // 64 bit bus; x1 word offset
                 sel_word_lane = 2'b00; // enable data[31:00]

      endcase
     end
    else
     begin
      // Little endian order: least significant word @ lowest address
      casex ({dma_bus_width,haddr[3:2]})

         4'b1x01 :                      // 128 bit bus; 01 word offset
                 sel_word_lane = 2'b01; // enable data[63:32]

         4'b1x10 :                      // 128 bit bus; 10 word offset
                 sel_word_lane = 2'b10; // enable data[95:64]

         4'b1x11 :                      // 128 bit bus; 11 word offset
                 sel_word_lane = 2'b11; // enable data[127:96]

         4'b01x1 :                      // 64 bit bus; x1 word offset
                 sel_word_lane = 2'b01; // enable data[63:32]

         default :                      // 32 bit bus or
                                        // 128 bit bus; 00 word offset
                                        // 64 bit bus; x0 word offset
                 sel_word_lane = 2'b00; // enable data[31:00]

      endcase
     end
    end
   //------------------------------------------------


   // rd_enable_word - registered version of sel_word_lane.
   //                  required because data phase is one cycle after the
   //                  address phase, therefore we must register the
   //                  word address offset information
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
       begin
         rd_enable_word <= 2'b00;
         rd_endian_swap_now <= 1'b0;
       end

      // hold version of sel_word_lane at end of address phase
      else if (bus_addr_strobe)
       begin
         rd_enable_word <= sel_word_lane;
         rd_endian_swap_now <= endian_swap_now;
       end

      // Else maintain value
      else
       begin
         rd_enable_word <= rd_enable_word;
         rd_endian_swap_now <= rd_endian_swap_now;
       end
    end
   //------------------------------------------------


   // hwdata - ahb data output register
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
         hwdata <= {128{1'b0}};

      // If we don't own the next data phase zero write data to allow
      // for wired or on system level
      else if (hready & ~ahb_addr_owned)
         hwdata <= {128{1'b0}};

      // select correct word lane on the 128 bit bus
      else if (bus_addr_strobe)
         case (sel_word_lane)

            2'b11   : begin
                       hwdata[127:96] <= dma_data_out_endian[31:0];
                       hwdata[95:64]  <= dma_data_out_endian[63:32];
                       hwdata[63:32]  <= dma_data_out_endian[95:64];
                       hwdata[31:0]   <= dma_data_out_endian[127:96];
                      end

            2'b01   : begin
                       hwdata[127:64] <= {64{1'b0}};
                       hwdata[63:32]  <= dma_data_out_endian[31:0];
                       hwdata[31:0]   <= dma_data_out_endian[63:32];
                      end

            2'b10   : begin
                       hwdata[127:96] <= {32{1'b0}};
                       hwdata[95:64]  <= dma_data_out_endian[31:0];
                       hwdata[63:0]   <= {64{1'b0}};
                      end

            default : begin
                       hwdata[127:0]  <= dma_data_out_endian[127:0];
                      end
         endcase

      // Else maintain value
      else
         hwdata <= hwdata;
    end
   //------------------------------------------------


   // dma_data_rd_endian - selected input data from AHB. This is transferred
   //                      to both dma_rx and dma_tx blocks via an endian swap
   //------------------------------------------------
   always@(rd_enable_word or hrdata)
      begin
         case (rd_enable_word)

            2'b11   : begin
                       dma_data_rd_endian[127:96] = hrdata[31:0];
                       dma_data_rd_endian[95:64]  = hrdata[63:32];
                       dma_data_rd_endian[63:32]  = hrdata[95:64];
                       dma_data_rd_endian[31:0]   = hrdata[127:96];
                      end

            2'b01   : begin
                       dma_data_rd_endian[127:64] = {64{1'b0}};
                       dma_data_rd_endian[63:32]  = hrdata[31:0];
                       dma_data_rd_endian[31:0]   = hrdata[63:32];
                      end

            2'b10   : begin
                       dma_data_rd_endian[127:32] = {96{1'b0}};
                       dma_data_rd_endian[31:0]   = hrdata[95:64];
                      end

            default : begin
                       dma_data_rd_endian[127:0]  = hrdata[127:0];
                      end
         endcase
      end
   //------------------------------------------------


   // dma_data_rd - byte endian swapped version of read data.
   //               Words are already aligned, so just need to
   //               swap bytes within each 32-bit word.
   //                 byte 0  => byte 3
   //                 byte 1  => byte 2
   //                 byte 2  => byte 1
   //                 byte 3  => byte 0
   //                 byte 4  => byte 7
   //                 byte 5  => byte 6
   //                 byte 6  => byte 5
   //                 byte 7  => byte 4
   //                 byte 8  => byte 11
   //                 byte 9  => byte 10
   //                 byte 10 => byte 9
   //                 byte 11 => byte 8
   //                 byte 12 => byte 15
   //                 byte 13 => byte 14
   //                 byte 14 => byte 13
   //                 byte 15 => byte 12
   //------------------------------------------------
   always @(rd_endian_swap_now or dma_data_rd_endian)
    begin
      if (rd_endian_swap_now)
       begin
         dma_data_rd = {dma_data_rd_endian[103:96],
                        dma_data_rd_endian[111:104],
                        dma_data_rd_endian[119:112],
                        dma_data_rd_endian[127:120],
                        dma_data_rd_endian[71:64],
                        dma_data_rd_endian[79:72],
                        dma_data_rd_endian[87:80],
                        dma_data_rd_endian[95:88],
                        dma_data_rd_endian[39:32],
                        dma_data_rd_endian[47:40],
                        dma_data_rd_endian[55:48],
                        dma_data_rd_endian[63:56],
                        dma_data_rd_endian[7:0],
                        dma_data_rd_endian[15:8],
                        dma_data_rd_endian[23:16],
                        dma_data_rd_endian[31:24]};
       end
      else
       begin
         dma_data_rd = dma_data_rd_endian[127:0];
       end
    end
   //------------------------------------------------


endmodule
