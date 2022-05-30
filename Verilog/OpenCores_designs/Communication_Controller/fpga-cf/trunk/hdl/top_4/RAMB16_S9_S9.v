
module RAMB16_S9_S9 (DOA, DOB, DOPA, DOPB, ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, DIPA, DIPB, ENA, ENB, SSRA, SSRB, WEA, WEB);

    parameter INIT_A = 9'h0;
    parameter INIT_B = 9'h0;
    parameter SRVAL_A = 9'h0;
    parameter SRVAL_B = 9'h0;
    parameter WRITE_MODE_A = "WRITE_FIRST";
    parameter WRITE_MODE_B = "WRITE_FIRST";
    parameter SIM_COLLISION_CHECK = "ALL";
    localparam SETUP_ALL = 1000;
    localparam SETUP_READ_FIRST = 3000;

    parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;

    output [7:0] DOA;
    output [0:0] DOPA;
    reg [7:0] doa_out;
    reg [0:0] dopa_out;
    wire doa_out0, doa_out1, doa_out2, doa_out3, doa_out4, doa_out5, doa_out6, doa_out7;
    wire dopa0_out;

    input [10:0] ADDRA;
    input [7:0] DIA;
    input [0:0] DIPA;
    input ENA, CLKA, WEA, SSRA;

    output [7:0] DOB;
    output [0:0] DOPB;
    reg [7:0] dob_out;
    reg [0:0] dopb_out;
    wire dob_out0, dob_out1, dob_out2, dob_out3, dob_out4, dob_out5, dob_out6, dob_out7;
    wire dopb0_out;

    input [10:0] ADDRB;
    input [7:0] DIB;
    input [0:0] DIPB;
    input ENB, CLKB, WEB, SSRB;

    reg [18431:0] mem;
    reg [8:0] count;
    reg [1:0] wr_mode_a, wr_mode_b;

    reg [5:0] dmi, dbi;
    reg [5:0] pmi, pbi;

    wire [10:0] addra_int;
    reg [10:0] addra_reg;
    wire [7:0] dia_int;
    wire [0:0] dipa_int;
    wire ena_int, clka_int, wea_int, ssra_int;
    reg ena_reg, wea_reg, ssra_reg;
    wire [10:0] addrb_int;
    reg [10:0] addrb_reg;
    wire [7:0] dib_int;
    wire [0:0] dipb_int;
    wire enb_int, clkb_int, web_int, ssrb_int;
    reg display_flag;
    reg enb_reg, web_reg, ssrb_reg;

    time time_clka, time_clkb;
    time time_clka_clkb;
    time time_clkb_clka;

    reg setup_all_a_b;
    reg setup_all_b_a;
    reg setup_zero;
    reg setup_rf_a_b;
    reg setup_rf_b_a;
    reg [1:0] data_collision, data_collision_a_b, data_collision_b_a;
    reg memory_collision, memory_collision_a_b, memory_collision_b_a;
    reg address_collision, address_collision_a_b, address_collision_b_a;
    reg change_clka;
    reg change_clkb;

    wire [14:0] data_addra_int;
    wire [14:0] data_addra_reg;
    wire [14:0] data_addrb_int;
    wire [14:0] data_addrb_reg;
    wire [15:0] parity_addra_int;
    wire [15:0] parity_addra_reg;
    wire [15:0] parity_addrb_int;
    wire [15:0] parity_addrb_reg;


    buf b_doa_out0 (doa_out0, doa_out[0]);
    buf b_doa_out1 (doa_out1, doa_out[1]);
    buf b_doa_out2 (doa_out2, doa_out[2]);
    buf b_doa_out3 (doa_out3, doa_out[3]);
    buf b_doa_out4 (doa_out4, doa_out[4]);
    buf b_doa_out5 (doa_out5, doa_out[5]);
    buf b_doa_out6 (doa_out6, doa_out[6]);
    buf b_doa_out7 (doa_out7, doa_out[7]);
    buf b_dopa_out0 (dopa_out0, dopa_out[0]);
    buf b_dob_out0 (dob_out0, dob_out[0]);
    buf b_dob_out1 (dob_out1, dob_out[1]);
    buf b_dob_out2 (dob_out2, dob_out[2]);
    buf b_dob_out3 (dob_out3, dob_out[3]);
    buf b_dob_out4 (dob_out4, dob_out[4]);
    buf b_dob_out5 (dob_out5, dob_out[5]);
    buf b_dob_out6 (dob_out6, dob_out[6]);
    buf b_dob_out7 (dob_out7, dob_out[7]);
    buf b_dopb_out0 (dopb_out0, dopb_out[0]);

    buf b_doa0 (DOA[0], doa_out0);
    buf b_doa1 (DOA[1], doa_out1);
    buf b_doa2 (DOA[2], doa_out2);
    buf b_doa3 (DOA[3], doa_out3);
    buf b_doa4 (DOA[4], doa_out4);
    buf b_doa5 (DOA[5], doa_out5);
    buf b_doa6 (DOA[6], doa_out6);
    buf b_doa7 (DOA[7], doa_out7);
    buf b_dopa0 (DOPA[0], dopa_out0);
    buf b_dob0 (DOB[0], dob_out0);
    buf b_dob1 (DOB[1], dob_out1);
    buf b_dob2 (DOB[2], dob_out2);
    buf b_dob3 (DOB[3], dob_out3);
    buf b_dob4 (DOB[4], dob_out4);
    buf b_dob5 (DOB[5], dob_out5);
    buf b_dob6 (DOB[6], dob_out6);
    buf b_dob7 (DOB[7], dob_out7);
    buf b_dopb0 (DOPB[0], dopb_out0);

    buf b_addra_0 (addra_int[0], ADDRA[0]);
    buf b_addra_1 (addra_int[1], ADDRA[1]);
    buf b_addra_2 (addra_int[2], ADDRA[2]);
    buf b_addra_3 (addra_int[3], ADDRA[3]);
    buf b_addra_4 (addra_int[4], ADDRA[4]);
    buf b_addra_5 (addra_int[5], ADDRA[5]);
    buf b_addra_6 (addra_int[6], ADDRA[6]);
    buf b_addra_7 (addra_int[7], ADDRA[7]);
    buf b_addra_8 (addra_int[8], ADDRA[8]);
    buf b_addra_9 (addra_int[9], ADDRA[9]);
    buf b_addra_10 (addra_int[10], ADDRA[10]);
    buf b_dia_0 (dia_int[0], DIA[0]);
    buf b_dia_1 (dia_int[1], DIA[1]);
    buf b_dia_2 (dia_int[2], DIA[2]);
    buf b_dia_3 (dia_int[3], DIA[3]);
    buf b_dia_4 (dia_int[4], DIA[4]);
    buf b_dia_5 (dia_int[5], DIA[5]);
    buf b_dia_6 (dia_int[6], DIA[6]);
    buf b_dia_7 (dia_int[7], DIA[7]);
    buf b_dipa_0 (dipa_int[0], DIPA[0]);
    buf b_ena (ena_int, ENA);
    buf b_clka (clka_int, CLKA);
    buf b_ssra (ssra_int, SSRA);
    buf b_wea (wea_int, WEA);
    buf b_addrb_0 (addrb_int[0], ADDRB[0]);
    buf b_addrb_1 (addrb_int[1], ADDRB[1]);
    buf b_addrb_2 (addrb_int[2], ADDRB[2]);
    buf b_addrb_3 (addrb_int[3], ADDRB[3]);
    buf b_addrb_4 (addrb_int[4], ADDRB[4]);
    buf b_addrb_5 (addrb_int[5], ADDRB[5]);
    buf b_addrb_6 (addrb_int[6], ADDRB[6]);
    buf b_addrb_7 (addrb_int[7], ADDRB[7]);
    buf b_addrb_8 (addrb_int[8], ADDRB[8]);
    buf b_addrb_9 (addrb_int[9], ADDRB[9]);
    buf b_addrb_10 (addrb_int[10], ADDRB[10]);
    buf b_dib_0 (dib_int[0], DIB[0]);
    buf b_dib_1 (dib_int[1], DIB[1]);
    buf b_dib_2 (dib_int[2], DIB[2]);
    buf b_dib_3 (dib_int[3], DIB[3]);
    buf b_dib_4 (dib_int[4], DIB[4]);
    buf b_dib_5 (dib_int[5], DIB[5]);
    buf b_dib_6 (dib_int[6], DIB[6]);
    buf b_dib_7 (dib_int[7], DIB[7]);
    buf b_dipb_0 (dipb_int[0], DIPB[0]);
    buf b_enb (enb_int, ENB);
    buf b_clkb (clkb_int, CLKB);
    buf b_ssrb (ssrb_int, SSRB);
    buf b_web (web_int, WEB);

    initial begin
	for (count = 0; count < 256; count = count + 1) begin
	    mem[count]		  <= INIT_00[count];
	    mem[256 * 1 + count]  <= INIT_01[count];
	    mem[256 * 2 + count]  <= INIT_02[count];
	    mem[256 * 3 + count]  <= INIT_03[count];
	    mem[256 * 4 + count]  <= INIT_04[count];
	    mem[256 * 5 + count]  <= INIT_05[count];
	    mem[256 * 6 + count]  <= INIT_06[count];
	    mem[256 * 7 + count]  <= INIT_07[count];
	    mem[256 * 8 + count]  <= INIT_08[count];
	    mem[256 * 9 + count]  <= INIT_09[count];
	    mem[256 * 10 + count] <= INIT_0A[count];
	    mem[256 * 11 + count] <= INIT_0B[count];
	    mem[256 * 12 + count] <= INIT_0C[count];
	    mem[256 * 13 + count] <= INIT_0D[count];
	    mem[256 * 14 + count] <= INIT_0E[count];
	    mem[256 * 15 + count] <= INIT_0F[count];
	    mem[256 * 16 + count] <= INIT_10[count];
	    mem[256 * 17 + count] <= INIT_11[count];
	    mem[256 * 18 + count] <= INIT_12[count];
	    mem[256 * 19 + count] <= INIT_13[count];
	    mem[256 * 20 + count] <= INIT_14[count];
	    mem[256 * 21 + count] <= INIT_15[count];
	    mem[256 * 22 + count] <= INIT_16[count];
	    mem[256 * 23 + count] <= INIT_17[count];
	    mem[256 * 24 + count] <= INIT_18[count];
	    mem[256 * 25 + count] <= INIT_19[count];
	    mem[256 * 26 + count] <= INIT_1A[count];
	    mem[256 * 27 + count] <= INIT_1B[count];
	    mem[256 * 28 + count] <= INIT_1C[count];
	    mem[256 * 29 + count] <= INIT_1D[count];
	    mem[256 * 30 + count] <= INIT_1E[count];
	    mem[256 * 31 + count] <= INIT_1F[count];
	    mem[256 * 32 + count] <= INIT_20[count];
	    mem[256 * 33 + count] <= INIT_21[count];
	    mem[256 * 34 + count] <= INIT_22[count];
	    mem[256 * 35 + count] <= INIT_23[count];
	    mem[256 * 36 + count] <= INIT_24[count];
	    mem[256 * 37 + count] <= INIT_25[count];
	    mem[256 * 38 + count] <= INIT_26[count];
	    mem[256 * 39 + count] <= INIT_27[count];
	    mem[256 * 40 + count] <= INIT_28[count];
	    mem[256 * 41 + count] <= INIT_29[count];
	    mem[256 * 42 + count] <= INIT_2A[count];
	    mem[256 * 43 + count] <= INIT_2B[count];
	    mem[256 * 44 + count] <= INIT_2C[count];
	    mem[256 * 45 + count] <= INIT_2D[count];
	    mem[256 * 46 + count] <= INIT_2E[count];
	    mem[256 * 47 + count] <= INIT_2F[count];
	    mem[256 * 48 + count] <= INIT_30[count];
	    mem[256 * 49 + count] <= INIT_31[count];
	    mem[256 * 50 + count] <= INIT_32[count];
	    mem[256 * 51 + count] <= INIT_33[count];
	    mem[256 * 52 + count] <= INIT_34[count];
	    mem[256 * 53 + count] <= INIT_35[count];
	    mem[256 * 54 + count] <= INIT_36[count];
	    mem[256 * 55 + count] <= INIT_37[count];
	    mem[256 * 56 + count] <= INIT_38[count];
	    mem[256 * 57 + count] <= INIT_39[count];
	    mem[256 * 58 + count] <= INIT_3A[count];
	    mem[256 * 59 + count] <= INIT_3B[count];
	    mem[256 * 60 + count] <= INIT_3C[count];
	    mem[256 * 61 + count] <= INIT_3D[count];
	    mem[256 * 62 + count] <= INIT_3E[count];
	    mem[256 * 63 + count] <= INIT_3F[count];
	    mem[256 * 64 + count] <= INITP_00[count];
	    mem[256 * 65 + count] <= INITP_01[count];
	    mem[256 * 66 + count] <= INITP_02[count];
	    mem[256 * 67 + count] <= INITP_03[count];
	    mem[256 * 68 + count] <= INITP_04[count];
	    mem[256 * 69 + count] <= INITP_05[count];
	    mem[256 * 70 + count] <= INITP_06[count];
	    mem[256 * 71 + count] <= INITP_07[count];
	end
	address_collision <= 0;
	address_collision_a_b <= 0;
	address_collision_b_a <= 0;
	change_clka <= 0;
	change_clkb <= 0;
	data_collision <= 0;
	data_collision_a_b <= 0;
	data_collision_b_a <= 0;
	memory_collision <= 0;
	memory_collision_a_b <= 0;
	memory_collision_b_a <= 0;
	setup_all_a_b <= 0;
	setup_all_b_a <= 0;
	setup_zero <= 0;
	setup_rf_a_b <= 0;
	setup_rf_b_a <= 0;
    end

    assign data_addra_int = addra_int * 8;
    assign data_addra_reg = addra_reg * 8;
    assign data_addrb_int = addrb_int * 8;
    assign data_addrb_reg = addrb_reg * 8;
    assign parity_addra_int = 16384 + addra_int * 1;
    assign parity_addra_reg = 16384 + addra_reg * 1;
    assign parity_addrb_int = 16384 + addrb_int * 1;
    assign parity_addrb_reg = 16384 + addrb_reg * 1;


    initial begin

	display_flag = 1;

	case (SIM_COLLISION_CHECK)

	    "NONE" : begin
		         assign setup_all_a_b = 1'b0;
	                 assign setup_all_b_a = 1'b0;
	                 assign setup_zero = 1'b0;
	                 assign setup_rf_a_b = 1'b0;
	                 assign setup_rf_b_a = 1'b0;
	                 assign display_flag = 0;
	             end
	    "WARNING_ONLY" : begin
		                 assign data_collision = 2'b00;
	                         assign data_collision_a_b = 2'b00;
	                         assign data_collision_b_a = 2'b00;
	                         assign memory_collision = 1'b0;
	                         assign memory_collision_a_b = 1'b0;
	                         assign memory_collision_b_a = 1'b0;
	                     end
	    "GENERATE_X_ONLY" : begin
		                    assign display_flag = 0;
	                        end
	    "ALL" : ;
	    default : begin
		          $display("Attribute Syntax Error : The Attribute SIM_COLLISION_CHECK on RAMB16_S9_S9 instance %m is set to %s.  Legal values for this attribute are ALL, NONE, WARNING_ONLY or GENERATE_X_ONLY.", SIM_COLLISION_CHECK);
		          $finish;
	              end

	endcase // case(SIM_COLLISION_CHECK)

    end // initial begin


    always @(posedge setup_all_a_b) begin
	if (data_addra_reg[14:3] == data_addrb_int[14:3]) begin
	if ((ena_reg == 1) && (enb_int == 1)) begin
	    case ({wr_mode_a, wr_mode_b, wea_reg, web_int})
		6'b000011 : begin data_collision_a_b <= 2'b11; display_wa_wb; end
		6'b000111 : begin data_collision_a_b <= 2'b11; display_wa_wb; end
		6'b001011 : begin data_collision_a_b <= 2'b10; display_wa_wb; end
//		6'b010011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
//		6'b010111 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
//		6'b011011 : begin data_collision_a_b <= 2'b00; display_wa_wb; end
		6'b100011 : begin data_collision_a_b <= 2'b01; display_wa_wb; end
		6'b100111 : begin data_collision_a_b <= 2'b01; display_wa_wb; end
		6'b101011 : begin display_wa_wb; end
		6'b000001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
//		6'b000101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
		6'b001001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
		6'b010001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
//		6'b010101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
		6'b011001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
		6'b100001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
//		6'b100101 : begin data_collision_a_b <= 2'b00; display_ra_wb; end
		6'b101001 : begin data_collision_a_b <= 2'b10; display_ra_wb; end
		6'b000010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
		6'b000110 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
		6'b001010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
//		6'b010010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
//		6'b010110 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
//		6'b011010 : begin data_collision_a_b <= 2'b00; display_wa_rb; end
		6'b100010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
		6'b100110 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
		6'b101010 : begin data_collision_a_b <= 2'b01; display_wa_rb; end
	    endcase
	end
	end
	setup_all_a_b <= 0;
    end


  


  

    task display_ra_wb;
    begin
	if (display_flag)
        $display("Memory Collision Error on RAMB16_S9_S9:%m at simulation time %.3f ns\nA read was performed on address %h (hex) of Port A while a write was requested to the same address on Port B. The write will be successful however the read value on Port A is unknown until the next CLKA cycle.", $time/1000.0, addra_int);
    end
    endtask

    task display_wa_rb;
    begin
	if (display_flag)
        $display("Memory Collision Error on RAMB16_S9_S9:%m at simulation time %.3f ns\nA read was performed on address %h (hex) of Port B while a write was requested to the same address on Port A. The write will be successful however the read value on Port B is unknown until the next CLKB cycle.", $time/1000.0, addrb_int);
    end
    endtask

    task display_wa_wb;
    begin
	if (display_flag)
        $display("Memory Collision Error on RAMB16_S9_S9:%m at simulation time %.3f ns\nA write was requested to the same address simultaneously at both Port A and Port B of the RAM. The contents written to the RAM at address location %h (hex) of Port A and address location %h (hex) of Port B are unknown.", $time/1000.0, addra_int, addrb_int);
    end
    endtask



    always @(posedge clka_int) begin
	addra_reg <= addra_int;
	ena_reg <= ena_int;
	ssra_reg <= ssra_int;
	wea_reg <= wea_int;
    end

    always @(posedge clkb_int) begin
	addrb_reg <= addrb_int;
	enb_reg <= enb_int;
	ssrb_reg <= ssrb_int;
	web_reg <= web_int;
    end



    initial begin
	case (WRITE_MODE_A)
	    "WRITE_FIRST" : wr_mode_a <= 2'b00;
	    "READ_FIRST"  : wr_mode_a <= 2'b01;
	    "NO_CHANGE"   : wr_mode_a <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_A on RAMB16_S9_S9 instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_A);
				$finish;
			    end
	endcase
    end

    initial begin
	case (WRITE_MODE_B)
	    "WRITE_FIRST" : wr_mode_b <= 2'b00;
	    "READ_FIRST"  : wr_mode_b <= 2'b01;
	    "NO_CHANGE"   : wr_mode_b <= 2'b10;
	    default       : begin
				$display("Attribute Syntax Error : The Attribute WRITE_MODE_B on RAMB16_S9_S9 instance %m is set to %s.  Legal values for this attribute are WRITE_FIRST, READ_FIRST or NO_CHANGE.", WRITE_MODE_B);
				$finish;
			    end
	endcase
    end

    // Port A
    always @(posedge clka_int) begin
	if (ena_int == 1'b1) begin
	    if (ssra_int == 1'b1) begin
		doa_out[0] <= SRVAL_A[0];
		doa_out[1] <= SRVAL_A[1];
		doa_out[2] <= SRVAL_A[2];
		doa_out[3] <= SRVAL_A[3];
		doa_out[4] <= SRVAL_A[4];
		doa_out[5] <= SRVAL_A[5];
		doa_out[6] <= SRVAL_A[6];
		doa_out[7] <= SRVAL_A[7];
		dopa_out[0] <= SRVAL_A[8];
	    end
	    else begin
		if (wea_int == 1'b1) begin
		    if (wr_mode_a == 2'b00) begin
			doa_out <= dia_int;
			dopa_out <= dipa_int;
		    end
		    else if (wr_mode_a == 2'b01) begin
			doa_out[0] <= mem[data_addra_int + 0];
			doa_out[1] <= mem[data_addra_int + 1];
			doa_out[2] <= mem[data_addra_int + 2];
			doa_out[3] <= mem[data_addra_int + 3];
			doa_out[4] <= mem[data_addra_int + 4];
			doa_out[5] <= mem[data_addra_int + 5];
			doa_out[6] <= mem[data_addra_int + 6];
			doa_out[7] <= mem[data_addra_int + 7];
			dopa_out[0] <= mem[parity_addra_int + 0];
		    end
		end
		else begin
		    doa_out[0] <= mem[data_addra_int + 0];
		    doa_out[1] <= mem[data_addra_int + 1];
		    doa_out[2] <= mem[data_addra_int + 2];
		    doa_out[3] <= mem[data_addra_int + 3];
		    doa_out[4] <= mem[data_addra_int + 4];
		    doa_out[5] <= mem[data_addra_int + 5];
		    doa_out[6] <= mem[data_addra_int + 6];
		    doa_out[7] <= mem[data_addra_int + 7];
		    dopa_out[0] <= mem[parity_addra_int + 0];
		end
	    end
	end
    end



    // Port B
    always @(posedge clkb_int) begin
	if (enb_int == 1'b1) begin
	    if (ssrb_int == 1'b1) begin
		dob_out[0] <= SRVAL_B[0];
		dob_out[1] <= SRVAL_B[1];
		dob_out[2] <= SRVAL_B[2];
		dob_out[3] <= SRVAL_B[3];
		dob_out[4] <= SRVAL_B[4];
		dob_out[5] <= SRVAL_B[5];
		dob_out[6] <= SRVAL_B[6];
		dob_out[7] <= SRVAL_B[7];
		dopb_out[0] <= SRVAL_B[8];
	    end
	    else begin
		if (web_int == 1'b1) begin
		    if (wr_mode_b == 2'b00) begin
			dob_out <= dib_int;
			dopb_out <= dipb_int;
		    end
		    else if (wr_mode_b == 2'b01) begin
			dob_out[0] <= mem[data_addrb_int + 0];
			dob_out[1] <= mem[data_addrb_int + 1];
			dob_out[2] <= mem[data_addrb_int + 2];
			dob_out[3] <= mem[data_addrb_int + 3];
			dob_out[4] <= mem[data_addrb_int + 4];
			dob_out[5] <= mem[data_addrb_int + 5];
			dob_out[6] <= mem[data_addrb_int + 6];
			dob_out[7] <= mem[data_addrb_int + 7];
			dopb_out[0] <= mem[parity_addrb_int + 0];
		    end
		end
		else begin
		    dob_out[0] <= mem[data_addrb_int + 0];
		    dob_out[1] <= mem[data_addrb_int + 1];
		    dob_out[2] <= mem[data_addrb_int + 2];
		    dob_out[3] <= mem[data_addrb_int + 3];
		    dob_out[4] <= mem[data_addrb_int + 4];
		    dob_out[5] <= mem[data_addrb_int + 5];
		    dob_out[6] <= mem[data_addrb_int + 6];
		    dob_out[7] <= mem[data_addrb_int + 7];
		    dopb_out[0] <= mem[parity_addrb_int + 0];
		end
	    end
	end
    end

    always @(posedge clkb_int) begin
	if (enb_int == 1'b1 && web_int == 1'b1) begin
	    mem[data_addrb_int + 0] <= dib_int[0];
	    mem[data_addrb_int + 1] <= dib_int[1];
	    mem[data_addrb_int + 2] <= dib_int[2];
	    mem[data_addrb_int + 3] <= dib_int[3];
	    mem[data_addrb_int + 4] <= dib_int[4];
	    mem[data_addrb_int + 5] <= dib_int[5];
	    mem[data_addrb_int + 6] <= dib_int[6];
	    mem[data_addrb_int + 7] <= dib_int[7];
	    mem[parity_addrb_int + 0] <= dipb_int[0];
	end
    end

    specify
	(CLKA *> DOA) = (100, 100);
	(CLKA *> DOPA) = (100, 100);
	(CLKB *> DOB) = (100, 100);
	(CLKB *> DOPB) = (100, 100);
    endspecify

endmodule 
