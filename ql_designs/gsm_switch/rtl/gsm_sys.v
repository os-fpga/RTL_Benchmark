// zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// File Name	: gsm_sys.v
// Description	: a 16x16 Grouped Shared Memory switch system
// Author		: Zefu Dai
// -------------------------------------------------------------------------------
// Version		: 
//	-- 2011-06-29 created by Zefu Dai
// fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

`include "timescale.v"

module gsm_sys
#(
	parameter	MWIDTH	= 4,	// multicast width = 4 output ports
	parameter	GSIZE   = 8,	// group size, number of gsm_unit in each group
	parameter	DWIDTH	= 128,	// data width = 16 bytes
	parameter	AWIDTH	= 7	// 2 BRAM = total 512 cells, each port is allocated 128 cells
)
(
	//** global
	input wire			clk_33M,
  
  input wire 		clk_320M,
  input wire		clk_80M,
	
	input wire 			shift_clk,
	
	input wire			extern_rst_n,

	output wire			clr_320M,
	output wire			clr_80M,
	output wire			rst_n,

	//** 16 ingress ports
	input wire  [MWIDTH*GSIZE-1:0]			i_ingress_valid,
	input wire  [MWIDTH*GSIZE-1:0]			i_ingress_header,
	input wire										i_ingress_data,

	//** 16 egress ports
	input wire  [MWIDTH*GSIZE-1:0]			i_egress_stall,
	output reg  [MWIDTH*GSIZE-1:0]			o_egress_valid,
	output wire										o_egress_data

);

`include "c_functions.v"

localparam	LOG_MWIDTH = clogb(MWIDTH); 
localparam	LOG_GSIZE = clogb(GSIZE);
//*************************************************************
// wires and registers
//*************************************************************
genvar i,j;

wire [GSIZE*GSIZE*MWIDTH-1:0] egress_rd;
wire [GSIZE*GSIZE*MWIDTH-1:0] egress_valid;
reg [GSIZE*GSIZE*MWIDTH-1:0] egress_grant;
wire [GSIZE*GSIZE*MWIDTH*DWIDTH-1:0] egress_data;
//wire clk_stable_80M;

wire [MWIDTH*GSIZE*DWIDTH-1:0]	i_ingress_data_wires;
reg [MWIDTH*GSIZE*DWIDTH-1:0]	o_egress_data_wires;
//reg [1:0] clk_stable_320M;
reg clr_320M_r;
reg clr_80M_r;

//*************************************************************
// use shift registers to reduces the size of the I/O data to 1
//*************************************************************
shift_data_in 
# (
.MWIDTH(MWIDTH),
.GSIZE(GSIZE),
.DWIDTH(DWIDTH)
)
shift_in (
.clk(shift_clk), 
.clr(extern_rst_n),
.sig_i(i_ingress_data), 
.sig_o(i_ingress_data_wires)
);

shift_data_out 
# (
.MWIDTH(MWIDTH),
.GSIZE(GSIZE),
.DWIDTH(DWIDTH)
)
shift_out (
.clk(shift_clk), 
.clr(extern_rst_n),
.sig_i(o_egress_data_wires), 
.sig_o(o_egress_data)
);

//*************************************************************
// logic starts here...
//*************************************************************
/*
ClockGenerator clk_gen
        (
        .EXTERNAL_RESET_L(extern_rst_n),
        .CLOCKS_STABLE_H(clk_stable_80M),
        .CLK_33MHz(clk_33M),

        .CLK_80MHz(clk_80M),
        .CLK_320MHz(clk_320M)
        );
*/
/*
always@(posedge clk_320M)begin
	clk_stable_320M <= {clk_stable_320M[0],clk_stable_80M};
end
*/
//BUFG RESET_320M_Buffer ( .I(~clk_stable_320M[1]), .O(clr_320M) );
//BUFG RESET_80M_Buffer ( .I(~clk_stable_80M), .O(clr_80M) );

//assign clr_320M = ~clk_stable_320M[1];
//assign clr_80M = ~clk_stable_80M;
always@(posedge clk_320M or negedge extern_rst_n) 
begin
  if (!extern_rst_n)
	   clr_320M_r <= 1'b1;
  else 
     clr_320M_r <= 1'b0;
end

always@(posedge clr_80M or negedge extern_rst_n) 
begin
  if (!extern_rst_n)
	   clr_80M_r <= 1'b1;
  else 
     clr_80M_r <= 1'b0;
end

assign rst_n = 1'b1;
assign clr_320M = clr_320M_r; 
assign clr_80M = clr_80M_r;


generate 
	for(i=0;i<GSIZE;i=i+1) begin: GSM_TILE_GEN
		gsm_tile
		#(
			.MWIDTH(MWIDTH),	
			.GSIZE(GSIZE),	
			.DWIDTH(DWIDTH),	
			.AWIDTH(AWIDTH)	
		)gsm_tile_inst
		(
			//** global
			.clk_320M(clk_320M),
			.clr_320M(clr_320M),

			.clk_80M(clk_80M),
			.clr_80M(clr_80M),

			.rst_n(rst_n),

			//** 4 ingress ports
			.i_ingress_valid(i_ingress_valid[(i+1)*MWIDTH-1:i*MWIDTH]),
			.i_ingress_header(i_ingress_header[(i+1)*MWIDTH-1:i*MWIDTH]),
			.i_ingress_data(i_ingress_data_wires[(i+1)*MWIDTH*DWIDTH-1:i*MWIDTH*DWIDTH]),

			//** 16 egress ports
			// group 1
			.i_egress_rd(egress_grant[(i+1)*GSIZE*MWIDTH-1:i*GSIZE*MWIDTH]),
			.o_egress_valid(egress_valid[(i+1)*GSIZE*MWIDTH-1:i*GSIZE*MWIDTH]),
			.o_egress_data(egress_data[(i+1)*GSIZE*MWIDTH*DWIDTH-1:i*GSIZE*MWIDTH*DWIDTH])
	
		);
	end // end for
endgenerate

// 16 4:1 multiplexers for the 16*4 egress ports

reg [GSIZE*GSIZE*MWIDTH-1:0] rr_req, rr_stall;
wire [GSIZE*GSIZE*MWIDTH-1:0] rr_grant;
reg [GSIZE*GSIZE*MWIDTH*DWIDTH-1:0] rr_data;
generate
    for(i=0;i<GSIZE*MWIDTH;i=i+1)begin: RR_REQ_GENI
        for(j=0;j<GSIZE;j=j+1)begin: RR_REQ_GENJ
            always@(*)begin
                rr_req[i*GSIZE+j] = egress_valid[j*GSIZE*MWIDTH+i];
                //rr_stall[i*GSIZE+j] = i_egress_stall[j*GSIZE*MWIDTH+i];
                rr_data[i*GSIZE*DWIDTH+(j+1)*DWIDTH-1:i*GSIZE*DWIDTH+j*DWIDTH]
                =
               egress_data[j*GSIZE*MWIDTH*DWIDTH+(i+1)*DWIDTH-1:j*GSIZE*MWIDTH*DWIDTH+i*DWIDTH];
            end
        end
    end
endgenerate

generate
	for(i=0;i<GSIZE*MWIDTH;i=i+1)begin:rnd_robin2
		rr_sch
		#(
			.NUM_PORT(GSIZE)	// number of requests to be scheduled
		)rr_sch_inst
		(
			.clk(clk_80M),
			.rst_n(rst_n),
			.clr(clr_80M),
		
			.req(rr_req[(i+1)*GSIZE-1:i*GSIZE]),
			.stall(i_egress_stall[i]),
			.grant(rr_grant[(i+1)*GSIZE-1:i*GSIZE])
		);
	end // end for rnd_robin2
endgenerate

generate
    for(i=0;i<GSIZE*MWIDTH;i=i+1)begin: RR_GRANT_GENI
        for(j=0;j<GSIZE;j=j+1)begin: RR_GRANT_GENJ
            always@(*)begin
                egress_grant[j*GSIZE*MWIDTH+i] = rr_grant[i*GSIZE+j];
            end
        end
    end
endgenerate

wire [DWIDTH-1:0] egress_data_mux[GSIZE*MWIDTH-1:0];
generate
    for(i=0;i<GSIZE*MWIDTH;i=i+1)begin: EGRESS_VALID_GEN
        always@(posedge clk_80M)begin
            if(clr_80M)begin
                o_egress_valid[i] <= 0;
                o_egress_data_wires[(i+1)*DWIDTH-1:i*DWIDTH] <= 0;
            end
            else begin
                o_egress_valid[i] <= |rr_grant[(i+1)*GSIZE-1:i*GSIZE];
                o_egress_data_wires[(i+1)*DWIDTH-1:i*DWIDTH] <=
                    egress_data_mux[i];
            end
        end

        c_select_1ofn#(
            .num_ports(GSIZE),
            .width(DWIDTH)
        )
        egress_dmux
        (
            .select(rr_grant[(i+1)*GSIZE-1:i*GSIZE]),
            .data_in(rr_data[(i+1)*GSIZE*DWIDTH-1:i*GSIZE*DWIDTH]),
            .data_out(egress_data_mux[i])
        );
    end
endgenerate

endmodule
