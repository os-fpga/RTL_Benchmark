//------------------------------------------------------------------------------
// Copyright (c) 2019 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           cdnsusbhs_ocp2axi_sl.v
//   Module Name:        cdnsusbhs_ocp2axi_sl
//
//   Release Revision:   R128_F015
//   Release SVN Tag:    USBHS_DUS1301_R128_F015_H03X32T08A32
//
//   IP Name:            USBHS-OTG
//   IP Part Number:     IP4010E
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          USB
//   Technology:         N/A
//   Protocol:           USB2
//   Architecture:       OTGCTL
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description:
//   AXI slave to OCP synthesis wrapper.
//   L.B., S.G.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



module cdnsusbhs_ocp2axi_sl
  (
  aclk,
  areset,


  awid,
  awaddr,
  awsize,
  awlen,
  awburst,
  awlock,
  awcache,
  awprot,
  awvalid,
  awready,


  `ifdef CDNSUSBHS_UP_AXI_4
  `else
  wid,
  `endif
  wdata,
  wstrb,
  wvalid,
  wready,
  wlast,


  bid,
  bready,
  bresp,
  bvalid,


  arid,
  araddr,
  arsize,
  arlen,
  arburst,
  arlock,
  arcache,
  arprot,
  arvalid,
  arready,


  rid,
  rready,
  rdata,
  rresp,
  rvalid,
  rlast,


  scmdaccept,
  sresp,
  sdata,
  mcmd,
  maddr,
  mbyteen,
  mdata,

  endian
  );





  parameter UPDATAWIDTH      = 32'd`CDNSUSBHS_UPDATAWIDTH;
  parameter UPADDRWIDTH      = 32'd`CDNSUSBHS_UPADDRWIDTH;
  parameter SAXI_ID_WIDTH    = 32'd`CDNSUSBHS_SAXI_ID_WIDTH;
  parameter S_LEN_WIDTH      = 32'd`CDNSUSBHS_S_LEN_WIDTH;
  parameter S_CACHE_WIDTH    = 32'd`CDNSUSBHS_S_CACHE_WIDTH;


  parameter AXI_WRAP_S_AWIDTH = 32'd32;
  parameter AXI_WRAP_S_DWIDTH = 32'd32;




  parameter AXI_OKAY      = 2'b00;
  parameter AXI_EXOKAY    = 2'b01;
  parameter AXI_SLVERR    = 2'b10;
  parameter AXI_DECERR    = 2'b11;




  parameter OCP_IDLE      = 3'b000;
  parameter OCP_WR        = 3'b001;
  parameter OCP_RD        = 3'b010;




  parameter OCP_NULL      = 2'b00;
  parameter OCP_DVA       = 2'b01;
  parameter OCP_FAIL      = 2'b10;
  parameter OCP_ERR       = 2'b11;








  input                           aclk;
  input                           areset;


  input       [SAXI_ID_WIDTH-1:0] awid;
  input         [UPADDRWIDTH-1:0] awaddr;
  input                     [2:0] awsize;
  input         [S_LEN_WIDTH-1:0] awlen;
  input                     [1:0] awburst;
  input                     [1:0] awlock;
  input       [S_CACHE_WIDTH-1:0] awcache;
  input                     [2:0] awprot;
  input                           awvalid;
  output                          awready;


  `ifdef CDNSUSBHS_UP_AXI_4
  `else
  input       [SAXI_ID_WIDTH-1:0] wid;
  `endif
  input                    [31:0] wdata;
  input                     [3:0] wstrb;
  input                           wvalid;
  output                          wready;
  input                           wlast;


  output      [SAXI_ID_WIDTH-1:0] bid;
  input                           bready;
  output                    [1:0] bresp;
  output                          bvalid;


  input       [SAXI_ID_WIDTH-1:0] arid;
  input         [UPADDRWIDTH-1:0] araddr;
  input                     [2:0] arsize;
  input         [S_LEN_WIDTH-1:0] arlen;
  input                     [1:0] arburst;
  input                     [1:0] arlock;
  input       [S_CACHE_WIDTH-1:0] arcache;
  input                     [2:0] arprot;
  input                           arvalid;
  output                          arready;


  output      [SAXI_ID_WIDTH-1:0] rid;
  input                           rready;
  output                    [31:0] rdata;
  output                    [1:0] rresp;
  output                          rvalid;
  output                          rlast;


  input                           scmdaccept;
  input                     [1:0] sresp;
  input                    [31:0] sdata;
  output                    [2:0] mcmd;
  output        [UPADDRWIDTH-1:0] maddr;
  output                    [3:0] mbyteen;
  output                   [31:0] mdata;

  input                           endian;





  wire                            ocpresp;
  reg                             ocpresp_r;
  reg     [AXI_WRAP_S_DWIDTH-1:0] sdatar;
  reg                [(32/8)-1:0] wstrb_i;
  wire               [(32/8)-1:0] byteen_rd;

  reg                       [3:0] len_r;
  reg                       [1:0] burst_r;
  reg         [SAXI_ID_WIDTH-1:0] id_r;
  reg           [UPADDRWIDTH-1:0] maddr_r;
  wire          [UPADDRWIDTH-1:0] maddr_nxt;
  reg                       [2:0] size_r;
  wire                      [2:0] size;
`ifdef CDNSUSBHS_SLAVE_WAITSTATE_SUPPORT
  reg                             scmdaccept_r;
`endif










  reg [2:0] xstate;
  reg [2:0] xstate_n;
  parameter XREAD   = 3'b000;
  parameter XWRITE  = 3'b001;
  parameter XWRITEB = 3'b101;
  parameter XBVALID = 3'b010;
  parameter XRDATA  = 3'b011;
  parameter XRESET  = 3'b100;
  parameter XIDLE   = 3'b111;


  `CDNSUSBHS_ALWAYS(aclk,areset)
    if `CDNSUSBHS_RESET(areset)
      xstate<=XRESET;
    else
      xstate<=xstate_n;


  always @(*)  begin
    if (xstate==XIDLE) begin

      if (wvalid || awvalid)               xstate_n=XWRITE;
      else if  (arvalid)                   xstate_n=XREAD;
      else                                 xstate_n=XIDLE;
    end

    else if (xstate==XWRITE) begin
      if (!wvalid && !awvalid && !arvalid) xstate_n=XIDLE;
      else if (!wvalid || !awvalid)        xstate_n=XREAD;
      else if (scmdaccept && !wlast)       xstate_n=XWRITEB;
      else if (scmdaccept)                 xstate_n=XBVALID;
      else                                 xstate_n=XWRITE;
    end
    else if (xstate==XWRITEB) begin
      if (!wvalid)                         xstate_n=XWRITEB;
      else if (scmdaccept && wlast)        xstate_n=XBVALID;
      else                                 xstate_n=XWRITEB;
    end

    else if(xstate==XBVALID) begin
      if (bready)                          xstate_n=XREAD;
      else                                 xstate_n=XBVALID;
    end

    else if(xstate==XREAD) begin
      if (!wvalid && !awvalid && !arvalid) xstate_n=XIDLE;
      else if (!arvalid)                   xstate_n=XWRITE;
`ifdef CDNSUSBHS_SLAVE_WAITSTATE_SUPPORT
      else if (ocpresp && scmdaccept)      xstate_n=XWRITE;
      else if (scmdaccept)                 xstate_n=XRDATA;
      else                                 xstate_n=XREAD;
`else
      else                                 xstate_n=XRDATA;
`endif
    end
    else if (xstate==XRDATA) begin
      if (rready && rvalid && rlast)       xstate_n=XWRITE;
      else                                 xstate_n=XRDATA;
    end
    else
                                           xstate_n=XWRITE;
  end








  `ifdef CDNSUSBHS_UP_AXI_4
  assign mcmd = (xstate==XWRITE && wvalid && awvalid)? OCP_WR :
                (xstate==XWRITEB && wvalid          )? OCP_WR :
                (xstate==XREAD  && arvalid          )? OCP_RD :
                (xstate==XRDATA && !rlast && rready && rvalid)? OCP_RD :
  `ifdef CDNSUSBHS_SLAVE_WAITSTATE_SUPPORT
                (xstate==XRDATA && !rlast && !scmdaccept_r)? OCP_RD :
  `endif
                                                       OCP_IDLE;
  `else
  assign mcmd = (xstate==XWRITE && wvalid && awvalid && (awid==wid)
                                                    )? OCP_WR :
                (xstate==XWRITEB && wvalid && (id_r==wid)
                                                    )? OCP_WR :
                (xstate==XREAD  && arvalid          )? OCP_RD :
                (xstate==XRDATA && !rlast && rready && rvalid)? OCP_RD :
  `ifdef CDNSUSBHS_SLAVE_WAITSTATE_SUPPORT
                (xstate==XRDATA && !rlast && !scmdaccept_r)? OCP_RD :
  `endif
                                                       OCP_IDLE;
  `endif


  assign maddr = (xstate==XWRITE) ? awaddr :
                 (xstate==XWRITEB)? maddr_nxt:
                 (xstate==XRDATA) ? maddr_nxt:
                                    araddr;














  always @(size or maddr or wstrb or endian)
    begin : WSTRB_I_COMB_PROC

    case (size)
      3'b000 :
        begin
             if (maddr[1:0] == 2'b00) wstrb_i = {1'b0,1'b0,1'b0,wstrb[0]} ;
        else if (maddr[1:0] == 2'b01) wstrb_i = {1'b0,1'b0,wstrb[1],1'b0} ;
        else if (maddr[1:0] == 2'b10) wstrb_i = {1'b0,wstrb[2],1'b0,1'b0} ;
        else                          wstrb_i = {wstrb[3],1'b0,1'b0,1'b0} ;
        end
      3'b001 :
        begin
        if (endian == 1'b0)
          begin
               if (maddr[1:0] == 2'b00) wstrb_i = {1'b0,1'b0,wstrb[1],wstrb[0]} ;
          else if (maddr[1:0] == 2'b01) wstrb_i = {1'b0,1'b0,wstrb[1],1'b0} ;
          else if (maddr[1:0] == 2'b10) wstrb_i = {wstrb[3],wstrb[2],1'b0,1'b0} ;
          else                          wstrb_i = {wstrb[3],1'b0,1'b0,1'b0} ;
          end
        else
          begin
               if (maddr[1:0] == 2'b00) wstrb_i = {1'b0,1'b0,wstrb[1],wstrb[0]} ;
          else if (maddr[1:0] == 2'b01) wstrb_i = {1'b0,1'b0,1'b0,wstrb[0]} ;
          else if (maddr[1:0] == 2'b10) wstrb_i = {wstrb[3],wstrb[2],1'b0,1'b0} ;
          else                          wstrb_i = {1'b0,wstrb[2],1'b0,1'b0} ;
          end
        end
      3'b010 :
        begin
        if (endian == 1'b0)
          begin
               if (maddr[1:0] == 2'b01) wstrb_i = {wstrb[3],wstrb[2],wstrb[1],1'b0} ;
          else if (maddr[1:0] == 2'b10) wstrb_i = {wstrb[3],wstrb[2],1'b0,1'b0} ;
          else if (maddr[1:0] == 2'b11) wstrb_i = {wstrb[3],1'b0,1'b0,1'b0} ;
          else                          wstrb_i = wstrb ;
          end
        else
          begin
               if (maddr[1:0] == 2'b01) wstrb_i = {1'b0,wstrb[2],wstrb[1],wstrb[0]} ;
          else if (maddr[1:0] == 2'b10) wstrb_i = {1'b0,1'b0,wstrb[1],wstrb[0]} ;
          else if (maddr[1:0] == 2'b11) wstrb_i = {1'b0,1'b0,1'b0,wstrb[0]} ;
          else                          wstrb_i = wstrb ;
          end
        end
      default :
        begin
        wstrb_i = 4'h0 ;
        end
    endcase
    end

  assign byteen_rd = (size == 3'b000 && maddr[1:0] == 2'b00) ? 4'b0001 :
                     (size == 3'b000 && maddr[1:0] == 2'b01) ? 4'b0010 :
                     (size == 3'b000 && maddr[1:0] == 2'b10) ? 4'b0100 :
                     (size == 3'b000 && maddr[1:0] == 2'b11) ? 4'b1000 :
                     (size == 3'b001 && maddr[1:0] == 2'b00) ? 4'b0011 :
                     (size == 3'b001 && maddr[1:0] == 2'b10) ? 4'b1100 :
                                                               4'b1111;
  assign mbyteen = (xstate==XWRITE) ? wstrb_i : byteen_rd;


  assign mdata  = wdata;





  assign arready = (xstate==XREAD  && scmdaccept)? 1'b1 : 1'b0;
  assign rresp   = AXI_OKAY;
  assign rvalid  = ocpresp |  ocpresp_r;
  assign rdata   = (ocpresp) ? sdata : sdatar;
  assign rlast   = (len_r == 4'b0000) ? 1'b1 : 1'b0;


  assign ocpresp = (sresp==OCP_DVA) ? 1'b1 : 1'b0;





  assign awready = (xstate==XWRITE && scmdaccept && wvalid && awvalid)? 1'b1 :
                                                                        1'b0;
  assign wready  = (xstate==XWRITE && scmdaccept && wvalid && awvalid)? 1'b1 :
                   (xstate==XWRITEB && scmdaccept && wvalid)          ? 1'b1 :
                                                                        1'b0;
  assign bvalid  = (xstate==XBVALID)? 1'b1 : 1'b0;
  assign bresp   = AXI_OKAY;






  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : RDATA_R_PROC
      if `CDNSUSBHS_RESET(areset)
        sdatar <= {{AXI_WRAP_S_DWIDTH}{1'b0}};
      else
      begin
        if (ocpresp)
          sdatar <= sdata;
       end
    end


  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : OCPRESP_R_PROC
      if `CDNSUSBHS_RESET(areset)
        ocpresp_r <= 1'b0;
      else
        if (xstate==XRDATA && (ocpresp_r==1'b1 || ocpresp==1'b1))
          ocpresp_r <= ~(rready & rvalid);
        else
          ocpresp_r <= 1'b0;









     end

`ifdef CDNSUSBHS_SLAVE_WAITSTATE_SUPPORT

  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : SCMDACCEPT_R_PROC
      if `CDNSUSBHS_RESET(areset)
        scmdaccept_r <= 1'b0;
      else
        if (scmdaccept)
          scmdaccept_r <= 1'b1;

        else if (mcmd==OCP_WR)
          scmdaccept_r <= 1'b0;
        else if (mcmd==OCP_RD)
          scmdaccept_r <= 1'b0;
     end
`endif




  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : ID_PROC
    if `CDNSUSBHS_RESET(areset)
      id_r <= {SAXI_ID_WIDTH{1'b0}};
    else
    begin
      if (scmdaccept==1'b1)
      begin
        if (xstate==XREAD)
          id_r <= arid;
        else if (xstate==XWRITE)
          id_r <= awid;
      end
    end
  end

  assign rid = id_r;
  assign bid = (xstate==XWRITE && scmdaccept==1'b1) ? awid : id_r;




  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : LEN_PROC
    if `CDNSUSBHS_RESET(areset)
      len_r <= {4{1'b0}};
    else
    begin
      if (xstate==XREAD && scmdaccept==1'b1 && arburst[1]==1'b0)
        len_r <= arlen;
      else if (xstate!=XRDATA )
        len_r <= {4{1'b0}};
      else if (rready && rvalid)
        len_r <= len_r - 1'b1;
    end
  end




  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : BURST_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      burst_r <= {2{1'b0}};
      size_r  <= {3{1'b0}};
      end
    else
    begin
      if (scmdaccept==1'b1)
      begin
        if (xstate==XREAD)
        begin
          burst_r <= arburst;
          size_r  <= arsize;
        end
        else if (xstate==XWRITE)
        begin
          burst_r <= awburst;
          size_r  <= awsize;
        end
      end
    end
  end

  assign size = (xstate==XREAD)  ? arsize :
                (xstate==XWRITE) ? awsize :
                                   size_r;




  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : MADDR_PROC
    if `CDNSUSBHS_RESET(areset)
      maddr_r <= {UPADDRWIDTH{1'b0}};
    else
    begin
      if (scmdaccept==1'b1)
      begin
        if (xstate==XREAD)
          maddr_r <= araddr;
        else if (xstate==XWRITE)
          maddr_r <= awaddr;
        else
          maddr_r <= maddr_nxt;
      end
    end
  end

  assign maddr_nxt =
                     (burst_r==2'b00 && size_r==3'b001) ? {maddr_r[UPADDRWIDTH-1:1],1'b0} :
                     (burst_r==2'b00 && size_r==3'b010) ? {maddr_r[UPADDRWIDTH-1:2],2'b00} :
                     (burst_r==2'b01 && size_r==3'b000) ? maddr_r+1'b1 :
                     (burst_r==2'b01 && size_r==3'b001) ? {(maddr_r[UPADDRWIDTH-1:1]+1'b1),1'b0} :
                     (burst_r==2'b01 && size_r==3'b010) ? {(maddr_r[UPADDRWIDTH-1:2]+1'b1),2'b00} :
                                                          maddr_r;

endmodule


