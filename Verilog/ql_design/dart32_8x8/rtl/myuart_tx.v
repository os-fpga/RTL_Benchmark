`timescale 1ns / 1ps
/* Simple UART TX module (9600 baud rate)
 */
module myuart_tx # (
    parameter BAUD_RATE = 9600
)
(
    input   clock,
    input   reset,
    input   enable,
    output  error,
    input   [7:0] data_in,
    input   tx_start,
    output  tx_ready,
    output  tx_data_out
);
    localparam TX_IDLE = 0,
               TX_START = 1,
               TX_STOP = 2,
               TX_ERROR = 3;
    
    // Internal States
    reg             tx_bit;
    reg     [ 8: 0] tx_word;
    reg     [ 3: 0] tx_bit_count;   // Count the number of bits sent
    
    reg     [ 1: 0] tx_state;
    
    // Wires
    reg     [ 1: 0] next_tx_state;
    reg             next_tx_bit;
    reg     [ 3: 0] next_tx_bit_count;
    reg     [ 8: 0] next_tx_word;
    
    wire            tx_tick;
    wire            parity;         // odd parity
    
    // Output
    assign tx_data_out = tx_bit;
    assign tx_ready = (tx_state == TX_IDLE) ? 1'b1 : 1'b0;
    assign error = (tx_state == TX_ERROR) ? 1'b1 : 1'b0;
    
    
    assign parity = ~(data_in[0]^data_in[1]^data_in[2]^data_in[3]^data_in[4]^data_in[5]^data_in[6]^data_in[7]);
    
    // Baud tick generator
    baud_gen #(.BAUD_RATE(BAUD_RATE)) tx_tick_gen (
        .clock (clock),
        .reset (tx_start),
        .start (tx_start),
        .baud_tick (tx_tick));
    
    // TX registers
    always @(posedge clock)
    begin
        if (reset)
        begin
            tx_bit          <= 1'b1;
            tx_bit_count    <= 4'h0;
            tx_word         <= 8'h00;
        end
        else if (enable)
        begin
            if (tx_start)
                tx_word     <= {parity, data_in};
            else
                tx_word     <= next_tx_word;
            
            tx_bit <= next_tx_bit;
            tx_bit_count <= next_tx_bit_count;
        end
    end
    
    // TX state machine
    always @(posedge clock)
    begin
        if (reset)
            tx_state    <= TX_IDLE;
        else if (enable)
            tx_state    <= next_tx_state;
    end
    
    always @(*)
    begin
        next_tx_state = tx_state;
        next_tx_bit = tx_bit;
        next_tx_bit_count = tx_bit_count;
        next_tx_word = tx_word;
        
        case (tx_state)
            TX_IDLE:
            begin
                if (tx_start)
                begin
                    next_tx_bit = 1'b0;     // Start bit
                    next_tx_state = TX_START;
                end
                next_tx_bit_count = 4'h0;
            end
            
            TX_START:
            begin
                if (tx_start)
                begin
                    next_tx_state = TX_ERROR;
                end
                else if (tx_tick)
                begin
                    {next_tx_word, next_tx_bit} = {1'b1, tx_word}; // Right shift out the bits
                    next_tx_bit_count = tx_bit_count + 4'h1;
                    
                    //if (tx_bit_count == 4'h8)
                    if (tx_bit_count == 4'h9)       // 8 bits data + 1 bit parity
                        next_tx_state = TX_STOP;
                end
            end
            
            TX_STOP:
            begin
                if (tx_tick)
                    next_tx_state = TX_IDLE;
            end
        endcase
    end

endmodule
