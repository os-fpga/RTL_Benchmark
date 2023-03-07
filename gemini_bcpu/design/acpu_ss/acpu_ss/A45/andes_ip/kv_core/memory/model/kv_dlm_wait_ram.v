// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dlm_wait_ram(
        	  lm_clk,
        	  lm_reset_n,
        	  dlm_a_addr,
        	  dlm_a_data,
        	  dlm_a_mask,
        	  dlm_a_opcode,
        	  dlm_a_size,
        	  dlm_a_user,
        	  dlm_a_valid,
        	  dlm_a_parity,
        	  dlm_a_ready,
        	  dlm_d_data,
        	  dlm_d_denied,
        	  dlm_d_ready,
        	  dlm_d_parity,
        	  dlm_d_valid
);
parameter DLM_RAM_AMSB = 11;
parameter DLM_RAM_DW   = 64;
parameter DLM_RAM_BWEW = 8;
parameter XLEN         = 64;

localparam DLM_RAM_ALSB = (XLEN == 64) ? 3 :
                          (XLEN == 32) ? 2 :
                                         1;
localparam DLM_RAM_AW   = DLM_RAM_AMSB - DLM_RAM_ALSB + 1;

localparam OUT_DELAY    = 0.1;

`ifdef NDS_DLM_WAIT_CYCLES
localparam DLM_WAIT_CYCLES = `NDS_DLM_WAIT_CYCLES;
`else
localparam DLM_WAIT_CYCLES = 1;
`endif

localparam FIFO_DW = XLEN;

input                                      lm_clk;
input                                      lm_reset_n;

input          [DLM_RAM_AMSB:DLM_RAM_ALSB] dlm_a_addr;
input                           [XLEN-1:0] dlm_a_data;
input                   [DLM_RAM_BWEW-1:0] dlm_a_mask;
input                                [2:0] dlm_a_opcode;
input                                [2:0] dlm_a_size;
input                                [1:0] dlm_a_user;
input                                      dlm_a_valid;
input                                [7:0] dlm_a_parity;
output                                     dlm_a_ready;

output                          [XLEN-1:0] dlm_d_data;
output                                     dlm_d_denied;
input                                      dlm_d_ready;
output                               [7:0] dlm_d_parity;
output                                     dlm_d_valid;

wire                                       ram_we     = dlm_a_opcode == 3'd1;
wire                    [DLM_RAM_BWEW-1:0] ram_bwe    = {DLM_RAM_BWEW{ram_we}} & dlm_a_mask;

wire                                       ram_cs     = dlm_a_valid;
wire                    [(DLM_RAM_AW-1):0] ram_addr   = dlm_a_addr;
wire                    [(DLM_RAM_DW-1):0] ram_wdata  = dlm_a_data;
wire                    [(DLM_RAM_DW-1):0] ram_rdata;

reg                                        ram_cs_d1;
wire                                       ram_cs_d1_nx;

wire                                       dlm_d_fifo_wvalid;
wire                                       dlm_d_fifo_rready;

nds_ram_model_bwe #(
        .ADDR_WIDTH (DLM_RAM_AW),
        .DATA_BYTE  (DLM_RAM_BWEW),
        .OUT_DELAY  (OUT_DELAY)
) ram_inst (
        .clk (lm_clk),
        .cs  (ram_cs),
        .bwe (ram_bwe),
        .addr(ram_addr),
        .din (ram_wdata),
        .dout(ram_rdata)
);


  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_1;
  wire               dlm_d_fifo_rvalid_1;
  wire               nds_unused_dlm_d_fifo_wready_1;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_1 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (ram_rdata                   ),
        .wvalid (dlm_d_fifo_wvalid           ),
        .wready (nds_unused_dlm_d_fifo_wready_1),
        .rdata  (dlm_d_fifo_rdata_1       ),
        .rvalid (dlm_d_fifo_rvalid_1      ),
        .rready (dlm_d_fifo_rready           )
    );
  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_2;
  wire               dlm_d_fifo_rvalid_2;
  wire               nds_unused_dlm_d_fifo_wready_2;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_2 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (dlm_d_fifo_rdata_1     ),
        .wvalid (dlm_d_fifo_rvalid_1    ),
        .wready (nds_unused_dlm_d_fifo_wready_2),
        .rdata  (dlm_d_fifo_rdata_2       ),
        .rvalid (dlm_d_fifo_rvalid_2      ),
        .rready (dlm_d_fifo_rready           )
    );
  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_3;
  wire               dlm_d_fifo_rvalid_3;
  wire               nds_unused_dlm_d_fifo_wready_3;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_3 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (dlm_d_fifo_rdata_2     ),
        .wvalid (dlm_d_fifo_rvalid_2    ),
        .wready (nds_unused_dlm_d_fifo_wready_3),
        .rdata  (dlm_d_fifo_rdata_3       ),
        .rvalid (dlm_d_fifo_rvalid_3      ),
        .rready (dlm_d_fifo_rready           )
    );
  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_4;
  wire               dlm_d_fifo_rvalid_4;
  wire               nds_unused_dlm_d_fifo_wready_4;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_4 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (dlm_d_fifo_rdata_3     ),
        .wvalid (dlm_d_fifo_rvalid_3    ),
        .wready (nds_unused_dlm_d_fifo_wready_4),
        .rdata  (dlm_d_fifo_rdata_4       ),
        .rvalid (dlm_d_fifo_rvalid_4      ),
        .rready (dlm_d_fifo_rready           )
    );
  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_5;
  wire               dlm_d_fifo_rvalid_5;
  wire               nds_unused_dlm_d_fifo_wready_5;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_5 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (dlm_d_fifo_rdata_4     ),
        .wvalid (dlm_d_fifo_rvalid_4    ),
        .wready (nds_unused_dlm_d_fifo_wready_5),
        .rdata  (dlm_d_fifo_rdata_5       ),
        .rvalid (dlm_d_fifo_rvalid_5      ),
        .rready (dlm_d_fifo_rready           )
    );
  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_6;
  wire               dlm_d_fifo_rvalid_6;
  wire               nds_unused_dlm_d_fifo_wready_6;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_6 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (dlm_d_fifo_rdata_5     ),
        .wvalid (dlm_d_fifo_rvalid_5    ),
        .wready (nds_unused_dlm_d_fifo_wready_6),
        .rdata  (dlm_d_fifo_rdata_6       ),
        .rvalid (dlm_d_fifo_rvalid_6      ),
        .rready (dlm_d_fifo_rready           )
    );
  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_7;
  wire               dlm_d_fifo_rvalid_7;
  wire               nds_unused_dlm_d_fifo_wready_7;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_7 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (dlm_d_fifo_rdata_6     ),
        .wvalid (dlm_d_fifo_rvalid_6    ),
        .wready (nds_unused_dlm_d_fifo_wready_7),
        .rdata  (dlm_d_fifo_rdata_7       ),
        .rvalid (dlm_d_fifo_rvalid_7      ),
        .rready (dlm_d_fifo_rready           )
    );
  wire [FIFO_DW-1:0] dlm_d_fifo_rdata_8;
  wire               dlm_d_fifo_rvalid_8;
  wire               nds_unused_dlm_d_fifo_wready_8;
    kv_fifo #(
        .DEPTH  (2                           ),
        .WIDTH  (FIFO_DW                     )
        ) u_dlm_d_fifo_8 (
        .clk    (lm_clk                      ),
        .reset_n(lm_reset_n                  ),
        .flush  (1'b0                        ),
        .wdata  (dlm_d_fifo_rdata_7     ),
        .wvalid (dlm_d_fifo_rvalid_7    ),
        .wready (nds_unused_dlm_d_fifo_wready_8),
        .rdata  (dlm_d_fifo_rdata_8       ),
        .rvalid (dlm_d_fifo_rvalid_8      ),
        .rready (dlm_d_fifo_rready           )
    );

assign dlm_a_ready  = 1'b1;

always @(posedge lm_clk or negedge lm_reset_n) begin
        if (!lm_reset_n)
                ram_cs_d1 <= 1'b0;
        else
                ram_cs_d1 <= ram_cs_d1_nx;
end

assign ram_cs_d1_nx = ram_cs;

assign dlm_d_fifo_wvalid   = ram_cs_d1;
assign dlm_d_fifo_rready   = dlm_d_ready;

assign dlm_d_denied = 1'b0;
assign dlm_d_parity = 8'b0;
assign dlm_d_data   = (DLM_WAIT_CYCLES == 0) ? ram_rdata
                    : (DLM_WAIT_CYCLES == 1) ? ram_rdata
                    : (DLM_WAIT_CYCLES == 2) ? dlm_d_fifo_rdata_1
                    : (DLM_WAIT_CYCLES == 3) ? dlm_d_fifo_rdata_2
                    : (DLM_WAIT_CYCLES == 4) ? dlm_d_fifo_rdata_3
                    : (DLM_WAIT_CYCLES == 5) ? dlm_d_fifo_rdata_4
                    : (DLM_WAIT_CYCLES == 6) ? dlm_d_fifo_rdata_5
                    : (DLM_WAIT_CYCLES == 7) ? dlm_d_fifo_rdata_6
                    : (DLM_WAIT_CYCLES == 8) ? dlm_d_fifo_rdata_7
                    : dlm_d_fifo_rdata_8
                    ;

assign dlm_d_valid =  (DLM_WAIT_CYCLES == 0) ? ram_cs_d1
                    : (DLM_WAIT_CYCLES == 1) ? ram_cs_d1
                    : (DLM_WAIT_CYCLES == 2) ? dlm_d_fifo_rvalid_1
                    : (DLM_WAIT_CYCLES == 3) ? dlm_d_fifo_rvalid_2
                    : (DLM_WAIT_CYCLES == 4) ? dlm_d_fifo_rvalid_3
                    : (DLM_WAIT_CYCLES == 5) ? dlm_d_fifo_rvalid_4
                    : (DLM_WAIT_CYCLES == 6) ? dlm_d_fifo_rvalid_5
                    : (DLM_WAIT_CYCLES == 7) ? dlm_d_fifo_rvalid_6
                    : (DLM_WAIT_CYCLES == 8) ? dlm_d_fifo_rvalid_7
                    : dlm_d_fifo_rvalid_8
                    ;

endmodule