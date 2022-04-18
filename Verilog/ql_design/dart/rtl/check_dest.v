 `timescale 1 ns/100 ps	// time unit = 1ns; precision = 1/10 ns
 /* Check Destination
  * check_dest.v
  *
  * Given a set of input nexthop and enable bits, generate a vector
  * that indicate if each incoming packet is for a node in this
  * partition.
  *
  * Node addresses follow the convention below:
  * addr2 = {partition ID (4), node ID (4), port ID (3)}
  */
`include "const.v"
module check_dest (
    src_nexthop_in,
    valid
);
    parameter N = 8;        // Number of incoming packets
    parameter PID = 4'h0;   // Partition number
    
    input  [N*`A_WIDTH-1:0]	src_nexthop_in;
    output          [N-1:0] valid;
    
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin : in
            wire [`A_WIDTH-1:0] nexthop;
            assign nexthop = src_nexthop_in[(i+1)*`A_WIDTH-1:i*`A_WIDTH];
            assign valid[i] = (nexthop[`A_DPID] == PID) ? 1'b1 : 1'b0;
        end
    endgenerate    
endmodule
