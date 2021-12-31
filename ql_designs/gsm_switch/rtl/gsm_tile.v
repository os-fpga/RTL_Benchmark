// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_tile.v
// Description	: Grouped Shared Memory first level switch --- gsm-tile. 
//				  each tile is responsible for data switching of 4 ingress 
//				  and 4 egress links
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version		: 
//	-- 2011-06-27 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff


`include "timescale.v"

module gsm_tile
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	GSIZE   = 4,	// group size, number of gsm_unit in each group
	parameter	DWIDTH	= 128,	// data width = 16 bytes
	parameter	AWIDTH	= 7	// 2 BRAM = total 512 cells, each port is allocated 128 cells
)
(
	//** global
	input wire			clk_320M,
	input wire			clr_320M,

	input wire			clk_80M,
	input wire			clr_80M,

	input wire			rst_n,

	//** 4 ingress ports
	input wire  [MWIDTH-1:0]		i_ingress_valid,
	input wire	[MWIDTH-1:0]		i_ingress_header,
	input wire	[MWIDTH*DWIDTH-1:0]	i_ingress_data,

	//** 16 egress ports
	input wire	[GSIZE*MWIDTH-1:0]		i_egress_rd,
	output wire [GSIZE*MWIDTH-1:0]		o_egress_valid,
	output wire	[GSIZE*MWIDTH*DWIDTH-1:0]	o_egress_data
	
);
`include "c_functions.v"
localparam LOG_MWIDTH = clogb(MWIDTH);
localparam MAX_PKT_LEN = 7; // maximum packet length in unit of 16-byte data cell
localparam LOC_PKT_LEN = 24; // the bit location of packet length field in the 16-byte data cell
localparam LOC_DEST_IP = 32; // the bit location of the destination ip field in the data cell
// ---------------------------------------------------------------------
// wire, registers and genvar
// ---------------------------------------------------------------------
genvar i,j;

reg [MWIDTH-1:0] common_sel;
//reg [DWIDTH-1:0] common_data;
reg [DWIDTH-1:0] common_data_reg[GSIZE-1:0];
//reg [MWIDTH-1:0] common_sel_reg[GSIZE-1:0];

reg [DWIDTH-1:0] ingress_data [MWIDTH-1:0];
wire [DWIDTH-1:0] asyn_rd_data [MWIDTH-1:0];
reg [MWIDTH*DWIDTH-1:0] asyn_rd_data_reg; 
wire [MWIDTH-1:0] asyn_empty;

reg [MWIDTH*MAX_PKT_LEN-1:0] ingress_pkt_length;
reg [MWIDTH*32-1:0] ingress_dest_ip;

// 0
wire [GSIZE*MWIDTH*MWIDTH-1:0] gsm_multicast;
wire [GSIZE*MWIDTH*AWIDTH-1:0] gsm_cell_addr;
wire [GSIZE*MWIDTH-1:0] gsm_wr_en;

wire [GSIZE*MWIDTH-1:0] hmp_rd,hmp_valid,bf_free_flag;
wire [GSIZE*MWIDTH*AWIDTH-1:0] hmp_addr;

// ---------------------------------------------------------------------
// logic starts here...
// ---------------------------------------------------------------------

// the mux logic implements a 4-to-1 multiplexer running at 320M clock domain 
// that cycle through each of the 4 data ports, so that they all get served in 
// every cycle of the 80M clock domain, the selected data is then broadcast
// to every unit in this GSM group


// the hardware malloc module has a 2 stage pipeline,
// therefore, the data bus also need to be registered 
// once more to match the pipeline processing
//
generate 
    for(i=0;i<MWIDTH;i=i+1)begin: INGRESS_REG
        always@(posedge clk_80M)begin
            if(clr_80M)
                ingress_data[i] <=0;
            else
                ingress_data[i] <= i_ingress_data[(i+1)*DWIDTH-1:i*DWIDTH];
        end
    end
endgenerate

generate
	for(i=0;i<MWIDTH;i=i+1) begin: DATA_PORT_MUX
		asyn_fifo
		#(
			.DBITWIDTH(DWIDTH),	// address + multicast vector + write enable
			.ABITWIDTH(2)			// 4 entries should be enough to accommodate the pipeline
		)
		ingress_data_fifo
		(
			// global
			.clk_a(clk_80M),
			.clk_b(clk_320M),
			.rst_n(rst_n),
			.clr_a(clr_80M),
			.clr_b(clr_320M),
	
			// FIFO write interface
			.write(1'b1),
			.write_data(ingress_data[i]),
	
			// FIFO read interface
			.read(~asyn_empty[i]),
			.read_data(asyn_rd_data[i]),
	
			// FIFO status signals
			.empty(asyn_empty[i]),
			.almost_full(),
			.full()
		);

		always@(posedge clk_320M )begin
			if(clr_320M)
				asyn_rd_data_reg[(i+1)*DWIDTH-1:i*DWIDTH] <= 0;
			else
				asyn_rd_data_reg[(i+1)*DWIDTH-1:i*DWIDTH] <= asyn_rd_data[i];
		end		
	end
endgenerate

// a 4-to-1 multiplexer
always@(posedge clk_320M )begin
	if(clr_320M)
		common_sel <= 1;
	else
		common_sel <= {common_sel,common_sel[MWIDTH-1]};
end

wire [DWIDTH-1:0] common_data_mux;
c_select_1ofn
#(
    .num_ports(MWIDTH),
    .width(DWIDTH)
)
time_mux
(
    .select(common_sel),
    .data_in(asyn_rd_data_reg),
    .data_out(common_data_mux)
);

always@(posedge clk_320M)begin
    if(clr_320M)
        common_data_reg[0] <= 0;
    else
        common_data_reg[0] <= common_data_mux;
end

generate
	for(i=1;i<GSIZE;i=i+1) begin: COMMON_DATA_PIPELINE
		always@(posedge clk_320M )begin
			if(clr_320M)begin
				common_data_reg[i] <= 0;
			end
			else begin
				common_data_reg[i] <= common_data_reg[i-1];
			end
		end		
	end
endgenerate
// the following generated code construct the GSM group structure.
// each group contains GSIZE (4) gsm units, each unit talks to 4  
// hardware malloc logic that manages one of the 4 ingress ports
// the control data embedded in each of 4 ingress port is broadcast
// to 4 hardware malloc module. and the hardware malloc module
// decides whether the ingress data is to be dropped or buffed
// into the gsm switch unit.

generate
    for(i=0;i<MWIDTH;i=i+1) begin: INGRESS_PKT_INFO_GEN
        always@(*)begin
            ingress_pkt_length[(i+1)*MAX_PKT_LEN-1:i*MAX_PKT_LEN] = 
                i_ingress_data[MAX_PKT_LEN+LOC_PKT_LEN-1+i*DWIDTH:LOC_PKT_LEN+i*DWIDTH];
            ingress_dest_ip[(i+1)*32-1:i*32] = 
                i_ingress_data[32+LOC_DEST_IP-1+i*DWIDTH:LOC_DEST_IP+i*DWIDTH];
        end
    end
endgenerate

generate 
	for(i=0;i<GSIZE;i=i+1)begin : GSM_UNIT_GEN
        /*
		hw_malloc_n
		#(
            .NUM_PORT(MWIDTH),
			.MWIDTH(MWIDTH),		// multicast width = 4 output ports
			.MAX_PKT_LEN(7), 	// maximum packet lenght in terms of number of 16-byte cells
			.HM_OFFSET(i*MWIDTH),		// offset for the multicast vectore
			.AWIDTH(AWIDTH)		// 2 BRAM = total 512 cells, each port is allocated 128 cells
		) hw_malloc_n_inst
		(
			// global
			.clk(clk_80M),
			.rst_n(rst_n),
			.clr(clr_80M),
		
			// ingress port
			.i_ingress_pkt_length(ingress_pkt_length),
			.i_ingress_dest_ip(ingress_dest_ip),
			.i_ingress_valid(i_ingress_valid),
			.i_ingress_header(i_ingress_header),
		
			// output to GSM 
			.o_gsm_multicast(gsm_multicast[i]),
			.o_gsm_cell_addr(gsm_cell_addr[i]),
			.o_gsm_wr_en(gsm_wr_en[i]),
		
			// input from GSM
			.o_hmp_rd(hmp_rd[i]),
			.i_hmp_valid(hmp_valid[i]),
			.i_hmp_addr(hmp_addr[i]),
			.i_bf_free_flag(bf_free_flag[i])
		);
*/
        for(j=0;j<MWIDTH;j=j+1) begin: HW_MALLOC_GEN
            hw_malloc
            #(
                .MWIDTH(MWIDTH),		// multicast width = 4 output ports
                .MAX_PKT_LEN(MAX_PKT_LEN), 	// maximum packet lenght in terms of number of 16-byte cells
                .AWIDTH(AWIDTH),		// 2 BRAM = total 512 cells, each port is allocated 128 cells
                .HM_OFFSET(i*MWIDTH)		// offset for the multicast vectore
            ) hw_malloc_inst
            (
                // global
                .clk(clk_80M),
                .rst_n(rst_n),
                .clr(clr_80M),
            
                // ingress port
                .i_ingress_pkt_length(ingress_pkt_length[(j+1)*MAX_PKT_LEN-1:j*MAX_PKT_LEN]),
                .i_ingress_dest_ip(ingress_dest_ip[(j+1)*32-1:j*32]),
                .i_ingress_valid(i_ingress_valid[j]),
                .i_ingress_header(i_ingress_header[j]),
            
                // output to GSM 
                .o_gsm_multicast(gsm_multicast[i*MWIDTH*MWIDTH+(j+1)*MWIDTH-1:i*MWIDTH*MWIDTH+j*MWIDTH]),
                .o_gsm_cell_addr(gsm_cell_addr[i*MWIDTH*AWIDTH+(j+1)*AWIDTH-1:i*MWIDTH*AWIDTH+j*AWIDTH]),
                .o_gsm_wr_en(gsm_wr_en[i*MWIDTH+j]),
            
                // input from GSM
                .o_hmp_rd(hmp_rd[i*MWIDTH+j]),
                .i_hmp_valid(hmp_valid[i*MWIDTH+j]),
                .i_hmp_addr(hmp_addr[i*MWIDTH*AWIDTH+(j+1)*AWIDTH-1:i*MWIDTH*AWIDTH+j*AWIDTH]),
                .i_bf_free_flag(bf_free_flag[i*MWIDTH+j])
            );
        end

		gsm_unit_ex
		#(
			.MWIDTH(MWIDTH),	// multicast width = 4 output ports
			.DWIDTH(DWIDTH),	// data width = 16 bytes
			.AWIDTH(AWIDTH),		// 2 BRAM = total 512 cells, each port is allocated 128 cells
			.PIPE_STAGE(i)
		)gsm_unit_inst
		(
			// global
			.clk_320M(clk_320M),
			.clr_320M(clr_320M),
		
			.clk_80M(clk_80M),
			.clr_80M(clr_80M),
		
			.rst_n(rst_n),
		
			// ingress malloc ports
			.i_wr_en(gsm_wr_en[(i+1)*MWIDTH-1:i*MWIDTH]),
			.i_wr_addr(gsm_cell_addr[(i+1)*MWIDTH*AWIDTH-1:i*MWIDTH*AWIDTH]),
			.i_multicast(gsm_multicast[(i+1)*MWIDTH*MWIDTH-1:i*MWIDTH*MWIDTH]),
		
			// egress ports
			.i_egress_rd(i_egress_rd[(i+1)*MWIDTH-1:i*MWIDTH]),
			.o_egress_valid(o_egress_valid[(i+1)*MWIDTH-1:i*MWIDTH]),
			.o_egress_data(o_egress_data[(i+1)*MWIDTH*DWIDTH-1:i*MWIDTH*DWIDTH]),
		
			// buffer free interface
			.i_hmp_rd(hmp_rd[(i+1)*MWIDTH-1:i*MWIDTH]), 		// read a pointer from the Hardware Malloc Pipe
			.o_hmp_valid(hmp_valid[(i+1)*MWIDTH-1:i*MWIDTH]),// Hardware Malloc Pipe is not empty and has available pointer
			.o_hmp_addr(hmp_addr[(i+1)*MWIDTH*AWIDTH-1:i*MWIDTH*AWIDTH]), 		// the pointer to the available buffer space
			.o_bf_free_flag(bf_free_flag[(i+1)*MWIDTH-1:i*MWIDTH]), 	// signal that a pointer has just been freed
			
            // common data bus (at 320Mhz clock domain)
			//.i_common_sel(common_sel),
			.i_common_wr_data(common_data_reg[i])
		);
	end // end for
endgenerate


endmodule


