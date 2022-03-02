`ifndef _atan32_table_
`define _atan32_table_
// atan table for values 1, 1/2, 1/4, 1/8, 1/16...
// Scale: code 2^30 = 90 deg, code 0 = 0 deg

package ConstPkg;

   parameter STEPS = 32;
   parameter real K = 0.6072529350088813;
   parameter bit [29:0] K_u30 = 30'h26dd3b6a;
   parameter bit [31:0] K_u32 = 32'h9b74eda8;
// for sin and cos start calculation from vector {K_u30, 0}
// modulus of vector {I, Q} = (coe_abs * K_u32) >> 32
// last table value dont use

   parameter bit signed [31:0] atan_table[STEPS] = '{
      32'sh20000000, // tan = 1/2^1 = 1/2
      32'sh12e4051e, // tan = 1/2^2 = 1/4
      32'sh09fb385b, // tan = 1/2^3 = 1/8
      32'sh051111d4, // tan = 1/2^4 = 1/16
      32'sh028b0d43, // tan = 1/2^5 = 1/32
      32'sh0145d7e1, // tan = 1/2^6 = 1/64
      32'sh00a2f61e, // tan = 1/2^7 = 1/128
      32'sh00517c55, // tan = 1/2^8 = 1/256
      32'sh0028be53, // tan = 1/2^9 = 1/512
      32'sh00145f2f, // tan = 1/2^10 = 1/1024
      32'sh000a2f98, // tan = 1/2^11 = 1/2048
      32'sh000517cc, // tan = 1/2^12 = 1/4096
      32'sh00028be6, // tan = 1/2^13 = 1/8192
      32'sh000145f3, // tan = 1/2^14 = 1/16384
      32'sh0000a2fa, // tan = 1/2^15 = 1/32768
      32'sh0000517d, // tan = 1/2^16 = 1/65536
      32'sh000028be, // tan = 1/2^17 = 1/131072
      32'sh0000145f, // tan = 1/2^18 = 1/262144
      32'sh00000a30, // tan = 1/2^19 = 1/524288
      32'sh00000518, // tan = 1/2^20 = 1/1048576
      32'sh0000028c, // tan = 1/2^21 = 1/2097152
      32'sh00000146, // tan = 1/2^22 = 1/4194304
      32'sh000000a3, // tan = 1/2^23 = 1/8388608
      32'sh00000051, // tan = 1/2^24 = 1/16777216
      32'sh00000029, // tan = 1/2^25 = 1/33554432
      32'sh00000014, // tan = 1/2^26 = 1/67108864
      32'sh0000000a, // tan = 1/2^27 = 1/134217728
      32'sh00000005, // tan = 1/2^28 = 1/268435456
      32'sh00000003, // tan = 1/2^29 = 1/536870912
      32'sh00000001, // tan = 1/2^30 = 1/1073741824
      32'sh00000001, // tan = 1/2^31 = 1/2147483648
      32'sh00000000  // tan = 1/2^32 = 1/4294967296
   };

endpackage: ConstPkg

`endif
