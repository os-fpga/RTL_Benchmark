// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


module ae250_aopd_testgen (
	  T_om,
	  T_oscl,
	  T_aopd_por_b,
	  test_mode,
	  test_clk,
	  test_rstn
);

input	T_om;
input	T_oscl;
input	T_aopd_por_b;

output	test_mode;
output	test_clk;
output	test_rstn;

assign	test_mode = T_om;
assign	test_clk = T_oscl;
assign	test_rstn = T_aopd_por_b;


endmodule
