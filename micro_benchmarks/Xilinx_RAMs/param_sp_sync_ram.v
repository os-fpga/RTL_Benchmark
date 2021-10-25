module param_sp_sync_ram
#( 
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 1 << ADDR_WIDTH)
(
    input clk,
    input [ADDR_WIDTH-1:0] addr,
    inout [DATA_WIDTH-1:0] data,
    input we,
    input cs, //chip select
    input oe  //output enable

);
reg [DATA_WIDTH-1:0] tmp_data;  
reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];

//write logic
always @ (posedge clk) begin
    if(cs & we)
        ram[addr] <= data;
end

//read logic
always @ (posedge clk) begin
    if(cs & !we)
        tmp_data <= ram[addr];
end

assign data = cs & oe & !we ? tmp_data : 'hz;

endmodule