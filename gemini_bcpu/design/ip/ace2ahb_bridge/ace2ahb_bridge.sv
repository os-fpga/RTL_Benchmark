`ifndef ACE2AHB_BRIDGE_MODULE
`define ACE2AHB_BRIDGE_MODULE

module ace_bridge #( parameter ACE_DINOP_NUM  = 2,
                     parameter ACE_DOUTOP_NUM = 2,
                     parameter ACE_DAT_CNT    = 1  // maximum of $clog2(ACE_DINOP_NUM) and $clog2(ACE_DOUTOP_NUM)
                   )
(

  // ACE interfaces
  input  logic                        [24:0] ace_opcode  ,
  input  logic                               ace_istart  ,
  input  logic [ACE_DINOP_NUM - 1 : 0]       ace_divalid ,
  input  logic [ACE_DINOP_NUM - 1 : 0][31:0] ace_dinop   ,

  output logic [ACE_DOUTOP_NUM - 1 : 0]       ace_dovalid ,
  output logic [ACE_DOUTOP_NUM - 1 : 0][31:0] ace_doutop  ,

  // AHB interface
  input  logic                                hclk        ,
  input  logic                                hresetn     ,

  input  logic                         [31:0] hrdata      ,
  input  logic                                hready      ,
  input  logic                          [1:0] hresp       ,

  output logic                          [5:0] haddr       ,
  output logic                                hsel        ,
  output logic                          [1:0] htrans      ,
  output logic                                hwrite      ,
  output logic                         [31:0] hwdata

);

  `include "ace2ahb_includes.svh"

  ahb_state_t ahb_cur_st;
  ahb_state_t ahb_nxt_st;

  logic                          idle2req;
  logic                          req2resp;
  logic                          resp2idle;
  logic                          set_wdat_cnt;
  logic                          set_rdat_cnt;
  logic                          dec_dat_cnt;
  logic [ACE_DAT_CNT - 1 : 0]    dat_cnt;
  logic [ACE_DOUTOP_NUM - 1 : 0] clr_dovalid;
  logic [ACE_DOUTOP_NUM - 1 : 0] set_dovalid;



  // Bridge FSM
  always_comb idle2req  = ace_istart;
  always_comb req2resp  = hready & (dat_cnt == ACE_DINOP_NUM - 1);
  always_comb resp2idle = hready & (dat_cnt == ACE_DOUTOP_NUM - 1);

  always_comb set_wdat_cnt = (ahb_cur_st == AHB_REQ_ADDR) & hready;
  always_comb set_rdat_cnt = (ahb_cur_st == AHB_RESP_ADDR) & hready;
  always_comb dec_dat_cnt  = ( (ahb_cur_st == AHB_REQ_WDAT) & ace_divalid[(ACE_DINOP_NUM[ACE_DAT_CNT - 1 : 0] - dat_cnt)] |
                               (ahb_cur_st == AHB_RESP_RDAT)
                             ) & hready;

  always_ff @(posedge hclk, negedge hresetn)
    if (!hresetn)          dat_cnt <= '0;
    else if (set_wdat_cnt) dat_cnt <= ACE_DINOP_NUM[ACE_DAT_CNT - 1 : 0];
    else if (set_rdat_cnt) dat_cnt <= ACE_DOUTOP_NUM[ACE_DAT_CNT - 1 : 0];
    else if (dec_dat_cnt)  dat_cnt <= dat_cnt - 'b1;

  always_ff @(posedge hclk, negedge hresetn)
    if (!hresetn) ahb_cur_st <= AHB_IDLE;
    else          ahb_cur_st <= ahb_nxt_st;

  always_comb
    case (ahb_cur_st)
      AHB_IDLE      : ahb_nxt_st = idle2req?  AHB_REQ_ADDR  : AHB_IDLE;
      AHB_REQ_ADDR  : ahb_nxt_st = hready?    (((ACE_DINOP_NUM == 1) & ace_divalid[0])? AHB_RESP_ADDR : AHB_REQ_WDAT)  : AHB_REQ_ADDR;
      AHB_REQ_WDAT  : ahb_nxt_st = req2resp?  AHB_RESP_ADDR : AHB_REQ_WDAT;
      AHB_RESP_ADDR : ahb_nxt_st = hready?    AHB_RESP_RDAT : AHB_RESP_ADDR;
      AHB_RESP_RDAT : ahb_nxt_st = resp2idle? AHB_IDLE      : AHB_RESP_RDAT;  
      default       : ahb_nxt_st = AHB_IDLE;
    endcase

  // AHB outputs
  always_ff @(posedge hclk, negedge hresetn)
    if (!hresetn) haddr <= 6'h0;
    else if (idle2req) 
      case (ace_opcode)
        25'h0   : haddr <= 6'h1;
        25'h1   : haddr <= 6'h2;
        25'h2   : haddr <= 6'h3;
        25'h4   : haddr <= 6'h4;
        25'h8   : haddr <= 6'h5;
        25'h10  : haddr <= 6'h6;
        default : haddr <= 6'h0;
      endcase

  always_comb hsel = 1'b1;

  always_ff @(posedge hclk, negedge hresetn)
    if (!hresetn)     htrans <= AHB_TRANS_IDLE;
    else case (ahb_cur_st)
      AHB_IDLE      : htrans <= idle2req? AHB_TRANS_NONSEQ : AHB_TRANS_IDLE;
      AHB_REQ_ADDR  : htrans <= (hready & ace_divalid[0])? ((ACE_DINOP_NUM == 1)? AHB_TRANS_IDLE : AHB_TRANS_SEQ) : AHB_TRANS_NONSEQ;
      AHB_REQ_WDAT  : htrans <= req2resp? AHB_TRANS_NONSEQ : AHB_TRANS_SEQ;
      AHB_RESP_ADDR : htrans <= hready? AHB_TRANS_SEQ;
      AHB_RESP_RDAT : htrans <= resp2idle? AHB_TRANS_IDLE : AHB_TRANS_SEQ;
      default       : htrans <= AHB_TRANS_IDLE;
    endcase

  always_ff @(posedge hclk, negedge hresetn)
    if (!hresetn)      hwrite <= 1'b0;
    else if (req2resp) hwrite <= 1'b0;
    else if (idle2req) hwrite <= 1'b1;

  always_comb ld_wdat = ((ahb_cur_st == AHB_REQ_ADDR) | (ahb_cur_st == AHB_REQ_WDAT)) & hready;

  always_ff @(posedge hclk, negedge hresetn)
    if (!hresetn)     hwdata <= 32'h0;
    else if (ld_wdat) hwdata <= ace_dinop[dat_cnt];

  // ACE outputs
  genvar do_num;
  generate;
    for (do_num = 0; do_num < ACE_DOUTOP_NUM; do_num++) begin: ace_do_
      
      always_comb clr_dovalid[do_num] = ace_dovalid[do_num];
      always_comb set_dovalid[do_num] = (ahb_cur_st == AHB_RESP_RDAT) & hready & (hresp == AHB_STS_OK) & (dat_cnt == do_num);

      always_ff @(posedge hclk, negedge hresetn)
        if (!hresetn)                 ace_dovalid[do_num] <= 1'b0;
        else if (clr_dovalid[do_num]) ace_dovalid[do_num] <= 1'b0;
        else if (set_dovalid[do_num]) ace_dovalid[do_num] <= 1'b1;
    
      always_ff @(posedge hclk, negedge hresetn)
        if (!hresetn)         ace_doutop[do_num] <= 32'h0;
        else if (set_dovalid) ace_doutop[do_num] <= hrdata;

    end // ace_do_
  endgenerate


endmodule

`endif  // ACE2AHB_BRIDGE_MODULE