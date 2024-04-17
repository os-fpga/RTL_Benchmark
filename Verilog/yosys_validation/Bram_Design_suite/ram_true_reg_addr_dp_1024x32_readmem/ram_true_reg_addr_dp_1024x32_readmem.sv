module ram_true_reg_addr_dp_1024x32_readmem (clk, weA, weB, addrA, addrB, dinA, dinB, doutA, doutB);
    input clk, weA, weB;
    input [9:0] addrA, addrB;
    input [31:0] dinA, dinB;
    output [31:0] doutA, doutB;
    
    reg [9:0] reg_addrA=0, reg_addrB=0;
    reg [31:0] ram [1023:0];

    initial begin
         $readmemh("mem.init", ram);
    end

    always @(posedge clk)
    begin
        if (weA)
            ram[addrA] <= dinA;
            reg_addrA <= addrA;
        if (weB)
            ram[addrB] <= dinB;
            reg_addrB <= addrB;
    end

    assign doutA = ram[reg_addrA];
    assign doutB = ram[reg_addrB];

endmodule 
