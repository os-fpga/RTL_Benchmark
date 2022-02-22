module r2048x8_2048x8 (WA,RA,WD,WClk,RClk,WClk_En,RClk_En,WEN,RD);

input [10:0] WA;
input [10:0] RA;
input WClk,RClk;
input WClk_En,RClk_En;
input WEN;
input [7:0] WD;
output [7:0] RD;

parameter memfile ="init_2048x8.hex";	

parameter addr_int = 11 ;
parameter data_depth_int = 2048;
parameter data_width_int = 8;
parameter wr_enable_int = 1;
parameter reg_rd_int = 0;

reg  [7:0] RD;

reg [data_width_int-1:0] 		mem [0: data_depth_int-1] /* verilator public */;

always @(posedge WClk) begin
  if (WEN) mem[WA][7:0]   <= WD[7:0];
end

always @(posedge RClk) begin
  RD <= mem[RA];
end

initial
  if(|memfile) begin
`ifndef ISE
    $display("Preloading %m from %s", memfile);
`endif
    $readmemh(memfile, mem);
  end

endmodule

