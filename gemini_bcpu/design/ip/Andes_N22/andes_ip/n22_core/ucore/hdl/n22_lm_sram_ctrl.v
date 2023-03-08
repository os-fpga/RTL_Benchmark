

`include "global.inc"

`ifdef N22_HAS_LM

module n22_lm_sram_ctrl #(
    parameter I_OR_D = 0,
    parameter DW = 32,
    parameter MW = 4,
    parameter AW = 32,
    parameter AW_LSB = 3
)(
  input  tcm_cgstop,

  input  uop_cmd_valid,
  output uop_cmd_ready,
  input  uop_cmd_read,
  input  [AW-1:0] uop_cmd_addr,
  input  [DW-1:0] uop_cmd_wdata,
  input  [MW-1:0] uop_cmd_wmask,
  input  [1:0]    uop_cmd_size,
  input  uop_cmd_mmode,
  input  uop_cmd_dmode,
  input  uop_cmd_vmode,
  input  uop_cmd_instr,

  output uop_rsp_valid,
  input  uop_rsp_ready,
  output [DW-1:0] uop_rsp_rdata,
  output uop_rsp_err,

  `ifdef N22_LM_MASTER_SRAM
  output          ram_cs,
  output [AW-AW_LSB-1:0] ram_addr,
  output [MW-1:0] ram_wem,
  output [DW-1:0] ram_din,
  input  [DW-1:0] ram_dout,
  output          clk_ram,
  `endif

  `ifdef N22_LM_MASTER_AHBL
  output [1:0]       ram_ahbl_htrans,
  output             ram_ahbl_hwrite,
  output [AW    -1:0]ram_ahbl_haddr,
  output [2:0]       ram_ahbl_hsize,
  output [2:0]       ram_ahbl_hburst,
  output [3:0]       ram_ahbl_hprot,
  output [1:0]       ram_ahbl_hattri,
  output [1:0]       ram_ahbl_master,
  output             ram_ahbl_hlock,
  output [DW    -1:0]ram_ahbl_hwdata,
  input  [DW    -1:0]ram_ahbl_hrdata,
  input  [1:0]       ram_ahbl_hresp,
  input              ram_ahbl_hready,
  `endif

  `ifdef N22_LM_MASTER_ICB
  output             ram_icb_cmd_valid,
  input              ram_icb_cmd_ready,
  output [1-1:0]     ram_icb_cmd_read,
  output [AW-1:0]    ram_icb_cmd_addr,
  output [DW-1:0]    ram_icb_cmd_wdata,
  output [MW-1:0]  ram_icb_cmd_wmask,
  output [2-1:0]     ram_icb_cmd_size,

  input              ram_icb_rsp_valid,
  output             ram_icb_rsp_ready,
  input              ram_icb_rsp_err,
  input  [DW-1:0]    ram_icb_rsp_rdata,
  `endif

  input  clkgate_bypass,
  input  clk,
  input  rst_n
  );


  `ifdef N22_LM_MASTER_SRAM
  n22_gnrl_pipe_stage # (
   .CUT_READY(0),
   .DP(1),
   .DW(1)
  ) u_e1_stage (
    .i_vld(uop_cmd_valid),
    .i_rdy(uop_cmd_ready),
    .i_dat(1'b0),
    .o_vld(uop_rsp_valid),
    .o_rdy(uop_rsp_ready),
    .o_dat(),

    .clk  (clk  ),
    .rst_n(rst_n)
   );

   assign ram_cs = uop_cmd_valid & uop_cmd_ready;
   wire s0 = (~uop_cmd_read);
   assign ram_addr= uop_cmd_addr [AW-1:AW_LSB];
   assign ram_wem = {MW{s0}} & uop_cmd_wmask[MW-1:0];
   assign ram_din = uop_cmd_wdata[DW-1:0];

   wire s1 = ram_cs | tcm_cgstop;

   n22_clkgate u_ram_clkgate(
     .clk_in   (clk        ),
     .clkgate_bypass(clkgate_bypass  ),
     .clock_en (s1),
     .clk_out  (clk_ram)
   );

   assign uop_rsp_rdata = ram_dout;
   assign uop_rsp_err   = 1'b0;

  `endif

  `ifdef N22_LM_MASTER_ICB
  assign uop_cmd_ready = ram_icb_cmd_ready;

  assign ram_icb_cmd_valid = uop_cmd_valid;
  assign ram_icb_cmd_read  = uop_cmd_read ;
  assign ram_icb_cmd_addr  = uop_cmd_addr ;
  assign ram_icb_cmd_wdata = uop_cmd_wdata;
  assign ram_icb_cmd_wmask = uop_cmd_wmask;
  assign ram_icb_cmd_size  = uop_cmd_size ;

  assign uop_rsp_valid = ram_icb_rsp_valid;
  assign uop_rsp_err   = ram_icb_rsp_err  ;
  assign uop_rsp_rdata = ram_icb_rsp_rdata;

  assign ram_icb_rsp_ready = uop_rsp_ready;





  `endif

  `ifdef N22_LM_MASTER_AHBL



  wire [3-1:0] s2;
  wire [3:0]   s3;
  wire [1:0]   s4;

  generate
    if (I_OR_D == 1) begin: gen_ilm
      assign s2    = `N22_IFU2BIU_BURST_TYPE;

      assign s3[0] = ~uop_cmd_instr;
      assign s3[1] = uop_cmd_mmode;
      assign s3[3:2] = 2'b10;

      assign s4 = 2'b01;
    end
    if (I_OR_D == 0) begin: gen_dlm
      assign s2    = `N22_LSU2BIU_BURST_TYPE;

      assign s3[0] = 1'b1;
      assign s3[1] = uop_cmd_mmode;
      assign s3[3:2] = 2'b10;

      assign s4 = 2'b01;
    end
  endgenerate


  n22_gnrl_icb2ahbl #(
     .SUPPORT_LOCK     (0),
     .SUPPORT_BURST    (0),
     .AW(AW),
     .DW(DW)
    )u_icb2ahbl(
    .bus_clk_en    (1'b1),
    .icb2ahbl_pend_active(),

    .lock_clear_ena (1'b0),

    .icb_cmd_valid (uop_cmd_valid ),
    .icb_cmd_ready (uop_cmd_ready ),
    .icb_cmd_read  (uop_cmd_read  ),
    .icb_cmd_addr  (uop_cmd_addr  ),
    .icb_cmd_wdata (uop_cmd_wdata ),
    .icb_cmd_wmask (uop_cmd_wmask ),
    .icb_cmd_size  (uop_cmd_size  ),
    .icb_cmd_lock  (1'b0  ),
    .icb_cmd_excl  (1'b0  ),
    .icb_cmd_burst (s2 ),
    .icb_cmd_beat  (2'b0  ),
    .icb_cmd_hprot (s3),
    .icb_cmd_attri (s4),
    .icb_cmd_dmode (uop_cmd_dmode),

    .icb_rsp_valid (uop_rsp_valid ),
    .icb_rsp_err   (uop_rsp_err   ),
    .icb_rsp_excl_ok(),
    .icb_rsp_rdata (uop_rsp_rdata ),

    .ahbl_htrans (ram_ahbl_htrans),
    .ahbl_hwrite (ram_ahbl_hwrite),
    .ahbl_haddr  (ram_ahbl_haddr ),
    .ahbl_hsize  (ram_ahbl_hsize),
    .ahbl_hburst (ram_ahbl_hburst),
    .ahbl_hprot  (ram_ahbl_hprot ),
    .ahbl_hattri (ram_ahbl_hattri),
    .ahbl_master (ram_ahbl_master),
    .ahbl_hlock  (ram_ahbl_hlock),
    .ahbl_hexcl  (),
    .ahbl_hwdata (ram_ahbl_hwdata),
    .ahbl_hrdata (ram_ahbl_hrdata),
    .ahbl_hresp  (ram_ahbl_hresp),
    .ahbl_hresp_exok  (1'b0 ),
    .ahbl_hready (ram_ahbl_hready),

    .clk  (clk  ),
    .rst_n(rst_n)
  );

  `endif

endmodule

`endif
