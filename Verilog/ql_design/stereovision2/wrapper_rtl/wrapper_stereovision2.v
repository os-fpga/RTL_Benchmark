module wrapper_stereovision2 (reset, tm3_clk_v0,  vidin_new_data, vidin_rgb_reg, vidin_addr_reg, svid_comp_switch, counter_out_2to1, bus_word_temp_2to1, sel_mux_bus_word_temp_2to1, vidin_new_data_fifo, vidin_rgb_reg_fifo_left, vidin_rgb_reg_fifo_right, vidin_addr_reg_2to0, v_nd_s1_left_2to0, v_nd_s2_left_2to0 , v_nd_s4_left_2to0 , v_d_reg_s1_left_2to0 , v_d_reg_s2_left_2to0 , v_d_reg_s4_left_2to0 , v_nd_s1_right_2to0, v_nd_s2_right_2to0 , v_nd_s4_right_2to0 , v_d_reg_s1_right_2to0 , v_d_reg_s2_right_2to0 , v_d_reg_s4_right_2to0,offchip_sram_data_in,offchip_sram_addr,offchip_sram_data_out,offchip_sram_we,offchip_sram_oe,tm3_sram_adsp);
		
   input [63:0]offchip_sram_data_in;
   output [18:0]offchip_sram_addr;
   output [63:0]offchip_sram_data_out;
   output [7:0]offchip_sram_we;
   output [1:0]offchip_sram_oe;
   input reset;
   input tm3_clk_v0; 

   output tm3_sram_adsp; 
   input vidin_new_data; 
   input[7:0] vidin_rgb_reg; 
   input[18:0] vidin_addr_reg; 
   input svid_comp_switch; 
   output[2:0] counter_out_2to1; 
   input [1:0] sel_mux_bus_word_temp_2to1;
   output[15:0] bus_word_temp_2to1;
   output vidin_new_data_fifo; 
   output[7:0] vidin_rgb_reg_fifo_left; 
   output[7:0] vidin_rgb_reg_fifo_right; 
   output[3:0] vidin_addr_reg_2to0; 
   input v_nd_s1_left_2to0; 
   input v_nd_s2_left_2to0; 
   input v_nd_s4_left_2to0; 
   input[7:0] v_d_reg_s1_left_2to0; 
   input[7:0] v_d_reg_s2_left_2to0; 
   input[7:0] v_d_reg_s4_left_2to0; 
   input v_nd_s1_right_2to0; 
   input v_nd_s2_right_2to0; 
   input v_nd_s4_right_2to0; 
   input[7:0] v_d_reg_s1_right_2to0; 
   input[7:0] v_d_reg_s2_right_2to0; 
   input[7:0] v_d_reg_s4_right_2to0; 

   wire [15:0] bus_word_3_2to1; 
   wire [15:0] bus_word_4_2to1; 
   wire [15:0] bus_word_5_2to1; 
   wire [15:0] bus_word_6_2to1;

 
   stereovision2 inst(.reset(reset),. tm3_clk_v0(tm3_clk_v0),.  vidin_new_data(vidin_new_data),. vidin_rgb_reg (vidin_rgb_reg),. vidin_addr_reg (vidin_addr_reg),. svid_comp_switch (svid_comp_switch),. counter_out_2to1 (counter_out_2to1),. bus_word_3_2to1 (bus_word_3_2to1),. bus_word_4_2to1 (bus_word_4_2to1),. bus_word_5_2to1 (bus_word_5_2to1),. bus_word_6_2to1 (bus_word_6_2to1),. vidin_new_data_fifo (vidin_new_data_fifo),. vidin_rgb_reg_fifo_left (vidin_rgb_reg_fifo_left),. vidin_rgb_reg_fifo_right (vidin_rgb_reg_fifo_right),. vidin_addr_reg_2to0 (vidin_addr_reg_2to0),. v_nd_s1_left_2to0 (v_nd_s1_left_2to0),. v_nd_s2_left_2to0 (v_nd_s2_left_2to0) ,. v_nd_s4_left_2to0 (v_nd_s4_left_2to0) ,. v_d_reg_s1_left_2to0 (v_d_reg_s1_left_2to0) ,. v_d_reg_s2_left_2to0 (v_d_reg_s2_left_2to0) ,. v_d_reg_s4_left_2to0 (v_d_reg_s4_left_2to0) ,. v_nd_s1_right_2to0 (v_nd_s1_right_2to0),. v_nd_s2_right_2to0 (v_nd_s2_right_2to0) ,. v_nd_s4_right_2to0 (v_nd_s4_right_2to0) ,. v_d_reg_s1_right_2to0 (v_d_reg_s1_right_2to0) ,. v_d_reg_s2_right_2to0 (v_d_reg_s2_right_2to0) ,. v_d_reg_s4_right_2to0 (v_d_reg_s4_right_2to0),. offchip_sram_data_in(offchip_sram_data_in),. offchip_sram_addr (offchip_sram_addr),. offchip_sram_data_out (offchip_sram_data_out),. offchip_sram_we (offchip_sram_we),. offchip_sram_oe (offchip_sram_oe),. tm3_sram_adsp(tm3_sram_adsp));
   mux_4x1 inst_mux (.in0(bus_word_3_2to1),.in1(bus_word_4_2to1),. in2(bus_word_5_2to1),. in3(bus_word_6_2to1),. sel(sel_mux_bus_word_temp_2to1),. out(bus_word_temp_2to1));
endmodule

module mux_4x1 (
   input [15:0]in0,
   input [15:0] in1,
   input [15:0] in2,
   input [15:0] in3,
  input [1:0]sel,
  output [15:0] out);
  wire [15:0] out0_w, out1_w;
  
  mux_2x1 m4_0(.a(in0),.b(in1),.sel(sel[0]),.out(out0_w));
  mux_2x1 m4_1(.a(in2),.b(in3),.sel(sel[0]),.out(out1_w));
  mux_2x1 m4_2(.a(out0_w),.b(out1_w),.sel(sel[1]),.out(out));
  
endmodule 

module mux_2x1 (
   input [15:0] a,
   input [15:0] b,
   input sel,
   output [15:0] out);
   assign out = sel ? b : a; 
endmodule