//    Copyright 2010 Andes Technology Corp. - All Rights Reserved.    //

module edm_tck_inv (edm_tck_n, edm_tck, test_mode);

output edm_tck_n;
input edm_tck;
input test_mode;

`ifdef SYNTHESIS

wire tck_buf;
wire tck_inv;

buf ckb_buf (tck_buf, edm_tck);
not ckb_inv (tck_inv, edm_tck);

assign edm_tck_n = test_mode ? /* synopsys infer_mux */ 
		tck_buf : tck_inv;

`else

assign edm_tck_n = test_mode ? edm_tck : ~edm_tck;

`endif
endmodule
