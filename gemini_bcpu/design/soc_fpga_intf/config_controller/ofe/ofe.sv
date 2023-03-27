module ofe #(
  parameter REGS_NUM = 1 ,
  parameter DWIDTH   = 32
) (
  input  logic                clk        ,
  input  logic                rst_n      ,
  // read apb_manager
  output logic                rack_o     ,
  output logic                rerr_o     ,
  output logic [  DWIDTH-1:0] rdat_o     ,
  input  logic [REGS_NUM-1:0] rreq_i     ,
  // write apb_manager
  output logic                wack_o     ,
  output logic                werr_o     ,
  input  logic [  DWIDTH-1:0] wdat_i     ,
  input  logic [REGS_NUM-1:0] wreq_i     ,
  input  logic [DWIDTH/8-1:0] wstr_i     ,
  // cfg status
  output logic                cfg_done   ,
  input  logic                pll3_status,
  input  logic                pll2_status,
  input  logic                pll1_status,
  input  logic                pll0_status,
  input  logic                icb_status ,
  input  logic                fcb_status
);
 

  ofe_regs #(
    .REGS_NUM(REGS_NUM),
    .DWIDTH  (DWIDTH  )
  ) ofe_regs_u (
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .rack_o     (rack_o     ),
    .rerr_o     (rerr_o     ),
    .rdat_o     (rdat_o     ),
    .rreq_i     (rreq_i     ),
    .wack_o     (wack_o     ),
    .werr_o     (werr_o     ),
    .wdat_i     (wdat_i     ),
    .wreq_i     (wreq_i     ),
    .wstr_i     (wstr_i     ),
    .cfg_done   (cfg_done   ),
    .pll3_status(pll3_status),
    .pll2_status(pll2_status),
    .pll1_status(pll1_status),
    .pll0_status(pll0_status),
    .icb_status (icb_status ),
    .fcb_status (fcb_status )
  );



endmodule                       