// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module pd_clk_ctrl (
input		clk,
input		rstn,
input		clock_unstable,
input		frq_scale_req,
input	[2:0]	frq_scale,
output		frq_scale_ack,
output		clk_en
);

reg	frq_scale_req_d1;
reg	frq_scale0_d1;
reg	reg_clk_en;
reg	reg_frq_scale_ack;
wire	reg_frq_scale_ack_nx;

assign	frq_scale_ack = reg_frq_scale_ack;
assign	reg_frq_scale_ack_nx = ~clock_unstable & frq_scale_req_d1;
assign	clk_en = reg_clk_en & ~clock_unstable;

always @(posedge clk or negedge rstn)
begin
	if (!rstn) begin
		frq_scale_req_d1 <= 1'b0;
		frq_scale0_d1	 <= 1'b0;
	end
	else begin
		frq_scale_req_d1 <= frq_scale_req;
		frq_scale0_d1	 <= frq_scale[0];
	end
end
always @(posedge clk or negedge rstn)
begin
	if (!rstn) begin
		reg_clk_en	  <= 1'b1;
	end
	else if (frq_scale_req_d1) begin
		reg_clk_en	  <= frq_scale0_d1;
	end
end
always @(posedge clk or negedge rstn)
begin
	if (!rstn) begin
		reg_frq_scale_ack <= 1'b0;
	end
	else begin
		reg_frq_scale_ack <= reg_frq_scale_ack_nx;
	end
end


endmodule
