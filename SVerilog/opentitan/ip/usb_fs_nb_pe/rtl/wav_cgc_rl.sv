 module wav_inv #(
   parameter DWIDTH = 1
) (
   input  logic [DWIDTH-1:0] i_a,
   output logic [DWIDTH-1:0] o_z
);

`ifdef WAV_SLIB_TSMC12FFC
   CKND4BWP16P90CPD u_inv [DWIDTH-1:0] (
      .I  (i_a),
      .ZN (o_z)
   );
   //cadence script_begin
   //set_db -quiet [get_db insts */u_inv[*]] .preserve true
   //cadence script_end
`elsif WAV_SLIB_GF12LPP
   INV_X4N_A7P5PP84TR_C16 u_inv [DWIDTH-1:0] (
      .A  (i_a),
      .Y (o_z)
   );
   //cadence script_begin
   //set_db -quiet [get_db insts */u_inv[*]] .preserve true
   //cadence script_end
`else
   assign o_z = ~i_a;
`endif

endmodule

module wav_latch #(
   parameter DWIDTH = 1
) (
   input  logic              i_clk,
   input  logic [DWIDTH-1:0] i_d,
   output logic [DWIDTH-1:0] o_q
);

`ifdef WAV_SLIB_TSMC12FFC
   LHQD0BWP16P90CPD u_latch [DWIDTH-1:0] (
      .D (i_d),
      .E (i_clk),
      .Q (o_q)
   );

   //cadence script_begin
   //set_db -quiet [get_db insts */u_latch[*]] .preserve true
   //cadence script_end
`elsif WAV_SLIB_GF12LPP
   LATQ_X3N_A7P5PP84TR_C16 u_latch [DWIDTH-1:0] (
      .D   (i_d),
      .G   (i_clk),
      .Q   (o_q)
   );

   //cadence script_begin
   //set_db -quiet [get_db insts */u_latch[*]] .preserve true
   //cadence script_end
`else
   always_latch
      if (i_clk)
         o_q <= i_d;
`endif

endmodule

module wav_and #(
   parameter DWIDTH = 1
) (
   input  logic [DWIDTH-1:0] i_a,
   input  logic [DWIDTH-1:0] i_b,
   output logic [DWIDTH-1:0] o_z
);

`ifdef WAV_SLIB_TSMC12FFC
   CKAN2D1BWP16P90CPD u_and [DWIDTH-1:0] (
       .A1 (i_a),
       .A2 (i_b),
       .Z  (o_z)
   );
   //cadence script_begin
   //set_db -quiet [get_db insts */u_and[*]] .preserve true
   //cadence script_end
`elsif WAV_SLIB_GF12LPP
   AND2_X2N_A7P5PP84TR_C16 u_and [DWIDTH-1:0] (
       .A (i_a),
       .B (i_b),
       .Y (o_z)
    ) ;

   //cadence script_begin
   //set_db -quiet [get_db insts */u_and[*]] .preserve true
   //cadence script_end
`else
   assign o_z = i_a & i_b;
`endif

endmodule



module wav_or #(
   parameter DWIDTH = 1
) (
   input  logic [DWIDTH-1:0] i_a,
   input  logic [DWIDTH-1:0] i_b,
   output logic [DWIDTH-1:0] o_z
);

`ifdef WAV_SLIB_TSMC12FFC
   CKOR2D1BWP16P90CPD u_or [DWIDTH-1:0] (
      .A1 (i_a),
      .A2 (i_b),
      .Z  (o_z)
   );
   //cadence script_begin
   //set_db -quiet [get_db insts */u_or[*]] .preserve true
   //cadence script_end
`elsif WAV_SLIB_GF12LPP
   OR2_X2N_A7P5PP84TR_C16 u_or [DWIDTH-1:0] (
       .A (i_a),
       .B (i_b),
       .Y (o_z)
    ) ;

   //cadence script_begin
   //set_db -quiet [get_db insts */u_or[*]] .preserve true
   //cadence script_end
`else
   assign o_z = i_a | i_b;
`endif

endmodule
 
 module wav_cgc_rl (
   input  logic i_cgc_en,
   input  logic i_clk_en,
   input  logic i_clk,
   output logic o_clk
);

`ifdef WAV_SLIB_TSMC12FFC
   CKLNQD10BWP16P90CPD u_cgc (
      .CP (i_clk),
      .E  (i_clk_en),
      .TE (i_cgc_en),
      .Q  (o_clk)
   );
   //cadence script_begin
   //set_db -quiet [get_db insts */u_cgc] .preserve true
   //cadence script_end
`elsif WAV_SLIB_GF12LPP
   PREICG_X4N_A7P5PP84TR_C16 u_cgc (
       .CK  (i_clk),
       .E   (i_clk_en),
       .SE  (i_cgc_en),
       .ECK (o_clk)
    ) ;

   //cadence script_begin
   //set_db -quiet [get_db insts */u_cgc] .preserve true
   //cadence script_end
`else
   logic clk_en, inv_clk, clk_test_en;

   wav_or    u_or    (.i_a(i_clk_en), .i_b(i_cgc_en), .o_z(clk_test_en));
   wav_inv   u_inv   (.i_a(i_clk), .o_z(inv_clk));
   wav_latch u_latch (.i_clk(inv_clk), .i_d(clk_test_en), .o_q(clk_en));
   wav_and   u_and   (.i_a(i_clk), .i_b(clk_en), .o_z(o_clk));
`endif

endmodule
