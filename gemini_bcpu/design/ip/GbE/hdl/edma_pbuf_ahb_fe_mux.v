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
//   Filename:           edma_pbuf_ahb_fe_mux.v
//   Module Name:        edma_pbuf_ahb_fe_mux
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
//   Description : Mulitplexes the address, control and data
//                 signals of the granted master onto the
//                 common AHB.
//
//   Specifics   : Supports 3 AHB Masters
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_ahb_fe_mux (

    //utility signals
    hclk,                           //AHB clock
    n_hreset,                       //AHB reset

    //from the common AHB
    hready,                         //hready signals end of previous transfer

    //from the arbiter
    hmaster,                        //id of master currently granted the bus

    //pre-mux master 00 inputs
    hburst_00,                      //hburst from master 00
    htrans_00,                      //htrans from master 00
    hsize_00,                       //hsize from master 00
    hwrite_00,                      //hwrite from master 00
    hprot_00,                       //hprot from master 00
    haddr_00,                       //haddr from master 00
    hwdata_00,                      //hwdata from master 00

    //pre-mux master 01 inputs
    hburst_01,                      //hburst from master 01
    htrans_01,                      //htrans from master 01
    hsize_01,                       //hsize from master 01
    hwrite_01,                      //hwrite from master 01
    hprot_01,                       //hprot from master 01
    haddr_01,                       //haddr from master 01
    hwdata_01,                      //hwdata from master 01

    //pre-mux master 02 inputs
    hburst_02,                      //hburst from master 02
    htrans_02,                      //htrans from master 02
    hsize_02,                       //hsize from master 02
    hwrite_02,                      //hwrite from master 02
    hprot_02,                       //hprot from master 02
    haddr_02,                       //haddr from master 02
    hwdata_02,                      //hwdata from master 02

    //master 03 inputs
    hburst_03,                      //hburst from master 03
    htrans_03,                      //htrans from master 03
    hsize_03,                       //hsize from master 03
    hwrite_03,                      //hwrite from master 03
    hprot_03,                       //hprot from master 03
    haddr_03,                       //haddr from master 03
    hwdata_03,                      //hwdata from master 03

    //post-mux outputs to common AHB
    htrans,                         //htrans of granted master
    hburst,                         //hburst of granted master
    hsize,                          //hsize of granted master
    hwrite,                         //hwrite of granted master
    hprot,                          //hprot of granted master
    haddr,                          //haddr of granted master
    hwdata                          //hwdata of granted master

);

  // parameters used to synthesis out unwanted logic
  parameter p_edma_addr_width  = 0;
  parameter p_edma_bus_width   = 0;
  parameter [3:0] p_valm = 4'hf;     // bit-wise valids for masters

//------------------------------------------------------------------------------
//interface signal definitions
//------------------------------------------------------------------------------
//utility signals
input           hclk;               //AHB clock
input           n_hreset;           //AHB reset

//from the common AHB
input           hready;             //hready signals end of previous transfer

//from the arbiter
input   [3:0]   hmaster;            //id of master currently granted the bus

//pre-mux master 00 inputs
input   [2:0]   hburst_00;          //hburst from master 00
input   [1:0]   htrans_00;          //htrans from master 00
input   [2:0]   hsize_00;           //hsize from master 00
input           hwrite_00;          //hwrite from master 00
input   [3:0]   hprot_00;           //hprot from master 00
input   [p_edma_addr_width-1:0]  haddr_00;           //haddr from master 00
input   [p_edma_bus_width-1:0]  hwdata_00;          //hwdata from master 00

//pre-mux master 01 inputs
input   [2:0]   hburst_01;          //hburst from master 01
input   [1:0]   htrans_01;          //htrans from master 01
input   [2:0]   hsize_01;           //hsize from master 01
input           hwrite_01;          //hwrite from master 01
input   [3:0]   hprot_01;           //hprot from master 01
input   [p_edma_addr_width-1:0]  haddr_01;           //haddr from master 01
input   [p_edma_bus_width-1:0]  hwdata_01;          //hwdata from master 01

//pre-mux master 02 inputs
input   [2:0]   hburst_02;          //hburst from master 02
input   [1:0]   htrans_02;          //htrans from master 02
input   [2:0]   hsize_02;           //hsize from master 02
input           hwrite_02;          //hwrite from master 02
input   [3:0]   hprot_02;           //hprot from master 02
input   [p_edma_addr_width-1:0]  haddr_02;           //haddr from master 02
input   [p_edma_bus_width-1:0]  hwdata_02;          //hwdata from master 02


//master 03 inputs
input   [2:0]   hburst_03;              //hburst for master 03
input   [1:0]   htrans_03;              //htrans for master 03
input   [2:0]   hsize_03;               //hsize for master 03
input           hwrite_03;              //hwrite for master 03
input   [3:0]   hprot_03;               //hprot for master 03
input   [p_edma_addr_width-1:0]  haddr_03;               //haddr for master 03
input   [p_edma_bus_width-1:0]  hwdata_03;              //hwdata for master 03

//post-mux outputs to common AHB
output  [1:0]   htrans;             //htrans of granted master
output  [2:0]   hburst;             //hburst of granted master
output  [2:0]   hsize;              //hsize of granted master
output          hwrite;             //hwrite of granted master
output  [3:0]   hprot;              //hprot of granted master
output  [p_edma_addr_width-1:0]  haddr;              //haddr of granted master
output  [p_edma_bus_width-1:0]  hwdata;             //hwdata of granted master

//------------------------------------------------------------------------------
//output registers
//------------------------------------------------------------------------------
reg     [1:0]   htrans;
reg     [2:0]   hburst;
reg     [2:0]   hsize;
reg             hwrite;
reg     [3:0]   hprot;
reg     [p_edma_addr_width-1:0]  haddr;
reg     [p_edma_bus_width-1:0]  hwdata;

// internal signasl
wire    [3:0]  hmaster_bus;         // bit-wiswe decode of hmaster
wire    [3:0]  hmaster_int;         // gated with p_valm
wire    [3:0]  hmaster_data_bus;    // bit-wiswe decode of hmaster_data
wire    [3:0]  hmaster_data_bus_int;// gated with p_valm
reg     [3:0]   hmaster_data;        // hmaster pipelined to data phase

assign hmaster_bus[0] = ( hmaster == 4'd0 );
assign hmaster_bus[1] = ( hmaster == 4'd1 );
assign hmaster_bus[2] = ( hmaster == 4'd2 );
assign hmaster_bus[3] = ( hmaster == 4'd3 );

assign hmaster_int = hmaster_bus & p_valm;

// psl property HMASTER_ONE_HOT = always
//            (onehot0(hmaster_int))@ (posedge hclk);
// psl assert HMASTER_ONE_HOT;

//------------------------------------------------------------------------------
//multiplex address and control signals
//------------------------------------------------------------------------------
always @( * )
begin : p_address_mux

    casex (hmaster_int)

    4'bxxx1 : begin

        htrans   = htrans_00;
        hburst   = hburst_00;
        hsize    = hsize_00;
        hwrite   = hwrite_00;
        hprot    = hprot_00;
        haddr    = haddr_00;

    end //block : MUX_IN_MASTER_00

    4'bxx10 : begin

        htrans   = htrans_01;
        hburst   = hburst_01;
        hsize    = hsize_01;
        hwrite   = hwrite_01;
        hprot    = hprot_01;
        haddr    = haddr_01;

    end //block : MUX_IN_MASTER_01

    4'bx100 : begin

        htrans   = htrans_02;
        hburst   = hburst_02;
        hsize    = hsize_02;
        hwrite   = hwrite_02;
        hprot    = hprot_02;
        haddr    = haddr_02;

    end //block

    4'b1000 : begin

        htrans   = htrans_03;
        hburst   = hburst_03;
        hsize    = hsize_03;
        hwrite   = hwrite_03;
        hprot    = hprot_03;
        haddr    = haddr_03;

    end //block

    default: begin // should not occur

        htrans   = 2'b00;
        hburst   = 3'b000;
        hsize    = 3'b000;
        hwrite   = 1'b0;
        hprot    = 4'b0000;
        haddr    = {p_edma_addr_width{1'b0}};

    end //block

    endcase //hmaster

end //ADDR_CNT_MUX

//------------------------------------------------------------------------------
//delay hmaster using hready for multiplexing of hwdata
//------------------------------------------------------------------------------
always @(posedge hclk or negedge n_hreset)
begin  : p_hmaster_data

    if (~n_hreset)
        hmaster_data <= 4'b0000;
    else
        if (hready)
            hmaster_data <= hmaster;
        else
            hmaster_data <= hmaster_data;

end //DELAY_HMASTER

assign hmaster_data_bus[0] = ( hmaster_data == 4'd0 );
assign hmaster_data_bus[1] = ( hmaster_data == 4'd1 );
assign hmaster_data_bus[2] = ( hmaster_data == 4'd2 );
assign hmaster_data_bus[3] = ( hmaster_data == 4'd3 );

assign hmaster_data_bus_int = hmaster_data_bus & p_valm;

// psl property HMST_BUS_ONE_HOT = always
//            (onehot0(hmaster_data_bus_int))@ (posedge hclk);
// psl assert HMST_BUS_ONE_HOT;

//------------------------------------------------------------------------------
//multiplex write data bus
//------------------------------------------------------------------------------
always @( * )
begin : p_hwdata

    casex (hmaster_data_bus_int)

    4'bxxx1 : hwdata = hwdata_00;
    4'bxx10 : hwdata = hwdata_01;
    4'bx100 : hwdata = hwdata_02;
    4'b1000 : hwdata = hwdata_03;
    default : hwdata = {p_edma_bus_width{1'd0}};

    endcase //hmaster_data

end //DATA_MUX

endmodule
