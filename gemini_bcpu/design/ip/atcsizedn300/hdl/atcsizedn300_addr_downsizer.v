// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atcsizedn300_addr_downsizer(
       	  aclk,
       	  aresetn,
       	  us_arwid,
       	  us_arwaddr,
       	  us_arwlen,
       	  us_arwsize,
       	  us_arwburst,
       	  us_arwlock,
       	  us_arwcache,
       	  us_arwprot,
       	  us_arwvalid,
       	  us_arwready,
       	  ds_arwaddr,
       	  ds_arwlen,
       	  ds_arwsize,
       	  ds_arwburst,
       	  ds_arwlock,
       	  ds_arwcache,
       	  ds_arwprot,
       	  ds_arwvalid,
       	  ds_arwready,
       	  us_data_size,
       	  us_data_id,
       	  us_last_burst,
       	  cmd_fifo_full
);

parameter ID_WIDTH = 4;
parameter ADDR_WIDTH = 32;
parameter US_DATA_WIDTH = 128;
parameter DS_DATA_WIDTH = 32;
parameter READ_CHANNEL = 1;

localparam DS_DATA_SIZE = $clog2(DS_DATA_WIDTH/8);
localparam IDLE  = 1'b0;
localparam SPLIT = 1'b1;

localparam FIXED = 2'b00;
localparam INCR  = 2'b01;
localparam WRAP  = 2'b10;

localparam ADDR_FIFO_WIDTH = ID_WIDTH + ADDR_WIDTH + 8 + 3 + 2 + 1 + 4 + 3;
localparam SPLIT_ARWADDR_DATA_WIDTH = DS_DATA_WIDTH / 8;

input                            aclk;
input                            aresetn;

input	[ID_WIDTH-1:0] 		us_arwid;
input	[ADDR_WIDTH-1:0] 	us_arwaddr;
input	[7:0] 			us_arwlen;
input	[2:0] 			us_arwsize;
input	[1:0] 			us_arwburst;
input	     	 		us_arwlock;
input	[3:0] 			us_arwcache;
input	[2:0] 			us_arwprot;
input                   	us_arwvalid;
output                  	us_arwready;

output	[ADDR_WIDTH-1:0] 	ds_arwaddr;
output	[7:0]			ds_arwlen;
output  [2:0]			ds_arwsize;
output  [1:0]			ds_arwburst;
output       			ds_arwlock;
output  [3:0]			ds_arwcache;
output  [2:0]			ds_arwprot;
output                   	ds_arwvalid;
input                  	 	ds_arwready;

output	[2:0]			us_data_size;
output	[ID_WIDTH-1:0]		us_data_id;
output				us_last_burst;
input				cmd_fifo_full;

reg	[ADDR_WIDTH-1:0] 	ds_arwaddr;
reg	[7:0]			ds_arwlen;
reg  	[2:0]			ds_arwsize;
reg  	[1:0]			ds_arwburst;
reg       			ds_arwlock;
reg  	[3:0]			ds_arwcache;
reg  	[2:0]			ds_arwprot;
reg	                  	us_arwready;

reg	[ADDR_WIDTH-1:0] 	ds_arwaddr_a1;
reg	[7:0]			ds_arwlen_a1;
reg  	[2:0]			ds_arwsize_a1;
reg  	[1:0]			ds_arwburst_a1;
reg       			ds_arwlock_a1;
reg  	[3:0]			ds_arwcache_a1;
reg  	[2:0]			ds_arwprot_a1;
reg                   		ds_addr_valid_a1;
reg	                  	us_arwready_a1;

reg                   		ds_addr_valid;

reg	[2:0]			us_data_size;
reg	[ID_WIDTH-1:0]		us_data_id;
reg				us_last_burst;

reg	[2:0]			us_data_size_a1;
reg	[ID_WIDTH-1:0]		us_data_id_a1;
reg				us_last_burst_a1;

wire				us_cmd_valid;

reg	[ADDR_FIFO_WIDTH-1:0]	cmd_buffer;
reg	[ADDR_FIFO_WIDTH-1:0]	cmd_buffer_a1;
wire	[ADDR_FIFO_WIDTH-1:0]	buffer_wdata;
reg				buffer_valid;
reg				buffer_valid_a1;

wire				us_arwvalid_mux;
wire	[ID_WIDTH-1:0] 		us_arwid_mux;
wire	[ADDR_WIDTH-1:0] 	us_arwaddr_mux;
wire	[7:0] 			us_arwlen_mux;
wire	[2:0] 			us_arwsize_mux;
wire	[1:0] 			us_arwburst_mux;
wire	     	 		us_arwlock_mux;
wire	[3:0] 			us_arwcache_mux;
wire	[2:0] 			us_arwprot_mux;

wire				bypass_us_trans;
wire				ds_cmd_valid;
wire 				data_size_big_than_ds;
wire	[10:0]			ds_trans_length;
wire	[7:0]			ds_split_trans_len;
wire	[7:0]			ds_first_trans_len;
wire 	[2:0]			data_ratio;
wire	[2:0]			tmp_data;

wire				wrap_split_detect;
wire				incr_split_detect;
wire				fixed_split_detect;
wire				single_burst_split_detect;
reg				split_detect;
reg 				align_wrap;
wire 				single_fixed;
wire				switch_ds_burst;

reg	[1:0]		 	wrap_start_addr;
reg	[9:0]			wrap_split_length;
reg	[7:0]			wrap_split_next_length;

reg				split_stage;
reg				split_stage_a1;
wire	[3:0]			one_shift_split_data_ratio;
wire				split_complete;
wire    [7:0]        		split_arwaddr_offset;

reg				split_single;
reg	[10:0]			split_arwlen;
reg	[ADDR_WIDTH-1:0] 	split_arwaddr;
reg	[1:0] 			split_arwburst;
reg	[1:0] 			split_data_ratio;
reg				split_single_a1;
reg	[10:0]			split_arwlen_a1;
reg	[ADDR_WIDTH-1:0] 	split_arwaddr_a1;
reg	[1:0] 			split_arwburst_a1;
reg	[1:0] 			split_data_ratio_a1;

wire				split_single_mux;
wire	[10:0]			split_arwlen_mux;
wire	[ADDR_WIDTH-1:0] 	split_arwaddr_mux;
wire	[1:0] 			split_arwburst_mux;
wire	[1:0] 			split_data_ratio_mux;
reg	[13:0]			split_incr_addr;

wire	[3:0]			split_fixed_len_offset;
wire	[3:0]			split_fixed_length;
wire	[3:0]			split_fixed_dec_length;

assign bypass_us_trans 	= ((!ds_arwvalid) || ds_arwready) && (!split_stage) && (!cmd_fifo_full);
assign ds_cmd_valid	= ds_arwvalid && ds_arwready;
assign us_cmd_valid	= us_arwready && us_arwvalid;

assign buffer_wdata	= {us_arwid, us_arwaddr, us_arwlen, us_arwsize, us_arwburst, us_arwlock, us_arwcache, us_arwprot};

assign us_arwvalid_mux	= buffer_valid ? 1'b1						: us_arwvalid;
assign us_arwid_mux	= buffer_valid ? cmd_buffer[ADDR_FIFO_WIDTH-1:21+ADDR_WIDTH]	: us_arwid;
assign us_arwaddr_mux	= buffer_valid ? cmd_buffer[21+ADDR_WIDTH-1:21]             	: us_arwaddr;
assign us_arwlen_mux	= buffer_valid ? cmd_buffer[20:13]                          	: us_arwlen;
assign us_arwsize_mux	= buffer_valid ? cmd_buffer[12:10]                          	: us_arwsize;
assign us_arwburst_mux	= buffer_valid ? cmd_buffer[9:8]                            	: us_arwburst;
assign us_arwlock_mux	= buffer_valid ? cmd_buffer[7]                              	: us_arwlock;
assign us_arwcache_mux	= buffer_valid ? cmd_buffer[6:3]                            	: us_arwcache;
assign us_arwprot_mux	= buffer_valid ? cmd_buffer[2:0]                            	: us_arwprot;

assign data_size_big_than_ds	= (us_arwsize_mux > DS_DATA_SIZE[2:0]);
assign data_ratio	= data_size_big_than_ds ? (us_arwsize_mux - DS_DATA_SIZE[2:0]) : 3'h0;

assign tmp_data		= (data_ratio[1:0] == 2'h3) ? (us_arwaddr_mux[DS_DATA_SIZE+2:DS_DATA_SIZE]) :
			  (data_ratio[1:0] == 2'h2) ? ({1'b0, us_arwaddr_mux[DS_DATA_SIZE+1:DS_DATA_SIZE]}) :
						{2'b0, us_arwaddr_mux[DS_DATA_SIZE[2:0]]};

assign ds_trans_length	= (data_ratio[1:0] == 2'h3) ? {us_arwlen_mux, (~us_arwaddr_mux[DS_DATA_SIZE+2:DS_DATA_SIZE])} :
			  (data_ratio[1:0] == 2'h2) ? {1'b0, us_arwlen_mux, (~us_arwaddr_mux[DS_DATA_SIZE+1:DS_DATA_SIZE])} :
			  (data_ratio[1:0] == 2'h1) ? {2'b0, us_arwlen_mux, (~us_arwaddr_mux[DS_DATA_SIZE[2:0]])} :
			                      	 {3'h0, us_arwlen_mux};

assign incr_split_detect	= (|ds_trans_length[10:8]) && bypass_us_trans;
assign wrap_split_detect	= (us_arwburst_mux == WRAP) && (|ds_trans_length[6:4]) && bypass_us_trans && (!align_wrap);
assign fixed_split_detect	= (us_arwburst_mux == FIXED) && data_size_big_than_ds && bypass_us_trans && (|us_arwlen_mux);
assign single_burst_split_detect= data_size_big_than_ds && bypass_us_trans && (!(|us_arwlen_mux)) && (|ds_trans_length[1:0]);

assign one_shift_split_data_ratio = 4'h1 << split_data_ratio;
assign split_complete	= (split_single_mux) 		? (!(|split_arwlen[2:0])):
			  (split_arwburst == FIXED) 	? (split_arwlen  <= {7'h0, one_shift_split_data_ratio}):
			  (split_arwburst == WRAP) 	? 1'b1 :
			  				  (split_arwlen[10:8] == 3'h0);

assign split_arwlen_mux		= split_detect ? ds_trans_length 		: split_arwlen;
assign split_arwaddr_mux	= split_detect ? us_arwaddr_mux 		: split_arwaddr;
assign split_arwburst_mux	= split_detect ? us_arwburst_mux 		: split_arwburst;
assign split_data_ratio_mux	= split_detect ? data_ratio[1:0]		: split_data_ratio;
assign split_single_mux		= split_detect ? single_burst_split_detect	: split_single;

assign split_fixed_len_offset	= (split_data_ratio_mux == 2'h3) ? {1'h0, split_arwaddr_mux[DS_DATA_SIZE+2:DS_DATA_SIZE]} :
				  (split_data_ratio_mux == 2'h2) ? {2'h0, split_arwaddr_mux[DS_DATA_SIZE+1:DS_DATA_SIZE]} :
									{3'b0, split_arwaddr_mux[DS_DATA_SIZE[2:0]]};
assign split_fixed_length	= (4'h1 << split_data_ratio_mux) - split_fixed_len_offset - 4'h1 ;
assign split_fixed_dec_length	= split_detect ? split_fixed_length : (4'h1 << (split_data_ratio_mux));

assign single_fixed	= (us_arwburst_mux == FIXED) && data_size_big_than_ds && bypass_us_trans && (!(|us_arwlen_mux));
assign switch_ds_burst	= split_detect || align_wrap || single_fixed;

assign ds_first_trans_len	= single_burst_split_detect	? 8'b0 :
				  fixed_split_detect		? {4'h0, split_fixed_length} :
			  	  wrap_split_detect		? wrap_split_length[7:0] - 8'h1:
			 	  incr_split_detect		? {6'h3f, ds_trans_length[1:0]}:
			  			  	  	  ds_trans_length[7:0];

assign ds_split_trans_len	= split_single			? 8'b0 :
				  (split_arwburst == FIXED) 	? {4'h0, split_fixed_length} :
				  (split_arwburst == WRAP) 	? split_arwlen[7:0] - 8'h1:
				  (split_arwlen[10:8] != 3'h0)	? 8'd255 :
			  					  split_arwlen[7:0];

assign split_arwaddr_offset = SPLIT_ARWADDR_DATA_WIDTH[7:0];

always @(*) begin
	if (us_cmd_valid && (!bypass_us_trans)) begin
		buffer_valid_a1 = 1'b1;
	end
	else if (bypass_us_trans) begin
		buffer_valid_a1 = 1'b0;
	end
	else begin
		buffer_valid_a1 = buffer_valid;
	end
end

always @(*) begin
	if (us_cmd_valid) begin
		cmd_buffer_a1 = buffer_wdata;
	end
	else begin
		cmd_buffer_a1 = cmd_buffer;
	end
end

always @(*) begin
	if (bypass_us_trans) begin
		us_arwready_a1	= 1'b1;
	end
	else if (us_cmd_valid && (!bypass_us_trans)) begin
		us_arwready_a1	= 1'b0;
	end
	else begin
		us_arwready_a1 = us_arwready;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		buffer_valid 	<= 1'b0;
		cmd_buffer	<= {(ADDR_FIFO_WIDTH){1'b0}};
		us_arwready 	<= 1'b0;
	end
	else begin
		buffer_valid 	<= buffer_valid_a1;
		cmd_buffer	<= cmd_buffer_a1;
		us_arwready 	<= us_arwready_a1;
	end
end

always @(*) begin
	if (us_arwvalid || buffer_valid) begin
		split_detect = wrap_split_detect || incr_split_detect || fixed_split_detect || single_burst_split_detect;
	end
	else begin
		split_detect = 1'b0;
	end
end

always @(*) begin
	if (split_stage && split_complete && ds_cmd_valid) begin
		split_stage_a1 = 1'b0;
	end
	else if ((!split_stage) && split_detect)begin
		split_stage_a1 = 1'b1;
	end
	else begin
		split_stage_a1 = split_stage;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		split_stage 	<= 1'b0;
	end
	else begin
		split_stage 	<= split_stage_a1;
	end
end

always @(*) begin
	if ((&us_arwlen_mux[3:0]) && us_arwsize_mux == 3'h5) begin
		wrap_start_addr		= 2'h0;
		wrap_split_length	= (10'h200 - {1'h0, us_arwaddr_mux[8:0]}) >> DS_DATA_SIZE[2:0];
		wrap_split_next_length	= us_arwaddr_mux[8:0] >> DS_DATA_SIZE[2:0];
		align_wrap		= (!(|us_arwaddr_mux[8:0])) && (us_arwburst_mux == WRAP);
	end
	else if ((&us_arwlen_mux[2:0]) && us_arwsize_mux == 3'h5) begin
		wrap_start_addr		= {us_arwaddr_mux[8], 1'b0};
		wrap_split_length	= (10'h100 - {2'h0, us_arwaddr_mux[7:0]}) >> DS_DATA_SIZE[2:0];
		wrap_split_next_length	= us_arwaddr_mux[7:0] >> DS_DATA_SIZE[2:0];
		align_wrap		= (!(|us_arwaddr_mux[7:0])) && (us_arwburst_mux == WRAP);
	end
	else if ((&us_arwlen_mux[3:0]) && us_arwsize_mux == 3'h4) begin
		wrap_start_addr		= {us_arwaddr_mux[8], 1'b0};
		wrap_split_length	= (10'h100 - {2'h0, us_arwaddr_mux[7:0]}) >> DS_DATA_SIZE[2:0];
		wrap_split_next_length	= us_arwaddr_mux[7:0] >> DS_DATA_SIZE[2:0];
		align_wrap		= (!(|us_arwaddr_mux[7:0])) && (us_arwburst_mux == WRAP);
	end
	else begin
		wrap_start_addr		= us_arwaddr_mux[8:7];
		wrap_split_length	= (10'h080 - {3'h0, us_arwaddr_mux[6:0]}) >> DS_DATA_SIZE[2:0];
		wrap_split_next_length	= {1'b0, us_arwaddr_mux[6:0]} >> DS_DATA_SIZE[2:0];
		align_wrap		= (!(|us_arwaddr_mux[6:0])) && (us_arwburst_mux == WRAP);
	end
end

generate
	if (DS_DATA_WIDTH == 32) begin :incr_addr_ds_width_32
		always @(*) begin
			case (split_arwlen_mux[1:0])
			2'h0:
				split_incr_addr = {(2'b0), 12'h3f4};
			2'h1:
				split_incr_addr = {(2'b0), 12'h3f8};
			2'h2:
				split_incr_addr = {(2'b0), 12'h3fc};
			2'h3:
				split_incr_addr = {(2'b0), 12'h400};
			endcase
		end
	end
	if (DS_DATA_WIDTH == 64) begin :incr_addr_ds_width_64
		always @(*) begin
			case (split_arwlen_mux[1:0])
			2'h0:
				split_incr_addr = {(1'b0), 12'h3f4, (1'b0)};
			2'h1:
				split_incr_addr = {(1'b0), 12'h3f8, (1'b0)};
			2'h2:
				split_incr_addr = {(1'b0), 12'h3fc, (1'b0)};
			2'h3:
				split_incr_addr = {(1'b0), 12'h400, (1'b0)};
			endcase
		end
	end
	if (DS_DATA_WIDTH == 128) begin :incr_addr_ds_width_128
		always @(*) begin
			case (split_arwlen_mux[1:0])
			2'h0:
				split_incr_addr = {12'h3f4, (2'b0)};
			2'h1:
				split_incr_addr = {12'h3f8, (2'b0)};
			2'h2:
				split_incr_addr = {12'h3fc, (2'b0)};
			2'h3:
				split_incr_addr = {12'h400, (2'b0)};
			endcase
		end
	end
endgenerate

always @(*) begin
	if ((split_detect || ds_arwready) && (!cmd_fifo_full)) begin
		if (split_single_mux) begin
			split_arwlen_a1 =  split_detect ? {8'h0, ((3'h1 << data_ratio) - 3'h2 - tmp_data)} : {8'h0, (split_arwlen[2:0] - 3'h1)};
		end
		else if (split_arwburst_mux == WRAP) begin
			split_arwlen_a1 = {3'h0, wrap_split_next_length};
		end
		else if (split_arwburst_mux == INCR) begin
			split_arwlen_a1 = (|split_arwlen_mux[10:8]) ? {(split_arwlen_mux[10:8] - 3'h1), split_arwlen_mux[7:2], 2'h3} :
								       11'h0;

		end
		else begin
			split_arwlen_a1 = split_arwlen_mux - {7'h0, split_fixed_dec_length};
		end
	end
	else begin
		split_arwlen_a1 = split_arwlen;
	end
end

always @(*) begin
	if ((split_detect || ds_arwready) && (!cmd_fifo_full)) begin
		if (split_single_mux) begin
			split_arwaddr_a1 = {split_arwaddr_mux[ADDR_WIDTH-1 : DS_DATA_SIZE], {(DS_DATA_SIZE){1'b0}}} + {{(ADDR_WIDTH-8){1'b0}},split_arwaddr_offset};
		end
		else if (split_arwburst_mux == WRAP) begin
			split_arwaddr_a1 = {us_arwaddr_mux[ADDR_WIDTH-1:9], wrap_start_addr, 7'h0};
		end
		else if (split_arwburst_mux == INCR) begin
			split_arwaddr_a1 = {split_arwaddr_mux[ADDR_WIDTH-1 : DS_DATA_SIZE], {(DS_DATA_SIZE){1'b0}}}  + {{(ADDR_WIDTH-14){1'b0}}, split_incr_addr};
		end
		else begin
			split_arwaddr_a1 = split_arwaddr_mux;
		end
	end
	else begin
		split_arwaddr_a1 = split_arwaddr;
	end
end

always @(*) begin
	if (split_stage) begin
		if (|split_arwlen_mux[2:0] == 1'b0) begin
			split_single_a1		= 1'b0;
		end
		else begin
			split_single_a1		= split_single;
		end
	end
	else if ((split_detect || ds_arwready) && (!cmd_fifo_full)) begin
		split_single_a1		= single_burst_split_detect;
	end
	else begin
		split_single_a1		= split_single;
	end
end

always @(*) begin
	if ((split_detect || ds_arwready) && (!cmd_fifo_full)) begin
		split_arwburst_a1	= split_arwburst_mux;
		split_data_ratio_a1	= split_data_ratio_mux;
	end
	else begin
		split_arwburst_a1	= split_arwburst;
		split_data_ratio_a1	= split_data_ratio;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		split_arwlen 		<= 11'h0;
		split_arwaddr		<= {(ADDR_WIDTH){1'b0}};
		split_arwburst		<= 2'h0;
		split_data_ratio	<= 2'h0;
		split_single		<= 1'b0;
	end
	else begin
		split_arwlen 		<= split_arwlen_a1;
		split_arwaddr		<= split_arwaddr_a1;
		split_arwburst		<= split_arwburst_a1;
		split_data_ratio	<= split_data_ratio_a1;
		split_single		<= split_single_a1;
	end
end


always @(*) begin
	if (split_stage && ds_arwready && (!cmd_fifo_full)) begin
		ds_arwaddr_a1	= split_arwaddr;
		ds_arwlen_a1	= ds_split_trans_len;
		ds_arwburst_a1	= INCR;
		us_last_burst_a1= split_complete;
	end
	else if (bypass_us_trans) begin
		ds_arwaddr_a1	= us_arwaddr_mux;
		ds_arwlen_a1	= ds_first_trans_len;
		ds_arwburst_a1	= (switch_ds_burst) ? INCR : us_arwburst_mux;
		us_last_burst_a1= split_detect ? 1'b0 : 1'b1;
	end
	else begin
		ds_arwaddr_a1	= ds_arwaddr;
		ds_arwlen_a1	= ds_arwlen;
		ds_arwburst_a1	= ds_arwburst;
		us_last_burst_a1= us_last_burst;
	end
end

generate
	if (READ_CHANNEL == 1) begin :read_lock_handling
		always @(*) begin
			if (split_stage && ds_arwready && (!cmd_fifo_full)) begin
				ds_arwlock_a1	= 1'h0;
			end
			else if (bypass_us_trans) begin
				ds_arwlock_a1	= split_detect ? 1'b0 : us_arwlock_mux;
			end
			else begin
				ds_arwlock_a1	= ds_arwlock;
			end
		end
	end
	else begin :write_lock_handling
		always @(*) begin
			if (bypass_us_trans) begin
				ds_arwlock_a1	= us_arwlock_mux;
			end
			else begin
				ds_arwlock_a1	= ds_arwlock;
			end
		end
	end
endgenerate

always @(*) begin
	if (bypass_us_trans) begin
		ds_addr_valid_a1= buffer_valid ? 1'b1 : us_arwvalid;
		ds_arwsize_a1	= (us_arwsize_mux > DS_DATA_SIZE[2:0]) ? DS_DATA_SIZE[2:0] : us_arwsize_mux;
		ds_arwcache_a1	= us_arwcache_mux;
		ds_arwprot_a1	= us_arwprot_mux;

		us_data_size_a1	= us_arwsize_mux;
		us_data_id_a1	= us_arwid_mux;
	end
	else begin
		ds_addr_valid_a1= ds_addr_valid;
		ds_arwsize_a1	= ds_arwsize;
		ds_arwcache_a1	= ds_arwcache;
		ds_arwprot_a1	= ds_arwprot;

		us_data_size_a1	= us_data_size;
		us_data_id_a1	= us_data_id;
	end
end

always @(posedge aclk or negedge aresetn) begin
	if (!aresetn) begin
		ds_addr_valid 	<= 1'h0;
		ds_arwaddr  	<= {(ADDR_WIDTH){1'b0}};
		ds_arwlen   	<= 8'h0;
		ds_arwsize  	<= 3'h0;
		ds_arwburst 	<= 2'h0;
		ds_arwlock  	<= 1'h0;
		ds_arwcache 	<= 4'h0;
		ds_arwprot  	<= 3'h0;

		us_data_size	<= 3'h0;
		us_data_id	<= {(ID_WIDTH){1'b0}};
		us_last_burst	<= 1'b0;
	end
	else begin
		ds_addr_valid 	<= ds_addr_valid_a1;
		ds_arwaddr  	<= ds_arwaddr_a1;
		ds_arwlen   	<= ds_arwlen_a1;
		ds_arwsize  	<= ds_arwsize_a1;
		ds_arwburst 	<= ds_arwburst_a1;
		ds_arwlock  	<= ds_arwlock_a1;
		ds_arwcache 	<= ds_arwcache_a1;
		ds_arwprot  	<= ds_arwprot_a1;

		us_data_size	<= us_data_size_a1;
		us_data_id	<= us_data_id_a1;
		us_last_burst	<= us_last_burst_a1;
	end
end
assign ds_arwvalid = cmd_fifo_full ? 1'b0 : ds_addr_valid;


endmodule
