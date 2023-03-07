
module sample_kv_clk_gen (
        	  clk_in,
        	  resetn,
        	  clk_en,
		  clk_out
);

parameter RATIO = 1;

input			clk_in;
input			resetn;
output			clk_en;
output			clk_out;

wire			s0;

generate
if (RATIO == 1) begin : gen_ratio_1
	assign clk_en = 1'b1;
	assign s0 = clk_in;
end
else  begin : gen_ratio_2
	reg     s1;
	always @(posedge clk_in or negedge resetn) begin
		if (!resetn)
			s1 <= 1'b0;
		else
			s1 <= ~s1;
	end
	assign clk_en = ~s1;
	assign s0 = s1;
end
endgenerate

`ifdef NDS_FPGA
	BUFGCE	TL_UL_CLK_MUX_INST (
		.I	(s0		),
		.CE	(1'b1			),
		.O	(clk_out		)
	);
`else
	assign clk_out = s0;
`endif

endmodule

