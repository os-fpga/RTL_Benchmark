// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_pma2axcache (
    c2nc,
    pma_mtype,
    arcache,
    awcache
);
input c2nc;
input [3:0] pma_mtype;
output [3:0] arcache;
output [3:0] awcache;


reg [3:0] arcache;
reg [3:0] awcache;
always @* begin
    casez ({pma_mtype,c2nc})
        5'b0000_?: arcache = 4'b0000;
        5'b0001_?: arcache = 4'b0001;
        5'b0010_?: arcache = 4'b0010;
        5'b0011_?: arcache = 4'b0011;
        5'b0100_0: arcache = 4'b1010;
        5'b0101_0: arcache = 4'b1110;
        5'b1000_0: arcache = 4'b1011;
        5'b1001_0: arcache = 4'b1111;
        5'b1010_0: arcache = 4'b1011;
        5'b1011_0: arcache = 4'b1111;
        5'b01??_1: arcache = 4'b0011;
        5'b10??_1: arcache = 4'b0011;
        default: arcache = 4'b0;
    endcase
end

always @* begin
    casez ({pma_mtype,c2nc})
        5'b0000_?: awcache = 4'b0000;
        5'b0001_?: awcache = 4'b0001;
        5'b0010_?: awcache = 4'b0010;
        5'b0011_?: awcache = 4'b0011;
        5'b0100_0: awcache = 4'b0110;
        5'b0101_0: awcache = 4'b0110;
        5'b1000_0: awcache = 4'b0111;
        5'b1001_0: awcache = 4'b0111;
        5'b1010_0: awcache = 4'b1111;
        5'b1011_0: awcache = 4'b1111;
        5'b01??_1: awcache = 4'b0011;
        5'b10??_1: awcache = 4'b0011;
        default: awcache = 4'b0;
    endcase
end

endmodule

