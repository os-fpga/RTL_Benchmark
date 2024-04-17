module ram_true_dp_out_reg_1024x32 (clk, weA, weB,reA, reB, addrA, addrB, dinA, dinB, doutA, doutB);
    input clk, weA, weB, reA, reB;
    input [9:0] addrA, addrB;
    input [31:0] dinA, dinB;
    output reg [31:0] doutA, doutB;
    
    reg [31:0] ram [1023:0];
    always @(posedge clk)
    begin
        if (weA)
            ram[addrA] <= dinA;
        else
            doutA <= ram[addrA];
    end

    always @(posedge clk)
    begin
        if (weB)
            ram[addrB] <= dinB;
        else
            doutB <= ram[addrB];
    end

endmodule