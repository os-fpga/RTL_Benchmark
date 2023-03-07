// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module rst_sync (
input		test_mode,
input		test_rstn,
input		clk,
input		rstn_in,
input		casc_rstn_in,
output		rstn_out,
output		casc_rstn_out
);
parameter HAS_CASC_RSTN = 1;
wire    rstn;
generate
if (HAS_CASC_RSTN) begin: gen_casc_rstn

        nds_rst_sync nds_casc_rst_sync (
        	.test_mode     (1'b0            ),
        	.test_resetn_in(1'b1            ),
        	.resetn_in     (casc_rstn_in    ),
        	.clk           (clk             ),
        	.resetn_out    (casc_rstn_out   )
        );
	assign rstn = rstn_in & casc_rstn_in;
end
else begin: gen_casc_rstn_else
	assign casc_rstn_out = 1'b1;
	assign rstn = rstn_in;
end
endgenerate

wire rstn_sync;
nds_rst_sync nds_ae350_rst_sync (
	.test_mode     (test_mode       ),
	.test_resetn_in(test_rstn       ),
	.resetn_in     (rstn            ),
	.clk           (clk             ),
	.resetn_out    (rstn_sync       )
);

assign rstn_out	= test_mode ? test_rstn : rstn_sync;

endmodule
