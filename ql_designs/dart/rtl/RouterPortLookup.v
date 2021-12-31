`timescale 1 ns/100 ps // time unit = 1ns; precision = 1/10 ns
/* Router Port Lookup Table
 * RouterPortLookup.v
 *
 * Implement a small distributed RAM-based lookup table that converts
 * Router port ID (3-bit) into physical node addresses (8-bit)
 *
 * Configuration path
 *      ram_config_in -> table -> ram_config_out
 */
`include "const.v"
module RouterPortLookup (
    clock,
    reset,
    ram_config_in,
    ram_config_in_valid,
    ram_config_out,
    ram_config_out_valid,
    port_id_a,
    haddr_a,
    port_id_b,
    haddr_b
);
`include "math.v"

    parameter NPORTS = 5;
    parameter WIDTH = 8;
    localparam LOG_NPORTS = CLogB2(NPORTS-1);

    // Global interface
    input           clock;
    input           reset;

    // RAM configuration interface
    input   [15: 0] ram_config_in;
    input           ram_config_in_valid;
    output  [15: 0] ram_config_out;
    output          ram_config_out_valid;

    // Data interface
    input     [LOG_NPORTS-1: 0] port_id_a;
    output         [WIDTH-1: 0] haddr_a;
    input     [LOG_NPORTS-1: 0] port_id_b;
    output         [WIDTH-1: 0] haddr_b;


    // Internal states
    reg       [LOG_NPORTS-1: 0] n_words_loaded;

    // Wires
    wire      [LOG_NPORTS-1: 0] w_ram_addr;
    wire                        w_config_done;


    // Output
    assign ram_config_out = ram_config_in;
    assign ram_config_out_valid = w_config_done ? ram_config_in_valid : 1'b0;
    
    assign w_config_done = (n_words_loaded == NPORTS) ? 1'b1 : 1'b0;


    // Config chain requires WIDTH <= 16
    // psl ERROR_distroRAM_width: assert always {WIDTH <= 16};


    // Lookup RAM
    assign w_ram_addr = (w_config_done) ? port_id_a : n_words_loaded[LOG_NPORTS-1:0];
    DistroRAM #(.WIDTH(WIDTH), .LOG_DEP(LOG_NPORTS)) port_table (
        .clock (clock),
        .wen (ram_config_in_valid & ~w_config_done),
        .waddr (w_ram_addr),
        .raddr (port_id_b),
        .din (ram_config_in[WIDTH-1:0]),
        .wdout (haddr_a),
        .rdout (haddr_b));

    // Configuration FSM
    always @(posedge clock)
    begin
        if (reset)
            n_words_loaded <= 0;
        else if (ram_config_in_valid & ~w_config_done)
            n_words_loaded <= n_words_loaded + 1;
    end

endmodule

