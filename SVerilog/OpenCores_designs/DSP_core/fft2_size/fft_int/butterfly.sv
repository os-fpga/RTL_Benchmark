`ifndef _butterfly_
`define _butterfly_
`include "W_int32.sv"

// Delay 3, 4
module butterfly #(parameter DATA_WIDTH = 32, W_WIDTH = 32, POW = 3)(
	input clk,
	input sync, // y
	input signed [DATA_WIDTH-1:0] sink_Re, sink_Im,
	output reg signed [DATA_WIDTH:0] source_Re, source_Im
);
	reg [POW-1:0] cnt;
	
	always_ff @(posedge clk)
		if (sync)
			cnt <= '0;
		else
			cnt <= cnt + 1'b1;
	
	generate
		if (POW == 1) // delay 3
			begin :gen1
				wire x_yn;
				reg signed [DATA_WIDTH-1:0] Re_reg[2], Im_reg[2];
				reg signed [DATA_WIDTH:0] new_x_Re, new_x_Im;
				
				assign x_yn = cnt[0];
				
				// W = 1
				always_ff @(posedge clk) begin
					Re_reg[0] <= sink_Re;
					Im_reg[0] <= sink_Im;
					Re_reg[1] <= Re_reg[0];					
					Im_reg[1] <= Im_reg[0];
				end
				
				always_ff @(posedge clk)
					if (x_yn == 1'b1)
						begin
							new_x_Re <= Re_reg[0] + Re_reg[1]; // x + y
							new_x_Im <= Im_reg[0] + Im_reg[1];
							source_Re <= Re_reg[0] - Re_reg[1]; // x - y
							source_Im <= Im_reg[0] - Im_reg[1];
						end
					else
						begin
							source_Re <= new_x_Re;
							source_Im <= new_x_Im;
						end
			end
		else if (POW == 2) // delay 3
			begin :gen2	
				wire x_yn, k;
				reg signed [DATA_WIDTH-1:0] Re_reg, Im_reg;
				reg signed [DATA_WIDTH-1:0] wy_Re, wy_Im;
				reg signed [DATA_WIDTH:0] new_x_Re, new_x_Im;
				
				assign x_yn = cnt[0];
				assign k = cnt[1];				
				
				always_ff @(posedge clk) begin
					Re_reg <= sink_Re;
					Im_reg <= sink_Im;
				end
				
				always_ff @(posedge clk)
					if (x_yn == 1'b0)
						case (k)
							1'b0: // 1
								begin
									wy_Re <= Re_reg;
									wy_Im <= Im_reg;
								end
							1'b1: // -j: -j * (a + j*b) = b - j*a
								begin
									wy_Re <= Im_reg;
									wy_Im <= DATA_WIDTH'('sh0) - Re_reg;
								end
						endcase
				
				always_ff @(posedge clk)
					if (x_yn == 1'b1)
						begin
							new_x_Re <= Re_reg + wy_Re; // x + w*y
							new_x_Im <= Im_reg + wy_Im;
							source_Re <= Re_reg - wy_Re; // x - w*y
							source_Im <= Im_reg - wy_Im;
						end
					else
						begin
							source_Re <= new_x_Re;
							source_Im <= new_x_Im;
						end
			end
		else // delay 4
			begin :gen3
				reg x_yn;
				wire [POW-2:0] k;
				reg signed [DATA_WIDTH-1:0] Re_reg[2], Im_reg[2];
				wire signed [W_WIDTH-1:0] W_Re, W_Im;
				reg signed [W_WIDTH + DATA_WIDTH:0] wy_Re, wy_Im;
				wire signed [DATA_WIDTH-1:0] wy_Re_tr, wy_Im_tr;
				reg signed [DATA_WIDTH:0] new_x_Re, new_x_Im;
						
				always_ff @(posedge clk)
					begin
						Re_reg[0] <= sink_Re;
						Im_reg[0] <= sink_Im;
						Re_reg[1] <= Re_reg[0];						
						Im_reg[1] <= Im_reg[0];
						x_yn <= cnt[0];
					end
				
				assign k = cnt[POW-1:1];
				
				W_int32 #(.POW(POW), .W_WIDTH(W_WIDTH)) W_inst(.clk, .k, .W_Re, .W_Im);
				
				// w * y = (wr + wi * j) * (yr + yi * j) = wr * yr  - wi * yi + j * (wi * yr + wr * yi)
				always_ff @(posedge clk)
					if (x_yn == 1'b0)
						begin
							wy_Re <= W_Re * Re_reg[1] - W_Im * Im_reg[1];
							wy_Im <= W_Re * Im_reg[1] + W_Im * Re_reg[1];
						end
				
				assign wy_Re_tr = wy_Re[(W_WIDTH-2)+:DATA_WIDTH];
				assign wy_Im_tr = wy_Im[(W_WIDTH-2)+:DATA_WIDTH];
				
				always_ff @(posedge clk)
					if (x_yn == 1'b1)
						begin
							new_x_Re <= Re_reg[1] + wy_Re_tr; // x
							new_x_Im <= Im_reg[1] + wy_Im_tr;
							source_Re <= Re_reg[1] - wy_Re_tr; // y
							source_Im <= Im_reg[1] - wy_Im_tr;
						end
					else
						begin
							source_Re <= new_x_Re;
							source_Im <= new_x_Im;
						end
			end
	endgenerate
endmodule :butterfly

`endif
