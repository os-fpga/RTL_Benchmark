module pscc_top_fpga #(
parameter            CLK_APB_SEL          = 0,     // 0, 1
parameter            CLK_DMA_SEL          = 0,     // 0, 1
parameter            DMAPTC               = 0,     // 0:AXI, 1:AHB
parameter            DMASRAM              = 1,     // 0:FlipFlop, 1:SRAM
parameter            DMADBW               = 32,    // 32, 64, 128
parameter            DMAFFD               = 256,   // 2^N, N>1
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

parameter            DPA_PKC              = 0,     // 0, 1
parameter            DPA_CIP              = 0,     // 0, 1

parameter            AUTOLD_SIZE          = 1,     // 1~32
parameter            CLK_XTL_PERIOD       = 50,    // 20~100

//auto para
parameter DMAFDW   = 2+(DMADBW/8)+DMADBW, //DMA Fifo Data Width
parameter DMAFAW   = clog2(DMAFFD)        //DMA Fifo Addr Width
)(
input                         osc0,
input                         osc1,
input                         osc2,
input                         osc3,

output   [ 9:0]               c0_addr,
output                        c0_ce_n,
output                        c0_we_n,
output   [31:0]               c0_din,
input    [31:0]               c0_dout,

output   [ 9:0]               c1_addr,
output                        c1_ce_n,
output                        c1_we_n,
output   [31:0]               c1_din,
input    [31:0]               c1_dout,

input                         VDD,
input                         VDD2,
input                         VSS,

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

input                         rng_fre_en,
input                         rng_fre_sel,
output                        rng_fre_out,

input                         scan_mode,
input                         scan_clk,

input                         clk_eng,
input                         clk_xtl,
input                         clk_apb,
input                         clk_dma,

input                         rst_n
);


wire                 rst_eng_n;
wire                 rst_xtl_n;
wire                 rst_osc_n;
wire                 rst_apb_n;
wire                 rst_dma_n;

wire                 pdet;
wire        [ 3:0]   pams;
wire        [ 1:0]   pam;
wire        [38:0]   ppa;
wire        [ 4:0]   paio;
wire        [31:0]   pdin;
wire        [31:0]   pdout;
wire        [15:0]   pdout_dummy;
wire                 pvprrdy;
wire                 pwe;
wire                 pprog;
wire                 pclk;
wire                 pce;
wire                 pdstb;
wire                 pldo;
wire                 penvdd2_vdd;
wire                 pen_osc;
wire                 penclk;
wire                 pclkout;
wire                 pclkin;

wire                 auth_req;
wire                 auth_ack;
wire                 auth_dat;
wire                 auth_set;
wire                 auth_cde;

wire                 rng_entropy;

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
   .clk              (pclkin)
);

////////////
//apb rstgen
wire                 clk_apb_ = (CLK_APB_SEL[0])? clk_apb: clk_eng;
pscc_rstgen          I_RSTGEN_3
(
   .rst_out_n        (rst_apb_n),
   .rst_n            (rst_n),
   .scan_mode        (scan_mode),
   .clk              (clk_apb_)
);

////////////
//dma rstgen
wire                 clk_dma_ = (CLK_DMA_SEL[0])? clk_dma: clk_eng;
pscc_rstgen          I_RSTGEN_4
(
   .rst_out_n        (rst_dma_n),
   .rst_n            (rst_n),
   .scan_mode        (scan_mode),
   .clk              (clk_dma_)
);


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
   
   .pdet             (pdet),
   .pams             (pams),
   .pam              (pam),
   .ppa              (ppa),
   .paio             (paio),
   .pdin             (pdin),
   .pdout            (pdout),
   .pdout_dummy      (pdout_dummy),
   .pvprrdy          (pvprrdy),
   .pwe              (pwe),
   .pprog            (pprog),
   .pclk             (pclk),
   .pce              (pce),
   .pdstb            (pdstb),
   .pldo             (pldo),
   .penvdd2_vdd      (penvdd2_vdd),
   .pen_osc          (pen_osc),
   .penclk           (penclk),
   .pclkout          (pclkout),
   .pclkin           (pclkin),
   
   .auth_req         (auth_req),
   .auth_ack         (auth_ack),
   .auth_dat         (auth_dat),
   .auth_set         (auth_set),
   .auth_cde         (auth_cde),
   
   .rng_entropy      (rng_entropy),
   .rng_fre_en       (rng_fre_en),
   .rng_fre_sel      (rng_fre_sel),
   .rng_fre_out      (rng_fre_out),

   .clk_eng          (clk_eng),
   .clk_xtl          (clk_xtl),
   .clk_apb          (clk_apb_),
   .clk_dma          (clk_dma_),

   .rst_eng_n        (rst_eng_n),
   .rst_xtl_n        (rst_xtl_n),
   .rst_osc_n        (rst_osc_n),
   .rst_apb_n        (rst_apb_n),
   .rst_dma_n        (rst_dma_n)
);

FPGA512X32Y2C1BR3    I_HMC
(
   .VDD2             (VDD2),
   .VDD              (VDD),
   .VSS              (VSS),
   .PENVDD2_VDD      (penvdd2_vdd),

   .PPA              (ppa),
   .PAIO             (paio),
   .PDIN             (pdin),
   .PDOUT            (pdout),
   .PDOUT_DUMMY      (pdout_dummy),
   .PVPRRDY          (pvprrdy),
   .PDET             (pdet),
   .PAMS             (pams),
   .PAM              (pam),
   .PWE              (pwe),
   .PPROG            (pprog),
   .PCLK             (pclk),
   .PCE              (pce),
   .PDSTB            (pdstb),
 //.PLDO             (pldo),
   .PENCLK           (penclk),
   .PCLKOUT          (pclkout),
   .PCLKIN           (pclkin),
   
   .PACREQ           (auth_req),
   .PACACK           (auth_ack),
   .PACDAT           (auth_dat),
   .PACSET           (auth_set),
   .PACCDE           (auth_cde),

   .PENFRE           ({5{pen_osc}}),
   .PFRE             ({NC,rng_entropy}),

   .c0_addr          (c0_addr),
   .c0_ce_n          (c0_ce_n),
   .c0_we_n          (c0_we_n),
   .c0_din           (c0_din),
   .c0_dout          (c0_dout),

   .c1_addr          (c1_addr),
   .c1_ce_n          (c1_ce_n),
   .c1_we_n          (c1_we_n),
   .c1_din           (c1_din),
   .c1_dout          (c1_dout),

   .osc0             (osc0),
   .osc1             (osc1),
   .osc2             (osc2),
   .osc3             (osc3),
   .clk              (clk_xtl),
   .rst_n            (rst_n)
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

