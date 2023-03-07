// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atcexmon300 (
	  aclk,
	  aresetn,

	  us_awid,
	  us_awaddr,
	  us_awlock,
	  us_awburst,
	  us_awlen,
	  us_awcache,
	  us_awprot,
	  us_awsize,
	  us_awqos,
	  us_awregion,
	  us_awvalid,
	  us_awready,

	  us_wdata,
	  us_wstrb,
	  us_wlast,
	  us_wvalid,
	  us_wready,

	  us_bresp,
	  us_bid,
	  us_bvalid,
	  us_bready,

	  us_arid,
	  us_araddr,
	  us_arlock,
	  us_arburst,
	  us_arlen,
	  us_arcache,
	  us_arprot,
	  us_arsize,
	  us_arqos,
	  us_arregion,
	  us_arvalid,
	  us_arready,

	  us_rid,
	  us_rresp,
	  us_rdata,
	  us_rlast,
	  us_rvalid,
	  us_rready,


	  ds_awid,
	  ds_awaddr,
	  ds_awlock,
	  ds_awburst,
	  ds_awlen,
	  ds_awcache,
	  ds_awprot,
	  ds_awsize,
	  ds_awqos,
	  ds_awregion,
	  ds_awvalid,
	  ds_awready,

	  ds_wdata,
	  ds_wstrb,
	  ds_wlast,
	  ds_wvalid,
	  ds_wready,

	  ds_bresp,
	  ds_bid,
	  ds_bvalid,
	  ds_bready,

	  ds_arid,
	  ds_araddr,
	  ds_arlock,
	  ds_arburst,
	  ds_arlen,
	  ds_arcache,
	  ds_arprot,
	  ds_arsize,
	  ds_arqos,
	  ds_arregion,
	  ds_arvalid,
	  ds_arready,

	  ds_rid,
	  ds_rresp,
	  ds_rdata,
	  ds_rlast,
	  ds_rvalid,
	  ds_rready
);

parameter ID_WIDTH = 16;
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 256;
parameter NUM_EX_SEQ = 32;

localparam PENDING_CNT = ID_WIDTH;
localparam SIZE_WIDTH  = 3;
localparam CACHE_WIDTH = 4;
localparam QOS_WIDTH = 4;
localparam REGION_WIDTH = 4;
localparam PROT_WIDTH  = 3;
localparam LEN_WIDTH   = 8;
localparam BURST_WIDTH = 2;
localparam PRODUCT_ID = 32'h00133010;
localparam FIFO_WIDTH = ID_WIDTH + ADDR_WIDTH + SIZE_WIDTH + BURST_WIDTH + LEN_WIDTH + CACHE_WIDTH + PROT_WIDTH + QOS_WIDTH + REGION_WIDTH + 1;

localparam IDLE		= 0;
localparam SEND_RW_LOCK	= 1;
localparam SEND_AR_LOCK	= 2;
localparam WAIT_AW_SEND = 3;
localparam SEND_AW_LOCK	= 4;
localparam WAIT_RW_PENDING = 5;
localparam WAIT_AR_PENDING = 6;
localparam WAIT_AW_PENDING = 7;
localparam WAIT_RW_RESP = 8;
localparam WAIT_AR_RESP = 9;
localparam WAIT_AW_RESP = 10;
localparam SEND_WDATA   = 11;
localparam WAIT_AW_ARREADY = 12;
localparam WAIT_AR_AWREADY = 13;
localparam STATES	= 14;

input                             aclk;
input                             aresetn;
input            [(ID_WIDTH-1):0] us_awid;
input            [ADDR_WIDTH-1:0] us_awaddr;
input                             us_awlock;
input                       [1:0] us_awburst;
input                       [7:0] us_awlen;
input	        [CACHE_WIDTH-1:0] us_awcache;
input	 	 [PROT_WIDTH-1:0] us_awprot;
input                       [2:0] us_awsize;
input		  [QOS_WIDTH-1:0] us_awqos;
input	       [REGION_WIDTH-1:0] us_awregion;
input                             us_awvalid;
output                            us_awready;

input	  	 [DATA_WIDTH-1:0] us_wdata;
input        [(DATA_WIDTH/8)-1:0] us_wstrb;
input                             us_wlast;
input                             us_wvalid;
output	  			  us_wready;

output                      [1:0] us_bresp;
output           [(ID_WIDTH-1):0] us_bid;
output                            us_bvalid;
input                             us_bready;


input            [(ID_WIDTH-1):0] us_arid;
input            [ADDR_WIDTH-1:0] us_araddr;
input                             us_arlock;
input                       [1:0] us_arburst;
input                       [7:0] us_arlen;
input	        [CACHE_WIDTH-1:0] us_arcache;
input	         [PROT_WIDTH-1:0] us_arprot;
input                       [2:0] us_arsize;
input		  [QOS_WIDTH-1:0] us_arqos;
input	       [REGION_WIDTH-1:0] us_arregion;
input                             us_arvalid;
output				  us_arready;

output           [(ID_WIDTH-1):0] us_rid;
output                      [1:0] us_rresp;
output	  	 [DATA_WIDTH-1:0] us_rdata;
output	  			  us_rlast;
output	  			  us_rvalid;
input                             us_rready;

output	  	 [(ID_WIDTH-1):0] ds_awid;
output		 [ADDR_WIDTH-1:0] ds_awaddr;
output	  		 	  ds_awlock;
output	  		    [1:0] ds_awburst;
output	  		    [7:0] ds_awlen;
output	        [CACHE_WIDTH-1:0] ds_awcache;
output	  	 [PROT_WIDTH-1:0] ds_awprot;
output	  		    [2:0] ds_awsize;
output		  [QOS_WIDTH-1:0] ds_awqos;
output	       [REGION_WIDTH-1:0] ds_awregion;
output	  			  ds_awvalid;
input                             ds_awready;

output	  	 [DATA_WIDTH-1:0] ds_wdata;
output       [(DATA_WIDTH/8)-1:0] ds_wstrb;
output	  			  ds_wlast;
output	  			  ds_wvalid;
input				  ds_wready;

input                       [1:0] ds_bresp;
input            [(ID_WIDTH-1):0] ds_bid;
input                             ds_bvalid;
output                            ds_bready;

output	  	 [(ID_WIDTH-1):0] ds_arid;
output	  	 [ADDR_WIDTH-1:0] ds_araddr;
output	  			  ds_arlock;
output	  		    [1:0] ds_arburst;
output	  		    [7:0] ds_arlen;
output	        [CACHE_WIDTH-1:0] ds_arcache;
output	  	 [PROT_WIDTH-1:0] ds_arprot;
output	  		    [2:0] ds_arsize;
output		  [QOS_WIDTH-1:0] ds_arqos;
output	       [REGION_WIDTH-1:0] ds_arregion;
output	  			  ds_arvalid;
input                             ds_arready;

input	 	 [(ID_WIDTH-1):0] ds_rid;
input                       [1:0] ds_rresp;
input	  	 [DATA_WIDTH-1:0] ds_rdata;
input                             ds_rlast;
input                             ds_rvalid;
output                            ds_rready;

wire 		 [NUM_EX_SEQ-1:0] ent_valid;
wire  		 [NUM_EX_SEQ-1:0] s0;
wire  		 [NUM_EX_SEQ-1:0] s1;
wire			          s2;
wire  [(NUM_EX_SEQ*ID_WIDTH)-1:0] ent_id;
wire  		 [NUM_EX_SEQ-1:0] dec_err;
wire 		 [NUM_EX_SEQ-1:0] match_exclusive;
wire		 [NUM_EX_SEQ-1:0] s3;
wire		 [NUM_EX_SEQ-1:0] s4;
wire		 [NUM_EX_SEQ-1:0] s5;
wire		 [NUM_EX_SEQ-1:0] s6;
wire		 	          s7;
wire			    [1:0] s8;
wire			          s9;
wire	         [NUM_EX_SEQ-1:0] s10;

wire				  s11;
wire               [ID_WIDTH-1:0] s12;
wire 		 [ADDR_WIDTH-1:0] s13;
wire 		 [SIZE_WIDTH-1:0] s14;
wire 	        [BURST_WIDTH-1:0] s15;
wire 		  [LEN_WIDTH-1:0] s16;
wire 	        [CACHE_WIDTH-1:0] s17;
wire 	 	 [PROT_WIDTH-1:0] s18;
wire 	 	  [QOS_WIDTH-1:0] s19;
wire 	       [REGION_WIDTH-1:0] s20;

wire				  s21;
wire               [ID_WIDTH-1:0] s22;
wire 		 [ADDR_WIDTH-1:0] s23;
wire 		 [SIZE_WIDTH-1:0] s24;
wire 	        [BURST_WIDTH-1:0] s25;
wire 		  [LEN_WIDTH-1:0] s26;
wire 	        [CACHE_WIDTH-1:0] s27;
wire 	 	 [PROT_WIDTH-1:0] s28;
wire 	 	  [QOS_WIDTH-1:0] s29;
wire 	       [REGION_WIDTH-1:0] s30;

wire                              s31;
wire                              s32;
wire				  s33;
wire				  s34;
wire				  s35;
wire				  s36;
wire				  s37;
wire				  s38;
wire				  s39;
wire				  s40;
wire				  s41;
wire				  s42;
reg				  s43;
reg				  s44;

wire		 [FIFO_WIDTH-1:0] s45;
wire		 		  s46;
reg		 [FIFO_WIDTH-1:0] s47;
wire		 [FIFO_WIDTH-1:0] s48;
wire		 		  s49;
reg		 [FIFO_WIDTH-1:0] s50;
wire		 		  s51;
wire		 		  s52;

wire				  s53;
wire				  s54;
wire				  s55;
wire				  s56;
wire				  s57;
wire				  s58;
wire				  s59;
wire				  s60;
wire				  s61;

wire 				  s62;
wire 				  s63;
wire 				  s64;
wire				  s65;
wire				  s66;
wire				  s67;
wire				  s68;
wire 				  s69;

reg		     [STATES-1:0] s70;
reg        	     [STATES-1:0] s71;
reg        	                  s72;
wire				  s73;
wire                              s74;
wire                              s75;
wire                              s76;
wire                              s77;
wire				  s78;
wire				  s79;
wire				  s80;
wire				  s81;
wire				  s82;
wire				  s83;

assign s53 = us_awvalid & us_awready & ~us_awlock;
assign s54 = ds_wvalid & ds_wready & ds_wlast & ~s77;
atcexmon300_pending_cnt #(
	.WIDTH	(PENDING_CNT		)
	) u_aw_d_pending_cnt (
	.clk            (aclk				),
	.reset_n        (aresetn			),
	.increase       (s53		),
	.decrease       (s54		),
	.full           (s55		),
	.zero           (s56		)
);

assign s57 = us_awvalid & us_awready & ~us_awlock;
assign s58 = us_bvalid & us_bready & ~s78;
atcexmon300_pending_cnt #(
	.WIDTH	(PENDING_CNT		)
	) u_aw_r_pending_cnt (
	.clk            (aclk				),
	.reset_n        (aresetn			),
	.increase       (s57		),
	.decrease       (s58		),
	.full           (s59		),
	.zero           (s60		)
);

assign s52 = us_awvalid & us_awready & us_awlock;
assign s48 = {us_awlock, us_awid, us_awaddr, us_awsize, us_awburst, us_awlen, us_awcache, us_awprot, us_awqos, us_awregion};
assign s49 = us_awvalid & us_awready;

assign {s11,
	s12,
	s13,
	s14,
	s15,
	s16,
	s17,
	s18,
	s19,
	s20
	}  = s50;

always @(posedge aclk or negedge aresetn) begin
        if (!aresetn)
		s50 <= {(FIFO_WIDTH){1'b0}};
	else if (s49)
		s50 <= s48;
end

always @(posedge aclk or negedge aresetn) begin
        if (!aresetn)
		s44 <= 1'b0;
	else
		s44 <= us_awvalid & us_awready & ~us_awlock;
end

assign s65 = us_arvalid & us_arready & ~us_arlock;
assign s66 = ds_rvalid & us_rready & ds_rlast & ~(s31);
atcexmon300_pending_cnt #(
	.WIDTH	(PENDING_CNT		)
	) u_ar_pending_cnt (
	.clk            (aclk				),
	.reset_n        (aresetn			),
	.increase       (s65			),
	.decrease       (s66			),
	.full           (s67		),
	.zero           (s61		)
);

assign s51 = us_arvalid & us_arready & us_arlock;
assign s45 = {us_arlock, us_arid, us_araddr, us_arsize, us_arburst, us_arlen, us_arcache, us_arprot, us_arqos, us_arregion};
assign s46 = us_arvalid & us_arready;

assign {s21,
	s22,
	s23,
	s24,
	s25,
	s26,
	s27,
	s28,
	s29,
	s30
	}  = s47;


always @(posedge aclk or negedge aresetn) begin
        if (!aresetn)
		s47 <= {(FIFO_WIDTH){1'b0}};
	else if (s46)
		s47 <= s45;
end

assign s73		= s70[IDLE];
assign s74	= s70[SEND_RW_LOCK];
assign s75	= s70[SEND_AR_LOCK];
assign s76	= s70[SEND_AW_LOCK];
assign s78 = s70[WAIT_AW_RESP];
assign s79 = s70[WAIT_AW_SEND];
assign s77   = s70[SEND_WDATA];
assign s80 = s70[WAIT_AR_RESP];
assign s81 = s70[WAIT_RW_RESP];
assign s82 = s70[WAIT_AW_ARREADY];
assign s83 = s70[WAIT_AR_AWREADY];

assign s31	 = s80 | s81;
assign s32 = s61 & s60;
assign s36	 = s32 & ~us_awvalid;
assign s37     = s32 & ~us_arvalid;

assign s33  = s51  & s52 &  s32;
assign s34  = s51  & s36;
assign s35  = s52 & s37;
assign s38  = s51  & s52 & ~s32;
assign s39  = s51  & ~s36;
assign s41  = s52 & ~s37;
assign s40 = s51  & (us_awvalid & ~us_awready);
assign s42 = s52 & (us_arvalid & ~us_arready);

assign s64 = ds_rvalid & us_rready & ds_rlast;
assign s62 = ds_bvalid & us_bready;
assign s63    = ds_wready & ds_wvalid & ds_wlast;

always @* begin
	s71 = {STATES{1'b0}};
	case (1'b1)
	s70[IDLE]: begin
		if (s33) begin
			s71[SEND_RW_LOCK] = 1'b1;
			s72 = 1'b1;
		end
		else if (s34) begin
			s71[SEND_AR_LOCK] = 1'b1;
			s72 = 1'b1;
		end
		else if (s35) begin
			s71[WAIT_AW_SEND] = 1'b1;
			s72 = 1'b1;
		end
		else if (s38) begin
			s71[WAIT_RW_PENDING] = 1'b1;
			s72 = 1'b1;
		end
		else if (s40) begin
			s71[WAIT_AR_AWREADY] = 1'b1;
			s72 = 1'b1;
		end
		else if (s42) begin
			s71[WAIT_AW_ARREADY] = 1'b1;
			s72 = 1'b1;
		end
		else if (s39) begin
			s71[WAIT_AR_PENDING] = 1'b1;
			s72 = 1'b1;
		end
		else if (s41) begin
			s71[WAIT_AW_PENDING] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_AW_SEND]: begin
		s71[SEND_AW_LOCK] = 1'b1;
		s72 = 1'b1;
	end
	s70[WAIT_AR_AWREADY]: begin
		if (us_awready & us_awlock) begin
			s71[WAIT_RW_PENDING] = 1'b1;
			s72 = 1'b1;
		end
		else if (us_awready & ~us_awlock) begin
			s71[WAIT_AR_PENDING] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_AW_ARREADY]: begin
		if (us_arready & us_arlock) begin
			s71[WAIT_RW_PENDING] = 1'b1;
			s72 = 1'b1;
		end
		else if (us_arready & ~us_arlock) begin
			s71[WAIT_AW_PENDING] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_RW_PENDING]: begin
		if (s32) begin
			s71[SEND_RW_LOCK] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_AR_PENDING]: begin
		if (s32) begin
			s71[SEND_AR_LOCK] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_AW_PENDING]: begin
		if (s32) begin
			s71[SEND_AW_LOCK] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[SEND_RW_LOCK]: begin
		if (ds_arready) begin
			s71[WAIT_RW_RESP] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[SEND_AR_LOCK]: begin
		if (ds_arready) begin
			s71[WAIT_AR_RESP] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[SEND_AW_LOCK]: begin
		if (ds_awready) begin
			s71[SEND_WDATA] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[SEND_WDATA]: begin
		if (s63) begin
			s71[WAIT_AW_RESP] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_RW_RESP]: begin
		if (s64) begin
			s71[SEND_AW_LOCK] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_AR_RESP]: begin
		if (s64) begin
			s71[IDLE] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	s70[WAIT_AW_RESP]: begin
		if (s62) begin
			s71[IDLE] = 1'b1;
			s72 = 1'b1;
		end
		else begin
			s72 = 1'b0;
		end
	end
	default: begin
		s71 = {STATES{1'b0}};
		s72 = 1'b0;
	end
	endcase
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s70 <= {{(STATES-1){1'b0}}, 1'b1};
	else if (s72)
		s70 <= s71;
end

assign s68 = s75 | s74;
assign s69 = s76;

assign ds_arvalid = us_arvalid & (s73 | s82) & ~us_arlock & ~s67
		  | s68
		  ;
assign ds_awvalid = us_awvalid & (s73 | s83) & ~us_awlock & ~s59
		  | s69
		  ;
assign us_arready = ds_arready & (s73 | s82) & ~s67;
assign us_awready = ds_awready & (s73 | s83) & ~s59;

assign	ds_awqos	= s69 ? s19	 : us_awqos	;
assign	ds_awregion	= s69 ? s20 : us_awregion	;
assign	ds_awid		= s69 ? s12	 : us_awid	;
assign	ds_awaddr	= s69 ? s13	 : us_awaddr	;
assign	ds_awburst	= s69 ? s15	 : us_awburst	;
assign	ds_awlen	= s69 ? s16	 : us_awlen	;
assign	ds_awcache	= s69 ? s17	 : us_awcache	;
assign	ds_awprot	= s69 ? s18	 : us_awprot	;
assign	ds_awsize	= s69 ? s14	 : us_awsize	;
assign	ds_awlock	= 1'b0;

assign	ds_wdata	= us_wdata;
assign	ds_wlast	= us_wlast;
assign	ds_wvalid	= us_wvalid & (~s56 | s77);
assign	us_wready	= ds_wready & (~s56 | s77);

assign	ds_arqos	= s68 ? s29	 :  us_arqos	;
assign	ds_arregion	= s68 ? s30 :  us_arregion ;
assign	ds_arid		= s68 ? s22	 :  us_arid	;
assign	ds_araddr	= s68 ? s23   :  us_araddr	;
assign	ds_arburst	= s68 ? s25  :  us_arburst  ;
assign	ds_arlen	= s68 ? s26	 :  us_arlen	;
assign	ds_arcache	= s68 ? s27  :  us_arcache  ;
assign	ds_arprot	= s68 ? s28   :  us_arprot	;
assign	ds_arsize	= s68 ? s24   :  us_arsize	;
assign	ds_arlock	= 1'b0;

assign  us_rid		= ds_rid;
assign	us_rdata	= ds_rdata;
assign	us_rlast	= ds_rlast;
assign	us_rvalid	= ds_rvalid;
assign	ds_rready	= us_rready;

assign  ds_bready	= us_bready;
assign  us_bvalid	= ds_bvalid;
assign  us_bid		= ds_bid;

assign s2         = ds_rvalid & us_rready & ds_rlast & ~ds_rresp[1] & s31 & ~(|s26);
assign s7 = (|s3);
assign s9    = ds_bvalid & us_bready & s43 & s78;

generate
genvar i;
for (i=0; i<NUM_EX_SEQ; i=i+1) begin : gen_ent
	atcexmon300_ent #(
		.FIFO_WIDTH      (FIFO_WIDTH		                ),
		.SIZE_WIDTH      (SIZE_WIDTH		                ),
		.ADDR_WIDTH	 (ADDR_WIDTH				),
		.DATA_WIDTH	 (DATA_WIDTH				),
		.ID_WIDTH	 (ID_WIDTH		                ),
		.BURST_WIDTH     (BURST_WIDTH		                ),
		.CACHE_WIDTH	 (CACHE_WIDTH		                ),
		.QOS_WIDTH	 (QOS_WIDTH		                ),
		.REGION_WIDTH	 (REGION_WIDTH		                ),
		.PROT_WIDTH      (PROT_WIDTH		                ),
		.LEN_WIDTH       (LEN_WIDTH		                )
		) u_monitor_ent		(
                .aclk			(aclk                                   ),
		.reset_n		(aresetn	                        ),
		.norm_clr		(s44				),
		.exok_clr		(s9				),
		.dec_err		(dec_err[i]				),
		.set			(s0[i]				),
		.exclusive_rdata	(s47				),
		.exclusive_wdata	(s50				),
		.match_exclusive	(match_exclusive[i]			),
		.ent_id			(ent_id[i*ID_WIDTH+:ID_WIDTH]		),
		.ent_valid		(ent_valid[i]				)
	);
	assign s6[i] = (s22 == ent_id[i*ID_WIDTH+:ID_WIDTH]);
	assign s3[i]   = s6[i] & ent_valid[i];
	assign dec_err[i] = ds_rvalid & us_rready & ds_rlast & ds_rresp[1] & s31 & s6[i];
	assign s1[i] = ( s3[i])
			  | (~s7 & s5[i] & (&ent_valid))
			  | (~s7 & s4[i])
			  ;
	assign s0[i] = s2 & s1[i];
end
endgenerate

atcexmon300_arb_fp #(
	.N	(NUM_EX_SEQ	)
	) u_arb_ent (
	.valid	(~ent_valid	),
	.ready	(s10	),
	.grant	(s4	)
);

atcexmon300_lfsr #(
	.N	(NUM_EX_SEQ	)
	) u_arb_lfsr (
	.resetn	(aresetn	),
	.clk	(aclk		),
	.update	(s51	),
	.grant	(s5	)
);

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s43 <= 1'b0;
	else
		s43 <= (|match_exclusive);
end

assign s8 = {1'b0,  s43};
assign us_rresp = (s31 & ~ds_rresp[1]) ?  2'b01 : ds_rresp;
assign us_bresp = ((s77 | s78) & ~ds_bresp[1])  ? s8 : ds_bresp;
assign ds_wstrb = (s77 & ~s43) ? ({(DATA_WIDTH/8){1'b0}}) : (us_wstrb);

endmodule

