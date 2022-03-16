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
//   Checked In : $Date: 2012-01-05 16:44:14 +0000 (Thu, 05 Jan 2012) $
//   Revision   : $Revision: 196799 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ CORE CLOCK GATE INTERCONNECT LEVEL
//-----------------------------------------------------------------------------

module cm0p_top_clk
  #(parameter CBAW = 0,
    parameter ACG  = 1)
   (input  wire hclk,            // Externally gated AHB clock input

    output wire rclk0,           // R0-to-R4 gated clock output
    output wire rclk1,           // R5-to-r14 gated clock output
    output wire pclk,            // PPB space gated clock output

    input  wire DFTSE,           // Clock gate bypass for scan test

    input  wire cpu_rclk0_en_i,  // R0-to-R4 clock enable term
    input  wire cpu_rclk1_en_i,  // R5-to-R14 clock enable term
    input  wire msl_pclk_en_i);  // PPB space clock enable term

   // -------------------------------------------------------------------------
   // NOTE:
   // -------------------------------------------------------------------------
   // The architectural clock gating implemented in Cortex-M0+ is not necessary
   // for correct functionality; all registers which gated clocks arrive at
   // have separate enable terms to ensure correct operation. It is therefore
   // permissible for each of the clock gate modules below to simply assign
   // CLKOUT from CLKIN irrespective of the ENABLE and DFTSE terms.
   // -------------------------------------------------------------------------

   wire        cfg_acg;

   generate
      if(CBAW == 0) begin : gen_cbaw
         assign cfg_acg = (ACG != 0);
      end
   endgenerate

   // -------------------------------------------------------------------------
   // Instantiate clock gate cells if required
   // -------------------------------------------------------------------------

   wire         rclk0_gated, rclk1_gated, pclk_gated;

   generate
      if((CBAW != 0) || (ACG != 0)) begin : gen_acg_0a

         // --------
         // Lower half register file clock gate cell instantiation.

         cm0p_acg u_rclk0 (.CLKIN  (hclk),
                           .ENABLE (cpu_rclk0_en_i),
                           .DFTSE  (DFTSE),
                           .CLKOUT (rclk0_gated));

         // --------
         // Upper half register file clock gate cell instantiation.

         cm0p_acg u_rclk1 (.CLKIN  (hclk),
                           .ENABLE (cpu_rclk1_en_i),
                           .DFTSE  (DFTSE),
                           .CLKOUT (rclk1_gated));

         // --------
         // Private peripheral space register write clock gate cell.

         cm0p_acg u_pclk (.CLKIN  (hclk),
                          .ENABLE (msl_pclk_en_i),
                          .DFTSE  (DFTSE),
                          .CLKOUT (pclk_gated));

      end else begin : gen_acg_0b

         wire [3:0] unused = { DFTSE, cpu_rclk0_en_i, cpu_rclk1_en_i,
                               msl_pclk_en_i };

         assign { rclk0_gated, rclk1_gated, pclk_gated } = 3'b0;

      end
   endgenerate

   // -------------------------------------------------------------------------
   // Select gated or primary clock
   // -------------------------------------------------------------------------

   // When no clock gates are present, all three output clocks are driven
   // directly by the incoming AHB clock.

   generate
      if(CBAW != 0) begin : gen_acg_1a

         assign rclk0 = cfg_acg ? rclk0_gated : hclk;
         assign rclk1 = cfg_acg ? rclk1_gated : hclk;
         assign pclk  = cfg_acg ? pclk_gated  : hclk;

      end else if(ACG != 0) begin : gen_acg_1b

         wire unused = cfg_acg;

         assign rclk0 = rclk0_gated;
         assign rclk1 = rclk1_gated;
         assign pclk  = pclk_gated;

      end else begin : gen_acg_1c

         wire [3:0] unused = { cfg_acg, rclk0_gated, rclk1_gated, pclk_gated };

         assign rclk0 = hclk;
         assign rclk1 = hclk;
         assign pclk  = hclk;

      end
   endgenerate

   // -------------------------------------------------------------------------

endmodule

//-----------------------------------------------------------------------------
// EOF
//-----------------------------------------------------------------------------
