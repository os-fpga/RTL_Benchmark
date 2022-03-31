`timescale 1ns/100 ps   // time unit = 1ns; precision = 1/10 ns
/* Router
 * Router.v
 *
 * Single N-port Router. NPORTS x NVCS input ports, 1 output port
 *
 * Configuration path:
 *      config_in -> CreditCounter_0 -> ... -> CreditCounter_N (N = nports * nvc) -> config_out
 *      ram_config_in -> Input RouterPortLookup -> Output RouterPortLookup -> ram_config_out
 */
`include "const.v"
module rt_update_flit #(
    parameter VC_WIDTH = 1,
              PORT_WIDTH = 3
)
(
    input   [`TS_WIDTH-1:0]     sim_time,
    input   [`FLIT_WIDTH-1:0]   old_flit,
    input                       old_flit_valid,
    input   [VC_WIDTH-1:0]      saved_vc,
    input   [VC_WIDTH-1:0]      allocated_vc,
    input   [PORT_WIDTH-1:0]    routed_oport,
    output  [`FLIT_WIDTH-1:0]   updated_flit
);
    // New flit timestamp = max (old_flit.timestamp, sim_time) + router_latency (1)
    wire    [`TS_WIDTH-1:0]     w_max_ts;
    wire    [`TS_WIDTH-1:0]     w_routed_ts;
    
    assign w_routed_ts = sim_time + 10'h005;
    

    // Use newly allocated VC if this is a header flit, otherwise inherit VC
    wire    [VC_WIDTH-1:0]      w_routed_vc;
    assign w_routed_vc = (old_flit[`F_HEAD] & old_flit_valid) ? allocated_vc : saved_vc;
    
    
    // Construct new flit
    assign updated_flit[`F_FLAGS] = old_flit[`F_FLAGS];
    assign updated_flit[`F_TS] = w_routed_ts;
    assign updated_flit[`F_DEST] = old_flit[`F_DEST];
    assign updated_flit[`F_SRC_INJ] = old_flit[`F_SRC_INJ];
    assign updated_flit[`F_OPORT] = routed_oport;
    assign updated_flit[`F_OVC] = {1'b0, w_routed_vc};
endmodule

