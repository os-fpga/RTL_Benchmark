// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_apbslv(
                          	  pclk,
                          	  presetn,
                          	  paddr,
                          	  psel,
                          	  penable,
                          	  pwrite,
                          	  pwdata,
                          	  pready,
                          	  prdata,
                          	  pslverr,
                          	  cmd_buff_wr,
                          	  cmd_buff_wdata,
                          	  cmd_buff_full,
                          	  rdata_buff_rd,
                          	  rdata_buff_rdata,
                          	  rdata_buff_empty
);

input		pclk;
input		presetn;
input	[31:0]	paddr;
input		psel;
input		penable;
input		pwrite;
input	[31:0]	pwdata;
output		pready;
output	[31:0]	prdata;
output		pslverr;
output		cmd_buff_wr;
output	[39:0]	cmd_buff_wdata;
input		cmd_buff_full;
output		rdata_buff_rd;
input	[31:0] 	rdata_buff_rdata;
input		rdata_buff_empty;

reg		s0;
reg		s1;
wire		s2;
wire		s3;
wire		s4;

assign	s2		=   psel 	  && (!penable);
assign	s3	=   s2 && (!pwrite);
assign	cmd_buff_wr		=   s2 && (!cmd_buff_full);
assign	cmd_buff_wdata		=  {pwrite, paddr[8:2], pwdata};
assign	rdata_buff_rd		=  !rdata_buff_empty;
assign	prdata			=   rdata_buff_rdata;
assign	s4	=  (s3 || s0) && rdata_buff_empty;
assign	pready			= !(cmd_buff_full    || s0  || s1);
assign	pslverr			=   1'b0;

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		s0     <= 1'b0;
		s1    <= 1'b0;
	end
	else begin
		s0     <= s4;
		s1    <= s2;
	end
end

endmodule
