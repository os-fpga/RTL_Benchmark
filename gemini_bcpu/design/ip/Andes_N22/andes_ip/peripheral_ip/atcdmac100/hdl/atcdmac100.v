// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcdmac100_config.vh"
`include "atcdmac100_const.vh"


module atcdmac100 (
	  haddr_mst,
	  hburst_mst,
	  hbusreq_mst,
	  hgrant_mst,
	  hlock_mst,
	  hprot_mst,
	  hrdata_mst,
	  hready_mst,
	  hresp_mst,
	  hsize_mst,
	  htrans_mst,
	  hwdata_mst,
	  hwrite_mst,
	  hclk,
	  hresetn,
	  dma_int,
	  haddr,
	  hburst,
	  hrdata,
	  hready,
	  hreadyin,
	  hresp,
	  hsel,
	  hsize,
	  htrans,
	  hwdata,
	  hwrite,
	  dma_ack,
	  dma_req
);

parameter ADDR_WIDTH = `ATCDMAC100_ADDR_WIDTH;
parameter ADDR_MSB = ADDR_WIDTH-1;
parameter DATA_WIDTH = 32;
parameter DATA_MSB = DATA_WIDTH-1;

output                  [(ADDR_WIDTH - 1):0] haddr_mst;
output                                 [2:0] hburst_mst;
output                                       hbusreq_mst;
input                                        hgrant_mst;
output                                       hlock_mst;
output                                 [3:0] hprot_mst;
input                   [(DATA_WIDTH - 1):0] hrdata_mst;
input                                        hready_mst;
input                                  [1:0] hresp_mst;
output                                 [2:0] hsize_mst;
output                                 [1:0] htrans_mst;
output                  [(DATA_WIDTH - 1):0] hwdata_mst;
output                                       hwrite_mst;
input                                        hclk;
input                                        hresetn;
output                                       dma_int;
input                   [(ADDR_WIDTH - 1):0] haddr;
input                                  [2:0] hburst;
output                  [(DATA_WIDTH - 1):0] hrdata;
output                                       hready;
input                                        hreadyin;
output                                 [1:0] hresp;
input                                        hsel;
input                                  [2:0] hsize;
input                                  [1:0] htrans;
input                   [(DATA_WIDTH - 1):0] hwdata;
input                                        hwrite;
output      [`ATCDMAC100_REQ_ACK_NUM-6'd1:0] dma_ack;
input       [`ATCDMAC100_REQ_ACK_NUM-6'd1:0] dma_req;

`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
wire                    [(ADDR_WIDTH - 1):0] ch_0_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_1_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_2_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_3_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_4_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_5_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_6_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_7_llp;
wire                    [(ADDR_WIDTH - 1):0] ch_llp;
wire                    [(ADDR_WIDTH - 1):0] dma_ch_llp_wdata;
wire                                         dma_ch_llp_wen;
`endif
`ifdef DMAC_CONFIG_CH0
wire                                         dma_ch_0_ctl_wen;
wire                                         dma_ch_0_dst_addr_wen;
wire                                         dma_ch_0_en_wen;
wire                                         dma_ch_0_err_wen;
wire                                         dma_ch_0_int_wen;
wire                                         dma_ch_0_src_addr_wen;
wire                                         dma_ch_0_tc_wen;
wire                                         dma_ch_0_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH1
wire                                         dma_ch_1_ctl_wen;
wire                                         dma_ch_1_dst_addr_wen;
wire                                         dma_ch_1_en_wen;
wire                                         dma_ch_1_err_wen;
wire                                         dma_ch_1_int_wen;
wire                                         dma_ch_1_src_addr_wen;
wire                                         dma_ch_1_tc_wen;
wire                                         dma_ch_1_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH2
wire                                         dma_ch_2_ctl_wen;
wire                                         dma_ch_2_dst_addr_wen;
wire                                         dma_ch_2_en_wen;
wire                                         dma_ch_2_err_wen;
wire                                         dma_ch_2_int_wen;
wire                                         dma_ch_2_src_addr_wen;
wire                                         dma_ch_2_tc_wen;
wire                                         dma_ch_2_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH3
wire                                         dma_ch_3_ctl_wen;
wire                                         dma_ch_3_dst_addr_wen;
wire                                         dma_ch_3_en_wen;
wire                                         dma_ch_3_err_wen;
wire                                         dma_ch_3_int_wen;
wire                                         dma_ch_3_src_addr_wen;
wire                                         dma_ch_3_tc_wen;
wire                                         dma_ch_3_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH4
wire                                         dma_ch_4_ctl_wen;
wire                                         dma_ch_4_dst_addr_wen;
wire                                         dma_ch_4_en_wen;
wire                                         dma_ch_4_err_wen;
wire                                         dma_ch_4_int_wen;
wire                                         dma_ch_4_src_addr_wen;
wire                                         dma_ch_4_tc_wen;
wire                                         dma_ch_4_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH5
wire                                         dma_ch_5_ctl_wen;
wire                                         dma_ch_5_dst_addr_wen;
wire                                         dma_ch_5_en_wen;
wire                                         dma_ch_5_err_wen;
wire                                         dma_ch_5_int_wen;
wire                                         dma_ch_5_src_addr_wen;
wire                                         dma_ch_5_tc_wen;
wire                                         dma_ch_5_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH6
wire                                         dma_ch_6_ctl_wen;
wire                                         dma_ch_6_dst_addr_wen;
wire                                         dma_ch_6_en_wen;
wire                                         dma_ch_6_err_wen;
wire                                         dma_ch_6_int_wen;
wire                                         dma_ch_6_src_addr_wen;
wire                                         dma_ch_6_tc_wen;
wire                                         dma_ch_6_tts_wen;
`endif
`ifdef DMAC_CONFIG_CH7
wire                                         dma_ch_7_ctl_wen;
wire                                         dma_ch_7_dst_addr_wen;
wire                                         dma_ch_7_en_wen;
wire                                         dma_ch_7_err_wen;
wire                                         dma_ch_7_int_wen;
wire                                         dma_ch_7_src_addr_wen;
wire                                         dma_ch_7_tc_wen;
wire                                         dma_ch_7_tts_wen;
`endif
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
   `ifdef DMAC_CONFIG_CH0
wire                                         dma_ch_0_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH1
wire                                         dma_ch_1_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH2
wire                                         dma_ch_2_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH3
wire                                         dma_ch_3_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH4
wire                                         dma_ch_4_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH5
wire                                         dma_ch_5_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH6
wire                                         dma_ch_6_llp_wen;
   `endif
   `ifdef DMAC_CONFIG_CH7
wire                                         dma_ch_7_llp_wen;
   `endif
`endif
wire                                         mst_dma_1st_ap;
wire                                         mst_dma_ack;
wire                    [(ADDR_WIDTH - 1):0] mst_dma_addr;
wire                                         mst_dma_error;
wire                                         mst_dma_grant;
wire                    [(DATA_WIDTH - 1):0] mst_dma_rdata;
wire                                         mst_dma_retry_2nd_cycle;
wire                                         mst_dma_retry_ap;
wire                                         ch_0_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_0_dst_addr;
wire                                   [1:0] ch_0_dst_addr_ctl;
wire                                         ch_0_dst_mode;
wire                                   [4:0] ch_0_dst_req_sel;
wire                                   [1:0] ch_0_dst_width;
wire                                         ch_0_en;
wire                                         ch_0_int_abt_mask;
wire                                         ch_0_int_err_mask;
wire                                         ch_0_int_tc_mask;
wire                                         ch_0_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_0_src_addr;
wire                                   [1:0] ch_0_src_addr_ctl;
wire                                   [2:0] ch_0_src_burst_size;
wire                                         ch_0_src_mode;
wire                                   [4:0] ch_0_src_req_sel;
wire                                   [1:0] ch_0_src_width;
wire                                  [21:0] ch_0_tts;
wire                                         ch_1_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_1_dst_addr;
wire                                   [1:0] ch_1_dst_addr_ctl;
wire                                         ch_1_dst_mode;
wire                                   [4:0] ch_1_dst_req_sel;
wire                                   [1:0] ch_1_dst_width;
wire                                         ch_1_en;
wire                                         ch_1_int_abt_mask;
wire                                         ch_1_int_err_mask;
wire                                         ch_1_int_tc_mask;
wire                                         ch_1_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_1_src_addr;
wire                                   [1:0] ch_1_src_addr_ctl;
wire                                   [2:0] ch_1_src_burst_size;
wire                                         ch_1_src_mode;
wire                                   [4:0] ch_1_src_req_sel;
wire                                   [1:0] ch_1_src_width;
wire                                  [21:0] ch_1_tts;
wire                                         ch_2_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_2_dst_addr;
wire                                   [1:0] ch_2_dst_addr_ctl;
wire                                         ch_2_dst_mode;
wire                                   [4:0] ch_2_dst_req_sel;
wire                                   [1:0] ch_2_dst_width;
wire                                         ch_2_en;
wire                                         ch_2_int_abt_mask;
wire                                         ch_2_int_err_mask;
wire                                         ch_2_int_tc_mask;
wire                                         ch_2_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_2_src_addr;
wire                                   [1:0] ch_2_src_addr_ctl;
wire                                   [2:0] ch_2_src_burst_size;
wire                                         ch_2_src_mode;
wire                                   [4:0] ch_2_src_req_sel;
wire                                   [1:0] ch_2_src_width;
wire                                  [21:0] ch_2_tts;
wire                                         ch_3_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_3_dst_addr;
wire                                   [1:0] ch_3_dst_addr_ctl;
wire                                         ch_3_dst_mode;
wire                                   [4:0] ch_3_dst_req_sel;
wire                                   [1:0] ch_3_dst_width;
wire                                         ch_3_en;
wire                                         ch_3_int_abt_mask;
wire                                         ch_3_int_err_mask;
wire                                         ch_3_int_tc_mask;
wire                                         ch_3_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_3_src_addr;
wire                                   [1:0] ch_3_src_addr_ctl;
wire                                   [2:0] ch_3_src_burst_size;
wire                                         ch_3_src_mode;
wire                                   [4:0] ch_3_src_req_sel;
wire                                   [1:0] ch_3_src_width;
wire                                  [21:0] ch_3_tts;
wire                                         ch_4_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_4_dst_addr;
wire                                   [1:0] ch_4_dst_addr_ctl;
wire                                         ch_4_dst_mode;
wire                                   [4:0] ch_4_dst_req_sel;
wire                                   [1:0] ch_4_dst_width;
wire                                         ch_4_en;
wire                                         ch_4_int_abt_mask;
wire                                         ch_4_int_err_mask;
wire                                         ch_4_int_tc_mask;
wire                                         ch_4_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_4_src_addr;
wire                                   [1:0] ch_4_src_addr_ctl;
wire                                   [2:0] ch_4_src_burst_size;
wire                                         ch_4_src_mode;
wire                                   [4:0] ch_4_src_req_sel;
wire                                   [1:0] ch_4_src_width;
wire                                  [21:0] ch_4_tts;
wire                                         ch_5_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_5_dst_addr;
wire                                   [1:0] ch_5_dst_addr_ctl;
wire                                         ch_5_dst_mode;
wire                                   [4:0] ch_5_dst_req_sel;
wire                                   [1:0] ch_5_dst_width;
wire                                         ch_5_en;
wire                                         ch_5_int_abt_mask;
wire                                         ch_5_int_err_mask;
wire                                         ch_5_int_tc_mask;
wire                                         ch_5_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_5_src_addr;
wire                                   [1:0] ch_5_src_addr_ctl;
wire                                   [2:0] ch_5_src_burst_size;
wire                                         ch_5_src_mode;
wire                                   [4:0] ch_5_src_req_sel;
wire                                   [1:0] ch_5_src_width;
wire                                  [21:0] ch_5_tts;
wire                                         ch_6_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_6_dst_addr;
wire                                   [1:0] ch_6_dst_addr_ctl;
wire                                         ch_6_dst_mode;
wire                                   [4:0] ch_6_dst_req_sel;
wire                                   [1:0] ch_6_dst_width;
wire                                         ch_6_en;
wire                                         ch_6_int_abt_mask;
wire                                         ch_6_int_err_mask;
wire                                         ch_6_int_tc_mask;
wire                                         ch_6_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_6_src_addr;
wire                                   [1:0] ch_6_src_addr_ctl;
wire                                   [2:0] ch_6_src_burst_size;
wire                                         ch_6_src_mode;
wire                                   [4:0] ch_6_src_req_sel;
wire                                   [1:0] ch_6_src_width;
wire                                  [21:0] ch_6_tts;
wire                                         ch_7_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_7_dst_addr;
wire                                   [1:0] ch_7_dst_addr_ctl;
wire                                         ch_7_dst_mode;
wire                                   [4:0] ch_7_dst_req_sel;
wire                                   [1:0] ch_7_dst_width;
wire                                         ch_7_en;
wire                                         ch_7_int_abt_mask;
wire                                         ch_7_int_err_mask;
wire                                         ch_7_int_tc_mask;
wire                                         ch_7_priority;
wire                    [(ADDR_WIDTH - 1):0] ch_7_src_addr;
wire                                   [1:0] ch_7_src_addr_ctl;
wire                                   [2:0] ch_7_src_burst_size;
wire                                         ch_7_src_mode;
wire                                   [4:0] ch_7_src_req_sel;
wire                                   [1:0] ch_7_src_width;
wire                                  [21:0] ch_7_tts;
wire                                         dma_soft_reset;
wire                                   [2:0] granted_channel;
wire                                         arb_end;
wire                                         ch_abt;
wire                    [(ADDR_WIDTH - 1):0] ch_dst_addr;
wire                                   [1:0] ch_dst_addr_ctl;
wire                                         ch_dst_mode;
wire                                         ch_dst_request;
wire                                   [1:0] ch_dst_width;
wire                                         ch_int_abt_mask;
wire                                         ch_int_err_mask;
wire                                         ch_int_tc_mask;
wire                                   [7:0] ch_level;
wire                                   [7:0] ch_request;
wire                    [(ADDR_WIDTH - 1):0] ch_src_addr;
wire                                   [1:0] ch_src_addr_ctl;
wire                                   [2:0] ch_src_burst_size;
wire                                         ch_src_mode;
wire                                         ch_src_request;
wire                                   [1:0] ch_src_width;
wire                                  [21:0] ch_tts;
wire                                   [2:0] current_channel;
wire                                         addr_cross_1k;
wire                                         arb_end_1st_cycle;
wire                                  [31:1] dma_ch_ctl_wdata;
wire                                         dma_ch_ctl_wen;
wire                                         dma_ch_dst_ack;
wire                    [(ADDR_WIDTH - 1):0] dma_ch_dst_addr_wdata;
wire                                         dma_ch_dst_addr_wen;
wire                                         dma_ch_en_wen;
wire                                         dma_ch_err_wen;
wire                                         dma_ch_int_wen;
wire                                         dma_ch_src_ack;
wire                    [(ADDR_WIDTH - 1):0] dma_ch_src_addr_wdata;
wire                                         dma_ch_src_addr_wen;
wire                                         dma_ch_tc_wen;
wire                                  [21:0] dma_ch_tts_wdata;
wire                                         dma_ch_tts_wen;
wire                                         dma_fifo_dst_addr_dec;
wire                                         dma_fifo_flush;
wire                                         dma_fifo_last_rd;
wire                                         dma_fifo_last_wr;
wire                                   [1:0] dma_fifo_rbyte_offset;
wire                                         dma_fifo_rd;
wire                                   [1:0] dma_fifo_rd_size;
wire                                         dma_fifo_src_addr_dec;
wire                                   [1:0] dma_fifo_wbyte_offset;
wire                    [(DATA_WIDTH - 1):0] dma_fifo_wdata;
wire                                         dma_fifo_wr;
wire                                   [1:0] dma_fifo_wr_size;
wire                    [(ADDR_WIDTH - 1):0] dma_mst_addr;
wire                                   [2:0] dma_mst_burst;
wire                                         dma_mst_direction_change;
wire                                         dma_mst_req;
wire                                   [1:0] dma_mst_size;
wire                    [(DATA_WIDTH - 1):0] dma_mst_wdata;
wire                                         dma_mst_write;
wire                                         idle_state;
wire                    [(DATA_WIDTH - 1):0] dma_fifo_rdata;


atcdmac100_engine #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) atcdmac100_engine (
	.hclk                    (hclk                    ),
	.hresetn                 (hresetn                 ),
	.dma_soft_reset          (dma_soft_reset          ),
	.idle_state              (idle_state              ),
	.arb_end                 (arb_end                 ),
	.arb_end_1st_cycle       (arb_end_1st_cycle       ),
	.dma_mst_req             (dma_mst_req             ),
	.dma_mst_addr            (dma_mst_addr            ),
	.dma_mst_write           (dma_mst_write           ),
	.dma_mst_size            (dma_mst_size            ),
	.dma_mst_wdata           (dma_mst_wdata           ),
	.dma_mst_burst           (dma_mst_burst           ),
	.dma_mst_direction_change(dma_mst_direction_change),
	.addr_cross_1k           (addr_cross_1k           ),
	.mst_dma_addr            (mst_dma_addr            ),
	.mst_dma_grant           (mst_dma_grant           ),
	.mst_dma_1st_ap          (mst_dma_1st_ap          ),
	.mst_dma_ack             (mst_dma_ack             ),
	.mst_dma_rdata           (mst_dma_rdata           ),
	.mst_dma_error           (mst_dma_error           ),
	.mst_dma_retry_2nd_cycle (mst_dma_retry_2nd_cycle ),
	.mst_dma_retry_ap        (mst_dma_retry_ap        ),
	.ch_src_addr_ctl         (ch_src_addr_ctl         ),
	.ch_dst_addr_ctl         (ch_dst_addr_ctl         ),
	.ch_src_width            (ch_src_width            ),
	.ch_dst_width            (ch_dst_width            ),
	.ch_src_burst_size       (ch_src_burst_size       ),
	.ch_src_mode             (ch_src_mode             ),
	.ch_src_request          (ch_src_request          ),
	.ch_dst_mode             (ch_dst_mode             ),
	.ch_dst_request          (ch_dst_request          ),
	.ch_tts                  (ch_tts                  ),
	.ch_src_addr             (ch_src_addr             ),
	.ch_dst_addr             (ch_dst_addr             ),
	.ch_int_tc_mask          (ch_int_tc_mask          ),
	.ch_int_err_mask         (ch_int_err_mask         ),
	.ch_int_abt_mask         (ch_int_abt_mask         ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_llp                  (ch_llp                  ),
`endif
	.ch_abt                  (ch_abt                  ),
	.dma_ch_src_ack          (dma_ch_src_ack          ),
	.dma_ch_dst_ack          (dma_ch_dst_ack          ),
	.dma_ch_ctl_wen          (dma_ch_ctl_wen          ),
	.dma_ch_en_wen           (dma_ch_en_wen           ),
	.dma_ch_src_addr_wen     (dma_ch_src_addr_wen     ),
	.dma_ch_dst_addr_wen     (dma_ch_dst_addr_wen     ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wen          (dma_ch_llp_wen          ),
`endif
	.dma_ch_tts_wen          (dma_ch_tts_wen          ),
	.dma_ch_tc_wen           (dma_ch_tc_wen           ),
	.dma_ch_err_wen          (dma_ch_err_wen          ),
	.dma_ch_int_wen          (dma_ch_int_wen          ),
	.dma_ch_ctl_wdata        (dma_ch_ctl_wdata        ),
	.dma_ch_tts_wdata        (dma_ch_tts_wdata        ),
	.dma_ch_src_addr_wdata   (dma_ch_src_addr_wdata   ),
	.dma_ch_dst_addr_wdata   (dma_ch_dst_addr_wdata   ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wdata        (dma_ch_llp_wdata        ),
`endif
	.dma_fifo_rbyte_offset   (dma_fifo_rbyte_offset   ),
	.dma_fifo_wbyte_offset   (dma_fifo_wbyte_offset   ),
	.dma_fifo_flush          (dma_fifo_flush          ),
	.dma_fifo_last_wr        (dma_fifo_last_wr        ),
	.dma_fifo_last_rd        (dma_fifo_last_rd        ),
	.dma_fifo_rd             (dma_fifo_rd             ),
	.dma_fifo_wr_size        (dma_fifo_wr_size        ),
	.dma_fifo_rd_size        (dma_fifo_rd_size        ),
	.dma_fifo_wdata          (dma_fifo_wdata          ),
	.dma_fifo_wr             (dma_fifo_wr             ),
	.dma_fifo_src_addr_dec   (dma_fifo_src_addr_dec   ),
	.dma_fifo_dst_addr_dec   (dma_fifo_dst_addr_dec   ),
	.dma_fifo_rdata          (dma_fifo_rdata          )
);

atcdmac100_ahbmst #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) atcdmac100_ahbmst (
	.hclk                    (hclk                    ),
	.hresetn                 (hresetn                 ),
	.hbusreq_mst             (hbusreq_mst             ),
	.hlock_mst               (hlock_mst               ),
	.htrans_mst              (htrans_mst              ),
	.haddr_mst               (haddr_mst               ),
	.hwrite_mst              (hwrite_mst              ),
	.hsize_mst               (hsize_mst               ),
	.hburst_mst              (hburst_mst              ),
	.hprot_mst               (hprot_mst               ),
	.hwdata_mst              (hwdata_mst              ),
	.hgrant_mst              (hgrant_mst              ),
	.hready_mst              (hready_mst              ),
	.hresp_mst               (hresp_mst               ),
	.hrdata_mst              (hrdata_mst              ),
	.dma_mst_req             (dma_mst_req             ),
	.dma_mst_addr            (dma_mst_addr            ),
	.dma_mst_write           (dma_mst_write           ),
	.dma_mst_size            (dma_mst_size            ),
	.dma_mst_burst           (dma_mst_burst           ),
	.dma_mst_wdata           (dma_mst_wdata           ),
	.dma_mst_direction_change(dma_mst_direction_change),
	.arb_end_1st_cycle       (arb_end_1st_cycle       ),
	.addr_cross_1k           (addr_cross_1k           ),
	.mst_dma_addr            (mst_dma_addr            ),
	.mst_dma_grant           (mst_dma_grant           ),
	.mst_dma_1st_ap          (mst_dma_1st_ap          ),
	.mst_dma_ack             (mst_dma_ack             ),
	.mst_dma_rdata           (mst_dma_rdata           ),
	.mst_dma_error           (mst_dma_error           ),
	.mst_dma_retry_2nd_cycle (mst_dma_retry_2nd_cycle ),
	.mst_dma_retry_ap        (mst_dma_retry_ap        )
);

atcdmac100_ahbslv #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) atcdmac100_ahbslv (
	.hclk                 (hclk                 ),
	.hresetn              (hresetn              ),
	.haddr                (haddr                ),
	.htrans               (htrans               ),
	.hwrite               (hwrite               ),
	.hsize                (hsize                ),
	.hburst               (hburst               ),
	.hwdata               (hwdata               ),
	.hsel                 (hsel                 ),
	.hreadyin             (hreadyin             ),
	.hrdata               (hrdata               ),
	.hresp                (hresp                ),
	.hready               (hready               ),
	.dma_int              (dma_int              ),
	.dma_soft_reset       (dma_soft_reset       ),
	.ch_0_en              (ch_0_en              ),
	.ch_0_int_tc_mask     (ch_0_int_tc_mask     ),
	.ch_0_int_err_mask    (ch_0_int_err_mask    ),
	.ch_0_int_abt_mask    (ch_0_int_abt_mask    ),
	.ch_0_src_req_sel     (ch_0_src_req_sel     ),
	.ch_0_dst_req_sel     (ch_0_dst_req_sel     ),
	.ch_0_src_addr_ctl    (ch_0_src_addr_ctl    ),
	.ch_0_dst_addr_ctl    (ch_0_dst_addr_ctl    ),
	.ch_0_src_mode        (ch_0_src_mode        ),
	.ch_0_dst_mode        (ch_0_dst_mode        ),
	.ch_0_src_width       (ch_0_src_width       ),
	.ch_0_dst_width       (ch_0_dst_width       ),
	.ch_0_src_burst_size  (ch_0_src_burst_size  ),
	.ch_0_priority        (ch_0_priority        ),
	.ch_0_src_addr        (ch_0_src_addr        ),
	.ch_0_dst_addr        (ch_0_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_0_llp             (ch_0_llp             ),
`endif
	.ch_0_tts             (ch_0_tts             ),
	.ch_0_abt             (ch_0_abt             ),
	.ch_1_en              (ch_1_en              ),
	.ch_1_int_tc_mask     (ch_1_int_tc_mask     ),
	.ch_1_int_err_mask    (ch_1_int_err_mask    ),
	.ch_1_int_abt_mask    (ch_1_int_abt_mask    ),
	.ch_1_src_req_sel     (ch_1_src_req_sel     ),
	.ch_1_dst_req_sel     (ch_1_dst_req_sel     ),
	.ch_1_src_addr_ctl    (ch_1_src_addr_ctl    ),
	.ch_1_dst_addr_ctl    (ch_1_dst_addr_ctl    ),
	.ch_1_src_mode        (ch_1_src_mode        ),
	.ch_1_dst_mode        (ch_1_dst_mode        ),
	.ch_1_src_width       (ch_1_src_width       ),
	.ch_1_dst_width       (ch_1_dst_width       ),
	.ch_1_src_burst_size  (ch_1_src_burst_size  ),
	.ch_1_priority        (ch_1_priority        ),
	.ch_1_src_addr        (ch_1_src_addr        ),
	.ch_1_dst_addr        (ch_1_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_1_llp             (ch_1_llp             ),
`endif
	.ch_1_tts             (ch_1_tts             ),
	.ch_1_abt             (ch_1_abt             ),
	.ch_2_en              (ch_2_en              ),
	.ch_2_int_tc_mask     (ch_2_int_tc_mask     ),
	.ch_2_int_err_mask    (ch_2_int_err_mask    ),
	.ch_2_int_abt_mask    (ch_2_int_abt_mask    ),
	.ch_2_src_req_sel     (ch_2_src_req_sel     ),
	.ch_2_dst_req_sel     (ch_2_dst_req_sel     ),
	.ch_2_src_addr_ctl    (ch_2_src_addr_ctl    ),
	.ch_2_dst_addr_ctl    (ch_2_dst_addr_ctl    ),
	.ch_2_src_mode        (ch_2_src_mode        ),
	.ch_2_dst_mode        (ch_2_dst_mode        ),
	.ch_2_src_width       (ch_2_src_width       ),
	.ch_2_dst_width       (ch_2_dst_width       ),
	.ch_2_src_burst_size  (ch_2_src_burst_size  ),
	.ch_2_priority        (ch_2_priority        ),
	.ch_2_src_addr        (ch_2_src_addr        ),
	.ch_2_dst_addr        (ch_2_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_2_llp             (ch_2_llp             ),
`endif
	.ch_2_tts             (ch_2_tts             ),
	.ch_2_abt             (ch_2_abt             ),
	.ch_3_en              (ch_3_en              ),
	.ch_3_int_tc_mask     (ch_3_int_tc_mask     ),
	.ch_3_int_err_mask    (ch_3_int_err_mask    ),
	.ch_3_int_abt_mask    (ch_3_int_abt_mask    ),
	.ch_3_src_req_sel     (ch_3_src_req_sel     ),
	.ch_3_dst_req_sel     (ch_3_dst_req_sel     ),
	.ch_3_src_addr_ctl    (ch_3_src_addr_ctl    ),
	.ch_3_dst_addr_ctl    (ch_3_dst_addr_ctl    ),
	.ch_3_src_mode        (ch_3_src_mode        ),
	.ch_3_dst_mode        (ch_3_dst_mode        ),
	.ch_3_src_width       (ch_3_src_width       ),
	.ch_3_dst_width       (ch_3_dst_width       ),
	.ch_3_src_burst_size  (ch_3_src_burst_size  ),
	.ch_3_priority        (ch_3_priority        ),
	.ch_3_src_addr        (ch_3_src_addr        ),
	.ch_3_dst_addr        (ch_3_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_3_llp             (ch_3_llp             ),
`endif
	.ch_3_tts             (ch_3_tts             ),
	.ch_3_abt             (ch_3_abt             ),
	.ch_4_en              (ch_4_en              ),
	.ch_4_int_tc_mask     (ch_4_int_tc_mask     ),
	.ch_4_int_err_mask    (ch_4_int_err_mask    ),
	.ch_4_int_abt_mask    (ch_4_int_abt_mask    ),
	.ch_4_src_req_sel     (ch_4_src_req_sel     ),
	.ch_4_dst_req_sel     (ch_4_dst_req_sel     ),
	.ch_4_src_addr_ctl    (ch_4_src_addr_ctl    ),
	.ch_4_dst_addr_ctl    (ch_4_dst_addr_ctl    ),
	.ch_4_src_mode        (ch_4_src_mode        ),
	.ch_4_dst_mode        (ch_4_dst_mode        ),
	.ch_4_src_width       (ch_4_src_width       ),
	.ch_4_dst_width       (ch_4_dst_width       ),
	.ch_4_src_burst_size  (ch_4_src_burst_size  ),
	.ch_4_priority        (ch_4_priority        ),
	.ch_4_src_addr        (ch_4_src_addr        ),
	.ch_4_dst_addr        (ch_4_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_4_llp             (ch_4_llp             ),
`endif
	.ch_4_tts             (ch_4_tts             ),
	.ch_4_abt             (ch_4_abt             ),
	.ch_5_en              (ch_5_en              ),
	.ch_5_int_tc_mask     (ch_5_int_tc_mask     ),
	.ch_5_int_err_mask    (ch_5_int_err_mask    ),
	.ch_5_int_abt_mask    (ch_5_int_abt_mask    ),
	.ch_5_src_req_sel     (ch_5_src_req_sel     ),
	.ch_5_dst_req_sel     (ch_5_dst_req_sel     ),
	.ch_5_src_addr_ctl    (ch_5_src_addr_ctl    ),
	.ch_5_dst_addr_ctl    (ch_5_dst_addr_ctl    ),
	.ch_5_src_mode        (ch_5_src_mode        ),
	.ch_5_dst_mode        (ch_5_dst_mode        ),
	.ch_5_src_width       (ch_5_src_width       ),
	.ch_5_dst_width       (ch_5_dst_width       ),
	.ch_5_src_burst_size  (ch_5_src_burst_size  ),
	.ch_5_priority        (ch_5_priority        ),
	.ch_5_src_addr        (ch_5_src_addr        ),
	.ch_5_dst_addr        (ch_5_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_5_llp             (ch_5_llp             ),
`endif
	.ch_5_tts             (ch_5_tts             ),
	.ch_5_abt             (ch_5_abt             ),
	.ch_6_en              (ch_6_en              ),
	.ch_6_int_tc_mask     (ch_6_int_tc_mask     ),
	.ch_6_int_err_mask    (ch_6_int_err_mask    ),
	.ch_6_int_abt_mask    (ch_6_int_abt_mask    ),
	.ch_6_src_req_sel     (ch_6_src_req_sel     ),
	.ch_6_dst_req_sel     (ch_6_dst_req_sel     ),
	.ch_6_src_addr_ctl    (ch_6_src_addr_ctl    ),
	.ch_6_dst_addr_ctl    (ch_6_dst_addr_ctl    ),
	.ch_6_src_mode        (ch_6_src_mode        ),
	.ch_6_dst_mode        (ch_6_dst_mode        ),
	.ch_6_src_width       (ch_6_src_width       ),
	.ch_6_dst_width       (ch_6_dst_width       ),
	.ch_6_src_burst_size  (ch_6_src_burst_size  ),
	.ch_6_priority        (ch_6_priority        ),
	.ch_6_src_addr        (ch_6_src_addr        ),
	.ch_6_dst_addr        (ch_6_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_6_llp             (ch_6_llp             ),
`endif
	.ch_6_tts             (ch_6_tts             ),
	.ch_6_abt             (ch_6_abt             ),
	.ch_7_en              (ch_7_en              ),
	.ch_7_int_tc_mask     (ch_7_int_tc_mask     ),
	.ch_7_int_err_mask    (ch_7_int_err_mask    ),
	.ch_7_int_abt_mask    (ch_7_int_abt_mask    ),
	.ch_7_src_req_sel     (ch_7_src_req_sel     ),
	.ch_7_dst_req_sel     (ch_7_dst_req_sel     ),
	.ch_7_src_addr_ctl    (ch_7_src_addr_ctl    ),
	.ch_7_dst_addr_ctl    (ch_7_dst_addr_ctl    ),
	.ch_7_src_mode        (ch_7_src_mode        ),
	.ch_7_dst_mode        (ch_7_dst_mode        ),
	.ch_7_src_width       (ch_7_src_width       ),
	.ch_7_dst_width       (ch_7_dst_width       ),
	.ch_7_src_burst_size  (ch_7_src_burst_size  ),
	.ch_7_priority        (ch_7_priority        ),
	.ch_7_src_addr        (ch_7_src_addr        ),
	.ch_7_dst_addr        (ch_7_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_7_llp             (ch_7_llp             ),
`endif
	.ch_7_tts             (ch_7_tts             ),
	.ch_7_abt             (ch_7_abt             ),
`ifdef DMAC_CONFIG_CH0
	.dma_ch_0_ctl_wen     (dma_ch_0_ctl_wen     ),
	.dma_ch_0_en_wen      (dma_ch_0_en_wen      ),
	.dma_ch_0_src_addr_wen(dma_ch_0_src_addr_wen),
	.dma_ch_0_dst_addr_wen(dma_ch_0_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_0_llp_wen     (dma_ch_0_llp_wen     ),
   `endif
	.dma_ch_0_tts_wen     (dma_ch_0_tts_wen     ),
	.dma_ch_0_tc_wen      (dma_ch_0_tc_wen      ),
	.dma_ch_0_err_wen     (dma_ch_0_err_wen     ),
	.dma_ch_0_int_wen     (dma_ch_0_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH1
	.dma_ch_1_ctl_wen     (dma_ch_1_ctl_wen     ),
	.dma_ch_1_en_wen      (dma_ch_1_en_wen      ),
	.dma_ch_1_src_addr_wen(dma_ch_1_src_addr_wen),
	.dma_ch_1_dst_addr_wen(dma_ch_1_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_1_llp_wen     (dma_ch_1_llp_wen     ),
   `endif
	.dma_ch_1_tts_wen     (dma_ch_1_tts_wen     ),
	.dma_ch_1_tc_wen      (dma_ch_1_tc_wen      ),
	.dma_ch_1_err_wen     (dma_ch_1_err_wen     ),
	.dma_ch_1_int_wen     (dma_ch_1_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH2
	.dma_ch_2_ctl_wen     (dma_ch_2_ctl_wen     ),
	.dma_ch_2_en_wen      (dma_ch_2_en_wen      ),
	.dma_ch_2_src_addr_wen(dma_ch_2_src_addr_wen),
	.dma_ch_2_dst_addr_wen(dma_ch_2_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_2_llp_wen     (dma_ch_2_llp_wen     ),
   `endif
	.dma_ch_2_tts_wen     (dma_ch_2_tts_wen     ),
	.dma_ch_2_tc_wen      (dma_ch_2_tc_wen      ),
	.dma_ch_2_err_wen     (dma_ch_2_err_wen     ),
	.dma_ch_2_int_wen     (dma_ch_2_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH3
	.dma_ch_3_ctl_wen     (dma_ch_3_ctl_wen     ),
	.dma_ch_3_en_wen      (dma_ch_3_en_wen      ),
	.dma_ch_3_src_addr_wen(dma_ch_3_src_addr_wen),
	.dma_ch_3_dst_addr_wen(dma_ch_3_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_3_llp_wen     (dma_ch_3_llp_wen     ),
   `endif
	.dma_ch_3_tts_wen     (dma_ch_3_tts_wen     ),
	.dma_ch_3_tc_wen      (dma_ch_3_tc_wen      ),
	.dma_ch_3_err_wen     (dma_ch_3_err_wen     ),
	.dma_ch_3_int_wen     (dma_ch_3_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH4
	.dma_ch_4_ctl_wen     (dma_ch_4_ctl_wen     ),
	.dma_ch_4_en_wen      (dma_ch_4_en_wen      ),
	.dma_ch_4_src_addr_wen(dma_ch_4_src_addr_wen),
	.dma_ch_4_dst_addr_wen(dma_ch_4_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_4_llp_wen     (dma_ch_4_llp_wen     ),
   `endif
	.dma_ch_4_tts_wen     (dma_ch_4_tts_wen     ),
	.dma_ch_4_tc_wen      (dma_ch_4_tc_wen      ),
	.dma_ch_4_err_wen     (dma_ch_4_err_wen     ),
	.dma_ch_4_int_wen     (dma_ch_4_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH5
	.dma_ch_5_ctl_wen     (dma_ch_5_ctl_wen     ),
	.dma_ch_5_en_wen      (dma_ch_5_en_wen      ),
	.dma_ch_5_src_addr_wen(dma_ch_5_src_addr_wen),
	.dma_ch_5_dst_addr_wen(dma_ch_5_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_5_llp_wen     (dma_ch_5_llp_wen     ),
   `endif
	.dma_ch_5_tts_wen     (dma_ch_5_tts_wen     ),
	.dma_ch_5_tc_wen      (dma_ch_5_tc_wen      ),
	.dma_ch_5_err_wen     (dma_ch_5_err_wen     ),
	.dma_ch_5_int_wen     (dma_ch_5_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH6
	.dma_ch_6_ctl_wen     (dma_ch_6_ctl_wen     ),
	.dma_ch_6_en_wen      (dma_ch_6_en_wen      ),
	.dma_ch_6_src_addr_wen(dma_ch_6_src_addr_wen),
	.dma_ch_6_dst_addr_wen(dma_ch_6_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_6_llp_wen     (dma_ch_6_llp_wen     ),
   `endif
	.dma_ch_6_tts_wen     (dma_ch_6_tts_wen     ),
	.dma_ch_6_tc_wen      (dma_ch_6_tc_wen      ),
	.dma_ch_6_err_wen     (dma_ch_6_err_wen     ),
	.dma_ch_6_int_wen     (dma_ch_6_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH7
	.dma_ch_7_ctl_wen     (dma_ch_7_ctl_wen     ),
	.dma_ch_7_en_wen      (dma_ch_7_en_wen      ),
	.dma_ch_7_src_addr_wen(dma_ch_7_src_addr_wen),
	.dma_ch_7_dst_addr_wen(dma_ch_7_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_7_llp_wen     (dma_ch_7_llp_wen     ),
   `endif
	.dma_ch_7_tts_wen     (dma_ch_7_tts_wen     ),
	.dma_ch_7_tc_wen      (dma_ch_7_tc_wen      ),
	.dma_ch_7_err_wen     (dma_ch_7_err_wen     ),
	.dma_ch_7_int_wen     (dma_ch_7_int_wen     ),
`endif
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wdata     (dma_ch_llp_wdata     ),
`endif
	.dma_ch_ctl_wdata     (dma_ch_ctl_wdata     ),
	.dma_ch_tts_wdata     (dma_ch_tts_wdata     ),
	.dma_ch_src_addr_wdata(dma_ch_src_addr_wdata),
	.dma_ch_dst_addr_wdata(dma_ch_dst_addr_wdata)
);

atcdmac100_fifo #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) atcdmac100_fifo (
	.hclk                 (hclk                 ),
	.hresetn              (hresetn              ),
	.dma_soft_reset       (dma_soft_reset       ),
	.dma_fifo_wr          (dma_fifo_wr          ),
	.dma_fifo_last_wr     (dma_fifo_last_wr     ),
	.dma_fifo_last_rd     (dma_fifo_last_rd     ),
	.dma_fifo_wdata       (dma_fifo_wdata       ),
	.dma_fifo_rd_size     (dma_fifo_rd_size     ),
	.dma_fifo_wr_size     (dma_fifo_wr_size     ),
	.dma_fifo_rd          (dma_fifo_rd          ),
	.dma_fifo_rbyte_offset(dma_fifo_rbyte_offset),
	.dma_fifo_wbyte_offset(dma_fifo_wbyte_offset),
	.dma_fifo_flush       (dma_fifo_flush       ),
	.dma_fifo_src_addr_dec(dma_fifo_src_addr_dec),
	.dma_fifo_dst_addr_dec(dma_fifo_dst_addr_dec),
	.dma_idle_state       (idle_state           ),
	.dma_fifo_rdata       (dma_fifo_rdata       )
);

atcdmac100_chmux #(
	.ADDR_WIDTH      (ADDR_WIDTH      ),
	.DATA_WIDTH      (DATA_WIDTH      )
) atcdmac100_chmux (
	.hclk                 (hclk                 ),
	.hresetn              (hresetn              ),
	.dma_soft_reset       (dma_soft_reset       ),
	.idle_state           (idle_state           ),
	.granted_channel      (granted_channel      ),
	.ch_request           (ch_request           ),
	.ch_level             (ch_level             ),
	.current_channel      (current_channel      ),
	.arb_end              (arb_end              ),
	.dma_req              (dma_req              ),
	.dma_ack              (dma_ack              ),
	.ch_0_en              (ch_0_en              ),
	.ch_0_int_tc_mask     (ch_0_int_tc_mask     ),
	.ch_0_int_err_mask    (ch_0_int_err_mask    ),
	.ch_0_int_abt_mask    (ch_0_int_abt_mask    ),
	.ch_0_src_req_sel     (ch_0_src_req_sel     ),
	.ch_0_dst_req_sel     (ch_0_dst_req_sel     ),
	.ch_0_src_addr_ctl    (ch_0_src_addr_ctl    ),
	.ch_0_dst_addr_ctl    (ch_0_dst_addr_ctl    ),
	.ch_0_src_mode        (ch_0_src_mode        ),
	.ch_0_dst_mode        (ch_0_dst_mode        ),
	.ch_0_src_width       (ch_0_src_width       ),
	.ch_0_dst_width       (ch_0_dst_width       ),
	.ch_0_src_burst_size  (ch_0_src_burst_size  ),
	.ch_0_priority        (ch_0_priority        ),
	.ch_0_src_addr        (ch_0_src_addr        ),
	.ch_0_dst_addr        (ch_0_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_0_llp             (ch_0_llp             ),
`endif
	.ch_0_tts             (ch_0_tts             ),
	.ch_0_abt             (ch_0_abt             ),
	.ch_1_en              (ch_1_en              ),
	.ch_1_int_tc_mask     (ch_1_int_tc_mask     ),
	.ch_1_int_err_mask    (ch_1_int_err_mask    ),
	.ch_1_int_abt_mask    (ch_1_int_abt_mask    ),
	.ch_1_src_req_sel     (ch_1_src_req_sel     ),
	.ch_1_dst_req_sel     (ch_1_dst_req_sel     ),
	.ch_1_src_addr_ctl    (ch_1_src_addr_ctl    ),
	.ch_1_dst_addr_ctl    (ch_1_dst_addr_ctl    ),
	.ch_1_src_mode        (ch_1_src_mode        ),
	.ch_1_dst_mode        (ch_1_dst_mode        ),
	.ch_1_src_width       (ch_1_src_width       ),
	.ch_1_dst_width       (ch_1_dst_width       ),
	.ch_1_src_burst_size  (ch_1_src_burst_size  ),
	.ch_1_priority        (ch_1_priority        ),
	.ch_1_src_addr        (ch_1_src_addr        ),
	.ch_1_dst_addr        (ch_1_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_1_llp             (ch_1_llp             ),
`endif
	.ch_1_tts             (ch_1_tts             ),
	.ch_1_abt             (ch_1_abt             ),
	.ch_2_en              (ch_2_en              ),
	.ch_2_int_tc_mask     (ch_2_int_tc_mask     ),
	.ch_2_int_err_mask    (ch_2_int_err_mask    ),
	.ch_2_int_abt_mask    (ch_2_int_abt_mask    ),
	.ch_2_src_req_sel     (ch_2_src_req_sel     ),
	.ch_2_dst_req_sel     (ch_2_dst_req_sel     ),
	.ch_2_src_addr_ctl    (ch_2_src_addr_ctl    ),
	.ch_2_dst_addr_ctl    (ch_2_dst_addr_ctl    ),
	.ch_2_src_mode        (ch_2_src_mode        ),
	.ch_2_dst_mode        (ch_2_dst_mode        ),
	.ch_2_src_width       (ch_2_src_width       ),
	.ch_2_dst_width       (ch_2_dst_width       ),
	.ch_2_src_burst_size  (ch_2_src_burst_size  ),
	.ch_2_priority        (ch_2_priority        ),
	.ch_2_src_addr        (ch_2_src_addr        ),
	.ch_2_dst_addr        (ch_2_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_2_llp             (ch_2_llp             ),
`endif
	.ch_2_tts             (ch_2_tts             ),
	.ch_2_abt             (ch_2_abt             ),
	.ch_3_en              (ch_3_en              ),
	.ch_3_int_tc_mask     (ch_3_int_tc_mask     ),
	.ch_3_int_err_mask    (ch_3_int_err_mask    ),
	.ch_3_int_abt_mask    (ch_3_int_abt_mask    ),
	.ch_3_src_req_sel     (ch_3_src_req_sel     ),
	.ch_3_dst_req_sel     (ch_3_dst_req_sel     ),
	.ch_3_src_addr_ctl    (ch_3_src_addr_ctl    ),
	.ch_3_dst_addr_ctl    (ch_3_dst_addr_ctl    ),
	.ch_3_src_mode        (ch_3_src_mode        ),
	.ch_3_dst_mode        (ch_3_dst_mode        ),
	.ch_3_src_width       (ch_3_src_width       ),
	.ch_3_dst_width       (ch_3_dst_width       ),
	.ch_3_src_burst_size  (ch_3_src_burst_size  ),
	.ch_3_priority        (ch_3_priority        ),
	.ch_3_src_addr        (ch_3_src_addr        ),
	.ch_3_dst_addr        (ch_3_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_3_llp             (ch_3_llp             ),
`endif
	.ch_3_tts             (ch_3_tts             ),
	.ch_3_abt             (ch_3_abt             ),
	.ch_4_en              (ch_4_en              ),
	.ch_4_int_tc_mask     (ch_4_int_tc_mask     ),
	.ch_4_int_err_mask    (ch_4_int_err_mask    ),
	.ch_4_int_abt_mask    (ch_4_int_abt_mask    ),
	.ch_4_src_req_sel     (ch_4_src_req_sel     ),
	.ch_4_dst_req_sel     (ch_4_dst_req_sel     ),
	.ch_4_src_addr_ctl    (ch_4_src_addr_ctl    ),
	.ch_4_dst_addr_ctl    (ch_4_dst_addr_ctl    ),
	.ch_4_src_mode        (ch_4_src_mode        ),
	.ch_4_dst_mode        (ch_4_dst_mode        ),
	.ch_4_src_width       (ch_4_src_width       ),
	.ch_4_dst_width       (ch_4_dst_width       ),
	.ch_4_src_burst_size  (ch_4_src_burst_size  ),
	.ch_4_priority        (ch_4_priority        ),
	.ch_4_src_addr        (ch_4_src_addr        ),
	.ch_4_dst_addr        (ch_4_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_4_llp             (ch_4_llp             ),
`endif
	.ch_4_tts             (ch_4_tts             ),
	.ch_4_abt             (ch_4_abt             ),
	.ch_5_en              (ch_5_en              ),
	.ch_5_int_tc_mask     (ch_5_int_tc_mask     ),
	.ch_5_int_err_mask    (ch_5_int_err_mask    ),
	.ch_5_int_abt_mask    (ch_5_int_abt_mask    ),
	.ch_5_src_req_sel     (ch_5_src_req_sel     ),
	.ch_5_dst_req_sel     (ch_5_dst_req_sel     ),
	.ch_5_src_addr_ctl    (ch_5_src_addr_ctl    ),
	.ch_5_dst_addr_ctl    (ch_5_dst_addr_ctl    ),
	.ch_5_src_mode        (ch_5_src_mode        ),
	.ch_5_dst_mode        (ch_5_dst_mode        ),
	.ch_5_src_width       (ch_5_src_width       ),
	.ch_5_dst_width       (ch_5_dst_width       ),
	.ch_5_src_burst_size  (ch_5_src_burst_size  ),
	.ch_5_priority        (ch_5_priority        ),
	.ch_5_src_addr        (ch_5_src_addr        ),
	.ch_5_dst_addr        (ch_5_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_5_llp             (ch_5_llp             ),
`endif
	.ch_5_tts             (ch_5_tts             ),
	.ch_5_abt             (ch_5_abt             ),
	.ch_6_en              (ch_6_en              ),
	.ch_6_int_tc_mask     (ch_6_int_tc_mask     ),
	.ch_6_int_err_mask    (ch_6_int_err_mask    ),
	.ch_6_int_abt_mask    (ch_6_int_abt_mask    ),
	.ch_6_src_req_sel     (ch_6_src_req_sel     ),
	.ch_6_dst_req_sel     (ch_6_dst_req_sel     ),
	.ch_6_src_addr_ctl    (ch_6_src_addr_ctl    ),
	.ch_6_dst_addr_ctl    (ch_6_dst_addr_ctl    ),
	.ch_6_src_mode        (ch_6_src_mode        ),
	.ch_6_dst_mode        (ch_6_dst_mode        ),
	.ch_6_src_width       (ch_6_src_width       ),
	.ch_6_dst_width       (ch_6_dst_width       ),
	.ch_6_src_burst_size  (ch_6_src_burst_size  ),
	.ch_6_priority        (ch_6_priority        ),
	.ch_6_src_addr        (ch_6_src_addr        ),
	.ch_6_dst_addr        (ch_6_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_6_llp             (ch_6_llp             ),
`endif
	.ch_6_tts             (ch_6_tts             ),
	.ch_6_abt             (ch_6_abt             ),
	.ch_7_en              (ch_7_en              ),
	.ch_7_int_tc_mask     (ch_7_int_tc_mask     ),
	.ch_7_int_err_mask    (ch_7_int_err_mask    ),
	.ch_7_int_abt_mask    (ch_7_int_abt_mask    ),
	.ch_7_src_req_sel     (ch_7_src_req_sel     ),
	.ch_7_dst_req_sel     (ch_7_dst_req_sel     ),
	.ch_7_src_addr_ctl    (ch_7_src_addr_ctl    ),
	.ch_7_dst_addr_ctl    (ch_7_dst_addr_ctl    ),
	.ch_7_src_mode        (ch_7_src_mode        ),
	.ch_7_dst_mode        (ch_7_dst_mode        ),
	.ch_7_src_width       (ch_7_src_width       ),
	.ch_7_dst_width       (ch_7_dst_width       ),
	.ch_7_src_burst_size  (ch_7_src_burst_size  ),
	.ch_7_priority        (ch_7_priority        ),
	.ch_7_src_addr        (ch_7_src_addr        ),
	.ch_7_dst_addr        (ch_7_dst_addr        ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_7_llp             (ch_7_llp             ),
`endif
	.ch_7_tts             (ch_7_tts             ),
	.ch_7_abt             (ch_7_abt             ),
`ifdef DMAC_CONFIG_CH0
	.dma_ch_0_ctl_wen     (dma_ch_0_ctl_wen     ),
	.dma_ch_0_en_wen      (dma_ch_0_en_wen      ),
	.dma_ch_0_src_addr_wen(dma_ch_0_src_addr_wen),
	.dma_ch_0_dst_addr_wen(dma_ch_0_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_0_llp_wen     (dma_ch_0_llp_wen     ),
   `endif
	.dma_ch_0_tts_wen     (dma_ch_0_tts_wen     ),
	.dma_ch_0_tc_wen      (dma_ch_0_tc_wen      ),
	.dma_ch_0_err_wen     (dma_ch_0_err_wen     ),
	.dma_ch_0_int_wen     (dma_ch_0_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH1
	.dma_ch_1_ctl_wen     (dma_ch_1_ctl_wen     ),
	.dma_ch_1_en_wen      (dma_ch_1_en_wen      ),
	.dma_ch_1_src_addr_wen(dma_ch_1_src_addr_wen),
	.dma_ch_1_dst_addr_wen(dma_ch_1_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_1_llp_wen     (dma_ch_1_llp_wen     ),
   `endif
	.dma_ch_1_tts_wen     (dma_ch_1_tts_wen     ),
	.dma_ch_1_tc_wen      (dma_ch_1_tc_wen      ),
	.dma_ch_1_err_wen     (dma_ch_1_err_wen     ),
	.dma_ch_1_int_wen     (dma_ch_1_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH2
	.dma_ch_2_ctl_wen     (dma_ch_2_ctl_wen     ),
	.dma_ch_2_en_wen      (dma_ch_2_en_wen      ),
	.dma_ch_2_src_addr_wen(dma_ch_2_src_addr_wen),
	.dma_ch_2_dst_addr_wen(dma_ch_2_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_2_llp_wen     (dma_ch_2_llp_wen     ),
   `endif
	.dma_ch_2_tts_wen     (dma_ch_2_tts_wen     ),
	.dma_ch_2_tc_wen      (dma_ch_2_tc_wen      ),
	.dma_ch_2_err_wen     (dma_ch_2_err_wen     ),
	.dma_ch_2_int_wen     (dma_ch_2_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH3
	.dma_ch_3_ctl_wen     (dma_ch_3_ctl_wen     ),
	.dma_ch_3_en_wen      (dma_ch_3_en_wen      ),
	.dma_ch_3_src_addr_wen(dma_ch_3_src_addr_wen),
	.dma_ch_3_dst_addr_wen(dma_ch_3_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_3_llp_wen     (dma_ch_3_llp_wen     ),
   `endif
	.dma_ch_3_tts_wen     (dma_ch_3_tts_wen     ),
	.dma_ch_3_tc_wen      (dma_ch_3_tc_wen      ),
	.dma_ch_3_err_wen     (dma_ch_3_err_wen     ),
	.dma_ch_3_int_wen     (dma_ch_3_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH4
	.dma_ch_4_ctl_wen     (dma_ch_4_ctl_wen     ),
	.dma_ch_4_en_wen      (dma_ch_4_en_wen      ),
	.dma_ch_4_src_addr_wen(dma_ch_4_src_addr_wen),
	.dma_ch_4_dst_addr_wen(dma_ch_4_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_4_llp_wen     (dma_ch_4_llp_wen     ),
   `endif
	.dma_ch_4_tts_wen     (dma_ch_4_tts_wen     ),
	.dma_ch_4_tc_wen      (dma_ch_4_tc_wen      ),
	.dma_ch_4_err_wen     (dma_ch_4_err_wen     ),
	.dma_ch_4_int_wen     (dma_ch_4_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH5
	.dma_ch_5_ctl_wen     (dma_ch_5_ctl_wen     ),
	.dma_ch_5_en_wen      (dma_ch_5_en_wen      ),
	.dma_ch_5_src_addr_wen(dma_ch_5_src_addr_wen),
	.dma_ch_5_dst_addr_wen(dma_ch_5_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_5_llp_wen     (dma_ch_5_llp_wen     ),
   `endif
	.dma_ch_5_tts_wen     (dma_ch_5_tts_wen     ),
	.dma_ch_5_tc_wen      (dma_ch_5_tc_wen      ),
	.dma_ch_5_err_wen     (dma_ch_5_err_wen     ),
	.dma_ch_5_int_wen     (dma_ch_5_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH6
	.dma_ch_6_ctl_wen     (dma_ch_6_ctl_wen     ),
	.dma_ch_6_en_wen      (dma_ch_6_en_wen      ),
	.dma_ch_6_src_addr_wen(dma_ch_6_src_addr_wen),
	.dma_ch_6_dst_addr_wen(dma_ch_6_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_6_llp_wen     (dma_ch_6_llp_wen     ),
   `endif
	.dma_ch_6_tts_wen     (dma_ch_6_tts_wen     ),
	.dma_ch_6_tc_wen      (dma_ch_6_tc_wen      ),
	.dma_ch_6_err_wen     (dma_ch_6_err_wen     ),
	.dma_ch_6_int_wen     (dma_ch_6_int_wen     ),
`endif
`ifdef DMAC_CONFIG_CH7
	.dma_ch_7_ctl_wen     (dma_ch_7_ctl_wen     ),
	.dma_ch_7_en_wen      (dma_ch_7_en_wen      ),
	.dma_ch_7_src_addr_wen(dma_ch_7_src_addr_wen),
	.dma_ch_7_dst_addr_wen(dma_ch_7_dst_addr_wen),
   `ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_7_llp_wen     (dma_ch_7_llp_wen     ),
   `endif
	.dma_ch_7_tts_wen     (dma_ch_7_tts_wen     ),
	.dma_ch_7_tc_wen      (dma_ch_7_tc_wen      ),
	.dma_ch_7_err_wen     (dma_ch_7_err_wen     ),
	.dma_ch_7_int_wen     (dma_ch_7_int_wen     ),
`endif
	.dma_ch_ctl_wen       (dma_ch_ctl_wen       ),
	.dma_ch_en_wen        (dma_ch_en_wen        ),
	.dma_ch_src_addr_wen  (dma_ch_src_addr_wen  ),
	.dma_ch_dst_addr_wen  (dma_ch_dst_addr_wen  ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.dma_ch_llp_wen       (dma_ch_llp_wen       ),
`endif
	.dma_ch_tts_wen       (dma_ch_tts_wen       ),
	.dma_ch_tc_wen        (dma_ch_tc_wen        ),
	.dma_ch_err_wen       (dma_ch_err_wen       ),
	.dma_ch_int_wen       (dma_ch_int_wen       ),
	.dma_ch_src_ack       (dma_ch_src_ack       ),
	.dma_ch_dst_ack       (dma_ch_dst_ack       ),
	.ch_src_addr_ctl      (ch_src_addr_ctl      ),
	.ch_dst_addr_ctl      (ch_dst_addr_ctl      ),
	.ch_src_width         (ch_src_width         ),
	.ch_dst_width         (ch_dst_width         ),
	.ch_src_burst_size    (ch_src_burst_size    ),
	.ch_src_mode          (ch_src_mode          ),
	.ch_src_request       (ch_src_request       ),
	.ch_dst_mode          (ch_dst_mode          ),
	.ch_dst_request       (ch_dst_request       ),
	.ch_tts               (ch_tts               ),
	.ch_src_addr          (ch_src_addr          ),
	.ch_dst_addr          (ch_dst_addr          ),
`ifdef ATCDMAC100_CHAIN_TRANSFER_SUPPORT
	.ch_llp               (ch_llp               ),
`endif
	.ch_abt               (ch_abt               ),
	.ch_int_tc_mask       (ch_int_tc_mask       ),
	.ch_int_err_mask      (ch_int_err_mask      ),
	.ch_int_abt_mask      (ch_int_abt_mask      )
);

atcdmac100_arbiter atcdmac100_arbiter (
	.ch_request     (ch_request     ),
	.ch_level       (ch_level       ),
	.current_channel(current_channel),
	.granted_channel(granted_channel)
);

endmodule
