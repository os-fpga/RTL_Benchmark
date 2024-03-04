module top
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=11)
(
  input [(ADDR_WIDTH-1):0] addr_a, addr_b,
  input clk,
  output reg [(DATA_WIDTH-1):0] q_a, q_b
);

  // Declare the RAM variable
  reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

  initial $readmemh("memory.mem", ram);
  
  always @ (posedge clk) begin
    q_a <= ram[addr_a];
    q_b <= ram[addr_b];
  end

endmodule