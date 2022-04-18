//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-11-02 09:50:33 +0000 (Fri, 02 Nov 2012) $
//   Revision   : $Revision: 227183 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ CROSS TRIGGER INTERFACE
//-----------------------------------------------------------------------------
// The CM0PCTI is a simplified version of the CoreSight CTI specifically
// designed for CORTEX-M0+. It is synchronous with the Cortex-M0 clock, and
// has direct interface with the Cortex-M0 and the CoreSight MTB-M0+. It has
// 1 trigger input, six trigger outputs, and 4 channel inputs/outputs. It
// implements an AHB-lite interface.
// ----------------------------------------------------------------------------

module CM0PCTI
   (
    // Clock and resets

    input wire         HCLK,         // AHB clock
    input wire         HRESETn,      // AHB reset
    input wire         CTIRESETn,    // CTI reset

    // Cortex-M0+ interface

    output wire        EDBGRQ,       // Debug halt request
    output wire        DBGRESTART,   // Debug restart request
    output wire [ 1:0] CTIIRQ,       // CTI IRQ request
    input  wire        DBGRESTARTED, // Debug restart acknowledge
    input  wire        HALTED,       // Core is halted in Debug state

    // MTB trace control interface

    output wire        TSTART,       // MTB trace start
    output wire        TSTOP,        // MTB trace stop

    // CTI channel interface

    input  wire [ 3:0] CTICHIN,      // CTI channel in
    output wire [ 3:0] CTICHOUT,     // CTI channel out

    // AHB-Lite slave interface

    input  wire        HSEL,         // AHB select
    input  wire [31:0] HADDR,        // AHB address
    input  wire        HWRITE,       // AHB write
    input  wire [ 2:0] HSIZE,        // AHB size
    input  wire [ 2:0] HBURST,       // AHB burst
    input  wire [ 3:0] HPROT,        // AHB properties
    input  wire [ 1:0] HTRANS,       // AHB transfer
    input  wire        HMASTLOCK,    // AHB locked transfer
    input  wire        HREADY,       // AHB ready
    input  wire [31:0] HWDATA,       // AHB write data
    output wire        HRESP,        // AHB error response
    output wire        HREADYOUT,    // AHB ready out
    output wire [31:0] HRDATA,       // AHB read data

    // Debug authentication interface

    input  wire        DBGEN,        // Invasive debug enable
    input  wire        NIDEN,        // Non-invasive debug enable

    // Miscellaneous signals

    input  wire [ 3:0] ECOREVNUM);   // ARM ECO bits


    // ------------------------------------------------------------------------
    // LOCAL PARAMETERS
    // ------------------------------------------------------------------------

    // Architectural registers
    localparam [ 9:0] L_ADDR_CONTROL           = 10'h000;
    localparam [ 9:0] L_ADDR_INTACK            = 10'h004;
    localparam [ 9:0] L_ADDR_APPSET            = 10'h005;
    localparam [ 9:0] L_ADDR_APPCLEAR          = 10'h006;
    localparam [ 9:0] L_ADDR_APPPULSE          = 10'h007;

    localparam [ 9:0] L_ADDR_INEN0             = 10'h008;
    localparam [ 9:0] L_ADDR_OUTEN0            = 10'h028;
    localparam [ 9:0] L_ADDR_OUTEN2            = 10'h02A;
    localparam [ 9:0] L_ADDR_OUTEN3            = 10'h02B;
    localparam [ 9:0] L_ADDR_OUTEN4            = 10'h02C;
    localparam [ 9:0] L_ADDR_OUTEN5            = 10'h02D;
    localparam [ 9:0] L_ADDR_OUTEN7            = 10'h02F;

    localparam [ 9:0] L_ADDR_TRIGINSTATUS      = 10'h04C;
    localparam [ 9:0] L_ADDR_TRIGOUTSTATUS     = 10'h04D;
    localparam [ 9:0] L_ADDR_CHINSTATUS        = 10'h04E;
    localparam [ 9:0] L_ADDR_CHOUTSTATUS       = 10'h04F;

    localparam [ 9:0] L_ADDR_GATE              = 10'h050;

    // Integration registers
    localparam [ 9:0] L_ADDR_ITCTRL            = 10'h3C0;
    localparam [ 9:0] L_ADDR_ITCHOUT           = 10'h3B9;
    localparam [ 9:0] L_ADDR_ITTRIGOUT         = 10'h3BA;
    localparam [ 9:0] L_ADDR_ITTRIGOUTACK      = 10'h3BC;
    localparam [ 9:0] L_ADDR_ITCHIN            = 10'h3BD;
    localparam [ 9:0] L_ADDR_ITTRIGIN          = 10'h3BE;

    // CoreSight management register address offsets
    localparam [ 9:0] L_ADDR_CLAIMSET          = 10'h3E8;
    localparam [ 9:0] L_ADDR_CLAIMCLR          = 10'h3E9;
    localparam [ 9:0] L_ADDR_AUTHSTATUS        = 10'h3EE;
    localparam [ 9:0] L_ADDR_DEVARCH           = 10'h3EF;
    localparam [ 9:0] L_ADDR_DEVID             = 10'h3F2;
    localparam [ 9:0] L_ADDR_DEVTYPE           = 10'h3F3;
    localparam [ 9:0] L_ADDR_PERIPHID4         = 10'h3F4;
    localparam [ 9:0] L_ADDR_PERIPHID0         = 10'h3F8;
    localparam [ 9:0] L_ADDR_PERIPHID1         = 10'h3F9;
    localparam [ 9:0] L_ADDR_PERIPHID2         = 10'h3FA;
    localparam [ 9:0] L_ADDR_PERIPHID3         = 10'h3FB;
    localparam [ 9:0] L_ADDR_COMPONID0         = 10'h3FC;
    localparam [ 9:0] L_ADDR_COMPONID1         = 10'h3FD;
    localparam [ 9:0] L_ADDR_COMPONID2         = 10'h3FE;
    localparam [ 9:0] L_ADDR_COMPONID3         = 10'h3FF;

    // CoreSight management register values
    localparam [ 3:0] L_VAL_CLAIMSET           = 4'hF;
    localparam [ 0:0] L_VAL_AUTHSTATUS_NSID    = 1'b1;
    localparam [ 0:0] L_VAL_AUTHSTATUS_NSNID   = 1'b1;
    localparam [ 0:0] L_VAL_AUTHSTATUS_SID     = 1'b0;
    localparam [ 0:0] L_VAL_AUTHSTATUS_SNID    = 1'b0;
    localparam [31:0] L_VAL_DEVARCH            = 32'h47701A14;
    localparam [31:0] L_VAL_DEVID              = 32'h01040800;
    localparam [ 7:0] L_VAL_DEVTYPE            = 8'h14;
    localparam [ 7:0] L_VAL_PERIPHID4          = 8'h04;
    localparam [ 7:0] L_VAL_PERIPHID0          = 8'hA6;
    localparam [ 7:0] L_VAL_PERIPHID1          = 8'hB9;
    localparam [ 7:0] L_VAL_PERIPHID2          = 8'h0B;
    localparam [ 3:0] L_VAL_PERIPHID3_CUSTOM   = 4'h0;
    localparam [ 7:0] L_VAL_COMPONID0          = 8'h0D;
    localparam [ 7:0] L_VAL_COMPONID1          = 8'h90;
    localparam [ 7:0] L_VAL_COMPONID2          = 8'h05;
    localparam [ 7:0] L_VAL_COMPONID3          = 8'hB1;



   // -------------------------------------------------------------------------
   // AHB-LITE SLAVE INTERFACE - Address decoding and data write
   // -------------------------------------------------------------------------

   reg       dphase_q;        // indicate data phase
   reg [9:0] addr_11to2_q;    // registered address bits 11 to 2
   reg       write_q;         // registered write

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       dphase_q <= 1'b0;
     else if (HREADY)
       dphase_q <= HSEL & HTRANS[1];

   always @(posedge HCLK)
     if (HSEL & HREADY & HTRANS[1]) begin
       addr_11to2_q <= HADDR[11:2];
       write_q      <= HWRITE;
     end

   //
   // Address decoding
   //

   wire sel_control        = ( addr_11to2_q == L_ADDR_CONTROL       );
   wire sel_intack         = ( addr_11to2_q == L_ADDR_INTACK        );
   wire sel_appset         = ( addr_11to2_q == L_ADDR_APPSET        );
   wire sel_appclear       = ( addr_11to2_q == L_ADDR_APPCLEAR      );
   wire sel_apppulse       = ( addr_11to2_q == L_ADDR_APPPULSE      );

   wire sel_inen0          = ( addr_11to2_q == L_ADDR_INEN0         );
   wire [5:0] sel_outen    = { addr_11to2_q == L_ADDR_OUTEN7,
                               addr_11to2_q == L_ADDR_OUTEN5,
                               addr_11to2_q == L_ADDR_OUTEN4,
                               addr_11to2_q == L_ADDR_OUTEN3,
                               addr_11to2_q == L_ADDR_OUTEN2,
                               addr_11to2_q == L_ADDR_OUTEN0        };

   wire sel_triginstatus   = ( addr_11to2_q == L_ADDR_TRIGINSTATUS  );
   wire sel_trigoutstatus  = ( addr_11to2_q == L_ADDR_TRIGOUTSTATUS );
   wire sel_chinstatus     = ( addr_11to2_q == L_ADDR_CHINSTATUS    );
   wire sel_choutstatus    = ( addr_11to2_q == L_ADDR_CHOUTSTATUS   );

   wire sel_gate           = ( addr_11to2_q == L_ADDR_GATE          );

   wire sel_itctrl         = ( addr_11to2_q == L_ADDR_ITCTRL        );
   wire sel_itchout        = ( addr_11to2_q == L_ADDR_ITCHOUT       );
   wire sel_ittrigout      = ( addr_11to2_q == L_ADDR_ITTRIGOUT     );
   wire sel_ittrigoutack   = ( addr_11to2_q == L_ADDR_ITTRIGOUTACK  );
   wire sel_itchin         = ( addr_11to2_q == L_ADDR_ITCHIN        );
   wire sel_ittrigin       = ( addr_11to2_q == L_ADDR_ITTRIGIN      );

   wire sel_claimset       = ( addr_11to2_q == L_ADDR_CLAIMSET      );
   wire sel_claimclr       = ( addr_11to2_q == L_ADDR_CLAIMCLR      );
   wire sel_authstatus     = ( addr_11to2_q == L_ADDR_AUTHSTATUS    );
   wire sel_devicearch     = ( addr_11to2_q == L_ADDR_DEVARCH       );
   wire sel_deviceid       = ( addr_11to2_q == L_ADDR_DEVID         );
   wire sel_devicetype     = ( addr_11to2_q == L_ADDR_DEVTYPE       );

   wire sel_peripheralid0  = ( addr_11to2_q == L_ADDR_PERIPHID0     );
   wire sel_peripheralid1  = ( addr_11to2_q == L_ADDR_PERIPHID1     );
   wire sel_peripheralid2  = ( addr_11to2_q == L_ADDR_PERIPHID2     );
   wire sel_peripheralid3  = ( addr_11to2_q == L_ADDR_PERIPHID3     );
   wire sel_peripheralid4  = ( addr_11to2_q == L_ADDR_PERIPHID4     );
   wire sel_componentid0   = ( addr_11to2_q == L_ADDR_COMPONID0     );
   wire sel_componentid1   = ( addr_11to2_q == L_ADDR_COMPONID1     );
   wire sel_componentid2   = ( addr_11to2_q == L_ADDR_COMPONID2     );
   wire sel_componentid3   = ( addr_11to2_q == L_ADDR_COMPONID3     );

   //
   // Architectural registers declaration
   //

   reg       control_q;     // CTICONTROL.GLBEN
   reg [3:0] apptrig_q;     // CTIAPPTRIG{APPSET,APPCLEAR}
   reg [3:0] inen0_q;       // CTIINENn.INEN
   reg [3:0] outen_q [5:0]; // CTIOUTENn.OUTEN
   reg [3:0] gate_q;        // CTIGATE.GATE
   reg       itctrl_q;      // CTIITCTRL.IME
   reg [3:0] claimtag_q;    // CTICLAIM{SET,CLR}.CLAIM

   reg [3:0] chout_q;       // CTICHOUTSTATUS.CHOUT
   reg [5:0] trigout_q;     // CTITRIGOUTSTATUS.TROUT

   //
   // Register write
   //

   wire wr_dphase = dphase_q & write_q;

   // CTICONTROL.GLBEN
   //

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       control_q <= 1'b0;
     else if (wr_dphase & sel_control)
       control_q <= HWDATA[0];

   // CTIAPPTRIG
   //

   wire [3:0] apptrig_nxt = ( {4{sel_appset}} & (apptrig_q |  HWDATA[3:0]) ) |
                            ( {4{sel_appclear}} & (apptrig_q & ~HWDATA[3:0]) );
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       apptrig_q <= 4'h0;
     else if (wr_dphase & (sel_appset | sel_appclear))
       apptrig_q <= apptrig_nxt;

   // CTIINEN0
   //

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       inen0_q <= 4'h0;
     else if (wr_dphase & sel_inen0)
       inen0_q <= HWDATA[3:0];

   // CTIOUTENn.OUTEN
   //

   genvar g_to;
   generate for (g_to = 0; g_to < 6; g_to = g_to + 1) begin: gen_outen
      always @(posedge HCLK or negedge CTIRESETn)
         if (~CTIRESETn)
            outen_q[g_to] <= 4'h0;
         else if (wr_dphase & sel_outen[g_to])
            outen_q[g_to] <= HWDATA[3:0];
   end endgenerate

   // CTIGATE.GATE
   //

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       gate_q <= 4'hF;
     else if (wr_dphase & sel_gate)
       gate_q <= HWDATA[3:0];

   // CTIITCTRL.IME
   //

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       itctrl_q <= 1'b0;
     else if (wr_dphase & sel_itctrl)
       itctrl_q <= HWDATA[0];

   // CTICLAIM{SET,CLR}.CLAIM
   //

   wire [3:0] claimtag_nxt =
                      ( {4{sel_claimset}} & (claimtag_q |  HWDATA[3:0]) ) |
                      ( {4{sel_claimclr}} & (claimtag_q & ~HWDATA[3:0]) );
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       claimtag_q <= 4'h0;
     else if (wr_dphase & (sel_claimset | sel_claimclr))
       claimtag_q <= claimtag_nxt;

   // -------------------------------------------------------------------------
   // Output channels
   // -------------------------------------------------------------------------

   // CTICHOUTSTATUS.CHOUT
   //

   // In normal operation, an output channel may be updated for:
   //  - a hardware event: input trigger mapped to that channel
   //  - a software event: APPTRIG or APPPULSE channel event

   // The only input trigger (0) is a HALTED pulse
   reg halted_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       halted_q <= 1'b0;
     else
       halted_q <= HALTED;

   wire       trigin0       = ~halted_q & HALTED;
   wire [3:0] trigin_ch     = {4{trigin0}} & inen0_q;
   wire [3:0] apppulse      = {4{(wr_dphase & sel_apppulse)}} & HWDATA[3:0];
   wire [3:0] app_ch        = apptrig_q | apppulse;
   wire       chout_en_nor  = ~itctrl_q & (control_q | (|chout_q));

   // CTIGATE.GATE prevents inside events from propagating to outside
   wire [3:0] chout_nxt_nor = {4{control_q}} & (gate_q & (trigin_ch | app_ch));

   // In integration mode, an output channel is directly controlled by software
   wire       chout_en_it   = itctrl_q & wr_dphase & sel_itchout;
   wire [3:0] chout_nxt_it  = HWDATA[3:0];

   // Overall output channel logic
   wire       chout_en      = chout_en_nor | chout_en_it;
   wire [3:0] chout_nxt     = chout_en_it ? chout_nxt_it : chout_nxt_nor;

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       chout_q <= 4'h0;
     else if (chout_en)
       chout_q <= chout_nxt;

   // -------------------------------------------------------------------------
   // Output triggers
   // -------------------------------------------------------------------------

   // CTITRIGOUTSTATUS.TROUT
   //

   // The implemented output triggers are mapped as follows:
   //
   // Programmers' model name     | RTL name       | Usage
   // ----------------------------------------------------------
   // CTITRIGOUTSTATUS.TROUT[  7] | trigout_q[  5] | DBGRESTART
   // CTITRIGOUTSTATUS.TROUT[  5] | trigout_q[  4] | TSTOP
   // CTITRIGOUTSTATUS.TROUT[  4] | trigout_q[  3] | TSTART
   // CTITRIGOUTSTATUS.TROUT[3:2] | trigout_q[2:1] | CTIIRQ[1:0]
   // CTITRIGOUTSTATUS.TROUT[  0] | trigout_q[  0] | EDBGRQ

   // In normal operation, an output trigger may be updated for:
   //  - a hardware event:
   //   . H1 input channel mapped to that trigger OR
   //   . H2 channel feedback (from input trigger) mapped to that trigger OR
   //   . H3 output trigger acknowledge
   //  - a software event:
   //   . S4 APPTRIG or APPPULSE channel event
   //   . S5 INTACK output trigger acknowledge

   // H1 and H2 affect all output triggers.
   // H3 affects TSTART and TSTOP (always auto-acknowledged) and DBGRESTART.
   // S4 affects all outputs triggers.
   // S5 affects EDBGRQ and CTIIRQ[1:0].

   // Register CTICHIN
   reg  [3:0] ctichin_q;
   always @(posedge HCLK)
     ctichin_q <= CTICHIN;

   // CTIGATE.GATE prevents outside channel events from propagating to inside
   wire [3:0] chin_gated = ctichin_q & gate_q;

   wire [3:0] ch_trigout = {4{control_q}} & (chin_gated | trigin_ch | app_ch);

   wire [5:0] trigout_set_nor   = { |(ch_trigout & outen_q[5]),
                                    |(ch_trigout & outen_q[4]),
                                    |(ch_trigout & outen_q[3]),
                                    |(ch_trigout & outen_q[2]),
                                    |(ch_trigout & outen_q[1]),
                                    |(ch_trigout & outen_q[0]) };

   wire [5:0] trigout_nxt_nor = { trigout_set_nor[5:3],
                                  trigout_set_nor[2:1] & {2{DBGEN}},
                                  trigout_set_nor[0] };

   wire       intack_edbgrq =    wr_dphase & sel_intack   & HWDATA[  0];
   wire [1:0] intack_ctiirq = {2{wr_dphase & sel_intack}} & HWDATA[3:2];

   wire       trigoutack_dbgrestart = HALTED ? ~DBGRESTARTED : trigout_q[5];

   wire       trigout_en_nor_edbgrq     = trigout_nxt_nor[  0] | intack_edbgrq;

   wire [1:0] trigout_en_nor_ctiirq     = trigout_nxt_nor[2:1] | intack_ctiirq;

   wire       trigout_en_nor_dbgrestart = trigout_nxt_nor[  5] |
                                          trigoutack_dbgrestart;

   wire [5:0] trigout_en_nor = {6{~itctrl_q}} & ({6{control_q}} | trigout_q) &
                               { trigout_en_nor_dbgrestart,
                                 1'b1,
                                 1'b1,
                                 trigout_en_nor_ctiirq,
                                 trigout_en_nor_edbgrq };

   // In integration mode, an output trigger is directly controlled by software
   wire       trigout_en_it  = itctrl_q & wr_dphase & sel_ittrigout;
   wire [5:0] trigout_nxt_it = { HWDATA[7], HWDATA[5:4],
                                (HWDATA[3:2] & {2{DBGEN}}), HWDATA[0] };

   // Overall output trigger logic
   wire [5:0] trigout_en = {6{trigout_en_it}} | trigout_en_nor;
   wire [5:0] trigout_nxt = trigout_en_it ? trigout_nxt_it : trigout_nxt_nor;

   generate for (g_to = 0; g_to < 6; g_to = g_to + 1) begin: gen_trigout
      always @(posedge HCLK or negedge CTIRESETn)
         if (~CTIRESETn)
            trigout_q[g_to] <= 1'b0;
         else if (trigout_en[g_to])
            trigout_q[g_to] <= trigout_nxt[g_to];
   end endgenerate


   // -------------------------------------------------------------------------
   // AHB-LITE SLAVE INTERFACE - Read data multiplexer
   // -------------------------------------------------------------------------

   wire [7:0] rdata_trigoutstatus = { trigout_q[5], 1'b0, trigout_q[4:1], 1'b0,
                                      trigout_q[0] };

   wire [7:0] rdata_authstatus    = { L_VAL_AUTHSTATUS_SNID, 1'b0,
                                      L_VAL_AUTHSTATUS_SID, 1'b0,
                                      L_VAL_AUTHSTATUS_NSNID, NIDEN,
                                      L_VAL_AUTHSTATUS_NSID,  DBGEN };

   wire [7:0] hrdata_8bits =
            ( {8{sel_control}}       & { {7{1'b0}}, control_q             } ) |
            ( {8{sel_appset}}        & {    4'h0,   apptrig_q             } ) |

            ( {8{sel_inen0}}         & {    4'h0,   inen0_q               } ) |
            ( {8{sel_outen[0]}}      & {    4'h0,   outen_q[0]            } ) |
            ( {8{sel_outen[1]}}      & {    4'h0,   outen_q[1]            } ) |
            ( {8{sel_outen[2]}}      & {    4'h0,   outen_q[2]            } ) |
            ( {8{sel_outen[3]}}      & {    4'h0,   outen_q[3]            } ) |
            ( {8{sel_outen[4]}}      & {    4'h0,   outen_q[4]            } ) |
            ( {8{sel_outen[5]}}      & {    4'h0,   outen_q[5]            } ) |

            ( {8{sel_triginstatus}}  & { {7{1'b0}}, trigin0               } ) |
            ( {8{sel_trigoutstatus}} &   rdata_trigoutstatus                ) |
            ( {8{sel_chinstatus}}    & {    4'h0,   ctichin_q             } ) |
            ( {8{sel_choutstatus}}   & {    4'h0,   chout_q               } ) |

            ( {8{sel_gate}}          & {    4'h0,   gate_q                } ) |

            ( {8{sel_itctrl}}        & { {7{1'b0}}, itctrl_q              } ) |
            ( {8{sel_ittrigoutack}}  & { trigoutack_dbgrestart, {7{1'b0}} } ) |
            ( {8{sel_itchin}}        & {    4'h0,   ctichin_q             } ) |
            ( {8{sel_ittrigin}}      & { {7{1'b0}}, trigin0               } ) |

            ( {8{sel_claimset}}      & { {4{1'b0}}, L_VAL_CLAIMSET        } ) |
            ( {8{sel_claimclr}}      & { {4{1'b0}}, claimtag_q            } ) |
            ( {8{sel_authstatus}}    &   rdata_authstatus                   ) |
            ( {8{sel_devicetype}}    &   L_VAL_DEVTYPE                      ) |

            ( {8{sel_peripheralid0}} &   L_VAL_PERIPHID0                    ) |
            ( {8{sel_peripheralid1}} &   L_VAL_PERIPHID1                    ) |
            ( {8{sel_peripheralid2}} &   L_VAL_PERIPHID2                    ) |
            ( {8{sel_peripheralid3}} & { ECOREVNUM,
                                         L_VAL_PERIPHID3_CUSTOM }           ) |
            ( {8{sel_peripheralid4}} &   L_VAL_PERIPHID4                    ) |
            ( {8{sel_componentid0}}  &   L_VAL_COMPONID0                    ) |
            ( {8{sel_componentid1}}  &   L_VAL_COMPONID1                    ) |
            ( {8{sel_componentid2}}  &   L_VAL_COMPONID2                    ) |
            ( {8{sel_componentid3}}  &   L_VAL_COMPONID3                    );

   wire [31:0] hrdata_32bits =
            ( {32{sel_devicearch}}   &   L_VAL_DEVARCH                      ) |
            ( {32{sel_deviceid}}     &   L_VAL_DEVID                        );


   // -------------------------------------------------------------------------
   // Output assignment
   // -------------------------------------------------------------------------

   // CTIGATE.GATE prevents CTI channel events from propagating outside
   assign CTICHOUT    = chout_q;

   // DBGEN prevents CTIIRQ from being asserted to the processor
   assign DBGRESTART  = trigout_q[5];
   assign TSTOP       = trigout_q[4];
   assign TSTART      = trigout_q[3];
   assign CTIIRQ[1:0] = trigout_q[2:1];
   assign EDBGRQ      = trigout_q[0];

   assign HRDATA      = { 24'h000000, hrdata_8bits } | hrdata_32bits;
   assign HREADYOUT   = 1'b1;
   assign HRESP       = 1'b0;


   // -------------------------------------------------------------------------
   // Unused signal assignment to facilitate linting
   // -------------------------------------------------------------------------

   wire [58:0] unused = { HWDATA[31:8], HWDATA[6], HMASTLOCK, HTRANS[0], HPROT,
                          HBURST, HSIZE, HADDR[31:12], HADDR[1:0] };


`ifdef ARM_ASSERT_ON

`include "std_ovl_defines.h"
   //--------------------------------------------------------------------------
   // OVL Assertions
   //--------------------------------------------------------------------------

   // register write data
   reg [31:0] ovl_hwdata_q;
   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_hwdata_q <= 32'h00000000;
     else if (HREADY)
       ovl_hwdata_q <= HWDATA[31:0];


   //--------------------------------------------------------------------------
   // Reading a non-readable or not implemented register returns 0
   //--------------------------------------------------------------------------
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("Reading a non-readable register returns 0"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE   &
                    (HADDR[11:2] !== L_ADDR_CONTROL)       &
                    (HADDR[11:2] !== L_ADDR_APPSET)        &
                    (HADDR[11:2] !== L_ADDR_INEN0)         &
                    (HADDR[11:2] !== L_ADDR_OUTEN0)        &
                    (HADDR[11:2] !== L_ADDR_OUTEN2)        &
                    (HADDR[11:2] !== L_ADDR_OUTEN3)        &
                    (HADDR[11:2] !== L_ADDR_OUTEN4)        &
                    (HADDR[11:2] !== L_ADDR_OUTEN5)        &
                    (HADDR[11:2] !== L_ADDR_OUTEN7)        &
                    (HADDR[11:2] !== L_ADDR_TRIGINSTATUS)  &
                    (HADDR[11:2] !== L_ADDR_TRIGOUTSTATUS) &
                    (HADDR[11:2] !== L_ADDR_CHINSTATUS)    &
                    (HADDR[11:2] !== L_ADDR_CHOUTSTATUS)   &
                    (HADDR[11:2] !== L_ADDR_GATE)          &
                    (HADDR[11:2] !== L_ADDR_ITTRIGOUTACK)  &
                    (HADDR[11:2] !== L_ADDR_ITCHIN)        &
                    (HADDR[11:2] !== L_ADDR_ITTRIGIN)      &
                    (HADDR[11:2] !== L_ADDR_ITCTRL)        &
                    (HADDR[11:2] !== L_ADDR_CLAIMSET)      &
                    (HADDR[11:2] !== L_ADDR_CLAIMCLR)      &
                    (HADDR[11:2] !== L_ADDR_AUTHSTATUS)    &
                    (HADDR[11:2] !== L_ADDR_DEVARCH)       &
                    (HADDR[11:2] !== L_ADDR_DEVID)         &
                    (HADDR[11:2] !== L_ADDR_DEVTYPE)       &
                    (HADDR[11:2] !== L_ADDR_PERIPHID4)     &
                    (HADDR[11:2] !== L_ADDR_PERIPHID0)     &
                    (HADDR[11:2] !== L_ADDR_PERIPHID1)     &
                    (HADDR[11:2] !== L_ADDR_PERIPHID2)     &
                    (HADDR[11:2] !== L_ADDR_PERIPHID3)     &
                    (HADDR[11:2] !== L_ADDR_COMPONID0)     &
                    (HADDR[11:2] !== L_ADDR_COMPONID1)     &
                    (HADDR[11:2] !== L_ADDR_COMPONID2)     &
                    (HADDR[11:2] !== L_ADDR_COMPONID3)),
      .test_expr    (HRDATA == 32'h00000000),
      .fire         ());

   //--------------------------------------------------------------------------
   // All registers remains unchanged if not written
   // (except for CTIAPPTRIG and INTACK)
   //--------------------------------------------------------------------------

   reg       ovl_control_q;
   reg [3:0] ovl_apptrig_q;
   reg [3:0] ovl_app_ch_q;
   reg [3:0] ovl_inen0_q;
   reg [3:0] ovl_outen_q[5:0];
   reg [3:0] ovl_gate_q;
   reg       ovl_itctrl_q;
   reg [3:0] ovl_claimtag_q;

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_control_q <= 1'b0;
     else
       ovl_control_q <= control_q;

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_app_ch_q <= 4'h0;
     else
       ovl_app_ch_q <= app_ch;

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_apptrig_q <= 4'h0;
     else
       ovl_apptrig_q <= apptrig_q;

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_gate_q <= 4'h0;
     else
       ovl_gate_q <= gate_q;

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_inen0_q <= 4'h0;
     else
       ovl_inen0_q <= inen0_q;

   generate for (g_to = 0; g_to < 6; g_to = g_to + 1) begin: gen_ovl_outen
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_outen_q[g_to] <= 4'h0;
     else
       ovl_outen_q[g_to] <= outen_q[g_to];
   end endgenerate

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_itctrl_q <= 1'b0;
     else
       ovl_itctrl_q <= itctrl_q;

   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_claimtag_q <= 4'h0;
     else
       ovl_claimtag_q <= claimtag_q;


   // Data phase
   reg ovl_control_write_dphase_q;
   reg ovl_intack_write_dphase_q;
   reg ovl_appset_write_dphase_q;
   reg ovl_appclear_write_dphase_q;
   reg ovl_apppulse_write_dphase_q;
   reg ovl_inen0_write_dphase_q;
   reg ovl_outen0_write_dphase_q;
   reg ovl_outen2_write_dphase_q;
   reg ovl_outen3_write_dphase_q;
   reg ovl_outen4_write_dphase_q;
   reg ovl_outen5_write_dphase_q;
   reg ovl_outen7_write_dphase_q;
   reg ovl_gate_write_dphase_q;
   reg ovl_claimset_write_dphase_q;
   reg ovl_claimclr_write_dphase_q;
   reg ovl_itctrl_write_dphase_q;

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_control_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_control_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                     (HADDR[11:2] == L_ADDR_CONTROL);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_intack_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_intack_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_INTACK);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_appset_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_appset_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_APPSET);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_appclear_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_appclear_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_APPCLEAR);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_apppulse_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_apppulse_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                      (HADDR[11:2] == L_ADDR_APPPULSE);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_inen0_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_inen0_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                   (HADDR[11:2] == L_ADDR_INEN0);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_outen0_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_outen0_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_OUTEN0);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_outen2_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_outen2_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_OUTEN2);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_outen3_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_outen3_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_OUTEN3);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_outen4_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_outen4_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_OUTEN4);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_outen5_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_outen5_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_OUTEN5);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_outen7_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_outen7_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                    (HADDR[11:2] == L_ADDR_OUTEN7);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_gate_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_gate_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                  (HADDR[11:2] == L_ADDR_GATE);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_claimset_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_claimset_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                      (HADDR[11:2] == L_ADDR_CLAIMSET);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_claimclr_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_claimclr_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                      (HADDR[11:2] == L_ADDR_CLAIMCLR);

   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_itctrl_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_itctrl_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                       (HADDR[11:2] == L_ADDR_ITCTRL);


   // registers remain unchanged if not written
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("register unchange"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_register_unchange
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~ovl_control_write_dphase_q   &
                     ~ovl_appset_write_dphase_q    &
                     ~ovl_appclear_write_dphase_q  &
                     ~ovl_inen0_write_dphase_q     &
                     ~ovl_outen0_write_dphase_q    &
                     ~ovl_outen2_write_dphase_q    &
                     ~ovl_outen3_write_dphase_q    &
                     ~ovl_outen4_write_dphase_q    &
                     ~ovl_outen5_write_dphase_q    &
                     ~ovl_outen7_write_dphase_q    &
                     ~ovl_gate_write_dphase_q      &
                     ~ovl_itctrl_write_dphase_q    &
                     ~ovl_claimset_write_dphase_q  &
                     ~ovl_claimclr_write_dphase_q),
      .test_expr    ((control_q   == ovl_control_q)   &
                     (apptrig_q   == ovl_apptrig_q)   &
                     (inen0_q     == ovl_inen0_q)     &
                     (outen_q[0]  == ovl_outen_q[0])  &
                     (outen_q[1]  == ovl_outen_q[1])  &
                     (outen_q[2]  == ovl_outen_q[2])  &
                     (outen_q[3]  == ovl_outen_q[3])  &
                     (outen_q[4]  == ovl_outen_q[4])  &
                     (outen_q[5]  == ovl_outen_q[5])  &
                     (gate_q      == ovl_gate_q)      &
                     (itctrl_q    == ovl_itctrl_q)    &
                     (claimtag_q  == ovl_claimtag_q)),
      .fire         ());

   // intack and apppulse is LOW when not written.
   ovl_implication
     #(.severity_level  (`OVL_FATAL),
       .property_type   (`OVL_ASSERT),
       .msg             ("intack and apppulse low"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))

   u_ovl_intack_low
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (~ovl_intack_write_dphase_q &
                        ~ovl_apppulse_write_dphase_q),
      .consequent_expr (~intack_edbgrq & !intack_ctiirq & !apppulse),
      .fire            ());

   //--------------------------------------------------------------------------
   // CTICONTROL
   //--------------------------------------------------------------------------

   // CTICONTROL read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CONTROL read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_control_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_CONTROL)),
      .test_expr    (HRDATA[0] == control_q),
      .fire         ());

   // CTICONTROL write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CONTROL write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_control_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_control_write_dphase_q),
      .test_expr    (control_q == ovl_hwdata_q[0]),
      .fire         ());

   // When CTICONTROL is LOW and integration mode is off,
   // all channel outputs and trigger outputs TSTART and TSTOP should be LOW.
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CONTROL function"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_control_function
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~control_q & ~itctrl_q),
      .test_expr    (!CTICHOUT & !TSTART & !TSTOP),
      .fire         ());


   //--------------------------------------------------------------------------
   // CTIINTACK
   //--------------------------------------------------------------------------

   // CTIINTACK write
   ovl_implication //intack is updated in the data phase.
     #(.severity_level          (`OVL_FATAL),
       .property_type           (`OVL_ASSERT),
       .msg                     ("INTACK write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_intack_write
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (ovl_intack_write_dphase_q),
      .consequent_expr ((intack_edbgrq == HWDATA[0]) &
                        (intack_ctiirq == HWDATA[3:2])),
      .fire            ());

   //--------------------------------------------------------------------------
   // CTIAPPTRIG
   //--------------------------------------------------------------------------

   // --------
   // CTIAPPSET
   // CTIAPPSET read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("APPSET read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_appset_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_APPSET)),
      .test_expr    (HRDATA[3:0] == apptrig_q),
      .fire         ());

   // CTIAPPSET sets the application trigger

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("APPSET"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_appset
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_appset_write_dphase_q),
      .test_expr    (apptrig_q == (ovl_hwdata_q[3:0] | ovl_apptrig_q)),
      .fire         ());


   // --------
   // CTIAPPCLEAR
   // CTIAPPCLEAR clear the application trigger

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("APPCLEAR"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_appclear
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_appclear_write_dphase_q),
      .test_expr    (apptrig_q == (~ovl_hwdata_q[3:0] & ovl_apptrig_q)),
      .fire         ());

   // --------
   // CTIAPPPULSE
   // CTIAPPPULSE sets a pulse

   ovl_implication // apppulse is updated in the data phase.
     #(.severity_level          (`OVL_FATAL),
       .property_type           (`OVL_ASSERT),
       .msg                     ("APPPULSE"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_apppulse
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (ovl_apppulse_write_dphase_q),
      .consequent_expr (apppulse == HWDATA[3:0]),
      .fire            ());

   //--------------------------------------------------------------------------
   // CTIINEN0
   //--------------------------------------------------------------------------

   // CTIINEN0 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("INEN0 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_inen0_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_INEN0)),
      .test_expr    (HRDATA[3:0] == inen0_q),
      .fire         ());

   // CTIINEN0 write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("INEN0 write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_inen0_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_inen0_write_dphase_q),
      .test_expr    (inen0_q == ovl_hwdata_q[3:0]),
      .fire         ());

   //--------------------------------------------------------------------------
   // CTIOUTEN0
   //--------------------------------------------------------------------------

   // CTIOUTEN0 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN0 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen0_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_OUTEN0)),
      .test_expr    (HRDATA[3:0] == outen_q[0]),
      .fire         ());

   // CTIOUTEN0 write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN0 write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen0_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_outen0_write_dphase_q),
      .test_expr    (outen_q[0] == ovl_hwdata_q[3:0]),
      .fire         ());

   //--------------------------------------------------------------------------
   // CTIOUTEN2
   //--------------------------------------------------------------------------

   // CTIOUTEN2 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN2 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen2_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_OUTEN2)),
      .test_expr    (HRDATA[3:0] == outen_q[1]),
      .fire         ());

   // CTIOUTEN2 write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN2 write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen2_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_outen2_write_dphase_q),
      .test_expr    (outen_q[1] == ovl_hwdata_q[3:0]),
      .fire         ());


   //--------------------------------------------------------------------------
   // CTIOUTEN3
   //--------------------------------------------------------------------------

   // CTIOUTEN3 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN3 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen3_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_OUTEN3)),
      .test_expr    (HRDATA[3:0] == outen_q[2]),
      .fire         ());

   // CTIOUTEN3 write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN3 write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen3_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_outen3_write_dphase_q),
      .test_expr    (outen_q[2] == ovl_hwdata_q[3:0]),
      .fire         ());


   //--------------------------------------------------------------------------
   // CTIOUTEN4
   //--------------------------------------------------------------------------

   // CTIOUTEN4 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN4 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen4_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_OUTEN4)),
      .test_expr    (HRDATA[3:0] == outen_q[3]),
      .fire         ());

   // CTIOUTEN4 write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN4 write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen4_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_outen4_write_dphase_q),
      .test_expr    (outen_q[3] == ovl_hwdata_q[3:0]),
      .fire         ());


   //--------------------------------------------------------------------------
   // CTIOUTEN5
   //--------------------------------------------------------------------------

   // CTIOUTEN5 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN5 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen5_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_OUTEN5)),
      .test_expr    (HRDATA[3:0] == outen_q[4]),
      .fire         ());

   // CTIOUTEN5 write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN5 write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen5_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_outen5_write_dphase_q),
      .test_expr    (outen_q[4] == ovl_hwdata_q[3:0]),
      .fire         ());


   //--------------------------------------------------------------------------
   // CTIOUTEN7
   //--------------------------------------------------------------------------

   // CTIOUTEN7 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN7 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen7_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_OUTEN7)),
      .test_expr    (HRDATA[3:0] == outen_q[5]),
      .fire         ());

   // CTIOUTEN7 write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("OUTEN7 write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_outen7_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_outen7_write_dphase_q),
      .test_expr    (outen_q[5] == ovl_hwdata_q[3:0]),
      .fire         ());

   //--------------------------------------------------------------------------
   // TRIGINSTATUS
   //--------------------------------------------------------------------------

   // TRIGINSTATUS read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("TRIGINSTATUS read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_triginstatus_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_TRIGINSTATUS)),
      .test_expr    (HRDATA[0] == trigin0),
      .fire         ());

   //--------------------------------------------------------------------------
   // TRIGOUTSTATUS
   //--------------------------------------------------------------------------

   // TRIGOUTSTATUS read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("TRIGOUTSTATUS read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_trigoutstatus_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_TRIGOUTSTATUS)),
      .test_expr    (HRDATA[7:0] == { trigout_q[5],   1'b0,
                                      trigout_q[4:1], 1'b0,
                                      trigout_q[0] }),
      .fire         ());

   //--------------------------------------------------------------------------
   // CHINSTATUS
   //--------------------------------------------------------------------------

   // CHINSTATUS read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CHINSTATUS read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chinstatus_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_CHINSTATUS)),
      .test_expr    (HRDATA[3:0] == ctichin_q),
      .fire         ());

   //--------------------------------------------------------------------------
   // CHOUTSTATUS
   //--------------------------------------------------------------------------

   // CHOUTSTATUS read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CHOUTSTATUS read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_choutstatus_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_CHOUTSTATUS)),
      .test_expr    (HRDATA[3:0] == chout_q),
      .fire         ());

   //--------------------------------------------------------------------------
   // CTIGATE
   //--------------------------------------------------------------------------

   // CTIGATE read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("GATE read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_gate_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_GATE)),
      .test_expr    (HRDATA[3:0] == gate_q),
      .fire         ());

   // CTIGATE write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("GATE write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_gate_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_gate_write_dphase_q),
      .test_expr    (gate_q == ovl_hwdata_q[3:0]),
      .fire         ());

   // When CTIGATE is LOW and integration mode is off,
   // all channel outputs and trigger outputs TSTART and TSTOP should be LOW.
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("GATE function"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_gate_function
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (!gate_q & ~itctrl_q),
      .test_expr    (!CTICHOUT),
      .fire         ());

   //--------------------------------------------------------------------------
   // Claim Tag
   //--------------------------------------------------------------------------

   // --------
   // CLAIMSET

   // CLAIMSET read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CLAIMSET read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_claimset_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_CLAIMSET)),
      .test_expr    (HRDATA[3:0] == L_VAL_CLAIMSET),
      .fire         ());

   // CLAIMSET sets the claim tag

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CLAIMTAG"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_claimset
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_claimset_write_dphase_q),
      .test_expr    (claimtag_q == (ovl_hwdata_q[3:0] | ovl_claimtag_q)),
      .fire         ());

   // CLAIMCLR

   // CLAIMCLR read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CLAIMCLR read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_claimclr_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_CLAIMCLR)),
      .test_expr    (HRDATA[3:0] == claimtag_q),
      .fire         ());


   // CLAIMCLR clear the claim tag

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("CLAIMCLR"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_claimclr
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_claimclr_write_dphase_q),
      .test_expr    (claimtag_q == (~ovl_hwdata_q[3:0] & ovl_claimtag_q)),
      .fire         ());


   //--------------------------------------------------------------------------
   // AUTHSTATUS
   //--------------------------------------------------------------------------
   // AUTHSTATUS read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("AUTHSTATUS read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_authstatus_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_AUTHSTATUS)),
      .test_expr    (HRDATA[7:0] == { 1'b0, L_VAL_AUTHSTATUS_SNID,
                                      1'b0, L_VAL_AUTHSTATUS_SID,
                                      L_VAL_AUTHSTATUS_NSNID, NIDEN,
                                      L_VAL_AUTHSTATUS_NSID, DBGEN }),
      .fire         ());

   //--------------------------------------------------------------------------
   // DEVARCH
   //--------------------------------------------------------------------------
   // DEVARCH read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("DEVARCH read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_devarch_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2]  == L_ADDR_DEVARCH)),
      .test_expr    (HRDATA[31:0] == L_VAL_DEVARCH),
      .fire         ());

   //--------------------------------------------------------------------------
   // DEVID
   //--------------------------------------------------------------------------
   // DEVID read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("DEVID read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_devid_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2]  == L_ADDR_DEVID)),
      .test_expr    (HRDATA[31:0] == L_VAL_DEVID),
      .fire         ());

   //--------------------------------------------------------------------------
   // DEVTYPE
   //--------------------------------------------------------------------------
   // DEVTYPE read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("DEVTYPE read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_devtype_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_DEVTYPE)),
      .test_expr    (HRDATA[7:0] == L_VAL_DEVTYPE),
      .fire         ());

   //--------------------------------------------------------------------------
   // PERIPHID4
   //--------------------------------------------------------------------------
   // PERIPHID4 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("PERIPHID4 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_periphid4_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_PERIPHID4)),
      .test_expr    (HRDATA[7:0] == L_VAL_PERIPHID4),
      .fire         ());

   //--------------------------------------------------------------------------
   // PERIPHID0
   //--------------------------------------------------------------------------
   // PERIPHID0 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("PERIPHID0 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_periphid0_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_PERIPHID0)),
      .test_expr    (HRDATA[7:0] == L_VAL_PERIPHID0),
      .fire         ());

   //--------------------------------------------------------------------------
   // PERIPHID1
   //--------------------------------------------------------------------------
   // PERIPHID1 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("PERIPHID1 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_periphid1_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_PERIPHID1)),
      .test_expr    (HRDATA[7:0] == L_VAL_PERIPHID1),
      .fire         ());

   //--------------------------------------------------------------------------
   // PERIPHID2
   //--------------------------------------------------------------------------
   // PERIPHID2 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("PERIPHID2 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_periphid2_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_PERIPHID2)),
      .test_expr    (HRDATA[7:0] == L_VAL_PERIPHID2),
      .fire         ());

   //--------------------------------------------------------------------------
   // PERIPHID3
   //--------------------------------------------------------------------------
   // PERIPHID3 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("PERIPHID3 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_periphid3_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_PERIPHID3)),
      .test_expr    (HRDATA[7:0] == { ECOREVNUM,
                                      L_VAL_PERIPHID3_CUSTOM }),
      .fire         ());

   //--------------------------------------------------------------------------
   // COMPONID0
   //--------------------------------------------------------------------------
   // COMPONID0 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("COMPONID0 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_componid0_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_COMPONID0)),
      .test_expr    (HRDATA[7:0] == L_VAL_COMPONID0),
      .fire         ());

   //--------------------------------------------------------------------------
   // COMPONID1
   //--------------------------------------------------------------------------
   // COMPONID1 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("COMPONID1 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_componid1_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_COMPONID1)),
      .test_expr    (HRDATA[7:0] == L_VAL_COMPONID1),
      .fire         ());

   //--------------------------------------------------------------------------
   // COMPONID2
   //--------------------------------------------------------------------------
   // COMPONID2 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("COMPONID2 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_componid2_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_COMPONID2)),
      .test_expr    (HRDATA[7:0] == L_VAL_COMPONID2),
      .fire         ());

   //--------------------------------------------------------------------------
   // COMPONID3
   //--------------------------------------------------------------------------
   // COMPONID3 read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("COMPONID3 read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_componid3_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_COMPONID3)),
      .test_expr    (HRDATA[7:0] == L_VAL_COMPONID3),
      .fire         ());


   //--------------------------------------------------------------------------
   // Trigin is a pulsed HALTED signal
   //--------------------------------------------------------------------------
   // trigin remains LOW as long as HALTED signal is LOW
   ovl_implication
     #(.severity_level          (`OVL_FATAL),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigin remains LOW when HALTED is LOW"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_trigin_low
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (~HALTED),
      .consequent_expr (~trigin0),
      .fire            ());

   // when HALTED is LOW, in the next cycle trigin should be the same as HALTED
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigin is a pulsed HALTED signal"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_trigin_pulse
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~HALTED),
      .test_expr    (trigin0 == HALTED),
      .fire         ());

   // trigin is only HIGH for one cycle
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigin is a pulsed HALTED signal"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_trigin_pulse_drop
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (trigin0),
      .test_expr    (~trigin0),
      .fire         ());


   //--------------------------------------------------------------------------
   // Trigger input -> Channel output
   //--------------------------------------------------------------------------
   // The channel output is HIGH when either the mapped trigger input
   // or APPTRIG or APPPULSE is high.
   reg ovl_trigin_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_trigin_q <= 1'b0;
     else
       ovl_trigin_q <= trigin0;

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigger input->channel output"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_trigin_chout
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q),
      .test_expr    (CTICHOUT == ({4{ovl_control_q}} &
                    { (ovl_trigin_q & ovl_inen0_q[3] | ovl_app_ch_q[3])
                       & ovl_gate_q[3],
                      (ovl_trigin_q & ovl_inen0_q[2] | ovl_app_ch_q[2])
                       & ovl_gate_q[2],
                      (ovl_trigin_q & ovl_inen0_q[1] | ovl_app_ch_q[1])
                       & ovl_gate_q[1],
                      (ovl_trigin_q & ovl_inen0_q[0] | ovl_app_ch_q[0])
                       & ovl_gate_q[0] })),
      .fire         ());

   //--------------------------------------------------------------------------
   // Channel input -> Trigger output
   //--------------------------------------------------------------------------

   // --------
   // EDBGRQ

   // channel input->trigout output before flop[0]
   // When CTICONTROL is HIGH, the trigger output before flop
   // is HIGH when either the gated mapped channel input or APPTRIG or APPPULSE
   // or feedback from trigger input is HIGH
   ovl_implication
     #(.severity_level  (`OVL_FATAL),
       .property_type   (`OVL_ASSERT),
       .msg             ("channel input->trigout output before flop[0]"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))

   u_ovl_chin_trigout0
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (~itctrl_q),
      .consequent_expr (trigout_nxt_nor[0] ==
                       (((ctichin_q[0] & gate_q[0]) | app_ch[0] | trigin_ch[0])
                        & control_q & outen_q[0][0]) |
                       (((ctichin_q[1] & gate_q[1]) | app_ch[1] | trigin_ch[1])
                        & control_q& outen_q[0][1]) |
                       (((ctichin_q[2] & gate_q[2]) | app_ch[2] | trigin_ch[2])
                        & control_q& outen_q[0][2]) |
                       (((ctichin_q[3] & gate_q[3]) | app_ch[3] | trigin_ch[3])
                        & control_q& outen_q[0][3]) ),
      .fire            ());

   // trigout output before flop[0]->trigout output[0]
   // When trigger output before flop is HIGH, trigger output must be HIGH
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigout output[0] high"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chin_trigout0_high
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & trigout_nxt_nor[0]),
      .test_expr    (EDBGRQ),
      .fire         ());

   // When trigger output before flop is LOW and INTACK is HIGH, trigger
   // output must be LOW.
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("INTACK ACK for trigger output[0]"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   ovl_chin_trigout0_ack
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[0] & intack_edbgrq),
      .test_expr    (~EDBGRQ),
      .fire         ());

   // When trigger output remains unchanged when
   // both INTACK and trigger output before flop are LOW
   reg ovl_edbgrq_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_edbgrq_q <= 1'b0;
     else
       ovl_edbgrq_q <= EDBGRQ;

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigger output[0] remains"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   ovl_chin_trigout0_remain
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[0] & ~intack_edbgrq),
      .test_expr    (EDBGRQ == ovl_edbgrq_q),
      .fire         ());


   // --------
   // CTIIRQ
   reg [1:0] ovl_ctiirq_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_ctiirq_q <= 2'b00;
     else
       ovl_ctiirq_q <= CTIIRQ;

   reg ovl_dbgen_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_dbgen_q <= 1'b0;
     else
       ovl_dbgen_q <= DBGEN;

   // channel input->trigout output before flop[1]
   // When CTICONTROL is HIGH, the trigger output before flop
   // is HIGH when either the gated mapped channel input or APPTRIG or APPPULSE
   // or feedback from trigger input is HIGH
   ovl_implication
     #(.severity_level  (`OVL_FATAL),
       .property_type   (`OVL_ASSERT),
       .msg             ("channel input->trigout output before flop[1]"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))

   u_ovl_chin_trigout1
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (~itctrl_q),
      .consequent_expr (trigout_nxt_nor[1] ==
                       (((ctichin_q[0] & gate_q[0]) | app_ch[0] | trigin_ch[0])
                        & control_q & DBGEN & outen_q[1][0]) |
                       (((ctichin_q[1] & gate_q[1]) | app_ch[1] | trigin_ch[1])
                        & control_q & DBGEN & outen_q[1][1]) |
                       (((ctichin_q[2] & gate_q[2]) | app_ch[2] | trigin_ch[2])
                        & control_q & DBGEN & outen_q[1][2]) |
                       (((ctichin_q[3] & gate_q[3]) | app_ch[3] | trigin_ch[3])
                        & control_q & DBGEN & outen_q[1][3]) ),
      .fire            ());

   // When trigger output before flop is HIGH, trigger output must be HIGH
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigout output[1] high"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chin_trigout1_high
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & trigout_nxt_nor[1]),
      .test_expr    (CTIIRQ[0]),
      .fire         ());

   // When trigger output before flop is LOW and INTACK is HIGH, trigger
   // output must be LOW.
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("INTACK ACK for trigger output[1]"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   ovl_chin_trigout1_ack
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[1] & intack_ctiirq[0]),
      .test_expr    (~CTIIRQ[0]),
      .fire         ());

   // When trigger output remains unchanged when
   // both INTACK and trigger output before flop are LOW
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigger output[1] remains"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   ovl_chin_trigout1_remain
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[1] & ~intack_ctiirq[0]),
      .test_expr    (CTIIRQ[0] == ovl_ctiirq_q[0]),
      .fire         ());

   // channel input->trigout output before flop[2]
   // When CTICONTROL is HIGH, the trigger output before flop
   // is HIGH when either the gated mapped channel input or APPTRIG or APPPULSE
   // or feedback from trigger input is HIGH
   ovl_implication
     #(.severity_level  (`OVL_FATAL),
       .property_type   (`OVL_ASSERT),
       .msg             ("channel input->trigout output before flop[2]"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))

   u_ovl_chin_trigout2
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (control_q & ~itctrl_q),
      .consequent_expr (trigout_nxt_nor[2] ==
                       (((ctichin_q[0] & gate_q[0]) | app_ch[0] | trigin_ch[0])
                        & control_q & DBGEN & outen_q[2][0]) |
                       (((ctichin_q[1] & gate_q[1]) | app_ch[1] | trigin_ch[1])
                        & control_q & DBGEN & outen_q[2][1]) |
                       (((ctichin_q[2] & gate_q[2]) | app_ch[2] | trigin_ch[2])
                        & control_q & DBGEN & outen_q[2][2]) |
                       (((ctichin_q[3] & gate_q[3]) | app_ch[3] | trigin_ch[3])
                        & control_q & DBGEN & outen_q[2][3]) ),
      .fire            ());

   // When trigger output before flop is HIGH, trigger output must be HIGH.
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigout output[2] high"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chin_trigout2_high
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & trigout_nxt_nor[2]),
      .test_expr    (CTIIRQ[1]),
      .fire         ());

   // When trigger output before flop is LOW and INTACK is HIGH, trigger output
   // must be LOW.
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("INTACK ACK for trigger output[2]"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   ovl_chin_trigout2_ack
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[2] & intack_ctiirq[1]),
      .test_expr    (~CTIIRQ[1]),
      .fire         ());

   // When trigger output remains unchanged when
   // both INTACK and trigger output before flop are LOW
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigger output[2] remains"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   ovl_chin_trigout2_remain
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[2] & ~intack_ctiirq[1]),
      .test_expr    (CTIIRQ[1] == ovl_ctiirq_q[1]),
      .fire         ());

   // --------
   // TSTART
   // TSTART is HIGH when either the gated mapped channel input or
   // APPTRIG or APPPULSE or feedback from trigger input is HIGH

   reg [3:0] ovl_chin_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_chin_q <= 4'h0;
     else
       ovl_chin_q <= ctichin_q;

   reg [3:0] ovl_chout_inen_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_chout_inen_q <= 4'h0;
     else
       ovl_chout_inen_q <= trigin_ch;

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("channel input->trigger output[3]"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chin_trigout3
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q),
      .test_expr    (TSTART == (ovl_control_q &
                    ((((ovl_chin_q[0] & ovl_gate_q[0]) | ovl_app_ch_q[0] |
                       ovl_chout_inen_q[0]) & ovl_outen_q[3][0])          |
                     (((ovl_chin_q[1] & ovl_gate_q[1]) | ovl_app_ch_q[1] |
                       ovl_chout_inen_q[1]) & ovl_outen_q[3][1])          |
                     (((ovl_chin_q[2] & ovl_gate_q[2]) | ovl_app_ch_q[2] |
                       ovl_chout_inen_q[2]) & ovl_outen_q[3][2])          |
                     (((ovl_chin_q[3] & ovl_gate_q[3]) | ovl_app_ch_q[3] |
                       ovl_chout_inen_q[3]) & ovl_outen_q[3][3])))),
      .fire         ());


   // --------
   // TSTOP
   // TSTOP is HIGH when either the gated mapped channel input
   // or APPTRIG or APPPULSE
   // or feedback from trigger input is HIGH
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("channel input->trigger output[4]"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chin_trigout4
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q),
      .test_expr    (TSTOP == (ovl_control_q &
                    ((((ovl_chin_q[0] & ovl_gate_q[0]) | ovl_app_ch_q[0] |
                       ovl_chout_inen_q[0]) & ovl_outen_q[4][0])          |
                     (((ovl_chin_q[1] & ovl_gate_q[1]) | ovl_app_ch_q[1] |
                       ovl_chout_inen_q[1]) & ovl_outen_q[4][1])          |
                     (((ovl_chin_q[2] & ovl_gate_q[2]) | ovl_app_ch_q[2] |
                       ovl_chout_inen_q[2]) & ovl_outen_q[4][2])          |
                     (((ovl_chin_q[3] & ovl_gate_q[3]) | ovl_app_ch_q[3] |
                       ovl_chout_inen_q[3]) & ovl_outen_q[4][3])))),
      .fire         ());


   // --------
   // DGBRESTART

   // channel input->trigout output before flop[5]
   // When CTICONTROL is HIGH, the trigger output before flop
   // is HIGH when either the gated mapped channel input  or application
   // trigger or feedback from trigger input is HIGH
   ovl_implication
     #(.severity_level  (`OVL_FATAL),
       .property_type   (`OVL_ASSERT),
       .msg             ("channel input->trigout output before flop[5]"),
       .coverage_level  (`OVL_COVER_DEFAULT),
       .clock_edge      (`OVL_POSEDGE),
       .reset_polarity  (`OVL_ACTIVE_LOW),
       .gating_type     (`OVL_GATE_NONE))

   u_ovl_chin_trigout5
     (.clock           (HCLK),
      .reset           (CTIRESETn),
      .enable          (1'b1),
      .antecedent_expr (~itctrl_q),
      .consequent_expr (trigout_nxt_nor[5] ==
                       (((ctichin_q[0] & gate_q[0]) | app_ch[0] | trigin_ch[0])
                        & control_q & outen_q[5][0]) |
                       (((ctichin_q[1] & gate_q[1]) | app_ch[1] | trigin_ch[1])
                        & control_q & outen_q[5][1]) |
                       (((ctichin_q[2] & gate_q[2]) | app_ch[2] | trigin_ch[2])
                        & control_q & outen_q[5][2]) |
                       (((ctichin_q[3] & gate_q[3]) | app_ch[3] | trigin_ch[3])
                        & control_q & outen_q[5][3]) ),
      .fire            ());

   // trigout output before flop[5]->trigout output[5]
   // When trigger output before flop is HIGH, trigger output must be HIGH
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigout output[5] high"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chin_trigout5_high
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & trigout_nxt_nor[5]),
      .test_expr    (DBGRESTART),
      .fire         ());

   // trigout output before flop[5]->trigout output[5]
   // When trigger output before flop is LOW and ACK is HIGH,
   // trigger output must be LOW.
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ACK for trigger output[5]"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_chin_trigout5_ack
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[5] &
                     trigoutack_dbgrestart),
      .test_expr    (~DBGRESTART),
      .fire         ());

   // When trigger output remains unchanged when
   //  both ACK and trigger output before flop are LOW
   reg ovl_dbgrestart_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_dbgrestart_q <= 1'b0;
     else
       ovl_dbgrestart_q <= DBGRESTART;

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("trigger output[5] remains"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   ovl_chin_trigout5_remain
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~trigout_nxt_nor[5] &
                     ~trigoutack_dbgrestart),
      .test_expr    (DBGRESTART == ovl_dbgrestart_q),
      .fire         ());

   // --------
   // DBGRESTART/DBGRESTARTED 4-phase handshake

   // phase 1-2, DBGRESTART remains high when no ACK received
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("DBGRESTART/DBGRESTARTED handshake 1_2"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_dbgrestart_hs_1_2
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & HALTED & DBGRESTART
                     & DBGRESTARTED),
      .test_expr    (DBGRESTART),
      .fire         ());

   //phase 3-4, DBGRESTART remains low after ACK is received
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("DBGRESTART/DBGRESTARTED handshake 3_4"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_dbgrestart_hs_3_4
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (~itctrl_q & ~DBGRESTART & ~DBGRESTARTED),
      .test_expr    (~DBGRESTART),
      .fire         ());


   //--------------------------------------------------------------------------
   // Integration mode
   //--------------------------------------------------------------------------

   //--------------------------------------------------------------------------
   // ITCTRL
   //--------------------------------------------------------------------------

   // ITCTRL read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITCTRL read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_itctrl_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_ITCTRL)),
      .test_expr    (HRDATA[0] == itctrl_q),
      .fire         ());

   // ITCTRL write

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITCTRL write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_itctrl_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_itctrl_write_dphase_q),
      .test_expr    (itctrl_q == ovl_hwdata_q[0]),
      .fire         ());

   //--------------------------------------------------------------------------
   // ITTRIGOUTACK
   //--------------------------------------------------------------------------

   // ITTRIGOUTACK read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITTRIGOUTACK read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_ittrigoutack_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_ITTRIGOUTACK)),
      .test_expr    (HRDATA[7] == trigoutack_dbgrestart),
      .fire         ());

   //--------------------------------------------------------------------------
   // ITCHIN
   //--------------------------------------------------------------------------

   // ITCHIN read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITCHIN read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_itchin_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_ITCHIN)),
      .test_expr    (HRDATA[3:0] == ctichin_q),
      .fire         ());

   //--------------------------------------------------------------------------
   // ITTRIGIN
   //--------------------------------------------------------------------------

   // ITTRIGIN read
   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITTRIGIN read"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_ittrigin_read
     (.clock        (HCLK),
      .reset        (HRESETn),
      .enable       (1'b1),
      .start_event  (HSEL & HTRANS[1] & HREADY & ~HWRITE &
                    (HADDR[11:2] == L_ADDR_ITTRIGIN)),
      .test_expr    (HRDATA[0] == trigin0),
      .fire         ());


   //--------------------------------------------------------------------------
   // ITCHOUT
   //--------------------------------------------------------------------------

   // ITCHOUT write
   reg ovl_itchout_write_dphase_q;
   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_itchout_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_itchout_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                     (HADDR[11:2] == L_ADDR_ITCHOUT);

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITCHOUT write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_itchout_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_itchout_write_dphase_q & itctrl_q),
      .test_expr    (CTICHOUT == ovl_hwdata_q[3:0]),
      .fire         ());


   //--------------------------------------------------------------------------
   // ITTRIGOUT
   //--------------------------------------------------------------------------

   // ITTRIGOUT write
   reg ovl_ittrigout_write_dphase_q;
   always @(posedge HCLK or negedge HRESETn)
     if (~HRESETn)
       ovl_ittrigout_write_dphase_q <= 1'b0;
     else if (HREADY)
       ovl_ittrigout_write_dphase_q <= HSEL & HTRANS[1] & HWRITE &
                                       (HADDR[11:2] == L_ADDR_ITTRIGOUT);

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITTRIGOUT write"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_ittrigout_write
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (ovl_ittrigout_write_dphase_q & itctrl_q),
      .test_expr    ((EDBGRQ     ==  ovl_hwdata_q[0])                       &
                     (CTIIRQ     == (ovl_hwdata_q[3:2] & {2{ovl_dbgen_q}})) &
                     (TSTART     ==  ovl_hwdata_q[4])                       &
                     (TSTOP      ==  ovl_hwdata_q[5])                       &
                     (DBGRESTART ==  ovl_hwdata_q[7])),
      .fire         ());

   //--------------------------------------------------------------------------
   // ITCHOUT and ITTRIGOUT do not change when device is locked
   // or they are not written
   //--------------------------------------------------------------------------

   reg [3:0] ovl_itchout_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_itchout_q <= 4'h0;
     else
       ovl_itchout_q <= CTICHOUT;

   reg [5:0] ovl_ittrigout_q;
   always @(posedge HCLK or negedge CTIRESETn)
     if (~CTIRESETn)
       ovl_ittrigout_q <= 4'h0;
     else
       ovl_ittrigout_q <= trigout_q;

   ovl_next
     #(.severity_level          (`OVL_FATAL),
       .num_cks                 (1),
       .check_overlapping       (1),
       .check_missing_start     (0),
       .property_type           (`OVL_ASSERT),
       .msg                     ("ITCHOUT and ITTRIGOUT remain"),
       .coverage_level          (`OVL_COVER_DEFAULT),
       .clock_edge              (`OVL_POSEDGE),
       .reset_polarity          (`OVL_ACTIVE_LOW),
       .gating_type             (`OVL_GATE_NONE))

   u_ovl_itchout_ittrigout_remain
     (.clock        (HCLK),
      .reset        (CTIRESETn),
      .enable       (1'b1),
      .start_event  (itctrl_q & ~ovl_itchout_write_dphase_q &
                     ~ovl_ittrigout_write_dphase_q),
      .test_expr    ((CTICHOUT   == ovl_itchout_q) &
                     (trigout_q  == ovl_ittrigout_q)),
      .fire         ());

`endif

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
