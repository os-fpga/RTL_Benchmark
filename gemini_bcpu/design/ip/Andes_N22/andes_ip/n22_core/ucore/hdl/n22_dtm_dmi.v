
`include "global.inc"
    `ifdef N22_HAS_DEBUG_PRIVATE
module n22_dtm_dmi (
	  dmi_hresetn,
	  dmi_tap_hrdata,
	  dmi_tap_ack,
	  tap_dmi_req,
	  tap_dmi_data,
	  dmi_hclk,
	  dmi_hresp,
	  dmi_hready,
	  dmi_hrdata,
	  dmi_hreadyout,
	  dmi_haddr,
	  dmi_htrans,
	  dmi_hwrite,
	  dmi_hsize,
	  dmi_hburst,
	  dmi_hprot,
	  dmi_hwdata,
	  dmi_hsel
);

localparam  DMI_DATA_BITS  = 32;
localparam  DMI_ADDR_BITS  = 7;
localparam  DMI_OP_BITS    = 2;

localparam   HTRANS_IDLE         = 2'b00;
localparam   HTRANS_BUSY         = 2'b01;
localparam   HTRANS_NONSEQ       = 2'b10;
localparam   HTRANS_SEQ          = 2'b11;

localparam   HRESP_OK            = 1'b0;
localparam   HRESP_ERROR         = 1'b1;

localparam   DMI_OP_NOP          = 2'b00;
localparam   DMI_OP_READ         = 2'b01;
localparam   DMI_OP_WRITE        = 2'b10;
localparam   DMI_OP_RSV          = 2'b11;

localparam DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS;


input		dmi_hresetn;

output	[31:0]			dmi_tap_hrdata;
output				dmi_tap_ack;
input				tap_dmi_req;
input	[DMI_REG_BITS-1:0]	tap_dmi_data;

input		dmi_hclk;
input		dmi_hresp;
input		dmi_hready;
input	[31:0]	dmi_hrdata;
output		dmi_hreadyout;
output	[31:0]	dmi_haddr;
output	[1:0]	dmi_htrans;
output		dmi_hwrite;
output	[2:0]	dmi_hsize;
output	[2:0]	dmi_hburst;
output	[3:0]	dmi_hprot;
output	[31:0]	dmi_hwdata;
output		dmi_hsel;

wire	s0;

reg	[DMI_REG_BITS-1:0]	s1;

reg	[1:0]	dmi_htrans;
wire	[1:0]	s2;

reg	[31:0]	dmi_tap_hrdata;
reg		s3;

wire	s4;
wire	s5;
reg	dmi_tap_ack;


wire	[DMI_ADDR_BITS-1:0]	s6;

assign	s0 = dmi_hready & tap_dmi_req & ~dmi_tap_ack & ~s4 & (dmi_htrans == HTRANS_IDLE);
assign	s6	     = s1[DMI_REG_BITS-1:(DMI_DATA_BITS+DMI_OP_BITS)];

assign	dmi_haddr        = {{(30-DMI_ADDR_BITS){1'b0}}, s6, 2'b0};
assign	dmi_hwrite       = (s1[DMI_OP_BITS-1:0] == DMI_OP_WRITE);
assign	dmi_hreadyout    = dmi_hready;
assign	dmi_hsize        = 3'b010;
assign	dmi_hburst       = 3'b000;
assign	dmi_hprot        = 4'b0001;
assign	dmi_hwdata       = s1[(DMI_DATA_BITS+DMI_OP_BITS)-1:DMI_OP_BITS];
assign	dmi_hsel         = 1'b1;

assign	s2 = s0 ? HTRANS_NONSEQ : HTRANS_IDLE;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		dmi_htrans <= 2'b0;
	end
	else begin
		dmi_htrans <= s2;
	end
end

wire	s7;

assign	s7 = s0;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		s1 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s7) begin
		s1 <= tap_dmi_data;
	end
end

wire	s8;
wire	s9;
wire	s10;

assign	s8 = (dmi_htrans == HTRANS_NONSEQ);
assign	s9 = (s3 & dmi_hready) | ~tap_dmi_req;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		s3 <= 1'b0;
	end
	else if (s9) begin
		s3 <= 1'b0;
	end
	else if (s8) begin
		s3 <= 1'b1;
	end
end

assign	s10 = s4 & ~dmi_hwrite & (dmi_hresp == HRESP_OK);
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		dmi_tap_hrdata <= 32'd0;
	end
	else if (s10) begin
		dmi_tap_hrdata <= dmi_hrdata;
	end
end

assign	s4 = s3 & dmi_hready;
assign	s5 = ~tap_dmi_req;
always @(posedge dmi_hclk or negedge dmi_hresetn) begin
	if (!dmi_hresetn) begin
		dmi_tap_ack <= 1'b0;
	end
	else if (s5) begin
		dmi_tap_ack <= 1'b0;
	end
	else if (s4) begin
		dmi_tap_ack <= 1'b1;
	end

end


endmodule
`endif
