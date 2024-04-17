module asym_ram_sdp_wide_sync_read (
input clk, write_enable, read_enable,
input [7:0] write_addr,
input [5:0] read_addr,
input [7:0] write_data,
output reg [31:0] read_data
);

reg [7:0] mem [0:255];

always @(posedge clk) begin
    if (write_enable)
        mem[write_addr] <= write_data;
    if (read_enable) begin
        read_data[7:0] <= mem[{read_addr, 2'b00}];
        read_data[15:8] <= mem[{read_addr, 2'b01}];
        read_data[23:16] <= mem[{read_addr, 2'b10}];
        read_data[31:24] <= mem[{read_addr, 2'b11}];
    end
end


endmodule