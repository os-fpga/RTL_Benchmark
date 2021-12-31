

module malloc_core_infer
#(
    parameter DWIDTH_A = 4,
    parameter DWIDTH_B = 1,
    parameter AWIDTH_A = 9,
    parameter AWIDTH_B = 11 
)
(
    input clka,
    input wea,
    input [AWIDTH_A-1:0] addra,
    input [DWIDTH_A-1:0] dina,
    //output [DWIDTH_A-1:0] douta,

    input clkb,
    input rstb,
    input web,
    input [AWIDTH_B-1:0] addrb,
    input [DWIDTH_B-1:0] dinb,
    output [DWIDTH_A-1:0] doutb
);
`include "c_functions.v"
localparam PORT_RATIO = (DWIDTH_A/DWIDTH_B);
localparam LOW_ADDR_WIDTH = clogb(PORT_RATIO);

wire [PORT_RATIO-1:0] enb;

c_decode
#(
    .num_ports(PORT_RATIO)
)
ram_sel
(
    .data_in(addrb[LOW_ADDR_WIDTH-1:0]),
    .data_out(enb)
);

genvar i;
generate
    for(i=0;i<PORT_RATIO;i=i+1)begin:WRITE_PORT_A
        infer_ram_wt
        #(
            .DWIDTH(DWIDTH_B),
            .AWIDTH(AWIDTH_A)
        )
        bit_vec
        (
            .clk_a(clka),
            .clk_b(clkb),

            .en_a(wea),
            .write_a(wea),
            .din_a(dina[(i+1)*DWIDTH_B-1:i*DWIDTH_B]),
            .addr_a(addra),
            .dout_a(),

            .en_b(enb[i]),
            .write_b(web),
            .addr_b(addrb[AWIDTH_B-1:LOW_ADDR_WIDTH]),
            .din_b(dinb),
            .dout_b(doutb[(i+1)*DWIDTH_B-1:i*DWIDTH_B])
        );
    end
endgenerate

endmodule
