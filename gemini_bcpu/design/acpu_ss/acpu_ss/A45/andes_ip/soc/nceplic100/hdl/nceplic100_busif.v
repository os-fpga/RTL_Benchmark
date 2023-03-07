// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module nceplic100_busif (
		  awid,
		  awaddr,
		  awlen,
		  awsize,
		  awburst,
		  awlock,
		  awcache,
		  awprot,
		  awvalid,
		  awready,
		  arid,
		  araddr,
		  arlen,
		  arsize,
		  arburst,
		  arlock,
		  arcache,
		  arprot,
		  arvalid,
		  arready,
		  wdata,
		  wstrb,
		  wlast,
		  wvalid,
		  wready,
		  bid,
		  bresp,
		  bvalid,
		  bready,
		  rid,
		  rdata,
		  rresp,
		  rlast,
		  rvalid,
		  rready,
		  htrans,
		  hsize,
		  hburst,
		  haddr,
		  hsel,
		  hwrite,
		  hwdata,
		  hready,
		  hreadyout,
		  hrdata,
		  hresp,
		  clk,
		  reset_n,
		  req_valid,
		  req_hit_dep,
		  dep_delay_wr,
		  req_wr,
		  req_addr,
		  req_region_sel,
		  rd_data,
		  wr_data
);
parameter 			INT_NUM		= 63;
parameter 			TARGET_NUM	= 16;
parameter			MAX_PRIORITY	= 15;
parameter			ADDR_WIDTH	= 32;
parameter			DATA_WIDTH	= 32;
parameter			PLIC_BUS	= "axi";
parameter                       ID_WIDTH	= 4;

parameter			BIT_REGION_SOURCE_PRIORITY	= 7;
parameter			BIT_REGION_INTERRUPT_PENDING	= 6;
parameter			BIT_REGION_TARGET_ENABLE	= 5;
parameter			BIT_REGION_TARGET_THRESHOLD	= 4;
parameter			BIT_REGION_PREEMPTIVE_STACK	= 3;
parameter			BIT_REGION_FEATURE		= 2;
parameter			BIT_REGION_TRIGGER_TYPE		= 1;
parameter			BIT_REGION_CONFIG		= 0;

localparam 			INTERNAL_TARGET_NUM		= TARGET_NUM - 1;

localparam 			TARGET_ENABLE_WORD_NUM		= INT_NUM >> 5;
localparam			VALID_MAX_PRIORITY	 	= (MAX_PRIORITY <=   3) ?   3 :
								  (MAX_PRIORITY <=   7) ?   7 :
								  (MAX_PRIORITY <=  15) ?  15 :
								  (MAX_PRIORITY <=  31) ?  31 :
								  (MAX_PRIORITY <=  63) ?  63 :
								  (MAX_PRIORITY <= 127) ? 127 :
											  255 ;
localparam 			PREEMPTED_WORD_NUM		= (VALID_MAX_PRIORITY <=  31 ) ? 0 :
					     	  		  (VALID_MAX_PRIORITY ==  63 ) ? 1 :
					          		  (VALID_MAX_PRIORITY ==  127) ? 3 : 7;


localparam		IDLE 		= 2'b00;
localparam		READ_WAIT1	= 2'b01;
localparam		READ_WAIT2	= 2'b10;
localparam		DEP_WAIT	= 2'b11;

localparam 		SOURCE_PRIORITY_REGION_BASE 		= 10'b0;
localparam 		INTERRUPT_PENDING_REGION_BASE 		= 15'h0020;
localparam 		TARGET_ENABLE_REGION_BASE 		= 11'h004;
localparam 		TARGET_THRESHOLD_REGION_BASE 		= 6'h20;
localparam		FEATURE_BASE				= 20'b0;
localparam		TRIGGER_TYPE_BASE			= 15'h021;
localparam		CONFIG_BASE				= 19'h0220;



localparam	[7:0]	AXI_LEN_1				= 8'b0;
localparam	[2:0]	AXI_SIZE_WORD				= 3'b010;
localparam	[2:0]	AXI_SIZE_DWORD				= 3'b011;
localparam	[1:0]	AXI_BURST_RSVD				= 2'b11;

localparam		SLVERR	= 2'b10;
localparam		OKAY	= 2'b00;

localparam 		AXI_REQ_FIFO_ADDR_WIDTH			= 20;
localparam 		AXI_REQ_FIFO_ID_WIDTH			= ID_WIDTH;
localparam 		AXI_REQ_FIFO_WR_WIDTH			= 1;
localparam 		AXI_REQ_FIFO_REGION_SEL_WIDTH		= 8;
localparam 		AXI_REQ_FIFO_SLVERR_WIDTH		= 1;
localparam 		AXI_REQ_FIFO_LENGTH_WIDTH		= 8;
localparam		AXI_REQ_FIFO_WIDTH			= AXI_REQ_FIFO_ADDR_WIDTH + AXI_REQ_FIFO_ID_WIDTH + AXI_REQ_FIFO_WR_WIDTH + AXI_REQ_FIFO_REGION_SEL_WIDTH + AXI_REQ_FIFO_SLVERR_WIDTH + AXI_REQ_FIFO_LENGTH_WIDTH;
localparam		AXI_REQ_FIFO_DEPTH			= 2;
localparam		AXI_REQ_FIFO_POINTER_INDEX_WIDTH	= 2;

localparam		AXI_REQ_FIFO_LENGTH_LSB			= 0;
localparam		AXI_REQ_FIFO_LENGTH_MSB			= AXI_REQ_FIFO_LENGTH_LSB+AXI_REQ_FIFO_LENGTH_WIDTH-1;
localparam		AXI_REQ_FIFO_SLVERR_BIT			= AXI_REQ_FIFO_LENGTH_MSB+1;
localparam		AXI_REQ_FIFO_REGION_SEL_LSB		= AXI_REQ_FIFO_SLVERR_BIT+1;
localparam		AXI_REQ_FIFO_REGION_SEL_MSB		= AXI_REQ_FIFO_REGION_SEL_LSB+AXI_REQ_FIFO_REGION_SEL_WIDTH-1;
localparam		AXI_REQ_FIFO_WRITE_BIT			= AXI_REQ_FIFO_REGION_SEL_MSB+1;
localparam		AXI_REQ_FIFO_ID_LSB			= AXI_REQ_FIFO_WRITE_BIT+1;
localparam		AXI_REQ_FIFO_ID_MSB			= AXI_REQ_FIFO_ID_LSB+AXI_REQ_FIFO_ID_WIDTH-1;
localparam		AXI_REQ_FIFO_ADDR_LSB			= AXI_REQ_FIFO_ID_MSB+1;
localparam		AXI_REQ_FIFO_ADDR_MSB			= AXI_REQ_FIFO_ADDR_LSB+AXI_REQ_FIFO_ADDR_WIDTH-1;

localparam		AXI_W_CH_FIFO_WDATA_WIDTH	  	= DATA_WIDTH;
localparam		AXI_W_CH_FIFO_BYTE_WEN_WIDTH	  	= (DATA_WIDTH/8);
localparam		AXI_W_CH_FIFO_WIDTH		  	= AXI_W_CH_FIFO_WDATA_WIDTH + AXI_W_CH_FIFO_BYTE_WEN_WIDTH;
localparam		AXI_W_CH_FIFO_DEPTH		  	= 2;
localparam		AXI_W_CH_FIFO_POINTER_INDEX_WIDTH 	= 2;

localparam		AXI_W_CH_FIFO_WDATA_LSB			= 0;
localparam		AXI_W_CH_FIFO_WDATA_MSB			= AXI_W_CH_FIFO_WDATA_LSB+AXI_W_CH_FIFO_WDATA_WIDTH-1;
localparam		AXI_W_CH_FIFO_BYTE_WEN_LSB		= AXI_W_CH_FIFO_WDATA_MSB+1;
localparam		AXI_W_CH_FIFO_BYTE_WEN_MSB		= AXI_W_CH_FIFO_BYTE_WEN_LSB+AXI_W_CH_FIFO_BYTE_WEN_WIDTH-1;

localparam		AXI_B_CH_FIFO_ID_WIDTH		  	= ID_WIDTH;
localparam		AXI_B_CH_FIFO_SLVERR_WIDTH	  	= 1;
localparam		AXI_B_CH_FIFO_WIDTH		  	= AXI_B_CH_FIFO_ID_WIDTH + AXI_B_CH_FIFO_SLVERR_WIDTH;
localparam		AXI_B_CH_FIFO_DEPTH		  	= 2;
localparam		AXI_B_CH_FIFO_POINTER_INDEX_WIDTH 	= 2;

localparam		AXI_B_CH_FIFO_ID_LSB			= 0;
localparam		AXI_B_CH_FIFO_ID_MSB			= AXI_B_CH_FIFO_ID_LSB+AXI_B_CH_FIFO_ID_WIDTH-1;
localparam		AXI_B_CH_FIFO_SLVERR_BIT		= AXI_B_CH_FIFO_ID_MSB+1;

input	[(ID_WIDTH-1):0]	awid;
input	[(ADDR_WIDTH-1):0]	awaddr;
input	[7:0]			awlen;
input	[2:0]			awsize;
input	[1:0]			awburst;
input				awlock;
input	[3:0]			awcache;
input	[2:0]			awprot;
input				awvalid;
output				awready;

input	[(ID_WIDTH-1):0]	arid;
input	[(ADDR_WIDTH-1):0]	araddr;
input	[7:0]			arlen;
input	[2:0]			arsize;
input	[1:0]			arburst;
input				arlock;
input	[3:0]			arcache;
input	[2:0]			arprot;
input				arvalid;
output				arready;

input	[(DATA_WIDTH-1):0]	wdata;
input	[((DATA_WIDTH/8)-1):0]	wstrb;
input				wlast;
input				wvalid;
output				wready;

output	[(ID_WIDTH-1):0]	bid;
output	[1:0]			bresp;
output				bvalid;
input				bready;

output	[(ID_WIDTH-1):0]	rid;
output	[(DATA_WIDTH-1):0]	rdata;
output	[1:0]			rresp;
output				rlast;
output				rvalid;
input				rready;

input 	[1:0]			htrans;
input 	[2:0]			hsize;
input 	[2:0]			hburst;
input	[(ADDR_WIDTH-1):0]	haddr;
input				hsel;
input				hwrite;
input	[(DATA_WIDTH-1):0]	hwdata;
input				hready;
output				hreadyout;
output	[(DATA_WIDTH-1):0]	hrdata;
output	[1:0]			hresp;

input				clk;
input				reset_n;

output				req_valid;
output				req_hit_dep;
output				dep_delay_wr;
output				req_wr;
output  [21:2]			req_addr;
output	[7:0]			req_region_sel;
input	[31:0]			rd_data;
output	[31:0]			wr_data;

wire	[31:0] 			s0;
wire	[DATA_WIDTH-1:0]	s1;
wire	[((DATA_WIDTH/8)-1):0]	s2;
wire				s3;
wire	[21:2] 			s4;
wire	[3:0]			s5;

wire	[31:0]			s6;
wire	[31:0]			s7;

generate
if (PLIC_BUS == "axi") begin: gen_axi_plic
	wire 	[7:0]				s8			= addr_predecode(araddr[21:2]);
	wire					s9			= (araddr[1:0] != 2'b00) | (arlen != AXI_LEN_1) | (arsize != AXI_SIZE_WORD) | (arburst == AXI_BURST_RSVD);
	wire 	[7:0] 				s10			= addr_predecode(awaddr[21:2]);
	wire					s11			= (awaddr[1:0] != 2'b00) | (awlen != AXI_LEN_1) | ~((awsize == AXI_SIZE_WORD) | (awsize == AXI_SIZE_DWORD)) | (awburst == AXI_BURST_RSVD);

	wire	[21:2]  			s12;
	wire    [(ID_WIDTH-1):0]		s13;
	wire					s14;
	wire	[7:0]				s15;
	wire					s16;
	wire	[7:0]				s17;
	wire	[(AXI_REQ_FIFO_WIDTH-1):0]	s18;

	wire					s19;
	wire					s20;

	wire	[21:2]  			s21;
	wire    [(ID_WIDTH-1):0]		s22;
	wire					s23;
	wire	[7:0]				s24;
	wire					s25;
	wire	[7:0]				s26;
	wire					s27;

	wire	[(AXI_REQ_FIFO_WIDTH-1):0]	s28;

	wire					s29;
	wire					s30;

	wire					s31;

	reg					s32;
	wire					s33;
	wire					s34;
	wire					s35;

	wire					s36;
	wire					s37;
	wire					s38;

	wire					s39;
	wire					s40;

	wire					s41;
	wire					s42;

	wire					s43;
	wire					s44;
	wire					s45;
	wire	[DATA_WIDTH-1:0]		s46;
	wire	[((DATA_WIDTH/8)-1):0]		s47;
	wire	[DATA_WIDTH-1:0]		s48;
	wire	[((DATA_WIDTH/8)-1):0]		s49;
	wire	[AXI_W_CH_FIFO_WIDTH-1:0]	s50;
	wire	[AXI_W_CH_FIFO_WIDTH-1:0]	s51;

	reg					s52;
	reg					s53;

	wire					s54;
	wire					s55;

	wire    [(ID_WIDTH-1):0]		s56;
	wire	[31:0]				s57;
	wire					s58;
	wire	[7:0]				s59;

	wire					s60;

	wire    [(ID_WIDTH-1):0]		s61;
	wire					s62;
	wire	[7:0]				s63;
	wire	[31:0]				s64;

	wire	[7:0]				s65;

	reg     [(ID_WIDTH-1):0]		s66;
	reg	[31:0]				s67;
	reg					s68;

	reg					s69;
	wire					s70;
	wire					s71;
	wire					s72;

	reg	[7:0]				s73;
	wire	[7:0]				s74;
	wire					s75;
	wire					s76;


	reg     [(ID_WIDTH-1):0]		s77;
	reg	[31:0]				s78;
	reg					s79;

	reg					s80;
	wire					s81;
	wire					s82;
	wire					s83;

	reg	[7:0]				s84;
	wire	[7:0]				s85;
	wire					s86;
	wire					s87;

	wire					s88;
	wire    [(ID_WIDTH-1):0]		s89;
	wire					s90;

	wire					s91;
	wire					s92;
	wire    [(ID_WIDTH-1):0]		s93;
	wire					s94;
	wire					s95;
	wire					s96;
	wire	[AXI_B_CH_FIFO_WIDTH-1:0]	s97;
	wire	[AXI_B_CH_FIFO_WIDTH-1:0]	s98;


	reg	[3:0]				s99;
	reg	[1:0]				s100;
	wire					s101;
	wire					s102;
	reg					s103;

	reg	[3:0]				s104;
	reg	[1:0]				s105;
	wire					s106;
	wire					s107;
	reg					s108;

	reg					s109;
	wire					s110;
	wire	[3:0]				s111;

	wire					s112;
	assign s19 = (arvalid & arready) | (awvalid & awready);
	assign s20 = s54 | s95;

	assign arready = ~s29 & ~s32;
	assign awready = ~s29 &  s32;

	assign s31 = awvalid & awready;

	assign s12		= s31 ? awaddr[21:2]  : araddr[21:2];
	assign s13		= s31 ? awid 	  : arid;
	assign s15	= s31 ? s10 : s8;
	assign s16	= s31 ? s11     : s9;
	assign s17	= s31 ? awlen         : arlen;
	assign s14	= s31 ;


	assign s18[AXI_REQ_FIFO_ADDR_MSB	 : AXI_REQ_FIFO_ADDR_LSB      ] = s12;
        assign s18[AXI_REQ_FIFO_ID_MSB	 : AXI_REQ_FIFO_ID_LSB	      ] = s13;
        assign s18[AXI_REQ_FIFO_REGION_SEL_MSB: AXI_REQ_FIFO_REGION_SEL_LSB] = s15;
        assign s18[AXI_REQ_FIFO_LENGTH_MSB    : AXI_REQ_FIFO_LENGTH_LSB    ] = s17;
        assign s18[AXI_REQ_FIFO_WRITE_BIT				      ] = s14;
        assign s18[AXI_REQ_FIFO_SLVERR_BIT				      ] = s16;

	assign s21		= s28[AXI_REQ_FIFO_ADDR_MSB		:AXI_REQ_FIFO_ADDR_LSB];
	assign s22		= s28[AXI_REQ_FIFO_ID_MSB		:AXI_REQ_FIFO_ID_LSB];
	assign s24	= s28[AXI_REQ_FIFO_REGION_SEL_MSB	:AXI_REQ_FIFO_REGION_SEL_LSB];
	assign s26	= s28[AXI_REQ_FIFO_LENGTH_MSB	:AXI_REQ_FIFO_LENGTH_LSB];
	assign s23        = s28[AXI_REQ_FIFO_WRITE_BIT];
	assign s25	= s28[AXI_REQ_FIFO_SLVERR_BIT];
	assign s27		= ~s30;


	nds_sync_fifo_ll #(.DATA_WIDTH		(AXI_REQ_FIFO_WIDTH		 ),
			   .FIFO_DEPTH		(AXI_REQ_FIFO_DEPTH		 ),
			   .POINTER_INDEX_WIDTH	(AXI_REQ_FIFO_POINTER_INDEX_WIDTH)
		   	  ) req_fifo ( .w_reset_n	(reset_n	),
				       .r_reset_n	(reset_n	),
				       .w_clk		(clk		),
				       .r_clk		(clk		),
				       .wr		(s19	),
				       .wr_data		(s18	),
				       .rd		(s20	),
				       .rd_data		(s28	),
				       .w_clk_empty	(		),
				       .empty		(s30	),
				       .full		(s29	)
			             );

	assign s33 = (arvalid & arready) | (awvalid & ~awready & ~arvalid);
	assign s34 = (awvalid & awready) | (arvalid & ~arready & ~awvalid);
	assign s35 = s33 | (s32 & ~s34);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s32 <= 1'b0;
		else
			s32 <= s35;
	end

	assign s37 	= ~s25 & s24[BIT_REGION_TARGET_THRESHOLD] &  s23 & (s21[5:2] == 4'h1);
	assign s36 		= ~s25 & s24[BIT_REGION_TARGET_THRESHOLD] & ~s23 & (s21[5:2] == 4'h1);
	assign s38 	= ~s25 & s24[BIT_REGION_PREEMPTIVE_STACK] &  s23 ;

	assign s40 = s37 & ((s102 & (s21[15:12] == s99)) | (s107 & (s21[15:12] == s104)));
        assign s39    = s36 & ((s102 & s103) | (s107 & s108));

	assign s41 = wvalid & wlast & wready;
	assign s42 = s27 & s43 & s23 & ~s40 & ~s91;

	assign s43 	     = ~s45;
	assign s46    = s51[AXI_W_CH_FIFO_WDATA_MSB	 :AXI_W_CH_FIFO_WDATA_LSB   ];
	assign s47 = s51[AXI_W_CH_FIFO_BYTE_WEN_MSB:AXI_W_CH_FIFO_BYTE_WEN_LSB];
	assign s48    = wdata;
	assign s49 = wstrb;
	assign wready 		     = ~s44;

	assign s50[AXI_W_CH_FIFO_WDATA_MSB	 :AXI_W_CH_FIFO_WDATA_LSB   ] = s48;
	assign s50[AXI_W_CH_FIFO_BYTE_WEN_MSB:AXI_W_CH_FIFO_BYTE_WEN_LSB] = s49;


	nds_sync_fifo_ll #(	.DATA_WIDTH		(AXI_W_CH_FIFO_WIDTH		  ),
		   		.FIFO_DEPTH		(AXI_W_CH_FIFO_DEPTH		  ),
		   		.POINTER_INDEX_WIDTH	(AXI_W_CH_FIFO_POINTER_INDEX_WIDTH)
	   	  	  ) w_ch_fifo (	.w_reset_n	(reset_n	),
			       		.r_reset_n	(reset_n	),
			       		.w_clk		(clk		),
			       		.r_clk		(clk		),
			       		.wr		(s41	),
			       		.wr_data	(s50),
			       		.rd		(s42	),
			       		.rd_data	(s51),
			       		.w_clk_empty	(		),
			       		.empty		(s45),
			       		.full		(s44	)
		             	      );


	assign s54 = s27 & ~s23 & ~s60 & ~s39;
	assign s55 = rvalid & rlast & rready;

	assign s60 = s69 & s80;

	assign s56 = s22;
	assign s57 = rd_data;
	assign s58 = s25;
	assign s59 = s26;

	assign s65 = s63 - 8'b0000_0001;

	assign s61		= s52 ? s77 	   : s66;
	assign s62	= s52 ? s79 : s68;
	assign s63	= s52 ? s84 : s73;
	assign s64	= s52 ? s78  : s67;

	assign rvalid = s69 | s80;
	assign rresp = s62 ? SLVERR : OKAY;
	assign rlast = rvalid & (s63 == 8'b0);
	assign rid = s61;

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s52 <= 1'b0;
		else if (s55)
			s52 <= ~s52;
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s53 <= 1'b0;
		else if (s54)
			s53 <= ~s53;
	end
	assign s70 = s54 & ~s53;
	assign s71 = s55 & ~s52;
	assign s72  = s70 | (s69 & ~s71);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s69 <= 1'b0;
		else
			s69 <= s72;
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s66 <= {ID_WIDTH{1'b0}};
			s68 <= 1'b0;
		end
		else if (s70) begin
			s66 <= s56;
			s68 <= s58;
		end
	end
	always @(posedge clk) begin
		if (s70)
			s67 <= s57;
	end
	assign s75 = rvalid & rready & ~rlast & ~s52;
	assign s76 = s75 | s70;
	assign s74 = s75 ? s65 : s59;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s73 <= 8'b0;
		else if (s76)
			s73 <= s74;
	end
	assign s81 = s54 & s53;
	assign s82 = s55 & s52;
	assign s83  = s81 | (s80 & ~s82);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s80 <= 1'b0;
		else
			s80 <= s83;
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s77 <= {ID_WIDTH{1'b0}};
			s79 <= 1'b0;
		end
		else if (s81) begin
			s77 <= s56;
			s79 <= s58;
		end
	end
	always @(posedge clk) begin
		if (s81)
			s78 <= s57;
	end
	assign s86 = rvalid & rready & ~rlast & s52;
	assign s87 = s86 | s81;
	assign s85 = s86 ? s65 : s59;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s84 <= 8'b0;
		else if (s87)
			s84 <= s85;
	end

	assign s95 = s27 & s43 & s23 & ~s40 & ~s91;
	assign s96  = bvalid & bready;

	assign s93 		= s22;
	assign s94 	= s25 | s3;

	assign s97[AXI_B_CH_FIFO_ID_MSB:AXI_B_CH_FIFO_ID_LSB] = s93;
	assign s97[AXI_B_CH_FIFO_SLVERR_BIT]		  = s94;

	assign s89 	   = s98[AXI_B_CH_FIFO_ID_MSB:AXI_B_CH_FIFO_ID_LSB];
	assign s90 = s98[AXI_B_CH_FIFO_SLVERR_BIT];

	assign s88 = ~s92;

	assign bvalid = s88;
	assign bresp  = s90 ? SLVERR : OKAY;
	assign bid    = s89;

	nds_sync_fifo_ll #(	.DATA_WIDTH		(AXI_B_CH_FIFO_WIDTH		  ),
		   		.FIFO_DEPTH		(AXI_B_CH_FIFO_DEPTH		  ),
		   		.POINTER_INDEX_WIDTH	(AXI_B_CH_FIFO_POINTER_INDEX_WIDTH)
	   	  	  ) b_ch_fifo (	.w_reset_n	(reset_n	),
			       		.r_reset_n	(reset_n	),
			       		.w_clk		(clk		),
			       		.r_clk		(clk		),
			       		.wr		(s95 ),
			       		.wr_data	(s97),
			       		.rd		(s96	),
			       		.rd_data	(s98),
			       		.w_clk_empty	(		),
			       		.empty		(s92),
			       		.full		(s91	)
		             	      );


	assign s110 = req_valid & (s37 | s36 | s38);
	assign s111 = s21[15:12];
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s109 <= 1'b0;
		else if (s110)
			s109 <= ~s109;
	end
	assign s101 = s110 & ~s109;
	assign s102 = |s100;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s100[0] <= 1'b0;
		else if (s101)
			s100[0] <= 1'b1;
		else
			s100[0] <= 1'b0;
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s100[1] <= 1'b0;
		else if (s102)
			s100[1] <= s100[0];
	end
	always @(posedge clk) begin
		if (s101) begin
			s99   <= s111;
			s103 <= s36;
		end
	end
	assign s106 = s110 & s109;
	assign s107 = |s105;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s105[0] <= 1'b0;
		else if (s106)
			s105[0] <= 1'b1;
		else
			s105[0] <= 1'b0;
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s105[1] <= 1'b0;
		else if (s107)
			s105[1] <= s105[0];
	end
	always @(posedge clk) begin
		if (s106) begin
			s104   <= s111;
			s108 <= s36;
		end
	end

	assign s0 		= s64;
	assign s1 		= s46;
	assign s2 	= s47;
	assign s4 		= s21;
	assign req_valid	= s27 & ~s25 & ~s40 &  ~s39 & ((~s60 & ~s23) | (~s91 & s23 & s43 & s112));
	assign req_wr		= s23;

	assign s112 	= (s5 == 4'hF) & ~s3;
	assign req_region_sel	= s24;
	assign dep_delay_wr = 1'b0;
	assign req_hit_dep = 1'b0;
end
endgenerate

generate
if ((PLIC_BUS == "axi") && (DATA_WIDTH == 32)) begin: gen_axi_wr_data_32
	assign wr_data		= s1;
	assign s5	= s2;
	assign req_addr 	= s4;
	assign s3	= (s2 != 4'hF) & (s2 != 4'h0);

end
else if ((PLIC_BUS == "axi") && (DATA_WIDTH == 64)) begin: gen_axi_wr_data_64
	wire 		s113;
	wire [21:2] 	s114;
	wire		s115;

	assign s113  = (s2[7:4] == 4'hF);
	assign wr_data		 = s113 ? s1[63:32]     : s1[31:0];
	assign s5	 = s113 ? s2[7:4]    : s2[3:0];
	assign s114 = s113 ? {s4[21:3],1'b1} : s4;
	assign req_addr 	 = ~req_wr ? s4 : s114;
	assign s115	 = ~((s2 == 8'h0F) | (s2 == 8'hF0) | (s2 == 8'h00)) |
		                    (s4[2]  & (s2 == 8'h0F));
	assign s3	 = s115;
end
else begin: gen_unused_axi_wr_data
	assign s5			= 4'b0;
        assign s0           = 32'b0;
        assign s1           = {DATA_WIDTH{1'b0}};
        assign s2        = {(DATA_WIDTH/8){1'b0}};
        assign s4             = 20'b0;
	assign s3			= 1'b0;
end
endgenerate
generate
if ((PLIC_BUS == "axi") && (DATA_WIDTH == 32)) begin: gen_axi_rdata32
	assign rdata = s0;
end
else if ((PLIC_BUS == "axi") && (DATA_WIDTH == 64)) begin: gen_axi_rdata64
	assign rdata = {s0, s0};
end
endgenerate

generate
if (PLIC_BUS == "ahb") begin: gen_ahb_plic
	reg	[21:2]					s116;
	reg						s117;
	reg	[1:0]					s118;
	reg	[1:0]					s119;
	reg	[3:0]					s120;
	reg						s121;
	reg	[31:0]					s122;
	reg						s123;
	wire						s124;
	wire 	s125 = hsel & htrans[1] & (hsize == 3'b010);
	wire 	s126 = s125 & hready & (s119 == IDLE);
	wire	[7:0]	s127 			= addr_predecode(haddr[21:2]);
	wire		s128 		= s127[BIT_REGION_SOURCE_PRIORITY];
	reg		s129 ;
	wire		s130			= s127[BIT_REGION_INTERRUPT_PENDING];
	reg		s131;
	wire		s132	= s127[BIT_REGION_TARGET_ENABLE];
	reg		s133;
	wire		s134 		= s127[BIT_REGION_TARGET_THRESHOLD];
	reg		s135;
	wire		s136 	= s127[BIT_REGION_PREEMPTIVE_STACK];
	reg		s137;
	wire		s138			= s127[BIT_REGION_FEATURE];
	reg		s139;
	wire		s140		= s127[BIT_REGION_TRIGGER_TYPE];
	reg		s141;
	wire		s142			= s127[BIT_REGION_CONFIG];
	reg		s143;
	wire		s144 		= s128 | s130 | s132 | s134 | s140 | (s142 & ~hwrite) | s136;
	wire		s145 		= s144 & ~hwrite;
	wire		s146 		= s144 & hwrite;
	wire	s147		= (s119 == IDLE) & (s116[21:2] == haddr[21:2]) & hwrite & ~s117 & (s116[5:2] == 4'b1) & s134 & s126;
	wire	s148		= (s119 == IDLE) & (s116[21:2] == haddr[21:2]) & hwrite & s117 & (s116[5:2] == 4'b1) & s134 & s126;
	wire	s149		= (s119 == IDLE) & (s116[15:12] == haddr[15:12]) & hwrite & s117 & s137 & s134 & s126;
	wire	s150		= (s119 == IDLE) & (s120[3:0] == haddr[15:12]) & hwrite & s121 & s134 & s126 & ~s149 & ~s148 & ~s147;

	wire	s151;
	wire	s152;
	reg	s153;

	reg	[1:0]	s154;

	wire	s155		= s126 & s145 ;
	wire	s156		= s126 & ~hwrite;
	reg	s157;
	wire	s158 		= s126 & s146;
	reg	s159;
	reg	s160;
	wire	s161 	= s137 & s160;
	wire	s162	= s123 & s125 & ~hwrite;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s120 <= 4'b0;
		else if (s161)
			s120 <= s116[15:12];
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s121 <= 1'b0;
		else
			s121 <= s161;
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s154 <= 2'b0;
		end
		else begin
			s154 <= {s154[0],s152};
		end
	end

	assign s152 = (s147 & (VALID_MAX_PRIORITY > 31)) | s148 | s149 | s150;
	assign s151 	= s154[1];

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s129 		<= 1'b0;
			s135 	<= 1'b0;
			s133 	<= 1'b0;
			s139 		<= 1'b0;
			s131			<= 1'b0;
			s137 <= 1'b0;
			s143 			<= 1'b0;
			s141 		<= 1'b0;
			s153		<= 1'b0;
		end
		else if (s126) begin
			s129 		<= s128;
			s135 	<= s134;
			s133 	<= s132;
			s139 		<= s138;
			s131			<= s130;
			s137 <= s136;
			s143 			<= s142;
			s141 		<= s140;
			s153		<= s152;
		end
	end
	always @* begin
		case(s119)
			IDLE: begin
				if (s152)
					s118 =DEP_WAIT;
				else if (s156)
					s118 = READ_WAIT1;
				else
					s118 = IDLE;
			end
			READ_WAIT1: begin
				if (s162)
					s118 = READ_WAIT2;
				else
					s118 = IDLE;
			end
			READ_WAIT2: begin
					s118 = IDLE;
			end
			DEP_WAIT: begin
				if (s151)
					s118 = IDLE;
				else
					s118 = DEP_WAIT;
			end
			default : s118 = 2'b0;
		endcase
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s119 <= 2'b0;
		else
			s119 <= s118;
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s116 <= 20'b0;
			s117 <= 1'b0;
		end
		else if (s126) begin
			s116 <= haddr[21:2];
			s117 <= hwrite;
		end
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s122 <= 32'b0;
		else if (s157)
			s122 <= rd_data;
	end

	assign	s124 = s156 | (~hready & s123);

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			s123	<= 1'b0;
		else
			s123	<= s124;
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s159 <= 1'b0;
			s160 <= 1'b0;
			s157 <= 1'b0;
		end
		else begin
			s159 <= s155;
			s160 <= s158;
			s157 <= s156;
		end
	end
	assign	hreadyout = (s119 == IDLE);
	assign	s6 = s122;
	assign	hresp = 2'b0;

	assign req_valid 	= s159 | s160;
	assign req_hit_dep	= s153;
	assign dep_delay_wr 	= s151;
	assign req_wr    	= s160;
	assign req_addr		= s116;
	assign req_region_sel	= {	s129,
					s131,
					s133,
					s135,
					s137,
					s139,
					s141,
					s143};
	assign wr_data		= s7;
end
endgenerate

generate
if ((PLIC_BUS == "ahb") && (DATA_WIDTH == 32)) begin: gen_ahb_data32
	assign hrdata 		= s6;
	assign s7	= hwdata;
end
else if ((PLIC_BUS == "ahb") && (DATA_WIDTH == 64)) begin: gen_ahb_data64
	assign hrdata		= {s6, s6};
	assign s7	= req_addr[2] ? hwdata[63:32] : hwdata[31:0];
end
endgenerate

generate
if (PLIC_BUS == "axi") begin: gen_unused_ahb_output
	assign hreadyout	= 1'b0;
	assign hrdata 		= {DATA_WIDTH{1'b0}};
	assign hresp 		= 2'b0;
	assign s6	= 32'b0;
	assign s7	= 32'b0;
end
endgenerate
generate
if (PLIC_BUS == "ahb") begin: gen_unused_axi_output

	assign awready	= 1'b0;
	assign arready 	= 1'b0;
	assign wready 	= 1'b0;
	assign bid 	= 4'b0;
	assign bresp 	= 2'b0;
	assign bvalid 	= 1'b0;
	assign rid 	= 4'b0;
	assign rdata 	= {DATA_WIDTH{1'b0}};
	assign rresp 	= 2'b0;
	assign rlast 	= 1'b0;
	assign rvalid 	= 1'b0;
end
endgenerate

function [7:0] addr_predecode;
	input [21:2] addr;
	reg   [7:0]  s127;
	begin
		s127[BIT_REGION_SOURCE_PRIORITY  ] = (addr[21:12] == SOURCE_PRIORITY_REGION_BASE	) & (addr[11: 2] <= INT_NUM[9:0]);
		s127[BIT_REGION_INTERRUPT_PENDING] = (addr[21: 7] == INTERRUPT_PENDING_REGION_BASE) & (addr[ 6: 2] <= TARGET_ENABLE_WORD_NUM[4:0]);
		s127[BIT_REGION_TARGET_ENABLE    ] = (addr[21:11] == TARGET_ENABLE_REGION_BASE	) & (addr[10: 7] <= INTERNAL_TARGET_NUM[3:0]	) & (addr[ 6:2] <= TARGET_ENABLE_WORD_NUM[4:0]);
		s127[BIT_REGION_TARGET_THRESHOLD ] = (addr[21:16] == TARGET_THRESHOLD_REGION_BASE	) & (addr[15:12] <= INTERNAL_TARGET_NUM[3:0]	) & (addr[11:6] == 6'h0)  & (addr[5:3] == 3'b0);
		s127[BIT_REGION_PREEMPTIVE_STACK ] = (addr[21:16] == TARGET_THRESHOLD_REGION_BASE	) & (addr[15:12] <= INTERNAL_TARGET_NUM[3:0]	) & (addr[11:6] == 6'h10) & (addr[5] == 1'b0) & (addr[4:2] <= PREEMPTED_WORD_NUM[2:0]);
		s127[BIT_REGION_FEATURE	       ] = (addr[21: 2] == FEATURE_BASE);
		s127[BIT_REGION_TRIGGER_TYPE     ] = (addr[21: 7] == TRIGGER_TYPE_BASE);
		s127[BIT_REGION_CONFIG           ] = (addr[21: 3] == CONFIG_BASE);
		addr_predecode = s127;
	end
endfunction



endmodule
