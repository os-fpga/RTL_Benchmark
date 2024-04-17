module tdp_100x11 (clkA, clkB, weA, weB, addrA, addrB, dinA, dinB, doutA, doutB);
    input clkA, clkB, weA, weB;
    input [3:0] addrA, addrB;
    input [99:0] dinA, dinB;
    output [99:0] doutA, doutB;

reg [3:0] reg_addrA, reg_addrB;
reg [99:0] ram [10:0];
always @(posedge clkA)
begin
reg_addrA <= addrA;
    if (weA)
	  ram[addrA] <= dinA;
        
end


always @(posedge clkB)
begin
  reg_addrB <= addrB;
    if (weB)
        ram[addrB] <= dinB;
      
end
    

assign doutA = ram[reg_addrA];
assign doutB = ram[reg_addrB];

endmodule