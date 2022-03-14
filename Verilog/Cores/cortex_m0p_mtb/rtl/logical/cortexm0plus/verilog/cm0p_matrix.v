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
//   Checked In : $Date: 2012-01-10 12:23:46 +0000 (Tue, 10 Jan 2012) $
//   Revision   : $Revision: 197289 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ MATRIX ARBITRATION BETWEEN CORE AND DEBUG SLAVE PORT
//-----------------------------------------------------------------------------

module cm0p_matrix
  #(parameter CBAW   = 0,
    parameter DBG    = 1,
    parameter IOP    = 0,
    parameter MPU    = 0,
    parameter SYST   = 1)

   (input  wire        hclk,               // Gated AHB clock
    input  wire        hreset_n,           // System reset

    output wire        spec_htrans_o,      // Speculative HTRANS[1] output
    output wire [31:0] haddr_o,            // AHB address
    output wire [ 2:0] hburst_o,           // AHB burst type (always 0)
    output wire        hmastlock_o,        // AHB locked transfer (always 0)
    output wire [ 3:0] hprot_o,            // AHB transaction protection
    output wire [ 2:0] hsize_o,            // AHB transaction size
    output wire [ 1:0] htrans_o,           // AHB transaction
    output wire [31:0] hwdata_o,           // AHB write-data
    output wire        hwrite_o,           // AHB write not read
    output wire        hmaster_o,          // bus master (0=core, 1=debug)
    output wire        shareable_o,        // AHB transaction shareable

    output wire [31:0] io_addr_o,          // IOP address
    output wire [31:0] io_check_o,         // IOP decode address
    output wire        io_master_o,        // IOP active master 0=CPU, 1=DBG
    output wire        io_priv_o,          // IOP access privileged
    output wire [ 1:0] io_size_o,          // IOP transaction size
    output wire        io_trans_o,         // IOP transaction valid
    output wire [31:0] io_wdata_o,         // IOP write-data
    output wire        io_write_o,         // IOP write

    input wire         io_match_i,         // IOP decoder match
    input wire  [31:0] io_rdata_i,         // IOP read-data

    input wire  [31:0] cpu_io_addr_i,      // CPU IO address
    input wire  [31:0] cpu_io_check_i,     // CPU IO decode address
    input wire         cpu_io_priv_i,      // CPU IO access privileged
    input wire         cpu_io_trans_i,     // CPU IO transaction valid
    input wire  [31:0] cpu_io_wdata_i,     // CPU IO write-data
    input wire  [ 1:0] cpu_io_size_i,      // CPU IO size
    input wire         cpu_io_write_i,     // CPU IO write

    output wire        msl_dbg_aux_en_o,   // Load core AUX (DCRDR write)
    output wire        msl_dbg_op_en_o,    // Load core PFU (DCRSR write)
    output wire        msl_pclk_en_o,      // PPB space clock enable
    output wire [23:0] msl_nvic_sels_o,    // Register selects for NVIC
    output wire [ 4:0] msl_mpu_sels_o,     // Register selects for MPU

    output wire [31:0] mtx_ppb_wdata_o,    // Write-data to NVIC PPB space
    output wire        mtx_cpu_resp_o,     // AHB error response to core
    output wire [31:0] mtx_ppb_hrdata_o,   // PPB space read-data for core
    output wire [31:0] mtx_dif_rdata_o,    // All read-data for debugger
    output wire        mtx_dif_io_hit_o,   // Debugger data ready
    output wire        mtx_dif_resp_o,     // AHB error response to debug I/F
    output wire        mtx_dif_slot_o,     // Address slot available to debug
    output wire        mtx_ppb_write_o,    // PPB data-phase access is a write
    output wire        mtx_ppb_active_o,   // PPB data-phase

    input  wire [31:0] hrdata_i,           // AHB read-data
    input  wire        hready_i,           // AHB ready / core advance
    input  wire        hresp_i,            // AHB error response
    input  wire [ 3:0] eco_rev_num_3to0_i, // Change-order revision bits

    input  wire        cpu_dbg_stall_i,    // Core stall debugger
    input  wire        cpu_spec_htrans_i,  // Core speculative trans
    input  wire        cpu_trans_i,        // Core access
    input  wire [31:0] cpu_haddr_i,        // Core transaction address
    input  wire [ 1:0] cpu_hsize_i,        // Core transaction size
    input  wire        cpu_priv_i,         // Core privilege
    input  wire        cpu_dni_i,          // Core data not fetch
    input  wire        cpu_hwrite_i,       // Core write not read
    input  wire [ 2:0] cpu_scb_i,          // Core memory attributes
    input  wire [31:0] dif_addr_i,         // Debugger transaction address
    input  wire [ 1:0] dif_size_i,         // Debugger transaction size
    input  wire        dif_spec_trans_i,   // Debugger speculative transaction
    input  wire        dif_aphase_i,       // Debugger access address-phase
    input  wire [31:0] dif_wdata_i,        // Debugger write-data
    input  wire        dif_write_i,        // Debugger write not read
    input  wire [ 1:0] dif_cb_i,           // Debugger transaction cacheability
    input  wire        dif_priv_i,         // Debugger transaction privileged
    input  wire        dsl_acc_ok_i,       // Debugger transaction is allowed
    input  wire        dbg_halt_req_i,     // Debugger halt request
    input  wire [ 1:0] dsl_cid_sels_i,     // Debug selects for CPUID and ACTLR
    input  wire        dsl_ppb_active_i,   // Debugger access to PPB (mask AHB)
    input  wire [31:0] cpu_hwdata_i,       // Core write-data
    input  wire [31:0] cpu_dcrdr_data_i,   // Core DCRDR read-data
    input  wire [31:0] nvm_hrdata_i,       // NVIC PPB space read-data
    input  wire [31:0] mpu_rdata_i);       // MPU PPB space read data

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   wire        cfg_dbg, cfg_iop, cfg_mpu;

   generate
      if(CBAW == 0) begin : gen_cbaw
         assign cfg_dbg = (DBG != 0);
         assign cfg_iop = (IOP != 0);
         assign cfg_mpu = (MPU != 0);
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Registers
   // -------------------------------------------------------------------------

   reg         cpu_dphase_q;   // AHB data-phase belongs to CPU

   // -------------------------------------------------------------------------
   // Local wire declarations
   // -------------------------------------------------------------------------

   wire [31:0] cid_rdata;      // ID registers from matrix_dec
   wire        msl_ppb_active; // System domain PPB data-phase
   wire        ppb_write;      // System domain PPB data-phase write
   wire        sel_dcrdr;      // Expose DCRDR value

   // -------------------------------------------------------------------------
   // Mask inputs based upon configuration
   // -------------------------------------------------------------------------

   // Prune debug-interface and signals from CPU to debug if debug is not
   // present.

   wire        dif_spec_trans, dif_aphase, dif_write, dif_priv, dsl_ppb_active;
   wire [31:0] dif_addr;
   wire [ 1:0] dif_size;
   wire [31:0] dif_wdata;
   wire [ 1:0] dif_cb;
   wire [31:0] dcrdr_data;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_0a

         assign dif_spec_trans = cfg_dbg ? dif_spec_trans_i :  1'b0;
         assign dif_aphase     = cfg_dbg ? dif_aphase_i     :  1'b0;
         assign dif_addr       = cfg_dbg ? dif_addr_i       : 32'b0;
         assign dif_size       = cfg_dbg ? dif_size_i       :  2'b0;
         assign dif_write      = cfg_dbg ? dif_write_i      :  1'b0;
         assign dif_wdata      = cfg_dbg ? dif_wdata_i      : 32'b0;
         assign dif_cb         = cfg_dbg ? dif_cb_i         :  2'b0;
         assign dif_priv       = cfg_dbg ? dif_priv_i       :  1'b0;
         assign dsl_ppb_active = cfg_dbg ? dsl_ppb_active_i :  1'b0;
         assign dcrdr_data     = cfg_dbg ? cpu_dcrdr_data_i : 32'b0;

      end else begin : gen_dbg_0b

         wire [104:0] unused = { dif_spec_trans_i, dif_aphase_i,
                                 dif_addr_i[31:0], dif_size_i[1:0],
                                 dif_write_i, dif_wdata_i[31:0], dif_cb_i[1:0],
                                 dif_priv_i, dsl_ppb_active_i,
                                 cpu_dcrdr_data_i[31:0] };

         assign { dif_spec_trans, dif_aphase, dif_addr[31:0], dif_size[1:0],
                  dif_write, dif_wdata[31:0], dif_cb[1:0], dif_priv,
                  dsl_ppb_active, dcrdr_data[31:0] } = 105'b0;
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Combine debug and system domain terms
   // -------------------------------------------------------------------------

   wire        ppb_active = dsl_ppb_active | msl_ppb_active;

   // -------------------------------------------------------------------------
   // Constrain slave port to non-speculative CPU idle cycles
   // -------------------------------------------------------------------------

   // The slave port only has its transaction presented on the AHB port
   // whenever the core is not performing a transaction; to aid timing, this is
   // simplified to whenever the core might be doing a transaction.

   // One complexity is that whilst it is permissible for a transaction to be
   // retracted in light of an AHB HRESP error response, it is not permissible
   // to start a new one; in order to prevent this scenario occurring as a
   // result of the slave port performing a transaction in the core's retracted
   // cycle, the HREADY cycle following the first error cycle is enforced as
   // not being usable by the slave port also - this is implemented within the
   // debug blocks.

   wire        dif_slot = ( ~cpu_spec_htrans_i &
                            ~cpu_dbg_stall_i &
                            dif_spec_trans );

   // -------------------------------------------------------------------------
   // Protect CPU from slave port initiated HRESP errors
   // -------------------------------------------------------------------------

   wire        cpu_dphase_nxt = cpu_trans_i;
   wire        cpu_resp       = hresp_i & cpu_dphase_q;

   // -------------------------------------------------------------------------
   // Function for determining default memory attributes if MPU is absent
   // -------------------------------------------------------------------------

   // The ARMv6-M specifies default memory attributes based on the top most
   // three bits of address. Note that 0xE... is actually Strongly-Ordered,
   // however, this address range is never presented on AHB.

   function [2:0] f_dmm_scb (input [2:0] i_addr_31to29);
      begin
         case (i_addr_31to29)
           3'h0    : f_dmm_scb = 3'b010; // NS Normal-C-WT
           3'h1    : f_dmm_scb = 3'b011; // NS Normal-C-WBWA
           3'h2    : f_dmm_scb = 3'b001; // NS Device
           3'h3    : f_dmm_scb = 3'b011; // NS Normal-C-WBWA
           3'h4    : f_dmm_scb = 3'b010; // NS Normal-C-WT
           3'h5    : f_dmm_scb = 3'b101; //  S Device
           3'h6    : f_dmm_scb = 3'b001; // NS Device
           3'h7    : f_dmm_scb = 3'b001; // NS Device
           default : f_dmm_scb = 3'bxxx; // Unreachable
         endcase
      end
   endfunction

   // -------------------------------------------------------------------------
   // Generate final primary AHB signals
   // -------------------------------------------------------------------------

   // Select between slave-port values and core values.

   wire [ 1:0] ahb_size    = dif_aphase ? dif_size  : cpu_hsize_i;
   wire [31:0] ahb_addr    = dif_aphase ? dif_addr  : cpu_haddr_i;
   wire        ahb_write   = dif_aphase ? dif_write : cpu_hwrite_i;

   // HWDATA from core and debugger guaranteed zero outside respective dphase.

   wire [31:0] ahb_wdata   = dif_wdata | cpu_hwdata_i;

   // --------
   // Construct shareable, cacheable and bufferable signals. If a full MPU is
   // present, then use SLVPROT provided by the debugger, otherwise use the
   // ARMv6-M default memory model attributes.

   wire [ 2:0] scb_mpu0;

   generate
      if((CBAW != 0) || (MPU == 0)) begin: gen_scb_mpu0

         assign scb_mpu0 = {3{~cfg_mpu}} & f_dmm_scb(ahb_addr[31:29]);

      end else begin: gen_scb_mp0_else

         assign scb_mpu0 = {3{1'b0}};

      end
   endgenerate

   wire [ 2:0] scb_mpu1;

   generate
      if((CBAW != 0) || (MPU != 0)) begin: gen_scb_mpu1

         wire [ 2:0] scb = dif_aphase ? {1'b1, dif_cb} : cpu_scb_i;
         assign scb_mpu1 = {3{cfg_mpu}} & scb;

      end else begin: gen_scb_mp1_else

         wire [ 4:0] unused = {dif_cb, cpu_scb_i};
         assign scb_mpu1 = {3{1'b0}};

      end
   endgenerate

   wire [ 2:0] ahb_scb     = scb_mpu0 | scb_mpu1;

   // --------
   // Construct remaining protection signals.

   wire        ahb_priv    = dif_aphase ? dif_priv : cpu_priv_i;
   wire        ahb_dni     = dif_aphase ?     1'b1 : cpu_dni_i;

   // SPECHTRANS provides a means of allowing read invariant memories to
   // speculatively prepare data without waiting for all of the address checks
   // and port decoding to have been performed, i.e. SPECHTRANS may get set
   // without a corresponding HTRANS, but this is the rare-case.

   wire        spec_htrans = cpu_spec_htrans_i | dif_spec_trans;

   // Core instruction fetches to the PPB space are thrown away to prevent
   // NVIC/SCS/debug state corruption; this is faster than having the core
   // AGU factor XN into the ppb_trans traffic; the incoming core HTRANS
   // already has XN factored in, and can therefore simply be ORed with
   // any slave-trans; mask unprivileged PPB accesses from debugger; route
   // transactions to external AHB when not accessing internal (e.g. PPB)
   // resources.

   wire        int_trans  = cpu_trans_i | dif_aphase & dsl_acc_ok_i;
   wire        ext_trans  = cpu_trans_i | dif_aphase & ~(cfg_iop & io_match_i);

   wire        int_sel    = (ahb_addr[31:28] == 4'hE);
   wire        ext_sel    = ~int_sel;

   wire        ppb_trans  = int_trans & int_sel;
   wire        ahb_trans  = ext_trans & ext_sel;

   // -------------------------------------------------------------------------
   // Construct slave port read data
   // -------------------------------------------------------------------------

   // The system control space (SCS) consist of the non-debug parts of the PPB,
   // and is constructed from the ID values and NVIC read data; the core takes
   // PPB data independently from AHB read data due to the requirement to
   // optionally perform endian swizzling on AHB, which is not required on PPB
   // due to it architecturally always being little-endian.

   wire [31:0] scs_rdata = nvm_hrdata_i | mpu_rdata_i | cid_rdata;

   // The SCS values are merged with the debug read-data and AHB data ready for
   // the slave port; the values of the SCS and debug read-data are guaranteed
   // to be zero if not the active data-path.

   wire [31:0] dif_rdata = ( {32{~ppb_active}} & hrdata_i |
                             {32{sel_dcrdr}} & dcrdr_data |
                             scs_rdata );

   // -------------------------------------------------------------------------
   // PPB hwdata_o masking for power conservation
   // -------------------------------------------------------------------------

   // Writes to the PPB space are expected to be very infrequent compared with
   // writes to the AHB bus; to prevent unnecessary toggling within the PPB
   // domain, the write-data is masked unless there is an active write
   // transaction to the PPB.

   wire [31:0] ppb_wdata = {32{ppb_active & ppb_write}} & ahb_wdata;

   // -------------------------------------------------------------------------
   // Instantiate system-control-space decoder
   // -------------------------------------------------------------------------

   // The decoder module generates one-hot selects for each of the addressable
   // registers in the PPB space; in addition, it also generates the core-ID
   // (CID) read-data for all non-configurable value registers in the design.

   cm0p_matrix_sel
     #(.CBAW(CBAW), .DBG(DBG), .SYST(SYST), .MPU(MPU))
   u_sel
     (.hclk               (hclk),
      .hreset_n           (hreset_n),

      .msl_pclk_en_o      (msl_pclk_en_o),

      .msl_ppb_active_o   (msl_ppb_active),
      .msl_ppb_write_o    (ppb_write),
      .msl_nvic_sels_o    (msl_nvic_sels_o[23:0]),
      .msl_mpu_sels_o     (msl_mpu_sels_o[4:0]),
      .msl_sel_dcrdr_o    (sel_dcrdr),
      .msl_dbg_aux_en_o   (msl_dbg_aux_en_o),
      .msl_dbg_op_en_o    (msl_dbg_op_en_o),
      .msl_cid_rdata_o    (cid_rdata[31:0]),

      .hready_i           (hready_i),
      .dsl_cid_sels_i     (dsl_cid_sels_i[1:0]),
      .ppb_trans_i        (ppb_trans),
      .ahb_size_1_i       (ahb_size[1]),
      .dbg_halt_req_i     (dbg_halt_req_i),
      .dif_aphase_i       (dif_aphase),
      .ahb_addr_i         (ahb_addr[31:0]),
      .ahb_write_i        (ahb_write),
      .eco_rev_num_3to0_i (eco_rev_num_3to0_i[3:0]));

   // -------------------------------------------------------------------------
   // Register implementation
   // -------------------------------------------------------------------------

   // If debug is not implemented, then all data-phases belong to the CPU, so
   // optimize out the register.

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_1a

         always @(posedge hclk or negedge hreset_n)
           if(~hreset_n)
             cpu_dphase_q <= 1'b0;
           else if(hready_i)
             cpu_dphase_q <= cpu_dphase_nxt;

      end else begin : gen_dbg_1b

         wire unused = cpu_dphase_nxt;
         wire one = 1'b1;
         always @* cpu_dphase_q = one;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Output assignments
   // -------------------------------------------------------------------------

   // HMASTER is used to identify whether the source of an AHB transaction was
   // the core (1'b0) or the slave-port (1'b1).

   assign      spec_htrans_o    = spec_htrans;

   assign      mtx_ppb_active_o = msl_ppb_active;
   assign      mtx_ppb_write_o  = ppb_write;
   assign      mtx_ppb_wdata_o  = ppb_wdata;

   assign      mtx_cpu_resp_o   = cpu_resp;
   assign      mtx_ppb_hrdata_o = scs_rdata;

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_2a

         assign hmaster_o      = cfg_dbg ? dif_slot : 1'b0;
         assign mtx_dif_slot_o = cfg_dbg ? dif_slot : 1'b0;
         assign mtx_dif_resp_o = cfg_dbg ? hresp_i  : 1'b0;

      end else begin : gen_dbg_2b

         wire unused = dif_slot;
         assign { hmaster_o, mtx_dif_slot_o, mtx_dif_resp_o } = 3'b0;

      end
   endgenerate

   // --------
   // The following AHB-Lite transactions are generated:

   //                          ++-- HTRANS[1:0]
   //                          || ++++-- HPROT[3:0]
   //                          || |||| +-- HMASTER
   //                          || |||| | +++-- HSIZE[2:0]
   //                          || |||| | |||
   //  bus idle                00 CB1X X 0XX
   //  core 16-bit fetch       10 CB10 0 001
   //  core 32-bit fetch       10 CB10 0 010
   //  core word load/store    10 CB11 0 010
   //  core half load/store    10 CB11 0 001
   //  core byte load/store    10 CB11 0 000
   //  debug word read/write   10 CB11 1 010
   //  debug half read/write   10 CB11 1 001
   //  debug byte read/write   10 CB11 1 000

   assign      haddr_o          = ahb_addr;
   assign      hburst_o         = 3'b0;
   assign      hmastlock_o      = 1'b0;
   assign      hprot_o          = { ahb_scb[1:0], ahb_priv, ahb_dni };
   assign      hsize_o          = { 1'b0, ahb_size };
   assign      htrans_o         = { ahb_trans, 1'b0 };
   assign      hwdata_o         = ahb_wdata;
   assign      hwrite_o         = ahb_write;

   assign      shareable_o      = ahb_scb[2];

   // -------------------------------------------------------------------------
   // IO port control
   // -------------------------------------------------------------------------

   wire [31:0] io_addr;
   wire [31:0] io_check;
   wire        io_master, io_priv, io_trans, io_write;
   wire [ 1:0] io_size;
   wire [31:0] io_wdata;

   wire [31:0] dif_rdata_full;
   wire        dif_io_hit;


   // --------
   // Multiplex IO port between core and debugger interface.

   generate
      if((CBAW != 0) || ((DBG != 0) && (IOP != 0))) begin : gen_iop_0a

         wire io_sel_dif = ( cfg_dbg & cfg_iop &
                             ~cpu_spec_htrans_i &
                             ~cpu_dbg_stall_i &
                             dif_spec_trans );

         assign io_addr   = io_sel_dif ? dif_addr   : cpu_io_addr_i;
         assign io_check  = io_sel_dif ? dif_addr   : cpu_io_check_i;
         assign io_master = io_sel_dif;
         assign io_priv   = io_sel_dif ? dif_priv   : cpu_io_priv_i;
         assign io_size   = io_sel_dif ? dif_size   : cpu_io_size_i;
         assign io_trans  = io_sel_dif ? io_match_i : cpu_io_trans_i;
         assign io_wdata  = io_sel_dif ? dif_wdata  : cpu_io_wdata_i;
         assign io_write  = io_sel_dif ? dif_write  : cpu_io_write_i;

         assign dif_rdata_full = io_sel_dif ? io_rdata_i : dif_rdata;
         assign dif_io_hit     = io_sel_dif ? io_match_i : 1'b0;

      end else if(IOP != 0) begin : gen_iop_0b

         wire [32:0] unused = { io_match_i, io_rdata_i[31:0] };

         assign io_addr   = cpu_io_addr_i[31:0];
         assign io_check  = cpu_io_check_i[31:0];
         assign io_master = 1'b0;
         assign io_priv   = cpu_io_priv_i;
         assign io_size   = cpu_io_size_i[1:0];
         assign io_trans  = cpu_io_trans_i;
         assign io_wdata  = cpu_io_wdata_i[31:0];
         assign io_write  = cpu_io_write_i;

         assign dif_rdata_full = dif_rdata;
         assign dif_io_hit     = 1'b0;

      end else begin : gen_iop_0c

         wire [133:0] unused = { cpu_io_addr_i[31:0], cpu_io_check_i[31:0],
                                 cpu_io_priv_i, cpu_io_size_i[1:0],
                                 cpu_io_trans_i, cpu_io_wdata_i[31:0],
                                 cpu_io_write_i, io_match_i, io_rdata_i[31:0]};

         assign { io_addr[31:0], io_check[31:0], io_master, io_priv,
                  io_size[1:0], io_trans, io_wdata[31:0],
                  io_write, dif_io_hit } = 103'b0;

         assign dif_rdata_full = dif_rdata;

      end
   endgenerate

   // --------
   // Propagate or tie-off debug connection from IO port

   generate
      if((CBAW != 0) || (DBG != 0)) begin : gen_dbg_3a

         assign mtx_dif_rdata_o  = cfg_dbg ? dif_rdata_full : 32'b0;
         assign mtx_dif_io_hit_o = cfg_dbg ? dif_io_hit     :  1'b0;

      end else begin : gen_dbg_3b

         wire [32:0] unused = { dif_rdata_full, dif_io_hit };

         assign mtx_dif_rdata_o  = 32'b0;
         assign mtx_dif_io_hit_o =  1'b0;

      end
   endgenerate

   // --------
   // Assign IO port outputs.

   assign      io_addr_o        = io_addr;
   assign      io_check_o       = io_check;
   assign      io_master_o      = io_master;
   assign      io_priv_o        = io_priv;
   assign      io_size_o        = io_size;
   assign      io_trans_o       = io_trans;
   assign      io_wdata_o       = io_wdata;
   assign      io_write_o       = io_write;

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

`include "std_ovl_defines.h"

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
     ( .clock(hclk),
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
     ( .clock(hclk),
       .reset(1'b1),
       .enable(1'b1),
       .qualifier(1'b1),
       .test_expr(cfg_dbg),
       .fire());

   // --------
   // AHB performs write data access size replication; this is not required by
   // the AHB specification.

   reg ahb_w_dphase_b, ahb_w_dphase_h;
   always @(posedge hclk or negedge hreset_n)
     if (!hreset_n) begin
        ahb_w_dphase_b <= 1'b0;
        ahb_w_dphase_h <= 1'b0;
     end else if (hready_i) begin
        ahb_w_dphase_b <= htrans_o[1] & hwrite_o & (hsize_o == 3'h0);
        ahb_w_dphase_h <= htrans_o[1] & hwrite_o & (hsize_o == 3'h1);
     end

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg ("AHB-Lite write data should be replicated for byte accesses"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_wdata_repl_b
     (
      .clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (ahb_w_dphase_b),
      .consequent_expr ((ahb_wdata[31:24] == ahb_wdata[7:0]) &
                        (ahb_wdata[23:16] == ahb_wdata[7:0]) &
                        (ahb_wdata[15: 8] == ahb_wdata[7:0])),
      .fire            ()
   );

   // --------
   // Replication for half-words.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg ("AHB-Lite write data should be replicated for halfword accesses"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_wdata_repl_h
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (ahb_w_dphase_h),
      .consequent_expr (ahb_wdata[31:16] == ahb_wdata[15:0]),
      .fire            ()
      );

   // --------
   // Only a subset of AHB transactions should ever be generated.

   ovl_implication
     #(.severity_level (`OVL_FATAL),
       .property_type  (`OVL_ASSERT),
       .msg ("AHB-Lite master size must be consistent with prot"),
       .coverage_level (`OVL_COVER_DEFAULT),
       .clock_edge     (`OVL_POSEDGE),
       .reset_polarity (`OVL_ACTIVE_LOW),
       .gating_type    (`OVL_GATE_NONE))
   u_asrt_size_ok_for_prot
     (.clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .antecedent_expr (htrans_o[1]),
      .consequent_expr ( hprot_o[0] & (hsize_o == 3'h0 |
                                       hsize_o == 3'h1 |
                                       hsize_o == 3'h2) |
                        ~hprot_o[0] & (hsize_o == 3'h1 |
                                       hsize_o == 3'h2)),
      .fire            ()
      );

   // --------
   // cpu_wdata and dif_wdata must not be non-zero at the same time.

   ovl_zero_one_hot #(
      .severity_level  (`OVL_FATAL),
      .width           (2),
      .property_type   (`OVL_ASSERT_2STATE),
      .msg ("cpu_wdata and dif_wdata must not be non-zero at the same time"),
      .coverage_level  (`OVL_COVER_DEFAULT),
      .clock_edge      (`OVL_POSEDGE),
      .reset_polarity  (`OVL_ACTIVE_LOW),
      .gating_type     (`OVL_GATE_NONE)
   ) u_wdata_zoh (
      .clock           (hclk),
      .reset           (hreset_n),
      .enable          (1'b1),
      .test_expr       ({|cpu_hwdata_i, |dif_wdata_i}),
      .fire            ()
   );

   // --------
   // Accesses into the SCS/PPB do not use the AHB interface, and as such can
   // not result in AHB errors.

    ovl_implication
    #(.severity_level (`OVL_FATAL),
      .property_type  (`OVL_ASSERT),
      .msg            ("SCS accesses cannot cause AHB bus faults"),
      .coverage_level (`OVL_COVER_DEFAULT),
      .clock_edge     (`OVL_POSEDGE),
      .reset_polarity (`OVL_ACTIVE_LOW),
      .gating_type    (`OVL_GATE_NONE))
    u_asrt_scs_acc_noahb
    ( .clock            (hclk),
      .reset            (hreset_n),
      .enable           (1'b1),
      .antecedent_expr  (u_sel.scs_active),
      .consequent_expr  (hready_i & ~hresp_i),
      .fire());

`endif

   // -------------------------------------------------------------------------

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
