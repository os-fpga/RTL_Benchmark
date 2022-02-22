module wrapper_io_reg_tc1 (mux_in, mux_sel, mux_sel2, com_sel, demux_sel,clk, demux_out, select_mux, select_demux, out_f);
input [0:127] mux_in;
input [6:0]mux_sel; 
input [6:0]mux_sel2;
input [2:0] com_sel;
input [6:0]demux_sel;
input clk;
output [127:0]demux_out;
input select_mux;
input select_demux;
output out_f;

wire [127:0]demux_out_w;

mux_128_2 mux0 (.in(mux_in),.sel(mux_sel),.out(mux_out),.clk(clk),.select(select_mux));
demux_128_2 demux0 (.in(mux_out),.sel(demux_sel),.out(demux_out_w),.clk(clk),.select(select_demux));
mux_128_2 mux1 (.in(mux_in[0:127]),.sel(mux_sel2),.out(out_f),.clk(clk),.select(select_mux));
assign demux_out = demux_out_w;
endmodule
