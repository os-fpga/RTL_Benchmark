// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module nceplmt100_rtc (
		  mtime_clk,
		  por_rstn,
		  mtime_shadow,
		  mtime_shadow_gray,
		  mtime,
		  mtime_gray,
		  stoptime_sync,
		  update_req_sync,
		  update_ack
);

parameter GRAY_WIDTH = 4;

input		                mtime_clk;
input		                por_rstn;
input	[63:GRAY_WIDTH]         mtime_shadow;
input	[GRAY_WIDTH-1:0]        mtime_shadow_gray;
output	[63:GRAY_WIDTH]         mtime;
output	[GRAY_WIDTH-1:0]        mtime_gray;
input	                        stoptime_sync;

input           		update_req_sync;
output		                update_ack;

reg		                s0;
reg	[63:GRAY_WIDTH]         mtime;

reg	[GRAY_WIDTH-1:0]	mtime_gray;
wire	[GRAY_WIDTH-1:0]	s1;

wire	[63:GRAY_WIDTH]         s2;
wire    [63:GRAY_WIDTH]         s3;
wire	                        s4;
wire	                        s5;
wire	                        s6;

reg     [GRAY_WIDTH-1:0]        s7;
wire    [GRAY_WIDTH-1:0]        s8;

wire                            s9;
wire                            s10;

always @(posedge mtime_clk or negedge por_rstn) begin
	if (!por_rstn) begin
		s0 <= 1'b0;
	end
	else begin
		s0 <= update_req_sync;
	end
end

always @(posedge mtime_clk or negedge por_rstn) begin
	if (!por_rstn) begin
		mtime <= {(64-GRAY_WIDTH){1'b0}};
	end
	else if (s5) begin
		mtime <= s2;
	end
end

always @(posedge mtime_clk or negedge por_rstn) begin
	if (!por_rstn) begin
		mtime_gray <= {GRAY_WIDTH{1'b0}};
	end
	else if (s4) begin
		mtime_gray <= s1;
	end
end

assign s1 = s6 ?  mtime_shadow_gray
					    : (s8 ^ {1'b0, s8[GRAY_WIDTH-1:1]});

integer s11;
always @* begin
        s7[GRAY_WIDTH-1] = mtime_gray[GRAY_WIDTH-1];
        for (s11 = GRAY_WIDTH-2; s11 >= 0; s11 = s11 - 1) begin
                s7[s11] = s7[s11+1] ^ mtime_gray[s11];
        end
end

assign s8 = s7 + {{(GRAY_WIDTH-1){1'b0}}, 1'b1};

assign update_ack = s0;

assign s6 = update_req_sync & ~update_ack;

assign s3 = mtime + {{(64-GRAY_WIDTH-1){1'b0}}, 1'b1};
assign s2    = s6 ? mtime_shadow : s3;

assign s9  = mtime_gray[GRAY_WIDTH-1] & ~|mtime_gray[GRAY_WIDTH-2:0];
assign s10 = s9 & ~stoptime_sync;

assign s4 = s6 | ~stoptime_sync;
assign s5      = s6 |  s10;

endmodule

