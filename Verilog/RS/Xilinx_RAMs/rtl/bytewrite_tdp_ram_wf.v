// True-Dual-Port BRAM with Byte-wide Write Enable Write First
// Write-First mode
// bytewrite_tdp_ram_wf.v
//
module bytewrite_tdp_ram_wf
#(
//--------------------------------------------------------------------------
parameter SIZE = 1024,
parameter COL_WIDTH = 9,
parameter ADDR_WIDTH = 10, 
parameter NB_COL = 4 
//----------------------------------------------------------------------
) (
input clkA,
input enaA,
input [NB_COL - 1:0] weA,
input [ADDR_WIDTH-1:0] addrA,
input [NB_COL * COL_WIDTH - 1:0] dinA,
output reg [NB_COL * COL_WIDTH - 1:0] doutA,
input clkB,
input enaB,
input [NB_COL - 1:0] weB,
input [ADDR_WIDTH-1:0] addrB,
input [NB_COL * COL_WIDTH - 1:0] dinB,
output reg [NB_COL * COL_WIDTH - 1:0] doutB
);

// Core Memory
reg [NB_COL * COL_WIDTH - 1:0] ram_block [(2**ADDR_WIDTH)-1:0];
integer i;

// Port-A Operation
always @ (posedge clkA) 
begin
	if(enaA) 
	begin
		for(i=0;i<NB_COL;i=i+1) 
		begin
			if(weA[i]) 
			begin
				ram_block[addrA][i*COL_WIDTH +: COL_WIDTH] <= dinA[i*COL_WIDTH +: COL_WIDTH];
				doutA[i*COL_WIDTH +: COL_WIDTH] <= dinA[i*COL_WIDTH +: COL_WIDTH];
			end
			else
				doutA[i*COL_WIDTH +: COL_WIDTH] <= ram_block[addrA][i*COL_WIDTH +: COL_WIDTH];
		end
	end
end

// Port-B Operation:
always @ (posedge clkB) 
begin
	if(enaB) 
	begin
		for(i=0;i<NB_COL;i=i+1) 
		begin
			if(weB[i]) 
			begin
				ram_block[addrB][i*COL_WIDTH +: COL_WIDTH] <= dinB[i*COL_WIDTH +: COL_WIDTH];
				doutB[i*COL_WIDTH +: COL_WIDTH] <= dinB[i*COL_WIDTH +: COL_WIDTH];
			end
			else
				doutB[i*COL_WIDTH +: COL_WIDTH] <= ram_block[addrB][i*COL_WIDTH +: COL_WIDTH];
		end
	end
end

endmodule // bytewrite_tdp_ram_wf
