/**
 * AES-128-ECB Encoder module
 *
 *  Copyright 2020 by Vyacheslav Gulyaev <v.gulyaev181@gmail.com>
 *
 *  Licensed under GNU General Public License 3.0 or later. 
 *  Some rights reserved. See COPYING, AUTHORS.
 *
 * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
 */

module aes128_enc(
                    input clk_i,
                    input rstn_i,
                    
                    input [127:0] data_i,
                    input [127:0] key_i,
                    input         valid_i,
                    

                    output logic [127:0] data_o,
                    output logic         valid_o
                    
               );

    //`define DEBUG_MODE 
    
    localparam logic [7:0] Sbox[0:15][0:15] = '{/*           0      1      2      3      4      5      6      7      8      9      A      B      C      D      E      F    */
                                                /*0*/    '{8'h63, 8'h7c, 8'h77, 8'h7b, 8'hf2, 8'h6b, 8'h6f, 8'hc5, 8'h30, 8'h01, 8'h67, 8'h2b, 8'hfe, 8'hd7, 8'hab, 8'h76},
                                                /*1*/    '{8'hca, 8'h82, 8'hc9, 8'h7d, 8'hfa, 8'h59, 8'h47, 8'hf0, 8'had, 8'hd4, 8'ha2, 8'haf, 8'h9c, 8'ha4, 8'h72, 8'hc0},
                                                /*2*/    '{8'hb7, 8'hfd, 8'h93, 8'h26, 8'h36, 8'h3f, 8'hf7, 8'hcc, 8'h34, 8'ha5, 8'he5, 8'hf1, 8'h71, 8'hd8, 8'h31, 8'h15},
                                                /*3*/    '{8'h04, 8'hc7, 8'h23, 8'hc3, 8'h18, 8'h96, 8'h05, 8'h9a, 8'h07, 8'h12, 8'h80, 8'he2, 8'heb, 8'h27, 8'hb2, 8'h75},
                                                /*4*/    '{8'h09, 8'h83, 8'h2c, 8'h1a, 8'h1b, 8'h6e, 8'h5a, 8'ha0, 8'h52, 8'h3b, 8'hd6, 8'hb3, 8'h29, 8'he3, 8'h2f, 8'h84},
                                                /*5*/    '{8'h53, 8'hd1, 8'h00, 8'hed, 8'h20, 8'hfc, 8'hb1, 8'h5b, 8'h6a, 8'hcb, 8'hbe, 8'h39, 8'h4a, 8'h4c, 8'h58, 8'hcf},
                                                /*6*/    '{8'hd0, 8'hef, 8'haa, 8'hfb, 8'h43, 8'h4d, 8'h33, 8'h85, 8'h45, 8'hf9, 8'h02, 8'h7f, 8'h50, 8'h3c, 8'h9f, 8'ha8},
                                                /*7*/    '{8'h51, 8'ha3, 8'h40, 8'h8f, 8'h92, 8'h9d, 8'h38, 8'hf5, 8'hbc, 8'hb6, 8'hda, 8'h21, 8'h10, 8'hff, 8'hf3, 8'hd2},
                                                /*8*/    '{8'hcd, 8'h0c, 8'h13, 8'hec, 8'h5f, 8'h97, 8'h44, 8'h17, 8'hc4, 8'ha7, 8'h7e, 8'h3d, 8'h64, 8'h5d, 8'h19, 8'h73},
                                                /*9*/    '{8'h60, 8'h81, 8'h4f, 8'hdc, 8'h22, 8'h2a, 8'h90, 8'h88, 8'h46, 8'hee, 8'hb8, 8'h14, 8'hde, 8'h5e, 8'h0b, 8'hdb},
                                                /*A*/    '{8'he0, 8'h32, 8'h3a, 8'h0a, 8'h49, 8'h06, 8'h24, 8'h5c, 8'hc2, 8'hd3, 8'hac, 8'h62, 8'h91, 8'h95, 8'he4, 8'h79},
                                                /*B*/    '{8'he7, 8'hc8, 8'h37, 8'h6d, 8'h8d, 8'hd5, 8'h4e, 8'ha9, 8'h6c, 8'h56, 8'hf4, 8'hea, 8'h65, 8'h7a, 8'hae, 8'h08},
                                                /*C*/    '{8'hba, 8'h78, 8'h25, 8'h2e, 8'h1c, 8'ha6, 8'hb4, 8'hc6, 8'he8, 8'hdd, 8'h74, 8'h1f, 8'h4b, 8'hbd, 8'h8b, 8'h8a},
                                                /*D*/    '{8'h70, 8'h3e, 8'hb5, 8'h66, 8'h48, 8'h03, 8'hf6, 8'h0e, 8'h61, 8'h35, 8'h57, 8'hb9, 8'h86, 8'hc1, 8'h1d, 8'h9e},
                                                /*E*/    '{8'he1, 8'hf8, 8'h98, 8'h11, 8'h69, 8'hd9, 8'h8e, 8'h94, 8'h9b, 8'h1e, 8'h87, 8'he9, 8'hce, 8'h55, 8'h28, 8'hdf},
                                                /*F*/    '{8'h8c, 8'ha1, 8'h89, 8'h0d, 8'hbf, 8'he6, 8'h42, 8'h68, 8'h41, 8'h99, 8'h2d, 8'h0f, 8'hb0, 8'h54, 8'hbb, 8'h16}
                                                };
    
    localparam logic [7:0] Rcon[0:3][0:9] = '{
                                                 '{8'h01, 8'h02, 8'h04, 8'h08, 8'h10, 8'h20, 8'h40, 8'h80, 8'h1b, 8'h36},
                                                 '{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00},
                                                 '{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00},
                                                 '{8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00}
                                             };    
    
    typedef logic [7:0] state_t [0:3] [0:3];
    state_t state;
    state_t round_key;
    
    logic [127:0] data_int;
    logic [3:0]   round;
    logic         busy;

    ////////////////////////////////////////
    /*
     * Implementation of functions area start
     */
    
    /*Transform functions 128-bit(16byte) vector to byte state matrix 4x4 and back
     *[15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0] <==>  | 15  11   7  3 |
     *                                              | 14  10   6  2 |
     *                                              | 13   9   5  1 |
     *                                              | 12   8   4  0 |
     */ 
    function state_t vect_to_matrix(input logic [127:0] data);
        state_t state_o;
        state_o      ='{ '{data[127:120], data[95:88], data[63:56], data[31:24]},
                         '{data[119:112], data[87:80], data[55:48], data[23:16]},
                         '{data[111:104], data[79:72], data[47:40], data[15: 8]},
                         '{data[103: 96], data[71:64], data[39:32], data[ 7: 0]}
                        };
        return state_o;
    endfunction

    function logic [127:0] matrix_to_vector(input state_t st);
        logic [127:0] d_o;
        d_o = {    st[0][0], st[1][0], st[2][0], st[3][0],
                   st[0][1], st[1][1], st[2][1], st[3][1],
                   st[0][2], st[1][2], st[2][2], st[3][2],
                   st[0][3], st[1][3], st[2][3], st[3][3]
              };
        return d_o;
    endfunction
    
    /*
     * Replase data in state matrix with data from Sbox(2^8) table 
     */
    function state_t sub_bytes(input state_t st);
        logic [3:0] r_gf;
        logic [3:0] c_gf;
        state_t state_o;
        for (int r=0; r<4; r=r+1) begin
            for (int c=0; c<4; c=c+1) begin
                r_gf = st[r][c][7:4];
                c_gf = st[r][c][3:0];
                state_o[r][c] = Sbox[r_gf][c_gf];
            end
        end
        //void'(debug_output("After sub bytes", state_o));
        return state_o;
    endfunction
    
    /*
     * Cyclic shift bytes in state matrix rows
     */
    function state_t shift_rows(input state_t st);
        state_t state_o;
        state_o = '{'{st[0][0], st[0][1], st[0][2], st[0][3]},
                    '{st[1][1], st[1][2], st[1][3], st[1][0]},
                    '{st[2][2], st[2][3], st[2][0], st[2][1]},
                    '{st[3][3], st[3][0], st[3][1], st[3][2]}
                    }; 
        //void'(debug_output("After shift rows", state_o));
        return state_o;
    endfunction
    
    /*
     * Multiplication by 2: 1-bit shift left + xor 8'h1b (if val[7]==1)
     */
    function logic [7:0] mul2(input logic [7:0] val);
        return (({val[6:0], 1'b0}) ^ (val[7] ? 8'h1b : 8'h00));
    endfunction
    
    /*
     * Multiplication by 3: mul2 + val ('+' is xor operation)
     */
    function logic [7:0] mul3(input logic [7:0] val);
        return (mul2(val) ^ val);
    endfunction
    
    /* Mix column algorithm is multiplication matrix on column vector
     * | s'[0,c] | = | 02 03 01 01 | * | s[0,c] |
     * | s'[1.c] |   | 01 02 03 01 |   | s[1,c] |
     * | s'[2,c] |   | 01 01 02 03 |   | s[2,c] |
     * | s'[3,c] |   | 03 01 01 02 |   | s[3,c] |
     */
    function state_t mix_columns(input state_t st);
        state_t state_o;
        for (int c=0; c<4; c=c+1) begin
            state_o[0][c] = mul2(st[0][c]) ^ mul3(st[1][c]) ^ st[2][c]       ^ st[3][c];       //s'[0,c] = ({02}*s[0,c]) + ({03}*s[1,c]) + s[2,c]        + s[3,c]
            state_o[1][c] = st[0][c]       ^ mul2(st[1][c]) ^ mul3(st[2][c]) ^ st[3][c];       //s'[1,c] = s[0,c]        + ({02}*s[1,c]) + ({03}*s[2,c]) + s[3,c]
            state_o[2][c] = st[0][c]       ^ st[1][c]       ^ mul2(st[2][c]) ^ mul3(st[3][c]); //s'[2,c] = s[0,c]        + s[1,c]        + ({02}*s[2,c]) + ({03}*s[3,c])
            state_o[3][c] = mul3(st[0][c]) ^ st[1][c]       ^ st[2][c]       ^ mul2(st[3][c]); //s'[2,c] = ({02}*s[0,c]) + s[1,c]        + s[2,c]        + ({02}*s[3,c])
        end
        //void'(debug_output("After mix columns", state_o));
        return state_o;
    endfunction
    
    /*
     * Computing next round key for key schedule
     * */
    function state_t compute_next_round_key(input state_t key, input logic [3:0] cur_round);
        state_t     key_o;
        logic [3:0] r_gf;
        logic [3:0] c_gf;
        
        for (int r=0; r<4; r=r+1) begin
            //compute [0] column
            //sub bytes from Sbox
            if (r<3) begin
                r_gf = key[r+1][3][7:4];
                c_gf = key[r+1][3][3:0];
            end else begin
                r_gf = key[0][3][7:4];
                c_gf = key[0][3][3:0];
            end
            key_o[r][0] = key[r][0] ^ Sbox[r_gf][c_gf] ^ Rcon[r][cur_round];
            
            //compute [1:3] columns 
            for (int c=1; c<4; c=c+1) begin
                key_o[r][c] = key_o[r][c-1] ^ key[r][c];
            end
        end
        return key_o;
    endfunction
    
    /*
     * Adding round key
     * */
    function state_t add_round_key(input state_t st, input state_t key);
        state_t state_o;
        for (int r=0; r<4; r=r+1) begin
            for (int c=0; c<4; c=c+1) begin
                state_o[r][c] = st[r][c] ^ key[r][c];
            end
        end
        //void'(debug_output("After add round key", state_o));
        return state_o;
    endfunction
    
    /*
     * Debug output
     * */
/*     
    function debug_output(string info, state_t state);
        `ifdef DEBUG_MODE
            for (int r=0; r<4; r=r+1) begin
                $display("[%t]: %s: 0x%02H  0x%02H  0x%02H  0x%02H", $time, info, state[r][0], state[r][1], state[r][2], state[r][3]);
            end
            $display("");
        `endif
    endfunction
*/    
    /*
     * Implementation of functions area end
     */
    ////////////////////////////////////////


    //AES-128 encoder logic
    assign data_int = data_i ^ key_i; // Initialization, i.e. adding round key before 1st round
    
    always @(posedge clk_i or negedge rstn_i) begin
        if (~rstn_i) begin
            `ifdef DEBUG_MODE
                $display("=====Reseting=====");
            `endif
            state = vect_to_matrix(127'h0);
            round_key = vect_to_matrix(127'h0);
            round = 4'h0;
            busy = 1'b0;
            data_o = 128'h0;
            valid_o = 1'b0; 
        end else if (valid_i & ~busy) begin //1st round after valid data receiving
            `ifdef DEBUG_MODE
                $display("=====Received valid data, starting round 1=====");
            `endif
            round = 4'h0;
            busy = 1'b1;

            state = vect_to_matrix(data_int); //convert 128 bit data xored with key to byte matrix 4x4
            state = sub_bytes(state);  //change data bytes on bytes from Sbox field
            state = shift_rows(state); //shift columns in rows 
            state = mix_columns(state);//mix columns algorithm
            round_key = vect_to_matrix(key_i);//convert 128bit key to byte matrix 4x4
            round_key = compute_next_round_key(round_key, round);//get next schedule key
            state = add_round_key(state, round_key);

            round = round + 1;
            data_o = 128'h0;
            valid_o = 1'b0; 
        end else if (busy) begin //rounds 2-10
            `ifdef DEBUG_MODE
                $display("=====Round %02d=====", (round+1));
            `endif
            state = sub_bytes(state);  //change data bytes on bytes from Sbox field

            state = shift_rows(state); //shift columns in rows
            if (round!=4'h9) begin
                state = mix_columns(state);//mix columns algorithm
            end
            round_key = compute_next_round_key(round_key, round);//get next schedule key
            state = add_round_key(state, round_key);
            if (round==9'h9) begin
                round = 4'h0;
                busy = 1'b0;
                data_o = matrix_to_vector(state);
                valid_o = 1'b1;
            end else begin
                round = round + 1;
                busy = 1'b1;
                data_o = 128'h0;
                valid_o = 1'b0; 
            end
        end else begin
            `ifdef DEBUG_MODE
                $display("=====IDLE=====");
            `endif
            state = vect_to_matrix(127'h0);
            round_key = vect_to_matrix(127'h0);
            round = 4'h0;
            busy = 1'b0;
            data_o = 128'h0;
            valid_o = 1'b0; 
        end
    end
    
endmodule
