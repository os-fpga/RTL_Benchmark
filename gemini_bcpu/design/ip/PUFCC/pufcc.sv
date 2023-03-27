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
   parameter DMAFAW              = clog2(DMAFFD)        //DMA Fifo Addr Width
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

logic [ 9:0] pub_sr_adr ;
logic        pub_sr_ce_n;
logic        pub_sr_we_n;
logic [31:0] pub_sr_wd  ;
logic [31:0] pub_sr_rd  ;
logic [10:0] pkc_sr_adr ;
logic        pkc_sr_ce_n;
logic        pkc_sr_we_n;
logic [31:0] pkc_sr_wd  ;
logic [31:0] pkc_sr_rd  ;
logic [ 6:0] ka_sr_adr  ;
logic        ka_sr_ce_n ;
logic        ka_sr_we_n ;
logic [31:0] ka_sr_wd   ;
logic [31:0] ka_sr_rd   ;


pscc_top #(
   .DMADBW             (DMADBW             ),
   .DMAFFD             (DMAFFD             ),
   .PRIVATE_KEY_WIDTH  (PRIVATE_KEY_WIDTH  ),
   .SHARED_SECRET_WIDTH(SHARED_SECRET_WIDTH),
   .KWP_MAX_KSIZE      (KWP_MAX_KSIZE      ),
   .AES_SBOX_NUM       (AES_SBOX_NUM       ),
   .CHACHA_QR_NUM      (CHACHA_QR_NUM      ),
   .CHACHA_QR_CYCLE    (CHACHA_QR_CYCLE    ),
   .SUP_AES            (SUP_AES            ),
   .SUP_GCM            (SUP_GCM            ),
   .SUP_XTS            (SUP_XTS            ),
   .SUP_CCM            (SUP_CCM            ),
   .SUP_SP90A          (SUP_SP90A          ),
   .SUP_RFC8439        (SUP_RFC8439        ),
   .SUP_SHA2_256       (SUP_SHA2_256       ),
   .SUP_SHA2_512       (SUP_SHA2_512       ),
   .SUP_SM3            (SUP_SM3            ),
   .SUP_SM4            (SUP_SM4            ),
   .SUP_KBKDF          (SUP_KBKDF          ),
   .SUP_PBKDF          (SUP_PBKDF          ),
   .SUP_SM2ENC         (SUP_SM2ENC         ),
   .SUP_SGDMA          (SUP_SGDMA          ),
   .DPA_PKC            (DPA_PKC            ),
   .DPA_CIP            (DPA_CIP            ),
   .AUTOLD_SIZE        (AUTOLD_SIZE        ),
   .CLK_XTL_PERIOD     (CLK_XTL_PERIOD     )
) pscc_top_u (
   `ifdef               USE_PWR_PIN
   .VDD        (VDD        ),
   .VDD2       (VDD2       ),
   .VSS        (VSS        ),
   `endif
   .autold_vld (autold_vld ),
   .autold_bits(autold_bits),
   .intrpt     (intrpt     ),
   .paddr      (paddr      ),
   .pwrite     (pwrite     ),
   .psel       (psel       ),
   .penable    (penable    ),
   .pwdata     (pwdata     ),
   .prdata     (prdata     ),
   .pready     (pready     ),
   .pslverr    (pslverr    ),
   .awprot     (awprot     ),
   .awaddr     (awaddr     ),
   .awlen      (awlen      ),
   .awsize     (awsize     ),
   .awburst    (awburst    ),
   .awvalid    (awvalid    ),
   .awready    (awready    ),
   .wdata      (wdata      ),
   .wstrb      (wstrb      ),
   .wlast      (wlast      ),
   .wvalid     (wvalid     ),
   .wready     (wready     ),
   .bresp      (bresp      ),
   .bvalid     (bvalid     ),
   .bready     (bready     ),
   .arprot     (arprot     ),
   .araddr     (araddr     ),
   .arlen      (arlen      ),
   .arsize     (arsize     ),
   .arburst    (arburst    ),
   .arvalid    (arvalid    ),
   .arready    (arready    ),
   .rdata      (rdata      ),
   .rresp      (rresp      ),
   .rlast      (rlast      ),
   .rvalid     (rvalid     ),
   .rready     (rready     ),
   .kexp_key   (kexp_key   ),
   .kexp_size  (kexp_size  ),
   .kexp_idx   (kexp_idx   ),
   .kexp_vld   (kexp_vld   ),
   .kexp_rdy   (kexp_rdy   ),
   .pub_sr_adr (pub_sr_adr ),
   .pub_sr_ce_n(pub_sr_ce_n),
   .pub_sr_we_n(pub_sr_we_n),
   .pub_sr_wd  (pub_sr_wd  ),
   .pub_sr_rd  (pub_sr_rd  ),
   .pkc_sr_adr (pkc_sr_adr ),
   .pkc_sr_ce_n(pkc_sr_ce_n),
   .pkc_sr_we_n(pkc_sr_we_n),
   .pkc_sr_wd  (pkc_sr_wd  ),
   .pkc_sr_rd  (pkc_sr_rd  ),
   .ka_sr_adr  (ka_sr_adr  ),
   .ka_sr_ce_n (ka_sr_ce_n ),
   .ka_sr_we_n (ka_sr_we_n ),
   .ka_sr_wd   (ka_sr_wd   ),
   .ka_sr_rd   (ka_sr_rd   ),
   .rng_fre_en (rng_fre_en ),
   .rng_fre_sel(rng_fre_sel),
   .rng_fre_out(rng_fre_out),
   .scan_mode  (scan_mode  ),
   .scan_clk   (scan_clk   ),
   .clk_eng    (clk_eng    ),
   .clk_xtl    (clk_xtl    ),
   .rst_n      (rst_n      )
);

`ifndef               USE_PWR_PIN
   wire VDD;
   wire VSS;
`endif


   dti_sp_tm16fcll_576x32_4ww2xoe_m_shd pkc_public_mem (
      .VDD  (VDD        ),
      .VSS  (VSS        ),
      .DO   (pub_sr_rd  ),
      .A    (pub_sr_adr ),
      .DI   (pub_sr_wd  ),
      .CE_N (pub_sr_ce_n),
      .GWE_N(pub_sr_we_n),
      .OE_N (pub_sr_ce_n),
      .T_RWM(3'b011     ), // TO BE REVIEWED AND ADJUSTED !!!!!
      .T_DLY(3'b000     ), // TO BE REVIEWED AND ADJUSTED !!!!!
      .CLK  (clk_eng    )
   );

   dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd pkc_internal_mem (
      .VDD  (VDD        ),
      .VSS  (VSS        ),
      .DO   (pkc_sr_rd  ),
      .A    (pkc_sr_adr ),
      .DI   (pkc_sr_wd  ),
      .CE_N (pkc_sr_ce_n),
      .GWE_N(pkc_sr_we_n),
      .OE_N (pkc_sr_ce_n),
      .T_RWM(3'b011     ), // TO BE REVIEWED AND ADJUSTED !!!!!
      .T_DLY(3'b000     ), // TO BE REVIEWED AND ADJUSTED !!!!!
      .CLK  (clk_eng    )
   );    

   dti_sp_tm16fcll_122x32_4ww2xoe_m_shd ka_mem (
      .VDD  (VDD       ),
      .VSS  (VSS       ),
      .DO   (ka_sr_rd  ),
      .A    (ka_sr_adr ),
      .DI   (ka_sr_wd  ),
      .CE_N (ka_sr_ce_n),
      .GWE_N(ka_sr_we_n),
      .OE_N (ka_sr_ce_n),
      .T_RWM(3'b011    ), // TO BE REVIEWED AND ADJUSTED !!!!!
      .T_DLY(3'b000    ), // TO BE REVIEWED AND ADJUSTED !!!!!
      .CLK  (clk_eng   )
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