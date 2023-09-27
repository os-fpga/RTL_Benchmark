module mult_16bit_outreg (clock0, reset, out, a, b);
output wire [31:0] out;
input  [15:0] a;
input  [15:0] b;
input  clock0, reset;

reg   [31:0] z_int;

assign out = z_int[31:0];

always @(posedge clock0) begin
    if (reset) begin
      z_int <= 0;
    end else begin
      z_int <= a*b;
    end
end

    // dsp_t1_20x18x64 dsp_inst (
    //     .a_i                (a_int),
    //     .b_i                (b_int),
    //     .acc_fir_i          (6'd0),
    //     .z_o                (z_int),
    //     .dly_b_o            (),
        
    //     .clock_i            (clock0),
    //     .reset_i            (reset),

    //     .feedback_i         (3'd0),
    //     .load_acc_i         (1'b0),
    //     .unsigned_a_i       (1'b1),
    //     .unsigned_b_i       (1'b1),

    //     .output_select_i    (3'h4),
    //     .saturate_enable_i  (1'b0),
    //     .shift_right_i      (6'd0),
    //     .round_i            (1'b0),
    //     .subtract_i         (1'b0),
    //     .register_inputs_i  (1'b0)
    // );

endmodule
