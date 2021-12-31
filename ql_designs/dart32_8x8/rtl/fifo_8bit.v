`timescale 1ns / 1ps

module fifo_8bit #(
    parameter WIDTH = 8,
    parameter LOG_DEP = 16
)
(
    input               clk,
    input               rst,
    
    
    input   [WIDTH-1:0] din,
    output  [WIDTH-1:0] dout,
    
    input               wr_en,
    input               rd_en,
    output              full,
    output              empty
);
    localparam DEPTH = 1 << LOG_DEP;
    
    wire                ram_wen;
    wire  [LOG_DEP-1:0] ram_waddr;
    wire  [LOG_DEP-1:0] ram_raddr;
    wire    [WIDTH-1:0] ram_dout;
    wire                w_empty;
    wire                w_full;
    wire                enable;
    wire                has_data;

    reg     [WIDTH-1:0] s1_dout;
    reg                 s2_empty; 
    reg                 rbusy; // Ensure rd_en only registered in the 1st half cycle of the slow clk
    
    wire fifo_read;
    wire fifo_write;
    
    assign enable = 1'b1;

    assign dout = s1_dout;
    assign has_data = ~s2_empty & ~rbusy;
    assign empty = s2_empty;
    assign full = w_full;
    
    assign fifo_read = enable & rd_en & has_data;
    assign fifo_write = enable & wr_en & (~full);

    always @(posedge clk)
    begin
        if (rst)
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
        .clock (clk),
        .reset (rst),
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
        .clock (clk),
        .enable (enable),
        .wen (ram_wen),
        .waddr (ram_waddr),
        .raddr (ram_raddr),
        .din (din),
        .dout (ram_dout),
        .wdout ());

    // First stage output register at posedge of clock
    always @(posedge clk)
    begin
        if (rst)
            s1_dout <= {(WIDTH){1'b0}};
        else if (enable)
        begin
            if (wr_en & w_empty)
                s1_dout <= din;
            else if (rbusy)
                s1_dout <= ram_dout;
        end
    end
endmodule

