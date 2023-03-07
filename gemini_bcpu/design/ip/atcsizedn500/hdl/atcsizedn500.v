// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module atcsizedn500 (
        	  us_a_opcode,
        	  us_a_param,
        	  us_a_user,
        	  us_a_size,
        	  us_a_address,
        	  us_a_source,
        	  us_a_data,
        	  us_a_mask,
        	  us_a_corrupt,
        	  us_a_valid,
        	  us_a_ready,
        	  us_b_opcode,
        	  us_b_param,
        	  us_b_size,
        	  us_b_source,
        	  us_b_address,
        	  us_b_user,
        	  us_b_data,
        	  us_b_mask,
        	  us_b_corrupt,
        	  us_b_valid,
        	  us_b_ready,
        	  us_c_opcode,
        	  us_c_param,
        	  us_c_size,
        	  us_c_source,
        	  us_c_address,
        	  us_c_user,
        	  us_c_data,
        	  us_c_corrupt,
        	  us_c_valid,
        	  us_c_ready,
        	  us_d_opcode,
        	  us_d_param,
        	  us_d_size,
        	  us_d_user,
        	  us_d_data,
        	  us_d_source,
        	  us_d_sink,
        	  us_d_denied,
        	  us_d_corrupt,
        	  us_d_valid,
        	  us_d_ready,
        	  us_e_valid,
        	  us_e_user,
        	  us_e_sink,
        	  us_e_ready,
        	  ds_a_opcode,
        	  ds_a_param,
        	  ds_a_user,
        	  ds_a_size,
        	  ds_a_address,
        	  ds_a_data,
        	  ds_a_mask,
        	  ds_a_source,
        	  ds_a_corrupt,
        	  ds_a_valid,
        	  ds_a_ready,
        	  ds_b_opcode,
        	  ds_b_param,
        	  ds_b_size,
        	  ds_b_source,
        	  ds_b_address,
        	  ds_b_user,
        	  ds_b_data,
        	  ds_b_mask,
        	  ds_b_corrupt,
        	  ds_b_valid,
        	  ds_b_ready,
        	  ds_c_opcode,
        	  ds_c_param,
        	  ds_c_size,
        	  ds_c_source,
        	  ds_c_address,
        	  ds_c_user,
        	  ds_c_data,
        	  ds_c_corrupt,
        	  ds_c_valid,
        	  ds_c_ready,
        	  ds_d_opcode,
        	  ds_d_param,
        	  ds_d_user,
        	  ds_d_size,
        	  ds_d_data,
        	  ds_d_source,
        	  ds_d_sink,
        	  ds_d_denied,
        	  ds_d_corrupt,
        	  ds_d_valid,
        	  ds_d_ready,
        	  ds_e_valid,
        	  ds_e_user,
        	  ds_e_sink,
        	  ds_e_ready,
        	  clk,
        	  resetn
);
parameter AW	 = 32;
parameter US_DW	 = 64;
parameter DS_DW	 = 32;
parameter OW  	 = 2;
parameter IW     = 2;
parameter A_UW   = 2;
parameter B_UW   = 2;
parameter C_UW   = 2;
parameter D_UW   = 2;
parameter E_UW   = 2;
localparam ZW    = 3;
localparam PRODUCT_ID = 32'h00095005;
localparam OST_NUM = 1<<OW;
localparam US_BYTE_NUM = US_DW/8;
localparam DS_BYTE_NUM = DS_DW/8;
localparam DW_RATIO = US_DW/DS_DW;
localparam DW_RATIO_LOG2 = $clog2(DW_RATIO);
localparam US_BYTE_NUM_LOG2 = $clog2(US_BYTE_NUM);
localparam DS_BYTE_NUM_LOG2 = $clog2(DS_BYTE_NUM);
localparam MAX_BYTE_SIZE_LOG2 = {{32-ZW{1'b0}},{ZW{1'b1}}};
localparam US_BEAT_CW = MAX_BYTE_SIZE_LOG2 - US_BYTE_NUM_LOG2;
localparam DS_BEAT_CW = MAX_BYTE_SIZE_LOG2 - DS_BYTE_NUM_LOG2;

localparam TL_OP_PUTFULL	= 3'd0;
localparam TL_OP_PUTPART	= 3'd1;
localparam TL_OP_ARITHETIC	= 3'd2;
localparam TL_OP_LOGICAL	= 3'd3;
localparam TL_OP_GET		= 3'd4;
localparam TL_OP_ACQUIREBLOCK	= 3'd6;


localparam TL_OP_ACCESSACK	= 3'd0;
localparam TL_OP_ACCESSACKDATA	= 3'd1;
localparam TL_OP_PROBEACKDATA	= 3'd5;
localparam TL_OP_RELEASE	= 3'd6;
localparam TL_OP_RELEASEDATA	= 3'd7;

localparam TL_OP_GRANT		= 3'd4;
localparam TL_OP_GRANTDATA	= 3'd5;
localparam TL_OP_RELEASEACK	= 3'd6;

input                     [2:0] us_a_opcode;
input    		  [2:0] us_a_param;
input     [A_UW-1:0] us_a_user;
input       	       [ZW-1:0] us_a_size;
input                  [AW-1:0] us_a_address;
input     	    [OW-1:0] us_a_source;
input               [US_DW-1:0] us_a_data;
input           [(US_DW/8)-1:0] us_a_mask;
input                           us_a_corrupt;
input                           us_a_valid;
output                          us_a_ready;

output                    [2:0] us_b_opcode;
output                    [2:0] us_b_param;
output                 [ZW-1:0] us_b_size;
output    	    [OW-1:0] us_b_source;
output                 [AW-1:0] us_b_address;
output    [B_UW-1:0] us_b_user;
output              [US_DW-1:0] us_b_data;
output          [(US_DW/8)-1:0] us_b_mask;
output                          us_b_corrupt;
output                          us_b_valid;
input                           us_b_ready;

input                     [2:0] us_c_opcode;
input                     [2:0] us_c_param;
input                  [ZW-1:0] us_c_size;
input     	    [OW-1:0] us_c_source;
input                  [AW-1:0] us_c_address;
input     	     [C_UW-1:0] us_c_user;
input               [US_DW-1:0] us_c_data;
input                           us_c_corrupt;
input                           us_c_valid;
output                          us_c_ready;


output                    [2:0] us_d_opcode;
output                    [1:0] us_d_param;
output                 [ZW-1:0] us_d_size;
output    [D_UW-1:0] us_d_user;
output              [US_DW-1:0] us_d_data;
output    	    [OW-1:0] us_d_source;
output      	       [IW-1:0] us_d_sink;
output                          us_d_denied;
output                          us_d_corrupt;
output                          us_d_valid;
input                           us_d_ready;

input                           us_e_valid;
input      [E_UW-1:0]  us_e_user;
input      [IW-1:0]  us_e_sink;
output                          us_e_ready;
output                    [2:0] ds_a_opcode;
output   		  [2:0] ds_a_param;
output    [A_UW-1:0] ds_a_user;
output      	       [ZW-1:0] ds_a_size;
output                 [AW-1:0] ds_a_address;
output              [DS_DW-1:0] ds_a_data;
output          [(DS_DW/8)-1:0] ds_a_mask;
output    	    [OW-1:0] ds_a_source;
output                          ds_a_corrupt;
output                          ds_a_valid;
input                           ds_a_ready;

input                     [2:0] ds_b_opcode;
input                     [2:0] ds_b_param;
input                  [ZW-1:0] ds_b_size;
input    	    [OW-1:0] ds_b_source;
input                  [AW-1:0] ds_b_address;
input     [B_UW-1:0] ds_b_user;
input               [DS_DW-1:0] ds_b_data;
input           [(DS_DW/8)-1:0] ds_b_mask;
input                           ds_b_corrupt;
input                           ds_b_valid;
output                          ds_b_ready;

output                    [2:0] ds_c_opcode;
output                    [2:0] ds_c_param;
output                 [ZW-1:0] ds_c_size;
output    	       [OW-1:0] ds_c_source;
output                 [AW-1:0] ds_c_address;
output    	     [C_UW-1:0] ds_c_user;
output              [DS_DW-1:0] ds_c_data;
output                          ds_c_corrupt;
output                          ds_c_valid;
input                           ds_c_ready;

input                     [2:0] ds_d_opcode;
input                     [1:0] ds_d_param;
input     [D_UW-1:0] ds_d_user;
input                  [ZW-1:0] ds_d_size;
input               [DS_DW-1:0] ds_d_data;
input     	    [OW-1:0] ds_d_source;
input       	       [IW-1:0] ds_d_sink;
input                           ds_d_denied;
input                           ds_d_corrupt;
input                           ds_d_valid;
output                          ds_d_ready;

output                          ds_e_valid;
output      	       [E_UW-1:0] ds_e_user;
output      	       [IW-1:0] ds_e_sink;
input                           ds_e_ready;

input                           clk;
input                           resetn;

localparam A_CTRL_WIDTH = AW+OW+A_UW+ZW+3+3;
localparam B_CTRL_WIDTH = AW+OW+B_UW+ZW+3+3;
localparam C_CTRL_WIDTH = AW+OW+ZW+3+3;
localparam A_PL_WIDTH   = US_DW+(US_DW/8)+1;
localparam B_PL_WIDTH   = DS_DW+(DS_DW/8)+1;
localparam C_PL_WIDTH   = US_DW+C_UW+1;
localparam A_CRPT_MSB   = 0;
localparam A_MASK_MSB   = A_CRPT_MSB + (US_DW/8);
localparam A_DATA_MSB   = A_MASK_MSB + US_DW;

localparam B_CRPT_MSB   = 0;
localparam B_MASK_MSB   = B_CRPT_MSB + (DS_DW/8);
localparam B_DATA_MSB   = B_MASK_MSB + DS_DW;


localparam C_CRPT_MSB   = 0;
localparam C_USER_MSB   = C_CRPT_MSB + C_UW;
localparam C_DATA_MSB   = C_USER_MSB + US_DW;

localparam A_SRC_MSB    = OW-1;
localparam A_ADDR_MSB   = A_SRC_MSB  + AW;
localparam A_SIZE_MSB   = A_ADDR_MSB + ZW;
localparam A_USER_MSB   = A_SIZE_MSB + A_UW;
localparam A_PARAM_MSB  = A_USER_MSB + 3;
localparam A_OPCODE_MSB = A_PARAM_MSB + 3;

localparam B_SRC_MSB    = OW-1;
localparam B_ADDR_MSB   = B_SRC_MSB  + AW;
localparam B_SIZE_MSB   = B_ADDR_MSB + ZW;
localparam B_USER_MSB   = B_SIZE_MSB + B_UW;
localparam B_PARAM_MSB  = B_USER_MSB + 3;
localparam B_OPCODE_MSB = B_PARAM_MSB + 3;

localparam C_SRC_MSB    = OW-1;
localparam C_ADDR_MSB   = C_SRC_MSB  + AW;
localparam C_SIZE_MSB   = C_ADDR_MSB + ZW;
localparam C_PARAM_MSB  = C_SIZE_MSB  + 3;
localparam C_OPCODE_MSB = C_PARAM_MSB + 3;

wire us_a_rd_multi_beat_cmd = (us_a_opcode==TL_OP_GET) |
                              (us_a_opcode==TL_OP_ACQUIREBLOCK) |
                              (us_a_opcode==TL_OP_LOGICAL) |
                              (us_a_opcode==TL_OP_ARITHETIC);

wire us_a_wr_multi_beat_cmd = (us_a_opcode==TL_OP_PUTFULL) |
                              (us_a_opcode==TL_OP_PUTPART) |
                              (us_a_opcode==TL_OP_LOGICAL) |
                              (us_a_opcode==TL_OP_ARITHETIC);

wire us_c_wr_multi_beat_cmd = (us_c_opcode==TL_OP_RELEASEDATA) |
                              (us_c_opcode==TL_OP_PROBEACKDATA) |
                              (us_c_opcode==TL_OP_ACCESSACKDATA);

wire ds_c_wr_multi_beat_cmd = (ds_c_opcode==TL_OP_RELEASEDATA) |
                              (ds_c_opcode==TL_OP_PROBEACKDATA) |
                              (ds_c_opcode==TL_OP_ACCESSACKDATA);

wire us_c_ostding_cmd = (us_c_opcode==TL_OP_RELEASEDATA) |
                        (us_c_opcode==TL_OP_RELEASE);

wire us_d_grant       = (us_d_opcode==TL_OP_GRANT);
wire us_d_release_ack = (us_d_opcode==TL_OP_RELEASEACK);
wire ds_d_release_ack = (ds_d_opcode==TL_OP_RELEASEACK);
wire us_d_access_ack = (us_d_opcode==TL_OP_ACCESSACK) | (us_d_opcode==TL_OP_ACCESSACKDATA);
wire ds_d_read_data = (ds_d_opcode==TL_OP_ACCESSACKDATA) |
                      (ds_d_opcode==TL_OP_GRANTDATA);
reg [OST_NUM-1:0] pending_d_corrupt;
reg [OST_NUM-1:0] pending_d_denied;
wire [OST_NUM-1:0] us_d_ost_sel;


reg [OST_NUM-1:0] ch_a_burst_ostding;
reg                    [2:0] ds_a_opcode;
reg                    [2:0] ds_a_param;
reg    [A_UW-1:0] ds_a_user;
reg      [ZW-1:0] ds_a_size;
reg                 [AW-1:0] ds_a_address;
reg    		 [OW-1:0] ds_a_source;
reg                          ds_a_corrupt;
reg                          ds_a_valid;
reg              [US_DW-1:0] us_a_data_d;
reg  	     [(US_DW/8)-1:0] us_a_mask_d;
reg [US_BEAT_CW-1:0] us_a_beat_cnt;
wire clr_ds_a_valid;
wire ds_a_beat_last;
wire [OST_NUM-1:0] us_a_ost_sel;
reg  [OW-1:0] current_us_a_source;
wire [OST_NUM-1:0] current_us_a_ost_sel;
wire set_d_resp_middle_a_burst;
wire clr_d_resp_middle_a_burst;
reg d_resp_middle_a_burst;
reg  us_a_pending_valid;
reg [A_CTRL_WIDTH-1:0] us_a_pending_ctrl;
reg [A_PL_WIDTH-1:0]   us_a_pending_pay_load;
wire [MAX_BYTE_SIZE_LOG2-1:0] us_a_length = ~({MAX_BYTE_SIZE_LOG2{1'b1}} << {{(MAX_BYTE_SIZE_LOG2-ZW){1'b0}},us_a_size});
wire us_a_beat_begin = ~|us_a_beat_cnt;
wire [US_BEAT_CW-1:0] us_a_beat_cnt_nx =
					 us_a_beat_cnt + ({US_BEAT_CW{us_a_valid & us_a_ready}} &
                                                         ({US_BEAT_CW{~us_a_beat_begin}} |
                                                         ({US_BEAT_CW{us_a_wr_multi_beat_cmd}} & us_a_length[US_BYTE_NUM_LOG2+:US_BEAT_CW])));
always@(posedge clk or negedge resetn)
	if(~resetn)
		us_a_beat_cnt <= {US_BEAT_CW{1'b0}};
	else
		us_a_beat_cnt <= us_a_beat_cnt_nx;

always@(posedge clk)
		current_us_a_source <= (us_a_valid & us_a_ready & us_a_beat_begin) ? us_a_source : current_us_a_source;

wire [DW_RATIO-1:0] ds_a_data_index;
wire [DW_RATIO-1:0] ds_a_data_sel;
reg  [DW_RATIO-1:0] ds_a_data_ptr;
reg [DW_RATIO_LOG2-1:0] ds_a_beat_ratio;
wire [DW_RATIO_LOG2-1:0] ds_a_beat_ratio_sel = ((us_a_valid & us_a_ready & us_a_beat_begin) ?
                                 ({DW_RATIO_LOG2{us_a_wr_multi_beat_cmd}} & us_a_length[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2]) :
					ds_a_beat_ratio);
always@(posedge clk or negedge resetn)
	if(~resetn)
		ds_a_beat_ratio <= {DW_RATIO_LOG2{1'b0}};
	else
		ds_a_beat_ratio <= ds_a_beat_ratio_sel + {DW_RATIO_LOG2{ds_a_valid & ds_a_ready}};

assign ds_a_beat_last = ~|ds_a_beat_ratio_sel;
assign ds_a_data_index = (us_a_valid & us_a_ready & us_a_beat_begin) ? ds_a_data_sel : ds_a_data_ptr;

always@(posedge clk or negedge resetn)
	if(~resetn)
		ds_a_data_ptr <= {{DW_RATIO-1{1'b0}},1'b1};
       else
		ds_a_data_ptr <=
				 (ds_a_valid & ds_a_ready) ? {ds_a_data_index[DW_RATIO-2:0],ds_a_data_index[DW_RATIO-1]} :
				 ds_a_data_index;

atcsizedn500_bin2onehot #(.N(DW_RATIO)) u_ds_a_addr_ptr (.in(us_a_address[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2]), .out(ds_a_data_sel));
atcsizedn500_mux_onehot #(.W(DS_DW),   .N(DW_RATIO)) u_ds_a_data (.out(ds_a_data), .in(us_a_data_d), .sel(ds_a_data_index));
atcsizedn500_mux_onehot #(.W(DS_DW/8), .N(DW_RATIO)) u_ds_a_mask (.out(ds_a_mask), .in(us_a_mask_d), .sel(ds_a_data_index));

assign us_a_ready  	= ~us_a_pending_valid & (~us_a_beat_begin | ~ch_a_burst_ostding[us_a_source]);


wire set_us_a_pending_valid = us_a_valid & us_a_ready & ds_a_valid & ~clr_ds_a_valid;
wire clr_us_a_pending_valid = ds_a_valid & clr_ds_a_valid;

always@(posedge clk or negedge resetn)
	if(~resetn)
		us_a_pending_valid <= 1'b0;
	else
		us_a_pending_valid <= set_us_a_pending_valid | (us_a_pending_valid & ~clr_us_a_pending_valid);
always@(posedge clk)
	if(set_us_a_pending_valid)
	us_a_pending_ctrl <= {
				us_a_opcode,
				us_a_param,
				us_a_user,
				us_a_size,
				us_a_address,
				us_a_source
				};
always@(posedge clk)
	if(set_us_a_pending_valid)
	us_a_pending_pay_load <= {
				us_a_data,
				us_a_mask,
				us_a_corrupt
				};
assign clr_ds_a_valid = ds_a_ready & ds_a_beat_last;
always@* begin
	 ds_a_valid     = us_a_pending_valid | (us_a_valid & us_a_ready);
	 ds_a_opcode 	= us_a_pending_valid ? us_a_pending_ctrl[A_OPCODE_MSB:(A_PARAM_MSB+1)] : us_a_opcode;
	 ds_a_param  	= us_a_pending_valid ? us_a_pending_ctrl[A_PARAM_MSB :(A_USER_MSB+1)] : us_a_param;
	 ds_a_user   	= us_a_pending_valid ? us_a_pending_ctrl[A_USER_MSB  :(A_SIZE_MSB+1)] : us_a_user;
	 ds_a_size   	= us_a_pending_valid ? us_a_pending_ctrl[A_SIZE_MSB  :(A_ADDR_MSB+1)] : us_a_size;
	 ds_a_address	= us_a_pending_valid ? us_a_pending_ctrl[A_ADDR_MSB  :(A_SRC_MSB+1)] : us_a_address;
	 ds_a_source 	= us_a_pending_valid ? us_a_pending_ctrl[A_SRC_MSB:0] : us_a_source;
	 us_a_data_d   	= us_a_pending_valid ? us_a_pending_pay_load[A_DATA_MSB:(A_MASK_MSB+1)] : us_a_data;
	 us_a_mask_d   	= us_a_pending_valid ? us_a_pending_pay_load[A_MASK_MSB:(A_CRPT_MSB+1)] : us_a_mask;
	 ds_a_corrupt	= us_a_pending_valid ? us_a_pending_pay_load[A_CRPT_MSB] : us_a_corrupt;
end
atcsizedn500_bin2onehot #(.N(OST_NUM)) u_us_a_src (.out(us_a_ost_sel), .in(us_a_source));
atcsizedn500_bin2onehot #(.N(OST_NUM)) u_curr_us_a_src (.out(current_us_a_ost_sel), .in(current_us_a_source));



reg [OST_NUM-1:0] ch_c_burst_ostding;
reg                    [2:0] ds_c_opcode;
reg                    [2:0] ds_c_param;
reg    [C_UW-1:0] ds_c_user;
reg      [ZW-1:0] ds_c_size;
reg                 [AW-1:0] ds_c_address;
reg    		 [OW-1:0] ds_c_source;
reg                          ds_c_corrupt;
reg                          ds_c_valid;
reg              [US_DW-1:0] us_c_data_d;
reg [US_BEAT_CW-1:0] us_c_beat_cnt;
reg [DS_BEAT_CW-1:0] ds_c_beat_cnt;
wire ds_c_beat_begin = ~|ds_c_beat_cnt;
wire clr_ds_c_valid;
wire ds_c_beat_last;
wire [OST_NUM-1:0] us_c_ost_sel;
reg  us_c_pending_valid;
reg  [OW-1:0] current_us_c_source;
wire [OST_NUM-1:0] current_us_c_ost_sel;
reg [C_CTRL_WIDTH-1:0] us_c_pending_ctrl;
reg [C_PL_WIDTH-1:0]   us_c_pending_pay_load;
wire set_d_resp_middle_c_burst;
wire clr_d_resp_middle_c_burst;
reg      d_resp_middle_c_burst;
wire [MAX_BYTE_SIZE_LOG2-1:0] us_c_length = ~({MAX_BYTE_SIZE_LOG2{1'b1}} << {{(MAX_BYTE_SIZE_LOG2-ZW){1'b0}},us_c_size});
wire us_c_beat_begin = ~|us_c_beat_cnt;
wire [US_BEAT_CW-1:0] us_c_beat_cnt_nx =
					 us_c_beat_cnt + ({US_BEAT_CW{us_c_valid & us_c_ready}} &
                                                         ({US_BEAT_CW{~us_c_beat_begin}} |
                                                         ({US_BEAT_CW{us_c_wr_multi_beat_cmd}} & us_c_length[US_BYTE_NUM_LOG2+:US_BEAT_CW])));
always@(posedge clk or negedge resetn)
	if(~resetn)
		us_c_beat_cnt <= {US_BEAT_CW{1'b0}};
	else
		us_c_beat_cnt <= us_c_beat_cnt_nx;

always@(posedge clk)
		current_us_c_source <= (us_c_valid & us_c_ready & us_c_beat_begin) ? us_c_source : current_us_c_source;

wire [MAX_BYTE_SIZE_LOG2-1:0] ds_c_length = ~({MAX_BYTE_SIZE_LOG2{1'b1}} << {{(MAX_BYTE_SIZE_LOG2-ZW){1'b0}},ds_c_size});
wire [DS_BEAT_CW-1:0] ds_c_beat_cnt_nx =
					 ds_c_beat_cnt + ({DS_BEAT_CW{ds_c_valid & ds_c_ready}} &
                                                         ({DS_BEAT_CW{~ds_c_beat_begin}} |
                                                         ({DS_BEAT_CW{ds_c_wr_multi_beat_cmd}} & ds_c_length[DS_BYTE_NUM_LOG2+:DS_BEAT_CW])));
always@(posedge clk or negedge resetn)
	if(~resetn)
		ds_c_beat_cnt <= {DS_BEAT_CW{1'b0}};
	else
		ds_c_beat_cnt <= ds_c_beat_cnt_nx;
wire [DW_RATIO-1:0] ds_c_data_index;
wire [DW_RATIO-1:0] ds_c_data_sel;
reg  [DW_RATIO-1:0] ds_c_data_ptr;
reg [DW_RATIO_LOG2-1:0] ds_c_beat_ratio;
wire [DW_RATIO_LOG2-1:0] ds_c_beat_ratio_sel = ((us_c_valid & us_c_ready & us_c_beat_begin) ?
                                 ({DW_RATIO_LOG2{us_c_wr_multi_beat_cmd}} & us_c_length[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2]) :
					ds_c_beat_ratio);
always@(posedge clk or negedge resetn)
	if(~resetn)
		ds_c_beat_ratio <= {DW_RATIO_LOG2{1'b0}};
	else
		ds_c_beat_ratio <= ds_c_beat_ratio_sel + {DW_RATIO_LOG2{ds_c_valid & ds_c_ready}};

assign ds_c_beat_last = ~|ds_c_beat_ratio_sel;
assign ds_c_data_index = (us_c_valid & us_c_ready & us_c_beat_begin) ? ds_c_data_sel : ds_c_data_ptr;

always@(posedge clk or negedge resetn)
	if(~resetn)
		ds_c_data_ptr <= {{DW_RATIO-1{1'b0}},1'b1};
       else
		ds_c_data_ptr <=
				 (ds_c_valid & ds_c_ready) ? {ds_c_data_index[DW_RATIO-2:0],ds_c_data_index[DW_RATIO-1]} :
				 ds_c_data_index;

atcsizedn500_bin2onehot #(.N(DW_RATIO)) u_ds_c_addr_ptr (.in(us_c_address[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2]), .out(ds_c_data_sel));
atcsizedn500_mux_onehot #(.W(DS_DW),   .N(DW_RATIO)) u_ds_c_data (.out(ds_c_data), .in(us_c_data_d), .sel(ds_c_data_index));

assign us_c_ready  	= ~us_c_pending_valid & (~us_c_beat_begin  | ~us_c_ostding_cmd | ~ch_c_burst_ostding[us_c_source]);

wire set_us_c_pending_valid = us_c_valid & us_c_ready & ds_c_valid & ~clr_ds_c_valid;
wire clr_us_c_pending_valid = ds_c_valid & clr_ds_c_valid;

always@(posedge clk or negedge resetn)
	if(~resetn)
		us_c_pending_valid <= 1'b0;
	else
		us_c_pending_valid <= set_us_c_pending_valid | (us_c_pending_valid & ~clr_us_c_pending_valid);

always@(posedge clk)
	if(set_us_c_pending_valid)
	us_c_pending_ctrl <= {
				us_c_opcode,
				us_c_param,
				us_c_size,
				us_c_address,
				us_c_source
				};
always@(posedge clk)
	if(set_us_c_pending_valid)
	us_c_pending_pay_load <= {
				us_c_data,
				us_c_user,
				us_c_corrupt
				};
assign clr_ds_c_valid = ds_c_ready & ds_c_beat_last;
always@* begin
	ds_c_valid = (us_c_valid & us_c_ready) | us_c_pending_valid;
	 ds_c_opcode 	= us_c_pending_valid ? us_c_pending_ctrl[C_OPCODE_MSB:(C_PARAM_MSB+1)] : us_c_opcode;
	 ds_c_param  	= us_c_pending_valid ? us_c_pending_ctrl[C_PARAM_MSB: (C_SIZE_MSB+1)] : us_c_param;
	 ds_c_size   	= us_c_pending_valid ? us_c_pending_ctrl[C_SIZE_MSB  :(C_ADDR_MSB+1)] : us_c_size;
	 ds_c_address	= us_c_pending_valid ? us_c_pending_ctrl[C_ADDR_MSB  :(C_SRC_MSB+1)] : us_c_address;
	 ds_c_source 	= us_c_pending_valid ? us_c_pending_ctrl[C_SRC_MSB:0] : us_c_source;
	 us_c_data_d   	= us_c_pending_valid ? us_c_pending_pay_load[C_DATA_MSB  :(C_USER_MSB+1)] : us_c_data;
	 ds_c_user   	= us_c_pending_valid ? us_c_pending_pay_load[C_USER_MSB  :(C_CRPT_MSB+1)] : us_c_user;
	 ds_c_corrupt	= us_c_pending_valid ? us_c_pending_pay_load[C_CRPT_MSB] : us_c_corrupt;
end
atcsizedn500_bin2onehot #(.N(OST_NUM)) u_us_c_src (.out(us_c_ost_sel), .in(us_c_source));
atcsizedn500_bin2onehot #(.N(OST_NUM)) u_curr_us_c_src (.out(current_us_c_ost_sel), .in(current_us_c_source));




reg [US_DW-1:0] data_buffer [0:OST_NUM-1];
reg [DW_RATIO-1:0] d_data_ptr [0:OST_NUM-1];
wire set_us_d_valid;
reg us_d_valid;
reg [OST_NUM-1:0] us_d2a_beat_last;
reg [US_BEAT_CW-1:0] us_d_beat_cnt [0:OST_NUM-1];
wire [OST_NUM-1:0] ds_d_ost_sel;
reg [2:0] us_d_opcode;
reg [1:0] us_d_param;
reg [D_UW-1:0] us_d_user;
reg [ZW-1:0] 		us_d_size;
reg [IW-1:0] us_d_sink;
reg [OW-1:0] us_d_source;
reg    us_d_denied;
reg    us_d_corrupt;

integer i,j,lc,l,mm,m,n,o,de,co,bq,br;
integer k;
wire [DW_RATIO-1:0] us_d_data_sel;
reg [DW_RATIO_LOG2-1:0] ds_d_beat_ratio [0:OST_NUM-1];
atcsizedn500_bin2onehot #(.N(DW_RATIO)) u_ds_d_addr_ptr (.in(us_a_address[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2]), .out(us_d_data_sel));
always@(posedge clk or negedge resetn)
	if(~resetn)
		for(j=0;j<OST_NUM;j=j+1)
			d_data_ptr[j] <= {DW_RATIO{1'b0}};
        else
		for(k=0;k<OST_NUM;k=k+1)
			d_data_ptr[k] <=
				      (us_a_valid & us_a_ready & us_a_ost_sel[k] & us_a_beat_begin) ? us_d_data_sel :
				      (ds_d_valid & ds_d_ready & ds_d_ost_sel[k] & ds_d_read_data) ? {d_data_ptr[k][DW_RATIO-2:0],d_data_ptr[k][DW_RATIO-1]} : d_data_ptr[k];

assign set_us_d_valid = ds_d_valid & ds_d_ready & (~ds_d_read_data | (~|ds_d_beat_ratio[ds_d_source]));

always@(posedge clk or negedge resetn)
	if(~resetn)
		for(bq=0;bq<OST_NUM;bq=bq+1)
		ds_d_beat_ratio[bq] <= {DW_RATIO_LOG2{1'b0}};
	else
		for(br=0;br<OST_NUM;br=br+1)
		ds_d_beat_ratio[br] <= (us_a_valid & us_a_ready & us_a_ost_sel[br] & us_a_beat_begin) ? ({DW_RATIO_LOG2{us_a_rd_multi_beat_cmd}} & us_a_length[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2]) : (ds_d_beat_ratio[br] + {DW_RATIO_LOG2{ds_d_valid & ds_d_ready & ds_d_ost_sel[br] & ~ds_d_release_ack}});

atcsizedn500_bin2onehot #(.N(OST_NUM)) u_ds_d_src (.out(ds_d_ost_sel), .in(ds_d_source[OW-1:0]));
atcsizedn500_bin2onehot #(.N(OST_NUM)) u_us_d_src (.out(us_d_ost_sel), .in(us_d_source));
assign us_d_data     = data_buffer[us_d_source];
assign ds_d_ready    = ~us_d_valid | us_d_ready;
always@(posedge clk)
	if(set_us_d_valid) begin
		us_d_opcode   <= ds_d_opcode;
		us_d_param    <= ds_d_param;
		us_d_user     <= ds_d_user;
		us_d_size     <= ds_d_size;
		us_d_source   <= ds_d_source;
		us_d_sink     <= ds_d_sink;
		us_d_denied   <= ds_d_denied  | (~ds_d_release_ack & pending_d_denied[ds_d_source]);
		us_d_corrupt  <= ds_d_corrupt | (~ds_d_release_ack & pending_d_corrupt[ds_d_source]);
	end
always@(*)
	for(i=0;i<OST_NUM;i=i+1) begin
		us_d2a_beat_last[i] = ~|us_d_beat_cnt[i];
	end

always@(posedge clk or negedge resetn)
	if(~resetn)
		us_d_valid <= 1'b0;
	else
		us_d_valid <= set_us_d_valid | (us_d_valid & ~us_d_ready);

always@(posedge clk or negedge resetn)
	if(~resetn)
		pending_d_denied <= {OST_NUM{1'b0}};
	else
		for(de=0;de<OST_NUM;de=de+1)
		pending_d_denied[de] <= (ds_d_valid & ds_d_ready & ds_d_ost_sel[de] & ds_d_read_data & ds_d_denied & ~set_us_d_valid) | (pending_d_denied[de] & ~(set_us_d_valid & ds_d_read_data & ds_d_ost_sel[de]));

always@(posedge clk or negedge resetn)
	if(~resetn)
		pending_d_corrupt <= {OST_NUM{1'b0}};
	else
		for(co=0;co<OST_NUM;co=co+1)
		pending_d_corrupt[co] <= (ds_d_valid & ds_d_ready & ds_d_ost_sel[co] & ds_d_read_data & ds_d_corrupt & ~set_us_d_valid) | (pending_d_corrupt[co] & ~(set_us_d_valid & ds_d_read_data & ds_d_ost_sel[co]));

assign set_d_resp_middle_a_burst = us_d_valid & us_d_ready & us_d_access_ack &  |(us_d2a_beat_last & us_d_ost_sel) & (current_us_a_source==us_d_source) & ~us_a_beat_begin;
assign clr_d_resp_middle_a_burst = (~|us_a_beat_cnt_nx);

always@(posedge clk or negedge resetn)
	if(~resetn)
		d_resp_middle_a_burst <= 1'b0;
	else
		d_resp_middle_a_burst <= (set_d_resp_middle_a_burst | d_resp_middle_a_burst) & ~clr_d_resp_middle_a_burst;

always@(posedge clk or negedge resetn)
	if(~resetn)
		ch_a_burst_ostding <= {OST_NUM{1'b0}};
	else
		for(l=0;l<OST_NUM;l=l+1)
		ch_a_burst_ostding[l] <= ((us_a_valid & us_a_ready & us_a_ost_sel[l]) | ch_a_burst_ostding[l]) & ~(us_d_valid & us_d_ready & us_d_ost_sel[l] & ~us_d_release_ack & (us_d_grant | us_d2a_beat_last[l])) & ~(current_us_a_ost_sel[l] & d_resp_middle_a_burst);

assign set_d_resp_middle_c_burst = us_d_valid & us_d_ready & us_d_release_ack & (current_us_c_source==us_d_source) & ~us_c_beat_begin;
assign clr_d_resp_middle_c_burst = (~|us_c_beat_cnt_nx);

always@(posedge clk or negedge resetn)
	if(~resetn)
		d_resp_middle_c_burst <= 1'b0;
	else
		d_resp_middle_c_burst <= (set_d_resp_middle_c_burst | d_resp_middle_c_burst) & ~clr_d_resp_middle_c_burst;

always@(posedge clk or negedge resetn)
	if(~resetn)
		ch_c_burst_ostding <= {OST_NUM{1'b0}};
	else
		for(lc=0;lc<OST_NUM;lc=lc+1)
		ch_c_burst_ostding[lc] <= ((us_c_valid & us_c_ready & us_c_ost_sel[lc] & us_c_ostding_cmd) | ch_c_burst_ostding[lc]) & ~(us_d_valid & us_d_ready & us_d_ost_sel[lc] & us_d_release_ack) & ~(current_us_c_ost_sel[lc] & d_resp_middle_c_burst);

 always@(posedge clk or negedge resetn)
        if(~resetn)
                for(mm=0;mm<OST_NUM;mm=mm+1)
               us_d_beat_cnt[mm] <= {US_BEAT_CW{1'b0}};
        else
                for(m=0;m<OST_NUM;m=m+1)
               us_d_beat_cnt[m] <= (us_a_valid & us_a_ready & us_a_ost_sel[m] & us_a_beat_begin) ? ({US_BEAT_CW{us_a_rd_multi_beat_cmd}} & us_a_length[US_BYTE_NUM_LOG2+:US_BEAT_CW]) : (us_d_beat_cnt[m] + {US_BEAT_CW{us_d_valid & us_d_ready & us_d_ost_sel[m] & ~us_d_release_ack & ~us_d2a_beat_last[m]}});


always@(posedge clk)
		for(n=0;n<OST_NUM;n=n+1)
			for(o=0;o<DW_RATIO;o=o+1)
				data_buffer[n][(DS_DW*o)+:DS_DW] <= (ds_d_valid & ds_d_ready & ds_d_ost_sel[n] & d_data_ptr[n][o] & ds_d_read_data) ? ds_d_data : data_buffer[n][(DS_DW*o)+:DS_DW];


assign  ds_e_valid = us_e_valid;
assign  ds_e_sink  = us_e_sink;
assign  ds_e_user  = us_e_user;
assign  us_e_ready = ds_e_ready;

reg                    [2:0] us_b_opcode;
reg                    [2:0] us_b_param;
reg    [B_UW-1:0] us_b_user;
reg      [ZW-1:0] us_b_size;
reg                 [AW-1:0] us_b_address;
reg    		 [OW-1:0] us_b_source;
reg                          us_b_corrupt;
reg                          us_b_valid;
reg [US_DW-1:0] us_b_data;
reg [(US_DW/8)-1:0] us_b_mask;
reg [DS_BEAT_CW-1:0] ds_b_beat_cnt;
wire ds_b_beat_last;

wire ds_b_wr_multi_beat_cmd = (ds_b_opcode==TL_OP_PUTFULL) | (ds_b_opcode==TL_OP_PUTPART) | (ds_b_opcode==TL_OP_LOGICAL) | (ds_b_opcode==TL_OP_ARITHETIC);
wire [MAX_BYTE_SIZE_LOG2-1:0] ds_b_length = ~({MAX_BYTE_SIZE_LOG2{1'b1}} << {{(MAX_BYTE_SIZE_LOG2-ZW){1'b0}},ds_b_size});
wire ds_b_beat_begin = ~|ds_b_beat_cnt;
wire [DS_BEAT_CW-1:0] ds_b_beat_cnt_nx =
					 ds_b_beat_cnt + ({DS_BEAT_CW{ds_b_valid & ds_b_ready}} &
                                                         ({DS_BEAT_CW{~ds_b_beat_begin}} |
                                                         ({DS_BEAT_CW{ds_b_wr_multi_beat_cmd}} & ds_b_length[DS_BYTE_NUM_LOG2+:DS_BEAT_CW])));
always@(posedge clk or negedge resetn)
	if(~resetn)
		ds_b_beat_cnt <= {DS_BEAT_CW{1'b0}};
	else
		ds_b_beat_cnt <= ds_b_beat_cnt_nx;



reg [DW_RATIO_LOG2-1:0] b_data_ptr;
integer bd,mk;
wire ds_b_single_data;
wire [DW_RATIO-1:0] us_b_data_sel;
assign ds_b_single_data =
                          (~|ds_b_length[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2]);
wire [MAX_BYTE_SIZE_LOG2:0] ds_b_len_sqr = {{MAX_BYTE_SIZE_LOG2{1'b0}},1'b1} << {{(MAX_BYTE_SIZE_LOG2-ZW+1){1'b0}},ds_b_size};
wire [(US_DW/8)-1:0] us_b_base_mask   = ~({US_DW/8{1'b1}} << {{(US_DW/8)-US_BYTE_NUM_LOG2{1'b0}},ds_b_len_sqr[US_BYTE_NUM_LOG2-1:0]});
wire [(US_DW/8)-1:0] us_b_single_mask = {US_DW/8{|ds_b_len_sqr[MAX_BYTE_SIZE_LOG2:US_BYTE_NUM_LOG2]}} | (us_b_base_mask << {{(US_DW/8)-US_BYTE_NUM_LOG2{1'b0}},ds_b_address[US_BYTE_NUM_LOG2-1:0]});

wire [DW_RATIO_LOG2-1:0] ds_b_data_ptr = (ds_b_beat_begin) ?  ds_b_address[DS_BYTE_NUM_LOG2+:DW_RATIO_LOG2] : b_data_ptr;
wire [DW_RATIO_LOG2:0] b_data_ptr_inc = {1'b0,ds_b_data_ptr} + {{DW_RATIO_LOG2{1'b0}}, (ds_b_valid & ds_b_ready)};

always@(posedge clk)
		b_data_ptr <=  b_data_ptr_inc[DW_RATIO_LOG2-1:0];

atcsizedn500_bin2onehot #(.N(DW_RATIO)) u_us_b_addr_ptr (.in(ds_b_data_ptr), .out(us_b_data_sel));

always@(posedge clk)
	for(bd=0;bd<DW_RATIO;bd=bd+1)
		us_b_data[(DS_DW*bd)+:DS_DW] <=
						  (ds_b_valid & ds_b_ready & (~us_b_valid | us_b_ready) & us_b_data_sel[bd] & ds_b_wr_multi_beat_cmd) ? ds_b_data :
                                                                                                                                                        us_b_data[(DS_DW*bd)+:DS_DW];

always@(posedge clk or negedge resetn)
	if(~resetn)
		us_b_mask <= {US_DW/8{1'b0}};
	else
		for(mk=0;mk<DW_RATIO;mk=mk+1)
			us_b_mask[((DS_DW/8)*mk)+:(DS_DW/8)] <=
                        (ds_b_valid & ds_b_ready & (~us_b_valid | us_b_ready) & ~ds_b_wr_multi_beat_cmd) ? us_b_single_mask[((DS_DW/8)*mk)+:DS_DW/8]  :
                        (ds_b_valid & ds_b_ready & (~us_b_valid | us_b_ready) & ds_b_single_data) ? ({DS_DW/8{us_b_data_sel[mk]}} & ds_b_mask) :
                        (ds_b_valid & ds_b_ready & (~us_b_valid | us_b_ready) & us_b_data_sel[mk]) ? ds_b_mask  :
                        (ds_b_valid & ds_b_ready & (~us_b_valid | us_b_ready) & ds_b_beat_begin & ~us_b_data_sel[mk]) ? {DS_DW/8{1'b0}}  :
                                                                                                                         us_b_mask[((DS_DW/8)*mk)+:DS_DW/8];

assign ds_b_beat_last = (~|ds_b_beat_cnt_nx[DW_RATIO_LOG2-1:0]);

assign ds_b_ready  	= (~us_b_valid | us_b_ready);


wire set_us_b_valid = ((ds_b_valid & ds_b_ready)) & (~us_b_valid | us_b_ready) & ds_b_beat_last;
always@(posedge clk)
	if(set_us_b_valid) begin
	 us_b_opcode 	<= ds_b_opcode ;
	 us_b_param  	<= ds_b_param  ;
	 us_b_user   	<= ds_b_user   ;
	 us_b_size   	<= ds_b_size   ;
	 us_b_address	<= ds_b_address;
	 us_b_source 	<= ds_b_source ;
	 us_b_corrupt	<= ds_b_corrupt;
	end

always@(posedge clk or negedge resetn)
	if(~resetn)
		us_b_valid <= 1'b0;
	else
		us_b_valid <= set_us_b_valid | (us_b_valid & ~us_b_ready);


endmodule
