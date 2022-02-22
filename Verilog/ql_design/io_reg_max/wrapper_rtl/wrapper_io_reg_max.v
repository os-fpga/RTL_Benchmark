module wrapper_io_reg_max (mux_in, mux_sel, com_sel, demux_sel,clk, demux_out, select_mux, select_demux);
input [0:127] mux_in;
input [6:0]mux_sel; 
input [2:0] com_sel;
input [6:0]demux_sel;
input clk;
output [127:0]demux_out;
input select_mux;
input select_demux;
wire [6:0] mux_com_sel;
wire [127:0]demux_out_w;

assign mux_com_sel = mux_sel ^ com_sel;

mux_128_2 mux0 (.in(mux_in),.sel(mux_com_sel),.out(mux_out),.clk(clk),.select(select_mux));
demux_128_2 demux0 (.in(mux_out),.sel(demux_sel),.out(demux_out_w),.clk(clk),.select(select_demux));
assign demux_out = demux_out_w;
endmodule
