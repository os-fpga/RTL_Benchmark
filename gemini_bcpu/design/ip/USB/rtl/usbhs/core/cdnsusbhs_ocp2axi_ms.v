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
//   Filename:           cdnsusbhs_ocp2axi_ms.v
//   Module Name:        cdnsusbhs_ocp2axi_ms
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
//   The AXI Master wrapper which issues
//   AXI transactions on the basis of incoming
//   transactions from an external OCP master.
//   The device implements the transfer protocol
//   according to the AMBA AXI specification
//   as well as the OCP specification.
//   G.P., S.G.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"



module cdnsusbhs_ocp2axi_ms
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


  wid,
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


  mcmd,
  maddr,
  mbyteen,
  mburstseq,
  mburstlength,
  mburstprecise,
  mreqlast,
  mdata,
  scmdaccept,
  sresp,
  sdata,


`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  b_max,
  wot,
  rot,
`endif
  axi_idle,
  axi_serror,
  axi_derror,
  axi_id_wr,
  axi_id_rd,
  axi_lock_wr,
  axi_cache_wr,
  axi_prot_wr,
  axi_lock_rd,
  axi_cache_rd,
  axi_prot_rd
  );









  localparam MAXI_ID_WIDTH     = 32'd`CDNSUSBHS_MAXI_ID_WIDTH;
  localparam M_LEN_WIDTH       = 32'd`CDNSUSBHS_M_LEN_WIDTH;
  localparam M_CACHE_WIDTH     = 32'd`CDNSUSBHS_M_CACHE_WIDTH;

`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  localparam AXI_OT_W          = 32'd`CDNSUSBHS_AXI_OT_W;
  localparam AW_B_FIFO_WIDTH   = M_LEN_WIDTH;
  localparam AXI_WCD           = 32'd`CDNSUSBHS_AXI_WCD;
  localparam AXI_WCD_PW        = 32'd`CDNSUSBHS_AXI_WCD_PW;
  localparam WR_CMD_ADDR_WIDTH = 32'd`CDNSUSBHS_AXI_WCD_PW;
  localparam RD_CMD_ADDR_WIDTH = 32'd`CDNSUSBHS_AXI_WCD_PW;
`endif






  localparam M_DATA_WIDTH    = 8'd32;
  localparam M_ADDR_WIDTH    = 8'd32;


  localparam AXI_DATA_WIDTH = 8'd32;


  localparam AXI_ADDR_WIDTH = 8'd32;


  localparam OCP_DATA_WIDTH = 8'd32;


  localparam OCP_ADDR_WIDTH = 8'd32;








  localparam AXI_SIZE1     = 3'b000;
  localparam AXI_SIZE2     = 3'b001;
  localparam AXI_SIZE4     = 3'b010;
  localparam AXI_SIZE8     = 3'b011;
  localparam AXI_SIZE16    = 3'b100;
  localparam AXI_SIZE32    = 3'b101;
  localparam AXI_SIZE64    = 3'b110;
  localparam AXI_SIZE128   = 3'b111;



  localparam AXI_FIXED     = 2'b00;
  localparam AXI_INCR      = 2'b01;



  localparam AXI_OKAY      = 2'b00;
  localparam AXI_EXOKAY    = 2'b01;
  localparam AXI_SLVERR    = 2'b10;
  localparam AXI_DECERR    = 2'b11;




  localparam OCP_CMD_IDLE      = 3'b000;
  localparam OCP_CMD_WR        = 3'b001;
  localparam OCP_CMD_RD        = 3'b010;
  localparam OCP_CMD_RDEX      = 3'b011;
  localparam OCP_CMD_RDL       = 3'b100;
  localparam OCP_CMD_WRNP      = 3'b101;
  localparam OCP_CMD_WRC       = 3'b110;
  localparam OCP_CMD_BCST      = 3'b111;



  localparam OCP_RESP_NULL      = 2'b00;
  localparam OCP_RESP_DVA       = 2'b01;
  localparam OCP_RESP_FAIL      = 2'b10;
  localparam OCP_RESP_ERR       = 2'b11;










  input                       aclk;
  input                       areset;



  input                       awready;
  output  [MAXI_ID_WIDTH-1:0] awid;
  output   [M_ADDR_WIDTH-1:0] awaddr;
  output    [M_LEN_WIDTH-1:0] awlen;
  output                [2:0] awsize;
  output                [1:0] awburst;
  output                [1:0] awlock;
  output  [M_CACHE_WIDTH-1:0] awcache;
  output                [2:0] awprot;
  output                      awvalid;



  input                       wready;
  output  [MAXI_ID_WIDTH-1:0] wid;
  output   [M_DATA_WIDTH-1:0] wdata;
  output [M_DATA_WIDTH/8-1:0] wstrb;
  output                      wlast;
  output                      wvalid;



  input   [MAXI_ID_WIDTH-1:0] bid;
  input                 [1:0] bresp;
  input                       bvalid;
  output                      bready;



  input                       arready;
  output  [MAXI_ID_WIDTH-1:0] arid;
  output   [M_ADDR_WIDTH-1:0] araddr;
  output    [M_LEN_WIDTH-1:0] arlen;
  output                [2:0] arsize;
  output                [1:0] arburst;
  output                [1:0] arlock;
  output  [M_CACHE_WIDTH-1:0] arcache;
  output                [2:0] arprot;
  output                      arvalid;



  input   [MAXI_ID_WIDTH-1:0] rid;
  input    [M_DATA_WIDTH-1:0] rdata;
  input                 [1:0] rresp;
  input                       rlast;
  input                       rvalid;
  output                      rready;



  input                 [2:0] mcmd;
  input    [M_ADDR_WIDTH-1:0] maddr;
  input  [M_DATA_WIDTH/8-1:0] mbyteen;
  input                 [2:0] mburstseq;
  input               [8-1:0] mburstlength;
  input                       mburstprecise;
  input                       mreqlast;
  input    [M_DATA_WIDTH-1:0] mdata;
  output                      scmdaccept;
  wire                        scmdaccept;
  output                [1:0] sresp;
  reg                   [1:0] sresp;
  output   [M_DATA_WIDTH-1:0] sdata;
  reg      [M_DATA_WIDTH-1:0] sdata;

  input   [MAXI_ID_WIDTH-1:0] axi_id_wr;
  input   [MAXI_ID_WIDTH-1:0] axi_id_rd;

  input                 [1:0] axi_lock_wr;
  input   [M_CACHE_WIDTH-1:0] axi_cache_wr;
  input                 [2:0] axi_prot_wr;
  input                 [1:0] axi_lock_rd;
  input   [M_CACHE_WIDTH-1:0] axi_cache_rd;
  input                 [2:0] axi_prot_rd;

`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT

  input     [M_LEN_WIDTH-1:0] b_max;
  input        [AXI_OT_W-1:0] wot;
  input        [AXI_OT_W-1:0] rot;

`endif
  output                      axi_idle;
  wire                        axi_idle;
  output                      axi_serror;
  wire                        axi_serror;
  output                      axi_derror;
  wire                        axi_derror;





  wire                        single_write;
  wire                        single_read;
  wire                        precise_write;
  wire                        precise_read;

  wire                        ocp_burst_wr_last;
  wire                        ocp_last_wr_ack;
  reg                         ocp_burst_wr_last_r;
  wire                        scmdaccept_i;

  wire     [M_ADDR_WIDTH-1:0] awaddr;
  wire      [M_LEN_WIDTH-1:0] awlen;
  reg      [M_ADDR_WIDTH-1:0] awaddr_r;
  reg       [M_LEN_WIDTH-1:0] awlen_r;
  reg                 [2:0]   awsize;
  reg                 [1:0]   awburst;
  wire                        awvalid;
  wire                        awvalid_i;
  reg                         awvalid_r;
  wire     [M_ADDR_WIDTH-1:0] araddr;
  reg      [M_ADDR_WIDTH-1:0] araddr_r;
  wire      [M_LEN_WIDTH-1:0] arlen;
  reg       [M_LEN_WIDTH-1:0] arlen_r;
  reg                 [2:0]   arsize;
  reg                 [1:0]   arburst;
  wire                        arvalid;
  wire                        arvalid_i;
  reg                         arvalid_r;
  wire     [M_DATA_WIDTH-1:0] wdata;
  wire   [M_DATA_WIDTH/8-1:0] wstrb;
  wire                        wlast;
  wire                        wvalid;
  wire                        rready;
  reg                         rready_r;

  reg                         awlocked;
  reg                         arlocked;

  wire                  [2:0] set_size;
  wire                  [1:0] set_addr;

  reg      [M_ADDR_WIDTH-1:0] maddr_s;
  reg                   [7:0] mbyteen_s;

  reg                         wdata_stored;

  wire                [8-1:0] len;
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT

  wire        [M_LEN_WIDTH-1:0] awlen_ot;
  wire                          aw_b_limit ;
  reg                           aw_b_limit_r ;
  wire    [WR_CMD_ADDR_WIDTH:0] aw_b_cnt ;
  wire                          len_dec ;
  reg                   [8-1:0] len_r;
  reg     [AW_B_FIFO_WIDTH-1:0] wcnt;
  wire                          wlast_ot;
  reg                           awvalid_ot;
  wire    [AW_B_FIFO_WIDTH-1:0] aw_b_fifo_quot;
  wire                          aw_b_fifo_qempty;
  wire                          aw_b_fifo_qfull;
  wire           [AXI_WCD_PW:0] aw_b_fifo_level;
  wire    [AW_B_FIFO_WIDTH-1:0] aw_b_fifo_din;
  wire                          aw_b_fifo_push;
  wire                          fifo_push;
  wire                          aw_b_fifo_pop;
  wire        [M_LEN_WIDTH-1:0] arlen_ot;
  wire                          ar_limit ;
  reg                           ar_limit_r ;
  wire    [RD_CMD_ADDR_WIDTH:0] ar_cnt ;
  reg                           arvalid_ot;

  reg                           wr_before_addr_r;
  wire                  [8-1:0] b_max_8;

  wire                          bxvalid;
  wire                          rxvalid;
`endif








  assign single_write =  (ocp_burst_wr_last_r                ) ? 1'b0 :
                         (mcmd==OCP_CMD_WR && mreqlast       ) ? 1'b1 :
                         (mcmd==OCP_CMD_WR && !mburstprecise ) ? 1'b1 :
                                                                 1'b0 ;



  assign single_read  =  (mcmd==OCP_CMD_RD && mreqlast       ) ? 1'b1 :
                         (mcmd==OCP_CMD_RD && !mburstprecise ) ? 1'b1 :
                                                                 1'b0 ;



  assign precise_write =  (mreqlast                          ) ? 1'b0 :
                          (mcmd==OCP_CMD_WR && mburstprecise ) ? 1'b1 :
                                                                 1'b0 ;



  assign precise_read  =  (mreqlast                          ) ? 1'b0 :

                          (mcmd==OCP_CMD_RD && mburstprecise ) ? 1'b1 :
                                                                 1'b0 ;



  assign ocp_burst_wr_last = (mcmd==OCP_CMD_WR && mreqlast   ) ? 1'b1 :
                                                                 1'b0 ;


  assign ocp_last_wr_ack = ((aw_b_cnt[WR_CMD_ADDR_WIDTH:0] == {(WR_CMD_ADDR_WIDTH+1){1'b0}}) &&
                            ocp_burst_wr_last_r == 1'b1)       ? 1'b1 :
                           (bvalid && (bid == axi_id_wr) &
                            bready &&
                            (aw_b_cnt[WR_CMD_ADDR_WIDTH:1] == {(WR_CMD_ADDR_WIDTH){1'b0}}) &&
                            aw_b_cnt[0] == 1'b1)               ? 1'b1 :
                                                                 1'b0 ;





  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : OCP_BURST_WR_LAST_REG_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      ocp_burst_wr_last_r <= 1'b0 ;
      end
    else
      begin
      if (ocp_last_wr_ack == 1'b1 ||
          ocp_burst_wr_last == 1'b0)
        begin
        ocp_burst_wr_last_r <= 1'b0 ;
        end
      else if (scmdaccept_i)
        begin
        ocp_burst_wr_last_r <= ocp_burst_wr_last ;
        end
      end
    end





  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : AWLOCKED_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      awlocked <= 1'b0 ;
      end
    else
      begin



      if (awlocked == 1'b1 && (((mreqlast == 1'b1 || single_write == 1'b1) &&
                                     wready == 1'b1 && wvalid == 1'b1) ||
                                     wdata_stored == 1'b1 && precise_write == 1'b0))
        awlocked <= 1'b0;
      else if ( (((!(wvalid && wready) )&& wdata_stored==1'b0) || precise_write == 1'b1) && awvalid_i == 1'b1 && awready == 1'b1 )
        awlocked <= 1'b1;
      end
    end





  `CDNSUSBHS_ALWAYS(aclk,areset)
    begin : ARLOCKED_PROC
    if `CDNSUSBHS_RESET(areset)
      begin
      arlocked <= 1'b0 ;
      end
    else
      begin
      if (arlocked == 1'b1 && (mreqlast == 1'b1 || single_read == 1'b1) &&
          rready == 1'b1 && rvalid == 1'b1 && rid == axi_id_rd)
        arlocked <= 1'b0;
      else if (arvalid_i == 1'b1  && arready  == 1'b1)
        arlocked <= 1'b1;
      end
    end




  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : WDATA_STORED_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      wdata_stored <= 1'b0;
    end
    else
    begin
      if ((!(awvalid_i && awready) && awlocked == 1'b0 ) && wvalid == 1'b1 && wready == 1'b1)
      begin
        wdata_stored <= 1'b1;
      end
      else if ((awvalid_i && awready))
      begin
        wdata_stored <= 1'b0;
      end
    end
  end




 assign set_size =
                   (mbyteen_s==8'b00001111) ? AXI_SIZE4 :
                   (mbyteen_s==8'b00000011) ? AXI_SIZE2 :
                   (mbyteen_s==8'b00001100) ? AXI_SIZE2 :
                                              AXI_SIZE1 ;

 assign set_addr = (mbyteen_s[0]==1'b1) ? 2'b00  :
                   (mbyteen_s[2]==1'b1) ? 2'b10  :
                   (mbyteen_s[3]==1'b1) ? 2'b11  :
                   (mbyteen_s[1]==1'b1) ? 2'b01  : 2'b00;




 assign len =
         (single_write | single_read) ? {8{1'b0}}:
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
         (awlocked | arlocked) ? len_r :
`endif
         mburstlength - 1'b1;



  always @(set_addr or maddr or mbyteen)
  begin
    begin
      maddr_s      = {maddr[M_ADDR_WIDTH-1 : 2], set_addr};
      mbyteen_s     = {4'b0000,mbyteen};
    end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AWVALID_R_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      awvalid_r <= 1'b0;
    end
    else
      begin
      if (awvalid_i == 1'b1 && awready == 1'b1)
        awvalid_r <= 1'b0;
      else if (awlocked == 1'b0 && (precise_write == 1'b1 || single_write == 1'b1))
        awvalid_r <= 1'b1;
      else
        awvalid_r <= 1'b0;
      end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AW_ADDR_LEN_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      awaddr_r  <= {M_ADDR_WIDTH{1'b0}};
      awlen_r   <= {M_LEN_WIDTH{1'b0}};
    end
    else
    begin
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
      if (fifo_push==1'b1 && awburst == 2'b01)
        begin
        awaddr_r[M_ADDR_WIDTH-1:2]  <= awaddr_r[M_ADDR_WIDTH-1:2] + b_max[M_LEN_WIDTH-1:0] + 1'b1;
        awlen_r   <= awlen_ot;
        end
      else if (awlocked == 1'b1)
        begin

        awlen_r   <= awlen_ot;
        end
      else if (precise_write == 1'b1 && awlocked == 1'b0)
`else
      if (precise_write == 1'b1 && awlocked == 1'b0)
`endif
      begin
        awaddr_r  <= maddr_s;
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
        awlen_r   <= awlen_ot;
`else
        awlen_r   <= len[M_LEN_WIDTH-1:0];
`endif
      end
      else if (single_write == 1'b1)
      begin
        awaddr_r  <= maddr_s;
        awlen_r   <= {M_LEN_WIDTH{1'b0}};
      end
    end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AW_CHANNEL_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      awsize    <= AXI_SIZE1;
      awburst   <= AXI_FIXED;
    end
    else
    begin
      if (precise_write == 1'b1 && awlocked == 1'b0)
      begin
        awsize    <= AXI_SIZE4;
        if (mburstseq == 3'b101)
          awburst   <= AXI_FIXED;
        else
          awburst   <= AXI_INCR;
      end
      else if (single_write == 1'b1)
      begin
        awsize    <= set_size;
        awburst   <= AXI_INCR;
      end
    end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : ARVALID_R_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      arvalid_r <= 1'b0;
    end
    else
      begin
      if (arlocked == 1'b0 && (precise_read == 1'b1 || single_read == 1'b1))
        arvalid_r <= 1'b1;
      else
        arvalid_r <= 1'b0;
      end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AR_ADDR_LEN_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      araddr_r  <= {M_ADDR_WIDTH{1'b0}};
      arlen_r   <= {M_LEN_WIDTH{1'b0}};
    end
    else
    begin
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
      if (fifo_push==1'b1 && arburst == 2'b01)
        begin
        araddr_r[M_ADDR_WIDTH-1:2]  <= araddr_r[M_ADDR_WIDTH-1:2] + b_max[M_LEN_WIDTH-1:0] + 1'b1;
        arlen_r   <= arlen_ot;
        end
      else if (arlocked == 1'b1)
        begin

        arlen_r   <= arlen_ot;
        end
      else if (precise_read == 1'b1 && arlocked == 1'b0)
`else
      if (precise_read && !arlocked)
`endif
      begin
        araddr_r  <= maddr_s;
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
        arlen_r   <= arlen_ot;
`else
        arlen_r   <= len[M_LEN_WIDTH-1:0];
`endif
      end
      else if (single_read == 1'b1)
      begin
        araddr_r  <= maddr_s;
        arlen_r   <= {M_LEN_WIDTH{1'b0}};
      end
    end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AR_CHANNEL_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      arsize    <= AXI_SIZE1;
      arburst   <= AXI_FIXED;
    end
    else
    begin
      if (precise_read && !arlocked)
      begin
        arsize    <= AXI_SIZE4;
        if (mburstseq == 3'b101)
          arburst   <= AXI_FIXED;
        else
          arburst   <= AXI_INCR;
      end
      else if (single_read == 1'b1)
      begin
        arsize    <= set_size;
        arburst   <= AXI_INCR;
      end
    end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : RREADY_R_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      rready_r <= 1'b0;
    end
    else
      if ((precise_read == 1'b1 || single_read == 1'b1) && (arlocked == 1'b1 || arvalid_i == 1'b1 ))
      begin
        rready_r <= 1'b1;
      end
      else
      begin
        rready_r <= 1'b0;
      end
  end



`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  assign awvalid_i  = !awlocked & awvalid_r & ~aw_b_limit_r;
`else
  assign awvalid_i  = !awlocked & awvalid_r;
`endif
  assign awlock     = axi_lock_wr;
  assign awcache    = axi_cache_wr;
  assign awprot     = axi_prot_wr;
  assign awid       = axi_id_wr;
  assign awaddr     = awaddr_r;
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  assign awlen      = (awlocked) ? awlen_ot : awlen_r;
  assign awvalid    = (awvalid_i | awvalid_ot) & ~aw_b_limit_r;
`else
  assign awlen      = awlen_r;
  assign awvalid    = awvalid_i;
`endif
  assign wid        = axi_id_wr;



`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  assign arvalid_i  = !arlocked & arvalid_r & ~ar_limit_r;
`else
  assign arvalid_i  = !arlocked & arvalid_r;
`endif
  assign arlock     = axi_lock_rd;
  assign arcache    = axi_cache_rd;
  assign arprot     = axi_prot_rd;
  assign araddr     = araddr_r;
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  assign arlen      = (arlocked) ? arlen_ot : arlen_r;
  assign arvalid    = arvalid_i | (arvalid_ot & ~ar_limit_r);
`else
  assign arlen      = arlen_r;
  assign arvalid    = arvalid_i;
`endif
  assign arid       = axi_id_rd;



`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  assign wvalid     = (precise_write | single_write) & (awlocked | awvalid_i) & !wdata_stored  & !(aw_b_fifo_qempty & awlocked);
`else
  assign wvalid     = (precise_write | single_write) & (awlocked | awvalid_i) & !wdata_stored;
`endif
  assign wdata      = mdata;
  assign wstrb      = (wvalid) ? mbyteen_s[M_DATA_WIDTH/8-1 : 0] : {M_DATA_WIDTH/8{1'b0}};

  assign wlast      = (single_write == 1'b1) ? 1'b1 :
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
                      (wlast_ot == 1'b1)     ? 1'b1 :
`endif
                                               mreqlast;



`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  assign rready     = (mcmd == OCP_CMD_RD) ? (rready_r & !(aw_b_fifo_qempty & arlocked)) : 1'b0;
`else
  assign rready     = (mcmd == OCP_CMD_RD) ? rready_r : 1'b0;
`endif



  assign bready     = 1'b1;
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT



`else

`endif




  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : SRESP_DELAY_PROC
    if `CDNSUSBHS_RESET(areset)
    begin
      sresp <= OCP_RESP_NULL;
    end
    else
      begin
      if (rready == 1'b1 && rvalid == 1'b1  && rid == axi_id_rd)
        sresp <= OCP_RESP_DVA;
      else
        sresp <= OCP_RESP_NULL;
      end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : SDATA_DELAY_PROC
    if `CDNSUSBHS_RESET(areset)
      sdata <= {M_DATA_WIDTH{1'b0}};
    else
      sdata <= rdata;
  end


  assign scmdaccept_i = (wdata_stored == 1'b1 && (awlocked == 1'b1 || (awvalid_i & awready)) ) ? 1'b1 :
                        ((awlocked == 1'b1 || (awvalid_i == 1'b1 && awready == 1'b1)) || arlocked == 1'b1) ? (wvalid & wready) | (rready & rvalid  & (rid == axi_id_rd)) :
                        1'b0;

  assign scmdaccept = (ocp_burst_wr_last_r && ocp_last_wr_ack ) ? 1'b1 :
                      (ocp_burst_wr_last                      ) ? 1'b0 :
                                                                  scmdaccept_i;




`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT





cdnsusbhs_common_gen_fifo
  #(
    .FIFO_WIDTH(AW_B_FIFO_WIDTH),
    .FIFO_DEPTH(AXI_WCD),
    .FIFO_ADDR_WIDTH(AXI_WCD_PW)
   )
U_CDNSUSBHS_AW_B_FIFO
  (
    .qout(aw_b_fifo_quot),
    .qempty(aw_b_fifo_qempty),
    .qfull(aw_b_fifo_qfull),
    .qlevel(aw_b_fifo_level),

    .clk(aclk),
    .rst_n(areset),

    .din(aw_b_fifo_din),
    .push(aw_b_fifo_push),

    .pop(aw_b_fifo_pop)
  );

assign aw_b_fifo_din  = (awvalid & awready) ? awlen : arlen;
assign aw_b_fifo_push = (
                         (aw_b_fifo_qempty) &&
                         (awvalid & awready) && (wvalid & wready & wlast)) ? 1'b0 :
                         (wr_before_addr_r) ? 1'b0 :
                        (awvalid & awready) | (arvalid & arready);
assign fifo_push      = (awvalid & awready) | (arvalid & arready);
assign aw_b_fifo_pop  = (
                         (aw_b_fifo_qempty) &&

                         (wvalid & wready & wlast)) ? 1'b0 :
                         (wvalid & wready & wlast) | (rvalid & rready & rlast & (rid == axi_id_rd));

assign len_dec = (len > b_max_8) ? 1'b1 : 1'b0 ;


assign b_max_8 = {{(8-M_LEN_WIDTH){1'b0}},b_max[M_LEN_WIDTH-1:0]};




  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : WR_BEFORE_ADDR_R_PROC
    if `CDNSUSBHS_RESET(areset)
      wr_before_addr_r <= 1'b0;
    else

      if ((aw_b_fifo_qempty) &
          (awvalid & !awready) &
          (wvalid & wready & wlast))
      wr_before_addr_r <= 1'b1;
      else if (awready)
      wr_before_addr_r <= 1'b0;
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : LEN_R_PROC
    if `CDNSUSBHS_RESET(areset)
      len_r <= {8{1'b0}};
    else
      if (fifo_push)
      len_r <= len - (b_max[M_LEN_WIDTH-1:0] + 1'b1);
      else if (!(arlocked | awlocked))
      len_r <= {8{1'b0}};
  end




cdnsusbhs_aximwrap_ot
#(
  .MAX_OT_WIDTH(WR_CMD_ADDR_WIDTH),
  .LAST_NOT_USED(32'd1),
  .AXI_OT_W(AXI_OT_W)
)
U_CDNSUSBHS_AXIMWRAP_OT_AW_B
(
  .aclk(aclk),
  .aresetn(areset),
  .max(wot),
  .axvalid(awvalid),
  .axready(awready),
  .xvalid(bxvalid),
  .xready(bready),
  .xlast(1'b1),
  .cnt(aw_b_cnt),
  .limit(aw_b_limit)
);

assign bxvalid = (bvalid) ? (bid == axi_id_wr) : 1'b0;
assign awlen_ot = (len_dec) ? b_max[M_LEN_WIDTH-1:0] : len[M_LEN_WIDTH-1:0];
assign wlast_ot = (b_max[M_LEN_WIDTH-1:0]=={M_LEN_WIDTH{1'b0}}) ? 1'b1 :
                  (aw_b_fifo_quot == wcnt) ? awlocked : 1'b0;

  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AWVALID_OT_PROC
    if `CDNSUSBHS_RESET(areset)
      awvalid_ot <= 1'b0;
    else
      if (awvalid & len_dec)
        awvalid_ot <= 1'b1;
      else if (awvalid & awready)
        awvalid_ot <= 1'b0;
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : WCNT_PROC
    if `CDNSUSBHS_RESET(areset)
      wcnt <= {AW_B_FIFO_WIDTH{1'b0}};
    else
      if (wvalid & wready)
      begin
        if (wlast)
          wcnt <= {AW_B_FIFO_WIDTH{1'b0}};
        else
          wcnt <= wcnt + 1'b1;
      end
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AW_B_LIMIT_PROC
    if `CDNSUSBHS_RESET(areset)
      aw_b_limit_r <= 1'b0;
    else
      aw_b_limit_r <= aw_b_limit;
  end





cdnsusbhs_aximwrap_ot
#(
  .MAX_OT_WIDTH(RD_CMD_ADDR_WIDTH),
  .LAST_NOT_USED(32'd0),
  .AXI_OT_W(AXI_OT_W)
)
U_CDNSUSBHS_AXIMWRAP_OT_AR
(
  .aclk(aclk),
  .aresetn(areset),
  .max(rot),
  .axvalid(arvalid),
  .axready(arready),
  .xvalid(rxvalid),
  .xready(rready),
  .xlast(rlast),
  .cnt(ar_cnt),
  .limit(ar_limit)
);

assign rxvalid = (rvalid) ? (rid == axi_id_rd) : 1'b0;
assign arlen_ot = (len_dec) ? b_max[M_LEN_WIDTH-1:0] : len[M_LEN_WIDTH-1:0];

  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : ARVALID_OT_PROC
    if `CDNSUSBHS_RESET(areset)
      arvalid_ot <= 1'b0;
    else
      if (arvalid & len_dec)
      arvalid_ot <= 1'b1;
      else if (arvalid & arready)
      arvalid_ot <= 1'b0;
  end


  `CDNSUSBHS_ALWAYS(aclk,areset)
  begin : AR_LIMIT_PROC
    if `CDNSUSBHS_RESET(areset)
      ar_limit_r <= 1'b0;
    else
      ar_limit_r <= ar_limit;
  end
`endif

  assign axi_idle = !(arlocked | awlocked |
`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
                      (aw_b_cnt != {(WR_CMD_ADDR_WIDTH+1){1'b0}}) |
`endif
                      single_write | single_read |
                      precise_write | precise_read);


  assign axi_derror =
                      (bready && bvalid && bresp == AXI_DECERR && bid == axi_id_wr) ? 1'b1 :

                      (rready && rvalid && rresp == AXI_DECERR && rid == axi_id_rd) ? 1'b1 :
                                                                                      1'b0;

  assign axi_serror = (bready && bvalid && bresp == AXI_SLVERR && bid == axi_id_wr) ? 1'b1 :

                      (rready && rvalid && rresp == AXI_SLVERR && rid == axi_id_rd) ? 1'b1 :

                                                                                      1'b0;

endmodule


