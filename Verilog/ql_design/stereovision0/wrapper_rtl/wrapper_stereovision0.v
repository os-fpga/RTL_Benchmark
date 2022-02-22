// Wrapper Design

module wrapper_stereovision0 (tm3_clk_v0, counter_out_1to0, bus_word_vidin_rgb_tmp, x_in_yin_tmp, select_x_in_yin_tmp, select_bus_word_vidin_rgb_tmp, v_nd_s1_left_2to0, v_nd_s2_left_2to0 , v_nd_s4_left_2to0 , v_d_reg_s1_left_2to0 , v_d_reg_s2_left_2to0 , v_d_reg_s4_left_2to0 , v_nd_s1_right_2to0, v_nd_s2_right_2to0 , v_nd_s4_right_2to0 , v_d_reg_s1_right_2to0 , v_d_reg_s2_right_2to0 , v_d_reg_s4_right_2to0 , tm3_vidout_red,tm3_vidout_green,tm3_vidout_blue , tm3_vidout_clock,tm3_vidout_hsync,tm3_vidout_vsync,tm3_vidout_blank , depth_out, offchip_sram_data_in,offchip_sram_addr,offchip_sram_data_out,offchip_sram_we,offchip_sram_oe, vidin_new_data_fifo, vidin_addr_reg_2to0);

   input tm3_clk_v0; 
   input [63:0]offchip_sram_data_in;
   output [18:0]offchip_sram_addr;
   output [63:0]offchip_sram_data_out;
   output [7:0]offchip_sram_we;
   output [1:0]offchip_sram_oe;
 
   input[2:0] counter_out_1to0; 
   input vidin_new_data_fifo; 
   
   input[7:0] bus_word_vidin_rgb_tmp;
   input [2:0] select_bus_word_vidin_rgb_tmp;
   input[3:0] vidin_addr_reg_2to0; 
   output v_nd_s1_left_2to0; 
   output v_nd_s2_left_2to0; 
   output v_nd_s4_left_2to0; 
   output[7:0] v_d_reg_s1_left_2to0; 
   output[7:0] v_d_reg_s2_left_2to0; 
   output[7:0] v_d_reg_s4_left_2to0; 
   output v_nd_s1_right_2to0; 
   output v_nd_s2_right_2to0; 
   output v_nd_s4_right_2to0; 
   output[7:0] v_d_reg_s1_right_2to0; 
   output[7:0] v_d_reg_s2_right_2to0; 
   output[7:0] v_d_reg_s4_right_2to0; 
   output[9:0] tm3_vidout_red; 
   output[9:0] tm3_vidout_green; 
   output[9:0] tm3_vidout_blue; 
   output tm3_vidout_clock; 
   output tm3_vidout_hsync; 
   output tm3_vidout_vsync; 
   output tm3_vidout_blank; 
   input [15:0] x_in_yin_tmp;
   input select_x_in_yin_tmp;
   output[15:0] depth_out; 
   reg [7:0]  bus_word_1_1to0; 
   reg [7:0]  bus_word_2_1to0; 
   reg [7:0]  bus_word_3_1to0; 
   reg [7:0]  bus_word_4_1to0; 
   reg [7:0]  bus_word_5_1to0; 
   reg [7:0]  bus_word_6_1to0;

   reg [7:0]  vidin_rgb_reg_fifo_left; 
   reg [7:0]  vidin_rgb_reg_fifo_right;

   reg [15:0] x_in;
   reg [15:0] y_in;

   always @(posedge tm3_clk_v0) begin
      case (select_bus_word_vidin_rgb_tmp)
	3'd0:
            bus_word_1_1to0 = bus_word_vidin_rgb_tmp;
	3'd1:
            bus_word_2_1to0 = bus_word_vidin_rgb_tmp;
	3'd2:
            bus_word_3_1to0 = bus_word_vidin_rgb_tmp;
	3'd3:
            bus_word_4_1to0 = bus_word_vidin_rgb_tmp;
	3'd4:
            bus_word_5_1to0 = bus_word_vidin_rgb_tmp;
	3'd5:
            bus_word_6_1to0 = bus_word_vidin_rgb_tmp;
	3'd6:
            vidin_rgb_reg_fifo_left = bus_word_vidin_rgb_tmp;
	3'd7:
            vidin_rgb_reg_fifo_right = bus_word_vidin_rgb_tmp;

	endcase

      case(select_x_in_yin_tmp)
         1'd0:
         x_in = x_in_yin_tmp;
         1'd1:
         y_in = x_in_yin_tmp;

      endcase
   end
   stereovision0 inst(.tm3_clk_v0 (tm3_clk_v0),. bus_word_1_1to0 (bus_word_1_1to0),. bus_word_2_1to0 (bus_word_2_1to0),. bus_word_3_1to0 (bus_word_3_1to0),. bus_word_4_1to0 (bus_word_4_1to0),. bus_word_5_1to0 (bus_word_5_1to0),. bus_word_6_1to0(bus_word_6_1to0),. counter_out_1to0(counter_out_1to0),. vidin_new_data_fifo (vidin_new_data_fifo),. vidin_rgb_reg_fifo_left (vidin_rgb_reg_fifo_left),. vidin_rgb_reg_fifo_right (vidin_rgb_reg_fifo_right),. vidin_addr_reg_2to0(vidin_addr_reg_2to0),. v_nd_s1_left_2to0 (v_nd_s1_left_2to0),. v_nd_s2_left_2to0 (v_nd_s2_left_2to0) ,. v_nd_s4_left_2to0 (v_nd_s4_left_2to0),. v_d_reg_s1_left_2to0 (v_d_reg_s1_left_2to0),. v_d_reg_s2_left_2to0 (v_d_reg_s2_left_2to0),. v_d_reg_s4_left_2to0(v_d_reg_s4_left_2to0) ,. v_nd_s1_right_2to0 (v_nd_s1_right_2to0),. v_nd_s2_right_2to0 (v_nd_s2_right_2to0),. v_nd_s4_right_2to0 (v_nd_s4_right_2to0) ,. v_d_reg_s1_right_2to0 (v_d_reg_s1_right_2to0) ,. v_d_reg_s2_right_2to0 (v_d_reg_s2_right_2to0),. v_d_reg_s4_right_2to0 (v_d_reg_s4_right_2to0) ,. tm3_vidout_red (tm3_vidout_red) ,. tm3_vidout_green (tm3_vidout_green),.tm3_vidout_blue (tm3_vidout_blue),. tm3_vidout_clock(tm3_vidout_clock),.tm3_vidout_hsync (tm3_vidout_hsync),.tm3_vidout_vsync (tm3_vidout_vsync),.tm3_vidout_blank (tm3_vidout_blank) ,. x_in(x_in),. y_in(y_in),. depth_out (depth_out),. offchip_sram_data_in(offchip_sram_data_in),.offchip_sram_addr (offchip_sram_addr),.offchip_sram_data_out(offchip_sram_data_out),.offchip_sram_we(offchip_sram_we),.offchip_sram_oe(offchip_sram_oe));

endmodule
