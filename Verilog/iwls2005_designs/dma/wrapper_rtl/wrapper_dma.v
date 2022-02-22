//Wrapper Design

`include "DMA_DEFINE.vh" 

module wrapper_dma 
( 
HCLK, 
HRSTn, 
 
h0write, 

h0lock, 


h0readyin, 

h0resp, 

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 

h_temp_addr, 
h_temp_trans, 
h1write, 
h_temp_size, 
h_temp_prot, 
h_temp_burst, 
h_temp_wdata, 
h1readyin, 

h1sel_temp_dma_br, 
select_h1sel_temp_dma_br,

h1rdt_temp_dma, 

h1rp_temp_dma, 

 h1rdy_temp_dma,  

h1rdt_temp_br,  

h1rp_temp_br, 

h1rdy_temp_br, 


`else 

h_temp_addr, 
h_temp_trans, 
h1write, 
h_temp_size, 
h_temp_prot, 
h_temp_burst, 
h_temp_wdata, 
h1lock,  
h1rdata, 
h1readyin, 
h1resp, 

`endif 
`endif 

haddr, 
hwrite, 
hsize, 
hburst, 
htrans, 
hprot, 
h0rdata,
hwdata,
hreadyin, 
hsel_reg, 
hreadyout_reg, 
hresp_reg, 

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 
hsel_br, 
hrdata_temp_br_reg,
sel_hrdata_temp_br_reg,
hreadyout_br, 
hresp_br, 
`endif 
`endif 


h0req, 
h0grant, 

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 
`else 
h1req, 
h1grant, 
`endif 
`endif 


dmaint, 
dmaint_tc, 
dmaint_err, 


dma_req, 
dma_ack_tc, 
sel_dma_ack_tc,
ch_select,
sel_addr_wdata,
sel_prot,
sel_size_burst,
sel_trans
); 

input HCLK; 
input HRSTn; 

output h0write; 
output h0lock;  
input [`DMA_HDATA_WIDTH-1:0] h0rdata; 
input h0readyin; 
input [`DMA_HRESP_WIDTH-1:0] h0resp; 

`ifdef DMA_HAVE_AHB1 

`ifdef DMA_HAVE_BRIDGE 
output [`DMA_HADDR_WIDTH-1:0] h_temp_addr; 
output [`DMA_HTRANS_WIDTH-1:0] h_temp_trans;  
output h1write; 
output [`DMA_HSIZE_WIDTH-1:0] h_temp_size; 
output [`DMA_HPROT_WIDTH-1:0] h_temp_prot; 
output [`DMA_HBURST_WIDTH-1:0] h_temp_burst; 
output [`DMA_HDATA_WIDTH-1:0] h_temp_wdata; 
output h1readyin; 

output [`DMA_MAX_CHNO-1:0] h1sel_temp_dma_br;
input select_h1sel_temp_dma_br;
 

input [`DMA_HDATA_WIDTH-1:0] h1rdt_temp_dma; 

input [`DMA_HRESP_WIDTH-1:0] h1rp_temp_dma; 

input h1rdy_temp_dma; 


input [`DMA_HDATA_WIDTH-1:0] h1rdt_temp_br; 


input [`DMA_HRESP_WIDTH-1:0] h1rp_temp_br; 


input h1rdy_temp_br; 


`else 


output [`DMA_HADDR_WIDTH-1:0] h_temp_addr; 
output [`DMA_HTRANS_WIDTH-1:0] h_temp_trans;   
output [`DMA_HSIZE_WIDTH-1:0] h_temp_size; 
output [`DMA_HPROT_WIDTH-1:0] h_temp_prot; 
output [`DMA_HBURST_WIDTH-1:0] h_temp_burst; 
output [`DMA_HDATA_WIDTH-1:0] h_temp_wdata; 
output h1write;  
output h1lock; 
input [`DMA_HDATA_WIDTH-1:0] h1rdata; 
input h1readyin; 
input [`DMA_HRESP_WIDTH-1:0] h1resp; 

`endif 
`endif 


input [`DMA_HADDR_WIDTH-1:0] haddr; 
input hwrite; 
input [`DMA_HSIZE_WIDTH-1:0] hsize; 
input [`DMA_HBURST_WIDTH-1:0] hburst; 
input [`DMA_HTRANS_WIDTH-1:0] htrans; 
input [`DMA_HPROT_WIDTH-1:0] hprot; 

input [`DMA_HDATA_WIDTH-1:0] hwdata; 
input hreadyin; 

input hsel_reg; 
output hreadyout_reg; 
output [`DMA_HRESP_WIDTH-1:0] hresp_reg; 

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 
input hsel_br; 

output [`DMA_HDATA_WIDTH-1:0] hrdata_temp_br_reg;
input sel_hrdata_temp_br_reg; 

output hreadyout_br; 
output [`DMA_HRESP_WIDTH-1:0] hresp_br; 
`endif 
`endif 


output h0req; 
input h0grant; 

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 
`else 
output h1req; 
input h1grant; 
`endif 
`endif 


output dmaint; 
output dmaint_tc; 
output dmaint_err;


input [`DMA_MAX_CHNO-1:0] dma_req; 

output [`DMA_MAX_CHNO-1:0] dma_ack_tc;
input  sel_dma_ack_tc;

input [2:0]ch_select;
input sel_addr_wdata;
input sel_prot;
input sel_size_burst;
input sel_trans;


reg [`DMA_HDATA_WIDTH-1:0] h1rdt0_dma;
reg [`DMA_HDATA_WIDTH-1:0] h1rdt1_dma;
reg [`DMA_HDATA_WIDTH-1:0] h1rdt2_dma;
reg [`DMA_HDATA_WIDTH-1:0] h1rdt3_dma;
reg [`DMA_HDATA_WIDTH-1:0] h1rdt4_dma;
reg [`DMA_HDATA_WIDTH-1:0] h1rdt5_dma;
reg [`DMA_HDATA_WIDTH-1:0] h1rdt6_dma;
reg [`DMA_HDATA_WIDTH-1:0] h1rdt7_dma;

reg [`DMA_HRESP_WIDTH-1:0] h1rp0_dma; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp1_dma; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp2_dma; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp3_dma; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp4_dma; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp5_dma; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp6_dma; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp7_dma; 

reg h1rdy0_dma;
reg h1rdy1_dma;
reg h1rdy2_dma;
reg h1rdy3_dma;
reg h1rdy4_dma;
reg h1rdy5_dma;
reg h1rdy6_dma;
reg h1rdy7_dma;

reg [`DMA_HDATA_WIDTH-1:0] h1rdt0_br; 
reg [`DMA_HDATA_WIDTH-1:0] h1rdt1_br; 
reg [`DMA_HDATA_WIDTH-1:0] h1rdt2_br; 
reg [`DMA_HDATA_WIDTH-1:0] h1rdt3_br; 
reg [`DMA_HDATA_WIDTH-1:0] h1rdt4_br; 
reg [`DMA_HDATA_WIDTH-1:0] h1rdt5_br; 
reg [`DMA_HDATA_WIDTH-1:0] h1rdt6_br; 
reg [`DMA_HDATA_WIDTH-1:0] h1rdt7_br; 

reg [`DMA_HRESP_WIDTH-1:0] h1rp0_br; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp1_br; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp2_br; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp3_br; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp4_br; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp5_br; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp6_br; 
reg [`DMA_HRESP_WIDTH-1:0] h1rp7_br; 

reg  h1rdy0_br; 
reg  h1rdy1_br; 
reg  h1rdy2_br; 
reg  h1rdy3_br; 
reg  h1rdy4_br; 
reg  h1rdy5_br; 
reg  h1rdy6_br; 
reg  h1rdy7_br; 

wire [`DMA_HADDR_WIDTH-1:0] h0addr; 
wire [`DMA_HTRANS_WIDTH-1:0] h0trans;
wire [`DMA_HSIZE_WIDTH-1:0] h0size; 
wire [`DMA_HPROT_WIDTH-1:0] h0prot; 
wire [`DMA_HBURST_WIDTH-1:0] h0burst; 
wire [`DMA_HDATA_WIDTH-1:0] h0wdata;

wire [`DMA_HADDR_WIDTH-1:0] h1addr; 
wire [`DMA_HTRANS_WIDTH-1:0] h1trans;
wire [`DMA_HSIZE_WIDTH-1:0] h1size; 
wire [`DMA_HPROT_WIDTH-1:0] h1prot; 
wire [`DMA_HBURST_WIDTH-1:0] h1burst; 
wire [`DMA_HDATA_WIDTH-1:0] h1wdata;

wire [`DMA_MAX_CHNO-1:0] h1sel_dma; 
wire [`DMA_MAX_CHNO-1:0] h1sel_br; 

wire [`DMA_MAX_CHNO-1:0] dma_ack; 
wire [`DMA_MAX_CHNO-1:0] dma_tc; 

wire [`DMA_HDATA_WIDTH-1:0] hrdata_br;
wire [`DMA_HDATA_WIDTH-1:0] hrdata_reg;

always @ (ch_select, h1rdy_temp_br, h1rp_temp_br, h1rdt_temp_br, h1rdy_temp_dma, h1rp_temp_dma, h1rdt_temp_dma ) begin
    
    h1rdt0_dma = 'b0;
    h1rdt1_dma = 'b0;
    h1rdt2_dma = 'b0;
    h1rdt3_dma = 'b0;
    h1rdt4_dma = 'b0;
    h1rdt5_dma = 'b0;
    h1rdt6_dma = 'b0;
    h1rdt7_dma = 'b0;

    h1rp0_dma = 'b0;
    h1rp1_dma = 'b0;
    h1rp2_dma = 'b0;
    h1rp3_dma = 'b0;
    h1rp4_dma = 'b0;
    h1rp5_dma = 'b0;
    h1rp6_dma = 'b0;
    h1rp7_dma = 'b0;

    h1rdy0_dma  = 'b0;
    h1rdy1_dma  = 'b0;
    h1rdy2_dma  = 'b0;
    h1rdy3_dma  = 'b0;
    h1rdy4_dma  = 'b0;
    h1rdy5_dma  = 'b0;
    h1rdy6_dma  = 'b0;
    h1rdy7_dma  = 'b0;

    h1rdt0_br = 'b0;
    h1rdt1_br = 'b0;
    h1rdt2_br = 'b0;
    h1rdt3_br = 'b0;
    h1rdt4_br = 'b0;
    h1rdt5_br = 'b0;
    h1rdt6_br = 'b0;
    h1rdt7_br = 'b0;

    h1rp0_br = 'b0;
    h1rp1_br = 'b0;
    h1rp2_br = 'b0;
    h1rp3_br = 'b0;
    h1rp4_br = 'b0;
    h1rp5_br = 'b0;
    h1rp6_br = 'b0;
    h1rp7_br = 'b0;

    h1rdy0_br = 'b0;
    h1rdy1_br = 'b0;
    h1rdy2_br = 'b0;
    h1rdy3_br = 'b0;
    h1rdy4_br = 'b0;
    h1rdy5_br = 'b0;
    h1rdy6_br = 'b0;
    h1rdy7_br = 'b0;

    case(ch_select) /*full_case*/

        3'd0: begin
            h1rdt0_dma = h1rdt_temp_dma;
            h1rp0_dma = h1rp_temp_dma;
            h1rdy0_dma = h1rdy_temp_dma;
            h1rdt0_br  = h1rdt_temp_br;
            h1rp0_br   = h1rp_temp_br;
            h1rdy0_br  = h1rdy_temp_br;
            
        end
        3'd1: begin
            h1rdt1_dma = h1rdt_temp_dma;
            h1rp1_dma = h1rp_temp_dma;
            h1rdy1_dma = h1rdy_temp_dma;
            h1rdt1_br  = h1rdt_temp_br;
            h1rp1_br   = h1rp_temp_br;
            h1rdy1_br  = h1rdy_temp_br;
            
        end
        3'd2: begin
            h1rdt2_dma = h1rdt_temp_dma;
            h1rp2_dma = h1rp_temp_dma;
            h1rdy2_dma = h1rdy_temp_dma;
            h1rdt2_br  = h1rdt_temp_br;
            h1rp2_br   = h1rp_temp_br;
            h1rdy2_br  = h1rdy_temp_br;
            
        end
        3'd3: begin
            h1rdt3_dma = h1rdt_temp_dma;
            h1rp3_dma = h1rp_temp_dma;
            h1rdy3_dma = h1rdy_temp_dma;
            h1rdt3_br  = h1rdt_temp_br;
            h1rp3_br   = h1rp_temp_br;
            h1rdy3_br  = h1rdy_temp_br;
    
        end
        3'd4: begin
            h1rdt4_dma = h1rdt_temp_dma;
            h1rp4_dma = h1rp_temp_dma;
            h1rdy4_dma = h1rdy_temp_dma;
            h1rdt4_br  = h1rdt_temp_br;
            h1rp4_br   = h1rp_temp_br;
            h1rdy4_br  = h1rdy_temp_br;
            
        end
        3'd5: begin
            h1rdt5_dma = h1rdt_temp_dma;
            h1rp5_dma = h1rp_temp_dma;
            h1rdy5_dma = h1rdy_temp_dma;
            h1rdt5_br  = h1rdt_temp_br;
            h1rp5_br   = h1rp_temp_br;
            h1rdy5_br  = h1rdy_temp_br;
            
        end
        3'd6: begin
            h1rdt6_dma = h1rdt_temp_dma;
            h1rp6_dma = h1rp_temp_dma;
            h1rdy6_dma = h1rdy_temp_dma;
            h1rdt6_br  = h1rdt_temp_br;
            h1rp6_br   = h1rp_temp_br;
            h1rdy6_br  = h1rdy_temp_br;
            
        end
        3'd7: begin
            h1rdt7_dma = h1rdt_temp_dma;
            h1rp7_dma = h1rp_temp_dma;
            h1rdy7_dma = h1rdy_temp_dma;
            h1rdt7_br  = h1rdt_temp_br;
            h1rp7_br   = h1rp_temp_br;
            h1rdy7_br  = h1rdy_temp_br;
            
        end

    endcase
end


dma inst_wrapper( 
.HCLK (HCLK),
.HRSTn (HRSTn),


.h0addr(h0addr),
.h0trans (h0trans),
.h0write (h0write), 
.h0size (h0size),
.h0prot (h0prot),
.h0lock (h0lock),
.h0burst (h0burst), 
.h0wdata (h0wdata), 
.h0rdata (h0rdata),
.h0readyin (h0readyin),
.h0resp (h0resp),

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 
.h1addr(h1addr),
.h1trans(h1trans),
.h1write(h1write),
.h1size(h1size),
.h1prot(h1prot),
.h1burst(h1burst),
.h1wdata(h1wdata),
.h1readyin(h1readyin), 
.h1sel_dma(h1sel_dma), 
.h1sel_br(h1sel_br),

.h1rdt0_dma (h1rdt0_dma), 
.h1rdt1_dma (h1rdt1_dma), 
.h1rdt2_dma (h1rdt2_dma), 
.h1rdt3_dma (h1rdt3_dma), 
.h1rdt4_dma (h1rdt4_dma), 
.h1rdt5_dma (h1rdt5_dma), 
.h1rdt6_dma (h1rdt6_dma), 
.h1rdt7_dma (h1rdt7_dma), 

.h1rp0_dma (h1rp0_dma), 
.h1rp1_dma (h1rp1_dma), 
.h1rp2_dma (h1rp2_dma), 
.h1rp3_dma (h1rp3_dma), 
.h1rp4_dma (h1rp4_dma), 
.h1rp5_dma (h1rp5_dma), 
.h1rp6_dma (h1rp6_dma), 
.h1rp7_dma (h1rp7_dma), 

.h1rdy0_dma (h1rdy0_dma), 
.h1rdy1_dma (h1rdy1_dma), 
.h1rdy2_dma (h1rdy2_dma), 
.h1rdy3_dma (h1rdy3_dma), 
.h1rdy4_dma (h1rdy4_dma), 
.h1rdy5_dma (h1rdy5_dma), 
.h1rdy6_dma (h1rdy6_dma), 
.h1rdy7_dma (h1rdy7_dma), 

.h1rdt0_br (h1rdt0_br), 
.h1rdt1_br (h1rdt1_br), 
.h1rdt2_br (h1rdt2_br), 
.h1rdt3_br (h1rdt3_br), 
.h1rdt4_br (h1rdt4_br), 
.h1rdt5_br (h1rdt5_br), 
.h1rdt6_br (h1rdt6_br), 
.h1rdt7_br (h1rdt7_br), 

.h1rp0_br (h1rp0_br), 
.h1rp1_br (h1rp1_br), 
.h1rp2_br (h1rp2_br), 
.h1rp3_br (h1rp3_br), 
.h1rp4_br (h1rp4_br), 
.h1rp5_br (h1rp5_br), 
.h1rp6_br (h1rp6_br), 
.h1rp7_br (h1rp7_br), 

.h1rdy0_br (h1rdy0_br), 
.h1rdy1_br (h1rdy1_br), 
.h1rdy2_br (h1rdy2_br), 
.h1rdy3_br (h1rdy3_br), 
.h1rdy4_br (h1rdy4_br), 
.h1rdy5_br (h1rdy5_br), 
.h1rdy6_br (h1rdy6_br), 
.h1rdy7_br (h1rdy7_br), 


`else 

.h1addr(h1addr), 
.h1trans(h1trans), 
.h1write(h1write), 
.h1size(h1size), 
.h1prot(h1prot), 
.h1lock(h1lock), 
.h1burst(h1burst), 
.h1wdata(h1wdata), 
.h1rdata(h1rdata), 
.h1readyin(h1readyin), 
.h1resp(h1resp), 

`endif 
`endif 


.haddr (haddr), 
.hwrite (hwrite), 
.hsize (hsize), 
.hburst (hburst), 
.htrans (htrans), 
.hprot (hprot), 
.hwdata (hwdata), 
.hreadyin (hreadyin), 
.hsel_reg (hsel_reg), 
.hrdata_reg (hrdata_reg), 
.hreadyout_reg (hreadyout_reg), 
.hresp_reg (hresp_reg), 

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 
.hsel_br(hsel_br), 
.hrdata_br(hrdata_br), 
.hreadyout_br(hreadyout_br), 
.hresp_br(hresp_br), 
`endif 
`endif 


.h0req(h0req), 
.h0grant(h0grant), 

`ifdef DMA_HAVE_AHB1 
`ifdef DMA_HAVE_BRIDGE 
`else 
.h1req (h1req), 
.h1grant (h1grant), 
`endif 
`endif 


.dmaint (dmaint),
.dmaint_tc (dmaint_tc),
.dmaint_err (dmaint_err), 


.dma_req (dma_req),
.dma_ack (dma_ack),
.dma_tc(dma_tc) 
); 
mux_2x1_32in inst0(.a (h0addr),.b (h1addr),.sel (sel_addr_wdata),.out (h_temp_addr));
mux_2x1_32in inst4(.a (h0wdata),.b (h1wdata),.sel (sel_addr_wdata),.out (h_temp_wdata));
mux_2x1_4in inst1(.a (h0prot),.b (h1prot),.sel (sel_prot),.out (h_temp_prot));
mux_2x1_3in inst2(.a (h0size),.b (h1size),.sel (sel_size_burst),.out (h_temp_size));
mux_2x1_3in inst5(.a (h0burst),.b (h1burst),.sel (sel_size_burst),.out (h_temp_burst));
mux_2x1_2in inst3(.a (h0trans),.b (h1trans),.sel (sel_trans),.out (h_temp_trans));

mux_2x1_8in inst6(.a (h1sel_dma),.b (h1sel_br),.sel (select_h1sel_temp_dma_br),.out (h1sel_temp_dma_br));
mux_2x1_8in inst7(.a (dma_ack),.b (dma_tc),.sel (sel_dma_ack_tc),.out (dma_ack_tc));

mux_2x1_32in inst8(.a (hrdata_reg),.b (hrdata_br),.sel (sel_hrdata_temp_br_reg),.out (hrdata_temp_br_reg));
endmodule 


module mux_2x1_32in (
	input [`DMA_HADDR_WIDTH-1:0] a,
	input [`DMA_HADDR_WIDTH-1:0] b,
	input sel,
	output [`DMA_HADDR_WIDTH-1:0] out);
	assign out = sel ? b : a;
	
endmodule 
module mux_2x1_4in (
	input [`DMA_HPROT_WIDTH-1:0] a,
	input [`DMA_HPROT_WIDTH-1:0] b,
	input sel,
	output [`DMA_HPROT_WIDTH-1:0] out);
	assign out = sel ? b : a;
	
endmodule

module mux_2x1_3in (
	input [`DMA_HSIZE_WIDTH-1:0] a,
	input [`DMA_HSIZE_WIDTH-1:0] b,
	input sel,
	output [`DMA_HSIZE_WIDTH-1:0] out);
	assign out = sel ? b : a;
	
endmodule 

module mux_2x1_2in (
	input [`DMA_HTRANS_WIDTH-1:0] a,
	input [`DMA_HTRANS_WIDTH-1:0] b,
	input sel,
	output [`DMA_HTRANS_WIDTH-1:0] out);
	assign out = sel ? b : a;
	
endmodule 

module mux_2x1_8in (
	input [`DMA_MAX_CHNO-1:0] a,
	input [`DMA_MAX_CHNO-1:0] b,
	input sel,
	output [`DMA_MAX_CHNO-1:0] out);
	assign out = sel ? b : a;
	
endmodule