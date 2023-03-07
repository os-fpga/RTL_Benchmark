// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc300_config.vh"
`include "atcbmc300_const.vh"

module atcbmc300_ds_addr_ctrl (
`ifdef ATCBMC300_MST0_SUPPORT
	  mst0_addr,
	  mst0_len,
	  mst0_size,
	  mst0_burst,
	  mst0_lock,
	  mst0_cache,
	  mst0_prot,
	  mst0_aid,
	  mst0_avalid,
	  mst0_connect,
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	  mst1_addr,
	  mst1_len,
	  mst1_size,
	  mst1_burst,
	  mst1_lock,
	  mst1_cache,
	  mst1_prot,
	  mst1_aid,
	  mst1_avalid,
	  mst1_connect,
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	  mst2_addr,
	  mst2_len,
	  mst2_size,
	  mst2_burst,
	  mst2_lock,
	  mst2_cache,
	  mst2_prot,
	  mst2_aid,
	  mst2_avalid,
	  mst2_connect,
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	  mst3_addr,
	  mst3_len,
	  mst3_size,
	  mst3_burst,
	  mst3_lock,
	  mst3_cache,
	  mst3_prot,
	  mst3_aid,
	  mst3_avalid,
	  mst3_connect,
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	  mst4_addr,
	  mst4_len,
	  mst4_size,
	  mst4_burst,
	  mst4_lock,
	  mst4_cache,
	  mst4_prot,
	  mst4_aid,
	  mst4_avalid,
	  mst4_connect,
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	  mst5_addr,
	  mst5_len,
	  mst5_size,
	  mst5_burst,
	  mst5_lock,
	  mst5_cache,
	  mst5_prot,
	  mst5_aid,
	  mst5_avalid,
	  mst5_connect,
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	  mst6_addr,
	  mst6_len,
	  mst6_size,
	  mst6_burst,
	  mst6_lock,
	  mst6_cache,
	  mst6_prot,
	  mst6_aid,
	  mst6_avalid,
	  mst6_connect,
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	  mst7_addr,
	  mst7_len,
	  mst7_size,
	  mst7_burst,
	  mst7_lock,
	  mst7_cache,
	  mst7_prot,
	  mst7_aid,
	  mst7_avalid,
	  mst7_connect,
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	  mst8_addr,
	  mst8_len,
	  mst8_size,
	  mst8_burst,
	  mst8_lock,
	  mst8_cache,
	  mst8_prot,
	  mst8_aid,
	  mst8_avalid,
	  mst8_connect,
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	  mst9_addr,
	  mst9_len,
	  mst9_size,
	  mst9_burst,
	  mst9_lock,
	  mst9_cache,
	  mst9_prot,
	  mst9_aid,
	  mst9_avalid,
	  mst9_connect,
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	  mst10_addr,
	  mst10_len,
	  mst10_size,
	  mst10_burst,
	  mst10_lock,
	  mst10_cache,
	  mst10_prot,
	  mst10_aid,
	  mst10_avalid,
	  mst10_connect,
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	  mst11_addr,
	  mst11_len,
	  mst11_size,
	  mst11_burst,
	  mst11_lock,
	  mst11_cache,
	  mst11_prot,
	  mst11_aid,
	  mst11_avalid,
	  mst11_connect,
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	  mst12_addr,
	  mst12_len,
	  mst12_size,
	  mst12_burst,
	  mst12_lock,
	  mst12_cache,
	  mst12_prot,
	  mst12_aid,
	  mst12_avalid,
	  mst12_connect,
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	  mst13_addr,
	  mst13_len,
	  mst13_size,
	  mst13_burst,
	  mst13_lock,
	  mst13_cache,
	  mst13_prot,
	  mst13_aid,
	  mst13_avalid,
	  mst13_connect,
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	  mst14_addr,
	  mst14_len,
	  mst14_size,
	  mst14_burst,
	  mst14_lock,
	  mst14_cache,
	  mst14_prot,
	  mst14_aid,
	  mst14_avalid,
	  mst14_connect,
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	  mst15_addr,
	  mst15_len,
	  mst15_size,
	  mst15_burst,
	  mst15_lock,
	  mst15_cache,
	  mst15_prot,
	  mst15_aid,
	  mst15_avalid,
	  mst15_connect,
`endif
	  addr_outstanding_en,
	  slv_aready,
	  arb_mid,
	  outstanding_ready,
	  addr,
	  len,
	  size,
	  burst,
	  lock,
	  cache,
	  prot,
	  aid,
	  avalid,
	  aready,
	  reg_mst0_high_priority,
	  reg_priority_reload,
	  aclk,
	  aresetn
);
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 64;
parameter ID_WIDTH   = 4;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam ID_MSB   = ID_WIDTH - 1;


`ifdef ATCBMC300_MST0_SUPPORT
input [ADDR_MSB:0] mst0_addr;
input [7:0]        mst0_len;
input [2:0]        mst0_size;
input [1:0]        mst0_burst;
input              mst0_lock;
input [3:0]        mst0_cache;
input [2:0]        mst0_prot;
input [ID_MSB:0]   mst0_aid;
input 	        mst0_avalid;
input		mst0_connect;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
input [ADDR_MSB:0] mst1_addr;
input [7:0]        mst1_len;
input [2:0]        mst1_size;
input [1:0]        mst1_burst;
input              mst1_lock;
input [3:0]        mst1_cache;
input [2:0]        mst1_prot;
input [ID_MSB:0]   mst1_aid;
input 	        mst1_avalid;
input		mst1_connect;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
input [ADDR_MSB:0] mst2_addr;
input [7:0]        mst2_len;
input [2:0]        mst2_size;
input [1:0]        mst2_burst;
input              mst2_lock;
input [3:0]        mst2_cache;
input [2:0]        mst2_prot;
input [ID_MSB:0]   mst2_aid;
input 	        mst2_avalid;
input		mst2_connect;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
input [ADDR_MSB:0] mst3_addr;
input [7:0]        mst3_len;
input [2:0]        mst3_size;
input [1:0]        mst3_burst;
input              mst3_lock;
input [3:0]        mst3_cache;
input [2:0]        mst3_prot;
input [ID_MSB:0]   mst3_aid;
input 	        mst3_avalid;
input		mst3_connect;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
input [ADDR_MSB:0] mst4_addr;
input [7:0]        mst4_len;
input [2:0]        mst4_size;
input [1:0]        mst4_burst;
input              mst4_lock;
input [3:0]        mst4_cache;
input [2:0]        mst4_prot;
input [ID_MSB:0]   mst4_aid;
input 	        mst4_avalid;
input		mst4_connect;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
input [ADDR_MSB:0] mst5_addr;
input [7:0]        mst5_len;
input [2:0]        mst5_size;
input [1:0]        mst5_burst;
input              mst5_lock;
input [3:0]        mst5_cache;
input [2:0]        mst5_prot;
input [ID_MSB:0]   mst5_aid;
input 	        mst5_avalid;
input		mst5_connect;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
input [ADDR_MSB:0] mst6_addr;
input [7:0]        mst6_len;
input [2:0]        mst6_size;
input [1:0]        mst6_burst;
input              mst6_lock;
input [3:0]        mst6_cache;
input [2:0]        mst6_prot;
input [ID_MSB:0]   mst6_aid;
input 	        mst6_avalid;
input		mst6_connect;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
input [ADDR_MSB:0] mst7_addr;
input [7:0]        mst7_len;
input [2:0]        mst7_size;
input [1:0]        mst7_burst;
input              mst7_lock;
input [3:0]        mst7_cache;
input [2:0]        mst7_prot;
input [ID_MSB:0]   mst7_aid;
input 	        mst7_avalid;
input		mst7_connect;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
input [ADDR_MSB:0] mst8_addr;
input [7:0]        mst8_len;
input [2:0]        mst8_size;
input [1:0]        mst8_burst;
input              mst8_lock;
input [3:0]        mst8_cache;
input [2:0]        mst8_prot;
input [ID_MSB:0]   mst8_aid;
input 	        mst8_avalid;
input		mst8_connect;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
input [ADDR_MSB:0] mst9_addr;
input [7:0]        mst9_len;
input [2:0]        mst9_size;
input [1:0]        mst9_burst;
input              mst9_lock;
input [3:0]        mst9_cache;
input [2:0]        mst9_prot;
input [ID_MSB:0]   mst9_aid;
input 	        mst9_avalid;
input		mst9_connect;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
input [ADDR_MSB:0] mst10_addr;
input [7:0]        mst10_len;
input [2:0]        mst10_size;
input [1:0]        mst10_burst;
input              mst10_lock;
input [3:0]        mst10_cache;
input [2:0]        mst10_prot;
input [ID_MSB:0]   mst10_aid;
input 	        mst10_avalid;
input		mst10_connect;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
input [ADDR_MSB:0] mst11_addr;
input [7:0]        mst11_len;
input [2:0]        mst11_size;
input [1:0]        mst11_burst;
input              mst11_lock;
input [3:0]        mst11_cache;
input [2:0]        mst11_prot;
input [ID_MSB:0]   mst11_aid;
input 	        mst11_avalid;
input		mst11_connect;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
input [ADDR_MSB:0] mst12_addr;
input [7:0]        mst12_len;
input [2:0]        mst12_size;
input [1:0]        mst12_burst;
input              mst12_lock;
input [3:0]        mst12_cache;
input [2:0]        mst12_prot;
input [ID_MSB:0]   mst12_aid;
input 	        mst12_avalid;
input		mst12_connect;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
input [ADDR_MSB:0] mst13_addr;
input [7:0]        mst13_len;
input [2:0]        mst13_size;
input [1:0]        mst13_burst;
input              mst13_lock;
input [3:0]        mst13_cache;
input [2:0]        mst13_prot;
input [ID_MSB:0]   mst13_aid;
input 	        mst13_avalid;
input		mst13_connect;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
input [ADDR_MSB:0] mst14_addr;
input [7:0]        mst14_len;
input [2:0]        mst14_size;
input [1:0]        mst14_burst;
input              mst14_lock;
input [3:0]        mst14_cache;
input [2:0]        mst14_prot;
input [ID_MSB:0]   mst14_aid;
input 	        mst14_avalid;
input		mst14_connect;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
input [ADDR_MSB:0] mst15_addr;
input [7:0]        mst15_len;
input [2:0]        mst15_size;
input [1:0]        mst15_burst;
input              mst15_lock;
input [3:0]        mst15_cache;
input [2:0]        mst15_prot;
input [ID_MSB:0]   mst15_aid;
input 	        mst15_avalid;
input		mst15_connect;
`endif
output 		    addr_outstanding_en;
output              slv_aready;
output [3:0]        arb_mid;
input               outstanding_ready;

output [ADDR_MSB:0] addr;
output [7:0]        len;
output [2:0]        size;
output [1:0]        burst;
output 	            lock;
output [3:0]        cache;
output [2:0]        prot;
output [(ID_MSB+4):0] aid;
output              avalid;
input               aready;
input              reg_mst0_high_priority;
input [15:0]       reg_priority_reload;
input aclk;
input aresetn;

reg [ADDR_MSB:0] addr;
reg [7:0]        len;
reg [2:0]        size;
reg [1:0]        burst;
reg 	         lock;
reg [3:0]        cache;
reg [2:0]        prot;
reg [ID_MSB:0]   s0;
reg              avalid;
reg [3:0]        s1;
wire [ID_MSB+4:0] aid;

reg [ADDR_MSB:0] s2  [0:15];
reg [7:0]        s3   [0:15];
reg [2:0]        s4  [0:15];
reg [1:0]        s5 [0:15];
reg 	         s6  [0:15];
reg [3:0]        s7 [0:15];
reg [2:0]        s8  [0:15];
reg [ID_MSB:0]   s9   [0:15];
reg [15:0]       s10;
reg [15:0]       s11;
wire [15:0]       s12;
wire 		s13;
assign s13 = s11!=16'h0;

`ifdef ATCBMC300_MST0_SUPPORT
reg s14;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s14 <= 1'b0;
	else
		s14 <= mst0_connect & ~((arb_mid==4'd0) & slv_aready) &
					   ((~s13 & mst0_avalid & reg_priority_reload[0]) | s14);
end
`endif
`ifdef ATCBMC300_MST1_SUPPORT
reg s15;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s15 <= 1'b0;
	else
		s15 <= mst1_connect & ~((arb_mid==4'd1) & slv_aready) &
					   ((~s13 & mst1_avalid & reg_priority_reload[1]) | s15);
end
`endif
`ifdef ATCBMC300_MST2_SUPPORT
reg s16;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s16 <= 1'b0;
	else
		s16 <= mst2_connect & ~((arb_mid==4'd2) & slv_aready) &
					   ((~s13 & mst2_avalid & reg_priority_reload[2]) | s16);
end
`endif
`ifdef ATCBMC300_MST3_SUPPORT
reg s17;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s17 <= 1'b0;
	else
		s17 <= mst3_connect & ~((arb_mid==4'd3) & slv_aready) &
					   ((~s13 & mst3_avalid & reg_priority_reload[3]) | s17);
end
`endif
`ifdef ATCBMC300_MST4_SUPPORT
reg s18;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s18 <= 1'b0;
	else
		s18 <= mst4_connect & ~((arb_mid==4'd4) & slv_aready) &
					   ((~s13 & mst4_avalid & reg_priority_reload[4]) | s18);
end
`endif
`ifdef ATCBMC300_MST5_SUPPORT
reg s19;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s19 <= 1'b0;
	else
		s19 <= mst5_connect & ~((arb_mid==4'd5) & slv_aready) &
					   ((~s13 & mst5_avalid & reg_priority_reload[5]) | s19);
end
`endif
`ifdef ATCBMC300_MST6_SUPPORT
reg s20;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s20 <= 1'b0;
	else
		s20 <= mst6_connect & ~((arb_mid==4'd6) & slv_aready) &
					   ((~s13 & mst6_avalid & reg_priority_reload[6]) | s20);
end
`endif
`ifdef ATCBMC300_MST7_SUPPORT
reg s21;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s21 <= 1'b0;
	else
		s21 <= mst7_connect & ~((arb_mid==4'd7) & slv_aready) &
					   ((~s13 & mst7_avalid & reg_priority_reload[7]) | s21);
end
`endif
`ifdef ATCBMC300_MST8_SUPPORT
reg s22;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s22 <= 1'b0;
	else
		s22 <= mst8_connect & ~((arb_mid==4'd8) & slv_aready) &
					   ((~s13 & mst8_avalid & reg_priority_reload[8]) | s22);
end
`endif
`ifdef ATCBMC300_MST9_SUPPORT
reg s23;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s23 <= 1'b0;
	else
		s23 <= mst9_connect & ~((arb_mid==4'd9) & slv_aready) &
					   ((~s13 & mst9_avalid & reg_priority_reload[9]) | s23);
end
`endif
`ifdef ATCBMC300_MST10_SUPPORT
reg s24;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s24 <= 1'b0;
	else
		s24 <= mst10_connect & ~((arb_mid==4'd10) & slv_aready) &
					   ((~s13 & mst10_avalid & reg_priority_reload[10]) | s24);
end
`endif
`ifdef ATCBMC300_MST11_SUPPORT
reg s25;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s25 <= 1'b0;
	else
		s25 <= mst11_connect & ~((arb_mid==4'd11) & slv_aready) &
					   ((~s13 & mst11_avalid & reg_priority_reload[11]) | s25);
end
`endif
`ifdef ATCBMC300_MST12_SUPPORT
reg s26;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s26 <= 1'b0;
	else
		s26 <= mst12_connect & ~((arb_mid==4'd12) & slv_aready) &
					   ((~s13 & mst12_avalid & reg_priority_reload[12]) | s26);
end
`endif
`ifdef ATCBMC300_MST13_SUPPORT
reg s27;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s27 <= 1'b0;
	else
		s27 <= mst13_connect & ~((arb_mid==4'd13) & slv_aready) &
					   ((~s13 & mst13_avalid & reg_priority_reload[13]) | s27);
end
`endif
`ifdef ATCBMC300_MST14_SUPPORT
reg s28;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s28 <= 1'b0;
	else
		s28 <= mst14_connect & ~((arb_mid==4'd14) & slv_aready) &
					   ((~s13 & mst14_avalid & reg_priority_reload[14]) | s28);
end
`endif
`ifdef ATCBMC300_MST15_SUPPORT
reg s29;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s29 <= 1'b0;
	else
		s29 <= mst15_connect & ~((arb_mid==4'd15) & slv_aready) &
					   ((~s13 & mst15_avalid & reg_priority_reload[15]) | s29);
end
`endif

always @* begin
`ifdef ATCBMC300_MST0_SUPPORT
	s2  [0] = mst0_addr  & {ADDR_WIDTH{mst0_connect}};
	s3   [0] = mst0_len   & {8{mst0_connect}};
	s4  [0] = mst0_size  & {3{mst0_connect}};
	s5 [0] = mst0_burst & {2{mst0_connect}};
	s7 [0] = mst0_cache & {4{mst0_connect}};
	s8  [0] = mst0_prot  & {3{mst0_connect}};
	s9   [0] = mst0_aid   & {ID_WIDTH{mst0_connect}};
	s6  [0] = mst0_lock  & mst0_connect;
	s10[0] = mst0_avalid   & mst0_connect;
	s11[0] = s14;
`else
	s2  [0] = {ADDR_WIDTH{1'b0}};
	s3   [0] = {8{1'b0}};
	s4  [0] = {3{1'b0}};
	s5 [0] = {2{1'b0}};
	s7 [0] = {4{1'b0}};
	s8  [0] = {3{1'b0}};
	s9   [0] = {ID_WIDTH{1'b0}};
	s6  [0] = {1{1'b0}};
	s10[0] = 1'b0;
	s11[0] = 1'b0;
`endif
`ifdef ATCBMC300_MST1_SUPPORT
	s2  [1] = mst1_addr  & {ADDR_WIDTH{mst1_connect}};
	s3   [1] = mst1_len   & {8{mst1_connect}};
	s4  [1] = mst1_size  & {3{mst1_connect}};
	s5 [1] = mst1_burst & {2{mst1_connect}};
	s7 [1] = mst1_cache & {4{mst1_connect}};
	s8  [1] = mst1_prot  & {3{mst1_connect}};
	s9   [1] = mst1_aid   & {ID_WIDTH{mst1_connect}};
	s6  [1] = mst1_lock  & mst1_connect;
	s10[1] = mst1_avalid   & mst1_connect;
	s11[1] = s15;
`else
	s2  [1] = {ADDR_WIDTH{1'b0}};
	s3   [1] = {8{1'b0}};
	s4  [1] = {3{1'b0}};
	s5 [1] = {2{1'b0}};
	s7 [1] = {4{1'b0}};
	s8  [1] = {3{1'b0}};
	s9   [1] = {ID_WIDTH{1'b0}};
	s6  [1] = {1{1'b0}};
	s10[1] = 1'b0;
	s11[1] = 1'b0;
`endif
`ifdef ATCBMC300_MST2_SUPPORT
	s2  [2] = mst2_addr  & {ADDR_WIDTH{mst2_connect}};
	s3   [2] = mst2_len   & {8{mst2_connect}};
	s4  [2] = mst2_size  & {3{mst2_connect}};
	s5 [2] = mst2_burst & {2{mst2_connect}};
	s7 [2] = mst2_cache & {4{mst2_connect}};
	s8  [2] = mst2_prot  & {3{mst2_connect}};
	s9   [2] = mst2_aid   & {ID_WIDTH{mst2_connect}};
	s6  [2] = mst2_lock  & mst2_connect;
	s10[2] = mst2_avalid   & mst2_connect;
	s11[2] = s16;
`else
	s2  [2] = {ADDR_WIDTH{1'b0}};
	s3   [2] = {8{1'b0}};
	s4  [2] = {3{1'b0}};
	s5 [2] = {2{1'b0}};
	s7 [2] = {4{1'b0}};
	s8  [2] = {3{1'b0}};
	s9   [2] = {ID_WIDTH{1'b0}};
	s6  [2] = {1{1'b0}};
	s10[2] = 1'b0;
	s11[2] = 1'b0;
`endif
`ifdef ATCBMC300_MST3_SUPPORT
	s2  [3] = mst3_addr  & {ADDR_WIDTH{mst3_connect}};
	s3   [3] = mst3_len   & {8{mst3_connect}};
	s4  [3] = mst3_size  & {3{mst3_connect}};
	s5 [3] = mst3_burst & {2{mst3_connect}};
	s7 [3] = mst3_cache & {4{mst3_connect}};
	s8  [3] = mst3_prot  & {3{mst3_connect}};
	s9   [3] = mst3_aid   & {ID_WIDTH{mst3_connect}};
	s6  [3] = mst3_lock  & mst3_connect;
	s10[3] = mst3_avalid   & mst3_connect;
	s11[3] = s17;
`else
	s2  [3] = {ADDR_WIDTH{1'b0}};
	s3   [3] = {8{1'b0}};
	s4  [3] = {3{1'b0}};
	s5 [3] = {2{1'b0}};
	s7 [3] = {4{1'b0}};
	s8  [3] = {3{1'b0}};
	s9   [3] = {ID_WIDTH{1'b0}};
	s6  [3] = {1{1'b0}};
	s10[3] = 1'b0;
	s11[3] = 1'b0;
`endif
`ifdef ATCBMC300_MST4_SUPPORT
	s2  [4] = mst4_addr  & {ADDR_WIDTH{mst4_connect}};
	s3   [4] = mst4_len   & {8{mst4_connect}};
	s4  [4] = mst4_size  & {3{mst4_connect}};
	s5 [4] = mst4_burst & {2{mst4_connect}};
	s7 [4] = mst4_cache & {4{mst4_connect}};
	s8  [4] = mst4_prot  & {3{mst4_connect}};
	s9   [4] = mst4_aid   & {ID_WIDTH{mst4_connect}};
	s6  [4] = mst4_lock  & mst4_connect;
	s10[4] = mst4_avalid   & mst4_connect;
	s11[4] = s18;
`else
	s2  [4] = {ADDR_WIDTH{1'b0}};
	s3   [4] = {8{1'b0}};
	s4  [4] = {3{1'b0}};
	s5 [4] = {2{1'b0}};
	s7 [4] = {4{1'b0}};
	s8  [4] = {3{1'b0}};
	s9   [4] = {ID_WIDTH{1'b0}};
	s6  [4] = {1{1'b0}};
	s10[4] = 1'b0;
	s11[4] = 1'b0;
`endif
`ifdef ATCBMC300_MST5_SUPPORT
	s2  [5] = mst5_addr  & {ADDR_WIDTH{mst5_connect}};
	s3   [5] = mst5_len   & {8{mst5_connect}};
	s4  [5] = mst5_size  & {3{mst5_connect}};
	s5 [5] = mst5_burst & {2{mst5_connect}};
	s7 [5] = mst5_cache & {4{mst5_connect}};
	s8  [5] = mst5_prot  & {3{mst5_connect}};
	s9   [5] = mst5_aid   & {ID_WIDTH{mst5_connect}};
	s6  [5] = mst5_lock  & mst5_connect;
	s10[5] = mst5_avalid   & mst5_connect;
	s11[5] = s19;
`else
	s2  [5] = {ADDR_WIDTH{1'b0}};
	s3   [5] = {8{1'b0}};
	s4  [5] = {3{1'b0}};
	s5 [5] = {2{1'b0}};
	s7 [5] = {4{1'b0}};
	s8  [5] = {3{1'b0}};
	s9   [5] = {ID_WIDTH{1'b0}};
	s6  [5] = {1{1'b0}};
	s10[5] = 1'b0;
	s11[5] = 1'b0;
`endif
`ifdef ATCBMC300_MST6_SUPPORT
	s2  [6] = mst6_addr  & {ADDR_WIDTH{mst6_connect}};
	s3   [6] = mst6_len   & {8{mst6_connect}};
	s4  [6] = mst6_size  & {3{mst6_connect}};
	s5 [6] = mst6_burst & {2{mst6_connect}};
	s7 [6] = mst6_cache & {4{mst6_connect}};
	s8  [6] = mst6_prot  & {3{mst6_connect}};
	s9   [6] = mst6_aid   & {ID_WIDTH{mst6_connect}};
	s6  [6] = mst6_lock  & mst6_connect;
	s10[6] = mst6_avalid   & mst6_connect;
	s11[6] = s20;
`else
	s2  [6] = {ADDR_WIDTH{1'b0}};
	s3   [6] = {8{1'b0}};
	s4  [6] = {3{1'b0}};
	s5 [6] = {2{1'b0}};
	s7 [6] = {4{1'b0}};
	s8  [6] = {3{1'b0}};
	s9   [6] = {ID_WIDTH{1'b0}};
	s6  [6] = {1{1'b0}};
	s10[6] = 1'b0;
	s11[6] = 1'b0;
`endif
`ifdef ATCBMC300_MST7_SUPPORT
	s2  [7] = mst7_addr  & {ADDR_WIDTH{mst7_connect}};
	s3   [7] = mst7_len   & {8{mst7_connect}};
	s4  [7] = mst7_size  & {3{mst7_connect}};
	s5 [7] = mst7_burst & {2{mst7_connect}};
	s7 [7] = mst7_cache & {4{mst7_connect}};
	s8  [7] = mst7_prot  & {3{mst7_connect}};
	s9   [7] = mst7_aid   & {ID_WIDTH{mst7_connect}};
	s6  [7] = mst7_lock  & mst7_connect;
	s10[7] = mst7_avalid   & mst7_connect;
	s11[7] = s21;
`else
	s2  [7] = {ADDR_WIDTH{1'b0}};
	s3   [7] = {8{1'b0}};
	s4  [7] = {3{1'b0}};
	s5 [7] = {2{1'b0}};
	s7 [7] = {4{1'b0}};
	s8  [7] = {3{1'b0}};
	s9   [7] = {ID_WIDTH{1'b0}};
	s6  [7] = {1{1'b0}};
	s10[7] = 1'b0;
	s11[7] = 1'b0;
`endif
`ifdef ATCBMC300_MST8_SUPPORT
	s2  [8] = mst8_addr  & {ADDR_WIDTH{mst8_connect}};
	s3   [8] = mst8_len   & {8{mst8_connect}};
	s4  [8] = mst8_size  & {3{mst8_connect}};
	s5 [8] = mst8_burst & {2{mst8_connect}};
	s7 [8] = mst8_cache & {4{mst8_connect}};
	s8  [8] = mst8_prot  & {3{mst8_connect}};
	s9   [8] = mst8_aid   & {ID_WIDTH{mst8_connect}};
	s6  [8] = mst8_lock  & mst8_connect;
	s10[8] = mst8_avalid   & mst8_connect;
	s11[8] = s22;
`else
	s2  [8] = {ADDR_WIDTH{1'b0}};
	s3   [8] = {8{1'b0}};
	s4  [8] = {3{1'b0}};
	s5 [8] = {2{1'b0}};
	s7 [8] = {4{1'b0}};
	s8  [8] = {3{1'b0}};
	s9   [8] = {ID_WIDTH{1'b0}};
	s6  [8] = {1{1'b0}};
	s10[8] = 1'b0;
	s11[8] = 1'b0;
`endif
`ifdef ATCBMC300_MST9_SUPPORT
	s2  [9] = mst9_addr  & {ADDR_WIDTH{mst9_connect}};
	s3   [9] = mst9_len   & {8{mst9_connect}};
	s4  [9] = mst9_size  & {3{mst9_connect}};
	s5 [9] = mst9_burst & {2{mst9_connect}};
	s7 [9] = mst9_cache & {4{mst9_connect}};
	s8  [9] = mst9_prot  & {3{mst9_connect}};
	s9   [9] = mst9_aid   & {ID_WIDTH{mst9_connect}};
	s6  [9] = mst9_lock  & mst9_connect;
	s10[9] = mst9_avalid   & mst9_connect;
	s11[9] = s23;
`else
	s2  [9] = {ADDR_WIDTH{1'b0}};
	s3   [9] = {8{1'b0}};
	s4  [9] = {3{1'b0}};
	s5 [9] = {2{1'b0}};
	s7 [9] = {4{1'b0}};
	s8  [9] = {3{1'b0}};
	s9   [9] = {ID_WIDTH{1'b0}};
	s6  [9] = {1{1'b0}};
	s10[9] = 1'b0;
	s11[9] = 1'b0;
`endif
`ifdef ATCBMC300_MST10_SUPPORT
	s2  [10] = mst10_addr  & {ADDR_WIDTH{mst10_connect}};
	s3   [10] = mst10_len   & {8{mst10_connect}};
	s4  [10] = mst10_size  & {3{mst10_connect}};
	s5 [10] = mst10_burst & {2{mst10_connect}};
	s7 [10] = mst10_cache & {4{mst10_connect}};
	s8  [10] = mst10_prot  & {3{mst10_connect}};
	s9   [10] = mst10_aid   & {ID_WIDTH{mst10_connect}};
	s6  [10] = mst10_lock  & mst10_connect;
	s10[10] = mst10_avalid   & mst10_connect;
	s11[10] = s24;
`else
	s2  [10] = {ADDR_WIDTH{1'b0}};
	s3   [10] = {8{1'b0}};
	s4  [10] = {3{1'b0}};
	s5 [10] = {2{1'b0}};
	s7 [10] = {4{1'b0}};
	s8  [10] = {3{1'b0}};
	s9   [10] = {ID_WIDTH{1'b0}};
	s6  [10] = {1{1'b0}};
	s10[10] = 1'b0;
	s11[10] = 1'b0;
`endif
`ifdef ATCBMC300_MST11_SUPPORT
	s2  [11] = mst11_addr  & {ADDR_WIDTH{mst11_connect}};
	s3   [11] = mst11_len   & {8{mst11_connect}};
	s4  [11] = mst11_size  & {3{mst11_connect}};
	s5 [11] = mst11_burst & {2{mst11_connect}};
	s7 [11] = mst11_cache & {4{mst11_connect}};
	s8  [11] = mst11_prot  & {3{mst11_connect}};
	s9   [11] = mst11_aid   & {ID_WIDTH{mst11_connect}};
	s6  [11] = mst11_lock  & mst11_connect;
	s10[11] = mst11_avalid   & mst11_connect;
	s11[11] = s25;
`else
	s2  [11] = {ADDR_WIDTH{1'b0}};
	s3   [11] = {8{1'b0}};
	s4  [11] = {3{1'b0}};
	s5 [11] = {2{1'b0}};
	s7 [11] = {4{1'b0}};
	s8  [11] = {3{1'b0}};
	s9   [11] = {ID_WIDTH{1'b0}};
	s6  [11] = {1{1'b0}};
	s10[11] = 1'b0;
	s11[11] = 1'b0;
`endif
`ifdef ATCBMC300_MST12_SUPPORT
	s2  [12] = mst12_addr  & {ADDR_WIDTH{mst12_connect}};
	s3   [12] = mst12_len   & {8{mst12_connect}};
	s4  [12] = mst12_size  & {3{mst12_connect}};
	s5 [12] = mst12_burst & {2{mst12_connect}};
	s7 [12] = mst12_cache & {4{mst12_connect}};
	s8  [12] = mst12_prot  & {3{mst12_connect}};
	s9   [12] = mst12_aid   & {ID_WIDTH{mst12_connect}};
	s6  [12] = mst12_lock  & mst12_connect;
	s10[12] = mst12_avalid   & mst12_connect;
	s11[12] = s26;
`else
	s2  [12] = {ADDR_WIDTH{1'b0}};
	s3   [12] = {8{1'b0}};
	s4  [12] = {3{1'b0}};
	s5 [12] = {2{1'b0}};
	s7 [12] = {4{1'b0}};
	s8  [12] = {3{1'b0}};
	s9   [12] = {ID_WIDTH{1'b0}};
	s6  [12] = {1{1'b0}};
	s10[12] = 1'b0;
	s11[12] = 1'b0;
`endif
`ifdef ATCBMC300_MST13_SUPPORT
	s2  [13] = mst13_addr  & {ADDR_WIDTH{mst13_connect}};
	s3   [13] = mst13_len   & {8{mst13_connect}};
	s4  [13] = mst13_size  & {3{mst13_connect}};
	s5 [13] = mst13_burst & {2{mst13_connect}};
	s7 [13] = mst13_cache & {4{mst13_connect}};
	s8  [13] = mst13_prot  & {3{mst13_connect}};
	s9   [13] = mst13_aid   & {ID_WIDTH{mst13_connect}};
	s6  [13] = mst13_lock  & mst13_connect;
	s10[13] = mst13_avalid   & mst13_connect;
	s11[13] = s27;
`else
	s2  [13] = {ADDR_WIDTH{1'b0}};
	s3   [13] = {8{1'b0}};
	s4  [13] = {3{1'b0}};
	s5 [13] = {2{1'b0}};
	s7 [13] = {4{1'b0}};
	s8  [13] = {3{1'b0}};
	s9   [13] = {ID_WIDTH{1'b0}};
	s6  [13] = {1{1'b0}};
	s10[13] = 1'b0;
	s11[13] = 1'b0;
`endif
`ifdef ATCBMC300_MST14_SUPPORT
	s2  [14] = mst14_addr  & {ADDR_WIDTH{mst14_connect}};
	s3   [14] = mst14_len   & {8{mst14_connect}};
	s4  [14] = mst14_size  & {3{mst14_connect}};
	s5 [14] = mst14_burst & {2{mst14_connect}};
	s7 [14] = mst14_cache & {4{mst14_connect}};
	s8  [14] = mst14_prot  & {3{mst14_connect}};
	s9   [14] = mst14_aid   & {ID_WIDTH{mst14_connect}};
	s6  [14] = mst14_lock  & mst14_connect;
	s10[14] = mst14_avalid   & mst14_connect;
	s11[14] = s28;
`else
	s2  [14] = {ADDR_WIDTH{1'b0}};
	s3   [14] = {8{1'b0}};
	s4  [14] = {3{1'b0}};
	s5 [14] = {2{1'b0}};
	s7 [14] = {4{1'b0}};
	s8  [14] = {3{1'b0}};
	s9   [14] = {ID_WIDTH{1'b0}};
	s6  [14] = {1{1'b0}};
	s10[14] = 1'b0;
	s11[14] = 1'b0;
`endif
`ifdef ATCBMC300_MST15_SUPPORT
	s2  [15] = mst15_addr  & {ADDR_WIDTH{mst15_connect}};
	s3   [15] = mst15_len   & {8{mst15_connect}};
	s4  [15] = mst15_size  & {3{mst15_connect}};
	s5 [15] = mst15_burst & {2{mst15_connect}};
	s7 [15] = mst15_cache & {4{mst15_connect}};
	s8  [15] = mst15_prot  & {3{mst15_connect}};
	s9   [15] = mst15_aid   & {ID_WIDTH{mst15_connect}};
	s6  [15] = mst15_lock  & mst15_connect;
	s10[15] = mst15_avalid   & mst15_connect;
	s11[15] = s29;
`else
	s2  [15] = {ADDR_WIDTH{1'b0}};
	s3   [15] = {8{1'b0}};
	s4  [15] = {3{1'b0}};
	s5 [15] = {2{1'b0}};
	s7 [15] = {4{1'b0}};
	s8  [15] = {3{1'b0}};
	s9   [15] = {ID_WIDTH{1'b0}};
	s6  [15] = {1{1'b0}};
	s10[15] = 1'b0;
	s11[15] = 1'b0;
`endif
end

assign s12 =    (reg_mst0_high_priority & s10[0]) ? 16'b1 :
		                        s13 ? s11 :
		    ((s10 & reg_priority_reload)!=16'h0) ? (s10 & reg_priority_reload) : s10;


assign arb_mid[3] = (~|s12[7:0]);
assign arb_mid[2] = arb_mid[3] ? (~|s12[11:08]) : (~|s12[03:00]);
assign arb_mid[1] =
            		(arb_mid[3:2]==2'h3 & (~|s12[13:12]))|
            		(arb_mid[3:2]==2'h2 & (~|s12[09:08]))|
            		(arb_mid[3:2]==2'h1 & (~|s12[05:04]))|
            		(arb_mid[3:2]==2'h0 & (~|s12[01:00]));
assign arb_mid[0] =
			(arb_mid[3:1]==3'h7 & ~s12[14]) |
			(arb_mid[3:1]==3'h6 & ~s12[12]) |
			(arb_mid[3:1]==3'h5 & ~s12[10]) |
			(arb_mid[3:1]==3'h4 & ~s12[08]) |
			(arb_mid[3:1]==3'h3 & ~s12[06]) |
			(arb_mid[3:1]==3'h2 & ~s12[04]) |
			(arb_mid[3:1]==3'h1 & ~s12[02]) |
			(arb_mid[3:1]==3'h0 & ~s12[00]) ;

assign aid = {s0,s1};
assign slv_aready = ~(avalid & ~aready) & outstanding_ready;
assign addr_outstanding_en = (slv_aready & |s10);
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		avalid <= 1'b0;
	else
		avalid <= (slv_aready & |s10) | (avalid & ~aready);
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		addr	<= {ADDR_WIDTH{1'b0}};
		len	<= 8'h0;
		size	<= 3'h0;
		burst	<= 2'h0;
		cache	<= 4'h0;
		lock	<= 1'b0;
		prot	<= 3'h0;
		s0	<= {ID_WIDTH{1'b0}};
		s1	<= 4'h0;
	end else if (|s10 & slv_aready) begin
		addr	<= s2[arb_mid];
		len	<= s3[arb_mid];
		size	<= s4[arb_mid];
		burst	<= s5[arb_mid];
		cache	<= s7[arb_mid];
		lock	<= s6[arb_mid];
		prot	<= s8[arb_mid];
		s0	<= s9[arb_mid];
		s1	<= arb_mid;
	end
end
endmodule
