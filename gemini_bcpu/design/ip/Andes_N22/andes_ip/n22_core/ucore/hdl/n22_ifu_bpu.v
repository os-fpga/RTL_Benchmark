
`include "global.inc"

`ifdef N22_HAS_DYNAMIC_BPU
module n22_ifu_bpu (
  input csr_bpu_enable,

  input updt_bpu_ena,
  input updt_bpu_take,
  input  [`N22_BPU_IDX_W-1:0] updt_bpu_idx,

  input  [`N22_PC_SIZE-1:0] prdt_bpu_pc,
  output prdt_bpu_take,
  output [`N22_BPU_IDX_W-1:0] prdt_bpu_idx,

  input  clk,
  input  rst_n
  );



  wire [`N22_BPU_IDX_W-1:0] s0;
  wire [`N22_BPU_IDX_W-1:0] s1 = {s0[`N22_BPU_IDX_W-2:0],updt_bpu_take};
  wire s2 = updt_bpu_ena & csr_bpu_enable;
  n22_gnrl_dfflr #(`N22_BPU_IDX_W) take_his_dfflr (s2, s1, s0, clk, rst_n);

  localparam BPU_IDX_W = `N22_BPU_IDX_W;

  generate
    if(BPU_IDX_W > 5) begin: gen_entry_num_gt_32
      assign prdt_bpu_idx = {s0[1:0],prdt_bpu_pc[`N22_BPU_IDX_W-2:1]};
    end
    else begin:gen_entry_num_le_32
      assign prdt_bpu_idx = {s0[0],prdt_bpu_pc[`N22_BPU_IDX_W-1:1]};
    end
  endgenerate


  wire[`N22_BPU_ENTRY_NUM-1:0] s3;
  wire[`N22_BPU_ENTRY_NUM-1:0] updt_ena;
  wire[`N22_BPU_ENTRY_NUM-1:0] updt_take;
  wire[`N22_BPU_ENTRY_NUM-1:0] prdt_take;
  wire[`N22_BPU_ENTRY_NUM-1:0] s4;

  genvar i;

  generate
      for (i=0; i<`N22_BPU_ENTRY_NUM;i=i+1) begin: gen_dec_sel_idx
          assign s3[i] = (updt_bpu_idx == $unsigned(i[`N22_BPU_IDX_W-1:0]));
          assign updt_ena [i] = updt_bpu_ena  & s3[i];
          assign updt_take[i] = updt_bpu_take & s3[i];

          n22_ifu_prdtor u_prdtor(
              .csr_bpu_enable(csr_bpu_enable),
              .updt_ena(updt_ena[i]),
              .updt_take(updt_take[i]),
              .prdt_take(prdt_take[i]),
              .clk(clk),
              .rst_n(rst_n)
          );

          assign s4[i] = (prdt_bpu_idx == $unsigned(i[`N22_BPU_IDX_W-1:0]));
      end
  endgenerate

   reg s5;

   integer s6;

   always @* begin:gen_take_mux
       s5 = 1'b0;

       for(s6=0; s6<`N22_BPU_ENTRY_NUM;s6=s6+1) begin: gen_sel_take
         s5 = s5 | (s4[s6] & prdt_take[s6]);
       end
   end

   assign prdt_bpu_take = s5;

endmodule
`endif
