// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_icache_tag_par_ram (
    clk,
    icache_tag_cs,
    icache_tag_addr,
    icache_tag_rdata,
    icache_tag_wdata,
    icache_tag_we,
    icache_tag_ctrl_in,
    icache_tag_ctrl_out);

    parameter ICACHE_TAG_RAM_DW= 19;
    parameter ICACHE_TAG_RAM_AW= 9;
    parameter ICACHE_TAG_RAM_CTRL_IN_WIDTH= 1;
    parameter ICACHE_TAG_RAM_CTRL_OUT_WIDTH= 1;
    localparam OUT_DELAY= 0.1;
    localparam ICACHE_TAG_ECC_DW= (ICACHE_TAG_RAM_DW-8>32)? 8: 4;
    localparam NO_ECC_TAG_DW= ICACHE_TAG_RAM_DW-ICACHE_TAG_ECC_DW;
    localparam ICACHE_LOCK_BIT= NO_ECC_TAG_DW-2;
    localparam ICACHE_LOCK_DUP_BIT= NO_ECC_TAG_DW-3;
    input clk;
    input icache_tag_cs;
    input [(ICACHE_TAG_RAM_AW-1):0] icache_tag_addr ;
    output [(ICACHE_TAG_RAM_DW-1):0] icache_tag_rdata ;
    input [(ICACHE_TAG_RAM_DW-1):0] icache_tag_wdata ;
    input icache_tag_we;
    input [(ICACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] icache_tag_ctrl_in ;
    output [(ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1):0] icache_tag_ctrl_out ;
`ifdef TEST_MEM_MACRO


`else
`endif

wire nds_unused_clk = clk;
wire nds_unused_icache_tag_cs = icache_tag_cs;
wire [(ICACHE_TAG_RAM_AW-1):0] nds_unused_icache_tag_addr = icache_tag_addr;
assign icache_tag_rdata = {((ICACHE_TAG_RAM_DW-1)+1){1'b0}};
wire [(ICACHE_TAG_RAM_DW-1):0] nds_unused_icache_tag_wdata = icache_tag_wdata;
wire nds_unused_icache_tag_we = icache_tag_we;
wire [(ICACHE_TAG_RAM_CTRL_IN_WIDTH-1):0] nds_unused_icache_tag_ctrl_in = icache_tag_ctrl_in;
assign icache_tag_ctrl_out = {((ICACHE_TAG_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

endmodule 