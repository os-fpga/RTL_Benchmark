//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2020 09:50:22 AM
// Design Name: 
// Module Name: pscc_top_fpga_wp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pscc_top_fpga_wp#(
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
parameter            CLK_XTL_PERIOD       = 50     // 20~100
)(
output                        autold_vld,
output  [AUTOLD_SIZE*256-1:0] autold_bits,

output               intrpt,

input       [14:0]   paddr,
input                pwrite,
input                psel,
input                penable,
input       [31:0]   pwdata,
output      [31:0]   prdata,
output               pready,
output               pslverr,

output     [7 -1:0]  hprot  ,
output     [2 -1:0]  htrans ,
output     [32-1:0]  haddr  ,
output     [3 -1:0]  hsize  ,
output     [3 -1:0]  hburst ,
output               hwrite ,
output [DMADBW-1:0]  hwdata ,
input  [DMADBW-1:0]  hrdata ,
input                hresp  ,
output               hsel      ,//pretend ahb bridge signal
input                hready_out,//pretend ahb bridge signal
output               hready_in ,//pretend ahb bridge signal

output      [ 2:0]   awprot,
output      [31:0]   awaddr,
output      [ 7:0]   awlen,
output      [ 2:0]   awsize,
output      [ 1:0]   awburst,
output               awvalid,
input                awready,
output[DMADBW-1:0]   wdata,
output[DMADBW/8-1:0] wstrb,
output               wlast,
output               wvalid,
input                wready,
input       [ 1:0]   bresp,
input                bvalid,
output               bready,
output      [ 2:0]   arprot,
output      [31:0]   araddr,
output      [ 7:0]   arlen,
output      [ 2:0]   arsize,
output      [ 1:0]   arburst,
output               arvalid,
input                arready,
input [DMADBW-1:0]   rdata,
input       [ 1:0]   rresp, 
input                rlast,
input                rvalid,
output               rready,

output     [255:0]   kexp_key,
output               kexp_size,
output               kexp_idx,
output               kexp_vld,
input                kexp_rdy,

input                clk_eng,
input                clk_xtl,
input                clk_apb,
input                clk_dma,

input                rst_n,

output               fpga_tie_h,
output               fpga_tie_l
);
wire               osc0;
wire               osc1;
wire               osc2;
wire               osc3;

wire      [ 9:0]   c0_addr;
wire               c0_ce_n;
wire               c0_we_n;
wire      [31:0]   c0_din;
wire      [31:0]   c0_dout;

wire      [ 9:0]   c1_addr;
wire               c1_ce_n;
wire               c1_we_n;
wire      [31:0]   c1_din;
wire      [31:0]   c1_dout;

wire               rng_fre_out;
    
wire      [ 9:0]   pub_sr_adr; 
wire               pub_sr_ce_n;
wire               pub_sr_we_n;
wire      [31:0]   pub_sr_wd;
wire      [31:0]   pub_sr_rd;
    
wire      [10:0]   pkc_sr_adr; 
wire               pkc_sr_ce_n;
wire               pkc_sr_we_n;
wire      [31:0]   pkc_sr_wd;
wire      [31:0]   pkc_sr_rd;
    
wire      [ 6:0]   ka_sr_adr; 
wire               ka_sr_ce_n;
wire               ka_sr_we_n;
wire      [31:0]   ka_sr_wd;
wire      [31:0]   ka_sr_rd;    

//auto para
localparam DMAFDW   = 2+(DMADBW/8)+DMADBW; //DMA Fifo Data Width
localparam DMAFAW   = clog2(DMAFFD)      ; //DMA Fifo Addr Width
wire                 dma_rd_sr_we_n;
wire  [DMAFAW-1:0]   dma_rd_sr_wa  ;
wire  [DMAFDW-1:0]   dma_rd_sr_wd  ;
wire                 dma_rd_sr_re_n;
wire  [DMAFAW-1:0]   dma_rd_sr_ra  ;
wire  [DMAFDW-1:0]   dma_rd_sr_rd  ;

wire                 dma_wr_sr_we_n;
wire  [DMAFAW-1:0]   dma_wr_sr_wa  ;
wire  [DMAFDW-1:0]   dma_wr_sr_wd  ;
wire                 dma_wr_sr_re_n;
wire  [DMAFAW-1:0]   dma_wr_sr_ra  ;
wire  [DMAFDW-1:0]   dma_wr_sr_rd  ;

wire   hnonsec               ;//no use in zynq7100
wire   hready    = hready_out;//pretend ahb bridge signal
assign hsel      = 1'b1      ;//pretend ahb bridge signal
assign hready_in = hready_out;//pretend ahb bridge signal


pscc_top_fpga#(
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

.AUTOLD_SIZE         (AUTOLD_SIZE),
.CLK_APB_SEL         (CLK_APB_SEL),
.CLK_DMA_SEL         (CLK_DMA_SEL),
.CLK_XTL_PERIOD      (CLK_XTL_PERIOD)
)   I_PSCC_TOP_FPGA
(
    .osc0(osc0),
    .osc1(osc1),
    .osc2(osc2),
    .osc3(osc3),
    
    .c0_addr(c0_addr),
    .c0_ce_n(c0_ce_n),
    .c0_we_n(c0_we_n),
    .c0_din(c0_din),
    .c0_dout(c0_dout),
    
    .c1_addr(c1_addr),
    .c1_ce_n(c1_ce_n),
    .c1_we_n(c1_we_n),
    .c1_din(c1_din),
    .c1_dout(c1_dout),
    
    .VDD(1'b1),
    .VDD2(1'b1),
    .VSS(1'b0),

    .autold_vld       (autold_vld),
    .autold_bits      (autold_bits),
    
    .intrpt(intrpt),
    
    .paddr(paddr),
    .pwrite(pwrite),
    .psel(psel),
    .penable(penable),
    .pwdata(pwdata),
    .prdata(prdata),
    .pready(pready),
    .pslverr(pslverr),
    
    .awprot(awprot),
    .awaddr(awaddr),
    .awlen(awlen),
    .awsize(awsize),
    .awburst(awburst),
    .awvalid(awvalid),
    .awready(awready),
    .wdata(wdata),
    .wstrb(wstrb),
    .wlast(wlast),
    .wvalid(wvalid),
    .wready(wready),
    .bresp(bresp),
    .bvalid(bvalid),
    .bready(bready),
    .arprot(arprot),
    .araddr(araddr),
    .arlen(arlen),
    .arsize(arsize),
    .arburst(arburst),
    .arvalid(arvalid),
    .arready(arready),
    .rdata(rdata),
    .rresp(rresp),
    .rlast(rlast),
    .rvalid(rvalid),
    .rready(rready),
   
    .hprot  (hprot  ),
    .hnonsec(hnonsec),
    .htrans (htrans ),
    .haddr  (haddr  ),
    .hsize  (hsize  ),
    .hburst (hburst ),
    .hwrite (hwrite ),
    .hwdata (hwdata ),
    .hrdata (hrdata ),
    .hready (hready ),
    .hresp  (hresp  ),

    .kexp_key(kexp_key ),
    .kexp_size(kexp_size),
    .kexp_idx(kexp_idx ),
    .kexp_vld(kexp_vld ),
    .kexp_rdy(kexp_rdy ),      

    .pub_sr_adr(pub_sr_adr), 
    .pub_sr_ce_n(pub_sr_ce_n),
    .pub_sr_we_n(pub_sr_we_n),
    .pub_sr_wd(pub_sr_wd),
    .pub_sr_rd(pub_sr_rd),
        
    .pkc_sr_adr(pkc_sr_adr), 
    .pkc_sr_ce_n(pkc_sr_ce_n),
    .pkc_sr_we_n(pkc_sr_we_n),
    .pkc_sr_wd(pkc_sr_wd),
    .pkc_sr_rd(pkc_sr_rd),
        
    .ka_sr_adr(ka_sr_adr), 
    .ka_sr_ce_n(ka_sr_ce_n),
    .ka_sr_we_n(ka_sr_we_n),
    .ka_sr_wd(ka_sr_wd),
    .ka_sr_rd(ka_sr_rd),  
    
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

    .rng_fre_en(1'b0),
    .rng_fre_sel(1'b0),
    .rng_fre_out(rng_fre_out),

    .scan_mode(1'b0),
    .scan_clk(1'b0),

    .clk_eng(clk_eng),
    .clk_xtl(clk_xtl),
    .clk_apb(clk_apb),
    .clk_dma(clk_dma),
    
    .rst_n(rst_n)
 );

pufs_osc_wp#(
   .OSC_TYPE   (2), //0:Four ROs, 1:toogle, 2:LFSR
   .PRBS_SIZE  (19),
   .PRBS_POLY  (19'h72000),
   .PRBS_INIT  (19'h55555)
) I_OSC_WP(
   .ro_out({osc3,osc2,osc1,osc0}),
   .clk(clk_xtl),
   .rst_n(rst_n)
);
 
pkc_pub_sram I_PKC_PUB_SRAM
(
   .clka(clk_eng),
   .ena(~pub_sr_ce_n),
   .wea(~pub_sr_we_n),
   .addra(pub_sr_adr),
   .dina(pub_sr_wd),
   .douta(pub_sr_rd)
);

pkc_int_sram I_PKC_INT_SRAM
(
   .clka(clk_eng),
   .ena(~pkc_sr_ce_n),
   .wea(~pkc_sr_we_n),
   .addra(pkc_sr_adr),
   .dina(pkc_sr_wd),
   .douta(pkc_sr_rd)
);

ka_sram I_KA_SRAM
(
   .clka(clk_eng),
   .ena(~ka_sr_ce_n),
   .wea(~ka_sr_we_n),
   .addra(ka_sr_adr),
   .dina(ka_sr_wd),
   .douta(ka_sr_rd)
);

otp_puf_cell I_CELL0
(
   .clka(clk_xtl),
   .ena(~c0_ce_n),
   .wea(~c0_we_n),
   .addra(c0_addr),
   .dina(c0_din),
   .douta(c0_dout)
);

otp_puf_cell I_CELL1
(
   .clka(clk_xtl),
   .ena(~c1_ce_n),
   .wea(~c1_we_n),
   .addra(c1_addr),
   .dina(c1_din),
   .douta(c1_dout)
);

dma_fifo_sram I_DMA_RD_SRAM
(
   .clka ( clk_dma),
   .ena  (~dma_rd_sr_we_n),
   .wea  (~dma_rd_sr_we_n),
   .addra( dma_rd_sr_wa),
   .dina ( dma_rd_sr_wd),
   .clkb ( clk_eng),
   .addrb( dma_rd_sr_ra),
   .doutb( dma_rd_sr_rd),
   .enb  (~dma_rd_sr_re_n)
);

dma_fifo_sram I_DMA_WR_SRAM
(
   .clka ( clk_eng),
   .ena  (~dma_wr_sr_we_n),
   .wea  (~dma_wr_sr_we_n),
   .addra( dma_wr_sr_wa),
   .dina ( dma_wr_sr_wd),
   .clkb ( clk_dma),
   .addrb( dma_wr_sr_ra),
   .doutb( dma_wr_sr_rd),
   .enb  (~dma_wr_sr_re_n)
);

assign fpga_tie_h = 1'b1;
assign fpga_tie_l = 1'b0;


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

