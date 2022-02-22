module t_dpram_sclka #(parameter AWIDTH = 5,
parameter DWIDTH = 32, parameter DEPTH = 32)
(
	data_a, 
  data_b,
	addr_a, 
  addr_b,
	we_a,
  we_b, 
  clk,
	q_a, 
  q_b
);

  input [DWIDTH-1 :0] data_a, data_b;
  input [AWIDTH-1 :0] addr_a, addr_b;
  input we_a, we_b, clk;
  output reg [DWIDTH-1 :0] q_a, q_b;
  
	// Declare the RAM variable
	reg [DWIDTH-1 :0] ram[DEPTH-1 :0];
	
	// Port A
	always @ (posedge clk)
	begin
		if (we_a) 
			ram[addr_a] <= data_a;
		q_b <= ram[addr_b];
	end
	
	// Port B
/* 	always @ (posedge clk)
	begin
		if (we_b)
		begin
			ram[addr_b] <= data_b;
			q_b <= data_b;
		end
		else
		begin
			q_b <= ram[addr_b];
		end
	end */
	
endmodule
