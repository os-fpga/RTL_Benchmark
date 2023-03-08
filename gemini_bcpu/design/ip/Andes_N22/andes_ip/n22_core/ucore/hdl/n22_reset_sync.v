

`include "global.inc"

module n22_reset_sync (
  input  clk,
  input  rst_n_a,
  input  reset_bypass,
  output rst_n_sync
);


localparam RST_SYNC_LEVEL = `N22_ASYNC_FF_LEVELS;

reg [RST_SYNC_LEVEL-1:0] rst_sync_r;


always @(posedge clk or negedge rst_n_a)
begin:gen_rst_sync_PROC
  if(rst_n_a == 1'b0)
    begin
      rst_sync_r[RST_SYNC_LEVEL-1:0] <= {RST_SYNC_LEVEL{1'b0}};
    end
  else
    begin
      rst_sync_r[RST_SYNC_LEVEL-1:0] <= {rst_sync_r[RST_SYNC_LEVEL-2:0],1'b1};
    end
end

 assign rst_n_sync = reset_bypass ? rst_n_a : rst_sync_r[`N22_ASYNC_FF_LEVELS-1];



endmodule

