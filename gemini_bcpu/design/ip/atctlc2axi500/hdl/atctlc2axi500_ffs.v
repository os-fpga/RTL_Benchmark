// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



module atctlc2axi500_ffs (
        	  out,
        	  in
);


parameter WIDTH = 8;

output	[WIDTH-1:0] out;
input	[WIDTH-1:0] in;



wire    [WIDTH-1:0] s0;


assign s0 = ~in + {{(WIDTH-1){1'b0}}, 1'b1};
assign out = in & s0;

endmodule

