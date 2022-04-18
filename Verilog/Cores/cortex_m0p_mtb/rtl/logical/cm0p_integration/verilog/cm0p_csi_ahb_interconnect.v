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
//      SVN Information
//
//      Checked In          : $Date: 2012-12-10 15:58:59 +0000 (Mon, 10 Dec 2012) $
//
//      Revision            : $Revision: 231111 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//     AHB interconnect for Cortex-M0+ CoreSight Processor Integration Level
//-----------------------------------------------------------------------------
//
// This block contains AHB address decoder and AHB multiplexors. It has
// 1 slave ports and 3 master ports:
// Slave port    -   Debug Component Slave Port
// Master 0 port -   CoreSight Inegration ROM Table
// Master 1 port -   CTI
// Master 2 port -   CoreSight MTB-M0+
//-----------------------------------------------------------------------------

module cm0p_csi_ahb_interconnect
  #(
    parameter ROMTABLEBASE = 32'hF0000000,
    parameter CTI          = 0,
    parameter CTIBASE      = 32'hF0001000,
    parameter MTB          = 0,
    parameter MTBAWIDTH    = 0,
    parameter MTBSFRBASE   = 32'hF0002000
    )
   (// Inputs
    input wire           hclk,
    input wire           hreset_n,
    input wire           hsel,
    input wire           hreadys,
    input wire [31:0]    haddrs,
    input wire           hreadyout_rom_table,
    input wire [31:0]    hrdata_rom_table,
    input wire           hresp_rom_table,
    input wire           hreadyout_cti,
    input wire [31:0]    hrdata_cti,
    input wire           hresp_cti,
    input wire           hreadyout_mtb,
    input wire [31:0]    hrdata_mtb,
    input wire           hresp_mtb,
    input wire [31:0]    mtb_sram_base,
    // Output wires
    output wire          hreadyouts,
    output wire          hresps,
    output wire [31:0]   hrdatas,
    output wire          hsel_rom_table,
    output wire          hsel_cti,
    output wire          hsel_mtb_sfr,
    output wire          hsel_mtb_sram
    );


   // Assist Lint waivers
   wire [11:0] unused = haddrs[11:0];


   // Registered HSELs
   reg   hsel_rom_table_r;
   reg   hsel_cti_r;
   reg   hsel_mtb_r;


   // HSEL Decoder
   assign hsel_rom_table = hsel & (haddrs[31:12] == ROMTABLEBASE[31:12]);
   assign hsel_cti       = hsel & (haddrs[31:12] == CTIBASE[31:12])    & (CTI!=0);
   assign hsel_mtb_sfr   = hsel & (haddrs[31:12] == MTBSFRBASE[31:12]) & (MTB!=0);

   // Extend width before comparison of mtb sram addresses to avoid compilation issues when AWIDTH=32
   wire [32:0] haddr_33  = {1'b0, haddrs[31:0]};
   wire [32:0] mtb_sram_base_33 = {1'b0, mtb_sram_base[31:0]};
   assign hsel_mtb_sram  = hsel &
                           (haddr_33[32:MTBAWIDTH] == mtb_sram_base_33[32:MTBAWIDTH]) &
                           (MTB!=0);


   // Combined hsel for MTB SFRs and SRAM selects the same master port
   wire    hsel_mtb      = hsel_mtb_sfr | hsel_mtb_sram;


   // Registered HSEL
   always @ (posedge hclk or negedge hreset_n)
     begin
       if (~hreset_n)
         begin
           hsel_rom_table_r <= 1'b0;
           hsel_cti_r       <= 1'b0;
           hsel_mtb_r       <= 1'b0;
         end
       else if (hreadys)
         begin
           hsel_rom_table_r <= hsel_rom_table;
           hsel_cti_r       <= hsel_cti;
           hsel_mtb_r       <= hsel_mtb;
          end
     end

     assign hrdatas = ({32{hsel_rom_table_r}} & hrdata_rom_table) |
                      ({32{hsel_cti_r}}       & hrdata_cti) |
                      ({32{hsel_mtb_r}}       & hrdata_mtb);

     assign hresps  = (hsel_rom_table_r & hresp_rom_table) |
                      (hsel_cti_r       & hresp_cti) |
                      (hsel_mtb_r       & hresp_mtb);

     assign hreadyouts = (hsel_rom_table_r & hreadyout_rom_table) |
                         (hsel_cti_r       & hreadyout_cti) |
                         (hsel_mtb_r       & hreadyout_mtb) |
                         // non-selectedd case: return ready response
                         (~(hsel_rom_table_r | hsel_cti_r | hsel_mtb_r));

   // -------------------------------------------------------------------------

`ifdef ARM_ASSERT_ON

   // -------------------------------------------------------------------------
   // Assertions
   // -------------------------------------------------------------------------

   `include "std_ovl_defines.h"

   // Check that only one hsel is asserted
   assert_zero_one_hot
     #(`OVL_FATAL,3,`OVL_ASSERT,
       "Only one slave can be selected at a time")
   u_asrt_hsel_onehot
     (.clk(hclk), .reset_n(hreset_n),
      .test_expr({hsel_rom_table, hsel_cti, hsel_mtb}));

`endif

endmodule
