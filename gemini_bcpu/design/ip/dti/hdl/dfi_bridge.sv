
module dfi_bridge (clk , dfi_rddata , dfi_rddata_dbi_n , dfi_rddata_valid , dmctl_dual_chan_en , dram_addr_pc , dram_bank_pc , dram_bg_pc , dram_cke_pc , dram_cmd_pc , dram_cs_n_pc , dram_rank_addr_rd_pc , dram_rank_addr_wr_pc , dram_rdata_enable_pc , dram_wdata_enable_pc , dram_wdata_pc , dram_wdata_valid_pc , dram_wstrb_pc , dti_data_byte_dis , mprw_mode_on , reg_ddr3_enable , reg_ddr4_enable , reg_ddr4_mr4_cal , reg_dfi_freq_ratio , reg_dram_bl_enc , reg_dual_rank , reg_lpddr3_enable , reg_lpddr4_enable , reg_mc_rd_dbi , reg_mc_wr_crc , reg_mc_wr_dbi , reg_odth4 , reg_odth8 , reg_t_phy_rdlat , reg_t_rddata_en , reg_t_wrdata_en , reset_n , dfi_act_n , dfi_bank , dfi_bg , dfi_ca , dfi_ca_l , dfi_cke , dfi_cs_n , dfi_odt , dfi_parity , dfi_rank , dfi_rank_rd , dfi_rank_wr , dfi_rddata_en , dfi_wrdata , dfi_wrdata_en , dfi_wrdata_mask , dram_cmd_mrr , dram_cmd_rd , dram_cmd_rdy , dram_cmd_wr , dram_dmi , dram_rdata , dram_rvalid , rank_hold_ext , xqr_load , xqw_load);
input   clk ;
input  [255:0] dfi_rddata ;
input  [31:0] dfi_rddata_dbi_n ;
input  [3:0] dfi_rddata_valid ;
input   dmctl_dual_chan_en ;
input  [17:0] dram_addr_pc ;
input  [3:0] dram_bank_pc ;
input  [1:0] dram_bg_pc ;
input  [1:0] dram_cke_pc ;
input  [4:0] dram_cmd_pc ;
input  [1:0] dram_cs_n_pc ;
input  [0:0] dram_rank_addr_rd_pc ;
input  [0:0] dram_rank_addr_wr_pc ;
input   dram_rdata_enable_pc ;
input   dram_wdata_enable_pc ;
input  [255:0] dram_wdata_pc ;
input   dram_wdata_valid_pc ;
input  [31:0] dram_wstrb_pc ;
input  [3:0] dti_data_byte_dis ;
input   mprw_mode_on ;
input   reg_ddr3_enable ;
input   reg_ddr4_enable ;
input  [2:0] reg_ddr4_mr4_cal ;
input  [1:0] reg_dfi_freq_ratio ;
input  [1:0] reg_dram_bl_enc ;
input  [0:0] reg_dual_rank ;
input   reg_lpddr3_enable ;
input   reg_lpddr4_enable ;
input   reg_mc_rd_dbi ;
input   reg_mc_wr_crc ;
input   reg_mc_wr_dbi ;
input  [7:0] reg_odth4 ;
input  [7:0] reg_odth8 ;
input  [7:0] reg_t_phy_rdlat ;
input  [7:0] reg_t_rddata_en ;
input  [7:0] reg_t_wrdata_en ;
input   reset_n ;
output  [3:0] dfi_act_n ;
output  [15:0] dfi_bank ;
output  [7:0] dfi_bg ;
output  [75:0] dfi_ca ;
output  [39:0] dfi_ca_l ;
output  [7:0] dfi_cke ;
output  [7:0] dfi_cs_n ;
output  [3:0] dfi_odt ;
output  [3:0] dfi_parity ;
output  [3:0] dfi_rank ;
output  [3:0] dfi_rank_rd ;
output  [3:0] dfi_rank_wr ;
output  [3:0] dfi_rddata_en ;
output  [255:0] dfi_wrdata ;
output  [3:0] dfi_wrdata_en ;
output  [31:0] dfi_wrdata_mask ;
output   dram_cmd_mrr ;
output   dram_cmd_rd ;
output   dram_cmd_rdy ;
output   dram_cmd_wr ;
output  [31:0] dram_dmi ;
output  [255:0] dram_rdata ;
output   dram_rvalid ;
output   rank_hold_ext ;
output   xqr_load ;
output   xqw_load ;
wire  [2:0] cmd_rdy_nxt ;
wire  [27:0] datain_par ;
wire  [0:0] dfi_act_n_mc ;
wire  [79:0] dfi_addr ;
wire  [17:0] dfi_addr_mc ;
wire  [3:0] dfi_bank_mc ;
wire  [1:0] dfi_bg_mc ;
wire  [139:0] dfi_ca_ctl ;
wire  [3:0] dfi_cal_act_n ;
wire  [79:0] dfi_cal_addr ;
wire  [15:0] dfi_cal_bank ;
wire  [7:0] dfi_cal_bg ;
wire  [7:0] dfi_cal_cke ;
wire  [7:0] dfi_cal_cs_n ;
wire  [3:0] dfi_cal_odt ;
wire  [3:0] dfi_cal_parity ;
wire  [3:0] dfi_cal_rank_rd ;
wire  [3:0] dfi_cal_rank_wr ;
wire  [0:0] dfi_cas_n_mc ;
wire  [1:0] dfi_cke_mc ;
wire   dfi_crc_wrdata_en ;
wire  [1:0] dfi_cs_n_mc ;
wire  [255:0] dfi_dbi_rddata ;
wire  [255:0] dfi_dbi_wrdata ;
wire  [63:0] dfi_dbi_wrdata_ecc ;
wire  [7:0] dfi_dbi_wrdata_ecc_mask ;
wire  [31:0] dfi_dbi_wrdata_mask ;
wire  [255:0] dfi_if_wrdata ;
wire  [31:0] dfi_if_wrdata_mask ;
wire  [13:0] dfi_lp4_cs ;
wire  [0:0] dfi_odt_mc ;
wire  [0:0] dfi_parity_mc ;
wire  [0:0] dfi_rank_rd_mc ;
wire  [0:0] dfi_rank_wr_crc ;
wire  [0:0] dfi_rank_wr_mc ;
wire  [0:0] dfi_ras_n_mc ;
wire  [255:0] dfi_rddata_ctrl ;
wire  [31:0] dfi_rddata_dbi_n_ctrl ;
wire  [31:0] dfi_rddata_dbi_n_mc ;
wire   dfi_rddata_en_mc ;
wire  [255:0] dfi_rddata_mc ;
wire   dfi_rddata_valid_mc ;
wire  [0:0] dfi_we_n_mc ;
wire  [7:0] dfi_wrdata_ecc_mask_mc ;
wire  [63:0] dfi_wrdata_ecc_mc ;
wire   dfi_wrdata_en_mc ;
wire  [31:0] dfi_wrdata_mask_mc ;
wire  [255:0] dfi_wrdata_mc ;
wire  [3:0] dram_bank ;
wire  [1:0] dram_bg ;
wire  [79:0] dram_ca ;
wire  [1:0] dram_cke ;
wire  [5:0] dram_cmd ;
wire  [1:0] dram_cs_n ;
wire  [7:0] dram_lp4_cs ;
wire  [2:0] dram_mr_sel ;
wire  [0:0] dram_rank_rd ;
wire  [0:0] dram_rank_wr ;
wire  [255:0] dram_rdata_correct ;
wire   dram_rdata_enable ;
wire  [255:0] dram_wdata ;
wire   dram_wdata_enable ;
wire  [255:0] dram_wdata_pc_ctrl ;
wire   dram_wdata_valid ;
wire  [31:0] dram_wstrb ;
wire  [31:0] dram_wstrb_pc_ctrl ;
wire  [17:0] pc_dram_addr ;
wire  [3:0] pc_dram_bank ;
wire  [1:0] pc_dram_bg ;
wire  [79:0] pc_dram_ca ;
wire  [1:0] pc_dram_cke ;
wire  [5:0] pc_dram_cmd ;
wire  [1:0] pc_dram_cs_n ;
wire  [7:0] pc_dram_lp4_cs ;
wire  [0:0] pc_dram_rank_addr_rd ;
wire  [0:0] pc_dram_rank_addr_wr ;
wire   pc_dram_rdata_enable ;
wire  [255:0] pc_dram_wdata ;
wire   pc_dram_wdata_enable ;
wire   pc_dram_wdata_valid ;
wire  [31:0] pc_dram_wstrb ;
wire   Tpl_146 ;
wire   Tpl_147 ;
wire  [2:0] Tpl_148 ;
wire  [1:0] Tpl_149 ;
wire  [3:0] Tpl_150 ;
wire  [79:0] Tpl_151 ;
wire  [15:0] Tpl_152 ;
wire  [7:0] Tpl_153 ;
wire  [7:0] Tpl_154 ;
wire  [7:0] Tpl_155 ;
wire  [3:0] Tpl_156 ;
wire  [3:0] Tpl_157 ;
wire  [3:0] Tpl_158 ;
wire  [3:0] Tpl_159 ;
wire  [5:0] Tpl_160 ;
wire   Tpl_161 ;
wire  [2:0] Tpl_162 ;
wire  [3:0] Tpl_163 ;
wire  [79:0] Tpl_164 ;
wire  [15:0] Tpl_165 ;
wire  [7:0] Tpl_166 ;
wire  [7:0] Tpl_167 ;
wire  [7:0] Tpl_168 ;
wire  [3:0] Tpl_169 ;
wire  [3:0] Tpl_170 ;
wire  [3:0] Tpl_171 ;
wire  [3:0] Tpl_172 ;
wire  [0:0][3:0] Tpl_173 ;
wire  [0:0][3:0][19:0] Tpl_174 ;
wire  [0:0][3:0][3:0] Tpl_175 ;
wire  [0:0][3:0][1:0] Tpl_176 ;
wire  [0:0][3:0] Tpl_177 ;
wire  [3:0][0:0] Tpl_178 ;
wire  [3:0][0:0] Tpl_179 ;
wire  [3:0][0:0] Tpl_180 ;
wire  [3:0][0:0][19:0] Tpl_181 ;
wire  [3:0][0:0][3:0] Tpl_182 ;
wire  [3:0][0:0][1:0] Tpl_183 ;
wire  [3:0][0:0] Tpl_184 ;
wire  [3:0][0:0] Tpl_185 ;
wire  [3:0][0:0] Tpl_186 ;
wire  [0:0][3:0] Tpl_187 ;
wire  [0:0][3:0][19:0] Tpl_188 ;
wire  [0:0][3:0][3:0] Tpl_189 ;
wire  [0:0][3:0][1:0] Tpl_190 ;
wire  [0:0][3:0] Tpl_191 ;
wire  [3:0][0:0] Tpl_192 ;
wire  [3:0][0:0] Tpl_193 ;
wire  [3:0][0:0] Tpl_194 ;
wire  [3:0][0:0][19:0] Tpl_195 ;
wire  [3:0][0:0][3:0] Tpl_196 ;
wire  [3:0][0:0][1:0] Tpl_197 ;
wire  [3:0][0:0] Tpl_198 ;
wire  [3:0][0:0] Tpl_199 ;
wire  [3:0][0:0] Tpl_200 ;
wire  [3:0][51:0] Tpl_201 ;
reg  [3:0][51:0] Tpl_202 ;
reg  [3:0][51:0] Tpl_203 ;
reg  [3:0][51:0] Tpl_204 ;
reg  [3:0][51:0] Tpl_205 ;
reg  [3:0][51:0] Tpl_206 ;
reg  [3:0][51:0] Tpl_207 ;
reg  [3:0][51:0] Tpl_208 ;
reg  [3:0][51:0] Tpl_209 ;
reg  [3:0][51:0] Tpl_210 ;
reg  [5:0] Tpl_211 ;
reg  [2:0] Tpl_212 ;
wire   Tpl_213 ;
reg   Tpl_214 ;
reg   Tpl_215 ;
reg   Tpl_216 ;
reg   Tpl_217 ;
reg   Tpl_218 ;
reg   Tpl_219 ;
reg   Tpl_220 ;
reg   Tpl_221 ;
reg  [2:0] Tpl_222 ;
reg   Tpl_223 ;
reg   Tpl_224 ;
wire   Tpl_227 ;
wire   Tpl_228 ;
wire  [1:0] Tpl_229 ;
wire  [3:0] Tpl_230 ;
wire  [255:0] Tpl_231 ;
wire  [255:0] Tpl_232 ;
wire   Tpl_233 ;
wire  [31:0] Tpl_234 ;
wire  [31:0] Tpl_235 ;
reg  [31:0] Tpl_236 ;
reg  [255:0] Tpl_237 ;
reg  [31:0] Tpl_238 ;
reg  [255:0] Tpl_239 ;
wire   Tpl_240 ;
wire  [2:0] Tpl_241 ;
wire  [3:0] Tpl_242 ;
wire  [1:0] Tpl_243 ;
wire  [79:0] Tpl_244 ;
wire  [1:0] Tpl_245 ;
wire  [5:0] Tpl_246 ;
wire  [1:0] Tpl_247 ;
wire  [7:0] Tpl_248 ;
wire  [0:0] Tpl_249 ;
wire  [0:0] Tpl_250 ;
wire   Tpl_251 ;
wire   Tpl_252 ;
wire  [1:0] Tpl_253 ;
wire  [1:0] Tpl_254 ;
wire  [0:0] Tpl_255 ;
wire   Tpl_256 ;
wire   Tpl_257 ;
wire  [7:0] Tpl_258 ;
wire  [7:0] Tpl_259 ;
wire   Tpl_260 ;
wire  [0:0] Tpl_261 ;
wire  [3:0] Tpl_262 ;
wire  [1:0] Tpl_263 ;
wire  [139:0] Tpl_264 ;
wire  [1:0] Tpl_265 ;
wire  [1:0] Tpl_266 ;
wire  [13:0] Tpl_267 ;
wire  [0:0] Tpl_268 ;
wire  [0:0] Tpl_269 ;
wire  [0:0] Tpl_270 ;
wire   Tpl_271 ;
wire   Tpl_272 ;
wire   Tpl_273 ;
wire   Tpl_274 ;
wire   Tpl_275 ;
wire   Tpl_276 ;
wire   Tpl_277 ;
wire   Tpl_278 ;
wire   Tpl_279 ;
wire   Tpl_280 ;
wire   Tpl_281 ;
wire   Tpl_282 ;
wire  [1:0] Tpl_283 ;
wire  [0:0] Tpl_284 ;
wire   Tpl_285 ;
wire   Tpl_286 ;
wire  [1:0] Tpl_287 ;
wire   Tpl_288 ;
wire   Tpl_289 ;
wire   Tpl_290 ;
wire  [1:0] Tpl_291 ;
wire  [5:0] Tpl_292 ;
wire   Tpl_293 ;
wire   Tpl_294 ;
wire   Tpl_295 ;
wire   Tpl_296 ;
wire   Tpl_297 ;
wire   Tpl_298 ;
wire  [0:0] Tpl_299 ;
wire   Tpl_300 ;
wire  [1:0] Tpl_301 ;
reg   Tpl_302 ;
reg  [1:0] Tpl_303 ;
wire  [0:0][1:0] Tpl_304 ;
wire  [0:0][0:0] Tpl_305 ;
wire  [0:0][0:0] Tpl_306 ;
wire   Tpl_307 ;
wire   Tpl_308 ;
wire  [0:0][1:0] Tpl_309 ;
wire  [0:0][0:0] Tpl_310 ;
wire  [0:0][0:0] Tpl_311 ;
wire   Tpl_312 ;
wire   Tpl_313 ;
reg   Tpl_314 ;
reg   Tpl_315 ;
wire   Tpl_316 ;
wire   Tpl_317 ;
wire   Tpl_320 ;
wire   Tpl_321 ;
wire   Tpl_322 ;
wire   Tpl_323 ;
wire  [1:0] Tpl_324 ;
wire   Tpl_325 ;
wire   Tpl_326 ;
wire   Tpl_327 ;
wire   Tpl_328 ;
wire  [5:0] Tpl_329 ;
wire  [1:0] Tpl_330 ;
wire  [3:0] Tpl_331 ;
wire  [0:0] Tpl_332 ;
wire  [0:0] Tpl_333 ;
wire  [79:0] Tpl_334 ;
wire  [7:0] Tpl_335 ;
wire  [2:0] Tpl_336 ;
wire   Tpl_337 ;
wire  [0:0] Tpl_338 ;
wire  [0:0] Tpl_339 ;
reg  [0:0] Tpl_340 ;
wire  [1:0] Tpl_341 ;
wire  [3:0] Tpl_342 ;
wire  [139:0] Tpl_343 ;
wire  [13:0] Tpl_344 ;
reg  [2:0] Tpl_345 ;
reg  [0:0][1:0] Tpl_346 ;
reg  [0:0][3:0] Tpl_347 ;
reg  [0:0][1:0] Tpl_348 ;
reg  [0:0][3:0] Tpl_349 ;
wire  [0:0][1:0] Tpl_350 ;
wire  [0:0][3:0] Tpl_351 ;
reg   Tpl_352 ;
wire   Tpl_353 ;
reg   Tpl_354 ;
reg  [0:0][6:0][19:0] Tpl_355 ;
wire  [6:0][1:0] Tpl_356 ;
reg  [0:0][9:0][19:0] Tpl_357 ;
reg  [9:0][1:0] Tpl_358 ;
wire  [9:0] Tpl_359 ;
wire  [199:0] Tpl_360 ;
wire  [0:0][199:0] Tpl_361 ;
wire  [9:0] Tpl_362 ;
wire   Tpl_365 ;
wire   Tpl_366 ;
wire   Tpl_367 ;
wire   Tpl_368 ;
wire   Tpl_369 ;
wire   Tpl_370 ;
wire   Tpl_371 ;
wire   Tpl_372 ;
wire   Tpl_373 ;
wire   Tpl_374 ;
reg  [2:0] Tpl_375 ;
reg  [2:0] Tpl_376 ;
reg  [2:0] Tpl_377 ;
reg  [2:0] Tpl_378 ;
wire   Tpl_379 ;
wire   Tpl_380 ;
wire   Tpl_381 ;
wire   Tpl_382 ;
wire   Tpl_383 ;
wire  [1:0] Tpl_384 ;
wire   Tpl_385 ;
wire   Tpl_386 ;
wire   Tpl_387 ;
wire   Tpl_388 ;
wire  [1:0] Tpl_389 ;
wire  [1:0] Tpl_390 ;
reg  [3:0][1:0] Tpl_391 ;
wire   Tpl_392 ;
reg  [1:0] Tpl_393 ;
wire  [1:0] Tpl_394 ;
reg  [3:0][1:0] Tpl_395 ;
wire  [1:0] Tpl_396 ;
wire   Tpl_397 ;
wire   Tpl_398 ;
wire   Tpl_399 ;
wire   Tpl_400 ;
wire   Tpl_401 ;
wire   Tpl_402 ;
wire  [1:0] Tpl_403 ;
wire   Tpl_404 ;
wire  [1:0] Tpl_405 ;
wire  [1:0] Tpl_406 ;
reg  [3:0][1:0] Tpl_407 ;
wire   Tpl_408 ;
wire  [1:0] Tpl_409 ;
reg  [1:0] Tpl_410 ;
wire  [1:0] Tpl_411 ;
reg  [3:0][1:0] Tpl_412 ;
wire   Tpl_413 ;
wire   Tpl_414 ;
wire   Tpl_415 ;
wire  [7:0] Tpl_416 ;
wire  [7:0] Tpl_417 ;
wire   Tpl_418 ;
wire   Tpl_419 ;
wire   Tpl_420 ;
wire   Tpl_421 ;
wire   Tpl_422 ;
wire   Tpl_423 ;
wire  [1:0] Tpl_424 ;
reg  [0:0] Tpl_425 ;
wire   Tpl_426 ;
wire  [7:0] Tpl_427 ;
wire   Tpl_428 ;
reg  [2:0] Tpl_429 ;
reg  [2:0] Tpl_430 ;
reg  [0:0] Tpl_431 ;
wire   Tpl_432 ;
wire   Tpl_433 ;
reg  [0:0] Tpl_434 ;
wire  [0:0] Tpl_435 ;
reg  [2:0][0:0] Tpl_436 ;
reg  [2:0][0:0] Tpl_437 ;
wire   Tpl_438 ;
wire   Tpl_439 ;
wire   Tpl_440 ;
wire   Tpl_441 ;
wire   Tpl_442 ;
wire  [7:0] Tpl_443 ;
wire   Tpl_444 ;
reg  [7:0] Tpl_445 ;
reg  [7:0] Tpl_446 ;
wire   Tpl_447 ;
wire   Tpl_448 ;
wire   Tpl_449 ;
wire   Tpl_450 ;
wire   Tpl_451 ;
wire   Tpl_452 ;
wire   Tpl_453 ;
wire  [17:0] Tpl_454 ;
wire  [1:0] Tpl_455 ;
wire  [3:0] Tpl_456 ;
wire  [4:0] Tpl_457 ;
wire  [1:0] Tpl_458 ;
wire  [1:0] Tpl_459 ;
wire  [0:0] Tpl_460 ;
wire  [0:0] Tpl_461 ;
wire  [255:0] Tpl_462 ;
wire  [31:0] Tpl_463 ;
wire   Tpl_464 ;
wire   Tpl_465 ;
wire   Tpl_466 ;
wire  [1:0] Tpl_467 ;
reg  [2:0] Tpl_468 ;
reg  [79:0] Tpl_469 ;
reg  [1:0] Tpl_470 ;
reg  [3:0] Tpl_471 ;
reg  [5:0] Tpl_472 ;
reg  [1:0] Tpl_473 ;
reg  [1:0] Tpl_474 ;
reg  [0:0] Tpl_475 ;
reg  [0:0] Tpl_476 ;
reg  [255:0] Tpl_477 ;
reg  [31:0] Tpl_478 ;
reg   Tpl_479 ;
reg   Tpl_480 ;
reg   Tpl_481 ;
reg  [17:0] Tpl_482 ;
reg  [7:0] Tpl_483 ;
wire   Tpl_484 ;
wire  [3:0] Tpl_485 ;
reg  [3:0][19:0] Tpl_486 ;
reg  [3:0][1:0] Tpl_487 ;
wire   Tpl_488 ;
reg   Tpl_489 ;
reg   Tpl_490 ;
reg   Tpl_491 ;
reg  [1:0] Tpl_492 ;
reg  [3:0] Tpl_493 ;
reg  [2:0] Tpl_494 ;
reg  [2:0] Tpl_495 ;
wire   Tpl_496 ;
wire   Tpl_497 ;
wire  [1:0] Tpl_498 ;
wire   Tpl_499 ;
wire   Tpl_500 ;
wire   Tpl_501 ;
wire  [7:0] Tpl_502 ;
wire  [7:0] Tpl_503 ;
wire  [7:0] Tpl_504 ;
wire   Tpl_505 ;
wire   Tpl_506 ;
wire   Tpl_507 ;
wire   Tpl_508 ;
wire  [0:0] Tpl_509 ;
wire  [3:0] Tpl_510 ;
wire  [1:0] Tpl_511 ;
wire  [1:0] Tpl_512 ;
wire  [1:0] Tpl_513 ;
wire  [0:0] Tpl_514 ;
wire  [0:0] Tpl_515 ;
wire  [139:0] Tpl_516 ;
wire  [13:0] Tpl_517 ;
wire  [0:0] Tpl_518 ;
wire  [0:0] Tpl_519 ;
wire  [3:0] Tpl_520 ;
wire  [79:0] Tpl_521 ;
wire  [15:0] Tpl_522 ;
wire  [7:0] Tpl_523 ;
wire  [7:0] Tpl_524 ;
wire  [7:0] Tpl_525 ;
wire  [3:0] Tpl_526 ;
wire  [3:0] Tpl_527 ;
wire  [3:0] Tpl_528 ;
wire  [3:0] Tpl_529 ;
wire  [255:0] Tpl_530 ;
wire  [31:0] Tpl_531 ;
wire   Tpl_532 ;
wire  [255:0] Tpl_533 ;
wire  [31:0] Tpl_534 ;
wire  [3:0] Tpl_535 ;
wire   Tpl_536 ;
wire  [255:0] Tpl_537 ;
wire  [31:0] Tpl_538 ;
wire  [3:0] Tpl_539 ;
wire  [3:0] Tpl_540 ;
wire  [255:0] Tpl_541 ;
wire  [31:0] Tpl_542 ;
wire   Tpl_543 ;
wire  [0:0] Tpl_544 ;
wire  [0:0][3:0] Tpl_545 ;
wire  [0:0][1:0] Tpl_546 ;
wire  [0:0][6:0][19:0] Tpl_547 ;
wire  [6:0][1:0] Tpl_548 ;
wire  [0:0] Tpl_549 ;
wire  [0:0][1:0] Tpl_550 ;
wire  [1:0] Tpl_551 ;
wire  [0:0][0:0] Tpl_552 ;
wire  [0:0][19:0] Tpl_553 ;
reg  [0:0][3:0] Tpl_554 ;
reg  [0:0][3:0][19:0] Tpl_555 ;
reg  [0:0][3:0][3:0] Tpl_556 ;
reg  [0:0][3:0][19:0] Tpl_557 ;
reg  [0:0][3:0][1:0] Tpl_558 ;
reg  [0:0][3:0] Tpl_559 ;
reg  [0:0][3:0][1:0] Tpl_560 ;
reg  [3:0][1:0] Tpl_561 ;
reg  [0:0][3:0][0:0] Tpl_562 ;
wire  [3:0][63:0] Tpl_563 ;
wire  [3:0][7:0] Tpl_564 ;
wire  [3:0] Tpl_565 ;
wire  [3:0][0:0] Tpl_566 ;
wire  [3:0] Tpl_567 ;
wire  [3:0][63:0] Tpl_568 ;
wire  [3:0][7:0] Tpl_569 ;
wire  [3:0] Tpl_570 ;
wire  [3:0][0:0] Tpl_571 ;
reg   Tpl_572 ;
reg   Tpl_573 ;
reg   Tpl_574 ;
reg   Tpl_575 ;
reg   Tpl_576 ;
reg   Tpl_577 ;
reg  [0:0] Tpl_578 ;
reg  [3:0] Tpl_579 ;
reg  [1:0] Tpl_580 ;
reg  [1:0] Tpl_581 ;
reg  [1:0] Tpl_582 ;
reg  [0:0] Tpl_583 ;
reg  [0:0] Tpl_584 ;
reg  [139:0] Tpl_585 ;
reg  [13:0] Tpl_586 ;
reg   Tpl_588 ;
reg   Tpl_589 ;
reg   Tpl_590 ;
reg   Tpl_591 ;
reg   Tpl_592 ;
reg   Tpl_593 ;
reg  [0:0][0:0] Tpl_594 ;
reg  [0:0][0:0] Tpl_595 ;
reg  [3:0] Tpl_596 ;
reg  [0:0] Tpl_597 ;
reg  [0:0] Tpl_598 ;
reg  [3:0] Tpl_599 ;
reg  [0:0] Tpl_600 ;
reg  [0:0] Tpl_601 ;
wire   Tpl_602 ;
wire   Tpl_603 ;
wire  [255:0] Tpl_604 ;
wire  [31:0] Tpl_605 ;
wire   Tpl_606 ;
wire  [0:0] Tpl_607 ;
wire  [0:0] Tpl_608 ;
wire   Tpl_609 ;
wire   Tpl_610 ;
wire  [255:0] Tpl_611 ;
wire  [31:0] Tpl_612 ;
wire   Tpl_613 ;
wire  [1:0] Tpl_614 ;
wire  [1:0] Tpl_615 ;
wire  [1:0] Tpl_616 ;
wire  [3:0] Tpl_617 ;
wire  [5:0] Tpl_618 ;
wire  [79:0] Tpl_619 ;
wire  [7:0] Tpl_620 ;
wire  [0:0] Tpl_621 ;
wire  [0:0] Tpl_622 ;
wire  [1:0] Tpl_623 ;
wire  [1:0] Tpl_624 ;
wire  [3:0] Tpl_625 ;
wire  [5:0] Tpl_626 ;
wire  [1:0] Tpl_627 ;
wire  [79:0] Tpl_628 ;
wire  [7:0] Tpl_629 ;
wire  [2:0] Tpl_630 ;
wire  [3:0][1:0][3:0] Tpl_631 ;
wire  [255:0] Tpl_632 ;
wire  [31:0] Tpl_633 ;
wire   Tpl_634 ;
wire   Tpl_635 ;
wire  [255:0] Tpl_636 ;
wire  [31:0] Tpl_637 ;
wire  [255:0] Tpl_638 ;
wire  [255:0] Tpl_639 ;
wire  [31:0] Tpl_640 ;
wire  [255:0] Tpl_641 ;
wire  [7:0] Tpl_643 ;
wire   Tpl_644 ;
wire  [7:0] Tpl_645 ;
wire  [7:0] Tpl_646 ;
wire   Tpl_647 ;
wire  [7:0] Tpl_648 ;
wire  [7:0] Tpl_649 ;
wire   Tpl_650 ;
wire  [7:0] Tpl_651 ;
wire  [7:0] Tpl_652 ;
wire   Tpl_653 ;
wire  [7:0] Tpl_654 ;
wire  [7:0] Tpl_655 ;
wire   Tpl_656 ;
wire  [7:0] Tpl_657 ;
wire  [7:0] Tpl_658 ;
wire   Tpl_659 ;
wire  [7:0] Tpl_660 ;
wire  [7:0] Tpl_661 ;
wire   Tpl_662 ;
wire  [7:0] Tpl_663 ;
wire  [7:0] Tpl_664 ;
wire   Tpl_665 ;
wire  [7:0] Tpl_666 ;
wire  [7:0] Tpl_667 ;
wire   Tpl_668 ;
wire  [7:0] Tpl_669 ;
wire  [7:0] Tpl_670 ;
wire   Tpl_671 ;
wire  [7:0] Tpl_672 ;
wire  [7:0] Tpl_673 ;
wire   Tpl_674 ;
wire  [7:0] Tpl_675 ;
wire  [7:0] Tpl_676 ;
wire   Tpl_677 ;
wire  [7:0] Tpl_678 ;
wire  [7:0] Tpl_679 ;
wire   Tpl_680 ;
wire  [7:0] Tpl_681 ;
wire  [7:0] Tpl_682 ;
wire   Tpl_683 ;
wire  [7:0] Tpl_684 ;
wire  [7:0] Tpl_685 ;
wire   Tpl_686 ;
wire  [7:0] Tpl_687 ;
wire  [7:0] Tpl_688 ;
wire   Tpl_689 ;
wire  [7:0] Tpl_690 ;
wire  [7:0] Tpl_691 ;
wire   Tpl_692 ;
wire  [7:0] Tpl_693 ;
wire  [7:0] Tpl_694 ;
wire   Tpl_695 ;
wire  [7:0] Tpl_696 ;
wire  [7:0] Tpl_697 ;
wire   Tpl_698 ;
wire  [7:0] Tpl_699 ;
wire  [7:0] Tpl_700 ;
wire   Tpl_701 ;
wire  [7:0] Tpl_702 ;
wire  [7:0] Tpl_703 ;
wire   Tpl_704 ;
wire  [7:0] Tpl_705 ;
wire  [7:0] Tpl_706 ;
wire   Tpl_707 ;
wire  [7:0] Tpl_708 ;
wire  [7:0] Tpl_709 ;
wire   Tpl_710 ;
wire  [7:0] Tpl_711 ;
wire  [7:0] Tpl_712 ;
wire   Tpl_713 ;
wire  [7:0] Tpl_714 ;
wire  [7:0] Tpl_715 ;
wire   Tpl_716 ;
wire  [7:0] Tpl_717 ;
wire  [7:0] Tpl_718 ;
wire   Tpl_719 ;
wire  [7:0] Tpl_720 ;
wire  [7:0] Tpl_721 ;
wire   Tpl_722 ;
wire  [7:0] Tpl_723 ;
wire  [7:0] Tpl_724 ;
wire   Tpl_725 ;
wire  [7:0] Tpl_726 ;
wire  [7:0] Tpl_727 ;
wire   Tpl_728 ;
wire  [7:0] Tpl_729 ;
wire  [7:0] Tpl_730 ;
wire   Tpl_731 ;
wire  [7:0] Tpl_732 ;
wire  [7:0] Tpl_733 ;
wire   Tpl_734 ;
wire  [7:0] Tpl_735 ;
wire  [7:0] Tpl_736 ;
wire   Tpl_737 ;
wire  [7:0] Tpl_738 ;
wire   Tpl_739 ;
wire  [255:0] Tpl_740 ;
wire   Tpl_741 ;
wire  [255:0] Tpl_742 ;
wire   Tpl_743 ;
wire   Tpl_744 ;
wire  [255:0] Tpl_745 ;
wire   Tpl_746 ;
wire  [255:0] Tpl_747 ;
wire  [63:0] Tpl_748 ;
wire  [7:0] Tpl_749 ;
wire  [31:0] Tpl_750 ;
wire  [1:0] Tpl_751 ;
wire   Tpl_752 ;
wire   Tpl_753 ;
wire  [79:0] Tpl_754 ;
wire  [5:0] Tpl_755 ;
wire  [3:0] Tpl_756 ;
wire  [1:0] Tpl_757 ;
wire   Tpl_758 ;
wire   Tpl_759 ;
wire   Tpl_760 ;
wire   Tpl_761 ;
wire  [255:0] Tpl_762 ;
wire  [63:0] Tpl_763 ;
wire  [7:0] Tpl_764 ;
wire  [31:0] Tpl_765 ;
wire   Tpl_766 ;
wire   Tpl_767 ;
wire   Tpl_768 ;
wire   Tpl_769 ;
wire   Tpl_770 ;
wire   Tpl_771 ;
reg   Tpl_772 ;
wire   Tpl_773 ;
wire   Tpl_774 ;
wire   Tpl_775 ;
reg   Tpl_776 ;
wire  [255:0] Tpl_777 ;
wire  [63:0] Tpl_778 ;
wire  [31:0] Tpl_779 ;
wire  [7:0] Tpl_780 ;
wire  [31:0] Tpl_781 ;
wire  [7:0] Tpl_782 ;
wire  [287:0] Tpl_783 ;
wire  [71:0] Tpl_784 ;
wire   Tpl_785 ;
wire   Tpl_786 ;
wire  [1:0] Tpl_787 ;
wire   Tpl_788 ;
wire  [1:0] Tpl_789 ;
wire  [3:0] Tpl_790 ;
wire  [255:0] Tpl_791 ;
wire  [31:0] Tpl_792 ;
wire  [63:0] Tpl_793 ;
wire  [7:0] Tpl_794 ;
wire   Tpl_795 ;
wire   Tpl_796 ;
wire  [79:0] Tpl_797 ;
wire  [5:0] Tpl_798 ;
wire  [31:0] Tpl_799 ;
wire  [7:0] Tpl_800 ;
wire   Tpl_801 ;
wire  [255:0] Tpl_802 ;
wire  [31:0] Tpl_803 ;
wire  [63:0] Tpl_804 ;
wire  [7:0] Tpl_805 ;
wire   Tpl_806 ;
wire   Tpl_807 ;
reg   Tpl_808 ;
reg   Tpl_809 ;
wire   Tpl_810 ;
wire   Tpl_811 ;
wire   Tpl_812 ;
wire   Tpl_813 ;
wire  [255:0] Tpl_814 ;
wire  [31:0] Tpl_815 ;
wire  [63:0] Tpl_816 ;
wire  [7:0] Tpl_817 ;
wire   Tpl_818 ;
reg   Tpl_819 ;
reg   Tpl_820 ;
wire   Tpl_821 ;
wire   Tpl_822 ;
reg   Tpl_823 ;
reg   Tpl_824 ;
reg   Tpl_825 ;
wire   Tpl_826 ;
reg  [31:0] Tpl_827 ;
reg  [31:0] Tpl_828 ;
reg  [7:0] Tpl_829 ;
reg  [7:0] Tpl_830 ;
reg   Tpl_831 ;
wire   Tpl_832 ;
reg   Tpl_833 ;
reg   Tpl_834 ;
wire  [255:0] Tpl_835 ;
wire  [255:0] Tpl_836 ;
wire  [63:0] Tpl_837 ;
wire  [63:0] Tpl_838 ;
wire   Tpl_839 ;
wire   Tpl_840 ;
wire   Tpl_841 ;
wire   Tpl_842 ;
wire  [31:0] Tpl_843 ;
wire  [31:0] Tpl_844 ;
wire  [7:0] Tpl_845 ;
wire  [7:0] Tpl_846 ;
reg   Tpl_847 ;
reg   Tpl_848 ;

typedef enum reg  [4:0] {

 ST_IDLE_1 = 5'h01 , 
 ST_WRTRANS_0_2 = 5'h02 , 
 ST_WRTRANS_1_3 = 5'h04 , 
 ST_WRTRANS_2_4 = 5'h08 , 
 ST_WRTRANS_3_5 = 5'h10
} __typeimpenum0;

wire   Tpl_850 ;
wire   Tpl_851 ;
wire   Tpl_852 ;
wire   Tpl_853 ;
wire  [63:0] Tpl_854 ;
wire  [7:0] Tpl_855 ;
wire  [1:0] Tpl_856 ;
wire  [71:0] Tpl_857 ;
reg  [71:0] Tpl_858 ;
wire  [7:0][8:0] Tpl_859 ;
wire  [8:0][7:0] Tpl_860 ;
reg   Tpl_861 ;
reg   Tpl_862 ;
__typeimpenum0  Tpl_863 ;
__typeimpenum0  Tpl_864 ;
wire  [0:0] Tpl_867 ;
wire   Tpl_868 ;
wire   Tpl_869 ;
wire   Tpl_870 ;
wire   Tpl_871 ;
wire  [0:0] Tpl_872 ;
wire   Tpl_873 ;
wire   Tpl_874 ;
wire   Tpl_875 ;
wire   Tpl_876 ;
wire   Tpl_877 ;
wire  [2:0] Tpl_878 ;
wire  [2:0] Tpl_879 ;
wire  [2:0] Tpl_880 ;
wire  [2:0] Tpl_881 ;
wire   Tpl_882 ;
wire   Tpl_883 ;
wire   Tpl_884 ;
wire   Tpl_885 ;
wire  [2:0] Tpl_886 ;
wire  [2:0] Tpl_887 ;
wire   Tpl_888 ;
wire   Tpl_889 ;
wire   Tpl_890 ;
wire   Tpl_891 ;
wire   Tpl_892 ;
wire  [2:0] Tpl_893 ;
wire  [2:0] Tpl_894 ;
wire  [3:0] Tpl_895 ;
wire   Tpl_896 ;
wire   Tpl_897 ;
wire  [3:0] Tpl_898 ;
wire  [2:0] Tpl_899 ;
wire  [2:0] Tpl_900 ;
wire   Tpl_901 ;
wire   Tpl_902 ;
wire   Tpl_903 ;
wire   Tpl_904 ;
wire   Tpl_905 ;
wire   Tpl_906 ;
wire   Tpl_907 ;
wire   Tpl_908 ;
wire  [3:0] Tpl_909 ;
wire  [2:0] Tpl_910 ;
wire  [2:0] Tpl_911 ;
wire   Tpl_912 ;
wire   Tpl_913 ;
wire   Tpl_914 ;
wire   Tpl_915 ;
wire  [3:0] Tpl_916 ;
wire   Tpl_917 ;
wire   Tpl_918 ;
wire   Tpl_919 ;
wire   Tpl_920 ;
wire   Tpl_921 ;
wire   Tpl_922 ;
wire   Tpl_923 ;
wire   Tpl_924 ;
wire   Tpl_925 ;
wire   Tpl_926 ;
wire   Tpl_927 ;
wire  [3:0] Tpl_928 ;
reg  [3:0] Tpl_929 ;
reg  [3:0] Tpl_930 ;
wire   Tpl_931 ;
wire   Tpl_932 ;
wire   Tpl_933 ;
wire  [2:0] Tpl_934 ;
wire  [3:0] Tpl_935 ;
reg  [2:0] Tpl_936 ;
wire   Tpl_937 ;
wire   Tpl_938 ;
wire   Tpl_939 ;
wire  [2:0] Tpl_940 ;
wire  [3:0] Tpl_941 ;
reg  [2:0] Tpl_942 ;
wire   Tpl_943 ;
wire   Tpl_944 ;
wire   Tpl_945 ;
wire   Tpl_946 ;
wire  [2:0] Tpl_947 ;
wire  [2:0] Tpl_948 ;
wire  [0:0] Tpl_949 ;
wire  [0:0] Tpl_950 ;
wire  [7:0] Tpl_951 ;
wire  [7:0][0:0] Tpl_952 ;
wire   Tpl_953 ;
wire  [7:0][0:0] Tpl_955 ;
wire  [2:0] Tpl_956 ;
wire  [0:0] Tpl_957 ;
wire  [7:0][0:0] Tpl_958 ;
wire   Tpl_961 ;
wire  [2:0] Tpl_962 ;
wire  [7:0] Tpl_963 ;
wire  [0:0] Tpl_964 ;
wire   Tpl_965 ;
wire   Tpl_966 ;
wire   Tpl_967 ;
reg  [0:0] Tpl_968 ;
wire  [0:0] Tpl_969 ;
wire   Tpl_970 ;
wire   Tpl_971 ;
wire   Tpl_972 ;
reg  [0:0] Tpl_973 ;
wire  [0:0] Tpl_974 ;
wire   Tpl_975 ;
wire   Tpl_976 ;
wire   Tpl_977 ;
reg  [0:0] Tpl_978 ;
wire  [0:0] Tpl_979 ;
wire   Tpl_980 ;
wire   Tpl_981 ;
wire   Tpl_982 ;
reg  [0:0] Tpl_983 ;
wire  [0:0] Tpl_984 ;
wire   Tpl_985 ;
wire   Tpl_986 ;
wire   Tpl_987 ;
reg  [0:0] Tpl_988 ;
wire  [0:0] Tpl_989 ;
wire   Tpl_990 ;
wire   Tpl_991 ;
wire   Tpl_992 ;
reg  [0:0] Tpl_993 ;
wire  [0:0] Tpl_994 ;
wire   Tpl_995 ;
wire   Tpl_996 ;
wire   Tpl_997 ;
reg  [0:0] Tpl_998 ;
wire  [0:0] Tpl_999 ;
wire   Tpl_1000 ;
wire   Tpl_1001 ;
wire   Tpl_1002 ;
reg  [0:0] Tpl_1003 ;
wire   Tpl_1004 ;
wire   Tpl_1005 ;
wire   Tpl_1006 ;
wire   Tpl_1007 ;
wire  [63:0] Tpl_1008 ;
wire  [7:0] Tpl_1009 ;
wire  [1:0] Tpl_1010 ;
wire  [71:0] Tpl_1011 ;
reg  [71:0] Tpl_1012 ;
wire  [7:0][8:0] Tpl_1013 ;
wire  [8:0][7:0] Tpl_1014 ;
reg   Tpl_1015 ;
reg   Tpl_1016 ;
__typeimpenum0  Tpl_1017 ;
__typeimpenum0  Tpl_1018 ;
wire   Tpl_1021 ;
wire   Tpl_1022 ;
wire   Tpl_1023 ;
wire   Tpl_1024 ;
wire  [63:0] Tpl_1025 ;
wire  [7:0] Tpl_1026 ;
wire  [1:0] Tpl_1027 ;
wire  [71:0] Tpl_1028 ;
reg  [71:0] Tpl_1029 ;
wire  [7:0][8:0] Tpl_1030 ;
wire  [8:0][7:0] Tpl_1031 ;
reg   Tpl_1032 ;
reg   Tpl_1033 ;
__typeimpenum0  Tpl_1034 ;
__typeimpenum0  Tpl_1035 ;
wire   Tpl_1038 ;
wire   Tpl_1039 ;
wire   Tpl_1040 ;
wire   Tpl_1041 ;
wire  [63:0] Tpl_1042 ;
wire  [7:0] Tpl_1043 ;
wire  [1:0] Tpl_1044 ;
wire  [71:0] Tpl_1045 ;
reg  [71:0] Tpl_1046 ;
wire  [7:0][8:0] Tpl_1047 ;
wire  [8:0][7:0] Tpl_1048 ;
reg   Tpl_1049 ;
reg   Tpl_1050 ;
__typeimpenum0  Tpl_1051 ;
__typeimpenum0  Tpl_1052 ;
wire   Tpl_1055 ;
wire   Tpl_1056 ;
wire   Tpl_1057 ;
wire   Tpl_1058 ;
wire  [63:0] Tpl_1059 ;
wire  [7:0] Tpl_1060 ;
wire  [1:0] Tpl_1061 ;
wire  [71:0] Tpl_1062 ;
reg  [71:0] Tpl_1063 ;
wire  [7:0][8:0] Tpl_1064 ;
wire  [8:0][7:0] Tpl_1065 ;
reg   Tpl_1066 ;
reg   Tpl_1067 ;
__typeimpenum0  Tpl_1068 ;
__typeimpenum0  Tpl_1069 ;
wire   Tpl_1072 ;
wire   Tpl_1073 ;
wire   Tpl_1074 ;
wire  [71:0] Tpl_1075 ;
wire  [7:0] Tpl_1076 ;
reg  [71:0] Tpl_1077 ;
reg  [7:0] Tpl_1078 ;
wire   Tpl_1079 ;
wire   Tpl_1080 ;
wire   Tpl_1081 ;
wire  [71:0] Tpl_1082 ;
wire  [7:0] Tpl_1083 ;
reg  [71:0] Tpl_1084 ;
reg  [7:0] Tpl_1085 ;
wire   Tpl_1086 ;
wire   Tpl_1087 ;
wire   Tpl_1088 ;
wire  [71:0] Tpl_1089 ;
wire  [7:0] Tpl_1090 ;
reg  [71:0] Tpl_1091 ;
reg  [7:0] Tpl_1092 ;
wire   Tpl_1093 ;
wire   Tpl_1094 ;
wire   Tpl_1095 ;
wire  [71:0] Tpl_1096 ;
wire  [7:0] Tpl_1097 ;
reg  [71:0] Tpl_1098 ;
reg  [7:0] Tpl_1099 ;
wire  [255:0] Tpl_1100 ;
wire  [31:0] Tpl_1101 ;
wire   Tpl_1102 ;
wire   Tpl_1103 ;
wire  [255:0] Tpl_1104 ;
wire  [31:0] Tpl_1105 ;
wire  [255:0] Tpl_1106 ;
wire  [31:0] Tpl_1107 ;
wire  [255:0] Tpl_1108 ;
wire   Tpl_1109 ;
wire  [31:0] Tpl_1110 ;
wire  [255:0] Tpl_1111 ;
wire  [31:0] Tpl_1112 ;
wire  [7:0] Tpl_1114 ;
wire   Tpl_1115 ;
wire   Tpl_1116 ;
wire  [7:0] Tpl_1117 ;
wire   Tpl_1118 ;
wire  [3:0] Tpl_1119 ;
wire  [7:0] Tpl_1120 ;
wire   Tpl_1121 ;
wire   Tpl_1122 ;
wire  [7:0] Tpl_1123 ;
wire   Tpl_1124 ;
wire  [3:0] Tpl_1125 ;
wire  [7:0] Tpl_1126 ;
wire   Tpl_1127 ;
wire   Tpl_1128 ;
wire  [7:0] Tpl_1129 ;
wire   Tpl_1130 ;
wire  [3:0] Tpl_1131 ;
wire  [7:0] Tpl_1132 ;
wire   Tpl_1133 ;
wire   Tpl_1134 ;
wire  [7:0] Tpl_1135 ;
wire   Tpl_1136 ;
wire  [3:0] Tpl_1137 ;
wire  [7:0] Tpl_1138 ;
wire   Tpl_1139 ;
wire   Tpl_1140 ;
wire  [7:0] Tpl_1141 ;
wire   Tpl_1142 ;
wire  [3:0] Tpl_1143 ;
wire  [7:0] Tpl_1144 ;
wire   Tpl_1145 ;
wire   Tpl_1146 ;
wire  [7:0] Tpl_1147 ;
wire   Tpl_1148 ;
wire  [3:0] Tpl_1149 ;
wire  [7:0] Tpl_1150 ;
wire   Tpl_1151 ;
wire   Tpl_1152 ;
wire  [7:0] Tpl_1153 ;
wire   Tpl_1154 ;
wire  [3:0] Tpl_1155 ;
wire  [7:0] Tpl_1156 ;
wire   Tpl_1157 ;
wire   Tpl_1158 ;
wire  [7:0] Tpl_1159 ;
wire   Tpl_1160 ;
wire  [3:0] Tpl_1161 ;
wire  [7:0] Tpl_1162 ;
wire   Tpl_1163 ;
wire   Tpl_1164 ;
wire  [7:0] Tpl_1165 ;
wire   Tpl_1166 ;
wire  [3:0] Tpl_1167 ;
wire  [7:0] Tpl_1168 ;
wire   Tpl_1169 ;
wire   Tpl_1170 ;
wire  [7:0] Tpl_1171 ;
wire   Tpl_1172 ;
wire  [3:0] Tpl_1173 ;
wire  [7:0] Tpl_1174 ;
wire   Tpl_1175 ;
wire   Tpl_1176 ;
wire  [7:0] Tpl_1177 ;
wire   Tpl_1178 ;
wire  [3:0] Tpl_1179 ;
wire  [7:0] Tpl_1180 ;
wire   Tpl_1181 ;
wire   Tpl_1182 ;
wire  [7:0] Tpl_1183 ;
wire   Tpl_1184 ;
wire  [3:0] Tpl_1185 ;
wire  [7:0] Tpl_1186 ;
wire   Tpl_1187 ;
wire   Tpl_1188 ;
wire  [7:0] Tpl_1189 ;
wire   Tpl_1190 ;
wire  [3:0] Tpl_1191 ;
wire  [7:0] Tpl_1192 ;
wire   Tpl_1193 ;
wire   Tpl_1194 ;
wire  [7:0] Tpl_1195 ;
wire   Tpl_1196 ;
wire  [3:0] Tpl_1197 ;
wire  [7:0] Tpl_1198 ;
wire   Tpl_1199 ;
wire   Tpl_1200 ;
wire  [7:0] Tpl_1201 ;
wire   Tpl_1202 ;
wire  [3:0] Tpl_1203 ;
wire  [7:0] Tpl_1204 ;
wire   Tpl_1205 ;
wire   Tpl_1206 ;
wire  [7:0] Tpl_1207 ;
wire   Tpl_1208 ;
wire  [3:0] Tpl_1209 ;
wire  [7:0] Tpl_1210 ;
wire   Tpl_1211 ;
wire   Tpl_1212 ;
wire  [7:0] Tpl_1213 ;
wire   Tpl_1214 ;
wire  [3:0] Tpl_1215 ;
wire  [7:0] Tpl_1216 ;
wire   Tpl_1217 ;
wire   Tpl_1218 ;
wire  [7:0] Tpl_1219 ;
wire   Tpl_1220 ;
wire  [3:0] Tpl_1221 ;
wire  [7:0] Tpl_1222 ;
wire   Tpl_1223 ;
wire   Tpl_1224 ;
wire  [7:0] Tpl_1225 ;
wire   Tpl_1226 ;
wire  [3:0] Tpl_1227 ;
wire  [7:0] Tpl_1228 ;
wire   Tpl_1229 ;
wire   Tpl_1230 ;
wire  [7:0] Tpl_1231 ;
wire   Tpl_1232 ;
wire  [3:0] Tpl_1233 ;
wire  [7:0] Tpl_1234 ;
wire   Tpl_1235 ;
wire   Tpl_1236 ;
wire  [7:0] Tpl_1237 ;
wire   Tpl_1238 ;
wire  [3:0] Tpl_1239 ;
wire  [7:0] Tpl_1240 ;
wire   Tpl_1241 ;
wire   Tpl_1242 ;
wire  [7:0] Tpl_1243 ;
wire   Tpl_1244 ;
wire  [3:0] Tpl_1245 ;
wire  [7:0] Tpl_1246 ;
wire   Tpl_1247 ;
wire   Tpl_1248 ;
wire  [7:0] Tpl_1249 ;
wire   Tpl_1250 ;
wire  [3:0] Tpl_1251 ;
wire  [7:0] Tpl_1252 ;
wire   Tpl_1253 ;
wire   Tpl_1254 ;
wire  [7:0] Tpl_1255 ;
wire   Tpl_1256 ;
wire  [3:0] Tpl_1257 ;
wire  [7:0] Tpl_1258 ;
wire   Tpl_1259 ;
wire   Tpl_1260 ;
wire  [7:0] Tpl_1261 ;
wire   Tpl_1262 ;
wire  [3:0] Tpl_1263 ;
wire  [7:0] Tpl_1264 ;
wire   Tpl_1265 ;
wire   Tpl_1266 ;
wire  [7:0] Tpl_1267 ;
wire   Tpl_1268 ;
wire  [3:0] Tpl_1269 ;
wire  [7:0] Tpl_1270 ;
wire   Tpl_1271 ;
wire   Tpl_1272 ;
wire  [7:0] Tpl_1273 ;
wire   Tpl_1274 ;
wire  [3:0] Tpl_1275 ;
wire  [7:0] Tpl_1276 ;
wire   Tpl_1277 ;
wire   Tpl_1278 ;
wire  [7:0] Tpl_1279 ;
wire   Tpl_1280 ;
wire  [3:0] Tpl_1281 ;
wire  [7:0] Tpl_1282 ;
wire   Tpl_1283 ;
wire   Tpl_1284 ;
wire  [7:0] Tpl_1285 ;
wire   Tpl_1286 ;
wire  [3:0] Tpl_1287 ;
wire  [7:0] Tpl_1288 ;
wire   Tpl_1289 ;
wire   Tpl_1290 ;
wire  [7:0] Tpl_1291 ;
wire   Tpl_1292 ;
wire  [3:0] Tpl_1293 ;
wire  [7:0] Tpl_1294 ;
wire   Tpl_1295 ;
wire   Tpl_1296 ;
wire  [7:0] Tpl_1297 ;
wire   Tpl_1298 ;
wire  [3:0] Tpl_1299 ;
wire  [7:0] Tpl_1300 ;
wire   Tpl_1301 ;
wire   Tpl_1302 ;
wire  [7:0] Tpl_1303 ;
wire   Tpl_1304 ;
wire  [3:0] Tpl_1305 ;
wire   Tpl_1306 ;
wire   Tpl_1307 ;
wire   Tpl_1308 ;
wire  [255:0] Tpl_1309 ;
wire  [31:0] Tpl_1310 ;
wire  [255:0] Tpl_1311 ;
wire  [31:0] Tpl_1312 ;
wire   Tpl_1313 ;
wire  [27:0] Tpl_1314 ;
wire   Tpl_1315 ;


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

assign datain_par[(0 * 28)+:28] = {{dfi_act_n_mc[0] , dfi_ca_ctl[((0 * 18) + 17)] , dfi_ca_ctl[(0 * 18)+:14] , dfi_bank_mc[(0 * 4)+:4] , dfi_bg_mc[(0 * 2)+:2]}};
assign dfi_ca_l[(0 * 10)+:10] = dfi_addr[(((0 * (20 - 10)) * 2) + (20 - 10))+:10];
assign dfi_ca[(0 * 19)+:19] = dfi_addr[((0 * 19) + 0)+:19];
assign dfi_ca_l[(1 * 10)+:10] = dfi_addr[(((1 * (20 - 10)) * 2) + (20 - 10))+:10];
assign dfi_ca[(1 * 19)+:19] = dfi_addr[((1 * 19) + 1)+:19];
assign dfi_ca_l[(2 * 10)+:10] = dfi_addr[(((2 * (20 - 10)) * 2) + (20 - 10))+:10];
assign dfi_ca[(2 * 19)+:19] = dfi_addr[((2 * 19) + 2)+:19];
assign dfi_ca_l[(3 * 10)+:10] = dfi_addr[(((3 * (20 - 10)) * 2) + (20 - 10))+:10];
assign dfi_ca[(3 * 19)+:19] = dfi_addr[((3 * 19) + 3)+:19];
assign dfi_rank = (reg_lpddr4_enable ? dfi_cs_n[7:4] : (~dfi_cs_n[7:4]));
assign dram_dmi = dfi_rddata_dbi_n_mc;
assign dram_rdata_correct = dfi_dbi_rddata;
assign dfi_dbi_wrdata_ecc = 0;
assign dfi_dbi_wrdata_ecc_mask = 0;

assign Tpl_146 = clk;
assign Tpl_147 = reset_n;
assign Tpl_148 = reg_ddr4_mr4_cal;
assign Tpl_149 = reg_dfi_freq_ratio;
assign Tpl_150 = dfi_cal_act_n;
assign Tpl_151 = dfi_cal_addr;
assign Tpl_152 = dfi_cal_bank;
assign Tpl_153 = dfi_cal_bg;
assign Tpl_154 = dfi_cal_cke;
assign Tpl_155 = dfi_cal_cs_n;
assign Tpl_156 = dfi_cal_odt;
assign Tpl_157 = dfi_cal_parity;
assign Tpl_158 = dfi_cal_rank_rd;
assign Tpl_159 = dfi_cal_rank_wr;
assign Tpl_160 = dram_cmd;
assign Tpl_161 = dram_cmd_rdy;
assign Tpl_162 = dram_mr_sel;
assign dfi_act_n = Tpl_163;
assign dfi_addr = Tpl_164;
assign dfi_bank = Tpl_165;
assign dfi_bg = Tpl_166;
assign dfi_cke = Tpl_167;
assign dfi_cs_n = Tpl_168;
assign dfi_odt = Tpl_169;
assign dfi_parity = Tpl_170;
assign dfi_rank_rd = Tpl_171;
assign dfi_rank_wr = Tpl_172;

assign Tpl_227 = clk;
assign Tpl_228 = reset_n;
assign Tpl_229 = reg_dfi_freq_ratio;
assign Tpl_230 = dti_data_byte_dis;
assign Tpl_231 = dram_wdata_pc;
assign Tpl_232 = dfi_rddata_mc;
assign Tpl_233 = dmctl_dual_chan_en;
assign Tpl_234 = dram_wstrb_pc;
assign Tpl_235 = dfi_rddata_dbi_n_mc;
assign dfi_rddata_dbi_n_ctrl = Tpl_236;
assign dfi_rddata_ctrl = Tpl_237;
assign dram_wstrb_pc_ctrl = Tpl_238;
assign dram_wdata_pc_ctrl = Tpl_239;

assign Tpl_240 = clk;
assign Tpl_241 = cmd_rdy_nxt;
assign Tpl_242 = dram_bank;
assign Tpl_243 = dram_bg;
assign Tpl_244 = dram_ca;
assign Tpl_245 = dram_cke;
assign Tpl_246 = dram_cmd;
assign Tpl_247 = dram_cs_n;
assign Tpl_248 = dram_lp4_cs;
assign Tpl_249 = dram_rank_rd;
assign Tpl_250 = dram_rank_wr;
assign Tpl_251 = mprw_mode_on;
assign Tpl_252 = reg_ddr4_enable;
assign Tpl_253 = reg_dfi_freq_ratio;
assign Tpl_254 = reg_dram_bl_enc;
assign Tpl_255 = reg_dual_rank;
assign Tpl_256 = reg_lpddr3_enable;
assign Tpl_257 = reg_lpddr4_enable;
assign Tpl_258 = reg_odth4;
assign Tpl_259 = reg_odth8;
assign Tpl_260 = reset_n;
assign dfi_act_n_mc = Tpl_261;
assign dfi_bank_mc = Tpl_262;
assign dfi_bg_mc = Tpl_263;
assign dfi_ca_ctl = Tpl_264;
assign dfi_cke_mc = Tpl_265;
assign dfi_cs_n_mc = Tpl_266;
assign dfi_lp4_cs = Tpl_267;
assign dfi_odt_mc = Tpl_268;
assign dfi_rank_rd_mc = Tpl_269;
assign dfi_rank_wr_crc = Tpl_270;
assign dram_cmd_mrr = Tpl_271;
assign dram_cmd_rd = Tpl_272;
assign dram_cmd_rdy = Tpl_273;
assign dram_cmd_wr = Tpl_274;
assign rank_hold_ext = Tpl_275;
assign xqr_load = Tpl_276;
assign xqw_load = Tpl_277;

assign Tpl_447 = clk;
assign Tpl_448 = reset_n;
assign Tpl_449 = reg_ddr4_enable;
assign Tpl_450 = reg_ddr3_enable;
assign Tpl_451 = reg_lpddr3_enable;
assign Tpl_452 = reg_lpddr4_enable;
assign Tpl_453 = dram_cmd_rdy;
assign Tpl_454 = dram_addr_pc;
assign Tpl_455 = dram_bg_pc;
assign Tpl_456 = dram_bank_pc;
assign Tpl_457 = dram_cmd_pc;
assign Tpl_458 = dram_cs_n_pc;
assign Tpl_459 = dram_cke_pc;
assign Tpl_460 = dram_rank_addr_wr_pc;
assign Tpl_461 = dram_rank_addr_rd_pc;
assign Tpl_462 = dram_wdata_pc_ctrl;
assign Tpl_463 = dram_wstrb_pc_ctrl;
assign Tpl_464 = dram_wdata_enable_pc;
assign Tpl_465 = dram_wdata_valid_pc;
assign Tpl_466 = dram_rdata_enable_pc;
assign Tpl_467 = reg_dfi_freq_ratio;
assign cmd_rdy_nxt = Tpl_468;
assign pc_dram_ca = Tpl_469;
assign pc_dram_bg = Tpl_470;
assign pc_dram_bank = Tpl_471;
assign pc_dram_cmd = Tpl_472;
assign pc_dram_cs_n = Tpl_473;
assign pc_dram_cke = Tpl_474;
assign pc_dram_rank_addr_wr = Tpl_475;
assign pc_dram_rank_addr_rd = Tpl_476;
assign pc_dram_wdata = Tpl_477;
assign pc_dram_wstrb = Tpl_478;
assign pc_dram_wdata_enable = Tpl_479;
assign pc_dram_wdata_valid = Tpl_480;
assign pc_dram_rdata_enable = Tpl_481;
assign pc_dram_addr = Tpl_482;
assign pc_dram_lp4_cs = Tpl_483;

assign Tpl_496 = clk;
assign Tpl_497 = reset_n;
assign Tpl_498 = reg_dfi_freq_ratio;
assign Tpl_499 = reg_lpddr4_enable;
assign Tpl_500 = reg_ddr3_enable;
assign Tpl_501 = reg_lpddr3_enable;
assign Tpl_502 = reg_t_wrdata_en;
assign Tpl_503 = reg_t_rddata_en;
assign Tpl_504 = reg_t_phy_rdlat;
assign Tpl_505 = dram_cmd_rd;
assign Tpl_506 = dram_cmd_wr;
assign Tpl_507 = dram_cmd_mrr;
assign Tpl_508 = dram_cmd_rdy;
assign Tpl_509 = dfi_act_n_mc;
assign Tpl_510 = dfi_bank_mc;
assign Tpl_511 = dfi_bg_mc;
assign Tpl_512 = dfi_cke_mc;
assign Tpl_513 = dfi_cs_n_mc;
assign Tpl_514 = dfi_odt_mc;
assign Tpl_515 = dfi_parity_mc;
assign Tpl_516 = dfi_ca_ctl;
assign Tpl_517 = dfi_lp4_cs;
assign Tpl_518 = dfi_rank_wr_mc;
assign Tpl_519 = dfi_rank_rd_mc;
assign dfi_cal_act_n = Tpl_520;
assign dfi_cal_addr = Tpl_521;
assign dfi_cal_bank = Tpl_522;
assign dfi_cal_bg = Tpl_523;
assign dfi_cal_cke = Tpl_524;
assign dfi_cal_cs_n = Tpl_525;
assign dfi_cal_odt = Tpl_526;
assign dfi_cal_parity = Tpl_527;
assign dfi_cal_rank_rd = Tpl_528;
assign dfi_cal_rank_wr = Tpl_529;
assign Tpl_530 = dfi_wrdata_mc;
assign Tpl_531 = dfi_wrdata_mask_mc;
assign Tpl_532 = dfi_wrdata_en_mc;
assign dfi_wrdata = Tpl_533;
assign dfi_wrdata_mask = Tpl_534;
assign dfi_wrdata_en = Tpl_535;
assign Tpl_536 = dfi_rddata_en_mc;
assign Tpl_537 = dfi_rddata;
assign Tpl_538 = dfi_rddata_dbi_n;
assign Tpl_539 = dfi_rddata_valid;
assign dfi_rddata_en = Tpl_540;
assign dfi_rddata_mc = Tpl_541;
assign dfi_rddata_dbi_n_mc = Tpl_542;
assign dfi_rddata_valid_mc = Tpl_543;

assign Tpl_602 = pc_dram_wdata_enable;
assign Tpl_603 = pc_dram_wdata_valid;
assign Tpl_604 = pc_dram_wdata;
assign Tpl_605 = pc_dram_wstrb;
assign Tpl_606 = pc_dram_rdata_enable;
assign Tpl_607 = pc_dram_rank_addr_wr;
assign Tpl_608 = pc_dram_rank_addr_rd;
assign dram_wdata_enable = Tpl_609;
assign dram_wdata_valid = Tpl_610;
assign dram_wdata = Tpl_611;
assign dram_wstrb = Tpl_612;
assign dram_rdata_enable = Tpl_613;
assign Tpl_614 = pc_dram_cs_n;
assign Tpl_615 = pc_dram_cke;
assign Tpl_616 = pc_dram_bg;
assign Tpl_617 = pc_dram_bank;
assign Tpl_618 = pc_dram_cmd;
assign Tpl_619 = pc_dram_ca;
assign Tpl_620 = pc_dram_lp4_cs;
assign dram_rank_wr = Tpl_621;
assign dram_rank_rd = Tpl_622;
assign dram_cs_n = Tpl_623;
assign dram_bg = Tpl_624;
assign dram_bank = Tpl_625;
assign dram_cmd = Tpl_626;
assign dram_cke = Tpl_627;
assign dram_ca = Tpl_628;
assign dram_lp4_cs = Tpl_629;
assign dram_mr_sel = Tpl_630;

assign Tpl_632 = dfi_rddata_ctrl;
assign Tpl_633 = dfi_rddata_dbi_n_ctrl;
assign Tpl_634 = reg_lpddr4_enable;
assign Tpl_635 = reg_mc_rd_dbi;
assign dfi_dbi_rddata = Tpl_636;

assign Tpl_739 = dram_rdata_enable;
assign Tpl_740 = dfi_dbi_rddata;
assign Tpl_741 = dfi_rddata_valid_mc;
assign Tpl_742 = dram_rdata_correct;
assign dram_rvalid = Tpl_743;
assign dfi_rddata_en_mc = Tpl_744;
assign dram_rdata = Tpl_745;

assign Tpl_746 = clk;
assign Tpl_747 = dfi_dbi_wrdata;
assign Tpl_748 = dfi_dbi_wrdata_ecc;
assign Tpl_749 = dfi_dbi_wrdata_ecc_mask;
assign Tpl_750 = dfi_dbi_wrdata_mask;
assign Tpl_751 = reg_dfi_freq_ratio;
assign Tpl_752 = dfi_rank_wr_crc;
assign Tpl_753 = dram_wdata_enable;
assign Tpl_754 = dram_ca;
assign Tpl_755 = dram_cmd;
assign Tpl_756 = dti_data_byte_dis;
assign Tpl_757 = reg_dram_bl_enc;
assign Tpl_758 = reg_mc_wr_crc;
assign Tpl_759 = reset_n;
assign dfi_rank_wr_mc = Tpl_760;
assign dfi_crc_wrdata_en = Tpl_761;
assign dfi_wrdata_mc = Tpl_762;
assign dfi_wrdata_ecc_mc = Tpl_763;
assign dfi_wrdata_ecc_mask_mc = Tpl_764;
assign dfi_wrdata_mask_mc = Tpl_765;

assign Tpl_1100 = dfi_if_wrdata;
assign Tpl_1101 = dfi_if_wrdata_mask;
assign Tpl_1102 = reg_lpddr4_enable;
assign Tpl_1103 = reg_mc_wr_dbi;
assign dfi_dbi_wrdata = Tpl_1104;
assign dfi_dbi_wrdata_mask = Tpl_1105;

assign Tpl_1306 = reg_ddr4_enable;
assign Tpl_1307 = dfi_crc_wrdata_en;
assign Tpl_1308 = dram_wdata_valid;
assign Tpl_1309 = dram_wdata;
assign Tpl_1310 = dram_wstrb;
assign dfi_if_wrdata = Tpl_1311;
assign dfi_if_wrdata_mask = Tpl_1312;
assign dfi_wrdata_en_mc = Tpl_1313;

assign Tpl_1314 = datain_par[27:0];
assign dfi_parity_mc[0] = Tpl_1315;

function integer   ceil_log2_6;
input integer   data ;
integer   i ;
ceil_log2_6 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_6 = (i + 1);

end
endfunction


function integer   last_one_7;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_7 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_7 = (i + 1);
end

end
endfunction


function integer   floor_log2_8;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_8 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_8 = ceil_log2;
else
floor_log2_8 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_9;
input integer   N ;
integer   i ;
is_onethot_9 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_9 = 1;
end
end

end
endfunction


function integer   ecc_width_10;
input integer   data_width ;
integer   i ;
ecc_width_10 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_9(i)))
begin
ecc_width_10 = (ecc_width_10 + 1);
end
end

end
endfunction


always @( posedge Tpl_146 or negedge Tpl_147 )
begin
if ((~Tpl_147))
begin
Tpl_223 <= 0;
Tpl_224 <= 0;
end
else
begin
Tpl_223 <= (Tpl_149 == 2'b01);
Tpl_224 <= (Tpl_149 == 2'b10);
end
end

assign Tpl_173 = Tpl_150;
assign Tpl_174 = Tpl_151;
assign Tpl_175 = Tpl_152;
assign Tpl_176 = Tpl_153;
assign Tpl_177 = Tpl_157;
assign Tpl_178 = Tpl_158;
assign Tpl_179 = Tpl_159;
assign Tpl_163 = Tpl_187;
assign Tpl_164 = Tpl_188;
assign Tpl_165 = Tpl_189;
assign Tpl_166 = Tpl_190;
assign Tpl_170 = Tpl_191;
assign Tpl_171 = Tpl_192;
assign Tpl_172 = Tpl_193;
assign Tpl_168 = Tpl_155;
assign Tpl_167 = Tpl_154;
assign Tpl_169 = Tpl_156;
assign Tpl_180[0][0] = Tpl_173[0][0];
assign Tpl_181[0][0] = Tpl_174[0][0];
assign Tpl_182[0][0] = Tpl_175[0][0];
assign Tpl_183[0][0] = Tpl_176[0][0];
assign Tpl_184[0][0] = Tpl_177[0][0];
assign Tpl_187[0][0] = Tpl_194[0][0];
assign Tpl_188[0][0] = Tpl_195[0][0];
assign Tpl_189[0][0] = Tpl_196[0][0];
assign Tpl_190[0][0] = Tpl_197[0][0];
assign Tpl_191[0][0] = Tpl_198[0][0];
assign Tpl_185[0] = Tpl_178[0];
assign Tpl_186[0] = Tpl_179[0];
assign Tpl_192[0] = Tpl_199[0];
assign Tpl_193[0] = Tpl_200[0];
assign Tpl_201[0] = {{Tpl_180[0] , Tpl_181[0] , Tpl_182[0] , Tpl_183[0] , Tpl_184[0] , Tpl_185[0] , Tpl_186[0]}};
assign {{Tpl_194[0] , Tpl_195[0] , Tpl_196[0] , Tpl_197[0] , Tpl_198[0] , Tpl_199[0] , Tpl_200[0]}} = Tpl_210[0];
assign Tpl_180[1][0] = Tpl_173[0][1];
assign Tpl_181[1][0] = Tpl_174[0][1];
assign Tpl_182[1][0] = Tpl_175[0][1];
assign Tpl_183[1][0] = Tpl_176[0][1];
assign Tpl_184[1][0] = Tpl_177[0][1];
assign Tpl_187[0][1] = Tpl_194[1][0];
assign Tpl_188[0][1] = Tpl_195[1][0];
assign Tpl_189[0][1] = Tpl_196[1][0];
assign Tpl_190[0][1] = Tpl_197[1][0];
assign Tpl_191[0][1] = Tpl_198[1][0];
assign Tpl_185[1] = Tpl_178[1];
assign Tpl_186[1] = Tpl_179[1];
assign Tpl_192[1] = Tpl_199[1];
assign Tpl_193[1] = Tpl_200[1];
assign Tpl_201[1] = {{Tpl_180[1] , Tpl_181[1] , Tpl_182[1] , Tpl_183[1] , Tpl_184[1] , Tpl_185[1] , Tpl_186[1]}};
assign {{Tpl_194[1] , Tpl_195[1] , Tpl_196[1] , Tpl_197[1] , Tpl_198[1] , Tpl_199[1] , Tpl_200[1]}} = Tpl_210[1];
assign Tpl_180[2][0] = Tpl_173[0][2];
assign Tpl_181[2][0] = Tpl_174[0][2];
assign Tpl_182[2][0] = Tpl_175[0][2];
assign Tpl_183[2][0] = Tpl_176[0][2];
assign Tpl_184[2][0] = Tpl_177[0][2];
assign Tpl_187[0][2] = Tpl_194[2][0];
assign Tpl_188[0][2] = Tpl_195[2][0];
assign Tpl_189[0][2] = Tpl_196[2][0];
assign Tpl_190[0][2] = Tpl_197[2][0];
assign Tpl_191[0][2] = Tpl_198[2][0];
assign Tpl_185[2] = Tpl_178[2];
assign Tpl_186[2] = Tpl_179[2];
assign Tpl_192[2] = Tpl_199[2];
assign Tpl_193[2] = Tpl_200[2];
assign Tpl_201[2] = {{Tpl_180[2] , Tpl_181[2] , Tpl_182[2] , Tpl_183[2] , Tpl_184[2] , Tpl_185[2] , Tpl_186[2]}};
assign {{Tpl_194[2] , Tpl_195[2] , Tpl_196[2] , Tpl_197[2] , Tpl_198[2] , Tpl_199[2] , Tpl_200[2]}} = Tpl_210[2];
assign Tpl_180[3][0] = Tpl_173[0][3];
assign Tpl_181[3][0] = Tpl_174[0][3];
assign Tpl_182[3][0] = Tpl_175[0][3];
assign Tpl_183[3][0] = Tpl_176[0][3];
assign Tpl_184[3][0] = Tpl_177[0][3];
assign Tpl_187[0][3] = Tpl_194[3][0];
assign Tpl_188[0][3] = Tpl_195[3][0];
assign Tpl_189[0][3] = Tpl_196[3][0];
assign Tpl_190[0][3] = Tpl_197[3][0];
assign Tpl_191[0][3] = Tpl_198[3][0];
assign Tpl_185[3] = Tpl_178[3];
assign Tpl_186[3] = Tpl_179[3];
assign Tpl_192[3] = Tpl_199[3];
assign Tpl_193[3] = Tpl_200[3];
assign Tpl_201[3] = {{Tpl_180[3] , Tpl_181[3] , Tpl_182[3] , Tpl_183[3] , Tpl_184[3] , Tpl_185[3] , Tpl_186[3]}};
assign {{Tpl_194[3] , Tpl_195[3] , Tpl_196[3] , Tpl_197[3] , Tpl_198[3] , Tpl_199[3] , Tpl_200[3]}} = Tpl_210[3];
assign Tpl_213 = (((|(Tpl_222 ^ Tpl_148)) & (~(|(Tpl_211 ^ 6'b010000)))) & (~(|(Tpl_212 ^ 3'b100))));

always @( posedge Tpl_146 or negedge Tpl_147 )
begin
if ((!Tpl_147))
begin
Tpl_211 <= 6'h00;
Tpl_212 <= 3'h0;
end
else
begin
if (Tpl_161)
begin
Tpl_211 <= Tpl_160;
Tpl_212 <= Tpl_162;
end
end
end


always @( posedge Tpl_146 or negedge Tpl_147 )
begin
if ((!Tpl_147))
begin
Tpl_222 <= 3'h0;
end
else
begin
if (Tpl_221)
begin
Tpl_222 <= Tpl_148;
end
end
end


always @( posedge Tpl_146 )
begin
Tpl_202 <= Tpl_201;
Tpl_203 <= Tpl_202;
Tpl_204 <= Tpl_203;
Tpl_205 <= Tpl_204;
Tpl_206 <= Tpl_205;
Tpl_207 <= Tpl_206;
Tpl_208 <= Tpl_207;
Tpl_209 <= Tpl_208;
Tpl_214 <= Tpl_213;
Tpl_215 <= Tpl_214;
Tpl_216 <= Tpl_215;
Tpl_217 <= Tpl_216;
Tpl_218 <= Tpl_217;
Tpl_219 <= Tpl_218;
Tpl_220 <= Tpl_219;
Tpl_221 <= Tpl_220;
end


always @(*)
begin
case (Tpl_222)
3'b001: Tpl_210 = (Tpl_224 ? {{Tpl_201[0] , Tpl_202[3] , Tpl_202[2] , Tpl_202[1]}} : (Tpl_223 ? {{Tpl_202[2] , Tpl_202[1] , Tpl_202[0] , Tpl_203[1]}} : Tpl_204));
3'b010: Tpl_210 = (Tpl_224 ? Tpl_202 : (Tpl_223 ? Tpl_203 : Tpl_205));
3'b011: Tpl_210 = (Tpl_224 ? {{Tpl_202[2] , Tpl_202[1] , Tpl_202[0] , Tpl_203[3]}} : (Tpl_223 ? {{Tpl_203[2] , Tpl_203[1] , Tpl_203[0] , Tpl_204[1]}} : Tpl_206));
3'b100: Tpl_210 = (Tpl_224 ? {{Tpl_202[1] , Tpl_202[0] , Tpl_203[3] , Tpl_203[2]}} : (Tpl_223 ? Tpl_204 : Tpl_207));
3'b101: Tpl_210 = (Tpl_224 ? Tpl_203 : (Tpl_223 ? Tpl_205 : Tpl_209));
default: Tpl_210 = Tpl_201;
endcase
end


always @(*)
begin
case ({{Tpl_230 , Tpl_233}})
5'b00000: begin
Tpl_238 = Tpl_234;
end
5'b00001: begin
if ((4 == 2))
begin
Tpl_238 = {{2'b00 , Tpl_234[7:6] , 2'b00 , Tpl_234[5:4] , 2'b00 , Tpl_234[3:2] , 2'b00 , Tpl_234[1:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_238 = {{16'b0000000000000000 , 2'b00 , Tpl_234[7:6] , 2'b00 , Tpl_234[5:4] , 2'b00 , Tpl_234[3:2] , 2'b00 , Tpl_234[1:0]}};
end
else
begin
Tpl_238 = {{2'b00 , Tpl_234[15:14] , 2'b00 , Tpl_234[13:12] , 2'b00 , Tpl_234[11:10] , 2'b00 , Tpl_234[9:8] , 2'b00 , Tpl_234[7:6] , 2'b00 , Tpl_234[5:4] , 2'b00 , Tpl_234[3:2] , 2'b00 , Tpl_234[1:0]}};
end
end
end
5'b11000: begin
if ((4 == 2))
begin
Tpl_238 = {{4'b0000 , Tpl_234[7:4] , 4'b0000 , Tpl_234[3:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_238 = {{16'b0000000000000000 , 2'b00 , Tpl_234[7:6] , 2'b00 , Tpl_234[5:4] , 2'b00 , Tpl_234[3:2] , 2'b00 , Tpl_234[1:0]}};
end
else
begin
Tpl_238 = {{2'b00 , Tpl_234[15:14] , 2'b00 , Tpl_234[13:12] , 2'b00 , Tpl_234[11:10] , 2'b00 , Tpl_234[9:8] , 2'b00 , Tpl_234[7:6] , 2'b00 , Tpl_234[5:4] , 2'b00 , Tpl_234[3:2] , 2'b00 , Tpl_234[1:0]}};
end
end
end
default: Tpl_238 = Tpl_234;
endcase
end


always @(*)
begin
case ({{Tpl_230 , Tpl_233}})
5'b00000: begin
Tpl_239 = Tpl_231;
end
5'b00001: begin
if ((4 == 2))
begin
Tpl_239 = {{16'b0000000000000000 , Tpl_231[63:48] , 16'b0000000000000000 , Tpl_231[47:32] , 16'b0000000000000000 , Tpl_231[31:16] , 16'b0000000000000000 , Tpl_231[15:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_239 = {{128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 , 16'b0000000000000000 , Tpl_231[63:48] , 16'b0000000000000000 , Tpl_231[47:32] , 16'b0000000000000000 , Tpl_231[31:16] , 16'b0000000000000000 , Tpl_231[15:0]}};
end
else
begin
Tpl_239 = {{16'b0000000000000000 , Tpl_231[128:112] , 16'b0000000000000000 , Tpl_231[111:96] , 16'b0000000000000000 , Tpl_231[95:80] , 16'b0000000000000000 , Tpl_231[79:64] , 16'b0000000000000000 , Tpl_231[63:48] , 16'b0000000000000000 , Tpl_231[47:32] , 16'b0000000000000000 , Tpl_231[31:16] , 16'b0000000000000000 , Tpl_231[15:0]}};
end
end
end
5'b11000: begin
if ((4 == 2))
begin
Tpl_239 = {{16'b0000000000000000 , Tpl_231[63:48] , 16'b0000000000000000 , Tpl_231[47:32] , 16'b0000000000000000 , Tpl_231[31:16] , 16'b0000000000000000 , Tpl_231[15:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_239 = {{128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 , 16'b0000000000000000 , Tpl_231[63:48] , 16'b0000000000000000 , Tpl_231[47:32] , 16'b0000000000000000 , Tpl_231[31:16] , 16'b0000000000000000 , Tpl_231[15:0]}};
end
else
begin
Tpl_239 = {{16'b0000000000000000 , Tpl_231[128:112] , 16'b0000000000000000 , Tpl_231[111:96] , 16'b0000000000000000 , Tpl_231[95:80] , 16'b0000000000000000 , Tpl_231[79:64] , 16'b0000000000000000 , Tpl_231[63:48] , 16'b0000000000000000 , Tpl_231[47:32] , 16'b0000000000000000 , Tpl_231[31:16] , 16'b0000000000000000 , Tpl_231[15:0]}};
end
end
end
default: Tpl_239 = Tpl_231;
endcase
end


always @(*)
begin
case ({{Tpl_230 , Tpl_233}})
5'b00000: begin
Tpl_237 = Tpl_232;
end
5'b00001: begin
if ((4 == 2))
begin
Tpl_237 = {{64'b0000000000000000000000000000000000000000000000000000000000000000 , Tpl_232[111:96] , Tpl_232[79:64] , Tpl_232[47:32] , Tpl_232[15:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_237 = {{128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 , 64'b0000000000000000000000000000000000000000000000000000000000000000 , Tpl_232[111:96] , Tpl_232[79:64] , Tpl_232[47:32] , Tpl_232[15:0]}};
end
else
begin
Tpl_237 = {{128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 , Tpl_232[239:224] , Tpl_232[207:192] , Tpl_232[175:160] , Tpl_232[143:128] , Tpl_232[111:96] , Tpl_232[79:64] , Tpl_232[47:32] , Tpl_232[15:0]}};
end
end
end
5'b11000: begin
if ((4 == 2))
begin
Tpl_237 = {{64'b0000000000000000000000000000000000000000000000000000000000000000 , Tpl_232[111:96] , Tpl_232[79:64] , Tpl_232[47:32] , Tpl_232[15:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_237 = {{128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 , 64'b0000000000000000000000000000000000000000000000000000000000000000 , Tpl_232[111:96] , Tpl_232[79:64] , Tpl_232[47:32] , Tpl_232[15:0]}};
end
else
begin
Tpl_237 = {{128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 , Tpl_232[239:224] , Tpl_232[207:192] , Tpl_232[175:160] , Tpl_232[143:128] , Tpl_232[111:96] , Tpl_232[79:64] , Tpl_232[47:32] , Tpl_232[15:0]}};
end
end
end
default: Tpl_237 = Tpl_232;
endcase
end


always @(*)
begin
case ({{Tpl_230 , Tpl_233}})
5'b00000: begin
Tpl_236 = Tpl_235;
end
5'b00001: begin
if ((4 == 2))
begin
Tpl_236 = {{8'b00000000 , Tpl_235[13:12] , Tpl_235[9:8] , Tpl_235[5:4] , Tpl_235[1:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_236 = {{16'b0000000000000000 , 8'b00000000 , Tpl_235[13:12] , Tpl_235[9:8] , Tpl_235[5:4] , Tpl_235[1:0]}};
end
else
begin
Tpl_236 = {{16'b0000000000000000 , Tpl_235[29:28] , Tpl_235[25:24] , Tpl_235[21:20] , Tpl_235[17:16] , Tpl_235[13:12] , Tpl_235[9:8] , Tpl_235[5:4] , Tpl_235[1:0]}};
end
end
end
5'b11000: begin
if ((4 == 2))
begin
Tpl_236 = {{8'b00000000 , Tpl_235[13:12] , Tpl_235[9:8] , Tpl_235[5:4] , Tpl_235[1:0]}};
end
else
begin
if ((Tpl_229 == 2'b01))
begin
Tpl_236 = {{16'b0000000000000000 , 8'b00000000 , Tpl_235[13:12] , Tpl_235[9:8] , Tpl_235[5:4] , Tpl_235[1:0]}};
end
else
begin
Tpl_236 = {{16'b0000000000000000 , Tpl_235[29:28] , Tpl_235[25:24] , Tpl_235[21:20] , Tpl_235[17:16] , Tpl_235[13:12] , Tpl_235[9:8] , Tpl_235[5:4] , Tpl_235[1:0]}};
end
end
end
default: Tpl_236 = Tpl_235;
endcase
end

assign Tpl_275 = 1'b0;

assign Tpl_285 = Tpl_240;
assign Tpl_286 = Tpl_260;
assign Tpl_287 = Tpl_254;
assign Tpl_288 = Tpl_256;
assign Tpl_289 = Tpl_257;
assign Tpl_290 = Tpl_273;
assign Tpl_291 = Tpl_247;
assign Tpl_292 = Tpl_246;
assign Tpl_278 = Tpl_293;
assign Tpl_274 = Tpl_294;
assign Tpl_272 = Tpl_295;
assign Tpl_271 = Tpl_296;
assign Tpl_281 = Tpl_297;
assign Tpl_279 = Tpl_298;
assign Tpl_284 = Tpl_299;
assign Tpl_280 = Tpl_300;
assign Tpl_283 = Tpl_301;
assign Tpl_282 = Tpl_302;

assign Tpl_320 = Tpl_240;
assign Tpl_321 = Tpl_260;
assign Tpl_322 = Tpl_252;
assign Tpl_323 = Tpl_257;
assign Tpl_324 = Tpl_253;
assign Tpl_325 = Tpl_281;
assign Tpl_326 = Tpl_279;
assign Tpl_327 = Tpl_280;
assign Tpl_328 = Tpl_282;
assign Tpl_329 = Tpl_246;
assign Tpl_330 = Tpl_243;
assign Tpl_331 = Tpl_242;
assign Tpl_332 = Tpl_250;
assign Tpl_333 = Tpl_249;
assign Tpl_334 = Tpl_244;
assign Tpl_335 = Tpl_248;
assign Tpl_336 = Tpl_241;
assign Tpl_273 = Tpl_337;
assign Tpl_270 = Tpl_338;
assign Tpl_269 = Tpl_339;
assign Tpl_261 = Tpl_340;
assign Tpl_263 = Tpl_341;
assign Tpl_262 = Tpl_342;
assign Tpl_264 = Tpl_343;
assign Tpl_267 = Tpl_344;

assign Tpl_365 = Tpl_240;
assign Tpl_366 = Tpl_260;
assign Tpl_367 = Tpl_251;
assign Tpl_368 = Tpl_279;
assign Tpl_369 = Tpl_273;
assign Tpl_370 = Tpl_272;
assign Tpl_371 = Tpl_271;
assign Tpl_372 = Tpl_274;
assign Tpl_277 = Tpl_373;
assign Tpl_276 = Tpl_374;

assign Tpl_379 = Tpl_240;
assign Tpl_380 = Tpl_260;
assign Tpl_381 = Tpl_281;
assign Tpl_382 = Tpl_279;
assign Tpl_383 = Tpl_280;
assign Tpl_384 = Tpl_283[1:0];
assign Tpl_385 = Tpl_282;
assign Tpl_386 = Tpl_273;
assign Tpl_387 = Tpl_274;
assign Tpl_388 = Tpl_272;
assign Tpl_389 = Tpl_247[1:0];
assign Tpl_266[1:0] = Tpl_390;

assign Tpl_397 = Tpl_240;
assign Tpl_398 = Tpl_260;
assign Tpl_399 = Tpl_281;
assign Tpl_400 = Tpl_279;
assign Tpl_401 = Tpl_282;
assign Tpl_402 = Tpl_273;
assign Tpl_403 = Tpl_245[1:0];
assign Tpl_404 = Tpl_280;
assign Tpl_405 = Tpl_247[1:0];
assign Tpl_265[1:0] = Tpl_406;

assign Tpl_413 = Tpl_240;
assign Tpl_414 = Tpl_260;
assign Tpl_415 = Tpl_255[0];
assign Tpl_416 = Tpl_258[7:0];
assign Tpl_417 = Tpl_259[7:0];
assign Tpl_418 = Tpl_278;
assign Tpl_419 = Tpl_274;
assign Tpl_420 = Tpl_272;
assign Tpl_421 = Tpl_279;
assign Tpl_422 = Tpl_251;
assign Tpl_423 = Tpl_273;
assign Tpl_424 = Tpl_247[1:0];
assign Tpl_268[0] = Tpl_425;

function integer   ceil_log2_11;
input integer   data ;
integer   i ;
ceil_log2_11 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_11 = (i + 1);

end
endfunction


function integer   last_one_12;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_12 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_12 = (i + 1);
end

end
endfunction


function integer   floor_log2_13;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_13 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_13 = ceil_log2;
else
floor_log2_13 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_14;
input integer   N ;
integer   i ;
is_onethot_14 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_14 = 1;
end
end

end
endfunction


function integer   ecc_width_15;
input integer   data_width ;
integer   i ;
ecc_width_15 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_14(i)))
begin
ecc_width_15 = (ecc_width_15 + 1);
end
end

end
endfunction

assign Tpl_317 = (Tpl_288 | Tpl_289);
assign Tpl_304 = Tpl_291;
assign Tpl_309 = (Tpl_304 | Tpl_303);
assign Tpl_308 = (&Tpl_306);
assign Tpl_307 = (&Tpl_305);
assign Tpl_313 = (&Tpl_311);
assign Tpl_312 = (&Tpl_310);
assign Tpl_316 = ((~(Tpl_308 & Tpl_307)) & Tpl_302);
assign Tpl_297 = (~(Tpl_308 | Tpl_307));
assign Tpl_298 = ((~Tpl_307) | (Tpl_315 & (Tpl_294 | Tpl_295)));
assign Tpl_301 = {{Tpl_307 , Tpl_308}};
assign Tpl_294 = ((((~(|(Tpl_292 ^ 6'b010100))) & (~Tpl_317)) | ((~(|(Tpl_292 ^ 6'b100111))) & Tpl_317)) | ((~(|(Tpl_292 ^ 6'b101000))) & Tpl_317));
assign Tpl_295 = (((~(|(Tpl_292 ^ 6'b010101))) & (~Tpl_317)) | ((~(|(Tpl_292 ^ 6'b101001))) & Tpl_317));
assign Tpl_296 = ((~(|(Tpl_292 ^ 6'b100001))) & Tpl_317);
assign Tpl_293 = (Tpl_287[1] & (~Tpl_287[0]));
assign Tpl_300 = 1'b1;
assign Tpl_299[0] = (&Tpl_305[0]);
assign Tpl_306[0][0] = Tpl_304[0][(0 * 2)];
assign Tpl_305[0][0] = Tpl_304[0][((0 * 2) + 1)];
assign Tpl_311[0][0] = Tpl_309[0][(0 * 2)];
assign Tpl_310[0][0] = Tpl_309[0][((0 * 2) + 1)];

always @(*)
begin
case ({{Tpl_292 , Tpl_317}})
{{6'b010010 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010000 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010001 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010110 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b001111 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010111 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b000001 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010011 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010101 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010100 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b010100 , 1'b0}}: Tpl_302 = (~(&Tpl_291));
{{6'b101010 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100000 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100001 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100011 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100010 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b010001 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b110001 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100100 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b111000 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100101 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100110 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b101001 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b100111 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b101000 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b101100 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b111001 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b111010 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
{{6'b110010 , 1'b1}}: Tpl_302 = (~(&Tpl_291));
default: Tpl_302 = '0;
endcase
end


always @( posedge Tpl_285 or negedge Tpl_286 )
begin
if ((~Tpl_286))
begin
Tpl_303 <= 2'h3;
Tpl_315 <= '0;
end
else
if ((Tpl_316 & Tpl_290))
begin
Tpl_303 <= Tpl_291;
Tpl_315 <= Tpl_298;
end
end


function integer   ceil_log2_16;
input integer   data ;
integer   i ;
ceil_log2_16 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_16 = (i + 1);

end
endfunction


function integer   last_one_17;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_17 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_17 = (i + 1);
end

end
endfunction


function integer   floor_log2_18;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_18 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_18 = ceil_log2;
else
floor_log2_18 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_19;
input integer   N ;
integer   i ;
is_onethot_19 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_19 = 1;
end
end

end
endfunction


function integer   ecc_width_20;
input integer   data_width ;
integer   i ;
ecc_width_20 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_19(i)))
begin
ecc_width_20 = (ecc_width_20 + 1);
end
end

end
endfunction

assign Tpl_337 = Tpl_345[0];
assign Tpl_342 = Tpl_347;
assign Tpl_341 = Tpl_346;
assign Tpl_343 = Tpl_355;
assign Tpl_344 = Tpl_356;
assign Tpl_353 = 1'b0;

always @( posedge Tpl_320 or negedge Tpl_321 )
begin
if ((~Tpl_321))
begin
Tpl_340[0] <= '0;
Tpl_346[0] <= 2'h0;
Tpl_347[0] <= 4'h0;
end
else
if (Tpl_337)
begin
Tpl_340[0] <= (~((Tpl_329 == 6'b010011) & Tpl_322));
Tpl_346[0] <= Tpl_350[0];
Tpl_347[0] <= Tpl_351[0];
end
else
if (Tpl_352)
begin
Tpl_346[0] <= Tpl_348[0];
Tpl_347[0] <= Tpl_349[0];
end
end


always @( posedge Tpl_320 or negedge Tpl_321 )
begin
if ((~Tpl_321))
begin
Tpl_348[0] <= 2'h0;
Tpl_349[0] <= 4'h0;
end
else
if (Tpl_337)
begin
if (Tpl_327)
begin
Tpl_348[0] <= Tpl_350[0];
Tpl_349[0] <= Tpl_351[0];
end
else
begin
Tpl_348[0] <= Tpl_330;
Tpl_349[0] <= Tpl_331;
end
end
else
if (Tpl_352)
begin
Tpl_348[0] <= 2'h0;
Tpl_349[0] <= 4'h0;
end
end

assign Tpl_350 = Tpl_330;
assign Tpl_351 = Tpl_331;

always @(*)
begin
end


always @( posedge Tpl_320 or negedge Tpl_321 )
begin
if ((~Tpl_321))
begin
Tpl_345 <= 3'h0;
end
else
if (Tpl_337)
begin
if (Tpl_328)
begin
Tpl_345 <= Tpl_336;
end
else
begin
Tpl_345 <= 3'h7;
end
end
else
begin
Tpl_345 <= {{1'b1 , Tpl_345[2:1]}};
end
end


always @( posedge Tpl_320 or negedge Tpl_321 )
begin
if ((~Tpl_321))
begin
Tpl_354 <= 1'b0;
end
else
if (Tpl_337)
begin
Tpl_354 <= Tpl_325;
end
end


always @( posedge Tpl_320 or negedge Tpl_321 )
begin
if ((~Tpl_321))
begin
Tpl_352 <= 1'b0;
end
else
if (Tpl_337)
begin
Tpl_352 <= Tpl_353;
end
else
if (Tpl_352)
begin
Tpl_352 <= 1'b0;
end
else
begin
Tpl_352 <= 1'b0;
end
end

assign Tpl_338 = Tpl_332;
assign Tpl_339 = Tpl_333;
assign Tpl_359 = {{3'b000 , Tpl_335 , 4'b0000}};
assign Tpl_362 = ((Tpl_324 == 2'b00) ? {{1'b0 , Tpl_358[(1+8):1]}} : ((Tpl_324 == 2'b01) ? {{2'b00 , Tpl_358[(2+7):2]}} : {{4'b0000 , Tpl_358[(4+5):4]}}));

always @( posedge Tpl_320 or negedge Tpl_321 )
begin
if ((~Tpl_321))
begin
Tpl_358 <= 0;
end
else
begin
Tpl_358 <= (Tpl_359 | Tpl_362);
end
end

assign Tpl_356 = Tpl_358[(0+6):0];
assign Tpl_360 = (Tpl_323 ? {{({{(60){{1'b0}}}}) , Tpl_334 , ({{(60){{1'b0}}}})}} : Tpl_334);
assign Tpl_361[0] = ((Tpl_324 == 2'b00) ? {{({{(20){{1'b0}}}}) , Tpl_357[0][(1+8):1]}} : ((Tpl_324 == 2'b01) ? {{({{(40){{1'b0}}}}) , Tpl_357[0][(2+7):2]}} : {{({{(80){{1'b0}}}}) , Tpl_357[0][(4+5):4]}}));

always @( posedge Tpl_320 or negedge Tpl_321 )
begin
if ((~Tpl_321))
begin
Tpl_357[0] <= 0;
end
else
begin
Tpl_357[0] <= (Tpl_360 | Tpl_361[0]);
end
end

assign Tpl_355[0] = Tpl_357[0][(0+6):0];
assign Tpl_373 = (Tpl_377[0] & (~Tpl_367));
assign Tpl_374 = Tpl_378[0];

always @(*)
begin
Tpl_375 = {{1'b0 , 1'b0 , Tpl_372}};
end


always @(*)
begin
Tpl_376 = {{1'b0 , 1'b0 , (Tpl_370 | Tpl_371)}};
end


always @( posedge Tpl_365 or negedge Tpl_366 )
begin
if ((~Tpl_366))
begin
Tpl_377 <= {{1'b0 , 1'b0 , 1'b0}};
Tpl_378 <= {{1'b0 , 1'b0 , 1'b0}};
end
else
if (Tpl_369)
begin
Tpl_377 <= Tpl_375;
Tpl_378 <= Tpl_376;
end
else
begin
Tpl_377 <= {{1'b0 , Tpl_377[2:1]}};
Tpl_378 <= {{1'b0 , Tpl_378[2:1]}};
end
end

assign Tpl_392 = (Tpl_385 & Tpl_386);
assign Tpl_394 = Tpl_391[0];
assign Tpl_390 = (Tpl_394 | Tpl_393);
assign Tpl_396 = ((Tpl_387 | Tpl_388) ? Tpl_384 : (Tpl_383 ? 2'b01 : 2'b10));

always @(*)
begin
Tpl_395 = {{2'b11 , 2'b11 , 2'b11 , Tpl_384}};
case ({{Tpl_381 , Tpl_382}})
2'b00: Tpl_395 = {{2'b11 , 2'b11 , 2'b11 , Tpl_384}};
2'b01: Tpl_395 = {{2'b11 , 2'b11 , 2'b11 , Tpl_396}};
2'b10: Tpl_395 = {{2'b11 , 2'b11 , 2'b11 , 2'b00}};
2'b11: Tpl_395 = {{2'b11 , 2'b11 , 2'b11 , 2'b00}};
default: Tpl_395 = 8'b00000000;
endcase
end


always @( posedge Tpl_379 or negedge Tpl_380 )
begin
if ((~Tpl_380))
begin
Tpl_393 <= 2'h3;
end
else
if (Tpl_392)
begin
Tpl_393 <= Tpl_389;
end
end


always @( posedge Tpl_379 or negedge Tpl_380 )
begin
if ((~Tpl_380))
begin
Tpl_391 <= 2'h0;
end
else
if (Tpl_386)
begin
if (Tpl_385)
begin
Tpl_391 <= Tpl_395;
end
else
begin
Tpl_391 <= Tpl_389;
end
end
else
begin
Tpl_391 <= {{Tpl_389 , Tpl_391[(1+2):1]}};
end
end

assign Tpl_408 = (Tpl_401 & Tpl_402);
assign Tpl_406 = Tpl_407[0];
assign Tpl_411 = (Tpl_404 ? {{Tpl_410[1] , Tpl_409[0]}} : {{Tpl_409[1] , Tpl_410[0]}});
assign Tpl_409[1] = ((Tpl_399 | (~Tpl_401)) ? Tpl_403[1] : ((~Tpl_405[1]) ? Tpl_403[1] : Tpl_410[1]));
assign Tpl_409[0] = ((Tpl_399 | (~Tpl_401)) ? Tpl_403[0] : ((~Tpl_405[0]) ? Tpl_403[0] : Tpl_410[0]));

always @(*)
begin
Tpl_412 = {{Tpl_409 , Tpl_409 , Tpl_409 , Tpl_409}};
end


always @( posedge Tpl_397 or negedge Tpl_398 )
begin
if ((~Tpl_398))
begin
Tpl_407 <= {{2'b11 , 2'b11 , 2'b11 , 2'b11}};
end
else
if (Tpl_402)
begin
Tpl_407 <= Tpl_412;
end
else
begin
Tpl_407 <= {{Tpl_409 , Tpl_407[(1+2):1]}};
end
end


always @( posedge Tpl_397 or negedge Tpl_398 )
begin
if ((~Tpl_398))
begin
Tpl_410 <= 0;
end
else
if (Tpl_408)
begin
Tpl_410 <= Tpl_409;
end
else
if (Tpl_402)
begin
Tpl_410 <= Tpl_409;
end
end

assign Tpl_426 = ((Tpl_419 | Tpl_420) & Tpl_423);
assign Tpl_427 = (Tpl_418 ? Tpl_416 : Tpl_417);
assign Tpl_432 = ((Tpl_429[0] & Tpl_426) | Tpl_430[1]);
assign Tpl_433 = (~(&Tpl_424));
assign Tpl_435 = '0;

always @(*)
begin
Tpl_429 = 3'b001;
end


always @(*)
begin
Tpl_437 = {{Tpl_435 , Tpl_435 , Tpl_434}};
end


always @(*)
begin
case ({{Tpl_415 , Tpl_419 , Tpl_420 , Tpl_433}})
4'b0101: Tpl_434 = 2'b01;
4'b0111: Tpl_434 = 2'b01;
4'b0100: Tpl_434 = 2'b01;
4'b0110: Tpl_434 = 2'b01;
4'b0011: Tpl_434 = 2'b00;
4'b0010: Tpl_434 = 2'b01;
4'b0000: Tpl_434 = 2'b00;
4'b0001: Tpl_434 = 2'b00;
4'b1101: Tpl_434 = 2'b01;
4'b1111: Tpl_434 = 2'b01;
4'b1100: Tpl_434 = 2'b10;
4'b1110: Tpl_434 = 2'b10;
4'b1011: Tpl_434 = 2'b00;
4'b1010: Tpl_434 = 2'b10;
4'b1000: Tpl_434 = 2'b00;
4'b1001: Tpl_434 = 2'b00;
default: Tpl_434 = 2'b00;
endcase
end


always @( posedge Tpl_413 or negedge Tpl_414 )
begin
if ((~Tpl_414))
begin
Tpl_430 <= 0;
end
else
if (Tpl_426)
begin
Tpl_430 <= Tpl_429;
end
else
begin
Tpl_430 <= {{1'b0 , Tpl_430[2:1]}};
end
end


always @( posedge Tpl_413 or negedge Tpl_414 )
begin
if ((~Tpl_414))
begin
Tpl_436 <= 0;
end
else
if (Tpl_426)
begin
Tpl_436 <= Tpl_437;
end
else
begin
Tpl_436 <= (Tpl_436 >> 1);
end
end


always @( posedge Tpl_413 or negedge Tpl_414 )
begin
if ((~Tpl_414))
begin
Tpl_425 <= '0;
end
else
if (Tpl_422)
begin
Tpl_425 <= '0;
end
else
if (Tpl_432)
begin
if ((Tpl_429[0] & Tpl_426))
begin
Tpl_425 <= Tpl_434;
end
else
begin
Tpl_425 <= Tpl_436[1];
end
end
else
if (Tpl_428)
begin
Tpl_425 <= '0;
end
end


assign Tpl_438 = Tpl_413;
assign Tpl_439 = Tpl_414;
assign Tpl_440 = 1'b0;
assign Tpl_441 = Tpl_432;
assign Tpl_442 = 1'b1;
assign Tpl_443 = Tpl_427;
assign Tpl_428 = Tpl_444;
assign Tpl_444 = ((Tpl_445 == 1) ? 1'b1 : 1'b0);

always @( posedge Tpl_438 or negedge Tpl_439 )
begin
if ((~Tpl_439))
Tpl_445 <= 1;
else
if (Tpl_440)
Tpl_445 <= 1;
else
if ((Tpl_442 | Tpl_441))
Tpl_445 <= Tpl_446;
end


always @(*)
begin
if (Tpl_441)
Tpl_446 = Tpl_443;
else
if ((Tpl_445 > 1))
Tpl_446 = (Tpl_445 - 1);
else
Tpl_446 = 1;
end


function integer   ceil_log2_21;
input integer   data ;
integer   i ;
ceil_log2_21 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_21 = (i + 1);

end
endfunction


function integer   last_one_22;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_22 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_22 = (i + 1);
end

end
endfunction


function integer   floor_log2_23;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_23 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_23 = ceil_log2;
else
floor_log2_23 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_24;
input integer   N ;
integer   i ;
is_onethot_24 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_24 = 1;
end
end

end
endfunction


function integer   ecc_width_25;
input integer   data_width ;
integer   i ;
ecc_width_25 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_24(i)))
begin
ecc_width_25 = (ecc_width_25 + 1);
end
end

end
endfunction


always @(*)
begin
Tpl_469 = Tpl_486;
Tpl_483 = Tpl_487;
Tpl_473 = Tpl_458;
Tpl_474 = Tpl_459;
Tpl_470 = Tpl_492;
Tpl_471 = Tpl_493;
end

assign Tpl_484 = (Tpl_451 | Tpl_452);
assign Tpl_488 = (((Tpl_454[6:0] == 7'b1000001) | (Tpl_454[6:0] == 7'b1000011)) | (Tpl_454[6:0] == 7'b1000111));

always @(*)
begin
Tpl_482 = Tpl_454;
Tpl_472 = Tpl_457;
case (Tpl_457)
5'b00001: Tpl_472 = (Tpl_484 ? 6'b011111 : 6'b001111);
5'b00010: Tpl_472 = (Tpl_484 ? 6'b010001 : 6'b001111);
5'b00011: Tpl_472 = (Tpl_484 ? 6'b110001 : 6'b010111);
5'b11111: Tpl_472 = (Tpl_484 ? 6'b111111 : 6'b011111);
5'b11001: Tpl_472 = 6'b010000;
5'b11010: Tpl_472 = 6'b010111;
5'b11000: Tpl_472 = 6'b010000;
5'b11011: Tpl_472 = (Tpl_484 ? 6'b100000 : 6'b010110);
5'b00101: Tpl_472 = 6'b100000;
5'b11100: Tpl_472 = (Tpl_484 ? 6'b100000 : 6'b010110);
5'b00110: Tpl_472 = (Tpl_452 ? 6'b111000 : (Tpl_484 ? 6'b100100 : 6'b000001));
5'b00111: Tpl_472 = (Tpl_484 ? 6'b100101 : 6'b010111);
5'b01000: Tpl_472 = (Tpl_484 ? 6'b100011 : 6'b010001);
5'b11101: Tpl_472 = 6'b111001;
5'b11110: Tpl_472 = 6'b111010;
5'b01001: Tpl_472 = 6'b100000;
5'b01010: Tpl_472 = 6'b100001;
5'b01011: Tpl_472 = (Tpl_484 ? 6'b100110 : 6'b010011);
5'b01100: Tpl_472 = (Tpl_484 ? 6'b100111 : 6'b010100);
5'b01101: Tpl_472 = (Tpl_484 ? 6'b101000 : 0);
5'b01110: Tpl_472 = (Tpl_484 ? 6'b101001 : 6'b010101);
5'b01111: Tpl_472 = (Tpl_484 ? 6'b101010 : 6'b010010);
5'b10000: Tpl_472 = 6'b010111;
5'b10001: Tpl_472 = 6'b110010;
5'b10010: Tpl_472 = 6'b110011;
5'b10011: Tpl_472 = 6'b110100;
5'b10100: Tpl_472 = 6'b110101;
5'b10101: Tpl_472 = 6'b110110;
5'b10110: Tpl_472 = 6'b110111;
endcase
if ((~Tpl_484))
begin
case (Tpl_457)
5'b11011: begin
Tpl_482 = Tpl_454;
end
5'b00101: begin
Tpl_482 = Tpl_454;
end
5'b11100: begin
Tpl_482 = Tpl_454;
end
5'b01111: begin
Tpl_482 = Tpl_454;
end
5'b01011: begin
Tpl_482 = Tpl_454;
end
5'b11001: begin
Tpl_482 = Tpl_454;
end
5'b11000: begin
Tpl_482 = Tpl_454;
end
5'b01100: begin
Tpl_482 = {{5'b00000 , Tpl_454[0] , 1'b0 , Tpl_454[1] , Tpl_454[11:2]}};
end
5'b01110: begin
Tpl_482 = {{5'b00000 , Tpl_454[0] , 1'b0 , Tpl_454[1] , Tpl_454[11:2]}};
end
default: Tpl_482 = 0;
endcase
end
else
Tpl_482 = 0;
end


always @(*)
begin
if (Tpl_449)
begin
case (Tpl_457)
5'b01011: begin
Tpl_489 = Tpl_482[16];
Tpl_490 = Tpl_482[15];
Tpl_491 = Tpl_482[14];
end
5'b00110: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b1;
end
5'b00111: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b1;
end
5'b01111: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b11001: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b0;
end
5'b01000: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b1;
end
5'b01111: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b11011: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b11100: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b01100: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b0;
Tpl_491 = 1'b0;
end
5'b11000: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b0;
end
5'b01110: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b0;
Tpl_491 = 1'b1;
end
default: begin
Tpl_489 = Tpl_482[2];
Tpl_490 = Tpl_482[1];
Tpl_491 = Tpl_482[0];
end
endcase
end
else
if (Tpl_450)
begin
case (Tpl_457)
5'b01011: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b1;
Tpl_491 = 1'b1;
end
5'b00110: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b1;
end
5'b00111: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b1;
end
5'b01111: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b11001: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b0;
end
5'b01000: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b1;
end
5'b01111: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b11011: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b11100: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b0;
end
5'b01100: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b0;
Tpl_491 = 1'b0;
end
5'b01110: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b0;
Tpl_491 = 1'b1;
end
5'b11000: begin
Tpl_489 = 1'b0;
Tpl_490 = 1'b0;
Tpl_491 = 1'b0;
end
5'b00010: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b1;
end
5'b00011: begin
Tpl_489 = 1'b1;
Tpl_490 = 1'b1;
Tpl_491 = 1'b1;
end
default: begin
Tpl_489 = Tpl_482[2];
Tpl_490 = Tpl_482[1];
Tpl_491 = Tpl_482[0];
end
endcase
end
else
begin
Tpl_489 = 0;
Tpl_490 = 0;
Tpl_491 = 0;
end
end


always @(*)
begin
Tpl_486 = 0;
Tpl_487 = 0;
if (Tpl_452)
begin
Tpl_492 = 0;
Tpl_493 = 0;
case (Tpl_457)
5'b01001: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , Tpl_454[13] , 5'b00110}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , Tpl_454[5:0]}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , Tpl_454[12] , 5'b10110}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , Tpl_454[11:6]}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b01010: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b001110}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , Tpl_454[5:0]}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b010010}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b00101: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 1'b0 , 5'b00110}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'h0a}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 1'b0 , 5'b10110}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'h01}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b01000: begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b110;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b101000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
5'b00110: begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b110;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b011000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
5'b00111: begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b110;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b010100}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
5'b01011: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , Tpl_454[15:12] , 2'b01}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , Tpl_454[11:10] , 1'b0 , Tpl_456[2:0]}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , Tpl_454[9:6] , 2'b11}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , Tpl_454[5:0]}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b01100: begin
Tpl_494 = 3'b100;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , Tpl_454[0] , 5'b00100}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , Tpl_454[1] , Tpl_454[11] , 1'b0 , Tpl_456[2:0]}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , Tpl_454[10] , 5'b10010}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , Tpl_454[9:4]}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b01101: begin
Tpl_494 = 3'b100;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b001100}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , Tpl_454[1] , Tpl_454[11] , 1'b0 , Tpl_456[2:0]}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , Tpl_454[10] , 5'b10010}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , Tpl_454[9:4]}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b01110: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , Tpl_454[0] , 5'b00010}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , Tpl_454[1] , Tpl_454[11] , 1'b0 , Tpl_456[2:0]}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , Tpl_454[10] , 5'b10010}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , Tpl_454[9:4]}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b01111: begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b110;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b010000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 3'b000 , Tpl_456[2:0]}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
5'b10001: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b100000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b001111}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
5'b10010: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b100000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b010001}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
5'b10011: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b100000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b000001}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b010010}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b10100: begin
Tpl_494 = 3'b110;
Tpl_495 = 3'b100;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b100000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b000111}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b010010}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = (~Tpl_458);
Tpl_487[3] = 0;
end
5'b10101: begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b110;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b100000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b001011}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
5'b10110: begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b110;
Tpl_486[0] = {{({{(14){{1'b0}}}}) , 6'b100000}};
Tpl_486[1] = {{({{(14){{1'b0}}}}) , 6'b001101}};
Tpl_486[2] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_486[3] = {{({{(14){{1'b0}}}}) , 6'b000000}};
Tpl_487[0] = (~Tpl_458);
Tpl_487[1] = 0;
Tpl_487[2] = 0;
Tpl_487[3] = 0;
end
default: begin
Tpl_486 = 0;
Tpl_487 = 0;
Tpl_494 = 3'b111;
Tpl_495 = 3'b111;
end
endcase
end
else
if (Tpl_451)
begin
Tpl_493 = 0;
Tpl_492 = 0;
Tpl_494 = 3'b111;
Tpl_495 = 3'b111;
case (Tpl_457)
5'b01001: begin
Tpl_486[0] = {{Tpl_454[15:6] , Tpl_454[5:0] , 4'b0000}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b01010: begin
Tpl_486[0] = {{Tpl_454[15:6] , Tpl_454[5:0] , 4'b1000}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b01000: begin
Tpl_486[0] = {{10'b0000000000 , 6'b000000 , 4'b1100}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b00110: begin
Tpl_486[0] = {{10'b0000000000 , 7'b0000000 , 3'b100}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b11101: begin
Tpl_486[0] = {{10'b0000000000 , 7'b0000000 , 3'b011}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b11011: begin
Tpl_486[0] = {{8'b10101011 , 2'b00 , 6'b001010 , 4'b0000}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b00101: begin
Tpl_486[0] = {{8'b11000011 , 2'b00 , 6'b001010 , 4'b0000}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b11100: begin
Tpl_486[0] = {{8'b01010110 , 2'b00 , 6'b001010 , 4'b0000}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b01111: begin
Tpl_486[0] = {{10'b0000000001 , Tpl_456[2:0] , 3'b000 , 4'b1011}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b01011: begin
Tpl_486[0] = {{Tpl_454[14:13] , Tpl_454[7:0] , Tpl_456[2:0] , Tpl_454[12:8] , 2'b10}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b01100: begin
Tpl_486[0] = {{Tpl_454[13:5] , Tpl_454[1] , Tpl_456[2:0] , Tpl_454[4:3] , 2'b00 , 3'b001}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
5'b01110: begin
Tpl_486[0] = {{Tpl_454[13:5] , Tpl_454[1] , Tpl_456[2:0] , Tpl_454[4:3] , 2'b00 , 3'b101}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
end
default: begin
Tpl_486 = 0;
end
endcase
end
else
if (Tpl_449)
begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b111;
case (Tpl_457)
5'b00010 ,  5'b00011 ,  5'b11001 ,  5'b11010 ,  5'b11000 ,  5'b11011 ,  5'b00101 ,  5'b11100 ,  5'b00110 ,  5'b00111 ,  5'b01000 ,  5'b11101 ,  5'b11110 ,  5'b01001 ,  5'b01010 ,  5'b01011 ,  5'b01100 ,  5'b01110 ,  5'b01111 ,  5'b10000 ,  5'b10001 ,  5'b10010 ,  5'b10011 ,  5'b10100 ,  5'b10101 ,  5'b10110: begin
Tpl_486[0] = {{3'b000 , Tpl_482[17] , Tpl_489 , Tpl_490 , Tpl_491 , Tpl_482[13:0]}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
Tpl_492 = Tpl_455;
Tpl_493 = Tpl_456;
end
default: begin
Tpl_486[0] = ({{(20){{1'b0}}}});
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
Tpl_492 = 0;
Tpl_493 = 0;
end
endcase
end
else
if (Tpl_450)
begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b111;
case (Tpl_457)
5'b00010 ,  5'b00011 ,  5'b11001 ,  5'b11010 ,  5'b11000 ,  5'b11011 ,  5'b00101 ,  5'b11100 ,  5'b00110 ,  5'b00111 ,  5'b01000 ,  5'b11101 ,  5'b11110 ,  5'b01001 ,  5'b01010 ,  5'b01011 ,  5'b01100 ,  5'b01110 ,  5'b01111 ,  5'b10000 ,  5'b10001 ,  5'b10010 ,  5'b10011 ,  5'b10100 ,  5'b10101 ,  5'b10110: begin
Tpl_486[0] = {{2'b00 , Tpl_489 , Tpl_490 , Tpl_491 , Tpl_482[15:0]}};
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
Tpl_492 = Tpl_455;
Tpl_493 = Tpl_456;
end
default: begin
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[1] = ({{(20){{1'b0}}}});
Tpl_486[2] = ({{(20){{1'b0}}}});
Tpl_486[3] = ({{(20){{1'b0}}}});
Tpl_492 = 0;
Tpl_493 = 0;
end
endcase
end
else
begin
Tpl_494 = 3'b111;
Tpl_495 = 3'b111;
Tpl_486[0] = 0;
Tpl_486[1] = 0;
Tpl_486[2] = 0;
Tpl_486[3] = 0;
Tpl_492 = 0;
Tpl_493 = 0;
end
end


always @(*)
begin
Tpl_475 = Tpl_460;
Tpl_476 = Tpl_461;
Tpl_477 = Tpl_462;
Tpl_478 = Tpl_463;
Tpl_479 = Tpl_464;
Tpl_480 = Tpl_465;
Tpl_481 = Tpl_466;
end

assign Tpl_468 = ((Tpl_467 == 2'b10) ? ((Tpl_452 & ((Tpl_457 == 5'b01100) || (Tpl_457 == 5'b01101))) ? 3'b110 : 3'b111) : ((Tpl_467 == 2'b01) ? Tpl_494 : Tpl_495));

function integer   ceil_log2_26;
input integer   data ;
integer   i ;
ceil_log2_26 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_26 = (i + 1);

end
endfunction


function integer   last_one_27;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_27 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_27 = (i + 1);
end

end
endfunction


function integer   floor_log2_28;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_28 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_28 = ceil_log2;
else
floor_log2_28 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_29;
input integer   N ;
integer   i ;
is_onethot_29 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_29 = 1;
end
end

end
endfunction


function integer   ecc_width_30;
input integer   data_width ;
integer   i ;
ecc_width_30 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_29(i)))
begin
ecc_width_30 = (ecc_width_30 + 1);
end
end

end
endfunction


always @( posedge Tpl_496 or negedge Tpl_497 )
begin
if ((~Tpl_497))
begin
Tpl_574 <= 0;
Tpl_575 <= 0;
Tpl_576 <= 0;
Tpl_577 <= 0;
Tpl_578 <= 0;
Tpl_579 <= 0;
Tpl_580 <= 0;
Tpl_581 <= 0;
Tpl_582 <= 0;
Tpl_583 <= 0;
Tpl_584 <= 0;
Tpl_585 <= 0;
Tpl_586 <= 0;
end
else
begin
Tpl_574 <= Tpl_505;
Tpl_575 <= Tpl_506;
Tpl_576 <= Tpl_507;
Tpl_577 <= Tpl_508;
Tpl_578 <= Tpl_509;
Tpl_579 <= Tpl_510;
Tpl_580 <= Tpl_511;
Tpl_581 <= Tpl_512;
Tpl_582 <= Tpl_513;
Tpl_583 <= Tpl_514;
Tpl_584 <= Tpl_515;
Tpl_585 <= Tpl_516;
Tpl_586 <= Tpl_517;
end
end


always @( posedge Tpl_496 or negedge Tpl_497 )
begin
if ((~Tpl_497))
begin
Tpl_572 <= 0;
Tpl_573 <= 0;
end
else
begin
Tpl_572 <= (Tpl_498 == 2'b01);
Tpl_573 <= (Tpl_498 == 2'b10);
end
end

assign Tpl_529 = Tpl_566;
assign Tpl_528 = Tpl_571;
assign Tpl_544 = Tpl_578;
assign Tpl_545 = Tpl_579;
assign Tpl_546 = Tpl_580;
assign Tpl_549 = Tpl_584;
assign Tpl_550 = Tpl_581;
assign Tpl_551 = Tpl_582;
assign Tpl_552 = Tpl_583;
assign Tpl_547 = Tpl_585;
assign Tpl_548 = Tpl_586;
assign Tpl_520 = Tpl_554;
assign Tpl_521 = Tpl_555;
assign Tpl_522 = Tpl_556;
assign Tpl_523 = Tpl_558;
assign Tpl_527 = Tpl_559;
assign Tpl_524 = Tpl_560;
assign Tpl_525 = Tpl_561;
assign Tpl_526 = Tpl_562;
assign Tpl_533 = Tpl_563;
assign Tpl_534 = Tpl_564;
assign Tpl_535 = Tpl_565;
assign Tpl_568 = Tpl_537;
assign Tpl_569 = Tpl_538;
assign Tpl_570 = Tpl_539;
assign Tpl_540 = Tpl_567;

always @( posedge Tpl_496 or negedge Tpl_497 )
begin
if ((~Tpl_497))
begin
Tpl_588 <= 0;
Tpl_589 <= 0;
Tpl_590 <= 0;
Tpl_591 <= 0;
Tpl_592 <= 0;
Tpl_593 <= 0;
Tpl_594 <= 0;
Tpl_595 <= 0;
end
else
begin
if (Tpl_577)
begin
if (Tpl_499)
begin
Tpl_588 <= ((Tpl_573 & (Tpl_502[1:0] == 2'b01)) & Tpl_575);
Tpl_589 <= ((Tpl_573 & (Tpl_502[1:0] == 2'b10)) & Tpl_575);
end
else
begin
Tpl_588 <= ((Tpl_573 & (Tpl_502[1:0] == 2'b00)) & Tpl_575);
Tpl_589 <= ((Tpl_573 & (Tpl_502[1:0] == 2'b01)) & Tpl_575);
end
if (Tpl_499)
begin
Tpl_590 <= (((Tpl_573 & (Tpl_502[1:0] == 2'b11)) & Tpl_575) | ((Tpl_572 & (Tpl_502[0] == 1)) & Tpl_575));
end
else
begin
Tpl_590 <= (((Tpl_573 & (Tpl_502[1:0] == 2'b10)) & Tpl_575) | ((Tpl_572 & (Tpl_502[0] == 0)) & Tpl_575));
end
Tpl_591 <= 1'b0;
Tpl_592 <= 1'b0;
Tpl_593 <= 1'b0;
end
Tpl_594 <= Tpl_552;
Tpl_595 <= Tpl_594;
end
end


always @(*)
begin
Tpl_554[0] = 4'b1111;
Tpl_555[0] = 4'b0000;
Tpl_556[0] = 4'b0000;
Tpl_558[0] = 4'b0000;
Tpl_559[0] = 4'b0000;
if ((Tpl_588 | Tpl_591))
begin
Tpl_554[0][3] = Tpl_544[0];
Tpl_556[0][3] = Tpl_545[0];
Tpl_558[0][3] = Tpl_546[0];
Tpl_559[0][3] = Tpl_549[0];
Tpl_555[0][3] = (Tpl_499 ? Tpl_547[0][3] : Tpl_547[0]);
Tpl_555[0][2] = (Tpl_499 ? Tpl_547[0][2] : 0);
Tpl_555[0][1] = (Tpl_499 ? Tpl_547[0][1] : 0);
Tpl_555[0][0] = (Tpl_499 ? Tpl_547[0][0] : 0);
end
else
if ((Tpl_589 | Tpl_592))
begin
Tpl_554[0][2] = Tpl_544[0];
Tpl_556[0][2] = Tpl_545[0];
Tpl_558[0][2] = Tpl_546[0];
Tpl_559[0][2] = Tpl_549[0];
Tpl_555[0][3] = (Tpl_499 ? Tpl_547[0][4] : 0);
Tpl_555[0][2] = (Tpl_499 ? Tpl_547[0][3] : Tpl_547[0]);
Tpl_555[0][1] = (Tpl_499 ? Tpl_547[0][2] : 0);
Tpl_555[0][0] = (Tpl_499 ? Tpl_547[0][1] : 0);
end
else
if ((Tpl_590 | Tpl_593))
begin
Tpl_554[0][1] = Tpl_544[0];
Tpl_556[0][1] = Tpl_545[0];
Tpl_558[0][1] = Tpl_546[0];
Tpl_559[0][1] = Tpl_549[0];
Tpl_555[0][3] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][5] : 0) : 0);
Tpl_555[0][2] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][4] : 0) : 0);
Tpl_555[0][1] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][3] : Tpl_547[0][3]) : Tpl_547[0]);
Tpl_555[0][0] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][2] : Tpl_547[0][2]) : 0);
end
else
begin
Tpl_554[0][0] = Tpl_544[0];
Tpl_556[0][0] = Tpl_545[0];
Tpl_558[0][0] = Tpl_546[0];
Tpl_559[0][0] = Tpl_549[0];
Tpl_555[0][3] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][6] : 0) : 0);
Tpl_555[0][2] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][5] : 0) : 0);
Tpl_555[0][1] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][4] : (Tpl_572 ? Tpl_547[0][4] : 0)) : 0);
Tpl_555[0][0] = (Tpl_499 ? (Tpl_573 ? Tpl_547[0][3] : (Tpl_572 ? Tpl_547[0][3] : Tpl_547[0][3])) : Tpl_547[0]);
end
end


always @(*)
begin
Tpl_560[0][3] = Tpl_550[0];
Tpl_560[0][2] = Tpl_550[0];
Tpl_560[0][1] = Tpl_550[0];
Tpl_560[0][0] = Tpl_550[0];
Tpl_562[0][3] = ((((Tpl_588 | Tpl_591) | Tpl_589) | Tpl_592) ? (Tpl_552[0] | Tpl_594[0]) : Tpl_552[0]);
Tpl_562[0][2] = ((Tpl_588 | Tpl_591) ? Tpl_594[0] : ((((Tpl_589 | Tpl_592) | Tpl_590) | Tpl_593) ? (Tpl_552[0] | Tpl_594[0]) : Tpl_552[0]));
Tpl_562[0][1] = ((Tpl_573 & (((Tpl_588 | Tpl_591) | Tpl_589) | Tpl_592)) ? Tpl_594[0] : (Tpl_572 ? Tpl_552[0] : (Tpl_552[0] | Tpl_594[0])));
Tpl_562[0][0] = ((Tpl_573 & (Tpl_588 | Tpl_591)) ? (Tpl_594[0] | Tpl_595[0]) : ((Tpl_573 & (((Tpl_589 | Tpl_592) | Tpl_590) | Tpl_593)) ? Tpl_594[0] : (Tpl_573 ? (Tpl_552[0] | Tpl_594[0]) : ((Tpl_572 & (Tpl_590 | Tpl_593)) ? Tpl_594[0] : Tpl_552[0]))));
end


always @(*)
begin
Tpl_561 = 8'b11111111;
if ((Tpl_588 | Tpl_591))
begin
Tpl_561[3] = (Tpl_499 ? Tpl_548[6] : Tpl_551);
Tpl_561[2] = (Tpl_499 ? Tpl_548[5] : 2'b11);
Tpl_561[1] = (Tpl_499 ? Tpl_548[4] : 2'b11);
Tpl_561[0] = (Tpl_499 ? Tpl_548[3] : 2'b11);
end
else
if ((Tpl_589 | Tpl_592))
begin
Tpl_561[3] = (Tpl_499 ? Tpl_548[3] : 2'b11);
Tpl_561[2] = (Tpl_499 ? Tpl_548[2] : Tpl_551);
Tpl_561[1] = (Tpl_499 ? Tpl_548[1] : 2'b11);
Tpl_561[0] = (Tpl_499 ? Tpl_548[0] : 2'b11);
end
else
if ((Tpl_590 | Tpl_593))
begin
Tpl_561[3] = (Tpl_499 ? (Tpl_573 ? Tpl_548[4] : 0) : 2'b11);
Tpl_561[2] = (Tpl_499 ? (Tpl_573 ? Tpl_548[3] : 0) : 2'b11);
Tpl_561[1] = (Tpl_499 ? (Tpl_573 ? Tpl_548[2] : Tpl_548[2]) : Tpl_551);
Tpl_561[0] = (Tpl_499 ? (Tpl_573 ? Tpl_548[1] : Tpl_548[1]) : 2'b11);
end
else
begin
Tpl_561[3] = (Tpl_499 ? (Tpl_573 ? Tpl_548[5] : 0) : 2'b11);
Tpl_561[2] = (Tpl_499 ? (Tpl_573 ? Tpl_548[4] : 0) : 2'b11);
Tpl_561[1] = (Tpl_499 ? (Tpl_573 ? Tpl_548[3] : (Tpl_572 ? Tpl_548[3] : 0)) : 2'b11);
Tpl_561[0] = (Tpl_499 ? (Tpl_573 ? Tpl_548[2] : (Tpl_572 ? Tpl_548[2] : Tpl_548[3])) : Tpl_551);
end
end


always @( posedge Tpl_496 or negedge Tpl_497 )
begin
if ((~Tpl_497))
begin
Tpl_596 <= 0;
Tpl_597 <= 0;
Tpl_598 <= 0;
end
else
begin
Tpl_596 <= Tpl_532;
Tpl_597 <= Tpl_518;
Tpl_598 <= Tpl_597;
end
end

assign Tpl_565[0] = (Tpl_573 ? Tpl_596 : (Tpl_572 ? Tpl_596 : Tpl_532));
assign Tpl_565[1] = (Tpl_573 ? Tpl_596 : Tpl_532);
assign Tpl_565[2] = Tpl_596;
assign Tpl_565[3] = Tpl_532;
assign Tpl_566[0] = (Tpl_573 ? (Tpl_598 & Tpl_597) : (Tpl_572 ? Tpl_597 : Tpl_518));
assign Tpl_566[1] = (Tpl_573 ? (Tpl_598 & Tpl_597) : (Tpl_597 & Tpl_518));
assign Tpl_566[2] = Tpl_597;
assign Tpl_566[3] = (Tpl_597 & Tpl_518);
assign Tpl_563 = Tpl_530;
assign Tpl_564 = Tpl_531;

always @( posedge Tpl_496 or negedge Tpl_497 )
begin
if ((~Tpl_497))
begin
Tpl_599 <= 0;
Tpl_600 <= 0;
Tpl_601 <= 0;
end
else
begin
Tpl_599 <= Tpl_536;
Tpl_600 <= Tpl_519;
Tpl_601 <= Tpl_600;
end
end

assign Tpl_567[0] = ((Tpl_573 & (((Tpl_503[1:0] == 2'b00) && (~Tpl_499)) || ((Tpl_503[1:0] == 2'b01) && Tpl_499))) ? Tpl_536 : (Tpl_573 ? Tpl_599 : (Tpl_499 ? ((Tpl_572 & (~Tpl_503[0])) ? Tpl_599 : Tpl_536) : ((Tpl_572 & Tpl_503[0]) ? Tpl_599 : Tpl_536))));
assign Tpl_567[1] = (((Tpl_573 & (Tpl_503[1:0] == 2'b00)) & Tpl_499) ? Tpl_599 : (((Tpl_573 & (Tpl_503[1:0] == 2'b11)) & Tpl_499) ? Tpl_599 : (((Tpl_573 & (Tpl_503[1:0] == 2'b10)) & (~Tpl_499)) ? Tpl_599 : (((Tpl_573 & (Tpl_503[1:0] == 2'b11)) & (~Tpl_499)) ? Tpl_599 : Tpl_536))));
assign Tpl_567[2] = (((Tpl_573 & (Tpl_503[1:0] == 2'b11)) & (~Tpl_499)) ? Tpl_599 : (((Tpl_573 & (Tpl_503[1:0] == 2'b00)) & Tpl_499) ? Tpl_599 : Tpl_536));
assign Tpl_567[3] = Tpl_536;
assign Tpl_571[0] = ((Tpl_573 & (Tpl_503[1:0] == 2'b00)) ? (Tpl_600 & Tpl_519) : ((Tpl_573 & (Tpl_503[1:0] == 2'b01)) ? Tpl_600 : (Tpl_573 ? (Tpl_601 & Tpl_600) : ((Tpl_572 & Tpl_503[0]) ? Tpl_600 : (Tpl_572 ? (Tpl_600 & Tpl_519) : Tpl_536)))));
assign Tpl_571[1] = ((Tpl_573 & (Tpl_503[1:0] == 2'b10)) ? Tpl_600 : ((Tpl_573 & (Tpl_503[1:0] == 2'b11)) ? (Tpl_601 & Tpl_600) : (Tpl_573 ? (Tpl_600 & Tpl_519) : (Tpl_503[0] ? (Tpl_600 & Tpl_519) : Tpl_519))));
assign Tpl_571[2] = ((Tpl_503[1:0] == 2'b11) ? Tpl_600 : (Tpl_600 & Tpl_519));
assign Tpl_571[3] = ((Tpl_503[1:0] == 2'b00) ? Tpl_519 : (Tpl_600 & Tpl_519));
assign Tpl_541 = Tpl_568;
assign Tpl_542 = Tpl_569;
assign Tpl_543 = Tpl_570[0];

function integer   ceil_log2_31;
input integer   data ;
integer   i ;
ceil_log2_31 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_31 = (i + 1);

end
endfunction


function integer   last_one_32;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_32 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_32 = (i + 1);
end

end
endfunction


function integer   floor_log2_33;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_33 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_33 = ceil_log2;
else
floor_log2_33 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_34;
input integer   N ;
integer   i ;
is_onethot_34 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_34 = 1;
end
end

end
endfunction


function integer   ecc_width_35;
input integer   data_width ;
integer   i ;
ecc_width_35 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_34(i)))
begin
ecc_width_35 = (ecc_width_35 + 1);
end
end

end
endfunction

assign Tpl_626 = Tpl_618;
assign Tpl_628 = Tpl_619;
assign Tpl_629 = Tpl_620;
assign Tpl_624 = Tpl_616;
assign Tpl_625 = Tpl_617;
assign Tpl_623 = Tpl_614;
assign Tpl_621 = Tpl_607;
assign Tpl_622 = Tpl_608;
assign Tpl_627 = Tpl_615;
assign Tpl_630 = Tpl_625[2:0];
assign Tpl_613 = Tpl_606;
assign Tpl_609 = Tpl_602;
assign Tpl_610 = Tpl_603;
assign Tpl_611 = Tpl_604;
assign Tpl_612 = Tpl_605;
assign Tpl_631 = Tpl_605;

function integer   ceil_log2_36;
input integer   data ;
integer   i ;
ceil_log2_36 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_36 = (i + 1);

end
endfunction


function integer   last_one_37;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_37 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_37 = (i + 1);
end

end
endfunction


function integer   floor_log2_38;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_38 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_38 = ceil_log2;
else
floor_log2_38 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_39;
input integer   N ;
integer   i ;
is_onethot_39 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_39 = 1;
end
end

end
endfunction


function integer   ecc_width_40;
input integer   data_width ;
integer   i ;
ecc_width_40 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_39(i)))
begin
ecc_width_40 = (ecc_width_40 + 1);
end
end

end
endfunction

assign Tpl_636 = (Tpl_635 ? Tpl_638 : Tpl_632);
assign Tpl_637 = (Tpl_634 ? (~Tpl_633) : Tpl_633);

assign Tpl_639 = Tpl_632;
assign Tpl_640 = Tpl_637;
assign Tpl_638 = Tpl_641;

assign Tpl_643 = Tpl_639[7:0];
assign Tpl_644 = Tpl_640[(0 / 8)];
assign Tpl_641[7:0] = Tpl_645;

assign Tpl_646 = Tpl_639[15:8];
assign Tpl_647 = Tpl_640[(8 / 8)];
assign Tpl_641[15:8] = Tpl_648;

assign Tpl_649 = Tpl_639[23:16];
assign Tpl_650 = Tpl_640[(16 / 8)];
assign Tpl_641[23:16] = Tpl_651;

assign Tpl_652 = Tpl_639[31:24];
assign Tpl_653 = Tpl_640[(24 / 8)];
assign Tpl_641[31:24] = Tpl_654;

assign Tpl_655 = Tpl_639[39:32];
assign Tpl_656 = Tpl_640[(32 / 8)];
assign Tpl_641[39:32] = Tpl_657;

assign Tpl_658 = Tpl_639[47:40];
assign Tpl_659 = Tpl_640[(40 / 8)];
assign Tpl_641[47:40] = Tpl_660;

assign Tpl_661 = Tpl_639[55:48];
assign Tpl_662 = Tpl_640[(48 / 8)];
assign Tpl_641[55:48] = Tpl_663;

assign Tpl_664 = Tpl_639[63:56];
assign Tpl_665 = Tpl_640[(56 / 8)];
assign Tpl_641[63:56] = Tpl_666;

assign Tpl_667 = Tpl_639[71:64];
assign Tpl_668 = Tpl_640[(64 / 8)];
assign Tpl_641[71:64] = Tpl_669;

assign Tpl_670 = Tpl_639[79:72];
assign Tpl_671 = Tpl_640[(72 / 8)];
assign Tpl_641[79:72] = Tpl_672;

assign Tpl_673 = Tpl_639[87:80];
assign Tpl_674 = Tpl_640[(80 / 8)];
assign Tpl_641[87:80] = Tpl_675;

assign Tpl_676 = Tpl_639[95:88];
assign Tpl_677 = Tpl_640[(88 / 8)];
assign Tpl_641[95:88] = Tpl_678;

assign Tpl_679 = Tpl_639[103:96];
assign Tpl_680 = Tpl_640[(96 / 8)];
assign Tpl_641[103:96] = Tpl_681;

assign Tpl_682 = Tpl_639[111:104];
assign Tpl_683 = Tpl_640[(104 / 8)];
assign Tpl_641[111:104] = Tpl_684;

assign Tpl_685 = Tpl_639[119:112];
assign Tpl_686 = Tpl_640[(112 / 8)];
assign Tpl_641[119:112] = Tpl_687;

assign Tpl_688 = Tpl_639[127:120];
assign Tpl_689 = Tpl_640[(120 / 8)];
assign Tpl_641[127:120] = Tpl_690;

assign Tpl_691 = Tpl_639[135:128];
assign Tpl_692 = Tpl_640[(128 / 8)];
assign Tpl_641[135:128] = Tpl_693;

assign Tpl_694 = Tpl_639[143:136];
assign Tpl_695 = Tpl_640[(136 / 8)];
assign Tpl_641[143:136] = Tpl_696;

assign Tpl_697 = Tpl_639[151:144];
assign Tpl_698 = Tpl_640[(144 / 8)];
assign Tpl_641[151:144] = Tpl_699;

assign Tpl_700 = Tpl_639[159:152];
assign Tpl_701 = Tpl_640[(152 / 8)];
assign Tpl_641[159:152] = Tpl_702;

assign Tpl_703 = Tpl_639[167:160];
assign Tpl_704 = Tpl_640[(160 / 8)];
assign Tpl_641[167:160] = Tpl_705;

assign Tpl_706 = Tpl_639[175:168];
assign Tpl_707 = Tpl_640[(168 / 8)];
assign Tpl_641[175:168] = Tpl_708;

assign Tpl_709 = Tpl_639[183:176];
assign Tpl_710 = Tpl_640[(176 / 8)];
assign Tpl_641[183:176] = Tpl_711;

assign Tpl_712 = Tpl_639[191:184];
assign Tpl_713 = Tpl_640[(184 / 8)];
assign Tpl_641[191:184] = Tpl_714;

assign Tpl_715 = Tpl_639[199:192];
assign Tpl_716 = Tpl_640[(192 / 8)];
assign Tpl_641[199:192] = Tpl_717;

assign Tpl_718 = Tpl_639[207:200];
assign Tpl_719 = Tpl_640[(200 / 8)];
assign Tpl_641[207:200] = Tpl_720;

assign Tpl_721 = Tpl_639[215:208];
assign Tpl_722 = Tpl_640[(208 / 8)];
assign Tpl_641[215:208] = Tpl_723;

assign Tpl_724 = Tpl_639[223:216];
assign Tpl_725 = Tpl_640[(216 / 8)];
assign Tpl_641[223:216] = Tpl_726;

assign Tpl_727 = Tpl_639[231:224];
assign Tpl_728 = Tpl_640[(224 / 8)];
assign Tpl_641[231:224] = Tpl_729;

assign Tpl_730 = Tpl_639[239:232];
assign Tpl_731 = Tpl_640[(232 / 8)];
assign Tpl_641[239:232] = Tpl_732;

assign Tpl_733 = Tpl_639[247:240];
assign Tpl_734 = Tpl_640[(240 / 8)];
assign Tpl_641[247:240] = Tpl_735;

assign Tpl_736 = Tpl_639[255:248];
assign Tpl_737 = Tpl_640[(248 / 8)];
assign Tpl_641[255:248] = Tpl_738;
assign Tpl_645 = (Tpl_644 ? Tpl_643 : (~Tpl_643));
assign Tpl_648 = (Tpl_647 ? Tpl_646 : (~Tpl_646));
assign Tpl_651 = (Tpl_650 ? Tpl_649 : (~Tpl_649));
assign Tpl_654 = (Tpl_653 ? Tpl_652 : (~Tpl_652));
assign Tpl_657 = (Tpl_656 ? Tpl_655 : (~Tpl_655));
assign Tpl_660 = (Tpl_659 ? Tpl_658 : (~Tpl_658));
assign Tpl_663 = (Tpl_662 ? Tpl_661 : (~Tpl_661));
assign Tpl_666 = (Tpl_665 ? Tpl_664 : (~Tpl_664));
assign Tpl_669 = (Tpl_668 ? Tpl_667 : (~Tpl_667));
assign Tpl_672 = (Tpl_671 ? Tpl_670 : (~Tpl_670));
assign Tpl_675 = (Tpl_674 ? Tpl_673 : (~Tpl_673));
assign Tpl_678 = (Tpl_677 ? Tpl_676 : (~Tpl_676));
assign Tpl_681 = (Tpl_680 ? Tpl_679 : (~Tpl_679));
assign Tpl_684 = (Tpl_683 ? Tpl_682 : (~Tpl_682));
assign Tpl_687 = (Tpl_686 ? Tpl_685 : (~Tpl_685));
assign Tpl_690 = (Tpl_689 ? Tpl_688 : (~Tpl_688));
assign Tpl_693 = (Tpl_692 ? Tpl_691 : (~Tpl_691));
assign Tpl_696 = (Tpl_695 ? Tpl_694 : (~Tpl_694));
assign Tpl_699 = (Tpl_698 ? Tpl_697 : (~Tpl_697));
assign Tpl_702 = (Tpl_701 ? Tpl_700 : (~Tpl_700));
assign Tpl_705 = (Tpl_704 ? Tpl_703 : (~Tpl_703));
assign Tpl_708 = (Tpl_707 ? Tpl_706 : (~Tpl_706));
assign Tpl_711 = (Tpl_710 ? Tpl_709 : (~Tpl_709));
assign Tpl_714 = (Tpl_713 ? Tpl_712 : (~Tpl_712));
assign Tpl_717 = (Tpl_716 ? Tpl_715 : (~Tpl_715));
assign Tpl_720 = (Tpl_719 ? Tpl_718 : (~Tpl_718));
assign Tpl_723 = (Tpl_722 ? Tpl_721 : (~Tpl_721));
assign Tpl_726 = (Tpl_725 ? Tpl_724 : (~Tpl_724));
assign Tpl_729 = (Tpl_728 ? Tpl_727 : (~Tpl_727));
assign Tpl_732 = (Tpl_731 ? Tpl_730 : (~Tpl_730));
assign Tpl_735 = (Tpl_734 ? Tpl_733 : (~Tpl_733));
assign Tpl_738 = (Tpl_737 ? Tpl_736 : (~Tpl_736));

function integer   ceil_log2_41;
input integer   data ;
integer   i ;
ceil_log2_41 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_41 = (i + 1);

end
endfunction


function integer   last_one_42;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_42 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_42 = (i + 1);
end

end
endfunction


function integer   floor_log2_43;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_43 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_43 = ceil_log2;
else
floor_log2_43 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_44;
input integer   N ;
integer   i ;
is_onethot_44 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_44 = 1;
end
end

end
endfunction


function integer   ecc_width_45;
input integer   data_width ;
integer   i ;
ecc_width_45 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_44(i)))
begin
ecc_width_45 = (ecc_width_45 + 1);
end
end

end
endfunction

assign Tpl_744 = Tpl_739;
assign Tpl_743 = Tpl_741;
assign Tpl_745 = Tpl_740;

function integer   ceil_log2_46;
input integer   data ;
integer   i ;
ceil_log2_46 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_46 = (i + 1);

end
endfunction


function integer   last_one_47;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_47 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_47 = (i + 1);
end

end
endfunction


function integer   floor_log2_48;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_48 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_48 = ceil_log2;
else
floor_log2_48 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_49;
input integer   N ;
integer   i ;
is_onethot_49 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_49 = 1;
end
end

end
endfunction


function integer   ecc_width_50;
input integer   data_width ;
integer   i ;
ecc_width_50 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_49(i)))
begin
ecc_width_50 = (ecc_width_50 + 1);
end
end

end
endfunction


assign Tpl_785 = Tpl_746;
assign Tpl_786 = Tpl_759;
assign Tpl_787 = Tpl_757;
assign Tpl_788 = Tpl_758;
assign Tpl_789 = Tpl_751;
assign Tpl_790 = Tpl_756;
assign Tpl_791 = Tpl_747;
assign Tpl_792 = Tpl_750;
assign Tpl_793 = Tpl_748;
assign Tpl_794 = Tpl_749;
assign Tpl_795 = Tpl_753;
assign Tpl_796 = Tpl_752;
assign Tpl_797 = Tpl_754;
assign Tpl_798 = Tpl_755;
assign Tpl_799 = Tpl_781;
assign Tpl_800 = Tpl_782;
assign Tpl_801 = Tpl_774;
assign Tpl_777 = Tpl_802;
assign Tpl_779 = Tpl_803;
assign Tpl_778 = Tpl_804;
assign Tpl_780 = Tpl_805;
assign Tpl_773 = Tpl_806;
assign Tpl_775 = Tpl_807;
assign Tpl_776 = Tpl_808;
assign Tpl_772 = Tpl_809;
assign Tpl_770 = Tpl_810;
assign Tpl_771 = Tpl_811;
assign Tpl_761 = Tpl_812;
assign Tpl_760 = Tpl_813;
assign Tpl_762 = Tpl_814;
assign Tpl_765 = Tpl_815;
assign Tpl_763 = Tpl_816;
assign Tpl_764 = Tpl_817;

assign Tpl_850 = Tpl_746;
assign Tpl_851 = Tpl_759;
assign Tpl_852 = Tpl_772;
assign Tpl_853 = Tpl_775;
assign Tpl_854 = Tpl_778;
assign Tpl_855 = Tpl_780;
assign Tpl_856 = Tpl_751;
assign Tpl_784 = Tpl_857;

assign Tpl_867 = Tpl_773;
assign Tpl_868 = Tpl_771;
assign Tpl_869 = Tpl_770;
assign Tpl_870 = Tpl_746;
assign Tpl_871 = Tpl_759;
assign Tpl_774 = Tpl_872;
assign Tpl_768 = Tpl_873;
assign Tpl_766 = Tpl_874;
assign Tpl_767 = Tpl_875;
assign Tpl_769 = Tpl_876;

assign Tpl_1004 = Tpl_746;
assign Tpl_1005 = Tpl_759;
assign Tpl_1006 = Tpl_772;
assign Tpl_1007 = Tpl_775;
assign Tpl_1008 = Tpl_777[63:0];
assign Tpl_1009 = Tpl_779[7:0];
assign Tpl_1010 = Tpl_751[1:0];
assign Tpl_783[71:0] = Tpl_1011;

assign Tpl_1021 = Tpl_746;
assign Tpl_1022 = Tpl_759;
assign Tpl_1023 = Tpl_772;
assign Tpl_1024 = Tpl_775;
assign Tpl_1025 = Tpl_777[127:64];
assign Tpl_1026 = Tpl_779[15:8];
assign Tpl_1027 = Tpl_751[1:0];
assign Tpl_783[143:72] = Tpl_1028;

assign Tpl_1038 = Tpl_746;
assign Tpl_1039 = Tpl_759;
assign Tpl_1040 = Tpl_772;
assign Tpl_1041 = Tpl_775;
assign Tpl_1042 = Tpl_777[191:128];
assign Tpl_1043 = Tpl_779[23:16];
assign Tpl_1044 = Tpl_751[1:0];
assign Tpl_783[215:144] = Tpl_1045;

assign Tpl_1055 = Tpl_746;
assign Tpl_1056 = Tpl_759;
assign Tpl_1057 = Tpl_772;
assign Tpl_1058 = Tpl_775;
assign Tpl_1059 = Tpl_777[255:192];
assign Tpl_1060 = Tpl_779[31:24];
assign Tpl_1061 = Tpl_751[1:0];
assign Tpl_783[287:216] = Tpl_1062;

assign Tpl_1072 = Tpl_746;
assign Tpl_1073 = Tpl_759;
assign Tpl_1074 = Tpl_776;
assign Tpl_1075 = Tpl_783[71:0];
assign Tpl_781[7:0] = Tpl_1076;

assign Tpl_1079 = Tpl_746;
assign Tpl_1080 = Tpl_759;
assign Tpl_1081 = Tpl_776;
assign Tpl_1082 = Tpl_783[143:72];
assign Tpl_781[15:8] = Tpl_1083;

assign Tpl_1086 = Tpl_746;
assign Tpl_1087 = Tpl_759;
assign Tpl_1088 = Tpl_776;
assign Tpl_1089 = Tpl_783[215:144];
assign Tpl_781[23:16] = Tpl_1090;

assign Tpl_1093 = Tpl_746;
assign Tpl_1094 = Tpl_759;
assign Tpl_1095 = Tpl_776;
assign Tpl_1096 = Tpl_783[287:216];
assign Tpl_781[31:24] = Tpl_1097;

function integer   ceil_log2_51;
input integer   data ;
integer   i ;
ceil_log2_51 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_51 = (i + 1);

end
endfunction


function integer   last_one_52;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_52 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_52 = (i + 1);
end

end
endfunction


function integer   floor_log2_53;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_53 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_53 = ceil_log2;
else
floor_log2_53 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_54;
input integer   N ;
integer   i ;
is_onethot_54 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_54 = 1;
end
end

end
endfunction


function integer   ecc_width_55;
input integer   data_width ;
integer   i ;
ecc_width_55 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_54(i)))
begin
ecc_width_55 = (ecc_width_55 + 1);
end
end

end
endfunction

assign Tpl_818 = Tpl_787[0];
assign Tpl_810 = ((Tpl_808 == 1'b0) & Tpl_795);
assign Tpl_811 = ((Tpl_798 == 6'b010100) & Tpl_788);

always @( posedge Tpl_785 or negedge Tpl_786 )
begin
if ((~Tpl_786))
Tpl_809 <= 1'b0;
else
begin
if (Tpl_810)
Tpl_809 <= Tpl_801;
end
end


always @( posedge Tpl_785 or negedge Tpl_786 )
begin
if ((~Tpl_786))
begin
Tpl_847 <= 1'b0;
Tpl_848 <= 1'b0;
end
else
begin
Tpl_847 <= (Tpl_789 == 2'b01);
Tpl_848 <= (Tpl_789 == 2'b10);
end
end

assign Tpl_807 = (Tpl_788 & Tpl_795);
assign Tpl_822 = (Tpl_788 & Tpl_796);

always @( posedge Tpl_785 or negedge Tpl_786 )
begin
if ((!Tpl_786))
begin
Tpl_808 <= '0;
Tpl_823 <= '0;
Tpl_831 <= '0;
end
else
begin
Tpl_808 <= Tpl_807;
Tpl_823 <= Tpl_822;
Tpl_831 <= (Tpl_808 & (~Tpl_807));
end
end

assign Tpl_802[(((0 * 2) * 4) * 8)+:64] = {{Tpl_791[((0 * 8) + ((((7) * (256))) / (8)))+:8] , Tpl_791[((0 * 8) + ((((6) * (256))) / (8)))+:8] , Tpl_791[((0 * 8) + ((((5) * (256))) / (8)))+:8] , Tpl_791[((0 * 8) + ((((4) * (256))) / (8)))+:8] , Tpl_791[((0 * 8) + ((((3) * (256))) / (8)))+:8] , Tpl_791[((0 * 8) + ((((2) * (256))) / (8)))+:8] , Tpl_791[((0 * 8) + ((((1) * (256))) / (8)))+:8] , Tpl_791[((0 * 8) + ((((0) * (256))) / (8)))+:8]}};
assign Tpl_803[((0 * 2) * 4)+:8] = {{Tpl_792[(0 + ((((7) * (32))) / (8)))] , Tpl_792[(0 + ((((6) * (32))) / (8)))] , Tpl_792[(0 + ((((5) * (32))) / (8)))] , Tpl_792[(0 + ((((4) * (32))) / (8)))] , Tpl_792[(0 + ((((3) * (32))) / (8)))] , Tpl_792[(0 + ((((2) * (32))) / (8)))] , Tpl_792[(0 + ((((1) * (32))) / (8)))] , Tpl_792[(0 + ((((0) * (32))) / (8)))]}};
assign Tpl_802[(((1 * 2) * 4) * 8)+:64] = {{Tpl_791[((1 * 8) + ((((7) * (256))) / (8)))+:8] , Tpl_791[((1 * 8) + ((((6) * (256))) / (8)))+:8] , Tpl_791[((1 * 8) + ((((5) * (256))) / (8)))+:8] , Tpl_791[((1 * 8) + ((((4) * (256))) / (8)))+:8] , Tpl_791[((1 * 8) + ((((3) * (256))) / (8)))+:8] , Tpl_791[((1 * 8) + ((((2) * (256))) / (8)))+:8] , Tpl_791[((1 * 8) + ((((1) * (256))) / (8)))+:8] , Tpl_791[((1 * 8) + ((((0) * (256))) / (8)))+:8]}};
assign Tpl_803[((1 * 2) * 4)+:8] = {{Tpl_792[(1 + ((((7) * (32))) / (8)))] , Tpl_792[(1 + ((((6) * (32))) / (8)))] , Tpl_792[(1 + ((((5) * (32))) / (8)))] , Tpl_792[(1 + ((((4) * (32))) / (8)))] , Tpl_792[(1 + ((((3) * (32))) / (8)))] , Tpl_792[(1 + ((((2) * (32))) / (8)))] , Tpl_792[(1 + ((((1) * (32))) / (8)))] , Tpl_792[(1 + ((((0) * (32))) / (8)))]}};
assign Tpl_802[(((2 * 2) * 4) * 8)+:64] = {{Tpl_791[((2 * 8) + ((((7) * (256))) / (8)))+:8] , Tpl_791[((2 * 8) + ((((6) * (256))) / (8)))+:8] , Tpl_791[((2 * 8) + ((((5) * (256))) / (8)))+:8] , Tpl_791[((2 * 8) + ((((4) * (256))) / (8)))+:8] , Tpl_791[((2 * 8) + ((((3) * (256))) / (8)))+:8] , Tpl_791[((2 * 8) + ((((2) * (256))) / (8)))+:8] , Tpl_791[((2 * 8) + ((((1) * (256))) / (8)))+:8] , Tpl_791[((2 * 8) + ((((0) * (256))) / (8)))+:8]}};
assign Tpl_803[((2 * 2) * 4)+:8] = {{Tpl_792[(2 + ((((7) * (32))) / (8)))] , Tpl_792[(2 + ((((6) * (32))) / (8)))] , Tpl_792[(2 + ((((5) * (32))) / (8)))] , Tpl_792[(2 + ((((4) * (32))) / (8)))] , Tpl_792[(2 + ((((3) * (32))) / (8)))] , Tpl_792[(2 + ((((2) * (32))) / (8)))] , Tpl_792[(2 + ((((1) * (32))) / (8)))] , Tpl_792[(2 + ((((0) * (32))) / (8)))]}};
assign Tpl_802[(((3 * 2) * 4) * 8)+:64] = {{Tpl_791[((3 * 8) + ((((7) * (256))) / (8)))+:8] , Tpl_791[((3 * 8) + ((((6) * (256))) / (8)))+:8] , Tpl_791[((3 * 8) + ((((5) * (256))) / (8)))+:8] , Tpl_791[((3 * 8) + ((((4) * (256))) / (8)))+:8] , Tpl_791[((3 * 8) + ((((3) * (256))) / (8)))+:8] , Tpl_791[((3 * 8) + ((((2) * (256))) / (8)))+:8] , Tpl_791[((3 * 8) + ((((1) * (256))) / (8)))+:8] , Tpl_791[((3 * 8) + ((((0) * (256))) / (8)))+:8]}};
assign Tpl_803[((3 * 2) * 4)+:8] = {{Tpl_792[(3 + ((((7) * (32))) / (8)))] , Tpl_792[(3 + ((((6) * (32))) / (8)))] , Tpl_792[(3 + ((((5) * (32))) / (8)))] , Tpl_792[(3 + ((((4) * (32))) / (8)))] , Tpl_792[(3 + ((((3) * (32))) / (8)))] , Tpl_792[(3 + ((((2) * (32))) / (8)))] , Tpl_792[(3 + ((((1) * (32))) / (8)))] , Tpl_792[(3 + ((((0) * (32))) / (8)))]}};
assign Tpl_804 = Tpl_793;
assign Tpl_805 = Tpl_794;
assign Tpl_806 = (Tpl_788 & ((((Tpl_798 == 6'b010100) & (Tpl_797[12] == 1'b1)) & Tpl_818) | ((Tpl_787 == 2'b11) & (Tpl_798 == 6'b010100))));
assign Tpl_836 = (Tpl_831 ? ((Tpl_790 == 4'b0000) ? {{({{(224){{1'b1}}}}) , Tpl_799}} : {{({{(240){{1'b1}}}}) , Tpl_799[15:0]}}) : Tpl_791);
assign Tpl_844 = (Tpl_831 ? ({{(32){{1'b1}}}}) : Tpl_792);
assign Tpl_838 = (Tpl_831 ? {{({{(56){{1'b1}}}}) , Tpl_800}} : Tpl_793);
assign Tpl_846 = (Tpl_831 ? ({{(8){{1'b1}}}}) : Tpl_794);
assign Tpl_840 = (Tpl_788 ? (Tpl_808 | Tpl_795) : Tpl_795);
assign Tpl_842 = (Tpl_788 ? (Tpl_823 | Tpl_796) : Tpl_796);
assign Tpl_835 = (Tpl_848 ? Tpl_791 : ((Tpl_847 & Tpl_819) ? ({{(256){{1'b1}}}}) : (((~Tpl_847) & Tpl_820) ? ({{(256){{1'b1}}}}) : ((Tpl_847 & Tpl_832) ? {{({{(224){{1'b1}}}}) , Tpl_827}} : (((~Tpl_847) & Tpl_832) ? {{({{(224){{1'b1}}}}) , Tpl_828}} : Tpl_791)))));
assign Tpl_843 = (Tpl_848 ? Tpl_792 : ((Tpl_847 & Tpl_819) ? ({{(32){{1'b1}}}}) : (((~Tpl_847) & Tpl_820) ? ({{(32){{1'b1}}}}) : (Tpl_832 ? ({{(32){{1'b1}}}}) : Tpl_792))));
assign Tpl_837 = (Tpl_848 ? Tpl_793 : ((Tpl_847 & Tpl_819) ? ({{(64){{1'b1}}}}) : (((~Tpl_847) & Tpl_820) ? ({{(64){{1'b1}}}}) : ((Tpl_847 & Tpl_832) ? {{({{(56){{1'b1}}}}) , Tpl_829}} : (((~Tpl_847) & Tpl_832) ? {{({{(56){{1'b1}}}}) , Tpl_830}} : Tpl_793)))));
assign Tpl_845 = (Tpl_848 ? Tpl_794 : ((Tpl_847 & Tpl_819) ? ({{(8){{1'b1}}}}) : (((~Tpl_847) & Tpl_820) ? ({{(8){{1'b1}}}}) : (Tpl_832 ? ({{(8){{1'b1}}}}) : Tpl_794))));
assign Tpl_839 = (Tpl_848 ? Tpl_795 : (Tpl_788 ? (Tpl_821 | Tpl_795) : Tpl_795));
assign Tpl_841 = (Tpl_848 ? Tpl_796 : (Tpl_788 ? (Tpl_826 | Tpl_796) : Tpl_796));
assign Tpl_832 = (Tpl_848 ? 0 : (Tpl_847 ? Tpl_833 : Tpl_834));
assign Tpl_821 = (Tpl_848 ? 0 : (Tpl_847 ? (Tpl_808 | Tpl_819) : ((Tpl_808 | Tpl_819) | Tpl_820)));
assign Tpl_826 = (Tpl_848 ? 0 : (Tpl_847 ? (Tpl_823 | Tpl_824) : ((Tpl_823 | Tpl_824) | Tpl_825)));
assign Tpl_814 = ((Tpl_809 | (Tpl_787 == 2'b11)) ? Tpl_836 : Tpl_835);
assign Tpl_815 = ((Tpl_809 | (Tpl_787 == 2'b11)) ? Tpl_844 : Tpl_843);
assign Tpl_816 = ((Tpl_809 | (Tpl_787 == 2'b11)) ? Tpl_838 : Tpl_837);
assign Tpl_817 = ((Tpl_809 | (Tpl_787 == 2'b11)) ? Tpl_846 : Tpl_845);
assign Tpl_812 = ((Tpl_809 | (Tpl_787 == 2'b11)) ? Tpl_840 : Tpl_839);
assign Tpl_813 = ((Tpl_809 | (Tpl_787 == 2'b11)) ? Tpl_842 : Tpl_841);

always @( posedge Tpl_785 or negedge Tpl_786 )
begin
if ((!Tpl_786))
begin
Tpl_833 <= '0;
Tpl_834 <= '0;
Tpl_827 <= 0;
Tpl_828 <= 0;
Tpl_829 <= 8'h00;
Tpl_830 <= 8'h00;
Tpl_819 <= '0;
Tpl_820 <= '0;
Tpl_824 <= '0;
Tpl_825 <= '0;
end
else
begin
Tpl_833 <= (Tpl_831 & (~Tpl_809));
Tpl_834 <= Tpl_833;
Tpl_827 <= Tpl_799;
Tpl_828 <= Tpl_827;
Tpl_829 <= Tpl_800;
Tpl_830 <= Tpl_829;
Tpl_819 <= (Tpl_808 & (~Tpl_809));
Tpl_820 <= Tpl_819;
Tpl_824 <= (Tpl_823 & (~Tpl_809));
Tpl_825 <= Tpl_824;
end
end


always @( posedge Tpl_850 or negedge Tpl_851 )
begin
if ((~Tpl_851))
begin
Tpl_861 <= 1'b0;
Tpl_862 <= 1'b0;
end
else
begin
Tpl_861 <= (Tpl_856 == 2'b01);
Tpl_862 <= (Tpl_856 == 2'b10);
end
end


always @(*)
begin
Tpl_864 = ST_IDLE_1;
case (Tpl_863)
ST_IDLE_1: if (Tpl_853)
Tpl_864 = ST_WRTRANS_0_2;
else
Tpl_864 = ST_IDLE_1;
ST_WRTRANS_0_2: if (Tpl_862)
Tpl_864 = ST_IDLE_1;
else
Tpl_864 = ST_WRTRANS_1_3;
ST_WRTRANS_1_3: if (Tpl_861)
Tpl_864 = ST_IDLE_1;
else
Tpl_864 = ST_WRTRANS_2_4;
ST_WRTRANS_2_4: Tpl_864 = ST_WRTRANS_3_5;
ST_WRTRANS_3_5: Tpl_864 = ST_IDLE_1;
default: Tpl_864 = Tpl_863;
endcase
end


always @( posedge Tpl_850 or negedge Tpl_851 )
begin
if ((~Tpl_851))
begin
Tpl_858 <= 72'hffffffffffffffffff;
end
else
if ((Tpl_863 != ST_IDLE_1))
Tpl_858 <= (Tpl_862 ? {{Tpl_855[7] , Tpl_854[63:56] , Tpl_855[6] , Tpl_854[55:48] , Tpl_855[5] , Tpl_854[47:40] , Tpl_855[4] , Tpl_854[39:32] , Tpl_855[3] , Tpl_854[31:24] , Tpl_855[2] , Tpl_854[23:16] , Tpl_855[1] , Tpl_854[15:8] , Tpl_855[0] , Tpl_854[7:0]}} : (Tpl_861 ? {{Tpl_855[3] , Tpl_854[31:24] , Tpl_855[2] , Tpl_854[23:16] , Tpl_855[1] , Tpl_854[15:8] , Tpl_855[0] , Tpl_854[7:0] , Tpl_858[71:36]}} : {{Tpl_855[1] , Tpl_854[15:8] , Tpl_855[0] , Tpl_854[7:0] , Tpl_858[71:18]}}));
else
Tpl_858 <= 72'hffffffffffffffffff;
end


always @( posedge Tpl_850 or negedge Tpl_851 )
begin
if ((~Tpl_851))
Tpl_863 <= ST_IDLE_1;
else
Tpl_863 <= Tpl_864;
end

assign Tpl_859 = (Tpl_852 ? Tpl_858 : {{Tpl_858[35:0] , Tpl_858[71:36]}});
assign Tpl_857 = Tpl_860;
assign Tpl_860[0][0] = Tpl_859[0][0];
assign Tpl_860[0][1] = Tpl_859[1][0];
assign Tpl_860[0][2] = Tpl_859[2][0];
assign Tpl_860[0][3] = Tpl_859[3][0];
assign Tpl_860[0][4] = Tpl_859[4][0];
assign Tpl_860[0][5] = Tpl_859[5][0];
assign Tpl_860[0][6] = Tpl_859[6][0];
assign Tpl_860[0][7] = Tpl_859[7][0];
assign Tpl_860[1][0] = Tpl_859[0][1];
assign Tpl_860[1][1] = Tpl_859[1][1];
assign Tpl_860[1][2] = Tpl_859[2][1];
assign Tpl_860[1][3] = Tpl_859[3][1];
assign Tpl_860[1][4] = Tpl_859[4][1];
assign Tpl_860[1][5] = Tpl_859[5][1];
assign Tpl_860[1][6] = Tpl_859[6][1];
assign Tpl_860[1][7] = Tpl_859[7][1];
assign Tpl_860[2][0] = Tpl_859[0][2];
assign Tpl_860[2][1] = Tpl_859[1][2];
assign Tpl_860[2][2] = Tpl_859[2][2];
assign Tpl_860[2][3] = Tpl_859[3][2];
assign Tpl_860[2][4] = Tpl_859[4][2];
assign Tpl_860[2][5] = Tpl_859[5][2];
assign Tpl_860[2][6] = Tpl_859[6][2];
assign Tpl_860[2][7] = Tpl_859[7][2];
assign Tpl_860[3][0] = Tpl_859[0][3];
assign Tpl_860[3][1] = Tpl_859[1][3];
assign Tpl_860[3][2] = Tpl_859[2][3];
assign Tpl_860[3][3] = Tpl_859[3][3];
assign Tpl_860[3][4] = Tpl_859[4][3];
assign Tpl_860[3][5] = Tpl_859[5][3];
assign Tpl_860[3][6] = Tpl_859[6][3];
assign Tpl_860[3][7] = Tpl_859[7][3];
assign Tpl_860[4][0] = Tpl_859[0][4];
assign Tpl_860[4][1] = Tpl_859[1][4];
assign Tpl_860[4][2] = Tpl_859[2][4];
assign Tpl_860[4][3] = Tpl_859[3][4];
assign Tpl_860[4][4] = Tpl_859[4][4];
assign Tpl_860[4][5] = Tpl_859[5][4];
assign Tpl_860[4][6] = Tpl_859[6][4];
assign Tpl_860[4][7] = Tpl_859[7][4];
assign Tpl_860[5][0] = Tpl_859[0][5];
assign Tpl_860[5][1] = Tpl_859[1][5];
assign Tpl_860[5][2] = Tpl_859[2][5];
assign Tpl_860[5][3] = Tpl_859[3][5];
assign Tpl_860[5][4] = Tpl_859[4][5];
assign Tpl_860[5][5] = Tpl_859[5][5];
assign Tpl_860[5][6] = Tpl_859[6][5];
assign Tpl_860[5][7] = Tpl_859[7][5];
assign Tpl_860[6][0] = Tpl_859[0][6];
assign Tpl_860[6][1] = Tpl_859[1][6];
assign Tpl_860[6][2] = Tpl_859[2][6];
assign Tpl_860[6][3] = Tpl_859[3][6];
assign Tpl_860[6][4] = Tpl_859[4][6];
assign Tpl_860[6][5] = Tpl_859[5][6];
assign Tpl_860[6][6] = Tpl_859[6][6];
assign Tpl_860[6][7] = Tpl_859[7][6];
assign Tpl_860[7][0] = Tpl_859[0][7];
assign Tpl_860[7][1] = Tpl_859[1][7];
assign Tpl_860[7][2] = Tpl_859[2][7];
assign Tpl_860[7][3] = Tpl_859[3][7];
assign Tpl_860[7][4] = Tpl_859[4][7];
assign Tpl_860[7][5] = Tpl_859[5][7];
assign Tpl_860[7][6] = Tpl_859[6][7];
assign Tpl_860[7][7] = Tpl_859[7][7];
assign Tpl_860[8][0] = Tpl_859[0][8];
assign Tpl_860[8][1] = Tpl_859[1][8];
assign Tpl_860[8][2] = Tpl_859[2][8];
assign Tpl_860[8][3] = Tpl_859[3][8];
assign Tpl_860[8][4] = Tpl_859[4][8];
assign Tpl_860[8][5] = Tpl_859[5][8];
assign Tpl_860[8][6] = Tpl_859[6][8];
assign Tpl_860[8][7] = Tpl_859[7][8];
assign Tpl_880 = 5;
assign Tpl_881 = 3;

assign Tpl_882 = Tpl_870;
assign Tpl_883 = Tpl_871;
assign Tpl_884 = Tpl_868;
assign Tpl_885 = Tpl_869;
assign Tpl_886 = Tpl_880;
assign Tpl_887 = Tpl_881;
assign Tpl_877 = Tpl_888;
assign Tpl_873 = Tpl_889;
assign Tpl_874 = Tpl_890;
assign Tpl_876 = Tpl_891;
assign Tpl_875 = Tpl_892;
assign Tpl_878 = Tpl_893;
assign Tpl_879 = Tpl_894;

assign Tpl_949 = Tpl_867;
assign Tpl_943 = Tpl_870;
assign Tpl_944 = Tpl_871;
assign Tpl_945 = Tpl_877;
assign Tpl_946 = Tpl_877;
assign Tpl_947 = Tpl_878;
assign Tpl_948 = Tpl_879;
assign Tpl_872 = Tpl_950;
assign Tpl_888 = Tpl_897;

assign Tpl_898 = Tpl_895;
assign Tpl_899 = Tpl_886;
assign Tpl_900 = Tpl_887;
assign Tpl_901 = Tpl_885;
assign Tpl_902 = Tpl_884;
assign Tpl_889 = Tpl_903;
assign Tpl_891 = Tpl_904;
assign Tpl_890 = Tpl_905;
assign Tpl_892 = Tpl_906;
assign Tpl_896 = Tpl_907;
assign Tpl_897 = Tpl_908;

assign Tpl_926 = Tpl_882;
assign Tpl_927 = Tpl_883;
assign Tpl_924 = Tpl_896;
assign Tpl_925 = Tpl_897;
assign Tpl_895 = Tpl_928;

assign Tpl_931 = Tpl_882;
assign Tpl_932 = Tpl_883;
assign Tpl_933 = Tpl_897;
assign Tpl_893 = Tpl_934;

assign Tpl_937 = Tpl_882;
assign Tpl_938 = Tpl_883;
assign Tpl_939 = Tpl_896;
assign Tpl_894 = Tpl_940;

assign Tpl_909 = Tpl_898;
assign Tpl_910 = Tpl_899;
assign Tpl_911 = Tpl_900;
assign Tpl_903 = Tpl_912;
assign Tpl_904 = Tpl_913;
assign Tpl_905 = Tpl_914;
assign Tpl_906 = Tpl_915;

assign Tpl_917 = Tpl_903;
assign Tpl_918 = Tpl_901;
assign Tpl_907 = Tpl_919;

assign Tpl_920 = Tpl_904;
assign Tpl_921 = Tpl_901;
assign Tpl_922 = Tpl_902;
assign Tpl_908 = Tpl_923;
assign Tpl_916 = 8;
assign Tpl_914 = (Tpl_909 <= {{1'b0 , Tpl_910}});
assign Tpl_915 = (Tpl_909 >= {{1'b0 , Tpl_911}});
assign Tpl_912 = (Tpl_909 == 0);
assign Tpl_913 = (Tpl_909 == Tpl_916);
assign Tpl_919 = ((~Tpl_917) & Tpl_918);
assign Tpl_923 = (Tpl_920 ? (Tpl_922 & Tpl_921) : Tpl_922);
assign Tpl_928 = Tpl_930;

always @(*)
begin: UPDATE_NX_COUNT_PROC_386
case ({{Tpl_924 , Tpl_925}})
2'b10: Tpl_929 = (Tpl_930 - 1);
2'b01: Tpl_929 = (Tpl_930 + 1);
default: Tpl_929 = Tpl_930;
endcase
end


always @( posedge Tpl_926 or negedge Tpl_927 )
begin: UPDATE_COUNT_PROC_387
if ((!Tpl_927))
Tpl_930 <= 0;
else
Tpl_930 <= Tpl_929;
end

assign Tpl_934 = Tpl_936;
assign Tpl_935 = ((Tpl_936 == (8 - 1)) ? 0 : (Tpl_936 + 1));

always @( posedge Tpl_931 or negedge Tpl_932 )
begin: COUNTER_UPDATE_PROC_388
if ((!Tpl_932))
Tpl_936 <= 0;
else
if (Tpl_933)
Tpl_936 <= Tpl_935;
end

assign Tpl_940 = Tpl_942;
assign Tpl_941 = ((Tpl_942 == (8 - 1)) ? 0 : (Tpl_942 + 1));

always @( posedge Tpl_937 or negedge Tpl_938 )
begin: COUNTER_UPDATE_PROC_389
if ((!Tpl_938))
Tpl_942 <= 0;
else
if (Tpl_939)
Tpl_942 <= Tpl_941;
end


function integer   ceil_log2_56;
input integer   data ;
integer   i ;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_56 = (i + 1);

end
endfunction

assign Tpl_953 = (Tpl_946 & Tpl_945);

assign Tpl_955 = Tpl_952;
assign Tpl_956 = Tpl_948;
assign Tpl_950 = Tpl_957;

assign Tpl_962 = Tpl_947;
assign Tpl_951 = Tpl_963;
assign Tpl_961 = Tpl_953;

assign Tpl_964 = Tpl_949;
assign Tpl_965 = Tpl_951[0];
assign Tpl_966 = Tpl_943;
assign Tpl_967 = Tpl_944;
assign Tpl_952[0] = Tpl_968;

assign Tpl_969 = Tpl_949;
assign Tpl_970 = Tpl_951[1];
assign Tpl_971 = Tpl_943;
assign Tpl_972 = Tpl_944;
assign Tpl_952[1] = Tpl_973;

assign Tpl_974 = Tpl_949;
assign Tpl_975 = Tpl_951[2];
assign Tpl_976 = Tpl_943;
assign Tpl_977 = Tpl_944;
assign Tpl_952[2] = Tpl_978;

assign Tpl_979 = Tpl_949;
assign Tpl_980 = Tpl_951[3];
assign Tpl_981 = Tpl_943;
assign Tpl_982 = Tpl_944;
assign Tpl_952[3] = Tpl_983;

assign Tpl_984 = Tpl_949;
assign Tpl_985 = Tpl_951[4];
assign Tpl_986 = Tpl_943;
assign Tpl_987 = Tpl_944;
assign Tpl_952[4] = Tpl_988;

assign Tpl_989 = Tpl_949;
assign Tpl_990 = Tpl_951[5];
assign Tpl_991 = Tpl_943;
assign Tpl_992 = Tpl_944;
assign Tpl_952[5] = Tpl_993;

assign Tpl_994 = Tpl_949;
assign Tpl_995 = Tpl_951[6];
assign Tpl_996 = Tpl_943;
assign Tpl_997 = Tpl_944;
assign Tpl_952[6] = Tpl_998;

assign Tpl_999 = Tpl_949;
assign Tpl_1000 = Tpl_951[7];
assign Tpl_1001 = Tpl_943;
assign Tpl_1002 = Tpl_944;
assign Tpl_952[7] = Tpl_1003;

function integer   ceil_log2_57;
input integer   data ;
integer   i ;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_57 = (i + 1);

end
endfunction

assign Tpl_957 = Tpl_958[Tpl_956];
assign Tpl_958[0] = Tpl_955[0];
assign Tpl_958[1] = Tpl_955[1];
assign Tpl_958[2] = Tpl_955[2];
assign Tpl_958[3] = Tpl_955[3];
assign Tpl_958[4] = Tpl_955[4];
assign Tpl_958[5] = Tpl_955[5];
assign Tpl_958[6] = Tpl_955[6];
assign Tpl_958[7] = Tpl_955[7];
assign Tpl_963 = (Tpl_961 ? ({{({{(7){{1'b0}}}}) , 1'b1}} << Tpl_962) : ({{(8){{1'b0}}}}));

always @( posedge Tpl_966 or negedge Tpl_967 )
begin: SINGLE_RAM_PROC_392
if ((!Tpl_967))
Tpl_968 <= 0;
else
if (Tpl_965)
Tpl_968 <= Tpl_964;
end


always @( posedge Tpl_971 or negedge Tpl_972 )
begin: SINGLE_RAM_PROC_393
if ((!Tpl_972))
Tpl_973 <= 0;
else
if (Tpl_970)
Tpl_973 <= Tpl_969;
end


always @( posedge Tpl_976 or negedge Tpl_977 )
begin: SINGLE_RAM_PROC_394
if ((!Tpl_977))
Tpl_978 <= 0;
else
if (Tpl_975)
Tpl_978 <= Tpl_974;
end


always @( posedge Tpl_981 or negedge Tpl_982 )
begin: SINGLE_RAM_PROC_395
if ((!Tpl_982))
Tpl_983 <= 0;
else
if (Tpl_980)
Tpl_983 <= Tpl_979;
end


always @( posedge Tpl_986 or negedge Tpl_987 )
begin: SINGLE_RAM_PROC_396
if ((!Tpl_987))
Tpl_988 <= 0;
else
if (Tpl_985)
Tpl_988 <= Tpl_984;
end


always @( posedge Tpl_991 or negedge Tpl_992 )
begin: SINGLE_RAM_PROC_397
if ((!Tpl_992))
Tpl_993 <= 0;
else
if (Tpl_990)
Tpl_993 <= Tpl_989;
end


always @( posedge Tpl_996 or negedge Tpl_997 )
begin: SINGLE_RAM_PROC_398
if ((!Tpl_997))
Tpl_998 <= 0;
else
if (Tpl_995)
Tpl_998 <= Tpl_994;
end


always @( posedge Tpl_1001 or negedge Tpl_1002 )
begin: SINGLE_RAM_PROC_399
if ((!Tpl_1002))
Tpl_1003 <= 0;
else
if (Tpl_1000)
Tpl_1003 <= Tpl_999;
end


always @( posedge Tpl_1004 or negedge Tpl_1005 )
begin
if ((~Tpl_1005))
begin
Tpl_1015 <= 1'b0;
Tpl_1016 <= 1'b0;
end
else
begin
Tpl_1015 <= (Tpl_1010 == 2'b01);
Tpl_1016 <= (Tpl_1010 == 2'b10);
end
end


always @(*)
begin
Tpl_1018 = ST_IDLE_1;
case (Tpl_1017)
ST_IDLE_1: if (Tpl_1007)
Tpl_1018 = ST_WRTRANS_0_2;
else
Tpl_1018 = ST_IDLE_1;
ST_WRTRANS_0_2: if (Tpl_1016)
Tpl_1018 = ST_IDLE_1;
else
Tpl_1018 = ST_WRTRANS_1_3;
ST_WRTRANS_1_3: if (Tpl_1015)
Tpl_1018 = ST_IDLE_1;
else
Tpl_1018 = ST_WRTRANS_2_4;
ST_WRTRANS_2_4: Tpl_1018 = ST_WRTRANS_3_5;
ST_WRTRANS_3_5: Tpl_1018 = ST_IDLE_1;
default: Tpl_1018 = Tpl_1017;
endcase
end


always @( posedge Tpl_1004 or negedge Tpl_1005 )
begin
if ((~Tpl_1005))
begin
Tpl_1012 <= 72'hffffffffffffffffff;
end
else
if ((Tpl_1017 != ST_IDLE_1))
Tpl_1012 <= (Tpl_1016 ? {{Tpl_1009[7] , Tpl_1008[63:56] , Tpl_1009[6] , Tpl_1008[55:48] , Tpl_1009[5] , Tpl_1008[47:40] , Tpl_1009[4] , Tpl_1008[39:32] , Tpl_1009[3] , Tpl_1008[31:24] , Tpl_1009[2] , Tpl_1008[23:16] , Tpl_1009[1] , Tpl_1008[15:8] , Tpl_1009[0] , Tpl_1008[7:0]}} : (Tpl_1015 ? {{Tpl_1009[3] , Tpl_1008[31:24] , Tpl_1009[2] , Tpl_1008[23:16] , Tpl_1009[1] , Tpl_1008[15:8] , Tpl_1009[0] , Tpl_1008[7:0] , Tpl_1012[71:36]}} : {{Tpl_1009[1] , Tpl_1008[15:8] , Tpl_1009[0] , Tpl_1008[7:0] , Tpl_1012[71:18]}}));
else
Tpl_1012 <= 72'hffffffffffffffffff;
end


always @( posedge Tpl_1004 or negedge Tpl_1005 )
begin
if ((~Tpl_1005))
Tpl_1017 <= ST_IDLE_1;
else
Tpl_1017 <= Tpl_1018;
end

assign Tpl_1013 = (Tpl_1006 ? Tpl_1012 : {{Tpl_1012[35:0] , Tpl_1012[71:36]}});
assign Tpl_1011 = Tpl_1014;
assign Tpl_1014[0][0] = Tpl_1013[0][0];
assign Tpl_1014[0][1] = Tpl_1013[1][0];
assign Tpl_1014[0][2] = Tpl_1013[2][0];
assign Tpl_1014[0][3] = Tpl_1013[3][0];
assign Tpl_1014[0][4] = Tpl_1013[4][0];
assign Tpl_1014[0][5] = Tpl_1013[5][0];
assign Tpl_1014[0][6] = Tpl_1013[6][0];
assign Tpl_1014[0][7] = Tpl_1013[7][0];
assign Tpl_1014[1][0] = Tpl_1013[0][1];
assign Tpl_1014[1][1] = Tpl_1013[1][1];
assign Tpl_1014[1][2] = Tpl_1013[2][1];
assign Tpl_1014[1][3] = Tpl_1013[3][1];
assign Tpl_1014[1][4] = Tpl_1013[4][1];
assign Tpl_1014[1][5] = Tpl_1013[5][1];
assign Tpl_1014[1][6] = Tpl_1013[6][1];
assign Tpl_1014[1][7] = Tpl_1013[7][1];
assign Tpl_1014[2][0] = Tpl_1013[0][2];
assign Tpl_1014[2][1] = Tpl_1013[1][2];
assign Tpl_1014[2][2] = Tpl_1013[2][2];
assign Tpl_1014[2][3] = Tpl_1013[3][2];
assign Tpl_1014[2][4] = Tpl_1013[4][2];
assign Tpl_1014[2][5] = Tpl_1013[5][2];
assign Tpl_1014[2][6] = Tpl_1013[6][2];
assign Tpl_1014[2][7] = Tpl_1013[7][2];
assign Tpl_1014[3][0] = Tpl_1013[0][3];
assign Tpl_1014[3][1] = Tpl_1013[1][3];
assign Tpl_1014[3][2] = Tpl_1013[2][3];
assign Tpl_1014[3][3] = Tpl_1013[3][3];
assign Tpl_1014[3][4] = Tpl_1013[4][3];
assign Tpl_1014[3][5] = Tpl_1013[5][3];
assign Tpl_1014[3][6] = Tpl_1013[6][3];
assign Tpl_1014[3][7] = Tpl_1013[7][3];
assign Tpl_1014[4][0] = Tpl_1013[0][4];
assign Tpl_1014[4][1] = Tpl_1013[1][4];
assign Tpl_1014[4][2] = Tpl_1013[2][4];
assign Tpl_1014[4][3] = Tpl_1013[3][4];
assign Tpl_1014[4][4] = Tpl_1013[4][4];
assign Tpl_1014[4][5] = Tpl_1013[5][4];
assign Tpl_1014[4][6] = Tpl_1013[6][4];
assign Tpl_1014[4][7] = Tpl_1013[7][4];
assign Tpl_1014[5][0] = Tpl_1013[0][5];
assign Tpl_1014[5][1] = Tpl_1013[1][5];
assign Tpl_1014[5][2] = Tpl_1013[2][5];
assign Tpl_1014[5][3] = Tpl_1013[3][5];
assign Tpl_1014[5][4] = Tpl_1013[4][5];
assign Tpl_1014[5][5] = Tpl_1013[5][5];
assign Tpl_1014[5][6] = Tpl_1013[6][5];
assign Tpl_1014[5][7] = Tpl_1013[7][5];
assign Tpl_1014[6][0] = Tpl_1013[0][6];
assign Tpl_1014[6][1] = Tpl_1013[1][6];
assign Tpl_1014[6][2] = Tpl_1013[2][6];
assign Tpl_1014[6][3] = Tpl_1013[3][6];
assign Tpl_1014[6][4] = Tpl_1013[4][6];
assign Tpl_1014[6][5] = Tpl_1013[5][6];
assign Tpl_1014[6][6] = Tpl_1013[6][6];
assign Tpl_1014[6][7] = Tpl_1013[7][6];
assign Tpl_1014[7][0] = Tpl_1013[0][7];
assign Tpl_1014[7][1] = Tpl_1013[1][7];
assign Tpl_1014[7][2] = Tpl_1013[2][7];
assign Tpl_1014[7][3] = Tpl_1013[3][7];
assign Tpl_1014[7][4] = Tpl_1013[4][7];
assign Tpl_1014[7][5] = Tpl_1013[5][7];
assign Tpl_1014[7][6] = Tpl_1013[6][7];
assign Tpl_1014[7][7] = Tpl_1013[7][7];
assign Tpl_1014[8][0] = Tpl_1013[0][8];
assign Tpl_1014[8][1] = Tpl_1013[1][8];
assign Tpl_1014[8][2] = Tpl_1013[2][8];
assign Tpl_1014[8][3] = Tpl_1013[3][8];
assign Tpl_1014[8][4] = Tpl_1013[4][8];
assign Tpl_1014[8][5] = Tpl_1013[5][8];
assign Tpl_1014[8][6] = Tpl_1013[6][8];
assign Tpl_1014[8][7] = Tpl_1013[7][8];

always @( posedge Tpl_1021 or negedge Tpl_1022 )
begin
if ((~Tpl_1022))
begin
Tpl_1032 <= 1'b0;
Tpl_1033 <= 1'b0;
end
else
begin
Tpl_1032 <= (Tpl_1027 == 2'b01);
Tpl_1033 <= (Tpl_1027 == 2'b10);
end
end


always @(*)
begin
Tpl_1035 = ST_IDLE_1;
case (Tpl_1034)
ST_IDLE_1: if (Tpl_1024)
Tpl_1035 = ST_WRTRANS_0_2;
else
Tpl_1035 = ST_IDLE_1;
ST_WRTRANS_0_2: if (Tpl_1033)
Tpl_1035 = ST_IDLE_1;
else
Tpl_1035 = ST_WRTRANS_1_3;
ST_WRTRANS_1_3: if (Tpl_1032)
Tpl_1035 = ST_IDLE_1;
else
Tpl_1035 = ST_WRTRANS_2_4;
ST_WRTRANS_2_4: Tpl_1035 = ST_WRTRANS_3_5;
ST_WRTRANS_3_5: Tpl_1035 = ST_IDLE_1;
default: Tpl_1035 = Tpl_1034;
endcase
end


always @( posedge Tpl_1021 or negedge Tpl_1022 )
begin
if ((~Tpl_1022))
begin
Tpl_1029 <= 72'hffffffffffffffffff;
end
else
if ((Tpl_1034 != ST_IDLE_1))
Tpl_1029 <= (Tpl_1033 ? {{Tpl_1026[7] , Tpl_1025[63:56] , Tpl_1026[6] , Tpl_1025[55:48] , Tpl_1026[5] , Tpl_1025[47:40] , Tpl_1026[4] , Tpl_1025[39:32] , Tpl_1026[3] , Tpl_1025[31:24] , Tpl_1026[2] , Tpl_1025[23:16] , Tpl_1026[1] , Tpl_1025[15:8] , Tpl_1026[0] , Tpl_1025[7:0]}} : (Tpl_1032 ? {{Tpl_1026[3] , Tpl_1025[31:24] , Tpl_1026[2] , Tpl_1025[23:16] , Tpl_1026[1] , Tpl_1025[15:8] , Tpl_1026[0] , Tpl_1025[7:0] , Tpl_1029[71:36]}} : {{Tpl_1026[1] , Tpl_1025[15:8] , Tpl_1026[0] , Tpl_1025[7:0] , Tpl_1029[71:18]}}));
else
Tpl_1029 <= 72'hffffffffffffffffff;
end


always @( posedge Tpl_1021 or negedge Tpl_1022 )
begin
if ((~Tpl_1022))
Tpl_1034 <= ST_IDLE_1;
else
Tpl_1034 <= Tpl_1035;
end

assign Tpl_1030 = (Tpl_1023 ? Tpl_1029 : {{Tpl_1029[35:0] , Tpl_1029[71:36]}});
assign Tpl_1028 = Tpl_1031;
assign Tpl_1031[0][0] = Tpl_1030[0][0];
assign Tpl_1031[0][1] = Tpl_1030[1][0];
assign Tpl_1031[0][2] = Tpl_1030[2][0];
assign Tpl_1031[0][3] = Tpl_1030[3][0];
assign Tpl_1031[0][4] = Tpl_1030[4][0];
assign Tpl_1031[0][5] = Tpl_1030[5][0];
assign Tpl_1031[0][6] = Tpl_1030[6][0];
assign Tpl_1031[0][7] = Tpl_1030[7][0];
assign Tpl_1031[1][0] = Tpl_1030[0][1];
assign Tpl_1031[1][1] = Tpl_1030[1][1];
assign Tpl_1031[1][2] = Tpl_1030[2][1];
assign Tpl_1031[1][3] = Tpl_1030[3][1];
assign Tpl_1031[1][4] = Tpl_1030[4][1];
assign Tpl_1031[1][5] = Tpl_1030[5][1];
assign Tpl_1031[1][6] = Tpl_1030[6][1];
assign Tpl_1031[1][7] = Tpl_1030[7][1];
assign Tpl_1031[2][0] = Tpl_1030[0][2];
assign Tpl_1031[2][1] = Tpl_1030[1][2];
assign Tpl_1031[2][2] = Tpl_1030[2][2];
assign Tpl_1031[2][3] = Tpl_1030[3][2];
assign Tpl_1031[2][4] = Tpl_1030[4][2];
assign Tpl_1031[2][5] = Tpl_1030[5][2];
assign Tpl_1031[2][6] = Tpl_1030[6][2];
assign Tpl_1031[2][7] = Tpl_1030[7][2];
assign Tpl_1031[3][0] = Tpl_1030[0][3];
assign Tpl_1031[3][1] = Tpl_1030[1][3];
assign Tpl_1031[3][2] = Tpl_1030[2][3];
assign Tpl_1031[3][3] = Tpl_1030[3][3];
assign Tpl_1031[3][4] = Tpl_1030[4][3];
assign Tpl_1031[3][5] = Tpl_1030[5][3];
assign Tpl_1031[3][6] = Tpl_1030[6][3];
assign Tpl_1031[3][7] = Tpl_1030[7][3];
assign Tpl_1031[4][0] = Tpl_1030[0][4];
assign Tpl_1031[4][1] = Tpl_1030[1][4];
assign Tpl_1031[4][2] = Tpl_1030[2][4];
assign Tpl_1031[4][3] = Tpl_1030[3][4];
assign Tpl_1031[4][4] = Tpl_1030[4][4];
assign Tpl_1031[4][5] = Tpl_1030[5][4];
assign Tpl_1031[4][6] = Tpl_1030[6][4];
assign Tpl_1031[4][7] = Tpl_1030[7][4];
assign Tpl_1031[5][0] = Tpl_1030[0][5];
assign Tpl_1031[5][1] = Tpl_1030[1][5];
assign Tpl_1031[5][2] = Tpl_1030[2][5];
assign Tpl_1031[5][3] = Tpl_1030[3][5];
assign Tpl_1031[5][4] = Tpl_1030[4][5];
assign Tpl_1031[5][5] = Tpl_1030[5][5];
assign Tpl_1031[5][6] = Tpl_1030[6][5];
assign Tpl_1031[5][7] = Tpl_1030[7][5];
assign Tpl_1031[6][0] = Tpl_1030[0][6];
assign Tpl_1031[6][1] = Tpl_1030[1][6];
assign Tpl_1031[6][2] = Tpl_1030[2][6];
assign Tpl_1031[6][3] = Tpl_1030[3][6];
assign Tpl_1031[6][4] = Tpl_1030[4][6];
assign Tpl_1031[6][5] = Tpl_1030[5][6];
assign Tpl_1031[6][6] = Tpl_1030[6][6];
assign Tpl_1031[6][7] = Tpl_1030[7][6];
assign Tpl_1031[7][0] = Tpl_1030[0][7];
assign Tpl_1031[7][1] = Tpl_1030[1][7];
assign Tpl_1031[7][2] = Tpl_1030[2][7];
assign Tpl_1031[7][3] = Tpl_1030[3][7];
assign Tpl_1031[7][4] = Tpl_1030[4][7];
assign Tpl_1031[7][5] = Tpl_1030[5][7];
assign Tpl_1031[7][6] = Tpl_1030[6][7];
assign Tpl_1031[7][7] = Tpl_1030[7][7];
assign Tpl_1031[8][0] = Tpl_1030[0][8];
assign Tpl_1031[8][1] = Tpl_1030[1][8];
assign Tpl_1031[8][2] = Tpl_1030[2][8];
assign Tpl_1031[8][3] = Tpl_1030[3][8];
assign Tpl_1031[8][4] = Tpl_1030[4][8];
assign Tpl_1031[8][5] = Tpl_1030[5][8];
assign Tpl_1031[8][6] = Tpl_1030[6][8];
assign Tpl_1031[8][7] = Tpl_1030[7][8];

always @( posedge Tpl_1038 or negedge Tpl_1039 )
begin
if ((~Tpl_1039))
begin
Tpl_1049 <= 1'b0;
Tpl_1050 <= 1'b0;
end
else
begin
Tpl_1049 <= (Tpl_1044 == 2'b01);
Tpl_1050 <= (Tpl_1044 == 2'b10);
end
end


always @(*)
begin
Tpl_1052 = ST_IDLE_1;
case (Tpl_1051)
ST_IDLE_1: if (Tpl_1041)
Tpl_1052 = ST_WRTRANS_0_2;
else
Tpl_1052 = ST_IDLE_1;
ST_WRTRANS_0_2: if (Tpl_1050)
Tpl_1052 = ST_IDLE_1;
else
Tpl_1052 = ST_WRTRANS_1_3;
ST_WRTRANS_1_3: if (Tpl_1049)
Tpl_1052 = ST_IDLE_1;
else
Tpl_1052 = ST_WRTRANS_2_4;
ST_WRTRANS_2_4: Tpl_1052 = ST_WRTRANS_3_5;
ST_WRTRANS_3_5: Tpl_1052 = ST_IDLE_1;
default: Tpl_1052 = Tpl_1051;
endcase
end


always @( posedge Tpl_1038 or negedge Tpl_1039 )
begin
if ((~Tpl_1039))
begin
Tpl_1046 <= 72'hffffffffffffffffff;
end
else
if ((Tpl_1051 != ST_IDLE_1))
Tpl_1046 <= (Tpl_1050 ? {{Tpl_1043[7] , Tpl_1042[63:56] , Tpl_1043[6] , Tpl_1042[55:48] , Tpl_1043[5] , Tpl_1042[47:40] , Tpl_1043[4] , Tpl_1042[39:32] , Tpl_1043[3] , Tpl_1042[31:24] , Tpl_1043[2] , Tpl_1042[23:16] , Tpl_1043[1] , Tpl_1042[15:8] , Tpl_1043[0] , Tpl_1042[7:0]}} : (Tpl_1049 ? {{Tpl_1043[3] , Tpl_1042[31:24] , Tpl_1043[2] , Tpl_1042[23:16] , Tpl_1043[1] , Tpl_1042[15:8] , Tpl_1043[0] , Tpl_1042[7:0] , Tpl_1046[71:36]}} : {{Tpl_1043[1] , Tpl_1042[15:8] , Tpl_1043[0] , Tpl_1042[7:0] , Tpl_1046[71:18]}}));
else
Tpl_1046 <= 72'hffffffffffffffffff;
end


always @( posedge Tpl_1038 or negedge Tpl_1039 )
begin
if ((~Tpl_1039))
Tpl_1051 <= ST_IDLE_1;
else
Tpl_1051 <= Tpl_1052;
end

assign Tpl_1047 = (Tpl_1040 ? Tpl_1046 : {{Tpl_1046[35:0] , Tpl_1046[71:36]}});
assign Tpl_1045 = Tpl_1048;
assign Tpl_1048[0][0] = Tpl_1047[0][0];
assign Tpl_1048[0][1] = Tpl_1047[1][0];
assign Tpl_1048[0][2] = Tpl_1047[2][0];
assign Tpl_1048[0][3] = Tpl_1047[3][0];
assign Tpl_1048[0][4] = Tpl_1047[4][0];
assign Tpl_1048[0][5] = Tpl_1047[5][0];
assign Tpl_1048[0][6] = Tpl_1047[6][0];
assign Tpl_1048[0][7] = Tpl_1047[7][0];
assign Tpl_1048[1][0] = Tpl_1047[0][1];
assign Tpl_1048[1][1] = Tpl_1047[1][1];
assign Tpl_1048[1][2] = Tpl_1047[2][1];
assign Tpl_1048[1][3] = Tpl_1047[3][1];
assign Tpl_1048[1][4] = Tpl_1047[4][1];
assign Tpl_1048[1][5] = Tpl_1047[5][1];
assign Tpl_1048[1][6] = Tpl_1047[6][1];
assign Tpl_1048[1][7] = Tpl_1047[7][1];
assign Tpl_1048[2][0] = Tpl_1047[0][2];
assign Tpl_1048[2][1] = Tpl_1047[1][2];
assign Tpl_1048[2][2] = Tpl_1047[2][2];
assign Tpl_1048[2][3] = Tpl_1047[3][2];
assign Tpl_1048[2][4] = Tpl_1047[4][2];
assign Tpl_1048[2][5] = Tpl_1047[5][2];
assign Tpl_1048[2][6] = Tpl_1047[6][2];
assign Tpl_1048[2][7] = Tpl_1047[7][2];
assign Tpl_1048[3][0] = Tpl_1047[0][3];
assign Tpl_1048[3][1] = Tpl_1047[1][3];
assign Tpl_1048[3][2] = Tpl_1047[2][3];
assign Tpl_1048[3][3] = Tpl_1047[3][3];
assign Tpl_1048[3][4] = Tpl_1047[4][3];
assign Tpl_1048[3][5] = Tpl_1047[5][3];
assign Tpl_1048[3][6] = Tpl_1047[6][3];
assign Tpl_1048[3][7] = Tpl_1047[7][3];
assign Tpl_1048[4][0] = Tpl_1047[0][4];
assign Tpl_1048[4][1] = Tpl_1047[1][4];
assign Tpl_1048[4][2] = Tpl_1047[2][4];
assign Tpl_1048[4][3] = Tpl_1047[3][4];
assign Tpl_1048[4][4] = Tpl_1047[4][4];
assign Tpl_1048[4][5] = Tpl_1047[5][4];
assign Tpl_1048[4][6] = Tpl_1047[6][4];
assign Tpl_1048[4][7] = Tpl_1047[7][4];
assign Tpl_1048[5][0] = Tpl_1047[0][5];
assign Tpl_1048[5][1] = Tpl_1047[1][5];
assign Tpl_1048[5][2] = Tpl_1047[2][5];
assign Tpl_1048[5][3] = Tpl_1047[3][5];
assign Tpl_1048[5][4] = Tpl_1047[4][5];
assign Tpl_1048[5][5] = Tpl_1047[5][5];
assign Tpl_1048[5][6] = Tpl_1047[6][5];
assign Tpl_1048[5][7] = Tpl_1047[7][5];
assign Tpl_1048[6][0] = Tpl_1047[0][6];
assign Tpl_1048[6][1] = Tpl_1047[1][6];
assign Tpl_1048[6][2] = Tpl_1047[2][6];
assign Tpl_1048[6][3] = Tpl_1047[3][6];
assign Tpl_1048[6][4] = Tpl_1047[4][6];
assign Tpl_1048[6][5] = Tpl_1047[5][6];
assign Tpl_1048[6][6] = Tpl_1047[6][6];
assign Tpl_1048[6][7] = Tpl_1047[7][6];
assign Tpl_1048[7][0] = Tpl_1047[0][7];
assign Tpl_1048[7][1] = Tpl_1047[1][7];
assign Tpl_1048[7][2] = Tpl_1047[2][7];
assign Tpl_1048[7][3] = Tpl_1047[3][7];
assign Tpl_1048[7][4] = Tpl_1047[4][7];
assign Tpl_1048[7][5] = Tpl_1047[5][7];
assign Tpl_1048[7][6] = Tpl_1047[6][7];
assign Tpl_1048[7][7] = Tpl_1047[7][7];
assign Tpl_1048[8][0] = Tpl_1047[0][8];
assign Tpl_1048[8][1] = Tpl_1047[1][8];
assign Tpl_1048[8][2] = Tpl_1047[2][8];
assign Tpl_1048[8][3] = Tpl_1047[3][8];
assign Tpl_1048[8][4] = Tpl_1047[4][8];
assign Tpl_1048[8][5] = Tpl_1047[5][8];
assign Tpl_1048[8][6] = Tpl_1047[6][8];
assign Tpl_1048[8][7] = Tpl_1047[7][8];

always @( posedge Tpl_1055 or negedge Tpl_1056 )
begin
if ((~Tpl_1056))
begin
Tpl_1066 <= 1'b0;
Tpl_1067 <= 1'b0;
end
else
begin
Tpl_1066 <= (Tpl_1061 == 2'b01);
Tpl_1067 <= (Tpl_1061 == 2'b10);
end
end


always @(*)
begin
Tpl_1069 = ST_IDLE_1;
case (Tpl_1068)
ST_IDLE_1: if (Tpl_1058)
Tpl_1069 = ST_WRTRANS_0_2;
else
Tpl_1069 = ST_IDLE_1;
ST_WRTRANS_0_2: if (Tpl_1067)
Tpl_1069 = ST_IDLE_1;
else
Tpl_1069 = ST_WRTRANS_1_3;
ST_WRTRANS_1_3: if (Tpl_1066)
Tpl_1069 = ST_IDLE_1;
else
Tpl_1069 = ST_WRTRANS_2_4;
ST_WRTRANS_2_4: Tpl_1069 = ST_WRTRANS_3_5;
ST_WRTRANS_3_5: Tpl_1069 = ST_IDLE_1;
default: Tpl_1069 = Tpl_1068;
endcase
end


always @( posedge Tpl_1055 or negedge Tpl_1056 )
begin
if ((~Tpl_1056))
begin
Tpl_1063 <= 72'hffffffffffffffffff;
end
else
if ((Tpl_1068 != ST_IDLE_1))
Tpl_1063 <= (Tpl_1067 ? {{Tpl_1060[7] , Tpl_1059[63:56] , Tpl_1060[6] , Tpl_1059[55:48] , Tpl_1060[5] , Tpl_1059[47:40] , Tpl_1060[4] , Tpl_1059[39:32] , Tpl_1060[3] , Tpl_1059[31:24] , Tpl_1060[2] , Tpl_1059[23:16] , Tpl_1060[1] , Tpl_1059[15:8] , Tpl_1060[0] , Tpl_1059[7:0]}} : (Tpl_1066 ? {{Tpl_1060[3] , Tpl_1059[31:24] , Tpl_1060[2] , Tpl_1059[23:16] , Tpl_1060[1] , Tpl_1059[15:8] , Tpl_1060[0] , Tpl_1059[7:0] , Tpl_1063[71:36]}} : {{Tpl_1060[1] , Tpl_1059[15:8] , Tpl_1060[0] , Tpl_1059[7:0] , Tpl_1063[71:18]}}));
else
Tpl_1063 <= 72'hffffffffffffffffff;
end


always @( posedge Tpl_1055 or negedge Tpl_1056 )
begin
if ((~Tpl_1056))
Tpl_1068 <= ST_IDLE_1;
else
Tpl_1068 <= Tpl_1069;
end

assign Tpl_1064 = (Tpl_1057 ? Tpl_1063 : {{Tpl_1063[35:0] , Tpl_1063[71:36]}});
assign Tpl_1062 = Tpl_1065;
assign Tpl_1065[0][0] = Tpl_1064[0][0];
assign Tpl_1065[0][1] = Tpl_1064[1][0];
assign Tpl_1065[0][2] = Tpl_1064[2][0];
assign Tpl_1065[0][3] = Tpl_1064[3][0];
assign Tpl_1065[0][4] = Tpl_1064[4][0];
assign Tpl_1065[0][5] = Tpl_1064[5][0];
assign Tpl_1065[0][6] = Tpl_1064[6][0];
assign Tpl_1065[0][7] = Tpl_1064[7][0];
assign Tpl_1065[1][0] = Tpl_1064[0][1];
assign Tpl_1065[1][1] = Tpl_1064[1][1];
assign Tpl_1065[1][2] = Tpl_1064[2][1];
assign Tpl_1065[1][3] = Tpl_1064[3][1];
assign Tpl_1065[1][4] = Tpl_1064[4][1];
assign Tpl_1065[1][5] = Tpl_1064[5][1];
assign Tpl_1065[1][6] = Tpl_1064[6][1];
assign Tpl_1065[1][7] = Tpl_1064[7][1];
assign Tpl_1065[2][0] = Tpl_1064[0][2];
assign Tpl_1065[2][1] = Tpl_1064[1][2];
assign Tpl_1065[2][2] = Tpl_1064[2][2];
assign Tpl_1065[2][3] = Tpl_1064[3][2];
assign Tpl_1065[2][4] = Tpl_1064[4][2];
assign Tpl_1065[2][5] = Tpl_1064[5][2];
assign Tpl_1065[2][6] = Tpl_1064[6][2];
assign Tpl_1065[2][7] = Tpl_1064[7][2];
assign Tpl_1065[3][0] = Tpl_1064[0][3];
assign Tpl_1065[3][1] = Tpl_1064[1][3];
assign Tpl_1065[3][2] = Tpl_1064[2][3];
assign Tpl_1065[3][3] = Tpl_1064[3][3];
assign Tpl_1065[3][4] = Tpl_1064[4][3];
assign Tpl_1065[3][5] = Tpl_1064[5][3];
assign Tpl_1065[3][6] = Tpl_1064[6][3];
assign Tpl_1065[3][7] = Tpl_1064[7][3];
assign Tpl_1065[4][0] = Tpl_1064[0][4];
assign Tpl_1065[4][1] = Tpl_1064[1][4];
assign Tpl_1065[4][2] = Tpl_1064[2][4];
assign Tpl_1065[4][3] = Tpl_1064[3][4];
assign Tpl_1065[4][4] = Tpl_1064[4][4];
assign Tpl_1065[4][5] = Tpl_1064[5][4];
assign Tpl_1065[4][6] = Tpl_1064[6][4];
assign Tpl_1065[4][7] = Tpl_1064[7][4];
assign Tpl_1065[5][0] = Tpl_1064[0][5];
assign Tpl_1065[5][1] = Tpl_1064[1][5];
assign Tpl_1065[5][2] = Tpl_1064[2][5];
assign Tpl_1065[5][3] = Tpl_1064[3][5];
assign Tpl_1065[5][4] = Tpl_1064[4][5];
assign Tpl_1065[5][5] = Tpl_1064[5][5];
assign Tpl_1065[5][6] = Tpl_1064[6][5];
assign Tpl_1065[5][7] = Tpl_1064[7][5];
assign Tpl_1065[6][0] = Tpl_1064[0][6];
assign Tpl_1065[6][1] = Tpl_1064[1][6];
assign Tpl_1065[6][2] = Tpl_1064[2][6];
assign Tpl_1065[6][3] = Tpl_1064[3][6];
assign Tpl_1065[6][4] = Tpl_1064[4][6];
assign Tpl_1065[6][5] = Tpl_1064[5][6];
assign Tpl_1065[6][6] = Tpl_1064[6][6];
assign Tpl_1065[6][7] = Tpl_1064[7][6];
assign Tpl_1065[7][0] = Tpl_1064[0][7];
assign Tpl_1065[7][1] = Tpl_1064[1][7];
assign Tpl_1065[7][2] = Tpl_1064[2][7];
assign Tpl_1065[7][3] = Tpl_1064[3][7];
assign Tpl_1065[7][4] = Tpl_1064[4][7];
assign Tpl_1065[7][5] = Tpl_1064[5][7];
assign Tpl_1065[7][6] = Tpl_1064[6][7];
assign Tpl_1065[7][7] = Tpl_1064[7][7];
assign Tpl_1065[8][0] = Tpl_1064[0][8];
assign Tpl_1065[8][1] = Tpl_1064[1][8];
assign Tpl_1065[8][2] = Tpl_1064[2][8];
assign Tpl_1065[8][3] = Tpl_1064[3][8];
assign Tpl_1065[8][4] = Tpl_1064[4][8];
assign Tpl_1065[8][5] = Tpl_1064[5][8];
assign Tpl_1065[8][6] = Tpl_1064[6][8];
assign Tpl_1065[8][7] = Tpl_1064[7][8];
assign Tpl_1076 = Tpl_1078;

always @(*)
begin
Tpl_1077 = Tpl_1075;
Tpl_1078[0] = (((((((((((((((((((((((((((((((((Tpl_1077[69] ^ Tpl_1077[68]) ^ Tpl_1077[67]) ^ Tpl_1077[66]) ^ Tpl_1077[64]) ^ Tpl_1077[63]) ^ Tpl_1077[60]) ^ Tpl_1077[56]) ^ Tpl_1077[54]) ^ Tpl_1077[53]) ^ Tpl_1077[52]) ^ Tpl_1077[50]) ^ Tpl_1077[49]) ^ Tpl_1077[48]) ^ Tpl_1077[45]) ^ Tpl_1077[43]) ^ Tpl_1077[40]) ^ Tpl_1077[39]) ^ Tpl_1077[35]) ^ Tpl_1077[34]) ^ Tpl_1077[31]) ^ Tpl_1077[30]) ^ Tpl_1077[28]) ^ Tpl_1077[23]) ^ Tpl_1077[21]) ^ Tpl_1077[19]) ^ Tpl_1077[18]) ^ Tpl_1077[16]) ^ Tpl_1077[14]) ^ Tpl_1077[12]) ^ Tpl_1077[8]) ^ Tpl_1077[7]) ^ Tpl_1077[6]) ^ Tpl_1077[0]);
Tpl_1078[1] = (((((((((((((((((((((((((((((((((((((((Tpl_1077[70] ^ Tpl_1077[66]) ^ Tpl_1077[65]) ^ Tpl_1077[63]) ^ Tpl_1077[61]) ^ Tpl_1077[60]) ^ Tpl_1077[57]) ^ Tpl_1077[56]) ^ Tpl_1077[55]) ^ Tpl_1077[52]) ^ Tpl_1077[51]) ^ Tpl_1077[48]) ^ Tpl_1077[46]) ^ Tpl_1077[45]) ^ Tpl_1077[44]) ^ Tpl_1077[43]) ^ Tpl_1077[41]) ^ Tpl_1077[39]) ^ Tpl_1077[36]) ^ Tpl_1077[34]) ^ Tpl_1077[32]) ^ Tpl_1077[30]) ^ Tpl_1077[29]) ^ Tpl_1077[28]) ^ Tpl_1077[24]) ^ Tpl_1077[23]) ^ Tpl_1077[22]) ^ Tpl_1077[21]) ^ Tpl_1077[20]) ^ Tpl_1077[18]) ^ Tpl_1077[17]) ^ Tpl_1077[16]) ^ Tpl_1077[15]) ^ Tpl_1077[14]) ^ Tpl_1077[13]) ^ Tpl_1077[12]) ^ Tpl_1077[9]) ^ Tpl_1077[6]) ^ Tpl_1077[1]) ^ Tpl_1077[0]);
Tpl_1078[2] = (((((((((((((((((((((((((((((((((((Tpl_1077[71] ^ Tpl_1077[69]) ^ Tpl_1077[68]) ^ Tpl_1077[63]) ^ Tpl_1077[62]) ^ Tpl_1077[61]) ^ Tpl_1077[60]) ^ Tpl_1077[58]) ^ Tpl_1077[57]) ^ Tpl_1077[54]) ^ Tpl_1077[50]) ^ Tpl_1077[48]) ^ Tpl_1077[47]) ^ Tpl_1077[46]) ^ Tpl_1077[44]) ^ Tpl_1077[43]) ^ Tpl_1077[42]) ^ Tpl_1077[39]) ^ Tpl_1077[37]) ^ Tpl_1077[34]) ^ Tpl_1077[33]) ^ Tpl_1077[29]) ^ Tpl_1077[28]) ^ Tpl_1077[25]) ^ Tpl_1077[24]) ^ Tpl_1077[22]) ^ Tpl_1077[17]) ^ Tpl_1077[15]) ^ Tpl_1077[13]) ^ Tpl_1077[12]) ^ Tpl_1077[10]) ^ Tpl_1077[8]) ^ Tpl_1077[6]) ^ Tpl_1077[2]) ^ Tpl_1077[1]) ^ Tpl_1077[0]);
Tpl_1078[3] = ((((((((((((((((((((((((((((((((((Tpl_1077[70] ^ Tpl_1077[69]) ^ Tpl_1077[64]) ^ Tpl_1077[63]) ^ Tpl_1077[62]) ^ Tpl_1077[61]) ^ Tpl_1077[59]) ^ Tpl_1077[58]) ^ Tpl_1077[55]) ^ Tpl_1077[51]) ^ Tpl_1077[49]) ^ Tpl_1077[48]) ^ Tpl_1077[47]) ^ Tpl_1077[45]) ^ Tpl_1077[44]) ^ Tpl_1077[43]) ^ Tpl_1077[40]) ^ Tpl_1077[38]) ^ Tpl_1077[35]) ^ Tpl_1077[34]) ^ Tpl_1077[30]) ^ Tpl_1077[29]) ^ Tpl_1077[26]) ^ Tpl_1077[25]) ^ Tpl_1077[23]) ^ Tpl_1077[18]) ^ Tpl_1077[16]) ^ Tpl_1077[14]) ^ Tpl_1077[13]) ^ Tpl_1077[11]) ^ Tpl_1077[9]) ^ Tpl_1077[7]) ^ Tpl_1077[3]) ^ Tpl_1077[2]) ^ Tpl_1077[1]);
Tpl_1078[4] = ((((((((((((((((((((((((((((((((((Tpl_1077[71] ^ Tpl_1077[70]) ^ Tpl_1077[65]) ^ Tpl_1077[64]) ^ Tpl_1077[63]) ^ Tpl_1077[62]) ^ Tpl_1077[60]) ^ Tpl_1077[59]) ^ Tpl_1077[56]) ^ Tpl_1077[52]) ^ Tpl_1077[50]) ^ Tpl_1077[49]) ^ Tpl_1077[48]) ^ Tpl_1077[46]) ^ Tpl_1077[45]) ^ Tpl_1077[44]) ^ Tpl_1077[41]) ^ Tpl_1077[39]) ^ Tpl_1077[36]) ^ Tpl_1077[35]) ^ Tpl_1077[31]) ^ Tpl_1077[30]) ^ Tpl_1077[27]) ^ Tpl_1077[26]) ^ Tpl_1077[24]) ^ Tpl_1077[19]) ^ Tpl_1077[17]) ^ Tpl_1077[15]) ^ Tpl_1077[14]) ^ Tpl_1077[12]) ^ Tpl_1077[10]) ^ Tpl_1077[8]) ^ Tpl_1077[4]) ^ Tpl_1077[3]) ^ Tpl_1077[2]);
Tpl_1078[5] = (((((((((((((((((((((((((((((((((Tpl_1077[71] ^ Tpl_1077[66]) ^ Tpl_1077[65]) ^ Tpl_1077[64]) ^ Tpl_1077[63]) ^ Tpl_1077[61]) ^ Tpl_1077[60]) ^ Tpl_1077[57]) ^ Tpl_1077[53]) ^ Tpl_1077[51]) ^ Tpl_1077[50]) ^ Tpl_1077[49]) ^ Tpl_1077[47]) ^ Tpl_1077[46]) ^ Tpl_1077[45]) ^ Tpl_1077[42]) ^ Tpl_1077[40]) ^ Tpl_1077[37]) ^ Tpl_1077[36]) ^ Tpl_1077[32]) ^ Tpl_1077[31]) ^ Tpl_1077[28]) ^ Tpl_1077[27]) ^ Tpl_1077[25]) ^ Tpl_1077[20]) ^ Tpl_1077[18]) ^ Tpl_1077[16]) ^ Tpl_1077[15]) ^ Tpl_1077[13]) ^ Tpl_1077[11]) ^ Tpl_1077[9]) ^ Tpl_1077[5]) ^ Tpl_1077[4]) ^ Tpl_1077[3]);
Tpl_1078[6] = ((((((((((((((((((((((((((((((((Tpl_1077[67] ^ Tpl_1077[66]) ^ Tpl_1077[65]) ^ Tpl_1077[64]) ^ Tpl_1077[62]) ^ Tpl_1077[61]) ^ Tpl_1077[58]) ^ Tpl_1077[54]) ^ Tpl_1077[52]) ^ Tpl_1077[51]) ^ Tpl_1077[50]) ^ Tpl_1077[48]) ^ Tpl_1077[47]) ^ Tpl_1077[46]) ^ Tpl_1077[43]) ^ Tpl_1077[41]) ^ Tpl_1077[38]) ^ Tpl_1077[37]) ^ Tpl_1077[33]) ^ Tpl_1077[32]) ^ Tpl_1077[29]) ^ Tpl_1077[28]) ^ Tpl_1077[26]) ^ Tpl_1077[21]) ^ Tpl_1077[19]) ^ Tpl_1077[17]) ^ Tpl_1077[16]) ^ Tpl_1077[14]) ^ Tpl_1077[12]) ^ Tpl_1077[10]) ^ Tpl_1077[6]) ^ Tpl_1077[5]) ^ Tpl_1077[4]);
Tpl_1078[7] = ((((((((((((((((((((((((((((((((Tpl_1077[68] ^ Tpl_1077[67]) ^ Tpl_1077[66]) ^ Tpl_1077[65]) ^ Tpl_1077[63]) ^ Tpl_1077[62]) ^ Tpl_1077[59]) ^ Tpl_1077[55]) ^ Tpl_1077[53]) ^ Tpl_1077[52]) ^ Tpl_1077[51]) ^ Tpl_1077[49]) ^ Tpl_1077[48]) ^ Tpl_1077[47]) ^ Tpl_1077[44]) ^ Tpl_1077[42]) ^ Tpl_1077[39]) ^ Tpl_1077[38]) ^ Tpl_1077[34]) ^ Tpl_1077[33]) ^ Tpl_1077[30]) ^ Tpl_1077[29]) ^ Tpl_1077[27]) ^ Tpl_1077[22]) ^ Tpl_1077[20]) ^ Tpl_1077[18]) ^ Tpl_1077[17]) ^ Tpl_1077[15]) ^ Tpl_1077[13]) ^ Tpl_1077[11]) ^ Tpl_1077[7]) ^ Tpl_1077[6]) ^ Tpl_1077[5]);
end

assign Tpl_1083 = Tpl_1085;

always @(*)
begin
Tpl_1084 = Tpl_1082;
Tpl_1085[0] = (((((((((((((((((((((((((((((((((Tpl_1084[69] ^ Tpl_1084[68]) ^ Tpl_1084[67]) ^ Tpl_1084[66]) ^ Tpl_1084[64]) ^ Tpl_1084[63]) ^ Tpl_1084[60]) ^ Tpl_1084[56]) ^ Tpl_1084[54]) ^ Tpl_1084[53]) ^ Tpl_1084[52]) ^ Tpl_1084[50]) ^ Tpl_1084[49]) ^ Tpl_1084[48]) ^ Tpl_1084[45]) ^ Tpl_1084[43]) ^ Tpl_1084[40]) ^ Tpl_1084[39]) ^ Tpl_1084[35]) ^ Tpl_1084[34]) ^ Tpl_1084[31]) ^ Tpl_1084[30]) ^ Tpl_1084[28]) ^ Tpl_1084[23]) ^ Tpl_1084[21]) ^ Tpl_1084[19]) ^ Tpl_1084[18]) ^ Tpl_1084[16]) ^ Tpl_1084[14]) ^ Tpl_1084[12]) ^ Tpl_1084[8]) ^ Tpl_1084[7]) ^ Tpl_1084[6]) ^ Tpl_1084[0]);
Tpl_1085[1] = (((((((((((((((((((((((((((((((((((((((Tpl_1084[70] ^ Tpl_1084[66]) ^ Tpl_1084[65]) ^ Tpl_1084[63]) ^ Tpl_1084[61]) ^ Tpl_1084[60]) ^ Tpl_1084[57]) ^ Tpl_1084[56]) ^ Tpl_1084[55]) ^ Tpl_1084[52]) ^ Tpl_1084[51]) ^ Tpl_1084[48]) ^ Tpl_1084[46]) ^ Tpl_1084[45]) ^ Tpl_1084[44]) ^ Tpl_1084[43]) ^ Tpl_1084[41]) ^ Tpl_1084[39]) ^ Tpl_1084[36]) ^ Tpl_1084[34]) ^ Tpl_1084[32]) ^ Tpl_1084[30]) ^ Tpl_1084[29]) ^ Tpl_1084[28]) ^ Tpl_1084[24]) ^ Tpl_1084[23]) ^ Tpl_1084[22]) ^ Tpl_1084[21]) ^ Tpl_1084[20]) ^ Tpl_1084[18]) ^ Tpl_1084[17]) ^ Tpl_1084[16]) ^ Tpl_1084[15]) ^ Tpl_1084[14]) ^ Tpl_1084[13]) ^ Tpl_1084[12]) ^ Tpl_1084[9]) ^ Tpl_1084[6]) ^ Tpl_1084[1]) ^ Tpl_1084[0]);
Tpl_1085[2] = (((((((((((((((((((((((((((((((((((Tpl_1084[71] ^ Tpl_1084[69]) ^ Tpl_1084[68]) ^ Tpl_1084[63]) ^ Tpl_1084[62]) ^ Tpl_1084[61]) ^ Tpl_1084[60]) ^ Tpl_1084[58]) ^ Tpl_1084[57]) ^ Tpl_1084[54]) ^ Tpl_1084[50]) ^ Tpl_1084[48]) ^ Tpl_1084[47]) ^ Tpl_1084[46]) ^ Tpl_1084[44]) ^ Tpl_1084[43]) ^ Tpl_1084[42]) ^ Tpl_1084[39]) ^ Tpl_1084[37]) ^ Tpl_1084[34]) ^ Tpl_1084[33]) ^ Tpl_1084[29]) ^ Tpl_1084[28]) ^ Tpl_1084[25]) ^ Tpl_1084[24]) ^ Tpl_1084[22]) ^ Tpl_1084[17]) ^ Tpl_1084[15]) ^ Tpl_1084[13]) ^ Tpl_1084[12]) ^ Tpl_1084[10]) ^ Tpl_1084[8]) ^ Tpl_1084[6]) ^ Tpl_1084[2]) ^ Tpl_1084[1]) ^ Tpl_1084[0]);
Tpl_1085[3] = ((((((((((((((((((((((((((((((((((Tpl_1084[70] ^ Tpl_1084[69]) ^ Tpl_1084[64]) ^ Tpl_1084[63]) ^ Tpl_1084[62]) ^ Tpl_1084[61]) ^ Tpl_1084[59]) ^ Tpl_1084[58]) ^ Tpl_1084[55]) ^ Tpl_1084[51]) ^ Tpl_1084[49]) ^ Tpl_1084[48]) ^ Tpl_1084[47]) ^ Tpl_1084[45]) ^ Tpl_1084[44]) ^ Tpl_1084[43]) ^ Tpl_1084[40]) ^ Tpl_1084[38]) ^ Tpl_1084[35]) ^ Tpl_1084[34]) ^ Tpl_1084[30]) ^ Tpl_1084[29]) ^ Tpl_1084[26]) ^ Tpl_1084[25]) ^ Tpl_1084[23]) ^ Tpl_1084[18]) ^ Tpl_1084[16]) ^ Tpl_1084[14]) ^ Tpl_1084[13]) ^ Tpl_1084[11]) ^ Tpl_1084[9]) ^ Tpl_1084[7]) ^ Tpl_1084[3]) ^ Tpl_1084[2]) ^ Tpl_1084[1]);
Tpl_1085[4] = ((((((((((((((((((((((((((((((((((Tpl_1084[71] ^ Tpl_1084[70]) ^ Tpl_1084[65]) ^ Tpl_1084[64]) ^ Tpl_1084[63]) ^ Tpl_1084[62]) ^ Tpl_1084[60]) ^ Tpl_1084[59]) ^ Tpl_1084[56]) ^ Tpl_1084[52]) ^ Tpl_1084[50]) ^ Tpl_1084[49]) ^ Tpl_1084[48]) ^ Tpl_1084[46]) ^ Tpl_1084[45]) ^ Tpl_1084[44]) ^ Tpl_1084[41]) ^ Tpl_1084[39]) ^ Tpl_1084[36]) ^ Tpl_1084[35]) ^ Tpl_1084[31]) ^ Tpl_1084[30]) ^ Tpl_1084[27]) ^ Tpl_1084[26]) ^ Tpl_1084[24]) ^ Tpl_1084[19]) ^ Tpl_1084[17]) ^ Tpl_1084[15]) ^ Tpl_1084[14]) ^ Tpl_1084[12]) ^ Tpl_1084[10]) ^ Tpl_1084[8]) ^ Tpl_1084[4]) ^ Tpl_1084[3]) ^ Tpl_1084[2]);
Tpl_1085[5] = (((((((((((((((((((((((((((((((((Tpl_1084[71] ^ Tpl_1084[66]) ^ Tpl_1084[65]) ^ Tpl_1084[64]) ^ Tpl_1084[63]) ^ Tpl_1084[61]) ^ Tpl_1084[60]) ^ Tpl_1084[57]) ^ Tpl_1084[53]) ^ Tpl_1084[51]) ^ Tpl_1084[50]) ^ Tpl_1084[49]) ^ Tpl_1084[47]) ^ Tpl_1084[46]) ^ Tpl_1084[45]) ^ Tpl_1084[42]) ^ Tpl_1084[40]) ^ Tpl_1084[37]) ^ Tpl_1084[36]) ^ Tpl_1084[32]) ^ Tpl_1084[31]) ^ Tpl_1084[28]) ^ Tpl_1084[27]) ^ Tpl_1084[25]) ^ Tpl_1084[20]) ^ Tpl_1084[18]) ^ Tpl_1084[16]) ^ Tpl_1084[15]) ^ Tpl_1084[13]) ^ Tpl_1084[11]) ^ Tpl_1084[9]) ^ Tpl_1084[5]) ^ Tpl_1084[4]) ^ Tpl_1084[3]);
Tpl_1085[6] = ((((((((((((((((((((((((((((((((Tpl_1084[67] ^ Tpl_1084[66]) ^ Tpl_1084[65]) ^ Tpl_1084[64]) ^ Tpl_1084[62]) ^ Tpl_1084[61]) ^ Tpl_1084[58]) ^ Tpl_1084[54]) ^ Tpl_1084[52]) ^ Tpl_1084[51]) ^ Tpl_1084[50]) ^ Tpl_1084[48]) ^ Tpl_1084[47]) ^ Tpl_1084[46]) ^ Tpl_1084[43]) ^ Tpl_1084[41]) ^ Tpl_1084[38]) ^ Tpl_1084[37]) ^ Tpl_1084[33]) ^ Tpl_1084[32]) ^ Tpl_1084[29]) ^ Tpl_1084[28]) ^ Tpl_1084[26]) ^ Tpl_1084[21]) ^ Tpl_1084[19]) ^ Tpl_1084[17]) ^ Tpl_1084[16]) ^ Tpl_1084[14]) ^ Tpl_1084[12]) ^ Tpl_1084[10]) ^ Tpl_1084[6]) ^ Tpl_1084[5]) ^ Tpl_1084[4]);
Tpl_1085[7] = ((((((((((((((((((((((((((((((((Tpl_1084[68] ^ Tpl_1084[67]) ^ Tpl_1084[66]) ^ Tpl_1084[65]) ^ Tpl_1084[63]) ^ Tpl_1084[62]) ^ Tpl_1084[59]) ^ Tpl_1084[55]) ^ Tpl_1084[53]) ^ Tpl_1084[52]) ^ Tpl_1084[51]) ^ Tpl_1084[49]) ^ Tpl_1084[48]) ^ Tpl_1084[47]) ^ Tpl_1084[44]) ^ Tpl_1084[42]) ^ Tpl_1084[39]) ^ Tpl_1084[38]) ^ Tpl_1084[34]) ^ Tpl_1084[33]) ^ Tpl_1084[30]) ^ Tpl_1084[29]) ^ Tpl_1084[27]) ^ Tpl_1084[22]) ^ Tpl_1084[20]) ^ Tpl_1084[18]) ^ Tpl_1084[17]) ^ Tpl_1084[15]) ^ Tpl_1084[13]) ^ Tpl_1084[11]) ^ Tpl_1084[7]) ^ Tpl_1084[6]) ^ Tpl_1084[5]);
end

assign Tpl_1090 = Tpl_1092;

always @(*)
begin
Tpl_1091 = Tpl_1089;
Tpl_1092[0] = (((((((((((((((((((((((((((((((((Tpl_1091[69] ^ Tpl_1091[68]) ^ Tpl_1091[67]) ^ Tpl_1091[66]) ^ Tpl_1091[64]) ^ Tpl_1091[63]) ^ Tpl_1091[60]) ^ Tpl_1091[56]) ^ Tpl_1091[54]) ^ Tpl_1091[53]) ^ Tpl_1091[52]) ^ Tpl_1091[50]) ^ Tpl_1091[49]) ^ Tpl_1091[48]) ^ Tpl_1091[45]) ^ Tpl_1091[43]) ^ Tpl_1091[40]) ^ Tpl_1091[39]) ^ Tpl_1091[35]) ^ Tpl_1091[34]) ^ Tpl_1091[31]) ^ Tpl_1091[30]) ^ Tpl_1091[28]) ^ Tpl_1091[23]) ^ Tpl_1091[21]) ^ Tpl_1091[19]) ^ Tpl_1091[18]) ^ Tpl_1091[16]) ^ Tpl_1091[14]) ^ Tpl_1091[12]) ^ Tpl_1091[8]) ^ Tpl_1091[7]) ^ Tpl_1091[6]) ^ Tpl_1091[0]);
Tpl_1092[1] = (((((((((((((((((((((((((((((((((((((((Tpl_1091[70] ^ Tpl_1091[66]) ^ Tpl_1091[65]) ^ Tpl_1091[63]) ^ Tpl_1091[61]) ^ Tpl_1091[60]) ^ Tpl_1091[57]) ^ Tpl_1091[56]) ^ Tpl_1091[55]) ^ Tpl_1091[52]) ^ Tpl_1091[51]) ^ Tpl_1091[48]) ^ Tpl_1091[46]) ^ Tpl_1091[45]) ^ Tpl_1091[44]) ^ Tpl_1091[43]) ^ Tpl_1091[41]) ^ Tpl_1091[39]) ^ Tpl_1091[36]) ^ Tpl_1091[34]) ^ Tpl_1091[32]) ^ Tpl_1091[30]) ^ Tpl_1091[29]) ^ Tpl_1091[28]) ^ Tpl_1091[24]) ^ Tpl_1091[23]) ^ Tpl_1091[22]) ^ Tpl_1091[21]) ^ Tpl_1091[20]) ^ Tpl_1091[18]) ^ Tpl_1091[17]) ^ Tpl_1091[16]) ^ Tpl_1091[15]) ^ Tpl_1091[14]) ^ Tpl_1091[13]) ^ Tpl_1091[12]) ^ Tpl_1091[9]) ^ Tpl_1091[6]) ^ Tpl_1091[1]) ^ Tpl_1091[0]);
Tpl_1092[2] = (((((((((((((((((((((((((((((((((((Tpl_1091[71] ^ Tpl_1091[69]) ^ Tpl_1091[68]) ^ Tpl_1091[63]) ^ Tpl_1091[62]) ^ Tpl_1091[61]) ^ Tpl_1091[60]) ^ Tpl_1091[58]) ^ Tpl_1091[57]) ^ Tpl_1091[54]) ^ Tpl_1091[50]) ^ Tpl_1091[48]) ^ Tpl_1091[47]) ^ Tpl_1091[46]) ^ Tpl_1091[44]) ^ Tpl_1091[43]) ^ Tpl_1091[42]) ^ Tpl_1091[39]) ^ Tpl_1091[37]) ^ Tpl_1091[34]) ^ Tpl_1091[33]) ^ Tpl_1091[29]) ^ Tpl_1091[28]) ^ Tpl_1091[25]) ^ Tpl_1091[24]) ^ Tpl_1091[22]) ^ Tpl_1091[17]) ^ Tpl_1091[15]) ^ Tpl_1091[13]) ^ Tpl_1091[12]) ^ Tpl_1091[10]) ^ Tpl_1091[8]) ^ Tpl_1091[6]) ^ Tpl_1091[2]) ^ Tpl_1091[1]) ^ Tpl_1091[0]);
Tpl_1092[3] = ((((((((((((((((((((((((((((((((((Tpl_1091[70] ^ Tpl_1091[69]) ^ Tpl_1091[64]) ^ Tpl_1091[63]) ^ Tpl_1091[62]) ^ Tpl_1091[61]) ^ Tpl_1091[59]) ^ Tpl_1091[58]) ^ Tpl_1091[55]) ^ Tpl_1091[51]) ^ Tpl_1091[49]) ^ Tpl_1091[48]) ^ Tpl_1091[47]) ^ Tpl_1091[45]) ^ Tpl_1091[44]) ^ Tpl_1091[43]) ^ Tpl_1091[40]) ^ Tpl_1091[38]) ^ Tpl_1091[35]) ^ Tpl_1091[34]) ^ Tpl_1091[30]) ^ Tpl_1091[29]) ^ Tpl_1091[26]) ^ Tpl_1091[25]) ^ Tpl_1091[23]) ^ Tpl_1091[18]) ^ Tpl_1091[16]) ^ Tpl_1091[14]) ^ Tpl_1091[13]) ^ Tpl_1091[11]) ^ Tpl_1091[9]) ^ Tpl_1091[7]) ^ Tpl_1091[3]) ^ Tpl_1091[2]) ^ Tpl_1091[1]);
Tpl_1092[4] = ((((((((((((((((((((((((((((((((((Tpl_1091[71] ^ Tpl_1091[70]) ^ Tpl_1091[65]) ^ Tpl_1091[64]) ^ Tpl_1091[63]) ^ Tpl_1091[62]) ^ Tpl_1091[60]) ^ Tpl_1091[59]) ^ Tpl_1091[56]) ^ Tpl_1091[52]) ^ Tpl_1091[50]) ^ Tpl_1091[49]) ^ Tpl_1091[48]) ^ Tpl_1091[46]) ^ Tpl_1091[45]) ^ Tpl_1091[44]) ^ Tpl_1091[41]) ^ Tpl_1091[39]) ^ Tpl_1091[36]) ^ Tpl_1091[35]) ^ Tpl_1091[31]) ^ Tpl_1091[30]) ^ Tpl_1091[27]) ^ Tpl_1091[26]) ^ Tpl_1091[24]) ^ Tpl_1091[19]) ^ Tpl_1091[17]) ^ Tpl_1091[15]) ^ Tpl_1091[14]) ^ Tpl_1091[12]) ^ Tpl_1091[10]) ^ Tpl_1091[8]) ^ Tpl_1091[4]) ^ Tpl_1091[3]) ^ Tpl_1091[2]);
Tpl_1092[5] = (((((((((((((((((((((((((((((((((Tpl_1091[71] ^ Tpl_1091[66]) ^ Tpl_1091[65]) ^ Tpl_1091[64]) ^ Tpl_1091[63]) ^ Tpl_1091[61]) ^ Tpl_1091[60]) ^ Tpl_1091[57]) ^ Tpl_1091[53]) ^ Tpl_1091[51]) ^ Tpl_1091[50]) ^ Tpl_1091[49]) ^ Tpl_1091[47]) ^ Tpl_1091[46]) ^ Tpl_1091[45]) ^ Tpl_1091[42]) ^ Tpl_1091[40]) ^ Tpl_1091[37]) ^ Tpl_1091[36]) ^ Tpl_1091[32]) ^ Tpl_1091[31]) ^ Tpl_1091[28]) ^ Tpl_1091[27]) ^ Tpl_1091[25]) ^ Tpl_1091[20]) ^ Tpl_1091[18]) ^ Tpl_1091[16]) ^ Tpl_1091[15]) ^ Tpl_1091[13]) ^ Tpl_1091[11]) ^ Tpl_1091[9]) ^ Tpl_1091[5]) ^ Tpl_1091[4]) ^ Tpl_1091[3]);
Tpl_1092[6] = ((((((((((((((((((((((((((((((((Tpl_1091[67] ^ Tpl_1091[66]) ^ Tpl_1091[65]) ^ Tpl_1091[64]) ^ Tpl_1091[62]) ^ Tpl_1091[61]) ^ Tpl_1091[58]) ^ Tpl_1091[54]) ^ Tpl_1091[52]) ^ Tpl_1091[51]) ^ Tpl_1091[50]) ^ Tpl_1091[48]) ^ Tpl_1091[47]) ^ Tpl_1091[46]) ^ Tpl_1091[43]) ^ Tpl_1091[41]) ^ Tpl_1091[38]) ^ Tpl_1091[37]) ^ Tpl_1091[33]) ^ Tpl_1091[32]) ^ Tpl_1091[29]) ^ Tpl_1091[28]) ^ Tpl_1091[26]) ^ Tpl_1091[21]) ^ Tpl_1091[19]) ^ Tpl_1091[17]) ^ Tpl_1091[16]) ^ Tpl_1091[14]) ^ Tpl_1091[12]) ^ Tpl_1091[10]) ^ Tpl_1091[6]) ^ Tpl_1091[5]) ^ Tpl_1091[4]);
Tpl_1092[7] = ((((((((((((((((((((((((((((((((Tpl_1091[68] ^ Tpl_1091[67]) ^ Tpl_1091[66]) ^ Tpl_1091[65]) ^ Tpl_1091[63]) ^ Tpl_1091[62]) ^ Tpl_1091[59]) ^ Tpl_1091[55]) ^ Tpl_1091[53]) ^ Tpl_1091[52]) ^ Tpl_1091[51]) ^ Tpl_1091[49]) ^ Tpl_1091[48]) ^ Tpl_1091[47]) ^ Tpl_1091[44]) ^ Tpl_1091[42]) ^ Tpl_1091[39]) ^ Tpl_1091[38]) ^ Tpl_1091[34]) ^ Tpl_1091[33]) ^ Tpl_1091[30]) ^ Tpl_1091[29]) ^ Tpl_1091[27]) ^ Tpl_1091[22]) ^ Tpl_1091[20]) ^ Tpl_1091[18]) ^ Tpl_1091[17]) ^ Tpl_1091[15]) ^ Tpl_1091[13]) ^ Tpl_1091[11]) ^ Tpl_1091[7]) ^ Tpl_1091[6]) ^ Tpl_1091[5]);
end

assign Tpl_1097 = Tpl_1099;

always @(*)
begin
Tpl_1098 = Tpl_1096;
Tpl_1099[0] = (((((((((((((((((((((((((((((((((Tpl_1098[69] ^ Tpl_1098[68]) ^ Tpl_1098[67]) ^ Tpl_1098[66]) ^ Tpl_1098[64]) ^ Tpl_1098[63]) ^ Tpl_1098[60]) ^ Tpl_1098[56]) ^ Tpl_1098[54]) ^ Tpl_1098[53]) ^ Tpl_1098[52]) ^ Tpl_1098[50]) ^ Tpl_1098[49]) ^ Tpl_1098[48]) ^ Tpl_1098[45]) ^ Tpl_1098[43]) ^ Tpl_1098[40]) ^ Tpl_1098[39]) ^ Tpl_1098[35]) ^ Tpl_1098[34]) ^ Tpl_1098[31]) ^ Tpl_1098[30]) ^ Tpl_1098[28]) ^ Tpl_1098[23]) ^ Tpl_1098[21]) ^ Tpl_1098[19]) ^ Tpl_1098[18]) ^ Tpl_1098[16]) ^ Tpl_1098[14]) ^ Tpl_1098[12]) ^ Tpl_1098[8]) ^ Tpl_1098[7]) ^ Tpl_1098[6]) ^ Tpl_1098[0]);
Tpl_1099[1] = (((((((((((((((((((((((((((((((((((((((Tpl_1098[70] ^ Tpl_1098[66]) ^ Tpl_1098[65]) ^ Tpl_1098[63]) ^ Tpl_1098[61]) ^ Tpl_1098[60]) ^ Tpl_1098[57]) ^ Tpl_1098[56]) ^ Tpl_1098[55]) ^ Tpl_1098[52]) ^ Tpl_1098[51]) ^ Tpl_1098[48]) ^ Tpl_1098[46]) ^ Tpl_1098[45]) ^ Tpl_1098[44]) ^ Tpl_1098[43]) ^ Tpl_1098[41]) ^ Tpl_1098[39]) ^ Tpl_1098[36]) ^ Tpl_1098[34]) ^ Tpl_1098[32]) ^ Tpl_1098[30]) ^ Tpl_1098[29]) ^ Tpl_1098[28]) ^ Tpl_1098[24]) ^ Tpl_1098[23]) ^ Tpl_1098[22]) ^ Tpl_1098[21]) ^ Tpl_1098[20]) ^ Tpl_1098[18]) ^ Tpl_1098[17]) ^ Tpl_1098[16]) ^ Tpl_1098[15]) ^ Tpl_1098[14]) ^ Tpl_1098[13]) ^ Tpl_1098[12]) ^ Tpl_1098[9]) ^ Tpl_1098[6]) ^ Tpl_1098[1]) ^ Tpl_1098[0]);
Tpl_1099[2] = (((((((((((((((((((((((((((((((((((Tpl_1098[71] ^ Tpl_1098[69]) ^ Tpl_1098[68]) ^ Tpl_1098[63]) ^ Tpl_1098[62]) ^ Tpl_1098[61]) ^ Tpl_1098[60]) ^ Tpl_1098[58]) ^ Tpl_1098[57]) ^ Tpl_1098[54]) ^ Tpl_1098[50]) ^ Tpl_1098[48]) ^ Tpl_1098[47]) ^ Tpl_1098[46]) ^ Tpl_1098[44]) ^ Tpl_1098[43]) ^ Tpl_1098[42]) ^ Tpl_1098[39]) ^ Tpl_1098[37]) ^ Tpl_1098[34]) ^ Tpl_1098[33]) ^ Tpl_1098[29]) ^ Tpl_1098[28]) ^ Tpl_1098[25]) ^ Tpl_1098[24]) ^ Tpl_1098[22]) ^ Tpl_1098[17]) ^ Tpl_1098[15]) ^ Tpl_1098[13]) ^ Tpl_1098[12]) ^ Tpl_1098[10]) ^ Tpl_1098[8]) ^ Tpl_1098[6]) ^ Tpl_1098[2]) ^ Tpl_1098[1]) ^ Tpl_1098[0]);
Tpl_1099[3] = ((((((((((((((((((((((((((((((((((Tpl_1098[70] ^ Tpl_1098[69]) ^ Tpl_1098[64]) ^ Tpl_1098[63]) ^ Tpl_1098[62]) ^ Tpl_1098[61]) ^ Tpl_1098[59]) ^ Tpl_1098[58]) ^ Tpl_1098[55]) ^ Tpl_1098[51]) ^ Tpl_1098[49]) ^ Tpl_1098[48]) ^ Tpl_1098[47]) ^ Tpl_1098[45]) ^ Tpl_1098[44]) ^ Tpl_1098[43]) ^ Tpl_1098[40]) ^ Tpl_1098[38]) ^ Tpl_1098[35]) ^ Tpl_1098[34]) ^ Tpl_1098[30]) ^ Tpl_1098[29]) ^ Tpl_1098[26]) ^ Tpl_1098[25]) ^ Tpl_1098[23]) ^ Tpl_1098[18]) ^ Tpl_1098[16]) ^ Tpl_1098[14]) ^ Tpl_1098[13]) ^ Tpl_1098[11]) ^ Tpl_1098[9]) ^ Tpl_1098[7]) ^ Tpl_1098[3]) ^ Tpl_1098[2]) ^ Tpl_1098[1]);
Tpl_1099[4] = ((((((((((((((((((((((((((((((((((Tpl_1098[71] ^ Tpl_1098[70]) ^ Tpl_1098[65]) ^ Tpl_1098[64]) ^ Tpl_1098[63]) ^ Tpl_1098[62]) ^ Tpl_1098[60]) ^ Tpl_1098[59]) ^ Tpl_1098[56]) ^ Tpl_1098[52]) ^ Tpl_1098[50]) ^ Tpl_1098[49]) ^ Tpl_1098[48]) ^ Tpl_1098[46]) ^ Tpl_1098[45]) ^ Tpl_1098[44]) ^ Tpl_1098[41]) ^ Tpl_1098[39]) ^ Tpl_1098[36]) ^ Tpl_1098[35]) ^ Tpl_1098[31]) ^ Tpl_1098[30]) ^ Tpl_1098[27]) ^ Tpl_1098[26]) ^ Tpl_1098[24]) ^ Tpl_1098[19]) ^ Tpl_1098[17]) ^ Tpl_1098[15]) ^ Tpl_1098[14]) ^ Tpl_1098[12]) ^ Tpl_1098[10]) ^ Tpl_1098[8]) ^ Tpl_1098[4]) ^ Tpl_1098[3]) ^ Tpl_1098[2]);
Tpl_1099[5] = (((((((((((((((((((((((((((((((((Tpl_1098[71] ^ Tpl_1098[66]) ^ Tpl_1098[65]) ^ Tpl_1098[64]) ^ Tpl_1098[63]) ^ Tpl_1098[61]) ^ Tpl_1098[60]) ^ Tpl_1098[57]) ^ Tpl_1098[53]) ^ Tpl_1098[51]) ^ Tpl_1098[50]) ^ Tpl_1098[49]) ^ Tpl_1098[47]) ^ Tpl_1098[46]) ^ Tpl_1098[45]) ^ Tpl_1098[42]) ^ Tpl_1098[40]) ^ Tpl_1098[37]) ^ Tpl_1098[36]) ^ Tpl_1098[32]) ^ Tpl_1098[31]) ^ Tpl_1098[28]) ^ Tpl_1098[27]) ^ Tpl_1098[25]) ^ Tpl_1098[20]) ^ Tpl_1098[18]) ^ Tpl_1098[16]) ^ Tpl_1098[15]) ^ Tpl_1098[13]) ^ Tpl_1098[11]) ^ Tpl_1098[9]) ^ Tpl_1098[5]) ^ Tpl_1098[4]) ^ Tpl_1098[3]);
Tpl_1099[6] = ((((((((((((((((((((((((((((((((Tpl_1098[67] ^ Tpl_1098[66]) ^ Tpl_1098[65]) ^ Tpl_1098[64]) ^ Tpl_1098[62]) ^ Tpl_1098[61]) ^ Tpl_1098[58]) ^ Tpl_1098[54]) ^ Tpl_1098[52]) ^ Tpl_1098[51]) ^ Tpl_1098[50]) ^ Tpl_1098[48]) ^ Tpl_1098[47]) ^ Tpl_1098[46]) ^ Tpl_1098[43]) ^ Tpl_1098[41]) ^ Tpl_1098[38]) ^ Tpl_1098[37]) ^ Tpl_1098[33]) ^ Tpl_1098[32]) ^ Tpl_1098[29]) ^ Tpl_1098[28]) ^ Tpl_1098[26]) ^ Tpl_1098[21]) ^ Tpl_1098[19]) ^ Tpl_1098[17]) ^ Tpl_1098[16]) ^ Tpl_1098[14]) ^ Tpl_1098[12]) ^ Tpl_1098[10]) ^ Tpl_1098[6]) ^ Tpl_1098[5]) ^ Tpl_1098[4]);
Tpl_1099[7] = ((((((((((((((((((((((((((((((((Tpl_1098[68] ^ Tpl_1098[67]) ^ Tpl_1098[66]) ^ Tpl_1098[65]) ^ Tpl_1098[63]) ^ Tpl_1098[62]) ^ Tpl_1098[59]) ^ Tpl_1098[55]) ^ Tpl_1098[53]) ^ Tpl_1098[52]) ^ Tpl_1098[51]) ^ Tpl_1098[49]) ^ Tpl_1098[48]) ^ Tpl_1098[47]) ^ Tpl_1098[44]) ^ Tpl_1098[42]) ^ Tpl_1098[39]) ^ Tpl_1098[38]) ^ Tpl_1098[34]) ^ Tpl_1098[33]) ^ Tpl_1098[30]) ^ Tpl_1098[29]) ^ Tpl_1098[27]) ^ Tpl_1098[22]) ^ Tpl_1098[20]) ^ Tpl_1098[18]) ^ Tpl_1098[17]) ^ Tpl_1098[15]) ^ Tpl_1098[13]) ^ Tpl_1098[11]) ^ Tpl_1098[7]) ^ Tpl_1098[6]) ^ Tpl_1098[5]);
end


function integer   ceil_log2_58;
input integer   data ;
integer   i ;
ceil_log2_58 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_58 = (i + 1);

end
endfunction


function integer   last_one_59;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_59 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_59 = (i + 1);
end

end
endfunction


function integer   floor_log2_60;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_60 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_60 = ceil_log2;
else
floor_log2_60 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_61;
input integer   N ;
integer   i ;
is_onethot_61 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_61 = 1;
end
end

end
endfunction


function integer   ecc_width_62;
input integer   data_width ;
integer   i ;
ecc_width_62 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_61(i)))
begin
ecc_width_62 = (ecc_width_62 + 1);
end
end

end
endfunction

assign Tpl_1104 = (Tpl_1103 ? Tpl_1106 : Tpl_1100);
assign Tpl_1105 = (Tpl_1103 ? Tpl_1107 : Tpl_1101);

assign Tpl_1108 = Tpl_1100;
assign Tpl_1109 = Tpl_1102;
assign Tpl_1110 = Tpl_1101;
assign Tpl_1106 = Tpl_1111;
assign Tpl_1107 = Tpl_1112;

assign Tpl_1114 = Tpl_1108[7:0];
assign Tpl_1111[7:0] = Tpl_1117;
assign Tpl_1116 = Tpl_1109;
assign Tpl_1115 = Tpl_1110[(0 / 8)];
assign Tpl_1112[(0 / 8)] = Tpl_1118;

assign Tpl_1120 = Tpl_1108[15:8];
assign Tpl_1111[15:8] = Tpl_1123;
assign Tpl_1122 = Tpl_1109;
assign Tpl_1121 = Tpl_1110[(8 / 8)];
assign Tpl_1112[(8 / 8)] = Tpl_1124;

assign Tpl_1126 = Tpl_1108[23:16];
assign Tpl_1111[23:16] = Tpl_1129;
assign Tpl_1128 = Tpl_1109;
assign Tpl_1127 = Tpl_1110[(16 / 8)];
assign Tpl_1112[(16 / 8)] = Tpl_1130;

assign Tpl_1132 = Tpl_1108[31:24];
assign Tpl_1111[31:24] = Tpl_1135;
assign Tpl_1134 = Tpl_1109;
assign Tpl_1133 = Tpl_1110[(24 / 8)];
assign Tpl_1112[(24 / 8)] = Tpl_1136;

assign Tpl_1138 = Tpl_1108[39:32];
assign Tpl_1111[39:32] = Tpl_1141;
assign Tpl_1140 = Tpl_1109;
assign Tpl_1139 = Tpl_1110[(32 / 8)];
assign Tpl_1112[(32 / 8)] = Tpl_1142;

assign Tpl_1144 = Tpl_1108[47:40];
assign Tpl_1111[47:40] = Tpl_1147;
assign Tpl_1146 = Tpl_1109;
assign Tpl_1145 = Tpl_1110[(40 / 8)];
assign Tpl_1112[(40 / 8)] = Tpl_1148;

assign Tpl_1150 = Tpl_1108[55:48];
assign Tpl_1111[55:48] = Tpl_1153;
assign Tpl_1152 = Tpl_1109;
assign Tpl_1151 = Tpl_1110[(48 / 8)];
assign Tpl_1112[(48 / 8)] = Tpl_1154;

assign Tpl_1156 = Tpl_1108[63:56];
assign Tpl_1111[63:56] = Tpl_1159;
assign Tpl_1158 = Tpl_1109;
assign Tpl_1157 = Tpl_1110[(56 / 8)];
assign Tpl_1112[(56 / 8)] = Tpl_1160;

assign Tpl_1162 = Tpl_1108[71:64];
assign Tpl_1111[71:64] = Tpl_1165;
assign Tpl_1164 = Tpl_1109;
assign Tpl_1163 = Tpl_1110[(64 / 8)];
assign Tpl_1112[(64 / 8)] = Tpl_1166;

assign Tpl_1168 = Tpl_1108[79:72];
assign Tpl_1111[79:72] = Tpl_1171;
assign Tpl_1170 = Tpl_1109;
assign Tpl_1169 = Tpl_1110[(72 / 8)];
assign Tpl_1112[(72 / 8)] = Tpl_1172;

assign Tpl_1174 = Tpl_1108[87:80];
assign Tpl_1111[87:80] = Tpl_1177;
assign Tpl_1176 = Tpl_1109;
assign Tpl_1175 = Tpl_1110[(80 / 8)];
assign Tpl_1112[(80 / 8)] = Tpl_1178;

assign Tpl_1180 = Tpl_1108[95:88];
assign Tpl_1111[95:88] = Tpl_1183;
assign Tpl_1182 = Tpl_1109;
assign Tpl_1181 = Tpl_1110[(88 / 8)];
assign Tpl_1112[(88 / 8)] = Tpl_1184;

assign Tpl_1186 = Tpl_1108[103:96];
assign Tpl_1111[103:96] = Tpl_1189;
assign Tpl_1188 = Tpl_1109;
assign Tpl_1187 = Tpl_1110[(96 / 8)];
assign Tpl_1112[(96 / 8)] = Tpl_1190;

assign Tpl_1192 = Tpl_1108[111:104];
assign Tpl_1111[111:104] = Tpl_1195;
assign Tpl_1194 = Tpl_1109;
assign Tpl_1193 = Tpl_1110[(104 / 8)];
assign Tpl_1112[(104 / 8)] = Tpl_1196;

assign Tpl_1198 = Tpl_1108[119:112];
assign Tpl_1111[119:112] = Tpl_1201;
assign Tpl_1200 = Tpl_1109;
assign Tpl_1199 = Tpl_1110[(112 / 8)];
assign Tpl_1112[(112 / 8)] = Tpl_1202;

assign Tpl_1204 = Tpl_1108[127:120];
assign Tpl_1111[127:120] = Tpl_1207;
assign Tpl_1206 = Tpl_1109;
assign Tpl_1205 = Tpl_1110[(120 / 8)];
assign Tpl_1112[(120 / 8)] = Tpl_1208;

assign Tpl_1210 = Tpl_1108[135:128];
assign Tpl_1111[135:128] = Tpl_1213;
assign Tpl_1212 = Tpl_1109;
assign Tpl_1211 = Tpl_1110[(128 / 8)];
assign Tpl_1112[(128 / 8)] = Tpl_1214;

assign Tpl_1216 = Tpl_1108[143:136];
assign Tpl_1111[143:136] = Tpl_1219;
assign Tpl_1218 = Tpl_1109;
assign Tpl_1217 = Tpl_1110[(136 / 8)];
assign Tpl_1112[(136 / 8)] = Tpl_1220;

assign Tpl_1222 = Tpl_1108[151:144];
assign Tpl_1111[151:144] = Tpl_1225;
assign Tpl_1224 = Tpl_1109;
assign Tpl_1223 = Tpl_1110[(144 / 8)];
assign Tpl_1112[(144 / 8)] = Tpl_1226;

assign Tpl_1228 = Tpl_1108[159:152];
assign Tpl_1111[159:152] = Tpl_1231;
assign Tpl_1230 = Tpl_1109;
assign Tpl_1229 = Tpl_1110[(152 / 8)];
assign Tpl_1112[(152 / 8)] = Tpl_1232;

assign Tpl_1234 = Tpl_1108[167:160];
assign Tpl_1111[167:160] = Tpl_1237;
assign Tpl_1236 = Tpl_1109;
assign Tpl_1235 = Tpl_1110[(160 / 8)];
assign Tpl_1112[(160 / 8)] = Tpl_1238;

assign Tpl_1240 = Tpl_1108[175:168];
assign Tpl_1111[175:168] = Tpl_1243;
assign Tpl_1242 = Tpl_1109;
assign Tpl_1241 = Tpl_1110[(168 / 8)];
assign Tpl_1112[(168 / 8)] = Tpl_1244;

assign Tpl_1246 = Tpl_1108[183:176];
assign Tpl_1111[183:176] = Tpl_1249;
assign Tpl_1248 = Tpl_1109;
assign Tpl_1247 = Tpl_1110[(176 / 8)];
assign Tpl_1112[(176 / 8)] = Tpl_1250;

assign Tpl_1252 = Tpl_1108[191:184];
assign Tpl_1111[191:184] = Tpl_1255;
assign Tpl_1254 = Tpl_1109;
assign Tpl_1253 = Tpl_1110[(184 / 8)];
assign Tpl_1112[(184 / 8)] = Tpl_1256;

assign Tpl_1258 = Tpl_1108[199:192];
assign Tpl_1111[199:192] = Tpl_1261;
assign Tpl_1260 = Tpl_1109;
assign Tpl_1259 = Tpl_1110[(192 / 8)];
assign Tpl_1112[(192 / 8)] = Tpl_1262;

assign Tpl_1264 = Tpl_1108[207:200];
assign Tpl_1111[207:200] = Tpl_1267;
assign Tpl_1266 = Tpl_1109;
assign Tpl_1265 = Tpl_1110[(200 / 8)];
assign Tpl_1112[(200 / 8)] = Tpl_1268;

assign Tpl_1270 = Tpl_1108[215:208];
assign Tpl_1111[215:208] = Tpl_1273;
assign Tpl_1272 = Tpl_1109;
assign Tpl_1271 = Tpl_1110[(208 / 8)];
assign Tpl_1112[(208 / 8)] = Tpl_1274;

assign Tpl_1276 = Tpl_1108[223:216];
assign Tpl_1111[223:216] = Tpl_1279;
assign Tpl_1278 = Tpl_1109;
assign Tpl_1277 = Tpl_1110[(216 / 8)];
assign Tpl_1112[(216 / 8)] = Tpl_1280;

assign Tpl_1282 = Tpl_1108[231:224];
assign Tpl_1111[231:224] = Tpl_1285;
assign Tpl_1284 = Tpl_1109;
assign Tpl_1283 = Tpl_1110[(224 / 8)];
assign Tpl_1112[(224 / 8)] = Tpl_1286;

assign Tpl_1288 = Tpl_1108[239:232];
assign Tpl_1111[239:232] = Tpl_1291;
assign Tpl_1290 = Tpl_1109;
assign Tpl_1289 = Tpl_1110[(232 / 8)];
assign Tpl_1112[(232 / 8)] = Tpl_1292;

assign Tpl_1294 = Tpl_1108[247:240];
assign Tpl_1111[247:240] = Tpl_1297;
assign Tpl_1296 = Tpl_1109;
assign Tpl_1295 = Tpl_1110[(240 / 8)];
assign Tpl_1112[(240 / 8)] = Tpl_1298;

assign Tpl_1300 = Tpl_1108[255:248];
assign Tpl_1111[255:248] = Tpl_1303;
assign Tpl_1302 = Tpl_1109;
assign Tpl_1301 = Tpl_1110[(248 / 8)];
assign Tpl_1112[(248 / 8)] = Tpl_1304;
assign Tpl_1119 = (((Tpl_1114[7] + Tpl_1114[6]) + (Tpl_1114[5] + Tpl_1114[4])) + ((Tpl_1114[3] + Tpl_1114[2]) + (Tpl_1114[1] + Tpl_1114[0])));

function  [3:0] count_zero_bits_94;
input  [7:0] vector ;
integer   i ;
count_zero_bits_94 = 4'h0;
begin

for (i = 0 ;((i) < (8)) ;i = (i + 1))
count_zero_bits_94 = (count_zero_bits_94 + {{3'b000 , (!vector[i])}});

end
endfunction

assign Tpl_1118 = (Tpl_1116 ? ((Tpl_1119 > 4'h4) & (~Tpl_1115)) : (!(count_zero_bits_94(Tpl_1114) > 4'b0100)));
assign Tpl_1117 = (Tpl_1116 ? ((Tpl_1119 > 4'h4) ? ((~Tpl_1114) | ({{(8){{Tpl_1115}}}})) : (Tpl_1114 | ({{(8){{Tpl_1115}}}}))) : ((count_zero_bits_94(Tpl_1114) > 4'b0100) ? (~Tpl_1114) : Tpl_1114));
assign Tpl_1125 = (((Tpl_1120[7] + Tpl_1120[6]) + (Tpl_1120[5] + Tpl_1120[4])) + ((Tpl_1120[3] + Tpl_1120[2]) + (Tpl_1120[1] + Tpl_1120[0])));
assign Tpl_1124 = (Tpl_1122 ? ((Tpl_1125 > 4'h4) & (~Tpl_1121)) : (!(count_zero_bits_94(Tpl_1120) > 4'b0100)));
assign Tpl_1123 = (Tpl_1122 ? ((Tpl_1125 > 4'h4) ? ((~Tpl_1120) | ({{(8){{Tpl_1121}}}})) : (Tpl_1120 | ({{(8){{Tpl_1121}}}}))) : ((count_zero_bits_94(Tpl_1120) > 4'b0100) ? (~Tpl_1120) : Tpl_1120));
assign Tpl_1131 = (((Tpl_1126[7] + Tpl_1126[6]) + (Tpl_1126[5] + Tpl_1126[4])) + ((Tpl_1126[3] + Tpl_1126[2]) + (Tpl_1126[1] + Tpl_1126[0])));
assign Tpl_1130 = (Tpl_1128 ? ((Tpl_1131 > 4'h4) & (~Tpl_1127)) : (!(count_zero_bits_94(Tpl_1126) > 4'b0100)));
assign Tpl_1129 = (Tpl_1128 ? ((Tpl_1131 > 4'h4) ? ((~Tpl_1126) | ({{(8){{Tpl_1127}}}})) : (Tpl_1126 | ({{(8){{Tpl_1127}}}}))) : ((count_zero_bits_94(Tpl_1126) > 4'b0100) ? (~Tpl_1126) : Tpl_1126));
assign Tpl_1137 = (((Tpl_1132[7] + Tpl_1132[6]) + (Tpl_1132[5] + Tpl_1132[4])) + ((Tpl_1132[3] + Tpl_1132[2]) + (Tpl_1132[1] + Tpl_1132[0])));
assign Tpl_1136 = (Tpl_1134 ? ((Tpl_1137 > 4'h4) & (~Tpl_1133)) : (!(count_zero_bits_94(Tpl_1132) > 4'b0100)));
assign Tpl_1135 = (Tpl_1134 ? ((Tpl_1137 > 4'h4) ? ((~Tpl_1132) | ({{(8){{Tpl_1133}}}})) : (Tpl_1132 | ({{(8){{Tpl_1133}}}}))) : ((count_zero_bits_94(Tpl_1132) > 4'b0100) ? (~Tpl_1132) : Tpl_1132));
assign Tpl_1143 = (((Tpl_1138[7] + Tpl_1138[6]) + (Tpl_1138[5] + Tpl_1138[4])) + ((Tpl_1138[3] + Tpl_1138[2]) + (Tpl_1138[1] + Tpl_1138[0])));
assign Tpl_1142 = (Tpl_1140 ? ((Tpl_1143 > 4'h4) & (~Tpl_1139)) : (!(count_zero_bits_94(Tpl_1138) > 4'b0100)));
assign Tpl_1141 = (Tpl_1140 ? ((Tpl_1143 > 4'h4) ? ((~Tpl_1138) | ({{(8){{Tpl_1139}}}})) : (Tpl_1138 | ({{(8){{Tpl_1139}}}}))) : ((count_zero_bits_94(Tpl_1138) > 4'b0100) ? (~Tpl_1138) : Tpl_1138));
assign Tpl_1149 = (((Tpl_1144[7] + Tpl_1144[6]) + (Tpl_1144[5] + Tpl_1144[4])) + ((Tpl_1144[3] + Tpl_1144[2]) + (Tpl_1144[1] + Tpl_1144[0])));
assign Tpl_1148 = (Tpl_1146 ? ((Tpl_1149 > 4'h4) & (~Tpl_1145)) : (!(count_zero_bits_94(Tpl_1144) > 4'b0100)));
assign Tpl_1147 = (Tpl_1146 ? ((Tpl_1149 > 4'h4) ? ((~Tpl_1144) | ({{(8){{Tpl_1145}}}})) : (Tpl_1144 | ({{(8){{Tpl_1145}}}}))) : ((count_zero_bits_94(Tpl_1144) > 4'b0100) ? (~Tpl_1144) : Tpl_1144));
assign Tpl_1155 = (((Tpl_1150[7] + Tpl_1150[6]) + (Tpl_1150[5] + Tpl_1150[4])) + ((Tpl_1150[3] + Tpl_1150[2]) + (Tpl_1150[1] + Tpl_1150[0])));
assign Tpl_1154 = (Tpl_1152 ? ((Tpl_1155 > 4'h4) & (~Tpl_1151)) : (!(count_zero_bits_94(Tpl_1150) > 4'b0100)));
assign Tpl_1153 = (Tpl_1152 ? ((Tpl_1155 > 4'h4) ? ((~Tpl_1150) | ({{(8){{Tpl_1151}}}})) : (Tpl_1150 | ({{(8){{Tpl_1151}}}}))) : ((count_zero_bits_94(Tpl_1150) > 4'b0100) ? (~Tpl_1150) : Tpl_1150));
assign Tpl_1161 = (((Tpl_1156[7] + Tpl_1156[6]) + (Tpl_1156[5] + Tpl_1156[4])) + ((Tpl_1156[3] + Tpl_1156[2]) + (Tpl_1156[1] + Tpl_1156[0])));
assign Tpl_1160 = (Tpl_1158 ? ((Tpl_1161 > 4'h4) & (~Tpl_1157)) : (!(count_zero_bits_94(Tpl_1156) > 4'b0100)));
assign Tpl_1159 = (Tpl_1158 ? ((Tpl_1161 > 4'h4) ? ((~Tpl_1156) | ({{(8){{Tpl_1157}}}})) : (Tpl_1156 | ({{(8){{Tpl_1157}}}}))) : ((count_zero_bits_94(Tpl_1156) > 4'b0100) ? (~Tpl_1156) : Tpl_1156));
assign Tpl_1167 = (((Tpl_1162[7] + Tpl_1162[6]) + (Tpl_1162[5] + Tpl_1162[4])) + ((Tpl_1162[3] + Tpl_1162[2]) + (Tpl_1162[1] + Tpl_1162[0])));
assign Tpl_1166 = (Tpl_1164 ? ((Tpl_1167 > 4'h4) & (~Tpl_1163)) : (!(count_zero_bits_94(Tpl_1162) > 4'b0100)));
assign Tpl_1165 = (Tpl_1164 ? ((Tpl_1167 > 4'h4) ? ((~Tpl_1162) | ({{(8){{Tpl_1163}}}})) : (Tpl_1162 | ({{(8){{Tpl_1163}}}}))) : ((count_zero_bits_94(Tpl_1162) > 4'b0100) ? (~Tpl_1162) : Tpl_1162));
assign Tpl_1173 = (((Tpl_1168[7] + Tpl_1168[6]) + (Tpl_1168[5] + Tpl_1168[4])) + ((Tpl_1168[3] + Tpl_1168[2]) + (Tpl_1168[1] + Tpl_1168[0])));
assign Tpl_1172 = (Tpl_1170 ? ((Tpl_1173 > 4'h4) & (~Tpl_1169)) : (!(count_zero_bits_94(Tpl_1168) > 4'b0100)));
assign Tpl_1171 = (Tpl_1170 ? ((Tpl_1173 > 4'h4) ? ((~Tpl_1168) | ({{(8){{Tpl_1169}}}})) : (Tpl_1168 | ({{(8){{Tpl_1169}}}}))) : ((count_zero_bits_94(Tpl_1168) > 4'b0100) ? (~Tpl_1168) : Tpl_1168));
assign Tpl_1179 = (((Tpl_1174[7] + Tpl_1174[6]) + (Tpl_1174[5] + Tpl_1174[4])) + ((Tpl_1174[3] + Tpl_1174[2]) + (Tpl_1174[1] + Tpl_1174[0])));
assign Tpl_1178 = (Tpl_1176 ? ((Tpl_1179 > 4'h4) & (~Tpl_1175)) : (!(count_zero_bits_94(Tpl_1174) > 4'b0100)));
assign Tpl_1177 = (Tpl_1176 ? ((Tpl_1179 > 4'h4) ? ((~Tpl_1174) | ({{(8){{Tpl_1175}}}})) : (Tpl_1174 | ({{(8){{Tpl_1175}}}}))) : ((count_zero_bits_94(Tpl_1174) > 4'b0100) ? (~Tpl_1174) : Tpl_1174));
assign Tpl_1185 = (((Tpl_1180[7] + Tpl_1180[6]) + (Tpl_1180[5] + Tpl_1180[4])) + ((Tpl_1180[3] + Tpl_1180[2]) + (Tpl_1180[1] + Tpl_1180[0])));
assign Tpl_1184 = (Tpl_1182 ? ((Tpl_1185 > 4'h4) & (~Tpl_1181)) : (!(count_zero_bits_94(Tpl_1180) > 4'b0100)));
assign Tpl_1183 = (Tpl_1182 ? ((Tpl_1185 > 4'h4) ? ((~Tpl_1180) | ({{(8){{Tpl_1181}}}})) : (Tpl_1180 | ({{(8){{Tpl_1181}}}}))) : ((count_zero_bits_94(Tpl_1180) > 4'b0100) ? (~Tpl_1180) : Tpl_1180));
assign Tpl_1191 = (((Tpl_1186[7] + Tpl_1186[6]) + (Tpl_1186[5] + Tpl_1186[4])) + ((Tpl_1186[3] + Tpl_1186[2]) + (Tpl_1186[1] + Tpl_1186[0])));
assign Tpl_1190 = (Tpl_1188 ? ((Tpl_1191 > 4'h4) & (~Tpl_1187)) : (!(count_zero_bits_94(Tpl_1186) > 4'b0100)));
assign Tpl_1189 = (Tpl_1188 ? ((Tpl_1191 > 4'h4) ? ((~Tpl_1186) | ({{(8){{Tpl_1187}}}})) : (Tpl_1186 | ({{(8){{Tpl_1187}}}}))) : ((count_zero_bits_94(Tpl_1186) > 4'b0100) ? (~Tpl_1186) : Tpl_1186));
assign Tpl_1197 = (((Tpl_1192[7] + Tpl_1192[6]) + (Tpl_1192[5] + Tpl_1192[4])) + ((Tpl_1192[3] + Tpl_1192[2]) + (Tpl_1192[1] + Tpl_1192[0])));
assign Tpl_1196 = (Tpl_1194 ? ((Tpl_1197 > 4'h4) & (~Tpl_1193)) : (!(count_zero_bits_94(Tpl_1192) > 4'b0100)));
assign Tpl_1195 = (Tpl_1194 ? ((Tpl_1197 > 4'h4) ? ((~Tpl_1192) | ({{(8){{Tpl_1193}}}})) : (Tpl_1192 | ({{(8){{Tpl_1193}}}}))) : ((count_zero_bits_94(Tpl_1192) > 4'b0100) ? (~Tpl_1192) : Tpl_1192));
assign Tpl_1203 = (((Tpl_1198[7] + Tpl_1198[6]) + (Tpl_1198[5] + Tpl_1198[4])) + ((Tpl_1198[3] + Tpl_1198[2]) + (Tpl_1198[1] + Tpl_1198[0])));
assign Tpl_1202 = (Tpl_1200 ? ((Tpl_1203 > 4'h4) & (~Tpl_1199)) : (!(count_zero_bits_94(Tpl_1198) > 4'b0100)));
assign Tpl_1201 = (Tpl_1200 ? ((Tpl_1203 > 4'h4) ? ((~Tpl_1198) | ({{(8){{Tpl_1199}}}})) : (Tpl_1198 | ({{(8){{Tpl_1199}}}}))) : ((count_zero_bits_94(Tpl_1198) > 4'b0100) ? (~Tpl_1198) : Tpl_1198));
assign Tpl_1209 = (((Tpl_1204[7] + Tpl_1204[6]) + (Tpl_1204[5] + Tpl_1204[4])) + ((Tpl_1204[3] + Tpl_1204[2]) + (Tpl_1204[1] + Tpl_1204[0])));
assign Tpl_1208 = (Tpl_1206 ? ((Tpl_1209 > 4'h4) & (~Tpl_1205)) : (!(count_zero_bits_94(Tpl_1204) > 4'b0100)));
assign Tpl_1207 = (Tpl_1206 ? ((Tpl_1209 > 4'h4) ? ((~Tpl_1204) | ({{(8){{Tpl_1205}}}})) : (Tpl_1204 | ({{(8){{Tpl_1205}}}}))) : ((count_zero_bits_94(Tpl_1204) > 4'b0100) ? (~Tpl_1204) : Tpl_1204));
assign Tpl_1215 = (((Tpl_1210[7] + Tpl_1210[6]) + (Tpl_1210[5] + Tpl_1210[4])) + ((Tpl_1210[3] + Tpl_1210[2]) + (Tpl_1210[1] + Tpl_1210[0])));
assign Tpl_1214 = (Tpl_1212 ? ((Tpl_1215 > 4'h4) & (~Tpl_1211)) : (!(count_zero_bits_94(Tpl_1210) > 4'b0100)));
assign Tpl_1213 = (Tpl_1212 ? ((Tpl_1215 > 4'h4) ? ((~Tpl_1210) | ({{(8){{Tpl_1211}}}})) : (Tpl_1210 | ({{(8){{Tpl_1211}}}}))) : ((count_zero_bits_94(Tpl_1210) > 4'b0100) ? (~Tpl_1210) : Tpl_1210));
assign Tpl_1221 = (((Tpl_1216[7] + Tpl_1216[6]) + (Tpl_1216[5] + Tpl_1216[4])) + ((Tpl_1216[3] + Tpl_1216[2]) + (Tpl_1216[1] + Tpl_1216[0])));
assign Tpl_1220 = (Tpl_1218 ? ((Tpl_1221 > 4'h4) & (~Tpl_1217)) : (!(count_zero_bits_94(Tpl_1216) > 4'b0100)));
assign Tpl_1219 = (Tpl_1218 ? ((Tpl_1221 > 4'h4) ? ((~Tpl_1216) | ({{(8){{Tpl_1217}}}})) : (Tpl_1216 | ({{(8){{Tpl_1217}}}}))) : ((count_zero_bits_94(Tpl_1216) > 4'b0100) ? (~Tpl_1216) : Tpl_1216));
assign Tpl_1227 = (((Tpl_1222[7] + Tpl_1222[6]) + (Tpl_1222[5] + Tpl_1222[4])) + ((Tpl_1222[3] + Tpl_1222[2]) + (Tpl_1222[1] + Tpl_1222[0])));
assign Tpl_1226 = (Tpl_1224 ? ((Tpl_1227 > 4'h4) & (~Tpl_1223)) : (!(count_zero_bits_94(Tpl_1222) > 4'b0100)));
assign Tpl_1225 = (Tpl_1224 ? ((Tpl_1227 > 4'h4) ? ((~Tpl_1222) | ({{(8){{Tpl_1223}}}})) : (Tpl_1222 | ({{(8){{Tpl_1223}}}}))) : ((count_zero_bits_94(Tpl_1222) > 4'b0100) ? (~Tpl_1222) : Tpl_1222));
assign Tpl_1233 = (((Tpl_1228[7] + Tpl_1228[6]) + (Tpl_1228[5] + Tpl_1228[4])) + ((Tpl_1228[3] + Tpl_1228[2]) + (Tpl_1228[1] + Tpl_1228[0])));
assign Tpl_1232 = (Tpl_1230 ? ((Tpl_1233 > 4'h4) & (~Tpl_1229)) : (!(count_zero_bits_94(Tpl_1228) > 4'b0100)));
assign Tpl_1231 = (Tpl_1230 ? ((Tpl_1233 > 4'h4) ? ((~Tpl_1228) | ({{(8){{Tpl_1229}}}})) : (Tpl_1228 | ({{(8){{Tpl_1229}}}}))) : ((count_zero_bits_94(Tpl_1228) > 4'b0100) ? (~Tpl_1228) : Tpl_1228));
assign Tpl_1239 = (((Tpl_1234[7] + Tpl_1234[6]) + (Tpl_1234[5] + Tpl_1234[4])) + ((Tpl_1234[3] + Tpl_1234[2]) + (Tpl_1234[1] + Tpl_1234[0])));
assign Tpl_1238 = (Tpl_1236 ? ((Tpl_1239 > 4'h4) & (~Tpl_1235)) : (!(count_zero_bits_94(Tpl_1234) > 4'b0100)));
assign Tpl_1237 = (Tpl_1236 ? ((Tpl_1239 > 4'h4) ? ((~Tpl_1234) | ({{(8){{Tpl_1235}}}})) : (Tpl_1234 | ({{(8){{Tpl_1235}}}}))) : ((count_zero_bits_94(Tpl_1234) > 4'b0100) ? (~Tpl_1234) : Tpl_1234));
assign Tpl_1245 = (((Tpl_1240[7] + Tpl_1240[6]) + (Tpl_1240[5] + Tpl_1240[4])) + ((Tpl_1240[3] + Tpl_1240[2]) + (Tpl_1240[1] + Tpl_1240[0])));
assign Tpl_1244 = (Tpl_1242 ? ((Tpl_1245 > 4'h4) & (~Tpl_1241)) : (!(count_zero_bits_94(Tpl_1240) > 4'b0100)));
assign Tpl_1243 = (Tpl_1242 ? ((Tpl_1245 > 4'h4) ? ((~Tpl_1240) | ({{(8){{Tpl_1241}}}})) : (Tpl_1240 | ({{(8){{Tpl_1241}}}}))) : ((count_zero_bits_94(Tpl_1240) > 4'b0100) ? (~Tpl_1240) : Tpl_1240));
assign Tpl_1251 = (((Tpl_1246[7] + Tpl_1246[6]) + (Tpl_1246[5] + Tpl_1246[4])) + ((Tpl_1246[3] + Tpl_1246[2]) + (Tpl_1246[1] + Tpl_1246[0])));
assign Tpl_1250 = (Tpl_1248 ? ((Tpl_1251 > 4'h4) & (~Tpl_1247)) : (!(count_zero_bits_94(Tpl_1246) > 4'b0100)));
assign Tpl_1249 = (Tpl_1248 ? ((Tpl_1251 > 4'h4) ? ((~Tpl_1246) | ({{(8){{Tpl_1247}}}})) : (Tpl_1246 | ({{(8){{Tpl_1247}}}}))) : ((count_zero_bits_94(Tpl_1246) > 4'b0100) ? (~Tpl_1246) : Tpl_1246));
assign Tpl_1257 = (((Tpl_1252[7] + Tpl_1252[6]) + (Tpl_1252[5] + Tpl_1252[4])) + ((Tpl_1252[3] + Tpl_1252[2]) + (Tpl_1252[1] + Tpl_1252[0])));
assign Tpl_1256 = (Tpl_1254 ? ((Tpl_1257 > 4'h4) & (~Tpl_1253)) : (!(count_zero_bits_94(Tpl_1252) > 4'b0100)));
assign Tpl_1255 = (Tpl_1254 ? ((Tpl_1257 > 4'h4) ? ((~Tpl_1252) | ({{(8){{Tpl_1253}}}})) : (Tpl_1252 | ({{(8){{Tpl_1253}}}}))) : ((count_zero_bits_94(Tpl_1252) > 4'b0100) ? (~Tpl_1252) : Tpl_1252));
assign Tpl_1263 = (((Tpl_1258[7] + Tpl_1258[6]) + (Tpl_1258[5] + Tpl_1258[4])) + ((Tpl_1258[3] + Tpl_1258[2]) + (Tpl_1258[1] + Tpl_1258[0])));
assign Tpl_1262 = (Tpl_1260 ? ((Tpl_1263 > 4'h4) & (~Tpl_1259)) : (!(count_zero_bits_94(Tpl_1258) > 4'b0100)));
assign Tpl_1261 = (Tpl_1260 ? ((Tpl_1263 > 4'h4) ? ((~Tpl_1258) | ({{(8){{Tpl_1259}}}})) : (Tpl_1258 | ({{(8){{Tpl_1259}}}}))) : ((count_zero_bits_94(Tpl_1258) > 4'b0100) ? (~Tpl_1258) : Tpl_1258));
assign Tpl_1269 = (((Tpl_1264[7] + Tpl_1264[6]) + (Tpl_1264[5] + Tpl_1264[4])) + ((Tpl_1264[3] + Tpl_1264[2]) + (Tpl_1264[1] + Tpl_1264[0])));
assign Tpl_1268 = (Tpl_1266 ? ((Tpl_1269 > 4'h4) & (~Tpl_1265)) : (!(count_zero_bits_94(Tpl_1264) > 4'b0100)));
assign Tpl_1267 = (Tpl_1266 ? ((Tpl_1269 > 4'h4) ? ((~Tpl_1264) | ({{(8){{Tpl_1265}}}})) : (Tpl_1264 | ({{(8){{Tpl_1265}}}}))) : ((count_zero_bits_94(Tpl_1264) > 4'b0100) ? (~Tpl_1264) : Tpl_1264));
assign Tpl_1275 = (((Tpl_1270[7] + Tpl_1270[6]) + (Tpl_1270[5] + Tpl_1270[4])) + ((Tpl_1270[3] + Tpl_1270[2]) + (Tpl_1270[1] + Tpl_1270[0])));
assign Tpl_1274 = (Tpl_1272 ? ((Tpl_1275 > 4'h4) & (~Tpl_1271)) : (!(count_zero_bits_94(Tpl_1270) > 4'b0100)));
assign Tpl_1273 = (Tpl_1272 ? ((Tpl_1275 > 4'h4) ? ((~Tpl_1270) | ({{(8){{Tpl_1271}}}})) : (Tpl_1270 | ({{(8){{Tpl_1271}}}}))) : ((count_zero_bits_94(Tpl_1270) > 4'b0100) ? (~Tpl_1270) : Tpl_1270));
assign Tpl_1281 = (((Tpl_1276[7] + Tpl_1276[6]) + (Tpl_1276[5] + Tpl_1276[4])) + ((Tpl_1276[3] + Tpl_1276[2]) + (Tpl_1276[1] + Tpl_1276[0])));
assign Tpl_1280 = (Tpl_1278 ? ((Tpl_1281 > 4'h4) & (~Tpl_1277)) : (!(count_zero_bits_94(Tpl_1276) > 4'b0100)));
assign Tpl_1279 = (Tpl_1278 ? ((Tpl_1281 > 4'h4) ? ((~Tpl_1276) | ({{(8){{Tpl_1277}}}})) : (Tpl_1276 | ({{(8){{Tpl_1277}}}}))) : ((count_zero_bits_94(Tpl_1276) > 4'b0100) ? (~Tpl_1276) : Tpl_1276));
assign Tpl_1287 = (((Tpl_1282[7] + Tpl_1282[6]) + (Tpl_1282[5] + Tpl_1282[4])) + ((Tpl_1282[3] + Tpl_1282[2]) + (Tpl_1282[1] + Tpl_1282[0])));
assign Tpl_1286 = (Tpl_1284 ? ((Tpl_1287 > 4'h4) & (~Tpl_1283)) : (!(count_zero_bits_94(Tpl_1282) > 4'b0100)));
assign Tpl_1285 = (Tpl_1284 ? ((Tpl_1287 > 4'h4) ? ((~Tpl_1282) | ({{(8){{Tpl_1283}}}})) : (Tpl_1282 | ({{(8){{Tpl_1283}}}}))) : ((count_zero_bits_94(Tpl_1282) > 4'b0100) ? (~Tpl_1282) : Tpl_1282));
assign Tpl_1293 = (((Tpl_1288[7] + Tpl_1288[6]) + (Tpl_1288[5] + Tpl_1288[4])) + ((Tpl_1288[3] + Tpl_1288[2]) + (Tpl_1288[1] + Tpl_1288[0])));
assign Tpl_1292 = (Tpl_1290 ? ((Tpl_1293 > 4'h4) & (~Tpl_1289)) : (!(count_zero_bits_94(Tpl_1288) > 4'b0100)));
assign Tpl_1291 = (Tpl_1290 ? ((Tpl_1293 > 4'h4) ? ((~Tpl_1288) | ({{(8){{Tpl_1289}}}})) : (Tpl_1288 | ({{(8){{Tpl_1289}}}}))) : ((count_zero_bits_94(Tpl_1288) > 4'b0100) ? (~Tpl_1288) : Tpl_1288));
assign Tpl_1299 = (((Tpl_1294[7] + Tpl_1294[6]) + (Tpl_1294[5] + Tpl_1294[4])) + ((Tpl_1294[3] + Tpl_1294[2]) + (Tpl_1294[1] + Tpl_1294[0])));
assign Tpl_1298 = (Tpl_1296 ? ((Tpl_1299 > 4'h4) & (~Tpl_1295)) : (!(count_zero_bits_94(Tpl_1294) > 4'b0100)));
assign Tpl_1297 = (Tpl_1296 ? ((Tpl_1299 > 4'h4) ? ((~Tpl_1294) | ({{(8){{Tpl_1295}}}})) : (Tpl_1294 | ({{(8){{Tpl_1295}}}}))) : ((count_zero_bits_94(Tpl_1294) > 4'b0100) ? (~Tpl_1294) : Tpl_1294));
assign Tpl_1305 = (((Tpl_1300[7] + Tpl_1300[6]) + (Tpl_1300[5] + Tpl_1300[4])) + ((Tpl_1300[3] + Tpl_1300[2]) + (Tpl_1300[1] + Tpl_1300[0])));
assign Tpl_1304 = (Tpl_1302 ? ((Tpl_1305 > 4'h4) & (~Tpl_1301)) : (!(count_zero_bits_94(Tpl_1300) > 4'b0100)));
assign Tpl_1303 = (Tpl_1302 ? ((Tpl_1305 > 4'h4) ? ((~Tpl_1300) | ({{(8){{Tpl_1301}}}})) : (Tpl_1300 | ({{(8){{Tpl_1301}}}}))) : ((count_zero_bits_94(Tpl_1300) > 4'b0100) ? (~Tpl_1300) : Tpl_1300));

function integer   ceil_log2_95;
input integer   data ;
integer   i ;
ceil_log2_95 = 1;
begin

for (i = 0 ;(((2 ** i)) < (data)) ;i = (i + 1))
ceil_log2_95 = (i + 1);

end
endfunction


function integer   last_one_96;
input integer   data ;
input integer   end_bit ;
integer   i ;
last_one_96 = 0;
begin

for (i = 0 ;((i) <= (end_bit)) ;i = (i + 1))
begin
if ((|(((data >> i)) % (2))))
last_one_96 = (i + 1);
end

end
endfunction


function integer   floor_log2_97;
input integer   value_int_i ;
integer   ceil_log2 ;
begin

for (ceil_log2 = 0 ;(((1 << ceil_log2)) < (value_int_i)) ;ceil_log2 = (ceil_log2 + 1))
floor_log2_97 = ceil_log2;

end
if (((1 << ceil_log2) == value_int_i))
floor_log2_97 = ceil_log2;
else
floor_log2_97 = (ceil_log2 - 1);
endfunction


function integer   is_onethot_98;
input integer   N ;
integer   i ;
is_onethot_98 = 0;
begin

for (i = 0 ;((i) < (N)) ;i = (i + 1))
begin
if ((N == (2 ** i)))
begin
is_onethot_98 = 1;
end
end

end
endfunction


function integer   ecc_width_99;
input integer   data_width ;
integer   i ;
ecc_width_99 = 0;
begin

for (i = 0 ;((i) <= (data_width)) ;i = (i + 1))
begin
if ((|is_onethot_98(i)))
begin
ecc_width_99 = (ecc_width_99 + 1);
end
end

end
endfunction

assign Tpl_1313 = Tpl_1307;
assign Tpl_1311 = Tpl_1309;
assign Tpl_1312 = (Tpl_1308 ? (Tpl_1306 ? Tpl_1310 : (~Tpl_1310)) : (Tpl_1306 ? 0 : ({{(32){{1'b1}}}})));
assign Tpl_1315 = (^Tpl_1314);

endmodule