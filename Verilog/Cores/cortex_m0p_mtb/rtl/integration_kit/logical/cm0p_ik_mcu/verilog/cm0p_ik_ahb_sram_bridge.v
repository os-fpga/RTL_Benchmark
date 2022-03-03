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
//      Checked In          : $Date: 2012-12-13 13:59:25 +0000 (Thu, 13 Dec 2012) $
//
//      Revision            : $Revision: 231538 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// CORTEX-M0+ AMBA-3 AHB-LITE TO EMBEDDED SRAM INTERFACE
// ----------------------------------------------------------------------------
// This block implements an AHB to SRAM bridge interface with zero-wait states.
// Zero-wait state achieved by buffering AHB writes.
// ----------------------------------------------------------------------------

module cm0p_ik_ahb_sram_bridge
  #(parameter AWIDTH = 12)
   (// AHB INTERFACE -------------------------------------------
    input  wire              HCLK,
    input  wire              HRESETn,
    input  wire [31:0]       HADDR,
    input  wire [ 2:0]       HBURST,
    input  wire              HMASTLOCK,
    input  wire [ 3:0]       HPROT,
    input  wire [ 2:0]       HSIZE,
    input  wire [ 1:0]       HTRANS,
    input  wire [31:0]       HWDATA,
    input  wire              HWRITE,
    input  wire              HSEL,
    input  wire              HREADY,
    output wire [31:0]       HRDATA,
    output wire              HREADYOUT,
    output wire              HRESP,

    // EMBEDDED SRAM INTERFACE ---------------------------------
    input  wire [31:0]       RAMRD,           // Read Data
    output wire [AWIDTH-3:0] RAMAD,           // Address
    output wire [31:0]       RAMWD,           // Write Data
    output wire              RAMCS,           // Chip Select
    output wire [ 3:0]       RAMWE            // Write Enable
    );

   // ----------------------------------------------------------
   // Internal state
   // ----------------------------------------------------------

   reg  [ 3:0]               buf_we_q;        // Write enable buffer
                                              // Also tracks pending write
   reg  [AWIDTH-3:0]         buf_waddr_q;     // Write address buffer

   reg  [31:0]               buf_wdata_q;     // Write data buffer
   reg                       buf_wdata_v_q;   // Buffered write data valid

   reg                       buf_hit_q;       // Read hit in write buffer

   // ----------------------------------------------------------
   // Read/write control logic
   // ----------------------------------------------------------

   wire        ahb_access = HSEL & HTRANS[1] & HREADY;
   wire        ahb_write  = ahb_access &  HWRITE;
   wire        ahb_read   = ahb_access & ~HWRITE;

   // Delay RAM write if read needs RAM access
   wire        ram_read   = ahb_read;
   wire        ram_write  = |buf_we_q & ~ram_read;

   // Byte lane decoder
   wire        tx_byte    = ~HSIZE[1] & ~HSIZE[0];
   wire        tx_half    = ~HSIZE[1] &  HSIZE[0];
   wire        tx_word    =  HSIZE[1];

   wire        byte_at_00 = tx_byte & ~HADDR[1] & ~HADDR[0];
   wire        byte_at_01 = tx_byte & ~HADDR[1] &  HADDR[0];
   wire        byte_at_10 = tx_byte &  HADDR[1] & ~HADDR[0];
   wire        byte_at_11 = tx_byte &  HADDR[1] &  HADDR[0];

   wire        half_at_00 = tx_half & ~HADDR[1];
   wire        half_at_10 = tx_half &  HADDR[1];

   wire        word_at_00 = tx_word;

   wire        byte_sel_0 = word_at_00 | half_at_00 | byte_at_00;
   wire        byte_sel_1 = word_at_00 | half_at_00 | byte_at_01;
   wire        byte_sel_2 = word_at_00 | half_at_10 | byte_at_10;
   wire        byte_sel_3 = word_at_00 | half_at_10 | byte_at_11;

   wire [3:0]  byte_sels  = {byte_sel_3, byte_sel_2, byte_sel_1, byte_sel_0};

   // Capture write enable and address on AHB write address phase.
   // Buffered write enable then used to track pending write.
   wire        buf_we_en  = ahb_write | ram_write;
   wire [3:0]  buf_we_nxt = {4{ahb_write}} & byte_sels;

   // Capture write data on AHB write data phase if can't write to RAM now.
   wire        buf_wdata_en    = |buf_we_q & ram_read & ~buf_wdata_v_q;

   wire        buf_wdata_v_en  = buf_wdata_en | ram_write;
   wire        buf_wdata_v_nxt = buf_wdata_en;

   // ----------------------------------------------------------
   // Read data merge : This is for the case when there is a AHB
   // write followed by AHB read to the same address. In this case
   // the data is merged from the buffer as the RAM write to that
   // address hasn't happened yet
   // ----------------------------------------------------------

   wire        buf_hit_nxt = (HADDR[AWIDTH-1:2] == buf_waddr_q[AWIDTH-3:0]);

   wire [ 3:0] merge       = {4{buf_hit_q}} & buf_we_q;

   wire [31:0] ahb_rdata   = { merge[3] ? buf_wdata_q[31:24] : RAMRD[31:24],
                               merge[2] ? buf_wdata_q[23:16] : RAMRD[23:16],
                               merge[1] ? buf_wdata_q[15: 8] : RAMRD[15: 8],
                               merge[0] ? buf_wdata_q[ 7: 0] : RAMRD[ 7: 0] };

   // ----------------------------------------------------------
   // Synchronous state update
   // ----------------------------------------------------------

   always @(posedge HCLK or negedge HRESETn)
     if(~HRESETn)
       buf_we_q <= 4'b0000;
     else if(buf_we_en)
       buf_we_q <= buf_we_nxt;

   always @(posedge HCLK)
     if(ahb_write)
       buf_waddr_q <= HADDR[AWIDTH-1:2];

   always @(posedge HCLK)
     if(buf_wdata_en & buf_we_q[3])
       buf_wdata_q[31:24] <= HWDATA[31:24];

   always @(posedge HCLK)
     if(buf_wdata_en & buf_we_q[2])
       buf_wdata_q[23:16] <= HWDATA[23:16];

   always @(posedge HCLK)
     if(buf_wdata_en & buf_we_q[1])
       buf_wdata_q[15: 8] <= HWDATA[15: 8];

   always @(posedge HCLK)
     if(buf_wdata_en & buf_we_q[0])
       buf_wdata_q[ 7: 0] <= HWDATA[ 7: 0];

   always @(posedge HCLK or negedge HRESETn)
     if(~HRESETn)
       buf_wdata_v_q <= 1'b0;
     else if(buf_wdata_v_en)
       buf_wdata_v_q <= buf_wdata_v_nxt;

   always @(posedge HCLK)
     if(ahb_read)
       buf_hit_q <= buf_hit_nxt;

   // ----------------------------------------------------------
   // RAM interface
   // ----------------------------------------------------------

   // RAM chip select high if AHB Read or RAM write
   wire        ram_cs       = ram_read | ram_write;
   // RAM WE is buffered WE for writes, zero for reads
   wire [ 3:0] ram_we       = {4{ram_write}} & buf_we_q[3:0];
   // RAM address is HADDR for reads, buffered address for writes
   wire [AWIDTH-3:0] ram_ad = ram_read ? HADDR[AWIDTH-1:2] : buf_waddr_q;
   // RAM write data is buffered data if valid, otherwise HWDATA
   wire [31:0] ram_wd       = buf_wdata_v_q ? buf_wdata_q : HWDATA[31:0];

   // ----------------------------------------------------------
   // Assign outputs
   // ----------------------------------------------------------

   assign HRDATA    = ahb_rdata;
   assign HREADYOUT = 1'b1;
   assign HRESP     = 1'b0;

   assign RAMWD     = ram_wd;
   assign RAMCS     = ram_cs;
   assign RAMWE     = ram_we;
   assign RAMAD     = ram_ad;


endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
