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
//   Checked In : $Date: 2012-01-12 19:27:00 +0000 (Thu, 12 Jan 2012) $
//   Revision   : $Revision: 197858 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ DEBUG WATCHPOINT UNIT
//-----------------------------------------------------------------------------

module cm0p_dbg_dwt
  #(parameter CBAW = 0,
    parameter RAR  = 0,
    parameter WPT  = 2)

   (input  wire        dclk,             // Debug clock
    input  wire        dbg_reset_n,      // Debug active-low reset

    output wire        dwt_event_o,      // Watchpoint hit output
    output wire [31:0] dwt_hrdata_o,     // Watchpoint register read-data

    input  wire        hready_i,         // AHB ready / core advance

    input  wire        cpu_dwt_trans_i,  // Valid core data transaction
    input  wire [31:0] cpu_addr_a_i,     // Core data address
    input  wire        cpu_dwt_ia_ok_i,  // IAEX valid for PC match
    input  wire        halted_i,         // Processor is halted
    input  wire        cpu_write_a_i,    // Core write not read
    input  wire [ 1:0] cpu_ls_size_i,    // Core data-transaction size
    input  wire        dbg_dwt_en_i,     // Watchpoint unit is enabled
    input  wire [ 7:0] dsl_dwt_sels_i,   // Watchpoint register selects
    input  wire        dsl_ppb_write_i,  // Register selects are for write
    input  wire [30:0] cpu_dwt_iaex_i,   // Instruction address for PCSR
    input  wire        cpu_pipefull_i,   // Core pipeline is populated
    input  wire [31:0] slv_wdata_i);     // Register write-data

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   localparam [1:0] L_WPT_PRES = (CBAW != 0) ? 2'b11 : { (WPT > 1), 1'b1 };

   wire        cfg_rar;
   wire [ 1:0] cfg_wpt;

   generate
      if(CBAW == 0) begin: gen_cbaw
         assign cfg_wpt = L_WPT_PRES;
         assign cfg_rar = (RAR != 0);
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Watchpoint hit function
   // -------------------------------------------------------------------------

   function wp_comp
     (input        i_en,
      input        i_read,
      input        i_write,
      input        i_execute,
      input [31:0] i_addr,
      input [ 1:0] i_size,
      input [31:0] i_pc,
      input [31:0] i_comp,
      input [ 4:0] i_mask,
      input [ 2:0] i_func);

      reg          i_off;
      reg   [ 4:0] i_mask_5;
      reg   [31:0] i_mask_32;
      reg          i_pcmode;
      reg          i_cmp_1;
      reg          i_cmp_0;
      reg   [ 1:0] i_cmp_lsb;
      reg   [31:0] i_test;
      reg   [31:0] i_value;
      reg          i_match;
      reg          i_rvalid;
      reg          i_wvalid;
      reg          i_ivalid;
      reg          i_valid;
      reg          i_event;
      reg          i_hit;

      begin
         i_off     = ~i_func[2] | ~i_en;               // In-active state
         i_mask_5  = {5{i_off}} | i_mask;              // Mask for power
         i_mask_32 = {32{1'b1}} << i_mask_5;           // Create 32-bit mask
         i_pcmode  = ~|i_func[1:0];                    // PC watchpoint mode
         i_cmp_1   = i_pcmode | ~i_size[1];            // Compare bit[1]
         i_cmp_0   = ~|i_size[1:0];                    // Compare bit[0]
         i_cmp_lsb = i_comp[1:0] & {i_cmp_1, i_cmp_0}; // Align comp[1:0]
         i_test    = {i_comp[31:2], i_cmp_lsb[1:0]};   // Final compare value
         i_value   = i_pcmode ? i_pc : i_addr;         // Select input
         i_match   = (i_value & i_mask_32) == i_test;  // Perform compare
         i_rvalid  = i_func[0] & i_read;               // Read event
         i_wvalid  = i_func[1] & i_write;              // Write event
         i_ivalid  = i_pcmode & i_execute;             // PC event
         i_valid   = i_rvalid | i_wvalid | i_ivalid;   // Merge events
         i_event   = i_valid & i_match;                // Add comparator
         i_hit     = i_event & ~i_off;                 // Final enable
         wp_comp   = i_hit;
      end
   endfunction

   // -------------------------------------------------------------------------
   // Derive whether any of the watchpoint comparators hits
   // -------------------------------------------------------------------------

   // Common watchpoint hit function inputs:

   wire [31:0] cpu_pc      = { cpu_dwt_iaex_i, 1'b0 };
   wire        cpu_dtrans  = cpu_dwt_trans_i;
   wire        cpu_rtrans  = cpu_dtrans & ~cpu_write_a_i;
   wire        cpu_wtrans  = cpu_dtrans &  cpu_write_a_i;
   wire        cpu_execute = cpu_pipefull_i;
   wire        comp_en     = dbg_dwt_en_i;

   // --------
   // Create per-watchpoint sels:

   wire [ 2:0] sels [1:0];

   assign sels[0] = {3{cfg_wpt[0]}} & dsl_dwt_sels_i[5:3];
   assign sels[1] = {3{cfg_wpt[1]}} & dsl_dwt_sels_i[2:0];

   // --------
   // Extract match and read-data from each comparator:

   wire [ 1:0] match;
   wire [31:0] hrdata_wpt [1:0];
   genvar      g_wpt;

   generate
      for(g_wpt = 0; g_wpt < 2; g_wpt = g_wpt + 1) begin: gen_for_wpt
         if (L_WPT_PRES[g_wpt]) begin: gen_wpt_pres

            // Register enables.

            wire dwt_comp_wr = sels[g_wpt][2] &  dsl_ppb_write_i;
            wire dwt_mask_wr = sels[g_wpt][1] &  dsl_ppb_write_i;
            wire dwt_func_wr = sels[g_wpt][0] &  dsl_ppb_write_i;
            wire dwt_func_rd = sels[g_wpt][0] & ~dsl_ppb_write_i;

            // --------
            // Match bit architected as clear-on-read

            wire dwt_mat_en  = dwt_func_rd | (match[g_wpt] & hready_i);

            // --------
            // State registers and register update logic.

            reg [31:0] dwt_comp_q; // DWT COMP
            reg [ 4:0] dwt_mask_q; // DWT MASK

            if(CBAW != 0) begin: gen_for_wpt_cbaw1

               // --------
               // CBAW mode.

               wire rar_reset_n = cfg_rar ? dbg_reset_n : 1'b1;

               always @(posedge dclk or negedge rar_reset_n)
                 if (~rar_reset_n)
                   dwt_comp_q <= {32{1'b1}};
                 else if (dwt_comp_wr)
                   dwt_comp_q <= slv_wdata_i[31:0];

               always @(posedge dclk or negedge rar_reset_n)
                 if (~rar_reset_n)
                   dwt_mask_q <= {5{1'b1}};
                 else if (dwt_mask_wr)
                   dwt_mask_q <= slv_wdata_i[4:0];

            end else if (RAR != 0) begin: gen_for_wpt_rar1

               // --------
               // Reset all registers.

               wire unused = cfg_rar;

               always @(posedge dclk or negedge dbg_reset_n)
                 if (~dbg_reset_n)
                   dwt_comp_q <= {32{1'b1}};
                 else if (dwt_comp_wr)
                   dwt_comp_q <= slv_wdata_i[31:0];

               always @(posedge dclk or negedge dbg_reset_n)
                 if (~dbg_reset_n)
                   dwt_mask_q <= {5{1'b1}};
                 else if (dwt_mask_wr)
                   dwt_mask_q <= slv_wdata_i[4:0];

            end else begin: gen_for_wpt_cbaw0_rar0

               // --------
               // Standard register implementation.

               wire unused = cfg_rar;

               always @(posedge dclk)
                 if (dwt_comp_wr)
                   dwt_comp_q <= slv_wdata_i[31:0];

               always @(posedge dclk)
                 if (dwt_mask_wr)
                   dwt_mask_q <= slv_wdata_i[4:0];

            end

            // --------
            // Always reset function register.

            reg  [ 2:0] dwt_func_q; // DWT FUNCTION [2:0]

            always @(posedge dclk or negedge dbg_reset_n)
              if (~dbg_reset_n)
                dwt_func_q <= {3{1'b0}};
              else if (dwt_func_wr)
                dwt_func_q <= slv_wdata_i[2:0];

            // --------
            // Match register.

            reg         dwt_mat_q;  // DWT MATCH

            // --------
            // Comparator and hit logic.

            assign match[g_wpt] = cfg_wpt[g_wpt] & wp_comp(comp_en,
                                                           cpu_rtrans,
                                                           cpu_wtrans,
                                                           cpu_execute,
                                                           cpu_addr_a_i[31:0],
                                                           cpu_ls_size_i[1:0],
                                                           cpu_pc[31:0],
                                                           dwt_comp_q[31:0],
                                                           dwt_mask_q[4:0],
                                                           dwt_func_q[2:0]);

            always @(posedge dclk or negedge dbg_reset_n)
              if (~dbg_reset_n)
                dwt_mat_q <= 1'b0;
              else if (dwt_mat_en)
                dwt_mat_q <= match[g_wpt];

            // --------
            // Read values.

            wire [31:0] dwt_mask = { {27{1'b0}},   // 31: 5 Reserved
                                     dwt_mask_q }; //  2: 0 MASK

            wire [31:0] dwt_func = { {7{1'b0}},            // 31:25 Reserved
                                     dwt_mat_q,            //    24 MATCHED
                                     {20{1'b0}},           // 23: 4 Reserved
                                     {1'b0, dwt_func_q} }; //  3: 0 FUNCTION

            // --------
            // Per comparator read-data output.

            assign hrdata_wpt[g_wpt] = ( {32{sels[g_wpt][2]}} & dwt_comp_q |
                                         {32{sels[g_wpt][1]}} & dwt_mask   |
                                         {32{sels[g_wpt][0]}} & dwt_func );

         end else begin: gen_wpt_abs

            // --------
            // Not present, so tie off.

            assign match[g_wpt] = 1'b0;
            assign hrdata_wpt[g_wpt] = {32{1'b0}};

         end
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Generate event for debug control logic if any hit
   // -------------------------------------------------------------------------

   wire        dwt_event = |match;

   // -------------------------------------------------------------------------
   // PPB register read values
   // -------------------------------------------------------------------------

   // The PCSR tracks the core program-counter unless we are halted or
   // performing exception handling in which case it reads as 0xFFFFFFFF.

   wire        dwt_pcsr_ok = ( cpu_dwt_ia_ok_i &
                               ~halted_i &
                               (cpu_dwt_iaex_i[30:27] != 4'hF) );

   wire [31:0] dwt_pcsr    = { cpu_dwt_iaex_i, 1'b0 } | {32{~dwt_pcsr_ok}};

   wire [ 3:0] num_comp    = ( cfg_wpt[1] ? 4'h2 :
                               cfg_wpt[0] ? 4'h1 :
                               4'h0 );

   wire [31:0] dwt_ctrl    = { num_comp,      // 31:28 NUMCOMP
                               {28{1'b0}} };  // 27: 0 Reserved

   // -------------------------------------------------------------------------
   // Read data mux
   // -------------------------------------------------------------------------

   wire [31:0] hrdata = ( {32{dsl_dwt_sels_i[7]}} & dwt_ctrl  |
                          {32{dsl_dwt_sels_i[6]}} & dwt_pcsr  |
                          hrdata_wpt[0] |
                          hrdata_wpt[1] );

   // -------------------------------------------------------------------------
   // Output assignments
   // -------------------------------------------------------------------------

   assign     dwt_event_o  = dwt_event;
   assign     dwt_hrdata_o = hrdata;

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

 `include "std_ovl_defines.h"

   // --------
   // Register enable X check.

   generate
      for(g_wpt = 0; g_wpt < 2; g_wpt = g_wpt + 1) begin: gen_for_wpt_ovl
         if(L_WPT_PRES[g_wpt]) begin: gen_wpt_pres_ovl

            ovl_never_unknown
              #(.severity_level(`OVL_FATAL),
                .width(4),
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
               .test_expr ({ gen_for_wpt[g_wpt].gen_wpt_pres.dwt_comp_wr,
                             gen_for_wpt[g_wpt].gen_wpt_pres.dwt_mask_wr,
                             gen_for_wpt[g_wpt].gen_wpt_pres.dwt_func_wr,
                             gen_for_wpt[g_wpt].gen_wpt_pres.dwt_mat_en }),
               .fire());
         end
      end
   endgenerate

   // --------
   // Only one register select can be active.

   ovl_zero_one_hot
     #(.severity_level(`OVL_FATAL),
       .width(8),
       .property_type(`OVL_ASSERT),
       .msg("Only one DWT register select may be active"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_dsl_dwt_sels_i
     (.clock(dclk),
      .reset(dbg_reset_n),
      .enable(1'b1),
      .test_expr(dsl_dwt_sels_i),
      .fire());

   // --------
   // Parameterisable configuration check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(32),
       .property_type(`OVL_ASSERT),
       .msg("CBAW config unknown"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cfg_cbaw
     (.clock(dclk),
      .reset(1'b1),
      .enable(1'b1),
      .qualifier(1'b1),
      .test_expr(CBAW),
      .fire());

   // --------
   // Parameterisable configuration check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(2),
       .property_type(`OVL_ASSERT),
       .msg("WPT config unknown"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cfg_wpt
     ( .clock(dclk),
       .reset(1'b1),
       .enable(1'b1),
       .qualifier(1'b1),
       .test_expr(cfg_wpt),
       .fire());

`endif

   // -------------------------------------------------------------------------

endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
