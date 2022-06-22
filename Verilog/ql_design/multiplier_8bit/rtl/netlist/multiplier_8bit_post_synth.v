/* Generated by Yosys 0.16+65 (git sha1 051517d61, gcc 9.1.0 -fPIC -Os) */

module multiplier_8bit(a_in, b_in, prod);
  wire _000_;
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  input [7:0] a_in;
  wire [7:0] a_in;
  input [7:0] b_in;
  wire [7:0] b_in;
  output [15:0] prod;
  wire [15:0] prod;
  assign prod[0] = 4'b1000 >> { b_in[0], a_in[0] };
  assign _017_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { a_in[0], b_in[2], b_in[0], a_in[2:1], b_in[1] };
  assign _018_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { a_in[2], b_in[1], a_in[1], b_in[2], b_in[0], a_in[3] };
  assign _019_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { b_in[1], a_in[3], b_in[0], a_in[2], b_in[2], a_in[4] };
  assign _020_ = 64'b1000011101110111011110001000100001111000100010001000011101110111 >> { _019_, _018_, a_in[1], b_in[3], a_in[0], b_in[4] };
  assign _021_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { a_in[2], b_in[1:0], a_in[1], b_in[2], a_in[3] };
  assign _022_ = 32'd2415919104 >> { b_in[1], prod[0], a_in[1], a_in[2], b_in[2] };
  assign _023_ = 64'b0000001000101011001010110010101110111111111111111111111111111111 >> { _020_, b_in[3], a_in[0], _022_, _017_, _021_ };
  assign _024_ = 64'b0010101110111011101100100010001010110010001000101011001000100010 >> { a_in[1], b_in[3], a_in[0], b_in[4], _019_, _018_ };
  assign _025_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { b_in[0], a_in[4], a_in[2], b_in[2:1], a_in[3] };
  assign _026_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { b_in[2], a_in[3], b_in[0], b_in[1], a_in[4], a_in[5] };
  assign _027_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { a_in[1], b_in[4], a_in[0], a_in[2], b_in[3], b_in[5] };
  assign _028_ = 8'b01101001 >> { _027_, _026_, _025_ };
  assign _029_ = 16'b1000000000000000 >> { a_in[0], b_in[3], a_in[1], b_in[4] };
  assign prod[5] = 16'b0110100110010110 >> { _029_, _028_, _024_, _023_ };
  assign prod[1] = 16'b0111100010001000 >> { a_in[0], b_in[1:0], a_in[1] };
  assign prod[2] = 64'b0000111111110000011110000111100001110111100010001000100010001000 >> { a_in[0], b_in[0], a_in[2], b_in[2], a_in[1], b_in[1] };
  assign prod[3] = 32'd2272819335 >> { _021_, _022_, _017_, a_in[0], b_in[3] };
  assign prod[4] = 64'b0000011110000000011111110000011111111000011111111000000011111000 >> { _020_, _017_, _021_, _022_, a_in[0], b_in[3] };
  assign _030_ = 8'b10110010 >> { _027_, _025_, _026_ };
  assign _031_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { a_in[0], b_in[5], a_in[1], b_in[4], a_in[2], b_in[3] };
  assign _032_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { b_in[0], a_in[5], b_in[1], a_in[4], b_in[2], a_in[3] };
  assign _033_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { a_in[1], b_in[5], a_in[2], b_in[3], a_in[3], b_in[4] };
  assign _034_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { b_in[1], a_in[5], b_in[0], b_in[2], a_in[4], a_in[6] };
  assign _035_ = 8'b01101001 >> { _034_, _033_, _032_ };
  assign _036_ = 32'd2022147960 >> { _031_, _035_, _030_, a_in[0], b_in[6] };
  assign prod[6] = 32'd412018545 >> { _036_, _024_, _029_, _028_, _023_ };
  assign _037_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { b_in[1], a_in[5], b_in[0], a_in[6], b_in[2], a_in[4] };
  assign _038_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { b_in[1], a_in[6], b_in[0], b_in[2], a_in[5], a_in[7] };
  assign _039_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { b_in[4], a_in[3:2], a_in[4], b_in[3], b_in[5] };
  assign _040_ = 8'b01101001 >> { _039_, _038_, _037_ };
  assign _041_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { a_in[1], b_in[5], a_in[2], b_in[4:3], a_in[3] };
  assign _042_ = 32'd2022213495 >> { _041_, a_in[1], b_in[6], a_in[0], b_in[7] };
  assign _043_ = 32'd2389799310 >> { _042_, _040_, _032_, _034_, _033_ };
  assign _044_ = 64'b0111000000001000111101110111000010001111111101110000100010001111 >> { _043_, _031_, _035_, _030_, a_in[0], b_in[6] };
  assign _045_ = 32'd143585279 >> { _036_, _024_, _029_, _028_, _023_ };
  assign prod[7] = 4'b0110 >> { _045_, _044_ };
  assign _046_ = 32'd360644951 >> { _032_, _040_, _034_, _033_, _042_ };
  assign _047_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { b_in[0], a_in[7], b_in[1], a_in[6], b_in[2], a_in[5] };
  assign _048_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { a_in[4], b_in[4], b_in[5], a_in[5], b_in[3], a_in[3] };
  assign _049_ = 64'b1000011101110111011110001000100001111000100010001000011101110111 >> { _048_, _047_, a_in[7], b_in[1], a_in[6], b_in[2] };
  assign _050_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { a_in[2], b_in[5], a_in[4], b_in[3], b_in[4], a_in[3] };
  assign _051_ = 32'd2022213495 >> { _050_, a_in[2], b_in[6], a_in[1], b_in[7] };
  assign _052_ = 32'd2389799310 >> { _049_, _051_, _037_, _039_, _038_ };
  assign _053_ = 32'd3934290048 >> { a_in[0], b_in[7:6], a_in[1], _041_ };
  assign _054_ = 64'b1110111111111111111111111111111100001000100011101000111010001110 >> { _043_, b_in[6], a_in[0], _031_, _035_, _030_ };
  assign prod[8] = 64'b1110000100011110000111101110000100011110111000011110000100011110 >> { _053_, _052_, _046_, _054_, _045_, _044_ };
  assign _055_ = 64'b0101011100000001000000010101011100000001010101110101011100000001 >> { _053_, _052_, _046_, _045_, _044_, _054_ };
  assign _056_ = 8'b11101000 >> { _046_, _053_, _052_ };
  assign _057_ = 32'd3934290048 >> { a_in[2], b_in[6], a_in[1], b_in[7], _050_ };
  assign _058_ = 64'b0010101110111011101100100010001010110010001000101011001000100010 >> { a_in[7], b_in[1], a_in[6], b_in[2], _048_, _047_ };
  assign _059_ = 16'b1000011101110111 >> { b_in[5], a_in[4], b_in[4], a_in[5] };
  assign _060_ = 64'b0100000000111111101111110011111110111111110000000100000011000000 >> { _059_, b_in[3], a_in[6], a_in[7], b_in[2:1] };
  assign _061_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { a_in[4], b_in[4], a_in[5], b_in[3], b_in[5], a_in[3] };
  assign _062_ = 4'b1000 >> { b_in[6], a_in[3] };
  assign _063_ = 4'b1000 >> { a_in[2], b_in[7] };
  assign _064_ = 32'd1771476585 >> { _063_, _062_, _061_, _060_, _058_ };
  assign _065_ = 32'd2136413441 >> { _049_, _037_, _039_, _038_, _051_ };
  assign prod[9] = 32'd2523490710 >> { _065_, _064_, _057_, _056_, _055_ };
  assign _066_ = 64'b1110101100001111000000000000000000000000000000000000000000000000 >> { b_in[2], a_in[7:6], _059_, b_in[3], b_in[1] };
  assign _067_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { b_in[5], a_in[4], b_in[4], a_in[5], a_in[6], b_in[3] };
  assign _068_ = 64'b0110101011000000100101010011111110010101001111111001010100111111 >> { a_in[6], b_in[4], a_in[7], b_in[5], a_in[5], b_in[3] };
  assign _069_ = 4'b1000 >> { b_in[7], a_in[3] };
  assign _070_ = 4'b1000 >> { a_in[4], b_in[6] };
  assign _071_ = 32'd2523490710 >> { _070_, _069_, _068_, _067_, _066_ };
  assign _072_ = 64'b1101010001000010010000100010101100101011101111011011110111010100 >> { _071_, _062_, _063_, _058_, _061_, _060_ };
  assign prod[10] = 64'b0001011101111110011111101110100011101000100000011000000100010111 >> { _072_, _064_, _057_, _055_, _065_, _056_ };
  assign _000_ = 64'b1110100010000000100000000000000011111111111111101111111011101000 >> { _072_, _064_, _057_, _055_, _065_, _056_ };
  assign _001_ = 64'b1101010001000000010000000000000011111111111111011111110111010100 >> { _071_, _063_, _058_, _062_, _061_, _060_ };
  assign _002_ = 64'b1111100010001000100000000000000010000000000000001000000000000000 >> { a_in[6], b_in[4], b_in[5], a_in[5], a_in[7], b_in[3] };
  assign _003_ = 16'b1000011101110111 >> { a_in[7], b_in[4], a_in[6], b_in[5] };
  assign _004_ = 4'b1000 >> { b_in[7], a_in[4] };
  assign _005_ = 32'd2272819335 >> { _004_, _003_, _002_, a_in[5], b_in[6] };
  assign _006_ = 64'b0100110111011011110110111011001010110010001001000010010001001101 >> { _005_, _069_, _070_, _066_, _068_, _067_ };
  assign prod[11] = 8'b01101001 >> { _006_, _001_, _000_ };
  assign _007_ = 64'b1111111111111011111110111011001010110010001000000010000000000000 >> { _005_, _069_, _070_, _066_, _068_, _067_ };
  assign _008_ = 4'b1000 >> { b_in[7], a_in[5] };
  assign _009_ = 64'b1011110011001100011100000000000001000011001100111000111111111111 >> { _008_, b_in[6], a_in[7], b_in[5], a_in[6], b_in[4] };
  assign _010_ = 64'b1111011110001111100011110000100000001000011100000111000011110111 >> { _009_, _002_, _004_, _003_, a_in[5], b_in[6] };
  assign prod[12] = 32'd2991410610 >> { _007_, _010_, _000_, _006_, _001_ };
  assign _011_ = 32'd4021193224 >> { _007_, _000_, _006_, _001_, _010_ };
  assign _012_ = 64'b1011111111111111111111111111111100000010001010110010101100101011 >> { _009_, b_in[6], a_in[5], _004_, _002_, _003_ };
  assign _013_ = 64'b0111111011110000110000000000000011000000000000001100000000000000 >> { a_in[7], b_in[5], a_in[6], _008_, b_in[6], b_in[4] };
  assign _014_ = 16'b1000011101110111 >> { a_in[7], b_in[6], b_in[7], a_in[6] };
  assign prod[13] = 16'b0110100110010110 >> { _014_, _013_, _012_, _011_ };
  assign _015_ = 64'b0111000011110011111101011111111111110101111111111111010111111111 >> { a_in[7], b_in[5], b_in[6], _014_, b_in[4], _008_ };
  assign _016_ = 32'd3590126815 >> { _014_, _012_, _013_, _011_, _015_ };
  assign prod[14] = 32'd2415882240 >> { _016_, b_in[7], a_in[7:6], b_in[6] };
  assign prod[15] = 32'd4160749568 >> { a_in[7], b_in[7], _016_, a_in[6], b_in[6] };
endmodule