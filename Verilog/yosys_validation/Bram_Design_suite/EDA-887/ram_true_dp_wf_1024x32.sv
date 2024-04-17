module ram_true_dp_wf_1024x32 (clk, weA, weB, addrA, addrB, dinA, dinB, doutA, doutB);
    input clk, weA, weB;
    input [9:0] addrA, addrB;
    input [31:0] dinA, dinB;
    output reg [31:0] doutA, doutB;
    
    reg [31:0] ram [1023:0];
    always @(posedge clk)
    begin
   
        if (weA) begin
            ram[addrA] <= dinA;
            doutA <= dinA;
        end
        else
            doutA <= ram[addrA];
   
        end
 
    always @(posedge clk)
    begin

        if (weB) begin
            ram[addrB] <= dinB;
            doutB <= dinB;
        end
        else
            doutB <= ram[addrB];
    end
endmodule