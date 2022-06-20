`ifndef _fft_w_
`define _fft_w_
`include "round32.sv"

module W_int32 #(parameter POW = 10, W_WIDTH = 32)(clk, k, W_Re, W_Im);
// N = 2**POW, Max POW = 10, Max W_WIDTH = 32
// File contains the rotate coefficients
// W(k, N) =  exp(-2i * pi * k / N)
// in the scale W * 2^30
   input wire clk;
   input wire [POW-2:0] k;
   output wire signed [W_WIDTH-1:0] W_Re, W_Im;

//	assert(POW >= 2 && POW <= 10) $info("POW OK"); else $error("POW failed");

   generate
      if (POW == 1)
         begin
            localparam bit signed [31:0] W_Re_table = 32'sh40000000;
            localparam bit signed [31:0] W_Im_table = 32'sh00000000;

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_table, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_table, W_Im);
         end
      else if (POW == 2)
         begin
            reg signed [31:0] W_Re_table[2] = '{
               32'sh40000000, 32'sh00000000
            };

            reg signed [31:0] W_Im_table[2] = '{
               32'sh00000000, 32'shc0000000
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 3)
         begin
            reg signed [31:0] W_Re_table[4] = '{
               32'sh40000000, 32'sh2d413ccd, 32'sh00000000, 32'shd2bec333
            };

            reg signed [31:0] W_Im_table[4] = '{
               32'sh00000000, 32'shd2bec333, 32'shc0000000, 32'shd2bec333
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 4)
         begin
            reg signed [31:0] W_Re_table[8] = '{
               32'sh40000000, 32'sh3b20d79e, 32'sh2d413ccd, 32'sh187de2a7, 32'sh00000000, 32'she7821d59, 32'shd2bec333, 32'shc4df2862
            };

            reg signed [31:0] W_Im_table[8] = '{
               32'sh00000000, 32'she7821d59, 32'shd2bec333, 32'shc4df2862, 32'shc0000000, 32'shc4df2862, 32'shd2bec333, 32'she7821d59
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 5)
         begin


            reg signed [31:0] W_Re_table[16] = '{
               32'sh40000000, 32'sh3ec52fa0, 32'sh3b20d79e, 32'sh3536cc52, 32'sh2d413ccd, 32'sh238e7673, 32'sh187de2a7, 32'sh0c7c5c1e, 
               32'sh00000000, 32'shf383a3e2, 32'she7821d59, 32'shdc71898d, 32'shd2bec333, 32'shcac933ae, 32'shc4df2862, 32'shc13ad060
            };

            reg signed [31:0] W_Im_table[16] = '{
               32'sh00000000, 32'shf383a3e2, 32'she7821d59, 32'shdc71898d, 32'shd2bec333, 32'shcac933ae, 32'shc4df2862, 32'shc13ad060, 
               32'shc0000000, 32'shc13ad060, 32'shc4df2862, 32'shcac933ae, 32'shd2bec333, 32'shdc71898d, 32'she7821d59, 32'shf383a3e2
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 6)
         begin

            reg signed [31:0] W_Re_table[32] = '{
               32'sh40000000, 32'sh3fb11b48, 32'sh3ec52fa0, 32'sh3d3e82ae, 32'sh3b20d79e, 32'sh387165e3, 32'sh3536cc52, 32'sh317900d6, 
               32'sh2d413ccd, 32'sh2899e64a, 32'sh238e7673, 32'sh1e2b5d38, 32'sh187de2a7, 32'sh1294062f, 32'sh0c7c5c1e, 32'sh0645e9af, 
               32'sh00000000, 32'shf9ba1651, 32'shf383a3e2, 32'shed6bf9d1, 32'she7821d59, 32'she1d4a2c8, 32'shdc71898d, 32'shd76619b6, 
               32'shd2bec333, 32'shce86ff2a, 32'shcac933ae, 32'shc78e9a1d, 32'shc4df2862, 32'shc2c17d52, 32'shc13ad060, 32'shc04ee4b8
            };

            reg signed [31:0] W_Im_table[32] = '{
               32'sh00000000, 32'shf9ba1651, 32'shf383a3e2, 32'shed6bf9d1, 32'she7821d59, 32'she1d4a2c8, 32'shdc71898d, 32'shd76619b6, 
               32'shd2bec333, 32'shce86ff2a, 32'shcac933ae, 32'shc78e9a1d, 32'shc4df2862, 32'shc2c17d52, 32'shc13ad060, 32'shc04ee4b8, 
               32'shc0000000, 32'shc04ee4b8, 32'shc13ad060, 32'shc2c17d52, 32'shc4df2862, 32'shc78e9a1d, 32'shcac933ae, 32'shce86ff2a, 
               32'shd2bec333, 32'shd76619b6, 32'shdc71898d, 32'she1d4a2c8, 32'she7821d59, 32'shed6bf9d1, 32'shf383a3e2, 32'shf9ba1651
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 7)
         begin

            reg signed [31:0] W_Re_table[64] = '{
               32'sh40000000, 32'sh3fec43c7, 32'sh3fb11b48, 32'sh3f4eaafe, 32'sh3ec52fa0, 32'sh3e14fdf7, 32'sh3d3e82ae, 32'sh3c42420a, 
               32'sh3b20d79e, 32'sh39daf5e8, 32'sh387165e3, 32'sh36e5068a, 32'sh3536cc52, 32'sh3367c090, 32'sh317900d6, 32'sh2f6bbe45, 
               32'sh2d413ccd, 32'sh2afad269, 32'sh2899e64a, 32'sh261feffa, 32'sh238e7673, 32'sh20e70f32, 32'sh1e2b5d38, 32'sh1b5d100a, 
               32'sh187de2a7, 32'sh158f9a76, 32'sh1294062f, 32'sh0f8cfcbe, 32'sh0c7c5c1e, 32'sh09640837, 32'sh0645e9af, 32'sh0323ecbe, 
               32'sh00000000, 32'shfcdc1342, 32'shf9ba1651, 32'shf69bf7c9, 32'shf383a3e2, 32'shf0730342, 32'shed6bf9d1, 32'shea70658a, 
               32'she7821d59, 32'she4a2eff6, 32'she1d4a2c8, 32'shdf18f0ce, 32'shdc71898d, 32'shd9e01006, 32'shd76619b6, 32'shd5052d97, 
               32'shd2bec333, 32'shd09441bb, 32'shce86ff2a, 32'shcc983f70, 32'shcac933ae, 32'shc91af976, 32'shc78e9a1d, 32'shc6250a18, 
               32'shc4df2862, 32'shc3bdbdf6, 32'shc2c17d52, 32'shc1eb0209, 32'shc13ad060, 32'shc0b15502, 32'shc04ee4b8, 32'shc013bc39
            };

            reg signed [31:0] W_Im_table[64] = '{
               32'sh00000000, 32'shfcdc1342, 32'shf9ba1651, 32'shf69bf7c9, 32'shf383a3e2, 32'shf0730342, 32'shed6bf9d1, 32'shea70658a, 
               32'she7821d59, 32'she4a2eff6, 32'she1d4a2c8, 32'shdf18f0ce, 32'shdc71898d, 32'shd9e01006, 32'shd76619b6, 32'shd5052d97, 
               32'shd2bec333, 32'shd09441bb, 32'shce86ff2a, 32'shcc983f70, 32'shcac933ae, 32'shc91af976, 32'shc78e9a1d, 32'shc6250a18, 
               32'shc4df2862, 32'shc3bdbdf6, 32'shc2c17d52, 32'shc1eb0209, 32'shc13ad060, 32'shc0b15502, 32'shc04ee4b8, 32'shc013bc39, 
               32'shc0000000, 32'shc013bc39, 32'shc04ee4b8, 32'shc0b15502, 32'shc13ad060, 32'shc1eb0209, 32'shc2c17d52, 32'shc3bdbdf6, 
               32'shc4df2862, 32'shc6250a18, 32'shc78e9a1d, 32'shc91af976, 32'shcac933ae, 32'shcc983f70, 32'shce86ff2a, 32'shd09441bb, 
               32'shd2bec333, 32'shd5052d97, 32'shd76619b6, 32'shd9e01006, 32'shdc71898d, 32'shdf18f0ce, 32'she1d4a2c8, 32'she4a2eff6, 
               32'she7821d59, 32'shea70658a, 32'shed6bf9d1, 32'shf0730342, 32'shf383a3e2, 32'shf69bf7c9, 32'shf9ba1651, 32'shfcdc1342
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 8)
         begin

            reg signed [31:0] W_Re_table[128] = '{
               32'sh40000000, 32'sh3ffb10c1, 32'sh3fec43c7, 32'sh3fd39b5a, 32'sh3fb11b48, 32'sh3f84c8e2, 32'sh3f4eaafe, 32'sh3f0ec9f5, 
               32'sh3ec52fa0, 32'sh3e71e759, 32'sh3e14fdf7, 32'sh3dae81cf, 32'sh3d3e82ae, 32'sh3cc511d9, 32'sh3c42420a, 32'sh3bb6276e, 
               32'sh3b20d79e, 32'sh3a8269a3, 32'sh39daf5e8, 32'sh392a9642, 32'sh387165e3, 32'sh37af8159, 32'sh36e5068a, 32'sh361214b0, 
               32'sh3536cc52, 32'sh34534f41, 32'sh3367c090, 32'sh32744493, 32'sh317900d6, 32'sh30761c18, 32'sh2f6bbe45, 32'sh2e5a1070, 
               32'sh2d413ccd, 32'sh2c216eaa, 32'sh2afad269, 32'sh29cd9578, 32'sh2899e64a, 32'sh275ff452, 32'sh261feffa, 32'sh24da0a9a, 
               32'sh238e7673, 32'sh223d66a8, 32'sh20e70f32, 32'sh1f8ba4dc, 32'sh1e2b5d38, 32'sh1cc66e99, 32'sh1b5d100a, 32'sh19ef7944, 
               32'sh187de2a7, 32'sh17088531, 32'sh158f9a76, 32'sh14135c94, 32'sh1294062f, 32'sh1111d263, 32'sh0f8cfcbe, 32'sh0e05c135, 
               32'sh0c7c5c1e, 32'sh0af10a22, 32'sh09640837, 32'sh07d59396, 32'sh0645e9af, 32'sh04b54825, 32'sh0323ecbe, 32'sh0192155f, 
               32'sh00000000, 32'shfe6deaa1, 32'shfcdc1342, 32'shfb4ab7db, 32'shf9ba1651, 32'shf82a6c6a, 32'shf69bf7c9, 32'shf50ef5de, 
               32'shf383a3e2, 32'shf1fa3ecb, 32'shf0730342, 32'sheeee2d9d, 32'shed6bf9d1, 32'shebeca36c, 32'shea70658a, 32'she8f77acf, 
               32'she7821d59, 32'she61086bc, 32'she4a2eff6, 32'she3399167, 32'she1d4a2c8, 32'she0745b24, 32'shdf18f0ce, 32'shddc29958, 
               32'shdc71898d, 32'shdb25f566, 32'shd9e01006, 32'shd8a00bae, 32'shd76619b6, 32'shd6326a88, 32'shd5052d97, 32'shd3de9156, 
               32'shd2bec333, 32'shd1a5ef90, 32'shd09441bb, 32'shcf89e3e8, 32'shce86ff2a, 32'shcd8bbb6d, 32'shcc983f70, 32'shcbacb0bf, 
               32'shcac933ae, 32'shc9edeb50, 32'shc91af976, 32'shc8507ea7, 32'shc78e9a1d, 32'shc6d569be, 32'shc6250a18, 32'shc57d965d, 
               32'shc4df2862, 32'shc449d892, 32'shc3bdbdf6, 32'shc33aee27, 32'shc2c17d52, 32'shc2517e31, 32'shc1eb0209, 32'shc18e18a7, 
               32'shc13ad060, 32'shc0f1360b, 32'shc0b15502, 32'shc07b371e, 32'shc04ee4b8, 32'shc02c64a6, 32'shc013bc39, 32'shc004ef3f
            };

            reg signed [31:0] W_Im_table[128] = '{
               32'sh00000000, 32'shfe6deaa1, 32'shfcdc1342, 32'shfb4ab7db, 32'shf9ba1651, 32'shf82a6c6a, 32'shf69bf7c9, 32'shf50ef5de, 
               32'shf383a3e2, 32'shf1fa3ecb, 32'shf0730342, 32'sheeee2d9d, 32'shed6bf9d1, 32'shebeca36c, 32'shea70658a, 32'she8f77acf, 
               32'she7821d59, 32'she61086bc, 32'she4a2eff6, 32'she3399167, 32'she1d4a2c8, 32'she0745b24, 32'shdf18f0ce, 32'shddc29958, 
               32'shdc71898d, 32'shdb25f566, 32'shd9e01006, 32'shd8a00bae, 32'shd76619b6, 32'shd6326a88, 32'shd5052d97, 32'shd3de9156, 
               32'shd2bec333, 32'shd1a5ef90, 32'shd09441bb, 32'shcf89e3e8, 32'shce86ff2a, 32'shcd8bbb6d, 32'shcc983f70, 32'shcbacb0bf, 
               32'shcac933ae, 32'shc9edeb50, 32'shc91af976, 32'shc8507ea7, 32'shc78e9a1d, 32'shc6d569be, 32'shc6250a18, 32'shc57d965d, 
               32'shc4df2862, 32'shc449d892, 32'shc3bdbdf6, 32'shc33aee27, 32'shc2c17d52, 32'shc2517e31, 32'shc1eb0209, 32'shc18e18a7, 
               32'shc13ad060, 32'shc0f1360b, 32'shc0b15502, 32'shc07b371e, 32'shc04ee4b8, 32'shc02c64a6, 32'shc013bc39, 32'shc004ef3f, 
               32'shc0000000, 32'shc004ef3f, 32'shc013bc39, 32'shc02c64a6, 32'shc04ee4b8, 32'shc07b371e, 32'shc0b15502, 32'shc0f1360b, 
               32'shc13ad060, 32'shc18e18a7, 32'shc1eb0209, 32'shc2517e31, 32'shc2c17d52, 32'shc33aee27, 32'shc3bdbdf6, 32'shc449d892, 
               32'shc4df2862, 32'shc57d965d, 32'shc6250a18, 32'shc6d569be, 32'shc78e9a1d, 32'shc8507ea7, 32'shc91af976, 32'shc9edeb50, 
               32'shcac933ae, 32'shcbacb0bf, 32'shcc983f70, 32'shcd8bbb6d, 32'shce86ff2a, 32'shcf89e3e8, 32'shd09441bb, 32'shd1a5ef90, 
               32'shd2bec333, 32'shd3de9156, 32'shd5052d97, 32'shd6326a88, 32'shd76619b6, 32'shd8a00bae, 32'shd9e01006, 32'shdb25f566, 
               32'shdc71898d, 32'shddc29958, 32'shdf18f0ce, 32'she0745b24, 32'she1d4a2c8, 32'she3399167, 32'she4a2eff6, 32'she61086bc, 
               32'she7821d59, 32'she8f77acf, 32'shea70658a, 32'shebeca36c, 32'shed6bf9d1, 32'sheeee2d9d, 32'shf0730342, 32'shf1fa3ecb, 
               32'shf383a3e2, 32'shf50ef5de, 32'shf69bf7c9, 32'shf82a6c6a, 32'shf9ba1651, 32'shfb4ab7db, 32'shfcdc1342, 32'shfe6deaa1
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 9)
         begin

            reg signed [31:0] W_Re_table[256] = '{
               32'sh40000000, 32'sh3ffec42d, 32'sh3ffb10c1, 32'sh3ff4e5e0, 32'sh3fec43c7, 32'sh3fe12acb, 32'sh3fd39b5a, 32'sh3fc395f9, 
               32'sh3fb11b48, 32'sh3f9c2bfb, 32'sh3f84c8e2, 32'sh3f6af2e3, 32'sh3f4eaafe, 32'sh3f2ff24a, 32'sh3f0ec9f5, 32'sh3eeb3347, 
               32'sh3ec52fa0, 32'sh3e9cc076, 32'sh3e71e759, 32'sh3e44a5ef, 32'sh3e14fdf7, 32'sh3de2f148, 32'sh3dae81cf, 32'sh3d77b192, 
               32'sh3d3e82ae, 32'sh3d02f757, 32'sh3cc511d9, 32'sh3c84d496, 32'sh3c42420a, 32'sh3bfd5cc4, 32'sh3bb6276e, 32'sh3b6ca4c4, 
               32'sh3b20d79e, 32'sh3ad2c2e8, 32'sh3a8269a3, 32'sh3a2fcee8, 32'sh39daf5e8, 32'sh3983e1e8, 32'sh392a9642, 32'sh38cf1669, 
               32'sh387165e3, 32'sh3811884d, 32'sh37af8159, 32'sh374b54ce, 32'sh36e5068a, 32'sh367c9a7e, 32'sh361214b0, 32'sh35a5793c, 
               32'sh3536cc52, 32'sh34c61236, 32'sh34534f41, 32'sh33de87de, 32'sh3367c090, 32'sh32eefdea, 32'sh32744493, 32'sh31f79948, 
               32'sh317900d6, 32'sh30f8801f, 32'sh30761c18, 32'sh2ff1d9c7, 32'sh2f6bbe45, 32'sh2ee3cebe, 32'sh2e5a1070, 32'sh2dce88aa, 
               32'sh2d413ccd, 32'sh2cb2324c, 32'sh2c216eaa, 32'sh2b8ef77d, 32'sh2afad269, 32'sh2a650525, 32'sh29cd9578, 32'sh29348937, 
               32'sh2899e64a, 32'sh27fdb2a7, 32'sh275ff452, 32'sh26c0b162, 32'sh261feffa, 32'sh257db64c, 32'sh24da0a9a, 32'sh2434f332, 
               32'sh238e7673, 32'sh22e69ac8, 32'sh223d66a8, 32'sh2192e09b, 32'sh20e70f32, 32'sh2039f90f, 32'sh1f8ba4dc, 32'sh1edc1953, 
               32'sh1e2b5d38, 32'sh1d79775c, 32'sh1cc66e99, 32'sh1c1249d8, 32'sh1b5d100a, 32'sh1aa6c82b, 32'sh19ef7944, 32'sh19372a64, 
               32'sh187de2a7, 32'sh17c3a931, 32'sh17088531, 32'sh164c7ddd, 32'sh158f9a76, 32'sh14d1e242, 32'sh14135c94, 32'sh135410c3, 
               32'sh1294062f, 32'sh11d3443f, 32'sh1111d263, 32'sh104fb80e, 32'sh0f8cfcbe, 32'sh0ec9a7f3, 32'sh0e05c135, 32'sh0d415013, 
               32'sh0c7c5c1e, 32'sh0bb6ecef, 32'sh0af10a22, 32'sh0a2abb59, 32'sh09640837, 32'sh089cf867, 32'sh07d59396, 32'sh070de172, 
               32'sh0645e9af, 32'sh057db403, 32'sh04b54825, 32'sh03ecadcf, 32'sh0323ecbe, 32'sh025b0caf, 32'sh0192155f, 32'sh00c90e90, 
               32'sh00000000, 32'shff36f170, 32'shfe6deaa1, 32'shfda4f351, 32'shfcdc1342, 32'shfc135231, 32'shfb4ab7db, 32'shfa824bfd, 
               32'shf9ba1651, 32'shf8f21e8e, 32'shf82a6c6a, 32'shf7630799, 32'shf69bf7c9, 32'shf5d544a7, 32'shf50ef5de, 32'shf4491311, 
               32'shf383a3e2, 32'shf2beafed, 32'shf1fa3ecb, 32'shf136580d, 32'shf0730342, 32'shefb047f2, 32'sheeee2d9d, 32'shee2cbbc1, 
               32'shed6bf9d1, 32'shecabef3d, 32'shebeca36c, 32'sheb2e1dbe, 32'shea70658a, 32'she9b38223, 32'she8f77acf, 32'she83c56cf, 
               32'she7821d59, 32'she6c8d59c, 32'she61086bc, 32'she55937d5, 32'she4a2eff6, 32'she3edb628, 32'she3399167, 32'she28688a4, 
               32'she1d4a2c8, 32'she123e6ad, 32'she0745b24, 32'shdfc606f1, 32'shdf18f0ce, 32'shde6d1f65, 32'shddc29958, 32'shdd196538, 
               32'shdc71898d, 32'shdbcb0cce, 32'shdb25f566, 32'shda8249b4, 32'shd9e01006, 32'shd93f4e9e, 32'shd8a00bae, 32'shd8024d59, 
               32'shd76619b6, 32'shd6cb76c9, 32'shd6326a88, 32'shd59afadb, 32'shd5052d97, 32'shd4710883, 32'shd3de9156, 32'shd34dcdb4, 
               32'shd2bec333, 32'shd2317756, 32'shd1a5ef90, 32'shd11c3142, 32'shd09441bb, 32'shd00e2639, 32'shcf89e3e8, 32'shcf077fe1, 
               32'shce86ff2a, 32'shce0866b8, 32'shcd8bbb6d, 32'shcd110216, 32'shcc983f70, 32'shcc217822, 32'shcbacb0bf, 32'shcb39edca, 
               32'shcac933ae, 32'shca5a86c4, 32'shc9edeb50, 32'shc9836582, 32'shc91af976, 32'shc8b4ab32, 32'shc8507ea7, 32'shc7ee77b3, 
               32'shc78e9a1d, 32'shc730e997, 32'shc6d569be, 32'shc67c1e18, 32'shc6250a18, 32'shc5d03118, 32'shc57d965d, 32'shc52d3d18, 
               32'shc4df2862, 32'shc4935b3c, 32'shc449d892, 32'shc402a33c, 32'shc3bdbdf6, 32'shc37b2b6a, 32'shc33aee27, 32'shc2fd08a9, 
               32'shc2c17d52, 32'shc2884e6e, 32'shc2517e31, 32'shc21d0eb8, 32'shc1eb0209, 32'shc1bb5a11, 32'shc18e18a7, 32'shc1633f8a, 
               32'shc13ad060, 32'shc114ccb9, 32'shc0f1360b, 32'shc0d00db6, 32'shc0b15502, 32'shc0950d1d, 32'shc07b371e, 32'shc063d405, 
               32'shc04ee4b8, 32'shc03c6a07, 32'shc02c64a6, 32'shc01ed535, 32'shc013bc39, 32'shc00b1a20, 32'shc004ef3f, 32'shc0013bd3
            };

            reg signed [31:0] W_Im_table[256] = '{
               32'sh00000000, 32'shff36f170, 32'shfe6deaa1, 32'shfda4f351, 32'shfcdc1342, 32'shfc135231, 32'shfb4ab7db, 32'shfa824bfd, 
               32'shf9ba1651, 32'shf8f21e8e, 32'shf82a6c6a, 32'shf7630799, 32'shf69bf7c9, 32'shf5d544a7, 32'shf50ef5de, 32'shf4491311, 
               32'shf383a3e2, 32'shf2beafed, 32'shf1fa3ecb, 32'shf136580d, 32'shf0730342, 32'shefb047f2, 32'sheeee2d9d, 32'shee2cbbc1, 
               32'shed6bf9d1, 32'shecabef3d, 32'shebeca36c, 32'sheb2e1dbe, 32'shea70658a, 32'she9b38223, 32'she8f77acf, 32'she83c56cf, 
               32'she7821d59, 32'she6c8d59c, 32'she61086bc, 32'she55937d5, 32'she4a2eff6, 32'she3edb628, 32'she3399167, 32'she28688a4, 
               32'she1d4a2c8, 32'she123e6ad, 32'she0745b24, 32'shdfc606f1, 32'shdf18f0ce, 32'shde6d1f65, 32'shddc29958, 32'shdd196538, 
               32'shdc71898d, 32'shdbcb0cce, 32'shdb25f566, 32'shda8249b4, 32'shd9e01006, 32'shd93f4e9e, 32'shd8a00bae, 32'shd8024d59, 
               32'shd76619b6, 32'shd6cb76c9, 32'shd6326a88, 32'shd59afadb, 32'shd5052d97, 32'shd4710883, 32'shd3de9156, 32'shd34dcdb4, 
               32'shd2bec333, 32'shd2317756, 32'shd1a5ef90, 32'shd11c3142, 32'shd09441bb, 32'shd00e2639, 32'shcf89e3e8, 32'shcf077fe1, 
               32'shce86ff2a, 32'shce0866b8, 32'shcd8bbb6d, 32'shcd110216, 32'shcc983f70, 32'shcc217822, 32'shcbacb0bf, 32'shcb39edca, 
               32'shcac933ae, 32'shca5a86c4, 32'shc9edeb50, 32'shc9836582, 32'shc91af976, 32'shc8b4ab32, 32'shc8507ea7, 32'shc7ee77b3, 
               32'shc78e9a1d, 32'shc730e997, 32'shc6d569be, 32'shc67c1e18, 32'shc6250a18, 32'shc5d03118, 32'shc57d965d, 32'shc52d3d18, 
               32'shc4df2862, 32'shc4935b3c, 32'shc449d892, 32'shc402a33c, 32'shc3bdbdf6, 32'shc37b2b6a, 32'shc33aee27, 32'shc2fd08a9, 
               32'shc2c17d52, 32'shc2884e6e, 32'shc2517e31, 32'shc21d0eb8, 32'shc1eb0209, 32'shc1bb5a11, 32'shc18e18a7, 32'shc1633f8a, 
               32'shc13ad060, 32'shc114ccb9, 32'shc0f1360b, 32'shc0d00db6, 32'shc0b15502, 32'shc0950d1d, 32'shc07b371e, 32'shc063d405, 
               32'shc04ee4b8, 32'shc03c6a07, 32'shc02c64a6, 32'shc01ed535, 32'shc013bc39, 32'shc00b1a20, 32'shc004ef3f, 32'shc0013bd3, 
               32'shc0000000, 32'shc0013bd3, 32'shc004ef3f, 32'shc00b1a20, 32'shc013bc39, 32'shc01ed535, 32'shc02c64a6, 32'shc03c6a07, 
               32'shc04ee4b8, 32'shc063d405, 32'shc07b371e, 32'shc0950d1d, 32'shc0b15502, 32'shc0d00db6, 32'shc0f1360b, 32'shc114ccb9, 
               32'shc13ad060, 32'shc1633f8a, 32'shc18e18a7, 32'shc1bb5a11, 32'shc1eb0209, 32'shc21d0eb8, 32'shc2517e31, 32'shc2884e6e, 
               32'shc2c17d52, 32'shc2fd08a9, 32'shc33aee27, 32'shc37b2b6a, 32'shc3bdbdf6, 32'shc402a33c, 32'shc449d892, 32'shc4935b3c, 
               32'shc4df2862, 32'shc52d3d18, 32'shc57d965d, 32'shc5d03118, 32'shc6250a18, 32'shc67c1e18, 32'shc6d569be, 32'shc730e997, 
               32'shc78e9a1d, 32'shc7ee77b3, 32'shc8507ea7, 32'shc8b4ab32, 32'shc91af976, 32'shc9836582, 32'shc9edeb50, 32'shca5a86c4, 
               32'shcac933ae, 32'shcb39edca, 32'shcbacb0bf, 32'shcc217822, 32'shcc983f70, 32'shcd110216, 32'shcd8bbb6d, 32'shce0866b8, 
               32'shce86ff2a, 32'shcf077fe1, 32'shcf89e3e8, 32'shd00e2639, 32'shd09441bb, 32'shd11c3142, 32'shd1a5ef90, 32'shd2317756, 
               32'shd2bec333, 32'shd34dcdb4, 32'shd3de9156, 32'shd4710883, 32'shd5052d97, 32'shd59afadb, 32'shd6326a88, 32'shd6cb76c9, 
               32'shd76619b6, 32'shd8024d59, 32'shd8a00bae, 32'shd93f4e9e, 32'shd9e01006, 32'shda8249b4, 32'shdb25f566, 32'shdbcb0cce, 
               32'shdc71898d, 32'shdd196538, 32'shddc29958, 32'shde6d1f65, 32'shdf18f0ce, 32'shdfc606f1, 32'she0745b24, 32'she123e6ad, 
               32'she1d4a2c8, 32'she28688a4, 32'she3399167, 32'she3edb628, 32'she4a2eff6, 32'she55937d5, 32'she61086bc, 32'she6c8d59c, 
               32'she7821d59, 32'she83c56cf, 32'she8f77acf, 32'she9b38223, 32'shea70658a, 32'sheb2e1dbe, 32'shebeca36c, 32'shecabef3d, 
               32'shed6bf9d1, 32'shee2cbbc1, 32'sheeee2d9d, 32'shefb047f2, 32'shf0730342, 32'shf136580d, 32'shf1fa3ecb, 32'shf2beafed, 
               32'shf383a3e2, 32'shf4491311, 32'shf50ef5de, 32'shf5d544a7, 32'shf69bf7c9, 32'shf7630799, 32'shf82a6c6a, 32'shf8f21e8e, 
               32'shf9ba1651, 32'shfa824bfd, 32'shfb4ab7db, 32'shfc135231, 32'shfcdc1342, 32'shfda4f351, 32'shfe6deaa1, 32'shff36f170
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else if (POW == 10)
         begin

            reg signed [31:0] W_Re_table[512] = '{
               32'sh40000000, 32'sh3fffb10b, 32'sh3ffec42d, 32'sh3ffd3969, 32'sh3ffb10c1, 32'sh3ff84a3c, 32'sh3ff4e5e0, 32'sh3ff0e3b6, 
               32'sh3fec43c7, 32'sh3fe7061f, 32'sh3fe12acb, 32'sh3fdab1d9, 32'sh3fd39b5a, 32'sh3fcbe75e, 32'sh3fc395f9, 32'sh3fbaa740, 
               32'sh3fb11b48, 32'sh3fa6f228, 32'sh3f9c2bfb, 32'sh3f90c8da, 32'sh3f84c8e2, 32'sh3f782c30, 32'sh3f6af2e3, 32'sh3f5d1d1d, 
               32'sh3f4eaafe, 32'sh3f3f9cab, 32'sh3f2ff24a, 32'sh3f1fabff, 32'sh3f0ec9f5, 32'sh3efd4c54, 32'sh3eeb3347, 32'sh3ed87efc, 
               32'sh3ec52fa0, 32'sh3eb14563, 32'sh3e9cc076, 32'sh3e87a10c, 32'sh3e71e759, 32'sh3e5b9392, 32'sh3e44a5ef, 32'sh3e2d1ea8, 
               32'sh3e14fdf7, 32'sh3dfc4418, 32'sh3de2f148, 32'sh3dc905c5, 32'sh3dae81cf, 32'sh3d9365a8, 32'sh3d77b192, 32'sh3d5b65d2, 
               32'sh3d3e82ae, 32'sh3d21086c, 32'sh3d02f757, 32'sh3ce44fb7, 32'sh3cc511d9, 32'sh3ca53e09, 32'sh3c84d496, 32'sh3c63d5d1, 
               32'sh3c42420a, 32'sh3c201994, 32'sh3bfd5cc4, 32'sh3bda0bf0, 32'sh3bb6276e, 32'sh3b91af97, 32'sh3b6ca4c4, 32'sh3b470753, 
               32'sh3b20d79e, 32'sh3afa1605, 32'sh3ad2c2e8, 32'sh3aaadea6, 32'sh3a8269a3, 32'sh3a596442, 32'sh3a2fcee8, 32'sh3a05a9fd, 
               32'sh39daf5e8, 32'sh39afb313, 32'sh3983e1e8, 32'sh395782d3, 32'sh392a9642, 32'sh38fd1ca4, 32'sh38cf1669, 32'sh38a08402, 
               32'sh387165e3, 32'sh3841bc7f, 32'sh3811884d, 32'sh37e0c9c3, 32'sh37af8159, 32'sh377daf89, 32'sh374b54ce, 32'sh371871a5, 
               32'sh36e5068a, 32'sh36b113fd, 32'sh367c9a7e, 32'sh36479a8e, 32'sh361214b0, 32'sh35dc0968, 32'sh35a5793c, 32'sh356e64b2, 
               32'sh3536cc52, 32'sh34feb0a5, 32'sh34c61236, 32'sh348cf190, 32'sh34534f41, 32'sh34192bd5, 32'sh33de87de, 32'sh33a363ec, 
               32'sh3367c090, 32'sh332b9e5e, 32'sh32eefdea, 32'sh32b1dfc9, 32'sh32744493, 32'sh32362ce0, 32'sh31f79948, 32'sh31b88a66, 
               32'sh317900d6, 32'sh3138fd35, 32'sh30f8801f, 32'sh30b78a36, 32'sh30761c18, 32'sh30343667, 32'sh2ff1d9c7, 32'sh2faf06da, 
               32'sh2f6bbe45, 32'sh2f2800af, 32'sh2ee3cebe, 32'sh2e9f291b, 32'sh2e5a1070, 32'sh2e148566, 32'sh2dce88aa, 32'sh2d881ae8, 
               32'sh2d413ccd, 32'sh2cf9ef09, 32'sh2cb2324c, 32'sh2c6a0746, 32'sh2c216eaa, 32'sh2bd8692b, 32'sh2b8ef77d, 32'sh2b451a55, 
               32'sh2afad269, 32'sh2ab02071, 32'sh2a650525, 32'sh2a19813f, 32'sh29cd9578, 32'sh2981428c, 32'sh29348937, 32'sh28e76a37, 
               32'sh2899e64a, 32'sh284bfe2f, 32'sh27fdb2a7, 32'sh27af0472, 32'sh275ff452, 32'sh2710830c, 32'sh26c0b162, 32'sh2670801a, 
               32'sh261feffa, 32'sh25cf01c8, 32'sh257db64c, 32'sh252c0e4f, 32'sh24da0a9a, 32'sh2487abf7, 32'sh2434f332, 32'sh23e1e117, 
               32'sh238e7673, 32'sh233ab414, 32'sh22e69ac8, 32'sh22922b5e, 32'sh223d66a8, 32'sh21e84d76, 32'sh2192e09b, 32'sh213d20e8, 
               32'sh20e70f32, 32'sh2090ac4d, 32'sh2039f90f, 32'sh1fe2f64c, 32'sh1f8ba4dc, 32'sh1f340596, 32'sh1edc1953, 32'sh1e83e0eb, 
               32'sh1e2b5d38, 32'sh1dd28f15, 32'sh1d79775c, 32'sh1d2016e9, 32'sh1cc66e99, 32'sh1c6c7f4a, 32'sh1c1249d8, 32'sh1bb7cf23, 
               32'sh1b5d100a, 32'sh1b020d6c, 32'sh1aa6c82b, 32'sh1a4b4128, 32'sh19ef7944, 32'sh19937161, 32'sh19372a64, 32'sh18daa52f, 
               32'sh187de2a7, 32'sh1820e3b0, 32'sh17c3a931, 32'sh1766340f, 32'sh17088531, 32'sh16aa9d7e, 32'sh164c7ddd, 32'sh15ee2738, 
               32'sh158f9a76, 32'sh1530d881, 32'sh14d1e242, 32'sh1472b8a5, 32'sh14135c94, 32'sh13b3cefa, 32'sh135410c3, 32'sh12f422db, 
               32'sh1294062f, 32'sh1233bbac, 32'sh11d3443f, 32'sh1172a0d7, 32'sh1111d263, 32'sh10b0d9d0, 32'sh104fb80e, 32'sh0fee6e0d, 
               32'sh0f8cfcbe, 32'sh0f2b650f, 32'sh0ec9a7f3, 32'sh0e67c65a, 32'sh0e05c135, 32'sh0da39978, 32'sh0d415013, 32'sh0cdee5f9, 
               32'sh0c7c5c1e, 32'sh0c19b374, 32'sh0bb6ecef, 32'sh0b540982, 32'sh0af10a22, 32'sh0a8defc3, 32'sh0a2abb59, 32'sh09c76dd8, 
               32'sh09640837, 32'sh09008b6a, 32'sh089cf867, 32'sh08395024, 32'sh07d59396, 32'sh0771c3b3, 32'sh070de172, 32'sh06a9edc9, 
               32'sh0645e9af, 32'sh05e1d61b, 32'sh057db403, 32'sh0519845e, 32'sh04b54825, 32'sh0451004d, 32'sh03ecadcf, 32'sh038851a2, 
               32'sh0323ecbe, 32'sh02bf801a, 32'sh025b0caf, 32'sh01f69373, 32'sh0192155f, 32'sh012d936c, 32'sh00c90e90, 32'sh006487c4, 
               32'sh00000000, 32'shff9b783c, 32'shff36f170, 32'shfed26c94, 32'shfe6deaa1, 32'shfe096c8d, 32'shfda4f351, 32'shfd407fe6, 
               32'shfcdc1342, 32'shfc77ae5e, 32'shfc135231, 32'shfbaeffb3, 32'shfb4ab7db, 32'shfae67ba2, 32'shfa824bfd, 32'shfa1e29e5, 
               32'shf9ba1651, 32'shf9561237, 32'shf8f21e8e, 32'shf88e3c4d, 32'shf82a6c6a, 32'shf7c6afdc, 32'shf7630799, 32'shf6ff7496, 
               32'shf69bf7c9, 32'shf6389228, 32'shf5d544a7, 32'shf572103d, 32'shf50ef5de, 32'shf4abf67e, 32'shf4491311, 32'shf3e64c8c, 
               32'shf383a3e2, 32'shf3211a07, 32'shf2beafed, 32'shf25c6688, 32'shf1fa3ecb, 32'shf19839a6, 32'shf136580d, 32'shf0d49af1, 
               32'shf0730342, 32'shf01191f3, 32'shefb047f2, 32'shef4f2630, 32'sheeee2d9d, 32'shee8d5f29, 32'shee2cbbc1, 32'shedcc4454, 
               32'shed6bf9d1, 32'shed0bdd25, 32'shecabef3d, 32'shec4c3106, 32'shebeca36c, 32'sheb8d475b, 32'sheb2e1dbe, 32'sheacf277f, 
               32'shea70658a, 32'shea11d8c8, 32'she9b38223, 32'she9556282, 32'she8f77acf, 32'she899cbf1, 32'she83c56cf, 32'she7df1c50, 
               32'she7821d59, 32'she7255ad1, 32'she6c8d59c, 32'she66c8e9f, 32'she61086bc, 32'she5b4bed8, 32'she55937d5, 32'she4fdf294, 
               32'she4a2eff6, 32'she44830dd, 32'she3edb628, 32'she39380b6, 32'she3399167, 32'she2dfe917, 32'she28688a4, 32'she22d70eb, 
               32'she1d4a2c8, 32'she17c1f15, 32'she123e6ad, 32'she0cbfa6a, 32'she0745b24, 32'she01d09b4, 32'shdfc606f1, 32'shdf6f53b3, 
               32'shdf18f0ce, 32'shdec2df18, 32'shde6d1f65, 32'shde17b28a, 32'shddc29958, 32'shdd6dd4a2, 32'shdd196538, 32'shdcc54bec, 
               32'shdc71898d, 32'shdc1e1ee9, 32'shdbcb0cce, 32'shdb785409, 32'shdb25f566, 32'shdad3f1b1, 32'shda8249b4, 32'shda30fe38, 
               32'shd9e01006, 32'shd98f7fe6, 32'shd93f4e9e, 32'shd8ef7cf4, 32'shd8a00bae, 32'shd850fb8e, 32'shd8024d59, 32'shd7b401d1, 
               32'shd76619b6, 32'shd71895c9, 32'shd6cb76c9, 32'shd67ebd74, 32'shd6326a88, 32'shd5e67ec1, 32'shd59afadb, 32'shd54fdf8f, 
               32'shd5052d97, 32'shd4bae5ab, 32'shd4710883, 32'shd42796d5, 32'shd3de9156, 32'shd395f8ba, 32'shd34dcdb4, 32'shd30610f7, 
               32'shd2bec333, 32'shd277e518, 32'shd2317756, 32'shd1eb7a9a, 32'shd1a5ef90, 32'shd160d6e5, 32'shd11c3142, 32'shd0d7ff51, 
               32'shd09441bb, 32'shd050f926, 32'shd00e2639, 32'shcfcbc999, 32'shcf89e3e8, 32'shcf4875ca, 32'shcf077fe1, 32'shcec702cb, 
               32'shce86ff2a, 32'shce47759a, 32'shce0866b8, 32'shcdc9d320, 32'shcd8bbb6d, 32'shcd4e2037, 32'shcd110216, 32'shccd461a2, 
               32'shcc983f70, 32'shcc5c9c14, 32'shcc217822, 32'shcbe6d42b, 32'shcbacb0bf, 32'shcb730e70, 32'shcb39edca, 32'shcb014f5b, 
               32'shcac933ae, 32'shca919b4e, 32'shca5a86c4, 32'shca23f698, 32'shc9edeb50, 32'shc9b86572, 32'shc9836582, 32'shc94eec03, 
               32'shc91af976, 32'shc8e78e5b, 32'shc8b4ab32, 32'shc8825077, 32'shc8507ea7, 32'shc81f363d, 32'shc7ee77b3, 32'shc7be4381, 
               32'shc78e9a1d, 32'shc75f7bfe, 32'shc730e997, 32'shc702e35c, 32'shc6d569be, 32'shc6a87d2d, 32'shc67c1e18, 32'shc6504ced, 
               32'shc6250a18, 32'shc5fa5603, 32'shc5d03118, 32'shc5a69bbe, 32'shc57d965d, 32'shc555215a, 32'shc52d3d18, 32'shc505e9fb, 
               32'shc4df2862, 32'shc4b8f8ad, 32'shc4935b3c, 32'shc46e5069, 32'shc449d892, 32'shc425f410, 32'shc402a33c, 32'shc3dfe66c, 
               32'shc3bdbdf6, 32'shc39c2a2f, 32'shc37b2b6a, 32'shc35ac1f7, 32'shc33aee27, 32'shc31bb049, 32'shc2fd08a9, 32'shc2def794, 
               32'shc2c17d52, 32'shc2a49a2e, 32'shc2884e6e, 32'shc26c9a58, 32'shc2517e31, 32'shc236fa3b, 32'shc21d0eb8, 32'shc203bbe8, 
               32'shc1eb0209, 32'shc1d2e158, 32'shc1bb5a11, 32'shc1a46c6e, 32'shc18e18a7, 32'shc1785ef4, 32'shc1633f8a, 32'shc14eba9d, 
               32'shc13ad060, 32'shc1278104, 32'shc114ccb9, 32'shc102b3ac, 32'shc0f1360b, 32'shc0e05401, 32'shc0d00db6, 32'shc0c06355, 
               32'shc0b15502, 32'shc0a2e2e3, 32'shc0950d1d, 32'shc087d3d0, 32'shc07b371e, 32'shc06f3726, 32'shc063d405, 32'shc0590dd8, 
               32'shc04ee4b8, 32'shc04558c0, 32'shc03c6a07, 32'shc03418a2, 32'shc02c64a6, 32'shc0254e27, 32'shc01ed535, 32'shc018f9e1, 
               32'shc013bc39, 32'shc00f1c4a, 32'shc00b1a20, 32'shc007b5c4, 32'shc004ef3f, 32'shc002c697, 32'shc0013bd3, 32'shc0004ef5
            };

            reg signed [31:0] W_Im_table[512] = '{
               32'sh00000000, 32'shff9b783c, 32'shff36f170, 32'shfed26c94, 32'shfe6deaa1, 32'shfe096c8d, 32'shfda4f351, 32'shfd407fe6, 
               32'shfcdc1342, 32'shfc77ae5e, 32'shfc135231, 32'shfbaeffb3, 32'shfb4ab7db, 32'shfae67ba2, 32'shfa824bfd, 32'shfa1e29e5, 
               32'shf9ba1651, 32'shf9561237, 32'shf8f21e8e, 32'shf88e3c4d, 32'shf82a6c6a, 32'shf7c6afdc, 32'shf7630799, 32'shf6ff7496, 
               32'shf69bf7c9, 32'shf6389228, 32'shf5d544a7, 32'shf572103d, 32'shf50ef5de, 32'shf4abf67e, 32'shf4491311, 32'shf3e64c8c, 
               32'shf383a3e2, 32'shf3211a07, 32'shf2beafed, 32'shf25c6688, 32'shf1fa3ecb, 32'shf19839a6, 32'shf136580d, 32'shf0d49af1, 
               32'shf0730342, 32'shf01191f3, 32'shefb047f2, 32'shef4f2630, 32'sheeee2d9d, 32'shee8d5f29, 32'shee2cbbc1, 32'shedcc4454, 
               32'shed6bf9d1, 32'shed0bdd25, 32'shecabef3d, 32'shec4c3106, 32'shebeca36c, 32'sheb8d475b, 32'sheb2e1dbe, 32'sheacf277f, 
               32'shea70658a, 32'shea11d8c8, 32'she9b38223, 32'she9556282, 32'she8f77acf, 32'she899cbf1, 32'she83c56cf, 32'she7df1c50, 
               32'she7821d59, 32'she7255ad1, 32'she6c8d59c, 32'she66c8e9f, 32'she61086bc, 32'she5b4bed8, 32'she55937d5, 32'she4fdf294, 
               32'she4a2eff6, 32'she44830dd, 32'she3edb628, 32'she39380b6, 32'she3399167, 32'she2dfe917, 32'she28688a4, 32'she22d70eb, 
               32'she1d4a2c8, 32'she17c1f15, 32'she123e6ad, 32'she0cbfa6a, 32'she0745b24, 32'she01d09b4, 32'shdfc606f1, 32'shdf6f53b3, 
               32'shdf18f0ce, 32'shdec2df18, 32'shde6d1f65, 32'shde17b28a, 32'shddc29958, 32'shdd6dd4a2, 32'shdd196538, 32'shdcc54bec, 
               32'shdc71898d, 32'shdc1e1ee9, 32'shdbcb0cce, 32'shdb785409, 32'shdb25f566, 32'shdad3f1b1, 32'shda8249b4, 32'shda30fe38, 
               32'shd9e01006, 32'shd98f7fe6, 32'shd93f4e9e, 32'shd8ef7cf4, 32'shd8a00bae, 32'shd850fb8e, 32'shd8024d59, 32'shd7b401d1, 
               32'shd76619b6, 32'shd71895c9, 32'shd6cb76c9, 32'shd67ebd74, 32'shd6326a88, 32'shd5e67ec1, 32'shd59afadb, 32'shd54fdf8f, 
               32'shd5052d97, 32'shd4bae5ab, 32'shd4710883, 32'shd42796d5, 32'shd3de9156, 32'shd395f8ba, 32'shd34dcdb4, 32'shd30610f7, 
               32'shd2bec333, 32'shd277e518, 32'shd2317756, 32'shd1eb7a9a, 32'shd1a5ef90, 32'shd160d6e5, 32'shd11c3142, 32'shd0d7ff51, 
               32'shd09441bb, 32'shd050f926, 32'shd00e2639, 32'shcfcbc999, 32'shcf89e3e8, 32'shcf4875ca, 32'shcf077fe1, 32'shcec702cb, 
               32'shce86ff2a, 32'shce47759a, 32'shce0866b8, 32'shcdc9d320, 32'shcd8bbb6d, 32'shcd4e2037, 32'shcd110216, 32'shccd461a2, 
               32'shcc983f70, 32'shcc5c9c14, 32'shcc217822, 32'shcbe6d42b, 32'shcbacb0bf, 32'shcb730e70, 32'shcb39edca, 32'shcb014f5b, 
               32'shcac933ae, 32'shca919b4e, 32'shca5a86c4, 32'shca23f698, 32'shc9edeb50, 32'shc9b86572, 32'shc9836582, 32'shc94eec03, 
               32'shc91af976, 32'shc8e78e5b, 32'shc8b4ab32, 32'shc8825077, 32'shc8507ea7, 32'shc81f363d, 32'shc7ee77b3, 32'shc7be4381, 
               32'shc78e9a1d, 32'shc75f7bfe, 32'shc730e997, 32'shc702e35c, 32'shc6d569be, 32'shc6a87d2d, 32'shc67c1e18, 32'shc6504ced, 
               32'shc6250a18, 32'shc5fa5603, 32'shc5d03118, 32'shc5a69bbe, 32'shc57d965d, 32'shc555215a, 32'shc52d3d18, 32'shc505e9fb, 
               32'shc4df2862, 32'shc4b8f8ad, 32'shc4935b3c, 32'shc46e5069, 32'shc449d892, 32'shc425f410, 32'shc402a33c, 32'shc3dfe66c, 
               32'shc3bdbdf6, 32'shc39c2a2f, 32'shc37b2b6a, 32'shc35ac1f7, 32'shc33aee27, 32'shc31bb049, 32'shc2fd08a9, 32'shc2def794, 
               32'shc2c17d52, 32'shc2a49a2e, 32'shc2884e6e, 32'shc26c9a58, 32'shc2517e31, 32'shc236fa3b, 32'shc21d0eb8, 32'shc203bbe8, 
               32'shc1eb0209, 32'shc1d2e158, 32'shc1bb5a11, 32'shc1a46c6e, 32'shc18e18a7, 32'shc1785ef4, 32'shc1633f8a, 32'shc14eba9d, 
               32'shc13ad060, 32'shc1278104, 32'shc114ccb9, 32'shc102b3ac, 32'shc0f1360b, 32'shc0e05401, 32'shc0d00db6, 32'shc0c06355, 
               32'shc0b15502, 32'shc0a2e2e3, 32'shc0950d1d, 32'shc087d3d0, 32'shc07b371e, 32'shc06f3726, 32'shc063d405, 32'shc0590dd8, 
               32'shc04ee4b8, 32'shc04558c0, 32'shc03c6a07, 32'shc03418a2, 32'shc02c64a6, 32'shc0254e27, 32'shc01ed535, 32'shc018f9e1, 
               32'shc013bc39, 32'shc00f1c4a, 32'shc00b1a20, 32'shc007b5c4, 32'shc004ef3f, 32'shc002c697, 32'shc0013bd3, 32'shc0004ef5, 
               32'shc0000000, 32'shc0004ef5, 32'shc0013bd3, 32'shc002c697, 32'shc004ef3f, 32'shc007b5c4, 32'shc00b1a20, 32'shc00f1c4a, 
               32'shc013bc39, 32'shc018f9e1, 32'shc01ed535, 32'shc0254e27, 32'shc02c64a6, 32'shc03418a2, 32'shc03c6a07, 32'shc04558c0, 
               32'shc04ee4b8, 32'shc0590dd8, 32'shc063d405, 32'shc06f3726, 32'shc07b371e, 32'shc087d3d0, 32'shc0950d1d, 32'shc0a2e2e3, 
               32'shc0b15502, 32'shc0c06355, 32'shc0d00db6, 32'shc0e05401, 32'shc0f1360b, 32'shc102b3ac, 32'shc114ccb9, 32'shc1278104, 
               32'shc13ad060, 32'shc14eba9d, 32'shc1633f8a, 32'shc1785ef4, 32'shc18e18a7, 32'shc1a46c6e, 32'shc1bb5a11, 32'shc1d2e158, 
               32'shc1eb0209, 32'shc203bbe8, 32'shc21d0eb8, 32'shc236fa3b, 32'shc2517e31, 32'shc26c9a58, 32'shc2884e6e, 32'shc2a49a2e, 
               32'shc2c17d52, 32'shc2def794, 32'shc2fd08a9, 32'shc31bb049, 32'shc33aee27, 32'shc35ac1f7, 32'shc37b2b6a, 32'shc39c2a2f, 
               32'shc3bdbdf6, 32'shc3dfe66c, 32'shc402a33c, 32'shc425f410, 32'shc449d892, 32'shc46e5069, 32'shc4935b3c, 32'shc4b8f8ad, 
               32'shc4df2862, 32'shc505e9fb, 32'shc52d3d18, 32'shc555215a, 32'shc57d965d, 32'shc5a69bbe, 32'shc5d03118, 32'shc5fa5603, 
               32'shc6250a18, 32'shc6504ced, 32'shc67c1e18, 32'shc6a87d2d, 32'shc6d569be, 32'shc702e35c, 32'shc730e997, 32'shc75f7bfe, 
               32'shc78e9a1d, 32'shc7be4381, 32'shc7ee77b3, 32'shc81f363d, 32'shc8507ea7, 32'shc8825077, 32'shc8b4ab32, 32'shc8e78e5b, 
               32'shc91af976, 32'shc94eec03, 32'shc9836582, 32'shc9b86572, 32'shc9edeb50, 32'shca23f698, 32'shca5a86c4, 32'shca919b4e, 
               32'shcac933ae, 32'shcb014f5b, 32'shcb39edca, 32'shcb730e70, 32'shcbacb0bf, 32'shcbe6d42b, 32'shcc217822, 32'shcc5c9c14, 
               32'shcc983f70, 32'shccd461a2, 32'shcd110216, 32'shcd4e2037, 32'shcd8bbb6d, 32'shcdc9d320, 32'shce0866b8, 32'shce47759a, 
               32'shce86ff2a, 32'shcec702cb, 32'shcf077fe1, 32'shcf4875ca, 32'shcf89e3e8, 32'shcfcbc999, 32'shd00e2639, 32'shd050f926, 
               32'shd09441bb, 32'shd0d7ff51, 32'shd11c3142, 32'shd160d6e5, 32'shd1a5ef90, 32'shd1eb7a9a, 32'shd2317756, 32'shd277e518, 
               32'shd2bec333, 32'shd30610f7, 32'shd34dcdb4, 32'shd395f8ba, 32'shd3de9156, 32'shd42796d5, 32'shd4710883, 32'shd4bae5ab, 
               32'shd5052d97, 32'shd54fdf8f, 32'shd59afadb, 32'shd5e67ec1, 32'shd6326a88, 32'shd67ebd74, 32'shd6cb76c9, 32'shd71895c9, 
               32'shd76619b6, 32'shd7b401d1, 32'shd8024d59, 32'shd850fb8e, 32'shd8a00bae, 32'shd8ef7cf4, 32'shd93f4e9e, 32'shd98f7fe6, 
               32'shd9e01006, 32'shda30fe38, 32'shda8249b4, 32'shdad3f1b1, 32'shdb25f566, 32'shdb785409, 32'shdbcb0cce, 32'shdc1e1ee9, 
               32'shdc71898d, 32'shdcc54bec, 32'shdd196538, 32'shdd6dd4a2, 32'shddc29958, 32'shde17b28a, 32'shde6d1f65, 32'shdec2df18, 
               32'shdf18f0ce, 32'shdf6f53b3, 32'shdfc606f1, 32'she01d09b4, 32'she0745b24, 32'she0cbfa6a, 32'she123e6ad, 32'she17c1f15, 
               32'she1d4a2c8, 32'she22d70eb, 32'she28688a4, 32'she2dfe917, 32'she3399167, 32'she39380b6, 32'she3edb628, 32'she44830dd, 
               32'she4a2eff6, 32'she4fdf294, 32'she55937d5, 32'she5b4bed8, 32'she61086bc, 32'she66c8e9f, 32'she6c8d59c, 32'she7255ad1, 
               32'she7821d59, 32'she7df1c50, 32'she83c56cf, 32'she899cbf1, 32'she8f77acf, 32'she9556282, 32'she9b38223, 32'shea11d8c8, 
               32'shea70658a, 32'sheacf277f, 32'sheb2e1dbe, 32'sheb8d475b, 32'shebeca36c, 32'shec4c3106, 32'shecabef3d, 32'shed0bdd25, 
               32'shed6bf9d1, 32'shedcc4454, 32'shee2cbbc1, 32'shee8d5f29, 32'sheeee2d9d, 32'shef4f2630, 32'shefb047f2, 32'shf01191f3, 
               32'shf0730342, 32'shf0d49af1, 32'shf136580d, 32'shf19839a6, 32'shf1fa3ecb, 32'shf25c6688, 32'shf2beafed, 32'shf3211a07, 
               32'shf383a3e2, 32'shf3e64c8c, 32'shf4491311, 32'shf4abf67e, 32'shf50ef5de, 32'shf572103d, 32'shf5d544a7, 32'shf6389228, 
               32'shf69bf7c9, 32'shf6ff7496, 32'shf7630799, 32'shf7c6afdc, 32'shf82a6c6a, 32'shf88e3c4d, 32'shf8f21e8e, 32'shf9561237, 
               32'shf9ba1651, 32'shfa1e29e5, 32'shfa824bfd, 32'shfae67ba2, 32'shfb4ab7db, 32'shfbaeffb3, 32'shfc135231, 32'shfc77ae5e, 
               32'shfcdc1342, 32'shfd407fe6, 32'shfda4f351, 32'shfe096c8d, 32'shfe6deaa1, 32'shfed26c94, 32'shff36f170, 32'shff9b783c
            };

            reg signed [31:0] W_Re_reg, W_Im_reg;
            always_ff @(posedge clk) begin
               W_Re_reg <= W_Re_table[k];
               W_Im_reg <= W_Im_table[k];
            end

            round32 #(.WIDTH(W_WIDTH)) round_re(W_Re_reg, W_Re);
            round32 #(.WIDTH(W_WIDTH)) round_im(W_Im_reg, W_Im);
         end
      else
			begin :illegal
//				assign W_Re = '0, W_Im = '0;
//				$fatal("Error");
			end
   endgenerate
endmodule :W_int32

`endif
