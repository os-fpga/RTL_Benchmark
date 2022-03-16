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
//   Checked In : $Date: 2012-07-23 10:14:16 +0100 (Mon, 23 Jul 2012) $
//   Revision   : $Revision: 215995 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// SIMPLE 32-BIT TO 16-BIT DOWNSIZING AHB-LITE BRIDGE
//-----------------------------------------------------------------------------

//   +--------------------+  32  +--------------------------+  16  +--------+
//   | CPU / INTERCONNECT | ---> | S-PORT   BRIDGE   M-PORT | ---> | MEMORY |
//   +--------------------+      +--------------------------+      +--------+

module cm0p_32to16_dnsize #(
 parameter AW       = 32 // Address width
 )
   (input  wire        HCLK,
    input  wire        HRESETn,

    input  wire [AW-1:0] SHADDR,
    input  wire [ 2:0] SHBURST,
    input  wire        SHMASTLOCK,
    input  wire [ 3:0] SHPROT,
    input  wire        SHREADY,
    input  wire        SHSEL,
    input  wire [ 2:0] SHSIZE,
    input  wire [ 1:0] SHTRANS,
    input  wire [31:0] SHWDATA,
    input  wire        SHWRITE,

    input  wire        SHMASTER,

    output wire [31:0] SHRDATA,
    output wire        SHRESP,
    output wire        SHREADYOUT,

    output wire [AW-1:0] MHADDR,
    output wire [ 2:0] MHBURST,
    output wire        MHMASTLOCK,
    output wire [ 3:0] MHPROT,
    output wire [ 2:0] MHSIZE,
    output wire [ 1:0] MHTRANS,
    output wire [15:0] MHWDATA,
    output wire        MHWRITE,

    output wire        MHMASTER,

    input  wire [15:0] MHRDATA,
    input  wire        MHREADY,
    input  wire        MHRESP);

   // -------------------------------------------------------------------------
   // Declare register state
   // -------------------------------------------------------------------------

   reg  [AW-3:0] addr_q;      // Store for HADDR[31:2] to be used for 2nd read
   reg         addr_valid_q;  // addr_q is valid, need a second HTRANS to slave
   reg  [15:0] rdata_q;       // Buffered rdata for merging to produce word data
   reg         rdata_valid_q; // Data in buffer is valid and should be merged
   reg         write_q;       // Operation is a write
   reg         wlane_q;       // Write-data lane selection
   reg  [ 3:0] prot_q;        // HPROT
   reg         lock_q;        // HMASTLOCK
   reg         master_q;      // HMASTER

   // -------------------------------------------------------------------------
   // Implement logic
   // -------------------------------------------------------------------------

   // Determine if we should register a transaction because it is larger than
   // 16-bits.

   wire        addr_valid_nxt = SHTRANS[1] & SHSIZE[1] & SHSEL & SHREADY;
   wire        addr_valid_en  = SHREADY & addr_valid_nxt | MHREADY & addr_valid_q;

   // --------
   // Register incoming address if a transaction is larger than 16-bits.

   wire [AW-2:0] addr_nxt = SHADDR[AW-1:2];
   wire          addr_en  = SHREADY & SHTRANS[1] & SHSIZE[1] & SHSEL;

   wire [ 3:0]   prot_nxt = SHPROT[3:0];
   wire          prot_en  = addr_en;

   wire          lock_nxt = SHMASTLOCK;
   wire          lock_en  = addr_en;

   wire          master_nxt = SHMASTER;
   wire          master_en  = addr_en;

   // --------
   // The address driven on the master interface is either the incoming address
   // or the previously registered address plus two. As the incoming address
   // must have been word aligned, this is just an OR.

   wire [AW-1:0] addr_inc   = { addr_q[AW-3:0], 2'b10 };
   wire [AW-1:0] addr_out   = addr_valid_q ? addr_inc : SHADDR;

   wire [ 3:0]   prot_out   = addr_valid_q ? prot_q   : SHPROT;
   wire          lock_out   = addr_valid_q ? lock_q   : SHMASTLOCK;
   wire          master_out = addr_valid_q ? master_q : SHMASTER;


   // --------
   // Determine if we should register a transactions data because it needs
   // concatenation before being returned to the master.

   wire        rdata_valid_nxt = addr_valid_q;
   wire        rdata_valid_en  = MHREADY;

   // --------
   // Sample master read data for 32-bit transactions.

   wire [15:0] rdata_nxt = MHRDATA[15:0];
   wire        rdata_en  = MHREADY & addr_valid_q;

   // --------
   // The outgoing HTRANS is always NSEQ or IDLE.

   wire [ 1:0] trans_out = { addr_valid_q | SHTRANS[1] & SHSEL, 1'b0 };

   // --------
   // The outgoing HWRITE is either passed through or the registered write.

   wire        write_out = addr_valid_q ? write_q : SHWRITE;

   wire        write_nxt = SHWRITE;
   wire        write_en  = addr_valid_en & addr_valid_nxt;

   // --------
   // The outgoing HSIZE is either the incoming size reduced to a maximum of
   // halfword, or halfword if performing the second half.

   wire [ 2:0] size_in  = { 2'b0, |SHSIZE[1:0] };
   wire [ 2:0] size_out = addr_valid_q ? 3'b001 : size_in;

   // --------
   // Construct read data either from replicated data from master port, or from
   // the concatenation of the current read data and the registered lower half.

   wire [31:0] rdata_rep = { MHRDATA, MHRDATA };
   wire [31:0] rdata_con = { MHRDATA, rdata_q };

   wire [31:0] rdata_out = rdata_valid_q ? rdata_con : rdata_rep;

   // --------
   // Determine whether HREADY should be reported to the master.

   wire        hready_out = MHREADY & ~addr_valid_q;
   wire        hresp_out  = MHRESP & ~addr_valid_q;

   // --------
   // Extract appropriate write data lane.

   wire [15:0] wdata_out = wlane_q ? SHWDATA[31:16] : SHWDATA[15:0];

   // --------
   // Derive write lane selection.

   wire        wlane_en  = MHREADY & MHTRANS[1] & MHWRITE;
   wire        wlane_nxt = MHADDR[1];

   // -------------------------------------------------------------------------
   // Generate synchronous update logic
   // -------------------------------------------------------------------------

   // Reset control registers.

   always @(posedge HCLK or negedge HRESETn)
     if(~HRESETn)
       addr_valid_q <= 1'b0;
     else if(addr_valid_en)
       addr_valid_q <= addr_valid_nxt;

   always @(posedge HCLK or negedge HRESETn)
     if(~HRESETn)
       rdata_valid_q <= 1'b0;
     else if(rdata_valid_en)
       rdata_valid_q <= rdata_valid_nxt;

   always @(posedge HCLK or negedge HRESETn)
     if(~HRESETn)
       wlane_q <= 1'b0;
     else if(wlane_en)
       wlane_q <= wlane_nxt;

   // Non-reset payload registers.

   always @(posedge HCLK)
     if(addr_en)
       addr_q <= addr_nxt;

   always @(posedge HCLK)
     if(rdata_en)
       rdata_q <= rdata_nxt;

   always @(posedge HCLK)
     if(write_en)
       write_q <= write_nxt;

   always @(posedge HCLK)
     if(prot_en)
       prot_q <= prot_nxt;

   always @(posedge HCLK)
     if(lock_en)
       lock_q <= lock_nxt;

   always @(posedge HCLK)
     if(master_en)
       master_q <= master_nxt;

   // -------------------------------------------------------------------------
   // Assign outputs
   // -------------------------------------------------------------------------

   assign SHRDATA    = rdata_out;
   assign SHRESP     = hresp_out;
   assign SHREADYOUT = hready_out;

   assign MHWRITE    = write_out;
   assign MHWDATA    = wdata_out;
   assign MHSIZE     = size_out;
   assign MHTRANS    = trans_out;
   assign MHADDR     = addr_out;
   assign MHBURST    = 3'b0;
   assign MHPROT     = prot_out;
   assign MHMASTLOCK = lock_out;
   assign MHMASTER   = master_out;

endmodule

// ----------------------------------------------------------------------------
// EOF
// ----------------------------------------------------------------------------
