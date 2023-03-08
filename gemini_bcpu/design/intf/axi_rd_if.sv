/********************************
 * Module: 	axi_rd_if
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
********************************/

interface axi_rd_if
#(
  parameter       IDW    = 4,        // Read  ID Width
  parameter       AW     = 32,       // Address Width
  parameter       DW     = 64,       // Data Width
  parameter       BLW    = 8,        // Burst Length Width
//  parameter       USRW   = 1,        // User Bits Width
  parameter       LOCKW  = 1         // Lock Width
 ) ();


//*****  Command Channel
 logic                     arvalid;   //Read Address Valid
 logic [IDW-1:0]           arid;      //Read ID
 logic [AW-1:0]            araddr;    //Read Address
 logic [1:0]               arburst;   //Read Burst Type
 logic [BLW-1:0]           arlen;     //Burst Length
 logic [2:0]               arsize;    //Burst Size
 logic [3:0]               arqos;     //Read QOS
 logic [LOCKW-1:0]         arlock;    //Read Lock Type (for AXI4 only use bit0, bit1=0)
 logic [3:0]               arcache;   //Read Cache Bits for Memory Type
 logic [2:0]               arprot;    //Read Protection Type
// logic [3:0]               arregion;  //Read Region Identifier
// logic [USRW-1:0]          aruser;    //Read User Signals (AXI4 only)
 logic                     arready;   //Read Address Ready

//*****  Data & Response Channels
 logic                     rvalid;    //Read Data Valid
 logic [IDW-1:0]           rid;       //Read Data ID
 logic                     rlast;     //Read Last
 logic [DW-1:0]            rdata;     //Read Data
 logic [1:0]               rresp;     //Read Response
// logic [USRW-1:0]          ruser;     //Read Data User Signals (AXI4 only)
 logic                     rready;    //Read Data Ready


modport init (
   output   arvalid,
   output   arid,
   output   araddr,
   output   arburst,
   output   arlen,
   output   arsize,
   output   arqos,
   output   arlock,
   output   arcache,
   output   arprot,
//   output   arregion,
//   output   aruser,
   output   rready,
      
   input    rvalid,
   input    rid,
   input    rlast,
   input    rdata,
   input    rresp,
//   input    ruser,
   input    arready
   );

modport tgt (
   input    arvalid,
   input    arid,
   input    araddr,
   input    arburst,
   input    arlen,
   input    arsize,
   input    arqos,
   input    arlock,
   input    arcache,
   input    arprot,
//   input    arregion,
//   input    aruser,
   input    rready,
      
   output   rvalid,
   output   rid,
   output   rlast,
   output   rdata,
   output   rresp,
//   output   ruser,
   output   arready
   );


endinterface //   axi_rd_if
