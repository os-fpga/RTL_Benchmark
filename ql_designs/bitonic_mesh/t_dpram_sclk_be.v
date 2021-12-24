module t_dpram_sclk_be
(
	input [31:0] data_a, data_b,
  input [3:0] be_a, be_b,
	input [5:0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [31:0] q_a, q_b
);
	// Declare the RAM variable
	reg [31:0] ram[63:0];
  
  wire we_int;
  wire [31 :0] data_wr;
  wire [5:0] addr_wr;
  //wire [3:0] be_int;
  
  //assign be_int = (we_b)? be_b: be_a;
  assign data_wr = (we_b)? data_b: data_a;
  assign addr_wr = (we_b)? addr_b: addr_a;
  assign we_int = we_a | we_b;
	
	// Port A
	always @ (posedge clk)
	begin
		if (we_int) 
			ram[addr_wr] <= data_wr;

		q_a <= ram[addr_a];

	end
  
	// Port B
/* 	always @ (posedge clk)
	begin
		if (we_b & be_b[0]) 
			ram[addr_b][7:0] <= data_b[7:0];
		if (we_b & be_b[1]) 
			ram[addr_b][15:8] <= data_b[15:8];	
		if (we_b & be_b[2]) 
			ram[addr_b][23:16] <= data_b[23:16];
		if (we_b & be_b[3]) 
			ram[addr_b][31:24] <= data_b[31:24];      

			q_b <= ram[addr_b];

	end */
	
endmodule
