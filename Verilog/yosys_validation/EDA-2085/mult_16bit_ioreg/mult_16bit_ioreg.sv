module mult_16bit_ioreg (clock0, reset, out, a, b);
output  [31:0] out;
input  [15:0] a;
input  [15:0] b;
input  clock0, reset;

reg  [15:0] a_int;
reg  [15:0] b_int;

reg   [31:0] z_int;

assign out=z_int;

always @(posedge clock0) begin
    if (reset) begin
      z_int <= 0;
      a_int <= 0;
      b_int <= 0;
    end else begin
      z_int <= b_int * a_int;
      a_int <= a;
      b_int <= b;
    end
end



endmodule
