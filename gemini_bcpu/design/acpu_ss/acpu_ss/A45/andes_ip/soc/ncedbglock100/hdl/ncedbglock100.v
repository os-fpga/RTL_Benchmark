// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module ncedbglock100(
		  tck,
		  pwr_rst_n,
		  secure_mode,
		  secure_code,
		  tms_i,
		  tms_o
);

localparam PRODUCT_ID = 32'h0c050001;

localparam SECURE_WIDTH = 128;
localparam SECURE_UNIT = 8;
localparam SECURE_LENGTH = SECURE_WIDTH / SECURE_UNIT;

localparam SHIFT_WIDTH = $clog2(SECURE_UNIT);
localparam SHIFT_LAST = SECURE_UNIT - 1;
localparam PACKAGE_WIDTH = $clog2(SECURE_LENGTH);
localparam PACKAGE_LAST = SECURE_LENGTH - 1;

localparam ST_IDLE     = 3'b001;
localparam ST_SHIFT    = 3'b010;
localparam ST_ACK      = 3'b100;
localparam ST_DONE     = 3'b011;
localparam ST_DONE_ACK = 3'b101;

input				tck;
input				pwr_rst_n;
input	[1:0]			secure_mode;
input	[127:0]			secure_code;
input				tms_i;
output				tms_o;

reg	[2:0]			pwr_rst_n_r;
wire				rst_n;
reg				init_done;
reg	[2:0]			secure_cs;
reg	[2:0]			secure_ns;
reg				tms_disabled;
reg				tms_unlockable;

reg	[(SHIFT_WIDTH-1):0]	shift_counter;
reg	[(PACKAGE_WIDTH-1):0]	package_counter;

reg	[(SECURE_UNIT-1):0]	shift_code;
wire				key_match;

always @(posedge tck or negedge pwr_rst_n) begin
	if (!pwr_rst_n)
		pwr_rst_n_r <= 3'b0;
	else if (!pwr_rst_n_r[2])
		pwr_rst_n_r <= {pwr_rst_n_r[1:0],1'b1};
end

assign rst_n      = pwr_rst_n_r[1];

always @(posedge tck or negedge rst_n) begin
	if (!rst_n)
		init_done <= 1'b0;
	else if (!init_done)
		init_done <= 1'b1;
end

always @(posedge tck or negedge rst_n) begin
	if (!rst_n)
		secure_cs <= ST_IDLE;
	else
		secure_cs <= secure_ns;
end

always @* begin
	case(secure_cs)
		ST_IDLE: begin
			if ((&shift_code) && tms_i && tms_unlockable)
				secure_ns = ST_SHIFT;
			else
				secure_ns = ST_IDLE;
		end
		ST_SHIFT: begin
			if (shift_counter == SHIFT_LAST[(SHIFT_WIDTH-1):0])
				secure_ns = ST_ACK;
			else
				secure_ns = ST_SHIFT;
		end
		ST_ACK: begin
			if (!tms_i && key_match) begin
				if (package_counter == PACKAGE_LAST[(PACKAGE_WIDTH-1):0])
					secure_ns = ST_DONE;
				else
					secure_ns = ST_SHIFT;
			end
			else begin
				if ((&shift_code) && tms_i)
					secure_ns = ST_SHIFT;
				else
					secure_ns = ST_IDLE;
			end
		end
		ST_DONE: begin
			if (shift_counter == SHIFT_LAST[(SHIFT_WIDTH-1):0])
				secure_ns = ST_DONE_ACK;
			else
				secure_ns = ST_DONE;
		end
		ST_DONE_ACK: begin
					secure_ns = ST_IDLE;
		end
		default: secure_ns = 3'b0;
	endcase
end

always @(posedge tck or negedge rst_n) begin
	if (!rst_n)
		shift_counter <= {(SHIFT_WIDTH){1'b0}};
	else if (secure_cs[2])
		shift_counter <= {(SHIFT_WIDTH){1'b0}};
	else if (secure_cs[1])
		shift_counter <= shift_counter + {{(SHIFT_WIDTH-1){1'b0}}, 1'b1};
end

always @(posedge tck or negedge rst_n) begin
	if (!rst_n)
		package_counter <= {(PACKAGE_WIDTH){1'b0}};
	else if (secure_cs[0] | (secure_cs[2] & (!key_match | tms_i)))
		package_counter <= {(PACKAGE_WIDTH){1'b0}};
	else if (secure_cs[2])
		package_counter <= package_counter + {{(PACKAGE_WIDTH-1){1'b0}}, 1'b1};
end

always @(posedge tck or negedge rst_n)
	if (!rst_n)
		shift_code <= {SECURE_UNIT{1'b0}};
	else
		shift_code <= {shift_code[(SECURE_UNIT-2):0], tms_i};

assign key_match = (secure_code[(package_counter*SECURE_UNIT)+:SECURE_UNIT] == shift_code);

always @(posedge tck or negedge rst_n) begin
	if (!rst_n)
		tms_disabled <= 1'b1;
	else if (!init_done)
		tms_disabled <= secure_mode[0];
	else if (secure_cs[2] && secure_cs[0] && (&shift_code) && tms_i)
		tms_disabled <= 1'b0;
end

always @(posedge tck or negedge rst_n) begin
	if (!rst_n)
		tms_unlockable <= 1'b1;
	else if (!init_done)
		tms_unlockable <= secure_mode[1];
end

assign	tms_o = tms_i | tms_disabled;

endmodule
