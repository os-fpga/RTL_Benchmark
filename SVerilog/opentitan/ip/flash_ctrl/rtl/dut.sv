

  

module flash_ctrl ();
  
	
	tlul_pkg::tl_h2d_t tl_fifo_h2d [2];

	
endmodule

module dut ();
  tlul_pkg::tl_d2h_t drsp_fifo_o;
  logic [5:0] hfifo_rspid;
  assign hfifo_rspid = drsp_fifo_o.d_source[8:3];
endmodule
