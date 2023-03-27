// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "ae350_config.vh"
`include "ae350_const.vh"

module ae350_rambrg_ram(
		  clk,
		  addr,
		  csb,
		  web,
		  din,
		  dout
);
parameter          ADDR_WIDTH=20;
parameter          DATA_WIDTH=64;

input                           clk;
input       [ADDR_WIDTH-1:0]	addr;
input				csb;
input	[(DATA_WIDTH/8)-1:0] 	web;
input       [DATA_WIDTH-1:0]	din;
output      [DATA_WIDTH-1:0]	dout;


`ifdef AE350_SRAM_1KB
generate
if (DATA_WIDTH==32) begin : gen_ram_1KB_dw_32
   ram256x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[7:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_1KB_dw_64
   ram128x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[6:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_1KB_dw_128
   ram64x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[5:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_1KB_dw_256
   ram32x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[4:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_2KB
generate
if (DATA_WIDTH==32) begin : gen_ram_2KB_dw_32
   ram512x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[8:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_2KB_dw_64
   ram256x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[7:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_2KB_dw_128
   ram128x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[6:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_2KB_dw_256
   ram64x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[5:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_4KB
generate
if (DATA_WIDTH==32) begin : gen_ram_4KB_dw_32
   ram1024x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[9:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_4KB_dw_64
   ram512x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[8:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_4KB_dw_128
   ram256x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[7:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_4KB_dw_256
   ram128x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[6:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_8KB
generate
if (DATA_WIDTH==32) begin : gen_ram_8KB_dw_32
   ram2048x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[10:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_8KB_dw_64
   ram1024x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[9:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_8KB_dw_128
   ram512x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[8:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_8KB_dw_256
   ram256x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[7:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_16KB
generate
if (DATA_WIDTH==32) begin : gen_ram_16KB_dw_32
   ram4096x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[11:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_16KB_dw_64
   ram2048x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[10:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_16KB_dw_128
   ram1024x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[9:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_16KB_dw_256
   ram512x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[8:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_32KB
generate
if (DATA_WIDTH==32) begin : gen_ram_32KB_dw_32
   ram8192x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[12:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_32KB_dw_64
   ram4096x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[11:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_32KB_dw_128
   ram2048x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[10:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_32KB_dw_256
   ram1024x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[9:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_64KB
generate
if (DATA_WIDTH==32) begin : gen_ram_64KB_dw_32
   ram16384x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[13:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_64KB_dw_64
   ram8192x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[12:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_64KB_dw_128
   ram4096x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[11:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_64KB_dw_256
   ram2048x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[10:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_128KB
generate
if (DATA_WIDTH==32) begin : gen_ram_128KB_dw_32
   ram32768x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[14:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_128KB_dw_64
   ram16384x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[13:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_128KB_dw_128
   ram8192x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[12:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_128KB_dw_256
   ram4096x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[11:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_256KB
generate
if (DATA_WIDTH==32) begin : gen_ram_256KB_dw_32
   ram65536x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[15:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_256KB_dw_64
   ram32768x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[14:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_256KB_dw_128
   ram16384x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[13:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_256KB_dw_256
   ram8192x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[12:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_512KB
generate
if (DATA_WIDTH==32) begin : gen_ram_512KB_dw_32
   ram131072x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[16:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_512KB_dw_64
   ram65536x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[15:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_512KB_dw_128
   ram32768x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[14:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_512KB_dw_256
   ram16384x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[13:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_1MB
generate
if (DATA_WIDTH==32) begin : gen_ram_1MB_dw_32
   ram262144x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[17:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_1MB_dw_64
   ram131072x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[16:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_1MB_dw_128
   ram65536x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[15:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_1MB_dw_256
   ram32768x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[14:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_2MB
generate
if (DATA_WIDTH==32) begin : gen_ram_2MB_dw_32
   ram524288x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[18:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_2MB_dw_64
   ram262144x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[17:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_2MB_dw_128
   ram131072x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[16:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_2MB_dw_256
   ram65536x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[15:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
`ifdef AE350_SRAM_4MB
generate
if (DATA_WIDTH==32) begin : gen_ram_4MB_dw_32
   ram1048576x32 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[19:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==64) begin : gen_ram_4MB_dw_64
   ram524288x64 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[18:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==128) begin : gen_ram_4MB_dw_128
   ram262144x128 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[17:0] ),
       .wea   (~web ),
       .douta ( dout));
end
if (DATA_WIDTH==256) begin : gen_ram_4MB_dw_256
   ram131072x256 mem (
       .clka  ( clk  ),
       .dina  ( din),
       .ena   (~csb ),
       .addra ( addr[16:0] ),
       .wea   (~web ),
       .douta ( dout));
end
endgenerate
`endif
endmodule

