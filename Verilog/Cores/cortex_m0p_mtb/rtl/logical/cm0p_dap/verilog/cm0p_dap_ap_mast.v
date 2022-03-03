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
//   Checked In : $Date: 2012-01-16 16:33:01 +0000 (Mon, 16 Jan 2012) $
//   Revision   : $Revision: 198245 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_dap_ap_mast
  #(parameter CBAW    = 0,
    parameter USER    = 0,       //0 -> SLVPROT user/priv bit is RO
    parameter MPU     = 0,       //0 -> SLVPROT cacheable/bufferable bits RO
    parameter RAR     = 0
    )
   (input  wire        dclk,            //SLV Clock
    input  wire        apreset_n,       //Power-On Reset
    input  wire        deviceen_i,      //Debug Enabled (from core)

    input  wire [31:0] dp_data_ap_i,    //Internal DAP Data Input
    input  wire [3:0]  dp_regaddr_ap_i, //Encoded AP Register Address for Current Tx
    input  wire        dp_rnw_ap_i,     //ReadNotWrite for Current Transaction
    input  wire        dp_req_ap_i,     //Control Synchronisation Input wire from DP
    output wire        ap_err_ap_o,     //Error Response from Current Transaction
    input  wire        ap_ack_ap_i,     //Control Synchronisation Output wire to DP
    output wire        ap_ack_load_o,   //Load Enable term for ap_ack_ap register
    output wire        ap_out_en_o,     //Enables Transitions on dp_data_ap
    output wire [31:0] ap_data_ap_o,    //Internal DAP Data Output
    output wire        ap_wr_en_o,      //Enable for ap_data_ap

    input  wire [31:0] slvrdata_i,      //CORTEX-M0+ Core Modified AHB Lite Signals
    input  wire        slvready_i,
    input  wire        slvresp_i,
    output wire [31:0] slvaddr_o,
    output wire [1:0]  slvtrans_o,
    output wire [3:0]  slvprot_o,
    output wire [1:0]  slvsize_o,

    input  wire [31:0] ap_base_reg_i,   // Exported pinout value for AP base reg
    input  wire [3:0]  ecorevnum_i      // Exported pinout revision field of APIDR
    );

// ----------------------------------------------------------------------------
// `define's
// ----------------------------------------------------------------------------
//  `include "cm0p_dap_ap_mast_defs.v"

// ----------------------------------------------------------------------------
// Configurablility
// ----------------------------------------------------------------------------
  wire  cfg_user;
  wire  cfg_mpu;
  wire  cfg_rar;

  generate
    if (CBAW == 0) begin : gen_cbaw
      assign cfg_user = (USER != 0);
      assign cfg_mpu  = (MPU != 0);
      assign cfg_rar  = (RAR != 0);
    end
  endgenerate

// ----------------------------------------------------------------------------
// Signal Declarations
// ----------------------------------------------------------------------------

  wire          ap_out_en;
  reg    [31:0] ap_data_ap;
  wire          ap_wr_en;
  wire    [3:0] dp_regaddr_ap_masked;
  wire          ap_err_ap;

  wire   [31:0] slvaddr;
  wire    [1:0] slvaddr_3_2;      //Bits[3:2] of SLVADDR (altered on BDx access)
  wire    [1:0] slvaddr_1_0;      //Bits[1:0] of SLVADDR (masked to aligned addr)
  wire    [1:0] slvaddr_1_0_mask; //Mask for SLVADDR[1:0]
  wire    [1:0] slvtrans;
  wire    [3:0] slvprot;
  wire    [1:0] slvsize;

  //Programmers Model Registers
  // - Transfer Address Register (0x04)
  reg    [31:0] tar;
  wire   [31:0] next_tar;         //Input to TAR

  // - Control Status Word (0x00) is Composite of the following fields:
  reg           csw_addr_inc;     //|CSW[5:4] (Packed Tx's not supported)
  wire          csw_addr_inc_next;//Input to csw_addr_inc
  reg     [1:0] csw_size;         //CSW[1:0] CSW[2] is always b0
  wire    [1:0] csw_size_next;    //Input to csw_size
  wire    [3:0] csw_prot;         //CSW[27:24] drives slvprot
  wire   [31:0] csw;              //Combined CSW Register

  //Control Signals & Data
  // - State Machine
  reg     [1:0] ap_crnt_state;    //State Machine Register
  reg     [1:0] ap_next_state;    //Input to State Machine Register
  // - AP State Signals
  wire          ap_active;        //Set when the AP is performing any transaction
  wire          slv_tx;           //Set when the AP performs an SLV transaction
  wire    [2:0] tar_inc_amount;   //Amount which is added to TAR to increment it
  wire   [10:0] incrd_tar;        //Result of tar[9:0] + tar_inc_amount
  wire          bdx_acc;          //Set when a BDx register is being accessed

  // - Register Load Signals
  wire          load_regs;        //Set when an AP register should be loaded, used
                                  //to form xxx_load
  wire          csw_load;         //Load CSW Registers from dp_data_ap_i
  wire          tar_load;         //Load TAR from dp_data_ap_i
  wire          tar_inc;          //Increment the address in TAR
  wire          load_from_slv;    //Set when data should be loaded from SLV
  wire          load_from_ap_reg; //Set when data should be loaded from AP Reg
  wire          slv_tx_suppressed;//Set when SLV is disabled by !deviceen_i
  wire          ap_ack_load;      //Load enable for ap_ack_ap register

  wire   [31:0] ap_idr;           // APIDR Register Value

  // Outputs
  assign ap_err_ap_o    = ap_err_ap;
  assign ap_ack_load_o  = ap_ack_load;
  assign ap_out_en_o    = ap_out_en;
  assign ap_data_ap_o   = ap_data_ap;
  assign ap_wr_en_o     = ap_wr_en;
  assign slvaddr_o      = slvaddr;
  assign slvtrans_o     = slvtrans;
  assign slvprot_o      = slvprot;
  assign slvsize_o      = slvsize;

// ----------------------------------------------------------------------------
// State Machine
// -------------
  //The AP State machine has 4 states: 2 for dealing with the interface to
  //the DP and 2 for performing SLV transactions. On a write to an AP
  //register which does not generate an SLV transaction, the state machine
  //transitions from IDLE to DONE, and in the done state loads the relevant
  //register and toggles the Ack signal to confirm that the transfer is
  //complete before going back into the IDLE state to wait for another
  //transaction.
  //Note that the SLV slvready_i signal is checked in both the Address and Data
  //states, which is not required by standard AHB, however this is required
  //by the CORTEX-M0+ DAP SLV interface to the core.
// ----------------------------------------------------------------------------
  //Determine Next State
  always @*
    case (ap_crnt_state)
      //In IDLE if the AP is active then the SM will go either to ADDR if the
      //transaction is to the DRW or BDx and deviceen_i is asserted starting an
      //SLV transaction, or straight to DONE if the transaction is to an
      //internal AP register or if deviceen_i is not asserted.
      AP_IDLE :  ap_next_state = ap_active
                                  ? ((slv_tx & deviceen_i) ? AP_ADDR : AP_DONE)
                                  : AP_IDLE;
      //slvready_i is checked in the ADDR state as the modified CORTEX-M0+ core
      //SLV interface is not guarenteed to always accept an address from the
      //DAP.
      AP_ADDR :  ap_next_state = slvready_i ? AP_DATA : AP_ADDR;
      //The SM stays in the DATA state until slvready_i indicates the bus
      //transaction has completed.
      AP_DATA :  ap_next_state = slvready_i ? AP_DONE : AP_DATA;
      //The AP always moves immediately from the DONE state back to IDLE, as
      //the actions required at the DONE state can always be performed in
      //a single cycle.
      AP_DONE :  ap_next_state = AP_IDLE;
      default : ap_next_state = 2'bxx; //X-Propagation
    endcase

  //Update Current State
  always @(posedge dclk or negedge apreset_n)
    if (!apreset_n)
      ap_crnt_state <= AP_IDLE;
    else
      ap_crnt_state <= ap_next_state;

// ----------------------------------------------------------------------------
// Control Signals
// ----------------------------------------------------------------------------
  //Control Synchronisation Signal
  // - ap_ack_ap_i is the handshake signal to the DP. It is sampled by
  // a synchroniser in the DP domain, so it must be driven from a CDC safe
  // register, i.e. one that will never glitch when it is not enabled.
  assign ap_ack_load = (ap_crnt_state == AP_DONE);

  //AP Status
  assign ap_active = (dp_req_ap_i ^ ap_ack_ap_i); //AP active when dp_req != ap_ack

  assign slv_tx = ( (dp_regaddr_ap_i == AP_REGADDR_DRW)  //Set on DRW
                    | bdx_acc);                          //or BDx Access

  assign bdx_acc = (dp_regaddr_ap_i[3:2] == 2'b01);      //BDx Regs are in Bank 1

  //tar_inc_amount is used to increment the TAR when address autoincrementing
  //is enabled. The amount by which the TAR is incremented depends on the
  //size of the current access:
  //  Byte  (b00) - 1
  //  HWord (b01) - 2
  //  Word  (b10) - 4
  assign tar_inc_amount = {csw_size, (~|csw_size)};

  //Register Enables
  //registers are loaded at the AP_DONE state, on write transactions
  assign load_regs = (ap_crnt_state == AP_DONE) & (~dp_rnw_ap_i);

  assign csw_load = load_regs & (dp_regaddr_ap_i == AP_REGADDR_CSW);
  assign tar_inc = (  (csw_addr_inc) &
                      //Increment at the end of the data phase
                      ((ap_crnt_state == AP_DATA) & slvready_i) &
                      //Only increment when accessing DRW register (not BDx)
                      (dp_regaddr_ap_i == AP_REGADDR_DRW) &
                      //Do not inc if tx resp was error
                      (~slvresp_i)
                   );
  assign tar_load = (load_regs & (dp_regaddr_ap_i==AP_REGADDR_TAR)) | tar_inc;

  //load_from_x do not take into account RnW, so the transfer data register
  //is always loaded, even on writes. This avoids the need for a separate
  //signal to load ap_err_ap, and does not affect functionality as the data
  //returned for a write transaction is defined as UNPREDICTABLE.
  assign load_from_slv = ((ap_crnt_state == AP_DATA) & slvready_i);
  assign load_from_ap_reg = ((ap_crnt_state == AP_DONE) & (~slv_tx));

  //attempted SLV transaction is suppressed by the de-assertion of deviceen_i
  assign slv_tx_suppressed = ((ap_crnt_state == AP_IDLE) & ap_active &
                              slv_tx & ~deviceen_i);

// ----------------------------------------------------------------------------
// AP Registers
// ----------------------------------------------------------------------------
  //CSW
  //a write of bx11 (a reserved value) into the Size field of the CSW will
  //result in 010 being stored (indicating word). This prevents SLV accesses
  //with an unsupported slvsize.
  assign csw_size_next = {dp_data_ap_i[1],
                          (dp_data_ap_i[0] & (~dp_data_ap_i[1]))};

  //Bit [1] of AddrInc (bit [5] of dp_data_ap_i) is not stored as it is used to
  //indicate packed transfers (b10), which are deprecated and should read
  //back as b00, or a reserved value (b11).
  assign csw_addr_inc_next = dp_data_ap_i[4];

  always @(posedge dclk or negedge apreset_n)
    if (!apreset_n) begin
      csw_size      <= 2'b00;
      csw_addr_inc  <= 1'b0;
    end
    else if (csw_load) begin
      csw_size      <= csw_size_next;
      csw_addr_inc  <= csw_addr_inc_next;
    end

  // Bits [27:24] of CSW map to the four slvprot outputs.
  // Bit  [24] is always RO
  // Bit  [25] is optionally RW according to USER configuration
  // Bits [27:26] are optionally RW according to MPU configuration
  // Reset (and RO) value is defined by local parameter AP_CFGPROT

  assign csw_prot[0] = AP_CFGPROT[0];

  generate

    if ((CBAW != 0) || (USER != 0)) begin : gen_csw_user_en

      reg prot_1;

      always @(posedge dclk or negedge apreset_n)
        if (!apreset_n)
          prot_1 <= AP_CFGPROT[1];
        else if (csw_load)
          prot_1 <= dp_data_ap_i[25];

      assign csw_prot[1] = cfg_user ? prot_1 : AP_CFGPROT[1];

    end else begin : gen_csw_user_dis

      assign csw_prot[1] = AP_CFGPROT[1];

    end

    if ((CBAW != 0) || (MPU != 0)) begin : gen_csw_mpu_en

      reg [1:0] prot_3_2;

      always @(posedge dclk or negedge apreset_n)
        if (!apreset_n)
          prot_3_2 <= AP_CFGPROT[3:2];
        else if (csw_load)
          prot_3_2 <= dp_data_ap_i[27:26];

      assign csw_prot[3:2] = cfg_mpu ? prot_3_2 : AP_CFGPROT[3:2];

    end else begin : gen_csw_mpu_dis

      assign csw_prot[3:2] = AP_CFGPROT[3:2];

    end

  endgenerate

  assign csw = {1'b0,                     //CSW[31]    DbgSwEnable
                3'b000, csw_prot,         //CSW[30:24] Prot
                1'b0,                     //CSW[23]    SPIDEN
                11'b00000000000,          //CSW[22:12] Reserved (RAZ)
                4'b0000,                  //CSW[11:8]  Mode
                1'b0,                     //CSW[7]     TrInProg
                deviceen_i,               //CSW[6]     DeviceEn
                1'b0, csw_addr_inc,       //CSW[5:4]   AddrInc
                1'b0,                     //CSW[3]     Reserved (RAZ)
                1'b0, csw_size            //CSW[2:0]   Size
               };
  //TAR
  //If the TAR is to be incremented, then only the bottom 10 bits are acted
  //upon. Incrementing the TAR above a 10-bit boundary causes the address to
  //wrap to the start of the boundary.
  //
  //incrd_tar is an 11 bit vector to store the result of the addition of the
  //bottom 10 bits of the TAR with tar_inc_amount. The bottom 10 bits of this
  //result are then used to form next_tar when tar_inc is set, ignoring
  //the carry out of the addition.
  assign incrd_tar = tar[9:0] + tar_inc_amount; //Generates an 11 bit result
  assign next_tar = (tar_inc  ? {tar[31:10], incrd_tar[9:0]} //Use lower 10 bits
                              : dp_data_ap_i);

  generate
    if ((CBAW != 0) || (RAR != 0)) begin : gen_tar_rar
      // Registers which do not usually have a reset term will use this reset
      // signal, connected to dpreset_n or tied high depending on whether Reset
      // All Registers (RAR) is required.

      wire rar_reset_n = cfg_rar ? apreset_n : 1'b1;

      always @(posedge dclk or negedge rar_reset_n)
        if (!rar_reset_n)
          tar <= {32{1'b1}};
        else if (tar_load)
          tar <= next_tar;

    end else begin : gen_tar

      always @(posedge dclk)
        if (tar_load)
          tar <= next_tar;

    end
  endgenerate

// ----------------------------------------------------------------------------
// DAP IO
// ----------------------------------------------------------------------------
  // APIDR Value
  // The APIDR Value can be affected by revision changes so it is XOR'ed with
  // the ECOREVNUM value input from the pins.
  assign ap_idr = {(ecorevnum_i ^ AP_IDR_REG_VAL[31:28]), AP_IDR_REG_VAL[27:0]};


  //Ensure that slvrdata_i is not passed to ap_data_ap when slvresp_i is
  //asserted in response to a read and ensure that X propogation does
  //not occur from slvrdata_i or uninitialised tar into ap_data_ap during
  //a write transaction by forcing the top bit of the address to map to one
  //of CFG, BSE, IDR or RSVD registers
  //Checked by assert u_asrt_ap_data_ap_wr_unk, u_asrt_ap_slverr_mask_slvrdata
  //u_asrt_ap_deviceen_mask_slvrdata
  assign dp_regaddr_ap_masked = {(dp_regaddr_ap_i[3] |
                                  slvresp_i | ~dp_rnw_ap_i | slv_tx_suppressed),
                                 dp_regaddr_ap_i[2:0]};

  always @*
    case (dp_regaddr_ap_masked)
      AP_REGADDR_CSW   : ap_data_ap = csw;
      AP_REGADDR_TAR   : ap_data_ap = tar;
      AP_REGADDR_CFG   : ap_data_ap = AP_CFG_REG_VAL;
      AP_REGADDR_BSE   : ap_data_ap = {ap_base_reg_i[31:12], 11'b0000_0000_001, ap_base_reg_i[0]};
      AP_REGADDR_IDR   : ap_data_ap = ap_idr;
      AP_REGADDR_DRW,
      AP_REGADDR_BD0,
      AP_REGADDR_BD1,
      AP_REGADDR_BD2,
      AP_REGADDR_BD3   : ap_data_ap = slvrdata_i;
      AP_REGADDR_RSVD1,
      AP_REGADDR_RSVD2,
      AP_REGADDR_RSVD3,
      AP_REGADDR_RSVD4,
      AP_REGADDR_RSVD5,
      AP_REGADDR_RSVD6 : ap_data_ap = 32'h0000_0000;  //Reserved Addrs are RAZ
      default : ap_data_ap = 32'hxxxx_xxxx;  //X Propagation
    endcase

  // ap_base_reg_i[11:1] bits are RAZ/O so ignore configuration input to
  // minimise area
  wire [10:0] unused = ap_base_reg_i[11:1];

  //ap_wr_en
  //This is the write enable for AP data and error response.
  assign ap_wr_en = load_from_ap_reg | load_from_slv | slv_tx_suppressed;

  //ap_out_en is the output enable for the AP side of the transfer
  //block. It is asserted whenever the AP is active so that the AP can read
  //the necessary data.
  assign ap_out_en = ap_active;

  //ap_err_ap Response from the AP Transaction is set if:
  assign ap_err_ap = slvresp_i |            //SLV Transaction Returned an Error
                     slv_tx_suppressed;     //or SLV Tx was attempted
                                            //with DEVICEEN low

// ----------------------------------------------------------------------------
// SLV IO
// ----------------------------------------------------------------------------
  //slvaddr
  // - slvaddr_3_2 - on a BDx access, slvaddr[3:2] is specified by regaddr
  assign slvaddr_3_2 = bdx_acc  ? dp_regaddr_ap_i[1:0]
                                : tar[3:2];
  // - slvaddr_1_0 - slvaddr[1:0] is masked so that slvaddr is always aligned
  // to slvsize
  assign slvaddr_1_0_mask = { ~(slvsize[1]),
                              ~(|slvsize[1:0]) };
  assign slvaddr_1_0 = tar[1:0] & slvaddr_1_0_mask;

  assign slvaddr = {tar[31:4], slvaddr_3_2, slvaddr_1_0};

  //slvtrans
  assign slvtrans = {(ap_crnt_state == AP_ADDR), 1'b0};

  //slvprot
  assign slvprot = csw_prot;

  //slvsize
  assign slvsize = {(csw_size[1] | bdx_acc), (csw_size[0] & ~bdx_acc)};

// ----------------------------------------------------------------------------
// Assertions
// ----------------------------------------------------------------------------
`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

  // Checking that dp_rnw_ap_i, dp_regaddr_ap_i, and dp_data_ap_i are never X
  // This should be guaranteed and these assertions are a safety check
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("RnW bit for AP must not be Unknown"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_dp_rnw_ap
    (
      .clock      (dclk),
      .reset      (apreset_n),
      .enable     (1'b1),
      .qualifier  (1'b1),
      .test_expr  (dp_rnw_ap_i),
      .fire       ()
    );

  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (4),
      .property_type       (`OVL_ASSERT),
      .msg                 ("RegAddr for AP must not be Unknown"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_dp_regaddr_ap
    (
      .clock      (dclk),
      .reset      (apreset_n),
      .enable     (1'b1),
      .qualifier  (1'b1),
      .test_expr  (dp_regaddr_ap_masked),
      .fire       ()
    );

  //X-Checking on Register Load Enables/Async Resets used in IF statements
  // - apreset_n is global async reset
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Reset for AP Must not be Unknown"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_apreset_n
      ( .clock      (dclk),
        .reset      (1'b1),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (apreset_n),
        .fire       () );

  // - csw_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("csw_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_csw_load
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (csw_load),
        .fire       () );

  // - tar_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (1),
      .property_type       (`OVL_ASSERT),
      .msg                 ("tar_load can never be x"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_xcheck_tar_load
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (tar_load),
        .fire       () );

  //State Machine
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (2),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP State Unknown"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_statemachine_unk
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (ap_crnt_state),
        .fire       ());

  // - X never spuriously returned to AP during a write transaction
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
      .width               (32),
      .property_type       (`OVL_ASSERT),
      .msg                 ("X must not be passed to AP during write"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_data_ap_wr_unk
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .qualifier  (ap_wr_en & (~dp_rnw_ap_i)),
        .test_expr  (ap_data_ap),
        .fire       () );

  // - AP must not return slvrdata_i when an error response is indicated
  ovl_implication
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP must not return slvrdata_i when slvresp_i asserted"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_slverr_mask_slvrdata
      ( .clock           (dclk),
        .reset           (apreset_n),
        .enable          (1'b1),
        .antecedent_expr (slvresp_i),
        .consequent_expr ((dp_regaddr_ap_masked != AP_REGADDR_DRW) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD0) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD1) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD2) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD3)),
        .fire            () );

  // - AP must not return slvrdata_i when deviceen_i disables SLV intervace
  ovl_implication
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP must not return slvrdata_i when deviceen_i deasserted"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_deviceen_mask_slvrdata
      ( .clock           (dclk),
        .reset           (apreset_n),
        .enable          (1'b1),
        .antecedent_expr (ap_wr_en & (ap_crnt_state != AP_DATA) & ~deviceen_i),
        .consequent_expr ((dp_regaddr_ap_masked != AP_REGADDR_DRW) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD0) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD1) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD2) &
                          (dp_regaddr_ap_masked != AP_REGADDR_BD3)),
        .fire            () );

  //Control Signals
  // - The AP should only ever be in IDLE when REQ == ACK
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP Must not be active when REQ != ACK"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_active_not_in_control
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  ((ap_crnt_state != AP_IDLE) &
                     (ap_ack_ap_i == dp_req_ap_i)),
        .fire       () );


  //slvsize should never be greater than b010
  ovl_range
    #(.severity_level      (`OVL_FATAL),
      .width               (2),
      .min                 (2'b00),
      .max                 (2'b10),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Unsupported SLV Transaction Size Specified"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_slv_unsupported_size
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  (slvsize),
        .fire       () );

  //csw_size should never be b11
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("csw_size can never be b11"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_csw_size_b11_check
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  ((csw_size == 2'b11)),
        .fire       () );

  //Unaligned Transfers are not supported
  // - This is forced on SLVADDR by masking the relevant bits, so there are
  // two levels of checking for this: FATAL asserts to check that the address
  // of SLVADDR is never unaligned, and WARNING asserts if software attempts
  // an unaligned access

  // - Unaligned Word (i.e. bits [1:0] are not b00)
  ovl_never  //On SLV Interface
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Unaligned Word Address on SLV Interface"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_unaligned_word_slv
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  ((slvsize == 2'b10) & (|slvaddr[1:0])),
        .fire       () );

  ovl_never  //Attempted by software
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Unaligned Word Access Attempted"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_ap_unaligned_word_tx
      ( .clock        (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  ((csw_size == 2'b10) & (|tar[1:0]) & slvtrans[1]),
        .fire       () );


  // - Unaligned H-Word (i.e. bit [0] is not b0)
  ovl_never
    #(.severity_level      (`OVL_FATAL),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Unaligned Half Word Address on SLV Interface"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_unaligned_hword_slv
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  ((slvsize == 2'b01) & slvaddr[0]),
        .fire       () );

  ovl_never  //Attempted by software
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Unaligned Half Word Access Attempted"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_ap_unaligned_hword_tx
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  ((csw_size == 2'b01) & tar[0] & slvtrans[1]),
        .fire       () );

  //Warnings for Illegal software accesses
  // - Accesses to BDx registers when size != word are UNP
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Accessing BDx with Size != Word is UNP"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_bdx_subword_acc
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  (bdx_acc & (csw_size != 2'b10) & slvtrans[1]),
        .fire       () );

  // - Attempt to set packed transfer/reserved addr inc value
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Attempt to set AddrInc to unsupported value"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_addr_inc_resvd
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  (csw_load & dp_data_ap_i[5]),
        .fire       () );

  // - Memory access attempted without initialising the TAR
  ovl_never_unknown
    #(.severity_level      (`OVL_INFO),
      .width               (32),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Memory access attempted before TAR set"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_uninit_tar
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .qualifier  (slvtrans[1]),
        .test_expr  (tar),
        .fire       () );

  // - It is architecturally UNP to attempt to increment the TAR beyond
  // bit[9]
  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("TAR Incremented beyond bit [9]"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_tar_inc_past_10
      (
        .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  (tar_inc & (&tar[9:2]) & ( //Wraps if tar[9:2] are set and:
                      (slvsize == 2'b10) |             //Word
                      ((slvsize == 2'b01) & tar[1]) |  //Hword and tar[1] set
                      (&tar[1:0]) ) ),//Byte & tar is 3
        .fire       ()
      );

  // - The CSW must be initialised before a memory access is attempted
  reg csw_initialised;
  always @(posedge dclk or negedge apreset_n)
    if (!apreset_n)
      csw_initialised <= 1'b0;
    else if (csw_load)
      csw_initialised <= 1'b1;

  ovl_never
    #(.severity_level      (`OVL_INFO),
      .property_type       (`OVL_ASSERT),
      .msg                 ("Memory accesses attempted before CSW initialised"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_info_mem_acc_before_csw_init
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  (~csw_initialised & slvtrans[1]),
        .fire       () );

  ovl_always
    #(.severity_level      (`OVL_ERROR),
      .property_type       (`OVL_ASSERT),
      .msg                 ("AP ROM table base[11:1] must be 11'b0000_0000_001"),
      .coverage_level      (`OVL_COVER_DEFAULT),
      .clock_edge          (`OVL_POSEDGE),
      .reset_polarity      (`OVL_ACTIVE_LOW),
      .gating_type         (`OVL_GATE_NONE))
    u_asrt_ap_base_reg
      ( .clock      (dclk),
        .reset      (apreset_n),
        .enable     (1'b1),
        .test_expr  (ap_base_reg_i[11:1] == 11'b0000_0000_001),
        .fire       () );

`endif

endmodule
