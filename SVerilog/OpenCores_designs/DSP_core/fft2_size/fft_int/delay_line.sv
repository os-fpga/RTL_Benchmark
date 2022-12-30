`ifndef _delay_line_
`define _delay_line_

module delay_lines_reg #(parameter DELAY = 300, WIDTH = 3)(
	input aclr, sclr, clock, clock_ena,
	input [WIDTH-1:0] sig_in,
	output [WIDTH-1:0] sig_out
);

genvar i;
generate for (i = 0; i < WIDTH; i++)
	begin :line
		delay_line_reg #(.DELAY(DELAY)) delay_line_inst(.aclr, .sclr, .clock, .clock_ena, .sig_in(sig_in[i]), .sig_out(sig_out[i]));
	end
endgenerate

endmodule :delay_lines_reg

module delay_line_reg #(parameter DELAY = 300)(input aclr, sclr, clock, clock_ena, sig_in, output sig_out);

generate
	if (DELAY == 0)
		assign sig_out = !aclr && !sclr && sig_in;
	else if (DELAY == 1)
		begin
			reg sig_reg = 1'b0;
			
			always_ff @(posedge clock, posedge aclr)
				if (aclr)				sig_reg <= 1'b0;
				else if (sclr)			sig_reg <= 1'b0;
				else if (clock_ena)	sig_reg <= sig_in;
			
			assign sig_out = sig_reg;
		end
	else
		begin
			reg [DELAY-1:0] sig_reg = '0;
		
			always_ff @(posedge clock, posedge aclr)
				if (aclr)				sig_reg <= '0;
				else if (sclr)			sig_reg <= '0;
				else if (clock_ena)	sig_reg <= {sig_reg[DELAY-2:0], sig_in};
			
			assign sig_out = sig_reg[DELAY-1];			
		end
endgenerate

endmodule :delay_line_reg

`endif
