// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcbmc301_config.vh"
`include "atcbmc301_const.vh"

module atcbmc301_ds_addr_ctrl (
`ifdef ATCBMC301_MST0_SUPPORT
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
`ifdef ATCBMC301_MST1_SUPPORT
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


`ifdef ATCBMC301_MST0_SUPPORT
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
`ifdef ATCBMC301_MST1_SUPPORT
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

`ifdef ATCBMC301_MST0_SUPPORT
reg s14;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s14 <= 1'b0;
	else
		s14 <= mst0_connect & ~((arb_mid==4'd0) & slv_aready) &
					   ((~s13 & mst0_avalid & reg_priority_reload[0]) | s14);
end
`endif
`ifdef ATCBMC301_MST1_SUPPORT
reg s15;
always @(posedge aclk or negedge aresetn) begin
	if (!aresetn)
		s15 <= 1'b0;
	else
		s15 <= mst1_connect & ~((arb_mid==4'd1) & slv_aready) &
					   ((~s13 & mst1_avalid & reg_priority_reload[1]) | s15);
end
`endif

always @* begin
`ifdef ATCBMC301_MST0_SUPPORT
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
`ifdef ATCBMC301_MST1_SUPPORT
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
