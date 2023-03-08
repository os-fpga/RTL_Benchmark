// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"

module atcbmc301_us_wdata_ctrl (
	  self_id,
`ifdef ATCBMC301_SLV1_SUPPORT
	  slv1_wmid,
	  slv1_wready,
	  slv1_connect,
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	  slv2_wmid,
	  slv2_wready,
	  slv2_connect,
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	  slv3_wmid,
	  slv3_wready,
	  slv3_connect,
`endif
	  us_wdata,
	  us_wlast,
	  us_wstrb,
	  us_wvalid,
	  us_wready,
	  aw_outstanding_id,
	  aw_addr_outstanding_en,
	  aw_outstanding_ready,
	  wd_outstanding_idle,
	  resp_outstanding_en,
	  outstanding_resp_ready,
	  dec_err_wready,
	  dec_err_wvalid,
	  dec_err_wlast,
	  mst_wsid,
	  mst_wvalid,
	  mst_wdata,
	  mst_wlast,
	  mst_wstrb,
	  aclk,
	  aresetn
);
parameter DATA_WIDTH = 64;
parameter OUTSTAND_ID_WIDTH = 5;
parameter OUTSTANDING_DEPTH = 2;

localparam DATA_MSB = DATA_WIDTH - 1;
localparam OUTSTAND_ID_MSB = OUTSTAND_ID_WIDTH - 1;

input [3:0] 	    self_id;

`ifdef ATCBMC301_SLV1_SUPPORT
input [3:0]        slv1_wmid;
input              slv1_wready;
input 	 	slv1_connect;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
input [3:0]        slv2_wmid;
input              slv2_wready;
input 	 	slv2_connect;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
input [3:0]        slv3_wmid;
input              slv3_wready;
input 	 	slv3_connect;
`endif
input [DATA_MSB:0] us_wdata;
input 	           us_wlast;
input [(DATA_WIDTH/8)-1:0] us_wstrb;
input              us_wvalid;
output             us_wready;

input [OUTSTAND_ID_MSB:0] aw_outstanding_id;
input	  	   aw_addr_outstanding_en;
output		   aw_outstanding_ready;
output		   wd_outstanding_idle;

output		   resp_outstanding_en;
input		   outstanding_resp_ready;
input		   dec_err_wready;
output		   dec_err_wvalid;
output		   dec_err_wlast;
output [4:0]       mst_wsid;
output		   	    mst_wvalid;
output [DATA_MSB:0] 	    mst_wdata;
output 	                    mst_wlast;
output [(DATA_WIDTH/8)-1:0] mst_wstrb;

input aclk;
input aresetn;

reg [DATA_MSB:0] 	 s0;
reg 	                 s1;
reg [(DATA_WIDTH/8)-1:0] s2;
reg             	 s3;
wire 			 s4;
wire [31:0] 		 s5;
wire 			 s6;
wire [OUTSTAND_ID_MSB:0] s7;
wire [OUTSTAND_ID_MSB:0] s8;
wire                     s9;
wire			 s10;
wire                     s11;
wire			 s12;

assign aw_outstanding_ready = ~s10;
assign wd_outstanding_idle  = s9;
assign s11 = (s3 | us_wvalid) & mst_wlast & outstanding_resp_ready & ~s9 & s4;
assign s12 = aw_addr_outstanding_en;
assign s7 = aw_outstanding_id;
assign resp_outstanding_en = s11;
assign mst_wsid = s8[4:0];


	assign s5[0] = 1'b0;

`ifdef ATCBMC301_SLV1_SUPPORT
	assign s5[1] = (slv1_wmid==self_id) & slv1_wready & slv1_connect;
`else
	assign s5[1] = 1'b0;
`endif
`ifdef ATCBMC301_SLV2_SUPPORT
	assign s5[2] = (slv2_wmid==self_id) & slv2_wready & slv2_connect;
`else
	assign s5[2] = 1'b0;
`endif
`ifdef ATCBMC301_SLV3_SUPPORT
	assign s5[3] = (slv3_wmid==self_id) & slv3_wready & slv3_connect;
`else
	assign s5[3] = 1'b0;
`endif
	assign s5[4] = 1'b0;

	assign s5[5] = 1'b0;

	assign s5[6] = 1'b0;

	assign s5[7] = 1'b0;

	assign s5[8] = 1'b0;

	assign s5[9] = 1'b0;

	assign s5[10] = 1'b0;

	assign s5[11] = 1'b0;

	assign s5[12] = 1'b0;

	assign s5[13] = 1'b0;

	assign s5[14] = 1'b0;

	assign s5[15] = 1'b0;

	assign s5[16] = 1'b0;

	assign s5[17] = 1'b0;

	assign s5[18] = 1'b0;

	assign s5[19] = 1'b0;

	assign s5[20] = 1'b0;

	assign s5[21] = 1'b0;

	assign s5[22] = 1'b0;

	assign s5[23] = 1'b0;

	assign s5[24] = 1'b0;

	assign s5[25] = 1'b0;

	assign s5[26] = 1'b0;

	assign s5[27] = 1'b0;

	assign s5[28] = 1'b0;

	assign s5[29] = 1'b0;

	assign s5[30] = 1'b0;

	assign s5[31] = 1'b0;

assign us_wready = ~s3;
assign mst_wvalid = (s3 | us_wvalid) & ~(mst_wlast & ~outstanding_resp_ready) & ~s9;
assign mst_wlast  = s3 ? s1 : us_wlast;
assign mst_wdata  = s3 ? s0 : us_wdata;
assign mst_wstrb  = s3 ? s2 : us_wstrb;
assign dec_err_wvalid = (s3 | us_wvalid) & s9;
assign dec_err_wlast = mst_wlast;
assign s4 = s5[mst_wsid];
assign s6 = dec_err_wready | (s4 & ~((s3 | us_wvalid) & mst_wlast & ~outstanding_resp_ready) & ~s9);

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s3 <= 1'b0;
	else
		s3 <= (s3 | us_wvalid) & ~s6;
end

always @(posedge aclk or negedge aresetn) begin
  if (!aresetn) begin
	s0  <= {DATA_WIDTH{1'b0}};
	s1  <= 1'b0;
	s2  <= {(DATA_WIDTH/8){1'b0}};
  end else if (us_wvalid & ~s6 & ~s3) begin
	s0  <= us_wdata;
	s1  <= us_wlast;
	s2  <= us_wstrb;
  end
end

nds_sync_fifo_afe #(
                .DATA_WIDTH (OUTSTAND_ID_WIDTH),
                .FIFO_DEPTH (OUTSTANDING_DEPTH)
) wsid_fifo (
	.reset_n     (aresetn               ),
	.clk         (aclk                  ),
	.wr          (s12          ),
	.wr_data     (s7       ),
	.rd          (s11          ),
	.rd_data     (s8       ),
	.almost_empty(                      ),
	.almost_full (                      ),
	.empty       (s9       ),
	.full        (s10        )
);

endmodule
