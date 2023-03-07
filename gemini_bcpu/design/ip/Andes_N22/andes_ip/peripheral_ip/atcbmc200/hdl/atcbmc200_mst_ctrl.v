// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"

module atcbmc200_mst_ctrl(
                           `ifdef ATCBMC200_AHB_SLV0
                           	  slv0_grant,
                           	  slv0_sel,
                           	  hs0_hready,
                           	  hs0_hrdata,
                           	  hs0_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV1
                           	  slv1_grant,
                           	  slv1_sel,
                           	  hs1_hready,
                           	  hs1_hrdata,
                           	  hs1_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV2
                           	  slv2_grant,
                           	  slv2_sel,
                           	  hs2_hready,
                           	  hs2_hrdata,
                           	  hs2_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV3
                           	  slv3_grant,
                           	  slv3_sel,
                           	  hs3_hready,
                           	  hs3_hrdata,
                           	  hs3_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV4
                           	  slv4_grant,
                           	  slv4_sel,
                           	  hs4_hready,
                           	  hs4_hrdata,
                           	  hs4_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV5
                           	  slv5_grant,
                           	  slv5_sel,
                           	  hs5_hready,
                           	  hs5_hrdata,
                           	  hs5_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV6
                           	  slv6_grant,
                           	  slv6_sel,
                           	  hs6_hready,
                           	  hs6_hrdata,
                           	  hs6_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV7
                           	  slv7_grant,
                           	  slv7_sel,
                           	  hs7_hready,
                           	  hs7_hrdata,
                           	  hs7_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV8
                           	  slv8_grant,
                           	  slv8_sel,
                           	  hs8_hready,
                           	  hs8_hrdata,
                           	  hs8_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV9
                           	  slv9_grant,
                           	  slv9_sel,
                           	  hs9_hready,
                           	  hs9_hrdata,
                           	  hs9_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV10
                           	  slv10_grant,
                           	  slv10_sel,
                           	  hs10_hready,
                           	  hs10_hrdata,
                           	  hs10_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV11
                           	  slv11_grant,
                           	  slv11_sel,
                           	  hs11_hready,
                           	  hs11_hrdata,
                           	  hs11_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV12
                           	  slv12_grant,
                           	  slv12_sel,
                           	  hs12_hready,
                           	  hs12_hrdata,
                           	  hs12_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV13
                           	  slv13_grant,
                           	  slv13_sel,
                           	  hs13_hready,
                           	  hs13_hrdata,
                           	  hs13_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV14
                           	  slv14_grant,
                           	  slv14_sel,
                           	  hs14_hready,
                           	  hs14_hrdata,
                           	  hs14_hresp,
                           `endif
                           `ifdef ATCBMC200_AHB_SLV15
                           	  slv15_grant,
                           	  slv15_sel,
                           	  hs15_hready,
                           	  hs15_hrdata,
                           	  hs15_hresp,
                           `endif
                           	  hclk,
                           	  hresetn,
                           	  hm_htrans,
                           	  hm_haddr,
                           	  hm_hburst,
                           	  hm_hprot,
                           	  hm_hsize,
                           	  hm_hwrite,
                           	  hm_hrdata,
                           	  hm_hready,
                           	  hm_hresp,
                           	  ctrl_wen,
                           	  resp_mode,
                           	  slv_sel_err,
                           	  dec_en,
                           	  mst_haddr,
                           	  mst_hburst,
                           	  mst_hprot,
                           	  mst_hsize,
                           	  mst_hwrite,
                           	  mst_htrans
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
parameter DATA_WIDTH = `ATCBMC200_DATA_WIDTH;

localparam ADDR_MSB = ADDR_WIDTH - 1;
localparam DATA_MSB = DATA_WIDTH - 1;

localparam ST_SIZE     = 3;
localparam ST_IDLE     = 3'd0,
	   ST_ARB      = 3'd1,
	   ST_TRANS    = 3'd2,
	   ST_ERROR0   = 3'd3,
	   ST_ERROR1   = 3'd4,
	   ST_FUZZY    = 3'd5;

localparam HTRANS_IDLE   = 2'b00;
localparam HTRANS_NONSEQ = 2'b10;

localparam HRESP_OK      = 2'b00;
localparam HRESP_ERROR   = 2'b01;


`ifdef ATCBMC200_AHB_SLV0
input                         slv0_grant;
input                         slv0_sel;
input                         hs0_hready;
input            [DATA_MSB:0] hs0_hrdata;
input                   [1:0] hs0_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV1
input                         slv1_grant;
input                         slv1_sel;
input                         hs1_hready;
input            [DATA_MSB:0] hs1_hrdata;
input                   [1:0] hs1_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV2
input                         slv2_grant;
input                         slv2_sel;
input                         hs2_hready;
input            [DATA_MSB:0] hs2_hrdata;
input                   [1:0] hs2_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV3
input                         slv3_grant;
input                         slv3_sel;
input                         hs3_hready;
input            [DATA_MSB:0] hs3_hrdata;
input                   [1:0] hs3_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV4
input                         slv4_grant;
input                         slv4_sel;
input                         hs4_hready;
input            [DATA_MSB:0] hs4_hrdata;
input                   [1:0] hs4_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV5
input                         slv5_grant;
input                         slv5_sel;
input                         hs5_hready;
input            [DATA_MSB:0] hs5_hrdata;
input                   [1:0] hs5_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV6
input                         slv6_grant;
input                         slv6_sel;
input                         hs6_hready;
input            [DATA_MSB:0] hs6_hrdata;
input                   [1:0] hs6_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV7
input                         slv7_grant;
input                         slv7_sel;
input                         hs7_hready;
input            [DATA_MSB:0] hs7_hrdata;
input                   [1:0] hs7_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV8
input                         slv8_grant;
input                         slv8_sel;
input                         hs8_hready;
input            [DATA_MSB:0] hs8_hrdata;
input                   [1:0] hs8_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV9
input                         slv9_grant;
input                         slv9_sel;
input                         hs9_hready;
input            [DATA_MSB:0] hs9_hrdata;
input                   [1:0] hs9_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV10
input                         slv10_grant;
input                         slv10_sel;
input                         hs10_hready;
input            [DATA_MSB:0] hs10_hrdata;
input                   [1:0] hs10_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV11
input                         slv11_grant;
input                         slv11_sel;
input                         hs11_hready;
input            [DATA_MSB:0] hs11_hrdata;
input                   [1:0] hs11_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV12
input                         slv12_grant;
input                         slv12_sel;
input                         hs12_hready;
input            [DATA_MSB:0] hs12_hrdata;
input                   [1:0] hs12_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV13
input                         slv13_grant;
input                         slv13_sel;
input                         hs13_hready;
input            [DATA_MSB:0] hs13_hrdata;
input                   [1:0] hs13_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV14
input                         slv14_grant;
input                         slv14_sel;
input                         hs14_hready;
input            [DATA_MSB:0] hs14_hrdata;
input                   [1:0] hs14_hresp;
`endif
`ifdef ATCBMC200_AHB_SLV15
input                         slv15_grant;
input                         slv15_sel;
input                         hs15_hready;
input            [DATA_MSB:0] hs15_hrdata;
input                   [1:0] hs15_hresp;
`endif

input                             hclk;
input                             hresetn;
input                       [1:0] hm_htrans;
input                [ADDR_MSB:0] hm_haddr;
input                       [2:0] hm_hburst;
input                       [3:0] hm_hprot;
input                       [2:0] hm_hsize;
input                             hm_hwrite;
output               [DATA_MSB:0] hm_hrdata;
output                            hm_hready;
output                      [1:0] hm_hresp;

input                             ctrl_wen;
input                             resp_mode;
input                             slv_sel_err;
output                            dec_en;
output               [ADDR_MSB:0] mst_haddr;
output                      [2:0] mst_hburst;
output                      [3:0] mst_hprot;
output                      [2:0] mst_hsize;
output                            mst_hwrite;
output                      [1:0] mst_htrans;

reg                 [ST_SIZE-1:0] s0;
reg                 [ST_SIZE-1:0] s1;
reg                               s2;
wire                              s3;
reg                         [3:0] s4;
reg                         [3:0] s5;
reg				  s6;
reg                  [ADDR_MSB:0] s7;
reg                         [2:0] s8;
reg                         [3:0] s9;
reg                         [2:0] s10;
reg                               s11;
reg                         [1:0] s12;


reg            [DATA_MSB:0] hm_hrdata;
reg                               hm_hready;
reg                         [1:0] hm_hresp;

reg                               s13;
reg                         [1:0] s14;


assign mst_haddr  = (s2) ? hm_haddr[ADDR_MSB:0] : s7[ADDR_MSB:0];
assign mst_hburst = (s2) ? hm_hburst                       : s8;
assign mst_hprot  = (s2) ? hm_hprot                        : s9;
assign mst_hsize  = (s2) ? hm_hsize                        : s10;
assign mst_hwrite = (s2) ? hm_hwrite                       : s11;
assign mst_htrans = (s2) ? hm_htrans                       : s12;

assign dec_en     = (hm_hready & (hm_htrans==HTRANS_NONSEQ))
                    | (s0==ST_ARB);

always@(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        s7  <= {ADDR_WIDTH{1'b0}};
        s8 <= 3'd0;
        s9  <= 4'd0;
        s10  <= 3'd0;
        s11 <= 1'b0;
        s12 <= 2'd0;
    end
    else if (hm_hready && (hm_htrans==HTRANS_NONSEQ)) begin
        s7  <= hm_haddr[ADDR_MSB:0];
        s8 <= hm_hburst;
        s9  <= hm_hprot;
        s10  <= hm_hsize;
        s11 <= hm_hwrite;
        s12 <= hm_htrans;
    end
end


assign s3 =
`ifdef ATCBMC200_AHB_SLV0
    slv0_grant |
`endif
`ifdef ATCBMC200_AHB_SLV1
    slv1_grant |
`endif
`ifdef ATCBMC200_AHB_SLV2
    slv2_grant |
`endif
`ifdef ATCBMC200_AHB_SLV3
    slv3_grant |
`endif
`ifdef ATCBMC200_AHB_SLV4
    slv4_grant |
`endif
`ifdef ATCBMC200_AHB_SLV5
    slv5_grant |
`endif
`ifdef ATCBMC200_AHB_SLV6
    slv6_grant |
`endif
`ifdef ATCBMC200_AHB_SLV7
    slv7_grant |
`endif
`ifdef ATCBMC200_AHB_SLV8
    slv8_grant |
`endif
`ifdef ATCBMC200_AHB_SLV9
    slv9_grant |
`endif
`ifdef ATCBMC200_AHB_SLV10
    slv10_grant |
`endif
`ifdef ATCBMC200_AHB_SLV11
    slv11_grant |
`endif
`ifdef ATCBMC200_AHB_SLV12
    slv12_grant |
`endif
`ifdef ATCBMC200_AHB_SLV13
    slv13_grant |
`endif
`ifdef ATCBMC200_AHB_SLV14
    slv14_grant |
`endif
`ifdef ATCBMC200_AHB_SLV15
    slv15_grant |
`endif
    1'b0;


always @* begin
s5 =
`ifdef ATCBMC200_AHB_SLV0
	({4{slv0_sel}} & 4'd0) |
`endif
`ifdef ATCBMC200_AHB_SLV1
	({4{slv1_sel}} & 4'd1) |
`endif
`ifdef ATCBMC200_AHB_SLV2
	({4{slv2_sel}} & 4'd2) |
`endif
`ifdef ATCBMC200_AHB_SLV3
	({4{slv3_sel}} & 4'd3) |
`endif
`ifdef ATCBMC200_AHB_SLV4
	({4{slv4_sel}} & 4'd4) |
`endif
`ifdef ATCBMC200_AHB_SLV5
	({4{slv5_sel}} & 4'd5) |
`endif
`ifdef ATCBMC200_AHB_SLV6
	({4{slv6_sel}} & 4'd6) |
`endif
`ifdef ATCBMC200_AHB_SLV7
	({4{slv7_sel}} & 4'd7) |
`endif
`ifdef ATCBMC200_AHB_SLV8
	({4{slv8_sel}} & 4'd8) |
`endif
`ifdef ATCBMC200_AHB_SLV9
	({4{slv9_sel}} & 4'd9) |
`endif
`ifdef ATCBMC200_AHB_SLV10
	({4{slv10_sel}} & 4'd10) |
`endif
`ifdef ATCBMC200_AHB_SLV11
	({4{slv11_sel}} & 4'd11) |
`endif
`ifdef ATCBMC200_AHB_SLV12
	({4{slv12_sel}} & 4'd12) |
`endif
`ifdef ATCBMC200_AHB_SLV13
	({4{slv13_sel}} & 4'd13) |
`endif
`ifdef ATCBMC200_AHB_SLV14
	({4{slv14_sel}} & 4'd14) |
`endif
`ifdef ATCBMC200_AHB_SLV15
	({4{slv15_sel}} & 4'd15) |
`endif
	4'd0;
end

always@(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        s4 <= 4'd0;
        s6 <= 1'b1;
    end
    else if (dec_en) begin
        s4 <= s5;
        s6 <= ~s3;
    end
end

always @* begin
   case({s6, s4})
`ifdef ATCBMC200_AHB_SLV0
	5'd0: begin
        hm_hrdata = hs0_hrdata;
        s13 = hs0_hready;
        s14 = hs0_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV1
	5'd1: begin
        hm_hrdata = hs1_hrdata;
        s13 = hs1_hready;
        s14 = hs1_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV2
	5'd2: begin
        hm_hrdata = hs2_hrdata;
        s13 = hs2_hready;
        s14 = hs2_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV3
	5'd3: begin
        hm_hrdata = hs3_hrdata;
        s13 = hs3_hready;
        s14 = hs3_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV4
	5'd4: begin
        hm_hrdata = hs4_hrdata;
        s13 = hs4_hready;
        s14 = hs4_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV5
	5'd5: begin
        hm_hrdata = hs5_hrdata;
        s13 = hs5_hready;
        s14 = hs5_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV6
	5'd6: begin
        hm_hrdata = hs6_hrdata;
        s13 = hs6_hready;
        s14 = hs6_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV7
	5'd7: begin
        hm_hrdata = hs7_hrdata;
        s13 = hs7_hready;
        s14 = hs7_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV8
	5'd8: begin
        hm_hrdata = hs8_hrdata;
        s13 = hs8_hready;
        s14 = hs8_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV9
	5'd9: begin
        hm_hrdata = hs9_hrdata;
        s13 = hs9_hready;
        s14 = hs9_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV10
	5'd10: begin
        hm_hrdata = hs10_hrdata;
        s13 = hs10_hready;
        s14 = hs10_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV11
	5'd11: begin
        hm_hrdata = hs11_hrdata;
        s13 = hs11_hready;
        s14 = hs11_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV12
	5'd12: begin
        hm_hrdata = hs12_hrdata;
        s13 = hs12_hready;
        s14 = hs12_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV13
	5'd13: begin
        hm_hrdata = hs13_hrdata;
        s13 = hs13_hready;
        s14 = hs13_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV14
	5'd14: begin
        hm_hrdata = hs14_hrdata;
        s13 = hs14_hready;
        s14 = hs14_hresp;
    end
`endif
`ifdef ATCBMC200_AHB_SLV15
	5'd15: begin
        hm_hrdata = hs15_hrdata;
        s13 = hs15_hready;
        s14 = hs15_hresp;
    end
`endif
   default: begin
       hm_hrdata = {DATA_WIDTH{1'b0}};
       s13 = 1'b0;
       s14 = HRESP_OK;
   end
   endcase
end

always @* begin
    case(s0)
        ST_IDLE:   hm_hready = 1'b1;
        ST_ARB:    hm_hready = 1'b0;
        ST_TRANS:  hm_hready = s13;
        ST_ERROR0: hm_hready = 1'b0;
        ST_ERROR1: hm_hready = 1'b1;
        ST_FUZZY:  hm_hready = 1'b0;
        default:   hm_hready = 1'b1;
    endcase
end

always @* begin
    case(s0)
        ST_IDLE:   hm_hresp = HRESP_OK;
        ST_ARB:    hm_hresp = HRESP_OK;
        ST_TRANS:  hm_hresp = s14;
        ST_ERROR0: hm_hresp = HRESP_ERROR;
        ST_ERROR1: hm_hresp = {1'b0, resp_mode};
        ST_FUZZY:  hm_hresp = HRESP_OK;
        default:   hm_hresp = HRESP_OK;
    endcase
end


always@(posedge hclk or negedge hresetn) begin
    if (!hresetn)  begin
        s0 <= ST_IDLE;
    end
    else begin
        s0 <= s1;
    end
end

always @* begin

    case(s0)
    ST_IDLE: begin
        if (s3) begin
            s1 = ST_TRANS;
        end
        else if (slv_sel_err) begin
            if (ctrl_wen) begin
        	    s1 = ST_FUZZY;
            end
            else begin
                s1 = (resp_mode) ? ST_ERROR0 : ST_ERROR1;
            end
        end
        else if (hm_htrans==HTRANS_NONSEQ) begin
            s1 = ST_ARB;
        end
        else begin
            s1 = ST_IDLE;
        end
    end

    ST_ARB: begin
        if (s3) begin
            s1 = ST_TRANS;
        end
        else begin
            s1 = ST_ARB;
        end
    end

    ST_TRANS: begin
        if (s13 && s3) begin
            s1 = ST_TRANS;
        end
        else if (s13 && slv_sel_err) begin
            if (ctrl_wen) begin
        	    s1 = ST_FUZZY;
            end
            else begin
                s1 = (resp_mode) ? ST_ERROR0 : ST_ERROR1;
            end
        end
        else if (s13 && (hm_htrans==HTRANS_NONSEQ)) begin
            s1 = ST_ARB;
        end
        else if (s13 && (hm_htrans==HTRANS_IDLE)) begin
            s1 = ST_IDLE;
        end
        else begin
            s1 = ST_TRANS;
       end
    end

    ST_ERROR0: begin
        s1 = ST_ERROR1;
    end

    ST_ERROR1: begin
        if (hm_htrans==HTRANS_IDLE) begin
            s1 = ST_IDLE;
        end
        else if (s3) begin
            s1 = ST_TRANS;
        end
        else if (slv_sel_err) begin
            s1 = (resp_mode) ? ST_ERROR0 : ST_ERROR1;
        end
        else if (hm_htrans==HTRANS_NONSEQ) begin
            s1 = ST_ARB;
        end
        else begin
            s1 = ST_IDLE;
        end
    end

    ST_FUZZY: begin
        s1 = (resp_mode) ? ST_ERROR0 : ST_ERROR1;
    end

    default: begin
        s1 = ST_IDLE;
    end
    endcase
end

always @* begin

    case(s0)
    ST_IDLE,
    ST_TRANS,
    ST_ERROR1: begin
        s2 = 1'b1;
    end


    default: begin
        s2 = 1'b0;
    end
    endcase
end

endmodule

