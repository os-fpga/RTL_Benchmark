`timescale 1ns / 1ps
/* mux_Nto1_wrapper.v
 * Wrapper for mux_Nto1 module to test Fmax
 */
module mux_Nto1_wrapper(
    clock,
    reset,
    in,
    sel,
    out
);
    parameter WIDTH = 4;
    parameter SIZE = 8;
    localparam LOG_SIZE = CLogB2(SIZE-1);
    
    input                   clock;
    input                   reset;
    input  [WIDTH*SIZE-1:0] in;
    input    [LOG_SIZE-1:0] sel;
    output                  out;
    
    reg    [WIDTH*SIZE-1:0] r_in;
    reg      [LOG_SIZE-1:0] r_sel_e;
    reg         [WIDTH-1:0] r_out_e;
    reg          [SIZE-1:0] r_sel_d;
    reg         [WIDTH-1:0] r_out_d;
    
    wire        [WIDTH-1:0] w_out_e;
    wire        [WIDTH-1:0] w_out_d;
    wire         [SIZE-1:0] w_sel_d;
    
    assign out = |(r_out_e ^ r_out_d);
    
    // Ceil of log base 2
    function integer CLogB2;
        input   [31:0] size;
        integer i;
        begin
            i = size;
            for (CLogB2 = 0; i > 0; CLogB2 = CLogB2 + 1)
                i = i >> 1;
        end
    endfunction    
    
    mux_Nto1 #(.WIDTH(WIDTH), .SIZE(SIZE)) ute (
        .in (r_in),
        .sel (r_sel_e),
        .out (w_out_e));
    
    mux_Nto1_decoded #(.WIDTH(WIDTH), .SIZE(SIZE)) utd (
        .in (r_in),
        .sel (r_sel_d),
        .out (w_out_d));
        
    decoder_N #(.LOG_SIZE (LOG_SIZE)) dec (
        .encoded (sel),
        .decoded (w_sel_d));

    always @(posedge clock or posedge reset)
    begin
        if (reset)
        begin
            r_in <= 0;
            r_sel_e <= 0;
            r_out_e <= 0;
            r_sel_d <= 0;
            r_out_d <= 0;
        end
        else
        begin
            r_in <= in;
            r_sel_e <= sel;
            r_out_e <= w_out_e;
            r_sel_d <= w_sel_d;
            r_out_d <= w_out_d;
        end
    end
    
endmodule
