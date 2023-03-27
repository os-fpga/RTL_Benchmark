`ifdef SAMPLE_AE350_SMU_CONST_VH
`else
`define SAMPLE_AE350_SMU_CONST_VH

`define SAMPLE_AE350_SMU_VERID			32'h0000_0100

`define SAMPLE_AE350_SMU_RESET_VECTOR_LO_DEFAULT	32'h80000000
`define SAMPLE_AE350_SMU_RESET_VECTOR_HI_DEFAULT	32'h00000000

`ifdef AE350_CLK_RATIO_4_4_2
	`define SAMPLE_AE350_SMU_CLKR_DEFAULT	4'b001_0
`elsif AE350_CLK_RATIO_4_4_1
	`define SAMPLE_AE350_SMU_CLKR_DEFAULT	4'b010_0
`elsif AE350_CLK_RATIO_4_2_2
	`define SAMPLE_AE350_SMU_CLKR_DEFAULT	4'b011_0
`elsif AE350_CLK_RATIO_4_2_1
	`define SAMPLE_AE350_SMU_CLKR_DEFAULT	4'b100_0
`else
      `define SAMPLE_AE350_SMU_CLKR_DEFAULT	4'b000_0
`endif

`endif
