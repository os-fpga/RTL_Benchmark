module r512x32_512x32 (WA,RA,WD,WClk,RClk,WClk_En,RClk_En,WEN,RD);

input [8:0] WA;
input [8:0] RA;
input WClk,RClk;
input WClk_En,RClk_En;
input [3:0] WEN;
input [31:0] WD;
output [31:0] RD;

parameter memfile ="init_512x32.hex";	

parameter addr_int = 9 ;
parameter data_depth_int = 512;
parameter data_width_int = 32;
parameter wr_enable_int = 4;
parameter reg_rd_int = 0;

reg  [31:0] RD;

reg [data_width_int-1:0] 		mem [0: data_depth_int-1] /* verilator public */;

always @(posedge WClk) begin
  if (WEN[0]) mem[WA][7:0]    <= WD[7:0];
  if (WEN[1]) mem[WA][15:8]   <= WD[15:8];
  if (WEN[2]) mem[WA][23:16]  <= WD[23:16];
  if (WEN[3]) mem[WA][31:24]  <= WD[31:24];
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

