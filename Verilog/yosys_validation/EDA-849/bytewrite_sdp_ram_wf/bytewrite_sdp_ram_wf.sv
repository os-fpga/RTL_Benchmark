module bytewrite_sdp_ram_wf #(
//--------------------------------------------------------------------------
parameter NUM_COL = 4, // 4 columns of 1 byte each make : 32 bits
parameter COL_WIDTH = 8, //1 byte
parameter ADDR_WIDTH = 10, // Addr Width in bits : 2 *ADDR_WIDTH = RAM Depth ---> 2^10 = 1024
parameter DATA_WIDTH = NUM_COL*COL_WIDTH // Data Width in bits
//--------------------------------------------------------------------------
)  (
input clk,
input ena,
input [NUM_COL-1:0] we, // to enable which byte to write
input [ADDR_WIDTH-1:0] read_addr,write_addr,
input [DATA_WIDTH-1:0] din,
output reg [DATA_WIDTH-1:0] dout
);

reg [DATA_WIDTH-1:0] ram [(2**ADDR_WIDTH)-1:0];
integer i;

always @ (posedge clk) 
begin
	if(ena) 
	begin
		for(i=0;i<NUM_COL;i=i+1) 
		begin
			if(we[i]) 
			begin
				ram[write_addr][i*COL_WIDTH +: COL_WIDTH] <= din[i*COL_WIDTH +: COL_WIDTH];
				dout[i*COL_WIDTH +: COL_WIDTH] <= din[i*COL_WIDTH +: COL_WIDTH];
			end
			else
				dout[i*COL_WIDTH +: COL_WIDTH] <= ram[read_addr][i*COL_WIDTH +: COL_WIDTH];
		end
	end
end


endmodule