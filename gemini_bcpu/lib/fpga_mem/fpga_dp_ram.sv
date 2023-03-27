// Simple Dual-Port Block RAM with Two Clocks

module fpga_dp_ram #(
    parameter A_WIDTH   = 9  ,
    parameter D_WIDTH   = 32 ,
    parameter RAM_DEPTH = 512
) (
    input               clka ,
    input               clkb ,
    input               ena  ,
    input               enb  ,
    input               wea  ,
    input [A_WIDTH-1:0] addra,
    input [A_WIDTH-1:0] addrb,
    input [D_WIDTH-1:0] dia  ,
    input [D_WIDTH-1:0] dob
);

reg [D_WIDTH-1:0] ram[RAM_DEPTH-1:0];
reg [D_WIDTH-1:0] dob               ;

always @(posedge clka) begin
    if (ena) begin
        if (wea) ram[addra] <= dia;
    end
end

always @(posedge clkb) begin
    if (enb) begin
        dob <= ram[addrb];
    end
end

endmodule