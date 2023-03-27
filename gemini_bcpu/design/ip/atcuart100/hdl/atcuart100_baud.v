// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"

module atcuart100_baud (
	  uclk,
	  urstn,
	  baud_initial,
	  dll_reg,
	  dlm_reg,
	  tx_active,
	  rx_active,
	  baud_mx
);

input				uclk;
input				urstn;
input				baud_initial;
input	[7:0]			dll_reg;
input	[7:0]			dlm_reg;
input				tx_active;
input				rx_active;

output				baud_mx;

reg	[15:0]			s0;
wire				s1;
wire				s2;
reg				s3;


assign s2 = (tx_active | rx_active);

always @(negedge urstn or posedge uclk)
begin
	if (~urstn)
		s3 <= 1'b0;
	else
		s3 <= s2;
end

assign s1 = ((s0 == 16'h1) & s2);

always @(negedge urstn or posedge uclk)
begin
	if (~urstn)
		s0 <= 16'h1;
	else if (baud_initial | s1)
		s0 <= {dlm_reg , dll_reg};
	else if (s2 & s3)
		s0 <= (s0 - 16'h1);
end

assign baud_mx = s1 | (s2 & (~s3));

endmodule

