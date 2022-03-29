`timescale 1ns / 1ps

/* RAMFIFO.v
 * Block RAM based FIFO
 * If FIFO is empty, the new data appears at the output after 2
 * clock cycles. Read signal dequeues the head of the FIFO.
 */

module RAMFIFO_slow (
    clock,
    reset,
    enable,
    wcc_id,
    rcc_id,
    data_in,
    data_out,
    write,
    read,
    full,
    empty,
    has_data,
    error
);
    parameter WIDTH = 36;
    parameter LOG_DEP = 6;          // 64 elements
    parameter LOG_CTX = 3;
    localparam DEPTH = 1 << LOG_DEP;
    localparam NUM_CTX = 1 << LOG_CTX;
    
    input                       clock;
    input                       reset;
    input                       enable;
    input         [LOG_CTX-1:0] wcc_id;      // Select context to write
    input         [LOG_CTX-1:0] rcc_id;      // Select context to read for reading
    input           [WIDTH-1:0] data_in;
    input                       write;
    input                       read;
    
    output  [NUM_CTX*WIDTH-1:0] data_out;
    output        [NUM_CTX-1:0] full;
    output        [NUM_CTX-1:0] empty;
    output        [NUM_CTX-1:0] has_data;
    output                      error;

    wire                        ram_wen;
    wire          [LOG_DEP-1:0] ram_waddr;
    wire          [LOG_DEP-1:0] ram_raddr;
    wire            [WIDTH-1:0] ram_dout;   // Regular read
    
    wire          [NUM_CTX-1:0] wen_all;
    wire  [NUM_CTX*LOG_DEP-1:0] waddr_all;
    wire  [NUM_CTX*LOG_DEP-1:0] raddr_all;
    wire          [NUM_CTX-1:0] w_empty;
    wire          [NUM_CTX-1:0] w_full;
    wire          [NUM_CTX-1:0] w_fifo_error;

    wire          [NUM_CTX-1:0] w_write_en;
    wire          [NUM_CTX-1:0] w_read_en;
    wire          [NUM_CTX-1:0] w_write;
    wire          [NUM_CTX-1:0] w_read;
    wire          [NUM_CTX-1:0] w_enable;

	// Internal states
    reg           [NUM_CTX-1:0] rbusy;
    reg           [NUM_CTX-1:0] s2_empty;

    // Output
    assign empty = s2_empty;
    assign full = w_full;
    assign has_data = ~s2_empty & ~rbusy;
    assign error = |w_fifo_error;
    
    
    // Context decoder
    wire [NUM_CTX-1:0] wcc_id_decoded;
    wire [NUM_CTX-1:0] rcc_id_decoded;
    
    assign w_enable = w_write_en | w_read_en;
    assign w_write_en = (enable) ? wcc_id_decoded : {(NUM_CTX){1'b0}};
    assign w_read_en = (enable) ? rcc_id_decoded : {(NUM_CTX){1'b0}};
    
    decoder_N #(.SIZE(NUM_CTX)) wcc_decoder (
            .encoded (wcc_id),
            .decoded (wcc_id_decoded));

    decoder_N #(.SIZE(NUM_CTX)) rcc_decoder (
            .encoded (rcc_id),
            .decoded (rcc_id_decoded));

    
    // RAM control, one for each context (LFSR-based, 50% smaller than counter based)
    genvar i;
    generate
        for (i = 0; i < NUM_CTX; i = i + 1)
        begin : ram_ctrl
            reg [WIDTH-1:0] s1_dout;
            
            assign w_fifo_error[i] = (w_write[i] & full[i]) | (w_read[i] & empty[i]);
            assign w_write[i] = w_write_en[i] & write & (~full[i]);
            assign w_read[i] = w_read_en[i] & read & has_data[i];

            RAMFIFO_ctrl_lfsr #(.LOG_DEP(LOG_DEP)) ctrl (
                .clock (clock),
                .reset (reset),
                .enable (w_enable[i]),
                .write (w_write[i]),
                .read (w_read[i]),
                .full (w_full[i]),
                .empty (w_empty[i]),
                .ram_wen (wen_all[i]),
                .ram_waddr (waddr_all[(i+1)*LOG_DEP-1:i*LOG_DEP]),
                .ram_raddr (),
                .ram_raddr_next (raddr_all[(i+1)*LOG_DEP-1:i*LOG_DEP]));
                
            always @(posedge clock)
            begin
                if (reset)
                begin
                    rbusy[i] <= 1'b0;
                    s2_empty[i] <= 1'b1;
                end
                else if (enable)
                begin
                    if (rbusy[i])   rbusy[i] <= 1'b0;
                    else            rbusy[i] <= w_read[i];
                    
                    s2_empty[i] <= w_empty[i];
                end
            end
              
            // Output registers
            always @(posedge clock)
            begin
                if (reset)
                begin
                    s1_dout <= {(WIDTH){1'b0}};
                end
                else if (enable)
                begin
                    if (w_write[i] & w_empty[i])
                        s1_dout <= data_in;
                    else if (rbusy[i])
                        s1_dout <= ram_dout;
                end
            end

            assign data_out[(i+1)*WIDTH-1:i*WIDTH] = s1_dout;
        end
    endgenerate
    
    // Multiplexer to select the control signals for the specified context
    assign ram_wen = |wen_all;
    
    mux_Nto1 #(.WIDTH(LOG_DEP), .SIZE(NUM_CTX)) ram_waddr_mux (
            .in (waddr_all),
            .sel (wcc_id),
            .out (ram_waddr));
    
    mux_Nto1 #(.WIDTH(LOG_DEP), .SIZE(NUM_CTX)) ram_raddr_mux (
            .in (raddr_all),
            .sel (rcc_id),
            .out (ram_raddr));

    // RAM storage
    DualBRAM #(.WIDTH(WIDTH), .LOG_DEP(LOG_DEP + LOG_CTX)) ram (
            .clock (clock),
            .enable (enable),
            .wen (ram_wen),
            .waddr ({wcc_id, ram_waddr}),
            .raddr ({rcc_id, ram_raddr}),
            .din (data_in),
            .dout (ram_dout),
            .wdout ());

endmodule

