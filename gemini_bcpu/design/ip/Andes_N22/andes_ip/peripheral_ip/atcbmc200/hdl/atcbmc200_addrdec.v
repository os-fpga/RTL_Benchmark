// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcbmc200_config.vh"
`include "atcbmc200_const.vh"

module atcbmc200_addrdec(
                          	  base,
                          	  addr,
                          	  size,
                          	  dec_en,
                          	  sel
);

parameter ADDR_WIDTH = `ATCBMC200_ADDR_MSB + 1;
parameter BASE_ADDR_LSB = (ADDR_WIDTH == 24) ? 10 : 20;

localparam ADDR_MSB = ADDR_WIDTH - 1;

input [ADDR_MSB:BASE_ADDR_LSB]    base;
input [ADDR_MSB:0]                addr;
input [3:0]                       size;
input                             dec_en;

output                            sel;

generate
if (ADDR_WIDTH == 24) begin : gen_addr_width_24
reg [14:0] s0;

always @* begin
    case (size)
    4'h0: s0 = 15'b0_00_0000_0000_0000;
    4'h1: s0 = 15'b1_00_0000_0000_0000;
    4'h2: s0 = 15'b1_00_0000_0000_0001;
    4'h3: s0 = 15'b1_00_0000_0000_0011;
    4'h4: s0 = 15'b1_00_0000_0000_0111;
    4'h5: s0 = 15'b1_00_0000_0000_1111;
    4'h6: s0 = 15'b1_00_0000_0001_1111;
    4'h7: s0 = 15'b1_00_0000_0011_1111;
    4'h8: s0 = 15'b1_00_0000_0111_1111;
    4'h9: s0 = 15'b1_00_0000_1111_1111;
    4'hA: s0 = 15'b1_00_0001_1111_1111;
    4'hB: s0 = 15'b1_00_0011_1111_1111;
    4'hC: s0 = 15'b1_00_0111_1111_1111;
    4'hD: s0 = 15'b1_00_1111_1111_1111;
    4'hE: s0 = 15'b1_01_1111_1111_1111;
    4'hF: s0 = 15'b1_11_1111_1111_1111;
    endcase
end

assign sel = dec_en & s0[14] & ((addr[23] == base[23]) | s0[13]) &
                                 ((addr[22] == base[22]) | s0[12]) &
                                 ((addr[21] == base[21]) | s0[11]) &
                                 ((addr[20] == base[20]) | s0[10]) &
                                 ((addr[19] == base[19]) | s0[9])  &
                                 ((addr[18] == base[18]) | s0[8])  &
                                 ((addr[17] == base[17]) | s0[7])  &
                                 ((addr[16] == base[16]) | s0[6])  &
                                 ((addr[15] == base[15]) | s0[5])  &
                                 ((addr[14] == base[14]) | s0[4])  &
                                 ((addr[13] == base[13]) | s0[3])  &
                                 ((addr[12] == base[12]) | s0[2])  &
                                 ((addr[11] == base[11]) | s0[1])  &
                                 ((addr[10] == base[10]) | s0[0]);

end else begin : gen_addr_width_other
reg [12:0] s0;

always @* begin
    case (size)
    4'h0:    s0 = 13'b0_0000_0000_0000;
    4'h1:    s0 = 13'b1_0000_0000_0000;
    4'h2:    s0 = 13'b1_0000_0000_0001;
    4'h3:    s0 = 13'b1_0000_0000_0011;
    4'h4:    s0 = 13'b1_0000_0000_0111;
    4'h5:    s0 = 13'b1_0000_0000_1111;
    4'h6:    s0 = 13'b1_0000_0001_1111;
    4'h7:    s0 = 13'b1_0000_0011_1111;
    4'h8:    s0 = 13'b1_0000_0111_1111;
    4'h9:    s0 = 13'b1_0000_1111_1111;
    4'hA:    s0 = 13'b1_0001_1111_1111;
    4'hB:    s0 = 13'b1_0011_1111_1111;
    4'hC:    s0 = 13'b1_0111_1111_1111;
`ifdef ATCBMC200_PRIORITY_DECODE
    4'hD:    s0 = 13'b1_1111_1111_1111;
`endif
    default: s0 = 13'b0_0000_0000_0000;
    endcase
end

assign sel = dec_en & s0[12] & ((addr[31] == base[31]) | s0[11]) &
                                 ((addr[30] == base[30]) | s0[10]) &
                                 ((addr[29] == base[29]) | s0[9])  &
                                 ((addr[28] == base[28]) | s0[8])  &
                                 ((addr[27] == base[27]) | s0[7])  &
                                 ((addr[26] == base[26]) | s0[6])  &
                                 ((addr[25] == base[25]) | s0[5])  &
                                 ((addr[24] == base[24]) | s0[4])  &
                                 ((addr[23] == base[23]) | s0[3])  &
                                 ((addr[22] == base[22]) | s0[2])  &
                                 ((addr[21] == base[21]) | s0[1])  &
                                 ((addr[20] == base[20]) | s0[0]);

end
endgenerate

endmodule

