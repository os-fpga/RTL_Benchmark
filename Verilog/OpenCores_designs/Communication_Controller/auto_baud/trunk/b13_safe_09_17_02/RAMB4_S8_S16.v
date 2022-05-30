module RAMB4_S8_S16 (DOA, DOB, ADDRA, ADDRB, CLKA, CLKB, DIA, DIB, ENA, ENB, RSTA, RSTB, WEA, WEB);

    parameter SIM_COLLISION_CHECK = "ALL";
    localparam SETUP_ALL = 100;

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

    output [7:0] DOA;
    reg [7:0] doa_out;
    wire doa_out0, doa_out1, doa_out2, doa_out3, doa_out4, doa_out5, doa_out6, doa_out7;

    input [8:0] ADDRA;
    input [7:0] DIA;
    input ENA, CLKA, WEA, RSTA;

    output [15:0] DOB;
    reg [15:0] dob_out;
    wire dob_out0, dob_out1, dob_out2, dob_out3, dob_out4, dob_out5, dob_out6, dob_out7, dob_out8, dob_out9, dob_out10, dob_out11, dob_out12, dob_out13, dob_out14, dob_out15;

    input [7:0] ADDRB;
    input [15:0] DIB;
    input ENB, CLKB, WEB, RSTB;

    reg [4095:0] mem;
    reg [8:0] count;

    reg [5:0] mi, mj, ai, aj, bi, bj, ci, cj, di, dj, ei, ej, fi, fj;

    wire [8:0] addra_int;
    reg [8:0] addra_reg;
    wire [7:0] dia_int;
    wire ena_int, clka_int, wea_int, rsta_int;
    reg ena_reg, wea_reg, rsta_reg;
    wire [7:0] addrb_int;
    reg [7:0] addrb_reg;
    wire [15:0] dib_int;
    wire enb_int, clkb_int, web_int, rstb_int;
    reg enb_reg, web_reg, rstb_reg;

    time time_clka, time_clkb;
    time time_clka_clkb;
    time time_clkb_clka;

    reg setup_all_a_b;
    reg setup_all_b_a;
    reg setup_zero;
    reg [1:0] data_collision, data_collision_a_b, data_collision_b_a;
    reg memory_collision, memory_collision_a_b, memory_collision_b_a;
    reg address_collision, address_collision_a_b, address_collision_b_a;
    reg change_clka;
    reg change_clkb;

    wire [11:0] mem_addra_int;
    wire [11:0] mem_addra_reg;
    wire [11:0] mem_addrb_int;
    wire [11:0] mem_addrb_reg;

    tri0 GSR = 1'b1;

    // always @(GSR)
	// if (GSR) begin
	//     assign doa_out <= 0;
	// end
	// else begin
	//     deassign doa_out;
	// end
// 
    // always @(GSR)
	// if (GSR) begin
	//     assign dob_out <= 0;
	// end
	// else begin
	//     deassign dob_out;
	// end

    buf b_doa_out0 (doa_out0, doa_out[0]);
    buf b_doa_out1 (doa_out1, doa_out[1]);
    buf b_doa_out2 (doa_out2, doa_out[2]);
    buf b_doa_out3 (doa_out3, doa_out[3]);
    buf b_doa_out4 (doa_out4, doa_out[4]);
    buf b_doa_out5 (doa_out5, doa_out[5]);
    buf b_doa_out6 (doa_out6, doa_out[6]);
    buf b_doa_out7 (doa_out7, doa_out[7]);
    buf b_dob_out0 (dob_out0, dob_out[0]);
    buf b_dob_out1 (dob_out1, dob_out[1]);
    buf b_dob_out2 (dob_out2, dob_out[2]);
    buf b_dob_out3 (dob_out3, dob_out[3]);
    buf b_dob_out4 (dob_out4, dob_out[4]);
    buf b_dob_out5 (dob_out5, dob_out[5]);
    buf b_dob_out6 (dob_out6, dob_out[6]);
    buf b_dob_out7 (dob_out7, dob_out[7]);
    buf b_dob_out8 (dob_out8, dob_out[8]);
    buf b_dob_out9 (dob_out9, dob_out[9]);
    buf b_dob_out10 (dob_out10, dob_out[10]);
    buf b_dob_out11 (dob_out11, dob_out[11]);
    buf b_dob_out12 (dob_out12, dob_out[12]);
    buf b_dob_out13 (dob_out13, dob_out[13]);
    buf b_dob_out14 (dob_out14, dob_out[14]);
    buf b_dob_out15 (dob_out15, dob_out[15]);
    buf b_doa0 (DOA[0], doa_out0);
    buf b_doa1 (DOA[1], doa_out1);
    buf b_doa2 (DOA[2], doa_out2);
    buf b_doa3 (DOA[3], doa_out3);
    buf b_doa4 (DOA[4], doa_out4);
    buf b_doa5 (DOA[5], doa_out5);
    buf b_doa6 (DOA[6], doa_out6);
    buf b_doa7 (DOA[7], doa_out7);
    buf b_dob0 (DOB[0], dob_out0);
    buf b_dob1 (DOB[1], dob_out1);
    buf b_dob2 (DOB[2], dob_out2);
    buf b_dob3 (DOB[3], dob_out3);
    buf b_dob4 (DOB[4], dob_out4);
    buf b_dob5 (DOB[5], dob_out5);
    buf b_dob6 (DOB[6], dob_out6);
    buf b_dob7 (DOB[7], dob_out7);
    buf b_dob8 (DOB[8], dob_out8);
    buf b_dob9 (DOB[9], dob_out9);
    buf b_dob10 (DOB[10], dob_out10);
    buf b_dob11 (DOB[11], dob_out11);
    buf b_dob12 (DOB[12], dob_out12);
    buf b_dob13 (DOB[13], dob_out13);
    buf b_dob14 (DOB[14], dob_out14);
    buf b_dob15 (DOB[15], dob_out15);
    buf b_addra_0 (addra_int[0], ADDRA[0]);
    buf b_addra_1 (addra_int[1], ADDRA[1]);
    buf b_addra_2 (addra_int[2], ADDRA[2]);
    buf b_addra_3 (addra_int[3], ADDRA[3]);
    buf b_addra_4 (addra_int[4], ADDRA[4]);
    buf b_addra_5 (addra_int[5], ADDRA[5]);
    buf b_addra_6 (addra_int[6], ADDRA[6]);
    buf b_addra_7 (addra_int[7], ADDRA[7]);
    buf b_addra_8 (addra_int[8], ADDRA[8]);
    buf b_dia_0 (dia_int[0], DIA[0]);
    buf b_dia_1 (dia_int[1], DIA[1]);
    buf b_dia_2 (dia_int[2], DIA[2]);
    buf b_dia_3 (dia_int[3], DIA[3]);
    buf b_dia_4 (dia_int[4], DIA[4]);
    buf b_dia_5 (dia_int[5], DIA[5]);
    buf b_dia_6 (dia_int[6], DIA[6]);
    buf b_dia_7 (dia_int[7], DIA[7]);
    buf b_clka (clka_int, CLKA);
    buf b_ena (ena_int, ENA);
    buf b_rsta (rsta_int, RSTA);
    buf b_wea (wea_int, WEA);
    buf b_addrb_0 (addrb_int[0], ADDRB[0]);
    buf b_addrb_1 (addrb_int[1], ADDRB[1]);
    buf b_addrb_2 (addrb_int[2], ADDRB[2]);
    buf b_addrb_3 (addrb_int[3], ADDRB[3]);
    buf b_addrb_4 (addrb_int[4], ADDRB[4]);
    buf b_addrb_5 (addrb_int[5], ADDRB[5]);
    buf b_addrb_6 (addrb_int[6], ADDRB[6]);
    buf b_addrb_7 (addrb_int[7], ADDRB[7]);
    buf b_dib_0 (dib_int[0], DIB[0]);
    buf b_dib_1 (dib_int[1], DIB[1]);
    buf b_dib_2 (dib_int[2], DIB[2]);
    buf b_dib_3 (dib_int[3], DIB[3]);
    buf b_dib_4 (dib_int[4], DIB[4]);
    buf b_dib_5 (dib_int[5], DIB[5]);
    buf b_dib_6 (dib_int[6], DIB[6]);
    buf b_dib_7 (dib_int[7], DIB[7]);
    buf b_dib_8 (dib_int[8], DIB[8]);
    buf b_dib_9 (dib_int[9], DIB[9]);
    buf b_dib_10 (dib_int[10], DIB[10]);
    buf b_dib_11 (dib_int[11], DIB[11]);
    buf b_dib_12 (dib_int[12], DIB[12]);
    buf b_dib_13 (dib_int[13], DIB[13]);
    buf b_dib_14 (dib_int[14], DIB[14]);
    buf b_dib_15 (dib_int[15], DIB[15]);
    buf b_clkb (clkb_int, CLKB);
    buf b_enb (enb_int, ENB);
    buf b_rstb (rstb_int, RSTB);
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
    end

    assign mem_addra_int = addra_int * 8;
    assign mem_addra_reg = addra_reg * 8;
    assign mem_addrb_int = addrb_int * 16;
    assign mem_addrb_reg = addrb_reg * 16;


 
    always @(posedge clkb_int) begin
	if (enb_int == 1'b1) begin
	    if (rstb_int == 1'b1) begin
		dob_out <= 16'b0;
	    end
	    else if (web_int == 0) begin
		dob_out[0] <= mem[mem_addrb_int + 0];
		dob_out[1] <= mem[mem_addrb_int + 1];
		dob_out[2] <= mem[mem_addrb_int + 2];
		dob_out[3] <= mem[mem_addrb_int + 3];
		dob_out[4] <= mem[mem_addrb_int + 4];
		dob_out[5] <= mem[mem_addrb_int + 5];
		dob_out[6] <= mem[mem_addrb_int + 6];
		dob_out[7] <= mem[mem_addrb_int + 7];
		dob_out[8] <= mem[mem_addrb_int + 8];
		dob_out[9] <= mem[mem_addrb_int + 9];
		dob_out[10] <= mem[mem_addrb_int + 10];
		dob_out[11] <= mem[mem_addrb_int + 11];
		dob_out[12] <= mem[mem_addrb_int + 12];
		dob_out[13] <= mem[mem_addrb_int + 13];
		dob_out[14] <= mem[mem_addrb_int + 14];
		dob_out[15] <= mem[mem_addrb_int + 15];
	    end
	    else begin
		dob_out <= dib_int;
	    end
	end
    end

    always @(posedge clkb_int) begin
	if (enb_int == 1'b1 && web_int == 1'b1) begin
	    mem[mem_addrb_int + 0] <= dib_int[0];
	    mem[mem_addrb_int + 1] <= dib_int[1];
	    mem[mem_addrb_int + 2] <= dib_int[2];
	    mem[mem_addrb_int + 3] <= dib_int[3];
	    mem[mem_addrb_int + 4] <= dib_int[4];
	    mem[mem_addrb_int + 5] <= dib_int[5];
	    mem[mem_addrb_int + 6] <= dib_int[6];
	    mem[mem_addrb_int + 7] <= dib_int[7];
	    mem[mem_addrb_int + 8] <= dib_int[8];
	    mem[mem_addrb_int + 9] <= dib_int[9];
	    mem[mem_addrb_int + 10] <= dib_int[10];
	    mem[mem_addrb_int + 11] <= dib_int[11];
	    mem[mem_addrb_int + 12] <= dib_int[12];
	    mem[mem_addrb_int + 13] <= dib_int[13];
	    mem[mem_addrb_int + 14] <= dib_int[14];
	    mem[mem_addrb_int + 15] <= dib_int[15];
	end
    end

    specify
	(CLKA *> DOA) = (100, 100);
	(CLKB *> DOB) = (100, 100);
    endspecify

endmodule 
