/*
Streaming FFT module with resizable FFT length
*/

`ifndef _fft_int_size_
`define _fft_int_size_
`include "size_ctrl.sv"
`include "cascade_0.sv"
`include "cascade_n.sv"

// Integer resizable streaming FFT
module fft_int_size #(parameter
	POW = 9, // max fft size 2**POW
	DATA_WIDTH = 32,
	POW_WIDTH = (2**$clog2(POW) > POW - 1) ? $clog2(POW) : $clog2(POW) + 1,
	RES_WIDTH = DATA_WIDTH + POW
)(
	input clk, aclr,
	
	// input data stream
	input sink_sop, sink_eop, sink_valid, // valid signal must be solid between sop and eop
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	
	// FFT length 2**pow
	input [POW_WIDTH-1:0] pow, // 4..POW
	output pow_ready, // pow ready to change
	
	// Result data stream
	output reg source_sop, source_eop, source_valid,
	output reg signed [RES_WIDTH-1:0] source_Re, source_Im,
	
	output error
);
	wire [POW-1:0][POW-1:0] fft_rdaddr;
	wire [POW-1:0] fft_rdack;
	wire [POW:0] ready;
	
	logic [POW:0][POW-1:0] rdaddr;
	logic [POW:0] rdack;
	
	genvar k;
	generate for (k = 0; k <= POW; k++)
		begin :res
			wire signed [DATA_WIDTH + k - 1:0] re, im;
		end
	endgenerate
	
	wire [POW_WIDTH-1:0] pow_reg;
	wire [POW-1:0] addr_max;
	wire [1:0] err;
	
	wire sop_reg, eop_reg, valid_reg;
	wire signed [DATA_WIDTH-1:0] re_reg, im_reg;
	
	size_ctrl #(.POW(POW), .DATA_WIDTH(DATA_WIDTH)) size_inst(
		.clk, .aclr, .pow, .source_eop,		
		.pow_reg, .addr_max,	.pow_ready, .error(err[0]),
		
		.sink_sop, .sink_eop, .sink_valid, .sink_Re, .sink_Im,	
		.sop_reg, .eop_reg, .valid_reg, .re_reg, .im_reg
	);
	
	// input controller
	cascade_0 #(.ADDR_WIDTH(POW), .DATA_WIDTH(DATA_WIDTH)) c0(
		.clk, .aclr,
		.sink_sop(sop_reg), .sink_eop(eop_reg), .sink_valid(valid_reg), .sink_Re(re_reg), .sink_Im(im_reg),
		.pow(pow_reg), .addr_max,
		
		.rdaddr(rdaddr[0]),
		.q_Re(res[0].re), .q_Im(res[0].im),
		.ready(ready[0]),
		.rdack(rdack[0]),
		.error(err[1])
	);
	
	always_comb begin
		rdaddr[0] = fft_rdaddr[0];
		rdack[0] = fft_rdack[0];
	end
	
	reg [POW-1:0] cnt = '0;
	genvar i;	
	generate
		for (i = 1; i <= POW; i++)
			begin :gen
				cascade_n #(.ADDR_WIDTH(POW), .DATA_WIDTH(DATA_WIDTH + i - 1), .POW(i)) cn(
					.clk, .aclr, .sink_ready(ready[i-1] && pow_reg >= i),
					.sink_rdaddr(fft_rdaddr[i-1]),
					.sink_Re(res[i-1].re), .sink_Im(res[i-1].im),
					.sink_rdack(fft_rdack[i-1]),
					.pow(pow_reg), .addr_max,
					
					.source_rdaddr(rdaddr[i]),
					.source_rdack(rdack[i]),
					.source_Re(res[i].re), .source_Im(res[i].im),
					.source_ready(ready[i])
				);
				
				if (i < 4)
					begin
						always_comb
							begin
								rdaddr[i] = fft_rdaddr[i];
								rdack[i] = fft_rdack[i];
							end
					end
				else if (i == POW)
					begin
						always_comb begin
							rdaddr[POW] = cnt;
							rdack[POW] = cnt == '1;
						end
					end
				else
					begin
						always_comb
							if (pow_reg > i)
								begin // todo: use 2 ports memory to read data
									rdaddr[i] = fft_rdaddr[i];
									rdack[i] = fft_rdack[i];
								end
							else
								begin
									rdaddr[i] = cnt;
									rdack[i] = cnt == addr_max;
								end
					end
			end
	endgenerate
	
	// Read data from last cascade
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			cnt <= '0;
		else if (!ready[pow_reg] || cnt == addr_max)
			cnt <= '0;
		else
			cnt <= cnt + 1'b1;
	
	reg res_sop, res_eop, res_valid = 1'b0;
	
	always_ff @(posedge clk) begin
		res_sop <= ready[pow_reg] && cnt == '0;
		res_eop <= cnt == addr_max;
	end
	
	always_ff @(posedge clk, posedge aclr)
		res_valid <= (aclr) ? 1'b0 : ready[pow_reg] || rdack[pow_reg];
	
	// form result
	// todo: 2 regs
	wire signed [RES_WIDTH - 1:0] res_re[2**POW_WIDTH], res_im[2**POW_WIDTH];
	
	genvar m;
	generate for (m = 0; m < 2**POW_WIDTH; m++)
		begin :gen_res
			if (m >= 4 && m <= POW)
				begin
					assign res_re[m] = RES_WIDTH'('sh0) + signed'(res[m].re);
					assign res_im[m] = RES_WIDTH'('sh0) + signed'(res[m].im);
				end
			else
				begin
					assign res_re[m] = 'sh0;
					assign res_im[m] = 'sh0;
				end
		end
	endgenerate
	
	always_ff @(posedge clk) begin
		source_sop <= res_sop;
		source_eop <= res_eop;
		
		source_Re <= res_re[pow_reg];
		source_Im <= res_im[pow_reg];
	end
	
	always_ff @(posedge clk, posedge aclr)
		source_valid <= (aclr) ? 1'b0 : res_valid;
	
	assign error = |err;
	
endmodule :fft_int_size

`endif
