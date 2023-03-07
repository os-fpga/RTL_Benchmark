module cfg_top #(
  parameter REGS_NUM         = 5  ,
  parameter DWIDTH           = 32 ,
  parameter CHAIN_NUM        = 128,
  parameter CHAIN_LENGTH_NUM = 16
) (
  input  logic                clk                    ,
  input  logic                rst_n                  ,
  // read apb_manager
  output logic                rack_o                 ,
  output logic                rerr_o                 ,
  output logic [  DWIDTH-1:0] rdat_o                 ,
  input  logic [REGS_NUM-1:0] rreq_i                 ,
  // write apb_manager
  output logic                wack_o                 ,
  output logic                werr_o                 ,
  input  logic [  DWIDTH-1:0] wdat_i                 ,
  input  logic [REGS_NUM-1:0] wreq_i                 ,
  input  logic [DWIDTH/8-1:0] wstr_i                 ,
  //status
  output logic                cfg_status_o           ,
  // ccff interface
  output logic                ccff_clk_o  [CHAIN_NUM],
  output logic                ccff_data_o [CHAIN_NUM],
  output logic                ccff_cmd_o  [CHAIN_NUM],
  input  logic                ccff_clk_i  [CHAIN_NUM],
  input  logic                ccff_data_i [CHAIN_NUM],
  output logic                ccff_rst_n
);
  


    logic [ 1:0] cfg_cmd                               ;
    logic        cfg_kickoff                           ;
    logic [31:0] chksum_word                           ;
    logic        chksum_status                         ;
    logic        soft_reset                            ;
    logic [ 7:0] end_chain_num                         ;
    logic [ 7:0] start_chain_num                       ;
    logic        world_align                           ;
    logic        byte_twist                            ;
    logic        bit_twist                             ;
    logic [31:0] chain_length        [CHAIN_LENGTH_NUM];
    logic [31:0] chains_length_map   [CHAIN_LENGTH_NUM];
    logic        cfg_done                              ;
    logic        kickoff_clr                           ;
    logic [ 1:0] fsm_state                             ;
    logic [29:0] shift_count                           ;
    logic        wreq_bitstream_wdata                  ;
    logic        wack_bitstream_wdata                  ;
    logic        rreq_bitstream_rdata                  ;
    logic [31:0] bitstream_rdata                       ;
    logic        rack_bitstream_rdata                  ;
    logic [15:0] switch_chain_time                     ;

  cfg_regs #(
    .REGS_NUM        (REGS_NUM        ),
    .DWIDTH          (DWIDTH          ),
    .CHAIN_LENGTH_NUM(CHAIN_LENGTH_NUM)
  ) cfg_regs (
    .clk                    (clk                 ),
    .rst_n                  (rst_n               ),
    .rack_o                 (rack_o              ),
    .rerr_o                 (rerr_o              ),
    .rdat_o                 (rdat_o              ),
    .rreq_i                 (rreq_i              ),
    .wack_o                 (wack_o              ),
    .werr_o                 (werr_o              ),
    .wdat_i                 (wdat_i              ),
    .wreq_i                 (wreq_i              ),
    .wstr_i                 (wstr_i              ),
    .cfg_cmd                (cfg_cmd             ),
    .cfg_kickoff            (cfg_kickoff         ),
    .chksum_word            (chksum_word         ),
    .chksum_status          (chksum_status       ),
    .soft_reset             (soft_reset          ),
    .cmd_control            (cmd_control         ),
    .end_chain_num          (end_chain_num       ),
    .start_chain_num        (start_chain_num     ),
    .world_align            (world_align         ),
    .byte_twist             (byte_twist          ),
    .bit_twist              (bit_twist           ),
    .chain_length           (chain_length        ),
    .chains_length_map      (chains_length_map   ),
    .switch_chain_time      (switch_chain_time   ),
    .cfg_done               (cfg_done            ),
    .kickoff_clr            (kickoff_clr         ),
    .fsm_state              (fsm_state           ),
    .shift_count            (shift_count         ),
    .rg_bitstream_wdata_wreq(wreq_bitstream_wdata),
    .wack_bitstream_wdata_i (wack_bitstream_wdata),
    .rg_bitstream_rdata_rreq(rreq_bitstream_rdata),
    .bitstream_rdata_i      (bitstream_rdata     ),
    .rack_bitstream_rdata_i (rack_bitstream_rdata),
    .cfg_done_status        (cfg_status_o        )
  );


  cfg_block_engine #(
    .CHAIN_NUM       (CHAIN_NUM       ),
    .CHAIN_LENGTH_NUM(CHAIN_LENGTH_NUM),
    .REGS_NUM        (REGS_NUM        ),
    .DWIDTH          (DWIDTH          )
  ) cfg_block_engine (
    .clk                (clk                 ),
    .rst_n              (rst_n               ),
    .cfg_cmd_i          (cfg_cmd             ),
    .kickoff_i          (cfg_kickoff         ),
    .chksum_i           (chksum_word         ),
    .soft_reset_i       (soft_reset          ),
    .end_chain_num_i    (end_chain_num       ),
    .start_chain_num_i  (start_chain_num     ),
    .world_align_i      (world_align         ),
    .byte_twist_i       (byte_twist          ),
    .bit_twist_i        (bit_twist           ),
    .chain_length_i     (chain_length        ),
    .chains_length_map_i(chains_length_map   ),
    .cmd_control_i      (cmd_control         ),
    .switch_chain_time_i(switch_chain_time   ),
    .chksum_status_o    (chksum_status       ),
    .fsm_state_o        (fsm_state           ),
    .shift_count_o      (shift_count         ),
    .clr_kickoff_o      (kickoff_clr         ),
    .bitstream_wack_o   (wack_bitstream_wdata),
    .bitstream_wdata_i  (wdat_i              ),
    .bitstream_wreq_i   (wreq_bitstream_wdata),
    .bitstream_rdata_o  (bitstream_rdata     ),
    .bitstream_rack_o   (rack_bitstream_rdata),
    .bitstream_rreq_i   (rreq_bitstream_rdata),
    .cfg_done_o         (cfg_done            ),
    .ready              (ready               ),
    .ccff_clk_o         (ccff_clk_o          ),
    .ccff_data_o        (ccff_data_o         ),
    .ccff_cmd_o         (ccff_cmd_o          ),
    .ccff_clk_i         (ccff_clk_i          ),
    .ccff_data_i        (ccff_data_i         ),
    .ccff_rst_n         (ccff_rst_n          )
  );


endmodule                       