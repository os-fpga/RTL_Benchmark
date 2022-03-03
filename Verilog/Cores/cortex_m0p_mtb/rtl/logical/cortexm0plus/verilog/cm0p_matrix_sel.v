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
//   Checked In : $Date: 2012-08-28 17:49:26 +0100 (Tue, 28 Aug 2012) $
//   Revision   : $Revision: 220358 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ PPB DECODER
//-----------------------------------------------------------------------------

module cm0p_matrix_sel
  #(parameter CBAW   = 0,
    parameter DBG    = 1,
    parameter SYST   = 1,
    parameter MPU    = 0)

   (input  wire        hclk,                // AHB clock
    input  wire        hreset_n,            // AHB reset

    output wire        msl_pclk_en_o,       // PPB register write clock enable

    output wire [23:0] msl_nvic_sels_o,     // NVIC register selects
    output wire [ 4:0] msl_mpu_sels_o,      // MPU register selects
    output wire        msl_sel_dcrdr_o,     // DCRDR read-data cycle
    output wire        msl_ppb_write_o,     // Write performed to PPB space
    output wire        msl_ppb_active_o,    // PPB not AHB is current slave
    output wire        msl_dbg_aux_en_o,    // Enable AUX for debug write
    output wire        msl_dbg_op_en_o,     // Enable opcode for debug write
    output wire [31:0] msl_cid_rdata_o,     // Component ID read-data

    input  wire        hready_i,            // AHB ready / core advance
    input  wire [ 3:0] eco_rev_num_3to0_i,  // Revision number ECOs

    input  wire [ 1:0] dsl_cid_sels_i,      // Debug ID value selects
    input  wire        dbg_halt_req_i,      // Debug halt request
    input  wire        ahb_size_1_i,        // Transaction is word-sized
    input  wire        ppb_trans_i,         // PPB transaction
    input  wire        dif_aphase_i,        // Debugger generated transaction
    input  wire [31:0] ahb_addr_i,          // Transaction address
    input  wire        ahb_write_i);        // transaction is a write

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   wire        cfg_dbg, cfg_syst, cfg_mpu;

   generate
      if(CBAW == 0) begin : gen_cfg_cbaw

         assign cfg_dbg    = (DBG    != 0);
         assign cfg_syst   = (SYST   != 0);
         assign cfg_mpu    = (MPU    != 0);

      end
   endgenerate

   // --------
   // Certain bits of the address are not used, but are routed here to maintain
   // the bus layout. Connect these bits to "unused".

   wire [ 5:0] unused = { ahb_addr_i[31:28], ahb_addr_i[1:0] };

   // -------------------------------------------------------------------------
   // Mask inputs based on configuration
   // -------------------------------------------------------------------------

   wire [ 1:0] dsl_cid_sels = cfg_dbg ? dsl_cid_sels_i : 2'b0;
   wire        dbg_halt_req = cfg_dbg ? dbg_halt_req_i : 1'b0;

   // -------------------------------------------------------------------------
   // PPB write, System Control Space (SCS) selector, and CPU guard registers
   // -------------------------------------------------------------------------

   reg  [ 5:0] scs_sel_q;    // Encoded PPB space register select
   reg         ppb_write_q;  // Access to PPB is a write

   // -------------------------------------------------------------------------
   // Create constants for PPB address decoding
   // -------------------------------------------------------------------------

   localparam [31:0] const_a_actlr      = 32'hE000E008;
   localparam [31:0] const_a_syst_csr   = 32'hE000E010;
   localparam [31:0] const_a_syst_rvr   = 32'hE000E014;
   localparam [31:0] const_a_syst_cvr   = 32'hE000E018;
   localparam [31:0] const_a_syst_calib = 32'hE000E01C;
   localparam [31:0] const_a_nvic_iser  = 32'hE000E100;
   localparam [31:0] const_a_nvic_icer  = 32'hE000E180;
   localparam [31:0] const_a_nvic_ispr  = 32'hE000E200;
   localparam [31:0] const_a_nvic_icpr  = 32'hE000E280;
   localparam [31:0] const_a_nvic_ipr0  = 32'hE000E400;
   localparam [31:0] const_a_nvic_ipr1  = 32'hE000E404;
   localparam [31:0] const_a_nvic_ipr2  = 32'hE000E408;
   localparam [31:0] const_a_nvic_ipr3  = 32'hE000E40C;
   localparam [31:0] const_a_nvic_ipr4  = 32'hE000E410;
   localparam [31:0] const_a_nvic_ipr5  = 32'hE000E414;
   localparam [31:0] const_a_nvic_ipr6  = 32'hE000E418;
   localparam [31:0] const_a_nvic_ipr7  = 32'hE000E41C;
   localparam [31:0] const_a_cpuid      = 32'hE000ED00;
   localparam [31:0] const_a_icsr       = 32'hE000ED04;
   localparam [31:0] const_a_vtor       = 32'hE000ED08;
   localparam [31:0] const_a_aircr      = 32'hE000ED0C;
   localparam [31:0] const_a_scr        = 32'hE000ED10;
   localparam [31:0] const_a_ccr        = 32'hE000ED14;
   localparam [31:0] const_a_shpr2      = 32'hE000ED1C;
   localparam [31:0] const_a_shpr3      = 32'hE000ED20;
   localparam [31:0] const_a_shcsr      = 32'hE000ED24;
   localparam [31:0] const_a_mpu_type   = 32'hE000ED90;
   localparam [31:0] const_a_mpu_ctrl   = 32'hE000ED94;
   localparam [31:0] const_a_mpu_rnr    = 32'hE000ED98;
   localparam [31:0] const_a_mpu_rbar   = 32'hE000ED9C;
   localparam [31:0] const_a_mpu_rasr   = 32'hE000EDA0;
   localparam [31:0] const_a_dcrsr      = 32'hE000EDF4;
   localparam [31:0] const_a_dcrdr      = 32'hE000EDF8;

   // -------------------------------------------------------------------------
   // SCS hashing function
   // -------------------------------------------------------------------------

   // Generates a unique value for valid SCS register addresses which is not
   // all ones or all zeros. The exclusive-OR pairs are:
   //
   //    585A9A
   //    743742
   //
   // with 0x1F available as the unmatched PPB space hit.

   function [5:0] scs_hash;
      input [31:0] i_key;
      begin
        scs_hash = { i_key[ 5] ^ i_key[7],
                     i_key[ 8] ^ i_key[4],
                     i_key[ 5] ^ i_key[3],
                     i_key[10] ^ i_key[7],
                     i_key[ 9] ^ i_key[4],
                     i_key[10] ^ i_key[2] };
        end
   endfunction

   // -------------------------------------------------------------------------
   // SCS matching functions
   // -------------------------------------------------------------------------

   // Uses hash and a specific enable to determine one-hot select.

   function scs_dbg_sel;
      input [ 8:0] i_key;
      input [31:0] i_raw_addr;
      begin
        scs_dbg_sel = i_key[6] & (i_key[5:0] == scs_hash(i_raw_addr));
      end
   endfunction

   function scs_any_sel;
      input [ 8:0] i_key;
      input [31:0] i_raw_addr;
      begin
        scs_any_sel = i_key[5:0] == scs_hash(i_raw_addr);
      end
   endfunction

   function scs_tck_sel;
      input [ 8:0] i_key;
      input [31:0] i_raw_addr;
      begin
        scs_tck_sel = i_key[7] & (i_key[5:0] == scs_hash(i_raw_addr));
      end
   endfunction

   function scs_mpu_sel;
      input [ 8:0] i_key;
      input [31:0] i_raw_addr;
      begin
        scs_mpu_sel = i_key[8] & (i_key[5:0] == scs_hash(i_raw_addr));
      end
   endfunction

   // -------------------------------------------------------------------------
   // Address and debug master check functions
   // -------------------------------------------------------------------------
   // Returns true if address + dif_aphase result in an SCS "hit"
   // as a result of a debug access; note that ppb_trans allows
   // us to ignore address[31:29]

   function scs_dbg_chk;
      input [11:0] i_m_addr;
      input [31:0] i_raw_addr;
      begin
        scs_dbg_chk = {1'b1, i_raw_addr[11:2]} == i_m_addr[10:0];
      end
   endfunction

   function scs_any_chk;
      input [11:0] i_m_addr;
      input [31:0] i_raw_addr;
      begin
        scs_any_chk = i_raw_addr[11:2] == i_m_addr[9:0];
      end
   endfunction

   function scs_mpu_chk;
      input [11:0] i_m_addr;
      input [31:0] i_raw_addr;
      begin
        scs_mpu_chk = i_m_addr[11] & ( i_raw_addr[11:2] == i_m_addr[9:0] );
      end
   endfunction

   // -------------------------------------------------------------------------
   // Determine whether address hits in the SCS
   // -------------------------------------------------------------------------

   // note that debug accesses are identified using dif_aphase_i,
   // bits[31:12] for all SCS space registers are identical and
   // tested separately from bits [11:2]; only word transactions
   // are allowed to actually cause a real SCS access

   wire [11:0] scs_mad = { cfg_mpu, cfg_dbg & dif_aphase_i, ahb_addr_i[11:2] };

   wire        scs_prefix = ahb_addr_i[27:12] == 16'h000E;

   wire        scs_match  =
               ( // DEBUG ONLY ACCESSIBLE REGISTERS
                 scs_dbg_chk(scs_mad, const_a_shcsr)      |
                 scs_dbg_chk(scs_mad, const_a_dcrsr)      |
                 scs_dbg_chk(scs_mad, const_a_dcrdr)      |

                 // CORE AND DEBUG ACCESSIBLE REGISTERS
                 scs_mpu_chk(scs_mad, const_a_mpu_type)   |
                 scs_mpu_chk(scs_mad, const_a_mpu_ctrl)   |
                 scs_mpu_chk(scs_mad, const_a_mpu_rnr)    |
                 scs_mpu_chk(scs_mad, const_a_mpu_rbar)   |
                 scs_mpu_chk(scs_mad, const_a_mpu_rasr)   |
                 scs_any_chk(scs_mad, const_a_actlr)      |
                 scs_any_chk(scs_mad, const_a_syst_csr)   |
                 scs_any_chk(scs_mad, const_a_syst_rvr)   |
                 scs_any_chk(scs_mad, const_a_syst_cvr)   |
                 scs_any_chk(scs_mad, const_a_syst_calib) |
                 scs_any_chk(scs_mad, const_a_nvic_iser)  |
                 scs_any_chk(scs_mad, const_a_nvic_icer)  |
                 scs_any_chk(scs_mad, const_a_nvic_ispr)  |
                 scs_any_chk(scs_mad, const_a_nvic_icpr)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr0)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr1)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr2)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr3)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr4)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr5)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr6)  |
                 scs_any_chk(scs_mad, const_a_nvic_ipr7)  |
                 scs_any_chk(scs_mad, const_a_cpuid)      |
                 scs_any_chk(scs_mad, const_a_icsr)       |
                 scs_any_chk(scs_mad, const_a_vtor)       |
                 scs_any_chk(scs_mad, const_a_aircr)      |
                 scs_any_chk(scs_mad, const_a_scr)        |
                 scs_any_chk(scs_mad, const_a_ccr)        |
                 scs_any_chk(scs_mad, const_a_shpr2)      |
                 scs_any_chk(scs_mad, const_a_shpr3)      );


   // -------------------------------------------------------------------------
   // Construct compressed address
   // -------------------------------------------------------------------------

   // To reduce area, use the hashing function to compress the PPB space into
   // an 6-bit value; for transactions that hit in the PPB space, but do not
   // hit a decoded address it is still required to place a non-zero value into
   // the hash registers so as to allow scs_active to direct zeros from the PPB
   // space rather than potentially X's from AHB for core/debugger reads.

   wire [ 5:0] scs_null      = 6'b111111;

   wire [ 5:0] scs_addr      = scs_hash(ahb_addr_i[31:0]);

   wire        scs_valid     = scs_match & scs_prefix & ahb_size_1_i;
   wire        scs_trans     = hready_i  & ppb_trans_i &  scs_valid;
   wire        scs_null_sel  = hready_i  & ppb_trans_i & ~scs_valid;

   wire [ 5:0] scs_sel_nxt   = ( {6{scs_trans}}    & scs_addr |
                                 {6{scs_null_sel}} & scs_null );

   wire        scs_active    = |scs_sel_q;

   // For power saving, a large number of the NVIC registers are only clocked
   // during a ppb_write phase (assuming ACGs are implemented), this requires
   // that ppb_write self clear after any PPB transaction.

   wire        ppb_write_nxt = scs_trans & ahb_write_i;
   wire        ppb_write_en  = ppb_write_nxt | ppb_write_q;

   wire        scs_sel_en    = hready_i;

   wire        pclk_en       = ppb_write_q;

   // -------------------------------------------------------------------------
   // Expand one-hot selects for data-phase
   // -------------------------------------------------------------------------

   wire [ 8:0] scs_key        = { cfg_mpu,   // MPU present
                                  cfg_syst,  // SysTick present
                                  cfg_dbg,   // Debug present
                                  scs_sel_q[5:0] };

   wire        sel_actlr      = scs_any_sel(scs_key, const_a_actlr);
   wire        sel_syst_csr   = scs_tck_sel(scs_key, const_a_syst_csr);
   wire        sel_syst_rvr   = scs_tck_sel(scs_key, const_a_syst_rvr);
   wire        sel_syst_cvr   = scs_tck_sel(scs_key, const_a_syst_cvr);
   wire        sel_syst_calib = scs_tck_sel(scs_key, const_a_syst_calib);
   wire        sel_nvic_iser  = scs_any_sel(scs_key, const_a_nvic_iser);
   wire        sel_nvic_icer  = scs_any_sel(scs_key, const_a_nvic_icer);
   wire        sel_nvic_ispr  = scs_any_sel(scs_key, const_a_nvic_ispr);
   wire        sel_nvic_icpr  = scs_any_sel(scs_key, const_a_nvic_icpr);
   wire        sel_nvic_ipr0  = scs_any_sel(scs_key, const_a_nvic_ipr0);
   wire        sel_nvic_ipr1  = scs_any_sel(scs_key, const_a_nvic_ipr1);
   wire        sel_nvic_ipr2  = scs_any_sel(scs_key, const_a_nvic_ipr2);
   wire        sel_nvic_ipr3  = scs_any_sel(scs_key, const_a_nvic_ipr3);
   wire        sel_nvic_ipr4  = scs_any_sel(scs_key, const_a_nvic_ipr4);
   wire        sel_nvic_ipr5  = scs_any_sel(scs_key, const_a_nvic_ipr5);
   wire        sel_nvic_ipr6  = scs_any_sel(scs_key, const_a_nvic_ipr6);
   wire        sel_nvic_ipr7  = scs_any_sel(scs_key, const_a_nvic_ipr7);
   wire        sel_cpuid      = scs_any_sel(scs_key, const_a_cpuid);
   wire        sel_icsr       = scs_any_sel(scs_key, const_a_icsr);
   wire        sel_vtor       = scs_any_sel(scs_key, const_a_vtor);
   wire        sel_aircr      = scs_any_sel(scs_key, const_a_aircr);
   wire        sel_scr        = scs_any_sel(scs_key, const_a_scr);
   wire        sel_ccr        = scs_any_sel(scs_key, const_a_ccr);
   wire        sel_shpr2      = scs_any_sel(scs_key, const_a_shpr2);
   wire        sel_shpr3      = scs_any_sel(scs_key, const_a_shpr3);
   wire        sel_shcsr      = scs_dbg_sel(scs_key, const_a_shcsr);
   wire        sel_mpu_type   = scs_mpu_sel(scs_key, const_a_mpu_type);
   wire        sel_mpu_ctrl   = scs_mpu_sel(scs_key, const_a_mpu_ctrl);
   wire        sel_mpu_rnr    = scs_mpu_sel(scs_key, const_a_mpu_rnr);
   wire        sel_mpu_rbar   = scs_mpu_sel(scs_key, const_a_mpu_rbar);
   wire        sel_mpu_rasr   = scs_mpu_sel(scs_key, const_a_mpu_rasr);
   wire        sel_dcrsr      = scs_dbg_sel(scs_key, const_a_dcrsr);
   wire        sel_dcrdr      = scs_dbg_sel(scs_key, const_a_dcrdr);

   // -------------------------------------------------------------------------
   // Selector register
   // -------------------------------------------------------------------------

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       scs_sel_q <= {6{1'b0}};
     else if(scs_sel_en)
       scs_sel_q <= scs_sel_nxt;

   always @(posedge hclk or negedge hreset_n)
     if(~hreset_n)
       ppb_write_q <= 1'b0;
     else if(ppb_write_en)
       ppb_write_q <= ppb_write_nxt;

   // -------------------------------------------------------------------------
   // Construct ID values with implementer ECO bits
   // -------------------------------------------------------------------------

   // ECOREVNUM at the top-level provides the architectural and design
   // methodology recommended ability to patch a set of revision/patch fields;
   // typically these values will be zero.

   wire [31:0] eco_cpuid = {28'b0, eco_rev_num_3to0_i};
   wire [31:0] val_cpuid = 32'h410CC601 ^ eco_cpuid;

   // -------------------------------------------------------------------------
   // Construct ID value bus locally to benefit from minimisation
   // -------------------------------------------------------------------------

   // The debugger needs to be able to access these registers whilst the core
   // is held in reset, so we need to merge in the debugger selections.

   wire        sel_cpuid_all = sel_cpuid | dsl_cid_sels[0];
   wire        sel_actlr_all = sel_actlr | dsl_cid_sels[1];

   wire [31:0] cid_rdata = ( {32{sel_cpuid_all}} & val_cpuid    |
                             {32{sel_actlr_all}} & 32'h00000000 );

   // -------------------------------------------------------------------------
   // Construct CPU related debug enables
   // -------------------------------------------------------------------------

   // To perform core register read and writes, the debugger has the ability to
   // write to both the opcode buffer and auxiliary register of the core; to
   // save routing to debug and back, the combination of the two selects and
   // ppb_write logic are performed here and then passed directly to the core.

   // Mask debug requests that are not accompanied with a halt request in order
   // to prevent some corner cases around debugger transactions in parallel
   // with DBGRESTART requests.

   wire        dbg_sel_ok = dbg_halt_req & ppb_write_q;

   wire        dbg_aux_en = cfg_dbg ? (sel_dcrdr & dbg_sel_ok) : 1'b0;
   wire        dbg_op_en  = cfg_dbg ? (sel_dcrsr & dbg_sel_ok) : 1'b0;

   // -------------------------------------------------------------------------
   // Construct output bus
   // -------------------------------------------------------------------------

   wire [23:0] nvic_sels = { sel_vtor,       sel_syst_csr,   sel_syst_rvr,
                             sel_syst_cvr,   sel_syst_calib, sel_nvic_iser,
                             sel_nvic_icer,  sel_nvic_ispr,  sel_nvic_icpr,
                             sel_nvic_ipr0,  sel_nvic_ipr1,  sel_nvic_ipr2,
                             sel_nvic_ipr3,  sel_nvic_ipr4,  sel_nvic_ipr5,
                             sel_nvic_ipr6,  sel_nvic_ipr7,  sel_icsr,
                             sel_aircr,      sel_scr,        sel_ccr,
                             sel_shpr2,      sel_shpr3,      sel_shcsr };

   wire [ 4:0] mpu_sels  = { sel_mpu_type,   sel_mpu_ctrl,   sel_mpu_rnr,
                             sel_mpu_rbar,   sel_mpu_rasr };

   // -------------------------------------------------------------------------
   // Assign outputs
   // -------------------------------------------------------------------------

   assign msl_nvic_sels_o  = nvic_sels;
   assign msl_mpu_sels_o   = mpu_sels;
   assign msl_sel_dcrdr_o  = sel_dcrdr;
   assign msl_cid_rdata_o  = cid_rdata;
   assign msl_ppb_write_o  = ppb_write_q;
   assign msl_ppb_active_o = scs_active;
   assign msl_dbg_aux_en_o = dbg_aux_en;
   assign msl_dbg_op_en_o  = dbg_op_en;
   assign msl_pclk_en_o    = pclk_en;

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
       .width(3),
       .property_type(`OVL_ASSERT),
       .msg("Register enables must never be X"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_reg_en_x
     (.clock     (hclk),
      .reset     (hreset_n),
      .enable    (1'b1),
      .qualifier (1'b1),
      .test_expr ({ pclk_en,
                    scs_sel_en,
                    ppb_write_en }),
      .fire());

   // --------
   // scs_addr must not be zero if the address is valid.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Valid SCS hashes must be non-zero"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_hash_safe
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(scs_trans),
      .consequent_expr(|scs_addr),
      .fire());

   // --------
   // scs_addr must not coincide with zero select value.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("Valid SCS hash clashes with NULL"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_hash_not_null
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(scs_null_sel),
      .consequent_expr(~scs_trans),
      .fire());

   // --------
   // Expanded PPB and debug selects must be zero if encoding zero.

   ovl_implication
     #(.severity_level(`OVL_FATAL),
       .property_type(`OVL_ASSERT),
       .msg("All outputs must be zero if no sels"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_sels_no_out
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(~|{scs_sel_q,dsl_cid_sels}),
      .consequent_expr(~|{msl_nvic_sels_o,
                          msl_mpu_sels_o,
                          msl_sel_dcrdr_o,
                          msl_cid_rdata_o,
                          msl_ppb_write_o,
                          msl_ppb_active_o,
                          msl_dbg_aux_en_o,
                          msl_dbg_op_en_o,
                          msl_pclk_en_o}),
      .fire());

   // --------
   // Only one register can be selected at a time.

   ovl_zero_one_hot
     #(.severity_level  (`OVL_FATAL),
       .width           (29), // 23 nvic + 5 mpu + vtor
       .property_type   (`OVL_ASSERT),
       .msg ("Must not select more than 1 register"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))
   u_sels_zoh
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .test_expr       ({msl_nvic_sels_o, msl_mpu_sels_o}),
      .fire            ());

   // --------
   // No transaction must result in no select in the next cycle.

   ovl_next
     #(.severity_level(`OVL_FATAL),
       .num_cks(1),
       .check_overlapping(1),
       .check_missing_start(0),
       .property_type(`OVL_ASSERT),
       .msg("Idle cycle cannot produce a sel"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_notx_nosel
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .start_event(~ppb_trans_i | ~hready_i),
      .test_expr(~|scs_sel_q),
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
     (.clock(hclk),
      .reset(1'b1),
      .enable(1'b1),
      .qualifier(1'b1),
      .test_expr(CBAW),
      .fire());

   // --------
   // Parameterisable configuration check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(1),
       .property_type(`OVL_ASSERT),
       .msg("DBG config unknown"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cfg_dbg
     (.clock(hclk),
      .reset(1'b1),
      .enable(1'b1),
      .qualifier(1'b1),
      .test_expr(cfg_dbg),
      .fire());

   // --------
   // Parameterisable configuration check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(1),
       .property_type(`OVL_ASSERT),
       .msg("SYST config unknown"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cfg_syst
     (.clock(hclk),
      .reset(1'b1),
      .enable(1'b1),
      .qualifier(1'b1),
      .test_expr(cfg_syst),
      .fire());

   // --------
   // Parameterisable configuration check.

   ovl_never_unknown
     #(.severity_level(`OVL_FATAL),
       .width(1),
       .property_type(`OVL_ASSERT),
       .msg("MPU config unknown"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_asrt_cfg_mpu
     (.clock(hclk),
      .reset(1'b1),
      .enable(1'b1),
      .qualifier(1'b1),
      .test_expr(cfg_mpu),
      .fire());

   // --------
   // Transactions performed into the SCS will not appear on the AHB.

   ovl_implication
     #(.severity_level   (`OVL_FATAL),
       .property_type    (`OVL_ASSERT),
       .msg              ("SCS accesses must not use AHB bus"),
       .coverage_level   (`OVL_COVER_DEFAULT),
       .clock_edge       (`OVL_POSEDGE),
       .reset_polarity   (`OVL_ACTIVE_LOW),
       .gating_type      (`OVL_GATE_NONE))
   u_asrt_scs_sel_hready
     (.clock            (hclk),
      .reset            (hreset_n),
      .enable           (1'b1),
      .antecedent_expr  (|scs_sel_q),
      .consequent_expr  (hready_i),
      .fire());

   wire        a_scs_sel_hready_ok = ~(|scs_sel_q) | hready_i;

   // --------
   // Core accesses to the SHCSR are UNPREDICTABLE.

   ovl_implication
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg("SHCSR access by core is UNPREDICTABLE"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_shcsr_dbg_only
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(hready_i & ppb_trans_i & scs_prefix &
                       (ahb_addr_i == const_a_shcsr)),
      .consequent_expr(dif_aphase_i),
      .fire());

   // --------
   // core accesses to the DCRSR might be UNPREDICTABLE.

   ovl_implication
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg("DCRSR access by core is UNPREDICTABLE"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_dcrsr_dbg_only
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(hready_i & ppb_trans_i & scs_prefix &
                       (ahb_addr_i == const_a_dcrsr)),
      .consequent_expr(dif_aphase_i),
      .fire());

   // --------
   // core accesses to the DCRDR might be UNPREDICTABLE.

   ovl_implication
     #(.severity_level(`OVL_INFO),
       .property_type(`OVL_ASSERT),
       .msg("DCRDR access by core is UNPREDICTABLE"),
       .coverage_level(`OVL_COVER_DEFAULT),
       .clock_edge(`OVL_POSEDGE),
       .reset_polarity(`OVL_ACTIVE_LOW),
       .gating_type(`OVL_GATE_NONE))
   u_info_dcrdr_dbg_only
     (.clock(hclk),
      .reset(hreset_n),
      .enable(1'b1),
      .antecedent_expr(hready_i & ppb_trans_i & scs_prefix &
                       (ahb_addr_i == const_a_dcrdr)),
      .consequent_expr(dif_aphase_i),
      .fire());

   // -------------------------------------------------------------------------

`endif

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
