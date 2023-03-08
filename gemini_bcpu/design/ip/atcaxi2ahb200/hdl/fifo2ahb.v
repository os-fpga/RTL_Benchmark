// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module fifo2ahb(
	  haddr,
	  htrans,
	  hready,
	  hresp,
	  hwrite,
	  hsize,
	  hburst,
	  hprot,
	  hwdata,
	  hrdata,
	  rcmdq_rdata,
	  rcmdq_empty,
	  rcmdq_rd,
	  wcmdq_rdata,
	  wcmdq_empty,
	  wcmdq_rd,
	  wdq_rdata,
	  wdq_empty,
	  wdq_rd,
	  rdq_wdata,
	  rdq_wr,
	  rdq_almost_full,
	  rdq_full,
	  brespq_wdata,
	  brespq_wr,
	  brespq_almost_full,
	  brespq_full,
	  clk,
	  resetn
);
parameter ID_WIDTH   = 4;
parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
localparam CMD_WIDTH   = 2+2+8+2+3+ID_WIDTH+ADDR_WIDTH;
localparam RDATA_WIDTH = 1+1+ID_WIDTH+DATA_WIDTH;
localparam WDATA_WIDTH = (DATA_WIDTH/8)+DATA_WIDTH;
localparam BRESP_WIDTH = 1+ID_WIDTH;
localparam NARROW_WSTRB_NUM = 64/DATA_WIDTH;

output [ADDR_WIDTH-1:0]	haddr;
output [1:0]	htrans;
input		hready;
input 		 hresp;
output		hwrite;
output [2:0]	 hsize;
output [2:0]	hburst;
output [3:0]	 hprot;
output [DATA_WIDTH-1:0]  hwdata;
input [DATA_WIDTH-1:0]  hrdata;
input [CMD_WIDTH-1:0] rcmdq_rdata;
input rcmdq_empty;
output rcmdq_rd;
input [CMD_WIDTH-1:0] wcmdq_rdata;
input wcmdq_empty;
output wcmdq_rd;


input [WDATA_WIDTH-1:0] wdq_rdata;
input wdq_empty;
output wdq_rd;

output [RDATA_WIDTH-1:0]  rdq_wdata;
output        rdq_wr;
input         rdq_almost_full;
input         rdq_full;

output [BRESP_WIDTH-1:0]  brespq_wdata;
output        brespq_wr;
input         brespq_almost_full;
input         brespq_full;


input clk;
input resetn;
localparam NDS_HTRANS_IDLE     =    2'b00;
localparam NDS_HTRANS_BUSY     =    2'b01;
localparam NDS_HTRANS_NSEQ     =    2'b10;
localparam NDS_HTRANS_SEQ      =    2'b11;
localparam NDS_HRESP_OK        =  1'b0;
localparam NDS_HRESP_ERROR     =  1'b1;
localparam NDS_HSIZE_BYTE      =    2'b00;
localparam NDS_HSIZE_HALFWORD  =    2'b01;
localparam NDS_HSIZE_WORD      =    2'b10;
localparam NDS_HSIZE_64        =    2'b11;
localparam NDS_HBURST_SINGLE   =     3'b000;
localparam NDS_HBURST_INCR     =     3'b001;
localparam NDS_HBURST_WRAP4    =     3'b010;
localparam NDS_HBURST_INCR4    =     3'b011;
localparam NDS_HBURST_WRAP8    =     3'b100;
localparam NDS_HBURST_INCR8    =     3'b101;
localparam NDS_HBURST_WRAP16   =     3'b110;
localparam NDS_HBURST_INCR16   =     3'b111;

localparam NDS_AXI_WRAP            = 2'h2;
localparam NDS_AXI_INCR            = 2'h1;
localparam NDS_AXI_FIX             = 2'h0;


localparam S_IDLE                       = 4'h0,
	  S_BUSY_WAIT_RESP_READY_1     = 4'h1,
	  S_BUSY_WAIT_RESP_READY_2     = 4'h2,
	  S_NSEQ_ADDR                  = 4'h3,
	   S_SEQ_ADDR                  = 4'h4,
	  S_NSEQ_ADDR_DATA             = 4'h5,
	   S_SEQ_ADDR_DATA             = 4'h6,
          S_IDLE_LAST_DATA             = 4'h7,
	  S_IDLE_HWDATA                = 4'h8,
          S_IDLE_WAIT_WVALID           = 4'h9,
	  S_BUSY_WAIT_WVALID           = 4'ha,
	  S_BUSY_HWDATA                = 4'hb,
	  S_BUSY_HRDATA                = 4'hc,
	  S_IDLE_HDATA_WAIT_RESP_READY = 4'hd,
          S_IDLE_WAIT_RESP_READY_1     = 4'he,
 	  S_IDLE_WAIT_RESP_READY_2     = 4'hf;


localparam S_RW_ADDR_DATA_READY         = 2'h0,
	  S_PREF_WDATA             = 2'h1,
	  S_PEND_AWADDR            = 2'h2,
	  S_PEND_AWADDR_PREF_WDATA = 2'h3;

localparam DW    = 4'h2;
localparam W0    = 4'h0;
localparam W4    = 4'h1;
localparam HW0   = 4'h7;
localparam HW2   = 4'h4;
localparam HW4   = 4'h5;
localparam HW6   = 4'h6;
localparam BYTE0 = 4'hf;
localparam BYTE1 = 4'h8;
localparam BYTE2 = 4'h9;
localparam BYTE3 = 4'ha;
localparam BYTE4 = 4'hb;
localparam BYTE5 = 4'hc;
localparam BYTE6 = 4'hd;
localparam BYTE7 = 4'he;

wire [ADDR_WIDTH-1:0] s0 = wcmdq_rdata[ADDR_WIDTH-1:0]                                 ;
wire [ID_WIDTH-1:0]   s1   = wcmdq_rdata[ID_WIDTH+ADDR_WIDTH-1  : ADDR_WIDTH]            ;
wire [2:0]            s2 = wcmdq_rdata[ID_WIDTH+ADDR_WIDTH+2  : ID_WIDTH+ADDR_WIDTH]   ;
wire [1:0]           s3 = wcmdq_rdata[ID_WIDTH+ADDR_WIDTH+4  : ID_WIDTH+ADDR_WIDTH+3] ;
wire [7:0]            s4  = wcmdq_rdata[ID_WIDTH+ADDR_WIDTH+12 : ID_WIDTH+ADDR_WIDTH+5] ;
wire [1:0]           s5 = wcmdq_rdata[ID_WIDTH+ADDR_WIDTH+14 : ID_WIDTH+ADDR_WIDTH+13];
wire [2:0]            s6 = {wcmdq_rdata[ID_WIDTH+ADDR_WIDTH+16],1'b0,wcmdq_rdata[ID_WIDTH+ADDR_WIDTH+15]};
wire                 s7 = ~wcmdq_empty;
wire        s8;
wire        wcmdq_rd = s7 & s8;
wire [ADDR_WIDTH-1:0] s9  =  rcmdq_rdata[ADDR_WIDTH-1:0]                                 ;
wire [ID_WIDTH-1:0]   s10    =  rcmdq_rdata[ID_WIDTH+ADDR_WIDTH-1  : ADDR_WIDTH]            ;
wire [2:0]            s11  =  rcmdq_rdata[ID_WIDTH+ADDR_WIDTH+2  : ID_WIDTH+ADDR_WIDTH]   ;
wire [1:0]            s12 =  rcmdq_rdata[ID_WIDTH+ADDR_WIDTH+4  : ID_WIDTH+ADDR_WIDTH+3] ;
wire [7:0]            s13   =  rcmdq_rdata[ID_WIDTH+ADDR_WIDTH+12 : ID_WIDTH+ADDR_WIDTH+5] ;
wire [1:0]            s14 =  rcmdq_rdata[ID_WIDTH+ADDR_WIDTH+14 : ID_WIDTH+ADDR_WIDTH+13];
wire [2:0]            s15 = {rcmdq_rdata[ID_WIDTH+ADDR_WIDTH+16],1'b0,rcmdq_rdata[ID_WIDTH+ADDR_WIDTH+15]};
wire                  s16 = ~rcmdq_empty;
wire        s17;
wire        rcmdq_rd = s16 & s17;
wire [DATA_WIDTH-1:0]  s18;
wire [ID_WIDTH-1:0] s19;
wire [1:0]   s20;
wire         s21;
assign rdq_wdata = {s19, s20[1], s21, s18};
wire        s22;
wire        s23 = ~rdq_full;
wire        rdq_wr = s22 & s23;
wire [DATA_WIDTH-1:0]  s24 = wdq_rdata[DATA_WIDTH-1:0];
wire [(DATA_WIDTH/8)-1:0] s25 = wdq_rdata[(DATA_WIDTH/8)+DATA_WIDTH-1:DATA_WIDTH];
wire        s26 = ~wdq_empty;
wire        s27;
wire        wdq_rd = s26 & s27;
wire [ID_WIDTH-1:0] s28;
wire [1:0] s29;
wire       s30;
wire       s31 = ~brespq_full;
assign brespq_wdata = {s29[1],s28};
assign brespq_wr = s30 & s31;
reg [1:0]	htrans;
reg [1:0]	s32;
reg		hwrite;
reg [2:0]	 hsize;
reg [2:0]	hburst;
reg [3:0]	 hprot;
reg [ADDR_WIDTH-1:0] haddr;
reg [DATA_WIDTH-1:0] hwdata;
reg [DATA_WIDTH-1:0] s33;
reg [7:0]            s34;
reg [ID_WIDTH-1:0]   s35;
reg [ID_WIDTH-1:0]   s36;
reg s37;
reg s38;
reg s39;
reg s40;
reg       s41;
reg [7:0] s42;
reg [7:0] s43;
reg       s44;
reg s45;

reg s46;
reg s47;
reg s48;
reg s49;
reg s50;
reg s51;
reg [3:0] s52;
wire [7:0] s53;
wire s54;
wire s55 =
	               s52 == HW0 |
	               s52 == HW2 |
	               s52 == HW4 |
	               s52 == HW6 ;
wire s56 =
	               s52 == W0 |
	               s52 == W4 ;
wire s57 =
	               s52 == DW ;

wire [ADDR_WIDTH-1:0] s58;
wire s59 = (hburst==NDS_HBURST_INCR) & (&haddr[9:3]) &  (hsize==3'h2 ?  haddr[2]   :
                                                                    hsize==3'h1 ? &haddr[2:1] :
                                                                    hsize==3'h0 ? &haddr[2:0] : 1'b1);
wire s60 = ((htrans==NDS_HTRANS_NSEQ) & ~s48) |
                 (htrans==NDS_HTRANS_SEQ);
wire s61 = (s49 & ~s39);
wire s62 = (s50 & (htrans==NDS_HTRANS_IDLE) & ~s39 & ~s40);
wire s63 = s48 & htrans==NDS_HTRANS_NSEQ;
wire s64 = ((hready & s60 & ~s45) | (s62 & s26 & ~s45));
wire s65 = s45 & ((s60 & hready) | ((htrans==NDS_HTRANS_IDLE) & ~(s46 & hresp & ~hready) & ~s49 & ~s50 & ~s39 & ~s40));
assign s27   = (s7 & (~s16 | rdq_full | s41) & ~brespq_full & s65) |
                  (s62 & ~s45) |
                  (hwrite & ((hready & ~s45 & htrans[1]) | (s40 & (hready | ~(s46 & hresp))) | (htrans==NDS_HTRANS_BUSY)));
assign s30 = ( s38 & hready &  s47);
assign s22 = (~s38 & hready & s46);
assign s28 = s36;
assign s19 = s28;
assign s18 = hrdata;
assign s29 = {(hresp | s44),1'b0};
assign s20 = {hresp,1'b0};
assign s21 = (~s38 & s47);

assign s8  = (~s16 | rdq_full | s41) & s26 & ~brespq_full & s65;
assign s17  = ~(s41 & s7 & s26 & ~brespq_full) & ~rdq_full & s65;

always@(posedge clk or negedge resetn)
  if(~resetn)
    s41 <= 1'b0;
  else if((s7 | (s26 & ~hwrite)) & ~s8 & (rcmdq_rd | ~s16))
    s41 <= 1'b1;
  else if(wcmdq_rd)
    s41 <= 1'b0;



wire s66 = hwrite ? ~s26 : rdq_almost_full;
wire s67 = (wcmdq_rd & (s54 | (s4==8'h0 & (|s53))));
wire s68 = s45 ? (s67 | rcmdq_rd | s48) :
                                         (s59 | (hburst==NDS_HBURST_SINGLE));
wire s69 =
			(   rdq_almost_full & rcmdq_rd) |
                        (brespq_almost_full & wcmdq_rd) |
                        (s45 ? (~rcmdq_rd & ~s67 & ~s48) :
                                          (s66 & (s59 | (hburst==NDS_HBURST_SINGLE))));
wire s70 = s66 & ~s45 & ~(s59 | (hburst==NDS_HBURST_SINGLE));

wire s71 = hwrite & s26;
wire s72 =  hwrite & (~brespq_almost_full | ~( s38 & s46)) & ~brespq_full;
wire s73 = ~hwrite & (~rdq_almost_full    | ~(~s38 & s46)) & ~rdq_full;
wire s74 = (((~s49 & ~s50 & s72) | s73) & ~(s46 & hresp & ~hready));
wire s75 = ((s71 | s73) & ~(s46 & hresp & ~hready));
wire s76 = (s39 & s74) |
                            (s40 & s75) ;

always@(posedge clk or negedge resetn)
  if(~resetn)
    s39 <= 1'b0;
  else if((   rdq_almost_full & rcmdq_rd) |
          (brespq_almost_full & wcmdq_rd))
    s39 <= 1'b1;
  else if(((s72 | s73) & ~(s46 & hresp & ~hready)) |
           (s72 & (s49 | s50)))
    s39 <= 1'b0;

always@(posedge clk or negedge resetn)
  if(~resetn)
    s40 <= 1'b0;
  else if(s66 & ~s45 & hready & htrans[1] & (s59 | (hburst==NDS_HBURST_SINGLE)))
    s40 <= 1'b1;
  else if(s75)
    s40 <= 1'b0;

always@(posedge clk or negedge resetn)
  if(~resetn)
    htrans <= NDS_HTRANS_IDLE;
  else
    htrans <= s32;

always@(*)
   case(htrans)
	NDS_HTRANS_NSEQ,
        NDS_HTRANS_SEQ:
		if(~hready)
             		s32 = htrans;
		else if(hready & s69)
             		s32 = NDS_HTRANS_IDLE;
		else if(hready & s70)
             		s32 = NDS_HTRANS_BUSY;
		else if(hready & s68)
             		s32 = NDS_HTRANS_NSEQ;
		else
             		s32 = NDS_HTRANS_SEQ;
	NDS_HTRANS_BUSY:
		if(s71 | s73)
             		s32 = NDS_HTRANS_SEQ;
		else
             		s32 = NDS_HTRANS_BUSY;

	default:
		if(           s76  |
		   (   ~rdq_almost_full & rcmdq_rd) |
                   (~brespq_almost_full & s67))
             		s32 = NDS_HTRANS_NSEQ;
		else
             		s32 = NDS_HTRANS_IDLE;
   endcase


always@(*)
  if(rcmdq_rd)
    s43 = s13[7:0];
  else if(wcmdq_rd)
    s43 = s4[7:0];
  else
    s43 = s42 - {7'h0,s64};

always@(posedge clk or negedge resetn)
  if(~resetn) begin
    s42 <= 8'h0;
    s45 <= 1'b1;
  end else begin
    s42 <= s43;
    s45 <= s43==8'h0;
  end

always@(posedge clk or negedge resetn)
  if(~resetn) begin
	s47 <= 1'b0;
	s46 <= 1'b0;
  end else if(hready) begin
	s47  <= ((s60 | s62) & s45) | s61;
	s46 <= s60;
  end

wire [9:0] s77 = (s11==3'h0) ? {6'h0,s13[3:0]} :
                             (s11==3'h1) ? {5'h0,s13[3:0],1'b1} :
                             (s11==3'h2) ? {4'h0,s13[3:0],2'h3} :
                                              {3'h0,s13[3:0],3'h7};
wire [9:0] s78 = s9[9:0] & ({6'h0,s13[3:0]} << s11);
wire [9:0] s79 = ((s9[9:0] & ~s77) | s77);
wire s80 =  (s79==10'h3ff) & (s78!=10'h0);

wire [9:0] s81 = (s2==3'h0) ? {6'h0,s4[3:0]} :
                             (s2==3'h1) ? {5'h0,s4[3:0],1'b1} :
                             (s2==3'h2) ? {4'h0,s4[3:0],2'h3} :
                                              {3'h0,s4[3:0],3'h7};
wire [9:0] s82 = s0[9:0] & ({6'h0,s4[3:0]} << s2);
wire [9:0] s83 = ((s0[9:0] & ~s81) | s81);
wire s84 =  (s83==10'h3ff) & (s82!=10'h0);
always@(posedge clk or negedge resetn)
  if(~resetn)
     hburst <= 3'b0;
  else if(rcmdq_rd)
    hburst <=
	     ((s14==NDS_AXI_WRAP  & s13[7:0]==8'hf)  ? NDS_HBURST_WRAP16 :
	      (s14==NDS_AXI_WRAP  & s13[7:0]==8'h7)  ? NDS_HBURST_WRAP8 :
	      (s14==NDS_AXI_WRAP  & s13[7:0]==8'h3)  ? NDS_HBURST_WRAP4 :
	      (s14==NDS_AXI_INCR  & s13[7:0]==8'hf & ~s80)  ? NDS_HBURST_INCR16 :
	      (s14==NDS_AXI_INCR  & s13[7:0]==8'h7 & ~s80)  ? NDS_HBURST_INCR8 :
	      (s14==NDS_AXI_INCR  & s13[7:0]==8'h3 & ~s80)  ? NDS_HBURST_INCR4 :
	     ((s14==NDS_AXI_WRAP &  s13[7:0]==8'h1) |
              (s14==NDS_AXI_FIX) | (s13[7:0]==8'h0))?   NDS_HBURST_SINGLE : NDS_HBURST_INCR);
  else if(wcmdq_rd)
    hburst <=
	     ((s5==NDS_AXI_WRAP  & s4[7:0]==8'hf)  ? NDS_HBURST_WRAP16 :
	      (s5==NDS_AXI_WRAP  & s4[7:0]==8'h7)  ? NDS_HBURST_WRAP8 :
	      (s5==NDS_AXI_WRAP  & s4[7:0]==8'h3)  ? NDS_HBURST_WRAP4 :
	      (s5==NDS_AXI_INCR  & s4[7:0]==8'hf & ~s84)  ? NDS_HBURST_INCR16 :
	      (s5==NDS_AXI_INCR  & s4[7:0]==8'h7 & ~s84)  ? NDS_HBURST_INCR8 :
	      (s5==NDS_AXI_INCR  & s4[7:0]==8'h3 & ~s84)  ? NDS_HBURST_INCR4 :
	     ((s5==NDS_AXI_WRAP &  s4[7:0]==8'h1) |
              (s5==NDS_AXI_FIX) | (s4[7:0]==8'h0))?   NDS_HBURST_SINGLE : NDS_HBURST_INCR);

always@(posedge clk or negedge resetn)
	if(~resetn)
		s37 <= 1'b0;
  	else if(rcmdq_rd)
		s37 <= (s14==NDS_AXI_WRAP & s13[7:0]==8'h1);
  	else if(wcmdq_rd)
		s37 <= (s5==NDS_AXI_WRAP & s4[7:0]==8'h1);

wire [ADDR_WIDTH-1:0] s85 = {{ADDR_WIDTH-1{1'b0}},htrans[1]} << hsize;
wire [ADDR_WIDTH-1:0] s86 = haddr + s85;
wire [ADDR_WIDTH-1:0] s87 = ({ADDR_WIDTH{(hburst==NDS_HBURST_INCR)}}   |
                                         {{ADDR_WIDTH-10{1'b0}},
					 {10{(hburst==NDS_HBURST_INCR16) |
                                             (hburst==NDS_HBURST_INCR8)  |
                                             (hburst==NDS_HBURST_INCR4)
                                         }}} |
                                         {{ADDR_WIDTH-4{1'b0}},
                                          (hburst==NDS_HBURST_WRAP16),
                                         ((hburst==NDS_HBURST_WRAP16)|
                                          (hburst==NDS_HBURST_WRAP8) ),
                                         ((hburst==NDS_HBURST_WRAP16)|
                                          (hburst==NDS_HBURST_WRAP8) |
                                          (hburst==NDS_HBURST_WRAP4) ),
                                         ((hburst==NDS_HBURST_WRAP16)|
                                          (hburst==NDS_HBURST_WRAP8) |
                                          (hburst==NDS_HBURST_WRAP4) |
                                          s37)}) << hsize;
generate
	genvar gen_i;
	for (gen_i=0; gen_i<=ADDR_WIDTH-1; gen_i=gen_i+1) begin:gen_next_haddr
		assign s58[gen_i] = s87[gen_i] ? s86[gen_i] : haddr[gen_i];
	end
endgenerate
wire [ADDR_WIDTH-1:3] s88 =
 				   s63 ?    haddr[ADDR_WIDTH-1:3]:
                                                              s0[ADDR_WIDTH-1:3];
always@(posedge clk or negedge resetn)
  if(~resetn)
	haddr <= {ADDR_WIDTH-1+1{1'b0}};
  else if(rcmdq_rd)
    	haddr <= {s9[ADDR_WIDTH-1:3],s11==3'h0 ? s9[2:0] :
                               s11==3'h1 ? {s9[2:1],1'b0} :
                               s11==3'h2 ? {s9[2],2'b0} :
				              3'h0};
  else if(wcmdq_rd & s4!=8'h0)
    	haddr <= {s0[ADDR_WIDTH-1:3],s2==3'h0 ?  s0[2:0] :
                               s2==3'h1 ? {s0[2:1],1'b0} :
                               s2==3'h2 ? {s0[2],2'b0} :
				              3'h0};
  else if((wcmdq_rd & s4==8'h0) | (s63 & hready))
    	haddr <= {s88[ADDR_WIDTH-1:3],
		  (s52==BYTE4 | s52==BYTE5 |
		   s52==BYTE6 | s52==BYTE7 |
		   s52==HW6   | s52==HW4   |
                   s52==W4),
		  (s52==BYTE2 | s52==BYTE3 |
                   s52==BYTE6 | s52==BYTE7 |
		   s52==HW6   | s52==HW2   ),
		  (s52==BYTE1 | s52==BYTE3 |
                   s52==BYTE5 | s52==BYTE7)};
  else if(s64)
	 haddr <= s58;


always@(posedge clk or negedge resetn)
  if(~resetn)
	hsize <= 3'h0;
  else if(rcmdq_rd)
    	hsize <= s11;
  else if(wcmdq_rd & s4!=8'h0)
    	hsize <= s2;
  else if(wcmdq_rd | (s63 & hready))
    	hsize <= {1'b0,(s57 | s56),
		       (s57 | s55)};

always@(posedge clk or negedge resetn)
      if(~resetn)
        hwrite <= 1'b0;
  else if(rcmdq_rd)
    	hwrite <= 1'b0;
  else if(wcmdq_rd)
    	hwrite <= 1'b1;

always@(posedge clk or negedge resetn)
      if(~resetn)
        s38 <= 1'b0;
  else if(((htrans==NDS_HTRANS_NSEQ) | (htrans==NDS_HTRANS_SEQ) | s61 | s62) & hready)
    	s38 <= hwrite;

always@(posedge clk or negedge resetn)
      if(~resetn)
        hprot <= 4'b0;
  else if(rcmdq_rd)
    	hprot <= {s12[1:0],s15[0],~s15[2]};
  else if(wcmdq_rd)
    	hprot <= {s3[1:0],s6[0],~s6[2]};


always@(posedge clk or negedge resetn)
      if(~resetn)
	s35   <= {ID_WIDTH-1+1{1'b0}};
  else if(rcmdq_rd)
	s35   <= s10;
  else if(wcmdq_rd)
	s35   <= s1;

always@(posedge clk or negedge resetn)
      if(~resetn)
	s36   <= {ID_WIDTH-1+1{1'b0}};
  else if((s60 | s61 | s62) & hready)
	s36   <= s35;

always@(posedge clk or negedge resetn)
      if(~resetn)
	s51 <= 1'b0;
      else if(wcmdq_rd)
	s51 <= (s2==3'h1 &   s0[0])    |
			   (s2==3'h2 & (|s0[1:0])) |
			   (s2==3'h3 & (|s0[2:0])) ;
      else if(s45 & ~s40 & ~s39 & hready)
	s51 <= 1'b0;

always@(posedge clk or negedge resetn)
      if(~resetn)
	     	s44 <= 1'b0;
	else
	     	s44 <= ((s51 | s50) & hready) |
                                      (~s47 & s38 & hready & hresp) |
                                      (~(s47 & hready) & s44);
always@(posedge clk or negedge resetn)
      if(~resetn)
		s33 <= {DATA_WIDTH-1+1{1'b0}};
	else if(s26 & s27)
		s33 <= s24;

always@(posedge clk or negedge resetn)
      	if(~resetn)
		hwdata <= {DATA_WIDTH-1+1{1'b0}};
	else if(hwrite & hready & ((htrans==NDS_HTRANS_NSEQ) | (htrans==NDS_HTRANS_SEQ)))
		hwdata <= s33;

wire [7:0] s89 = {NARROW_WSTRB_NUM{s25[(DATA_WIDTH/8)-1:0]}};
wire [2:0] s90 = htrans[1] ? s58[2:0] : haddr[2:0];
wire [7:0] s91 = wcmdq_rd ?
			(s2==3'h0 ? (8'b1    <<  s0[2:0]) :
                         s2==3'h1 ? (8'b11   << {s0[2:1],1'b0}) :
		         s2==3'h2 ? (8'b1111 << {s0[2],2'b0}) :
                                       ({8{1'b1}})) :
			(hsize==3'h0  ? (8'b1    <<  s90[2:0]) :
                         hsize==3'h1  ? (8'b11   << {s90[2:1],1'b0}) :
		         hsize==3'h2  ? (8'b1111 << {s90[2],2'b0}) :
                                       ({8{1'b1}}));
assign s53 = (s89 &         s91) ;

wire [7:0] s92 = s48 ? s34 : s53;
wire [7:0] s93 = s92 &
					     ~({   s52==BYTE7,   s52==BYTE6,
						   s52==BYTE5,   s52==BYTE4,
						   s52==BYTE3,   s52==BYTE2,
						   s52==BYTE1,   s52==BYTE0} |
					       {{2{s52==HW6}},{2{s52==HW4}},
						{2{s52==HW2}},{2{s52==HW0}}} |
					       {{4{s52==W4}}, {4{s52==W0}}} |
						{8{s52==DW}});
wire [2:0] s94 = wcmdq_rd ? s2 : hsize;
assign s54 = s94==3'h3 ?  (s53==8'hff) :
			      s94==3'h2 ? ((s53==8'h0f) |
                                                          (s53==8'hf0)) :
			      s94==3'h1 ? ((s53==8'h03) |
				  			  (s53==8'h30) |
				                          (s53==8'h0c) |
                                                          (s53==8'hc0)) :
				  ((s53==8'h01) | (s53==8'h10) |
				   (s53==8'h02) | (s53==8'h20) |
				   (s53==8'h04) | (s53==8'h40) |
				   (s53==8'h08) | (s53==8'h80)) ;

wire s95 =
 				  (s34==8'hff) |
				  (s34==8'h0f) | (s34==8'hf0) |
				  (s34==8'h03) | (s34==8'h30) |
				  (s34==8'h0c) | (s34==8'hc0) |
				  (s34==8'h01) | (s34==8'h10) |
				  (s34==8'h02) | (s34==8'h20) |
				  (s34==8'h04) | (s34==8'h40) |
				  (s34==8'h08) | (s34==8'h80) ;

always@(posedge clk or negedge resetn)
      	if(~resetn)
	  s48 <= 1'b0;
  	else if(wcmdq_rd & (s4==8'h0))
	  s48 <= ~(
 				 	 (s53==8'hff) | (s53==8'h00) |
				 	 (s53==8'h0f) | (s53==8'hf0) |
				 	 (s53==8'h03) | (s53==8'h30) |
				 	 (s53==8'h0c) | (s53==8'hc0) |
				 	 (s53==8'h01) | (s53==8'h10) |
				 	 (s53==8'h02) | (s53==8'h20) |
				 	 (s53==8'h04) | (s53==8'h40) |
				 	 (s53==8'h08) | (s53==8'h80)) ;
        else if(s63 & hready)
	  s48 <= ~(
 				 	 (s34==8'hff) | (s34==8'h00) |
				 	 (s34==8'h0f) | (s34==8'hf0) |
				 	 (s34==8'h03) | (s34==8'h30) |
				 	 (s34==8'h0c) | (s34==8'hc0) |
				 	 (s34==8'h01) | (s34==8'h10) |
				 	 (s34==8'h02) | (s34==8'h20) |
				 	 (s34==8'h04) | (s34==8'h40) |
				 	 (s34==8'h08) | (s34==8'h80)) ;



always@(posedge clk or negedge resetn)
      	if(~resetn)
	  s50 <= 1'b0;
	else
	  s50 <= (~s54 & (wcmdq_rd ? (s4!=8'h0): wdq_rd)) |
                            (s50 & ~(s45 & ~s40 & ~s39 & (htrans!=NDS_HTRANS_BUSY) & hready));

always@(posedge clk or negedge resetn)
      	if(~resetn)
	  s49 <= 1'b0;
	else
	  s49 <= (wcmdq_rd & (~|s53) & (s4==8'h0)) | (s49 & (s39 | ~hready));

always@(posedge clk or negedge resetn)
      	if(~resetn)
		s34 <= 8'h0;
  	else if(wcmdq_rd | (s63 & hready))
		s34 <= s93;



always @(*) begin
  	  if(s92[1:0]==2'b01)
             s52 = BYTE0;
  	  else if(s92[1:0]==2'b10)
             s52 = BYTE1;
  	  else if(s92[3:0]==4'b0100)
             s52 = BYTE2;
  	  else if(s92[3:0]==4'b1000)
             s52 = BYTE3;
  	  else if(s92[1:0]==2'b11 & s92[3:2]!=2'b11)
             s52 = HW0;
  	  else if(s92[3:0]==4'b1100)
             s52 = HW2;
  	  else if((s92[7:0]==8'h0) |
		 (s92[3:0]==4'b1111 & s92[7:4]!=4'b1111))
             s52 = W0;
  	  else if(s92[3:0]==4'b0000 & s92[5:4]==2'b01)
             s52 = BYTE4;
  	  else if(s92[3:0]==4'b0000 & s92[5:4]==2'b10)
             s52 = BYTE5;
  	  else if(s92[3:0]==4'b0000 & s92[7:4]==4'b0100)
             s52 = BYTE6;
  	  else if(s92[3:0]==4'b0000 & s92[7:4]==4'b1000)
             s52 = BYTE7;
  	  else if(s92[3:0]==4'b0000 & s92[5:4]==2'b11 & s92[7:6]!=2'b11)
             s52 = HW4;
  	  else if(s92[3:0]==4'b0000 & s92[5:4]==2'b00 & s92[7:6]==2'b11)
             s52 = HW6;
  	  else if(s92[3:0]==4'b0000 & s92[7:4]==4'b1111)
             s52 = W4;
          else
             s52 = DW;
end
endmodule
