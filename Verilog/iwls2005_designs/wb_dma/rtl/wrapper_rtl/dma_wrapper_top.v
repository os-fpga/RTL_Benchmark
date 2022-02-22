
module dma_wrapper_top #(parameter ch_count = 1)
(
input		clk_i, rst_i,

// --------------------------------------
// WISHBONE INTERFACE 

// Slave Interface
input	    [31:0]	ts_wbs_data_i,
output reg	[31:0]	ts_wbs_data_o,
input	    [31:0]	ts_wb_addr_i,
input	    [3:0]	ts_wb_sel_i,
input		        ts_wb_we_i,
input		        ts_wb_cyc_i,
input		        ts_wb_stb_i,
output reg		ts_wb_ack_o,
output reg		ts_wb_err_o,
output reg		ts_wb_rty_o,

// Master Interface
input	    [31:0]	tm_wbm_data_i,
output reg	[31:0]	tm_wbm_data_o,
output reg	[31:0]	tm_wb_addr_o,
output reg	[3:0]	tm_wb_sel_o,
output reg		    tm_wb_we_o,
output reg		    tm_wb_cyc_o,
output reg		    tm_wb_stb_o,
input		        tm_wb_ack_i,
input		        tm_wb_err_i,
input		        tm_wb_rty_i,

// Misc Signals
input	    [ch_count-1:0]	dma_req_i,
input	    [ch_count-1:0]	dma_nd_i,
output  	[ch_count-1:0]	dma_ack_o,
input	    [ch_count-1:0]	dma_rest_i,
output 		            inta_o,
output 		            intb_o,
input                       select_master,
input                       select_slave

);

// Slave Interface
reg   	[31:0]	wb0s_data_i;
wire   	[31:0]	wb0s_data_o;
reg   	[31:0]	wb0_addr_i;
reg   	[3:0]	wb0_sel_i;
reg   		    wb0_we_i;
reg   		    wb0_cyc_i;
reg   		    wb0_stb_i;
wire   		    wb0_ack_o;
wire   		    wb0_err_o;
wire   		    wb0_rty_o;

// Master Interface
reg	    [31:0]	wb0m_data_i;
wire	[31:0]	wb0m_data_o;
wire	[31:0]	wb0_addr_o;
wire	[3:0]	wb0_sel_o;
wire		    wb0_we_o;
wire		    wb0_cyc_o;
wire		    wb0_stb_o;
reg		        wb0_ack_i;
reg		        wb0_err_i;
reg		        wb0_rty_i;

// --------------------------------------
// WISHBONE INTERFACE 1

// Slave Interface
reg   	[31:0]	wb1s_data_i;
wire   	[31:0]	wb1s_data_o;
reg   	[31:0]	wb1_addr_i;
reg   	[3:0]	wb1_sel_i;
reg   		    wb1_we_i;
reg   		    wb1_cyc_i;
reg   		    wb1_stb_i;
wire   		    wb1_ack_o;
wire   		    wb1_err_o;
wire   		    wb1_rty_o;

// Master Interface
reg	    [31:0]	wb1m_data_i;
wire	[31:0]	wb1m_data_o;
wire	[31:0]	wb1_addr_o;
wire	[3:0]	wb1_sel_o;
wire		    wb1_we_o;
wire		    wb1_cyc_o;
wire		    wb1_stb_o;
reg		        wb1_ack_i;
reg		        wb1_err_i;
reg		        wb1_rty_i;

always @(select_master,tm_wbm_data_i,tm_wb_ack_i,tm_wb_err_i,tm_wb_rty_i,
 		  wb0m_data_o,wb0_addr_o,wb0_sel_o,wb0_we_o,wb0_cyc_o,wb0_stb_o,
		  wb1m_data_o,wb1_addr_o,wb1_sel_o,wb1_we_o,wb1_cyc_o,wb1_stb_o) 
begin

	wb0m_data_i     = 'b0;
	wb0_ack_i   	= 'b0;
	wb0_err_i  		= 'b0;
	wb0_rty_i  		= 'b0;
	tm_wbm_data_o  	= 'b0;
	tm_wb_addr_o  	= 'b0;
	tm_wb_sel_o  	= 'b0;
	tm_wb_we_o  	= 'b0;
	tm_wb_cyc_o  	= 'b0;
	tm_wb_stb_o  	= 'b0;
	wb1m_data_i  	= 'b0;
	wb1_ack_i  		= 'b0;
	wb1_err_i  		= 'b0;
	wb1_rty_i  		= 'b0;

	case (select_master)
	1'b0:
		begin
     		wb0m_data_i        = tm_wbm_data_i;
	 		wb0_ack_i          = tm_wb_ack_i;
     		wb0_err_i          = tm_wb_err_i;
     		wb0_rty_i          = tm_wb_rty_i;
     		tm_wbm_data_o	   = wb0m_data_o;
     		tm_wb_addr_o	   = wb0_addr_o;
     		tm_wb_sel_o		   = wb0_sel_o;
     		tm_wb_we_o		   = wb0_we_o;
     		tm_wb_cyc_o		   = wb0_cyc_o;
     		tm_wb_stb_o		   = wb0_stb_o;
		end
	1'b1:
		begin
			wb1m_data_i        = tm_wbm_data_i;
			wb1_ack_i          = tm_wb_ack_i;
    		wb1_err_i          = tm_wb_err_i;
    		wb1_rty_i          = tm_wb_rty_i;
    		tm_wbm_data_o	   = wb1m_data_o;
    		tm_wb_addr_o	   = wb1_addr_o;
    		tm_wb_sel_o		   = wb1_sel_o;
    		tm_wb_we_o		   = wb1_we_o;
    		tm_wb_cyc_o		   = wb1_cyc_o;
    		tm_wb_stb_o		   = wb1_stb_o;	
		end	
	endcase
end

always @(select_slave,ts_wbs_data_i,ts_wb_addr_i,ts_wb_sel_i,ts_wb_we_i,ts_wb_cyc_i,ts_wb_stb_i,
         wb0s_data_o,wb0_ack_o,wb0_err_o,wb0_rty_o,wb1s_data_o,wb1_ack_o,wb1_err_o,wb1_rty_o) 
begin
	ts_wbs_data_o   = 'b0;
	ts_wb_ack_o 	= 'b0;
	ts_wb_err_o 	= 'b0;
	ts_wb_rty_o 	= 'b0;
	wb0s_data_i 	= 'b0;
	wb0_addr_i		= 'b0;
	wb0_sel_i 		= 'b0;
	wb0_we_i 		= 'b0;
	wb0_cyc_i 		= 'b0;
	wb0_stb_i 		= 'b0;
	wb1s_data_i 	= 'b0;
	wb1_addr_i 		= 'b0;
	wb1_sel_i 		= 'b0;
	wb1_we_i 		= 'b0;
	wb1_cyc_i 		= 'b0;
	wb1_stb_i 		= 'b0;	

	case (select_slave)
	1'b0:
	begin
			ts_wbs_data_o        = wb0s_data_o;
	 		ts_wb_ack_o          = wb0_ack_o;
     		ts_wb_err_o          = wb0_err_o;
     		ts_wb_rty_o          = wb0_rty_o;
     		wb0s_data_i	         = ts_wbs_data_i;
     		wb0_addr_i	         = ts_wb_addr_i;
     		wb0_sel_i		     = ts_wb_sel_i;
     		wb0_we_i		     = ts_wb_we_i;
     		wb0_cyc_i		     = ts_wb_cyc_i;
     		wb0_stb_i		     = ts_wb_stb_i;
	end
	1'b1:
	begin
			ts_wbs_data_o        = wb1s_data_o;
	 		ts_wb_ack_o          = wb1_ack_o;
     		ts_wb_err_o          = wb1_err_o;
     		ts_wb_rty_o          = wb1_rty_o;
     		wb1s_data_i	         = ts_wbs_data_i;
     		wb1_addr_i	         = ts_wb_addr_i;
     		wb1_sel_i		     = ts_wb_sel_i;
     		wb1_we_i		     = ts_wb_we_i;
     		wb1_cyc_i		     = ts_wb_cyc_i;
     		wb1_stb_i		     = ts_wb_stb_i;
		
	end
		
	endcase
end

wb_dma_top dma_top (clk_i, rst_i,

	wb0s_data_i, wb0s_data_o, wb0_addr_i, wb0_sel_i, wb0_we_i, wb0_cyc_i,
	wb0_stb_i, wb0_ack_o, wb0_err_o, wb0_rty_o,
	wb0m_data_i, wb0m_data_o, wb0_addr_o, wb0_sel_o, wb0_we_o, wb0_cyc_o,
	wb0_stb_o, wb0_ack_i, wb0_err_i, wb0_rty_i,

	wb1s_data_i, wb1s_data_o, wb1_addr_i, wb1_sel_i, wb1_we_i, wb1_cyc_i,
	wb1_stb_i, wb1_ack_o, wb1_err_o, wb1_rty_o,
	wb1m_data_i, wb1m_data_o, wb1_addr_o, wb1_sel_o, wb1_we_o, wb1_cyc_o,
	wb1_stb_o, wb1_ack_i, wb1_err_i, wb1_rty_i,

	dma_req_i, dma_ack_o, dma_nd_i, dma_rest_i,

	inta_o, intb_o
	);

endmodule
