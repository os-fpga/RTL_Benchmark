module dsp_regin (clock0, reset, out, a, b);
output [31:0] out;
input  [15:0] a;
input  [15:0] b;
input  clock0, reset;

reg  [15:0] a_int;
reg  [15:0] b_int;


assign out = a_int*b_int;
 always @(posedge clock0) begin
    if (reset) begin
      a_int <= 0;
      b_int <= 0;
    end else begin
      a_int <= a;
      b_int <= b;
    end
  end

    
endmodule
