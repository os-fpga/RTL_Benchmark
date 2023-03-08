// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module pd_vol_ctrl (
input		clk,
input		rstn,
input		voltage_unstable,
input		vol_scale_req,
input	[2:0]	vol_scale,
output		vol_scale_ack,
output		vol_on
);

reg	vol_scale_req_d1;
reg	vol_scale0_d1;
reg	reg_vol_on;
reg	reg_vol_scale_ack;
wire	reg_vol_scale_ack_nx;

assign	vol_scale_ack = reg_vol_scale_ack;
assign	reg_vol_scale_ack_nx = ~voltage_unstable & vol_scale_req_d1;
assign	vol_on = reg_vol_on & ~voltage_unstable;

always @(posedge clk or negedge rstn)
begin
	if (!rstn) begin
		vol_scale_req_d1 <= 1'b0;
		vol_scale0_d1	 <= 1'b0;
	end
	else begin
		vol_scale_req_d1 <= vol_scale_req;
		vol_scale0_d1	 <= vol_scale[0];
	end
end
always @(posedge clk or negedge rstn)
begin
	if (!rstn) begin
		reg_vol_on	  <= 1'b1;
	end
	else if (vol_scale_req_d1) begin
		reg_vol_on	  <= vol_scale0_d1;
	end
end
always @(posedge clk or negedge rstn)
begin
	if (!rstn) begin
		reg_vol_scale_ack <= 1'b0;
	end
	else begin
		reg_vol_scale_ack <= reg_vol_scale_ack_nx;
	end
end

endmodule
