module cfg_regs #(
    parameter REGS_NUM         = 44,
    parameter DWIDTH           = 32,
    parameter CHAIN_LENGTH_NUM = 16
) (
    input  logic                clk                                 ,
    input  logic                rst_n                               ,
    // read apb_manager
    output logic                rack_o                              ,
    output logic                rerr_o                              ,
    output logic [  DWIDTH-1:0] rdat_o                              ,
    input  logic [REGS_NUM-1:0] rreq_i                              ,
    // write apb_manager
    output logic                wack_o                              ,
    output logic                werr_o                              ,
    input  logic [  DWIDTH-1:0] wdat_i                              ,
    input  logic [REGS_NUM-1:0] wreq_i                              ,
    input  logic [DWIDTH/8-1:0] wstr_i                              ,
    output logic [         1:0] cfg_cmd                             ,
    output logic                cfg_kickoff                         ,
    output logic [        31:0] chksum_word                         ,
    input  logic                chksum_status                       ,
    output logic                soft_reset                          ,
    output logic                cmd_control                         ,
    output logic [         7:0] end_chain_num                       ,
    output logic [         7:0] start_chain_num                     ,
    output logic                world_align                         ,
    output logic                byte_twist                          ,
    output logic                bit_twist                           ,
    output logic [        31:0] chain_length      [CHAIN_LENGTH_NUM],
    output logic [        31:0] chains_length_map [CHAIN_LENGTH_NUM],
    output logic [        15:0] switch_chain_time                   ,
    input  logic                cfg_done                            ,
    input  logic                kickoff_clr                         ,
    input  logic [         1:0] fsm_state                           ,
    input  logic [        29:0] shift_count                         ,
    // write bitstream
    output logic                rg_bitstream_wdata_wreq             ,
    input  logic                wack_bitstream_wdata_i              ,
    // read bitstream
    output logic                rg_bitstream_rdata_rreq             ,
    input  logic [        31:0] bitstream_rdata_i                   ,
    input  logic                rack_bitstream_rdata_i              ,
    // status
    output logic                cfg_done_status
);
//*****************************************************************************
//              Declarations
//*****************************************************************************
logic [31:0] rg_rdat_mux  ;
logic [31:0] rg_rdat_mux_d;
logic [31:0] wstr_b       ;


logic rg_cfg_cmd_rreq;
logic rg_cfg_kickoff_rreq;
logic rg_cfg_done_rreq;
logic rg_chksum_word_rreq;
logic rg_chksum_status_rreq;
logic rg_soft_reset_rreq;
logic rg_cmd_control_rreq;
logic rg_op_config_rreq;
logic rg_shift_status_rreq;
logic rg_chain_length_rreq[CHAIN_LENGTH_NUM];
logic rg_chains_length_map_rreq[CHAIN_LENGTH_NUM];
logic rg_switch_chain_time_rreq;

logic rg_cfg_cmd_wreq;
logic rg_cfg_kickoff_wreq;
logic rg_cfg_done_wreq;
logic rg_chksum_word_wreq;
logic rg_soft_reset_wreq;
logic rg_cmd_control_wreq;
logic rg_op_config_wreq;
logic rg_shift_status_wreq;
logic rg_chain_length_wreq[CHAIN_LENGTH_NUM];
logic rg_chains_length_map_wreq[CHAIN_LENGTH_NUM];
logic rg_switch_chain_time_wreq;

logic [31:0] rg_cfg_cmd;
logic [31:0] rg_cfg_kickoff;
logic [31:0] rg_cfg_done;
logic [31:0] rg_chksum_word;
logic [31:0] rg_chksum_status;
logic [31:0] rg_soft_reset;
logic [31:0] rg_cmd_control;
logic [31:0] rg_op_config;
logic [31:0] rg_bitstream_wdata; 
logic [31:0] rg_bitstream_rdata;
logic [31:0] rg_shift_status;
logic [31:0] rg_chain_length[CHAIN_LENGTH_NUM];
logic [31:0] rg_chains_length_map[CHAIN_LENGTH_NUM];
logic [31:0] rg_switch_chain_time;

genvar n;

//*****************************************************************************
//              Registers Access logic
//*****************************************************************************
assign wstr_b = {
                {8{wstr_i[3]}},
                {8{wstr_i[2]}},
                {8{wstr_i[1]}},
                {8{wstr_i[0]}}
                };

//write req
assign rg_cfg_cmd_wreq               = wreq_i[0];
assign rg_cfg_kickoff_wreq           = wreq_i[1];
assign rg_cfg_done_wreq              = wreq_i[2];
assign rg_chksum_word_wreq           = wreq_i[3];
assign rg_soft_reset_wreq            = wreq_i[5];
assign rg_cmd_control_wreq           = wreq_i[6];
assign rg_op_config_wreq             = wreq_i[7];
assign rg_shift_status_wreq          = wreq_i[8];
assign rg_bitstream_wdata_wreq       = wreq_i[9];
assign rg_switch_chain_time_wreq     = wreq_i[11];

// read req
assign rg_cfg_cmd_rreq               = rreq_i[0];
assign rg_cfg_kickoff_rreq           = rreq_i[1];
assign rg_cfg_done_rreq              = rreq_i[2];
assign rg_chksum_word_rreq           = rreq_i[3];
assign rg_chksum_status_rreq         = rreq_i[4];
assign rg_soft_reset_rreq            = rreq_i[5];
assign rg_cmd_control_rreq           = wreq_i[6];
assign rg_op_config_rreq             = rreq_i[7];
assign rg_shift_status_rreq          = rreq_i[8];
assign rg_bitstream_rdata_rreq       = rreq_i[10];
assign rg_switch_chain_time_rreq     = rreq_i[11]; 

logic [31:0] rg_rdat_mux_length     [CHAIN_LENGTH_NUM];
logic        rg_rdat_mux_length_sel;
logic [31:0] rg_rdat_mux_length_mux    ;
logic [31:0] rg_rdat_mux_length_map [CHAIN_LENGTH_NUM];
logic        rg_rdat_mux_length_map_sel;
logic [31:0] rg_rdat_mux_length_map_mux;
 generate
    for(n = 0; n < CHAIN_LENGTH_NUM; n = n + 1) begin : gen_chains_wrreq
         assign rg_chain_length_wreq[n]       = wreq_i[12+n];
         assign rg_chain_length_rreq[n]       = rreq_i[12+n];


         assign rg_rdat_mux_length[n]     = rg_chain_length_rreq[n]      ? rg_chain_length[n] :'h0;


         assign rg_chains_length_map_wreq[n]  = wreq_i[12+CHAIN_LENGTH_NUM+n];
         assign rg_chains_length_map_rreq[n]  = rreq_i[12+CHAIN_LENGTH_NUM+n];


         assign rg_rdat_mux_length_map[n] = rg_chains_length_map_rreq[n] ? rg_chains_length_map[n] :'h0;

    end          
endgenerate

always_comb begin
    rg_rdat_mux_length_sel = 'h0;
    for(int id = 0; id < CHAIN_LENGTH_NUM; id = id + 1) begin
        rg_rdat_mux_length_sel = rg_rdat_mux_length_sel | rg_chain_length_rreq[id];
    end
end

always_comb begin
    rg_rdat_mux_length_mux = 'h0;
    for(int id = 0; id < CHAIN_LENGTH_NUM; id = id + 1) begin
        rg_rdat_mux_length_mux = rg_rdat_mux_length_mux | rg_rdat_mux_length[id];
    end
end

always_comb begin
    rg_rdat_mux_length_map_sel = 'h0;
    for(int id = 0; id < CHAIN_LENGTH_NUM; id = id + 1) begin
        rg_rdat_mux_length_map_sel = rg_rdat_mux_length_map_sel | rg_chains_length_map_rreq[id];
    end
end

always_comb begin
    rg_rdat_mux_length_map_mux = 'h0;
    for(int id = 0; id < CHAIN_LENGTH_NUM; id = id + 1) begin
        rg_rdat_mux_length_map_mux = rg_rdat_mux_length_map_mux | rg_rdat_mux_length_map[id];
    end
end


//read data
assign rg_rdat_mux = (rg_cfg_cmd_rreq              ) ? rg_cfg_cmd :
                     (rg_cfg_kickoff_rreq          ) ? rg_cfg_kickoff :
                     (rg_cfg_done_rreq             ) ? rg_cfg_done :
                     (rg_chksum_word_rreq          ) ? rg_chksum_word :
                     (rg_chksum_status_rreq        ) ? rg_chksum_status :
                     (rg_soft_reset_rreq           ) ? rg_soft_reset :
                     (rg_cmd_control_rreq          ) ? rg_cmd_control :
                     (rg_op_config_rreq            ) ? rg_op_config :
                     // (rg_bitstream_wdata_rreq      ) ? rg_bitstream_wdata :
                     (rg_bitstream_rdata_rreq      ) ? rg_bitstream_rdata :
                     (rg_shift_status_rreq         ) ? rg_shift_status :
                     (rg_switch_chain_time_rreq    ) ? rg_switch_chain_time :     
                     (rg_rdat_mux_length_sel       ) ? rg_rdat_mux_length_mux :
                     (rg_rdat_mux_length_map_sel   ) ? rg_rdat_mux_length_map_mux : 32'h0;



// assign rg_bitstream_wdata = bitstream_wdata_i; 
assign rg_bitstream_rdata = bitstream_rdata_i;                     

always @(posedge clk or negedge rst_n)
    if (!rst_n)       rg_rdat_mux_d <= 32'h0;
    else if (|rreq_i) rg_rdat_mux_d <= rg_rdat_mux;  

assign rdat_o = rg_rdat_mux_d;

always @ (posedge clk, negedge rst_n)
    if (!rst_n) rack_o <= 1'b0;
    else        rack_o <= (|rreq_i[8:0]) | (|rreq_i[REGS_NUM-1:11]) | rack_bitstream_rdata_i;


always @ (posedge clk, negedge rst_n)
    if (!rst_n) wack_o <= 1'b0;
    else        wack_o <= (|wreq_i[8:0]) | (|wreq_i[REGS_NUM-1:11]) | wack_bitstream_wdata_i;

assign rerr_o = rreq_i[9]; //WO register
assign werr_o = wreq_i[10]; //RO register
//*****************************************************************************
//              Register CFG_CMD
//              offset 0x0  
//  Location    Attribute   Field Name
//
//  [31:2]     Rsvd             
//  [1: 0]         R/W         cfg_cmd
//*****************************************************************************


assign rg_cfg_cmd = {
                         30'h0,
                         cfg_cmd
                         };      


always @(posedge clk or negedge rst_n)
    if (!rst_n)                           cfg_cmd  <= 'b0;
    else if (rg_cfg_cmd_wreq & wstr_b[1]) cfg_cmd  <= wdat_i[1:0];

//*****************************************************************************
//              Register CFG_KICKOFF
//              offset   
//  Location    Attribute   Field Name
//
//  [31:1]     Rsvd             
//  [   0]     R/W         cfg_kickoff
//*****************************************************************************


assign rg_cfg_kickoff = {
                         31'h0,
                         cfg_kickoff
                         };      


always @(posedge clk or negedge rst_n)
    if (!rst_n)                               cfg_kickoff  <= 'b0;
    else if (rg_cfg_kickoff_wreq & wstr_b[0]) cfg_kickoff  <= wdat_i[0];
    else if (kickoff_clr)                     cfg_kickoff  <= 'b0;


//*****************************************************************************
//              Register CFG_DONE
//              offset   
//  Location    Attribute   Field Name
//
//  [31:1]     Rsvd             
//  [   0]     R/O         cfg_done
//*****************************************************************************

assign rg_cfg_done = {
                         31'h0,
                         cfg_done_status
                         };      

always @(posedge clk or negedge rst_n)
    if (!rst_n)                               cfg_done_status  <= 'b0;
    else if (rg_chksum_word_wreq & wstr_b[0]) cfg_done_status  <= wdat_i[0];
    else if (cfg_done)                        cfg_done_status <= 1'b1;
    else if (rg_cfg_kickoff_wreq & wstr_b[0]) cfg_done_status <= 1'b0;

//*****************************************************************************
//              Register CHKSUM_WORD
//              offset   
//  Location    Attribute   Field Name
//
//  [31:0]     R/W         chksum_word
//*****************************************************************************


assign rg_chksum_word = {
                         chksum_word
                         };      


always @(posedge clk or negedge rst_n)
    if (!rst_n)                                chksum_word  <= 'b0;
    else if (rg_chksum_word_wreq & wstr_b[31]) chksum_word  <= wdat_i[31:0];

//*****************************************************************************
//              Register CHKSUM_STATUS
//              offset   
//  Location    Attribute   Field Name
//
//  [31:1]     Rsvd             
//  [   0]     R/O         chksum_status
//*****************************************************************************


assign rg_chksum_status = {
                         31'h0,
                         chksum_status
                         };      


//*****************************************************************************
//              Register SOFT_RESET
//              offset   
//  Location    Attribute   Field Name
//
//  [31:1]     Rsvd             
//  [   0]     R/W         soft_reset
//*****************************************************************************


assign rg_soft_reset = {
                         31'h0,
                         soft_reset
                         };      


always @(posedge clk or negedge rst_n)
    if (!rst_n)                              soft_reset  <= 'b0;
    else if (rg_soft_reset_wreq & wstr_b[0]) soft_reset  <= wdat_i[0];

//*****************************************************************************
//              Register CMD_CONTROL
//              offset   
//  Location    Attribute   Field Name
//
//  [31:1]     Rsvd             
//  [   0]     R/W         cmd_control
//*****************************************************************************


assign rg_cmd_control = {
                         31'h0,
                         cmd_control
                         };      


always @(posedge clk or negedge rst_n)
    if (!rst_n)                               cmd_control  <= 'b0;
    else if (rg_cmd_control_wreq & wstr_b[0]) cmd_control  <= wdat_i[0];

//*****************************************************************************
//              Register OP_CONFIG
//              offset   
//  Location    Attribute   Field Name
//
//  [31:24]     R/W         end_chain_num
//  [23:16]     R/W         start_chain_num
//  [15: 9]     Rsvd             
//  [    8]     R/W         world_align
//  [ 7: 5]     Rsvd             
//  [    4]     R/W         byte_twist
//  [ 3: 1]     Rsvd             
//  [    0]     R/W         bit_twist
//*****************************************************************************


assign rg_op_config = {
                         end_chain_num,
                         start_chain_num,
                         7'b0,
                         world_align,
                         3'b0,
                         byte_twist,
                         3'b0,
                         bit_twist
                         };      


always @(posedge clk or negedge rst_n)
    if (!rst_n)                             end_chain_num  <= 'b0;
    else if (rg_op_config_wreq & wstr_b[31]) end_chain_num  <= wdat_i[31:24];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             start_chain_num  <= 'b0;
    else if (rg_op_config_wreq & wstr_b[23]) start_chain_num  <= wdat_i[23:16];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             world_align  <= 'b0;
    else if (rg_op_config_wreq & wstr_b[8])  world_align  <= wdat_i[8];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             byte_twist  <= 'b0;
    else if (rg_op_config_wreq & wstr_b[4])  byte_twist  <= wdat_i[4];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             bit_twist  <= 'b0;
    else if (rg_op_config_wreq & wstr_b[0])  bit_twist  <= wdat_i[0];

//*****************************************************************************
//              Register SHIFT_STATUS
//              offset   
//  Location    Attribute   Field Name
//
//  [31:30]     R/O         fsm_state
//  [29: 0]     R/O         shift_count
//*****************************************************************************


assign rg_shift_status = {fsm_state,
                         shift_count
                         };      


// always @(posedge clk or negedge rst_n)
//     if (!rst_n)                                fsm_state  <= 'b0;
//     else if (rg_shift_status_wreq & wstr_b[31]) fsm_state  <= wdat_i[31:30];

// always @(posedge clk or negedge rst_n)
//     if (!rst_n)                                shift_count  <= 'b0;
//     else if (rg_shift_status_wreq & wstr_b[29]) shift_count  <= wdat_i[29:0];


//*****************************************************************************
//              Register SWITCH_CHAIN_TIME
//              offset   
//  Location    Attribute   Field Name
//
//  [31:16]     Rsvd             
//  [15: 0]     R/W         switch_chain_time
//*****************************************************************************


assign rg_switch_chain_time = {
                         16'h0,
                         switch_chain_time
                         };      


always @(posedge clk or negedge rst_n)
    if (!rst_n)                                      switch_chain_time  <= 'h4;
    else if (rg_switch_chain_time_wreq & wstr_b[15]) switch_chain_time  <= wdat_i[15:0];

//*****************************************************************************
//              Register CHAIN_LENGTH
//              offset   0x28+n*0x4, n = 0...15
//  Location    Attribute   Field Name
//
//  [31:0]     R/W         chain_length
//*****************************************************************************


generate
    for(n = 0; n < CHAIN_LENGTH_NUM; n = n + 1) begin : gen_chains_length_regs
        assign rg_chain_length[n] = {chain_length[n]};  

        always @(posedge clk or negedge rst_n)
            if (!rst_n)                                       chain_length[n]  <= 'h0;
            else if (rg_chain_length_wreq[n] & wstr_b[31]) chain_length[n]  <= wdat_i[31:0]; 
    end          
endgenerate

//*****************************************************************************
//              Register CHAIN_LENGTH
//              offset   0x28+n*0x4, n = 0...15
//  Location    Attribute   Field Name
//
//  [31:0]     R/W         chain_length
//*****************************************************************************


 generate
    for(n = 0; n < CHAIN_LENGTH_NUM; n = n + 1) begin : gen_chains_sel_regs
        assign rg_chains_length_map[n] = {
                                             chains_length_map[n]
                                             };  

        always @(posedge clk or negedge rst_n)
            if (!rst_n)                                            chains_length_map[n]  <= 'h0;
            else if (rg_chains_length_map_wreq[n] & wstr_b[31]) chains_length_map[n]  <= wdat_i[31:0];   
    end          
endgenerate



endmodule