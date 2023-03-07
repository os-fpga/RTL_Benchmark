//    Copyright 2006 Andes Technology Corp. - All Rights Reserved.    //


module gck (clk_out, clk_en, clk_in, test_en);

parameter BYPASS_CLKEN_IN_FPGA = 0;

(* gated_clock = "true" *) input clk_in;
input clk_en;
input test_en;

output clk_out;


reg latch_out;

always @(clk_in or clk_en or test_en)
	if (~clk_in)
		latch_out <= clk_en | test_en;

generate
if (BYPASS_CLKEN_IN_FPGA) begin: gen_bypass_clk_en
	`ifdef NDS_FPGA
	assign clk_out = clk_in;
	`else
	assign clk_out = clk_in & latch_out;
	`endif
end
else begin: gen_nobypass_clk_en
	assign clk_out = clk_in & latch_out;
end
endgenerate

endmodule
