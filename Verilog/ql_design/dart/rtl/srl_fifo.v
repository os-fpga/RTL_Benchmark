`timescale 1ns / 1ps
/* SRL16 based FIFO
 *
 * Verilog version adapted from OpenCores SRL FIFO project
 * http://www.opencores.org/project,srl_fifo
 */
module srl_fifo (
    clock,
    reset,
    data_in,
    data_out,
    write,
    read,
    full,
    empty
);
    parameter WIDTH = 11;
    parameter LOG_DEP = 4;
    localparam LENGTH = 1 << LOG_DEP;
    
    input                clock;
    input                reset;
    input   [WIDTH-1: 0] data_in;
    output  [WIDTH-1: 0] data_out;
    input                write;
    input                read;
    output               full;
    output               empty;
    
    
    // Control signals
    wire                 pointer_zero;
    wire                 pointer_full;
    wire                 valid_write;
    wire                 valid_count;
    
    reg                  empty;
    reg   [LOG_DEP-1: 0] pointer;
    
    // Output
    assign full = pointer_full;
    
    // SRL
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1)
        begin : srl_array
            reg [LENGTH-1: 0] item;
            
            always @(posedge clock)
            begin
                if (valid_write)
                    item <= {item[LENGTH-2:0], data_in[i]};
            end
            
            // Output
            assign data_out[i] = item[pointer];
        end
    endgenerate
    
    // Valid write, high when valid to write data to the FIFO
    assign valid_write = ((read & write) | (write & ~pointer_full));
    
    // Empty state
    always @ (posedge clock)
    begin
        if (reset)
            empty <= 1'b1;
        else if (empty & write)
            empty <= 1'b0;
        else if (pointer_zero & read & ~write)
            empty <= 1'b1;
    end
    
    // W   R   Action
    // 0   0   pointer <= pointer
    // 0   1   pointer <= pointer - 1
    // 1   0   pointer <= pointer + 1
    // 1   1   pointer <= pointer
    
    assign valid_count = (write & ~read & ~pointer_full & ~empty) | (~write & read & ~pointer_zero);
    
    always @(posedge clock)
    begin
        if (reset)
            pointer <= 0;
        else if (valid_count)
            if (write)
                pointer <= pointer + 1;
            else
                pointer <= pointer - 1;
    end
    
    // Detect when pointer is zero and maximum
    assign pointer_zero = (pointer == 0) ? 1'b1 : 1'b0;
    assign pointer_full = (pointer == LENGTH - 1) ? 1'b1 : 1'b0;
    
endmodule
