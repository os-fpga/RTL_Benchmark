

`include "global.inc"



module n22_gnrl_icb_arbt # (
  parameter AW = 32,
  parameter DW = 64,
  parameter USR_W = 1,
  parameter ARBT_SCHEME = 3,
  parameter FIFO_OUTS_NUM = 1,
  parameter FIFO_CUT_READY = 0,
  parameter ARBT_NUM = 4,
  parameter ALLOW_0CYCL_RSP = 1,
  parameter ALLOW_BURST = 0,
  parameter ARBT_PTR_W = 2
) (
  output             arbt_active,

  output             o_icb_cmd_valid,
  input              o_icb_cmd_ready,
  output             o_icb_cmd_read,
  output [AW-1:0]    o_icb_cmd_addr,
  output [DW-1:0]    o_icb_cmd_wdata,
  output [(DW/8-1):0]  o_icb_cmd_wmask,
  output [3-1:0]     o_icb_cmd_burst,
  output [2-1:0]     o_icb_cmd_beat,
  output             o_icb_cmd_lock,
  output             o_icb_cmd_excl,
  output [1:0]       o_icb_cmd_size,
  output [USR_W-1:0] o_icb_cmd_usr,

  input              o_icb_rsp_valid,
  output             o_icb_rsp_ready,
  input              o_icb_rsp_err,
  input              o_icb_rsp_excl_ok,
  input  [DW-1:0]    o_icb_rsp_rdata,
  input  [USR_W-1:0] o_icb_rsp_usr,

  input  [ARBT_NUM*1-1:0]     i_bus_icb_cmd_sel_vec,

  output [ARBT_NUM*1-1:0]     i_bus_icb_cmd_ready,
  input  [ARBT_NUM*1-1:0]     i_bus_icb_cmd_valid,
  input  [ARBT_NUM*1-1:0]     i_bus_icb_cmd_read,
  input  [ARBT_NUM*AW-1:0]    i_bus_icb_cmd_addr,
  input  [ARBT_NUM*DW-1:0]    i_bus_icb_cmd_wdata,
  input  [(ARBT_NUM*DW/8-1):0]  i_bus_icb_cmd_wmask,
  input  [ARBT_NUM*3-1:0]     i_bus_icb_cmd_burst,
  input  [ARBT_NUM*2-1:0]     i_bus_icb_cmd_beat ,
  input  [ARBT_NUM*1-1:0]     i_bus_icb_cmd_lock ,
  input  [ARBT_NUM*1-1:0]     i_bus_icb_cmd_excl ,
  input  [ARBT_NUM*2-1:0]     i_bus_icb_cmd_size ,
  input  [ARBT_NUM*USR_W-1:0] i_bus_icb_cmd_usr  ,

  output [ARBT_NUM*1-1:0]     i_bus_icb_rsp_valid,
  input  [ARBT_NUM*1-1:0]     i_bus_icb_rsp_ready,
  output [ARBT_NUM*1-1:0]     i_bus_icb_rsp_err,
  output [ARBT_NUM*1-1:0]     i_bus_icb_rsp_excl_ok,
  output [ARBT_NUM*DW-1:0]    i_bus_icb_rsp_rdata,
  output [ARBT_NUM*USR_W-1:0] i_bus_icb_rsp_usr,

  input  clk,
  input  rst_n
  );

  wire             icb_rsp_valid;
  wire             icb_rsp_ready;
  wire             icb_rsp_err;
  wire             icb_rsp_excl_ok;
  wire [DW-1:0]    icb_rsp_rdata;
  wire [USR_W-1:0] icb_rsp_usr;

  localparam RSP_PACK_W = (2+DW+USR_W);
  wire [RSP_PACK_W-1:0] rsp_fifo_i_dat = {
                                 o_icb_rsp_err,
                                 o_icb_rsp_excl_ok,
                                 o_icb_rsp_rdata,
                                 o_icb_rsp_usr};

  wire [RSP_PACK_W-1:0] rsp_fifo_o_dat;

  assign {
                                 icb_rsp_err,
                                 icb_rsp_excl_ok,
                                 icb_rsp_rdata,
                                 icb_rsp_usr} = rsp_fifo_o_dat;
      assign rsp_fifo_o_dat = rsp_fifo_i_dat;
      assign icb_rsp_valid = o_icb_rsp_valid;
      assign o_icb_rsp_ready = icb_rsp_ready;




  wire rspid_fifo_empty;


genvar i;
generate
  if(ARBT_NUM == 1) begin:gen_arbt_num_eq_1
    assign i_bus_icb_cmd_ready = o_icb_cmd_ready    ;
    assign o_icb_cmd_valid     = i_bus_icb_cmd_valid;
    assign o_icb_cmd_read      = i_bus_icb_cmd_read ;
    assign o_icb_cmd_addr      = i_bus_icb_cmd_addr ;
    assign o_icb_cmd_wdata     = i_bus_icb_cmd_wdata;
    assign o_icb_cmd_wmask     = i_bus_icb_cmd_wmask;
    assign o_icb_cmd_burst     = i_bus_icb_cmd_burst;
    assign o_icb_cmd_beat      = i_bus_icb_cmd_beat ;
    assign o_icb_cmd_lock      = i_bus_icb_cmd_lock ;
    assign o_icb_cmd_excl      = i_bus_icb_cmd_excl ;
    assign o_icb_cmd_size      = i_bus_icb_cmd_size ;
    assign o_icb_cmd_usr       = i_bus_icb_cmd_usr  ;

    assign icb_rsp_ready     = i_bus_icb_rsp_ready;
    assign i_bus_icb_rsp_valid = icb_rsp_valid    ;
    assign i_bus_icb_rsp_err   = icb_rsp_err      ;
    assign i_bus_icb_rsp_excl_ok   = icb_rsp_excl_ok      ;
    assign i_bus_icb_rsp_rdata = icb_rsp_rdata    ;
    assign i_bus_icb_rsp_usr   = icb_rsp_usr      ;

    assign rspid_fifo_empty    = 1'b1;


  end
  else begin:gen_arbt_num_gt_1

    integer j;

    wire [ARBT_NUM-1:0] i_bus_icb_cmd_grt_vec;
    wire [ARBT_NUM-1:0] i_bus_icb_cmd_sel;
    wire o_icb_cmd_valid_real;
    wire o_icb_cmd_ready_real;

    wire            i_icb_cmd_read [ARBT_NUM-1:0];
    wire [AW-1:0]   i_icb_cmd_addr [ARBT_NUM-1:0];
    wire [DW-1:0]   i_icb_cmd_wdata[ARBT_NUM-1:0];
    wire [(DW/8-1):0] i_icb_cmd_wmask[ARBT_NUM-1:0];
    wire [3-1:0]    i_icb_cmd_burst[ARBT_NUM-1:0];
    wire [2-1:0]    i_icb_cmd_beat [ARBT_NUM-1:0];
    wire            i_icb_cmd_lock [ARBT_NUM-1:0];
    wire            i_icb_cmd_excl [ARBT_NUM-1:0];
    wire [2-1:0]    i_icb_cmd_size [ARBT_NUM-1:0];
    wire [USR_W-1:0]i_icb_cmd_usr  [ARBT_NUM-1:0];

    reg            sel_o_icb_cmd_read;
    reg [AW-1:0]   sel_o_icb_cmd_addr;
    reg [DW-1:0]   sel_o_icb_cmd_wdata;
    reg [(DW/8-1):0] sel_o_icb_cmd_wmask;
    reg [3-1:0]    sel_o_icb_cmd_burst;
    reg [2-1:0]    sel_o_icb_cmd_beat ;
    reg            sel_o_icb_cmd_lock ;
    reg            sel_o_icb_cmd_excl ;
    reg [2-1:0]    sel_o_icb_cmd_size ;
    reg [USR_W-1:0]sel_o_icb_cmd_usr  ;

    wire icb_rsp_ready_pre;
    wire icb_rsp_valid_pre;

    wire rspid_fifo_bypass;
    wire rspid_fifo_wen;
    wire rspid_fifo_ren;


    wire rspid_fifo_i_valid;
    wire rspid_fifo_o_valid;
    wire rspid_fifo_i_ready;
    wire rspid_fifo_o_ready;
    wire [ARBT_PTR_W-1:0] rspid_fifo_rdat;
    wire [ARBT_PTR_W-1:0] rspid_fifo_wdat;

    wire rspid_fifo_full;
    reg [ARBT_PTR_W-1:0] i_arbt_indic_id;

    wire [ARBT_NUM*1-1:0] i_bus_icb_cmd_ready_pos;
    wire [ARBT_NUM*1-1:0] i_bus_icb_cmd_valid_pos;

    wire arbt_ena;

    wire [ARBT_PTR_W-1:0] icb_rsp_port_id;

    wire [ARBT_NUM-1:0] burst_mask_r  ;
    wire [ARBT_NUM-1:0] burst_mask_set;
    wire [ARBT_NUM-1:0] burst_mask_clr;
    wire [ARBT_NUM-1:0] burst_mask_ena;
    wire [ARBT_NUM-1:0] burst_mask_nxt;

    if(ALLOW_BURST == 1) begin: gen_allow_burst
      assign i_bus_icb_cmd_valid_pos = (~burst_mask_r) & i_bus_icb_cmd_valid;
      assign i_bus_icb_cmd_ready     = (~burst_mask_r) & i_bus_icb_cmd_ready_pos;
    end
    else begin: gen_not_allow_burst
      assign burst_mask_r   = {ARBT_NUM{1'b0}};
      assign burst_mask_set = {ARBT_NUM{1'b0}};
      assign burst_mask_clr = {ARBT_NUM{1'b0}};
      assign burst_mask_ena = {ARBT_NUM{1'b0}};
      assign burst_mask_nxt = {ARBT_NUM{1'b0}};

      assign i_bus_icb_cmd_valid_pos = i_bus_icb_cmd_valid;
      assign i_bus_icb_cmd_ready     = i_bus_icb_cmd_ready_pos;
    end

    assign o_icb_cmd_valid = o_icb_cmd_valid_real & (~rspid_fifo_full);
    assign o_icb_cmd_ready_real = o_icb_cmd_ready & (~rspid_fifo_full);

    for(i = 0; i < ARBT_NUM; i = i+1)
    begin:gen_icb_distract
      assign i_icb_cmd_read [i] = i_bus_icb_cmd_read [(i+1)*1     -1 : i*1     ];
      assign i_icb_cmd_addr [i] = i_bus_icb_cmd_addr [(i+1)*AW    -1 : i*AW    ];
      assign i_icb_cmd_wdata[i] = i_bus_icb_cmd_wdata[(i+1)*DW    -1 : i*DW    ];
      assign i_icb_cmd_wmask[i] = i_bus_icb_cmd_wmask[(i+1)*(DW/8)-1 : i*(DW/8)];
      assign i_icb_cmd_burst[i] = i_bus_icb_cmd_burst[(i+1)*3     -1 : i*3     ];
      assign i_icb_cmd_beat [i] = i_bus_icb_cmd_beat [(i+1)*2     -1 : i*2     ];
      assign i_icb_cmd_lock [i] = i_bus_icb_cmd_lock [(i+1)*1     -1 : i*1     ];
      assign i_icb_cmd_excl [i] = i_bus_icb_cmd_excl [(i+1)*1     -1 : i*1     ];
      assign i_icb_cmd_size [i] = i_bus_icb_cmd_size [(i+1)*2     -1 : i*2     ];
      assign i_icb_cmd_usr  [i] = i_bus_icb_cmd_usr  [(i+1)*USR_W -1 : i*USR_W ];

      assign i_bus_icb_cmd_ready_pos[i] = i_bus_icb_cmd_grt_vec[i] & o_icb_cmd_ready_real;
      assign i_bus_icb_rsp_valid[i] = icb_rsp_valid_pre & (icb_rsp_port_id == i[ARBT_PTR_W-1:0]);
    end

    assign arbt_ena = o_icb_cmd_valid & o_icb_cmd_ready;

    if(ALLOW_BURST == 1) begin: gen_burst
      for(i = 0; i < ARBT_NUM; i = i+1)
      begin:gen_burst_mask

        assign burst_mask_set[i] = (i_bus_icb_cmd_sel[i] == 1'b0) & o_icb_cmd_beat[0] & arbt_ena;
        assign burst_mask_clr[i] = burst_mask_r[i] & o_icb_cmd_beat[1] & arbt_ena;
        assign burst_mask_ena[i] = burst_mask_set[i] |   burst_mask_clr[i];
        assign burst_mask_nxt[i] = burst_mask_set[i] & (~burst_mask_clr[i]);

        n22_gnrl_dfflr #(1) burst_mask_dfflr (burst_mask_ena[i], burst_mask_nxt[i], burst_mask_r[i], clk, rst_n);

      end
    end

    if(ARBT_SCHEME == 0) begin:gen_priorty_arbt
      for(i = 0; i < ARBT_NUM; i = i+1)
      begin:gen_priroty_grt_vec

        if(i==0) begin: gen_i_is_0
          assign i_bus_icb_cmd_grt_vec[i] =  1'b1;
          assign i_bus_icb_cmd_sel[i] = i_bus_icb_cmd_grt_vec[i] & i_bus_icb_cmd_valid_pos[i];
        end
        else begin:gen_i_is_not_0
          assign i_bus_icb_cmd_grt_vec[i] =  ~(|i_bus_icb_cmd_valid_pos[i-1:0]);
          assign i_bus_icb_cmd_sel[i] = i_bus_icb_cmd_grt_vec[i] & i_bus_icb_cmd_valid_pos[i];
        end

      end

      assign o_icb_cmd_valid_real = |i_bus_icb_cmd_valid_pos;

    end

   if(ARBT_SCHEME == 1) begin:gen_rrobin_arbt
     assign arbt_ena = o_icb_cmd_valid & o_icb_cmd_ready;
     n22_gnrl_rrobin # (
         .ARBT_NUM(ARBT_NUM)
     )u_n22_gnrl_rrobin(
       .grt_vec  (i_bus_icb_cmd_grt_vec),
       .req_vec  (i_bus_icb_cmd_valid_pos),
       .arbt_ena (arbt_ena),
       .clk      (clk),
       .rst_n    (rst_n)
     );
     assign i_bus_icb_cmd_sel = i_bus_icb_cmd_grt_vec;
     assign o_icb_cmd_valid_real = |i_bus_icb_cmd_valid_pos;

   end

   if(ARBT_SCHEME == 2) begin:gen_indic_arbt
     assign i_bus_icb_cmd_grt_vec = i_bus_icb_cmd_sel_vec;
     assign i_bus_icb_cmd_sel = i_bus_icb_cmd_grt_vec;
     assign o_icb_cmd_valid_real = |(i_bus_icb_cmd_valid_pos & i_bus_icb_cmd_sel_vec);
   end

   if(ARBT_SCHEME == 3) begin:gen_indic_priorty_arbt
      for(i = 0; i < ARBT_NUM; i = i+1)
      begin:gen_priroty_grt_vec

        if(i==0) begin: gen_i_is_0
          assign i_bus_icb_cmd_grt_vec[i] =  1'b1;
          assign i_bus_icb_cmd_sel[i] = i_bus_icb_cmd_grt_vec[i] & i_bus_icb_cmd_sel_vec[i];
        end
        else if(i==(ARBT_NUM-1)) begin: gen_i_is_n
          assign i_bus_icb_cmd_grt_vec[i] =  ~(|i_bus_icb_cmd_sel_vec[i-1:0]);
          assign i_bus_icb_cmd_sel[i] = i_bus_icb_cmd_grt_vec[i];
        end
        else begin:gen_i_is_not_0
          assign i_bus_icb_cmd_grt_vec[i] =  ~(|i_bus_icb_cmd_sel_vec[i-1:0]);
          assign i_bus_icb_cmd_sel[i] = i_bus_icb_cmd_grt_vec[i] & i_bus_icb_cmd_sel_vec[i];
        end

      end

      assign o_icb_cmd_valid_real = |(i_bus_icb_cmd_valid_pos & i_bus_icb_cmd_sel_vec);
    end


    always @ (*) begin : sel_o_icb_cmd_ready_PROC
      sel_o_icb_cmd_read  = {1   {1'b0}};
      sel_o_icb_cmd_addr  = {AW  {1'b0}};
      sel_o_icb_cmd_wdata = {DW  {1'b0}};
      sel_o_icb_cmd_wmask = {DW/8{1'b0}};
      sel_o_icb_cmd_burst = {3   {1'b0}};
      sel_o_icb_cmd_beat  = {2   {1'b0}};
      sel_o_icb_cmd_lock  = {1   {1'b0}};
      sel_o_icb_cmd_excl  = {1   {1'b0}};
      sel_o_icb_cmd_size  = {2   {1'b0}};
      sel_o_icb_cmd_usr   = {USR_W{1'b0}};
      for(j = 0; j < ARBT_NUM; j = j+1) begin
        sel_o_icb_cmd_read  = sel_o_icb_cmd_read  | ({1    {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_read [j]);
        sel_o_icb_cmd_addr  = sel_o_icb_cmd_addr  | ({AW   {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_addr [j]);
        sel_o_icb_cmd_wdata = sel_o_icb_cmd_wdata | ({DW   {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_wdata[j]);
        sel_o_icb_cmd_wmask = sel_o_icb_cmd_wmask | ({DW/8 {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_wmask[j]);
        sel_o_icb_cmd_burst = sel_o_icb_cmd_burst | ({3    {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_burst[j]);
        sel_o_icb_cmd_beat  = sel_o_icb_cmd_beat  | ({2    {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_beat [j]);
        sel_o_icb_cmd_lock  = sel_o_icb_cmd_lock  | ({1    {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_lock [j]);
        sel_o_icb_cmd_excl  = sel_o_icb_cmd_excl  | ({1    {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_excl [j]);
        sel_o_icb_cmd_size  = sel_o_icb_cmd_size  | ({2    {i_bus_icb_cmd_sel[j]}} & i_icb_cmd_size [j]);
        sel_o_icb_cmd_usr   = sel_o_icb_cmd_usr   | ({USR_W{i_bus_icb_cmd_sel[j]}} & i_icb_cmd_usr  [j]);
      end
    end

    always @ (*) begin : i_arbt_indic_id_PROC
      i_arbt_indic_id = {ARBT_PTR_W{1'b0}};
      for(j = 0; j < ARBT_NUM; j = j+1) begin
        i_arbt_indic_id = i_arbt_indic_id | ({ARBT_PTR_W{i_bus_icb_cmd_sel[j]}} & $unsigned(j[ARBT_PTR_W-1:0]));
      end
    end

    assign rspid_fifo_wen = o_icb_cmd_valid & o_icb_cmd_ready;
    assign rspid_fifo_ren = icb_rsp_valid & icb_rsp_ready;


    if(ALLOW_0CYCL_RSP == 1) begin: gen_allow_0rsp
        assign rspid_fifo_bypass = rspid_fifo_empty & rspid_fifo_wen & rspid_fifo_ren;
        assign icb_rsp_port_id = rspid_fifo_empty ? rspid_fifo_wdat : rspid_fifo_rdat;
        assign icb_rsp_valid_pre = icb_rsp_valid;
        assign icb_rsp_ready     = icb_rsp_ready_pre;
    end
    else begin: gen_no_allow_0rsp
        assign rspid_fifo_bypass   = 1'b0;
        assign icb_rsp_port_id   = rspid_fifo_empty ? {ARBT_PTR_W{1'b0}} : rspid_fifo_rdat;
        assign icb_rsp_valid_pre = (~rspid_fifo_empty) & icb_rsp_valid;
        assign icb_rsp_ready     = (~rspid_fifo_empty) & icb_rsp_ready_pre;
    end

    assign rspid_fifo_i_valid = rspid_fifo_wen & (~rspid_fifo_bypass);
    assign rspid_fifo_full    = (~rspid_fifo_i_ready);
    assign rspid_fifo_o_ready = rspid_fifo_ren & (~rspid_fifo_bypass);
    assign rspid_fifo_empty   = (~rspid_fifo_o_valid);

    assign rspid_fifo_wdat   = i_arbt_indic_id;

    if(FIFO_OUTS_NUM == 1) begin:gen_dp_1
      n22_gnrl_pipe_stage # (
        .CUT_READY (FIFO_CUT_READY),
        .DP  (1),
        .DW  (ARBT_PTR_W)
      ) u_n22_gnrl_rspid_fifo (
        .i_vld(rspid_fifo_i_valid),
        .i_rdy(rspid_fifo_i_ready),
        .i_dat(rspid_fifo_wdat ),
        .o_vld(rspid_fifo_o_valid),
        .o_rdy(rspid_fifo_o_ready),
        .o_dat(rspid_fifo_rdat ),
        .clk  (clk),
        .rst_n(rst_n)
      );

    end
    else begin: gen_dp_gt1
      n22_gnrl_fifo # (
        .CUT_READY (FIFO_CUT_READY),
        .MSKO      (0),
        .DP  (FIFO_OUTS_NUM),
        .DW  (ARBT_PTR_W)
      ) u_n22_gnrl_rspid_fifo (
        .i_vld(rspid_fifo_i_valid),
        .i_rdy(rspid_fifo_i_ready),
        .i_dat(rspid_fifo_wdat ),
        .o_vld(rspid_fifo_o_valid),
        .o_rdy(rspid_fifo_o_ready),
        .o_dat(rspid_fifo_rdat ),

        .clk  (clk),
        .rst_n(rst_n)
      );
    end

    assign o_icb_cmd_read  = sel_o_icb_cmd_read ;
    assign o_icb_cmd_addr  = sel_o_icb_cmd_addr ;
    assign o_icb_cmd_wdata = sel_o_icb_cmd_wdata;
    assign o_icb_cmd_wmask = sel_o_icb_cmd_wmask;
    assign o_icb_cmd_burst = sel_o_icb_cmd_burst;
    assign o_icb_cmd_beat  = sel_o_icb_cmd_beat ;
    assign o_icb_cmd_lock  = sel_o_icb_cmd_lock ;
    assign o_icb_cmd_excl  = sel_o_icb_cmd_excl ;
    assign o_icb_cmd_size  = sel_o_icb_cmd_size ;
    assign o_icb_cmd_usr   = sel_o_icb_cmd_usr  ;

    assign icb_rsp_ready_pre = i_bus_icb_rsp_ready[icb_rsp_port_id];



    assign i_bus_icb_rsp_err     = {ARBT_NUM{icb_rsp_err  }};
    assign i_bus_icb_rsp_excl_ok = {ARBT_NUM{icb_rsp_excl_ok}};
    assign i_bus_icb_rsp_rdata   = {ARBT_NUM{icb_rsp_rdata}};
    assign i_bus_icb_rsp_usr     = {ARBT_NUM{icb_rsp_usr}};
  end
  endgenerate

  assign arbt_active = (|i_bus_icb_cmd_valid) | (~rspid_fifo_empty) | icb_rsp_valid;

endmodule


module n22_gnrl_icb_buffer # (
  parameter CMD_MSKO = 0,
  parameter OUTS_CNT_W = 1,
  parameter AW = 32,
  parameter DW = 32,
  parameter CMD_CUT_READY = 0,
  parameter RSP_CUT_READY = 0,
  parameter CMD_DP = 0,
  parameter RSP_DP = 0,
  parameter RSP_ALWAYS_READY = 0,
  parameter USR_W = 1
) (
  input              bus_clk_en,

  output             icb_buffer_active,

  input              i_icb_cmd_valid,
  output             i_icb_cmd_ready,
  input              i_icb_cmd_read,
  input  [AW-1:0]    i_icb_cmd_addr,
  input  [DW-1:0]    i_icb_cmd_wdata,
  input  [(DW/8-1):0]  i_icb_cmd_wmask,
  input              i_icb_cmd_lock,
  input              i_icb_cmd_excl,
  input  [1:0]       i_icb_cmd_size,
  input  [2:0]       i_icb_cmd_burst,
  input  [1:0]       i_icb_cmd_beat,
  input  [USR_W-1:0] i_icb_cmd_usr,

  output             i_icb_rsp_valid,
  input              i_icb_rsp_ready,
  output             i_icb_rsp_err,
  output             i_icb_rsp_excl_ok,
  output [DW-1:0]    i_icb_rsp_rdata,
  output [USR_W-1:0] i_icb_rsp_usr,

  output             o_icb_cmd_valid,
  input              o_icb_cmd_ready,
  output             o_icb_cmd_read,
  output [AW-1:0]    o_icb_cmd_addr,
  output [DW-1:0]    o_icb_cmd_wdata,
  output [(DW/8-1):0]  o_icb_cmd_wmask,
  output             o_icb_cmd_lock,
  output             o_icb_cmd_excl,
  output [1:0]       o_icb_cmd_size,
  output [2:0]       o_icb_cmd_burst,
  output [1:0]       o_icb_cmd_beat,
  output [USR_W-1:0] o_icb_cmd_usr,

  input              o_icb_rsp_valid,
  output             o_icb_rsp_ready,
  input              o_icb_rsp_err,
  input              o_icb_rsp_excl_ok,
  input  [DW-1:0]    o_icb_rsp_rdata,
  input  [USR_W-1:0] o_icb_rsp_usr,

  input  clk,
  input  rst_n
  );

  localparam CMD_PACK_W = (1+AW+DW+(DW/8)+1+1+3+2+2+USR_W);

  wire [CMD_PACK_W-1:0] cmd_fifo_i_dat = {
                                 i_icb_cmd_read,
                                 i_icb_cmd_addr,
                                 i_icb_cmd_wdata,
                                 i_icb_cmd_wmask,
                                 i_icb_cmd_lock,
                                 i_icb_cmd_excl,
                                 i_icb_cmd_size,
                                 i_icb_cmd_burst,
                                 i_icb_cmd_beat,
                                 i_icb_cmd_usr};

  wire [CMD_PACK_W-1:0] cmd_fifo_o_dat;

  assign {
                                 o_icb_cmd_read,
                                 o_icb_cmd_addr,
                                 o_icb_cmd_wdata,
                                 o_icb_cmd_wmask,
                                 o_icb_cmd_lock,
                                 o_icb_cmd_excl,
                                 o_icb_cmd_size,
                                 o_icb_cmd_burst,
                                 o_icb_cmd_beat,
                                 o_icb_cmd_usr} = cmd_fifo_o_dat;

  wire o_icb_cmd_valid_pre;
  wire o_icb_cmd_ready_pre;

  wire cmd_fifo_i_valid;
  wire cmd_fifo_i_ready;
  assign cmd_fifo_i_valid = bus_clk_en & i_icb_cmd_valid;
  assign i_icb_cmd_ready  = bus_clk_en & cmd_fifo_i_ready;

  n22_gnrl_fifo # (
    .CUT_READY (CMD_CUT_READY),
    .MSKO      (CMD_MSKO),
    .DP  (CMD_DP),
    .DW  (CMD_PACK_W)
  ) u_n22_gnrl_cmd_fifo (
    .i_vld(cmd_fifo_i_valid),
    .i_rdy(cmd_fifo_i_ready),
    .i_dat(cmd_fifo_i_dat ),
    .o_vld(o_icb_cmd_valid_pre),
    .o_rdy(o_icb_cmd_ready_pre),
    .o_dat(cmd_fifo_o_dat ),

    .clk  (clk),
    .rst_n(rst_n)
  );

  wire rsp_buf_ready;

  generate
    if(RSP_ALWAYS_READY == 1) begin: gen_rsp_always_ready_1
      assign o_icb_cmd_valid     = rsp_buf_ready & o_icb_cmd_valid_pre;
      assign o_icb_cmd_ready_pre = rsp_buf_ready & o_icb_cmd_ready;
    end
    else begin: gen_rsp_always_ready_0
      assign o_icb_cmd_valid     = o_icb_cmd_valid_pre;
      assign o_icb_cmd_ready_pre = o_icb_cmd_ready;
    end
  endgenerate



  localparam RSP_PACK_W = (2+DW+USR_W);
  wire [RSP_PACK_W-1:0] rsp_fifo_i_dat = {
                                 o_icb_rsp_err,
                                 o_icb_rsp_excl_ok,
                                 o_icb_rsp_rdata,
                                 o_icb_rsp_usr};

  wire [RSP_PACK_W-1:0] rsp_fifo_o_dat;

  assign {
                                 i_icb_rsp_err,
                                 i_icb_rsp_excl_ok,
                                 i_icb_rsp_rdata,
                                 i_icb_rsp_usr} = rsp_fifo_o_dat;

      n22_gnrl_fifo # (
        .CUT_READY (RSP_CUT_READY),
        .MSKO      (0),
        .DP  (RSP_DP),
        .DW  (RSP_PACK_W)
      ) u_n22_gnrl_rsp_fifo (
        .i_vld(o_icb_rsp_valid),
        .i_rdy(o_icb_rsp_ready),
        .i_dat(rsp_fifo_i_dat ),
        .o_vld(i_icb_rsp_valid),
        .o_rdy(i_icb_rsp_ready),
        .o_dat(rsp_fifo_o_dat ),

        .clk  (clk),
        .rst_n(rst_n)
      );





  wire outs_cnt_inc = i_icb_cmd_valid & i_icb_cmd_ready;
  wire outs_cnt_dec = i_icb_rsp_valid & i_icb_rsp_ready;
  wire outs_cnt_ena = outs_cnt_inc ^ outs_cnt_dec;
  wire [OUTS_CNT_W-1:0] outs_cnt_r;
  wire [OUTS_CNT_W-1:0] outs_cnt_nxt = outs_cnt_inc ? (outs_cnt_r + 1'b1) : (outs_cnt_r - 1'b1);
  n22_gnrl_dfflr #(OUTS_CNT_W) outs_cnt_dfflr (outs_cnt_ena, outs_cnt_nxt, outs_cnt_r, clk, rst_n);

  assign icb_buffer_active = i_icb_cmd_valid | (~(outs_cnt_r == {OUTS_CNT_W{1'b0}}));

  wire o_outs_cnt_inc = o_icb_cmd_valid & o_icb_cmd_ready;
  wire o_outs_cnt_dec = i_icb_rsp_valid & i_icb_rsp_ready;
  wire o_outs_cnt_ena = o_outs_cnt_inc ^ o_outs_cnt_dec;
  wire [OUTS_CNT_W-1:0] o_outs_cnt_r;
  wire [OUTS_CNT_W-1:0] o_outs_cnt_nxt = o_outs_cnt_inc ? (o_outs_cnt_r + 1'b1) : (o_outs_cnt_r - 1'b1);
  n22_gnrl_dfflr #(OUTS_CNT_W) o_outs_cnt_dfflr (o_outs_cnt_ena, o_outs_cnt_nxt, o_outs_cnt_r, clk, rst_n);

  assign rsp_buf_ready = (o_outs_cnt_r == {OUTS_CNT_W{1'b0}});

endmodule



module n22_gnrl_icb_splt # (
  parameter AW = 32,
  parameter DW = 64,
  parameter USE_ALL_READY = 0,
  parameter FIFO_OUTS_NUM = 8,
  parameter FIFO_CUT_READY = 0,
  parameter SPLT_NUM = 4,
  parameter SPLT_PTR_1HOT = 1,
  parameter SPLT_PTR_W = 4,
  parameter ALLOW_DIFF = 1,
  parameter ALLOW_0CYCL_RSP = 1,
  parameter VLD_MSK_PAYLOAD = 0,
  parameter USR_W = 1
) (
  input  [SPLT_NUM-1:0] i_icb_splt_indic,

  input  i_icb_cmd_valid,
  output i_icb_cmd_ready,
  input             i_icb_cmd_read,
  input  [AW-1:0]   i_icb_cmd_addr,
  input  [DW-1:0]   i_icb_cmd_wdata,
  input  [(DW/8-1):0] i_icb_cmd_wmask,
  input  [2:0]      i_icb_cmd_burst,
  input  [1:0]      i_icb_cmd_beat,
  input             i_icb_cmd_lock,
  input             i_icb_cmd_excl,
  input  [1:0]      i_icb_cmd_size,
  input  [USR_W-1:0]i_icb_cmd_usr,

  output i_icb_rsp_valid,
  input  i_icb_rsp_ready,
  output i_icb_rsp_err,
  output i_icb_rsp_excl_ok,
  output [DW-1:0] i_icb_rsp_rdata,
  output [USR_W-1:0] i_icb_rsp_usr,

  input  [SPLT_NUM*1-1:0]    o_bus_icb_cmd_ready,
  output [SPLT_NUM*1-1:0]    o_bus_icb_cmd_valid,
  output [SPLT_NUM*1-1:0]    o_bus_icb_cmd_read,
  output [SPLT_NUM*AW-1:0]   o_bus_icb_cmd_addr,
  output [SPLT_NUM*DW-1:0]   o_bus_icb_cmd_wdata,
  output [(SPLT_NUM*DW/8-1):0] o_bus_icb_cmd_wmask,
  output [SPLT_NUM*3-1:0]    o_bus_icb_cmd_burst,
  output [SPLT_NUM*2-1:0]    o_bus_icb_cmd_beat,
  output [SPLT_NUM*1-1:0]    o_bus_icb_cmd_lock,
  output [SPLT_NUM*1-1:0]    o_bus_icb_cmd_excl,
  output [SPLT_NUM*2-1:0]    o_bus_icb_cmd_size,
  output [SPLT_NUM*USR_W-1:0]o_bus_icb_cmd_usr,

  input  [SPLT_NUM*1-1:0]  o_bus_icb_rsp_valid,
  output [SPLT_NUM*1-1:0]  o_bus_icb_rsp_ready,
  input  [SPLT_NUM*1-1:0]  o_bus_icb_rsp_err,
  input  [SPLT_NUM*1-1:0]  o_bus_icb_rsp_excl_ok,
  input  [SPLT_NUM*DW-1:0] o_bus_icb_rsp_rdata,
  input  [SPLT_NUM*USR_W-1:0] o_bus_icb_rsp_usr,

  input  clk,
  input  rst_n
  );



generate
  if(SPLT_NUM == 1) begin:gen_splt_num_eq_1
    assign i_icb_cmd_ready     = o_bus_icb_cmd_ready;
    assign o_bus_icb_cmd_valid = i_icb_cmd_valid;
    assign o_bus_icb_cmd_read  = i_icb_cmd_read ;
    assign o_bus_icb_cmd_addr  = i_icb_cmd_addr ;
    assign o_bus_icb_cmd_wdata = i_icb_cmd_wdata;
    assign o_bus_icb_cmd_wmask = i_icb_cmd_wmask;
    assign o_bus_icb_cmd_burst = i_icb_cmd_burst;
    assign o_bus_icb_cmd_beat  = i_icb_cmd_beat ;
    assign o_bus_icb_cmd_lock  = i_icb_cmd_lock ;
    assign o_bus_icb_cmd_excl  = i_icb_cmd_excl ;
    assign o_bus_icb_cmd_size  = i_icb_cmd_size ;
    assign o_bus_icb_cmd_usr   = i_icb_cmd_usr  ;

    assign o_bus_icb_rsp_ready = i_icb_rsp_ready;
    assign i_icb_rsp_valid     = o_bus_icb_rsp_valid;
    assign i_icb_rsp_err       = o_bus_icb_rsp_err  ;
    assign i_icb_rsp_excl_ok   = o_bus_icb_rsp_excl_ok  ;
    assign i_icb_rsp_rdata     = o_bus_icb_rsp_rdata;
    assign i_icb_rsp_usr       = o_bus_icb_rsp_usr;

  end
  else begin:gen_splt_num_gt_1

    genvar i;
    genvar ii;
    integer j;

    wire [SPLT_NUM-1:0] o_icb_cmd_valid;
    wire [SPLT_NUM-1:0] o_icb_cmd_ready;

    wire            o_icb_cmd_read [SPLT_NUM-1:0];
    wire [AW-1:0]   o_icb_cmd_addr [SPLT_NUM-1:0];
    wire [DW-1:0]   o_icb_cmd_wdata[SPLT_NUM-1:0];
    wire [(DW/8-1):0] o_icb_cmd_wmask[SPLT_NUM-1:0];
    wire [2:0]      o_icb_cmd_burst[SPLT_NUM-1:0];
    wire [1:0]      o_icb_cmd_beat [SPLT_NUM-1:0];
    wire            o_icb_cmd_lock [SPLT_NUM-1:0];
    wire            o_icb_cmd_excl [SPLT_NUM-1:0];
    wire [1:0]      o_icb_cmd_size [SPLT_NUM-1:0];
    wire [USR_W-1:0]o_icb_cmd_usr  [SPLT_NUM-1:0];

    wire [SPLT_NUM-1:0] o_icb_rsp_valid;
    wire [SPLT_NUM-1:0] o_icb_rsp_ready;
    wire [SPLT_NUM-1:0] o_icb_rsp_err  ;
    wire [SPLT_NUM-1:0] o_icb_rsp_excl_ok  ;
    wire [DW-1:0] o_icb_rsp_rdata  [SPLT_NUM-1:0];
    wire [USR_W-1:0] o_icb_rsp_usr [SPLT_NUM-1:0];

    wire [SPLT_NUM-1:0] o_icb_cmd_ready_excpt_this [SPLT_NUM-1:0];

    wire sel_o_icb_cmd_ready;

    wire rspid_fifo_bypass;
    wire rspid_fifo_wen;
    wire rspid_fifo_ren;

    wire [SPLT_PTR_W-1:0] o_icb_rsp_port_id;

    wire rspid_fifo_i_valid;
    wire rspid_fifo_o_valid;
    wire rspid_fifo_i_ready;
    wire rspid_fifo_o_ready;
    wire [SPLT_PTR_W-1:0] rspid_fifo_rdat;
    wire [SPLT_PTR_W-1:0] rspid_fifo_wdat;

    wire rspid_fifo_full;
    wire rspid_fifo_empty;
    reg [SPLT_PTR_W-1:0] i_splt_indic_id;

    wire i_icb_cmd_ready_pre;
    wire i_icb_cmd_valid_pre;

    wire i_icb_rsp_ready_pre;
    wire i_icb_rsp_valid_pre;


    for(i = 0; i < SPLT_NUM; i = i+1)
    begin:gen_icb_distract
      assign o_icb_cmd_ready[i]                             = o_bus_icb_cmd_ready[(i+1)*1     -1 : (i)*1     ];
      assign o_bus_icb_cmd_valid[(i+1)*1     -1 : i*1     ] = o_icb_cmd_valid[i];
      assign o_bus_icb_cmd_read [(i+1)*1     -1 : i*1     ] = o_icb_cmd_read [i];
      assign o_bus_icb_cmd_addr [(i+1)*AW    -1 : i*AW    ] = o_icb_cmd_addr [i];
      assign o_bus_icb_cmd_wdata[(i+1)*DW    -1 : i*DW    ] = o_icb_cmd_wdata[i];
      assign o_bus_icb_cmd_wmask[(i+1)*(DW/8)-1 : i*(DW/8)] = o_icb_cmd_wmask[i];
      assign o_bus_icb_cmd_burst[(i+1)*3     -1 : i*3     ] = o_icb_cmd_burst[i];
      assign o_bus_icb_cmd_beat [(i+1)*2     -1 : i*2     ] = o_icb_cmd_beat [i];
      assign o_bus_icb_cmd_lock [(i+1)*1     -1 : i*1     ] = o_icb_cmd_lock [i];
      assign o_bus_icb_cmd_excl [(i+1)*1     -1 : i*1     ] = o_icb_cmd_excl [i];
      assign o_bus_icb_cmd_size [(i+1)*2     -1 : i*2     ] = o_icb_cmd_size [i];
      assign o_bus_icb_cmd_usr  [(i+1)*USR_W -1 : i*USR_W ] = o_icb_cmd_usr  [i];

      assign o_bus_icb_rsp_ready[(i+1)*1-1 :i*1 ] = o_icb_rsp_ready[i];
      assign o_icb_rsp_valid[i]                   = o_bus_icb_rsp_valid[(i+1)*1-1 :i*1 ];
      assign o_icb_rsp_err  [i]                   = o_bus_icb_rsp_err  [(i+1)*1-1 :i*1 ];
      assign o_icb_rsp_excl_ok  [i]               = o_bus_icb_rsp_excl_ok  [(i+1)*1-1 :i*1 ];
      assign o_icb_rsp_rdata[i]                   = o_bus_icb_rsp_rdata[(i+1)*DW-1:i*DW];
      assign o_icb_rsp_usr  [i]                   = o_bus_icb_rsp_usr  [(i+1)*USR_W-1:i*USR_W];
    end

    if(USE_ALL_READY == 1) begin:gen_all_ready
      assign sel_o_icb_cmd_ready = (&o_icb_cmd_ready);
    end
    else begin:gen_non_all_ready
      reg  sel_o_icb_cmd_ready_reg;
      always @ (*) begin : sel_o_icb_cmd_ready_PROC
        sel_o_icb_cmd_ready_reg = 1'b0;
          for(j = 0; j < SPLT_NUM; j = j+1) begin
            sel_o_icb_cmd_ready_reg = sel_o_icb_cmd_ready_reg | (i_icb_splt_indic[j] & o_icb_cmd_ready[j]);
          end
      end
      assign sel_o_icb_cmd_ready = sel_o_icb_cmd_ready_reg;
    end

    assign i_icb_cmd_ready_pre = sel_o_icb_cmd_ready;

    if(ALLOW_DIFF == 1) begin:gen_allow_diff
       assign i_icb_cmd_valid_pre = i_icb_cmd_valid     & (~rspid_fifo_full);
       assign i_icb_cmd_ready     = i_icb_cmd_ready_pre & (~rspid_fifo_full);
    end
    else begin:gen_not_allow_diff
       wire cmd_diff_branch = (~rspid_fifo_empty) & (~(rspid_fifo_wdat == rspid_fifo_rdat));
       assign i_icb_cmd_valid_pre = i_icb_cmd_valid     & (~cmd_diff_branch) & (~rspid_fifo_full);
       assign i_icb_cmd_ready     = i_icb_cmd_ready_pre & (~cmd_diff_branch) & (~rspid_fifo_full);
    end


    if(SPLT_PTR_1HOT == 1) begin:gen_ptr_1hot
       always @ (*) begin : i_splt_indic_id_PROC
         i_splt_indic_id = i_icb_splt_indic;
       end
    end
    else begin:gen_ptr_not_1hot
       always @ (*) begin : i_splt_indic_id_PROC
         i_splt_indic_id = {SPLT_PTR_W{1'b0}};
         for(j = 0; j < SPLT_NUM; j = j+1) begin
           i_splt_indic_id = i_splt_indic_id | ({SPLT_PTR_W{i_icb_splt_indic[j]}} & $unsigned(j[SPLT_PTR_W-1:0]));
         end
       end
    end

    assign rspid_fifo_wen = i_icb_cmd_valid & i_icb_cmd_ready;
    assign rspid_fifo_ren = i_icb_rsp_valid & i_icb_rsp_ready;

    if(ALLOW_0CYCL_RSP == 1) begin: gen_allow_0rsp
        assign rspid_fifo_bypass = rspid_fifo_empty & rspid_fifo_wen & rspid_fifo_ren;
        assign o_icb_rsp_port_id = rspid_fifo_empty ? rspid_fifo_wdat : rspid_fifo_rdat;
        assign i_icb_rsp_valid     = i_icb_rsp_valid_pre;
        assign i_icb_rsp_ready_pre = i_icb_rsp_ready;
    end
    else begin: gen_no_allow_0rsp
        assign rspid_fifo_bypass = 1'b0;
        assign o_icb_rsp_port_id = rspid_fifo_empty ? {SPLT_PTR_W{1'b0}} : rspid_fifo_rdat;
        assign i_icb_rsp_valid     = (~rspid_fifo_empty) & i_icb_rsp_valid_pre;
        assign i_icb_rsp_ready_pre = (~rspid_fifo_empty) & i_icb_rsp_ready;
    end

    assign rspid_fifo_i_valid = rspid_fifo_wen & (~rspid_fifo_bypass);
    assign rspid_fifo_full    = (~rspid_fifo_i_ready);
    assign rspid_fifo_o_ready = rspid_fifo_ren & (~rspid_fifo_bypass);
    assign rspid_fifo_empty   = (~rspid_fifo_o_valid);

    assign rspid_fifo_wdat   = i_splt_indic_id;

    if(FIFO_OUTS_NUM == 1) begin:gen_fifo_dp_1
      n22_gnrl_pipe_stage # (
        .CUT_READY (FIFO_CUT_READY),
        .DP  (1),
        .DW  (SPLT_PTR_W)
      ) u_n22_gnrl_rspid_fifo (
        .i_vld(rspid_fifo_i_valid),
        .i_rdy(rspid_fifo_i_ready),
        .i_dat(rspid_fifo_wdat ),
        .o_vld(rspid_fifo_o_valid),
        .o_rdy(rspid_fifo_o_ready),
        .o_dat(rspid_fifo_rdat ),

        .clk  (clk),
        .rst_n(rst_n)
      );

    end
    else begin: gen_fifo_dp_gt_1
      n22_gnrl_fifo # (
        .CUT_READY (FIFO_CUT_READY),
        .MSKO      (0),
        .DP  (FIFO_OUTS_NUM),
        .DW  (SPLT_PTR_W)
      ) u_n22_gnrl_rspid_fifo (
        .i_vld(rspid_fifo_i_valid),
        .i_rdy(rspid_fifo_i_ready),
        .i_dat(rspid_fifo_wdat ),
        .o_vld(rspid_fifo_o_valid),
        .o_rdy(rspid_fifo_o_ready),
        .o_dat(rspid_fifo_rdat ),

        .clk  (clk),
        .rst_n(rst_n)
      );
    end

    for(i = 0; i < SPLT_NUM; i = i+1)
    begin:gen_o_icb_cmd_valid

      for(ii = 0; ii < SPLT_NUM; ii = ii+1)
      begin:gen_o_cmd_ready_excpt_this
         if(i == ii) begin: gen_same_i
           assign o_icb_cmd_ready_excpt_this[i][ii] = 1'b1;
         end
         else begin: gen_no_same_i
           assign o_icb_cmd_ready_excpt_this[i][ii] = o_icb_cmd_ready[ii];
         end
      end

      if(USE_ALL_READY == 1) begin:gen_all_ready
         assign o_icb_cmd_valid[i] = i_icb_splt_indic[i] & i_icb_cmd_valid_pre & (&o_icb_cmd_ready_excpt_this[i]);
      end
      else begin:gen_non_all_ready
         assign o_icb_cmd_valid[i] = i_icb_splt_indic[i] & i_icb_cmd_valid_pre;
      end
      if(VLD_MSK_PAYLOAD == 0) begin: gen_no_vld_msk_payload
          assign o_icb_cmd_read [i] = i_icb_cmd_read ;
          assign o_icb_cmd_addr [i] = i_icb_cmd_addr ;
          assign o_icb_cmd_wdata[i] = i_icb_cmd_wdata;
          assign o_icb_cmd_wmask[i] = i_icb_cmd_wmask;
          assign o_icb_cmd_burst[i] = i_icb_cmd_burst;
          assign o_icb_cmd_beat [i] = i_icb_cmd_beat ;
          assign o_icb_cmd_lock [i] = i_icb_cmd_lock ;
          assign o_icb_cmd_excl [i] = i_icb_cmd_excl ;
          assign o_icb_cmd_size [i] = i_icb_cmd_size ;
          assign o_icb_cmd_usr  [i] = i_icb_cmd_usr  ;
      end
      else begin: gen_vld_msk_payload
          assign o_icb_cmd_read [i] = {1    {o_icb_cmd_valid[i]}} & i_icb_cmd_read ;
          assign o_icb_cmd_addr [i] = {AW   {o_icb_cmd_valid[i]}} & i_icb_cmd_addr ;
          assign o_icb_cmd_wdata[i] = {DW   {o_icb_cmd_valid[i]}} & i_icb_cmd_wdata;
          assign o_icb_cmd_wmask[i] = {DW/8 {o_icb_cmd_valid[i]}} & i_icb_cmd_wmask;
          assign o_icb_cmd_burst[i] = {3    {o_icb_cmd_valid[i]}} & i_icb_cmd_burst;
          assign o_icb_cmd_beat [i] = {2    {o_icb_cmd_valid[i]}} & i_icb_cmd_beat ;
          assign o_icb_cmd_lock [i] = {1    {o_icb_cmd_valid[i]}} & i_icb_cmd_lock ;
          assign o_icb_cmd_excl [i] = {1    {o_icb_cmd_valid[i]}} & i_icb_cmd_excl ;
          assign o_icb_cmd_size [i] = {2    {o_icb_cmd_valid[i]}} & i_icb_cmd_size ;
          assign o_icb_cmd_usr  [i] = {USR_W{o_icb_cmd_valid[i]}} & i_icb_cmd_usr  ;
      end
    end

    if(SPLT_PTR_1HOT == 1) begin:gen_ptr_1hot_rsp

        for(i = 0; i < SPLT_NUM; i = i+1)
        begin:gen_o_icb_rsp_ready
          assign o_icb_rsp_ready[i] = (o_icb_rsp_port_id[i] & i_icb_rsp_ready_pre);
        end
        assign i_icb_rsp_valid_pre = |(o_icb_rsp_valid & o_icb_rsp_port_id);


        reg sel_i_icb_rsp_err;
        reg sel_i_icb_rsp_excl_ok;
        reg [DW-1:0] sel_i_icb_rsp_rdata;
        reg [USR_W-1:0] sel_i_icb_rsp_usr;

        always @ (*) begin : sel_icb_rsp_PROC
          sel_i_icb_rsp_err   = 1'b0;
          sel_i_icb_rsp_excl_ok   = 1'b0;
          sel_i_icb_rsp_rdata = {DW   {1'b0}};
          sel_i_icb_rsp_usr   = {USR_W{1'b0}};
          for(j = 0; j < SPLT_NUM; j = j+1) begin
            sel_i_icb_rsp_err     = sel_i_icb_rsp_err     | (       o_icb_rsp_port_id[j]   & o_icb_rsp_err[j]);
            sel_i_icb_rsp_excl_ok = sel_i_icb_rsp_excl_ok | (       o_icb_rsp_port_id[j]   & o_icb_rsp_excl_ok[j]);
            sel_i_icb_rsp_rdata   = sel_i_icb_rsp_rdata   | ({DW   {o_icb_rsp_port_id[j]}} & o_icb_rsp_rdata[j]);
            sel_i_icb_rsp_usr     = sel_i_icb_rsp_usr     | ({USR_W{o_icb_rsp_port_id[j]}} & o_icb_rsp_usr[j]);
          end
        end

        assign i_icb_rsp_err   = sel_i_icb_rsp_err  ;
        assign i_icb_rsp_excl_ok   = sel_i_icb_rsp_excl_ok  ;
        assign i_icb_rsp_rdata = sel_i_icb_rsp_rdata;
        assign i_icb_rsp_usr   = sel_i_icb_rsp_usr  ;

    end
    else begin:gen_ptr_not_1hot_rsp

        for(i = 0; i < SPLT_NUM; i = i+1)
        begin:gen_o_icb_rsp_ready
          assign o_icb_rsp_ready[i] = (o_icb_rsp_port_id == i[SPLT_PTR_W-1:0]) & i_icb_rsp_ready_pre;
        end
        assign i_icb_rsp_valid_pre = o_icb_rsp_valid[o_icb_rsp_port_id];


        assign i_icb_rsp_err     = o_icb_rsp_err    [o_icb_rsp_port_id];
        assign i_icb_rsp_excl_ok = o_icb_rsp_excl_ok[o_icb_rsp_port_id];
        assign i_icb_rsp_rdata   = o_icb_rsp_rdata  [o_icb_rsp_port_id];
        assign i_icb_rsp_usr     = o_icb_rsp_usr    [o_icb_rsp_port_id];
    end

  end
  endgenerate

endmodule







module n22_gnrl_icb2ahbl
  #(
    parameter SUPPORT_LOCK = 0,
    parameter SUPPORT_BURST = 0,
    parameter AW = 32,
    parameter DW = 32
    )
  (
  input              lock_clear_ena,

  input              icb_cmd_valid,
  output             icb_cmd_ready,
  input              icb_cmd_read,
  input  [AW-1:0]    icb_cmd_addr,
  input  [DW-1:0]    icb_cmd_wdata,
  input  [(DW/8-1):0]  icb_cmd_wmask,
  input  [1:0]       icb_cmd_size,
  input              icb_cmd_lock,
  input              icb_cmd_excl,
  input  [3-1:0]     icb_cmd_burst,
  input  [2-1:0]     icb_cmd_beat,
  input  [3:0]       icb_cmd_hprot,
  input  [1:0]       icb_cmd_attri,
  input              icb_cmd_dmode,

  output             icb_rsp_valid,
  output             icb_rsp_err,
  output             icb_rsp_excl_ok,
  output [DW-1:0]    icb_rsp_rdata,

  output [1:0]       ahbl_htrans,
  output             ahbl_hwrite,
  output [AW    -1:0]ahbl_haddr,
  output [2:0]       ahbl_hsize,
  output             ahbl_hlock,
  output             ahbl_hexcl,
  output [2:0]       ahbl_hburst,
  output [DW    -1:0]ahbl_hwdata,
  output [3:0]       ahbl_hprot,
  output [1:0]       ahbl_hattri,
  output [1:0]       ahbl_master,
  input  [DW    -1:0]ahbl_hrdata,
  input  [1:0]       ahbl_hresp,
  input              ahbl_hresp_exok,
  input              ahbl_hready,

  input              bus_clk_en,

  output             icb2ahbl_pend_active,

  input              clk,
  input              rst_n
  );

  wire icb_rsp_ready = 1'b1;

`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off










//synopsys translate_on
`endif
`endif


  wire ahbl_hready_en = ahbl_hready & bus_clk_en;

  wire i_icb_cmd_valid;
  wire i_icb_cmd_ready;
  wire i_icb_rsp_valid;

  wire icb_cmd_wmask0;

  wire wmask0_r;
  wire wmask0_set;
  wire wmask0_clr;
  wire wmask0_ena;
  wire wmask0_nxt;

  wire icb_out_flag_r;
  wire icb_out_flag_set;
  wire icb_out_flag_clr;
  wire icb_out_flag_ena;
  wire icb_out_flag_nxt;

  wire wmask0_rsp_vld;










      assign icb_cmd_wmask0  = 1'b0;
      assign wmask0_r   = 1'b0;
      assign wmask0_set = 1'b0;
      assign wmask0_clr = 1'b0;
      assign wmask0_ena = 1'b0;
      assign wmask0_nxt = 1'b0;

      assign wmask0_rsp_vld = 1'b0;

      assign icb_out_flag_r   = 1'b0;
      assign icb_out_flag_set = 1'b0;
      assign icb_out_flag_clr = 1'b0;
      assign icb_out_flag_ena = 1'b0;
      assign icb_out_flag_nxt = 1'b0;

      assign i_icb_cmd_valid = icb_cmd_valid;
      assign icb_cmd_ready   = i_icb_cmd_ready;
      assign icb_rsp_valid   = i_icb_rsp_valid;

  wire burst_flag_set;
  wire burst_flag_clr;
  wire burst_flag_ena;
  wire burst_flag_nxt;
  wire burst_flag_r;

  wire lock2idle_r;
  wire lock_flag_r;
  wire lock_clear_dly_r;

  wire ahbl_eff_trans = ahbl_hready_en & ahbl_htrans[1];

  generate

    if(SUPPORT_BURST == 1) begin:gen_burst_1
      assign burst_flag_set = icb_cmd_beat[0] & ahbl_eff_trans;
      assign burst_flag_clr = icb_cmd_beat[1] & ahbl_eff_trans;
      assign burst_flag_ena = burst_flag_set |   burst_flag_clr;
      assign burst_flag_nxt = burst_flag_set | (~burst_flag_clr);

      n22_gnrl_dfflr #(1) burst_flag_dfflr (burst_flag_ena, burst_flag_nxt, burst_flag_r, clk, rst_n);
    end
    else begin: gen_burst_0
      assign burst_flag_set = 1'b0;
      assign burst_flag_clr = 1'b0;
      assign burst_flag_ena = 1'b0;
      assign burst_flag_nxt = 1'b0;
      assign burst_flag_r = 1'b0;
    end

  endgenerate

  assign i_icb_cmd_ready  = ahbl_hready_en   & (~lock2idle_r);
  assign ahbl_htrans[1] = i_icb_cmd_valid & (~lock2idle_r);
  assign ahbl_htrans[0] = burst_flag_r;


  localparam FSM_W  = 2;
  localparam STA_AR = 2'b00;
  localparam STA_WD = 2'b01;
  localparam STA_RD = 2'b10;

  wire[FSM_W-1:0] ahbl_sta_r;
  wire[FSM_W-1:0] ahbl_sta_nxt;

  wire to_wd_sta = ahbl_eff_trans & ahbl_hwrite;
  wire to_rd_sta = ahbl_eff_trans & (~ahbl_hwrite);
  wire to_ar_sta = ahbl_hready_en & (~ahbl_htrans[1]);

  wire  ahbl_sta_is_ar = (ahbl_sta_r == STA_AR);

  assign ahbl_sta_nxt = ahbl_hready_en ?  (
                               {FSM_W{to_ar_sta}} & (STA_AR)
                             | {FSM_W{to_wd_sta}} & (STA_WD)
                             | {FSM_W{to_rd_sta}} & (STA_RD)
                         ) : ahbl_sta_r;

  n22_gnrl_dffr #(FSM_W) ahbl_sta_dffr (ahbl_sta_nxt, ahbl_sta_r, clk, rst_n);

  wire [DW-1:0]ahbl_hwdata_r;
  wire ahbl_hwdata_ena = to_wd_sta;
  n22_gnrl_dfflr #(DW) ahbl_hwdata_dfflr (ahbl_hwdata_ena, icb_cmd_wdata, ahbl_hwdata_r, clk, rst_n);



  assign ahbl_hwrite = ~icb_cmd_read;
  assign ahbl_haddr  = icb_cmd_addr;
  assign ahbl_hsize  = {1'b0,icb_cmd_size};
  assign ahbl_hexcl  = icb_cmd_excl;
  assign ahbl_hburst = icb_cmd_burst;
  assign ahbl_hwdata = ahbl_hwdata_r;

  assign ahbl_hprot  = icb_cmd_hprot ;
  assign ahbl_hattri = icb_cmd_attri;


  wire icb_cmd_ifu  = (~icb_cmd_dmode) & (~icb_cmd_hprot[0]);
  wire icb_cmd_data = (~icb_cmd_dmode) & icb_cmd_hprot[0];
  wire icb_cmd_dbg  = icb_cmd_dmode;

  wire [1:0] icb_cmd_master =
                        icb_cmd_data ? 2'b00 :
                        icb_cmd_dbg ? 2'b01 :
                        icb_cmd_ifu ? 2'b10 :
                                      2'b11;
  assign ahbl_master = icb_cmd_master;

  assign i_icb_rsp_valid = ahbl_hready_en & (~ahbl_sta_is_ar);
  assign icb_rsp_rdata = ahbl_hrdata;
  assign icb_rsp_err   = ahbl_hresp[0];
  assign icb_rsp_excl_ok   = ahbl_hresp_exok;


  wire lock2idle_set;
  wire lock2idle_clr;
  wire lock2idle_ena;
  wire lock2idle_nxt;

  wire lock_flag_set;
  wire lock_flag_clr;
  wire lock_flag_ena;
  wire lock_flag_nxt;

  wire lock_clear_dly_set;
  wire lock_clear_dly_clr;
  wire lock_clear_dly_ena;
  wire lock_clear_dly_nxt;

  generate

    if(SUPPORT_LOCK == 1) begin:gen_lock_1
      assign ahbl_hlock    = ((icb_cmd_lock & icb_cmd_valid) | lock_flag_r) & (~lock2idle_r);

      assign lock2idle_set = lock_flag_clr;
      assign lock2idle_clr = lock2idle_r & to_ar_sta;
      assign lock2idle_ena = lock2idle_set | lock2idle_clr;
      assign lock2idle_nxt = lock2idle_set & (~lock2idle_clr);
      n22_gnrl_dfflr #(1) lock2idle_dfflr (lock2idle_ena, lock2idle_nxt, lock2idle_r, clk, rst_n);

      wire lock_clear_to_delay = (burst_flag_r | icb_cmd_valid);
      assign lock_clear_dly_set = (lock_clear_ena & lock_clear_to_delay);
      assign lock_clear_dly_clr = lock_flag_clr | (~lock_flag_r);
      assign lock_clear_dly_ena = lock_clear_dly_set |   lock_clear_dly_clr;
      assign lock_clear_dly_nxt = lock_clear_dly_set & (~lock_clear_dly_clr);
      n22_gnrl_dfflr #(1) lock_clear_dly_dfflr (lock_clear_dly_ena, lock_clear_dly_nxt, lock_clear_dly_r, clk, rst_n);

      assign lock_flag_set = to_rd_sta & icb_cmd_lock;
      assign lock_flag_clr = lock_flag_r & (
                             (to_wd_sta & (~icb_cmd_lock))
                           | (lock_clear_ena & (~lock_clear_to_delay))
                           | (lock_clear_dly_r & (~lock_clear_to_delay))
                           )
                           ;
      assign lock_flag_ena = lock_flag_set | lock_flag_clr;
      assign lock_flag_nxt = lock_flag_set & (~lock_flag_clr);
      n22_gnrl_dfflr #(1) lock_flag_dfflr (lock_flag_ena, lock_flag_nxt, lock_flag_r, clk, rst_n);
    end

    else begin: gen_lock_0
      assign lock2idle_set = 1'b0;
      assign lock2idle_clr = 1'b0;
      assign lock2idle_ena = 1'b0;
      assign lock2idle_nxt = 1'b0;

      assign lock_flag_set = 1'b0;
      assign lock_flag_clr = 1'b0;
      assign lock_flag_ena = 1'b0;
      assign lock_flag_nxt = 1'b0;

      assign lock_clear_dly_set = 1'b0;
      assign lock_clear_dly_clr = 1'b0;
      assign lock_clear_dly_ena = 1'b0;
      assign lock_clear_dly_nxt = 1'b0;

      assign ahbl_hlock    = 1'b0;
      assign lock2idle_r   = 1'b0;
      assign lock_flag_r   = 1'b0;
      assign lock_clear_dly_r   = 1'b0;
    end

  endgenerate


  `ifndef FPGA_SOURCE
  `ifndef SYNTHESIS







  `endif
  `endif


  assign icb2ahbl_pend_active = lock2idle_r
                           | lock_clear_ena
                           | lock_clear_dly_r;

endmodule




module n22_gnrl_ahbl2icb
  #(
    parameter AW = 32,
    parameter DW = 32
    )
  (

  output             ahbl2icb_active,

  input              ahbl_hsel,
  input              ahbl_hexcl,
  input  [1:0]       ahbl_htrans,
  input              ahbl_hwrite,
  input  [AW    -1:0]ahbl_haddr,
  input  [2:0]       ahbl_hsize,
  input  [DW    -1:0]ahbl_hwdata,

  output  [DW   -1:0]ahbl_hrdata,
  output  [1:0]      ahbl_hresp,
  output             ahbl_hresp_exok,
  input              ahbl_hready_in,
  output             ahbl_hready_out,

  output             icb_cmd_valid,
  input              icb_cmd_ready,
  output             icb_cmd_read,
  output  [AW-1:0]   icb_cmd_addr,
  output  [DW-1:0]   icb_cmd_wdata,
  output  [(DW/8-1):0] icb_cmd_wmask,
  output  [1:0]      icb_cmd_size,
  output             icb_cmd_excl,

  input              icb_rsp_valid,
  output             icb_rsp_ready,
  input              icb_rsp_err,
  input              icb_rsp_excl_ok,
  input  [DW-1:0]    icb_rsp_rdata,

  input              clk,
  input              rst_n
  );


  wire  i_icb_cmd_valid;
  wire  i_icb_cmd_ready;
  wire  i_icb_cmd_read;
  wire  i_icb_cmd_excl;
  wire  [AW-1:0] i_icb_cmd_addr;
  wire  [DW-1:0] i_icb_cmd_wdata;
  wire  [(DW/8-1):0] i_icb_cmd_wmask;
  wire  [2-1:0] i_icb_cmd_size;

  localparam BUF_CMD_PACK_W = (AW+DW+(DW/8)+4);
  wire [BUF_CMD_PACK_W-1:0] icb_cmd_pack;
  wire [BUF_CMD_PACK_W-1:0] i_icb_cmd_pack =  {
                      i_icb_cmd_read,
                      i_icb_cmd_excl,
                      i_icb_cmd_addr,
                      i_icb_cmd_wdata,
                      i_icb_cmd_wmask,
                      i_icb_cmd_size
                    };
  assign {
                      icb_cmd_read,
                      icb_cmd_excl,
                      icb_cmd_addr,
                      icb_cmd_wdata,
                      icb_cmd_wmask,
                      icb_cmd_size
                    } = icb_cmd_pack;


  n22_gnrl_bypbuf # (
   .DP(1),
   .DW(BUF_CMD_PACK_W)
  ) u_byp_icb_cmd_buf(
    .i_vld(i_icb_cmd_valid),
    .i_rdy(i_icb_cmd_ready),
    .i_dat(i_icb_cmd_pack),
    .o_vld(icb_cmd_valid),
    .o_rdy(icb_cmd_ready),
    .o_dat(icb_cmd_pack),

    .clk  (clk  ),
    .rst_n(rst_n)
   );



  wire i_icb_rsp_valid;
  wire i_icb_rsp_ready;
  wire i_icb_rsp_err;
  wire i_icb_rsp_excl_ok;
  wire [DW-1:0] i_icb_rsp_rdata;

  wire [DW+2-1:0]i_icb_rsp_pack;
  wire [DW+2-1:0]icb_rsp_pack;

  assign icb_rsp_pack = {
                          icb_rsp_excl_ok,
                          icb_rsp_err,
                          icb_rsp_rdata
                          };

  assign {
                          i_icb_rsp_excl_ok,
                          i_icb_rsp_err,
                          i_icb_rsp_rdata
                          } = i_icb_rsp_pack;

  n22_gnrl_bypbuf # (
    .DP(1),
    .DW(DW+2)
  ) u_ahbl2icb_rsp_bypbuf(
      .i_vld   (icb_rsp_valid),
      .i_rdy   (icb_rsp_ready),

      .o_vld   (i_icb_rsp_valid),
      .o_rdy   (i_icb_rsp_ready),

      .i_dat   (icb_rsp_pack),
      .o_dat   (i_icb_rsp_pack),

      .clk     (clk  ),
      .rst_n   (rst_n)
  );


  wire ahbl_hready_real = ahbl_hready_out & ahbl_hready_in;

  wire ahbl_hsel_trans  =
        ahbl_hsel
      & ahbl_htrans[1]
      ;

  wire ahbl_addr_en  = ahbl_hsel_trans
      & ahbl_hready_real;

  wire [1:0] ahbl_htrans_r;

  wire ahbl_data_en  =
        ahbl_htrans_r[1]
      & ahbl_hready_real;

  wire ahbl_hvalid_r;
  wire ahbl_hvalid_ena = ahbl_hready_real;
  wire ahbl_hvalid_nxt = ahbl_addr_en;
  n22_gnrl_dfflr #(1) ahbl_hvalid_dfflr (ahbl_hvalid_ena, ahbl_hvalid_nxt, ahbl_hvalid_r, clk, rst_n);


  wire ahbl_htrans_ena = ahbl_hready_real;
  wire [1:0] ahbl_htrans_nxt = ahbl_htrans;
  n22_gnrl_dfflr #(2) ahbl_htrans_dfflr (ahbl_htrans_ena, ahbl_htrans_nxt, ahbl_htrans_r, clk, rst_n);

  wire ahbl_hexcl_r;
  wire ahbl_hexcl_ena = ahbl_hready_real;
  wire ahbl_hexcl_nxt = ahbl_hexcl;
  n22_gnrl_dfflr #(1) ahbl_hexcl_dfflr (ahbl_hexcl_ena, ahbl_hexcl_nxt, ahbl_hexcl_r, clk, rst_n);

  wire [1:0] ahbl_hsize_r;
  wire ahbl_hsize_ena = ahbl_hready_real;
  wire [1:0] ahbl_hsize_nxt = ahbl_hsize[1:0];
  n22_gnrl_dfflr #(2) ahbl_hsize_dfflr (ahbl_hsize_ena, ahbl_hsize_nxt, ahbl_hsize_r, clk, rst_n);

  wire ahbl_haddr_ena = ahbl_hready_real;
  wire [AW-1:0] ahbl_haddr_r;
  wire [AW-1:0] ahbl_haddr_nxt = ahbl_haddr;
  n22_gnrl_dfflr #(AW) ahbl_haddr_dfflr (ahbl_haddr_ena, ahbl_haddr_nxt, ahbl_haddr_r, clk, rst_n);


  wire icb_wr_vld_r;

  assign i_icb_cmd_read = icb_wr_vld_r ? 1'b0 : 1'b1;
  assign i_icb_cmd_addr = icb_wr_vld_r ? ahbl_haddr_r : ahbl_haddr;
  assign i_icb_cmd_size = icb_wr_vld_r ? ahbl_hsize_r[1:0] : ahbl_hsize[1:0];
  assign i_icb_cmd_excl = icb_wr_vld_r ? ahbl_hexcl_r : ahbl_hexcl;
  assign i_icb_cmd_wdata = ahbl_hwdata;

  wire [(DW/8-1):0] ahbl2icb_wmask;
  wire [(DW/8-1):0] ahbl2icb_wmask_r;

  wire ahbl2icb_wmask_ena = ahbl_hready_real;
  wire [(DW/8-1):0] ahbl2icb_wmask_nxt = ahbl2icb_wmask;
  n22_gnrl_dfflr #(DW/8) ahbl2icb_wmask_dfflr (ahbl2icb_wmask_ena, ahbl2icb_wmask_nxt, ahbl2icb_wmask_r, clk, rst_n);

  assign i_icb_cmd_wmask = ahbl2icb_wmask_r;

  generate

  if(DW == 64) begin:gen_dw_64
     assign ahbl2icb_wmask =
         (ahbl_hsize == 2'b00) ? (1'b1 << ahbl_haddr[2:0])
       : (ahbl_hsize == 2'b01) ? (2'b11 << {ahbl_haddr[2:1],1'b0})
       : (ahbl_hsize == 2'b10) ? (4'b1111 << {ahbl_haddr[2],2'b0})
       : (8'b1111_1111)
       ;
  end

  if(DW == 32) begin:gen_dw_32
     assign ahbl2icb_wmask =
         (ahbl_hsize == 2'b00) ? (1'b1 << ahbl_haddr[1:0])
       : (ahbl_hsize == 2'b01) ? (2'b11 << {ahbl_haddr[1:1],1'b0})
       : (ahbl_hsize == 2'b10) ? (4'b1111)
       : (4'b1111)
       ;
  end

  endgenerate

  wire rd_hresp_1st_err_r;
  wire rd_hresp_1st_err;
  wire rd_hresp_1st_err_set = i_icb_rsp_valid & rd_hresp_1st_err;
  wire rd_hresp_1st_err_clr = rd_hresp_1st_err_r & ahbl_hready_real;
  wire rd_hresp_1st_err_ena = rd_hresp_1st_err_set | rd_hresp_1st_err_clr;
  wire rd_hresp_1st_err_nxt = rd_hresp_1st_err_set | (~rd_hresp_1st_err_clr);
  n22_gnrl_dfflr #(1) rd_hresp_1st_err_dfflr (rd_hresp_1st_err_ena, rd_hresp_1st_err_nxt, rd_hresp_1st_err_r, clk, rst_n);

  wire ahbl_hsel_trans_wr = (ahbl_hsel_trans & ahbl_hwrite);

  wire icb_wr_vld_set = ahbl_hvalid_ena & ahbl_hsel_trans_wr;
  wire icb_wr_vld_clr = i_icb_cmd_valid & i_icb_cmd_ready & (~i_icb_cmd_read);
  wire icb_wr_vld_ena = icb_wr_vld_set | icb_wr_vld_clr;
  wire icb_wr_vld_nxt = icb_wr_vld_set | (~icb_wr_vld_clr);
  n22_gnrl_dfflr #(1) icb_wr_vld_dfflr (icb_wr_vld_ena, icb_wr_vld_nxt, icb_wr_vld_r, clk, rst_n);

  wire icb_rd_vld_r;
  wire icb_rd_vld_set = i_icb_cmd_valid & i_icb_cmd_ready & i_icb_cmd_read;
  wire icb_rd_vld_clr = i_icb_rsp_valid & i_icb_rsp_ready & icb_rd_vld_r;
  wire icb_rd_vld_ena = icb_rd_vld_set | icb_rd_vld_clr;
  wire icb_rd_vld_nxt = icb_rd_vld_set | (~icb_rd_vld_clr);
  n22_gnrl_dfflr #(1) icb_rd_vld_dfflr (icb_rd_vld_ena, icb_rd_vld_nxt, icb_rd_vld_r, clk, rst_n);

  wire icb_out_flag_r;
  wire outs_cnt_inc = i_icb_cmd_valid & i_icb_cmd_ready;
  wire outs_cnt_dec = i_icb_rsp_valid & i_icb_rsp_ready;
  wire outs_cnt_ena = outs_cnt_inc ^ outs_cnt_dec;
  wire [2-1:0] outs_cnt_r;
  wire [2-1:0] outs_cnt_nxt = outs_cnt_inc ? (outs_cnt_r + 1'b1) : (outs_cnt_r - 1'b1);
  n22_gnrl_dfflr #(2) outs_cnt_dfflr (outs_cnt_ena, outs_cnt_nxt, outs_cnt_r, clk, rst_n);

  assign icb_out_flag_r = (~(outs_cnt_r == {2{1'b0}}));


  wire icb_out_rd_r;
  wire icb_out_rd_ena = outs_cnt_inc;
  wire icb_out_rd_nxt = i_icb_cmd_read;
  n22_gnrl_dfflr #(1) icb_out_rd_dfflr (icb_out_rd_ena, icb_out_rd_nxt, icb_out_rd_r, clk, rst_n);

  wire ahbl_hsel_trans_rd = (ahbl_hsel_trans & (~ahbl_hwrite));
  wire hready_out_condi;
  assign i_icb_cmd_valid = (
                 (ahbl_hsel_trans_rd & hready_out_condi)
               | icb_wr_vld_r)
               ;

  assign rd_hresp_1st_err = (i_icb_rsp_err & icb_out_rd_r) ? (~rd_hresp_1st_err_r) : 1'b0;

  wire   wait_wr_finish = (icb_out_flag_r & (~icb_out_rd_r));

  assign hready_out_condi =
                (icb_out_flag_r ? ((outs_cnt_r == 2'b1) & i_icb_rsp_valid) : 1'b1) &
                ((wait_wr_finish & (~ahbl_hwrite)) ? i_icb_rsp_valid : 1'b1) &
                ((wait_wr_finish & ahbl_hwrite & ahbl_hexcl) ? i_icb_rsp_valid : 1'b1) &
                (
                  (~ahbl_hvalid_r) ? 1'b1 :
                  icb_rd_vld_r ? (~rd_hresp_1st_err) :
                  icb_wr_vld_r ? (ahbl_hwrite & (~ahbl_hexcl)) :
                  1'b1);
  assign ahbl_hready_out = i_icb_cmd_ready & hready_out_condi;

  assign i_icb_rsp_ready = (ahbl_hready_in & (~rd_hresp_1st_err))
                         | wait_wr_finish;

  assign ahbl_hrdata = i_icb_rsp_rdata;
  assign ahbl_hresp[0]  = 1'b0;
  assign ahbl_hresp[1]  = 1'b0;
  assign ahbl_hresp_exok  = i_icb_rsp_excl_ok;

  assign ahbl2icb_active = i_icb_cmd_valid | icb_cmd_valid | icb_out_flag_r;

endmodule




module n22_gnrl_icb_active # (
  parameter OUTS_CNT_W = 1
) (

  output             icb_active,

  input              icb_cmd_valid,
  input              icb_cmd_ready,

  input              icb_rsp_valid,
  input              icb_rsp_ready,

  input              clk,
  input              rst_n
  );


  wire outs_cnt_inc = icb_cmd_valid & icb_cmd_ready;
  wire outs_cnt_dec = icb_rsp_valid & icb_rsp_ready;
  wire outs_cnt_ena = outs_cnt_inc ^ outs_cnt_dec;
  wire [OUTS_CNT_W-1:0] outs_cnt_r;
  wire [OUTS_CNT_W-1:0] outs_cnt_nxt = outs_cnt_inc ? (outs_cnt_r + 1'b1) : (outs_cnt_r - 1'b1);
  n22_gnrl_dfflr #(OUTS_CNT_W) outs_cnt_dfflr (outs_cnt_ena, outs_cnt_nxt, outs_cnt_r, clk, rst_n);

  assign icb_active = icb_cmd_valid | (~(outs_cnt_r == {OUTS_CNT_W{1'b0}}));


endmodule




`ifdef N22_HAS_PPI

module n22_gnrl_icb2apb # (
  parameter AW = 32,
  parameter DW = 64
) (
  input              icb_cmd_valid,
  output             icb_cmd_ready,
  input              icb_cmd_read,
  input  [AW-1:0]    icb_cmd_addr,
  input  [DW-1:0]    icb_cmd_wdata,
  input  [(DW/8-1):0]  icb_cmd_wmask,
  input  [1:0]       icb_cmd_size,
  input              icb_cmd_dmode,
  input              icb_cmd_mmode,

  output             icb_rsp_valid,
  output             icb_rsp_err,
  output [DW-1:0]    icb_rsp_rdata,

  output [AW-1:0] apb_paddr,
  output          apb_pwrite,
  output          apb_psel,
  output          apb_dmode,
  output [2:0]    apb_pprot,
  output [3:0]    apb_pstrobe,
  output          apb_penable,
  output [DW-1:0] apb_pwdata,
  input  [DW-1:0] apb_prdata,
  input           apb_pready,
  input           apb_pslverr,

  input  clk,
  input  rst_n
  );


`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off












//synopsys translate_on
`endif
`endif

  wire apb_enable_r;

  assign icb_rsp_valid = icb_cmd_ready;
  assign icb_rsp_rdata = apb_prdata;

  assign icb_rsp_err = apb_pslverr;

  wire apb_enable_set = (~apb_enable_r) & icb_cmd_valid;
  assign icb_cmd_ready = (apb_enable_r & apb_pready);
  wire apb_enable_clr = icb_cmd_ready;
  wire apb_enable_ena = apb_enable_set | apb_enable_clr;
  wire apb_enable_nxt = apb_enable_set & (~apb_enable_clr);
  n22_gnrl_dfflr #(1) apb_enable_dfflr (apb_enable_ena, apb_enable_nxt, apb_enable_r, clk, rst_n);


  assign apb_paddr  = icb_cmd_addr;
  assign apb_pwrite = (~icb_cmd_read);
  assign apb_dmode  = icb_cmd_dmode;

  assign apb_pprot[0] = icb_cmd_mmode;
  assign apb_pprot[1] = 1'b1         ;
  assign apb_pprot[2] = 1'b0         ;

  assign apb_psel    = icb_cmd_valid;
  assign apb_penable = apb_enable_r;
  assign apb_pwdata  = icb_cmd_wdata;
  assign apb_pstrobe = icb_cmd_read ? {DW/8{1'b0}} : icb_cmd_wmask;

endmodule



module n22_gnrl_apb2icb # (
  parameter AW = 32,
  parameter DW = 64
) (
  output              icb_cmd_valid,
  input               icb_cmd_ready,
  output              icb_cmd_read,
  output  [AW-1:0]    icb_cmd_addr,
  output  [DW-1:0]    icb_cmd_wdata,
  output  [(DW/8-1):0]  icb_cmd_wmask,
  output  [1:0]       icb_cmd_size,

  input               icb_rsp_valid,
  input               icb_rsp_err,
  input   [DW-1:0]    icb_rsp_rdata,

  input   [AW-1:0] apb_paddr,
  input            apb_pwrite,
  input            apb_psel ,
  input            apb_penable,
  input   [DW-1:0] apb_pwdata,
  output  [DW-1:0] apb_prdata,
  output           apb_pready,
  output           apb_pslverr,

  input  clk,
  input  rst_n
  );

  assign apb_prdata  = icb_rsp_rdata;
  assign apb_pslverr = icb_rsp_err;

  assign apb_pready    = icb_cmd_ready;
  assign icb_cmd_valid = apb_psel & apb_penable;

  assign icb_cmd_read  = ~apb_pwrite;
  assign icb_cmd_addr  = apb_paddr;
  assign icb_cmd_wdata = apb_pwdata;
  assign icb_cmd_wmask = {DW/8{1'b1}};

  generate
    if(DW == 8) begin:gen_dw8
      assign icb_cmd_size = 2'b00;
    end
    if(DW == 16) begin:gen_dw16
      assign icb_cmd_size = 2'b01;
    end
    if(DW == 32) begin:gen_dw32
      assign icb_cmd_size = 2'b10;
    end
    if(DW == 64) begin:gen_dw64
      assign icb_cmd_size = 2'b11;
    end
  endgenerate

endmodule
`endif


