// Single-Port Block RAM

module fpga_sp_ram #(
    parameter A_WIDTH   = 9  ,
    parameter D_WIDTH   = 32 ,
    parameter RAM_DEPTH = 512
) (
    input               clk ,
    input               we  ,
    input               en  ,
    input [A_WIDTH-1:0] addr,
    input [D_WIDTH-1:0] di  ,
    output[D_WIDTH-1:0] dout
);

reg [D_WIDTH-1:0] RAM [RAM_DEPTH-1:0];
reg [D_WIDTH-1:0] dout               ;

always @(posedge clk) begin
    if (en) begin
        if (we)
            RAM[addr] <= di;
        else
            dout <= RAM[addr];
    end
end

endmodule