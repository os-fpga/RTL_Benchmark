

`include "global.inc"

module n22_tmr_main(

  input           clk,
  input           rst_n,

  input           icb_cmd_valid,
  output          icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0] icb_cmd_addr,
  input           icb_cmd_read,
  input  [32-1:0] icb_cmd_wdata,

  output          icb_rsp_valid,
  input           icb_rsp_ready,
  output [32-1:0] icb_rsp_rdata,

  output          tmr_irq,
  output          sft_irq,

  output          tmr_stop,

  output [`N22_XLEN-1:0] mtime_r,
  output [`N22_XLEN-1:0] mtimeh_r,

  input           io_rtctick
);

  localparam MSIP_ADDR      = `N22_MSIP_ADDR_OFST     ;
  localparam MSTOP_ADDR     = `N22_MSTOP_ADDR_OFST    ;
  localparam MTIMEL_ADDR    = `N22_MTIMEL_ADDR_OFST   ;
  localparam MTIMEH_ADDR    = `N22_MTIMEH_ADDR_OFST   ;
  localparam MTIMECMPL_ADDR = `N22_MTIMECMPL_ADDR_OFST;
  localparam MTIMECMPH_ADDR = `N22_MTIMECMPH_ADDR_OFST;

  wire s0    = icb_cmd_valid & icb_cmd_ready;
  wire s1 = s0 & (~icb_cmd_read);
  wire s2 = s0 & icb_cmd_read;


  wire s3      = (icb_cmd_addr[`N22_TMR_ADDR_WIDTH-1:0] == MSIP_ADDR     );
  wire s4 = (icb_cmd_addr[`N22_TMR_ADDR_WIDTH-1:0] == MTIMECMPL_ADDR);
  wire s5 = (icb_cmd_addr[`N22_TMR_ADDR_WIDTH-1:0] == MTIMECMPH_ADDR);
  wire s6    = (icb_cmd_addr[`N22_TMR_ADDR_WIDTH-1:0] == MTIMEL_ADDR    );
  wire s7    = (icb_cmd_addr[`N22_TMR_ADDR_WIDTH-1:0] == MTIMEH_ADDR    );
  wire s8      = (icb_cmd_addr[`N22_TMR_ADDR_WIDTH-1:0] == MSTOP_ADDR     );

  wire [32-1:0] s9     ;
  wire [32-1:0] s10     ;
  wire [32-1:0] s11;
  wire [32-1:0] s12;

  wire [32-1:0] s13 =
                     ({32{s3     }} & s9     )
                   | ({32{s8     }} & s10     )
                   | ({32{s4}} & s11)
                   | ({32{s5}} & s12)
                   | ({32{s6   }} & mtime_r   )
                   | ({32{s7   }} & mtimeh_r   );


  wire [32-1:0] s14;
  wire s15 = s1 & s8;
  assign s14 = {31'b0, icb_cmd_wdata[0]};
  n22_gnrl_dfflr #(32) stop_dfflr(s15, s14, s10, clk, rst_n);

  assign tmr_stop = s10[0];

  wire [32-1:0] s16;
  wire s17 = s1 & s3;
  assign s16 = {31'b0, icb_cmd_wdata[0]};
  n22_gnrl_dfflr #(32) msip_dfflr(s17, s16, s9, clk, rst_n);

  assign sft_irq = s9[0];
  wire [32-1:0] s18;
  wire [32-1:0] s19;

  wire [32-1:0] s20;
  wire s21 = s1 & s6;
  wire s22 = io_rtctick;
  wire s23 = s21 | s22;
  assign s20 = s21 ? icb_cmd_wdata : s18;
  n22_gnrl_dfflr #(32) mtimel_dfflr(s23, s20, mtime_r, clk, rst_n);

  wire [32-1:0] s24;
  wire s25 = s1 & s7;
  wire s26 = io_rtctick;
  wire s27 = s25 | s26;
  assign s24 = s25 ? icb_cmd_wdata : s19;
  n22_gnrl_dfflr #(32) mtimeh_dfflr(s27, s24, mtimeh_r, clk, rst_n);

  assign {s19, s18} = {mtimeh_r, mtime_r} + 64'b1;

  wire [32-1:0] s28;
  wire s29 = s1 & s4;
  wire s30 = s29;
  assign s28 = icb_cmd_wdata;
  n22_gnrl_dfflrs #(32) mtimecmpl_dfflrs(s30, s28, s11, clk, rst_n);

  wire [32-1:0] s31;
  wire s32 = s1 & s5;
  wire s33 = s32;
  assign s31 = icb_cmd_wdata;
  n22_gnrl_dfflrs #(32) mtimecmph_dfflrs(s33, s31, s12, clk, rst_n);

  assign tmr_irq = ({mtimeh_r, mtime_r} >= {s12, s11});

  assign icb_rsp_valid = icb_cmd_valid;
  assign icb_cmd_ready = icb_rsp_ready;
  assign icb_rsp_rdata = s13;


endmodule




