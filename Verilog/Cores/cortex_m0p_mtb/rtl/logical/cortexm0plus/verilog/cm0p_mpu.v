//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2011-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-08-28 17:48:29 +0100 (Tue, 28 Aug 2012) $
//   Revision   : $Revision: 220356 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ MEMORY PROTECTION UNIT
//-----------------------------------------------------------------------------

module cm0p_mpu
  #(parameter CBAW = 0,
    parameter IOP  = 0,
    parameter MPU  = 0,
    parameter RAR  = 0)

   (// Clock and reset

    input  wire        pclk,                // PPB clock, only used for updates
    input  wire        reset_n,             // System reset

    // Lookup request interface

    input  wire [26:0] cpu_addr_a_31to5_i,  // Lookup A address
    input  wire [26:0] cpu_addr_b_31to5_i,  // Lookup B address
    input  wire        cpu_dni_a_i,         // Lookup A is data not instruction
    input  wire        cpu_write_a_i,       // Lookup A is write not read
    input  wire        cpu_vectread_a_i,    // Lookup A is a vector fetch
    input  wire        cpu_priv_i,          // Mode is privileged
    input  wire        cpu_hfnmi_i,         // Exception is Hardfault or NMI

    output wire        mpu_fault_a_o,       // Lookup A would fault
    output wire        mpu_fault_b_o,       // Lookup B would fault
    output wire [ 2:0] mpu_scb_a_o,         // Attributes for lookup A
    output wire [ 2:0] mpu_scb_b_o,         // Attributes for lookup B

    // Register access interface

    input  wire [ 4:0] acc_sel_i,           // Control register selection
    input  wire        acc_write_i,         // Write control register
    input  wire [31:0] acc_wdata_i,         // Register write data

    output wire [31:0] acc_rdata_o);        // Register read data

   // -------------------------------------------------------------------------
   // Configurability
   // -------------------------------------------------------------------------

   wire       cfg_iop, cfg_mpu, cfg_rar;

   generate
      if(CBAW == 0) begin: gen_cbaw
         assign cfg_iop = (IOP != 0);
         assign cfg_mpu = (MPU != 0);
         assign cfg_rar = (RAR != 0);
      end
   endgenerate

   // ---------
   // Use configuration to determine number of MPU regions to construct and
   // how many sets of comparators are required. If an IO port is present, the
   // one set is required for AHB and a second for the IO port itself.

   localparam L_MPU          = ((MPU != 0) || (CBAW != 0)) ? 8 : 0;
   localparam L_NUM_ADDR     = ((IOP != 0) || (CBAW != 0)) ? 2 : 1;
   localparam L_NUM_ADDR_MAX = 2;

   // Turn cfg_iop into format better suited for use in for loops.

   wire [L_NUM_ADDR_MAX-1:0] cfg_numaddr = { cfg_iop, 1'b1 };

   // -------------------------------------------------------------------------
   // Generate optional reset
   // -------------------------------------------------------------------------

   // Not all of the registers are required to be reset by the architecture.
   // The implementation may be configured to reset all registers with the
   // reset used being HRESETn. This signal is only used in RAR configs.

   wire rar_reset_n = ~cfg_rar | reset_n;

   // -------------------------------------------------------------------------
   // Function - address region and subregion hit
   // -------------------------------------------------------------------------

   // Region hit:
   // Compare relevant top bits between target address and register programmed
   // address.

   // Subregion hit:
   // Extract 3 relevant bits of target address and check corresponding
   // register SRD bit value; after masking all other address bits: end up
   // with 0*CBA0*; after 4-bit OR reduction to create index: get one pattern,
   // which is 0CBA rotated by an amount based on the alignment of the three
   // address bits to the 4-bit boundary used for OR reduction; based on the
   // pattern, only certain index values are possible, and for each index
   // corresponds an SRD bit number.

   // PATTERN | ROTATION AMOUNT | Possible indices (from 15 to 0) and
   //         |                 | corresponding SRD bit number
   //    0CBA |               0 | ________ 76543210
   //    CBA0 |               1 | _7_6_5_4 _3_2_1_0
   //    BA0C |               2 | __73__62 __51__40
   //    A0CB |               3 | ____7531 ____6420


   // Function is split to reuse address-independent logic for all interfaces.

   function [66:0] f_regsubreg_hit_prep
     (input        i_enable,
      input [ 4:0] i_size,
      input [ 7:0] i_srd);

      reg [ 4:0]   i_size_int;
      reg [31:0]   i_rmask;
      reg [26:0]   i_srmask; //same width as target
      reg [ 3:0]   i_srrot;
      reg [15:0]   i_srval;

      begin

         // -------------------------------------------------------------------
         // Region hit
         // -------------------------------------------------------------------

         // Force size to max when not enabled (to reduce power).

         i_size_int = i_size | {5{~i_enable}};

         // Address mask to force all non-region-hit-relevant bits to 0.

         i_rmask = { {31{1'b1}}, 1'b0 } << i_size_int;

         // -------------------------------------------------------------------
         // Subregion hit
         // -------------------------------------------------------------------

         // Address mask to force all non-subregion-hit-relevant bits to 0.

         i_srmask = { {3{1'b1}}, i_rmask[31:8] } & ~i_rmask[31:5];

         // Rotation amount (size 0 corresponds to rotation 3).

         i_srrot  = { i_size_int[1:0] == 2'b10, i_size_int[1:0] == 2'b01,
                      i_size_int[1:0] == 2'b00, i_size_int[1:0] == 2'b11 };

         // Array to index into to select appropriate SRD bit value.

         i_srval  = { 1'b0,                                           //1111
                      i_srd[7],                                       //1110
                      i_srd[7],                                       //1101
                      i_srrot[1] & i_srd[6] | i_srrot[2] & i_srd[3],  //1100
                      i_srd[7],                                       //1011
                      i_srd[5],                                       //1010
                      i_srrot[2] & i_srd[6] | i_srrot[3] & i_srd[3],  //1001
                      i_srrot[1] & i_srd[4] | i_srrot[2] & i_srd[2] |
                      i_srrot[3] & i_srd[1],                          //1000
                      i_srd[7],                                       //0111
                      i_srrot[0] & i_srd[6] | i_srrot[1] & i_srd[3],  //0110
                      i_srd[5],                                       //0101
                      i_srrot[0] & i_srd[4] | i_srrot[1] & i_srd[2] |
                      i_srrot[2] & i_srd[1],                          //0100
                      i_srrot[0] & i_srd[3] | i_srrot[3] & i_srd[6],  //0011
                      i_srrot[0] & i_srd[2] | i_srrot[1] & i_srd[1] |
                      i_srrot[3] & i_srd[4],                          //0010
                      i_srrot[0] & i_srd[1] | i_srrot[2] & i_srd[4] |
                      i_srrot[3] & i_srd[2],                          //0001
                      i_srd[0] };                                     //0000

         // -------------------------------------------------------------------
         // Assign result
         // -------------------------------------------------------------------

         f_regsubreg_hit_prep = { i_rmask[31:8],
                                  i_srmask[26:0],
                                  i_srval[15:0] };

      end
   endfunction

   // ----------------------------------------------------------------------
   // Function to take prepared data and address and determine hit
   // ----------------------------------------------------------------------

   function f_regsubreg_hit
     (input        i_enable,
      input [23:0] i_base,     // [31:8]
      input [26:0] i_target,   // [31:(8-3=5)]
      input [66:0] i_prep_data);

      reg [23:0]   i_rmask_31to8;
      reg [26:0]   i_srmask; // Same width as target
      reg [15:0]   i_srval;
      reg          i_rhit;
      reg [26:0]   i_srbits; // Same width as target
      reg [ 3:0]   i_sridx;
      reg          i_srhit;

      begin

         // -------------------------------------------------------------------
         // Breakout result of prepared data function to independent values
         // -------------------------------------------------------------------

         { i_rmask_31to8, i_srmask, i_srval } = i_prep_data;

         // -------------------------------------------------------------------
         // Primary region hit detection
         // -------------------------------------------------------------------

         // Compare relevant bits of lookup address and region base address.

         i_rhit  = ~|((i_target[26:3] ^ i_base) & i_rmask_31to8);

         // -------------------------------------------------------------------
         // Subregion hit
         // -------------------------------------------------------------------

         // Apply srmask to address; all bits except 3 bits relevant for
         // subregion hit forced to 0.

         i_srbits = i_target[26:0] & i_srmask;

         // Create index by OR reducing every 4th bit together.

         i_sridx  = { i_srbits[ 3] | i_srbits[ 7] | i_srbits[11] |
                      i_srbits[15] | i_srbits[19] | i_srbits[23],
                      i_srbits[ 2] | i_srbits[ 6] | i_srbits[10] |
                      i_srbits[14] | i_srbits[18] | i_srbits[22] |
                      i_srbits[26],
                      i_srbits[ 1] | i_srbits[ 5] | i_srbits[ 9] |
                      i_srbits[13] | i_srbits[17] | i_srbits[21] |
                      i_srbits[25],
                      i_srbits[ 0] | i_srbits[ 4] | i_srbits[ 8] |
                      i_srbits[12] | i_srbits[16] | i_srbits[20] |
                      i_srbits[24] };

         i_srhit  = ~i_srval[i_sridx];

         f_regsubreg_hit = i_enable & i_rhit & i_srhit;

      end
   endfunction

   // ----------------------------------------------------------------------
   // Function to determine region permissions for default memory map
   // ----------------------------------------------------------------------

   function f_reg_fault_ap
     (input [ 2:0] i_ap,
      input        i_priv,
      input        i_dni,
      input        i_str);

      begin
         case (i_ap)
           3'b000 : f_reg_fault_ap = 1'b1;
           3'b001 : f_reg_fault_ap = ~i_priv;
           3'b010 : f_reg_fault_ap = ~i_priv & i_dni & i_str;
           3'b011 : f_reg_fault_ap = 1'b0;
           3'b100 : f_reg_fault_ap = 1'b1; // Architecturally UNPREDICTABLE
           3'b101 : f_reg_fault_ap = ~i_priv | (i_dni & i_str);
           3'b110 : f_reg_fault_ap = i_dni & i_str;
           3'b111 : f_reg_fault_ap = i_dni & i_str;
           default: f_reg_fault_ap = 1'bx;
         endcase
      end
   endfunction

   // ----------------------------------------------------------------------
   // Function to determine default memory map bus memory attributes
   // ----------------------------------------------------------------------

   function [2:0] f_dmm_scb (input [2:0] i_addr_31to29);
      begin
         case (i_addr_31to29)
           3'h0   : f_dmm_scb = 3'b010; // NS N-C-WT
           3'h1   : f_dmm_scb = 3'b011; // NS N-C-WBWA
           3'h2   : f_dmm_scb = 3'b001; // NS Device
           3'h3   : f_dmm_scb = 3'b011; // NS N-C-WBWA
           3'h4   : f_dmm_scb = 3'b010; // NS N-C-WT
           3'h5   : f_dmm_scb = 3'b101; //  S Device
           3'h6   : f_dmm_scb = 3'b001; // NS Device
               // Strictly, addr[31:20] == E00 => scb == 3'b100 (S SO)
               // However, this address is never visible on AHB.
           3'h7   : f_dmm_scb = 3'b001; // NS Device
           default: f_dmm_scb = 3'bxxx;
         endcase
      end
   endfunction

   // ----------------------------------------------------------------------
   // Function to determine default memory map XN attribute
   // ----------------------------------------------------------------------

   function f_dmm_xn (input [2:0] i_addr_31to29);
      begin
         case (i_addr_31to29)
           3'h0, 3'h1, 3'h3, 3'h4: f_dmm_xn = 1'b0;
           3'h2, 3'h5, 3'h6, 3'h7: f_dmm_xn = 1'b1;
           default               : f_dmm_xn = 1'bx;
         endcase
      end
   endfunction

   // -------------------------------------------------------------------------
   // Map inputs into memory protection checks
   // -------------------------------------------------------------------------

   // The processor generates two addresses; "A" is the only interface used if
   // the IO port is not present and can generate all forms of read/write,
   // instruction and data. The "B" interface is only used if the IO port is
   // present, and is used only for instruction fetches, thus can never be a
   // data transaction and thus a write.

   // Map addresses to permit array use.

   wire [31:0] cpu_addr [L_NUM_ADDR_MAX-1:0];

   assign cpu_addr[0] = { cpu_addr_a_31to5_i, 5'b0 };
   assign cpu_addr[1] = { cpu_addr_b_31to5_i, 5'b0 };

   // --------
   // Map whether the transaction to be looked up is an instruction fetch or
   // data. Note interface "B" always for instruction fetch.

   wire [L_NUM_ADDR_MAX-1:0] cpu_dni      = { 1'b0, cpu_dni_a_i };

   // --------
   // Map whether the transaction to be looked up is a read or write. Note that
   // interface "B" can only be an instruction fetch thus never a write.

   wire [L_NUM_ADDR_MAX-1:0] cpu_write    = { 1'b0, cpu_write_a_i };

   // --------
   // Vector fetches always bypass the MPU; map whether the transactions to be
   // loocked up are vector fetches. Note that interface "B" never has vector
   // fetches performed on it.

   wire [L_NUM_ADDR_MAX-1:0] cpu_vectread = { 1'b0, cpu_vectread_a_i };

   // -------------------------------------------------------------------------
   // Generate MPU region state and comparators
   // -------------------------------------------------------------------------

   // Declare generate loop indices.

   genvar g_r;  // Region number iterator 0..7
   genvar g_n;  // Lookup number iterator 0..1

   // --------
   // Tie off unused signals to facilitate linting.

   generate
      if(L_MPU != 0) begin: gen_unused_0

         wire [1:0] unused = acc_wdata_i[7:6];

         for(g_n = 0; g_n < L_NUM_ADDR_MAX; g_n = g_n + 1) begin: gen_unused_1
            if(g_n < L_NUM_ADDR) begin: gen_unused_2
               // None to be added.
            end else begin: gen_unused_3

               wire [34:0] unused = { cpu_addr[g_n][31:0], cpu_dni[g_n],
                                      cpu_write[g_n], cpu_vectread[g_n] };

            end
         end

      end else begin: gen_unused_4

         wire [41:0] unused = { pclk, reset_n, cpu_hfnmi_i, acc_sel_i[4:0],
                                acc_write_i, acc_wdata_i[31:0], rar_reset_n };

         for(g_n = 0; g_n < L_NUM_ADDR_MAX; g_n = g_n + 1) begin: gen_unused_5

            wire [2:0] unused = { cfg_numaddr[g_n], cpu_write[g_n],
                                  cpu_vectread[g_n] };

            if (g_n < L_NUM_ADDR) begin: gen_unused_6
               // None to be added.
            end else begin: gen_unused_7

               wire [28:0] unused = { cpu_addr[g_n][27:0], cpu_dni[g_n] };

            end
         end
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Functions and signals used whether MPU present or not
   // -------------------------------------------------------------------------

   // System and PPB address decoder

   wire [L_NUM_ADDR-1:0] addr_sys;
   wire [L_NUM_ADDR-1:0] addr_ppb;

   generate
      for(g_n = 0; g_n < L_NUM_ADDR; g_n = g_n + 1) begin: gen_addr_sys_ppb

         assign addr_sys[g_n] = (cpu_addr[g_n][31:29] == 3'b111);
         assign addr_ppb[g_n] = addr_sys[g_n] & ~cpu_addr[g_n][28];

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Main logic only generated when MPU present
   // -------------------------------------------------------------------------

   wire [L_NUM_ADDR_MAX-1:0] mpu_fault;
   wire [2:0]                mpu_scb [L_NUM_ADDR_MAX-1:0];

   generate
      if(L_MPU != 0) begin: gen_mpu

         // -------------------------------------------------------------------
         // MPU architectural register state
         // -------------------------------------------------------------------

         // MPU global registers:

         reg             privdefena_q;  // Default enabled for Privileged code
         reg             hfnmiena_q;    // Hardfault/NMI enables default map
         reg             genable_q;     // MPU global enable

         reg [      2:0] region_q;      // Currently active region number

         // --------
         // Per MPU region registers:

         reg [     23:0] addr_q [L_MPU-1:0];  // Address base bits [31:8]
         reg [L_MPU-1:0] xn_q;                // Region is execute-never
         reg [      2:0] ap_q [L_MPU-1:0];    // Region access permissions
         reg [      2:0] scb_q [L_MPU-1:0];   // Region memory attribtues
         reg [      7:0] srd_q [L_MPU-1:0];   // Subregion disables
         reg [      4:0] size_q [L_MPU-1:0];  // Region size
         reg [L_MPU-1:0] renable_q;           // Region enables

         // -------------------------------------------------------------------
         // Register read logic
         // -------------------------------------------------------------------

         wire [31:0]     mpu_type = { 8'b0, 8'b0, L_MPU[7:0], 8'b0 };

         wire [31:0]     mpu_ctrl = { 29'b0, privdefena_q, hfnmiena_q,
                                      genable_q };

         wire [31:0]     mpu_rnr  = { 29'b0, region_q };
         wire [31:0]     mpu_rbar = { addr_q[region_q], 5'b0, region_q };

         wire [31:0]     mpu_rasr = { 3'b0, xn_q[region_q], 1'b0,
                                      ap_q[region_q], 5'b0, scb_q[region_q],
                                      srd_q[region_q], 2'b0, size_q[region_q],
                                      renable_q[region_q] };

         // --------
         // Support for CBAW - mask register access when there is no MPU.

         wire [ 4:0]     acc_sel = acc_sel_i & {5{cfg_mpu}};

         wire            acc_sel_type = acc_sel[4];
         wire            acc_sel_ctrl = acc_sel[3];
         wire            acc_sel_rnr  = acc_sel[2];
         wire            acc_sel_rbar = acc_sel[1];
         wire            acc_sel_rasr = acc_sel[0];

         // --------
         // Mux final read data via OR of ANDs to ensure 0 when no access.

         assign acc_rdata_o = ({32{acc_sel_type}} & mpu_type) |
                              ({32{acc_sel_ctrl}} & mpu_ctrl) |
                              ({32{acc_sel_rnr }} & mpu_rnr ) |
                              ({32{acc_sel_rbar}} & mpu_rbar) |
                              ({32{acc_sel_rasr}} & mpu_rasr);

         // -------------------------------------------------------------------
         // Register write logic and register creation
         // -------------------------------------------------------------------

         // MPU global registers:

         // --------
         // privdefena_q, hfnmiena_q, genable_q

         wire            genable_en = acc_write_i & acc_sel_ctrl;

         always @(posedge pclk or negedge reset_n)
           if (~reset_n)
             { privdefena_q, hfnmiena_q, genable_q } <= 3'b0;
           else if (genable_en)
             { privdefena_q, hfnmiena_q, genable_q } <= acc_wdata_i[2:0];

         // --------
         // region_q

         wire            region_en = ( acc_write_i &
                                       (acc_sel_rnr |
                                        (acc_sel_rbar & acc_wdata_i[4])) );

         always @(posedge pclk or negedge rar_reset_n)
           if (~rar_reset_n)
             region_q <= {3{1'b1}};
           else if (region_en)
             region_q <= acc_wdata_i[2:0];


         // --------
         // Per region registers:

         for(g_r = 0; g_r < L_MPU; g_r = g_r + 1) begin: gen_mpu_region_regs

            // --------
            // addr_q

            wire addr_en = ( acc_write_i & acc_sel_rbar &
                             ( ( acc_wdata_i[4] &
                                 (acc_wdata_i[2:0] == g_r[2:0]) ) |
                               ( ~acc_wdata_i[4] &
                                 (region_q         == g_r[2:0]) ) ) );

            always @(posedge pclk or negedge rar_reset_n)
              if (~rar_reset_n)
                addr_q[g_r] <= {24{1'b1}};
              else if (addr_en)
                addr_q[g_r] <= acc_wdata_i[31:8];

            // --------
            // xn_q, ap_q, scb_q, srd_q, size_q

            wire renable_en = ( acc_write_i & acc_sel_rasr &
                                (region_q == g_r[2:0]) );

            always @(posedge pclk or negedge rar_reset_n)
              if (~rar_reset_n) begin
                 xn_q  [g_r] <= {1{1'b1}};
                 ap_q  [g_r] <= {3{1'b1}};
                 scb_q [g_r] <= {3{1'b1}};
                 srd_q [g_r] <= {8{1'b1}};
                 size_q[g_r] <= {5{1'b1}};
              end else if (renable_en) begin
                 xn_q  [g_r] <= acc_wdata_i[   28];
                 ap_q  [g_r] <= acc_wdata_i[26:24];
                 scb_q [g_r] <= acc_wdata_i[18:16];
                 srd_q [g_r] <= acc_wdata_i[15: 8];
                 size_q[g_r] <= acc_wdata_i[ 5: 1];
              end

            // --------
            // renable_q

            // The individual region enables are always reset even though this
            // is not required by the architecture.

            always @(posedge pclk or negedge reset_n)
              if (~reset_n)
                renable_q[g_r] <= 1'b0;
              else if (renable_en)
                renable_q[g_r] <= acc_wdata_i[0];

         end

         // End of per region registers.
         // --------


         // -------------------------------------------------------------------
         // Lookup - register defined region hit - interface-independent
         // -------------------------------------------------------------------

         wire [66:0] regsubreg_hit_prep [L_MPU-1:0];

         for(g_r = 0; g_r < L_MPU; g_r = g_r + 1) begin: gen_regsubreg_hit_prep

            assign regsubreg_hit_prep[g_r] =
              f_regsubreg_hit_prep( genable_q & renable_q[g_r],
                                    size_q[g_r],
                                    srd_q[g_r]);

         end

         // -------------------------------------------------------------------
         // Lookup - register defined region hit - interface-dependent
         // -------------------------------------------------------------------

         for (g_n = 0; g_n < L_NUM_ADDR_MAX; g_n = g_n + 1) begin: gen_numaddr

            if (g_n < L_NUM_ADDR) begin: gen_present

               // --------
               // Compute per-region hit, fault and scb in parallel.

               wire [L_MPU-1:0] reg_hit;
               wire [L_MPU-1:0] reg_flt;
               wire [2:0]       reg_scb [L_MPU-1:0];

               for (g_r = 0; g_r < L_MPU; g_r = g_r + 1) begin: gen_region

                  assign reg_hit[g_r] =
                    f_regsubreg_hit( renable_q[g_r],
                                     addr_q[g_r],
                                     cpu_addr[g_n][31:5],
                                     regsubreg_hit_prep[g_r]);

                  wire reg_flt_ap =
                    f_reg_fault_ap( ap_q[g_r],
                                    cpu_priv_i,
                                    cpu_dni[g_n],
                                    cpu_write[g_n]);

                  wire reg_flt_xn = ~cpu_dni[g_n] & xn_q[g_r];

                  assign reg_flt[g_r] = reg_flt_ap | reg_flt_xn;
                  assign reg_scb[g_r] = scb_q[g_r];
               end

               // --------
               // Cascade mux based on hit to end up with highest region that
               // hits.

               wire [3:0] reg_hit_oo2 = { |reg_hit    [7:6],
                                          |reg_hit    [5:4],
                                          |reg_hit    [3:2],
                                          |reg_hit    [1:0] };

               wire [1:0] reg_hit_oo4 = { |reg_hit_oo2[3:2],
                                          |reg_hit_oo2[1:0] };

               wire       reg_hit_oo8 =   |reg_hit_oo4[1:0]  ;

               wire [3:0] reg_flt_oo2 = { reg_hit    [6+1] ? reg_flt    [6+1] :
                                                             reg_flt    [6],
                                          reg_hit    [4+1] ? reg_flt    [4+1] :
                                                             reg_flt    [4],
                                          reg_hit    [2+1] ? reg_flt    [2+1] :
                                                             reg_flt    [2],
                                          reg_hit    [0+1] ? reg_flt    [0+1] :
                                                             reg_flt    [0] };

               wire [1:0] reg_flt_oo4 = { reg_hit_oo2[2+1] ? reg_flt_oo2[2+1] :
                                                             reg_flt_oo2[2],
                                          reg_hit_oo2[0+1] ? reg_flt_oo2[0+1] :
                                                             reg_flt_oo2[0] };

               wire       reg_flt_oo8 =   reg_hit_oo4[0+1] ? reg_flt_oo4[0+1] :
                                                             reg_flt_oo4[0]  ;

               wire [2:0] reg_scb_oo2 [3:0];

               assign reg_scb_oo2[3]  =   reg_hit    [6+1] ? reg_scb    [6+1] :
                                                             reg_scb    [6];

               assign reg_scb_oo2[2]  =   reg_hit    [4+1] ? reg_scb    [4+1] :
                                                             reg_scb    [4];

               assign reg_scb_oo2[1]  =   reg_hit    [2+1] ? reg_scb    [2+1] :
                                                             reg_scb    [2];

               assign reg_scb_oo2[0]  =   reg_hit    [0+1] ? reg_scb    [0+1] :
                                                             reg_scb    [0];

               wire [2:0] reg_scb_oo4 [1:0];

               assign reg_scb_oo4[1]  =   reg_hit_oo2[2+1] ? reg_scb_oo2[2+1] :
                                                             reg_scb_oo2[2];

               assign reg_scb_oo4[0]  =   reg_hit_oo2[0+1] ? reg_scb_oo2[0+1] :
                                                             reg_scb_oo2[0];

               wire [2:0] reg_scb_oo8 =   reg_hit_oo4[0+1] ? reg_scb_oo4[0+1] :
                                                             reg_scb_oo4[0];

               // --------
               // SO and DEV regions are always shareable.

               wire [2:0] reg_scb_final = reg_scb_oo8 | {~reg_scb_oo8[1], 2'b0};

               // --------
               // Select between region fault/scb and others.

               wire       dmm_en_only = ( addr_ppb[g_n] |
                                          cpu_vectread[g_n] |
                                          (cpu_hfnmi_i & ~hfnmiena_q) );

               wire       dmm_en_back = cpu_priv_i & privdefena_q;
               wire       reg_en      = cfg_mpu & genable_q & ~dmm_en_only;
               wire       dmm_en      = ~reg_en | dmm_en_back;
               wire       dmm_flt_ap  = ~cpu_priv_i & addr_ppb[g_n];

               wire       dmm_flt_xn  = ( ~cpu_dni[g_n] &
                                          f_dmm_xn(cpu_addr[g_n][31:29]) );

               wire       dmm_flt     = dmm_flt_ap | dmm_flt_xn;
               wire       always_flt  = ~cpu_dni[g_n] & addr_sys[g_n];
               wire       nonreg_flt  = ~dmm_en | dmm_flt | always_flt;
               wire       reg_hit_en  = reg_en & reg_hit_oo8;
               wire       use_reg_flt = reg_hit_en & ~always_flt;
               wire       use_reg_scb = reg_hit_en;

               wire       flt         = use_reg_flt ? reg_flt_oo8 : nonreg_flt;

               wire [2:0] scb = use_reg_scb ? reg_scb_final :
                                              f_dmm_scb(cpu_addr[g_n][31:29]);

               assign mpu_fault[g_n] = flt &              cfg_numaddr[g_n];
               assign mpu_scb  [g_n] = scb & {3{cfg_mpu & cfg_numaddr[g_n]}};

            end else begin: gen_mpu_numaddr_not_present

               // --------
               // No interface, so just tie off.

               assign mpu_fault[g_n] = 1'b0;
               assign mpu_scb  [g_n] = 3'b0;

            end
         end
      end else begin: gen_no_mpu

         wire unused = cfg_mpu;

         // --------
         // No registers, so just tie off.

         assign acc_rdata_o = 32'b0;

         for(g_n = 0; g_n < L_NUM_ADDR_MAX; g_n = g_n + 1) begin: gen_no_numaddr

            if (g_n < L_NUM_ADDR) begin: gen_no_present

               // --------
               // Use default memory map.

               wire dmm_flt_ap = ~cpu_priv_i & addr_ppb[g_n];

               wire dmm_flt_xn = ( ~cpu_dni[g_n] &
                                   f_dmm_xn(cpu_addr[g_n][31:29]) );

               wire dmm_flt    = dmm_flt_ap | dmm_flt_xn;

               assign mpu_fault[g_n] = dmm_flt;

            end else begin: gen_no_numaddr_not_present

               // --------
               // No interface, so just tie off.

               assign mpu_fault[g_n] = 1'b0;

            end

            // --------
            // Default memory map attributes computed in matrix when no MPU.

            assign mpu_scb[g_n] = 3'b0;

         end
      end
   endgenerate

   assign mpu_fault_a_o = mpu_fault[0];
   assign mpu_fault_b_o = mpu_fault[1];
   assign mpu_scb_a_o   = mpu_scb  [0];
   assign mpu_scb_b_o   = mpu_scb  [1];

`ifdef ARM_ASSERT_ON
   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

 `include "std_ovl_defines.h"

   genvar g0;

   generate
      for (g0 = 0; g0 < L_MPU; g0 = g0 + 1) begin: gen_ovl_regions

         // --------
         // Check register enables never unknown.

         ovl_never_unknown
           #(.severity_level (`OVL_FATAL),
             .width          (2),
             .property_type  (`OVL_ASSERT),
             .msg            ("Register enables must never be X"),
             .coverage_level (`OVL_COVER_DEFAULT),
             .clock_edge     (`OVL_POSEDGE),
             .reset_polarity (`OVL_ACTIVE_LOW),
             .gating_type    (`OVL_GATE_NONE))
         u_ovl_reg_en_nx_r
           (.clock     (pclk),
            .reset     (reset_n),
            .enable    (1'b1),
            .qualifier (1'b1),
            .test_expr ({ gen_mpu.gen_mpu_region_regs[g0].addr_en,
                          gen_mpu.gen_mpu_region_regs[g0].renable_en }),
            .fire      ());

         ovl_always
           #(.severity_level (`OVL_INFO),
             .property_type  (`OVL_ASSERT),
             .msg ("Software should program region size to 256 bytes or more"),
             .coverage_level (`OVL_COVER_DEFAULT),
             .clock_edge     (`OVL_POSEDGE),
             .reset_polarity (`OVL_ACTIVE_LOW),
             .gating_type    (`OVL_GATE_NONE))
         u_ovl_info_size_256bplus
           (.clock     (pclk),
            .reset     (reset_n),
            .enable    (gen_mpu.genable_q & gen_mpu.renable_q[g0]),
            .test_expr (gen_mpu.size_q[g0] >= 5'd7),
            .fire      ());

      end
   endgenerate

   // --------
   // Check that PPB read data is zero if no transaction.

   ovl_implication
     #(.severity_level  (`OVL_FATAL),
       .property_type   (`OVL_ASSERT_2STATE), // accesses to non-reset register
                                              // before initialized will cause
                                              // X on rdata
       .msg ("Read data must be 0 when there is no register access"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))
   u_ovl_rdata_a_no_r_acc
     (.clock           (pclk),
      .reset           (reset_n),
      .enable          (1'b1),
      .antecedent_expr (~|acc_sel_i),
      .consequent_expr (~|acc_rdata_o),
      .fire            ());

   // --------
   // Register enable X check.

   generate
      if(L_MPU != 0) begin: ovl_gen_mpu

         ovl_never_unknown
           #(.severity_level  (`OVL_FATAL),
             .width           (2),
             .property_type   (`OVL_ASSERT),
             .msg ("Register enables must never be X"),
             .coverage_level  (`OVL_COVER_DEFAULT),
             .clock_edge      (`OVL_POSEDGE),
             .reset_polarity  (`OVL_ACTIVE_LOW),
             .gating_type     (`OVL_GATE_NONE))
         u_ovl_reg_en_nx_g
           (.clock           (pclk),
            .reset           (reset_n),
            .enable          (1'b1),
            .qualifier       (1'b1),
            .test_expr       ({ gen_mpu.genable_en,
                                gen_mpu.region_en }),
            .fire            ());

      end
   endgenerate

`endif

endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
