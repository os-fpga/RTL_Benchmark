// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module nceplmt100_busif (
		  clk,
		  resetn,
		  htrans,
		  hsize,
		  hburst,
		  haddr,
		  hsel,
		  hwrite,
		  hwdata,
		  hreadyout,
		  hready,
		  hrdata,
		  hresp,
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
		  wdata,
		  wstrb,
		  wlast,
		  wvalid,
		  wready,
		  bid,
		  bresp,
		  bvalid,
		  bready,
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
		  rid,
		  rdata,
		  rresp,
		  rlast,
		  rvalid,
		  rready,
		  mtip,
		  mtime,
		  mtime_gray_sync,
		  mtime_shadow,
		  mtime_shadow_gray,
		  update_req,
		  update_ack_sync
);
parameter			ADDR_WIDTH = 32;
parameter			DATA_WIDTH = 32;
parameter			BUS_TYPE = "ahb";
parameter			ID_WIDTH = 4;
parameter			NHART = 1;

parameter                       GRAY_WIDTH = 4;

input 				clk;
input 				resetn;
input 	[1:0]			htrans;
input 	[2:0]			hsize;
input 	[2:0]			hburst;
input	[ADDR_WIDTH-1:0]	haddr;
input				hsel;
input				hwrite;
input	[DATA_WIDTH-1:0]	hwdata;
output				hreadyout;
input				hready;
output	[DATA_WIDTH-1:0]	hrdata;
output	[1:0]			hresp;

input	[ID_WIDTH-1:0]		awid;
input	[ADDR_WIDTH-1:0]	awaddr;
input	[7:0]			awlen;
input	[2:0]			awsize;
input	[1:0]			awburst;
input				awlock;
input	[3:0]			awcache;
input	[2:0]			awprot;
input				awvalid;
output				awready;
input	[DATA_WIDTH-1:0]	wdata;
input	[(DATA_WIDTH/8)-1:0]	wstrb;
input				wlast;
input				wvalid;
output				wready;
output	[ID_WIDTH-1:0]		bid;
output	[1:0]			bresp;
output				bvalid;
input				bready;
input	[ID_WIDTH-1:0]		arid;
input	[ADDR_WIDTH-1:0]	araddr;
input	[7:0]			arlen;
input	[2:0]			arsize;
input	[1:0]			arburst;
input				arlock;
input	[3:0]			arcache;
input	[2:0]			arprot;
input				arvalid;
output				arready;
output	[ID_WIDTH-1:0]		rid;
output	[DATA_WIDTH-1:0]	rdata;
output	[1:0]			rresp;
output				rlast;
output				rvalid;
input				rready;

output	[NHART-1:0]		mtip;

input	[63:GRAY_WIDTH]	        mtime;
input	[GRAY_WIDTH-1:0]	mtime_gray_sync;
output	[63:GRAY_WIDTH]		mtime_shadow;
output	[GRAY_WIDTH-1:0]	mtime_shadow_gray;

output				update_req;
input				update_ack_sync;

localparam ADDR_MTIME        =  10'h0;
localparam ADDR_MTIMEH       =  10'h4;
localparam ADDR_MTIMECMP     =  10'h8;
localparam ADDR_MTIMECMPH    =  10'hc;
localparam MTIME_SYNC_IDLE   =  2'd0;
localparam MTIME_SYNC_WRITE  =  2'd1;
localparam MTIME_SYNC_SYNC   =  2'd2;
localparam MTIME_SYNC_ACK    =  2'd3;

localparam NDS_ARESP_OK	     = 2'b00;
localparam NDS_ARESP_SLVERR  = 2'b10;

localparam NDS_ASIZE_WORD   	 = 3'b010;
localparam NDS_ASIZE_DOUBLE_WORD = 3'b011;

wire				s0;
wire	[NHART-1:0]		s1;

wire				s2;
wire				s3;
wire	[NHART-1:0]		s4;
wire	[NHART-1:0]		s5;

wire				s6;

wire	[63:0]			s7;
wire    [63:0]                  s8;
wire	[63:GRAY_WIDTH]		mtime_shadow;
reg	[31:0]			s9;
wire	[31:0]			s10;
reg	[31:GRAY_WIDTH]		s11;
wire	[31:GRAY_WIDTH]		s12;
reg	[GRAY_WIDTH-1:0]	mtime_shadow_gray;
wire	[GRAY_WIDTH-1:0]	s13;
reg	[GRAY_WIDTH-1:0]	s14;
wire	[63:0]			s15[0:NHART-1];
reg	[31:0]			s16[0:NHART-1];
reg	[31:0]			s17[0:NHART-1];
wire	[31:0]			s18[0:NHART-1];
wire	[31:0]			s19[0:NHART-1];


wire				s20;
wire				s21;
wire				s22;
wire				s23;
wire	[63:0]			s24;

wire				s25;
wire                            s26;
wire				s27;
reg				update_req;
wire				s28;
wire				s29;
wire				s30;

reg	[1:0]			s31;
reg	[1:0]			s32;
wire				s33;
wire				s34;
wire				s35;
wire				s36;
wire				s37;

wire	[NHART-1:0]		s38;
wire				s39;
wire	[NHART-1:0]		s40;
wire	[NHART-1:0]	   	s41;
wire	[NHART-1:0]		s42;
wire	[NHART-1:0]		s43;
reg	[NHART-1:0]		mtip;

wire	[DATA_WIDTH-1:0]	s44;
wire	[31:0]			s45;

reg                             s46;
wire                            s47;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		mtime_shadow_gray <= {GRAY_WIDTH{1'b0}};
	end
	else if (s20) begin
		mtime_shadow_gray <= s13;
	end
end

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		s11 <= {(32-GRAY_WIDTH){1'd0}};
	end
	else if (s21) begin
		s11 <= s12;
	end
end

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		s9 <= 32'd0;
	end
	else if (s22) begin
		s9 <= s10;
	end
end

generate
genvar i_reg_mcmp;
for (i_reg_mcmp=0; i_reg_mcmp<NHART; i_reg_mcmp=i_reg_mcmp+1) begin: gen_mtimecmpl
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s17[i_reg_mcmp] <= 32'hffff_ffff;
		end
		else if (s4[i_reg_mcmp]) begin
			s17[i_reg_mcmp] <= s19[i_reg_mcmp];
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s16[i_reg_mcmp] <= 32'hffff_ffff;
		end
		else if (s5[i_reg_mcmp]) begin
			s16[i_reg_mcmp] <= s18[i_reg_mcmp];
		end
	end
end
endgenerate

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		update_req <= 1'b0;
	end
	else begin
		update_req <= s29;
	end
end

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		s46 <= 1'b0;
	end
	else if (s47) begin
		s46 <= 1'b1;
	end
end

generate
genvar i_mtip_reg;
for (i_mtip_reg=0; i_mtip_reg<NHART; i_mtip_reg=i_mtip_reg+1) begin: gen_mtip_reg
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			mtip[i_mtip_reg] <= 1'b0;
		end
		else if (s42[i_mtip_reg]) begin
			mtip[i_mtip_reg] <= s43[i_mtip_reg];
		end
	end
end
endgenerate

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		s31 <= 2'd0;
	end
	else begin
		s31 <= s32;
	end
end

always @* begin
	case (s31)
		MTIME_SYNC_IDLE: begin
			if (s6) begin
				s32 = MTIME_SYNC_WRITE;
			end
			else begin
				s32 = MTIME_SYNC_IDLE;
			end
		end
		MTIME_SYNC_WRITE: begin
			if (s33 & ~update_ack_sync) begin
				s32 = MTIME_SYNC_SYNC;
			end
			else begin
				s32 = MTIME_SYNC_WRITE;
			end
		end
		MTIME_SYNC_SYNC: begin
			if (s30) begin
				s32 = MTIME_SYNC_ACK;
			end
			else begin
				s32 = MTIME_SYNC_SYNC;
			end
		end
		MTIME_SYNC_ACK: begin
			if (s6) begin
				s32 = MTIME_SYNC_WRITE;
			end
			else if (~update_ack_sync) begin
				s32 = MTIME_SYNC_IDLE;
			end

			else begin
				s32 = MTIME_SYNC_ACK;
			end
		end
		default: begin
			s32 = 2'd0;
		end
	endcase
end

wire		s48;
wire	[9:0]	s49;
wire	[9:0]	s50;
wire	[9:0]	s51;
reg	[63:0]	s52;
wire	[63:0]	s53[0:NHART];

wire		s54;
wire		s55;

generate
genvar i_rd, i_hrd;
if (BUS_TYPE == "ahb") begin : gen_ahb_interface
	reg				s56;
	wire				s57;
	wire				s58;
	wire				s59;

	reg	[9:0]			s60;
	reg 	[2:0]			s61;

	reg	[DATA_WIDTH-1:0]	s62;
	wire	[DATA_WIDTH-1:0]	s63;
	wire				s64;
	wire				s65;

	wire				s66;
	wire				s67;
	reg				s68;
	wire				s69;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s62 <= {DATA_WIDTH{1'b0}};
		end
		else if (s66) begin
			s62 <= s63;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s60         <= 10'd0;
			s61	 <= 3'd0;
			s68 <= 1'b0;
		end
		else if (hready) begin
			s60	 <= haddr[9:0];
			s61	 <= hsize;
			s68 <= s67;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s56 <= 1'b1;
		end
		else begin
			s56 <= s59;
		end
	end

	assign s33 = (htrans == 2'd0) | ~hsel;
	assign s66  = hsel & htrans[1] & hready & !hwrite;
	assign s67 = hsel & htrans[1] & hready &  hwrite;

	assign s57 = s37 | s34 | hreadyout;
	assign s58 = (s36 | (~(s46 | s2 | s3) & ~hwrite)) & htrans[1] & ((haddr[9:0] == ADDR_MTIME) | (haddr[9:0] == ADDR_MTIMEH));
	assign s59  = ~s58 & s57;

	assign s54 = (s61 == 3'h3) | ((s61 == 3'h2) &  s60[2]);
	assign s55  = (s61 == 3'h3) | ((s61 == 3'h2) & ~s60[2]);

	assign s64    = s69 & s48 & (haddr[9:0] == s49);

	assign s65 = (DATA_WIDTH == 32) & haddr[2] & s66;

	for(i_hrd=0; i_hrd<DATA_WIDTH; i_hrd=i_hrd+32) begin: gen_hrdata
                assign s63[(i_hrd+31):i_hrd] = s64             ? hwdata[(i_hrd+31):i_hrd] :
                                                         (s65) ? s52[63:32]   :
                                                                                  s52[(i_hrd+31):i_hrd];
	end

	assign s48 = s68;
	assign s69  = s66;
	assign s49      = s60;
	assign s51       = haddr[9:0];

	assign s44 = hwdata;

	assign hrdata	 = s62;
	assign hreadyout = s56;
	assign hresp     = 2'd0;

end
endgenerate

generate
if (BUS_TYPE != "axi") begin : gen_ahb_interface_dummy_axi
	assign awready = 1'b0;
	assign wready  = 1'b0;
	assign bid     = {ID_WIDTH{1'b0}};
	assign bresp   = 2'd0;
	assign bvalid  = 1'b0;
	assign arready = 1'b0;
	assign rid     = {ID_WIDTH{1'b0}};
	assign rdata   = {DATA_WIDTH{1'b0}};
	assign rresp   = 2'b0;
	assign rlast   = 1'b0;
	assign rvalid  = 1'b0;
end
endgenerate

generate
if (BUS_TYPE == "axi") begin : gen_axi_interface
	reg	[9:0]			s70;
	reg	[ID_WIDTH-1:0]		s71;
	reg	[(DATA_WIDTH/8)-1:0]	s72;
	wire	[(DATA_WIDTH/8)-1:0]	s73;
	reg				s74;
	reg				 s75;
	reg				s76;

	wire 				s77;
	wire 				 s78;
	wire 				 s79;

	wire				s80;
	wire				s81;
	wire				s82;

	wire				s83;
	wire				s84;
	wire				s85;

	wire				s86;
	wire				s87;
	wire				s88;

	wire				s89;

	reg	[DATA_WIDTH-1:0]	s90;
	wire	[DATA_WIDTH-1:0]	s91;
	wire				s92;
	wire				s93;

	reg				s94;
	reg	[ID_WIDTH-1:0]		s95;
	wire	[ID_WIDTH-1:0]		s96;
	wire				s97;
	wire				s98;
	wire				s99;
	wire				s100;

	reg				s101;
	wire				s102;
	wire				s103;
	wire				s104;

	reg	[ID_WIDTH-1:0]		s105;
	wire	[ID_WIDTH-1:0]		s106;
	reg	[DATA_WIDTH-1:0]	s107;
	wire 	[DATA_WIDTH-1:0] 	s108;
	wire				s109;
	wire				s110;

	wire 				s111;
	wire 		 		s112;

	wire				s113;
	wire				s114;
	wire				s115;
	reg				s116;
	wire				s117;

	wire	[7:0]			s118;
	reg	[7:0]			s119;

	reg				s120;
	wire				s121;
	wire				s122;
	wire				s123;

	reg				s124;
	wire				s125;
	wire				s126;
	wire				s127;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s70 <= 10'h0;
			s71   <= {ID_WIDTH{1'b0}};
		end
		else if (s77) begin
			s70 <= awaddr[9:0];
			s71   <= awid;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s90 <= {DATA_WIDTH{1'b0}};
			s72 <= {(DATA_WIDTH/8){1'b0}};
		end
		else if (s78) begin
			s90 <= s91;
			s72 <= wstrb;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s107 <= {DATA_WIDTH{1'b0}};
		end
		else if (s111) begin
			s107 <= s108;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s74 <= 1'b0;
			 s75 <= 1'b0;
			s76 <= 1'b0;
			s101    <= 1'b0;
			s94    <= 1'b0;
		end
		else begin
			s74 <= s82;
			 s75 <=  s85;
			s76 <= s88;
			s94    <= s99;
			s101    <= s104;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s95    <= {ID_WIDTH{1'b0}};
		end
		else if (s100) begin
			s95    <= s96;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s105    <= {ID_WIDTH{1'b0}};
		end
		else if (s109) begin
			s105    <= s106;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s116	   <= 1'b0;
			s120 <= 1'b0;
			s124 <= 1'b0;
		end
		else begin
			s116	   <= s115;
			s120 <= s123;
			s124 <= s127;
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			s119 <= 8'd0;
		end
		else if (s112) begin
			s119 <= s118;
		end
	end

	assign s33 = ~s74 & ~s76 & ~s75;

	assign s77 = awvalid & awready;
	assign  s78 = wvalid  & wready;

	assign s80 = s77   & ~s78 & ~s75;
	assign s81 = s74 &  s78 & ~s77;
	assign s82  = s80 | (s74 & ~s81);

	assign s83 = s78   & ~s77 & ~s74;
	assign s84 = s75	   &  s77 & ~s78;
	assign  s85 = s83 | (s75 & ~s84);

	assign s73 = s75 ? s72 : wstrb;
	assign s93 = |s73;
	assign s92  = (s77 & s78) | (s78 & s74) | (s77 & s75);
	assign s48 = s92 & s93 & ~s116;

	assign s91 = wdata;

	assign s54 = (DATA_WIDTH == 64) & (&s73[((DATA_WIDTH/8)-1):((DATA_WIDTH/8)-4)]);
	assign s55  = &s73[3:0];

	assign s49 = s74 ? s70 : awaddr[9:0];
	assign s44 = s75  ? s90 : wdata;

	assign awready = ~s74 & ~s36 & ~s89;
	assign wready  = ~s75  & ~s36 & ~s89;

	assign s79 = bvalid & bready;
	assign s97 = s92;
	assign s98 = s79;
	assign s99  = s97 | (~s98 & s94);
	assign s89 = bvalid & ~bready;
	assign s96 = s74 ? s71 : awid;
	assign s100 = s77;

	assign bvalid = s94;
	assign bid    = s95;
	assign bresp  = s116 ? NDS_ARESP_SLVERR : NDS_ARESP_OK;


	assign s111 = arvalid & arready;
	assign  s112 = rvalid  & rready;

	assign s86 = s111;
	assign s87 =  s112 & s76;
	assign s88  = s86 | (s76 & ~s87);

	assign arready = s46 & ~s76;

	assign s102 = s111;
	assign s103 = s112;
	assign s104  = s102 | (~s103 & s101);

	assign s110 = (DATA_WIDTH == 32) & araddr[2];

	for(i_rd=0; i_rd<DATA_WIDTH; i_rd=i_rd+32) begin: gen_rdata
                assign s108[(i_rd+31):i_rd] = (s110) ? s52[63:32] : s52[(i_rd+31):i_rd];
	end

	assign s109 = s111;
	assign s106 = arid;

	assign s51 = araddr[9:0];

	assign s125 = s92 & ~s48;
	assign s126 = s79;
	assign s127  = s125 | (~s126 & s124);

	assign s121 = s111 & ((|arlen) | ((arsize != NDS_ASIZE_WORD) & (arsize != NDS_ASIZE_DOUBLE_WORD)));
	assign s122 = s112 & rlast;
	assign s123  = s121 | (~s122 & s120);

	assign rid    = s105;
	assign rresp  = s120 ? NDS_ARESP_SLVERR : NDS_ARESP_OK;
	assign rdata  = s107;
	assign rvalid = s101;
	assign rlast  = s117 ? 1'b0 : 1'b1;

	assign s118 =  s111		?  arlen :
				     (s119 == 8'd0) ?  8'd0  :
			     				          (s119 - 8'd1);
	assign s117 = (|s119);

	assign s113 = s77 & (|awlen);
	assign s114 = s78 & wlast;
	assign s115  = s113 | (~s114 & s116);


end
endgenerate

generate
if (BUS_TYPE != "ahb") begin : gen_axi_interface_dummy_ahb
	assign hreadyout = 1'b0;
	assign hrdata    = {DATA_WIDTH{1'b0}};
	assign hresp     = 2'd0;
end
endgenerate

assign s34  = (s31 == MTIME_SYNC_IDLE );
assign s35 = (s31 == MTIME_SYNC_WRITE);
assign s36  = (s31 == MTIME_SYNC_SYNC );
assign s37   = (s31 == MTIME_SYNC_ACK  );

assign s50 = {s49[9:3], 1'b0, s49[1:0]};

assign s2  = s48 & (s49    == ADDR_MTIME) &  s55;
assign s3 = s48 & (s50 == ADDR_MTIME) & (s54 | s49[2]);

generate
genvar i_mcmp_we;
for (i_mcmp_we=0; i_mcmp_we<NHART; i_mcmp_we=i_mcmp_we+1) begin: gen_mtimecmp_we

	assign s4[i_mcmp_we]  = s48 & (s49    == (ADDR_MTIMECMP + {i_mcmp_we[6:0], 3'd0})) &  s55;
	assign s5[i_mcmp_we] = s48 & (s50 == (ADDR_MTIMECMP + {i_mcmp_we[6:0], 3'd0})) & (s54 | s49[2]);
end
endgenerate

assign s6  = s2 | s3;
assign mtime_shadow = {s9, s11};

generate
genvar i_mcmp;
for (i_mcmp=0; i_mcmp<NHART; i_mcmp=i_mcmp+1) begin: gen_mtimecmp_64bit
	assign s15[i_mcmp] = {s16[i_mcmp], s17[i_mcmp]};
end
endgenerate

assign s7 = {s9, s11, s14};

assign s24 = s7;

assign s0 = ({s51[9:3], 3'b0} == ADDR_MTIME);

generate
genvar i_rd_mcmp;
for (i_rd_mcmp=0; i_rd_mcmp<NHART; i_rd_mcmp=i_rd_mcmp+1) begin: gen_read_mtimecmp_en
	assign s1[i_rd_mcmp] = ({s51[9:3], 3'b0} == (ADDR_MTIMECMP + {i_rd_mcmp[6:0], 3'd0}));
end
endgenerate

generate
genvar i_plmt_rd;
for (i_plmt_rd=0; i_plmt_rd<(NHART+1); i_plmt_rd=i_plmt_rd+1) begin: gen_plmt_rdata_array
	if (i_plmt_rd == 0) begin: gen_read_mtime_data
		assign s53[i_plmt_rd] = ({64{s0}} & s24);
	end
	else begin: gen_read_mtimecmp_data
		assign s53[i_plmt_rd] = ({64{s1[i_plmt_rd-1]}} & s15[i_plmt_rd-1]);
	end
end
endgenerate

integer s128;
always @* begin
	s52 = 64'd0;
	for (s128=0; s128<(NHART+1); s128=s128+1) begin: gen_plmt_rdata
		s52 = s52 | s53[s128];
	end
end


integer s129;
always @* begin
        s14[GRAY_WIDTH-1] = mtime_shadow_gray[GRAY_WIDTH-1];
        for (s129 = GRAY_WIDTH-2; s129 >= 0; s129 = s129 - 1) begin
                s14[s129] = s14[s129+1] ^ mtime_shadow_gray[s129];
        end
end

assign s25 = mtime_shadow_gray[GRAY_WIDTH-1] & ~mtime_gray_sync[GRAY_WIDTH-1];
assign s26 = s25 & ~s27 & ~s6;

assign s27       =  s28;
assign s23 =  s35 | s36 | s6;

assign s20  = s2  | s27 | ~s23;
assign s21      = s2  | s27 | (s26 & ~s23);
assign s22      = s3 | s27 | (s26 & ~s23);

assign s8 = s7 + 64'd3;

assign s45     = s54 ? s44[DATA_WIDTH-1:DATA_WIDTH-32] : s44[31:0];


assign s13 = s2    ? (s44[GRAY_WIDTH-1:0]            ^ {1'b0, s44[GRAY_WIDTH-1:1]}) :
                              s27 ? (s8[GRAY_WIDTH-1:0] ^ {1'b0, s8[GRAY_WIDTH-1:1]}) :
                                             mtime_gray_sync;

assign s12 = ({(31-GRAY_WIDTH+1){s2}}               & s44[31:GRAY_WIDTH])
                        | ({(31-GRAY_WIDTH+1){s27}}            & s8[31:GRAY_WIDTH])
                        | ({(31-GRAY_WIDTH+1){s26}} & mtime[31:GRAY_WIDTH]);

assign s10 = ({32{s3}}              & s45)
                        | ({32{s27}}            & s8[63:32])
                        | ({32{s26}} & mtime[63:32]);

generate
genvar i_mcmp_data;
for (i_mcmp_data=0; i_mcmp_data<NHART; i_mcmp_data=i_mcmp_data+1) begin: gen_mcmp_data
	assign s19[i_mcmp_data] = s44[31:0];
	assign s18[i_mcmp_data] = s44[DATA_WIDTH-1:DATA_WIDTH-32];
end
endgenerate

assign s28  = s36 & ~update_req;
assign s29   = s28 | (update_req & ~update_ack_sync);
assign s30 = update_req &  update_ack_sync;

generate
genvar i_mtip;
for (i_mtip=0; i_mtip<NHART; i_mtip=i_mtip+1) begin: gen_mtip_compare
	assign s38[i_mtip] = (s7 >= s15[i_mtip]);
end
endgenerate
assign s39 = s2 | s3;
assign s42  = s40 | s41;
assign s40 = (s38 & {NHART{~s39}});
assign s41 = s4 | s5;
assign s43  = ~s41 & (s40 | mtip);

assign s47 = (s26 & ~s23) | s2 | s3;

endmodule
