/* util.v
 *
 * This file contains globally accessed functions that can be included
 * in any Verilog modules.
 */

/* Get flit timestamp
 */
`include "const.v"
 
function [9:0] flit_ts;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_ts = flit[32:23];
endfunction

/* Get flit destination
 */
function [7:0] flit_dest;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_dest = flit[22:15];
endfunction

/* Get flit source
 */
function [7:0] flit_source;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_source = flit[14:7];
endfunction

/* Get flit injection timestamp
 */
function [9:0] flit_inject_ts;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_inject_ts = flit[14:5];
endfunction

/* Return the head flag
 */
function flit_is_head;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_is_head = flit[35];
endfunction

/* Return the tail flag
 */
function flit_is_tail;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_is_tail = flit[34];
endfunction

/* Return the measurement flag
 */
function flit_is_measurement;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_is_measurement = flit[33];
endfunction

/* Return the port
 */
function [2:0] flit_port;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_port = flit[4:2];
endfunction

/* Return the port VC
 */
function flit_vc;
    input   [`FLIT_WIDTH-1: 0] flit;
    flit_vc = flit[0];
endfunction

/* Form flit with new timestamp
 */
function [`FLIT_WIDTH-1:0] update_flit_ts;
    input   [`FLIT_WIDTH-1:0] old_flit;
    input   [`TS_WIDTH-1:0] new_ts;
    update_flit_ts = {old_flit[35:33], new_ts, old_flit[22:0]};
endfunction

/* Form flit with new port and VC
 */
function [`FLIT_WIDTH-1:0] update_flit_port;
    input   [`FLIT_WIDTH-1:0] old_flit;
    input   [ 2: 0] new_oport;
    input   [ 1: 0] new_vc;
    update_flit_port = {old_flit[35:5], new_oport, new_vc};
endfunction

/* Get credit timestamp
 */
function [9:0] credit_ts;
    input   [`CREDIT_WIDTH-1:0] credit;
    credit_ts = credit[9:0];
endfunction

/* Get credit VC
 */
function credit_vc;
    input   [`CREDIT_WIDTH-1:0] credit;
    credit_vc = credit[10];
endfunction

/* Assemble credit flit from individual components
 */
function [`CREDIT_WIDTH-1:0] assemble_credit;
    input                   vc;
    input   [`TS_WIDTH-1:0] ts;
    assemble_credit = {vc, ts};
endfunction

/* Form credit flit with new timestamp
 */
function [`CREDIT_WIDTH-1:0] update_credit_ts;
    input   [`CREDIT_WIDTH-1:0] old_credit;
    input   [`TS_WIDTH-1:0] new_ts;
    update_credit_ts = {old_credit[10], new_ts};
endfunction

