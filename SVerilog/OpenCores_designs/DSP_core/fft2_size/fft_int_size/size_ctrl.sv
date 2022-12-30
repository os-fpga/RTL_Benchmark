`ifndef _size_ctrl_
`define _size_ctrl_

// FFT controller
module size_ctrl #(parameter
	POW = 14, // up to 2**POW FFT length
	DATA_WIDTH = 32,
	POW_WIDTH = (2**$clog2(POW) > POW - 1) ? $clog2(POW) : $clog2(POW) + 1
)(
	input clk, aclr,
	input [POW_WIDTH-1:0] pow, // 4..POW - FFT size is 2**pow
	input source_eop, // end of FFT
	output reg [POW_WIDTH-1:0] pow_reg, // current FFT pow
	output reg [POW-1:0] addr_max, // current last FFT data number
	output reg pow_ready, // pow ready to change
	output reg error, // error of parameter pow
	
	// input data stream
	input sink_sop, sink_eop, sink_valid,
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	// output data stream
	output reg sop_reg, eop_reg, valid_reg,
	output reg signed [DATA_WIDTH-1:0] re_reg, im_reg
);
	reg [1:0] tsk_cnt = '0; // fft tasks counter
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			begin
				pow_reg <= POW_WIDTH'(POW);
				addr_max <= {POW{1'b1}};
			end
		else if (pow > POW)
			begin
				pow_reg <= POW_WIDTH'(POW);
				addr_max <= {POW{1'b1}};
			end
		else if (pow_ready && sink_sop && sink_valid)
			begin
				pow_reg <= pow;
				addr_max <= {POW{1'b1}}>>(POW - pow);
			end
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			tsk_cnt <= '0;
		else if (sink_sop && sink_valid && source_eop)
			;
		else if (sink_sop && sink_valid)
			tsk_cnt <= tsk_cnt + 1'b1;
		else if (source_eop)
			tsk_cnt <= tsk_cnt - 1'b1;
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			pow_ready <= 1'b0;
		else if (sink_sop && sink_valid)
			pow_ready <= 1'b0;
		else if (source_eop && tsk_cnt == 'd1)
			pow_ready <= 1'b1;
		else
			pow_ready <= tsk_cnt == '0;
	
	always_ff @(posedge clk, posedge aclr)
		if (aclr)
			error <= 1'b0;
		else if (sink_sop && sink_valid && (pow != pow_reg && !pow_ready || pow < 4 || pow > POW))
			error <= 1'b1;
	
	always_ff @(posedge clk, posedge aclr)
		valid_reg <= (aclr) ? 1'b0 : sink_valid;
		
	always_ff @(posedge clk) begin
		sop_reg <= sink_sop;
		eop_reg <= sink_eop;
		re_reg <= sink_Re;
		im_reg <= sink_Im;
	end
	
endmodule :size_ctrl

`endif
