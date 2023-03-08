// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary



module ae250_aopd_clkgen (
		  test_mode,
		  test_clk,
		  clk_32k,
		  T_oscl,
		  dbg_tck,
		  T_tck
);

input		test_mode;
input		test_clk;

output		clk_32k;
input		T_oscl;

output		dbg_tck;
input		T_tck;

assign	clk_32k		= test_mode ? test_clk : T_oscl;
assign	dbg_tck	= test_mode ? test_clk : T_tck;

endmodule
