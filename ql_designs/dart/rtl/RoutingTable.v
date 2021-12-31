`timescale 1ns/100 ps   // time unit = 1ns; precision = 1/10 ns
/* RoutingTable
 * RoutingTable.v
 *
 * N-context dual-port Routing Table with 256 x 9 bits entries each
 */
`include "const.v"
module RoutingTable (
    clock,
    reset,
    enable,
    ram_config_in,
    ram_config_in_valid,
    ram_config_out,
    ram_config_out_valid,
    ccid_ina,
    dest_ina,
    ccid_outa,
    nexthop_outa,
    ccid_inb,
    dest_inb,
    ccid_outb,
    nexthop_outb
);
`include "math.v"

    parameter LOG_CTX = 3;          // Specify number of contexts
    localparam LOG_TBSIZE = 1 + LOG_CTX + `ADDR_WIDTH;
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
    input        [LOG_CTX-1: 0] ccid_ina;
    input    [`ADDR_WIDTH-1: 0] dest_ina;
    output       [LOG_CTX-1: 0] ccid_outa;
    output              [ 8: 0] nexthop_outa;
    
    // port B
    input        [LOG_CTX-1: 0] ccid_inb;
    input    [`ADDR_WIDTH-1: 0] dest_inb;
    output       [LOG_CTX-1: 0] ccid_outb;
    output              [ 8: 0] nexthop_outb;


    // Internal states
    reg         [LOG_TBSIZE: 0] n_words_loaded;
    reg          [LOG_CTX-1: 0] r_ccida;
    reg          [LOG_CTX-1: 0] r_ccidb;

    // Wires
    wire      [LOG_TBSIZE-1: 0] w_waddr;
	wire						w_config_done;

    // Output
    assign ram_config_out = ram_config_in;
    assign ram_config_out_valid = w_config_done ? ram_config_in_valid : 1'b0;
    assign ccid_outa = r_ccida;             // Match 1-cycle latency of RAM reading
    assign ccid_outb = r_ccidb;

	assign w_config_done = (n_words_loaded == TABLE_SIZE) ? 1'b1 : 1'b0;
	assign w_waddr = (w_config_done) ? {1'b0, dest_ina} : n_words_loaded[LOG_TBSIZE-1:0];

    // Routing Table
    DualBRAM #(.WIDTH(9), .LOG_DEP(LOG_TBSIZE)) rtable (
        .clock (clock),
        .wen (ram_config_in_valid & ~w_config_done),
        .waddr (w_waddr),
        .raddr ({1'b1, ccid_inb, dest_inb}),
        .din (ram_config_in[8:0]),
        .dout (nexthop_outb),
        .wdout (nexthop_outa));

    // Pipeline register for cc_id
    always @(posedge clock or posedge reset)
    begin
        if (reset)
        begin
            r_ccida <= 0;
            r_ccidb <= 0;
        end
        else if (enable)
        begin
            r_ccida <= ccid_ina;
            r_ccidb <= ccid_inb;
        end
    end

    // Configuration FSM
    always @(posedge clock or posedge reset)
    begin
        if (reset)
            n_words_loaded <= 0;
        else if (ram_config_in_valid & ~w_config_done)
            n_words_loaded <= n_words_loaded + 1;
    end

endmodule

