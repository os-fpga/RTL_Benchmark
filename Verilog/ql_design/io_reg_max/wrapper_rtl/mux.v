
module mux_128_2 (in,sel,out,clk,select);
input [127:0] in;
input [7:0]sel;
output out;
input clk;
input select;

reg [127:0] in_internal0, in_internal1;
reg [7:0] sel_internal0, sel_internal1;
wire  out_internal0, out_internal1;
reg out_t; 
always @(*)
begin
    case(select)
        1'b0:
        begin
            in_internal0  = in;
            sel_internal0 = sel;
            out_t = out_internal0;
        end
        1'b1:
        begin
            in_internal1  =  in;
            sel_internal1 = sel;
            out_t = out_internal1;
        end  
    endcase
end


mux_128x1 inst0(
    .in(in_internal0 ),
    .sel(sel_internal0),
    .out(out_internal0),
    .clk(clk)
    );
mux_128x1 inst1(
        .in(in_internal1),
        .sel(sel_internal1),
        .out(out_internal1),
        .clk(clk)
        );
assign out =out_t;
endmodule

module mux_128x1 (in,sel,out,clk);
input [127:0] in;
input [6:0]sel;
output out;
input clk;

wire out0_w, out1_w;

mux_64x1 m128_0(.in(in[63:0]),.sel(sel[5:0]),.out(out0_w),.clk(clk));
mux_64x1 m128_1(.in(in[127:64]),.sel(sel[5:0]),.out(out1_w),.clk(clk));
mux_2x1 m128_2(.a(out0_w),.b(out1_w),.sel(sel[6]),.out(out));

endmodule

module mux_64x1 (in,sel,out,clk);
input [63:0] in;
input [5:0]sel;
output out;
input clk;

wire out0_w, out1_w;

mux_32x1 m64_0(.in(in[31:0]),.sel(sel[4:0]),.out(out0_w),.clk(clk));
mux_32x1 m64_1(.in(in[63:32]),.sel(sel[4:0]),.out(out1_w),.clk(clk));
mux_2x1 m64_2(.a(out0_w),.b(out1_w),.sel(sel[5]),.out(out));

endmodule

module mux_32x1 (in,sel,out,clk);
input [31:0] in;
input [4:0]sel;
output out;
input clk;

wire out0_w, out1_w;

mux_16x1 m32_0(.in(in[15:0]),.sel(sel[3:0]),.out(out0_w),.clk(clk));
mux_16x1 m32_1(.in(in[31:16]),.sel(sel[3:0]),.out(out1_w),.clk(clk));
mux_2x1 m32_2(.a(out0_w),.b(out1_w),.sel(sel[4]),.out(out));

endmodule

module mux_16x1 (in,sel,out,clk);
input [15:0] in;
input [3:0]sel;
output out;
input clk;

wire out0_w, out1_w;

mux_8x1 m16_0(.in(in[7:0]),.sel(sel[2:0]),.out(out0_w),.clk(clk));
mux_8x1 m16_1(.in(in[15:8]),.sel(sel[2:0]),.out(out1_w),.clk(clk));
mux_2x1 m16_2(.a(out0_w),.b(out1_w),.sel(sel[3]),.out(out));

endmodule

module mux_8x1 (in,sel,out,clk);
input [7:0] in;
input [2:0]sel;
output out;
input clk;

wire out0_w, out1_w;

mux_4x1 m8_0(.in(in[3:0]),.sel(sel[1:0]),.out(out0_w),.clk(clk));
mux_4x1 m8_1(.in(in[7:4]),.sel(sel[1:0]),.out(out1_w),.clk(clk));
mux_2x1 m8_2(.a(out0_w),.b(out1_w),.sel(sel[2]),.out(out));

endmodule

module mux_4x1 (in,sel,out,clk);
input [3:0] in;
input [1:0]sel;
input clk;
output out;
wire out0_w, out1_w;

mux_2x1_reg m4_0(.a(in[0]),.b(in[1]),.sel(sel[0]),.out(out0_w),.clk(clk));
mux_2x1_reg m4_1(.a(in[2]),.b(in[3]),.sel(sel[0]),.out(out1_w),.clk(clk));
mux_2x1 m4_2(.a(out0_w),.b(out1_w),.sel(sel[1]),.out(out));

endmodule 


module mux_2x1_reg (a,b,sel,out,clk);
input a,b;
input sel,clk;
output reg out;
reg a_out, b_out;

always @(posedge clk)
begin
a_out <= a;
b_out <= b;
end

always @(a_out or b_out or sel)
    out = sel ? b_out:a_out;

endmodule 


module mux_2x1 (a,b,sel,out);
input a,b;
input sel;
output out;

assign out = sel ? b : a;

endmodule 
