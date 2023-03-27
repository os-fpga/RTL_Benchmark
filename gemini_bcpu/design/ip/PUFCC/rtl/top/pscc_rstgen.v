module pscc_rstgen (
output         rst_out_n,
input          rst_n,
input          scan_mode,
input          clk
);
reg   [ 1:0]   synch_rst;

always@(posedge clk or negedge rst_n) begin
   if(~rst_n) synch_rst <= 2'b0;
   else synch_rst <= {synch_rst[0], 1'b1};
end

`ifdef USE_SCAN_MUX
pscc_rstgen_mux  I_RSTGENMUX
(
   .Z             (rst_out_n),
   .A             (synch_rst[1]),
   .B             (rst_n),
   .S             (scan_mode)
);
`else
assign rst_out_n  = synch_rst[1];
`endif
endmodule

