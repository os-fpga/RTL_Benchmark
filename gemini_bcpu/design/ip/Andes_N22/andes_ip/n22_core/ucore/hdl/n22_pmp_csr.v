
`include "global.inc"

module n22_pmp_csr(
  input csr_ena,
  input csr_wr_en,
  input csr_rd_en,
  input [12-1:0] csr_idx,
  input wbck_csr_wen,
  input  [`N22_XLEN-1:0] wbck_csr_dat,
  output [`N22_XLEN-1:0] read_csr_dat,
  output csr_addr_legal,

`ifdef N22_HAS_PMP
  output [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  output [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  output [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,
`endif

  input  clk,
  input  rst_n

  );

  localparam	PMP_CSR_ENTRY_NUM	= 16 ;

  wire [`N22_XLEN-1:0] pmpaddr  [0:PMP_CSR_ENTRY_NUM-1];
  wire [`N22_XLEN-1:0] pmpaddr_nxt  [0:PMP_CSR_ENTRY_NUM-1];
  wire [PMP_CSR_ENTRY_NUM-1:0] pmpaddr_ena;

  wire                  pmpcfg_r [0:PMP_CSR_ENTRY_NUM-1];
  wire                  pmpcfg_w [0:PMP_CSR_ENTRY_NUM-1];
  wire                  pmpcfg_x [0:PMP_CSR_ENTRY_NUM-1];
  wire [2-1:0]          pmpcfg_a [0:PMP_CSR_ENTRY_NUM-1];
  wire                  pmpcfg_l [0:PMP_CSR_ENTRY_NUM-1];

  wire                  pmpcfg_a_tor [0:PMP_CSR_ENTRY_NUM-1];

  wire [`N22_XLEN-1:0] csr_pmpcfg  [0:PMP_CSR_ENTRY_NUM/4-1];

  wire [8-1:0] pmpcfg_q   [0:PMP_CSR_ENTRY_NUM-1];
  wire [8-1:0] pmpcfg     [0:PMP_CSR_ENTRY_NUM-1];
  wire [8-1:0] pmpcfg_nxt [0:PMP_CSR_ENTRY_NUM-1];
  wire         pmpcfg_ena [0:PMP_CSR_ENTRY_NUM-1];

  genvar i;

  `ifdef N22_HAS_PMP
  generate
    for (i=0; i<`N22_PMP_ENTRY_NUM; i=i+1) begin: gen_port
      assign pmpaddr_r    [(i*`N22_XLEN+`N22_XLEN-1) : i*`N22_XLEN] = pmpaddr [i];
      assign pmpcfg_bit_r [(i*1+1-1) : i*1]                   = pmpcfg_r[i];
      assign pmpcfg_bit_w [(i*1+1-1) : i*1]                   = pmpcfg_w[i];
      assign pmpcfg_bit_x [(i*1+1-1) : i*1]                   = pmpcfg_x[i];
      assign pmpcfg_bit_a [(i*2+2-1) : i*2]                   = pmpcfg_a[i];
      assign pmpcfg_bit_l [(i*1+1-1) : i*1]                   = pmpcfg_l[i];
    end
  endgenerate
  `endif





  wire[PMP_CSR_ENTRY_NUM/4-1:0] sel_csr_pmpcfg;
  wire[PMP_CSR_ENTRY_NUM/4-1:0] rd_csr_pmpcfg;
  wire[PMP_CSR_ENTRY_NUM/4-1:0] wr_csr_pmpcfg;
  wire[PMP_CSR_ENTRY_NUM/4-1:0] csr_pmpcfg_wr_ena;

  wire[PMP_CSR_ENTRY_NUM-1:0] sel_pmpaddr;
  wire[PMP_CSR_ENTRY_NUM-1:0] rd_pmpaddr;
  wire[PMP_CSR_ENTRY_NUM-1:0] wr_pmpaddr;
  wire[PMP_CSR_ENTRY_NUM-1:0] pmpaddr_wr_ena;


  generate
    for (i=0; i<PMP_CSR_ENTRY_NUM/4; i=i+1) begin: gen_sel_pmpcfg
      assign sel_csr_pmpcfg[i] = (csr_idx == (12'h3A0 + i[11:0]));
      if (i<`N22_PMP_ENTRY_NUM/4) begin: gen_sel_pmp_cfg_exist
        assign rd_csr_pmpcfg[i]  = csr_rd_en & sel_csr_pmpcfg[i];
        assign wr_csr_pmpcfg[i]  = csr_wr_en & sel_csr_pmpcfg[i];
        assign csr_pmpcfg_wr_ena[i]  = (wr_csr_pmpcfg[i]  & wbck_csr_wen);
        assign csr_pmpcfg[i] = {pmpcfg[i*4+3], pmpcfg[i*4+2], pmpcfg[i*4+1], pmpcfg[i*4]};
      end
      else begin: gen_sel_pmp_cfg_nonexist
        assign rd_csr_pmpcfg[i]  = 1'b0;
        assign wr_csr_pmpcfg[i]  = 1'b0;
        assign csr_pmpcfg_wr_ena[i]  = 1'b0;
        assign csr_pmpcfg[i] = {`N22_XLEN{1'b0}};
      end
    end

    for (i=0; i<PMP_CSR_ENTRY_NUM; i=i+1) begin: gen_pmp_entry
      assign sel_pmpaddr[i] = (csr_idx == (12'h3B0 + i[11:0]));
      if (i<`N22_PMP_ENTRY_NUM) begin: gen_pmp_entry_exist
        assign rd_pmpaddr[i]  = csr_rd_en & sel_pmpaddr[i];
        assign wr_pmpaddr[i]  = csr_wr_en & sel_pmpaddr[i];
        assign pmpaddr_wr_ena[i]  = (wr_pmpaddr[i] & wbck_csr_wen);
      end
      else begin: gen_pmp_entry_nonexist
        assign rd_pmpaddr[i]  = 1'b0;
        assign wr_pmpaddr[i]  = 1'b0;
        assign pmpaddr_wr_ena[i]  = 1'b0;
      end
      if(i < (PMP_CSR_ENTRY_NUM-1)) begin: gen_i_is_not_max
        assign pmpaddr_ena[i] = pmpaddr_wr_ena[i] & (~( pmpcfg_l[i] | pmpcfg_a_tor[i+1] ));
      end
      if(i == (PMP_CSR_ENTRY_NUM-1)) begin: gen_i_is_max
        assign pmpaddr_ena[i] = pmpaddr_wr_ena[i] & (~( pmpcfg_l[i] | 1'b0 ));
      end

      assign pmpcfg_ena[i] = csr_pmpcfg_wr_ena[i/4] & (~pmpcfg_l[i]);

      assign pmpcfg_a_tor[i] = 1'b0;


      assign pmpcfg_nxt[i][4:0] = wbck_csr_dat[((i%4)*8+4):((i%4)*8)];
      assign pmpcfg_nxt[i][6:5] = 2'b0;
      assign pmpcfg_nxt[i][7]   = wbck_csr_dat[(i%4)*8+7];

      n22_gnrl_dfflr #(8) pmpcfg_dfflr (pmpcfg_ena[i], pmpcfg_nxt[i], pmpcfg_q[i], clk, rst_n);

      assign pmpcfg[i][2:0] = pmpcfg_q[i][2:0];
      assign pmpcfg[i][4:3] = ((~pmpcfg_q[i][4]) & pmpcfg_q[i][3]) ? 2'b00 : pmpcfg_q[i][4:3];
      assign pmpcfg[i][6:5] = 2'b0;
      assign pmpcfg[i][7]   = pmpcfg_q[i][7]  ;

      assign pmpcfg_r[i] = pmpcfg[i][0];
      assign pmpcfg_w[i] = pmpcfg[i][1];
      assign pmpcfg_x[i] = pmpcfg[i][2];
      assign pmpcfg_a[i] = pmpcfg[i][4:3];
      assign pmpcfg_l[i] = pmpcfg[i][7];

      assign pmpaddr_nxt[i] = {2'b0,wbck_csr_dat[29:0]};
      n22_gnrl_dfflr #(32) pmpaddr_dfflr (pmpaddr_ena[i], pmpaddr_nxt[i], pmpaddr[i], clk, rst_n);

    end
  endgenerate






  reg [`N22_XLEN-1:0] read_csr_dat_sel;
  reg csr_addr_legal_sel;

  integer j;

  always @ (*) begin : sel_for
      read_csr_dat_sel = `N22_XLEN'b0;
      csr_addr_legal_sel = 1'b0;
      for(j = 0; j < PMP_CSR_ENTRY_NUM/4; j = j+1) begin
        read_csr_dat_sel = read_csr_dat_sel | ({`N22_XLEN{rd_csr_pmpcfg[j]}} & csr_pmpcfg[j]);
        csr_addr_legal_sel = csr_addr_legal_sel | sel_csr_pmpcfg[j];
      end

      for(j = 0; j < PMP_CSR_ENTRY_NUM; j = j+1) begin
        read_csr_dat_sel = read_csr_dat_sel | ({`N22_XLEN{rd_pmpaddr[j]}} & pmpaddr[j]);
        csr_addr_legal_sel = csr_addr_legal_sel | sel_pmpaddr[j];
      end
  end

  assign read_csr_dat = read_csr_dat_sel;
  assign csr_addr_legal = csr_addr_legal_sel;

endmodule

