// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_dcu_mant (
    dcu_clk,
    dcu_reset_n,
    dcache_disable_init,
    ctl_idle,
    dcu_ix_req,
    dcu_ix_addr,
    dcu_ix_command,
    dcu_ix_wdata,
    dcu_ix_ack,
    dcu_ix_rdata,
    dcu_ix_raddr,
    dcu_ix_status,
    evb_empty,
    dcu_xcctl_ecc_error,
    dcu_xcctl_ecc_corr,
    mant_idle,
    mant_req_valid,
    mant_req_func,
    mant_req_addr,
    mant_req_way,
    mant_req_wdata,
    mant_req_ready,
    mant_ack_valid,
    mant_ack_rdata,
    mant_ack_status,
    mant_ack_defer
);
parameter PALEN = 32;
parameter DCACHE_SIZE_KB = 0;
parameter DCACHE_WAY = 2;
localparam GRN_LSB = 2;
localparam GRN_MSB = 5;
localparam IDX_LSB = 6;
localparam IDX_WIDTH = $unsigned($clog2(DCACHE_SIZE_KB * 1024 / DCACHE_WAY / 64));
localparam IDX_MSB = IDX_LSB + IDX_WIDTH - 1;
localparam RESET = 0;
localparam INIT = 1;
localparam IDLE = 2;
localparam CCTL0 = 3;
localparam CCTL1 = 4;
localparam CCTL2 = 5;
localparam CCTL3 = 6;
localparam STATES = 7;
input dcu_clk;
input dcu_reset_n;
input dcache_disable_init;
input ctl_idle;
input dcu_ix_req;
input [31:0] dcu_ix_addr;
input [7:0] dcu_ix_command;
input [31:0] dcu_ix_wdata;
output dcu_ix_ack;
output [31:0] dcu_ix_rdata;
output [31:0] dcu_ix_raddr;
output [11:0] dcu_ix_status;
input evb_empty;
input dcu_xcctl_ecc_error;
input dcu_xcctl_ecc_corr;
output mant_idle;
output mant_req_valid;
output [8:0] mant_req_func;
output [PALEN - 1:0] mant_req_addr;
output [3:0] mant_req_way;
output [31:0] mant_req_wdata;
input mant_req_ready;
input mant_ack_valid;
input [31:0] mant_ack_rdata;
input [11:0] mant_ack_status;
input mant_ack_defer;


wire way1 = DCACHE_WAY == 1;
wire way2 = DCACHE_WAY == 2;
wire way4 = DCACHE_WAY == 4;
reg [STATES - 1:0] fsm_cs;
reg [STATES - 1:0] fsm_ns;
reg fsm_en;
wire fsm_reset = fsm_cs[RESET];
wire fsm_idle = fsm_cs[IDLE];
wire fsm_init = fsm_cs[INIT];
wire fsm_cctl0 = fsm_cs[CCTL0];
wire fsm_cctl2 = fsm_cs[CCTL2];
wire fsm_cctl3 = fsm_cs[CCTL3];
reg [IDX_WIDTH - 1:0] mant_idx;
wire [IDX_WIDTH - 1:0] mant_idx_nx;
wire [IDX_WIDTH - 1:0] mant_idx_add_one;
wire mant_idx_en;
reg [GRN_MSB:GRN_LSB] mant_grn;
wire [GRN_MSB:GRN_LSB] mant_grn_nx;
wire [GRN_MSB:GRN_LSB] mant_grn_add_one;
wire mant_grn_en;
reg [3:0] mant_way;
wire [3:0] mant_way_nx;
wire [3:0] mant_way_add_one;
wire mant_way_en;
reg [31:0] dcu_ix_rdata;
wire [1:0] dcu_ix_way;
reg [11:0] dcu_ix_status;
wire [11:0] dcu_ix_status_nx;
wire dcu_ix_status_en;
wire [11:0] evb_ecc_status;
wire dcu_ix_fault = dcu_ix_status[0];
wire init_last;
wire cctl_last;
wire mant_grn_last;
wire mant_way_last;
wire mant_idx_last;
wire [IDX_WIDTH - 1:0] cctl_idx;
wire [GRN_MSB:GRN_LSB] cctl_grn;
wire [3:0] cctl_way;
wire [3:0] cctl_way_ix;
wire [1:0] dcu_ix_rway;
wire cctl_all;
wire cctl_idx_inc;
wire cctl_grn_inc;
wire command_done;
reg wball_done;
wire wball_done_en;
wire wball_done_nx;
wire wball_done_set;
wire wball_done_clr;
always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        fsm_cs <= {{(STATES - 1){1'b0}},1'b1};
    end
    else if (fsm_en) begin
        fsm_cs <= fsm_ns;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        mant_idx <= {IDX_WIDTH{1'b0}};
    end
    else if (mant_idx_en) begin
        mant_idx <= mant_idx_nx;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        mant_grn <= {(GRN_MSB - GRN_LSB + 1){1'b0}};
    end
    else if (mant_grn_en) begin
        mant_grn <= mant_grn_nx;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        mant_way <= 4'd1;
    end
    else if (mant_way_en) begin
        mant_way <= mant_way_nx;
    end
end

always @(posedge dcu_clk or negedge dcu_reset_n) begin
    if (!dcu_reset_n) begin
        wball_done <= 1'b0;
    end
    else if (wball_done_en) begin
        wball_done <= wball_done_nx;
    end
end

always @* begin
    fsm_ns = {STATES{1'b0}};
    case (1'b1)
        fsm_cs[RESET]: begin
            if (dcache_disable_init) begin
                fsm_ns[IDLE] = 1'b1;
            end
            else begin
                fsm_ns[INIT] = 1'b1;
            end
            fsm_en = 1'b1;
        end
        fsm_cs[INIT]: begin
            fsm_ns[IDLE] = 1'b1;
            fsm_en = init_last;
        end
        fsm_cs[IDLE]: begin
            fsm_ns[CCTL0] = 1'b1;
            fsm_en = dcu_ix_req & ctl_idle;
        end
        fsm_cs[CCTL0]: begin
            if (command_done) begin
                fsm_ns[CCTL3] = 1'b1;
                fsm_en = 1'b1;
            end
            else begin
                fsm_ns[CCTL1] = 1'b1;
                fsm_en = mant_req_ready;
            end
        end
        fsm_cs[CCTL1]: begin
            if (~dcu_ix_req) begin
                fsm_ns[IDLE] = 1'b1;
                fsm_en = 1'b1;
            end
            else begin
                fsm_ns[CCTL0] = mant_ack_defer;
                fsm_ns[CCTL2] = ~mant_ack_defer;
                fsm_en = mant_ack_valid;
            end
        end
        fsm_cs[CCTL2]: begin
            if (~dcu_ix_req) begin
                fsm_ns[IDLE] = 1'b1;
                fsm_en = 1'b1;
            end
            else if (cctl_last | dcu_ix_fault) begin
                fsm_ns[CCTL3] = 1'b1;
                fsm_en = evb_empty;
            end
            else begin
                fsm_ns[CCTL0] = 1'b1;
                fsm_en = evb_empty;
            end
        end
        fsm_cs[CCTL3]: begin
            fsm_ns[IDLE] = 1'b1;
            fsm_en = ~dcu_ix_req;
        end
        default: begin
            fsm_ns = {STATES{1'b0}};
            fsm_en = 1'b0;
        end
    endcase
end

assign init_last = &mant_idx;
assign cctl_last = ~cctl_all | (mant_idx_last & mant_way_last);
assign mant_grn_last = &mant_grn;
assign mant_idx_en = (fsm_init & mant_req_ready) | (fsm_idle & dcu_ix_req) | (fsm_cctl2 & fsm_en & cctl_idx_inc & mant_way_last) | (fsm_cctl2 & fsm_en & cctl_grn_inc & mant_way_last & mant_grn_last);
assign mant_idx_add_one = mant_idx + {{(IDX_WIDTH - 1){1'b0}},1'b1};
assign mant_idx_nx = ({IDX_WIDTH{fsm_init}} & mant_idx_add_one) | ({IDX_WIDTH{fsm_idle}} & cctl_idx) | ({IDX_WIDTH{fsm_cctl2}} & mant_idx_add_one);
assign mant_idx_last = &mant_idx;
assign mant_grn_en = (fsm_idle & dcu_ix_req) | (fsm_cctl2 & fsm_en & cctl_grn_inc);
assign mant_grn_add_one = mant_grn + {{(GRN_MSB - GRN_LSB){1'b0}},1'b1};
assign mant_grn_nx = ({(GRN_MSB - GRN_LSB + 1){fsm_idle}} & cctl_grn) | ({(GRN_MSB - GRN_LSB + 1){fsm_cctl2}} & mant_grn_add_one);
assign mant_way_en = fsm_reset | fsm_idle & dcu_ix_req | (fsm_cctl2 & fsm_en & cctl_idx_inc) | (fsm_cctl2 & fsm_en & cctl_grn_inc & mant_grn_last);
assign mant_way_nx = ({4{fsm_reset}}) | ({4{fsm_idle}} & cctl_way) | ({4{fsm_cctl2}} & mant_way_add_one);
assign mant_way_add_one = ({4{way1}} & 4'd1) | ({4{way2}} & {2'd0,mant_way[0],mant_way[1]}) | ({4{way4}} & {mant_way[2:0],mant_way[3]});
assign mant_way_last = (way1) | (way2 & mant_way[1]) | (way4 & mant_way[3]);
kv_onehot2bin #(
    .N(4)
) u_dcu_ix_rway (
    .out(dcu_ix_rway),
    .in(mant_way)
);
assign wball_done_en = wball_done_set | wball_done_clr;
assign wball_done_nx = ~wball_done_clr & (wball_done | wball_done_set);
assign wball_done_set = fsm_cctl3 & cctl_all;
assign wball_done_clr = ~ctl_idle;
assign dcu_ix_ack = fsm_cctl3;
always @(posedge dcu_clk) begin
    if (mant_ack_valid) begin
        dcu_ix_rdata <= mant_ack_rdata;
    end
end

always @(posedge dcu_clk) begin
    if (dcu_ix_status_en) begin
        dcu_ix_status <= dcu_ix_status_nx;
    end
end

assign dcu_ix_status_en = mant_ack_valid | dcu_xcctl_ecc_error;
assign dcu_ix_status_nx = mant_ack_valid ? mant_ack_status : evb_ecc_status;
assign evb_ecc_status[0] = 1'b1;
assign evb_ecc_status[1 +:8] = 8'd0;
assign evb_ecc_status[9] = dcu_xcctl_ecc_corr;
assign evb_ecc_status[10] = 1'b1;
assign evb_ecc_status[11] = 1'b0;
assign cctl_idx = cctl_all ? {IDX_WIDTH{1'b0}} : dcu_ix_addr[IDX_MSB:IDX_LSB];
assign cctl_grn = dcu_ix_addr[GRN_MSB:GRN_LSB];
assign dcu_ix_way = ({2{way1}} & 2'b0) | ({2{way2}} & {1'b0,dcu_ix_addr[IDX_MSB + 1]}) | ({2{way4}} & dcu_ix_addr[IDX_MSB + 2:IDX_MSB + 1]);
kv_bin2onehot #(
    .N(4)
) u_cctl_way_ix (
    .out(cctl_way_ix),
    .in(dcu_ix_way)
);
assign cctl_all = (dcu_ix_command == 8'b00000110) | (dcu_ix_command == 8'b00010111) | (dcu_ix_command == 8'b00000111);
assign cctl_idx_inc = (dcu_ix_command == 8'b00010011) | (dcu_ix_command == 8'b00010101) | (dcu_ix_command == 8'b00010000) | (dcu_ix_command == 8'b00010001) | (dcu_ix_command == 8'b00010010) | cctl_all;
assign cctl_grn_inc = (dcu_ix_command == 8'b00010100) | (dcu_ix_command == 8'b00010110);
assign command_done = ((dcu_ix_command == 8'b00000111) & wball_done);
assign cctl_way = cctl_all ? 4'b0001 : cctl_way_ix;
assign dcu_ix_raddr[GRN_LSB - 1:0] = dcu_ix_addr[GRN_LSB - 1:0];
assign dcu_ix_raddr[GRN_MSB:GRN_LSB] = mant_grn;
assign dcu_ix_raddr[IDX_MSB:IDX_LSB] = mant_idx;
assign dcu_ix_raddr[31:IDX_MSB + 1] = ({(32 - IDX_MSB - 1){way1}} & dcu_ix_addr[31:IDX_MSB + 1]) | ({(32 - IDX_MSB - 1){way2}} & {dcu_ix_addr[31:IDX_MSB + 2],dcu_ix_rway[0]}) | ({(32 - IDX_MSB - 1){way4}} & {dcu_ix_addr[31:IDX_MSB + 3],dcu_ix_rway[1:0]});
assign mant_req_valid = fsm_init | (fsm_cctl0 & ~command_done);
assign mant_req_func[0] = (fsm_cctl0 & (dcu_ix_command == 8'b00010111)) | (fsm_cctl0 & (dcu_ix_command == 8'b00010000));
assign mant_req_func[2] = (fsm_cctl0 & (dcu_ix_command == 8'b00000111)) | (fsm_cctl0 & (dcu_ix_command == 8'b00010001));
assign mant_req_func[1] = (fsm_cctl0 & (dcu_ix_command == 8'b00000110)) | (fsm_cctl0 & (dcu_ix_command == 8'b00010010));
assign mant_req_func[3] = fsm_init | (fsm_cctl0 & (dcu_ix_command == 8'b00010101));
assign mant_req_func[4] = (fsm_cctl0 & (dcu_ix_command == 8'b00010011));
assign mant_req_func[6] = (fsm_cctl0 & (dcu_ix_command == 8'b00010110));
assign mant_req_func[5] = (fsm_cctl0 & (dcu_ix_command == 8'b00010100));
assign mant_req_func[7 +:2] = 2'd2;
assign mant_req_addr[PALEN - 1:IDX_MSB + 1] = {(PALEN - IDX_MSB - 1){1'b0}};
assign mant_req_addr[IDX_MSB:IDX_LSB] = mant_idx;
assign mant_req_addr[GRN_MSB:GRN_LSB] = mant_grn;
assign mant_req_addr[GRN_LSB - 1:0] = {GRN_LSB{1'b0}};
assign mant_req_way = mant_way;
assign mant_req_wdata = ({32{fsm_cctl0}} & dcu_ix_wdata);
assign mant_idle = fsm_idle;
endmodule

