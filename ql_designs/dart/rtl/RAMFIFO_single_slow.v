`timescale 1ns / 1ps

/* RAMFIFO_single.v
 * Block RAM based FIFO (single context)
 * If FIFO is empty, the new data appears at the output after 2
 * clock cycle. Read signal dequeues the head of the FIFO.
 */

module RAMFIFO_single_slow #(
    parameter WIDTH = 36,
    parameter LOG_DEP = 4
)
(
    input               clock,
    input               reset,
    input               enable,
    
    input   [WIDTH-1:0] data_in,
    output  [WIDTH-1:0] data_out,
    
    input               write,
    input               read,
    output              full,
    output              empty,
    output              has_data
);
    localparam DEPTH = 1 << LOG_DEP;
    
    wire                ram_wen;
    wire  [LOG_DEP-1:0] ram_waddr;
    wire  [LOG_DEP-1:0] ram_raddr;
    wire    [WIDTH-1:0] ram_dout;
    wire                w_empty;
    wire                w_full;

    reg     [WIDTH-1:0] s1_dout;
    reg                 s2_empty; 
    reg                 rbusy; // Ensure read only registered in the 1st half cycle of the slow clock
    
    wire fifo_read;
    wire fifo_write;

    assign data_out = s1_dout;
    assign has_data = ~s2_empty & ~rbusy;
    assign empty = s2_empty;
    assign full = w_full;
    
    assign fifo_read = enable & read & has_data;
    assign fifo_write = enable & write & (~full);

    always @(posedge clock)
    begin
        if (reset)
        begin
            rbusy <= 1'b0;
            s2_empty <= 1'b1;
        end
        else if (enable)
        begin
            if (rbusy)  rbusy <= 1'b0;
            else        rbusy <= fifo_read;
            
            // Delay empty so it shows up 2 cycles after read to match dout
            s2_empty <= w_empty;
        end
    end

    // RAM control (1-cycle latency)
    RAMFIFO_ctrl_lfsr #(.LOG_DEP(LOG_DEP)) ctrl (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .write (fifo_write), // caller is responsible for making sure write is only high for 1 cycle
        .read (fifo_read),
        .full (w_full),
        .empty (w_empty),
        .ram_wen (ram_wen),
        .ram_waddr (ram_waddr),
        .ram_raddr (),
        .ram_raddr_next (ram_raddr));

    // RAM storage
    DualBRAM #(.WIDTH(WIDTH), .LOG_DEP(LOG_DEP)) ram (
        .clock (clock),
        .enable (enable),
        .wen (ram_wen),
        .waddr (ram_waddr),
        .raddr (ram_raddr),
        .din (data_in),
        .dout (ram_dout),
        .wdout ());

    // First stage output register at posedge of clock
    always @(posedge clock)
    begin
        if (reset)
            s1_dout <= {(WIDTH){1'b0}};
        else if (enable)
        begin
            if (write & w_empty)
                s1_dout <= data_in;
            else if (rbusy)
                s1_dout <= ram_dout;
        end
    end
endmodule

