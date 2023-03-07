// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_shuffle (
    way,
    din,
    dout
);
parameter DCACHE_WAY = 2;
parameter W = 64;
parameter REVERSE = 0;
input [3:0] way;
input [(W * 4) - 1:0] din;
output [(W * 4) - 1:0] dout;


wire s0 = DCACHE_WAY == 1;
wire s1 = DCACHE_WAY == 2;
wire s2 = DCACHE_WAY == 4;
wire s3 = REVERSE != 0;
assign dout[W * 0 +:W] = ({W{s0}} & din[W * 0 +:W]) | ({W{s1 & way[0]}} & din[W * 0 +:W]) | ({W{s1 & way[1]}} & din[W * 2 +:W]) | ({W{s2 & ~s3 & way[0]}} & din[W * 0 +:W]) | ({W{s2 & ~s3 & way[1]}} & din[W * 3 +:W]) | ({W{s2 & ~s3 & way[2]}} & din[W * 2 +:W]) | ({W{s2 & ~s3 & way[3]}} & din[W * 1 +:W]) | ({W{s2 & s3 & way[0]}} & din[W * 0 +:W]) | ({W{s2 & s3 & way[1]}} & din[W * 1 +:W]) | ({W{s2 & s3 & way[2]}} & din[W * 2 +:W]) | ({W{s2 & s3 & way[3]}} & din[W * 3 +:W]);
assign dout[W * 1 +:W] = ({W{s0}} & din[W * 1 +:W]) | ({W{s1 & way[0]}} & din[W * 1 +:W]) | ({W{s1 & way[1]}} & din[W * 3 +:W]) | ({W{s2 & ~s3 & way[0]}} & din[W * 1 +:W]) | ({W{s2 & ~s3 & way[1]}} & din[W * 0 +:W]) | ({W{s2 & ~s3 & way[2]}} & din[W * 3 +:W]) | ({W{s2 & ~s3 & way[3]}} & din[W * 2 +:W]) | ({W{s2 & s3 & way[0]}} & din[W * 1 +:W]) | ({W{s2 & s3 & way[1]}} & din[W * 2 +:W]) | ({W{s2 & s3 & way[2]}} & din[W * 3 +:W]) | ({W{s2 & s3 & way[3]}} & din[W * 0 +:W]);
assign dout[W * 2 +:W] = ({W{s0}} & din[W * 2 +:W]) | ({W{s1 & way[0]}} & din[W * 2 +:W]) | ({W{s1 & way[1]}} & din[W * 0 +:W]) | ({W{s2 & ~s3 & way[0]}} & din[W * 2 +:W]) | ({W{s2 & ~s3 & way[1]}} & din[W * 1 +:W]) | ({W{s2 & ~s3 & way[2]}} & din[W * 0 +:W]) | ({W{s2 & ~s3 & way[3]}} & din[W * 3 +:W]) | ({W{s2 & s3 & way[0]}} & din[W * 2 +:W]) | ({W{s2 & s3 & way[1]}} & din[W * 3 +:W]) | ({W{s2 & s3 & way[2]}} & din[W * 0 +:W]) | ({W{s2 & s3 & way[3]}} & din[W * 1 +:W]);
assign dout[W * 3 +:W] = ({W{s0}} & din[W * 3 +:W]) | ({W{s1 & way[0]}} & din[W * 3 +:W]) | ({W{s1 & way[1]}} & din[W * 1 +:W]) | ({W{s2 & ~s3 & way[0]}} & din[W * 3 +:W]) | ({W{s2 & ~s3 & way[1]}} & din[W * 2 +:W]) | ({W{s2 & ~s3 & way[2]}} & din[W * 1 +:W]) | ({W{s2 & ~s3 & way[3]}} & din[W * 0 +:W]) | ({W{s2 & s3 & way[0]}} & din[W * 3 +:W]) | ({W{s2 & s3 & way[1]}} & din[W * 0 +:W]) | ({W{s2 & s3 & way[2]}} & din[W * 1 +:W]) | ({W{s2 & s3 & way[3]}} & din[W * 2 +:W]);
endmodule

