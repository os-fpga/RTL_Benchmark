module ram_true_dp_512x32 (clk, weA, weB, addrA, addrB, dinA, dinB, doutA, doutB);
    input clk, weA, weB;
    input [8:0] addrA, addrB;
    input [31:0] dinA, dinB;
    output [31:0] doutA, doutB;
    
    reg [31:0] ram [511:0];
    always @(posedge clk)
    begin
        if (weA)
            ram[addrA] <= dinA;
        if (weB)
            ram[addrB] <= dinB;
    end

    assign doutA = ram[addrA];
    assign doutB = ram[addrB];

endmodule