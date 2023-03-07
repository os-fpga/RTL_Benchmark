// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"

module atcbmc200_ahbslv_rf(
                            	  hrdata,
                            	  hready,
                            	  hresp,
                            	  hclk,
                            	  hresetn,
                            	  hready_in,
                            	  haddr,
                            	  hsel,
                            	  hsize,
                            	  htrans,
                            	  hwdata,
                            	  hwrite,
                            	  init_priority,
                            `ifdef ATCBMC200_AHB_MST0
                            	  mst0_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST1
                            	  mst1_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST2
                            	  mst2_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST3
                            	  mst3_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST4
                            	  mst4_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST5
                            	  mst5_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST6
                            	  mst6_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST7
                            	  mst7_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST8
                            	  mst8_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST9
                            	  mst9_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST10
                            	  mst10_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST11
                            	  mst11_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST12
                            	  mst12_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST13
                            	  mst13_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST14
                            	  mst14_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_MST15
                            	  mst15_sel_err,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV0
                            	  slv0_base,
                            	  slv0_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV1
                            	  slv1_base,
                            	  slv1_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV2
                            	  slv2_base,
                            	  slv2_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV3
                            	  slv3_base,
                            	  slv3_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV4
                            	  slv4_base,
                            	  slv4_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV5
                            	  slv5_base,
                            	  slv5_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV6
                            	  slv6_base,
                            	  slv6_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV7
                            	  slv7_base,
                            	  slv7_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV8
                            	  slv8_base,
                            	  slv8_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV9
                            	  slv9_base,
                            	  slv9_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV10
                            	  slv10_base,
                            	  slv10_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV11
                            	  slv11_base,
                            	  slv11_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV12
                            	  slv12_base,
                            	  slv12_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV13
                            	  slv13_base,
                            	  slv13_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV14
                            	  slv14_base,
                            	  slv14_size,
                            `endif
                            `ifdef ATCBMC200_AHB_SLV15
                            	  slv15_base,
                            	  slv15_size,
                            `endif
                            	  bmc_intr,
                            	  mst0_highest_en,
                            	  ctrl_wen,
                            	  resp_mode
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;

parameter DATA_WIDTH = `ATCBMC200_DATA_WIDTH;

parameter BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;
localparam DW_RATIO = DATA_WIDTH/32;

output                     [DATA_MSB:0] hrdata;
output                                  hready;
output                            [1:0] hresp;
input                                   hclk;
input                                   hresetn;
input					hready_in;
input                      [ADDR_MSB:0] haddr;
input                                   hsel;
input                             [2:0] hsize;
input                             [1:0] htrans;
input                      [DATA_MSB:0] hwdata;
input                                   hwrite;
output                           [15:0] init_priority;

localparam HRESP_OK      = 2'b00;


`ifdef ATCBMC200_AHB_MST0
input                               mst0_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST1
input                               mst1_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST2
input                               mst2_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST3
input                               mst3_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST4
input                               mst4_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST5
input                               mst5_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST6
input                               mst6_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST7
input                               mst7_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST8
input                               mst8_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST9
input                               mst9_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST10
input                               mst10_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST11
input                               mst11_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST12
input                               mst12_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST13
input                               mst13_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST14
input                               mst14_sel_err;
`endif
`ifdef ATCBMC200_AHB_MST15
input                               mst15_sel_err;
`endif

`ifdef ATCBMC200_AHB_SLV0
output [ADDR_MSB:BASE_ADDR_LSB] slv0_base;
output                    [3:0] slv0_size;
`endif
`ifdef ATCBMC200_AHB_SLV1
output [ADDR_MSB:BASE_ADDR_LSB] slv1_base;
output                    [3:0] slv1_size;
`endif
`ifdef ATCBMC200_AHB_SLV2
output [ADDR_MSB:BASE_ADDR_LSB] slv2_base;
output                    [3:0] slv2_size;
`endif
`ifdef ATCBMC200_AHB_SLV3
output [ADDR_MSB:BASE_ADDR_LSB] slv3_base;
output                    [3:0] slv3_size;
`endif
`ifdef ATCBMC200_AHB_SLV4
output [ADDR_MSB:BASE_ADDR_LSB] slv4_base;
output                    [3:0] slv4_size;
`endif
`ifdef ATCBMC200_AHB_SLV5
output [ADDR_MSB:BASE_ADDR_LSB] slv5_base;
output                    [3:0] slv5_size;
`endif
`ifdef ATCBMC200_AHB_SLV6
output [ADDR_MSB:BASE_ADDR_LSB] slv6_base;
output                    [3:0] slv6_size;
`endif
`ifdef ATCBMC200_AHB_SLV7
output [ADDR_MSB:BASE_ADDR_LSB] slv7_base;
output                    [3:0] slv7_size;
`endif
`ifdef ATCBMC200_AHB_SLV8
output [ADDR_MSB:BASE_ADDR_LSB] slv8_base;
output                    [3:0] slv8_size;
`endif
`ifdef ATCBMC200_AHB_SLV9
output [ADDR_MSB:BASE_ADDR_LSB] slv9_base;
output                    [3:0] slv9_size;
`endif
`ifdef ATCBMC200_AHB_SLV10
output [ADDR_MSB:BASE_ADDR_LSB] slv10_base;
output                    [3:0] slv10_size;
`endif
`ifdef ATCBMC200_AHB_SLV11
output [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
output                    [3:0] slv11_size;
`endif
`ifdef ATCBMC200_AHB_SLV12
output [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
output                    [3:0] slv12_size;
`endif
`ifdef ATCBMC200_AHB_SLV13
output [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
output                    [3:0] slv13_size;
`endif
`ifdef ATCBMC200_AHB_SLV14
output [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
output                    [3:0] slv14_size;
`endif
`ifdef ATCBMC200_AHB_SLV15
output [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
output                    [3:0] slv15_size;
`endif

output                              bmc_intr;
output                              mst0_highest_en;
output                              ctrl_wen;
output                              resp_mode;


`ifdef ATCBMC200_AHB_SLV0
parameter [ADDR_MSB:0] AHB_SLV0_BASE = `ATCBMC200_AHB_SLV0_BASE;
assign slv0_base = AHB_SLV0_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv0_size = `ATCBMC200_AHB_SLV0_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV1
parameter [ADDR_MSB:0] AHB_SLV1_BASE = `ATCBMC200_AHB_SLV1_BASE;
assign slv1_base = AHB_SLV1_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv1_size = `ATCBMC200_AHB_SLV1_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV2
parameter [ADDR_MSB:0] AHB_SLV2_BASE = `ATCBMC200_AHB_SLV2_BASE;
assign slv2_base = AHB_SLV2_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv2_size = `ATCBMC200_AHB_SLV2_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV3
parameter [ADDR_MSB:0] AHB_SLV3_BASE = `ATCBMC200_AHB_SLV3_BASE;
assign slv3_base = AHB_SLV3_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv3_size = `ATCBMC200_AHB_SLV3_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV4
parameter [ADDR_MSB:0] AHB_SLV4_BASE = `ATCBMC200_AHB_SLV4_BASE;
assign slv4_base = AHB_SLV4_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv4_size = `ATCBMC200_AHB_SLV4_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV5
parameter [ADDR_MSB:0] AHB_SLV5_BASE = `ATCBMC200_AHB_SLV5_BASE;
assign slv5_base = AHB_SLV5_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv5_size = `ATCBMC200_AHB_SLV5_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV6
parameter [ADDR_MSB:0] AHB_SLV6_BASE = `ATCBMC200_AHB_SLV6_BASE;
assign slv6_base = AHB_SLV6_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv6_size = `ATCBMC200_AHB_SLV6_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV7
parameter [ADDR_MSB:0] AHB_SLV7_BASE = `ATCBMC200_AHB_SLV7_BASE;
assign slv7_base = AHB_SLV7_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv7_size = `ATCBMC200_AHB_SLV7_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV8
parameter [ADDR_MSB:0] AHB_SLV8_BASE = `ATCBMC200_AHB_SLV8_BASE;
assign slv8_base = AHB_SLV8_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv8_size = `ATCBMC200_AHB_SLV8_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV9
parameter [ADDR_MSB:0] AHB_SLV9_BASE = `ATCBMC200_AHB_SLV9_BASE;
assign slv9_base = AHB_SLV9_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv9_size = `ATCBMC200_AHB_SLV9_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV10
parameter [ADDR_MSB:0] AHB_SLV10_BASE = `ATCBMC200_AHB_SLV10_BASE;
assign slv10_base = AHB_SLV10_BASE[ADDR_MSB:BASE_ADDR_LSB];
assign slv10_size = `ATCBMC200_AHB_SLV10_SIZE;
`endif
`ifdef ATCBMC200_AHB_SLV11
parameter [ADDR_MSB:0] AHB_SLV11_BASE = `ATCBMC200_AHB_SLV11_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV12
parameter [ADDR_MSB:0] AHB_SLV12_BASE = `ATCBMC200_AHB_SLV12_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV13
parameter [ADDR_MSB:0] AHB_SLV13_BASE = `ATCBMC200_AHB_SLV13_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV14
parameter [ADDR_MSB:0] AHB_SLV14_BASE = `ATCBMC200_AHB_SLV14_BASE;
`endif
`ifdef ATCBMC200_AHB_SLV15
parameter [ADDR_MSB:0] AHB_SLV15_BASE = `ATCBMC200_AHB_SLV15_BASE;
`endif

`ifdef ATCBMC200_AHB_SLV11
reg [ADDR_MSB:BASE_ADDR_LSB] slv11_base;
reg                    [3:0] slv11_size;
`endif
`ifdef ATCBMC200_AHB_SLV12
reg [ADDR_MSB:BASE_ADDR_LSB] slv12_base;
reg                    [3:0] slv12_size;
`endif
`ifdef ATCBMC200_AHB_SLV13
reg [ADDR_MSB:BASE_ADDR_LSB] slv13_base;
reg                    [3:0] slv13_size;
`endif
`ifdef ATCBMC200_AHB_SLV14
reg [ADDR_MSB:BASE_ADDR_LSB] slv14_base;
reg                    [3:0] slv14_size;
`endif
`ifdef ATCBMC200_AHB_SLV15
reg [ADDR_MSB:BASE_ADDR_LSB] slv15_base;
reg                    [3:0] slv15_size;
`endif


reg                                    mst0_highest_en;
reg                                    s0;

wire                            [15:0] s1;
wire                            [15:0] init_priority;

`ifdef ATCBMC200_AHB_MST0
    reg                                  s2;
    reg                                  s3;
`endif
`ifdef ATCBMC200_AHB_MST1
    reg                                  s4;
    reg                                  s5;
`endif
`ifdef ATCBMC200_AHB_MST2
    reg                                  s6;
    reg                                  s7;
`endif
`ifdef ATCBMC200_AHB_MST3
    reg                                  s8;
    reg                                  s9;
`endif
`ifdef ATCBMC200_AHB_MST4
    reg                                  s10;
    reg                                  s11;
`endif
`ifdef ATCBMC200_AHB_MST5
    reg                                  s12;
    reg                                  s13;
`endif
`ifdef ATCBMC200_AHB_MST6
    reg                                  s14;
    reg                                  s15;
`endif
`ifdef ATCBMC200_AHB_MST7
    reg                                  s16;
    reg                                  s17;
`endif
`ifdef ATCBMC200_AHB_MST8
    reg                                  s18;
    reg                                  s19;
`endif
`ifdef ATCBMC200_AHB_MST9
    reg                                  s20;
    reg                                  s21;
`endif
`ifdef ATCBMC200_AHB_MST10
    reg                                  s22;
    reg                                  s23;
`endif
`ifdef ATCBMC200_AHB_MST11
    reg                                  s24;
    reg                                  s25;
`endif
`ifdef ATCBMC200_AHB_MST12
    reg                                  s26;
    reg                                  s27;
`endif
`ifdef ATCBMC200_AHB_MST13
    reg                                  s28;
    reg                                  s29;
`endif
`ifdef ATCBMC200_AHB_MST14
    reg                                  s30;
    reg                                  s31;
`endif
`ifdef ATCBMC200_AHB_MST15
    reg                                  s32;
    reg                                  s33;
`endif

reg                                    resp_mode;

reg				       s34;
reg				 [7:2] s35;
wire	                        [31:0] s36[0:31];
wire	                               s37[0:31];
wire	                         [3:0] s38[0:31];
reg             [((DATA_WIDTH/8)-1):0] s39;
reg             [((DATA_WIDTH/8)-1):0] s40;
reg                       [DATA_MSB:0] hrdata;
wire                      [DATA_MSB:0] s41;
wire	                        [31:0] s42[0:31];

wire                                   s43;
wire                                   s44;
reg                                    s45;
reg                                    ctrl_wen;
reg                                    s46;
`ifdef ATCBMC200_AHB_SLV11
reg         s47;
`endif
`ifdef ATCBMC200_AHB_SLV12
reg         s48;
`endif
`ifdef ATCBMC200_AHB_SLV13
reg         s49;
`endif
`ifdef ATCBMC200_AHB_SLV14
reg         s50;
`endif
`ifdef ATCBMC200_AHB_SLV15
reg         s51;
`endif



assign bmc_intr = s0 & (
`ifdef ATCBMC200_AHB_MST15
                   s32 |
`endif
`ifdef ATCBMC200_AHB_MST14
                   s30 |
`endif
`ifdef ATCBMC200_AHB_MST13
                   s28 |
`endif
`ifdef ATCBMC200_AHB_MST12
                   s26 |
`endif
`ifdef ATCBMC200_AHB_MST11
                   s24 |
`endif
`ifdef ATCBMC200_AHB_MST10
                   s22 |
`endif
`ifdef ATCBMC200_AHB_MST9
                   s20 |
`endif
`ifdef ATCBMC200_AHB_MST8
                   s18 |
`endif
`ifdef ATCBMC200_AHB_MST7
                   s16 |
`endif
`ifdef ATCBMC200_AHB_MST6
                   s14 |
`endif
`ifdef ATCBMC200_AHB_MST5
                   s12 |
`endif
`ifdef ATCBMC200_AHB_MST4
                   s10 |
`endif
`ifdef ATCBMC200_AHB_MST3
                   s8 |
`endif
`ifdef ATCBMC200_AHB_MST2
                   s6 |
`endif
`ifdef ATCBMC200_AHB_MST1
                   s4 |
`endif
`ifdef ATCBMC200_AHB_MST0
                   s2 |
`endif
                   1'b0 );

assign hready = (~s34);

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
	s34 <= 1'b0;
	s35      <= 6'h0;
    end else begin
	s34 <= (s43 & (
	        	(ctrl_wen     & s37[5]) |
	        	(s46     & s37[6]) |
`ifdef ATCBMC200_AHB_SLV11
		      	(s47    & s37[18]) |
`endif
`ifdef ATCBMC200_AHB_SLV12
		      	(s48    & s37[19]) |
`endif
`ifdef ATCBMC200_AHB_SLV13
		      	(s49    & s37[20]) |
`endif
`ifdef ATCBMC200_AHB_SLV14
		      	(s50    & s37[21]) |
`endif
`ifdef ATCBMC200_AHB_SLV15
		      	(s51    & s37[22]) |
`endif
			(s45 & s37[4]))) ;
	s35      <= haddr[7:2];
    end
end

assign hresp  = HRESP_OK;


assign s44 = hsel & hready_in & hwrite & htrans[1];


generate
if (DATA_WIDTH == 32) begin: gen_hwdata_wbe_32
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				s40[3] =  (haddr[1:0] == 2'b11) ;
				s40[2] =  (haddr[1:0] == 2'b10) ;
				s40[1] =  (haddr[1:0] == 2'b01) ;
				s40[0] =  (haddr[1:0] == 2'b00) ;
			end
			3'b001: begin
				s40[3:2] = {2{(haddr[1] == 1'b1)}};
				s40[1:0] = {2{(haddr[1] == 1'b0)}};
			end
			3'b010: begin
				s40[3:0] = {4{1'b1}};
			end
			default:
				s40 = 4'b0;
		endcase
	end
end
if (DATA_WIDTH == 64) begin: gen_hwdata_wbe_64
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				s40[7] =  (haddr[2:0] == 3'b111) ;
				s40[6] =  (haddr[2:0] == 3'b110) ;
				s40[5] =  (haddr[2:0] == 3'b101) ;
				s40[4] =  (haddr[2:0] == 3'b100) ;
				s40[3] =  (haddr[2:0] == 3'b011) ;
				s40[2] =  (haddr[2:0] == 3'b010) ;
				s40[1] =  (haddr[2:0] == 3'b001) ;
				s40[0] =  (haddr[2:0] == 3'b000) ;
			end
			3'b001: begin
				s40[7:6] = {2{(haddr[2:1] == 2'b11)}};
				s40[5:4] = {2{(haddr[2:1] == 2'b10)}};
				s40[3:2] = {2{(haddr[2:1] == 2'b01)}};
				s40[1:0] = {2{(haddr[2:1] == 2'b00)}};
			end
			3'b010: begin
				s40[7:4] = {4{(haddr[2] == 1'b1)}};
				s40[3:0] = {4{(haddr[2] == 1'b0)}};
			end
			3'b011: begin
				s40[7:0] = {8{1'b1}};
			end
			default:
				s40 = 8'b0;
		endcase
	end
end
if (DATA_WIDTH == 128) begin: gen_hwdata_wbe_128
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				s40[15] =  (haddr[3:0] == 4'b1111) ;
				s40[14] =  (haddr[3:0] == 4'b1110) ;
				s40[13] =  (haddr[3:0] == 4'b1101) ;
				s40[12] =  (haddr[3:0] == 4'b1100) ;
				s40[11] =  (haddr[3:0] == 4'b1011) ;
				s40[10] =  (haddr[3:0] == 4'b1010) ;
				s40[9] =  (haddr[3:0] == 4'b1001) ;
				s40[8] =  (haddr[3:0] == 4'b1000) ;
				s40[7] =  (haddr[3:0] == 4'b0111) ;
				s40[6] =  (haddr[3:0] == 4'b0110) ;
				s40[5] =  (haddr[3:0] == 4'b0101) ;
				s40[4] =  (haddr[3:0] == 4'b0100) ;
				s40[3] =  (haddr[3:0] == 4'b0011) ;
				s40[2] =  (haddr[3:0] == 4'b0010) ;
				s40[1] =  (haddr[3:0] == 4'b0001) ;
				s40[0] =  (haddr[3:0] == 4'b0000) ;
			end
			3'b001: begin
				s40[15:14] = {2{(haddr[3:1] == 3'b111)}};
				s40[13:12] = {2{(haddr[3:1] == 3'b110)}};
				s40[11:10] = {2{(haddr[3:1] == 3'b101)}};
				s40[9:8] = {2{(haddr[3:1] == 3'b100)}};
				s40[7:6] = {2{(haddr[3:1] == 3'b011)}};
				s40[5:4] = {2{(haddr[3:1] == 3'b010)}};
				s40[3:2] = {2{(haddr[3:1] == 3'b001)}};
				s40[1:0] = {2{(haddr[3:1] == 3'b000)}};
			end
			3'b010: begin
				s40[15:12] = {4{(haddr[3:2] == 2'b11)}};
				s40[11:8] = {4{(haddr[3:2] == 2'b10)}};
				s40[7:4] = {4{(haddr[3:2] == 2'b01)}};
				s40[3:0] = {4{(haddr[3:2] == 2'b00)}};
			end
			3'b011: begin
				s40[15:8] = {8{(haddr[3] == 1'b1)}};
				s40[7:0] = {8{(haddr[3] == 1'b0)}};
			end
			3'b100: begin
				s40[15:0] = {16{1'b1}};
			end
			default:
				s40 = 16'b0;
		endcase
	end
end
if (DATA_WIDTH == 256) begin: gen_hwdata_wbe_256
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				s40[31] =  (haddr[4:0] == 5'b11111) ;
				s40[30] =  (haddr[4:0] == 5'b11110) ;
				s40[29] =  (haddr[4:0] == 5'b11101) ;
				s40[28] =  (haddr[4:0] == 5'b11100) ;
				s40[27] =  (haddr[4:0] == 5'b11011) ;
				s40[26] =  (haddr[4:0] == 5'b11010) ;
				s40[25] =  (haddr[4:0] == 5'b11001) ;
				s40[24] =  (haddr[4:0] == 5'b11000) ;
				s40[23] =  (haddr[4:0] == 5'b10111) ;
				s40[22] =  (haddr[4:0] == 5'b10110) ;
				s40[21] =  (haddr[4:0] == 5'b10101) ;
				s40[20] =  (haddr[4:0] == 5'b10100) ;
				s40[19] =  (haddr[4:0] == 5'b10011) ;
				s40[18] =  (haddr[4:0] == 5'b10010) ;
				s40[17] =  (haddr[4:0] == 5'b10001) ;
				s40[16] =  (haddr[4:0] == 5'b10000) ;
				s40[15] =  (haddr[4:0] == 5'b01111) ;
				s40[14] =  (haddr[4:0] == 5'b01110) ;
				s40[13] =  (haddr[4:0] == 5'b01101) ;
				s40[12] =  (haddr[4:0] == 5'b01100) ;
				s40[11] =  (haddr[4:0] == 5'b01011) ;
				s40[10] =  (haddr[4:0] == 5'b01010) ;
				s40[9] =  (haddr[4:0] == 5'b01001) ;
				s40[8] =  (haddr[4:0] == 5'b01000) ;
				s40[7] =  (haddr[4:0] == 5'b00111) ;
				s40[6] =  (haddr[4:0] == 5'b00110) ;
				s40[5] =  (haddr[4:0] == 5'b00101) ;
				s40[4] =  (haddr[4:0] == 5'b00100) ;
				s40[3] =  (haddr[4:0] == 5'b00011) ;
				s40[2] =  (haddr[4:0] == 5'b00010) ;
				s40[1] =  (haddr[4:0] == 5'b00001) ;
				s40[0] =  (haddr[4:0] == 5'b00000) ;
			end
			3'b001: begin
				s40[31:30] = {2{(haddr[4:1] == 4'b1111)}};
				s40[29:28] = {2{(haddr[4:1] == 4'b1110)}};
				s40[27:26] = {2{(haddr[4:1] == 4'b1101)}};
				s40[25:24] = {2{(haddr[4:1] == 4'b1100)}};
				s40[23:22] = {2{(haddr[4:1] == 4'b1011)}};
				s40[21:20] = {2{(haddr[4:1] == 4'b1010)}};
				s40[19:18] = {2{(haddr[4:1] == 4'b1001)}};
				s40[17:16] = {2{(haddr[4:1] == 4'b1000)}};
				s40[15:14] = {2{(haddr[4:1] == 4'b0111)}};
				s40[13:12] = {2{(haddr[4:1] == 4'b0110)}};
				s40[11:10] = {2{(haddr[4:1] == 4'b0101)}};
				s40[9:8] = {2{(haddr[4:1] == 4'b0100)}};
				s40[7:6] = {2{(haddr[4:1] == 4'b0011)}};
				s40[5:4] = {2{(haddr[4:1] == 4'b0010)}};
				s40[3:2] = {2{(haddr[4:1] == 4'b0001)}};
				s40[1:0] = {2{(haddr[4:1] == 4'b0000)}};
			end
			3'b010: begin
				s40[31:28] = {4{(haddr[4:2] == 3'b111)}};
				s40[27:24] = {4{(haddr[4:2] == 3'b110)}};
				s40[23:20] = {4{(haddr[4:2] == 3'b101)}};
				s40[19:16] = {4{(haddr[4:2] == 3'b100)}};
				s40[15:12] = {4{(haddr[4:2] == 3'b011)}};
				s40[11:8] = {4{(haddr[4:2] == 3'b010)}};
				s40[7:4] = {4{(haddr[4:2] == 3'b001)}};
				s40[3:0] = {4{(haddr[4:2] == 3'b000)}};
			end
			3'b011: begin
				s40[31:24] = {8{(haddr[4:3] == 2'b11)}};
				s40[23:16] = {8{(haddr[4:3] == 2'b10)}};
				s40[15:8] = {8{(haddr[4:3] == 2'b01)}};
				s40[7:0] = {8{(haddr[4:3] == 2'b00)}};
			end
			3'b100: begin
				s40[31:16] = {16{(haddr[4] == 1'b1)}};
				s40[15:0] = {16{(haddr[4] == 1'b0)}};
			end
			3'b101: begin
				s40[31:0] = {32{1'b1}};
			end
			default:
				s40 = 32'b0;
		endcase
	end
end
if (DATA_WIDTH == 512) begin: gen_hwdata_wbe_512
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				s40[63] =  (haddr[5:0] == 6'b111111) ;
				s40[62] =  (haddr[5:0] == 6'b111110) ;
				s40[61] =  (haddr[5:0] == 6'b111101) ;
				s40[60] =  (haddr[5:0] == 6'b111100) ;
				s40[59] =  (haddr[5:0] == 6'b111011) ;
				s40[58] =  (haddr[5:0] == 6'b111010) ;
				s40[57] =  (haddr[5:0] == 6'b111001) ;
				s40[56] =  (haddr[5:0] == 6'b111000) ;
				s40[55] =  (haddr[5:0] == 6'b110111) ;
				s40[54] =  (haddr[5:0] == 6'b110110) ;
				s40[53] =  (haddr[5:0] == 6'b110101) ;
				s40[52] =  (haddr[5:0] == 6'b110100) ;
				s40[51] =  (haddr[5:0] == 6'b110011) ;
				s40[50] =  (haddr[5:0] == 6'b110010) ;
				s40[49] =  (haddr[5:0] == 6'b110001) ;
				s40[48] =  (haddr[5:0] == 6'b110000) ;
				s40[47] =  (haddr[5:0] == 6'b101111) ;
				s40[46] =  (haddr[5:0] == 6'b101110) ;
				s40[45] =  (haddr[5:0] == 6'b101101) ;
				s40[44] =  (haddr[5:0] == 6'b101100) ;
				s40[43] =  (haddr[5:0] == 6'b101011) ;
				s40[42] =  (haddr[5:0] == 6'b101010) ;
				s40[41] =  (haddr[5:0] == 6'b101001) ;
				s40[40] =  (haddr[5:0] == 6'b101000) ;
				s40[39] =  (haddr[5:0] == 6'b100111) ;
				s40[38] =  (haddr[5:0] == 6'b100110) ;
				s40[37] =  (haddr[5:0] == 6'b100101) ;
				s40[36] =  (haddr[5:0] == 6'b100100) ;
				s40[35] =  (haddr[5:0] == 6'b100011) ;
				s40[34] =  (haddr[5:0] == 6'b100010) ;
				s40[33] =  (haddr[5:0] == 6'b100001) ;
				s40[32] =  (haddr[5:0] == 6'b100000) ;
				s40[31] =  (haddr[5:0] == 6'b011111) ;
				s40[30] =  (haddr[5:0] == 6'b011110) ;
				s40[29] =  (haddr[5:0] == 6'b011101) ;
				s40[28] =  (haddr[5:0] == 6'b011100) ;
				s40[27] =  (haddr[5:0] == 6'b011011) ;
				s40[26] =  (haddr[5:0] == 6'b011010) ;
				s40[25] =  (haddr[5:0] == 6'b011001) ;
				s40[24] =  (haddr[5:0] == 6'b011000) ;
				s40[23] =  (haddr[5:0] == 6'b010111) ;
				s40[22] =  (haddr[5:0] == 6'b010110) ;
				s40[21] =  (haddr[5:0] == 6'b010101) ;
				s40[20] =  (haddr[5:0] == 6'b010100) ;
				s40[19] =  (haddr[5:0] == 6'b010011) ;
				s40[18] =  (haddr[5:0] == 6'b010010) ;
				s40[17] =  (haddr[5:0] == 6'b010001) ;
				s40[16] =  (haddr[5:0] == 6'b010000) ;
				s40[15] =  (haddr[5:0] == 6'b001111) ;
				s40[14] =  (haddr[5:0] == 6'b001110) ;
				s40[13] =  (haddr[5:0] == 6'b001101) ;
				s40[12] =  (haddr[5:0] == 6'b001100) ;
				s40[11] =  (haddr[5:0] == 6'b001011) ;
				s40[10] =  (haddr[5:0] == 6'b001010) ;
				s40[9] =  (haddr[5:0] == 6'b001001) ;
				s40[8] =  (haddr[5:0] == 6'b001000) ;
				s40[7] =  (haddr[5:0] == 6'b000111) ;
				s40[6] =  (haddr[5:0] == 6'b000110) ;
				s40[5] =  (haddr[5:0] == 6'b000101) ;
				s40[4] =  (haddr[5:0] == 6'b000100) ;
				s40[3] =  (haddr[5:0] == 6'b000011) ;
				s40[2] =  (haddr[5:0] == 6'b000010) ;
				s40[1] =  (haddr[5:0] == 6'b000001) ;
				s40[0] =  (haddr[5:0] == 6'b000000) ;
			end
			3'b001: begin
				s40[63:62] = {2{(haddr[5:1] == 5'b11111)}};
				s40[61:60] = {2{(haddr[5:1] == 5'b11110)}};
				s40[59:58] = {2{(haddr[5:1] == 5'b11101)}};
				s40[57:56] = {2{(haddr[5:1] == 5'b11100)}};
				s40[55:54] = {2{(haddr[5:1] == 5'b11011)}};
				s40[53:52] = {2{(haddr[5:1] == 5'b11010)}};
				s40[51:50] = {2{(haddr[5:1] == 5'b11001)}};
				s40[49:48] = {2{(haddr[5:1] == 5'b11000)}};
				s40[47:46] = {2{(haddr[5:1] == 5'b10111)}};
				s40[45:44] = {2{(haddr[5:1] == 5'b10110)}};
				s40[43:42] = {2{(haddr[5:1] == 5'b10101)}};
				s40[41:40] = {2{(haddr[5:1] == 5'b10100)}};
				s40[39:38] = {2{(haddr[5:1] == 5'b10011)}};
				s40[37:36] = {2{(haddr[5:1] == 5'b10010)}};
				s40[35:34] = {2{(haddr[5:1] == 5'b10001)}};
				s40[33:32] = {2{(haddr[5:1] == 5'b10000)}};
				s40[31:30] = {2{(haddr[5:1] == 5'b01111)}};
				s40[29:28] = {2{(haddr[5:1] == 5'b01110)}};
				s40[27:26] = {2{(haddr[5:1] == 5'b01101)}};
				s40[25:24] = {2{(haddr[5:1] == 5'b01100)}};
				s40[23:22] = {2{(haddr[5:1] == 5'b01011)}};
				s40[21:20] = {2{(haddr[5:1] == 5'b01010)}};
				s40[19:18] = {2{(haddr[5:1] == 5'b01001)}};
				s40[17:16] = {2{(haddr[5:1] == 5'b01000)}};
				s40[15:14] = {2{(haddr[5:1] == 5'b00111)}};
				s40[13:12] = {2{(haddr[5:1] == 5'b00110)}};
				s40[11:10] = {2{(haddr[5:1] == 5'b00101)}};
				s40[9:8] = {2{(haddr[5:1] == 5'b00100)}};
				s40[7:6] = {2{(haddr[5:1] == 5'b00011)}};
				s40[5:4] = {2{(haddr[5:1] == 5'b00010)}};
				s40[3:2] = {2{(haddr[5:1] == 5'b00001)}};
				s40[1:0] = {2{(haddr[5:1] == 5'b00000)}};
			end
			3'b010: begin
				s40[63:60] = {4{(haddr[5:2] == 4'b1111)}};
				s40[59:56] = {4{(haddr[5:2] == 4'b1110)}};
				s40[55:52] = {4{(haddr[5:2] == 4'b1101)}};
				s40[51:48] = {4{(haddr[5:2] == 4'b1100)}};
				s40[47:44] = {4{(haddr[5:2] == 4'b1011)}};
				s40[43:40] = {4{(haddr[5:2] == 4'b1010)}};
				s40[39:36] = {4{(haddr[5:2] == 4'b1001)}};
				s40[35:32] = {4{(haddr[5:2] == 4'b1000)}};
				s40[31:28] = {4{(haddr[5:2] == 4'b0111)}};
				s40[27:24] = {4{(haddr[5:2] == 4'b0110)}};
				s40[23:20] = {4{(haddr[5:2] == 4'b0101)}};
				s40[19:16] = {4{(haddr[5:2] == 4'b0100)}};
				s40[15:12] = {4{(haddr[5:2] == 4'b0011)}};
				s40[11:8] = {4{(haddr[5:2] == 4'b0010)}};
				s40[7:4] = {4{(haddr[5:2] == 4'b0001)}};
				s40[3:0] = {4{(haddr[5:2] == 4'b0000)}};
			end
			3'b011: begin
				s40[63:56] = {8{(haddr[5:3] == 3'b111)}};
				s40[55:48] = {8{(haddr[5:3] == 3'b110)}};
				s40[47:40] = {8{(haddr[5:3] == 3'b101)}};
				s40[39:32] = {8{(haddr[5:3] == 3'b100)}};
				s40[31:24] = {8{(haddr[5:3] == 3'b011)}};
				s40[23:16] = {8{(haddr[5:3] == 3'b010)}};
				s40[15:8] = {8{(haddr[5:3] == 3'b001)}};
				s40[7:0] = {8{(haddr[5:3] == 3'b000)}};
			end
			3'b100: begin
				s40[63:48] = {16{(haddr[5:4] == 2'b11)}};
				s40[47:32] = {16{(haddr[5:4] == 2'b10)}};
				s40[31:16] = {16{(haddr[5:4] == 2'b01)}};
				s40[15:0] = {16{(haddr[5:4] == 2'b00)}};
			end
			3'b101: begin
				s40[63:32] = {32{(haddr[5] == 1'b1)}};
				s40[31:0] = {32{(haddr[5] == 1'b0)}};
			end
			3'b110: begin
				s40[63:0] = {64{1'b1}};
			end
			default:
				s40 = 64'b0;
		endcase
	end
end
if (DATA_WIDTH == 1024) begin: gen_hwdata_wbe_1024
	always @* begin
		case (hsize[2:0])
			3'b000: begin
				s40[127] =  (haddr[6:0] == 7'b1111111) ;
				s40[126] =  (haddr[6:0] == 7'b1111110) ;
				s40[125] =  (haddr[6:0] == 7'b1111101) ;
				s40[124] =  (haddr[6:0] == 7'b1111100) ;
				s40[123] =  (haddr[6:0] == 7'b1111011) ;
				s40[122] =  (haddr[6:0] == 7'b1111010) ;
				s40[121] =  (haddr[6:0] == 7'b1111001) ;
				s40[120] =  (haddr[6:0] == 7'b1111000) ;
				s40[119] =  (haddr[6:0] == 7'b1110111) ;
				s40[118] =  (haddr[6:0] == 7'b1110110) ;
				s40[117] =  (haddr[6:0] == 7'b1110101) ;
				s40[116] =  (haddr[6:0] == 7'b1110100) ;
				s40[115] =  (haddr[6:0] == 7'b1110011) ;
				s40[114] =  (haddr[6:0] == 7'b1110010) ;
				s40[113] =  (haddr[6:0] == 7'b1110001) ;
				s40[112] =  (haddr[6:0] == 7'b1110000) ;
				s40[111] =  (haddr[6:0] == 7'b1101111) ;
				s40[110] =  (haddr[6:0] == 7'b1101110) ;
				s40[109] =  (haddr[6:0] == 7'b1101101) ;
				s40[108] =  (haddr[6:0] == 7'b1101100) ;
				s40[107] =  (haddr[6:0] == 7'b1101011) ;
				s40[106] =  (haddr[6:0] == 7'b1101010) ;
				s40[105] =  (haddr[6:0] == 7'b1101001) ;
				s40[104] =  (haddr[6:0] == 7'b1101000) ;
				s40[103] =  (haddr[6:0] == 7'b1100111) ;
				s40[102] =  (haddr[6:0] == 7'b1100110) ;
				s40[101] =  (haddr[6:0] == 7'b1100101) ;
				s40[100] =  (haddr[6:0] == 7'b1100100) ;
				s40[99] =  (haddr[6:0] == 7'b1100011) ;
				s40[98] =  (haddr[6:0] == 7'b1100010) ;
				s40[97] =  (haddr[6:0] == 7'b1100001) ;
				s40[96] =  (haddr[6:0] == 7'b1100000) ;
				s40[95] =  (haddr[6:0] == 7'b1011111) ;
				s40[94] =  (haddr[6:0] == 7'b1011110) ;
				s40[93] =  (haddr[6:0] == 7'b1011101) ;
				s40[92] =  (haddr[6:0] == 7'b1011100) ;
				s40[91] =  (haddr[6:0] == 7'b1011011) ;
				s40[90] =  (haddr[6:0] == 7'b1011010) ;
				s40[89] =  (haddr[6:0] == 7'b1011001) ;
				s40[88] =  (haddr[6:0] == 7'b1011000) ;
				s40[87] =  (haddr[6:0] == 7'b1010111) ;
				s40[86] =  (haddr[6:0] == 7'b1010110) ;
				s40[85] =  (haddr[6:0] == 7'b1010101) ;
				s40[84] =  (haddr[6:0] == 7'b1010100) ;
				s40[83] =  (haddr[6:0] == 7'b1010011) ;
				s40[82] =  (haddr[6:0] == 7'b1010010) ;
				s40[81] =  (haddr[6:0] == 7'b1010001) ;
				s40[80] =  (haddr[6:0] == 7'b1010000) ;
				s40[79] =  (haddr[6:0] == 7'b1001111) ;
				s40[78] =  (haddr[6:0] == 7'b1001110) ;
				s40[77] =  (haddr[6:0] == 7'b1001101) ;
				s40[76] =  (haddr[6:0] == 7'b1001100) ;
				s40[75] =  (haddr[6:0] == 7'b1001011) ;
				s40[74] =  (haddr[6:0] == 7'b1001010) ;
				s40[73] =  (haddr[6:0] == 7'b1001001) ;
				s40[72] =  (haddr[6:0] == 7'b1001000) ;
				s40[71] =  (haddr[6:0] == 7'b1000111) ;
				s40[70] =  (haddr[6:0] == 7'b1000110) ;
				s40[69] =  (haddr[6:0] == 7'b1000101) ;
				s40[68] =  (haddr[6:0] == 7'b1000100) ;
				s40[67] =  (haddr[6:0] == 7'b1000011) ;
				s40[66] =  (haddr[6:0] == 7'b1000010) ;
				s40[65] =  (haddr[6:0] == 7'b1000001) ;
				s40[64] =  (haddr[6:0] == 7'b1000000) ;
				s40[63] =  (haddr[6:0] == 7'b0111111) ;
				s40[62] =  (haddr[6:0] == 7'b0111110) ;
				s40[61] =  (haddr[6:0] == 7'b0111101) ;
				s40[60] =  (haddr[6:0] == 7'b0111100) ;
				s40[59] =  (haddr[6:0] == 7'b0111011) ;
				s40[58] =  (haddr[6:0] == 7'b0111010) ;
				s40[57] =  (haddr[6:0] == 7'b0111001) ;
				s40[56] =  (haddr[6:0] == 7'b0111000) ;
				s40[55] =  (haddr[6:0] == 7'b0110111) ;
				s40[54] =  (haddr[6:0] == 7'b0110110) ;
				s40[53] =  (haddr[6:0] == 7'b0110101) ;
				s40[52] =  (haddr[6:0] == 7'b0110100) ;
				s40[51] =  (haddr[6:0] == 7'b0110011) ;
				s40[50] =  (haddr[6:0] == 7'b0110010) ;
				s40[49] =  (haddr[6:0] == 7'b0110001) ;
				s40[48] =  (haddr[6:0] == 7'b0110000) ;
				s40[47] =  (haddr[6:0] == 7'b0101111) ;
				s40[46] =  (haddr[6:0] == 7'b0101110) ;
				s40[45] =  (haddr[6:0] == 7'b0101101) ;
				s40[44] =  (haddr[6:0] == 7'b0101100) ;
				s40[43] =  (haddr[6:0] == 7'b0101011) ;
				s40[42] =  (haddr[6:0] == 7'b0101010) ;
				s40[41] =  (haddr[6:0] == 7'b0101001) ;
				s40[40] =  (haddr[6:0] == 7'b0101000) ;
				s40[39] =  (haddr[6:0] == 7'b0100111) ;
				s40[38] =  (haddr[6:0] == 7'b0100110) ;
				s40[37] =  (haddr[6:0] == 7'b0100101) ;
				s40[36] =  (haddr[6:0] == 7'b0100100) ;
				s40[35] =  (haddr[6:0] == 7'b0100011) ;
				s40[34] =  (haddr[6:0] == 7'b0100010) ;
				s40[33] =  (haddr[6:0] == 7'b0100001) ;
				s40[32] =  (haddr[6:0] == 7'b0100000) ;
				s40[31] =  (haddr[6:0] == 7'b0011111) ;
				s40[30] =  (haddr[6:0] == 7'b0011110) ;
				s40[29] =  (haddr[6:0] == 7'b0011101) ;
				s40[28] =  (haddr[6:0] == 7'b0011100) ;
				s40[27] =  (haddr[6:0] == 7'b0011011) ;
				s40[26] =  (haddr[6:0] == 7'b0011010) ;
				s40[25] =  (haddr[6:0] == 7'b0011001) ;
				s40[24] =  (haddr[6:0] == 7'b0011000) ;
				s40[23] =  (haddr[6:0] == 7'b0010111) ;
				s40[22] =  (haddr[6:0] == 7'b0010110) ;
				s40[21] =  (haddr[6:0] == 7'b0010101) ;
				s40[20] =  (haddr[6:0] == 7'b0010100) ;
				s40[19] =  (haddr[6:0] == 7'b0010011) ;
				s40[18] =  (haddr[6:0] == 7'b0010010) ;
				s40[17] =  (haddr[6:0] == 7'b0010001) ;
				s40[16] =  (haddr[6:0] == 7'b0010000) ;
				s40[15] =  (haddr[6:0] == 7'b0001111) ;
				s40[14] =  (haddr[6:0] == 7'b0001110) ;
				s40[13] =  (haddr[6:0] == 7'b0001101) ;
				s40[12] =  (haddr[6:0] == 7'b0001100) ;
				s40[11] =  (haddr[6:0] == 7'b0001011) ;
				s40[10] =  (haddr[6:0] == 7'b0001010) ;
				s40[9] =  (haddr[6:0] == 7'b0001001) ;
				s40[8] =  (haddr[6:0] == 7'b0001000) ;
				s40[7] =  (haddr[6:0] == 7'b0000111) ;
				s40[6] =  (haddr[6:0] == 7'b0000110) ;
				s40[5] =  (haddr[6:0] == 7'b0000101) ;
				s40[4] =  (haddr[6:0] == 7'b0000100) ;
				s40[3] =  (haddr[6:0] == 7'b0000011) ;
				s40[2] =  (haddr[6:0] == 7'b0000010) ;
				s40[1] =  (haddr[6:0] == 7'b0000001) ;
				s40[0] =  (haddr[6:0] == 7'b0000000) ;
			end
			3'b001: begin
				s40[127:126] = {2{(haddr[6:1] == 6'b111111)}};
				s40[125:124] = {2{(haddr[6:1] == 6'b111110)}};
				s40[123:122] = {2{(haddr[6:1] == 6'b111101)}};
				s40[121:120] = {2{(haddr[6:1] == 6'b111100)}};
				s40[119:118] = {2{(haddr[6:1] == 6'b111011)}};
				s40[117:116] = {2{(haddr[6:1] == 6'b111010)}};
				s40[115:114] = {2{(haddr[6:1] == 6'b111001)}};
				s40[113:112] = {2{(haddr[6:1] == 6'b111000)}};
				s40[111:110] = {2{(haddr[6:1] == 6'b110111)}};
				s40[109:108] = {2{(haddr[6:1] == 6'b110110)}};
				s40[107:106] = {2{(haddr[6:1] == 6'b110101)}};
				s40[105:104] = {2{(haddr[6:1] == 6'b110100)}};
				s40[103:102] = {2{(haddr[6:1] == 6'b110011)}};
				s40[101:100] = {2{(haddr[6:1] == 6'b110010)}};
				s40[99:98] = {2{(haddr[6:1] == 6'b110001)}};
				s40[97:96] = {2{(haddr[6:1] == 6'b110000)}};
				s40[95:94] = {2{(haddr[6:1] == 6'b101111)}};
				s40[93:92] = {2{(haddr[6:1] == 6'b101110)}};
				s40[91:90] = {2{(haddr[6:1] == 6'b101101)}};
				s40[89:88] = {2{(haddr[6:1] == 6'b101100)}};
				s40[87:86] = {2{(haddr[6:1] == 6'b101011)}};
				s40[85:84] = {2{(haddr[6:1] == 6'b101010)}};
				s40[83:82] = {2{(haddr[6:1] == 6'b101001)}};
				s40[81:80] = {2{(haddr[6:1] == 6'b101000)}};
				s40[79:78] = {2{(haddr[6:1] == 6'b100111)}};
				s40[77:76] = {2{(haddr[6:1] == 6'b100110)}};
				s40[75:74] = {2{(haddr[6:1] == 6'b100101)}};
				s40[73:72] = {2{(haddr[6:1] == 6'b100100)}};
				s40[71:70] = {2{(haddr[6:1] == 6'b100011)}};
				s40[69:68] = {2{(haddr[6:1] == 6'b100010)}};
				s40[67:66] = {2{(haddr[6:1] == 6'b100001)}};
				s40[65:64] = {2{(haddr[6:1] == 6'b100000)}};
				s40[63:62] = {2{(haddr[6:1] == 6'b011111)}};
				s40[61:60] = {2{(haddr[6:1] == 6'b011110)}};
				s40[59:58] = {2{(haddr[6:1] == 6'b011101)}};
				s40[57:56] = {2{(haddr[6:1] == 6'b011100)}};
				s40[55:54] = {2{(haddr[6:1] == 6'b011011)}};
				s40[53:52] = {2{(haddr[6:1] == 6'b011010)}};
				s40[51:50] = {2{(haddr[6:1] == 6'b011001)}};
				s40[49:48] = {2{(haddr[6:1] == 6'b011000)}};
				s40[47:46] = {2{(haddr[6:1] == 6'b010111)}};
				s40[45:44] = {2{(haddr[6:1] == 6'b010110)}};
				s40[43:42] = {2{(haddr[6:1] == 6'b010101)}};
				s40[41:40] = {2{(haddr[6:1] == 6'b010100)}};
				s40[39:38] = {2{(haddr[6:1] == 6'b010011)}};
				s40[37:36] = {2{(haddr[6:1] == 6'b010010)}};
				s40[35:34] = {2{(haddr[6:1] == 6'b010001)}};
				s40[33:32] = {2{(haddr[6:1] == 6'b010000)}};
				s40[31:30] = {2{(haddr[6:1] == 6'b001111)}};
				s40[29:28] = {2{(haddr[6:1] == 6'b001110)}};
				s40[27:26] = {2{(haddr[6:1] == 6'b001101)}};
				s40[25:24] = {2{(haddr[6:1] == 6'b001100)}};
				s40[23:22] = {2{(haddr[6:1] == 6'b001011)}};
				s40[21:20] = {2{(haddr[6:1] == 6'b001010)}};
				s40[19:18] = {2{(haddr[6:1] == 6'b001001)}};
				s40[17:16] = {2{(haddr[6:1] == 6'b001000)}};
				s40[15:14] = {2{(haddr[6:1] == 6'b000111)}};
				s40[13:12] = {2{(haddr[6:1] == 6'b000110)}};
				s40[11:10] = {2{(haddr[6:1] == 6'b000101)}};
				s40[9:8] = {2{(haddr[6:1] == 6'b000100)}};
				s40[7:6] = {2{(haddr[6:1] == 6'b000011)}};
				s40[5:4] = {2{(haddr[6:1] == 6'b000010)}};
				s40[3:2] = {2{(haddr[6:1] == 6'b000001)}};
				s40[1:0] = {2{(haddr[6:1] == 6'b000000)}};
			end
			3'b010: begin
				s40[127:124] = {4{(haddr[6:2] == 5'b11111)}};
				s40[123:120] = {4{(haddr[6:2] == 5'b11110)}};
				s40[119:116] = {4{(haddr[6:2] == 5'b11101)}};
				s40[115:112] = {4{(haddr[6:2] == 5'b11100)}};
				s40[111:108] = {4{(haddr[6:2] == 5'b11011)}};
				s40[107:104] = {4{(haddr[6:2] == 5'b11010)}};
				s40[103:100] = {4{(haddr[6:2] == 5'b11001)}};
				s40[99:96] = {4{(haddr[6:2] == 5'b11000)}};
				s40[95:92] = {4{(haddr[6:2] == 5'b10111)}};
				s40[91:88] = {4{(haddr[6:2] == 5'b10110)}};
				s40[87:84] = {4{(haddr[6:2] == 5'b10101)}};
				s40[83:80] = {4{(haddr[6:2] == 5'b10100)}};
				s40[79:76] = {4{(haddr[6:2] == 5'b10011)}};
				s40[75:72] = {4{(haddr[6:2] == 5'b10010)}};
				s40[71:68] = {4{(haddr[6:2] == 5'b10001)}};
				s40[67:64] = {4{(haddr[6:2] == 5'b10000)}};
				s40[63:60] = {4{(haddr[6:2] == 5'b01111)}};
				s40[59:56] = {4{(haddr[6:2] == 5'b01110)}};
				s40[55:52] = {4{(haddr[6:2] == 5'b01101)}};
				s40[51:48] = {4{(haddr[6:2] == 5'b01100)}};
				s40[47:44] = {4{(haddr[6:2] == 5'b01011)}};
				s40[43:40] = {4{(haddr[6:2] == 5'b01010)}};
				s40[39:36] = {4{(haddr[6:2] == 5'b01001)}};
				s40[35:32] = {4{(haddr[6:2] == 5'b01000)}};
				s40[31:28] = {4{(haddr[6:2] == 5'b00111)}};
				s40[27:24] = {4{(haddr[6:2] == 5'b00110)}};
				s40[23:20] = {4{(haddr[6:2] == 5'b00101)}};
				s40[19:16] = {4{(haddr[6:2] == 5'b00100)}};
				s40[15:12] = {4{(haddr[6:2] == 5'b00011)}};
				s40[11:8] = {4{(haddr[6:2] == 5'b00010)}};
				s40[7:4] = {4{(haddr[6:2] == 5'b00001)}};
				s40[3:0] = {4{(haddr[6:2] == 5'b00000)}};
			end
			3'b011: begin
				s40[127:120] = {8{(haddr[6:3] == 4'b1111)}};
				s40[119:112] = {8{(haddr[6:3] == 4'b1110)}};
				s40[111:104] = {8{(haddr[6:3] == 4'b1101)}};
				s40[103:96] = {8{(haddr[6:3] == 4'b1100)}};
				s40[95:88] = {8{(haddr[6:3] == 4'b1011)}};
				s40[87:80] = {8{(haddr[6:3] == 4'b1010)}};
				s40[79:72] = {8{(haddr[6:3] == 4'b1001)}};
				s40[71:64] = {8{(haddr[6:3] == 4'b1000)}};
				s40[63:56] = {8{(haddr[6:3] == 4'b0111)}};
				s40[55:48] = {8{(haddr[6:3] == 4'b0110)}};
				s40[47:40] = {8{(haddr[6:3] == 4'b0101)}};
				s40[39:32] = {8{(haddr[6:3] == 4'b0100)}};
				s40[31:24] = {8{(haddr[6:3] == 4'b0011)}};
				s40[23:16] = {8{(haddr[6:3] == 4'b0010)}};
				s40[15:8] = {8{(haddr[6:3] == 4'b0001)}};
				s40[7:0] = {8{(haddr[6:3] == 4'b0000)}};
			end
			3'b100: begin
				s40[127:112] = {16{(haddr[6:4] == 3'b111)}};
				s40[111:96] = {16{(haddr[6:4] == 3'b110)}};
				s40[95:80] = {16{(haddr[6:4] == 3'b101)}};
				s40[79:64] = {16{(haddr[6:4] == 3'b100)}};
				s40[63:48] = {16{(haddr[6:4] == 3'b011)}};
				s40[47:32] = {16{(haddr[6:4] == 3'b010)}};
				s40[31:16] = {16{(haddr[6:4] == 3'b001)}};
				s40[15:0] = {16{(haddr[6:4] == 3'b000)}};
			end
			3'b101: begin
				s40[127:96] = {32{(haddr[6:5] == 2'b11)}};
				s40[95:64] = {32{(haddr[6:5] == 2'b10)}};
				s40[63:32] = {32{(haddr[6:5] == 2'b01)}};
				s40[31:0] = {32{(haddr[6:5] == 2'b00)}};
			end
			3'b110: begin
				s40[127:64] = {64{(haddr[6] == 1'b1)}};
				s40[63:0] = {64{(haddr[6] == 1'b0)}};
			end
			3'b111: begin
				s40[127:0] = {128{1'b1}};
			end
			default:
				s40 = 128'b0;
		endcase
	end
end
endgenerate
always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
        	s39 <= {(DATA_WIDTH/8){1'b0}};
	end
	else if (s44) begin
        	s39 <= s40;
	end
end

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        s45 <= 1'b0;
        ctrl_wen     <= 1'b0;
        s46     <= 1'b0;
`ifdef ATCBMC200_AHB_SLV11
      	s47 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_SLV12
      	s48 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_SLV13
      	s49 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_SLV14
      	s50 <= 1'b0;
`endif
`ifdef ATCBMC200_AHB_SLV15
      	s51 <= 1'b0;
`endif
    end
    else begin
        s45 <= s44 & s37[4];
        ctrl_wen     <= s44 & s37[5];
        s46     <= s44 & s37[6];
`ifdef ATCBMC200_AHB_SLV11
      	s47 <= s44 & s37[18];
`endif
`ifdef ATCBMC200_AHB_SLV12
      	s48 <= s44 & s37[19];
`endif
`ifdef ATCBMC200_AHB_SLV13
      	s49 <= s44 & s37[20];
`endif
`ifdef ATCBMC200_AHB_SLV14
      	s50 <= s44 & s37[21];
`endif
`ifdef ATCBMC200_AHB_SLV15
      	s51 <= s44 & s37[22];
`endif
    end
end



always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        mst0_highest_en <= 1'b0;
    end
    else if (s45) begin
	if (s38[4][3]) begin
	    mst0_highest_en <= s36[4][31];
        end
    end
end


`ifdef ATCBMC200_AHB_MST0
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s3 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s3 <= s36[4][0];
	    end
    end
    assign init_priority[0] = s3;
`else
    assign init_priority[0] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST1
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s5 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s5 <= s36[4][1];
	    end
    end
    assign init_priority[1] = s5;
`else
    assign init_priority[1] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST2
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s7 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s7 <= s36[4][2];
	    end
    end
    assign init_priority[2] = s7;
`else
    assign init_priority[2] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST3
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s9 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s9 <= s36[4][3];
	    end
    end
    assign init_priority[3] = s9;
`else
    assign init_priority[3] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST4
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s11 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s11 <= s36[4][4];
	    end
    end
    assign init_priority[4] = s11;
`else
    assign init_priority[4] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST5
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s13 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s13 <= s36[4][5];
	    end
    end
    assign init_priority[5] = s13;
`else
    assign init_priority[5] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST6
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s15 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s15 <= s36[4][6];
	    end
    end
    assign init_priority[6] = s15;
`else
    assign init_priority[6] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST7
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s17 <= 1'b1;
	    end
        else if (s45 && s38[4][0]) begin
            s17 <= s36[4][7];
	    end
    end
    assign init_priority[7] = s17;
`else
    assign init_priority[7] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST8
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s19 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s19 <= s36[4][8];
	    end
    end
    assign init_priority[8] = s19;
`else
    assign init_priority[8] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST9
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s21 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s21 <= s36[4][9];
	    end
    end
    assign init_priority[9] = s21;
`else
    assign init_priority[9] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST10
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s23 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s23 <= s36[4][10];
	    end
    end
    assign init_priority[10] = s23;
`else
    assign init_priority[10] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST11
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s25 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s25 <= s36[4][11];
	    end
    end
    assign init_priority[11] = s25;
`else
    assign init_priority[11] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST12
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s27 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s27 <= s36[4][12];
	    end
    end
    assign init_priority[12] = s27;
`else
    assign init_priority[12] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST13
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s29 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s29 <= s36[4][13];
	    end
    end
    assign init_priority[13] = s29;
`else
    assign init_priority[13] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST14
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s31 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s31 <= s36[4][14];
	    end
    end
    assign init_priority[14] = s31;
`else
    assign init_priority[14] = 1'b0;
`endif
`ifdef ATCBMC200_AHB_MST15
    always @(posedge hclk or negedge hresetn) begin
        if (!hresetn) begin
            s33 <= 1'b1;
	    end
        else if (s45 && s38[4][1]) begin
            s33 <= s36[4][15];
	    end
    end
    assign init_priority[15] = s33;
`else
    assign init_priority[15] = 1'b0;
`endif

`ifdef ATCBMC200_RESP_MODE_ERROR
wire s52 = 1'b1;
`else
wire s52 = 1'b0;
`endif

always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        s0         <= 1'b0;
        resp_mode       <= s52;
    end
    else if (ctrl_wen) begin
        if (s38[5][0]) begin
		s0 <= s36[5][1];
		resp_mode <= s36[5][0];
	end
    end
end


`ifdef ATCBMC200_AHB_MST0
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s2 <= 1'b0;
       else if (s46 && s38[6][0])
           s2 <= s2 & ~s36[6][0];
       else if (mst0_sel_err)
           s2 <= 1'b1;
    end
    assign s1[0] = s2;
`else
    assign s1[0] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST1
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s4 <= 1'b0;
       else if (s46 && s38[6][0])
           s4 <= s4 & ~s36[6][1];
       else if (mst1_sel_err)
           s4 <= 1'b1;
    end
    assign s1[1] = s4;
`else
    assign s1[1] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST2
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s6 <= 1'b0;
       else if (s46 && s38[6][0])
           s6 <= s6 & ~s36[6][2];
       else if (mst2_sel_err)
           s6 <= 1'b1;
    end
    assign s1[2] = s6;
`else
    assign s1[2] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST3
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s8 <= 1'b0;
       else if (s46 && s38[6][0])
           s8 <= s8 & ~s36[6][3];
       else if (mst3_sel_err)
           s8 <= 1'b1;
    end
    assign s1[3] = s8;
`else
    assign s1[3] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST4
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s10 <= 1'b0;
       else if (s46 && s38[6][0])
           s10 <= s10 & ~s36[6][4];
       else if (mst4_sel_err)
           s10 <= 1'b1;
    end
    assign s1[4] = s10;
`else
    assign s1[4] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST5
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s12 <= 1'b0;
       else if (s46 && s38[6][0])
           s12 <= s12 & ~s36[6][5];
       else if (mst5_sel_err)
           s12 <= 1'b1;
    end
    assign s1[5] = s12;
`else
    assign s1[5] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST6
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s14 <= 1'b0;
       else if (s46 && s38[6][0])
           s14 <= s14 & ~s36[6][6];
       else if (mst6_sel_err)
           s14 <= 1'b1;
    end
    assign s1[6] = s14;
`else
    assign s1[6] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST7
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s16 <= 1'b0;
       else if (s46 && s38[6][0])
           s16 <= s16 & ~s36[6][7];
       else if (mst7_sel_err)
           s16 <= 1'b1;
    end
    assign s1[7] = s16;
`else
    assign s1[7] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST8
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s18 <= 1'b0;
       else if (s46 && s38[6][1])
           s18 <= s18 & ~s36[6][8];
       else if (mst8_sel_err)
           s18 <= 1'b1;
    end
    assign s1[8] = s18;
`else
    assign s1[8] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST9
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s20 <= 1'b0;
       else if (s46 && s38[6][1])
           s20 <= s20 & ~s36[6][9];
       else if (mst9_sel_err)
           s20 <= 1'b1;
    end
    assign s1[9] = s20;
`else
    assign s1[9] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST10
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s22 <= 1'b0;
       else if (s46 && s38[6][1])
           s22 <= s22 & ~s36[6][10];
       else if (mst10_sel_err)
           s22 <= 1'b1;
    end
    assign s1[10] = s22;
`else
    assign s1[10] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST11
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s24 <= 1'b0;
       else if (s46 && s38[6][1])
           s24 <= s24 & ~s36[6][11];
       else if (mst11_sel_err)
           s24 <= 1'b1;
    end
    assign s1[11] = s24;
`else
    assign s1[11] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST12
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s26 <= 1'b0;
       else if (s46 && s38[6][1])
           s26 <= s26 & ~s36[6][12];
       else if (mst12_sel_err)
           s26 <= 1'b1;
    end
    assign s1[12] = s26;
`else
    assign s1[12] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST13
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s28 <= 1'b0;
       else if (s46 && s38[6][1])
           s28 <= s28 & ~s36[6][13];
       else if (mst13_sel_err)
           s28 <= 1'b1;
    end
    assign s1[13] = s28;
`else
    assign s1[13] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST14
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s30 <= 1'b0;
       else if (s46 && s38[6][1])
           s30 <= s30 & ~s36[6][14];
       else if (mst14_sel_err)
           s30 <= 1'b1;
    end
    assign s1[14] = s30;
`else
    assign s1[14] = 1'b0;
`endif

`ifdef ATCBMC200_AHB_MST15
    always @(posedge hclk or negedge hresetn) begin
       if (!hresetn)
           s32 <= 1'b0;
       else if (s46 && s38[6][1])
           s32 <= s32 & ~s36[6][15];
       else if (mst15_sel_err)
           s32 <= 1'b1;
    end
    assign s1[15] = s32;
`else
    assign s1[15] = 1'b0;
`endif



`ifdef ATCBMC200_AHB_SLV11
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv11_base <= AHB_SLV11_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv11_size <= `ATCBMC200_AHB_SLV11_SIZE;
    end
    else if (s47) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (s38[18][2]) slv11_base[23:16] <= s36[18][23:16];
        if (s38[18][1]) slv11_base[15:10]  <= s36[18][15:10];
        `else
        if (s38[18][3]) slv11_base[31:24] <= s36[18][31:24];
        if (s38[18][2]) slv11_base[23:20]  <= s36[18][23:20];
        `endif

        if (s38[18][0]) slv11_size       <= s36[18][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV12
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv12_base <= AHB_SLV12_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv12_size <= `ATCBMC200_AHB_SLV12_SIZE;
    end
    else if (s48) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (s38[19][2]) slv12_base[23:16] <= s36[19][23:16];
        if (s38[19][1]) slv12_base[15:10]  <= s36[19][15:10];
        `else
        if (s38[19][3]) slv12_base[31:24] <= s36[19][31:24];
        if (s38[19][2]) slv12_base[23:20]  <= s36[19][23:20];
        `endif

        if (s38[19][0]) slv12_size       <= s36[19][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV13
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv13_base <= AHB_SLV13_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv13_size <= `ATCBMC200_AHB_SLV13_SIZE;
    end
    else if (s49) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (s38[20][2]) slv13_base[23:16] <= s36[20][23:16];
        if (s38[20][1]) slv13_base[15:10]  <= s36[20][15:10];
        `else
        if (s38[20][3]) slv13_base[31:24] <= s36[20][31:24];
        if (s38[20][2]) slv13_base[23:20]  <= s36[20][23:20];
        `endif

        if (s38[20][0]) slv13_size       <= s36[20][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV14
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv14_base <= AHB_SLV14_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv14_size <= `ATCBMC200_AHB_SLV14_SIZE;
    end
    else if (s50) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (s38[21][2]) slv14_base[23:16] <= s36[21][23:16];
        if (s38[21][1]) slv14_base[15:10]  <= s36[21][15:10];
        `else
        if (s38[21][3]) slv14_base[31:24] <= s36[21][31:24];
        if (s38[21][2]) slv14_base[23:20]  <= s36[21][23:20];
        `endif

        if (s38[21][0]) slv14_size       <= s36[21][3:0];
    end
end
`endif

`ifdef ATCBMC200_AHB_SLV15
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        slv15_base <= AHB_SLV15_BASE[ADDR_MSB:BASE_ADDR_LSB];
        slv15_size <= `ATCBMC200_AHB_SLV15_SIZE;
    end
    else if (s51) begin
        `ifdef ATCBMC200_ADDR_WIDTH_24
        if (s38[22][2]) slv15_base[23:16] <= s36[22][23:16];
        if (s38[22][1]) slv15_base[15:10]  <= s36[22][15:10];
        `else
        if (s38[22][3]) slv15_base[31:24] <= s36[22][31:24];
        if (s38[22][2]) slv15_base[23:20]  <= s36[22][23:20];
        `endif

        if (s38[22][0]) slv15_size       <= s36[22][3:0];
    end
end
`endif



assign	s42[0] = `ATCBMC200_PRODUCT_ID;
assign	s42[4] = {mst0_highest_en, 15'b0, init_priority};
assign	s42[5] = {30'h0, s0, resp_mode};
assign	s42[6] = {16'b0, s1};
`ifdef ATCBMC200_AHB_SLV1
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[8] = {8'h0, slv1_base, 6'h0, slv1_size};
	`else
assign	s42[8] = {slv1_base[31:BASE_ADDR_LSB], 16'h0, slv1_size};
	`endif
`else
assign	s42[8] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV2
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[9] = {8'h0, slv2_base, 6'h0, slv2_size};
	`else
assign	s42[9] = {slv2_base[31:BASE_ADDR_LSB], 16'h0, slv2_size};
	`endif
`else
assign	s42[9] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV3
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[10] = {8'h0, slv3_base, 6'h0, slv3_size};
	`else
assign	s42[10] = {slv3_base[31:BASE_ADDR_LSB], 16'h0, slv3_size};
	`endif
`else
assign	s42[10] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV4
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[11] = {8'h0, slv4_base, 6'h0, slv4_size};
	`else
assign	s42[11] = {slv4_base[31:BASE_ADDR_LSB], 16'h0, slv4_size};
	`endif
`else
assign	s42[11] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV5
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[12] = {8'h0, slv5_base, 6'h0, slv5_size};
	`else
assign	s42[12] = {slv5_base[31:BASE_ADDR_LSB], 16'h0, slv5_size};
	`endif
`else
assign	s42[12] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV6
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[13] = {8'h0, slv6_base, 6'h0, slv6_size};
	`else
assign	s42[13] = {slv6_base[31:BASE_ADDR_LSB], 16'h0, slv6_size};
	`endif
`else
assign	s42[13] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV7
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[14] = {8'h0, slv7_base, 6'h0, slv7_size};
	`else
assign	s42[14] = {slv7_base[31:BASE_ADDR_LSB], 16'h0, slv7_size};
	`endif
`else
assign	s42[14] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV8
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[15] = {8'h0, slv8_base, 6'h0, slv8_size};
	`else
assign	s42[15] = {slv8_base[31:BASE_ADDR_LSB], 16'h0, slv8_size};
	`endif
`else
assign	s42[15] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV9
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[16] = {8'h0, slv9_base, 6'h0, slv9_size};
	`else
assign	s42[16] = {slv9_base[31:BASE_ADDR_LSB], 16'h0, slv9_size};
	`endif
`else
assign	s42[16] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV10
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[17] = {8'h0, slv10_base, 6'h0, slv10_size};
	`else
assign	s42[17] = {slv10_base[31:BASE_ADDR_LSB], 16'h0, slv10_size};
	`endif
`else
assign	s42[17] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV11
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[18] = {8'h0, slv11_base, 6'h0, slv11_size};
	`else
assign	s42[18] = {slv11_base[31:BASE_ADDR_LSB], 16'h0, slv11_size};
	`endif
`else
assign	s42[18] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV12
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[19] = {8'h0, slv12_base, 6'h0, slv12_size};
	`else
assign	s42[19] = {slv12_base[31:BASE_ADDR_LSB], 16'h0, slv12_size};
	`endif
`else
assign	s42[19] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV13
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[20] = {8'h0, slv13_base, 6'h0, slv13_size};
	`else
assign	s42[20] = {slv13_base[31:BASE_ADDR_LSB], 16'h0, slv13_size};
	`endif
`else
assign	s42[20] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV14
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[21] = {8'h0, slv14_base, 6'h0, slv14_size};
	`else
assign	s42[21] = {slv14_base[31:BASE_ADDR_LSB], 16'h0, slv14_size};
	`endif
`else
assign	s42[21] = 32'h0;
`endif
`ifdef ATCBMC200_AHB_SLV15
	`ifdef ATCBMC200_ADDR_WIDTH_24
assign	s42[22] = {8'h0, slv15_base, 6'h0, slv15_size};
	`else
assign	s42[22] = {slv15_base[31:BASE_ADDR_LSB], 16'h0, slv15_size};
	`endif
`else
assign	s42[22] = 32'h0;
`endif
assign	s42[1] = 32'h0;
assign	s42[2] = 32'h0;
assign	s42[3] = 32'h0;
assign	s42[7] = 32'h0;
assign	s42[23] = 32'h0;
assign	s42[24] = 32'h0;
assign	s42[25] = 32'h0;
assign	s42[26] = 32'h0;
assign	s42[27] = 32'h0;
assign	s42[28] = 32'h0;
assign	s42[29] = 32'h0;
assign	s42[30] = 32'h0;
assign	s42[31] = 32'h0;

wire	[6:2] s53 = s34 ? s35[6:2] : haddr[6:2];


generate
if (DATA_WIDTH == 32) begin: gen_hrdata_dw_32
	assign	s41	=	{
					s42[s53[6:2]]
	};
	assign	{
		s36[31]
		} = hwdata;
	assign	{
		s38[31]
		} = s39;
	assign	{
		s37[31]
		} = {1{haddr[7:2]==6'd31}};
	assign	{
		s36[30]
		} = hwdata;
	assign	{
		s38[30]
		} = s39;
	assign	{
		s37[30]
		} = {1{haddr[7:2]==6'd30}};
	assign	{
		s36[29]
		} = hwdata;
	assign	{
		s38[29]
		} = s39;
	assign	{
		s37[29]
		} = {1{haddr[7:2]==6'd29}};
	assign	{
		s36[28]
		} = hwdata;
	assign	{
		s38[28]
		} = s39;
	assign	{
		s37[28]
		} = {1{haddr[7:2]==6'd28}};
	assign	{
		s36[27]
		} = hwdata;
	assign	{
		s38[27]
		} = s39;
	assign	{
		s37[27]
		} = {1{haddr[7:2]==6'd27}};
	assign	{
		s36[26]
		} = hwdata;
	assign	{
		s38[26]
		} = s39;
	assign	{
		s37[26]
		} = {1{haddr[7:2]==6'd26}};
	assign	{
		s36[25]
		} = hwdata;
	assign	{
		s38[25]
		} = s39;
	assign	{
		s37[25]
		} = {1{haddr[7:2]==6'd25}};
	assign	{
		s36[24]
		} = hwdata;
	assign	{
		s38[24]
		} = s39;
	assign	{
		s37[24]
		} = {1{haddr[7:2]==6'd24}};
	assign	{
		s36[23]
		} = hwdata;
	assign	{
		s38[23]
		} = s39;
	assign	{
		s37[23]
		} = {1{haddr[7:2]==6'd23}};
	assign	{
		s36[22]
		} = hwdata;
	assign	{
		s38[22]
		} = s39;
	assign	{
		s37[22]
		} = {1{haddr[7:2]==6'd22}};
	assign	{
		s36[21]
		} = hwdata;
	assign	{
		s38[21]
		} = s39;
	assign	{
		s37[21]
		} = {1{haddr[7:2]==6'd21}};
	assign	{
		s36[20]
		} = hwdata;
	assign	{
		s38[20]
		} = s39;
	assign	{
		s37[20]
		} = {1{haddr[7:2]==6'd20}};
	assign	{
		s36[19]
		} = hwdata;
	assign	{
		s38[19]
		} = s39;
	assign	{
		s37[19]
		} = {1{haddr[7:2]==6'd19}};
	assign	{
		s36[18]
		} = hwdata;
	assign	{
		s38[18]
		} = s39;
	assign	{
		s37[18]
		} = {1{haddr[7:2]==6'd18}};
	assign	{
		s36[17]
		} = hwdata;
	assign	{
		s38[17]
		} = s39;
	assign	{
		s37[17]
		} = {1{haddr[7:2]==6'd17}};
	assign	{
		s36[16]
		} = hwdata;
	assign	{
		s38[16]
		} = s39;
	assign	{
		s37[16]
		} = {1{haddr[7:2]==6'd16}};
	assign	{
		s36[15]
		} = hwdata;
	assign	{
		s38[15]
		} = s39;
	assign	{
		s37[15]
		} = {1{haddr[7:2]==6'd15}};
	assign	{
		s36[14]
		} = hwdata;
	assign	{
		s38[14]
		} = s39;
	assign	{
		s37[14]
		} = {1{haddr[7:2]==6'd14}};
	assign	{
		s36[13]
		} = hwdata;
	assign	{
		s38[13]
		} = s39;
	assign	{
		s37[13]
		} = {1{haddr[7:2]==6'd13}};
	assign	{
		s36[12]
		} = hwdata;
	assign	{
		s38[12]
		} = s39;
	assign	{
		s37[12]
		} = {1{haddr[7:2]==6'd12}};
	assign	{
		s36[11]
		} = hwdata;
	assign	{
		s38[11]
		} = s39;
	assign	{
		s37[11]
		} = {1{haddr[7:2]==6'd11}};
	assign	{
		s36[10]
		} = hwdata;
	assign	{
		s38[10]
		} = s39;
	assign	{
		s37[10]
		} = {1{haddr[7:2]==6'd10}};
	assign	{
		s36[9]
		} = hwdata;
	assign	{
		s38[9]
		} = s39;
	assign	{
		s37[9]
		} = {1{haddr[7:2]==6'd9}};
	assign	{
		s36[8]
		} = hwdata;
	assign	{
		s38[8]
		} = s39;
	assign	{
		s37[8]
		} = {1{haddr[7:2]==6'd8}};
	assign	{
		s36[7]
		} = hwdata;
	assign	{
		s38[7]
		} = s39;
	assign	{
		s37[7]
		} = {1{haddr[7:2]==6'd7}};
	assign	{
		s36[6]
		} = hwdata;
	assign	{
		s38[6]
		} = s39;
	assign	{
		s37[6]
		} = {1{haddr[7:2]==6'd6}};
	assign	{
		s36[5]
		} = hwdata;
	assign	{
		s38[5]
		} = s39;
	assign	{
		s37[5]
		} = {1{haddr[7:2]==6'd5}};
	assign	{
		s36[4]
		} = hwdata;
	assign	{
		s38[4]
		} = s39;
	assign	{
		s37[4]
		} = {1{haddr[7:2]==6'd4}};
	assign	{
		s36[3]
		} = hwdata;
	assign	{
		s38[3]
		} = s39;
	assign	{
		s37[3]
		} = {1{haddr[7:2]==6'd3}};
	assign	{
		s36[2]
		} = hwdata;
	assign	{
		s38[2]
		} = s39;
	assign	{
		s37[2]
		} = {1{haddr[7:2]==6'd2}};
	assign	{
		s36[1]
		} = hwdata;
	assign	{
		s38[1]
		} = s39;
	assign	{
		s37[1]
		} = {1{haddr[7:2]==6'd1}};
	assign	{
		s36[0]
		} = hwdata;
	assign	{
		s38[0]
		} = s39;
	assign	{
		s37[0]
		} = {1{haddr[7:2]==6'd0}};
end
if (DATA_WIDTH == 64) begin: gen_hrdata_dw_64
	assign	s41	=	{
					s42[{s53[6:3],1'd1}],
					s42[{s53[6:3],1'd0}]
	};
	assign	{
		s36[31],
		s36[30]
		} = hwdata;
	assign	{
		s38[31],
		s38[30]
		} = s39;
	assign	{
		s37[31],
		s37[30]
		} = {2{haddr[7:3]==5'd15}};
	assign	{
		s36[29],
		s36[28]
		} = hwdata;
	assign	{
		s38[29],
		s38[28]
		} = s39;
	assign	{
		s37[29],
		s37[28]
		} = {2{haddr[7:3]==5'd14}};
	assign	{
		s36[27],
		s36[26]
		} = hwdata;
	assign	{
		s38[27],
		s38[26]
		} = s39;
	assign	{
		s37[27],
		s37[26]
		} = {2{haddr[7:3]==5'd13}};
	assign	{
		s36[25],
		s36[24]
		} = hwdata;
	assign	{
		s38[25],
		s38[24]
		} = s39;
	assign	{
		s37[25],
		s37[24]
		} = {2{haddr[7:3]==5'd12}};
	assign	{
		s36[23],
		s36[22]
		} = hwdata;
	assign	{
		s38[23],
		s38[22]
		} = s39;
	assign	{
		s37[23],
		s37[22]
		} = {2{haddr[7:3]==5'd11}};
	assign	{
		s36[21],
		s36[20]
		} = hwdata;
	assign	{
		s38[21],
		s38[20]
		} = s39;
	assign	{
		s37[21],
		s37[20]
		} = {2{haddr[7:3]==5'd10}};
	assign	{
		s36[19],
		s36[18]
		} = hwdata;
	assign	{
		s38[19],
		s38[18]
		} = s39;
	assign	{
		s37[19],
		s37[18]
		} = {2{haddr[7:3]==5'd9}};
	assign	{
		s36[17],
		s36[16]
		} = hwdata;
	assign	{
		s38[17],
		s38[16]
		} = s39;
	assign	{
		s37[17],
		s37[16]
		} = {2{haddr[7:3]==5'd8}};
	assign	{
		s36[15],
		s36[14]
		} = hwdata;
	assign	{
		s38[15],
		s38[14]
		} = s39;
	assign	{
		s37[15],
		s37[14]
		} = {2{haddr[7:3]==5'd7}};
	assign	{
		s36[13],
		s36[12]
		} = hwdata;
	assign	{
		s38[13],
		s38[12]
		} = s39;
	assign	{
		s37[13],
		s37[12]
		} = {2{haddr[7:3]==5'd6}};
	assign	{
		s36[11],
		s36[10]
		} = hwdata;
	assign	{
		s38[11],
		s38[10]
		} = s39;
	assign	{
		s37[11],
		s37[10]
		} = {2{haddr[7:3]==5'd5}};
	assign	{
		s36[9],
		s36[8]
		} = hwdata;
	assign	{
		s38[9],
		s38[8]
		} = s39;
	assign	{
		s37[9],
		s37[8]
		} = {2{haddr[7:3]==5'd4}};
	assign	{
		s36[7],
		s36[6]
		} = hwdata;
	assign	{
		s38[7],
		s38[6]
		} = s39;
	assign	{
		s37[7],
		s37[6]
		} = {2{haddr[7:3]==5'd3}};
	assign	{
		s36[5],
		s36[4]
		} = hwdata;
	assign	{
		s38[5],
		s38[4]
		} = s39;
	assign	{
		s37[5],
		s37[4]
		} = {2{haddr[7:3]==5'd2}};
	assign	{
		s36[3],
		s36[2]
		} = hwdata;
	assign	{
		s38[3],
		s38[2]
		} = s39;
	assign	{
		s37[3],
		s37[2]
		} = {2{haddr[7:3]==5'd1}};
	assign	{
		s36[1],
		s36[0]
		} = hwdata;
	assign	{
		s38[1],
		s38[0]
		} = s39;
	assign	{
		s37[1],
		s37[0]
		} = {2{haddr[7:3]==5'd0}};
end
if (DATA_WIDTH == 128) begin: gen_hrdata_dw_128
	assign	s41	=	{
					s42[{s53[6:4],2'd3}],
					s42[{s53[6:4],2'd2}],
					s42[{s53[6:4],2'd1}],
					s42[{s53[6:4],2'd0}]
	};
	assign	{
		s36[31],
		s36[30],
		s36[29],
		s36[28]
		} = hwdata;
	assign	{
		s38[31],
		s38[30],
		s38[29],
		s38[28]
		} = s39;
	assign	{
		s37[31],
		s37[30],
		s37[29],
		s37[28]
		} = {4{haddr[7:4]==4'd7}};
	assign	{
		s36[27],
		s36[26],
		s36[25],
		s36[24]
		} = hwdata;
	assign	{
		s38[27],
		s38[26],
		s38[25],
		s38[24]
		} = s39;
	assign	{
		s37[27],
		s37[26],
		s37[25],
		s37[24]
		} = {4{haddr[7:4]==4'd6}};
	assign	{
		s36[23],
		s36[22],
		s36[21],
		s36[20]
		} = hwdata;
	assign	{
		s38[23],
		s38[22],
		s38[21],
		s38[20]
		} = s39;
	assign	{
		s37[23],
		s37[22],
		s37[21],
		s37[20]
		} = {4{haddr[7:4]==4'd5}};
	assign	{
		s36[19],
		s36[18],
		s36[17],
		s36[16]
		} = hwdata;
	assign	{
		s38[19],
		s38[18],
		s38[17],
		s38[16]
		} = s39;
	assign	{
		s37[19],
		s37[18],
		s37[17],
		s37[16]
		} = {4{haddr[7:4]==4'd4}};
	assign	{
		s36[15],
		s36[14],
		s36[13],
		s36[12]
		} = hwdata;
	assign	{
		s38[15],
		s38[14],
		s38[13],
		s38[12]
		} = s39;
	assign	{
		s37[15],
		s37[14],
		s37[13],
		s37[12]
		} = {4{haddr[7:4]==4'd3}};
	assign	{
		s36[11],
		s36[10],
		s36[9],
		s36[8]
		} = hwdata;
	assign	{
		s38[11],
		s38[10],
		s38[9],
		s38[8]
		} = s39;
	assign	{
		s37[11],
		s37[10],
		s37[9],
		s37[8]
		} = {4{haddr[7:4]==4'd2}};
	assign	{
		s36[7],
		s36[6],
		s36[5],
		s36[4]
		} = hwdata;
	assign	{
		s38[7],
		s38[6],
		s38[5],
		s38[4]
		} = s39;
	assign	{
		s37[7],
		s37[6],
		s37[5],
		s37[4]
		} = {4{haddr[7:4]==4'd1}};
	assign	{
		s36[3],
		s36[2],
		s36[1],
		s36[0]
		} = hwdata;
	assign	{
		s38[3],
		s38[2],
		s38[1],
		s38[0]
		} = s39;
	assign	{
		s37[3],
		s37[2],
		s37[1],
		s37[0]
		} = {4{haddr[7:4]==4'd0}};
end
if (DATA_WIDTH == 256) begin: gen_hrdata_dw_256
	assign	s41	=	{
					s42[{s53[6:5],3'd7}],
					s42[{s53[6:5],3'd6}],
					s42[{s53[6:5],3'd5}],
					s42[{s53[6:5],3'd4}],
					s42[{s53[6:5],3'd3}],
					s42[{s53[6:5],3'd2}],
					s42[{s53[6:5],3'd1}],
					s42[{s53[6:5],3'd0}]
	};
	assign	{
		s36[31],
		s36[30],
		s36[29],
		s36[28],
		s36[27],
		s36[26],
		s36[25],
		s36[24]
		} = hwdata;
	assign	{
		s38[31],
		s38[30],
		s38[29],
		s38[28],
		s38[27],
		s38[26],
		s38[25],
		s38[24]
		} = s39;
	assign	{
		s37[31],
		s37[30],
		s37[29],
		s37[28],
		s37[27],
		s37[26],
		s37[25],
		s37[24]
		} = {8{haddr[7:5]==3'd3}};
	assign	{
		s36[23],
		s36[22],
		s36[21],
		s36[20],
		s36[19],
		s36[18],
		s36[17],
		s36[16]
		} = hwdata;
	assign	{
		s38[23],
		s38[22],
		s38[21],
		s38[20],
		s38[19],
		s38[18],
		s38[17],
		s38[16]
		} = s39;
	assign	{
		s37[23],
		s37[22],
		s37[21],
		s37[20],
		s37[19],
		s37[18],
		s37[17],
		s37[16]
		} = {8{haddr[7:5]==3'd2}};
	assign	{
		s36[15],
		s36[14],
		s36[13],
		s36[12],
		s36[11],
		s36[10],
		s36[9],
		s36[8]
		} = hwdata;
	assign	{
		s38[15],
		s38[14],
		s38[13],
		s38[12],
		s38[11],
		s38[10],
		s38[9],
		s38[8]
		} = s39;
	assign	{
		s37[15],
		s37[14],
		s37[13],
		s37[12],
		s37[11],
		s37[10],
		s37[9],
		s37[8]
		} = {8{haddr[7:5]==3'd1}};
	assign	{
		s36[7],
		s36[6],
		s36[5],
		s36[4],
		s36[3],
		s36[2],
		s36[1],
		s36[0]
		} = hwdata;
	assign	{
		s38[7],
		s38[6],
		s38[5],
		s38[4],
		s38[3],
		s38[2],
		s38[1],
		s38[0]
		} = s39;
	assign	{
		s37[7],
		s37[6],
		s37[5],
		s37[4],
		s37[3],
		s37[2],
		s37[1],
		s37[0]
		} = {8{haddr[7:5]==3'd0}};
end
if (DATA_WIDTH == 512) begin: gen_hrdata_dw_512
	assign	s41	=	{
					s42[{s53[6],4'd15}],
					s42[{s53[6],4'd14}],
					s42[{s53[6],4'd13}],
					s42[{s53[6],4'd12}],
					s42[{s53[6],4'd11}],
					s42[{s53[6],4'd10}],
					s42[{s53[6],4'd9}],
					s42[{s53[6],4'd8}],
					s42[{s53[6],4'd7}],
					s42[{s53[6],4'd6}],
					s42[{s53[6],4'd5}],
					s42[{s53[6],4'd4}],
					s42[{s53[6],4'd3}],
					s42[{s53[6],4'd2}],
					s42[{s53[6],4'd1}],
					s42[{s53[6],4'd0}]
	};
	assign	{
		s36[31],
		s36[30],
		s36[29],
		s36[28],
		s36[27],
		s36[26],
		s36[25],
		s36[24],
		s36[23],
		s36[22],
		s36[21],
		s36[20],
		s36[19],
		s36[18],
		s36[17],
		s36[16]
		} = hwdata;
	assign	{
		s38[31],
		s38[30],
		s38[29],
		s38[28],
		s38[27],
		s38[26],
		s38[25],
		s38[24],
		s38[23],
		s38[22],
		s38[21],
		s38[20],
		s38[19],
		s38[18],
		s38[17],
		s38[16]
		} = s39;
	assign	{
		s37[31],
		s37[30],
		s37[29],
		s37[28],
		s37[27],
		s37[26],
		s37[25],
		s37[24],
		s37[23],
		s37[22],
		s37[21],
		s37[20],
		s37[19],
		s37[18],
		s37[17],
		s37[16]
		} = {16{haddr[7:6]==2'd1}};
	assign	{
		s36[15],
		s36[14],
		s36[13],
		s36[12],
		s36[11],
		s36[10],
		s36[9],
		s36[8],
		s36[7],
		s36[6],
		s36[5],
		s36[4],
		s36[3],
		s36[2],
		s36[1],
		s36[0]
		} = hwdata;
	assign	{
		s38[15],
		s38[14],
		s38[13],
		s38[12],
		s38[11],
		s38[10],
		s38[9],
		s38[8],
		s38[7],
		s38[6],
		s38[5],
		s38[4],
		s38[3],
		s38[2],
		s38[1],
		s38[0]
		} = s39;
	assign	{
		s37[15],
		s37[14],
		s37[13],
		s37[12],
		s37[11],
		s37[10],
		s37[9],
		s37[8],
		s37[7],
		s37[6],
		s37[5],
		s37[4],
		s37[3],
		s37[2],
		s37[1],
		s37[0]
		} = {16{haddr[7:6]==2'd0}};
end
if (DATA_WIDTH == 1024) begin: gen_hrdata_dw_1024
	assign	s41	=	{
					s42[5'd31],
					s42[5'd30],
					s42[5'd29],
					s42[5'd28],
					s42[5'd27],
					s42[5'd26],
					s42[5'd25],
					s42[5'd24],
					s42[5'd23],
					s42[5'd22],
					s42[5'd21],
					s42[5'd20],
					s42[5'd19],
					s42[5'd18],
					s42[5'd17],
					s42[5'd16],
					s42[5'd15],
					s42[5'd14],
					s42[5'd13],
					s42[5'd12],
					s42[5'd11],
					s42[5'd10],
					s42[5'd9],
					s42[5'd8],
					s42[5'd7],
					s42[5'd6],
					s42[5'd5],
					s42[5'd4],
					s42[5'd3],
					s42[5'd2],
					s42[5'd1],
					s42[5'd0]
	};
	assign	{
		s36[31],
		s36[30],
		s36[29],
		s36[28],
		s36[27],
		s36[26],
		s36[25],
		s36[24],
		s36[23],
		s36[22],
		s36[21],
		s36[20],
		s36[19],
		s36[18],
		s36[17],
		s36[16],
		s36[15],
		s36[14],
		s36[13],
		s36[12],
		s36[11],
		s36[10],
		s36[9],
		s36[8],
		s36[7],
		s36[6],
		s36[5],
		s36[4],
		s36[3],
		s36[2],
		s36[1],
		s36[0]
		} = hwdata;
	assign	{
		s38[31],
		s38[30],
		s38[29],
		s38[28],
		s38[27],
		s38[26],
		s38[25],
		s38[24],
		s38[23],
		s38[22],
		s38[21],
		s38[20],
		s38[19],
		s38[18],
		s38[17],
		s38[16],
		s38[15],
		s38[14],
		s38[13],
		s38[12],
		s38[11],
		s38[10],
		s38[9],
		s38[8],
		s38[7],
		s38[6],
		s38[5],
		s38[4],
		s38[3],
		s38[2],
		s38[1],
		s38[0]
		} = s39;
	assign	{
		s37[31],
		s37[30],
		s37[29],
		s37[28],
		s37[27],
		s37[26],
		s37[25],
		s37[24],
		s37[23],
		s37[22],
		s37[21],
		s37[20],
		s37[19],
		s37[18],
		s37[17],
		s37[16],
		s37[15],
		s37[14],
		s37[13],
		s37[12],
		s37[11],
		s37[10],
		s37[9],
		s37[8],
		s37[7],
		s37[6],
		s37[5],
		s37[4],
		s37[3],
		s37[2],
		s37[1],
		s37[0]
		} = {32{haddr[7]==1'd0}};
end
endgenerate

assign s43 = hsel & hready_in & ~hwrite & htrans[1];
wire s54 = s34 ? s35[7] : haddr[7];
always @(posedge hclk) begin
    if (s43 || s34) begin
        case (s54)
        1'b0:
		hrdata <= s41;
	default:
		hrdata <= {DATA_WIDTH{1'b0}};
	endcase
    end
end

endmodule

