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
//     AHB interconnect for CORTEX-M0+ Integration Kit
//-----------------------------------------------------------------------------
//
// This block contains an AHB address decoder and AHB multiplexors. It has
// 1 slave ports and 8 master ports.
// Master port 0 is used as the default if no other master port is matched
// by the address decode logic.
//-----------------------------------------------------------------------------

module cm0p_ik_ahb_interconnect
  #(
    parameter base_m1 = 32'h00000000,
    parameter width_m1 = 0,
    parameter enable_m1 = 1,
    parameter base_m2 = 32'h00000000,
    parameter width_m2 = 0,
    parameter enable_m2 = 1,
    parameter base_m3 = 32'h00000000,
    parameter width_m3 = 0,
    parameter enable_m3 = 1,
    parameter base_m4 = 32'h00000000,
    parameter width_m4 = 0,
    parameter enable_m4 = 1,
    parameter base_m5 = 32'h00000000,
    parameter width_m5 = 0,
    parameter enable_m5 = 1,
    parameter base_m6 = 32'h00000000,
    parameter width_m6 = 0,
    parameter enable_m6 = 1,
    parameter base_m7 = 32'h00000000,
    parameter width_m7 = 0,
    parameter enable_m7 = 1
    )
  (// Inputs
   input wire           HCLK,
   input wire           HRESETn,
   input wire [31:0]    HADDRS,
   input wire           HREADYOUTM0,
   input wire [31:0]    HRDATAM0,
   input wire           HRESPM0,
   input wire           HREADYOUTM1,
   input wire [31:0]    HRDATAM1,
   input wire           HRESPM1,
   input wire           HREADYOUTM2,
   input wire [31:0]    HRDATAM2,
   input wire           HRESPM2,
   input wire           HREADYOUTM3,
   input wire [31:0]    HRDATAM3,
   input wire           HRESPM3,
   input wire           HREADYOUTM4,
   input wire [31:0]    HRDATAM4,
   input wire           HRESPM4,
   input wire           HREADYOUTM5,
   input wire [31:0]    HRDATAM5,
   input wire           HRESPM5,
   input wire           HREADYOUTM6,
   input wire [31:0]    HRDATAM6,
   input wire           HRESPM6,
   input wire           HREADYOUTM7,
   input wire [31:0]    HRDATAM7,
   input wire           HRESPM7,
   // Output wires
   output wire          HREADYS,
   output wire          HRESPS,
   output wire [31:0]   HRDATAS,
   output wire          HSELM0,
   output wire          HSELM1,
   output wire          HSELM2,
   output wire          HSELM3,
   output wire          HSELM4,
   output wire          HSELM5,
   output wire          HSELM6,
   output wire          HSELM7
   );

   // Registered HSELs
   reg   hsel_m0_r;
   reg   hsel_m1_r;
   reg   hsel_m2_r;
   reg   hsel_m3_r;
   reg   hsel_m4_r;
   reg   hsel_m5_r;
   reg   hsel_m6_r;
   reg   hsel_m7_r;

   // HSEL Decoder
   wire  hsel_m7 = (enable_m7 != 0) & (HADDRS[31:width_m7] == base_m7[31:width_m7]);
   wire  hsel_m6 = (enable_m6 != 0) & (HADDRS[31:width_m6] == base_m6[31:width_m6]);
   wire  hsel_m5 = (enable_m5 != 0) & (HADDRS[31:width_m5] == base_m5[31:width_m5]);
   wire  hsel_m4 = (enable_m4 != 0) & (HADDRS[31:width_m4] == base_m4[31:width_m4]);
   wire  hsel_m3 = (enable_m3 != 0) & (HADDRS[31:width_m3] == base_m3[31:width_m3]);
   wire  hsel_m2 = (enable_m2 != 0) & (HADDRS[31:width_m2] == base_m2[31:width_m2]);
   wire  hsel_m1 = (enable_m1 != 0) & (HADDRS[31:width_m1] == base_m1[31:width_m1]);

   // m0 is used as the default port, for example for AHB Default Slave
   wire  hsel_m0 = ~(hsel_m1 | hsel_m2 | hsel_m3 | hsel_m4 | hsel_m5 | hsel_m6 | hsel_m7);

   // Registered HSEL
   always @ (posedge HCLK or negedge HRESETn)
     begin
       if (!HRESETn)
         begin
           hsel_m0_r <= 1'b0;
           hsel_m1_r <= 1'b0;
           hsel_m2_r <= 1'b0;
           hsel_m3_r <= 1'b0;
           hsel_m4_r <= 1'b0;
           hsel_m5_r <= 1'b0;
           hsel_m6_r <= 1'b0;
           hsel_m7_r <= 1'b0;
         end
       else if (HREADYS)
         begin
           hsel_m0_r <= hsel_m0;
           hsel_m1_r <= hsel_m1;
           hsel_m2_r <= hsel_m2;
           hsel_m3_r <= hsel_m3;
           hsel_m4_r <= hsel_m4;
           hsel_m5_r <= hsel_m5;
           hsel_m6_r <= hsel_m6;
           hsel_m7_r <= hsel_m7;
         end
     end

     assign HRDATAS = ({32{hsel_m0_r}} & HRDATAM0) |
                      ({32{hsel_m1_r}} & HRDATAM1) |
                      ({32{hsel_m2_r}} & HRDATAM2) |
                      ({32{hsel_m3_r}} & HRDATAM3) |
                      ({32{hsel_m4_r}} & HRDATAM4) |
                      ({32{hsel_m5_r}} & HRDATAM5) |
                      ({32{hsel_m6_r}} & HRDATAM6) |
                      ({32{hsel_m7_r}} & HRDATAM7);

     assign HRESPS  = (hsel_m0_r & HRESPM0) |
                      (hsel_m1_r & HRESPM1) |
                      (hsel_m2_r & HRESPM2) |
                      (hsel_m3_r & HRESPM3) |
                      (hsel_m4_r & HRESPM4) |
                      (hsel_m5_r & HRESPM5) |
                      (hsel_m6_r & HRESPM6) |
                      (hsel_m7_r & HRESPM7);

     assign HREADYS = (hsel_m0_r & HREADYOUTM0) |
                      (hsel_m1_r & HREADYOUTM1) |
                      (hsel_m2_r & HREADYOUTM2) |
                      (hsel_m3_r & HREADYOUTM3) |
                      (hsel_m4_r & HREADYOUTM4) |
                      (hsel_m5_r & HREADYOUTM5) |
                      (hsel_m6_r & HREADYOUTM6) |
                      (hsel_m7_r & HREADYOUTM7) |
                      // Reply READY if no master port (slave device) selected (reset)
                      (~(hsel_m0_r | hsel_m1_r | hsel_m2_r | hsel_m3_r | hsel_m4_r | hsel_m5_r | hsel_m6_r | hsel_m7_r));

     assign  HSELM0 = hsel_m0;
     assign  HSELM1 = hsel_m1;
     assign  HSELM2 = hsel_m2;
     assign  HSELM3 = hsel_m3;
     assign  HSELM4 = hsel_m4;
     assign  HSELM5 = hsel_m5;
     assign  HSELM6 = hsel_m6;
     assign  HSELM7 = hsel_m7;

endmodule
