// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"


module atcuart100 (
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
	  uclk,
	  urstn,
`endif
	  dma_rx_ack,
	  dma_tx_ack,
	  paddr,
	  pclk,
	  penable,
	  presetn,
	  psel,
	  pwdata,
	  pwrite,
	  uart_ctsn,
	  uart_dcdn,
	  uart_dsrn,
	  uart_rin,
	  uart_sin,
	  dma_rx_req,
	  dma_tx_req,
	  prdata,
	  uart_dtrn,
	  uart_intr,
	  uart_out1n,
	  uart_out2n,
	  uart_rtsn,
	  uart_sout
);

`ifdef ATCUART100_UCLK_PCLK_SAME
`else
input              uclk;
input              urstn;
`endif
input              dma_rx_ack;
input              dma_tx_ack;
input        [5:2] paddr;
input              pclk;
input              penable;
input              presetn;
input              psel;
input       [31:0] pwdata;
input              pwrite;
input              uart_ctsn;
input              uart_dcdn;
input              uart_dsrn;
input              uart_rin;
input              uart_sin;
output             dma_rx_req;
output             dma_tx_req;
output      [31:0] prdata;
output             uart_dtrn;
output             uart_intr;
output             uart_out1n;
output             uart_out2n;
output             uart_rtsn;
output             uart_sout;

`ifdef ATCUART100_UCLK_PCLK_SAME
wire               uclk;
wire               urstn;
`endif
wire               auto_rts;
wire               baud_initial;
wire               baud_mx;
wire         [7:0] dll_reg;
wire         [7:0] dlm_reg;
wire               dma_mode;
wire               fcr_rxfifo_rst;
wire               fcr_txfifo_rst;
wire               fifo_enable;
wire               framing_err;
wire               lcr_break;
wire               lcr_parity_enable;
wire               lcr_parity_even;
wire               lcr_parity_stick;
wire               lcr_stopbit;
wire         [1:0] lcr_wordlength;
wire               lsr_overrun;
wire               lsr_read;
wire               mcr_auto_flow;
wire               mcr_dtr;
wire               mcr_loop_mode;
wire               mcr_out1;
wire               mcr_out2;
wire               mcr_rts;
wire               msr_cts;
wire               msr_dcd;
wire               msr_dcts_wen;
wire               msr_ddcd_wen;
wire               msr_ddsr_wen;
wire               msr_dsr;
wire               msr_ri;
wire               msr_teri_wen;
wire         [4:1] oversample;
wire               parity_err;
wire               rx_active;
wire               rx_break;
wire               rx_dr_intr;
wire               rx_over_clr;
wire               rx_timeout_intr;
wire         [7:0] rxfifo_datain;
wire         [7:0] rxfifo_dataout;
wire               rxfifo_empty;
wire               rxfifo_empty_uclk;
wire               rxfifo_read;
wire               rxfifo_read_uclk;
wire         [1:0] rxfifo_threshold;
wire               rxfifo_write;
wire         [2:0] stfifo_dataout;
wire               stfifo_error;
wire               tx_active;
wire               tx_data_ready;
wire               tx_shift_empty;
wire         [7:0] txfifo_datain;
wire         [7:0] txfifo_dataout;
wire               txfifo_empty;
wire               txfifo_full;
wire               txfifo_read;
wire         [1:0] txfifo_threshold;
wire               txfifo_write;
wire               uart_auto_cts;
wire               uart_fifo_enable;
wire               uart_loop_mode;
wire               uart_rx_busy;
wire               uart_timeout_wen;
wire               uart_tx_busy;
wire               unloop_sout;

`ifdef ATCUART100_UCLK_PCLK_SAME
assign uclk  = pclk;
assign urstn = presetn;
`endif

atcuart100_apbif_reg u_apbif_reg (
	.pclk             (pclk             ),
	.presetn          (presetn          ),
	.psel             (psel             ),
	.penable          (penable          ),
	.paddr            (paddr            ),
	.pwdata           (pwdata           ),
	.pwrite           (pwrite           ),
	.prdata           (prdata           ),
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
	.uclk             (uclk             ),
	.urstn            (urstn            ),
`endif
	.rxfifo_dataout   (rxfifo_dataout   ),
	.rxfifo_read      (rxfifo_read      ),
	.txfifo_datain    (txfifo_datain    ),
	.txfifo_write     (txfifo_write     ),
	.dll_reg          (dll_reg          ),
	.dlm_reg          (dlm_reg          ),
	.rxfifo_threshold (rxfifo_threshold ),
	.txfifo_threshold (txfifo_threshold ),
	.dma_mode         (dma_mode         ),
	.fcr_txfifo_rst   (fcr_txfifo_rst   ),
	.fcr_rxfifo_rst   (fcr_rxfifo_rst   ),
	.uart_fifo_enable (uart_fifo_enable ),
	.fifo_enable      (fifo_enable      ),
	.mcr_auto_flow    (mcr_auto_flow    ),
	.mcr_loop_mode    (mcr_loop_mode    ),
	.mcr_out2         (mcr_out2         ),
	.mcr_out1         (mcr_out1         ),
	.mcr_rts          (mcr_rts          ),
	.mcr_dtr          (mcr_dtr          ),
	.rx_timeout_intr  (rx_timeout_intr  ),
	.tx_shift_empty   (tx_shift_empty   ),
	.txfifo_empty     (txfifo_empty     ),
	.txfifo_full      (txfifo_full      ),
	.lsr_overrun      (lsr_overrun      ),
	.rxfifo_empty     (rxfifo_empty     ),
	.rx_dr_intr       (rx_dr_intr       ),
	.msr_dcd          (msr_dcd          ),
	.msr_ri           (msr_ri           ),
	.msr_dsr          (msr_dsr          ),
	.msr_cts          (msr_cts          ),
	.msr_ddcd_wen     (msr_ddcd_wen     ),
	.msr_teri_wen     (msr_teri_wen     ),
	.msr_ddsr_wen     (msr_ddsr_wen     ),
	.msr_dcts_wen     (msr_dcts_wen     ),
	.baud_initial     (baud_initial     ),
	.oversample       (oversample       ),
	.lcr_break        (lcr_break        ),
	.lcr_parity_stick (lcr_parity_stick ),
	.lcr_parity_even  (lcr_parity_even  ),
	.lcr_parity_enable(lcr_parity_enable),
	.lcr_stopbit      (lcr_stopbit      ),
	.lcr_wordlength   (lcr_wordlength   ),
	.stfifo_dataout   (stfifo_dataout   ),
	.stfifo_error     (stfifo_error     ),
	.rx_over_clr      (rx_over_clr      ),
	.lsr_read         (lsr_read         ),
	.uart_intr        (uart_intr        )
);

atcuart100_modem u_modem (
	.pclk          (pclk          ),
	.presetn       (presetn       ),
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
	.uclk          (uclk          ),
	.urstn         (urstn         ),
`endif
	.uart_ctsn     (uart_ctsn     ),
	.uart_dsrn     (uart_dsrn     ),
	.uart_rin      (uart_rin      ),
	.uart_dcdn     (uart_dcdn     ),
	.uart_dtrn     (uart_dtrn     ),
	.uart_rtsn     (uart_rtsn     ),
	.uart_out1n    (uart_out1n    ),
	.uart_out2n    (uart_out2n    ),
	.mcr_auto_flow (mcr_auto_flow ),
	.mcr_loop_mode (mcr_loop_mode ),
	.mcr_out2      (mcr_out2      ),
	.mcr_out1      (mcr_out1      ),
	.mcr_rts       (mcr_rts       ),
	.mcr_dtr       (mcr_dtr       ),
	.msr_dcts_wen  (msr_dcts_wen  ),
	.msr_ddsr_wen  (msr_ddsr_wen  ),
	.msr_teri_wen  (msr_teri_wen  ),
	.msr_ddcd_wen  (msr_ddcd_wen  ),
	.msr_cts       (msr_cts       ),
	.msr_dsr       (msr_dsr       ),
	.msr_ri        (msr_ri        ),
	.msr_dcd       (msr_dcd       ),
	.auto_rts      (auto_rts      ),
	.uart_loop_mode(uart_loop_mode),
	.uart_auto_cts (uart_auto_cts )
);

atcuart100_baud u_baud (
	.uclk        (uclk        ),
	.urstn       (urstn       ),
	.baud_initial(baud_initial),
	.dll_reg     (dll_reg     ),
	.dlm_reg     (dlm_reg     ),
	.tx_active   (tx_active   ),
	.rx_active   (rx_active   ),
	.baud_mx     (baud_mx     )
);

atcuart100_txctrl u_txctrl (
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
	.uclk            (uclk            ),
	.urstn           (urstn           ),
`endif
	.pclk            (pclk            ),
	.presetn         (presetn         ),
	.fifo_enable     (fifo_enable     ),
	.dma_mode        (dma_mode        ),
	.txfifo_threshold(txfifo_threshold),
	.fcr_txfifo_rst  (fcr_txfifo_rst  ),
	.uart_auto_cts   (uart_auto_cts   ),
	.txfifo_datain   (txfifo_datain   ),
	.txfifo_write    (txfifo_write    ),
	.txfifo_empty    (txfifo_empty    ),
	.tx_shift_empty  (tx_shift_empty  ),
	.txfifo_full     (txfifo_full     ),
	.txfifo_dataout  (txfifo_dataout  ),
	.tx_data_ready   (tx_data_ready   ),
	.txfifo_read     (txfifo_read     ),
	.uart_tx_busy    (uart_tx_busy    ),
	.tx_active       (tx_active       ),
	.dma_tx_req      (dma_tx_req      ),
	.dma_tx_ack      (dma_tx_ack      )
);

atcuart100_rxctrl u_rxctrl (
	.uclk             (uclk             ),
	.urstn            (urstn            ),
	.pclk             (pclk             ),
	.presetn          (presetn          ),
	.fifo_enable      (fifo_enable      ),
	.dma_mode         (dma_mode         ),
	.rxfifo_threshold (rxfifo_threshold ),
	.fcr_rxfifo_rst   (fcr_rxfifo_rst   ),
	.auto_rts         (auto_rts         ),
	.rxfifo_dataout   (rxfifo_dataout   ),
	.rxfifo_read      (rxfifo_read      ),
	.rxfifo_empty     (rxfifo_empty     ),
	.lsr_overrun      (lsr_overrun      ),
	.stfifo_dataout   (stfifo_dataout   ),
	.stfifo_error     (stfifo_error     ),
	.rx_over_clr      (rx_over_clr      ),
	.lsr_read         (lsr_read         ),
	.parity_err       (parity_err       ),
	.framing_err      (framing_err      ),
	.rx_break         (rx_break         ),
	.rxfifo_datain    (rxfifo_datain    ),
	.rxfifo_write     (rxfifo_write     ),
	.uart_rx_busy     (uart_rx_busy     ),
	.uart_timeout_wen (uart_timeout_wen ),
	.rxfifo_empty_uclk(rxfifo_empty_uclk),
	.rxfifo_read_uclk (rxfifo_read_uclk ),
	.rx_active        (rx_active        ),
	.rx_dr_intr       (rx_dr_intr       ),
	.rx_timeout_intr  (rx_timeout_intr  ),
	.dma_rx_req       (dma_rx_req       ),
	.dma_rx_ack       (dma_rx_ack       )
);

atcuart100_uart_tx u_uart_tx (
	.uclk             (uclk             ),
	.urstn            (urstn            ),
	.baud_mx          (baud_mx          ),
	.uart_sout        (uart_sout        ),
	.unloop_sout      (unloop_sout      ),
	.txfifo_dataout   (txfifo_dataout   ),
	.tx_data_ready    (tx_data_ready    ),
	.txfifo_read      (txfifo_read      ),
	.uart_tx_busy     (uart_tx_busy     ),
	.uart_loop_mode   (uart_loop_mode   ),
	.oversample       (oversample       ),
	.lcr_break        (lcr_break        ),
	.lcr_parity_stick (lcr_parity_stick ),
	.lcr_parity_even  (lcr_parity_even  ),
	.lcr_parity_enable(lcr_parity_enable),
	.lcr_stopbit      (lcr_stopbit      ),
	.lcr_wordlength   (lcr_wordlength   )
);

atcuart100_uart_rx u_uart_rx (
	.uclk             (uclk             ),
	.urstn            (urstn            ),
	.baud_mx          (baud_mx          ),
	.uart_sin         (uart_sin         ),
	.unloop_sout      (unloop_sout      ),
	.rxfifo_datain    (rxfifo_datain    ),
	.rxfifo_write     (rxfifo_write     ),
	.uart_rx_busy     (uart_rx_busy     ),
	.parity_err       (parity_err       ),
	.framing_err      (framing_err      ),
	.rx_break         (rx_break         ),
	.uart_timeout_wen (uart_timeout_wen ),
	.uart_loop_mode   (uart_loop_mode   ),
	.uart_fifo_enable (uart_fifo_enable ),
	.rxfifo_empty_uclk(rxfifo_empty_uclk),
	.rxfifo_read_uclk (rxfifo_read_uclk ),
	.oversample       (oversample       ),
	.lcr_parity_stick (lcr_parity_stick ),
	.lcr_parity_even  (lcr_parity_even  ),
	.lcr_parity_enable(lcr_parity_enable),
	.lcr_stopbit      (lcr_stopbit      ),
	.lcr_wordlength   (lcr_wordlength   )
);

endmodule
