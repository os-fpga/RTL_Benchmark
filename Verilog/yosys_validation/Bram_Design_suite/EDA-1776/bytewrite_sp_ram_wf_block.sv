module bytewrite_sp_ram_wf_block
#(
//--------------------------------------------------------------------------
parameter NUM_COL = 2, // 2 columns of 1 byte each make : 16 bits
parameter COL_WIDTH = 8, //1 byte
parameter ADDR_WIDTH = 10, // Addr Width in bits : 2 *ADDR_WIDTH = RAM Depth ---> 2^10 = 1024
parameter DATA_WIDTH = NUM_COL*COL_WIDTH // Data Width in bits
//--------------------------------------------------------------------------
) (
input clk,
input ena,
input [NUM_COL-1:0] we,
input [ADDR_WIDTH-1:0] addr,
input [DATA_WIDTH-1:0] din,
output reg [DATA_WIDTH-1:0] dout
);

(* ram_style = "block" *)
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
				ram[addr][i*COL_WIDTH +: COL_WIDTH] <= din[i*COL_WIDTH +: COL_WIDTH];
				dout[i*COL_WIDTH +: COL_WIDTH] <= din[i*COL_WIDTH +: COL_WIDTH];
			end
			else
				dout[i*COL_WIDTH +: COL_WIDTH] <= ram[addr][i*COL_WIDTH +: COL_WIDTH];
		end
	end
end

endmodule 
