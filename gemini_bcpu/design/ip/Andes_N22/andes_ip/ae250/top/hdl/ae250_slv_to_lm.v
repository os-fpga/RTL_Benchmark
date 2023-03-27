// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary


module ae250_slv_to_lm (
	  hclk,
	  hresetn,
	  slv_hsel,
	  slv_hrdata,
	  slv_hready,
	  slv_hreadyout,
	  slv_hresp,
	  slv_haddr,
	  slv_hburst,
	  slv_hprot,
	  slv_hsize,
	  slv_htrans,
	  slv_hwdata,
	  slv_hwrite,
	  core_slv_hsel,
	  core_slv_huser,
	  core_slv_hrdata,
	  core_slv_hready,
	  core_slv_hreadyout,
	  core_slv_hresp,
	  core_slv_haddr,
	  core_slv_hburst,
	  core_slv_hprot,
	  core_slv_hsize,
	  core_slv_htrans,
	  core_slv_hwdata,
	  core_slv_hwrite
);

parameter BIU_ADDR_WIDTH = 32;
parameter BIU_DATA_WIDTH = 32;

input                            hclk;
input                            hresetn;
input                            slv_hsel;
output                    [31:0] slv_hrdata;
input                            slv_hready;
output                           slv_hreadyout;
output                     [1:0] slv_hresp;
input       [BIU_ADDR_WIDTH-1:0] slv_haddr;
input                      [2:0] slv_hburst;
input                      [3:0] slv_hprot;
input                      [2:0] slv_hsize;
input                      [1:0] slv_htrans;
input                     [31:0] slv_hwdata;
input                            slv_hwrite;
output                           core_slv_hsel;
output                           core_slv_huser;
input       [BIU_DATA_WIDTH-1:0] core_slv_hrdata;
output                           core_slv_hready;
input                            core_slv_hreadyout;
input                      [1:0] core_slv_hresp;
output      [BIU_ADDR_WIDTH-1:0] core_slv_haddr;
output                     [2:0] core_slv_hburst;
output                     [3:0] core_slv_hprot;
output                     [2:0] core_slv_hsize;
output                     [1:0] core_slv_htrans;
output      [BIU_DATA_WIDTH-1:0] core_slv_hwdata;
output                           core_slv_hwrite;


assign core_slv_huser  = slv_haddr[21];
assign core_slv_hsel   = slv_hsel;
assign core_slv_hready = slv_hready;
assign core_slv_hwrite = slv_hwrite;
assign core_slv_htrans = slv_htrans;
assign core_slv_hburst = slv_hburst;
assign core_slv_hprot  = slv_hprot;
assign core_slv_hsize  = slv_hsize;
assign core_slv_haddr  = slv_haddr;
assign slv_hreadyout   = core_slv_hreadyout;
assign slv_hresp       = core_slv_hresp;

generate
if (BIU_DATA_WIDTH == 32) begin : gen_hdata_64
	assign slv_hrdata      = core_slv_hrdata;
	assign core_slv_hwdata = slv_hwdata;
end
endgenerate

generate
if (BIU_DATA_WIDTH == 64) begin : gen_ahb32_to_ahb64

	atcsizeup100 #(
		.DS_DATA_WIDTH   (64              ),
		.US_DATA_WIDTH   (32              )
	) atcsizeup100 (
		.hclk        (hclk           ),
		.hresetn     (hresetn        ),
		.us_haddr_3_2(slv_haddr[3:2] ),
		.us_hsel     (slv_hsel       ),
		.us_hrdata   (slv_hrdata     ),
		.us_hready   (slv_hready     ),
		.us_hwdata   (slv_hwdata     ),
		.us_hwrite   (slv_hwrite     ),
		.us_htrans   (slv_htrans     ),
		.ds_hrdata   (core_slv_hrdata),
		.ds_hwdata   (core_slv_hwdata)
	);

end
endgenerate

endmodule
