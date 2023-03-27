
`include "global.inc"

`ifdef N22_HAS_CLIC
module n22_clicintip_gen #(
    parameter INDEX = 1,
    parameter IRQ_NUM_LOG2 = 5
)(
    input  clk_aon,
    input  rst_n,
    input  clic_irq_i,
    input  [1:0] clicintattr_trig_r,
    input  edge_trig_ip_clr_en,
    input  [IRQ_NUM_LOG2-1:0] irq_id_top_r,
    input  icb_cmd_byte_sel_ip,
    input  icb_cmd_wr_hsked,
    input  [31:0] icb_cmd_wdata,
    output [7:0] clicintip_r
);

wire clic_irq_r;
wire [7:0] clicintip_nxt;
n22_gnrl_dffr #(1) n22_clic_irq_dffr(clic_irq_i,clic_irq_r,clk_aon,rst_n);

wire irq_p_edge_valid = clic_irq_i & (~clic_irq_r);
wire irq_n_edge_valid= (~clic_irq_i) & clic_irq_r;

wire clicintip_wen = icb_cmd_byte_sel_ip & icb_cmd_wr_hsked;

wire [7:0] clicintip;

wire clicintip_set = (~clicintip[0]) & (clicintattr_trig_r[0]) & (clicintattr_trig_r[1] ? irq_n_edge_valid :
                                                                irq_p_edge_valid);
wire clicintip_clr = edge_trig_ip_clr_en & (clicintattr_trig_r[0]) & (irq_id_top_r == INDEX[IRQ_NUM_LOG2-1:0]);
wire [7:0] clicintip_edge_trig;

assign clicintip_nxt = clicintip_wen ? {7'b0,icb_cmd_wdata[0]} :
                       clicintip_set ? 8'b1 :
                       clicintip_clr ? 8'b0 :
                       clicintip_edge_trig;


wire clicintip_ena = clicintip_wen | clicintip_set | clicintip_clr;
n22_gnrl_dfflr #(8) n22_clicintip_dfflr(clicintip_ena, clicintip_nxt, clicintip_edge_trig, clk_aon, rst_n);

assign clicintip = clicintattr_trig_r[0] ? clicintip_edge_trig : {7'b0,clic_irq_r};

assign clicintip_r = clicintip;

endmodule
`endif
