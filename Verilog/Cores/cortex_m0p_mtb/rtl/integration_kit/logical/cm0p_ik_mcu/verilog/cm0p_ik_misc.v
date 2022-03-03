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
//      SVN Information
//
//      Checked In          : $Date: 2012-08-31 12:34:14 +0100 (Fri, 31 Aug 2012) $
//
//      Revision            : $Revision: 220755 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//     Miscellaneous Logic Block
//-----------------------------------------------------------------------------
//
// This block is used to facilitate testing in the Cortex-M0+ Integration Kit
// o    Delays loopout_gpio before returning as loopin_gpio
// o    Delays rxev_gpio before sending to core as RXEV
// o    Delays RXEV before sending to gpio input as delayed_rxev
// o    Delays nmi_gpio before sending to core as NMI
// o    Delays irq_gpio before sending to core as IRQ
// o    Sticky register indicating presence of I/O Port
//-----------------------------------------------------------------------------

module cm0p_ik_misc
  (input  wire        fclk,
   input  wire        hresetn,
   input  wire        iotrans,
   input  wire        iop_sticky_clr,
   input  wire        loopout_gpio,
   input  wire        rxev_gpio,
   input  wire        nmi_gpio,
   input  wire [30:0] irq_gpio,
   output wire [30:0] irq,
   output wire        nmi,
   output wire        loopin_gpio,
   output reg         iop_sticky,
   output wire        rxev,
   output wire        delayed_rxev);

//-----------------------------------------------------------------------------
// Delays on loopin_gpio
//-----------------------------------------------------------------------------

  cm0p_ik_misc_delay u_dly_loopin_gpio (.fclk(fclk), .hresetn(hresetn), .i(loopout_gpio), .o(loopin_gpio));


//-----------------------------------------------------------------------------
// Delays on rxev_gpio & rxev
//-----------------------------------------------------------------------------

  cm0p_ik_misc_delay u_dly_rxev_gpio (.fclk(fclk), .hresetn(hresetn), .i(rxev_gpio), .o(rxev));
  cm0p_ik_misc_delay u_dly_rxev      (.fclk(fclk), .hresetn(hresetn), .i(rxev),      .o(delayed_rxev));


//-----------------------------------------------------------------------------
// Delays on nmi
//-----------------------------------------------------------------------------

  cm0p_ik_misc_delay u_dly_nmi (.fclk(fclk), .hresetn(hresetn), .i(nmi_gpio), .o(nmi));


//-----------------------------------------------------------------------------
// Delays on irqs
//-----------------------------------------------------------------------------

  cm0p_ik_misc_delay u_dly_irq00 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 0]), .o(irq[ 0]));
  cm0p_ik_misc_delay u_dly_irq01 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 1]), .o(irq[ 1]));
  cm0p_ik_misc_delay u_dly_irq02 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 2]), .o(irq[ 2]));
  cm0p_ik_misc_delay u_dly_irq03 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 3]), .o(irq[ 3]));
  cm0p_ik_misc_delay u_dly_irq04 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 4]), .o(irq[ 4]));
  cm0p_ik_misc_delay u_dly_irq05 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 5]), .o(irq[ 5]));
  cm0p_ik_misc_delay u_dly_irq06 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 6]), .o(irq[ 6]));
  cm0p_ik_misc_delay u_dly_irq07 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 7]), .o(irq[ 7]));
  cm0p_ik_misc_delay u_dly_irq08 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 8]), .o(irq[ 8]));
  cm0p_ik_misc_delay u_dly_irq09 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[ 9]), .o(irq[ 9]));
  cm0p_ik_misc_delay u_dly_irq10 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[10]), .o(irq[10]));
  cm0p_ik_misc_delay u_dly_irq11 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[11]), .o(irq[11]));
  cm0p_ik_misc_delay u_dly_irq12 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[12]), .o(irq[12]));
  cm0p_ik_misc_delay u_dly_irq13 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[13]), .o(irq[13]));
  cm0p_ik_misc_delay u_dly_irq14 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[14]), .o(irq[14]));
  cm0p_ik_misc_delay u_dly_irq15 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[15]), .o(irq[15]));
  cm0p_ik_misc_delay u_dly_irq16 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[16]), .o(irq[16]));
  cm0p_ik_misc_delay u_dly_irq17 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[17]), .o(irq[17]));
  cm0p_ik_misc_delay u_dly_irq18 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[18]), .o(irq[18]));
  cm0p_ik_misc_delay u_dly_irq19 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[19]), .o(irq[19]));
  cm0p_ik_misc_delay u_dly_irq20 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[20]), .o(irq[20]));
  cm0p_ik_misc_delay u_dly_irq21 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[21]), .o(irq[21]));
  cm0p_ik_misc_delay u_dly_irq22 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[22]), .o(irq[22]));
  cm0p_ik_misc_delay u_dly_irq23 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[23]), .o(irq[23]));
  cm0p_ik_misc_delay u_dly_irq24 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[24]), .o(irq[24]));
  cm0p_ik_misc_delay u_dly_irq25 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[25]), .o(irq[25]));
  cm0p_ik_misc_delay u_dly_irq26 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[26]), .o(irq[26]));
  cm0p_ik_misc_delay u_dly_irq27 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[27]), .o(irq[27]));
  cm0p_ik_misc_delay u_dly_irq28 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[28]), .o(irq[28]));
  cm0p_ik_misc_delay u_dly_irq29 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[29]), .o(irq[29]));
  cm0p_ik_misc_delay u_dly_irq30 (.fclk(fclk), .hresetn(hresetn), .i(irq_gpio[30]), .o(irq[30]));

//-----------------------------------------------------------------------------
// Sticky register set on IOTRANS
//-----------------------------------------------------------------------------
  always @(posedge fclk or negedge hresetn)
    if (!hresetn)
      iop_sticky <= 1'b0;
    else if (~iop_sticky | iop_sticky_clr)
      iop_sticky <= iotrans & ~iop_sticky_clr;

endmodule
