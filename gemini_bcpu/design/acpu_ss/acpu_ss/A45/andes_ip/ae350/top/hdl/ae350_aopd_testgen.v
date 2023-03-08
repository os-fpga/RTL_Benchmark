// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module ae350_aopd_testgen (
input	T_om			/* synthesis syn_keep=1 */,
input	T_osch			/* synthesis syn_keep=1 */,
input	T_aopd_por_b		/* synthesis syn_keep=1 */,

output	test_mode		/* synthesis syn_keep=1 */,
output	test_clk		/* synthesis syn_keep=1 */,
output	test_rstn		/* synthesis syn_keep=1 */,

output	scan_test		/* synthesis syn_keep=1 */,
output	scan_enable		/* synthesis syn_keep=1 */
);

assign	test_mode = T_om;
assign	test_clk = T_osch;
assign	test_rstn = T_aopd_por_b;

assign	scan_test = 1'b0;
assign	scan_enable = 1'b0;

endmodule
