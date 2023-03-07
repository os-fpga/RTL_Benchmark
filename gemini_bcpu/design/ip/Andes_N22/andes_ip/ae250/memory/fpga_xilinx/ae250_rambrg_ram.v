// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_config.vh"
`include "ae250_const.vh"

module ae250_rambrg_ram(
		  clk,
		  rambrg_ram_addr,
		  rambrg_ram_csb,
		  rambrg_ram_web,
		  rambrg_ram_wdata,
		  rambrg_ram_rdata
);
parameter          RAMBRG_RAM_ADDR_WIDTH=20;
parameter          RAMBRG_RAM_DATA_WIDTH=32;

input                                   clk;
input       [RAMBRG_RAM_ADDR_WIDTH-1:0]	rambrg_ram_addr;
input					rambrg_ram_csb;
input	[(RAMBRG_RAM_DATA_WIDTH/8)-1:0] rambrg_ram_web;
input       [RAMBRG_RAM_DATA_WIDTH-1:0]	rambrg_ram_wdata;
output      [RAMBRG_RAM_DATA_WIDTH-1:0]	rambrg_ram_rdata;


`ifdef AE250_SRAM_1KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_1KB_dw_32
   ram256x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_1KB_dw_64
   ram128x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[6:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_1KB_dw_128
   ram64x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[5:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_1KB_dw_256
   ram32x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[4:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_2KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_2KB_dw_32
   ram512x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_2KB_dw_64
   ram256x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_2KB_dw_128
   ram128x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[6:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_2KB_dw_256
   ram64x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[5:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_4KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_4KB_dw_32
   ram1024x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_4KB_dw_64
   ram512x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_4KB_dw_128
   ram256x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_4KB_dw_256
   ram128x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[6:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_8KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_8KB_dw_32
   ram2048x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_8KB_dw_64
   ram1024x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_8KB_dw_128
   ram512x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_8KB_dw_256
   ram256x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_16KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_16KB_dw_32
   ram4096x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_16KB_dw_64
   ram2048x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_16KB_dw_128
   ram1024x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_16KB_dw_256
   ram512x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_32KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_32KB_dw_32
   ram8192x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_32KB_dw_64
   ram4096x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_32KB_dw_128
   ram2048x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_32KB_dw_256
   ram1024x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_64KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_64KB_dw_32
   ram16384x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_64KB_dw_64
   ram8192x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_64KB_dw_128
   ram4096x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_64KB_dw_256
   ram2048x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_128KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_128KB_dw_32
   ram32768x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_128KB_dw_64
   ram16384x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_128KB_dw_128
   ram8192x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_128KB_dw_256
   ram4096x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_256KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_256KB_dw_32
   ram65536x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_256KB_dw_64
   ram32768x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_256KB_dw_128
   ram16384x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_256KB_dw_256
   ram8192x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_512KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_512KB_dw_32
   ram131072x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_512KB_dw_64
   ram65536x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_512KB_dw_128
   ram32768x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_512KB_dw_256
   ram16384x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_1MB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_1MB_dw_32
   ram262144x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[17:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_1MB_dw_64
   ram131072x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_1MB_dw_128
   ram65536x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_1MB_dw_256
   ram32768x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_2MB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_2MB_dw_32
   ram524288x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[18:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_2MB_dw_64
   ram262144x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[17:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_2MB_dw_128
   ram131072x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_2MB_dw_256
   ram65536x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif
`ifdef AE250_SRAM_4MB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_4MB_dw_32
   ram1048576x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[19:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_4MB_dw_64
   ram524288x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[18:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_4MB_dw_128
   ram262144x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[17:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_4MB_dw_256
   ram131072x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   (~rambrg_ram_csb ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata));
end
endgenerate
`endif

endmodule

