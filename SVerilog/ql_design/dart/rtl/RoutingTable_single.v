`timescale 1ns/100 ps   // time unit = 1ns; precision = 1/10 ns
/* RoutingTable
 * RoutingTable.v
 *
 * N-context dual-port Routing Table with 256 x 9 bits entries each
 */
`include "const.v"
module RoutingTable_single (
    clock,
    reset,
    enable,
    ram_config_in,
    ram_config_in_valid,
    ram_config_out,
    ram_config_out_valid,
    dest_ina,
    nexthop_outa,
    dest_inb,
    nexthop_outb
);
`include "math.v"

    localparam LOG_TBSIZE = 1 + `ADDR_WIDTH;
    localparam TABLE_SIZE = 1 << LOG_TBSIZE;

    // Global interface
    input           clock;
    input           reset;
    input           enable;

    // RAM configuration interface
    input   [15: 0] ram_config_in;
    input           ram_config_in_valid;
    output  [15: 0] ram_config_out;
    output          ram_config_out_valid;

    // Data interface (port A)
    input    [`ADDR_WIDTH-1: 0] dest_ina;
    output              [ 8: 0] nexthop_outa;
    
    // port B
    input    [`ADDR_WIDTH-1: 0] dest_inb;
    output              [ 8: 0] nexthop_outb;


    // Internal states
    reg         [LOG_TBSIZE: 0] n_words_loaded;

    // Wires
    wire      [LOG_TBSIZE-1: 0] w_waddr;
    wire                        w_config_done;

    // Output
    assign ram_config_out = ram_config_in;
    assign ram_config_out_valid = w_config_done ? ram_config_in_valid : 1'b0;

    assign w_config_done = (n_words_loaded == TABLE_SIZE) ? 1'b1 : 1'b0;
    assign w_waddr = (w_config_done) ? {1'b0, dest_ina} : n_words_loaded[LOG_TBSIZE-1:0];

    // Routing Table
    DualBRAM #(.WIDTH(9), .LOG_DEP(LOG_TBSIZE)) rtable (
        .enable (enable),
        .clock (clock),
        .wen (ram_config_in_valid & ~w_config_done),
        .waddr (w_waddr),
        .raddr ({1'b1, dest_inb}),
        .din (ram_config_in[8:0]),
        .dout (nexthop_outb),
        .wdout (nexthop_outa));


    // Configuration FSM
    always @(posedge clock)
    begin
        if (reset)
            n_words_loaded <= 0;
        else if (ram_config_in_valid & ~w_config_done)
            n_words_loaded <= n_words_loaded + 1;
    end

endmodule

