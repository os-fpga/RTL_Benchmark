module sync_sp_wr_first_reg #(parameter DATA_WIDTH=8, ADDRESS_WIDTH=10)
(input  wire                      we, clk,
input  wire  [DATA_WIDTH-1:0]    wd,
input  wire  [ADDRESS_WIDTH-1:0] addr,
output wire  [DATA_WIDTH-1:0]    rd);
					 
localparam WORD  = (DATA_WIDTH-1);
localparam DEPTH = (2**ADDRESS_WIDTH-1);
						   
reg [WORD:0] data_out_r;
reg [WORD:0] memory [0:DEPTH];
								 
always @(posedge clk) begin
	if (we)
		memory[addr] <= wd;
	data_out_r <= memory[addr];
end
														    
assign rd = data_out_r;
															   
endmodule 
