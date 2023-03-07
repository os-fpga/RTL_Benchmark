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


assign autold_vld = 'h0;
assign autold_bits = 'h0;

assign intrpt = 'h0;

assign prdata = 'h0;
assign pready = 'h0;
assign pslverr = 'h0;

`ifdef PSCC_DMA_AHB
assign hprot = 'h0;
assign hnonsec = 'h0;
assign htrans = 'h0;
assign haddr = 'h0;
assign hsize = 'h0;
assign hburst = 'h0;
assign hwrite = 'h0;
assign hwdata = 'h0;
`else //PSCC_DMA_AXI
assign awprot = 'h0;
assign awaddr = 'h0;
assign awlen = 'h0;
assign awsize = 'h0;
assign awburst = 'h0;
assign awvalid = 'h0;
assign wdata = 'h0;
assign wstrb = 'h0;
assign wlast = 'h0;
assign wvalid = 'h0;
assign bready = 'h0;
assign arprot = 'h0;
assign araddr = 'h0;
assign arlen = 'h0;
assign arsize = 'h0;
assign arburst = 'h0;
assign arvalid = 'h0;
assign rready = 'h0;
`endif

assign kexp_key ='h0;
assign kexp_size ='h0;
assign kexp_idx ='h0;
assign kexp_vld ='h0;

assign pub_sr_adr ='h0; 
assign pub_sr_ce_n ='h0;
assign pub_sr_we_n ='h0;
assign pub_sr_wd ='h0;

assign pkc_sr_adr ='h0; 
assign pkc_sr_ce_n ='h0;
assign pkc_sr_we_n ='h0;
assign pkc_sr_wd ='h0;

assign ka_sr_adr ='h0; 
assign ka_sr_ce_n ='h0;
assign ka_sr_we_n ='h0;
assign ka_sr_wd ='h0;

`ifdef PSCC_DMA_SRAM
assign dma_rd_sr_we_n = 'h0;//clk_dma
assign dma_rd_sr_wa = 'h0;//clk_dma
assign dma_rd_sr_wd = 'h0;//clk_dma
assign dma_rd_sr_re_n = 'h0;//clk_eng
assign dma_rd_sr_ra = 'h0;//clk_eng

assign dma_wr_sr_we_n = 'h0;//clk_eng
assign dma_wr_sr_wa = 'h0;//clk_eng
assign dma_wr_sr_wd = 'h0;//clk_eng
assign dma_wr_sr_re_n = 'h0;//clk_dma
assign dma_wr_sr_ra = 'h0;//clk_dma
`endif

assign rng_fre_out = 'h0;

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