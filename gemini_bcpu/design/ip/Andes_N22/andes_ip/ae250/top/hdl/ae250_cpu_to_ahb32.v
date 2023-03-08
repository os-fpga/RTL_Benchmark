// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


module ae250_cpu_to_ahb32 (
	  haddr,
	  hburst,
	  hclk,
	  hprot,
	  hrdata,
	  hready,
	  hresetn,
	  hresp,
	  hsize,
	  htrans,
	  hwdata,
	  hwrite,
	  us_haddr,
	  us_hburst,
	  us_hprot,
	  us_hrdata,
	  us_hready,
	  us_hresp,
	  us_hsize,
	  us_htrans,
	  us_hwdata,
	  us_hwrite
);

parameter BIU_ADDR_WIDTH = 32;
parameter BIU_DATA_WIDTH = 32;

output      [BIU_ADDR_WIDTH-1:0] haddr;
output                     [2:0] hburst;
input                            hclk;
output                     [3:0] hprot;
input                     [31:0] hrdata;
input                            hready;
input                            hresetn;
input                      [1:0] hresp;
output                     [2:0] hsize;
output                     [1:0] htrans;
output                    [31:0] hwdata;
output                           hwrite;
input       [BIU_ADDR_WIDTH-1:0] us_haddr;
input                      [2:0] us_hburst;
input                      [3:0] us_hprot;
output      [BIU_DATA_WIDTH-1:0] us_hrdata;
output                           us_hready;
output                     [1:0] us_hresp;
input                      [2:0] us_hsize;
input                      [1:0] us_htrans;
input       [BIU_DATA_WIDTH-1:0] us_hwdata;
input                            us_hwrite;


generate
if (BIU_DATA_WIDTH != 64) begin	: gen_ahb32_to_ahb32
	assign haddr       = us_haddr;
	assign hburst      = us_hburst;
	assign hprot       = us_hprot;
	assign hsize       = us_hsize;
	assign hwrite      = us_hwrite;
	assign hwdata      = us_hwdata;
	assign htrans      = us_htrans;

	assign us_hrdata = hrdata;
	assign us_hresp  = hresp;
	assign us_hready = hready;
end
else begin : gen_ahb64_to_ahb32_hresp1
	assign us_hresp[1] = 1'b0;
end
endgenerate

generate
if (BIU_DATA_WIDTH == 64) begin : gen_ahb64_to_ahb32

	atcsizedn100 #(
		.ADDR_WIDTH      (BIU_ADDR_WIDTH  ),
		.DS_DATA_WIDTH   (32              ),
		.US_DATA_WIDTH   (64              ),
		.WRITE_BUFFER_SUPPORT(1'b0               )
	) atcsizedn100 (
		.hclk        (hclk       ),
		.hresetn     (hresetn    ),
		.us_haddr    (us_haddr   ),
		.us_hburst   (us_hburst  ),
		.us_hprot    (us_hprot   ),
		.us_hsel     (1'b1       ),
		.us_hrdata   (us_hrdata  ),
		.us_hready   (us_hready  ),
		.us_hreadyout(us_hready  ),
		.us_hresp    (us_hresp[0]),
		.us_hsize    (us_hsize   ),
		.us_hwdata   (us_hwdata  ),
		.us_hwrite   (us_hwrite  ),
		.us_htrans   (us_htrans  ),
		.ds_haddr    (haddr      ),
		.ds_hburst   (hburst     ),
		.ds_hprot    (hprot      ),
		.ds_hrdata   (hrdata     ),
		.ds_hready   (hready     ),
		.ds_hresp    (hresp[0]   ),
		.ds_hsize    (hsize      ),
		.ds_hwdata   (hwdata     ),
		.ds_hwrite   (hwrite     ),
		.ds_htrans   (htrans     ),
		.bufw_err    (           )
	);

end
endgenerate

endmodule
