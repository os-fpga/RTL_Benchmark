/*
 * Fontmap ROM
 *
 * This is the ROM containing the map for a monospaced 8x8 font.
 * The address input is the concatenation of the required ASCII code [10:3] and the
 * number of the line [2:0] contained into the char (starting from the top).
 * It should use only one 2KByte Block RAM on a Xilinx FPGA device.
 * The font design is (C) 2005 by Brian Cassidy and released under the Perl license.
 * All the rest is (C) 2008 by Fabrizio Fazzino and released under the GPL license.
 */

// synthesis attribute rom_style of fontmap_rom is block;
module fontmap_rom (
    input sys_clock_i,
    input read_i,
    input[10:0] address_i,
    output reg[7:0] data_o
  );

  always @(posedge sys_clock_i) begin
    if(read_i) begin
      case(address_i)

        // ASCII 0
        0 : data_o <= 8'h00;
        1 : data_o <= 8'h00;
        2 : data_o <= 8'h00;
        3 : data_o <= 8'h00;
        4 : data_o <= 8'h00;
        5 : data_o <= 8'h00;
        6 : data_o <= 8'h00;
        7 : data_o <= 8'h00;

        // ASCII 1
        8 : data_o <= 8'h7e;
        9 : data_o <= 8'h81;
        10 : data_o <= 8'ha5;
        11 : data_o <= 8'h81;
        12 : data_o <= 8'hbd;
        13 : data_o <= 8'h99;
        14 : data_o <= 8'h81;
        15 : data_o <= 8'h7e;

        // ASCII 2
        16 : data_o <= 8'h7e;
        17 : data_o <= 8'hff;
        18 : data_o <= 8'hdb;
        19 : data_o <= 8'hff;
        20 : data_o <= 8'hc3;
        21 : data_o <= 8'he7;
        22 : data_o <= 8'hff;
        23 : data_o <= 8'h7e;

        // ASCII 3
        24 : data_o <= 8'h6c;
        25 : data_o <= 8'hfe;
        26 : data_o <= 8'hfe;
        27 : data_o <= 8'hfe;
        28 : data_o <= 8'h7c;
        29 : data_o <= 8'h38;
        30 : data_o <= 8'h10;
        31 : data_o <= 8'h00;

        // ASCII 4
        32 : data_o <= 8'h10;
        33 : data_o <= 8'h38;
        34 : data_o <= 8'h7c;
        35 : data_o <= 8'hfe;
        36 : data_o <= 8'h7c;
        37 : data_o <= 8'h38;
        38 : data_o <= 8'h10;
        39 : data_o <= 8'h00;

        // ASCII 5
        40 : data_o <= 8'h38;
        41 : data_o <= 8'h7c;
        42 : data_o <= 8'h38;
        43 : data_o <= 8'hfe;
        44 : data_o <= 8'hfe;
        45 : data_o <= 8'hd6;
        46 : data_o <= 8'h10;
        47 : data_o <= 8'h38;

        // ASCII 6
        48 : data_o <= 8'h10;
        49 : data_o <= 8'h38;
        50 : data_o <= 8'h7c;
        51 : data_o <= 8'hfe;
        52 : data_o <= 8'hfe;
        53 : data_o <= 8'h7c;
        54 : data_o <= 8'h10;
        55 : data_o <= 8'h38;

        // ASCII 7
        56 : data_o <= 8'h00;
        57 : data_o <= 8'h00;
        58 : data_o <= 8'h18;
        59 : data_o <= 8'h3c;
        60 : data_o <= 8'h3c;
        61 : data_o <= 8'h18;
        62 : data_o <= 8'h00;
        63 : data_o <= 8'h00;

        // ASCII 8
        64 : data_o <= 8'hff;
        65 : data_o <= 8'hff;
        66 : data_o <= 8'he7;
        67 : data_o <= 8'hc3;
        68 : data_o <= 8'hc3;
        69 : data_o <= 8'he7;
        70 : data_o <= 8'hff;
        71 : data_o <= 8'hff;

        // ASCII 9
        72 : data_o <= 8'h00;
        73 : data_o <= 8'h3c;
        74 : data_o <= 8'h66;
        75 : data_o <= 8'h42;
        76 : data_o <= 8'h42;
        77 : data_o <= 8'h66;
        78 : data_o <= 8'h3c;
        79 : data_o <= 8'h00;

        // ASCII 10
/*
        80 : data_o <= 8'hff;
        81 : data_o <= 8'hc3;
        82 : data_o <= 8'h99;
        83 : data_o <= 8'hbd;
        84 : data_o <= 8'hbd;
        85 : data_o <= 8'h99;
        86 : data_o <= 8'hc3;
        87 : data_o <= 8'hff;
*/
        80 : data_o <= 8'h00;
        81 : data_o <= 8'h00;
        82 : data_o <= 8'h00;
        83 : data_o <= 8'h00;
        84 : data_o <= 8'h00;
        85 : data_o <= 8'h00;
        86 : data_o <= 8'h00;
        87 : data_o <= 8'h00;

        // ASCII 11
        88 : data_o <= 8'h0f;
        89 : data_o <= 8'h07;
        90 : data_o <= 8'h0f;
        91 : data_o <= 8'h7d;
        92 : data_o <= 8'hcc;
        93 : data_o <= 8'hcc;
        94 : data_o <= 8'hcc;
        95 : data_o <= 8'h78;

        // ASCII 12
        96 : data_o <= 8'h3c;
        97 : data_o <= 8'h66;
        98 : data_o <= 8'h66;
        99 : data_o <= 8'h66;
        100 : data_o <= 8'h3c;
        101 : data_o <= 8'h18;
        102 : data_o <= 8'h7e;
        103 : data_o <= 8'h18;

        // ASCII 13
        104 : data_o <= 8'h3f;
        105 : data_o <= 8'h33;
        106 : data_o <= 8'h3f;
        107 : data_o <= 8'h30;
        108 : data_o <= 8'h30;
        109 : data_o <= 8'h70;
        110 : data_o <= 8'hf0;
        111 : data_o <= 8'he0;

        // ASCII 14
        112 : data_o <= 8'h7f;
        113 : data_o <= 8'h63;
        114 : data_o <= 8'h7f;
        115 : data_o <= 8'h63;
        116 : data_o <= 8'h63;
        117 : data_o <= 8'h67;
        118 : data_o <= 8'he6;
        119 : data_o <= 8'hc0;

        // ASCII 15
        120 : data_o <= 8'h18;
        121 : data_o <= 8'hdb;
        122 : data_o <= 8'h3c;
        123 : data_o <= 8'he7;
        124 : data_o <= 8'he7;
        125 : data_o <= 8'h3c;
        126 : data_o <= 8'hdb;
        127 : data_o <= 8'h18;

        // ASCII 16
        128 : data_o <= 8'h80;
        129 : data_o <= 8'he0;
        130 : data_o <= 8'hf8;
        131 : data_o <= 8'hfe;
        132 : data_o <= 8'hf8;
        133 : data_o <= 8'he0;
        134 : data_o <= 8'h80;
        135 : data_o <= 8'h00;

        // ASCII 17
        136 : data_o <= 8'h02;
        137 : data_o <= 8'h0e;
        138 : data_o <= 8'h3e;
        139 : data_o <= 8'hfe;
        140 : data_o <= 8'h3e;
        141 : data_o <= 8'h0e;
        142 : data_o <= 8'h02;
        143 : data_o <= 8'h00;

        // ASCII 18
        144 : data_o <= 8'h18;
        145 : data_o <= 8'h3c;
        146 : data_o <= 8'h7e;
        147 : data_o <= 8'h18;
        148 : data_o <= 8'h18;
        149 : data_o <= 8'h7e;
        150 : data_o <= 8'h3c;
        151 : data_o <= 8'h18;

        // ASCII 19
        152 : data_o <= 8'h66;
        153 : data_o <= 8'h66;
        154 : data_o <= 8'h66;
        155 : data_o <= 8'h66;
        156 : data_o <= 8'h66;
        157 : data_o <= 8'h00;
        158 : data_o <= 8'h66;
        159 : data_o <= 8'h00;

        // ASCII 20
        160 : data_o <= 8'h7f;
        161 : data_o <= 8'hdb;
        162 : data_o <= 8'hdb;
        163 : data_o <= 8'h7b;
        164 : data_o <= 8'h1b;
        165 : data_o <= 8'h1b;
        166 : data_o <= 8'h1b;
        167 : data_o <= 8'h00;

        // ASCII 21
        168 : data_o <= 8'h3e;
        169 : data_o <= 8'h61;
        170 : data_o <= 8'h3c;
        171 : data_o <= 8'h66;
        172 : data_o <= 8'h66;
        173 : data_o <= 8'h3c;
        174 : data_o <= 8'h86;
        175 : data_o <= 8'h7c;

        // ASCII 22
        176 : data_o <= 8'h00;
        177 : data_o <= 8'h00;
        178 : data_o <= 8'h00;
        179 : data_o <= 8'h00;
        180 : data_o <= 8'h7e;
        181 : data_o <= 8'h7e;
        182 : data_o <= 8'h7e;
        183 : data_o <= 8'h00;

        // ASCII 23
        184 : data_o <= 8'h18;
        185 : data_o <= 8'h3c;
        186 : data_o <= 8'h7e;
        187 : data_o <= 8'h18;
        188 : data_o <= 8'h7e;
        189 : data_o <= 8'h3c;
        190 : data_o <= 8'h18;
        191 : data_o <= 8'hff;

        // ASCII 24
        192 : data_o <= 8'h18;
        193 : data_o <= 8'h3c;
        194 : data_o <= 8'h7e;
        195 : data_o <= 8'h18;
        196 : data_o <= 8'h18;
        197 : data_o <= 8'h18;
        198 : data_o <= 8'h18;
        199 : data_o <= 8'h00;

        // ASCII 25
        200 : data_o <= 8'h18;
        201 : data_o <= 8'h18;
        202 : data_o <= 8'h18;
        203 : data_o <= 8'h18;
        204 : data_o <= 8'h7e;
        205 : data_o <= 8'h3c;
        206 : data_o <= 8'h18;
        207 : data_o <= 8'h00;

        // ASCII 26
        208 : data_o <= 8'h00;
        209 : data_o <= 8'h18;
        210 : data_o <= 8'h0c;
        211 : data_o <= 8'hfe;
        212 : data_o <= 8'h0c;
        213 : data_o <= 8'h18;
        214 : data_o <= 8'h00;
        215 : data_o <= 8'h00;

        // ASCII 27
	216 : data_o <= 8'h00;
        217 : data_o <= 8'h30;
        218 : data_o <= 8'h60;
        219 : data_o <= 8'hfe;
        220 : data_o <= 8'h60;
        221 : data_o <= 8'h30;
        222 : data_o <= 8'h00;
        223 : data_o <= 8'h00;

        // ASCII 28
        224 : data_o <= 8'h00;
        225 : data_o <= 8'h00;
        226 : data_o <= 8'hc0;
        227 : data_o <= 8'hc0;
        228 : data_o <= 8'hc0;
        229 : data_o <= 8'hfe;
        230 : data_o <= 8'h00;
        231 : data_o <= 8'h00;

        // ASCII 29
        232 : data_o <= 8'h00;
        233 : data_o <= 8'h24;
        234 : data_o <= 8'h66;
        235 : data_o <= 8'hff;
        236 : data_o <= 8'h66;
        237 : data_o <= 8'h24;
        238 : data_o <= 8'h00;
        239 : data_o <= 8'h00;

        // ASCII 30
        240 : data_o <= 8'h00;
        241 : data_o <= 8'h18;
        242 : data_o <= 8'h3c;
        243 : data_o <= 8'h7e;
        244 : data_o <= 8'hff;
        245 : data_o <= 8'hff;
        246 : data_o <= 8'h00;
        247 : data_o <= 8'h00;

        // ASCII 31
        248 : data_o <= 8'h00;
        249 : data_o <= 8'hff;
        250 : data_o <= 8'hff;
        251 : data_o <= 8'h7e;
        252 : data_o <= 8'h3c;
        253 : data_o <= 8'h18;
        254 : data_o <= 8'h00;
        255 : data_o <= 8'h00;

        // ASCII 32
        256 : data_o <= 8'h00;
        257 : data_o <= 8'h00;
        258 : data_o <= 8'h00;
        259 : data_o <= 8'h00;
        260 : data_o <= 8'h00;
        261 : data_o <= 8'h00;
        262 : data_o <= 8'h00;
        263 : data_o <= 8'h00;

        // ASCII 33
        264 : data_o <= 8'h18;
        265 : data_o <= 8'h3c;
        266 : data_o <= 8'h3c;
        267 : data_o <= 8'h18;
        268 : data_o <= 8'h18;
        269 : data_o <= 8'h00;
        270 : data_o <= 8'h18;
        271 : data_o <= 8'h00;

        // ASCII 34
        272 : data_o <= 8'h66;
        273 : data_o <= 8'h66;
        274 : data_o <= 8'h24;
        275 : data_o <= 8'h00;
        276 : data_o <= 8'h00;
        277 : data_o <= 8'h00;
        278 : data_o <= 8'h00;
        279 : data_o <= 8'h00;

        // ASCII 35
        280 : data_o <= 8'h6c;
        281 : data_o <= 8'h6c;
        282 : data_o <= 8'hfe;
        283 : data_o <= 8'h6c;
        284 : data_o <= 8'hfe;
        285 : data_o <= 8'h6c;
        286 : data_o <= 8'h6c;
        287 : data_o <= 8'h00;

        // ASCII 36
        288 : data_o <= 8'h18;
        289 : data_o <= 8'h3e;
        290 : data_o <= 8'h60;
        291 : data_o <= 8'h3c;
        292 : data_o <= 8'h06;
        293 : data_o <= 8'h7c;
        294 : data_o <= 8'h18;
        295 : data_o <= 8'h00;

        // ASCII 37
	296 : data_o <= 8'h00;
        297 : data_o <= 8'hc6;
        298 : data_o <= 8'hcc;
        299 : data_o <= 8'h18;
        300 : data_o <= 8'h30;
        301 : data_o <= 8'h66;
        302 : data_o <= 8'hc6;
        303 : data_o <= 8'h00;

        // ASCII 38
	304 : data_o <= 8'h38;
        305 : data_o <= 8'h6c;
        306 : data_o <= 8'h38;
        307 : data_o <= 8'h76;
        308 : data_o <= 8'hdc;
        309 : data_o <= 8'hcc;
        310 : data_o <= 8'h76;
        311 : data_o <= 8'h00;

        // ASCII 39
	312 : data_o <= 8'h18;
        313 : data_o <= 8'h18;
        314 : data_o <= 8'h30;
        315 : data_o <= 8'h00;
        316 : data_o <= 8'h00;
        317 : data_o <= 8'h00;
        318 : data_o <= 8'h00;
        319 : data_o <= 8'h00;

        // ASCII 40
        320 : data_o <= 8'h0c;
        321 : data_o <= 8'h18;
        322 : data_o <= 8'h30;
        323 : data_o <= 8'h30;
        324 : data_o <= 8'h30;
        325 : data_o <= 8'h18;
        326 : data_o <= 8'h0c;
        327 : data_o <= 8'h00;

        // ASCII 41
        328 : data_o <= 8'h30;
        329 : data_o <= 8'h18;
        330 : data_o <= 8'h0c;
        331 : data_o <= 8'h0c;
        332 : data_o <= 8'h0c;
        333 : data_o <= 8'h18;
        334 : data_o <= 8'h30;
        335 : data_o <= 8'h00;

        // ASCII 42
        336 : data_o <= 8'h00;
        337 : data_o <= 8'h66;
        338 : data_o <= 8'h3c;
        339 : data_o <= 8'hff;
        340 : data_o <= 8'h3c;
        341 : data_o <= 8'h66;
        342 : data_o <= 8'h00;
        343 : data_o <= 8'h00;

        // ASCII 43
        344 : data_o <= 8'h00;
        345 : data_o <= 8'h18;
        346 : data_o <= 8'h18;
        347 : data_o <= 8'h7e;
        348 : data_o <= 8'h18;
        349 : data_o <= 8'h18;
        350 : data_o <= 8'h00;
        351 : data_o <= 8'h00;

        // ASCII 44
        352 : data_o <= 8'h00;
        353 : data_o <= 8'h00;
        354 : data_o <= 8'h00;
        355 : data_o <= 8'h00;
        356 : data_o <= 8'h00;
        357 : data_o <= 8'h18;
        358 : data_o <= 8'h18;
        359 : data_o <= 8'h30;

        // ASCII 45
        360 : data_o <= 8'h00;
        361 : data_o <= 8'h00;
        362 : data_o <= 8'h00;
        363 : data_o <= 8'h7e;
        364 : data_o <= 8'h00;
        365 : data_o <= 8'h00;
        366 : data_o <= 8'h00;
        367 : data_o <= 8'h00;

        // ASCII 46
        368 : data_o <= 8'h00;
        369 : data_o <= 8'h00;
        370 : data_o <= 8'h00;
        371 : data_o <= 8'h00;
        372 : data_o <= 8'h00;
        373 : data_o <= 8'h18;
        374 : data_o <= 8'h18;
        375 : data_o <= 8'h00;

        // ASCII 47
        376 : data_o <= 8'h06;
        377 : data_o <= 8'h0c;
        378 : data_o <= 8'h18;
        379 : data_o <= 8'h30;
        380 : data_o <= 8'h60;
        381 : data_o <= 8'hc0;
        382 : data_o <= 8'h80;
        383 : data_o <= 8'h00;

        // ASCII 48
        384 : data_o <= 8'h38;
        385 : data_o <= 8'h6c;
        386 : data_o <= 8'hc6;
        387 : data_o <= 8'hd6;
        388 : data_o <= 8'hc6;
        389 : data_o <= 8'h6c;
        390 : data_o <= 8'h38;
        391 : data_o <= 8'h00;

        // ASCII 49
        392 : data_o <= 8'h18;
        393 : data_o <= 8'h38;
        394 : data_o <= 8'h18;
        395 : data_o <= 8'h18;
        396 : data_o <= 8'h18;
        397 : data_o <= 8'h18;
        398 : data_o <= 8'h7e;
        399 : data_o <= 8'h00;

        // ASCII 50
        400 : data_o <= 8'h7c;
        401 : data_o <= 8'hc6;
        402 : data_o <= 8'h06;
        403 : data_o <= 8'h1c;
        404 : data_o <= 8'h30;
        405 : data_o <= 8'h66;
        406 : data_o <= 8'hfe;
        407 : data_o <= 8'h00;

        // ASCII 51
        408 : data_o <= 8'h7c;
        409 : data_o <= 8'hc6;
        410 : data_o <= 8'h06;
        411 : data_o <= 8'h3c;
        412 : data_o <= 8'h06;
        413 : data_o <= 8'hc6;
        414 : data_o <= 8'h7c;
        415 : data_o <= 8'h00;

        // ASCII 52
        416 : data_o <= 8'h1c;
        417 : data_o <= 8'h3c;
        418 : data_o <= 8'h6c;
        419 : data_o <= 8'hcc;
        420 : data_o <= 8'hfe;
        421 : data_o <= 8'h0c;
        422 : data_o <= 8'h1e;
        423 : data_o <= 8'h00;

        // ASCII 53
        424 : data_o <= 8'hfe;
        425 : data_o <= 8'hc0;
        426 : data_o <= 8'hc0;
        427 : data_o <= 8'hfc;
        428 : data_o <= 8'h06;
        429 : data_o <= 8'hc6;
        430 : data_o <= 8'h7c;
        431 : data_o <= 8'h00;

        // ASCII 54
        432 : data_o <= 8'h38;
        433 : data_o <= 8'h60;
        434 : data_o <= 8'hc0;
        435 : data_o <= 8'hfc;
        436 : data_o <= 8'hc6;
        437 : data_o <= 8'hc6;
        438 : data_o <= 8'h7c;
        439 : data_o <= 8'h00;

        // ASCII 55
        440 : data_o <= 8'hfe;
        441 : data_o <= 8'hc6;
        442 : data_o <= 8'h0c;
        443 : data_o <= 8'h18;
        444 : data_o <= 8'h30;
        445 : data_o <= 8'h30;
        446 : data_o <= 8'h30;
        447 : data_o <= 8'h00;

        // ASCII 56
        448 : data_o <= 8'h7c;
        449 : data_o <= 8'hc6;
        450 : data_o <= 8'hc6;
        451 : data_o <= 8'h7c;
        452 : data_o <= 8'hc6;
        453 : data_o <= 8'hc6;
        454 : data_o <= 8'h7c;
        455 : data_o <= 8'h00;

        // ASCII 57
        456 : data_o <= 8'h7c;
        457 : data_o <= 8'hc6;
        458 : data_o <= 8'hc6;
        459 : data_o <= 8'h7e;
        460 : data_o <= 8'h06;
        461 : data_o <= 8'h0c;
        462 : data_o <= 8'h78;
        463 : data_o <= 8'h00;

        // ASCII 58
        464 : data_o <= 8'h00;
        465 : data_o <= 8'h18;
        466 : data_o <= 8'h18;
        467 : data_o <= 8'h00;
        468 : data_o <= 8'h00;
        469 : data_o <= 8'h18;
        470 : data_o <= 8'h18;
        471 : data_o <= 8'h00;

        // ASCII 59
        472 : data_o <= 8'h00;
        473 : data_o <= 8'h18;
        474 : data_o <= 8'h18;
        475 : data_o <= 8'h00;
        476 : data_o <= 8'h00;
        477 : data_o <= 8'h18;
        478 : data_o <= 8'h18;
        479 : data_o <= 8'h30;

        // ASCII 60
        480 : data_o <= 8'h06;
        481 : data_o <= 8'h0c;
        482 : data_o <= 8'h18;
        483 : data_o <= 8'h30;
        484 : data_o <= 8'h18;
        485 : data_o <= 8'h0c;
        486 : data_o <= 8'h06;
        487 : data_o <= 8'h00;

        // ASCII 61
        488 : data_o <= 8'h00;
        489 : data_o <= 8'h00;
        490 : data_o <= 8'h7e;
        491 : data_o <= 8'h00;
        492 : data_o <= 8'h00;
        493 : data_o <= 8'h7e;
        494 : data_o <= 8'h00;
        495 : data_o <= 8'h00;

        // ASCII 62
        496 : data_o <= 8'h60;
        497 : data_o <= 8'h30;
        498 : data_o <= 8'h18;
        499 : data_o <= 8'h0c;
        500 : data_o <= 8'h18;
        501 : data_o <= 8'h30;
        502 : data_o <= 8'h60;
        503 : data_o <= 8'h00;

        // ASCII 63
        504 : data_o <= 8'h7c;
        505 : data_o <= 8'hc6;
        506 : data_o <= 8'h0c;
        507 : data_o <= 8'h18;
        508 : data_o <= 8'h18;
        509 : data_o <= 8'h00;
        510 : data_o <= 8'h18;
        511 : data_o <= 8'h00;

        // ASCII 64
        512 : data_o <= 8'h7c;
        513 : data_o <= 8'hc6;
        514 : data_o <= 8'hde;
        515 : data_o <= 8'hde;
        516 : data_o <= 8'hde;
        517 : data_o <= 8'hc0;
        518 : data_o <= 8'h78;
        519 : data_o <= 8'h00;

        // ASCII 65
        520 : data_o <= 8'h38;
        521 : data_o <= 8'h6c;
        522 : data_o <= 8'hc6;
        523 : data_o <= 8'hfe;
        524 : data_o <= 8'hc6;
        525 : data_o <= 8'hc6;
        526 : data_o <= 8'hc6;
        527 : data_o <= 8'h00;

        // ASCII 66
        528 : data_o <= 8'hfc;
        529 : data_o <= 8'h66;
        530 : data_o <= 8'h66;
        531 : data_o <= 8'h7c;
        532 : data_o <= 8'h66;
        533 : data_o <= 8'h66;
        534 : data_o <= 8'hfc;
        535 : data_o <= 8'h00;

        // ASCII 67
        536 : data_o <= 8'h3c;
        537 : data_o <= 8'h66;
        538 : data_o <= 8'hc0;
        539 : data_o <= 8'hc0;
        540 : data_o <= 8'hc0;
        541 : data_o <= 8'h66;
        542 : data_o <= 8'h3c;
        543 : data_o <= 8'h00;

        // ASCII 68
        544 : data_o <= 8'hf8;
        545 : data_o <= 8'h6c;
        546 : data_o <= 8'h66;
        547 : data_o <= 8'h66;
        548 : data_o <= 8'h66;
        549 : data_o <= 8'h6c;
        550 : data_o <= 8'hf8;
        551 : data_o <= 8'h00;

        // ASCII 69
        552 : data_o <= 8'hfe;
        553 : data_o <= 8'h62;
        554 : data_o <= 8'h68;
        555 : data_o <= 8'h78;
        556 : data_o <= 8'h68;
        557 : data_o <= 8'h62;
        558 : data_o <= 8'hfe;
        559 : data_o <= 8'h00;

        // ASCII 70
        560 : data_o <= 8'hfe;
        561 : data_o <= 8'h62;
        562 : data_o <= 8'h68;
        563 : data_o <= 8'h78;
        564 : data_o <= 8'h68;
        565 : data_o <= 8'h60;
        566 : data_o <= 8'hf0;
        567 : data_o <= 8'h00;

        // ASCII 71
        568 : data_o <= 8'h3c;
        569 : data_o <= 8'h66;
        570 : data_o <= 8'hc0;
        571 : data_o <= 8'hc0;
        572 : data_o <= 8'hce;
        573 : data_o <= 8'h66;
        574 : data_o <= 8'h3a;
        575 : data_o <= 8'h00;

        // ASCII 72
        576 : data_o <= 8'hc6;
        577 : data_o <= 8'hc6;
        578 : data_o <= 8'hc6;
        579 : data_o <= 8'hfe;
        580 : data_o <= 8'hc6;
        581 : data_o <= 8'hc6;
        582 : data_o <= 8'hc6;
        583 : data_o <= 8'h00;

        // ASCII 73
        584 : data_o <= 8'h3c;
        585 : data_o <= 8'h18;
        586 : data_o <= 8'h18;
        587 : data_o <= 8'h18;
        588 : data_o <= 8'h18;
        589 : data_o <= 8'h18;
        590 : data_o <= 8'h3c;
        591 : data_o <= 8'h00;

        // ASCII 74
        592 : data_o <= 8'h1e;
        593 : data_o <= 8'h0c;
        594 : data_o <= 8'h0c;
        595 : data_o <= 8'h0c;
        596 : data_o <= 8'hcc;
        597 : data_o <= 8'hcc;
        598 : data_o <= 8'h78;
        599 : data_o <= 8'h00;

        // ASCII 75
        600 : data_o <= 8'he6;
        601 : data_o <= 8'h66;
        602 : data_o <= 8'h6c;
        603 : data_o <= 8'h78;
        604 : data_o <= 8'h6c;
        605 : data_o <= 8'h66;
        606 : data_o <= 8'he6;
        607 : data_o <= 8'h00;

        // ASCII 76
        608 : data_o <= 8'hf0;
        609 : data_o <= 8'h60;
        610 : data_o <= 8'h60;
        611 : data_o <= 8'h60;
        612 : data_o <= 8'h62;
        613 : data_o <= 8'h66;
        614 : data_o <= 8'hfe;
        615 : data_o <= 8'h00;

        // ASCII 77
        616 : data_o <= 8'hc6;
        617 : data_o <= 8'hee;
        618 : data_o <= 8'hfe;
        619 : data_o <= 8'hfe;
        620 : data_o <= 8'hd6;
        621 : data_o <= 8'hc6;
        622 : data_o <= 8'hc6;
        623 : data_o <= 8'h00;

        // ASCII 78
        624 : data_o <= 8'hc6;
        625 : data_o <= 8'he6;
        626 : data_o <= 8'hf6;
        627 : data_o <= 8'hde;
        628 : data_o <= 8'hce;
        629 : data_o <= 8'hc6;
        630 : data_o <= 8'hc6;
        631 : data_o <= 8'h00;

        // ASCII 79
        632 : data_o <= 8'h7c;
        633 : data_o <= 8'hc6;
        634 : data_o <= 8'hc6;
        635 : data_o <= 8'hc6;
        636 : data_o <= 8'hc6;
        637 : data_o <= 8'hc6;
        638 : data_o <= 8'h7c;
        639 : data_o <= 8'h00;

        // ASCII 80
        640 : data_o <= 8'hfc;
        641 : data_o <= 8'h66;
        642 : data_o <= 8'h66;
        643 : data_o <= 8'h7c;
        644 : data_o <= 8'h60;
        645 : data_o <= 8'h60;
        646 : data_o <= 8'hf0;
        647 : data_o <= 8'h00;

        // ASCII 81
        648 : data_o <= 8'h7c;
        649 : data_o <= 8'hc6;
        650 : data_o <= 8'hc6;
        651 : data_o <= 8'hc6;
        652 : data_o <= 8'hc6;
        653 : data_o <= 8'hce;
        654 : data_o <= 8'h7c;
        655 : data_o <= 8'h0e;

        // ASCII 82
        656 : data_o <= 8'hfc;
        657 : data_o <= 8'h66;
        658 : data_o <= 8'h66;
        659 : data_o <= 8'h7c;
        660 : data_o <= 8'h6c;
        661 : data_o <= 8'h66;
        662 : data_o <= 8'he6;
        663 : data_o <= 8'h00;

        // ASCII 83
        664 : data_o <= 8'h3c;
        665 : data_o <= 8'h66;
        666 : data_o <= 8'h30;
        667 : data_o <= 8'h18;
        668 : data_o <= 8'h0c;
        669 : data_o <= 8'h66;
        670 : data_o <= 8'h3c;
        671 : data_o <= 8'h00;

        // ASCII 84
        672 : data_o <= 8'h7e;
        673 : data_o <= 8'h7e;
        674 : data_o <= 8'h5a;
        675 : data_o <= 8'h18;
        676 : data_o <= 8'h18;
        677 : data_o <= 8'h18;
        678 : data_o <= 8'h3c;
        679 : data_o <= 8'h00;

        // ASCII 85
        680 : data_o <= 8'hc6;
        681 : data_o <= 8'hc6;
        682 : data_o <= 8'hc6;
        683 : data_o <= 8'hc6;
        684 : data_o <= 8'hc6;
        685 : data_o <= 8'hc6;
        686 : data_o <= 8'h7c;
        687 : data_o <= 8'h00;

        // ASCII 86
        688 : data_o <= 8'hc6;
        689 : data_o <= 8'hc6;
        690 : data_o <= 8'hc6;
        691 : data_o <= 8'hc6;
        692 : data_o <= 8'hc6;
        693 : data_o <= 8'h6c;
        694 : data_o <= 8'h38;
        695 : data_o <= 8'h00;

        // ASCII 87
        696 : data_o <= 8'hc6;
        697 : data_o <= 8'hc6;
        698 : data_o <= 8'hc6;
        699 : data_o <= 8'hd6;
        700 : data_o <= 8'hd6;
        701 : data_o <= 8'hfe;
        702 : data_o <= 8'h6c;
        703 : data_o <= 8'h00;

        // ASCII 88
        704 : data_o <= 8'hc6;
        705 : data_o <= 8'hc6;
        706 : data_o <= 8'h6c;
        707 : data_o <= 8'h38;
        708 : data_o <= 8'h6c;
        709 : data_o <= 8'hc6;
        710 : data_o <= 8'hc6;
        711 : data_o <= 8'h00;

        // ASCII 89
        712 : data_o <= 8'h66;
        713 : data_o <= 8'h66;
        714 : data_o <= 8'h66;
        715 : data_o <= 8'h3c;
        716 : data_o <= 8'h18;
        717 : data_o <= 8'h18;
        718 : data_o <= 8'h3c;
        719 : data_o <= 8'h00;

        // ASCII 90
        720 : data_o <= 8'hfe;
        721 : data_o <= 8'hc6;
        722 : data_o <= 8'h8c;
        723 : data_o <= 8'h18;
        724 : data_o <= 8'h32;
        725 : data_o <= 8'h66;
        726 : data_o <= 8'hfe;
        727 : data_o <= 8'h00;

        // ASCII 91
        728 : data_o <= 8'h3c;
        729 : data_o <= 8'h30;
        730 : data_o <= 8'h30;
        731 : data_o <= 8'h30;
        732 : data_o <= 8'h30;
        733 : data_o <= 8'h30;
        734 : data_o <= 8'h3c;
        735 : data_o <= 8'h00;

        // ASCII 92
        736 : data_o <= 8'hc0;
        737 : data_o <= 8'h60;
        738 : data_o <= 8'h30;
        739 : data_o <= 8'h18;
        740 : data_o <= 8'h0c;
        741 : data_o <= 8'h06;
        742 : data_o <= 8'h02;
        743 : data_o <= 8'h00;

        // ASCII 93
        744 : data_o <= 8'h3c;
        745 : data_o <= 8'h0c;
        746 : data_o <= 8'h0c;
        747 : data_o <= 8'h0c;
        748 : data_o <= 8'h0c;
        749 : data_o <= 8'h0c;
        750 : data_o <= 8'h3c;
        751 : data_o <= 8'h00;

        // ASCII 94
        752 : data_o <= 8'h10;
        753 : data_o <= 8'h38;
        754 : data_o <= 8'h6c;
        755 : data_o <= 8'hc6;
        756 : data_o <= 8'h00;
        757 : data_o <= 8'h00;
        758 : data_o <= 8'h00;
        759 : data_o <= 8'h00;

        // ASCII 95
        760 : data_o <= 8'h00;
        761 : data_o <= 8'h00;
        762 : data_o <= 8'h00;
        763 : data_o <= 8'h00;
        764 : data_o <= 8'h00;
        765 : data_o <= 8'h00;
        766 : data_o <= 8'h00;
        767 : data_o <= 8'hff;

        // ASCII 96
        768 : data_o <= 8'h30;
        769 : data_o <= 8'h18;
        770 : data_o <= 8'h0c;
        771 : data_o <= 8'h00;
        772 : data_o <= 8'h00;
        773 : data_o <= 8'h00;
        774 : data_o <= 8'h00;
        775 : data_o <= 8'h00;

        // ASCII 97
        776 : data_o <= 8'h00;
        777 : data_o <= 8'h00;
        778 : data_o <= 8'h78;
        779 : data_o <= 8'h0c;
        780 : data_o <= 8'h7c;
        781 : data_o <= 8'hcc;
        782 : data_o <= 8'h76;
        783 : data_o <= 8'h00;

        // ASCII 98
        784 : data_o <= 8'he0;
        785 : data_o <= 8'h60;
        786 : data_o <= 8'h7c;
        787 : data_o <= 8'h66;
        788 : data_o <= 8'h66;
        789 : data_o <= 8'h66;
        790 : data_o <= 8'hdc;
        791 : data_o <= 8'h00;

        // ASCII 99
        792 : data_o <= 8'h00;
        793 : data_o <= 8'h00;
        794 : data_o <= 8'h7c;
        795 : data_o <= 8'hc6;
        796 : data_o <= 8'hc0;
        797 : data_o <= 8'hc6;
        798 : data_o <= 8'h7c;
        799 : data_o <= 8'h00;

        // ASCII 100
        800 : data_o <= 8'h1c;
        801 : data_o <= 8'h0c;
        802 : data_o <= 8'h7c;
        803 : data_o <= 8'hcc;
        804 : data_o <= 8'hcc;
        805 : data_o <= 8'hcc;
        806 : data_o <= 8'h76;
        807 : data_o <= 8'h00;

        // ASCII 101
        808 : data_o <= 8'h00;
        809 : data_o <= 8'h00;
        810 : data_o <= 8'h7c;
        811 : data_o <= 8'hc6;
        812 : data_o <= 8'hfe;
        813 : data_o <= 8'hc0;
        814 : data_o <= 8'h7c;
        815 : data_o <= 8'h00;

        // ASCII 102
        816 : data_o <= 8'h3c;
        817 : data_o <= 8'h66;
        818 : data_o <= 8'h60;
        819 : data_o <= 8'hf8;
        820 : data_o <= 8'h60;
        821 : data_o <= 8'h60;
        822 : data_o <= 8'hf0;
        823 : data_o <= 8'h00;

        // ASCII 103
        824 : data_o <= 8'h00;
        825 : data_o <= 8'h00;
        826 : data_o <= 8'h76;
        827 : data_o <= 8'hcc;
        828 : data_o <= 8'hcc;
        829 : data_o <= 8'h7c;
        830 : data_o <= 8'h0c;
        831 : data_o <= 8'hf8;

        // ASCII 104
        832 : data_o <= 8'he0;
        833 : data_o <= 8'h60;
        834 : data_o <= 8'h6c;
        835 : data_o <= 8'h76;
        836 : data_o <= 8'h66;
        837 : data_o <= 8'h66;
        838 : data_o <= 8'he6;
        839 : data_o <= 8'h00;

        // ASCII 105
        840 : data_o <= 8'h18;
        841 : data_o <= 8'h00;
        842 : data_o <= 8'h38;
        843 : data_o <= 8'h18;
        844 : data_o <= 8'h18;
        845 : data_o <= 8'h18;
        846 : data_o <= 8'h3c;
        847 : data_o <= 8'h00;

        // ASCII 106
        848 : data_o <= 8'h06;
        849 : data_o <= 8'h00;
        850 : data_o <= 8'h06;
        851 : data_o <= 8'h06;
        852 : data_o <= 8'h06;
        853 : data_o <= 8'h66;
        854 : data_o <= 8'h66;
        855 : data_o <= 8'h3c;

        // ASCII 107
        856 : data_o <= 8'he0;
        857 : data_o <= 8'h60;
        858 : data_o <= 8'h66;
        859 : data_o <= 8'h6c;
        860 : data_o <= 8'h78;
        861 : data_o <= 8'h6c;
        862 : data_o <= 8'he6;
        863 : data_o <= 8'h00;

        // ASCII 108
        864 : data_o <= 8'h38;
        865 : data_o <= 8'h18;
        866 : data_o <= 8'h18;
        867 : data_o <= 8'h18;
        868 : data_o <= 8'h18;
        869 : data_o <= 8'h18;
        870 : data_o <= 8'h3c;
        871 : data_o <= 8'h00;

        // ASCII 109
        872 : data_o <= 8'h00;
        873 : data_o <= 8'h00;
        874 : data_o <= 8'hec;
        875 : data_o <= 8'hfe;
        876 : data_o <= 8'hd6;
        877 : data_o <= 8'hd6;
        878 : data_o <= 8'hd6;
        879 : data_o <= 8'h00;

        // ASCII 110
        880 : data_o <= 8'h00;
        881 : data_o <= 8'h00;
        882 : data_o <= 8'hdc;
        883 : data_o <= 8'h66;
        884 : data_o <= 8'h66;
        885 : data_o <= 8'h66;
        886 : data_o <= 8'h66;
        887 : data_o <= 8'h00;

        // ASCII 111
        888 : data_o <= 8'h00;
        889 : data_o <= 8'h00;
        890 : data_o <= 8'h7c;
        891 : data_o <= 8'hc6;
        892 : data_o <= 8'hc6;
        893 : data_o <= 8'hc6;
        894 : data_o <= 8'h7c;
        895 : data_o <= 8'h00;

        // ASCII 112
        896 : data_o <= 8'h00;
        897 : data_o <= 8'h00;
        898 : data_o <= 8'hdc;
        899 : data_o <= 8'h66;
        900 : data_o <= 8'h66;
        901 : data_o <= 8'h7c;
        902 : data_o <= 8'h60;
        903 : data_o <= 8'hf0;

        // ASCII 113
        904 : data_o <= 8'h00;
        905 : data_o <= 8'h00;
        906 : data_o <= 8'h76;
        907 : data_o <= 8'hcc;
        908 : data_o <= 8'hcc;
        909 : data_o <= 8'h7c;
        910 : data_o <= 8'h0c;
        911 : data_o <= 8'h1e;

        // ASCII 114
        912 : data_o <= 8'h00;
        913 : data_o <= 8'h00;
        914 : data_o <= 8'hdc;
        915 : data_o <= 8'h76;
        916 : data_o <= 8'h60;
        917 : data_o <= 8'h60;
        918 : data_o <= 8'hf0;
        919 : data_o <= 8'h00;

        // ASCII 115
        920 : data_o <= 8'h00;
        921 : data_o <= 8'h00;
        922 : data_o <= 8'h7e;
        923 : data_o <= 8'hc0;
        924 : data_o <= 8'h7c;
        925 : data_o <= 8'h06;
        926 : data_o <= 8'hfc;
        927 : data_o <= 8'h00;

        // ASCII 116
        928 : data_o <= 8'h30;
        929 : data_o <= 8'h30;
        930 : data_o <= 8'hfc;
        931 : data_o <= 8'h30;
        932 : data_o <= 8'h30;
        933 : data_o <= 8'h36;
        934 : data_o <= 8'h1c;
        935 : data_o <= 8'h00;

        // ASCII 117
        936 : data_o <= 8'h00;
        937 : data_o <= 8'h00;
        938 : data_o <= 8'hcc;
        939 : data_o <= 8'hcc;
        940 : data_o <= 8'hcc;
        941 : data_o <= 8'hcc;
        942 : data_o <= 8'h76;
        943 : data_o <= 8'h00;

        // ASCII 118
        944 : data_o <= 8'h00;
        945 : data_o <= 8'h00;
        946 : data_o <= 8'hc6;
        947 : data_o <= 8'hc6;
        948 : data_o <= 8'hc6;
        949 : data_o <= 8'h6c;
        950 : data_o <= 8'h38;
        951 : data_o <= 8'h00;

        // ASCII 119
        952 : data_o <= 8'h00;
        953 : data_o <= 8'h00;
        954 : data_o <= 8'hc6;
        955 : data_o <= 8'hd6;
        956 : data_o <= 8'hd6;
        957 : data_o <= 8'hfe;
        958 : data_o <= 8'h6c;
        959 : data_o <= 8'h00;

        // ASCII 120
        960 : data_o <= 8'h00;
        961 : data_o <= 8'h00;
        962 : data_o <= 8'hc6;
        963 : data_o <= 8'h6c;
        964 : data_o <= 8'h38;
        965 : data_o <= 8'h6c;
        966 : data_o <= 8'hc6;
        967 : data_o <= 8'h00;

        // ASCII 121
        968 : data_o <= 8'h00;
        969 : data_o <= 8'h00;
        970 : data_o <= 8'hc6;
        971 : data_o <= 8'hc6;
        972 : data_o <= 8'hc6;
        973 : data_o <= 8'h7e;
        974 : data_o <= 8'h06;
        975 : data_o <= 8'hfc;

        // ASCII 122
        976 : data_o <= 8'h00;
        977 : data_o <= 8'h00;
        978 : data_o <= 8'h7e;
        979 : data_o <= 8'h4c;
        980 : data_o <= 8'h18;
        981 : data_o <= 8'h32;
        982 : data_o <= 8'h7e;
        983 : data_o <= 8'h00;

        // ASCII 123
        984 : data_o <= 8'h0e;
        985 : data_o <= 8'h18;
        986 : data_o <= 8'h18;
        987 : data_o <= 8'h70;
        988 : data_o <= 8'h18;
        989 : data_o <= 8'h18;
        990 : data_o <= 8'h0e;
        991 : data_o <= 8'h00;

        // ASCII 124
        992 : data_o <= 8'h18;
        993 : data_o <= 8'h18;
        994 : data_o <= 8'h18;
        995 : data_o <= 8'h18;
        996 : data_o <= 8'h18;
        997 : data_o <= 8'h18;
        998 : data_o <= 8'h18;
        999 : data_o <= 8'h00;

        // ASCII 125
        1000 : data_o <= 8'h70;
        1001 : data_o <= 8'h18;
        1002 : data_o <= 8'h18;
        1003 : data_o <= 8'h0e;
        1004 : data_o <= 8'h18;
        1005 : data_o <= 8'h18;
        1006 : data_o <= 8'h70;
        1007 : data_o <= 8'h00;

        // ASCII 126
        1008 : data_o <= 8'h76;
        1009 : data_o <= 8'hdc;
        1010 : data_o <= 8'h00;
        1011 : data_o <= 8'h00;
        1012 : data_o <= 8'h00;
        1013 : data_o <= 8'h00;
        1014 : data_o <= 8'h00;
        1015 : data_o <= 8'h00;

        // ASCII 127
        1016 : data_o <= 8'h00;
        1017 : data_o <= 8'h10;
        1018 : data_o <= 8'h38;
        1019 : data_o <= 8'h6c;
        1020 : data_o <= 8'hc6;
        1021 : data_o <= 8'hc6;
        1022 : data_o <= 8'hfe;
        1023 : data_o <= 8'h00;

        // ASCII 128
        1024 : data_o <= 8'h7c;
        1025 : data_o <= 8'hc6;
        1026 : data_o <= 8'hc0;
        1027 : data_o <= 8'hc0;
        1028 : data_o <= 8'hc6;
        1029 : data_o <= 8'h7c;
        1030 : data_o <= 8'h0c;
        1031 : data_o <= 8'h78;

        // ASCII 129
        1032 : data_o <= 8'hcc;
        1033 : data_o <= 8'h00;
        1034 : data_o <= 8'hcc;
        1035 : data_o <= 8'hcc;
        1036 : data_o <= 8'hcc;
        1037 : data_o <= 8'hcc;
        1038 : data_o <= 8'h76;
        1039 : data_o <= 8'h00;

        // ASCII 130
        1040 : data_o <= 8'h0c;
        1041 : data_o <= 8'h18;
        1042 : data_o <= 8'h7c;
        1043 : data_o <= 8'hc6;
        1044 : data_o <= 8'hfe;
        1045 : data_o <= 8'hc0;
        1046 : data_o <= 8'h7c;
        1047 : data_o <= 8'h00;

        // ASCII 131
        1048 : data_o <= 8'h7c;
        1049 : data_o <= 8'h82;
        1050 : data_o <= 8'h78;
        1051 : data_o <= 8'h0c;
        1052 : data_o <= 8'h7c;
        1053 : data_o <= 8'hcc;
        1054 : data_o <= 8'h76;
        1055 : data_o <= 8'h00;

        // ASCII 132
        1056 : data_o <= 8'hc6;
        1057 : data_o <= 8'h00;
        1058 : data_o <= 8'h78;
        1059 : data_o <= 8'h0c;
        1060 : data_o <= 8'h7c;
        1061 : data_o <= 8'hcc;
        1062 : data_o <= 8'h76;
        1063 : data_o <= 8'h00;

        // ASCII 133
        1064 : data_o <= 8'h30;
        1065 : data_o <= 8'h18;
        1066 : data_o <= 8'h78;
        1067 : data_o <= 8'h0c;
        1068 : data_o <= 8'h7c;
        1069 : data_o <= 8'hcc;
        1070 : data_o <= 8'h76;
        1071 : data_o <= 8'h00;

        // ASCII 134
        1072 : data_o <= 8'h30;
        1073 : data_o <= 8'h30;
        1074 : data_o <= 8'h78;
        1075 : data_o <= 8'h0c;
        1076 : data_o <= 8'h7c;
        1077 : data_o <= 8'hcc;
        1078 : data_o <= 8'h76;
        1079 : data_o <= 8'h00;

        // ASCII 135
        1080 : data_o <= 8'h00;
        1081 : data_o <= 8'h00;
        1082 : data_o <= 8'h7e;
        1083 : data_o <= 8'hc0;
        1084 : data_o <= 8'hc0;
        1085 : data_o <= 8'h7e;
        1086 : data_o <= 8'h0c;
        1087 : data_o <= 8'h38;

        // ASCII 136
        1088 : data_o <= 8'h7c;
        1089 : data_o <= 8'h82;
        1090 : data_o <= 8'h7c;
        1091 : data_o <= 8'hc6;
        1092 : data_o <= 8'hfe;
        1093 : data_o <= 8'hc0;
        1094 : data_o <= 8'h7c;
        1095 : data_o <= 8'h00;

        // ASCII 137
        1096 : data_o <= 8'hc6;
        1097 : data_o <= 8'h00;
        1098 : data_o <= 8'h7c;
        1099 : data_o <= 8'hc6;
        1100 : data_o <= 8'hfe;
        1101 : data_o <= 8'hc0;
        1102 : data_o <= 8'h7c;
        1103 : data_o <= 8'h00;

        // ASCII 138
        1104 : data_o <= 8'h30;
        1105 : data_o <= 8'h18;
        1106 : data_o <= 8'h7c;
        1107 : data_o <= 8'hc6;
        1108 : data_o <= 8'hfe;
        1109 : data_o <= 8'hc0;
        1110 : data_o <= 8'h7c;
        1111 : data_o <= 8'h00;

        // ASCII 139
        1112 : data_o <= 8'h66;
        1113 : data_o <= 8'h00;
        1114 : data_o <= 8'h38;
        1115 : data_o <= 8'h18;
        1116 : data_o <= 8'h18;
        1117 : data_o <= 8'h18;
        1118 : data_o <= 8'h3c;
        1119 : data_o <= 8'h00;

        // ASCII 140
        1120 : data_o <= 8'h7c;
        1121 : data_o <= 8'h82;
        1122 : data_o <= 8'h38;
        1123 : data_o <= 8'h18;
        1124 : data_o <= 8'h18;
        1125 : data_o <= 8'h18;
        1126 : data_o <= 8'h3c;
        1127 : data_o <= 8'h00;

        // ASCII 141
        1128 : data_o <= 8'h30;
        1129 : data_o <= 8'h18;
        1130 : data_o <= 8'h00;
        1131 : data_o <= 8'h38;
        1132 : data_o <= 8'h18;
        1133 : data_o <= 8'h18;
        1134 : data_o <= 8'h3c;
        1135 : data_o <= 8'h00;

        // ASCII 142
        1136 : data_o <= 8'hc6;
        1137 : data_o <= 8'h38;
        1138 : data_o <= 8'h6c;
        1139 : data_o <= 8'hc6;
        1140 : data_o <= 8'hfe;
        1141 : data_o <= 8'hc6;
        1142 : data_o <= 8'hc6;
        1143 : data_o <= 8'h00;

        // ASCII 143
        1144 : data_o <= 8'h38;
        1145 : data_o <= 8'h6c;
        1146 : data_o <= 8'h7c;
        1147 : data_o <= 8'hc6;
        1148 : data_o <= 8'hfe;
        1149 : data_o <= 8'hc6;
        1150 : data_o <= 8'hc6;
        1151 : data_o <= 8'h00;

        // ASCII 144
        1152 : data_o <= 8'h18;
        1153 : data_o <= 8'h30;
        1154 : data_o <= 8'hfe;
        1155 : data_o <= 8'hc0;
        1156 : data_o <= 8'hf8;
        1157 : data_o <= 8'hc0;
        1158 : data_o <= 8'hfe;
        1159 : data_o <= 8'h00;

        // ASCII 145
        1160 : data_o <= 8'h00;
        1161 : data_o <= 8'h00;
        1162 : data_o <= 8'h7e;
        1163 : data_o <= 8'h18;
        1164 : data_o <= 8'h7e;
        1165 : data_o <= 8'hd8;
        1166 : data_o <= 8'h7e;
        1167 : data_o <= 8'h00;

        // ASCII 146
        1168 : data_o <= 8'h3e;
        1169 : data_o <= 8'h6c;
        1170 : data_o <= 8'hcc;
        1171 : data_o <= 8'hfe;
        1172 : data_o <= 8'hcc;
        1173 : data_o <= 8'hcc;
        1174 : data_o <= 8'hce;
        1175 : data_o <= 8'h00;

        // ASCII 147
        1176 : data_o <= 8'h7c;
        1177 : data_o <= 8'h82;
        1178 : data_o <= 8'h7c;
        1179 : data_o <= 8'hc6;
        1180 : data_o <= 8'hc6;
        1181 : data_o <= 8'hc6;
        1182 : data_o <= 8'h7c;
        1183 : data_o <= 8'h00;

        // ASCII 148
        1184 : data_o <= 8'hc6;
        1185 : data_o <= 8'h00;
        1186 : data_o <= 8'h7c;
        1187 : data_o <= 8'hc6;
        1188 : data_o <= 8'hc6;
        1189 : data_o <= 8'hc6;
        1190 : data_o <= 8'h7c;
        1191 : data_o <= 8'h00;

        // ASCII 149
        1192 : data_o <= 8'h30;
        1193 : data_o <= 8'h18;
        1194 : data_o <= 8'h7c;
        1195 : data_o <= 8'hc6;
        1196 : data_o <= 8'hc6;
        1197 : data_o <= 8'hc6;
        1198 : data_o <= 8'h7c;
        1199 : data_o <= 8'h00;

        // ASCII 150
        1200 : data_o <= 8'h78;
        1201 : data_o <= 8'h84;
        1202 : data_o <= 8'h00;
        1203 : data_o <= 8'hcc;
        1204 : data_o <= 8'hcc;
        1205 : data_o <= 8'hcc;
        1206 : data_o <= 8'h76;
        1207 : data_o <= 8'h00;

        // ASCII 151
        1208 : data_o <= 8'h60;
        1209 : data_o <= 8'h30;
        1210 : data_o <= 8'hcc;
        1211 : data_o <= 8'hcc;
        1212 : data_o <= 8'hcc;
        1213 : data_o <= 8'hcc;
        1214 : data_o <= 8'h76;
        1215 : data_o <= 8'h00;

        // ASCII 152
        1216 : data_o <= 8'hc6;
        1217 : data_o <= 8'h00;
        1218 : data_o <= 8'hc6;
        1219 : data_o <= 8'hc6;
        1220 : data_o <= 8'hc6;
        1221 : data_o <= 8'h7e;
        1222 : data_o <= 8'h06;
        1223 : data_o <= 8'hfc;

        // ASCII 153
        1224 : data_o <= 8'hc6;
        1225 : data_o <= 8'h38;
        1226 : data_o <= 8'h6c;
        1227 : data_o <= 8'hc6;
        1228 : data_o <= 8'hc6;
        1229 : data_o <= 8'h6c;
        1230 : data_o <= 8'h38;
        1231 : data_o <= 8'h00;

        // ASCII 154
        1232 : data_o <= 8'hc6;
        1233 : data_o <= 8'h00;
        1234 : data_o <= 8'hc6;
        1235 : data_o <= 8'hc6;
        1236 : data_o <= 8'hc6;
        1237 : data_o <= 8'hc6;
        1238 : data_o <= 8'h7c;
        1239 : data_o <= 8'h00;

        // ASCII 155
        1240 : data_o <= 8'h18;
        1241 : data_o <= 8'h18;
        1242 : data_o <= 8'h7e;
        1243 : data_o <= 8'hc0;
        1244 : data_o <= 8'hc0;
        1245 : data_o <= 8'h7e;
        1246 : data_o <= 8'h18;
        1247 : data_o <= 8'h18;

        // ASCII 156
        1248 : data_o <= 8'h38;
        1249 : data_o <= 8'h6c;
        1250 : data_o <= 8'h64;
        1251 : data_o <= 8'hf0;
        1252 : data_o <= 8'h60;
        1253 : data_o <= 8'h66;
        1254 : data_o <= 8'hfc;
        1255 : data_o <= 8'h00;

        // ASCII 157
        1256 : data_o <= 8'h66;
        1257 : data_o <= 8'h66;
        1258 : data_o <= 8'h3c;
        1259 : data_o <= 8'h7e;
        1260 : data_o <= 8'h18;
        1261 : data_o <= 8'h7e;
        1262 : data_o <= 8'h18;
        1263 : data_o <= 8'h18;

        // ASCII 158
        1264 : data_o <= 8'hf8;
        1265 : data_o <= 8'hcc;
        1266 : data_o <= 8'hcc;
        1267 : data_o <= 8'hfa;
        1268 : data_o <= 8'hc6;
        1269 : data_o <= 8'hcf;
        1270 : data_o <= 8'hc6;
        1271 : data_o <= 8'hc7;

        // ASCII 159
        1272 : data_o <= 8'h0e;
        1273 : data_o <= 8'h1b;
        1274 : data_o <= 8'h18;
        1275 : data_o <= 8'h3c;
        1276 : data_o <= 8'h18;
        1277 : data_o <= 8'hd8;
        1278 : data_o <= 8'h70;
        1279 : data_o <= 8'h00;

        // ASCII 160
        1280 : data_o <= 8'h18;
        1281 : data_o <= 8'h30;
        1282 : data_o <= 8'h78;
        1283 : data_o <= 8'h0c;
        1284 : data_o <= 8'h7c;
        1285 : data_o <= 8'hcc;
        1286 : data_o <= 8'h76;
        1287 : data_o <= 8'h00;

        // ASCII 161
        1288 : data_o <= 8'h0c;
        1289 : data_o <= 8'h18;
        1290 : data_o <= 8'h00;
        1291 : data_o <= 8'h38;
        1292 : data_o <= 8'h18;
        1293 : data_o <= 8'h18;
        1294 : data_o <= 8'h3c;
        1295 : data_o <= 8'h00;

        // ASCII 162
        1296 : data_o <= 8'h0c;
        1297 : data_o <= 8'h18;
        1298 : data_o <= 8'h7c;
        1299 : data_o <= 8'hc6;
        1300 : data_o <= 8'hc6;
        1301 : data_o <= 8'hc6;
        1302 : data_o <= 8'h7c;
        1303 : data_o <= 8'h00;

        // ASCII 163
        1304 : data_o <= 8'h18;
        1305 : data_o <= 8'h30;
        1306 : data_o <= 8'hcc;
        1307 : data_o <= 8'hcc;
        1308 : data_o <= 8'hcc;
        1309 : data_o <= 8'hcc;
        1310 : data_o <= 8'h76;
        1311 : data_o <= 8'h00;

        // ASCII 164
        1312 : data_o <= 8'h76;
        1313 : data_o <= 8'hdc;
        1314 : data_o <= 8'h00;
        1315 : data_o <= 8'hdc;
        1316 : data_o <= 8'h66;
        1317 : data_o <= 8'h66;
        1318 : data_o <= 8'h66;
        1319 : data_o <= 8'h00;

        // ASCII 165
        1320 : data_o <= 8'h76;
        1321 : data_o <= 8'hdc;
        1322 : data_o <= 8'h00;
        1323 : data_o <= 8'he6;
        1324 : data_o <= 8'hf6;
        1325 : data_o <= 8'hde;
        1326 : data_o <= 8'hce;
        1327 : data_o <= 8'h00;

        // ASCII 166
        1328 : data_o <= 8'h3c;
        1329 : data_o <= 8'h6c;
        1330 : data_o <= 8'h6c;
        1331 : data_o <= 8'h3e;
        1332 : data_o <= 8'h00;
        1333 : data_o <= 8'h7e;
        1334 : data_o <= 8'h00;
        1335 : data_o <= 8'h00;

        // ASCII 167
        1336 : data_o <= 8'h38;
        1337 : data_o <= 8'h6c;
        1338 : data_o <= 8'h6c;
        1339 : data_o <= 8'h38;
        1340 : data_o <= 8'h00;
        1341 : data_o <= 8'h7c;
        1342 : data_o <= 8'h00;
        1343 : data_o <= 8'h00;

        // ASCII 168
        1344 : data_o <= 8'h18;
        1345 : data_o <= 8'h00;
        1346 : data_o <= 8'h18;
        1347 : data_o <= 8'h18;
        1348 : data_o <= 8'h30;
        1349 : data_o <= 8'h63;
        1350 : data_o <= 8'h3e;
        1351 : data_o <= 8'h00;

        // ASCII 169
        1352 : data_o <= 8'h00;
        1353 : data_o <= 8'h00;
        1354 : data_o <= 8'h00;
        1355 : data_o <= 8'hfe;
        1356 : data_o <= 8'hc0;
        1357 : data_o <= 8'hc0;
        1358 : data_o <= 8'h00;
        1359 : data_o <= 8'h00;

        // ASCII 170
        1360 : data_o <= 8'h00;
        1361 : data_o <= 8'h00;
        1362 : data_o <= 8'h00;
        1363 : data_o <= 8'hfe;
        1364 : data_o <= 8'h06;
        1365 : data_o <= 8'h06;
        1366 : data_o <= 8'h00;
        1367 : data_o <= 8'h00;

        // ASCII 171
        1368 : data_o <= 8'h63;
        1369 : data_o <= 8'he6;
        1370 : data_o <= 8'h6c;
        1371 : data_o <= 8'h7e;
        1372 : data_o <= 8'h33;
        1373 : data_o <= 8'h66;
        1374 : data_o <= 8'hcc;
        1375 : data_o <= 8'h0f;

        // ASCII 172
        1376 : data_o <= 8'h63;
        1377 : data_o <= 8'he6;
        1378 : data_o <= 8'h6c;
        1379 : data_o <= 8'h7a;
        1380 : data_o <= 8'h36;
        1381 : data_o <= 8'h6a;
        1382 : data_o <= 8'hdf;
        1383 : data_o <= 8'h06;

        // ASCII 173
        1384 : data_o <= 8'h18;
        1385 : data_o <= 8'h00;
        1386 : data_o <= 8'h18;
        1387 : data_o <= 8'h18;
        1388 : data_o <= 8'h3c;
        1389 : data_o <= 8'h3c;
        1390 : data_o <= 8'h18;
        1391 : data_o <= 8'h00;

        // ASCII 174
        1392 : data_o <= 8'h00;
        1393 : data_o <= 8'h33;
        1394 : data_o <= 8'h66;
        1395 : data_o <= 8'hcc;
        1396 : data_o <= 8'h66;
        1397 : data_o <= 8'h33;
        1398 : data_o <= 8'h00;
        1399 : data_o <= 8'h00;

        // ASCII 175
        1400 : data_o <= 8'h00;
        1401 : data_o <= 8'hcc;
        1402 : data_o <= 8'h66;
        1403 : data_o <= 8'h33;
        1404 : data_o <= 8'h66;
        1405 : data_o <= 8'hcc;
        1406 : data_o <= 8'h00;
        1407 : data_o <= 8'h00;

        // ASCII 176
        1408 : data_o <= 8'h22;
        1409 : data_o <= 8'h88;
        1410 : data_o <= 8'h22;
        1411 : data_o <= 8'h88;
        1412 : data_o <= 8'h22;
        1413 : data_o <= 8'h88;
        1414 : data_o <= 8'h22;
        1415 : data_o <= 8'h88;

        // ASCII 177
        1416 : data_o <= 8'h55;
        1417 : data_o <= 8'haa;
        1418 : data_o <= 8'h55;
        1419 : data_o <= 8'haa;
        1420 : data_o <= 8'h55;
        1421 : data_o <= 8'haa;
        1422 : data_o <= 8'h55;
        1423 : data_o <= 8'haa;

        // ASCII 178
        1424 : data_o <= 8'h77;
        1425 : data_o <= 8'hdd;
        1426 : data_o <= 8'h77;
        1427 : data_o <= 8'hdd;
        1428 : data_o <= 8'h77;
        1429 : data_o <= 8'hdd;
        1430 : data_o <= 8'h77;
        1431 : data_o <= 8'hdd;

        // ASCII 179
        1432 : data_o <= 8'h18;
        1433 : data_o <= 8'h18;
        1434 : data_o <= 8'h18;
        1435 : data_o <= 8'h18;
        1436 : data_o <= 8'h18;
        1437 : data_o <= 8'h18;
        1438 : data_o <= 8'h18;
        1439 : data_o <= 8'h18;

        // ASCII 180
        1440 : data_o <= 8'h18;
        1441 : data_o <= 8'h18;
        1442 : data_o <= 8'h18;
        1443 : data_o <= 8'h18;
        1444 : data_o <= 8'hf8;
        1445 : data_o <= 8'h18;
        1446 : data_o <= 8'h18;
        1447 : data_o <= 8'h18;

        // ASCII 181
        1448 : data_o <= 8'h18;
        1449 : data_o <= 8'h18;
        1450 : data_o <= 8'hf8;
        1451 : data_o <= 8'h18;
        1452 : data_o <= 8'hf8;
        1453 : data_o <= 8'h18;
        1454 : data_o <= 8'h18;
        1455 : data_o <= 8'h18;

        // ASCII 182
        1456 : data_o <= 8'h36;
        1457 : data_o <= 8'h36;
        1458 : data_o <= 8'h36;
        1459 : data_o <= 8'h36;
        1460 : data_o <= 8'hf6;
        1461 : data_o <= 8'h36;
        1462 : data_o <= 8'h36;
        1463 : data_o <= 8'h36;

        // ASCII 183
        1464 : data_o <= 8'h00;
        1465 : data_o <= 8'h00;
        1466 : data_o <= 8'h00;
        1467 : data_o <= 8'h00;
        1468 : data_o <= 8'hfe;
        1469 : data_o <= 8'h36;
        1470 : data_o <= 8'h36;
        1471 : data_o <= 8'h36;

        // ASCII 184
        1472 : data_o <= 8'h00;
        1473 : data_o <= 8'h00;
        1474 : data_o <= 8'hf8;
        1475 : data_o <= 8'h18;
        1476 : data_o <= 8'hf8;
        1477 : data_o <= 8'h18;
        1478 : data_o <= 8'h18;
        1479 : data_o <= 8'h18;

        // ASCII 185
        1480 : data_o <= 8'h36;
        1481 : data_o <= 8'h36;
        1482 : data_o <= 8'hf6;
        1483 : data_o <= 8'h06;
        1484 : data_o <= 8'hf6;
        1485 : data_o <= 8'h36;
        1486 : data_o <= 8'h36;
        1487 : data_o <= 8'h36;

        // ASCII 186
        1488 : data_o <= 8'h36;
        1489 : data_o <= 8'h36;
        1490 : data_o <= 8'h36;
        1491 : data_o <= 8'h36;
        1492 : data_o <= 8'h36;
        1493 : data_o <= 8'h36;
        1494 : data_o <= 8'h36;
        1495 : data_o <= 8'h36;

        // ASCII 187
        1496 : data_o <= 8'h00;
        1497 : data_o <= 8'h00;
        1498 : data_o <= 8'hfe;
        1499 : data_o <= 8'h06;
        1500 : data_o <= 8'hf6;
        1501 : data_o <= 8'h36;
        1502 : data_o <= 8'h36;
        1503 : data_o <= 8'h36;

        // ASCII 188
        1504 : data_o <= 8'h36;
        1505 : data_o <= 8'h36;
        1506 : data_o <= 8'hf6;
        1507 : data_o <= 8'h06;
        1508 : data_o <= 8'hfe;
        1509 : data_o <= 8'h00;
        1510 : data_o <= 8'h00;
        1511 : data_o <= 8'h00;

        // ASCII 189
        1512 : data_o <= 8'h36;
        1513 : data_o <= 8'h36;
        1514 : data_o <= 8'h36;
        1515 : data_o <= 8'h36;
        1516 : data_o <= 8'hfe;
        1517 : data_o <= 8'h00;
        1518 : data_o <= 8'h00;
        1519 : data_o <= 8'h00;

        // ASCII 190
        1520 : data_o <= 8'h18;
        1521 : data_o <= 8'h18;
        1522 : data_o <= 8'hf8;
        1523 : data_o <= 8'h18;
        1524 : data_o <= 8'hf8;
        1525 : data_o <= 8'h00;
        1526 : data_o <= 8'h00;
        1527 : data_o <= 8'h00;

        // ASCII 191
        1528 : data_o <= 8'h00;
        1529 : data_o <= 8'h00;
        1530 : data_o <= 8'h00;
        1531 : data_o <= 8'h00;
        1532 : data_o <= 8'hf8;
        1533 : data_o <= 8'h18;
        1534 : data_o <= 8'h18;
        1535 : data_o <= 8'h18;

        // ASCII 192
        1536 : data_o <= 8'h18;
        1537 : data_o <= 8'h18;
        1538 : data_o <= 8'h18;
        1539 : data_o <= 8'h18;
        1540 : data_o <= 8'h1f;
        1541 : data_o <= 8'h00;
        1542 : data_o <= 8'h00;
        1543 : data_o <= 8'h00;

        // ASCII 193
        1544 : data_o <= 8'h18;
        1545 : data_o <= 8'h18;
        1546 : data_o <= 8'h18;
        1547 : data_o <= 8'h18;
        1548 : data_o <= 8'hff;
        1549 : data_o <= 8'h00;
        1550 : data_o <= 8'h00;
        1551 : data_o <= 8'h00;

        // ASCII 194
        1552 : data_o <= 8'h00;
        1553 : data_o <= 8'h00;
        1554 : data_o <= 8'h00;
        1555 : data_o <= 8'h00;
        1556 : data_o <= 8'hff;
        1557 : data_o <= 8'h18;
        1558 : data_o <= 8'h18;
        1559 : data_o <= 8'h18;

        // ASCII 195
        1560 : data_o <= 8'h18;
        1561 : data_o <= 8'h18;
        1562 : data_o <= 8'h18;
        1563 : data_o <= 8'h18;
        1564 : data_o <= 8'h1f;
        1565 : data_o <= 8'h18;
        1566 : data_o <= 8'h18;
        1567 : data_o <= 8'h18;

        // ASCII 196
        1568 : data_o <= 8'h00;
        1569 : data_o <= 8'h00;
        1570 : data_o <= 8'h00;
        1571 : data_o <= 8'h00;
        1572 : data_o <= 8'hff;
        1573 : data_o <= 8'h00;
        1574 : data_o <= 8'h00;
        1575 : data_o <= 8'h00;

        // ASCII 197
        1576 : data_o <= 8'h18;
        1577 : data_o <= 8'h18;
        1578 : data_o <= 8'h18;
        1579 : data_o <= 8'h18;
        1580 : data_o <= 8'hff;
        1581 : data_o <= 8'h18;
        1582 : data_o <= 8'h18;
        1583 : data_o <= 8'h18;

        // ASCII 198
        1584 : data_o <= 8'h18;
        1585 : data_o <= 8'h18;
        1586 : data_o <= 8'h1f;
        1587 : data_o <= 8'h18;
        1588 : data_o <= 8'h1f;
        1589 : data_o <= 8'h18;
        1590 : data_o <= 8'h18;
        1591 : data_o <= 8'h18;

        // ASCII 199
        1592 : data_o <= 8'h36;
        1593 : data_o <= 8'h36;
        1594 : data_o <= 8'h36;
        1595 : data_o <= 8'h36;
        1596 : data_o <= 8'h37;
        1597 : data_o <= 8'h36;
        1598 : data_o <= 8'h36;
        1599 : data_o <= 8'h36;

        // ASCII 200
        1600 : data_o <= 8'h36;
        1601 : data_o <= 8'h36;
        1602 : data_o <= 8'h37;
        1603 : data_o <= 8'h30;
        1604 : data_o <= 8'h3f;
        1605 : data_o <= 8'h00;
        1606 : data_o <= 8'h00;
        1607 : data_o <= 8'h00;

        // ASCII 201
        1608 : data_o <= 8'h00;
        1609 : data_o <= 8'h00;
        1610 : data_o <= 8'h3f;
        1611 : data_o <= 8'h30;
        1612 : data_o <= 8'h37;
        1613 : data_o <= 8'h36;
        1614 : data_o <= 8'h36;
        1615 : data_o <= 8'h36;

        // ASCII 202
        1616 : data_o <= 8'h36;
        1617 : data_o <= 8'h36;
        1618 : data_o <= 8'hf7;
        1619 : data_o <= 8'h00;
        1620 : data_o <= 8'hff;
        1621 : data_o <= 8'h00;
        1622 : data_o <= 8'h00;
        1623 : data_o <= 8'h00;

        // ASCII 203
        1624 : data_o <= 8'h00;
        1625 : data_o <= 8'h00;
        1626 : data_o <= 8'hff;
        1627 : data_o <= 8'h00;
        1628 : data_o <= 8'hf7;
        1629 : data_o <= 8'h36;
        1630 : data_o <= 8'h36;
        1631 : data_o <= 8'h36;

        // ASCII 204
        1632 : data_o <= 8'h36;
        1633 : data_o <= 8'h36;
        1634 : data_o <= 8'h37;
        1635 : data_o <= 8'h30;
        1636 : data_o <= 8'h37;
        1637 : data_o <= 8'h36;
        1638 : data_o <= 8'h36;
        1639 : data_o <= 8'h36;

        // ASCII 205
        1640 : data_o <= 8'h00;
        1641 : data_o <= 8'h00;
        1642 : data_o <= 8'hff;
        1643 : data_o <= 8'h00;
        1644 : data_o <= 8'hff;
        1645 : data_o <= 8'h00;
        1646 : data_o <= 8'h00;
        1647 : data_o <= 8'h00;

        // ASCII 206
        1648 : data_o <= 8'h36;
        1649 : data_o <= 8'h36;
        1650 : data_o <= 8'hf7;
        1651 : data_o <= 8'h00;
        1652 : data_o <= 8'hf7;
        1653 : data_o <= 8'h36;
        1654 : data_o <= 8'h36;
        1655 : data_o <= 8'h36;

        // ASCII 207
        1656 : data_o <= 8'h18;
        1657 : data_o <= 8'h18;
        1658 : data_o <= 8'hff;
        1659 : data_o <= 8'h00;
        1660 : data_o <= 8'hff;
        1661 : data_o <= 8'h00;
        1662 : data_o <= 8'h00;
        1663 : data_o <= 8'h00;

        // ASCII 208
        1664 : data_o <= 8'h36;
        1665 : data_o <= 8'h36;
        1666 : data_o <= 8'h36;
        1667 : data_o <= 8'h36;
        1668 : data_o <= 8'hff;
        1669 : data_o <= 8'h00;
        1670 : data_o <= 8'h00;
        1671 : data_o <= 8'h00;

        // ASCII 209
        1672 : data_o <= 8'h00;
        1673 : data_o <= 8'h00;
        1674 : data_o <= 8'hff;
        1675 : data_o <= 8'h00;
        1676 : data_o <= 8'hff;
        1677 : data_o <= 8'h18;
        1678 : data_o <= 8'h18;
        1679 : data_o <= 8'h18;

        // ASCII 210
        1680 : data_o <= 8'h00;
        1681 : data_o <= 8'h00;
        1682 : data_o <= 8'h00;
        1683 : data_o <= 8'h00;
        1684 : data_o <= 8'hff;
        1685 : data_o <= 8'h36;
        1686 : data_o <= 8'h36;
        1687 : data_o <= 8'h36;

        // ASCII 211
        1688 : data_o <= 8'h36;
        1689 : data_o <= 8'h36;
        1690 : data_o <= 8'h36;
        1691 : data_o <= 8'h36;
        1692 : data_o <= 8'h3f;
        1693 : data_o <= 8'h00;
        1694 : data_o <= 8'h00;
        1695 : data_o <= 8'h00;

        // ASCII 212
        1696 : data_o <= 8'h18;
        1697 : data_o <= 8'h18;
        1698 : data_o <= 8'h1f;
        1699 : data_o <= 8'h18;
        1700 : data_o <= 8'h1f;
        1701 : data_o <= 8'h00;
        1702 : data_o <= 8'h00;
        1703 : data_o <= 8'h00;

        // ASCII 213
        1704 : data_o <= 8'h00;
        1705 : data_o <= 8'h00;
        1706 : data_o <= 8'h1f;
        1707 : data_o <= 8'h18;
        1708 : data_o <= 8'h1f;
        1709 : data_o <= 8'h18;
        1710 : data_o <= 8'h18;
        1711 : data_o <= 8'h18;

        // ASCII 214
        1712 : data_o <= 8'h00;
        1713 : data_o <= 8'h00;
        1714 : data_o <= 8'h00;
        1715 : data_o <= 8'h00;
        1716 : data_o <= 8'h3f;
        1717 : data_o <= 8'h36;
        1718 : data_o <= 8'h36;
        1719 : data_o <= 8'h36;

        // ASCII 215
        1720 : data_o <= 8'h36;
        1721 : data_o <= 8'h36;
        1722 : data_o <= 8'h36;
        1723 : data_o <= 8'h36;
        1724 : data_o <= 8'hff;
        1725 : data_o <= 8'h36;
        1726 : data_o <= 8'h36;
        1727 : data_o <= 8'h36;

        // ASCII 216
        1728 : data_o <= 8'h18;
        1729 : data_o <= 8'h18;
        1730 : data_o <= 8'hff;
        1731 : data_o <= 8'h18;
        1732 : data_o <= 8'hff;
        1733 : data_o <= 8'h18;
        1734 : data_o <= 8'h18;
        1735 : data_o <= 8'h18;

        // ASCII 217
        1736 : data_o <= 8'h18;
        1737 : data_o <= 8'h18;
        1738 : data_o <= 8'h18;
        1739 : data_o <= 8'h18;
        1740 : data_o <= 8'hf8;
        1741 : data_o <= 8'h00;
        1742 : data_o <= 8'h00;
        1743 : data_o <= 8'h00;

        // ASCII 218
        1744 : data_o <= 8'h00;
        1745 : data_o <= 8'h00;
        1746 : data_o <= 8'h00;
        1747 : data_o <= 8'h00;
        1748 : data_o <= 8'h1f;
        1749 : data_o <= 8'h18;
        1750 : data_o <= 8'h18;
        1751 : data_o <= 8'h18;

        // ASCII 219
        1752 : data_o <= 8'hff;
        1753 : data_o <= 8'hff;
        1754 : data_o <= 8'hff;
        1755 : data_o <= 8'hff;
        1756 : data_o <= 8'hff;
        1757 : data_o <= 8'hff;
        1758 : data_o <= 8'hff;
        1759 : data_o <= 8'hff;

        // ASCII 220
        1760 : data_o <= 8'h00;
        1761 : data_o <= 8'h00;
        1762 : data_o <= 8'h00;
        1763 : data_o <= 8'h00;
        1764 : data_o <= 8'hff;
        1765 : data_o <= 8'hff;
        1766 : data_o <= 8'hff;
        1767 : data_o <= 8'hff;

        // ASCII 221
        1768 : data_o <= 8'hf0;
        1769 : data_o <= 8'hf0;
        1770 : data_o <= 8'hf0;
        1771 : data_o <= 8'hf0;
        1772 : data_o <= 8'hf0;
        1773 : data_o <= 8'hf0;
        1774 : data_o <= 8'hf0;
        1775 : data_o <= 8'hf0;

        // ASCII 222
        1776 : data_o <= 8'h0f;
        1777 : data_o <= 8'h0f;
        1778 : data_o <= 8'h0f;
        1779 : data_o <= 8'h0f;
        1780 : data_o <= 8'h0f;
        1781 : data_o <= 8'h0f;
        1782 : data_o <= 8'h0f;
        1783 : data_o <= 8'h0f;

        // ASCII 223
        1784 : data_o <= 8'hff;
        1785 : data_o <= 8'hff;
        1786 : data_o <= 8'hff;
        1787 : data_o <= 8'hff;
        1788 : data_o <= 8'h00;
        1789 : data_o <= 8'h00;
        1790 : data_o <= 8'h00;
        1791 : data_o <= 8'h00;

        // ASCII 224
        1792 : data_o <= 8'h00;
        1793 : data_o <= 8'h00;
        1794 : data_o <= 8'h76;
        1795 : data_o <= 8'hdc;
        1796 : data_o <= 8'hc8;
        1797 : data_o <= 8'hdc;
        1798 : data_o <= 8'h76;
        1799 : data_o <= 8'h00;

        // ASCII 225
        1800 : data_o <= 8'h78;
        1801 : data_o <= 8'hcc;
        1802 : data_o <= 8'hcc;
        1803 : data_o <= 8'hd8;
        1804 : data_o <= 8'hcc;
        1805 : data_o <= 8'hc6;
        1806 : data_o <= 8'hcc;
        1807 : data_o <= 8'h00;

        // ASCII 226
        1808 : data_o <= 8'hfe;
        1809 : data_o <= 8'hc6;
        1810 : data_o <= 8'hc0;
        1811 : data_o <= 8'hc0;
        1812 : data_o <= 8'hc0;
        1813 : data_o <= 8'hc0;
        1814 : data_o <= 8'hc0;
        1815 : data_o <= 8'h00;

        // ASCII 227
        1816 : data_o <= 8'h00;
        1817 : data_o <= 8'h00;
        1818 : data_o <= 8'hfe;
        1819 : data_o <= 8'h6c;
        1820 : data_o <= 8'h6c;
        1821 : data_o <= 8'h6c;
        1822 : data_o <= 8'h6c;
        1823 : data_o <= 8'h00;

        // ASCII 228
        1824 : data_o <= 8'hfe;
        1825 : data_o <= 8'hc6;
        1826 : data_o <= 8'h60;
        1827 : data_o <= 8'h30;
        1828 : data_o <= 8'h60;
        1829 : data_o <= 8'hc6;
        1830 : data_o <= 8'hfe;
        1831 : data_o <= 8'h00;

        // ASCII 229
        1832 : data_o <= 8'h00;
        1833 : data_o <= 8'h00;
        1834 : data_o <= 8'h7e;
        1835 : data_o <= 8'hd8;
        1836 : data_o <= 8'hd8;
        1837 : data_o <= 8'hd8;
        1838 : data_o <= 8'h70;
        1839 : data_o <= 8'h00;

        // ASCII 230
        1840 : data_o <= 8'h00;
        1841 : data_o <= 8'h00;
        1842 : data_o <= 8'h66;
        1843 : data_o <= 8'h66;
        1844 : data_o <= 8'h66;
        1845 : data_o <= 8'h66;
        1846 : data_o <= 8'h7c;
        1847 : data_o <= 8'hc0;

        // ASCII 231
        1848 : data_o <= 8'h00;
        1849 : data_o <= 8'h76;
        1850 : data_o <= 8'hdc;
        1851 : data_o <= 8'h18;
        1852 : data_o <= 8'h18;
        1853 : data_o <= 8'h18;
        1854 : data_o <= 8'h18;
        1855 : data_o <= 8'h00;

        // ASCII 232
        1856 : data_o <= 8'h7e;
        1857 : data_o <= 8'h18;
        1858 : data_o <= 8'h3c;
        1859 : data_o <= 8'h66;
        1860 : data_o <= 8'h66;
        1861 : data_o <= 8'h3c;
        1862 : data_o <= 8'h18;
        1863 : data_o <= 8'h7e;

        // ASCII 233
        1864 : data_o <= 8'h38;
        1865 : data_o <= 8'h6c;
        1866 : data_o <= 8'hc6;
        1867 : data_o <= 8'hfe;
        1868 : data_o <= 8'hc6;
        1869 : data_o <= 8'h6c;
        1870 : data_o <= 8'h38;
        1871 : data_o <= 8'h00;

        // ASCII 234
        1872 : data_o <= 8'h38;
        1873 : data_o <= 8'h6c;
        1874 : data_o <= 8'hc6;
        1875 : data_o <= 8'hc6;
        1876 : data_o <= 8'h6c;
        1877 : data_o <= 8'h6c;
        1878 : data_o <= 8'hee;
        1879 : data_o <= 8'h00;

        // ASCII 235
        1880 : data_o <= 8'h0e;
        1881 : data_o <= 8'h18;
        1882 : data_o <= 8'h0c;
        1883 : data_o <= 8'h3e;
        1884 : data_o <= 8'h66;
        1885 : data_o <= 8'h66;
        1886 : data_o <= 8'h3c;
        1887 : data_o <= 8'h00;

        // ASCII 236
        1888 : data_o <= 8'h00;
        1889 : data_o <= 8'h00;
        1890 : data_o <= 8'h7e;
        1891 : data_o <= 8'hdb;
        1892 : data_o <= 8'hdb;
        1893 : data_o <= 8'h7e;
        1894 : data_o <= 8'h00;
        1895 : data_o <= 8'h00;

        // ASCII 237
        1896 : data_o <= 8'h06;
        1897 : data_o <= 8'h0c;
        1898 : data_o <= 8'h7e;
        1899 : data_o <= 8'hdb;
        1900 : data_o <= 8'hdb;
        1901 : data_o <= 8'h7e;
        1902 : data_o <= 8'h60;
        1903 : data_o <= 8'hc0;

        // ASCII 238
        1904 : data_o <= 8'h1e;
        1905 : data_o <= 8'h30;
        1906 : data_o <= 8'h60;
        1907 : data_o <= 8'h7e;
        1908 : data_o <= 8'h60;
        1909 : data_o <= 8'h30;
        1910 : data_o <= 8'h1e;
        1911 : data_o <= 8'h00;

        // ASCII 239
        1912 : data_o <= 8'h00;
        1913 : data_o <= 8'h7c;
        1914 : data_o <= 8'hc6;
        1915 : data_o <= 8'hc6;
        1916 : data_o <= 8'hc6;
        1917 : data_o <= 8'hc6;
        1918 : data_o <= 8'hc6;
        1919 : data_o <= 8'h00;

        // ASCII 240
        1920 : data_o <= 8'h00;
        1921 : data_o <= 8'hfe;
        1922 : data_o <= 8'h00;
        1923 : data_o <= 8'hfe;
        1924 : data_o <= 8'h00;
        1925 : data_o <= 8'hfe;
        1926 : data_o <= 8'h00;
        1927 : data_o <= 8'h00;

        // ASCII 241
        1928 : data_o <= 8'h18;
        1929 : data_o <= 8'h18;
        1930 : data_o <= 8'h7e;
        1931 : data_o <= 8'h18;
        1932 : data_o <= 8'h18;
        1933 : data_o <= 8'h00;
        1934 : data_o <= 8'h7e;
        1935 : data_o <= 8'h00;

        // ASCII 242
        1936 : data_o <= 8'h30;
        1937 : data_o <= 8'h18;
        1938 : data_o <= 8'h0c;
        1939 : data_o <= 8'h18;
        1940 : data_o <= 8'h30;
        1941 : data_o <= 8'h00;
        1942 : data_o <= 8'h7e;
        1943 : data_o <= 8'h00;

        // ASCII 243
        1944 : data_o <= 8'h0c;
        1945 : data_o <= 8'h18;
        1946 : data_o <= 8'h30;
        1947 : data_o <= 8'h18;
        1948 : data_o <= 8'h0c;
        1949 : data_o <= 8'h00;
        1950 : data_o <= 8'h7e;
        1951 : data_o <= 8'h00;

        // ASCII 244
        1952 : data_o <= 8'h0e;
        1953 : data_o <= 8'h1b;
        1954 : data_o <= 8'h1b;
        1955 : data_o <= 8'h18;
        1956 : data_o <= 8'h18;
        1957 : data_o <= 8'h18;
        1958 : data_o <= 8'h18;
        1959 : data_o <= 8'h18;

        // ASCII 245
        1960 : data_o <= 8'h18;
        1961 : data_o <= 8'h18;
        1962 : data_o <= 8'h18;
        1963 : data_o <= 8'h18;
        1964 : data_o <= 8'h18;
        1965 : data_o <= 8'hd8;
        1966 : data_o <= 8'hd8;
        1967 : data_o <= 8'h70;

        // ASCII 246
        1968 : data_o <= 8'h00;
        1969 : data_o <= 8'h18;
        1970 : data_o <= 8'h00;
        1971 : data_o <= 8'h7e;
        1972 : data_o <= 8'h00;
        1973 : data_o <= 8'h18;
        1974 : data_o <= 8'h00;
        1975 : data_o <= 8'h00;

        // ASCII 247
        1976 : data_o <= 8'h00;
        1977 : data_o <= 8'h76;
        1978 : data_o <= 8'hdc;
        1979 : data_o <= 8'h00;
        1980 : data_o <= 8'h76;
        1981 : data_o <= 8'hdc;
        1982 : data_o <= 8'h00;
        1983 : data_o <= 8'h00;

        // ASCII 248
        1984 : data_o <= 8'h38;
        1985 : data_o <= 8'h6c;
        1986 : data_o <= 8'h6c;
        1987 : data_o <= 8'h38;
        1988 : data_o <= 8'h00;
        1989 : data_o <= 8'h00;
        1990 : data_o <= 8'h00;
        1991 : data_o <= 8'h00;

        // ASCII 249
        1992 : data_o <= 8'h00;
        1993 : data_o <= 8'h00;
        1994 : data_o <= 8'h00;
        1995 : data_o <= 8'h18;
        1996 : data_o <= 8'h18;
        1997 : data_o <= 8'h00;
        1998 : data_o <= 8'h00;
        1999 : data_o <= 8'h00;

        // ASCII 250
        2000 : data_o <= 8'h00;
        2001 : data_o <= 8'h00;
        2002 : data_o <= 8'h00;
        2003 : data_o <= 8'h18;
        2004 : data_o <= 8'h00;
        2005 : data_o <= 8'h00;
        2006 : data_o <= 8'h00;
        2007 : data_o <= 8'h00;

        // ASCII 251
        2008 : data_o <= 8'h0f;
        2009 : data_o <= 8'h0c;
        2010 : data_o <= 8'h0c;
        2011 : data_o <= 8'h0c;
        2012 : data_o <= 8'hec;
        2013 : data_o <= 8'h6c;
        2014 : data_o <= 8'h3c;
        2015 : data_o <= 8'h1c;

        // ASCII 252
        2016 : data_o <= 8'h6c;
        2017 : data_o <= 8'h36;
        2018 : data_o <= 8'h36;
        2019 : data_o <= 8'h36;
        2020 : data_o <= 8'h36;
        2021 : data_o <= 8'h00;
        2022 : data_o <= 8'h00;
        2023 : data_o <= 8'h00;

        // ASCII 253
        2024 : data_o <= 8'h78;
        2025 : data_o <= 8'h0c;
        2026 : data_o <= 8'h18;
        2027 : data_o <= 8'h30;
        2028 : data_o <= 8'h7c;
        2029 : data_o <= 8'h00;
        2030 : data_o <= 8'h00;
        2031 : data_o <= 8'h00;

        // ASCII 254
        2032 : data_o <= 8'h00;
        2033 : data_o <= 8'h00;
        2034 : data_o <= 8'h3c;
        2035 : data_o <= 8'h3c;
        2036 : data_o <= 8'h3c;
        2037 : data_o <= 8'h3c;
        2038 : data_o <= 8'h00;
        2039 : data_o <= 8'h00;

        // ASCII 255
        2040 : data_o <= 8'h00;
        2041 : data_o <= 8'h00;
        2042 : data_o <= 8'h00;
        2043 : data_o <= 8'h00;
        2044 : data_o <= 8'h00;
        2045 : data_o <= 8'h00;
        2046 : data_o <= 8'h00;
        2047 : data_o <= 8'h00;

      endcase
    end
  end
endmodule
