

module asym_ram_sdp_wide_write (
    input clk, read_enable,
    input [3:0] write_enable,
    input [5:0] write_addr,
    input [7:0] read_addr,
    input [31:0] write_data,
    output reg [7:0] read_data    );

reg [7:0] mem [0:255];


always @(posedge clk) begin
    if (write_enable[0])
        mem[{write_addr, 2'b00}] <= write_data[7:0];
    if (write_enable[1])
        mem[{write_addr, 2'b01}] <= write_data[15:8];
    if (write_enable[2])
        mem[{write_addr, 2'b10}] <= write_data[23:16];
    if (write_enable[3])
        mem[{write_addr, 2'b11}] <= write_data[31:24];
    if (read_enable)
        read_data <= mem[read_addr];
end


endmodule