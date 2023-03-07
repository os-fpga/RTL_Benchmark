

`include "global.inc"

module n22_irq_sync (
  input  clk_aon,
  input  rst_n,

  input  rx_evt,

  input  nmi_irq,
  input  ext_irq,
  input  sft_irq,
  input  tmr_irq,

  output rx_evt_req,
  input  rx_evt_ack,

  input  nmi_irq_taken,

  output nmi_irq_r,
  output ext_irq_r,
  output sft_irq_r,
  output tmr_irq_r
);

n22_gnrl_dffr #(1) ext_irq_dffr(ext_irq, ext_irq_r, clk_aon, rst_n);
n22_gnrl_dffr #(1) sft_irq_dffr(sft_irq, sft_irq_r, clk_aon, rst_n);
n22_gnrl_dffr #(1) tmr_irq_dffr(tmr_irq, tmr_irq_r, clk_aon, rst_n);

wire rx_evt_r;
wire rx_evt_set = rx_evt;
wire rx_evt_clr = rx_evt_ack;
wire rx_evt_ena = rx_evt_set | rx_evt_clr;
wire rx_evt_nxt = rx_evt_set | (~rx_evt_clr);
n22_gnrl_dfflr #(1) rx_evt_dfflr (rx_evt_ena, rx_evt_nxt , rx_evt_r,  clk_aon, rst_n);

assign rx_evt_req = rx_evt_r;

wire nmi_irq_d1;
n22_gnrl_dffr #(1) nmi_irq_d_dffr(nmi_irq, nmi_irq_d1, clk_aon, rst_n);

wire nmi_irq_set = nmi_irq & (~nmi_irq_d1);
wire nmi_irq_clr = nmi_irq_taken;
wire nmi_irq_ena = nmi_irq_set | nmi_irq_clr;
wire nmi_irq_nxt = nmi_irq_set | (~nmi_irq_clr);
n22_gnrl_dfflr #(1) nmi_irq_dfflr(nmi_irq_ena, nmi_irq_nxt, nmi_irq_r, clk_aon, rst_n);

endmodule

