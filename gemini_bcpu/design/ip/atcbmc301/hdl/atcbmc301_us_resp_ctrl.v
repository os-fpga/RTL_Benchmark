// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"

module atcbmc301_us_resp_ctrl (
	  self_id,
`ifdef ATCBMC301_SLV1_SUPPORT
	  slv1_resp_data,
	  slv1_resp_id,
	  slv1_resp_valid,
	  slv1_connect,
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	  slv2_resp_data,
	  slv2_resp_id,
	  slv2_resp_valid,
	  slv2_connect,
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	  slv3_resp_data,
	  slv3_resp_id,
	  slv3_resp_valid,
	  slv3_connect,
`endif
	  mst_resp_slave_id,
	  mst_resp_ready,
	  dec_err_resp_id,
	  dec_err_resp_data,
	  dec_err_resp_valid,
	  dec_err_resp_ready,
	  outstanding_id,
	  outstanding_en,
	  outstanding_ready,
	  outstanding_idle,
	  resp_id,
	  resp_data,
	  resp_valid,
	  resp_ready,
	  aclk,
	  aresetn
);
parameter RESP_DATA_WIDTH = 3;
parameter ID_WIDTH   = 4;
parameter BRESP_CHANNEL = 1;
parameter RESP_INORDER_ONLY = 1;
parameter OUTSTAND_ID_WIDTH = 5;
parameter OUTSTANDING_DEPTH = 4;

localparam ID_MSB = ID_WIDTH - 1;
localparam OUTSTAND_ID_MSB = OUTSTAND_ID_WIDTH - 1;
localparam RESP_DATA_MSB = RESP_DATA_WIDTH - 1;

input [3:0] 	self_id;

`ifdef ATCBMC301_SLV1_SUPPORT
input [RESP_DATA_MSB:0] slv1_resp_data;
input [ID_MSB+4:0] slv1_resp_id;
input              slv1_resp_valid;
input              slv1_connect;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
input [RESP_DATA_MSB:0] slv2_resp_data;
input [ID_MSB+4:0] slv2_resp_id;
input              slv2_resp_valid;
input              slv2_connect;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
input [RESP_DATA_MSB:0] slv3_resp_data;
input [ID_MSB+4:0] slv3_resp_id;
input              slv3_resp_valid;
input              slv3_connect;
`endif
output  [4:0]       mst_resp_slave_id;
output              mst_resp_ready;

input [ID_MSB:0] 	dec_err_resp_id;
input [RESP_DATA_MSB:0]	dec_err_resp_data;
input    		dec_err_resp_valid;
output          	dec_err_resp_ready;

input [OUTSTAND_ID_MSB:0] outstanding_id;
input 		   	  outstanding_en;
output		   	  outstanding_ready;
output			  outstanding_idle;

output [ID_MSB:0]   	  resp_id;
output [RESP_DATA_MSB:0]  resp_data;
output                    resp_valid;
input              	  resp_ready;

input aclk;
input aresetn;

reg [ID_MSB:0]      	resp_id;
reg [RESP_DATA_MSB:0] 	resp_data;
reg                   	resp_valid;
reg [ID_MSB:0] 	s0 [0:31];
reg [RESP_DATA_MSB:0] 	s1 [0:31];
reg [31:0] 	      	s2;

wire s3;

always @* begin
	s2[0] = 1'b0;
	s1[0]  = {RESP_DATA_WIDTH{1'b0}};
	s0[0]    = {ID_WIDTH{1'b0}};

`ifdef ATCBMC301_SLV1_SUPPORT
	s2[1] = slv1_resp_valid & (slv1_resp_id[3:0]==self_id) & slv1_connect;
	s1[1]  = {RESP_DATA_WIDTH{slv1_connect}} & slv1_resp_data;
	s0[1]    = {ID_WIDTH{slv1_connect}} & slv1_resp_id[ID_MSB+4:4];
`else
	s2[1] = 1'b0;
	s1[1]  = {RESP_DATA_WIDTH{1'b0}};
	s0[1]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	s2[2] = slv2_resp_valid & (slv2_resp_id[3:0]==self_id) & slv2_connect;
	s1[2]  = {RESP_DATA_WIDTH{slv2_connect}} & slv2_resp_data;
	s0[2]    = {ID_WIDTH{slv2_connect}} & slv2_resp_id[ID_MSB+4:4];
`else
	s2[2] = 1'b0;
	s1[2]  = {RESP_DATA_WIDTH{1'b0}};
	s0[2]    = {ID_WIDTH{1'b0}};
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	s2[3] = slv3_resp_valid & (slv3_resp_id[3:0]==self_id) & slv3_connect;
	s1[3]  = {RESP_DATA_WIDTH{slv3_connect}} & slv3_resp_data;
	s0[3]    = {ID_WIDTH{slv3_connect}} & slv3_resp_id[ID_MSB+4:4];
`else
	s2[3] = 1'b0;
	s1[3]  = {RESP_DATA_WIDTH{1'b0}};
	s0[3]    = {ID_WIDTH{1'b0}};
`endif
	s2[4] = 1'b0;
	s1[4]  = {RESP_DATA_WIDTH{1'b0}};
	s0[4]    = {ID_WIDTH{1'b0}};

	s2[5] = 1'b0;
	s1[5]  = {RESP_DATA_WIDTH{1'b0}};
	s0[5]    = {ID_WIDTH{1'b0}};

	s2[6] = 1'b0;
	s1[6]  = {RESP_DATA_WIDTH{1'b0}};
	s0[6]    = {ID_WIDTH{1'b0}};

	s2[7] = 1'b0;
	s1[7]  = {RESP_DATA_WIDTH{1'b0}};
	s0[7]    = {ID_WIDTH{1'b0}};

	s2[8] = 1'b0;
	s1[8]  = {RESP_DATA_WIDTH{1'b0}};
	s0[8]    = {ID_WIDTH{1'b0}};

	s2[9] = 1'b0;
	s1[9]  = {RESP_DATA_WIDTH{1'b0}};
	s0[9]    = {ID_WIDTH{1'b0}};

	s2[10] = 1'b0;
	s1[10]  = {RESP_DATA_WIDTH{1'b0}};
	s0[10]    = {ID_WIDTH{1'b0}};

	s2[11] = 1'b0;
	s1[11]  = {RESP_DATA_WIDTH{1'b0}};
	s0[11]    = {ID_WIDTH{1'b0}};

	s2[12] = 1'b0;
	s1[12]  = {RESP_DATA_WIDTH{1'b0}};
	s0[12]    = {ID_WIDTH{1'b0}};

	s2[13] = 1'b0;
	s1[13]  = {RESP_DATA_WIDTH{1'b0}};
	s0[13]    = {ID_WIDTH{1'b0}};

	s2[14] = 1'b0;
	s1[14]  = {RESP_DATA_WIDTH{1'b0}};
	s0[14]    = {ID_WIDTH{1'b0}};

	s2[15] = 1'b0;
	s1[15]  = {RESP_DATA_WIDTH{1'b0}};
	s0[15]    = {ID_WIDTH{1'b0}};

	s2[16] = 1'b0;
	s1[16]  = {RESP_DATA_WIDTH{1'b0}};
	s0[16]    = {ID_WIDTH{1'b0}};

	s2[17] = 1'b0;
	s1[17]  = {RESP_DATA_WIDTH{1'b0}};
	s0[17]    = {ID_WIDTH{1'b0}};

	s2[18] = 1'b0;
	s1[18]  = {RESP_DATA_WIDTH{1'b0}};
	s0[18]    = {ID_WIDTH{1'b0}};

	s2[19] = 1'b0;
	s1[19]  = {RESP_DATA_WIDTH{1'b0}};
	s0[19]    = {ID_WIDTH{1'b0}};

	s2[20] = 1'b0;
	s1[20]  = {RESP_DATA_WIDTH{1'b0}};
	s0[20]    = {ID_WIDTH{1'b0}};

	s2[21] = 1'b0;
	s1[21]  = {RESP_DATA_WIDTH{1'b0}};
	s0[21]    = {ID_WIDTH{1'b0}};

	s2[22] = 1'b0;
	s1[22]  = {RESP_DATA_WIDTH{1'b0}};
	s0[22]    = {ID_WIDTH{1'b0}};

	s2[23] = 1'b0;
	s1[23]  = {RESP_DATA_WIDTH{1'b0}};
	s0[23]    = {ID_WIDTH{1'b0}};

	s2[24] = 1'b0;
	s1[24]  = {RESP_DATA_WIDTH{1'b0}};
	s0[24]    = {ID_WIDTH{1'b0}};

	s2[25] = 1'b0;
	s1[25]  = {RESP_DATA_WIDTH{1'b0}};
	s0[25]    = {ID_WIDTH{1'b0}};

	s2[26] = 1'b0;
	s1[26]  = {RESP_DATA_WIDTH{1'b0}};
	s0[26]    = {ID_WIDTH{1'b0}};

	s2[27] = 1'b0;
	s1[27]  = {RESP_DATA_WIDTH{1'b0}};
	s0[27]    = {ID_WIDTH{1'b0}};

	s2[28] = 1'b0;
	s1[28]  = {RESP_DATA_WIDTH{1'b0}};
	s0[28]    = {ID_WIDTH{1'b0}};

	s2[29] = 1'b0;
	s1[29]  = {RESP_DATA_WIDTH{1'b0}};
	s0[29]    = {ID_WIDTH{1'b0}};

	s2[30] = 1'b0;
	s1[30]  = {RESP_DATA_WIDTH{1'b0}};
	s0[30]    = {ID_WIDTH{1'b0}};

	s2[31] = 1'b0;
	s1[31]  = {RESP_DATA_WIDTH{1'b0}};
	s0[31]    = {ID_WIDTH{1'b0}};

end
assign       mst_resp_ready = ~(resp_valid & ~resp_ready) & ~outstanding_idle;
assign dec_err_resp_ready = ~(resp_valid & ~resp_ready) & outstanding_idle;

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		resp_data <= {RESP_DATA_WIDTH{1'b0}};
		resp_id   <= {ID_WIDTH{1'b0}};
		resp_valid <= 1'b0;
	end else if (dec_err_resp_valid && dec_err_resp_ready) begin
		resp_data <= dec_err_resp_data;
		resp_id   <= dec_err_resp_id[ID_MSB:0];
		resp_valid <= 1'b1;
	end else if (s2[mst_resp_slave_id] && mst_resp_ready) begin
		resp_data <= s1[mst_resp_slave_id];
		resp_id   <= s0[mst_resp_slave_id];
		resp_valid <= 1'b1;
	end else if (resp_ready)
		resp_valid <= 1'b0;
end

generate
	if (BRESP_CHANNEL==1) begin:always_bresp_last
		assign s3 = 1'b1;
	end else begin: rdata_last
		assign s3 = dec_err_resp_valid ? dec_err_resp_data[RESP_DATA_WIDTH-3] : s1[mst_resp_slave_id][RESP_DATA_WIDTH-3];
	end
endgenerate
		wire s4          ;
		wire [4:0] s5       ;
		wire s6          ;
		wire [4:0] s7       ;
		wire s8	   ;
		wire s9 	   ;
		assign outstanding_idle = s8;
		assign outstanding_ready = ~s9;
		assign s4    = outstanding_en;
		assign s5 = outstanding_id[4:0];
		assign s6    = s2[mst_resp_slave_id] & mst_resp_ready & s3;
		assign mst_resp_slave_id = s7[4:0];
		nds_sync_fifo_afe #(
		                .DATA_WIDTH (5),
		                .FIFO_DEPTH (OUTSTANDING_DEPTH)
                        ) rsid_fifo (
			.reset_n     (aresetn               ),
			.clk         (aclk                  ),
			.wr          (s4          ),
			.wr_data     (s5       ),
			.rd          (s6          ),
			.rd_data     (s7       ),
			.almost_empty(                      ),
			.almost_full (                      ),
			.empty       (s8       ),
			.full        (s9        )
					   );

endmodule
