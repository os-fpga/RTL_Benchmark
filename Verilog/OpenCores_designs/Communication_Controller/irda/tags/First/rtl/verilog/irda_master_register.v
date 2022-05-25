//`include "irda_defines.v"

module irda_master_register (clk, wb_rst_i, wb_addr_i, wb_dat_i, we_i, master, 
		fast_mode, mir_mode, mir_half, fir_mode, tx_select, loopback_enable, use_dma);

input				clk;
input				wb_rst_i;
input		[3:0]	wb_addr_i;
input		[7:1]	wb_dat_i;
input				we_i;
output	[7:1]	master;
output			mir_mode;	// MIR mode selected (fast or slow)
output			mir_half;	// 1 if half speed MIR is selected
output			fir_mode;	// 1 if FIR mode is selected
output			fast_mode;  // 1 - fast mode (MIR or FIR) , 0 - slow mode
output			tx_select;  // 1 - transmitter mode selected, 0 - receiver mode]
output			loopback_enable; // loopback mode enable output
output			use_dma;    // bit 7 (DMA use)



reg		[7:1]	master;
wire		[3:0]	wb_addr_i;
wire		[7:1]	wb_dat_i;

always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		master	<= #1 0;
	end else begin
		if (we_i && wb_addr_i == `IRDA_MASTER)
			master	<= #1 wb_dat_i;
	end
end

assign	fast_mode = ( master[`IRDA_MASTER_SPEED]!=2'b0 );
assign	tx_select = master[`IRDA_MASTER_MODE];
assign	loopback_enable = master[`IRDA_MASTER_LB];
assign	mir_mode = (master[4]==1'b1);
assign	mir_half = (master[`IRDA_MASTER_SPEED] == 2'b10);
assign	fir_mode = (master[`IRDA_MASTER_SPEED] == 2'b01);
assign	use_dma = master[7];

endmodule
