
`include "global.inc"

  `ifdef N22_HAS_ICACHE

module n22_icache(
  output icache_active,
  input  icache_ram_cgstop,

  input  icache_rstinit_dis,

  input  icache_flush_req,
  output icache_flush_done,
  output icache_no_outs,


  input  icb_cmd_valid,
  output icb_cmd_ready,
  input  [`N22_ADDR_SIZE-1:0] icb_cmd_addr,
  input  icb_cmd_vmode,
  input  icb_cmd_mmode,
  input  icb_cmd_err,

  output icb_rsp_valid,
  output icb_rsp_err,
  output [`N22_ICACHE_DATA_WIDTH-1:0] icb_rsp_rdata,

  input  bus_clk_en,

  output                           icache_w0_tram_cs,
  output                           icache_w0_tram_we,
  output [`N22_ICACHE_TAG_RAM_AW-1:0] icache_w0_tram_addr,
  output [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w0_tram_din,
  input  [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w0_tram_dout,
  output                       clk_icache_w0_tram,

  output                           icache_w0_dram_cs,
  output                           icache_w0_dram_we,
  output [`N22_ICACHE_DATA_RAM_AW-1:0] icache_w0_dram_addr,
  output [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w0_dram_din,
  input  [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w0_dram_dout,
  output                       clk_icache_w0_dram,

  `ifdef N22_ICACHE_2WAYS
  output                           icache_w1_tram_cs,
  output                           icache_w1_tram_we,
  output [`N22_ICACHE_TAG_RAM_AW-1:0] icache_w1_tram_addr,
  output [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w1_tram_din,
  input  [`N22_ICACHE_TAG_RAM_DW-1:0] icache_w1_tram_dout,
  output                       clk_icache_w1_tram,


  output                           icache_w1_dram_cs,
  output                           icache_w1_dram_we,
  output [`N22_ICACHE_DATA_RAM_AW-1:0] icache_w1_dram_addr,
  output [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w1_dram_din,
  input  [`N22_ICACHE_DATA_RAM_DW-1:0] icache_w1_dram_dout,
  output                       clk_icache_w1_dram,
  `endif

  output  miss_icb_cmd_valid,
  input   miss_icb_cmd_ready,
  output  [`N22_ADDR_SIZE-1:0] miss_icb_cmd_addr,
  output  miss_icb_cmd_read,
  output  [2:0] miss_icb_cmd_burst,
  output  [1:0] miss_icb_cmd_beat,
  output  miss_icb_cmd_mmode,
  output  miss_icb_cmd_vmode,
  output  miss_icb_cmd_dmode,

  input   miss_icb_rsp_valid,
  input   miss_icb_rsp_err,
  input   [32-1:0] miss_icb_rsp_rdata,

  input  reset_flag_r,

  input  clkgate_bypass,
  input  clk,
  input  rst_n
  );

  wire icb_rsp_ready = 1'b1;

  wire  miss_icb_rsp_ready;

  wire sync_rst_pulse = reset_flag_r;
  wire sync_rst_pulse_1_r;
  wire sync_rst_pulse_2_r;
  wire sync_rst_pulse_3_r;
  wire sync_rst_pulse_4_r;

  n22_gnrl_dffr #(1) sync_rst_pulse_1_dffr (sync_rst_pulse    , sync_rst_pulse_1_r, clk, rst_n);
  n22_gnrl_dffr #(1) sync_rst_pulse_2_dffr (sync_rst_pulse_1_r, sync_rst_pulse_2_r, clk, rst_n);
  n22_gnrl_dffr #(1) sync_rst_pulse_3_dffr (sync_rst_pulse_2_r, sync_rst_pulse_3_r, clk, rst_n);
  n22_gnrl_dffr #(1) sync_rst_pulse_4_dffr (sync_rst_pulse_3_r, sync_rst_pulse_4_r, clk, rst_n);

  wire icb_cmd_hsked = icb_cmd_valid & icb_cmd_ready;


  wire rstinvl_start = (~icache_rstinit_dis) & sync_rst_pulse_4_r;

  wire dly_sync_rst_pluse =
                 sync_rst_pulse_1_r
               | sync_rst_pulse_2_r
               | sync_rst_pulse_3_r
               | sync_rst_pulse_4_r ;

  wire invl_phase_r;
  wire invl_phase;
  wire tram_invl_active =
                 sync_rst_pulse
               | dly_sync_rst_pluse
               | invl_phase;

  wire e1_o_vld;
  wire flushinvl_start = (icache_flush_req & (~icache_flush_done) & (~e1_o_vld));

  wire [`N22_ICACHE_TAG_RAM_AW-1:0] invl_cnt_r;
  wire invl_cnt_set = (~invl_phase_r) & (
         rstinvl_start
         | flushinvl_start
         );
  wire invl_cnt_inc = invl_phase_r;
  wire invl_cnt_ena = invl_cnt_set | invl_cnt_inc;
  wire [`N22_ICACHE_TAG_RAM_AW-1:0] invl_cnt_nxt =
                                   invl_cnt_set ? {`N22_ICACHE_TAG_RAM_AW{1'b0}}
                                 : invl_cnt_inc ? (invl_cnt_r + {{`N22_ICACHE_TAG_RAM_AW-1{1'b0}},1'b1})
                                 : invl_cnt_r;

  n22_gnrl_dfflr #(`N22_ICACHE_TAG_RAM_AW) invl_cnt_dfflr (invl_cnt_ena, invl_cnt_nxt, invl_cnt_r, clk, rst_n);

  localparam ICACHE_TAG_RAM_DP_MINUS1 = (`N22_ICACHE_TAG_RAM_DP -1);
  wire invl_phase_set = invl_cnt_set;
  wire invl_phase_clr = (invl_cnt_r == ICACHE_TAG_RAM_DP_MINUS1[`N22_ICACHE_TAG_RAM_AW-1:0]);
  wire invl_phase_ena = invl_phase_set |   invl_phase_clr;
  wire invl_phase_nxt = invl_phase_set | (~invl_phase_clr);
  n22_gnrl_dfflr #(1) invl_phase_dfflr (invl_phase_ena, invl_phase_nxt, invl_phase_r, clk, rst_n);

  wire flush_done_r;
  wire flush_done_set = icache_flush_req & invl_phase_clr;
  wire flush_done_clr = flush_done_r;
  wire flush_done_ena = flush_done_set |   flush_done_clr;
  wire flush_done_nxt = flush_done_set | (~flush_done_clr);
  n22_gnrl_dfflr #(1) flush_done_dfflr (flush_done_ena, flush_done_nxt, flush_done_r, clk, rst_n);

  assign icache_flush_done = flush_done_r;

  assign invl_phase = invl_phase_set | invl_phase_r;

  wire invl_tram_cs = invl_cnt_inc;
  wire invl_tram_we = 1'b1;
  wire [`N22_ICACHE_TAG_RAM_AW-1:0] invl_tram_addr = invl_cnt_r;
  wire [`N22_ICACHE_TAG_RAM_DW-1:0] invl_tram_din  = {`N22_ICACHE_TAG_RAM_DW{1'b0}};


  wire [`N22_ICACHE_LINE_AW-1:0]      icb_cmd_line_addr    = icb_cmd_addr[`N22_ICACHE_LINE_ADDR_RANGE];
  wire [`N22_ICACHE_NONLINE_AW-1:0]   icb_cmd_nonline_addr = icb_cmd_addr[`N22_ICACHE_NONLINE_ADDR_RANGE];

  wire [`N22_ICACHE_INDEX_W-1:0]      icb_cmd_addr_idx = icb_cmd_nonline_addr[`N22_ICACHE_INDEX_W-1:0];
  wire [`N22_ICACHE_TAG_W-1:0]       icb_cmd_addr_tag = icb_cmd_nonline_addr[`N22_ICACHE_NONLINE_AW-1:`N22_ICACHE_INDEX_W];

  wire icb_cmd_same_line;
  wire icb_access_tag_ena = icb_cmd_hsked & (~icb_cmd_same_line);
  wire icb_access_data_ena = icb_cmd_hsked;
  wire [`N22_ICACHE_TAG_RAM_AW-1:0] icb_tram_addr = icb_cmd_addr_idx;
  wire [`N22_ICACHE_DATA_RAM_AW-1:0] icb_dram_addr = {icb_cmd_addr_idx,icb_cmd_line_addr[`N22_ICACHE_LINE_AW-1:`N22_ICACHE_DWORD_AW]};

  wire w0_refil_tram_ena;
  wire refil_tram_wr;
  wire [`N22_ICACHE_TAG_RAM_AW-1:0] refil_tram_addr;
  wire [`N22_ICACHE_TAG_RAM_DW-1:0] refil_tram_din;

  assign icache_w0_tram_cs   = invl_phase ? invl_tram_cs   : (w0_refil_tram_ena | icb_access_tag_ena);
  assign icache_w0_tram_we   = invl_phase ? invl_tram_we   :  w0_refil_tram_ena ? refil_tram_wr   : 1'b0;
  assign icache_w0_tram_addr = invl_phase ? invl_tram_addr :  w0_refil_tram_ena ? refil_tram_addr : icb_tram_addr;
  assign icache_w0_tram_din  = invl_phase ? invl_tram_din  :  w0_refil_tram_ena ? refil_tram_din  : {`N22_ICACHE_TAG_RAM_DW{1'b0}};


  wire w0_refil_dram_ena;
  `ifdef N22_ICACHE_2WAYS
  wire w1_refil_dram_ena;
  `endif

  wire refil_dram_wr;
  wire [`N22_ICACHE_DATA_RAM_AW-1:0] refil_dram_addr;
  wire [`N22_ICACHE_DATA_RAM_DW-1:0] refil_dram_din ;

  assign icache_w0_dram_cs   = (w0_refil_dram_ena | icb_access_data_ena);
  assign icache_w0_dram_we   = w0_refil_dram_ena ? refil_dram_wr   : 1'b0;
  assign icache_w0_dram_addr = w0_refil_dram_ena ? refil_dram_addr : icb_dram_addr;
  assign icache_w0_dram_din  = w0_refil_dram_ena ? refil_dram_din  : {`N22_ICACHE_DATA_RAM_DW{1'b0}};


  wire w0_tram_clk_en = icache_w0_tram_cs | icache_ram_cgstop;

  n22_clkgate u_w0_tram_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (w0_tram_clk_en),
    .clk_out  (clk_icache_w0_tram)
  );

  wire w0_dram_clk_en = icache_w0_dram_cs | icache_ram_cgstop;

  n22_clkgate u_w0_dram_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (w0_dram_clk_en),
    .clk_out  (clk_icache_w0_dram)
  );

  `ifdef N22_ICACHE_2WAYS
  wire w1_refil_tram_ena;

  assign icache_w1_tram_cs   = invl_phase ? invl_tram_cs   : (w1_refil_tram_ena | icb_access_tag_ena);
  assign icache_w1_tram_we   = invl_phase ? invl_tram_we   :  w1_refil_tram_ena ? refil_tram_wr   : 1'b0;
  assign icache_w1_tram_addr = invl_phase ? invl_tram_addr :  w1_refil_tram_ena ? refil_tram_addr : icb_tram_addr;
  assign icache_w1_tram_din  = invl_phase ? invl_tram_din  :  w1_refil_tram_ena ? refil_tram_din  : {`N22_ICACHE_TAG_RAM_DW{1'b0}};


  assign icache_w1_dram_cs   = (w1_refil_dram_ena | icb_access_data_ena);
  assign icache_w1_dram_we   = w1_refil_dram_ena ? refil_dram_wr   : 1'b0;
  assign icache_w1_dram_addr = w1_refil_dram_ena ? refil_dram_addr : icb_dram_addr;
  assign icache_w1_dram_din  = w1_refil_dram_ena ? refil_dram_din  : {`N22_ICACHE_DATA_RAM_DW{1'b0}};


  wire w1_tram_clk_en = icache_w1_tram_cs | icache_ram_cgstop;

  n22_clkgate u_w1_tram_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (w1_tram_clk_en),
    .clk_out  (clk_icache_w1_tram)
  );

  wire w1_dram_clk_en = icache_w1_dram_cs | icache_ram_cgstop;

  n22_clkgate u_w1_dram_clkgate(
    .clk_in   (clk        ),
    .clkgate_bypass(clkgate_bypass  ),
    .clock_en (w1_dram_clk_en),
    .clk_out  (clk_icache_w1_dram)
  );
  `endif


 wire e1_i_busy =
               | dly_sync_rst_pluse
               | invl_phase
               ;


 assign icache_active = tram_invl_active | e1_o_vld | icb_cmd_valid;

 wire e1_i_vld;
 wire e1_i_rdy;
 wire e1_o_rdy;

 assign e1_i_vld      = (~e1_i_busy) & icb_cmd_valid;
 assign icb_cmd_ready = (~e1_i_busy) & e1_i_rdy;

 wire miss_icb_cmd_hsked = miss_icb_cmd_valid & miss_icb_cmd_ready;
 wire icb_rsp_hsked = icb_rsp_valid & icb_rsp_ready;
 wire miss_rsp_cmd_hsked = miss_icb_rsp_valid & miss_icb_rsp_ready;

 wire [`N22_ADDR_SIZE+4-1:0] e1_i_pack;
 wire [`N22_ADDR_SIZE+4-1:0] e1_o_pack;
 wire e1_icb_mmode;
 wire e1_icb_err;
 wire e1_icb_vmode;
 wire e1_icb_same_line;
 wire [`N22_ADDR_SIZE-1:0] e1_cmd_addr;
 assign e1_i_pack = {
                    icb_cmd_err,
                    icb_cmd_vmode,
                    icb_cmd_mmode,
                    icb_cmd_same_line,
                    icb_cmd_addr};
 assign {
     e1_icb_err,
     e1_icb_vmode,
     e1_icb_mmode,
     e1_icb_same_line,
     e1_cmd_addr} = e1_o_pack;

 n22_gnrl_pipe_stage # (
  .CUT_READY(0),
  .DP(1),
  .DW(`N22_ADDR_SIZE+4)
 ) u_icache_e1_stage (
   .i_vld(e1_i_vld),
   .i_rdy(e1_i_rdy),
   .i_dat(e1_i_pack),
   .o_vld(e1_o_vld),
   .o_rdy(e1_o_rdy),
   .o_dat(e1_o_pack),

   .clk  (clk  ),
   .rst_n(rst_n)
  );

  wire [`N22_ICACHE_LINE_AW-1:0]    e1_cmd_line_addr    = e1_cmd_addr[`N22_ICACHE_LINE_ADDR_RANGE];
  wire [`N22_ICACHE_NONLINE_AW-1:0] e1_cmd_nonline_addr = e1_cmd_addr[`N22_ICACHE_NONLINE_ADDR_RANGE];

  wire holdup_r;
  assign icb_cmd_same_line = holdup_r &
           (icb_cmd_addr[`N22_ICACHE_NONLINE_ADDR_RANGE] == e1_cmd_addr[`N22_ICACHE_NONLINE_ADDR_RANGE]);

  wire [`N22_ICACHE_INDEX_W-1:0] e1_cmd_addr_idx = e1_cmd_nonline_addr[`N22_ICACHE_INDEX_W-1:0];
  wire [`N22_ICACHE_TAG_W-1:0]   e1_cmd_addr_tag = e1_cmd_nonline_addr[`N22_ICACHE_NONLINE_AW-1:`N22_ICACHE_INDEX_W];

  wire e1_w0_vld;
  wire e1_w0_tag_eq = e1_w0_vld & (e1_cmd_addr_tag == icache_w0_tram_dout[`N22_ICACHE_TAG_W-1:0]);
  wire e1_w0_hit = e1_o_vld & e1_w0_tag_eq;

  `ifdef N22_ICACHE_2WAYS
  wire e1_w1_vld;
  wire e1_w1_tag_eq = e1_w1_vld & (e1_cmd_addr_tag == icache_w1_tram_dout[`N22_ICACHE_TAG_W-1:0]);
  wire e1_w1_hit = e1_o_vld & e1_w1_tag_eq;
  `endif

  wire icache_sta_is_idle;

  wire hit_condition = (
                                    e1_w0_tag_eq
                         `ifdef N22_ICACHE_2WAYS
                                  | e1_w1_tag_eq
                         `endif
                                  | e1_icb_same_line
                                  | e1_icb_err
                       );

  wire e1_miss = e1_o_vld & (~hit_condition) & icache_sta_is_idle;

  wire e1_hit  = e1_o_vld &   hit_condition  & icache_sta_is_idle;

  wire holdup_sel_w0_r;
  wire rerd_out_vld;

  wire refil_replace_way;

  wire data_sel_w0 =
          (e1_hit & e1_icb_same_line) ? holdup_sel_w0_r :
               e1_hit ? e1_w0_hit :
               rerd_out_vld ? (refil_replace_way == 1'b0) :
                   1'b0;

  assign icb_rsp_valid =
                     e1_hit
                   | rerd_out_vld;

  wire rerd_out_err;
  assign icb_rsp_err = (rerd_out_err & rerd_out_vld) | (e1_hit & e1_icb_err);

  assign e1_o_rdy = icb_rsp_hsked;

  `ifdef N22_ICACHE_2WAYS
  wire [`N22_ICACHE_DATA_WIDTH-1:0] e1_o_data = data_sel_w0 ? icache_w0_dram_dout : icache_w1_dram_dout;
  `endif
  `ifndef N22_ICACHE_2WAYS
  wire [`N22_ICACHE_DATA_WIDTH-1:0] e1_o_data = icache_w0_dram_dout;
  `endif

  assign e1_w0_vld = icache_w0_tram_dout[`N22_ICACHE_TAG_W];
  `ifdef N22_ICACHE_2WAYS
  assign e1_w1_vld = icache_w1_tram_dout[`N22_ICACHE_TAG_W];
  `endif


  localparam ICACH_STATE_WIDTH  = 3;
  localparam ICACH_STATE_IDLE = 3'd0;
  localparam ICACH_STATE_SENT  = 3'd1;
  localparam ICACH_STATE_FILL  = 3'd2;
  localparam ICACH_STATE_RERD  = 3'd3;
  localparam ICACH_STATE_ROUT  = 3'd4;

  wire [ICACH_STATE_WIDTH-1:0] icache_state_nxt;
  wire [ICACH_STATE_WIDTH-1:0] icache_state_r;
  wire icache_state_ena;

  wire [ICACH_STATE_WIDTH-1:0] state_idle_nxt;
  wire [ICACH_STATE_WIDTH-1:0] state_sent_nxt;
  wire [ICACH_STATE_WIDTH-1:0] state_fill_nxt;
  wire [ICACH_STATE_WIDTH-1:0] state_rerd_nxt;
  wire [ICACH_STATE_WIDTH-1:0] state_rout_nxt;
  wire state_idle_exit_ena;
  wire state_sent_exit_ena;
  wire state_fill_exit_ena;
  wire state_rerd_exit_ena;
  wire state_rout_exit_ena;

  wire miss_icb_rsp_hsked = miss_icb_rsp_valid & miss_icb_rsp_ready;

  assign icache_sta_is_idle = (icache_state_r == ICACH_STATE_IDLE);
  wire icache_sta_is_sent   = (icache_state_r == ICACH_STATE_SENT);
  wire icache_sta_is_fill   = (icache_state_r == ICACH_STATE_FILL);
  wire icache_sta_is_rerd   = (icache_state_r == ICACH_STATE_RERD);
  wire icache_sta_is_rout   = (icache_state_r == ICACH_STATE_ROUT);

  assign state_idle_exit_ena = icache_sta_is_idle & miss_icb_cmd_hsked;
  assign state_idle_nxt      = ICACH_STATE_SENT;

  assign state_sent_exit_ena  = icache_sta_is_sent & miss_icb_rsp_hsked;
  assign state_sent_nxt     = ICACH_STATE_FILL;

  wire miss_icb_rsp_last;
  assign state_fill_exit_ena = icache_sta_is_fill & miss_icb_rsp_hsked;
  assign state_fill_nxt      = miss_icb_rsp_last ? (
                                         ICACH_STATE_RERD
                                     ): ICACH_STATE_FILL;

  assign state_rerd_exit_ena = icache_sta_is_rerd;
  assign state_rerd_nxt      = ICACH_STATE_ROUT;

  assign state_rout_exit_ena = icache_sta_is_rout & icb_rsp_hsked;
  assign state_rout_nxt      = ICACH_STATE_IDLE;

  assign icache_state_ena =
            state_idle_exit_ena | state_sent_exit_ena |
            state_fill_exit_ena | state_rerd_exit_ena | state_rout_exit_ena;

  assign icache_state_nxt =
              ({ICACH_STATE_WIDTH{state_idle_exit_ena}} & state_idle_nxt)
            | ({ICACH_STATE_WIDTH{state_sent_exit_ena}} & state_sent_nxt)
            | ({ICACH_STATE_WIDTH{state_fill_exit_ena}} & state_fill_nxt)
            | ({ICACH_STATE_WIDTH{state_rerd_exit_ena}} & state_rerd_nxt)
            | ({ICACH_STATE_WIDTH{state_rout_exit_ena}} & state_rout_nxt)
              ;

  n22_gnrl_dfflr #(ICACH_STATE_WIDTH) icache_state_dfflr (icache_state_ena, icache_state_nxt, icache_state_r, clk, rst_n);


  wire miss_icb_rsp_last_hsked = miss_icb_rsp_hsked & miss_icb_rsp_last;

  wire miss_rsp_err_acc_r;
  wire miss_rsp_err_acc_set = miss_icb_rsp_hsked & miss_icb_rsp_err;
  wire miss_rsp_err_acc_clr = miss_rsp_err_acc_r & miss_icb_rsp_last_hsked;
  wire miss_rsp_err_acc_ena = miss_rsp_err_acc_set |   miss_rsp_err_acc_clr;
  wire miss_rsp_err_acc_nxt = miss_rsp_err_acc_set & (~miss_rsp_err_acc_clr);
  n22_gnrl_dfflr #(1) miss_rsp_err_acc_dfflr (miss_rsp_err_acc_ena, miss_rsp_err_acc_nxt, miss_rsp_err_acc_r, clk, rst_n);

  wire miss_rsp_err_acc = miss_rsp_err_acc_r | miss_icb_rsp_err;

  localparam ICACHE_LINE_WCNT_NUM_MINUS1 = (`N22_ICACHE_LINE_WCNT_NUM-1);
  wire [`N22_ICACHE_LINE_WCNT_W-1:0] miss_cnt_r;
  wire miss_cnt_inc = miss_icb_cmd_hsked;
  wire miss_icb_cmd_first = (miss_cnt_r == `N22_ICACHE_LINE_WCNT_W'b0);
  wire miss_icb_cmd_last = (miss_cnt_r == ICACHE_LINE_WCNT_NUM_MINUS1[`N22_ICACHE_LINE_WCNT_W-1:0]);
  wire miss_cnt_clr = miss_icb_cmd_hsked & miss_icb_cmd_last;
  wire miss_cnt_ena = miss_cnt_inc | miss_cnt_clr;
  wire [`N22_ICACHE_LINE_WCNT_W-1:0] miss_cnt_nxt =
                                   miss_cnt_clr ? {`N22_ICACHE_LINE_WCNT_W{1'b0}}
                                 : miss_cnt_inc ? (miss_cnt_r + {{`N22_ICACHE_LINE_WCNT_W-1{1'b0}},1'b1})
                                 : miss_cnt_r;

  n22_gnrl_dfflr #(`N22_ICACHE_LINE_WCNT_W) miss_cnt_dfflr (miss_cnt_ena, miss_cnt_nxt, miss_cnt_r, clk, rst_n);

`ifdef N22_ICACHE_2WAYS
  wire refil_replace_way_r;
  wire glb_replace_way_r;
  wire glb_replace_way_ena = miss_icb_rsp_last_hsked;
  wire glb_replace_way_nxt = ~refil_replace_way;
  n22_gnrl_dfflr #(1) glb_replace_way_dfflr (glb_replace_way_ena, glb_replace_way_nxt, glb_replace_way_r, clk, rst_n);

  wire refil_replace_way_ena = state_idle_exit_ena;
  wire refil_replace_way_nxt = (~e1_w0_vld) ? 1'b0 : (~e1_w1_vld) ? 1'b1 : glb_replace_way_r;
  n22_gnrl_dfflr #(1) refil_replace_way_dfflr (refil_replace_way_ena, refil_replace_way_nxt, refil_replace_way_r, clk, rst_n);
  assign refil_replace_way = refil_replace_way_r;
`endif

`ifndef N22_ICACHE_2WAYS
  assign refil_replace_way = 1'b0;
`endif


  wire holdup_set = icb_rsp_hsked & (~icb_rsp_err);
  wire holdup_clr = holdup_r & (e1_miss | invl_cnt_set);
  wire holdup_ena = holdup_set |   holdup_clr;
  wire holdup_nxt = holdup_set | (~holdup_clr);
  n22_gnrl_dfflr #(1) holdup_dfflr (holdup_ena, holdup_nxt, holdup_r, clk, rst_n);

  n22_gnrl_dfflr #(1) holdup_sel_w0_dfflr (holdup_set, data_sel_w0, holdup_sel_w0_r, clk, rst_n);


  wire miss_icb_cmd_valid_r;
  wire miss_icb_cmd_valid_set = e1_miss & bus_clk_en;
  wire miss_icb_cmd_valid_clr = miss_icb_cmd_valid_r & miss_cnt_clr;
  wire miss_icb_cmd_valid_ena = miss_icb_cmd_valid_set |   miss_icb_cmd_valid_clr;
  wire miss_icb_cmd_valid_nxt = miss_icb_cmd_valid_set & (~miss_icb_cmd_valid_clr);
  n22_gnrl_dfflr #(1) miss_icb_cmd_valid_dfflr (miss_icb_cmd_valid_ena, miss_icb_cmd_valid_nxt, miss_icb_cmd_valid_r, clk, rst_n);

  assign  miss_icb_cmd_valid = miss_icb_cmd_valid_r;
  assign  miss_icb_cmd_addr  = {e1_cmd_nonline_addr,miss_cnt_r,2'b0};
  assign  miss_icb_cmd_mmode  = e1_icb_mmode;
  assign  miss_icb_cmd_vmode  = e1_icb_vmode;
  assign  miss_icb_cmd_read  = 1'b1;
  assign  miss_icb_cmd_burst = `N22_ICACHE_BURST_TYPE;
  wire  miss_icb_cmd_start = miss_icb_cmd_first;
  wire  miss_icb_cmd_end   = miss_icb_cmd_last;
  assign  miss_icb_cmd_beat = {miss_icb_cmd_end,miss_icb_cmd_start};

  assign  miss_icb_cmd_dmode  = 1'b0;


  assign  miss_icb_rsp_ready = 1'b1;



  wire [`N22_ICACHE_LINE_WCNT_W-1:0] miss_rsp_cnt_r;
  wire miss_rsp_cnt_inc = miss_icb_rsp_hsked;
  wire miss_icb_rsp_first = (miss_rsp_cnt_r == `N22_ICACHE_LINE_WCNT_W'b0);
  assign miss_icb_rsp_last = (miss_rsp_cnt_r == ICACHE_LINE_WCNT_NUM_MINUS1[`N22_ICACHE_LINE_WCNT_W-1:0]);
  wire miss_rsp_cnt_clr = miss_icb_rsp_hsked & miss_icb_rsp_last;
  wire miss_rsp_cnt_ena = miss_rsp_cnt_inc | miss_rsp_cnt_clr;
  wire [`N22_ICACHE_LINE_WCNT_W-1:0] miss_rsp_cnt_nxt =
                                   miss_rsp_cnt_clr ? {`N22_ICACHE_LINE_WCNT_W{1'b0}}
                                 : miss_rsp_cnt_inc ? (miss_rsp_cnt_r + {{`N22_ICACHE_LINE_WCNT_W-1{1'b0}},1'b1})
                                 : miss_rsp_cnt_r;

  n22_gnrl_dfflr #(`N22_ICACHE_LINE_WCNT_W) miss_rsp_cnt_dfflr (miss_rsp_cnt_ena, miss_rsp_cnt_nxt, miss_rsp_cnt_r, clk, rst_n);

  `ifdef N22_ICACHE_DATA_RAM_DW_IS_64

  wire miss_rsp_odd_r = miss_rsp_cnt_r[0];


  wire rdata_buf_ena = (~miss_rsp_odd_r) & miss_icb_rsp_hsked;
  wire [32-1:0] rdata_buf_r;
  wire [32-1:0] rdata_buf_nxt = miss_icb_rsp_rdata;
  n22_gnrl_dfflr #(32) rdata_buf_dfflr (rdata_buf_ena, rdata_buf_nxt, rdata_buf_r, clk, rst_n);
  `endif


  wire [`N22_ICACHE_TAG_RAM_AW-1:0] miss_wr_tram_waddr;
  wire [`N22_ICACHE_TAG_RAM_DW-1:0] miss_wr_tram_wdin;

  wire miss_wr_tram_wen = miss_icb_rsp_last_hsked;
  assign miss_wr_tram_waddr =  e1_cmd_addr_idx;
  assign miss_wr_tram_wdin = {(~miss_rsp_err_acc),e1_cmd_addr_tag};

  wire   refil_tram_ena = miss_wr_tram_wen;
  assign refil_tram_wr  = 1'b1;
  assign refil_tram_addr = miss_wr_tram_waddr;
  assign refil_tram_din = miss_wr_tram_wdin;

  assign w0_refil_tram_ena = refil_tram_ena & (~refil_replace_way);
  `ifdef N22_ICACHE_2WAYS
  assign w1_refil_tram_ena = refil_tram_ena & (refil_replace_way);
  `endif


  wire [`N22_ICACHE_DATA_RAM_DW-1:0] miss_wr_dram_wdin;
  wire [`N22_ICACHE_DATA_RAM_AW-1:0] miss_wr_dram_waddr;

  wire miss_wr_dram_wen;

  `ifdef N22_ICACHE_DATA_RAM_DW_IS_64
  assign miss_wr_dram_waddr = {e1_cmd_addr_idx,miss_rsp_cnt_r[`N22_ICACHE_LINE_WCNT_W-1:1]};
  assign miss_wr_dram_wdin = {miss_icb_rsp_rdata,rdata_buf_r};
  assign miss_wr_dram_wen = miss_icb_rsp_hsked & miss_rsp_odd_r;
  `else
  assign miss_wr_dram_waddr = {e1_cmd_addr_idx,miss_rsp_cnt_r[`N22_ICACHE_LINE_WCNT_W-1:0]};
  assign miss_wr_dram_wen = miss_icb_rsp_hsked;
  assign miss_wr_dram_wdin = miss_icb_rsp_rdata;
  `endif

  wire [`N22_ICACHE_DATA_RAM_AW-1:0] miss_wr_dram_raddr;
  wire [`N22_ICACHE_DATA_RAM_DW-1:0] miss_wr_dram_rdin;

  wire miss_wr_dram_ren = icache_sta_is_rerd;
  assign miss_wr_dram_raddr = {e1_cmd_addr_idx,e1_cmd_line_addr[`N22_ICACHE_LINE_AW-1:`N22_ICACHE_DWORD_AW]};
  assign miss_wr_dram_rdin = `N22_ICACHE_DATA_RAM_DW'b0;

  wire   refil_dram_ena = miss_wr_dram_ren | miss_wr_dram_wen;
  assign refil_dram_wr  = ~miss_wr_dram_ren;
  assign refil_dram_addr = miss_wr_dram_ren ? miss_wr_dram_raddr : miss_wr_dram_waddr;
  assign refil_dram_din = miss_wr_dram_wdin;

  assign w0_refil_dram_ena = refil_dram_ena & (~refil_replace_way);
  `ifdef N22_ICACHE_2WAYS
  assign w1_refil_dram_ena = refil_dram_ena & (refil_replace_way);
  `endif


  assign icb_rsp_rdata = (e1_hit & e1_icb_err) ? `N22_ICACHE_DATA_WIDTH'b0 : e1_o_data;

  assign rerd_out_vld =  icache_sta_is_rout;


  wire rerd_out_err_r;
  wire rerd_out_err_ena = refil_tram_ena;
  wire rerd_out_err_nxt = miss_rsp_err_acc;
  n22_gnrl_dfflr #(1) rerd_out_err_dfflr (rerd_out_err_ena, rerd_out_err_nxt, rerd_out_err_r, clk, rst_n);

  assign rerd_out_err = rerd_out_err_r;

  assign icache_no_outs = ~icache_active;

endmodule

  `endif
