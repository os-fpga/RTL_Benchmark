`timescale 1ns / 1ps
/* Simple UART RX module (9600 baud rate)
 */
module myuart_rx #(
    parameter BAUD_RATE = 9600
)
(
    input   clock,
    input   reset,
    input   enable,
    output  error,
    input   rx_data_in,
    output  [7:0] data_out,
    output  data_out_valid
);
    localparam RX_IDLE = 0,
               RX_START = 1,
               RX_STOP = 2,
               RX_ERROR = 3;

    // Internal States
    reg     [ 8: 0] rx_word;        // MSB = parity
    reg             rx_word_valid;
    reg     [ 3: 0] rx_bit_count;   // Count the number of bits received

    reg     [ 1: 0] rx_state;
    
    // Wires
    reg     [ 1: 0] next_rx_state;
    reg     [ 8: 0] next_rx_word;   // MSB = parity
    reg             next_rx_word_valid;
    reg     [ 3: 0] next_rx_bit_count;
    
    wire            rx_tick;
    reg             rx_start;       // Indicate a start bit is detected
    
    wire            parity;         // odd parity

    
    // Output
    assign data_out = rx_word;
    assign data_out_valid = rx_word_valid;
    assign error = (rx_state == RX_ERROR) ? 1'b1 : 1'b0;
    
    
    assign parity = ~(rx_word[0]^rx_word[1]^rx_word[2]^rx_word[3]^rx_word[4]^rx_word[5]^rx_word[6]^rx_word[7]);

    // Baud tick generator
    baud_gen #(.BAUD_RATE(BAUD_RATE)) rx_tick_gen (
        .clock (clock),
        .reset (reset),
        .start (rx_start),
        .baud_tick (rx_tick));

        
    // RX register
    always @(posedge clock)
    begin
        if (reset)
        begin
            rx_word <= 8'h00;
            rx_word_valid <= 1'b0;
            rx_bit_count <= 4'h0;
        end
        else if (enable)
        begin
            rx_word <= next_rx_word;
            rx_word_valid <= next_rx_word_valid;
            rx_bit_count <= next_rx_bit_count;
        end
    end
    
    // RX state machine
    always @(posedge clock)
    begin
        if (reset)
            rx_state    <= RX_IDLE;
        else if (enable)
            rx_state    <= next_rx_state;
    end
    
    always @(*)
    begin
        rx_start = 1'b0;
        next_rx_state = rx_state;
        next_rx_word = rx_word;
        next_rx_word_valid = 1'b0;
        next_rx_bit_count = rx_bit_count;
        
        case (rx_state)
            RX_IDLE:
            begin
                if (~rx_data_in)
                begin
                    next_rx_state = RX_START;
                    rx_start = 1'b1;
                end
                next_rx_bit_count = 4'h0;
            end
            
            RX_START:
            begin
                if (rx_tick)
                begin
                    //next_rx_word = {rx_data_in, rx_word[7:1]};  // Shift right
                    next_rx_word = {rx_data_in, rx_word[8:1]};  // Shift right
                    next_rx_bit_count = rx_bit_count + 4'h1;    // Count # of bits
                    
                    //if (rx_bit_count == 4'h8)
                    if (rx_bit_count == 4'h9)                   // 8 bits + 1 bit odd parity
                    begin
                        next_rx_state = RX_STOP;
                    end
                end
            end 
            
            RX_STOP:
            begin
                if (rx_tick)
                begin
                    if (~rx_data_in || (rx_word[8] != parity))
                        // Missing stop bit 1'b1 or incorrect parity
                        next_rx_state = RX_ERROR;
                    else
                    begin
                        next_rx_state = RX_IDLE;
                        next_rx_word_valid = 1'b1;
                    end
                end
            end
        endcase
    end
endmodule
