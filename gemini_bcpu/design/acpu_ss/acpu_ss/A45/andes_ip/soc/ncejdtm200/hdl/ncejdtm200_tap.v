// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module ncejdtm200_tap (
	  dbg_wakeup_req,
	  tms_out_en,
	  tdi,
	  tms,
	  tdo,
	  tdo_out_en,
	  tck,
	  pwr_rst_n,
	  dmi_tap_hrdata,
	  dmi_tap_ack,
	  tap_dmi_req,
	  tap_dmi_data,
	  dtm_dmi_resetn
);

parameter DEBUG_INTERFACE = "jtag";

localparam  DMI_DATA_BITS  = 32;
localparam  DMI_ADDR_BITS  = 7;
localparam  DMI_OP_BITS    = 2;

localparam DTMCS_IDLE_CYCLES = 3'd7;

localparam JTAG_IDCODE = 32'h1000563D;

localparam TEST_LOGIC_RESET = 4'b0000;
localparam RUN_TEST_IDLE    = 4'b1000;
localparam SELECT_DR_SCAN   = 4'b1001;
localparam CAPTURE_DR	    = 4'b1010;
localparam SHIFT_DR	    = 4'b1011;
localparam EXIT1_DR	    = 4'b1100;
localparam PAUSE_DR	    = 4'b1101;
localparam EXIT2_DR	    = 4'b1110;
localparam UPDATE_DR	    = 4'b1111;
localparam SELECT_IR_SCAN   = 4'b0001;
localparam CAPTURE_IR	    = 4'b0010;
localparam SHIFT_IR	    = 4'b0011;
localparam EXIT1_IR	    = 4'b0100;
localparam PAUSE_IR	    = 4'b0101;
localparam EXIT2_IR	    = 4'b0110;
localparam UPDATE_IR	    = 4'b0111;

localparam IDCODE           = 5'b00001;
localparam DTM_CTRL_ST      = 5'b10000;
localparam DMI_ACCESS       = 5'b10001;

localparam   DMI_OP_NOP          = 2'b00;
localparam   DMI_OP_READ         = 2'b01;
localparam   DMI_OP_WRITE        = 2'b10;
localparam   DMI_OP_RSV          = 2'b11;

localparam IR_BITS = 5;

localparam DMI_REG_BITS = DMI_DATA_BITS + DMI_ADDR_BITS + DMI_OP_BITS;

output			dbg_wakeup_req;
output			tms_out_en;

input			tdi;
input			tms;
output			tdo;
output			tdo_out_en;

input			tck;
input			pwr_rst_n;

input	[31:0]			dmi_tap_hrdata;
input				dmi_tap_ack;
output				tap_dmi_req;
output	[DMI_REG_BITS-1:0]	tap_dmi_data;
output				dtm_dmi_resetn;

reg		s0;
wire		s1;

wire	s2;

wire		s3;
wire		s4;
wire		s5;
wire		s6;
wire		s7;
wire		s8;
wire		s9;
wire		s10;
wire		s11;
wire		s12;
wire		s13;
reg	[3:0]	s14;
reg	[3:0]	s15;

reg	[IR_BITS-1:0]	s16;

reg	[DMI_REG_BITS-1:0]	s17;
wire	[DMI_REG_BITS-1:0]	s18;
wire	[DMI_REG_BITS-1:0] 	s19;

reg	[1:0]	s20;
wire	[31:0]	s21;
wire	[3:0]	s22;
wire	[5:0]	s23;
wire	[2:0]	s24;
wire		s25;
wire		s26;

reg	[DMI_REG_BITS-1:0]	s27;
wire				s28;
reg				dtm_dmi_resetn;

reg tap_dmi_req;

reg	tdo;
reg	s29;
wire	s30;

wire	s31;
wire	s32;
wire	s33;
wire	s34;

reg	dbg_wakeup_req;
wire	s35;

generate
if (DEBUG_INTERFACE == "serial") begin: gen_jtag_twowire_control
	wire	s36;
	wire	s37;
	wire	s38;
	reg	s39;
	reg	s40;
	reg	s41;
	reg	s42;

	assign	tms_out_en = s42;

	assign	s33 = tms;
	assign	s34 = s3 ? s41 : tms;

	assign	s31	= s3 & ~s36 & ~s39;
	assign	s36    = s40;
	assign	s32 = s39;
	assign	s37 = s31;
	assign	s38 = s36;
	always @(posedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s40 <= 1'b0;
			s39 <= 1'b0;
		end
		else begin
			s40 <= s37;
			s39 <= s38;
		end
	end

	always @(posedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s41 <= 1'b0;
		end
		else if (s36) begin
			s41 <= tms;
		end
	end

	always @(negedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s42 <= 1'b0;
		end
		else begin
			s42 <= s39;
		end
	end
	assign  tdo_out_en = 1'b0;
end
else begin: gen_jtag_fivewire_control
	reg	s43;

	assign	s33           = tdi;
	assign	s34           = tms;
	assign	s31    = s3;
	assign	s32 = 1'b1;
	assign  tms_out_en      = 1'b0;
	assign	tdo_out_en      = s43;

	always @(negedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s43 <= 1'b0;
		end
		else if (s3) begin
			s43 <= 1'b1;
		end
		else begin
			s43 <= 1'b0;
		end
	end
end
endgenerate


assign s2 = ~s25;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		dtm_dmi_resetn <= 1'b0;
	end
	else begin
		dtm_dmi_resetn <= s2;
	end
end

assign	s1 = (s14 == TEST_LOGIC_RESET);
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s0 <= 1'b0;
	end
	else begin
		s0 <= s1;
	end
end

wire	s44;

assign	s44 = ~s3 | s32;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s15 <= TEST_LOGIC_RESET;
	end
	else if (s44) begin
		s15 <= s14;
	end
end

always @(s15 or s34) begin
	case (s15)
		RUN_TEST_IDLE: begin
			if (s34)
				s14 = SELECT_DR_SCAN;
			else
				s14 = RUN_TEST_IDLE;
		end

		SELECT_DR_SCAN: begin
			if (s34)
				s14 = SELECT_IR_SCAN;
			else
				s14 = CAPTURE_DR;
		end
		CAPTURE_DR: begin
			if (s34)
				s14 = EXIT1_DR;
			else
				s14 = SHIFT_DR;
		end
		SHIFT_DR: begin
			if (s34)
				s14 = EXIT1_DR;
			else
				s14 = SHIFT_DR;
		end
		EXIT1_DR: begin
			if (s34)
				s14 = UPDATE_DR;
			else
				s14 = PAUSE_DR;
		end
		PAUSE_DR: begin
			if (s34)
				s14 = EXIT2_DR;
			else
				s14 = PAUSE_DR;
		end
		EXIT2_DR: begin
			if (s34)
				s14 = UPDATE_DR;
			else
				s14 = SHIFT_DR;
		end
		UPDATE_DR: begin
			if (s34)
				s14 = SELECT_DR_SCAN;
			else
				s14 = RUN_TEST_IDLE;
		end

		SELECT_IR_SCAN: begin
			if (s34)
				s14 = TEST_LOGIC_RESET;
			else
				s14 = CAPTURE_IR;
		end
		CAPTURE_IR: begin
			if (s34)
				s14 = EXIT1_IR;
			else
				s14 = SHIFT_IR;
		end
		SHIFT_IR: begin
			if (s34)
				s14 = EXIT1_IR;
			else
				s14 = SHIFT_IR;
		end
		EXIT1_IR: begin
			if (s34)
				s14 = UPDATE_IR;
			else
				s14 = PAUSE_IR;
		end
		PAUSE_IR: begin
			if (s34)
				s14 = EXIT2_IR;
			else
				s14 = PAUSE_IR;
		end
		EXIT2_IR: begin
			if (s34)
				s14 = UPDATE_IR;
			else
				s14 = SHIFT_IR;
		end
		UPDATE_IR: begin
			if (s34)
				s14 = SELECT_DR_SCAN;
			else
				s14 = RUN_TEST_IDLE;
		end
		default: begin
			if (s34)
				s14 = TEST_LOGIC_RESET;
			else
				s14 = RUN_TEST_IDLE;
		end
	endcase
end

assign	s4   = (s15 == SHIFT_IR);
assign	s5 = (s15 == CAPTURE_IR);
assign	s6  = (s15 == UPDATE_IR);
assign	s7   = (s15 == SHIFT_DR);
assign	s8 = (s15 == CAPTURE_DR);
assign	s9  = (s15 == UPDATE_DR);
assign	s3 = s4 | s7;

assign	s10      = ~s11 & ~s12 & ~s13;
assign	s11      = (s16 == IDCODE);
assign	s12 = (s16 == DTM_CTRL_ST);
assign	s13  = (s16 == DMI_ACCESS);


reg	s45;
wire	s46;
wire	s47;

assign	s46 = s25 & (tap_dmi_req | dmi_tap_ack);
assign	s47 = tap_dmi_req & ~dmi_tap_ack;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s45 <= 1'b0;
	end
	else if (s46) begin
		s45 <= 1'b1;
	end
	else if (s47) begin
		s45 <= 1'b0;
	end

end

wire			    s48;
wire	[DMI_REG_BITS-1:0]  s49;
wire			    s50;
wire			    s51;
wire			    s52;
wire			    s53;
wire			    s54;

assign	s54	    = ~(tap_dmi_req | (dmi_tap_ack & ~s45));
assign	s51	    = s54 & s13 & (s27[1:0] == DMI_OP_READ) & ~s28;
assign	s52	    = s54 & s13 & (s27[1:0] == DMI_OP_WRITE) & ~s28;
assign	s53		    = (~s54 | s28) & s13;

assign	s49           = s5 ? {{(DMI_REG_BITS-IR_BITS){1'b0}}, s16} :
			      ({{(DMI_REG_BITS-32){1'b0}}, ({32{s11}} & JTAG_IDCODE)} |
			      {{(DMI_REG_BITS-32){1'b0}}, ({32{s12}} & s21)} |
			      ({s27[DMI_REG_BITS-1:2], 2'd0} & {DMI_REG_BITS{s52}}) |
			      ({s27[DMI_REG_BITS-1:34], dmi_tap_hrdata, 2'd0} & {DMI_REG_BITS{s51}}) |
			      ({s27[DMI_REG_BITS-1:34], 32'd0, 2'd3} & {DMI_REG_BITS{s53}}));
assign	s48 = (s8 & (s11 | s12 | s13)) |
			      (s5);
assign	s18 = s4 ? {{(DMI_REG_BITS-IR_BITS){1'b0}}, s33, s17[IR_BITS-1:1]} :
			      s13  ? {s33, s17[DMI_REG_BITS-1:1]} : {{(DMI_REG_BITS-32){1'b0}}, s33, s17[31:1]};
assign 	s19    = s48 ? s49 : s18;
assign	s50    = s31 | s8 | s5;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s17 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s0) begin
		s17 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s50) begin
		s17 <= s19;
	end
end

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s16 <= IDCODE;
	end
	else if (s0) begin
		s16 <= IDCODE;
	end
	else if (s6) begin
		s16 <= s17[IR_BITS-1:0];
	end
end

wire	s55;
wire	s56;

assign	s25 = s12 & s9 & s17[17];
assign	s26     = s12 & s9 & s17[16];
assign	s24	   = DTMCS_IDLE_CYCLES;
assign	s23	   = 6'd7;
assign	s22	   = 4'd1;

assign	s56  = s8 & s13 & ~s54;
assign	s55  = s26 | s0 | s25;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s20 <= 2'd0;
	end
	else if (s55) begin
		s20 <= 2'd0;
	end
	else if (s56) begin
		s20 <= 2'd3;
	end

end

assign	s21   	   = {14'b0,         1'b0,     1'b0, 1'b0, s24, s20, s23, s22};

wire	s57;
wire	s58;
wire	s59;

assign	s28  = (s20 == 2'd3);
assign	s59 	        = ^s17[1:0];
assign	s57 = s9 & s13 & s59 & ~s28;
assign	s58 = (dmi_tap_ack & ~s45) | s0 | s25;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tap_dmi_req <= 1'b0;
	end
	else if (s58) begin
		tap_dmi_req <= 1'b0;
	end
	else if (s57) begin
		tap_dmi_req <= 1'b1;
	end

end

wire	s60;

assign	s60  = s9 & s13 & ~s28;
assign	tap_dmi_data   = s27;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s27 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s0) begin
		s27 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s60) begin
		s27 <= s17;
	end
end

wire	s61;

assign	s30     = (s7 & (s10 ? s29 : s17[0])) |
		     (s4 & s17[0]);
assign	s61 = s8 | s0;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s29 <= 1'b0;
	end
	else if (s61) begin
		s29 <= 1'b0;
	end
	else if (s7 & s31) begin
		s29 <= s33;
	end
end

always @(negedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tdo <= 1'b0;
	end
	else if (s0) begin
		tdo <= 1'b0;
	end
	else if (s31)begin
		tdo <= s30;
	end
end

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		dbg_wakeup_req <= 1'b0;
	end
	else begin
		dbg_wakeup_req <= s35;
	end
end

assign s35 = dbg_wakeup_req | (s15 != TEST_LOGIC_RESET);

endmodule
