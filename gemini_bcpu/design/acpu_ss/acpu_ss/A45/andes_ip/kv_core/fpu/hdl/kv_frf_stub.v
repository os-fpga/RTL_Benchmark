// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_frf_stub(
		  core_clk,
		  core_reset_n,
		  hart_under_reset,
		  frf_raddr1,
		  frf_rdata1,
		  frf_raddr2,
		  frf_rdata2,
		  frf_raddr3,
		  frf_rdata3,
		  frf_raddr4,
		  frf_rdata4,
		  frf_we1,
		  frf_waddr1,
		  frf_wdata1,
		  frf_wstatus1,
		  frf_we2,
		  frf_waddr2,
		  frf_wdata2,
		  frf_wstatus2,
		  frf_we3,
		  frf_waddr3,
		  frf_wdata3,
		  frf_wstatus3
);
parameter         FLEN = 64;
parameter         GPRNUM = 32;
input              core_clk;
input              core_reset_n;
input              hart_under_reset;
input        [4:0] frf_raddr1;
output  [FLEN-1:0] frf_rdata1;
input        [4:0] frf_raddr2;
output  [FLEN-1:0] frf_rdata2;
input        [4:0] frf_raddr3;
output  [FLEN-1:0] frf_rdata3;
input        [4:0] frf_raddr4;
output  [FLEN-1:0] frf_rdata4;
input              frf_we1;
input        [4:0] frf_waddr1;
input   [FLEN-1:0] frf_wdata1;
input       [1:0]  frf_wstatus1;

input              frf_we2;
input        [4:0] frf_waddr2;
input   [FLEN-1:0] frf_wdata2;
input        [1:0] frf_wstatus2;

input              frf_we3;
input        [4:0] frf_waddr3;
input   [FLEN-1:0] frf_wdata3;
input              frf_wstatus3;

wire		   s0 = core_clk | core_reset_n | hart_under_reset
			      | (|frf_raddr1) | (|frf_raddr2) | (|frf_raddr3) | (|frf_raddr4)
			      | frf_we1 | (|frf_waddr1) | (|frf_wdata1) | (|frf_wstatus1)
			      | frf_we2 | (|frf_waddr2) | (|frf_wdata2) | (|frf_wstatus2)
			      | frf_we3 | (|frf_waddr3) | (|frf_wdata3) | (|frf_wstatus3)
			      ;
assign frf_rdata1 = {FLEN{1'b0}};
assign frf_rdata2 = {FLEN{1'b0}};
assign frf_rdata3 = {FLEN{1'b0}};
assign frf_rdata4 = {FLEN{1'b0}};

endmodule

