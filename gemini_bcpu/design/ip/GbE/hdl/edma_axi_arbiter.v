//------------------------------------------------------------------------------
// Copyright (c) 2015-2019 Cadence Design Systems, Inc.
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
//   Filename:           edma_axi_arbiter.v
//   Module Name:        edma_axi_arbiter
//
//   Release Revision:   r1p12f1
//   Release SVN Tag:    gem_gxl_det0102_r1p12f1
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
//   Description
//
// 2 input AXI arbiter for combining DMA and PCIe master ports
// Does not add bits to the ID signals as a normal AXI arbiter would as
// PCIe and DMA generate non overlapping values
//
//------------------------------------------------------------------------------


module edma_axi_arbiter #(

  // Configuration parameters
  parameter AW                        =  32,      // address width
  parameter DW                        =  64,      // data width
  parameter IW                        =  4,       // ID Width of MACs
  parameter AXI4                      =  1,       // AXI4 / AXI3 select
  parameter AXI_WIC                   =  32'd8,   // Write Issuing Capability
  parameter AXI_WIC_WIDTH             =  4'd3,    // Log 2 (AXI_WIC)
  parameter AXI_RIC                   =  32'd8,   // Read Issuing Capability
  parameter AXI_RIC_WIDTH             =  4'd3     // Log 2 (AXI_RIC)

)(

  // Clock + Reset
  input                     aclk,
  input                     n_areset,

  // AXI slave port connecting to eMAC AXI master port
  // AW
  input [IW-1:0]            emac_awid,
  input [AW-1:0]            emac_awaddr,
  input [AW/8-1:0]          emac_awaddr_par,
  input [3+4*AXI4:0]        emac_awlen,
  input [2:0]               emac_awsize,
  input [1:0]               emac_awburst,
  input [1-AXI4:0]          emac_awlock,
  input [3:0]               emac_awcache,
  input [2:0]               emac_awprot,
  input [3:0]               emac_awqos,
  input [3:0]               emac_awregion,
  input                     emac_awvalid,
  output                    emac_awready,

  // W
  input [IW-1:0]            emac_wid,
  input [DW-1:0]            emac_wdata,
  input [DW/8-1:0]          emac_wdata_par,
  input [DW/8-1:0]          emac_wstrb,
  input                     emac_wlast,
  input                     emac_wvalid,
  output                    emac_wready,

  // B
  output [IW-1:0]           emac_bid,
  output [1:0]              emac_bresp,
  output                    emac_bvalid,

  // AR
  input [IW-1:0]            emac_arid,
  input [AW-1:0]            emac_araddr,
  input [AW/8-1:0]          emac_araddr_par,
  input [3+4*AXI4:0]        emac_arlen,
  input [2:0]               emac_arsize,
  input [1:0]               emac_arburst,
  input [1-AXI4:0]          emac_arlock,
  input [3:0]               emac_arcache,
  input [2:0]               emac_arprot,
  input [3:0]               emac_arqos,
  input [3:0]               emac_arregion,
  input                     emac_arvalid,
  output                    emac_arready,

  // R
  output [IW-1:0]           emac_rid,
  output [DW-1:0]           emac_rdata,
  output [DW/8-1:0]         emac_rdata_par,
  output [1:0]              emac_rresp,
  output                    emac_rlast,
  output                    emac_rvalid,
  input                     emac_rready,


  // AXI slave port connecting to pMAC AXI master port
  // AW
  input [IW-1:0]            pmac_awid,
  input [AW-1:0]            pmac_awaddr,
  input [AW/8-1:0]          pmac_awaddr_par,
  input [3+4*AXI4:0]        pmac_awlen,
  input [2:0]               pmac_awsize,
  input [1:0]               pmac_awburst,
  input [1-AXI4:0]          pmac_awlock,
  input [3:0]               pmac_awcache,
  input [2:0]               pmac_awprot,
  input [3:0]               pmac_awqos,
  input [3:0]               pmac_awregion,
  input                     pmac_awvalid,
  output                    pmac_awready,

  // W
  input [IW-1:0]            pmac_wid,
  input [DW-1:0]            pmac_wdata,
  input [DW/8-1:0]          pmac_wdata_par,
  input [DW/8-1:0]          pmac_wstrb,
  input                     pmac_wlast,
  input                     pmac_wvalid,
  output                    pmac_wready,

  // B
  output [IW-1:0]           pmac_bid,
  output [1:0]              pmac_bresp,
  output                    pmac_bvalid,
  // AR
  input [IW-1:0]            pmac_arid,
  input [AW-1:0]            pmac_araddr,
  input [AW/8-1:0]          pmac_araddr_par,
  input [3+4*AXI4:0]        pmac_arlen,
  input [2:0]               pmac_arsize,
  input [1:0]               pmac_arburst,
  input [1-AXI4:0]          pmac_arlock,
  input [3:0]               pmac_arcache,
  input [2:0]               pmac_arprot,
  input [3:0]               pmac_arqos,
  input [3:0]               pmac_arregion,
  input                     pmac_arvalid,
  output                    pmac_arready,

  // R
  output [IW-1:0]           pmac_rid,
  output [DW-1:0]           pmac_rdata,
  output [DW/8-1:0]         pmac_rdata_par,
  output [1:0]              pmac_rresp,
  output                    pmac_rlast,
  output                    pmac_rvalid,
  input                     pmac_rready,


  // AXI master port connecting to SoC AXI slave
  // AW
  output reg [IW:0]         awid,
  output reg [AW-1:0]       awaddr,
  output reg [AW/8-1:0]     awaddr_par,
  output reg [3+4*AXI4:0]   awlen,
  output reg [2:0]          awsize,
  output reg [1:0]          awburst,
  output reg [1-AXI4:0]     awlock,
  output reg [3:0]          awcache,
  output reg [2:0]          awprot,
  output reg [3:0]          awqos,
  output reg [3:0]          awregion,
  output                    awvalid,
  input                     awready,

  // W
  output [IW:0]             wid,
  output [DW-1:0]           wdata,
  output [DW/8-1:0]         wdata_par,
  output [DW/8-1:0]         wstrb,
  output                    wlast,
  output                    wvalid,
  input                     wready,

  // B
  input  [IW:0]             bid,
  input  [1:0]              bresp,
  input                     bvalid,
  output                    bready,

  // AR
  output reg [IW:0]         arid,
  output reg [AW-1:0]       araddr,
  output reg [AW/8-1:0]     araddr_par,
  output reg [3+4*AXI4:0]   arlen,
  output reg [2:0]          arsize,
  output reg [1:0]          arburst,
  output reg [1-AXI4:0]     arlock,
  output reg [3:0]          arcache,
  output reg [2:0]          arprot,
  output reg [3:0]          arqos,
  output reg [3:0]          arregion,
  output                    arvalid,
  input                     arready,

  // R
  input  [IW:0]             rid,
  input  [DW-1:0]           rdata,
  input  [DW/8-1:0]         rdata_par,
  input  [1:0]              rresp,
  input                     rlast,
  input                     rvalid,
  output                    rready

);

  wire                      emac_ar_gnt_int;
  wire                      emac_ar_gnt;
  reg                       emac_ar_gnt_hold;
  wire                      emac_r_sel;
  wire                      emac_aw_gnt;
  wire                      emac_aw_gnt_int;
  reg                       emac_aw_gnt_hold;
  wire                      emac_w_sel;
  wire                      emac_b_sel;

  wire                      pmac_ar_gnt_int;
  wire                      pmac_ar_gnt;
  reg                       pmac_ar_gnt_hold;
  wire                      pmac_r_sel;
  wire                      pmac_aw_gnt;
  wire                      pmac_aw_gnt_int;
  reg                       pmac_aw_gnt_hold;
  wire                      pmac_w_sel;
  wire                      pmac_b_sel;


  reg  [AXI_RIC_WIDTH:0]    ric_cnt;
  wire                      max_ric;

  reg  [AXI_WIC_WIDTH:0]    wic_cnt;
  wire                      max_wic;

  wire                      aw_gnt_fifo_in;
  wire                      aw_gnt_fifo_out;
  wire                      aw_gnt_fifo_push;
  wire                      aw_gnt_fifo_pop;
  wire                      aw_gnt_fifo_full;
  wire                      aw_gnt_fifo_empty;

  reg                       awvalid_1st_beat;

  //============================================================================
  // Write request arbitration
  // Use pmac_awvalid and emac_awvalid as requests
  // eMAC always has higher priority
  // AXI spec requires that awvalid does not drop before awready once
  // asserted, so generate hold signals to capture first granted master
  // until awready is asserted
  // Do not grant either master if write issuing capability has been met or if
  // aw grant FIFO is full
  //============================================================================

  assign emac_aw_gnt_int = emac_awvalid && !aw_gnt_fifo_full && !max_wic;
  assign pmac_aw_gnt_int = pmac_awvalid && !emac_awvalid && !emac_aw_gnt_hold && !aw_gnt_fifo_full && !max_wic;

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      emac_aw_gnt_hold <= 1'b0;
      pmac_aw_gnt_hold <= 1'b0;
    end
    else
    begin
      if (emac_aw_gnt_int && !pmac_aw_gnt_hold && !awready)
        emac_aw_gnt_hold <= 1'b1;
      else
        if (awready)
          emac_aw_gnt_hold <= 1'b0;

      if (pmac_aw_gnt_int && !emac_aw_gnt_hold && !awready)
        pmac_aw_gnt_hold <= 1'b1;
      else
        if (awready)
          pmac_aw_gnt_hold <= 1'b0;
    end
  end

  assign emac_aw_gnt = (emac_aw_gnt_int && !pmac_aw_gnt_hold) || emac_aw_gnt_hold;
  assign pmac_aw_gnt = (pmac_aw_gnt_int && !emac_aw_gnt_hold) || pmac_aw_gnt_hold;

  assign emac_awready = emac_aw_gnt && awready;
  assign pmac_awready = pmac_aw_gnt && awready;


  //============================================================================
  // FIFO to store flag indicating which requestor is granted for write accesses
  // - used to steer write data.
  // Pushed on first beat of AW request, pop on last stripe of W data
  //============================================================================

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      awvalid_1st_beat <= 1'b1;
    else
      if (awready)
        awvalid_1st_beat <= 1'b1;
      else
        if (awvalid)
          awvalid_1st_beat <= 1'b0;
  end

  assign aw_gnt_fifo_push = awvalid && awvalid_1st_beat;

  assign aw_gnt_fifo_pop  = wvalid && wready && wlast;

  assign aw_gnt_fifo_in   = emac_aw_gnt;


  edma_gen_fifo #(

    .FIFO_WIDTH       (1),
    .FIFO_DEPTH       (2),
    .FIFO_ADDR_WIDTH  (4'd1)

  ) i_aw_gnt_fifo (

    .clk_pcie   (aclk),
    .rst_n      (n_areset),

    .flush      (1'b0),

    .qempty     (aw_gnt_fifo_empty),
    .qfull      (aw_gnt_fifo_full),
    .qlevel     (),

    .push       (aw_gnt_fifo_push),
    .din        (aw_gnt_fifo_in),

    .pop        (aw_gnt_fifo_pop),
    .qout       (aw_gnt_fifo_out)

  );

  //============================================================================
  // Write data select
  // If aw_gnt FIFO is not empty, its output indicates which source should be
  // selected. If FIFO is empty, select source which matches that granted for
  // AW, but only if relevant AWREADY is also asserted. This ensures that
  // W transactions are not accepted in advance of corresponding AW transactions
  //============================================================================

  assign emac_w_sel =  (~aw_gnt_fifo_empty && aw_gnt_fifo_out);
  assign pmac_w_sel =  (~aw_gnt_fifo_empty && ~aw_gnt_fifo_out);

  assign wid        = emac_w_sel  ? {emac_wid, 1'b1}  : {pmac_wid, 1'b0};
  assign wdata      = emac_w_sel  ? emac_wdata        : pmac_wdata;
  assign wdata_par  = emac_w_sel  ? emac_wdata_par    : pmac_wdata_par;
  assign wstrb      = emac_w_sel  ? emac_wstrb        : pmac_wstrb;
  assign wlast      = emac_w_sel  ? emac_wlast        : pmac_wlast;


  assign emac_wready = emac_w_sel && wready;
  assign pmac_wready = pmac_w_sel && wready;

  //============================================================================
  // Write response steering
  // Drive signals to both ports, but only validate the relevant one
  // Strip lower bit from ID as this was added to the request by the arbiter
  //============================================================================
  assign emac_bid    = bid[IW:1];
  assign emac_bresp  = bresp;

  assign pmac_bid   = bid[IW:1];
  assign pmac_bresp = bresp;

  assign pmac_b_sel  = ~bid[0];
  assign emac_b_sel  = bid[0];

  assign pmac_bvalid = pmac_b_sel && bvalid;
  assign emac_bvalid = emac_b_sel && bvalid;


  //============================================================================
  // Write issuing capability counter
  //============================================================================
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      wic_cnt <= {AXI_WIC_WIDTH+1{1'b0}};
    else
      if (awvalid && awready && ~(bvalid && bready))
        wic_cnt <= wic_cnt + {{AXI_WIC_WIDTH{1'b0}}, 1'b1};
      else
        if (~(awvalid && awready) && bvalid && bready)
          wic_cnt <= wic_cnt - {{AXI_WIC_WIDTH{1'b0}}, 1'b1};
  end

  assign max_wic = ({{(31-AXI_WIC_WIDTH){1'b0}},wic_cnt} == AXI_WIC);

  //============================================================================
  // Read request arbitration
  // Use pmac_arvalid and emac_arvalid as requests
  // eMAC always has higher priority
  // AXI spec requires that arvalid does not drop before arready once
  // asserted, so generate hold signals to capture first granted master
  // until arready is asserted
  // Do not grant either master if read issuing capability has been met
  //============================================================================

  assign emac_ar_gnt_int = emac_arvalid && !max_ric;
  assign pmac_ar_gnt_int = pmac_arvalid && !emac_ar_gnt_int && !max_ric;

  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
    begin
      emac_ar_gnt_hold <= 1'b0;
      pmac_ar_gnt_hold <= 1'b0;
    end
    else
    begin
      if (emac_ar_gnt_int && !pmac_ar_gnt_hold && !arready)
        emac_ar_gnt_hold <= 1'b1;
      else
        if (arready)
          emac_ar_gnt_hold <= 1'b0;

      if (pmac_ar_gnt_int && !emac_ar_gnt_hold && !arready)
        pmac_ar_gnt_hold <= 1'b1;
      else
        if (arready)
          pmac_ar_gnt_hold <= 1'b0;
    end
  end

  assign emac_ar_gnt = (emac_ar_gnt_int && !pmac_ar_gnt_hold) || emac_ar_gnt_hold;
  assign pmac_ar_gnt = (pmac_ar_gnt_int && !emac_ar_gnt_hold) || pmac_ar_gnt_hold;

  assign emac_arready = emac_ar_gnt && arready;
  assign pmac_arready = pmac_ar_gnt && arready;



  //============================================================================
  // Write request selection
  //============================================================================
  always @(*)
  begin
    if (emac_aw_gnt)
    begin
      awid      = {emac_awid, 1'b1};
      awaddr    = emac_awaddr;
      awaddr_par= emac_awaddr_par;
      awlen     = emac_awlen;
      awsize    = emac_awsize;
      awburst   = emac_awburst;
      awlock    = emac_awlock;
      awcache   = emac_awcache;
      awprot    = emac_awprot;
      awqos     = emac_awqos;
      awregion  = emac_awregion;
    end
    else
    begin
      awid      = {pmac_awid, 1'b0};
      awaddr    = pmac_awaddr;
      awaddr_par= pmac_awaddr_par;
      awlen     = pmac_awlen;
      awsize    = pmac_awsize;
      awburst   = pmac_awburst;
      awlock    = pmac_awlock;
      awcache   = pmac_awcache;
      awprot    = pmac_awprot;
      awqos     = pmac_awqos;
      awregion  = pmac_awregion;
    end
  end

  //============================================================================
  // Read request selection
  //============================================================================
  always @(*)
  begin
    if (emac_ar_gnt)
    begin
      arid      = {emac_arid, 1'b1};
      araddr    = emac_araddr;
      araddr_par= emac_araddr_par;
      arlen     = emac_arlen;
      arsize    = emac_arsize;
      arburst   = emac_arburst;
      arlock    = emac_arlock;
      arcache   = emac_arcache;
      arprot    = emac_arprot;
      arqos     = emac_arqos;
      arregion  = emac_arregion;
    end
    else
    begin
      arid      = {pmac_arid, 1'b0};
      araddr    = pmac_araddr;
      araddr_par= pmac_araddr_par;
      arlen     = pmac_arlen;
      arsize    = pmac_arsize;
      arburst   = pmac_arburst;
      arlock    = pmac_arlock;
      arcache   = pmac_arcache;
      arprot    = pmac_arprot;
      arqos     = pmac_arqos;
      arregion  = pmac_arregion;
    end
  end


  //============================================================================
  // Read response steering
  // Drive signals to both ports, but only validate relevant one
  //============================================================================
  assign pmac_rid       = rid[IW:1];
  assign pmac_rdata     = rdata;
  assign pmac_rdata_par = rdata_par;
  assign pmac_rresp     = rresp;
  assign pmac_rlast     = rlast;

  assign emac_rid       = rid[IW:1];
  assign emac_rdata     = rdata;
  assign emac_rdata_par = rdata_par;
  assign emac_rresp     = rresp;
  assign emac_rlast     = rlast;

  assign pmac_r_sel  = ~rid[0];
  assign emac_r_sel  = rid[0];

  assign pmac_rvalid = pmac_r_sel && rvalid;
  assign emac_rvalid = emac_r_sel && rvalid;


  //============================================================================
  // Read access maximum outstanding request counter
  //============================================================================
  always @ (posedge aclk or negedge n_areset)
  begin
    if (~n_areset)
      ric_cnt <= {AXI_RIC_WIDTH+1{1'b0}};
    else
      if (arvalid && arready &&
          ~(rvalid && rready && rlast))
        ric_cnt <= ric_cnt + {{AXI_RIC_WIDTH{1'b0}}, 1'b1};
      else
        if (~(arvalid && arready) &&
             rvalid && rready && rlast)
          ric_cnt <= ric_cnt - {{AXI_RIC_WIDTH{1'b0}}, 1'b1};
  end

  assign max_ric = ({{(31-AXI_RIC_WIDTH){1'b0}},ric_cnt} == AXI_RIC);

  //============================================================================
  // SoC Port handshaking
  //============================================================================

  assign awvalid = (pmac_awvalid && pmac_aw_gnt) || (emac_awvalid && emac_aw_gnt);

  assign wvalid  = (pmac_wvalid && pmac_w_sel) || (emac_wvalid && emac_w_sel);

  assign bready  = 1'b1; // Underlying modules always accept the response

  assign arvalid = (pmac_arvalid && pmac_ar_gnt) || (emac_arvalid && emac_ar_gnt);

  assign rready  = (pmac_rready && pmac_r_sel) || (emac_rready && emac_r_sel);

////////////// Assertions ////////////////////
`ifdef ABV_ON

// Assertion 4.2.3 check that there are no dead cycles added
// We are going to check that the transitions on emac_awvalid/pmac_awvalid
// are propagated to awvalid in the same clock cycle.
// The same will be done with pmac_arvalid/emac_arvalid -> arvalid

// Write
property check_423_awvalid_pmac;
@(posedge aclk)
  (pmac_awvalid && pmac_aw_gnt) |->  (awvalid == pmac_awvalid);
endproperty
assert_check_423_awvalid_pmac : assert property (check_423_awvalid_pmac);

property check_423_awvalid_emac;
@(posedge aclk)
  (emac_awvalid && emac_aw_gnt) |->  (awvalid == emac_awvalid);
endproperty
assert_check_423_awvalid_emac : assert property (check_423_awvalid_emac);

// Read
property check_423_arvalid_pmac;
@(posedge aclk)
  (pmac_arvalid && pmac_ar_gnt) |->  (arvalid == pmac_arvalid);
endproperty
assert_check_423_arvalid_pmac : assert property (check_423_arvalid_pmac);

property check_423_arvalid_emac;
@(posedge aclk)
  (emac_arvalid && emac_ar_gnt) |->  (arvalid == emac_arvalid);
endproperty
assert_check_423_arvalid_emac : assert property (check_423_arvalid_emac);


// Assertion 4.2.4 check that AXI IDs are correctly added by the arbiter depending on the source MAC
// We are going to perform the check on AWID (Write) and ARID (Read)

// Write
property check_424_awid_emac;
@(posedge aclk)
  emac_aw_gnt |-> (awid [0] == 1'b1);
endproperty
assert_check_424_awid_emac : assert property (check_424_awid_emac);

property check_424_awid_pmac;
@(posedge aclk)
  pmac_aw_gnt |-> (awid [0] == 1'b0);
endproperty
assert_check_424_awid_pmac : assert property (check_424_awid_pmac);


// Read
property check_424_arid_emac;
@(posedge aclk)
  emac_ar_gnt |-> (arid [0] == 1'b1);
endproperty
assert_check_424_arid_emac : assert property (check_424_arid_emac);

property check_424_arid_pmac;
@(posedge aclk)
  pmac_ar_gnt |-> (arid [0] == 1'b0);
endproperty
assert_check_424_arid_pmac : assert property (check_424_arid_pmac);

`endif

endmodule

