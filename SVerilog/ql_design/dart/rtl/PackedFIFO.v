`timescale 1ns / 1ps
/* Packed FIFO
 * Multiple FIFO packed into 1 block RAM
 * 2-cycle latency
 */
module PackedFIFO #(
    parameter logN = 2,
    parameter WIDTH = 36,
    parameter logDEPTH = 6
)
(
    input                           clock,
    input                           reset,
    input                [logN-1:0] wid,
    input                [logN-1:0] rid,
    input                           write,
    input                           read,
    input               [WIDTH-1:0] data_in,
    output    [(1<<logN)*WIDTH-1:0] data_out,
    output          [(1<<logN)-1:0] full,
    output          [(1<<logN)-1:0] empty,
    output          [(1<<logN)-1:0] has_data,
    output                          error
);
    localparam N = 1<<logN;
    localparam DEPTH = 1 << logDEPTH;


    reg r_read_busy;
    reg [N*WIDTH-1:0] r_dout;
    reg [N-1:0] r_dout_valid;
    reg [N-1:0] r_load_dout;

    wire [N-1:0] w_read_request;
    wire [N-1:0] w_write_request;

    wire [N-1:0] w_wid_decoded;
    wire [N-1:0] w_rid_decoded;

    reg  [N-1:0] w_fifo_enable;
    reg  [N-1:0] w_fifo_write;
    reg  [N-1:0] w_fifo_read;
    wire [N-1:0] w_fifo_full;
    wire [N-1:0] w_fifo_empty;
    wire [N-1:0] w_fifo_wen;
    wire [N*logDEPTH-1:0] w_fifo_waddr;
    wire [N*logDEPTH-1:0] w_fifo_raddr;

    reg  [N-1:0] w_load_din;        // Tell r_dout[i] to load the value of data_in
    reg  [N-1:0] w_load_dout;       // Tell r_dout[i] to load the value of ram_dout

    wire w_ram_wen;
    wire [logN+logDEPTH-1:0] w_ram_waddr;
    wire [logN+logDEPTH-1:0] w_ram_raddr;
    wire [WIDTH-1:0] w_ram_dout;


    // Output
    assign data_out = r_dout;
    assign full = w_fifo_full;
    assign empty = w_fifo_empty & (~r_dout_valid);
    assign error = 1'b1;


    decoder_N #(.SIZE(N)) wid_decode (
        .encoded (wid),
        .decoded (w_wid_decoded));

    decoder_N #(.SIZE(N)) rid_decode (
        .encoded (rid),
        .decoded (w_rid_decoded));

    assign w_write_request = (write == 1'b1) ? w_wid_decoded : 0;
    assign w_read_request = (read == 1'b1 && r_read_busy == 1'b0) ? w_rid_decoded : 0;

    // FIFO controls
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin : fifo
            // FIFO control
            RAMFIFO_ctrl_lfsr #(.LOG_DEP(logDEPTH)) ctrl (
                .clock (clock),
                .reset (reset),
                .enable (w_fifo_enable[i]),
                .write (w_fifo_write[i]),
                .read (w_fifo_read[i]),
                .full (w_fifo_full[i]),
                .empty (w_fifo_empty[i]),
                .ram_wen (w_fifo_wen[i]),
                .ram_waddr (w_fifo_waddr[(i+1)*logDEPTH-1:i*logDEPTH]),
                .ram_raddr (w_fifo_raddr[(i+1)*logDEPTH-1:i*logDEPTH]),
                .ram_raddr_next ());

            always @(*)
            begin
                w_fifo_read[i] = 0;
                w_fifo_write[i] = 0;
                w_fifo_enable[i] = 0;
                w_load_din[i] = 0;
                w_load_dout[i] = 0;


                if (w_read_request[i] & ~w_write_request[i])
                begin
                    // Read from FIFO and no write
                    if (~w_fifo_empty[i])
                    begin
                        w_fifo_enable[i] = 1;
                        w_fifo_read[i] = 1;
                        w_load_dout[i] = 1;
                    end
                end
                else if (~w_read_request[i] & w_write_request[i])
                begin
                    // Write to FIFO and no read
                    if (~r_dout_valid[i])
                    begin
                        // dout is invalid => FIFO is empty. Write to dout directly
                        w_load_din[i] = 1;
                    end
                    else
                    begin
                        // Something is already in dout. Write to FIFO.
                        w_fifo_enable[i] = 1;
                        w_fifo_write[i] = 1;
                    end
                end
                else if (w_read_request[i] & w_write_request[i])
                begin
                    // Reading and writing simultaneously
                    if (w_fifo_empty[i])
                    begin
                        // FIFO in RAM is empty and dout is being read. Write data_in to dout
                        w_load_din[i] = 1;
                    end
                    else
                    begin
                        // Write to FIFO and read from FIFO
                        w_fifo_enable[i] = 1;
                        w_fifo_write[i] = 1;
                        w_fifo_read[i] = 1;
                        w_load_dout[i] = 1;
                    end
                end
            end

            // Output register
            assign has_data[i] = (r_read_busy & r_load_dout[i]) ? 0 : ~empty[i];

            always @(posedge clock)
            begin
                if (reset)
                    r_dout[(i+1)*WIDTH-1:i*WIDTH] <= 0;
                else if (w_load_din[i])
                    r_dout[(i+1)*WIDTH-1:i*WIDTH] <= data_in;
                else if (r_load_dout[i])
                    r_dout[(i+1)*WIDTH-1:i*WIDTH] <= w_ram_dout;
            end

            always @(posedge clock)
            begin
                if (reset)
                    r_dout_valid[i] <= 1'b0;
                else if (w_load_din[i] | w_load_dout[i])
                    r_dout_valid[i] <= 1'b1;
                else if (w_read_request[i] & ~w_load_din[i] & ~w_load_dout[i])
                    r_dout_valid[i] <= 1'b0;
            end

            always @(posedge clock)
            begin
                if (reset)
                    r_load_dout[i] <= 0;
                else
                    r_load_dout[i] <= w_load_dout[i];
            end
        end
    endgenerate

    always @(posedge clock)
    begin
        if (reset)
            r_read_busy <= 0;
        else if (read == 1 && w_load_dout != 0)
            // Allow 1 cycle to load data from RAM
            r_read_busy <= 1;
        else if (r_read_busy == 1)
            r_read_busy <= 0;
    end


    // Block RAM
    DualBRAM #(.WIDTH(WIDTH), .LOG_DEP(logN+logDEPTH)) ram (
        .clock (clock),
        .wen (w_ram_wen),
        .waddr (w_ram_waddr),
        .raddr (w_ram_raddr),
        .din (data_in),
        .dout (w_ram_dout),
        .wdout ());

    assign w_ram_waddr[logDEPTH+logN-1:logDEPTH] = wid;
    mux_Nto1 #(.WIDTH(logDEPTH), .SIZE(N)) waddr_mux (
        .in (w_fifo_waddr),
        .sel (wid),
        .out (w_ram_waddr[logDEPTH-1:0]));

    assign w_ram_raddr[logDEPTH+logN-1:logDEPTH] = rid;
    mux_Nto1 #(.WIDTH(logDEPTH), .SIZE(N)) raddr_mux (
        .in (w_fifo_raddr),
        .sel (rid),
        .out (w_ram_raddr[logDEPTH-1:0]));

    assign w_ram_wen = |w_fifo_wen;

endmodule

