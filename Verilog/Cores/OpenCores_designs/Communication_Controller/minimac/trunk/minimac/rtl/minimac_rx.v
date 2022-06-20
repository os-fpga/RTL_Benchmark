/*
 * Milkymist VJ SoC
 * Copyright (C) 2007, 2008, 2009, 2010 Sebastien Bourdeauducq
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

module minimac_rx(
	input sys_clk,
	input sys_rst,
	input rx_rst,

	output [31:0] wbm_adr_o,
	output wbm_cyc_o,
	output wbm_stb_o,
	input wbm_ack_i,
	output reg [31:0] wbm_dat_o,

	input rx_valid,
	input [29:0] rx_adr,
	output rx_resetcount,
	output rx_incrcount,
	output rx_endframe,

	output fifo_full,

	input phy_rx_clk,
	input [3:0] phy_rx_data,
	input phy_dv,
	input phy_rx_er
);

reg rx_resetcount_r;
reg rx_endframe_r;
assign rx_resetcount = rx_resetcount_r;
assign rx_endframe = rx_endframe_r;

reg bus_stb;
assign wbm_cyc_o = bus_stb;
assign wbm_stb_o = bus_stb;

wire fifo_empty;
reg fifo_ack;
wire fifo_eof;
wire [7:0] fifo_data;
minimac_rxfifo rxfifo(
	.sys_clk(sys_clk),
	.rx_rst(rx_rst),

	.phy_rx_clk(phy_rx_clk),
	.phy_rx_data(phy_rx_data),
	.phy_dv(phy_dv),
	.phy_rx_er(phy_rx_er),

	.empty(fifo_empty),
	.ack(fifo_ack),
	.eof(fifo_eof),
	.data(fifo_data),

	.fifo_full(fifo_full)
);

reg start_of_frame;
reg end_of_frame;
reg in_frame;
always @(posedge sys_clk) begin
	if(sys_rst|rx_rst)
		in_frame <= 1'b0;
	else begin
		if(start_of_frame)
			in_frame <= 1'b1;
		if(end_of_frame)
			in_frame <= 1'b0;
	end
end

reg loadbyte_en;
reg [1:0] loadbyte_counter;
always @(posedge sys_clk) begin
	if(sys_rst|rx_rst)
		loadbyte_counter <= 1'b0;
	else begin
		if(start_of_frame)
			loadbyte_counter <= 1'b0;
		else if(loadbyte_en)
			loadbyte_counter <= loadbyte_counter + 2'd1;
		if(loadbyte_en) begin
			case(loadbyte_counter)
				2'd0: wbm_dat_o[31:24] <= fifo_data;
				2'd1: wbm_dat_o[23:16] <= fifo_data;
				2'd2: wbm_dat_o[15: 8] <= fifo_data;
				2'd3: wbm_dat_o[ 7: 0] <= fifo_data;
			endcase
		end
	end
end
wire full_word = &loadbyte_counter;
wire empty_word = loadbyte_counter == 2'd0;

parameter MTU = 11'd1530;

reg [10:0] maxcount;
always @(posedge sys_clk) begin
	if(sys_rst|rx_rst)
		maxcount <= MTU;
	else begin
		if(start_of_frame)
			maxcount <= MTU;
		else if(loadbyte_en)
			maxcount <= maxcount - 11'd1;
	end
end
wire still_place = |maxcount;

assign rx_incrcount = loadbyte_en;

reg next_wb_adr;
reg [29:0] adr;
always @(posedge sys_clk) begin
	if(sys_rst)
		adr <= 30'd0;
	else begin
		if(start_of_frame)
			adr <= rx_adr;
		if(next_wb_adr)
			adr <= adr + 30'd1;
	end
end
assign wbm_adr_o = {adr, 2'd0};

reg [2:0] state;
reg [2:0] next_state;

parameter IDLE		= 3'd0;
parameter LOADBYTE	= 3'd1;
parameter WBSTROBE	= 3'd2;
parameter SENDLAST	= 3'd3;
parameter NOMORE	= 3'd3;

always @(posedge sys_clk) begin
	if(sys_rst)
		state <= IDLE;
	else
		state <= next_state;
end

always @(*) begin
	next_state = state;
	fifo_ack = 1'b0;

	rx_resetcount_r = 1'b0;
	rx_endframe_r = 1'b0;

	start_of_frame = 1'b0;
	end_of_frame = 1'b0;

	loadbyte_en = 1'b0;

	bus_stb = 1'b0;

	next_wb_adr = 1'b0;

	case(state)
		IDLE: begin
			if(~fifo_empty & rx_valid) begin
				if(fifo_eof) begin
					fifo_ack = 1'b1;
					if(in_frame) begin
						if(fifo_data[0])
							rx_resetcount_r = 1'b1;
						else begin
							if(empty_word)
								rx_endframe_r = 1'b1;
							else
								next_state = SENDLAST;
						end
						end_of_frame = 1'b1;
					end
				end else begin
					if(~in_frame)
						start_of_frame = 1'b1;
					next_state = LOADBYTE;
				end
			end
		end
		LOADBYTE: begin
			loadbyte_en = 1'b1;
			fifo_ack = 1'b1;
			if(full_word & rx_valid)
				next_state = WBSTROBE;
			else
				next_state = IDLE;
		end
		WBSTROBE: begin
			bus_stb = 1'b1;
			if(wbm_ack_i) begin
				if(still_place)
					next_state = IDLE;
				else
					next_state = NOMORE;
				next_wb_adr = 1'b1;
			end
		end
		SENDLAST: begin
			bus_stb = 1'b1;
			if(wbm_ack_i) begin
				rx_endframe_r = 1'b1;
				next_state = IDLE;
			end
		end
		NOMORE: begin
			fifo_ack = 1'b1;
			if(~fifo_empty & rx_valid) begin
				if(fifo_eof) begin
					rx_resetcount_r = 1'b1;
					end_of_frame = 1'b1;
					next_state = IDLE;
				end
			end
		end
	endcase
end

endmodule
