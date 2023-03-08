/********************************
 * Module: 	ahb_if
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
********************************/

interface ahb_if
#(
  parameter       AW = 32,     // Address Width
  parameter       DW = 32      // Data Width
 ) ();


   logic [AW-1:0]   haddr      ;  //  Address bus.
   logic [2:0]      hburst     ;  //  Burst Type
   logic            hmastlock  ;  //  Master Lock
   logic            hprot      ;  //  Prot
   logic [DW-1:0]   hrdata     ;  //  Read data bus.
   logic            hready     ;  //  Ready
//   logic            hreadysel  ;  //  ReadySel
   logic [1:0]      hresp      ;  //  Response.
   logic            hsel       ;  //  Chip Select.
   logic [2:0]      hsize      ;  //  Access size (byte/word/dword)
   logic [1:0]      htrans     ;  //  Transfer type.
   logic [3:0]      hwbe       ;  //  write byte enable.
   logic [DW-1:0]   hwdata     ;  //  Write data bus. 
   logic            hwrite     ;  //  Write Enable.


modport init (
    output haddr,
    output hburst,
    output hmastlock,
    output hprot,
//    output hreadysel,
    output hsel,
    output hsize,
    output htrans,
    output hwdata,
    output hwrite,

    input  hrdata,
    input  hready,
    input  hresp
   );

 modport tgt (
    input  haddr,
    input  hburst,
    input  hmastlock,
    input  hprot,
//    input  hreadysel,
    input  hsel,
    input  hsize,
    input  htrans,
    input  hwdata,
    input  hwrite,

    output hrdata,
    output hready,
    output hresp
   );


endinterface // ahb_if
