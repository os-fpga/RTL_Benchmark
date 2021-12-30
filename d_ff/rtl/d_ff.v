
module d_ff (d, clk, rst, q);
    parameter bus_size = 5;
    input [0: bus_size-1]d;
    input clk,rst;
    output reg [0: bus_size-1 ]q;

    always@ (posedge clk , negedge rst)
        begin 
            if (!rst)
                q<= 0;
            else 
                q<= d;
        end
endmodule
 
