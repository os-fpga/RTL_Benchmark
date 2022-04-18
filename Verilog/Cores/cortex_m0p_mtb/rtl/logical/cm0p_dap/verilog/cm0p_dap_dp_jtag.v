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
//   Checked In : $Date: 2012-01-10 12:02:06 +0000 (Tue, 10 Jan 2012) $
//   Revision   : $Revision: 197285 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_dap_dp_jtag
  #(parameter CBAW    = 0,
    parameter JTAGnSW = 0,
    parameter HALTEV  = 0,  //1 -> Debug halt event is supported
    parameter RAR     = 0
    )
   (//Clocks and resets
    input  wire        tck,                  //JTAG Clock
    input  wire        dpreset_n,            //DP PO Reset

    //JTAG Connections
    input  wire        n_trst,               //JTAG State Machine Reset
    input  wire        tdi_i,                //JTAG Data In
    input  wire        tms_i,                //JTAG Test Mode Select
    output wire        tdo_o,                //JTAG Data Out
    output wire        n_tdoen_o,            //TDO Output Enable

    //Internal DAP Connections
    // - To Transfer Module
    output wire [31:0] dp_data_dp_o,         //Data from DP to AP for AP transaction
    output wire  [3:0] dp_regaddr_dp_o,      //AP Register Address for an AP Transaction
    output wire        dp_rnw_dp_o,          //RnW For AP Transaction
    output wire        dp_wr_en_o,           //Load transfer register with above data
    output wire        dp_out_en_o,          //Mask for ap_data_dp_i input
    output wire        dp_err_out_en_o,      //Mask for ap_err_dp_i input

    // - From Transfer Module
    input  wire [31:0] ap_data_dp_i,         //Returned data from result of AP transaction
    input  wire        ap_err_dp_i,          //Error response from AP transaction

    // - Debug Halt Event
    input  wire        halted_n_i,           //Processor halted (active low)

    // - Synchronisation Handshake Signals
    input  wire        ap_ack_dp_i,          //Transaction complete acknowledge from AP
    input  wire        dp_req_dp_i,          //Request AP to complete a transaction
    output wire        dp_req_dp_load_o,     //Load Enable for dp_req_dp register in CDC block

    //Power Management Connections
    input  wire        csyspwrupack_sync_i,  //Sync'd System Power Domain Power Up Ack
    input  wire        dp_cs_cdbgpwrupack_i, //Debug Power Domain Power Up Ack for CSR
    output wire        csyspwrupreq_o,       //System Power Domain Power Up Request
    output wire        dp_cs_cdbgpwrupreq_o, //Debug Power Domain Power Up Request

    input  wire        reset_dp_ap_handshake_i,

    input  wire  [3:0] ecorevnum_i           // Configurable Revision field of DPIDR
    );

// ----------------------------------------------------------------------------
// `define's
// ----------------------------------------------------------------------------
//  `include "cm0p_dap_dp_jtag_defs.v"

// ----------------------------------------------------------------------------
// Configurablility
// ----------------------------------------------------------------------------
  wire     cfg_haltev;
  wire     cfg_rar;

  generate
    if (CBAW == 0) begin : gen_cbaw
      assign cfg_haltev = (HALTEV != 0);
      assign cfg_rar    = (RAR    != 0);
    end
  endgenerate

// ----------------------------------------------------------------------------
// Signal Declarations
// ----------------------------------------------------------------------------
  // Registers which do not usually have a reset term will use this reset
  // signal, connected to dpreset_n or tied high depending on whether Reset
  // All Registers (RAR) is required.
  wire        rar_reset_n = cfg_rar ? dpreset_n : 1'b1;

  reg         tdo;                //TDO is registered and driven off tckn
  wire        n_tdoen;
  wire [31:0] dp_data_dp;
  wire [3:0]  dp_regaddr_dp;
  wire        dp_rnw_dp;
  wire        dp_wr_en;
  wire        dp_out_en;
  wire        dp_err_out_en;
  reg         dp_cs_csyspwrupreq; //Cxxx signals come directly from Ctrl/Status
  reg         dp_cs_cdbgpwrupreq;
  reg         dp_cs_cdbgrstreq;

  //Control For Top Level Internal Signals
  wire        tck_n;              //tck_n is inverted tck
  reg         tdo_next_data;      //Muxed input to TDO register in SDR states
  wire        tdo_next;           //Muxed Input to TDO register
  wire        tdo_load;           //Load enable for TDO register
  reg         tdoen;              //Active High n_tdoen signal

  wire        tdi_masked;         //TDI passed through a CDC AND gate

  wire        dp_req_dp_load;     //Load enable for dp_req_dp reg

  //JTAG State Machine
  reg  [3:0]  jtag_state;         //JTAG Current State
  reg  [3:0]  jtag_state_next;    //Input to jtag_state

  //JTAG Scan Chain
  //The scan chains are split into the upper 32 bits (top) and the lower 3 bits
  //(bottom)
  reg  [31:0] jtag_sc_top;        //Bits [34:3] of JTAG Scan Chain
  reg  [2:0]  jtag_sc_btm;        //Bits [2:0] of JTAG Scan Chain
  //jtag_sc_top is loaded from an OR-of-AND mux, with extra logic to set the
  //value loaded to 0x10000000 at CIR.
  wire [31:0] jtag_sc_top_next;   //Input to jtag_sc_top (after CIR logic)
  wire [31:0] jtag_sc_mux;        //Output of OoA mux (before CIR logic)
  wire [31:0] jtag_sc_shifted;    //Shifted data input to mux
  // - Signals for mux enable terms
  wire        state_cir;          //Set when JTAG SM is in CIR state
  wire        state_cdr;          //Set when JTAG SM is in CDR state
  wire        state_udr;          //Set when JTAG SM is in UDR state
  wire        shifted_en;         //Enable for shifted data input
  wire        tap_id_en;          //Enable for TAP ID Input
  wire        dpidr_en;           //Enable for DPIDR input
  wire        ctrlstat_en;        //Enable for Ctrl/Stat reg input
  wire        evstat_en;          //Enable for Event Status reg input
  // - Control Signals for SC Registers
  wire        jtag_sc_top_load;   //Load enable for jtag_sc_top
  wire [2:0]  jtag_sc_btm_next;   //Input to jtag_sc[2:0]
  wire        jtag_sc_btm_load;   //Load enable for jtag_sc_btm

  //JTAG Instruction Register
  reg  [2:0]  jtag_inst;          //Stored 3 Bit Encoded JTAG Instruction
  reg  [2:0]  jtag_inst_enc;      //3 Bit Encoded Instruction Derived from SC
  wire [2:0]  jtag_inst_next;     //Input to jtag_inst
  wire        jtag_inst_load;     //Load enable for jtag_inst

  // JTAG Instruction Decodes
  wire        ir_apacc;           // DPACC Scan Chain in IR
  wire        ir_dpacc;           // APACC    "     "
  wire        ir_dpapacc;         // DPACC or APACC Scan Chain in IR
  wire        ir_abort;           // ABORT Scan Chain
  wire        ir_idcode;          // IDCODE Scan Chain

  //DP State
  reg         ap_ndp;             //Set if the last tx was to the AP
  wire        ap_ndp_next;        //Input to ap_ndp
  wire        ap_ndp_load;        //Load enable for ap_ndp
  reg         ap_busy_regd;       //Set if the ack was wait at the CDR state
  wire        ap_busy_regd_load;  //Load for ap_busy_regd
  wire        ap_busy_inst;       //AP transaction initiated
  wire        ap_interface_busy;  //AP is in control of DP/AP interface
  wire [2:0]  ack;                //3 Bit Tx Acknowledge
  wire        ack_wait;           //Used to form ack
  wire        ap_pwr_on;          //AP power status flag

  //Transaction Control
  wire        perform_tx_ap;
  wire        perform_tx_dp;
  wire        dp_write;
  wire        start_ap_tx;
  wire        start_ap_tx_masked;
  wire        start_ap_req;
  wire [1:0]  tx_regaddr;         //Register addr for tx (in jtag_sc_btm[2:1])
  wire        tx_rnw;             //RnW for tx (in jtag_sc_btm[0])

  //DP Registers
  // - dp_ctrlstat
  wire [31:0] dp_ctrlstat;        //Composite CTRL/STAT register
  reg         dp_cs_stickyerr;    //Bit[5] of CTRL/STAT
  reg         dp_cs_stickyorun;   //Bit[1] of CTRL/STAT
  reg         dp_cs_orundetect;   //Bit[0] of CTRL/STAT
  //dp_cs_load is used to load the CTRL/STAT fields which are set on
  //a write to the CTRL/STAT register, i.e. the CxxxREQ fields. The error
  //fields are loaded by the relevant error condition or flag reset.
  wire        dp_cs_load;
  //Control Status Register Error flag signals:
  wire        stickyerr_detected;
  wire        dp_cs_stickyerr_load;
  wire        dp_cs_stickyerr_next;
  wire        dp_stkerr_clr;
  wire        dp_cs_stickyorun_load;
  wire        dp_cs_stickyorun_next;
  wire        dp_stkorun_clr;
  wire        stickyorun_detected;

  // - dp_evstat
  wire [31:0] dp_evstat;              //RO Register

  // - dp_sel
  reg         dp_sel_apsel;           //Encoded Bits[31:24] of Select Register
  wire        dp_sel_apsel_next;      //Input to dp_sel_apsel
  reg  [1:0]  dp_sel_apbanksel;       //Encoded Bits[7:4] of Select Register
  wire [1:0]  dp_sel_apbanksel_next;  //Input to dp_sel_apbanksel
  wire [1:0]  dp_sel_apbanksel_masked;
  wire        dp_sel_apbanksel_next_1;//Each bit is encoded separately
  wire        dp_sel_apbanksel_next_0;
  wire [1:0]  dp_sel_dpbanksel;       //Recoded Select register
  wire        dp_sel_load;            //Enable for Select registers

  // - dp_abort
  wire        dp_abort_execute;       //Set on a write to the abort register
  reg         dp_abort_dapabort;      //Bit[0] of Abort, indicates an abort
  wire        dp_abort_dapabort_next; //Input to dp_abort_dapabort
  wire        dp_abort_dapabort_load; //Load enable for dp_abort_dapabort

  wire [31:0] dp_idr;                 // DPIDR Register Value
  wire [31:0] jtag_tap_id;            // JTAG TAP Identification Code

  // Outputs
  assign tdo_o                  = tdo;
  assign n_tdoen_o              = n_tdoen;
  assign dp_data_dp_o           = dp_data_dp;
  assign dp_regaddr_dp_o        = dp_regaddr_dp;
  assign dp_rnw_dp_o            = dp_rnw_dp;
  assign dp_wr_en_o             = dp_wr_en;
  assign dp_out_en_o            = dp_out_en;
  assign dp_err_out_en_o        = dp_err_out_en;
  assign dp_req_dp_load_o       = dp_req_dp_load;
  assign csyspwrupreq_o         = dp_cs_csyspwrupreq;
  assign dp_cs_cdbgpwrupreq_o   = dp_cs_cdbgpwrupreq;

// ============================================================================
// Start of Main Code
// ============================================================================

// ----------------------------------------------------------------------------
// JTAG State Machine
// ------------------
  //This is the standard 16 State JTAG TAP State Machine.
// ----------------------------------------------------------------------------
  //Determine Next State
  always @*
    case (jtag_state)
      JTAG_TLR : jtag_state_next = (tms_i ? JTAG_TLR : JTAG_RTI);
      JTAG_RTI : jtag_state_next = (tms_i ? JTAG_SDS : JTAG_RTI);
      //DR States
      JTAG_SDS : jtag_state_next = (tms_i ? JTAG_SIS : JTAG_CDR);
      JTAG_CDR : jtag_state_next = (tms_i ? JTAG_E1D : JTAG_SDR);
      JTAG_SDR : jtag_state_next = (tms_i ? JTAG_E1D : JTAG_SDR);
      JTAG_E1D : jtag_state_next = (tms_i ? JTAG_UDR : JTAG_PDR);
      JTAG_PDR : jtag_state_next = (tms_i ? JTAG_E2D : JTAG_PDR);
      JTAG_E2D : jtag_state_next = (tms_i ? JTAG_UDR : JTAG_SDR);
      JTAG_UDR : jtag_state_next = (tms_i ? JTAG_SDS : JTAG_RTI);
      //IR States
      JTAG_SIS : jtag_state_next = (tms_i ? JTAG_TLR : JTAG_CIR);
      JTAG_CIR : jtag_state_next = (tms_i ? JTAG_E1I : JTAG_SIR);
      JTAG_SIR : jtag_state_next = (tms_i ? JTAG_E1I : JTAG_SIR);
      JTAG_E1I : jtag_state_next = (tms_i ? JTAG_UIR : JTAG_PIR);
      JTAG_PIR : jtag_state_next = (tms_i ? JTAG_E2I : JTAG_PIR);
      JTAG_E2I : jtag_state_next = (tms_i ? JTAG_UIR : JTAG_SIR);
      JTAG_UIR : jtag_state_next = (tms_i ? JTAG_SDS : JTAG_RTI);
      default : jtag_state_next = 4'bxxxx;  //X Propagation
    endcase

  //State Machine Register
  always @(posedge tck or negedge n_trst)
    if (!n_trst)
      jtag_state <= JTAG_TLR;
    else
      jtag_state <= jtag_state_next;

// ----------------------------------------------------------------------------
// JTAG Instructions
// -----------------
  //The JTAG DP has a 4 bit instruction scan chain with 5 defined
  //instructions:
  //
  //Inst. S/C   Instruction
  //  1000         Abort
  //  1010         DPACC
  //  1011         APACC
  //  1110        IDCODE
  //  1111        BYPASS
  //
  //All undefined instructions default to the BYPASS instruction.
  //
  //The instructions are encoded to 3 bits as there are 5 possible
  //instructions and this DP does not implement or support boundary scan
  //instructions. The encoding simply removes the common top bit from the
  //instructions.
  //
  //The encoded instruction is reset to IDCODE on dpreset_n or when the state
  //machine is in TLR, and is loaded with the encoded value in the
  //Instruction Scan Chain when the state machine is in UIR
// ----------------------------------------------------------------------------
  //Determine Encoded Instruction based on Instruction Scan Chain
  always @*
    case (jtag_sc_top[31:28]) //Instruction SC is top 4 bits of jtag_sc
      JTAG_ABORT   : jtag_inst_enc = JTAG_3_ABORT;
      JTAG_DPACC   : jtag_inst_enc = JTAG_3_DPACC;
      JTAG_APACC   : jtag_inst_enc = JTAG_3_APACC;
      JTAG_IDCODE  : jtag_inst_enc = JTAG_3_IDCODE;
      JTAG_BYPASS  : jtag_inst_enc = JTAG_3_BYPASS;
      JTAG_UNSUP0,
      JTAG_UNSUP1,
      JTAG_UNSUP2,
      JTAG_UNSUP3,
      JTAG_UNSUP4,
      JTAG_UNSUP5,
      JTAG_UNSUP6,
      JTAG_UNSUP7,
      JTAG_UNSUP9,
      JTAG_UNSUPC,
      JTAG_UNSUPD  : jtag_inst_enc = JTAG_3_BYPASS;
      default      : jtag_inst_enc = 3'bxxx;  //X Propagation
    endcase

  //Determine input & enable for jtag_inst register
  assign jtag_inst_next = ((jtag_state == JTAG_TLR)
                           ? JTAG_3_IDCODE
                           : jtag_inst_enc);

  assign jtag_inst_load = (jtag_state == JTAG_TLR) | (jtag_state == JTAG_UIR);

  //Updated Encoded Instruction
  //Asynchronously reset to IDCODE by DPRESETn for safety and by state TLR
  //following synchronous TMS or asynchronous nTRST reset
  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      jtag_inst <= JTAG_3_IDCODE;
    else if (jtag_inst_load)
      jtag_inst <= jtag_inst_next;

  // Instruction Decodes
  // These wires are used to clearly indicate the selected scan chain, in
  // logic elsewhere in the code which depends on the IR contents.
  assign ir_apacc   = (jtag_inst == JTAG_3_APACC);
  assign ir_dpacc   = (jtag_inst == JTAG_3_DPACC);
  assign ir_dpapacc = (jtag_inst == JTAG_3_DPACC) | (jtag_inst == JTAG_3_APACC);
  assign ir_abort   = (jtag_inst == JTAG_3_ABORT);
  assign ir_idcode  = (jtag_inst == JTAG_3_IDCODE);

// ----------------------------------------------------------------------------
// TDO Output
// ----------
  //The data on TDO is required to change on the falling edge of tck. To
  //acheive this, the signal tck_n is set to the inverted clock, and TDO is
  //registered and driven off the rising edge of tck_n (the falling edge of
  //tck).
  //
  //TDO is driven in the SDR and SIR states, such that the data for
  //a particular bit is available on the falling edge AFTER the rising edge
  //at which the value on TDI was sampled for the respective bit. For example
  //with a 35 bit data scan chain, on the first rising clock edge in SDR the
  //value on TDI is sampled by the DAP and loaded into bit [34] of the scan
  //chain. On the NEXT falling edge, the debugger can sample TDO and will
  //read the value which was in bit [0] of the scan chain at the CDR state.
  //
  //The source of TDO depends on the length of the currently selected scan
  //chain. A single 35 bit shift register is used for all scan chains, and
  //TDI is always connected to its MSB. TDO is then connected to:
  //
  // Scan Chain    Length    TDO Source
  //  BYPASS         1      jtag_sc[34]
  //Instruction      4      jtag_sc[31]
  //  IDCODE        32      jtag_sc[3]
  //   DPACC        35      jtag_sc[0]
  //   APACC        35      jtag_sc[0]
// ----------------------------------------------------------------------------
  //The input to the TDO register is selected by a mux
  // - enable terms
  //TDO Source
  // - Source when in SDR
  always @*
    case (jtag_inst)
      JTAG_3_BYPASS  : tdo_next_data = jtag_sc_top[31]; //1 Bit SC
      JTAG_3_IDCODE  : tdo_next_data = jtag_sc_top[0];  //32 Bit SC
      JTAG_3_ABORT,
      JTAG_3_DPACC,
      JTAG_3_APACC   : tdo_next_data = jtag_sc_btm[0];  //35 Bit SC
      // Unused cases checked by OVL u_jtag_inst_valid
      default        : tdo_next_data = 1'bx;            //X Propagation
    endcase

  // - Source when in SDR or SIR
  assign tdo_next = ((jtag_state == JTAG_SDR)
                     ? tdo_next_data     //Data SC
                     : jtag_sc_top[28]); //Inst SC=4 Bit

  //Inverted Clock
  assign tck_n = ~tck;

  //TDO Load Enable
  assign tdo_load = (jtag_state == JTAG_SDR) | (jtag_state == JTAG_SIR);

  //TDO Register
  always @(posedge tck_n or negedge dpreset_n)
    if (!dpreset_n)
      tdo <= 1'b0;
    else if (tdo_load)
      tdo <= tdo_next;

  //nTDOEN is used to allow TDO to be tri-stated externally.
  always @(posedge tck_n or negedge dpreset_n)
    if (!dpreset_n)
      tdoen <= 1'b0;
    else
      tdoen <= tdo_load; //TDO is enabled whenever it is being loaded

  assign n_tdoen = ~tdoen;

// ----------------------------------------------------------------------------
// JTAG Scan Chain
// ---------------
  //All JTAG scan chains are comprised of a single 35 bit shift register.
  //This is split into two parts: jtag_sc_top, which is the top 32 bits, and
  //jtag_sc_btm, which is the bottom 3 bits. TDI is always shifted into the
  //MSB of jtag_sc_top - the different length scan chains are created by
  //sourcing TDO from different bits.
  //By splitting the scan chain up into two parts, the top part can be
  //shifted without affecting the data stored in the bottom part. This allows
  //scans through the BYPASS and IDCODE scan chains to be performed in
  //between two DP or APACC transactions without needing to buffer the
  //register address and RnW bits (which are the bottom 3 bits of the DPAPACC
  //scan chain).
  //The register is loaded by an OR-of-AND multiplexer structure, as the data
  //loaded depends on a number of orthogonal signals, and it is often
  //required to load the register with 0x00000000.
// ----------------------------------------------------------------------------
  //Mux Enable Terms
  // - Interim terms
  assign state_cir = (jtag_state == JTAG_CIR);
  assign state_cdr = (jtag_state == JTAG_CDR);
  assign state_udr = (jtag_state == JTAG_UDR);

  // - Shifted Data
  assign shifted_en = ~(state_cir | state_cdr); //Shifted is default output

  // - TAP IDCODE Enable
  assign tap_id_en = state_cdr & ir_idcode; // Capture IDCODE

  // TAP IDCODE Value
  assign jtag_tap_id = {(ecorevnum_i ^ JTAG_DEVICE_ID[31:28]), JTAG_DEVICE_ID[27:0]};

  // - AP Data Output Enable
  // This is a top-level output to a mask in a separate block (ap_cdc).
  assign dp_out_en = dp_err_out_en;

  // - AP Error Output Enable
  // This is a top-level output to a mask in a separate block (ap_cdc).
  assign dp_err_out_en =  state_cdr &            // CDR State
                          ir_dpapacc &           // DPACC or APACC
                          ap_ndp &               // last transaction was APACC
                          ap_busy_regd &         // an AP transaction occurred
                          (~ap_interface_busy) & // DP controls CDC block
                          dp_sel_apsel &         // AP is selected
                          (~dp_abort_dapabort);  // AP has not been aborted

  // - DPIDR Enable
  assign dpidr_en = state_cdr & ir_dpapacc & (~ap_ndp)
                    & (tx_regaddr == JTAG_REGADDR_DPIDR);

  // DPIDR Value
  // The DPIDR revision field can be changed so the defined value is XOR'ed with
  // the ECOREVNUM value from the input
  assign dp_idr = {(ecorevnum_i ^ JTAG_DPIDR_REG_VAL[31:28]), JTAG_DPIDR_REG_VAL[27:0]};

  // - CTRL/STAT Enable
  assign ctrlstat_en = state_cdr & ir_dpapacc & (~ap_ndp)
                       & (tx_regaddr == JTAG_REGADDR_DPBANK)
                       & (dp_sel_dpbanksel == JTAG_DPBANK_CTRLSTAT);

  // - EVENTSTAT Enable
  assign evstat_en = state_cdr & ir_dpapacc & (~ap_ndp)
                     & (tx_regaddr == JTAG_REGADDR_DPBANK)
                     & (dp_sel_dpbanksel == JTAG_DPBANK_EVSTAT);

  //Event Status Register (EVENTSTAT) (Read Only)
  assign dp_evstat = { {31{1'b0}},     //[31:1] SBZ/RAZ
                       halted_n_i      //[0]    Processor halted event (active low)
                     };

  // The IEEE spec allows TDI to be undriven outside the shift states.
  // To avoid loading metastable values TDI is passed through a CDC AND mask.
  cm0p_dap_jt_cdc_comb_and
    u_tdi_and_gate
    (
      .DATAIN   (tdi_i),
      .MASKn    (shifted_en),
      .DATAOUT  (tdi_masked)
    );

  //OR-of-AND Mux
  // - shifted data input
  assign jtag_sc_shifted = {tdi_masked, (jtag_sc_top[31:1] & {31{shifted_en}})};

  // - Mux
  assign jtag_sc_mux =  (jtag_sc_shifted)      |  // already masked
                        ({32{tap_id_en}}    & jtag_tap_id) |
                        ({32{dpidr_en}}     & dp_idr)      |
                        ({32{ctrlstat_en}}  & dp_ctrlstat) |
                        ({32{evstat_en}}    & dp_evstat)   |
                        ap_data_dp_i; //This is masked externally

  //Set Value to 0x10000000 at CIR
  // - This is achieved by ORing bit[28] of jtag_sc_mux with state_cir (when
  // state_cir is asserted, jtag_sc_mux is 0x00000000).
  assign jtag_sc_top_next = { jtag_sc_mux[31:29],
                              (jtag_sc_mux[28] | state_cir),
                              jtag_sc_mux[27:0] };

  //Load Enable for jtag_sc_top register
  assign jtag_sc_top_load = //Always load in CDR (loading for BYPASS is benign)
                            (jtag_state == JTAG_CDR) |
                            //Always load in CIR
                            (jtag_state == JTAG_CIR) |
                            //Always load in SDR
                            (jtag_state == JTAG_SDR) |
                            //Always load in SIR
                            (jtag_state == JTAG_SIR);

  //Input to jtag_sc_bottom (JTAG Scan Chain [2:0]). This can either be the
  //current value shifted right, with the LSB of jtag_sc_top shifted in, or
  //the 3 bit transaction acknowledge.

  // This is used to generate the final ACK response for the transaction.
  // Since ACK is either OK/FAULT or WAIT only one requires logic.
  assign ack_wait = ir_dpapacc              // DPACC/APACC
                    & ap_ndp                // Previous accepted Tx is APACC
                    & dp_sel_apsel          // AP is selected
                    & (ir_apacc |           // APACC
                      (~dp_abort_dapabort)) // DPACC after non-aborted APACC
                    & (state_cdr
                       ? ap_busy_inst       // AP busy at CDR
                       : ap_busy_regd);     // AP was busy at last CDR

  assign ack = {1'b0, (~ack_wait), ack_wait};

  assign jtag_sc_btm_next = ((jtag_state == JTAG_SDR)
                             ? ({jtag_sc_top[0], jtag_sc_btm[2:1]}) //Shift
                             : ack);                                //Load Par.

  //Load Enable for jtag_sc_btm
  assign jtag_sc_btm_load = ( //Load in CDR or SDR
                              (jtag_state == JTAG_CDR) |
                              (jtag_state == JTAG_SDR)
                            ) &
                            ( //When the current instruction is DPACC or APACC
                              ir_dpapacc | ir_abort
                            );

  //JTAG Scan Chain Registers
  // - jtag_sc_top
  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_jtag_sc_top_rar

      always @(posedge tck or negedge rar_reset_n)
        if (!rar_reset_n)
          jtag_sc_top <= {32{1'b1}};
        else if (jtag_sc_top_load)
          jtag_sc_top <= jtag_sc_top_next;

    end else begin : gen_jtag_sc_top

      wire unused = rar_reset_n;

      always @(posedge tck)
        if (jtag_sc_top_load)
          jtag_sc_top <= jtag_sc_top_next;

    end
  endgenerate

  // - jtag_sc_btm
  // This register is reset as the data is used in control signals.
  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      jtag_sc_btm <= 3'b000;
    else if (jtag_sc_btm_load)
      jtag_sc_btm <= jtag_sc_btm_next;

  //The data in jtag_sc_btm specifies the register address and RnW direction
  //for the current transaction
  assign tx_regaddr = jtag_sc_btm[2:1];
  assign tx_rnw     = jtag_sc_btm[0];

// ----------------------------------------------------------------------------
// DP State
// --------
  //At the CDR state when the current instruction is DPACC or APACC, the
  //value loaded depends on whether the instruction was APACC at the previous
  //UDR state on the previous DPACC or APACC transaction. Scans through the
  //BYPASS or IDCODE scan chains may have happened in the mean time so this
  //data is not available, so a separate bit is used to capture this.
// ----------------------------------------------------------------------------
  //ap_ndp is set at UDR when the current instruction is APACC or DPACC
  //(therefore the bit is not overwritten during IDCODE or BYPASS scans, so
  //these operations do not affect the pipelining of DP & AP transactions.
  assign ap_ndp_load = state_udr & ir_dpapacc & (~ack_wait);

  assign ap_ndp_next = ir_apacc;

  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      ap_ndp <= 1'b0; //Reset as used in control signals
    else if (ap_ndp_load)
      ap_ndp <= ap_ndp_next;

// ----------------------------------------------------------------------------
// AP Synchronisation Handshaking
// -----------------------------
  //A simple two phase handshaking mechanism is used to synchronise between
  //the DP and AP, and to initiate AP transactions. The DP can only start
  //a transaction when the AP is idle. The DP can see that the AP is idle
  //when the DP driven REQ handshake signal is the same value as the AP driven
  //ACK. When the AP is idle, the DP has control over the shared transfer
  //module, which is used to pass transaction data back and forth between the
  //AP and DP.
  //
  //To initiate an AP transaction, the DP first writes the transaction data
  //to the transfer module, then toggles the REQ signal, so that REQ != ACK,
  //which signals to the AP that it should complete a transaction. When the
  //AP transaction is complete, it toggles ACK, so that REQ == ACK, and the
  //DP again sees that the AP is idle. It can then read the result of the
  //transaction from the transfer register.
  //
  //Note that REQ and ACK are synchronised into the destination clock domains
  //at the DAP top level.
// ----------------------------------------------------------------------------
  //AP Status
  //ap_interface_busy is true when the AP controls the CDC block,
  //and is used at the PARK state to determine whether to load the result
  //of an AP transaction.
  assign ap_interface_busy = (dp_req_dp_i ^ ap_ack_dp_i);

  //ap_busy_inst is the instantaneous value of ap_busy, and indicates that
  //the AP is busy due to a transaction being initiated.
  assign ap_busy_inst = ap_interface_busy & ap_busy_regd;

  //Registered AP Status - Clear at CDR
  assign ap_busy_regd_load =  start_ap_tx_masked |
                              (state_cdr & (ir_dpapacc) & (~ap_busy_inst));

  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      ap_busy_regd <= 1'b0;
    else if (ap_busy_regd_load)
      ap_busy_regd <= start_ap_tx_masked;

  //AP Transactions
  assign start_ap_tx =  perform_tx_ap &   // Tx allowed
                        dp_sel_apsel;     // AP selected
    // start_ap_tx is masked so that the AP transaction is only started if the
  // AP is powered up.
  assign start_ap_tx_masked = start_ap_tx & ap_pwr_on;

  // start_ap_req indicates a request is to be made to the AP, for
  // a transaction or the handshake-reset sequence.
  assign start_ap_req = start_ap_tx_masked | reset_dp_ap_handshake_i;

  //dp_wr_en is used to load the transfer register with the DP
  //transaction data at the start of an AP transaction.
  assign dp_wr_en = start_ap_req;

  //dp_req_dp_i is toggled to start an AP transaction. It is is cleared to 0
  //when the AP is reset, as an AP reset forces ap_ack_x to 0.
  //dp_req_dp_i can be set only if the AP is powered on - a power down request
  //will clear it to safeguard the handshaking logic.
  //The register itself is in the DP CDC block.
  assign dp_req_dp_load = start_ap_req;
// ----------------------------------------------------------------------------
// Power Up/Power Down Handshaking
// ----------------------------------------------------------------------------

  //ap_pwr_on indicates that the AP is powered on by looking at the
  //CDBGPWRUPREQ and CDBGPWRUPACK signals, and is used to allow transasctions
  //only if both are high, i.e. the AP has been powered up and no power down
  //request has been made, and to keep dp_req_dp_i synchronized to the AP (it
  //assumes ap_ack is 0 after an AP reset).
  assign ap_pwr_on = (dp_cs_cdbgpwrupreq & dp_cs_cdbgpwrupack_i);

// ----------------------------------------------------------------------------
// Logical DP Registers
// --------------------
  //The JTAG DP Programmers Model is:
  //A[3:2] RnW  Register
  // 0x0    R     DPIDR
  // 0x0    W     Abort   (accesses to the ABORT scan chain are treated as
  //                      acceses to this register)
  // 0x4    X   Ctrl/Stat
  // 0x8    R   Reserved
  // 0x8    W    Select
  // 0xC    X    RDBUFF
  //
  //All DP Logical Register names are preceded in the RTL by dp_. The
  //individual fields making up composite registers are preceded by
  //dp_regname_.
// ----------------------------------------------------------------------------
  //CONTROL SIGNALS
  assign perform_tx_dp =  state_udr &             // Update-DR
                          ir_dpacc &              // DPACC
                          (~ack_wait);            // OK/FAULT response

  assign perform_tx_ap =  state_udr &             // Update DR
                          ir_apacc &              // APACC
                          (~(ap_busy_regd |       // AP is not busy
                             dp_cs_stickyorun |   // No Sticky Overrun
                             dp_cs_stickyerr));   // No Sticky Error

  assign dp_write = perform_tx_dp & (~tx_rnw);

  //REGISTERS
  //Abort
  //The abort register is WO and its effects are immediate, so it is not
  //physically implemented.
  //The abort register is used to clear error flags, which is done with the
  //following signals
  //As ABORT is in its own scan chain the address and the RnW bits are
  //disregarded - it is UNP if they are wrong
  assign dp_abort_execute = state_udr &     // Execute at UDR
                            ir_abort;       // ABORT Scan Chain

  //A DAPABORT has be to stored, as it affects the subsequent operation of
  //the DP. In CORTEX-M0+DAP, a DAPABORT has no effect on the AP, however it
  //free's up access to all of the DP registers. It is only asserted when the AP
  //is busy, in case the AP naturally becomes free after an ABORT is issued
  //then this clears the abort.
  assign dp_abort_dapabort_next = ap_busy_regd;

  assign dp_abort_dapabort_load = (dp_abort_execute & jtag_sc_top[0]) |
                                  //Set on write to abort
                                  dp_abort_dapabort;  //Then loads until cleared

  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      dp_abort_dapabort <= 1'b0;
    else if (dp_abort_dapabort_load)
      dp_abort_dapabort <= dp_abort_dapabort_next;

  //Control/Status
  //This register is a composite of a number of different fields
  assign dp_ctrlstat = {  csyspwrupack_sync_i,  //[31]    RO
                          dp_cs_csyspwrupreq,   //[30]    RW
                          dp_cs_cdbgpwrupack_i, //[29]    RO
                          dp_cs_cdbgpwrupreq,   //[28]    RW
                          1'b0,                 //[27]    RAZ
                          dp_cs_cdbgrstreq,     //[26]    RW
                          1'b0,                 //[25]    RAZ
                          1'b0,                 //[24]    RAZ
                          12'b0000_0000_0000,   //[23:12] TRNCNT (RAZ in MinDP)
                          4'b0000,              //[11:8]  MASKLANE (RAZ in MinDP)
                          1'b0,                 //[7]     RAZ in JTAG
                          1'b0,                 //[6]     RAZ in JTAG
                          dp_cs_stickyerr,      //[5] RO
                          1'b0,                 //[4]     StickyCmp (RAZ in MinDP)
                          2'b00,                //[3:2]   TRNMODE (RAZ in MinDP)
                          dp_cs_stickyorun,     //[1]     STICKYORUN
                          dp_cs_orundetect      //[0]     ORUNDETECT
                       };

  assign dp_cs_load = dp_write
                      & (tx_regaddr == JTAG_REGADDR_DPBANK)
                      & (dp_sel_dpbanksel == JTAG_DPBANK_CTRLSTAT);

  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n) begin
      dp_cs_csyspwrupreq        <= 1'b0;
      dp_cs_cdbgpwrupreq        <= 1'b0;
      dp_cs_cdbgrstreq          <= 1'b0;
      dp_cs_orundetect          <= 1'b0;
    end
    else if (dp_cs_load) begin
      dp_cs_csyspwrupreq        <= jtag_sc_top[30];
      dp_cs_cdbgpwrupreq        <= jtag_sc_top[28];
      dp_cs_cdbgrstreq          <= jtag_sc_top[26];
      dp_cs_orundetect          <= jtag_sc_top[0];
    end

  //Select
  //This register is WO, and the data written is encoded to be stored in
  //a fewer number of bits.
  //The select register comprises the following fields:
  //  [31:24] APSEL     - Selects between the AP's connected to the DP
  //  [7:4]   APBANKSEL - Selects the bank within the current AP

  //Since only 1 AP is present in this DAP, the APSEL field is encoded as
  //a single bit, which is set when the present AP is selected. This is
  //performed by a reduction-NOR on the APSEL value written, such that the
  //present AP is selected when APSEL is 0x00
  assign dp_sel_apsel_next = ~(|jtag_sc_top[31:24]);

  //There are 16 logical banks in the AP, however only three of them are
  //used: 0x0, 0x1 and 0xF. Therefore APBANKSEL is encoded as a 2 bit value
  //as follows:
  //  jtag_sc_top[7:4] == 4'b0000 -> 2'b00 (AP Bank 0x0)
  //  jtag_sc_top[7:4] == 4'b0001 -> 2'b01 (AP Bank 0x1)
  //  jtag_sc_top[7:4] == 4'b1111 -> 2'b11 (AP Bank 0xF)
  //                       Else   -> 2'b10 (RAZ/WI)
  //If the DP/AP handshake needs to be reset in preparation for power down the
  //bank selection is forced to 2'b10 so any transaction caused is RAZ/WI.

  //Encoded Bit 0
  assign dp_sel_apbanksel_next_1 =  (|jtag_sc_top[7:5]);
  //Encoded Bit 1
  assign dp_sel_apbanksel_next_0 = ((~dp_sel_apbanksel_next_1 & jtag_sc_top[4])
                                   | (&jtag_sc_top[7:4]));
  assign dp_sel_apbanksel_next = {dp_sel_apbanksel_next_1,
                                  dp_sel_apbanksel_next_0};

  assign dp_sel_load = dp_write
                       & (tx_regaddr == JTAG_REGADDR_SELECT);

  //The APSEL and APBANKSEL fields of the Select register are architecturally
  //defined to be unpredictable after reset. However, the encoded APSEL
  //signal is reset (such that the AP is not selected) as this is used as
  //a control signal. This is different to resetting the architectural
  //equivalent to 0x00, as writing that value would set the encoded APSEL to
  //be b1. APBANKSEL is not reset as it is only used as a data signal to the
  //AP and cannot be used unless APSEL is set, implying that the register has
  //been initialised.
  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      dp_sel_apsel     <= 1'b0; //AP is not selected after reset
    else if (dp_sel_load)
      dp_sel_apsel     <= dp_sel_apsel_next;

  generate
    if ((CBAW != 0) || (HALTEV != 0)) begin : gen_haltev

      reg [1:0] dpbanksel;
      reg [1:0] dpbanksel_next;

      always @*
        if (cfg_haltev) begin
          case (jtag_sc_top[3:0])
            4'b0000: dpbanksel_next = JTAG_DPBANK_CTRLSTAT;
            4'b0001,
            4'b0010,
            4'b0011: dpbanksel_next = JTAG_DPBANK_RESERVED;
            4'b0100: dpbanksel_next = JTAG_DPBANK_EVSTAT;
            4'b0101,
            4'b0110,
            4'b0111,
            4'b1000,
            4'b1001,
            4'b1010,
            4'b1011,
            4'b1100,
            4'b1101,
            4'b1110,
            4'b1111: dpbanksel_next = JTAG_DPBANK_RESERVED;
            default: dpbanksel_next = 1'bx;  //X Propagation
          endcase // case(jtag_sc_top[3:0])
        end else begin
          dpbanksel_next = JTAG_DPBANK_CTRLSTAT;
        end

      always @(posedge tck or negedge dpreset_n)
        if (!dpreset_n)
          dpbanksel <= JTAG_DPBANK_CTRLSTAT;
        else if (dp_sel_load)
          dpbanksel <= dpbanksel_next;

      assign  dp_sel_dpbanksel = dpbanksel;

    end else begin : gen_haltev_dis

      assign  dp_sel_dpbanksel = JTAG_DPBANK_CTRLSTAT;

    end

  endgenerate

  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_dp_sel_apbanksel_rar

      always @(posedge tck or negedge rar_reset_n)
        if (!rar_reset_n)
          dp_sel_apbanksel <= 2'b11;
        else if (dp_sel_load)
          dp_sel_apbanksel <= dp_sel_apbanksel_next;

    end else begin : gen_dp_sel_apbanksel

      always @(posedge tck)
        if (dp_sel_load)
          dp_sel_apbanksel <= dp_sel_apbanksel_next;

    end
  endgenerate

// ----------------------------------------------------------------------------
// Error Flags
// -----------
  //These are architecturally part of the Control/Status register, however
  //are set by external error conditions. They can be cleared by either
  //writing to the abort register, or by writing 1 to the relevant bit in the
  //Control/Status register.
// ----------------------------------------------------------------------------
  //Sticky Error
  //Set when an AP transaction returns an error, or when an illegal AP
  //transaction is attempted. In the case of a legal AP transaction the error
  //from the AP is masked by dp_err_out_en, which ensures the error is sampled
  //only when it is valid.
  assign stickyerr_detected = ap_err_dp_i | (start_ap_tx & (~ap_pwr_on));

  //The Sticky Error Flag can be cleared by writing to the Abort register, or
  //by writing 1 to the actual error flag in the Control/Status register
  assign dp_stkerr_clr =  (dp_abort_execute & jtag_sc_top[2]) | //Abt Reg
                          (dp_cs_load & jtag_sc_top[5]);        //W1C

  assign dp_cs_stickyerr_load = ( (~dp_cs_stickyerr)
                                        & stickyerr_detected )
                                      | dp_stkerr_clr;

  assign dp_cs_stickyerr_next = ~dp_stkerr_clr;

  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      dp_cs_stickyerr <= 1'b0;
    else if (dp_cs_stickyerr_load)
      dp_cs_stickyerr <= dp_cs_stickyerr_next;

  //Sticky Overrun
  //Set when ORUNDETECT is set and a transaction gives a wait response.
  assign stickyorun_detected  = state_cdr &
                                //Wait only set in CDR on DPACC or APACC
                                ack_wait &        //Error Condition
                                dp_cs_orundetect; //Detection enabled

  //The Sticky Overrun flag is cleared by writing to the abort register,
  // or by writing 1 to the actual error flag in the Control/Status register.
  assign dp_stkorun_clr = (dp_abort_execute & jtag_sc_top[4])
                          | (dp_cs_load & jtag_sc_top[1] );

  assign dp_cs_stickyorun_load =  ( (~dp_cs_stickyorun)
                                          & stickyorun_detected )
                                        | dp_stkorun_clr;

  assign dp_cs_stickyorun_next = ~dp_stkorun_clr;

  always @(posedge tck or negedge dpreset_n)
    if (!dpreset_n)
      dp_cs_stickyorun <= 1'b0;
    else if (dp_cs_stickyorun_load)
      dp_cs_stickyorun <= dp_cs_stickyorun_next;

// ----------------------------------------------------------------------------
// Top Level IO
// ----------------------------------------------------------------------------
  assign dp_data_dp = jtag_sc_top;
  assign dp_rnw_dp = tx_rnw;

  // During the handshake reset sequence, 2'b10 is passed as the Bank Select
  // to the AP. All registers under this encoded banksel field are reserved
  // and RAZ/WI so this results in a null transaction.
  assign dp_sel_apbanksel_masked =  (reset_dp_ap_handshake_i ?
                                    2'b10 : dp_sel_apbanksel);

  assign dp_regaddr_dp = {dp_sel_apbanksel_masked, tx_regaddr};

// Assertions
// ----------------------------------------------------------------------------
`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

  ovl_implication
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ap_busy_regd and ap_busy_inst must be consistent."),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_regd_inst_consistency
    (
      .clock            (tck),
      .reset            (dpreset_n),
      .enable           (1'b1),
      .antecedent_expr  (~ap_busy_regd),
      .consequent_expr  (~ap_busy_inst),
      .fire             ()
    );

  // - jtag_inst
  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("jtag_inst must be a valid encoding"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_jtag_inst_valid
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ((jtag_inst == JTAG_3_BYPASS) |
                     (jtag_inst == JTAG_3_IDCODE) |
                     (jtag_inst == JTAG_3_ABORT)  |
                     (jtag_inst == JTAG_3_DPACC)  |
                     (jtag_inst == JTAG_3_APACC)),
        .fire       () );

  ovl_implication
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("The JTAG Instruction Register should contain a valid instruction at SDR"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_valid_jtag_inst
    (
      .clock            (tck),
      .reset            (dpreset_n),
      .enable           (1'b1),
      .antecedent_expr  (jtag_state == JTAG_SDR),
      .consequent_expr  ((jtag_inst == JTAG_3_BYPASS) | ir_dpapacc | ir_idcode | ir_abort),
      .fire             ()
    );


  ovl_implication
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("The AP can be busy without being aborted only if it is selected and APACC was the last accepted transaction."),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_busy_and_selected
    (
      .clock            (tck),
      .reset            (dpreset_n),
      .enable           (1'b1),
      .antecedent_expr  ((ap_busy_inst | ap_busy_regd) & (~dp_abort_dapabort)),
      .consequent_expr  (dp_sel_apsel & ap_ndp),
      .fire             ()
    );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Both ap_busy_inst and ap_busy_regd should be set when an AP transaction starts"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_regd_inst_simultaneous_at_start_aptx
    (
      .clock        (tck),
      .reset        (dpreset_n),
      .enable       (1'b1),
      .start_event  (~ap_busy_regd),
      .test_expr    (ap_busy_regd == ap_busy_inst),
      .fire         ()
    );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("A transaction should be about to start when ap_busy_inst goes high, and ap_busy_inst should be low when the transaction's result is sampled."),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_regd_cleared_after_inst
      (
        .clock        (tck),
        .reset        (dpreset_n),
        .enable       (1'b1),
        .start_event  (ap_busy_inst),
        .test_expr    (ap_busy_regd),
        .fire         ()
      );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("The DP must not report an AP transaction in progress when the dummy transaction as part of the handshake reset sequence is performed."),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_handshake_reset_never_ap_busy_regd
      (
        .clock        (tck),
        .reset        (dpreset_n),
        .enable       (1'b1),
        .start_event  (reset_dp_ap_handshake_i & ~ap_busy_regd),
        .test_expr    (~ap_busy_regd),
        .fire         ()
      );


  // DPRESETn is a synchronised reset that may not be deasserted for up to 3
  // TCK cycles after nTRST is de-asserted (for example if the unsynchronised
  // source of DPRESETn and nTRST are both asserted and released before the
  // first TCK)
  // In this situation, check that the synchronised DPRESETn does not prevent
  // the DP from behaving correctly. By inspection, there is no DP state that
  // is reset by DPRESETn that is sensitive to the jtag state machine in states
  // TLR, RTI or SDS (apart from jtag_inst) so simply assert that the state
  // machine will be in one of these three states for at least three cycles
  // following an nTRST.
  // For jtag_inst, check that it is reset to IDCODE on the 4th cycle after
  // nTRST (to ensure it is unaffected by a synchronised DPRESETn)

  wire jtag_state_safe = ((jtag_state == JTAG_TLR) |
                          (jtag_state == JTAG_RTI) |
                          (jtag_state == JTAG_SDS));

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("JTAG state machine must not leave TLR, RTI or SIR for 1 of 3 cycles after nTRST"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_jtag_safe_1_after_ntrst
      (
        .clock        (tck),
        .reset        (1'b1),
        .enable       (1'b1),
        .start_event  (~n_trst),
        .test_expr    (jtag_state_safe),
        .fire         ()
      );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (2),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("JTAG state machine must not leave TLR, RTI or SIR for 2 of 3 cycles after nTRST"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_jtag_safe_2_after_ntrst
      (
        .clock        (tck),
        .reset        (1'b1),
        .enable       (1'b1),
        .start_event  (~n_trst),
        .test_expr    (jtag_state_safe),
        .fire         ()
      );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (3),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("JTAG state machine must not leave TLR, RTI or SIR for 3 of 3 cycles after nTRST"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_jtag_safe_3_after_ntrst
      (
        .clock        (tck),
        .reset        (1'b1),
        .enable       (1'b1),
        .start_event  (~n_trst),
        .test_expr    (jtag_state_safe),
        .fire         ()
      );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (4),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("nTRST must reset leave jtag_inst in state JTAG_3_IDCODE regardless of DPRESETn"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_jtag_idcode_after_ntrst
      (
        .clock        (tck),
        .reset        (1'b1),
        .enable       (1'b1),
        .start_event  (~n_trst),
        .test_expr    (jtag_inst == JTAG_3_IDCODE),
        .fire         ()
      );

  //This is a usage warning as it may occur in a system where the debugger uses TMS to
  //reset the JTAG state machine rather than nTRST
  ovl_implication
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("DPRESETn asserted when JTAG not in safe state"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_jtag_unsafe
    (
      .clock            (tck),
      .reset            (n_trst),
      .enable           (1'b1),
      .antecedent_expr  (~dpreset_n),
      .consequent_expr  (jtag_state_safe),
      .fire             ()
    );

  // ap_err_dp cannot be sampled before it is written. The register has no
  // reset so this is detected by looking for X.
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ap_err_dp must never be X"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_ap_err_dp
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (ap_err_dp_i),
        .fire       () );

  //Check for X in Register load enables
  // - jtag_inst_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("jtag_inst_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_jtag_inst_load_x
      ( .clock      (tck),
        .reset      (n_trst),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (jtag_inst_load),
        .fire       () );

  // - tdo_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("tdo_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_tdo_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (tdo_load),
        .fire       () );

  // - jtag_c_top_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("jtag_sc_top_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_jtag_sc_top_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (jtag_sc_top_load),
        .fire       () );

  // - jtag_sc_btm_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("jtag_sc_btm_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_jtag_sc_btm_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (jtag_sc_btm_load),
        .fire       () );

  // - ap_busy_regd_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ap_busy_regd_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_busy_regd_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (ap_busy_regd_load),
        .fire       () );

  // - ap_ndp_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ap_ndp_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_ndp_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (ap_ndp_load),
        .fire       () );

  // - dp_req_dp_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_req_dp_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_dp_req_dp_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_req_dp_load),
        .fire       () );

  // - dp_abort_dapabort_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_abort_dapabort_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_dp_abort_dapabort_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_abort_dapabort_load),
        .fire       () );

  // - dp_cs_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_cs_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_dp_cs_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_cs_load),
        .fire       () );

  // - dp_sel_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_sel_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_dp_sel_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_sel_load),
        .fire       () );

  // - dp_cs_stickyerr_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_cs_stickyerr_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_dp_cs_stickyerr_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_cs_stickyerr_load),
        .fire       () );

  // - dp_cs_stickyorun_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_cs_stickyorun_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_dp_cs_stickyorun_load_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_cs_stickyorun_load),
        .fire       () );

  //jtag_state should never be X
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (4),
      .property_type       (`OVL_ASSERT),
      .msg                 ("jtag_state can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_jtag_state_x_check
      ( .clock      (tck),
        .reset      (n_trst),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (jtag_state),
        .fire       () );

  //jtag_sc[34:31] should never be x during UIR
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (4),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Instruction Scan Chain should never be x at UIR"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_jtag_inst_sc_x_check
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (jtag_state == JTAG_UIR),
        .test_expr  (jtag_sc_top[31:28]),
        .fire       () );

  //stickyorun should never be set when orundetect is low
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("It is UNP for STICKYORUN to be set while Overrun Detection is disabled"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_stickyorun_when_detect_low
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_stickyorun & (~dp_cs_orundetect)),
        .fire       () );

  //An AP transaction should not be started unless Select has been
  //initialised
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (2),
      .property_type       (`OVL_ASSERT),
      .msg                 ("An AP Transaction should not be started until SELECT initialised"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_started_aptx_while_banksel_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (start_ap_tx),
        .test_expr  (dp_sel_apbanksel),
        .fire       () );

  //An AP request should not be started with an unknown APBANKSEL
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (2),
      .property_type       (`OVL_ASSERT),
      .msg                 ("An AP request should not be made with an unknown APBANKSEL"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_started_apreq_while_banksel_x
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (start_ap_req),
        .test_expr  (dp_sel_apbanksel_masked),
        .fire       () );

  //Enable terms to OR of AND mux must be zero or 1 hot
  ovl_zero_one_hot
    #(.severity_level      (`OVL_FATAL),
      .width               (6),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Input enables to OoA mux must be 1 hot (or zero)"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_jtag_sc_mux_zero_one_hot
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ({dp_out_en, shifted_en,
                      tap_id_en, dpidr_en, ctrlstat_en, evstat_en}),
        .fire       () );

  //If a legal AP transaction is started, the handshake should not be reset
  ovl_zero_one_hot
    #(.severity_level      (`OVL_FATAL),
      .width               (2),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Handshake Reset Sequence should not occur for a legal AP transaction"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_reset_handshake_ap_tx_zero_one_hot
      (
        .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ({reset_dp_ap_handshake_i, start_ap_tx_masked}),
        .fire       ()
      );

 //Detect Illegal Software Sequences
  // - Debugger should not try and access AP when CDBGPWRUPACK is low.
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP Transaction Attempted while AP powered down"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_ap_access_while_powereddown
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ( (start_ap_tx & (~dp_cs_cdbgpwrupack_i)) ),
        .fire       ());

  // - CxxxREQ can not be deasserted until the corresponding CxxxACK is seen,
  // nor can it be asserted unless the corresponding CxxxACK is low
  ovl_handshake  //DBGPWRUP
    #(.severity_level      (`OVL_INFO),
      .min_ack_cycle       (0),
      .max_ack_cycle       (0),
      .req_drop            (1),
      .deassert_count      (0),
      .max_ack_length      (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Illegal CDBGPWRUPREQ behaviour"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_cdbgpwrupreq_handshake
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .req        (dp_cs_cdbgpwrupreq),
        .ack        (dp_cs_cdbgpwrupack_i),
        .fire       () );

  ovl_handshake  //SYSPWRUP
    #(.severity_level      (`OVL_INFO),
      .min_ack_cycle       (0),
      .max_ack_cycle       (0),
      .req_drop            (1),
      .deassert_count      (0),
      .max_ack_length      (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Illegal CSYSPWRUPREQ behaviour"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_csyspwrupreq_handshake
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .req        (dp_cs_csyspwrupreq),
        .ack        (csyspwrupack_sync_i),
        .fire       () );

  // - The effect of setting a Ctrl/Stat field not implemented on MinDP is UNP
  ovl_never  //TRNCNT
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Setting TRNCNT to a non-zero value is UNP"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_trncnt_set
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_load & (|jtag_sc_top[21:12])),
        .fire       () );

  ovl_never  //MASKLANE
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Setting MASKLANE to a non-zero value is UNP"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_masklane_set
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_load & (|jtag_sc_top[11:8])),
        .fire       () );

  ovl_never  //TRNMODE
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Setting TRNMODE to a non-zero value is UNP"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_trnmode_set
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_load & (|jtag_sc_top[3:2])),
        .fire       () );

  // The effect of clearing ORUNDETECT while STICKYORUN is 1 is UNP
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Switching out of overrun detect mode while STICKYORUN is set is UNP"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_stickyorun_set
    (
      .clock        (tck),
      .reset        (dpreset_n),
      .enable       (1'b1),
      .test_expr    (dp_cs_load & (~jtag_sc_top[0]) & (~jtag_sc_top[1]) & dp_cs_stickyorun),
      .fire       ()
    );

  //sticky_err_detected should never be set when dp_out_en is low
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Sticky Err Detected should never be set when dp_out_en is low"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_stickyerr_det_mask
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (ap_err_dp_i & (~dp_err_out_en)),
        .fire       () );

  // - The Select register should be initialised before attempting an AP tx
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (2),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Select register must be initialised before attempting an AP tx"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_select_uninit
      ( .clock      (tck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (start_ap_tx),
        .test_expr  (dp_sel_apbanksel),
        .fire       () );

`endif

endmodule

