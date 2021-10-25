module param_dp_async_ram
#( 
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 1 << ADDR_WIDTH)
(
    input clk,
    input [ADDR_WIDTH-1:0] addr1,
    inout [DATA_WIDTH-1:0] data1,
    input [ADDR_WIDTH-1:0] addr2,
    inout [DATA_WIDTH-1:0] data2,
    input we_1,
    input we_2,
    input cs_1, //chip select
    input cs_2, 
    input oe_1,  //output enable
    input oe_2  

);

reg [DATA_WIDTH-1:0] tmp_data1;
reg [DATA_WIDTH-1:0] tmp_data2;
reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];

//write logic
always @ (posedge clk) begin
    if(cs_1 & we_1)
        ram[addr1] <= data1;
    else if(cs_2 & we_2)
        ram[addr2] <= data2;
 
end

//asyc read logic
assign data1 = cs_1 & oe_1 & !we_1 ? ram[addr1] : 'hz;
assign data2 = cs_2 & oe_2 & !we_2 ? ram[addr2] : 'hz;

endmodule