`timescale 1ns / 1ps
/* Baud rate generator (9600)
 * Assume 50 MHz clock input
 */
module baud_gen #(
    parameter BAUD_RATE = 9600
)
(
    input clock,
    input reset,
    input start,
    output reg baud_tick
);
    `include "math.v"
    
    localparam WIDTH = 16;

    reg     [WIDTH-1: 0]    counter_r;
    wire    [WIDTH-1:0]     max;
    
    // Counter values are selected for each baud rate
    generate
        if (BAUD_RATE == 9600)          // 9600
        begin
            reg [1:0] toggle;
            
            assign max = (toggle == 0) ? 16'd5209 : 16'd5208;
            
            always @(posedge clock)
            begin
                if (reset)
                    toggle <= 0;
                else if (baud_tick)
                    if (toggle == 2)
                        toggle <= 0;
                    else
                        toggle <= toggle + 1;
            end
        end
        else if (BAUD_RATE == 115200)   // 115200
        begin
            reg [6:0] toggle;
            
            assign max = (toggle == 0) ? 16'd435 : 16'd434;
            
            always @(posedge clock)
            begin
                if (reset)
                    toggle <= 0;
                else if (baud_tick)
                    if (toggle == 35)
                        toggle <= 0;
                    else
                        toggle <= toggle + 1;
            end
        end
        else if (BAUD_RATE == 0)        // Simulation
        begin
            assign max = 16'h4;
        end
    endgenerate
    
    // Baud tick counter
    always @(posedge clock)
    begin
        if (reset)
        begin
            counter_r   <= {(WIDTH){1'b0}};
            baud_tick   <= 1'b0;
        end
        else
        begin
            if (counter_r == max)
            begin
                baud_tick <= 1'b1;
                counter_r <= {(WIDTH){1'b0}};
            end
            else
            begin
                baud_tick <= 1'b0;
                
                if (start)
                    counter_r <= {1'b0, max[WIDTH-1:1]};    // Reset counter to half the max value
                else
                    counter_r <= counter_r + {{(WIDTH-1){1'b0}}, 1'b1};
            end
        end
    end
endmodule
