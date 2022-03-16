//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-01-24 15:19:05 +0000 (Tue, 24 Jan 2012) $
//   Revision   : $Revision: 199306 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ DEBUG BREAKPOINT UNIT
//-----------------------------------------------------------------------------

module cm0p_dbg_bpu
  #(parameter CBAW = 0,
    parameter BKPT = 4,
    parameter RAR  = 0)

   (input  wire        dclk,               // Debug clock
    input  wire        dbg_reset_n,        // Debug reset

    output wire [31:0] bpu_hrdata_o,       // Breakpoint register read-data
    output wire [ 1:0] bpu_match_o,        // Breakpoint half-word match

    input  wire        hready_i,           // AHB ready / core advance

    input  wire [29:0] cpu_haddr_31to2_i,  // Fetch address to match against
    input  wire        dbg_c_debugen_i,    // Debug is enabled
    input  wire [ 4:0] dsl_bpu_sels_i,     // Breakpoint register selects
    input  wire        dsl_ppb_write_i,    // Register select is for write
    input  wire [31:0] slv_wdata_i);       // Register write-data


   // -------------------------------------------------------------------------
   // Global wire declarations
   // -------------------------------------------------------------------------

   // Reset signal for RAR reset register, and zero for tie-offs:

   wire        rar_reset_n;
   wire        zero = 1'b0;

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   // Generate breakpoint present masking and RAR config wires:

   localparam [3:0] L_BKPT_PRES = ( (CBAW != 0) ? 4'b1111 :
                                    { (BKPT > 3), (BKPT > 2),
                                      (BKPT > 1), 1'b1 } );

   wire [ 3:0] cfg_bkpt;
   wire        cfg_rar;

   // --------
   // Generate driving logic for masking terms and RAR reset:

   generate
      if(CBAW != 0) begin: gen_cfg_cbaw1

         assign rar_reset_n = cfg_rar ? dbg_reset_n : 1'b1;
         wire [4:0] unused_cbaw1 = { L_BKPT_PRES, zero };

      end else begin: gen_cfg_cbaw0

         assign cfg_bkpt    = L_BKPT_PRES;
         assign cfg_rar     = (RAR != 0);
         assign rar_reset_n = 1'b0;

         wire [1:0] unused_cbaw0 = { cfg_rar, rar_reset_n };

         if(BKPT > 3) begin: gen_cfg_cbaw0_bkptmax
            wire unused = zero;
         end
      end
   endgenerate

   // --------
   // Mask out unused bits of write-data, passed in to preserve bus:

   wire        unused = slv_wdata_i[29];

   // -------------------------------------------------------------------------
   // Mask inputs based on configuration
   // -------------------------------------------------------------------------

   wire [ 4:0] bpu_sels = { cfg_bkpt[0] & dsl_bpu_sels_i[4],
                            cfg_bkpt[3] & dsl_bpu_sels_i[3],
                            cfg_bkpt[2] & dsl_bpu_sels_i[2],
                            cfg_bkpt[1] & dsl_bpu_sels_i[1],
                            cfg_bkpt[0] & dsl_bpu_sels_i[0] };

   // -------------------------------------------------------------------------
   // Local execute control register state
   // -------------------------------------------------------------------------

   reg  [ 3:0] bpu_comp_en_q;    // comparator enable
   reg  [28:0] bpu_comp_q [3:0]; // comparator bp_match and comp

   reg         bpu_en_q;         // master enable
   reg  [ 1:0] bpu_match_q;      // match flags

   // -------------------------------------------------------------------------
   // Comparators and hit register logic
   // -------------------------------------------------------------------------

   // Breakpoint comparator function:
   //   [1] = match on upper-half-word
   //   [0] = match on lower-half-word

   function [1:0] comp_match
     (input        en,
      input [28:0] comp_r,
      input [31:0] addr);

      begin
         // Enabled and addr match and bp_comp.

         comp_match = {2{en & (addr[28:2] == comp_r[26:0])}} & comp_r[28:27];
      end
   endfunction

   // --------
   // Construct full address.

   wire [31:0] cpu_haddr = { cpu_haddr_31to2_i, 2'b00 };

   // --------
   // Only match on instruction fetches from Code memory region

   wire        fetch_code = ~|cpu_haddr[31:29];
   wire        match_en   = dbg_c_debugen_i & bpu_en_q & fetch_code;

   wire [ 1:0] match [3:0];
   genvar      g_bkpt;

   generate
      for(g_bkpt=0; g_bkpt<4; g_bkpt = g_bkpt + 1) begin: gen_match
         if((CBAW != 0) || L_BKPT_PRES[g_bkpt]) begin: gen_match_pres

            assign match[g_bkpt] = ( {2{cfg_bkpt[g_bkpt]}} &
                                     comp_match(bpu_comp_en_q[g_bkpt],
                                                bpu_comp_q   [g_bkpt],
                                                cpu_haddr) );

         end else begin: gen_match_abs

            assign match[g_bkpt] = 2'b0;

         end
      end
   endgenerate

   // --------
   // Combine match signals from all implemented comparators:

   wire [ 1:0] match_n = match[0] | match[1] | match[2] | match[3];

   wire [ 1:0] nxt_bpu_match = {2{match_en}} & match_n;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       bpu_match_q <= 2'b00;
     else if (hready_i)
       bpu_match_q <= nxt_bpu_match;

   // -------------------------------------------------------------------------
   // Peripheral bus write interface logic
   // -------------------------------------------------------------------------

   wire        bpu_ctrl_key    = slv_wdata_i[1];
   wire        ppb_bpu_ctrl_wr = bpu_sels[4] & dsl_ppb_write_i & bpu_ctrl_key;

   wire [ 3:0] ppb_bpu_comp_wr = bpu_sels[3:0] & {4{dsl_ppb_write_i}};

   wire [28:0] bpu_comp_nxt = { slv_wdata_i[31:30], slv_wdata_i[28:2] };

   // -------------------------------------------------------------------------
   // Synchronous update logic
   // -------------------------------------------------------------------------

   // Breakpoint unit control

   always @(posedge dclk or negedge dbg_reset_n)
      if(~dbg_reset_n)
         bpu_en_q <= 1'b0;
      else if (ppb_bpu_ctrl_wr)
         bpu_en_q <= slv_wdata_i[0];

   // --------
   // Comparator registers

   generate
      for(g_bkpt=0; g_bkpt<4; g_bkpt=g_bkpt+1) begin: gen_comp_q
         if(CBAW != 0) begin: gen_comp_q_cbaw

            // --------
            // CBAW mode registers.

            always @(posedge dclk or negedge dbg_reset_n)
              if (~dbg_reset_n)
                bpu_comp_en_q[g_bkpt] <= 1'b0;
              else if (ppb_bpu_comp_wr[g_bkpt])
                bpu_comp_en_q[g_bkpt] <= slv_wdata_i[0];

            always @(posedge dclk or negedge rar_reset_n)
              if (~rar_reset_n) begin
                 bpu_comp_q[g_bkpt] <= {29{1'b1}};
              end else if (ppb_bpu_comp_wr[g_bkpt]) begin
                 bpu_comp_q[g_bkpt] <= bpu_comp_nxt;
              end

         end else if (L_BKPT_PRES[g_bkpt]) begin: gen_comp_q_pres

            if(RAR != 0) begin: gen_comp_q_pres_rar1

               // --------
               // All registers reset in RAR configurations.

               always @(posedge dclk or negedge dbg_reset_n)
                 if (~dbg_reset_n) begin
                    bpu_comp_en_q[g_bkpt] <= 1'b0;
                    bpu_comp_q[g_bkpt] <= {29{1'b1}};
                 end else if (ppb_bpu_comp_wr[g_bkpt]) begin
                    bpu_comp_en_q[g_bkpt] <= slv_wdata_i[0];
                    bpu_comp_q[g_bkpt] <= bpu_comp_nxt;
                 end

            end else begin: gen_comp_q_pres_rar0

               // --------
               // Only enable registers reset in non RAR configurations.

               always @(posedge dclk or negedge dbg_reset_n)
                 if (~dbg_reset_n)
                   bpu_comp_en_q[g_bkpt] <= 1'b0;
                 else if (ppb_bpu_comp_wr[g_bkpt])
                   bpu_comp_en_q[g_bkpt] <= slv_wdata_i[0];

               always @(posedge dclk)
                 if (ppb_bpu_comp_wr[g_bkpt])
                   bpu_comp_q[g_bkpt] <= bpu_comp_nxt;

            end
         end else begin: gen_comp_q_abs

            // --------
            // Tie off unused comparators.

            always @* bpu_comp_en_q[g_bkpt] =     zero  ;
            always @* bpu_comp_q   [g_bkpt] = {29{zero}};

         end
      end
   endgenerate

   // -------------------------------------------------------------------------
   // PPB read interface logic
   // -------------------------------------------------------------------------

   // Breakpoint unit control register, containing number of breakpoints.

   wire [ 3:0] num_code  = ( cfg_bkpt[3] ? 4'h4 :
                             cfg_bkpt[2] ? 4'h3 :
                             cfg_bkpt[1] ? 4'h2 :
                             4'h1 );

   wire [31:0] bpu_ctrl  = { {24{1'b0}}, // 31: 8 Reserved
                             num_code,   //  7: 4 NUM_CODE
                             {2{1'b0}},  //  3: 2 Reserved
                             1'b0,       //     1 KEY (RAZ)
                             bpu_en_q }; //     0 ENABLE

   // --------
   // Individual comparator register reads.

   wire [31:0] bpu_comp [3:0];

   generate
      for (g_bkpt=0; g_bkpt<4; g_bkpt=g_bkpt+1) begin: gen_bpu_comp

         assign bpu_comp[g_bkpt] =
                  { bpu_comp_q[g_bkpt][28:27], // 31:30 BP_MATCH
                    1'b0,                      //    29 Reserved
                    bpu_comp_q[g_bkpt][26:0],  // 28: 2 COMP
                    1'b0,                      //     1 Reserved
                    bpu_comp_en_q[g_bkpt] };   //     0 ENABLE

      end
   endgenerate

   // --------
   // PPB read data mux for BPU.

   wire [31:0] hrdata = {32{bpu_sels[4]}} & bpu_ctrl    |
                        {32{bpu_sels[3]}} & bpu_comp[3] |
                        {32{bpu_sels[2]}} & bpu_comp[2] |
                        {32{bpu_sels[1]}} & bpu_comp[1] |
                        {32{bpu_sels[0]}} & bpu_comp[0];

   // -------------------------------------------------------------------------
   // Assign outputs
   // -------------------------------------------------------------------------

   assign bpu_match_o  = bpu_match_q;
   assign bpu_hrdata_o = hrdata;

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

 `include "std_ovl_defines.h"

   // --------
   // Register enable X check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(6),
       .property_type(`OVL_ASSERT),
       .msg("Register enables must never be X"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_reg_en_x
     (.clock     (dclk),
      .reset     (dbg_reset_n),
      .enable    (1'b1),
      .qualifier (1'b1),
      .test_expr ({ hready_i,
                    ppb_bpu_comp_wr[0],
                    ppb_bpu_comp_wr[1],
                    ppb_bpu_comp_wr[2],
                    ppb_bpu_comp_wr[3],
                    ppb_bpu_ctrl_wr }),
      .fire      ());

   // --------
   // Only one register select can be active.

   ovl_zero_one_hot
     #(.severity_level(`OVL_FATAL),
       .width(5),
       .property_type(`OVL_ASSERT),
       .msg("Only one BPU register select may be active"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_bpu_sels
     (.clock(dclk),
      .reset(dbg_reset_n),
      .enable(1'b1),
      .test_expr(dsl_bpu_sels_i),
      .fire());

`endif

   //--------------------------------------------------------------------------

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
