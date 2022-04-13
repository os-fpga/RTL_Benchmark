`timescale 1ns / 1ps
/* Packet Playback Control
 *
 * Input:
 *      ready   [N-1:0]
 *      request [N-1:0]
 *
 * Output:
 *      select  [N-1:0]     Select is always valid
 *
 * State:
 *      ~Round-robin priority
 */

module PacketPBControl #(
    parameter N = 4
)
(
    input clock,
    input reset,
    input enable,
    input [N-1:0] ready,
    input [N-1:0] request,
    output [N-1:0] select
);
    `include "math.v"
    
    reg [N-1:0] r_prio;
    
    wire [N-1:0] w_available;
    wire [N-1:0] w_select;
    
    // Output
    assign select = w_select;
    
    
    // Only those TGs that are requesting a new packet and also have a new
    // packet available can be chosen from
    assign w_available = (enable == 1'b1) ? (ready & request & r_prio) : {(N){1'b0}};


    // Select a node according to the priority
    rr_prio_x4 rr_select (
        .ready (w_available),
        .prio (r_prio),
        .select (w_select));

    // Update the priority so the selected node has the lowest priority in next round
    always @(posedge clock)
    begin
        if (reset)
            r_prio <= 1;
        else if (|w_select)
            r_prio <= {w_select[N-2:0], w_select[N-1]};
    end
endmodule

