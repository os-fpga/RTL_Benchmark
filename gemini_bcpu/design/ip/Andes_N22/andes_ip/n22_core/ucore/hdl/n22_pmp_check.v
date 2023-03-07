
`include "global.inc"
`ifdef N22_HAS_PMP
module n22_pmp_check(

   `ifdef N22_HAS_DEBUG
  input dbg_mprven,
    `endif

  input [`N22_PMP_ENTRY_NUM*`N22_XLEN-1:0] pmpaddr_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_r,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_w,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_x,
  input [`N22_PMP_ENTRY_NUM*2-1:0] pmpcfg_bit_a,
  input [`N22_PMP_ENTRY_NUM*1-1:0] pmpcfg_bit_l,


  input  mstatus_mprv,
  input  i_mpp_m_mode,
  input  i_mmode,
  input  i_dmode,
  input  i_r,
  input  i_w,
  input  i_x,
  input  [`N22_ADDR_SIZE-1:0] i_addr ,
  output o_err
  );

   `ifndef N22_HAS_DEBUG
  wire dbg_mprven = 1'b0;
   `endif

  genvar i;

  wire [`N22_XLEN-1:0] pmpaddr       [`N22_PMP_ENTRY_NUM-1:0];
  wire [`N22_XLEN-1:0] pmpaddr_mask  [`N22_PMP_ENTRY_NUM-1:0];
  wire                  s0      [`N22_PMP_ENTRY_NUM-1:0];
  wire                  s1      [`N22_PMP_ENTRY_NUM-1:0];
  wire                  s2      [`N22_PMP_ENTRY_NUM-1:0];
  wire [2-1:0]          s3      [`N22_PMP_ENTRY_NUM-1:0];
  wire                  s4      [`N22_PMP_ENTRY_NUM-1:0];

  wire  [`N22_PMP_ENTRY_NUM-1:0] s5  ;
  wire  [`N22_PMP_ENTRY_NUM-1:0] s6  ;
  wire  [`N22_PMP_ENTRY_NUM-1:0] s7;

  wire  [`N22_PMP_ENTRY_NUM-1:0] s8 ;
  wire  [`N22_PMP_ENTRY_NUM-1:0] s9    ;
  wire  [`N22_PMP_ENTRY_NUM-1:0] s10;

  generate
    for (i=0; i<`N22_PMP_ENTRY_NUM; i=i+1) begin: gen_port
      assign pmpaddr [i] = pmpaddr_r   [(i*`N22_XLEN+`N22_XLEN-1) : i*`N22_XLEN];
      assign s0[i] = pmpcfg_bit_r[(i*1+1-1) : i*1];
      assign s1[i] = pmpcfg_bit_w[(i*1+1-1) : i*1];
      assign s2[i] = pmpcfg_bit_x[(i*1+1-1) : i*1];
      assign s3[i] = pmpcfg_bit_a[(i*2+2-1) : i*2];
      assign s4[i] = pmpcfg_bit_l[(i*1+1-1) : i*1];
    end
  endgenerate

  wire s11 = (i_dmode ? dbg_mprven : 1'b1) & mstatus_mprv;
  wire s12 = ( (i_r | i_w) & s11) ? i_mpp_m_mode : (i_mmode | i_dmode);
  wire s13 = (~s12);

  generate
    for (i=0; i<`N22_PMP_ENTRY_NUM; i=i+1) begin: gen_pmpcfg_a
      assign s5[i] = (s3[i] == 2'b00);
      assign s6[i] = (s3[i] == 2'b10);
      assign s7[i] = (s3[i] == 2'b11);


      n22_pmp_0dect u_pmpaddr_0dect(.na4(s6[i]), .pmpaddr(pmpaddr[i][30-1:0]), .pmpaddr_mask(pmpaddr_mask[i])  );

      assign s8[i] = ( (i_addr & pmpaddr_mask[i]) == ({pmpaddr[i][30-1:0],2'b0} & pmpaddr_mask[i]) );

      assign s9[i] = ((s7[i] | s6[i]) & s8[i]);

      if(i == 0) begin: gen_i_is_0
          assign s10[i] = s9[i];
      end
      else begin: gen_i_is_not_0
          assign s10[i] = s9[i] & (~(|s9[i-1:0]));
      end
    end

  endgenerate

  wire s14 = ~(|s9);

  reg s15;
  reg s16;
  reg s17;
  reg s18;


  integer s19;

  always @ (*) begin : match_sel_for
      s17   = 1'b0;
      s16   = 1'b0;
      s15   = 1'b0;
      s18   = 1'b0;
      for(s19 = 0; s19 < `N22_PMP_ENTRY_NUM; s19 = s19+1) begin
        s17   = s17   | (s10[s19] & s2[s19]);
        s16   = s16   | (s10[s19] & s1[s19]);
        s15   = s15   | (s10[s19] & s0[s19]);
        s18   = s18   | (s10[s19] & s4[s19]);
      end
  end



  wire s20 = (i_r ? s15 : 1'b1) &
                         (i_w ? s16 : 1'b1) &
                         (i_x ? s17 : 1'b1) ;

  wire s21 = s20;
  wire s22 = s14
                         | (~s18)
                         | s20;

  wire s23 = (s13 ? s21 : s22) ;

  assign o_err = ~s23;

endmodule

`endif
