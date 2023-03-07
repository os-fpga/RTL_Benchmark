// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module atciic100_gsf(
		  pclk,
		  presetn,
		  t_sp,
		  I,
		  timing_parameter_scaling_pulse,
		  O,
		  rising_edge,
		  falling_edge
);

input			pclk;
input			presetn;
input		[2:0]	t_sp;
input			I;
input			timing_parameter_scaling_pulse;
output			O;
output			rising_edge;
output			falling_edge;

wire			s0;
wire			s1;

reg 			O;
reg		[2:0]	s2;

assign	s1       = (s2 == t_sp) & (O != s0);
assign	rising_edge  = s1 & ~O & timing_parameter_scaling_pulse;
assign	falling_edge = s1 &  O & timing_parameter_scaling_pulse;

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		O <= 1'b1;
	end
	else if (timing_parameter_scaling_pulse) begin
		if (s1) begin
			O <= ~O;
		end
	end
end

always @(posedge pclk or negedge presetn) begin
	if (!presetn) begin
		s2 <= 3'b0;
	end
	else if (timing_parameter_scaling_pulse) begin
		if (s2 >= t_sp) begin
			s2 <= 3'b0;
		end
		else if (O != s0) begin
			s2 <= s2 + 3'b1;
		end
		else begin
			s2 <= 3'b0;
		end
	end
end

nds_sync_l2l #(.RESET_VALUE (1'b1)) u_nds_sync_l2l (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(I),
	.b_signal			(s0),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

endmodule
