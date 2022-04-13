`timescale 1ns / 1ps
/* 2-to-1 serializer and deserializer
 */
 
/* Deserializer acknolwedges the narrower data_in immediately
 */
module deserializer #(
    parameter WIDTH = 8,    // Width of each data chunk
    parameter N = 2         // Number of data chunks to deserialize
)
(
    input                   clock,
    input                   reset,
    input  [WIDTH-1:0]      data_in,
    input                   data_in_valid,
    output [WIDTH*N-1:0]    data_out,
    output                  data_out_valid
);
    `include "math.v"
    
    // Internal states
    reg [WIDTH*N-1:0]       data_store;
    reg [CLogB2(N-1)-1:0]   data_chunk_count;
    reg                     data_store_valid;
    
    // Output
    assign data_out = data_store;
    assign data_out_valid = data_store_valid;
    
    always @(posedge clock)
    begin
        if (reset)
        begin
            data_store <= {(WIDTH*N){1'b0}};
            data_chunk_count <= 1'b0;
            data_store_valid <= 1'b0;
        end
        else
        begin
            if (data_in_valid)
            begin
                // Right shift to deserialize
                data_store <= {data_in, data_store[WIDTH*N-1:WIDTH]};
                
                if (data_chunk_count == N-1)
                    data_chunk_count <= 0;
                else
                    data_chunk_count <= data_chunk_count + 1'b1;
            end
            
            // We have received all data chunks
            if (data_chunk_count == N-1 && data_in_valid == 1'b1)
                data_store_valid <= 1'b1;
            else
                data_store_valid <= 1'b0;
        end
    end
endmodule


/* Serializer acknowledges the wider data_in when it starts processing the word
 */
module serializer #(
    parameter WIDTH = 8,    // Width of each data chunk
    parameter N = 2         // Number of data chunks to serialize
)
(
    input                   clock,
    input                   reset,
    input  [WIDTH*N-1:0]    data_in,
    input                   data_in_valid,
    output [WIDTH-1:0]      data_out,
    output reg              data_out_valid,
    output                  busy
);
    localparam IDLE = 0,
               BUSY = 1;

    `include "math.v"
    
    // Internal states
    reg [WIDTH*N-1:0]       data_store;
    reg [CLogB2(N-1)-1:0]   data_chunk_count;
    reg                     state;
    
    assign data_out = data_store[WIDTH-1:0];
    assign busy = (state == IDLE) ? 1'b0 : 1'b1;
    
    always @(posedge clock)
    begin
        if (reset)
        begin
            data_store <= {(WIDTH*N){1'b0}};
            data_chunk_count <= 0;
            state <= IDLE;
        end
        else
        begin
            case (state)
                IDLE:
                begin
                    if (data_in_valid)
                    begin
                        data_store <= data_in;
                        data_chunk_count <= data_chunk_count + 1;
                        data_out_valid <= 1'b1;
                        state <= BUSY;
                    end
                    else
                        data_out_valid <= 1'b0;
                end
                
                BUSY:
                begin
                    data_store <= {{(WIDTH-1){1'b0}}, data_store[WIDTH*N-1:WIDTH]};
                    data_chunk_count <= data_chunk_count + 1;
                    data_out_valid <= 1'b1;
                    
                    if (data_chunk_count == N-1)
                        state <= IDLE;
                end
            endcase
        end
    end
endmodule
