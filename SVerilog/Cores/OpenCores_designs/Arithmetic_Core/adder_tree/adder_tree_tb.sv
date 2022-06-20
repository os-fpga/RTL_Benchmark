timeunit 1ns;
timeprecision 1ps;

module adder_tree_tb;

localparam N = 10;
localparam DATA_WIDTH = 12;
localparam RESULT_WIDTH = ((N-1) < 2**$clog2(N)) ? DATA_WIDTH + $clog2(N) : DATA_WIDTH + $clog2(N) + 1;

bit clock = 0, clock_ena = 1;

logic signed [DATA_WIDTH-1:0] data[N-1:0];
wire signed [DATA_WIDTH-1:0] data_in[N-1:0]; // alias for wave form

wire signed [RESULT_WIDTH-1:0] result;
bit signed [RESULT_WIDTH-1:0] sum = 0;

always #10ns clock++;

initial begin
	static bit sign = 0, error = 0;
	
	repeat(10) @(posedge clock);
	
	// Test 1
	for (int i = 0; i < N; i++)
		begin
			data[i] = i + 1;
			if (sign++) data[i] = -data[i];
		end
	
	sum = 0;
	for (int i = 0; i < N; i++)
		sum += data[i];
	
	repeat(100) @(posedge clock);	
	assert (sum == result) else error |= 1;
	
	// Test 2	
	for (int i = 0; i < N; i++)
		data[i] = data[i]*(i+1);
	
	sum = 0;
	for (int i = 0; i < N; i++)
		sum += data[i];
	
	repeat(100) @(posedge clock);
	assert (sum == result) else error |= 1;
	
	// Test 3
	for (int i = 0; i < N; i++)
		data[i] = $signed( {1'b0, {(DATA_WIDTH-1){1'b1}}} ); // max value
	
	sum = 0;
	for (int i = 0; i < N; i++)
		sum += data[i];
	
	repeat(100) @(posedge clock);
	assert (sum == result) else error |= 1;
	
	if (error)
		$display("ERROR");
	else
		$display("Test OK!");
	
	$stop(2);
end

adder_tree #(.N(N), .DATA_WIDTH(DATA_WIDTH)) dut(.*);

genvar j;

generate for (j = 0; j < N; j++)
	begin :gen
		assign data_in[j] = data[j];
	end
endgenerate

endmodule
