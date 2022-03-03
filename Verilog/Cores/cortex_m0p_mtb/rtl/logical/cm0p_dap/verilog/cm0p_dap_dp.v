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

module cm0p_dap_dp
  #(parameter CBAW     = 0,
    parameter JTAGnSW  = 0,    //1 -> JTAG, 0 -> SW
    parameter SWMD     = 0,    //1 -> For Serial Wire multi-drop support
    parameter HALTEV   = 0,    //1 -> Debug halt event is supported
    parameter RAR      = 0     //1 -> Resets on All Registers, 0 -> not RAR
    )
   (input  wire        swclktck,
    input  wire        dpreset_n,
    input  wire        n_trst,
    input  wire        tdi_i,
    input  wire        swditms_i,
    input  wire        cdbgpwrupack_i,
    input  wire        halted_i,
    output wire        tdo_o,
    output wire        n_tdoen_o,
    output wire        swdo_o,
    output wire        swdoen_o,
    output wire        swdetect_o,
    output wire        cdbgpwrupreq_o,
    //Internal DAP IO
    input  wire [33:0] dap_ap_to_dp_i,
    output wire [37:0] dap_dp_to_ap_o,

    //Configurability IO
    input  wire [31:0] targetid_i,   // 31:28=TREVISION 27:12=TPARTNO 11:1=TDESIGNER 0=1
    input  wire [3:0]  instanceid_i, // DLPIDR[31:28] for Serial Wire protocol 2
    input  wire [3:0]  ecorevnum_i,

    // Scan Enable for DFT
    input  wire        DFTSE
    );


  wire          cfg_jtag;
  wire          cfg_haltev;

  generate
    if (CBAW == 0) begin : gen_cbaw
      assign cfg_jtag   = (JTAGnSW != 0);
      assign cfg_haltev = (HALTEV != 0);
    end
  endgenerate

  wire [31:0] dp_data_dp;
  wire [3:0]  dp_regaddr_dp;
  wire        dp_rnw_dp;
  wire [31:0] dp_data;
  wire [3:0]  dp_regaddr;
  wire        dp_rnw;
  wire        dp_wr_en;
  wire        dp_out_en;
  wire        dp_err_out_en;
  wire        dp_req_dp;
  wire        dp_req_dp_load;
  wire        ap_err_dp;
  wire        ap_ack_dp;
  wire [31:0] ap_data_dp;
  wire        halted_sync;
  wire        halted_n;
  wire        csyspwrupack_sync;
  wire        dp_cs_cdbgpwrupreq;
  wire        dp_cs_cdbgpwrupack;
  wire        reset_dp_ap_handshake;

  //Module Outputs from JTAG & SW to be Selected Between
  wire        jt_tdo;
  wire        jt_n_tdoen;
  wire        sw_swdo;
  wire        sw_swdoen;
  wire        sw_swdetect;
  wire        jt_dp_cs_cdbgpwrupreq;
  wire        sw_dp_cs_cdbgpwrupreq;
  wire        jt_csyspwrupreq;
  wire        sw_csyspwrupreq;
  wire [31:0] jt_dp_data_dp;
  wire [31:0] sw_dp_data_dp;
  wire [3:0]  jt_dp_regaddr_dp;
  wire [3:0]  sw_dp_regaddr_dp;
  wire        jt_dp_rnw_dp;
  wire        sw_dp_rnw_dp;
  wire        jt_dp_wr_en;
  wire        sw_dp_wr_en;
  wire        jt_dp_out_en;
  wire        sw_dp_out_en;
  wire        jt_dp_err_out_en;
  wire        sw_dp_err_out_en;
  wire        jt_dp_req_dp_load;
  wire        sw_dp_req_dp_load;

  wire        ap_err;
  wire        ap_ack_ap;
  wire [31:0] ap_data;

  //------------------------------------------------------------------------------
  // Synchroniser for halted_i if option included
  //------------------------------------------------------------------------------

  generate
    if ((CBAW != 0) || (HALTEV != 0)) begin : gen_event

      cm0p_dap_cdc_capt_sync
        u_halted_sync
          (
           .SYNCRSTn     (dpreset_n),
           .SYNCCLK      (swclktck),
           .SYNCDI       (halted_i),
           .DFTSE        (DFTSE),
           .SYNCDO       (halted_sync)
           );

    end else begin :gen_event_dis // block: gen_event

      wire unused          = halted_i;

      assign halted_sync   = 1'b0;

    end
  endgenerate

  assign halted_n = cfg_haltev & ~halted_sync; // Status is active low

  //------------------------------------------------------------------------------
  // Select Between JTAG & SW
  //------------------------------------------------------------------------------

  //cfg_jtag is set when JTAG is selected

  //Most input signals to cm0p_dap_dp are connected to two internal signals:
  //one to each DP. These input signal pairs are muxed such that one signal
  //is always tied-off depending on which DP is selected. Certain signals are
  //only used by a single DP (e.g. tdi_i); these are tied-off in the usual way.
  //Inputs to the JTAG DP are prefixed jt_, inputs to the SW DP are prefixed
  //sw_.

  generate
    if ((CBAW != 0) || (JTAGnSW != 0)) begin : gen_jtag_dp

      wire jt_tdi                   = cfg_jtag       & tdi_i;
      wire jt_tms                   = cfg_jtag       & swditms_i;
      wire jt_csyspwrupack_sync     = cfg_jtag       & csyspwrupack_sync;
      wire jt_dp_cs_cdbgpwrupack    = cfg_jtag       & dp_cs_cdbgpwrupack;
      wire jt_halted_n              = cfg_jtag       & halted_n;
      wire jt_ap_err_dp             = cfg_jtag       & ap_err_dp;
      wire jt_ap_ack_dp             = cfg_jtag       & ap_ack_dp;
      wire [31:0] jt_ap_data_dp     = {32{cfg_jtag}} & ap_data_dp;
      wire jt_dp_req_dp             = cfg_jtag       & dp_req_dp;
      wire jt_reset_dp_ap_handshake = cfg_jtag       & reset_dp_ap_handshake;
      wire [3:0]  jt_ecorevnum      = {4{cfg_jtag}}  & ecorevnum_i;

      //JTAG DP
      cm0p_dap_dp_jtag
        #(.CBAW     (CBAW),
          .JTAGnSW  (JTAGnSW),
          .HALTEV   (HALTEV),
          .RAR      (RAR))
          u_cm0p_dap_dp_jtag
            (.tck                        (swclktck),
             .dpreset_n                  (dpreset_n),
             .n_trst                     (n_trst),
             .tdi_i                      (jt_tdi),
             .tms_i                      (jt_tms),
             .halted_n_i                 (jt_halted_n),
             .dp_cs_cdbgpwrupack_i       (jt_dp_cs_cdbgpwrupack),
             .csyspwrupack_sync_i        (jt_csyspwrupack_sync),
             .dp_cs_cdbgpwrupreq_o       (jt_dp_cs_cdbgpwrupreq),
             .csyspwrupreq_o             (jt_csyspwrupreq),
             .tdo_o                      (jt_tdo),
             .n_tdoen_o                  (jt_n_tdoen),
             .ap_data_dp_i               (jt_ap_data_dp),
             .ap_err_dp_i                (jt_ap_err_dp),
             .ap_ack_dp_i                (jt_ap_ack_dp),
             .dp_data_dp_o               (jt_dp_data_dp),
             .dp_regaddr_dp_o            (jt_dp_regaddr_dp),
             .dp_rnw_dp_o                (jt_dp_rnw_dp),
             .dp_wr_en_o                 (jt_dp_wr_en),
             .dp_out_en_o                (jt_dp_out_en),
             .dp_err_out_en_o            (jt_dp_err_out_en),
             .dp_req_dp_i                (jt_dp_req_dp),
             .dp_req_dp_load_o           (jt_dp_req_dp_load),
             .reset_dp_ap_handshake_i    (jt_reset_dp_ap_handshake),
             .ecorevnum_i                (jt_ecorevnum)
             );

      // TARGETID and INSTANCEID not used for JTAG
      wire [35:0] unused = {targetid_i, instanceid_i};

    end else begin : gen_no_jtag_dp

      wire [1:0] unused = {tdi_i, n_trst};

      assign     jt_tdo                = 1'b0;
      assign     jt_n_tdoen            = 1'b0;
      assign     jt_dp_cs_cdbgpwrupreq = 1'b0;
      assign     jt_csyspwrupreq       = 1'b0;
      assign     jt_dp_data_dp         = {32{1'b0}};
      assign     jt_dp_regaddr_dp      = {4{1'b0}};
      assign     jt_dp_rnw_dp          = 1'b0;
      assign     jt_dp_wr_en           = 1'b0;
      assign     jt_dp_out_en          = 1'b0;
      assign     jt_dp_err_out_en      = 1'b0;
      assign     jt_dp_req_dp_load     = 1'b0;

    end // block: gen_no_jtag_dp

    if ((CBAW != 0) || (JTAGnSW == 0)) begin : gen_sw_dp

      wire sw_swdi                  = (!cfg_jtag)     & swditms_i;
      wire sw_csyspwrupack_sync     = (!cfg_jtag)     & csyspwrupack_sync;
      wire sw_dp_cs_cdbgpwrupack    = (!cfg_jtag)     & dp_cs_cdbgpwrupack;
      wire sw_halted_n              = (!cfg_jtag)     & halted_n;
      wire sw_ap_err_dp             = (!cfg_jtag)     & ap_err_dp;
      wire sw_ap_ack_dp             = (!cfg_jtag)     & ap_ack_dp;
      wire [31:0] sw_ap_data_dp     = {32{!cfg_jtag}} & ap_data_dp;
      wire sw_dp_req_dp             = (!cfg_jtag)     & dp_req_dp;
      wire sw_reset_dp_ap_handshake = (!cfg_jtag)     & reset_dp_ap_handshake;
      wire [31:0] sw_targetid       = {32{!cfg_jtag}} & targetid_i;
      wire [3:0]  sw_instanceid     = {4{!cfg_jtag}}  & instanceid_i;
      wire [3:0]  sw_ecorevnum      = {4{!cfg_jtag}}  & ecorevnum_i;

      //SW DP
      cm0p_dap_dp_sw
        #(.CBAW     (CBAW),
          .JTAGnSW  (JTAGnSW),
          .SWMD     (SWMD),
          .HALTEV   (HALTEV),
          .RAR      (RAR))
          u_cm0p_dap_dp_sw
            (.swclk                      (swclktck),
             .dpreset_n                  (dpreset_n),
             .swdi_i                     (sw_swdi),
             .halted_n_i                 (sw_halted_n),
             .dp_cs_cdbgpwrupack_i       (sw_dp_cs_cdbgpwrupack),
             .csyspwrupack_sync_i        (sw_csyspwrupack_sync),
             .dp_cs_cdbgpwrupreq_o       (sw_dp_cs_cdbgpwrupreq),
             .csyspwrupreq_o             (sw_csyspwrupreq),
             .swdo_o                     (sw_swdo),
             .swdoen_o                   (sw_swdoen),
             .swdetect_o                 (sw_swdetect),
             .ap_data_dp_i               (sw_ap_data_dp),
             .ap_err_dp_i                (sw_ap_err_dp),
             .ap_ack_dp_i                (sw_ap_ack_dp),
             .dp_data_dp_o               (sw_dp_data_dp),
             .dp_regaddr_dp_o            (sw_dp_regaddr_dp),
             .dp_rnw_dp_o                (sw_dp_rnw_dp),
             .dp_wr_en_o                 (sw_dp_wr_en),
             .dp_out_en_o                (sw_dp_out_en),
             .dp_err_out_en_o            (sw_dp_err_out_en),
             .dp_req_dp_i                (sw_dp_req_dp),
             .dp_req_dp_load_o           (sw_dp_req_dp_load),
             .reset_dp_ap_handshake_i    (sw_reset_dp_ap_handshake),
             .targetid_i                 (sw_targetid),
             .instanceid_i               (sw_instanceid),
             .ecorevnum_i                (sw_ecorevnum),
             .DFTSE                      (DFTSE)
             );

    end else begin : gen_no_sw_dp

      assign sw_dp_cs_cdbgpwrupreq = 1'b0;
      assign sw_csyspwrupreq       = 1'b0;
      assign sw_swdo               = 1'b0;
      assign sw_swdoen             = 1'b0;
      assign sw_swdetect           = 1'b0;
      assign sw_dp_data_dp         = {32{1'b0}};
      assign sw_dp_regaddr_dp      = {4{1'b0}};
      assign sw_dp_rnw_dp          = 1'b0;
      assign sw_dp_wr_en           = 1'b0;
      assign sw_dp_out_en          = 1'b0;
      assign sw_dp_err_out_en      = 1'b0;
      assign sw_dp_req_dp_load     = 1'b0;

    end
  endgenerate

  assign dp_data_dp         = cfg_jtag ? jt_dp_data_dp         : sw_dp_data_dp;
  assign dp_regaddr_dp      = cfg_jtag ? jt_dp_regaddr_dp      : sw_dp_regaddr_dp;
  assign dp_rnw_dp          = cfg_jtag ? jt_dp_rnw_dp          : sw_dp_rnw_dp;
  assign dp_wr_en           = cfg_jtag ? jt_dp_wr_en           : sw_dp_wr_en;
  assign dp_out_en          = cfg_jtag ? jt_dp_out_en          : sw_dp_out_en;
  assign dp_err_out_en      = cfg_jtag ? jt_dp_err_out_en      : sw_dp_err_out_en;
  assign dp_req_dp_load     = cfg_jtag ? jt_dp_req_dp_load     : sw_dp_req_dp_load;
  assign dp_cs_cdbgpwrupreq = cfg_jtag ? jt_dp_cs_cdbgpwrupreq : sw_dp_cs_cdbgpwrupreq;

  // To facilitate tool workflow, signals crossing the power domain boundary
  // from the DP (DP Power Domain) to the AP (Debug Power Domain) are bundled
  // into a bus to be passed across the boundary as a single signal.

  // Unpack signals from incoming bus
  assign {
          ap_data,
          ap_err,
          ap_ack_ap
          }                 = dap_ap_to_dp_i;

  // DP Half of the CDC Module
  cm0p_dap_dp_cdc
    #(.CBAW    (CBAW),
      .RAR     (RAR))
      u_cm0p_dap_dp_cdc
        (.swclktck                   (swclktck),
         .dpreset_n                  (dpreset_n),
         .dp_wr_en_i                 (dp_wr_en),
         .dp_rnw_dp_i                (dp_rnw_dp),
         .dp_regaddr_dp_i            (dp_regaddr_dp),
         .dp_data_dp_i               (dp_data_dp),
         .dp_out_en_i                (dp_out_en),
         .dp_err_out_en_i            (dp_err_out_en),
         .dp_req_dp_load_i           (dp_req_dp_load),
         .dp_req_dp_o                (dp_req_dp),
         .dp_rnw_o                   (dp_rnw),
         .dp_regaddr_o               (dp_regaddr),
         .dp_data_o                  (dp_data),
         .ap_data_dp_o               (ap_data_dp),
         .ap_err_dp_o                (ap_err_dp),
         .ap_data_i                  (ap_data),
         .ap_err_i                   (ap_err),
         .ap_ack_ap_i                (ap_ack_ap),
         .ap_ack_dp_o                (ap_ack_dp),
         .DFTSE                      (DFTSE)
         );

  // Power-up Handshaking Module
  cm0p_dap_dp_pwr
    u_cm0p_dap_dp_pwr
      (.swclktck                   (swclktck),
       .dpreset_n                  (dpreset_n),
       .dp_cs_cdbgpwrupreq_i       (dp_cs_cdbgpwrupreq),
       .dp_cs_cdbgpwrupack_o       (dp_cs_cdbgpwrupack),
       .cdbgpwrupreq_o             (cdbgpwrupreq_o),
       .cdbgpwrupack_i             (cdbgpwrupack_i),
       .dp_req_dp_i                (dp_req_dp),
       .ap_ack_dp_i                (ap_ack_dp),
       .reset_dp_ap_handshake_o    (reset_dp_ap_handshake),
       .DFTSE                      (DFTSE)
       );

  //Outputs from the separate SW & JTAG DPs, prefixed sw_ or jt_ are muxed onto
  //the relevant internal signal, which is then masked to form the output.

  // In Cortex-M0+ DAP, csyspwrupreq is looped back to csyspwrupack
  assign csyspwrupack_sync  = cfg_jtag ? jt_csyspwrupreq : sw_csyspwrupreq;

  assign tdo_o              =   cfg_jtag  & jt_tdo;
  assign n_tdoen_o          =   cfg_jtag  & jt_n_tdoen;
  assign swdo_o             = (!cfg_jtag) & sw_swdo;
  assign swdoen_o           = (!cfg_jtag) & sw_swdoen;
  assign swdetect_o         = (!cfg_jtag) & sw_swdetect;

  assign dap_dp_to_ap_o  = {
                            dp_rnw,         // [37]
                            dp_regaddr,     // [36:33]
                            dp_data,        // [32:1]
                            dp_req_dp       // [0]
                           };

endmodule
