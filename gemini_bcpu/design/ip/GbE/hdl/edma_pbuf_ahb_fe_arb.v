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
//   Filename:           edma_pbuf_ahb_fe_arb.v
//   Module Name:        edma_pbuf_ahb_fe_arb
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
//   Description : generates hgrant, hmastlock and hmaster signals
//                based upon the output of the priority and end_burst modules
//
//   Specifics   : Supports 4 AHB Masters
//
//------------------------------------------------------------------------------


//htrans defines
`define         AHBCARB_IDLE            2'b00
`define         AHBCARB_BUSY            2'b01
`define         AHBCARB_NONSEQ          2'b10
`define         AHBCARB_SEQ             2'b11

//hburst defines
`define         AHBCARB_SINGLE          3'b000
`define         AHBCARB_INCR            3'b001
`define         AHBCARB_WRAP4           3'b010
`define         AHBCARB_INCR4           3'b011
`define         AHBCARB_WRAP8           3'b100
`define         AHBCARB_INCR8           3'b101
`define         AHBCARB_WRAP16          3'b110
`define         AHBCARB_INCR16          3'b111

//hresp defines
`define         AHBCARB_OKAY            2'b00
`define         AHBCARB_ERROR           2'b01
`define         AHBCARB_RETRY           2'b10
`define         AHBCARB_SPLIT           2'b11

module edma_pbuf_ahb_fe_arb (

    //utility signals
    hclk,                           //AHB clock
    n_hreset,                       //AHB reset

    //master 00 arbitration inputs
    hbusreq_00,                     //hbusreq from master 00
    hlock_00,                       //hlock from master 00

    //master 01 arbitration inputs
    hbusreq_01,                     //hbusreq from master 01
    hlock_01,                       //hlock from master 01

    //master 02 arbitration inputs
    hbusreq_02,                     //hbusreq from master 02
    hlock_02,                       //hlock from master 02

    //master 03 inputs
    hbusreq_03,                     //hbusreq from master 03
    hlock_03,                       //hlock from master 03

    //common AHB inputs
    htrans,                         //htrans from granted master
    hburst,                         //hburst from granted master
    hready,                         //hready from granted slave

    c_priority_type,                // Priority type

    //output to common AHB
    hgrant_00,                      //hgrant for master 00
    hgrant_01,                      //hgrant for master 01
    hgrant_02,                      //hgrant for master 02
    hgrant_03,                      //hgrant for master 03
    hmastlock,                      //the granted master has locked access
    hmaster                         //the id for the currently granted master

);//end module edma_pbuf_ahbarb

// parameters used to synthesis out unwanted logic
parameter [3:0] p_valm = 4'hf;     // bit-wise valids for masters

//------------------------------------------------------------------------------
//interface signal definitions
//------------------------------------------------------------------------------
//utility signals
input           hclk;               //AHB clock
input           n_hreset;           //AHB reset

//master 00 arbitration inputs
input           hbusreq_00;         //hbusreq from master 00
input           hlock_00;           //hlock from master 00

//master 01 arbitration inputs
input           hbusreq_01;         //hbusreq from master 01
input           hlock_01;           //hlock from master 01

//master 02 arbitration inputs
input           hbusreq_02;         //hbusreq from master 02
input           hlock_02;           //hlock from master 02

//master 03 inputs
input           hbusreq_03;             //hbusreq for master 03
input           hlock_03;               //hlock for master 03

//from the common AHB
input   [1:0]   htrans;             //htrans from the granted master
input   [2:0]   hburst;             //hburst from the granted master
input           hready;             //hready from the selected slave

//configuration inputs
// Arbiter configuration
input   [1:0]   c_priority_type;        // Priority type
                                        // 00 = round robin descending
                                        // 01 = fixed 15 most 0 least
                                        // 1? = reserved

//output to common AHB
output          hgrant_00;          //hgrant for master 00
output          hgrant_01;          //hgrant for master 01
output          hgrant_02;          //hgrant for master 02
output          hgrant_03;          //hgrant for master 03
output          hmastlock;          //the granted master has locked access
output  [3:0]   hmaster;            //the id for the currently granted master

//------------------------------------------------------------------------------
//output wires and registers
//------------------------------------------------------------------------------
wire            hgrant_00;
wire            hgrant_01;
wire            hgrant_02;
wire            hgrant_03;
reg             hmastlock;
reg     [3:0]   hmaster;

//------------------------------------------------------------------------------
//internal signals and defines
//------------------------------------------------------------------------------
reg             rearbitrate;        //last address phase of the current burst
reg     [3:0]  next_master;         //indicates the master id that will be
                                    //granted the bus at the next opportunity
reg     [3:0]  hgrant_bus;          //hgrant for each of the masters
wire    [3:0]  hgrant_int;          //hgrant_bus gated with p_valm

wire    [3:0]  hlock_bus;           //hlock for each of the masters
reg     [3:0]  hgrant_bus_reg;      //registered version of hgrant_bus

wire    [3:0]  hbusreq_bus;         //master requests grouped

wire    [7:0]   priority_bus;       // used to reorder priority
reg     [7:0]   priority_field;     // Field from which to select master

//------------------------------------------------------------------------------
//group the bus request signals from the masters
// Validate requests with masters that exist
//------------------------------------------------------------------------------
assign hbusreq_bus = { hbusreq_03,
                       hbusreq_02,
                       hbusreq_01,
                       hbusreq_00 };


//------------------------------------------------------------------------------
//split hgrant_bus in to individual signals
//------------------------------------------------------------------------------
assign hgrant_00 = hgrant_bus[00];
assign hgrant_01 = hgrant_bus[01];
assign hgrant_02 = hgrant_bus[02];
assign hgrant_03 = hgrant_bus[03];


//------------------------------------------------------------------------------
//generate hgrant signals
//The default master must be granted when a locked transfer is split.
//Masters that receive RETRY responses to locked transfers should be re-granted
//Next master should be granted when rearbitrate is high
//------------------------------------------------------------------------------
always @( * )
begin
  if (rearbitrate)
    hgrant_bus = next_master & p_valm;
  else
    hgrant_bus = hgrant_bus_reg & p_valm;
end

//------------------------------------------------------------------------------
//register hgrant_bus
//------------------------------------------------------------------------------
always @(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
      hgrant_bus_reg <= 4'h8;
  else
      hgrant_bus_reg <= hgrant_bus & p_valm;
end


//------------------------------------------------------------------------------
//generate hmaster and hmastlock
//------------------------------------------------------------------------------
assign hlock_bus = { hlock_03,
                     hlock_02,
                     hlock_01,
                     hlock_00 };

assign hgrant_int = hgrant_bus;

// psl property HGRANT_ONE_HOT = always
//            (onehot0(hgrant_int))@(posedge hclk);
// psl assert HGRANT_ONE_HOT;

always @(posedge hclk or negedge n_hreset)
begin

  if (~n_hreset)
  begin
    //default master is assigned during reset
    hmaster   <= 4'd3; // DEFAULT MASTER
  end

  else if (hready)
  begin

    //hmaster is generated based upon hgrant
    casex (hgrant_int)
      4'bxxx1 : hmaster <= 4'd00;
      4'bxx10 : hmaster <= 4'd01;
      4'bx100 : hmaster <= 4'd02;
      4'b1000 : hmaster <= 4'd03;
      default : hmaster <= hmaster;
    endcase //(hgrant)

  end
  else
      begin
          hmaster   <= hmaster;
      end
end

//hmastlock is asserted if the current access is part of a locked transfer.
//Unspecified length transfers may have sections that are locked.
//Other transfer types indicate locked access before the first transfer.
always @(posedge hclk or negedge n_hreset)
begin
    if (~n_hreset)
        begin
            hmastlock <= 1'b0;
        end
    else
        begin
            if (hready)
                hmastlock <= |(hlock_bus & hgrant_bus);
            else
                hmastlock <= hmastlock;
        end
end

reg             hmastlock_1d;       //registered copy of hmastlock

//------------------------------------------------------------------------------
//register the hmastlock signal.
//The AHB master cannot change in the cycle that follows a locked transfer
//------------------------------------------------------------------------------
always @(posedge hclk or negedge n_hreset)
begin
    if (~n_hreset)
        hmastlock_1d <= 1'b0 ;
    else
        hmastlock_1d <= hmastlock ;
end

reg     [1:0]   htrans_1rd;         //htrans registered only when hready high
//------------------------------------------------------------------------------
//register the htrans signal.
//------------------------------------------------------------------------------
always @(posedge hclk or negedge n_hreset)
begin
    if (~n_hreset)
        htrans_1rd <= 2'b00;
    else if (hready & htrans != `AHBCARB_BUSY )
        htrans_1rd <= htrans ;
    else
        htrans_1rd <= htrans_1rd ;
end

reg     [4:0]   tfer_count;         //count number of transfer during burst
//------------------------------------------------------------------------------
//count the number of transfers in the current burst
//------------------------------------------------------------------------------
always @(posedge hclk or negedge n_hreset)
begin : p_tfer_count

    if (~n_hreset)
        //if reset
        tfer_count <= {5{1'b0}};

    //Set tfer_count to be the number of transfers to be performed, minus 1.
    else if (hready & (htrans == `AHBCARB_NONSEQ))
        case(hburst)
            `AHBCARB_SINGLE          :  tfer_count <= 5'h00;
            `AHBCARB_INCR            :  tfer_count <= 5'h0f;
            `AHBCARB_WRAP4,  `AHBCARB_INCR4  :  tfer_count <= 5'h03;
            `AHBCARB_WRAP8,  `AHBCARB_INCR8  :  tfer_count <= 5'h07;
            `AHBCARB_WRAP16, `AHBCARB_INCR16 :  tfer_count <= 5'h0f;
        endcase // (hburst)

    else if ( hready &
              ( (htrans_1rd == `AHBCARB_NONSEQ) | (htrans_1rd == `AHBCARB_SEQ) ) &
              ( htrans != `AHBCARB_BUSY )
            )
        tfer_count <= tfer_count - 5'h01 ;

    else // hready low
        tfer_count <= tfer_count;

end //TFER_CNT

//------------------------------------------------------------------------------
//end burst state machine
//------------------------------------------------------------------------------
always @( * )
begin : p_rearbitrate

    //prevent arbitration happening when a locked transfer is underway, in the
    //cycle immediately following a locked transfer or when a locked transfer
    //has been given a SPLIT or RETRY response and has not yet completed.
    if (hmastlock | hmastlock_1d)
        rearbitrate = 1'b0 ;

    else begin

      case ( htrans )

      `AHBCARB_IDLE: rearbitrate = 1'b1;

      `AHBCARB_BUSY, `AHBCARB_NONSEQ:
        if ( hburst == 3'b000 ) begin
          rearbitrate = 1'b1;
        end
        else begin
          rearbitrate = 1'b0;
        end

      default:   // `AHBCARB_SEQ:
        if (tfer_count == 5'h01) begin
          rearbitrate = 1'b1;
        end
        else begin
          rearbitrate = 1'b0;
        end

      endcase

    end

end //REARBITRATE

//-------------------------------------------------------
// Generate field to select priority
always @ ( hmaster or c_priority_type )
begin
  case ( c_priority_type )
  2'b00: // round robin
    case ( hmaster )
    4'd00   : priority_field = 8'h0f;
    4'd01   : priority_field = 8'h1e;
    4'd02   : priority_field = 8'h3c;
    default : priority_field = 8'h78;
    endcase
  2'b01 : // fixed priority
    priority_field = 8'h0f;
  default :
    priority_field = 8'h0f;
  endcase
end

wire [7:0]  hbusreq_x2 = { hbusreq_bus, hbusreq_bus };
wire [7:0]  w_valm_x2;
assign w_valm_x2[7:4] = p_valm;
assign w_valm_x2[3:0] = p_valm;
assign priority_bus = priority_field &
                      hbusreq_x2 &
                      w_valm_x2;


// Implement round robin or fixed priority
always @ (posedge hclk or negedge n_hreset)
begin : p_next_master

  if ( ~ n_hreset )
    next_master <= 4'h8;
  else
    if ( hready )
    begin
      casex ( priority_bus )

      8'b0000_0001,
      8'b0001_xxxx :
         next_master <= 4'b0001;

      8'b0000_001x,
      8'b001x_xxxx :
         next_master <= 4'b0010;

      8'b0000_01xx,
      8'b01xx_xxxx :
         next_master <= 4'b0100;

      8'b0000_1xxx,
      8'b1xxx_xxxx :
         next_master <= 4'b1000;

      default: // No requesting master
         next_master <= 4'h8;

      endcase

    end

    else

      next_master <= next_master;

end // p_next_master

endmodule
