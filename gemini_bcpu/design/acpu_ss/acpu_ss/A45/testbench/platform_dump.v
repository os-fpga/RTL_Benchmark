// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale 1ns/1ns

module platform_dump;
supply0 dummy_wire;
`ifdef DUMP
initial begin
	`ifdef TRN
		$recordfile("verilog.trn");
	`else
	`ifdef FSDB
		$fsdbDumpfile("verilog.fsdb");
	`else
	`ifdef VPD
		$vcdplusfile("verilog.vpd");
		$vcdplusautoflushon;
	`else
		$dumpfile("verilog.vcd");
	`endif
	`endif
	`endif

#0;

	`ifdef TRN
		$recordvars;
	`else
	`ifdef FSDB
		$fsdbDumpvars;
	`else
	`ifdef VPD
		$vcdpluson;
	`else
		$dumpvars;
	`endif
	`endif
	`endif
end
`endif
endmodule
