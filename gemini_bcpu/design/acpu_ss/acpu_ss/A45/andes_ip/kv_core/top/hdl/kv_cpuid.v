// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_cpuid(
		  csr_marchid,
		  csr_mimpid
);

parameter  CPUID            = 16'h0000;
parameter  MIMPID           = 32'h00000000;
parameter  XLEN		    = 32;

output            [XLEN-1:0] csr_marchid;
output            [XLEN-1:0] csr_mimpid;


wire             [XLEN-1:0] csr_marchid;
wire                 [15:0] csr_marchid_cpuid = CPUID;
wire             [XLEN-1:0] csr_mimpid;
wire                  [3:0] csr_mimpid_extension = MIMPID[3:0];
wire                  [3:0] csr_mimpid_minor     = MIMPID[7:4];
wire                 [23:0] csr_mimpid_major     = MIMPID[31:8];

assign csr_marchid[15:0]      = csr_marchid_cpuid;
assign csr_marchid[XLEN-2:16] = {(XLEN-2-16+1){1'b0}};
assign csr_marchid[XLEN-1]    = 1'b1;

assign csr_mimpid[3:0]        = csr_mimpid_extension;
assign csr_mimpid[7:4]        = csr_mimpid_minor;
assign csr_mimpid[31:8]       = csr_mimpid_major;

generate
if (XLEN == 64) begin : gen_mimpid_msb
	assign csr_mimpid[63:32] = 32'd0;
end
endgenerate


endmodule

