/********************************
 * Module: 	atb_if
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
********************************/

interface atb_if
#(
  parameter       DW = 32        // Data Width
 ) ();

localparam BYTEW = $clog2( DW/8 ) ;

logic               atready;     // ATB ready
logic               afvalid;     // ATB flush valid
logic               atvalid;     // ATB valid
logic [BYTEW-1:0]   atbytes;     // ATB bytes
logic [DW-1:0]      atdata;      // ATB data
logic [6:0]         atid;        // ATB ID
logic               afready;     // ATB flush ready

 modport init (
    input           atready,     // ATB ready
    input           afvalid,     // ATB flush valid
    output          atvalid,     // ATB valid
    output          atbytes,     // ATB bytes
    output          atdata,      // ATB data
    output          atid,       // ATB ID
    output          afready      // ATB flush ready
   );

 modport tgt (
    output          atready,     // ATB ready
    output          afvalid,     // ATB flush valid
    input           atvalid,     // ATB valid
    input           atbytes,     // ATB bytes
    input           atdata,      // ATB data
    input           atid,        // ATB ID
    input           afready      // ATB flush ready
 );

endinterface  // atb_if
