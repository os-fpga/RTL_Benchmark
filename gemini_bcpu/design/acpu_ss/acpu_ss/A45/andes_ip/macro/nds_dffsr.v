// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module nds_dffsr (
		  dout,
		  din,
		  wen,
		  clk,
		  set_n,
		  reset_n

);
parameter DATA_WIDTH = 1;

output	[DATA_WIDTH-1:0]
		dout;

input	[DATA_WIDTH-1:0]
		din;
input		wen;

input		clk;
input		set_n;
input		reset_n;

reg	[DATA_WIDTH-1:0]
		dout;


always @(posedge clk or negedge set_n or negedge reset_n) begin
        if (!reset_n)
                dout <= {DATA_WIDTH{1'b0}};
        else if (!set_n)
                dout <= {DATA_WIDTH{1'b1}};
	else if (wen)
		dout <= din;
end


endmodule

