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
//   Filename:           cdnsusbhs_adma_sfr.v
//   Module Name:        cdnsusbhs_adma_sfr
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
//   Special Function Registers module
//   M.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"
`include "cdnsusbhs_adma_defines.v"

module cdnsusbhs_adma_sfr
(
  upclk,
  uprst,

  intreq,

  dma_upaddr,
  dma_uprd,
  dma_upwr,
  dma_upbe_wr,
  dma_upbe_rd,
  dma_upwdata,
  dma_uprdata,

  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  axi_b_max,
  axi_wot,
  axi_rot,
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
  axi_prot_rd,






  ocp_cfgrst,




  ocp_dtrans,


  ocp_dir,
  ocp_epno,


  ocp_traddr_read,
  ocp_traddr_read_ack,

  ocp_traddr_write,
  ocp_traddr_read_req,
  ocp_traddr_write_req,


  ocp_epdtrans_write,
  ocp_epdtrans_write_req,


  ocp_ep_cfg_write,

  ocp_epdtrans_read,
  ocp_ependian_read,

  ocp_enable_read,
  ocp_ependian_write,
  ocp_enable_write,


  ocp_eprst_ack,
  ocp_dflush_ack,
  ocp_drdy,
  ocp_eprst,
  ocp_dflush,



  ocp_isoerr,
  ocp_outsmm,
  ocp_ccs,

  ocp_trberr,
  ocp_inmis,
  ocp_outmis,
  ocp_descmis,
  ocp_insp,
  ocp_outsp,
  ocp_incmpl,
  ocp_outcmpl,
  ocp_dbusy,
  ocp_dbusy_2,


  ocp_isoerr_ack,
  ocp_outsmm_ack,
  ocp_trberr_ack,
  ocp_inmis_ack,
  ocp_outmis_ack,
  ocp_insp_ack,
  ocp_outsp_ack,
  ocp_incmpl_ack,
  ocp_outcmpl_ack,


  ocp_isoerr_en,
  ocp_outsmm_en,
  ocp_trberr_en,
  ocp_descmis_en,
  ocp_isoerr_en_ch,
  ocp_outsmm_en_ch,
  ocp_trberr_en_ch,
  ocp_descmis_en_ch,
  ep_sts_en_wr,


  ocp_drbl_ch,
  ocp_drbl,
  ocp_drbl_req,


  ocp_epists

);





  `include "cdnsusbhs_adma_params.v"






  input                              upclk;
  input                              uprst;



  output                             intreq;
  wire                               intreq;



  input  [SFR_ADDR_WIDTH-3:0]        dma_upaddr;
  input                              dma_uprd;
  input                              dma_upwr;
  input  [3:0]                       dma_upbe_rd;
  input  [3:0]                       dma_upbe_wr;
  input  [31:0]                      dma_upwdata;
  output [31:0]                      dma_uprdata;
  wire   [31:0]                      dma_uprdata;


  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  output [M_LEN_WIDTH-1:0]           axi_b_max;
  reg    [M_LEN_WIDTH-1:0]           axi_b_max;
  output [AXI_OT_W-1:0]              axi_wot;
  reg    [AXI_OT_W-1:0]              axi_wot;
  output [AXI_OT_W-1:0]              axi_rot;
  reg    [AXI_OT_W-1:0]              axi_rot;
  `endif

  input                              axi_idle;
  input                              axi_serror;
  input                              axi_derror;
  output [MAXI_ID_WIDTH-1:0]         axi_id_wr;
  reg    [MAXI_ID_WIDTH-1:0]         axi_id_wr;
  output [MAXI_ID_WIDTH-1:0]         axi_id_rd;
  reg    [MAXI_ID_WIDTH-1:0]         axi_id_rd;

  output [1:0]                       axi_lock_wr;
  wire   [1:0]                       axi_lock_wr;
  output [M_CACHE_WIDTH-1:0]         axi_cache_wr;
  wire   [M_CACHE_WIDTH-1:0]         axi_cache_wr;
  output [2:0]                       axi_prot_wr;
  wire   [2:0]                       axi_prot_wr;
  output [1:0]                       axi_lock_rd;
  wire   [1:0]                       axi_lock_rd;
  output [M_CACHE_WIDTH-1:0]         axi_cache_rd;
  wire   [M_CACHE_WIDTH-1:0]         axi_cache_rd;
  output [2:0]                       axi_prot_rd;
  wire   [2:0]                       axi_prot_rd;








  output                             ocp_cfgrst;
  reg                                ocp_cfgrst;


`ifdef CDNSUSBHS_SFR_SUPPORT_ENDIANESS_CONV

`else

`endif


  output                             ocp_dtrans;
  reg                                ocp_dtrans;


  output                             ocp_dir;
  reg                                ocp_dir;
  output [3:0]                       ocp_epno;
  reg    [3:0]                       ocp_epno;



  input  [31:0]                      ocp_traddr_read;
  input                              ocp_traddr_read_ack;

  output [31:0]                      ocp_traddr_write;
  reg    [31:0]                      ocp_traddr_write;
  output                             ocp_traddr_read_req;
  reg                                ocp_traddr_read_req;
  output                             ocp_traddr_write_req;
  reg                                ocp_traddr_write_req;


  input                              ocp_epdtrans_read;
  output                             ocp_epdtrans_write;
  reg                                ocp_epdtrans_write;
  output                             ocp_epdtrans_write_req;
  reg                                ocp_epdtrans_write_req;






  output                             ocp_ep_cfg_write;
  reg                                ocp_ep_cfg_write;
  input                              ocp_ependian_read;

  input                              ocp_enable_read;








  output                             ocp_ependian_write;
  `ifdef CDNSUSBHS_SUPPORT_ENDIANESS_CONV
  reg                                ocp_ependian_write;
  `else
  wire                               ocp_ependian_write;
  `endif


  output                             ocp_enable_write;
  reg                                ocp_enable_write;


  input                              ocp_eprst_ack;
  input                              ocp_dflush_ack;
  output                             ocp_drdy;
  reg                                ocp_drdy;
  output                             ocp_eprst;
  reg                                ocp_eprst;
  output                             ocp_dflush;
  reg                                ocp_dflush;



  input                              ocp_isoerr;
  input                              ocp_outsmm;
  input                       [31:0] ocp_ccs;

  input                              ocp_trberr;
  input                              ocp_inmis;
  input                              ocp_outmis;
  input                       [31:0] ocp_descmis;
  input                              ocp_insp;
  input                              ocp_outsp;
  input                              ocp_incmpl;
  input                              ocp_outcmpl;
  input                              ocp_dbusy;
  input                        [1:0] ocp_dbusy_2;

  output                             ocp_isoerr_ack;
  reg                                ocp_isoerr_ack;
  output                             ocp_outsmm_ack;
  reg                                ocp_outsmm_ack;
  output                             ocp_trberr_ack;
  reg                                ocp_trberr_ack;
  output                             ocp_inmis_ack;
  reg                                ocp_inmis_ack;
  output                             ocp_outmis_ack;
  reg                                ocp_outmis_ack;
  output                             ocp_insp_ack;
  reg                                ocp_insp_ack;
  output                             ocp_outsp_ack;
  reg                                ocp_outsp_ack;
  output                             ocp_incmpl_ack;
  reg                                ocp_incmpl_ack;
  output                             ocp_outcmpl_ack;
  reg                                ocp_outcmpl_ack;


  input                              ocp_isoerr_en;
  input                              ocp_outsmm_en;
  input                              ocp_trberr_en;
  input                              ocp_descmis_en;
  output                             ocp_isoerr_en_ch;
  reg                                ocp_isoerr_en_ch;
  output                             ocp_outsmm_en_ch;
  reg                                ocp_outsmm_en_ch;
  output                             ocp_trberr_en_ch;
  reg                                ocp_trberr_en_ch;
  output                             ocp_descmis_en_ch;
  reg                                ocp_descmis_en_ch;
  output                             ep_sts_en_wr;
  reg                                ep_sts_en_wr;


  input  [31:0]                      ocp_drbl_ch;
  output [31:0]                      ocp_drbl;
  wire   [31:0]                      ocp_drbl;
  reg    [31:0]                      ocp_drbl_c;
  output                             ocp_drbl_req;
  reg                                ocp_drbl_req;


  input  [31:0]                      ocp_epists;


  parameter SFR_USB_CONF_ADDR     = `CDNSUSBHS_SFR_ADDR_WIDTH'b0000000;
  parameter SFR_USB_STS_ADDR      = `CDNSUSBHS_SFR_ADDR_WIDTH'b0000100;





  parameter SFR_EP_SEL_ADDR       = `CDNSUSBHS_SFR_ADDR_WIDTH'b0011100;
  parameter SFR_EP_TRADDR_ADDR    = `CDNSUSBHS_SFR_ADDR_WIDTH'b0100000;
  parameter SFR_EP_CFG_ADDR       = `CDNSUSBHS_SFR_ADDR_WIDTH'b0100100;
  parameter SFR_EP_CMD_ADDR       = `CDNSUSBHS_SFR_ADDR_WIDTH'b0101000;
  parameter SFR_EP_STS_ADDR       = `CDNSUSBHS_SFR_ADDR_WIDTH'b0101100;

  parameter SFR_EP_STS_EN_ADDR    = `CDNSUSBHS_SFR_ADDR_WIDTH'b0110100;
  parameter SFR_DRBL_ADDR         = `CDNSUSBHS_SFR_ADDR_WIDTH'b0111000;
  parameter SFR_EP_IEN_ADDR       = `CDNSUSBHS_SFR_ADDR_WIDTH'b0111100;
  parameter SFR_EP_ISTS_ADDR      = `CDNSUSBHS_SFR_ADDR_WIDTH'b1000000;
  parameter SFR_AXI_CTRL_ADDR     = `CDNSUSBHS_SFR_ADDR_WIDTH'b1000100;
  parameter SFR_AXI_ID_ADDR       = `CDNSUSBHS_SFR_ADDR_WIDTH'b1001000;
  parameter SFR_AXI_CAP_ADDR      = `CDNSUSBHS_SFR_ADDR_WIDTH'b1010000;
  parameter SFR_AXI_CTRL0_ADDR    = `CDNSUSBHS_SFR_ADDR_WIDTH'b1011000;
  parameter SFR_AXI_CTRL1_ADDR    = `CDNSUSBHS_SFR_ADDR_WIDTH'b1011100;

  parameter SFR_USB_CONF_RSTV     = 32'h00000000;
  parameter SFR_USB_STS_RSTV      = 32'h03000000;
  parameter SFR_EP_SEL_RSTV       = 32'h00000000;
  parameter SFR_EP_TRADDR_RSTV    = 32'h00000000;
  parameter SFR_EP_CFG_RSTV       = 32'h00000000;
  parameter SFR_EP_CMD_RSTV       = 32'h00000000;
  parameter SFR_EP_STS_RSTV       = 32'h00000000;
  parameter SFR_EP_STS_EN_RSTV    = 32'h00000000;



  parameter SFR_EP_IEN_RSTV       = 32'h00010001;





  parameter SFR_AXI_CTRL_RSTV     = 32'h00000000;
  parameter SFR_AXI_ID_RSTV       = 32'h00000000;
  parameter SFR_AXI_CAP_RSTV      = 32'h00000000;







  `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
  wire  [32-1:0]                     axi_ctrl0;
  wire  [32-1:0]                     axi_ctrl1;
  reg   [M_LEN_WIDTH-1:0]            axi_b_max_r;
  reg   [AXI_OT_W-1:0]               axi_wot_r;
  reg   [AXI_OT_W-1:0]               axi_rot_r;
  `endif

  reg   [16-1:0]                     axi_id_wr_r;
  reg   [16-1:0]                     axi_id_rd_r;
  wire  [32-1:0]                     axi_id;

  reg   [32-1:0]                     axi_ctrl_r;
  wire  [32-1:0]                     axi_ctrl;
  wire  [32-1:0]                     axi_cap;
  reg                                axi_serror_r;
  reg                                axi_derror_r;
  reg                                axi_serroren_r;
  reg                                axi_derroren_r;




  wire   [SFR_ADDR_WIDTH-1:0]        maddr_s;
  wire   [OCP_BYTEEN_WIDTH-1:0]      mbyteen_s;
  wire   [OCP_DATA_WIDTH-1:0]        mdata_s;









  wire                               sfr_wr;

  wire                               sfr_rd;


  reg  [OCP_DATA_WIDTH-1:0]          sdata_s_r;



  reg  [OCP_DATA_WIDTH-1:0]          sdata;
  wire [OCP_DATA_WIDTH-1:0]          mdata;
  wire [OCP_BYTEEN_WIDTH-1:0]        mbyteen;




  wire [OCP_DATA_WIDTH-1:0]          usb_conf;


  wire                               ocp_cfgrst_ack;


  wire [OCP_DATA_WIDTH-1:0]          usb_sts;


  wire [OCP_DATA_WIDTH-1:0]          ep_sel;


  wire [OCP_DATA_WIDTH-1:0]          ep_traddr;


  wire [OCP_DATA_WIDTH-1:0]          ep_cfg;



  wire [OCP_DATA_WIDTH-1:0]          ep_cmd;




  wire [OCP_DATA_WIDTH-1:0]          ep_sts;



  wire [OCP_DATA_WIDTH-1:0]          ep_sts_en;






  wire [OCP_DATA_WIDTH-1:0]          ep_ien;
  reg  [OCP_DATA_WIDTH-1:0]          ep_ien_r;






  reg                                sflag_s_wait_r;
  reg                                sflag_s_r;









  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFLAG_S_WAIT_PROC
    if `CDNSUSBHS_RESET(uprst)
      sflag_s_wait_r           <= 1'b0;
    else
    begin
      if
      (
        (sfr_wr &
         (maddr_s == SFR_EP_STS_ADDR ||
          maddr_s == SFR_AXI_CAP_ADDR
            )) ||
        (sfr_wr & (maddr_s == SFR_USB_CONF_ADDR || maddr_s == SFR_EP_CMD_ADDR) & mbyteen[0] & mdata[0]) ||
        (((ocp_dir) ? ocp_inmis : ocp_outmis) & ocp_drdy) ||
        ((ocp_drbl & ocp_descmis) != {32{1'b0}})
      )
        sflag_s_wait_r         <= 1'b1;
      else
        sflag_s_wait_r         <= 1'b0;
    end
  end

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFLAG_S_PROC
    if `CDNSUSBHS_RESET(uprst)
      sflag_s_r                <= 1'b0;
    else
    begin
      if
      (
        (sfr_wr & (maddr_s == SFR_EP_STS_ADDR ||
                   maddr_s == SFR_AXI_CAP_ADDR

                   )) ||
        (((ocp_dir) ? ocp_inmis : ocp_outmis) & ocp_drdy) ||
        ((ocp_drbl & ocp_descmis) != {32{1'b0}})
      )
        sflag_s_r              <= 1'b0;
      else if
      (
        (
          ((ocp_epists & ep_ien) != {32{1'b0}}) ||
          ((axi_serror_r & axi_serroren_r) != 1'b0) ||
          ((axi_derror_r & axi_derroren_r) != 1'b0) ) &

         ~sflag_s_wait_r
      )
        sflag_s_r              <= 1'b1;
    end
  end


  assign intreq = sflag_s_r;


  assign   maddr_s = {dma_upaddr,2'b00};

  assign   mbyteen_s = (dma_upwr) ? dma_upbe_wr : dma_upbe_rd;

  assign   mdata_s = dma_upwdata;

  assign sfr_rd   = dma_uprd;

  assign sfr_wr   = dma_upwr;








  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SDATA_S_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      sdata_s_r                <= {OCP_DATA_WIDTH{1'b0}};
    else
    begin





          sdata_s_r            <= sdata;

    end
  end




  always
  @(
    axi_id or
    axi_cap or
    `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
    axi_ctrl0 or
    axi_ctrl1 or
    `endif
    axi_ctrl or
    maddr_s or
    usb_conf or
    usb_sts or
    ep_sel or
    ep_traddr or
    ep_cfg or
    ep_cmd or
    ep_sts or
    ep_sts_en or
    ocp_drbl or
    ep_ien or
    ocp_epists
  )
  begin : SDATA_S_COMB_PROC
    case(maddr_s)
      SFR_USB_CONF_ADDR  :
        sdata                  = usb_conf;

      SFR_USB_STS_ADDR   :
        sdata                  = usb_sts;

      SFR_EP_SEL_ADDR    :
        sdata                  = ep_sel;

      SFR_EP_TRADDR_ADDR :
        sdata                  = ep_traddr;

      SFR_EP_CFG_ADDR    :
        sdata                  = ep_cfg;

      SFR_EP_CMD_ADDR    :
        sdata                  = ep_cmd;

      SFR_EP_STS_ADDR    :
        sdata                  = ep_sts;

      SFR_EP_STS_EN_ADDR :
        sdata                  = ep_sts_en;

      SFR_DRBL_ADDR      :
        sdata                  = ocp_drbl;

      SFR_EP_IEN_ADDR    :
        sdata                  = ep_ien;

      SFR_EP_ISTS_ADDR   :
        sdata                  = ocp_epists;

      SFR_AXI_ID_ADDR    :
        sdata                  = axi_id;

      SFR_AXI_CTRL_ADDR  :
        sdata                  = axi_ctrl;

      SFR_AXI_CAP_ADDR   :
        sdata                  = axi_cap;

    `ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT
      SFR_AXI_CTRL0_ADDR :
        sdata                  = axi_ctrl0;

      SFR_AXI_CTRL1_ADDR :
        sdata                  = axi_ctrl1;
    `endif

      default :
        sdata                  = {OCP_DATA_WIDTH{1'b0}};

    endcase
  end


  assign   dma_uprdata = sdata_s_r;





  assign mdata = mdata_s;



  assign mbyteen = mbyteen_s;




















    `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : CFGRST_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_cfgrst                <= SFR_USB_CONF_RSTV[0];
    else
    begin
      if (sfr_wr & (maddr_s == SFR_USB_CONF_ADDR) & mbyteen[0] & mdata[0])
        ocp_cfgrst            <= 1'b1;
      else if(ocp_cfgrst_ack)
        ocp_cfgrst            <= 1'b0;
    end
  end




















  assign ocp_cfgrst_ack = ocp_cfgrst;







`ifdef CDNSUSBHS_SFR_SUPPORT_ENDIANESS_CONV













`else

`endif































  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DTRANS_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_dtrans               <= SFR_USB_STS_RSTV[3];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_USB_CONF_ADDR) & mbyteen[1] & (mdata[9] ^ mdata[8]))
        ocp_dtrans             <= mdata[9];
    end
  end







  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DIR_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_dir                  <= SFR_EP_SEL_RSTV[7];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_SEL_ADDR) & mbyteen[0])
        ocp_dir                <= mdata[7];
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPNO_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_epno                 <= SFR_EP_SEL_RSTV[3:0];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_SEL_ADDR) & mbyteen[0])
        ocp_epno               <= mdata[3:0];
    end
  end







  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_EP_TRADDR_WRITE_REQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_traddr_write_req     <= 1'b0;
    else
    begin
       if(sfr_wr &
              (maddr_s == SFR_EP_TRADDR_ADDR) & mbyteen[3])
        ocp_traddr_write_req   <= 1'b1;
      else
        ocp_traddr_write_req   <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_EP_TRADDR_READ_REQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_traddr_read_req      <= 1'b0;
    else
    begin
      if(ocp_traddr_read_ack)
        ocp_traddr_read_req    <= 1'b0;
      else if(sfr_rd &
              (maddr_s == SFR_EP_TRADDR_ADDR))
        ocp_traddr_read_req    <= 1'b1;
    end
  end

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_TRADDR_WRITE_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_traddr_write         <= SFR_EP_TRADDR_RSTV;
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_TRADDR_ADDR))
      begin
        if(mbyteen[3])
          ocp_traddr_write[31:24] <= mdata[31:24];
        if(mbyteen[2])
          ocp_traddr_write[23:16] <= mdata[23:16];
        if(mbyteen[1])
          ocp_traddr_write[15:8]  <= mdata[15:8];
        if(mbyteen[0])
          ocp_traddr_write[7:0]   <= mdata[7:0];
      end
    end
  end
























  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_EP_CFG_WRITE_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_ep_cfg_write         <= 1'b0;
    else
    begin
      if(sfr_wr &
                (maddr_s == SFR_EP_CFG_ADDR) & mbyteen[3])
        ocp_ep_cfg_write       <= 1'b1;
      else
        ocp_ep_cfg_write       <= 1'b0;
    end
  end





















  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPDTRANS_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      ocp_epdtrans_write               <= 1'b0;
      ocp_epdtrans_write_req           <= 1'b0;
      end
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_CFG_ADDR) & mbyteen[1] & (mdata[13] ^ mdata[12]))
        begin
        ocp_epdtrans_write     <= mdata[13];
        ocp_epdtrans_write_req <= 1'b1;
        end


      else
        begin
        ocp_epdtrans_write     <= ocp_epdtrans_read;
        ocp_epdtrans_write_req <= 1'b0;
        end
    end
  end

  `ifdef CDNSUSBHS_SUPPORT_ENDIANESS_CONV



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OCP_EPENDIAN_WRITE_PROC
      if `CDNSUSBHS_RESET(uprst)
        ocp_ependian_write     <= SFR_EP_CFG_RSTV[7];
      else
      begin
        if(sfr_wr & (maddr_s == SFR_EP_CFG_ADDR) & mbyteen[0])
          ocp_ependian_write   <= mdata[7];
      end
    end
  `else
    assign ocp_ependian_write    = 1'b0;
  `endif




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_ENABLE_WRITE_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_enable_write         <= SFR_EP_CFG_RSTV[0];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_CFG_ADDR) & mbyteen[0])
        ocp_enable_write       <= mdata[0];
    end
  end







  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EPRST_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_eprst                <= SFR_EP_CMD_RSTV[0];


    else
    begin
      if (ocp_eprst_ack)
        ocp_eprst              <= 1'b0;
      else if(sfr_wr &
              (maddr_s == SFR_EP_CMD_ADDR) & mbyteen[0] & mdata[0])
        ocp_eprst              <= 1'b1;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_DRDY_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_drdy                 <= SFR_EP_CMD_RSTV[6];


    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_CMD_ADDR) &
         mbyteen[0] & mdata[6])
        ocp_drdy               <= 1'b1;
      else
        ocp_drdy               <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : DFLUSH_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_dflush                <= SFR_EP_CMD_RSTV[7];


    else
    begin
      if (ocp_dflush_ack)
        ocp_dflush              <= 1'b0;
      else if(sfr_wr &
              (maddr_s == SFR_EP_CMD_ADDR) & mbyteen[0] & mdata[7])
        ocp_dflush              <= 1'b1;
    end
  end


















  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_ISOERR_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_isoerr_ack           <= SFR_EP_STS_RSTV[15];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[1] & mdata[15])
        ocp_isoerr_ack         <= 1'b1;
      else if(~ocp_isoerr)
        ocp_isoerr_ack         <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_OUTSMM_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_outsmm_ack           <= SFR_EP_STS_RSTV[14];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[1] & mdata[14])
        ocp_outsmm_ack         <= 1'b1;
      else if(~ocp_outsmm)
        ocp_outsmm_ack         <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_INSP_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_insp_ack             <= SFR_EP_STS_RSTV[3];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[0] & ocp_dir & mdata[3])
        ocp_insp_ack           <= 1'b1;
      else if(~ocp_insp)
        ocp_insp_ack           <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_OUTSP_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_outsp_ack            <= SFR_EP_STS_RSTV[3];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[0] & ~ocp_dir & mdata[3])
        ocp_outsp_ack          <= 1'b1;
      else if(~ocp_outsp)
        ocp_outsp_ack          <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_TRBERR_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_trberr_ack           <= SFR_EP_STS_RSTV[7];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[0] & mdata[7])
        ocp_trberr_ack         <= 1'b1;
      else if(~ocp_trberr)
        ocp_trberr_ack         <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_INMIS_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_inmis_ack            <= SFR_EP_STS_RSTV[4];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[0] & ocp_dir & mdata[4])
        ocp_inmis_ack          <= 1'b1;
      else if(~ocp_inmis)
        ocp_inmis_ack          <= 1'b0;
    end
  end




 `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_OUTMIS_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_outmis_ack           <= SFR_EP_STS_RSTV[4];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[0] & ~ocp_dir & mdata[4])
        ocp_outmis_ack         <= 1'b1;
      else if(~ocp_outmis)
        ocp_outmis_ack         <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_INCMPL_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_incmpl_ack           <= SFR_EP_STS_RSTV[2];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[0] & ocp_dir & mdata[2])
        ocp_incmpl_ack         <= 1'b1;
      else if(~ocp_incmpl)
        ocp_incmpl_ack         <= 1'b0;
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_OUTCMPL_ACK_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_outcmpl_ack          <= SFR_EP_STS_RSTV[2];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_ADDR) & mbyteen[0] & ~ocp_dir & mdata[2])
        ocp_outcmpl_ack        <= 1'b1;
      else if(~ocp_outcmpl)
        ocp_outcmpl_ack        <= 1'b0;
    end
  end







  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_DESCMIS_EN_CH_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_descmis_en_ch        <= SFR_EP_STS_EN_RSTV[4];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_EN_ADDR) & mbyteen[0])
        ocp_descmis_en_ch      <= mdata[4];
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_TRBERR_EN_CH_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_trberr_en_ch         <= SFR_EP_STS_EN_RSTV[7];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_EN_ADDR) & mbyteen[0])
        ocp_trberr_en_ch       <= mdata[7];
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_OUTSMM_EN_CH_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_outsmm_en_ch         <= SFR_EP_STS_EN_RSTV[14];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_EN_ADDR) & mbyteen[1])
        ocp_outsmm_en_ch       <= mdata[14];
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : OCP_ISOERR_EN_CH_PROC
    if `CDNSUSBHS_RESET(uprst)
      ocp_isoerr_en_ch         <= SFR_EP_STS_EN_RSTV[15];
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_EN_ADDR) & mbyteen[1])
        ocp_isoerr_en_ch       <= mdata[15];
    end
  end




  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EP_STS_EN_REQ_PROC
    if `CDNSUSBHS_RESET(uprst)
      ep_sts_en_wr             <= 1'b0;
    else
    begin
      if(sfr_wr & (maddr_s == SFR_EP_STS_EN_ADDR))
        ep_sts_en_wr           <= 1'b1;
      else
        ep_sts_en_wr           <= 1'b0;
    end
  end









  always
  @(
    maddr_s or

    sfr_wr
  )
  begin : OCP_DRBL_REQ_PROC




      ocp_drbl_req             = (sfr_wr & (maddr_s == SFR_DRBL_ADDR));
  end




  always
  @(
    maddr_s or
    mbyteen or
    mdata or
    ocp_drbl_ch or
    sfr_wr
  )
  begin : DRBL_COMB_PROC
    integer i;
    if(sfr_wr & (maddr_s == SFR_DRBL_ADDR) )
      for (i = 0; i < 32; i = i + 1)
        if( mbyteen[ i/8 ] )
          ocp_drbl_c[i]        = mdata[i] | ocp_drbl_ch[i];
        else
          ocp_drbl_c[i]        = ocp_drbl_ch[i];
    else
      ocp_drbl_c               = ocp_drbl_ch;
  end

  assign ocp_drbl = ocp_drbl_c & IMPLEMENT_EP;







  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : EP_IEN_PROC
    integer i;
    if `CDNSUSBHS_RESET(uprst)
      ep_ien_r                 <= SFR_EP_IEN_RSTV;
    else
    begin




      if(ocp_cfgrst)
        for (i = 0; i < 32; i = i + 1)
          if(i != 0 && i != 16)
            ep_ien_r[i]        <= SFR_EP_IEN_RSTV[i];
          else
            ep_ien_r[i]        <= ep_ien_r[i];
      else if(sfr_wr & (maddr_s == SFR_EP_IEN_ADDR) )
        for (i = 0; i < 32; i = i + 1)
          if( mbyteen[ i/8 ] )
            ep_ien_r[i]        <= mdata[i];
    end
  end

  assign ep_ien = ep_ien_r & IMPLEMENT_EP;




  assign usb_conf     =
    {
     {24{1'b0}},
      1'b0,
      1'b0,
      1'b0,
      1'b0,
      1'b0,
      1'b0,
      1'b0,
      1'b0
    };
  assign usb_sts      =
    {
      1'b0,
      1'b0,
     {6{1'b0}},
     {16{1'b0}},
      1'b0,
      3'b000,
      ocp_dtrans,
      1'b0,
      1'b0,
      1'b0
    };

  assign ep_sel       =
    {
     {24{1'b0}},
      ocp_dir,
      3'b000,
      ocp_epno
    };

  assign ep_traddr = ocp_traddr_read;

  assign ep_cfg       =
    {
      5'b00000,
     {11{1'b0}},
      2'b00,
      2'b00,
      4'b0000,
      ocp_ependian_read,
      1'b0,
      1'b0,
      1'b0,
      1'b0,
      2'b00,
      ocp_enable_read
    };

  assign ep_cmd       =
    {
     {24{1'b0}},
      ocp_dflush,
      ocp_drbl[{ocp_dir, ocp_epno}],
      2'b00,
      1'b0,
      1'b0,
      1'b0,
      ocp_eprst
    };

  assign ep_sts       =
    {
      ocp_epdtrans_read,
      2'b00,
      5'b00000,
      4'b0000,
      1'b0,
      ocp_dbusy_2,
      1'b0,
      ocp_isoerr,
      ocp_outsmm,
      1'b0,
      1'b0,
      ocp_ccs[{ocp_dir,ocp_epno}],
      1'b0,
      ocp_dbusy,
      1'b0,
      ocp_trberr,
      1'b0,
      1'b0,
      (ocp_inmis | ocp_outmis),
      (ocp_insp | ocp_outsp),
      (ocp_incmpl | ocp_outcmpl),
      1'b0,
      1'b0
    };

  assign ep_sts_en    =
    {
      12'h000,
      1'b0,
      3'b000,
      ocp_isoerr_en,
      ocp_outsmm_en,
      1'b0,
      1'b0,
      3'b000,
      1'b0,
      ocp_trberr_en,
      1'b0,
      1'b0,
      ocp_descmis_en,
      3'b000,
      1'b0
    };


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_ID_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_id_rd_r <= SFR_AXI_ID_RSTV[15:0];
      axi_id_wr_r <= SFR_AXI_ID_RSTV[15:0];
    end
    else
    begin
      if (sfr_wr & (maddr_s == SFR_AXI_ID_ADDR))
      begin
        if(mbyteen[3])
          axi_id_wr_r[15:8] <= mdata[31:24];
        if(mbyteen[2])
          axi_id_wr_r[7:0]  <= mdata[23:16];
        if(mbyteen[1])
          axi_id_rd_r[15:8] <= mdata[15:8];
        if(mbyteen[0])
          axi_id_rd_r[7:0]  <= mdata[7:0];
      end
    end
  end


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : AXI_ID_IDLE_REG_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_id_rd <= SFR_AXI_ID_RSTV[MAXI_ID_WIDTH-1:0];
      axi_id_wr <= SFR_AXI_ID_RSTV[MAXI_ID_WIDTH-1:0];
    end
    else
    begin
      if (axi_idle)
      begin
        axi_id_wr <= axi_id_wr_r[MAXI_ID_WIDTH-1:0];
        axi_id_rd <= axi_id_rd_r[MAXI_ID_WIDTH-1:0];
      end
    end
  end

  assign axi_id = {
                   {(16-MAXI_ID_WIDTH){1'b0}}, axi_id_wr,
                   {(16-MAXI_ID_WIDTH){1'b0}}, axi_id_rd
                  };


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_CTRL_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_ctrl_r <= SFR_AXI_CTRL_RSTV;
    end
    else
    begin
      if(sfr_wr & (maddr_s == SFR_AXI_CTRL_ADDR))
      begin
        if(mbyteen[3])
          axi_ctrl_r[31:24] <= mdata[31:24];
        if(mbyteen[2])
          axi_ctrl_r[23:16]  <= mdata[23:16];
        if(mbyteen[1])
          axi_ctrl_r[15:8]  <= mdata[15:8];
        if(mbyteen[0])
          axi_ctrl_r[7:0]   <= mdata[7:0];
      end
    end
  end

  assign axi_lock_wr  = axi_ctrl_r[25:24];
  assign axi_cache_wr = axi_ctrl_r[M_CACHE_WIDTH+19:20];
  assign axi_prot_wr  = axi_ctrl_r[18:16];
  assign axi_lock_rd  = axi_ctrl_r[9:8];
  assign axi_cache_rd = axi_ctrl_r[M_CACHE_WIDTH+3:4];
  assign axi_prot_rd  = axi_ctrl_r[2:0];

  assign axi_ctrl = {
                     {(8-2){1'b0}}, axi_lock_wr, {axi_cache_wr,1'b0,axi_prot_wr},
                     {(8-2){1'b0}}, axi_lock_rd, {axi_cache_rd,1'b0,axi_prot_rd}
                    };


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_SLERROR_R_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_serror_r <= SFR_AXI_CAP_RSTV[29];
    end
    else
    begin
      if (axi_serror)
        begin
          axi_serror_r <= 1'b1;
        end
      else if (sfr_wr & (maddr_s == SFR_AXI_CAP_ADDR) &
               mbyteen[3] & mdata[29])
        begin
          axi_serror_r <= 1'b0;
        end
    end
  end


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_DECERROR_R_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_derror_r <= SFR_AXI_CAP_RSTV[28];
    end
    else
    begin
      if (axi_derror)
      begin
        axi_derror_r <= 1'b1;
      end
      else if (sfr_wr & (maddr_s == SFR_AXI_CAP_ADDR) &
               mbyteen[3] & mdata[28])
      begin
        axi_derror_r <= 1'b0;
      end
    end
  end


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_ERROREN_R_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_serroren_r <= SFR_AXI_CAP_RSTV[21];
      axi_derroren_r <= SFR_AXI_CAP_RSTV[20];
    end
    else
    begin
      if (sfr_wr & (maddr_s == SFR_AXI_CAP_ADDR))
      begin
        if (mbyteen[2])
        begin
          axi_serroren_r <= mdata[21];
          axi_derroren_r <= mdata[20];
        end
      end
    end
  end


  assign axi_cap = {
                    1'b0,
                    axi_idle,
                    axi_serror_r,
                    axi_derror_r,
                     {(6){1'b0}},
                    axi_serroren_r,
                    axi_derroren_r,
                     {(20){1'b0}}
                   };

`ifdef CDNSUSBHS_AXI_MASTER_WRAPPER_OT_SUPPORT

  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_B_MAX_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_b_max_r <= AXI_BMAX_RST_VALUE[M_LEN_WIDTH-1:0];
    end
    else
    begin
      if (sfr_wr & (maddr_s == SFR_AXI_CTRL0_ADDR))
      begin
        if (mbyteen[0])
        begin
          if (mdata[M_LEN_WIDTH-1:0] > AXI_BMAX_RST_VALUE[M_LEN_WIDTH-1:0])
          begin
            axi_b_max_r <= AXI_BMAX_RST_VALUE[M_LEN_WIDTH-1:0];
          end
          else
          begin
            axi_b_max_r <= mdata[M_LEN_WIDTH-1:0];
          end
        end
      end
    end
  end


  assign axi_ctrl0 = {
                      {(32-M_LEN_WIDTH){1'b0}}, axi_b_max[M_LEN_WIDTH-1:0]
                     };


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_WOT_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_wot_r <= AXI_MAX_WR_OT;
    end
    else
    begin
      if (sfr_wr & (maddr_s == SFR_AXI_CTRL1_ADDR))
      begin
        if (mbyteen[0])
          begin
          if (mdata[AXI_OT_W-1:0] > AXI_MAX_WR_OT[AXI_OT_W-1:0])
          begin
            axi_wot_r <= AXI_MAX_WR_OT;
          end
          else
          begin
            axi_wot_r <= mdata[AXI_OT_W-1:0];
          end
        end
      end
    end
  end


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : SFR_AXI_ROT_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_rot_r <= AXI_MAX_RD_OT;
    end
    else
    begin
      if (sfr_wr & (maddr_s == SFR_AXI_CTRL1_ADDR))
      begin
        if (mbyteen[2])
        begin
          if (mdata[(16+AXI_OT_W-1):16] > AXI_MAX_RD_OT[AXI_OT_W-1:0])
          begin
            axi_rot_r <= AXI_MAX_RD_OT;
          end
          else
          begin
            axi_rot_r <= mdata[AXI_OT_W+16-1:16];
          end
        end
      end
    end
  end


  assign axi_ctrl1 = {
                      {(16-AXI_OT_W){1'b0}}, axi_wot,
                      {(16-AXI_OT_W){1'b0}}, axi_rot
                     };


  `CDNSUSBHS_ALWAYS(upclk,uprst)
  begin : AXI_IDLE_REG_PROC
    if `CDNSUSBHS_RESET(uprst)
    begin
      axi_b_max <= AXI_BMAX_RST_VALUE[M_LEN_WIDTH-1:0];
      axi_wot   <= AXI_MAX_WR_OT;
      axi_rot   <= AXI_MAX_RD_OT;
    end
    else
    begin
      if (axi_idle)
      begin
        axi_b_max <= axi_b_max_r;
        axi_wot   <= axi_wot_r;
        axi_rot   <= axi_rot_r;
      end
    end
  end
`endif

endmodule
