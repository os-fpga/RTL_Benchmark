//***************************************************************************************
//*  STATEMENT OF USE
//*  CONFIDENTIAL AND PROPRIETARY SOFTWARE/DATA OF PUFsecurity Technology Inc.
//*  Copyright (c) 2022 PUFsecurity Technology Inc. All Rights Reserved.
//*
//*  This information contains confidential and proprietary information of PUFsecurity.
//*  No part of this information may be reproduced, transmitted, transcribed,
//*  stored in a retrieval system, or translated into any human or computer
//*  language, in any form or by any means, electronic, mechanical, magnetic,
//*  optical, chemical, manual, or otherwise, without the prior written permission
//*  of PUFsecurity.  This information was prepared for informational purpose and is for
//*  use by PUFsecurity's customers only.  PUFsecurity reserves the right to make changes
//*  in the information at any time and without notice.
//***************************************************************************************
//*
//*  REVISION HISTORY: 
//*  v1.0    2022/06/24    Initial release
//*
//***************************************************************************************

module pscc_top #(
parameter            DMADBW               = 32,    // 32, 64, 128
parameter            DMAFFD               = 4,     // 2^N, N>1
parameter            PRIVATE_KEY_WIDTH    = 576,   // 256, 384,  576
parameter            SHARED_SECRET_WIDTH  = 1152,  // 512, 768, 1152
parameter            KWP_MAX_KSIZE        = 640,   // 512, 640
parameter            AES_SBOX_NUM         = 16,    // 1, 2, 4, 8, 16
parameter            CHACHA_QR_NUM        = 2,     // 1, 2, 4
parameter            CHACHA_QR_CYCLE      = 2,     // 1, 2, 4

parameter            SUP_AES              = 1,     // 0, 1
parameter            SUP_GCM              = 1,     // 0, 1
parameter            SUP_XTS              = 1,     // 0, 1
parameter            SUP_CCM              = 1,     // 0, 1
parameter            SUP_SP90A            = 1,     // 0, 1

parameter            SUP_RFC8439          = 1,     // 0, 1

parameter            SUP_SHA2_256         = 1,     // 0, 1
parameter            SUP_SHA2_512         = 1,     // 0, 1

parameter            SUP_SM3              = 1,     // 0, 1
parameter            SUP_SM4              = 1,     // 0, 1

parameter            SUP_KBKDF            = 1,     // 0, 1
parameter            SUP_PBKDF            = 1,     // 0, 1
parameter            SUP_SM2ENC           = 1,     // 0, 1

parameter            SUP_SGDMA            = 1,     // 0, 1

parameter            DPA_PKC              = 1,     // 0, 1
parameter            DPA_CIP              = 1,     // 0, 1

parameter            AUTOLD_SIZE          = 1,     // 1~32
parameter            CLK_XTL_PERIOD       = 50,    // 20~100

//auto para
parameter DMAFDW   = 2+(DMADBW/8)+DMADBW, //DMA Fifo Data Width
parameter DMAFAW   = clog2(DMAFFD)        //DMA Fifo Addr Width
)(
`ifdef               USE_PWR_PIN
input                         VDD,
input                         VDD2,
input                         VSS,
`endif

output                        autold_vld,
output  [AUTOLD_SIZE*256-1:0] autold_bits,

output                        intrpt,

input    [14:0]               paddr,
input                         pwrite,
input                         psel,
input                         penable,
input    [31:0]               pwdata,
output   [31:0]               prdata,
output                        pready,
output                        pslverr,

`ifdef PSCC_DMA_AHB
output [7        -1:0]        hprot  ,
output                        hnonsec,
output [2        -1:0]        htrans ,
output [32       -1:0]        haddr  ,
output [3        -1:0]        hsize  ,
output [3        -1:0]        hburst ,
output                        hwrite ,
output [DMADBW   -1:0]        hwdata ,
input  [DMADBW   -1:0]        hrdata ,
input                         hready ,
input                         hresp  ,
`else //PSCC_DMA_AXI
output [3        -1:0]        awprot ,
output [32       -1:0]        awaddr ,
output [8        -1:0]        awlen  ,
output [3        -1:0]        awsize ,
output [2        -1:0]        awburst,
output                        awvalid,
input                         awready,
output [DMADBW   -1:0]        wdata  ,
output [DMADBW/8 -1:0]        wstrb  ,
output                        wlast  ,
output                        wvalid ,
input                         wready ,
input  [2        -1:0]        bresp  ,
input                         bvalid ,
output                        bready ,
output [3        -1:0]        arprot ,
output [32       -1:0]        araddr ,
output [8        -1:0]        arlen  ,
output [3        -1:0]        arsize ,
output [2        -1:0]        arburst,
output                        arvalid,
input                         arready,
input  [DMADBW   -1:0]        rdata  ,
input  [2        -1:0]        rresp  , 
input                         rlast  ,
input                         rvalid ,
output                        rready ,
`endif

output   [255:0]              kexp_key,
output                        kexp_size,
output                        kexp_idx,
output                        kexp_vld,
input                         kexp_rdy,

output   [ 9:0]               pub_sr_adr, 
output                        pub_sr_ce_n,
output                        pub_sr_we_n,
output   [31:0]               pub_sr_wd,
input    [31:0]               pub_sr_rd,

output   [10:0]               pkc_sr_adr, 
output                        pkc_sr_ce_n,
output                        pkc_sr_we_n,
output   [31:0]               pkc_sr_wd,
input    [31:0]               pkc_sr_rd,

output   [ 6:0]               ka_sr_adr, 
output                        ka_sr_ce_n,
output                        ka_sr_we_n,
output   [31:0]               ka_sr_wd,
input    [31:0]               ka_sr_rd,

`ifdef PSCC_DMA_SRAM
output                        dma_rd_sr_we_n,//clk_dma
output   [DMAFAW-1:0]         dma_rd_sr_wa  ,//clk_dma
output   [DMAFDW-1:0]         dma_rd_sr_wd  ,//clk_dma
output                        dma_rd_sr_re_n,//clk_eng
output   [DMAFAW-1:0]         dma_rd_sr_ra  ,//clk_eng
input    [DMAFDW-1:0]         dma_rd_sr_rd  ,//clk_eng
                
output                        dma_wr_sr_we_n,//clk_eng
output   [DMAFAW-1:0]         dma_wr_sr_wa  ,//clk_eng
output   [DMAFDW-1:0]         dma_wr_sr_wd  ,//clk_eng
output                        dma_wr_sr_re_n,//clk_dma
output   [DMAFAW-1:0]         dma_wr_sr_ra  ,//clk_dma
input    [DMAFDW-1:0]         dma_wr_sr_rd  ,//clk_dma
`endif

input                         rng_fre_en,
input                         rng_fre_sel,
output                        rng_fre_out,

input                         scan_mode,
input                         scan_clk,

input                         clk_eng,
input                         clk_xtl,
`ifdef PSCC_APB_CLK
input                         clk_apb,
`endif
`ifdef PSCC_DMA_CLK
input                         clk_dma,
`endif

input                         rst_n
);


wire                 rst_eng_n;
wire                 rst_xtl_n;
wire                 rst_osc_n;
wire                 rst_apb_n;
wire                 rst_dma_n;


wire                 rtl_pdet;
wire        [ 1:0]   rtl_pam;
wire        [ 3:0]   rtl_pams;
wire        [38:0]   rtl_ppa;
wire        [ 4:0]   rtl_paio;
wire        [31:0]   rtl_pdin;
wire        [31:0]   rtl_pdout;
wire        [15:0]   rtl_pdout_dummy;
wire                 rtl_pvprrdy;
wire                 rtl_pwe;
wire                 rtl_pprog;
wire                 rtl_pclk;
wire                 rtl_pce;
wire                 rtl_pdstb;
wire                 rtl_pldo;
wire                 rtl_pen_osc;
wire                 rtl_penclk;
wire                 rtl_pclkout;
wire                 rtl_pclkin;
wire                 rtl_penvdd2_vdd;

wire                 rtl_auth_req;
wire                 rtl_auth_ack;
wire                 rtl_auth_dat;
wire                 rtl_auth_set;
wire                 rtl_auth_cde;

wire                 rtl_rng_entropy;

wire                 hmc_pdet;
wire        [ 1:0]   hmc_pam;
wire        [ 3:0]   hmc_pams;
wire        [38:0]   hmc_ppa;
wire        [ 4:0]   hmc_paio;
wire        [31:0]   hmc_pdin;
wire        [31:0]   hmc_pdout;
wire        [15:0]   hmc_pdout_dummy;
wire                 hmc_pvprrdy;
wire                 hmc_pwe;
wire                 hmc_pprog;
wire                 hmc_pclk;
wire                 hmc_pce;
wire                 hmc_pdstb;
wire                 hmc_pldo;
wire                 hmc_pen_osc;
wire                 hmc_penclk;
wire                 hmc_pclkout;
wire                 hmc_pclkin;
wire                 hmc_penvdd2_vdd;

wire                 hmc_auth_req;
wire                 hmc_auth_ack;
wire                 hmc_auth_dat;
wire                 hmc_auth_set;
wire                 hmc_auth_cde;

wire                 hmc_rng_entropy;

wire                 hbusreq;
wire                 hgrant = 1'b1;
wire        [ 2:0]   NC;


////////////
//eng rstgen
pscc_rstgen          I_RSTGEN_0
(
   .rst_out_n        (rst_eng_n),
   .rst_n            (rst_n),
   .scan_mode        (scan_mode),
   .clk              (clk_eng)
);

////////////
//xtl rstgen
pscc_rstgen          I_RSTGEN_1
(
   .rst_out_n        (rst_xtl_n),
   .rst_n            (rst_n),
   .scan_mode        (scan_mode),
   .clk              (clk_xtl)
);

////////////
//osc rstgen
pscc_rstgen          I_RSTGEN_2
(
   .rst_out_n        (rst_osc_n),
   .rst_n            (rst_n),
   .scan_mode        (scan_mode),
   .clk              (rtl_pclkin)
);

////////////
//apb rstgen
`ifdef PSCC_APB_CLK
localparam CLK_APB_SEL = 1;
pscc_rstgen          I_RSTGEN_3
(
   .rst_out_n        (rst_apb_n),
   .rst_n            (rst_n),
   .scan_mode        (scan_mode),
   .clk              (clk_apb)
);
`else
localparam CLK_APB_SEL = 0;
wire   clk_apb   = clk_eng  ;
assign rst_apb_n = rst_eng_n;
`endif

////////////
//dma rstgen
`ifdef PSCC_DMA_CLK
localparam CLK_DMA_SEL = 1;
pscc_rstgen          I_RSTGEN_4
(
   .rst_out_n        (rst_dma_n),
   .rst_n            (rst_n),
   .scan_mode        (scan_mode),
   .clk              (clk_dma)
);
`else
localparam CLK_DMA_SEL = 0;
wire   clk_dma   = clk_eng;
assign rst_dma_n = rst_eng_n;
`endif


`ifdef PSCC_DMA_AHB                                      
localparam DMAPTC = 1;                                  //set DMA to AHB
wire  [3        -1:0]        awprot                   ; //tie AXI dummy port
wire  [32       -1:0]        awaddr                   ; //tie AXI dummy port
wire  [8        -1:0]        awlen                    ; //tie AXI dummy port
wire  [3        -1:0]        awsize                   ; //tie AXI dummy port
wire  [2        -1:0]        awburst                  ; //tie AXI dummy port
wire                         awvalid                  ; //tie AXI dummy port
wire                         awready={         {1'b0}}; //tie AXI dummy port
wire  [DMADBW   -1:0]        wdata                    ; //tie AXI dummy port
wire  [DMADBW/8 -1:0]        wstrb                    ; //tie AXI dummy port
wire                         wlast                    ; //tie AXI dummy port
wire                         wvalid                   ; //tie AXI dummy port
wire                         wready ={         {1'b0}}; //tie AXI dummy port
wire  [2        -1:0]        bresp  ={2        {1'b0}}; //tie AXI dummy port
wire                         bvalid ={         {1'b0}}; //tie AXI dummy port
wire                         bready                   ; //tie AXI dummy port
wire  [3        -1:0]        arprot                   ; //tie AXI dummy port
wire  [32       -1:0]        araddr                   ; //tie AXI dummy port
wire  [8        -1:0]        arlen                    ; //tie AXI dummy port
wire  [3        -1:0]        arsize                   ; //tie AXI dummy port
wire  [2        -1:0]        arburst                  ; //tie AXI dummy port
wire                         arvalid                  ; //tie AXI dummy port
wire                         arready={         {1'b0}}; //tie AXI dummy port
wire  [DMADBW   -1:0]        rdata  ={DMADBW   {1'b0}}; //tie AXI dummy port
wire  [2        -1:0]        rresp  ={2        {1'b0}}; //tie AXI dummy port
wire                         rlast  ={         {1'b0}}; //tie AXI dummy port
wire                         rvalid ={         {1'b0}}; //tie AXI dummy port
wire                         rready                   ; //tie AXI dummy port
`else //PSCC_DMA_AXI
localparam DMAPTC = 0;                                  //set DMA to AXI
wire  [7        -1:0]        hprot                    ; //tie AHB dummy port
wire                         hnonsec                  ; //tie AHB dummy port
wire  [2        -1:0]        htrans                   ; //tie AHB dummy port
wire  [32       -1:0]        haddr                    ; //tie AHB dummy port
wire  [3        -1:0]        hsize                    ; //tie AHB dummy port
wire  [3        -1:0]        hburst                   ; //tie AHB dummy port
wire                         hwrite                   ; //tie AHB dummy port
wire  [DMADBW   -1:0]        hwdata                   ; //tie AHB dummy port
wire  [DMADBW   -1:0]        hrdata ={DMADBW   {1'b0}}; //tie AHB dummy port
wire                         hready ={         {1'b0}}; //tie AHB dummy port
wire                         hresp  ={         {1'b0}}; //tie AHB dummy port
`endif

`ifdef PSCC_DMA_SRAM
localparam DMASRAM = 1;
`else
localparam DMASRAM =0;
wire                         dma_rd_sr_we_n               ;//tie SRAM dummy port
wire  [DMAFAW   -1:0]        dma_rd_sr_wa                 ;//tie SRAM dummy port
wire  [DMAFDW   -1:0]        dma_rd_sr_wd                 ;//tie SRAM dummy port
wire                         dma_rd_sr_re_n               ;//tie SRAM dummy port
wire  [DMAFAW   -1:0]        dma_rd_sr_ra                 ;//tie SRAM dummy port
wire  [DMAFDW   -1:0]        dma_rd_sr_rd  ={DMAFDW{1'b0}};//tie SRAM dummy port
wire                         dma_wr_sr_we_n               ;//tie SRAM dummy port
wire  [DMAFAW   -1:0]        dma_wr_sr_wa                 ;//tie SRAM dummy port
wire  [DMAFDW   -1:0]        dma_wr_sr_wd                 ;//tie SRAM dummy port
wire                         dma_wr_sr_re_n               ;//tie SRAM dummy port
wire  [DMAFAW   -1:0]        dma_wr_sr_ra                 ;//tie SRAM dummy port
wire  [DMAFDW   -1:0]        dma_wr_sr_rd  ={DMAFDW{1'b0}};//tie SRAM dummy port
`endif

pscc_core#(
.CLK_APB_SEL         (CLK_APB_SEL),
.CLK_DMA_SEL         (CLK_DMA_SEL),
.DMAPTC              (DMAPTC),
.DMASRAM             (DMASRAM),
.DMADBW              (DMADBW),
.DMAFFD              (DMAFFD),

.PRIVATE_KEY_WIDTH   (PRIVATE_KEY_WIDTH),
.SHARED_SECRET_WIDTH (SHARED_SECRET_WIDTH),
.KWP_MAX_KSIZE       (KWP_MAX_KSIZE),
.AES_SBOX_NUM        (AES_SBOX_NUM),
.CHACHA_QR_NUM       (CHACHA_QR_NUM),
.CHACHA_QR_CYCLE     (CHACHA_QR_CYCLE),

.SUP_AES             (SUP_AES),
.SUP_GCM             (SUP_GCM),
.SUP_XTS             (SUP_XTS),
.SUP_CCM             (SUP_CCM),
.SUP_SP90A           (SUP_SP90A),

.SUP_RFC8439         (SUP_RFC8439),

.SUP_SHA2_256        (SUP_SHA2_256),
.SUP_SHA2_512        (SUP_SHA2_512),

.SUP_SM3             (SUP_SM3),
.SUP_SM4             (SUP_SM4),

.SUP_KBKDF           (SUP_KBKDF),
.SUP_PBKDF           (SUP_PBKDF),
.SUP_SM2ENC          (SUP_SM2ENC),

.SUP_SGDMA           (SUP_SGDMA),

.DPA_PKC             (DPA_PKC),
.DPA_CIP             (DPA_CIP),

.AUTOLD_BITSIZE      (AUTOLD_SIZE*256),
.CLK_XTL_PERIOD      (CLK_XTL_PERIOD)
)                    I_PSCC_CORE
(
   .autold_vld       (autold_vld),
   .autold_bits      (autold_bits),
   .intrpt           (intrpt),

   .paddr            (paddr),
   .pwrite           (pwrite),
   .psel             (psel),
   .penable          (penable),
   .pwdata           (pwdata),
   .prdata           (prdata),
   .pready           (pready),
   .pslverr          (pslverr),
   
   .hbusreq          (hbusreq),
   .hgrant           (hgrant ),
   .hprot            (hprot  ),
   .hnonsec          (hnonsec),
   .htrans           (htrans ),
   .haddr            (haddr  ),
   .hsize            (hsize  ),
   .hburst           (hburst ),
   .hwrite           (hwrite ),
   .hwdata           (hwdata ),
   .hrdata           (hrdata ),
   .hready           (hready ),
   .hresp      ({1'b0,hresp }),

   .awprot           (awprot ),
   .awsize           (awsize ),
   .awburst          (awburst),
   .awaddr           (awaddr ),
   .awlen            (awlen  ),
   .awvalid          (awvalid),
   .awready          (awready),
   .wdata            (wdata  ),
   .wstrb            (wstrb  ),
   .wlast            (wlast  ),
   .wvalid           (wvalid ),
   .wready           (wready ),
   .bresp            (bresp  ),
   .bvalid           (bvalid ),
   .bready           (bready ),
   .arprot           (arprot ),
   .arsize           (arsize ),
   .arburst          (arburst),
   .araddr           (araddr ),
   .arlen            (arlen  ),
   .arvalid          (arvalid),
   .arready          (arready),
   .rdata            (rdata  ),
   .rresp            (rresp  ), 
   .rlast            (rlast  ),
   .rvalid           (rvalid ),
   .rready           (rready ),
   
   .kexp_key         (kexp_key),
   .kexp_size        (kexp_size),
   .kexp_idx         (kexp_idx),
   .kexp_vld         (kexp_vld),
   .kexp_rdy         (kexp_rdy),
   
   .pub_sr_adr       (pub_sr_adr), 
   .pub_sr_ce_n      (pub_sr_ce_n),
   .pub_sr_we_n      (pub_sr_we_n),
   .pub_sr_wd        (pub_sr_wd),
   .pub_sr_rd        (pub_sr_rd),
   
   .pkc_sr_adr       (pkc_sr_adr), 
   .pkc_sr_ce_n      (pkc_sr_ce_n),
   .pkc_sr_we_n      (pkc_sr_we_n),
   .pkc_sr_wd        (pkc_sr_wd),
   .pkc_sr_rd        (pkc_sr_rd),
   
   .ka_sr_adr        (ka_sr_adr), 
   .ka_sr_ce_n       (ka_sr_ce_n),
   .ka_sr_we_n       (ka_sr_we_n),
   .ka_sr_wd         (ka_sr_wd),
   .ka_sr_rd         (ka_sr_rd),
   
   .dma_rd_sr_we_n   (dma_rd_sr_we_n),
   .dma_rd_sr_wa     (dma_rd_sr_wa),
   .dma_rd_sr_wd     (dma_rd_sr_wd),
   .dma_rd_sr_re_n   (dma_rd_sr_re_n),
   .dma_rd_sr_ra     (dma_rd_sr_ra),
   .dma_rd_sr_rd     (dma_rd_sr_rd),

   .dma_wr_sr_we_n   (dma_wr_sr_we_n),
   .dma_wr_sr_wa     (dma_wr_sr_wa),
   .dma_wr_sr_wd     (dma_wr_sr_wd),
   .dma_wr_sr_re_n   (dma_wr_sr_re_n),
   .dma_wr_sr_ra     (dma_wr_sr_ra),
   .dma_wr_sr_rd     (dma_wr_sr_rd),

   .pdet             (rtl_pdet),
   .pams             (rtl_pams),
   .pam              (rtl_pam),
   .ppa              (rtl_ppa),
   .paio             (rtl_paio),
   .pdin             (rtl_pdin),
   .pdout            (rtl_pdout),
   .pdout_dummy      (rtl_pdout_dummy),
   .pvprrdy          (rtl_pvprrdy),
   .pwe              (rtl_pwe),
   .pprog            (rtl_pprog),
   .pclk             (rtl_pclk),
   .pce              (rtl_pce),
   .pdstb            (rtl_pdstb),
   .pldo             (rtl_pldo),
   .penvdd2_vdd      (rtl_penvdd2_vdd),
   .pen_osc          (rtl_pen_osc),
   .penclk           (rtl_penclk),
   .pclkout          (rtl_pclkout),
   .pclkin           (rtl_pclkin),
   
   .auth_req         (rtl_auth_req),
   .auth_ack         (rtl_auth_ack),
   .auth_dat         (rtl_auth_dat),
   .auth_set         (rtl_auth_set),
   .auth_cde         (rtl_auth_cde),
   
   .rng_entropy      (rtl_rng_entropy),
   .rng_fre_en       (rng_fre_en),
   .rng_fre_sel      (rng_fre_sel),
   .rng_fre_out      (rng_fre_out),

   .clk_eng          (clk_eng),
   .clk_xtl          (clk_xtl),
   .clk_apb          (clk_apb),
   .clk_dma          (clk_dma),

   .rst_eng_n        (rst_eng_n),
   .rst_xtl_n        (rst_xtl_n),
   .rst_osc_n        (rst_osc_n),
   .rst_apb_n        (rst_apb_n),
   .rst_dma_n        (rst_dma_n)
);

`ifdef USE_SCAN_MUX
pscc_scan_mux        I_MUX
(
   .rtl_pam          (rtl_pam),
   .rtl_pams         (rtl_pams),
   .rtl_pdet         (rtl_pdet),

   .rtl_ppa          (rtl_ppa),
   .rtl_paio         (rtl_paio),
   .rtl_pdin         (rtl_pdin),
   .rtl_pdout        (rtl_pdout),
   .rtl_pdout_dummy  (rtl_pdout_dummy),
   .rtl_pvprrdy      (rtl_pvprrdy),
   .rtl_pwe          (rtl_pwe),
   .rtl_pprog        (rtl_pprog),
   .rtl_pclk         (rtl_pclk),
   .rtl_pce          (rtl_pce),
   .rtl_pdstb        (rtl_pdstb),
   .rtl_pldo         (rtl_pldo),
   .rtl_pen_osc      (rtl_pen_osc),
   .rtl_penclk       (rtl_penclk),
   .rtl_pclkout      (rtl_pclkout),
   .rtl_pclkin       (rtl_pclkin),
   .rtl_penvdd2_vdd  (rtl_penvdd2_vdd),

   .rtl_auth_req     (rtl_auth_req),
   .rtl_auth_ack     (rtl_auth_ack),
   .rtl_auth_dat     (rtl_auth_dat),
   .rtl_auth_set     (rtl_auth_set),
   .rtl_auth_cde     (rtl_auth_cde),

   .rtl_rng_entropy  (rtl_rng_entropy),

   .hmc_pam          (hmc_pam),
   .hmc_pams         (hmc_pams),
   .hmc_pdet         (hmc_pdet),

   .hmc_ppa          (hmc_ppa),
   .hmc_paio         (hmc_paio),
   .hmc_pdin         (hmc_pdin),
   .hmc_pdout        (hmc_pdout),
   .hmc_pdout_dummy  (hmc_pdout_dummy),
   .hmc_pvprrdy      (hmc_pvprrdy),
   .hmc_pwe          (hmc_pwe),
   .hmc_pprog        (hmc_pprog),
   .hmc_pclk         (hmc_pclk),
   .hmc_pce          (hmc_pce),
   .hmc_pdstb        (hmc_pdstb),
   .hmc_pldo         (hmc_pldo),
   .hmc_pen_osc      (hmc_pen_osc),
   .hmc_penclk       (hmc_penclk),
   .hmc_pclkout      (hmc_pclkout),
   .hmc_pclkin       (hmc_pclkin),
   .hmc_penvdd2_vdd  (hmc_penvdd2_vdd),

   .hmc_auth_req     (hmc_auth_req),
   .hmc_auth_ack     (hmc_auth_ack),
   .hmc_auth_dat     (hmc_auth_dat),
   .hmc_auth_set     (hmc_auth_set),
   .hmc_auth_cde     (hmc_auth_cde),

   .hmc_rng_entropy  (hmc_rng_entropy),

   .scan_clk         (scan_clk),
   .scan_mode        (scan_mode),
   .rst_n            (rst_n)
);
`else
assign rtl_pdout        = hmc_pdout;
assign rtl_pdout_dummy  = hmc_pdout_dummy;
assign rtl_pam          = hmc_pam;
assign rtl_pams         = hmc_pams;
assign rtl_pdet         = hmc_pdet;
assign rtl_pvprrdy      = hmc_pvprrdy;
assign rtl_auth_req     = hmc_auth_req;
assign rtl_auth_set     = hmc_auth_set;
assign rtl_auth_cde     = hmc_auth_cde;
assign rtl_rng_entropy  = hmc_rng_entropy;
assign rtl_pclkout      = hmc_pclkout;

assign hmc_ppa          = rtl_ppa;
assign hmc_paio         = rtl_paio;
assign hmc_pdin         = rtl_pdin;
assign hmc_pwe          = rtl_pwe;
assign hmc_pprog        = rtl_pprog;
assign hmc_pclk         = rtl_pclk;
assign hmc_pce          = rtl_pce;
assign hmc_pdstb        = rtl_pdstb;
assign hmc_pldo         = rtl_pldo;
assign hmc_pen_osc      = rtl_pen_osc;
assign hmc_penclk       = rtl_penclk;
assign hmc_pclkin       = rtl_pclkin;
assign hmc_auth_ack     = rtl_auth_ack;
assign hmc_auth_dat     = rtl_auth_dat;
assign hmc_penvdd2_vdd  = rtl_penvdd2_vdd;
`endif

EGP512X32UA016CW01   I_HMC
(
`ifdef               USE_PWR_PIN
   .VDD2             (VDD2),
   .VDD              (VDD),
   .VSS              (VSS),
`endif

   .PPA              (hmc_ppa),
   .PDET             (hmc_pdet),

   .PAIO             (hmc_paio),
   .PDIN             (hmc_pdin),
   .PDOUT            (hmc_pdout),
   .PDOUT_DUMMY      (hmc_pdout_dummy),
   .PWE              (hmc_pwe),
   .PPROG            (hmc_pprog),
   .PCE              (hmc_pce),
   .PDSTB            (hmc_pdstb),
   .PENVDD2_VDD      (hmc_penvdd2_vdd),
   .PAMS             (hmc_pams),
   .PAM              (hmc_pam),
   .PENCLK           (hmc_penclk),
   .PCLKOUT          (hmc_pclkout),
   .PVPRRDY          (hmc_pvprrdy),
   .PCLK             (hmc_pclk),
   .PCLKIN           (hmc_pclkin),

   .PACREQ           (hmc_auth_req),
   .PACACK           (hmc_auth_ack),
   .PACDAT           (hmc_auth_dat),
   .PACSET           (hmc_auth_set),
   .PACCDE           (hmc_auth_cde),

   .PENFRE           ({5{hmc_pen_osc}}),
   .PFRE             ({NC,hmc_rng_entropy})
);


   /* verilator lint_off VARHIDDEN */
   // pragma coverage off
   function integer clog2;
      input integer value;
      begin
         value = value - 1;
         for(clog2=0; value>0; clog2=clog2+1) begin
            value = value >> 1;
         end
      end
   endfunction
   // pragma coverage on
   /* verilator lint_on VARHIDDEN */
endmodule

