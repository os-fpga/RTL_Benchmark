module   pscc_clksw_mux(
output   Z,
input    A, //osc_clk
input    B, //scan_clk
input    S  //scan_mode 
);
assign   Z  = ((S&B)|((!S)&A));
endmodule

