// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_icache_data_ecc_ram (
    clk,
    icache_data_rdata,
    icache_data_wdata,
    icache_data_cs,
    icache_data_we,
    icache_data_addr,
    icache_data_ctrl_in,
    icache_data_ctrl_out);

    parameter ICACHE_DATA_RAM_DW= 64;
    parameter ICACHE_DATA_RAM_AW= 11;
    parameter ICACHE_DATA_RAM_CTRL_IN_WIDTH= 1;
    parameter ICACHE_DATA_RAM_CTRL_OUT_WIDTH= 1;
    localparam OUT_DELAY= 0.1;
    input clk;
    output [(ICACHE_DATA_RAM_DW-1):0] icache_data_rdata ;
    input [(ICACHE_DATA_RAM_DW-1):0] icache_data_wdata ;
    input icache_data_cs;
    input icache_data_we;
    input [(ICACHE_DATA_RAM_AW-1):0] icache_data_addr ;
    input [(ICACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] icache_data_ctrl_in ;
    output [(ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] icache_data_ctrl_out ;
wire nds_unused_clk = clk;
assign icache_data_rdata = {((ICACHE_DATA_RAM_DW-1)+1){1'b0}};
wire [(ICACHE_DATA_RAM_DW-1):0] nds_unused_icache_data_wdata = icache_data_wdata;
wire nds_unused_icache_data_cs = icache_data_cs;
wire nds_unused_icache_data_we = icache_data_we;
wire [(ICACHE_DATA_RAM_AW-1):0] nds_unused_icache_data_addr = icache_data_addr;
wire [(ICACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] nds_unused_icache_data_ctrl_in = icache_data_ctrl_in;
assign icache_data_ctrl_out = {((ICACHE_DATA_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

endmodule
