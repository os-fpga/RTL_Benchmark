
`include "global.inc"

module n22_exu_regfile(
  input  [`N22_RFIDX_WIDTH-1:0] read_src1_idx,
  input  [`N22_RFIDX_WIDTH-1:0] read_src2_idx,
  output [`N22_XLEN-1:0] read_src1_dat,
  output [`N22_XLEN-1:0] read_src2_dat,

  `ifdef N22_REGFILE_2WP
  input  wbck_dest_wen1,
  input  [`N22_RFIDX_WIDTH-1:0] wbck_dest_idx1,
  input  [`N22_XLEN-1:0] wbck_dest_dat1,

  input  wbck_dest_wen2,
  input  [`N22_RFIDX_WIDTH-1:0] wbck_dest_idx2,
  input  [`N22_XLEN-1:0] wbck_dest_dat2,
  `endif

  `ifndef N22_REGFILE_2WP
  input  wbck_dest_wen,
  input  [`N22_RFIDX_WIDTH-1:0] wbck_dest_idx,
  input  [`N22_XLEN-1:0] wbck_dest_dat,
  `endif

  output [`N22_XLEN-1:0] x1_r,
`ifdef N22_HAS_STACKSAFE
  output [`N22_XLEN-1:0] sp_r,
`endif

  input  clkgate_bypass,
  input  clk,
  input  rst_n
  );

  wire [`N22_XLEN-1:0] rf_r [0:`N22_RFREG_NUM-1];
  wire [`N22_RFREG_NUM-1:0] rf_wen;
  wire [`N22_XLEN-1:0] rf_wdat [0:`N22_RFREG_NUM-1];

           `ifdef N22_REGFILE_2WP
  wire [`N22_RFREG_NUM-1:0] rf_wen1;
  wire [`N22_RFREG_NUM-1:0] rf_wen2;
           `endif

  `ifdef N22_REGFILE_LATCH_BASED
  wire [`N22_XLEN-1:0] wbck_dest_dat_r;
  n22_gnrl_dffl #(`N22_XLEN) wbck_dat_dffl (wbck_dest_wen, wbck_dest_dat, wbck_dest_dat_r, clk);
  wire [`N22_RFREG_NUM-1:0] clk_rf_ltch;
  `endif


  genvar i;
  generate

      for (i=0; i<`N22_RFREG_NUM; i=i+1) begin:gen_regfile

        if(i==0) begin: gen_rf0
            assign rf_wen[i] = 1'b0;
            assign rf_r[i] = `N22_XLEN'b0;
          `ifdef N22_REGFILE_LATCH_BASED
            assign clk_rf_ltch[i] = 1'b0;
          `endif
            assign rf_wdat[i] = `N22_XLEN'b0;
           `ifdef N22_REGFILE_2WP
            assign rf_wen1[i] = 1'b0;
            assign rf_wen2[i] = 1'b0;
           `endif
        end
        else begin: gen_rfno0
           `ifndef N22_REGFILE_2WP
            assign rf_wen[i] = wbck_dest_wen & (wbck_dest_idx == i[`N22_RFIDX_WIDTH-1:0]) ;
            assign rf_wdat[i] = wbck_dest_dat;
           `endif

           `ifdef N22_REGFILE_2WP
            assign rf_wen1[i] = wbck_dest_wen1 & (wbck_dest_idx1 == i[`N22_RFIDX_WIDTH-1:0]) ;
            assign rf_wen2[i] = wbck_dest_wen2 & (wbck_dest_idx2 == i[`N22_RFIDX_WIDTH-1:0]) ;

            assign rf_wen[i] = rf_wen1[i] | rf_wen2[i];
            assign rf_wdat[i] = ({`N22_XLEN{rf_wen1[i]}} & wbck_dest_dat1) | ({`N22_XLEN{rf_wen2[i]}} & wbck_dest_dat2);
           `endif

          `ifdef N22_REGFILE_LATCH_BASED
            n22_clkgate u_n22_clkgate(
              .clk_in  (clk  ),
              .clkgate_bypass(clkgate_bypass),
              .clock_en(rf_wen[i]),
              .clk_out (clk_rf_ltch[i])
            );
            n22_gnrl_ltch #(`N22_XLEN) rf_ltch (clk_rf_ltch[i], wbck_dest_dat_r, rf_r[i]);
          `else
             `ifdef N22_REGFILE_RST
            n22_gnrl_dfflr #(`N22_XLEN) rf_dfflr (rf_wen[i], rf_wdat[i], rf_r[i], clk, rst_n);
             `else
            n22_gnrl_dffl  #(`N22_XLEN) rf_dffl  (rf_wen[i], rf_wdat[i], rf_r[i], clk);
             `endif
          `endif
        end

      end
  endgenerate

  `ifdef N22_RFREG_NUM_IS_16
  assign read_src1_dat = rf_r[read_src1_idx[`N22_RFIDX_WIDTH-2:0]];
  assign read_src2_dat = rf_r[read_src2_idx[`N22_RFIDX_WIDTH-2:0]];
  `endif
  `ifdef N22_RFREG_NUM_IS_32
  assign read_src1_dat = rf_r[read_src1_idx];
  assign read_src2_dat = rf_r[read_src2_idx];
  `endif


  assign x1_r = rf_r[1];
`ifdef N22_HAS_STACKSAFE
  assign sp_r = rf_r[2];
`endif


  `ifndef SYNTHESIS
  wire [`N22_XLEN-1:0] x0 = rf_r[0];
  wire [`N22_XLEN-1:0] x1 = rf_r[1];
  wire [`N22_XLEN-1:0] x2 = rf_r[2];
  wire [`N22_XLEN-1:0] x3 = rf_r[3];
  wire [`N22_XLEN-1:0] x4 = rf_r[4];
  wire [`N22_XLEN-1:0] x5 = rf_r[5];
  wire [`N22_XLEN-1:0] x6 = rf_r[6];
  wire [`N22_XLEN-1:0] x7 = rf_r[7];
  wire [`N22_XLEN-1:0] x8 = rf_r[8];
  wire [`N22_XLEN-1:0] x9 = rf_r[9];
  wire [`N22_XLEN-1:0] x10 = rf_r[10];
  wire [`N22_XLEN-1:0] x11 = rf_r[11];
  wire [`N22_XLEN-1:0] x12 = rf_r[12];
  wire [`N22_XLEN-1:0] x13 = rf_r[13];
  wire [`N22_XLEN-1:0] x14 = rf_r[14];
  wire [`N22_XLEN-1:0] x15 = rf_r[15];
  `ifdef N22_RFREG_NUM_IS_32
  wire [`N22_XLEN-1:0] x16 = rf_r[16];
  wire [`N22_XLEN-1:0] x17 = rf_r[17];
  wire [`N22_XLEN-1:0] x18 = rf_r[18];
  wire [`N22_XLEN-1:0] x19 = rf_r[19];
  wire [`N22_XLEN-1:0] x20 = rf_r[20];
  wire [`N22_XLEN-1:0] x21 = rf_r[21];
  wire [`N22_XLEN-1:0] x22 = rf_r[22];
  wire [`N22_XLEN-1:0] x23 = rf_r[23];
  wire [`N22_XLEN-1:0] x24 = rf_r[24];
  wire [`N22_XLEN-1:0] x25 = rf_r[25];
  wire [`N22_XLEN-1:0] x26 = rf_r[26];
  wire [`N22_XLEN-1:0] x27 = rf_r[27];
  wire [`N22_XLEN-1:0] x28 = rf_r[28];
  wire [`N22_XLEN-1:0] x29 = rf_r[29];
  wire [`N22_XLEN-1:0] x30 = rf_r[30];
  wire [`N22_XLEN-1:0] x31 = rf_r[31];
  `endif

  wire [`N22_XLEN-1:0] abi_zero = rf_r[0];
  wire [`N22_XLEN-1:0] abi_ra = rf_r[1];
  wire [`N22_XLEN-1:0] abi_sp = rf_r[2];
  wire [`N22_XLEN-1:0] abi_gp = rf_r[3];
  wire [`N22_XLEN-1:0] abi_tp = rf_r[4];
  wire [`N22_XLEN-1:0] abi_t0 = rf_r[5];
  wire [`N22_XLEN-1:0] abi_t1 = rf_r[6];
  wire [`N22_XLEN-1:0] abi_t2 = rf_r[7];
  wire [`N22_XLEN-1:0] abi_s0 = rf_r[8];
  wire [`N22_XLEN-1:0] abi_s1 = rf_r[9];
  wire [`N22_XLEN-1:0] abi_a0 = rf_r[10];
  wire [`N22_XLEN-1:0] abi_a1 = rf_r[11];
  wire [`N22_XLEN-1:0] abi_a2 = rf_r[12];
  wire [`N22_XLEN-1:0] abi_a3 = rf_r[13];
  wire [`N22_XLEN-1:0] abi_a4 = rf_r[14];
  wire [`N22_XLEN-1:0] abi_a5 = rf_r[15];
  `ifdef N22_RFREG_NUM_IS_32
  wire [`N22_XLEN-1:0] abi_a6 = rf_r[16];
  wire [`N22_XLEN-1:0] abi_a7 = rf_r[17];
  wire [`N22_XLEN-1:0] abi_s2 = rf_r[18];
  wire [`N22_XLEN-1:0] abi_s3 = rf_r[19];
  wire [`N22_XLEN-1:0] abi_s4 = rf_r[20];
  wire [`N22_XLEN-1:0] abi_s5 = rf_r[21];
  wire [`N22_XLEN-1:0] abi_s6 = rf_r[22];
  wire [`N22_XLEN-1:0] abi_s7 = rf_r[23];
  wire [`N22_XLEN-1:0] abi_s8 = rf_r[24];
  wire [`N22_XLEN-1:0] abi_s9 = rf_r[25];
  wire [`N22_XLEN-1:0] abi_s10 = rf_r[26];
  wire [`N22_XLEN-1:0] abi_s11 = rf_r[27];
  wire [`N22_XLEN-1:0] abi_t3 = rf_r[28];
  wire [`N22_XLEN-1:0] abi_t4 = rf_r[29];
  wire [`N22_XLEN-1:0] abi_t5 = rf_r[30];
  wire [`N22_XLEN-1:0] abi_t6 = rf_r[31];
  `endif
  `endif

endmodule

