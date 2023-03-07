// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module nds_ecc_ram_model (
    clk,
    we,
    cs,
    addr,
    din,
    dout
);

parameter  WRITE_WIDTH      = 64;
parameter  ADDR_WIDTH       = 5;
parameter  IN_DELAY         = 0;
parameter  OUT_DELAY        = 0;
parameter  ENABLE           = "yes";

localparam MEM_SIZE         = 2 ** ADDR_WIDTH;
localparam DATA_WIDTH       = WRITE_WIDTH;
localparam TABLE_DEPTH      = 16;
localparam TABLE_ADDR_WIDTH = $clog2(TABLE_DEPTH);
localparam STORE_ADDR_WIDTH = ADDR_WIDTH - TABLE_ADDR_WIDTH;

input                         clk;
input                         we;
input                         cs;
input      [(ADDR_WIDTH-1):0] addr;
input     [(WRITE_WIDTH-1):0] din;
output    [(WRITE_WIDTH-1):0] dout;

// synthesis translate_off
wire      [(WRITE_WIDTH-1):0] p_dout;
reg       [(WRITE_WIDTH-1):0] mem[0:(MEM_SIZE-1)];
// synthesis translate_on
wire                          we_dly;
wire                          cs_dly;
wire       [(ADDR_WIDTH-1):0] addr_dly;
wire      [(WRITE_WIDTH-1):0] din_dly;

reg [(ADDR_WIDTH-1):0]        read_addr;

assign #(IN_DELAY) we_dly   = we;
assign #(IN_DELAY) cs_dly   = cs;
assign #(IN_DELAY) addr_dly = addr;
assign #(IN_DELAY) din_dly  = din;

always @(posedge clk) begin
    if (cs_dly) begin
        if (we_dly) begin
            // synthesis translate_off
            mem[addr_dly] <= din_dly;
            // synthesis translate_on
        end
    end
end

always @(posedge clk) begin
    if (cs_dly) begin
        if (we_dly)
            read_addr <= {ADDR_WIDTH{1'bx}};
        else
            read_addr <= addr_dly;
    end
end

// synthesis translate_off
`ifdef TEST_MEM_MACRO

assign p_dout               = mem[read_addr];
assign #(OUT_DELAY) dout    = p_dout;

`elsif DISABLE_RAND_ECC_INJECT

assign p_dout               = mem[read_addr];
assign #(OUT_DELAY) dout    = p_dout;























`else

assign p_dout = mem[read_addr];
assign #(OUT_DELAY) dout = p_dout;

`endif

`ifdef NDS_INTERNAL_SIM
initial begin
$display ("NDS_MEM_INFO:%m:ADDR_WIDTH = %2d", ADDR_WIDTH);
$display ("NDS_MEM_INFO:%m:DATA_WIDTH = %2d", WRITE_WIDTH);
$display ("NDS_MEM_INFO:%m:WE_WIDTH   = %2d", 1);
$display ("NDS_MEM_INFO:%m:ENABLE     = %3s", ENABLE);
end
`endif
// synthesis translate_on


endmodule
