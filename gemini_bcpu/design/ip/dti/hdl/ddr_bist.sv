
module ddr_bist (clk , rst_n , bist_run , bist_error , bist_endtest , bist_start_rank , bist_end_rank , bist_start_bank , bist_end_bank , bist_start_background , bist_end_background , bist_start_row , bist_end_row , bist_start_column , bist_end_column , bist_element , bist_operation , bist_end_retention , bist_march_element_0 , bist_march_element_1 , bist_march_element_2 , bist_march_element_3 , bist_march_element_4 , bist_march_element_5 , bist_march_element_6 , bist_march_element_7 , bist_march_element_8 , bist_march_element_9 , bist_march_element_10 , bist_march_element_11 , bist_march_element_12 , bist_march_element_13 , bist_march_element_14 , bist_march_element_15 , reg_size_max_rt , reg_lpddr4_enable , reg_dfi_freq_ratio , dram_ras_ready , dram_cas_ready , dram_pre_ready , dram_write_en , dram_write_burst_last , dram_read_en , dram_read_burst_last , dram_read_data , dram_write_data , dram_write_strobe , dram_rank_addr , dram_bank_occp , dram_row_addr , dram_cas_info , dram_ras_valid , dram_cas_valid , dram_pre_valid , dram_cas_rd , diagnosis_en , bist_error_new , dram_bank_fail , dram_rank_fail , dram_row_fail);
input   clk ;
input   rst_n ;
input   bist_run ;
output   bist_error ;
output   bist_endtest ;
input  [0:0] bist_start_rank ;
input  [0:0] bist_end_rank ;
input  [3:0] bist_start_bank ;
input  [3:0] bist_end_bank ;
input  [2:0] bist_start_background ;
input  [2:0] bist_end_background ;
input  [16:0] bist_start_row ;
input  [16:0] bist_end_row ;
input  [10:0] bist_start_column ;
input  [10:0] bist_end_column ;
input  [3:0] bist_element ;
input  [3:0] bist_operation ;
input  [3:0] bist_end_retention ;
input  [31:0] bist_march_element_0 ;
input  [31:0] bist_march_element_1 ;
input  [31:0] bist_march_element_2 ;
input  [31:0] bist_march_element_3 ;
input  [31:0] bist_march_element_4 ;
input  [31:0] bist_march_element_5 ;
input  [31:0] bist_march_element_6 ;
input  [31:0] bist_march_element_7 ;
input  [31:0] bist_march_element_8 ;
input  [31:0] bist_march_element_9 ;
input  [31:0] bist_march_element_10 ;
input  [31:0] bist_march_element_11 ;
input  [31:0] bist_march_element_12 ;
input  [31:0] bist_march_element_13 ;
input  [31:0] bist_march_element_14 ;
input  [31:0] bist_march_element_15 ;
input  [11:0] reg_size_max_rt ;
input   reg_lpddr4_enable ;
input  [1:0] reg_dfi_freq_ratio ;
input  [15:0] dram_ras_ready ;
input  [15:0] dram_cas_ready ;
input  [15:0] dram_pre_ready ;
input   dram_write_en ;
input   dram_write_burst_last ;
input   dram_read_en ;
input   dram_read_burst_last ;
input  [255:0] dram_read_data ;
output  [255:0] dram_write_data ;
output  [31:0] dram_write_strobe ;
output  [63:0] dram_rank_addr ;
output  [15:0] dram_bank_occp ;
output  [271:0] dram_row_addr ;
output  [575:0] dram_cas_info ;
output  [15:0] dram_ras_valid ;
output  [15:0] dram_cas_valid ;
output  [15:0] dram_pre_valid ;
output  [15:0] dram_cas_rd ;
input   diagnosis_en ;
output   bist_error_new ;
output  [3:0] dram_bank_fail ;
output  [0:0] dram_rank_fail ;
output  [16:0] dram_row_fail ;
wire   bank_ras_ready ;
wire   bank_cas_ready ;
wire   bank_pre_ready ;
wire   bank_ras_valid ;
wire   bank_cas_valid ;
wire   bank_pre_valid ;
wire   bank_cas_rd ;
wire  [2:0] background_sel ;
wire  [0:0] dram_rank ;
wire  [16:0] dram_row ;
wire  [35:0] cas_info ;
wire  [10:0] dram_column ;
wire   background_invert ;
wire  [5:0] dram_cas_num ;
wire   fail ;
wire   new_fail ;
wire  [255:0] dpg_data ;
wire  [3:0] dram_bank ;
wire   valid_row ;
wire   valid_column ;
wire  [3:0] test_bank_index ;
wire   Tpl_81 ;
wire   Tpl_82 ;
wire   Tpl_83 ;
wire   Tpl_84 ;
wire   Tpl_85 ;
wire   Tpl_86 ;
wire   Tpl_87 ;
wire  [0:0] Tpl_88 ;
wire  [0:0] Tpl_89 ;
wire  [3:0] Tpl_90 ;
wire  [3:0] Tpl_91 ;
wire  [2:0] Tpl_92 ;
wire  [2:0] Tpl_93 ;
wire  [16:0] Tpl_94 ;
wire  [16:0] Tpl_95 ;
wire  [10:0] Tpl_96 ;
wire  [10:0] Tpl_97 ;
wire  [3:0] Tpl_98 ;
wire  [3:0] Tpl_99 ;
wire  [3:0] Tpl_100 ;
wire  [31:0] Tpl_101 ;
wire  [31:0] Tpl_102 ;
wire  [31:0] Tpl_103 ;
wire  [31:0] Tpl_104 ;
wire  [31:0] Tpl_105 ;
wire  [31:0] Tpl_106 ;
wire  [31:0] Tpl_107 ;
wire  [31:0] Tpl_108 ;
wire  [31:0] Tpl_109 ;
wire  [31:0] Tpl_110 ;
wire  [31:0] Tpl_111 ;
wire  [31:0] Tpl_112 ;
wire  [31:0] Tpl_113 ;
wire  [31:0] Tpl_114 ;
wire  [31:0] Tpl_115 ;
wire  [31:0] Tpl_116 ;
wire  [2:0] Tpl_117 ;
reg   Tpl_118 ;
wire   Tpl_119 ;
wire   Tpl_120 ;
wire   Tpl_121 ;
wire   Tpl_122 ;
wire   Tpl_123 ;
wire   Tpl_124 ;
wire   Tpl_125 ;
wire   Tpl_126 ;
wire   Tpl_127 ;
wire   Tpl_128 ;
wire   Tpl_129 ;
wire  [0:0] Tpl_130 ;
wire  [3:0] Tpl_131 ;
wire  [16:0] Tpl_132 ;
wire  [10:0] Tpl_133 ;
wire   Tpl_134 ;
wire   Tpl_135 ;
wire   Tpl_136 ;
wire  [0:0] Tpl_137 ;
wire  [3:0] Tpl_138 ;
wire  [16:0] Tpl_139 ;
wire   Tpl_140 ;
wire   Tpl_141 ;
wire   Tpl_142 ;
wire   Tpl_143 ;
wire   Tpl_144 ;
wire   Tpl_145 ;
wire   Tpl_146 ;
wire   Tpl_147 ;
wire   Tpl_148 ;
wire   Tpl_149 ;
wire   Tpl_150 ;
wire   Tpl_151 ;
wire   Tpl_152 ;
wire  [8:0] Tpl_153 ;
wire  [8:0] Tpl_154 ;
wire  [8:0] Tpl_155 ;
wire   Tpl_156 ;
wire   Tpl_157 ;
wire   Tpl_158 ;
wire  [2:0] Tpl_159 ;
wire  [2:0] Tpl_160 ;
wire  [2:0] Tpl_161 ;
wire  [2:0] Tpl_162 ;
wire  [2:0] Tpl_163 ;
wire  [2:0] Tpl_164 ;
wire  [2:0] Tpl_165 ;
wire  [2:0] Tpl_166 ;
wire  [2:0] Tpl_167 ;
wire  [3:0] Tpl_168 ;
reg   Tpl_169 ;
reg   Tpl_170 ;
reg   Tpl_171 ;
reg   Tpl_172 ;
reg   Tpl_173 ;
reg   Tpl_174 ;
reg   Tpl_175 ;
reg   Tpl_176 ;
reg  [0:0] Tpl_177 ;
reg  [0:0] Tpl_178 ;
reg  [3:0] Tpl_179 ;
reg  [3:0] Tpl_180 ;
reg  [16:0] Tpl_181 ;
reg  [16:0] Tpl_182 ;
reg  [10:0] Tpl_183 ;
reg   Tpl_184 ;
reg   Tpl_185 ;
reg  [2:0] Tpl_186 ;
wire   Tpl_187 ;
wire   Tpl_188 ;
wire   Tpl_189 ;
wire  [10:0] Tpl_190 ;
wire   Tpl_191 ;
wire  [16:0] Tpl_192 ;
wire  [3:0] Tpl_193 ;
wire   Tpl_194 ;
wire  [2:0] Tpl_195 ;
wire   Tpl_196 ;
wire  [3:0] Tpl_197 ;
wire   Tpl_198 ;
wire  [0:0] Tpl_199 ;
wire   Tpl_200 ;
wire   Tpl_201 ;
wire   Tpl_202 ;
wire   Tpl_203 ;
wire  [3:0] Tpl_204 ;
wire   Tpl_205 ;
wire   Tpl_206 ;
wire   Tpl_207 ;
wire   Tpl_208 ;
wire   Tpl_209 ;
wire  [3:0] Tpl_210 ;
wire  [3:0] Tpl_211 ;
wire  [3:0] Tpl_212 ;
wire   Tpl_213 ;
wire   Tpl_214 ;
wire  [3:0] Tpl_215 ;
reg  [3:0] Tpl_216 ;
reg  [3:0] Tpl_217 ;
wire   Tpl_218 ;
wire   Tpl_219 ;
wire   Tpl_220 ;
wire   Tpl_221 ;
wire   Tpl_222 ;
wire  [3:0] Tpl_223 ;
wire  [3:0] Tpl_224 ;
wire  [3:0] Tpl_225 ;
wire   Tpl_226 ;
wire   Tpl_227 ;
wire  [3:0] Tpl_228 ;
reg  [3:0] Tpl_229 ;
reg  [3:0] Tpl_230 ;
wire   Tpl_231 ;
wire   Tpl_232 ;
wire   Tpl_233 ;
wire   Tpl_234 ;
wire   Tpl_235 ;
wire  [10:0] Tpl_236 ;
wire  [10:0] Tpl_237 ;
wire  [10:0] Tpl_238 ;
wire   Tpl_239 ;
wire   Tpl_240 ;
wire  [10:0] Tpl_241 ;
reg  [10:0] Tpl_242 ;
reg  [10:0] Tpl_243 ;
wire   Tpl_244 ;
wire   Tpl_245 ;
wire   Tpl_246 ;
wire   Tpl_247 ;
wire   Tpl_248 ;
wire  [16:0] Tpl_249 ;
wire  [16:0] Tpl_250 ;
wire  [16:0] Tpl_251 ;
wire   Tpl_252 ;
wire   Tpl_253 ;
wire  [16:0] Tpl_254 ;
reg  [16:0] Tpl_255 ;
reg  [16:0] Tpl_256 ;
wire   Tpl_257 ;
wire   Tpl_258 ;
wire   Tpl_259 ;
wire   Tpl_260 ;
wire   Tpl_261 ;
wire  [3:0] Tpl_262 ;
wire  [3:0] Tpl_263 ;
wire  [3:0] Tpl_264 ;
wire   Tpl_265 ;
wire   Tpl_266 ;
wire  [3:0] Tpl_267 ;
reg  [3:0] Tpl_268 ;
reg  [3:0] Tpl_269 ;
wire   Tpl_270 ;
wire   Tpl_271 ;
wire   Tpl_272 ;
wire  [31:0] Tpl_273 ;
wire  [31:0] Tpl_274 ;
wire  [31:0] Tpl_275 ;
wire  [31:0] Tpl_276 ;
wire  [31:0] Tpl_277 ;
wire  [31:0] Tpl_278 ;
wire  [31:0] Tpl_279 ;
wire  [31:0] Tpl_280 ;
wire  [31:0] Tpl_281 ;
wire  [31:0] Tpl_282 ;
wire  [31:0] Tpl_283 ;
wire  [31:0] Tpl_284 ;
wire  [31:0] Tpl_285 ;
wire  [31:0] Tpl_286 ;
wire  [31:0] Tpl_287 ;
wire  [31:0] Tpl_288 ;
wire  [3:0] Tpl_289 ;
reg  [8:0] Tpl_290 ;
reg  [8:0] Tpl_291 ;
wire   Tpl_292 ;
wire   Tpl_293 ;
wire   Tpl_294 ;
reg  [8:0] Tpl_295 ;
reg  [31:0] Tpl_296 ;
integer   Tpl_297 ;
wire   Tpl_298 ;
wire   Tpl_299 ;
wire   Tpl_300 ;
wire   Tpl_301 ;
wire   Tpl_302 ;
wire  [2:0] Tpl_303 ;
wire  [2:0] Tpl_304 ;
wire  [2:0] Tpl_305 ;
wire   Tpl_306 ;
wire   Tpl_307 ;
wire  [2:0] Tpl_308 ;
reg  [2:0] Tpl_309 ;
reg  [2:0] Tpl_310 ;
wire   Tpl_311 ;
wire   Tpl_312 ;
wire   Tpl_313 ;
wire   Tpl_314 ;
wire   Tpl_315 ;
wire  [3:0] Tpl_316 ;
wire  [3:0] Tpl_317 ;
wire  [3:0] Tpl_318 ;
wire   Tpl_319 ;
wire   Tpl_320 ;
wire  [3:0] Tpl_321 ;
reg  [3:0] Tpl_322 ;
reg  [3:0] Tpl_323 ;
wire   Tpl_324 ;
wire   Tpl_325 ;
wire   Tpl_326 ;
wire   Tpl_327 ;
wire   Tpl_328 ;
wire  [0:0] Tpl_329 ;
wire  [0:0] Tpl_330 ;
wire  [0:0] Tpl_331 ;
wire   Tpl_332 ;
wire   Tpl_333 ;
wire  [0:0] Tpl_334 ;
reg  [0:0] Tpl_335 ;
reg  [0:0] Tpl_336 ;
wire  [2:0] Tpl_337 ;
reg  [255:0] Tpl_338 ;
reg  [127:0] Tpl_339 ;
integer   Tpl_340 ;
wire   Tpl_341 ;
wire   Tpl_342 ;
wire   Tpl_343 ;
wire   Tpl_344 ;
wire   Tpl_345 ;
wire  [255:0] Tpl_346 ;
wire   Tpl_347 ;
wire  [1:0] Tpl_348 ;
wire  [11:0] Tpl_349 ;
wire   Tpl_350 ;
wire  [255:0] Tpl_351 ;
wire  [255:0] Tpl_352 ;
wire   Tpl_353 ;
wire   Tpl_354 ;
reg  [255:0] Tpl_355 ;
reg  [255:0] Tpl_356 ;
reg   Tpl_357 ;
reg   Tpl_358 ;
wire  [255:0] Tpl_359 ;
wire  [255:0] Tpl_360 ;


function integer   ceil_log2_1;
input integer   data ;
integer   i ;
ceil_log2_1 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_1 = (i + 1);

end
endfunction


function integer   last_one_2;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_2 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_2 = (i + 1);
end

end
endfunction


function integer   floor_log2_3;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_3 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_3 = ceil_log2;
else
floor_log2_3 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_4;
input integer   N ;
integer   i ;
is_onethot_4 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_4 = 1;
end
end

end
endfunction


function integer   ecc_width_5;
input integer   data_width ;
integer   i ;
ecc_width_5 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_4(i)))
begin
ecc_width_5 = (ecc_width_5 + 1);
end
end

end
endfunction

assign test_bank_index = dram_bank;
assign bank_ras_ready = dram_ras_ready[test_bank_index];
assign bank_cas_ready = dram_cas_ready[test_bank_index];
assign bank_pre_ready = dram_pre_ready[test_bank_index];
assign dram_bank_occp = (1 << test_bank_index);
assign dram_ras_valid = (({{(16){{bank_ras_valid}}}}) & dram_bank_occp);
assign dram_cas_valid = (({{(16){{bank_cas_valid}}}}) & dram_bank_occp);
assign dram_pre_valid = (({{(16){{bank_pre_valid}}}}) & dram_bank_occp);
assign dram_cas_rd = (({{(16){{bank_cas_rd}}}}) & dram_bank_occp);
assign cas_info = {{({{(6){{1'b0}}}}) , dram_cas_num , ({{(4){{1'b0}}}}) , ({{(6){{1'b0}}}}) , 1'b0 , dram_column , 1'b0 , 1'b0}};
assign dram_cas_num = ((reg_dfi_freq_ratio == 2'b10) ? (reg_lpddr4_enable ? 4'b0011 : 4'b0000) : ((reg_dfi_freq_ratio == 2'b01) ? (reg_lpddr4_enable ? 4'b0111 : 4'b0001) : (reg_lpddr4_enable ? 4'b1111 : 4'b0011)));
assign dram_rank_addr = ({{(16){{dram_rank}}}});
assign dram_row_addr = ({{(16){{dram_row}}}});
assign dram_cas_info = ({{(16){{cas_info}}}});
assign valid_row = ((dram_row >= bist_start_row) && (dram_row <= bist_end_row));
assign valid_column = ((dram_column >= bist_start_column) && (dram_column <= bist_end_column));
assign dram_write_strobe = ({{(32){{1'b1}}}});

assign Tpl_81 = clk;
assign Tpl_82 = rst_n;
assign Tpl_83 = bist_run;
assign background_sel = Tpl_117;
assign background_invert = Tpl_118;
assign bist_error = Tpl_85;
assign bist_endtest = Tpl_86;
assign Tpl_84 = reg_lpddr4_enable;
assign Tpl_87 = fail;
assign Tpl_88 = bist_start_rank;
assign Tpl_89 = bist_end_rank;
assign Tpl_90 = bist_start_bank;
assign Tpl_91 = bist_end_bank;
assign Tpl_92 = bist_start_background;
assign Tpl_93 = bist_end_background;
assign Tpl_94 = bist_start_row;
assign Tpl_95 = bist_end_row;
assign Tpl_96 = bist_start_column;
assign Tpl_97 = bist_end_column;
assign Tpl_98 = bist_element;
assign Tpl_99 = bist_operation;
assign Tpl_100 = bist_end_retention;
assign Tpl_101 = bist_march_element_0;
assign Tpl_102 = bist_march_element_1;
assign Tpl_103 = bist_march_element_2;
assign Tpl_104 = bist_march_element_3;
assign Tpl_105 = bist_march_element_4;
assign Tpl_106 = bist_march_element_5;
assign Tpl_107 = bist_march_element_6;
assign Tpl_108 = bist_march_element_7;
assign Tpl_109 = bist_march_element_8;
assign Tpl_110 = bist_march_element_9;
assign Tpl_111 = bist_march_element_10;
assign Tpl_112 = bist_march_element_11;
assign Tpl_113 = bist_march_element_12;
assign Tpl_114 = bist_march_element_13;
assign Tpl_115 = bist_march_element_14;
assign Tpl_116 = bist_march_element_15;
assign Tpl_119 = dram_write_en;
assign Tpl_120 = dram_write_burst_last;
assign Tpl_121 = dram_read_en;
assign Tpl_122 = dram_read_burst_last;
assign Tpl_123 = bank_ras_ready;
assign Tpl_124 = bank_cas_ready;
assign Tpl_125 = bank_pre_ready;
assign bank_ras_valid = Tpl_126;
assign bank_cas_valid = Tpl_127;
assign bank_pre_valid = Tpl_128;
assign bank_cas_rd = Tpl_129;
assign dram_rank = Tpl_130;
assign dram_bank = Tpl_131;
assign dram_row = Tpl_132;
assign dram_column = Tpl_133;
assign Tpl_134 = diagnosis_en;
assign Tpl_135 = new_fail;
assign bist_error_new = Tpl_136;
assign dram_rank_fail = Tpl_137;
assign dram_bank_fail = Tpl_138;
assign dram_row_fail = Tpl_139;

assign Tpl_337 = background_sel;
assign dpg_data = Tpl_338;

assign Tpl_341 = clk;
assign Tpl_342 = rst_n;
assign Tpl_343 = bist_run;
assign Tpl_344 = valid_row;
assign Tpl_345 = valid_column;
assign Tpl_346 = dpg_data;
assign Tpl_347 = background_invert;
assign Tpl_348 = reg_dfi_freq_ratio;
assign Tpl_350 = dram_read_en;
assign dram_write_data = Tpl_352;
assign Tpl_351 = dram_read_data;
assign new_fail = Tpl_353;
assign Tpl_349 = reg_size_max_rt;
assign fail = Tpl_354;

always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
begin
Tpl_183 <= 0;
end
else
begin
Tpl_183 <= (Tpl_84 ? 32 : 8);
end
end

assign Tpl_189 = ((Tpl_83 && (Tpl_134 || (!Tpl_85))) && (!Tpl_86));

always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
Tpl_169 <= 0;
else
Tpl_169 <= Tpl_170;
end


always @(*)
begin
if ((Tpl_189 && ((Tpl_123 && Tpl_126) || (Tpl_125 && Tpl_128))))
Tpl_170 = (Tpl_169 + 1);
else
Tpl_170 = Tpl_169;
end

assign Tpl_126 = (((Tpl_189 && (Tpl_169 == 0)) && (!Tpl_152)) ? 1'b1 : 1'b0);

always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
Tpl_171 <= 0;
else
Tpl_171 <= Tpl_172;
end


always @(*)
begin
if ((Tpl_189 && ((((Tpl_124 && Tpl_127) && Tpl_142) && (Tpl_168 == 0)) || (Tpl_125 && Tpl_128))))
Tpl_172 = (Tpl_171 + 1);
else
Tpl_172 = Tpl_171;
end


always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
Tpl_173 <= 0;
else
Tpl_173 <= Tpl_174;
end


always @(*)
begin
if ((Tpl_189 && Tpl_169))
begin
if ((Tpl_173 && Tpl_124))
Tpl_174 = 1'b0;
else
begin
if ((Tpl_171 == 0))
Tpl_174 = 1'b1;
else
if ((Tpl_188 && (!Tpl_128)))
Tpl_174 = 1'b1;
else
Tpl_174 = Tpl_173;
end
end
else
Tpl_174 = 1'b0;
end

assign Tpl_127 = ((!Tpl_152) ? Tpl_173 : 1'b0);

always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
Tpl_175 <= 1'b0;
else
Tpl_175 <= Tpl_176;
end


always @(*)
begin
if ((!Tpl_125))
begin
if ((((((Tpl_189 && Tpl_143) && Tpl_141) && (((Tpl_157 && Tpl_121) && Tpl_122) || ((Tpl_156 && Tpl_119) && Tpl_120))) && (!Tpl_152)) && (!Tpl_127)))
Tpl_176 = 1'b1;
else
Tpl_176 = Tpl_175;
end
else
Tpl_176 = 1'b0;
end

assign Tpl_128 = ((!Tpl_152) ? Tpl_175 : 1'b0);
assign Tpl_201 = ((Tpl_189 && Tpl_152) ? 1'b1 : 1'b0);
assign Tpl_188 = (Tpl_152 ? (Tpl_203 && Tpl_189) : ((Tpl_141 && Tpl_143) ? ((Tpl_125 && Tpl_128) && Tpl_189) : ((((Tpl_156 && Tpl_119) && Tpl_120) || ((Tpl_157 && Tpl_121) && Tpl_122)) && Tpl_189)));
assign Tpl_191 = (Tpl_152 ? ((Tpl_189 && Tpl_141) && Tpl_203) : (Tpl_143 ? ((Tpl_125 && Tpl_128) && Tpl_189) : (((((Tpl_156 && Tpl_119) && Tpl_120) || ((Tpl_157 && Tpl_121) && Tpl_122)) && Tpl_141) && Tpl_189)));
assign Tpl_133 = Tpl_190;
assign Tpl_187 = (Tpl_152 ? (((Tpl_189 && Tpl_143) && Tpl_141) && Tpl_203) : ((((Tpl_141 && Tpl_143) && (Tpl_125 && Tpl_128)) && Tpl_189) && (!(Tpl_145 && Tpl_151))));
assign Tpl_132 = Tpl_192;
assign Tpl_194 = (Tpl_152 ? ((((Tpl_189 && Tpl_145) && Tpl_143) && Tpl_141) && Tpl_203) : ((((Tpl_145 && (Tpl_125 && Tpl_128)) && Tpl_143) && Tpl_141) && Tpl_189));
assign Tpl_159 = {{Tpl_153[0] , Tpl_154[0] , Tpl_155[0]}};
assign Tpl_160 = {{Tpl_153[1] , Tpl_154[1] , Tpl_155[1]}};
assign Tpl_161 = {{Tpl_153[2] , Tpl_154[2] , Tpl_155[2]}};
assign Tpl_162 = {{Tpl_153[3] , Tpl_154[3] , Tpl_155[3]}};
assign Tpl_163 = {{Tpl_153[4] , Tpl_154[4] , Tpl_155[4]}};
assign Tpl_164 = {{Tpl_153[5] , Tpl_154[5] , Tpl_155[5]}};
assign Tpl_165 = {{Tpl_153[6] , Tpl_154[6] , Tpl_155[6]}};
assign Tpl_166 = {{Tpl_153[7] , Tpl_154[7] , Tpl_155[7]}};
assign Tpl_167 = {{Tpl_153[8] , Tpl_154[8] , Tpl_155[8]}};

always @(*)
begin
case (Tpl_168)
4'b0000: Tpl_186 = Tpl_159;
4'b0001: Tpl_186 = Tpl_160;
4'b0010: Tpl_186 = Tpl_161;
4'b0011: Tpl_186 = Tpl_162;
4'b0100: Tpl_186 = Tpl_163;
4'b0101: Tpl_186 = Tpl_164;
4'b0110: Tpl_186 = Tpl_165;
4'b0111: Tpl_186 = Tpl_166;
4'b1000: Tpl_186 = Tpl_167;
default: Tpl_186 = 3'b000;
endcase
end

assign Tpl_158 = Tpl_186[0];
assign Tpl_156 = Tpl_186[1];
assign Tpl_157 = Tpl_186[2];
assign Tpl_129 = Tpl_157;

always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
Tpl_118 <= 1'b0;
else
Tpl_118 <= Tpl_158;
end

assign Tpl_196 = (((((Tpl_147 && Tpl_145) && Tpl_143) && Tpl_141) && (Tpl_125 && Tpl_128)) && Tpl_189);
assign Tpl_117 = Tpl_195;
assign Tpl_198 = ((((((Tpl_148 && Tpl_147) && Tpl_145) && Tpl_143) && Tpl_141) && (Tpl_125 && Tpl_128)) && Tpl_189);
assign Tpl_131 = Tpl_197;
assign Tpl_200 = (((((((Tpl_149 && Tpl_148) && Tpl_147) && Tpl_145) && Tpl_143) && Tpl_141) && (Tpl_125 && Tpl_128)) && Tpl_189);
assign Tpl_130 = Tpl_199;

always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
begin
Tpl_177 <= 0;
Tpl_179 <= 0;
Tpl_181 <= 0;
end
else
begin
Tpl_177 <= Tpl_178;
Tpl_179 <= Tpl_180;
Tpl_181 <= Tpl_182;
end
end


always @(*)
begin
if (Tpl_135)
begin
Tpl_178 = Tpl_130;
Tpl_180 = Tpl_131;
Tpl_182 = Tpl_132;
end
else
begin
Tpl_178 = Tpl_177;
Tpl_180 = Tpl_179;
Tpl_182 = Tpl_181;
end
end

assign Tpl_137 = Tpl_177;
assign Tpl_138 = Tpl_179;
assign Tpl_139 = Tpl_181;

always @( posedge Tpl_81 or negedge Tpl_82 )
begin
if ((!Tpl_82))
Tpl_184 <= 1'b0;
else
Tpl_184 <= Tpl_185;
end


always @(*)
begin
if (((((((((Tpl_146 & Tpl_149) & Tpl_148) & Tpl_147) & Tpl_145) & Tpl_143) & Tpl_141) & (Tpl_125 & Tpl_128)) || ((!Tpl_134) && Tpl_85)))
Tpl_185 = 1'b1;
else
Tpl_185 = Tpl_184;
end

assign Tpl_86 = Tpl_184;
assign Tpl_85 = Tpl_87;
assign Tpl_136 = Tpl_135;

assign Tpl_205 = Tpl_81;
assign Tpl_206 = Tpl_82;
assign Tpl_208 = Tpl_201;
assign Tpl_207 = Tpl_189;
assign Tpl_210 = 4'b0001;
assign Tpl_209 = 1'b1;
assign Tpl_211 = 4'b0000;
assign Tpl_212 = Tpl_100;
assign Tpl_202 = Tpl_213;
assign Tpl_203 = Tpl_214;
assign Tpl_204 = Tpl_215;

assign Tpl_218 = Tpl_81;
assign Tpl_219 = Tpl_82;
assign Tpl_221 = Tpl_188;
assign Tpl_220 = Tpl_189;
assign Tpl_223 = 4'b0001;
assign Tpl_222 = 1'b1;
assign Tpl_224 = 4'b0000;
assign Tpl_225 = Tpl_99;
assign Tpl_140 = Tpl_226;
assign Tpl_141 = Tpl_227;
assign Tpl_168 = Tpl_228;

assign Tpl_231 = Tpl_81;
assign Tpl_232 = Tpl_82;
assign Tpl_234 = Tpl_191;
assign Tpl_233 = Tpl_189;
assign Tpl_236 = Tpl_183;
assign Tpl_235 = 1'b1;
assign Tpl_237 = Tpl_96;
assign Tpl_238 = Tpl_97;
assign Tpl_142 = Tpl_239;
assign Tpl_143 = Tpl_240;
assign Tpl_190 = Tpl_241;

assign Tpl_244 = Tpl_81;
assign Tpl_245 = Tpl_82;
assign Tpl_247 = Tpl_187;
assign Tpl_246 = Tpl_189;
assign Tpl_249 = {{({{(16){{1'b0}}}}) , 1'b1}};
assign Tpl_248 = Tpl_150;
assign Tpl_250 = Tpl_94;
assign Tpl_251 = Tpl_95;
assign Tpl_144 = Tpl_252;
assign Tpl_145 = Tpl_253;
assign Tpl_192 = Tpl_254;

assign Tpl_257 = Tpl_81;
assign Tpl_258 = Tpl_82;
assign Tpl_260 = Tpl_194;
assign Tpl_259 = Tpl_189;
assign Tpl_262 = 4'b0001;
assign Tpl_261 = 1'b1;
assign Tpl_263 = 4'b0000;
assign Tpl_264 = Tpl_98;
assign Tpl_147 = Tpl_266;
assign Tpl_193 = Tpl_267;

assign Tpl_270 = Tpl_81;
assign Tpl_271 = Tpl_82;
assign Tpl_272 = Tpl_194;
assign Tpl_273 = Tpl_101;
assign Tpl_274 = Tpl_102;
assign Tpl_275 = Tpl_103;
assign Tpl_276 = Tpl_104;
assign Tpl_277 = Tpl_105;
assign Tpl_278 = Tpl_106;
assign Tpl_279 = Tpl_107;
assign Tpl_280 = Tpl_108;
assign Tpl_281 = Tpl_109;
assign Tpl_282 = Tpl_110;
assign Tpl_283 = Tpl_111;
assign Tpl_284 = Tpl_112;
assign Tpl_285 = Tpl_113;
assign Tpl_286 = Tpl_114;
assign Tpl_287 = Tpl_115;
assign Tpl_288 = Tpl_116;
assign Tpl_289 = Tpl_193;
assign Tpl_153 = Tpl_290;
assign Tpl_154 = Tpl_291;
assign Tpl_155 = Tpl_295;
assign Tpl_150 = Tpl_292;
assign Tpl_151 = Tpl_293;
assign Tpl_152 = Tpl_294;

assign Tpl_298 = Tpl_81;
assign Tpl_299 = Tpl_82;
assign Tpl_301 = Tpl_196;
assign Tpl_300 = Tpl_189;
assign Tpl_303 = 3'b001;
assign Tpl_302 = 1'b1;
assign Tpl_304 = Tpl_92;
assign Tpl_305 = Tpl_93;
assign Tpl_148 = Tpl_307;
assign Tpl_195 = Tpl_308;

assign Tpl_311 = Tpl_81;
assign Tpl_312 = Tpl_82;
assign Tpl_314 = Tpl_198;
assign Tpl_313 = Tpl_189;
assign Tpl_316 = {{({{(3){{1'b0}}}}) , 1'b1}};
assign Tpl_315 = 1'b1;
assign Tpl_317 = Tpl_90;
assign Tpl_318 = Tpl_91;
assign Tpl_149 = Tpl_320;
assign Tpl_197 = Tpl_321;

assign Tpl_324 = Tpl_81;
assign Tpl_325 = Tpl_82;
assign Tpl_327 = Tpl_200;
assign Tpl_326 = Tpl_189;
assign Tpl_329 = 1'b1;
assign Tpl_328 = 1'b1;
assign Tpl_330 = Tpl_88;
assign Tpl_331 = Tpl_89;
assign Tpl_146 = Tpl_333;
assign Tpl_199 = Tpl_334;

always @( posedge Tpl_205 or negedge Tpl_206 )
begin
if ((!Tpl_206))
begin
Tpl_216 <= 0;
end
else
begin
Tpl_216 <= Tpl_217;
end
end


always @(*)
begin
if (Tpl_208)
begin
if (((Tpl_216 == Tpl_212) && Tpl_209))
begin
Tpl_217 = Tpl_211;
end
else
if (((Tpl_216 == Tpl_211) && (!Tpl_209)))
begin
Tpl_217 = Tpl_212;
end
else
begin
Tpl_217 = (Tpl_209 ? (Tpl_216 + Tpl_210) : (Tpl_216 - Tpl_210));
end
end
else
if ((!Tpl_207))
begin
if (Tpl_209)
begin
Tpl_217 = Tpl_211;
end
else
begin
Tpl_217 = Tpl_212;
end
end
else
begin
Tpl_217 = Tpl_216;
end
end

assign Tpl_215 = Tpl_216;
assign Tpl_213 = ((((Tpl_215 == Tpl_211) & Tpl_209) || ((Tpl_215 == Tpl_212) & (!Tpl_209))) ? 1'b1 : 1'b0);
assign Tpl_214 = ((((Tpl_215 == Tpl_212) & Tpl_209) || ((Tpl_215 == Tpl_211) & (!Tpl_209))) ? 1'b1 : 1'b0);

always @( posedge Tpl_218 or negedge Tpl_219 )
begin
if ((!Tpl_219))
begin
Tpl_229 <= 0;
end
else
begin
Tpl_229 <= Tpl_230;
end
end


always @(*)
begin
if (Tpl_221)
begin
if (((Tpl_229 == Tpl_225) && Tpl_222))
begin
Tpl_230 = Tpl_224;
end
else
if (((Tpl_229 == Tpl_224) && (!Tpl_222)))
begin
Tpl_230 = Tpl_225;
end
else
begin
Tpl_230 = (Tpl_222 ? (Tpl_229 + Tpl_223) : (Tpl_229 - Tpl_223));
end
end
else
if ((!Tpl_220))
begin
if (Tpl_222)
begin
Tpl_230 = Tpl_224;
end
else
begin
Tpl_230 = Tpl_225;
end
end
else
begin
Tpl_230 = Tpl_229;
end
end

assign Tpl_228 = Tpl_229;
assign Tpl_226 = ((((Tpl_228 == Tpl_224) & Tpl_222) || ((Tpl_228 == Tpl_225) & (!Tpl_222))) ? 1'b1 : 1'b0);
assign Tpl_227 = ((((Tpl_228 == Tpl_225) & Tpl_222) || ((Tpl_228 == Tpl_224) & (!Tpl_222))) ? 1'b1 : 1'b0);

always @( posedge Tpl_231 or negedge Tpl_232 )
begin
if ((!Tpl_232))
begin
Tpl_242 <= 0;
end
else
begin
Tpl_242 <= Tpl_243;
end
end


always @(*)
begin
if (Tpl_234)
begin
if (((Tpl_242 == Tpl_238) && Tpl_235))
begin
Tpl_243 = Tpl_237;
end
else
if (((Tpl_242 == Tpl_237) && (!Tpl_235)))
begin
Tpl_243 = Tpl_238;
end
else
begin
Tpl_243 = (Tpl_235 ? (Tpl_242 + Tpl_236) : (Tpl_242 - Tpl_236));
end
end
else
if ((!Tpl_233))
begin
if (Tpl_235)
begin
Tpl_243 = Tpl_237;
end
else
begin
Tpl_243 = Tpl_238;
end
end
else
begin
Tpl_243 = Tpl_242;
end
end

assign Tpl_241 = Tpl_242;
assign Tpl_239 = ((((Tpl_241 == Tpl_237) & Tpl_235) || ((Tpl_241 == Tpl_238) & (!Tpl_235))) ? 1'b1 : 1'b0);
assign Tpl_240 = ((((Tpl_241 == Tpl_238) & Tpl_235) || ((Tpl_241 == Tpl_237) & (!Tpl_235))) ? 1'b1 : 1'b0);

always @( posedge Tpl_244 or negedge Tpl_245 )
begin
if ((!Tpl_245))
begin
Tpl_255 <= 0;
end
else
begin
Tpl_255 <= Tpl_256;
end
end


always @(*)
begin
if (Tpl_247)
begin
if (((Tpl_255 == Tpl_251) && Tpl_248))
begin
Tpl_256 = Tpl_250;
end
else
if (((Tpl_255 == Tpl_250) && (!Tpl_248)))
begin
Tpl_256 = Tpl_251;
end
else
begin
Tpl_256 = (Tpl_248 ? (Tpl_255 + Tpl_249) : (Tpl_255 - Tpl_249));
end
end
else
if ((!Tpl_246))
begin
if (Tpl_248)
begin
Tpl_256 = Tpl_250;
end
else
begin
Tpl_256 = Tpl_251;
end
end
else
begin
Tpl_256 = Tpl_255;
end
end

assign Tpl_254 = Tpl_255;
assign Tpl_252 = ((((Tpl_254 == Tpl_250) & Tpl_248) || ((Tpl_254 == Tpl_251) & (!Tpl_248))) ? 1'b1 : 1'b0);
assign Tpl_253 = ((((Tpl_254 == Tpl_251) & Tpl_248) || ((Tpl_254 == Tpl_250) & (!Tpl_248))) ? 1'b1 : 1'b0);

always @( posedge Tpl_257 or negedge Tpl_258 )
begin
if ((!Tpl_258))
begin
Tpl_268 <= 0;
end
else
begin
Tpl_268 <= Tpl_269;
end
end


always @(*)
begin
if (Tpl_260)
begin
if (((Tpl_268 == Tpl_264) && Tpl_261))
begin
Tpl_269 = Tpl_263;
end
else
if (((Tpl_268 == Tpl_263) && (!Tpl_261)))
begin
Tpl_269 = Tpl_264;
end
else
begin
Tpl_269 = (Tpl_261 ? (Tpl_268 + Tpl_262) : (Tpl_268 - Tpl_262));
end
end
else
if ((!Tpl_259))
begin
if (Tpl_261)
begin
Tpl_269 = Tpl_263;
end
else
begin
Tpl_269 = Tpl_264;
end
end
else
begin
Tpl_269 = Tpl_268;
end
end

assign Tpl_267 = Tpl_268;
assign Tpl_265 = ((((Tpl_267 == Tpl_263) & Tpl_261) || ((Tpl_267 == Tpl_264) & (!Tpl_261))) ? 1'b1 : 1'b0);
assign Tpl_266 = ((((Tpl_267 == Tpl_264) & Tpl_261) || ((Tpl_267 == Tpl_263) & (!Tpl_261))) ? 1'b1 : 1'b0);

always @(*)
begin
case (Tpl_289)
4'b0000: Tpl_296 = Tpl_273;
4'b0001: Tpl_296 = Tpl_274;
4'b0010: Tpl_296 = Tpl_275;
4'b0011: Tpl_296 = Tpl_276;
4'b0100: Tpl_296 = Tpl_277;
4'b0101: Tpl_296 = Tpl_278;
4'b0110: Tpl_296 = Tpl_279;
4'b0111: Tpl_296 = Tpl_280;
4'b1000: Tpl_296 = Tpl_281;
4'b1001: Tpl_296 = Tpl_282;
4'b1010: Tpl_296 = Tpl_283;
4'b1011: Tpl_296 = Tpl_284;
4'b1100: Tpl_296 = Tpl_285;
4'b1101: Tpl_296 = Tpl_286;
4'b1110: Tpl_296 = Tpl_287;
4'b1111: Tpl_296 = Tpl_288;
default: Tpl_296 = Tpl_273;
endcase
end

assign Tpl_292 = Tpl_296[(32 - 1)];
assign Tpl_293 = Tpl_296[(32 - 2)];
assign Tpl_294 = Tpl_296[(32 - 3)];

always @(*)
begin
begin

for (Tpl_297 = 0 ;((Tpl_297) < (9)) ;Tpl_297 = (Tpl_297 + 1))
begin: ELEMENT_DECODE_97
Tpl_291[Tpl_297] = Tpl_296[((32 - 4) - ((3) * (Tpl_297)))];
Tpl_290[Tpl_297] = Tpl_296[((32 - 4) - (((3) * (Tpl_297)) + 1))];
Tpl_295[Tpl_297] = Tpl_296[((32 - 4) - (((3) * (Tpl_297)) + 2))];
end

end
end


always @( posedge Tpl_298 or negedge Tpl_299 )
begin
if ((!Tpl_299))
begin
Tpl_309 <= 0;
end
else
begin
Tpl_309 <= Tpl_310;
end
end


always @(*)
begin
if (Tpl_301)
begin
if (((Tpl_309 == Tpl_305) && Tpl_302))
begin
Tpl_310 = Tpl_304;
end
else
if (((Tpl_309 == Tpl_304) && (!Tpl_302)))
begin
Tpl_310 = Tpl_305;
end
else
begin
Tpl_310 = (Tpl_302 ? (Tpl_309 + Tpl_303) : (Tpl_309 - Tpl_303));
end
end
else
if ((!Tpl_300))
begin
if (Tpl_302)
begin
Tpl_310 = Tpl_304;
end
else
begin
Tpl_310 = Tpl_305;
end
end
else
begin
Tpl_310 = Tpl_309;
end
end

assign Tpl_308 = Tpl_309;
assign Tpl_306 = ((((Tpl_308 == Tpl_304) & Tpl_302) || ((Tpl_308 == Tpl_305) & (!Tpl_302))) ? 1'b1 : 1'b0);
assign Tpl_307 = ((((Tpl_308 == Tpl_305) & Tpl_302) || ((Tpl_308 == Tpl_304) & (!Tpl_302))) ? 1'b1 : 1'b0);

always @( posedge Tpl_311 or negedge Tpl_312 )
begin
if ((!Tpl_312))
begin
Tpl_322 <= 0;
end
else
begin
Tpl_322 <= Tpl_323;
end
end


always @(*)
begin
if (Tpl_314)
begin
if (((Tpl_322 == Tpl_318) && Tpl_315))
begin
Tpl_323 = Tpl_317;
end
else
if (((Tpl_322 == Tpl_317) && (!Tpl_315)))
begin
Tpl_323 = Tpl_318;
end
else
begin
Tpl_323 = (Tpl_315 ? (Tpl_322 + Tpl_316) : (Tpl_322 - Tpl_316));
end
end
else
if ((!Tpl_313))
begin
if (Tpl_315)
begin
Tpl_323 = Tpl_317;
end
else
begin
Tpl_323 = Tpl_318;
end
end
else
begin
Tpl_323 = Tpl_322;
end
end

assign Tpl_321 = Tpl_322;
assign Tpl_319 = ((((Tpl_321 == Tpl_317) & Tpl_315) || ((Tpl_321 == Tpl_318) & (!Tpl_315))) ? 1'b1 : 1'b0);
assign Tpl_320 = ((((Tpl_321 == Tpl_318) & Tpl_315) || ((Tpl_321 == Tpl_317) & (!Tpl_315))) ? 1'b1 : 1'b0);

always @( posedge Tpl_324 or negedge Tpl_325 )
begin
if ((!Tpl_325))
begin
Tpl_335 <= 0;
end
else
begin
Tpl_335 <= Tpl_336;
end
end


always @(*)
begin
if (Tpl_327)
begin
if (((Tpl_335 == Tpl_331) && Tpl_328))
begin
Tpl_336 = Tpl_330;
end
else
if (((Tpl_335 == Tpl_330) && (!Tpl_328)))
begin
Tpl_336 = Tpl_331;
end
else
begin
Tpl_336 = (Tpl_328 ? (Tpl_335 + Tpl_329) : (Tpl_335 - Tpl_329));
end
end
else
if ((!Tpl_326))
begin
if (Tpl_328)
begin
Tpl_336 = Tpl_330;
end
else
begin
Tpl_336 = Tpl_331;
end
end
else
begin
Tpl_336 = Tpl_335;
end
end

assign Tpl_334 = Tpl_335;
assign Tpl_332 = ((((Tpl_334 == Tpl_330) & Tpl_328) || ((Tpl_334 == Tpl_331) & (!Tpl_328))) ? 1'b1 : 1'b0);
assign Tpl_333 = ((((Tpl_334 == Tpl_331) & Tpl_328) || ((Tpl_334 == Tpl_330) & (!Tpl_328))) ? 1'b1 : 1'b0);

always @(*)
begin
case (Tpl_337)
3'b000: Tpl_339 = 0;
3'b001: Tpl_339 = ({{(64){{2'b01}}}});
3'b010: Tpl_339 = ({{(32){{4'b0011}}}});
3'b011: Tpl_339 = ({{(16){{8'b00001111}}}});
3'b100: Tpl_339 = ({{(8){{16'b0000000011111111}}}});
3'b101: Tpl_339 = ({{(4){{32'b00000000000000001111111111111111}}}});
3'b110: Tpl_339 = ({{(2){{64'b0000000000000000000000000000000011111111111111111111111111111111}}}});
3'b111: Tpl_339 = 128'b00000000000000000000000000000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111;
default: Tpl_339 = 0;
endcase
end


always @( Tpl_339 )
begin
begin

for (Tpl_340 = 0 ;((Tpl_340) < (256)) ;Tpl_340 = (Tpl_340 + 1))
begin
Tpl_338[Tpl_340] = Tpl_339[((Tpl_340) % (128))];
end

end
end

assign Tpl_360 = ((Tpl_348 == 2'b00) ? {{({{(192){{1'b0}}}}) , ({{(64){{1'b1}}}})}} : ((Tpl_348 == 2'b01) ? {{({{(128){{1'b0}}}}) , ({{(128){{1'b1}}}})}} : ({{(256){{1'b1}}}})));
assign Tpl_352 = (Tpl_347 ? (~Tpl_346) : Tpl_346);
assign Tpl_359 = (Tpl_347 ? (~Tpl_346) : Tpl_346);

always @( posedge Tpl_341 or negedge Tpl_342 )
begin
if ((!Tpl_342))
Tpl_355 <= 0;
else
Tpl_355 <= Tpl_356;
end


always @(*)
begin
if (Tpl_343)
begin
if (((Tpl_350 && Tpl_344) && Tpl_345))
if ((Tpl_349[2:0] == 3'b011))
begin
Tpl_356 = ((Tpl_359[63:0] & Tpl_360[63:0]) ^ Tpl_351[63:0]);
end
else
if ((Tpl_349[2:0] == 3'b100))
begin
Tpl_356 = ((Tpl_359[127:0] & Tpl_360[127:0]) ^ Tpl_351[127:0]);
end
else
Tpl_356 = ((Tpl_359 & Tpl_360) ^ Tpl_351);
else
Tpl_356 = Tpl_355;
end
else
Tpl_356 = Tpl_355;
end

assign Tpl_353 = (|Tpl_355);

always @( posedge Tpl_341 or negedge Tpl_342 )
begin
if ((!Tpl_342))
Tpl_357 <= 1'b0;
else
Tpl_357 <= Tpl_358;
end


always @(*)
begin
if (Tpl_353)
Tpl_358 = 1'b1;
else
Tpl_358 = Tpl_357;
end

assign Tpl_354 = Tpl_357;

endmodule