//------------------------------------------------------------------------------
// Copyright (c) 2002-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_filter.v
//   Module Name:        gem_filter
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
//   Description :       Contains the address and type matching logic.
//                       This block is clocked by rx_clk.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

// The gem_filter module
module gem_filter (

   //System Inputs
   n_rxreset,
   rx_clk,

   // signals coming from the tx block
   tx_en,

   // signals coming from the top level (via loop back module)
   ext_match1_from_loop,
   ext_match2_from_loop,
   ext_match3_from_loop,
   ext_match4_from_loop,

   // signals coming from the rx block
   frame_being_decoded,
   ext_da,
   ext_da_stb,
   ext_sa,
   ext_sa_stb,
   ext_type,
   ext_type_stb,
   code_error,
   rx_no_pause_frames,
   rm_non_vlan,
   vlan_tagged,

   // signals coming from the register block
   ext_match_en,
   uni_hash_en,
   multi_hash_en,
   no_broadcast,
   copy_all_frames,
   hash,
   mask_add1,
   spec_add_filter_regs,
   spec_add_filter_active,
   spec_type1,
   spec_type2,
   spec_type3,
   spec_type4,
   spec_type1_active,
   spec_type2_active,
   spec_type3_active,
   spec_type4_active,
   full_duplex,
   loopback_local,
   en_half_duplex_rx,

   // signals going to gem_rx
   pause_add_match,
   rx_store_frame,

   // signals going to the dma block
   fil_broadcast_frame,
   fil_multicast_frame,
   fil_mult_hash_match,
   fil_uni_hash_match,
   fil_ext_match1,
   fil_ext_match2,
   fil_ext_match3,
   fil_ext_match4,
   fil_add_match,
   fil_type_match1,
   fil_type_match2,
   fil_type_match3,
   fil_type_match4
   );

  parameter p_num_spec_add_filters    = 32'd0;

   // system signals
   input         n_rxreset;               // receive reset.
   input         rx_clk;                  // receive clock.

   input         tx_en;                   // transmit data enable from tx.
   // signals coming from the top level (via loop back module)
   input         ext_match1_from_loop;    // external match (frame to be copied)
   input         ext_match2_from_loop;    // external match (frame to be copied)
   input         ext_match3_from_loop;    // external match (frame to be copied)
   input         ext_match4_from_loop;    // external match (frame to be copied)

   // signals coming from the rx block
   input         frame_being_decoded;     // valid frame is being decoded
   input  [47:0] ext_da;                  // destination address from rx data
   input         ext_da_stb;              // pulsed when ext_da valid
   input  [47:0] ext_sa;                  // source address from rx data
   input         ext_sa_stb;              // pulsed when ext_da valid
   input  [15:0] ext_type;                // length/TypeID field from rx data
   input         ext_type_stb;            // pulsed when ext_type valid
   input         code_error;              // gem_rx detected code error in frame
   input         rx_no_pause_frames;      // Don't copy any pause frames.
   input         rm_non_vlan;             // Only copy any VLAN tagged frames.
   input         vlan_tagged;             // Identifies a VLAN tagged frame.

   // signals coming from the register block
   input         ext_match_en;            // external match enable
   input         uni_hash_en;             // unicast hash enable
   input         multi_hash_en;           // multicast hash enable signal
   input         no_broadcast;            // disable reception of broadcast frms
   input         copy_all_frames;         // copy all frames signal
   input  [63:0] hash;                    // hash register for destination
                                          // address filtering
   input [55*(p_num_spec_add_filters+1)-1:0] spec_add_filter_regs;   // specific address filters
   input [p_num_spec_add_filters:0] spec_add_filter_active;  // specific address filter active
   input  [47:0] mask_add1;               // specific address 1 mask for
                                          // destination address comparison.
   input  [15:0] spec_type1;              // specific type 1 for type comparison
   input  [15:0] spec_type2;              // specific type 2 for type comparison
   input  [15:0] spec_type3;              // specific type 3 for type comparison
   input  [15:0] spec_type4;              // specific type 4 for type comparison
   input         spec_type1_active;       // spec_type1 can be used for type
                                          // comparison.
   input         spec_type2_active;       // spec_type2 can be used for type
                                          // comparison.
   input         spec_type3_active;       // spec_type3 can be used for type
                                          // comparison.
   input         spec_type4_active;       // spec_type4 can be used for type
                                          // comparison.
   input         full_duplex;             // duplex signal from the network
                                          // config register
   input         loopback_local;          // loop back signal
   input         en_half_duplex_rx;       // enable receiving of frames whilst
                                          // transmiting in half duplex.

   // signals going to gem_rx
   output        pause_add_match;         // dest address indicates pause frame
   output        rx_store_frame;          // rx_clk pulse indicating that
                                          // frame should be stored

   // signals going to the dma block
   output        fil_broadcast_frame;     // broadcast frame indication signal
   output        fil_multicast_frame;     // multicast frame indication signal
   output        fil_mult_hash_match;     // multicast hash matched frame
   output        fil_uni_hash_match;      // unicast hash matched frame
   output        fil_ext_match1;          // filter matched as external 1
   output        fil_ext_match2;          // filter matched as external 2
   output        fil_ext_match3;          // filter matched as external 3
   output        fil_ext_match4;          // filter matched as external 4
   output  [p_num_spec_add_filters:0] fil_add_match; // filter matched as spec add
   output        fil_type_match1;         // filter matched as spec type 1
   output        fil_type_match2;         // filter matched as spec type 2
   output        fil_type_match3;         // filter matched as spec type 3
   output        fil_type_match4;         // filter matched as spec type 4


   // declare wire's and reg's for outputs
   wire          rx_store_frame;          // single cycle pulse indicating the
                                          // frame should be stored to memory
   reg           fil_broadcast_frame;     // broadcast frame signal
   reg           fil_multicast_frame;     // multicast frame signal
   reg           fil_mult_hash_match;     // multicast hash matched frame
   reg           fil_uni_hash_match;      // unicast hash matched frame
   reg           fil_ext_match1;          // filter matched as external 1
   reg           fil_ext_match2;          // filter matched as external 2
   reg           fil_ext_match3;          // filter matched as external 3
   reg           fil_ext_match4;          // filter matched as external 4
   reg           fil_type_match1;         // filter matched as spec type 1
   reg           fil_type_match2;         // filter matched as spec type 2
   reg           fil_type_match3;         // filter matched as spec type 3
   reg           fil_type_match4;         // filter matched as spec type 4

   // Internal signals
   wire          tx_en_sync;              // synching tx_en signal
   reg           store_frame_disable;     // used to prevent store frame from
                                          // being asserted
   wire          pause_block;             // block storing of pause frames
   wire          vlan_block;              // block storing of non-VLAN frames
   reg           rx_vlan_frame_pend;      // store match info whilst waiting
                                          // for VLAN tag to be identified.
   wire          broadcast_dec;           // broadcast decoded
   wire          multicast_dec;           // multicast decoded
   wire          multi_hash_dec;          // multicast hash decoded
   wire          uni_hash_dec;            // unicast hash decoded
   reg           ext_match1_dec;          // external match 1 decoded
   reg           ext_match2_dec;          // external match 2 decoded
   reg           ext_match3_dec;          // external match 3 decoded
   reg           ext_match4_dec;          // external match 4 decoded
   wire          ext_match_dec;           // external match decoded
   reg           ext_match_window;        // external match decoding window
   wire          ext_match_dec_pulse;     // external match decoded pulse

   wire [p_num_spec_add_filters-1:0] local_add_dec_sa_local;     // specific add match decoded
   wire [p_num_spec_add_filters-1:0] local_add_dec_da_local;     // specific add match decoded
   wire          local_add_dec_da ;       // specific add match decoded
   wire          local_add_dec_sa ;       // specific add match decoded
   wire          local_type1_dec;         // specific type 1 match decoded
   wire          local_type2_dec;         // specific type 2 match decoded
   wire          local_type3_dec;         // specific type 3 match decoded
   wire          local_type4_dec;         // specific type 4 match decoded
   wire          local_type_dec;          // specific type match decoded
   wire    [5:0] hash_index;              // a reduction of the destination
                                          // address (ext_da) to 6 bits

   parameter     PAUSE_SPEC_ADD = 48'h010000c28001;



   // synchronise tx_en from the tx block
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_en (
      .clk(rx_clk),
      .reset_n(n_rxreset),
      .din(tx_en),
      .dout(tx_en_sync));


   // reduce ext_da to 6 bits (ie hash it down) by XOR'ing every sixth bit
   // together
   assign hash_index[0] = ext_da[0]  ^ ext_da[6]  ^ ext_da[12] ^ ext_da[18] ^
                          ext_da[24] ^ ext_da[30] ^ ext_da[36] ^ ext_da[42];
   assign hash_index[1] = ext_da[1]  ^ ext_da[7]  ^ ext_da[13] ^ ext_da[19] ^
                          ext_da[25] ^ ext_da[31] ^ ext_da[37] ^ ext_da[43];
   assign hash_index[2] = ext_da[2]  ^ ext_da[8]  ^ ext_da[14] ^ ext_da[20] ^
                          ext_da[26] ^ ext_da[32] ^ ext_da[38] ^ ext_da[44];
   assign hash_index[3] = ext_da[3]  ^ ext_da[9]  ^ ext_da[15] ^ ext_da[21] ^
                          ext_da[27] ^ ext_da[33] ^ ext_da[39] ^ ext_da[45];
   assign hash_index[4] = ext_da[4]  ^ ext_da[10] ^ ext_da[16] ^ ext_da[22] ^
                          ext_da[28] ^ ext_da[34] ^ ext_da[40] ^ ext_da[46];
   assign hash_index[5] = ext_da[5]  ^ ext_da[11] ^ ext_da[17] ^ ext_da[23] ^
                          ext_da[29] ^ ext_da[35] ^ ext_da[41] ^ ext_da[47];


   // The first bit transmitted indicates whether the destination address
   // is unicast or multicast. '1' indicates multicast. All '1's is broadcast,
   // a special case of multicast. The first bit is also the LSB of the
   // first byte so this corresponds to ext_da[0].

   // check for unicast hash match
   assign uni_hash_dec   = ~ext_da[0] & hash[hash_index] & uni_hash_en;

   // check for multicast hash match
   assign multi_hash_dec =  ext_da[0] & hash[hash_index] & multi_hash_en;

   // check for broadcast frame
   assign broadcast_dec  = (& ext_da) & ~no_broadcast;

   // check for multicast frame (excludes broadcasts)
   assign multicast_dec  = ext_da[0] & ~broadcast_dec;


   // compare ext_da to the values in the specific address registers
  genvar spec_add_filters_var;
  generate if (p_num_spec_add_filters > 32'd0) begin : gen_add_filters
    wire  local_add1_dec;          // specific add match decoded
    for (spec_add_filters_var=0; spec_add_filters_var<p_num_spec_add_filters[31:0]; spec_add_filters_var = spec_add_filters_var+1)
    begin : spec_add_filters_gen

      wire [47:0] local_spec_add_filter;
      wire  local_spec_add_filter_active;
      wire  local_spec_add_filter_type;
      assign local_spec_add_filter_active = spec_add_filter_active[spec_add_filters_var];
      assign local_spec_add_filter_type = spec_add_filter_regs[((55*spec_add_filters_var)+48)];
      assign local_spec_add_filter = spec_add_filter_regs[((55*spec_add_filters_var)+47):(55*spec_add_filters_var)];

      if (spec_add_filters_var == 0)
      begin : gen_filt_0
        assign local_add_dec_da_local[spec_add_filters_var] = local_spec_add_filter_active &
                                                              ~local_spec_add_filter_type &
                                                              ((local_spec_add_filter | mask_add1) == (ext_da | mask_add1));
        assign local_add_dec_sa_local[spec_add_filters_var] = local_spec_add_filter_active &
                                                              local_spec_add_filter_type &
                                                              ((local_spec_add_filter | mask_add1) == (ext_sa | mask_add1));
        assign local_add1_dec = spec_add_filter_active[spec_add_filters_var] & ((spec_add_filter_regs[55*spec_add_filters_var+47:0] | mask_add1) == (ext_da | mask_add1));
      end
      else
      begin : gen_filt_others
        wire [47:0] byte_mask_expanded;
        assign byte_mask_expanded = { {8{spec_add_filter_regs[55*spec_add_filters_var+54]}},
                                      {8{spec_add_filter_regs[55*spec_add_filters_var+53]}},
                                      {8{spec_add_filter_regs[55*spec_add_filters_var+52]}},
                                      {8{spec_add_filter_regs[55*spec_add_filters_var+51]}},
                                      {8{spec_add_filter_regs[55*spec_add_filters_var+50]}},
                                      {8{spec_add_filter_regs[55*spec_add_filters_var+49]}}};
        assign local_add_dec_da_local[spec_add_filters_var] = local_spec_add_filter_active &
                                                              ~local_spec_add_filter_type &
                                                            ((local_spec_add_filter | byte_mask_expanded) == (ext_da | byte_mask_expanded));
        assign local_add_dec_sa_local[spec_add_filters_var] = local_spec_add_filter_active &
                                                              local_spec_add_filter_type &
                                                            ((local_spec_add_filter | byte_mask_expanded) == (ext_sa | byte_mask_expanded));
      end
    end
   assign local_add_dec_da  = |local_add_dec_da_local |
                               copy_all_frames | broadcast_dec |
                               uni_hash_dec | multi_hash_dec;

   assign local_add_dec_sa  = |local_add_dec_sa_local;

   // check for pause frame
   assign pause_add_match = (local_add1_dec | (ext_da == PAUSE_SPEC_ADD)) &
                            ~store_frame_disable;

  end else begin : gen_no_add_filters
   assign local_add_dec_da        = copy_all_frames | broadcast_dec |
                                    uni_hash_dec | multi_hash_dec;
   assign local_add_dec_sa        = 1'b0;
   assign local_add_dec_sa_local  = {p_num_spec_add_filters{1'b0}};
   assign local_add_dec_da_local  = {p_num_spec_add_filters{1'b0}};
   // check for pause frame
   assign pause_add_match = (ext_da == PAUSE_SPEC_ADD) & ~store_frame_disable;
  end
  endgenerate

   // compare ext_type to the values in the specific address registers
   assign local_type1_dec = spec_type1_active & (spec_type1 == ext_type);
   assign local_type2_dec = spec_type2_active & (spec_type2 == ext_type);
   assign local_type3_dec = spec_type3_active & (spec_type3 == ext_type);
   assign local_type4_dec = spec_type4_active & (spec_type4 == ext_type);
   assign local_type_dec  = local_type1_dec | local_type2_dec |
                            local_type3_dec | local_type4_dec;


   // Block pause frames if rx_no_pause_frames is set and the destination
   // address matches the pause frame multicast address. This will let
   // through pause frames addressed to specific address register 1 but
   // waiting to check whether frames addressed to specific address 1
   // are pause frames would add significant latency to the address
   // recognition process.
   assign pause_block     = rx_no_pause_frames & (ext_da == PAUSE_SPEC_ADD);

   // Block non-VLAN tagged frames if rm_non_vlan is set.
   assign vlan_block      = rm_non_vlan & ~vlan_tagged;

   // Store match pulses if waiting for a VLAN match & rm_non_vlan is active
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
         rx_vlan_frame_pend <= 1'b0;
      else if (rx_store_frame | ~frame_being_decoded | store_frame_disable)
         rx_vlan_frame_pend <= 1'b0;
      else if (vlan_block & ((ext_da_stb & local_add_dec_da) |
                             (ext_sa_stb & local_add_dec_sa) |
                             (ext_type_stb & local_type_dec) |
                             ext_match_dec_pulse))
         rx_vlan_frame_pend <= 1'b1;
      else
         rx_vlan_frame_pend <= rx_vlan_frame_pend;
   end



   // check for external match. Register at input to improve I/O timing
   // This register stage can be removed if external decoding logic
   // timing is tight.
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
         begin
            ext_match1_dec <= 1'b0;
            ext_match2_dec <= 1'b0;
            ext_match3_dec <= 1'b0;
            ext_match4_dec <= 1'b0;
         end
      else
         begin
            ext_match1_dec <= ext_match_en & ext_match1_from_loop;
            ext_match2_dec <= ext_match_en & ext_match2_from_loop;
            ext_match3_dec <= ext_match_en & ext_match3_from_loop;
            ext_match4_dec <= ext_match_en & ext_match4_from_loop;
         end
   end

   // Combine decodes for signalling match
   assign ext_match_dec  = ext_match1_dec | ext_match2_dec |
                           ext_match3_dec | ext_match4_dec;

   // Only allow decode of external match after a new ext_da_stb has been
   // seen.
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
         ext_match_window <= 1'b0;
      else if (rx_store_frame | ext_match_dec | ~frame_being_decoded)
         ext_match_window <= 1'b0;
      else if (ext_da_stb)
         ext_match_window <= 1'b1;
      else
         ext_match_window <= ext_match_window;
   end

   // Qualify external match with window, thus creating a pulse
   assign ext_match_dec_pulse = ext_match_dec & (ext_match_window | ext_da_stb);


   // disable store frame when transmitting in half duplex mode or when rx_er
   // has been detected
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
         store_frame_disable <= 1'b0;
      else if ((tx_en_sync & ~full_duplex & ~loopback_local &
                                            ~en_half_duplex_rx) | code_error)
         store_frame_disable <= 1'b1;
      else if (~frame_being_decoded)
         store_frame_disable <= 1'b0;
      else
         store_frame_disable <= store_frame_disable;
   end


   // determine whether to store frame
   // store when ext_da_stb and destination address is matched
   // or when ext_type_stb and length/typeID is matched
   // or when external match signalled.
   // Don't store if store_frame_disable or pause_block or vlan_block are high.
   assign rx_store_frame = ~store_frame_disable & ~pause_block & ~vlan_block &
                              ((ext_da_stb & local_add_dec_da) |
                               (ext_sa_stb & local_add_dec_sa) |
                               (ext_type_stb & local_type_dec) |
                               ext_match_dec_pulse |
                               rx_vlan_frame_pend);


   // Register match condition.
   // Sample match status when rx_store_frame is active
   generate if (p_num_spec_add_filters > 32'd0) begin : gen_spec_add_filter
    reg  [p_num_spec_add_filters-1:0] fil_add_match_r; // specific address register match
    always@(posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
            fil_add_match_r       <= {p_num_spec_add_filters{1'b0}}; // specific address register match
      else if (rx_store_frame)
            fil_add_match_r       <= local_add_dec_da_local | local_add_dec_sa_local;
    end
    assign fil_add_match = {fil_add_match_r,1'b0};
   end else begin : gen_no_spec_add
    assign fil_add_match = 1'b0;
   end
   endgenerate


   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
         begin
            fil_broadcast_frame <= 1'b0;
            fil_multicast_frame <= 1'b0;
            fil_mult_hash_match <= 1'b0;
            fil_uni_hash_match  <= 1'b0;
            fil_ext_match1      <= 1'b0;
            fil_ext_match2      <= 1'b0;
            fil_ext_match3      <= 1'b0;
            fil_ext_match4      <= 1'b0;
            fil_type_match1     <= 1'b0;
            fil_type_match2     <= 1'b0;
            fil_type_match3     <= 1'b0;
            fil_type_match4     <= 1'b0;
         end
      else if (rx_store_frame)
         begin
            fil_broadcast_frame <= broadcast_dec;
            fil_multicast_frame <= multicast_dec;
            fil_mult_hash_match <= multi_hash_dec;
            fil_uni_hash_match  <= uni_hash_dec;
            fil_ext_match1      <= ext_match1_dec;
            fil_ext_match2      <= ext_match2_dec;
            fil_ext_match3      <= ext_match3_dec;
            fil_ext_match4      <= ext_match4_dec;
            fil_type_match1     <= local_type1_dec;
            fil_type_match2     <= local_type2_dec;
            fil_type_match3     <= local_type3_dec;
            fil_type_match4     <= local_type4_dec;
         end
      else
         begin
            fil_broadcast_frame <= fil_broadcast_frame;
            fil_multicast_frame <= fil_multicast_frame;
            fil_mult_hash_match <= fil_mult_hash_match;
            fil_uni_hash_match  <= fil_uni_hash_match;
            fil_ext_match1      <= fil_ext_match1;
            fil_ext_match2      <= fil_ext_match2;
            fil_ext_match3      <= fil_ext_match3;
            fil_ext_match4      <= fil_ext_match4;
            fil_type_match1     <= fil_type_match1;
            fil_type_match2     <= fil_type_match2;
            fil_type_match3     <= fil_type_match3;
            fil_type_match4     <= fil_type_match4;
         end
   end


endmodule
