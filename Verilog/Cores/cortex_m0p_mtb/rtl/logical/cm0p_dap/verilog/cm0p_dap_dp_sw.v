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
//   Checked In : $Date: 2012-12-06 15:23:14 +0000 (Thu, 06 Dec 2012) $
//   Revision   : $Revision: 230813 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_dap_dp_sw
  #(parameter CBAW    = 0,
    parameter JTAGnSW = 0,
    parameter SWMD    = 0,  //1 -> For Serial Wire multi-drop support
    parameter HALTEV  = 0,  //1 -> Debug halt event is supported
    parameter RAR     = 0
    )
   (//Clocks and resets
    input  wire        swclk,                  //SW Clock
    input  wire        dpreset_n,              //DP PO Reset

    //SW Connections
    input  wire        swdi_i,                 //SW Data In
    output wire        swdo_o,                 //SW Data Out
    output wire        swdoen_o,               //SW Data Out Enable
    output wire        swdetect_o,             //SW Detect line reset

    //Internal DAP Connections
    // - To Transfer Module
    output wire [31:0] dp_data_dp_o,           //Data from DP to AP for AP transaction
    output wire  [3:0] dp_regaddr_dp_o,        //AP Register Address for an AP Transaction
    output wire        dp_rnw_dp_o,            //RnW For AP Transaction
    output wire        dp_wr_en_o,             //Load transfer register with above data
    output wire        dp_out_en_o,            //Mask for ap_data_dp input
    output wire        dp_err_out_en_o,        //Mask for error flags from AP

    // - From Transfer Module
    input  wire [31:0] ap_data_dp_i,           //Returned data from result of AP transaction
    input  wire        ap_err_dp_i,            //Error response from AP transaction

    // - Synchronisation Handshake Signals
    input  wire        dp_req_dp_i,            //Request AP to complete a transaction
    output wire        dp_req_dp_load_o,       // Load Enable for dp_req_dp register in CDC block
    input  wire        ap_ack_dp_i,            //Transaction complete acknowledge from AP

    // - Debug halt event
    input  wire        halted_n_i,             //Processor halted (active low)

    // - Power Management Connections
    input  wire        csyspwrupack_sync_i,    //Sync'd System Power Domain Power Up Ack
    input  wire        dp_cs_cdbgpwrupack_i,   //Software Power Up Ack
    output wire        csyspwrupreq_o,         //System Power Domain Power Up Request
    output wire        dp_cs_cdbgpwrupreq_o,   //Debug Power Domain Power Up Request

    input  wire        reset_dp_ap_handshake_i,//DP/AP handshake should be reset

    // - Configuration
    input  wire [31:0] targetid_i,             // TARGETID for DP architecture 2
    input  wire [3:0]  instanceid_i,           // DLPIDR[31:28] for Serial Wire protocol 2
    input  wire [3:0]  ecorevnum_i,            // Configurable DPIDR Revision Field

    // Scan Enable for DFT
    input  wire        DFTSE
    );

// ----------------------------------------------------------------------------
// `define's
// ----------------------------------------------------------------------------
//  `include "cm0p_dap_dp_sw_defs.v"

// ----------------------------------------------------------------------------
// Configurablility
// ----------------------------------------------------------------------------
  wire     cfg_sw;
  wire     cfg_swmd;
  wire     cfg_haltev;
  wire     cfg_rar;

  generate
    if (CBAW == 0) begin : gen_cbaw
      assign cfg_sw     = (JTAGnSW == 0);
      assign cfg_swmd   = (SWMD    != 0);
      assign cfg_haltev = (HALTEV  != 0);
      assign cfg_rar    = (RAR     != 0);
    end
  endgenerate

// ----------------------------------------------------------------------------
// Signal Declarations
// ----------------------------------------------------------------------------

  // Registers which do not usually have a reset term will use this reset
  // signal, connected to dpreset_n or tied high depending on whether Reset
  // All Registers (RAR) is required.
  wire          rar_reset_n = cfg_rar ? dpreset_n : 1'b1;

  wire          swdo;
  reg           swdoen;
  wire          swdetect;
  wire   [31:0] dp_data_dp;
  wire    [3:0] dp_regaddr_dp;
  wire          dp_rnw_dp;
  wire          dp_wr_en;
  wire          dp_out_en;
  wire          dp_err_out_en;
  // - CxxxREQ signals are registered as they are set by writing to the
  // CTRL/STAT register
  reg           dp_cs_csyspwrupreq;
  reg           dp_cs_cdbgpwrupreq;
  reg           dp_cs_cdbgrstreq;

  //Control For Top Level Internal Signals
  // - swdi_int is a masked, registered version of swdi_i, to prevent metastability
  // as a result of sampling a changing signal, for example during turnaround,
  // resulting in internal state, particularly the sw_state state machine,
  // from making logically impossible state transitions.
  wire          swdi_int_sw;
  wire          swdi_int_swmd;
  wire          swdi_int;
  wire          swdi_int_en;          //Enable for mask on swdi_int
  // - swdi_sync is 2-register synchronised to minimise the chance of metastabilty
  // resulting in the sw_state state machine making logically impossible state
  // transitions during dormant state activation when, for example,  SWDI could
  // be used asynchronously by an alternative protocol.
  wire          swdi_sync;

  wire          swdoen_next;          //Input to swdoen

  // - dp_req_dp Control
  wire          dp_req_dp_load;       //Load enable for dp_req_dp_i register

  //State Machine
  wire    [8:0] sw_state;             //SW State Machine
  reg           sw_step_ndat;         //Step to next sequential state from normal states
  wire          sw_step_norm;         //Step to next sequential state from normal states
  reg     [8:0] sw_next_norm;         //Next state during normal states
  wire          sw_step_reset;        //Step to next sequential state from reset states
  wire    [8:0] sw_next_reset;        //Next state during line reset states
  reg           sw_step_dmnt;         //Step to next sequential state from dormant states
  reg     [8:0] sw_next_dmnt;         //Next state during dormant entry/exit states
  wire    [8:0] sw_next_lfsr;         //Next state during dormant lfsr comparison
  reg           sw_step_mux;          //Next state is sequential
  wire    [8:0] sw_next_step;         //Next sequential state
  reg     [8:0] sw_next_mux;          //Next nen-sequential state
  wire    [8:0] sw_next;              //Input to sw_state

  // - During the count states, the following signals are used to determine
  // the next state:
  wire          count_50;             //Set when Count reaches 50
  wire    [6:0] count_inc;            //Count increment

  //Packet Data
  reg     [3:0] packet;               //4 bit shift reg to store packet data
  wire          packet_shift;         //Shift enable for packet
  wire    [3:0] packet_next;          //Input to packet
  wire          packet_ap_ndp;        //APnDP
  wire          packet_r_nw;          //RnW
  wire    [1:0] packet_reg_addr;      //2 Bit A[3:2]

  wire          non_waitable_tx;      //Set when the current transaction cannot
                                      //generate a WAIT/FAULT response.
  wire          dpidr_dec;            //DPIDR register read decoded
  wire          resend_acc;           //Set when RESEND register is being accessed
  wire          trn_write;            //Set when TRN field of DLCR is written
  wire          tsel_dec;             //Target Selection register write decoded
  wire          targetsel;            //Target selected during TARGETSEL write

  //Parity Generation & Checking
  reg           parity;               //1 flop is used to generate parity in series
  wire          parity_next;          //Input to parity flop
  wire          parity_load;          //Load enable to parity flop
  wire          parity_generate;      //Parity OoA mux enable terms
  wire          parity_ack_ok_en;
  wire          parity_ack_wait_en;
  wire          parity_ack_fault_en;
  wire          parity_reset;         //Synchronous reset for parity flop
  wire          parity_source;        //Data stream from which parity is generated
  wire          sw_parity_err;        //Parity error indication
  wire          sw_data_end_ok;       //End of data phase in an OK-ACK transaction

  //SW Shift Register
  // - This register is loaded by an OoA multiplexer
  reg    [31:0] sw_data;
  // - Mux Control Signals
  wire          ap_acc;               //Set when AP data is addressed by tx
  wire          sw_header_valid;      //Set when a valid SW header is received
  wire          sw_reg_load;          //Load sw_data with DP register
  wire          sw_data_dpidr_en;     //DPIDR Register Term Enable
  wire          sw_data_ctrlstat_en;  //Ctrl/Stat Register Term Enable
  wire          sw_data_dlcr_en;      //DLCR Register Term Enable
  wire          sw_data_targetid_en;  //TARGETID Register Term Enable
  wire          sw_data_dlpidr_en;    //DLPIDR Register Term Enable
  wire          sw_data_evstat_en;    //EVENTSTAT Register Term Enable
  wire          sw_data_shift;        //Load shifted data into shift reg
  // - Mux Data Signals
  wire   [31:0] sw_data_shifted;      //Shift register input to sw_data
  wire   [31:0] sw_data_next;         //Mux Ouptut - Input to register
  // - Register Control Signals
  wire          sw_data_load;         //Load enable for shift reg

  //Control Signals
  wire          perform_tx;           //Set when a transaction should be initiated
  wire          dp_write;             //Set when a DP register should be written
  wire          start_ap_tx;          //Set when an AP transaction should be started
  wire          start_ap_tx_masked;
  wire          start_ap_req;         //Set when a request is to be made to the AP

  //DAP Status Signals
  wire          ap_interface_busy;    //AP is in control of DP/AP Interface
  wire          ap_busy_inst;         //AP transaction intiated
  reg           ap_busy_regd;         //Registered version of ap_busy_inst
  wire          ap_busy_regd_load;    //Load enable to ap_busy_regd
  wire          ap_pwr_on;            //AP power status flag

  //DP Registers
  // - dp_ctrlstat
  wire   [31:0] dp_ctrlstat;          //Composite CTRL/STAT register
  reg           dp_cs_wdataerr;       //Bit[7] of CTRL/STAT (WDATAERR)
  reg           dp_cs_readok;         //Bit[6] of CTRL/STAT (READOK)
  reg           dp_cs_stickyerr;      //Bit[5] of CTRL/STAT (STICKYERR)
  reg           dp_cs_stickyorun;     //Bit[1] of CTRL/STAT (STICKYORUN)
  reg           dp_cs_orundetect;     //Bit[0] of CTRL/STAT (ORUNDETECT)
  //dp_cs_load is used to load the CTRL/STAT fields which are set on
  //a write to the CTRL/STAT register, i.e. the CxxxREQ fields. The error
  //fields are loaded by the relevant error condition or flag reset.
  wire          dp_cs_load;
  //Control Status Register Error flag signals:
  wire          wdataerr_detected;
  wire          dp_cs_wdataerr_load;
  wire          dp_cs_wdataerr_next;
  wire          stickyerr_detected;
  wire          dp_cs_stickyerr_load;
  wire          dp_cs_stickyerr_next;
  wire          dp_cs_readok_load;
  wire          dp_cs_readok_next;
  wire          dp_cs_stickyorun_load;
  wire          dp_cs_stickyorun_next;
  wire          stickyorun_detected;

  // - dp RO registers
  wire   [31:0] dp_dlcr;
  wire   [31:0] dp_targetid;
  wire   [31:0] dp_dlpidr;
  wire   [31:0] dp_evstat;
  // - dp_sel
  reg           dp_sel_apsel;             //Encoded [31:24] of Select Register
  wire          dp_sel_apsel_next;        //Input to dp_sel_apsel
  reg     [1:0] dp_sel_apbanksel;         //Encoded [7:4] of Select Register
  wire    [1:0] dp_sel_apbanksel_next;    //Input to dp_sel_apbanksel
  wire          dp_sel_apbanksel_next_1;  //Each bit is encoded separately
  wire          dp_sel_apbanksel_next_0;
  wire    [1:0] dp_sel_apbanksel_masked;
  wire    [2:0] dp_sel_dpbanksel;         //Recoded Select register
  wire          dp_sel_load;              //Enable for Select registers

  // - dp_abort
  wire          dp_abort_execute;         //Set on a write to the abort register
  wire          dp_abort_stkorun_clr;     //Bit[4] of Abort, clears sticky orun
  wire          dp_abort_wdataerr_clr;    //Bit[3] of Abort, clears wdataerr
  wire          dp_abort_stkerr_clr;      //Bit[2] of Abort, clears sticky error
  reg           dp_abort_dapabort;        //Bit[0] of Abort, indicates an abort
  wire          dp_abort_dapabort_next;   //Input to dp_abort_dapabort
  wire          dp_abort_dapabort_load;   //Load enable for dp_abort_dapabort

  //Ack Signals
  wire          ack_ok_inst;              //ACK OK    during state  SW_ST_PARK
  wire          ack_ok_ack0;              //ACK OK    during states SW_ST_ACK0(_NODAT)
  wire          ack_ok_ack1;              //ACK OK    during states SW_ST_ACK1(_NODAT)
  wire          ack_wait_inst;            //ACK WAIT  during state  SW_ST_PARK
  wire          ack_fault;                //ACK FAULT valid at all times

  wire   [31:0] dp_idr_raw;               // Raw value of DPIDR
  wire   [31:0] dp_idr;                   // Value of DPIDR including ECO

  // Outputs
  assign swdo_o                 = swdo;
  assign swdoen_o               = swdoen;
  assign swdetect_o             = swdetect;
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
// SW State Machine
// ----------------
  //There is a single state machine to control all the DP operations,
  //including decoding the SW protocol. The protocol requires that a line reset
  //is performed by holding SWDI high for 50 cycles and that the first
  //transaction after the line reset is a read of the DPIDR.
  //To detect this, extra states are added which count through 50 consecutive
  //1's, and extra shadow states are used for the SW packet decoding to check
  //that the first transaction after this is a read of the DPIDR.
  //
  //Although the SW State Machine has 114 possible states, many of the states
  //simply progress from one state to the next as a counter. To save area in
  //the synthesis, rather than using a case statement to determine every
  //possible next state, a hybrid between case statement and counter is used.
  //The lower 5 bits of the state machine are still set using a case
  //statement during the "non-counting" states, however, when one of the
  //upper two bits is set, the next state is determined using an adder to
  //increment the state sequentially.
  //
  //Note that since SWDI is registered, when the debugger is driving the line
  //the SM is one state behind the line. To allow it to catch up after the
  //debugger finishes driving the line and the DAP starts driving it, the TRN
  //state is skipped. After the DAP has finished driving the line, and the
  //debugger resumes driving it, there are two TRN states instead of 1: one to
  //come back inline with the delayed debugger data, and one for the actual
  //TRN state driven on the line.
  //
// ----------------------------------------------------------------------------

  wire [8:0] sw_next_parity_rst = (swdi_int ?
                                   (packet[3] ?
                                    (packet[2] ?
                                     (packet[1] ?
                                      (packet[0] ?
                                       SW_ST_RST_6 :
                                       SW_ST_RST_4) :
                                      SW_ST_RST_3) :
                                     SW_ST_RST_2) :
                                    SW_ST_RST_1) :
                                   SW_ST_RST_0);

  wire [8:0] sw_next_stop_rst   = (parity ?
                                   (packet[3] ?
                                    (packet[2] ?
                                     (packet[1] ?
                                      (packet[0] ?
                                       SW_ST_RST_7 :
                                       SW_ST_RST_5) :
                                      SW_ST_RST_4) :
                                     SW_ST_RST_3) :
                                    SW_ST_RST_2) :
                                   SW_ST_RST_1);

  //Determine next state during normal states
  always @*
    begin
      sw_step_ndat = 1'bx;
      sw_next_norm = {9{1'bx}};
      case (sw_state[4:0])
        //After the Data Parity state there will be a TRN for reads, and not
        //for writes.
        //If a write of a non-zero value to the TRN field of the DLCR is
        //detected here then it causes an immediate protocol error.
        //If a write to TARGETSEL matches continue waiting for DPIDR read
        //after line reset otherwise treat as protocol error.
        //For all other writes wait for next header.
        SW_ST_DATAPARITY[4:0]: begin
                                 sw_step_ndat = packet_r_nw; // SW_ST_ENDTRN0
                                 sw_next_norm = (tsel_dec
                                                 ? (targetsel
                                                    ? SW_ST_RST_START
                                                    : SW_ST_RST_0)
                                                 : (trn_write
                                                    ? SW_ST_RST_0
                                                    : SW_ST_START)
                                                 );
                               end
        SW_ST_ENDTRN0[4:0]   : sw_step_ndat = 1'b1;
        SW_ST_ENDTRN1[4:0]   : sw_step_ndat = 1'b1;
        //Wait for start bit
        SW_ST_START[4:0]     : begin
                                 sw_step_ndat = swdi_int; // SW_ST_APnDP
                                 sw_next_norm = SW_ST_START;
                               end
        //Advance through packet header
        SW_ST_APnDP[4:0]     : sw_step_ndat = 1'b1;
        SW_ST_RnW[4:0]       : sw_step_ndat = 1'b1;
        SW_ST_A0[4:0]        : sw_step_ndat = 1'b1;
        SW_ST_A1[4:0]        : sw_step_ndat = 1'b1;
        //If a parity error is detected then the SM must determine how many
        //consecutive 1's there were up to the parity state, and skip the
        //appropriate number of reset counter states so that a count of 50 1's
        //starting before the parity error is detected is not missed.
        //Note that is the packet was all 1's, then there will have been an
        //extra 1 in addition to the ones counted (the start bit).
        //Access to RESEND and TARGETSEL are treated as protocol errors
        SW_ST_PARITY[4:0]    : begin
                                 sw_step_ndat = ~(sw_parity_err | resend_acc | tsel_dec); // SW_ST_STOP
                                 sw_next_norm = sw_next_parity_rst;
                               end
        //If a stop bit error is detected, the correct entry state to the reset
        //count sequence is determined in the same way as for parity errors.
        //Note that at least one 1 will have been detected (the erroneous
        //stop bit).
        SW_ST_STOP[4:0]      : begin
                                 sw_step_ndat = ~swdi_int; // SW_ST_PARK
                                 sw_next_norm = sw_next_stop_rst;
                               end
        //If a Park error is detected then the number of consecutive 1's must
        //be 0 (as this will have been the park bit error).
        //Otherwise generate an ACK with or without a data phase depending on
        //whether the ACK is OK or overrun detect mode is enabled
        SW_ST_PARK[4:0]      : begin
                                 sw_step_ndat = swdi_int & (ack_ok_inst | dp_cs_orundetect); // SW_ST_ACK0
                                 sw_next_norm = swdi_int ? SW_ST_ACK0_NODAT : SW_ST_RST_0;
                               end
        //ACK States with data phase
        SW_ST_ACK0[4:0]      : sw_step_ndat = 1'b1;
        SW_ST_ACK1[4:0]      : sw_step_ndat = 1'b1;
        SW_ST_ACK2[4:0]      : begin
                                 sw_step_ndat = ~packet_r_nw; // SW_ST_ACKTRN0
                                 sw_next_norm = SW_ST_DATA0;
                               end
        SW_ST_ACKTRN0[4:0]   : sw_step_ndat = 1'b1;
        SW_ST_ACKTRN1[4:0]   : begin
                                 sw_step_ndat = 1'b0;
                                 sw_next_norm = SW_ST_DATA0;
                               end
        //ACK States without data phase
        SW_ST_ACK0_NODAT[4:0]: sw_step_ndat = 1'b1;
        SW_ST_ACK1_NODAT[4:0]: sw_step_ndat = 1'b1;
        SW_ST_ACK2_NODAT[4:0]: begin
                                 sw_step_ndat = 1'b0;
                                 sw_next_norm = SW_ST_ENDTRN0;
                               end
        //Reset Shadow States
        // - Wait for start bit after line reset
        SW_ST_RST_START[4:0] : begin
                                 sw_step_ndat = swdi_int; // SW_ST_RST_APnDP
                                 sw_next_norm = SW_ST_RST_START;
                               end
        //Advance through packet header
        SW_ST_RST_APnDP[4:0] : sw_step_ndat = 1'b1;
        SW_ST_RST_RnW[4:0]   : sw_step_ndat = 1'b1;
        SW_ST_RST_A0[4:0]    : sw_step_ndat = 1'b1;
        SW_ST_RST_A1[4:0]    : sw_step_ndat = 1'b1;
        //If a parity error is detected then the SM must determine how many
        //consecutive 1's there were up to the parity state, and skip the
        //appropriate number of reset counter states so that a count of 50 1's
        //starting before the parity error is detected is not missed.
        //Note that is the packet was all 1's, then there will have been an
        //extra 1 in addition to the ones counted (the start bit).
        //Only DPIDR reads and TARGETSEL writes are allowed all other accesses
        //are treated as protocol errors
        SW_ST_RST_PARITY[4:0]: begin
                                 sw_step_ndat = 1'b0;
                                 sw_next_norm = (((dpidr_dec | tsel_dec) & ~sw_parity_err)
                                                 ? SW_ST_STOP
                                                 : sw_next_parity_rst);
                               end
        //If the SM enters an unused state (e.g. due to meta-stability), then
        //the next state will always be the start of a line reset count,
        //forcing a line reset in this case.
        SW_ST_UNUSED0[4:0],
        SW_ST_UNUSED1[4:0],
        SW_ST_UNUSED2[4:0],
        SW_ST_UNUSED3[4:0],
        SW_ST_UNUSED4[4:0],
        SW_ST_UNUSED5[4:0],
        SW_ST_UNUSED6[4:0]   : begin
                                 sw_step_ndat = 1'b0;
                                 sw_next_norm = SW_ST_RST_0;
                               end
        default              : begin
                                 sw_step_ndat = 1'bx;
                                 sw_next_norm = {9{1'bx}};
                               end   //X-Propagation
      endcase // case(sw_state[4:0])
    end

  // Sequential state step all data states within normal states
  assign sw_step_norm = sw_step_ndat | (sw_state[5] == SW_ST_DATA0[5]);

  //Count States
  // - count_50 is set once 50 consecutive 1's have been counted. Note that
  // sw_state[5:0] can never exceed 50 in normal use when counting consecutive
  // values. The test has been optimized for area under this assumption.
  // If the state machine reaches states above 50, the behaviour is the same
  // as state 50 or one of the lower reset states for predictable operation.
  assign count_50 = sw_state[5] & sw_state[4] & sw_state[1];

  // The counter increments unconditionally and provides the next state for
  // sequential states; its output value is selected by the multiplexer if
  // required.
  assign count_inc = sw_state[5:0] + 1'b1;

  // Next state for sequential steps
  assign sw_next_step = {sw_state[8:6], count_inc[5:0]};

  // - sw_step_reset and sw_next_reset are the next state input to the state
  // register when in reset states
  assign sw_step_reset = swdi_int & ~count_50;
  assign sw_next_reset = (count_50
                          ? (swdi_int
                             ? SW_ST_RST_50
                             : (cfg_swmd
                                ? SW_ST_DENT_0
                                : SW_ST_RST_START
                                )
                             )
                          : SW_ST_RST_0
                          );

  // Determine next state during dormant states
  // sw_state[5] is not included in the decode to minimise area so these
  // states alias in a region of unused state encodings.
  always @*
    begin
      sw_step_dmnt = 1'bx;
      sw_next_dmnt = {9{1'bx}};
      case (sw_state[4:0])
        // Dormant state entry immediately following LINERESET
        // First 0 has already been detected
        // Check for start of a DP access which could be
        // to DPIDR or TARGETSEL
        // SWDI set is a normal start bit
        SW_ST_DENT_0[4:0]      : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_RST_APnDP;
                                 end
        // SWDI not set so just wait for a start bit
        SW_ST_DENT_1[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_START;
                                 end
        // Start bit and SWDI not set so handle reset DP access
        SW_ST_DENT_2[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_RnW;
                                 end
        // Only dormant state entry may be detected from now on
        SW_ST_DENT_3[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_DENT_4[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_DENT_5[4:0]      : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_RST_5;
                                 end
        SW_ST_DENT_6[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_DENT_7[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_DENT_8[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_DENT_9[4:0]      : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_RST_4;
                                 end
        SW_ST_DENT_A[4:0]      : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_RST_1;
                                 end
        SW_ST_DENT_B[4:0]      : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_RST_1;
                                 end
        SW_ST_DENT_C[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_DENT_D[4:0]      : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_DENT_E[4:0]      : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = swdi_int
                                                  ? SW_ST_DLFSR_WAIT
                                                  : SW_ST_RST_0;
                                 end
        SW_ST_UNUSED8[4:0]     : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_UNUSED9[4:0]     : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_UNUSED10[4:0]    : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_UNUSED11[4:0]    : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_UNUSED12[4:0]   : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        SW_ST_UNUSED13[4:0]   : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = SW_ST_RST_0;
                                 end
        // Alert sequence has four bits after lfsr before activation
        // which may be ignored. Since the 2-flop synchroniser
        // was being used in the previous state, SW_ST_DLFSR_END,
        // and future states will observe swdi_int, only three
        // states are required
        SW_ST_ALRT0_0[4:0]     : sw_step_dmnt = 1'b1;
        SW_ST_ALRT0_1[4:0]     : sw_step_dmnt = 1'b1;
        SW_ST_ALRT0_2[4:0]     : sw_step_dmnt = 1'b1;
        // Serial Wire Activation code
        SW_ST_SWACT_0[4:0]     : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_DLFSR_WAIT;
                                 end
        SW_ST_SWACT_1[4:0]     : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_DLFSR_WAIT;
                                 end
        SW_ST_SWACT_2[4:0]     : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_DLFSR_WAIT;
                                 end
        SW_ST_SWACT_3[4:0]     : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_DLFSR_WAIT;
                                 end
        SW_ST_SWACT_4[4:0]     : begin
                                   sw_step_dmnt = swdi_int;
                                   sw_next_dmnt = SW_ST_DLFSR_WAIT;
                                 end
        SW_ST_SWACT_5[4:0]     : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_DLFSR_WAIT;
                                 end
        SW_ST_SWACT_6[4:0]     : begin
                                   sw_step_dmnt = ~swdi_int;
                                   sw_next_dmnt = SW_ST_DLFSR_WAIT;
                                 end
        SW_ST_SWACT_7[4:0]     : begin
                                   sw_step_dmnt = 1'b0;
                                   sw_next_dmnt = swdi_int
                                                  ? SW_ST_DLFSR_WAIT
                                                  : SW_ST_RST_0;
                                 end
        default                : begin
                                   sw_step_dmnt = 1'bx;
                                   sw_next_dmnt = {9{1'bx}};
                                 end   //X-Propagation
      endcase // case(sw_state[4:0])
    end

  // - sw_next_lfsr is the next state input to the state register when
  // in dormant state detecting an activation sequence
  assign sw_next_lfsr  = ((swdi_sync == sw_state[0])
                          ? (// SWDI matches so start, end or continue detection
                             ((sw_state == SW_ST_DLFSR_WAIT)
                              ? SW_ST_DLFSR_START
                              : ((sw_state == SW_ST_DLFSR_END)
                                 ? SW_ST_ALRT0_0
                                 : {2'b10,
                                    sw_state[6] ^ sw_state[3] ^ sw_state[1] ^ sw_state[0],
                                    sw_state[6:1]}
                                 )
                              )
                             )
                          : (// SWDI mismatch so restart
                             SW_ST_DLFSR_WAIT
                             )
                          );

  //SW State Register
  // - sw_step_mux indicates whether the next state is sequential
  always @*
    case (sw_state[8:6])
      3'b000:  sw_step_mux = sw_step_norm;
      3'b001:  sw_step_mux = sw_step_reset;
      3'b010:  sw_step_mux = sw_step_dmnt;
      3'b011:  sw_step_mux = 1'b0;
      3'b100,
      3'b101:  sw_step_mux = 1'b0;
      3'b110,
      3'b111:  sw_step_mux = 1'b0;
      default: sw_step_mux = 1'bx;
    endcase

  // - sw_next_mux is the muxed input to sw_state for non-sequential states
  always @*
    case (sw_state[8:6])
      3'b000:  sw_next_mux = sw_next_norm;
      3'b001:  sw_next_mux = sw_next_reset;
      3'b010:  sw_next_mux = sw_next_dmnt;
      3'b011:  sw_next_mux = SW_ST_RST_0;
      3'b100,
      3'b101:  sw_next_mux = sw_next_lfsr;
      3'b110,
      3'b111:  sw_next_mux = SW_ST_RST_0;
      default: sw_next_mux = {9{1'bx}};
    endcase

  assign sw_next = sw_step_mux ? sw_next_step : sw_next_mux;

  // - sw_state
  // The reset state is RST_6, as a line reset is required after a reset, and
  // a 6-cycle margin allows for the use of reset synchronizers.
  // Generate sw_state register optimised for area with 9 or 7 bits
  // depending on wither Serial Wire protocol 2 is configured
  generate
    if ((CBAW != 0) || (SWMD != 0)) begin : gen_sw_state9

      wire [8:0] sw_state_reset = cfg_swmd ? SW_ST_DLFSR_WAIT : SW_ST_RST_6;

      reg  [8:0] sw_state_reg;

      always @(posedge swclk or negedge dpreset_n)
        if (!dpreset_n)
          sw_state_reg <= sw_state_reset;
        else
          sw_state_reg <= sw_next;

      assign sw_state = sw_state_reg;

    end else begin : gen_sw_state7

      wire [1:0] unused = sw_next[8:7];

      reg  [6:0] sw_state_reg;

      always @(posedge swclk or negedge dpreset_n)
        if (!dpreset_n)
          sw_state_reg <= SW_ST_RST_6[6:0];
        else
          sw_state_reg <= sw_next[6:0];

      assign sw_state = {2'b0, sw_state_reg};

    end
  endgenerate

// ----------------------------------------------------------------------------
// SW Packet Decode
// ----------------
  //Every SW Transaction starts with a packet, driven by the host, comprised
  //of the following data used to specify the transaction:
  //  APnDP  - Whether the Transaction is to an AP or DP Register
  //  RnW    - Whether the Transaction is a read or a write
  //  A[3:2] - The address of the register being accessed
  //
  //This data is stored in a 4 bit shift register, with the relevant bits
  //connected to wires for the different fields. These are then used to
  //control the DP operation for the rest of the packet. The RnW and A[3:2]
  //bits are also passed to the AP on AP transactions.
  //
  //The packet data is loaded during normal transactions, but also during the
  //DPIDR read as part of a line reset. This means the registers have to be
  //enabled by both the relevant main state machine states, and reset shadow
  //states.
// ----------------------------------------------------------------------------
  assign packet_shift = ( ((sw_state & SW_ST_HDR_MASK) == SW_ST_APnDP) |
                          ((sw_state & SW_ST_HDR_MASK) == SW_ST_RnW) |
                          ((sw_state & SW_ST_HDR_MASK) == SW_ST_A0) |
                          ((sw_state & SW_ST_HDR_MASK) == SW_ST_A1) |
                          (sw_state == SW_ST_DENT_2) // APnDP
                        );

  assign packet_next = {swdi_int, packet[3:1]};

  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_packet_rar

      always @(posedge swclk or negedge rar_reset_n)
        if (!rar_reset_n)
          packet <= 4'b1111;
        else if (packet_shift)
          packet <= packet_next;

    end else begin : gen_packet

      wire unused = rar_reset_n;

      always @(posedge swclk)
        if (packet_shift)
          packet <= packet_next;

    end
  endgenerate

  assign packet_ap_ndp    = packet[0];
  assign packet_r_nw      = packet[1];
  assign packet_reg_addr  = packet[3:2];

// ----------------------------------------------------------------------------
// Parity Generation & Checking
// ----------------------------
  //Parity data is generated by serially shifting data through a register.
  //When the input to the register is 1, its value is flipped; when the input
  //is 0, it is preserved. This means that after the data has been shifted
  //through, the register will store the correct parity value which can
  //either be checked against the supplied parity bit (for data driven by
  //the host) or driven onto SWDO (for data driven by the DAP).
  //
  //By resetting the parity register to either 1 or 0 at the start of the
  //serial data word, even or odd parity can be generated. Even parity is
  //used in SW, so the register is reset to 0.
  //
  //The DAP must be able to both generate and check parity, so the input to
  //the register must be able to be driven by either SWDI or SWDO.
  //
  //The parity register is also used to register the acknowledge responses in
  //the ACKx states, to reduce the combinatorial paths onto SWDO. The
  //multiplexing between the different inputs to the register is performed
  //using an OR-of-ANDs mux to reduce area.
// ----------------------------------------------------------------------------

  assign parity_source = (sw_data_shift & packet_r_nw) ? swdo
  //Parity is generated on data shifted out during a read transaction
                                                       : swdi_int;
  //and checked at all other times

  //The parity value is reset at the start of parity generation/checking
  //The value is reset for the 32 bit data word at the end of the ACK state,
  //which is necessary for read data, and at ACKTRN1 for writes.
  assign parity_reset = ( ((sw_state & SW_ST_HDR_MASK) == SW_ST_START)
                        | ((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK2)
                        | (sw_state == SW_ST_ACKTRN1)
                        | (sw_state == SW_ST_DENT_0)
                        | (sw_state == SW_ST_DENT_1) );

  //A parity value is generated during the packet APnDP, RnW and A[3:2]
  //states, as well as when the 32 bit data word is being shifted in/out.
  assign parity_generate = (packet_shift | sw_data_shift);

  //OoA Mux Control Inputs
  // - Note ack inputs are loaded a cycle before they are to be driven onto
  // SWDO
  assign parity_ack_ok_en     = (sw_state == SW_ST_PARK);
  assign parity_ack_wait_en   = ((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK0);
  assign parity_ack_fault_en  = ((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK1);

  //Parity next is the input to the parity register, i.e. the output of the
  //OoA mux
  assign parity_next =  (parity_generate      & (parity ^ parity_source))   |
                        (parity_ack_ok_en     & ack_ok_inst)                |
                        (parity_ack_wait_en   & ~(ack_ok_ack0 | ack_fault)) |
                        (parity_ack_fault_en  & ack_fault);

  //The parity register is loaded when parity is being generated or the
  //register is being synchronously reset, or any of the mux enable terms are
  //asserted
  assign parity_load =  parity_reset        |
                        parity_generate     |
                        parity_ack_ok_en    |
                        parity_ack_wait_en  |
                        parity_ack_fault_en;

  //Parity Register
  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_parity_rar

      always @(posedge swclk or negedge rar_reset_n)
        if (!rar_reset_n)
          parity <= 1'b1;
        else if (parity_load)
          parity <= parity_next;

    end else begin : gen_parity

      always @(posedge swclk)
        if (parity_load)
          parity <= parity_next;

    end
  endgenerate

  // Parity Check
  // If the incoming bit is different from the generated parity bit, this
  // bit is asserted to signal a parity error.
  assign sw_parity_err = (swdi_int ^ parity);

// ----------------------------------------------------------------------------
// Logical DP Registers
// --------------------
  //The SW DP Programmers Model is:
  //A[3:2] DPBankSel RnW  Register
  // 0x0       X      R     DPIDR
  // 0x0       X      W     Abort
  // 0x4     0x0      X   Ctrl/Stat  - only bit[0] decoded for arch 1 unless
  // 0x4     0x1      X     DLCR
  // 0x4     0x2      X   TARGETID   - DP Architecture 2 only
  // 0x4     0x3      X    DLPIDR    - DP Architecture 2 only
  // 0x4     0x4      X    EVSTAT    - if HALTEV supported
  // 0x8       X      R    Resend
  // 0x8       X      W    Select
  // 0xC       X      R    RDBUFF
  // 0xC       X      W   Reserved
  //
  //All DP Logical Register names are preceded in the RTL by dp_. The
  //individual fields making up composite registers are preceded by
  //dp_regname_.
// ----------------------------------------------------------------------------
  //CONTROL SIGNALS
  //sw_data_end_ok is asserted at the end of the data phase of a transaction
  //which has returned an OK response.
  //ack_fault is only used to mask out data parity errors when writes are
  //ignored in overrun detection mode (outside overrun mode the data parity
  //state is unreachable in the case of a WAIT or FAULT). In overrun mode the
  //FAULT and WAIT (implicitly) are checked as ack_fault is asserted as soon
  //as the STICKYORUN error bit is set.
  assign sw_data_end_ok = (sw_state == SW_ST_DATAPARITY) &
                          (~ack_fault);

  //perform_tx is asserted at the end of the data phase, and is used to form the
  //loads for DP registers, the abort signals and is used to generate the AP
  //synchronisation handshake signals to start an AP transaction. It is only
  //generated when correct parity is detected on data (this is guaranteed for
  //read data as the DAP generates the parity, and ensures that corrupted
  //data does not get written).
  assign perform_tx = sw_data_end_ok &
                      ( (~sw_parity_err) | packet_r_nw );

  //dp_write is asserted when a DP register should be written.
  assign dp_write = perform_tx & (~packet_ap_ndp) & (~packet_r_nw);

  //Non-Waitable Accesses are reads of the DPIDR or CTRL/STAT register, and
  //writes to the Abort Register or Target Selection register.
  //non_waitable_tx is used to indicate one of these accesses.
  assign non_waitable_tx = (~packet_ap_ndp) &
                           ( //Abort & DPIDR are same address
                             (packet_reg_addr == SW_REGADDR_DPIDR) |
                             //Ctrl/Stat is only selected when dpbanksel is 0
                             ( (packet_reg_addr == SW_REGADDR_DPBANK)
                               & (dp_sel_dpbanksel == SW_DPBANK_CTRLSTAT) & packet_r_nw) |
                             //Target Selection Register writes
                             tsel_dec
                           );

  //REGISTERS
  //Abort Register
  //The abort register is WO and its effects are immediate, so it is not
  //physically implemented.
  //The abort register is used to clear error flags, which is implemented via
  //the following signals
  assign dp_abort_execute = dp_write
                            & (packet_reg_addr == SW_REGADDR_ABORT);

  assign dp_abort_wdataerr_clr = dp_abort_execute & sw_data[3];
  assign dp_abort_stkerr_clr   = dp_abort_execute & sw_data[2];

  //A DAPABORT has be to stored, as it affects the subsequent operation of
  //the DP. In CORTEX-M0+DAP, a DAPABORT has no effect on the AP, however it
  //free's up access to all of the DP registers. It is only asserted when the AP
  //is busy, in case the AP naturally becomes free after an ABORT is issued
  //then this clears the abort.
  assign dp_abort_dapabort_next = ap_busy_regd;

  assign dp_abort_dapabort_load = (dp_abort_execute & sw_data[0]) |
                                  //Set on write to abort
                                  dp_abort_dapabort;  //Then loads until cleared

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      dp_abort_dapabort <= 1'b0;
    else if (dp_abort_dapabort_load)
      dp_abort_dapabort <= dp_abort_dapabort_next;

  //Control/Status Register
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
                          dp_cs_wdataerr,       //[7]     RO
                          dp_cs_readok,         //[6]     RO
                          dp_cs_stickyerr,      //[5]     RO
                          1'b0,                 //[4]     StickyCmp (RAZ in MinDP)
                          2'b00,                //[3:2]   TRNMODE (RAZ in MinDP)
                          dp_cs_stickyorun,     //[1]     STICKYORUN
                          dp_cs_orundetect      //[0]     ORUNDETECT
                       };

  //NB The Error Flag fields are not loaded with the other ctrl/stat fields
  //as they are set and cleared by different signals.
  assign dp_cs_load = dp_write
                      & (dp_sel_dpbanksel == SW_DPBANK_CTRLSTAT)
                      & (packet_reg_addr == SW_REGADDR_DPBANK);

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n) begin
      dp_cs_csyspwrupreq    <= 1'b0;
      dp_cs_cdbgpwrupreq    <= 1'b0;
      dp_cs_cdbgrstreq      <= 1'b0;
      dp_cs_orundetect      <= 1'b0;
    end
    else if (dp_cs_load) begin
      dp_cs_csyspwrupreq    <= sw_data[30];
      dp_cs_cdbgpwrupreq    <= sw_data[28];
      dp_cs_cdbgrstreq      <= sw_data[26];
      dp_cs_orundetect      <= sw_data[0];
    end

  //Datalink Control Register (DLCR) (Read Only)
  assign dp_dlcr = { {22{1'b0}},     //[31:10] SBZ/RAZ
                     2'b00,          //[9:8]   TURNAROUND (RO), 00 => 1 Cycle
                     2'b01,          //[7:6]   Wiremode (RO), 01 => Synchronous
                     3'b000,         //[5:3]   SBZ/RAZ
                     3'b000          //[2:0]   Prescaler
                     };

  // Target Identification Register (RO) (SWMD config only)
  assign dp_targetid = { targetid_i[31:1], 1'b1};

  // TARGETID[0] is RAO so ignore configuration input to minimise area
  wire   unused_tid = targetid_i[0];

  // Data Link Protocol Identification Register (RO) (SWMD config only)
  assign dp_dlpidr = { instanceid_i[3:0],  // 31:28 Target Instance
                       {24{1'b0}},         // 27: 4 Reserved UNK
                       4'b0001};           //  3: 0

  //Event Status Register (EVENTSTAT) (Read Only)
  assign dp_evstat = { {31{1'b0}},     //[31:1] SBZ/RAZ
                       halted_n_i      //[0]    Processor halted event (active low)
                       };

  //DPIDR
  //Decode an attempt to read dpidr
  assign dpidr_dec =  (~packet_ap_ndp) & packet_r_nw &
                      (packet_reg_addr == SW_REGADDR_DPIDR);

  //The TURNAROUND field is deprecated, and writing a value other than b00 to
  //it must be treated as a protocol error.
  assign trn_write =  dp_write &
                      (dp_sel_dpbanksel == SW_DPBANK_DLCR) &
                      (packet_reg_addr == SW_REGADDR_DPBANK) &
                      (|sw_data[9:8]);

  //Resend Register
  //The Resend register is not physically implemented, and accesses to it are
  //trapped into the SW protocol error state.
  assign resend_acc = (~packet_ap_ndp) & packet_r_nw &
                      (packet_reg_addr == SW_REGADDR_RESEND);

  //Target Select
  //Decode an attempt to write independent of sw_parity_err since
  //parity errors or writes of a non-matching target id both result
  //in a protocol error and do not set WDATAERR in Ctrl/Stat
  assign tsel_dec   = cfg_swmd &
                      (~packet_ap_ndp) & (~packet_r_nw) &
                      (packet_reg_addr == SW_REGADDR_TARGETSEL);
  assign targetsel  = (sw_data == {dp_dlpidr[31:28], dp_targetid[27:0]}) &
                      (~sw_parity_err);

  //Select Register
  //This register is WO, and the data written is encoded to be stored in
  //a fewer number of bits.
  //The select register comprises the following fields:
  //  [31:24] APSEL     - Selects between the AP's connected to the DP
  //  [7:4]   APBANKSEL - Selects the bank within the current AP
  //  [3:0]   DPBANKSEL - Selects the bank within the DP

  //Since only 1 AP is present in this DAP, the APSEL field is encoded as
  //a single bit, which is set when the present AP is selected. This is
  //performed by a reduction-NOR on the APSEL value written, such that the
  //present AP is selected when APSEL is 0x00
  assign dp_sel_apsel_next = ~(|sw_data[31:24]);

  //There are 16 logical banks in the AP, however only three of them are
  //used: 0x0, 0x1 and 0xF. Therefore APBANKSEL is encoded as a 2 bit value
  //as follows:
  //  sw_data[7:4] == 4'b0000 -> 2'b00 (AP Bank 0x0)
  //  sw_data[7:4] == 4'b0001 -> 2'b01 (AP Bank 0x1)
  //  sw_data[7:4] == 4'b1111 -> 2'b11 (AP Bank 0xF)
  //                   Else   -> 2'b10 (Reserved, RAZ/WI)
  //If the DP/AP handshake needs to be reset in preparation for power down the
  //bank selection is forced to 2'b10 so any transaction caused is RAZ/WI.

  // Encoded Bit 1
  assign dp_sel_apbanksel_next_1 =  (|sw_data[7:5]);
  // Encoded Bit 0
  assign dp_sel_apbanksel_next_0 = (((~dp_sel_apbanksel_next_1) & sw_data[4])
                                   | (&sw_data[7:4]));
  assign dp_sel_apbanksel_next = {dp_sel_apbanksel_next_1,
                                  dp_sel_apbanksel_next_0};

  //DPBANKSEL is decoded depending on DP architecture and HALTEV support

  assign dp_sel_load = dp_write
                       & (packet_reg_addr == SW_REGADDR_SELECT);

  //The APSEL and APBANKSEL fields of the Select register are architecturally
  //defined to be unpredictable after reset. However, the encoded APSEL
  //signal is reset (such that the AP is not selected) as this is used as
  //a control signal. This is different to resetting the architectural
  //equivalent to 0x00, as writing that value would set the encoded APSEL to
  //be b1. APBANKSEL is not reset as it is only used as a data signal to the
  //AP and cannot be used unless APSEL is set, implying that the register has
  //been initialised.
  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n) begin
      dp_sel_apsel     <= 1'b0;  //AP is not selected after reset
    end
    else if (dp_sel_load) begin
      dp_sel_apsel     <= dp_sel_apsel_next;
    end

  // Generate dp_sel_dpbanksel register optimised for area with 3, 2 or 1
  // bits depending on configuration
  generate
    if ((CBAW != 0) || (SWMD != 0) || (HALTEV != 0)) begin : gen_bank

      reg [2:0] dpbanksel_next;

      always @*
        if (cfg_swmd || cfg_haltev) begin
          case (sw_data[3:0])
            4'b0000: dpbanksel_next =              SW_DPBANK_CTRLSTAT;
            4'b0001: dpbanksel_next =              SW_DPBANK_DLCR;
            4'b0010: dpbanksel_next = cfg_swmd   ? SW_DPBANK_TARGETID : SW_DPBANK_RESERVED;
            4'b0011: dpbanksel_next = cfg_swmd   ? SW_DPBANK_DLPIDR   : SW_DPBANK_RESERVED;
            4'b0100: dpbanksel_next = cfg_haltev ? SW_DPBANK_EVSTAT   : SW_DPBANK_RESERVED;
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
            4'b1111: dpbanksel_next =              SW_DPBANK_RESERVED;
            default: dpbanksel_next =              3'bxxx; // propagate X
          endcase // case(sw_data[3:0])
        end else begin
          dpbanksel_next = sw_data[0] ? SW_DPBANK_DLCR : SW_DPBANK_CTRLSTAT;
        end

      if ((CBAW != 0) || (SWMD != 0)) begin : gen_dpbanksel3

        reg [2:0] dpbanksel;

        always @(posedge swclk or negedge dpreset_n)
          if (!dpreset_n)
            dpbanksel <= SW_DPBANK_CTRLSTAT;
          else if (dp_sel_load)
            dpbanksel <= dpbanksel_next;

         assign  dp_sel_dpbanksel = dpbanksel;

      end else begin : gen_dpbanksel2 // block: gen_dpbanksel3

        wire unused = dpbanksel_next[2];

        reg [1:0] dpbanksel;

        always @(posedge swclk or negedge dpreset_n)
          if (!dpreset_n)
            dpbanksel <= SW_DPBANK_CTRLSTAT[1:0];
          else if (dp_sel_load)
            dpbanksel <= dpbanksel_next[1:0];

         assign  dp_sel_dpbanksel = {SW_DPBANK_CTRLSTAT[2], dpbanksel};

       end

    end else begin : gen_dpbanksel1

      reg dpbanksel;

      always @(posedge swclk or negedge dpreset_n)
        if (!dpreset_n)
          dpbanksel <= SW_DPBANK_CTRLSTAT[0];
        else if (dp_sel_load)
          dpbanksel <= sw_data[0];

      assign  dp_sel_dpbanksel = {SW_DPBANK_CTRLSTAT[2:1], dpbanksel};

    end

  endgenerate

  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_dp_sel_apbanksel_rar

      always @(posedge swclk or negedge rar_reset_n)
        if (!rar_reset_n)
          dp_sel_apbanksel <= 2'b11;
        else if (dp_sel_load)
          dp_sel_apbanksel <= dp_sel_apbanksel_next;

    end else begin : gen_dp_sel_apbanksel

      always @(posedge swclk)
        if (dp_sel_load)
          dp_sel_apbanksel <= dp_sel_apbanksel_next;

    end
  endgenerate

// ----------------------------------------------------------------------------
// SW Shift Register
// -----------------
  //The SW Shift Register is loaded with data from either the current DP
  //transaction or the previous AP transaction at the PACKTRN0 state. It is
  //shifted right as SWDI is shifted in, during the DATAx states. The data
  //stored in it is used to write into the relevant DP register, or start and
  //AP transaction in the START state.
  //
  //Data loaded into the Shift Register can come from three sources: a DP
  //register, the shifted form of itself, or from the external AP data
  //source. These are selected by an OR-of-AND multiplexer to save area, and
  //as it can be desirable to load zero.
// ----------------------------------------------------------------------------
  //Load Enable Terms
  //sw_header_valid is asserted at the PARK state, when the shift
  //register needs to be loaded with either the result of the previous AP
  //transaction or the selected DP register. Note that this is asserted even
  //on writes, as this makes the control logic simpler and has no effect on
  //functionality as the data already in sw_data is ignored on writes.
  //The signal is also asserted regardless of whether the AP is busy, as in
  //this case, the input is masked to 0 by dp_out_en, and on faults as there
  //is no data phase so the data loaded is not used.
  //swdi_int is used to mask this signal so that no transaction can occur if
  //the PARK bit is 0 (header invalid) and reflects the state machine
  //entering a reset state.
  assign sw_header_valid = ((sw_state == SW_ST_PARK) & (swdi_int));

  //ap_acc is asserted when the current transaction addresses the AP
  //i.e. APnDP is asserted or the access is a RDBUFF read).
  assign ap_acc = packet_ap_ndp |
                  ((packet_reg_addr == SW_REGADDR_RDBUFF) &
                  packet_r_nw);

  // - DP Registers
  // DPIDR Value
  // The DPIDR revision field can be changed so the defined value is XOR'ed with
  // the ECOREVNUM value from the input
  assign dp_idr_raw = cfg_swmd ? SW_DPIDR_REG_VAL2 : SW_DPIDR_REG_VAL1;
  assign dp_idr     = {(ecorevnum_i ^ dp_idr_raw[31:28]), dp_idr_raw[27:0]};

  // - sw_reg_load is common to all DP register load enables
  assign sw_reg_load = sw_header_valid & (~packet_ap_ndp);
  assign sw_data_dpidr_en     = sw_reg_load &
                                (packet_reg_addr == SW_REGADDR_DPIDR);
  assign sw_data_ctrlstat_en  = sw_reg_load & (dp_sel_dpbanksel == SW_DPBANK_CTRLSTAT) &
                                (packet_reg_addr == SW_REGADDR_DPBANK);
  assign sw_data_dlcr_en      = sw_reg_load & (dp_sel_dpbanksel == SW_DPBANK_DLCR) &
                                (packet_reg_addr == SW_REGADDR_DPBANK);
  assign sw_data_targetid_en  = sw_reg_load & (dp_sel_dpbanksel == SW_DPBANK_TARGETID) &
                                (packet_reg_addr == SW_REGADDR_DPBANK);
  assign sw_data_dlpidr_en    = sw_reg_load & (dp_sel_dpbanksel == SW_DPBANK_DLPIDR) &
                                (packet_reg_addr == SW_REGADDR_DPBANK);
  assign sw_data_evstat_en    = sw_reg_load & (dp_sel_dpbanksel == SW_DPBANK_EVSTAT) &
                                (packet_reg_addr == SW_REGADDR_DPBANK);

  // - The mask for the ap_data_dp_i and ap_err_dp_i inputs is external to
  //the DP and controlled by the dp_out_en and dp_err_out_en signals.
  assign dp_err_out_en = sw_header_valid &     //Header valid
                         ap_busy_regd &        //An AP transaction occurred
                         (~ap_interface_busy) &//DP controls CDC block
                         dp_sel_apsel &        //AP is selected
                         (~dp_abort_dapabort); //AP has not been aborted

  //As dp_err_out_en but qualified by this being an AP or RDBUFF access
  assign dp_out_en     = dp_err_out_en &
                         ap_acc;               //Tx addresses AP

  // - Shift Register
  // sw_data_shift is asserted during the DATAx states
  assign sw_data_shift = (sw_state[8:5] == SW_ST_DATA0[8:5]);

  //OoA Multiplexer
  // - sw_data_shifted data input
  assign sw_data_shifted = {swdi_int, sw_data[31:1]};
  assign sw_data_next = ({32{sw_data_dpidr_en}}     & dp_idr)         |
                        ({32{sw_data_ctrlstat_en}}  & dp_ctrlstat)    |
                        ({32{sw_data_dlcr_en}}      & dp_dlcr)        |
                        ({32{sw_data_targetid_en}}  & dp_targetid)    |
                        ({32{sw_data_dlpidr_en}}    & dp_dlpidr)      |
                        ({32{sw_data_evstat_en}}    & dp_evstat)      |
                        ({32{sw_data_shift}}        & sw_data_shifted)|
                        ap_data_dp_i; //This is masked externally

  //Actual sw_data register
  //sw_data_load is used as the enable term to sw_data - note the register is
  //loaded even on writes (as the data loaded is ignored), and waited AP
  //accesses (as the register will load 0x00000000).
  assign sw_data_load = sw_data_shift | sw_header_valid;

  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_sw_data_rar

      always @(posedge swclk or negedge rar_reset_n)
        if (!rar_reset_n)
          sw_data <= {32{1'b1}};
        else if (sw_data_load)
          sw_data <= sw_data_next;

    end else begin : gen_sw_data

      always @(posedge swclk)
        if (sw_data_load)
          sw_data <= sw_data_next;

    end
  endgenerate

// ----------------------------------------------------------------------------
// AP Synchronisation Handshaking
// ------------------------------
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

  //ap_interface_busy is true when the AP controls the CDC block, and is used
  //to mask the DP's output enables to avoid contention in the CDC block.
  assign ap_interface_busy = (dp_req_dp_i ^ ap_ack_dp_i);

  //ap_busy_inst is the instantaneous value of ap_busy, and indicates that
  //the AP is busy due to a transaction being in progress.
  assign ap_busy_inst = ap_interface_busy & ap_busy_regd;

  //ap_busy_regd indicates when an AP transaction is in progress and the
  //error or data response from the AP has not yet been sampled.
  //It is cleared whenever a new AP or RDBUFF read or any write is
  //started (with an OK ACK). All of these cases architecturally make
  //subsequent access to the read data either return a new value or make
  //the previous value UNPREDICTABLE. The write condition to any register
  //other than TARGETSEL is used to ensure that, for example, if the
  //STICKYERR bit is cleared after the transaction has completed that the
  //error bit will not be re-sampled and set it again.
  assign ap_busy_regd_load =  start_ap_tx_masked |                // Set
                              (sw_header_valid & (~ap_busy_inst) &
                               (ap_acc |
                                (~(packet_r_nw | tsel_dec))));    // Clear

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      ap_busy_regd <= 1'b0;
    else if (ap_busy_regd_load)
      ap_busy_regd <= start_ap_tx_masked;

  //start_ap_tx is asserted when an AP transaction is to be started. I.e.,
  //when perform_tx is asserted, APnDP for the transaction is
  //asserted and the AP is selected. The perform_tx signal checks that the
  //previous transaction did not give a wait or fault response, and that
  //write data parity is valid (if a write transaction).
  assign start_ap_tx = perform_tx & packet_ap_ndp & dp_sel_apsel;

  // start_ap_tx is masked so that the AP transaction is only started if the
  // AP is powered up.
  assign start_ap_tx_masked = start_ap_tx & ap_pwr_on;

  // start_ap_req indicates a request is to be made to the AP, for
  // a transaction or the handshake-reset sequence.
  assign start_ap_req = start_ap_tx_masked | reset_dp_ap_handshake_i;

  //dp_wr_en is used to load the transfer register with the DP
  //transaction data at the start of an AP transaction or when the handshake
  //reset sequence occurs to ensure the transaction has no effect.
  assign dp_wr_en = start_ap_req;

  //dp_req_dp_i is toggled to start an AP request. It is is cleared to 0
  //dp_req_dp_i can be set only if the AP is powered on - a power down request
  //will clear it to safeguard the handshaking logic.
  //The register is a CDC safe launch flop in the DP CDC block.
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
// SW Acknowledge
// --------------
  //As part of every transaction, the DAP drives a 3 bit acknowledge with the
  //following three bits (in the order they appear on the line):
  //ACK0  OK
  //ACK1  Wait
  //ACK2  Fault
  //
  //Fault is set when any of the sticky error flags or WDATAERR is set
  //ap_err_dp_i is included so ack_fault is valid during state SW_ST_PARK
  //Wait is set when fault is not set and an AP transaction is outstanding
  //(if the AP is selected).
  //OK is set when wait and fault are not set
// ----------------------------------------------------------------------------

  assign ack_fault      = (~non_waitable_tx) &
                          ( dp_cs_wdataerr  |
                            ap_err_dp_i |        // STICKYERR will become set
                            dp_cs_stickyerr |
                            dp_cs_stickyorun);

  // Conditions for WAIT are:
  // Not a FAULT response, the AP is selected and busy, and neither a non-waitable
  // transaction (access to DPIDR, ABORT or CTRL/STAT) nor a DP (except RDBUFF)
  // access where an ABORT has occurred.
  assign ack_wait_inst  = (~ack_fault) & dp_sel_apsel & ap_busy_inst &
                         // busy elsewhere
                         (~(non_waitable_tx | (dp_abort_dapabort & ~ap_acc)));
                         // conditions under which WAIT is NOT allowed

  assign ack_ok_inst    = ~(ack_fault | ack_wait_inst);

  // ACK OK is determined during states SW_ST_ACK0/1(_NODAT) by looking at
  // parity (the OK or WAIT bit) and ack_fault
  assign ack_ok_ack0    = parity;
  assign ack_ok_ack1    = ~(parity | ack_fault);

// ----------------------------------------------------------------------------
// Error Flags
// -----------
  //Note that WDATAERR is sticky even though this is not mentioned in the name.
  //READOK is not sticky.
// ----------------------------------------------------------------------------
  //Write Data Error
  //Set when all the following criteria are met:
  //1. DP is in the data parity state
  //2. It is a write operation
  //3. There was no transaction error in overrun mode (Sticky Overrun bit is 0)
  //4. parity error is detected in write data (except for Target Selection)
  assign wdataerr_detected =  (sw_data_end_ok) &
                              (~packet_r_nw) &
                              (sw_parity_err & ~tsel_dec);

  assign dp_cs_wdataerr_load = ((~dp_cs_wdataerr) & wdataerr_detected)
                                     | dp_abort_wdataerr_clr;
  //Input to wdataerr selects 0 on clear operations and 1 at all other times
  assign dp_cs_wdataerr_next = ~dp_abort_wdataerr_clr;

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      dp_cs_wdataerr <= 1'b0;
    else if (dp_cs_wdataerr_load)
      dp_cs_wdataerr <= dp_cs_wdataerr_next;

  //Sticky Error
  //Set when an AP transaction returns an error, or when an illegal AP
  //transaction is attempted. In the case of a legal AP transaction the error
  //from the AP is masked by dp_err_out_en, which ensures the error is sampled
  //only when it is valid.
  assign stickyerr_detected = ap_err_dp_i | (start_ap_tx & (~ap_pwr_on));

  assign dp_cs_stickyerr_load = ((~dp_cs_stickyerr) &
                                        stickyerr_detected)
                                      | dp_abort_stkerr_clr;

  assign dp_cs_stickyerr_next = ~dp_abort_stkerr_clr;

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      dp_cs_stickyerr <= 1'b0;
    else if (dp_cs_stickyerr_load)
      dp_cs_stickyerr <= dp_cs_stickyerr_next;

  //Sticky Overrun
  //Set when ORUNDETECT is set and a transaction gives a wait or fault response,
  //or there is a protocol error.
  //Must be set later than state SW_ST_ACK0(_NODAT) to ensure that ack_fault does
  //not become set in the ACK WAIT case and generate ACK FAULT bit as well.
  //But early enough to cause ack_fault to be used in state ACK2 to determine
  //whether SWDOEN should be generated for the read data phase.
  assign stickyorun_detected  = dp_cs_orundetect &
                                ( (((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK1) &
                                   (~ack_ok_ack1)) |
                                  (sw_state[8:6] == SW_ST_RST_0[8:6])); //Set on protocol error

  //The Sticky Overrun flag is cleared by writing to the abort register
  assign dp_abort_stkorun_clr = (dp_abort_execute & sw_data[4]);

  assign dp_cs_stickyorun_load =  ( (~dp_cs_stickyorun)
                                          & stickyorun_detected )
                                        | dp_abort_stkorun_clr;

  assign dp_cs_stickyorun_next = ~dp_abort_stkorun_clr;

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      dp_cs_stickyorun <= 1'b0;
    else if (dp_cs_stickyorun_load)
      dp_cs_stickyorun <= dp_cs_stickyorun_next;

  //Read OK
  //This bit indicates whether the ACK for the most recent AP/RDBUFF read
  //was OK.
  assign dp_cs_readok_load =  sw_header_valid & //Valid header
                                    ap_acc &          //Tx addresses AP
                                    packet_r_nw;      //Transaction is Read
  //ack_ok_inst is used as the register is loaded when ack_ok_inst is sampled
  assign dp_cs_readok_next = ack_ok_inst;

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      dp_cs_readok <= 1'b0;
    else if (dp_cs_readok_load)
      dp_cs_readok <= dp_cs_readok_next;
// ----------------------------------------------------------------------------
// Top-Level IO
// ----------------------------------------------------------------------------

  //SWDO
  //SWDOEN is used at the top level to control the tri-stated SWDIO line.
  //The enable term is registered to prevent it from glitching and causing
  //errors in a system where swdio is controlled with a tri-state with a slow
  //turn on/off time. Because of this the load enable for the registered
  //signal is driven one cycle in advance.
  //In state SW_ST_ACK2, the data phase will always be entered but if overrun
  //detect mode was enabled and the ACK was wait or fault then the
  //stickyoverrun bit will have become set so ack_fault will indicate whether
  //the output enable should be de-asserted during the read data phase.
  //In state SW_ST_ACK2_NODAT there will be no data phase.
  //ACK is not driven for TARGETSEL writes
  assign swdoen_next = (((sw_header_valid |
                          ((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK0) |
                          ((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK1)) &
                         ~tsel_dec) |
                        ((sw_state == SW_ST_ACK2) &
                         packet_r_nw & ~ack_fault) |
                        (swdoen & sw_data_shift));

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      swdoen <= 1'b0; //After reset debugger drives lines
    else
      swdoen <= swdoen_next;

  //SWDO is driven by a Multiplexer which selects between the bottom bit
  //of the data shift register, the three acknowledges and the data parity
  //bit. SWDO is then masked by SWDOEN. Note that the acknowledges and parity
  //is sourced from the parity register, as this is used to register the
  //acknowledges to ease timing.
  assign swdo = sw_state[5] ? sw_data[0] : parity;

  //swdetect is asserted after 48 cycles of line reset have been observed to
  //allow non-Serial Wire devices external to the DAP to be disabled
  //automatically.
  assign swdetect = (sw_state == SW_ST_RST_48);

  //SWDI
  //swdi_int is a registered version of SWDI, used to reduce the probability
  //of a meta-stable value on SWDI propagating into the design.
  assign swdi_int_en =  (
                          ((sw_state & SW_ST_HDR_MASK) == SW_ST_START) |
                          //packet_shift is asserted during standard and RST
                          //APnDP, RnW, A[1:0]
                          packet_shift |
                          ((sw_state & SW_ST_HDR_MASK) == SW_ST_PARITY) |
                          (sw_state == SW_ST_STOP) |
                          (sw_state == SW_ST_PARK) |
                          //Sample during data shift and data parity on
                          //writes
                          ((~packet_r_nw) & (
                            sw_data_shift |
                            (sw_state == SW_ST_DATAPARITY) )) |
                          //Need to sample during reset counter states as
                          //SWDI advances or resets the count
                          (sw_state[8:6] == SW_ST_RST_0[8:6]) |
                          //Sample during Dormant state entry/activation
                          //except during skipped bits that may be ignored
                          ((sw_state[8:6] == SW_ST_DENT_0[8:6]) &
                           (sw_state[4:3] != SW_ST_ALRT0_0[4:3]))
                          );

  generate
    if ((CBAW != 0) || (SWMD == 0)) begin : gen_swdi_sw_0

      // The capture flop for SWDI needs to be CDC-safe, i.e. its input must be
      // ignored when the load term is low.
      // The flop is a set flop to avoid missing a 1 from the initial line reset
      // after power-on.

      wire swdi_reg_sw;

      cm0p_dap_sw_cdc_capt_reset
        u_dp_sw_swdi_capture
          (.REGCLK     (swclk),
           .REGRESETn  (dpreset_n),
           .REGDI      (swdi_i),
           .DFTSE      (DFTSE),
           .REGDO      (swdi_reg_sw));

      cm0p_dap_cdc_comb_and
        u_mask_swdi_sw
          (.DATAIN   (swdi_reg_sw),
           .MASKn    (swdi_int_en),
           .DATAOUT  (swdi_int_sw));

    end else begin : gen_swdi_sw_1

      assign swdi_int_sw = 1'b0;

    end
    if ((CBAW != 0) || (SWMD != 0)) begin : gen_swdi_swmd_0
      // The capture flop for SWDI needs to be CDC-safe, i.e. its input must be
      // ignored when the load term is low.
      // The flop is a set flop to avoid missing a 1 from the initial line reset
      // after power-on.

      wire swdi_reg_swmd;
      wire swdi_sync_swmd;

      cm0p_dap_sw_cdc_capt_sync
        u_dp_sw_swdi_sync
          (.SYNCCLK    (swclk),
           .SYNCRSTn   (dpreset_n),
           .SYNCDI     (swdi_i),
           .DFTSE      (DFTSE),
           .REGDO      (swdi_reg_swmd),
           .SYNCDO     (swdi_sync_swmd)
           );

      cm0p_dap_cdc_comb_and
        u_mask_swdi_swmd
          (.DATAIN   (swdi_reg_swmd),
           .MASKn    (swdi_int_en),
           .DATAOUT  (swdi_int_swmd));

      assign swdi_sync     = cfg_swmd & swdi_sync_swmd;

    end else begin : gen_swdi_swmd_1

      assign swdi_int_swmd = 1'b0;
      assign swdi_sync     = 1'b0;

    end
  endgenerate

  assign swdi_int = cfg_swmd ? swdi_int_swmd : swdi_int_sw;

  //dp_data_dp is driven by the sw_data register. The data is loaded by
  //a separate control signal, dp_wr_en
  assign dp_data_dp = sw_data;

  // During the handshake reset sequence, 2'b10 is passed as the Bank Select
  // to the AP. All registers under this encoded banksel field are reserved
  // and RAZ/WI so this results in a null transaction.
  assign dp_sel_apbanksel_masked =  (reset_dp_ap_handshake_i ?
                                    2'b10 : dp_sel_apbanksel);

  //dp_regaddr_dp is the register address for an AP transaction. It is driven by
  //the supplied two bit address, and the two bit value loaded into the
  //SELECT register.
  assign dp_regaddr_dp = {dp_sel_apbanksel_masked, packet_reg_addr};

  //dp_rnw_dp is the direction for an AP transaction.
  assign dp_rnw_dp = packet_r_nw;

// ----------------------------------------------------------------------------
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
      .clock            (swclk),
      .reset            (dpreset_n),
      .enable           (1'b1),
      .antecedent_expr  (~ap_busy_regd),
      .consequent_expr  (~ap_busy_inst),
      .fire             ()
    );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("An AP transaction must not cause a WAIT response after it has completed."),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_apacc_completed_wait
    (
      .clock        (swclk),
      .reset        (dpreset_n),
      .enable       (1'b1),
      .start_event  (sw_header_valid & (~ap_busy_inst) & (ap_acc | (~(packet_r_nw | tsel_dec)))),
      .test_expr    (~(ap_busy_inst | ap_busy_regd)),
      .fire         ()
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
      .clock        (swclk),
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
      .msg                 ("A transaction should be about to start when ap_busy_inst goes high, and ap_busy_inst should be low when result is sampled."),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_regd_cleared_after_inst
      (
        .clock        (swclk),
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
      .msg                 ("The DP must not report an AP transaction in progress when dummy transaction in handshake reset sequence is performed."),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_handshake_reset_never_ap_busy_regd
      (
        .clock        (swclk),
        .reset        (dpreset_n),
        .enable       (1'b1),
        .start_event  (reset_dp_ap_handshake_i & ~ap_busy_regd),
        .test_expr    (~ap_busy_regd),
        .fire         ()
      );

  // ap_err_dp_i cannot be sampled before it is written. The register has no
  // reset so this is detected by looking for X.
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ap_err_dp_i must never be X"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_ap_err_dp
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (ap_err_dp_i),
        .fire       () );

  //X-Checking on Register Load Enables/Async Resets used in IF statements
  // - dpreset_n
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Reset for DP Must not be Unknown"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_dpreset_n
      ( .clock      (swclk),
        .reset      (1'b1),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dpreset_n),
        .fire       () );

  // - packet_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("packet_shift can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_packet_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (packet_shift),
        .fire       () );

  // - parity_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("parity_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_parity_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (parity_load),
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
    u_asrt_xcheck_dp_abort_dapabort_load
      ( .clock      (swclk),
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
    u_asrt_xcheck_dp_cs_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_cs_load) ,
        .fire       ());

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
    u_asrt_xcheck_dp_sel_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_sel_load),
        .fire       () );

  // - sw_data_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("sw_data_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_sw_data_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (sw_data_load),
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
    u_asrt_xcheck_ap_busy_regd_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (ap_busy_regd_load),
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
    u_asrt_xcheck_dp_req_dp_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_req_dp_load),
        .fire       () );

  // - dp_cs_wdataerr_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_cs_wdataerr_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_dp_cs_wdataerr_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_cs_wdataerr_load),
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
    u_asrt_xcheck_dp_cs_stickyerr_load
      ( .clock      (swclk),
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
    u_asrt_xcheck_dp_cs_stickyorun_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_cs_stickyorun_load),
        .fire       () );

  // - dp_cs_readok_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("dp_cs_readok_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_dp_cs_readok_load
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (dp_cs_readok_load),
        .fire       () );

  // - swdi_int_en
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("swdi_int_en can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_swdi_int_en_x
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (swdi_int_en),
        .fire       () );

  ovl_implication
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("swdi_int_en must not be asserted while in dormant state"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_swdi_int_en_dormant
    (
      .clock            (swclk),
      .reset            (dpreset_n),
      .enable           (1'b1),
      .antecedent_expr  (sw_state[8] == SW_ST_DLFSR_START[8]),
      .consequent_expr  (~swdi_int_en),
      .fire             ()
    );

  //SWDI and SWDO should never be enabled together
  //swdi_int_en is one cycle later than SWDI sampling so delay swdoen for
  //comparison
  reg    ovl_swdoen_reg;
  always @(posedge swclk)
    ovl_swdoen_reg <= swdoen;

  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SWDI and SWDO should never be enabled together"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_swdi_swdoen
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (swdi_int_en & ovl_swdoen_reg),
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
      ( .clock      (swclk),
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
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (start_ap_req),
        .test_expr  (dp_sel_apbanksel_masked),
        .fire       () );

  //Only 1 of Ack OK, Wait and False should ever be set (1 Hot)
  ovl_one_hot
    #(.severity_level      (`OVL_FATAL),
      .width               (3),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACKx Should be One Hot"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ack_one_hot
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (sw_header_valid
                     ? {ack_ok_inst, ack_wait_inst, ack_fault}
                     : 3'b001),
        .fire       () );

  //ACK must be driven correctly on SWDOEN and SWDO
  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK OK must not be driven after protocol error"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_no_ack_ok
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (((sw_state == SW_ST_PARK) & (~swdi_int))),
        .test_expr   (~swdoen),
        .fire        () );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK ~OK must be generated correctly"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ack_ok_0
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (sw_header_valid & ~ack_ok_inst),
        .test_expr   (swdoen & ~swdo),
        .fire        () );

  // During TARGETSEL writes after reset SWDOEN is not driven
  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (1),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK OK must be generated correctly"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ack_ok_1
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (sw_header_valid & ack_ok_inst),
        .test_expr   ((tsel_dec ^ swdoen) & swdo),
        .fire        () );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (2),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK WAIT must not be driven after protocol error"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_no_ack_wait
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (((sw_state == SW_ST_PARK) & (~swdi_int))),
        .test_expr   (~swdoen),
        .fire        () );

  // During TARGETSEL writes after reset SWDOEN is not driven
  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (2),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK ~WAIT must be generated correctly"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ack_wait_0
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (sw_header_valid & ~ack_wait_inst),
        .test_expr   ((tsel_dec ^ swdoen) & ~swdo),
        .fire        () );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (2),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK WAIT must be generated correctly"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ack_wait_1
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (sw_header_valid & ack_wait_inst),
        .test_expr   (swdoen & swdo),
        .fire        () );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (3),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK FAULT must not be driven after protocol error"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_no_ack_fault
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (((sw_state == SW_ST_PARK) & (~swdi_int))),
        .test_expr   (~swdoen),
        .fire        () );

  // During TARGETSEL writes after reset SWDOEN is not driven
  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (3),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK ~FAULT must be generated correctly"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ack_fault_0
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (sw_header_valid & ~ack_fault),
        .test_expr   ((tsel_dec ^ swdoen) & ~swdo),
        .fire        () );

  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (3),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("ACK FAULT must be generated correctly"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ack_fault_1
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (sw_header_valid & ack_fault),
        .test_expr   (swdoen & swdo),
        .fire        () );

  //The enable inputs to the OoA mux on Parity must be one hot or zero
  ovl_zero_one_hot
    #(.severity_level      (`OVL_FATAL),
      .width               (5),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Control Inputs to Parity Input Must be Zero or One Hot"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_parity_ctrl_zero_one_hot
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ({parity_reset, parity_generate,
                      parity_ack_ok_en, parity_ack_wait_en,
                      parity_ack_fault_en}),
        .fire       () );

  //The enable inputs to the OoA mux on sw_data must be one hot or zero
  ovl_zero_one_hot
    #(.severity_level      (`OVL_FATAL),
      .width               (8),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Control Inputs to sw_data mux Must be Zero or One Hot"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_swdata_mux_ctrl_zero_one_hot
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ({sw_data_dpidr_en, sw_data_ctrlstat_en,
                      sw_data_dlcr_en,
                      sw_data_targetid_en, sw_data_dlpidr_en,
                      sw_data_evstat_en,
                      sw_data_shift,
                      dp_out_en}),
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
        .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ({reset_dp_ap_handshake_i, start_ap_tx_masked}),
        .fire       ()
      );

  //sticky_err_detected should never be set when dp_out_en is low
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Sticky Err Detected should never be set when dp_err_out_en is low"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_stickyerr_det_mask
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (ap_err_dp_i & (~dp_err_out_en)),
        .fire       () );

  //perform_tx should never be asserted if a parity error is detected
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("A Write should not be committed if there was a parity error"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_never_write_on_bad_parity
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (perform_tx & wdataerr_detected),
        .fire       () );

  //The State Machine should never be in a dataphase unless ack_ok is set, or
  //the sticky overrun bit is set (implying DP is in overrun mode and an
  //error has been successfully detected).
  //6 cycles is enough to get into read or write data phases
  ovl_next
    #(.severity_level      (`OVL_FATAL),
      .num_cks             (6),
      .check_overlapping   (1),
      .check_missing_start (0),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Should not be in dataphase when ack != OK unless overrun error detected"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_illegally_in_dataphase
      ( .clock       (swclk),
        .reset       (dpreset_n),
        .enable      (1'b1),
        .start_event (sw_header_valid & (~ack_ok_inst)),
        .test_expr   ((~sw_data_shift) | dp_cs_stickyorun),
        .fire        () );

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
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  ( (start_ap_tx & (~dp_cs_cdbgpwrupack_i)) ),
        .fire       ());

  // - Accesses to the RESEND register cause a protocol error and therefore not
  //recommended
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Attempt to access RESEND register"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_resend_access_attempted
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (resend_acc & (sw_state == SW_ST_PARITY)),
        .fire       () );

  // - Writing a non-zero value to TRN in the DLCR causes a protocol error
  // and therefore is not recommended
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Attempt to write TRN field"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_trn_write_attempted
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (trn_write & (sw_state == SW_ST_DATAPARITY)),
        .fire       () );

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
      ( .clock      (swclk),
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
      ( .clock      (swclk),
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
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_load & (|sw_data[21:12])),
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
      ( .clock        (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_load & (|sw_data[11:8])),
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
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_load & (|sw_data[3:2])),
        .fire       () );

  // - Clearing the ORUNDETECT bit while STICKYORUN is set is unpredictable
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("It is not possible to disable Overrun Detection when STICKYORUN is set"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_orundet_clear
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (dp_cs_stickyorun & (~dp_cs_orundetect)),
        .fire       () );

  // - The Select register should be initialised before attempting an AP tx
  ovl_never_unknown
    #(.severity_level      (`OVL_INFO),
      .width               (2),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Select register must be initialised before attempting an AP tx"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_select_uninit
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (perform_tx & packet_ap_ndp),
        .test_expr  (dp_sel_apbanksel),
        .fire       () );

  // - Debugger should not attempt to select a target with UNPREDICTABLE TARGETSEL value
  ovl_implication
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Writes to TARGETSEL[0]=0 are UNPREDICTABLE"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_targetsel_unpred
      ( .clock           (swclk),
        .reset           (dpreset_n),
        .enable          (1'b1),
        .antecedent_expr (sw_data_end_ok & tsel_dec),
        .consequent_expr (sw_data[0]),
        .fire            () );

  // - Encodings for SW_ST_ACK_MASK and SW_ST_ACK*(_NODAT) must be consistent
  // to allow the mask to be used for optimising the comparision
  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_ACK_MASK and SW_ST_ACK0s must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_ack0_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK0) ==
                     ((sw_state == SW_ST_ACK0) |
                      (sw_state == SW_ST_ACK0_NODAT))),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_ACK_MASK and SW_ST_ACK1s must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_ack1_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK1) ==
                     ((sw_state == SW_ST_ACK1) |
                      (sw_state == SW_ST_ACK1_NODAT))),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_ACK_MASK and SW_ST_ACK2s must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_ack2_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_ACK_MASK) == SW_ST_ACK2) ==
                     ((sw_state == SW_ST_ACK2) |
                      (sw_state == SW_ST_ACK2_NODAT))),
        .fire       () );

  // - Encodings for SW_ST_HDR_MASK and SW_ST(_RST)_* must be consistent
  // to allow the mask to be used for optimising the comparision
  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_HDR_MASK and SW_ST_START must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_start_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_HDR_MASK) == SW_ST_START) ==
                     ((sw_state == SW_ST_START) |
                      (sw_state == SW_ST_RST_START))),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_HDR_MASK and SW_ST_APnDP must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_apndp_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_HDR_MASK) == SW_ST_APnDP) ==
                     ((sw_state == SW_ST_APnDP) |
                      (sw_state == SW_ST_RST_APnDP))),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_HDR_MASK and SW_ST_RnW must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_rnw_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_HDR_MASK) == SW_ST_RnW) ==
                     ((sw_state == SW_ST_RnW) |
                      (sw_state == SW_ST_RST_RnW))),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_HDR_MASK and SW_ST_A0 must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_a0_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_HDR_MASK) == SW_ST_A0) ==
                     ((sw_state == SW_ST_A0) |
                      (sw_state == SW_ST_RST_A0))),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_HDR_MASK and SW_ST_A1 must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_a1_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_HDR_MASK) == SW_ST_A1) ==
                     ((sw_state == SW_ST_A1) |
                      (sw_state == SW_ST_RST_A1))),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SW_ST_HDR_MASK and SW_ST_PARITY must be consistent"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_sw_state_parity_valid
      ( .clock      (swclk),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .test_expr  (((sw_state & SW_ST_HDR_MASK) == SW_ST_PARITY) ==
                     ((sw_state == SW_ST_PARITY) |
                      (sw_state == SW_ST_RST_PARITY))),
        .fire       () );

  // - Configuration for TARGETID[7:1] should be a valid JEDEC JEP106 Manufacturer identity code
  ovl_implication
    #(.severity_level      (`OVL_ERROR),
      .property_type       (`OVL_ASSERT),
      .msg                 ("TARGETID[7:1] should be a valid JEDEC JEP106 Manufacturer identity code"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_targetid_jep106_valid
      ( .clock           (swclk),
        .reset           (dpreset_n),
        .enable          (1'b1),
        .antecedent_expr (cfg_sw & cfg_swmd),
        .consequent_expr ((targetid_i[7:1] != 7'b1111111) &
                          (targetid_i[7:1] != 7'b0000000)),
        .fire            () );

  // - Configuration for TARGETID must have bit 0 set
  ovl_implication
    #(.severity_level      (`OVL_ERROR),
      .property_type       (`OVL_ASSERT),
      .msg                 ("TARGETID[0] must be 1"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_targetid_valid
      ( .clock           (swclk),
        .reset           (dpreset_n),
        .enable          (1'b1),
        .antecedent_expr (cfg_sw & cfg_swmd),
        .consequent_expr (targetid_i[0]),
        .fire            () );

  // - Configuration for TARGETID must ensure TARGETSEL=0xFFFFFFFF deselects target
  ovl_implication
    #(.severity_level      (`OVL_ERROR),
      .property_type       (`OVL_ASSERT),
      .msg                 ("TARGETID must not have all bits set"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_targetsel_match
      ( .clock           (swclk),
        .reset           (dpreset_n),
        .enable          (1'b1),
        .antecedent_expr (cfg_sw & cfg_swmd),
        .consequent_expr (dp_targetid[27:0] != 28'hFFFFFFF),
        .fire            () );

  // Supporting logic to count consecutive SWDI==1 for checking SWDETECT output

  reg [5:0] ovl_swdi_ones;
  reg       ovl_48_swdi_ones_del1;

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      ovl_swdi_ones <= 6'd7;
    else if (!swdi_i)
      ovl_swdi_ones <= 6'd0;
    else if (ovl_swdi_ones < 6'd48)
      ovl_swdi_ones = ovl_swdi_ones + 1'b1;

  always @(posedge swclk or negedge dpreset_n)
    if (!dpreset_n)
      ovl_48_swdi_ones_del1 <= 1'b0;
    else
      ovl_48_swdi_ones_del1 <= (ovl_swdi_ones == 6'd48);

  // - SWDETECT must only be asserted if at least 48 cycles of a line reset have been observed
  // Owing to registered sampling, the 49th and/or the current, 50th cycle may have SWDI==0
  ovl_implication
    #(.severity_level      (`OVL_ERROR),
      .property_type       (`OVL_ASSERT),
      .msg                 ("SWDETECT must only occur 1 cycle after at least 48 consecutive SWDI==1"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
      u_asrt_swdetect_only_after_line_reset
      ( .clock           (swclk),
        .reset           (dpreset_n),
        .enable          (1'b1),
        .antecedent_expr (cfg_sw & swdetect_o),
        .consequent_expr (ovl_48_swdi_ones_del1),
        .fire            () );

`else // !`ifdef ARM_ASSERT_ON

  // Avoid warning for configuration wire only used by asserts
  wire   unused_cfg = cfg_sw;

`endif

endmodule
