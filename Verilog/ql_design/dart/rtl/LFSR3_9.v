`timescale 1ns / 1ps
/* LFSR3_9.v
 * Linear Feedback Shift Register (any length between 3 to 9 bits)
 */
module LFSR3_9(
    clock,
    reset,
    enable,
    dout,
    dout_next
);
    parameter LENGTH = 6;
    parameter FULL_CYCLE = 1;
    
    input                   clock;
    input                   reset;
    input                   enable;
    output    [LENGTH-1: 0] dout;
    output    [LENGTH-1: 0] dout_next;
    
    // Shift register
    reg       [LENGTH-1: 0] dout;
    
    // Feedback signal
    wire                    din;
    wire                    lockup;

    // Output
    assign dout_next = {dout[LENGTH-2:0], din};
    
    // Maximal period
    generate
        if (LENGTH == 3 || LENGTH == 4 || LENGTH == 6 || LENGTH == 7)
            assign din = dout[LENGTH-1] ^ dout[LENGTH-2] ^ lockup;
        else if (LENGTH == 5)
            assign din = dout[4] ^ dout[2] ^ lockup;
        else if (LENGTH == 8)
            assign din = dout[7] ^ dout[5] ^ dout[4] ^ dout[3] ^ lockup;
        else if (LENGTH == 9)
            assign din = dout[8] ^ dout[4] ^ lockup;
        else
        begin
            //$display ("LFSR Error: Don't know what to do with length %d", LENGTH);
            assign din = dout[0];
        end
        
        // Lock-up state detection
        if (FULL_CYCLE == 1)
            assign lockup = ~|(dout[LENGTH-2:0]);
        else
            assign lockup = 1'b0;
    endgenerate
   
    always @(posedge clock)
    begin
        if (reset)
            dout <= {(LENGTH){1'b1}};
        else if (enable)
            dout <= dout_next;
    end
endmodule
