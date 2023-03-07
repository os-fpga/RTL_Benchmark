// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



module atcexmon300_bin2mask (
        	  out,
        	  in
);
parameter N = 8;
localparam W = $unsigned($clog2(N));

output   [N-1:0] out;
input    [W-1:0] in;

assign out = {(N){1'b1}} << in;

endmodule


