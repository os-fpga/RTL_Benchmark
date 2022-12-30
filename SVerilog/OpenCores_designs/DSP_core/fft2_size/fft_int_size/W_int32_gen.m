clc
clear
close all

POW_MAX = 16;

fid = fopen('W_int32.sv', 'w');

fprintf(fid, '`ifndef _fft_w_\n');
fprintf(fid, '`define _fft_w_\n');
fprintf(fid, '`include "round32.sv"\n\n');

fprintf(fid, 'module W_int32 #(parameter POW, W_WIDTH)(clk, k, W_Re, W_Im);\n');
fprintf(fid, '// N = 2**POW, Max POW = 10, Max W_WIDTH = 32\n');
fprintf(fid, '// File contains the rotate coefficients\n');
fprintf(fid, '// W(k, N) =  exp(-2i * pi * k / N)\n');
fprintf(fid, '// in the scale W * 2^30\n\n');
fprintf(fid, '   input wire clk;\n');
fprintf(fid, '   input wire [POW-2:0] k;\n');
fprintf(fid, '   output wire signed [W_WIDTH-1:0] W_Re, W_Im;\n\n');

fprintf(fid, '   generate\n');
fprintf(fid, '      if (POW == 1)\n');
fprintf(fid, '         begin\n');
w = W(0, 2) * 2^30;
bit32 = IntToBit32(real(w));
fprintf(fid, '            localparam bit signed [31:0] W_Re_table = 32''sh%08x;\n', bit32);

bit32 = IntToBit32(imag(w));
fprintf(fid, '            localparam bit signed [31:0] W_Im_table = 32''sh%08x;\n\n', bit32);

fprintf(fid, '            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_table, W_Re);\n');
fprintf(fid, '            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_table, W_Im);\n');
fprintf(fid, '         end\n');

for POW = 2:POW_MAX
    fprintf(fid, '      else if (POW == %d)\n', POW);
    fprintf(fid, '         begin\n');    
    fprintf(fid, '            reg signed [31:0] W_Re_table[%d] = ''{\n', 2^(POW-1));
    fprintf(fid, '               ');
    for i=1:2^(POW-1)
        w = W(i-1, 2^POW) * 2^30;
        bit32 = IntToBit32(real(w));
        if i ~= 2^(POW-1)
            fprintf(fid, '32''sh%08x, ', bit32);
            if mod(i, 8) == 0
                fprintf(fid, '\n');
                fprintf(fid, '               ');
            end
        else
            fprintf(fid, '32''sh%08x\n', bit32);
            fprintf(fid, '            };\n\n');
        end
    end

    fprintf(fid, '            reg signed [31:0] W_Im_table[%d] = ''{\n', 2^(POW-1));
    fprintf(fid, '               ');
    for i=1:2^(POW-1)
        w = W(i-1, 2^POW) * 2^30;
        bit32 = IntToBit32(imag(w));
        if i ~= 2^(POW-1)
            fprintf(fid, '32''sh%08x, ', bit32);
            if mod(i, 8) == 0
                fprintf(fid, '\n');
                fprintf(fid, '               ');
            end
        else
            fprintf(fid, '32''sh%08x\n', bit32);
            fprintf(fid, '            };\n\n');
        end
    end
    
    fprintf(fid, '            reg signed [31:0] W_Re_reg, W_Im_reg;\n');
    fprintf(fid, '            always_ff @(posedge clk) begin\n');
    fprintf(fid, '               W_Re_reg <= W_Re_table[k];\n');
    fprintf(fid, '               W_Im_reg <= W_Im_table[k];\n');
    fprintf(fid, '            end\n\n');
    
    fprintf(fid, '            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);\n');
    fprintf(fid, '            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);\n');    

    fprintf(fid, '         end\n');
end

fprintf(fid, '   endgenerate\n');

fprintf(fid, 'endmodule :W_int32\n\n');

fprintf(fid, '`endif\n');

fclose(fid);
