// Wrapper_Design

module wrapper_cf_fir_24_16_16 (clock_c, reset_i, data_i, k_temp_i, k16_i, k17_i, k18_i, k19_i, k20_i, k21_i, k22_i, k23_i, k24_i, select_k_temp, data_o );
input  clock_c;
input  reset_i;
input  [15:0] data_i;
input  [15:0] k_temp_i;
input  [15:0] k16_i;
input  [15:0] k17_i;
input  [15:0] k18_i;
input  [15:0] k19_i;
input  [15:0] k20_i;
input  [15:0] k21_i;
input  [15:0] k22_i;
input  [15:0] k23_i;
input  [15:0] k24_i;
input [3:0] select_k_temp;
output [36:0] data_o;


reg [15:0] k0_i;
reg [15:0] k1_i;
reg [15:0] k2_i;
reg [15:0] k3_i;
reg [15:0] k4_i;
reg [15:0] k5_i;
reg [15:0] k6_i;
reg [15:0] k7_i;
reg [15:0] k8_i;
reg [15:0] k9_i;
reg [15:0] k10_i;
reg [15:0] k11_i;
reg [15:0] k12_i;
reg [15:0] k13_i;
reg [15:0] k14_i;
reg [15:0] k15_i;

always @(posedge clock_c)
        begin

            case (select_k_temp) 
                    4'd0:
                        k0_i = k_temp_i;
                    4'd1:
                        k1_i = k_temp_i;
                    4'd2:
                        k2_i = k_temp_i;
                    4'd3:
                        k3_i = k_temp_i;
                    4'd4:
                        k4_i = k_temp_i;
                    4'd5:
                        k5_i = k_temp_i;
                    4'd6:
                        k6_i = k_temp_i;
                    4'd7:
                        k7_i = k_temp_i;
                    4'd8:
                        k8_i = k_temp_i;
                    4'd9:
                        k9_i = k_temp_i;
                    4'd10:
                        k10_i = k_temp_i;
                    4'd11:
                        k11_i = k_temp_i;
                    4'd12:
                        k12_i = k_temp_i;
                    4'd13:
                        k13_i = k_temp_i;
                    4'd14:
                        k14_i = k_temp_i;
                    4'd15:
                        k15_i = k_temp_i;
                    
            endcase
        end

    top (clock_c, reset_i, data_i, k0_i, k1_i, k2_i, k3_i, k4_i, k5_i, k6_i, k7_i, k8_i, k9_i, k10_i, k11_i, k12_i, k13_i, k14_i, k15_i, k16_i, k17_i, k18_i, k19_i, k20_i, k21_i, k22_i, k23_i, k24_i, data_o);

endmodule 
