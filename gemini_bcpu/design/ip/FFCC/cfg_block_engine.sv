module cfg_block_engine #(
    parameter CHAIN_NUM        = 128,
    parameter CHAIN_LENGTH_NUM = 16 ,
    parameter REGS_NUM         = 5  ,
    parameter DWIDTH           = 32
) (
    //
    input  logic              clk                                   ,
    input  logic              rst_n                                 ,
    //input settings and control
    input  logic [       1:0] cfg_cmd_i                             ,
    input  logic              kickoff_i                             ,
    input  logic [      31:0] chksum_i                              ,
    input  logic              soft_reset_i                          ,
    input  logic [       7:0] end_chain_num_i                       ,
    input  logic [       7:0] start_chain_num_i                     ,
    input  logic              world_align_i                         ,
    input  logic              byte_twist_i                          ,
    input  logic              bit_twist_i                           ,
    input  logic [      31:0] chain_length_i  [CHAIN_LENGTH_NUM]    ,
    input  logic [      31:0] chains_length_map_i [CHAIN_LENGTH_NUM],
    input  logic              cmd_control_i                         ,
    input  logic [      15:0] switch_chain_time_i                   ,
    //output status
    output logic              chksum_status_o                       ,
    output logic [       1:0] fsm_state_o                           ,
    output logic [      29:0] shift_count_o                         ,
    output logic              clr_kickoff_o                         ,
    // read/write to FPGA config data
    output logic              bitstream_wack_o                      ,
    input  logic [DWIDTH-1:0] bitstream_wdata_i                     ,
    input  logic              bitstream_wreq_i                      ,
    // read from FPGA config data
    output logic [DWIDTH-1:0] bitstream_rdata_o                     ,
    output logic              bitstream_rack_o                      ,
    input  logic              bitstream_rreq_i                      ,
    //
    output logic              ready                                 ,
    output logic              cfg_done_o                            ,
    //configuration chain interface
    output logic              ccff_clk_o  [CHAIN_NUM]               ,
    output logic              ccff_data_o [CHAIN_NUM]               ,
    output logic              ccff_cmd_o  [CHAIN_NUM]               ,
    input  logic              ccff_clk_i  [CHAIN_NUM]               ,
    input  logic              ccff_data_i [CHAIN_NUM]               ,
    output logic              ccff_rst_n
);



typedef enum logic [1:0] { IDLE = 2'b00,
                           WAIT    = 2'b01,
                           SHIFT   = 2'b10} cfg_state_t;

// FSM
cfg_state_t cfg_write_cur_st ;
cfg_state_t cfg_write_nxt_st ;


logic [31:0] shift_reg;
logic [4:0] shift_bit_cnt;
logic clr_shift_bit_cnt;
logic shift_done;
logic [31:0] chain_bit_cnt;
logic clr_chain_bit_cnt; 
logic [31:0] bitstream_bit_cnt;
logic [31:0] chain_length    [CHAIN_NUM];
logic [31:0] start_chain_length;
logic [31:0] end_chain_length;
logic [31:0] current_chain_length;
logic [7:0] current_chain_num;
logic en_switch_chain_num;
logic switch_chain_num;
logic [15:0] switch_chain_time_cnt;
logic switch_chain_time_cnt_en;
logic swith_chain_pause;
logic clk_out;
logic clk_in;
logic [31:0]shift_in_reg;
logic [31:0]shift_in_bit_cnt;
logic shift_in_done;
logic [31:0]chain_in_bit_cnt;
logic clr_chain_in_bit_cnt;
logic [31:0] shift_in_reg_ff;
logic [2:0] shift_in_done_ff;
logic shift_in_data_rdy;
logic bitstream_rack_o_ff;
logic bitstream_wack_o_ff;
logic [15:0] chksum_c0_w0;
logic [15:0] chksum_c0_w1; 
logic [15:0] chksum_c1_w0; 
logic [15:0] chksum_c1_w1;
logic [15:0] chksum_c0;
logic [15:0] chksum_c1;
logic pre_chksum_en;
logic post_chksum_en;
logic [15:0] csum_w0;
logic [15:0] csum_w1;

genvar n, k;
generate
 
    for(n = 0; n < CHAIN_LENGTH_NUM; n = n + 1) begin : gen_chain_length
        for(k = 0; k < CHAIN_NUM/CHAIN_LENGTH_NUM; k = k + 1) begin : gen_length_map
        assign chain_length[n*8+k] = chains_length_map_i[n][4*k+3:4*k] == k ? chain_length_i[k] : 'h0;
        end  
    end
endgenerate 

//write bitstream logic, working on apb clk
always_ff @(posedge clk, negedge rst_n)
    if (!rst_n) cfg_write_cur_st <= IDLE;
    else        cfg_write_cur_st <= cfg_write_nxt_st;

always_comb
    case (cfg_write_cur_st)
        IDLE      : cfg_write_nxt_st = kickoff_i ? WAIT : IDLE;        
        WAIT      : cfg_write_nxt_st = cfg_cmd_i[1] ? 
                                      (bitstream_rreq_i ? SHIFT : WAIT) :
                                      (bitstream_wreq_i ? SHIFT : WAIT);
        SHIFT     : cfg_write_nxt_st = clr_kickoff_o ? IDLE : 
                                       shift_done  ? WAIT : SHIFT;
        default   : cfg_write_nxt_st = IDLE;
    endcase

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)     shift_reg <= 'h0;
    else case (cfg_write_cur_st)
        IDLE      : shift_reg <= 'h0;
        WAIT      : shift_reg <=  (byte_twist_i & !bit_twist_i) ? {bitstream_wdata_i[24],bitstream_wdata_i[25],bitstream_wdata_i[26],bitstream_wdata_i[27], bitstream_wdata_i[28], bitstream_wdata_i[29], bitstream_wdata_i[30], bitstream_wdata_i[31],
                                                                  bitstream_wdata_i[16],bitstream_wdata_i[17],bitstream_wdata_i[18],bitstream_wdata_i[19], bitstream_wdata_i[20], bitstream_wdata_i[21], bitstream_wdata_i[22], bitstream_wdata_i[23],
                                                                  bitstream_wdata_i[8],bitstream_wdata_i[9],bitstream_wdata_i[10],bitstream_wdata_i[11], bitstream_wdata_i[12], bitstream_wdata_i[13], bitstream_wdata_i[14], bitstream_wdata_i[15],
                                                                  bitstream_wdata_i[0],bitstream_wdata_i[1],bitstream_wdata_i[2],bitstream_wdata_i[3], bitstream_wdata_i[4], bitstream_wdata_i[5], bitstream_wdata_i[6], bitstream_wdata_i[7]} : 
                                   (byte_twist_i & bit_twist_i) ? {bitstream_wdata_i[7],bitstream_wdata_i[6],bitstream_wdata_i[5],bitstream_wdata_i[4], bitstream_wdata_i[3], bitstream_wdata_i[2], bitstream_wdata_i[1], bitstream_wdata_i[0],
                                                                  bitstream_wdata_i[15],bitstream_wdata_i[14],bitstream_wdata_i[13],bitstream_wdata_i[12], bitstream_wdata_i[11], bitstream_wdata_i[10], bitstream_wdata_i[9], bitstream_wdata_i[8],
                                                                  bitstream_wdata_i[23],bitstream_wdata_i[22],bitstream_wdata_i[21],bitstream_wdata_i[20], bitstream_wdata_i[19], bitstream_wdata_i[18], bitstream_wdata_i[17], bitstream_wdata_i[16],
                                                                  bitstream_wdata_i[31],bitstream_wdata_i[30],bitstream_wdata_i[29],bitstream_wdata_i[28], bitstream_wdata_i[27], bitstream_wdata_i[26], bitstream_wdata_i[25], bitstream_wdata_i[24]} : 
                                 (!byte_twist_i & bit_twist_i) ? {bitstream_wdata_i[0],bitstream_wdata_i[1],bitstream_wdata_i[2],bitstream_wdata_i[3], bitstream_wdata_i[4], bitstream_wdata_i[5], bitstream_wdata_i[6], bitstream_wdata_i[7],
                                                                  bitstream_wdata_i[8],bitstream_wdata_i[9],bitstream_wdata_i[10],bitstream_wdata_i[11], bitstream_wdata_i[12], bitstream_wdata_i[13], bitstream_wdata_i[14], bitstream_wdata_i[15],
                                                                  bitstream_wdata_i[16],bitstream_wdata_i[17],bitstream_wdata_i[18],bitstream_wdata_i[19], bitstream_wdata_i[20], bitstream_wdata_i[21], bitstream_wdata_i[22], bitstream_wdata_i[23],
                                                                  bitstream_wdata_i[24],bitstream_wdata_i[25],bitstream_wdata_i[26],bitstream_wdata_i[27], bitstream_wdata_i[28], bitstream_wdata_i[29], bitstream_wdata_i[30], bitstream_wdata_i[31]} :                                
                                                                  bitstream_wdata_i;        
        SHIFT     : shift_reg <= !swith_chain_pause ? {1'b0, shift_reg[31:1]} : shift_reg; 
        default   : shift_reg <= 'h0;
    endcase    

// acl for wdata
assign bitstream_wack_o = cfg_cmd_i[1] ? 1'b0 : 
                          kickoff_i ? shift_done : bitstream_wreq_i;


// cnt logic
// counter for bit shifting
// clear after shift 32 bit, or all bits for the current chain are shifted
always_ff @(posedge clk, negedge rst_n) begin : proc_shift_bit_cnt
    if(~rst_n)
        shift_bit_cnt <= 0;
    else if(cfg_write_cur_st==SHIFT)
        if(clr_shift_bit_cnt)
            shift_bit_cnt <= 0;
        else if(!swith_chain_pause)
            shift_bit_cnt <= shift_bit_cnt + 1;
end

// bit chain counter
// clrear after all bits for the current chain are shifted
always_ff @(posedge clk , negedge rst_n) begin : proc_chain_bit_cnt
    if(~rst_n)
        chain_bit_cnt <= 0;
    else if(cfg_write_cur_st==SHIFT)
        if(clr_chain_bit_cnt)
            chain_bit_cnt <= 0;
        else if(!swith_chain_pause)
            chain_bit_cnt <= chain_bit_cnt + 1;
end

// bitstream counter, for all chain
// clear after all bitstream bits are shifted
always_ff @(posedge clk, negedge rst_n) begin : proc_bitstream_bit_cnt
    if(~rst_n)
        bitstream_bit_cnt <= 0;
    else if(cfg_write_cur_st==SHIFT)
        if(clr_kickoff_o)
            bitstream_bit_cnt <= 0;
        else if(!swith_chain_pause)
            bitstream_bit_cnt <= bitstream_bit_cnt + 1;
end


assign shift_done = shift_bit_cnt==5'd31 || world_align_i&clr_chain_bit_cnt; 

assign clr_shift_bit_cnt = shift_done & !swith_chain_pause;

assign clr_chain_bit_cnt = (cfg_write_cur_st==SHIFT) && (chain_bit_cnt==current_chain_length-1) & !swith_chain_pause;

assign clr_kickoff_o = clr_chain_bit_cnt & current_chain_num==end_chain_num_i;


// chain length sel and control
always_ff @(posedge clk, negedge rst_n)
    if (!rst_n) start_chain_length <= chain_length[0];
    else        start_chain_length <= chain_length[start_chain_num_i];

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n) end_chain_length <= chain_length[0];
    else        end_chain_length <= chain_length[end_chain_num_i];

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n) current_chain_length <= chain_length[0];
    else        current_chain_length <= chain_length[current_chain_num];    


always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)                   current_chain_num <= start_chain_num_i;
    else if(cfg_write_cur_st==IDLE)     current_chain_num <= start_chain_num_i;    
    else if (en_switch_chain_num) current_chain_num <= current_chain_num + 8'b1;

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)                       switch_chain_time_cnt_en <= '0;
    else if (clr_chain_bit_cnt )      switch_chain_time_cnt_en <= '1;         
    else if (switch_chain_time_cnt==switch_chain_time_i) switch_chain_time_cnt_en <= '0;

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)                                          switch_chain_time_cnt <= 0;
    else if (clr_chain_bit_cnt )      switch_chain_time_cnt <= 0;         
    else if (switch_chain_time_cnt_en)                   switch_chain_time_cnt <= switch_chain_time_cnt + 16'b1;

assign swith_chain_pause = switch_chain_time_cnt_en;

assign switch_chain_num = end_chain_num_i!=current_chain_num;

assign en_switch_chain_num = switch_chain_time_cnt_en & switch_chain_time_cnt==switch_chain_time_i;    


//read bitstream, working on clk_in


  always_ff @(posedge clk_in, negedge rst_n)
    if (!rst_n)     shift_in_reg <= 'h0;
    else if(kickoff_i & cfg_cmd_i[1] & !shift_in_done)
        shift_in_reg <= (bit_twist_i) ? {ccff_data_i[current_chain_num], shift_in_reg[31:1]} : {shift_in_reg[30:0],ccff_data_i[current_chain_num]};
    else if(shift_in_done)
        if(world_align_i)
            shift_in_reg <= 'h0;
        else
            shift_in_reg <= shift_in_reg;

always_ff @(posedge clk_in, negedge rst_n) begin : proc_shift_in_bit_cnt
    if(~rst_n)
        shift_in_bit_cnt <= 0;
    else begin
        if(shift_in_done)
            shift_in_bit_cnt <= 0;
        else 
            shift_in_bit_cnt <= shift_in_bit_cnt + 1;
    end    
end

always_ff @(posedge clk_in, negedge rst_n)
    if (!rst_n)            shift_in_reg_ff <= 0;
    else if(shift_in_done) shift_in_reg_ff <= shift_in_reg;


// clear after all bits for the current chain are shifted

always_ff @(posedge clk_in , negedge rst_n) begin : proc_chain_in_bit_cnt
    if(~rst_n)
        chain_in_bit_cnt <= 0;
    else begin
        if(clr_chain_in_bit_cnt)
            chain_in_bit_cnt <= 0;
        else 
            chain_in_bit_cnt <= chain_in_bit_cnt + 1;
    end    
end

assign shift_in_done = shift_in_bit_cnt==5'd31 || world_align_i&clr_chain_in_bit_cnt; 

assign clr_chain_in_bit_cnt = (chain_in_bit_cnt==current_chain_length-1);




always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)  shift_in_done_ff <= 0;
    else         shift_in_done_ff <= {shift_in_done_ff[1:0], shift_in_done};

assign shift_in_data_rdy = shift_in_done_ff[2:1] == 2'b01;

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)                bitstream_rdata_o <= 0;
    else if(shift_in_data_rdy) bitstream_rdata_o <= (byte_twist_i) ? {shift_in_reg_ff[24],shift_in_reg_ff[25],shift_in_reg_ff[26],shift_in_reg_ff[27], shift_in_reg_ff[28], shift_in_reg_ff[29], shift_in_reg_ff[30], shift_in_reg_ff[31], 
                                                                      shift_in_reg_ff[16],shift_in_reg_ff[17],shift_in_reg_ff[18],shift_in_reg_ff[19], shift_in_reg_ff[20], shift_in_reg_ff[21], shift_in_reg_ff[22], shift_in_reg_ff[23],
                                                                      shift_in_reg_ff[8],shift_in_reg_ff[9],shift_in_reg_ff[10],shift_in_reg_ff[11], shift_in_reg_ff[12], shift_in_reg_ff[13], shift_in_reg_ff[14], shift_in_reg_ff[15],
                                                                      shift_in_reg_ff[0],shift_in_reg_ff[1],shift_in_reg_ff[2],shift_in_reg_ff[3], shift_in_reg_ff[4], shift_in_reg_ff[5], shift_in_reg_ff[6], shift_in_reg_ff[7]} : shift_in_reg_ff;

//ack for rdata
always @ (posedge clk or negedge rst_n)
  if (!rst_n)                                bitstream_rack_o <= 1'b0;
  else if (~kickoff_i)                       bitstream_rack_o <= bitstream_rreq_i;
  else if (cfg_cmd_i[1] & shift_in_data_rdy) bitstream_rack_o <= 1'b1;
  else if (bitstream_rack_o)                 bitstream_rack_o <= 1'b0;


always_ff @(posedge clk, negedge rst_n)
    if (!rst_n) ready <= 1'b0;
    else if(shift_done) ready <= 1'b1;
    else if(cfg_write_cur_st==SHIFT) ready <= 1'b0;


// chksum 

assign pre_chksum_en  = (cfg_cmd_i == 1);
assign post_chksum_en = (cfg_cmd_i == 2);


assign csum_w0 = chksum_i[15: 0];
assign csum_w1 = chksum_i[31:16];


assign chksum_c0_w0 = pre_chksum_en ? chksum_c0 + bitstream_wdata_i[15: 0] 
                                    : post_chksum_en && bitstream_rack_o ? chksum_c0 + bitstream_rdata_o[15:0] 
                                    : 16'h0 ;

assign chksum_c0_w1 = pre_chksum_en ? chksum_c0 + bitstream_wdata_i[31:16]
                                    : post_chksum_en && bitstream_rack_o ? chksum_c0 + bitstream_rdata_o[31:16] 
                                    : 16'h0 ;

assign chksum_c1_w0 = pre_chksum_en ? chksum_c0 + chksum_c1 + bitstream_wdata_i[15:0]
                                    : post_chksum_en && bitstream_rack_o ? chksum_c0 + chksum_c1 + bitstream_rdata_o[15:0]
                                    : 16'h0 ;

assign chksum_c1_w1 = pre_chksum_en ? chksum_c0 + chksum_c1 + bitstream_wdata_i[31:16]
                                    : post_chksum_en && bitstream_rack_o ? chksum_c0 + chksum_c1 + bitstream_rdata_o[31:16]
                                    : 16'h0 ;                                                  


always_ff @(posedge clk, negedge rst_n)
    if (!rst_n) bitstream_rack_o_ff <= 0;
    else        bitstream_rack_o_ff <= bitstream_rack_o;

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n) bitstream_wack_o_ff <= 0;
    else        bitstream_wack_o_ff <= bitstream_wack_o;    

always_ff @(posedge clk, negedge rst_n) begin
  if (~rst_n) begin
    chksum_c0 <=  16'h0; 
    chksum_c1 <=  16'h0;
  end else if(cfg_write_cur_st == IDLE) begin
    chksum_c0 <=  16'h0; 
    chksum_c1 <=  16'h0;    
  end else if (pre_chksum_en & bitstream_wack_o_ff==1'b1 & ~cfg_done_o) begin
    chksum_c0 <=  chksum_c0_w0;
    chksum_c1 <=  chksum_c1_w0;
  end else if (pre_chksum_en & bitstream_wack_o_ff==1'b1 & ~cfg_done_o) begin
    chksum_c0 <=  chksum_c0_w1;
    chksum_c1 <=  chksum_c1_w1;
  end else if (post_chksum_en & bitstream_rack_o==1'b1 & ~cfg_done_o) begin
    chksum_c0 <=  chksum_c0_w0;
    chksum_c1 <=  chksum_c1_w0;
  end else if (post_chksum_en & bitstream_rack_o_ff==1'b1 & ~cfg_done_o) begin
    chksum_c0 <=  chksum_c0_w1;
    chksum_c1 <=  chksum_c1_w1;
  end
end


always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)                                              chksum_status_o <= 1'b0;
    else if (pre_chksum_en & post_chksum_en & clr_kickoff_o) chksum_status_o <= ~(|(chksum_c0 + csum_w0 + csum_w1) || |(chksum_c1 - csum_w1)); 

// cfg done 

always_ff @(posedge clk, negedge rst_n)
    if (!rst_n)                                                 cfg_done_o <= 1'b0;
    else if (!pre_chksum_en & clr_kickoff_o)                    cfg_done_o <= 1'b1; 
    else if ( pre_chksum_en  & clr_kickoff_o & chksum_status_o) cfg_done_o <= 1'b1; 
    else                                                        cfg_done_o <= 1'b0;


///////////////////////////////////

assign shift_count_o = bitstream_bit_cnt[29:0];
assign fsm_state_o = cfg_write_cur_st;

///////////////////////////////////

logic ser_data;
assign clk_in = ccff_clk_i[current_chain_num];

assign en_clk = cfg_write_cur_st==SHIFT & !swith_chain_pause;

clkgate ccff_clkgate (.clk(clk), .clk_en(en_clk), .clk_out(clk_out));

assign ser_data = shift_reg[0];

generate
    for(n = 0; n < CHAIN_NUM; n = n + 1) begin : gen_ccff_intf
        always_comb
            if(n==current_chain_num)begin
                ccff_clk_o[n]  = clk_out;
                ccff_data_o[n] = shift_reg[0];
                ccff_cmd_o[n]  = cmd_control_i;

            end
            else begin
                ccff_clk_o[n]  = '0;
                ccff_data_o[n] = '0;
                ccff_cmd_o[n]  = '0;

            end

end          
endgenerate            

assign ccff_rst_n = soft_reset_i;

endmodule
