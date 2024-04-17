module asym_ram_sdp_wide_sync_read_via_part_selection (
input clk, write_enable, read_enable,
input [1:0] byte_lane,
input [7:0] write_addr,
input [5:0] read_addr,
input [7:0] write_data,
output reg [31:0] read_data
);
reg [31:0] mem [255:0];
always @(posedge clk) begin
    if (write_enable)
        mem[write_addr][byte_lane * 8 +: 8] <= write_data;
    if (read_enable)
        read_data <= mem[read_addr];
end
endmodule