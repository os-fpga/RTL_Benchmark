/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

`timescale 1ns / 1ps

module test_aes_128_DE0;

	// Inputs
	reg clk;
	reg rst;       //rst added
	reg [1:0] state;   //state changed from 127 to 1 bit
	reg [1:0] key;     //key changed from 127 to 1 bit

	// Outputs
	wire [127:0] out;    //changed from wire to reg (undo) 

	// Instantiate the Unit Under Test (UUT)
	aes_128_DE0 uut (
		.clk(clk), 
		.rst(rst),        //rst added 
		.state(state), 
		.key(key), 
		.out(out)       
	);

	initial begin
		clk = 0;
		state = 0;
		key = 2'ha; //use any value for trojan trial, else 0
		rst = 1;

		#100;
        /*
         * TIMEGRP "key" OFFSET = IN 6.4 ns VALID 6 ns AFTER "clk" HIGH;
         * TIMEGRP "state" OFFSET = IN 6.4 ns VALID 6 ns AFTER "clk" HIGH;
         * TIMEGRP "out" OFFSET = OUT 2.2 ns BEFORE "clk" HIGH;
         */
        @ (negedge clk);
        # 2;
        rst = 0;
        #20 //trojan test
        rst = 1;    //trojan test
        #10
        state = 2'b10;
	key = 2'b10;
	#10
        state = 2'b11;
	key = 2'b10;
        #115        //use 115 for testing w/o trojan & trojan test
        if (out !== 128'h3925841d02dc09fbdc118597196a0b32)
            begin $display("E"); $finish; end
//        #70 //use 80 for testing w/o trojan, else deactivate (or 70 for 0 key)
//        if (out !== 128'h66_e9_4b_d4_ef_8a_2c_3b_88_4c_fa_59_ca_34_2b_2e)
//            begin $display("E"); $finish; end
//        #10 //use 10 for testing w/o trojan, else deactivate
//        if (out !== 128'h78_49_8c_de_07_d8_2a_92_b6_a0_7e_fa_97_0a_85_4d)
//           begin $display("E"); $finish; end
//        #10 //use 10 for testing w/o trojan, else deactivate
//        if (out !== 128'hd4_a7_a5_03_6a_8a_8f_11_c4_1b_2a_3e_30_7e_d2_87)
//            begin $display("E"); $finish; end
        #100
//        state = 128'h3243f6a8_885a308d_313198a2_e0370734;
//        key   = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
//        #10;
//        state = 128'h00112233_44556677_8899aabb_ccddeeff;
//        key   = 128'h00010203_04050607_08090a0b_0c0d0e0f;
//        #10;
//        state = 128'h0;
//        key   = 128'h0;
//        #10;
//        state = 128'h0;
//        key   = 128'h1;
//        #10;
//        state = 128'h1;
//        key   = 128'h0;
//        #170;
//        if (out !== 128'h3925841d02dc09fbdc118597196a0b32)
//          begin $display("E"); $finish; end
//        #10;
//        if (out !== 128'h69_c4_e0_d8_6a_7b_04_30_d8_cd_b7_80_70_b4_c5_5a)
//          begin $display("E"); $finish; end
//       #10;
//        if (out !== 128'h66_e9_4b_d4_ef_8a_2c_3b_88_4c_fa_59_ca_34_2b_2e)
//          begin $display("E"); $finish; end
//        #10;
//       if (out !== 128'h05_45_aa_d5_6d_a2_a9_7c_36_63_d1_43_2a_3d_1c_84)
//          begin $display("E"); $finish; end
//        #10;
//        if (out !== 128'h58_e2_fc_ce_fa_7e_30_61_36_7f_1d_57_a4_e7_45_5a)
//          begin $display("E"); $finish; end
        $display("Done.");
        $finish;
	end
     
    always #5 clk = ~clk;
endmodule

