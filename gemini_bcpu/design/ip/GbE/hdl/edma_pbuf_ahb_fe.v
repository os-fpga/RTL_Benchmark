//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           edma_pbuf_ahb_fe.v
//   Module Name:        edma_pbuf_ahb_fe
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description    :   This module takes the 4 AHB masters from edma_pbuf.v
//                      and arbitrates between them using a simple arbitration
//                      priority
//                        1) TOP PRIORITY = RX descriptor access
//                        2)              = TX descriptor access
//                        3)              = RX data access
//                        4)              = RX data access
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_ahb_fe (

 // Inputs

    // global clk & reset
    n_hreset,                       // global reset
    hclk,                           // global clock

    // ahb input interface
    hgrant,                         // ahb grant
    hready,                         // slave ready to complete current transfer

    //RX Descriptor Master inputs
    hbusreq_00,                     //hbusreq from RX Descriptor Master
    hlock_00,                       //hlock from RX Descriptor Master
    hburst_00,                      //hburst from RX Descriptor Master
    htrans_00,                      //htrans from RX Descriptor Master
    hsize_00,                       //hsize from RX Descriptor Master
    hwrite_00,                      //hwrite from RX Descriptor Master
    hprot_00,                       //hprot from RX Descriptor Master
    haddr_00,                       //haddr from RX Descriptor Master
    hwdata_00,                      //hwdata from RX Descriptor Master

    //TX Descriptor Master inputs
    hbusreq_01,                     //hbusreq from TX Descriptor Master
    hlock_01,                       //hlock from TX Descriptor Master
    hburst_01,                      //hburst from TX Descriptor Master
    htrans_01,                      //htrans from TX Descriptor Master
    hsize_01,                       //hsize from TX Descriptor Master
    hwrite_01,                      //hwrite from TX Descriptor Master
    hprot_01,                       //hprot from TX Descriptor Master
    haddr_01,                       //haddr from TX Descriptor Master
    hwdata_01,                      //hwdata from TX Descriptor Master

    //RX Data Master inputs
    hbusreq_02,                     //hbusreq from RX Data Master
    hlock_02,                       //hlock from RX Data Master
    hburst_02,                      //hburst from RX Data Master
    htrans_02,                      //htrans from RX Data Master
    hsize_02,                       //hsize from RX Data Master
    hwrite_02,                      //hwrite from RX Data Master
    hprot_02,                       //hprot from RX Data Master
    haddr_02,                       //haddr from RX Data Master
    hwdata_02,                      //hwdata from RX Data Master

    //TX Data Master inputs
    hbusreq_03,                     //hbusreq from TX Data Master
    hlock_03,                       //hlock from TX Data Master
    hburst_03,                      //hburst from TX Data Master
    htrans_03,                      //htrans from TX Data Master
    hsize_03,                       //hsize from TX Data Master
    hwrite_03,                      //hwrite from TX Data Master
    hprot_03,                       //hprot from TX Data Master
    haddr_03,                       //haddr from TX Data Master
    hwdata_03,                      //hwdata from TX Data Master

 // Outputs
    //arbiter outputs to common AHB
    hgrant_00,                      //hgrant for master 00
    hgrant_01,                      //hgrant for master 01
    hgrant_02,                      //hgrant for master 02
    hgrant_03,                      //hgrant for master 03

    // ahb output interface
    htrans,                         // current ahb transfer
    hburst,                         // type of burst
    hsize,                          // size of the transfer (32, 64 or 128)
    hwrite,                         // direction of the transfer
    hbusreq,                        // ahb requested
    hlock,                          // burst not to be interrupted
    haddr,                          // transfer address
    hwdata,                         // ahb output data
    hprot                            // burst meaning - not used

 );

// -----------------------------------------------------------------------------
// Input declarations
// -----------------------------------------------------------------------------

  parameter p_edma_addr_width  = 0;
  parameter p_edma_bus_width   = 0;

   // system inputs
   input           n_hreset;             // global reset
   input           hclk;                 // global clock for this module

   // ahb input interface
   input           hgrant;               // ahb grant
   input           hready;               // slave ready to complete transfer

   //master 00 inputs
   input           hbusreq_00;             //hbusreq for master 00
   input           hlock_00;               //hlock for master 00
   input   [2:0]   hburst_00;              //hburst for master 00
   input   [1:0]   htrans_00;              //htrans for master 00
   input   [2:0]   hsize_00;               //hsize for master 00
   input           hwrite_00;              //hwrite for master 00
   input   [3:0]   hprot_00;               //hprot for master 00
   input   [p_edma_addr_width-1:0]  haddr_00;               //haddr for master 00
   input   [p_edma_bus_width-1:0]  hwdata_00;              //hwdata for master 00

   //master 01 inputs
   input           hbusreq_01;             //hbusreq for master 01
   input           hlock_01;               //hlock for master 01
   input   [2:0]   hburst_01;              //hburst for master 01
   input   [1:0]   htrans_01;              //htrans for master 01
   input   [2:0]   hsize_01;               //hsize for master 01
   input           hwrite_01;              //hwrite for master 01
   input   [3:0]   hprot_01;               //hprot for master 01
   input   [p_edma_addr_width-1:0]  haddr_01;               //haddr for master 01
   input   [p_edma_bus_width-1:0]  hwdata_01;              //hwdata for master 01

   //master 02 inputs
   input           hbusreq_02;             //hbusreq for master 02
   input           hlock_02;               //hlock for master 02
   input   [2:0]   hburst_02;              //hburst for master 02
   input   [1:0]   htrans_02;              //htrans for master 02
   input   [2:0]   hsize_02;               //hsize for master 02
   input           hwrite_02;              //hwrite for master 02
   input   [3:0]   hprot_02;               //hprot for master 02
   input   [p_edma_addr_width-1:0]  haddr_02;               //haddr for master 02
   input   [p_edma_bus_width-1:0]  hwdata_02;              //hwdata for master 02

   //master 03 inputs
   input           hbusreq_03;             //hbusreq for master 03
   input           hlock_03;               //hlock for master 03
   input   [2:0]   hburst_03;              //hburst for master 03
   input   [1:0]   htrans_03;              //htrans for master 03
   input   [2:0]   hsize_03;               //hsize for master 03
   input           hwrite_03;              //hwrite for master 03
   input   [3:0]   hprot_03;               //hprot for master 03
   input   [p_edma_addr_width-1:0]  haddr_03;               //haddr for master 03
   input   [p_edma_bus_width-1:0]  hwdata_03;              //hwdata for master 03
// -----------------------------------------------------------------------------
// Output declarations
// -----------------------------------------------------------------------------

   //arbiter outputs to common AHB
   output          hgrant_00;              //hgrant for master 00
   output          hgrant_01;              //hgrant for master 01
   output          hgrant_02;              //hgrant for master 02
   output          hgrant_03;              //hgrant for master 03

 // ahb output interface
   output  [1:0]   htrans;               // current ahb transfer
   output  [2:0]   hburst;               // type of burst
   output  [2:0]   hsize;                // size of the transfer (32, 64 or 128)
   output          hwrite;               // direction of the transfer
   output          hbusreq;              // ahb requested
   output          hlock;                // burst not to be interrupted
   output  [p_edma_addr_width-1:0]  haddr;                // transfer address
   output  [p_edma_bus_width-1:0]  hwdata;               // ahb output data
   output  [3:0]   hprot;                // burst meaning - not used


   wire    [3:0]   hmaster;

   wire            hgrant_00i;              //hgrant for master 00
   wire            hgrant_01i;              //hgrant for master 01
   wire            hgrant_02i;              //hgrant for master 02
   wire            hgrant_03i;              //hgrant for master 03

  assign hgrant_00 = hgrant & hgrant_00i;
  assign hgrant_01 = hgrant & hgrant_01i;
  assign hgrant_02 = hgrant & hgrant_02i;
  assign hgrant_03 = hgrant & hgrant_03i;
  assign hlock = 1'b0;

//------------------------------------------------------------------------------
//instantiate the arbiter
//------------------------------------------------------------------------------
edma_pbuf_ahb_fe_arb  i_arbiter (

    //utility signals
    .hclk               (hclk),          //AHB clock
    .n_hreset           (n_hreset),      //AHB reset

    //master 00 arbitration inputs
    .hbusreq_00         (hbusreq_00),    //hbusreq from master 00
    .hlock_00           (hlock_00),      //hlock from master 00

    //master 01 arbitration inputs
    .hbusreq_01         (hbusreq_01),    //hbusreq from master 01
    .hlock_01           (hlock_01),      //hlock from master 01

    //master 02 arbitration inputs
    .hbusreq_02         (hbusreq_02),    //hbusreq from master 02
    .hlock_02           (hlock_02),      //hlock from master 02

    //master 03 arbitration inputs
    .hbusreq_03         (hbusreq_03),    //hbusreq from master 03
    .hlock_03           (hlock_03),      //hlock from master 03

    //from the common AHB
    .htrans             (htrans),        //htrans from the granted master
    .hburst             (hburst),        //hburst from the granted master
    .hready             (hready),        //hready from the selected slave

    .c_priority_type    (2'b00),         // Fixed Priority
                                         // (set to 2'b00 for roundrobin)

    //output to common AHB
    .hgrant_00          (hgrant_00i),     //hgrant for master 00
    .hgrant_01          (hgrant_01i),     //hgrant for master 01
    .hgrant_02          (hgrant_02i),     //hgrant for master 02
    .hgrant_03          (hgrant_03i),     //hgrant for master 03
    .hmastlock          (),               //granted master has locked access
    .hmaster            (hmaster)         //id of the currently granted master

);

edma_pbuf_ahb_fe_mux  #(
                      .p_edma_addr_width(p_edma_addr_width),
                      .p_edma_bus_width(p_edma_bus_width)
                    ) i_master2slavemux (

    //utility signals
    .hclk               (hclk),             //AHB clock
    .n_hreset           (n_hreset),         //AHB reset

    //from the common AHB
    .hready             (hready),           //previous transfer's hready

    //from the arbiter
    .hmaster            (hmaster),          //id of currently granted master

    //pre-mux master 00 inputs
    .hburst_00          (hburst_00),        //hburst for master 00
    .htrans_00          (htrans_00),        //htrans for master 00
    .hsize_00           (hsize_00),         //hsize for master 00
    .hwrite_00          (hwrite_00),        //hwrite for master 00
    .hprot_00           (hprot_00),         //hprot for master 00
    .haddr_00           (haddr_00),         //haddr for master 00
    .hwdata_00          (hwdata_00),        //hwdata for master 00

    //pre-mux master 01 inputs
    .hburst_01          (hburst_01),        //hburst for master 01
    .htrans_01          (htrans_01),        //htrans for master 01
    .hsize_01           (hsize_01),         //hsize for master 01
    .hwrite_01          (hwrite_01),        //hwrite for master 01
    .hprot_01           (hprot_01),         //hprot for master 01
    .haddr_01           (haddr_01),         //haddr for master 01
    .hwdata_01          (hwdata_01),        //hwdata for master 01

    //pre-mux master 02 inputs
    .hburst_02          (hburst_02),        //hburst for master 02
    .htrans_02          (htrans_02),        //htrans for master 02
    .hsize_02           (hsize_02),         //hsize for master 02
    .hwrite_02          (hwrite_02),        //hwrite for master 02
    .hprot_02           (hprot_02),         //hprot for master 02
    .haddr_02           (haddr_02),         //haddr for master 02
    .hwdata_02          (hwdata_02),        //hwdata for master 02

    //pre-mux master 03 inputs
    .hburst_03          (hburst_03),        //hburst for master 03
    .htrans_03          (htrans_03),        //htrans for master 03
    .hsize_03           (hsize_03),         //hsize for master 03
    .hwrite_03          (hwrite_03),        //hwrite for master 03
    .hprot_03           (hprot_03),         //hprot for master 03
    .haddr_03           (haddr_03),         //haddr for master 03
    .hwdata_03          (hwdata_03),        //hwdata for master 03

    //post-mux outputs to common AHB
    .hburst             (hburst),           //hburst of granted master
    .htrans             (htrans),           //htrans of granted master
    .hsize              (hsize),            //hsize of granted master
    .hwrite             (hwrite),           //hwrite of granted master
    .hprot              (hprot),            //hprot of granted master
    .haddr              (haddr),            //haddr of granted master
    .hwdata             (hwdata)            //hwdata of granted master

);
assign hbusreq = hbusreq_00 | hbusreq_01 | hbusreq_02 | hbusreq_03;

endmodule
