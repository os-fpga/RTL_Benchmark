

module sample_ae350_aopd_clkgen (
input		test_mode,
input		test_clk,

output		clk_32k,
input		T_oscl,

output		dbg_tck,
input		T_tck
);

assign	clk_32k	= test_mode ? test_clk : T_oscl;
assign	dbg_tck	= test_mode ? test_clk : T_tck;

endmodule
