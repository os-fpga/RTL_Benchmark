
`include "global.inc"
    `ifdef N22_HAS_DEBUG_PRIVATE
module n22_dtm_tap (
          reset_bypass,
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

input           reset_bypass;
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

wire s0 = reset_bypass ? tck : ~tck;

reg		s1;
wire		s2;

wire	s3;

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
wire		s14;
reg	[3:0]	s15;
reg	[3:0]	s16;

reg	[IR_BITS-1:0]	s17;

reg	[DMI_REG_BITS-1:0]	s18;
wire	[DMI_REG_BITS-1:0]	s19;
wire	[DMI_REG_BITS-1:0] 	s20;


wire [`N22_XLEN-1:0] s21 = 32'h0fff442C;
wire [`N22_XLEN-1:0] s22 = 32'h00011211;
wire [`N22_XLEN-1:0] s23 = (s21 + s22);

reg	[1:0]	s24;
wire	[31:0]	s25;
wire	[3:0]	s26;
wire	[5:0]	s27;
wire	[2:0]	s28;
wire		s29;
wire		s30;

reg	[DMI_REG_BITS-1:0]	s31;
wire				s32;
reg				dtm_dmi_resetn;

reg tap_dmi_req;

reg	tdo;
reg	s33;
wire	s34;

wire	s35;
wire	s36;
wire	s37;
wire	s38;

generate
if (DEBUG_INTERFACE == "serial") begin: gen_jtag_twowire_control
	wire	s39;
	wire	s40;
	wire	s41;
	reg	s42;
	reg	s43;
	reg	s44;
	reg	s45;

	assign	tms_out_en = s45;

	assign	s37 = tms;
	assign	s38 = s4 ? s44 : tms;

	assign	s35	= s4 & ~s39 & ~s42;
	assign	s39    = s43;
	assign	s36 = s42;
	assign	s40 = s35;
	assign	s41 = s39;
	always @(posedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s43 <= 1'b0;
			s42 <= 1'b0;
		end
		else begin
			s43 <= s40;
			s42 <= s41;
		end
	end

	always @(posedge tck or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s44 <= 1'b0;
		end
		else if (s39) begin
			s44 <= tms;
		end
	end

	always @(posedge s0 or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s45 <= 1'b0;
		end
		else begin
			s45 <= s42;
		end
	end
	assign tdo_out_en = 1'b0;
end
else begin: gen_jtag_fivewire_control
	reg s46;

	assign	s37           = tdi;
	assign	s38           = tms;
	assign	s35    = s4;
	assign	s36 = 1'b1;
	assign  tms_out_en      = 1'b0;
	assign	tdo_out_en      = s46;

	always @(posedge s0 or negedge pwr_rst_n) begin
		if (!pwr_rst_n) begin
			s46 <= 1'b0;
		end
		else if (s4) begin
			s46 <= 1'b1;
		end
		else begin
			s46 <= 1'b0;
		end
	end
end
endgenerate


assign s3 = ~s29;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		dtm_dmi_resetn <= 1'b0;
	end
	else begin
		dtm_dmi_resetn <= s3;
	end
end

assign	s2 = (s15 == TEST_LOGIC_RESET);
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s1 <= 1'b0;
	end
	else begin
		s1 <= s2;
	end
end

wire	s47;

assign	s47 = ~s4 | s36;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s16 <= TEST_LOGIC_RESET;
	end
	else if (s47) begin
		s16 <= s15;
	end
end

always @(s16 or s38) begin
	case (s16)
		RUN_TEST_IDLE: begin
			if (s38)
				s15 = SELECT_DR_SCAN;
			else
				s15 = RUN_TEST_IDLE;
		end

		SELECT_DR_SCAN: begin
			if (s38)
				s15 = SELECT_IR_SCAN;
			else
				s15 = CAPTURE_DR;
		end
		CAPTURE_DR: begin
			if (s38)
				s15 = EXIT1_DR;
			else
				s15 = SHIFT_DR;
		end
		SHIFT_DR: begin
			if (s38)
				s15 = EXIT1_DR;
			else
				s15 = SHIFT_DR;
		end
		EXIT1_DR: begin
			if (s38)
				s15 = UPDATE_DR;
			else
				s15 = PAUSE_DR;
		end
		PAUSE_DR: begin
			if (s38)
				s15 = EXIT2_DR;
			else
				s15 = PAUSE_DR;
		end
		EXIT2_DR: begin
			if (s38)
				s15 = UPDATE_DR;
			else
				s15 = SHIFT_DR;
		end
		UPDATE_DR: begin
			if (s38)
				s15 = SELECT_DR_SCAN;
			else
				s15 = RUN_TEST_IDLE;
		end

		SELECT_IR_SCAN: begin
			if (s38)
				s15 = TEST_LOGIC_RESET;
			else
				s15 = CAPTURE_IR;
		end
		CAPTURE_IR: begin
			if (s38)
				s15 = EXIT1_IR;
			else
				s15 = SHIFT_IR;
		end
		SHIFT_IR: begin
			if (s38)
				s15 = EXIT1_IR;
			else
				s15 = SHIFT_IR;
		end
		EXIT1_IR: begin
			if (s38)
				s15 = UPDATE_IR;
			else
				s15 = PAUSE_IR;
		end
		PAUSE_IR: begin
			if (s38)
				s15 = EXIT2_IR;
			else
				s15 = PAUSE_IR;
		end
		EXIT2_IR: begin
			if (s38)
				s15 = UPDATE_IR;
			else
				s15 = SHIFT_IR;
		end
		UPDATE_IR: begin
			if (s38)
				s15 = SELECT_DR_SCAN;
			else
				s15 = RUN_TEST_IDLE;
		end
		default: begin
			if (s38)
				s15 = TEST_LOGIC_RESET;
			else
				s15 = RUN_TEST_IDLE;
		end
	endcase
end

assign	s5   = (s16 == SHIFT_IR);
assign	s6 = (s16 == CAPTURE_IR);
assign	s7  = (s16 == UPDATE_IR);
assign	s8   = (s16 == SHIFT_DR);
assign	s9 = (s16 == CAPTURE_DR);
assign	s10  = (s16 == UPDATE_DR);
assign	s4 = s5 | s8;

assign	s11      = ~s12 & ~s13 & ~s14;
assign	s12      = (s17 == IDCODE);
assign	s13 = (s17 == DTM_CTRL_ST);
assign	s14  = (s17 == DMI_ACCESS);


reg	s48;
wire	s49;
wire	s50;

assign	s49 = s29 & (tap_dmi_req | dmi_tap_ack);
assign	s50 = tap_dmi_req & ~dmi_tap_ack;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s48 <= 1'b0;
	end
	else if (s49) begin
		s48 <= 1'b1;
	end
	else if (s50) begin
		s48 <= 1'b0;
	end

end

wire			    s51;
wire	[DMI_REG_BITS-1:0]  s52;
wire			    s53;
wire			    s54;
wire			    s55;
wire			    s56;
wire			    s57;

assign	s57	    = ~(tap_dmi_req | (dmi_tap_ack & ~s48));
assign	s54	    = s57 & s14 & (s31[1:0] == DMI_OP_READ) & ~s32;
assign	s55	    = s57 & s14 & (s31[1:0] == DMI_OP_WRITE) & ~s32;
assign	s56		    = (~s57 | s32) & s14;

assign	s52           = s6 ? {{(DMI_REG_BITS-IR_BITS){1'b0}}, s17} :
			      ({{(DMI_REG_BITS-32){1'b0}}, ({32{s12}} & s23)} |
			      {{(DMI_REG_BITS-32){1'b0}}, ({32{s13}} & s25)} |
			      ({s31[DMI_REG_BITS-1:2], 2'd0} & {DMI_REG_BITS{s55}}) |
			      ({s31[DMI_REG_BITS-1:34], dmi_tap_hrdata, 2'd0} & {DMI_REG_BITS{s54}}) |
			      ({s31[DMI_REG_BITS-1:34], 32'd0, 2'd3} & {DMI_REG_BITS{s56}}));
assign	s51 = (s9 & (s12 | s13 | s14)) |
			      (s6);
assign	s19 = s5 ? {{(DMI_REG_BITS-IR_BITS){1'b0}}, s37, s18[IR_BITS-1:1]} :
			      s14  ? {s37, s18[DMI_REG_BITS-1:1]} : {{(DMI_REG_BITS-32){1'b0}}, s37, s18[31:1]};
assign 	s20    = s51 ? s52 : s19;
assign	s53    = s35 | s9 | s6;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s18 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s1) begin
		s18 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s53) begin
		s18 <= s20;
	end
end

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s17 <= IDCODE;
	end
	else if (s1) begin
		s17 <= IDCODE;
	end
	else if (s7) begin
		s17 <= s18[IR_BITS-1:0];
	end
end

wire	s58;
wire	s59;

assign	s29 = s13 & s10 & s18[17];
assign	s30     = s13 & s10 & s18[16];
assign	s28	   = DTMCS_IDLE_CYCLES;
assign	s27	   = 6'd7;
assign	s26	   = 4'd1;

assign	s59  = s9 & s14 & ~s57;
assign	s58  = s30 | s1 | s29;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s24 <= 2'd0;
	end
	else if (s58) begin
		s24 <= 2'd0;
	end
	else if (s59) begin
		s24 <= 2'd3;
	end

end

assign	s25   	   = {14'b0,         1'b0,     1'b0, 1'b0, s28, s24, s27, s26};

wire	s60;
wire	s61;
wire	s62;

assign	s32  = (s24 == 2'd3);
assign	s62 	        = ^s18[1:0];
assign	s60 = s10 & s14 & s62 & ~s32;
assign	s61 = (dmi_tap_ack & ~s48) | s1 | s29;
always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tap_dmi_req <= 1'b0;
	end
	else if (s61) begin
		tap_dmi_req <= 1'b0;
	end
	else if (s60) begin
		tap_dmi_req <= 1'b1;
	end

end


wire	s63;

assign	s63  = s10 & s14 & ~s32;
assign	tap_dmi_data   = s31;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s31 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s1) begin
		s31 <= {(DMI_REG_BITS){1'b0}};
	end
	else if (s63) begin
		s31 <= s18;
	end
end

wire	s64;

assign	s34     = (s8 & (s11 ? s33 : s18[0])) |
		     (s5 & s18[0]);
assign	s64 = s9 | s1;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		s33 <= 1'b0;
	end
	else if (s64) begin
		s33 <= 1'b0;
	end
	else if (s8 & s35) begin
		s33 <= s37;
	end
end

always @(posedge s0 or negedge pwr_rst_n) begin
	if (!pwr_rst_n) begin
		tdo <= 1'b0;
	end
	else if (s1) begin
		tdo <= 1'b0;
	end
	else if (s35)begin
		tdo <= s34;
	end
end



endmodule
`endif
