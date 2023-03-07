//------------------------------------------------------------------------------
// Copyright (c) 2008-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_tx_align.v
//   Module Name:        edma_pbuf_tx_align
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
//   Description: This module perfoms alignment of TX data as it is read
//                from the AHB. Each buffer can begin with an offset, which
//                is defined in the descriptors. This module strips out
//                this offset from the first data in the buffer, and then
//                continuously realigns the rest of the data in the buffer
//                to create full 32, 64 or 128 bit words to be written into
//                the FIFO. If required any residue left at the end of the
//                final buffer in a frame is forced into the FIFO as an
//                incomplete word.
//                Additionally this module calculates the current number of
//                free slots in the FIFO, based on any on-going buffer
//                activity. If there are enough free slots for further DMA
//                operation the fifo_free_slots output is activated.
//
//------------------------------------------------------------------------------


module edma_pbuf_tx_align #(
   parameter TX_BASE2_FIFO_SIZE  = 4'b1010,
   parameter TX_FIFO_CNT_WIDTH   = 4,
   parameter p_edma_asf_dap_prot = 1'b0
   ) (

   // system signals
   hclk,
   n_hreset,

   // signals coming from gem_registers
   dma_bus_width,

   // inputs from edma_tx
   tx_dma_state_data,
   tx_data_strobe,
   frm_val_data_phase,
   hrdata,
   hrdata_par,
   buffer_done_decode,
   last_buf_done_decode,
   last_access_bytes,
   tx_length_decrement,
   tx_buffer_offset,
   //sop_written_to_fifo,
   dma_w_fifo_count,
   dma_w_flush,
   force_fifo_eop_err,

   // outputs to edma_tx
   dma_w_data,
   dma_w_data_par,
   dma_w_wr,
   //dma_w_sop,
   dma_w_eop,
   //dma_w_err,
   dma_w_mod

   );


//******************************************************************************
// port declarations
//******************************************************************************

   input          hclk;                // AHB clock
   input          n_hreset;            // AHB reset

   // gem_registers block interface
   input    [1:0] dma_bus_width;       // 00 = 32  bit bus
                                       // 01 = 64  bit bus
                                       // 11 = 128 bit bus (default)

   // inputs from edma_tx
   input          tx_dma_state_data;   // main state machine currently in
                                       // data read state
   input          tx_data_strobe;      // signals individual ahb data phase
   input          frm_val_data_phase;  // valid data phase when in data state
   input  [127:0] hrdata;              // AHB input data   128 bits
   input  [15:0]  hrdata_par;
   input          buffer_done_decode;  // next data phase is the final read
                                       // in the buffer
   input          last_buf_done_decode;// next data phase is the final read
                                       // in the last buffer of a frame.
   input    [4:0] last_access_bytes;   // number of bytes in last access.
   input    [4:0] tx_length_decrement; // sets amount tx_dma_length is to be
                                       // decremented by on next clock
                                       // set by dma_bus_width
   input    [3:0] tx_buffer_offset;    // byte offset of start of buffer
   //input          sop_written_to_fifo; // SOP has now been written into FIFO
   input [(TX_FIFO_CNT_WIDTH -1):0]
                  dma_w_fifo_count;    // number of valid words in FIFO in hclk
   input          dma_w_flush;         // FIFO flush is active
   input          force_fifo_eop_err;  // Force an ERROR into FIFO with EOP

   // outputs to edma_tx
   output [127:0] dma_w_data;          // Aligned word to be written to FIFO
   output [15:0]  dma_w_data_par;
   output         dma_w_wr;            // Write new aligned word to FIFO
   output         dma_w_eop;           // FIFO write is last data in frame
   //output         dma_w_sop;           // FIFO write is first data in frame
   output   [3:0] dma_w_mod;           // indicates number of bytes valid in
                                       // EOP FIFO write.
   //output         dma_w_err;           // Push an error into the FIFO.


   //***************************************************************************
   // wire and reg declarations
   //***************************************************************************

   // Offset stripping buffer
   reg    [127:0] txd_data_in;         // incoming data right justified.
   reg    [15:0]  txd_par_in;          // the last 16 bits are parity of the txd_data
   reg    [127:0] txd_data;            // registered txd_data_in.
   wire   [15:0]  txd_par;             // the last 16 bits are parity of the txd_data
   reg      [4:0] no_txd_data;         // number of bytes valid in txd_data.
   reg            new_txd_data;        // new txd_data available.
   reg            last_txd_data;       // last txd_data in buffer now available.
   reg            first_txd_data;      // indicates first access of a buffer

   // alignment buffer control
   reg      [3:0] align_pntr;          // Points to next byte to fill
   wire     [5:0] next_align_pntr;     // Next value of align_pntr
   reg            next_align_full;     // Alignment buffer about to be filled
   reg            next_align_overflow; // Alignment buffer about to overflow
   reg            prev_align_overflowd;// Alignment buffer overflowed
   reg            last_aligned_data;   // last frame data in align buffer
   reg            force_over_align;    // force overflow into align buffer
   reg            force_over_store;    // store force overflow when no room
                                       // in FIFO.
   reg    [247:0] txd_data_align;      // buffer containing aligned data
                                       // in lowest 128 bits and residue
                                       // in upper 120 bits
   wire   [30:0]  txd_par_align;       //parity of txd_data_align

   reg    [247:0] txd_data_align_nxt;  // buffer containing aligned data
                                       // in lowest 128 bits and residue
                                       // in upper 120 bits.
   reg    [30:0]  txd_par_align_nxt;   //parity of txd_data_align_nxt

   // FIFO interface
   reg            dma_w_wr_gen;        // new 128 bit aligned data ready
   reg      [3:0] dma_w_mod;           // valid number of bytes in new
                                       // aligned data
   reg            force_eop_err_store; // store force_fifo_eop_err if no space
   reg            force_eop_err;       // force_fifo_eop_err when enough space

   // FIFO level logic
   reg            dma_w_wr_del;        // delayed dma_w_wr.
   wire     [3:0] accesses_left;       // number of accesses on-going
   reg  [TX_FIFO_CNT_WIDTH:0]
                  next_free_slots;     // next number of slots available, once
                                       // adjusted for on-going accesses.
   reg            fifo_free_slots_one; // set when there is one or more free
                                       // slots available in the fifo.

//******************************************************************************
// Main body of code
//******************************************************************************


//******************************************************************************
// Offset stripping buffer
//******************************************************************************

  // first_txd_data is asserted to indicate the first data burst access
  // either at the begining of a frame or at the beginning of each descriptor
  // last_txd_data is pulsed every time the last buffer is done.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      first_txd_data  <= 1'b1;
      last_txd_data   <= 1'b0;
    end

    // If flushing next data must be first in buffer
    else if(dma_w_flush)
    begin
      first_txd_data  <= 1'b1;
      last_txd_data   <= 1'b0;
    end

    // at every data strobe in data state, check to see if buffer is done
    else if(tx_data_strobe & tx_dma_state_data)
    begin
      first_txd_data  <= buffer_done_decode;
      last_txd_data   <= last_buf_done_decode;
    end

    // else maintain value for first_txd_data or zero last_txd_data
    else
    begin
      first_txd_data  <= first_txd_data;
      last_txd_data   <= 1'b0;
    end
  end


  // right justify incoming new hrdata. Only applies to first data in
  // a buffer as indicated by first_txd_data.
  always @(*)
  begin
    if (first_txd_data)
      case (tx_buffer_offset)
        4'b0001 : txd_data_in = {8'h00, hrdata[127:8]};
        4'b0010 : txd_data_in = {16'd0, hrdata[127:16]};
        4'b0011 : txd_data_in = {24'd0, hrdata[127:24]};
        4'b0100 : txd_data_in = {32'd0, hrdata[127:32]};
        4'b0101 : txd_data_in = {40'd0, hrdata[127:40]};
        4'b0110 : txd_data_in = {48'd0, hrdata[127:48]};
        4'b0111 : txd_data_in = {56'd0, hrdata[127:56]};
        4'b1000 : txd_data_in = {64'd0, hrdata[127:64]};
        4'b1001 : txd_data_in = {72'd0, hrdata[127:72]};
        4'b1010 : txd_data_in = {80'd0, hrdata[127:80]};
        4'b1011 : txd_data_in = {88'd0, hrdata[127:88]};
        4'b1100 : txd_data_in = {96'd0, hrdata[127:96]};
        4'b1101 : txd_data_in = {104'd0,hrdata[127:104]};
        4'b1110 : txd_data_in = {112'd0,hrdata[127:112]};
        4'b1111 : txd_data_in = {120'd0,hrdata[127:120]};
        default : txd_data_in =         hrdata[127:0];
      endcase
    else
      txd_data_in = hrdata;
  end
  // The input should be first extended to take in the parity bits.
  // In this module, the databus is realigned. Some bytes of “hrdata”
  // are passed to “txd_data_in” bus. Sometimes bytes of 0x0 are passed.
  // In the case where “hrdata” is passed, the parity bytes should
  // be simply passed through directly.  Where 0x0 is passed, a parity
  // bit of ‘0’ should be used.
  always @(*)
  begin
    if (first_txd_data)
      case (tx_buffer_offset)
        4'b0001 : txd_par_in  = {1'b0,  hrdata_par[15:1]};
        4'b0010 : txd_par_in  = {2'd0,  hrdata_par[15:2]};
        4'b0011 : txd_par_in  = {3'd0,  hrdata_par[15:3]};
        4'b0100 : txd_par_in  = {4'd0,  hrdata_par[15:4]};
        4'b0101 : txd_par_in  = {5'd0,  hrdata_par[15:5]};
        4'b0110 : txd_par_in  = {6'd0,  hrdata_par[15:6]};
        4'b0111 : txd_par_in  = {7'd0,  hrdata_par[15:7]};
        4'b1000 : txd_par_in  = {8'd0,  hrdata_par[15:8]};
        4'b1001 : txd_par_in  = {9'd0,  hrdata_par[15:9]};
        4'b1010 : txd_par_in  = {10'd0, hrdata_par[15:10]};
        4'b1011 : txd_par_in  = {11'd0, hrdata_par[15:11]};
        4'b1100 : txd_par_in  = {12'd0, hrdata_par[15:12]};
        4'b1101 : txd_par_in  = {13'd0, hrdata_par[15:13]};
        4'b1110 : txd_par_in  = {14'd0, hrdata_par[15:14]};
        4'b1111 : txd_par_in  = {15'd0, hrdata_par[15]};
        default : txd_par_in  = hrdata_par;
      endcase
    else
      txd_par_in  = hrdata_par;
  end

  // register incoming data after justifying.
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      txd_data  <= 128'd0;
    else
      txd_data  <= txd_data_in;
  end

  // Store the parity
  generate if (p_edma_asf_dap_prot == 1) begin : gen_txd_par
    reg [15:0]  txd_par_r;
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        txd_par_r <= 16'd0;
      else
        txd_par_r <= txd_par_in;
    end
    assign txd_par  = txd_par_r;
  end else begin : gen_no_txd_par
    assign txd_par  = 16'd0;
  end
  endgenerate

  // work out how many valid bytes there are in the new txd_data.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      no_txd_data <= 5'b00000;

    // clear on a flush
    else if (dma_w_flush)
      no_txd_data <= 5'b00000;

    // final data phase in buffer, so take how much is left.
    else if (tx_data_strobe & buffer_done_decode & tx_dma_state_data)
      no_txd_data <= last_access_bytes[4:0];

    // first data phase in buffer, so calculate amount of
    // data for full word minus the offset.
    else if (tx_data_strobe & first_txd_data & tx_dma_state_data)
      no_txd_data <= (tx_length_decrement[4:0] - {1'b0, tx_buffer_offset});

    // data transfer in middle of buffer, so full transfer
    else if (tx_data_strobe & tx_dma_state_data)
      no_txd_data <= tx_length_decrement[4:0];

    // else maintain value
    else
      no_txd_data <= no_txd_data[4:0];
  end


  // new txd_data is available on registered hready strobe when in the
  // data state.
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      new_txd_data  <= 1'b0;
    else
      new_txd_data  <= tx_data_strobe & tx_dma_state_data;
  end


//******************************************************************************
// 128-bit alignment buffer plus 120-bit residue.
//******************************************************************************

  // Keep an offset pointer to keep track of current byte being
  // written to in 128 bit alignment buffer (16 possible bytes)
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      align_pntr  <= 4'h0;

    // If main state machine is idle, or last aligned data has been
    // processed, then reset alignment pointer to byte 0
    else if (dma_w_flush | force_fifo_eop_err | last_aligned_data)
      align_pntr  <= 4'h0;

    // If last data transfered has overflowed a new transfer will
    // be initiated. Zero pointer after this event
    // Note that if this event doesn't happen then the pointer will
    // already be zero (no overflow)
    else if (force_over_align)
      align_pntr  <= 4'h0;

    // When new txd data available, assign align_pntr to new value
    else if (new_txd_data)
      case (dma_bus_width)
        2'b00   : align_pntr  <= {2'b00,next_align_pntr[1:0]};
        2'b01   : align_pntr  <= {1'b0, next_align_pntr[2:0]};
        default : align_pntr  <= next_align_pntr[3:0];
      endcase

    // Else maintain value
    else
      align_pntr  <= align_pntr;
  end


  // work out how many bytes will be present in the alignment buffer
  // after the next load (equals the current plus the incoming new bytes)
  assign next_align_pntr = ({1'b0, align_pntr[3:0]} + no_txd_data[4:0]);


  // detect when the alignemnt buffer will be full or have overflow when
  // the next load is completed.
  always @(*)
  begin
    case (dma_bus_width)
      2'b00   : begin
        next_align_full     = next_align_pntr[2];
        next_align_overflow = next_align_pntr[2] & (next_align_pntr[1:0] != 2'b00);
      end
      2'b01   : begin
        next_align_full     = next_align_pntr[3];
        next_align_overflow = next_align_pntr[3] & (next_align_pntr[2:0] != 3'b000);
      end
      default : begin
        next_align_full     = next_align_pntr[4];
        next_align_overflow = next_align_pntr[4] & (next_align_pntr[3:0] != 4'h0);
      end
    endcase
  end


  // Indicate when there has been an overflow of the alignment buffer.
  // This will be used to force the residue back into the alignment buffer,
  // ready for the next new data or at the end of a frame.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      prev_align_overflowd  <= 1'b0;
    else if (dma_w_flush | force_fifo_eop_err | last_aligned_data)
      prev_align_overflowd  <= 1'b0;
    else if (new_txd_data & next_align_overflow)
      prev_align_overflowd  <= 1'b1;
    else if (new_txd_data | force_over_align)
      prev_align_overflowd  <= 1'b0;
    else
      prev_align_overflowd  <= prev_align_overflowd;
  end


  // detect when final data in frame is at the output of the alignment buffer.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      last_aligned_data <= 1'b0;
    else if (dma_w_flush | force_fifo_eop_err)
      last_aligned_data <= 1'b0;
    else if ((last_txd_data & ~next_align_overflow) | force_over_align)
      last_aligned_data <= 1'b1;
    else
      last_aligned_data <= 1'b0;
  end


  // force overflow to be transfered to alignment buffer at last_txd_data.
  // If the last txd data load caused an overflow and then force it
  // into the alignment buffer.
  // If there is not enough slots in the FIFO, then store the force
  // overflow until there is room.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      force_over_align  <= 1'b0;
      force_over_store  <= 1'b0;
    end

    // reset if main state machine is idle or there is a flush
    else if (dma_w_flush | force_fifo_eop_err)
    begin
      force_over_align  <= 1'b0;
      force_over_store  <= 1'b0;
    end

    // if a force overflow has been stored and there is now enough room,
    // then we can now force the final push.
    else if (force_over_store & fifo_free_slots_one)
    begin
      force_over_align  <= 1'b1;
      force_over_store  <= 1'b0;
    end

    // Last data has now been loaded into the alignment buffer. If it
    // overflowed then we will need to force the overflow as the final write.
    // Can only signal this when we know there are enough free slots,
    // otherwise store until there is.
    else if (last_txd_data & next_align_overflow)
    begin
      force_over_align  <= fifo_free_slots_one;
      force_over_store  <= ~fifo_free_slots_one;
    end

    // else continue to hold stored value, but zero force_over_align, to
    // ensure that it is only a pulse.
    else
    begin
      force_over_align  <= 1'b0;
      force_over_store  <= force_over_store;
    end
  end


  // txd_data_align data alignment buffer
  // Used to re-align data into 128 bit chunks after stripping out offset.
  // This buffer is split into two portions. The lower portion is for
  // the alignment buffer itself, that will be used to present aligned
  // data for further processing.
  // The upper portion forms the residue for overspill from the lower portion.
  // This residue is moved back into the lower portion when an overflow
  // is detected.
  // For 32-bit DMA bus width, the lower portion is bits[31:0], and the
  // residue is in bits [63:32] (bits[247:64] are unused).
  // For 64-bit DMA bus width, the lower portion is bits[63:0], and the
  // residue is in bits [127:64] (bits[247:128] are unused).
  // For 128-bit DMA bus width, the lower portion is bits[127:0], and the
  // residue is in bits [247:128] (all bits are used).
  always @(*)
  begin
    // default
    txd_data_align_nxt  = txd_data_align;
    txd_par_align_nxt   = txd_par_align;

    // if previous store overflowed need to ensure residue is placed
    // in the bottom bytes (marked as used by this point). To
    // simplify statements the whole of the residue is copied down
    // and then overwritten by new txd data if appropriate.
    if ((new_txd_data & prev_align_overflowd) | force_over_align)
    begin
      case (dma_bus_width)
        2'b00   : begin
          txd_data_align_nxt[31:0]  = txd_data_align_nxt[63:32];
          txd_par_align_nxt[3:0]    = txd_par_align_nxt[7:4];
        end
        2'b01   : begin
          txd_data_align_nxt[63:0]  = txd_data_align_nxt[127:64];
          txd_par_align_nxt[7:0]    = txd_par_align_nxt[15:8];
        end
        default : begin
          txd_data_align_nxt[119:0] = txd_data_align_nxt[247:128];
          txd_par_align_nxt[14:0]   = txd_par_align_nxt[30:16];
        end
      endcase
    end
    // if new txd data is available load up the correct number
    // of valid bytes into the buffer, beginning at the byte
    // pointed to by align_pntr. Always load the full 128 bits so that
    // any residue is stored.
    if (new_txd_data)
    begin
      case (align_pntr)
        4'h1:
        begin
          txd_data_align_nxt[135:8]   = txd_data[127:0];
          txd_par_align_nxt[16:1]     = txd_par[15:0];
        end
        4'h2:
        begin
          txd_data_align_nxt[143:16]  = txd_data[127:0];
          txd_par_align_nxt[17:2]     = txd_par[15:0];
        end
        4'h3:
        begin
          txd_data_align_nxt[151:24]  = txd_data[127:0];
          txd_par_align_nxt[18:3]     = txd_par[15:0];
        end
        4'h4:
        begin
          txd_data_align_nxt[159:32]  = txd_data[127:0];
          txd_par_align_nxt[19:4]     = txd_par[15:0];
        end
        4'h5:
        begin
          txd_data_align_nxt[167:40]  = txd_data[127:0];
          txd_par_align_nxt[20:5]     = txd_par[15:0];
        end
        4'h6:
        begin
          txd_data_align_nxt[175:48]  = txd_data[127:0];
          txd_par_align_nxt[21:6]     = txd_par[15:0];
        end
        4'h7:
        begin
          txd_data_align_nxt[183:56]  = txd_data[127:0];
          txd_par_align_nxt[22:7]     = txd_par[15:0];
        end
        4'h8:
        begin
          txd_data_align_nxt[191:64]  = txd_data[127:0];
          txd_par_align_nxt[23:8]     = txd_par[15:0];
        end
        4'h9:
        begin
          txd_data_align_nxt[199:72]  = txd_data[127:0];
          txd_par_align_nxt[24:9]     = txd_par[15:0];
        end
        4'ha:
        begin
          txd_data_align_nxt[207:80]  = txd_data[127:0];
          txd_par_align_nxt[25:10]    = txd_par[15:0];
        end
        4'hb:
        begin
          txd_data_align_nxt[215:88]  = txd_data[127:0];
          txd_par_align_nxt[26:11]    = txd_par[15:0];
        end
        4'hc:
        begin
          txd_data_align_nxt[223:96]  = txd_data[127:0];
          txd_par_align_nxt[27:12]    = txd_par[15:0];
        end
        4'hd:
        begin
          txd_data_align_nxt[231:104] = txd_data[127:0];
          txd_par_align_nxt[28:13]    = txd_par[15:0];
        end
        4'he:
        begin
          txd_data_align_nxt[239:112] = txd_data[127:0];
          txd_par_align_nxt[29:14]    = txd_par[15:0];
        end
        4'hf:
        begin
          txd_data_align_nxt[247:120] = txd_data[127:0];
          txd_par_align_nxt[30:15]    = txd_par[15:0];
        end
        default:
        begin
          txd_data_align_nxt[127:0]   = txd_data[127:0];
          txd_par_align_nxt[15:0]     = txd_par[15:0];
        end
      endcase
    end
  end

  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      txd_data_align  <= 248'd0;
    else
      txd_data_align  <= txd_data_align_nxt;
  end

  generate if (p_edma_asf_dap_prot == 1) begin : gen_txd_par_align
    reg [30:0]  txd_par_align_r;

    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        txd_par_align_r <= 31'd0;
      else
        txd_par_align_r <= txd_par_align_nxt;
    end
    assign txd_par_align = txd_par_align_r;
  end else begin : gen_no_txd_par_align
    assign txd_par_align  = 31'd0;
  end
  endgenerate

//******************************************************************************
// TX DMA FIFO write interface
//******************************************************************************


  // FIFO write data is always the bottom 128 bits of the aligned data
  assign dma_w_data     = txd_data_align[127:0];
  assign dma_w_data_par = txd_par_align[15:0];

  // Indicate when new aligned data is available to write into the FIFO.
  // Either when the alignment buffer is filled, or when the last data in
  // a frame has not forced an overflow of the alignment buffer, or when
  // a forced overflow is active.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      dma_w_wr_gen  <= 1'b0;
    else if (dma_w_flush | force_fifo_eop_err | last_aligned_data)
      dma_w_wr_gen  <= 1'b0;
    else if ((next_align_full & new_txd_data) |
             (last_txd_data & ~next_align_overflow) |
             force_over_align)
      dma_w_wr_gen  <= 1'b1;
    else
      dma_w_wr_gen  <= 1'b0;
  end

  // dma_w_wr output is also forced when an ERR/EOP combination is
  // required to be forced into the FIFO.
  assign dma_w_wr = dma_w_wr_gen | force_eop_err;


  // Indicate how many bytes are valid in the last aligned data.
  // If the last txd data is about to be loaded into the align buffer
  // and doesn't overflow it, or if there is a force overflow, then MOD
  // is indicated by the next alignment pointer value.
  // Zero upper bits depending on bus width
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      dma_w_mod <= 4'h0;

    // if last data is not going to overflow buffer then take next_align_pntr.
    else if (last_txd_data & ~next_align_overflow)
      case (dma_bus_width)
        2'b00   : dma_w_mod <= {2'b00,next_align_pntr[1:0]};
        2'b01   : dma_w_mod <= {1'b0, next_align_pntr[2:0]};
        default : dma_w_mod <= next_align_pntr[3:0];
      endcase

    // if last data overflowed the buffer then take align_pntr.
    else if (force_over_align)
      case (dma_bus_width)
        2'b00   : dma_w_mod <= {2'b00,align_pntr[1:0]};
        2'b01   : dma_w_mod <= {1'b0, align_pntr[2:0]};
        default : dma_w_mod <= align_pntr[3:0];
      endcase

    // Else indicate full 16 bytes
    else
      dma_w_mod <= 4'h0;
  end


  // end of packet set when last aligned data is being presented
  // dma_w_eop output is also forced when an ERR/EOP combination is
  // required to be forced into the FIFO.
  assign dma_w_eop = last_aligned_data | force_eop_err;


  // If there is not enough slots in the FIFO to do the force_fifo_eop_err,
  // then store until there is room.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      force_eop_err_store <= 1'b0;
      force_eop_err       <= 1'b0;
    end

    // clear on a flush
    else if(dma_w_flush)
    begin
      force_eop_err_store <= 1'b0;
      force_eop_err       <= 1'b0;
    end

    // if a force_fifo_eop_err has been stored and there is now enough room,
    // then we can now force the final push.
    else if ((force_fifo_eop_err | force_eop_err_store) & fifo_free_slots_one)
    begin
      force_eop_err_store <= 1'b0;
      force_eop_err       <= 1'b1;
    end

    // if a force_fifo_eop_err happens and there is not enough room,
    // then store as force_eop_err_store.
    else if (force_fifo_eop_err)
    begin
      force_eop_err_store <= 1'b1;
      force_eop_err       <= 1'b0;
    end

    // else continue to hold stored value
    else
    begin
      force_eop_err_store <= force_eop_err_store;
      force_eop_err       <= 1'b0;
    end
  end



//******************************************************************************
// FIFO level monitor
//******************************************************************************

  // delay FIFO write strobe to detect when another word is being written to
  // the FIFO (allows for delay in fifo count output)
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      dma_w_wr_del  <= 1'b0;
    else
      dma_w_wr_del  <= dma_w_wr;
  end

  // calculate how many on-going AHB or data store accesses have still to
  // be acccounted for in the fifo count.
  assign accesses_left = {3'b000, dma_w_wr} +              // +1 if writing
                         {3'b000, dma_w_wr_del} +          // +1 if just written
                         {3'b000, new_txd_data} +          // +1 if new data
                         {2'b00, frm_val_data_phase,1'b0}; // +2 if ongoing
                                                           // AHB access

  wire [TX_FIFO_CNT_WIDTH:0] dma_w_fifo_count_p_accesses_left;
  
  assign dma_w_fifo_count_p_accesses_left = (dma_w_fifo_count[(TX_FIFO_CNT_WIDTH -1):0] + accesses_left);
  
  // calculate the number of real FIFO slots available once on-going accesses
  // from the AHB or data store have completed
  always @(*)
  begin
    // if current count plus the ajustment for on-going activity is
    // greater than the fifo depth, then there are no free slots.
    if (dma_w_fifo_count_p_accesses_left[TX_FIFO_CNT_WIDTH-1:0] > TX_BASE2_FIFO_SIZE)
      next_free_slots = {(TX_FIFO_CNT_WIDTH + 1){1'b0}};

    // else take away the adjusted count value from the depth to get the
    // number of free slots available
    else
      next_free_slots = TX_BASE2_FIFO_SIZE - (dma_w_fifo_count[(TX_FIFO_CNT_WIDTH -1):0] + accesses_left);
  end


  // signal when there are one or more free slots in the FIFO.
  // Used to do an alignment buffer forced overflow.
  always@(*)
  begin
    // if adjustment count is greater than or equal to one, then
    // signal last free slots.
    if (next_free_slots >= {{TX_FIFO_CNT_WIDTH{1'b0}},1'b1})
      fifo_free_slots_one = 1'b1;

    // else block any requests for more DMA activity.
    else
      fifo_free_slots_one = 1'b0;
  end

endmodule

