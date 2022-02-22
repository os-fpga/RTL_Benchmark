//Wrapper Design

module wrapper_io_tc1 (mux_in, mux_sel, mux_sel2, com_sel, demux_sel, demux_out, select_mux, select_demux);
    input [0:127] mux_in;
    input [6:0]mux_sel; 
    input [6:0]mux_sel2;
    input [2:0] com_sel;
    input [6:0]demux_sel;
    output [127:0]demux_out;
    input select_mux;
    input select_demux;
    wire [127:0]demux_out_w;

    
    mux_128_2 mux0 (.in(mux_in),.sel(mux_sel),.out(mux_out),.select(select_mux));
    demux_128_2 demux0 (.in(mux_out),.sel(demux_sel),.out(demux_out_w),.select(select_demux));
    assign demux_out = demux_out_w;
    endmodule

