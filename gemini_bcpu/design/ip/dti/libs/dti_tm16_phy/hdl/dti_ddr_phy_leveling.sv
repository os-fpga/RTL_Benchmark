`include "dti_global_defines.vh"

module dti_ddr_phy_leveling #(
  parameter   PHY_SLICE_NUM       = `CFG_PHY_SLICE_NUM      ,
  parameter   CHAN_RANK_NUM       = `CFG_CHAN_RANK_NUM       ,
  parameter   PHY_GATE_DLY_WIDTH  = `CFG_PHY_GATE_DLY_WIDTH ,
  parameter   GTPH_WIDTH          = `CFG_GTPH_WIDTH         ,
  parameter   HOLD_WIDTH          = `CFG_HOLD_WIDTH
) (
  input   [ PHY_SLICE_NUM - 1 : 0 ]                         DTI_DATA_BYTE_DISABLE,
  input   [ CHAN_RANK_NUM - 1 : 0 ]                          ranken_reg_pom  ,
  input   [ PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1 : 0 ]    DTI_GTPH_R0     ,
  input   [ PHY_SLICE_NUM * PHY_GATE_DLY_WIDTH - 1 : 0 ]    DTI_GTPH_R1     ,
  output  [ PHY_SLICE_NUM * HOLD_WIDTH - 1 : 0 ]            DTI_HOLD_R0     ,
  output  [ PHY_SLICE_NUM * HOLD_WIDTH - 1 : 0 ]            DTI_HOLD_R1
);
  wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ PHY_SLICE_NUM - 1 : 0 ] [ PHY_GATE_DLY_WIDTH  - 1 : 0 ]   DTI_GTPH_IP ;
  wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ PHY_SLICE_NUM - 1 : 0 ] [ HOLD_WIDTH          - 1 : 0 ]   DTI_HOLD_OP ;
  wire    [ PHY_SLICE_NUM - 1 : 0 ] [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH          - 1 : 0 ]   gtph        ;
  wire    [ PHY_SLICE_NUM - 1 : 0 ] [ CHAN_RANK_NUM  - 1 : 0 ] [ HOLD_WIDTH          - 1 : 0 ]   hold        ;

  assign  DTI_GTPH_IP                   = {DTI_GTPH_R1, DTI_GTPH_R0};
  assign  { DTI_HOLD_R1, DTI_HOLD_R0 }  = DTI_HOLD_OP;
  genvar  sid, rid;
  generate
    for (sid = 0; sid < PHY_SLICE_NUM; sid = sid + 1) begin : PROC_SLICE
      for (rid = 0; rid < CHAN_RANK_NUM; rid = rid + 1) begin : PROC_RANK
        assign  gtph        [sid] [rid] = DTI_GTPH_IP [rid] [sid] [PHY_GATE_DLY_WIDTH-1:2] & {GTPH_WIDTH{~DTI_DATA_BYTE_DISABLE[sid] & ranken_reg_pom[rid]}};
        assign  DTI_HOLD_OP [rid] [sid] = hold        [sid] [rid];
      end
    end
  endgenerate

  generate
    if (PHY_SLICE_NUM == 4) begin  //  4 data slices
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max01    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max23    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max      ;
      wire                              [ GTPH_WIDTH  - 1 : 0 ]   gtph_max_final;
      
      assign  gtph_max01  [0] = gtph[0][0]    > gtph[1][0]    ? gtph[0][0]    : gtph[1][0]    ;
      assign  gtph_max23  [0] = gtph[2][0]    > gtph[3][0]    ? gtph[2][0]    : gtph[3][0]    ;
      assign  gtph_max    [0] = gtph_max01[0] > gtph_max23[0] ? gtph_max01[0] : gtph_max23[0] ;
      
      assign  gtph_max01  [1] = gtph[0][1]    > gtph[1][1]    ? gtph[0][1]    : gtph[1][1]    ;
      assign  gtph_max23  [1] = gtph[2][1]    > gtph[3][1]    ? gtph[2][1]    : gtph[3][1]    ;
      assign  gtph_max    [1] = gtph_max01[1] > gtph_max23[1] ? gtph_max01[1] : gtph_max23[1] ;
      
      assign  gtph_max_final  = gtph_max[0]   > gtph_max[1]   ? gtph_max[0]   : gtph_max[1]   ;
      
      assign  hold[0][0]      = gtph_max_final - gtph[0][0];
      assign  hold[0][1]      = gtph_max_final - gtph[0][1];
      assign  hold[1][0]      = gtph_max_final - gtph[1][0];
      assign  hold[1][1]      = gtph_max_final - gtph[1][1];
      assign  hold[2][0]      = gtph_max_final - gtph[2][0];
      assign  hold[2][1]      = gtph_max_final - gtph[2][1];
      assign  hold[3][0]      = gtph_max_final - gtph[3][0];
      assign  hold[3][1]      = gtph_max_final - gtph[3][1];
    end
    else if (PHY_SLICE_NUM == 5) begin  //  5 data slices
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max01    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max23    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max03    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max      ;
      wire                              [ GTPH_WIDTH  - 1 : 0 ]   gtph_max_final;
      
      assign  gtph_max01  [0] = gtph[0][0]    > gtph[1][0]    ? gtph[0][0]    : gtph[1][0]    ;
      assign  gtph_max23  [0] = gtph[2][0]    > gtph[3][0]    ? gtph[2][0]    : gtph[3][0]    ;
      assign  gtph_max03  [0] = gtph_max01[0] > gtph_max23[0] ? gtph_max01[0] : gtph_max23[0] ;
      assign  gtph_max    [0] = gtph_max03[0] > gtph[4][0]    ? gtph_max03[0] : gtph[4][0]    ;
      
      assign  gtph_max01  [1] = gtph[0][1]    > gtph[1][1]    ? gtph[0][1]    : gtph[1][1]    ;
      assign  gtph_max23  [1] = gtph[2][1]    > gtph[3][1]    ? gtph[2][1]    : gtph[3][1]    ;
      assign  gtph_max03  [1] = gtph_max01[1] > gtph_max23[1] ? gtph_max01[1] : gtph_max23[1] ;
      assign  gtph_max    [1] = gtph_max03[1] > gtph[4][1]    ? gtph_max03[1] : gtph[4][1]    ;
      
      assign  gtph_max_final  = gtph_max[0]   > gtph_max[1]   ? gtph_max[0]   : gtph_max[1]   ;
      
      assign  hold[0][0]      = gtph_max_final - gtph[0][0];
      assign  hold[0][1]      = gtph_max_final - gtph[0][1];
      assign  hold[1][0]      = gtph_max_final - gtph[1][0];
      assign  hold[1][1]      = gtph_max_final - gtph[1][1];
      assign  hold[2][0]      = gtph_max_final - gtph[2][0];
      assign  hold[2][1]      = gtph_max_final - gtph[2][1];
      assign  hold[3][0]      = gtph_max_final - gtph[3][0];
      assign  hold[3][1]      = gtph_max_final - gtph[3][1];
      assign  hold[4][0]      = gtph_max_final - gtph[4][0];
      assign  hold[4][1]      = gtph_max_final - gtph[4][1];
    end
    else if (PHY_SLICE_NUM == 8) begin  // 8 data slices
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max01    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max23    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max45    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max67    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max03    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max47    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max      ;
      wire                              [ GTPH_WIDTH  - 1 : 0 ]   gtph_max_final;
      
      assign  gtph_max01  [0] = gtph[0][0]    > gtph[1][0]    ? gtph[0][0]    : gtph[1][0]    ;
      assign  gtph_max23  [0] = gtph[2][0]    > gtph[3][0]    ? gtph[2][0]    : gtph[3][0]    ;
      assign  gtph_max45  [0] = gtph[4][0]    > gtph[5][0]    ? gtph[4][0]    : gtph[5][0]    ;
      assign  gtph_max67  [0] = gtph[6][0]    > gtph[7][0]    ? gtph[6][0]    : gtph[7][0]    ;
      assign  gtph_max03  [0] = gtph_max01[0] > gtph_max23[0] ? gtph_max01[0] : gtph_max23[0] ;
      assign  gtph_max47  [0] = gtph_max45[0] > gtph_max67[0] ? gtph_max45[0] : gtph_max67[0] ;
      assign  gtph_max    [0] = gtph_max03[0] > gtph_max47[0] ? gtph_max03[0] : gtph_max47[0] ;
      
      assign  gtph_max01  [1] = gtph[0][1]    > gtph[1][1]    ? gtph[0][1]    : gtph[1][1]    ;
      assign  gtph_max23  [1] = gtph[2][1]    > gtph[3][1]    ? gtph[2][1]    : gtph[3][1]    ;
      assign  gtph_max45  [1] = gtph[4][1]    > gtph[5][1]    ? gtph[4][1]    : gtph[5][1]    ;
      assign  gtph_max67  [1] = gtph[6][1]    > gtph[7][1]    ? gtph[6][1]    : gtph[7][1]    ;
      assign  gtph_max03  [1] = gtph_max01[1] > gtph_max23[1] ? gtph_max01[1] : gtph_max23[1] ;
      assign  gtph_max47  [1] = gtph_max45[1] > gtph_max67[1] ? gtph_max45[1] : gtph_max67[1] ;
      assign  gtph_max    [1] = gtph_max03[1] > gtph_max47[1] ? gtph_max03[1] : gtph_max47[1] ;
      
      assign  gtph_max_final  = gtph_max[0]   > gtph_max[1]   ? gtph_max[0]   : gtph_max[1]   ;
      
      assign  hold[0][0]      = gtph_max_final - gtph[0][0];
      assign  hold[0][1]      = gtph_max_final - gtph[0][1];
      assign  hold[1][0]      = gtph_max_final - gtph[1][0];
      assign  hold[1][1]      = gtph_max_final - gtph[1][1];
      assign  hold[2][0]      = gtph_max_final - gtph[2][0];
      assign  hold[2][1]      = gtph_max_final - gtph[2][1];
      assign  hold[3][0]      = gtph_max_final - gtph[3][0];
      assign  hold[3][1]      = gtph_max_final - gtph[3][1];
      assign  hold[4][0]      = gtph_max_final - gtph[4][0];
      assign  hold[4][1]      = gtph_max_final - gtph[4][1];
      assign  hold[5][0]      = gtph_max_final - gtph[5][0];
      assign  hold[5][1]      = gtph_max_final - gtph[5][1];
      assign  hold[6][0]      = gtph_max_final - gtph[6][0];
      assign  hold[6][1]      = gtph_max_final - gtph[6][1];
      assign  hold[7][0]      = gtph_max_final - gtph[7][0];
      assign  hold[7][1]      = gtph_max_final - gtph[7][1];
    end
    else begin // 9 data slices
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max01    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max23    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max45    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max67    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max03    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max47    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max07    ;
      wire    [ CHAN_RANK_NUM  - 1 : 0 ] [ GTPH_WIDTH  - 1 : 0 ]   gtph_max      ;
      wire                              [ GTPH_WIDTH  - 1 : 0 ]   gtph_max_final;
      
      assign  gtph_max01  [0] = gtph[0][0]    > gtph[1][0]    ? gtph[0][0]    : gtph[1][0]    ;
      assign  gtph_max23  [0] = gtph[2][0]    > gtph[3][0]    ? gtph[2][0]    : gtph[3][0]    ;
      assign  gtph_max45  [0] = gtph[4][0]    > gtph[5][0]    ? gtph[4][0]    : gtph[5][0]    ;
      assign  gtph_max67  [0] = gtph[6][0]    > gtph[7][0]    ? gtph[6][0]    : gtph[7][0]    ;
      assign  gtph_max03  [0] = gtph_max01[0] > gtph_max23[0] ? gtph_max01[0] : gtph_max23[0] ;
      assign  gtph_max47  [0] = gtph_max45[0] > gtph_max67[0] ? gtph_max45[0] : gtph_max67[0] ;
      assign  gtph_max07  [0] = gtph_max03[0] > gtph_max47[0] ? gtph_max03[0] : gtph_max47[0] ;
      assign  gtph_max    [0] = gtph_max07[0] > gtph[8][0]    ? gtph_max07[0] : gtph[8][0]    ;
      
      assign  gtph_max01  [1] = gtph[0][1]    > gtph[1][1]    ? gtph[0][1]    : gtph[1][1]    ;
      assign  gtph_max23  [1] = gtph[2][1]    > gtph[3][1]    ? gtph[2][1]    : gtph[3][1]    ;
      assign  gtph_max45  [1] = gtph[4][1]    > gtph[5][1]    ? gtph[4][1]    : gtph[5][1]    ;
      assign  gtph_max67  [1] = gtph[6][1]    > gtph[7][1]    ? gtph[6][1]    : gtph[7][1]    ;
      assign  gtph_max03  [1] = gtph_max01[1] > gtph_max23[1] ? gtph_max01[1] : gtph_max23[1] ;
      assign  gtph_max47  [1] = gtph_max45[1] > gtph_max67[1] ? gtph_max45[1] : gtph_max67[1] ;
      assign  gtph_max07  [1] = gtph_max03[1] > gtph_max47[1] ? gtph_max03[1] : gtph_max47[1] ;
      assign  gtph_max    [1] = gtph_max07[1] > gtph[8][1]    ? gtph_max07[1] : gtph[8][1]    ;
      
      assign  gtph_max_final  = gtph_max[0]   > gtph_max[1]   ? gtph_max[0]   : gtph_max[1]   ;
      
      assign  hold[0][0]      = gtph_max_final - gtph[0][0];
      assign  hold[0][1]      = gtph_max_final - gtph[0][1];
      assign  hold[1][0]      = gtph_max_final - gtph[1][0];
      assign  hold[1][1]      = gtph_max_final - gtph[1][1];
      assign  hold[2][0]      = gtph_max_final - gtph[2][0];
      assign  hold[2][1]      = gtph_max_final - gtph[2][1];
      assign  hold[3][0]      = gtph_max_final - gtph[3][0];
      assign  hold[3][1]      = gtph_max_final - gtph[3][1];
      assign  hold[4][0]      = gtph_max_final - gtph[4][0];
      assign  hold[4][1]      = gtph_max_final - gtph[4][1];
      assign  hold[5][0]      = gtph_max_final - gtph[5][0];
      assign  hold[5][1]      = gtph_max_final - gtph[5][1];
      assign  hold[6][0]      = gtph_max_final - gtph[6][0];
      assign  hold[6][1]      = gtph_max_final - gtph[6][1];
      assign  hold[7][0]      = gtph_max_final - gtph[7][0];
      assign  hold[7][1]      = gtph_max_final - gtph[7][1];
      assign  hold[8][0]      = gtph_max_final - gtph[8][0];
      assign  hold[8][1]      = gtph_max_final - gtph[8][1];
    end
  endgenerate

endmodule
