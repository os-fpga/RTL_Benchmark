
module demux_128_2 (in,sel,out,select);
    input in;
    input [7:0]sel;
    output [127:0]out;
    input select;
    
    reg in_internal0, in_internal1;
    reg [7:0] sel_internal0, sel_internal1;
    wire [127:0] out_internal0, out_internal1 ;
    reg [127:0] out_t;
    always @(*)
    begin
       case (select)
        1'b0: 
            begin
                in_internal0  = in;
                sel_internal0 = sel;
                in_internal1  =  0;
                sel_internal1 = 0;
                out_t = out_internal0;
            end
        1'b1: 
            begin
                in_internal0  = 0;
                sel_internal0 = 0;
                in_internal1  =  in;
                sel_internal1 = sel;
                out_t = out_internal1;
            end
        endcase
    end
       
    
    demux_1x128 inst0(
        .in(in_internal0),
        .sel(sel_internal0),
        .out(out_internal0)
        );
        demux_1x128 inst1(
            .in(in_internal1),
            .sel(sel_internal1),
            .out(out_internal1)
            );
    assign out =out_t;
endmodule

module demux_1x128 (in,sel,out);
input in;
input [6:0] sel;
output [127:0] out;
wire [1:0] out_w;

demux_1x2 d128_0(.in(in),.sel(sel[6]),.out(out_w[1:0]));
demux_1x64 d128_1(.in(out_w[0]),.sel(sel[5:0]),.out(out[63:0]));
demux_1x64 d128_2(.in(out_w[1]),.sel(sel[5:0]),.out(out[127:64]));

endmodule

module demux_1x64 (in,sel,out);
input in;
input [5:0] sel;
output [63:0] out;
wire [1:0] out_w;

demux_1x2 d64_0(.in(in),.sel(sel[5]),.out(out_w[1:0]));
demux_1x32 d64_1(.in(out_w[0]),.sel(sel[4:0]),.out(out[31:0]));
demux_1x32 d64_2(.in(out_w[1]),.sel(sel[4:0]),.out(out[63:32]));

endmodule

module demux_1x32 (in,sel,out);
input in;
input [4:0] sel;
output [31:0] out;
wire [1:0] out_w;

demux_1x2 d32_0(.in(in),.sel(sel[4]),.out(out_w[1:0]));
demux_1x16 d32_1(.in(out_w[0]),.sel(sel[3:0]),.out(out[15:0]));
demux_1x16 d32_2(.in(out_w[1]),.sel(sel[3:0]),.out(out[31:16]));

endmodule


module demux_1x16 (in,sel,out);
input in;
input [3:0] sel;
output [15:0] out;
wire [1:0] out_w;

demux_1x2 d16_0(.in(in),.sel(sel[3]),.out(out_w[1:0]));
demux_1x8 d16_1(.in(out_w[0]),.sel(sel[2:0]),.out(out[7:0]));
demux_1x8 d16_2(.in(out_w[1]),.sel(sel[2:0]),.out(out[15:8]));

endmodule

module demux_1x8 (in,sel,out);
input in;
input [2:0] sel;
output [7:0] out;
wire [1:0] out_w;

demux_1x2 d8_0(.in(in),.sel(sel[2]),.out(out_w[1:0]));
demux_1x4 d8_1(.in(out_w[0]),.sel(sel[1:0]),.out(out[3:0]));
demux_1x4 d8_2(.in(out_w[1]),.sel(sel[1:0]),.out(out[7:4]));

endmodule 

module demux_1x4 (in,sel,out);
input in;
input [1:0] sel;
output [3:0] out;
wire [1:0]out_w;

demux_1x2 d4_0(.in(in),.sel(sel[1]),.out(out_w));
demux_1x2 d4_1(.in(out_w[0]),.sel(sel[0]),.out(out[1:0]));
demux_1x2 d4_2(.in(out_w[1]),.sel(sel[0]),.out(out[3:2]));


endmodule 

module demux_1x2 (in,sel,out);
input in,sel;
output [1:0] out;

assign out[0] = (sel==0) ? in :0;
assign out[1] = (sel==1) ? in :0;

endmodule 
