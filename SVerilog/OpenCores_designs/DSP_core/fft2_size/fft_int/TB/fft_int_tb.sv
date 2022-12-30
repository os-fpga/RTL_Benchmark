timeunit 1ns;
timeprecision 1ns;
`include "ifft_int.sv"

module fft_int_tb;
	localparam POW = 6;
	localparam DATA_WIDTH = 32;
	localparam RES_WIDTH = DATA_WIDTH + POW;
	
	bit clk = 0, aclr = 1;
	bit sink_sop = 0, sink_eop = 0, sink_valid = 0;
	bit signed [DATA_WIDTH-1:0] sink_Re = 0, sink_Im = 0;
	wire source_sop, source_eop, source_valid;
	wire signed [RES_WIDTH-1:0] source_Re, source_Im;
	wire error;
	
	localparam time period = 20ns;
	always #(period/2) clk++;
	
	initial begin
		repeat(10) @(posedge clk);
		aclr = 0;
		repeat(10) @(posedge clk);
		
		@(posedge clk);
		Test(2**POW, 1<<1);
		Test(2**POW, 1<<2);
		Test(2**POW, 5<<1);

//		TestLine(2**POW);
//		TestConst(2**POW);
		
		wait (source_eop || error);			
		if (error) $warning("Error");
		
		repeat(2**POW * 3 * 3) @(posedge clk);
		$stop(2);
	end
	
	always #(period * 2**POW * 10) begin
		$warning("Timeout");
		$stop(2);
	end
	
	fft_int #(.POW(POW), .DATA_WIDTH(DATA_WIDTH)) dut(.*);
	
	wire signed [DATA_WIDTH-1:0] ifft_source_Re, ifft_source_Im;
	wire ifft_sop, ifft_eop, ifft_valid;
	wire ifft_err;
	
	ifft_int #(.POW(POW), .DATA_WIDTH(RES_WIDTH)) ifft_inst(
		.clk, .aclr,
		.sink_sop(source_sop), .sink_eop(source_eop), .sink_valid(source_valid),
		.sink_Re(source_Re), .sink_Im(source_Im),
		
		.source_sop(ifft_sop), .source_eop(ifft_eop), .source_valid(ifft_valid),
		.source_Re(ifft_source_Re), .source_Im(ifft_source_Im),
		.error(ifft_err)
	);
	
	
	task Test(int len, int bin_msk = 2);
		int ar[];
		ar = new[len];
		
		for (int i = 0; i < len; i++)
			if ((bin_msk & 1<<i) != 0)
				ar[i] = 1<<16;
			else
				ar[i] = 0;
		
		for (int i = 0; i < len; i++) begin			
			sink_sop = i == 0;
			sink_eop = i == len - 1;
			sink_valid = 1;
			sink_Re = ar[i];
			@(posedge clk);
		end
		
		sink_sop = 0;
		sink_eop = 0;
		sink_valid = 0;
		sink_Re = 0;
		
		ar.delete();
	endtask
	
	task TestLine(int len);
		int ar_Im[], ar_Re[];
		ar_Re = new[len];
		ar_Im = new[len];		
		
		for (int i = 0; i < len; i++) begin
			ar_Re[i] = (i+1) * 2**16;
			ar_Im[i] = 0;
//			ar_Im[i] = -(i+1);
		end
		
		for (int i = 0; i < len; i++) begin			
			sink_sop = i == 0;
			sink_eop = i == len - 1;
			sink_valid = 1;
			sink_Re = ar_Re[i];
			sink_Im = ar_Im[i];
			@(posedge clk);
		end
		
		sink_sop = 0;
		sink_eop = 0;
		sink_valid = 0;
		sink_Re = 0;
		sink_Im = 0;
		
		ar_Re.delete();
		ar_Im.delete();
	endtask
	
	task TestConst(int len);		
		for (int i = 0; i < len; i++) begin			
			sink_sop = i == 0;
			sink_eop = i == len - 1;
			sink_valid = 1;
			sink_Re = 2**16;
			sink_Im = -(2**16);
			@(posedge clk);
		end
		
		sink_sop = 0;
		sink_eop = 0;
		sink_valid = 0;
		sink_Re = 0;
		sink_Im = 0;
	endtask
	
endmodule :fft_int_tb
