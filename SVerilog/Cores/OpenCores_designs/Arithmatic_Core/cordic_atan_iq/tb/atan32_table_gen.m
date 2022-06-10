clc

i = 0;
atan_table(1) = int32(1);

while i == 0 || atan_table(i) ~= 0
    atan_table(i+1) = int32(round(atan(1/2^i) / (pi/2) * 2^30));
    i = i + 1;
end

k = 1;
for i=1:length(atan_table) % ?
   k = k * 1 / sqrt(1 + 2^(-2 * (i-1)));
end

fid = fopen('atan32_table.sv', 'w');

fprintf(fid, '`ifndef _atan32_table_\n');
fprintf(fid, '`define _atan32_table_\n');
fprintf(fid, '// atan table for values 1, 1/2, 1/4, 1/8, 1/16...\n');
fprintf(fid, '// Scale: code 2^30 = 90 deg, code 0 = 0 deg\n\n');

fprintf(fid, 'package ConstPkg;\n\n');
fprintf(fid, '   parameter STEPS = %d;\n',  length(atan_table));
fprintf(fid, '   parameter real K = %.16f;\n', k);
fprintf(fid, '   parameter bit [29:0] K_u30 = 30''h%08x;\n', int32(round(k * 2^30)));
fprintf(fid, '   parameter bit [31:0] K_u32 = 32''h%08x;\n', uint32(round(k * 2^32)));
fprintf(fid, '// for sin and cos start calculation from vector {K_u30, 0}\n');
fprintf(fid, '// modulus of vector {I, Q} = (coe_abs * K_u32) >> 32\n');
fprintf(fid, '// last table value dont use\n\n');

fprintf(fid, '   parameter bit signed [31:0] atan_table[STEPS] = ''{\n');

for i=1:length(atan_table)
    fprintf(fid, '      32''sh%08x', atan_table(i));
    if i ~= length(atan_table)
        fprintf(fid, ', // tan = 1/2^%d = 1/%d\n', i, 2^i);
    else
        fprintf(fid, '  // tan = 1/2^%d = 1/%d\n', i, 2^i);
        fprintf(fid, '   };\n\n');
    end
end

fprintf(fid, 'endpackage: ConstPkg\n\n');
fprintf(fid, '`endif\n');

fclose(fid);

sum(double(atan_table / 2^30))
