module pufcc #(
   parameter DMADBW              = 32                 , // 32, 64, 128
   parameter DMAFFD              = 4                  , // 2^N, N>1
   parameter PRIVATE_KEY_WIDTH   = 576                , // 256, 384,  576
   parameter SHARED_SECRET_WIDTH = 1152               , // 512, 768, 1152
   parameter KWP_MAX_KSIZE       = 640                , // 512, 640
   parameter AES_SBOX_NUM        = 16                 , // 1, 2, 4, 8, 16
   parameter CHACHA_QR_NUM       = 2                  , // 1, 2, 4
   parameter CHACHA_QR_CYCLE     = 2                  , // 1, 2, 4
   parameter SUP_AES             = 1                  , // 0, 1
   parameter SUP_GCM             = 1                  , // 0, 1
   parameter SUP_XTS             = 1                  , // 0, 1
   parameter SUP_CCM             = 1                  , // 0, 1
   parameter SUP_SP90A           = 1                  , // 0, 1
   parameter SUP_RFC8439         = 1                  , // 0, 1
   parameter SUP_SHA2_256        = 1                  , // 0, 1
   parameter SUP_SHA2_512        = 1                  , // 0, 1
   parameter SUP_SM3             = 1                  , // 0, 1
   parameter SUP_SM4             = 1                  , // 0, 1
   parameter SUP_KBKDF           = 1                  , // 0, 1
   parameter SUP_PBKDF           = 1                  , // 0, 1
   parameter SUP_SM2ENC          = 1                  , // 0, 1
   parameter SUP_SGDMA           = 1                  , // 0, 1
   parameter DPA_PKC             = 1                  , // 0, 1
   parameter DPA_CIP             = 1                  , // 0, 1
   parameter AUTOLD_SIZE         = 1                  , // 1~32
   parameter CLK_XTL_PERIOD      = 50                 , // 20~100
   //auto para
   parameter DMAFDW              = 2+(DMADBW/8)+DMADBW, //DMA Fifo Data Width
   parameter DMAFAW              = DMAFFD        //DMA Fifo Addr Width
) (
   `ifdef               USE_PWR_PIN
   input  wire                       VDD        ,
   input  wire                       VDD2       ,
   input  wire                       VSS        ,
   `endif
   output logic                       autold_vld ,
   output logic [AUTOLD_SIZE*256-1:0] autold_bits,
   output logic                       intrpt     ,
   input  logic [               14:0] paddr      ,
   input  logic                       pwrite     ,
   input  logic                       psel       ,
   input  logic                       penable    ,
   input  logic [               31:0] pwdata     ,
   output logic [               31:0] prdata     ,
   output logic                       pready     ,
   output logic                       pslverr    ,
   output logic [              3-1:0] awprot     ,
   output logic [             32-1:0] awaddr     ,
   output logic [              8-1:0] awlen      ,
   output logic [              3-1:0] awsize     ,
   output logic [              2-1:0] awburst    ,
   output logic                       awvalid    ,
   input  logic                       awready    ,
   output logic [         DMADBW-1:0] wdata      ,
   output logic [       DMADBW/8-1:0] wstrb      ,
   output logic                       wlast      ,
   output logic                       wvalid     ,
   input  logic                       wready     ,
   input  logic [              2-1:0] bresp      ,
   input  logic                       bvalid     ,
   output logic                       bready     ,
   output logic [              3-1:0] arprot     ,
   output logic [             32-1:0] araddr     ,
   output logic [              8-1:0] arlen      ,
   output logic [              3-1:0] arsize     ,
   output logic [              2-1:0] arburst    ,
   output logic                       arvalid    ,
   input  logic                       arready    ,
   input  logic [         DMADBW-1:0] rdata      ,
   input  logic [              2-1:0] rresp      ,
   input  logic                       rlast      ,
   input  logic                       rvalid     ,
   output logic                       rready     ,
   output logic [              255:0] kexp_key   ,
   output logic                       kexp_size  ,
   output logic                       kexp_idx   ,
   output logic                       kexp_vld   ,
   input  logic                       kexp_rdy   ,
   input  logic                       rng_fre_en ,
   input  logic                       rng_fre_sel,
   output logic                       rng_fre_out,
   input  logic                       scan_mode  ,
   input  logic                       scan_clk   ,
   input  logic                       clk_eng    ,
   input  logic                       clk_xtl    ,
   input  logic                       rst_n
);

   /*output logic                       */assign autold_vld ='d0;
   /*output logic [AUTOLD_SIZE*256-1:0] */assign autold_bits='d0;
   /*output logic                       */assign intrpt     ='d0;
   /*output logic [               31:0] */assign prdata     ='d0;
   /*output logic                       */assign pready     ='d0;
   /*output logic                       */assign pslverr    ='d0;
   /*output logic [              3-1:0] */assign awprot     ='d0;
   /*output logic [             32-1:0] */assign awaddr     ='d0;
   /*output logic [              8-1:0] */assign awlen      ='d0;
   /*output logic [              3-1:0] */assign awsize     ='d0;
   /*output logic [              2-1:0] */assign awburst    ='d0;
   /*output logic                       */assign awvalid    ='d0;
   /*output logic [         DMADBW-1:0] */assign wdata      ='d0;
   /*output logic [       DMADBW/8-1:0] */assign wstrb      ='d0;
   /*output logic                       */assign wlast      ='d0;
   /*output logic                       */assign wvalid     ='d0;
   /*output logic                       */assign bready     ='d0;
   /*output logic [              3-1:0] */assign arprot     ='d0;
   /*output logic [             32-1:0] */assign araddr     ='d0;
   /*output logic [              8-1:0] */assign arlen      ='d0;
   /*output logic [              3-1:0] */assign arsize     ='d0;
   /*output logic [              2-1:0] */assign arburst    ='d0;
   /*output logic                       */assign arvalid    ='d0;
   /*output logic                       */assign rready     ='d0;
   /*output logic [              255:0] */assign kexp_key   ='d0;
   /*output logic                       */assign kexp_size  ='d0;
   /*output logic                       */assign kexp_idx   ='d0;
   /*output logic                       */assign kexp_vld   ='d0;
   /*output logic                       */assign rng_fre_out='d0;

endmodule 
