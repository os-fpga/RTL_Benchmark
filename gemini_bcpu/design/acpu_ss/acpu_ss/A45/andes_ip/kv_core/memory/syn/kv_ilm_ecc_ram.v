// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module kv_ilm_ecc_ram (
    clk,
    ilm_cs,
    ilm_we,
    ilm_addr,
    ilm_wdata,
    ilm_rdata,
    ilm_ctrl_in,
    ilm_ctrl_out);

    parameter ILM_RAM_AW= 11;
    parameter ILM_RAM_DW= 64;
    parameter ILM_RAM_CTRL_IN_WIDTH= 1;
    parameter ILM_RAM_CTRL_OUT_WIDTH= 1;
    localparam OUT_DELAY= 0.1;
    localparam IN_DELAY= 0.1;
    input clk;
    input ilm_cs;
    input ilm_we;
    input [(ILM_RAM_AW-1):0] ilm_addr ;
    input [(ILM_RAM_DW-1):0] ilm_wdata ;
    output [(ILM_RAM_DW-1):0] ilm_rdata ;
    input [(ILM_RAM_CTRL_IN_WIDTH-1):0] ilm_ctrl_in ;
    output [(ILM_RAM_CTRL_OUT_WIDTH-1):0] ilm_ctrl_out ;
wire nds_unused_clk = clk;
wire nds_unused_ilm_cs = ilm_cs;
wire nds_unused_ilm_we = ilm_we;
wire [(ILM_RAM_AW-1):0] nds_unused_ilm_addr = ilm_addr;
wire [(ILM_RAM_DW-1):0] nds_unused_ilm_wdata = ilm_wdata;
assign ilm_rdata = {((ILM_RAM_DW-1)+1){1'b0}};
wire [(ILM_RAM_CTRL_IN_WIDTH-1):0] nds_unused_ilm_ctrl_in = ilm_ctrl_in;
assign ilm_ctrl_out = {((ILM_RAM_CTRL_OUT_WIDTH-1)+1){1'b0}};

endmodule 