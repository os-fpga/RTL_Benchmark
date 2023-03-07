/********************************
 * Module: 	axi_wr_if
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
********************************/

interface axi_wr_if
#(
  parameter       IDW = 4,   // Write ID width
  parameter       AW = 32,   // Address Width
  parameter       DW = 64,   // Data Width
  parameter       BLW = 8,   // Burst Length width
//  parameter       USRW = 1,  // User Bits Width
  parameter       LOCKW = 1  // Lock Width
 ) ();


//**** Command Channel
   logic                     awvalid;   //Write Address Valid
   logic [IDW-1:0]           awid;      //Write Address ID
   logic [AW-1:0]            awaddr;    //Write Address
   logic [1:0]               awburst;   //Write Burst type
   logic [BLW-1:0]           awlen;     //Burst Length
   logic [2:0]               awsize;    //Burst Size
   logic [3:0]               awqos;     //Write QOS
   logic [LOCKW-1:0]         awlock;    //Write Lock Type (for AXI4 only use bit0, bit1=0)
   logic [3:0]               awcache;   //Write Cache bits for Memory Type
   logic [2:0]               awprot;    //Write Protection Type
//   logic [3:0]               awregion;  //Write Region Identifier
//   logic [USRW-1:0]          awuser;    //Write User Signals (AXI4 only)
   logic                     awready;   //Write Address Ready

//**** Data Channel
   logic                     wvalid;    //Write Data Valid
   logic [IDW-1:0]           wid;       //Write ID (AXI3 only)
   logic                     wlast;     //Write Last
   logic [DW-1:0]            wdata;     //Write Data
   logic [DW/8-1:0]          wstrb;     //Write Strobe
//   logic [USRW-1:0]          wuser;     //Write Data User Signals (AXI4 only)
   logic                     wready;    //Write Data Ready

//**** Response Channel
   logic                     bready;    //Write Response Ready
   logic                     bvalid;    //Write Response Valid
   logic [1:0]               bresp;     //Write Response
   logic [IDW-1:0]           bid;       //Write Response ID
//   logic [USRW-1:0]          buser;     //Write Response User Signals (AXI4 only)


 modport init (
   output  awvalid,
   output  awid,
   output  awaddr,
   output  awburst,
   output  awlen,
   output  awsize,
   output  awqos,
   output  awlock,
   output  awcache,
   output  awprot,
//   output  awregion,
//   output  awuser,
   output  wvalid,
   output  wid,
   output  wlast,
   output  wdata,
   output  wstrb,
//   output  wuser,
   output  bready,

   input   awready,
   input   wready,
   input   bvalid,
   input   bresp,
//   input   buser,
   input   bid
   );

 modport tgt (
   input   awvalid,
   input   awid,
   input   awaddr,
   input   awburst,
   input   awlen,
   input   awsize,
   input   awqos,
   input   awlock,
   input   awcache,
   input   awprot,
//   input   awregion,
//   input   awuser,
   input   wvalid,
   input   wid,
   input   wlast,
   input   wdata,
   input   wstrb,
//   input   wuser,
   input   bready,

   output  awready,
   output  wready,
   output  bvalid,
   output  bresp,
//   output  buser,
   output  bid
   );


endinterface //   axi_wr_if
