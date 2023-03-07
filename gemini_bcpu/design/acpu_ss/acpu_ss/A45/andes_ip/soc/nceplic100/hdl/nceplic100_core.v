// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module nceplic100_core (
		  clk,
		  reset_n,
		  req_valid,
		  req_hit_dep,
		  req_wr,
		  dep_delay_wr,
		  req_addr,
		  req_region_sel,
		  rd_data,
		  wr_data,
		  int_src,
		  t0_eip,
		  t0_eiid,
		  t0_eiack,
		  t1_eip,
		  t1_eiid,
		  t1_eiack,
		  t2_eip,
		  t2_eiid,
		  t2_eiack,
		  t3_eip,
		  t3_eiid,
		  t3_eiack,
		  t4_eip,
		  t4_eiid,
		  t4_eiack,
		  t5_eip,
		  t5_eiid,
		  t5_eiack,
		  t6_eip,
		  t6_eiid,
		  t6_eiack,
		  t7_eip,
		  t7_eiid,
		  t7_eiack,
		  t8_eip,
		  t8_eiid,
		  t8_eiack,
		  t9_eip,
		  t9_eiid,
		  t9_eiack,
		  t10_eip,
		  t10_eiid,
		  t10_eiack,
		  t11_eip,
		  t11_eiid,
		  t11_eiack,
		  t12_eip,
		  t12_eiid,
		  t12_eiack,
		  t13_eip,
		  t13_eiid,
		  t13_eiack,
		  t14_eip,
		  t14_eiid,
		  t14_eiack,
		  t15_eip,
		  t15_eiid,
		  t15_eiack
);
parameter 		INT_NUM				= 63;
parameter 		TARGET_NUM			= 16;
parameter 		MAX_PRIORITY 			= 15;
parameter		PROGRAMMABLE_TRIGGER		= 0;
parameter [1023:0]	EDGE_TRIGGER 			= 1024'b0;
parameter [1023:0]	ASYNC_INT 			= 1024'b0;
parameter 		ADDR_WIDTH 			= 32;
parameter 		VECTOR_PLIC_SUPPORT 		= "no";
parameter 		BIT_REGION_SOURCE_PRIORITY	= 7;
parameter 		BIT_REGION_INTERRUPT_PENDING	= 6;
parameter 		BIT_REGION_TARGET_ENABLE	= 5;
parameter 		BIT_REGION_TARGET_THRESHOLD	= 4;
parameter 		BIT_REGION_PREEMPTIVE_STACK	= 3;
parameter 		BIT_REGION_FEATURE		= 2;
parameter 		BIT_REGION_TRIGGER_TYPE		= 1;
parameter 		BIT_REGION_CONFIG		= 0;
parameter               SYNC_STAGE                      = 2;
localparam		INTERNAL_TARGET_NUM		= TARGET_NUM - 1;
localparam		PLIC_VERSION 			= 1;
localparam 		VALID_MAX_PRIORITY	 	= (MAX_PRIORITY <=   3) ?   3 :
	  						  (MAX_PRIORITY <=   7) ?   7 :
	  						  (MAX_PRIORITY <=  15) ?  15 :
	  						  (MAX_PRIORITY <=  31) ?  31 :
	  						  (MAX_PRIORITY <=  63) ?  63 :
	  						  (MAX_PRIORITY <= 127) ? 127 :
	  								     	  255 ;
localparam		PRIORITY_WIDTH 			= $clog2(VALID_MAX_PRIORITY+1);
localparam		INT_NUM_WIDTH			= (INT_NUM <=   3) ? 2 :
	  						  (INT_NUM <=   7) ? 3 :
	  						  (INT_NUM <=  15) ? 4 :
	  						  (INT_NUM <=  31) ? 5 :
	  						  (INT_NUM <=  63) ? 6 :
	  						  (INT_NUM <= 127) ? 7 :
	  						  (INT_NUM <= 255) ? 8 :
	  						  (INT_NUM <= 511) ? 9 : 10;
localparam		REMAINED_PRIORITY_WIDTH		= 32 - PRIORITY_WIDTH;
localparam		REMAINED_INT_NUM_WIDTH		= 32 - INT_NUM_WIDTH;

input 							clk;
input 							reset_n;
input							req_valid;
input							req_hit_dep;
input							req_wr;
input							dep_delay_wr;
input		[21:2]					req_addr;
input		[7:0]					req_region_sel;
output		[31:0]					rd_data;
input		[31:0]					wr_data;


input 		[INT_NUM:1]				int_src;
output							t0_eip;
output		[9:0]					t0_eiid;
input							t0_eiack;

output							t1_eip;
output		[9:0]					t1_eiid;
input							t1_eiack;

output							t2_eip;
output		[9:0]					t2_eiid;
input							t2_eiack;

output							t3_eip;
output		[9:0]					t3_eiid;
input							t3_eiack;

output							t4_eip;
output		[9:0]					t4_eiid;
input							t4_eiack;

output							t5_eip;
output		[9:0]					t5_eiid;
input							t5_eiack;

output							t6_eip;
output		[9:0]					t6_eiid;
input							t6_eiack;

output							t7_eip;
output		[9:0]					t7_eiid;
input							t7_eiack;

output							t8_eip;
output		[9:0]					t8_eiid;
input							t8_eiack;

output							t9_eip;
output		[9:0]					t9_eiid;
input							t9_eiack;

output							t10_eip;
output		[9:0]					t10_eiid;
input							t10_eiack;

output							t11_eip;
output		[9:0]					t11_eiid;
input							t11_eiack;

output							t12_eip;
output		[9:0]					t12_eiid;
input							t12_eiack;

output							t13_eip;
output		[9:0]					t13_eiid;
input							t13_eiack;

output							t14_eip;
output		[9:0]					t14_eiid;
input							t14_eiack;

output							t15_eip;
output		[9:0]					t15_eiid;
input							t15_eiack;




wire	[15:0]					external_interrupt_pending;
reg	[(TARGET_NUM-1):0]			external_interrupt_pending_reg;
wire	[(TARGET_NUM-1):0]			external_interrupt_pending_reg_nx;
wire	[15:0]					eip;
reg	[(PRIORITY_WIDTH-1):0]			read_source_priority_level1_l[0:15];
reg	[(PRIORITY_WIDTH-1):0]			read_source_priority_level1_h[0:15];
reg	[(PRIORITY_WIDTH-1):0]			read_source_priority_level1[0:15];
reg	[(PRIORITY_WIDTH-1):0]			read_source_priority_level2;
reg	[31:0]					read_interrupt_pending;
reg	[(PRIORITY_WIDTH-1):0]			read_target_threshold;
reg	[(PRIORITY_WIDTH-1):0]			read_arb_max_priority;
reg	[1023:0]				read_target_enable;
reg	[31:0]					read_target_enable_word;
reg	[(INT_NUM_WIDTH-1):0]			target_claim_id;

assign	eip = external_interrupt_pending;
assign  t0_eip = eip[0];
assign  t1_eip = eip[1];
assign  t2_eip = eip[2];
assign  t3_eip = eip[3];
assign  t4_eip = eip[4];
assign  t5_eip = eip[5];
assign  t6_eip = eip[6];
assign  t7_eip = eip[7];
assign  t8_eip = eip[8];
assign  t9_eip = eip[9];
assign  t10_eip = eip[10];
assign  t11_eip = eip[11];
assign  t12_eip = eip[12];
assign  t13_eip = eip[13];
assign  t14_eip = eip[14];
assign  t15_eip = eip[15];

wire	hit_source_priority 		= req_region_sel[BIT_REGION_SOURCE_PRIORITY  ];
wire	hit_pending			= req_region_sel[BIT_REGION_INTERRUPT_PENDING];
wire	hit_target_enable_region	= req_region_sel[BIT_REGION_TARGET_ENABLE    ];
wire	hit_target_threshold 		= req_region_sel[BIT_REGION_TARGET_THRESHOLD ];
wire	hit_preempted_priority_stack 	= req_region_sel[BIT_REGION_PREEMPTIVE_STACK ];
wire	hit_feature_reg			= req_region_sel[BIT_REGION_FEATURE	     ];
wire	hit_trigger_type		= req_region_sel[BIT_REGION_TRIGGER_TYPE     ];
wire	hit_dependency			= req_hit_dep;
wire	write_req = req_valid & req_wr;
wire	read_req = req_valid & ~req_wr;

wire	dependency_delay_write;





wire	[(PRIORITY_WIDTH-1):0]		source_priority[0:1023];
reg	[(PRIORITY_WIDTH-1):0]		source_priority_reg[0:INT_NUM];
wire	[(PRIORITY_WIDTH-1):0]		source_priority_req[0:1023];
wire	[INT_NUM:1]			source_priority_write;
wire	[1023:0]			interrupt_pending;
reg	[INT_NUM:1]			interrupt_pending_reg;
wire	[INT_NUM:1]			interrupt_pending_reg_bit_wr;
wire	[31:0]				interrupt_pending_reg_word_wr;
wire	[9:0]				source_id[0:1023];

wire	[(PRIORITY_WIDTH-1):0]		target_threshold[0:15];
reg	[(PRIORITY_WIDTH-1):0]		target_threshold_reg[0:(TARGET_NUM-1)];
wire	[1023:0]			target_enable[0:15];
wire	[15:0]				target_threshold_write;
wire	[(TARGET_NUM-1):0]		target_enable_write;
wire	[31:0]				target_enable_word_write;
wire	[(TARGET_NUM-1):0]		target_claim;
wire	[(TARGET_NUM-1):0]		target_ahb_claim;
wire	[(TARGET_NUM-1):0]		target_vector_claim;
wire	[(TARGET_NUM-1):0]		target_complete;
wire	[255:0]				target_preempted_priority_stack[0:15];
reg	[255:0]				preempted_priority_stack_mux_out;
reg	[VALID_MAX_PRIORITY:0]		target_preempted_priority_stack_reg[0:(TARGET_NUM-1)];
wire	[VALID_MAX_PRIORITY:0]		target_preempted_priority_stack_bit_write[0:(TARGET_NUM-1)];
wire	[7:0]				target_preempted_priority_stack_word_write;
wire	[VALID_MAX_PRIORITY:0]		target_preempted_priority_stack_bit_claim_set[0:(TARGET_NUM-1)];
wire	[VALID_MAX_PRIORITY:0]		target_preempted_priority_stack_bit_complete_clear[0:(TARGET_NUM-1)];
wire	[(PRIORITY_WIDTH-1):0]		stack_highest_priority[0:(TARGET_NUM-1)];
wire	[(TARGET_NUM-1):0]		stack_highest_priority_valid;
reg	[31:0]				target_threshold_region_mux_out;
reg					preempted_priority_stack_en;
wire					vector_mode_en;
reg	[31:0]				trigger_type_mux_out;
reg	[31:0]				read_preempted_priority_stack;
reg	[INT_NUM:1]			int_src_d1;
reg	[(TARGET_NUM-1):0]		arbitration_en_d1;
reg	[(TARGET_NUM-1):0]		vector_mode_claim_clear_d1;
wire	[INT_NUM:1]			int_src_sync_out;
wire	[INT_NUM:1]			int_src_edge_out;
wire	[1023:0]			interrupt_trigger_type;
reg	[INT_NUM:1]			interrupt_trigger_type_reg;
wire	[INT_NUM:1]			interrupt_trigger_type_reg_bit_wr;
wire	[31:0]				interrupt_trigger_type_reg_word_wr;

reg	[INT_NUM:1]			gateway_interrupt_inflight;
wire	[INT_NUM:1]			gateway_valid;
wire	[INT_NUM:1]			gateway_ready;
wire	[INT_NUM:1]			gateway_complete;
wire	[INT_NUM:1]			interrupt_claim;
wire	[INT_NUM:1]			interrupt_ahb_claim;
wire	[INT_NUM:1]			interrupt_vector_claim;
wire	[(TARGET_NUM-1):0]		interrupt_vector_claim_target_array[0:INT_NUM];

wire	[15:0]				eiack;
wire	[(TARGET_NUM-1):0]		eiack_to_plic;
wire	[(TARGET_NUM-1):0]		eiack_to_plic_pulse;
wire	[(TARGET_NUM-1):0]		arbitration_en;
wire	[(TARGET_NUM-1):0]		vector_mode_claim_clear;
wire	[(TARGET_NUM-1):0]		modify_setting_clear_max_pri;

wire	[(INT_NUM_WIDTH-1):0]		max_id[0:15];
reg	[(INT_NUM_WIDTH-1):0]		max_id_reg[0:(TARGET_NUM-1)];
wire	[(INT_NUM_WIDTH-1):0]		max_id_nx[0:(TARGET_NUM-1)];
wire	[(PRIORITY_WIDTH-1):0]		max_priority[0:15];
reg	[(PRIORITY_WIDTH-1):0]		max_priority_reg[0:(TARGET_NUM-1)];
wire	[(PRIORITY_WIDTH-1):0]		max_priority_nx[0:(TARGET_NUM-1)];

wire	[(PRIORITY_WIDTH-1):0]		enabled_source_priority[0:(TARGET_NUM-1)][0:1023];

wire					int_arb_2_lhs_bigger[0:(TARGET_NUM-1)][0:511];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_2_id[0:(TARGET_NUM-1)][0:511];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_2_priority[0:(TARGET_NUM-1)][0:511];

wire					int_arb_4_lhs_bigger[0:(TARGET_NUM-1)][0:255];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_4_id[0:(TARGET_NUM-1)][0:255];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_4_priority[0:(TARGET_NUM-1)][0:255];

wire					int_arb_8_lhs_bigger[0:(TARGET_NUM-1)][0:127];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_8_id[0:(TARGET_NUM-1)][0:127];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_8_priority[0:(TARGET_NUM-1)][0:127];

wire					int_arb_16_lhs_bigger[0:(TARGET_NUM-1)][0:63];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_16_id[0:(TARGET_NUM-1)][0:63];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_16_priority[0:(TARGET_NUM-1)][0:63];

wire					int_arb_32_lhs_bigger[0:(TARGET_NUM-1)][0:31];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_32_id[0:(TARGET_NUM-1)][0:31];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_32_priority[0:(TARGET_NUM-1)][0:31];

wire					int_arb_64_lhs_bigger[0:(TARGET_NUM-1)][0:15];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_64_id[0:(TARGET_NUM-1)][0:15];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_64_priority[0:(TARGET_NUM-1)][0:15];

wire					int_arb_128_lhs_bigger[0:(TARGET_NUM-1)][0:7];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_128_id[0:(TARGET_NUM-1)][0:7];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_128_priority[0:(TARGET_NUM-1)][0:7];

wire					int_arb_256_lhs_bigger[0:(TARGET_NUM-1)][0:3];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_256_id[0:(TARGET_NUM-1)][0:3];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_256_priority[0:(TARGET_NUM-1)][0:3];

wire					int_arb_512_lhs_bigger[0:(TARGET_NUM-1)][0:1];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_512_id[0:(TARGET_NUM-1)][0:1];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_512_priority[0:(TARGET_NUM-1)][0:1];

wire					int_arb_1024_lhs_bigger[0:(TARGET_NUM-1)];
wire	[(INT_NUM_WIDTH-1):0]		int_arb_1024_id[0:(TARGET_NUM-1)];
wire	[(PRIORITY_WIDTH-1):0]		int_arb_1024_priority[0:(TARGET_NUM-1)];

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		arbitration_en_d1	   <= {TARGET_NUM{1'b0}};
		vector_mode_claim_clear_d1 <= {TARGET_NUM{1'b0}};
	end
	else begin
		arbitration_en_d1	   <= arbitration_en;
		vector_mode_claim_clear_d1 <= vector_mode_claim_clear;
	end
end

generate
if (INT_NUM > 511) begin: gen_int_vector_need_10b
	assign t0_eiid 	= {10{vector_mode_en}} & max_id[0];
	assign t1_eiid 	= {10{vector_mode_en}} & max_id[1];
	assign t2_eiid 	= {10{vector_mode_en}} & max_id[2];
	assign t3_eiid 	= {10{vector_mode_en}} & max_id[3];
	assign t4_eiid 	= {10{vector_mode_en}} & max_id[4];
	assign t5_eiid 	= {10{vector_mode_en}} & max_id[5];
	assign t6_eiid 	= {10{vector_mode_en}} & max_id[6];
	assign t7_eiid 	= {10{vector_mode_en}} & max_id[7];
	assign t8_eiid 	= {10{vector_mode_en}} & max_id[8];
	assign t9_eiid 	= {10{vector_mode_en}} & max_id[9];
	assign t10_eiid = {10{vector_mode_en}} & max_id[10];
	assign t11_eiid = {10{vector_mode_en}} & max_id[11];
	assign t12_eiid = {10{vector_mode_en}} & max_id[12];
	assign t13_eiid = {10{vector_mode_en}} & max_id[13];
	assign t14_eiid = {10{vector_mode_en}} & max_id[14];
	assign t15_eiid = {10{vector_mode_en}} & max_id[15];
end
else begin: gen_int_vector_less_than_10b
	assign t0_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[0] };
	assign t1_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[1] };
	assign t2_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[2] };
	assign t3_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[3] };
	assign t4_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[4] };
	assign t5_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[5] };
	assign t6_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[6] };
	assign t7_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[7] };
	assign t8_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[8] };
	assign t9_eiid  = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[9] };
	assign t10_eiid = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[10]};
	assign t11_eiid = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[11]};
	assign t12_eiid = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[12]};
	assign t13_eiid = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[13]};
	assign t14_eiid = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[14]};
	assign t15_eiid = {10{vector_mode_en}} & {{(10-INT_NUM_WIDTH){1'b0}},max_id[15]};
end
endgenerate
assign eiack = {t15_eiack, t14_eiack, t13_eiack, t12_eiack,
		t11_eiack, t10_eiack,  t9_eiack,  t8_eiack,
		 t7_eiack,  t6_eiack,  t5_eiack,  t4_eiack,
		 t3_eiack,  t2_eiack,  t1_eiack,  t0_eiack
		 };

wire	real_claim    = vector_mode_en ? 1'b1 : (read_arb_max_priority > read_target_threshold);

assign  target_vector_claim = {(TARGET_NUM){vector_mode_en}} & eiack_to_plic_pulse;

assign dependency_delay_write 	= dep_delay_wr;

generate
genvar ack_num;
for (ack_num = 0; ack_num < TARGET_NUM; ack_num = ack_num + 1) begin : gen_sync_eiack_block
        nds_sync_l2l #(
                .RESET_VALUE    (1'b0      ),
                .SYNC_STAGE     (SYNC_STAGE)
        ) plic_sync(
		.b_reset_n			(reset_n			),
		.b_clk				(clk				),
		.a_signal			(eiack[ack_num]			),
		.b_signal			(eiack_to_plic[ack_num]		),
		.b_signal_rising_edge_pulse	(eiack_to_plic_pulse[ack_num]	),
		.b_signal_falling_edge_pulse	( 			),
		.b_signal_edge_pulse		( 			)
	);
end
endgenerate

generate
genvar g;
for (g = 1; g <= INT_NUM; g = g + 1 ) begin : gen_int_src_synchronizer
	if (ASYNC_INT[g] == 1'd1) begin : gen_async_int
		nds_sync_l2l #(
                        .RESET_VALUE    (1'b0      ),
                        .SYNC_STAGE     (SYNC_STAGE)
                ) int_src_sync(
			.b_reset_n			(reset_n		),
			.b_clk				(clk			),
			.a_signal			(int_src[g]		),
			.b_signal			(int_src_sync_out[g]	),
			.b_signal_rising_edge_pulse	( 		),
			.b_signal_falling_edge_pulse	( 		),
			.b_signal_edge_pulse		( 		)
		);
	end
	else begin : gen_sync_int
		assign int_src_sync_out[g] = int_src[g];
	end
end
endgenerate


always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		int_src_d1 <= {(INT_NUM){1'b0}};
	else
		int_src_d1 <= int_src_sync_out;
end

generate
genvar i;
for (i = 1; i <= INT_NUM; i = i + 1 ) begin : gen_edge_transfer
	if (PROGRAMMABLE_TRIGGER) begin : gen_programable_trigger_int
		assign int_src_edge_out[i] = interrupt_trigger_type[i] ? int_src_sync_out[i] & ~int_src_d1[i] : int_src_sync_out[i];
	end
	else if (EDGE_TRIGGER[i] == 1'b1) begin : gen_edge_trigger_int
		assign int_src_edge_out[i] = int_src_sync_out[i] & ~int_src_d1[i];
	end
	else begin : gen_level_trigger_int
		assign int_src_edge_out[i] = int_src_sync_out[i];
	end
end
endgenerate

generate
genvar j;
genvar k;
for (j = 0; j <= INT_NUM; j = j + 1) begin : gen_vector_int_claim_src
	for (k = 0 ; k < TARGET_NUM ; k = k + 1) begin : gen_vector_int_claim_target
		if (j == 0) begin : gen_unused_interrupt_vector_claim_target_array
			assign interrupt_vector_claim_target_array[j][k] = 1'b0;
		end
		else begin : gen_used_interrupt_vector_claim_target_array
			wire [INT_NUM_WIDTH-1:0] i_vec_src = j[INT_NUM_WIDTH-1:0];
			assign interrupt_vector_claim_target_array[j][k] = target_vector_claim[k] & (max_id[k] == i_vec_src);
		end
	end
end
endgenerate


generate
genvar l;
genvar m;
for (l = 0; l < 32; l = l + 1) begin : gen_source_block_1
	for (m = l*32; m < (l+1)*32; m = m + 1) begin : gen_source_block_2
		wire [9:0] src_num = m[9:0];
		if (m == 0) begin : gen_unused_source_block_0
			assign  interrupt_pending[m] = 1'b0;
			assign  source_priority[m] = {(PRIORITY_WIDTH){1'b0}};
			assign  source_priority_req[m] = {(PRIORITY_WIDTH){1'b0}};
			assign  source_id[m] = src_num;
			assign  interrupt_trigger_type[m] = 1'b0;
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					source_priority_reg[m] <= {{(PRIORITY_WIDTH-1){1'b0}},1'b1};
				else
					source_priority_reg[m] <= {(PRIORITY_WIDTH){1'b0}};
			end
			wire unused_wire = |source_priority_reg[m];
		end
		else if (m > INT_NUM) begin : gen_unused_source_block_bigger_than_int_num
			assign  interrupt_pending[m] = 1'b0;
			assign  source_priority[m] = {(PRIORITY_WIDTH){1'b0}};
			assign  source_priority_req[m] = {(PRIORITY_WIDTH){1'b0}};
			assign  source_id[m] = src_num;
			assign  interrupt_trigger_type[m] = 1'b0;
		end
		else begin : gen_used_source_block
			assign  source_id[m] = src_num;
			assign 	interrupt_pending[m] 		= interrupt_pending_reg[m];
			assign 	source_priority[m] 		= source_priority_reg[m];
			assign	gateway_ready[m] 		= ~interrupt_pending_reg[m];
			assign	gateway_valid[m]		= int_src_edge_out[m] & ~gateway_interrupt_inflight[m];
			assign	gateway_complete[m] 		= hit_target_threshold & write_req & (req_addr[3:2] == 2'h1) & (wr_data[9:0] == src_num);
			assign 	source_priority_req[m] 		= {(PRIORITY_WIDTH){interrupt_pending[m]}} & source_priority[m];
			assign	interrupt_ahb_claim[m]     	= hit_target_threshold  & (req_addr[5:2] == 4'h1) & (target_claim_id == src_num[INT_NUM_WIDTH-1:0]) & read_req & real_claim;
			assign	interrupt_vector_claim[m]     	= |interrupt_vector_claim_target_array[m];
			assign	interrupt_claim[m]     		= interrupt_ahb_claim[m] | interrupt_vector_claim[m];
			assign  interrupt_pending_reg_bit_wr[m]	= hit_pending & write_req & interrupt_pending_reg_word_wr[m/32] & wr_data[m % 32];
			assign  interrupt_trigger_type_reg_bit_wr[m] = hit_trigger_type & write_req & interrupt_trigger_type_reg_word_wr[m/32];

			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					interrupt_pending_reg[m] <= 1'b0;
				else if (interrupt_claim[m])
					interrupt_pending_reg[m] <= 1'b0;
				else if (gateway_valid[m] && gateway_ready[m])
					interrupt_pending_reg[m] <= 1'b1;
				else if (interrupt_pending_reg_bit_wr[m])
					interrupt_pending_reg[m] <= wr_data[m % 32];
			end
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					gateway_interrupt_inflight[m] <= 1'b0;
				else if (gateway_complete[m])
					gateway_interrupt_inflight[m] <= 1'b0;
				else if (int_src_edge_out[m] && gateway_ready[m])
					gateway_interrupt_inflight[m] <= 1'b1;
			end
			assign	source_priority_write[m] = hit_source_priority & write_req & (req_addr[11:2] == src_num);
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					source_priority_reg[m] <= {{(PRIORITY_WIDTH-1){1'b0}},1'b1};
				else if (source_priority_write[m])
					source_priority_reg[m] <= wr_data[(PRIORITY_WIDTH-1):0];
			end
			assign  interrupt_trigger_type[m] = interrupt_trigger_type_reg[m];
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					interrupt_trigger_type_reg[m] <= EDGE_TRIGGER[m];
				else if (interrupt_trigger_type_reg_bit_wr[m])
					interrupt_trigger_type_reg[m] <= wr_data[m % 32];
			end
		end
	end
end
endgenerate

generate
genvar n;
for (n = 0; n < 32; n = n + 1) begin : gen_interrupt_pending_reg_word_wr
	wire [4:0] k_src = n[4:0];
	assign interrupt_pending_reg_word_wr[n] = (req_addr[6:2] == k_src);
	assign interrupt_trigger_type_reg_word_wr[n] = (req_addr[6:2] == k_src);
end
endgenerate

assign target_preempted_priority_stack_word_write[7] = (req_addr[4:2] == 3'h7);
assign target_preempted_priority_stack_word_write[6] = (req_addr[4:2] == 3'h6);
assign target_preempted_priority_stack_word_write[5] = (req_addr[4:2] == 3'h5);
assign target_preempted_priority_stack_word_write[4] = (req_addr[4:2] == 3'h4);
assign target_preempted_priority_stack_word_write[3] = (req_addr[4:2] == 3'h3);
assign target_preempted_priority_stack_word_write[2] = (req_addr[4:2] == 3'h2);
assign target_preempted_priority_stack_word_write[1] = (req_addr[4:2] == 3'h1);
assign target_preempted_priority_stack_word_write[0] = (req_addr[4:2] == 3'h0);


generate
genvar p1;
genvar p2;
genvar p3;
genvar p4;
genvar p5;
for (p2 = TARGET_NUM; p2 < 16; p2 = p2 + 1) begin : gen_unused_target_block
	assign target_threshold[p2] = {(PRIORITY_WIDTH){1'b0}};
	assign target_enable[p2] = 1024'b0;
	assign target_preempted_priority_stack[p2] = 256'b0;
	assign target_threshold_write[p2] = 1'b0;
end
endgenerate
generate
for (p1 = 0; p1 < TARGET_NUM; p1 = p1 + 1) begin : gen_used_target_block
	wire [3:0] i_target = p1[3:0];
	assign target_threshold_write[p1] =  hit_target_threshold & write_req & (req_addr[15:12] == i_target) & (req_addr[5:2] == 4'h0) ;
	assign target_claim[p1] = preempted_priority_stack_en & (target_ahb_claim[p1] | target_vector_claim[p1]);
	assign target_ahb_claim[p1] = hit_target_threshold & (req_addr[5:2] == 4'h1) & read_req & (req_addr[15:12] == i_target) & eip[p1] & real_claim;
	assign target_complete[p1] = stack_highest_priority_valid[p1] & preempted_priority_stack_en & hit_target_threshold & ((write_req & ~hit_dependency) | dependency_delay_write) & (req_addr[5:2] == 4'h1) & (req_addr[15:12] == i_target);
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			target_threshold_reg[p1] <= {(PRIORITY_WIDTH){1'b0}};
		else if (target_claim[p1])
			target_threshold_reg[p1] <= max_priority_reg[p1];
		else if (target_complete[p1])
			target_threshold_reg[p1] <= stack_highest_priority[p1];
		else if (target_threshold_write[p1])
			target_threshold_reg[p1] <= wr_data[(PRIORITY_WIDTH-1):0];
	end
	assign target_threshold[p1] = target_threshold_reg[p1];
	assign target_enable_write[p1] = write_req & hit_target_enable_region & (req_addr[10:7] == i_target);
	assign target_enable[p1][0] = 1'b0;
	for (p3 = 1; p3 < 512; p3 = p3 + 1) begin : gen_target_enable_bit1
		if (p3 > INT_NUM) begin : gen_unused_te1
			assign target_enable[p1][p3] = 1'b0;
		end
		else begin : gen_used_te1
			reg	reg_target_enable;
			wire	target_enable_bit_write;
			assign target_enable_bit_write = target_enable_write[p1] & target_enable_word_write[p3/32];
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					reg_target_enable <= 1'b0;
				else if (target_enable_bit_write)
					reg_target_enable <= wr_data[p3 % 32];
			end
			assign target_enable[p1][p3] = reg_target_enable;
		end
	end
	for (p4 = 512; p4 < 1024; p4 = p4 + 1) begin : gen_target_enable_bit2
		if (p4 > INT_NUM) begin : gen_unused_te2
			assign target_enable[p1][p4] = 1'b0;
		end
		else begin : gen_used_te2
			reg	reg_target_enable;
			wire	target_enable_bit_write;
			assign target_enable_bit_write = target_enable_write[p1] & target_enable_word_write[p4/32];
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					reg_target_enable <= 1'b0;
				else if (target_enable_bit_write)
					reg_target_enable <= wr_data[p4 % 32];
			end
			assign target_enable[p1][p4] = reg_target_enable;
		end
	end
	for (p5 = 0; p5 < 256; p5 = p5 + 1) begin : gen_preempted_priority_stack_bit
		if (p5 > VALID_MAX_PRIORITY) begin : gen_unused_pstack
			assign target_preempted_priority_stack[p1][p5] = 1'b0;
		end
		else begin : gen_used_pstack
			wire [7:0] i_stk_bit = p5[7:0];
			assign target_preempted_priority_stack[p1][p5] = target_preempted_priority_stack_reg[p1][p5];
			assign target_preempted_priority_stack_bit_claim_set[p1][p5] = preempted_priority_stack_en & (target_ahb_claim[p1] | target_vector_claim[p1]) & (target_threshold[p1] == i_stk_bit[(PRIORITY_WIDTH-1):0]);
			assign target_preempted_priority_stack_bit_complete_clear[p1][p5] =  target_complete[p1] & (stack_highest_priority[p1] == i_stk_bit[(PRIORITY_WIDTH-1):0]) ;
			assign target_preempted_priority_stack_bit_write[p1][p5] =  hit_preempted_priority_stack & write_req & (req_addr[15:12] == i_target) & target_preempted_priority_stack_word_write[p5/32];
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n)
					target_preempted_priority_stack_reg[p1][p5] <= 1'b0;
				else if (target_preempted_priority_stack_bit_claim_set[p1][p5])
					target_preempted_priority_stack_reg[p1][p5] <= 1'b1;
				else if (target_preempted_priority_stack_bit_complete_clear[p1][p5])
					target_preempted_priority_stack_reg[p1][p5] <= 1'b0;
				else if (target_preempted_priority_stack_bit_write[p1][p5])
					target_preempted_priority_stack_reg[p1][p5] <= wr_data[p5 % 32];
			end
		end
	end
end
endgenerate

generate
genvar q;
for (q = 0; q < 32 ; q = q + 1) begin : gen_target_enable_word_write
	wire [4:0] j_target = q[4:0];
	assign target_enable_word_write[q] = (req_addr[6:2] == j_target);
end
endgenerate



generate
genvar r1;
genvar r2;
for (r1 = 0; r1 < TARGET_NUM; r1 = r1 + 1) begin : gen_find_stack_msb_per_target
	wire	[1:0]	stack_msb_4_p[0:7];
	wire		stack_msb_4_v[0:7];
	wire	[2:0]	stack_msb_8_p[0:3];
	wire		stack_msb_8_v[0:3];
	wire	[3:0]	stack_msb_16_p[0:1];
	wire		stack_msb_16_v[0:1];
	wire	[4:0]	stack_msb_32_p;
	wire		stack_msb_32_v;
	wire	[31:0]	lzu_in;
	wire	[2:0] 	lzu_stage1_p_reg_nx;
	reg	[2:0] 	lzu_stage1_p_reg;
	wire	[7:0]	lzu_stack_word_summary;
	wire	[31:0]	most_signif_word_nx;
	reg	[31:0]	most_signif_word;
	assign lzu_stage1_p_reg_nx =
			({3{lzu_stack_word_summary[7:1]==7'b1}} & 3'b001) |
			({3{lzu_stack_word_summary[7:2]==6'b1}} & 3'b010) |
			({3{lzu_stack_word_summary[7:3]==5'b1}} & 3'b011) |
			({3{lzu_stack_word_summary[7:4]==4'b1}} & 3'b100) |
			({3{lzu_stack_word_summary[7:5]==3'b1}} & 3'b101) |
			({3{lzu_stack_word_summary[7:6]==2'b1}} & 3'b110) |
			({3{lzu_stack_word_summary[7  ]==1'b1}} & 3'b111) ;

	assign most_signif_word_nx =
			({32{lzu_stack_word_summary[7:0]==8'b1}} & target_preempted_priority_stack[r1][ 31:  0]) |
			({32{lzu_stack_word_summary[7:1]==7'b1}} & target_preempted_priority_stack[r1][ 63: 32]) |
			({32{lzu_stack_word_summary[7:2]==6'b1}} & target_preempted_priority_stack[r1][ 95: 64]) |
			({32{lzu_stack_word_summary[7:3]==5'b1}} & target_preempted_priority_stack[r1][127: 96]) |
			({32{lzu_stack_word_summary[7:4]==4'b1}} & target_preempted_priority_stack[r1][159:128]) |
			({32{lzu_stack_word_summary[7:5]==3'b1}} & target_preempted_priority_stack[r1][191:160]) |
			({32{lzu_stack_word_summary[7:6]==2'b1}} & target_preempted_priority_stack[r1][223:192]) |
			({32{lzu_stack_word_summary[7  ]==1'b1}} & target_preempted_priority_stack[r1][255:224]) ;

	always @(posedge clk or negedge reset_n) begin : gen_lzu_flops
		if (!reset_n) begin
			lzu_stage1_p_reg <= 3'b0;
			most_signif_word <= 32'b0;
		end
		else begin
			lzu_stage1_p_reg <= lzu_stage1_p_reg_nx;
			most_signif_word <= most_signif_word_nx;
		end
	end

	assign lzu_stack_word_summary[0] = |target_preempted_priority_stack[r1][31:0];
	assign lzu_stack_word_summary[1] = |target_preempted_priority_stack[r1][63:32];
	assign lzu_stack_word_summary[2] = |target_preempted_priority_stack[r1][95:64];
	assign lzu_stack_word_summary[3] = |target_preempted_priority_stack[r1][127:96];
	assign lzu_stack_word_summary[4] = |target_preempted_priority_stack[r1][159:128];
	assign lzu_stack_word_summary[5] = |target_preempted_priority_stack[r1][191:160];
	assign lzu_stack_word_summary[6] = |target_preempted_priority_stack[r1][223:192];
	assign lzu_stack_word_summary[7] = |target_preempted_priority_stack[r1][255:224];
	if (VALID_MAX_PRIORITY <= 31) begin : gen_lzu_input_max_pri_smaller_than_31
		assign lzu_in = target_preempted_priority_stack[r1][31:0];
	end
	else begin : gen_lzu_input_max_pri_bigger_than_31
		assign lzu_in = most_signif_word;
	end
	for (r2 = 0; r2 < 8; r2 = r2 + 1) begin : gen_sub_element
		assign stack_msb_4_p[r2][1] 	= lzu_in[r2*4+3]
								| lzu_in[r2*4+2];
		assign stack_msb_4_p[r2][0] 	= lzu_in[r2*4+3]
								| (~lzu_in[r2*4+2] & lzu_in[r2*4+1]);
		assign stack_msb_4_v[r2]	= |lzu_in[r2*4+3:r2*4];
		if (r2 % 2 == 0) begin : gen_stack_sub_element_2
			assign stack_msb_8_p[r2/2]	= stack_msb_4_v[r2/1+1] ? {1'b1,stack_msb_4_p[r2/1+1]} : {1'b0,stack_msb_4_p[r2/1]};
			assign stack_msb_8_v[r2/2]	= stack_msb_4_v[r2/1+1] | stack_msb_4_v[r2/1];
		end
		if (r2 % 4 == 0) begin : gen_stack_sub_element_4
			assign stack_msb_16_p[r2/4]	= stack_msb_8_v[r2/2+1] ? {1'b1,stack_msb_8_p[r2/2+1]} : {1'b0,stack_msb_8_p[r2/2]};
			assign stack_msb_16_v[r2/4]	= stack_msb_8_v[r2/2+1] | stack_msb_8_v[r2/2];
		end
	end
	assign stack_msb_32_p	= stack_msb_16_v[1] ? {1'b1,stack_msb_16_p[1]} : {1'b0,stack_msb_16_p[0]};
	assign stack_msb_32_v	= stack_msb_16_v[1] | stack_msb_16_v[0];
	if (VALID_MAX_PRIORITY == 3) begin : gen_stack_v_p_3
		assign stack_highest_priority_valid[r1] 	= stack_msb_4_v[0];
		assign stack_highest_priority[r1] 	= stack_msb_4_p[0];
	end
	else if (VALID_MAX_PRIORITY == 7) begin : gen_stack_v_p_7
		assign stack_highest_priority_valid[r1] 	= stack_msb_8_v[0];
		assign stack_highest_priority[r1] 	= stack_msb_8_p[0];
	end
	else if (VALID_MAX_PRIORITY == 15) begin : gen_stack_v_p_15
		assign stack_highest_priority_valid[r1] 	= stack_msb_16_v[0];
		assign stack_highest_priority[r1] 	= stack_msb_16_p[0];
	end
	else if (VALID_MAX_PRIORITY == 31) begin : gen_stack_v_p_31
		assign stack_highest_priority_valid[r1] 	= stack_msb_32_v;
		assign stack_highest_priority[r1] 	= stack_msb_32_p;
	end
	else if (VALID_MAX_PRIORITY == 63) begin : gen_stack_v_p_63
		assign stack_highest_priority_valid[r1] 	= stack_msb_32_v;
		assign stack_highest_priority[r1] 	= {lzu_stage1_p_reg[0],stack_msb_32_p};
	end
	else if (VALID_MAX_PRIORITY == 127) begin : gen_stack_v_p_127
		assign stack_highest_priority_valid[r1] 	= stack_msb_32_v;
		assign stack_highest_priority[r1] 	= {lzu_stage1_p_reg[1:0],stack_msb_32_p};
	end
	else begin : gen_stack_v_p_255
		assign stack_highest_priority_valid[r1] 	= stack_msb_32_v;
		assign stack_highest_priority[r1] 	= {lzu_stage1_p_reg[2:0],stack_msb_32_p};
	end
end
endgenerate

reg [(PRIORITY_WIDTH-1):0]	int_arb_32_priority_reg [0:(TARGET_NUM-1)][0:31];
reg [(INT_NUM_WIDTH-1):0]	int_arb_32_id_reg [0:(TARGET_NUM-1)][0:31];
generate
genvar s2;
genvar s4;
genvar s8;
genvar s16;
genvar s32;
genvar s64;
genvar s128;
genvar s256;
genvar s512;
genvar t1;
genvar t2;
genvar u;
for (u = 0; u < 16; u = u + 1) begin	: gen_arb_block
	if (u > INTERNAL_TARGET_NUM) begin : gen_unuded_target_arb
		assign max_id[u] = {(INT_NUM_WIDTH){1'b0}};
		assign max_priority[u] = {(PRIORITY_WIDTH){1'b0}};
		assign external_interrupt_pending[u] = 1'b0;
	end
	else begin : gen_used_target_arb
		for (t1 = 0; t1 < 512; t1 = t1 + 1) begin  : gen_arb_source_priority_with_enable1
			assign enabled_source_priority[u][t1] = {(PRIORITY_WIDTH){target_enable[u][t1]}} & source_priority_req[t1];
		end
		for (t2 = 512; t2 < 1024; t2 = t2 + 1) begin  : gen_arb_source_priority_with_enable2
			assign enabled_source_priority[u][t2] = {(PRIORITY_WIDTH){target_enable[u][t2]}} & source_priority_req[t2];
		end
		for (s2 = 0; s2 < 512; s2 = s2 + 1) begin : gen_arb_element_radix2
			assign int_arb_2_lhs_bigger[u][s2] 	= enabled_source_priority[u][s2*2+1] >  enabled_source_priority[u][s2*2];
			assign int_arb_2_priority[u][s2] 	= int_arb_2_lhs_bigger[u][s2]  ?  enabled_source_priority[u][s2*2+1] :  enabled_source_priority[u][s2*2];
			assign int_arb_2_id[u][s2] 		= int_arb_2_lhs_bigger[u][s2]  ?  source_id[s2*2+1][INT_NUM_WIDTH-1:0] : source_id[s2*2][INT_NUM_WIDTH-1:0];
		end
		for (s4 = 0; s4 < 256; s4 = s4 + 1) begin  : gen_arb_element_radix4
			assign int_arb_4_lhs_bigger[u][s4] 	= int_arb_2_priority[u][s4*2+1] >  int_arb_2_priority[u][s4*2];
			assign int_arb_4_priority[u][s4]	= int_arb_4_lhs_bigger[u][s4]  ?  int_arb_2_priority[u][s4*2+1] :  int_arb_2_priority[u][s4*2];
			assign int_arb_4_id[u][s4] 		= int_arb_4_lhs_bigger[u][s4]  ?  int_arb_2_id[u][s4*2+1] :  int_arb_2_id[u][s4*2];
		end
		for (s8 = 0; s8 < 128; s8 = s8 + 1) begin  : gen_arb_element_radix8
			assign int_arb_8_lhs_bigger[u][s8] 	= int_arb_4_priority[u][s8*2+1] >  int_arb_4_priority[u][s8*2];
			assign int_arb_8_priority[u][s8]	= int_arb_8_lhs_bigger[u][s8]  ?  int_arb_4_priority[u][s8*2+1] :  int_arb_4_priority[u][s8*2];
			assign int_arb_8_id[u][s8] 		= int_arb_8_lhs_bigger[u][s8]  ?  int_arb_4_id[u][s8*2+1] :  int_arb_4_id[u][s8*2];
		end
		for (s16 = 0; s16 < 64; s16 = s16 + 1) begin  : gen_arb_element_radix16
			assign int_arb_16_lhs_bigger[u][s16] 	= int_arb_8_priority[u][s16*2+1] >  int_arb_8_priority[u][s16*2];
			assign int_arb_16_priority[u][s16]	= int_arb_16_lhs_bigger[u][s16]  ?  int_arb_8_priority[u][s16*2+1] :  int_arb_8_priority[u][s16*2];
			assign int_arb_16_id[u][s16] 		= int_arb_16_lhs_bigger[u][s16]  ?  int_arb_8_id[u][s16*2+1] :  int_arb_8_id[u][s16*2];
		end
		for (s32 = 0; s32 < 32; s32 = s32 + 1) begin  : gen_arb_element_radix32
			assign int_arb_32_lhs_bigger[u][s32] 	= int_arb_16_priority[u][s32*2+1] >  int_arb_16_priority[u][s32*2];
			assign int_arb_32_priority[u][s32]	= int_arb_32_lhs_bigger[u][s32]  ?  int_arb_16_priority[u][s32*2+1] :  int_arb_16_priority[u][s32*2];
			assign int_arb_32_id[u][s32] 		= int_arb_32_lhs_bigger[u][s32]  ?  int_arb_16_id[u][s32*2+1] :  int_arb_16_id[u][s32*2];
		end
		for (s64 = 0; s64 < 16; s64 = s64 + 1) begin  : gen_arb_element_radix64
			assign int_arb_64_lhs_bigger[u][s64] 	= int_arb_32_priority_reg[u][s64*2+1] >  int_arb_32_priority_reg[u][s64*2];
			assign int_arb_64_priority[u][s64]	= int_arb_64_lhs_bigger[u][s64]  ?  int_arb_32_priority_reg[u][s64*2+1] :  int_arb_32_priority_reg[u][s64*2];
			assign int_arb_64_id[u][s64] 		= int_arb_64_lhs_bigger[u][s64]  ?  int_arb_32_id_reg[u][s64*2+1] :  int_arb_32_id_reg[u][s64*2];
		end
		for (s128 = 0; s128 < 8; s128 = s128 + 1) begin  : gen_arb_element_radix128
			assign int_arb_128_lhs_bigger[u][s128] 	= int_arb_64_priority[u][s128*2+1] >  int_arb_64_priority[u][s128*2];
			assign int_arb_128_priority[u][s128]	= int_arb_128_lhs_bigger[u][s128]  ?  int_arb_64_priority[u][s128*2+1] :  int_arb_64_priority[u][s128*2];
			assign int_arb_128_id[u][s128] 		= int_arb_128_lhs_bigger[u][s128]  ?  int_arb_64_id[u][s128*2+1] :  int_arb_64_id[u][s128*2];
		end
		for (s256 = 0; s256 < 4; s256 = s256 + 1) begin  : gen_arb_element_radix256
			assign int_arb_256_lhs_bigger[u][s256] 	= int_arb_128_priority[u][s256*2+1] >  int_arb_128_priority[u][s256*2];
			assign int_arb_256_priority[u][s256]	= int_arb_256_lhs_bigger[u][s256]  ?  int_arb_128_priority[u][s256*2+1] :  int_arb_128_priority[u][s256*2];
			assign int_arb_256_id[u][s256] 		= int_arb_256_lhs_bigger[u][s256]  ?  int_arb_128_id[u][s256*2+1] :  int_arb_128_id[u][s256*2];
		end
		for (s512 = 0; s512 < 2; s512 = s512 + 1) begin  : gen_arb_element_radix512
			assign int_arb_512_lhs_bigger[u][s512] 	= int_arb_256_priority[u][s512*2+1] >  int_arb_256_priority[u][s512*2];
			assign int_arb_512_priority[u][s512]	= int_arb_512_lhs_bigger[u][s512]  ?  int_arb_256_priority[u][s512*2+1] :  int_arb_256_priority[u][s512*2];
			assign int_arb_512_id[u][s512] 		= int_arb_512_lhs_bigger[u][s512]  ?  int_arb_256_id[u][s512*2+1] :  int_arb_256_id[u][s512*2];
		end
			assign int_arb_1024_lhs_bigger[u]	= int_arb_512_priority[u][1] >  int_arb_512_priority[u][0];
			assign int_arb_1024_priority[u] 	= int_arb_1024_lhs_bigger[u] ?  int_arb_512_priority[u][1] 	:	int_arb_512_priority[u][0];
			assign int_arb_1024_id[u] 		= int_arb_1024_lhs_bigger[u] ?  int_arb_512_id[u][1] 	:	int_arb_512_id[u][0];
		if (INT_NUM < 2) begin : gen_max_id_pri_nx_2
			assign max_id_nx[u] = int_arb_2_id[u][0];
			assign max_priority_nx[u] = int_arb_2_priority[u][0];
		end
		else if (INT_NUM < 4) begin : gen_max_id_pri_nx_4
			assign max_id_nx[u] = int_arb_4_id[u][0];
			assign max_priority_nx[u] = int_arb_4_priority[u][0];
		end
		else if (INT_NUM < 8) begin : gen_max_id_pri_nx_8
			assign max_id_nx[u] = int_arb_8_id[u][0];
			assign max_priority_nx[u] = int_arb_8_priority[u][0];
		end
		else if (INT_NUM < 16) begin : gen_max_id_pri_nx_16
			assign max_id_nx[u] = int_arb_16_id[u][0];
			assign max_priority_nx[u] = int_arb_16_priority[u][0];
		end
		else if (INT_NUM < 32) begin : gen_max_id_pri_nx_32
			assign max_id_nx[u] = int_arb_32_id[u][0];
			assign max_priority_nx[u] = int_arb_32_priority[u][0];
		end
		else if (INT_NUM < 64) begin : gen_max_id_pri_nx_64
			assign max_id_nx[u] = int_arb_64_id[u][0];
			assign max_priority_nx[u] = int_arb_64_priority[u][0];
		end
		else if (INT_NUM < 128) begin : gen_max_id_pri_nx_128
			assign max_id_nx[u] = int_arb_128_id[u][0];
			assign max_priority_nx[u] = int_arb_128_priority[u][0];
		end
		else if (INT_NUM < 256) begin : gen_max_id_pri_nx_256
			assign max_id_nx[u] = int_arb_256_id[u][0];
			assign max_priority_nx[u] = int_arb_256_priority[u][0];
		end
		else if (INT_NUM < 512) begin : gen_max_id_pri_nx_512
			assign max_id_nx[u] = int_arb_512_id[u][0];
			assign max_priority_nx[u] = int_arb_512_priority[u][0];
		end
		else begin : gen_max_id_pri_nx_1024
			assign max_id_nx[u] = int_arb_1024_id[u];
			assign max_priority_nx[u] = int_arb_1024_priority[u];
		end
		assign arbitration_en[u] = ~vector_mode_en | (~eip[u] & ~eiack_to_plic[u]);
		assign vector_mode_claim_clear[u] = target_vector_claim[u] | target_ahb_claim[u];
		assign modify_setting_clear_max_pri[u] = ~eip[u] & ((((hit_source_priority & (req_addr[11:2] != 10'b0)) | hit_pending) & write_req) | target_threshold_write[u] | target_enable_write[u] | (|target_ahb_claim) | (|target_vector_claim));
		always @(posedge clk or negedge reset_n) begin : gen_max_id_pri_flops
			if (!reset_n) begin
				max_id_reg[u] <= {(INT_NUM_WIDTH){1'b0}};
				max_priority_reg[u] <= {(PRIORITY_WIDTH){1'b0}};
			end
			else if (vector_mode_claim_clear[u]) begin
				max_id_reg[u] <= {(INT_NUM_WIDTH){1'b0}};
				max_priority_reg[u] <= {(PRIORITY_WIDTH){1'b0}};
			end
			else if (modify_setting_clear_max_pri[u]) begin
				max_id_reg[u] <= {(INT_NUM_WIDTH){1'b0}};
				max_priority_reg[u] <= {(PRIORITY_WIDTH){1'b0}};
			end
			else if (arbitration_en[u]) begin
				max_id_reg[u] <= max_id_nx[u];
				max_priority_reg[u] <= max_priority_nx[u];
			end
		end
		assign max_id[u] = max_id_reg[u];
		assign max_priority[u] = max_priority_reg[u];
		assign external_interrupt_pending_reg_nx[u] = (max_priority_nx[u] > target_threshold[u]) ? 1'b1 : 1'b0;
		assign external_interrupt_pending[u] = external_interrupt_pending_reg[u];
		always @(posedge clk or negedge reset_n) begin : gen_external_interrupt_pending_flops
			if (!reset_n)
				external_interrupt_pending_reg[u] <= 1'b0;
			else if (vector_mode_claim_clear[u])
				external_interrupt_pending_reg[u] <= 1'b0;
			else if (modify_setting_clear_max_pri[u])
				external_interrupt_pending_reg[u] <= 1'b0;
			else if (arbitration_en_d1[u] & ~vector_mode_claim_clear_d1[u])
				external_interrupt_pending_reg[u] <= external_interrupt_pending_reg_nx[u];
		end
	end
end
for (u = 0; u < 16; u = u + 1) begin	: gen_arb_block_gtn32
	if (u <= INTERNAL_TARGET_NUM) begin : gen_used_target_arb_gtn32
		for (s32 = 0; s32 < 32; s32 = s32 + 1) begin: gen_arb_flop
			always @(posedge clk or negedge reset_n) begin
				if (!reset_n) begin
					int_arb_32_priority_reg[u][s32]	<= {(PRIORITY_WIDTH){1'b0}};
					int_arb_32_id_reg[u][s32]	<= {(INT_NUM_WIDTH){1'b0}};
				end
				else if (arbitration_en[u]) begin
					int_arb_32_priority_reg[u][s32]	<= int_arb_32_priority[u][s32];
					int_arb_32_id_reg[u][s32]	<= int_arb_32_id[u][s32];
				end
			end
		end
	end
end
endgenerate




generate
genvar v;
for (v = 0; v < 16; v = v + 1) begin : gen_read_source_priority_block_level1
	always @* begin : READ_SOURCE_PRIORITY_32_TO_1_LOW_MUX
		case(req_addr[6:2])
		5'h0 : read_source_priority_level1_l[v] = source_priority[(64*v)+0];
		5'h1 : read_source_priority_level1_l[v] = source_priority[(64*v)+1];
		5'h2 : read_source_priority_level1_l[v] = source_priority[(64*v)+2];
		5'h3 : read_source_priority_level1_l[v] = source_priority[(64*v)+3];
		5'h4 : read_source_priority_level1_l[v] = source_priority[(64*v)+4];
		5'h5 : read_source_priority_level1_l[v] = source_priority[(64*v)+5];
		5'h6 : read_source_priority_level1_l[v] = source_priority[(64*v)+6];
		5'h7 : read_source_priority_level1_l[v] = source_priority[(64*v)+7];
		5'h8 : read_source_priority_level1_l[v] = source_priority[(64*v)+8];
		5'h9 : read_source_priority_level1_l[v] = source_priority[(64*v)+9];
		5'hA : read_source_priority_level1_l[v] = source_priority[(64*v)+10];
		5'hB : read_source_priority_level1_l[v] = source_priority[(64*v)+11];
		5'hC : read_source_priority_level1_l[v] = source_priority[(64*v)+12];
		5'hD : read_source_priority_level1_l[v] = source_priority[(64*v)+13];
		5'hE : read_source_priority_level1_l[v] = source_priority[(64*v)+14];
		5'hF : read_source_priority_level1_l[v] = source_priority[(64*v)+15];
		5'h10 : read_source_priority_level1_l[v] = source_priority[(64*v)+16];
		5'h11 : read_source_priority_level1_l[v] = source_priority[(64*v)+17];
		5'h12 : read_source_priority_level1_l[v] = source_priority[(64*v)+18];
		5'h13 : read_source_priority_level1_l[v] = source_priority[(64*v)+19];
		5'h14 : read_source_priority_level1_l[v] = source_priority[(64*v)+20];
		5'h15 : read_source_priority_level1_l[v] = source_priority[(64*v)+21];
		5'h16 : read_source_priority_level1_l[v] = source_priority[(64*v)+22];
		5'h17 : read_source_priority_level1_l[v] = source_priority[(64*v)+23];
		5'h18 : read_source_priority_level1_l[v] = source_priority[(64*v)+24];
		5'h19 : read_source_priority_level1_l[v] = source_priority[(64*v)+25];
		5'h1A : read_source_priority_level1_l[v] = source_priority[(64*v)+26];
		5'h1B : read_source_priority_level1_l[v] = source_priority[(64*v)+27];
		5'h1C : read_source_priority_level1_l[v] = source_priority[(64*v)+28];
		5'h1D : read_source_priority_level1_l[v] = source_priority[(64*v)+29];
		5'h1E : read_source_priority_level1_l[v] = source_priority[(64*v)+30];
		5'h1F : read_source_priority_level1_l[v] = source_priority[(64*v)+31];
		default : read_source_priority_level1_l[v] = {(PRIORITY_WIDTH){1'b0}};
		endcase
	end
	always @* begin : READ_SOURCE_PRIORITY_32_TO_1_HIGH_MUX
		case(req_addr[6:2])
		5'h0 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+0];
		5'h1 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+1];
		5'h2 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+2];
		5'h3 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+3];
		5'h4 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+4];
		5'h5 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+5];
		5'h6 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+6];
		5'h7 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+7];
		5'h8 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+8];
		5'h9 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+9];
		5'hA : read_source_priority_level1_h[v] = source_priority[32+(64*v)+10];
		5'hB : read_source_priority_level1_h[v] = source_priority[32+(64*v)+11];
		5'hC : read_source_priority_level1_h[v] = source_priority[32+(64*v)+12];
		5'hD : read_source_priority_level1_h[v] = source_priority[32+(64*v)+13];
		5'hE : read_source_priority_level1_h[v] = source_priority[32+(64*v)+14];
		5'hF : read_source_priority_level1_h[v] = source_priority[32+(64*v)+15];
		5'h10 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+16];
		5'h11 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+17];
		5'h12 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+18];
		5'h13 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+19];
		5'h14 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+20];
		5'h15 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+21];
		5'h16 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+22];
		5'h17 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+23];
		5'h18 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+24];
		5'h19 : read_source_priority_level1_h[v] = source_priority[32+(64*v)+25];
		5'h1A : read_source_priority_level1_h[v] = source_priority[32+(64*v)+26];
		5'h1B : read_source_priority_level1_h[v] = source_priority[32+(64*v)+27];
		5'h1C : read_source_priority_level1_h[v] = source_priority[32+(64*v)+28];
		5'h1D : read_source_priority_level1_h[v] = source_priority[32+(64*v)+29];
		5'h1E : read_source_priority_level1_h[v] = source_priority[32+(64*v)+30];
		5'h1F : read_source_priority_level1_h[v] = source_priority[32+(64*v)+31];
		default : read_source_priority_level1_h[v] = {(PRIORITY_WIDTH){1'b0}};
		endcase
	end
	always @*begin : READ_SOURCE_PRIORITY_HL_MUX
		case(req_addr[7])
		1'b0 : read_source_priority_level1[v] = read_source_priority_level1_l[v];
		1'b1 : read_source_priority_level1[v] = read_source_priority_level1_h[v];
		default : read_source_priority_level1[v] = {(PRIORITY_WIDTH){1'b0}};
		endcase
	end
end
if (INT_NUM < 128) begin : gen_read_source_priority_block_level2_2
	always @* begin
		case(req_addr[8])
		1'b0: read_source_priority_level2 = read_source_priority_level1[0];
		1'b1: read_source_priority_level2 = read_source_priority_level1[1];
		default : read_source_priority_level2 = {(PRIORITY_WIDTH){1'b0}};
		endcase
	end
end
else if (INT_NUM < 256) begin : gen_read_source_priority_block_level2_4
	always @* begin
		case(req_addr[9:8])
		2'h0 : read_source_priority_level2 = read_source_priority_level1[0];
		2'h1 : read_source_priority_level2 = read_source_priority_level1[1];
		2'h2 : read_source_priority_level2 = read_source_priority_level1[2];
		2'h3 : read_source_priority_level2 = read_source_priority_level1[3];
		default : read_source_priority_level2 = {(PRIORITY_WIDTH){1'b0}};
		endcase
	end
end
else if (INT_NUM < 512) begin : gen_read_source_priority_block_level2_8
	always @* begin
		case(req_addr[10:8])
		3'h0 : read_source_priority_level2 = read_source_priority_level1[0];
		3'h1 : read_source_priority_level2 = read_source_priority_level1[1];
		3'h2 : read_source_priority_level2 = read_source_priority_level1[2];
		3'h3 : read_source_priority_level2 = read_source_priority_level1[3];
		3'h4 : read_source_priority_level2 = read_source_priority_level1[4];
		3'h5 : read_source_priority_level2 = read_source_priority_level1[5];
		3'h6 : read_source_priority_level2 = read_source_priority_level1[6];
		3'h7 : read_source_priority_level2 = read_source_priority_level1[7];
		default : read_source_priority_level2 = {(PRIORITY_WIDTH){1'b0}};
		endcase
	end
end
else begin :  gen_read_source_priority_block_level2_16
	always @* begin
		case(req_addr[11:8])
		4'h0 : read_source_priority_level2 = read_source_priority_level1[0];
		4'h1 : read_source_priority_level2 = read_source_priority_level1[1];
		4'h2 : read_source_priority_level2 = read_source_priority_level1[2];
		4'h3 : read_source_priority_level2 = read_source_priority_level1[3];
		4'h4 : read_source_priority_level2 = read_source_priority_level1[4];
		4'h5 : read_source_priority_level2 = read_source_priority_level1[5];
		4'h6 : read_source_priority_level2 = read_source_priority_level1[6];
		4'h7 : read_source_priority_level2 = read_source_priority_level1[7];
		4'h8 : read_source_priority_level2 = read_source_priority_level1[8];
		4'h9 : read_source_priority_level2 = read_source_priority_level1[9];
		4'hA : read_source_priority_level2 = read_source_priority_level1[10];
		4'hB : read_source_priority_level2 = read_source_priority_level1[11];
		4'hC : read_source_priority_level2 = read_source_priority_level1[12];
		4'hD : read_source_priority_level2 = read_source_priority_level1[13];
		4'hE : read_source_priority_level2 = read_source_priority_level1[14];
		4'hF : read_source_priority_level2 = read_source_priority_level1[15];
		default : read_source_priority_level2 = {(PRIORITY_WIDTH){1'b0}};
		endcase
	end
end
endgenerate


always @* begin
	case(req_addr[6:2])
	5'h0 : read_interrupt_pending = interrupt_pending[31:0];
	5'h1 : read_interrupt_pending = interrupt_pending[63:32];
	5'h2 : read_interrupt_pending = interrupt_pending[95:64];
	5'h3 : read_interrupt_pending = interrupt_pending[127:96];
	5'h4 : read_interrupt_pending = interrupt_pending[159:128];
	5'h5 : read_interrupt_pending = interrupt_pending[191:160];
	5'h6 : read_interrupt_pending = interrupt_pending[223:192];
	5'h7 : read_interrupt_pending = interrupt_pending[255:224];
	5'h8 : read_interrupt_pending = interrupt_pending[287:256];
	5'h9 : read_interrupt_pending = interrupt_pending[319:288];
	5'hA : read_interrupt_pending = interrupt_pending[351:320];
	5'hB : read_interrupt_pending = interrupt_pending[383:352];
	5'hC : read_interrupt_pending = interrupt_pending[415:384];
	5'hD : read_interrupt_pending = interrupt_pending[447:416];
	5'hE : read_interrupt_pending = interrupt_pending[479:448];
	5'hF : read_interrupt_pending = interrupt_pending[511:480];
	5'h10 : read_interrupt_pending = interrupt_pending[543:512];
	5'h11 : read_interrupt_pending = interrupt_pending[575:544];
	5'h12 : read_interrupt_pending = interrupt_pending[607:576];
	5'h13 : read_interrupt_pending = interrupt_pending[639:608];
	5'h14 : read_interrupt_pending = interrupt_pending[671:640];
	5'h15 : read_interrupt_pending = interrupt_pending[703:672];
	5'h16 : read_interrupt_pending = interrupt_pending[735:704];
	5'h17 : read_interrupt_pending = interrupt_pending[767:736];
	5'h18 : read_interrupt_pending = interrupt_pending[799:768];
	5'h19 : read_interrupt_pending = interrupt_pending[831:800];
	5'h1A : read_interrupt_pending = interrupt_pending[863:832];
	5'h1B : read_interrupt_pending = interrupt_pending[895:864];
	5'h1C : read_interrupt_pending = interrupt_pending[927:896];
	5'h1D : read_interrupt_pending = interrupt_pending[959:928];
	5'h1E : read_interrupt_pending = interrupt_pending[991:960];
	5'h1F : read_interrupt_pending = interrupt_pending[1023:992];
	default : read_interrupt_pending = 32'b0;
	endcase
end


always @* begin : read_target_enable_target_mux
	case(req_addr[10:7])
		4'h0	: read_target_enable = target_enable[0];
		4'h1	: read_target_enable = target_enable[1];
		4'h2	: read_target_enable = target_enable[2];
		4'h3	: read_target_enable = target_enable[3];
		4'h4	: read_target_enable = target_enable[4];
		4'h5	: read_target_enable = target_enable[5];
		4'h6	: read_target_enable = target_enable[6];
		4'h7	: read_target_enable = target_enable[7];
		4'h8	: read_target_enable = target_enable[8];
		4'h9	: read_target_enable = target_enable[9];
		4'hA	: read_target_enable = target_enable[10];
		4'hB	: read_target_enable = target_enable[11];
		4'hC	: read_target_enable = target_enable[12];
		4'hD	: read_target_enable = target_enable[13];
		4'hE	: read_target_enable = target_enable[14];
		4'hF	: read_target_enable = target_enable[15];
		default : read_target_enable = 1024'b0;
	endcase
end

always @* begin : read_target_enable_word_mux
	case(req_addr[6:2])
		5'h0	: read_target_enable_word = read_target_enable[31:0];
		5'h1	: read_target_enable_word = read_target_enable[63:32];
		5'h2	: read_target_enable_word = read_target_enable[95:64];
		5'h3	: read_target_enable_word = read_target_enable[127:96];
		5'h4	: read_target_enable_word = read_target_enable[159:128];
		5'h5	: read_target_enable_word = read_target_enable[191:160];
		5'h6	: read_target_enable_word = read_target_enable[223:192];
		5'h7	: read_target_enable_word = read_target_enable[255:224];
		5'h8	: read_target_enable_word = read_target_enable[287:256];
		5'h9	: read_target_enable_word = read_target_enable[319:288];
		5'hA	: read_target_enable_word = read_target_enable[351:320];
		5'hB	: read_target_enable_word = read_target_enable[383:352];
		5'hC	: read_target_enable_word = read_target_enable[415:384];
		5'hD	: read_target_enable_word = read_target_enable[447:416];
		5'hE	: read_target_enable_word = read_target_enable[479:448];
		5'hF	: read_target_enable_word = read_target_enable[511:480];
		5'h10	: read_target_enable_word = read_target_enable[543:512];
		5'h11	: read_target_enable_word = read_target_enable[575:544];
		5'h12	: read_target_enable_word = read_target_enable[607:576];
		5'h13	: read_target_enable_word = read_target_enable[639:608];
		5'h14	: read_target_enable_word = read_target_enable[671:640];
		5'h15	: read_target_enable_word = read_target_enable[703:672];
		5'h16	: read_target_enable_word = read_target_enable[735:704];
		5'h17	: read_target_enable_word = read_target_enable[767:736];
		5'h18	: read_target_enable_word = read_target_enable[799:768];
		5'h19	: read_target_enable_word = read_target_enable[831:800];
		5'h1A	: read_target_enable_word = read_target_enable[863:832];
		5'h1B	: read_target_enable_word = read_target_enable[895:864];
		5'h1C	: read_target_enable_word = read_target_enable[927:896];
		5'h1D	: read_target_enable_word = read_target_enable[959:928];
		5'h1E	: read_target_enable_word = read_target_enable[991:960];
		5'h1F	: read_target_enable_word = read_target_enable[1023:992];
		default : read_target_enable_word = 32'b0;
	endcase
end




always @* begin : read_target_threshold_16_to_1_mux
	case (req_addr[15:12])
	4'h0 : read_target_threshold = target_threshold[0];
	4'h1 : read_target_threshold = target_threshold[1];
	4'h2 : read_target_threshold = target_threshold[2];
	4'h3 : read_target_threshold = target_threshold[3];
	4'h4 : read_target_threshold = target_threshold[4];
	4'h5 : read_target_threshold = target_threshold[5];
	4'h6 : read_target_threshold = target_threshold[6];
	4'h7 : read_target_threshold = target_threshold[7];
	4'h8 : read_target_threshold = target_threshold[8];
	4'h9 : read_target_threshold = target_threshold[9];
	4'hA : read_target_threshold = target_threshold[10];
	4'hB : read_target_threshold = target_threshold[11];
	4'hC : read_target_threshold = target_threshold[12];
	4'hD : read_target_threshold = target_threshold[13];
	4'hE : read_target_threshold = target_threshold[14];
	4'hF : read_target_threshold = target_threshold[15];
	default : read_target_threshold = {(PRIORITY_WIDTH){1'b0}};
	endcase
end


always @* begin : read_arb_max_priority_mux
	case (req_addr[15:12])
	4'h0 : read_arb_max_priority = max_priority[0];
	4'h1 : read_arb_max_priority = max_priority[1];
	4'h2 : read_arb_max_priority = max_priority[2];
	4'h3 : read_arb_max_priority = max_priority[3];
	4'h4 : read_arb_max_priority = max_priority[4];
	4'h5 : read_arb_max_priority = max_priority[5];
	4'h6 : read_arb_max_priority = max_priority[6];
	4'h7 : read_arb_max_priority = max_priority[7];
	4'h8 : read_arb_max_priority = max_priority[8];
	4'h9 : read_arb_max_priority = max_priority[9];
	4'hA : read_arb_max_priority = max_priority[10];
	4'hB : read_arb_max_priority = max_priority[11];
	4'hC : read_arb_max_priority = max_priority[12];
	4'hD : read_arb_max_priority = max_priority[13];
	4'hE : read_arb_max_priority = max_priority[14];
	4'hF : read_arb_max_priority = max_priority[15];
	default : read_arb_max_priority = {(PRIORITY_WIDTH){1'b0}};
	endcase
end




always @* begin : target_claim_16_to_1_mux
	case (req_addr[15:12])
	4'h0 : target_claim_id = max_id[0] & {(INT_NUM_WIDTH){external_interrupt_pending[0]}};
	4'h1 : target_claim_id = max_id[1] & {(INT_NUM_WIDTH){external_interrupt_pending[1]}};
	4'h2 : target_claim_id = max_id[2] & {(INT_NUM_WIDTH){external_interrupt_pending[2]}};
	4'h3 : target_claim_id = max_id[3] & {(INT_NUM_WIDTH){external_interrupt_pending[3]}};
	4'h4 : target_claim_id = max_id[4] & {(INT_NUM_WIDTH){external_interrupt_pending[4]}};
	4'h5 : target_claim_id = max_id[5] & {(INT_NUM_WIDTH){external_interrupt_pending[5]}};
	4'h6 : target_claim_id = max_id[6] & {(INT_NUM_WIDTH){external_interrupt_pending[6]}};
	4'h7 : target_claim_id = max_id[7] & {(INT_NUM_WIDTH){external_interrupt_pending[7]}};
	4'h8 : target_claim_id = max_id[8] & {(INT_NUM_WIDTH){external_interrupt_pending[8]}};
	4'h9 : target_claim_id = max_id[9] & {(INT_NUM_WIDTH){external_interrupt_pending[9]}};
	4'hA : target_claim_id = max_id[10] & {(INT_NUM_WIDTH){external_interrupt_pending[10]}};
	4'hB : target_claim_id = max_id[11] & {(INT_NUM_WIDTH){external_interrupt_pending[11]}};
	4'hC : target_claim_id = max_id[12] & {(INT_NUM_WIDTH){external_interrupt_pending[12]}};
	4'hD : target_claim_id = max_id[13] & {(INT_NUM_WIDTH){external_interrupt_pending[13]}};
	4'hE : target_claim_id = max_id[14] & {(INT_NUM_WIDTH){external_interrupt_pending[14]}};
	4'hF : target_claim_id = max_id[15] & {(INT_NUM_WIDTH){external_interrupt_pending[15]}};
	default : target_claim_id = {(INT_NUM_WIDTH){1'b0}};
	endcase
end


always @* begin : target_preempted_priority_stack_16_to_1_mux
	case (req_addr[15:12])
	4'h0 : preempted_priority_stack_mux_out = target_preempted_priority_stack[0];
	4'h1 : preempted_priority_stack_mux_out = target_preempted_priority_stack[1];
	4'h2 : preempted_priority_stack_mux_out = target_preempted_priority_stack[2];
	4'h3 : preempted_priority_stack_mux_out = target_preempted_priority_stack[3];
	4'h4 : preempted_priority_stack_mux_out = target_preempted_priority_stack[4];
	4'h5 : preempted_priority_stack_mux_out = target_preempted_priority_stack[5];
	4'h6 : preempted_priority_stack_mux_out = target_preempted_priority_stack[6];
	4'h7 : preempted_priority_stack_mux_out = target_preempted_priority_stack[7];
	4'h8 : preempted_priority_stack_mux_out = target_preempted_priority_stack[8];
	4'h9 : preempted_priority_stack_mux_out = target_preempted_priority_stack[9];
	4'hA : preempted_priority_stack_mux_out = target_preempted_priority_stack[10];
	4'hB : preempted_priority_stack_mux_out = target_preempted_priority_stack[11];
	4'hC : preempted_priority_stack_mux_out = target_preempted_priority_stack[12];
	4'hD : preempted_priority_stack_mux_out = target_preempted_priority_stack[13];
	4'hE : preempted_priority_stack_mux_out = target_preempted_priority_stack[14];
	4'hF : preempted_priority_stack_mux_out = target_preempted_priority_stack[15];
	default : preempted_priority_stack_mux_out = 256'b0;
	endcase
end


always @* begin : TARGET_THRESHOLD_REGION_MUX
	case (req_addr[2])
	1'h0	: target_threshold_region_mux_out = {{REMAINED_PRIORITY_WIDTH{1'b0}},read_target_threshold};
	1'h1	: target_threshold_region_mux_out = real_claim ? {{REMAINED_INT_NUM_WIDTH{1'b0}},target_claim_id} : 32'b0;
	default	: target_threshold_region_mux_out = 32'b0;
	endcase
end

always @* begin : PREEMPITVE_STACK_MUX
	case(req_addr[4:2])
	3'h0: read_preempted_priority_stack = preempted_priority_stack_mux_out[31:0];
	3'h1: read_preempted_priority_stack = preempted_priority_stack_mux_out[63:32];
	3'h2: read_preempted_priority_stack = preempted_priority_stack_mux_out[95:64];
	3'h3: read_preempted_priority_stack = preempted_priority_stack_mux_out[127:96];
	3'h4: read_preempted_priority_stack = preempted_priority_stack_mux_out[159:128];
	3'h5: read_preempted_priority_stack = preempted_priority_stack_mux_out[191:160];
	3'h6: read_preempted_priority_stack = preempted_priority_stack_mux_out[223:192];
	3'h7: read_preempted_priority_stack = preempted_priority_stack_mux_out[255:224];
	default : read_preempted_priority_stack = 32'b0;
	endcase
end


always @* begin : TRIGGER_TYPE_MUX
	case(req_addr[6:2])
	5'h0 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[31:0] : EDGE_TRIGGER[31:0];
	5'h1 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[63:32] : EDGE_TRIGGER[63:32];
	5'h2 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[95:64] : EDGE_TRIGGER[95:64];
	5'h3 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[127:96] : EDGE_TRIGGER[127:96];
	5'h4 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[159:128] : EDGE_TRIGGER[159:128];
	5'h5 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[191:160] : EDGE_TRIGGER[191:160];
	5'h6 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[223:192] : EDGE_TRIGGER[223:192];
	5'h7 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[255:224] : EDGE_TRIGGER[255:224];
	5'h8 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[287:256] : EDGE_TRIGGER[287:256];
	5'h9 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[319:288] : EDGE_TRIGGER[319:288];
	5'hA : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[351:320] : EDGE_TRIGGER[351:320];
	5'hB : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[383:352] : EDGE_TRIGGER[383:352];
	5'hC : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[415:384] : EDGE_TRIGGER[415:384];
	5'hD : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[447:416] : EDGE_TRIGGER[447:416];
	5'hE : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[479:448] : EDGE_TRIGGER[479:448];
	5'hF : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[511:480] : EDGE_TRIGGER[511:480];
	5'h10 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[543:512] : EDGE_TRIGGER[543:512];
	5'h11 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[575:544] : EDGE_TRIGGER[575:544];
	5'h12 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[607:576] : EDGE_TRIGGER[607:576];
	5'h13 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[639:608] : EDGE_TRIGGER[639:608];
	5'h14 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[671:640] : EDGE_TRIGGER[671:640];
	5'h15 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[703:672] : EDGE_TRIGGER[703:672];
	5'h16 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[735:704] : EDGE_TRIGGER[735:704];
	5'h17 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[767:736] : EDGE_TRIGGER[767:736];
	5'h18 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[799:768] : EDGE_TRIGGER[799:768];
	5'h19 : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[831:800] : EDGE_TRIGGER[831:800];
	5'h1A : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[863:832] : EDGE_TRIGGER[863:832];
	5'h1B : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[895:864] : EDGE_TRIGGER[895:864];
	5'h1C : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[927:896] : EDGE_TRIGGER[927:896];
	5'h1D : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[959:928] : EDGE_TRIGGER[959:928];
	5'h1E : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[991:960] : EDGE_TRIGGER[991:960];
	5'h1F : trigger_type_mux_out = PROGRAMMABLE_TRIGGER ? interrupt_trigger_type[1023:992] : EDGE_TRIGGER[1023:992];
	default : trigger_type_mux_out = 32'b0;
	endcase
end
reg  [31:0]	rdata_mux_out;
wire [6:0] 	rdata_mux_sel = {req_region_sel[7:3],req_region_sel[1:0]};
wire [31:0]	source_priority_region_mux_out = hit_feature_reg ? {30'b0,vector_mode_en, preempted_priority_stack_en} : {{REMAINED_PRIORITY_WIDTH{1'b0}},read_source_priority_level2};
wire [31:0]	config_mux_out = req_addr[2] ? {8'b0,VALID_MAX_PRIORITY[7:0],PLIC_VERSION[15:0]} : {11'b0,TARGET_NUM[4:0],6'b0,INT_NUM[9:0]};
always @* begin
	case(rdata_mux_sel)
	7'b1000000 : rdata_mux_out = source_priority_region_mux_out;
	7'b0100000 : rdata_mux_out = read_interrupt_pending;
	7'b0010000 : rdata_mux_out = read_target_enable_word;
	7'b0001000 : rdata_mux_out = target_threshold_region_mux_out;
        7'b0000100 : rdata_mux_out = read_preempted_priority_stack;
        7'b0000010 : rdata_mux_out = trigger_type_mux_out;
        7'b0000001 : rdata_mux_out = config_mux_out;
        7'b0000000 : rdata_mux_out = 32'b0;
	default : rdata_mux_out = 32'b0;
	endcase
end
assign rd_data = rdata_mux_out;

wire feature_reg_write =  hit_feature_reg & write_req & ~req_addr[2];
always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		preempted_priority_stack_en <= 1'b0;
	else if (feature_reg_write)
		preempted_priority_stack_en <= wr_data[0];
end
generate
if (VECTOR_PLIC_SUPPORT == "yes") begin : gen_vplic_enabled
	reg reg_vector_mode_en;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n)
			reg_vector_mode_en <= 1'b0;
		else if (feature_reg_write)
			reg_vector_mode_en <= wr_data[1];
	end
	assign vector_mode_en = reg_vector_mode_en;
end
else begin : gen_vplic_disabled
	assign vector_mode_en = 1'b0;
end
endgenerate

endmodule
