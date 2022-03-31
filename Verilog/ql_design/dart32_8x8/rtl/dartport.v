`timescale 1ns / 1ps
/* DART UART ports
 */
module dartport #(
    parameter WIDTH = 16,
              BAUD_RATE = 9600
)
(
    input clock,
    input reset,
    input enable,
    output rx_error,
    output tx_error,
    
    input RS232_RX_DATA,
    output RS232_TX_DATA,
    
    output [WIDTH-1:0]  rx_data,
    output              rx_valid,
    
    input  [WIDTH-1:0]  tx_data,
    input               tx_valid,
    output              tx_ack
);

    localparam N = (WIDTH+7)>>3;    // The number of 8-bit words required
    localparam IDLE = 0, TRANSMITTING = 1;
    
    wire [7:0]  rx_word;
    wire        rx_word_valid;
    
    wire [7:0]  tx_to_fifo_word;
    wire        tx_to_fifo_valid;
    wire        tx_serializer_busy;
    wire [7:0]  tx_word;
    wire        tx_fifo_empty;
    wire        tx_fifo_full;
    wire        tx_start;
    wire        tx_ready;
    
    reg         tx_state;

    // RX Side
    // Receive data from UART (8-bit) and deserialize into WIDTH words
    // Ready words must be consumed immediately
    
    myuart_rx #(.BAUD_RATE(BAUD_RATE)) rx_module (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (rx_error),
        .rx_data_in (RS232_RX_DATA),
        .data_out (rx_word),
        .data_out_valid (rx_word_valid));
    
    deserializer #(.WIDTH(8), .N(N)) rx_deserializer (
        .clock(clock),
		.reset(reset),
		.data_in(rx_word),
		.data_in_valid(rx_word_valid & enable),
		.data_out(rx_data),
		.data_out_valid(rx_valid));
    
    
    // TX Side
    // Receive data from user. The user should not send a new word to the TX
    // module until an ack is received.
    // User data is serialized into 8-bit words before sending out through
    // the UART's TX module
    
    assign tx_ack = tx_valid & ~tx_fifo_full & ~tx_serializer_busy;
    assign tx_start = (tx_state == IDLE) ? (~tx_fifo_empty & tx_ready) : 1'b0;
    
    serializer #(.WIDTH(8), .N(N)) tx_serializer (
        .clock (clock),
        .reset (reset),
        .data_in (tx_data),
        .data_in_valid (tx_valid & enable),
        .data_out (tx_to_fifo_word),
        .data_out_valid (tx_to_fifo_valid),
        .busy (tx_serializer_busy));
    
    // TX FIFO
    fifo_8bit #(.WIDTH(8),.LOG_DEP(16)) tx_buffer (
        .clk (clock),
        .rst (reset),
        .din (tx_to_fifo_word),
        .wr_en (tx_to_fifo_valid & enable),
        .dout (tx_word),
        .rd_en (tx_start & enable),
        .empty (tx_fifo_empty),
        .full (tx_fifo_full));
        
    myuart_tx #(.BAUD_RATE(BAUD_RATE)) tx_module (
        .clock (clock),
        .reset (reset),
        .enable (enable),
        .error (tx_error),
        .data_in (tx_word),
        .tx_start (tx_start),
        .tx_data_out (RS232_TX_DATA),
        .tx_ready (tx_ready));
    
    // State machine that coordinates between tx_buffer and tx_module
    always @(posedge clock)
    begin
        if (reset)
        begin
            tx_state <= IDLE;
        end
        else if (enable)
        begin
            case (tx_state)
                IDLE:
                begin
                    if (~tx_fifo_empty & tx_ready)
                        tx_state <= TRANSMITTING;
                end
                
                TRANSMITTING:
                begin
                    if (tx_ready)
                        tx_state <= IDLE;
                end
            endcase
        end
    end
endmodule
