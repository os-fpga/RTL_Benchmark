// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`timescale 1ps/1ps

module ahb_sim_control (
	  hclk,
	  hresetn,
	  haddr,
	  htrans,
	  hwrite,
	  hsize,
	  hburst,
	  hprot,
	  hwdata,
	  hreadyi,
	  hsel,
	  hmaster,
	  hrdata,
	  hresp,
	  hready,
	  hsplit
);

parameter DATA_WIDTH = 32;
parameter BWE        = DATA_WIDTH/8;

parameter [19:0] BASE = 20'h8_0000;

parameter HMASTER_START = 4'd1;

parameter MIN_HREADY_CYCLES = 32'd0;
parameter DEV_HREADY_CYCLES = 32'd10;
parameter MIN_HSPLIT_CYCLES = 32'd0;
parameter DEV_HSPLIT_CYCLES = 32'd10;

parameter AHB_RESP_OKAY  = 2'b00;
parameter AHB_RESP_ERROR = 2'b01;
parameter AHB_RESP_RETRY = 2'b10;
parameter AHB_RESP_SPLIT = 2'b11;

parameter MSG_PAGE0 = BASE;
parameter MSG_PAGE1 = (BASE + 20'd4);
parameter MSG_PAGE2 = (BASE + 20'd8);
parameter MSG_PAGE4 = (BASE + 20'd16);

parameter RUN_HART_NUM = 1;
input		hclk;
input		hresetn;

input [31:0]	haddr;
input [1:0]	htrans;
input		hwrite;
input [2:0]	hsize;
input [2:0]	hburst;
input [3:0]	hprot;
input [DATA_WIDTH-1:0]	hwdata;
input		hreadyi;
input		hsel;
input [3:0]	hmaster;

output [DATA_WIDTH-1:0]	hrdata;

output [1:0]	hresp;
output		hready;
output [15:0]	hsplit;

wire [DATA_WIDTH-1:0]	hrdata;
wire [DATA_WIDTH-1:0]	hrdata_out;
reg  [63:0]		hrdata_out_64b;
wire  [1:0]	hresp;
reg		hready;
wire [15:0]	hsplit;

wire		wr_en;
wire		rd_en;
wire		rd_en3;
wire		block_rdata_valid;
wire [31:0]	valid_rd_addr;
reg		wr_data_phase;
reg		rd_data_phase;
reg		update_rd_data;
reg [31:0]	valid_haddr;
reg		rd_en_d1;
reg		rd_en3_d1;

reg [31:0]	temp1;
reg [31:0]	temp2;
reg [31:0]	temp3;
reg [31:0]	temp4;
reg [31:0]	temp5;
reg [31:0]	temp6;
reg [31:0]	temp7;


reg [31:0]	simctl_p_0;
reg [31:0]	simctl_p_1;
reg [31:0]	simctl_p_2;
reg [31:0]	simctl_p_3;
reg [31:0]	simctl_p_4;
reg [31:0]	simctl_p_5;
reg [31:0]	simctl_p_6;
reg [31:0]	simctl_p_7;
reg [31:0]	simctl_p_8;
reg [31:0]	simctl_p_9;
reg [31:0]	simctl_p_10;
reg [31:0]	simctl_p_11;
reg [31:0]	simctl_p_12;
reg [31:0]	simctl_p_13;
reg [31:0]	simctl_p_14;
reg [31:0]	simctl_p_15;
reg		temp1wen, temp1wen_d1;
reg		temp2wen, temp2wen_d1;
reg		temp3wen, temp3wen_d1;
reg		temp4wen, temp4wen_d1;
reg		temp5wen, temp5wen_d1;
reg		temp6wen, temp6wen_d1;
reg		temp7wen, temp7wen_d1;
reg [3:0]	hmaster_reg;
reg [3:0]	hmaster_reg_d1;


reg		simctl_p_0wen;
reg		simctl_p_1wen;
reg		simctl_p_2wen;
reg		simctl_p_3wen;
reg		simctl_p_4wen;
reg		simctl_p_5wen;
reg		simctl_p_6wen;
reg		simctl_p_7wen;
reg		simctl_p_8wen;
reg		simctl_p_9wen;
reg		simctl_p_10wen;
reg		simctl_p_11wen;
reg		simctl_p_12wen;
reg		simctl_p_13wen;
reg		simctl_p_14wen;
reg		simctl_p_15wen;

reg [7:0]	wbe;
reg [7:0]	tempwbe_d1;

integer		finish_status;
event		event_finish;
integer		finish_cnt;


event		event_model_0;
event		event_model_1;
event		event_model_2;
event		event_model_3;
event		event_model_4;
event		event_model_5;
event		event_model_6;
event		event_model_7;
event		event_model_8;
event		event_model_9;
event		event_model_10;
event		event_model_11;
event		event_model_12;
event		event_model_13;
event		event_model_14;
event		event_model_15;


reg [3:0]	target_core_id;
reg [3:0] 	force_cosim_cid;
reg [3:0] 	target_hmaster;
reg [DATA_WIDTH-1:0] 	default_data;
reg [31:0]	seed;

initial begin
	force_cosim_cid = 4'b0;

	if (!$value$plusargs("nds_core_id=%d", target_core_id))
		target_core_id = 4'd0;

	if ($value$plusargs("force_cosim_cid=%d", force_cosim_cid)) begin
		target_core_id = force_cosim_cid;
	end

	target_hmaster = HMASTER_START + target_core_id;

	if (!$value$plusargs("nds_default_hrdata=%h", default_data))
		default_data = {DATA_WIDTH{1'b0}};
	$display("%0t: default hrdata of %m is set to 0x%h", $time, default_data);

	finish_cnt = 0;
end

initial begin
        if ($value$plusargs("seed=%d", seed))
                seed = seed ^ 32'h44495936;
        else
                seed = 32'h44495936;
end

wire [63:0] hwdata_64b;

generate
if (DATA_WIDTH == 32) begin : gen_hwdata_32
	assign hwdata_64b = {32'h0, hwdata};
end
else if (DATA_WIDTH == 64) begin : gen_hwdata_64
	assign hwdata_64b = hwdata;
end
else begin : gen_hwdata_bigger_64
	wire [DATA_WIDTH-1:0] shifted_hwdata;
	assign shifted_hwdata = hwdata >> (64 * valid_haddr[($clog2(DATA_WIDTH)-4):3]);
	assign hwdata_64b = shifted_hwdata[63:0];
end
endgenerate

always @(posedge hclk) begin
	if (hsel && htrans[1] && hreadyi && (hsize[2:0] >= 3'b100)) begin
                $display("%0t:ahb_sim_control:ERROR:ahb_sim_control does not support 128-bit read/write", $time);
        	#10 $finish;
	end
end

always @(posedge hclk) begin
	if (hreadyi) begin
	if (DATA_WIDTH == 32) begin
		case (hsize[1:0])
		2'b00: begin
			wbe[3] <= (haddr[1:0] == 2'b11);
			wbe[2] <= (haddr[1:0] == 2'b10);
			wbe[1] <= (haddr[1:0] == 2'b01);
			wbe[0] <= (haddr[1:0] == 2'b00);
	        end

		2'b01: begin
			wbe[3:2] <= {  haddr[1],  haddr[1] };
			wbe[1:0] <= { ~haddr[1], ~haddr[1] };
		end

		2'b10:
			wbe[3:0] <= 4'b1111;

		default:
			wbe[3:0] <= 4'b0000;
		endcase
		wbe[7:4] <= 4'b0000;
	end
	else begin
		case (hsize[1:0])
		2'b00: begin
			wbe[7] <= (haddr[2:0] == 3'b111);
			wbe[6] <= (haddr[2:0] == 3'b110);
			wbe[5] <= (haddr[2:0] == 3'b101);
			wbe[4] <= (haddr[2:0] == 3'b100);
			wbe[3] <= (haddr[2:0] == 3'b011);
			wbe[2] <= (haddr[2:0] == 3'b010);
			wbe[1] <= (haddr[2:0] == 3'b001);
			wbe[0] <= (haddr[2:0] == 3'b000);
	        end

		2'b01: begin
			wbe[7:6] <= {2{(haddr[2]  &  haddr[1])}};
			wbe[5:4] <= {2{(haddr[2]  & ~haddr[1])}};
			wbe[3:2] <= {2{(~haddr[2] &  haddr[1])}};
			wbe[1:0] <= {2{(~haddr[2] & ~haddr[1])}};
		end

		2'b10: begin
			wbe[7:4] <= {4{haddr[2]}};
			wbe[3:0] <= {4{~haddr[2]}};
		end

		2'b11: begin
			wbe[7:0] <= 8'b11111111;
		end

		default:
			wbe[7:0] <= 8'b0;
		endcase
	end
	end
end

always @(negedge hresetn or posedge hclk) begin
	if (~hresetn) begin
		wr_data_phase <= 1'b0;
		rd_data_phase <= 1'b0;
	end
	else if (hreadyi) begin
		wr_data_phase <= hsel & hwrite & htrans[1];
		rd_data_phase <= hsel & ~hwrite & htrans[1];
	end
end

always @(negedge hresetn or posedge hclk) begin
	if (~hresetn)
		update_rd_data <= 1'b0;
	else if (update_rd_data)
		update_rd_data <= 1'b0;
	else if (block_rdata_valid)
		update_rd_data <= 1'b1;
end

always @(negedge hresetn or posedge hclk) begin
	if (~hresetn)
		valid_haddr <= 32'h0;
	else if (hsel & hreadyi)
		valid_haddr <= haddr;
end

always @(negedge hresetn or posedge hclk) begin
	if (~hresetn) begin
		rd_en_d1 <= 1'b0;
		rd_en3_d1 <= 1'b0;

	end
	else begin
		rd_en_d1 <= rd_en;
		rd_en3_d1 <= rd_en3;
	end
end

assign block_rdata_valid = wr_data_phase && (hsel & hreadyi & (~hwrite) & htrans[1]);
assign valid_rd_addr = update_rd_data ? valid_haddr : haddr;

assign rd_en = hsel && (~hwrite) && htrans[1] && hreadyi && (haddr[19:8]== 12'h8_10);
assign rd_en3 = hsel && (~hwrite) && htrans[1] && hreadyi && (haddr[19:4]==MSG_PAGE4[19:4]);

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn) begin
	end
	else if ((DATA_WIDTH == 32) && wr_data_phase && (valid_haddr[19:2] == valid_rd_addr[19:2])) begin
		hrdata_out_64b[63:32] <= 32'h0;
		if (rd_en || (update_rd_data & rd_en_d1)) begin

			case (valid_rd_addr[7:2])
			6'h0:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_0[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_0[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_0[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_0[31:24];
				end
			6'h1:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_1[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_1[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_1[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_1[31:24];
				end
			6'h2:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_2[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_2[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_2[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_2[31:24];
				end
			6'h3:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_3[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_3[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_3[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_3[31:24];
				end
			6'h4:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_4[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_4[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_4[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_4[31:24];
				end
			6'h5:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_5[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_5[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_5[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_5[31:24];
				end
			6'h6:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_6[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_6[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_6[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_6[31:24];
				end
			6'h7:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_7[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_7[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_7[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_7[31:24];
				end
			6'h8:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_8[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_8[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_8[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_8[31:24];
				end
			6'h9:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_9[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_9[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_9[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_9[31:24];
				end
			6'ha:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_10[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_10[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_10[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_10[31:24];
				end
			6'hb:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_11[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_11[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_11[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_11[31:24];
				end
			6'hc:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_12[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_12[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_12[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_12[31:24];
				end
			6'hd:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_13[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_13[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_13[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_13[31:24];
				end
			6'he:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_14[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_14[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_14[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_14[31:24];
				end
			6'hf:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_15[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_15[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_15[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_15[31:24];
				end
			default:
				hrdata_out_64b[31:0] <= 32'h0;
			endcase
		end
		else if (rd_en3 || (update_rd_data & rd_en3_d1)) begin

			case (valid_rd_addr[3:2])
			2'h0:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : temp4[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : temp4[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : temp4[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : temp4[31:24];
				end
			2'h1:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : temp5[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : temp5[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : temp5[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : temp5[31:24];
				end
			2'h2:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : temp6[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : temp6[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : temp6[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : temp6[31:24];
				end
			2'h3:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : temp7[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : temp7[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : temp7[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : temp7[31:24];
				end
			default:
				hrdata_out_64b[31:0] <= 32'h0;
			endcase
		end
	end
	else if ((DATA_WIDTH == 64) && wr_data_phase && (valid_haddr[19:3] == valid_rd_addr[19:3])) begin
		if (rd_en || (update_rd_data & rd_en_d1)) begin

			case (valid_rd_addr[7:3])
			5'h0:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_0[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_0[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_0[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_0[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_1[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_1[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_1[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_1[31:24];
				end
			5'h1:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_2[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_2[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_2[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_2[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_3[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_3[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_3[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_3[31:24];
				end
			5'h2:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_4[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_4[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_4[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_4[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_5[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_5[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_5[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_5[31:24];
				end
			5'h3:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_6[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_6[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_6[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_6[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_7[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_7[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_7[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_7[31:24];
				end
			5'h4:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_8[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_8[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_8[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_8[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_9[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_9[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_9[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_9[31:24];
				end
			5'h5:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_10[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_10[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_10[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_10[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_11[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_11[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_11[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_11[31:24];
				end
			5'h6:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_12[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_12[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_12[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_12[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_13[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_13[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_13[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_13[31:24];
				end
			5'h7:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : simctl_p_14[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : simctl_p_14[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : simctl_p_14[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : simctl_p_14[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : simctl_p_15[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : simctl_p_15[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : simctl_p_15[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : simctl_p_15[31:24];
				end
			default:
				hrdata_out_64b <= 64'h0;
			endcase
		end
		else if (rd_en3 || (update_rd_data & rd_en3_d1)) begin

			case (valid_rd_addr[3])
			1'h0:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : temp4[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : temp4[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : temp4[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : temp4[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : temp5[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : temp5[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : temp5[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : temp5[31:24];
				end
			1'h1:	begin
				hrdata_out_64b[ 7: 0] <= (wbe[0]) ? hwdata_64b[ 7: 0] : temp6[ 7: 0];
				hrdata_out_64b[15: 8] <= (wbe[1]) ? hwdata_64b[15: 8] : temp6[15: 8];
				hrdata_out_64b[23:16] <= (wbe[2]) ? hwdata_64b[23:16] : temp6[23:16];
				hrdata_out_64b[31:24] <= (wbe[3]) ? hwdata_64b[31:24] : temp6[31:24];
				hrdata_out_64b[39:32] <= (wbe[4]) ? hwdata_64b[39:32] : temp7[ 7: 0];
				hrdata_out_64b[47:40] <= (wbe[5]) ? hwdata_64b[47:40] : temp7[15: 8];
				hrdata_out_64b[55:48] <= (wbe[6]) ? hwdata_64b[55:48] : temp7[23:16];
				hrdata_out_64b[63:56] <= (wbe[7]) ? hwdata_64b[63:56] : temp7[31:24];
				end
			default:
				hrdata_out_64b <= 64'h0;
			endcase
		end
	end
	else if (rd_en || (update_rd_data & rd_en_d1)) begin

		if (DATA_WIDTH == 32) begin
		case (valid_rd_addr[7:2])
		6'h0: hrdata_out_64b <= {32'h0, simctl_p_0};
		6'h1: hrdata_out_64b <= {32'h0, simctl_p_1};
		6'h2: hrdata_out_64b <= {32'h0, simctl_p_2};
		6'h3: hrdata_out_64b <= {32'h0, simctl_p_3};
		6'h4: hrdata_out_64b <= {32'h0, simctl_p_4};
		6'h5: hrdata_out_64b <= {32'h0, simctl_p_5};
		6'h6: hrdata_out_64b <= {32'h0, simctl_p_6};
		6'h7: hrdata_out_64b <= {32'h0, simctl_p_7};
		6'h8: hrdata_out_64b <= {32'h0, simctl_p_8};
		6'h9: hrdata_out_64b <= {32'h0, simctl_p_9};
		6'ha: hrdata_out_64b <= {32'h0, simctl_p_10};
		6'hb: hrdata_out_64b <= {32'h0, simctl_p_11};
		6'hc: hrdata_out_64b <= {32'h0, simctl_p_12};
		6'hd: hrdata_out_64b <= {32'h0, simctl_p_13};
		6'he: hrdata_out_64b <= {32'h0, simctl_p_14};
		6'hf: hrdata_out_64b <= {32'h0, simctl_p_15};
		default:
			hrdata_out_64b <= 64'h0;
		endcase
		end
		else begin
		case (valid_rd_addr[7:3])
		5'h0: hrdata_out_64b <= {simctl_p_1, simctl_p_0};
		5'h1: hrdata_out_64b <= {simctl_p_3, simctl_p_2};
		5'h2: hrdata_out_64b <= {simctl_p_5, simctl_p_4};
		5'h3: hrdata_out_64b <= {simctl_p_7, simctl_p_6};
		5'h4: hrdata_out_64b <= {simctl_p_9, simctl_p_8};
		5'h5: hrdata_out_64b <= {simctl_p_11, simctl_p_10};
		5'h6: hrdata_out_64b <= {simctl_p_13, simctl_p_12};
		5'h7: hrdata_out_64b <= {simctl_p_15, simctl_p_14};
		default:
			hrdata_out_64b <= 64'h0;
		endcase
		end
	end
	else if (rd_en3 || (update_rd_data & rd_en3_d1)) begin
		if (DATA_WIDTH == 32) begin
		case (valid_rd_addr[3:2])
		2'h0:	hrdata_out_64b <= {32'h0, temp4};
		2'h1:	hrdata_out_64b <= {32'h0, temp5};
		2'h2:	hrdata_out_64b <= {32'h0, temp6};
		2'h3:	hrdata_out_64b <= {32'h0, temp7};
		default:hrdata_out_64b <= 64'hx;
		endcase
		end
		else begin
		case (valid_rd_addr[3])
		1'h0:	hrdata_out_64b <= {temp5, temp4};
		1'h1:	hrdata_out_64b <= {temp7, temp6};
		default:hrdata_out_64b <= 64'hx;
		endcase
		end
	end
end

generate
if (DATA_WIDTH == 32) begin : gen_hrdata_32
	assign hrdata_out = hrdata_out_64b[31:0];
end
else begin : gen_hrdata_bigger_32
	assign hrdata_out = {(DATA_WIDTH/64){hrdata_out_64b}};
end
endgenerate

assign hrdata = (hreadyi && hresp == AHB_RESP_OKAY)? hrdata_out: default_data;

always @(posedge hclk or negedge hresetn) begin
	if (~hresetn)
		hready <= 1'b0;
	else
		hready <= ~block_rdata_valid;
end

assign hresp = AHB_RESP_OKAY;

assign hsplit = 16'h0;

assign wr_en = hsel && hwrite && htrans[1] && hreadyi;

always @(posedge hclk or negedge hresetn)
	if (~hresetn) begin
		hmaster_reg    <= 4'h0;
		hmaster_reg_d1 <= 4'h0;
	end
	else if (hreadyi) begin
		hmaster_reg    <= hmaster;
		hmaster_reg_d1 <= hmaster_reg;
	end


always @(posedge hclk or negedge hresetn)
	if (~hresetn) begin
		temp1wen <= 1'b0;
		temp1wen_d1 <= 1'b0;
		temp1 <= 32'h0;

		temp2wen <= 1'b0;
		temp2wen_d1 <= 1'b0;
		temp2 <= 32'h0;

		temp3wen <= 1'b0;
		temp3wen_d1 <= 1'b0;
		temp3 <= 32'h0;

		temp4wen <= 1'b0;
		temp4wen_d1 <= 1'b0;
		temp4 <= 32'h0;

		temp5wen <= 1'b0;
		temp5wen_d1 <= 1'b0;
		temp5 <= 32'h0;

		temp6wen <= 1'b0;
		temp6wen_d1 <= 1'b0;
		temp6 <= 32'h0;

		temp7wen <= 1'b0;
		temp7wen_d1 <= 1'b0;
		temp7 <= 32'h0;



		simctl_p_0wen <= 1'b0;
		simctl_p_0 <= 32'h0;

		simctl_p_1wen <= 1'b0;
		simctl_p_1 <= 32'h0;

		simctl_p_2wen <= 1'b0;
		simctl_p_2 <= 32'h0;

		simctl_p_3wen <= 1'b0;
		simctl_p_3 <= 32'h0;

		simctl_p_4wen <= 1'b0;
		simctl_p_4 <= 32'h0;

		simctl_p_5wen <= 1'b0;
		simctl_p_5 <= 32'h0;

		simctl_p_6wen <= 1'b0;
		simctl_p_6 <= 32'h0;

		simctl_p_7wen <= 1'b0;
		simctl_p_7 <= 32'h0;

		simctl_p_8wen <= 1'b0;
		simctl_p_8 <= 32'h0;

		simctl_p_9wen <= 1'b0;
		simctl_p_9 <= 32'h0;

		simctl_p_10wen <= 1'b0;
		simctl_p_10 <= 32'h0;

		simctl_p_11wen <= 1'b0;
		simctl_p_11 <= 32'h0;

		simctl_p_12wen <= 1'b0;
		simctl_p_12 <= 32'h0;

		simctl_p_13wen <= 1'b0;
		simctl_p_13 <= 32'h0;

		simctl_p_14wen <= 1'b0;
		simctl_p_14 <= 32'h0;

		simctl_p_15wen <= 1'b0;
		simctl_p_15 <= 32'h0;


		tempwbe_d1  <= 8'h0;
	end
	else if (hreadyi) begin
		temp1wen <= wr_en && (haddr[19:2] == MSG_PAGE0[19:2]);
		temp1wen_d1 <= temp1wen;
		if (temp1wen && wbe[0]) temp1[ 7: 0] <= hwdata_64b[ 7: 0];
		if (temp1wen && wbe[1]) temp1[15: 8] <= hwdata_64b[15: 8];
		if (temp1wen && wbe[2]) temp1[23:16] <= hwdata_64b[23:16];
		if (temp1wen && wbe[3]) temp1[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		temp2wen <= wr_en && (haddr[19:2] == MSG_PAGE1[19:2]);
		temp2wen_d1 <= temp2wen;
		if (temp2wen && wbe[0]) temp2[ 7: 0] <= hwdata_64b[ 7: 0];
		if (temp2wen && wbe[1]) temp2[15: 8] <= hwdata_64b[15: 8];
		if (temp2wen && wbe[2]) temp2[23:16] <= hwdata_64b[23:16];
		if (temp2wen && wbe[3]) temp2[31:24] <= hwdata_64b[31:24];
		end

		temp3wen <= wr_en && (haddr[19:2] == MSG_PAGE2[19:2]);
		temp3wen_d1 <= temp3wen;
		if (temp3wen && wbe[0]) temp3[ 7: 0] <= hwdata_64b[ 7: 0];
		if (temp3wen && wbe[1]) temp3[15: 8] <= hwdata_64b[15: 8];
		if (temp3wen && wbe[2]) temp3[23:16] <= hwdata_64b[23:16];
		if (temp3wen && wbe[3]) temp3[31:24] <= hwdata_64b[31:24];

		temp4wen <= wr_en && (haddr[19:4] == MSG_PAGE4[19:4]) && (haddr[3:2] == 2'h0);
		temp4wen_d1 <= temp4wen;
		if (temp4wen && wbe[0]) temp4[ 7: 0] <= hwdata_64b[ 7: 0];
		if (temp4wen && wbe[1]) temp4[15: 8] <= hwdata_64b[15: 8];
		if (temp4wen && wbe[2]) temp4[23:16] <= hwdata_64b[23:16];
		if (temp4wen && wbe[3]) temp4[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		temp5wen <= wr_en && (haddr[19:4] == MSG_PAGE4[19:4]) && (haddr[3:2] == 2'h1);
		temp5wen_d1 <= temp5wen;
		if (temp5wen && wbe[0]) temp5[ 7: 0] <= hwdata_64b[ 7: 0];
		if (temp5wen && wbe[1]) temp5[15: 8] <= hwdata_64b[15: 8];
		if (temp5wen && wbe[2]) temp5[23:16] <= hwdata_64b[23:16];
		if (temp5wen && wbe[3]) temp5[31:24] <= hwdata_64b[31:24];
		end

		temp6wen <= wr_en && (haddr[19:4] == MSG_PAGE4[19:4]) && (haddr[3:2] == 2'h2);
		temp6wen_d1 <= temp6wen;
		if (temp6wen && wbe[0]) temp6[ 7: 0] <= hwdata_64b[ 7: 0];
		if (temp6wen && wbe[1]) temp6[15: 8] <= hwdata_64b[15: 8];
		if (temp6wen && wbe[2]) temp6[23:16] <= hwdata_64b[23:16];
		if (temp6wen && wbe[3]) temp6[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		temp7wen <= wr_en && (haddr[19:4] == MSG_PAGE4[19:4]) && (haddr[3:2] == 2'h3);
		temp7wen_d1 <= temp7wen;
		if (temp7wen && wbe[0]) temp7[ 7: 0] <= hwdata_64b[ 7: 0];
		if (temp7wen && wbe[1]) temp7[15: 8] <= hwdata_64b[15: 8];
		if (temp7wen && wbe[2]) temp7[23:16] <= hwdata_64b[23:16];
		if (temp7wen && wbe[3]) temp7[31:24] <= hwdata_64b[31:24];
		end

		if (DATA_WIDTH != 32) begin
		temp2wen <= wr_en && (haddr[19:3] == MSG_PAGE1[19:3]);
		temp2wen_d1 <= temp2wen;
		if (temp2wen && wbe[4]) temp2[ 7: 0] <= hwdata_64b[39:32];
		if (temp2wen && wbe[5]) temp2[15: 8] <= hwdata_64b[47:40];
		if (temp2wen && wbe[6]) temp2[23:16] <= hwdata_64b[55:48];
		if (temp2wen && wbe[7]) temp2[31:24] <= hwdata_64b[63:56];

		temp5wen <= wr_en && ((haddr[19:4] == MSG_PAGE4[19:4]) && (haddr[3] == 1'h0));
		temp5wen_d1 <= temp5wen;
		if (temp5wen && wbe[4]) temp5[ 7: 0] <= hwdata_64b[39:32];
		if (temp5wen && wbe[5]) temp5[15: 8] <= hwdata_64b[47:40];
		if (temp5wen && wbe[6]) temp5[23:16] <= hwdata_64b[55:48];
		if (temp5wen && wbe[7]) temp5[31:24] <= hwdata_64b[63:56];

		temp7wen <= wr_en && ((haddr[19:4] == MSG_PAGE4[19:4]) && (haddr[3] == 1'h1));
		temp7wen_d1 <= temp7wen;
		if (temp7wen && wbe[4]) temp7[ 7: 0] <= hwdata_64b[39:32];
		if (temp7wen && wbe[5]) temp7[15: 8] <= hwdata_64b[47:40];
		if (temp7wen && wbe[6]) temp7[23:16] <= hwdata_64b[55:48];
		if (temp7wen && wbe[7]) temp7[31:24] <= hwdata_64b[63:56];
		end


		simctl_p_0wen <= wr_en && (haddr[19:2] == 18'h2_0400);
		if (simctl_p_0wen && wbe[0]) simctl_p_0[7:0] <= hwdata_64b[7:0];
		if (simctl_p_0wen && wbe[1]) simctl_p_0[15:8] <= hwdata_64b[15:8];
		if (simctl_p_0wen && wbe[2]) simctl_p_0[23:16] <= hwdata_64b[23:16];
		if (simctl_p_0wen && wbe[3]) simctl_p_0[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_1wen <= wr_en && (haddr[19:2] == 18'h2_0401);
		if (simctl_p_1wen && wbe[0]) simctl_p_1[7:0] <= hwdata_64b[7:0];
		if (simctl_p_1wen && wbe[1]) simctl_p_1[15:8] <= hwdata_64b[15:8];
		if (simctl_p_1wen && wbe[2]) simctl_p_1[23:16] <= hwdata_64b[23:16];
		if (simctl_p_1wen && wbe[3]) simctl_p_1[31:24] <= hwdata_64b[31:24];
		end

		simctl_p_2wen <= wr_en && (haddr[19:2] == 18'h2_0402);
		if (simctl_p_2wen && wbe[0]) simctl_p_2[7:0] <= hwdata_64b[7:0];
		if (simctl_p_2wen && wbe[1]) simctl_p_2[15:8] <= hwdata_64b[15:8];
		if (simctl_p_2wen && wbe[2]) simctl_p_2[23:16] <= hwdata_64b[23:16];
		if (simctl_p_2wen && wbe[3]) simctl_p_2[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_3wen <= wr_en && (haddr[19:2] == 18'h2_0403);
		if (simctl_p_3wen && wbe[0]) simctl_p_3[7:0] <= hwdata_64b[7:0];
		if (simctl_p_3wen && wbe[1]) simctl_p_3[15:8] <= hwdata_64b[15:8];
		if (simctl_p_3wen && wbe[2]) simctl_p_3[23:16] <= hwdata_64b[23:16];
		if (simctl_p_3wen && wbe[3]) simctl_p_3[31:24] <= hwdata_64b[31:24];
		end

		simctl_p_4wen <= wr_en && (haddr[19:2] == 18'h2_0404);
		if (simctl_p_4wen && wbe[0]) simctl_p_4[7:0] <= hwdata_64b[7:0];
		if (simctl_p_4wen && wbe[1]) simctl_p_4[15:8] <= hwdata_64b[15:8];
		if (simctl_p_4wen && wbe[2]) simctl_p_4[23:16] <= hwdata_64b[23:16];
		if (simctl_p_4wen && wbe[3]) simctl_p_4[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_5wen <= wr_en && (haddr[19:2] == 18'h2_0405);
		if (simctl_p_5wen && wbe[0]) simctl_p_5[7:0] <= hwdata_64b[7:0];
		if (simctl_p_5wen && wbe[1]) simctl_p_5[15:8] <= hwdata_64b[15:8];
		if (simctl_p_5wen && wbe[2]) simctl_p_5[23:16] <= hwdata_64b[23:16];
		if (simctl_p_5wen && wbe[3]) simctl_p_5[31:24] <= hwdata_64b[31:24];
		end

		simctl_p_6wen <= wr_en && (haddr[19:2] == 18'h2_0406);
		if (simctl_p_6wen && wbe[0]) simctl_p_6[7:0] <= hwdata_64b[7:0];
		if (simctl_p_6wen && wbe[1]) simctl_p_6[15:8] <= hwdata_64b[15:8];
		if (simctl_p_6wen && wbe[2]) simctl_p_6[23:16] <= hwdata_64b[23:16];
		if (simctl_p_6wen && wbe[3]) simctl_p_6[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_7wen <= wr_en && (haddr[19:2] == 18'h2_0407);
		if (simctl_p_7wen && wbe[0]) simctl_p_7[7:0] <= hwdata_64b[7:0];
		if (simctl_p_7wen && wbe[1]) simctl_p_7[15:8] <= hwdata_64b[15:8];
		if (simctl_p_7wen && wbe[2]) simctl_p_7[23:16] <= hwdata_64b[23:16];
		if (simctl_p_7wen && wbe[3]) simctl_p_7[31:24] <= hwdata_64b[31:24];
		end

		simctl_p_8wen <= wr_en && (haddr[19:2] == 18'h2_0408);
		if (simctl_p_8wen && wbe[0]) simctl_p_8[7:0] <= hwdata_64b[7:0];
		if (simctl_p_8wen && wbe[1]) simctl_p_8[15:8] <= hwdata_64b[15:8];
		if (simctl_p_8wen && wbe[2]) simctl_p_8[23:16] <= hwdata_64b[23:16];
		if (simctl_p_8wen && wbe[3]) simctl_p_8[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_9wen <= wr_en && (haddr[19:2] == 18'h2_0409);
		if (simctl_p_9wen && wbe[0]) simctl_p_9[7:0] <= hwdata_64b[7:0];
		if (simctl_p_9wen && wbe[1]) simctl_p_9[15:8] <= hwdata_64b[15:8];
		if (simctl_p_9wen && wbe[2]) simctl_p_9[23:16] <= hwdata_64b[23:16];
		if (simctl_p_9wen && wbe[3]) simctl_p_9[31:24] <= hwdata_64b[31:24];
		end

		simctl_p_10wen <= wr_en && (haddr[19:2] == 18'h2_040a);
		if (simctl_p_10wen && wbe[0]) simctl_p_10[7:0] <= hwdata_64b[7:0];
		if (simctl_p_10wen && wbe[1]) simctl_p_10[15:8] <= hwdata_64b[15:8];
		if (simctl_p_10wen && wbe[2]) simctl_p_10[23:16] <= hwdata_64b[23:16];
		if (simctl_p_10wen && wbe[3]) simctl_p_10[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_11wen <= wr_en && (haddr[19:2] == 18'h2_040b);
		if (simctl_p_11wen && wbe[0]) simctl_p_11[7:0] <= hwdata_64b[7:0];
		if (simctl_p_11wen && wbe[1]) simctl_p_11[15:8] <= hwdata_64b[15:8];
		if (simctl_p_11wen && wbe[2]) simctl_p_11[23:16] <= hwdata_64b[23:16];
		if (simctl_p_11wen && wbe[3]) simctl_p_11[31:24] <= hwdata_64b[31:24];
		end

		simctl_p_12wen <= wr_en && (haddr[19:2] == 18'h2_040c);
		if (simctl_p_12wen && wbe[0]) simctl_p_12[7:0] <= hwdata_64b[7:0];
		if (simctl_p_12wen && wbe[1]) simctl_p_12[15:8] <= hwdata_64b[15:8];
		if (simctl_p_12wen && wbe[2]) simctl_p_12[23:16] <= hwdata_64b[23:16];
		if (simctl_p_12wen && wbe[3]) simctl_p_12[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_13wen <= wr_en && (haddr[19:2] == 18'h2_040d);
		if (simctl_p_13wen && wbe[0]) simctl_p_13[7:0] <= hwdata_64b[7:0];
		if (simctl_p_13wen && wbe[1]) simctl_p_13[15:8] <= hwdata_64b[15:8];
		if (simctl_p_13wen && wbe[2]) simctl_p_13[23:16] <= hwdata_64b[23:16];
		if (simctl_p_13wen && wbe[3]) simctl_p_13[31:24] <= hwdata_64b[31:24];
		end

		simctl_p_14wen <= wr_en && (haddr[19:2] == 18'h2_040e);
		if (simctl_p_14wen && wbe[0]) simctl_p_14[7:0] <= hwdata_64b[7:0];
		if (simctl_p_14wen && wbe[1]) simctl_p_14[15:8] <= hwdata_64b[15:8];
		if (simctl_p_14wen && wbe[2]) simctl_p_14[23:16] <= hwdata_64b[23:16];
		if (simctl_p_14wen && wbe[3]) simctl_p_14[31:24] <= hwdata_64b[31:24];

		if (DATA_WIDTH == 32) begin
		simctl_p_15wen <= wr_en && (haddr[19:2] == 18'h2_040f);
		if (simctl_p_15wen && wbe[0]) simctl_p_15[7:0] <= hwdata_64b[7:0];
		if (simctl_p_15wen && wbe[1]) simctl_p_15[15:8] <= hwdata_64b[15:8];
		if (simctl_p_15wen && wbe[2]) simctl_p_15[23:16] <= hwdata_64b[23:16];
		if (simctl_p_15wen && wbe[3]) simctl_p_15[31:24] <= hwdata_64b[31:24];
		end



		if (DATA_WIDTH != 32) begin
		simctl_p_1wen <= wr_en && (haddr[19:3] == 17'h1_0200);
		if (simctl_p_1wen && wbe[4]) simctl_p_1[7:0] <= hwdata_64b[39:32];
		if (simctl_p_1wen && wbe[5]) simctl_p_1[15:8] <= hwdata_64b[47:40];
		if (simctl_p_1wen && wbe[6]) simctl_p_1[23:16] <= hwdata_64b[55:48];
		if (simctl_p_1wen && wbe[7]) simctl_p_1[31:24] <= hwdata_64b[63:56];

		simctl_p_3wen <= wr_en && (haddr[19:3] == 17'h1_0201);
		if (simctl_p_3wen && wbe[4]) simctl_p_3[7:0] <= hwdata_64b[39:32];
		if (simctl_p_3wen && wbe[5]) simctl_p_3[15:8] <= hwdata_64b[47:40];
		if (simctl_p_3wen && wbe[6]) simctl_p_3[23:16] <= hwdata_64b[55:48];
		if (simctl_p_3wen && wbe[7]) simctl_p_3[31:24] <= hwdata_64b[63:56];

		simctl_p_5wen <= wr_en && (haddr[19:3] == 17'h1_0202);
		if (simctl_p_5wen && wbe[4]) simctl_p_5[7:0] <= hwdata_64b[39:32];
		if (simctl_p_5wen && wbe[5]) simctl_p_5[15:8] <= hwdata_64b[47:40];
		if (simctl_p_5wen && wbe[6]) simctl_p_5[23:16] <= hwdata_64b[55:48];
		if (simctl_p_5wen && wbe[7]) simctl_p_5[31:24] <= hwdata_64b[63:56];

		simctl_p_7wen <= wr_en && (haddr[19:3] == 17'h1_0203);
		if (simctl_p_7wen && wbe[4]) simctl_p_7[7:0] <= hwdata_64b[39:32];
		if (simctl_p_7wen && wbe[5]) simctl_p_7[15:8] <= hwdata_64b[47:40];
		if (simctl_p_7wen && wbe[6]) simctl_p_7[23:16] <= hwdata_64b[55:48];
		if (simctl_p_7wen && wbe[7]) simctl_p_7[31:24] <= hwdata_64b[63:56];

		simctl_p_9wen <= wr_en && (haddr[19:3] == 17'h1_0204);
		if (simctl_p_9wen && wbe[4]) simctl_p_9[7:0] <= hwdata_64b[39:32];
		if (simctl_p_9wen && wbe[5]) simctl_p_9[15:8] <= hwdata_64b[47:40];
		if (simctl_p_9wen && wbe[6]) simctl_p_9[23:16] <= hwdata_64b[55:48];
		if (simctl_p_9wen && wbe[7]) simctl_p_9[31:24] <= hwdata_64b[63:56];

		simctl_p_11wen <= wr_en && (haddr[19:3] == 17'h1_0205);
		if (simctl_p_11wen && wbe[4]) simctl_p_11[7:0] <= hwdata_64b[39:32];
		if (simctl_p_11wen && wbe[5]) simctl_p_11[15:8] <= hwdata_64b[47:40];
		if (simctl_p_11wen && wbe[6]) simctl_p_11[23:16] <= hwdata_64b[55:48];
		if (simctl_p_11wen && wbe[7]) simctl_p_11[31:24] <= hwdata_64b[63:56];

		simctl_p_13wen <= wr_en && (haddr[19:3] == 17'h1_0206);
		if (simctl_p_13wen && wbe[4]) simctl_p_13[7:0] <= hwdata_64b[39:32];
		if (simctl_p_13wen && wbe[5]) simctl_p_13[15:8] <= hwdata_64b[47:40];
		if (simctl_p_13wen && wbe[6]) simctl_p_13[23:16] <= hwdata_64b[55:48];
		if (simctl_p_13wen && wbe[7]) simctl_p_13[31:24] <= hwdata_64b[63:56];

		simctl_p_15wen <= wr_en && (haddr[19:3] == 17'h1_0207);
		if (simctl_p_15wen && wbe[4]) simctl_p_15[7:0] <= hwdata_64b[39:32];
		if (simctl_p_15wen && wbe[5]) simctl_p_15[15:8] <= hwdata_64b[47:40];
		if (simctl_p_15wen && wbe[6]) simctl_p_15[23:16] <= hwdata_64b[55:48];
		if (simctl_p_15wen && wbe[7]) simctl_p_15[31:24] <= hwdata_64b[63:56];

		end

		tempwbe_d1 <= wbe;
	end

parameter CHAR_SIZE    = 160;
parameter STRING_WIDTH = CHAR_SIZE*8;
reg [STRING_WIDTH-1:0]	_string;
reg [STRING_WIDTH-1:0]	_string_prev;
reg [31:0]		char_count;
reg [3:0]		tmep2_wbe_d1;

always @(posedge hclk or negedge hresetn)
	if (~hresetn) begin
		_string = {STRING_WIDTH{1'd0}};
		_string_prev = {STRING_WIDTH{1'd0}};
		char_count = 32'd0;
	end
	else if (temp1wen_d1 & hreadyi) begin
		if (temp1 == 32'hdddd_1111) begin
			_string = {STRING_WIDTH{1'd0}};
			char_count = 32'd0;
		end
		else if (temp1 == 32'hdddd_eeee) begin
			if(char_count > CHAR_SIZE) begin
				$display("%0t:Sim Control:ERROR: The number of Display characters is larger than string buffer size(%0d).", $time, CHAR_SIZE);
				finish_status = 1;
				->event_finish;
			end
			$display("Sim Control Display:%0s", _string);
			_string_prev = _string;
			_string = {STRING_WIDTH{1'd0}};
			char_count = 32'd0;
		end
	end
	else if (temp2wen_d1 & hreadyi) begin
		if (DATA_WIDTH == 32) begin
			tmep2_wbe_d1 = tempwbe_d1[3:0];
		end
		else begin
			tmep2_wbe_d1 = tempwbe_d1[7:4];
		end

		case (tmep2_wbe_d1)
		4'b0001: begin
			_string = _string << 8;
			_string[7:0] = temp2[7:0];
			char_count = char_count + 1;
		end

		4'b0010: begin
			_string = _string << 8;
			_string[7:0] = temp2[15:8];
			char_count = char_count + 1;
		end

		4'b0100: begin
			_string = _string << 8;
			_string[7:0] = temp2[23:16];
			char_count = char_count + 1;
		end

		4'b1000: begin
			_string = _string << 8;
			_string[7:0] = temp2[31:24];
			char_count = char_count + 1;
		end

		4'b0011: begin
			_string = _string << 16;
			_string[15:8] = temp2[7:0];
			_string[7:0] = temp2[15:8];
			char_count = char_count + 2;
		end

		4'b1100: begin
			_string = _string << 16;
			_string[15:8] = temp2[23:16];
			_string[7:0] = temp2[31:24];
			char_count = char_count + 2;
		end

		4'b1111: begin
			_string = _string << 32;
			_string[31:24] = temp2[7:0];
			_string[23:16] = temp2[15:8];
			_string[15:8] = temp2[23:16];
			_string[7:0] = temp2[31:24];
			char_count = char_count + 4;
		end

		default: begin
			_string = {STRING_WIDTH{1'bx}};
		end
		endcase
	end

`ifndef NDS_AE350_NO_RST_FINISH_CNT
always @(posedge hclk or negedge hresetn)
	if (~hresetn) begin
		finish_cnt = 0;
	end
`endif
always @(posedge hclk)
	if (temp1wen_d1 & hreadyi)
		case (temp1)
		32'h0123_4567: begin
			finish_status = 2;
			->event_finish;
			#0 $display("%0t:ipipe:%0d:---- SIMULATION FINISHED ----", $time, hmaster_reg_d1 - HMASTER_START);
		end

		32'h0123_4568: begin
			finish_cnt = finish_cnt + 1;
			if ((hmaster_reg_d1 == target_hmaster) && (finish_cnt == RUN_HART_NUM)) begin
				finish_status = 0;
				->event_finish;
				#1 $display("%0t:ipipe:%0d:---- SIMULATION PASSED ----", $time, hmaster_reg_d1 - HMASTER_START);
			end
			else
				$display("%0t:ipipe:%0d:---- SIMULATION FINISHED ----", $time, hmaster_reg_d1 - HMASTER_START);
		end

		32'h0123_4569: begin
			finish_status = 1;
			->event_finish;
			#0 $display("%0t:ipipe:%0d:---- SIMULATION FAILED ----", $time, hmaster_reg_d1 - HMASTER_START);
		end

		32'h0123_4570:
			$display("%0t:ipipe:%0d:---- SIMULATION WARNING ----", $time, hmaster_reg_d1 - HMASTER_START);

		32'h0123_4571: begin
			finish_status = 3;
			->event_finish;
		    if (_string_prev[7:0] !== 8'd0) begin
			#0 $display("%0t:ipipe:%0d:---- SIMULATION SKIPPED ---- (%0s)", $time, hmaster_reg_d1 - HMASTER_START, _string_prev);
		    end
		    else begin
			#0 $display("%0t:ipipe:%0d:---- SIMULATION SKIPPED ----", $time, hmaster_reg_d1 - HMASTER_START);
		    end
		end

		endcase


always @(posedge hclk)
	if (temp1wen_d1 & hreadyi)
		case (temp1)

		32'heeee_0000: ->event_model_0;
		32'heeee_0001: ->event_model_1;
		32'heeee_0002: ->event_model_2;
		32'heeee_0003: ->event_model_3;
		32'heeee_0004: ->event_model_4;
		32'heeee_0005: ->event_model_5;
		32'heeee_0006: ->event_model_6;
		32'heeee_0007: ->event_model_7;
		32'heeee_0008: ->event_model_8;
		32'heeee_0009: ->event_model_9;
		32'heeee_000a: ->event_model_10;
		32'heeee_000b: ->event_model_11;
		32'heeee_000c: ->event_model_12;
		32'heeee_000d: ->event_model_13;
		32'heeee_000e: ->event_model_14;
		32'heeee_000f: ->event_model_15;
		default:;
		endcase



always @(event_model_0)
	$display("%0t:%m:External model 0 event trigger", $time);

always @(event_model_1)
	$display("%0t:%m:External model 1 event trigger", $time);

always @(event_model_2)
	$display("%0t:%m:External model 2 event trigger", $time);

always @(event_model_3)
	$display("%0t:%m:External model 3 event trigger", $time);

always @(event_model_4)
	$display("%0t:%m:External model 4 event trigger", $time);

always @(event_model_5)
	$display("%0t:%m:External model 5 event trigger", $time);

always @(event_model_6)
	$display("%0t:%m:External model 6 event trigger", $time);

always @(event_model_7)
	$display("%0t:%m:External model 7 event trigger", $time);

always @(event_model_8)
	$display("%0t:%m:External model 8 event trigger", $time);

always @(event_model_9)
	$display("%0t:%m:External model 9 event trigger", $time);

always @(event_model_10)
	$display("%0t:%m:External model 10 event trigger", $time);

always @(event_model_11)
	$display("%0t:%m:External model 11 event trigger", $time);

always @(event_model_12)
	$display("%0t:%m:External model 12 event trigger", $time);

always @(event_model_13)
	$display("%0t:%m:External model 13 event trigger", $time);

always @(event_model_14)
	$display("%0t:%m:External model 14 event trigger", $time);

always @(event_model_15)
	$display("%0t:%m:External model 15 event trigger", $time);



always @(posedge hclk)
	if (temp3wen_d1 & hreadyi)
		$display("Sim Control Debug: %h", temp3);

endmodule

