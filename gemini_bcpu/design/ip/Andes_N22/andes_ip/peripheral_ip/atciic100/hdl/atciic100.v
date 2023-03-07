// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atciic100_config.vh"
`include "atciic100_const.vh"


module atciic100 (
	  i2c_int,
	  paddr,
	  penable,
	  prdata,
	  psel,
	  pwdata,
	  pwrite,
	  pclk,
	  presetn,
	  dma_ack,
	  dma_req,
	  scl_o,
	  sda_o,
	  scl_i,
	  sda_i
);

output             i2c_int;
input        [5:2] paddr;
input              penable;
output      [31:0] prdata;
input              psel;
input       [31:0] pwdata;
input              pwrite;
input              pclk;
input              presetn;
input              dma_ack;
output             dma_req;
output             scl_o;
output             sda_o;
input              scl_i;
input              sda_i;

wire                               [9:0] addr;
wire                                     addressing;
wire                                     clr_apb;
wire                               [8:0] datacnt;
wire                                     dma_en;
wire                                     do_ack;
wire                                     do_nack;
wire                                     iic_en;
wire                                     iic_rst;
wire                                     int_en_byterecv;
wire                                     int_st_cmpl;
wire                                     master;
wire                                     phase_P;
wire                                     phase_S;
wire                                     phase_adr;
wire                                     phase_dat;
wire                                     rd_apb;
wire                                     rdwt;
wire                               [4:0] t_hddat;
wire                               [9:0] t_high;
wire                               [9:0] t_low;
wire                               [2:0] t_sp;
wire                               [4:0] t_sudat;
wire                               [4:0] tpm;
wire                                     trans;
wire                                     wr_apb;
wire         [`ATCIIC100_DATA_WIDTH-1:0] wr_data_apb;
wire                                     addrhit_trig;
wire                                     arblose_trig;
wire                                     byterecv_trig;
wire                                     bytetrans_trig;
wire                                     clr_cntlr;
wire                                     cmpl_trig;
wire                               [8:0] nx_datacnt;
wire                                     nx_rdwt;
wire                                     rd_cntlr;
wire                                     slv_hit;
wire                                     st_ack;
wire                                     st_busbusy;
wire                                     st_gencall;
wire                                     start_cond;
wire                                     stop_cond;
wire                                     timing_parameter_scaling_pulse;
wire                                     wr_cntlr;
wire         [`ATCIIC100_DATA_WIDTH-1:0] wr_data_cntlr;
wire        [`ATCIIC100_INDEX_WIDTH-1:0] entries;
wire                                     fifo_empty;
wire                                     fifo_full;
wire                                     fifo_half_empty;
wire                                     fifo_half_full;
wire         [`ATCIIC100_DATA_WIDTH-1:0] rd_data;
wire                                     scl;
wire                                     scl_falling;
wire                                     scl_rising;
wire                                     sda;
wire                                     sda_falling;
wire                                     sda_rising;


atciic100_apbslv u_apbslv (
	.pclk           (pclk           ),
	.presetn        (presetn        ),
	.psel           (psel           ),
	.penable        (penable        ),
	.pwrite         (pwrite         ),
	.paddr          (paddr          ),
	.pwdata         (pwdata         ),
	.prdata         (prdata         ),
	.sda            (sda            ),
	.scl            (scl            ),
	.i2c_int        (i2c_int        ),
	.st_gencall     (st_gencall     ),
	.st_busbusy     (st_busbusy     ),
	.st_ack         (st_ack         ),
	.nx_rdwt        (nx_rdwt        ),
	.nx_datacnt     (nx_datacnt     ),
	.cmpl_trig      (cmpl_trig      ),
	.byterecv_trig  (byterecv_trig  ),
	.bytetrans_trig (bytetrans_trig ),
	.start_cond     (start_cond     ),
	.stop_cond      (stop_cond      ),
	.arblose_trig   (arblose_trig   ),
	.addrhit_trig   (addrhit_trig   ),
	.fifo_rd_data   (rd_data        ),
	.fifo_empty     (fifo_empty     ),
	.fifo_full      (fifo_full      ),
	.fifo_half_full (fifo_half_full ),
	.fifo_half_empty(fifo_half_empty),
	.slv_hit        (slv_hit        ),
	.addr           (addr           ),
	.int_en_byterecv(int_en_byterecv),
	.int_st_cmpl    (int_st_cmpl    ),
	.iic_rst        (iic_rst        ),
	.fifo_clr       (clr_apb        ),
	.do_ack         (do_ack         ),
	.do_nack        (do_nack        ),
	.trans          (trans          ),
	.fifo_wr        (wr_apb         ),
	.fifo_rd        (rd_apb         ),
	.fifo_wr_data   (wr_data_apb    ),
	.phase_S        (phase_S        ),
	.phase_adr      (phase_adr      ),
	.phase_dat      (phase_dat      ),
	.phase_P        (phase_P        ),
	.rdwt           (rdwt           ),
	.datacnt        (datacnt        ),
	.t_sp           (t_sp           ),
	.t_hddat        (t_hddat        ),
	.t_sudat        (t_sudat        ),
	.t_high         (t_high         ),
	.t_low          (t_low          ),
	.addressing     (addressing     ),
	.master         (master         ),
	.dma_en         (dma_en         ),
	.iic_en         (iic_en         ),
	.tpm            (tpm            )
);

atciic100_ctrl u_ctrl (
	.pclk                          (pclk           ),
	.presetn                       (presetn        ),
	.scl                           (scl            ),
	.sda                           (sda            ),
	.scl_falling                   (scl_falling    ),
	.scl_rising                    (scl_rising     ),
	.sda_falling                   (sda_falling    ),
	.sda_rising                    (sda_rising     ),
	.scl_o                         (scl_o          ),
	.sda_o                         (sda_o          ),
	.addr                          (addr           ),
	.int_en_byterecv               (int_en_byterecv),
	.iic_rst                       (iic_rst        ),
	.do_ack                        (do_ack         ),
	.do_nack                       (do_nack        ),
	.trans                         (trans          ),
	.phase_S                       (phase_S        ),
	.phase_adr                     (phase_adr      ),
	.phase_dat                     (phase_dat      ),
	.phase_P                       (phase_P        ),
	.rdwt                          (rdwt           ),
	.datacnt                       (datacnt        ),
	.t_hddat                       (t_hddat        ),
	.t_sudat                       (t_sudat        ),
	.t_high                        (t_high         ),
	.t_low                         (t_low          ),
	.dma_en                        (dma_en         ),
	.master                        (master         ),
	.addressing                    (addressing     ),
	.iic_en                        (iic_en         ),
	.dma_ack                       (dma_ack        ),
	.fifo_rd_data                  (rd_data        ),
	.fifo_full                     (fifo_full      ),
	.fifo_empty                    (fifo_empty     ),
	.fifo_entries                  (entries        ),
	.int_st_cmpl                   (int_st_cmpl    ),
	.tpm                           (tpm            ),
	.timing_parameter_scaling_pulse(timing_parameter_scaling_pulse),
	.dma_req                       (dma_req        ),
	.st_busbusy                    (st_busbusy     ),
	.st_ack                        (st_ack         ),
	.start_cond                    (start_cond     ),
	.stop_cond                     (stop_cond      ),
	.st_gencall                    (st_gencall     ),
	.nx_datacnt                    (nx_datacnt     ),
	.nx_rdwt                       (nx_rdwt        ),
	.cmpl_trig                     (cmpl_trig      ),
	.byterecv_trig                 (byterecv_trig  ),
	.bytetrans_trig                (bytetrans_trig ),
	.arblose_trig                  (arblose_trig   ),
	.addrhit_trig                  (addrhit_trig   ),
	.fifo_wr_data                  (wr_data_cntlr  ),
	.fifo_wr                       (wr_cntlr       ),
	.fifo_rd                       (rd_cntlr       ),
	.fifo_clr                      (clr_cntlr      ),
	.slv_hit                       (slv_hit        )
);

atciic100_fifo u_fifo (
	.clk          (pclk           ),
	.reset_n      (presetn        ),
	.wr_apb       (wr_apb         ),
	.wr_cntlr     (wr_cntlr       ),
	.rd_apb       (rd_apb         ),
	.rd_cntlr     (rd_cntlr       ),
	.clr_apb      (clr_apb        ),
	.clr_cntlr    (clr_cntlr      ),
	.wr_data_apb  (wr_data_apb    ),
	.wr_data_cntlr(wr_data_cntlr  ),
	.full         (fifo_full      ),
	.empty        (fifo_empty     ),
	.half_full    (fifo_half_full ),
	.half_empty   (fifo_half_empty),
	.entries      (entries        ),
	.rd_data      (rd_data        )
);

atciic100_gsf u_sda_gsf (
	.pclk                          (pclk       ),
	.presetn                       (presetn    ),
	.t_sp                          (t_sp       ),
	.I                             (sda_i      ),
	.timing_parameter_scaling_pulse(timing_parameter_scaling_pulse),
	.O                             (sda        ),
	.rising_edge                   (sda_rising ),
	.falling_edge                  (sda_falling)
);

atciic100_gsf u_scl_gsf (
	.pclk                          (pclk       ),
	.presetn                       (presetn    ),
	.t_sp                          (t_sp       ),
	.I                             (scl_i      ),
	.timing_parameter_scaling_pulse(timing_parameter_scaling_pulse),
	.O                             (scl        ),
	.rising_edge                   (scl_rising ),
	.falling_edge                  (scl_falling)
);

endmodule
