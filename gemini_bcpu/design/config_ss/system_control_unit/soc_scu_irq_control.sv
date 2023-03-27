module soc_scu_irq_control (
  // clock and reset
  input  logic             clk_bcpu         ,
  input  logic             rst_n_bcpu       ,
  input  logic             clk_acpu         ,
  input  logic             rst_n_acpu       ,
  input  logic             clk_cru          ,
  input  logic             rst_n_per        ,  
  // interrupt control
  input  logic [31:0][2:0] irq_map          ,
  input  logic [31:0]      irq_mask         ,
  // input interrupts
  input  logic             acpu_watchdog_irq,
  input  logic             bcpu_watchdog_irq,
  input  logic             timer_irq        ,
  input  logic             usb_irq          ,
  input  logic             emac_irq         ,
  input  logic             uart0_irq        ,
  input  logic             uart1_irq        ,
  input  logic             qspi_irq         ,
  input  logic             i2c_irq          ,
  input  logic             gpio_irq         ,
  input  logic             dma_irq          ,
  input  logic             ddr_irq          , 
  input  logic             acpu_mailbox_irq ,
  input  logic             bcpu_mailbox_irq ,
  input  logic             fpga0_mailbox_irq,
  input  logic             fpga1_mailbox_irq, 
  input  logic             pscc_irq         ,   
  input  logic [15:0]      fpga_irq_src     ,
  // output interrupt sets
  output logic [31:0]      acpu_irq_set     ,
  output logic [31:0]      bcpu_irq_set     ,
  output logic [12:0]      fpga_irq_set
);

logic [31:0] acpu_irq_set_w;
logic [31:0] acpu_irq_set_ff;
logic [31:0] bcpu_irq_set_w;
logic [31:0] bcpu_irq_set_ff;
logic [31:0] fpga_irq_set_w;
logic [31:0] fpga_irq_set_ff;
logic [15:0] fpga_irq_src_ff;


sync_ff #(
    .DWIDTH(16)
  ) fpga_irq_src_sync (
    .clk   (clk_cru),
    .rst_n (rst_n_per),
    .din   (fpga_irq_src),
    .dout  (fpga_irq_src_ff)
  );


assign acpu_irq_set_w = { 
                      irq_map[31] == 3'b010 ? irq_mask[31] & fpga_irq_src_ff[15] : 1'b0,
                      irq_map[30] == 3'b010 ? irq_mask[30] & fpga_irq_src_ff[14] : 1'b0,
                      irq_map[29] == 3'b010 ? irq_mask[29] & fpga_irq_src_ff[13] : 1'b0,
                      irq_map[28] == 3'b010 ? irq_mask[28] & fpga_irq_src_ff[12] : 1'b0,
                      irq_map[27] == 3'b010 ? irq_mask[27] & fpga_irq_src_ff[11] : 1'b0,
                      irq_map[26] == 3'b010 ? irq_mask[26] & fpga_irq_src_ff[10] : 1'b0,
                      irq_map[25] == 3'b010 ? irq_mask[25] & fpga_irq_src_ff[9] : 1'b0,
                      irq_map[24] == 3'b010 ? irq_mask[24] & fpga_irq_src_ff[8] : 1'b0,
                      irq_map[23] == 3'b010 ? irq_mask[23] & fpga_irq_src_ff[7] : 1'b0,
                      irq_map[22] == 3'b010 ? irq_mask[22] & fpga_irq_src_ff[6] : 1'b0,
                      irq_map[21] == 3'b010 ? irq_mask[21] & fpga_irq_src_ff[5] : 1'b0,
                      irq_map[20] == 3'b010 ? irq_mask[20] & fpga_irq_src_ff[4] : 1'b0,
                      irq_map[19] == 3'b010 ? irq_mask[19] & fpga_irq_src_ff[3] : 1'b0,
                      irq_map[18] == 3'b010 ? irq_mask[18] & fpga_irq_src_ff[2] : 1'b0,
                      irq_map[17] == 3'b010 ? irq_mask[17] & fpga_irq_src_ff[1] : 1'b0,
                      irq_map[16] == 3'b010 ? irq_mask[16] & fpga_irq_src_ff[0] : 1'b0,
                      1'b0,//reserved 
                      irq_map[14] == 3'b010 ? irq_mask[14] & pscc_irq : 1'b0, 
                      irq_map[13] == 3'b010 ? irq_mask[13] & fpga1_mailbox_irq : 1'b0,
                      irq_map[12] == 3'b010 ? irq_mask[12] & fpga0_mailbox_irq : 1'b0,
                      irq_map[11] == 3'b010 ? irq_mask[11] & bcpu_mailbox_irq : 1'b0,
                      irq_map[10] == 3'b010 ? irq_mask[10] & ddr_irq : 1'b0,
                      irq_map[9]  == 3'b010 ? irq_mask[9]  & dma_irq : 1'b0,
                      irq_map[8]  == 3'b010 ? irq_mask[8]  & gpio_irq : 1'b0,
                      irq_map[7]  == 3'b010 ? irq_mask[7]  & i2c_irq : 1'b0,
                      irq_map[6]  == 3'b010 ? irq_mask[6]  & qspi_irq : 1'b0,
                      irq_map[5]  == 3'b010 ? irq_mask[5]  & uart1_irq : 1'b0,
                      irq_map[4]  == 3'b010 ? irq_mask[4]  & uart0_irq : 1'b0,
                      irq_map[3]  == 3'b010 ? irq_mask[3]  & emac_irq : 1'b0,
                      irq_map[2]  == 3'b010 ? irq_mask[2]  & usb_irq : 1'b0,
                      irq_map[1]  == 3'b010 ? irq_mask[1]  & timer_irq : 1'b0,
                      irq_map[0]  == 3'b010 ? irq_mask[0]  & acpu_watchdog_irq : 1'b0
                      };
always @(posedge clk_acpu or negedge rst_n_acpu)
    if (!rst_n_acpu) acpu_irq_set_ff  <= 32'h0;
    else             acpu_irq_set_ff  <= acpu_irq_set_w;

assign acpu_irq_set = acpu_irq_set_ff;

assign bcpu_irq_set_w = { 
                      irq_map[31] == 3'b001 ? irq_mask[31] & fpga_irq_src_ff[15] : 1'b0,
                      irq_map[30] == 3'b001 ? irq_mask[30] & fpga_irq_src_ff[14] : 1'b0,
                      irq_map[29] == 3'b001 ? irq_mask[29] & fpga_irq_src_ff[13] : 1'b0,
                      irq_map[28] == 3'b001 ? irq_mask[28] & fpga_irq_src_ff[12] : 1'b0,
                      irq_map[27] == 3'b001 ? irq_mask[27] & fpga_irq_src_ff[11] : 1'b0,
                      irq_map[26] == 3'b001 ? irq_mask[26] & fpga_irq_src_ff[10] : 1'b0,
                      irq_map[25] == 3'b001 ? irq_mask[25] & fpga_irq_src_ff[9] : 1'b0,
                      irq_map[24] == 3'b001 ? irq_mask[24] & fpga_irq_src_ff[8] : 1'b0,
                      irq_map[23] == 3'b001 ? irq_mask[23] & fpga_irq_src_ff[7] : 1'b0,
                      irq_map[22] == 3'b001 ? irq_mask[22] & fpga_irq_src_ff[6] : 1'b0,
                      irq_map[21] == 3'b001 ? irq_mask[21] & fpga_irq_src_ff[5] : 1'b0,
                      irq_map[20] == 3'b001 ? irq_mask[20] & fpga_irq_src_ff[4] : 1'b0,
                      irq_map[19] == 3'b001 ? irq_mask[19] & fpga_irq_src_ff[3] : 1'b0,
                      irq_map[18] == 3'b001 ? irq_mask[18] & fpga_irq_src_ff[2] : 1'b0,
                      irq_map[17] == 3'b001 ? irq_mask[17] & fpga_irq_src_ff[1] : 1'b0,
                      irq_map[16] == 3'b001 ? irq_mask[16] & fpga_irq_src_ff[0] : 1'b0,
                      1'b0,//reserved 
                      irq_map[14] == 3'b001 ? irq_mask[14] & pscc_irq : 1'b0,
                      irq_map[13] == 3'b001 ? irq_mask[13] & fpga1_mailbox_irq : 1'b0,
                      irq_map[12] == 3'b001 ? irq_mask[12] & fpga0_mailbox_irq : 1'b0,
                      irq_map[11] == 3'b001 ? irq_mask[11] & acpu_mailbox_irq : 1'b0,
                      irq_map[10] == 3'b001 ? irq_mask[10] & ddr_irq : 1'b0,
                      irq_map[9]  == 3'b001 ? irq_mask[9]  & dma_irq : 1'b0,
                      irq_map[8]  == 3'b001 ? irq_mask[8]  & gpio_irq : 1'b0,
                      irq_map[7]  == 3'b001 ? irq_mask[7]  & i2c_irq : 1'b0,
                      irq_map[6]  == 3'b001 ? irq_mask[6]  & qspi_irq : 1'b0,
                      irq_map[5]  == 3'b001 ? irq_mask[5]  & uart1_irq : 1'b0,
                      irq_map[4]  == 3'b001 ? irq_mask[4]  & uart0_irq : 1'b0,
                      irq_map[3]  == 3'b001 ? irq_mask[3]  & emac_irq : 1'b0,
                      irq_map[2]  == 3'b001 ? irq_mask[2]  & usb_irq : 1'b0,
                      irq_map[1]  == 3'b001 ? irq_mask[1]  & timer_irq : 1'b0,
                      irq_map[0]  == 3'b001 ? irq_mask[0]  & bcpu_watchdog_irq : 1'b0
                      };

always @(posedge clk_bcpu or negedge rst_n_bcpu)
    if (!rst_n_bcpu) bcpu_irq_set_ff  <= 32'h0;
    else             bcpu_irq_set_ff  <= bcpu_irq_set_w;

assign bcpu_irq_set = bcpu_irq_set_ff;

assign fpga_irq_set_w = { 
                      19'h0,//reserved 
                      irq_map[12] == 3'b100 ? irq_mask[11] & pscc_irq : 1'b0,
                      irq_map[11] == 3'b100 ? irq_mask[11] & bcpu_mailbox_irq : 1'b0,
                      irq_map[10] == 3'b100 ? irq_mask[10] & acpu_watchdog_irq : 1'b0,
                      irq_map[9]  == 3'b100 ? irq_mask[9]  & ddr_irq : 1'b0,
                      irq_map[8]  == 3'b100 ? irq_mask[8]  & dma_irq : 1'b0,
                      irq_map[7]  == 3'b100 ? irq_mask[7]  & gpio_irq : 1'b0,
                      irq_map[6]  == 3'b100 ? irq_mask[6]  & i2c_irq : 1'b0,
                      irq_map[5]  == 3'b100 ? irq_mask[5]  & qspi_irq : 1'b0,
                      irq_map[4]  == 3'b100 ? irq_mask[4]  & uart1_irq : 1'b0,
                      irq_map[3]  == 3'b100 ? irq_mask[3]  & uart0_irq : 1'b0,
                      irq_map[2]  == 3'b100 ? irq_mask[2]  & emac_irq : 1'b0,
                      irq_map[1]  == 3'b100 ? irq_mask[1]  & usb_irq : 1'b0,
                      irq_map[0]  == 3'b100 ? irq_mask[0]  & timer_irq : 1'b0
                      };

always @(posedge clk_cru or negedge rst_n_per)
    if (!rst_n_per) fpga_irq_set_ff  <= 32'h0;
    else            fpga_irq_set_ff  <= fpga_irq_set_w;

assign fpga_irq_set = fpga_irq_set_ff[12:0];

endmodule