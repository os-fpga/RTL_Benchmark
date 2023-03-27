module   pscc_rstgen_mux(
output   Z,
input    A, //synch_rst
input    B, //rst_n
input    S  //scan_mode 
);
assign   Z  = ((S&B)|((!S)&A));
endmodule

