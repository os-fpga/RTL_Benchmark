

`include "global.inc"

module n22_rst_ctrl (

`ifdef N22_HAS_DEBUG
  output hart_under_reset,
`endif
  input  clk_aon,
  input  por_reset_n,
  input  core_reset_n,
  input  reset_bypass,



  output rst_core,

  output rst_aon

);


wire  rst_n_a;

wire  byp_core_reset_n = reset_bypass ? 1'b1 :
                       (
                         core_reset_n
                       );

assign rst_n_a = (por_reset_n & byp_core_reset_n);

wire rst_n_sync;





n22_reset_sync u_n22_reset_sync(
  .clk      (clk_aon),
  .rst_n_a  (rst_n_a),
  .reset_bypass(reset_bypass),
  .rst_n_sync(rst_n_sync)
);




 assign rst_core = rst_n_sync;

 assign rst_aon = rst_n_sync;

`ifdef N22_HAS_DEBUG
  wire reset_flag_r;
  n22_gnrl_dffrs #(1) reset_flag_dffrs (1'b0, reset_flag_r, clk_aon, rst_core);
  assign hart_under_reset = reset_flag_r;

`endif


endmodule

