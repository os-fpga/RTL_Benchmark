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
//   Checked In : $Date: 2012-06-26 15:45:32 +0100 (Tue, 26 Jun 2012) $
//   Revision   : $Revision: 213087 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ DEBUG SLAVE PORT BUS INFERFACE UNIT
//-----------------------------------------------------------------------------

module cm0p_dbg_if
  #(parameter CBAW   = 0,
    parameter AHBSLV = 1,
    parameter IOP    = 0,
    parameter MPU    = 0,
    parameter RAR    = 0)
   (input  wire        dclk,                 // Debug clock
    input  wire        dbg_reset_n,          // Debug reset

    output wire [31:0] slv_rdata_o,          // SLV port read-data
    output wire        slv_ready_o,          // SLV port ready
    output wire        slv_resp_o,           // SLV port error response

    output wire        dif_spec_trans_o,     // Debugger speculative transaction
    output wire        dif_aphase_o,         // Debugger in address-phase
    output wire [31:0] dif_addr_o,           // Debugger address to matrix
    output wire [ 1:0] dif_size_o,           // Debugger size to matrix
    output wire [ 1:0] dif_cb_o,             // Debugger transaction attributes
    output wire        dif_priv_o,           // Debugger transaction privileged
    output wire [31:0] dif_wdata_o,          // Debugger write-data to AHB/NVIC
    output wire        dif_write_o,          // Debugger write not read
    output wire        dif_cpu_force_idle_o, // Force debug access slot (QoS)

    input  wire        hready_i,             // AHB ready / core advance
    input  wire [31:0] slv_addr_i,           // SLV port address
    input  wire [ 3:0] slv_prot_i,           // SLV port transaction protection
    input  wire        slv_stall_i,          // SLV port stall request
    input  wire [ 1:0] slv_size_i,           // SLV port transaction size
    input  wire [ 1:0] slv_trans_i,          // SLV port transaction
    input  wire [31:0] slv_wdata_i,          // SLV port write-data
    input  wire        slv_write_i,          // SLV port write not read

    input  wire        cpu_wphase_i,         // Core in AHB write-data-phase
    input  wire [31:0] bpu_hrdata_i,         // Breakpoint unit read-data
    input  wire [31:0] dsl_hrdata_i,         // CoreSight ID read-data
    input  wire [31:0] dbg_hrdata_i,         // Debug control read-data
    input  wire [31:0] dwt_hrdata_i,         // Watchpoint unit read-data
    input  wire        mtx_dif_slot_i,       // Matrix address slot for debugger
    input  wire [31:0] mtx_dif_rdata_i,      // Matrix read-data from AHB/NVIC
    input  wire        mtx_dif_resp_i,       // Matrix error response from AHB
    input  wire        mtx_dif_io_hit_i,     // IO port transaction issued
    input  wire        iaex_en_i,            // Processor PC advancing
    input  wire        dsl_ppb_usr_err_i);   // PPB user access error reponse

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   // This module is only generated if DBG is implemented or if using CBAW for
   // model generation purposes. As a result, cfg_rar and cfg_dbg are not fully
   // utilized for the standard synthesis.

   wire        cfg_ahbslv, cfg_dbg, cfg_iop, cfg_mpu, cfg_rar;

   generate
      if (CBAW == 0) begin : gen_cfg_cbaw0

         assign cfg_ahbslv = (AHBSLV != 0);
         assign cfg_dbg    = 1'b1;
         assign cfg_iop    = (IOP    != 0);
         assign cfg_mpu    = (MPU    != 0);
         assign cfg_rar    = (RAR    != 0);
         wire unused = cfg_rar;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // State registers
   // -------------------------------------------------------------------------

   reg  [31:0] slv_addr_q;   // Registered SLV address
   reg  [ 1:0] slv_cb_q;     // Registered SLV attributes
   reg         slv_priv_q;   // Registered SLV priviledged
   reg  [ 1:0] slv_size_q;   // Registered SLV size
   reg         slv_trans_q;  // Registered SLV transaction valid
   reg         slv_write_q;  // Registered SLV write not read
   reg         dphase_q;     // Interface in data-phase
   reg         stall_q;      // Stall SLV transaction request
   reg  [ 3:0] count_q;      // QoS not arbitrated access slot counter

   // -------------------------------------------------------------------------
   // Discard input bits used to keep bus aligned to AHB-Lite standard
   // -------------------------------------------------------------------------

   wire [ 1:0] unused = { slv_prot_i[0], slv_trans_i[0] };

   // -------------------------------------------------------------------------
   // Mask inputs if debug is not present
   // -------------------------------------------------------------------------

   // For synthesis, cfg_dbg will always be one as this module is never
   // instantiated. For ARM model creation, we need to support the module
   // being present, but all inputs from the SLV port being ignored.

   wire        cpu_wphase = cfg_dbg                & cpu_wphase_i;
   wire [31:0] slv_addr   = {32{cfg_dbg}}          & slv_addr_i[31:0];
   wire [ 1:0] slv_cb     = {2{cfg_dbg & cfg_mpu}} & slv_prot_i[3:2];
   wire        slv_priv   = cfg_dbg                & slv_prot_i[1];
   wire [ 1:0] slv_size   = {2{cfg_dbg}}           & slv_size_i[1:0];
   wire        slv_trans  = cfg_dbg                & slv_trans_i[1];
   wire [31:0] slv_wdata  = {32{cfg_dbg}}          & slv_wdata_i[31:0];
   wire        slv_write  = cfg_dbg                & slv_write_i;

   // -------------------------------------------------------------------------
   // Assign debug-interface control signals
   // -------------------------------------------------------------------------

   // If operating in AHB compliant mode, then the debug interface (DIF)
   // signals must be assigned from the registered SLV port variants, else they
   // are assigned straight from the SLV port input pins.

   wire [31:0] dif_addr;
   wire [ 1:0] dif_cb;
   wire        dif_priv;
   wire [ 1:0] dif_size;
   wire        dif_write;

   generate
      if(CBAW != 0) begin : gen_ahbslv_0a

         assign dif_addr  = cfg_ahbslv ? slv_addr_q[31:0] : slv_addr[31:0];
         assign dif_cb    = cfg_ahbslv ? slv_cb_q[1:0]    : slv_cb[1:0];
         assign dif_priv  = cfg_ahbslv ? slv_priv_q       : slv_priv;
         assign dif_size  = cfg_ahbslv ? slv_size_q[1:0]  : slv_size[1:0];
         assign dif_write = cfg_ahbslv ? slv_write_q      : slv_write;

      end else if(AHBSLV != 0) begin : gen_ahbslv_0b

         assign dif_addr  = slv_addr_q[31:0];
         assign dif_cb    = slv_cb_q[1:0];
         assign dif_priv  = slv_priv_q;
         assign dif_size  = slv_size_q[1:0];
         assign dif_write = slv_write_q;

      end else begin : gen_ahbslv_0c

         wire [37:0] unused = { slv_addr_q[31:0], slv_cb_q[1:0], slv_priv_q,
                                slv_size_q[1:0], slv_write_q };

         assign dif_addr  = slv_addr[31:0];
         assign dif_cb    = slv_cb[1:0];
         assign dif_priv  = slv_priv;
         assign dif_size  = slv_size[1:0];
         assign dif_write = slv_write;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Construct AHB and IO port write data
   // -------------------------------------------------------------------------

   // AHB only requires the active byte-lanes to contain valid data. To
   // simplify connection of sub-32-bit peripherals to the AHB and/or IO port
   // the active lanes are replicated across all lanes. Use a simple
   // butterfly matrix to extract the appropriate bytes from the incoming SLV
   // write-data and replicate these:

   wire [ 1:0] w_sel_a   = { dif_addr[1] | dif_size[1], ~dif_addr[1] };

   wire [31:0] w_data_a  = { w_sel_a[1] ? slv_wdata[31:16] : slv_wdata[15: 0],
                             w_sel_a[0] ? slv_wdata[15: 0] : slv_wdata[31:16] };

   wire [ 1:0] w_sel_b   = { dif_size[0] | dif_size[1] |  dif_addr[0],
                             dif_size[0] | dif_size[1] | ~dif_addr[0] };

   wire [31:0] w_data_b  = { w_sel_b[1] ? w_data_a[31:24] : w_data_a[23:16],
                             w_sel_b[0] ? w_data_a[23:16] : w_data_a[31:24],
                             w_sel_b[1] ? w_data_a[15: 8] : w_data_a[ 7: 0],
                             w_sel_b[0] ? w_data_a[ 7: 0] : w_data_a[15: 8] };

   // Ensure wdata is zero when write transaction may not be processed.

   wire        w_data_en = dphase_q | slv_trans_q & mtx_dif_slot_i;

   wire [31:0] dif_wdata = {32{w_data_en & ~cpu_wphase}} & w_data_b;

   // -------------------------------------------------------------------------
   // Merge debug component read data with AHB/NVIC read data
   // -------------------------------------------------------------------------

   // Mask faulting data values from AHB/PPB if configured for use as in AHB
   // mode. The Cortex-M0+ DAP automatically performs this, so there is no need
   // to do this if the interface is not configured for AHB.

   wire [31:0] mtx_rdata = {32{~stall_q | ~cfg_ahbslv}} & mtx_dif_rdata_i;

   // Any non-selected component always returns zero on its read data, so
   // simply OR together the read-data values:


   wire [31:0] slv_rdata = ( dwt_hrdata_i |   // Watchpoint unit
                             bpu_hrdata_i |   // Breakpoint unit
                             dbg_hrdata_i |   // Debug control
                             dsl_hrdata_i |   // CoreSight IDs
                             mtx_rdata    );  // AHB, PPB, NVIC and IO port

   // -------------------------------------------------------------------------
   // IO port hit conditioning
   // -------------------------------------------------------------------------

   // If the processor is implemented without an IO port, then optimize out
   // the logic associated with handling IO port transactions.

   wire        dif_io_hit;

   generate
      if((CBAW != 0) || (IOP != 0)) begin : gen_iop_1a

         assign dif_io_hit = cfg_iop & mtx_dif_io_hit_i;

      end else begin : gen_iop_1b

         wire unused = mtx_dif_io_hit_i;
         assign dif_io_hit = 1'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Response control
   // -------------------------------------------------------------------------

   // Generate READY and RESP signals for the SLV interface. The interface is
   // ready whenever there is no transaction already registered, when it is
   // returning data from the IO port or AHB/PPB, or in the second cycle of a
   // two cycle error response.

   wire slv_ready = ( ~slv_trans_q |                             // Idle
                      mtx_dif_slot_i & dif_io_hit |              // IOP data
                      dphase_q & hready_i & ~dsl_ppb_usr_err_i | // AHB data
                      dphase_q & stall_q );                      // Error

   // Errors are generated as per AHB-Lite, and are always extended to a full
   // two cycle response, even if the AHB is reset midway through.

   wire slv_resp     = dphase_q & ( stall_q |            // Registered fault
                                    mtx_dif_resp_i |     // AHB fault
                                    dsl_ppb_usr_err_i ); // PPB privilege fault

   // -------------------------------------------------------------------------
   // Register terms
   // -------------------------------------------------------------------------

   // The SLV trans register is enabled whenever the interface is driving ready
   // high. The remainded of the control is sampled when both ready is high and
   // a new transfer is being presented.

   wire slv_ctl_en   = slv_trans & slv_ready;
   wire slv_trans_en = slv_ready;

   // --------
   // The stall register is used both to prevent the debug interface from
   // starting a new transaction if it hasn't already started, or to implement
   // the two cycle error reponse, if it has.

   // Stalls are inserted for the first cycle of all AHB faults (even those
   // seen by the processor), for the first cycle response geenrated by
   // privilege based PPB access faults, and final to implement the SLVSTALL
   // capability by generating a stall if the interface is, or will be idle.

   wire stall_nxt    = ( ~hready_i & mtx_dif_resp_i |  // Any AHB fault
                         dsl_ppb_usr_err_i |           // PPB privilege fault
                         slv_ready & slv_stall_i |     // SVLSTALL and idle ..
                         ~mtx_dif_slot_i & ~dphase_q & slv_stall_i ); // ..next

   wire stall_en     = stall_nxt | stall_q; // Stall self clears

   // -------------------------------------------------------------------------
   // Generate transaction request for bus-matrix
   // -------------------------------------------------------------------------

   // Request a transaction if we have a transaction pending as long as a core
   // transaction hasn't just received an HRESP error.

   wire        wr_clash       = cpu_wphase & dif_write;
   wire        dif_spec_trans = slv_trans_q & ~dphase_q & ~stall_q & ~wr_clash;

   // The request is validated by the matrix on the first cycle in which the
   // core does not also wish to perform one, indicated by mtx_slot; use this
   // to determine when the debug interface enters its data-phase.

   wire        dif_aphase = dif_spec_trans & mtx_dif_slot_i;

   wire        dphase_nxt = dif_aphase & ~dif_io_hit;
   wire        dphase_en  = dif_aphase & hready_i | dphase_q & slv_ready;

   // -------------------------------------------------------------------------
   // Debug interface transaction QoS
   // -------------------------------------------------------------------------

   // Core transactions have higher priority than debugger transactions and
   // the core can issue accesses back to back for arbitrarily long periods of
   // time; to avoid situations where the core can prevent debugger access for
   // too long, ensure the core becomes idle at some point in the near future.

   wire        count_max = count_q == 4'hF;
   wire [ 4:0] count_sat = {count_q[3:0], ~count_max} + 1'b1;
   wire [ 3:0] count_inc = count_sat[4:1];

   wire        count_up  = ( hready_i & iaex_en_i & ~mtx_dif_slot_i &
                             ~slv_stall_i );

   wire        count_clr = slv_ready | dsl_ppb_usr_err_i;
   wire        count_en  = slv_trans_q & (count_up | count_clr);

   wire [ 3:0] count_nxt = {4{~count_clr}} & count_inc[3:0];

   wire        dif_cpu_force_idle = count_max & ~slv_stall_i;

   // -------------------------------------------------------------------------
   // Sequential updates
   // -------------------------------------------------------------------------

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       stall_q <= 1'b0;
     else if (stall_en)
       stall_q <= stall_nxt;

   always @(posedge dclk or negedge dbg_reset_n)
     if (~dbg_reset_n)
       dphase_q <= 1'b0;
     else if (dphase_en)
       dphase_q <= dphase_nxt;

   always @(posedge dclk or negedge dbg_reset_n)
     if(~dbg_reset_n)
       count_q <= 4'b0;
     else if(count_en)
       count_q <= count_nxt[3:0];

   // --------
   // The following register carry the SLV transaction payload when the
   // interface is configured in AHB like mode.

   generate
      if((CBAW != 0) || ((AHBSLV != 0) && (RAR != 0))) begin : gen_rar_0a

         wire rar_reset_n = ~cfg_rar | dbg_reset_n;

         always @(posedge dclk or negedge rar_reset_n)
           if(~rar_reset_n) begin
              slv_addr_q  <= {32{1'b1}};
              slv_priv_q  <= 1'b1;
              slv_size_q  <= {2{1'b1}};
              slv_write_q <= 1'b1;
           end else if(slv_ctl_en) begin
              slv_addr_q  <= slv_addr[31:0];
              slv_priv_q  <= slv_priv;
              slv_size_q  <= slv_size[1:0];
              slv_write_q <= slv_write;
           end

      end else if(AHBSLV != 0) begin : gen_rar_0b

         always @(posedge dclk)
           if(slv_ctl_en) begin
              slv_addr_q  <= slv_addr[31:0];
              slv_priv_q  <= slv_priv;
              slv_size_q  <= slv_size[1:0];
              slv_write_q <= slv_write;
           end

      end else begin : gen_rar_0c

         wire unused = slv_ctl_en;
         wire zero = 1'b0;

         always @*
           begin
              slv_addr_q  = {32{zero}};
              slv_priv_q  = zero;
              slv_size_q  = {2{zero}};
              slv_write_q = zero;
           end

      end
   endgenerate

   // --------
   // If no MPU is present, then the AHB properties assigned to transactions
   // generated by the SLV port are forced to mirror those of the processor
   // for a given address space.

   localparam AHB_AND_MPU         = (AHBSLV != 0) && (MPU != 0);
   localparam AHB_AND_MPU_AND_RAR = AHB_AND_MPU && (RAR != 0);

   generate
      if((CBAW != 0) || AHB_AND_MPU_AND_RAR) begin : gen_rar_1a

         wire rar_reset_n = ~cfg_rar | dbg_reset_n;

         always @(posedge dclk or negedge rar_reset_n)
           if(~rar_reset_n)
             slv_cb_q <= {2{1'b1}};
           else if(slv_ctl_en)
             slv_cb_q <= slv_cb[1:0];

      end else if(AHB_AND_MPU) begin : gen_rar_1b

         always @(posedge dclk)
           if(slv_ctl_en)
             slv_cb_q <= slv_cb[1:0];

      end else begin : gen_rar_1c

         if(AHBSLV != 0) begin : gen_rar_1d
            wire [1:0] unused = slv_cb;
         end

         wire zero = 1'b0;
         always @* slv_cb_q = {2{zero}};

      end
   endgenerate

   // --------
   // The transaction register is always present if the SLV port is functional,
   // even in non-AHB mode. This results in all SLV port transactions being
   // delayed one cycle, but also ensures that the SLVWDATA will be valid when
   // the register is set. The non-AHB mode SLV port master is required to hold
   // its address and size signals, thus all information is available in a
   // single cycle.

   always @(posedge dclk or negedge dbg_reset_n)
     if(~dbg_reset_n)
       slv_trans_q <= 1'b0;
     else if(slv_trans_en)
       slv_trans_q <= slv_trans;

   // -------------------------------------------------------------------------
   // Output assignments
   // -------------------------------------------------------------------------

   // Assign outputs. All signals are mapped straight through for synthesis
   // builds, as when CBAW is zero, this module is only generated if DBG and
   // thus cfg_dbg are true.

   assign      dif_aphase_o         = cfg_dbg ? dif_aphase         :  1'b0;
   assign      dif_cb_o             = cfg_dbg ? dif_cb             :  2'b0;
   assign      dif_cpu_force_idle_o = cfg_dbg ? dif_cpu_force_idle :  1'b0;
   assign      dif_spec_trans_o     = cfg_dbg ? dif_spec_trans     :  1'b0;
   assign      dif_addr_o           = cfg_dbg ? dif_addr           : 32'b0;
   assign      dif_priv_o           = cfg_dbg ? dif_priv           :  1'b0;
   assign      slv_rdata_o          = cfg_dbg ? slv_rdata          : 32'b0;
   assign      slv_ready_o          = cfg_dbg ? slv_ready          :  1'b1;
   assign      slv_resp_o           = cfg_dbg ? slv_resp           :  1'b0;
   assign      dif_size_o           = cfg_dbg ? dif_size           :  2'b0;
   assign      dif_wdata_o          = cfg_dbg ? dif_wdata          : 32'b0;
   assign      dif_write_o          = cfg_dbg ? dif_write          :  1'b0;

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

 `include "std_ovl_defines.h"

   // --------
   // Register enables must never be unknown.

   ovl_never_unknown
     #(.severity_level (`OVL_FATAL),
       .width          (5),
       .property_type  (`OVL_ASSERT),
       .msg            ("Register enables must never be X"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_reg_en_x
     (.clock     (dclk),
      .reset     (dbg_reset_n),
      .enable    (1'b1),
      .qualifier (1'b1),
      .test_expr ({ stall_en,
                    dphase_en,
                    count_en,
                    slv_trans_en,
                    slv_ctl_en }),
      .fire      ());

   // --------
   // A data-phase requires a transaction to be registered.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("DIF data-phase requires an active transaction"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_dphase_q_slvtrans_q
     (.clock           (dclk),
      .reset           (dbg_reset_n),
      .enable          (1'b1),
      .antecedent_expr (dphase_q),
      .consequent_expr (slv_trans_q),
      .fire            ());

   // --------
   // The SLVSTALL input must not result in the CPU being requested to idle.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("SLVSTALL must not force idle the CPU"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_slvstall_no_cpu_stall
     (.clock           (dclk),
      .reset           (dbg_reset_n),
      .enable          (1'b1),
      .antecedent_expr (stall_q & slv_stall_i),
      .consequent_expr (~dif_cpu_force_idle_o),
      .fire            ());

   // --------
   // There must be an outstanding transaction if we are stalling the CPU.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg            ("CPU only stalled for an outstanding transaction"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_stall_needs_trans
     (.clock           (dclk),
      .reset           (dbg_reset_n),
      .enable          (1'b1),
      .antecedent_expr (dif_cpu_force_idle_o),
      .consequent_expr (slv_trans_q),
      .fire            ());

   // -------------------------------------------------------------------------

`endif

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
