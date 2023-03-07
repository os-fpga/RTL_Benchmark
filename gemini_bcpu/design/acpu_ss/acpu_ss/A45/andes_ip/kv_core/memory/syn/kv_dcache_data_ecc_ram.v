// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_dcache_data_ecc_ram (
    clk,
    dcache_data_rdata,
    dcache_data_wdata,
    dcache_data_cs,
    dcache_data_we,
    dcache_data_addr,
    dcache_data_ctrl_in,
    dcache_data_ctrl_out);

    parameter DCACHE_DATA_RAM_DW= 64;
    parameter DCACHE_DATA_RAM_AW= 11;
    parameter DCACHE_DATA_RAM_BWEW= 8;
    parameter DCACHE_DATA_RAM_CTRL_IN_WIDTH= 1;
    parameter DCACHE_DATA_RAM_CTRL_OUT_WIDTH= 1;
    localparam OUT_DELAY= 0.1;
    input clk;
    output [(DCACHE_DATA_RAM_DW-1):0] dcache_data_rdata ;
    input [(DCACHE_DATA_RAM_DW-1):0] dcache_data_wdata ;
    input dcache_data_cs;
    input dcache_data_we;
    input [(DCACHE_DATA_RAM_AW-1):0] dcache_data_addr ;
    input [(DCACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] dcache_data_ctrl_in ;
    output [(DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1):0] dcache_data_ctrl_out ;
wire nds_unused_clk = clk;
assign dcache_data_rdata = {((DCACHE_DATA_RAM_DW-1)+1){1'b0}};
wire [(DCACHE_DATA_RAM_DW-1):0] nds_unused_dcache_data_wdata = dcache_data_wdata;
wire nds_unused_dcache_data_cs = dcache_data_cs;
wire nds_unused_dcache_data_we = dcache_data_we;
wire [(DCACHE_DATA_RAM_AW-1):0] nds_unused_dcache_data_addr = dcache_data_addr;
wire [(DCACHE_DATA_RAM_CTRL_IN_WIDTH-1):0] nds_unused_dcache_data_ctrl_in = dcache_data_ctrl_in;
assign dcache_data_ctrl_out = {((DCACHE_DATA_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

endmodule 