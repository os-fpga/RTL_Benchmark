`timescale 1ns / 1ps
/* RAMFIFO_ctrl_lfsr_dc.v
 * LFSR-based control for RAMFIFO, assuming that the RAMFIFO
 * has an output register that stores the first element
 */
module RAMFIFO_ctrl_lfsr_dc (
    clock,
    reset,
    enable,
    write,
    read,
    full,
    empty,
    ram_wen,
    ram_waddr,
    ram_raddr
);
    parameter WIDTH = 36;
    parameter LOG_DEP = 6;
    localparam DEPTH = 1 << LOG_DEP;
    
    input                   clock;
    input                   reset;
    input                   enable;
    input                   write;
    input                   read;
    
    output                  full;
    output                  empty;
    output                  ram_wen;
    output    [LOG_DEP-1:0] ram_waddr;
    output    [LOG_DEP-1:0] ram_raddr;

    // Control signals
    wire                valid_write;
    wire                valid_read;
    wire                next_head_is_tail;
    wire  [LOG_DEP-1:0] next_head;
    wire  [LOG_DEP-1:0] head;
    wire  [LOG_DEP-1:0] tail;
    
    reg                 empty;
    
    // Output
    assign full = (head == tail && empty == 1'b0) ? 1'b1 : 1'b0;
    assign ram_wen = valid_write;
    assign ram_waddr = tail;
    assign ram_raddr = next_head;

    // Valid write, high when valid to write data to the FIFO
    assign valid_write = enable & ((read & write) | (write & ~full));
    assign valid_read = enable & (read & ~empty);
    
    // Empty state
    always @(posedge clock or posedge reset)
    begin
        if (reset)
            empty <= 1'b1;
        else if (enable & empty & write)
            empty <= 1'b0;
        else if (enable & read & ~write & next_head_is_tail)
            empty <= 1'b1;
    end
    
    // Head LFSR (where to read)
    LFSR3_9 #(.LENGTH(LOG_DEP), .FULL_CYCLE(1)) lfsr_head (
            .clock (clock),
            .reset (reset),
            .enable (valid_read),
            .dout (head),
            .dout_next (next_head));
    
    // Tail LFSR (where to write)
    LFSR3_9 #(.LENGTH(LOG_DEP), .FULL_CYCLE(1)) lfsr_tail (
            .clock (clock),
            .reset (reset),
            .enable (valid_write),
            .dout (tail),
            .dout_next ());
    
    assign next_head_is_tail = (next_head == tail) ? 1'b1 : 1'b0;

    // TODO
    reg [15: 0] size;
    always @(posedge clock or posedge reset)
    begin
        if (reset)
            size <= 16'h0000;
        else
        begin
            if (read & ~write)
                size <= size - 1;
            else if (write & ~read)
                size <= size + 1;
        end
    end
endmodule

