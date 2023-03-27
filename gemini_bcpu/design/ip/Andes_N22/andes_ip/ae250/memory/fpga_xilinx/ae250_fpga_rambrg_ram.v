// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_config.vh"
`include "ae250_const.vh"

module ae250_fpga_rambrg_ram(
		  clk,
		  hresetn,
		  rambrg_ram_addr,
		  rambrg_ram_csb,
		  rambrg_ram_web,
		  rambrg_ram_wdata,
		  rambrg_ram_rdata
);
parameter          RAMBRG_RAM_ADDR_WIDTH=20;
parameter          RAMBRG_RAM_DATA_WIDTH=32;

input                                   clk;
input                                   hresetn;
input       [RAMBRG_RAM_ADDR_WIDTH-1:0]	rambrg_ram_addr;
input					rambrg_ram_csb;
input	[(RAMBRG_RAM_DATA_WIDTH/8)-1:0] rambrg_ram_web;
input       [RAMBRG_RAM_DATA_WIDTH-1:0]	rambrg_ram_wdata;
output      [RAMBRG_RAM_DATA_WIDTH-1:0]	rambrg_ram_rdata;
reg    high_part_all_zero_d1;
wire    high_part_all_zero;
always @(posedge clk or negedge hresetn) begin
        if (!hresetn)
            high_part_all_zero_d1 <= 1'b0;
        else
            high_part_all_zero_d1 <= high_part_all_zero;
end


`ifdef AE250_SRAM_1KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_1KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:8] == 12'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram256x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_1KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:7] == 13'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram128x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[6:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_1KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:6] == 14'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram64x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[5:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_1KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:5] == 15'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram32x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[4:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_2KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_2KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:9] == 11'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram512x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_2KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:8] == 12'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram256x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_2KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:7] == 13'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram128x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[6:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_2KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:6] == 14'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram64x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[5:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_4KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_4KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:10] == 10'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram1024x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_4KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:9] == 11'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram512x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_4KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:8] == 12'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram256x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_4KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:7] == 13'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram128x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[6:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_8KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_8KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:11] == 9'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram2048x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_8KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:10] == 10'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram1024x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_8KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:9] == 11'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram512x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_8KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:8] == 12'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram256x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[7:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_16KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_16KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:12] == 8'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram4096x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_16KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:11] == 9'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram2048x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_16KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:10] == 10'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram1024x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_16KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:9] == 11'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram512x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[8:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_32KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_32KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:13] == 7'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram8192x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_32KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:12] == 8'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram4096x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_32KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:11] == 9'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram2048x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_32KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:10] == 10'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram1024x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[9:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_64KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_64KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:14] == 6'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram16384x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_64KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:13] == 7'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram8192x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_64KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:12] == 8'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram4096x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_64KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:11] == 9'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram2048x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[10:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_128KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_128KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:15] == 5'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram32768x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_128KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:14] == 6'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram16384x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_128KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:13] == 7'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram8192x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_128KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:12] == 8'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram4096x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[11:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_256KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_256KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:16] == 4'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram65536x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_256KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:15] == 5'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram32768x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_256KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:14] == 6'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram16384x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_256KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:13] == 7'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram8192x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[12:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_512KB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_512KB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:17] == 3'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram131072x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_512KB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:16] == 4'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram65536x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_512KB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:15] == 5'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram32768x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_512KB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:14] == 6'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram16384x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[13:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_1MB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_1MB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:18] == 2'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram262144x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[17:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_1MB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:17] == 3'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram131072x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_1MB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:16] == 4'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram65536x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_1MB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:15] == 5'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram32768x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[14:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_2MB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_2MB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:19] == 1'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram524288x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[18:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_2MB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:18] == 2'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram262144x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[17:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_2MB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:17] == 3'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram131072x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_2MB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:16] == 4'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram65536x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[15:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif
`ifdef AE250_SRAM_4MB
generate
if (RAMBRG_RAM_DATA_WIDTH==32) begin : gen_ram_4MB_dw_32
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:20] == 0'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram1048576x32 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[19:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==64) begin : gen_ram_4MB_dw_64
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:19] == 1'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram524288x64 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[18:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==128) begin : gen_ram_4MB_dw_128
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:18] == 2'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram262144x128 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[17:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
if (RAMBRG_RAM_DATA_WIDTH==256) begin : gen_ram_4MB_dw_256
   assign high_part_all_zero = rambrg_ram_addr[RAMBRG_RAM_ADDR_WIDTH-1:17] == 3'h0;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_ori;
   wire [RAMBRG_RAM_DATA_WIDTH-1:0] rambrg_ram_rdata_wrap;
   wire enable_ori = (~rambrg_ram_csb) & high_part_all_zero;
   wire enable_wrap = (~rambrg_ram_csb) & !high_part_all_zero;
   assign rambrg_ram_rdata = (high_part_all_zero_d1)?rambrg_ram_rdata_ori:rambrg_ram_rdata_wrap;
   ram131072x256 mem (
       .clka  ( clk  ),
       .dina  ( rambrg_ram_wdata),
       .ena   ( enable_ori ),
       .addra ( rambrg_ram_addr[16:0] ),
       .wea   (~rambrg_ram_web ),
       .douta ( rambrg_ram_rdata_ori));
  ram8192x32 mem_32KB (
     .clka  ( clk  ),
     .dina  ( rambrg_ram_wdata),
     .ena   ( enable_wrap ),
     .addra ( rambrg_ram_addr[12:0] ),
     .wea   (~rambrg_ram_web ),
     .douta ( rambrg_ram_rdata_wrap));
end
endgenerate
`endif

endmodule

