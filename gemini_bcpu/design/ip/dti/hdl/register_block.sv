
module register_block (uci_cmd_op , uci_cmd_chan , uci_cmd_rank , uci_mr_sel , uci_mrs_last , uci_mpr_data , dmctl_ddrt , dmctl_dfi_freq_ratio , dmctl_dram_bank_en , dmctl_switch_close , dmctl_bank_policy , dmctl_wr_dbi , dmctl_rd_dbi , dmctl_dual_chan_en , dmctl_dual_rank_en , dmctl_rd_req_min , dmctl_wr_req_min , dmctl_wr_crc , dmctl_chan_unlock , dmctl_hi_pri_imm , dmcfg_ref_post_pull_en , dmcfg_auto_srx_zqcl , dmcfg_ref_int_en , dmcfg_req_th , dmcfg_zq_auto_en , dmcfg_ref_otf , dmcfg_dqs2cken , lpddr4_lpmr1_fs0_wpre , lpddr4_lpmr1_fs0_rpre , lpddr4_lpmr1_fs1_wpre , lpddr4_lpmr1_fs1_rpre , lpddr4_lpmr12_fs0_vrefcas , lpddr4_lpmr12_fs0_vrefcar , lpddr4_lpmr12_fs1_vrefcas , lpddr4_lpmr12_fs1_vrefcar , lpddr4_lpmr14_fs0_vrefdqs , lpddr4_lpmr14_fs0_vrefdqr , lpddr4_lpmr14_fs1_vrefdqs , lpddr4_lpmr14_fs1_vrefdqr , ddr4_mr2_wrcrc , ddr4_mr4_cal , ddr4_mr4_rpre , ddr4_mr4_wpre , ddr4_mr6_vrefdq , ddr4_mr6_vrefdqr , ddr4_mr6_ccdl , phy_dti_dram_clk_dis , phy_dti_data_byte_dis , pom_chanen , pom_dfien , pom_proc , pom_physeten , pom_phyfsen , pom_phyinit , pom_dllrsten , pom_draminiten , pom_vrefdqrden , pom_vrefcaen , pom_gten , pom_wrlvlen , pom_rdlvlen , pom_vrefdqwren , pom_dlyevalen , pom_sanchken , pom_fs , pom_clklocken , pom_cmddlyen , pom_odt , pom_dqsdqen , pom_ranken , rtgc0_gt_updt , rtgc0_gt_dis , rtgc0_fs0_twren , rtgc0_fs0_trden , rtgc0_fs0_trdendbi , rtgc1_fs1_twren , rtgc1_fs1_trden , rtgc1_fs1_trdendbi , ptar_ba , ptar_row , ptar_col , vtgc_ivrefr , vtgc_ivrefts , vtgc_vrefdqsw , vtgc_vrefcasw , vtgc_ivrefen , pbcr_bist_en , pbcr_bist_start , pbcr_lp_en , pccr_srst , pccr_tpaden , pccr_mvg , pccr_en , pccr_upd , pccr_bypen , pccr_byp_n , pccr_byp_p , pccr_initcnt , dqsdqcr_dlyoffs , dqsdqcr_dqsel , dqsdqcr_mupd , dqsdqcr_mpcrpt , dqsdqcr_dlymax , dqsdqcr_dir , dqsdqcr_rank , calvlpa0_pattern_a , calvlpa1_pattern_b , adft_tst_en_ca , adft_tst_en_dq , outbypen0_clk , outbypen0_dm , outbypen0_dqs , outbypen1_dq , outbypen2_ctl , outd0_clk , outd0_dm , outd0_dqs , outd1_dq , outd2_ctl , dvstt1_dfi_freq_ratio , pos_physetc , pos_phyfsc , pos_phyinitc , pos_dllrstc , pos_draminitc , pos_vrefdqrdc , pos_vrefcac , pos_gtc , pos_wrlvlc , pos_rdlvlc , pos_vrefdqwrc , pos_dlyevalc , pos_sanchkc , pos_ofs , pos_fs0req , pos_fs1req , pos_clklockc , pos_cmddlyc , pos_dqsdqc , dllsttca_lock , dllsttca_ovfl , dllsttca_unfl , dllsttdq_lock , dllsttdq_ovfl , dllsttdq_unfl , pbsr_bist_done , pbsr_bist_err_ctl , pbsr1_bist_err_dq , pbsr2_bist_err_dm , pcsr_srstc , pcsr_updc , pcsr_nbc , pcsr_pbc , rtcfg_ext_pri_rt , rtcfg_max_pri_rt , rtcfg_arq_lvl_hi_rt , rtcfg_arq_lvl_lo_rt , rtcfg_awq_lvl_hi_rt , rtcfg_awq_lvl_lo_rt , rtcfg_arq_lat_barrier_en_rt , rtcfg_awq_lat_barrier_en_rt , rtcfg_arq_ooo_en_rt , rtcfg_awq_ooo_en_rt , rtcfg_acq_realtime_en_rt , rtcfg_wm_enable_rt , rtcfg_arq_lahead_en_rt , rtcfg_awq_lahead_en_rt , rtcfg_narrow_mode_rt , rtcfg_narrow_size_rt , rtcfg_arq_lat_barrier_rt , rtcfg_awq_lat_barrier_rt , rtcfg_arq_starv_th_rt , rtcfg_awq_starv_th_rt , rtcfg_size_max_rt , addr_cfg , dllctlca_limit , dllctlca_en , dllctlca_upd , dllctlca_byp , dllctlca_bypc , dllctlca_clkdly , dllctldq_limit , dllctldq_en , dllctldq_upd , dllctldq_byp , dllctldq_bypc , pbcr_vrefenca , pbcr_vrefsetca , cior_drvsel , cior_cmos_en , cior_odis_clk , cior_odis_ctl , dior_drvsel , dior_cmos_en , dior_fena_rcv , dior_rtt_en , dior_rtt_sel , dior_odis_dq , dior_odis_dm , dior_odis_dqs , ptsr_vrefcar , ptsr_vrefcar_ip , ptsr_vrefcas , ptsr_vrefcas_ip , ptsr_vrefdqwrr , ptsr_vrefdqwrr_ip , ptsr_vrefdqwrs , ptsr_vrefdqwrs_ip , ptsr_cs , ptsr_cs_ip , ptsr_ca , ptsr_ca_ip , ptsr_ba , ptsr_actn , ptsr_cke , ptsr_gt , ptsr_gt_ip , ptsr_wrlvl , ptsr_wrlvl_ip , ptsr_dqsdq , ptsr_dqsdq_ip , ptsr_dqsdm , ptsr_dqsdm_ip , ptsr_rdlvldq , ptsr_rdlvldq_ip , ptsr_rdlvldm , ptsr_rdlvldm_ip , ptsr_vrefdqrd , ptsr_vrefdqrd_ip , ptsr_vrefdqrdr , ptsr_vrefdqrdr_ip , ptsr_psck , ptsr_psck_ip , ptsr_dqsleadck , ptsr_dqsleadck_ip , ptsr_sanpat , ptsr_odt , ptsr_rstn , ptsr_nt_rank , ptsr_nt_rank_ip , reg_t_alrtp_rb , reg_t_ckesr_rb , reg_t_ccd_s_rb , reg_t_faw_rb , reg_t_rtw_rb , reg_t_rcd_rb , reg_t_rdpden_rb , reg_t_rc_rb , reg_t_ras_rb , reg_t_pd_rb , reg_t_rp_rb , reg_t_wlbr_rb , reg_t_wrapden_rb , reg_t_cke_rb , reg_t_xp_rb , reg_t_vreftimelong_rb , reg_t_vreftimeshort_rb , reg_t_mrd_rb , reg_t_zqcs_itv_rb , reg_t_pori_rb , reg_t_zqinit_rb , reg_t_mrs2lvlen_rb , reg_t_zqcs_rb , reg_t_xpdll_rb , reg_t_wlbtr_rb , reg_t_rrd_s_rb , reg_t_rfc1_rb , reg_t_mrs2act_rb , reg_t_lvlaa_rb , reg_t_dllk_rb , reg_t_refi_off_rb , reg_t_mprr_rb , reg_t_xpr_rb , reg_t_dllrst_rb , reg_t_rst_rb , reg_t_odth4_rb , reg_t_odth8_rb , reg_t_lvlload_rb , reg_t_lvldll_rb , reg_t_lvlresp_rb , reg_t_xs_rb , reg_t_mod_rb , reg_t_dpd_rb , reg_t_mrw_rb , reg_t_wr2rd_rb , reg_t_mrr_rb , reg_t_zqrs_rb , reg_t_dqscke_rb , reg_t_xsr_rb , reg_t_mped_rb , reg_t_mpx_rb , reg_t_wr_mpr_rb , reg_t_init5_rb , reg_t_setgear_rb , reg_t_syncgear_rb , reg_t_dlllock_rb , reg_t_wlbtr_s_rb , reg_t_read_low_rb , reg_t_read_high_rb , reg_t_write_low_rb , reg_t_write_high_rb , reg_t_rfc2_rb , reg_t_rfc4_rb , reg_t_wlbr_crcdm_rb , reg_t_wlbtr_crcdm_l_rb , reg_t_wlbtr_crcdm_s_rb , reg_t_xmpdll_rb , reg_t_wrmpr_rb , reg_t_lvlexit_rb , reg_t_lvldis_rb , reg_t_zqoper_rb , reg_t_rfc_rb , reg_t_xsdll_rb , reg_odtlon_rb , reg_odtloff_rb , reg_t_wlmrd_rb , reg_t_wldqsen_rb , reg_t_wtr_rb , reg_t_rda2pd_rb , reg_t_wra2pd_rb , reg_t_zqcl_rb , reg_t_calvl_adr_ckeh_rb , reg_t_calvl_capture_rb , reg_t_calvl_cc_rb , reg_t_calvl_en_rb , reg_t_calvl_ext_rb , reg_t_calvl_max_rb , reg_t_ckehdqs_rb , reg_t_ccd_rb , reg_t_zqlat_rb , reg_t_ckckeh_rb , reg_t_rrd_rb , reg_t_caent_rb , reg_t_cmdcke_rb , reg_t_mpcwr_rb , reg_t_dqrpt_rb , reg_t_zq_itv_rb , reg_t_ckelck_rb , reg_t_dllen_rb , reg_t_init3_rb , reg_t_dtrain_rb , reg_t_mpcwr2rd_rb , reg_t_fc_rb , reg_t_refi_rb , reg_t_vrcgen_rb , reg_t_vrcgdis_rb , reg_t_odtup_rb , reg_t_ccdwm_rb , reg_t_osco_rb , reg_t_ckfspe_rb , reg_t_ckfspx_rb , reg_t_init1_rb , reg_t_zqcal_rb , reg_t_lvlresp_nr_rb , reg_t_ppd_rb , bistcfg_start_rank_ch , bistcfg_end_rank_ch , bistcfg_start_bank_ch , bistcfg_end_bank_ch , bistcfg_start_background_ch , bistcfg_end_background_ch , bistcfg_element_ch , bistcfg_operation_ch , bistcfg_retention_ch , bistcfg_diagnosis_en_ch , biststaddr_start_row_ch , biststaddr_start_col_ch , bistedaddr_end_row_ch , bistedaddr_end_col_ch , bistm0_march_element_0_ch , bistm1_march_element_1_ch , bistm2_march_element_2_ch , bistm3_march_element_3_ch , bistm4_march_element_4_ch , bistm5_march_element_5_ch , bistm6_march_element_6_ch , bistm7_march_element_7_ch , bistm8_march_element_8_ch , bistm9_march_element_9_ch , bistm10_march_element_10_ch , bistm11_march_element_11_ch , bistm12_march_element_12_ch , bistm13_march_element_13_ch , bistm14_march_element_14_ch , bistm15_march_element_15_ch , status_dram_pause_ch , status_user_cmd_ready_ch , status_bank_idle_ch , status_xqr_empty_ch , status_xqr_full_ch , status_xqw_empty_ch , status_xqw_full_ch , status_int_gc_fsm_ch , status_bist_error_ch , status_bist_endtest_ch , status_bist_error_new_ch , status_bist_rank_fail_ch , status_bist_bank_fail_ch , status_bist_row_fail_ch , pts_vrefdqrderr , pts_vrefcaerr , pts_gterr , pts_wrlvlerr , pts_vrefdqwrerr , pts_rdlvldmerr , pts_dllerr , pts_lp3calvlerr , pts_sanchkerr , pts_dqsdmerr , pts_rdlvldqerr , pts_dqsdqerr , mpr_done_ch , mpr_readout_ch , mrr_done_ch , mrr_readout_ch , shad_reg_lpmr1_fs0 , shad_reg_lpmr1_fs1 , shad_reg_lpmr2_fs0 , shad_reg_lpmr2_fs1 , shad_reg_lpmr3_fs0 , shad_reg_lpmr3_fs1 , shad_reg_lpmr11_fs0 , shad_reg_lpmr11_fs1 , shad_reg_lpmr11_nt_fs0 , shad_reg_lpmr11_nt_fs1 , shad_reg_lpmr12_fs0 , shad_reg_lpmr12_fs1 , shad_reg_lpmr13 , shad_reg_lpmr14_fs0 , shad_reg_lpmr14_fs1 , shad_reg_lpmr22_fs0 , shad_reg_lpmr22_fs1 , shad_reg_lpmr22_nt_fs0 , shad_reg_lpmr22_nt_fs1 , data_rddata , int_gc_fsm_ch , reg_ddr4_mr0 , reg_ddr4_mr1 , reg_ddr4_mr2 , reg_ddr4_mr3 , reg_ddr4_mr4 , reg_ddr4_mr5 , reg_ddr4_mr6 , reg_ddr3_mr0 , reg_ddr3_mr1 , reg_ddr3_mr2 , reg_ddr3_mr3 , reg_lpddr4_lpmr13 , reg_lpddr4_lpmr16 , reg_lpddr4_lpmr1_fs0 , reg_lpddr4_lpmr1_fs1 , reg_lpddr4_lpmr2_fs0 , reg_lpddr4_lpmr2_fs1 , reg_lpddr4_lpmr3_fs0 , reg_lpddr4_lpmr3_fs1 , reg_lpddr4_lpmr11_fs0 , reg_lpddr4_lpmr11_fs1 , reg_lpddr4_lpmr11_nt_fs0 , reg_lpddr4_lpmr11_nt_fs1 , reg_lpddr4_lpmr12_fs0 , reg_lpddr4_lpmr12_fs1 , reg_lpddr4_lpmr14_fs0 , reg_lpddr4_lpmr14_fs1 , reg_lpddr4_lpmr22_fs0 , reg_lpddr4_lpmr22_fs1 , reg_lpddr4_lpmr22_nt_fs0 , reg_lpddr4_lpmr22_nt_fs1 , reg_lpddr3_lpmr1 , reg_lpddr3_lpmr2 , reg_lpddr3_lpmr3 , reg_lpddr3_lpmr10 , reg_lpddr3_lpmr11 , reg_lpddr3_lpmr16 , reg_lpddr3_lpmr17 , ddr4_mr4_t_cal , dram_crc_dm , dram_bl_enc , reg_ddr4_enable , reg_ddr3_enable , reg_lpddr4_enable , reg_lpddr3_enable , axi4lite_arvalid , axi4lite_araddr , axi4lite_arready , axi4lite_rready , axi4lite_rvalid , axi4lite_rdata , axi4lite_rresp , axi4lite_awvalid , axi4lite_awaddr , axi4lite_awready , axi4lite_wvalid , axi4lite_wdata , axi4lite_wready , axi4lite_bready , axi4lite_bvalid , axi4lite_bresp , clk , reset_n , ptsr_upd , mupd_dqsdqcr_clr , user_cmd_wait_done_ch , mpr_access_enable , mpr_rd_n_wr , mrr_enable , rddata_upd , user_cmd_valid , reg_phy_init_done);
output reg  [4:0] uci_cmd_op ;
output reg  [1:0] uci_cmd_chan ;
output reg  [1:0] uci_cmd_rank ;
output reg  [5:0] uci_mr_sel ;
output reg   uci_mrs_last ;
output reg  [7:0] uci_mpr_data ;
output reg  [2:0] dmctl_ddrt ;
output reg  [1:0] dmctl_dfi_freq_ratio ;
output reg  [2:0] dmctl_dram_bank_en ;
output reg   dmctl_switch_close ;
output reg   dmctl_bank_policy ;
output reg   dmctl_wr_dbi ;
output reg   dmctl_rd_dbi ;
output reg   dmctl_dual_chan_en ;
output reg   dmctl_dual_rank_en ;
output reg  [6:0] dmctl_rd_req_min ;
output reg  [7:0] dmctl_wr_req_min ;
output reg   dmctl_wr_crc ;
output reg   dmctl_chan_unlock ;
output reg   dmctl_hi_pri_imm ;
output reg   dmcfg_ref_post_pull_en ;
output reg   dmcfg_auto_srx_zqcl ;
output reg   dmcfg_ref_int_en ;
output reg  [2:0] dmcfg_req_th ;
output reg   dmcfg_zq_auto_en ;
output reg   dmcfg_ref_otf ;
output reg   dmcfg_dqs2cken ;
output reg   lpddr4_lpmr1_fs0_wpre ;
output reg   lpddr4_lpmr1_fs0_rpre ;
output reg   lpddr4_lpmr1_fs1_wpre ;
output reg   lpddr4_lpmr1_fs1_rpre ;
output reg  [5:0] lpddr4_lpmr12_fs0_vrefcas ;
output reg   lpddr4_lpmr12_fs0_vrefcar ;
output reg  [5:0] lpddr4_lpmr12_fs1_vrefcas ;
output reg   lpddr4_lpmr12_fs1_vrefcar ;
output reg  [5:0] lpddr4_lpmr14_fs0_vrefdqs ;
output reg   lpddr4_lpmr14_fs0_vrefdqr ;
output reg  [5:0] lpddr4_lpmr14_fs1_vrefdqs ;
output reg   lpddr4_lpmr14_fs1_vrefdqr ;
output reg   ddr4_mr2_wrcrc ;
output reg  [2:0] ddr4_mr4_cal ;
output reg   ddr4_mr4_rpre ;
output reg   ddr4_mr4_wpre ;
output reg  [5:0] ddr4_mr6_vrefdq ;
output reg   ddr4_mr6_vrefdqr ;
output reg  [2:0] ddr4_mr6_ccdl ;
output reg   phy_dti_dram_clk_dis ;
output reg  [3:0] phy_dti_data_byte_dis ;
output reg  [1:0] pom_chanen ;
output reg   pom_dfien ;
output reg   pom_proc ;
output reg   pom_physeten ;
output reg   pom_phyfsen ;
output reg   pom_phyinit ;
output reg   pom_dllrsten ;
output reg   pom_draminiten ;
output reg   pom_vrefdqrden ;
output reg   pom_vrefcaen ;
output reg   pom_gten ;
output reg   pom_wrlvlen ;
output reg   pom_rdlvlen ;
output reg   pom_vrefdqwren ;
output reg   pom_dlyevalen ;
output reg   pom_sanchken ;
output reg   pom_fs ;
output reg   pom_clklocken ;
output reg   pom_cmddlyen ;
output reg   pom_odt ;
output reg   pom_dqsdqen ;
output reg  [1:0] pom_ranken ;
output reg   rtgc0_gt_updt ;
output reg   rtgc0_gt_dis ;
output reg  [5:0] rtgc0_fs0_twren ;
output reg  [5:0] rtgc0_fs0_trden ;
output reg  [6:0] rtgc0_fs0_trdendbi ;
output reg  [5:0] rtgc1_fs1_twren ;
output reg  [5:0] rtgc1_fs1_trden ;
output reg  [6:0] rtgc1_fs1_trdendbi ;
output reg  [3:0] ptar_ba ;
output reg  [16:0] ptar_row ;
output reg  [10:0] ptar_col ;
output reg   vtgc_ivrefr ;
output reg  [7:0] vtgc_ivrefts ;
output reg  [5:0] vtgc_vrefdqsw ;
output reg  [5:0] vtgc_vrefcasw ;
output reg   vtgc_ivrefen ;
output reg   pbcr_bist_en ;
output reg   pbcr_bist_start ;
output reg   pbcr_lp_en ;
output reg   pccr_srst ;
output reg   pccr_tpaden ;
output reg   pccr_mvg ;
output reg   pccr_en ;
output reg   pccr_upd ;
output reg   pccr_bypen ;
output reg  [3:0] pccr_byp_n ;
output reg  [3:0] pccr_byp_p ;
output reg  [10:0] pccr_initcnt ;
output reg  [7:0] dqsdqcr_dlyoffs ;
output reg  [3:0] dqsdqcr_dqsel ;
output reg   dqsdqcr_mupd ;
output reg  [2:0] dqsdqcr_mpcrpt ;
output reg  [7:0] dqsdqcr_dlymax ;
output reg   dqsdqcr_dir ;
output reg  [1:0] dqsdqcr_rank ;
output reg  [19:0] calvlpa0_pattern_a ;
output reg  [19:0] calvlpa1_pattern_b ;
output reg  [1:0] adft_tst_en_ca ;
output reg  [3:0] adft_tst_en_dq ;
output reg  [1:0] outbypen0_clk ;
output reg  [3:0] outbypen0_dm ;
output reg  [3:0] outbypen0_dqs ;
output reg  [31:0] outbypen1_dq ;
output reg  [29:0] outbypen2_ctl ;
output reg  [1:0] outd0_clk ;
output reg  [3:0] outd0_dm ;
output reg  [3:0] outd0_dqs ;
output reg  [31:0] outd1_dq ;
output reg  [29:0] outd2_ctl ;
output reg  [1:0] dvstt1_dfi_freq_ratio ;
input   pos_physetc ;
input   pos_phyfsc ;
input   pos_phyinitc ;
input   pos_dllrstc ;
input   pos_draminitc ;
input   pos_vrefdqrdc ;
input   pos_vrefcac ;
input  [1:0] pos_gtc ;
input  [1:0] pos_wrlvlc ;
input  [1:0] pos_rdlvlc ;
input  [1:0] pos_vrefdqwrc ;
input  [1:0] pos_dlyevalc ;
input  [1:0] pos_sanchkc ;
input   pos_ofs ;
input   pos_fs0req ;
input   pos_fs1req ;
input   pos_clklockc ;
input   pos_cmddlyc ;
input  [1:0] pos_dqsdqc ;
input  [1:0] dllsttca_lock ;
input  [1:0] dllsttca_ovfl ;
input  [1:0] dllsttca_unfl ;
input  [3:0] dllsttdq_lock ;
input  [3:0] dllsttdq_ovfl ;
input  [3:0] dllsttdq_unfl ;
input   pbsr_bist_done ;
input  [29:0] pbsr_bist_err_ctl ;
input  [31:0] pbsr1_bist_err_dq ;
input  [3:0] pbsr2_bist_err_dm ;
input   pcsr_srstc ;
input   pcsr_updc ;
input  [3:0] pcsr_nbc ;
input  [3:0] pcsr_pbc ;
output reg  [3:0] rtcfg_ext_pri_rt ;
output reg  [3:0] rtcfg_max_pri_rt ;
output reg  [15:0] rtcfg_arq_lvl_hi_rt ;
output reg  [15:0] rtcfg_arq_lvl_lo_rt ;
output reg  [15:0] rtcfg_awq_lvl_hi_rt ;
output reg  [15:0] rtcfg_awq_lvl_lo_rt ;
output reg  [3:0] rtcfg_arq_lat_barrier_en_rt ;
output reg  [3:0] rtcfg_awq_lat_barrier_en_rt ;
output reg  [3:0] rtcfg_arq_ooo_en_rt ;
output reg  [3:0] rtcfg_awq_ooo_en_rt ;
output reg  [3:0] rtcfg_acq_realtime_en_rt ;
output reg  [3:0] rtcfg_wm_enable_rt ;
output reg  [3:0] rtcfg_arq_lahead_en_rt ;
output reg  [3:0] rtcfg_awq_lahead_en_rt ;
output reg  [3:0] rtcfg_narrow_mode_rt ;
output reg  [11:0] rtcfg_narrow_size_rt ;
output reg  [31:0] rtcfg_arq_lat_barrier_rt ;
output reg  [31:0] rtcfg_awq_lat_barrier_rt ;
output reg  [31:0] rtcfg_arq_starv_th_rt ;
output reg  [31:0] rtcfg_awq_starv_th_rt ;
output reg  [11:0] rtcfg_size_max_rt ;
output reg  [169:0] addr_cfg ;
output reg  [9:0] dllctlca_limit ;
output reg  [1:0] dllctlca_en ;
output reg  [1:0] dllctlca_upd ;
output reg  [1:0] dllctlca_byp ;
output reg  [15:0] dllctlca_bypc ;
output reg  [11:0] dllctlca_clkdly ;
output reg  [19:0] dllctldq_limit ;
output reg  [3:0] dllctldq_en ;
output reg  [3:0] dllctldq_upd ;
output reg  [3:0] dllctldq_byp ;
output reg  [31:0] dllctldq_bypc ;
output reg  [1:0] pbcr_vrefenca ;
output reg  [11:0] pbcr_vrefsetca ;
output reg  [5:0] cior_drvsel ;
output reg  [1:0] cior_cmos_en ;
output reg  [1:0] cior_odis_clk ;
output reg  [29:0] cior_odis_ctl ;
output reg  [11:0] dior_drvsel ;
output reg  [3:0] dior_cmos_en ;
output reg  [3:0] dior_fena_rcv ;
output reg  [3:0] dior_rtt_en ;
output reg  [11:0] dior_rtt_sel ;
output reg  [31:0] dior_odis_dq ;
output reg  [3:0] dior_odis_dm ;
output reg  [3:0] dior_odis_dqs ;
output reg  [1:0] ptsr_vrefcar ;
input  [1:0] ptsr_vrefcar_ip ;
output reg  [11:0] ptsr_vrefcas ;
input  [11:0] ptsr_vrefcas_ip ;
output reg  [1:0] ptsr_vrefdqwrr ;
input  [1:0] ptsr_vrefdqwrr_ip ;
output reg  [11:0] ptsr_vrefdqwrs ;
input  [11:0] ptsr_vrefdqwrs_ip ;
output reg  [27:0] ptsr_cs ;
input  [27:0] ptsr_cs_ip ;
output reg  [531:0] ptsr_ca ;
input  [531:0] ptsr_ca_ip ;
output reg  [111:0] ptsr_ba ;
output reg  [27:0] ptsr_actn ;
output reg  [27:0] ptsr_cke ;
output reg  [47:0] ptsr_gt ;
input  [47:0] ptsr_gt_ip ;
output reg  [63:0] ptsr_wrlvl ;
input  [63:0] ptsr_wrlvl_ip ;
output reg  [511:0] ptsr_dqsdq ;
input  [511:0] ptsr_dqsdq_ip ;
output reg  [63:0] ptsr_dqsdm ;
input  [63:0] ptsr_dqsdm_ip ;
output reg  [511:0] ptsr_rdlvldq ;
input  [511:0] ptsr_rdlvldq_ip ;
output reg  [63:0] ptsr_rdlvldm ;
input  [63:0] ptsr_rdlvldm_ip ;
output reg  [23:0] ptsr_vrefdqrd ;
input  [23:0] ptsr_vrefdqrd_ip ;
output reg   ptsr_vrefdqrdr ;
input   ptsr_vrefdqrdr_ip ;
output reg  [7:0] ptsr_psck ;
input  [7:0] ptsr_psck_ip ;
output reg  [7:0] ptsr_dqsleadck ;
input  [7:0] ptsr_dqsleadck_ip ;
output reg  [15:0] ptsr_sanpat ;
output reg  [13:0] ptsr_odt ;
output reg  [13:0] ptsr_rstn ;
output reg   ptsr_nt_rank ;
input   ptsr_nt_rank_ip ;
output reg  [7:0] reg_t_alrtp_rb ;
output reg  [7:0] reg_t_ckesr_rb ;
output reg  [7:0] reg_t_ccd_s_rb ;
output reg  [7:0] reg_t_faw_rb ;
output reg  [7:0] reg_t_rtw_rb ;
output reg  [7:0] reg_t_rcd_rb ;
output reg  [7:0] reg_t_rdpden_rb ;
output reg  [7:0] reg_t_rc_rb ;
output reg  [7:0] reg_t_ras_rb ;
output reg  [7:0] reg_t_pd_rb ;
output reg  [7:0] reg_t_rp_rb ;
output reg  [7:0] reg_t_wlbr_rb ;
output reg  [7:0] reg_t_wrapden_rb ;
output reg  [7:0] reg_t_cke_rb ;
output reg  [7:0] reg_t_xp_rb ;
output reg  [13:0] reg_t_vreftimelong_rb ;
output reg  [7:0] reg_t_vreftimeshort_rb ;
output reg  [7:0] reg_t_mrd_rb ;
output reg  [27:0] reg_t_zqcs_itv_rb ;
output reg  [19:0] reg_t_pori_rb ;
output reg  [19:0] reg_t_zqinit_rb ;
output reg  [19:0] reg_t_mrs2lvlen_rb ;
output reg  [7:0] reg_t_zqcs_rb ;
output reg  [7:0] reg_t_xpdll_rb ;
output reg  [7:0] reg_t_wlbtr_rb ;
output reg  [7:0] reg_t_rrd_s_rb ;
output reg  [13:0] reg_t_rfc1_rb ;
output reg  [7:0] reg_t_mrs2act_rb ;
output reg  [7:0] reg_t_lvlaa_rb ;
output reg  [19:0] reg_t_dllk_rb ;
output reg  [19:0] reg_t_refi_off_rb ;
output reg  [7:0] reg_t_mprr_rb ;
output reg  [19:0] reg_t_xpr_rb ;
output reg  [7:0] reg_t_dllrst_rb ;
output reg  [19:0] reg_t_rst_rb ;
output reg  [7:0] reg_t_odth4_rb ;
output reg  [7:0] reg_t_odth8_rb ;
output reg  [7:0] reg_t_lvlload_rb ;
output reg  [7:0] reg_t_lvldll_rb ;
output reg  [7:0] reg_t_lvlresp_rb ;
output reg  [13:0] reg_t_xs_rb ;
output reg  [7:0] reg_t_mod_rb ;
output reg  [19:0] reg_t_dpd_rb ;
output reg  [7:0] reg_t_mrw_rb ;
output reg  [7:0] reg_t_wr2rd_rb ;
output reg  [7:0] reg_t_mrr_rb ;
output reg  [7:0] reg_t_zqrs_rb ;
output reg  [7:0] reg_t_dqscke_rb ;
output reg  [13:0] reg_t_xsr_rb ;
output reg  [7:0] reg_t_mped_rb ;
output reg  [7:0] reg_t_mpx_rb ;
output reg  [7:0] reg_t_wr_mpr_rb ;
output reg  [21:0] reg_t_init5_rb ;
output reg  [7:0] reg_t_setgear_rb ;
output reg  [7:0] reg_t_syncgear_rb ;
output reg  [21:0] reg_t_dlllock_rb ;
output reg  [7:0] reg_t_wlbtr_s_rb ;
output reg  [9:0] reg_t_read_low_rb ;
output reg  [9:0] reg_t_read_high_rb ;
output reg  [9:0] reg_t_write_low_rb ;
output reg  [9:0] reg_t_write_high_rb ;
output reg  [13:0] reg_t_rfc2_rb ;
output reg  [13:0] reg_t_rfc4_rb ;
output reg  [7:0] reg_t_wlbr_crcdm_rb ;
output reg  [7:0] reg_t_wlbtr_crcdm_l_rb ;
output reg  [7:0] reg_t_wlbtr_crcdm_s_rb ;
output reg  [13:0] reg_t_xmpdll_rb ;
output reg  [7:0] reg_t_wrmpr_rb ;
output reg  [7:0] reg_t_lvlexit_rb ;
output reg  [7:0] reg_t_lvldis_rb ;
output reg  [13:0] reg_t_zqoper_rb ;
output reg  [13:0] reg_t_rfc_rb ;
output reg  [13:0] reg_t_xsdll_rb ;
output reg  [4:0] reg_odtlon_rb ;
output reg  [4:0] reg_odtloff_rb ;
output reg  [7:0] reg_t_wlmrd_rb ;
output reg  [7:0] reg_t_wldqsen_rb ;
output reg  [7:0] reg_t_wtr_rb ;
output reg  [7:0] reg_t_rda2pd_rb ;
output reg  [7:0] reg_t_wra2pd_rb ;
output reg  [13:0] reg_t_zqcl_rb ;
output reg  [7:0] reg_t_calvl_adr_ckeh_rb ;
output reg  [7:0] reg_t_calvl_capture_rb ;
output reg  [7:0] reg_t_calvl_cc_rb ;
output reg  [7:0] reg_t_calvl_en_rb ;
output reg  [7:0] reg_t_calvl_ext_rb ;
output reg  [7:0] reg_t_calvl_max_rb ;
output reg  [7:0] reg_t_ckehdqs_rb ;
output reg  [7:0] reg_t_ccd_rb ;
output reg  [7:0] reg_t_zqlat_rb ;
output reg  [7:0] reg_t_ckckeh_rb ;
output reg  [7:0] reg_t_rrd_rb ;
output reg  [21:0] reg_t_caent_rb ;
output reg  [7:0] reg_t_cmdcke_rb ;
output reg  [7:0] reg_t_mpcwr_rb ;
output reg  [7:0] reg_t_dqrpt_rb ;
output reg  [27:0] reg_t_zq_itv_rb ;
output reg  [7:0] reg_t_ckelck_rb ;
output reg  [7:0] reg_t_dllen_rb ;
output reg  [19:0] reg_t_init3_rb ;
output reg  [7:0] reg_t_dtrain_rb ;
output reg  [7:0] reg_t_mpcwr2rd_rb ;
output reg  [13:0] reg_t_fc_rb ;
output reg  [13:0] reg_t_refi_rb ;
output reg  [13:0] reg_t_vrcgen_rb ;
output reg  [7:0] reg_t_vrcgdis_rb ;
output reg  [7:0] reg_t_odtup_rb ;
output reg  [7:0] reg_t_ccdwm_rb ;
output reg  [7:0] reg_t_osco_rb ;
output reg  [7:0] reg_t_ckfspe_rb ;
output reg  [7:0] reg_t_ckfspx_rb ;
output reg  [13:0] reg_t_init1_rb ;
output reg  [19:0] reg_t_zqcal_rb ;
output reg  [7:0] reg_t_lvlresp_nr_rb ;
output reg  [7:0] reg_t_ppd_rb ;
output reg  [1:0] bistcfg_start_rank_ch ;
output reg  [1:0] bistcfg_end_rank_ch ;
output reg  [7:0] bistcfg_start_bank_ch ;
output reg  [7:0] bistcfg_end_bank_ch ;
output reg  [5:0] bistcfg_start_background_ch ;
output reg  [5:0] bistcfg_end_background_ch ;
output reg  [7:0] bistcfg_element_ch ;
output reg  [7:0] bistcfg_operation_ch ;
output reg  [7:0] bistcfg_retention_ch ;
output reg  [1:0] bistcfg_diagnosis_en_ch ;
output reg  [33:0] biststaddr_start_row_ch ;
output reg  [21:0] biststaddr_start_col_ch ;
output reg  [33:0] bistedaddr_end_row_ch ;
output reg  [21:0] bistedaddr_end_col_ch ;
output reg  [63:0] bistm0_march_element_0_ch ;
output reg  [63:0] bistm1_march_element_1_ch ;
output reg  [63:0] bistm2_march_element_2_ch ;
output reg  [63:0] bistm3_march_element_3_ch ;
output reg  [63:0] bistm4_march_element_4_ch ;
output reg  [63:0] bistm5_march_element_5_ch ;
output reg  [63:0] bistm6_march_element_6_ch ;
output reg  [63:0] bistm7_march_element_7_ch ;
output reg  [63:0] bistm8_march_element_8_ch ;
output reg  [63:0] bistm9_march_element_9_ch ;
output reg  [63:0] bistm10_march_element_10_ch ;
output reg  [63:0] bistm11_march_element_11_ch ;
output reg  [63:0] bistm12_march_element_12_ch ;
output reg  [63:0] bistm13_march_element_13_ch ;
output reg  [63:0] bistm14_march_element_14_ch ;
output reg  [63:0] bistm15_march_element_15_ch ;
input  [1:0] status_dram_pause_ch ;
input  [1:0] status_user_cmd_ready_ch ;
input  [31:0] status_bank_idle_ch ;
input  [1:0] status_xqr_empty_ch ;
input  [1:0] status_xqr_full_ch ;
input  [1:0] status_xqw_empty_ch ;
input  [1:0] status_xqw_full_ch ;
input  [1:0] status_int_gc_fsm_ch ;
input  [1:0] status_bist_error_ch ;
input  [1:0] status_bist_endtest_ch ;
input  [1:0] status_bist_error_new_ch ;
input  [1:0] status_bist_rank_fail_ch ;
input  [7:0] status_bist_bank_fail_ch ;
input  [33:0] status_bist_row_fail_ch ;
input  [7:0] pts_vrefdqrderr ;
input  [3:0] pts_vrefcaerr ;
input  [7:0] pts_gterr ;
input  [7:0] pts_wrlvlerr ;
input  [7:0] pts_vrefdqwrerr ;
input  [7:0] pts_rdlvldmerr ;
input  [5:0] pts_dllerr ;
input  [3:0] pts_lp3calvlerr ;
input  [7:0] pts_sanchkerr ;
input  [7:0] pts_dqsdmerr ;
input  [63:0] pts_rdlvldqerr ;
input  [63:0] pts_dqsdqerr ;
input   mpr_done_ch ;
input  [7:0] mpr_readout_ch ;
input  [1:0] mrr_done_ch ;
input  [15:0] mrr_readout_ch ;
input  [7:0] shad_reg_lpmr1_fs0 ;
input  [7:0] shad_reg_lpmr1_fs1 ;
input  [7:0] shad_reg_lpmr2_fs0 ;
input  [7:0] shad_reg_lpmr2_fs1 ;
input  [7:0] shad_reg_lpmr3_fs0 ;
input  [7:0] shad_reg_lpmr3_fs1 ;
input  [7:0] shad_reg_lpmr11_fs0 ;
input  [7:0] shad_reg_lpmr11_fs1 ;
input  [7:0] shad_reg_lpmr11_nt_fs0 ;
input  [7:0] shad_reg_lpmr11_nt_fs1 ;
input  [7:0] shad_reg_lpmr12_fs0 ;
input  [7:0] shad_reg_lpmr12_fs1 ;
input  [7:0] shad_reg_lpmr13 ;
input  [7:0] shad_reg_lpmr14_fs0 ;
input  [7:0] shad_reg_lpmr14_fs1 ;
input  [7:0] shad_reg_lpmr22_fs0 ;
input  [7:0] shad_reg_lpmr22_fs1 ;
input  [7:0] shad_reg_lpmr22_nt_fs0 ;
input  [7:0] shad_reg_lpmr22_nt_fs1 ;
input  [511:0] data_rddata ;
output reg  [1:0] int_gc_fsm_ch ;
output reg  [17:0] reg_ddr4_mr0 ;
output reg  [17:0] reg_ddr4_mr1 ;
output reg  [17:0] reg_ddr4_mr2 ;
output reg  [17:0] reg_ddr4_mr3 ;
output reg  [17:0] reg_ddr4_mr4 ;
output reg  [17:0] reg_ddr4_mr5 ;
output reg  [17:0] reg_ddr4_mr6 ;
output reg  [17:0] reg_ddr3_mr0 ;
output reg  [17:0] reg_ddr3_mr1 ;
output reg  [17:0] reg_ddr3_mr2 ;
output reg  [17:0] reg_ddr3_mr3 ;
output reg  [7:0] reg_lpddr4_lpmr13 ;
output reg  [7:0] reg_lpddr4_lpmr16 ;
output reg  [7:0] reg_lpddr4_lpmr1_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr1_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr2_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr2_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr3_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr3_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr11_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr11_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr11_nt_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr11_nt_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr12_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr12_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr14_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr14_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr22_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr22_fs1 ;
output reg  [7:0] reg_lpddr4_lpmr22_nt_fs0 ;
output reg  [7:0] reg_lpddr4_lpmr22_nt_fs1 ;
output reg  [7:0] reg_lpddr3_lpmr1 ;
output reg  [7:0] reg_lpddr3_lpmr2 ;
output reg  [7:0] reg_lpddr3_lpmr3 ;
output reg  [7:0] reg_lpddr3_lpmr10 ;
output reg  [7:0] reg_lpddr3_lpmr11 ;
output reg  [7:0] reg_lpddr3_lpmr16 ;
output reg  [7:0] reg_lpddr3_lpmr17 ;
output reg  [3:0] ddr4_mr4_t_cal ;
output reg   dram_crc_dm ;
output reg  [1:0] dram_bl_enc ;
output reg   reg_ddr4_enable ;
output reg   reg_ddr3_enable ;
output reg   reg_lpddr4_enable ;
output reg   reg_lpddr3_enable ;
input   axi4lite_arvalid ;
input  [11:0] axi4lite_araddr ;
output reg   axi4lite_arready ;
input   axi4lite_rready ;
output reg   axi4lite_rvalid ;
output reg  [31:0] axi4lite_rdata ;
output reg  [1:0] axi4lite_rresp ;
input   axi4lite_awvalid ;
input  [11:0] axi4lite_awaddr ;
output reg   axi4lite_awready ;
input   axi4lite_wvalid ;
input  [31:0] axi4lite_wdata ;
output reg   axi4lite_wready ;
input   axi4lite_bready ;
output reg   axi4lite_bvalid ;
output reg  [1:0] axi4lite_bresp ;
input   clk ;
input   reset_n ;
input   ptsr_upd ;
input   mupd_dqsdqcr_clr ;
input  [1:0] user_cmd_wait_done_ch ;
input   mpr_access_enable ;
input   mpr_rd_n_wr ;
input  [1:0] mrr_enable ;
input   rddata_upd ;
output reg  [1:0] user_cmd_valid ;
output reg   reg_phy_init_done ;
wire   user_cmd_ready ;
wire  [1:0] user_cmd_wait_done ;
wire  [11:0] waddr ;
wire  [11:0] raddr ;
wire  [31:0] wdata ;
wire  [31:0] rdata ;
wire   rd_en ;
wire   wr_en ;
wire  [1:0] addr_wr_dec_status ;
wire  [1:0] addr_rd_dec_status ;
wire   dmcfg_int_gc_fsm_en ;
wire   dmcfg_int_gc_fsm_clr ;
wire  [1:0] lpddr4_lpmr1_fs0_bl ;
wire  [2:0] lpddr4_lpmr1_fs0_nwr ;
wire   lpddr4_lpmr1_fs0_rpst ;
wire  [1:0] lpddr4_lpmr1_fs1_bl ;
wire  [2:0] lpddr4_lpmr1_fs1_nwr ;
wire   lpddr4_lpmr1_fs1_rpst ;
wire  [2:0] lpddr4_lpmr2_fs0_rl ;
wire  [2:0] lpddr4_lpmr2_fs0_wl ;
wire   lpddr4_lpmr2_fs0_wls ;
wire   lpddr4_lpmr2_wrlev ;
wire  [2:0] lpddr4_lpmr2_fs1_rl ;
wire  [2:0] lpddr4_lpmr2_fs1_wl ;
wire   lpddr4_lpmr2_fs1_wls ;
wire   lpddr4_lpmr3_fs0_pucal ;
wire   lpddr4_lpmr3_fs0_wpst ;
wire   lpddr4_lpmr3_pprp ;
wire  [2:0] lpddr4_lpmr3_fs0_pdds ;
wire   lpddr4_lpmr3_fs0_rdbi ;
wire   lpddr4_lpmr3_fs0_wdbi ;
wire   lpddr4_lpmr3_fs1_pucal ;
wire   lpddr4_lpmr3_fs1_wpst ;
wire  [2:0] lpddr4_lpmr3_fs1_pdds ;
wire   lpddr4_lpmr3_fs1_rdbi ;
wire   lpddr4_lpmr3_fs1_wdbi ;
wire  [2:0] lpddr4_lpmr11_fs0_dqodt ;
wire  [2:0] lpddr4_lpmr11_fs0_caodt ;
wire  [2:0] lpddr4_lpmr11_fs1_dqodt ;
wire  [2:0] lpddr4_lpmr11_fs1_caodt ;
wire  [2:0] lpddr4_lpmr11_nt_fs0_dqodt ;
wire  [2:0] lpddr4_lpmr11_nt_fs0_caodt ;
wire  [2:0] lpddr4_lpmr11_nt_fs1_dqodt ;
wire  [2:0] lpddr4_lpmr11_nt_fs1_caodt ;
wire   lpddr4_lpmr13_cbt ;
wire   lpddr4_lpmr13_rpt ;
wire   lpddr4_lpmr13_vro ;
wire   lpddr4_lpmr13_vrcg ;
wire   lpddr4_lpmr13_rro ;
wire   lpddr4_lpmr13_dmd ;
wire   lpddr4_lpmr13_fspwr ;
wire   lpddr4_lpmr13_fspop ;
wire  [2:0] lpddr4_lpmr22_fs0_socodt ;
wire   lpddr4_lpmr22_fs0_odteck ;
wire   lpddr4_lpmr22_fs0_odtecs ;
wire   lpddr4_lpmr22_fs0_odtdca ;
wire  [1:0] lpddr4_lpmr22_odtdx8 ;
wire  [2:0] lpddr4_lpmr22_fs1_socodt ;
wire   lpddr4_lpmr22_fs1_odteck ;
wire   lpddr4_lpmr22_fs1_odtecs ;
wire   lpddr4_lpmr22_fs1_odtdca ;
wire  [2:0] lpddr4_lpmr22_nt_fs0_socodt ;
wire   lpddr4_lpmr22_nt_fs0_odteck ;
wire   lpddr4_lpmr22_nt_fs0_odtecs ;
wire   lpddr4_lpmr22_nt_fs0_odtdca ;
wire  [1:0] lpddr4_lpmr22_nt_odtdx8 ;
wire  [2:0] lpddr4_lpmr22_nt_fs1_socodt ;
wire   lpddr4_lpmr22_nt_fs1_odteck ;
wire   lpddr4_lpmr22_nt_fs1_odtecs ;
wire   lpddr4_lpmr22_nt_fs1_odtdca ;
wire  [2:0] lpddr3_lpmr1_bl ;
wire  [2:0] lpddr3_lpmr1_nwr ;
wire  [3:0] lpddr3_lpmr2_rlwl ;
wire   lpddr3_lpmr2_nwre ;
wire   lpddr3_lpmr2_wls ;
wire   lpddr3_lpmr2_wrlev ;
wire  [3:0] lpddr3_lpmr3_ds ;
wire  [7:0] lpddr3_lpmr10_cali_code ;
wire  [1:0] lpddr3_lpmr11_dqodt ;
wire   lpddr3_lpmr11_pd ;
wire  [7:0] lpddr3_lpmr16_pasr_b ;
wire  [7:0] lpddr3_lpmr17_pasr_s ;
wire  [2:0] ddr4_mr0_wr ;
wire   ddr4_mr0_dllrst ;
wire   ddr4_mr0_tm ;
wire  [3:0] ddr4_mr0_cl ;
wire   ddr4_mr0_rbt ;
wire  [1:0] ddr4_mr0_bl ;
wire   ddr4_mr1_qoff ;
wire   ddr4_mr1_tdqs ;
wire   ddr4_mr1_wrlvl ;
wire  [2:0] ddr4_mr1_rttnom ;
wire  [1:0] ddr4_mr1_dic ;
wire   ddr4_mr1_dllen ;
wire  [2:0] ddr4_mr1_al ;
wire  [1:0] ddr4_mr2_rttwr ;
wire  [1:0] ddr4_mr2_lasr ;
wire  [2:0] ddr4_mr2_cwl ;
wire   ddr4_mr3_mpro ;
wire  [1:0] ddr4_mr3_mprp ;
wire   ddr4_mr3_gdwn ;
wire   ddr4_mr3_pda ;
wire   ddr4_mr3_tsr ;
wire  [2:0] ddr4_mr3_fgrm ;
wire  [1:0] ddr4_mr3_wcl ;
wire  [1:0] ddr4_mr3_mprf ;
wire   ddr4_mr4_mpdwn ;
wire   ddr4_mr4_tcrr ;
wire   ddr4_mr4_tcrm ;
wire   ddr4_mr4_ivref ;
wire   ddr4_mr4_srab ;
wire   ddr4_mr4_rptm ;
wire  [2:0] ddr4_mr5_capl ;
wire   ddr4_mr5_crcec ;
wire   ddr4_mr5_caps ;
wire   ddr4_mr5_odtb ;
wire  [2:0] ddr4_mr5_rttpk ;
wire   ddr4_mr5_cappe ;
wire   ddr4_mr5_dm ;
wire   ddr4_mr5_wdbi ;
wire   ddr4_mr5_rdbi ;
wire   ddr4_mr6_vrefdqe ;
wire   ddr3_mr0_ppd ;
wire  [2:0] ddr3_mr0_wr ;
wire   ddr3_mr0_dllrst ;
wire   ddr3_mr0_tm ;
wire  [3:0] ddr3_mr0_cl ;
wire   ddr3_mr0_rbt ;
wire  [2:0] ddr3_mr0_bl ;
wire   ddr3_mr1_qoff ;
wire   ddr3_mr1_tdqs ;
wire   ddr3_mr1_wrlvl ;
wire  [2:0] ddr3_mr1_rttnom ;
wire  [1:0] ddr3_mr1_dic ;
wire   ddr3_mr1_dllen ;
wire  [1:0] ddr3_mr1_al ;
wire  [1:0] ddr3_mr2_rttwr ;
wire   ddr3_mr2_srt ;
wire   ddr3_mr2_lasr ;
wire  [2:0] ddr3_mr2_cwl ;
wire  [2:0] ddr3_mr2_pasr ;
wire   ddr3_mr3_mpro ;
wire  [1:0] ddr3_mr3_mprp ;
wire   rtcfg0_rt0_ext_pri ;
wire   rtcfg0_rt0_max_pri ;
wire  [3:0] rtcfg0_rt0_arq_lvl_hi ;
wire  [3:0] rtcfg0_rt0_arq_lvl_lo ;
wire  [3:0] rtcfg0_rt0_awq_lvl_hi ;
wire  [3:0] rtcfg0_rt0_awq_lvl_lo ;
wire   rtcfg0_rt0_arq_lat_barrier_en ;
wire   rtcfg0_rt0_awq_lat_barrier_en ;
wire   rtcfg0_rt0_arq_ooo_en ;
wire   rtcfg0_rt0_awq_ooo_en ;
wire   rtcfg0_rt0_acq_realtime_en ;
wire   rtcfg0_rt0_wm_enable ;
wire   rtcfg0_rt0_arq_lahead_en ;
wire   rtcfg0_rt0_awq_lahead_en ;
wire   rtcfg0_rt0_narrow_mode ;
wire  [2:0] rtcfg0_rt0_narrow_size ;
wire   rtcfg0_rt1_ext_pri ;
wire   rtcfg0_rt1_max_pri ;
wire  [3:0] rtcfg0_rt1_arq_lvl_hi ;
wire  [3:0] rtcfg0_rt1_arq_lvl_lo ;
wire  [3:0] rtcfg0_rt1_awq_lvl_hi ;
wire  [3:0] rtcfg0_rt1_awq_lvl_lo ;
wire   rtcfg0_rt1_arq_lat_barrier_en ;
wire   rtcfg0_rt1_awq_lat_barrier_en ;
wire   rtcfg0_rt1_arq_ooo_en ;
wire   rtcfg0_rt1_awq_ooo_en ;
wire   rtcfg0_rt1_acq_realtime_en ;
wire   rtcfg0_rt1_wm_enable ;
wire   rtcfg0_rt1_arq_lahead_en ;
wire   rtcfg0_rt1_awq_lahead_en ;
wire   rtcfg0_rt1_narrow_mode ;
wire  [2:0] rtcfg0_rt1_narrow_size ;
wire   rtcfg0_rt2_ext_pri ;
wire   rtcfg0_rt2_max_pri ;
wire  [3:0] rtcfg0_rt2_arq_lvl_hi ;
wire  [3:0] rtcfg0_rt2_arq_lvl_lo ;
wire  [3:0] rtcfg0_rt2_awq_lvl_hi ;
wire  [3:0] rtcfg0_rt2_awq_lvl_lo ;
wire   rtcfg0_rt2_arq_lat_barrier_en ;
wire   rtcfg0_rt2_awq_lat_barrier_en ;
wire   rtcfg0_rt2_arq_ooo_en ;
wire   rtcfg0_rt2_awq_ooo_en ;
wire   rtcfg0_rt2_acq_realtime_en ;
wire   rtcfg0_rt2_wm_enable ;
wire   rtcfg0_rt2_arq_lahead_en ;
wire   rtcfg0_rt2_awq_lahead_en ;
wire   rtcfg0_rt2_narrow_mode ;
wire  [2:0] rtcfg0_rt2_narrow_size ;
wire   rtcfg0_rt3_ext_pri ;
wire   rtcfg0_rt3_max_pri ;
wire  [3:0] rtcfg0_rt3_arq_lvl_hi ;
wire  [3:0] rtcfg0_rt3_arq_lvl_lo ;
wire  [3:0] rtcfg0_rt3_awq_lvl_hi ;
wire  [3:0] rtcfg0_rt3_awq_lvl_lo ;
wire   rtcfg0_rt3_arq_lat_barrier_en ;
wire   rtcfg0_rt3_awq_lat_barrier_en ;
wire   rtcfg0_rt3_arq_ooo_en ;
wire   rtcfg0_rt3_awq_ooo_en ;
wire   rtcfg0_rt3_acq_realtime_en ;
wire   rtcfg0_rt3_wm_enable ;
wire   rtcfg0_rt3_arq_lahead_en ;
wire   rtcfg0_rt3_awq_lahead_en ;
wire   rtcfg0_rt3_narrow_mode ;
wire  [2:0] rtcfg0_rt3_narrow_size ;
wire  [7:0] rtcfg1_rt0_arq_lat_barrier ;
wire  [7:0] rtcfg1_rt0_awq_lat_barrier ;
wire  [7:0] rtcfg1_rt0_arq_starv_th ;
wire  [7:0] rtcfg1_rt0_awq_starv_th ;
wire  [7:0] rtcfg1_rt1_arq_lat_barrier ;
wire  [7:0] rtcfg1_rt1_awq_lat_barrier ;
wire  [7:0] rtcfg1_rt1_arq_starv_th ;
wire  [7:0] rtcfg1_rt1_awq_starv_th ;
wire  [7:0] rtcfg1_rt2_arq_lat_barrier ;
wire  [7:0] rtcfg1_rt2_awq_lat_barrier ;
wire  [7:0] rtcfg1_rt2_arq_starv_th ;
wire  [7:0] rtcfg1_rt2_awq_starv_th ;
wire  [7:0] rtcfg1_rt3_arq_lat_barrier ;
wire  [7:0] rtcfg1_rt3_awq_lat_barrier ;
wire  [7:0] rtcfg1_rt3_arq_starv_th ;
wire  [7:0] rtcfg1_rt3_awq_starv_th ;
wire  [2:0] rtcfg2_rt0_size_max ;
wire  [2:0] rtcfg2_rt1_size_max ;
wire  [2:0] rtcfg2_rt2_size_max ;
wire  [2:0] rtcfg2_rt3_size_max ;
wire  [4:0] addr0_col_addr_map_b0 ;
wire  [4:0] addr0_col_addr_map_b1 ;
wire  [4:0] addr0_col_addr_map_b2 ;
wire  [4:0] addr0_col_addr_map_b3 ;
wire  [4:0] addr0_col_addr_map_b4 ;
wire  [4:0] addr0_col_addr_map_b5 ;
wire  [4:0] addr1_col_addr_map_b6 ;
wire  [4:0] addr1_col_addr_map_b7 ;
wire  [4:0] addr1_col_addr_map_b8 ;
wire  [4:0] addr1_col_addr_map_b9 ;
wire  [4:0] addr1_col_addr_map_b10 ;
wire  [4:0] addr2_row_addr_map_b0 ;
wire  [4:0] addr2_row_addr_map_b1 ;
wire  [4:0] addr2_row_addr_map_b2 ;
wire  [4:0] addr2_row_addr_map_b3 ;
wire  [4:0] addr2_row_addr_map_b4 ;
wire  [4:0] addr2_row_addr_map_b5 ;
wire  [4:0] addr3_row_addr_map_b6 ;
wire  [4:0] addr3_row_addr_map_b7 ;
wire  [4:0] addr3_row_addr_map_b8 ;
wire  [4:0] addr3_row_addr_map_b9 ;
wire  [4:0] addr3_row_addr_map_b10 ;
wire  [4:0] addr3_row_addr_map_b11 ;
wire  [4:0] addr4_row_addr_map_b12 ;
wire  [4:0] addr4_row_addr_map_b13 ;
wire  [4:0] addr4_row_addr_map_b14 ;
wire  [4:0] addr4_row_addr_map_b15 ;
wire  [4:0] addr4_row_addr_map_b16 ;
wire  [4:0] addr5_bank_addr_map_b0 ;
wire  [4:0] addr5_bank_addr_map_b1 ;
wire  [4:0] addr5_bank_addr_map_b2 ;
wire  [4:0] addr5_bank_addr_map_b3 ;
wire  [4:0] addr5_rank_addr_map_b0 ;
wire  [4:0] addr5_chan_addr_map_b0 ;
wire  [4:0] dllctlca_ch0_limit ;
wire   dllctlca_ch0_en ;
wire   dllctlca_ch0_upd ;
wire   dllctlca_ch0_byp ;
wire  [7:0] dllctlca_ch0_bypc ;
wire  [5:0] dllctlca_ch0_clkdly ;
wire  [4:0] dllctlca_ch1_limit ;
wire   dllctlca_ch1_en ;
wire   dllctlca_ch1_upd ;
wire   dllctlca_ch1_byp ;
wire  [7:0] dllctlca_ch1_bypc ;
wire  [5:0] dllctlca_ch1_clkdly ;
wire  [4:0] dllctldq_sl0_limit ;
wire   dllctldq_sl0_en ;
wire   dllctldq_sl0_upd ;
wire   dllctldq_sl0_byp ;
wire  [7:0] dllctldq_sl0_bypc ;
wire  [4:0] dllctldq_sl1_limit ;
wire   dllctldq_sl1_en ;
wire   dllctldq_sl1_upd ;
wire   dllctldq_sl1_byp ;
wire  [7:0] dllctldq_sl1_bypc ;
wire  [4:0] dllctldq_sl2_limit ;
wire   dllctldq_sl2_en ;
wire   dllctldq_sl2_upd ;
wire   dllctldq_sl2_byp ;
wire  [7:0] dllctldq_sl2_bypc ;
wire  [4:0] dllctldq_sl3_limit ;
wire   dllctldq_sl3_en ;
wire   dllctldq_sl3_upd ;
wire   dllctldq_sl3_byp ;
wire  [7:0] dllctldq_sl3_bypc ;
wire   pbcr_vrefenca_c0 ;
wire  [5:0] pbcr_vrefsetca_c0 ;
wire   pbcr_vrefenca_c1 ;
wire  [5:0] pbcr_vrefsetca_c1 ;
wire  [2:0] cior0_ch0_drvsel ;
wire   cior0_ch0_cmos_en ;
wire  [2:0] cior0_ch1_drvsel ;
wire   cior0_ch1_cmos_en ;
wire  [1:0] cior1_odis_clk ;
wire  [29:0] cior1_odis_ctl ;
wire  [2:0] dior_sl0_drvsel ;
wire   dior_sl0_cmos_en ;
wire   dior_sl0_fena_rcv ;
wire   dior_sl0_rtt_en ;
wire  [2:0] dior_sl0_rtt_sel ;
wire  [7:0] dior_sl0_odis_dq ;
wire   dior_sl0_odis_dm ;
wire   dior_sl0_odis_dqs ;
wire  [2:0] dior_sl1_drvsel ;
wire   dior_sl1_cmos_en ;
wire   dior_sl1_fena_rcv ;
wire   dior_sl1_rtt_en ;
wire  [2:0] dior_sl1_rtt_sel ;
wire  [7:0] dior_sl1_odis_dq ;
wire   dior_sl1_odis_dm ;
wire   dior_sl1_odis_dqs ;
wire  [2:0] dior_sl2_drvsel ;
wire   dior_sl2_cmos_en ;
wire   dior_sl2_fena_rcv ;
wire   dior_sl2_rtt_en ;
wire  [2:0] dior_sl2_rtt_sel ;
wire  [7:0] dior_sl2_odis_dq ;
wire   dior_sl2_odis_dm ;
wire   dior_sl2_odis_dqs ;
wire  [2:0] dior_sl3_drvsel ;
wire   dior_sl3_cmos_en ;
wire   dior_sl3_fena_rcv ;
wire   dior_sl3_rtt_en ;
wire  [2:0] dior_sl3_rtt_sel ;
wire  [7:0] dior_sl3_odis_dq ;
wire   dior_sl3_odis_dm ;
wire   dior_sl3_odis_dqs ;
wire   ptsr0_r0_vrefcar ;
reg   ptsr0_r0_vrefcar_ip ;
wire  [5:0] ptsr0_r0_vrefcas ;
reg  [5:0] ptsr0_r0_vrefcas_ip ;
wire   ptsr0_r0_vrefdqwrr ;
reg   ptsr0_r0_vrefdqwrr_ip ;
wire  [5:0] ptsr0_r0_vrefdqwrs ;
reg  [5:0] ptsr0_r0_vrefdqwrs_ip ;
wire  [6:0] ptsr1_r0_csc0 ;
reg  [6:0] ptsr1_r0_csc0_ip ;
wire  [6:0] ptsr1_r0_csc1 ;
reg  [6:0] ptsr1_r0_csc1_ip ;
wire  [6:0] ptsr1_r0_cac0b0 ;
reg  [6:0] ptsr1_r0_cac0b0_ip ;
wire  [6:0] ptsr1_r0_cac0b1 ;
reg  [6:0] ptsr1_r0_cac0b1_ip ;
wire  [6:0] ptsr2_r0_cac0b2 ;
reg  [6:0] ptsr2_r0_cac0b2_ip ;
wire  [6:0] ptsr2_r0_cac0b3 ;
reg  [6:0] ptsr2_r0_cac0b3_ip ;
wire  [6:0] ptsr2_r0_cac0b4 ;
reg  [6:0] ptsr2_r0_cac0b4_ip ;
wire  [6:0] ptsr2_r0_cac0b5 ;
reg  [6:0] ptsr2_r0_cac0b5_ip ;
wire  [6:0] ptsr3_r0_cac0b6 ;
reg  [6:0] ptsr3_r0_cac0b6_ip ;
wire  [6:0] ptsr3_r0_cac0b7 ;
reg  [6:0] ptsr3_r0_cac0b7_ip ;
wire  [6:0] ptsr3_r0_cac0b8 ;
reg  [6:0] ptsr3_r0_cac0b8_ip ;
wire  [6:0] ptsr3_r0_cac0b9 ;
reg  [6:0] ptsr3_r0_cac0b9_ip ;
wire  [6:0] ptsr4_r0_cac0b10 ;
reg  [6:0] ptsr4_r0_cac0b10_ip ;
wire  [6:0] ptsr4_r0_cac0b11 ;
reg  [6:0] ptsr4_r0_cac0b11_ip ;
wire  [6:0] ptsr4_r0_cac0b12 ;
reg  [6:0] ptsr4_r0_cac0b12_ip ;
wire  [6:0] ptsr4_r0_cac0b13 ;
reg  [6:0] ptsr4_r0_cac0b13_ip ;
wire  [6:0] ptsr5_r0_cac0b14 ;
reg  [6:0] ptsr5_r0_cac0b14_ip ;
wire  [6:0] ptsr5_r0_cac0b15 ;
reg  [6:0] ptsr5_r0_cac0b15_ip ;
wire  [6:0] ptsr5_r0_cac0b16 ;
reg  [6:0] ptsr5_r0_cac0b16_ip ;
wire  [6:0] ptsr5_r0_cac0b17 ;
reg  [6:0] ptsr5_r0_cac0b17_ip ;
wire  [6:0] ptsr6_r0_cac0b18 ;
reg  [6:0] ptsr6_r0_cac0b18_ip ;
wire  [6:0] ptsr6_r0_cac1b0 ;
reg  [6:0] ptsr6_r0_cac1b0_ip ;
wire  [6:0] ptsr6_r0_cac1b1 ;
reg  [6:0] ptsr6_r0_cac1b1_ip ;
wire  [6:0] ptsr6_r0_cac1b2 ;
reg  [6:0] ptsr6_r0_cac1b2_ip ;
wire  [6:0] ptsr7_r0_cac1b3 ;
reg  [6:0] ptsr7_r0_cac1b3_ip ;
wire  [6:0] ptsr7_r0_cac1b4 ;
reg  [6:0] ptsr7_r0_cac1b4_ip ;
wire  [6:0] ptsr7_r0_cac1b5 ;
reg  [6:0] ptsr7_r0_cac1b5_ip ;
wire  [6:0] ptsr7_r0_cac1b6 ;
reg  [6:0] ptsr7_r0_cac1b6_ip ;
wire  [6:0] ptsr8_r0_cac1b7 ;
reg  [6:0] ptsr8_r0_cac1b7_ip ;
wire  [6:0] ptsr8_r0_cac1b8 ;
reg  [6:0] ptsr8_r0_cac1b8_ip ;
wire  [6:0] ptsr8_r0_cac1b9 ;
reg  [6:0] ptsr8_r0_cac1b9_ip ;
wire  [6:0] ptsr8_r0_cac1b10 ;
reg  [6:0] ptsr8_r0_cac1b10_ip ;
wire  [6:0] ptsr9_r0_cac1b11 ;
reg  [6:0] ptsr9_r0_cac1b11_ip ;
wire  [6:0] ptsr9_r0_cac1b12 ;
reg  [6:0] ptsr9_r0_cac1b12_ip ;
wire  [6:0] ptsr9_r0_cac1b13 ;
reg  [6:0] ptsr9_r0_cac1b13_ip ;
wire  [6:0] ptsr9_r0_cac1b14 ;
reg  [6:0] ptsr9_r0_cac1b14_ip ;
wire  [6:0] ptsr10_r0_cac1b15 ;
reg  [6:0] ptsr10_r0_cac1b15_ip ;
wire  [6:0] ptsr10_r0_cac1b16 ;
reg  [6:0] ptsr10_r0_cac1b16_ip ;
wire  [6:0] ptsr10_r0_cac1b17 ;
reg  [6:0] ptsr10_r0_cac1b17_ip ;
wire  [6:0] ptsr10_r0_cac1b18 ;
reg  [6:0] ptsr10_r0_cac1b18_ip ;
wire  [6:0] ptsr11_r0_bac0b0 ;
wire  [6:0] ptsr11_r0_bac0b1 ;
wire  [6:0] ptsr11_r0_bac0b2 ;
wire  [6:0] ptsr11_r0_bac0b3 ;
wire  [6:0] ptsr12_r0_bac1b0 ;
wire  [6:0] ptsr12_r0_bac1b1 ;
wire  [6:0] ptsr12_r0_bac1b2 ;
wire  [6:0] ptsr12_r0_bac1b3 ;
wire  [6:0] ptsr13_r0_actnc0 ;
wire  [6:0] ptsr13_r0_actnc1 ;
wire  [6:0] ptsr13_r0_ckec0 ;
wire  [6:0] ptsr13_r0_ckec1 ;
wire  [5:0] ptsr14_r0_gts0 ;
reg  [5:0] ptsr14_r0_gts0_ip ;
wire  [5:0] ptsr14_r0_gts1 ;
reg  [5:0] ptsr14_r0_gts1_ip ;
wire  [5:0] ptsr14_r0_gts2 ;
reg  [5:0] ptsr14_r0_gts2_ip ;
wire  [5:0] ptsr14_r0_gts3 ;
reg  [5:0] ptsr14_r0_gts3_ip ;
wire  [7:0] ptsr15_r0_wrlvls0 ;
reg  [7:0] ptsr15_r0_wrlvls0_ip ;
wire  [7:0] ptsr15_r0_wrlvls1 ;
reg  [7:0] ptsr15_r0_wrlvls1_ip ;
wire  [7:0] ptsr15_r0_wrlvls2 ;
reg  [7:0] ptsr15_r0_wrlvls2_ip ;
wire  [7:0] ptsr15_r0_wrlvls3 ;
reg  [7:0] ptsr15_r0_wrlvls3_ip ;
wire  [7:0] ptsr16_r0_dqsdqs0b0 ;
reg  [7:0] ptsr16_r0_dqsdqs0b0_ip ;
wire  [7:0] ptsr16_r0_dqsdqs0b1 ;
reg  [7:0] ptsr16_r0_dqsdqs0b1_ip ;
wire  [7:0] ptsr16_r0_dqsdqs0b2 ;
reg  [7:0] ptsr16_r0_dqsdqs0b2_ip ;
wire  [7:0] ptsr16_r0_dqsdqs0b3 ;
reg  [7:0] ptsr16_r0_dqsdqs0b3_ip ;
wire  [7:0] ptsr17_r0_dqsdqs0b4 ;
reg  [7:0] ptsr17_r0_dqsdqs0b4_ip ;
wire  [7:0] ptsr17_r0_dqsdqs0b5 ;
reg  [7:0] ptsr17_r0_dqsdqs0b5_ip ;
wire  [7:0] ptsr17_r0_dqsdqs0b6 ;
reg  [7:0] ptsr17_r0_dqsdqs0b6_ip ;
wire  [7:0] ptsr17_r0_dqsdqs0b7 ;
reg  [7:0] ptsr17_r0_dqsdqs0b7_ip ;
wire  [7:0] ptsr18_r0_dqsdqs1b0 ;
reg  [7:0] ptsr18_r0_dqsdqs1b0_ip ;
wire  [7:0] ptsr18_r0_dqsdqs1b1 ;
reg  [7:0] ptsr18_r0_dqsdqs1b1_ip ;
wire  [7:0] ptsr18_r0_dqsdqs1b2 ;
reg  [7:0] ptsr18_r0_dqsdqs1b2_ip ;
wire  [7:0] ptsr18_r0_dqsdqs1b3 ;
reg  [7:0] ptsr18_r0_dqsdqs1b3_ip ;
wire  [7:0] ptsr19_r0_dqsdqs1b4 ;
reg  [7:0] ptsr19_r0_dqsdqs1b4_ip ;
wire  [7:0] ptsr19_r0_dqsdqs1b5 ;
reg  [7:0] ptsr19_r0_dqsdqs1b5_ip ;
wire  [7:0] ptsr19_r0_dqsdqs1b6 ;
reg  [7:0] ptsr19_r0_dqsdqs1b6_ip ;
wire  [7:0] ptsr19_r0_dqsdqs1b7 ;
reg  [7:0] ptsr19_r0_dqsdqs1b7_ip ;
wire  [7:0] ptsr20_r0_dqsdqs2b0 ;
reg  [7:0] ptsr20_r0_dqsdqs2b0_ip ;
wire  [7:0] ptsr20_r0_dqsdqs2b1 ;
reg  [7:0] ptsr20_r0_dqsdqs2b1_ip ;
wire  [7:0] ptsr20_r0_dqsdqs2b2 ;
reg  [7:0] ptsr20_r0_dqsdqs2b2_ip ;
wire  [7:0] ptsr20_r0_dqsdqs2b3 ;
reg  [7:0] ptsr20_r0_dqsdqs2b3_ip ;
wire  [7:0] ptsr21_r0_dqsdqs2b4 ;
reg  [7:0] ptsr21_r0_dqsdqs2b4_ip ;
wire  [7:0] ptsr21_r0_dqsdqs2b5 ;
reg  [7:0] ptsr21_r0_dqsdqs2b5_ip ;
wire  [7:0] ptsr21_r0_dqsdqs2b6 ;
reg  [7:0] ptsr21_r0_dqsdqs2b6_ip ;
wire  [7:0] ptsr21_r0_dqsdqs2b7 ;
reg  [7:0] ptsr21_r0_dqsdqs2b7_ip ;
wire  [7:0] ptsr22_r0_dqsdqs3b0 ;
reg  [7:0] ptsr22_r0_dqsdqs3b0_ip ;
wire  [7:0] ptsr22_r0_dqsdqs3b1 ;
reg  [7:0] ptsr22_r0_dqsdqs3b1_ip ;
wire  [7:0] ptsr22_r0_dqsdqs3b2 ;
reg  [7:0] ptsr22_r0_dqsdqs3b2_ip ;
wire  [7:0] ptsr22_r0_dqsdqs3b3 ;
reg  [7:0] ptsr22_r0_dqsdqs3b3_ip ;
wire  [7:0] ptsr23_r0_dqsdqs3b4 ;
reg  [7:0] ptsr23_r0_dqsdqs3b4_ip ;
wire  [7:0] ptsr23_r0_dqsdqs3b5 ;
reg  [7:0] ptsr23_r0_dqsdqs3b5_ip ;
wire  [7:0] ptsr23_r0_dqsdqs3b6 ;
reg  [7:0] ptsr23_r0_dqsdqs3b6_ip ;
wire  [7:0] ptsr23_r0_dqsdqs3b7 ;
reg  [7:0] ptsr23_r0_dqsdqs3b7_ip ;
wire  [7:0] ptsr24_r0_dqsdms0 ;
reg  [7:0] ptsr24_r0_dqsdms0_ip ;
wire  [7:0] ptsr24_r0_dqsdms1 ;
reg  [7:0] ptsr24_r0_dqsdms1_ip ;
wire  [7:0] ptsr24_r0_dqsdms2 ;
reg  [7:0] ptsr24_r0_dqsdms2_ip ;
wire  [7:0] ptsr24_r0_dqsdms3 ;
reg  [7:0] ptsr24_r0_dqsdms3_ip ;
wire  [7:0] ptsr25_r0_rdlvldqs0b0 ;
reg  [7:0] ptsr25_r0_rdlvldqs0b0_ip ;
wire  [7:0] ptsr25_r0_rdlvldqs0b1 ;
reg  [7:0] ptsr25_r0_rdlvldqs0b1_ip ;
wire  [7:0] ptsr25_r0_rdlvldqs0b2 ;
reg  [7:0] ptsr25_r0_rdlvldqs0b2_ip ;
wire  [7:0] ptsr25_r0_rdlvldqs0b3 ;
reg  [7:0] ptsr25_r0_rdlvldqs0b3_ip ;
wire  [7:0] ptsr26_r0_rdlvldqs0b4 ;
reg  [7:0] ptsr26_r0_rdlvldqs0b4_ip ;
wire  [7:0] ptsr26_r0_rdlvldqs0b5 ;
reg  [7:0] ptsr26_r0_rdlvldqs0b5_ip ;
wire  [7:0] ptsr26_r0_rdlvldqs0b6 ;
reg  [7:0] ptsr26_r0_rdlvldqs0b6_ip ;
wire  [7:0] ptsr26_r0_rdlvldqs0b7 ;
reg  [7:0] ptsr26_r0_rdlvldqs0b7_ip ;
wire  [7:0] ptsr27_r0_rdlvldqs1b0 ;
reg  [7:0] ptsr27_r0_rdlvldqs1b0_ip ;
wire  [7:0] ptsr27_r0_rdlvldqs1b1 ;
reg  [7:0] ptsr27_r0_rdlvldqs1b1_ip ;
wire  [7:0] ptsr27_r0_rdlvldqs1b2 ;
reg  [7:0] ptsr27_r0_rdlvldqs1b2_ip ;
wire  [7:0] ptsr27_r0_rdlvldqs1b3 ;
reg  [7:0] ptsr27_r0_rdlvldqs1b3_ip ;
wire  [7:0] ptsr28_r0_rdlvldqs1b4 ;
reg  [7:0] ptsr28_r0_rdlvldqs1b4_ip ;
wire  [7:0] ptsr28_r0_rdlvldqs1b5 ;
reg  [7:0] ptsr28_r0_rdlvldqs1b5_ip ;
wire  [7:0] ptsr28_r0_rdlvldqs1b6 ;
reg  [7:0] ptsr28_r0_rdlvldqs1b6_ip ;
wire  [7:0] ptsr28_r0_rdlvldqs1b7 ;
reg  [7:0] ptsr28_r0_rdlvldqs1b7_ip ;
wire  [7:0] ptsr29_r0_rdlvldqs2b0 ;
reg  [7:0] ptsr29_r0_rdlvldqs2b0_ip ;
wire  [7:0] ptsr29_r0_rdlvldqs2b1 ;
reg  [7:0] ptsr29_r0_rdlvldqs2b1_ip ;
wire  [7:0] ptsr29_r0_rdlvldqs2b2 ;
reg  [7:0] ptsr29_r0_rdlvldqs2b2_ip ;
wire  [7:0] ptsr29_r0_rdlvldqs2b3 ;
reg  [7:0] ptsr29_r0_rdlvldqs2b3_ip ;
wire  [7:0] ptsr30_r0_rdlvldqs2b4 ;
reg  [7:0] ptsr30_r0_rdlvldqs2b4_ip ;
wire  [7:0] ptsr30_r0_rdlvldqs2b5 ;
reg  [7:0] ptsr30_r0_rdlvldqs2b5_ip ;
wire  [7:0] ptsr30_r0_rdlvldqs2b6 ;
reg  [7:0] ptsr30_r0_rdlvldqs2b6_ip ;
wire  [7:0] ptsr30_r0_rdlvldqs2b7 ;
reg  [7:0] ptsr30_r0_rdlvldqs2b7_ip ;
wire  [7:0] ptsr31_r0_rdlvldqs3b0 ;
reg  [7:0] ptsr31_r0_rdlvldqs3b0_ip ;
wire  [7:0] ptsr31_r0_rdlvldqs3b1 ;
reg  [7:0] ptsr31_r0_rdlvldqs3b1_ip ;
wire  [7:0] ptsr31_r0_rdlvldqs3b2 ;
reg  [7:0] ptsr31_r0_rdlvldqs3b2_ip ;
wire  [7:0] ptsr31_r0_rdlvldqs3b3 ;
reg  [7:0] ptsr31_r0_rdlvldqs3b3_ip ;
wire  [7:0] ptsr32_r0_rdlvldqs3b4 ;
reg  [7:0] ptsr32_r0_rdlvldqs3b4_ip ;
wire  [7:0] ptsr32_r0_rdlvldqs3b5 ;
reg  [7:0] ptsr32_r0_rdlvldqs3b5_ip ;
wire  [7:0] ptsr32_r0_rdlvldqs3b6 ;
reg  [7:0] ptsr32_r0_rdlvldqs3b6_ip ;
wire  [7:0] ptsr32_r0_rdlvldqs3b7 ;
reg  [7:0] ptsr32_r0_rdlvldqs3b7_ip ;
wire  [7:0] ptsr33_r0_rdlvldms0 ;
reg  [7:0] ptsr33_r0_rdlvldms0_ip ;
wire  [7:0] ptsr33_r0_rdlvldms1 ;
reg  [7:0] ptsr33_r0_rdlvldms1_ip ;
wire  [7:0] ptsr33_r0_rdlvldms2 ;
reg  [7:0] ptsr33_r0_rdlvldms2_ip ;
wire  [7:0] ptsr33_r0_rdlvldms3 ;
reg  [7:0] ptsr33_r0_rdlvldms3_ip ;
wire  [5:0] ptsr34_r0_vrefdqrds0 ;
reg  [5:0] ptsr34_r0_vrefdqrds0_ip ;
wire  [5:0] ptsr34_r0_vrefdqrds1 ;
reg  [5:0] ptsr34_r0_vrefdqrds1_ip ;
wire  [5:0] ptsr34_r0_vrefdqrds2 ;
reg  [5:0] ptsr34_r0_vrefdqrds2_ip ;
wire  [5:0] ptsr34_r0_vrefdqrds3 ;
reg  [5:0] ptsr34_r0_vrefdqrds3_ip ;
wire   ptsr34_r0_vrefdqrdr ;
reg   ptsr34_r0_vrefdqrdr_ip ;
wire   ptsr35_r1_vrefcar ;
reg   ptsr35_r1_vrefcar_ip ;
wire  [5:0] ptsr35_r1_vrefcas ;
reg  [5:0] ptsr35_r1_vrefcas_ip ;
wire   ptsr35_r1_vrefdqwrr ;
reg   ptsr35_r1_vrefdqwrr_ip ;
wire  [5:0] ptsr35_r1_vrefdqwrs ;
reg  [5:0] ptsr35_r1_vrefdqwrs_ip ;
wire  [6:0] ptsr36_r1_csc0 ;
reg  [6:0] ptsr36_r1_csc0_ip ;
wire  [6:0] ptsr36_r1_csc1 ;
reg  [6:0] ptsr36_r1_csc1_ip ;
wire  [6:0] ptsr36_r1_cac0b0 ;
reg  [6:0] ptsr36_r1_cac0b0_ip ;
wire  [6:0] ptsr36_r1_cac0b1 ;
reg  [6:0] ptsr36_r1_cac0b1_ip ;
wire  [6:0] ptsr37_r1_cac0b2 ;
reg  [6:0] ptsr37_r1_cac0b2_ip ;
wire  [6:0] ptsr37_r1_cac0b3 ;
reg  [6:0] ptsr37_r1_cac0b3_ip ;
wire  [6:0] ptsr37_r1_cac0b4 ;
reg  [6:0] ptsr37_r1_cac0b4_ip ;
wire  [6:0] ptsr37_r1_cac0b5 ;
reg  [6:0] ptsr37_r1_cac0b5_ip ;
wire  [6:0] ptsr38_r1_cac0b6 ;
reg  [6:0] ptsr38_r1_cac0b6_ip ;
wire  [6:0] ptsr38_r1_cac0b7 ;
reg  [6:0] ptsr38_r1_cac0b7_ip ;
wire  [6:0] ptsr38_r1_cac0b8 ;
reg  [6:0] ptsr38_r1_cac0b8_ip ;
wire  [6:0] ptsr38_r1_cac0b9 ;
reg  [6:0] ptsr38_r1_cac0b9_ip ;
wire  [6:0] ptsr39_r1_cac0b10 ;
reg  [6:0] ptsr39_r1_cac0b10_ip ;
wire  [6:0] ptsr39_r1_cac0b11 ;
reg  [6:0] ptsr39_r1_cac0b11_ip ;
wire  [6:0] ptsr39_r1_cac0b12 ;
reg  [6:0] ptsr39_r1_cac0b12_ip ;
wire  [6:0] ptsr39_r1_cac0b13 ;
reg  [6:0] ptsr39_r1_cac0b13_ip ;
wire  [6:0] ptsr40_r1_cac0b14 ;
reg  [6:0] ptsr40_r1_cac0b14_ip ;
wire  [6:0] ptsr40_r1_cac0b15 ;
reg  [6:0] ptsr40_r1_cac0b15_ip ;
wire  [6:0] ptsr40_r1_cac0b16 ;
reg  [6:0] ptsr40_r1_cac0b16_ip ;
wire  [6:0] ptsr40_r1_cac0b17 ;
reg  [6:0] ptsr40_r1_cac0b17_ip ;
wire  [6:0] ptsr41_r1_cac0b18 ;
reg  [6:0] ptsr41_r1_cac0b18_ip ;
wire  [6:0] ptsr41_r1_cac1b0 ;
reg  [6:0] ptsr41_r1_cac1b0_ip ;
wire  [6:0] ptsr41_r1_cac1b1 ;
reg  [6:0] ptsr41_r1_cac1b1_ip ;
wire  [6:0] ptsr41_r1_cac1b2 ;
reg  [6:0] ptsr41_r1_cac1b2_ip ;
wire  [6:0] ptsr42_r1_cac1b3 ;
reg  [6:0] ptsr42_r1_cac1b3_ip ;
wire  [6:0] ptsr42_r1_cac1b4 ;
reg  [6:0] ptsr42_r1_cac1b4_ip ;
wire  [6:0] ptsr42_r1_cac1b5 ;
reg  [6:0] ptsr42_r1_cac1b5_ip ;
wire  [6:0] ptsr42_r1_cac1b6 ;
reg  [6:0] ptsr42_r1_cac1b6_ip ;
wire  [6:0] ptsr43_r1_cac1b7 ;
reg  [6:0] ptsr43_r1_cac1b7_ip ;
wire  [6:0] ptsr43_r1_cac1b8 ;
reg  [6:0] ptsr43_r1_cac1b8_ip ;
wire  [6:0] ptsr43_r1_cac1b9 ;
reg  [6:0] ptsr43_r1_cac1b9_ip ;
wire  [6:0] ptsr43_r1_cac1b10 ;
reg  [6:0] ptsr43_r1_cac1b10_ip ;
wire  [6:0] ptsr44_r1_cac1b11 ;
reg  [6:0] ptsr44_r1_cac1b11_ip ;
wire  [6:0] ptsr44_r1_cac1b12 ;
reg  [6:0] ptsr44_r1_cac1b12_ip ;
wire  [6:0] ptsr44_r1_cac1b13 ;
reg  [6:0] ptsr44_r1_cac1b13_ip ;
wire  [6:0] ptsr44_r1_cac1b14 ;
reg  [6:0] ptsr44_r1_cac1b14_ip ;
wire  [6:0] ptsr45_r1_cac1b15 ;
reg  [6:0] ptsr45_r1_cac1b15_ip ;
wire  [6:0] ptsr45_r1_cac1b16 ;
reg  [6:0] ptsr45_r1_cac1b16_ip ;
wire  [6:0] ptsr45_r1_cac1b17 ;
reg  [6:0] ptsr45_r1_cac1b17_ip ;
wire  [6:0] ptsr45_r1_cac1b18 ;
reg  [6:0] ptsr45_r1_cac1b18_ip ;
wire  [6:0] ptsr46_r1_bac0b0 ;
wire  [6:0] ptsr46_r1_bac0b1 ;
wire  [6:0] ptsr46_r1_bac0b2 ;
wire  [6:0] ptsr46_r1_bac0b3 ;
wire  [6:0] ptsr47_r1_bac1b0 ;
wire  [6:0] ptsr47_r1_bac1b1 ;
wire  [6:0] ptsr47_r1_bac1b2 ;
wire  [6:0] ptsr47_r1_bac1b3 ;
wire  [6:0] ptsr48_r1_actnc0 ;
wire  [6:0] ptsr48_r1_actnc1 ;
wire  [6:0] ptsr48_r1_ckec0 ;
wire  [6:0] ptsr48_r1_ckec1 ;
wire  [5:0] ptsr49_r1_gts0 ;
reg  [5:0] ptsr49_r1_gts0_ip ;
wire  [5:0] ptsr49_r1_gts1 ;
reg  [5:0] ptsr49_r1_gts1_ip ;
wire  [5:0] ptsr49_r1_gts2 ;
reg  [5:0] ptsr49_r1_gts2_ip ;
wire  [5:0] ptsr49_r1_gts3 ;
reg  [5:0] ptsr49_r1_gts3_ip ;
wire  [7:0] ptsr50_r1_wrlvls0 ;
reg  [7:0] ptsr50_r1_wrlvls0_ip ;
wire  [7:0] ptsr50_r1_wrlvls1 ;
reg  [7:0] ptsr50_r1_wrlvls1_ip ;
wire  [7:0] ptsr50_r1_wrlvls2 ;
reg  [7:0] ptsr50_r1_wrlvls2_ip ;
wire  [7:0] ptsr50_r1_wrlvls3 ;
reg  [7:0] ptsr50_r1_wrlvls3_ip ;
wire  [7:0] ptsr51_r1_dqsdqs0b0 ;
reg  [7:0] ptsr51_r1_dqsdqs0b0_ip ;
wire  [7:0] ptsr51_r1_dqsdqs0b1 ;
reg  [7:0] ptsr51_r1_dqsdqs0b1_ip ;
wire  [7:0] ptsr51_r1_dqsdqs0b2 ;
reg  [7:0] ptsr51_r1_dqsdqs0b2_ip ;
wire  [7:0] ptsr51_r1_dqsdqs0b3 ;
reg  [7:0] ptsr51_r1_dqsdqs0b3_ip ;
wire  [7:0] ptsr52_r1_dqsdqs0b4 ;
reg  [7:0] ptsr52_r1_dqsdqs0b4_ip ;
wire  [7:0] ptsr52_r1_dqsdqs0b5 ;
reg  [7:0] ptsr52_r1_dqsdqs0b5_ip ;
wire  [7:0] ptsr52_r1_dqsdqs0b6 ;
reg  [7:0] ptsr52_r1_dqsdqs0b6_ip ;
wire  [7:0] ptsr52_r1_dqsdqs0b7 ;
reg  [7:0] ptsr52_r1_dqsdqs0b7_ip ;
wire  [7:0] ptsr53_r1_dqsdqs1b0 ;
reg  [7:0] ptsr53_r1_dqsdqs1b0_ip ;
wire  [7:0] ptsr53_r1_dqsdqs1b1 ;
reg  [7:0] ptsr53_r1_dqsdqs1b1_ip ;
wire  [7:0] ptsr53_r1_dqsdqs1b2 ;
reg  [7:0] ptsr53_r1_dqsdqs1b2_ip ;
wire  [7:0] ptsr53_r1_dqsdqs1b3 ;
reg  [7:0] ptsr53_r1_dqsdqs1b3_ip ;
wire  [7:0] ptsr54_r1_dqsdqs1b4 ;
reg  [7:0] ptsr54_r1_dqsdqs1b4_ip ;
wire  [7:0] ptsr54_r1_dqsdqs1b5 ;
reg  [7:0] ptsr54_r1_dqsdqs1b5_ip ;
wire  [7:0] ptsr54_r1_dqsdqs1b6 ;
reg  [7:0] ptsr54_r1_dqsdqs1b6_ip ;
wire  [7:0] ptsr54_r1_dqsdqs1b7 ;
reg  [7:0] ptsr54_r1_dqsdqs1b7_ip ;
wire  [7:0] ptsr55_r1_dqsdqs2b0 ;
reg  [7:0] ptsr55_r1_dqsdqs2b0_ip ;
wire  [7:0] ptsr55_r1_dqsdqs2b1 ;
reg  [7:0] ptsr55_r1_dqsdqs2b1_ip ;
wire  [7:0] ptsr55_r1_dqsdqs2b2 ;
reg  [7:0] ptsr55_r1_dqsdqs2b2_ip ;
wire  [7:0] ptsr55_r1_dqsdqs2b3 ;
reg  [7:0] ptsr55_r1_dqsdqs2b3_ip ;
wire  [7:0] ptsr56_r1_dqsdqs2b4 ;
reg  [7:0] ptsr56_r1_dqsdqs2b4_ip ;
wire  [7:0] ptsr56_r1_dqsdqs2b5 ;
reg  [7:0] ptsr56_r1_dqsdqs2b5_ip ;
wire  [7:0] ptsr56_r1_dqsdqs2b6 ;
reg  [7:0] ptsr56_r1_dqsdqs2b6_ip ;
wire  [7:0] ptsr56_r1_dqsdqs2b7 ;
reg  [7:0] ptsr56_r1_dqsdqs2b7_ip ;
wire  [7:0] ptsr57_r1_dqsdqs3b0 ;
reg  [7:0] ptsr57_r1_dqsdqs3b0_ip ;
wire  [7:0] ptsr57_r1_dqsdqs3b1 ;
reg  [7:0] ptsr57_r1_dqsdqs3b1_ip ;
wire  [7:0] ptsr57_r1_dqsdqs3b2 ;
reg  [7:0] ptsr57_r1_dqsdqs3b2_ip ;
wire  [7:0] ptsr57_r1_dqsdqs3b3 ;
reg  [7:0] ptsr57_r1_dqsdqs3b3_ip ;
wire  [7:0] ptsr58_r1_dqsdqs3b4 ;
reg  [7:0] ptsr58_r1_dqsdqs3b4_ip ;
wire  [7:0] ptsr58_r1_dqsdqs3b5 ;
reg  [7:0] ptsr58_r1_dqsdqs3b5_ip ;
wire  [7:0] ptsr58_r1_dqsdqs3b6 ;
reg  [7:0] ptsr58_r1_dqsdqs3b6_ip ;
wire  [7:0] ptsr58_r1_dqsdqs3b7 ;
reg  [7:0] ptsr58_r1_dqsdqs3b7_ip ;
wire  [7:0] ptsr59_r1_dqsdms0 ;
reg  [7:0] ptsr59_r1_dqsdms0_ip ;
wire  [7:0] ptsr59_r1_dqsdms1 ;
reg  [7:0] ptsr59_r1_dqsdms1_ip ;
wire  [7:0] ptsr59_r1_dqsdms2 ;
reg  [7:0] ptsr59_r1_dqsdms2_ip ;
wire  [7:0] ptsr59_r1_dqsdms3 ;
reg  [7:0] ptsr59_r1_dqsdms3_ip ;
wire  [7:0] ptsr60_r1_rdlvldqs0b0 ;
reg  [7:0] ptsr60_r1_rdlvldqs0b0_ip ;
wire  [7:0] ptsr60_r1_rdlvldqs0b1 ;
reg  [7:0] ptsr60_r1_rdlvldqs0b1_ip ;
wire  [7:0] ptsr60_r1_rdlvldqs0b2 ;
reg  [7:0] ptsr60_r1_rdlvldqs0b2_ip ;
wire  [7:0] ptsr60_r1_rdlvldqs0b3 ;
reg  [7:0] ptsr60_r1_rdlvldqs0b3_ip ;
wire  [7:0] ptsr61_r1_rdlvldqs0b4 ;
reg  [7:0] ptsr61_r1_rdlvldqs0b4_ip ;
wire  [7:0] ptsr61_r1_rdlvldqs0b5 ;
reg  [7:0] ptsr61_r1_rdlvldqs0b5_ip ;
wire  [7:0] ptsr61_r1_rdlvldqs0b6 ;
reg  [7:0] ptsr61_r1_rdlvldqs0b6_ip ;
wire  [7:0] ptsr61_r1_rdlvldqs0b7 ;
reg  [7:0] ptsr61_r1_rdlvldqs0b7_ip ;
wire  [7:0] ptsr62_r1_rdlvldqs1b0 ;
reg  [7:0] ptsr62_r1_rdlvldqs1b0_ip ;
wire  [7:0] ptsr62_r1_rdlvldqs1b1 ;
reg  [7:0] ptsr62_r1_rdlvldqs1b1_ip ;
wire  [7:0] ptsr62_r1_rdlvldqs1b2 ;
reg  [7:0] ptsr62_r1_rdlvldqs1b2_ip ;
wire  [7:0] ptsr62_r1_rdlvldqs1b3 ;
reg  [7:0] ptsr62_r1_rdlvldqs1b3_ip ;
wire  [7:0] ptsr63_r1_rdlvldqs1b4 ;
reg  [7:0] ptsr63_r1_rdlvldqs1b4_ip ;
wire  [7:0] ptsr63_r1_rdlvldqs1b5 ;
reg  [7:0] ptsr63_r1_rdlvldqs1b5_ip ;
wire  [7:0] ptsr63_r1_rdlvldqs1b6 ;
reg  [7:0] ptsr63_r1_rdlvldqs1b6_ip ;
wire  [7:0] ptsr63_r1_rdlvldqs1b7 ;
reg  [7:0] ptsr63_r1_rdlvldqs1b7_ip ;
wire  [7:0] ptsr64_r1_rdlvldqs2b0 ;
reg  [7:0] ptsr64_r1_rdlvldqs2b0_ip ;
wire  [7:0] ptsr64_r1_rdlvldqs2b1 ;
reg  [7:0] ptsr64_r1_rdlvldqs2b1_ip ;
wire  [7:0] ptsr64_r1_rdlvldqs2b2 ;
reg  [7:0] ptsr64_r1_rdlvldqs2b2_ip ;
wire  [7:0] ptsr64_r1_rdlvldqs2b3 ;
reg  [7:0] ptsr64_r1_rdlvldqs2b3_ip ;
wire  [7:0] ptsr65_r1_rdlvldqs2b4 ;
reg  [7:0] ptsr65_r1_rdlvldqs2b4_ip ;
wire  [7:0] ptsr65_r1_rdlvldqs2b5 ;
reg  [7:0] ptsr65_r1_rdlvldqs2b5_ip ;
wire  [7:0] ptsr65_r1_rdlvldqs2b6 ;
reg  [7:0] ptsr65_r1_rdlvldqs2b6_ip ;
wire  [7:0] ptsr65_r1_rdlvldqs2b7 ;
reg  [7:0] ptsr65_r1_rdlvldqs2b7_ip ;
wire  [7:0] ptsr66_r1_rdlvldqs3b0 ;
reg  [7:0] ptsr66_r1_rdlvldqs3b0_ip ;
wire  [7:0] ptsr66_r1_rdlvldqs3b1 ;
reg  [7:0] ptsr66_r1_rdlvldqs3b1_ip ;
wire  [7:0] ptsr66_r1_rdlvldqs3b2 ;
reg  [7:0] ptsr66_r1_rdlvldqs3b2_ip ;
wire  [7:0] ptsr66_r1_rdlvldqs3b3 ;
reg  [7:0] ptsr66_r1_rdlvldqs3b3_ip ;
wire  [7:0] ptsr67_r1_rdlvldqs3b4 ;
reg  [7:0] ptsr67_r1_rdlvldqs3b4_ip ;
wire  [7:0] ptsr67_r1_rdlvldqs3b5 ;
reg  [7:0] ptsr67_r1_rdlvldqs3b5_ip ;
wire  [7:0] ptsr67_r1_rdlvldqs3b6 ;
reg  [7:0] ptsr67_r1_rdlvldqs3b6_ip ;
wire  [7:0] ptsr67_r1_rdlvldqs3b7 ;
reg  [7:0] ptsr67_r1_rdlvldqs3b7_ip ;
wire  [7:0] ptsr68_r1_rdlvldms0 ;
reg  [7:0] ptsr68_r1_rdlvldms0_ip ;
wire  [7:0] ptsr68_r1_rdlvldms1 ;
reg  [7:0] ptsr68_r1_rdlvldms1_ip ;
wire  [7:0] ptsr68_r1_rdlvldms2 ;
reg  [7:0] ptsr68_r1_rdlvldms2_ip ;
wire  [7:0] ptsr68_r1_rdlvldms3 ;
reg  [7:0] ptsr68_r1_rdlvldms3_ip ;
wire  [3:0] ptsr69_r0_psck ;
reg  [3:0] ptsr69_r0_psck_ip ;
wire  [3:0] ptsr69_r0_dqsleadck ;
reg  [3:0] ptsr69_r0_dqsleadck_ip ;
wire  [3:0] ptsr69_r1_psck ;
reg  [3:0] ptsr69_r1_psck_ip ;
wire  [3:0] ptsr69_r1_dqsleadck ;
reg  [3:0] ptsr69_r1_dqsleadck_ip ;
wire  [15:0] ptsr69_sanpat ;
wire  [6:0] ptsr70_odtc0 ;
wire  [6:0] ptsr70_odtc1 ;
wire  [6:0] ptsr70_rstnc0 ;
wire  [6:0] ptsr70_rstnc1 ;
wire   ptsr70_nt_rank ;
reg   ptsr70_nt_rank_ip ;
wire  [5:0] treg1_t_alrtp ;
wire  [4:0] treg1_t_ckesr ;
wire  [4:0] treg1_t_ccd_s ;
wire  [6:0] treg1_t_faw ;
wire  [7:0] treg1_t_rtw ;
wire  [5:0] treg2_t_rcd ;
wire  [7:0] treg2_t_rdpden ;
wire  [7:0] treg2_t_rc ;
wire  [7:0] treg2_t_ras ;
wire  [5:0] treg3_t_pd ;
wire  [5:0] treg3_t_rp ;
wire  [7:0] treg3_t_wlbr ;
wire  [7:0] treg3_t_wrapden ;
wire  [3:0] treg3_t_cke ;
wire  [4:0] treg4_t_xp ;
wire  [9:0] treg4_t_vreftimelong ;
wire  [7:0] treg4_t_vreftimeshort ;
wire  [5:0] treg4_t_mrd ;
wire  [27:0] treg5_t_zqcs_itv ;
wire  [19:0] treg6_t_pori ;
wire  [10:0] treg6_t_zqinit ;
wire  [7:0] treg7_t_mrs2lvlen ;
wire  [7:0] treg7_t_zqcs ;
wire  [5:0] treg7_t_xpdll ;
wire  [6:0] treg7_t_wlbtr ;
wire  [4:0] treg8_t_rrd_s ;
wire  [9:0] treg8_t_rfc1 ;
wire  [7:0] treg8_t_mrs2act ;
wire  [7:0] treg8_t_lvlaa ;
wire  [10:0] treg9_t_dllk ;
wire  [13:0] treg9_t_refi_off ;
wire  [1:0] treg9_t_mprr ;
wire  [19:0] treg10_t_xpr ;
wire  [7:0] treg10_t_dllrst ;
wire  [19:0] treg11_t_rst ;
wire  [7:0] treg11_t_odth4 ;
wire  [7:0] treg12_t_odth8 ;
wire  [7:0] treg12_t_lvlload ;
wire  [7:0] treg12_t_lvldll ;
wire  [7:0] treg12_t_lvlresp ;
wire  [9:0] treg13_t_xs ;
wire  [5:0] treg13_t_mod ;
wire  [19:0] treg14_t_dpd ;
wire  [4:0] treg14_t_mrw ;
wire  [6:0] treg14_t_wr2rd ;
wire  [5:0] treg15_t_mrr ;
wire  [7:0] treg15_t_zqrs ;
wire  [4:0] treg15_t_dqscke ;
wire  [9:0] treg15_t_xsr ;
wire  [5:0] treg16_t_mped ;
wire  [4:0] treg16_t_mpx ;
wire  [5:0] treg16_t_wr_mpr ;
wire  [13:0] treg16_t_init5 ;
wire  [2:0] treg17_t_setgear ;
wire  [5:0] treg17_t_syncgear ;
wire  [15:0] treg17_t_dlllock ;
wire  [6:0] treg17_t_wlbtr_s ;
wire  [9:0] treg18_t_read_low ;
wire  [9:0] treg18_t_read_high ;
wire  [9:0] treg19_t_write_low ;
wire  [9:0] treg19_t_write_high ;
wire  [9:0] treg20_t_rfc2 ;
wire  [9:0] treg20_t_rfc4 ;
wire  [6:0] treg21_t_wlbr_crcdm ;
wire  [6:0] treg21_t_wlbtr_crcdm_l ;
wire  [6:0] treg21_t_wlbtr_crcdm_s ;
wire  [10:0] treg21_t_xmpdll ;
wire  [7:0] treg22_t_wrmpr ;
wire  [7:0] treg22_t_lvlexit ;
wire  [7:0] treg22_t_lvldis ;
wire  [11:0] treg23_t_zqoper ;
wire  [9:0] treg23_t_rfc ;
wire  [10:0] treg24_t_xsdll ;
wire  [4:0] treg24_odtlon ;
wire  [4:0] treg25_odtloff ;
wire  [5:0] treg25_t_wlmrd ;
wire  [4:0] treg25_t_wldqsen ;
wire  [3:0] treg25_t_wtr ;
wire  [7:0] treg26_t_rda2pd ;
wire  [7:0] treg26_t_wra2pd ;
wire  [11:0] treg26_t_zqcl ;
wire  [7:0] treg27_t_calvl_adr_ckeh ;
wire  [7:0] treg27_t_calvl_capture ;
wire  [7:0] treg27_t_calvl_cc ;
wire  [7:0] treg27_t_calvl_en ;
wire  [7:0] treg28_t_calvl_ext ;
wire  [7:0] treg28_t_calvl_max ;
wire  [4:0] treg29_t_ckehdqs ;
wire  [4:0] treg29_t_ccd ;
wire  [6:0] treg29_t_zqlat ;
wire  [1:0] treg29_t_ckckeh ;
wire  [4:0] treg30_t_rrd ;
wire  [9:0] treg30_t_caent ;
wire  [3:0] treg30_t_cmdcke ;
wire  [5:0] treg30_t_mpcwr ;
wire  [5:0] treg30_t_dqrpt ;
wire  [27:0] treg31_t_zq_itv ;
wire  [3:0] treg31_t_ckelck ;
wire  [7:0] treg32_t_dllen ;
wire  [17:0] treg32_t_init3 ;
wire  [2:0] treg32_t_dtrain ;
wire  [6:0] treg33_t_mpcwr2rd ;
wire  [9:0] treg33_t_fc ;
wire  [13:0] treg33_t_refi ;
wire  [8:0] treg34_t_vrcgen ;
wire  [7:0] treg34_t_vrcgdis ;
wire  [7:0] treg34_t_odtup ;
wire  [5:0] treg34_t_ccdwm ;
wire  [7:0] treg35_t_osco ;
wire  [3:0] treg35_t_ckfspe ;
wire  [3:0] treg35_t_ckfspx ;
wire  [13:0] treg35_t_init1 ;
wire  [10:0] treg36_t_zqcal ;
wire  [7:0] treg36_t_lvlresp_nr ;
wire  [3:0] treg36_t_ppd ;
wire   bistcfg_ch0_start_rank ;
wire   bistcfg_ch0_end_rank ;
wire  [3:0] bistcfg_ch0_start_bank ;
wire  [3:0] bistcfg_ch0_end_bank ;
wire  [2:0] bistcfg_ch0_start_background ;
wire  [2:0] bistcfg_ch0_end_background ;
wire  [3:0] bistcfg_ch0_element ;
wire  [3:0] bistcfg_ch0_operation ;
wire  [3:0] bistcfg_ch0_retention ;
wire   bistcfg_ch0_diagnosis_en ;
wire   bistcfg_ch1_start_rank ;
wire   bistcfg_ch1_end_rank ;
wire  [3:0] bistcfg_ch1_start_bank ;
wire  [3:0] bistcfg_ch1_end_bank ;
wire  [2:0] bistcfg_ch1_start_background ;
wire  [2:0] bistcfg_ch1_end_background ;
wire  [3:0] bistcfg_ch1_element ;
wire  [3:0] bistcfg_ch1_operation ;
wire  [3:0] bistcfg_ch1_retention ;
wire   bistcfg_ch1_diagnosis_en ;
wire  [16:0] biststaddr_ch0_start_row ;
wire  [10:0] biststaddr_ch0_start_col ;
wire  [16:0] biststaddr_ch1_start_row ;
wire  [10:0] biststaddr_ch1_start_col ;
wire  [16:0] bistedaddr_ch0_end_row ;
wire  [10:0] bistedaddr_ch0_end_col ;
wire  [16:0] bistedaddr_ch1_end_row ;
wire  [10:0] bistedaddr_ch1_end_col ;
wire  [31:0] bistm0_ch0_march_element_0 ;
wire  [31:0] bistm0_ch1_march_element_0 ;
wire  [31:0] bistm1_ch0_march_element_1 ;
wire  [31:0] bistm1_ch1_march_element_1 ;
wire  [31:0] bistm2_ch0_march_element_2 ;
wire  [31:0] bistm2_ch1_march_element_2 ;
wire  [31:0] bistm3_ch0_march_element_3 ;
wire  [31:0] bistm3_ch1_march_element_3 ;
wire  [31:0] bistm4_ch0_march_element_4 ;
wire  [31:0] bistm4_ch1_march_element_4 ;
wire  [31:0] bistm5_ch0_march_element_5 ;
wire  [31:0] bistm5_ch1_march_element_5 ;
wire  [31:0] bistm6_ch0_march_element_6 ;
wire  [31:0] bistm6_ch1_march_element_6 ;
wire  [31:0] bistm7_ch0_march_element_7 ;
wire  [31:0] bistm7_ch1_march_element_7 ;
wire  [31:0] bistm8_ch0_march_element_8 ;
wire  [31:0] bistm8_ch1_march_element_8 ;
wire  [31:0] bistm9_ch0_march_element_9 ;
wire  [31:0] bistm9_ch1_march_element_9 ;
wire  [31:0] bistm10_ch0_march_element_10 ;
wire  [31:0] bistm10_ch1_march_element_10 ;
wire  [31:0] bistm11_ch0_march_element_11 ;
wire  [31:0] bistm11_ch1_march_element_11 ;
wire  [31:0] bistm12_ch0_march_element_12 ;
wire  [31:0] bistm12_ch1_march_element_12 ;
wire  [31:0] bistm13_ch0_march_element_13 ;
wire  [31:0] bistm13_ch1_march_element_13 ;
wire  [31:0] bistm14_ch0_march_element_14 ;
wire  [31:0] bistm14_ch1_march_element_14 ;
wire  [31:0] bistm15_ch0_march_element_15 ;
wire  [31:0] bistm15_ch1_march_element_15 ;
wire  [15:0] dvstt0_device_id ;
wire  [1:0] dvstt1_dram_bl_enc ;
wire   opstt_ch0_dram_pause ;
wire   opstt_ch0_user_cmd_ready ;
wire  [15:0] opstt_ch0_bank_idle ;
wire   opstt_ch0_xqr_empty ;
wire   opstt_ch0_xqr_full ;
wire   opstt_ch0_xqw_empty ;
wire   opstt_ch0_xqw_full ;
wire   opstt_ch1_dram_pause ;
wire   opstt_ch1_user_cmd_ready ;
wire  [15:0] opstt_ch1_bank_idle ;
wire   opstt_ch1_xqr_empty ;
wire   opstt_ch1_xqr_full ;
wire   opstt_ch1_xqw_empty ;
wire   opstt_ch1_xqw_full ;
wire   intstt_ch0_int_gc_fsm ;
wire   intstt_ch1_int_gc_fsm ;
wire   ddrbiststt_ch0_error ;
wire   ddrbiststt_ch0_endtest ;
wire   ddrbiststt_ch0_error_new ;
wire   ddrbiststt_ch0_rank_fail ;
wire  [3:0] ddrbiststt_ch0_bank_fail ;
wire  [16:0] ddrbiststt_ch0_row_fail ;
wire   ddrbiststt_ch1_error ;
wire   ddrbiststt_ch1_endtest ;
wire   ddrbiststt_ch1_error_new ;
wire   ddrbiststt_ch1_rank_fail ;
wire  [3:0] ddrbiststt_ch1_bank_fail ;
wire  [16:0] ddrbiststt_ch1_row_fail ;
wire  [3:0] pts0_r0_vrefdqrderr ;
wire  [1:0] pts0_r0_vrefcaerr ;
wire  [3:0] pts0_r0_gterr ;
wire  [3:0] pts0_r0_wrlvlerr ;
wire  [3:0] pts0_r0_vrefdqwrerr ;
wire  [3:0] pts0_r0_rdlvldmerr ;
wire  [5:0] pts0_dllerr ;
wire  [3:0] pts0_lp3calvlerr ;
wire  [3:0] pts1_r0_sanchkerr ;
wire  [3:0] pts1_r0_dqsdmerr ;
wire  [3:0] pts1_r1_sanchkerr ;
wire  [3:0] pts1_r1_dqsdmerr ;
wire  [31:0] pts2_r0_rdlvldqerr ;
wire  [31:0] pts3_r0_dqsdqerr ;
wire  [3:0] pts4_r1_vrefdqrderr ;
wire  [1:0] pts4_r1_vrefcaerr ;
wire  [3:0] pts4_r1_gterr ;
wire  [3:0] pts4_r1_wrlvlerr ;
wire  [3:0] pts4_r1_vrefdqwrerr ;
wire  [3:0] pts4_r1_rdlvldmerr ;
wire  [31:0] pts5_r1_rdlvldqerr ;
wire  [31:0] pts6_r1_dqsdqerr ;
wire   mpr_done ;
wire  [7:0] mpr_readout ;
wire   mrr_ch0_done ;
wire  [7:0] mrr_ch0_readout ;
wire   mrr_ch1_done ;
wire  [7:0] mrr_ch1_readout ;
wire  [1:0] shad_lpmr1_fs0_bl ;
wire   shad_lpmr1_fs0_wpre ;
wire   shad_lpmr1_fs0_rpre ;
wire  [2:0] shad_lpmr1_fs0_nwr ;
wire   shad_lpmr1_fs0_rpst ;
wire  [1:0] shad_lpmr1_fs1_bl ;
wire   shad_lpmr1_fs1_wpre ;
wire   shad_lpmr1_fs1_rpre ;
wire  [2:0] shad_lpmr1_fs1_nwr ;
wire   shad_lpmr1_fs1_rpst ;
wire  [2:0] shad_lpmr2_fs0_rl ;
wire  [2:0] shad_lpmr2_fs0_wl ;
wire   shad_lpmr2_fs0_wls ;
wire   shad_lpmr2_wrlev ;
wire  [2:0] shad_lpmr2_fs1_rl ;
wire  [2:0] shad_lpmr2_fs1_wl ;
wire   shad_lpmr2_fs1_wls ;
wire   shad_lpmr2_reserved ;
wire   shad_lpmr3_fs0_pucal ;
wire   shad_lpmr3_fs0_wpst ;
wire   shad_lpmr3_pprp ;
wire  [2:0] shad_lpmr3_fs0_pdds ;
wire   shad_lpmr3_fs0_rdbi ;
wire   shad_lpmr3_fs0_wdbi ;
wire   shad_lpmr3_fs1_pucal ;
wire   shad_lpmr3_fs1_wpst ;
wire   shad_lpmr3_reserved ;
wire  [2:0] shad_lpmr3_fs1_pdds ;
wire   shad_lpmr3_fs1_rdbi ;
wire   shad_lpmr3_fs1_wdbi ;
wire  [2:0] shad_lpmr11_fs0_dqodt ;
wire   shad_lpmr11_reserved0 ;
wire  [2:0] shad_lpmr11_fs0_caodt ;
wire   shad_lpmr11_reserved1 ;
wire  [2:0] shad_lpmr11_fs1_dqodt ;
wire   shad_lpmr11_reserved2 ;
wire  [2:0] shad_lpmr11_fs1_caodt ;
wire   shad_lpmr11_reserved3 ;
wire  [2:0] shad_lpmr11_nt_fs0_dqodt ;
wire   shad_lpmr11_nt_reserved0 ;
wire  [2:0] shad_lpmr11_nt_fs0_caodt ;
wire   shad_lpmr11_nt_reserved1 ;
wire  [2:0] shad_lpmr11_nt_fs1_dqodt ;
wire   shad_lpmr11_nt_reserved2 ;
wire  [2:0] shad_lpmr11_nt_fs1_caodt ;
wire   shad_lpmr11_nt_reserved3 ;
wire  [5:0] shad_lpmr12_fs0_vrefcas ;
wire   shad_lpmr12_fs0_vrefcar ;
wire   shad_lpmr12_reserved0 ;
wire  [5:0] shad_lpmr12_fs1_vrefcas ;
wire   shad_lpmr12_fs1_vrefcar ;
wire   shad_lpmr12_reserved1 ;
wire   shad_lpmr13_cbt ;
wire   shad_lpmr13_rpt ;
wire   shad_lpmr13_vro ;
wire   shad_lpmr13_vrcg ;
wire   shad_lpmr13_rro ;
wire   shad_lpmr13_dmd ;
wire   shad_lpmr13_fspwr ;
wire   shad_lpmr13_fspop ;
wire  [5:0] shad_lpmr14_fs0_vrefdqs ;
wire   shad_lpmr14_fs0_vrefdqr ;
wire   shad_lpmr14_reserved0 ;
wire  [5:0] shad_lpmr14_fs1_vrefdqs ;
wire   shad_lpmr14_fs1_vrefdqr ;
wire   shad_lpmr14_reserved1 ;
wire  [2:0] shad_lpmr22_fs0_socodt ;
wire   shad_lpmr22_fs0_odteck ;
wire   shad_lpmr22_fs0_odtecs ;
wire   shad_lpmr22_fs0_odtdca ;
wire  [1:0] shad_lpmr22_odtdx8 ;
wire  [2:0] shad_lpmr22_fs1_socodt ;
wire   shad_lpmr22_fs1_odteck ;
wire   shad_lpmr22_fs1_odtecs ;
wire   shad_lpmr22_fs1_odtdca ;
wire  [1:0] shad_lpmr22_reserved ;
wire  [2:0] shad_lpmr22_nt_fs0_socodt ;
wire   shad_lpmr22_nt_fs0_odteck ;
wire   shad_lpmr22_nt_fs0_odtecs ;
wire   shad_lpmr22_nt_fs0_odtdca ;
wire  [1:0] shad_lpmr22_nt_odtdx8 ;
wire  [2:0] shad_lpmr22_nt_fs1_socodt ;
wire   shad_lpmr22_nt_fs1_odteck ;
wire   shad_lpmr22_nt_fs1_odtecs ;
wire   shad_lpmr22_nt_fs1_odtdca ;
wire  [1:0] shad_lpmr22_nt_reserved ;
wire  [31:0] data0_rddata ;
wire  [31:0] data1_rddata ;
wire  [31:0] data2_rddata ;
wire  [31:0] data3_rddata ;
wire  [31:0] data4_rddata ;
wire  [31:0] data5_rddata ;
wire  [31:0] data6_rddata ;
wire  [31:0] data7_rddata ;
wire  [31:0] data8_rddata ;
wire  [31:0] data9_rddata ;
wire  [31:0] data10_rddata ;
wire  [31:0] data11_rddata ;
wire  [31:0] data12_rddata ;
wire  [31:0] data13_rddata ;
wire  [31:0] data14_rddata ;
wire  [31:0] data15_rddata ;
wire   data16_rdvalid ;
wire   int_gc_fsm_ch0 ;
wire   int_gc_fsm_ch1 ;
wire   dvstt1_ddr4_en ;
wire   dvstt1_ddr3_en ;
wire   dvstt1_lpddr3_en ;
wire   dvstt1_lpddr4_en ;
reg  [4:0] Tpl_1730 ;
reg  [1:0] Tpl_1731 ;
reg  [1:0] Tpl_1732 ;
reg  [5:0] Tpl_1733 ;
reg   Tpl_1734 ;
reg  [7:0] Tpl_1735 ;
reg  [2:0] Tpl_1736 ;
reg  [1:0] Tpl_1737 ;
reg  [2:0] Tpl_1738 ;
reg   Tpl_1739 ;
reg   Tpl_1740 ;
reg   Tpl_1741 ;
reg   Tpl_1742 ;
reg   Tpl_1743 ;
reg   Tpl_1744 ;
reg  [6:0] Tpl_1745 ;
reg  [7:0] Tpl_1746 ;
reg   Tpl_1747 ;
reg   Tpl_1748 ;
reg   Tpl_1749 ;
reg   Tpl_1750 ;
reg   Tpl_1751 ;
reg   Tpl_1752 ;
reg   Tpl_1753 ;
reg   Tpl_1754 ;
reg  [2:0] Tpl_1755 ;
reg   Tpl_1756 ;
reg   Tpl_1757 ;
reg   Tpl_1758 ;
reg  [1:0] Tpl_1759 ;
reg   Tpl_1760 ;
reg   Tpl_1761 ;
reg  [2:0] Tpl_1762 ;
reg   Tpl_1763 ;
reg  [1:0] Tpl_1764 ;
reg   Tpl_1765 ;
reg   Tpl_1766 ;
reg  [2:0] Tpl_1767 ;
reg   Tpl_1768 ;
reg  [2:0] Tpl_1769 ;
reg  [2:0] Tpl_1770 ;
reg   Tpl_1771 ;
reg   Tpl_1772 ;
reg  [2:0] Tpl_1773 ;
reg  [2:0] Tpl_1774 ;
reg   Tpl_1775 ;
reg   Tpl_1776 ;
reg   Tpl_1777 ;
reg   Tpl_1778 ;
reg  [2:0] Tpl_1779 ;
reg   Tpl_1780 ;
reg   Tpl_1781 ;
reg   Tpl_1782 ;
reg   Tpl_1783 ;
reg  [2:0] Tpl_1784 ;
reg   Tpl_1785 ;
reg   Tpl_1786 ;
reg  [2:0] Tpl_1787 ;
reg  [2:0] Tpl_1788 ;
reg  [2:0] Tpl_1789 ;
reg  [2:0] Tpl_1790 ;
reg  [2:0] Tpl_1791 ;
reg  [2:0] Tpl_1792 ;
reg  [2:0] Tpl_1793 ;
reg  [2:0] Tpl_1794 ;
reg  [5:0] Tpl_1795 ;
reg   Tpl_1796 ;
reg  [5:0] Tpl_1797 ;
reg   Tpl_1798 ;
reg   Tpl_1799 ;
reg   Tpl_1800 ;
reg   Tpl_1801 ;
reg   Tpl_1802 ;
reg   Tpl_1803 ;
reg   Tpl_1804 ;
reg   Tpl_1805 ;
reg   Tpl_1806 ;
reg  [5:0] Tpl_1807 ;
reg   Tpl_1808 ;
reg  [5:0] Tpl_1809 ;
reg   Tpl_1810 ;
reg  [2:0] Tpl_1811 ;
reg   Tpl_1812 ;
reg   Tpl_1813 ;
reg   Tpl_1814 ;
reg  [1:0] Tpl_1815 ;
reg  [2:0] Tpl_1816 ;
reg   Tpl_1817 ;
reg   Tpl_1818 ;
reg   Tpl_1819 ;
reg  [2:0] Tpl_1820 ;
reg   Tpl_1821 ;
reg   Tpl_1822 ;
reg   Tpl_1823 ;
reg  [1:0] Tpl_1824 ;
reg  [2:0] Tpl_1825 ;
reg   Tpl_1826 ;
reg   Tpl_1827 ;
reg   Tpl_1828 ;
reg  [2:0] Tpl_1829 ;
reg  [2:0] Tpl_1830 ;
reg  [3:0] Tpl_1831 ;
reg   Tpl_1832 ;
reg   Tpl_1833 ;
reg   Tpl_1834 ;
reg  [3:0] Tpl_1835 ;
reg  [7:0] Tpl_1836 ;
reg  [1:0] Tpl_1837 ;
reg   Tpl_1838 ;
reg  [7:0] Tpl_1839 ;
reg  [7:0] Tpl_1840 ;
reg  [2:0] Tpl_1841 ;
reg   Tpl_1842 ;
reg   Tpl_1843 ;
reg  [3:0] Tpl_1844 ;
reg   Tpl_1845 ;
reg  [1:0] Tpl_1846 ;
reg   Tpl_1847 ;
reg   Tpl_1848 ;
reg   Tpl_1849 ;
reg  [2:0] Tpl_1850 ;
reg  [1:0] Tpl_1851 ;
reg   Tpl_1852 ;
reg  [2:0] Tpl_1853 ;
reg  [1:0] Tpl_1854 ;
reg  [1:0] Tpl_1855 ;
reg  [2:0] Tpl_1856 ;
reg   Tpl_1857 ;
reg   Tpl_1858 ;
reg  [1:0] Tpl_1859 ;
reg   Tpl_1860 ;
reg   Tpl_1861 ;
reg   Tpl_1862 ;
reg  [2:0] Tpl_1863 ;
reg  [1:0] Tpl_1864 ;
reg  [1:0] Tpl_1865 ;
reg   Tpl_1866 ;
reg   Tpl_1867 ;
reg   Tpl_1868 ;
reg   Tpl_1869 ;
reg  [2:0] Tpl_1870 ;
reg   Tpl_1871 ;
reg   Tpl_1872 ;
reg   Tpl_1873 ;
reg   Tpl_1874 ;
reg  [2:0] Tpl_1875 ;
reg   Tpl_1876 ;
reg   Tpl_1877 ;
reg   Tpl_1878 ;
reg  [2:0] Tpl_1879 ;
reg   Tpl_1880 ;
reg   Tpl_1881 ;
reg   Tpl_1882 ;
reg   Tpl_1883 ;
reg  [5:0] Tpl_1884 ;
reg   Tpl_1885 ;
reg   Tpl_1886 ;
reg  [2:0] Tpl_1887 ;
reg   Tpl_1888 ;
reg  [2:0] Tpl_1889 ;
reg   Tpl_1890 ;
reg   Tpl_1891 ;
reg  [3:0] Tpl_1892 ;
reg   Tpl_1893 ;
reg  [2:0] Tpl_1894 ;
reg   Tpl_1895 ;
reg   Tpl_1896 ;
reg   Tpl_1897 ;
reg  [2:0] Tpl_1898 ;
reg  [1:0] Tpl_1899 ;
reg   Tpl_1900 ;
reg  [1:0] Tpl_1901 ;
reg  [1:0] Tpl_1902 ;
reg   Tpl_1903 ;
reg   Tpl_1904 ;
reg  [2:0] Tpl_1905 ;
reg  [2:0] Tpl_1906 ;
reg   Tpl_1907 ;
reg  [1:0] Tpl_1908 ;
reg   Tpl_1909 ;
reg   Tpl_1910 ;
reg  [3:0] Tpl_1911 ;
reg  [3:0] Tpl_1912 ;
reg  [3:0] Tpl_1913 ;
reg  [3:0] Tpl_1914 ;
reg   Tpl_1915 ;
reg   Tpl_1916 ;
reg   Tpl_1917 ;
reg   Tpl_1918 ;
reg   Tpl_1919 ;
reg   Tpl_1920 ;
reg   Tpl_1921 ;
reg   Tpl_1922 ;
reg   Tpl_1923 ;
reg  [2:0] Tpl_1924 ;
reg   Tpl_1925 ;
reg   Tpl_1926 ;
reg  [3:0] Tpl_1927 ;
reg  [3:0] Tpl_1928 ;
reg  [3:0] Tpl_1929 ;
reg  [3:0] Tpl_1930 ;
reg   Tpl_1931 ;
reg   Tpl_1932 ;
reg   Tpl_1933 ;
reg   Tpl_1934 ;
reg   Tpl_1935 ;
reg   Tpl_1936 ;
reg   Tpl_1937 ;
reg   Tpl_1938 ;
reg   Tpl_1939 ;
reg  [2:0] Tpl_1940 ;
reg   Tpl_1941 ;
reg   Tpl_1942 ;
reg  [3:0] Tpl_1943 ;
reg  [3:0] Tpl_1944 ;
reg  [3:0] Tpl_1945 ;
reg  [3:0] Tpl_1946 ;
reg   Tpl_1947 ;
reg   Tpl_1948 ;
reg   Tpl_1949 ;
reg   Tpl_1950 ;
reg   Tpl_1951 ;
reg   Tpl_1952 ;
reg   Tpl_1953 ;
reg   Tpl_1954 ;
reg   Tpl_1955 ;
reg  [2:0] Tpl_1956 ;
reg   Tpl_1957 ;
reg   Tpl_1958 ;
reg  [3:0] Tpl_1959 ;
reg  [3:0] Tpl_1960 ;
reg  [3:0] Tpl_1961 ;
reg  [3:0] Tpl_1962 ;
reg   Tpl_1963 ;
reg   Tpl_1964 ;
reg   Tpl_1965 ;
reg   Tpl_1966 ;
reg   Tpl_1967 ;
reg   Tpl_1968 ;
reg   Tpl_1969 ;
reg   Tpl_1970 ;
reg   Tpl_1971 ;
reg  [2:0] Tpl_1972 ;
reg  [7:0] Tpl_1973 ;
reg  [7:0] Tpl_1974 ;
reg  [7:0] Tpl_1975 ;
reg  [7:0] Tpl_1976 ;
reg  [7:0] Tpl_1977 ;
reg  [7:0] Tpl_1978 ;
reg  [7:0] Tpl_1979 ;
reg  [7:0] Tpl_1980 ;
reg  [7:0] Tpl_1981 ;
reg  [7:0] Tpl_1982 ;
reg  [7:0] Tpl_1983 ;
reg  [7:0] Tpl_1984 ;
reg  [7:0] Tpl_1985 ;
reg  [7:0] Tpl_1986 ;
reg  [7:0] Tpl_1987 ;
reg  [7:0] Tpl_1988 ;
reg  [2:0] Tpl_1989 ;
reg  [2:0] Tpl_1990 ;
reg  [2:0] Tpl_1991 ;
reg  [2:0] Tpl_1992 ;
reg  [4:0] Tpl_1993 ;
reg  [4:0] Tpl_1994 ;
reg  [4:0] Tpl_1995 ;
reg  [4:0] Tpl_1996 ;
reg  [4:0] Tpl_1997 ;
reg  [4:0] Tpl_1998 ;
reg  [4:0] Tpl_1999 ;
reg  [4:0] Tpl_2000 ;
reg  [4:0] Tpl_2001 ;
reg  [4:0] Tpl_2002 ;
reg  [4:0] Tpl_2003 ;
reg  [4:0] Tpl_2004 ;
reg  [4:0] Tpl_2005 ;
reg  [4:0] Tpl_2006 ;
reg  [4:0] Tpl_2007 ;
reg  [4:0] Tpl_2008 ;
reg  [4:0] Tpl_2009 ;
reg  [4:0] Tpl_2010 ;
reg  [4:0] Tpl_2011 ;
reg  [4:0] Tpl_2012 ;
reg  [4:0] Tpl_2013 ;
reg  [4:0] Tpl_2014 ;
reg  [4:0] Tpl_2015 ;
reg  [4:0] Tpl_2016 ;
reg  [4:0] Tpl_2017 ;
reg  [4:0] Tpl_2018 ;
reg  [4:0] Tpl_2019 ;
reg  [4:0] Tpl_2020 ;
reg  [4:0] Tpl_2021 ;
reg  [4:0] Tpl_2022 ;
reg  [4:0] Tpl_2023 ;
reg  [4:0] Tpl_2024 ;
reg  [4:0] Tpl_2025 ;
reg  [4:0] Tpl_2026 ;
reg   Tpl_2027 ;
reg  [3:0] Tpl_2028 ;
reg  [1:0] Tpl_2029 ;
reg   Tpl_2030 ;
reg   Tpl_2031 ;
reg   Tpl_2032 ;
reg   Tpl_2033 ;
reg   Tpl_2034 ;
reg   Tpl_2035 ;
reg   Tpl_2036 ;
reg   Tpl_2037 ;
reg   Tpl_2038 ;
reg   Tpl_2039 ;
reg   Tpl_2040 ;
reg   Tpl_2041 ;
reg   Tpl_2042 ;
reg   Tpl_2043 ;
reg   Tpl_2044 ;
reg   Tpl_2045 ;
reg   Tpl_2046 ;
reg   Tpl_2047 ;
reg   Tpl_2048 ;
reg   Tpl_2049 ;
reg  [1:0] Tpl_2050 ;
reg  [4:0] Tpl_2051 ;
reg   Tpl_2052 ;
reg   Tpl_2053 ;
reg   Tpl_2054 ;
reg  [7:0] Tpl_2055 ;
reg  [5:0] Tpl_2056 ;
reg  [4:0] Tpl_2057 ;
reg   Tpl_2058 ;
reg   Tpl_2059 ;
reg   Tpl_2060 ;
reg  [7:0] Tpl_2061 ;
reg  [5:0] Tpl_2062 ;
reg  [4:0] Tpl_2063 ;
reg   Tpl_2064 ;
reg   Tpl_2065 ;
reg   Tpl_2066 ;
reg  [7:0] Tpl_2067 ;
reg  [4:0] Tpl_2068 ;
reg   Tpl_2069 ;
reg   Tpl_2070 ;
reg   Tpl_2071 ;
reg  [7:0] Tpl_2072 ;
reg  [4:0] Tpl_2073 ;
reg   Tpl_2074 ;
reg   Tpl_2075 ;
reg   Tpl_2076 ;
reg  [7:0] Tpl_2077 ;
reg  [4:0] Tpl_2078 ;
reg   Tpl_2079 ;
reg   Tpl_2080 ;
reg   Tpl_2081 ;
reg  [7:0] Tpl_2082 ;
reg   Tpl_2083 ;
reg   Tpl_2084 ;
reg  [5:0] Tpl_2085 ;
reg  [5:0] Tpl_2086 ;
reg  [6:0] Tpl_2087 ;
reg  [5:0] Tpl_2088 ;
reg  [5:0] Tpl_2089 ;
reg  [6:0] Tpl_2090 ;
reg  [3:0] Tpl_2091 ;
reg  [16:0] Tpl_2092 ;
reg  [10:0] Tpl_2093 ;
reg   Tpl_2094 ;
reg  [7:0] Tpl_2095 ;
reg  [5:0] Tpl_2096 ;
reg  [5:0] Tpl_2097 ;
reg   Tpl_2098 ;
reg   Tpl_2099 ;
reg   Tpl_2100 ;
reg   Tpl_2101 ;
reg   Tpl_2102 ;
reg  [5:0] Tpl_2103 ;
reg   Tpl_2104 ;
reg  [5:0] Tpl_2105 ;
reg  [2:0] Tpl_2106 ;
reg   Tpl_2107 ;
reg  [2:0] Tpl_2108 ;
reg   Tpl_2109 ;
reg  [1:0] Tpl_2110 ;
reg  [29:0] Tpl_2111 ;
reg  [2:0] Tpl_2112 ;
reg   Tpl_2113 ;
reg   Tpl_2114 ;
reg   Tpl_2115 ;
reg  [2:0] Tpl_2116 ;
reg  [7:0] Tpl_2117 ;
reg   Tpl_2118 ;
reg   Tpl_2119 ;
reg  [2:0] Tpl_2120 ;
reg   Tpl_2121 ;
reg   Tpl_2122 ;
reg   Tpl_2123 ;
reg  [2:0] Tpl_2124 ;
reg  [7:0] Tpl_2125 ;
reg   Tpl_2126 ;
reg   Tpl_2127 ;
reg  [2:0] Tpl_2128 ;
reg   Tpl_2129 ;
reg   Tpl_2130 ;
reg   Tpl_2131 ;
reg  [2:0] Tpl_2132 ;
reg  [7:0] Tpl_2133 ;
reg   Tpl_2134 ;
reg   Tpl_2135 ;
reg  [2:0] Tpl_2136 ;
reg   Tpl_2137 ;
reg   Tpl_2138 ;
reg   Tpl_2139 ;
reg  [2:0] Tpl_2140 ;
reg  [7:0] Tpl_2141 ;
reg   Tpl_2142 ;
reg   Tpl_2143 ;
reg   Tpl_2144 ;
reg   Tpl_2145 ;
reg   Tpl_2146 ;
reg   Tpl_2147 ;
reg   Tpl_2148 ;
reg   Tpl_2149 ;
reg  [3:0] Tpl_2150 ;
reg  [3:0] Tpl_2151 ;
reg  [10:0] Tpl_2152 ;
reg  [7:0] Tpl_2153 ;
reg  [3:0] Tpl_2154 ;
reg   Tpl_2155 ;
reg  [2:0] Tpl_2156 ;
reg  [7:0] Tpl_2157 ;
reg   Tpl_2158 ;
reg  [1:0] Tpl_2159 ;
reg   Tpl_2160 ;
wire   Tpl_2161 ;
reg  [5:0] Tpl_2162 ;
wire  [5:0] Tpl_2163 ;
reg   Tpl_2164 ;
wire   Tpl_2165 ;
reg  [5:0] Tpl_2166 ;
wire  [5:0] Tpl_2167 ;
reg  [6:0] Tpl_2168 ;
wire  [6:0] Tpl_2169 ;
reg  [6:0] Tpl_2170 ;
wire  [6:0] Tpl_2171 ;
reg  [6:0] Tpl_2172 ;
wire  [6:0] Tpl_2173 ;
reg  [6:0] Tpl_2174 ;
wire  [6:0] Tpl_2175 ;
reg  [6:0] Tpl_2176 ;
wire  [6:0] Tpl_2177 ;
reg  [6:0] Tpl_2178 ;
wire  [6:0] Tpl_2179 ;
reg  [6:0] Tpl_2180 ;
wire  [6:0] Tpl_2181 ;
reg  [6:0] Tpl_2182 ;
wire  [6:0] Tpl_2183 ;
reg  [6:0] Tpl_2184 ;
wire  [6:0] Tpl_2185 ;
reg  [6:0] Tpl_2186 ;
wire  [6:0] Tpl_2187 ;
reg  [6:0] Tpl_2188 ;
wire  [6:0] Tpl_2189 ;
reg  [6:0] Tpl_2190 ;
wire  [6:0] Tpl_2191 ;
reg  [6:0] Tpl_2192 ;
wire  [6:0] Tpl_2193 ;
reg  [6:0] Tpl_2194 ;
wire  [6:0] Tpl_2195 ;
reg  [6:0] Tpl_2196 ;
wire  [6:0] Tpl_2197 ;
reg  [6:0] Tpl_2198 ;
wire  [6:0] Tpl_2199 ;
reg  [6:0] Tpl_2200 ;
wire  [6:0] Tpl_2201 ;
reg  [6:0] Tpl_2202 ;
wire  [6:0] Tpl_2203 ;
reg  [6:0] Tpl_2204 ;
wire  [6:0] Tpl_2205 ;
reg  [6:0] Tpl_2206 ;
wire  [6:0] Tpl_2207 ;
reg  [6:0] Tpl_2208 ;
wire  [6:0] Tpl_2209 ;
reg  [6:0] Tpl_2210 ;
wire  [6:0] Tpl_2211 ;
reg  [6:0] Tpl_2212 ;
wire  [6:0] Tpl_2213 ;
reg  [6:0] Tpl_2214 ;
wire  [6:0] Tpl_2215 ;
reg  [6:0] Tpl_2216 ;
wire  [6:0] Tpl_2217 ;
reg  [6:0] Tpl_2218 ;
wire  [6:0] Tpl_2219 ;
reg  [6:0] Tpl_2220 ;
wire  [6:0] Tpl_2221 ;
reg  [6:0] Tpl_2222 ;
wire  [6:0] Tpl_2223 ;
reg  [6:0] Tpl_2224 ;
wire  [6:0] Tpl_2225 ;
reg  [6:0] Tpl_2226 ;
wire  [6:0] Tpl_2227 ;
reg  [6:0] Tpl_2228 ;
wire  [6:0] Tpl_2229 ;
reg  [6:0] Tpl_2230 ;
wire  [6:0] Tpl_2231 ;
reg  [6:0] Tpl_2232 ;
wire  [6:0] Tpl_2233 ;
reg  [6:0] Tpl_2234 ;
wire  [6:0] Tpl_2235 ;
reg  [6:0] Tpl_2236 ;
wire  [6:0] Tpl_2237 ;
reg  [6:0] Tpl_2238 ;
wire  [6:0] Tpl_2239 ;
reg  [6:0] Tpl_2240 ;
wire  [6:0] Tpl_2241 ;
reg  [6:0] Tpl_2242 ;
wire  [6:0] Tpl_2243 ;
reg  [6:0] Tpl_2244 ;
wire  [6:0] Tpl_2245 ;
reg  [6:0] Tpl_2246 ;
wire  [6:0] Tpl_2247 ;
reg  [6:0] Tpl_2248 ;
reg  [6:0] Tpl_2249 ;
reg  [6:0] Tpl_2250 ;
reg  [6:0] Tpl_2251 ;
reg  [6:0] Tpl_2252 ;
reg  [6:0] Tpl_2253 ;
reg  [6:0] Tpl_2254 ;
reg  [6:0] Tpl_2255 ;
reg  [6:0] Tpl_2256 ;
reg  [6:0] Tpl_2257 ;
reg  [6:0] Tpl_2258 ;
reg  [6:0] Tpl_2259 ;
reg  [5:0] Tpl_2260 ;
wire  [5:0] Tpl_2261 ;
reg  [5:0] Tpl_2262 ;
wire  [5:0] Tpl_2263 ;
reg  [5:0] Tpl_2264 ;
wire  [5:0] Tpl_2265 ;
reg  [5:0] Tpl_2266 ;
wire  [5:0] Tpl_2267 ;
reg  [7:0] Tpl_2268 ;
wire  [7:0] Tpl_2269 ;
reg  [7:0] Tpl_2270 ;
wire  [7:0] Tpl_2271 ;
reg  [7:0] Tpl_2272 ;
wire  [7:0] Tpl_2273 ;
reg  [7:0] Tpl_2274 ;
wire  [7:0] Tpl_2275 ;
reg  [7:0] Tpl_2276 ;
wire  [7:0] Tpl_2277 ;
reg  [7:0] Tpl_2278 ;
wire  [7:0] Tpl_2279 ;
reg  [7:0] Tpl_2280 ;
wire  [7:0] Tpl_2281 ;
reg  [7:0] Tpl_2282 ;
wire  [7:0] Tpl_2283 ;
reg  [7:0] Tpl_2284 ;
wire  [7:0] Tpl_2285 ;
reg  [7:0] Tpl_2286 ;
wire  [7:0] Tpl_2287 ;
reg  [7:0] Tpl_2288 ;
wire  [7:0] Tpl_2289 ;
reg  [7:0] Tpl_2290 ;
wire  [7:0] Tpl_2291 ;
reg  [7:0] Tpl_2292 ;
wire  [7:0] Tpl_2293 ;
reg  [7:0] Tpl_2294 ;
wire  [7:0] Tpl_2295 ;
reg  [7:0] Tpl_2296 ;
wire  [7:0] Tpl_2297 ;
reg  [7:0] Tpl_2298 ;
wire  [7:0] Tpl_2299 ;
reg  [7:0] Tpl_2300 ;
wire  [7:0] Tpl_2301 ;
reg  [7:0] Tpl_2302 ;
wire  [7:0] Tpl_2303 ;
reg  [7:0] Tpl_2304 ;
wire  [7:0] Tpl_2305 ;
reg  [7:0] Tpl_2306 ;
wire  [7:0] Tpl_2307 ;
reg  [7:0] Tpl_2308 ;
wire  [7:0] Tpl_2309 ;
reg  [7:0] Tpl_2310 ;
wire  [7:0] Tpl_2311 ;
reg  [7:0] Tpl_2312 ;
wire  [7:0] Tpl_2313 ;
reg  [7:0] Tpl_2314 ;
wire  [7:0] Tpl_2315 ;
reg  [7:0] Tpl_2316 ;
wire  [7:0] Tpl_2317 ;
reg  [7:0] Tpl_2318 ;
wire  [7:0] Tpl_2319 ;
reg  [7:0] Tpl_2320 ;
wire  [7:0] Tpl_2321 ;
reg  [7:0] Tpl_2322 ;
wire  [7:0] Tpl_2323 ;
reg  [7:0] Tpl_2324 ;
wire  [7:0] Tpl_2325 ;
reg  [7:0] Tpl_2326 ;
wire  [7:0] Tpl_2327 ;
reg  [7:0] Tpl_2328 ;
wire  [7:0] Tpl_2329 ;
reg  [7:0] Tpl_2330 ;
wire  [7:0] Tpl_2331 ;
reg  [7:0] Tpl_2332 ;
wire  [7:0] Tpl_2333 ;
reg  [7:0] Tpl_2334 ;
wire  [7:0] Tpl_2335 ;
reg  [7:0] Tpl_2336 ;
wire  [7:0] Tpl_2337 ;
reg  [7:0] Tpl_2338 ;
wire  [7:0] Tpl_2339 ;
reg  [7:0] Tpl_2340 ;
wire  [7:0] Tpl_2341 ;
reg  [7:0] Tpl_2342 ;
wire  [7:0] Tpl_2343 ;
reg  [7:0] Tpl_2344 ;
wire  [7:0] Tpl_2345 ;
reg  [7:0] Tpl_2346 ;
wire  [7:0] Tpl_2347 ;
reg  [7:0] Tpl_2348 ;
wire  [7:0] Tpl_2349 ;
reg  [7:0] Tpl_2350 ;
wire  [7:0] Tpl_2351 ;
reg  [7:0] Tpl_2352 ;
wire  [7:0] Tpl_2353 ;
reg  [7:0] Tpl_2354 ;
wire  [7:0] Tpl_2355 ;
reg  [7:0] Tpl_2356 ;
wire  [7:0] Tpl_2357 ;
reg  [7:0] Tpl_2358 ;
wire  [7:0] Tpl_2359 ;
reg  [7:0] Tpl_2360 ;
wire  [7:0] Tpl_2361 ;
reg  [7:0] Tpl_2362 ;
wire  [7:0] Tpl_2363 ;
reg  [7:0] Tpl_2364 ;
wire  [7:0] Tpl_2365 ;
reg  [7:0] Tpl_2366 ;
wire  [7:0] Tpl_2367 ;
reg  [7:0] Tpl_2368 ;
wire  [7:0] Tpl_2369 ;
reg  [7:0] Tpl_2370 ;
wire  [7:0] Tpl_2371 ;
reg  [7:0] Tpl_2372 ;
wire  [7:0] Tpl_2373 ;
reg  [7:0] Tpl_2374 ;
wire  [7:0] Tpl_2375 ;
reg  [7:0] Tpl_2376 ;
wire  [7:0] Tpl_2377 ;
reg  [7:0] Tpl_2378 ;
wire  [7:0] Tpl_2379 ;
reg  [7:0] Tpl_2380 ;
wire  [7:0] Tpl_2381 ;
reg  [7:0] Tpl_2382 ;
wire  [7:0] Tpl_2383 ;
reg  [7:0] Tpl_2384 ;
wire  [7:0] Tpl_2385 ;
reg  [7:0] Tpl_2386 ;
wire  [7:0] Tpl_2387 ;
reg  [7:0] Tpl_2388 ;
wire  [7:0] Tpl_2389 ;
reg  [7:0] Tpl_2390 ;
wire  [7:0] Tpl_2391 ;
reg  [7:0] Tpl_2392 ;
wire  [7:0] Tpl_2393 ;
reg  [7:0] Tpl_2394 ;
wire  [7:0] Tpl_2395 ;
reg  [7:0] Tpl_2396 ;
wire  [7:0] Tpl_2397 ;
reg  [7:0] Tpl_2398 ;
wire  [7:0] Tpl_2399 ;
reg  [7:0] Tpl_2400 ;
wire  [7:0] Tpl_2401 ;
reg  [7:0] Tpl_2402 ;
wire  [7:0] Tpl_2403 ;
reg  [7:0] Tpl_2404 ;
wire  [7:0] Tpl_2405 ;
reg  [7:0] Tpl_2406 ;
wire  [7:0] Tpl_2407 ;
reg  [7:0] Tpl_2408 ;
wire  [7:0] Tpl_2409 ;
reg  [7:0] Tpl_2410 ;
wire  [7:0] Tpl_2411 ;
reg  [7:0] Tpl_2412 ;
wire  [7:0] Tpl_2413 ;
reg  [7:0] Tpl_2414 ;
wire  [7:0] Tpl_2415 ;
reg  [7:0] Tpl_2416 ;
wire  [7:0] Tpl_2417 ;
reg  [7:0] Tpl_2418 ;
wire  [7:0] Tpl_2419 ;
reg  [5:0] Tpl_2420 ;
wire  [5:0] Tpl_2421 ;
reg  [5:0] Tpl_2422 ;
wire  [5:0] Tpl_2423 ;
reg  [5:0] Tpl_2424 ;
wire  [5:0] Tpl_2425 ;
reg  [5:0] Tpl_2426 ;
wire  [5:0] Tpl_2427 ;
reg   Tpl_2428 ;
wire   Tpl_2429 ;
reg   Tpl_2430 ;
wire   Tpl_2431 ;
reg  [5:0] Tpl_2432 ;
wire  [5:0] Tpl_2433 ;
reg   Tpl_2434 ;
wire   Tpl_2435 ;
reg  [5:0] Tpl_2436 ;
wire  [5:0] Tpl_2437 ;
reg  [6:0] Tpl_2438 ;
wire  [6:0] Tpl_2439 ;
reg  [6:0] Tpl_2440 ;
wire  [6:0] Tpl_2441 ;
reg  [6:0] Tpl_2442 ;
wire  [6:0] Tpl_2443 ;
reg  [6:0] Tpl_2444 ;
wire  [6:0] Tpl_2445 ;
reg  [6:0] Tpl_2446 ;
wire  [6:0] Tpl_2447 ;
reg  [6:0] Tpl_2448 ;
wire  [6:0] Tpl_2449 ;
reg  [6:0] Tpl_2450 ;
wire  [6:0] Tpl_2451 ;
reg  [6:0] Tpl_2452 ;
wire  [6:0] Tpl_2453 ;
reg  [6:0] Tpl_2454 ;
wire  [6:0] Tpl_2455 ;
reg  [6:0] Tpl_2456 ;
wire  [6:0] Tpl_2457 ;
reg  [6:0] Tpl_2458 ;
wire  [6:0] Tpl_2459 ;
reg  [6:0] Tpl_2460 ;
wire  [6:0] Tpl_2461 ;
reg  [6:0] Tpl_2462 ;
wire  [6:0] Tpl_2463 ;
reg  [6:0] Tpl_2464 ;
wire  [6:0] Tpl_2465 ;
reg  [6:0] Tpl_2466 ;
wire  [6:0] Tpl_2467 ;
reg  [6:0] Tpl_2468 ;
wire  [6:0] Tpl_2469 ;
reg  [6:0] Tpl_2470 ;
wire  [6:0] Tpl_2471 ;
reg  [6:0] Tpl_2472 ;
wire  [6:0] Tpl_2473 ;
reg  [6:0] Tpl_2474 ;
wire  [6:0] Tpl_2475 ;
reg  [6:0] Tpl_2476 ;
wire  [6:0] Tpl_2477 ;
reg  [6:0] Tpl_2478 ;
wire  [6:0] Tpl_2479 ;
reg  [6:0] Tpl_2480 ;
wire  [6:0] Tpl_2481 ;
reg  [6:0] Tpl_2482 ;
wire  [6:0] Tpl_2483 ;
reg  [6:0] Tpl_2484 ;
wire  [6:0] Tpl_2485 ;
reg  [6:0] Tpl_2486 ;
wire  [6:0] Tpl_2487 ;
reg  [6:0] Tpl_2488 ;
wire  [6:0] Tpl_2489 ;
reg  [6:0] Tpl_2490 ;
wire  [6:0] Tpl_2491 ;
reg  [6:0] Tpl_2492 ;
wire  [6:0] Tpl_2493 ;
reg  [6:0] Tpl_2494 ;
wire  [6:0] Tpl_2495 ;
reg  [6:0] Tpl_2496 ;
wire  [6:0] Tpl_2497 ;
reg  [6:0] Tpl_2498 ;
wire  [6:0] Tpl_2499 ;
reg  [6:0] Tpl_2500 ;
wire  [6:0] Tpl_2501 ;
reg  [6:0] Tpl_2502 ;
wire  [6:0] Tpl_2503 ;
reg  [6:0] Tpl_2504 ;
wire  [6:0] Tpl_2505 ;
reg  [6:0] Tpl_2506 ;
wire  [6:0] Tpl_2507 ;
reg  [6:0] Tpl_2508 ;
wire  [6:0] Tpl_2509 ;
reg  [6:0] Tpl_2510 ;
wire  [6:0] Tpl_2511 ;
reg  [6:0] Tpl_2512 ;
wire  [6:0] Tpl_2513 ;
reg  [6:0] Tpl_2514 ;
wire  [6:0] Tpl_2515 ;
reg  [6:0] Tpl_2516 ;
wire  [6:0] Tpl_2517 ;
reg  [6:0] Tpl_2518 ;
reg  [6:0] Tpl_2519 ;
reg  [6:0] Tpl_2520 ;
reg  [6:0] Tpl_2521 ;
reg  [6:0] Tpl_2522 ;
reg  [6:0] Tpl_2523 ;
reg  [6:0] Tpl_2524 ;
reg  [6:0] Tpl_2525 ;
reg  [6:0] Tpl_2526 ;
reg  [6:0] Tpl_2527 ;
reg  [6:0] Tpl_2528 ;
reg  [6:0] Tpl_2529 ;
reg  [5:0] Tpl_2530 ;
wire  [5:0] Tpl_2531 ;
reg  [5:0] Tpl_2532 ;
wire  [5:0] Tpl_2533 ;
reg  [5:0] Tpl_2534 ;
wire  [5:0] Tpl_2535 ;
reg  [5:0] Tpl_2536 ;
wire  [5:0] Tpl_2537 ;
reg  [7:0] Tpl_2538 ;
wire  [7:0] Tpl_2539 ;
reg  [7:0] Tpl_2540 ;
wire  [7:0] Tpl_2541 ;
reg  [7:0] Tpl_2542 ;
wire  [7:0] Tpl_2543 ;
reg  [7:0] Tpl_2544 ;
wire  [7:0] Tpl_2545 ;
reg  [7:0] Tpl_2546 ;
wire  [7:0] Tpl_2547 ;
reg  [7:0] Tpl_2548 ;
wire  [7:0] Tpl_2549 ;
reg  [7:0] Tpl_2550 ;
wire  [7:0] Tpl_2551 ;
reg  [7:0] Tpl_2552 ;
wire  [7:0] Tpl_2553 ;
reg  [7:0] Tpl_2554 ;
wire  [7:0] Tpl_2555 ;
reg  [7:0] Tpl_2556 ;
wire  [7:0] Tpl_2557 ;
reg  [7:0] Tpl_2558 ;
wire  [7:0] Tpl_2559 ;
reg  [7:0] Tpl_2560 ;
wire  [7:0] Tpl_2561 ;
reg  [7:0] Tpl_2562 ;
wire  [7:0] Tpl_2563 ;
reg  [7:0] Tpl_2564 ;
wire  [7:0] Tpl_2565 ;
reg  [7:0] Tpl_2566 ;
wire  [7:0] Tpl_2567 ;
reg  [7:0] Tpl_2568 ;
wire  [7:0] Tpl_2569 ;
reg  [7:0] Tpl_2570 ;
wire  [7:0] Tpl_2571 ;
reg  [7:0] Tpl_2572 ;
wire  [7:0] Tpl_2573 ;
reg  [7:0] Tpl_2574 ;
wire  [7:0] Tpl_2575 ;
reg  [7:0] Tpl_2576 ;
wire  [7:0] Tpl_2577 ;
reg  [7:0] Tpl_2578 ;
wire  [7:0] Tpl_2579 ;
reg  [7:0] Tpl_2580 ;
wire  [7:0] Tpl_2581 ;
reg  [7:0] Tpl_2582 ;
wire  [7:0] Tpl_2583 ;
reg  [7:0] Tpl_2584 ;
wire  [7:0] Tpl_2585 ;
reg  [7:0] Tpl_2586 ;
wire  [7:0] Tpl_2587 ;
reg  [7:0] Tpl_2588 ;
wire  [7:0] Tpl_2589 ;
reg  [7:0] Tpl_2590 ;
wire  [7:0] Tpl_2591 ;
reg  [7:0] Tpl_2592 ;
wire  [7:0] Tpl_2593 ;
reg  [7:0] Tpl_2594 ;
wire  [7:0] Tpl_2595 ;
reg  [7:0] Tpl_2596 ;
wire  [7:0] Tpl_2597 ;
reg  [7:0] Tpl_2598 ;
wire  [7:0] Tpl_2599 ;
reg  [7:0] Tpl_2600 ;
wire  [7:0] Tpl_2601 ;
reg  [7:0] Tpl_2602 ;
wire  [7:0] Tpl_2603 ;
reg  [7:0] Tpl_2604 ;
wire  [7:0] Tpl_2605 ;
reg  [7:0] Tpl_2606 ;
wire  [7:0] Tpl_2607 ;
reg  [7:0] Tpl_2608 ;
wire  [7:0] Tpl_2609 ;
reg  [7:0] Tpl_2610 ;
wire  [7:0] Tpl_2611 ;
reg  [7:0] Tpl_2612 ;
wire  [7:0] Tpl_2613 ;
reg  [7:0] Tpl_2614 ;
wire  [7:0] Tpl_2615 ;
reg  [7:0] Tpl_2616 ;
wire  [7:0] Tpl_2617 ;
reg  [7:0] Tpl_2618 ;
wire  [7:0] Tpl_2619 ;
reg  [7:0] Tpl_2620 ;
wire  [7:0] Tpl_2621 ;
reg  [7:0] Tpl_2622 ;
wire  [7:0] Tpl_2623 ;
reg  [7:0] Tpl_2624 ;
wire  [7:0] Tpl_2625 ;
reg  [7:0] Tpl_2626 ;
wire  [7:0] Tpl_2627 ;
reg  [7:0] Tpl_2628 ;
wire  [7:0] Tpl_2629 ;
reg  [7:0] Tpl_2630 ;
wire  [7:0] Tpl_2631 ;
reg  [7:0] Tpl_2632 ;
wire  [7:0] Tpl_2633 ;
reg  [7:0] Tpl_2634 ;
wire  [7:0] Tpl_2635 ;
reg  [7:0] Tpl_2636 ;
wire  [7:0] Tpl_2637 ;
reg  [7:0] Tpl_2638 ;
wire  [7:0] Tpl_2639 ;
reg  [7:0] Tpl_2640 ;
wire  [7:0] Tpl_2641 ;
reg  [7:0] Tpl_2642 ;
wire  [7:0] Tpl_2643 ;
reg  [7:0] Tpl_2644 ;
wire  [7:0] Tpl_2645 ;
reg  [7:0] Tpl_2646 ;
wire  [7:0] Tpl_2647 ;
reg  [7:0] Tpl_2648 ;
wire  [7:0] Tpl_2649 ;
reg  [7:0] Tpl_2650 ;
wire  [7:0] Tpl_2651 ;
reg  [7:0] Tpl_2652 ;
wire  [7:0] Tpl_2653 ;
reg  [7:0] Tpl_2654 ;
wire  [7:0] Tpl_2655 ;
reg  [7:0] Tpl_2656 ;
wire  [7:0] Tpl_2657 ;
reg  [7:0] Tpl_2658 ;
wire  [7:0] Tpl_2659 ;
reg  [7:0] Tpl_2660 ;
wire  [7:0] Tpl_2661 ;
reg  [7:0] Tpl_2662 ;
wire  [7:0] Tpl_2663 ;
reg  [7:0] Tpl_2664 ;
wire  [7:0] Tpl_2665 ;
reg  [7:0] Tpl_2666 ;
wire  [7:0] Tpl_2667 ;
reg  [7:0] Tpl_2668 ;
wire  [7:0] Tpl_2669 ;
reg  [7:0] Tpl_2670 ;
wire  [7:0] Tpl_2671 ;
reg  [7:0] Tpl_2672 ;
wire  [7:0] Tpl_2673 ;
reg  [7:0] Tpl_2674 ;
wire  [7:0] Tpl_2675 ;
reg  [7:0] Tpl_2676 ;
wire  [7:0] Tpl_2677 ;
reg  [7:0] Tpl_2678 ;
wire  [7:0] Tpl_2679 ;
reg  [7:0] Tpl_2680 ;
wire  [7:0] Tpl_2681 ;
reg  [7:0] Tpl_2682 ;
wire  [7:0] Tpl_2683 ;
reg  [7:0] Tpl_2684 ;
wire  [7:0] Tpl_2685 ;
reg  [7:0] Tpl_2686 ;
wire  [7:0] Tpl_2687 ;
reg  [7:0] Tpl_2688 ;
wire  [7:0] Tpl_2689 ;
reg  [3:0] Tpl_2690 ;
wire  [3:0] Tpl_2691 ;
reg  [3:0] Tpl_2692 ;
wire  [3:0] Tpl_2693 ;
reg  [3:0] Tpl_2694 ;
wire  [3:0] Tpl_2695 ;
reg  [3:0] Tpl_2696 ;
wire  [3:0] Tpl_2697 ;
reg  [15:0] Tpl_2698 ;
reg  [6:0] Tpl_2699 ;
reg  [6:0] Tpl_2700 ;
reg  [6:0] Tpl_2701 ;
reg  [6:0] Tpl_2702 ;
reg   Tpl_2703 ;
wire   Tpl_2704 ;
reg  [19:0] Tpl_2705 ;
reg  [19:0] Tpl_2706 ;
reg  [5:0] Tpl_2707 ;
reg  [4:0] Tpl_2708 ;
reg  [4:0] Tpl_2709 ;
reg  [6:0] Tpl_2710 ;
reg  [7:0] Tpl_2711 ;
reg  [5:0] Tpl_2712 ;
reg  [7:0] Tpl_2713 ;
reg  [7:0] Tpl_2714 ;
reg  [7:0] Tpl_2715 ;
reg  [5:0] Tpl_2716 ;
reg  [5:0] Tpl_2717 ;
reg  [7:0] Tpl_2718 ;
reg  [7:0] Tpl_2719 ;
reg  [3:0] Tpl_2720 ;
reg  [4:0] Tpl_2721 ;
reg  [9:0] Tpl_2722 ;
reg  [7:0] Tpl_2723 ;
reg  [5:0] Tpl_2724 ;
reg  [27:0] Tpl_2725 ;
reg  [19:0] Tpl_2726 ;
reg  [10:0] Tpl_2727 ;
reg  [7:0] Tpl_2728 ;
reg  [7:0] Tpl_2729 ;
reg  [5:0] Tpl_2730 ;
reg  [6:0] Tpl_2731 ;
reg  [4:0] Tpl_2732 ;
reg  [9:0] Tpl_2733 ;
reg  [7:0] Tpl_2734 ;
reg  [7:0] Tpl_2735 ;
reg  [10:0] Tpl_2736 ;
reg  [13:0] Tpl_2737 ;
reg  [1:0] Tpl_2738 ;
reg  [19:0] Tpl_2739 ;
reg  [7:0] Tpl_2740 ;
reg  [19:0] Tpl_2741 ;
reg  [7:0] Tpl_2742 ;
reg  [7:0] Tpl_2743 ;
reg  [7:0] Tpl_2744 ;
reg  [7:0] Tpl_2745 ;
reg  [7:0] Tpl_2746 ;
reg  [9:0] Tpl_2747 ;
reg  [5:0] Tpl_2748 ;
reg  [19:0] Tpl_2749 ;
reg  [4:0] Tpl_2750 ;
reg  [6:0] Tpl_2751 ;
reg  [5:0] Tpl_2752 ;
reg  [7:0] Tpl_2753 ;
reg  [4:0] Tpl_2754 ;
reg  [9:0] Tpl_2755 ;
reg  [5:0] Tpl_2756 ;
reg  [4:0] Tpl_2757 ;
reg  [5:0] Tpl_2758 ;
reg  [13:0] Tpl_2759 ;
reg  [2:0] Tpl_2760 ;
reg  [5:0] Tpl_2761 ;
reg  [15:0] Tpl_2762 ;
reg  [6:0] Tpl_2763 ;
reg  [9:0] Tpl_2764 ;
reg  [9:0] Tpl_2765 ;
reg  [9:0] Tpl_2766 ;
reg  [9:0] Tpl_2767 ;
reg  [9:0] Tpl_2768 ;
reg  [9:0] Tpl_2769 ;
reg  [6:0] Tpl_2770 ;
reg  [6:0] Tpl_2771 ;
reg  [6:0] Tpl_2772 ;
reg  [10:0] Tpl_2773 ;
reg  [7:0] Tpl_2774 ;
reg  [7:0] Tpl_2775 ;
reg  [7:0] Tpl_2776 ;
reg  [11:0] Tpl_2777 ;
reg  [9:0] Tpl_2778 ;
reg  [10:0] Tpl_2779 ;
reg  [4:0] Tpl_2780 ;
reg  [4:0] Tpl_2781 ;
reg  [5:0] Tpl_2782 ;
reg  [4:0] Tpl_2783 ;
reg  [3:0] Tpl_2784 ;
reg  [7:0] Tpl_2785 ;
reg  [7:0] Tpl_2786 ;
reg  [11:0] Tpl_2787 ;
reg  [7:0] Tpl_2788 ;
reg  [7:0] Tpl_2789 ;
reg  [7:0] Tpl_2790 ;
reg  [7:0] Tpl_2791 ;
reg  [7:0] Tpl_2792 ;
reg  [7:0] Tpl_2793 ;
reg  [4:0] Tpl_2794 ;
reg  [4:0] Tpl_2795 ;
reg  [6:0] Tpl_2796 ;
reg  [1:0] Tpl_2797 ;
reg  [4:0] Tpl_2798 ;
reg  [9:0] Tpl_2799 ;
reg  [3:0] Tpl_2800 ;
reg  [5:0] Tpl_2801 ;
reg  [5:0] Tpl_2802 ;
reg  [27:0] Tpl_2803 ;
reg  [3:0] Tpl_2804 ;
reg  [7:0] Tpl_2805 ;
reg  [17:0] Tpl_2806 ;
reg  [2:0] Tpl_2807 ;
reg  [6:0] Tpl_2808 ;
reg  [9:0] Tpl_2809 ;
reg  [13:0] Tpl_2810 ;
reg  [8:0] Tpl_2811 ;
reg  [7:0] Tpl_2812 ;
reg  [7:0] Tpl_2813 ;
reg  [5:0] Tpl_2814 ;
reg  [7:0] Tpl_2815 ;
reg  [3:0] Tpl_2816 ;
reg  [3:0] Tpl_2817 ;
reg  [13:0] Tpl_2818 ;
reg  [10:0] Tpl_2819 ;
reg  [7:0] Tpl_2820 ;
reg  [3:0] Tpl_2821 ;
reg   Tpl_2822 ;
reg   Tpl_2823 ;
reg  [3:0] Tpl_2824 ;
reg  [3:0] Tpl_2825 ;
reg  [2:0] Tpl_2826 ;
reg  [2:0] Tpl_2827 ;
reg  [3:0] Tpl_2828 ;
reg  [3:0] Tpl_2829 ;
reg  [3:0] Tpl_2830 ;
reg   Tpl_2831 ;
reg   Tpl_2832 ;
reg   Tpl_2833 ;
reg  [3:0] Tpl_2834 ;
reg  [3:0] Tpl_2835 ;
reg  [2:0] Tpl_2836 ;
reg  [2:0] Tpl_2837 ;
reg  [3:0] Tpl_2838 ;
reg  [3:0] Tpl_2839 ;
reg  [3:0] Tpl_2840 ;
reg   Tpl_2841 ;
reg  [16:0] Tpl_2842 ;
reg  [10:0] Tpl_2843 ;
reg  [16:0] Tpl_2844 ;
reg  [10:0] Tpl_2845 ;
reg  [16:0] Tpl_2846 ;
reg  [10:0] Tpl_2847 ;
reg  [16:0] Tpl_2848 ;
reg  [10:0] Tpl_2849 ;
reg  [31:0] Tpl_2850 ;
reg  [31:0] Tpl_2851 ;
reg  [31:0] Tpl_2852 ;
reg  [31:0] Tpl_2853 ;
reg  [31:0] Tpl_2854 ;
reg  [31:0] Tpl_2855 ;
reg  [31:0] Tpl_2856 ;
reg  [31:0] Tpl_2857 ;
reg  [31:0] Tpl_2858 ;
reg  [31:0] Tpl_2859 ;
reg  [31:0] Tpl_2860 ;
reg  [31:0] Tpl_2861 ;
reg  [31:0] Tpl_2862 ;
reg  [31:0] Tpl_2863 ;
reg  [31:0] Tpl_2864 ;
reg  [31:0] Tpl_2865 ;
reg  [31:0] Tpl_2866 ;
reg  [31:0] Tpl_2867 ;
reg  [31:0] Tpl_2868 ;
reg  [31:0] Tpl_2869 ;
reg  [31:0] Tpl_2870 ;
reg  [31:0] Tpl_2871 ;
reg  [31:0] Tpl_2872 ;
reg  [31:0] Tpl_2873 ;
reg  [31:0] Tpl_2874 ;
reg  [31:0] Tpl_2875 ;
reg  [31:0] Tpl_2876 ;
reg  [31:0] Tpl_2877 ;
reg  [31:0] Tpl_2878 ;
reg  [31:0] Tpl_2879 ;
reg  [31:0] Tpl_2880 ;
reg  [31:0] Tpl_2881 ;
reg  [1:0] Tpl_2882 ;
reg  [3:0] Tpl_2883 ;
reg  [1:0] Tpl_2884 ;
reg  [3:0] Tpl_2885 ;
reg  [3:0] Tpl_2886 ;
reg  [31:0] Tpl_2887 ;
reg  [29:0] Tpl_2888 ;
reg  [1:0] Tpl_2889 ;
reg  [3:0] Tpl_2890 ;
reg  [3:0] Tpl_2891 ;
reg  [31:0] Tpl_2892 ;
reg  [29:0] Tpl_2893 ;
wire  [15:0] Tpl_2894 ;
wire  [1:0] Tpl_2895 ;
wire  [1:0] Tpl_2896 ;
wire   Tpl_2897 ;
wire   Tpl_2898 ;
wire  [15:0] Tpl_2899 ;
wire   Tpl_2900 ;
wire   Tpl_2901 ;
wire   Tpl_2902 ;
wire   Tpl_2903 ;
wire   Tpl_2904 ;
wire   Tpl_2905 ;
wire  [15:0] Tpl_2906 ;
wire   Tpl_2907 ;
wire   Tpl_2908 ;
wire   Tpl_2909 ;
wire   Tpl_2910 ;
wire   Tpl_2911 ;
wire   Tpl_2912 ;
wire   Tpl_2913 ;
wire   Tpl_2914 ;
wire   Tpl_2915 ;
wire   Tpl_2916 ;
wire  [3:0] Tpl_2917 ;
wire  [16:0] Tpl_2918 ;
wire   Tpl_2919 ;
wire   Tpl_2920 ;
wire   Tpl_2921 ;
wire   Tpl_2922 ;
wire  [3:0] Tpl_2923 ;
wire  [16:0] Tpl_2924 ;
wire   Tpl_2925 ;
wire   Tpl_2926 ;
wire   Tpl_2927 ;
wire   Tpl_2928 ;
wire   Tpl_2929 ;
wire   Tpl_2930 ;
wire   Tpl_2931 ;
wire  [1:0] Tpl_2932 ;
wire  [1:0] Tpl_2933 ;
wire  [1:0] Tpl_2934 ;
wire  [1:0] Tpl_2935 ;
wire  [1:0] Tpl_2936 ;
wire  [1:0] Tpl_2937 ;
wire   Tpl_2938 ;
wire   Tpl_2939 ;
wire   Tpl_2940 ;
wire   Tpl_2941 ;
wire   Tpl_2942 ;
wire  [1:0] Tpl_2943 ;
wire  [3:0] Tpl_2944 ;
wire  [1:0] Tpl_2945 ;
wire  [3:0] Tpl_2946 ;
wire  [3:0] Tpl_2947 ;
wire  [3:0] Tpl_2948 ;
wire  [3:0] Tpl_2949 ;
wire  [5:0] Tpl_2950 ;
wire  [3:0] Tpl_2951 ;
wire  [3:0] Tpl_2952 ;
wire  [3:0] Tpl_2953 ;
wire  [3:0] Tpl_2954 ;
wire  [3:0] Tpl_2955 ;
wire  [31:0] Tpl_2956 ;
wire  [31:0] Tpl_2957 ;
wire  [3:0] Tpl_2958 ;
wire  [1:0] Tpl_2959 ;
wire  [3:0] Tpl_2960 ;
wire  [3:0] Tpl_2961 ;
wire  [3:0] Tpl_2962 ;
wire  [3:0] Tpl_2963 ;
wire  [31:0] Tpl_2964 ;
wire  [31:0] Tpl_2965 ;
wire  [1:0] Tpl_2966 ;
wire  [1:0] Tpl_2967 ;
wire  [1:0] Tpl_2968 ;
wire  [3:0] Tpl_2969 ;
wire  [3:0] Tpl_2970 ;
wire  [3:0] Tpl_2971 ;
wire   Tpl_2972 ;
wire  [29:0] Tpl_2973 ;
wire  [31:0] Tpl_2974 ;
wire  [3:0] Tpl_2975 ;
wire   Tpl_2976 ;
wire   Tpl_2977 ;
wire  [3:0] Tpl_2978 ;
wire  [3:0] Tpl_2979 ;
wire   Tpl_2980 ;
wire  [7:0] Tpl_2981 ;
wire   Tpl_2982 ;
wire  [7:0] Tpl_2983 ;
wire   Tpl_2984 ;
wire  [7:0] Tpl_2985 ;
wire  [1:0] Tpl_2986 ;
wire   Tpl_2987 ;
wire   Tpl_2988 ;
wire  [2:0] Tpl_2989 ;
wire   Tpl_2990 ;
wire  [1:0] Tpl_2991 ;
wire   Tpl_2992 ;
wire   Tpl_2993 ;
wire  [2:0] Tpl_2994 ;
wire   Tpl_2995 ;
wire  [2:0] Tpl_2996 ;
wire  [2:0] Tpl_2997 ;
wire   Tpl_2998 ;
wire   Tpl_2999 ;
wire  [2:0] Tpl_3000 ;
wire  [2:0] Tpl_3001 ;
wire   Tpl_3002 ;
wire   Tpl_3003 ;
wire   Tpl_3004 ;
wire   Tpl_3005 ;
wire   Tpl_3006 ;
wire  [2:0] Tpl_3007 ;
wire   Tpl_3008 ;
wire   Tpl_3009 ;
wire   Tpl_3010 ;
wire   Tpl_3011 ;
wire   Tpl_3012 ;
wire  [2:0] Tpl_3013 ;
wire   Tpl_3014 ;
wire   Tpl_3015 ;
wire  [2:0] Tpl_3016 ;
wire   Tpl_3017 ;
wire  [2:0] Tpl_3018 ;
wire   Tpl_3019 ;
wire  [2:0] Tpl_3020 ;
wire   Tpl_3021 ;
wire  [2:0] Tpl_3022 ;
wire   Tpl_3023 ;
wire  [2:0] Tpl_3024 ;
wire   Tpl_3025 ;
wire  [2:0] Tpl_3026 ;
wire   Tpl_3027 ;
wire  [2:0] Tpl_3028 ;
wire   Tpl_3029 ;
wire  [2:0] Tpl_3030 ;
wire   Tpl_3031 ;
wire  [5:0] Tpl_3032 ;
wire   Tpl_3033 ;
wire   Tpl_3034 ;
wire  [5:0] Tpl_3035 ;
wire   Tpl_3036 ;
wire   Tpl_3037 ;
wire   Tpl_3038 ;
wire   Tpl_3039 ;
wire   Tpl_3040 ;
wire   Tpl_3041 ;
wire   Tpl_3042 ;
wire   Tpl_3043 ;
wire   Tpl_3044 ;
wire   Tpl_3045 ;
wire  [5:0] Tpl_3046 ;
wire   Tpl_3047 ;
wire   Tpl_3048 ;
wire  [5:0] Tpl_3049 ;
wire   Tpl_3050 ;
wire   Tpl_3051 ;
wire  [2:0] Tpl_3052 ;
wire   Tpl_3053 ;
wire   Tpl_3054 ;
wire   Tpl_3055 ;
wire  [1:0] Tpl_3056 ;
wire  [2:0] Tpl_3057 ;
wire   Tpl_3058 ;
wire   Tpl_3059 ;
wire   Tpl_3060 ;
wire  [1:0] Tpl_3061 ;
wire  [2:0] Tpl_3062 ;
wire   Tpl_3063 ;
wire   Tpl_3064 ;
wire   Tpl_3065 ;
wire  [1:0] Tpl_3066 ;
wire  [2:0] Tpl_3067 ;
wire   Tpl_3068 ;
wire   Tpl_3069 ;
wire   Tpl_3070 ;
wire  [1:0] Tpl_3071 ;
wire  [31:0] Tpl_3072 ;
wire  [31:0] Tpl_3073 ;
wire  [31:0] Tpl_3074 ;
wire  [31:0] Tpl_3075 ;
wire  [31:0] Tpl_3076 ;
wire  [31:0] Tpl_3077 ;
wire  [31:0] Tpl_3078 ;
wire  [31:0] Tpl_3079 ;
wire  [31:0] Tpl_3080 ;
wire  [31:0] Tpl_3081 ;
wire  [31:0] Tpl_3082 ;
wire  [31:0] Tpl_3083 ;
wire  [31:0] Tpl_3084 ;
wire  [31:0] Tpl_3085 ;
wire  [31:0] Tpl_3086 ;
wire  [31:0] Tpl_3087 ;
wire   Tpl_3088 ;
reg   Tpl_3089 ;
reg   Tpl_3090 ;
wire   Tpl_3091 ;
wire   Tpl_3092 ;
wire   Tpl_3093 ;
wire  [1:0] Tpl_3094 ;
reg  [1:0] Tpl_3095 ;
wire  [11:0] Tpl_3096 ;
wire  [11:0] Tpl_3097 ;
wire  [31:0] Tpl_3098 ;
reg  [31:0] Tpl_3099 ;
wire   Tpl_3100 ;
wire   Tpl_3101 ;
wire   Tpl_3102 ;
wire   Tpl_3103 ;
reg  [1:0] Tpl_3104 ;
reg  [1:0] Tpl_3105 ;
wire   Tpl_3106 ;
wire   Tpl_3107 ;
wire   Tpl_3108 ;
wire  [1:0] Tpl_3109 ;
reg   Tpl_3110 ;
reg   Tpl_3111 ;
reg   Tpl_3112 ;
reg   Tpl_3113 ;
reg   Tpl_3114 ;
reg   Tpl_3115 ;
reg   Tpl_3116 ;
reg   Tpl_3117 ;
reg   Tpl_3118 ;
reg   Tpl_3119 ;
reg   Tpl_3120 ;
reg   Tpl_3121 ;
reg   Tpl_3122 ;
reg   Tpl_3123 ;
reg   Tpl_3124 ;
reg   Tpl_3125 ;
reg   Tpl_3126 ;
reg   Tpl_3127 ;
reg   Tpl_3128 ;
reg   Tpl_3129 ;
reg   Tpl_3130 ;
reg   Tpl_3131 ;
reg   Tpl_3132 ;
reg   Tpl_3133 ;
reg   Tpl_3134 ;
reg   Tpl_3135 ;
reg   Tpl_3136 ;
reg   Tpl_3137 ;
reg   Tpl_3138 ;
reg   Tpl_3139 ;
reg   Tpl_3140 ;
reg   Tpl_3141 ;
reg   Tpl_3142 ;
reg   Tpl_3143 ;
reg   Tpl_3144 ;
reg   Tpl_3145 ;
reg   Tpl_3146 ;
reg   Tpl_3147 ;
reg   Tpl_3148 ;
reg   Tpl_3149 ;
reg   Tpl_3150 ;
reg   Tpl_3151 ;
reg   Tpl_3152 ;
reg   Tpl_3153 ;
reg   Tpl_3154 ;
reg   Tpl_3155 ;
reg   Tpl_3156 ;
reg   Tpl_3157 ;
reg   Tpl_3158 ;
reg   Tpl_3159 ;
reg   Tpl_3160 ;
reg   Tpl_3161 ;
reg   Tpl_3162 ;
reg   Tpl_3163 ;
reg   Tpl_3164 ;
reg   Tpl_3165 ;
reg   Tpl_3166 ;
reg   Tpl_3167 ;
reg   Tpl_3168 ;
reg   Tpl_3169 ;
reg   Tpl_3170 ;
reg   Tpl_3171 ;
reg   Tpl_3172 ;
reg   Tpl_3173 ;
reg   Tpl_3174 ;
reg   Tpl_3175 ;
reg   Tpl_3176 ;
reg   Tpl_3177 ;
reg   Tpl_3178 ;
reg   Tpl_3179 ;
reg   Tpl_3180 ;
reg   Tpl_3181 ;
reg   Tpl_3182 ;
reg   Tpl_3183 ;
reg   Tpl_3184 ;
reg   Tpl_3185 ;
reg   Tpl_3186 ;
reg   Tpl_3187 ;
reg   Tpl_3188 ;
reg   Tpl_3189 ;
reg   Tpl_3190 ;
reg   Tpl_3191 ;
reg   Tpl_3192 ;
reg   Tpl_3193 ;
reg   Tpl_3194 ;
reg   Tpl_3195 ;
reg   Tpl_3196 ;
reg   Tpl_3197 ;
reg   Tpl_3198 ;
reg   Tpl_3199 ;
reg   Tpl_3200 ;
reg   Tpl_3201 ;
reg   Tpl_3202 ;
reg   Tpl_3203 ;
reg   Tpl_3204 ;
reg   Tpl_3205 ;
reg   Tpl_3206 ;
reg   Tpl_3207 ;
reg   Tpl_3208 ;
reg   Tpl_3209 ;
reg   Tpl_3210 ;
reg   Tpl_3211 ;
reg   Tpl_3212 ;
reg   Tpl_3213 ;
reg   Tpl_3214 ;
reg   Tpl_3215 ;
reg   Tpl_3216 ;
reg   Tpl_3217 ;
reg   Tpl_3218 ;
reg   Tpl_3219 ;
reg   Tpl_3220 ;
reg   Tpl_3221 ;
reg   Tpl_3222 ;
reg   Tpl_3223 ;
reg   Tpl_3224 ;
reg   Tpl_3225 ;
reg   Tpl_3226 ;
reg   Tpl_3227 ;
reg   Tpl_3228 ;
reg   Tpl_3229 ;
reg   Tpl_3230 ;
reg   Tpl_3231 ;
reg   Tpl_3232 ;
reg   Tpl_3233 ;
reg   Tpl_3234 ;
reg   Tpl_3235 ;
reg   Tpl_3236 ;
reg   Tpl_3237 ;
reg   Tpl_3238 ;
reg   Tpl_3239 ;
reg   Tpl_3240 ;
reg   Tpl_3241 ;
reg   Tpl_3242 ;
reg   Tpl_3243 ;
reg   Tpl_3244 ;
reg   Tpl_3245 ;
reg   Tpl_3246 ;
reg   Tpl_3247 ;
reg   Tpl_3248 ;
reg   Tpl_3249 ;
reg   Tpl_3250 ;
reg   Tpl_3251 ;
reg   Tpl_3252 ;
reg   Tpl_3253 ;
reg   Tpl_3254 ;
reg   Tpl_3255 ;
reg   Tpl_3256 ;
reg   Tpl_3257 ;
reg   Tpl_3258 ;
reg   Tpl_3259 ;
reg   Tpl_3260 ;
reg   Tpl_3261 ;
reg   Tpl_3262 ;
reg   Tpl_3263 ;
reg   Tpl_3264 ;
reg   Tpl_3265 ;
reg   Tpl_3266 ;
reg   Tpl_3267 ;
reg   Tpl_3268 ;
reg   Tpl_3269 ;
reg   Tpl_3270 ;
reg   Tpl_3271 ;
reg   Tpl_3272 ;
reg   Tpl_3273 ;
reg   Tpl_3274 ;
reg   Tpl_3275 ;
reg   Tpl_3276 ;
reg   Tpl_3277 ;
reg   Tpl_3278 ;
reg   Tpl_3279 ;
reg   Tpl_3280 ;
reg   Tpl_3281 ;
reg   Tpl_3282 ;
reg   Tpl_3283 ;
reg   Tpl_3284 ;
reg   Tpl_3285 ;
reg   Tpl_3286 ;
reg   Tpl_3287 ;
reg   Tpl_3288 ;
reg   Tpl_3289 ;
reg   Tpl_3290 ;
reg   Tpl_3291 ;
reg   Tpl_3292 ;
reg   Tpl_3293 ;
reg   Tpl_3294 ;
reg   Tpl_3295 ;
reg   Tpl_3296 ;
reg   Tpl_3297 ;
reg   Tpl_3298 ;
reg   Tpl_3299 ;
reg   Tpl_3300 ;
reg   Tpl_3301 ;
reg   Tpl_3302 ;
reg   Tpl_3303 ;
reg   Tpl_3304 ;
reg   Tpl_3305 ;
reg   Tpl_3306 ;
reg   Tpl_3307 ;
reg   Tpl_3308 ;
reg   Tpl_3309 ;
reg   Tpl_3310 ;
reg   Tpl_3311 ;
reg   Tpl_3312 ;
reg   Tpl_3313 ;
reg   Tpl_3314 ;
reg   Tpl_3315 ;
reg   Tpl_3316 ;
reg   Tpl_3317 ;
reg   Tpl_3318 ;
reg   Tpl_3319 ;
reg   Tpl_3320 ;
reg   Tpl_3321 ;
reg   Tpl_3322 ;
reg   Tpl_3323 ;
reg   Tpl_3324 ;
reg   Tpl_3325 ;
reg   Tpl_3326 ;
reg   Tpl_3327 ;
reg   Tpl_3328 ;
reg   Tpl_3329 ;
reg   Tpl_3330 ;
reg   Tpl_3331 ;
reg   Tpl_3332 ;
reg   Tpl_3333 ;
reg   Tpl_3334 ;
reg   Tpl_3335 ;
reg   Tpl_3336 ;
reg   Tpl_3337 ;
reg   Tpl_3338 ;
reg   Tpl_3339 ;
reg   Tpl_3340 ;
reg   Tpl_3341 ;
reg   Tpl_3342 ;
reg   Tpl_3343 ;
reg   Tpl_3344 ;
reg   Tpl_3345 ;
reg   Tpl_3346 ;
reg   Tpl_3347 ;
reg   Tpl_3348 ;
reg   Tpl_3349 ;
reg   Tpl_3350 ;
reg   Tpl_3351 ;
reg   Tpl_3352 ;
reg   Tpl_3353 ;
reg   Tpl_3354 ;
reg   Tpl_3355 ;
reg   Tpl_3356 ;
reg   Tpl_3357 ;
reg   Tpl_3358 ;
reg   Tpl_3359 ;
reg   Tpl_3360 ;
reg   Tpl_3361 ;
reg   Tpl_3362 ;
reg   Tpl_3363 ;
reg   Tpl_3364 ;
reg   Tpl_3365 ;
reg   Tpl_3366 ;
reg   Tpl_3367 ;
reg   Tpl_3368 ;
reg   Tpl_3369 ;
reg   Tpl_3370 ;
reg   Tpl_3371 ;
reg   Tpl_3372 ;
reg   Tpl_3373 ;
reg   Tpl_3374 ;
reg   Tpl_3375 ;
reg   Tpl_3376 ;
reg   Tpl_3377 ;
reg   Tpl_3378 ;
reg   Tpl_3379 ;
reg   Tpl_3380 ;
reg   Tpl_3381 ;
reg   Tpl_3382 ;
reg   Tpl_3383 ;
reg   Tpl_3384 ;
reg   Tpl_3385 ;
reg   Tpl_3386 ;
reg   Tpl_3387 ;
reg   Tpl_3388 ;
reg   Tpl_3389 ;
reg   Tpl_3390 ;
reg   Tpl_3391 ;
reg   Tpl_3392 ;
reg   Tpl_3393 ;
reg   Tpl_3394 ;
reg   Tpl_3395 ;
reg   Tpl_3396 ;
reg   Tpl_3397 ;
reg   Tpl_3398 ;
reg   Tpl_3399 ;
reg   Tpl_3400 ;
reg   Tpl_3401 ;
reg   Tpl_3402 ;
reg   Tpl_3403 ;
reg   Tpl_3404 ;
reg   Tpl_3405 ;
reg   Tpl_3406 ;
reg   Tpl_3407 ;
reg   Tpl_3408 ;
reg   Tpl_3409 ;
reg   Tpl_3410 ;
reg   Tpl_3411 ;
reg   Tpl_3412 ;
reg   Tpl_3413 ;
reg   Tpl_3414 ;
reg   Tpl_3415 ;
reg   Tpl_3416 ;
reg   Tpl_3417 ;
reg   Tpl_3418 ;
reg   Tpl_3419 ;
reg   Tpl_3420 ;
reg   Tpl_3421 ;
reg   Tpl_3422 ;
reg   Tpl_3423 ;
reg   Tpl_3424 ;
reg   Tpl_3425 ;
reg   Tpl_3426 ;
reg   Tpl_3427 ;
reg   Tpl_3428 ;
reg   Tpl_3429 ;
reg   Tpl_3430 ;
reg   Tpl_3431 ;
reg   Tpl_3432 ;
reg   Tpl_3433 ;
reg   Tpl_3434 ;
reg   Tpl_3435 ;
reg   Tpl_3436 ;
reg   Tpl_3437 ;
reg   Tpl_3438 ;
reg   Tpl_3439 ;
reg   Tpl_3440 ;
reg   Tpl_3441 ;
reg   Tpl_3442 ;
reg   Tpl_3443 ;
reg   Tpl_3444 ;
reg   Tpl_3445 ;
reg   Tpl_3446 ;
reg   Tpl_3447 ;
reg   Tpl_3448 ;
reg   Tpl_3449 ;
reg   Tpl_3450 ;
reg   Tpl_3451 ;
reg   Tpl_3452 ;
reg   Tpl_3453 ;
reg   Tpl_3454 ;
reg   Tpl_3455 ;
reg   Tpl_3456 ;
reg   Tpl_3457 ;
reg   Tpl_3458 ;
reg   Tpl_3459 ;
reg   Tpl_3460 ;
reg   Tpl_3461 ;
reg   Tpl_3462 ;
reg   Tpl_3463 ;
reg   Tpl_3464 ;
reg   Tpl_3465 ;
reg   Tpl_3466 ;
reg   Tpl_3467 ;
reg   Tpl_3468 ;
reg   Tpl_3469 ;
reg   Tpl_3470 ;
reg   Tpl_3471 ;
reg   Tpl_3472 ;
reg   Tpl_3473 ;
reg   Tpl_3474 ;
reg   Tpl_3475 ;
reg   Tpl_3476 ;
reg   Tpl_3477 ;
reg   Tpl_3478 ;
reg   Tpl_3479 ;
reg   Tpl_3480 ;
reg   Tpl_3481 ;
reg   Tpl_3482 ;
reg   Tpl_3483 ;
reg   Tpl_3484 ;
reg   Tpl_3485 ;
reg   Tpl_3486 ;
reg   Tpl_3487 ;
reg   Tpl_3488 ;
reg   Tpl_3489 ;
reg   Tpl_3490 ;
reg   Tpl_3491 ;
reg   Tpl_3492 ;
reg   Tpl_3493 ;
reg   Tpl_3494 ;
reg   Tpl_3495 ;
reg   Tpl_3496 ;
reg   Tpl_3497 ;
reg   Tpl_3498 ;
reg   Tpl_3499 ;
reg   Tpl_3500 ;
reg   Tpl_3501 ;
reg   Tpl_3502 ;
reg   Tpl_3503 ;
reg   Tpl_3504 ;
reg   Tpl_3505 ;
reg   Tpl_3506 ;
reg   Tpl_3507 ;
reg   Tpl_3508 ;
reg   Tpl_3509 ;
reg   Tpl_3510 ;
reg   Tpl_3511 ;
reg   Tpl_3512 ;
reg   Tpl_3513 ;
reg   Tpl_3514 ;
reg   Tpl_3515 ;
reg   Tpl_3516 ;
reg   Tpl_3517 ;
reg   Tpl_3518 ;
reg   Tpl_3519 ;
reg   Tpl_3520 ;
reg   Tpl_3521 ;
reg   Tpl_3522 ;
reg   Tpl_3523 ;
reg   Tpl_3524 ;
reg   Tpl_3525 ;
reg   Tpl_3526 ;
reg   Tpl_3527 ;
reg   Tpl_3528 ;
reg   Tpl_3529 ;
reg   Tpl_3530 ;
reg   Tpl_3531 ;
reg   Tpl_3532 ;
reg   Tpl_3533 ;
reg   Tpl_3534 ;
reg   Tpl_3535 ;
reg   Tpl_3536 ;
reg   Tpl_3537 ;
reg   Tpl_3538 ;
reg   Tpl_3539 ;
reg   Tpl_3540 ;
reg   Tpl_3541 ;
reg   Tpl_3542 ;
reg   Tpl_3543 ;
reg   Tpl_3544 ;
reg   Tpl_3545 ;
reg   Tpl_3546 ;
reg   Tpl_3547 ;
reg   Tpl_3548 ;
reg   Tpl_3549 ;
reg   Tpl_3550 ;
reg   Tpl_3551 ;
reg   Tpl_3552 ;
reg   Tpl_3553 ;
reg   Tpl_3554 ;
reg   Tpl_3555 ;
reg   Tpl_3556 ;
reg   Tpl_3557 ;
reg   Tpl_3558 ;
reg   Tpl_3559 ;
reg   Tpl_3560 ;
reg   Tpl_3561 ;
reg   Tpl_3562 ;
reg   Tpl_3563 ;
reg   Tpl_3564 ;
reg   Tpl_3565 ;
reg   Tpl_3566 ;
reg   Tpl_3567 ;
reg   Tpl_3568 ;
reg   Tpl_3569 ;
reg   Tpl_3570 ;
reg   Tpl_3571 ;
reg   Tpl_3572 ;
reg   Tpl_3573 ;
reg   Tpl_3574 ;
reg   Tpl_3575 ;
reg   Tpl_3576 ;
reg   Tpl_3577 ;
reg   Tpl_3578 ;
reg   Tpl_3579 ;
reg   Tpl_3580 ;
reg   Tpl_3581 ;
reg   Tpl_3582 ;
reg   Tpl_3583 ;
reg   Tpl_3584 ;
reg   Tpl_3585 ;
reg   Tpl_3586 ;
reg   Tpl_3587 ;
reg   Tpl_3588 ;
reg   Tpl_3589 ;
reg   Tpl_3590 ;
reg   Tpl_3591 ;
reg   Tpl_3592 ;
reg   Tpl_3593 ;
reg   Tpl_3594 ;
reg   Tpl_3595 ;
reg   Tpl_3596 ;
reg   Tpl_3597 ;
reg   Tpl_3598 ;
reg   Tpl_3599 ;
reg   Tpl_3600 ;
reg   Tpl_3601 ;
reg   Tpl_3602 ;
reg   Tpl_3603 ;
reg   Tpl_3604 ;
reg   Tpl_3605 ;
reg   Tpl_3606 ;
reg   Tpl_3607 ;
reg   Tpl_3608 ;
reg   Tpl_3609 ;
reg   Tpl_3610 ;
reg   Tpl_3611 ;
reg  [15:0] Tpl_3612 ;
reg  [1:0] Tpl_3613 ;
reg  [1:0] Tpl_3614 ;
reg   Tpl_3615 ;
reg   Tpl_3616 ;
reg  [15:0] Tpl_3617 ;
reg   Tpl_3618 ;
reg   Tpl_3619 ;
reg   Tpl_3620 ;
reg   Tpl_3621 ;
reg   Tpl_3622 ;
reg   Tpl_3623 ;
reg  [15:0] Tpl_3624 ;
reg   Tpl_3625 ;
reg   Tpl_3626 ;
reg   Tpl_3627 ;
reg   Tpl_3628 ;
reg   Tpl_3629 ;
reg   Tpl_3630 ;
reg   Tpl_3631 ;
reg   Tpl_3632 ;
reg   Tpl_3633 ;
reg   Tpl_3634 ;
reg  [3:0] Tpl_3635 ;
reg  [16:0] Tpl_3636 ;
reg   Tpl_3637 ;
reg   Tpl_3638 ;
reg   Tpl_3639 ;
reg   Tpl_3640 ;
reg  [3:0] Tpl_3641 ;
reg  [16:0] Tpl_3642 ;
reg   Tpl_3643 ;
reg   Tpl_3644 ;
reg   Tpl_3645 ;
reg   Tpl_3646 ;
reg   Tpl_3647 ;
reg   Tpl_3648 ;
reg   Tpl_3649 ;
reg  [1:0] Tpl_3650 ;
reg  [1:0] Tpl_3651 ;
reg  [1:0] Tpl_3652 ;
reg  [1:0] Tpl_3653 ;
reg  [1:0] Tpl_3654 ;
reg  [1:0] Tpl_3655 ;
reg   Tpl_3656 ;
reg   Tpl_3657 ;
reg   Tpl_3658 ;
reg   Tpl_3659 ;
reg   Tpl_3660 ;
reg  [1:0] Tpl_3661 ;
reg  [3:0] Tpl_3662 ;
reg  [1:0] Tpl_3663 ;
reg  [3:0] Tpl_3664 ;
reg  [3:0] Tpl_3665 ;
reg  [3:0] Tpl_3666 ;
reg  [3:0] Tpl_3667 ;
reg  [5:0] Tpl_3668 ;
reg  [3:0] Tpl_3669 ;
reg  [3:0] Tpl_3670 ;
reg  [3:0] Tpl_3671 ;
reg  [3:0] Tpl_3672 ;
reg  [3:0] Tpl_3673 ;
reg  [31:0] Tpl_3674 ;
reg  [31:0] Tpl_3675 ;
reg  [3:0] Tpl_3676 ;
reg  [1:0] Tpl_3677 ;
reg  [3:0] Tpl_3678 ;
reg  [3:0] Tpl_3679 ;
reg  [3:0] Tpl_3680 ;
reg  [3:0] Tpl_3681 ;
reg  [31:0] Tpl_3682 ;
reg  [31:0] Tpl_3683 ;
reg  [1:0] Tpl_3684 ;
reg  [1:0] Tpl_3685 ;
reg  [1:0] Tpl_3686 ;
reg  [3:0] Tpl_3687 ;
reg  [3:0] Tpl_3688 ;
reg  [3:0] Tpl_3689 ;
reg   Tpl_3690 ;
reg  [29:0] Tpl_3691 ;
reg  [31:0] Tpl_3692 ;
reg  [3:0] Tpl_3693 ;
reg   Tpl_3694 ;
reg   Tpl_3695 ;
reg  [3:0] Tpl_3696 ;
reg  [3:0] Tpl_3697 ;
reg   Tpl_3698 ;
reg  [7:0] Tpl_3699 ;
reg   Tpl_3700 ;
reg  [7:0] Tpl_3701 ;
reg   Tpl_3702 ;
reg  [7:0] Tpl_3703 ;
reg  [1:0] Tpl_3704 ;
reg   Tpl_3705 ;
reg   Tpl_3706 ;
reg  [2:0] Tpl_3707 ;
reg   Tpl_3708 ;
reg  [1:0] Tpl_3709 ;
reg   Tpl_3710 ;
reg   Tpl_3711 ;
reg  [2:0] Tpl_3712 ;
reg   Tpl_3713 ;
reg  [2:0] Tpl_3714 ;
reg  [2:0] Tpl_3715 ;
reg   Tpl_3716 ;
reg   Tpl_3717 ;
reg  [2:0] Tpl_3718 ;
reg  [2:0] Tpl_3719 ;
reg   Tpl_3720 ;
reg   Tpl_3721 ;
reg   Tpl_3722 ;
reg   Tpl_3723 ;
reg   Tpl_3724 ;
reg  [2:0] Tpl_3725 ;
reg   Tpl_3726 ;
reg   Tpl_3727 ;
reg   Tpl_3728 ;
reg   Tpl_3729 ;
reg   Tpl_3730 ;
reg  [2:0] Tpl_3731 ;
reg   Tpl_3732 ;
reg   Tpl_3733 ;
reg  [2:0] Tpl_3734 ;
reg   Tpl_3735 ;
reg  [2:0] Tpl_3736 ;
reg   Tpl_3737 ;
reg  [2:0] Tpl_3738 ;
reg   Tpl_3739 ;
reg  [2:0] Tpl_3740 ;
reg   Tpl_3741 ;
reg  [2:0] Tpl_3742 ;
reg   Tpl_3743 ;
reg  [2:0] Tpl_3744 ;
reg   Tpl_3745 ;
reg  [2:0] Tpl_3746 ;
reg   Tpl_3747 ;
reg  [2:0] Tpl_3748 ;
reg   Tpl_3749 ;
reg  [5:0] Tpl_3750 ;
reg   Tpl_3751 ;
reg   Tpl_3752 ;
reg  [5:0] Tpl_3753 ;
reg   Tpl_3754 ;
reg   Tpl_3755 ;
reg   Tpl_3756 ;
reg   Tpl_3757 ;
reg   Tpl_3758 ;
reg   Tpl_3759 ;
reg   Tpl_3760 ;
reg   Tpl_3761 ;
reg   Tpl_3762 ;
reg   Tpl_3763 ;
reg  [5:0] Tpl_3764 ;
reg   Tpl_3765 ;
reg   Tpl_3766 ;
reg  [5:0] Tpl_3767 ;
reg   Tpl_3768 ;
reg   Tpl_3769 ;
reg  [2:0] Tpl_3770 ;
reg   Tpl_3771 ;
reg   Tpl_3772 ;
reg   Tpl_3773 ;
reg  [1:0] Tpl_3774 ;
reg  [2:0] Tpl_3775 ;
reg   Tpl_3776 ;
reg   Tpl_3777 ;
reg   Tpl_3778 ;
reg  [1:0] Tpl_3779 ;
reg  [2:0] Tpl_3780 ;
reg   Tpl_3781 ;
reg   Tpl_3782 ;
reg   Tpl_3783 ;
reg  [1:0] Tpl_3784 ;
reg  [2:0] Tpl_3785 ;
reg   Tpl_3786 ;
reg   Tpl_3787 ;
reg   Tpl_3788 ;
reg  [1:0] Tpl_3789 ;
reg  [31:0] Tpl_3790 ;
reg  [31:0] Tpl_3791 ;
reg  [31:0] Tpl_3792 ;
reg  [31:0] Tpl_3793 ;
reg  [31:0] Tpl_3794 ;
reg  [31:0] Tpl_3795 ;
reg  [31:0] Tpl_3796 ;
reg  [31:0] Tpl_3797 ;
reg  [31:0] Tpl_3798 ;
reg  [31:0] Tpl_3799 ;
reg  [31:0] Tpl_3800 ;
reg  [31:0] Tpl_3801 ;
reg  [31:0] Tpl_3802 ;
reg  [31:0] Tpl_3803 ;
reg  [31:0] Tpl_3804 ;
reg  [31:0] Tpl_3805 ;
reg   Tpl_3806 ;
reg  [31:0] Tpl_3807 ;
reg  [31:0] Tpl_3808 ;
reg  [31:0] Tpl_3809 ;
reg  [31:0] Tpl_3810 ;
reg  [31:0] Tpl_3811 ;
reg  [31:0] Tpl_3812 ;
reg  [31:0] Tpl_3813 ;
reg  [31:0] Tpl_3814 ;
reg  [31:0] Tpl_3815 ;
reg  [31:0] Tpl_3816 ;
reg  [31:0] Tpl_3817 ;
reg  [31:0] Tpl_3818 ;
reg  [31:0] Tpl_3819 ;
reg  [31:0] Tpl_3820 ;
reg  [31:0] Tpl_3821 ;
reg  [31:0] Tpl_3822 ;
reg  [31:0] Tpl_3823 ;
reg  [31:0] Tpl_3824 ;
reg  [31:0] Tpl_3825 ;
reg  [31:0] Tpl_3826 ;
reg  [31:0] Tpl_3827 ;
reg  [31:0] Tpl_3828 ;
reg  [31:0] Tpl_3829 ;
reg  [31:0] Tpl_3830 ;
reg  [31:0] Tpl_3831 ;
reg  [31:0] Tpl_3832 ;
reg  [31:0] Tpl_3833 ;
reg  [31:0] Tpl_3834 ;
reg  [31:0] Tpl_3835 ;
reg  [31:0] Tpl_3836 ;
reg  [31:0] Tpl_3837 ;
reg  [31:0] Tpl_3838 ;
reg  [31:0] Tpl_3839 ;
reg  [31:0] Tpl_3840 ;
reg  [31:0] Tpl_3841 ;
reg  [31:0] Tpl_3842 ;
reg  [31:0] Tpl_3843 ;
reg  [31:0] Tpl_3844 ;
reg  [31:0] Tpl_3845 ;
reg  [31:0] Tpl_3846 ;
reg  [31:0] Tpl_3847 ;
reg  [31:0] Tpl_3848 ;
reg  [31:0] Tpl_3849 ;
reg  [31:0] Tpl_3850 ;
reg  [31:0] Tpl_3851 ;
reg  [31:0] Tpl_3852 ;
reg  [31:0] Tpl_3853 ;
reg  [31:0] Tpl_3854 ;
reg  [31:0] Tpl_3855 ;
reg  [31:0] Tpl_3856 ;
reg  [31:0] Tpl_3857 ;
reg  [31:0] Tpl_3858 ;
reg  [31:0] Tpl_3859 ;
reg  [31:0] Tpl_3860 ;
reg  [31:0] Tpl_3861 ;
reg  [31:0] Tpl_3862 ;
reg  [31:0] Tpl_3863 ;
reg  [31:0] Tpl_3864 ;
reg  [31:0] Tpl_3865 ;
reg  [31:0] Tpl_3866 ;
reg  [31:0] Tpl_3867 ;
reg  [31:0] Tpl_3868 ;
reg  [31:0] Tpl_3869 ;
reg  [31:0] Tpl_3870 ;
reg  [31:0] Tpl_3871 ;
reg  [31:0] Tpl_3872 ;
reg  [31:0] Tpl_3873 ;
reg  [31:0] Tpl_3874 ;
reg  [31:0] Tpl_3875 ;
reg  [31:0] Tpl_3876 ;
reg  [31:0] Tpl_3877 ;
reg  [31:0] Tpl_3878 ;
reg  [31:0] Tpl_3879 ;
reg  [31:0] Tpl_3880 ;
reg  [31:0] Tpl_3881 ;
reg  [31:0] Tpl_3882 ;
reg  [31:0] Tpl_3883 ;
reg  [31:0] Tpl_3884 ;
reg  [31:0] Tpl_3885 ;
reg  [31:0] Tpl_3886 ;
reg  [31:0] Tpl_3887 ;
reg  [31:0] Tpl_3888 ;
reg  [31:0] Tpl_3889 ;
reg  [31:0] Tpl_3890 ;
reg  [31:0] Tpl_3891 ;
reg  [31:0] Tpl_3892 ;
reg  [31:0] Tpl_3893 ;
reg  [31:0] Tpl_3894 ;
reg  [31:0] Tpl_3895 ;
reg  [31:0] Tpl_3896 ;
reg  [31:0] Tpl_3897 ;
reg  [31:0] Tpl_3898 ;
reg  [31:0] Tpl_3899 ;
reg  [31:0] Tpl_3900 ;
reg  [31:0] Tpl_3901 ;
reg  [31:0] Tpl_3902 ;
reg  [31:0] Tpl_3903 ;
reg  [31:0] Tpl_3904 ;
reg  [31:0] Tpl_3905 ;
reg  [31:0] Tpl_3906 ;
reg  [31:0] Tpl_3907 ;
reg  [31:0] Tpl_3908 ;
reg  [31:0] Tpl_3909 ;
reg  [31:0] Tpl_3910 ;
reg  [31:0] Tpl_3911 ;
reg  [31:0] Tpl_3912 ;
reg  [31:0] Tpl_3913 ;
reg  [31:0] Tpl_3914 ;
reg  [31:0] Tpl_3915 ;
reg  [31:0] Tpl_3916 ;
reg  [31:0] Tpl_3917 ;
reg  [31:0] Tpl_3918 ;
reg  [31:0] Tpl_3919 ;
reg  [31:0] Tpl_3920 ;
reg  [31:0] Tpl_3921 ;
reg  [31:0] Tpl_3922 ;
reg  [31:0] Tpl_3923 ;
reg  [31:0] Tpl_3924 ;
reg  [31:0] Tpl_3925 ;
reg  [31:0] Tpl_3926 ;
reg  [31:0] Tpl_3927 ;
reg  [31:0] Tpl_3928 ;
reg  [31:0] Tpl_3929 ;
reg  [31:0] Tpl_3930 ;
reg  [31:0] Tpl_3931 ;
reg  [31:0] Tpl_3932 ;
reg  [31:0] Tpl_3933 ;
reg  [31:0] Tpl_3934 ;
reg  [31:0] Tpl_3935 ;
reg  [31:0] Tpl_3936 ;
reg  [31:0] Tpl_3937 ;
reg  [31:0] Tpl_3938 ;
reg  [31:0] Tpl_3939 ;
reg  [31:0] Tpl_3940 ;
reg  [31:0] Tpl_3941 ;
reg  [31:0] Tpl_3942 ;
reg  [31:0] Tpl_3943 ;
reg  [31:0] Tpl_3944 ;
reg  [31:0] Tpl_3945 ;
reg  [31:0] Tpl_3946 ;
reg  [31:0] Tpl_3947 ;
reg  [31:0] Tpl_3948 ;
reg  [31:0] Tpl_3949 ;
reg  [31:0] Tpl_3950 ;
reg  [31:0] Tpl_3951 ;
reg  [31:0] Tpl_3952 ;
reg  [31:0] Tpl_3953 ;
reg  [31:0] Tpl_3954 ;
reg  [31:0] Tpl_3955 ;
reg  [31:0] Tpl_3956 ;
reg  [31:0] Tpl_3957 ;
reg  [31:0] Tpl_3958 ;
reg  [31:0] Tpl_3959 ;
reg  [31:0] Tpl_3960 ;
reg  [31:0] Tpl_3961 ;
reg  [31:0] Tpl_3962 ;
reg  [31:0] Tpl_3963 ;
reg  [31:0] Tpl_3964 ;
reg  [31:0] Tpl_3965 ;
reg  [31:0] Tpl_3966 ;
reg  [31:0] Tpl_3967 ;
reg  [31:0] Tpl_3968 ;
reg  [31:0] Tpl_3969 ;
reg  [31:0] Tpl_3970 ;
reg  [31:0] Tpl_3971 ;
reg  [31:0] Tpl_3972 ;
reg  [31:0] Tpl_3973 ;
reg  [31:0] Tpl_3974 ;
reg  [31:0] Tpl_3975 ;
reg  [31:0] Tpl_3976 ;
reg  [31:0] Tpl_3977 ;
reg  [31:0] Tpl_3978 ;
reg  [31:0] Tpl_3979 ;
reg  [31:0] Tpl_3980 ;
reg  [31:0] Tpl_3981 ;
reg  [31:0] Tpl_3982 ;
reg  [31:0] Tpl_3983 ;
reg  [31:0] Tpl_3984 ;
reg  [31:0] Tpl_3985 ;
reg  [31:0] Tpl_3986 ;
reg  [31:0] Tpl_3987 ;
reg  [31:0] Tpl_3988 ;
reg  [31:0] Tpl_3989 ;
reg  [31:0] Tpl_3990 ;
reg  [31:0] Tpl_3991 ;
reg  [31:0] Tpl_3992 ;
reg  [31:0] Tpl_3993 ;
reg  [31:0] Tpl_3994 ;
reg  [31:0] Tpl_3995 ;
reg  [31:0] Tpl_3996 ;
reg  [31:0] Tpl_3997 ;
reg  [31:0] Tpl_3998 ;
reg  [31:0] Tpl_3999 ;
reg  [31:0] Tpl_4000 ;
reg  [31:0] Tpl_4001 ;
reg  [31:0] Tpl_4002 ;
reg  [31:0] Tpl_4003 ;
reg  [31:0] Tpl_4004 ;
reg  [31:0] Tpl_4005 ;
reg  [31:0] Tpl_4006 ;
reg  [31:0] Tpl_4007 ;
reg  [31:0] Tpl_4008 ;
reg  [31:0] Tpl_4009 ;
reg  [31:0] Tpl_4010 ;
reg  [31:0] Tpl_4011 ;
reg  [31:0] Tpl_4012 ;
reg  [31:0] Tpl_4013 ;
reg  [31:0] Tpl_4014 ;
reg  [31:0] Tpl_4015 ;
reg  [31:0] Tpl_4016 ;
reg  [31:0] Tpl_4017 ;
reg  [31:0] Tpl_4018 ;
reg  [31:0] Tpl_4019 ;
reg  [31:0] Tpl_4020 ;
reg  [31:0] Tpl_4021 ;
reg  [31:0] Tpl_4022 ;
reg  [31:0] Tpl_4023 ;
reg  [31:0] Tpl_4024 ;
reg  [31:0] Tpl_4025 ;
reg  [31:0] Tpl_4026 ;
reg  [31:0] Tpl_4027 ;
reg  [31:0] Tpl_4028 ;
reg  [31:0] Tpl_4029 ;
reg  [31:0] Tpl_4030 ;
reg  [31:0] Tpl_4031 ;
reg  [31:0] Tpl_4032 ;
reg  [31:0] Tpl_4033 ;
reg  [31:0] Tpl_4034 ;
reg  [31:0] Tpl_4035 ;
reg  [31:0] Tpl_4036 ;
reg  [31:0] Tpl_4037 ;
reg  [31:0] Tpl_4038 ;
reg  [31:0] Tpl_4039 ;
reg  [31:0] Tpl_4040 ;
reg  [31:0] Tpl_4041 ;
reg  [31:0] Tpl_4042 ;
reg  [31:0] Tpl_4043 ;
reg  [31:0] Tpl_4044 ;
reg  [31:0] Tpl_4045 ;
reg  [31:0] Tpl_4046 ;
reg  [31:0] Tpl_4047 ;
reg  [31:0] Tpl_4048 ;
reg  [31:0] Tpl_4049 ;
reg  [31:0] Tpl_4050 ;
reg  [31:0] Tpl_4051 ;
reg  [31:0] Tpl_4052 ;
reg  [31:0] Tpl_4053 ;
reg  [31:0] Tpl_4054 ;
reg  [31:0] Tpl_4055 ;
reg  [31:0] Tpl_4056 ;
reg  [31:0] Tpl_4057 ;
reg  [31:0] Tpl_4058 ;
reg  [31:0] Tpl_4059 ;
reg  [31:0] Tpl_4060 ;
reg  [31:0] Tpl_4061 ;
reg  [31:0] Tpl_4062 ;
reg  [31:0] Tpl_4063 ;
reg  [31:0] Tpl_4064 ;
reg  [31:0] Tpl_4065 ;
reg  [31:0] Tpl_4066 ;
reg  [31:0] Tpl_4067 ;
reg  [31:0] Tpl_4068 ;
reg  [31:0] Tpl_4069 ;
reg  [31:0] Tpl_4070 ;
reg  [31:0] Tpl_4071 ;
reg  [31:0] Tpl_4072 ;
reg  [31:0] Tpl_4073 ;
reg  [31:0] Tpl_4074 ;
reg  [31:0] Tpl_4075 ;
reg  [31:0] Tpl_4076 ;
reg  [31:0] Tpl_4077 ;
reg  [31:0] Tpl_4078 ;
reg  [31:0] Tpl_4079 ;
reg  [31:0] Tpl_4080 ;
reg  [31:0] Tpl_4081 ;
reg  [31:0] Tpl_4082 ;
reg  [31:0] Tpl_4083 ;
wire   Tpl_4085 ;
wire   Tpl_4086 ;
wire   Tpl_4087 ;
wire  [11:0] Tpl_4088 ;
reg   Tpl_4089 ;
wire   Tpl_4090 ;
reg   Tpl_4091 ;
reg  [31:0] Tpl_4092 ;
reg  [1:0] Tpl_4093 ;
wire  [1:0] Tpl_4094 ;
wire  [1:0] Tpl_4095 ;
wire  [31:0] Tpl_4096 ;
reg   Tpl_4097 ;
reg  [11:0] Tpl_4098 ;
reg  [1:0] Tpl_4099 ;
reg  [1:0] Tpl_4100 ;
wire   Tpl_4101 ;
wire   Tpl_4102 ;
wire   Tpl_4103 ;
wire   Tpl_4104 ;
wire  [11:0] Tpl_4105 ;
reg   Tpl_4106 ;
wire   Tpl_4107 ;
wire  [31:0] Tpl_4108 ;
reg   Tpl_4109 ;
wire   Tpl_4110 ;
reg   Tpl_4111 ;
reg  [1:0] Tpl_4112 ;
wire  [1:0] Tpl_4113 ;
wire  [1:0] Tpl_4114 ;
wire  [1:0] Tpl_4115 ;
reg  [31:0] Tpl_4116 ;
reg   Tpl_4117 ;
reg  [11:0] Tpl_4118 ;
reg  [2:0] Tpl_4119 ;
reg  [2:0] Tpl_4120 ;
wire  [1:0] Tpl_4121 ;
wire   Tpl_4122 ;
wire   Tpl_4123 ;
wire  [2:0] Tpl_4124 ;
wire   Tpl_4125 ;
wire  [1:0] Tpl_4126 ;
wire   Tpl_4127 ;
wire   Tpl_4128 ;
wire  [2:0] Tpl_4129 ;
wire   Tpl_4130 ;
wire  [2:0] Tpl_4131 ;
wire  [2:0] Tpl_4132 ;
wire   Tpl_4133 ;
wire   Tpl_4134 ;
wire  [2:0] Tpl_4135 ;
wire  [2:0] Tpl_4136 ;
wire   Tpl_4137 ;
wire   Tpl_4138 ;
wire   Tpl_4139 ;
wire   Tpl_4140 ;
wire  [2:0] Tpl_4141 ;
wire   Tpl_4142 ;
wire   Tpl_4143 ;
wire   Tpl_4144 ;
wire   Tpl_4145 ;
wire  [2:0] Tpl_4146 ;
wire   Tpl_4147 ;
wire   Tpl_4148 ;
wire  [2:0] Tpl_4149 ;
wire  [2:0] Tpl_4150 ;
wire  [2:0] Tpl_4151 ;
wire  [2:0] Tpl_4152 ;
wire  [2:0] Tpl_4153 ;
wire  [2:0] Tpl_4154 ;
wire  [2:0] Tpl_4155 ;
wire  [2:0] Tpl_4156 ;
wire  [5:0] Tpl_4157 ;
wire   Tpl_4158 ;
wire  [5:0] Tpl_4159 ;
wire   Tpl_4160 ;
wire   Tpl_4161 ;
wire   Tpl_4162 ;
wire   Tpl_4163 ;
wire   Tpl_4164 ;
wire   Tpl_4165 ;
wire   Tpl_4166 ;
wire   Tpl_4167 ;
wire   Tpl_4168 ;
wire  [5:0] Tpl_4169 ;
wire   Tpl_4170 ;
wire  [5:0] Tpl_4171 ;
wire   Tpl_4172 ;
wire  [2:0] Tpl_4173 ;
wire   Tpl_4174 ;
wire   Tpl_4175 ;
wire   Tpl_4176 ;
wire  [1:0] Tpl_4177 ;
wire  [2:0] Tpl_4178 ;
wire   Tpl_4179 ;
wire   Tpl_4180 ;
wire   Tpl_4181 ;
wire  [2:0] Tpl_4182 ;
wire   Tpl_4183 ;
wire   Tpl_4184 ;
wire   Tpl_4185 ;
wire  [1:0] Tpl_4186 ;
wire  [2:0] Tpl_4187 ;
wire   Tpl_4188 ;
wire   Tpl_4189 ;
wire   Tpl_4190 ;
wire  [2:0] Tpl_4191 ;
wire  [2:0] Tpl_4192 ;
wire  [3:0] Tpl_4193 ;
wire   Tpl_4194 ;
wire   Tpl_4195 ;
wire   Tpl_4196 ;
wire  [3:0] Tpl_4197 ;
wire  [7:0] Tpl_4198 ;
wire  [1:0] Tpl_4199 ;
wire   Tpl_4200 ;
wire  [7:0] Tpl_4201 ;
wire  [7:0] Tpl_4202 ;
wire  [2:0] Tpl_4203 ;
wire   Tpl_4204 ;
wire   Tpl_4205 ;
wire  [3:0] Tpl_4206 ;
wire   Tpl_4207 ;
wire  [1:0] Tpl_4208 ;
wire   Tpl_4209 ;
wire   Tpl_4210 ;
wire   Tpl_4211 ;
wire  [2:0] Tpl_4212 ;
wire  [1:0] Tpl_4213 ;
wire   Tpl_4214 ;
wire  [2:0] Tpl_4215 ;
wire  [1:0] Tpl_4216 ;
wire  [1:0] Tpl_4217 ;
wire  [2:0] Tpl_4218 ;
wire   Tpl_4219 ;
wire   Tpl_4220 ;
wire  [1:0] Tpl_4221 ;
wire   Tpl_4222 ;
wire   Tpl_4223 ;
wire   Tpl_4224 ;
wire  [2:0] Tpl_4225 ;
wire  [1:0] Tpl_4226 ;
wire  [1:0] Tpl_4227 ;
wire   Tpl_4228 ;
wire   Tpl_4229 ;
wire   Tpl_4230 ;
wire   Tpl_4231 ;
wire  [2:0] Tpl_4232 ;
wire   Tpl_4233 ;
wire   Tpl_4234 ;
wire   Tpl_4235 ;
wire   Tpl_4236 ;
wire  [2:0] Tpl_4237 ;
wire   Tpl_4238 ;
wire   Tpl_4239 ;
wire   Tpl_4240 ;
wire  [2:0] Tpl_4241 ;
wire   Tpl_4242 ;
wire   Tpl_4243 ;
wire   Tpl_4244 ;
wire   Tpl_4245 ;
wire  [5:0] Tpl_4246 ;
wire   Tpl_4247 ;
wire   Tpl_4248 ;
wire  [2:0] Tpl_4249 ;
wire   Tpl_4250 ;
wire  [2:0] Tpl_4251 ;
wire   Tpl_4252 ;
wire   Tpl_4253 ;
wire  [3:0] Tpl_4254 ;
wire   Tpl_4255 ;
wire  [2:0] Tpl_4256 ;
wire   Tpl_4257 ;
wire   Tpl_4258 ;
wire   Tpl_4259 ;
wire  [2:0] Tpl_4260 ;
wire  [1:0] Tpl_4261 ;
wire   Tpl_4262 ;
wire  [1:0] Tpl_4263 ;
wire  [1:0] Tpl_4264 ;
wire   Tpl_4265 ;
wire   Tpl_4266 ;
wire  [2:0] Tpl_4267 ;
wire  [2:0] Tpl_4268 ;
wire   Tpl_4269 ;
wire  [1:0] Tpl_4270 ;
wire   Tpl_4271 ;
wire   Tpl_4272 ;
wire  [3:0] Tpl_4273 ;
wire  [3:0] Tpl_4274 ;
wire  [3:0] Tpl_4275 ;
wire  [3:0] Tpl_4276 ;
wire   Tpl_4277 ;
wire   Tpl_4278 ;
wire   Tpl_4279 ;
wire   Tpl_4280 ;
wire   Tpl_4281 ;
wire   Tpl_4282 ;
wire   Tpl_4283 ;
wire   Tpl_4284 ;
wire   Tpl_4285 ;
wire  [2:0] Tpl_4286 ;
wire   Tpl_4287 ;
wire   Tpl_4288 ;
wire  [3:0] Tpl_4289 ;
wire  [3:0] Tpl_4290 ;
wire  [3:0] Tpl_4291 ;
wire  [3:0] Tpl_4292 ;
wire   Tpl_4293 ;
wire   Tpl_4294 ;
wire   Tpl_4295 ;
wire   Tpl_4296 ;
wire   Tpl_4297 ;
wire   Tpl_4298 ;
wire   Tpl_4299 ;
wire   Tpl_4300 ;
wire   Tpl_4301 ;
wire  [2:0] Tpl_4302 ;
wire   Tpl_4303 ;
wire   Tpl_4304 ;
wire  [3:0] Tpl_4305 ;
wire  [3:0] Tpl_4306 ;
wire  [3:0] Tpl_4307 ;
wire  [3:0] Tpl_4308 ;
wire   Tpl_4309 ;
wire   Tpl_4310 ;
wire   Tpl_4311 ;
wire   Tpl_4312 ;
wire   Tpl_4313 ;
wire   Tpl_4314 ;
wire   Tpl_4315 ;
wire   Tpl_4316 ;
wire   Tpl_4317 ;
wire  [2:0] Tpl_4318 ;
wire   Tpl_4319 ;
wire   Tpl_4320 ;
wire  [3:0] Tpl_4321 ;
wire  [3:0] Tpl_4322 ;
wire  [3:0] Tpl_4323 ;
wire  [3:0] Tpl_4324 ;
wire   Tpl_4325 ;
wire   Tpl_4326 ;
wire   Tpl_4327 ;
wire   Tpl_4328 ;
wire   Tpl_4329 ;
wire   Tpl_4330 ;
wire   Tpl_4331 ;
wire   Tpl_4332 ;
wire   Tpl_4333 ;
wire  [2:0] Tpl_4334 ;
wire  [7:0] Tpl_4335 ;
wire  [7:0] Tpl_4336 ;
wire  [7:0] Tpl_4337 ;
wire  [7:0] Tpl_4338 ;
wire  [7:0] Tpl_4339 ;
wire  [7:0] Tpl_4340 ;
wire  [7:0] Tpl_4341 ;
wire  [7:0] Tpl_4342 ;
wire  [7:0] Tpl_4343 ;
wire  [7:0] Tpl_4344 ;
wire  [7:0] Tpl_4345 ;
wire  [7:0] Tpl_4346 ;
wire  [7:0] Tpl_4347 ;
wire  [7:0] Tpl_4348 ;
wire  [7:0] Tpl_4349 ;
wire  [7:0] Tpl_4350 ;
wire  [2:0] Tpl_4351 ;
wire  [2:0] Tpl_4352 ;
wire  [2:0] Tpl_4353 ;
wire  [2:0] Tpl_4354 ;
wire  [4:0] Tpl_4355 ;
wire  [4:0] Tpl_4356 ;
wire  [4:0] Tpl_4357 ;
wire  [4:0] Tpl_4358 ;
wire  [4:0] Tpl_4359 ;
wire  [4:0] Tpl_4360 ;
wire  [4:0] Tpl_4361 ;
wire  [4:0] Tpl_4362 ;
wire  [4:0] Tpl_4363 ;
wire  [4:0] Tpl_4364 ;
wire  [4:0] Tpl_4365 ;
wire  [4:0] Tpl_4366 ;
wire  [4:0] Tpl_4367 ;
wire  [4:0] Tpl_4368 ;
wire  [4:0] Tpl_4369 ;
wire  [4:0] Tpl_4370 ;
wire  [4:0] Tpl_4371 ;
wire  [4:0] Tpl_4372 ;
wire  [4:0] Tpl_4373 ;
wire  [4:0] Tpl_4374 ;
wire  [4:0] Tpl_4375 ;
wire  [4:0] Tpl_4376 ;
wire  [4:0] Tpl_4377 ;
wire  [4:0] Tpl_4378 ;
wire  [4:0] Tpl_4379 ;
wire  [4:0] Tpl_4380 ;
wire  [4:0] Tpl_4381 ;
wire  [4:0] Tpl_4382 ;
wire  [4:0] Tpl_4383 ;
wire  [4:0] Tpl_4384 ;
wire  [4:0] Tpl_4385 ;
wire  [4:0] Tpl_4386 ;
wire  [4:0] Tpl_4387 ;
wire  [4:0] Tpl_4388 ;
wire  [4:0] Tpl_4389 ;
wire   Tpl_4390 ;
wire   Tpl_4391 ;
wire   Tpl_4392 ;
wire  [7:0] Tpl_4393 ;
wire  [5:0] Tpl_4394 ;
wire  [4:0] Tpl_4395 ;
wire   Tpl_4396 ;
wire   Tpl_4397 ;
wire   Tpl_4398 ;
wire  [7:0] Tpl_4399 ;
wire  [5:0] Tpl_4400 ;
wire  [4:0] Tpl_4401 ;
wire   Tpl_4402 ;
wire   Tpl_4403 ;
wire   Tpl_4404 ;
wire  [7:0] Tpl_4405 ;
wire  [4:0] Tpl_4406 ;
wire   Tpl_4407 ;
wire   Tpl_4408 ;
wire   Tpl_4409 ;
wire  [7:0] Tpl_4410 ;
wire  [4:0] Tpl_4411 ;
wire   Tpl_4412 ;
wire   Tpl_4413 ;
wire   Tpl_4414 ;
wire  [7:0] Tpl_4415 ;
wire  [4:0] Tpl_4416 ;
wire   Tpl_4417 ;
wire   Tpl_4418 ;
wire   Tpl_4419 ;
wire  [7:0] Tpl_4420 ;
wire   Tpl_4421 ;
wire  [5:0] Tpl_4422 ;
wire   Tpl_4423 ;
wire  [5:0] Tpl_4424 ;
wire  [2:0] Tpl_4425 ;
wire   Tpl_4426 ;
wire  [2:0] Tpl_4427 ;
wire   Tpl_4428 ;
wire  [1:0] Tpl_4429 ;
wire  [29:0] Tpl_4430 ;
wire  [2:0] Tpl_4431 ;
wire   Tpl_4432 ;
wire   Tpl_4433 ;
wire   Tpl_4434 ;
wire  [2:0] Tpl_4435 ;
wire  [7:0] Tpl_4436 ;
wire   Tpl_4437 ;
wire   Tpl_4438 ;
wire  [2:0] Tpl_4439 ;
wire   Tpl_4440 ;
wire   Tpl_4441 ;
wire   Tpl_4442 ;
wire  [2:0] Tpl_4443 ;
wire  [7:0] Tpl_4444 ;
wire   Tpl_4445 ;
wire   Tpl_4446 ;
wire  [2:0] Tpl_4447 ;
wire   Tpl_4448 ;
wire   Tpl_4449 ;
wire   Tpl_4450 ;
wire  [2:0] Tpl_4451 ;
wire  [7:0] Tpl_4452 ;
wire   Tpl_4453 ;
wire   Tpl_4454 ;
wire  [2:0] Tpl_4455 ;
wire   Tpl_4456 ;
wire   Tpl_4457 ;
wire   Tpl_4458 ;
wire  [2:0] Tpl_4459 ;
wire  [7:0] Tpl_4460 ;
wire   Tpl_4461 ;
wire   Tpl_4462 ;
wire   Tpl_4463 ;
reg   Tpl_4464 ;
wire  [5:0] Tpl_4465 ;
reg  [5:0] Tpl_4466 ;
wire   Tpl_4467 ;
reg   Tpl_4468 ;
wire  [5:0] Tpl_4469 ;
reg  [5:0] Tpl_4470 ;
wire  [6:0] Tpl_4471 ;
reg  [6:0] Tpl_4472 ;
wire  [6:0] Tpl_4473 ;
reg  [6:0] Tpl_4474 ;
wire  [6:0] Tpl_4475 ;
reg  [6:0] Tpl_4476 ;
wire  [6:0] Tpl_4477 ;
reg  [6:0] Tpl_4478 ;
wire  [6:0] Tpl_4479 ;
reg  [6:0] Tpl_4480 ;
wire  [6:0] Tpl_4481 ;
reg  [6:0] Tpl_4482 ;
wire  [6:0] Tpl_4483 ;
reg  [6:0] Tpl_4484 ;
wire  [6:0] Tpl_4485 ;
reg  [6:0] Tpl_4486 ;
wire  [6:0] Tpl_4487 ;
reg  [6:0] Tpl_4488 ;
wire  [6:0] Tpl_4489 ;
reg  [6:0] Tpl_4490 ;
wire  [6:0] Tpl_4491 ;
reg  [6:0] Tpl_4492 ;
wire  [6:0] Tpl_4493 ;
reg  [6:0] Tpl_4494 ;
wire  [6:0] Tpl_4495 ;
reg  [6:0] Tpl_4496 ;
wire  [6:0] Tpl_4497 ;
reg  [6:0] Tpl_4498 ;
wire  [6:0] Tpl_4499 ;
reg  [6:0] Tpl_4500 ;
wire  [6:0] Tpl_4501 ;
reg  [6:0] Tpl_4502 ;
wire  [6:0] Tpl_4503 ;
reg  [6:0] Tpl_4504 ;
wire  [6:0] Tpl_4505 ;
reg  [6:0] Tpl_4506 ;
wire  [6:0] Tpl_4507 ;
reg  [6:0] Tpl_4508 ;
wire  [6:0] Tpl_4509 ;
reg  [6:0] Tpl_4510 ;
wire  [6:0] Tpl_4511 ;
reg  [6:0] Tpl_4512 ;
wire  [6:0] Tpl_4513 ;
reg  [6:0] Tpl_4514 ;
wire  [6:0] Tpl_4515 ;
reg  [6:0] Tpl_4516 ;
wire  [6:0] Tpl_4517 ;
reg  [6:0] Tpl_4518 ;
wire  [6:0] Tpl_4519 ;
reg  [6:0] Tpl_4520 ;
wire  [6:0] Tpl_4521 ;
reg  [6:0] Tpl_4522 ;
wire  [6:0] Tpl_4523 ;
reg  [6:0] Tpl_4524 ;
wire  [6:0] Tpl_4525 ;
reg  [6:0] Tpl_4526 ;
wire  [6:0] Tpl_4527 ;
reg  [6:0] Tpl_4528 ;
wire  [6:0] Tpl_4529 ;
reg  [6:0] Tpl_4530 ;
wire  [6:0] Tpl_4531 ;
reg  [6:0] Tpl_4532 ;
wire  [6:0] Tpl_4533 ;
reg  [6:0] Tpl_4534 ;
wire  [6:0] Tpl_4535 ;
reg  [6:0] Tpl_4536 ;
wire  [6:0] Tpl_4537 ;
reg  [6:0] Tpl_4538 ;
wire  [6:0] Tpl_4539 ;
reg  [6:0] Tpl_4540 ;
wire  [6:0] Tpl_4541 ;
reg  [6:0] Tpl_4542 ;
wire  [6:0] Tpl_4543 ;
reg  [6:0] Tpl_4544 ;
wire  [6:0] Tpl_4545 ;
reg  [6:0] Tpl_4546 ;
wire  [6:0] Tpl_4547 ;
reg  [6:0] Tpl_4548 ;
wire  [6:0] Tpl_4549 ;
reg  [6:0] Tpl_4550 ;
wire  [6:0] Tpl_4551 ;
wire  [6:0] Tpl_4552 ;
wire  [6:0] Tpl_4553 ;
wire  [6:0] Tpl_4554 ;
wire  [6:0] Tpl_4555 ;
wire  [6:0] Tpl_4556 ;
wire  [6:0] Tpl_4557 ;
wire  [6:0] Tpl_4558 ;
wire  [6:0] Tpl_4559 ;
wire  [6:0] Tpl_4560 ;
wire  [6:0] Tpl_4561 ;
wire  [6:0] Tpl_4562 ;
wire  [5:0] Tpl_4563 ;
reg  [5:0] Tpl_4564 ;
wire  [5:0] Tpl_4565 ;
reg  [5:0] Tpl_4566 ;
wire  [5:0] Tpl_4567 ;
reg  [5:0] Tpl_4568 ;
wire  [5:0] Tpl_4569 ;
reg  [5:0] Tpl_4570 ;
wire  [7:0] Tpl_4571 ;
reg  [7:0] Tpl_4572 ;
wire  [7:0] Tpl_4573 ;
reg  [7:0] Tpl_4574 ;
wire  [7:0] Tpl_4575 ;
reg  [7:0] Tpl_4576 ;
wire  [7:0] Tpl_4577 ;
reg  [7:0] Tpl_4578 ;
wire  [7:0] Tpl_4579 ;
reg  [7:0] Tpl_4580 ;
wire  [7:0] Tpl_4581 ;
reg  [7:0] Tpl_4582 ;
wire  [7:0] Tpl_4583 ;
reg  [7:0] Tpl_4584 ;
wire  [7:0] Tpl_4585 ;
reg  [7:0] Tpl_4586 ;
wire  [7:0] Tpl_4587 ;
reg  [7:0] Tpl_4588 ;
wire  [7:0] Tpl_4589 ;
reg  [7:0] Tpl_4590 ;
wire  [7:0] Tpl_4591 ;
reg  [7:0] Tpl_4592 ;
wire  [7:0] Tpl_4593 ;
reg  [7:0] Tpl_4594 ;
wire  [7:0] Tpl_4595 ;
reg  [7:0] Tpl_4596 ;
wire  [7:0] Tpl_4597 ;
reg  [7:0] Tpl_4598 ;
wire  [7:0] Tpl_4599 ;
reg  [7:0] Tpl_4600 ;
wire  [7:0] Tpl_4601 ;
reg  [7:0] Tpl_4602 ;
wire  [7:0] Tpl_4603 ;
reg  [7:0] Tpl_4604 ;
wire  [7:0] Tpl_4605 ;
reg  [7:0] Tpl_4606 ;
wire  [7:0] Tpl_4607 ;
reg  [7:0] Tpl_4608 ;
wire  [7:0] Tpl_4609 ;
reg  [7:0] Tpl_4610 ;
wire  [7:0] Tpl_4611 ;
reg  [7:0] Tpl_4612 ;
wire  [7:0] Tpl_4613 ;
reg  [7:0] Tpl_4614 ;
wire  [7:0] Tpl_4615 ;
reg  [7:0] Tpl_4616 ;
wire  [7:0] Tpl_4617 ;
reg  [7:0] Tpl_4618 ;
wire  [7:0] Tpl_4619 ;
reg  [7:0] Tpl_4620 ;
wire  [7:0] Tpl_4621 ;
reg  [7:0] Tpl_4622 ;
wire  [7:0] Tpl_4623 ;
reg  [7:0] Tpl_4624 ;
wire  [7:0] Tpl_4625 ;
reg  [7:0] Tpl_4626 ;
wire  [7:0] Tpl_4627 ;
reg  [7:0] Tpl_4628 ;
wire  [7:0] Tpl_4629 ;
reg  [7:0] Tpl_4630 ;
wire  [7:0] Tpl_4631 ;
reg  [7:0] Tpl_4632 ;
wire  [7:0] Tpl_4633 ;
reg  [7:0] Tpl_4634 ;
wire  [7:0] Tpl_4635 ;
reg  [7:0] Tpl_4636 ;
wire  [7:0] Tpl_4637 ;
reg  [7:0] Tpl_4638 ;
wire  [7:0] Tpl_4639 ;
reg  [7:0] Tpl_4640 ;
wire  [7:0] Tpl_4641 ;
reg  [7:0] Tpl_4642 ;
wire  [7:0] Tpl_4643 ;
reg  [7:0] Tpl_4644 ;
wire  [7:0] Tpl_4645 ;
reg  [7:0] Tpl_4646 ;
wire  [7:0] Tpl_4647 ;
reg  [7:0] Tpl_4648 ;
wire  [7:0] Tpl_4649 ;
reg  [7:0] Tpl_4650 ;
wire  [7:0] Tpl_4651 ;
reg  [7:0] Tpl_4652 ;
wire  [7:0] Tpl_4653 ;
reg  [7:0] Tpl_4654 ;
wire  [7:0] Tpl_4655 ;
reg  [7:0] Tpl_4656 ;
wire  [7:0] Tpl_4657 ;
reg  [7:0] Tpl_4658 ;
wire  [7:0] Tpl_4659 ;
reg  [7:0] Tpl_4660 ;
wire  [7:0] Tpl_4661 ;
reg  [7:0] Tpl_4662 ;
wire  [7:0] Tpl_4663 ;
reg  [7:0] Tpl_4664 ;
wire  [7:0] Tpl_4665 ;
reg  [7:0] Tpl_4666 ;
wire  [7:0] Tpl_4667 ;
reg  [7:0] Tpl_4668 ;
wire  [7:0] Tpl_4669 ;
reg  [7:0] Tpl_4670 ;
wire  [7:0] Tpl_4671 ;
reg  [7:0] Tpl_4672 ;
wire  [7:0] Tpl_4673 ;
reg  [7:0] Tpl_4674 ;
wire  [7:0] Tpl_4675 ;
reg  [7:0] Tpl_4676 ;
wire  [7:0] Tpl_4677 ;
reg  [7:0] Tpl_4678 ;
wire  [7:0] Tpl_4679 ;
reg  [7:0] Tpl_4680 ;
wire  [7:0] Tpl_4681 ;
reg  [7:0] Tpl_4682 ;
wire  [7:0] Tpl_4683 ;
reg  [7:0] Tpl_4684 ;
wire  [7:0] Tpl_4685 ;
reg  [7:0] Tpl_4686 ;
wire  [7:0] Tpl_4687 ;
reg  [7:0] Tpl_4688 ;
wire  [7:0] Tpl_4689 ;
reg  [7:0] Tpl_4690 ;
wire  [7:0] Tpl_4691 ;
reg  [7:0] Tpl_4692 ;
wire  [7:0] Tpl_4693 ;
reg  [7:0] Tpl_4694 ;
wire  [7:0] Tpl_4695 ;
reg  [7:0] Tpl_4696 ;
wire  [7:0] Tpl_4697 ;
reg  [7:0] Tpl_4698 ;
wire  [7:0] Tpl_4699 ;
reg  [7:0] Tpl_4700 ;
wire  [7:0] Tpl_4701 ;
reg  [7:0] Tpl_4702 ;
wire  [7:0] Tpl_4703 ;
reg  [7:0] Tpl_4704 ;
wire  [7:0] Tpl_4705 ;
reg  [7:0] Tpl_4706 ;
wire  [7:0] Tpl_4707 ;
reg  [7:0] Tpl_4708 ;
wire  [7:0] Tpl_4709 ;
reg  [7:0] Tpl_4710 ;
wire  [7:0] Tpl_4711 ;
reg  [7:0] Tpl_4712 ;
wire  [7:0] Tpl_4713 ;
reg  [7:0] Tpl_4714 ;
wire  [7:0] Tpl_4715 ;
reg  [7:0] Tpl_4716 ;
wire  [7:0] Tpl_4717 ;
reg  [7:0] Tpl_4718 ;
wire  [7:0] Tpl_4719 ;
reg  [7:0] Tpl_4720 ;
wire  [7:0] Tpl_4721 ;
reg  [7:0] Tpl_4722 ;
wire  [5:0] Tpl_4723 ;
reg  [5:0] Tpl_4724 ;
wire  [5:0] Tpl_4725 ;
reg  [5:0] Tpl_4726 ;
wire  [5:0] Tpl_4727 ;
reg  [5:0] Tpl_4728 ;
wire  [5:0] Tpl_4729 ;
reg  [5:0] Tpl_4730 ;
wire   Tpl_4731 ;
reg   Tpl_4732 ;
wire   Tpl_4733 ;
reg   Tpl_4734 ;
wire  [5:0] Tpl_4735 ;
reg  [5:0] Tpl_4736 ;
wire   Tpl_4737 ;
reg   Tpl_4738 ;
wire  [5:0] Tpl_4739 ;
reg  [5:0] Tpl_4740 ;
wire  [6:0] Tpl_4741 ;
reg  [6:0] Tpl_4742 ;
wire  [6:0] Tpl_4743 ;
reg  [6:0] Tpl_4744 ;
wire  [6:0] Tpl_4745 ;
reg  [6:0] Tpl_4746 ;
wire  [6:0] Tpl_4747 ;
reg  [6:0] Tpl_4748 ;
wire  [6:0] Tpl_4749 ;
reg  [6:0] Tpl_4750 ;
wire  [6:0] Tpl_4751 ;
reg  [6:0] Tpl_4752 ;
wire  [6:0] Tpl_4753 ;
reg  [6:0] Tpl_4754 ;
wire  [6:0] Tpl_4755 ;
reg  [6:0] Tpl_4756 ;
wire  [6:0] Tpl_4757 ;
reg  [6:0] Tpl_4758 ;
wire  [6:0] Tpl_4759 ;
reg  [6:0] Tpl_4760 ;
wire  [6:0] Tpl_4761 ;
reg  [6:0] Tpl_4762 ;
wire  [6:0] Tpl_4763 ;
reg  [6:0] Tpl_4764 ;
wire  [6:0] Tpl_4765 ;
reg  [6:0] Tpl_4766 ;
wire  [6:0] Tpl_4767 ;
reg  [6:0] Tpl_4768 ;
wire  [6:0] Tpl_4769 ;
reg  [6:0] Tpl_4770 ;
wire  [6:0] Tpl_4771 ;
reg  [6:0] Tpl_4772 ;
wire  [6:0] Tpl_4773 ;
reg  [6:0] Tpl_4774 ;
wire  [6:0] Tpl_4775 ;
reg  [6:0] Tpl_4776 ;
wire  [6:0] Tpl_4777 ;
reg  [6:0] Tpl_4778 ;
wire  [6:0] Tpl_4779 ;
reg  [6:0] Tpl_4780 ;
wire  [6:0] Tpl_4781 ;
reg  [6:0] Tpl_4782 ;
wire  [6:0] Tpl_4783 ;
reg  [6:0] Tpl_4784 ;
wire  [6:0] Tpl_4785 ;
reg  [6:0] Tpl_4786 ;
wire  [6:0] Tpl_4787 ;
reg  [6:0] Tpl_4788 ;
wire  [6:0] Tpl_4789 ;
reg  [6:0] Tpl_4790 ;
wire  [6:0] Tpl_4791 ;
reg  [6:0] Tpl_4792 ;
wire  [6:0] Tpl_4793 ;
reg  [6:0] Tpl_4794 ;
wire  [6:0] Tpl_4795 ;
reg  [6:0] Tpl_4796 ;
wire  [6:0] Tpl_4797 ;
reg  [6:0] Tpl_4798 ;
wire  [6:0] Tpl_4799 ;
reg  [6:0] Tpl_4800 ;
wire  [6:0] Tpl_4801 ;
reg  [6:0] Tpl_4802 ;
wire  [6:0] Tpl_4803 ;
reg  [6:0] Tpl_4804 ;
wire  [6:0] Tpl_4805 ;
reg  [6:0] Tpl_4806 ;
wire  [6:0] Tpl_4807 ;
reg  [6:0] Tpl_4808 ;
wire  [6:0] Tpl_4809 ;
reg  [6:0] Tpl_4810 ;
wire  [6:0] Tpl_4811 ;
reg  [6:0] Tpl_4812 ;
wire  [6:0] Tpl_4813 ;
reg  [6:0] Tpl_4814 ;
wire  [6:0] Tpl_4815 ;
reg  [6:0] Tpl_4816 ;
wire  [6:0] Tpl_4817 ;
reg  [6:0] Tpl_4818 ;
wire  [6:0] Tpl_4819 ;
reg  [6:0] Tpl_4820 ;
wire  [6:0] Tpl_4821 ;
wire  [6:0] Tpl_4822 ;
wire  [6:0] Tpl_4823 ;
wire  [6:0] Tpl_4824 ;
wire  [6:0] Tpl_4825 ;
wire  [6:0] Tpl_4826 ;
wire  [6:0] Tpl_4827 ;
wire  [6:0] Tpl_4828 ;
wire  [6:0] Tpl_4829 ;
wire  [6:0] Tpl_4830 ;
wire  [6:0] Tpl_4831 ;
wire  [6:0] Tpl_4832 ;
wire  [5:0] Tpl_4833 ;
reg  [5:0] Tpl_4834 ;
wire  [5:0] Tpl_4835 ;
reg  [5:0] Tpl_4836 ;
wire  [5:0] Tpl_4837 ;
reg  [5:0] Tpl_4838 ;
wire  [5:0] Tpl_4839 ;
reg  [5:0] Tpl_4840 ;
wire  [7:0] Tpl_4841 ;
reg  [7:0] Tpl_4842 ;
wire  [7:0] Tpl_4843 ;
reg  [7:0] Tpl_4844 ;
wire  [7:0] Tpl_4845 ;
reg  [7:0] Tpl_4846 ;
wire  [7:0] Tpl_4847 ;
reg  [7:0] Tpl_4848 ;
wire  [7:0] Tpl_4849 ;
reg  [7:0] Tpl_4850 ;
wire  [7:0] Tpl_4851 ;
reg  [7:0] Tpl_4852 ;
wire  [7:0] Tpl_4853 ;
reg  [7:0] Tpl_4854 ;
wire  [7:0] Tpl_4855 ;
reg  [7:0] Tpl_4856 ;
wire  [7:0] Tpl_4857 ;
reg  [7:0] Tpl_4858 ;
wire  [7:0] Tpl_4859 ;
reg  [7:0] Tpl_4860 ;
wire  [7:0] Tpl_4861 ;
reg  [7:0] Tpl_4862 ;
wire  [7:0] Tpl_4863 ;
reg  [7:0] Tpl_4864 ;
wire  [7:0] Tpl_4865 ;
reg  [7:0] Tpl_4866 ;
wire  [7:0] Tpl_4867 ;
reg  [7:0] Tpl_4868 ;
wire  [7:0] Tpl_4869 ;
reg  [7:0] Tpl_4870 ;
wire  [7:0] Tpl_4871 ;
reg  [7:0] Tpl_4872 ;
wire  [7:0] Tpl_4873 ;
reg  [7:0] Tpl_4874 ;
wire  [7:0] Tpl_4875 ;
reg  [7:0] Tpl_4876 ;
wire  [7:0] Tpl_4877 ;
reg  [7:0] Tpl_4878 ;
wire  [7:0] Tpl_4879 ;
reg  [7:0] Tpl_4880 ;
wire  [7:0] Tpl_4881 ;
reg  [7:0] Tpl_4882 ;
wire  [7:0] Tpl_4883 ;
reg  [7:0] Tpl_4884 ;
wire  [7:0] Tpl_4885 ;
reg  [7:0] Tpl_4886 ;
wire  [7:0] Tpl_4887 ;
reg  [7:0] Tpl_4888 ;
wire  [7:0] Tpl_4889 ;
reg  [7:0] Tpl_4890 ;
wire  [7:0] Tpl_4891 ;
reg  [7:0] Tpl_4892 ;
wire  [7:0] Tpl_4893 ;
reg  [7:0] Tpl_4894 ;
wire  [7:0] Tpl_4895 ;
reg  [7:0] Tpl_4896 ;
wire  [7:0] Tpl_4897 ;
reg  [7:0] Tpl_4898 ;
wire  [7:0] Tpl_4899 ;
reg  [7:0] Tpl_4900 ;
wire  [7:0] Tpl_4901 ;
reg  [7:0] Tpl_4902 ;
wire  [7:0] Tpl_4903 ;
reg  [7:0] Tpl_4904 ;
wire  [7:0] Tpl_4905 ;
reg  [7:0] Tpl_4906 ;
wire  [7:0] Tpl_4907 ;
reg  [7:0] Tpl_4908 ;
wire  [7:0] Tpl_4909 ;
reg  [7:0] Tpl_4910 ;
wire  [7:0] Tpl_4911 ;
reg  [7:0] Tpl_4912 ;
wire  [7:0] Tpl_4913 ;
reg  [7:0] Tpl_4914 ;
wire  [7:0] Tpl_4915 ;
reg  [7:0] Tpl_4916 ;
wire  [7:0] Tpl_4917 ;
reg  [7:0] Tpl_4918 ;
wire  [7:0] Tpl_4919 ;
reg  [7:0] Tpl_4920 ;
wire  [7:0] Tpl_4921 ;
reg  [7:0] Tpl_4922 ;
wire  [7:0] Tpl_4923 ;
reg  [7:0] Tpl_4924 ;
wire  [7:0] Tpl_4925 ;
reg  [7:0] Tpl_4926 ;
wire  [7:0] Tpl_4927 ;
reg  [7:0] Tpl_4928 ;
wire  [7:0] Tpl_4929 ;
reg  [7:0] Tpl_4930 ;
wire  [7:0] Tpl_4931 ;
reg  [7:0] Tpl_4932 ;
wire  [7:0] Tpl_4933 ;
reg  [7:0] Tpl_4934 ;
wire  [7:0] Tpl_4935 ;
reg  [7:0] Tpl_4936 ;
wire  [7:0] Tpl_4937 ;
reg  [7:0] Tpl_4938 ;
wire  [7:0] Tpl_4939 ;
reg  [7:0] Tpl_4940 ;
wire  [7:0] Tpl_4941 ;
reg  [7:0] Tpl_4942 ;
wire  [7:0] Tpl_4943 ;
reg  [7:0] Tpl_4944 ;
wire  [7:0] Tpl_4945 ;
reg  [7:0] Tpl_4946 ;
wire  [7:0] Tpl_4947 ;
reg  [7:0] Tpl_4948 ;
wire  [7:0] Tpl_4949 ;
reg  [7:0] Tpl_4950 ;
wire  [7:0] Tpl_4951 ;
reg  [7:0] Tpl_4952 ;
wire  [7:0] Tpl_4953 ;
reg  [7:0] Tpl_4954 ;
wire  [7:0] Tpl_4955 ;
reg  [7:0] Tpl_4956 ;
wire  [7:0] Tpl_4957 ;
reg  [7:0] Tpl_4958 ;
wire  [7:0] Tpl_4959 ;
reg  [7:0] Tpl_4960 ;
wire  [7:0] Tpl_4961 ;
reg  [7:0] Tpl_4962 ;
wire  [7:0] Tpl_4963 ;
reg  [7:0] Tpl_4964 ;
wire  [7:0] Tpl_4965 ;
reg  [7:0] Tpl_4966 ;
wire  [7:0] Tpl_4967 ;
reg  [7:0] Tpl_4968 ;
wire  [7:0] Tpl_4969 ;
reg  [7:0] Tpl_4970 ;
wire  [7:0] Tpl_4971 ;
reg  [7:0] Tpl_4972 ;
wire  [7:0] Tpl_4973 ;
reg  [7:0] Tpl_4974 ;
wire  [7:0] Tpl_4975 ;
reg  [7:0] Tpl_4976 ;
wire  [7:0] Tpl_4977 ;
reg  [7:0] Tpl_4978 ;
wire  [7:0] Tpl_4979 ;
reg  [7:0] Tpl_4980 ;
wire  [7:0] Tpl_4981 ;
reg  [7:0] Tpl_4982 ;
wire  [7:0] Tpl_4983 ;
reg  [7:0] Tpl_4984 ;
wire  [7:0] Tpl_4985 ;
reg  [7:0] Tpl_4986 ;
wire  [7:0] Tpl_4987 ;
reg  [7:0] Tpl_4988 ;
wire  [7:0] Tpl_4989 ;
reg  [7:0] Tpl_4990 ;
wire  [7:0] Tpl_4991 ;
reg  [7:0] Tpl_4992 ;
wire  [3:0] Tpl_4993 ;
reg  [3:0] Tpl_4994 ;
wire  [3:0] Tpl_4995 ;
reg  [3:0] Tpl_4996 ;
wire  [3:0] Tpl_4997 ;
reg  [3:0] Tpl_4998 ;
wire  [3:0] Tpl_4999 ;
reg  [3:0] Tpl_5000 ;
wire  [15:0] Tpl_5001 ;
wire  [6:0] Tpl_5002 ;
wire  [6:0] Tpl_5003 ;
wire  [6:0] Tpl_5004 ;
wire  [6:0] Tpl_5005 ;
wire   Tpl_5006 ;
reg   Tpl_5007 ;
wire  [5:0] Tpl_5008 ;
wire  [4:0] Tpl_5009 ;
wire  [4:0] Tpl_5010 ;
wire  [6:0] Tpl_5011 ;
wire  [7:0] Tpl_5012 ;
wire  [5:0] Tpl_5013 ;
wire  [7:0] Tpl_5014 ;
wire  [7:0] Tpl_5015 ;
wire  [7:0] Tpl_5016 ;
wire  [5:0] Tpl_5017 ;
wire  [5:0] Tpl_5018 ;
wire  [7:0] Tpl_5019 ;
wire  [7:0] Tpl_5020 ;
wire  [3:0] Tpl_5021 ;
wire  [4:0] Tpl_5022 ;
wire  [9:0] Tpl_5023 ;
wire  [7:0] Tpl_5024 ;
wire  [5:0] Tpl_5025 ;
wire  [27:0] Tpl_5026 ;
wire  [19:0] Tpl_5027 ;
wire  [10:0] Tpl_5028 ;
wire  [7:0] Tpl_5029 ;
wire  [7:0] Tpl_5030 ;
wire  [5:0] Tpl_5031 ;
wire  [6:0] Tpl_5032 ;
wire  [4:0] Tpl_5033 ;
wire  [9:0] Tpl_5034 ;
wire  [7:0] Tpl_5035 ;
wire  [7:0] Tpl_5036 ;
wire  [10:0] Tpl_5037 ;
wire  [13:0] Tpl_5038 ;
wire  [1:0] Tpl_5039 ;
wire  [19:0] Tpl_5040 ;
wire  [7:0] Tpl_5041 ;
wire  [19:0] Tpl_5042 ;
wire  [7:0] Tpl_5043 ;
wire  [7:0] Tpl_5044 ;
wire  [7:0] Tpl_5045 ;
wire  [7:0] Tpl_5046 ;
wire  [7:0] Tpl_5047 ;
wire  [9:0] Tpl_5048 ;
wire  [5:0] Tpl_5049 ;
wire  [19:0] Tpl_5050 ;
wire  [4:0] Tpl_5051 ;
wire  [6:0] Tpl_5052 ;
wire  [5:0] Tpl_5053 ;
wire  [7:0] Tpl_5054 ;
wire  [4:0] Tpl_5055 ;
wire  [9:0] Tpl_5056 ;
wire  [5:0] Tpl_5057 ;
wire  [4:0] Tpl_5058 ;
wire  [5:0] Tpl_5059 ;
wire  [13:0] Tpl_5060 ;
wire  [2:0] Tpl_5061 ;
wire  [5:0] Tpl_5062 ;
wire  [15:0] Tpl_5063 ;
wire  [6:0] Tpl_5064 ;
wire  [9:0] Tpl_5065 ;
wire  [9:0] Tpl_5066 ;
wire  [9:0] Tpl_5067 ;
wire  [9:0] Tpl_5068 ;
wire  [9:0] Tpl_5069 ;
wire  [9:0] Tpl_5070 ;
wire  [6:0] Tpl_5071 ;
wire  [6:0] Tpl_5072 ;
wire  [6:0] Tpl_5073 ;
wire  [10:0] Tpl_5074 ;
wire  [7:0] Tpl_5075 ;
wire  [7:0] Tpl_5076 ;
wire  [7:0] Tpl_5077 ;
wire  [11:0] Tpl_5078 ;
wire  [9:0] Tpl_5079 ;
wire  [10:0] Tpl_5080 ;
wire  [4:0] Tpl_5081 ;
wire  [4:0] Tpl_5082 ;
wire  [5:0] Tpl_5083 ;
wire  [4:0] Tpl_5084 ;
wire  [3:0] Tpl_5085 ;
wire  [7:0] Tpl_5086 ;
wire  [7:0] Tpl_5087 ;
wire  [11:0] Tpl_5088 ;
wire  [7:0] Tpl_5089 ;
wire  [7:0] Tpl_5090 ;
wire  [7:0] Tpl_5091 ;
wire  [7:0] Tpl_5092 ;
wire  [7:0] Tpl_5093 ;
wire  [7:0] Tpl_5094 ;
wire  [4:0] Tpl_5095 ;
wire  [4:0] Tpl_5096 ;
wire  [6:0] Tpl_5097 ;
wire  [1:0] Tpl_5098 ;
wire  [4:0] Tpl_5099 ;
wire  [9:0] Tpl_5100 ;
wire  [3:0] Tpl_5101 ;
wire  [5:0] Tpl_5102 ;
wire  [5:0] Tpl_5103 ;
wire  [27:0] Tpl_5104 ;
wire  [3:0] Tpl_5105 ;
wire  [7:0] Tpl_5106 ;
wire  [17:0] Tpl_5107 ;
wire  [2:0] Tpl_5108 ;
wire  [6:0] Tpl_5109 ;
wire  [9:0] Tpl_5110 ;
wire  [13:0] Tpl_5111 ;
wire  [8:0] Tpl_5112 ;
wire  [7:0] Tpl_5113 ;
wire  [7:0] Tpl_5114 ;
wire  [5:0] Tpl_5115 ;
wire  [7:0] Tpl_5116 ;
wire  [3:0] Tpl_5117 ;
wire  [3:0] Tpl_5118 ;
wire  [13:0] Tpl_5119 ;
wire  [10:0] Tpl_5120 ;
wire  [7:0] Tpl_5121 ;
wire  [3:0] Tpl_5122 ;
wire   Tpl_5123 ;
wire   Tpl_5124 ;
wire  [3:0] Tpl_5125 ;
wire  [3:0] Tpl_5126 ;
wire  [2:0] Tpl_5127 ;
wire  [2:0] Tpl_5128 ;
wire  [3:0] Tpl_5129 ;
wire  [3:0] Tpl_5130 ;
wire  [3:0] Tpl_5131 ;
wire   Tpl_5132 ;
wire   Tpl_5133 ;
wire   Tpl_5134 ;
wire  [3:0] Tpl_5135 ;
wire  [3:0] Tpl_5136 ;
wire  [2:0] Tpl_5137 ;
wire  [2:0] Tpl_5138 ;
wire  [3:0] Tpl_5139 ;
wire  [3:0] Tpl_5140 ;
wire  [3:0] Tpl_5141 ;
wire   Tpl_5142 ;
wire  [16:0] Tpl_5143 ;
wire  [10:0] Tpl_5144 ;
wire  [16:0] Tpl_5145 ;
wire  [10:0] Tpl_5146 ;
wire  [16:0] Tpl_5147 ;
wire  [10:0] Tpl_5148 ;
wire  [16:0] Tpl_5149 ;
wire  [10:0] Tpl_5150 ;
wire  [31:0] Tpl_5151 ;
wire  [31:0] Tpl_5152 ;
wire  [31:0] Tpl_5153 ;
wire  [31:0] Tpl_5154 ;
wire  [31:0] Tpl_5155 ;
wire  [31:0] Tpl_5156 ;
wire  [31:0] Tpl_5157 ;
wire  [31:0] Tpl_5158 ;
wire  [31:0] Tpl_5159 ;
wire  [31:0] Tpl_5160 ;
wire  [31:0] Tpl_5161 ;
wire  [31:0] Tpl_5162 ;
wire  [31:0] Tpl_5163 ;
wire  [31:0] Tpl_5164 ;
wire  [31:0] Tpl_5165 ;
wire  [31:0] Tpl_5166 ;
wire  [31:0] Tpl_5167 ;
wire  [31:0] Tpl_5168 ;
wire  [31:0] Tpl_5169 ;
wire  [31:0] Tpl_5170 ;
wire  [31:0] Tpl_5171 ;
wire  [31:0] Tpl_5172 ;
wire  [31:0] Tpl_5173 ;
wire  [31:0] Tpl_5174 ;
wire  [31:0] Tpl_5175 ;
wire  [31:0] Tpl_5176 ;
wire  [31:0] Tpl_5177 ;
wire  [31:0] Tpl_5178 ;
wire  [31:0] Tpl_5179 ;
wire  [31:0] Tpl_5180 ;
wire  [31:0] Tpl_5181 ;
wire  [31:0] Tpl_5182 ;
reg   Tpl_5183 ;
reg   Tpl_5184 ;
reg  [15:0] Tpl_5185 ;
reg   Tpl_5186 ;
reg   Tpl_5187 ;
reg   Tpl_5188 ;
reg   Tpl_5189 ;
reg   Tpl_5190 ;
reg   Tpl_5191 ;
reg  [15:0] Tpl_5192 ;
reg   Tpl_5193 ;
reg   Tpl_5194 ;
reg   Tpl_5195 ;
reg   Tpl_5196 ;
reg   Tpl_5197 ;
reg   Tpl_5198 ;
reg   Tpl_5199 ;
reg   Tpl_5200 ;
reg   Tpl_5201 ;
reg   Tpl_5202 ;
reg  [3:0] Tpl_5203 ;
reg  [16:0] Tpl_5204 ;
reg   Tpl_5205 ;
reg   Tpl_5206 ;
reg   Tpl_5207 ;
reg   Tpl_5208 ;
reg  [3:0] Tpl_5209 ;
reg  [16:0] Tpl_5210 ;
reg  [3:0] Tpl_5211 ;
reg  [1:0] Tpl_5212 ;
reg  [3:0] Tpl_5213 ;
reg  [3:0] Tpl_5214 ;
reg  [3:0] Tpl_5215 ;
reg  [3:0] Tpl_5216 ;
reg  [5:0] Tpl_5217 ;
reg  [3:0] Tpl_5218 ;
reg  [3:0] Tpl_5219 ;
reg  [3:0] Tpl_5220 ;
reg  [3:0] Tpl_5221 ;
reg  [3:0] Tpl_5222 ;
reg  [31:0] Tpl_5223 ;
reg  [31:0] Tpl_5224 ;
reg  [3:0] Tpl_5225 ;
reg  [1:0] Tpl_5226 ;
reg  [3:0] Tpl_5227 ;
reg  [3:0] Tpl_5228 ;
reg  [3:0] Tpl_5229 ;
reg  [3:0] Tpl_5230 ;
reg  [31:0] Tpl_5231 ;
reg  [31:0] Tpl_5232 ;
reg   Tpl_5233 ;
reg  [7:0] Tpl_5234 ;
reg   Tpl_5235 ;
reg  [7:0] Tpl_5236 ;
reg   Tpl_5237 ;
reg  [7:0] Tpl_5238 ;
reg  [1:0] Tpl_5239 ;
reg   Tpl_5240 ;
reg   Tpl_5241 ;
reg  [2:0] Tpl_5242 ;
reg   Tpl_5243 ;
reg  [1:0] Tpl_5244 ;
reg   Tpl_5245 ;
reg   Tpl_5246 ;
reg  [2:0] Tpl_5247 ;
reg   Tpl_5248 ;
reg  [2:0] Tpl_5249 ;
reg  [2:0] Tpl_5250 ;
reg   Tpl_5251 ;
reg   Tpl_5252 ;
reg  [2:0] Tpl_5253 ;
reg  [2:0] Tpl_5254 ;
reg   Tpl_5255 ;
reg   Tpl_5256 ;
reg   Tpl_5257 ;
reg   Tpl_5258 ;
reg   Tpl_5259 ;
reg  [2:0] Tpl_5260 ;
reg   Tpl_5261 ;
reg   Tpl_5262 ;
reg   Tpl_5263 ;
reg   Tpl_5264 ;
reg   Tpl_5265 ;
reg  [2:0] Tpl_5266 ;
reg   Tpl_5267 ;
reg   Tpl_5268 ;
reg  [2:0] Tpl_5269 ;
reg   Tpl_5270 ;
reg  [2:0] Tpl_5271 ;
reg   Tpl_5272 ;
reg  [2:0] Tpl_5273 ;
reg   Tpl_5274 ;
reg  [2:0] Tpl_5275 ;
reg   Tpl_5276 ;
reg  [2:0] Tpl_5277 ;
reg   Tpl_5278 ;
reg  [2:0] Tpl_5279 ;
reg   Tpl_5280 ;
reg  [2:0] Tpl_5281 ;
reg   Tpl_5282 ;
reg  [2:0] Tpl_5283 ;
reg   Tpl_5284 ;
reg  [5:0] Tpl_5285 ;
reg   Tpl_5286 ;
reg   Tpl_5287 ;
reg  [5:0] Tpl_5288 ;
reg   Tpl_5289 ;
reg   Tpl_5290 ;
reg   Tpl_5291 ;
reg   Tpl_5292 ;
reg   Tpl_5293 ;
reg   Tpl_5294 ;
reg   Tpl_5295 ;
reg   Tpl_5296 ;
reg   Tpl_5297 ;
reg   Tpl_5298 ;
reg  [5:0] Tpl_5299 ;
reg   Tpl_5300 ;
reg   Tpl_5301 ;
reg  [5:0] Tpl_5302 ;
reg   Tpl_5303 ;
reg   Tpl_5304 ;
reg  [2:0] Tpl_5305 ;
reg   Tpl_5306 ;
reg   Tpl_5307 ;
reg   Tpl_5308 ;
reg  [1:0] Tpl_5309 ;
reg  [2:0] Tpl_5310 ;
reg   Tpl_5311 ;
reg   Tpl_5312 ;
reg   Tpl_5313 ;
reg  [1:0] Tpl_5314 ;
reg  [2:0] Tpl_5315 ;
reg   Tpl_5316 ;
reg   Tpl_5317 ;
reg   Tpl_5318 ;
reg  [1:0] Tpl_5319 ;
reg  [2:0] Tpl_5320 ;
reg   Tpl_5321 ;
reg   Tpl_5322 ;
reg   Tpl_5323 ;
reg  [1:0] Tpl_5324 ;
reg  [31:0] Tpl_5325 ;
reg  [31:0] Tpl_5326 ;
reg  [31:0] Tpl_5327 ;
reg  [31:0] Tpl_5328 ;
reg  [31:0] Tpl_5329 ;
reg  [31:0] Tpl_5330 ;
reg  [31:0] Tpl_5331 ;
reg  [31:0] Tpl_5332 ;
reg  [31:0] Tpl_5333 ;
reg  [31:0] Tpl_5334 ;
reg  [31:0] Tpl_5335 ;
reg  [31:0] Tpl_5336 ;
reg  [31:0] Tpl_5337 ;
reg  [31:0] Tpl_5338 ;
reg  [31:0] Tpl_5339 ;
reg  [31:0] Tpl_5340 ;
wire   Tpl_5341 ;
wire   Tpl_5342 ;
reg  [3:0] Tpl_5343 ;
reg  [3:0] Tpl_5344 ;
reg  [15:0] Tpl_5345 ;
reg  [15:0] Tpl_5346 ;
reg  [15:0] Tpl_5347 ;
reg  [15:0] Tpl_5348 ;
reg  [3:0] Tpl_5349 ;
reg  [3:0] Tpl_5350 ;
reg  [3:0] Tpl_5351 ;
reg  [3:0] Tpl_5352 ;
reg  [3:0] Tpl_5353 ;
reg  [3:0] Tpl_5354 ;
reg  [3:0] Tpl_5355 ;
reg  [3:0] Tpl_5356 ;
reg  [3:0] Tpl_5357 ;
reg  [11:0] Tpl_5358 ;
reg  [31:0] Tpl_5359 ;
reg  [31:0] Tpl_5360 ;
reg  [31:0] Tpl_5361 ;
reg  [31:0] Tpl_5362 ;
reg  [11:0] Tpl_5363 ;
reg  [169:0] Tpl_5364 ;
reg  [9:0] Tpl_5365 ;
reg  [1:0] Tpl_5366 ;
reg  [1:0] Tpl_5367 ;
reg  [1:0] Tpl_5368 ;
reg  [15:0] Tpl_5369 ;
reg  [11:0] Tpl_5370 ;
reg  [19:0] Tpl_5371 ;
reg  [3:0] Tpl_5372 ;
reg  [3:0] Tpl_5373 ;
reg  [3:0] Tpl_5374 ;
reg  [31:0] Tpl_5375 ;
reg  [1:0] Tpl_5376 ;
reg  [11:0] Tpl_5377 ;
reg  [5:0] Tpl_5378 ;
reg  [1:0] Tpl_5379 ;
reg  [1:0] Tpl_5380 ;
reg  [29:0] Tpl_5381 ;
reg  [11:0] Tpl_5382 ;
reg  [3:0] Tpl_5383 ;
reg  [3:0] Tpl_5384 ;
reg  [3:0] Tpl_5385 ;
reg  [11:0] Tpl_5386 ;
reg  [31:0] Tpl_5387 ;
reg  [3:0] Tpl_5388 ;
reg  [3:0] Tpl_5389 ;
reg  [1:0] Tpl_5390 ;
wire  [1:0] Tpl_5391 ;
reg  [11:0] Tpl_5392 ;
wire  [11:0] Tpl_5393 ;
reg  [1:0] Tpl_5394 ;
wire  [1:0] Tpl_5395 ;
reg  [11:0] Tpl_5396 ;
wire  [11:0] Tpl_5397 ;
reg  [27:0] Tpl_5398 ;
wire  [27:0] Tpl_5399 ;
reg  [531:0] Tpl_5400 ;
wire  [531:0] Tpl_5401 ;
reg  [111:0] Tpl_5402 ;
reg  [27:0] Tpl_5403 ;
reg  [27:0] Tpl_5404 ;
reg  [47:0] Tpl_5405 ;
wire  [47:0] Tpl_5406 ;
reg  [63:0] Tpl_5407 ;
wire  [63:0] Tpl_5408 ;
reg  [511:0] Tpl_5409 ;
wire  [511:0] Tpl_5410 ;
reg  [63:0] Tpl_5411 ;
wire  [63:0] Tpl_5412 ;
reg  [511:0] Tpl_5413 ;
wire  [511:0] Tpl_5414 ;
reg  [63:0] Tpl_5415 ;
wire  [63:0] Tpl_5416 ;
reg  [23:0] Tpl_5417 ;
wire  [23:0] Tpl_5418 ;
reg   Tpl_5419 ;
wire   Tpl_5420 ;
reg  [7:0] Tpl_5421 ;
wire  [7:0] Tpl_5422 ;
reg  [7:0] Tpl_5423 ;
wire  [7:0] Tpl_5424 ;
reg  [15:0] Tpl_5425 ;
reg  [13:0] Tpl_5426 ;
reg  [13:0] Tpl_5427 ;
reg   Tpl_5428 ;
wire   Tpl_5429 ;
reg  [7:0] Tpl_5430 ;
reg  [7:0] Tpl_5431 ;
reg  [7:0] Tpl_5432 ;
reg  [7:0] Tpl_5433 ;
reg  [7:0] Tpl_5434 ;
reg  [7:0] Tpl_5435 ;
reg  [7:0] Tpl_5436 ;
reg  [7:0] Tpl_5437 ;
reg  [7:0] Tpl_5438 ;
reg  [7:0] Tpl_5439 ;
reg  [7:0] Tpl_5440 ;
reg  [7:0] Tpl_5441 ;
reg  [7:0] Tpl_5442 ;
reg  [7:0] Tpl_5443 ;
reg  [7:0] Tpl_5444 ;
reg  [13:0] Tpl_5445 ;
reg  [7:0] Tpl_5446 ;
reg  [7:0] Tpl_5447 ;
reg  [27:0] Tpl_5448 ;
reg  [19:0] Tpl_5449 ;
reg  [19:0] Tpl_5450 ;
reg  [19:0] Tpl_5451 ;
reg  [7:0] Tpl_5452 ;
reg  [7:0] Tpl_5453 ;
reg  [7:0] Tpl_5454 ;
reg  [7:0] Tpl_5455 ;
reg  [13:0] Tpl_5456 ;
reg  [7:0] Tpl_5457 ;
reg  [7:0] Tpl_5458 ;
reg  [19:0] Tpl_5459 ;
reg  [19:0] Tpl_5460 ;
reg  [7:0] Tpl_5461 ;
reg  [19:0] Tpl_5462 ;
reg  [7:0] Tpl_5463 ;
reg  [19:0] Tpl_5464 ;
reg  [7:0] Tpl_5465 ;
reg  [7:0] Tpl_5466 ;
reg  [7:0] Tpl_5467 ;
reg  [7:0] Tpl_5468 ;
reg  [7:0] Tpl_5469 ;
reg  [13:0] Tpl_5470 ;
reg  [7:0] Tpl_5471 ;
reg  [19:0] Tpl_5472 ;
reg  [7:0] Tpl_5473 ;
reg  [7:0] Tpl_5474 ;
reg  [7:0] Tpl_5475 ;
reg  [7:0] Tpl_5476 ;
reg  [7:0] Tpl_5477 ;
reg  [13:0] Tpl_5478 ;
reg  [7:0] Tpl_5479 ;
reg  [7:0] Tpl_5480 ;
reg  [7:0] Tpl_5481 ;
reg  [21:0] Tpl_5482 ;
reg  [7:0] Tpl_5483 ;
reg  [7:0] Tpl_5484 ;
reg  [21:0] Tpl_5485 ;
reg  [7:0] Tpl_5486 ;
reg  [9:0] Tpl_5487 ;
reg  [9:0] Tpl_5488 ;
reg  [9:0] Tpl_5489 ;
reg  [9:0] Tpl_5490 ;
reg  [13:0] Tpl_5491 ;
reg  [13:0] Tpl_5492 ;
reg  [7:0] Tpl_5493 ;
reg  [7:0] Tpl_5494 ;
reg  [7:0] Tpl_5495 ;
reg  [13:0] Tpl_5496 ;
reg  [7:0] Tpl_5497 ;
reg  [7:0] Tpl_5498 ;
reg  [7:0] Tpl_5499 ;
reg  [13:0] Tpl_5500 ;
reg  [13:0] Tpl_5501 ;
reg  [13:0] Tpl_5502 ;
reg  [4:0] Tpl_5503 ;
reg  [4:0] Tpl_5504 ;
reg  [7:0] Tpl_5505 ;
reg  [7:0] Tpl_5506 ;
reg  [7:0] Tpl_5507 ;
reg  [7:0] Tpl_5508 ;
reg  [7:0] Tpl_5509 ;
reg  [13:0] Tpl_5510 ;
reg  [7:0] Tpl_5511 ;
reg  [7:0] Tpl_5512 ;
reg  [7:0] Tpl_5513 ;
reg  [7:0] Tpl_5514 ;
reg  [7:0] Tpl_5515 ;
reg  [7:0] Tpl_5516 ;
reg  [7:0] Tpl_5517 ;
reg  [7:0] Tpl_5518 ;
reg  [7:0] Tpl_5519 ;
reg  [7:0] Tpl_5520 ;
reg  [7:0] Tpl_5521 ;
reg  [21:0] Tpl_5522 ;
reg  [7:0] Tpl_5523 ;
reg  [7:0] Tpl_5524 ;
reg  [7:0] Tpl_5525 ;
reg  [27:0] Tpl_5526 ;
reg  [7:0] Tpl_5527 ;
reg  [7:0] Tpl_5528 ;
reg  [19:0] Tpl_5529 ;
reg  [7:0] Tpl_5530 ;
reg  [7:0] Tpl_5531 ;
reg  [13:0] Tpl_5532 ;
reg  [13:0] Tpl_5533 ;
reg  [13:0] Tpl_5534 ;
reg  [7:0] Tpl_5535 ;
reg  [7:0] Tpl_5536 ;
reg  [7:0] Tpl_5537 ;
reg  [7:0] Tpl_5538 ;
reg  [7:0] Tpl_5539 ;
reg  [7:0] Tpl_5540 ;
reg  [13:0] Tpl_5541 ;
reg  [19:0] Tpl_5542 ;
reg  [7:0] Tpl_5543 ;
reg  [7:0] Tpl_5544 ;
reg  [1:0] Tpl_5545 ;
reg  [1:0] Tpl_5546 ;
reg  [7:0] Tpl_5547 ;
reg  [7:0] Tpl_5548 ;
reg  [5:0] Tpl_5549 ;
reg  [5:0] Tpl_5550 ;
reg  [7:0] Tpl_5551 ;
reg  [7:0] Tpl_5552 ;
reg  [7:0] Tpl_5553 ;
reg  [1:0] Tpl_5554 ;
reg  [33:0] Tpl_5555 ;
reg  [21:0] Tpl_5556 ;
reg  [33:0] Tpl_5557 ;
reg  [21:0] Tpl_5558 ;
reg  [63:0] Tpl_5559 ;
reg  [63:0] Tpl_5560 ;
reg  [63:0] Tpl_5561 ;
reg  [63:0] Tpl_5562 ;
reg  [63:0] Tpl_5563 ;
reg  [63:0] Tpl_5564 ;
reg  [63:0] Tpl_5565 ;
reg  [63:0] Tpl_5566 ;
reg  [63:0] Tpl_5567 ;
reg  [63:0] Tpl_5568 ;
reg  [63:0] Tpl_5569 ;
reg  [63:0] Tpl_5570 ;
reg  [63:0] Tpl_5571 ;
reg  [63:0] Tpl_5572 ;
reg  [63:0] Tpl_5573 ;
reg  [63:0] Tpl_5574 ;
wire  [1:0] Tpl_5575 ;
wire  [1:0] Tpl_5576 ;
wire  [31:0] Tpl_5577 ;
wire  [1:0] Tpl_5578 ;
wire  [1:0] Tpl_5579 ;
wire  [1:0] Tpl_5580 ;
wire  [1:0] Tpl_5581 ;
wire  [1:0] Tpl_5582 ;
wire  [1:0] Tpl_5583 ;
wire  [1:0] Tpl_5584 ;
wire  [1:0] Tpl_5585 ;
wire  [1:0] Tpl_5586 ;
wire  [7:0] Tpl_5587 ;
wire  [33:0] Tpl_5588 ;
wire  [7:0] Tpl_5589 ;
wire  [3:0] Tpl_5590 ;
wire  [7:0] Tpl_5591 ;
wire  [7:0] Tpl_5592 ;
wire  [7:0] Tpl_5593 ;
wire  [7:0] Tpl_5594 ;
wire  [5:0] Tpl_5595 ;
wire  [3:0] Tpl_5596 ;
wire  [7:0] Tpl_5597 ;
wire  [7:0] Tpl_5598 ;
wire  [63:0] Tpl_5599 ;
wire  [63:0] Tpl_5600 ;
wire   Tpl_5601 ;
wire  [7:0] Tpl_5602 ;
wire  [1:0] Tpl_5603 ;
wire  [15:0] Tpl_5604 ;
wire  [7:0] Tpl_5605 ;
wire  [7:0] Tpl_5606 ;
wire  [7:0] Tpl_5607 ;
wire  [7:0] Tpl_5608 ;
wire  [7:0] Tpl_5609 ;
wire  [7:0] Tpl_5610 ;
wire  [7:0] Tpl_5611 ;
wire  [7:0] Tpl_5612 ;
wire  [7:0] Tpl_5613 ;
wire  [7:0] Tpl_5614 ;
wire  [7:0] Tpl_5615 ;
wire  [7:0] Tpl_5616 ;
wire  [7:0] Tpl_5617 ;
wire  [7:0] Tpl_5618 ;
wire  [7:0] Tpl_5619 ;
wire  [7:0] Tpl_5620 ;
wire  [7:0] Tpl_5621 ;
wire  [7:0] Tpl_5622 ;
wire  [7:0] Tpl_5623 ;
wire  [511:0] Tpl_5624 ;
reg  [1:0] Tpl_5625 ;
wire   Tpl_5626 ;
reg  [17:0] Tpl_5627 ;
reg  [17:0] Tpl_5628 ;
reg  [17:0] Tpl_5629 ;
reg  [17:0] Tpl_5630 ;
reg  [17:0] Tpl_5631 ;
reg  [17:0] Tpl_5632 ;
reg  [17:0] Tpl_5633 ;
reg  [17:0] Tpl_5634 ;
reg  [17:0] Tpl_5635 ;
reg  [17:0] Tpl_5636 ;
reg  [17:0] Tpl_5637 ;
reg  [7:0] Tpl_5638 ;
reg  [7:0] Tpl_5639 ;
reg  [7:0] Tpl_5640 ;
reg  [7:0] Tpl_5641 ;
reg  [7:0] Tpl_5642 ;
reg  [7:0] Tpl_5643 ;
reg  [7:0] Tpl_5644 ;
reg  [7:0] Tpl_5645 ;
reg  [7:0] Tpl_5646 ;
reg  [7:0] Tpl_5647 ;
reg  [7:0] Tpl_5648 ;
reg  [7:0] Tpl_5649 ;
reg  [7:0] Tpl_5650 ;
reg  [7:0] Tpl_5651 ;
reg  [7:0] Tpl_5652 ;
reg  [7:0] Tpl_5653 ;
reg  [7:0] Tpl_5654 ;
reg  [7:0] Tpl_5655 ;
reg  [7:0] Tpl_5656 ;
reg  [7:0] Tpl_5657 ;
reg  [7:0] Tpl_5658 ;
reg  [7:0] Tpl_5659 ;
reg  [7:0] Tpl_5660 ;
reg  [7:0] Tpl_5661 ;
reg  [7:0] Tpl_5662 ;
reg  [7:0] Tpl_5663 ;
reg  [7:0] Tpl_5664 ;
reg  [3:0] Tpl_5665 ;
reg   Tpl_5666 ;
reg  [1:0] Tpl_5667 ;
reg   Tpl_5668 ;
reg   Tpl_5669 ;
reg   Tpl_5670 ;
reg   Tpl_5671 ;
wire  [2:0] Tpl_5672 ;

assign user_cmd_ready = (&status_user_cmd_ready_ch);
assign user_cmd_wait_done = user_cmd_wait_done_ch;
assign dvstt1_dram_bl_enc = dram_bl_enc;
assign dvstt1_ddr4_en = reg_ddr4_enable;
assign dvstt1_ddr3_en = reg_ddr3_enable;
assign dvstt1_lpddr3_en = reg_lpddr3_enable;
assign dvstt1_lpddr4_en = reg_lpddr4_enable;
assign dvstt1_dfi_freq_ratio = dmctl_dfi_freq_ratio;
assign dvstt0_device_id = 16'h0000;

always @( posedge clk or negedge reset_n )
begin
if ((!reset_n))
begin
reg_phy_init_done <= 1'b0;
end
else
begin
reg_phy_init_done <= ((&pos_phyinitc) & (&pos_draminitc));
end
end


assign uci_cmd_op = Tpl_1730;
assign uci_cmd_chan = Tpl_1731;
assign uci_cmd_rank = Tpl_1732;
assign uci_mr_sel = Tpl_1733;
assign uci_mrs_last = Tpl_1734;
assign uci_mpr_data = Tpl_1735;
assign dmctl_ddrt = Tpl_1736;
assign dmctl_dfi_freq_ratio = Tpl_1737;
assign dmctl_dram_bank_en = Tpl_1738;
assign dmctl_switch_close = Tpl_1739;
assign dmctl_bank_policy = Tpl_1740;
assign dmctl_wr_dbi = Tpl_1741;
assign dmctl_rd_dbi = Tpl_1742;
assign dmctl_dual_chan_en = Tpl_1743;
assign dmctl_dual_rank_en = Tpl_1744;
assign dmctl_rd_req_min = Tpl_1745;
assign dmctl_wr_req_min = Tpl_1746;
assign dmctl_wr_crc = Tpl_1747;
assign dmctl_chan_unlock = Tpl_1748;
assign dmctl_hi_pri_imm = Tpl_1749;
assign dmcfg_ref_post_pull_en = Tpl_1750;
assign dmcfg_auto_srx_zqcl = Tpl_1751;
assign dmcfg_ref_int_en = Tpl_1752;
assign dmcfg_int_gc_fsm_en = Tpl_1753;
assign dmcfg_int_gc_fsm_clr = Tpl_1754;
assign dmcfg_req_th = Tpl_1755;
assign dmcfg_zq_auto_en = Tpl_1756;
assign dmcfg_ref_otf = Tpl_1757;
assign dmcfg_dqs2cken = Tpl_1758;
assign lpddr4_lpmr1_fs0_bl = Tpl_1759;
assign lpddr4_lpmr1_fs0_wpre = Tpl_1760;
assign lpddr4_lpmr1_fs0_rpre = Tpl_1761;
assign lpddr4_lpmr1_fs0_nwr = Tpl_1762;
assign lpddr4_lpmr1_fs0_rpst = Tpl_1763;
assign lpddr4_lpmr1_fs1_bl = Tpl_1764;
assign lpddr4_lpmr1_fs1_wpre = Tpl_1765;
assign lpddr4_lpmr1_fs1_rpre = Tpl_1766;
assign lpddr4_lpmr1_fs1_nwr = Tpl_1767;
assign lpddr4_lpmr1_fs1_rpst = Tpl_1768;
assign lpddr4_lpmr2_fs0_rl = Tpl_1769;
assign lpddr4_lpmr2_fs0_wl = Tpl_1770;
assign lpddr4_lpmr2_fs0_wls = Tpl_1771;
assign lpddr4_lpmr2_wrlev = Tpl_1772;
assign lpddr4_lpmr2_fs1_rl = Tpl_1773;
assign lpddr4_lpmr2_fs1_wl = Tpl_1774;
assign lpddr4_lpmr2_fs1_wls = Tpl_1775;
assign lpddr4_lpmr3_fs0_pucal = Tpl_1776;
assign lpddr4_lpmr3_fs0_wpst = Tpl_1777;
assign lpddr4_lpmr3_pprp = Tpl_1778;
assign lpddr4_lpmr3_fs0_pdds = Tpl_1779;
assign lpddr4_lpmr3_fs0_rdbi = Tpl_1780;
assign lpddr4_lpmr3_fs0_wdbi = Tpl_1781;
assign lpddr4_lpmr3_fs1_pucal = Tpl_1782;
assign lpddr4_lpmr3_fs1_wpst = Tpl_1783;
assign lpddr4_lpmr3_fs1_pdds = Tpl_1784;
assign lpddr4_lpmr3_fs1_rdbi = Tpl_1785;
assign lpddr4_lpmr3_fs1_wdbi = Tpl_1786;
assign lpddr4_lpmr11_fs0_dqodt = Tpl_1787;
assign lpddr4_lpmr11_fs0_caodt = Tpl_1788;
assign lpddr4_lpmr11_fs1_dqodt = Tpl_1789;
assign lpddr4_lpmr11_fs1_caodt = Tpl_1790;
assign lpddr4_lpmr11_nt_fs0_dqodt = Tpl_1791;
assign lpddr4_lpmr11_nt_fs0_caodt = Tpl_1792;
assign lpddr4_lpmr11_nt_fs1_dqodt = Tpl_1793;
assign lpddr4_lpmr11_nt_fs1_caodt = Tpl_1794;
assign lpddr4_lpmr12_fs0_vrefcas = Tpl_1795;
assign lpddr4_lpmr12_fs0_vrefcar = Tpl_1796;
assign lpddr4_lpmr12_fs1_vrefcas = Tpl_1797;
assign lpddr4_lpmr12_fs1_vrefcar = Tpl_1798;
assign lpddr4_lpmr13_cbt = Tpl_1799;
assign lpddr4_lpmr13_rpt = Tpl_1800;
assign lpddr4_lpmr13_vro = Tpl_1801;
assign lpddr4_lpmr13_vrcg = Tpl_1802;
assign lpddr4_lpmr13_rro = Tpl_1803;
assign lpddr4_lpmr13_dmd = Tpl_1804;
assign lpddr4_lpmr13_fspwr = Tpl_1805;
assign lpddr4_lpmr13_fspop = Tpl_1806;
assign lpddr4_lpmr14_fs0_vrefdqs = Tpl_1807;
assign lpddr4_lpmr14_fs0_vrefdqr = Tpl_1808;
assign lpddr4_lpmr14_fs1_vrefdqs = Tpl_1809;
assign lpddr4_lpmr14_fs1_vrefdqr = Tpl_1810;
assign lpddr4_lpmr22_fs0_socodt = Tpl_1811;
assign lpddr4_lpmr22_fs0_odteck = Tpl_1812;
assign lpddr4_lpmr22_fs0_odtecs = Tpl_1813;
assign lpddr4_lpmr22_fs0_odtdca = Tpl_1814;
assign lpddr4_lpmr22_odtdx8 = Tpl_1815;
assign lpddr4_lpmr22_fs1_socodt = Tpl_1816;
assign lpddr4_lpmr22_fs1_odteck = Tpl_1817;
assign lpddr4_lpmr22_fs1_odtecs = Tpl_1818;
assign lpddr4_lpmr22_fs1_odtdca = Tpl_1819;
assign lpddr4_lpmr22_nt_fs0_socodt = Tpl_1820;
assign lpddr4_lpmr22_nt_fs0_odteck = Tpl_1821;
assign lpddr4_lpmr22_nt_fs0_odtecs = Tpl_1822;
assign lpddr4_lpmr22_nt_fs0_odtdca = Tpl_1823;
assign lpddr4_lpmr22_nt_odtdx8 = Tpl_1824;
assign lpddr4_lpmr22_nt_fs1_socodt = Tpl_1825;
assign lpddr4_lpmr22_nt_fs1_odteck = Tpl_1826;
assign lpddr4_lpmr22_nt_fs1_odtecs = Tpl_1827;
assign lpddr4_lpmr22_nt_fs1_odtdca = Tpl_1828;
assign lpddr3_lpmr1_bl = Tpl_1829;
assign lpddr3_lpmr1_nwr = Tpl_1830;
assign lpddr3_lpmr2_rlwl = Tpl_1831;
assign lpddr3_lpmr2_nwre = Tpl_1832;
assign lpddr3_lpmr2_wls = Tpl_1833;
assign lpddr3_lpmr2_wrlev = Tpl_1834;
assign lpddr3_lpmr3_ds = Tpl_1835;
assign lpddr3_lpmr10_cali_code = Tpl_1836;
assign lpddr3_lpmr11_dqodt = Tpl_1837;
assign lpddr3_lpmr11_pd = Tpl_1838;
assign lpddr3_lpmr16_pasr_b = Tpl_1839;
assign lpddr3_lpmr17_pasr_s = Tpl_1840;
assign ddr4_mr0_wr = Tpl_1841;
assign ddr4_mr0_dllrst = Tpl_1842;
assign ddr4_mr0_tm = Tpl_1843;
assign ddr4_mr0_cl = Tpl_1844;
assign ddr4_mr0_rbt = Tpl_1845;
assign ddr4_mr0_bl = Tpl_1846;
assign ddr4_mr1_qoff = Tpl_1847;
assign ddr4_mr1_tdqs = Tpl_1848;
assign ddr4_mr1_wrlvl = Tpl_1849;
assign ddr4_mr1_rttnom = Tpl_1850;
assign ddr4_mr1_dic = Tpl_1851;
assign ddr4_mr1_dllen = Tpl_1852;
assign ddr4_mr1_al = Tpl_1853;
assign ddr4_mr2_rttwr = Tpl_1854;
assign ddr4_mr2_lasr = Tpl_1855;
assign ddr4_mr2_cwl = Tpl_1856;
assign ddr4_mr2_wrcrc = Tpl_1857;
assign ddr4_mr3_mpro = Tpl_1858;
assign ddr4_mr3_mprp = Tpl_1859;
assign ddr4_mr3_gdwn = Tpl_1860;
assign ddr4_mr3_pda = Tpl_1861;
assign ddr4_mr3_tsr = Tpl_1862;
assign ddr4_mr3_fgrm = Tpl_1863;
assign ddr4_mr3_wcl = Tpl_1864;
assign ddr4_mr3_mprf = Tpl_1865;
assign ddr4_mr4_mpdwn = Tpl_1866;
assign ddr4_mr4_tcrr = Tpl_1867;
assign ddr4_mr4_tcrm = Tpl_1868;
assign ddr4_mr4_ivref = Tpl_1869;
assign ddr4_mr4_cal = Tpl_1870;
assign ddr4_mr4_srab = Tpl_1871;
assign ddr4_mr4_rptm = Tpl_1872;
assign ddr4_mr4_rpre = Tpl_1873;
assign ddr4_mr4_wpre = Tpl_1874;
assign ddr4_mr5_capl = Tpl_1875;
assign ddr4_mr5_crcec = Tpl_1876;
assign ddr4_mr5_caps = Tpl_1877;
assign ddr4_mr5_odtb = Tpl_1878;
assign ddr4_mr5_rttpk = Tpl_1879;
assign ddr4_mr5_cappe = Tpl_1880;
assign ddr4_mr5_dm = Tpl_1881;
assign ddr4_mr5_wdbi = Tpl_1882;
assign ddr4_mr5_rdbi = Tpl_1883;
assign ddr4_mr6_vrefdq = Tpl_1884;
assign ddr4_mr6_vrefdqr = Tpl_1885;
assign ddr4_mr6_vrefdqe = Tpl_1886;
assign ddr4_mr6_ccdl = Tpl_1887;
assign ddr3_mr0_ppd = Tpl_1888;
assign ddr3_mr0_wr = Tpl_1889;
assign ddr3_mr0_dllrst = Tpl_1890;
assign ddr3_mr0_tm = Tpl_1891;
assign ddr3_mr0_cl = Tpl_1892;
assign ddr3_mr0_rbt = Tpl_1893;
assign ddr3_mr0_bl = Tpl_1894;
assign ddr3_mr1_qoff = Tpl_1895;
assign ddr3_mr1_tdqs = Tpl_1896;
assign ddr3_mr1_wrlvl = Tpl_1897;
assign ddr3_mr1_rttnom = Tpl_1898;
assign ddr3_mr1_dic = Tpl_1899;
assign ddr3_mr1_dllen = Tpl_1900;
assign ddr3_mr1_al = Tpl_1901;
assign ddr3_mr2_rttwr = Tpl_1902;
assign ddr3_mr2_srt = Tpl_1903;
assign ddr3_mr2_lasr = Tpl_1904;
assign ddr3_mr2_cwl = Tpl_1905;
assign ddr3_mr2_pasr = Tpl_1906;
assign ddr3_mr3_mpro = Tpl_1907;
assign ddr3_mr3_mprp = Tpl_1908;
assign rtcfg0_rt0_ext_pri = Tpl_1909;
assign rtcfg0_rt0_max_pri = Tpl_1910;
assign rtcfg0_rt0_arq_lvl_hi = Tpl_1911;
assign rtcfg0_rt0_arq_lvl_lo = Tpl_1912;
assign rtcfg0_rt0_awq_lvl_hi = Tpl_1913;
assign rtcfg0_rt0_awq_lvl_lo = Tpl_1914;
assign rtcfg0_rt0_arq_lat_barrier_en = Tpl_1915;
assign rtcfg0_rt0_awq_lat_barrier_en = Tpl_1916;
assign rtcfg0_rt0_arq_ooo_en = Tpl_1917;
assign rtcfg0_rt0_awq_ooo_en = Tpl_1918;
assign rtcfg0_rt0_acq_realtime_en = Tpl_1919;
assign rtcfg0_rt0_wm_enable = Tpl_1920;
assign rtcfg0_rt0_arq_lahead_en = Tpl_1921;
assign rtcfg0_rt0_awq_lahead_en = Tpl_1922;
assign rtcfg0_rt0_narrow_mode = Tpl_1923;
assign rtcfg0_rt0_narrow_size = Tpl_1924;
assign rtcfg0_rt1_ext_pri = Tpl_1925;
assign rtcfg0_rt1_max_pri = Tpl_1926;
assign rtcfg0_rt1_arq_lvl_hi = Tpl_1927;
assign rtcfg0_rt1_arq_lvl_lo = Tpl_1928;
assign rtcfg0_rt1_awq_lvl_hi = Tpl_1929;
assign rtcfg0_rt1_awq_lvl_lo = Tpl_1930;
assign rtcfg0_rt1_arq_lat_barrier_en = Tpl_1931;
assign rtcfg0_rt1_awq_lat_barrier_en = Tpl_1932;
assign rtcfg0_rt1_arq_ooo_en = Tpl_1933;
assign rtcfg0_rt1_awq_ooo_en = Tpl_1934;
assign rtcfg0_rt1_acq_realtime_en = Tpl_1935;
assign rtcfg0_rt1_wm_enable = Tpl_1936;
assign rtcfg0_rt1_arq_lahead_en = Tpl_1937;
assign rtcfg0_rt1_awq_lahead_en = Tpl_1938;
assign rtcfg0_rt1_narrow_mode = Tpl_1939;
assign rtcfg0_rt1_narrow_size = Tpl_1940;
assign rtcfg0_rt2_ext_pri = Tpl_1941;
assign rtcfg0_rt2_max_pri = Tpl_1942;
assign rtcfg0_rt2_arq_lvl_hi = Tpl_1943;
assign rtcfg0_rt2_arq_lvl_lo = Tpl_1944;
assign rtcfg0_rt2_awq_lvl_hi = Tpl_1945;
assign rtcfg0_rt2_awq_lvl_lo = Tpl_1946;
assign rtcfg0_rt2_arq_lat_barrier_en = Tpl_1947;
assign rtcfg0_rt2_awq_lat_barrier_en = Tpl_1948;
assign rtcfg0_rt2_arq_ooo_en = Tpl_1949;
assign rtcfg0_rt2_awq_ooo_en = Tpl_1950;
assign rtcfg0_rt2_acq_realtime_en = Tpl_1951;
assign rtcfg0_rt2_wm_enable = Tpl_1952;
assign rtcfg0_rt2_arq_lahead_en = Tpl_1953;
assign rtcfg0_rt2_awq_lahead_en = Tpl_1954;
assign rtcfg0_rt2_narrow_mode = Tpl_1955;
assign rtcfg0_rt2_narrow_size = Tpl_1956;
assign rtcfg0_rt3_ext_pri = Tpl_1957;
assign rtcfg0_rt3_max_pri = Tpl_1958;
assign rtcfg0_rt3_arq_lvl_hi = Tpl_1959;
assign rtcfg0_rt3_arq_lvl_lo = Tpl_1960;
assign rtcfg0_rt3_awq_lvl_hi = Tpl_1961;
assign rtcfg0_rt3_awq_lvl_lo = Tpl_1962;
assign rtcfg0_rt3_arq_lat_barrier_en = Tpl_1963;
assign rtcfg0_rt3_awq_lat_barrier_en = Tpl_1964;
assign rtcfg0_rt3_arq_ooo_en = Tpl_1965;
assign rtcfg0_rt3_awq_ooo_en = Tpl_1966;
assign rtcfg0_rt3_acq_realtime_en = Tpl_1967;
assign rtcfg0_rt3_wm_enable = Tpl_1968;
assign rtcfg0_rt3_arq_lahead_en = Tpl_1969;
assign rtcfg0_rt3_awq_lahead_en = Tpl_1970;
assign rtcfg0_rt3_narrow_mode = Tpl_1971;
assign rtcfg0_rt3_narrow_size = Tpl_1972;
assign rtcfg1_rt0_arq_lat_barrier = Tpl_1973;
assign rtcfg1_rt0_awq_lat_barrier = Tpl_1974;
assign rtcfg1_rt0_arq_starv_th = Tpl_1975;
assign rtcfg1_rt0_awq_starv_th = Tpl_1976;
assign rtcfg1_rt1_arq_lat_barrier = Tpl_1977;
assign rtcfg1_rt1_awq_lat_barrier = Tpl_1978;
assign rtcfg1_rt1_arq_starv_th = Tpl_1979;
assign rtcfg1_rt1_awq_starv_th = Tpl_1980;
assign rtcfg1_rt2_arq_lat_barrier = Tpl_1981;
assign rtcfg1_rt2_awq_lat_barrier = Tpl_1982;
assign rtcfg1_rt2_arq_starv_th = Tpl_1983;
assign rtcfg1_rt2_awq_starv_th = Tpl_1984;
assign rtcfg1_rt3_arq_lat_barrier = Tpl_1985;
assign rtcfg1_rt3_awq_lat_barrier = Tpl_1986;
assign rtcfg1_rt3_arq_starv_th = Tpl_1987;
assign rtcfg1_rt3_awq_starv_th = Tpl_1988;
assign rtcfg2_rt0_size_max = Tpl_1989;
assign rtcfg2_rt1_size_max = Tpl_1990;
assign rtcfg2_rt2_size_max = Tpl_1991;
assign rtcfg2_rt3_size_max = Tpl_1992;
assign addr0_col_addr_map_b0 = Tpl_1993;
assign addr0_col_addr_map_b1 = Tpl_1994;
assign addr0_col_addr_map_b2 = Tpl_1995;
assign addr0_col_addr_map_b3 = Tpl_1996;
assign addr0_col_addr_map_b4 = Tpl_1997;
assign addr0_col_addr_map_b5 = Tpl_1998;
assign addr1_col_addr_map_b6 = Tpl_1999;
assign addr1_col_addr_map_b7 = Tpl_2000;
assign addr1_col_addr_map_b8 = Tpl_2001;
assign addr1_col_addr_map_b9 = Tpl_2002;
assign addr1_col_addr_map_b10 = Tpl_2003;
assign addr2_row_addr_map_b0 = Tpl_2004;
assign addr2_row_addr_map_b1 = Tpl_2005;
assign addr2_row_addr_map_b2 = Tpl_2006;
assign addr2_row_addr_map_b3 = Tpl_2007;
assign addr2_row_addr_map_b4 = Tpl_2008;
assign addr2_row_addr_map_b5 = Tpl_2009;
assign addr3_row_addr_map_b6 = Tpl_2010;
assign addr3_row_addr_map_b7 = Tpl_2011;
assign addr3_row_addr_map_b8 = Tpl_2012;
assign addr3_row_addr_map_b9 = Tpl_2013;
assign addr3_row_addr_map_b10 = Tpl_2014;
assign addr3_row_addr_map_b11 = Tpl_2015;
assign addr4_row_addr_map_b12 = Tpl_2016;
assign addr4_row_addr_map_b13 = Tpl_2017;
assign addr4_row_addr_map_b14 = Tpl_2018;
assign addr4_row_addr_map_b15 = Tpl_2019;
assign addr4_row_addr_map_b16 = Tpl_2020;
assign addr5_bank_addr_map_b0 = Tpl_2021;
assign addr5_bank_addr_map_b1 = Tpl_2022;
assign addr5_bank_addr_map_b2 = Tpl_2023;
assign addr5_bank_addr_map_b3 = Tpl_2024;
assign addr5_rank_addr_map_b0 = Tpl_2025;
assign addr5_chan_addr_map_b0 = Tpl_2026;
assign phy_dti_dram_clk_dis = Tpl_2027;
assign phy_dti_data_byte_dis = Tpl_2028;
assign pom_chanen = Tpl_2029;
assign pom_dfien = Tpl_2030;
assign pom_proc = Tpl_2031;
assign pom_physeten = Tpl_2032;
assign pom_phyfsen = Tpl_2033;
assign pom_phyinit = Tpl_2034;
assign pom_dllrsten = Tpl_2035;
assign pom_draminiten = Tpl_2036;
assign pom_vrefdqrden = Tpl_2037;
assign pom_vrefcaen = Tpl_2038;
assign pom_gten = Tpl_2039;
assign pom_wrlvlen = Tpl_2040;
assign pom_rdlvlen = Tpl_2041;
assign pom_vrefdqwren = Tpl_2042;
assign pom_dlyevalen = Tpl_2043;
assign pom_sanchken = Tpl_2044;
assign pom_fs = Tpl_2045;
assign pom_clklocken = Tpl_2046;
assign pom_cmddlyen = Tpl_2047;
assign pom_odt = Tpl_2048;
assign pom_dqsdqen = Tpl_2049;
assign pom_ranken = Tpl_2050;
assign dllctlca_ch0_limit = Tpl_2051;
assign dllctlca_ch0_en = Tpl_2052;
assign dllctlca_ch0_upd = Tpl_2053;
assign dllctlca_ch0_byp = Tpl_2054;
assign dllctlca_ch0_bypc = Tpl_2055;
assign dllctlca_ch0_clkdly = Tpl_2056;
assign dllctlca_ch1_limit = Tpl_2057;
assign dllctlca_ch1_en = Tpl_2058;
assign dllctlca_ch1_upd = Tpl_2059;
assign dllctlca_ch1_byp = Tpl_2060;
assign dllctlca_ch1_bypc = Tpl_2061;
assign dllctlca_ch1_clkdly = Tpl_2062;
assign dllctldq_sl0_limit = Tpl_2063;
assign dllctldq_sl0_en = Tpl_2064;
assign dllctldq_sl0_upd = Tpl_2065;
assign dllctldq_sl0_byp = Tpl_2066;
assign dllctldq_sl0_bypc = Tpl_2067;
assign dllctldq_sl1_limit = Tpl_2068;
assign dllctldq_sl1_en = Tpl_2069;
assign dllctldq_sl1_upd = Tpl_2070;
assign dllctldq_sl1_byp = Tpl_2071;
assign dllctldq_sl1_bypc = Tpl_2072;
assign dllctldq_sl2_limit = Tpl_2073;
assign dllctldq_sl2_en = Tpl_2074;
assign dllctldq_sl2_upd = Tpl_2075;
assign dllctldq_sl2_byp = Tpl_2076;
assign dllctldq_sl2_bypc = Tpl_2077;
assign dllctldq_sl3_limit = Tpl_2078;
assign dllctldq_sl3_en = Tpl_2079;
assign dllctldq_sl3_upd = Tpl_2080;
assign dllctldq_sl3_byp = Tpl_2081;
assign dllctldq_sl3_bypc = Tpl_2082;
assign rtgc0_gt_updt = Tpl_2083;
assign rtgc0_gt_dis = Tpl_2084;
assign rtgc0_fs0_twren = Tpl_2085;
assign rtgc0_fs0_trden = Tpl_2086;
assign rtgc0_fs0_trdendbi = Tpl_2087;
assign rtgc1_fs1_twren = Tpl_2088;
assign rtgc1_fs1_trden = Tpl_2089;
assign rtgc1_fs1_trdendbi = Tpl_2090;
assign ptar_ba = Tpl_2091;
assign ptar_row = Tpl_2092;
assign ptar_col = Tpl_2093;
assign vtgc_ivrefr = Tpl_2094;
assign vtgc_ivrefts = Tpl_2095;
assign vtgc_vrefdqsw = Tpl_2096;
assign vtgc_vrefcasw = Tpl_2097;
assign vtgc_ivrefen = Tpl_2098;
assign pbcr_bist_en = Tpl_2099;
assign pbcr_bist_start = Tpl_2100;
assign pbcr_lp_en = Tpl_2101;
assign pbcr_vrefenca_c0 = Tpl_2102;
assign pbcr_vrefsetca_c0 = Tpl_2103;
assign pbcr_vrefenca_c1 = Tpl_2104;
assign pbcr_vrefsetca_c1 = Tpl_2105;
assign cior0_ch0_drvsel = Tpl_2106;
assign cior0_ch0_cmos_en = Tpl_2107;
assign cior0_ch1_drvsel = Tpl_2108;
assign cior0_ch1_cmos_en = Tpl_2109;
assign cior1_odis_clk = Tpl_2110;
assign cior1_odis_ctl = Tpl_2111;
assign dior_sl0_drvsel = Tpl_2112;
assign dior_sl0_cmos_en = Tpl_2113;
assign dior_sl0_fena_rcv = Tpl_2114;
assign dior_sl0_rtt_en = Tpl_2115;
assign dior_sl0_rtt_sel = Tpl_2116;
assign dior_sl0_odis_dq = Tpl_2117;
assign dior_sl0_odis_dm = Tpl_2118;
assign dior_sl0_odis_dqs = Tpl_2119;
assign dior_sl1_drvsel = Tpl_2120;
assign dior_sl1_cmos_en = Tpl_2121;
assign dior_sl1_fena_rcv = Tpl_2122;
assign dior_sl1_rtt_en = Tpl_2123;
assign dior_sl1_rtt_sel = Tpl_2124;
assign dior_sl1_odis_dq = Tpl_2125;
assign dior_sl1_odis_dm = Tpl_2126;
assign dior_sl1_odis_dqs = Tpl_2127;
assign dior_sl2_drvsel = Tpl_2128;
assign dior_sl2_cmos_en = Tpl_2129;
assign dior_sl2_fena_rcv = Tpl_2130;
assign dior_sl2_rtt_en = Tpl_2131;
assign dior_sl2_rtt_sel = Tpl_2132;
assign dior_sl2_odis_dq = Tpl_2133;
assign dior_sl2_odis_dm = Tpl_2134;
assign dior_sl2_odis_dqs = Tpl_2135;
assign dior_sl3_drvsel = Tpl_2136;
assign dior_sl3_cmos_en = Tpl_2137;
assign dior_sl3_fena_rcv = Tpl_2138;
assign dior_sl3_rtt_en = Tpl_2139;
assign dior_sl3_rtt_sel = Tpl_2140;
assign dior_sl3_odis_dq = Tpl_2141;
assign dior_sl3_odis_dm = Tpl_2142;
assign dior_sl3_odis_dqs = Tpl_2143;
assign pccr_srst = Tpl_2144;
assign pccr_tpaden = Tpl_2145;
assign pccr_mvg = Tpl_2146;
assign pccr_en = Tpl_2147;
assign pccr_upd = Tpl_2148;
assign pccr_bypen = Tpl_2149;
assign pccr_byp_n = Tpl_2150;
assign pccr_byp_p = Tpl_2151;
assign pccr_initcnt = Tpl_2152;
assign dqsdqcr_dlyoffs = Tpl_2153;
assign dqsdqcr_dqsel = Tpl_2154;
assign dqsdqcr_mupd = Tpl_2155;
assign dqsdqcr_mpcrpt = Tpl_2156;
assign dqsdqcr_dlymax = Tpl_2157;
assign dqsdqcr_dir = Tpl_2158;
assign dqsdqcr_rank = Tpl_2159;
assign ptsr0_r0_vrefcar = Tpl_2160;
assign Tpl_2161 = ptsr0_r0_vrefcar_ip;
assign ptsr0_r0_vrefcas = Tpl_2162;
assign Tpl_2163 = ptsr0_r0_vrefcas_ip;
assign ptsr0_r0_vrefdqwrr = Tpl_2164;
assign Tpl_2165 = ptsr0_r0_vrefdqwrr_ip;
assign ptsr0_r0_vrefdqwrs = Tpl_2166;
assign Tpl_2167 = ptsr0_r0_vrefdqwrs_ip;
assign ptsr1_r0_csc0 = Tpl_2168;
assign Tpl_2169 = ptsr1_r0_csc0_ip;
assign ptsr1_r0_csc1 = Tpl_2170;
assign Tpl_2171 = ptsr1_r0_csc1_ip;
assign ptsr1_r0_cac0b0 = Tpl_2172;
assign Tpl_2173 = ptsr1_r0_cac0b0_ip;
assign ptsr1_r0_cac0b1 = Tpl_2174;
assign Tpl_2175 = ptsr1_r0_cac0b1_ip;
assign ptsr2_r0_cac0b2 = Tpl_2176;
assign Tpl_2177 = ptsr2_r0_cac0b2_ip;
assign ptsr2_r0_cac0b3 = Tpl_2178;
assign Tpl_2179 = ptsr2_r0_cac0b3_ip;
assign ptsr2_r0_cac0b4 = Tpl_2180;
assign Tpl_2181 = ptsr2_r0_cac0b4_ip;
assign ptsr2_r0_cac0b5 = Tpl_2182;
assign Tpl_2183 = ptsr2_r0_cac0b5_ip;
assign ptsr3_r0_cac0b6 = Tpl_2184;
assign Tpl_2185 = ptsr3_r0_cac0b6_ip;
assign ptsr3_r0_cac0b7 = Tpl_2186;
assign Tpl_2187 = ptsr3_r0_cac0b7_ip;
assign ptsr3_r0_cac0b8 = Tpl_2188;
assign Tpl_2189 = ptsr3_r0_cac0b8_ip;
assign ptsr3_r0_cac0b9 = Tpl_2190;
assign Tpl_2191 = ptsr3_r0_cac0b9_ip;
assign ptsr4_r0_cac0b10 = Tpl_2192;
assign Tpl_2193 = ptsr4_r0_cac0b10_ip;
assign ptsr4_r0_cac0b11 = Tpl_2194;
assign Tpl_2195 = ptsr4_r0_cac0b11_ip;
assign ptsr4_r0_cac0b12 = Tpl_2196;
assign Tpl_2197 = ptsr4_r0_cac0b12_ip;
assign ptsr4_r0_cac0b13 = Tpl_2198;
assign Tpl_2199 = ptsr4_r0_cac0b13_ip;
assign ptsr5_r0_cac0b14 = Tpl_2200;
assign Tpl_2201 = ptsr5_r0_cac0b14_ip;
assign ptsr5_r0_cac0b15 = Tpl_2202;
assign Tpl_2203 = ptsr5_r0_cac0b15_ip;
assign ptsr5_r0_cac0b16 = Tpl_2204;
assign Tpl_2205 = ptsr5_r0_cac0b16_ip;
assign ptsr5_r0_cac0b17 = Tpl_2206;
assign Tpl_2207 = ptsr5_r0_cac0b17_ip;
assign ptsr6_r0_cac0b18 = Tpl_2208;
assign Tpl_2209 = ptsr6_r0_cac0b18_ip;
assign ptsr6_r0_cac1b0 = Tpl_2210;
assign Tpl_2211 = ptsr6_r0_cac1b0_ip;
assign ptsr6_r0_cac1b1 = Tpl_2212;
assign Tpl_2213 = ptsr6_r0_cac1b1_ip;
assign ptsr6_r0_cac1b2 = Tpl_2214;
assign Tpl_2215 = ptsr6_r0_cac1b2_ip;
assign ptsr7_r0_cac1b3 = Tpl_2216;
assign Tpl_2217 = ptsr7_r0_cac1b3_ip;
assign ptsr7_r0_cac1b4 = Tpl_2218;
assign Tpl_2219 = ptsr7_r0_cac1b4_ip;
assign ptsr7_r0_cac1b5 = Tpl_2220;
assign Tpl_2221 = ptsr7_r0_cac1b5_ip;
assign ptsr7_r0_cac1b6 = Tpl_2222;
assign Tpl_2223 = ptsr7_r0_cac1b6_ip;
assign ptsr8_r0_cac1b7 = Tpl_2224;
assign Tpl_2225 = ptsr8_r0_cac1b7_ip;
assign ptsr8_r0_cac1b8 = Tpl_2226;
assign Tpl_2227 = ptsr8_r0_cac1b8_ip;
assign ptsr8_r0_cac1b9 = Tpl_2228;
assign Tpl_2229 = ptsr8_r0_cac1b9_ip;
assign ptsr8_r0_cac1b10 = Tpl_2230;
assign Tpl_2231 = ptsr8_r0_cac1b10_ip;
assign ptsr9_r0_cac1b11 = Tpl_2232;
assign Tpl_2233 = ptsr9_r0_cac1b11_ip;
assign ptsr9_r0_cac1b12 = Tpl_2234;
assign Tpl_2235 = ptsr9_r0_cac1b12_ip;
assign ptsr9_r0_cac1b13 = Tpl_2236;
assign Tpl_2237 = ptsr9_r0_cac1b13_ip;
assign ptsr9_r0_cac1b14 = Tpl_2238;
assign Tpl_2239 = ptsr9_r0_cac1b14_ip;
assign ptsr10_r0_cac1b15 = Tpl_2240;
assign Tpl_2241 = ptsr10_r0_cac1b15_ip;
assign ptsr10_r0_cac1b16 = Tpl_2242;
assign Tpl_2243 = ptsr10_r0_cac1b16_ip;
assign ptsr10_r0_cac1b17 = Tpl_2244;
assign Tpl_2245 = ptsr10_r0_cac1b17_ip;
assign ptsr10_r0_cac1b18 = Tpl_2246;
assign Tpl_2247 = ptsr10_r0_cac1b18_ip;
assign ptsr11_r0_bac0b0 = Tpl_2248;
assign ptsr11_r0_bac0b1 = Tpl_2249;
assign ptsr11_r0_bac0b2 = Tpl_2250;
assign ptsr11_r0_bac0b3 = Tpl_2251;
assign ptsr12_r0_bac1b0 = Tpl_2252;
assign ptsr12_r0_bac1b1 = Tpl_2253;
assign ptsr12_r0_bac1b2 = Tpl_2254;
assign ptsr12_r0_bac1b3 = Tpl_2255;
assign ptsr13_r0_actnc0 = Tpl_2256;
assign ptsr13_r0_actnc1 = Tpl_2257;
assign ptsr13_r0_ckec0 = Tpl_2258;
assign ptsr13_r0_ckec1 = Tpl_2259;
assign ptsr14_r0_gts0 = Tpl_2260;
assign Tpl_2261 = ptsr14_r0_gts0_ip;
assign ptsr14_r0_gts1 = Tpl_2262;
assign Tpl_2263 = ptsr14_r0_gts1_ip;
assign ptsr14_r0_gts2 = Tpl_2264;
assign Tpl_2265 = ptsr14_r0_gts2_ip;
assign ptsr14_r0_gts3 = Tpl_2266;
assign Tpl_2267 = ptsr14_r0_gts3_ip;
assign ptsr15_r0_wrlvls0 = Tpl_2268;
assign Tpl_2269 = ptsr15_r0_wrlvls0_ip;
assign ptsr15_r0_wrlvls1 = Tpl_2270;
assign Tpl_2271 = ptsr15_r0_wrlvls1_ip;
assign ptsr15_r0_wrlvls2 = Tpl_2272;
assign Tpl_2273 = ptsr15_r0_wrlvls2_ip;
assign ptsr15_r0_wrlvls3 = Tpl_2274;
assign Tpl_2275 = ptsr15_r0_wrlvls3_ip;
assign ptsr16_r0_dqsdqs0b0 = Tpl_2276;
assign Tpl_2277 = ptsr16_r0_dqsdqs0b0_ip;
assign ptsr16_r0_dqsdqs0b1 = Tpl_2278;
assign Tpl_2279 = ptsr16_r0_dqsdqs0b1_ip;
assign ptsr16_r0_dqsdqs0b2 = Tpl_2280;
assign Tpl_2281 = ptsr16_r0_dqsdqs0b2_ip;
assign ptsr16_r0_dqsdqs0b3 = Tpl_2282;
assign Tpl_2283 = ptsr16_r0_dqsdqs0b3_ip;
assign ptsr17_r0_dqsdqs0b4 = Tpl_2284;
assign Tpl_2285 = ptsr17_r0_dqsdqs0b4_ip;
assign ptsr17_r0_dqsdqs0b5 = Tpl_2286;
assign Tpl_2287 = ptsr17_r0_dqsdqs0b5_ip;
assign ptsr17_r0_dqsdqs0b6 = Tpl_2288;
assign Tpl_2289 = ptsr17_r0_dqsdqs0b6_ip;
assign ptsr17_r0_dqsdqs0b7 = Tpl_2290;
assign Tpl_2291 = ptsr17_r0_dqsdqs0b7_ip;
assign ptsr18_r0_dqsdqs1b0 = Tpl_2292;
assign Tpl_2293 = ptsr18_r0_dqsdqs1b0_ip;
assign ptsr18_r0_dqsdqs1b1 = Tpl_2294;
assign Tpl_2295 = ptsr18_r0_dqsdqs1b1_ip;
assign ptsr18_r0_dqsdqs1b2 = Tpl_2296;
assign Tpl_2297 = ptsr18_r0_dqsdqs1b2_ip;
assign ptsr18_r0_dqsdqs1b3 = Tpl_2298;
assign Tpl_2299 = ptsr18_r0_dqsdqs1b3_ip;
assign ptsr19_r0_dqsdqs1b4 = Tpl_2300;
assign Tpl_2301 = ptsr19_r0_dqsdqs1b4_ip;
assign ptsr19_r0_dqsdqs1b5 = Tpl_2302;
assign Tpl_2303 = ptsr19_r0_dqsdqs1b5_ip;
assign ptsr19_r0_dqsdqs1b6 = Tpl_2304;
assign Tpl_2305 = ptsr19_r0_dqsdqs1b6_ip;
assign ptsr19_r0_dqsdqs1b7 = Tpl_2306;
assign Tpl_2307 = ptsr19_r0_dqsdqs1b7_ip;
assign ptsr20_r0_dqsdqs2b0 = Tpl_2308;
assign Tpl_2309 = ptsr20_r0_dqsdqs2b0_ip;
assign ptsr20_r0_dqsdqs2b1 = Tpl_2310;
assign Tpl_2311 = ptsr20_r0_dqsdqs2b1_ip;
assign ptsr20_r0_dqsdqs2b2 = Tpl_2312;
assign Tpl_2313 = ptsr20_r0_dqsdqs2b2_ip;
assign ptsr20_r0_dqsdqs2b3 = Tpl_2314;
assign Tpl_2315 = ptsr20_r0_dqsdqs2b3_ip;
assign ptsr21_r0_dqsdqs2b4 = Tpl_2316;
assign Tpl_2317 = ptsr21_r0_dqsdqs2b4_ip;
assign ptsr21_r0_dqsdqs2b5 = Tpl_2318;
assign Tpl_2319 = ptsr21_r0_dqsdqs2b5_ip;
assign ptsr21_r0_dqsdqs2b6 = Tpl_2320;
assign Tpl_2321 = ptsr21_r0_dqsdqs2b6_ip;
assign ptsr21_r0_dqsdqs2b7 = Tpl_2322;
assign Tpl_2323 = ptsr21_r0_dqsdqs2b7_ip;
assign ptsr22_r0_dqsdqs3b0 = Tpl_2324;
assign Tpl_2325 = ptsr22_r0_dqsdqs3b0_ip;
assign ptsr22_r0_dqsdqs3b1 = Tpl_2326;
assign Tpl_2327 = ptsr22_r0_dqsdqs3b1_ip;
assign ptsr22_r0_dqsdqs3b2 = Tpl_2328;
assign Tpl_2329 = ptsr22_r0_dqsdqs3b2_ip;
assign ptsr22_r0_dqsdqs3b3 = Tpl_2330;
assign Tpl_2331 = ptsr22_r0_dqsdqs3b3_ip;
assign ptsr23_r0_dqsdqs3b4 = Tpl_2332;
assign Tpl_2333 = ptsr23_r0_dqsdqs3b4_ip;
assign ptsr23_r0_dqsdqs3b5 = Tpl_2334;
assign Tpl_2335 = ptsr23_r0_dqsdqs3b5_ip;
assign ptsr23_r0_dqsdqs3b6 = Tpl_2336;
assign Tpl_2337 = ptsr23_r0_dqsdqs3b6_ip;
assign ptsr23_r0_dqsdqs3b7 = Tpl_2338;
assign Tpl_2339 = ptsr23_r0_dqsdqs3b7_ip;
assign ptsr24_r0_dqsdms0 = Tpl_2340;
assign Tpl_2341 = ptsr24_r0_dqsdms0_ip;
assign ptsr24_r0_dqsdms1 = Tpl_2342;
assign Tpl_2343 = ptsr24_r0_dqsdms1_ip;
assign ptsr24_r0_dqsdms2 = Tpl_2344;
assign Tpl_2345 = ptsr24_r0_dqsdms2_ip;
assign ptsr24_r0_dqsdms3 = Tpl_2346;
assign Tpl_2347 = ptsr24_r0_dqsdms3_ip;
assign ptsr25_r0_rdlvldqs0b0 = Tpl_2348;
assign Tpl_2349 = ptsr25_r0_rdlvldqs0b0_ip;
assign ptsr25_r0_rdlvldqs0b1 = Tpl_2350;
assign Tpl_2351 = ptsr25_r0_rdlvldqs0b1_ip;
assign ptsr25_r0_rdlvldqs0b2 = Tpl_2352;
assign Tpl_2353 = ptsr25_r0_rdlvldqs0b2_ip;
assign ptsr25_r0_rdlvldqs0b3 = Tpl_2354;
assign Tpl_2355 = ptsr25_r0_rdlvldqs0b3_ip;
assign ptsr26_r0_rdlvldqs0b4 = Tpl_2356;
assign Tpl_2357 = ptsr26_r0_rdlvldqs0b4_ip;
assign ptsr26_r0_rdlvldqs0b5 = Tpl_2358;
assign Tpl_2359 = ptsr26_r0_rdlvldqs0b5_ip;
assign ptsr26_r0_rdlvldqs0b6 = Tpl_2360;
assign Tpl_2361 = ptsr26_r0_rdlvldqs0b6_ip;
assign ptsr26_r0_rdlvldqs0b7 = Tpl_2362;
assign Tpl_2363 = ptsr26_r0_rdlvldqs0b7_ip;
assign ptsr27_r0_rdlvldqs1b0 = Tpl_2364;
assign Tpl_2365 = ptsr27_r0_rdlvldqs1b0_ip;
assign ptsr27_r0_rdlvldqs1b1 = Tpl_2366;
assign Tpl_2367 = ptsr27_r0_rdlvldqs1b1_ip;
assign ptsr27_r0_rdlvldqs1b2 = Tpl_2368;
assign Tpl_2369 = ptsr27_r0_rdlvldqs1b2_ip;
assign ptsr27_r0_rdlvldqs1b3 = Tpl_2370;
assign Tpl_2371 = ptsr27_r0_rdlvldqs1b3_ip;
assign ptsr28_r0_rdlvldqs1b4 = Tpl_2372;
assign Tpl_2373 = ptsr28_r0_rdlvldqs1b4_ip;
assign ptsr28_r0_rdlvldqs1b5 = Tpl_2374;
assign Tpl_2375 = ptsr28_r0_rdlvldqs1b5_ip;
assign ptsr28_r0_rdlvldqs1b6 = Tpl_2376;
assign Tpl_2377 = ptsr28_r0_rdlvldqs1b6_ip;
assign ptsr28_r0_rdlvldqs1b7 = Tpl_2378;
assign Tpl_2379 = ptsr28_r0_rdlvldqs1b7_ip;
assign ptsr29_r0_rdlvldqs2b0 = Tpl_2380;
assign Tpl_2381 = ptsr29_r0_rdlvldqs2b0_ip;
assign ptsr29_r0_rdlvldqs2b1 = Tpl_2382;
assign Tpl_2383 = ptsr29_r0_rdlvldqs2b1_ip;
assign ptsr29_r0_rdlvldqs2b2 = Tpl_2384;
assign Tpl_2385 = ptsr29_r0_rdlvldqs2b2_ip;
assign ptsr29_r0_rdlvldqs2b3 = Tpl_2386;
assign Tpl_2387 = ptsr29_r0_rdlvldqs2b3_ip;
assign ptsr30_r0_rdlvldqs2b4 = Tpl_2388;
assign Tpl_2389 = ptsr30_r0_rdlvldqs2b4_ip;
assign ptsr30_r0_rdlvldqs2b5 = Tpl_2390;
assign Tpl_2391 = ptsr30_r0_rdlvldqs2b5_ip;
assign ptsr30_r0_rdlvldqs2b6 = Tpl_2392;
assign Tpl_2393 = ptsr30_r0_rdlvldqs2b6_ip;
assign ptsr30_r0_rdlvldqs2b7 = Tpl_2394;
assign Tpl_2395 = ptsr30_r0_rdlvldqs2b7_ip;
assign ptsr31_r0_rdlvldqs3b0 = Tpl_2396;
assign Tpl_2397 = ptsr31_r0_rdlvldqs3b0_ip;
assign ptsr31_r0_rdlvldqs3b1 = Tpl_2398;
assign Tpl_2399 = ptsr31_r0_rdlvldqs3b1_ip;
assign ptsr31_r0_rdlvldqs3b2 = Tpl_2400;
assign Tpl_2401 = ptsr31_r0_rdlvldqs3b2_ip;
assign ptsr31_r0_rdlvldqs3b3 = Tpl_2402;
assign Tpl_2403 = ptsr31_r0_rdlvldqs3b3_ip;
assign ptsr32_r0_rdlvldqs3b4 = Tpl_2404;
assign Tpl_2405 = ptsr32_r0_rdlvldqs3b4_ip;
assign ptsr32_r0_rdlvldqs3b5 = Tpl_2406;
assign Tpl_2407 = ptsr32_r0_rdlvldqs3b5_ip;
assign ptsr32_r0_rdlvldqs3b6 = Tpl_2408;
assign Tpl_2409 = ptsr32_r0_rdlvldqs3b6_ip;
assign ptsr32_r0_rdlvldqs3b7 = Tpl_2410;
assign Tpl_2411 = ptsr32_r0_rdlvldqs3b7_ip;
assign ptsr33_r0_rdlvldms0 = Tpl_2412;
assign Tpl_2413 = ptsr33_r0_rdlvldms0_ip;
assign ptsr33_r0_rdlvldms1 = Tpl_2414;
assign Tpl_2415 = ptsr33_r0_rdlvldms1_ip;
assign ptsr33_r0_rdlvldms2 = Tpl_2416;
assign Tpl_2417 = ptsr33_r0_rdlvldms2_ip;
assign ptsr33_r0_rdlvldms3 = Tpl_2418;
assign Tpl_2419 = ptsr33_r0_rdlvldms3_ip;
assign ptsr34_r0_vrefdqrds0 = Tpl_2420;
assign Tpl_2421 = ptsr34_r0_vrefdqrds0_ip;
assign ptsr34_r0_vrefdqrds1 = Tpl_2422;
assign Tpl_2423 = ptsr34_r0_vrefdqrds1_ip;
assign ptsr34_r0_vrefdqrds2 = Tpl_2424;
assign Tpl_2425 = ptsr34_r0_vrefdqrds2_ip;
assign ptsr34_r0_vrefdqrds3 = Tpl_2426;
assign Tpl_2427 = ptsr34_r0_vrefdqrds3_ip;
assign ptsr34_r0_vrefdqrdr = Tpl_2428;
assign Tpl_2429 = ptsr34_r0_vrefdqrdr_ip;
assign ptsr35_r1_vrefcar = Tpl_2430;
assign Tpl_2431 = ptsr35_r1_vrefcar_ip;
assign ptsr35_r1_vrefcas = Tpl_2432;
assign Tpl_2433 = ptsr35_r1_vrefcas_ip;
assign ptsr35_r1_vrefdqwrr = Tpl_2434;
assign Tpl_2435 = ptsr35_r1_vrefdqwrr_ip;
assign ptsr35_r1_vrefdqwrs = Tpl_2436;
assign Tpl_2437 = ptsr35_r1_vrefdqwrs_ip;
assign ptsr36_r1_csc0 = Tpl_2438;
assign Tpl_2439 = ptsr36_r1_csc0_ip;
assign ptsr36_r1_csc1 = Tpl_2440;
assign Tpl_2441 = ptsr36_r1_csc1_ip;
assign ptsr36_r1_cac0b0 = Tpl_2442;
assign Tpl_2443 = ptsr36_r1_cac0b0_ip;
assign ptsr36_r1_cac0b1 = Tpl_2444;
assign Tpl_2445 = ptsr36_r1_cac0b1_ip;
assign ptsr37_r1_cac0b2 = Tpl_2446;
assign Tpl_2447 = ptsr37_r1_cac0b2_ip;
assign ptsr37_r1_cac0b3 = Tpl_2448;
assign Tpl_2449 = ptsr37_r1_cac0b3_ip;
assign ptsr37_r1_cac0b4 = Tpl_2450;
assign Tpl_2451 = ptsr37_r1_cac0b4_ip;
assign ptsr37_r1_cac0b5 = Tpl_2452;
assign Tpl_2453 = ptsr37_r1_cac0b5_ip;
assign ptsr38_r1_cac0b6 = Tpl_2454;
assign Tpl_2455 = ptsr38_r1_cac0b6_ip;
assign ptsr38_r1_cac0b7 = Tpl_2456;
assign Tpl_2457 = ptsr38_r1_cac0b7_ip;
assign ptsr38_r1_cac0b8 = Tpl_2458;
assign Tpl_2459 = ptsr38_r1_cac0b8_ip;
assign ptsr38_r1_cac0b9 = Tpl_2460;
assign Tpl_2461 = ptsr38_r1_cac0b9_ip;
assign ptsr39_r1_cac0b10 = Tpl_2462;
assign Tpl_2463 = ptsr39_r1_cac0b10_ip;
assign ptsr39_r1_cac0b11 = Tpl_2464;
assign Tpl_2465 = ptsr39_r1_cac0b11_ip;
assign ptsr39_r1_cac0b12 = Tpl_2466;
assign Tpl_2467 = ptsr39_r1_cac0b12_ip;
assign ptsr39_r1_cac0b13 = Tpl_2468;
assign Tpl_2469 = ptsr39_r1_cac0b13_ip;
assign ptsr40_r1_cac0b14 = Tpl_2470;
assign Tpl_2471 = ptsr40_r1_cac0b14_ip;
assign ptsr40_r1_cac0b15 = Tpl_2472;
assign Tpl_2473 = ptsr40_r1_cac0b15_ip;
assign ptsr40_r1_cac0b16 = Tpl_2474;
assign Tpl_2475 = ptsr40_r1_cac0b16_ip;
assign ptsr40_r1_cac0b17 = Tpl_2476;
assign Tpl_2477 = ptsr40_r1_cac0b17_ip;
assign ptsr41_r1_cac0b18 = Tpl_2478;
assign Tpl_2479 = ptsr41_r1_cac0b18_ip;
assign ptsr41_r1_cac1b0 = Tpl_2480;
assign Tpl_2481 = ptsr41_r1_cac1b0_ip;
assign ptsr41_r1_cac1b1 = Tpl_2482;
assign Tpl_2483 = ptsr41_r1_cac1b1_ip;
assign ptsr41_r1_cac1b2 = Tpl_2484;
assign Tpl_2485 = ptsr41_r1_cac1b2_ip;
assign ptsr42_r1_cac1b3 = Tpl_2486;
assign Tpl_2487 = ptsr42_r1_cac1b3_ip;
assign ptsr42_r1_cac1b4 = Tpl_2488;
assign Tpl_2489 = ptsr42_r1_cac1b4_ip;
assign ptsr42_r1_cac1b5 = Tpl_2490;
assign Tpl_2491 = ptsr42_r1_cac1b5_ip;
assign ptsr42_r1_cac1b6 = Tpl_2492;
assign Tpl_2493 = ptsr42_r1_cac1b6_ip;
assign ptsr43_r1_cac1b7 = Tpl_2494;
assign Tpl_2495 = ptsr43_r1_cac1b7_ip;
assign ptsr43_r1_cac1b8 = Tpl_2496;
assign Tpl_2497 = ptsr43_r1_cac1b8_ip;
assign ptsr43_r1_cac1b9 = Tpl_2498;
assign Tpl_2499 = ptsr43_r1_cac1b9_ip;
assign ptsr43_r1_cac1b10 = Tpl_2500;
assign Tpl_2501 = ptsr43_r1_cac1b10_ip;
assign ptsr44_r1_cac1b11 = Tpl_2502;
assign Tpl_2503 = ptsr44_r1_cac1b11_ip;
assign ptsr44_r1_cac1b12 = Tpl_2504;
assign Tpl_2505 = ptsr44_r1_cac1b12_ip;
assign ptsr44_r1_cac1b13 = Tpl_2506;
assign Tpl_2507 = ptsr44_r1_cac1b13_ip;
assign ptsr44_r1_cac1b14 = Tpl_2508;
assign Tpl_2509 = ptsr44_r1_cac1b14_ip;
assign ptsr45_r1_cac1b15 = Tpl_2510;
assign Tpl_2511 = ptsr45_r1_cac1b15_ip;
assign ptsr45_r1_cac1b16 = Tpl_2512;
assign Tpl_2513 = ptsr45_r1_cac1b16_ip;
assign ptsr45_r1_cac1b17 = Tpl_2514;
assign Tpl_2515 = ptsr45_r1_cac1b17_ip;
assign ptsr45_r1_cac1b18 = Tpl_2516;
assign Tpl_2517 = ptsr45_r1_cac1b18_ip;
assign ptsr46_r1_bac0b0 = Tpl_2518;
assign ptsr46_r1_bac0b1 = Tpl_2519;
assign ptsr46_r1_bac0b2 = Tpl_2520;
assign ptsr46_r1_bac0b3 = Tpl_2521;
assign ptsr47_r1_bac1b0 = Tpl_2522;
assign ptsr47_r1_bac1b1 = Tpl_2523;
assign ptsr47_r1_bac1b2 = Tpl_2524;
assign ptsr47_r1_bac1b3 = Tpl_2525;
assign ptsr48_r1_actnc0 = Tpl_2526;
assign ptsr48_r1_actnc1 = Tpl_2527;
assign ptsr48_r1_ckec0 = Tpl_2528;
assign ptsr48_r1_ckec1 = Tpl_2529;
assign ptsr49_r1_gts0 = Tpl_2530;
assign Tpl_2531 = ptsr49_r1_gts0_ip;
assign ptsr49_r1_gts1 = Tpl_2532;
assign Tpl_2533 = ptsr49_r1_gts1_ip;
assign ptsr49_r1_gts2 = Tpl_2534;
assign Tpl_2535 = ptsr49_r1_gts2_ip;
assign ptsr49_r1_gts3 = Tpl_2536;
assign Tpl_2537 = ptsr49_r1_gts3_ip;
assign ptsr50_r1_wrlvls0 = Tpl_2538;
assign Tpl_2539 = ptsr50_r1_wrlvls0_ip;
assign ptsr50_r1_wrlvls1 = Tpl_2540;
assign Tpl_2541 = ptsr50_r1_wrlvls1_ip;
assign ptsr50_r1_wrlvls2 = Tpl_2542;
assign Tpl_2543 = ptsr50_r1_wrlvls2_ip;
assign ptsr50_r1_wrlvls3 = Tpl_2544;
assign Tpl_2545 = ptsr50_r1_wrlvls3_ip;
assign ptsr51_r1_dqsdqs0b0 = Tpl_2546;
assign Tpl_2547 = ptsr51_r1_dqsdqs0b0_ip;
assign ptsr51_r1_dqsdqs0b1 = Tpl_2548;
assign Tpl_2549 = ptsr51_r1_dqsdqs0b1_ip;
assign ptsr51_r1_dqsdqs0b2 = Tpl_2550;
assign Tpl_2551 = ptsr51_r1_dqsdqs0b2_ip;
assign ptsr51_r1_dqsdqs0b3 = Tpl_2552;
assign Tpl_2553 = ptsr51_r1_dqsdqs0b3_ip;
assign ptsr52_r1_dqsdqs0b4 = Tpl_2554;
assign Tpl_2555 = ptsr52_r1_dqsdqs0b4_ip;
assign ptsr52_r1_dqsdqs0b5 = Tpl_2556;
assign Tpl_2557 = ptsr52_r1_dqsdqs0b5_ip;
assign ptsr52_r1_dqsdqs0b6 = Tpl_2558;
assign Tpl_2559 = ptsr52_r1_dqsdqs0b6_ip;
assign ptsr52_r1_dqsdqs0b7 = Tpl_2560;
assign Tpl_2561 = ptsr52_r1_dqsdqs0b7_ip;
assign ptsr53_r1_dqsdqs1b0 = Tpl_2562;
assign Tpl_2563 = ptsr53_r1_dqsdqs1b0_ip;
assign ptsr53_r1_dqsdqs1b1 = Tpl_2564;
assign Tpl_2565 = ptsr53_r1_dqsdqs1b1_ip;
assign ptsr53_r1_dqsdqs1b2 = Tpl_2566;
assign Tpl_2567 = ptsr53_r1_dqsdqs1b2_ip;
assign ptsr53_r1_dqsdqs1b3 = Tpl_2568;
assign Tpl_2569 = ptsr53_r1_dqsdqs1b3_ip;
assign ptsr54_r1_dqsdqs1b4 = Tpl_2570;
assign Tpl_2571 = ptsr54_r1_dqsdqs1b4_ip;
assign ptsr54_r1_dqsdqs1b5 = Tpl_2572;
assign Tpl_2573 = ptsr54_r1_dqsdqs1b5_ip;
assign ptsr54_r1_dqsdqs1b6 = Tpl_2574;
assign Tpl_2575 = ptsr54_r1_dqsdqs1b6_ip;
assign ptsr54_r1_dqsdqs1b7 = Tpl_2576;
assign Tpl_2577 = ptsr54_r1_dqsdqs1b7_ip;
assign ptsr55_r1_dqsdqs2b0 = Tpl_2578;
assign Tpl_2579 = ptsr55_r1_dqsdqs2b0_ip;
assign ptsr55_r1_dqsdqs2b1 = Tpl_2580;
assign Tpl_2581 = ptsr55_r1_dqsdqs2b1_ip;
assign ptsr55_r1_dqsdqs2b2 = Tpl_2582;
assign Tpl_2583 = ptsr55_r1_dqsdqs2b2_ip;
assign ptsr55_r1_dqsdqs2b3 = Tpl_2584;
assign Tpl_2585 = ptsr55_r1_dqsdqs2b3_ip;
assign ptsr56_r1_dqsdqs2b4 = Tpl_2586;
assign Tpl_2587 = ptsr56_r1_dqsdqs2b4_ip;
assign ptsr56_r1_dqsdqs2b5 = Tpl_2588;
assign Tpl_2589 = ptsr56_r1_dqsdqs2b5_ip;
assign ptsr56_r1_dqsdqs2b6 = Tpl_2590;
assign Tpl_2591 = ptsr56_r1_dqsdqs2b6_ip;
assign ptsr56_r1_dqsdqs2b7 = Tpl_2592;
assign Tpl_2593 = ptsr56_r1_dqsdqs2b7_ip;
assign ptsr57_r1_dqsdqs3b0 = Tpl_2594;
assign Tpl_2595 = ptsr57_r1_dqsdqs3b0_ip;
assign ptsr57_r1_dqsdqs3b1 = Tpl_2596;
assign Tpl_2597 = ptsr57_r1_dqsdqs3b1_ip;
assign ptsr57_r1_dqsdqs3b2 = Tpl_2598;
assign Tpl_2599 = ptsr57_r1_dqsdqs3b2_ip;
assign ptsr57_r1_dqsdqs3b3 = Tpl_2600;
assign Tpl_2601 = ptsr57_r1_dqsdqs3b3_ip;
assign ptsr58_r1_dqsdqs3b4 = Tpl_2602;
assign Tpl_2603 = ptsr58_r1_dqsdqs3b4_ip;
assign ptsr58_r1_dqsdqs3b5 = Tpl_2604;
assign Tpl_2605 = ptsr58_r1_dqsdqs3b5_ip;
assign ptsr58_r1_dqsdqs3b6 = Tpl_2606;
assign Tpl_2607 = ptsr58_r1_dqsdqs3b6_ip;
assign ptsr58_r1_dqsdqs3b7 = Tpl_2608;
assign Tpl_2609 = ptsr58_r1_dqsdqs3b7_ip;
assign ptsr59_r1_dqsdms0 = Tpl_2610;
assign Tpl_2611 = ptsr59_r1_dqsdms0_ip;
assign ptsr59_r1_dqsdms1 = Tpl_2612;
assign Tpl_2613 = ptsr59_r1_dqsdms1_ip;
assign ptsr59_r1_dqsdms2 = Tpl_2614;
assign Tpl_2615 = ptsr59_r1_dqsdms2_ip;
assign ptsr59_r1_dqsdms3 = Tpl_2616;
assign Tpl_2617 = ptsr59_r1_dqsdms3_ip;
assign ptsr60_r1_rdlvldqs0b0 = Tpl_2618;
assign Tpl_2619 = ptsr60_r1_rdlvldqs0b0_ip;
assign ptsr60_r1_rdlvldqs0b1 = Tpl_2620;
assign Tpl_2621 = ptsr60_r1_rdlvldqs0b1_ip;
assign ptsr60_r1_rdlvldqs0b2 = Tpl_2622;
assign Tpl_2623 = ptsr60_r1_rdlvldqs0b2_ip;
assign ptsr60_r1_rdlvldqs0b3 = Tpl_2624;
assign Tpl_2625 = ptsr60_r1_rdlvldqs0b3_ip;
assign ptsr61_r1_rdlvldqs0b4 = Tpl_2626;
assign Tpl_2627 = ptsr61_r1_rdlvldqs0b4_ip;
assign ptsr61_r1_rdlvldqs0b5 = Tpl_2628;
assign Tpl_2629 = ptsr61_r1_rdlvldqs0b5_ip;
assign ptsr61_r1_rdlvldqs0b6 = Tpl_2630;
assign Tpl_2631 = ptsr61_r1_rdlvldqs0b6_ip;
assign ptsr61_r1_rdlvldqs0b7 = Tpl_2632;
assign Tpl_2633 = ptsr61_r1_rdlvldqs0b7_ip;
assign ptsr62_r1_rdlvldqs1b0 = Tpl_2634;
assign Tpl_2635 = ptsr62_r1_rdlvldqs1b0_ip;
assign ptsr62_r1_rdlvldqs1b1 = Tpl_2636;
assign Tpl_2637 = ptsr62_r1_rdlvldqs1b1_ip;
assign ptsr62_r1_rdlvldqs1b2 = Tpl_2638;
assign Tpl_2639 = ptsr62_r1_rdlvldqs1b2_ip;
assign ptsr62_r1_rdlvldqs1b3 = Tpl_2640;
assign Tpl_2641 = ptsr62_r1_rdlvldqs1b3_ip;
assign ptsr63_r1_rdlvldqs1b4 = Tpl_2642;
assign Tpl_2643 = ptsr63_r1_rdlvldqs1b4_ip;
assign ptsr63_r1_rdlvldqs1b5 = Tpl_2644;
assign Tpl_2645 = ptsr63_r1_rdlvldqs1b5_ip;
assign ptsr63_r1_rdlvldqs1b6 = Tpl_2646;
assign Tpl_2647 = ptsr63_r1_rdlvldqs1b6_ip;
assign ptsr63_r1_rdlvldqs1b7 = Tpl_2648;
assign Tpl_2649 = ptsr63_r1_rdlvldqs1b7_ip;
assign ptsr64_r1_rdlvldqs2b0 = Tpl_2650;
assign Tpl_2651 = ptsr64_r1_rdlvldqs2b0_ip;
assign ptsr64_r1_rdlvldqs2b1 = Tpl_2652;
assign Tpl_2653 = ptsr64_r1_rdlvldqs2b1_ip;
assign ptsr64_r1_rdlvldqs2b2 = Tpl_2654;
assign Tpl_2655 = ptsr64_r1_rdlvldqs2b2_ip;
assign ptsr64_r1_rdlvldqs2b3 = Tpl_2656;
assign Tpl_2657 = ptsr64_r1_rdlvldqs2b3_ip;
assign ptsr65_r1_rdlvldqs2b4 = Tpl_2658;
assign Tpl_2659 = ptsr65_r1_rdlvldqs2b4_ip;
assign ptsr65_r1_rdlvldqs2b5 = Tpl_2660;
assign Tpl_2661 = ptsr65_r1_rdlvldqs2b5_ip;
assign ptsr65_r1_rdlvldqs2b6 = Tpl_2662;
assign Tpl_2663 = ptsr65_r1_rdlvldqs2b6_ip;
assign ptsr65_r1_rdlvldqs2b7 = Tpl_2664;
assign Tpl_2665 = ptsr65_r1_rdlvldqs2b7_ip;
assign ptsr66_r1_rdlvldqs3b0 = Tpl_2666;
assign Tpl_2667 = ptsr66_r1_rdlvldqs3b0_ip;
assign ptsr66_r1_rdlvldqs3b1 = Tpl_2668;
assign Tpl_2669 = ptsr66_r1_rdlvldqs3b1_ip;
assign ptsr66_r1_rdlvldqs3b2 = Tpl_2670;
assign Tpl_2671 = ptsr66_r1_rdlvldqs3b2_ip;
assign ptsr66_r1_rdlvldqs3b3 = Tpl_2672;
assign Tpl_2673 = ptsr66_r1_rdlvldqs3b3_ip;
assign ptsr67_r1_rdlvldqs3b4 = Tpl_2674;
assign Tpl_2675 = ptsr67_r1_rdlvldqs3b4_ip;
assign ptsr67_r1_rdlvldqs3b5 = Tpl_2676;
assign Tpl_2677 = ptsr67_r1_rdlvldqs3b5_ip;
assign ptsr67_r1_rdlvldqs3b6 = Tpl_2678;
assign Tpl_2679 = ptsr67_r1_rdlvldqs3b6_ip;
assign ptsr67_r1_rdlvldqs3b7 = Tpl_2680;
assign Tpl_2681 = ptsr67_r1_rdlvldqs3b7_ip;
assign ptsr68_r1_rdlvldms0 = Tpl_2682;
assign Tpl_2683 = ptsr68_r1_rdlvldms0_ip;
assign ptsr68_r1_rdlvldms1 = Tpl_2684;
assign Tpl_2685 = ptsr68_r1_rdlvldms1_ip;
assign ptsr68_r1_rdlvldms2 = Tpl_2686;
assign Tpl_2687 = ptsr68_r1_rdlvldms2_ip;
assign ptsr68_r1_rdlvldms3 = Tpl_2688;
assign Tpl_2689 = ptsr68_r1_rdlvldms3_ip;
assign ptsr69_r0_psck = Tpl_2690;
assign Tpl_2691 = ptsr69_r0_psck_ip;
assign ptsr69_r0_dqsleadck = Tpl_2692;
assign Tpl_2693 = ptsr69_r0_dqsleadck_ip;
assign ptsr69_r1_psck = Tpl_2694;
assign Tpl_2695 = ptsr69_r1_psck_ip;
assign ptsr69_r1_dqsleadck = Tpl_2696;
assign Tpl_2697 = ptsr69_r1_dqsleadck_ip;
assign ptsr69_sanpat = Tpl_2698;
assign ptsr70_odtc0 = Tpl_2699;
assign ptsr70_odtc1 = Tpl_2700;
assign ptsr70_rstnc0 = Tpl_2701;
assign ptsr70_rstnc1 = Tpl_2702;
assign ptsr70_nt_rank = Tpl_2703;
assign Tpl_2704 = ptsr70_nt_rank_ip;
assign calvlpa0_pattern_a = Tpl_2705;
assign calvlpa1_pattern_b = Tpl_2706;
assign treg1_t_alrtp = Tpl_2707;
assign treg1_t_ckesr = Tpl_2708;
assign treg1_t_ccd_s = Tpl_2709;
assign treg1_t_faw = Tpl_2710;
assign treg1_t_rtw = Tpl_2711;
assign treg2_t_rcd = Tpl_2712;
assign treg2_t_rdpden = Tpl_2713;
assign treg2_t_rc = Tpl_2714;
assign treg2_t_ras = Tpl_2715;
assign treg3_t_pd = Tpl_2716;
assign treg3_t_rp = Tpl_2717;
assign treg3_t_wlbr = Tpl_2718;
assign treg3_t_wrapden = Tpl_2719;
assign treg3_t_cke = Tpl_2720;
assign treg4_t_xp = Tpl_2721;
assign treg4_t_vreftimelong = Tpl_2722;
assign treg4_t_vreftimeshort = Tpl_2723;
assign treg4_t_mrd = Tpl_2724;
assign treg5_t_zqcs_itv = Tpl_2725;
assign treg6_t_pori = Tpl_2726;
assign treg6_t_zqinit = Tpl_2727;
assign treg7_t_mrs2lvlen = Tpl_2728;
assign treg7_t_zqcs = Tpl_2729;
assign treg7_t_xpdll = Tpl_2730;
assign treg7_t_wlbtr = Tpl_2731;
assign treg8_t_rrd_s = Tpl_2732;
assign treg8_t_rfc1 = Tpl_2733;
assign treg8_t_mrs2act = Tpl_2734;
assign treg8_t_lvlaa = Tpl_2735;
assign treg9_t_dllk = Tpl_2736;
assign treg9_t_refi_off = Tpl_2737;
assign treg9_t_mprr = Tpl_2738;
assign treg10_t_xpr = Tpl_2739;
assign treg10_t_dllrst = Tpl_2740;
assign treg11_t_rst = Tpl_2741;
assign treg11_t_odth4 = Tpl_2742;
assign treg12_t_odth8 = Tpl_2743;
assign treg12_t_lvlload = Tpl_2744;
assign treg12_t_lvldll = Tpl_2745;
assign treg12_t_lvlresp = Tpl_2746;
assign treg13_t_xs = Tpl_2747;
assign treg13_t_mod = Tpl_2748;
assign treg14_t_dpd = Tpl_2749;
assign treg14_t_mrw = Tpl_2750;
assign treg14_t_wr2rd = Tpl_2751;
assign treg15_t_mrr = Tpl_2752;
assign treg15_t_zqrs = Tpl_2753;
assign treg15_t_dqscke = Tpl_2754;
assign treg15_t_xsr = Tpl_2755;
assign treg16_t_mped = Tpl_2756;
assign treg16_t_mpx = Tpl_2757;
assign treg16_t_wr_mpr = Tpl_2758;
assign treg16_t_init5 = Tpl_2759;
assign treg17_t_setgear = Tpl_2760;
assign treg17_t_syncgear = Tpl_2761;
assign treg17_t_dlllock = Tpl_2762;
assign treg17_t_wlbtr_s = Tpl_2763;
assign treg18_t_read_low = Tpl_2764;
assign treg18_t_read_high = Tpl_2765;
assign treg19_t_write_low = Tpl_2766;
assign treg19_t_write_high = Tpl_2767;
assign treg20_t_rfc2 = Tpl_2768;
assign treg20_t_rfc4 = Tpl_2769;
assign treg21_t_wlbr_crcdm = Tpl_2770;
assign treg21_t_wlbtr_crcdm_l = Tpl_2771;
assign treg21_t_wlbtr_crcdm_s = Tpl_2772;
assign treg21_t_xmpdll = Tpl_2773;
assign treg22_t_wrmpr = Tpl_2774;
assign treg22_t_lvlexit = Tpl_2775;
assign treg22_t_lvldis = Tpl_2776;
assign treg23_t_zqoper = Tpl_2777;
assign treg23_t_rfc = Tpl_2778;
assign treg24_t_xsdll = Tpl_2779;
assign treg24_odtlon = Tpl_2780;
assign treg25_odtloff = Tpl_2781;
assign treg25_t_wlmrd = Tpl_2782;
assign treg25_t_wldqsen = Tpl_2783;
assign treg25_t_wtr = Tpl_2784;
assign treg26_t_rda2pd = Tpl_2785;
assign treg26_t_wra2pd = Tpl_2786;
assign treg26_t_zqcl = Tpl_2787;
assign treg27_t_calvl_adr_ckeh = Tpl_2788;
assign treg27_t_calvl_capture = Tpl_2789;
assign treg27_t_calvl_cc = Tpl_2790;
assign treg27_t_calvl_en = Tpl_2791;
assign treg28_t_calvl_ext = Tpl_2792;
assign treg28_t_calvl_max = Tpl_2793;
assign treg29_t_ckehdqs = Tpl_2794;
assign treg29_t_ccd = Tpl_2795;
assign treg29_t_zqlat = Tpl_2796;
assign treg29_t_ckckeh = Tpl_2797;
assign treg30_t_rrd = Tpl_2798;
assign treg30_t_caent = Tpl_2799;
assign treg30_t_cmdcke = Tpl_2800;
assign treg30_t_mpcwr = Tpl_2801;
assign treg30_t_dqrpt = Tpl_2802;
assign treg31_t_zq_itv = Tpl_2803;
assign treg31_t_ckelck = Tpl_2804;
assign treg32_t_dllen = Tpl_2805;
assign treg32_t_init3 = Tpl_2806;
assign treg32_t_dtrain = Tpl_2807;
assign treg33_t_mpcwr2rd = Tpl_2808;
assign treg33_t_fc = Tpl_2809;
assign treg33_t_refi = Tpl_2810;
assign treg34_t_vrcgen = Tpl_2811;
assign treg34_t_vrcgdis = Tpl_2812;
assign treg34_t_odtup = Tpl_2813;
assign treg34_t_ccdwm = Tpl_2814;
assign treg35_t_osco = Tpl_2815;
assign treg35_t_ckfspe = Tpl_2816;
assign treg35_t_ckfspx = Tpl_2817;
assign treg35_t_init1 = Tpl_2818;
assign treg36_t_zqcal = Tpl_2819;
assign treg36_t_lvlresp_nr = Tpl_2820;
assign treg36_t_ppd = Tpl_2821;
assign bistcfg_ch0_start_rank = Tpl_2822;
assign bistcfg_ch0_end_rank = Tpl_2823;
assign bistcfg_ch0_start_bank = Tpl_2824;
assign bistcfg_ch0_end_bank = Tpl_2825;
assign bistcfg_ch0_start_background = Tpl_2826;
assign bistcfg_ch0_end_background = Tpl_2827;
assign bistcfg_ch0_element = Tpl_2828;
assign bistcfg_ch0_operation = Tpl_2829;
assign bistcfg_ch0_retention = Tpl_2830;
assign bistcfg_ch0_diagnosis_en = Tpl_2831;
assign bistcfg_ch1_start_rank = Tpl_2832;
assign bistcfg_ch1_end_rank = Tpl_2833;
assign bistcfg_ch1_start_bank = Tpl_2834;
assign bistcfg_ch1_end_bank = Tpl_2835;
assign bistcfg_ch1_start_background = Tpl_2836;
assign bistcfg_ch1_end_background = Tpl_2837;
assign bistcfg_ch1_element = Tpl_2838;
assign bistcfg_ch1_operation = Tpl_2839;
assign bistcfg_ch1_retention = Tpl_2840;
assign bistcfg_ch1_diagnosis_en = Tpl_2841;
assign biststaddr_ch0_start_row = Tpl_2842;
assign biststaddr_ch0_start_col = Tpl_2843;
assign biststaddr_ch1_start_row = Tpl_2844;
assign biststaddr_ch1_start_col = Tpl_2845;
assign bistedaddr_ch0_end_row = Tpl_2846;
assign bistedaddr_ch0_end_col = Tpl_2847;
assign bistedaddr_ch1_end_row = Tpl_2848;
assign bistedaddr_ch1_end_col = Tpl_2849;
assign bistm0_ch0_march_element_0 = Tpl_2850;
assign bistm0_ch1_march_element_0 = Tpl_2851;
assign bistm1_ch0_march_element_1 = Tpl_2852;
assign bistm1_ch1_march_element_1 = Tpl_2853;
assign bistm2_ch0_march_element_2 = Tpl_2854;
assign bistm2_ch1_march_element_2 = Tpl_2855;
assign bistm3_ch0_march_element_3 = Tpl_2856;
assign bistm3_ch1_march_element_3 = Tpl_2857;
assign bistm4_ch0_march_element_4 = Tpl_2858;
assign bistm4_ch1_march_element_4 = Tpl_2859;
assign bistm5_ch0_march_element_5 = Tpl_2860;
assign bistm5_ch1_march_element_5 = Tpl_2861;
assign bistm6_ch0_march_element_6 = Tpl_2862;
assign bistm6_ch1_march_element_6 = Tpl_2863;
assign bistm7_ch0_march_element_7 = Tpl_2864;
assign bistm7_ch1_march_element_7 = Tpl_2865;
assign bistm8_ch0_march_element_8 = Tpl_2866;
assign bistm8_ch1_march_element_8 = Tpl_2867;
assign bistm9_ch0_march_element_9 = Tpl_2868;
assign bistm9_ch1_march_element_9 = Tpl_2869;
assign bistm10_ch0_march_element_10 = Tpl_2870;
assign bistm10_ch1_march_element_10 = Tpl_2871;
assign bistm11_ch0_march_element_11 = Tpl_2872;
assign bistm11_ch1_march_element_11 = Tpl_2873;
assign bistm12_ch0_march_element_12 = Tpl_2874;
assign bistm12_ch1_march_element_12 = Tpl_2875;
assign bistm13_ch0_march_element_13 = Tpl_2876;
assign bistm13_ch1_march_element_13 = Tpl_2877;
assign bistm14_ch0_march_element_14 = Tpl_2878;
assign bistm14_ch1_march_element_14 = Tpl_2879;
assign bistm15_ch0_march_element_15 = Tpl_2880;
assign bistm15_ch1_march_element_15 = Tpl_2881;
assign adft_tst_en_ca = Tpl_2882;
assign adft_tst_en_dq = Tpl_2883;
assign outbypen0_clk = Tpl_2884;
assign outbypen0_dm = Tpl_2885;
assign outbypen0_dqs = Tpl_2886;
assign outbypen1_dq = Tpl_2887;
assign outbypen2_ctl = Tpl_2888;
assign outd0_clk = Tpl_2889;
assign outd0_dm = Tpl_2890;
assign outd0_dqs = Tpl_2891;
assign outd1_dq = Tpl_2892;
assign outd2_ctl = Tpl_2893;
assign Tpl_2894 = dvstt0_device_id;
assign Tpl_2895 = dvstt1_dram_bl_enc;
assign Tpl_2896 = dvstt1_dfi_freq_ratio;
assign Tpl_2897 = opstt_ch0_dram_pause;
assign Tpl_2898 = opstt_ch0_user_cmd_ready;
assign Tpl_2899 = opstt_ch0_bank_idle;
assign Tpl_2900 = opstt_ch0_xqr_empty;
assign Tpl_2901 = opstt_ch0_xqr_full;
assign Tpl_2902 = opstt_ch0_xqw_empty;
assign Tpl_2903 = opstt_ch0_xqw_full;
assign Tpl_2904 = opstt_ch1_dram_pause;
assign Tpl_2905 = opstt_ch1_user_cmd_ready;
assign Tpl_2906 = opstt_ch1_bank_idle;
assign Tpl_2907 = opstt_ch1_xqr_empty;
assign Tpl_2908 = opstt_ch1_xqr_full;
assign Tpl_2909 = opstt_ch1_xqw_empty;
assign Tpl_2910 = opstt_ch1_xqw_full;
assign Tpl_2911 = intstt_ch0_int_gc_fsm;
assign Tpl_2912 = intstt_ch1_int_gc_fsm;
assign Tpl_2913 = ddrbiststt_ch0_error;
assign Tpl_2914 = ddrbiststt_ch0_endtest;
assign Tpl_2915 = ddrbiststt_ch0_error_new;
assign Tpl_2916 = ddrbiststt_ch0_rank_fail;
assign Tpl_2917 = ddrbiststt_ch0_bank_fail;
assign Tpl_2918 = ddrbiststt_ch0_row_fail;
assign Tpl_2919 = ddrbiststt_ch1_error;
assign Tpl_2920 = ddrbiststt_ch1_endtest;
assign Tpl_2921 = ddrbiststt_ch1_error_new;
assign Tpl_2922 = ddrbiststt_ch1_rank_fail;
assign Tpl_2923 = ddrbiststt_ch1_bank_fail;
assign Tpl_2924 = ddrbiststt_ch1_row_fail;
assign Tpl_2925 = pos_physetc;
assign Tpl_2926 = pos_phyfsc;
assign Tpl_2927 = pos_phyinitc;
assign Tpl_2928 = pos_dllrstc;
assign Tpl_2929 = pos_draminitc;
assign Tpl_2930 = pos_vrefdqrdc;
assign Tpl_2931 = pos_vrefcac;
assign Tpl_2932 = pos_gtc;
assign Tpl_2933 = pos_wrlvlc;
assign Tpl_2934 = pos_rdlvlc;
assign Tpl_2935 = pos_vrefdqwrc;
assign Tpl_2936 = pos_dlyevalc;
assign Tpl_2937 = pos_sanchkc;
assign Tpl_2938 = pos_ofs;
assign Tpl_2939 = pos_fs0req;
assign Tpl_2940 = pos_fs1req;
assign Tpl_2941 = pos_clklockc;
assign Tpl_2942 = pos_cmddlyc;
assign Tpl_2943 = pos_dqsdqc;
assign Tpl_2944 = pts0_r0_vrefdqrderr;
assign Tpl_2945 = pts0_r0_vrefcaerr;
assign Tpl_2946 = pts0_r0_gterr;
assign Tpl_2947 = pts0_r0_wrlvlerr;
assign Tpl_2948 = pts0_r0_vrefdqwrerr;
assign Tpl_2949 = pts0_r0_rdlvldmerr;
assign Tpl_2950 = pts0_dllerr;
assign Tpl_2951 = pts0_lp3calvlerr;
assign Tpl_2952 = pts1_r0_sanchkerr;
assign Tpl_2953 = pts1_r0_dqsdmerr;
assign Tpl_2954 = pts1_r1_sanchkerr;
assign Tpl_2955 = pts1_r1_dqsdmerr;
assign Tpl_2956 = pts2_r0_rdlvldqerr;
assign Tpl_2957 = pts3_r0_dqsdqerr;
assign Tpl_2958 = pts4_r1_vrefdqrderr;
assign Tpl_2959 = pts4_r1_vrefcaerr;
assign Tpl_2960 = pts4_r1_gterr;
assign Tpl_2961 = pts4_r1_wrlvlerr;
assign Tpl_2962 = pts4_r1_vrefdqwrerr;
assign Tpl_2963 = pts4_r1_rdlvldmerr;
assign Tpl_2964 = pts5_r1_rdlvldqerr;
assign Tpl_2965 = pts6_r1_dqsdqerr;
assign Tpl_2966 = dllsttca_lock;
assign Tpl_2967 = dllsttca_ovfl;
assign Tpl_2968 = dllsttca_unfl;
assign Tpl_2969 = dllsttdq_lock;
assign Tpl_2970 = dllsttdq_ovfl;
assign Tpl_2971 = dllsttdq_unfl;
assign Tpl_2972 = pbsr_bist_done;
assign Tpl_2973 = pbsr_bist_err_ctl;
assign Tpl_2974 = pbsr1_bist_err_dq;
assign Tpl_2975 = pbsr2_bist_err_dm;
assign Tpl_2976 = pcsr_srstc;
assign Tpl_2977 = pcsr_updc;
assign Tpl_2978 = pcsr_nbc;
assign Tpl_2979 = pcsr_pbc;
assign Tpl_2980 = mpr_done;
assign Tpl_2981 = mpr_readout;
assign Tpl_2982 = mrr_ch0_done;
assign Tpl_2983 = mrr_ch0_readout;
assign Tpl_2984 = mrr_ch1_done;
assign Tpl_2985 = mrr_ch1_readout;
assign Tpl_2986 = shad_lpmr1_fs0_bl;
assign Tpl_2987 = shad_lpmr1_fs0_wpre;
assign Tpl_2988 = shad_lpmr1_fs0_rpre;
assign Tpl_2989 = shad_lpmr1_fs0_nwr;
assign Tpl_2990 = shad_lpmr1_fs0_rpst;
assign Tpl_2991 = shad_lpmr1_fs1_bl;
assign Tpl_2992 = shad_lpmr1_fs1_wpre;
assign Tpl_2993 = shad_lpmr1_fs1_rpre;
assign Tpl_2994 = shad_lpmr1_fs1_nwr;
assign Tpl_2995 = shad_lpmr1_fs1_rpst;
assign Tpl_2996 = shad_lpmr2_fs0_rl;
assign Tpl_2997 = shad_lpmr2_fs0_wl;
assign Tpl_2998 = shad_lpmr2_fs0_wls;
assign Tpl_2999 = shad_lpmr2_wrlev;
assign Tpl_3000 = shad_lpmr2_fs1_rl;
assign Tpl_3001 = shad_lpmr2_fs1_wl;
assign Tpl_3002 = shad_lpmr2_fs1_wls;
assign Tpl_3003 = shad_lpmr2_reserved;
assign Tpl_3004 = shad_lpmr3_fs0_pucal;
assign Tpl_3005 = shad_lpmr3_fs0_wpst;
assign Tpl_3006 = shad_lpmr3_pprp;
assign Tpl_3007 = shad_lpmr3_fs0_pdds;
assign Tpl_3008 = shad_lpmr3_fs0_rdbi;
assign Tpl_3009 = shad_lpmr3_fs0_wdbi;
assign Tpl_3010 = shad_lpmr3_fs1_pucal;
assign Tpl_3011 = shad_lpmr3_fs1_wpst;
assign Tpl_3012 = shad_lpmr3_reserved;
assign Tpl_3013 = shad_lpmr3_fs1_pdds;
assign Tpl_3014 = shad_lpmr3_fs1_rdbi;
assign Tpl_3015 = shad_lpmr3_fs1_wdbi;
assign Tpl_3016 = shad_lpmr11_fs0_dqodt;
assign Tpl_3017 = shad_lpmr11_reserved0;
assign Tpl_3018 = shad_lpmr11_fs0_caodt;
assign Tpl_3019 = shad_lpmr11_reserved1;
assign Tpl_3020 = shad_lpmr11_fs1_dqodt;
assign Tpl_3021 = shad_lpmr11_reserved2;
assign Tpl_3022 = shad_lpmr11_fs1_caodt;
assign Tpl_3023 = shad_lpmr11_reserved3;
assign Tpl_3024 = shad_lpmr11_nt_fs0_dqodt;
assign Tpl_3025 = shad_lpmr11_nt_reserved0;
assign Tpl_3026 = shad_lpmr11_nt_fs0_caodt;
assign Tpl_3027 = shad_lpmr11_nt_reserved1;
assign Tpl_3028 = shad_lpmr11_nt_fs1_dqodt;
assign Tpl_3029 = shad_lpmr11_nt_reserved2;
assign Tpl_3030 = shad_lpmr11_nt_fs1_caodt;
assign Tpl_3031 = shad_lpmr11_nt_reserved3;
assign Tpl_3032 = shad_lpmr12_fs0_vrefcas;
assign Tpl_3033 = shad_lpmr12_fs0_vrefcar;
assign Tpl_3034 = shad_lpmr12_reserved0;
assign Tpl_3035 = shad_lpmr12_fs1_vrefcas;
assign Tpl_3036 = shad_lpmr12_fs1_vrefcar;
assign Tpl_3037 = shad_lpmr12_reserved1;
assign Tpl_3038 = shad_lpmr13_cbt;
assign Tpl_3039 = shad_lpmr13_rpt;
assign Tpl_3040 = shad_lpmr13_vro;
assign Tpl_3041 = shad_lpmr13_vrcg;
assign Tpl_3042 = shad_lpmr13_rro;
assign Tpl_3043 = shad_lpmr13_dmd;
assign Tpl_3044 = shad_lpmr13_fspwr;
assign Tpl_3045 = shad_lpmr13_fspop;
assign Tpl_3046 = shad_lpmr14_fs0_vrefdqs;
assign Tpl_3047 = shad_lpmr14_fs0_vrefdqr;
assign Tpl_3048 = shad_lpmr14_reserved0;
assign Tpl_3049 = shad_lpmr14_fs1_vrefdqs;
assign Tpl_3050 = shad_lpmr14_fs1_vrefdqr;
assign Tpl_3051 = shad_lpmr14_reserved1;
assign Tpl_3052 = shad_lpmr22_fs0_socodt;
assign Tpl_3053 = shad_lpmr22_fs0_odteck;
assign Tpl_3054 = shad_lpmr22_fs0_odtecs;
assign Tpl_3055 = shad_lpmr22_fs0_odtdca;
assign Tpl_3056 = shad_lpmr22_odtdx8;
assign Tpl_3057 = shad_lpmr22_fs1_socodt;
assign Tpl_3058 = shad_lpmr22_fs1_odteck;
assign Tpl_3059 = shad_lpmr22_fs1_odtecs;
assign Tpl_3060 = shad_lpmr22_fs1_odtdca;
assign Tpl_3061 = shad_lpmr22_reserved;
assign Tpl_3062 = shad_lpmr22_nt_fs0_socodt;
assign Tpl_3063 = shad_lpmr22_nt_fs0_odteck;
assign Tpl_3064 = shad_lpmr22_nt_fs0_odtecs;
assign Tpl_3065 = shad_lpmr22_nt_fs0_odtdca;
assign Tpl_3066 = shad_lpmr22_nt_odtdx8;
assign Tpl_3067 = shad_lpmr22_nt_fs1_socodt;
assign Tpl_3068 = shad_lpmr22_nt_fs1_odteck;
assign Tpl_3069 = shad_lpmr22_nt_fs1_odtecs;
assign Tpl_3070 = shad_lpmr22_nt_fs1_odtdca;
assign Tpl_3071 = shad_lpmr22_nt_reserved;
assign Tpl_3072 = data0_rddata;
assign Tpl_3073 = data1_rddata;
assign Tpl_3074 = data2_rddata;
assign Tpl_3075 = data3_rddata;
assign Tpl_3076 = data4_rddata;
assign Tpl_3077 = data5_rddata;
assign Tpl_3078 = data6_rddata;
assign Tpl_3079 = data7_rddata;
assign Tpl_3080 = data8_rddata;
assign Tpl_3081 = data9_rddata;
assign Tpl_3082 = data10_rddata;
assign Tpl_3083 = data11_rddata;
assign Tpl_3084 = data12_rddata;
assign Tpl_3085 = data13_rddata;
assign Tpl_3086 = data14_rddata;
assign Tpl_3087 = data15_rddata;
assign Tpl_3088 = data16_rdvalid;
assign int_gc_fsm_ch0 = Tpl_3089;
assign int_gc_fsm_ch1 = Tpl_3090;
assign Tpl_3091 = clk;
assign Tpl_3092 = reset_n;
assign Tpl_3093 = user_cmd_ready;
assign Tpl_3094 = user_cmd_wait_done;
assign user_cmd_valid = Tpl_3095;
assign Tpl_3096 = waddr;
assign Tpl_3097 = raddr;
assign Tpl_3098 = wdata;
assign rdata = Tpl_3099;
assign Tpl_3100 = wr_en;
assign Tpl_3101 = rd_en;
assign Tpl_3102 = ptsr_upd;
assign Tpl_3103 = mupd_dqsdqcr_clr;
assign addr_wr_dec_status = Tpl_3104;
assign addr_rd_dec_status = Tpl_3105;
assign Tpl_3106 = rddata_upd;
assign Tpl_3107 = mpr_access_enable;
assign Tpl_3108 = mpr_rd_n_wr;
assign Tpl_3109 = mrr_enable;

assign Tpl_4085 = clk;
assign Tpl_4086 = reset_n;
assign Tpl_4087 = axi4lite_arvalid;
assign Tpl_4088 = axi4lite_araddr;
assign axi4lite_arready = Tpl_4089;
assign Tpl_4090 = axi4lite_rready;
assign axi4lite_rvalid = Tpl_4091;
assign axi4lite_rdata = Tpl_4092;
assign axi4lite_rresp = Tpl_4093;
assign Tpl_4094 = status_int_gc_fsm_ch;
assign Tpl_4095 = addr_rd_dec_status;
assign Tpl_4096 = rdata;
assign rd_en = Tpl_4097;
assign raddr = Tpl_4098;

assign Tpl_4101 = clk;
assign Tpl_4102 = reset_n;
assign Tpl_4103 = user_cmd_ready;
assign Tpl_4104 = axi4lite_awvalid;
assign Tpl_4105 = axi4lite_awaddr;
assign axi4lite_awready = Tpl_4106;
assign Tpl_4107 = axi4lite_wvalid;
assign Tpl_4108 = axi4lite_wdata;
assign axi4lite_wready = Tpl_4109;
assign Tpl_4110 = axi4lite_bready;
assign axi4lite_bvalid = Tpl_4111;
assign axi4lite_bresp = Tpl_4112;
assign Tpl_4113 = user_cmd_wait_done;
assign Tpl_4114 = status_int_gc_fsm_ch;
assign Tpl_4115 = addr_wr_dec_status;
assign wdata = Tpl_4116;
assign wr_en = Tpl_4117;
assign waddr = Tpl_4118;

assign Tpl_4121 = lpddr4_lpmr1_fs0_bl;
assign Tpl_4122 = lpddr4_lpmr1_fs0_wpre;
assign Tpl_4123 = lpddr4_lpmr1_fs0_rpre;
assign Tpl_4124 = lpddr4_lpmr1_fs0_nwr;
assign Tpl_4125 = lpddr4_lpmr1_fs0_rpst;
assign Tpl_4126 = lpddr4_lpmr1_fs1_bl;
assign Tpl_4127 = lpddr4_lpmr1_fs1_wpre;
assign Tpl_4128 = lpddr4_lpmr1_fs1_rpre;
assign Tpl_4129 = lpddr4_lpmr1_fs1_nwr;
assign Tpl_4130 = lpddr4_lpmr1_fs1_rpst;
assign Tpl_4131 = lpddr4_lpmr2_fs0_rl;
assign Tpl_4132 = lpddr4_lpmr2_fs0_wl;
assign Tpl_4133 = lpddr4_lpmr2_fs0_wls;
assign Tpl_4134 = lpddr4_lpmr2_wrlev;
assign Tpl_4135 = lpddr4_lpmr2_fs1_rl;
assign Tpl_4136 = lpddr4_lpmr2_fs1_wl;
assign Tpl_4137 = lpddr4_lpmr2_fs1_wls;
assign Tpl_4138 = lpddr4_lpmr3_fs0_pucal;
assign Tpl_4139 = lpddr4_lpmr3_fs0_wpst;
assign Tpl_4140 = lpddr4_lpmr3_pprp;
assign Tpl_4141 = lpddr4_lpmr3_fs0_pdds;
assign Tpl_4142 = lpddr4_lpmr3_fs0_rdbi;
assign Tpl_4143 = lpddr4_lpmr3_fs0_wdbi;
assign Tpl_4144 = lpddr4_lpmr3_fs1_pucal;
assign Tpl_4145 = lpddr4_lpmr3_fs1_wpst;
assign Tpl_4146 = lpddr4_lpmr3_fs1_pdds;
assign Tpl_4147 = lpddr4_lpmr3_fs1_rdbi;
assign Tpl_4148 = lpddr4_lpmr3_fs1_wdbi;
assign Tpl_4149 = lpddr4_lpmr11_fs0_dqodt;
assign Tpl_4150 = lpddr4_lpmr11_fs0_caodt;
assign Tpl_4151 = lpddr4_lpmr11_fs1_dqodt;
assign Tpl_4152 = lpddr4_lpmr11_fs1_caodt;
assign Tpl_4153 = lpddr4_lpmr11_nt_fs0_dqodt;
assign Tpl_4154 = lpddr4_lpmr11_nt_fs0_caodt;
assign Tpl_4155 = lpddr4_lpmr11_nt_fs1_dqodt;
assign Tpl_4156 = lpddr4_lpmr11_nt_fs1_caodt;
assign Tpl_4157 = lpddr4_lpmr12_fs0_vrefcas;
assign Tpl_4158 = lpddr4_lpmr12_fs0_vrefcar;
assign Tpl_4159 = lpddr4_lpmr12_fs1_vrefcas;
assign Tpl_4160 = lpddr4_lpmr12_fs1_vrefcar;
assign Tpl_4161 = lpddr4_lpmr13_cbt;
assign Tpl_4162 = lpddr4_lpmr13_rpt;
assign Tpl_4163 = lpddr4_lpmr13_vro;
assign Tpl_4164 = lpddr4_lpmr13_vrcg;
assign Tpl_4165 = lpddr4_lpmr13_rro;
assign Tpl_4166 = lpddr4_lpmr13_dmd;
assign Tpl_4167 = lpddr4_lpmr13_fspwr;
assign Tpl_4168 = lpddr4_lpmr13_fspop;
assign Tpl_4169 = lpddr4_lpmr14_fs0_vrefdqs;
assign Tpl_4170 = lpddr4_lpmr14_fs0_vrefdqr;
assign Tpl_4171 = lpddr4_lpmr14_fs1_vrefdqs;
assign Tpl_4172 = lpddr4_lpmr14_fs1_vrefdqr;
assign Tpl_4173 = lpddr4_lpmr22_fs0_socodt;
assign Tpl_4174 = lpddr4_lpmr22_fs0_odteck;
assign Tpl_4175 = lpddr4_lpmr22_fs0_odtecs;
assign Tpl_4176 = lpddr4_lpmr22_fs0_odtdca;
assign Tpl_4177 = lpddr4_lpmr22_odtdx8;
assign Tpl_4178 = lpddr4_lpmr22_fs1_socodt;
assign Tpl_4179 = lpddr4_lpmr22_fs1_odteck;
assign Tpl_4180 = lpddr4_lpmr22_fs1_odtecs;
assign Tpl_4181 = lpddr4_lpmr22_fs1_odtdca;
assign Tpl_4182 = lpddr4_lpmr22_nt_fs0_socodt;
assign Tpl_4183 = lpddr4_lpmr22_nt_fs0_odteck;
assign Tpl_4184 = lpddr4_lpmr22_nt_fs0_odtecs;
assign Tpl_4185 = lpddr4_lpmr22_nt_fs0_odtdca;
assign Tpl_4186 = lpddr4_lpmr22_nt_odtdx8;
assign Tpl_4187 = lpddr4_lpmr22_nt_fs1_socodt;
assign Tpl_4188 = lpddr4_lpmr22_nt_fs1_odteck;
assign Tpl_4189 = lpddr4_lpmr22_nt_fs1_odtecs;
assign Tpl_4190 = lpddr4_lpmr22_nt_fs1_odtdca;
assign Tpl_4191 = lpddr3_lpmr1_bl;
assign Tpl_4192 = lpddr3_lpmr1_nwr;
assign Tpl_4193 = lpddr3_lpmr2_rlwl;
assign Tpl_4194 = lpddr3_lpmr2_nwre;
assign Tpl_4195 = lpddr3_lpmr2_wls;
assign Tpl_4196 = lpddr3_lpmr2_wrlev;
assign Tpl_4197 = lpddr3_lpmr3_ds;
assign Tpl_4198 = lpddr3_lpmr10_cali_code;
assign Tpl_4199 = lpddr3_lpmr11_dqodt;
assign Tpl_4200 = lpddr3_lpmr11_pd;
assign Tpl_4201 = lpddr3_lpmr16_pasr_b;
assign Tpl_4202 = lpddr3_lpmr17_pasr_s;
assign Tpl_4203 = ddr4_mr0_wr;
assign Tpl_4204 = ddr4_mr0_dllrst;
assign Tpl_4205 = ddr4_mr0_tm;
assign Tpl_4206 = ddr4_mr0_cl;
assign Tpl_4207 = ddr4_mr0_rbt;
assign Tpl_4208 = ddr4_mr0_bl;
assign Tpl_4209 = ddr4_mr1_qoff;
assign Tpl_4210 = ddr4_mr1_tdqs;
assign Tpl_4211 = ddr4_mr1_wrlvl;
assign Tpl_4212 = ddr4_mr1_rttnom;
assign Tpl_4213 = ddr4_mr1_dic;
assign Tpl_4214 = ddr4_mr1_dllen;
assign Tpl_4215 = ddr4_mr1_al;
assign Tpl_4216 = ddr4_mr2_rttwr;
assign Tpl_4217 = ddr4_mr2_lasr;
assign Tpl_4218 = ddr4_mr2_cwl;
assign Tpl_4219 = ddr4_mr2_wrcrc;
assign Tpl_4220 = ddr4_mr3_mpro;
assign Tpl_4221 = ddr4_mr3_mprp;
assign Tpl_4222 = ddr4_mr3_gdwn;
assign Tpl_4223 = ddr4_mr3_pda;
assign Tpl_4224 = ddr4_mr3_tsr;
assign Tpl_4225 = ddr4_mr3_fgrm;
assign Tpl_4226 = ddr4_mr3_wcl;
assign Tpl_4227 = ddr4_mr3_mprf;
assign Tpl_4228 = ddr4_mr4_mpdwn;
assign Tpl_4229 = ddr4_mr4_tcrr;
assign Tpl_4230 = ddr4_mr4_tcrm;
assign Tpl_4231 = ddr4_mr4_ivref;
assign Tpl_4232 = ddr4_mr4_cal;
assign Tpl_4233 = ddr4_mr4_srab;
assign Tpl_4234 = ddr4_mr4_rptm;
assign Tpl_4235 = ddr4_mr4_rpre;
assign Tpl_4236 = ddr4_mr4_wpre;
assign Tpl_4237 = ddr4_mr5_capl;
assign Tpl_4238 = ddr4_mr5_crcec;
assign Tpl_4239 = ddr4_mr5_caps;
assign Tpl_4240 = ddr4_mr5_odtb;
assign Tpl_4241 = ddr4_mr5_rttpk;
assign Tpl_4242 = ddr4_mr5_cappe;
assign Tpl_4243 = ddr4_mr5_dm;
assign Tpl_4244 = ddr4_mr5_wdbi;
assign Tpl_4245 = ddr4_mr5_rdbi;
assign Tpl_4246 = ddr4_mr6_vrefdq;
assign Tpl_4247 = ddr4_mr6_vrefdqr;
assign Tpl_4248 = ddr4_mr6_vrefdqe;
assign Tpl_4249 = ddr4_mr6_ccdl;
assign Tpl_4250 = ddr3_mr0_ppd;
assign Tpl_4251 = ddr3_mr0_wr;
assign Tpl_4252 = ddr3_mr0_dllrst;
assign Tpl_4253 = ddr3_mr0_tm;
assign Tpl_4254 = ddr3_mr0_cl;
assign Tpl_4255 = ddr3_mr0_rbt;
assign Tpl_4256 = ddr3_mr0_bl;
assign Tpl_4257 = ddr3_mr1_qoff;
assign Tpl_4258 = ddr3_mr1_tdqs;
assign Tpl_4259 = ddr3_mr1_wrlvl;
assign Tpl_4260 = ddr3_mr1_rttnom;
assign Tpl_4261 = ddr3_mr1_dic;
assign Tpl_4262 = ddr3_mr1_dllen;
assign Tpl_4263 = ddr3_mr1_al;
assign Tpl_4264 = ddr3_mr2_rttwr;
assign Tpl_4265 = ddr3_mr2_srt;
assign Tpl_4266 = ddr3_mr2_lasr;
assign Tpl_4267 = ddr3_mr2_cwl;
assign Tpl_4268 = ddr3_mr2_pasr;
assign Tpl_4269 = ddr3_mr3_mpro;
assign Tpl_4270 = ddr3_mr3_mprp;
assign Tpl_4271 = rtcfg0_rt0_ext_pri;
assign Tpl_4272 = rtcfg0_rt0_max_pri;
assign Tpl_4273 = rtcfg0_rt0_arq_lvl_hi;
assign Tpl_4274 = rtcfg0_rt0_arq_lvl_lo;
assign Tpl_4275 = rtcfg0_rt0_awq_lvl_hi;
assign Tpl_4276 = rtcfg0_rt0_awq_lvl_lo;
assign Tpl_4277 = rtcfg0_rt0_arq_lat_barrier_en;
assign Tpl_4278 = rtcfg0_rt0_awq_lat_barrier_en;
assign Tpl_4279 = rtcfg0_rt0_arq_ooo_en;
assign Tpl_4280 = rtcfg0_rt0_awq_ooo_en;
assign Tpl_4281 = rtcfg0_rt0_acq_realtime_en;
assign Tpl_4282 = rtcfg0_rt0_wm_enable;
assign Tpl_4283 = rtcfg0_rt0_arq_lahead_en;
assign Tpl_4284 = rtcfg0_rt0_awq_lahead_en;
assign Tpl_4285 = rtcfg0_rt0_narrow_mode;
assign Tpl_4286 = rtcfg0_rt0_narrow_size;
assign Tpl_4287 = rtcfg0_rt1_ext_pri;
assign Tpl_4288 = rtcfg0_rt1_max_pri;
assign Tpl_4289 = rtcfg0_rt1_arq_lvl_hi;
assign Tpl_4290 = rtcfg0_rt1_arq_lvl_lo;
assign Tpl_4291 = rtcfg0_rt1_awq_lvl_hi;
assign Tpl_4292 = rtcfg0_rt1_awq_lvl_lo;
assign Tpl_4293 = rtcfg0_rt1_arq_lat_barrier_en;
assign Tpl_4294 = rtcfg0_rt1_awq_lat_barrier_en;
assign Tpl_4295 = rtcfg0_rt1_arq_ooo_en;
assign Tpl_4296 = rtcfg0_rt1_awq_ooo_en;
assign Tpl_4297 = rtcfg0_rt1_acq_realtime_en;
assign Tpl_4298 = rtcfg0_rt1_wm_enable;
assign Tpl_4299 = rtcfg0_rt1_arq_lahead_en;
assign Tpl_4300 = rtcfg0_rt1_awq_lahead_en;
assign Tpl_4301 = rtcfg0_rt1_narrow_mode;
assign Tpl_4302 = rtcfg0_rt1_narrow_size;
assign Tpl_4303 = rtcfg0_rt2_ext_pri;
assign Tpl_4304 = rtcfg0_rt2_max_pri;
assign Tpl_4305 = rtcfg0_rt2_arq_lvl_hi;
assign Tpl_4306 = rtcfg0_rt2_arq_lvl_lo;
assign Tpl_4307 = rtcfg0_rt2_awq_lvl_hi;
assign Tpl_4308 = rtcfg0_rt2_awq_lvl_lo;
assign Tpl_4309 = rtcfg0_rt2_arq_lat_barrier_en;
assign Tpl_4310 = rtcfg0_rt2_awq_lat_barrier_en;
assign Tpl_4311 = rtcfg0_rt2_arq_ooo_en;
assign Tpl_4312 = rtcfg0_rt2_awq_ooo_en;
assign Tpl_4313 = rtcfg0_rt2_acq_realtime_en;
assign Tpl_4314 = rtcfg0_rt2_wm_enable;
assign Tpl_4315 = rtcfg0_rt2_arq_lahead_en;
assign Tpl_4316 = rtcfg0_rt2_awq_lahead_en;
assign Tpl_4317 = rtcfg0_rt2_narrow_mode;
assign Tpl_4318 = rtcfg0_rt2_narrow_size;
assign Tpl_4319 = rtcfg0_rt3_ext_pri;
assign Tpl_4320 = rtcfg0_rt3_max_pri;
assign Tpl_4321 = rtcfg0_rt3_arq_lvl_hi;
assign Tpl_4322 = rtcfg0_rt3_arq_lvl_lo;
assign Tpl_4323 = rtcfg0_rt3_awq_lvl_hi;
assign Tpl_4324 = rtcfg0_rt3_awq_lvl_lo;
assign Tpl_4325 = rtcfg0_rt3_arq_lat_barrier_en;
assign Tpl_4326 = rtcfg0_rt3_awq_lat_barrier_en;
assign Tpl_4327 = rtcfg0_rt3_arq_ooo_en;
assign Tpl_4328 = rtcfg0_rt3_awq_ooo_en;
assign Tpl_4329 = rtcfg0_rt3_acq_realtime_en;
assign Tpl_4330 = rtcfg0_rt3_wm_enable;
assign Tpl_4331 = rtcfg0_rt3_arq_lahead_en;
assign Tpl_4332 = rtcfg0_rt3_awq_lahead_en;
assign Tpl_4333 = rtcfg0_rt3_narrow_mode;
assign Tpl_4334 = rtcfg0_rt3_narrow_size;
assign Tpl_4335 = rtcfg1_rt0_arq_lat_barrier;
assign Tpl_4336 = rtcfg1_rt0_awq_lat_barrier;
assign Tpl_4337 = rtcfg1_rt0_arq_starv_th;
assign Tpl_4338 = rtcfg1_rt0_awq_starv_th;
assign Tpl_4339 = rtcfg1_rt1_arq_lat_barrier;
assign Tpl_4340 = rtcfg1_rt1_awq_lat_barrier;
assign Tpl_4341 = rtcfg1_rt1_arq_starv_th;
assign Tpl_4342 = rtcfg1_rt1_awq_starv_th;
assign Tpl_4343 = rtcfg1_rt2_arq_lat_barrier;
assign Tpl_4344 = rtcfg1_rt2_awq_lat_barrier;
assign Tpl_4345 = rtcfg1_rt2_arq_starv_th;
assign Tpl_4346 = rtcfg1_rt2_awq_starv_th;
assign Tpl_4347 = rtcfg1_rt3_arq_lat_barrier;
assign Tpl_4348 = rtcfg1_rt3_awq_lat_barrier;
assign Tpl_4349 = rtcfg1_rt3_arq_starv_th;
assign Tpl_4350 = rtcfg1_rt3_awq_starv_th;
assign Tpl_4351 = rtcfg2_rt0_size_max;
assign Tpl_4352 = rtcfg2_rt1_size_max;
assign Tpl_4353 = rtcfg2_rt2_size_max;
assign Tpl_4354 = rtcfg2_rt3_size_max;
assign Tpl_4355 = addr0_col_addr_map_b0;
assign Tpl_4356 = addr0_col_addr_map_b1;
assign Tpl_4357 = addr0_col_addr_map_b2;
assign Tpl_4358 = addr0_col_addr_map_b3;
assign Tpl_4359 = addr0_col_addr_map_b4;
assign Tpl_4360 = addr0_col_addr_map_b5;
assign Tpl_4361 = addr1_col_addr_map_b6;
assign Tpl_4362 = addr1_col_addr_map_b7;
assign Tpl_4363 = addr1_col_addr_map_b8;
assign Tpl_4364 = addr1_col_addr_map_b9;
assign Tpl_4365 = addr1_col_addr_map_b10;
assign Tpl_4366 = addr2_row_addr_map_b0;
assign Tpl_4367 = addr2_row_addr_map_b1;
assign Tpl_4368 = addr2_row_addr_map_b2;
assign Tpl_4369 = addr2_row_addr_map_b3;
assign Tpl_4370 = addr2_row_addr_map_b4;
assign Tpl_4371 = addr2_row_addr_map_b5;
assign Tpl_4372 = addr3_row_addr_map_b6;
assign Tpl_4373 = addr3_row_addr_map_b7;
assign Tpl_4374 = addr3_row_addr_map_b8;
assign Tpl_4375 = addr3_row_addr_map_b9;
assign Tpl_4376 = addr3_row_addr_map_b10;
assign Tpl_4377 = addr3_row_addr_map_b11;
assign Tpl_4378 = addr4_row_addr_map_b12;
assign Tpl_4379 = addr4_row_addr_map_b13;
assign Tpl_4380 = addr4_row_addr_map_b14;
assign Tpl_4381 = addr4_row_addr_map_b15;
assign Tpl_4382 = addr4_row_addr_map_b16;
assign Tpl_4383 = addr5_bank_addr_map_b0;
assign Tpl_4384 = addr5_bank_addr_map_b1;
assign Tpl_4385 = addr5_bank_addr_map_b2;
assign Tpl_4386 = addr5_bank_addr_map_b3;
assign Tpl_4387 = addr5_rank_addr_map_b0;
assign Tpl_4388 = addr5_chan_addr_map_b0;
assign Tpl_4389 = dllctlca_ch0_limit;
assign Tpl_4390 = dllctlca_ch0_en;
assign Tpl_4391 = dllctlca_ch0_upd;
assign Tpl_4392 = dllctlca_ch0_byp;
assign Tpl_4393 = dllctlca_ch0_bypc;
assign Tpl_4394 = dllctlca_ch0_clkdly;
assign Tpl_4395 = dllctlca_ch1_limit;
assign Tpl_4396 = dllctlca_ch1_en;
assign Tpl_4397 = dllctlca_ch1_upd;
assign Tpl_4398 = dllctlca_ch1_byp;
assign Tpl_4399 = dllctlca_ch1_bypc;
assign Tpl_4400 = dllctlca_ch1_clkdly;
assign Tpl_4401 = dllctldq_sl0_limit;
assign Tpl_4402 = dllctldq_sl0_en;
assign Tpl_4403 = dllctldq_sl0_upd;
assign Tpl_4404 = dllctldq_sl0_byp;
assign Tpl_4405 = dllctldq_sl0_bypc;
assign Tpl_4406 = dllctldq_sl1_limit;
assign Tpl_4407 = dllctldq_sl1_en;
assign Tpl_4408 = dllctldq_sl1_upd;
assign Tpl_4409 = dllctldq_sl1_byp;
assign Tpl_4410 = dllctldq_sl1_bypc;
assign Tpl_4411 = dllctldq_sl2_limit;
assign Tpl_4412 = dllctldq_sl2_en;
assign Tpl_4413 = dllctldq_sl2_upd;
assign Tpl_4414 = dllctldq_sl2_byp;
assign Tpl_4415 = dllctldq_sl2_bypc;
assign Tpl_4416 = dllctldq_sl3_limit;
assign Tpl_4417 = dllctldq_sl3_en;
assign Tpl_4418 = dllctldq_sl3_upd;
assign Tpl_4419 = dllctldq_sl3_byp;
assign Tpl_4420 = dllctldq_sl3_bypc;
assign Tpl_4421 = pbcr_vrefenca_c0;
assign Tpl_4422 = pbcr_vrefsetca_c0;
assign Tpl_4423 = pbcr_vrefenca_c1;
assign Tpl_4424 = pbcr_vrefsetca_c1;
assign Tpl_4425 = cior0_ch0_drvsel;
assign Tpl_4426 = cior0_ch0_cmos_en;
assign Tpl_4427 = cior0_ch1_drvsel;
assign Tpl_4428 = cior0_ch1_cmos_en;
assign Tpl_4429 = cior1_odis_clk;
assign Tpl_4430 = cior1_odis_ctl;
assign Tpl_4431 = dior_sl0_drvsel;
assign Tpl_4432 = dior_sl0_cmos_en;
assign Tpl_4433 = dior_sl0_fena_rcv;
assign Tpl_4434 = dior_sl0_rtt_en;
assign Tpl_4435 = dior_sl0_rtt_sel;
assign Tpl_4436 = dior_sl0_odis_dq;
assign Tpl_4437 = dior_sl0_odis_dm;
assign Tpl_4438 = dior_sl0_odis_dqs;
assign Tpl_4439 = dior_sl1_drvsel;
assign Tpl_4440 = dior_sl1_cmos_en;
assign Tpl_4441 = dior_sl1_fena_rcv;
assign Tpl_4442 = dior_sl1_rtt_en;
assign Tpl_4443 = dior_sl1_rtt_sel;
assign Tpl_4444 = dior_sl1_odis_dq;
assign Tpl_4445 = dior_sl1_odis_dm;
assign Tpl_4446 = dior_sl1_odis_dqs;
assign Tpl_4447 = dior_sl2_drvsel;
assign Tpl_4448 = dior_sl2_cmos_en;
assign Tpl_4449 = dior_sl2_fena_rcv;
assign Tpl_4450 = dior_sl2_rtt_en;
assign Tpl_4451 = dior_sl2_rtt_sel;
assign Tpl_4452 = dior_sl2_odis_dq;
assign Tpl_4453 = dior_sl2_odis_dm;
assign Tpl_4454 = dior_sl2_odis_dqs;
assign Tpl_4455 = dior_sl3_drvsel;
assign Tpl_4456 = dior_sl3_cmos_en;
assign Tpl_4457 = dior_sl3_fena_rcv;
assign Tpl_4458 = dior_sl3_rtt_en;
assign Tpl_4459 = dior_sl3_rtt_sel;
assign Tpl_4460 = dior_sl3_odis_dq;
assign Tpl_4461 = dior_sl3_odis_dm;
assign Tpl_4462 = dior_sl3_odis_dqs;
assign Tpl_4463 = ptsr0_r0_vrefcar;
assign ptsr0_r0_vrefcar_ip = Tpl_4464;
assign Tpl_4465 = ptsr0_r0_vrefcas;
assign ptsr0_r0_vrefcas_ip = Tpl_4466;
assign Tpl_4467 = ptsr0_r0_vrefdqwrr;
assign ptsr0_r0_vrefdqwrr_ip = Tpl_4468;
assign Tpl_4469 = ptsr0_r0_vrefdqwrs;
assign ptsr0_r0_vrefdqwrs_ip = Tpl_4470;
assign Tpl_4471 = ptsr1_r0_csc0;
assign ptsr1_r0_csc0_ip = Tpl_4472;
assign Tpl_4473 = ptsr1_r0_csc1;
assign ptsr1_r0_csc1_ip = Tpl_4474;
assign Tpl_4475 = ptsr1_r0_cac0b0;
assign ptsr1_r0_cac0b0_ip = Tpl_4476;
assign Tpl_4477 = ptsr1_r0_cac0b1;
assign ptsr1_r0_cac0b1_ip = Tpl_4478;
assign Tpl_4479 = ptsr2_r0_cac0b2;
assign ptsr2_r0_cac0b2_ip = Tpl_4480;
assign Tpl_4481 = ptsr2_r0_cac0b3;
assign ptsr2_r0_cac0b3_ip = Tpl_4482;
assign Tpl_4483 = ptsr2_r0_cac0b4;
assign ptsr2_r0_cac0b4_ip = Tpl_4484;
assign Tpl_4485 = ptsr2_r0_cac0b5;
assign ptsr2_r0_cac0b5_ip = Tpl_4486;
assign Tpl_4487 = ptsr3_r0_cac0b6;
assign ptsr3_r0_cac0b6_ip = Tpl_4488;
assign Tpl_4489 = ptsr3_r0_cac0b7;
assign ptsr3_r0_cac0b7_ip = Tpl_4490;
assign Tpl_4491 = ptsr3_r0_cac0b8;
assign ptsr3_r0_cac0b8_ip = Tpl_4492;
assign Tpl_4493 = ptsr3_r0_cac0b9;
assign ptsr3_r0_cac0b9_ip = Tpl_4494;
assign Tpl_4495 = ptsr4_r0_cac0b10;
assign ptsr4_r0_cac0b10_ip = Tpl_4496;
assign Tpl_4497 = ptsr4_r0_cac0b11;
assign ptsr4_r0_cac0b11_ip = Tpl_4498;
assign Tpl_4499 = ptsr4_r0_cac0b12;
assign ptsr4_r0_cac0b12_ip = Tpl_4500;
assign Tpl_4501 = ptsr4_r0_cac0b13;
assign ptsr4_r0_cac0b13_ip = Tpl_4502;
assign Tpl_4503 = ptsr5_r0_cac0b14;
assign ptsr5_r0_cac0b14_ip = Tpl_4504;
assign Tpl_4505 = ptsr5_r0_cac0b15;
assign ptsr5_r0_cac0b15_ip = Tpl_4506;
assign Tpl_4507 = ptsr5_r0_cac0b16;
assign ptsr5_r0_cac0b16_ip = Tpl_4508;
assign Tpl_4509 = ptsr5_r0_cac0b17;
assign ptsr5_r0_cac0b17_ip = Tpl_4510;
assign Tpl_4511 = ptsr6_r0_cac0b18;
assign ptsr6_r0_cac0b18_ip = Tpl_4512;
assign Tpl_4513 = ptsr6_r0_cac1b0;
assign ptsr6_r0_cac1b0_ip = Tpl_4514;
assign Tpl_4515 = ptsr6_r0_cac1b1;
assign ptsr6_r0_cac1b1_ip = Tpl_4516;
assign Tpl_4517 = ptsr6_r0_cac1b2;
assign ptsr6_r0_cac1b2_ip = Tpl_4518;
assign Tpl_4519 = ptsr7_r0_cac1b3;
assign ptsr7_r0_cac1b3_ip = Tpl_4520;
assign Tpl_4521 = ptsr7_r0_cac1b4;
assign ptsr7_r0_cac1b4_ip = Tpl_4522;
assign Tpl_4523 = ptsr7_r0_cac1b5;
assign ptsr7_r0_cac1b5_ip = Tpl_4524;
assign Tpl_4525 = ptsr7_r0_cac1b6;
assign ptsr7_r0_cac1b6_ip = Tpl_4526;
assign Tpl_4527 = ptsr8_r0_cac1b7;
assign ptsr8_r0_cac1b7_ip = Tpl_4528;
assign Tpl_4529 = ptsr8_r0_cac1b8;
assign ptsr8_r0_cac1b8_ip = Tpl_4530;
assign Tpl_4531 = ptsr8_r0_cac1b9;
assign ptsr8_r0_cac1b9_ip = Tpl_4532;
assign Tpl_4533 = ptsr8_r0_cac1b10;
assign ptsr8_r0_cac1b10_ip = Tpl_4534;
assign Tpl_4535 = ptsr9_r0_cac1b11;
assign ptsr9_r0_cac1b11_ip = Tpl_4536;
assign Tpl_4537 = ptsr9_r0_cac1b12;
assign ptsr9_r0_cac1b12_ip = Tpl_4538;
assign Tpl_4539 = ptsr9_r0_cac1b13;
assign ptsr9_r0_cac1b13_ip = Tpl_4540;
assign Tpl_4541 = ptsr9_r0_cac1b14;
assign ptsr9_r0_cac1b14_ip = Tpl_4542;
assign Tpl_4543 = ptsr10_r0_cac1b15;
assign ptsr10_r0_cac1b15_ip = Tpl_4544;
assign Tpl_4545 = ptsr10_r0_cac1b16;
assign ptsr10_r0_cac1b16_ip = Tpl_4546;
assign Tpl_4547 = ptsr10_r0_cac1b17;
assign ptsr10_r0_cac1b17_ip = Tpl_4548;
assign Tpl_4549 = ptsr10_r0_cac1b18;
assign ptsr10_r0_cac1b18_ip = Tpl_4550;
assign Tpl_4551 = ptsr11_r0_bac0b0;
assign Tpl_4552 = ptsr11_r0_bac0b1;
assign Tpl_4553 = ptsr11_r0_bac0b2;
assign Tpl_4554 = ptsr11_r0_bac0b3;
assign Tpl_4555 = ptsr12_r0_bac1b0;
assign Tpl_4556 = ptsr12_r0_bac1b1;
assign Tpl_4557 = ptsr12_r0_bac1b2;
assign Tpl_4558 = ptsr12_r0_bac1b3;
assign Tpl_4559 = ptsr13_r0_actnc0;
assign Tpl_4560 = ptsr13_r0_actnc1;
assign Tpl_4561 = ptsr13_r0_ckec0;
assign Tpl_4562 = ptsr13_r0_ckec1;
assign Tpl_4563 = ptsr14_r0_gts0;
assign ptsr14_r0_gts0_ip = Tpl_4564;
assign Tpl_4565 = ptsr14_r0_gts1;
assign ptsr14_r0_gts1_ip = Tpl_4566;
assign Tpl_4567 = ptsr14_r0_gts2;
assign ptsr14_r0_gts2_ip = Tpl_4568;
assign Tpl_4569 = ptsr14_r0_gts3;
assign ptsr14_r0_gts3_ip = Tpl_4570;
assign Tpl_4571 = ptsr15_r0_wrlvls0;
assign ptsr15_r0_wrlvls0_ip = Tpl_4572;
assign Tpl_4573 = ptsr15_r0_wrlvls1;
assign ptsr15_r0_wrlvls1_ip = Tpl_4574;
assign Tpl_4575 = ptsr15_r0_wrlvls2;
assign ptsr15_r0_wrlvls2_ip = Tpl_4576;
assign Tpl_4577 = ptsr15_r0_wrlvls3;
assign ptsr15_r0_wrlvls3_ip = Tpl_4578;
assign Tpl_4579 = ptsr16_r0_dqsdqs0b0;
assign ptsr16_r0_dqsdqs0b0_ip = Tpl_4580;
assign Tpl_4581 = ptsr16_r0_dqsdqs0b1;
assign ptsr16_r0_dqsdqs0b1_ip = Tpl_4582;
assign Tpl_4583 = ptsr16_r0_dqsdqs0b2;
assign ptsr16_r0_dqsdqs0b2_ip = Tpl_4584;
assign Tpl_4585 = ptsr16_r0_dqsdqs0b3;
assign ptsr16_r0_dqsdqs0b3_ip = Tpl_4586;
assign Tpl_4587 = ptsr17_r0_dqsdqs0b4;
assign ptsr17_r0_dqsdqs0b4_ip = Tpl_4588;
assign Tpl_4589 = ptsr17_r0_dqsdqs0b5;
assign ptsr17_r0_dqsdqs0b5_ip = Tpl_4590;
assign Tpl_4591 = ptsr17_r0_dqsdqs0b6;
assign ptsr17_r0_dqsdqs0b6_ip = Tpl_4592;
assign Tpl_4593 = ptsr17_r0_dqsdqs0b7;
assign ptsr17_r0_dqsdqs0b7_ip = Tpl_4594;
assign Tpl_4595 = ptsr18_r0_dqsdqs1b0;
assign ptsr18_r0_dqsdqs1b0_ip = Tpl_4596;
assign Tpl_4597 = ptsr18_r0_dqsdqs1b1;
assign ptsr18_r0_dqsdqs1b1_ip = Tpl_4598;
assign Tpl_4599 = ptsr18_r0_dqsdqs1b2;
assign ptsr18_r0_dqsdqs1b2_ip = Tpl_4600;
assign Tpl_4601 = ptsr18_r0_dqsdqs1b3;
assign ptsr18_r0_dqsdqs1b3_ip = Tpl_4602;
assign Tpl_4603 = ptsr19_r0_dqsdqs1b4;
assign ptsr19_r0_dqsdqs1b4_ip = Tpl_4604;
assign Tpl_4605 = ptsr19_r0_dqsdqs1b5;
assign ptsr19_r0_dqsdqs1b5_ip = Tpl_4606;
assign Tpl_4607 = ptsr19_r0_dqsdqs1b6;
assign ptsr19_r0_dqsdqs1b6_ip = Tpl_4608;
assign Tpl_4609 = ptsr19_r0_dqsdqs1b7;
assign ptsr19_r0_dqsdqs1b7_ip = Tpl_4610;
assign Tpl_4611 = ptsr20_r0_dqsdqs2b0;
assign ptsr20_r0_dqsdqs2b0_ip = Tpl_4612;
assign Tpl_4613 = ptsr20_r0_dqsdqs2b1;
assign ptsr20_r0_dqsdqs2b1_ip = Tpl_4614;
assign Tpl_4615 = ptsr20_r0_dqsdqs2b2;
assign ptsr20_r0_dqsdqs2b2_ip = Tpl_4616;
assign Tpl_4617 = ptsr20_r0_dqsdqs2b3;
assign ptsr20_r0_dqsdqs2b3_ip = Tpl_4618;
assign Tpl_4619 = ptsr21_r0_dqsdqs2b4;
assign ptsr21_r0_dqsdqs2b4_ip = Tpl_4620;
assign Tpl_4621 = ptsr21_r0_dqsdqs2b5;
assign ptsr21_r0_dqsdqs2b5_ip = Tpl_4622;
assign Tpl_4623 = ptsr21_r0_dqsdqs2b6;
assign ptsr21_r0_dqsdqs2b6_ip = Tpl_4624;
assign Tpl_4625 = ptsr21_r0_dqsdqs2b7;
assign ptsr21_r0_dqsdqs2b7_ip = Tpl_4626;
assign Tpl_4627 = ptsr22_r0_dqsdqs3b0;
assign ptsr22_r0_dqsdqs3b0_ip = Tpl_4628;
assign Tpl_4629 = ptsr22_r0_dqsdqs3b1;
assign ptsr22_r0_dqsdqs3b1_ip = Tpl_4630;
assign Tpl_4631 = ptsr22_r0_dqsdqs3b2;
assign ptsr22_r0_dqsdqs3b2_ip = Tpl_4632;
assign Tpl_4633 = ptsr22_r0_dqsdqs3b3;
assign ptsr22_r0_dqsdqs3b3_ip = Tpl_4634;
assign Tpl_4635 = ptsr23_r0_dqsdqs3b4;
assign ptsr23_r0_dqsdqs3b4_ip = Tpl_4636;
assign Tpl_4637 = ptsr23_r0_dqsdqs3b5;
assign ptsr23_r0_dqsdqs3b5_ip = Tpl_4638;
assign Tpl_4639 = ptsr23_r0_dqsdqs3b6;
assign ptsr23_r0_dqsdqs3b6_ip = Tpl_4640;
assign Tpl_4641 = ptsr23_r0_dqsdqs3b7;
assign ptsr23_r0_dqsdqs3b7_ip = Tpl_4642;
assign Tpl_4643 = ptsr24_r0_dqsdms0;
assign ptsr24_r0_dqsdms0_ip = Tpl_4644;
assign Tpl_4645 = ptsr24_r0_dqsdms1;
assign ptsr24_r0_dqsdms1_ip = Tpl_4646;
assign Tpl_4647 = ptsr24_r0_dqsdms2;
assign ptsr24_r0_dqsdms2_ip = Tpl_4648;
assign Tpl_4649 = ptsr24_r0_dqsdms3;
assign ptsr24_r0_dqsdms3_ip = Tpl_4650;
assign Tpl_4651 = ptsr25_r0_rdlvldqs0b0;
assign ptsr25_r0_rdlvldqs0b0_ip = Tpl_4652;
assign Tpl_4653 = ptsr25_r0_rdlvldqs0b1;
assign ptsr25_r0_rdlvldqs0b1_ip = Tpl_4654;
assign Tpl_4655 = ptsr25_r0_rdlvldqs0b2;
assign ptsr25_r0_rdlvldqs0b2_ip = Tpl_4656;
assign Tpl_4657 = ptsr25_r0_rdlvldqs0b3;
assign ptsr25_r0_rdlvldqs0b3_ip = Tpl_4658;
assign Tpl_4659 = ptsr26_r0_rdlvldqs0b4;
assign ptsr26_r0_rdlvldqs0b4_ip = Tpl_4660;
assign Tpl_4661 = ptsr26_r0_rdlvldqs0b5;
assign ptsr26_r0_rdlvldqs0b5_ip = Tpl_4662;
assign Tpl_4663 = ptsr26_r0_rdlvldqs0b6;
assign ptsr26_r0_rdlvldqs0b6_ip = Tpl_4664;
assign Tpl_4665 = ptsr26_r0_rdlvldqs0b7;
assign ptsr26_r0_rdlvldqs0b7_ip = Tpl_4666;
assign Tpl_4667 = ptsr27_r0_rdlvldqs1b0;
assign ptsr27_r0_rdlvldqs1b0_ip = Tpl_4668;
assign Tpl_4669 = ptsr27_r0_rdlvldqs1b1;
assign ptsr27_r0_rdlvldqs1b1_ip = Tpl_4670;
assign Tpl_4671 = ptsr27_r0_rdlvldqs1b2;
assign ptsr27_r0_rdlvldqs1b2_ip = Tpl_4672;
assign Tpl_4673 = ptsr27_r0_rdlvldqs1b3;
assign ptsr27_r0_rdlvldqs1b3_ip = Tpl_4674;
assign Tpl_4675 = ptsr28_r0_rdlvldqs1b4;
assign ptsr28_r0_rdlvldqs1b4_ip = Tpl_4676;
assign Tpl_4677 = ptsr28_r0_rdlvldqs1b5;
assign ptsr28_r0_rdlvldqs1b5_ip = Tpl_4678;
assign Tpl_4679 = ptsr28_r0_rdlvldqs1b6;
assign ptsr28_r0_rdlvldqs1b6_ip = Tpl_4680;
assign Tpl_4681 = ptsr28_r0_rdlvldqs1b7;
assign ptsr28_r0_rdlvldqs1b7_ip = Tpl_4682;
assign Tpl_4683 = ptsr29_r0_rdlvldqs2b0;
assign ptsr29_r0_rdlvldqs2b0_ip = Tpl_4684;
assign Tpl_4685 = ptsr29_r0_rdlvldqs2b1;
assign ptsr29_r0_rdlvldqs2b1_ip = Tpl_4686;
assign Tpl_4687 = ptsr29_r0_rdlvldqs2b2;
assign ptsr29_r0_rdlvldqs2b2_ip = Tpl_4688;
assign Tpl_4689 = ptsr29_r0_rdlvldqs2b3;
assign ptsr29_r0_rdlvldqs2b3_ip = Tpl_4690;
assign Tpl_4691 = ptsr30_r0_rdlvldqs2b4;
assign ptsr30_r0_rdlvldqs2b4_ip = Tpl_4692;
assign Tpl_4693 = ptsr30_r0_rdlvldqs2b5;
assign ptsr30_r0_rdlvldqs2b5_ip = Tpl_4694;
assign Tpl_4695 = ptsr30_r0_rdlvldqs2b6;
assign ptsr30_r0_rdlvldqs2b6_ip = Tpl_4696;
assign Tpl_4697 = ptsr30_r0_rdlvldqs2b7;
assign ptsr30_r0_rdlvldqs2b7_ip = Tpl_4698;
assign Tpl_4699 = ptsr31_r0_rdlvldqs3b0;
assign ptsr31_r0_rdlvldqs3b0_ip = Tpl_4700;
assign Tpl_4701 = ptsr31_r0_rdlvldqs3b1;
assign ptsr31_r0_rdlvldqs3b1_ip = Tpl_4702;
assign Tpl_4703 = ptsr31_r0_rdlvldqs3b2;
assign ptsr31_r0_rdlvldqs3b2_ip = Tpl_4704;
assign Tpl_4705 = ptsr31_r0_rdlvldqs3b3;
assign ptsr31_r0_rdlvldqs3b3_ip = Tpl_4706;
assign Tpl_4707 = ptsr32_r0_rdlvldqs3b4;
assign ptsr32_r0_rdlvldqs3b4_ip = Tpl_4708;
assign Tpl_4709 = ptsr32_r0_rdlvldqs3b5;
assign ptsr32_r0_rdlvldqs3b5_ip = Tpl_4710;
assign Tpl_4711 = ptsr32_r0_rdlvldqs3b6;
assign ptsr32_r0_rdlvldqs3b6_ip = Tpl_4712;
assign Tpl_4713 = ptsr32_r0_rdlvldqs3b7;
assign ptsr32_r0_rdlvldqs3b7_ip = Tpl_4714;
assign Tpl_4715 = ptsr33_r0_rdlvldms0;
assign ptsr33_r0_rdlvldms0_ip = Tpl_4716;
assign Tpl_4717 = ptsr33_r0_rdlvldms1;
assign ptsr33_r0_rdlvldms1_ip = Tpl_4718;
assign Tpl_4719 = ptsr33_r0_rdlvldms2;
assign ptsr33_r0_rdlvldms2_ip = Tpl_4720;
assign Tpl_4721 = ptsr33_r0_rdlvldms3;
assign ptsr33_r0_rdlvldms3_ip = Tpl_4722;
assign Tpl_4723 = ptsr34_r0_vrefdqrds0;
assign ptsr34_r0_vrefdqrds0_ip = Tpl_4724;
assign Tpl_4725 = ptsr34_r0_vrefdqrds1;
assign ptsr34_r0_vrefdqrds1_ip = Tpl_4726;
assign Tpl_4727 = ptsr34_r0_vrefdqrds2;
assign ptsr34_r0_vrefdqrds2_ip = Tpl_4728;
assign Tpl_4729 = ptsr34_r0_vrefdqrds3;
assign ptsr34_r0_vrefdqrds3_ip = Tpl_4730;
assign Tpl_4731 = ptsr34_r0_vrefdqrdr;
assign ptsr34_r0_vrefdqrdr_ip = Tpl_4732;
assign Tpl_4733 = ptsr35_r1_vrefcar;
assign ptsr35_r1_vrefcar_ip = Tpl_4734;
assign Tpl_4735 = ptsr35_r1_vrefcas;
assign ptsr35_r1_vrefcas_ip = Tpl_4736;
assign Tpl_4737 = ptsr35_r1_vrefdqwrr;
assign ptsr35_r1_vrefdqwrr_ip = Tpl_4738;
assign Tpl_4739 = ptsr35_r1_vrefdqwrs;
assign ptsr35_r1_vrefdqwrs_ip = Tpl_4740;
assign Tpl_4741 = ptsr36_r1_csc0;
assign ptsr36_r1_csc0_ip = Tpl_4742;
assign Tpl_4743 = ptsr36_r1_csc1;
assign ptsr36_r1_csc1_ip = Tpl_4744;
assign Tpl_4745 = ptsr36_r1_cac0b0;
assign ptsr36_r1_cac0b0_ip = Tpl_4746;
assign Tpl_4747 = ptsr36_r1_cac0b1;
assign ptsr36_r1_cac0b1_ip = Tpl_4748;
assign Tpl_4749 = ptsr37_r1_cac0b2;
assign ptsr37_r1_cac0b2_ip = Tpl_4750;
assign Tpl_4751 = ptsr37_r1_cac0b3;
assign ptsr37_r1_cac0b3_ip = Tpl_4752;
assign Tpl_4753 = ptsr37_r1_cac0b4;
assign ptsr37_r1_cac0b4_ip = Tpl_4754;
assign Tpl_4755 = ptsr37_r1_cac0b5;
assign ptsr37_r1_cac0b5_ip = Tpl_4756;
assign Tpl_4757 = ptsr38_r1_cac0b6;
assign ptsr38_r1_cac0b6_ip = Tpl_4758;
assign Tpl_4759 = ptsr38_r1_cac0b7;
assign ptsr38_r1_cac0b7_ip = Tpl_4760;
assign Tpl_4761 = ptsr38_r1_cac0b8;
assign ptsr38_r1_cac0b8_ip = Tpl_4762;
assign Tpl_4763 = ptsr38_r1_cac0b9;
assign ptsr38_r1_cac0b9_ip = Tpl_4764;
assign Tpl_4765 = ptsr39_r1_cac0b10;
assign ptsr39_r1_cac0b10_ip = Tpl_4766;
assign Tpl_4767 = ptsr39_r1_cac0b11;
assign ptsr39_r1_cac0b11_ip = Tpl_4768;
assign Tpl_4769 = ptsr39_r1_cac0b12;
assign ptsr39_r1_cac0b12_ip = Tpl_4770;
assign Tpl_4771 = ptsr39_r1_cac0b13;
assign ptsr39_r1_cac0b13_ip = Tpl_4772;
assign Tpl_4773 = ptsr40_r1_cac0b14;
assign ptsr40_r1_cac0b14_ip = Tpl_4774;
assign Tpl_4775 = ptsr40_r1_cac0b15;
assign ptsr40_r1_cac0b15_ip = Tpl_4776;
assign Tpl_4777 = ptsr40_r1_cac0b16;
assign ptsr40_r1_cac0b16_ip = Tpl_4778;
assign Tpl_4779 = ptsr40_r1_cac0b17;
assign ptsr40_r1_cac0b17_ip = Tpl_4780;
assign Tpl_4781 = ptsr41_r1_cac0b18;
assign ptsr41_r1_cac0b18_ip = Tpl_4782;
assign Tpl_4783 = ptsr41_r1_cac1b0;
assign ptsr41_r1_cac1b0_ip = Tpl_4784;
assign Tpl_4785 = ptsr41_r1_cac1b1;
assign ptsr41_r1_cac1b1_ip = Tpl_4786;
assign Tpl_4787 = ptsr41_r1_cac1b2;
assign ptsr41_r1_cac1b2_ip = Tpl_4788;
assign Tpl_4789 = ptsr42_r1_cac1b3;
assign ptsr42_r1_cac1b3_ip = Tpl_4790;
assign Tpl_4791 = ptsr42_r1_cac1b4;
assign ptsr42_r1_cac1b4_ip = Tpl_4792;
assign Tpl_4793 = ptsr42_r1_cac1b5;
assign ptsr42_r1_cac1b5_ip = Tpl_4794;
assign Tpl_4795 = ptsr42_r1_cac1b6;
assign ptsr42_r1_cac1b6_ip = Tpl_4796;
assign Tpl_4797 = ptsr43_r1_cac1b7;
assign ptsr43_r1_cac1b7_ip = Tpl_4798;
assign Tpl_4799 = ptsr43_r1_cac1b8;
assign ptsr43_r1_cac1b8_ip = Tpl_4800;
assign Tpl_4801 = ptsr43_r1_cac1b9;
assign ptsr43_r1_cac1b9_ip = Tpl_4802;
assign Tpl_4803 = ptsr43_r1_cac1b10;
assign ptsr43_r1_cac1b10_ip = Tpl_4804;
assign Tpl_4805 = ptsr44_r1_cac1b11;
assign ptsr44_r1_cac1b11_ip = Tpl_4806;
assign Tpl_4807 = ptsr44_r1_cac1b12;
assign ptsr44_r1_cac1b12_ip = Tpl_4808;
assign Tpl_4809 = ptsr44_r1_cac1b13;
assign ptsr44_r1_cac1b13_ip = Tpl_4810;
assign Tpl_4811 = ptsr44_r1_cac1b14;
assign ptsr44_r1_cac1b14_ip = Tpl_4812;
assign Tpl_4813 = ptsr45_r1_cac1b15;
assign ptsr45_r1_cac1b15_ip = Tpl_4814;
assign Tpl_4815 = ptsr45_r1_cac1b16;
assign ptsr45_r1_cac1b16_ip = Tpl_4816;
assign Tpl_4817 = ptsr45_r1_cac1b17;
assign ptsr45_r1_cac1b17_ip = Tpl_4818;
assign Tpl_4819 = ptsr45_r1_cac1b18;
assign ptsr45_r1_cac1b18_ip = Tpl_4820;
assign Tpl_4821 = ptsr46_r1_bac0b0;
assign Tpl_4822 = ptsr46_r1_bac0b1;
assign Tpl_4823 = ptsr46_r1_bac0b2;
assign Tpl_4824 = ptsr46_r1_bac0b3;
assign Tpl_4825 = ptsr47_r1_bac1b0;
assign Tpl_4826 = ptsr47_r1_bac1b1;
assign Tpl_4827 = ptsr47_r1_bac1b2;
assign Tpl_4828 = ptsr47_r1_bac1b3;
assign Tpl_4829 = ptsr48_r1_actnc0;
assign Tpl_4830 = ptsr48_r1_actnc1;
assign Tpl_4831 = ptsr48_r1_ckec0;
assign Tpl_4832 = ptsr48_r1_ckec1;
assign Tpl_4833 = ptsr49_r1_gts0;
assign ptsr49_r1_gts0_ip = Tpl_4834;
assign Tpl_4835 = ptsr49_r1_gts1;
assign ptsr49_r1_gts1_ip = Tpl_4836;
assign Tpl_4837 = ptsr49_r1_gts2;
assign ptsr49_r1_gts2_ip = Tpl_4838;
assign Tpl_4839 = ptsr49_r1_gts3;
assign ptsr49_r1_gts3_ip = Tpl_4840;
assign Tpl_4841 = ptsr50_r1_wrlvls0;
assign ptsr50_r1_wrlvls0_ip = Tpl_4842;
assign Tpl_4843 = ptsr50_r1_wrlvls1;
assign ptsr50_r1_wrlvls1_ip = Tpl_4844;
assign Tpl_4845 = ptsr50_r1_wrlvls2;
assign ptsr50_r1_wrlvls2_ip = Tpl_4846;
assign Tpl_4847 = ptsr50_r1_wrlvls3;
assign ptsr50_r1_wrlvls3_ip = Tpl_4848;
assign Tpl_4849 = ptsr51_r1_dqsdqs0b0;
assign ptsr51_r1_dqsdqs0b0_ip = Tpl_4850;
assign Tpl_4851 = ptsr51_r1_dqsdqs0b1;
assign ptsr51_r1_dqsdqs0b1_ip = Tpl_4852;
assign Tpl_4853 = ptsr51_r1_dqsdqs0b2;
assign ptsr51_r1_dqsdqs0b2_ip = Tpl_4854;
assign Tpl_4855 = ptsr51_r1_dqsdqs0b3;
assign ptsr51_r1_dqsdqs0b3_ip = Tpl_4856;
assign Tpl_4857 = ptsr52_r1_dqsdqs0b4;
assign ptsr52_r1_dqsdqs0b4_ip = Tpl_4858;
assign Tpl_4859 = ptsr52_r1_dqsdqs0b5;
assign ptsr52_r1_dqsdqs0b5_ip = Tpl_4860;
assign Tpl_4861 = ptsr52_r1_dqsdqs0b6;
assign ptsr52_r1_dqsdqs0b6_ip = Tpl_4862;
assign Tpl_4863 = ptsr52_r1_dqsdqs0b7;
assign ptsr52_r1_dqsdqs0b7_ip = Tpl_4864;
assign Tpl_4865 = ptsr53_r1_dqsdqs1b0;
assign ptsr53_r1_dqsdqs1b0_ip = Tpl_4866;
assign Tpl_4867 = ptsr53_r1_dqsdqs1b1;
assign ptsr53_r1_dqsdqs1b1_ip = Tpl_4868;
assign Tpl_4869 = ptsr53_r1_dqsdqs1b2;
assign ptsr53_r1_dqsdqs1b2_ip = Tpl_4870;
assign Tpl_4871 = ptsr53_r1_dqsdqs1b3;
assign ptsr53_r1_dqsdqs1b3_ip = Tpl_4872;
assign Tpl_4873 = ptsr54_r1_dqsdqs1b4;
assign ptsr54_r1_dqsdqs1b4_ip = Tpl_4874;
assign Tpl_4875 = ptsr54_r1_dqsdqs1b5;
assign ptsr54_r1_dqsdqs1b5_ip = Tpl_4876;
assign Tpl_4877 = ptsr54_r1_dqsdqs1b6;
assign ptsr54_r1_dqsdqs1b6_ip = Tpl_4878;
assign Tpl_4879 = ptsr54_r1_dqsdqs1b7;
assign ptsr54_r1_dqsdqs1b7_ip = Tpl_4880;
assign Tpl_4881 = ptsr55_r1_dqsdqs2b0;
assign ptsr55_r1_dqsdqs2b0_ip = Tpl_4882;
assign Tpl_4883 = ptsr55_r1_dqsdqs2b1;
assign ptsr55_r1_dqsdqs2b1_ip = Tpl_4884;
assign Tpl_4885 = ptsr55_r1_dqsdqs2b2;
assign ptsr55_r1_dqsdqs2b2_ip = Tpl_4886;
assign Tpl_4887 = ptsr55_r1_dqsdqs2b3;
assign ptsr55_r1_dqsdqs2b3_ip = Tpl_4888;
assign Tpl_4889 = ptsr56_r1_dqsdqs2b4;
assign ptsr56_r1_dqsdqs2b4_ip = Tpl_4890;
assign Tpl_4891 = ptsr56_r1_dqsdqs2b5;
assign ptsr56_r1_dqsdqs2b5_ip = Tpl_4892;
assign Tpl_4893 = ptsr56_r1_dqsdqs2b6;
assign ptsr56_r1_dqsdqs2b6_ip = Tpl_4894;
assign Tpl_4895 = ptsr56_r1_dqsdqs2b7;
assign ptsr56_r1_dqsdqs2b7_ip = Tpl_4896;
assign Tpl_4897 = ptsr57_r1_dqsdqs3b0;
assign ptsr57_r1_dqsdqs3b0_ip = Tpl_4898;
assign Tpl_4899 = ptsr57_r1_dqsdqs3b1;
assign ptsr57_r1_dqsdqs3b1_ip = Tpl_4900;
assign Tpl_4901 = ptsr57_r1_dqsdqs3b2;
assign ptsr57_r1_dqsdqs3b2_ip = Tpl_4902;
assign Tpl_4903 = ptsr57_r1_dqsdqs3b3;
assign ptsr57_r1_dqsdqs3b3_ip = Tpl_4904;
assign Tpl_4905 = ptsr58_r1_dqsdqs3b4;
assign ptsr58_r1_dqsdqs3b4_ip = Tpl_4906;
assign Tpl_4907 = ptsr58_r1_dqsdqs3b5;
assign ptsr58_r1_dqsdqs3b5_ip = Tpl_4908;
assign Tpl_4909 = ptsr58_r1_dqsdqs3b6;
assign ptsr58_r1_dqsdqs3b6_ip = Tpl_4910;
assign Tpl_4911 = ptsr58_r1_dqsdqs3b7;
assign ptsr58_r1_dqsdqs3b7_ip = Tpl_4912;
assign Tpl_4913 = ptsr59_r1_dqsdms0;
assign ptsr59_r1_dqsdms0_ip = Tpl_4914;
assign Tpl_4915 = ptsr59_r1_dqsdms1;
assign ptsr59_r1_dqsdms1_ip = Tpl_4916;
assign Tpl_4917 = ptsr59_r1_dqsdms2;
assign ptsr59_r1_dqsdms2_ip = Tpl_4918;
assign Tpl_4919 = ptsr59_r1_dqsdms3;
assign ptsr59_r1_dqsdms3_ip = Tpl_4920;
assign Tpl_4921 = ptsr60_r1_rdlvldqs0b0;
assign ptsr60_r1_rdlvldqs0b0_ip = Tpl_4922;
assign Tpl_4923 = ptsr60_r1_rdlvldqs0b1;
assign ptsr60_r1_rdlvldqs0b1_ip = Tpl_4924;
assign Tpl_4925 = ptsr60_r1_rdlvldqs0b2;
assign ptsr60_r1_rdlvldqs0b2_ip = Tpl_4926;
assign Tpl_4927 = ptsr60_r1_rdlvldqs0b3;
assign ptsr60_r1_rdlvldqs0b3_ip = Tpl_4928;
assign Tpl_4929 = ptsr61_r1_rdlvldqs0b4;
assign ptsr61_r1_rdlvldqs0b4_ip = Tpl_4930;
assign Tpl_4931 = ptsr61_r1_rdlvldqs0b5;
assign ptsr61_r1_rdlvldqs0b5_ip = Tpl_4932;
assign Tpl_4933 = ptsr61_r1_rdlvldqs0b6;
assign ptsr61_r1_rdlvldqs0b6_ip = Tpl_4934;
assign Tpl_4935 = ptsr61_r1_rdlvldqs0b7;
assign ptsr61_r1_rdlvldqs0b7_ip = Tpl_4936;
assign Tpl_4937 = ptsr62_r1_rdlvldqs1b0;
assign ptsr62_r1_rdlvldqs1b0_ip = Tpl_4938;
assign Tpl_4939 = ptsr62_r1_rdlvldqs1b1;
assign ptsr62_r1_rdlvldqs1b1_ip = Tpl_4940;
assign Tpl_4941 = ptsr62_r1_rdlvldqs1b2;
assign ptsr62_r1_rdlvldqs1b2_ip = Tpl_4942;
assign Tpl_4943 = ptsr62_r1_rdlvldqs1b3;
assign ptsr62_r1_rdlvldqs1b3_ip = Tpl_4944;
assign Tpl_4945 = ptsr63_r1_rdlvldqs1b4;
assign ptsr63_r1_rdlvldqs1b4_ip = Tpl_4946;
assign Tpl_4947 = ptsr63_r1_rdlvldqs1b5;
assign ptsr63_r1_rdlvldqs1b5_ip = Tpl_4948;
assign Tpl_4949 = ptsr63_r1_rdlvldqs1b6;
assign ptsr63_r1_rdlvldqs1b6_ip = Tpl_4950;
assign Tpl_4951 = ptsr63_r1_rdlvldqs1b7;
assign ptsr63_r1_rdlvldqs1b7_ip = Tpl_4952;
assign Tpl_4953 = ptsr64_r1_rdlvldqs2b0;
assign ptsr64_r1_rdlvldqs2b0_ip = Tpl_4954;
assign Tpl_4955 = ptsr64_r1_rdlvldqs2b1;
assign ptsr64_r1_rdlvldqs2b1_ip = Tpl_4956;
assign Tpl_4957 = ptsr64_r1_rdlvldqs2b2;
assign ptsr64_r1_rdlvldqs2b2_ip = Tpl_4958;
assign Tpl_4959 = ptsr64_r1_rdlvldqs2b3;
assign ptsr64_r1_rdlvldqs2b3_ip = Tpl_4960;
assign Tpl_4961 = ptsr65_r1_rdlvldqs2b4;
assign ptsr65_r1_rdlvldqs2b4_ip = Tpl_4962;
assign Tpl_4963 = ptsr65_r1_rdlvldqs2b5;
assign ptsr65_r1_rdlvldqs2b5_ip = Tpl_4964;
assign Tpl_4965 = ptsr65_r1_rdlvldqs2b6;
assign ptsr65_r1_rdlvldqs2b6_ip = Tpl_4966;
assign Tpl_4967 = ptsr65_r1_rdlvldqs2b7;
assign ptsr65_r1_rdlvldqs2b7_ip = Tpl_4968;
assign Tpl_4969 = ptsr66_r1_rdlvldqs3b0;
assign ptsr66_r1_rdlvldqs3b0_ip = Tpl_4970;
assign Tpl_4971 = ptsr66_r1_rdlvldqs3b1;
assign ptsr66_r1_rdlvldqs3b1_ip = Tpl_4972;
assign Tpl_4973 = ptsr66_r1_rdlvldqs3b2;
assign ptsr66_r1_rdlvldqs3b2_ip = Tpl_4974;
assign Tpl_4975 = ptsr66_r1_rdlvldqs3b3;
assign ptsr66_r1_rdlvldqs3b3_ip = Tpl_4976;
assign Tpl_4977 = ptsr67_r1_rdlvldqs3b4;
assign ptsr67_r1_rdlvldqs3b4_ip = Tpl_4978;
assign Tpl_4979 = ptsr67_r1_rdlvldqs3b5;
assign ptsr67_r1_rdlvldqs3b5_ip = Tpl_4980;
assign Tpl_4981 = ptsr67_r1_rdlvldqs3b6;
assign ptsr67_r1_rdlvldqs3b6_ip = Tpl_4982;
assign Tpl_4983 = ptsr67_r1_rdlvldqs3b7;
assign ptsr67_r1_rdlvldqs3b7_ip = Tpl_4984;
assign Tpl_4985 = ptsr68_r1_rdlvldms0;
assign ptsr68_r1_rdlvldms0_ip = Tpl_4986;
assign Tpl_4987 = ptsr68_r1_rdlvldms1;
assign ptsr68_r1_rdlvldms1_ip = Tpl_4988;
assign Tpl_4989 = ptsr68_r1_rdlvldms2;
assign ptsr68_r1_rdlvldms2_ip = Tpl_4990;
assign Tpl_4991 = ptsr68_r1_rdlvldms3;
assign ptsr68_r1_rdlvldms3_ip = Tpl_4992;
assign Tpl_4993 = ptsr69_r0_psck;
assign ptsr69_r0_psck_ip = Tpl_4994;
assign Tpl_4995 = ptsr69_r0_dqsleadck;
assign ptsr69_r0_dqsleadck_ip = Tpl_4996;
assign Tpl_4997 = ptsr69_r1_psck;
assign ptsr69_r1_psck_ip = Tpl_4998;
assign Tpl_4999 = ptsr69_r1_dqsleadck;
assign ptsr69_r1_dqsleadck_ip = Tpl_5000;
assign Tpl_5001 = ptsr69_sanpat;
assign Tpl_5002 = ptsr70_odtc0;
assign Tpl_5003 = ptsr70_odtc1;
assign Tpl_5004 = ptsr70_rstnc0;
assign Tpl_5005 = ptsr70_rstnc1;
assign Tpl_5006 = ptsr70_nt_rank;
assign ptsr70_nt_rank_ip = Tpl_5007;
assign Tpl_5008 = treg1_t_alrtp;
assign Tpl_5009 = treg1_t_ckesr;
assign Tpl_5010 = treg1_t_ccd_s;
assign Tpl_5011 = treg1_t_faw;
assign Tpl_5012 = treg1_t_rtw;
assign Tpl_5013 = treg2_t_rcd;
assign Tpl_5014 = treg2_t_rdpden;
assign Tpl_5015 = treg2_t_rc;
assign Tpl_5016 = treg2_t_ras;
assign Tpl_5017 = treg3_t_pd;
assign Tpl_5018 = treg3_t_rp;
assign Tpl_5019 = treg3_t_wlbr;
assign Tpl_5020 = treg3_t_wrapden;
assign Tpl_5021 = treg3_t_cke;
assign Tpl_5022 = treg4_t_xp;
assign Tpl_5023 = treg4_t_vreftimelong;
assign Tpl_5024 = treg4_t_vreftimeshort;
assign Tpl_5025 = treg4_t_mrd;
assign Tpl_5026 = treg5_t_zqcs_itv;
assign Tpl_5027 = treg6_t_pori;
assign Tpl_5028 = treg6_t_zqinit;
assign Tpl_5029 = treg7_t_mrs2lvlen;
assign Tpl_5030 = treg7_t_zqcs;
assign Tpl_5031 = treg7_t_xpdll;
assign Tpl_5032 = treg7_t_wlbtr;
assign Tpl_5033 = treg8_t_rrd_s;
assign Tpl_5034 = treg8_t_rfc1;
assign Tpl_5035 = treg8_t_mrs2act;
assign Tpl_5036 = treg8_t_lvlaa;
assign Tpl_5037 = treg9_t_dllk;
assign Tpl_5038 = treg9_t_refi_off;
assign Tpl_5039 = treg9_t_mprr;
assign Tpl_5040 = treg10_t_xpr;
assign Tpl_5041 = treg10_t_dllrst;
assign Tpl_5042 = treg11_t_rst;
assign Tpl_5043 = treg11_t_odth4;
assign Tpl_5044 = treg12_t_odth8;
assign Tpl_5045 = treg12_t_lvlload;
assign Tpl_5046 = treg12_t_lvldll;
assign Tpl_5047 = treg12_t_lvlresp;
assign Tpl_5048 = treg13_t_xs;
assign Tpl_5049 = treg13_t_mod;
assign Tpl_5050 = treg14_t_dpd;
assign Tpl_5051 = treg14_t_mrw;
assign Tpl_5052 = treg14_t_wr2rd;
assign Tpl_5053 = treg15_t_mrr;
assign Tpl_5054 = treg15_t_zqrs;
assign Tpl_5055 = treg15_t_dqscke;
assign Tpl_5056 = treg15_t_xsr;
assign Tpl_5057 = treg16_t_mped;
assign Tpl_5058 = treg16_t_mpx;
assign Tpl_5059 = treg16_t_wr_mpr;
assign Tpl_5060 = treg16_t_init5;
assign Tpl_5061 = treg17_t_setgear;
assign Tpl_5062 = treg17_t_syncgear;
assign Tpl_5063 = treg17_t_dlllock;
assign Tpl_5064 = treg17_t_wlbtr_s;
assign Tpl_5065 = treg18_t_read_low;
assign Tpl_5066 = treg18_t_read_high;
assign Tpl_5067 = treg19_t_write_low;
assign Tpl_5068 = treg19_t_write_high;
assign Tpl_5069 = treg20_t_rfc2;
assign Tpl_5070 = treg20_t_rfc4;
assign Tpl_5071 = treg21_t_wlbr_crcdm;
assign Tpl_5072 = treg21_t_wlbtr_crcdm_l;
assign Tpl_5073 = treg21_t_wlbtr_crcdm_s;
assign Tpl_5074 = treg21_t_xmpdll;
assign Tpl_5075 = treg22_t_wrmpr;
assign Tpl_5076 = treg22_t_lvlexit;
assign Tpl_5077 = treg22_t_lvldis;
assign Tpl_5078 = treg23_t_zqoper;
assign Tpl_5079 = treg23_t_rfc;
assign Tpl_5080 = treg24_t_xsdll;
assign Tpl_5081 = treg24_odtlon;
assign Tpl_5082 = treg25_odtloff;
assign Tpl_5083 = treg25_t_wlmrd;
assign Tpl_5084 = treg25_t_wldqsen;
assign Tpl_5085 = treg25_t_wtr;
assign Tpl_5086 = treg26_t_rda2pd;
assign Tpl_5087 = treg26_t_wra2pd;
assign Tpl_5088 = treg26_t_zqcl;
assign Tpl_5089 = treg27_t_calvl_adr_ckeh;
assign Tpl_5090 = treg27_t_calvl_capture;
assign Tpl_5091 = treg27_t_calvl_cc;
assign Tpl_5092 = treg27_t_calvl_en;
assign Tpl_5093 = treg28_t_calvl_ext;
assign Tpl_5094 = treg28_t_calvl_max;
assign Tpl_5095 = treg29_t_ckehdqs;
assign Tpl_5096 = treg29_t_ccd;
assign Tpl_5097 = treg29_t_zqlat;
assign Tpl_5098 = treg29_t_ckckeh;
assign Tpl_5099 = treg30_t_rrd;
assign Tpl_5100 = treg30_t_caent;
assign Tpl_5101 = treg30_t_cmdcke;
assign Tpl_5102 = treg30_t_mpcwr;
assign Tpl_5103 = treg30_t_dqrpt;
assign Tpl_5104 = treg31_t_zq_itv;
assign Tpl_5105 = treg31_t_ckelck;
assign Tpl_5106 = treg32_t_dllen;
assign Tpl_5107 = treg32_t_init3;
assign Tpl_5108 = treg32_t_dtrain;
assign Tpl_5109 = treg33_t_mpcwr2rd;
assign Tpl_5110 = treg33_t_fc;
assign Tpl_5111 = treg33_t_refi;
assign Tpl_5112 = treg34_t_vrcgen;
assign Tpl_5113 = treg34_t_vrcgdis;
assign Tpl_5114 = treg34_t_odtup;
assign Tpl_5115 = treg34_t_ccdwm;
assign Tpl_5116 = treg35_t_osco;
assign Tpl_5117 = treg35_t_ckfspe;
assign Tpl_5118 = treg35_t_ckfspx;
assign Tpl_5119 = treg35_t_init1;
assign Tpl_5120 = treg36_t_zqcal;
assign Tpl_5121 = treg36_t_lvlresp_nr;
assign Tpl_5122 = treg36_t_ppd;
assign Tpl_5123 = bistcfg_ch0_start_rank;
assign Tpl_5124 = bistcfg_ch0_end_rank;
assign Tpl_5125 = bistcfg_ch0_start_bank;
assign Tpl_5126 = bistcfg_ch0_end_bank;
assign Tpl_5127 = bistcfg_ch0_start_background;
assign Tpl_5128 = bistcfg_ch0_end_background;
assign Tpl_5129 = bistcfg_ch0_element;
assign Tpl_5130 = bistcfg_ch0_operation;
assign Tpl_5131 = bistcfg_ch0_retention;
assign Tpl_5132 = bistcfg_ch0_diagnosis_en;
assign Tpl_5133 = bistcfg_ch1_start_rank;
assign Tpl_5134 = bistcfg_ch1_end_rank;
assign Tpl_5135 = bistcfg_ch1_start_bank;
assign Tpl_5136 = bistcfg_ch1_end_bank;
assign Tpl_5137 = bistcfg_ch1_start_background;
assign Tpl_5138 = bistcfg_ch1_end_background;
assign Tpl_5139 = bistcfg_ch1_element;
assign Tpl_5140 = bistcfg_ch1_operation;
assign Tpl_5141 = bistcfg_ch1_retention;
assign Tpl_5142 = bistcfg_ch1_diagnosis_en;
assign Tpl_5143 = biststaddr_ch0_start_row;
assign Tpl_5144 = biststaddr_ch0_start_col;
assign Tpl_5145 = biststaddr_ch1_start_row;
assign Tpl_5146 = biststaddr_ch1_start_col;
assign Tpl_5147 = bistedaddr_ch0_end_row;
assign Tpl_5148 = bistedaddr_ch0_end_col;
assign Tpl_5149 = bistedaddr_ch1_end_row;
assign Tpl_5150 = bistedaddr_ch1_end_col;
assign Tpl_5151 = bistm0_ch0_march_element_0;
assign Tpl_5152 = bistm0_ch1_march_element_0;
assign Tpl_5153 = bistm1_ch0_march_element_1;
assign Tpl_5154 = bistm1_ch1_march_element_1;
assign Tpl_5155 = bistm2_ch0_march_element_2;
assign Tpl_5156 = bistm2_ch1_march_element_2;
assign Tpl_5157 = bistm3_ch0_march_element_3;
assign Tpl_5158 = bistm3_ch1_march_element_3;
assign Tpl_5159 = bistm4_ch0_march_element_4;
assign Tpl_5160 = bistm4_ch1_march_element_4;
assign Tpl_5161 = bistm5_ch0_march_element_5;
assign Tpl_5162 = bistm5_ch1_march_element_5;
assign Tpl_5163 = bistm6_ch0_march_element_6;
assign Tpl_5164 = bistm6_ch1_march_element_6;
assign Tpl_5165 = bistm7_ch0_march_element_7;
assign Tpl_5166 = bistm7_ch1_march_element_7;
assign Tpl_5167 = bistm8_ch0_march_element_8;
assign Tpl_5168 = bistm8_ch1_march_element_8;
assign Tpl_5169 = bistm9_ch0_march_element_9;
assign Tpl_5170 = bistm9_ch1_march_element_9;
assign Tpl_5171 = bistm10_ch0_march_element_10;
assign Tpl_5172 = bistm10_ch1_march_element_10;
assign Tpl_5173 = bistm11_ch0_march_element_11;
assign Tpl_5174 = bistm11_ch1_march_element_11;
assign Tpl_5175 = bistm12_ch0_march_element_12;
assign Tpl_5176 = bistm12_ch1_march_element_12;
assign Tpl_5177 = bistm13_ch0_march_element_13;
assign Tpl_5178 = bistm13_ch1_march_element_13;
assign Tpl_5179 = bistm14_ch0_march_element_14;
assign Tpl_5180 = bistm14_ch1_march_element_14;
assign Tpl_5181 = bistm15_ch0_march_element_15;
assign Tpl_5182 = bistm15_ch1_march_element_15;
assign opstt_ch0_dram_pause = Tpl_5183;
assign opstt_ch0_user_cmd_ready = Tpl_5184;
assign opstt_ch0_bank_idle = Tpl_5185;
assign opstt_ch0_xqr_empty = Tpl_5186;
assign opstt_ch0_xqr_full = Tpl_5187;
assign opstt_ch0_xqw_empty = Tpl_5188;
assign opstt_ch0_xqw_full = Tpl_5189;
assign opstt_ch1_dram_pause = Tpl_5190;
assign opstt_ch1_user_cmd_ready = Tpl_5191;
assign opstt_ch1_bank_idle = Tpl_5192;
assign opstt_ch1_xqr_empty = Tpl_5193;
assign opstt_ch1_xqr_full = Tpl_5194;
assign opstt_ch1_xqw_empty = Tpl_5195;
assign opstt_ch1_xqw_full = Tpl_5196;
assign intstt_ch0_int_gc_fsm = Tpl_5197;
assign intstt_ch1_int_gc_fsm = Tpl_5198;
assign ddrbiststt_ch0_error = Tpl_5199;
assign ddrbiststt_ch0_endtest = Tpl_5200;
assign ddrbiststt_ch0_error_new = Tpl_5201;
assign ddrbiststt_ch0_rank_fail = Tpl_5202;
assign ddrbiststt_ch0_bank_fail = Tpl_5203;
assign ddrbiststt_ch0_row_fail = Tpl_5204;
assign ddrbiststt_ch1_error = Tpl_5205;
assign ddrbiststt_ch1_endtest = Tpl_5206;
assign ddrbiststt_ch1_error_new = Tpl_5207;
assign ddrbiststt_ch1_rank_fail = Tpl_5208;
assign ddrbiststt_ch1_bank_fail = Tpl_5209;
assign ddrbiststt_ch1_row_fail = Tpl_5210;
assign pts0_r0_vrefdqrderr = Tpl_5211;
assign pts0_r0_vrefcaerr = Tpl_5212;
assign pts0_r0_gterr = Tpl_5213;
assign pts0_r0_wrlvlerr = Tpl_5214;
assign pts0_r0_vrefdqwrerr = Tpl_5215;
assign pts0_r0_rdlvldmerr = Tpl_5216;
assign pts0_dllerr = Tpl_5217;
assign pts0_lp3calvlerr = Tpl_5218;
assign pts1_r0_sanchkerr = Tpl_5219;
assign pts1_r0_dqsdmerr = Tpl_5220;
assign pts1_r1_sanchkerr = Tpl_5221;
assign pts1_r1_dqsdmerr = Tpl_5222;
assign pts2_r0_rdlvldqerr = Tpl_5223;
assign pts3_r0_dqsdqerr = Tpl_5224;
assign pts4_r1_vrefdqrderr = Tpl_5225;
assign pts4_r1_vrefcaerr = Tpl_5226;
assign pts4_r1_gterr = Tpl_5227;
assign pts4_r1_wrlvlerr = Tpl_5228;
assign pts4_r1_vrefdqwrerr = Tpl_5229;
assign pts4_r1_rdlvldmerr = Tpl_5230;
assign pts5_r1_rdlvldqerr = Tpl_5231;
assign pts6_r1_dqsdqerr = Tpl_5232;
assign mpr_done = Tpl_5233;
assign mpr_readout = Tpl_5234;
assign mrr_ch0_done = Tpl_5235;
assign mrr_ch0_readout = Tpl_5236;
assign mrr_ch1_done = Tpl_5237;
assign mrr_ch1_readout = Tpl_5238;
assign shad_lpmr1_fs0_bl = Tpl_5239;
assign shad_lpmr1_fs0_wpre = Tpl_5240;
assign shad_lpmr1_fs0_rpre = Tpl_5241;
assign shad_lpmr1_fs0_nwr = Tpl_5242;
assign shad_lpmr1_fs0_rpst = Tpl_5243;
assign shad_lpmr1_fs1_bl = Tpl_5244;
assign shad_lpmr1_fs1_wpre = Tpl_5245;
assign shad_lpmr1_fs1_rpre = Tpl_5246;
assign shad_lpmr1_fs1_nwr = Tpl_5247;
assign shad_lpmr1_fs1_rpst = Tpl_5248;
assign shad_lpmr2_fs0_rl = Tpl_5249;
assign shad_lpmr2_fs0_wl = Tpl_5250;
assign shad_lpmr2_fs0_wls = Tpl_5251;
assign shad_lpmr2_wrlev = Tpl_5252;
assign shad_lpmr2_fs1_rl = Tpl_5253;
assign shad_lpmr2_fs1_wl = Tpl_5254;
assign shad_lpmr2_fs1_wls = Tpl_5255;
assign shad_lpmr2_reserved = Tpl_5256;
assign shad_lpmr3_fs0_pucal = Tpl_5257;
assign shad_lpmr3_fs0_wpst = Tpl_5258;
assign shad_lpmr3_pprp = Tpl_5259;
assign shad_lpmr3_fs0_pdds = Tpl_5260;
assign shad_lpmr3_fs0_rdbi = Tpl_5261;
assign shad_lpmr3_fs0_wdbi = Tpl_5262;
assign shad_lpmr3_fs1_pucal = Tpl_5263;
assign shad_lpmr3_fs1_wpst = Tpl_5264;
assign shad_lpmr3_reserved = Tpl_5265;
assign shad_lpmr3_fs1_pdds = Tpl_5266;
assign shad_lpmr3_fs1_rdbi = Tpl_5267;
assign shad_lpmr3_fs1_wdbi = Tpl_5268;
assign shad_lpmr11_fs0_dqodt = Tpl_5269;
assign shad_lpmr11_reserved0 = Tpl_5270;
assign shad_lpmr11_fs0_caodt = Tpl_5271;
assign shad_lpmr11_reserved1 = Tpl_5272;
assign shad_lpmr11_fs1_dqodt = Tpl_5273;
assign shad_lpmr11_reserved2 = Tpl_5274;
assign shad_lpmr11_fs1_caodt = Tpl_5275;
assign shad_lpmr11_reserved3 = Tpl_5276;
assign shad_lpmr11_nt_fs0_dqodt = Tpl_5277;
assign shad_lpmr11_nt_reserved0 = Tpl_5278;
assign shad_lpmr11_nt_fs0_caodt = Tpl_5279;
assign shad_lpmr11_nt_reserved1 = Tpl_5280;
assign shad_lpmr11_nt_fs1_dqodt = Tpl_5281;
assign shad_lpmr11_nt_reserved2 = Tpl_5282;
assign shad_lpmr11_nt_fs1_caodt = Tpl_5283;
assign shad_lpmr11_nt_reserved3 = Tpl_5284;
assign shad_lpmr12_fs0_vrefcas = Tpl_5285;
assign shad_lpmr12_fs0_vrefcar = Tpl_5286;
assign shad_lpmr12_reserved0 = Tpl_5287;
assign shad_lpmr12_fs1_vrefcas = Tpl_5288;
assign shad_lpmr12_fs1_vrefcar = Tpl_5289;
assign shad_lpmr12_reserved1 = Tpl_5290;
assign shad_lpmr13_cbt = Tpl_5291;
assign shad_lpmr13_rpt = Tpl_5292;
assign shad_lpmr13_vro = Tpl_5293;
assign shad_lpmr13_vrcg = Tpl_5294;
assign shad_lpmr13_rro = Tpl_5295;
assign shad_lpmr13_dmd = Tpl_5296;
assign shad_lpmr13_fspwr = Tpl_5297;
assign shad_lpmr13_fspop = Tpl_5298;
assign shad_lpmr14_fs0_vrefdqs = Tpl_5299;
assign shad_lpmr14_fs0_vrefdqr = Tpl_5300;
assign shad_lpmr14_reserved0 = Tpl_5301;
assign shad_lpmr14_fs1_vrefdqs = Tpl_5302;
assign shad_lpmr14_fs1_vrefdqr = Tpl_5303;
assign shad_lpmr14_reserved1 = Tpl_5304;
assign shad_lpmr22_fs0_socodt = Tpl_5305;
assign shad_lpmr22_fs0_odteck = Tpl_5306;
assign shad_lpmr22_fs0_odtecs = Tpl_5307;
assign shad_lpmr22_fs0_odtdca = Tpl_5308;
assign shad_lpmr22_odtdx8 = Tpl_5309;
assign shad_lpmr22_fs1_socodt = Tpl_5310;
assign shad_lpmr22_fs1_odteck = Tpl_5311;
assign shad_lpmr22_fs1_odtecs = Tpl_5312;
assign shad_lpmr22_fs1_odtdca = Tpl_5313;
assign shad_lpmr22_reserved = Tpl_5314;
assign shad_lpmr22_nt_fs0_socodt = Tpl_5315;
assign shad_lpmr22_nt_fs0_odteck = Tpl_5316;
assign shad_lpmr22_nt_fs0_odtecs = Tpl_5317;
assign shad_lpmr22_nt_fs0_odtdca = Tpl_5318;
assign shad_lpmr22_nt_odtdx8 = Tpl_5319;
assign shad_lpmr22_nt_fs1_socodt = Tpl_5320;
assign shad_lpmr22_nt_fs1_odteck = Tpl_5321;
assign shad_lpmr22_nt_fs1_odtecs = Tpl_5322;
assign shad_lpmr22_nt_fs1_odtdca = Tpl_5323;
assign shad_lpmr22_nt_reserved = Tpl_5324;
assign data0_rddata = Tpl_5325;
assign data1_rddata = Tpl_5326;
assign data2_rddata = Tpl_5327;
assign data3_rddata = Tpl_5328;
assign data4_rddata = Tpl_5329;
assign data5_rddata = Tpl_5330;
assign data6_rddata = Tpl_5331;
assign data7_rddata = Tpl_5332;
assign data8_rddata = Tpl_5333;
assign data9_rddata = Tpl_5334;
assign data10_rddata = Tpl_5335;
assign data11_rddata = Tpl_5336;
assign data12_rddata = Tpl_5337;
assign data13_rddata = Tpl_5338;
assign data14_rddata = Tpl_5339;
assign data15_rddata = Tpl_5340;
assign Tpl_5341 = int_gc_fsm_ch0;
assign Tpl_5342 = int_gc_fsm_ch1;
assign rtcfg_ext_pri_rt = Tpl_5343;
assign rtcfg_max_pri_rt = Tpl_5344;
assign rtcfg_arq_lvl_hi_rt = Tpl_5345;
assign rtcfg_arq_lvl_lo_rt = Tpl_5346;
assign rtcfg_awq_lvl_hi_rt = Tpl_5347;
assign rtcfg_awq_lvl_lo_rt = Tpl_5348;
assign rtcfg_arq_lat_barrier_en_rt = Tpl_5349;
assign rtcfg_awq_lat_barrier_en_rt = Tpl_5350;
assign rtcfg_arq_ooo_en_rt = Tpl_5351;
assign rtcfg_awq_ooo_en_rt = Tpl_5352;
assign rtcfg_acq_realtime_en_rt = Tpl_5353;
assign rtcfg_wm_enable_rt = Tpl_5354;
assign rtcfg_arq_lahead_en_rt = Tpl_5355;
assign rtcfg_awq_lahead_en_rt = Tpl_5356;
assign rtcfg_narrow_mode_rt = Tpl_5357;
assign rtcfg_narrow_size_rt = Tpl_5358;
assign rtcfg_arq_lat_barrier_rt = Tpl_5359;
assign rtcfg_awq_lat_barrier_rt = Tpl_5360;
assign rtcfg_arq_starv_th_rt = Tpl_5361;
assign rtcfg_awq_starv_th_rt = Tpl_5362;
assign rtcfg_size_max_rt = Tpl_5363;
assign addr_cfg = Tpl_5364;
assign dllctlca_limit = Tpl_5365;
assign dllctlca_en = Tpl_5366;
assign dllctlca_upd = Tpl_5367;
assign dllctlca_byp = Tpl_5368;
assign dllctlca_bypc = Tpl_5369;
assign dllctlca_clkdly = Tpl_5370;
assign dllctldq_limit = Tpl_5371;
assign dllctldq_en = Tpl_5372;
assign dllctldq_upd = Tpl_5373;
assign dllctldq_byp = Tpl_5374;
assign dllctldq_bypc = Tpl_5375;
assign pbcr_vrefenca = Tpl_5376;
assign pbcr_vrefsetca = Tpl_5377;
assign cior_drvsel = Tpl_5378;
assign cior_cmos_en = Tpl_5379;
assign cior_odis_clk = Tpl_5380;
assign cior_odis_ctl = Tpl_5381;
assign dior_drvsel = Tpl_5382;
assign dior_cmos_en = Tpl_5383;
assign dior_fena_rcv = Tpl_5384;
assign dior_rtt_en = Tpl_5385;
assign dior_rtt_sel = Tpl_5386;
assign dior_odis_dq = Tpl_5387;
assign dior_odis_dm = Tpl_5388;
assign dior_odis_dqs = Tpl_5389;
assign ptsr_vrefcar = Tpl_5390;
assign Tpl_5391 = ptsr_vrefcar_ip;
assign ptsr_vrefcas = Tpl_5392;
assign Tpl_5393 = ptsr_vrefcas_ip;
assign ptsr_vrefdqwrr = Tpl_5394;
assign Tpl_5395 = ptsr_vrefdqwrr_ip;
assign ptsr_vrefdqwrs = Tpl_5396;
assign Tpl_5397 = ptsr_vrefdqwrs_ip;
assign ptsr_cs = Tpl_5398;
assign Tpl_5399 = ptsr_cs_ip;
assign ptsr_ca = Tpl_5400;
assign Tpl_5401 = ptsr_ca_ip;
assign ptsr_ba = Tpl_5402;
assign ptsr_actn = Tpl_5403;
assign ptsr_cke = Tpl_5404;
assign ptsr_gt = Tpl_5405;
assign Tpl_5406 = ptsr_gt_ip;
assign ptsr_wrlvl = Tpl_5407;
assign Tpl_5408 = ptsr_wrlvl_ip;
assign ptsr_dqsdq = Tpl_5409;
assign Tpl_5410 = ptsr_dqsdq_ip;
assign ptsr_dqsdm = Tpl_5411;
assign Tpl_5412 = ptsr_dqsdm_ip;
assign ptsr_rdlvldq = Tpl_5413;
assign Tpl_5414 = ptsr_rdlvldq_ip;
assign ptsr_rdlvldm = Tpl_5415;
assign Tpl_5416 = ptsr_rdlvldm_ip;
assign ptsr_vrefdqrd = Tpl_5417;
assign Tpl_5418 = ptsr_vrefdqrd_ip;
assign ptsr_vrefdqrdr = Tpl_5419;
assign Tpl_5420 = ptsr_vrefdqrdr_ip;
assign ptsr_psck = Tpl_5421;
assign Tpl_5422 = ptsr_psck_ip;
assign ptsr_dqsleadck = Tpl_5423;
assign Tpl_5424 = ptsr_dqsleadck_ip;
assign ptsr_sanpat = Tpl_5425;
assign ptsr_odt = Tpl_5426;
assign ptsr_rstn = Tpl_5427;
assign ptsr_nt_rank = Tpl_5428;
assign Tpl_5429 = ptsr_nt_rank_ip;
assign reg_t_alrtp_rb = Tpl_5430;
assign reg_t_ckesr_rb = Tpl_5431;
assign reg_t_ccd_s_rb = Tpl_5432;
assign reg_t_faw_rb = Tpl_5433;
assign reg_t_rtw_rb = Tpl_5434;
assign reg_t_rcd_rb = Tpl_5435;
assign reg_t_rdpden_rb = Tpl_5436;
assign reg_t_rc_rb = Tpl_5437;
assign reg_t_ras_rb = Tpl_5438;
assign reg_t_pd_rb = Tpl_5439;
assign reg_t_rp_rb = Tpl_5440;
assign reg_t_wlbr_rb = Tpl_5441;
assign reg_t_wrapden_rb = Tpl_5442;
assign reg_t_cke_rb = Tpl_5443;
assign reg_t_xp_rb = Tpl_5444;
assign reg_t_vreftimelong_rb = Tpl_5445;
assign reg_t_vreftimeshort_rb = Tpl_5446;
assign reg_t_mrd_rb = Tpl_5447;
assign reg_t_zqcs_itv_rb = Tpl_5448;
assign reg_t_pori_rb = Tpl_5449;
assign reg_t_zqinit_rb = Tpl_5450;
assign reg_t_mrs2lvlen_rb = Tpl_5451;
assign reg_t_zqcs_rb = Tpl_5452;
assign reg_t_xpdll_rb = Tpl_5453;
assign reg_t_wlbtr_rb = Tpl_5454;
assign reg_t_rrd_s_rb = Tpl_5455;
assign reg_t_rfc1_rb = Tpl_5456;
assign reg_t_mrs2act_rb = Tpl_5457;
assign reg_t_lvlaa_rb = Tpl_5458;
assign reg_t_dllk_rb = Tpl_5459;
assign reg_t_refi_off_rb = Tpl_5460;
assign reg_t_mprr_rb = Tpl_5461;
assign reg_t_xpr_rb = Tpl_5462;
assign reg_t_dllrst_rb = Tpl_5463;
assign reg_t_rst_rb = Tpl_5464;
assign reg_t_odth4_rb = Tpl_5465;
assign reg_t_odth8_rb = Tpl_5466;
assign reg_t_lvlload_rb = Tpl_5467;
assign reg_t_lvldll_rb = Tpl_5468;
assign reg_t_lvlresp_rb = Tpl_5469;
assign reg_t_xs_rb = Tpl_5470;
assign reg_t_mod_rb = Tpl_5471;
assign reg_t_dpd_rb = Tpl_5472;
assign reg_t_mrw_rb = Tpl_5473;
assign reg_t_wr2rd_rb = Tpl_5474;
assign reg_t_mrr_rb = Tpl_5475;
assign reg_t_zqrs_rb = Tpl_5476;
assign reg_t_dqscke_rb = Tpl_5477;
assign reg_t_xsr_rb = Tpl_5478;
assign reg_t_mped_rb = Tpl_5479;
assign reg_t_mpx_rb = Tpl_5480;
assign reg_t_wr_mpr_rb = Tpl_5481;
assign reg_t_init5_rb = Tpl_5482;
assign reg_t_setgear_rb = Tpl_5483;
assign reg_t_syncgear_rb = Tpl_5484;
assign reg_t_dlllock_rb = Tpl_5485;
assign reg_t_wlbtr_s_rb = Tpl_5486;
assign reg_t_read_low_rb = Tpl_5487;
assign reg_t_read_high_rb = Tpl_5488;
assign reg_t_write_low_rb = Tpl_5489;
assign reg_t_write_high_rb = Tpl_5490;
assign reg_t_rfc2_rb = Tpl_5491;
assign reg_t_rfc4_rb = Tpl_5492;
assign reg_t_wlbr_crcdm_rb = Tpl_5493;
assign reg_t_wlbtr_crcdm_l_rb = Tpl_5494;
assign reg_t_wlbtr_crcdm_s_rb = Tpl_5495;
assign reg_t_xmpdll_rb = Tpl_5496;
assign reg_t_wrmpr_rb = Tpl_5497;
assign reg_t_lvlexit_rb = Tpl_5498;
assign reg_t_lvldis_rb = Tpl_5499;
assign reg_t_zqoper_rb = Tpl_5500;
assign reg_t_rfc_rb = Tpl_5501;
assign reg_t_xsdll_rb = Tpl_5502;
assign reg_odtlon_rb = Tpl_5503;
assign reg_odtloff_rb = Tpl_5504;
assign reg_t_wlmrd_rb = Tpl_5505;
assign reg_t_wldqsen_rb = Tpl_5506;
assign reg_t_wtr_rb = Tpl_5507;
assign reg_t_rda2pd_rb = Tpl_5508;
assign reg_t_wra2pd_rb = Tpl_5509;
assign reg_t_zqcl_rb = Tpl_5510;
assign reg_t_calvl_adr_ckeh_rb = Tpl_5511;
assign reg_t_calvl_capture_rb = Tpl_5512;
assign reg_t_calvl_cc_rb = Tpl_5513;
assign reg_t_calvl_en_rb = Tpl_5514;
assign reg_t_calvl_ext_rb = Tpl_5515;
assign reg_t_calvl_max_rb = Tpl_5516;
assign reg_t_ckehdqs_rb = Tpl_5517;
assign reg_t_ccd_rb = Tpl_5518;
assign reg_t_zqlat_rb = Tpl_5519;
assign reg_t_ckckeh_rb = Tpl_5520;
assign reg_t_rrd_rb = Tpl_5521;
assign reg_t_caent_rb = Tpl_5522;
assign reg_t_cmdcke_rb = Tpl_5523;
assign reg_t_mpcwr_rb = Tpl_5524;
assign reg_t_dqrpt_rb = Tpl_5525;
assign reg_t_zq_itv_rb = Tpl_5526;
assign reg_t_ckelck_rb = Tpl_5527;
assign reg_t_dllen_rb = Tpl_5528;
assign reg_t_init3_rb = Tpl_5529;
assign reg_t_dtrain_rb = Tpl_5530;
assign reg_t_mpcwr2rd_rb = Tpl_5531;
assign reg_t_fc_rb = Tpl_5532;
assign reg_t_refi_rb = Tpl_5533;
assign reg_t_vrcgen_rb = Tpl_5534;
assign reg_t_vrcgdis_rb = Tpl_5535;
assign reg_t_odtup_rb = Tpl_5536;
assign reg_t_ccdwm_rb = Tpl_5537;
assign reg_t_osco_rb = Tpl_5538;
assign reg_t_ckfspe_rb = Tpl_5539;
assign reg_t_ckfspx_rb = Tpl_5540;
assign reg_t_init1_rb = Tpl_5541;
assign reg_t_zqcal_rb = Tpl_5542;
assign reg_t_lvlresp_nr_rb = Tpl_5543;
assign reg_t_ppd_rb = Tpl_5544;
assign bistcfg_start_rank_ch = Tpl_5545;
assign bistcfg_end_rank_ch = Tpl_5546;
assign bistcfg_start_bank_ch = Tpl_5547;
assign bistcfg_end_bank_ch = Tpl_5548;
assign bistcfg_start_background_ch = Tpl_5549;
assign bistcfg_end_background_ch = Tpl_5550;
assign bistcfg_element_ch = Tpl_5551;
assign bistcfg_operation_ch = Tpl_5552;
assign bistcfg_retention_ch = Tpl_5553;
assign bistcfg_diagnosis_en_ch = Tpl_5554;
assign biststaddr_start_row_ch = Tpl_5555;
assign biststaddr_start_col_ch = Tpl_5556;
assign bistedaddr_end_row_ch = Tpl_5557;
assign bistedaddr_end_col_ch = Tpl_5558;
assign bistm0_march_element_0_ch = Tpl_5559;
assign bistm1_march_element_1_ch = Tpl_5560;
assign bistm2_march_element_2_ch = Tpl_5561;
assign bistm3_march_element_3_ch = Tpl_5562;
assign bistm4_march_element_4_ch = Tpl_5563;
assign bistm5_march_element_5_ch = Tpl_5564;
assign bistm6_march_element_6_ch = Tpl_5565;
assign bistm7_march_element_7_ch = Tpl_5566;
assign bistm8_march_element_8_ch = Tpl_5567;
assign bistm9_march_element_9_ch = Tpl_5568;
assign bistm10_march_element_10_ch = Tpl_5569;
assign bistm11_march_element_11_ch = Tpl_5570;
assign bistm12_march_element_12_ch = Tpl_5571;
assign bistm13_march_element_13_ch = Tpl_5572;
assign bistm14_march_element_14_ch = Tpl_5573;
assign bistm15_march_element_15_ch = Tpl_5574;
assign Tpl_5575 = status_dram_pause_ch;
assign Tpl_5576 = status_user_cmd_ready_ch;
assign Tpl_5577 = status_bank_idle_ch;
assign Tpl_5578 = status_xqr_empty_ch;
assign Tpl_5579 = status_xqr_full_ch;
assign Tpl_5580 = status_xqw_empty_ch;
assign Tpl_5581 = status_xqw_full_ch;
assign Tpl_5582 = status_int_gc_fsm_ch;
assign Tpl_5583 = status_bist_error_ch;
assign Tpl_5584 = status_bist_endtest_ch;
assign Tpl_5585 = status_bist_error_new_ch;
assign Tpl_5586 = status_bist_rank_fail_ch;
assign Tpl_5587 = status_bist_bank_fail_ch;
assign Tpl_5588 = status_bist_row_fail_ch;
assign Tpl_5589 = pts_vrefdqrderr;
assign Tpl_5590 = pts_vrefcaerr;
assign Tpl_5591 = pts_gterr;
assign Tpl_5592 = pts_wrlvlerr;
assign Tpl_5593 = pts_vrefdqwrerr;
assign Tpl_5594 = pts_rdlvldmerr;
assign Tpl_5595 = pts_dllerr;
assign Tpl_5596 = pts_lp3calvlerr;
assign Tpl_5597 = pts_sanchkerr;
assign Tpl_5598 = pts_dqsdmerr;
assign Tpl_5599 = pts_rdlvldqerr;
assign Tpl_5600 = pts_dqsdqerr;
assign Tpl_5601 = mpr_done_ch;
assign Tpl_5602 = mpr_readout_ch;
assign Tpl_5603 = mrr_done_ch;
assign Tpl_5604 = mrr_readout_ch;
assign Tpl_5605 = shad_reg_lpmr1_fs0;
assign Tpl_5606 = shad_reg_lpmr1_fs1;
assign Tpl_5607 = shad_reg_lpmr2_fs0;
assign Tpl_5608 = shad_reg_lpmr2_fs1;
assign Tpl_5609 = shad_reg_lpmr3_fs0;
assign Tpl_5610 = shad_reg_lpmr3_fs1;
assign Tpl_5611 = shad_reg_lpmr11_fs0;
assign Tpl_5612 = shad_reg_lpmr11_fs1;
assign Tpl_5613 = shad_reg_lpmr11_nt_fs0;
assign Tpl_5614 = shad_reg_lpmr11_nt_fs1;
assign Tpl_5615 = shad_reg_lpmr12_fs0;
assign Tpl_5616 = shad_reg_lpmr12_fs1;
assign Tpl_5617 = shad_reg_lpmr13;
assign Tpl_5618 = shad_reg_lpmr14_fs0;
assign Tpl_5619 = shad_reg_lpmr14_fs1;
assign Tpl_5620 = shad_reg_lpmr22_fs0;
assign Tpl_5621 = shad_reg_lpmr22_fs1;
assign Tpl_5622 = shad_reg_lpmr22_nt_fs0;
assign Tpl_5623 = shad_reg_lpmr22_nt_fs1;
assign Tpl_5624 = data_rddata;
assign int_gc_fsm_ch = Tpl_5625;
assign Tpl_5626 = pos_ofs;
assign reg_ddr4_mr0 = Tpl_5627;
assign reg_ddr4_mr1 = Tpl_5628;
assign reg_ddr4_mr2 = Tpl_5629;
assign reg_ddr4_mr3 = Tpl_5630;
assign reg_ddr4_mr4 = Tpl_5631;
assign reg_ddr4_mr5 = Tpl_5632;
assign reg_ddr4_mr6 = Tpl_5633;
assign reg_ddr3_mr0 = Tpl_5634;
assign reg_ddr3_mr1 = Tpl_5635;
assign reg_ddr3_mr2 = Tpl_5636;
assign reg_ddr3_mr3 = Tpl_5637;
assign reg_lpddr4_lpmr13 = Tpl_5638;
assign reg_lpddr4_lpmr16 = Tpl_5639;
assign reg_lpddr4_lpmr1_fs0 = Tpl_5640;
assign reg_lpddr4_lpmr1_fs1 = Tpl_5641;
assign reg_lpddr4_lpmr2_fs0 = Tpl_5642;
assign reg_lpddr4_lpmr2_fs1 = Tpl_5643;
assign reg_lpddr4_lpmr3_fs0 = Tpl_5644;
assign reg_lpddr4_lpmr3_fs1 = Tpl_5645;
assign reg_lpddr4_lpmr11_fs0 = Tpl_5646;
assign reg_lpddr4_lpmr11_fs1 = Tpl_5647;
assign reg_lpddr4_lpmr11_nt_fs0 = Tpl_5648;
assign reg_lpddr4_lpmr11_nt_fs1 = Tpl_5649;
assign reg_lpddr4_lpmr12_fs0 = Tpl_5650;
assign reg_lpddr4_lpmr12_fs1 = Tpl_5651;
assign reg_lpddr4_lpmr14_fs0 = Tpl_5652;
assign reg_lpddr4_lpmr14_fs1 = Tpl_5653;
assign reg_lpddr4_lpmr22_fs0 = Tpl_5654;
assign reg_lpddr4_lpmr22_fs1 = Tpl_5655;
assign reg_lpddr4_lpmr22_nt_fs0 = Tpl_5656;
assign reg_lpddr4_lpmr22_nt_fs1 = Tpl_5657;
assign reg_lpddr3_lpmr1 = Tpl_5658;
assign reg_lpddr3_lpmr2 = Tpl_5659;
assign reg_lpddr3_lpmr3 = Tpl_5660;
assign reg_lpddr3_lpmr10 = Tpl_5661;
assign reg_lpddr3_lpmr11 = Tpl_5662;
assign reg_lpddr3_lpmr16 = Tpl_5663;
assign reg_lpddr3_lpmr17 = Tpl_5664;
assign ddr4_mr4_t_cal = Tpl_5665;
assign dram_crc_dm = Tpl_5666;
assign dram_bl_enc = Tpl_5667;
assign reg_ddr4_enable = Tpl_5668;
assign reg_ddr3_enable = Tpl_5669;
assign reg_lpddr4_enable = Tpl_5670;
assign reg_lpddr3_enable = Tpl_5671;
assign Tpl_5672 = dmctl_ddrt;
assign Tpl_3110 = (Tpl_3101 & (Tpl_3097 == 12'h00c));
assign Tpl_3111 = ((Tpl_3100 & (Tpl_3096 == 12'h00c)) & Tpl_3093);
assign Tpl_3112 = (Tpl_3101 & (Tpl_3097 == 12'h100));
assign Tpl_3113 = (Tpl_3100 & (Tpl_3096 == 12'h100));
assign Tpl_3114 = (Tpl_3101 & (Tpl_3097 == 12'h104));
assign Tpl_3115 = (Tpl_3100 & (Tpl_3096 == 12'h104));
assign Tpl_3116 = (Tpl_3101 & (Tpl_3097 == 12'h108));
assign Tpl_3117 = (Tpl_3100 & (Tpl_3096 == 12'h108));
assign Tpl_3118 = (Tpl_3101 & (Tpl_3097 == 12'h10c));
assign Tpl_3119 = (Tpl_3100 & (Tpl_3096 == 12'h10c));
assign Tpl_3120 = (Tpl_3101 & (Tpl_3097 == 12'h110));
assign Tpl_3121 = (Tpl_3100 & (Tpl_3096 == 12'h110));
assign Tpl_3122 = (Tpl_3101 & (Tpl_3097 == 12'h114));
assign Tpl_3123 = (Tpl_3100 & (Tpl_3096 == 12'h114));
assign Tpl_3124 = (Tpl_3101 & (Tpl_3097 == 12'h118));
assign Tpl_3125 = (Tpl_3100 & (Tpl_3096 == 12'h118));
assign Tpl_3126 = (Tpl_3101 & (Tpl_3097 == 12'h11c));
assign Tpl_3127 = (Tpl_3100 & (Tpl_3096 == 12'h11c));
assign Tpl_3128 = (Tpl_3101 & (Tpl_3097 == 12'h120));
assign Tpl_3129 = (Tpl_3100 & (Tpl_3096 == 12'h120));
assign Tpl_3130 = (Tpl_3101 & (Tpl_3097 == 12'h124));
assign Tpl_3131 = (Tpl_3100 & (Tpl_3096 == 12'h124));
assign Tpl_3132 = (Tpl_3101 & (Tpl_3097 == 12'h128));
assign Tpl_3133 = (Tpl_3100 & (Tpl_3096 == 12'h128));
assign Tpl_3134 = (Tpl_3101 & (Tpl_3097 == 12'h12c));
assign Tpl_3135 = (Tpl_3100 & (Tpl_3096 == 12'h12c));
assign Tpl_3136 = (Tpl_3101 & (Tpl_3097 == 12'h130));
assign Tpl_3137 = (Tpl_3100 & (Tpl_3096 == 12'h130));
assign Tpl_3138 = (Tpl_3101 & (Tpl_3097 == 12'h134));
assign Tpl_3139 = (Tpl_3100 & (Tpl_3096 == 12'h134));
assign Tpl_3140 = (Tpl_3101 & (Tpl_3097 == 12'h138));
assign Tpl_3141 = (Tpl_3100 & (Tpl_3096 == 12'h138));
assign Tpl_3142 = (Tpl_3101 & (Tpl_3097 == 12'h13c));
assign Tpl_3143 = (Tpl_3100 & (Tpl_3096 == 12'h13c));
assign Tpl_3144 = (Tpl_3101 & (Tpl_3097 == 12'h140));
assign Tpl_3145 = (Tpl_3100 & (Tpl_3096 == 12'h140));
assign Tpl_3146 = (Tpl_3101 & (Tpl_3097 == 12'h144));
assign Tpl_3147 = (Tpl_3100 & (Tpl_3096 == 12'h144));
assign Tpl_3148 = (Tpl_3101 & (Tpl_3097 == 12'h148));
assign Tpl_3149 = (Tpl_3100 & (Tpl_3096 == 12'h148));
assign Tpl_3150 = (Tpl_3101 & (Tpl_3097 == 12'h14c));
assign Tpl_3151 = (Tpl_3100 & (Tpl_3096 == 12'h14c));
assign Tpl_3152 = (Tpl_3101 & (Tpl_3097 == 12'h150));
assign Tpl_3153 = (Tpl_3100 & (Tpl_3096 == 12'h150));
assign Tpl_3154 = (Tpl_3101 & (Tpl_3097 == 12'h154));
assign Tpl_3155 = (Tpl_3100 & (Tpl_3096 == 12'h154));
assign Tpl_3156 = (Tpl_3101 & (Tpl_3097 == 12'h158));
assign Tpl_3157 = (Tpl_3100 & (Tpl_3096 == 12'h158));
assign Tpl_3158 = (Tpl_3101 & (Tpl_3097 == 12'h15c));
assign Tpl_3159 = (Tpl_3100 & (Tpl_3096 == 12'h15c));
assign Tpl_3160 = (Tpl_3101 & (Tpl_3097 == 12'h160));
assign Tpl_3161 = (Tpl_3100 & (Tpl_3096 == 12'h160));
assign Tpl_3162 = (Tpl_3101 & (Tpl_3097 == 12'h164));
assign Tpl_3163 = (Tpl_3100 & (Tpl_3096 == 12'h164));
assign Tpl_3164 = (Tpl_3101 & (Tpl_3097 == 12'h168));
assign Tpl_3165 = (Tpl_3100 & (Tpl_3096 == 12'h168));
assign Tpl_3166 = (Tpl_3101 & (Tpl_3097 == 12'h16c));
assign Tpl_3167 = (Tpl_3100 & (Tpl_3096 == 12'h16c));
assign Tpl_3168 = (Tpl_3101 & (Tpl_3097 == 12'h170));
assign Tpl_3169 = (Tpl_3100 & (Tpl_3096 == 12'h170));
assign Tpl_3170 = (Tpl_3101 & (Tpl_3097 == 12'h174));
assign Tpl_3171 = (Tpl_3100 & (Tpl_3096 == 12'h174));
assign Tpl_3172 = (Tpl_3101 & (Tpl_3097 == 12'h178));
assign Tpl_3173 = (Tpl_3100 & (Tpl_3096 == 12'h178));
assign Tpl_3174 = (Tpl_3101 & (Tpl_3097 == 12'h17c));
assign Tpl_3175 = (Tpl_3100 & (Tpl_3096 == 12'h17c));
assign Tpl_3176 = (Tpl_3101 & (Tpl_3097 == 12'h180));
assign Tpl_3177 = (Tpl_3100 & (Tpl_3096 == 12'h180));
assign Tpl_3178 = (Tpl_3101 & (Tpl_3097 == 12'h184));
assign Tpl_3179 = (Tpl_3100 & (Tpl_3096 == 12'h184));
assign Tpl_3180 = (Tpl_3101 & (Tpl_3097 == 12'h188));
assign Tpl_3181 = (Tpl_3100 & (Tpl_3096 == 12'h188));
assign Tpl_3182 = (Tpl_3101 & (Tpl_3097 == 12'h18c));
assign Tpl_3183 = (Tpl_3100 & (Tpl_3096 == 12'h18c));
assign Tpl_3184 = (Tpl_3101 & (Tpl_3097 == 12'h190));
assign Tpl_3185 = (Tpl_3100 & (Tpl_3096 == 12'h190));
assign Tpl_3186 = (Tpl_3101 & (Tpl_3097 == 12'h194));
assign Tpl_3187 = (Tpl_3100 & (Tpl_3096 == 12'h194));
assign Tpl_3188 = (Tpl_3101 & (Tpl_3097 == 12'h198));
assign Tpl_3189 = (Tpl_3100 & (Tpl_3096 == 12'h198));
assign Tpl_3190 = (Tpl_3101 & (Tpl_3097 == 12'h19c));
assign Tpl_3191 = (Tpl_3100 & (Tpl_3096 == 12'h19c));
assign Tpl_3192 = (Tpl_3101 & (Tpl_3097 == 12'h1a0));
assign Tpl_3193 = (Tpl_3100 & (Tpl_3096 == 12'h1a0));
assign Tpl_3194 = (Tpl_3101 & (Tpl_3097 == 12'h1a4));
assign Tpl_3195 = (Tpl_3100 & (Tpl_3096 == 12'h1a4));
assign Tpl_3196 = (Tpl_3101 & (Tpl_3097 == 12'h1a8));
assign Tpl_3197 = (Tpl_3100 & (Tpl_3096 == 12'h1a8));
assign Tpl_3198 = (Tpl_3101 & (Tpl_3097 == 12'h1ac));
assign Tpl_3199 = (Tpl_3100 & (Tpl_3096 == 12'h1ac));
assign Tpl_3200 = (Tpl_3101 & (Tpl_3097 == 12'h1b0));
assign Tpl_3201 = (Tpl_3100 & (Tpl_3096 == 12'h1b0));
assign Tpl_3202 = (Tpl_3101 & (Tpl_3097 == 12'h1b4));
assign Tpl_3203 = (Tpl_3100 & (Tpl_3096 == 12'h1b4));
assign Tpl_3204 = (Tpl_3101 & (Tpl_3097 == 12'h1b8));
assign Tpl_3205 = (Tpl_3100 & (Tpl_3096 == 12'h1b8));
assign Tpl_3206 = (Tpl_3101 & (Tpl_3097 == 12'h1bc));
assign Tpl_3207 = (Tpl_3100 & (Tpl_3096 == 12'h1bc));
assign Tpl_3208 = (Tpl_3101 & (Tpl_3097 == 12'h1c0));
assign Tpl_3209 = (Tpl_3100 & (Tpl_3096 == 12'h1c0));
assign Tpl_3210 = (Tpl_3101 & (Tpl_3097 == 12'h1c4));
assign Tpl_3211 = (Tpl_3100 & (Tpl_3096 == 12'h1c4));
assign Tpl_3212 = (Tpl_3101 & (Tpl_3097 == 12'h1c8));
assign Tpl_3213 = (Tpl_3100 & (Tpl_3096 == 12'h1c8));
assign Tpl_3214 = (Tpl_3101 & (Tpl_3097 == 12'h1cc));
assign Tpl_3215 = (Tpl_3100 & (Tpl_3096 == 12'h1cc));
assign Tpl_3216 = (Tpl_3101 & (Tpl_3097 == 12'h1d0));
assign Tpl_3217 = (Tpl_3100 & (Tpl_3096 == 12'h1d0));
assign Tpl_3218 = (Tpl_3101 & (Tpl_3097 == 12'h1d4));
assign Tpl_3219 = (Tpl_3100 & (Tpl_3096 == 12'h1d4));
assign Tpl_3220 = (Tpl_3101 & (Tpl_3097 == 12'h1d8));
assign Tpl_3221 = (Tpl_3100 & (Tpl_3096 == 12'h1d8));
assign Tpl_3222 = (Tpl_3101 & (Tpl_3097 == 12'h1dc));
assign Tpl_3223 = (Tpl_3100 & (Tpl_3096 == 12'h1dc));
assign Tpl_3224 = (Tpl_3101 & (Tpl_3097 == 12'h1e0));
assign Tpl_3225 = (Tpl_3100 & (Tpl_3096 == 12'h1e0));
assign Tpl_3226 = (Tpl_3101 & (Tpl_3097 == 12'h1e4));
assign Tpl_3227 = (Tpl_3100 & (Tpl_3096 == 12'h1e4));
assign Tpl_3228 = (Tpl_3101 & (Tpl_3097 == 12'h1e8));
assign Tpl_3229 = (Tpl_3100 & (Tpl_3096 == 12'h1e8));
assign Tpl_3230 = (Tpl_3101 & (Tpl_3097 == 12'h1ec));
assign Tpl_3231 = (Tpl_3100 & (Tpl_3096 == 12'h1ec));
assign Tpl_3232 = (Tpl_3101 & (Tpl_3097 == 12'h1f0));
assign Tpl_3233 = (Tpl_3100 & (Tpl_3096 == 12'h1f0));
assign Tpl_3234 = (Tpl_3101 & (Tpl_3097 == 12'h1f4));
assign Tpl_3235 = (Tpl_3100 & (Tpl_3096 == 12'h1f4));
assign Tpl_3236 = (Tpl_3101 & (Tpl_3097 == 12'h1f8));
assign Tpl_3237 = (Tpl_3100 & (Tpl_3096 == 12'h1f8));
assign Tpl_3238 = (Tpl_3101 & (Tpl_3097 == 12'h1fc));
assign Tpl_3239 = (Tpl_3100 & (Tpl_3096 == 12'h1fc));
assign Tpl_3240 = (Tpl_3101 & (Tpl_3097 == 12'h200));
assign Tpl_3241 = (Tpl_3100 & (Tpl_3096 == 12'h200));
assign Tpl_3242 = (Tpl_3101 & (Tpl_3097 == 12'h204));
assign Tpl_3243 = (Tpl_3100 & (Tpl_3096 == 12'h204));
assign Tpl_3244 = (Tpl_3101 & (Tpl_3097 == 12'h208));
assign Tpl_3245 = (Tpl_3100 & (Tpl_3096 == 12'h208));
assign Tpl_3246 = (Tpl_3101 & (Tpl_3097 == 12'h20c));
assign Tpl_3247 = (Tpl_3100 & (Tpl_3096 == 12'h20c));
assign Tpl_3248 = (Tpl_3101 & (Tpl_3097 == 12'h210));
assign Tpl_3249 = (Tpl_3100 & (Tpl_3096 == 12'h210));
assign Tpl_3250 = (Tpl_3101 & (Tpl_3097 == 12'h214));
assign Tpl_3251 = (Tpl_3100 & (Tpl_3096 == 12'h214));
assign Tpl_3252 = (Tpl_3101 & (Tpl_3097 == 12'h218));
assign Tpl_3253 = (Tpl_3100 & (Tpl_3096 == 12'h218));
assign Tpl_3254 = (Tpl_3101 & (Tpl_3097 == 12'h21c));
assign Tpl_3255 = (Tpl_3100 & (Tpl_3096 == 12'h21c));
assign Tpl_3256 = (Tpl_3101 & (Tpl_3097 == 12'h220));
assign Tpl_3257 = (Tpl_3100 & (Tpl_3096 == 12'h220));
assign Tpl_3258 = (Tpl_3101 & (Tpl_3097 == 12'h224));
assign Tpl_3259 = (Tpl_3100 & (Tpl_3096 == 12'h224));
assign Tpl_3260 = (Tpl_3101 & (Tpl_3097 == 12'h228));
assign Tpl_3261 = (Tpl_3100 & (Tpl_3096 == 12'h228));
assign Tpl_3262 = (Tpl_3101 & (Tpl_3097 == 12'h22c));
assign Tpl_3263 = (Tpl_3100 & (Tpl_3096 == 12'h22c));
assign Tpl_3264 = (Tpl_3101 & (Tpl_3097 == 12'h230));
assign Tpl_3265 = (Tpl_3100 & (Tpl_3096 == 12'h230));
assign Tpl_3266 = (Tpl_3101 & (Tpl_3097 == 12'h234));
assign Tpl_3267 = (Tpl_3100 & (Tpl_3096 == 12'h234));
assign Tpl_3268 = (Tpl_3101 & (Tpl_3097 == 12'h238));
assign Tpl_3269 = (Tpl_3100 & (Tpl_3096 == 12'h238));
assign Tpl_3270 = (Tpl_3101 & (Tpl_3097 == 12'h23c));
assign Tpl_3271 = (Tpl_3100 & (Tpl_3096 == 12'h23c));
assign Tpl_3272 = (Tpl_3101 & (Tpl_3097 == 12'h240));
assign Tpl_3273 = (Tpl_3100 & (Tpl_3096 == 12'h240));
assign Tpl_3274 = (Tpl_3101 & (Tpl_3097 == 12'h244));
assign Tpl_3275 = (Tpl_3100 & (Tpl_3096 == 12'h244));
assign Tpl_3276 = (Tpl_3101 & (Tpl_3097 == 12'h248));
assign Tpl_3277 = (Tpl_3100 & (Tpl_3096 == 12'h248));
assign Tpl_3278 = (Tpl_3101 & (Tpl_3097 == 12'h24c));
assign Tpl_3279 = (Tpl_3100 & (Tpl_3096 == 12'h24c));
assign Tpl_3280 = (Tpl_3101 & (Tpl_3097 == 12'h250));
assign Tpl_3281 = (Tpl_3100 & (Tpl_3096 == 12'h250));
assign Tpl_3282 = (Tpl_3101 & (Tpl_3097 == 12'h254));
assign Tpl_3283 = (Tpl_3100 & (Tpl_3096 == 12'h254));
assign Tpl_3284 = (Tpl_3101 & (Tpl_3097 == 12'h258));
assign Tpl_3285 = (Tpl_3100 & (Tpl_3096 == 12'h258));
assign Tpl_3286 = (Tpl_3101 & (Tpl_3097 == 12'h25c));
assign Tpl_3287 = (Tpl_3100 & (Tpl_3096 == 12'h25c));
assign Tpl_3288 = (Tpl_3101 & (Tpl_3097 == 12'h260));
assign Tpl_3289 = (Tpl_3100 & (Tpl_3096 == 12'h260));
assign Tpl_3290 = (Tpl_3101 & (Tpl_3097 == 12'h264));
assign Tpl_3291 = (Tpl_3100 & (Tpl_3096 == 12'h264));
assign Tpl_3292 = (Tpl_3101 & (Tpl_3097 == 12'h268));
assign Tpl_3293 = (Tpl_3100 & (Tpl_3096 == 12'h268));
assign Tpl_3294 = (Tpl_3101 & (Tpl_3097 == 12'h26c));
assign Tpl_3295 = (Tpl_3100 & (Tpl_3096 == 12'h26c));
assign Tpl_3296 = (Tpl_3101 & (Tpl_3097 == 12'h270));
assign Tpl_3297 = (Tpl_3100 & (Tpl_3096 == 12'h270));
assign Tpl_3298 = (Tpl_3101 & (Tpl_3097 == 12'h274));
assign Tpl_3299 = (Tpl_3100 & (Tpl_3096 == 12'h274));
assign Tpl_3300 = (Tpl_3101 & (Tpl_3097 == 12'h278));
assign Tpl_3301 = (Tpl_3100 & (Tpl_3096 == 12'h278));
assign Tpl_3302 = (Tpl_3101 & (Tpl_3097 == 12'h27c));
assign Tpl_3303 = (Tpl_3100 & (Tpl_3096 == 12'h27c));
assign Tpl_3304 = (Tpl_3101 & (Tpl_3097 == 12'h280));
assign Tpl_3305 = (Tpl_3100 & (Tpl_3096 == 12'h280));
assign Tpl_3306 = (Tpl_3101 & (Tpl_3097 == 12'h284));
assign Tpl_3307 = (Tpl_3100 & (Tpl_3096 == 12'h284));
assign Tpl_3308 = (Tpl_3101 & (Tpl_3097 == 12'h288));
assign Tpl_3309 = (Tpl_3100 & (Tpl_3096 == 12'h288));
assign Tpl_3310 = (Tpl_3101 & (Tpl_3097 == 12'h28c));
assign Tpl_3311 = (Tpl_3100 & (Tpl_3096 == 12'h28c));
assign Tpl_3312 = (Tpl_3101 & (Tpl_3097 == 12'h290));
assign Tpl_3313 = (Tpl_3100 & (Tpl_3096 == 12'h290));
assign Tpl_3314 = (Tpl_3101 & (Tpl_3097 == 12'h294));
assign Tpl_3315 = (Tpl_3100 & (Tpl_3096 == 12'h294));
assign Tpl_3316 = (Tpl_3101 & (Tpl_3097 == 12'h298));
assign Tpl_3317 = (Tpl_3100 & (Tpl_3096 == 12'h298));
assign Tpl_3318 = (Tpl_3101 & (Tpl_3097 == 12'h29c));
assign Tpl_3319 = (Tpl_3100 & (Tpl_3096 == 12'h29c));
assign Tpl_3320 = (Tpl_3101 & (Tpl_3097 == 12'h2a0));
assign Tpl_3321 = (Tpl_3100 & (Tpl_3096 == 12'h2a0));
assign Tpl_3322 = (Tpl_3101 & (Tpl_3097 == 12'h2a4));
assign Tpl_3323 = (Tpl_3100 & (Tpl_3096 == 12'h2a4));
assign Tpl_3324 = (Tpl_3101 & (Tpl_3097 == 12'h2a8));
assign Tpl_3325 = (Tpl_3100 & (Tpl_3096 == 12'h2a8));
assign Tpl_3326 = (Tpl_3101 & (Tpl_3097 == 12'h2ac));
assign Tpl_3327 = (Tpl_3100 & (Tpl_3096 == 12'h2ac));
assign Tpl_3328 = (Tpl_3101 & (Tpl_3097 == 12'h2b0));
assign Tpl_3329 = (Tpl_3100 & (Tpl_3096 == 12'h2b0));
assign Tpl_3330 = (Tpl_3101 & (Tpl_3097 == 12'h2b4));
assign Tpl_3331 = (Tpl_3100 & (Tpl_3096 == 12'h2b4));
assign Tpl_3332 = (Tpl_3101 & (Tpl_3097 == 12'h2b8));
assign Tpl_3333 = (Tpl_3100 & (Tpl_3096 == 12'h2b8));
assign Tpl_3334 = (Tpl_3101 & (Tpl_3097 == 12'h2bc));
assign Tpl_3335 = (Tpl_3100 & (Tpl_3096 == 12'h2bc));
assign Tpl_3336 = (Tpl_3101 & (Tpl_3097 == 12'h2c0));
assign Tpl_3337 = (Tpl_3100 & (Tpl_3096 == 12'h2c0));
assign Tpl_3338 = (Tpl_3101 & (Tpl_3097 == 12'h2c4));
assign Tpl_3339 = (Tpl_3100 & (Tpl_3096 == 12'h2c4));
assign Tpl_3340 = (Tpl_3101 & (Tpl_3097 == 12'h2c8));
assign Tpl_3341 = (Tpl_3100 & (Tpl_3096 == 12'h2c8));
assign Tpl_3342 = (Tpl_3101 & (Tpl_3097 == 12'h2cc));
assign Tpl_3343 = (Tpl_3100 & (Tpl_3096 == 12'h2cc));
assign Tpl_3344 = (Tpl_3101 & (Tpl_3097 == 12'h2d0));
assign Tpl_3345 = (Tpl_3100 & (Tpl_3096 == 12'h2d0));
assign Tpl_3346 = (Tpl_3101 & (Tpl_3097 == 12'h2d4));
assign Tpl_3347 = (Tpl_3100 & (Tpl_3096 == 12'h2d4));
assign Tpl_3348 = (Tpl_3101 & (Tpl_3097 == 12'h2d8));
assign Tpl_3349 = (Tpl_3100 & (Tpl_3096 == 12'h2d8));
assign Tpl_3350 = (Tpl_3101 & (Tpl_3097 == 12'h2dc));
assign Tpl_3351 = (Tpl_3100 & (Tpl_3096 == 12'h2dc));
assign Tpl_3352 = (Tpl_3101 & (Tpl_3097 == 12'h2e0));
assign Tpl_3353 = (Tpl_3100 & (Tpl_3096 == 12'h2e0));
assign Tpl_3354 = (Tpl_3101 & (Tpl_3097 == 12'h2e4));
assign Tpl_3355 = (Tpl_3100 & (Tpl_3096 == 12'h2e4));
assign Tpl_3356 = (Tpl_3101 & (Tpl_3097 == 12'h2e8));
assign Tpl_3357 = (Tpl_3100 & (Tpl_3096 == 12'h2e8));
assign Tpl_3358 = (Tpl_3101 & (Tpl_3097 == 12'h2ec));
assign Tpl_3359 = (Tpl_3100 & (Tpl_3096 == 12'h2ec));
assign Tpl_3360 = (Tpl_3101 & (Tpl_3097 == 12'h2f0));
assign Tpl_3361 = (Tpl_3100 & (Tpl_3096 == 12'h2f0));
assign Tpl_3362 = (Tpl_3101 & (Tpl_3097 == 12'h2f4));
assign Tpl_3363 = (Tpl_3100 & (Tpl_3096 == 12'h2f4));
assign Tpl_3364 = (Tpl_3101 & (Tpl_3097 == 12'h2f8));
assign Tpl_3365 = (Tpl_3100 & (Tpl_3096 == 12'h2f8));
assign Tpl_3366 = (Tpl_3101 & (Tpl_3097 == 12'h2fc));
assign Tpl_3367 = (Tpl_3100 & (Tpl_3096 == 12'h2fc));
assign Tpl_3368 = (Tpl_3101 & (Tpl_3097 == 12'h300));
assign Tpl_3369 = (Tpl_3100 & (Tpl_3096 == 12'h300));
assign Tpl_3370 = (Tpl_3101 & (Tpl_3097 == 12'h304));
assign Tpl_3371 = (Tpl_3100 & (Tpl_3096 == 12'h304));
assign Tpl_3372 = (Tpl_3101 & (Tpl_3097 == 12'h308));
assign Tpl_3373 = (Tpl_3100 & (Tpl_3096 == 12'h308));
assign Tpl_3374 = (Tpl_3101 & (Tpl_3097 == 12'h30c));
assign Tpl_3375 = (Tpl_3100 & (Tpl_3096 == 12'h30c));
assign Tpl_3376 = (Tpl_3101 & (Tpl_3097 == 12'h310));
assign Tpl_3377 = (Tpl_3100 & (Tpl_3096 == 12'h310));
assign Tpl_3378 = (Tpl_3101 & (Tpl_3097 == 12'h314));
assign Tpl_3379 = (Tpl_3100 & (Tpl_3096 == 12'h314));
assign Tpl_3380 = (Tpl_3101 & (Tpl_3097 == 12'h318));
assign Tpl_3381 = (Tpl_3100 & (Tpl_3096 == 12'h318));
assign Tpl_3382 = (Tpl_3101 & (Tpl_3097 == 12'h31c));
assign Tpl_3383 = (Tpl_3100 & (Tpl_3096 == 12'h31c));
assign Tpl_3384 = (Tpl_3101 & (Tpl_3097 == 12'h320));
assign Tpl_3385 = (Tpl_3100 & (Tpl_3096 == 12'h320));
assign Tpl_3386 = (Tpl_3101 & (Tpl_3097 == 12'h324));
assign Tpl_3387 = (Tpl_3100 & (Tpl_3096 == 12'h324));
assign Tpl_3388 = (Tpl_3101 & (Tpl_3097 == 12'h328));
assign Tpl_3389 = (Tpl_3100 & (Tpl_3096 == 12'h328));
assign Tpl_3390 = (Tpl_3101 & (Tpl_3097 == 12'h32c));
assign Tpl_3391 = (Tpl_3100 & (Tpl_3096 == 12'h32c));
assign Tpl_3392 = (Tpl_3101 & (Tpl_3097 == 12'h330));
assign Tpl_3393 = (Tpl_3100 & (Tpl_3096 == 12'h330));
assign Tpl_3394 = (Tpl_3101 & (Tpl_3097 == 12'h334));
assign Tpl_3395 = (Tpl_3100 & (Tpl_3096 == 12'h334));
assign Tpl_3396 = (Tpl_3101 & (Tpl_3097 == 12'h338));
assign Tpl_3397 = (Tpl_3100 & (Tpl_3096 == 12'h338));
assign Tpl_3398 = (Tpl_3101 & (Tpl_3097 == 12'h33c));
assign Tpl_3399 = (Tpl_3100 & (Tpl_3096 == 12'h33c));
assign Tpl_3400 = (Tpl_3101 & (Tpl_3097 == 12'h340));
assign Tpl_3401 = (Tpl_3100 & (Tpl_3096 == 12'h340));
assign Tpl_3402 = (Tpl_3101 & (Tpl_3097 == 12'h344));
assign Tpl_3403 = (Tpl_3100 & (Tpl_3096 == 12'h344));
assign Tpl_3404 = (Tpl_3101 & (Tpl_3097 == 12'h348));
assign Tpl_3405 = (Tpl_3100 & (Tpl_3096 == 12'h348));
assign Tpl_3406 = (Tpl_3101 & (Tpl_3097 == 12'h34c));
assign Tpl_3407 = (Tpl_3100 & (Tpl_3096 == 12'h34c));
assign Tpl_3408 = (Tpl_3101 & (Tpl_3097 == 12'h350));
assign Tpl_3409 = (Tpl_3100 & (Tpl_3096 == 12'h350));
assign Tpl_3410 = (Tpl_3101 & (Tpl_3097 == 12'h354));
assign Tpl_3411 = (Tpl_3100 & (Tpl_3096 == 12'h354));
assign Tpl_3412 = (Tpl_3101 & (Tpl_3097 == 12'h358));
assign Tpl_3413 = (Tpl_3100 & (Tpl_3096 == 12'h358));
assign Tpl_3414 = (Tpl_3101 & (Tpl_3097 == 12'h35c));
assign Tpl_3415 = (Tpl_3100 & (Tpl_3096 == 12'h35c));
assign Tpl_3416 = (Tpl_3101 & (Tpl_3097 == 12'h360));
assign Tpl_3417 = (Tpl_3100 & (Tpl_3096 == 12'h360));
assign Tpl_3418 = (Tpl_3101 & (Tpl_3097 == 12'h364));
assign Tpl_3419 = (Tpl_3100 & (Tpl_3096 == 12'h364));
assign Tpl_3420 = (Tpl_3101 & (Tpl_3097 == 12'h368));
assign Tpl_3421 = (Tpl_3100 & (Tpl_3096 == 12'h368));
assign Tpl_3422 = (Tpl_3101 & (Tpl_3097 == 12'h36c));
assign Tpl_3423 = (Tpl_3100 & (Tpl_3096 == 12'h36c));
assign Tpl_3424 = (Tpl_3101 & (Tpl_3097 == 12'h370));
assign Tpl_3425 = (Tpl_3100 & (Tpl_3096 == 12'h370));
assign Tpl_3426 = (Tpl_3101 & (Tpl_3097 == 12'h374));
assign Tpl_3427 = (Tpl_3100 & (Tpl_3096 == 12'h374));
assign Tpl_3428 = (Tpl_3101 & (Tpl_3097 == 12'h378));
assign Tpl_3429 = (Tpl_3100 & (Tpl_3096 == 12'h378));
assign Tpl_3430 = (Tpl_3101 & (Tpl_3097 == 12'h37c));
assign Tpl_3431 = (Tpl_3100 & (Tpl_3096 == 12'h37c));
assign Tpl_3432 = (Tpl_3101 & (Tpl_3097 == 12'h380));
assign Tpl_3433 = (Tpl_3100 & (Tpl_3096 == 12'h380));
assign Tpl_3434 = (Tpl_3101 & (Tpl_3097 == 12'h384));
assign Tpl_3435 = (Tpl_3100 & (Tpl_3096 == 12'h384));
assign Tpl_3436 = (Tpl_3101 & (Tpl_3097 == 12'h388));
assign Tpl_3437 = (Tpl_3100 & (Tpl_3096 == 12'h388));
assign Tpl_3438 = (Tpl_3101 & (Tpl_3097 == 12'h38c));
assign Tpl_3439 = (Tpl_3100 & (Tpl_3096 == 12'h38c));
assign Tpl_3440 = (Tpl_3101 & (Tpl_3097 == 12'h390));
assign Tpl_3441 = (Tpl_3100 & (Tpl_3096 == 12'h390));
assign Tpl_3442 = (Tpl_3101 & (Tpl_3097 == 12'h394));
assign Tpl_3443 = (Tpl_3100 & (Tpl_3096 == 12'h394));
assign Tpl_3444 = (Tpl_3101 & (Tpl_3097 == 12'h398));
assign Tpl_3445 = (Tpl_3100 & (Tpl_3096 == 12'h398));
assign Tpl_3446 = (Tpl_3101 & (Tpl_3097 == 12'h39c));
assign Tpl_3447 = (Tpl_3100 & (Tpl_3096 == 12'h39c));
assign Tpl_3448 = (Tpl_3101 & (Tpl_3097 == 12'h3a0));
assign Tpl_3449 = (Tpl_3100 & (Tpl_3096 == 12'h3a0));
assign Tpl_3450 = (Tpl_3101 & (Tpl_3097 == 12'h3a4));
assign Tpl_3451 = (Tpl_3100 & (Tpl_3096 == 12'h3a4));
assign Tpl_3452 = (Tpl_3101 & (Tpl_3097 == 12'h3a8));
assign Tpl_3453 = (Tpl_3100 & (Tpl_3096 == 12'h3a8));
assign Tpl_3454 = (Tpl_3101 & (Tpl_3097 == 12'h3ac));
assign Tpl_3455 = (Tpl_3100 & (Tpl_3096 == 12'h3ac));
assign Tpl_3456 = (Tpl_3101 & (Tpl_3097 == 12'h3b0));
assign Tpl_3457 = (Tpl_3100 & (Tpl_3096 == 12'h3b0));
assign Tpl_3458 = (Tpl_3101 & (Tpl_3097 == 12'h3b4));
assign Tpl_3459 = (Tpl_3100 & (Tpl_3096 == 12'h3b4));
assign Tpl_3460 = (Tpl_3101 & (Tpl_3097 == 12'h3b8));
assign Tpl_3461 = (Tpl_3100 & (Tpl_3096 == 12'h3b8));
assign Tpl_3462 = (Tpl_3101 & (Tpl_3097 == 12'h3bc));
assign Tpl_3463 = (Tpl_3100 & (Tpl_3096 == 12'h3bc));
assign Tpl_3464 = (Tpl_3101 & (Tpl_3097 == 12'h3c0));
assign Tpl_3465 = (Tpl_3100 & (Tpl_3096 == 12'h3c0));
assign Tpl_3466 = (Tpl_3101 & (Tpl_3097 == 12'h3c4));
assign Tpl_3467 = (Tpl_3100 & (Tpl_3096 == 12'h3c4));
assign Tpl_3468 = (Tpl_3101 & (Tpl_3097 == 12'h3c8));
assign Tpl_3469 = (Tpl_3100 & (Tpl_3096 == 12'h3c8));
assign Tpl_3470 = (Tpl_3101 & (Tpl_3097 == 12'h3cc));
assign Tpl_3471 = (Tpl_3100 & (Tpl_3096 == 12'h3cc));
assign Tpl_3472 = (Tpl_3101 & (Tpl_3097 == 12'h3d0));
assign Tpl_3473 = (Tpl_3100 & (Tpl_3096 == 12'h3d0));
assign Tpl_3474 = (Tpl_3101 & (Tpl_3097 == 12'h3d4));
assign Tpl_3475 = (Tpl_3100 & (Tpl_3096 == 12'h3d4));
assign Tpl_3476 = (Tpl_3101 & (Tpl_3097 == 12'h3d8));
assign Tpl_3477 = (Tpl_3100 & (Tpl_3096 == 12'h3d8));
assign Tpl_3478 = (Tpl_3101 & (Tpl_3097 == 12'h3dc));
assign Tpl_3479 = (Tpl_3100 & (Tpl_3096 == 12'h3dc));
assign Tpl_3480 = (Tpl_3101 & (Tpl_3097 == 12'h3e0));
assign Tpl_3481 = (Tpl_3100 & (Tpl_3096 == 12'h3e0));
assign Tpl_3482 = (Tpl_3101 & (Tpl_3097 == 12'h3e4));
assign Tpl_3483 = (Tpl_3100 & (Tpl_3096 == 12'h3e4));
assign Tpl_3484 = (Tpl_3101 & (Tpl_3097 == 12'h3e8));
assign Tpl_3485 = (Tpl_3100 & (Tpl_3096 == 12'h3e8));
assign Tpl_3486 = (Tpl_3101 & (Tpl_3097 == 12'h3ec));
assign Tpl_3487 = (Tpl_3100 & (Tpl_3096 == 12'h3ec));
assign Tpl_3488 = (Tpl_3101 & (Tpl_3097 == 12'h3f0));
assign Tpl_3489 = (Tpl_3100 & (Tpl_3096 == 12'h3f0));
assign Tpl_3490 = (Tpl_3101 & (Tpl_3097 == 12'h3f4));
assign Tpl_3491 = (Tpl_3100 & (Tpl_3096 == 12'h3f4));
assign Tpl_3492 = (Tpl_3101 & (Tpl_3097 == 12'h3f8));
assign Tpl_3493 = (Tpl_3100 & (Tpl_3096 == 12'h3f8));
assign Tpl_3494 = (Tpl_3101 & (Tpl_3097 == 12'h3fc));
assign Tpl_3495 = (Tpl_3100 & (Tpl_3096 == 12'h3fc));
assign Tpl_3496 = (Tpl_3101 & (Tpl_3097 == 12'h400));
assign Tpl_3497 = (Tpl_3100 & (Tpl_3096 == 12'h400));
assign Tpl_3498 = (Tpl_3101 & (Tpl_3097 == 12'h404));
assign Tpl_3499 = (Tpl_3100 & (Tpl_3096 == 12'h404));
assign Tpl_3500 = (Tpl_3101 & (Tpl_3097 == 12'h408));
assign Tpl_3501 = (Tpl_3100 & (Tpl_3096 == 12'h408));
assign Tpl_3502 = (Tpl_3101 & (Tpl_3097 == 12'h40c));
assign Tpl_3503 = (Tpl_3100 & (Tpl_3096 == 12'h40c));
assign Tpl_3504 = (Tpl_3101 & (Tpl_3097 == 12'h410));
assign Tpl_3505 = (Tpl_3100 & (Tpl_3096 == 12'h410));
assign Tpl_3506 = (Tpl_3101 & (Tpl_3097 == 12'h414));
assign Tpl_3507 = (Tpl_3100 & (Tpl_3096 == 12'h414));
assign Tpl_3508 = (Tpl_3101 & (Tpl_3097 == 12'h418));
assign Tpl_3509 = (Tpl_3100 & (Tpl_3096 == 12'h418));
assign Tpl_3510 = (Tpl_3101 & (Tpl_3097 == 12'h41c));
assign Tpl_3511 = (Tpl_3100 & (Tpl_3096 == 12'h41c));
assign Tpl_3512 = (Tpl_3101 & (Tpl_3097 == 12'h420));
assign Tpl_3513 = (Tpl_3100 & (Tpl_3096 == 12'h420));
assign Tpl_3514 = (Tpl_3101 & (Tpl_3097 == 12'h424));
assign Tpl_3515 = (Tpl_3100 & (Tpl_3096 == 12'h424));
assign Tpl_3516 = (Tpl_3101 & (Tpl_3097 == 12'h428));
assign Tpl_3517 = (Tpl_3100 & (Tpl_3096 == 12'h428));
assign Tpl_3518 = (Tpl_3101 & (Tpl_3097 == 12'h42c));
assign Tpl_3519 = (Tpl_3100 & (Tpl_3096 == 12'h42c));
assign Tpl_3520 = (Tpl_3101 & (Tpl_3097 == 12'h430));
assign Tpl_3521 = (Tpl_3100 & (Tpl_3096 == 12'h430));
assign Tpl_3522 = (Tpl_3101 & (Tpl_3097 == 12'h434));
assign Tpl_3523 = (Tpl_3100 & (Tpl_3096 == 12'h434));
assign Tpl_3524 = (Tpl_3101 & (Tpl_3097 == 12'h438));
assign Tpl_3525 = (Tpl_3100 & (Tpl_3096 == 12'h438));
assign Tpl_3526 = (Tpl_3101 & (Tpl_3097 == 12'h43c));
assign Tpl_3527 = (Tpl_3100 & (Tpl_3096 == 12'h43c));
assign Tpl_3528 = (Tpl_3101 & (Tpl_3097 == 12'h440));
assign Tpl_3529 = (Tpl_3100 & (Tpl_3096 == 12'h440));
assign Tpl_3530 = (Tpl_3101 & (Tpl_3097 == 12'h444));
assign Tpl_3531 = (Tpl_3100 & (Tpl_3096 == 12'h444));
assign Tpl_3532 = (Tpl_3101 & (Tpl_3097 == 12'h448));
assign Tpl_3533 = (Tpl_3100 & (Tpl_3096 == 12'h448));
assign Tpl_3534 = (Tpl_3101 & (Tpl_3097 == 12'h44c));
assign Tpl_3535 = (Tpl_3100 & (Tpl_3096 == 12'h44c));
assign Tpl_3536 = (Tpl_3101 & (Tpl_3097 == 12'h450));
assign Tpl_3537 = (Tpl_3100 & (Tpl_3096 == 12'h450));
assign Tpl_3538 = (Tpl_3101 & (Tpl_3097 == 12'h454));
assign Tpl_3539 = (Tpl_3100 & (Tpl_3096 == 12'h454));
assign Tpl_3540 = (Tpl_3101 & (Tpl_3097 == 12'h458));
assign Tpl_3541 = (Tpl_3100 & (Tpl_3096 == 12'h458));
assign Tpl_3542 = (Tpl_3101 & (Tpl_3097 == 12'h45c));
assign Tpl_3543 = (Tpl_3100 & (Tpl_3096 == 12'h45c));
assign Tpl_3544 = (Tpl_3101 & (Tpl_3097 == 12'h460));
assign Tpl_3545 = (Tpl_3100 & (Tpl_3096 == 12'h460));
assign Tpl_3546 = (Tpl_3101 & (Tpl_3097 == 12'h464));
assign Tpl_3547 = (Tpl_3100 & (Tpl_3096 == 12'h464));
assign Tpl_3548 = (Tpl_3101 & (Tpl_3097 == 12'h468));
assign Tpl_3549 = (Tpl_3100 & (Tpl_3096 == 12'h468));
assign Tpl_3550 = (Tpl_3101 & (Tpl_3097 == 12'h46c));
assign Tpl_3551 = (Tpl_3100 & (Tpl_3096 == 12'h46c));
assign Tpl_3552 = (Tpl_3101 & (Tpl_3097 == 12'h470));
assign Tpl_3553 = (Tpl_3100 & (Tpl_3096 == 12'h470));
assign Tpl_3554 = (Tpl_3101 & (Tpl_3097 == 12'h474));
assign Tpl_3555 = (Tpl_3100 & (Tpl_3096 == 12'h474));
assign Tpl_3556 = (Tpl_3101 & (Tpl_3097 == 12'h478));
assign Tpl_3557 = (Tpl_3100 & (Tpl_3096 == 12'h478));
assign Tpl_3558 = (Tpl_3101 & (Tpl_3097 == 12'h47c));
assign Tpl_3559 = (Tpl_3100 & (Tpl_3096 == 12'h47c));
assign Tpl_3560 = (Tpl_3101 & (Tpl_3097 == 12'he00));
assign Tpl_3561 = (Tpl_3101 & (Tpl_3097 == 12'he04));
assign Tpl_3562 = (Tpl_3101 & (Tpl_3097 == 12'he08));
assign Tpl_3563 = (Tpl_3101 & (Tpl_3097 == 12'he0c));
assign Tpl_3564 = (Tpl_3101 & (Tpl_3097 == 12'he10));
assign Tpl_3565 = (Tpl_3101 & (Tpl_3097 == 12'he14));
assign Tpl_3566 = (Tpl_3101 & (Tpl_3097 == 12'he18));
assign Tpl_3567 = (Tpl_3101 & (Tpl_3097 == 12'he1c));
assign Tpl_3568 = (Tpl_3101 & (Tpl_3097 == 12'he20));
assign Tpl_3569 = (Tpl_3101 & (Tpl_3097 == 12'he24));
assign Tpl_3570 = (Tpl_3101 & (Tpl_3097 == 12'he28));
assign Tpl_3571 = (Tpl_3101 & (Tpl_3097 == 12'he2c));
assign Tpl_3572 = (Tpl_3101 & (Tpl_3097 == 12'he30));
assign Tpl_3573 = (Tpl_3101 & (Tpl_3097 == 12'he34));
assign Tpl_3574 = (Tpl_3101 & (Tpl_3097 == 12'he38));
assign Tpl_3575 = (Tpl_3101 & (Tpl_3097 == 12'he3c));
assign Tpl_3576 = (Tpl_3101 & (Tpl_3097 == 12'he40));
assign Tpl_3577 = (Tpl_3101 & (Tpl_3097 == 12'he44));
assign Tpl_3578 = (Tpl_3101 & (Tpl_3097 == 12'he48));
assign Tpl_3579 = (Tpl_3101 & (Tpl_3097 == 12'he4c));
assign Tpl_3580 = (Tpl_3101 & (Tpl_3097 == 12'he50));
assign Tpl_3581 = (Tpl_3101 & (Tpl_3097 == 12'he54));
assign Tpl_3582 = (Tpl_3101 & (Tpl_3097 == 12'he58));
assign Tpl_3583 = (Tpl_3101 & (Tpl_3097 == 12'he5c));
assign Tpl_3584 = (Tpl_3101 & (Tpl_3097 == 12'he60));
assign Tpl_3585 = (Tpl_3101 & (Tpl_3097 == 12'he64));
assign Tpl_3586 = (Tpl_3101 & (Tpl_3097 == 12'he68));
assign Tpl_3587 = (Tpl_3101 & (Tpl_3097 == 12'he6c));
assign Tpl_3588 = (Tpl_3101 & (Tpl_3097 == 12'he70));
assign Tpl_3589 = (Tpl_3101 & (Tpl_3097 == 12'he74));
assign Tpl_3590 = (Tpl_3101 & (Tpl_3097 == 12'he78));
assign Tpl_3591 = (Tpl_3101 & (Tpl_3097 == 12'he7c));
assign Tpl_3592 = (Tpl_3101 & (Tpl_3097 == 12'he80));
assign Tpl_3593 = (Tpl_3101 & (Tpl_3097 == 12'he84));
assign Tpl_3594 = (Tpl_3101 & (Tpl_3097 == 12'he88));
assign Tpl_3595 = (Tpl_3101 & (Tpl_3097 == 12'he8c));
assign Tpl_3596 = (Tpl_3101 & (Tpl_3097 == 12'he90));
assign Tpl_3597 = (Tpl_3101 & (Tpl_3097 == 12'he94));
assign Tpl_3598 = (Tpl_3101 & (Tpl_3097 == 12'he98));
assign Tpl_3599 = (Tpl_3101 & (Tpl_3097 == 12'he9c));
assign Tpl_3600 = (Tpl_3101 & (Tpl_3097 == 12'hea0));
assign Tpl_3601 = (Tpl_3101 & (Tpl_3097 == 12'hea4));
assign Tpl_3602 = (Tpl_3101 & (Tpl_3097 == 12'hea8));
assign Tpl_3603 = (Tpl_3101 & (Tpl_3097 == 12'heac));
assign Tpl_3604 = (Tpl_3101 & (Tpl_3097 == 12'heb0));
assign Tpl_3605 = (Tpl_3101 & (Tpl_3097 == 12'heb4));
assign Tpl_3606 = (Tpl_3101 & (Tpl_3097 == 12'heb8));
assign Tpl_3607 = (Tpl_3101 & (Tpl_3097 == 12'hebc));
assign Tpl_3608 = (Tpl_3101 & (Tpl_3097 == 12'hec0));
assign Tpl_3609 = (Tpl_3101 & (Tpl_3097 == 12'hec4));
assign Tpl_3610 = (Tpl_3101 & (Tpl_3097 == 12'hec8));
assign Tpl_3611 = (Tpl_3101 & (Tpl_3097 == 12'hecc));

always @(*)
begin: WRITE_ADDR_DECODE_STATUS_PROC_3
if ((!Tpl_3100))
begin
Tpl_3104 = 2'b00;
end
else
begin
Tpl_3104[0] = 1'b0;
Tpl_3104[1] = (~(|{{Tpl_3111 , Tpl_3113 , Tpl_3115 , Tpl_3117 , Tpl_3119 , Tpl_3121 , Tpl_3123 , Tpl_3125 , Tpl_3127 , Tpl_3129 , Tpl_3131 , Tpl_3133 , Tpl_3135 , Tpl_3137 , Tpl_3139 , Tpl_3141 , Tpl_3143 , Tpl_3145 , Tpl_3147 , Tpl_3149 , Tpl_3151 , Tpl_3153 , Tpl_3155 , Tpl_3157 , Tpl_3159 , Tpl_3161 , Tpl_3163 , Tpl_3165 , Tpl_3167 , Tpl_3169 , Tpl_3171 , Tpl_3173 , Tpl_3175 , Tpl_3177 , Tpl_3179 , Tpl_3181 , Tpl_3183 , Tpl_3185 , Tpl_3187 , Tpl_3189 , Tpl_3191 , Tpl_3193 , Tpl_3195 , Tpl_3197 , Tpl_3199 , Tpl_3201 , Tpl_3203 , Tpl_3205 , Tpl_3207 , Tpl_3209 , Tpl_3211 , Tpl_3213 , Tpl_3215 , Tpl_3217 , Tpl_3219 , Tpl_3221 , Tpl_3223 , Tpl_3225 , Tpl_3227 , Tpl_3229 , Tpl_3231 , Tpl_3233 , Tpl_3235 , Tpl_3237 , Tpl_3239 , Tpl_3241 , Tpl_3243 , Tpl_3245 , Tpl_3247 , Tpl_3249 , Tpl_3251 , Tpl_3253 , Tpl_3255 , Tpl_3257 , Tpl_3259 , Tpl_3261 , Tpl_3263 , Tpl_3265 , Tpl_3267 , Tpl_3269 , Tpl_3271 , Tpl_3273 , Tpl_3275 , Tpl_3277 , Tpl_3279 , Tpl_3281 , Tpl_3283 , Tpl_3285 , Tpl_3287 , Tpl_3289 , Tpl_3291 , Tpl_3293 , Tpl_3295 , Tpl_3297 , Tpl_3299 , Tpl_3301 , Tpl_3303 , Tpl_3305 , Tpl_3307 , Tpl_3309 , Tpl_3311 , Tpl_3313 , Tpl_3315 , Tpl_3317 , Tpl_3319 , Tpl_3321 , Tpl_3323 , Tpl_3325 , Tpl_3327 , Tpl_3329 , Tpl_3331 , Tpl_3333 , Tpl_3335 , Tpl_3337 , Tpl_3339 , Tpl_3341 , Tpl_3343 , Tpl_3345 , Tpl_3347 , Tpl_3349 , Tpl_3351 , Tpl_3353 , Tpl_3355 , Tpl_3357 , Tpl_3359 , Tpl_3361 , Tpl_3363 , Tpl_3365 , Tpl_3367 , Tpl_3369 , Tpl_3371 , Tpl_3373 , Tpl_3375 , Tpl_3377 , Tpl_3379 , Tpl_3381 , Tpl_3383 , Tpl_3385 , Tpl_3387 , Tpl_3389 , Tpl_3391 , Tpl_3393 , Tpl_3395 , Tpl_3397 , Tpl_3399 , Tpl_3401 , Tpl_3403 , Tpl_3405 , Tpl_3407 , Tpl_3409 , Tpl_3411 , Tpl_3413 , Tpl_3415 , Tpl_3417 , Tpl_3419 , Tpl_3421 , Tpl_3423 , Tpl_3425 , Tpl_3427 , Tpl_3429 , Tpl_3431 , Tpl_3433 , Tpl_3435 , Tpl_3437 , Tpl_3439 , Tpl_3441 , Tpl_3443 , Tpl_3445 , Tpl_3447 , Tpl_3449 , Tpl_3451 , Tpl_3453 , Tpl_3455 , Tpl_3457 , Tpl_3459 , Tpl_3461 , Tpl_3463 , Tpl_3465 , Tpl_3467 , Tpl_3469 , Tpl_3471 , Tpl_3473 , Tpl_3475 , Tpl_3477 , Tpl_3479 , Tpl_3481 , Tpl_3483 , Tpl_3485 , Tpl_3487 , Tpl_3489 , Tpl_3491 , Tpl_3493 , Tpl_3495 , Tpl_3497 , Tpl_3499 , Tpl_3501 , Tpl_3503 , Tpl_3505 , Tpl_3507 , Tpl_3509 , Tpl_3511 , Tpl_3513 , Tpl_3515 , Tpl_3517 , Tpl_3519 , Tpl_3521 , Tpl_3523 , Tpl_3525 , Tpl_3527 , Tpl_3529 , Tpl_3531 , Tpl_3533 , Tpl_3535 , Tpl_3537 , Tpl_3539 , Tpl_3541 , Tpl_3543 , Tpl_3545 , Tpl_3547 , Tpl_3549 , Tpl_3551 , Tpl_3553 , Tpl_3555 , Tpl_3557 , Tpl_3559}}));
end
end


always @(*)
begin: READ_ADDR_DECODE_STATUS_PROC_6
if ((!Tpl_3101))
begin
Tpl_3105 = 2'b00;
end
else
begin
Tpl_3105[0] = 1'b0;
Tpl_3105[1] = (~(|{{Tpl_3110 , Tpl_3112 , Tpl_3114 , Tpl_3116 , Tpl_3118 , Tpl_3120 , Tpl_3122 , Tpl_3124 , Tpl_3126 , Tpl_3128 , Tpl_3130 , Tpl_3132 , Tpl_3134 , Tpl_3136 , Tpl_3138 , Tpl_3140 , Tpl_3142 , Tpl_3144 , Tpl_3146 , Tpl_3148 , Tpl_3150 , Tpl_3152 , Tpl_3154 , Tpl_3156 , Tpl_3158 , Tpl_3160 , Tpl_3162 , Tpl_3164 , Tpl_3166 , Tpl_3168 , Tpl_3170 , Tpl_3172 , Tpl_3174 , Tpl_3176 , Tpl_3178 , Tpl_3180 , Tpl_3182 , Tpl_3184 , Tpl_3186 , Tpl_3188 , Tpl_3190 , Tpl_3192 , Tpl_3194 , Tpl_3196 , Tpl_3198 , Tpl_3200 , Tpl_3202 , Tpl_3204 , Tpl_3206 , Tpl_3208 , Tpl_3210 , Tpl_3212 , Tpl_3214 , Tpl_3216 , Tpl_3218 , Tpl_3220 , Tpl_3222 , Tpl_3224 , Tpl_3226 , Tpl_3228 , Tpl_3230 , Tpl_3232 , Tpl_3234 , Tpl_3236 , Tpl_3238 , Tpl_3240 , Tpl_3242 , Tpl_3244 , Tpl_3246 , Tpl_3248 , Tpl_3250 , Tpl_3252 , Tpl_3254 , Tpl_3256 , Tpl_3258 , Tpl_3260 , Tpl_3262 , Tpl_3264 , Tpl_3266 , Tpl_3268 , Tpl_3270 , Tpl_3272 , Tpl_3274 , Tpl_3276 , Tpl_3278 , Tpl_3280 , Tpl_3282 , Tpl_3284 , Tpl_3286 , Tpl_3288 , Tpl_3290 , Tpl_3292 , Tpl_3294 , Tpl_3296 , Tpl_3298 , Tpl_3300 , Tpl_3302 , Tpl_3304 , Tpl_3306 , Tpl_3308 , Tpl_3310 , Tpl_3312 , Tpl_3314 , Tpl_3316 , Tpl_3318 , Tpl_3320 , Tpl_3322 , Tpl_3324 , Tpl_3326 , Tpl_3328 , Tpl_3330 , Tpl_3332 , Tpl_3334 , Tpl_3336 , Tpl_3338 , Tpl_3340 , Tpl_3342 , Tpl_3344 , Tpl_3346 , Tpl_3348 , Tpl_3350 , Tpl_3352 , Tpl_3354 , Tpl_3356 , Tpl_3358 , Tpl_3360 , Tpl_3362 , Tpl_3364 , Tpl_3366 , Tpl_3368 , Tpl_3370 , Tpl_3372 , Tpl_3374 , Tpl_3376 , Tpl_3378 , Tpl_3380 , Tpl_3382 , Tpl_3384 , Tpl_3386 , Tpl_3388 , Tpl_3390 , Tpl_3392 , Tpl_3394 , Tpl_3396 , Tpl_3398 , Tpl_3400 , Tpl_3402 , Tpl_3404 , Tpl_3406 , Tpl_3408 , Tpl_3410 , Tpl_3412 , Tpl_3414 , Tpl_3416 , Tpl_3418 , Tpl_3420 , Tpl_3422 , Tpl_3424 , Tpl_3426 , Tpl_3428 , Tpl_3430 , Tpl_3432 , Tpl_3434 , Tpl_3436 , Tpl_3438 , Tpl_3440 , Tpl_3442 , Tpl_3444 , Tpl_3446 , Tpl_3448 , Tpl_3450 , Tpl_3452 , Tpl_3454 , Tpl_3456 , Tpl_3458 , Tpl_3460 , Tpl_3462 , Tpl_3464 , Tpl_3466 , Tpl_3468 , Tpl_3470 , Tpl_3472 , Tpl_3474 , Tpl_3476 , Tpl_3478 , Tpl_3480 , Tpl_3482 , Tpl_3484 , Tpl_3486 , Tpl_3488 , Tpl_3490 , Tpl_3492 , Tpl_3494 , Tpl_3496 , Tpl_3498 , Tpl_3500 , Tpl_3502 , Tpl_3504 , Tpl_3506 , Tpl_3508 , Tpl_3510 , Tpl_3512 , Tpl_3514 , Tpl_3516 , Tpl_3518 , Tpl_3520 , Tpl_3522 , Tpl_3524 , Tpl_3526 , Tpl_3528 , Tpl_3530 , Tpl_3532 , Tpl_3534 , Tpl_3536 , Tpl_3538 , Tpl_3540 , Tpl_3542 , Tpl_3544 , Tpl_3546 , Tpl_3548 , Tpl_3550 , Tpl_3552 , Tpl_3554 , Tpl_3556 , Tpl_3558 , Tpl_3560 , Tpl_3561 , Tpl_3562 , Tpl_3563 , Tpl_3564 , Tpl_3565 , Tpl_3566 , Tpl_3567 , Tpl_3568 , Tpl_3569 , Tpl_3570 , Tpl_3571 , Tpl_3572 , Tpl_3573 , Tpl_3574 , Tpl_3575 , Tpl_3576 , Tpl_3577 , Tpl_3578 , Tpl_3579 , Tpl_3580 , Tpl_3581 , Tpl_3582 , Tpl_3583 , Tpl_3584 , Tpl_3585 , Tpl_3586 , Tpl_3587 , Tpl_3588 , Tpl_3589 , Tpl_3590 , Tpl_3591 , Tpl_3592 , Tpl_3593 , Tpl_3594 , Tpl_3595 , Tpl_3596 , Tpl_3597 , Tpl_3598 , Tpl_3599 , Tpl_3600 , Tpl_3601 , Tpl_3602 , Tpl_3603 , Tpl_3604 , Tpl_3605 , Tpl_3606 , Tpl_3607 , Tpl_3608 , Tpl_3609 , Tpl_3610 , Tpl_3611}}));
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: UCI_CMD_OP_PROC_9
if ((!Tpl_3092))
begin
Tpl_1730 <= 0;
end
else
if (Tpl_3111)
begin
Tpl_1730 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: UCI_CMD_CHAN_PROC_12
if ((!Tpl_3092))
begin
Tpl_1731 <= 0;
end
else
if (Tpl_3111)
begin
Tpl_1731 <= Tpl_3098[6:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: UCI_CMD_RANK_PROC_15
if ((!Tpl_3092))
begin
Tpl_1732 <= 0;
end
else
if (Tpl_3111)
begin
Tpl_1732 <= Tpl_3098[8:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: UCI_MR_SEL_PROC_18
if ((!Tpl_3092))
begin
Tpl_1733 <= 0;
end
else
if (Tpl_3111)
begin
Tpl_1733 <= Tpl_3098[14:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: UCI_MRS_LAST_PROC_21
if ((!Tpl_3092))
begin
Tpl_1734 <= 0;
end
else
if (Tpl_3111)
begin
Tpl_1734 <= Tpl_3098[15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: UCI_MPR_DATA_PROC_24
if ((!Tpl_3092))
begin
Tpl_1735 <= 0;
end
else
if (Tpl_3111)
begin
Tpl_1735 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_DDRT_PROC_27
if ((!Tpl_3092))
begin
Tpl_1736 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1736 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_DFI_FREQ_RATIO_PROC_30
if ((!Tpl_3092))
begin
Tpl_1737 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1737 <= Tpl_3098[4:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_DRAM_BANK_EN_PROC_33
if ((!Tpl_3092))
begin
Tpl_1738 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1738 <= Tpl_3098[7:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_SWITCH_CLOSE_PROC_36
if ((!Tpl_3092))
begin
Tpl_1739 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1739 <= Tpl_3098[8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_BANK_POLICY_PROC_39
if ((!Tpl_3092))
begin
Tpl_1740 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1740 <= Tpl_3098[9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_WR_DBI_PROC_42
if ((!Tpl_3092))
begin
Tpl_1741 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1741 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_RD_DBI_PROC_45
if ((!Tpl_3092))
begin
Tpl_1742 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1742 <= Tpl_3098[11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_DUAL_CHAN_EN_PROC_48
if ((!Tpl_3092))
begin
Tpl_1743 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1743 <= Tpl_3098[12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_DUAL_RANK_EN_PROC_51
if ((!Tpl_3092))
begin
Tpl_1744 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1744 <= Tpl_3098[13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_RD_REQ_MIN_PROC_54
if ((!Tpl_3092))
begin
Tpl_1745 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1745 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_WR_REQ_MIN_PROC_57
if ((!Tpl_3092))
begin
Tpl_1746 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1746 <= Tpl_3098[28:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_WR_CRC_PROC_60
if ((!Tpl_3092))
begin
Tpl_1747 <= 0;
end
else
if (Tpl_3113)
begin
Tpl_1747 <= Tpl_3098[29];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_CHAN_UNLOCK_PROC_63
if ((!Tpl_3092))
begin
Tpl_1748 <= 1'b1;
end
else
if (Tpl_3113)
begin
Tpl_1748 <= Tpl_3098[30];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCTL_HI_PRI_IMM_PROC_66
if ((!Tpl_3092))
begin
Tpl_1749 <= 1'b1;
end
else
if (Tpl_3113)
begin
Tpl_1749 <= Tpl_3098[31];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_REF_POST_PULL_EN_PROC_69
if ((!Tpl_3092))
begin
Tpl_1750 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1750 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_AUTO_SRX_ZQCL_PROC_72
if ((!Tpl_3092))
begin
Tpl_1751 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1751 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_REF_INT_EN_PROC_75
if ((!Tpl_3092))
begin
Tpl_1752 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1752 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_INT_GC_FSM_EN_PROC_78
if ((!Tpl_3092))
begin
Tpl_1753 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1753 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_INT_GC_FSM_CLR_PROC_81
if ((!Tpl_3092))
begin
Tpl_1754 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1754 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_REQ_TH_PROC_84
if ((!Tpl_3092))
begin
Tpl_1755 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1755 <= Tpl_3098[7:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_ZQ_AUTO_EN_PROC_87
if ((!Tpl_3092))
begin
Tpl_1756 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1756 <= Tpl_3098[8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_REF_OTF_PROC_90
if ((!Tpl_3092))
begin
Tpl_1757 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1757 <= Tpl_3098[9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DMCFG_DQS2CKEN_PROC_93
if ((!Tpl_3092))
begin
Tpl_1758 <= 0;
end
else
if (Tpl_3115)
begin
Tpl_1758 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS0_BL_PROC_96
if ((!Tpl_3092))
begin
Tpl_1759 <= 0;
end
else
if (Tpl_3117)
begin
Tpl_1759 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS0_WPRE_PROC_99
if ((!Tpl_3092))
begin
Tpl_1760 <= 1'b1;
end
else
if (Tpl_3117)
begin
Tpl_1760 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS0_RPRE_PROC_102
if ((!Tpl_3092))
begin
Tpl_1761 <= 0;
end
else
if (Tpl_3117)
begin
Tpl_1761 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS0_NWR_PROC_105
if ((!Tpl_3092))
begin
Tpl_1762 <= 0;
end
else
if (Tpl_3117)
begin
Tpl_1762 <= Tpl_3098[6:4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS0_RPST_PROC_108
if ((!Tpl_3092))
begin
Tpl_1763 <= 0;
end
else
if (Tpl_3117)
begin
Tpl_1763 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS1_BL_PROC_111
if ((!Tpl_3092))
begin
Tpl_1764 <= 0;
end
else
if (Tpl_3117)
begin
Tpl_1764 <= Tpl_3098[9:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS1_WPRE_PROC_114
if ((!Tpl_3092))
begin
Tpl_1765 <= 1'b1;
end
else
if (Tpl_3117)
begin
Tpl_1765 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS1_RPRE_PROC_117
if ((!Tpl_3092))
begin
Tpl_1766 <= 0;
end
else
if (Tpl_3117)
begin
Tpl_1766 <= Tpl_3098[11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS1_NWR_PROC_120
if ((!Tpl_3092))
begin
Tpl_1767 <= 3'h5;
end
else
if (Tpl_3117)
begin
Tpl_1767 <= Tpl_3098[14:12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR1_FS1_RPST_PROC_123
if ((!Tpl_3092))
begin
Tpl_1768 <= 0;
end
else
if (Tpl_3117)
begin
Tpl_1768 <= Tpl_3098[15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR2_FS0_RL_PROC_126
if ((!Tpl_3092))
begin
Tpl_1769 <= 3'h5;
end
else
if (Tpl_3119)
begin
Tpl_1769 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR2_FS0_WL_PROC_129
if ((!Tpl_3092))
begin
Tpl_1770 <= 3'h5;
end
else
if (Tpl_3119)
begin
Tpl_1770 <= Tpl_3098[5:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR2_FS0_WLS_PROC_132
if ((!Tpl_3092))
begin
Tpl_1771 <= 0;
end
else
if (Tpl_3119)
begin
Tpl_1771 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR2_WRLEV_PROC_135
if ((!Tpl_3092))
begin
Tpl_1772 <= 0;
end
else
if (Tpl_3119)
begin
Tpl_1772 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR2_FS1_RL_PROC_138
if ((!Tpl_3092))
begin
Tpl_1773 <= 3'h5;
end
else
if (Tpl_3119)
begin
Tpl_1773 <= Tpl_3098[10:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR2_FS1_WL_PROC_141
if ((!Tpl_3092))
begin
Tpl_1774 <= 3'h5;
end
else
if (Tpl_3119)
begin
Tpl_1774 <= Tpl_3098[13:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR2_FS1_WLS_PROC_144
if ((!Tpl_3092))
begin
Tpl_1775 <= 0;
end
else
if (Tpl_3119)
begin
Tpl_1775 <= Tpl_3098[14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS0_PUCAL_PROC_147
if ((!Tpl_3092))
begin
Tpl_1776 <= 1'b1;
end
else
if (Tpl_3121)
begin
Tpl_1776 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS0_WPST_PROC_150
if ((!Tpl_3092))
begin
Tpl_1777 <= 0;
end
else
if (Tpl_3121)
begin
Tpl_1777 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_PPRP_PROC_153
if ((!Tpl_3092))
begin
Tpl_1778 <= 0;
end
else
if (Tpl_3121)
begin
Tpl_1778 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS0_PDDS_PROC_156
if ((!Tpl_3092))
begin
Tpl_1779 <= 3'h6;
end
else
if (Tpl_3121)
begin
Tpl_1779 <= Tpl_3098[5:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS0_RDBI_PROC_159
if ((!Tpl_3092))
begin
Tpl_1780 <= 0;
end
else
if (Tpl_3121)
begin
Tpl_1780 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS0_WDBI_PROC_162
if ((!Tpl_3092))
begin
Tpl_1781 <= 0;
end
else
if (Tpl_3121)
begin
Tpl_1781 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS1_PUCAL_PROC_165
if ((!Tpl_3092))
begin
Tpl_1782 <= 1'b1;
end
else
if (Tpl_3121)
begin
Tpl_1782 <= Tpl_3098[8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS1_WPST_PROC_168
if ((!Tpl_3092))
begin
Tpl_1783 <= 0;
end
else
if (Tpl_3121)
begin
Tpl_1783 <= Tpl_3098[9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS1_PDDS_PROC_171
if ((!Tpl_3092))
begin
Tpl_1784 <= 3'h6;
end
else
if (Tpl_3121)
begin
Tpl_1784 <= Tpl_3098[12:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS1_RDBI_PROC_174
if ((!Tpl_3092))
begin
Tpl_1785 <= 0;
end
else
if (Tpl_3121)
begin
Tpl_1785 <= Tpl_3098[13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR3_FS1_WDBI_PROC_177
if ((!Tpl_3092))
begin
Tpl_1786 <= 0;
end
else
if (Tpl_3121)
begin
Tpl_1786 <= Tpl_3098[14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_FS0_DQODT_PROC_180
if ((!Tpl_3092))
begin
Tpl_1787 <= 0;
end
else
if (Tpl_3123)
begin
Tpl_1787 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_FS0_CAODT_PROC_183
if ((!Tpl_3092))
begin
Tpl_1788 <= 0;
end
else
if (Tpl_3123)
begin
Tpl_1788 <= Tpl_3098[5:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_FS1_DQODT_PROC_186
if ((!Tpl_3092))
begin
Tpl_1789 <= 0;
end
else
if (Tpl_3123)
begin
Tpl_1789 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_FS1_CAODT_PROC_189
if ((!Tpl_3092))
begin
Tpl_1790 <= 0;
end
else
if (Tpl_3123)
begin
Tpl_1790 <= Tpl_3098[11:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_NT_FS0_DQODT_PROC_192
if ((!Tpl_3092))
begin
Tpl_1791 <= 0;
end
else
if (Tpl_3125)
begin
Tpl_1791 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_NT_FS0_CAODT_PROC_195
if ((!Tpl_3092))
begin
Tpl_1792 <= 0;
end
else
if (Tpl_3125)
begin
Tpl_1792 <= Tpl_3098[5:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_NT_FS1_DQODT_PROC_198
if ((!Tpl_3092))
begin
Tpl_1793 <= 0;
end
else
if (Tpl_3125)
begin
Tpl_1793 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR11_NT_FS1_CAODT_PROC_201
if ((!Tpl_3092))
begin
Tpl_1794 <= 0;
end
else
if (Tpl_3125)
begin
Tpl_1794 <= Tpl_3098[11:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR12_FS0_VREFCAS_PROC_204
if ((!Tpl_3092))
begin
Tpl_1795 <= 6'h0d;
end
else
if (Tpl_3127)
begin
Tpl_1795 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR12_FS0_VREFCAR_PROC_207
if ((!Tpl_3092))
begin
Tpl_1796 <= 1'b1;
end
else
if (Tpl_3127)
begin
Tpl_1796 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR12_FS1_VREFCAS_PROC_210
if ((!Tpl_3092))
begin
Tpl_1797 <= 6'h0d;
end
else
if (Tpl_3127)
begin
Tpl_1797 <= Tpl_3098[12:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR12_FS1_VREFCAR_PROC_213
if ((!Tpl_3092))
begin
Tpl_1798 <= 1'b1;
end
else
if (Tpl_3127)
begin
Tpl_1798 <= Tpl_3098[13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_CBT_PROC_216
if ((!Tpl_3092))
begin
Tpl_1799 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1799 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_RPT_PROC_219
if ((!Tpl_3092))
begin
Tpl_1800 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1800 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_VRO_PROC_222
if ((!Tpl_3092))
begin
Tpl_1801 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1801 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_VRCG_PROC_225
if ((!Tpl_3092))
begin
Tpl_1802 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1802 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_RRO_PROC_228
if ((!Tpl_3092))
begin
Tpl_1803 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1803 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_DMD_PROC_231
if ((!Tpl_3092))
begin
Tpl_1804 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1804 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_FSPWR_PROC_234
if ((!Tpl_3092))
begin
Tpl_1805 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1805 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR13_FSPOP_PROC_237
if ((!Tpl_3092))
begin
Tpl_1806 <= 0;
end
else
if (Tpl_3129)
begin
Tpl_1806 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR14_FS0_VREFDQS_PROC_240
if ((!Tpl_3092))
begin
Tpl_1807 <= 6'h0d;
end
else
if (Tpl_3131)
begin
Tpl_1807 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR14_FS0_VREFDQR_PROC_243
if ((!Tpl_3092))
begin
Tpl_1808 <= 1'b1;
end
else
if (Tpl_3131)
begin
Tpl_1808 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR14_FS1_VREFDQS_PROC_246
if ((!Tpl_3092))
begin
Tpl_1809 <= 6'h0d;
end
else
if (Tpl_3131)
begin
Tpl_1809 <= Tpl_3098[12:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR14_FS1_VREFDQR_PROC_249
if ((!Tpl_3092))
begin
Tpl_1810 <= 1'b1;
end
else
if (Tpl_3131)
begin
Tpl_1810 <= Tpl_3098[13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS0_SOCODT_PROC_252
if ((!Tpl_3092))
begin
Tpl_1811 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1811 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS0_ODTECK_PROC_255
if ((!Tpl_3092))
begin
Tpl_1812 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1812 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS0_ODTECS_PROC_258
if ((!Tpl_3092))
begin
Tpl_1813 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1813 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS0_ODTDCA_PROC_261
if ((!Tpl_3092))
begin
Tpl_1814 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1814 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_ODTDX8_PROC_264
if ((!Tpl_3092))
begin
Tpl_1815 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1815 <= Tpl_3098[7:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS1_SOCODT_PROC_267
if ((!Tpl_3092))
begin
Tpl_1816 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1816 <= Tpl_3098[10:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS1_ODTECK_PROC_270
if ((!Tpl_3092))
begin
Tpl_1817 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1817 <= Tpl_3098[11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS1_ODTECS_PROC_273
if ((!Tpl_3092))
begin
Tpl_1818 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1818 <= Tpl_3098[12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_FS1_ODTDCA_PROC_276
if ((!Tpl_3092))
begin
Tpl_1819 <= 0;
end
else
if (Tpl_3133)
begin
Tpl_1819 <= Tpl_3098[13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS0_SOCODT_PROC_279
if ((!Tpl_3092))
begin
Tpl_1820 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1820 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS0_ODTECK_PROC_282
if ((!Tpl_3092))
begin
Tpl_1821 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1821 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS0_ODTECS_PROC_285
if ((!Tpl_3092))
begin
Tpl_1822 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1822 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS0_ODTDCA_PROC_288
if ((!Tpl_3092))
begin
Tpl_1823 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1823 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_ODTDX8_PROC_291
if ((!Tpl_3092))
begin
Tpl_1824 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1824 <= Tpl_3098[7:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS1_SOCODT_PROC_294
if ((!Tpl_3092))
begin
Tpl_1825 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1825 <= Tpl_3098[10:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS1_ODTECK_PROC_297
if ((!Tpl_3092))
begin
Tpl_1826 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1826 <= Tpl_3098[11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS1_ODTECS_PROC_300
if ((!Tpl_3092))
begin
Tpl_1827 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1827 <= Tpl_3098[12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR4_LPMR22_NT_FS1_ODTDCA_PROC_303
if ((!Tpl_3092))
begin
Tpl_1828 <= 0;
end
else
if (Tpl_3135)
begin
Tpl_1828 <= Tpl_3098[13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR1_BL_PROC_306
if ((!Tpl_3092))
begin
Tpl_1829 <= 0;
end
else
if (Tpl_3137)
begin
Tpl_1829 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR1_NWR_PROC_309
if ((!Tpl_3092))
begin
Tpl_1830 <= 0;
end
else
if (Tpl_3137)
begin
Tpl_1830 <= Tpl_3098[5:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR2_RLWL_PROC_312
if ((!Tpl_3092))
begin
Tpl_1831 <= 0;
end
else
if (Tpl_3139)
begin
Tpl_1831 <= Tpl_3098[3:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR2_NWRE_PROC_315
if ((!Tpl_3092))
begin
Tpl_1832 <= 0;
end
else
if (Tpl_3139)
begin
Tpl_1832 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR2_WLS_PROC_318
if ((!Tpl_3092))
begin
Tpl_1833 <= 0;
end
else
if (Tpl_3139)
begin
Tpl_1833 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR2_WRLEV_PROC_321
if ((!Tpl_3092))
begin
Tpl_1834 <= 0;
end
else
if (Tpl_3139)
begin
Tpl_1834 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR3_DS_PROC_324
if ((!Tpl_3092))
begin
Tpl_1835 <= 0;
end
else
if (Tpl_3141)
begin
Tpl_1835 <= Tpl_3098[3:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR10_CALI_CODE_PROC_327
if ((!Tpl_3092))
begin
Tpl_1836 <= 0;
end
else
if (Tpl_3143)
begin
Tpl_1836 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR11_DQODT_PROC_330
if ((!Tpl_3092))
begin
Tpl_1837 <= 0;
end
else
if (Tpl_3145)
begin
Tpl_1837 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR11_PD_PROC_333
if ((!Tpl_3092))
begin
Tpl_1838 <= 0;
end
else
if (Tpl_3145)
begin
Tpl_1838 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR16_PASR_B_PROC_336
if ((!Tpl_3092))
begin
Tpl_1839 <= 0;
end
else
if (Tpl_3147)
begin
Tpl_1839 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: LPDDR3_LPMR17_PASR_S_PROC_339
if ((!Tpl_3092))
begin
Tpl_1840 <= 0;
end
else
if (Tpl_3149)
begin
Tpl_1840 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR0_WR_PROC_342
if ((!Tpl_3092))
begin
Tpl_1841 <= 0;
end
else
if (Tpl_3151)
begin
Tpl_1841 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR0_DLLRST_PROC_345
if ((!Tpl_3092))
begin
Tpl_1842 <= 0;
end
else
if (Tpl_3151)
begin
Tpl_1842 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR0_TM_PROC_348
if ((!Tpl_3092))
begin
Tpl_1843 <= 0;
end
else
if (Tpl_3151)
begin
Tpl_1843 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR0_CL_PROC_351
if ((!Tpl_3092))
begin
Tpl_1844 <= 0;
end
else
if (Tpl_3151)
begin
Tpl_1844 <= Tpl_3098[8:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR0_RBT_PROC_354
if ((!Tpl_3092))
begin
Tpl_1845 <= 0;
end
else
if (Tpl_3151)
begin
Tpl_1845 <= Tpl_3098[9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR0_BL_PROC_357
if ((!Tpl_3092))
begin
Tpl_1846 <= 0;
end
else
if (Tpl_3151)
begin
Tpl_1846 <= Tpl_3098[11:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR1_QOFF_PROC_360
if ((!Tpl_3092))
begin
Tpl_1847 <= 0;
end
else
if (Tpl_3153)
begin
Tpl_1847 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR1_TDQS_PROC_363
if ((!Tpl_3092))
begin
Tpl_1848 <= 0;
end
else
if (Tpl_3153)
begin
Tpl_1848 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR1_WRLVL_PROC_366
if ((!Tpl_3092))
begin
Tpl_1849 <= 0;
end
else
if (Tpl_3153)
begin
Tpl_1849 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR1_RTTNOM_PROC_369
if ((!Tpl_3092))
begin
Tpl_1850 <= 0;
end
else
if (Tpl_3153)
begin
Tpl_1850 <= Tpl_3098[5:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR1_DIC_PROC_372
if ((!Tpl_3092))
begin
Tpl_1851 <= 0;
end
else
if (Tpl_3153)
begin
Tpl_1851 <= Tpl_3098[7:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR1_DLLEN_PROC_375
if ((!Tpl_3092))
begin
Tpl_1852 <= 0;
end
else
if (Tpl_3153)
begin
Tpl_1852 <= Tpl_3098[8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR1_AL_PROC_378
if ((!Tpl_3092))
begin
Tpl_1853 <= 0;
end
else
if (Tpl_3153)
begin
Tpl_1853 <= Tpl_3098[11:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR2_RTTWR_PROC_381
if ((!Tpl_3092))
begin
Tpl_1854 <= 0;
end
else
if (Tpl_3155)
begin
Tpl_1854 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR2_LASR_PROC_384
if ((!Tpl_3092))
begin
Tpl_1855 <= 0;
end
else
if (Tpl_3155)
begin
Tpl_1855 <= Tpl_3098[3:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR2_CWL_PROC_387
if ((!Tpl_3092))
begin
Tpl_1856 <= 0;
end
else
if (Tpl_3155)
begin
Tpl_1856 <= Tpl_3098[6:4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR2_WRCRC_PROC_390
if ((!Tpl_3092))
begin
Tpl_1857 <= 0;
end
else
if (Tpl_3155)
begin
Tpl_1857 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_MPRO_PROC_393
if ((!Tpl_3092))
begin
Tpl_1858 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1858 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_MPRP_PROC_396
if ((!Tpl_3092))
begin
Tpl_1859 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1859 <= Tpl_3098[2:1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_GDWN_PROC_399
if ((!Tpl_3092))
begin
Tpl_1860 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1860 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_PDA_PROC_402
if ((!Tpl_3092))
begin
Tpl_1861 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1861 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_TSR_PROC_405
if ((!Tpl_3092))
begin
Tpl_1862 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1862 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_FGRM_PROC_408
if ((!Tpl_3092))
begin
Tpl_1863 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1863 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_WCL_PROC_411
if ((!Tpl_3092))
begin
Tpl_1864 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1864 <= Tpl_3098[10:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR3_MPRF_PROC_414
if ((!Tpl_3092))
begin
Tpl_1865 <= 0;
end
else
if (Tpl_3157)
begin
Tpl_1865 <= Tpl_3098[12:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_MPDWN_PROC_417
if ((!Tpl_3092))
begin
Tpl_1866 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1866 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_TCRR_PROC_420
if ((!Tpl_3092))
begin
Tpl_1867 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1867 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_TCRM_PROC_423
if ((!Tpl_3092))
begin
Tpl_1868 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1868 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_IVREF_PROC_426
if ((!Tpl_3092))
begin
Tpl_1869 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1869 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_CAL_PROC_429
if ((!Tpl_3092))
begin
Tpl_1870 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1870 <= Tpl_3098[6:4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_SRAB_PROC_432
if ((!Tpl_3092))
begin
Tpl_1871 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1871 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_RPTM_PROC_435
if ((!Tpl_3092))
begin
Tpl_1872 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1872 <= Tpl_3098[8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_RPRE_PROC_438
if ((!Tpl_3092))
begin
Tpl_1873 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1873 <= Tpl_3098[9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR4_WPRE_PROC_441
if ((!Tpl_3092))
begin
Tpl_1874 <= 0;
end
else
if (Tpl_3159)
begin
Tpl_1874 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_CAPL_PROC_444
if ((!Tpl_3092))
begin
Tpl_1875 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1875 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_CRCEC_PROC_447
if ((!Tpl_3092))
begin
Tpl_1876 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1876 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_CAPS_PROC_450
if ((!Tpl_3092))
begin
Tpl_1877 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1877 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_ODTB_PROC_453
if ((!Tpl_3092))
begin
Tpl_1878 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1878 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_RTTPK_PROC_456
if ((!Tpl_3092))
begin
Tpl_1879 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1879 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_CAPPE_PROC_459
if ((!Tpl_3092))
begin
Tpl_1880 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1880 <= Tpl_3098[9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_DM_PROC_462
if ((!Tpl_3092))
begin
Tpl_1881 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1881 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_WDBI_PROC_465
if ((!Tpl_3092))
begin
Tpl_1882 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1882 <= Tpl_3098[11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR5_RDBI_PROC_468
if ((!Tpl_3092))
begin
Tpl_1883 <= 0;
end
else
if (Tpl_3161)
begin
Tpl_1883 <= Tpl_3098[12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR6_VREFDQ_PROC_471
if ((!Tpl_3092))
begin
Tpl_1884 <= 0;
end
else
if (Tpl_3163)
begin
Tpl_1884 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR6_VREFDQR_PROC_474
if ((!Tpl_3092))
begin
Tpl_1885 <= 0;
end
else
if (Tpl_3163)
begin
Tpl_1885 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR6_VREFDQE_PROC_477
if ((!Tpl_3092))
begin
Tpl_1886 <= 0;
end
else
if (Tpl_3163)
begin
Tpl_1886 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR4_MR6_CCDL_PROC_480
if ((!Tpl_3092))
begin
Tpl_1887 <= 0;
end
else
if (Tpl_3163)
begin
Tpl_1887 <= Tpl_3098[10:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR0_PPD_PROC_483
if ((!Tpl_3092))
begin
Tpl_1888 <= 0;
end
else
if (Tpl_3165)
begin
Tpl_1888 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR0_WR_PROC_486
if ((!Tpl_3092))
begin
Tpl_1889 <= 0;
end
else
if (Tpl_3165)
begin
Tpl_1889 <= Tpl_3098[3:1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR0_DLLRST_PROC_489
if ((!Tpl_3092))
begin
Tpl_1890 <= 0;
end
else
if (Tpl_3165)
begin
Tpl_1890 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR0_TM_PROC_492
if ((!Tpl_3092))
begin
Tpl_1891 <= 0;
end
else
if (Tpl_3165)
begin
Tpl_1891 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR0_CL_PROC_495
if ((!Tpl_3092))
begin
Tpl_1892 <= 0;
end
else
if (Tpl_3165)
begin
Tpl_1892 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR0_RBT_PROC_498
if ((!Tpl_3092))
begin
Tpl_1893 <= 0;
end
else
if (Tpl_3165)
begin
Tpl_1893 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR0_BL_PROC_501
if ((!Tpl_3092))
begin
Tpl_1894 <= 0;
end
else
if (Tpl_3165)
begin
Tpl_1894 <= Tpl_3098[13:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR1_QOFF_PROC_504
if ((!Tpl_3092))
begin
Tpl_1895 <= 0;
end
else
if (Tpl_3167)
begin
Tpl_1895 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR1_TDQS_PROC_507
if ((!Tpl_3092))
begin
Tpl_1896 <= 0;
end
else
if (Tpl_3167)
begin
Tpl_1896 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR1_WRLVL_PROC_510
if ((!Tpl_3092))
begin
Tpl_1897 <= 0;
end
else
if (Tpl_3167)
begin
Tpl_1897 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR1_RTTNOM_PROC_513
if ((!Tpl_3092))
begin
Tpl_1898 <= 0;
end
else
if (Tpl_3167)
begin
Tpl_1898 <= Tpl_3098[5:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR1_DIC_PROC_516
if ((!Tpl_3092))
begin
Tpl_1899 <= 0;
end
else
if (Tpl_3167)
begin
Tpl_1899 <= Tpl_3098[7:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR1_DLLEN_PROC_519
if ((!Tpl_3092))
begin
Tpl_1900 <= 0;
end
else
if (Tpl_3167)
begin
Tpl_1900 <= Tpl_3098[8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR1_AL_PROC_522
if ((!Tpl_3092))
begin
Tpl_1901 <= 0;
end
else
if (Tpl_3167)
begin
Tpl_1901 <= Tpl_3098[10:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR2_RTTWR_PROC_525
if ((!Tpl_3092))
begin
Tpl_1902 <= 0;
end
else
if (Tpl_3169)
begin
Tpl_1902 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR2_SRT_PROC_528
if ((!Tpl_3092))
begin
Tpl_1903 <= 0;
end
else
if (Tpl_3169)
begin
Tpl_1903 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR2_LASR_PROC_531
if ((!Tpl_3092))
begin
Tpl_1904 <= 0;
end
else
if (Tpl_3169)
begin
Tpl_1904 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR2_CWL_PROC_534
if ((!Tpl_3092))
begin
Tpl_1905 <= 0;
end
else
if (Tpl_3169)
begin
Tpl_1905 <= Tpl_3098[6:4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR2_PASR_PROC_537
if ((!Tpl_3092))
begin
Tpl_1906 <= 0;
end
else
if (Tpl_3169)
begin
Tpl_1906 <= Tpl_3098[9:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR3_MPRO_PROC_540
if ((!Tpl_3092))
begin
Tpl_1907 <= 0;
end
else
if (Tpl_3171)
begin
Tpl_1907 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDR3_MR3_MPRP_PROC_543
if ((!Tpl_3092))
begin
Tpl_1908 <= 0;
end
else
if (Tpl_3171)
begin
Tpl_1908 <= Tpl_3098[2:1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_EXT_PRI_PROC_546
if ((!Tpl_3092))
begin
Tpl_1909 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1909 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_MAX_PRI_PROC_549
if ((!Tpl_3092))
begin
Tpl_1910 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1910 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_ARQ_LVL_HI_PROC_552
if ((!Tpl_3092))
begin
Tpl_1911 <= 4'hf;
end
else
if (Tpl_3173)
begin
Tpl_1911 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_ARQ_LVL_LO_PROC_555
if ((!Tpl_3092))
begin
Tpl_1912 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1912 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_AWQ_LVL_HI_PROC_558
if ((!Tpl_3092))
begin
Tpl_1913 <= 4'hf;
end
else
if (Tpl_3173)
begin
Tpl_1913 <= Tpl_3098[13:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_AWQ_LVL_LO_PROC_561
if ((!Tpl_3092))
begin
Tpl_1914 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1914 <= Tpl_3098[17:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_ARQ_LAT_BARRIER_EN_PROC_564
if ((!Tpl_3092))
begin
Tpl_1915 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1915 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_AWQ_LAT_BARRIER_EN_PROC_567
if ((!Tpl_3092))
begin
Tpl_1916 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1916 <= Tpl_3098[19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_ARQ_OOO_EN_PROC_570
if ((!Tpl_3092))
begin
Tpl_1917 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1917 <= Tpl_3098[20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_AWQ_OOO_EN_PROC_573
if ((!Tpl_3092))
begin
Tpl_1918 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1918 <= Tpl_3098[21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_ACQ_REALTIME_EN_PROC_576
if ((!Tpl_3092))
begin
Tpl_1919 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1919 <= Tpl_3098[22];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_WM_ENABLE_PROC_579
if ((!Tpl_3092))
begin
Tpl_1920 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1920 <= Tpl_3098[23];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_ARQ_LAHEAD_EN_PROC_582
if ((!Tpl_3092))
begin
Tpl_1921 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1921 <= Tpl_3098[24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_AWQ_LAHEAD_EN_PROC_585
if ((!Tpl_3092))
begin
Tpl_1922 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1922 <= Tpl_3098[25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_NARROW_MODE_PROC_588
if ((!Tpl_3092))
begin
Tpl_1923 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1923 <= Tpl_3098[26];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT0_NARROW_SIZE_PROC_591
if ((!Tpl_3092))
begin
Tpl_1924 <= 0;
end
else
if (Tpl_3173)
begin
Tpl_1924 <= Tpl_3098[29:27];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_EXT_PRI_PROC_594
if ((!Tpl_3092))
begin
Tpl_1925 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1925 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_MAX_PRI_PROC_597
if ((!Tpl_3092))
begin
Tpl_1926 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1926 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_ARQ_LVL_HI_PROC_600
if ((!Tpl_3092))
begin
Tpl_1927 <= 4'hf;
end
else
if (Tpl_3175)
begin
Tpl_1927 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_ARQ_LVL_LO_PROC_603
if ((!Tpl_3092))
begin
Tpl_1928 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1928 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_AWQ_LVL_HI_PROC_606
if ((!Tpl_3092))
begin
Tpl_1929 <= 4'hf;
end
else
if (Tpl_3175)
begin
Tpl_1929 <= Tpl_3098[13:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_AWQ_LVL_LO_PROC_609
if ((!Tpl_3092))
begin
Tpl_1930 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1930 <= Tpl_3098[17:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_ARQ_LAT_BARRIER_EN_PROC_612
if ((!Tpl_3092))
begin
Tpl_1931 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1931 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_AWQ_LAT_BARRIER_EN_PROC_615
if ((!Tpl_3092))
begin
Tpl_1932 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1932 <= Tpl_3098[19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_ARQ_OOO_EN_PROC_618
if ((!Tpl_3092))
begin
Tpl_1933 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1933 <= Tpl_3098[20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_AWQ_OOO_EN_PROC_621
if ((!Tpl_3092))
begin
Tpl_1934 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1934 <= Tpl_3098[21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_ACQ_REALTIME_EN_PROC_624
if ((!Tpl_3092))
begin
Tpl_1935 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1935 <= Tpl_3098[22];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_WM_ENABLE_PROC_627
if ((!Tpl_3092))
begin
Tpl_1936 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1936 <= Tpl_3098[23];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_ARQ_LAHEAD_EN_PROC_630
if ((!Tpl_3092))
begin
Tpl_1937 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1937 <= Tpl_3098[24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_AWQ_LAHEAD_EN_PROC_633
if ((!Tpl_3092))
begin
Tpl_1938 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1938 <= Tpl_3098[25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_NARROW_MODE_PROC_636
if ((!Tpl_3092))
begin
Tpl_1939 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1939 <= Tpl_3098[26];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT1_NARROW_SIZE_PROC_639
if ((!Tpl_3092))
begin
Tpl_1940 <= 0;
end
else
if (Tpl_3175)
begin
Tpl_1940 <= Tpl_3098[29:27];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_EXT_PRI_PROC_642
if ((!Tpl_3092))
begin
Tpl_1941 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1941 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_MAX_PRI_PROC_645
if ((!Tpl_3092))
begin
Tpl_1942 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1942 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_ARQ_LVL_HI_PROC_648
if ((!Tpl_3092))
begin
Tpl_1943 <= 4'hf;
end
else
if (Tpl_3177)
begin
Tpl_1943 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_ARQ_LVL_LO_PROC_651
if ((!Tpl_3092))
begin
Tpl_1944 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1944 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_AWQ_LVL_HI_PROC_654
if ((!Tpl_3092))
begin
Tpl_1945 <= 4'hf;
end
else
if (Tpl_3177)
begin
Tpl_1945 <= Tpl_3098[13:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_AWQ_LVL_LO_PROC_657
if ((!Tpl_3092))
begin
Tpl_1946 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1946 <= Tpl_3098[17:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_ARQ_LAT_BARRIER_EN_PROC_660
if ((!Tpl_3092))
begin
Tpl_1947 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1947 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_AWQ_LAT_BARRIER_EN_PROC_663
if ((!Tpl_3092))
begin
Tpl_1948 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1948 <= Tpl_3098[19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_ARQ_OOO_EN_PROC_666
if ((!Tpl_3092))
begin
Tpl_1949 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1949 <= Tpl_3098[20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_AWQ_OOO_EN_PROC_669
if ((!Tpl_3092))
begin
Tpl_1950 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1950 <= Tpl_3098[21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_ACQ_REALTIME_EN_PROC_672
if ((!Tpl_3092))
begin
Tpl_1951 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1951 <= Tpl_3098[22];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_WM_ENABLE_PROC_675
if ((!Tpl_3092))
begin
Tpl_1952 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1952 <= Tpl_3098[23];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_ARQ_LAHEAD_EN_PROC_678
if ((!Tpl_3092))
begin
Tpl_1953 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1953 <= Tpl_3098[24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_AWQ_LAHEAD_EN_PROC_681
if ((!Tpl_3092))
begin
Tpl_1954 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1954 <= Tpl_3098[25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_NARROW_MODE_PROC_684
if ((!Tpl_3092))
begin
Tpl_1955 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1955 <= Tpl_3098[26];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT2_NARROW_SIZE_PROC_687
if ((!Tpl_3092))
begin
Tpl_1956 <= 0;
end
else
if (Tpl_3177)
begin
Tpl_1956 <= Tpl_3098[29:27];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_EXT_PRI_PROC_690
if ((!Tpl_3092))
begin
Tpl_1957 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1957 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_MAX_PRI_PROC_693
if ((!Tpl_3092))
begin
Tpl_1958 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1958 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_ARQ_LVL_HI_PROC_696
if ((!Tpl_3092))
begin
Tpl_1959 <= 4'hf;
end
else
if (Tpl_3179)
begin
Tpl_1959 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_ARQ_LVL_LO_PROC_699
if ((!Tpl_3092))
begin
Tpl_1960 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1960 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_AWQ_LVL_HI_PROC_702
if ((!Tpl_3092))
begin
Tpl_1961 <= 4'hf;
end
else
if (Tpl_3179)
begin
Tpl_1961 <= Tpl_3098[13:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_AWQ_LVL_LO_PROC_705
if ((!Tpl_3092))
begin
Tpl_1962 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1962 <= Tpl_3098[17:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_ARQ_LAT_BARRIER_EN_PROC_708
if ((!Tpl_3092))
begin
Tpl_1963 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1963 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_AWQ_LAT_BARRIER_EN_PROC_711
if ((!Tpl_3092))
begin
Tpl_1964 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1964 <= Tpl_3098[19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_ARQ_OOO_EN_PROC_714
if ((!Tpl_3092))
begin
Tpl_1965 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1965 <= Tpl_3098[20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_AWQ_OOO_EN_PROC_717
if ((!Tpl_3092))
begin
Tpl_1966 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1966 <= Tpl_3098[21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_ACQ_REALTIME_EN_PROC_720
if ((!Tpl_3092))
begin
Tpl_1967 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1967 <= Tpl_3098[22];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_WM_ENABLE_PROC_723
if ((!Tpl_3092))
begin
Tpl_1968 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1968 <= Tpl_3098[23];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_ARQ_LAHEAD_EN_PROC_726
if ((!Tpl_3092))
begin
Tpl_1969 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1969 <= Tpl_3098[24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_AWQ_LAHEAD_EN_PROC_729
if ((!Tpl_3092))
begin
Tpl_1970 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1970 <= Tpl_3098[25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_NARROW_MODE_PROC_732
if ((!Tpl_3092))
begin
Tpl_1971 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1971 <= Tpl_3098[26];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG0_RT3_NARROW_SIZE_PROC_735
if ((!Tpl_3092))
begin
Tpl_1972 <= 0;
end
else
if (Tpl_3179)
begin
Tpl_1972 <= Tpl_3098[29:27];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT0_ARQ_LAT_BARRIER_PROC_738
if ((!Tpl_3092))
begin
Tpl_1973 <= 0;
end
else
if (Tpl_3181)
begin
Tpl_1973 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT0_AWQ_LAT_BARRIER_PROC_741
if ((!Tpl_3092))
begin
Tpl_1974 <= 0;
end
else
if (Tpl_3181)
begin
Tpl_1974 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT0_ARQ_STARV_TH_PROC_744
if ((!Tpl_3092))
begin
Tpl_1975 <= 0;
end
else
if (Tpl_3181)
begin
Tpl_1975 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT0_AWQ_STARV_TH_PROC_747
if ((!Tpl_3092))
begin
Tpl_1976 <= 0;
end
else
if (Tpl_3181)
begin
Tpl_1976 <= Tpl_3098[31:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT1_ARQ_LAT_BARRIER_PROC_750
if ((!Tpl_3092))
begin
Tpl_1977 <= 0;
end
else
if (Tpl_3183)
begin
Tpl_1977 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT1_AWQ_LAT_BARRIER_PROC_753
if ((!Tpl_3092))
begin
Tpl_1978 <= 0;
end
else
if (Tpl_3183)
begin
Tpl_1978 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT1_ARQ_STARV_TH_PROC_756
if ((!Tpl_3092))
begin
Tpl_1979 <= 0;
end
else
if (Tpl_3183)
begin
Tpl_1979 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT1_AWQ_STARV_TH_PROC_759
if ((!Tpl_3092))
begin
Tpl_1980 <= 0;
end
else
if (Tpl_3183)
begin
Tpl_1980 <= Tpl_3098[31:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT2_ARQ_LAT_BARRIER_PROC_762
if ((!Tpl_3092))
begin
Tpl_1981 <= 0;
end
else
if (Tpl_3185)
begin
Tpl_1981 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT2_AWQ_LAT_BARRIER_PROC_765
if ((!Tpl_3092))
begin
Tpl_1982 <= 0;
end
else
if (Tpl_3185)
begin
Tpl_1982 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT2_ARQ_STARV_TH_PROC_768
if ((!Tpl_3092))
begin
Tpl_1983 <= 0;
end
else
if (Tpl_3185)
begin
Tpl_1983 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT2_AWQ_STARV_TH_PROC_771
if ((!Tpl_3092))
begin
Tpl_1984 <= 0;
end
else
if (Tpl_3185)
begin
Tpl_1984 <= Tpl_3098[31:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT3_ARQ_LAT_BARRIER_PROC_774
if ((!Tpl_3092))
begin
Tpl_1985 <= 0;
end
else
if (Tpl_3187)
begin
Tpl_1985 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT3_AWQ_LAT_BARRIER_PROC_777
if ((!Tpl_3092))
begin
Tpl_1986 <= 0;
end
else
if (Tpl_3187)
begin
Tpl_1986 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT3_ARQ_STARV_TH_PROC_780
if ((!Tpl_3092))
begin
Tpl_1987 <= 0;
end
else
if (Tpl_3187)
begin
Tpl_1987 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG1_RT3_AWQ_STARV_TH_PROC_783
if ((!Tpl_3092))
begin
Tpl_1988 <= 0;
end
else
if (Tpl_3187)
begin
Tpl_1988 <= Tpl_3098[31:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG2_RT0_SIZE_MAX_PROC_786
if ((!Tpl_3092))
begin
Tpl_1989 <= 0;
end
else
if (Tpl_3189)
begin
Tpl_1989 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG2_RT1_SIZE_MAX_PROC_789
if ((!Tpl_3092))
begin
Tpl_1990 <= 0;
end
else
if (Tpl_3191)
begin
Tpl_1990 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG2_RT2_SIZE_MAX_PROC_792
if ((!Tpl_3092))
begin
Tpl_1991 <= 0;
end
else
if (Tpl_3193)
begin
Tpl_1991 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTCFG2_RT3_SIZE_MAX_PROC_795
if ((!Tpl_3092))
begin
Tpl_1992 <= 0;
end
else
if (Tpl_3195)
begin
Tpl_1992 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR0_COL_ADDR_MAP_B0_PROC_798
if ((!Tpl_3092))
begin
Tpl_1993 <= 0;
end
else
if (Tpl_3197)
begin
Tpl_1993 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR0_COL_ADDR_MAP_B1_PROC_801
if ((!Tpl_3092))
begin
Tpl_1994 <= 0;
end
else
if (Tpl_3197)
begin
Tpl_1994 <= Tpl_3098[9:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR0_COL_ADDR_MAP_B2_PROC_804
if ((!Tpl_3092))
begin
Tpl_1995 <= 0;
end
else
if (Tpl_3197)
begin
Tpl_1995 <= Tpl_3098[14:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR0_COL_ADDR_MAP_B3_PROC_807
if ((!Tpl_3092))
begin
Tpl_1996 <= 0;
end
else
if (Tpl_3197)
begin
Tpl_1996 <= Tpl_3098[19:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR0_COL_ADDR_MAP_B4_PROC_810
if ((!Tpl_3092))
begin
Tpl_1997 <= 0;
end
else
if (Tpl_3197)
begin
Tpl_1997 <= Tpl_3098[24:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR0_COL_ADDR_MAP_B5_PROC_813
if ((!Tpl_3092))
begin
Tpl_1998 <= 0;
end
else
if (Tpl_3197)
begin
Tpl_1998 <= Tpl_3098[29:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR1_COL_ADDR_MAP_B6_PROC_816
if ((!Tpl_3092))
begin
Tpl_1999 <= 0;
end
else
if (Tpl_3199)
begin
Tpl_1999 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR1_COL_ADDR_MAP_B7_PROC_819
if ((!Tpl_3092))
begin
Tpl_2000 <= 0;
end
else
if (Tpl_3199)
begin
Tpl_2000 <= Tpl_3098[9:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR1_COL_ADDR_MAP_B8_PROC_822
if ((!Tpl_3092))
begin
Tpl_2001 <= 0;
end
else
if (Tpl_3199)
begin
Tpl_2001 <= Tpl_3098[14:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR1_COL_ADDR_MAP_B9_PROC_825
if ((!Tpl_3092))
begin
Tpl_2002 <= 0;
end
else
if (Tpl_3199)
begin
Tpl_2002 <= Tpl_3098[19:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR1_COL_ADDR_MAP_B10_PROC_828
if ((!Tpl_3092))
begin
Tpl_2003 <= 0;
end
else
if (Tpl_3199)
begin
Tpl_2003 <= Tpl_3098[24:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR2_ROW_ADDR_MAP_B0_PROC_831
if ((!Tpl_3092))
begin
Tpl_2004 <= 0;
end
else
if (Tpl_3201)
begin
Tpl_2004 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR2_ROW_ADDR_MAP_B1_PROC_834
if ((!Tpl_3092))
begin
Tpl_2005 <= 0;
end
else
if (Tpl_3201)
begin
Tpl_2005 <= Tpl_3098[9:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR2_ROW_ADDR_MAP_B2_PROC_837
if ((!Tpl_3092))
begin
Tpl_2006 <= 0;
end
else
if (Tpl_3201)
begin
Tpl_2006 <= Tpl_3098[14:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR2_ROW_ADDR_MAP_B3_PROC_840
if ((!Tpl_3092))
begin
Tpl_2007 <= 0;
end
else
if (Tpl_3201)
begin
Tpl_2007 <= Tpl_3098[19:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR2_ROW_ADDR_MAP_B4_PROC_843
if ((!Tpl_3092))
begin
Tpl_2008 <= 0;
end
else
if (Tpl_3201)
begin
Tpl_2008 <= Tpl_3098[24:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR2_ROW_ADDR_MAP_B5_PROC_846
if ((!Tpl_3092))
begin
Tpl_2009 <= 0;
end
else
if (Tpl_3201)
begin
Tpl_2009 <= Tpl_3098[29:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR3_ROW_ADDR_MAP_B6_PROC_849
if ((!Tpl_3092))
begin
Tpl_2010 <= 0;
end
else
if (Tpl_3203)
begin
Tpl_2010 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR3_ROW_ADDR_MAP_B7_PROC_852
if ((!Tpl_3092))
begin
Tpl_2011 <= 0;
end
else
if (Tpl_3203)
begin
Tpl_2011 <= Tpl_3098[9:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR3_ROW_ADDR_MAP_B8_PROC_855
if ((!Tpl_3092))
begin
Tpl_2012 <= 0;
end
else
if (Tpl_3203)
begin
Tpl_2012 <= Tpl_3098[14:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR3_ROW_ADDR_MAP_B9_PROC_858
if ((!Tpl_3092))
begin
Tpl_2013 <= 0;
end
else
if (Tpl_3203)
begin
Tpl_2013 <= Tpl_3098[19:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR3_ROW_ADDR_MAP_B10_PROC_861
if ((!Tpl_3092))
begin
Tpl_2014 <= 0;
end
else
if (Tpl_3203)
begin
Tpl_2014 <= Tpl_3098[24:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR3_ROW_ADDR_MAP_B11_PROC_864
if ((!Tpl_3092))
begin
Tpl_2015 <= 0;
end
else
if (Tpl_3203)
begin
Tpl_2015 <= Tpl_3098[29:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR4_ROW_ADDR_MAP_B12_PROC_867
if ((!Tpl_3092))
begin
Tpl_2016 <= 0;
end
else
if (Tpl_3205)
begin
Tpl_2016 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR4_ROW_ADDR_MAP_B13_PROC_870
if ((!Tpl_3092))
begin
Tpl_2017 <= 0;
end
else
if (Tpl_3205)
begin
Tpl_2017 <= Tpl_3098[9:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR4_ROW_ADDR_MAP_B14_PROC_873
if ((!Tpl_3092))
begin
Tpl_2018 <= 0;
end
else
if (Tpl_3205)
begin
Tpl_2018 <= Tpl_3098[14:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR4_ROW_ADDR_MAP_B15_PROC_876
if ((!Tpl_3092))
begin
Tpl_2019 <= 0;
end
else
if (Tpl_3205)
begin
Tpl_2019 <= Tpl_3098[19:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR4_ROW_ADDR_MAP_B16_PROC_879
if ((!Tpl_3092))
begin
Tpl_2020 <= 0;
end
else
if (Tpl_3205)
begin
Tpl_2020 <= Tpl_3098[24:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR5_BANK_ADDR_MAP_B0_PROC_882
if ((!Tpl_3092))
begin
Tpl_2021 <= 0;
end
else
if (Tpl_3207)
begin
Tpl_2021 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR5_BANK_ADDR_MAP_B1_PROC_885
if ((!Tpl_3092))
begin
Tpl_2022 <= 0;
end
else
if (Tpl_3207)
begin
Tpl_2022 <= Tpl_3098[9:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR5_BANK_ADDR_MAP_B2_PROC_888
if ((!Tpl_3092))
begin
Tpl_2023 <= 0;
end
else
if (Tpl_3207)
begin
Tpl_2023 <= Tpl_3098[14:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR5_BANK_ADDR_MAP_B3_PROC_891
if ((!Tpl_3092))
begin
Tpl_2024 <= 0;
end
else
if (Tpl_3207)
begin
Tpl_2024 <= Tpl_3098[19:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR5_RANK_ADDR_MAP_B0_PROC_894
if ((!Tpl_3092))
begin
Tpl_2025 <= 0;
end
else
if (Tpl_3207)
begin
Tpl_2025 <= Tpl_3098[24:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADDR5_CHAN_ADDR_MAP_B0_PROC_897
if ((!Tpl_3092))
begin
Tpl_2026 <= 0;
end
else
if (Tpl_3207)
begin
Tpl_2026 <= Tpl_3098[29:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PHY_DTI_DRAM_CLK_DIS_PROC_900
if ((!Tpl_3092))
begin
Tpl_2027 <= 0;
end
else
if (Tpl_3209)
begin
Tpl_2027 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PHY_DTI_DATA_BYTE_DIS_PROC_903
if ((!Tpl_3092))
begin
Tpl_2028 <= 0;
end
else
if (Tpl_3209)
begin
Tpl_2028 <= Tpl_3098[4:1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_CHANEN_PROC_906
if ((!Tpl_3092))
begin
Tpl_2029 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2029 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_DFIEN_PROC_909
if ((!Tpl_3092))
begin
Tpl_2030 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2030 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_PROC_PROC_912
if ((!Tpl_3092))
begin
Tpl_2031 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2031 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_PHYSETEN_PROC_915
if ((!Tpl_3092))
begin
Tpl_2032 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2032 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_PHYFSEN_PROC_918
if ((!Tpl_3092))
begin
Tpl_2033 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2033 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_PHYINIT_PROC_921
if ((!Tpl_3092))
begin
Tpl_2034 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2034 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_DLLRSTEN_PROC_924
if ((!Tpl_3092))
begin
Tpl_2035 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2035 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_DRAMINITEN_PROC_927
if ((!Tpl_3092))
begin
Tpl_2036 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2036 <= Tpl_3098[8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_VREFDQRDEN_PROC_930
if ((!Tpl_3092))
begin
Tpl_2037 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2037 <= Tpl_3098[9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_VREFCAEN_PROC_933
if ((!Tpl_3092))
begin
Tpl_2038 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2038 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_GTEN_PROC_936
if ((!Tpl_3092))
begin
Tpl_2039 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2039 <= Tpl_3098[11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_WRLVLEN_PROC_939
if ((!Tpl_3092))
begin
Tpl_2040 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2040 <= Tpl_3098[12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_RDLVLEN_PROC_942
if ((!Tpl_3092))
begin
Tpl_2041 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2041 <= Tpl_3098[13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_VREFDQWREN_PROC_945
if ((!Tpl_3092))
begin
Tpl_2042 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2042 <= Tpl_3098[14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_DLYEVALEN_PROC_948
if ((!Tpl_3092))
begin
Tpl_2043 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2043 <= Tpl_3098[15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_SANCHKEN_PROC_951
if ((!Tpl_3092))
begin
Tpl_2044 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2044 <= Tpl_3098[16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_FS_PROC_954
if ((!Tpl_3092))
begin
Tpl_2045 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2045 <= Tpl_3098[17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_CLKLOCKEN_PROC_957
if ((!Tpl_3092))
begin
Tpl_2046 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2046 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_CMDDLYEN_PROC_960
if ((!Tpl_3092))
begin
Tpl_2047 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2047 <= Tpl_3098[19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_ODT_PROC_963
if ((!Tpl_3092))
begin
Tpl_2048 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2048 <= Tpl_3098[20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_DQSDQEN_PROC_966
if ((!Tpl_3092))
begin
Tpl_2049 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2049 <= Tpl_3098[21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POM_RANKEN_PROC_969
if ((!Tpl_3092))
begin
Tpl_2050 <= 0;
end
else
if (Tpl_3211)
begin
Tpl_2050 <= Tpl_3098[23:22];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH0_LIMIT_PROC_972
if ((!Tpl_3092))
begin
Tpl_2051 <= 0;
end
else
if (Tpl_3213)
begin
Tpl_2051 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH0_EN_PROC_975
if ((!Tpl_3092))
begin
Tpl_2052 <= 0;
end
else
if (Tpl_3213)
begin
Tpl_2052 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH0_UPD_PROC_978
if ((!Tpl_3092))
begin
Tpl_2053 <= 0;
end
else
if (Tpl_3213)
begin
Tpl_2053 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH0_BYP_PROC_981
if ((!Tpl_3092))
begin
Tpl_2054 <= 0;
end
else
if (Tpl_3213)
begin
Tpl_2054 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH0_BYPC_PROC_984
if ((!Tpl_3092))
begin
Tpl_2055 <= 0;
end
else
if (Tpl_3213)
begin
Tpl_2055 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH0_CLKDLY_PROC_987
if ((!Tpl_3092))
begin
Tpl_2056 <= 0;
end
else
if (Tpl_3213)
begin
Tpl_2056 <= Tpl_3098[21:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH1_LIMIT_PROC_990
if ((!Tpl_3092))
begin
Tpl_2057 <= 0;
end
else
if (Tpl_3215)
begin
Tpl_2057 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH1_EN_PROC_993
if ((!Tpl_3092))
begin
Tpl_2058 <= 0;
end
else
if (Tpl_3215)
begin
Tpl_2058 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH1_UPD_PROC_996
if ((!Tpl_3092))
begin
Tpl_2059 <= 0;
end
else
if (Tpl_3215)
begin
Tpl_2059 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH1_BYP_PROC_999
if ((!Tpl_3092))
begin
Tpl_2060 <= 0;
end
else
if (Tpl_3215)
begin
Tpl_2060 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH1_BYPC_PROC_1002
if ((!Tpl_3092))
begin
Tpl_2061 <= 0;
end
else
if (Tpl_3215)
begin
Tpl_2061 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLCA_CH1_CLKDLY_PROC_1005
if ((!Tpl_3092))
begin
Tpl_2062 <= 0;
end
else
if (Tpl_3215)
begin
Tpl_2062 <= Tpl_3098[21:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL0_LIMIT_PROC_1008
if ((!Tpl_3092))
begin
Tpl_2063 <= 0;
end
else
if (Tpl_3217)
begin
Tpl_2063 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL0_EN_PROC_1011
if ((!Tpl_3092))
begin
Tpl_2064 <= 0;
end
else
if (Tpl_3217)
begin
Tpl_2064 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL0_UPD_PROC_1014
if ((!Tpl_3092))
begin
Tpl_2065 <= 0;
end
else
if (Tpl_3217)
begin
Tpl_2065 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL0_BYP_PROC_1017
if ((!Tpl_3092))
begin
Tpl_2066 <= 0;
end
else
if (Tpl_3217)
begin
Tpl_2066 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL0_BYPC_PROC_1020
if ((!Tpl_3092))
begin
Tpl_2067 <= 0;
end
else
if (Tpl_3217)
begin
Tpl_2067 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL1_LIMIT_PROC_1023
if ((!Tpl_3092))
begin
Tpl_2068 <= 0;
end
else
if (Tpl_3219)
begin
Tpl_2068 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL1_EN_PROC_1026
if ((!Tpl_3092))
begin
Tpl_2069 <= 0;
end
else
if (Tpl_3219)
begin
Tpl_2069 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL1_UPD_PROC_1029
if ((!Tpl_3092))
begin
Tpl_2070 <= 0;
end
else
if (Tpl_3219)
begin
Tpl_2070 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL1_BYP_PROC_1032
if ((!Tpl_3092))
begin
Tpl_2071 <= 0;
end
else
if (Tpl_3219)
begin
Tpl_2071 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL1_BYPC_PROC_1035
if ((!Tpl_3092))
begin
Tpl_2072 <= 0;
end
else
if (Tpl_3219)
begin
Tpl_2072 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL2_LIMIT_PROC_1038
if ((!Tpl_3092))
begin
Tpl_2073 <= 0;
end
else
if (Tpl_3221)
begin
Tpl_2073 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL2_EN_PROC_1041
if ((!Tpl_3092))
begin
Tpl_2074 <= 0;
end
else
if (Tpl_3221)
begin
Tpl_2074 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL2_UPD_PROC_1044
if ((!Tpl_3092))
begin
Tpl_2075 <= 0;
end
else
if (Tpl_3221)
begin
Tpl_2075 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL2_BYP_PROC_1047
if ((!Tpl_3092))
begin
Tpl_2076 <= 0;
end
else
if (Tpl_3221)
begin
Tpl_2076 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL2_BYPC_PROC_1050
if ((!Tpl_3092))
begin
Tpl_2077 <= 0;
end
else
if (Tpl_3221)
begin
Tpl_2077 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL3_LIMIT_PROC_1053
if ((!Tpl_3092))
begin
Tpl_2078 <= 0;
end
else
if (Tpl_3223)
begin
Tpl_2078 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL3_EN_PROC_1056
if ((!Tpl_3092))
begin
Tpl_2079 <= 0;
end
else
if (Tpl_3223)
begin
Tpl_2079 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL3_UPD_PROC_1059
if ((!Tpl_3092))
begin
Tpl_2080 <= 0;
end
else
if (Tpl_3223)
begin
Tpl_2080 <= Tpl_3098[6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL3_BYP_PROC_1062
if ((!Tpl_3092))
begin
Tpl_2081 <= 0;
end
else
if (Tpl_3223)
begin
Tpl_2081 <= Tpl_3098[7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLCTLDQ_SL3_BYPC_PROC_1065
if ((!Tpl_3092))
begin
Tpl_2082 <= 0;
end
else
if (Tpl_3223)
begin
Tpl_2082 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC0_GT_UPDT_PROC_1068
if ((!Tpl_3092))
begin
Tpl_2083 <= 0;
end
else
if (Tpl_3225)
begin
Tpl_2083 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC0_GT_DIS_PROC_1071
if ((!Tpl_3092))
begin
Tpl_2084 <= 0;
end
else
if (Tpl_3225)
begin
Tpl_2084 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC0_FS0_TWREN_PROC_1074
if ((!Tpl_3092))
begin
Tpl_2085 <= 0;
end
else
if (Tpl_3225)
begin
Tpl_2085 <= Tpl_3098[7:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC0_FS0_TRDEN_PROC_1077
if ((!Tpl_3092))
begin
Tpl_2086 <= 0;
end
else
if (Tpl_3225)
begin
Tpl_2086 <= Tpl_3098[13:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC0_FS0_TRDENDBI_PROC_1080
if ((!Tpl_3092))
begin
Tpl_2087 <= 0;
end
else
if (Tpl_3225)
begin
Tpl_2087 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC1_FS1_TWREN_PROC_1083
if ((!Tpl_3092))
begin
Tpl_2088 <= 0;
end
else
if (Tpl_3227)
begin
Tpl_2088 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC1_FS1_TRDEN_PROC_1086
if ((!Tpl_3092))
begin
Tpl_2089 <= 0;
end
else
if (Tpl_3227)
begin
Tpl_2089 <= Tpl_3098[11:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: RTGC1_FS1_TRDENDBI_PROC_1089
if ((!Tpl_3092))
begin
Tpl_2090 <= 0;
end
else
if (Tpl_3227)
begin
Tpl_2090 <= Tpl_3098[18:12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTAR_BA_PROC_1092
if ((!Tpl_3092))
begin
Tpl_2091 <= 0;
end
else
if (Tpl_3229)
begin
Tpl_2091 <= Tpl_3098[3:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTAR_ROW_PROC_1095
if ((!Tpl_3092))
begin
Tpl_2092 <= 0;
end
else
if (Tpl_3229)
begin
Tpl_2092 <= Tpl_3098[20:4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTAR_COL_PROC_1098
if ((!Tpl_3092))
begin
Tpl_2093 <= 0;
end
else
if (Tpl_3229)
begin
Tpl_2093 <= Tpl_3098[31:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: VTGC_IVREFR_PROC_1101
if ((!Tpl_3092))
begin
Tpl_2094 <= 0;
end
else
if (Tpl_3231)
begin
Tpl_2094 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: VTGC_IVREFTS_PROC_1104
if ((!Tpl_3092))
begin
Tpl_2095 <= 0;
end
else
if (Tpl_3231)
begin
Tpl_2095 <= Tpl_3098[8:1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: VTGC_VREFDQSW_PROC_1107
if ((!Tpl_3092))
begin
Tpl_2096 <= 0;
end
else
if (Tpl_3231)
begin
Tpl_2096 <= Tpl_3098[14:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: VTGC_VREFCASW_PROC_1110
if ((!Tpl_3092))
begin
Tpl_2097 <= 0;
end
else
if (Tpl_3231)
begin
Tpl_2097 <= Tpl_3098[20:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: VTGC_IVREFEN_PROC_1113
if ((!Tpl_3092))
begin
Tpl_2098 <= 1'b1;
end
else
if (Tpl_3231)
begin
Tpl_2098 <= Tpl_3098[21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBCR_BIST_EN_PROC_1116
if ((!Tpl_3092))
begin
Tpl_2099 <= 0;
end
else
if (Tpl_3233)
begin
Tpl_2099 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBCR_BIST_START_PROC_1119
if ((!Tpl_3092))
begin
Tpl_2100 <= 0;
end
else
if (Tpl_3233)
begin
Tpl_2100 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBCR_LP_EN_PROC_1122
if ((!Tpl_3092))
begin
Tpl_2101 <= 0;
end
else
if (Tpl_3233)
begin
Tpl_2101 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBCR_VREFENCA_C0_PROC_1125
if ((!Tpl_3092))
begin
Tpl_2102 <= 0;
end
else
if (Tpl_3233)
begin
Tpl_2102 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBCR_VREFSETCA_C0_PROC_1128
if ((!Tpl_3092))
begin
Tpl_2103 <= 0;
end
else
if (Tpl_3233)
begin
Tpl_2103 <= Tpl_3098[9:4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBCR_VREFENCA_C1_PROC_1131
if ((!Tpl_3092))
begin
Tpl_2104 <= 0;
end
else
if (Tpl_3233)
begin
Tpl_2104 <= Tpl_3098[10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBCR_VREFSETCA_C1_PROC_1134
if ((!Tpl_3092))
begin
Tpl_2105 <= 0;
end
else
if (Tpl_3233)
begin
Tpl_2105 <= Tpl_3098[16:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CIOR0_CH0_DRVSEL_PROC_1137
if ((!Tpl_3092))
begin
Tpl_2106 <= 0;
end
else
if (Tpl_3235)
begin
Tpl_2106 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CIOR0_CH0_CMOS_EN_PROC_1140
if ((!Tpl_3092))
begin
Tpl_2107 <= 0;
end
else
if (Tpl_3235)
begin
Tpl_2107 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CIOR0_CH1_DRVSEL_PROC_1143
if ((!Tpl_3092))
begin
Tpl_2108 <= 0;
end
else
if (Tpl_3237)
begin
Tpl_2108 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CIOR0_CH1_CMOS_EN_PROC_1146
if ((!Tpl_3092))
begin
Tpl_2109 <= 0;
end
else
if (Tpl_3237)
begin
Tpl_2109 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CIOR1_ODIS_CLK_PROC_1149
if ((!Tpl_3092))
begin
Tpl_2110 <= 0;
end
else
if (Tpl_3239)
begin
Tpl_2110 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CIOR1_ODIS_CTL_PROC_1152
if ((!Tpl_3092))
begin
Tpl_2111 <= 0;
end
else
if (Tpl_3239)
begin
Tpl_2111 <= Tpl_3098[31:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_DRVSEL_PROC_1155
if ((!Tpl_3092))
begin
Tpl_2112 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2112 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_CMOS_EN_PROC_1158
if ((!Tpl_3092))
begin
Tpl_2113 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2113 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_FENA_RCV_PROC_1161
if ((!Tpl_3092))
begin
Tpl_2114 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2114 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_RTT_EN_PROC_1164
if ((!Tpl_3092))
begin
Tpl_2115 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2115 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_RTT_SEL_PROC_1167
if ((!Tpl_3092))
begin
Tpl_2116 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2116 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_ODIS_DQ_PROC_1170
if ((!Tpl_3092))
begin
Tpl_2117 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2117 <= Tpl_3098[16:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_ODIS_DM_PROC_1173
if ((!Tpl_3092))
begin
Tpl_2118 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2118 <= Tpl_3098[17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL0_ODIS_DQS_PROC_1176
if ((!Tpl_3092))
begin
Tpl_2119 <= 0;
end
else
if (Tpl_3241)
begin
Tpl_2119 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_DRVSEL_PROC_1179
if ((!Tpl_3092))
begin
Tpl_2120 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2120 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_CMOS_EN_PROC_1182
if ((!Tpl_3092))
begin
Tpl_2121 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2121 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_FENA_RCV_PROC_1185
if ((!Tpl_3092))
begin
Tpl_2122 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2122 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_RTT_EN_PROC_1188
if ((!Tpl_3092))
begin
Tpl_2123 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2123 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_RTT_SEL_PROC_1191
if ((!Tpl_3092))
begin
Tpl_2124 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2124 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_ODIS_DQ_PROC_1194
if ((!Tpl_3092))
begin
Tpl_2125 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2125 <= Tpl_3098[16:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_ODIS_DM_PROC_1197
if ((!Tpl_3092))
begin
Tpl_2126 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2126 <= Tpl_3098[17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL1_ODIS_DQS_PROC_1200
if ((!Tpl_3092))
begin
Tpl_2127 <= 0;
end
else
if (Tpl_3243)
begin
Tpl_2127 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_DRVSEL_PROC_1203
if ((!Tpl_3092))
begin
Tpl_2128 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2128 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_CMOS_EN_PROC_1206
if ((!Tpl_3092))
begin
Tpl_2129 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2129 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_FENA_RCV_PROC_1209
if ((!Tpl_3092))
begin
Tpl_2130 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2130 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_RTT_EN_PROC_1212
if ((!Tpl_3092))
begin
Tpl_2131 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2131 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_RTT_SEL_PROC_1215
if ((!Tpl_3092))
begin
Tpl_2132 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2132 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_ODIS_DQ_PROC_1218
if ((!Tpl_3092))
begin
Tpl_2133 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2133 <= Tpl_3098[16:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_ODIS_DM_PROC_1221
if ((!Tpl_3092))
begin
Tpl_2134 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2134 <= Tpl_3098[17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL2_ODIS_DQS_PROC_1224
if ((!Tpl_3092))
begin
Tpl_2135 <= 0;
end
else
if (Tpl_3245)
begin
Tpl_2135 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_DRVSEL_PROC_1227
if ((!Tpl_3092))
begin
Tpl_2136 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2136 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_CMOS_EN_PROC_1230
if ((!Tpl_3092))
begin
Tpl_2137 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2137 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_FENA_RCV_PROC_1233
if ((!Tpl_3092))
begin
Tpl_2138 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2138 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_RTT_EN_PROC_1236
if ((!Tpl_3092))
begin
Tpl_2139 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2139 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_RTT_SEL_PROC_1239
if ((!Tpl_3092))
begin
Tpl_2140 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2140 <= Tpl_3098[8:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_ODIS_DQ_PROC_1242
if ((!Tpl_3092))
begin
Tpl_2141 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2141 <= Tpl_3098[16:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_ODIS_DM_PROC_1245
if ((!Tpl_3092))
begin
Tpl_2142 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2142 <= Tpl_3098[17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DIOR_SL3_ODIS_DQS_PROC_1248
if ((!Tpl_3092))
begin
Tpl_2143 <= 0;
end
else
if (Tpl_3247)
begin
Tpl_2143 <= Tpl_3098[18];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_SRST_PROC_1251
if ((!Tpl_3092))
begin
Tpl_2144 <= 1'h1;
end
else
if (Tpl_3249)
begin
Tpl_2144 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_TPADEN_PROC_1254
if ((!Tpl_3092))
begin
Tpl_2145 <= 1'h1;
end
else
if (Tpl_3249)
begin
Tpl_2145 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_MVG_PROC_1257
if ((!Tpl_3092))
begin
Tpl_2146 <= 1'h1;
end
else
if (Tpl_3249)
begin
Tpl_2146 <= Tpl_3098[2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_EN_PROC_1260
if ((!Tpl_3092))
begin
Tpl_2147 <= 1'h1;
end
else
if (Tpl_3249)
begin
Tpl_2147 <= Tpl_3098[3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_UPD_PROC_1263
if ((!Tpl_3092))
begin
Tpl_2148 <= 1'h1;
end
else
if (Tpl_3249)
begin
Tpl_2148 <= Tpl_3098[4];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_BYPEN_PROC_1266
if ((!Tpl_3092))
begin
Tpl_2149 <= 0;
end
else
if (Tpl_3249)
begin
Tpl_2149 <= Tpl_3098[5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_BYP_N_PROC_1269
if ((!Tpl_3092))
begin
Tpl_2150 <= 0;
end
else
if (Tpl_3249)
begin
Tpl_2150 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_BYP_P_PROC_1272
if ((!Tpl_3092))
begin
Tpl_2151 <= 0;
end
else
if (Tpl_3249)
begin
Tpl_2151 <= Tpl_3098[13:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCCR_INITCNT_PROC_1275
if ((!Tpl_3092))
begin
Tpl_2152 <= 11'h400;
end
else
if (Tpl_3249)
begin
Tpl_2152 <= Tpl_3098[24:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DQSDQCR_DLYOFFS_PROC_1278
if ((!Tpl_3092))
begin
Tpl_2153 <= 0;
end
else
if (Tpl_3251)
begin
Tpl_2153 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DQSDQCR_DQSEL_PROC_1281
if ((!Tpl_3092))
begin
Tpl_2154 <= 0;
end
else
if (Tpl_3251)
begin
Tpl_2154 <= Tpl_3098[11:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DQSDQCR_MUPD_PROC_1284
if ((!Tpl_3092))
begin
Tpl_2155 <= 0;
end
else
if (Tpl_3251)
begin
Tpl_2155 <= Tpl_3098[12];
end
else
begin
Tpl_2155 <= (Tpl_2155 & (~Tpl_3103));
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DQSDQCR_MPCRPT_PROC_1288
if ((!Tpl_3092))
begin
Tpl_2156 <= 0;
end
else
if (Tpl_3251)
begin
Tpl_2156 <= Tpl_3098[15:13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DQSDQCR_DLYMAX_PROC_1291
if ((!Tpl_3092))
begin
Tpl_2157 <= 0;
end
else
if (Tpl_3251)
begin
Tpl_2157 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DQSDQCR_DIR_PROC_1294
if ((!Tpl_3092))
begin
Tpl_2158 <= 0;
end
else
if (Tpl_3251)
begin
Tpl_2158 <= Tpl_3098[24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DQSDQCR_RANK_PROC_1297
if ((!Tpl_3092))
begin
Tpl_2159 <= 0;
end
else
if (Tpl_3251)
begin
Tpl_2159 <= Tpl_3098[26:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR0_R0_VREFCAR_PROC_1300
if ((!Tpl_3092))
begin
Tpl_2160 <= 0;
end
else
if (Tpl_3253)
begin
Tpl_2160 <= Tpl_3098[0];
end
else
if (Tpl_3102)
begin
Tpl_2160 <= Tpl_2161;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR0_R0_VREFCAS_PROC_1304
if ((!Tpl_3092))
begin
Tpl_2162 <= 0;
end
else
if (Tpl_3253)
begin
Tpl_2162 <= Tpl_3098[6:1];
end
else
if (Tpl_3102)
begin
Tpl_2162 <= Tpl_2163;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR0_R0_VREFDQWRR_PROC_1308
if ((!Tpl_3092))
begin
Tpl_2164 <= 0;
end
else
if (Tpl_3253)
begin
Tpl_2164 <= Tpl_3098[7];
end
else
if (Tpl_3102)
begin
Tpl_2164 <= Tpl_2165;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR0_R0_VREFDQWRS_PROC_1312
if ((!Tpl_3092))
begin
Tpl_2166 <= 0;
end
else
if (Tpl_3253)
begin
Tpl_2166 <= Tpl_3098[13:8];
end
else
if (Tpl_3102)
begin
Tpl_2166 <= Tpl_2167;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR1_R0_CSC0_PROC_1316
if ((!Tpl_3092))
begin
Tpl_2168 <= 0;
end
else
if (Tpl_3255)
begin
Tpl_2168 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2168 <= Tpl_2169;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR1_R0_CSC1_PROC_1320
if ((!Tpl_3092))
begin
Tpl_2170 <= 0;
end
else
if (Tpl_3255)
begin
Tpl_2170 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2170 <= Tpl_2171;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR1_R0_CAC0B0_PROC_1324
if ((!Tpl_3092))
begin
Tpl_2172 <= 0;
end
else
if (Tpl_3255)
begin
Tpl_2172 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2172 <= Tpl_2173;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR1_R0_CAC0B1_PROC_1328
if ((!Tpl_3092))
begin
Tpl_2174 <= 0;
end
else
if (Tpl_3255)
begin
Tpl_2174 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2174 <= Tpl_2175;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR2_R0_CAC0B2_PROC_1332
if ((!Tpl_3092))
begin
Tpl_2176 <= 0;
end
else
if (Tpl_3257)
begin
Tpl_2176 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2176 <= Tpl_2177;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR2_R0_CAC0B3_PROC_1336
if ((!Tpl_3092))
begin
Tpl_2178 <= 0;
end
else
if (Tpl_3257)
begin
Tpl_2178 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2178 <= Tpl_2179;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR2_R0_CAC0B4_PROC_1340
if ((!Tpl_3092))
begin
Tpl_2180 <= 0;
end
else
if (Tpl_3257)
begin
Tpl_2180 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2180 <= Tpl_2181;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR2_R0_CAC0B5_PROC_1344
if ((!Tpl_3092))
begin
Tpl_2182 <= 0;
end
else
if (Tpl_3257)
begin
Tpl_2182 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2182 <= Tpl_2183;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR3_R0_CAC0B6_PROC_1348
if ((!Tpl_3092))
begin
Tpl_2184 <= 0;
end
else
if (Tpl_3259)
begin
Tpl_2184 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2184 <= Tpl_2185;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR3_R0_CAC0B7_PROC_1352
if ((!Tpl_3092))
begin
Tpl_2186 <= 0;
end
else
if (Tpl_3259)
begin
Tpl_2186 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2186 <= Tpl_2187;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR3_R0_CAC0B8_PROC_1356
if ((!Tpl_3092))
begin
Tpl_2188 <= 0;
end
else
if (Tpl_3259)
begin
Tpl_2188 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2188 <= Tpl_2189;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR3_R0_CAC0B9_PROC_1360
if ((!Tpl_3092))
begin
Tpl_2190 <= 0;
end
else
if (Tpl_3259)
begin
Tpl_2190 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2190 <= Tpl_2191;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR4_R0_CAC0B10_PROC_1364
if ((!Tpl_3092))
begin
Tpl_2192 <= 0;
end
else
if (Tpl_3261)
begin
Tpl_2192 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2192 <= Tpl_2193;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR4_R0_CAC0B11_PROC_1368
if ((!Tpl_3092))
begin
Tpl_2194 <= 0;
end
else
if (Tpl_3261)
begin
Tpl_2194 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2194 <= Tpl_2195;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR4_R0_CAC0B12_PROC_1372
if ((!Tpl_3092))
begin
Tpl_2196 <= 0;
end
else
if (Tpl_3261)
begin
Tpl_2196 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2196 <= Tpl_2197;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR4_R0_CAC0B13_PROC_1376
if ((!Tpl_3092))
begin
Tpl_2198 <= 0;
end
else
if (Tpl_3261)
begin
Tpl_2198 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2198 <= Tpl_2199;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR5_R0_CAC0B14_PROC_1380
if ((!Tpl_3092))
begin
Tpl_2200 <= 0;
end
else
if (Tpl_3263)
begin
Tpl_2200 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2200 <= Tpl_2201;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR5_R0_CAC0B15_PROC_1384
if ((!Tpl_3092))
begin
Tpl_2202 <= 0;
end
else
if (Tpl_3263)
begin
Tpl_2202 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2202 <= Tpl_2203;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR5_R0_CAC0B16_PROC_1388
if ((!Tpl_3092))
begin
Tpl_2204 <= 0;
end
else
if (Tpl_3263)
begin
Tpl_2204 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2204 <= Tpl_2205;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR5_R0_CAC0B17_PROC_1392
if ((!Tpl_3092))
begin
Tpl_2206 <= 0;
end
else
if (Tpl_3263)
begin
Tpl_2206 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2206 <= Tpl_2207;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR6_R0_CAC0B18_PROC_1396
if ((!Tpl_3092))
begin
Tpl_2208 <= 0;
end
else
if (Tpl_3265)
begin
Tpl_2208 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2208 <= Tpl_2209;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR6_R0_CAC1B0_PROC_1400
if ((!Tpl_3092))
begin
Tpl_2210 <= 0;
end
else
if (Tpl_3265)
begin
Tpl_2210 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2210 <= Tpl_2211;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR6_R0_CAC1B1_PROC_1404
if ((!Tpl_3092))
begin
Tpl_2212 <= 0;
end
else
if (Tpl_3265)
begin
Tpl_2212 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2212 <= Tpl_2213;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR6_R0_CAC1B2_PROC_1408
if ((!Tpl_3092))
begin
Tpl_2214 <= 0;
end
else
if (Tpl_3265)
begin
Tpl_2214 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2214 <= Tpl_2215;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR7_R0_CAC1B3_PROC_1412
if ((!Tpl_3092))
begin
Tpl_2216 <= 0;
end
else
if (Tpl_3267)
begin
Tpl_2216 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2216 <= Tpl_2217;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR7_R0_CAC1B4_PROC_1416
if ((!Tpl_3092))
begin
Tpl_2218 <= 0;
end
else
if (Tpl_3267)
begin
Tpl_2218 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2218 <= Tpl_2219;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR7_R0_CAC1B5_PROC_1420
if ((!Tpl_3092))
begin
Tpl_2220 <= 0;
end
else
if (Tpl_3267)
begin
Tpl_2220 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2220 <= Tpl_2221;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR7_R0_CAC1B6_PROC_1424
if ((!Tpl_3092))
begin
Tpl_2222 <= 0;
end
else
if (Tpl_3267)
begin
Tpl_2222 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2222 <= Tpl_2223;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR8_R0_CAC1B7_PROC_1428
if ((!Tpl_3092))
begin
Tpl_2224 <= 0;
end
else
if (Tpl_3269)
begin
Tpl_2224 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2224 <= Tpl_2225;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR8_R0_CAC1B8_PROC_1432
if ((!Tpl_3092))
begin
Tpl_2226 <= 0;
end
else
if (Tpl_3269)
begin
Tpl_2226 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2226 <= Tpl_2227;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR8_R0_CAC1B9_PROC_1436
if ((!Tpl_3092))
begin
Tpl_2228 <= 0;
end
else
if (Tpl_3269)
begin
Tpl_2228 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2228 <= Tpl_2229;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR8_R0_CAC1B10_PROC_1440
if ((!Tpl_3092))
begin
Tpl_2230 <= 0;
end
else
if (Tpl_3269)
begin
Tpl_2230 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2230 <= Tpl_2231;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR9_R0_CAC1B11_PROC_1444
if ((!Tpl_3092))
begin
Tpl_2232 <= 0;
end
else
if (Tpl_3271)
begin
Tpl_2232 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2232 <= Tpl_2233;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR9_R0_CAC1B12_PROC_1448
if ((!Tpl_3092))
begin
Tpl_2234 <= 0;
end
else
if (Tpl_3271)
begin
Tpl_2234 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2234 <= Tpl_2235;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR9_R0_CAC1B13_PROC_1452
if ((!Tpl_3092))
begin
Tpl_2236 <= 0;
end
else
if (Tpl_3271)
begin
Tpl_2236 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2236 <= Tpl_2237;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR9_R0_CAC1B14_PROC_1456
if ((!Tpl_3092))
begin
Tpl_2238 <= 0;
end
else
if (Tpl_3271)
begin
Tpl_2238 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2238 <= Tpl_2239;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR10_R0_CAC1B15_PROC_1460
if ((!Tpl_3092))
begin
Tpl_2240 <= 0;
end
else
if (Tpl_3273)
begin
Tpl_2240 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2240 <= Tpl_2241;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR10_R0_CAC1B16_PROC_1464
if ((!Tpl_3092))
begin
Tpl_2242 <= 0;
end
else
if (Tpl_3273)
begin
Tpl_2242 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2242 <= Tpl_2243;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR10_R0_CAC1B17_PROC_1468
if ((!Tpl_3092))
begin
Tpl_2244 <= 0;
end
else
if (Tpl_3273)
begin
Tpl_2244 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2244 <= Tpl_2245;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR10_R0_CAC1B18_PROC_1472
if ((!Tpl_3092))
begin
Tpl_2246 <= 0;
end
else
if (Tpl_3273)
begin
Tpl_2246 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2246 <= Tpl_2247;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR11_R0_BAC0B0_PROC_1476
if ((!Tpl_3092))
begin
Tpl_2248 <= 0;
end
else
if (Tpl_3275)
begin
Tpl_2248 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR11_R0_BAC0B1_PROC_1479
if ((!Tpl_3092))
begin
Tpl_2249 <= 0;
end
else
if (Tpl_3275)
begin
Tpl_2249 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR11_R0_BAC0B2_PROC_1482
if ((!Tpl_3092))
begin
Tpl_2250 <= 0;
end
else
if (Tpl_3275)
begin
Tpl_2250 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR11_R0_BAC0B3_PROC_1485
if ((!Tpl_3092))
begin
Tpl_2251 <= 0;
end
else
if (Tpl_3275)
begin
Tpl_2251 <= Tpl_3098[27:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR12_R0_BAC1B0_PROC_1488
if ((!Tpl_3092))
begin
Tpl_2252 <= 0;
end
else
if (Tpl_3277)
begin
Tpl_2252 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR12_R0_BAC1B1_PROC_1491
if ((!Tpl_3092))
begin
Tpl_2253 <= 0;
end
else
if (Tpl_3277)
begin
Tpl_2253 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR12_R0_BAC1B2_PROC_1494
if ((!Tpl_3092))
begin
Tpl_2254 <= 0;
end
else
if (Tpl_3277)
begin
Tpl_2254 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR12_R0_BAC1B3_PROC_1497
if ((!Tpl_3092))
begin
Tpl_2255 <= 0;
end
else
if (Tpl_3277)
begin
Tpl_2255 <= Tpl_3098[27:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR13_R0_ACTNC0_PROC_1500
if ((!Tpl_3092))
begin
Tpl_2256 <= 0;
end
else
if (Tpl_3279)
begin
Tpl_2256 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR13_R0_ACTNC1_PROC_1503
if ((!Tpl_3092))
begin
Tpl_2257 <= 0;
end
else
if (Tpl_3279)
begin
Tpl_2257 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR13_R0_CKEC0_PROC_1506
if ((!Tpl_3092))
begin
Tpl_2258 <= 0;
end
else
if (Tpl_3279)
begin
Tpl_2258 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR13_R0_CKEC1_PROC_1509
if ((!Tpl_3092))
begin
Tpl_2259 <= 0;
end
else
if (Tpl_3279)
begin
Tpl_2259 <= Tpl_3098[27:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR14_R0_GTS0_PROC_1512
if ((!Tpl_3092))
begin
Tpl_2260 <= 0;
end
else
if (Tpl_3281)
begin
Tpl_2260 <= Tpl_3098[5:0];
end
else
if (Tpl_3102)
begin
Tpl_2260 <= Tpl_2261;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR14_R0_GTS1_PROC_1516
if ((!Tpl_3092))
begin
Tpl_2262 <= 0;
end
else
if (Tpl_3281)
begin
Tpl_2262 <= Tpl_3098[11:6];
end
else
if (Tpl_3102)
begin
Tpl_2262 <= Tpl_2263;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR14_R0_GTS2_PROC_1520
if ((!Tpl_3092))
begin
Tpl_2264 <= 0;
end
else
if (Tpl_3281)
begin
Tpl_2264 <= Tpl_3098[17:12];
end
else
if (Tpl_3102)
begin
Tpl_2264 <= Tpl_2265;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR14_R0_GTS3_PROC_1524
if ((!Tpl_3092))
begin
Tpl_2266 <= 0;
end
else
if (Tpl_3281)
begin
Tpl_2266 <= Tpl_3098[23:18];
end
else
if (Tpl_3102)
begin
Tpl_2266 <= Tpl_2267;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR15_R0_WRLVLS0_PROC_1528
if ((!Tpl_3092))
begin
Tpl_2268 <= 0;
end
else
if (Tpl_3283)
begin
Tpl_2268 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2268 <= Tpl_2269;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR15_R0_WRLVLS1_PROC_1532
if ((!Tpl_3092))
begin
Tpl_2270 <= 0;
end
else
if (Tpl_3283)
begin
Tpl_2270 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2270 <= Tpl_2271;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR15_R0_WRLVLS2_PROC_1536
if ((!Tpl_3092))
begin
Tpl_2272 <= 0;
end
else
if (Tpl_3283)
begin
Tpl_2272 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2272 <= Tpl_2273;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR15_R0_WRLVLS3_PROC_1540
if ((!Tpl_3092))
begin
Tpl_2274 <= 0;
end
else
if (Tpl_3283)
begin
Tpl_2274 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2274 <= Tpl_2275;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR16_R0_DQSDQS0B0_PROC_1544
if ((!Tpl_3092))
begin
Tpl_2276 <= 0;
end
else
if (Tpl_3285)
begin
Tpl_2276 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2276 <= Tpl_2277;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR16_R0_DQSDQS0B1_PROC_1548
if ((!Tpl_3092))
begin
Tpl_2278 <= 0;
end
else
if (Tpl_3285)
begin
Tpl_2278 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2278 <= Tpl_2279;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR16_R0_DQSDQS0B2_PROC_1552
if ((!Tpl_3092))
begin
Tpl_2280 <= 0;
end
else
if (Tpl_3285)
begin
Tpl_2280 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2280 <= Tpl_2281;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR16_R0_DQSDQS0B3_PROC_1556
if ((!Tpl_3092))
begin
Tpl_2282 <= 0;
end
else
if (Tpl_3285)
begin
Tpl_2282 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2282 <= Tpl_2283;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR17_R0_DQSDQS0B4_PROC_1560
if ((!Tpl_3092))
begin
Tpl_2284 <= 0;
end
else
if (Tpl_3287)
begin
Tpl_2284 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2284 <= Tpl_2285;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR17_R0_DQSDQS0B5_PROC_1564
if ((!Tpl_3092))
begin
Tpl_2286 <= 0;
end
else
if (Tpl_3287)
begin
Tpl_2286 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2286 <= Tpl_2287;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR17_R0_DQSDQS0B6_PROC_1568
if ((!Tpl_3092))
begin
Tpl_2288 <= 0;
end
else
if (Tpl_3287)
begin
Tpl_2288 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2288 <= Tpl_2289;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR17_R0_DQSDQS0B7_PROC_1572
if ((!Tpl_3092))
begin
Tpl_2290 <= 0;
end
else
if (Tpl_3287)
begin
Tpl_2290 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2290 <= Tpl_2291;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR18_R0_DQSDQS1B0_PROC_1576
if ((!Tpl_3092))
begin
Tpl_2292 <= 0;
end
else
if (Tpl_3289)
begin
Tpl_2292 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2292 <= Tpl_2293;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR18_R0_DQSDQS1B1_PROC_1580
if ((!Tpl_3092))
begin
Tpl_2294 <= 0;
end
else
if (Tpl_3289)
begin
Tpl_2294 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2294 <= Tpl_2295;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR18_R0_DQSDQS1B2_PROC_1584
if ((!Tpl_3092))
begin
Tpl_2296 <= 0;
end
else
if (Tpl_3289)
begin
Tpl_2296 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2296 <= Tpl_2297;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR18_R0_DQSDQS1B3_PROC_1588
if ((!Tpl_3092))
begin
Tpl_2298 <= 0;
end
else
if (Tpl_3289)
begin
Tpl_2298 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2298 <= Tpl_2299;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR19_R0_DQSDQS1B4_PROC_1592
if ((!Tpl_3092))
begin
Tpl_2300 <= 0;
end
else
if (Tpl_3291)
begin
Tpl_2300 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2300 <= Tpl_2301;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR19_R0_DQSDQS1B5_PROC_1596
if ((!Tpl_3092))
begin
Tpl_2302 <= 0;
end
else
if (Tpl_3291)
begin
Tpl_2302 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2302 <= Tpl_2303;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR19_R0_DQSDQS1B6_PROC_1600
if ((!Tpl_3092))
begin
Tpl_2304 <= 0;
end
else
if (Tpl_3291)
begin
Tpl_2304 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2304 <= Tpl_2305;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR19_R0_DQSDQS1B7_PROC_1604
if ((!Tpl_3092))
begin
Tpl_2306 <= 0;
end
else
if (Tpl_3291)
begin
Tpl_2306 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2306 <= Tpl_2307;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR20_R0_DQSDQS2B0_PROC_1608
if ((!Tpl_3092))
begin
Tpl_2308 <= 0;
end
else
if (Tpl_3293)
begin
Tpl_2308 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2308 <= Tpl_2309;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR20_R0_DQSDQS2B1_PROC_1612
if ((!Tpl_3092))
begin
Tpl_2310 <= 0;
end
else
if (Tpl_3293)
begin
Tpl_2310 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2310 <= Tpl_2311;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR20_R0_DQSDQS2B2_PROC_1616
if ((!Tpl_3092))
begin
Tpl_2312 <= 0;
end
else
if (Tpl_3293)
begin
Tpl_2312 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2312 <= Tpl_2313;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR20_R0_DQSDQS2B3_PROC_1620
if ((!Tpl_3092))
begin
Tpl_2314 <= 0;
end
else
if (Tpl_3293)
begin
Tpl_2314 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2314 <= Tpl_2315;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR21_R0_DQSDQS2B4_PROC_1624
if ((!Tpl_3092))
begin
Tpl_2316 <= 0;
end
else
if (Tpl_3295)
begin
Tpl_2316 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2316 <= Tpl_2317;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR21_R0_DQSDQS2B5_PROC_1628
if ((!Tpl_3092))
begin
Tpl_2318 <= 0;
end
else
if (Tpl_3295)
begin
Tpl_2318 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2318 <= Tpl_2319;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR21_R0_DQSDQS2B6_PROC_1632
if ((!Tpl_3092))
begin
Tpl_2320 <= 0;
end
else
if (Tpl_3295)
begin
Tpl_2320 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2320 <= Tpl_2321;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR21_R0_DQSDQS2B7_PROC_1636
if ((!Tpl_3092))
begin
Tpl_2322 <= 0;
end
else
if (Tpl_3295)
begin
Tpl_2322 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2322 <= Tpl_2323;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR22_R0_DQSDQS3B0_PROC_1640
if ((!Tpl_3092))
begin
Tpl_2324 <= 0;
end
else
if (Tpl_3297)
begin
Tpl_2324 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2324 <= Tpl_2325;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR22_R0_DQSDQS3B1_PROC_1644
if ((!Tpl_3092))
begin
Tpl_2326 <= 0;
end
else
if (Tpl_3297)
begin
Tpl_2326 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2326 <= Tpl_2327;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR22_R0_DQSDQS3B2_PROC_1648
if ((!Tpl_3092))
begin
Tpl_2328 <= 0;
end
else
if (Tpl_3297)
begin
Tpl_2328 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2328 <= Tpl_2329;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR22_R0_DQSDQS3B3_PROC_1652
if ((!Tpl_3092))
begin
Tpl_2330 <= 0;
end
else
if (Tpl_3297)
begin
Tpl_2330 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2330 <= Tpl_2331;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR23_R0_DQSDQS3B4_PROC_1656
if ((!Tpl_3092))
begin
Tpl_2332 <= 0;
end
else
if (Tpl_3299)
begin
Tpl_2332 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2332 <= Tpl_2333;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR23_R0_DQSDQS3B5_PROC_1660
if ((!Tpl_3092))
begin
Tpl_2334 <= 0;
end
else
if (Tpl_3299)
begin
Tpl_2334 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2334 <= Tpl_2335;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR23_R0_DQSDQS3B6_PROC_1664
if ((!Tpl_3092))
begin
Tpl_2336 <= 0;
end
else
if (Tpl_3299)
begin
Tpl_2336 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2336 <= Tpl_2337;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR23_R0_DQSDQS3B7_PROC_1668
if ((!Tpl_3092))
begin
Tpl_2338 <= 0;
end
else
if (Tpl_3299)
begin
Tpl_2338 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2338 <= Tpl_2339;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR24_R0_DQSDMS0_PROC_1672
if ((!Tpl_3092))
begin
Tpl_2340 <= 0;
end
else
if (Tpl_3301)
begin
Tpl_2340 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2340 <= Tpl_2341;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR24_R0_DQSDMS1_PROC_1676
if ((!Tpl_3092))
begin
Tpl_2342 <= 0;
end
else
if (Tpl_3301)
begin
Tpl_2342 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2342 <= Tpl_2343;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR24_R0_DQSDMS2_PROC_1680
if ((!Tpl_3092))
begin
Tpl_2344 <= 0;
end
else
if (Tpl_3301)
begin
Tpl_2344 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2344 <= Tpl_2345;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR24_R0_DQSDMS3_PROC_1684
if ((!Tpl_3092))
begin
Tpl_2346 <= 0;
end
else
if (Tpl_3301)
begin
Tpl_2346 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2346 <= Tpl_2347;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR25_R0_RDLVLDQS0B0_PROC_1688
if ((!Tpl_3092))
begin
Tpl_2348 <= 0;
end
else
if (Tpl_3303)
begin
Tpl_2348 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2348 <= Tpl_2349;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR25_R0_RDLVLDQS0B1_PROC_1692
if ((!Tpl_3092))
begin
Tpl_2350 <= 0;
end
else
if (Tpl_3303)
begin
Tpl_2350 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2350 <= Tpl_2351;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR25_R0_RDLVLDQS0B2_PROC_1696
if ((!Tpl_3092))
begin
Tpl_2352 <= 0;
end
else
if (Tpl_3303)
begin
Tpl_2352 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2352 <= Tpl_2353;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR25_R0_RDLVLDQS0B3_PROC_1700
if ((!Tpl_3092))
begin
Tpl_2354 <= 0;
end
else
if (Tpl_3303)
begin
Tpl_2354 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2354 <= Tpl_2355;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR26_R0_RDLVLDQS0B4_PROC_1704
if ((!Tpl_3092))
begin
Tpl_2356 <= 0;
end
else
if (Tpl_3305)
begin
Tpl_2356 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2356 <= Tpl_2357;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR26_R0_RDLVLDQS0B5_PROC_1708
if ((!Tpl_3092))
begin
Tpl_2358 <= 0;
end
else
if (Tpl_3305)
begin
Tpl_2358 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2358 <= Tpl_2359;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR26_R0_RDLVLDQS0B6_PROC_1712
if ((!Tpl_3092))
begin
Tpl_2360 <= 0;
end
else
if (Tpl_3305)
begin
Tpl_2360 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2360 <= Tpl_2361;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR26_R0_RDLVLDQS0B7_PROC_1716
if ((!Tpl_3092))
begin
Tpl_2362 <= 0;
end
else
if (Tpl_3305)
begin
Tpl_2362 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2362 <= Tpl_2363;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR27_R0_RDLVLDQS1B0_PROC_1720
if ((!Tpl_3092))
begin
Tpl_2364 <= 0;
end
else
if (Tpl_3307)
begin
Tpl_2364 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2364 <= Tpl_2365;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR27_R0_RDLVLDQS1B1_PROC_1724
if ((!Tpl_3092))
begin
Tpl_2366 <= 0;
end
else
if (Tpl_3307)
begin
Tpl_2366 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2366 <= Tpl_2367;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR27_R0_RDLVLDQS1B2_PROC_1728
if ((!Tpl_3092))
begin
Tpl_2368 <= 0;
end
else
if (Tpl_3307)
begin
Tpl_2368 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2368 <= Tpl_2369;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR27_R0_RDLVLDQS1B3_PROC_1732
if ((!Tpl_3092))
begin
Tpl_2370 <= 0;
end
else
if (Tpl_3307)
begin
Tpl_2370 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2370 <= Tpl_2371;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR28_R0_RDLVLDQS1B4_PROC_1736
if ((!Tpl_3092))
begin
Tpl_2372 <= 0;
end
else
if (Tpl_3309)
begin
Tpl_2372 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2372 <= Tpl_2373;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR28_R0_RDLVLDQS1B5_PROC_1740
if ((!Tpl_3092))
begin
Tpl_2374 <= 0;
end
else
if (Tpl_3309)
begin
Tpl_2374 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2374 <= Tpl_2375;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR28_R0_RDLVLDQS1B6_PROC_1744
if ((!Tpl_3092))
begin
Tpl_2376 <= 0;
end
else
if (Tpl_3309)
begin
Tpl_2376 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2376 <= Tpl_2377;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR28_R0_RDLVLDQS1B7_PROC_1748
if ((!Tpl_3092))
begin
Tpl_2378 <= 0;
end
else
if (Tpl_3309)
begin
Tpl_2378 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2378 <= Tpl_2379;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR29_R0_RDLVLDQS2B0_PROC_1752
if ((!Tpl_3092))
begin
Tpl_2380 <= 0;
end
else
if (Tpl_3311)
begin
Tpl_2380 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2380 <= Tpl_2381;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR29_R0_RDLVLDQS2B1_PROC_1756
if ((!Tpl_3092))
begin
Tpl_2382 <= 0;
end
else
if (Tpl_3311)
begin
Tpl_2382 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2382 <= Tpl_2383;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR29_R0_RDLVLDQS2B2_PROC_1760
if ((!Tpl_3092))
begin
Tpl_2384 <= 0;
end
else
if (Tpl_3311)
begin
Tpl_2384 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2384 <= Tpl_2385;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR29_R0_RDLVLDQS2B3_PROC_1764
if ((!Tpl_3092))
begin
Tpl_2386 <= 0;
end
else
if (Tpl_3311)
begin
Tpl_2386 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2386 <= Tpl_2387;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR30_R0_RDLVLDQS2B4_PROC_1768
if ((!Tpl_3092))
begin
Tpl_2388 <= 0;
end
else
if (Tpl_3313)
begin
Tpl_2388 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2388 <= Tpl_2389;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR30_R0_RDLVLDQS2B5_PROC_1772
if ((!Tpl_3092))
begin
Tpl_2390 <= 0;
end
else
if (Tpl_3313)
begin
Tpl_2390 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2390 <= Tpl_2391;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR30_R0_RDLVLDQS2B6_PROC_1776
if ((!Tpl_3092))
begin
Tpl_2392 <= 0;
end
else
if (Tpl_3313)
begin
Tpl_2392 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2392 <= Tpl_2393;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR30_R0_RDLVLDQS2B7_PROC_1780
if ((!Tpl_3092))
begin
Tpl_2394 <= 0;
end
else
if (Tpl_3313)
begin
Tpl_2394 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2394 <= Tpl_2395;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR31_R0_RDLVLDQS3B0_PROC_1784
if ((!Tpl_3092))
begin
Tpl_2396 <= 0;
end
else
if (Tpl_3315)
begin
Tpl_2396 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2396 <= Tpl_2397;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR31_R0_RDLVLDQS3B1_PROC_1788
if ((!Tpl_3092))
begin
Tpl_2398 <= 0;
end
else
if (Tpl_3315)
begin
Tpl_2398 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2398 <= Tpl_2399;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR31_R0_RDLVLDQS3B2_PROC_1792
if ((!Tpl_3092))
begin
Tpl_2400 <= 0;
end
else
if (Tpl_3315)
begin
Tpl_2400 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2400 <= Tpl_2401;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR31_R0_RDLVLDQS3B3_PROC_1796
if ((!Tpl_3092))
begin
Tpl_2402 <= 0;
end
else
if (Tpl_3315)
begin
Tpl_2402 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2402 <= Tpl_2403;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR32_R0_RDLVLDQS3B4_PROC_1800
if ((!Tpl_3092))
begin
Tpl_2404 <= 0;
end
else
if (Tpl_3317)
begin
Tpl_2404 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2404 <= Tpl_2405;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR32_R0_RDLVLDQS3B5_PROC_1804
if ((!Tpl_3092))
begin
Tpl_2406 <= 0;
end
else
if (Tpl_3317)
begin
Tpl_2406 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2406 <= Tpl_2407;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR32_R0_RDLVLDQS3B6_PROC_1808
if ((!Tpl_3092))
begin
Tpl_2408 <= 0;
end
else
if (Tpl_3317)
begin
Tpl_2408 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2408 <= Tpl_2409;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR32_R0_RDLVLDQS3B7_PROC_1812
if ((!Tpl_3092))
begin
Tpl_2410 <= 0;
end
else
if (Tpl_3317)
begin
Tpl_2410 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2410 <= Tpl_2411;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR33_R0_RDLVLDMS0_PROC_1816
if ((!Tpl_3092))
begin
Tpl_2412 <= 0;
end
else
if (Tpl_3319)
begin
Tpl_2412 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2412 <= Tpl_2413;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR33_R0_RDLVLDMS1_PROC_1820
if ((!Tpl_3092))
begin
Tpl_2414 <= 0;
end
else
if (Tpl_3319)
begin
Tpl_2414 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2414 <= Tpl_2415;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR33_R0_RDLVLDMS2_PROC_1824
if ((!Tpl_3092))
begin
Tpl_2416 <= 0;
end
else
if (Tpl_3319)
begin
Tpl_2416 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2416 <= Tpl_2417;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR33_R0_RDLVLDMS3_PROC_1828
if ((!Tpl_3092))
begin
Tpl_2418 <= 0;
end
else
if (Tpl_3319)
begin
Tpl_2418 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2418 <= Tpl_2419;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR34_R0_VREFDQRDS0_PROC_1832
if ((!Tpl_3092))
begin
Tpl_2420 <= 0;
end
else
if (Tpl_3321)
begin
Tpl_2420 <= Tpl_3098[5:0];
end
else
if (Tpl_3102)
begin
Tpl_2420 <= Tpl_2421;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR34_R0_VREFDQRDS1_PROC_1836
if ((!Tpl_3092))
begin
Tpl_2422 <= 0;
end
else
if (Tpl_3321)
begin
Tpl_2422 <= Tpl_3098[11:6];
end
else
if (Tpl_3102)
begin
Tpl_2422 <= Tpl_2423;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR34_R0_VREFDQRDS2_PROC_1840
if ((!Tpl_3092))
begin
Tpl_2424 <= 0;
end
else
if (Tpl_3321)
begin
Tpl_2424 <= Tpl_3098[17:12];
end
else
if (Tpl_3102)
begin
Tpl_2424 <= Tpl_2425;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR34_R0_VREFDQRDS3_PROC_1844
if ((!Tpl_3092))
begin
Tpl_2426 <= 0;
end
else
if (Tpl_3321)
begin
Tpl_2426 <= Tpl_3098[23:18];
end
else
if (Tpl_3102)
begin
Tpl_2426 <= Tpl_2427;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR34_R0_VREFDQRDR_PROC_1848
if ((!Tpl_3092))
begin
Tpl_2428 <= 0;
end
else
if (Tpl_3321)
begin
Tpl_2428 <= Tpl_3098[24];
end
else
if (Tpl_3102)
begin
Tpl_2428 <= Tpl_2429;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR35_R1_VREFCAR_PROC_1852
if ((!Tpl_3092))
begin
Tpl_2430 <= 0;
end
else
if (Tpl_3323)
begin
Tpl_2430 <= Tpl_3098[0];
end
else
if (Tpl_3102)
begin
Tpl_2430 <= Tpl_2431;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR35_R1_VREFCAS_PROC_1856
if ((!Tpl_3092))
begin
Tpl_2432 <= 0;
end
else
if (Tpl_3323)
begin
Tpl_2432 <= Tpl_3098[6:1];
end
else
if (Tpl_3102)
begin
Tpl_2432 <= Tpl_2433;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR35_R1_VREFDQWRR_PROC_1860
if ((!Tpl_3092))
begin
Tpl_2434 <= 0;
end
else
if (Tpl_3323)
begin
Tpl_2434 <= Tpl_3098[7];
end
else
if (Tpl_3102)
begin
Tpl_2434 <= Tpl_2435;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR35_R1_VREFDQWRS_PROC_1864
if ((!Tpl_3092))
begin
Tpl_2436 <= 0;
end
else
if (Tpl_3323)
begin
Tpl_2436 <= Tpl_3098[13:8];
end
else
if (Tpl_3102)
begin
Tpl_2436 <= Tpl_2437;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR36_R1_CSC0_PROC_1868
if ((!Tpl_3092))
begin
Tpl_2438 <= 0;
end
else
if (Tpl_3325)
begin
Tpl_2438 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2438 <= Tpl_2439;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR36_R1_CSC1_PROC_1872
if ((!Tpl_3092))
begin
Tpl_2440 <= 0;
end
else
if (Tpl_3325)
begin
Tpl_2440 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2440 <= Tpl_2441;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR36_R1_CAC0B0_PROC_1876
if ((!Tpl_3092))
begin
Tpl_2442 <= 0;
end
else
if (Tpl_3325)
begin
Tpl_2442 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2442 <= Tpl_2443;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR36_R1_CAC0B1_PROC_1880
if ((!Tpl_3092))
begin
Tpl_2444 <= 0;
end
else
if (Tpl_3325)
begin
Tpl_2444 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2444 <= Tpl_2445;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR37_R1_CAC0B2_PROC_1884
if ((!Tpl_3092))
begin
Tpl_2446 <= 0;
end
else
if (Tpl_3327)
begin
Tpl_2446 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2446 <= Tpl_2447;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR37_R1_CAC0B3_PROC_1888
if ((!Tpl_3092))
begin
Tpl_2448 <= 0;
end
else
if (Tpl_3327)
begin
Tpl_2448 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2448 <= Tpl_2449;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR37_R1_CAC0B4_PROC_1892
if ((!Tpl_3092))
begin
Tpl_2450 <= 0;
end
else
if (Tpl_3327)
begin
Tpl_2450 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2450 <= Tpl_2451;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR37_R1_CAC0B5_PROC_1896
if ((!Tpl_3092))
begin
Tpl_2452 <= 0;
end
else
if (Tpl_3327)
begin
Tpl_2452 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2452 <= Tpl_2453;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR38_R1_CAC0B6_PROC_1900
if ((!Tpl_3092))
begin
Tpl_2454 <= 0;
end
else
if (Tpl_3329)
begin
Tpl_2454 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2454 <= Tpl_2455;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR38_R1_CAC0B7_PROC_1904
if ((!Tpl_3092))
begin
Tpl_2456 <= 0;
end
else
if (Tpl_3329)
begin
Tpl_2456 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2456 <= Tpl_2457;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR38_R1_CAC0B8_PROC_1908
if ((!Tpl_3092))
begin
Tpl_2458 <= 0;
end
else
if (Tpl_3329)
begin
Tpl_2458 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2458 <= Tpl_2459;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR38_R1_CAC0B9_PROC_1912
if ((!Tpl_3092))
begin
Tpl_2460 <= 0;
end
else
if (Tpl_3329)
begin
Tpl_2460 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2460 <= Tpl_2461;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR39_R1_CAC0B10_PROC_1916
if ((!Tpl_3092))
begin
Tpl_2462 <= 0;
end
else
if (Tpl_3331)
begin
Tpl_2462 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2462 <= Tpl_2463;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR39_R1_CAC0B11_PROC_1920
if ((!Tpl_3092))
begin
Tpl_2464 <= 0;
end
else
if (Tpl_3331)
begin
Tpl_2464 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2464 <= Tpl_2465;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR39_R1_CAC0B12_PROC_1924
if ((!Tpl_3092))
begin
Tpl_2466 <= 0;
end
else
if (Tpl_3331)
begin
Tpl_2466 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2466 <= Tpl_2467;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR39_R1_CAC0B13_PROC_1928
if ((!Tpl_3092))
begin
Tpl_2468 <= 0;
end
else
if (Tpl_3331)
begin
Tpl_2468 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2468 <= Tpl_2469;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR40_R1_CAC0B14_PROC_1932
if ((!Tpl_3092))
begin
Tpl_2470 <= 0;
end
else
if (Tpl_3333)
begin
Tpl_2470 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2470 <= Tpl_2471;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR40_R1_CAC0B15_PROC_1936
if ((!Tpl_3092))
begin
Tpl_2472 <= 0;
end
else
if (Tpl_3333)
begin
Tpl_2472 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2472 <= Tpl_2473;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR40_R1_CAC0B16_PROC_1940
if ((!Tpl_3092))
begin
Tpl_2474 <= 0;
end
else
if (Tpl_3333)
begin
Tpl_2474 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2474 <= Tpl_2475;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR40_R1_CAC0B17_PROC_1944
if ((!Tpl_3092))
begin
Tpl_2476 <= 0;
end
else
if (Tpl_3333)
begin
Tpl_2476 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2476 <= Tpl_2477;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR41_R1_CAC0B18_PROC_1948
if ((!Tpl_3092))
begin
Tpl_2478 <= 0;
end
else
if (Tpl_3335)
begin
Tpl_2478 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2478 <= Tpl_2479;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR41_R1_CAC1B0_PROC_1952
if ((!Tpl_3092))
begin
Tpl_2480 <= 0;
end
else
if (Tpl_3335)
begin
Tpl_2480 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2480 <= Tpl_2481;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR41_R1_CAC1B1_PROC_1956
if ((!Tpl_3092))
begin
Tpl_2482 <= 0;
end
else
if (Tpl_3335)
begin
Tpl_2482 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2482 <= Tpl_2483;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR41_R1_CAC1B2_PROC_1960
if ((!Tpl_3092))
begin
Tpl_2484 <= 0;
end
else
if (Tpl_3335)
begin
Tpl_2484 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2484 <= Tpl_2485;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR42_R1_CAC1B3_PROC_1964
if ((!Tpl_3092))
begin
Tpl_2486 <= 0;
end
else
if (Tpl_3337)
begin
Tpl_2486 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2486 <= Tpl_2487;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR42_R1_CAC1B4_PROC_1968
if ((!Tpl_3092))
begin
Tpl_2488 <= 0;
end
else
if (Tpl_3337)
begin
Tpl_2488 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2488 <= Tpl_2489;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR42_R1_CAC1B5_PROC_1972
if ((!Tpl_3092))
begin
Tpl_2490 <= 0;
end
else
if (Tpl_3337)
begin
Tpl_2490 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2490 <= Tpl_2491;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR42_R1_CAC1B6_PROC_1976
if ((!Tpl_3092))
begin
Tpl_2492 <= 0;
end
else
if (Tpl_3337)
begin
Tpl_2492 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2492 <= Tpl_2493;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR43_R1_CAC1B7_PROC_1980
if ((!Tpl_3092))
begin
Tpl_2494 <= 0;
end
else
if (Tpl_3339)
begin
Tpl_2494 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2494 <= Tpl_2495;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR43_R1_CAC1B8_PROC_1984
if ((!Tpl_3092))
begin
Tpl_2496 <= 0;
end
else
if (Tpl_3339)
begin
Tpl_2496 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2496 <= Tpl_2497;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR43_R1_CAC1B9_PROC_1988
if ((!Tpl_3092))
begin
Tpl_2498 <= 0;
end
else
if (Tpl_3339)
begin
Tpl_2498 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2498 <= Tpl_2499;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR43_R1_CAC1B10_PROC_1992
if ((!Tpl_3092))
begin
Tpl_2500 <= 0;
end
else
if (Tpl_3339)
begin
Tpl_2500 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2500 <= Tpl_2501;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR44_R1_CAC1B11_PROC_1996
if ((!Tpl_3092))
begin
Tpl_2502 <= 0;
end
else
if (Tpl_3341)
begin
Tpl_2502 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2502 <= Tpl_2503;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR44_R1_CAC1B12_PROC_2000
if ((!Tpl_3092))
begin
Tpl_2504 <= 0;
end
else
if (Tpl_3341)
begin
Tpl_2504 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2504 <= Tpl_2505;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR44_R1_CAC1B13_PROC_2004
if ((!Tpl_3092))
begin
Tpl_2506 <= 0;
end
else
if (Tpl_3341)
begin
Tpl_2506 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2506 <= Tpl_2507;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR44_R1_CAC1B14_PROC_2008
if ((!Tpl_3092))
begin
Tpl_2508 <= 0;
end
else
if (Tpl_3341)
begin
Tpl_2508 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2508 <= Tpl_2509;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR45_R1_CAC1B15_PROC_2012
if ((!Tpl_3092))
begin
Tpl_2510 <= 0;
end
else
if (Tpl_3343)
begin
Tpl_2510 <= Tpl_3098[6:0];
end
else
if (Tpl_3102)
begin
Tpl_2510 <= Tpl_2511;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR45_R1_CAC1B16_PROC_2016
if ((!Tpl_3092))
begin
Tpl_2512 <= 0;
end
else
if (Tpl_3343)
begin
Tpl_2512 <= Tpl_3098[13:7];
end
else
if (Tpl_3102)
begin
Tpl_2512 <= Tpl_2513;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR45_R1_CAC1B17_PROC_2020
if ((!Tpl_3092))
begin
Tpl_2514 <= 0;
end
else
if (Tpl_3343)
begin
Tpl_2514 <= Tpl_3098[20:14];
end
else
if (Tpl_3102)
begin
Tpl_2514 <= Tpl_2515;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR45_R1_CAC1B18_PROC_2024
if ((!Tpl_3092))
begin
Tpl_2516 <= 0;
end
else
if (Tpl_3343)
begin
Tpl_2516 <= Tpl_3098[27:21];
end
else
if (Tpl_3102)
begin
Tpl_2516 <= Tpl_2517;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR46_R1_BAC0B0_PROC_2028
if ((!Tpl_3092))
begin
Tpl_2518 <= 0;
end
else
if (Tpl_3345)
begin
Tpl_2518 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR46_R1_BAC0B1_PROC_2031
if ((!Tpl_3092))
begin
Tpl_2519 <= 0;
end
else
if (Tpl_3345)
begin
Tpl_2519 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR46_R1_BAC0B2_PROC_2034
if ((!Tpl_3092))
begin
Tpl_2520 <= 0;
end
else
if (Tpl_3345)
begin
Tpl_2520 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR46_R1_BAC0B3_PROC_2037
if ((!Tpl_3092))
begin
Tpl_2521 <= 0;
end
else
if (Tpl_3345)
begin
Tpl_2521 <= Tpl_3098[27:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR47_R1_BAC1B0_PROC_2040
if ((!Tpl_3092))
begin
Tpl_2522 <= 0;
end
else
if (Tpl_3347)
begin
Tpl_2522 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR47_R1_BAC1B1_PROC_2043
if ((!Tpl_3092))
begin
Tpl_2523 <= 0;
end
else
if (Tpl_3347)
begin
Tpl_2523 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR47_R1_BAC1B2_PROC_2046
if ((!Tpl_3092))
begin
Tpl_2524 <= 0;
end
else
if (Tpl_3347)
begin
Tpl_2524 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR47_R1_BAC1B3_PROC_2049
if ((!Tpl_3092))
begin
Tpl_2525 <= 0;
end
else
if (Tpl_3347)
begin
Tpl_2525 <= Tpl_3098[27:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR48_R1_ACTNC0_PROC_2052
if ((!Tpl_3092))
begin
Tpl_2526 <= 0;
end
else
if (Tpl_3349)
begin
Tpl_2526 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR48_R1_ACTNC1_PROC_2055
if ((!Tpl_3092))
begin
Tpl_2527 <= 0;
end
else
if (Tpl_3349)
begin
Tpl_2527 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR48_R1_CKEC0_PROC_2058
if ((!Tpl_3092))
begin
Tpl_2528 <= 0;
end
else
if (Tpl_3349)
begin
Tpl_2528 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR48_R1_CKEC1_PROC_2061
if ((!Tpl_3092))
begin
Tpl_2529 <= 0;
end
else
if (Tpl_3349)
begin
Tpl_2529 <= Tpl_3098[27:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR49_R1_GTS0_PROC_2064
if ((!Tpl_3092))
begin
Tpl_2530 <= 0;
end
else
if (Tpl_3351)
begin
Tpl_2530 <= Tpl_3098[5:0];
end
else
if (Tpl_3102)
begin
Tpl_2530 <= Tpl_2531;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR49_R1_GTS1_PROC_2068
if ((!Tpl_3092))
begin
Tpl_2532 <= 0;
end
else
if (Tpl_3351)
begin
Tpl_2532 <= Tpl_3098[11:6];
end
else
if (Tpl_3102)
begin
Tpl_2532 <= Tpl_2533;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR49_R1_GTS2_PROC_2072
if ((!Tpl_3092))
begin
Tpl_2534 <= 0;
end
else
if (Tpl_3351)
begin
Tpl_2534 <= Tpl_3098[17:12];
end
else
if (Tpl_3102)
begin
Tpl_2534 <= Tpl_2535;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR49_R1_GTS3_PROC_2076
if ((!Tpl_3092))
begin
Tpl_2536 <= 0;
end
else
if (Tpl_3351)
begin
Tpl_2536 <= Tpl_3098[23:18];
end
else
if (Tpl_3102)
begin
Tpl_2536 <= Tpl_2537;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR50_R1_WRLVLS0_PROC_2080
if ((!Tpl_3092))
begin
Tpl_2538 <= 0;
end
else
if (Tpl_3353)
begin
Tpl_2538 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2538 <= Tpl_2539;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR50_R1_WRLVLS1_PROC_2084
if ((!Tpl_3092))
begin
Tpl_2540 <= 0;
end
else
if (Tpl_3353)
begin
Tpl_2540 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2540 <= Tpl_2541;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR50_R1_WRLVLS2_PROC_2088
if ((!Tpl_3092))
begin
Tpl_2542 <= 0;
end
else
if (Tpl_3353)
begin
Tpl_2542 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2542 <= Tpl_2543;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR50_R1_WRLVLS3_PROC_2092
if ((!Tpl_3092))
begin
Tpl_2544 <= 0;
end
else
if (Tpl_3353)
begin
Tpl_2544 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2544 <= Tpl_2545;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR51_R1_DQSDQS0B0_PROC_2096
if ((!Tpl_3092))
begin
Tpl_2546 <= 0;
end
else
if (Tpl_3355)
begin
Tpl_2546 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2546 <= Tpl_2547;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR51_R1_DQSDQS0B1_PROC_2100
if ((!Tpl_3092))
begin
Tpl_2548 <= 0;
end
else
if (Tpl_3355)
begin
Tpl_2548 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2548 <= Tpl_2549;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR51_R1_DQSDQS0B2_PROC_2104
if ((!Tpl_3092))
begin
Tpl_2550 <= 0;
end
else
if (Tpl_3355)
begin
Tpl_2550 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2550 <= Tpl_2551;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR51_R1_DQSDQS0B3_PROC_2108
if ((!Tpl_3092))
begin
Tpl_2552 <= 0;
end
else
if (Tpl_3355)
begin
Tpl_2552 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2552 <= Tpl_2553;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR52_R1_DQSDQS0B4_PROC_2112
if ((!Tpl_3092))
begin
Tpl_2554 <= 0;
end
else
if (Tpl_3357)
begin
Tpl_2554 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2554 <= Tpl_2555;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR52_R1_DQSDQS0B5_PROC_2116
if ((!Tpl_3092))
begin
Tpl_2556 <= 0;
end
else
if (Tpl_3357)
begin
Tpl_2556 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2556 <= Tpl_2557;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR52_R1_DQSDQS0B6_PROC_2120
if ((!Tpl_3092))
begin
Tpl_2558 <= 0;
end
else
if (Tpl_3357)
begin
Tpl_2558 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2558 <= Tpl_2559;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR52_R1_DQSDQS0B7_PROC_2124
if ((!Tpl_3092))
begin
Tpl_2560 <= 0;
end
else
if (Tpl_3357)
begin
Tpl_2560 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2560 <= Tpl_2561;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR53_R1_DQSDQS1B0_PROC_2128
if ((!Tpl_3092))
begin
Tpl_2562 <= 0;
end
else
if (Tpl_3359)
begin
Tpl_2562 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2562 <= Tpl_2563;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR53_R1_DQSDQS1B1_PROC_2132
if ((!Tpl_3092))
begin
Tpl_2564 <= 0;
end
else
if (Tpl_3359)
begin
Tpl_2564 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2564 <= Tpl_2565;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR53_R1_DQSDQS1B2_PROC_2136
if ((!Tpl_3092))
begin
Tpl_2566 <= 0;
end
else
if (Tpl_3359)
begin
Tpl_2566 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2566 <= Tpl_2567;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR53_R1_DQSDQS1B3_PROC_2140
if ((!Tpl_3092))
begin
Tpl_2568 <= 0;
end
else
if (Tpl_3359)
begin
Tpl_2568 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2568 <= Tpl_2569;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR54_R1_DQSDQS1B4_PROC_2144
if ((!Tpl_3092))
begin
Tpl_2570 <= 0;
end
else
if (Tpl_3361)
begin
Tpl_2570 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2570 <= Tpl_2571;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR54_R1_DQSDQS1B5_PROC_2148
if ((!Tpl_3092))
begin
Tpl_2572 <= 0;
end
else
if (Tpl_3361)
begin
Tpl_2572 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2572 <= Tpl_2573;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR54_R1_DQSDQS1B6_PROC_2152
if ((!Tpl_3092))
begin
Tpl_2574 <= 0;
end
else
if (Tpl_3361)
begin
Tpl_2574 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2574 <= Tpl_2575;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR54_R1_DQSDQS1B7_PROC_2156
if ((!Tpl_3092))
begin
Tpl_2576 <= 0;
end
else
if (Tpl_3361)
begin
Tpl_2576 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2576 <= Tpl_2577;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR55_R1_DQSDQS2B0_PROC_2160
if ((!Tpl_3092))
begin
Tpl_2578 <= 0;
end
else
if (Tpl_3363)
begin
Tpl_2578 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2578 <= Tpl_2579;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR55_R1_DQSDQS2B1_PROC_2164
if ((!Tpl_3092))
begin
Tpl_2580 <= 0;
end
else
if (Tpl_3363)
begin
Tpl_2580 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2580 <= Tpl_2581;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR55_R1_DQSDQS2B2_PROC_2168
if ((!Tpl_3092))
begin
Tpl_2582 <= 0;
end
else
if (Tpl_3363)
begin
Tpl_2582 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2582 <= Tpl_2583;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR55_R1_DQSDQS2B3_PROC_2172
if ((!Tpl_3092))
begin
Tpl_2584 <= 0;
end
else
if (Tpl_3363)
begin
Tpl_2584 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2584 <= Tpl_2585;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR56_R1_DQSDQS2B4_PROC_2176
if ((!Tpl_3092))
begin
Tpl_2586 <= 0;
end
else
if (Tpl_3365)
begin
Tpl_2586 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2586 <= Tpl_2587;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR56_R1_DQSDQS2B5_PROC_2180
if ((!Tpl_3092))
begin
Tpl_2588 <= 0;
end
else
if (Tpl_3365)
begin
Tpl_2588 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2588 <= Tpl_2589;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR56_R1_DQSDQS2B6_PROC_2184
if ((!Tpl_3092))
begin
Tpl_2590 <= 0;
end
else
if (Tpl_3365)
begin
Tpl_2590 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2590 <= Tpl_2591;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR56_R1_DQSDQS2B7_PROC_2188
if ((!Tpl_3092))
begin
Tpl_2592 <= 0;
end
else
if (Tpl_3365)
begin
Tpl_2592 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2592 <= Tpl_2593;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR57_R1_DQSDQS3B0_PROC_2192
if ((!Tpl_3092))
begin
Tpl_2594 <= 0;
end
else
if (Tpl_3367)
begin
Tpl_2594 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2594 <= Tpl_2595;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR57_R1_DQSDQS3B1_PROC_2196
if ((!Tpl_3092))
begin
Tpl_2596 <= 0;
end
else
if (Tpl_3367)
begin
Tpl_2596 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2596 <= Tpl_2597;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR57_R1_DQSDQS3B2_PROC_2200
if ((!Tpl_3092))
begin
Tpl_2598 <= 0;
end
else
if (Tpl_3367)
begin
Tpl_2598 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2598 <= Tpl_2599;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR57_R1_DQSDQS3B3_PROC_2204
if ((!Tpl_3092))
begin
Tpl_2600 <= 0;
end
else
if (Tpl_3367)
begin
Tpl_2600 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2600 <= Tpl_2601;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR58_R1_DQSDQS3B4_PROC_2208
if ((!Tpl_3092))
begin
Tpl_2602 <= 0;
end
else
if (Tpl_3369)
begin
Tpl_2602 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2602 <= Tpl_2603;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR58_R1_DQSDQS3B5_PROC_2212
if ((!Tpl_3092))
begin
Tpl_2604 <= 0;
end
else
if (Tpl_3369)
begin
Tpl_2604 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2604 <= Tpl_2605;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR58_R1_DQSDQS3B6_PROC_2216
if ((!Tpl_3092))
begin
Tpl_2606 <= 0;
end
else
if (Tpl_3369)
begin
Tpl_2606 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2606 <= Tpl_2607;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR58_R1_DQSDQS3B7_PROC_2220
if ((!Tpl_3092))
begin
Tpl_2608 <= 0;
end
else
if (Tpl_3369)
begin
Tpl_2608 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2608 <= Tpl_2609;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR59_R1_DQSDMS0_PROC_2224
if ((!Tpl_3092))
begin
Tpl_2610 <= 0;
end
else
if (Tpl_3371)
begin
Tpl_2610 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2610 <= Tpl_2611;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR59_R1_DQSDMS1_PROC_2228
if ((!Tpl_3092))
begin
Tpl_2612 <= 0;
end
else
if (Tpl_3371)
begin
Tpl_2612 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2612 <= Tpl_2613;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR59_R1_DQSDMS2_PROC_2232
if ((!Tpl_3092))
begin
Tpl_2614 <= 0;
end
else
if (Tpl_3371)
begin
Tpl_2614 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2614 <= Tpl_2615;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR59_R1_DQSDMS3_PROC_2236
if ((!Tpl_3092))
begin
Tpl_2616 <= 0;
end
else
if (Tpl_3371)
begin
Tpl_2616 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2616 <= Tpl_2617;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR60_R1_RDLVLDQS0B0_PROC_2240
if ((!Tpl_3092))
begin
Tpl_2618 <= 0;
end
else
if (Tpl_3373)
begin
Tpl_2618 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2618 <= Tpl_2619;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR60_R1_RDLVLDQS0B1_PROC_2244
if ((!Tpl_3092))
begin
Tpl_2620 <= 0;
end
else
if (Tpl_3373)
begin
Tpl_2620 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2620 <= Tpl_2621;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR60_R1_RDLVLDQS0B2_PROC_2248
if ((!Tpl_3092))
begin
Tpl_2622 <= 0;
end
else
if (Tpl_3373)
begin
Tpl_2622 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2622 <= Tpl_2623;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR60_R1_RDLVLDQS0B3_PROC_2252
if ((!Tpl_3092))
begin
Tpl_2624 <= 0;
end
else
if (Tpl_3373)
begin
Tpl_2624 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2624 <= Tpl_2625;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR61_R1_RDLVLDQS0B4_PROC_2256
if ((!Tpl_3092))
begin
Tpl_2626 <= 0;
end
else
if (Tpl_3375)
begin
Tpl_2626 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2626 <= Tpl_2627;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR61_R1_RDLVLDQS0B5_PROC_2260
if ((!Tpl_3092))
begin
Tpl_2628 <= 0;
end
else
if (Tpl_3375)
begin
Tpl_2628 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2628 <= Tpl_2629;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR61_R1_RDLVLDQS0B6_PROC_2264
if ((!Tpl_3092))
begin
Tpl_2630 <= 0;
end
else
if (Tpl_3375)
begin
Tpl_2630 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2630 <= Tpl_2631;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR61_R1_RDLVLDQS0B7_PROC_2268
if ((!Tpl_3092))
begin
Tpl_2632 <= 0;
end
else
if (Tpl_3375)
begin
Tpl_2632 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2632 <= Tpl_2633;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR62_R1_RDLVLDQS1B0_PROC_2272
if ((!Tpl_3092))
begin
Tpl_2634 <= 0;
end
else
if (Tpl_3377)
begin
Tpl_2634 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2634 <= Tpl_2635;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR62_R1_RDLVLDQS1B1_PROC_2276
if ((!Tpl_3092))
begin
Tpl_2636 <= 0;
end
else
if (Tpl_3377)
begin
Tpl_2636 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2636 <= Tpl_2637;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR62_R1_RDLVLDQS1B2_PROC_2280
if ((!Tpl_3092))
begin
Tpl_2638 <= 0;
end
else
if (Tpl_3377)
begin
Tpl_2638 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2638 <= Tpl_2639;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR62_R1_RDLVLDQS1B3_PROC_2284
if ((!Tpl_3092))
begin
Tpl_2640 <= 0;
end
else
if (Tpl_3377)
begin
Tpl_2640 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2640 <= Tpl_2641;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR63_R1_RDLVLDQS1B4_PROC_2288
if ((!Tpl_3092))
begin
Tpl_2642 <= 0;
end
else
if (Tpl_3379)
begin
Tpl_2642 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2642 <= Tpl_2643;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR63_R1_RDLVLDQS1B5_PROC_2292
if ((!Tpl_3092))
begin
Tpl_2644 <= 0;
end
else
if (Tpl_3379)
begin
Tpl_2644 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2644 <= Tpl_2645;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR63_R1_RDLVLDQS1B6_PROC_2296
if ((!Tpl_3092))
begin
Tpl_2646 <= 0;
end
else
if (Tpl_3379)
begin
Tpl_2646 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2646 <= Tpl_2647;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR63_R1_RDLVLDQS1B7_PROC_2300
if ((!Tpl_3092))
begin
Tpl_2648 <= 0;
end
else
if (Tpl_3379)
begin
Tpl_2648 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2648 <= Tpl_2649;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR64_R1_RDLVLDQS2B0_PROC_2304
if ((!Tpl_3092))
begin
Tpl_2650 <= 0;
end
else
if (Tpl_3381)
begin
Tpl_2650 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2650 <= Tpl_2651;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR64_R1_RDLVLDQS2B1_PROC_2308
if ((!Tpl_3092))
begin
Tpl_2652 <= 0;
end
else
if (Tpl_3381)
begin
Tpl_2652 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2652 <= Tpl_2653;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR64_R1_RDLVLDQS2B2_PROC_2312
if ((!Tpl_3092))
begin
Tpl_2654 <= 0;
end
else
if (Tpl_3381)
begin
Tpl_2654 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2654 <= Tpl_2655;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR64_R1_RDLVLDQS2B3_PROC_2316
if ((!Tpl_3092))
begin
Tpl_2656 <= 0;
end
else
if (Tpl_3381)
begin
Tpl_2656 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2656 <= Tpl_2657;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR65_R1_RDLVLDQS2B4_PROC_2320
if ((!Tpl_3092))
begin
Tpl_2658 <= 0;
end
else
if (Tpl_3383)
begin
Tpl_2658 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2658 <= Tpl_2659;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR65_R1_RDLVLDQS2B5_PROC_2324
if ((!Tpl_3092))
begin
Tpl_2660 <= 0;
end
else
if (Tpl_3383)
begin
Tpl_2660 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2660 <= Tpl_2661;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR65_R1_RDLVLDQS2B6_PROC_2328
if ((!Tpl_3092))
begin
Tpl_2662 <= 0;
end
else
if (Tpl_3383)
begin
Tpl_2662 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2662 <= Tpl_2663;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR65_R1_RDLVLDQS2B7_PROC_2332
if ((!Tpl_3092))
begin
Tpl_2664 <= 0;
end
else
if (Tpl_3383)
begin
Tpl_2664 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2664 <= Tpl_2665;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR66_R1_RDLVLDQS3B0_PROC_2336
if ((!Tpl_3092))
begin
Tpl_2666 <= 0;
end
else
if (Tpl_3385)
begin
Tpl_2666 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2666 <= Tpl_2667;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR66_R1_RDLVLDQS3B1_PROC_2340
if ((!Tpl_3092))
begin
Tpl_2668 <= 0;
end
else
if (Tpl_3385)
begin
Tpl_2668 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2668 <= Tpl_2669;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR66_R1_RDLVLDQS3B2_PROC_2344
if ((!Tpl_3092))
begin
Tpl_2670 <= 0;
end
else
if (Tpl_3385)
begin
Tpl_2670 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2670 <= Tpl_2671;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR66_R1_RDLVLDQS3B3_PROC_2348
if ((!Tpl_3092))
begin
Tpl_2672 <= 0;
end
else
if (Tpl_3385)
begin
Tpl_2672 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2672 <= Tpl_2673;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR67_R1_RDLVLDQS3B4_PROC_2352
if ((!Tpl_3092))
begin
Tpl_2674 <= 0;
end
else
if (Tpl_3387)
begin
Tpl_2674 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2674 <= Tpl_2675;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR67_R1_RDLVLDQS3B5_PROC_2356
if ((!Tpl_3092))
begin
Tpl_2676 <= 0;
end
else
if (Tpl_3387)
begin
Tpl_2676 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2676 <= Tpl_2677;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR67_R1_RDLVLDQS3B6_PROC_2360
if ((!Tpl_3092))
begin
Tpl_2678 <= 0;
end
else
if (Tpl_3387)
begin
Tpl_2678 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2678 <= Tpl_2679;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR67_R1_RDLVLDQS3B7_PROC_2364
if ((!Tpl_3092))
begin
Tpl_2680 <= 0;
end
else
if (Tpl_3387)
begin
Tpl_2680 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2680 <= Tpl_2681;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR68_R1_RDLVLDMS0_PROC_2368
if ((!Tpl_3092))
begin
Tpl_2682 <= 0;
end
else
if (Tpl_3389)
begin
Tpl_2682 <= Tpl_3098[7:0];
end
else
if (Tpl_3102)
begin
Tpl_2682 <= Tpl_2683;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR68_R1_RDLVLDMS1_PROC_2372
if ((!Tpl_3092))
begin
Tpl_2684 <= 0;
end
else
if (Tpl_3389)
begin
Tpl_2684 <= Tpl_3098[15:8];
end
else
if (Tpl_3102)
begin
Tpl_2684 <= Tpl_2685;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR68_R1_RDLVLDMS2_PROC_2376
if ((!Tpl_3092))
begin
Tpl_2686 <= 0;
end
else
if (Tpl_3389)
begin
Tpl_2686 <= Tpl_3098[23:16];
end
else
if (Tpl_3102)
begin
Tpl_2686 <= Tpl_2687;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR68_R1_RDLVLDMS3_PROC_2380
if ((!Tpl_3092))
begin
Tpl_2688 <= 0;
end
else
if (Tpl_3389)
begin
Tpl_2688 <= Tpl_3098[31:24];
end
else
if (Tpl_3102)
begin
Tpl_2688 <= Tpl_2689;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR69_R0_PSCK_PROC_2384
if ((!Tpl_3092))
begin
Tpl_2690 <= 0;
end
else
if (Tpl_3391)
begin
Tpl_2690 <= Tpl_3098[3:0];
end
else
if (Tpl_3102)
begin
Tpl_2690 <= Tpl_2691;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR69_R0_DQSLEADCK_PROC_2388
if ((!Tpl_3092))
begin
Tpl_2692 <= 0;
end
else
if (Tpl_3391)
begin
Tpl_2692 <= Tpl_3098[7:4];
end
else
if (Tpl_3102)
begin
Tpl_2692 <= Tpl_2693;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR69_R1_PSCK_PROC_2392
if ((!Tpl_3092))
begin
Tpl_2694 <= 0;
end
else
if (Tpl_3391)
begin
Tpl_2694 <= Tpl_3098[11:8];
end
else
if (Tpl_3102)
begin
Tpl_2694 <= Tpl_2695;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR69_R1_DQSLEADCK_PROC_2396
if ((!Tpl_3092))
begin
Tpl_2696 <= 0;
end
else
if (Tpl_3391)
begin
Tpl_2696 <= Tpl_3098[15:12];
end
else
if (Tpl_3102)
begin
Tpl_2696 <= Tpl_2697;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR69_SANPAT_PROC_2400
if ((!Tpl_3092))
begin
Tpl_2698 <= 0;
end
else
if (Tpl_3391)
begin
Tpl_2698 <= Tpl_3098[31:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR70_ODTC0_PROC_2403
if ((!Tpl_3092))
begin
Tpl_2699 <= 0;
end
else
if (Tpl_3393)
begin
Tpl_2699 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR70_ODTC1_PROC_2406
if ((!Tpl_3092))
begin
Tpl_2700 <= 0;
end
else
if (Tpl_3393)
begin
Tpl_2700 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR70_RSTNC0_PROC_2409
if ((!Tpl_3092))
begin
Tpl_2701 <= 0;
end
else
if (Tpl_3393)
begin
Tpl_2701 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR70_RSTNC1_PROC_2412
if ((!Tpl_3092))
begin
Tpl_2702 <= 0;
end
else
if (Tpl_3393)
begin
Tpl_2702 <= Tpl_3098[27:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTSR70_NT_RANK_PROC_2415
if ((!Tpl_3092))
begin
Tpl_2703 <= 0;
end
else
if (Tpl_3393)
begin
Tpl_2703 <= Tpl_3098[28];
end
else
if (Tpl_3102)
begin
Tpl_2703 <= Tpl_2704;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CALVLPA0_PATTERN_A_PROC_2419
if ((!Tpl_3092))
begin
Tpl_2705 <= 0;
end
else
if (Tpl_3395)
begin
Tpl_2705 <= Tpl_3098[19:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: CALVLPA1_PATTERN_B_PROC_2422
if ((!Tpl_3092))
begin
Tpl_2706 <= 0;
end
else
if (Tpl_3397)
begin
Tpl_2706 <= Tpl_3098[19:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG1_T_ALRTP_PROC_2425
if ((!Tpl_3092))
begin
Tpl_2707 <= 0;
end
else
if (Tpl_3399)
begin
Tpl_2707 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG1_T_CKESR_PROC_2428
if ((!Tpl_3092))
begin
Tpl_2708 <= 0;
end
else
if (Tpl_3399)
begin
Tpl_2708 <= Tpl_3098[10:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG1_T_CCD_S_PROC_2431
if ((!Tpl_3092))
begin
Tpl_2709 <= 0;
end
else
if (Tpl_3399)
begin
Tpl_2709 <= Tpl_3098[15:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG1_T_FAW_PROC_2434
if ((!Tpl_3092))
begin
Tpl_2710 <= 0;
end
else
if (Tpl_3399)
begin
Tpl_2710 <= Tpl_3098[22:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG1_T_RTW_PROC_2437
if ((!Tpl_3092))
begin
Tpl_2711 <= 0;
end
else
if (Tpl_3399)
begin
Tpl_2711 <= Tpl_3098[30:23];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG2_T_RCD_PROC_2440
if ((!Tpl_3092))
begin
Tpl_2712 <= 8'h0b;
end
else
if (Tpl_3401)
begin
Tpl_2712 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG2_T_RDPDEN_PROC_2443
if ((!Tpl_3092))
begin
Tpl_2713 <= 0;
end
else
if (Tpl_3401)
begin
Tpl_2713 <= Tpl_3098[13:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG2_T_RC_PROC_2446
if ((!Tpl_3092))
begin
Tpl_2714 <= 0;
end
else
if (Tpl_3401)
begin
Tpl_2714 <= Tpl_3098[21:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG2_T_RAS_PROC_2449
if ((!Tpl_3092))
begin
Tpl_2715 <= 0;
end
else
if (Tpl_3401)
begin
Tpl_2715 <= Tpl_3098[29:22];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG3_T_PD_PROC_2452
if ((!Tpl_3092))
begin
Tpl_2716 <= 0;
end
else
if (Tpl_3403)
begin
Tpl_2716 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG3_T_RP_PROC_2455
if ((!Tpl_3092))
begin
Tpl_2717 <= 8'h0b;
end
else
if (Tpl_3403)
begin
Tpl_2717 <= Tpl_3098[11:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG3_T_WLBR_PROC_2458
if ((!Tpl_3092))
begin
Tpl_2718 <= 0;
end
else
if (Tpl_3403)
begin
Tpl_2718 <= Tpl_3098[19:12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG3_T_WRAPDEN_PROC_2461
if ((!Tpl_3092))
begin
Tpl_2719 <= 0;
end
else
if (Tpl_3403)
begin
Tpl_2719 <= Tpl_3098[27:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG3_T_CKE_PROC_2464
if ((!Tpl_3092))
begin
Tpl_2720 <= 0;
end
else
if (Tpl_3403)
begin
Tpl_2720 <= Tpl_3098[31:28];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG4_T_XP_PROC_2467
if ((!Tpl_3092))
begin
Tpl_2721 <= 0;
end
else
if (Tpl_3405)
begin
Tpl_2721 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG4_T_VREFTIMELONG_PROC_2470
if ((!Tpl_3092))
begin
Tpl_2722 <= 10'h0c8;
end
else
if (Tpl_3405)
begin
Tpl_2722 <= Tpl_3098[14:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG4_T_VREFTIMESHORT_PROC_2473
if ((!Tpl_3092))
begin
Tpl_2723 <= 8'h50;
end
else
if (Tpl_3405)
begin
Tpl_2723 <= Tpl_3098[22:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG4_T_MRD_PROC_2476
if ((!Tpl_3092))
begin
Tpl_2724 <= 8'h08;
end
else
if (Tpl_3405)
begin
Tpl_2724 <= Tpl_3098[28:23];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG5_T_ZQCS_ITV_PROC_2479
if ((!Tpl_3092))
begin
Tpl_2725 <= 0;
end
else
if (Tpl_3407)
begin
Tpl_2725 <= Tpl_3098[27:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG6_T_PORI_PROC_2482
if ((!Tpl_3092))
begin
Tpl_2726 <= 20'hc3500;
end
else
if (Tpl_3409)
begin
Tpl_2726 <= Tpl_3098[19:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG6_T_ZQINIT_PROC_2485
if ((!Tpl_3092))
begin
Tpl_2727 <= 11'h640;
end
else
if (Tpl_3409)
begin
Tpl_2727 <= Tpl_3098[30:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG7_T_MRS2LVLEN_PROC_2488
if ((!Tpl_3092))
begin
Tpl_2728 <= 20'hc3500;
end
else
if (Tpl_3411)
begin
Tpl_2728 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG7_T_ZQCS_PROC_2491
if ((!Tpl_3092))
begin
Tpl_2729 <= 0;
end
else
if (Tpl_3411)
begin
Tpl_2729 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG7_T_XPDLL_PROC_2494
if ((!Tpl_3092))
begin
Tpl_2730 <= 0;
end
else
if (Tpl_3411)
begin
Tpl_2730 <= Tpl_3098[21:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG7_T_WLBTR_PROC_2497
if ((!Tpl_3092))
begin
Tpl_2731 <= 0;
end
else
if (Tpl_3411)
begin
Tpl_2731 <= Tpl_3098[28:22];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG8_T_RRD_S_PROC_2500
if ((!Tpl_3092))
begin
Tpl_2732 <= 0;
end
else
if (Tpl_3413)
begin
Tpl_2732 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG8_T_RFC1_PROC_2503
if ((!Tpl_3092))
begin
Tpl_2733 <= 0;
end
else
if (Tpl_3413)
begin
Tpl_2733 <= Tpl_3098[14:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG8_T_MRS2ACT_PROC_2506
if ((!Tpl_3092))
begin
Tpl_2734 <= 0;
end
else
if (Tpl_3413)
begin
Tpl_2734 <= Tpl_3098[22:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG8_T_LVLAA_PROC_2509
if ((!Tpl_3092))
begin
Tpl_2735 <= 8'h08;
end
else
if (Tpl_3413)
begin
Tpl_2735 <= Tpl_3098[30:23];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG9_T_DLLK_PROC_2512
if ((!Tpl_3092))
begin
Tpl_2736 <= 0;
end
else
if (Tpl_3415)
begin
Tpl_2736 <= Tpl_3098[10:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG9_T_REFI_OFF_PROC_2515
if ((!Tpl_3092))
begin
Tpl_2737 <= 0;
end
else
if (Tpl_3415)
begin
Tpl_2737 <= Tpl_3098[24:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG9_T_MPRR_PROC_2518
if ((!Tpl_3092))
begin
Tpl_2738 <= 0;
end
else
if (Tpl_3415)
begin
Tpl_2738 <= Tpl_3098[26:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG10_T_XPR_PROC_2521
if ((!Tpl_3092))
begin
Tpl_2739 <= 20'h00018;
end
else
if (Tpl_3417)
begin
Tpl_2739 <= Tpl_3098[19:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG10_T_DLLRST_PROC_2524
if ((!Tpl_3092))
begin
Tpl_2740 <= 8'h04;
end
else
if (Tpl_3417)
begin
Tpl_2740 <= Tpl_3098[27:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG11_T_RST_PROC_2527
if ((!Tpl_3092))
begin
Tpl_2741 <= 20'h4e200;
end
else
if (Tpl_3419)
begin
Tpl_2741 <= Tpl_3098[19:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG11_T_ODTH4_PROC_2530
if ((!Tpl_3092))
begin
Tpl_2742 <= 0;
end
else
if (Tpl_3419)
begin
Tpl_2742 <= Tpl_3098[27:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG12_T_ODTH8_PROC_2533
if ((!Tpl_3092))
begin
Tpl_2743 <= 0;
end
else
if (Tpl_3421)
begin
Tpl_2743 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG12_T_LVLLOAD_PROC_2536
if ((!Tpl_3092))
begin
Tpl_2744 <= 8'h04;
end
else
if (Tpl_3421)
begin
Tpl_2744 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG12_T_LVLDLL_PROC_2539
if ((!Tpl_3092))
begin
Tpl_2745 <= 8'h04;
end
else
if (Tpl_3421)
begin
Tpl_2745 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG12_T_LVLRESP_PROC_2542
if ((!Tpl_3092))
begin
Tpl_2746 <= 8'h32;
end
else
if (Tpl_3421)
begin
Tpl_2746 <= Tpl_3098[31:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG13_T_XS_PROC_2545
if ((!Tpl_3092))
begin
Tpl_2747 <= 0;
end
else
if (Tpl_3423)
begin
Tpl_2747 <= Tpl_3098[9:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG13_T_MOD_PROC_2548
if ((!Tpl_3092))
begin
Tpl_2748 <= 6'h18;
end
else
if (Tpl_3423)
begin
Tpl_2748 <= Tpl_3098[15:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG14_T_DPD_PROC_2551
if ((!Tpl_3092))
begin
Tpl_2749 <= 0;
end
else
if (Tpl_3425)
begin
Tpl_2749 <= Tpl_3098[19:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG14_T_MRW_PROC_2554
if ((!Tpl_3092))
begin
Tpl_2750 <= 0;
end
else
if (Tpl_3425)
begin
Tpl_2750 <= Tpl_3098[24:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG14_T_WR2RD_PROC_2557
if ((!Tpl_3092))
begin
Tpl_2751 <= 0;
end
else
if (Tpl_3425)
begin
Tpl_2751 <= Tpl_3098[31:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG15_T_MRR_PROC_2560
if ((!Tpl_3092))
begin
Tpl_2752 <= 6'h08;
end
else
if (Tpl_3427)
begin
Tpl_2752 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG15_T_ZQRS_PROC_2563
if ((!Tpl_3092))
begin
Tpl_2753 <= 0;
end
else
if (Tpl_3427)
begin
Tpl_2753 <= Tpl_3098[13:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG15_T_DQSCKE_PROC_2566
if ((!Tpl_3092))
begin
Tpl_2754 <= 5'h08;
end
else
if (Tpl_3427)
begin
Tpl_2754 <= Tpl_3098[18:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG15_T_XSR_PROC_2569
if ((!Tpl_3092))
begin
Tpl_2755 <= 0;
end
else
if (Tpl_3427)
begin
Tpl_2755 <= Tpl_3098[28:19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG16_T_MPED_PROC_2572
if ((!Tpl_3092))
begin
Tpl_2756 <= 0;
end
else
if (Tpl_3429)
begin
Tpl_2756 <= Tpl_3098[5:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG16_T_MPX_PROC_2575
if ((!Tpl_3092))
begin
Tpl_2757 <= 0;
end
else
if (Tpl_3429)
begin
Tpl_2757 <= Tpl_3098[10:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG16_T_WR_MPR_PROC_2578
if ((!Tpl_3092))
begin
Tpl_2758 <= 0;
end
else
if (Tpl_3429)
begin
Tpl_2758 <= Tpl_3098[16:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG16_T_INIT5_PROC_2581
if ((!Tpl_3092))
begin
Tpl_2759 <= 0;
end
else
if (Tpl_3429)
begin
Tpl_2759 <= Tpl_3098[30:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG17_T_SETGEAR_PROC_2584
if ((!Tpl_3092))
begin
Tpl_2760 <= 3'h2;
end
else
if (Tpl_3431)
begin
Tpl_2760 <= Tpl_3098[2:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG17_T_SYNCGEAR_PROC_2587
if ((!Tpl_3092))
begin
Tpl_2761 <= 6'h18;
end
else
if (Tpl_3431)
begin
Tpl_2761 <= Tpl_3098[8:3];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG17_T_DLLLOCK_PROC_2590
if ((!Tpl_3092))
begin
Tpl_2762 <= 16'h04b0;
end
else
if (Tpl_3431)
begin
Tpl_2762 <= Tpl_3098[24:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG17_T_WLBTR_S_PROC_2593
if ((!Tpl_3092))
begin
Tpl_2763 <= 0;
end
else
if (Tpl_3431)
begin
Tpl_2763 <= Tpl_3098[31:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG18_T_READ_LOW_PROC_2596
if ((!Tpl_3092))
begin
Tpl_2764 <= 10'd512;
end
else
if (Tpl_3433)
begin
Tpl_2764 <= Tpl_3098[9:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG18_T_READ_HIGH_PROC_2599
if ((!Tpl_3092))
begin
Tpl_2765 <= 10'd64;
end
else
if (Tpl_3433)
begin
Tpl_2765 <= Tpl_3098[19:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG19_T_WRITE_LOW_PROC_2602
if ((!Tpl_3092))
begin
Tpl_2766 <= 10'd1023;
end
else
if (Tpl_3435)
begin
Tpl_2766 <= Tpl_3098[9:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG19_T_WRITE_HIGH_PROC_2605
if ((!Tpl_3092))
begin
Tpl_2767 <= 10'd128;
end
else
if (Tpl_3435)
begin
Tpl_2767 <= Tpl_3098[19:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG20_T_RFC2_PROC_2608
if ((!Tpl_3092))
begin
Tpl_2768 <= 0;
end
else
if (Tpl_3437)
begin
Tpl_2768 <= Tpl_3098[9:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG20_T_RFC4_PROC_2611
if ((!Tpl_3092))
begin
Tpl_2769 <= 0;
end
else
if (Tpl_3437)
begin
Tpl_2769 <= Tpl_3098[19:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG21_T_WLBR_CRCDM_PROC_2614
if ((!Tpl_3092))
begin
Tpl_2770 <= 0;
end
else
if (Tpl_3439)
begin
Tpl_2770 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG21_T_WLBTR_CRCDM_L_PROC_2617
if ((!Tpl_3092))
begin
Tpl_2771 <= 0;
end
else
if (Tpl_3439)
begin
Tpl_2771 <= Tpl_3098[13:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG21_T_WLBTR_CRCDM_S_PROC_2620
if ((!Tpl_3092))
begin
Tpl_2772 <= 0;
end
else
if (Tpl_3439)
begin
Tpl_2772 <= Tpl_3098[20:14];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG21_T_XMPDLL_PROC_2623
if ((!Tpl_3092))
begin
Tpl_2773 <= 0;
end
else
if (Tpl_3439)
begin
Tpl_2773 <= Tpl_3098[31:21];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG22_T_WRMPR_PROC_2626
if ((!Tpl_3092))
begin
Tpl_2774 <= 8'h18;
end
else
if (Tpl_3441)
begin
Tpl_2774 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG22_T_LVLEXIT_PROC_2629
if ((!Tpl_3092))
begin
Tpl_2775 <= 8'h10;
end
else
if (Tpl_3441)
begin
Tpl_2775 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG22_T_LVLDIS_PROC_2632
if ((!Tpl_3092))
begin
Tpl_2776 <= 8'h10;
end
else
if (Tpl_3441)
begin
Tpl_2776 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG23_T_ZQOPER_PROC_2635
if ((!Tpl_3092))
begin
Tpl_2777 <= 0;
end
else
if (Tpl_3443)
begin
Tpl_2777 <= Tpl_3098[11:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG23_T_RFC_PROC_2638
if ((!Tpl_3092))
begin
Tpl_2778 <= 0;
end
else
if (Tpl_3443)
begin
Tpl_2778 <= Tpl_3098[21:12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG24_T_XSDLL_PROC_2641
if ((!Tpl_3092))
begin
Tpl_2779 <= 0;
end
else
if (Tpl_3445)
begin
Tpl_2779 <= Tpl_3098[10:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG24_ODTLON_PROC_2644
if ((!Tpl_3092))
begin
Tpl_2780 <= 0;
end
else
if (Tpl_3445)
begin
Tpl_2780 <= Tpl_3098[15:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG25_ODTLOFF_PROC_2647
if ((!Tpl_3092))
begin
Tpl_2781 <= 0;
end
else
if (Tpl_3447)
begin
Tpl_2781 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG25_T_WLMRD_PROC_2650
if ((!Tpl_3092))
begin
Tpl_2782 <= 0;
end
else
if (Tpl_3447)
begin
Tpl_2782 <= Tpl_3098[10:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG25_T_WLDQSEN_PROC_2653
if ((!Tpl_3092))
begin
Tpl_2783 <= 0;
end
else
if (Tpl_3447)
begin
Tpl_2783 <= Tpl_3098[15:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG25_T_WTR_PROC_2656
if ((!Tpl_3092))
begin
Tpl_2784 <= 0;
end
else
if (Tpl_3447)
begin
Tpl_2784 <= Tpl_3098[19:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG26_T_RDA2PD_PROC_2659
if ((!Tpl_3092))
begin
Tpl_2785 <= 0;
end
else
if (Tpl_3449)
begin
Tpl_2785 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG26_T_WRA2PD_PROC_2662
if ((!Tpl_3092))
begin
Tpl_2786 <= 0;
end
else
if (Tpl_3449)
begin
Tpl_2786 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG26_T_ZQCL_PROC_2665
if ((!Tpl_3092))
begin
Tpl_2787 <= 0;
end
else
if (Tpl_3449)
begin
Tpl_2787 <= Tpl_3098[27:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG27_T_CALVL_ADR_CKEH_PROC_2668
if ((!Tpl_3092))
begin
Tpl_2788 <= 0;
end
else
if (Tpl_3451)
begin
Tpl_2788 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG27_T_CALVL_CAPTURE_PROC_2671
if ((!Tpl_3092))
begin
Tpl_2789 <= 0;
end
else
if (Tpl_3451)
begin
Tpl_2789 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG27_T_CALVL_CC_PROC_2674
if ((!Tpl_3092))
begin
Tpl_2790 <= 0;
end
else
if (Tpl_3451)
begin
Tpl_2790 <= Tpl_3098[23:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG27_T_CALVL_EN_PROC_2677
if ((!Tpl_3092))
begin
Tpl_2791 <= 0;
end
else
if (Tpl_3451)
begin
Tpl_2791 <= Tpl_3098[31:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG28_T_CALVL_EXT_PROC_2680
if ((!Tpl_3092))
begin
Tpl_2792 <= 0;
end
else
if (Tpl_3453)
begin
Tpl_2792 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG28_T_CALVL_MAX_PROC_2683
if ((!Tpl_3092))
begin
Tpl_2793 <= 0;
end
else
if (Tpl_3453)
begin
Tpl_2793 <= Tpl_3098[15:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG29_T_CKEHDQS_PROC_2686
if ((!Tpl_3092))
begin
Tpl_2794 <= 5'h08;
end
else
if (Tpl_3455)
begin
Tpl_2794 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG29_T_CCD_PROC_2689
if ((!Tpl_3092))
begin
Tpl_2795 <= 0;
end
else
if (Tpl_3455)
begin
Tpl_2795 <= Tpl_3098[9:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG29_T_ZQLAT_PROC_2692
if ((!Tpl_3092))
begin
Tpl_2796 <= 7'h08;
end
else
if (Tpl_3455)
begin
Tpl_2796 <= Tpl_3098[16:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG29_T_CKCKEH_PROC_2695
if ((!Tpl_3092))
begin
Tpl_2797 <= 2'h3;
end
else
if (Tpl_3455)
begin
Tpl_2797 <= Tpl_3098[18:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG30_T_RRD_PROC_2698
if ((!Tpl_3092))
begin
Tpl_2798 <= 0;
end
else
if (Tpl_3457)
begin
Tpl_2798 <= Tpl_3098[4:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG30_T_CAENT_PROC_2701
if ((!Tpl_3092))
begin
Tpl_2799 <= 10'h0c8;
end
else
if (Tpl_3457)
begin
Tpl_2799 <= Tpl_3098[14:5];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG30_T_CMDCKE_PROC_2704
if ((!Tpl_3092))
begin
Tpl_2800 <= 0;
end
else
if (Tpl_3457)
begin
Tpl_2800 <= Tpl_3098[18:15];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG30_T_MPCWR_PROC_2707
if ((!Tpl_3092))
begin
Tpl_2801 <= 0;
end
else
if (Tpl_3457)
begin
Tpl_2801 <= Tpl_3098[24:19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG30_T_DQRPT_PROC_2710
if ((!Tpl_3092))
begin
Tpl_2802 <= 6'h04;
end
else
if (Tpl_3457)
begin
Tpl_2802 <= Tpl_3098[30:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG31_T_ZQ_ITV_PROC_2713
if ((!Tpl_3092))
begin
Tpl_2803 <= 0;
end
else
if (Tpl_3459)
begin
Tpl_2803 <= Tpl_3098[27:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG31_T_CKELCK_PROC_2716
if ((!Tpl_3092))
begin
Tpl_2804 <= 5'h05;
end
else
if (Tpl_3459)
begin
Tpl_2804 <= Tpl_3098[31:28];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG32_T_DLLEN_PROC_2719
if ((!Tpl_3092))
begin
Tpl_2805 <= 8'h0a;
end
else
if (Tpl_3461)
begin
Tpl_2805 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG32_T_INIT3_PROC_2722
if ((!Tpl_3092))
begin
Tpl_2806 <= 0;
end
else
if (Tpl_3461)
begin
Tpl_2806 <= Tpl_3098[25:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG32_T_DTRAIN_PROC_2725
if ((!Tpl_3092))
begin
Tpl_2807 <= 3'h2;
end
else
if (Tpl_3461)
begin
Tpl_2807 <= Tpl_3098[28:26];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG33_T_MPCWR2RD_PROC_2728
if ((!Tpl_3092))
begin
Tpl_2808 <= 0;
end
else
if (Tpl_3463)
begin
Tpl_2808 <= Tpl_3098[6:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG33_T_FC_PROC_2731
if ((!Tpl_3092))
begin
Tpl_2809 <= 10'h0a0;
end
else
if (Tpl_3463)
begin
Tpl_2809 <= Tpl_3098[16:7];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG33_T_REFI_PROC_2734
if ((!Tpl_3092))
begin
Tpl_2810 <= 0;
end
else
if (Tpl_3463)
begin
Tpl_2810 <= Tpl_3098[30:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG34_T_VRCGEN_PROC_2737
if ((!Tpl_3092))
begin
Tpl_2811 <= 9'h0a0;
end
else
if (Tpl_3465)
begin
Tpl_2811 <= Tpl_3098[8:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG34_T_VRCGDIS_PROC_2740
if ((!Tpl_3092))
begin
Tpl_2812 <= 8'h50;
end
else
if (Tpl_3465)
begin
Tpl_2812 <= Tpl_3098[16:9];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG34_T_ODTUP_PROC_2743
if ((!Tpl_3092))
begin
Tpl_2813 <= 7'h20;
end
else
if (Tpl_3465)
begin
Tpl_2813 <= Tpl_3098[24:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG34_T_CCDWM_PROC_2746
if ((!Tpl_3092))
begin
Tpl_2814 <= 0;
end
else
if (Tpl_3465)
begin
Tpl_2814 <= Tpl_3098[30:25];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG35_T_OSCO_PROC_2749
if ((!Tpl_3092))
begin
Tpl_2815 <= 0;
end
else
if (Tpl_3467)
begin
Tpl_2815 <= Tpl_3098[7:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG35_T_CKFSPE_PROC_2752
if ((!Tpl_3092))
begin
Tpl_2816 <= 0;
end
else
if (Tpl_3467)
begin
Tpl_2816 <= Tpl_3098[11:8];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG35_T_CKFSPX_PROC_2755
if ((!Tpl_3092))
begin
Tpl_2817 <= 0;
end
else
if (Tpl_3467)
begin
Tpl_2817 <= Tpl_3098[15:12];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG35_T_INIT1_PROC_2758
if ((!Tpl_3092))
begin
Tpl_2818 <= 14'h2b68;
end
else
if (Tpl_3467)
begin
Tpl_2818 <= Tpl_3098[29:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG36_T_ZQCAL_PROC_2761
if ((!Tpl_3092))
begin
Tpl_2819 <= 11'h640;
end
else
if (Tpl_3469)
begin
Tpl_2819 <= Tpl_3098[10:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG36_T_LVLRESP_NR_PROC_2764
if ((!Tpl_3092))
begin
Tpl_2820 <= 8'h32;
end
else
if (Tpl_3469)
begin
Tpl_2820 <= Tpl_3098[18:11];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: TREG36_T_PPD_PROC_2767
if ((!Tpl_3092))
begin
Tpl_2821 <= 0;
end
else
if (Tpl_3469)
begin
Tpl_2821 <= Tpl_3098[22:19];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_START_RANK_PROC_2770
if ((!Tpl_3092))
begin
Tpl_2822 <= 0;
end
else
if (Tpl_3471)
begin
Tpl_2822 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_END_RANK_PROC_2773
if ((!Tpl_3092))
begin
Tpl_2823 <= 0;
end
else
if (Tpl_3471)
begin
Tpl_2823 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_START_BANK_PROC_2776
if ((!Tpl_3092))
begin
Tpl_2824 <= 0;
end
else
if (Tpl_3471)
begin
Tpl_2824 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_END_BANK_PROC_2779
if ((!Tpl_3092))
begin
Tpl_2825 <= 2'b11;
end
else
if (Tpl_3471)
begin
Tpl_2825 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_START_BACKGROUND_PROC_2782
if ((!Tpl_3092))
begin
Tpl_2826 <= 0;
end
else
if (Tpl_3471)
begin
Tpl_2826 <= Tpl_3098[12:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_END_BACKGROUND_PROC_2785
if ((!Tpl_3092))
begin
Tpl_2827 <= 3'b011;
end
else
if (Tpl_3471)
begin
Tpl_2827 <= Tpl_3098[15:13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_ELEMENT_PROC_2788
if ((!Tpl_3092))
begin
Tpl_2828 <= 4'b0100;
end
else
if (Tpl_3471)
begin
Tpl_2828 <= Tpl_3098[19:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_OPERATION_PROC_2791
if ((!Tpl_3092))
begin
Tpl_2829 <= 4'b0001;
end
else
if (Tpl_3471)
begin
Tpl_2829 <= Tpl_3098[23:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_RETENTION_PROC_2794
if ((!Tpl_3092))
begin
Tpl_2830 <= 4'b0001;
end
else
if (Tpl_3471)
begin
Tpl_2830 <= Tpl_3098[27:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH0_DIAGNOSIS_EN_PROC_2797
if ((!Tpl_3092))
begin
Tpl_2831 <= 1'b0;
end
else
if (Tpl_3471)
begin
Tpl_2831 <= Tpl_3098[28];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_START_RANK_PROC_2800
if ((!Tpl_3092))
begin
Tpl_2832 <= 0;
end
else
if (Tpl_3473)
begin
Tpl_2832 <= Tpl_3098[0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_END_RANK_PROC_2803
if ((!Tpl_3092))
begin
Tpl_2833 <= 0;
end
else
if (Tpl_3473)
begin
Tpl_2833 <= Tpl_3098[1];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_START_BANK_PROC_2806
if ((!Tpl_3092))
begin
Tpl_2834 <= 0;
end
else
if (Tpl_3473)
begin
Tpl_2834 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_END_BANK_PROC_2809
if ((!Tpl_3092))
begin
Tpl_2835 <= 2'b11;
end
else
if (Tpl_3473)
begin
Tpl_2835 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_START_BACKGROUND_PROC_2812
if ((!Tpl_3092))
begin
Tpl_2836 <= 0;
end
else
if (Tpl_3473)
begin
Tpl_2836 <= Tpl_3098[12:10];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_END_BACKGROUND_PROC_2815
if ((!Tpl_3092))
begin
Tpl_2837 <= 3'b011;
end
else
if (Tpl_3473)
begin
Tpl_2837 <= Tpl_3098[15:13];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_ELEMENT_PROC_2818
if ((!Tpl_3092))
begin
Tpl_2838 <= 4'b0100;
end
else
if (Tpl_3473)
begin
Tpl_2838 <= Tpl_3098[19:16];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_OPERATION_PROC_2821
if ((!Tpl_3092))
begin
Tpl_2839 <= 4'b0001;
end
else
if (Tpl_3473)
begin
Tpl_2839 <= Tpl_3098[23:20];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_RETENTION_PROC_2824
if ((!Tpl_3092))
begin
Tpl_2840 <= 4'b0001;
end
else
if (Tpl_3473)
begin
Tpl_2840 <= Tpl_3098[27:24];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTCFG_CH1_DIAGNOSIS_EN_PROC_2827
if ((!Tpl_3092))
begin
Tpl_2841 <= 1'b0;
end
else
if (Tpl_3473)
begin
Tpl_2841 <= Tpl_3098[28];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTSTADDR_CH0_START_ROW_PROC_2830
if ((!Tpl_3092))
begin
Tpl_2842 <= 0;
end
else
if (Tpl_3475)
begin
Tpl_2842 <= Tpl_3098[16:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTSTADDR_CH0_START_COL_PROC_2833
if ((!Tpl_3092))
begin
Tpl_2843 <= 0;
end
else
if (Tpl_3475)
begin
Tpl_2843 <= Tpl_3098[27:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTSTADDR_CH1_START_ROW_PROC_2836
if ((!Tpl_3092))
begin
Tpl_2844 <= 0;
end
else
if (Tpl_3477)
begin
Tpl_2844 <= Tpl_3098[16:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTSTADDR_CH1_START_COL_PROC_2839
if ((!Tpl_3092))
begin
Tpl_2845 <= 0;
end
else
if (Tpl_3477)
begin
Tpl_2845 <= Tpl_3098[27:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTEDADDR_CH0_END_ROW_PROC_2842
if ((!Tpl_3092))
begin
Tpl_2846 <= 18'd3;
end
else
if (Tpl_3479)
begin
Tpl_2846 <= Tpl_3098[16:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTEDADDR_CH0_END_COL_PROC_2845
if ((!Tpl_3092))
begin
Tpl_2847 <= 12'd32;
end
else
if (Tpl_3479)
begin
Tpl_2847 <= Tpl_3098[27:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTEDADDR_CH1_END_ROW_PROC_2848
if ((!Tpl_3092))
begin
Tpl_2848 <= 18'd3;
end
else
if (Tpl_3481)
begin
Tpl_2848 <= Tpl_3098[16:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTEDADDR_CH1_END_COL_PROC_2851
if ((!Tpl_3092))
begin
Tpl_2849 <= 12'd32;
end
else
if (Tpl_3481)
begin
Tpl_2849 <= Tpl_3098[27:17];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM0_CH0_MARCH_ELEMENT_0_PROC_2854
if ((!Tpl_3092))
begin
Tpl_2850 <= 32'b10010010000000000000000000000000;
end
else
if (Tpl_3483)
begin
Tpl_2850 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM0_CH1_MARCH_ELEMENT_0_PROC_2857
if ((!Tpl_3092))
begin
Tpl_2851 <= 32'b10010010000000000000000000000000;
end
else
if (Tpl_3485)
begin
Tpl_2851 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM1_CH0_MARCH_ELEMENT_1_PROC_2860
if ((!Tpl_3092))
begin
Tpl_2852 <= 32'b10100000000000000000000000000000;
end
else
if (Tpl_3487)
begin
Tpl_2852 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM1_CH1_MARCH_ELEMENT_1_PROC_2863
if ((!Tpl_3092))
begin
Tpl_2853 <= 32'b10100000000000000000000000000000;
end
else
if (Tpl_3489)
begin
Tpl_2853 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM2_CH0_MARCH_ELEMENT_2_PROC_2866
if ((!Tpl_3092))
begin
Tpl_2854 <= 32'b11001010100000000000000000000000;
end
else
if (Tpl_3491)
begin
Tpl_2854 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM2_CH1_MARCH_ELEMENT_2_PROC_2869
if ((!Tpl_3092))
begin
Tpl_2855 <= 32'b11001010100000000000000000000000;
end
else
if (Tpl_3493)
begin
Tpl_2855 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM3_CH0_MARCH_ELEMENT_3_PROC_2872
if ((!Tpl_3092))
begin
Tpl_2856 <= 32'b00100000000000000000000000000000;
end
else
if (Tpl_3495)
begin
Tpl_2856 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM3_CH1_MARCH_ELEMENT_3_PROC_2875
if ((!Tpl_3092))
begin
Tpl_2857 <= 32'b00100000000000000000000000000000;
end
else
if (Tpl_3497)
begin
Tpl_2857 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM4_CH0_MARCH_ELEMENT_4_PROC_2878
if ((!Tpl_3092))
begin
Tpl_2858 <= 32'b01001110000000000000000000000000;
end
else
if (Tpl_3499)
begin
Tpl_2858 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM4_CH1_MARCH_ELEMENT_4_PROC_2881
if ((!Tpl_3092))
begin
Tpl_2859 <= 32'b01001110000000000000000000000000;
end
else
if (Tpl_3501)
begin
Tpl_2859 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM5_CH0_MARCH_ELEMENT_5_PROC_2884
if ((!Tpl_3092))
begin
Tpl_2860 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3503)
begin
Tpl_2860 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM5_CH1_MARCH_ELEMENT_5_PROC_2887
if ((!Tpl_3092))
begin
Tpl_2861 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3505)
begin
Tpl_2861 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM6_CH0_MARCH_ELEMENT_6_PROC_2890
if ((!Tpl_3092))
begin
Tpl_2862 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3507)
begin
Tpl_2862 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM6_CH1_MARCH_ELEMENT_6_PROC_2893
if ((!Tpl_3092))
begin
Tpl_2863 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3509)
begin
Tpl_2863 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM7_CH0_MARCH_ELEMENT_7_PROC_2896
if ((!Tpl_3092))
begin
Tpl_2864 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3511)
begin
Tpl_2864 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM7_CH1_MARCH_ELEMENT_7_PROC_2899
if ((!Tpl_3092))
begin
Tpl_2865 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3513)
begin
Tpl_2865 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM8_CH0_MARCH_ELEMENT_8_PROC_2902
if ((!Tpl_3092))
begin
Tpl_2866 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3515)
begin
Tpl_2866 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM8_CH1_MARCH_ELEMENT_8_PROC_2905
if ((!Tpl_3092))
begin
Tpl_2867 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3517)
begin
Tpl_2867 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM9_CH0_MARCH_ELEMENT_9_PROC_2908
if ((!Tpl_3092))
begin
Tpl_2868 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3519)
begin
Tpl_2868 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM9_CH1_MARCH_ELEMENT_9_PROC_2911
if ((!Tpl_3092))
begin
Tpl_2869 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3521)
begin
Tpl_2869 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM10_CH0_MARCH_ELEMENT_10_PROC_2914
if ((!Tpl_3092))
begin
Tpl_2870 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3523)
begin
Tpl_2870 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM10_CH1_MARCH_ELEMENT_10_PROC_2917
if ((!Tpl_3092))
begin
Tpl_2871 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3525)
begin
Tpl_2871 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM11_CH0_MARCH_ELEMENT_11_PROC_2920
if ((!Tpl_3092))
begin
Tpl_2872 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3527)
begin
Tpl_2872 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM11_CH1_MARCH_ELEMENT_11_PROC_2923
if ((!Tpl_3092))
begin
Tpl_2873 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3529)
begin
Tpl_2873 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM12_CH0_MARCH_ELEMENT_12_PROC_2926
if ((!Tpl_3092))
begin
Tpl_2874 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3531)
begin
Tpl_2874 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM12_CH1_MARCH_ELEMENT_12_PROC_2929
if ((!Tpl_3092))
begin
Tpl_2875 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3533)
begin
Tpl_2875 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM13_CH0_MARCH_ELEMENT_13_PROC_2932
if ((!Tpl_3092))
begin
Tpl_2876 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3535)
begin
Tpl_2876 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM13_CH1_MARCH_ELEMENT_13_PROC_2935
if ((!Tpl_3092))
begin
Tpl_2877 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3537)
begin
Tpl_2877 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM14_CH0_MARCH_ELEMENT_14_PROC_2938
if ((!Tpl_3092))
begin
Tpl_2878 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3539)
begin
Tpl_2878 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM14_CH1_MARCH_ELEMENT_14_PROC_2941
if ((!Tpl_3092))
begin
Tpl_2879 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3541)
begin
Tpl_2879 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM15_CH0_MARCH_ELEMENT_15_PROC_2944
if ((!Tpl_3092))
begin
Tpl_2880 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3543)
begin
Tpl_2880 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: BISTM15_CH1_MARCH_ELEMENT_15_PROC_2947
if ((!Tpl_3092))
begin
Tpl_2881 <= 32'b00000000000000000000000000000000;
end
else
if (Tpl_3545)
begin
Tpl_2881 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADFT_TST_EN_CA_PROC_2950
if ((!Tpl_3092))
begin
Tpl_2882 <= 0;
end
else
if (Tpl_3547)
begin
Tpl_2882 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: ADFT_TST_EN_DQ_PROC_2953
if ((!Tpl_3092))
begin
Tpl_2883 <= 0;
end
else
if (Tpl_3547)
begin
Tpl_2883 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTBYPEN0_CLK_PROC_2956
if ((!Tpl_3092))
begin
Tpl_2884 <= 0;
end
else
if (Tpl_3549)
begin
Tpl_2884 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTBYPEN0_DM_PROC_2959
if ((!Tpl_3092))
begin
Tpl_2885 <= 0;
end
else
if (Tpl_3549)
begin
Tpl_2885 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTBYPEN0_DQS_PROC_2962
if ((!Tpl_3092))
begin
Tpl_2886 <= 0;
end
else
if (Tpl_3549)
begin
Tpl_2886 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTBYPEN1_DQ_PROC_2965
if ((!Tpl_3092))
begin
Tpl_2887 <= 0;
end
else
if (Tpl_3551)
begin
Tpl_2887 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTBYPEN2_CTL_PROC_2968
if ((!Tpl_3092))
begin
Tpl_2888 <= 0;
end
else
if (Tpl_3553)
begin
Tpl_2888 <= Tpl_3098[29:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTD0_CLK_PROC_2971
if ((!Tpl_3092))
begin
Tpl_2889 <= 0;
end
else
if (Tpl_3555)
begin
Tpl_2889 <= Tpl_3098[1:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTD0_DM_PROC_2974
if ((!Tpl_3092))
begin
Tpl_2890 <= 0;
end
else
if (Tpl_3555)
begin
Tpl_2890 <= Tpl_3098[5:2];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTD0_DQS_PROC_2977
if ((!Tpl_3092))
begin
Tpl_2891 <= 0;
end
else
if (Tpl_3555)
begin
Tpl_2891 <= Tpl_3098[9:6];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTD1_DQ_PROC_2980
if ((!Tpl_3092))
begin
Tpl_2892 <= 0;
end
else
if (Tpl_3557)
begin
Tpl_2892 <= Tpl_3098[31:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OUTD2_CTL_PROC_2983
if ((!Tpl_3092))
begin
Tpl_2893 <= 0;
end
else
if (Tpl_3559)
begin
Tpl_2893 <= Tpl_3098[29:0];
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DVSTT0_DEVICE_ID_PROC_2986
if ((!Tpl_3092))
begin
Tpl_3612 <= 0;
end
else
begin
Tpl_3612 <= Tpl_2894;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DVSTT1_DRAM_BL_ENC_PROC_2989
if ((!Tpl_3092))
begin
Tpl_3613 <= 0;
end
else
begin
Tpl_3613 <= Tpl_2895;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DVSTT1_DFI_FREQ_RATIO_PROC_2992
if ((!Tpl_3092))
begin
Tpl_3614 <= 0;
end
else
begin
Tpl_3614 <= Tpl_2896;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH0_DRAM_PAUSE_PROC_2995
if ((!Tpl_3092))
begin
Tpl_3615 <= 1'b1;
end
else
begin
Tpl_3615 <= Tpl_2897;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH0_USER_CMD_READY_PROC_2998
if ((!Tpl_3092))
begin
Tpl_3616 <= 1'b1;
end
else
begin
Tpl_3616 <= Tpl_2898;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH0_BANK_IDLE_PROC_3001
if ((!Tpl_3092))
begin
Tpl_3617 <= 16'hffff;
end
else
begin
Tpl_3617 <= Tpl_2899;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH0_XQR_EMPTY_PROC_3004
if ((!Tpl_3092))
begin
Tpl_3618 <= 1'b1;
end
else
begin
Tpl_3618 <= Tpl_2900;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH0_XQR_FULL_PROC_3007
if ((!Tpl_3092))
begin
Tpl_3619 <= 0;
end
else
begin
Tpl_3619 <= Tpl_2901;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH0_XQW_EMPTY_PROC_3010
if ((!Tpl_3092))
begin
Tpl_3620 <= 1'b1;
end
else
begin
Tpl_3620 <= Tpl_2902;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH0_XQW_FULL_PROC_3013
if ((!Tpl_3092))
begin
Tpl_3621 <= 0;
end
else
begin
Tpl_3621 <= Tpl_2903;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH1_DRAM_PAUSE_PROC_3016
if ((!Tpl_3092))
begin
Tpl_3622 <= 1'b1;
end
else
begin
Tpl_3622 <= Tpl_2904;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH1_USER_CMD_READY_PROC_3019
if ((!Tpl_3092))
begin
Tpl_3623 <= 1'b1;
end
else
begin
Tpl_3623 <= Tpl_2905;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH1_BANK_IDLE_PROC_3022
if ((!Tpl_3092))
begin
Tpl_3624 <= 16'hffff;
end
else
begin
Tpl_3624 <= Tpl_2906;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH1_XQR_EMPTY_PROC_3025
if ((!Tpl_3092))
begin
Tpl_3625 <= 1'b1;
end
else
begin
Tpl_3625 <= Tpl_2907;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH1_XQR_FULL_PROC_3028
if ((!Tpl_3092))
begin
Tpl_3626 <= 0;
end
else
begin
Tpl_3626 <= Tpl_2908;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH1_XQW_EMPTY_PROC_3031
if ((!Tpl_3092))
begin
Tpl_3627 <= 1'b1;
end
else
begin
Tpl_3627 <= Tpl_2909;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: OPSTT_CH1_XQW_FULL_PROC_3034
if ((!Tpl_3092))
begin
Tpl_3628 <= 0;
end
else
begin
Tpl_3628 <= Tpl_2910;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: INTSTT_CH0_INT_GC_FSM_PROC_3037
if ((!Tpl_3092))
begin
Tpl_3629 <= 0;
end
else
if (Tpl_1753)
begin
if (Tpl_1754)
begin
Tpl_3629 <= '0;
end
else
if (Tpl_2911)
begin
Tpl_3629 <= 1'b1;
end
end
else
begin
Tpl_3629 <= '0;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: INTSTT_CH1_INT_GC_FSM_PROC_3043
if ((!Tpl_3092))
begin
Tpl_3630 <= 0;
end
else
if (Tpl_1753)
begin
if (Tpl_1754)
begin
Tpl_3630 <= '0;
end
else
if (Tpl_2912)
begin
Tpl_3630 <= 1'b1;
end
end
else
begin
Tpl_3630 <= '0;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH0_ERROR_PROC_3049
if ((!Tpl_3092))
begin
Tpl_3631 <= 0;
end
else
begin
Tpl_3631 <= Tpl_2913;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH0_ENDTEST_PROC_3052
if ((!Tpl_3092))
begin
Tpl_3632 <= 0;
end
else
begin
Tpl_3632 <= Tpl_2914;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH0_ERROR_NEW_PROC_3055
if ((!Tpl_3092))
begin
Tpl_3633 <= 0;
end
else
begin
Tpl_3633 <= Tpl_2915;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH0_RANK_FAIL_PROC_3058
if ((!Tpl_3092))
begin
Tpl_3634 <= 0;
end
else
if ((Tpl_2913 & (~Tpl_2914)))
begin
Tpl_3634 <= Tpl_2916;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH0_BANK_FAIL_PROC_3061
if ((!Tpl_3092))
begin
Tpl_3635 <= 0;
end
else
if ((Tpl_2913 & (~Tpl_2914)))
begin
Tpl_3635 <= Tpl_2917;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH0_ROW_FAIL_PROC_3064
if ((!Tpl_3092))
begin
Tpl_3636 <= 0;
end
else
if ((Tpl_2913 & (~Tpl_2914)))
begin
Tpl_3636 <= Tpl_2918;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH1_ERROR_PROC_3067
if ((!Tpl_3092))
begin
Tpl_3637 <= 0;
end
else
begin
Tpl_3637 <= Tpl_2919;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH1_ENDTEST_PROC_3070
if ((!Tpl_3092))
begin
Tpl_3638 <= 0;
end
else
begin
Tpl_3638 <= Tpl_2920;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH1_ERROR_NEW_PROC_3073
if ((!Tpl_3092))
begin
Tpl_3639 <= 0;
end
else
begin
Tpl_3639 <= Tpl_2921;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH1_RANK_FAIL_PROC_3076
if ((!Tpl_3092))
begin
Tpl_3640 <= 0;
end
else
if ((Tpl_2919 & (~Tpl_2920)))
begin
Tpl_3640 <= Tpl_2922;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH1_BANK_FAIL_PROC_3079
if ((!Tpl_3092))
begin
Tpl_3641 <= 0;
end
else
if ((Tpl_2919 & (~Tpl_2920)))
begin
Tpl_3641 <= Tpl_2923;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DDRBISTSTT_CH1_ROW_FAIL_PROC_3082
if ((!Tpl_3092))
begin
Tpl_3642 <= 0;
end
else
if ((Tpl_2919 & (~Tpl_2920)))
begin
Tpl_3642 <= Tpl_2924;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_PHYSETC_PROC_3085
if ((!Tpl_3092))
begin
Tpl_3643 <= 0;
end
else
begin
Tpl_3643 <= Tpl_2925;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_PHYFSC_PROC_3088
if ((!Tpl_3092))
begin
Tpl_3644 <= 0;
end
else
begin
Tpl_3644 <= Tpl_2926;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_PHYINITC_PROC_3091
if ((!Tpl_3092))
begin
Tpl_3645 <= 0;
end
else
begin
Tpl_3645 <= Tpl_2927;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_DLLRSTC_PROC_3094
if ((!Tpl_3092))
begin
Tpl_3646 <= 0;
end
else
begin
Tpl_3646 <= Tpl_2928;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_DRAMINITC_PROC_3097
if ((!Tpl_3092))
begin
Tpl_3647 <= 0;
end
else
begin
Tpl_3647 <= Tpl_2929;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_VREFDQRDC_PROC_3100
if ((!Tpl_3092))
begin
Tpl_3648 <= 0;
end
else
begin
Tpl_3648 <= Tpl_2930;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_VREFCAC_PROC_3103
if ((!Tpl_3092))
begin
Tpl_3649 <= 0;
end
else
begin
Tpl_3649 <= Tpl_2931;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_GTC_PROC_3106
if ((!Tpl_3092))
begin
Tpl_3650 <= 0;
end
else
begin
Tpl_3650 <= Tpl_2932;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_WRLVLC_PROC_3109
if ((!Tpl_3092))
begin
Tpl_3651 <= 0;
end
else
begin
Tpl_3651 <= Tpl_2933;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_RDLVLC_PROC_3112
if ((!Tpl_3092))
begin
Tpl_3652 <= 0;
end
else
begin
Tpl_3652 <= Tpl_2934;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_VREFDQWRC_PROC_3115
if ((!Tpl_3092))
begin
Tpl_3653 <= 0;
end
else
begin
Tpl_3653 <= Tpl_2935;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_DLYEVALC_PROC_3118
if ((!Tpl_3092))
begin
Tpl_3654 <= 0;
end
else
begin
Tpl_3654 <= Tpl_2936;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_SANCHKC_PROC_3121
if ((!Tpl_3092))
begin
Tpl_3655 <= 0;
end
else
begin
Tpl_3655 <= Tpl_2937;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_OFS_PROC_3124
if ((!Tpl_3092))
begin
Tpl_3656 <= 0;
end
else
begin
Tpl_3656 <= Tpl_2938;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_FS0REQ_PROC_3127
if ((!Tpl_3092))
begin
Tpl_3657 <= 0;
end
else
begin
Tpl_3657 <= Tpl_2939;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_FS1REQ_PROC_3130
if ((!Tpl_3092))
begin
Tpl_3658 <= 0;
end
else
begin
Tpl_3658 <= Tpl_2940;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_CLKLOCKC_PROC_3133
if ((!Tpl_3092))
begin
Tpl_3659 <= 0;
end
else
begin
Tpl_3659 <= Tpl_2941;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_CMDDLYC_PROC_3136
if ((!Tpl_3092))
begin
Tpl_3660 <= 0;
end
else
begin
Tpl_3660 <= Tpl_2942;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: POS_DQSDQC_PROC_3139
if ((!Tpl_3092))
begin
Tpl_3661 <= 0;
end
else
begin
Tpl_3661 <= Tpl_2943;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_R0_VREFDQRDERR_PROC_3142
if ((!Tpl_3092))
begin
Tpl_3662 <= 0;
end
else
begin
Tpl_3662 <= Tpl_2944;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_R0_VREFCAERR_PROC_3145
if ((!Tpl_3092))
begin
Tpl_3663 <= 0;
end
else
begin
Tpl_3663 <= Tpl_2945;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_R0_GTERR_PROC_3148
if ((!Tpl_3092))
begin
Tpl_3664 <= 0;
end
else
begin
Tpl_3664 <= Tpl_2946;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_R0_WRLVLERR_PROC_3151
if ((!Tpl_3092))
begin
Tpl_3665 <= 0;
end
else
begin
Tpl_3665 <= Tpl_2947;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_R0_VREFDQWRERR_PROC_3154
if ((!Tpl_3092))
begin
Tpl_3666 <= 0;
end
else
begin
Tpl_3666 <= Tpl_2948;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_R0_RDLVLDMERR_PROC_3157
if ((!Tpl_3092))
begin
Tpl_3667 <= 0;
end
else
begin
Tpl_3667 <= Tpl_2949;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_DLLERR_PROC_3160
if ((!Tpl_3092))
begin
Tpl_3668 <= 0;
end
else
begin
Tpl_3668 <= Tpl_2950;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS0_LP3CALVLERR_PROC_3163
if ((!Tpl_3092))
begin
Tpl_3669 <= 0;
end
else
begin
Tpl_3669 <= Tpl_2951;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS1_R0_SANCHKERR_PROC_3166
if ((!Tpl_3092))
begin
Tpl_3670 <= 0;
end
else
begin
Tpl_3670 <= Tpl_2952;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS1_R0_DQSDMERR_PROC_3169
if ((!Tpl_3092))
begin
Tpl_3671 <= 0;
end
else
begin
Tpl_3671 <= Tpl_2953;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS1_R1_SANCHKERR_PROC_3172
if ((!Tpl_3092))
begin
Tpl_3672 <= 0;
end
else
begin
Tpl_3672 <= Tpl_2954;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS1_R1_DQSDMERR_PROC_3175
if ((!Tpl_3092))
begin
Tpl_3673 <= 0;
end
else
begin
Tpl_3673 <= Tpl_2955;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS2_R0_RDLVLDQERR_PROC_3178
if ((!Tpl_3092))
begin
Tpl_3674 <= 0;
end
else
begin
Tpl_3674 <= Tpl_2956;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS3_R0_DQSDQERR_PROC_3181
if ((!Tpl_3092))
begin
Tpl_3675 <= 0;
end
else
begin
Tpl_3675 <= Tpl_2957;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS4_R1_VREFDQRDERR_PROC_3184
if ((!Tpl_3092))
begin
Tpl_3676 <= 0;
end
else
begin
Tpl_3676 <= Tpl_2958;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS4_R1_VREFCAERR_PROC_3187
if ((!Tpl_3092))
begin
Tpl_3677 <= 0;
end
else
begin
Tpl_3677 <= Tpl_2959;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS4_R1_GTERR_PROC_3190
if ((!Tpl_3092))
begin
Tpl_3678 <= 0;
end
else
begin
Tpl_3678 <= Tpl_2960;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS4_R1_WRLVLERR_PROC_3193
if ((!Tpl_3092))
begin
Tpl_3679 <= 0;
end
else
begin
Tpl_3679 <= Tpl_2961;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS4_R1_VREFDQWRERR_PROC_3196
if ((!Tpl_3092))
begin
Tpl_3680 <= 0;
end
else
begin
Tpl_3680 <= Tpl_2962;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS4_R1_RDLVLDMERR_PROC_3199
if ((!Tpl_3092))
begin
Tpl_3681 <= 0;
end
else
begin
Tpl_3681 <= Tpl_2963;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS5_R1_RDLVLDQERR_PROC_3202
if ((!Tpl_3092))
begin
Tpl_3682 <= 0;
end
else
begin
Tpl_3682 <= Tpl_2964;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PTS6_R1_DQSDQERR_PROC_3205
if ((!Tpl_3092))
begin
Tpl_3683 <= 0;
end
else
begin
Tpl_3683 <= Tpl_2965;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLSTTCA_LOCK_PROC_3208
if ((!Tpl_3092))
begin
Tpl_3684 <= 0;
end
else
begin
Tpl_3684 <= Tpl_2966;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLSTTCA_OVFL_PROC_3211
if ((!Tpl_3092))
begin
Tpl_3685 <= 0;
end
else
begin
Tpl_3685 <= Tpl_2967;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLSTTCA_UNFL_PROC_3214
if ((!Tpl_3092))
begin
Tpl_3686 <= 0;
end
else
begin
Tpl_3686 <= Tpl_2968;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLSTTDQ_LOCK_PROC_3217
if ((!Tpl_3092))
begin
Tpl_3687 <= 0;
end
else
begin
Tpl_3687 <= Tpl_2969;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLSTTDQ_OVFL_PROC_3220
if ((!Tpl_3092))
begin
Tpl_3688 <= 0;
end
else
begin
Tpl_3688 <= Tpl_2970;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DLLSTTDQ_UNFL_PROC_3223
if ((!Tpl_3092))
begin
Tpl_3689 <= 0;
end
else
begin
Tpl_3689 <= Tpl_2971;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBSR_BIST_DONE_PROC_3226
if ((!Tpl_3092))
begin
Tpl_3690 <= 0;
end
else
begin
Tpl_3690 <= Tpl_2972;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBSR_BIST_ERR_CTL_PROC_3229
if ((!Tpl_3092))
begin
Tpl_3691 <= 0;
end
else
begin
Tpl_3691 <= Tpl_2973;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBSR1_BIST_ERR_DQ_PROC_3232
if ((!Tpl_3092))
begin
Tpl_3692 <= 0;
end
else
begin
Tpl_3692 <= Tpl_2974;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PBSR2_BIST_ERR_DM_PROC_3235
if ((!Tpl_3092))
begin
Tpl_3693 <= 0;
end
else
begin
Tpl_3693 <= Tpl_2975;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCSR_SRSTC_PROC_3238
if ((!Tpl_3092))
begin
Tpl_3694 <= 0;
end
else
begin
Tpl_3694 <= Tpl_2976;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCSR_UPDC_PROC_3241
if ((!Tpl_3092))
begin
Tpl_3695 <= 0;
end
else
begin
Tpl_3695 <= Tpl_2977;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCSR_NBC_PROC_3244
if ((!Tpl_3092))
begin
Tpl_3696 <= 0;
end
else
begin
Tpl_3696 <= Tpl_2978;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: PCSR_PBC_PROC_3247
if ((!Tpl_3092))
begin
Tpl_3697 <= 0;
end
else
begin
Tpl_3697 <= Tpl_2979;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: MPR_DONE_PROC_3250
if ((!Tpl_3092))
begin
Tpl_3698 <= 0;
end
else
if (Tpl_2980)
begin
Tpl_3698 <= 1'b1;
end
else
if ((Tpl_3107 & Tpl_3108))
begin
Tpl_3698 <= 1'b0;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: MPR_READOUT_PROC_3254
if ((!Tpl_3092))
begin
Tpl_3699 <= 0;
end
else
if (Tpl_2980)
begin
Tpl_3699 <= Tpl_2981;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: MRR_CH0_DONE_PROC_3257
if ((!Tpl_3092))
begin
Tpl_3700 <= 0;
end
else
if (Tpl_3109[0])
begin
Tpl_3700 <= 1'b0;
end
else
if (Tpl_2982)
begin
Tpl_3700 <= 1'b1;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: MRR_CH0_READOUT_PROC_3261
if ((!Tpl_3092))
begin
Tpl_3701 <= 0;
end
else
if (Tpl_2982)
begin
Tpl_3701 <= Tpl_2983;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: MRR_CH1_DONE_PROC_3264
if ((!Tpl_3092))
begin
Tpl_3702 <= 0;
end
else
if (Tpl_3109[1])
begin
Tpl_3702 <= 1'b0;
end
else
if (Tpl_2984)
begin
Tpl_3702 <= 1'b1;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: MRR_CH1_READOUT_PROC_3268
if ((!Tpl_3092))
begin
Tpl_3703 <= 0;
end
else
if (Tpl_2984)
begin
Tpl_3703 <= Tpl_2985;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS0_BL_PROC_3271
if ((!Tpl_3092))
begin
Tpl_3704 <= 0;
end
else
begin
Tpl_3704 <= Tpl_2986;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS0_WPRE_PROC_3274
if ((!Tpl_3092))
begin
Tpl_3705 <= 0;
end
else
begin
Tpl_3705 <= Tpl_2987;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS0_RPRE_PROC_3277
if ((!Tpl_3092))
begin
Tpl_3706 <= 0;
end
else
begin
Tpl_3706 <= Tpl_2988;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS0_NWR_PROC_3280
if ((!Tpl_3092))
begin
Tpl_3707 <= 0;
end
else
begin
Tpl_3707 <= Tpl_2989;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS0_RPST_PROC_3283
if ((!Tpl_3092))
begin
Tpl_3708 <= 0;
end
else
begin
Tpl_3708 <= Tpl_2990;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS1_BL_PROC_3286
if ((!Tpl_3092))
begin
Tpl_3709 <= 0;
end
else
begin
Tpl_3709 <= Tpl_2991;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS1_WPRE_PROC_3289
if ((!Tpl_3092))
begin
Tpl_3710 <= 0;
end
else
begin
Tpl_3710 <= Tpl_2992;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS1_RPRE_PROC_3292
if ((!Tpl_3092))
begin
Tpl_3711 <= 0;
end
else
begin
Tpl_3711 <= Tpl_2993;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS1_NWR_PROC_3295
if ((!Tpl_3092))
begin
Tpl_3712 <= 0;
end
else
begin
Tpl_3712 <= Tpl_2994;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR1_FS1_RPST_PROC_3298
if ((!Tpl_3092))
begin
Tpl_3713 <= 0;
end
else
begin
Tpl_3713 <= Tpl_2995;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_FS0_RL_PROC_3301
if ((!Tpl_3092))
begin
Tpl_3714 <= 0;
end
else
begin
Tpl_3714 <= Tpl_2996;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_FS0_WL_PROC_3304
if ((!Tpl_3092))
begin
Tpl_3715 <= 0;
end
else
begin
Tpl_3715 <= Tpl_2997;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_FS0_WLS_PROC_3307
if ((!Tpl_3092))
begin
Tpl_3716 <= 0;
end
else
begin
Tpl_3716 <= Tpl_2998;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_WRLEV_PROC_3310
if ((!Tpl_3092))
begin
Tpl_3717 <= 0;
end
else
begin
Tpl_3717 <= Tpl_2999;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_FS1_RL_PROC_3313
if ((!Tpl_3092))
begin
Tpl_3718 <= 0;
end
else
begin
Tpl_3718 <= Tpl_3000;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_FS1_WL_PROC_3316
if ((!Tpl_3092))
begin
Tpl_3719 <= 0;
end
else
begin
Tpl_3719 <= Tpl_3001;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_FS1_WLS_PROC_3319
if ((!Tpl_3092))
begin
Tpl_3720 <= 0;
end
else
begin
Tpl_3720 <= Tpl_3002;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR2_RESERVED_PROC_3322
if ((!Tpl_3092))
begin
Tpl_3721 <= 0;
end
else
begin
Tpl_3721 <= Tpl_3003;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS0_PUCAL_PROC_3325
if ((!Tpl_3092))
begin
Tpl_3722 <= 1'b1;
end
else
begin
Tpl_3722 <= Tpl_3004;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS0_WPST_PROC_3328
if ((!Tpl_3092))
begin
Tpl_3723 <= 0;
end
else
begin
Tpl_3723 <= Tpl_3005;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_PPRP_PROC_3331
if ((!Tpl_3092))
begin
Tpl_3724 <= 0;
end
else
begin
Tpl_3724 <= Tpl_3006;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS0_PDDS_PROC_3334
if ((!Tpl_3092))
begin
Tpl_3725 <= 3'h6;
end
else
begin
Tpl_3725 <= Tpl_3007;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS0_RDBI_PROC_3337
if ((!Tpl_3092))
begin
Tpl_3726 <= 0;
end
else
begin
Tpl_3726 <= Tpl_3008;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS0_WDBI_PROC_3340
if ((!Tpl_3092))
begin
Tpl_3727 <= 0;
end
else
begin
Tpl_3727 <= Tpl_3009;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS1_PUCAL_PROC_3343
if ((!Tpl_3092))
begin
Tpl_3728 <= 1'b1;
end
else
begin
Tpl_3728 <= Tpl_3010;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS1_WPST_PROC_3346
if ((!Tpl_3092))
begin
Tpl_3729 <= 0;
end
else
begin
Tpl_3729 <= Tpl_3011;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_RESERVED_PROC_3349
if ((!Tpl_3092))
begin
Tpl_3730 <= 0;
end
else
begin
Tpl_3730 <= Tpl_3012;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS1_PDDS_PROC_3352
if ((!Tpl_3092))
begin
Tpl_3731 <= 3'h6;
end
else
begin
Tpl_3731 <= Tpl_3013;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS1_RDBI_PROC_3355
if ((!Tpl_3092))
begin
Tpl_3732 <= 0;
end
else
begin
Tpl_3732 <= Tpl_3014;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR3_FS1_WDBI_PROC_3358
if ((!Tpl_3092))
begin
Tpl_3733 <= 0;
end
else
begin
Tpl_3733 <= Tpl_3015;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_FS0_DQODT_PROC_3361
if ((!Tpl_3092))
begin
Tpl_3734 <= 0;
end
else
begin
Tpl_3734 <= Tpl_3016;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_RESERVED0_PROC_3364
if ((!Tpl_3092))
begin
Tpl_3735 <= 0;
end
else
begin
Tpl_3735 <= Tpl_3017;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_FS0_CAODT_PROC_3367
if ((!Tpl_3092))
begin
Tpl_3736 <= 0;
end
else
begin
Tpl_3736 <= Tpl_3018;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_RESERVED1_PROC_3370
if ((!Tpl_3092))
begin
Tpl_3737 <= 0;
end
else
begin
Tpl_3737 <= Tpl_3019;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_FS1_DQODT_PROC_3373
if ((!Tpl_3092))
begin
Tpl_3738 <= 0;
end
else
begin
Tpl_3738 <= Tpl_3020;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_RESERVED2_PROC_3376
if ((!Tpl_3092))
begin
Tpl_3739 <= 0;
end
else
begin
Tpl_3739 <= Tpl_3021;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_FS1_CAODT_PROC_3379
if ((!Tpl_3092))
begin
Tpl_3740 <= 0;
end
else
begin
Tpl_3740 <= Tpl_3022;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_RESERVED3_PROC_3382
if ((!Tpl_3092))
begin
Tpl_3741 <= 0;
end
else
begin
Tpl_3741 <= Tpl_3023;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_FS0_DQODT_PROC_3385
if ((!Tpl_3092))
begin
Tpl_3742 <= 0;
end
else
begin
Tpl_3742 <= Tpl_3024;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_RESERVED0_PROC_3388
if ((!Tpl_3092))
begin
Tpl_3743 <= 0;
end
else
begin
Tpl_3743 <= Tpl_3025;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_FS0_CAODT_PROC_3391
if ((!Tpl_3092))
begin
Tpl_3744 <= 0;
end
else
begin
Tpl_3744 <= Tpl_3026;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_RESERVED1_PROC_3394
if ((!Tpl_3092))
begin
Tpl_3745 <= 0;
end
else
begin
Tpl_3745 <= Tpl_3027;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_FS1_DQODT_PROC_3397
if ((!Tpl_3092))
begin
Tpl_3746 <= 0;
end
else
begin
Tpl_3746 <= Tpl_3028;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_RESERVED2_PROC_3400
if ((!Tpl_3092))
begin
Tpl_3747 <= 0;
end
else
begin
Tpl_3747 <= Tpl_3029;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_FS1_CAODT_PROC_3403
if ((!Tpl_3092))
begin
Tpl_3748 <= 0;
end
else
begin
Tpl_3748 <= Tpl_3030;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR11_NT_RESERVED3_PROC_3406
if ((!Tpl_3092))
begin
Tpl_3749 <= 0;
end
else
begin
Tpl_3749 <= Tpl_3031;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR12_FS0_VREFCAS_PROC_3409
if ((!Tpl_3092))
begin
Tpl_3750 <= 6'h0d;
end
else
begin
Tpl_3750 <= Tpl_3032;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR12_FS0_VREFCAR_PROC_3412
if ((!Tpl_3092))
begin
Tpl_3751 <= 1'b1;
end
else
begin
Tpl_3751 <= Tpl_3033;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR12_RESERVED0_PROC_3415
if ((!Tpl_3092))
begin
Tpl_3752 <= 0;
end
else
begin
Tpl_3752 <= Tpl_3034;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR12_FS1_VREFCAS_PROC_3418
if ((!Tpl_3092))
begin
Tpl_3753 <= 6'h0d;
end
else
begin
Tpl_3753 <= Tpl_3035;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR12_FS1_VREFCAR_PROC_3421
if ((!Tpl_3092))
begin
Tpl_3754 <= 1'b1;
end
else
begin
Tpl_3754 <= Tpl_3036;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR12_RESERVED1_PROC_3424
if ((!Tpl_3092))
begin
Tpl_3755 <= 0;
end
else
begin
Tpl_3755 <= Tpl_3037;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_CBT_PROC_3427
if ((!Tpl_3092))
begin
Tpl_3756 <= 0;
end
else
begin
Tpl_3756 <= Tpl_3038;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_RPT_PROC_3430
if ((!Tpl_3092))
begin
Tpl_3757 <= 0;
end
else
begin
Tpl_3757 <= Tpl_3039;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_VRO_PROC_3433
if ((!Tpl_3092))
begin
Tpl_3758 <= 0;
end
else
begin
Tpl_3758 <= Tpl_3040;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_VRCG_PROC_3436
if ((!Tpl_3092))
begin
Tpl_3759 <= 0;
end
else
begin
Tpl_3759 <= Tpl_3041;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_RRO_PROC_3439
if ((!Tpl_3092))
begin
Tpl_3760 <= 0;
end
else
begin
Tpl_3760 <= Tpl_3042;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_DMD_PROC_3442
if ((!Tpl_3092))
begin
Tpl_3761 <= 0;
end
else
begin
Tpl_3761 <= Tpl_3043;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_FSPWR_PROC_3445
if ((!Tpl_3092))
begin
Tpl_3762 <= 0;
end
else
begin
Tpl_3762 <= Tpl_3044;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR13_FSPOP_PROC_3448
if ((!Tpl_3092))
begin
Tpl_3763 <= 0;
end
else
begin
Tpl_3763 <= Tpl_3045;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR14_FS0_VREFDQS_PROC_3451
if ((!Tpl_3092))
begin
Tpl_3764 <= 6'h0d;
end
else
begin
Tpl_3764 <= Tpl_3046;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR14_FS0_VREFDQR_PROC_3454
if ((!Tpl_3092))
begin
Tpl_3765 <= 1'b1;
end
else
begin
Tpl_3765 <= Tpl_3047;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR14_RESERVED0_PROC_3457
if ((!Tpl_3092))
begin
Tpl_3766 <= 0;
end
else
begin
Tpl_3766 <= Tpl_3048;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR14_FS1_VREFDQS_PROC_3460
if ((!Tpl_3092))
begin
Tpl_3767 <= 6'h0d;
end
else
begin
Tpl_3767 <= Tpl_3049;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR14_FS1_VREFDQR_PROC_3463
if ((!Tpl_3092))
begin
Tpl_3768 <= 1'b1;
end
else
begin
Tpl_3768 <= Tpl_3050;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR14_RESERVED1_PROC_3466
if ((!Tpl_3092))
begin
Tpl_3769 <= 0;
end
else
begin
Tpl_3769 <= Tpl_3051;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS0_SOCODT_PROC_3469
if ((!Tpl_3092))
begin
Tpl_3770 <= 0;
end
else
begin
Tpl_3770 <= Tpl_3052;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS0_ODTECK_PROC_3472
if ((!Tpl_3092))
begin
Tpl_3771 <= 0;
end
else
begin
Tpl_3771 <= Tpl_3053;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS0_ODTECS_PROC_3475
if ((!Tpl_3092))
begin
Tpl_3772 <= 0;
end
else
begin
Tpl_3772 <= Tpl_3054;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS0_ODTDCA_PROC_3478
if ((!Tpl_3092))
begin
Tpl_3773 <= 0;
end
else
begin
Tpl_3773 <= Tpl_3055;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_ODTDX8_PROC_3481
if ((!Tpl_3092))
begin
Tpl_3774 <= 0;
end
else
begin
Tpl_3774 <= Tpl_3056;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS1_SOCODT_PROC_3484
if ((!Tpl_3092))
begin
Tpl_3775 <= 0;
end
else
begin
Tpl_3775 <= Tpl_3057;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS1_ODTECK_PROC_3487
if ((!Tpl_3092))
begin
Tpl_3776 <= 0;
end
else
begin
Tpl_3776 <= Tpl_3058;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS1_ODTECS_PROC_3490
if ((!Tpl_3092))
begin
Tpl_3777 <= 0;
end
else
begin
Tpl_3777 <= Tpl_3059;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_FS1_ODTDCA_PROC_3493
if ((!Tpl_3092))
begin
Tpl_3778 <= 0;
end
else
begin
Tpl_3778 <= Tpl_3060;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_RESERVED_PROC_3496
if ((!Tpl_3092))
begin
Tpl_3779 <= 0;
end
else
begin
Tpl_3779 <= Tpl_3061;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS0_SOCODT_PROC_3499
if ((!Tpl_3092))
begin
Tpl_3780 <= 0;
end
else
begin
Tpl_3780 <= Tpl_3062;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS0_ODTECK_PROC_3502
if ((!Tpl_3092))
begin
Tpl_3781 <= 0;
end
else
begin
Tpl_3781 <= Tpl_3063;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS0_ODTECS_PROC_3505
if ((!Tpl_3092))
begin
Tpl_3782 <= 0;
end
else
begin
Tpl_3782 <= Tpl_3064;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS0_ODTDCA_PROC_3508
if ((!Tpl_3092))
begin
Tpl_3783 <= 0;
end
else
begin
Tpl_3783 <= Tpl_3065;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_ODTDX8_PROC_3511
if ((!Tpl_3092))
begin
Tpl_3784 <= 0;
end
else
begin
Tpl_3784 <= Tpl_3066;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS1_SOCODT_PROC_3514
if ((!Tpl_3092))
begin
Tpl_3785 <= 0;
end
else
begin
Tpl_3785 <= Tpl_3067;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS1_ODTECK_PROC_3517
if ((!Tpl_3092))
begin
Tpl_3786 <= 0;
end
else
begin
Tpl_3786 <= Tpl_3068;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS1_ODTECS_PROC_3520
if ((!Tpl_3092))
begin
Tpl_3787 <= 0;
end
else
begin
Tpl_3787 <= Tpl_3069;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_FS1_ODTDCA_PROC_3523
if ((!Tpl_3092))
begin
Tpl_3788 <= 0;
end
else
begin
Tpl_3788 <= Tpl_3070;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: SHAD_LPMR22_NT_RESERVED_PROC_3526
if ((!Tpl_3092))
begin
Tpl_3789 <= 0;
end
else
begin
Tpl_3789 <= Tpl_3071;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA0_RDDATA_PROC_3529
if ((!Tpl_3092))
begin
Tpl_3790 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3790 <= Tpl_3072;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA1_RDDATA_PROC_3532
if ((!Tpl_3092))
begin
Tpl_3791 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3791 <= Tpl_3073;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA2_RDDATA_PROC_3535
if ((!Tpl_3092))
begin
Tpl_3792 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3792 <= Tpl_3074;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA3_RDDATA_PROC_3538
if ((!Tpl_3092))
begin
Tpl_3793 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3793 <= Tpl_3075;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA4_RDDATA_PROC_3541
if ((!Tpl_3092))
begin
Tpl_3794 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3794 <= Tpl_3076;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA5_RDDATA_PROC_3544
if ((!Tpl_3092))
begin
Tpl_3795 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3795 <= Tpl_3077;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA6_RDDATA_PROC_3547
if ((!Tpl_3092))
begin
Tpl_3796 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3796 <= Tpl_3078;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA7_RDDATA_PROC_3550
if ((!Tpl_3092))
begin
Tpl_3797 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3797 <= Tpl_3079;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA8_RDDATA_PROC_3553
if ((!Tpl_3092))
begin
Tpl_3798 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3798 <= Tpl_3080;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA9_RDDATA_PROC_3556
if ((!Tpl_3092))
begin
Tpl_3799 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3799 <= Tpl_3081;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA10_RDDATA_PROC_3559
if ((!Tpl_3092))
begin
Tpl_3800 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3800 <= Tpl_3082;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA11_RDDATA_PROC_3562
if ((!Tpl_3092))
begin
Tpl_3801 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3801 <= Tpl_3083;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA12_RDDATA_PROC_3565
if ((!Tpl_3092))
begin
Tpl_3802 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3802 <= Tpl_3084;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA13_RDDATA_PROC_3568
if ((!Tpl_3092))
begin
Tpl_3803 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3803 <= Tpl_3085;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA14_RDDATA_PROC_3571
if ((!Tpl_3092))
begin
Tpl_3804 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3804 <= Tpl_3086;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA15_RDDATA_PROC_3574
if ((!Tpl_3092))
begin
Tpl_3805 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3805 <= Tpl_3087;
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin: DATA16_RDVALID_PROC_3577
if ((!Tpl_3092))
begin
Tpl_3806 <= 0;
end
else
if (Tpl_3106)
begin
Tpl_3806 <= 1'b1;
end
else
if ((Tpl_3611 & Tpl_3806))
begin
Tpl_3806 <= 1'b0;
end
end

assign Tpl_3807[4:0] = Tpl_1730;
assign Tpl_3807[6:5] = Tpl_1731;
assign Tpl_3807[8:7] = Tpl_1732;
assign Tpl_3807[14:9] = Tpl_1733;
assign Tpl_3807[15] = Tpl_1734;
assign Tpl_3807[23:16] = Tpl_1735;
assign Tpl_3807[31:24] = 8'h00;
assign Tpl_3808[2:0] = Tpl_1736;
assign Tpl_3808[4:3] = Tpl_1737;
assign Tpl_3808[7:5] = Tpl_1738;
assign Tpl_3808[8] = Tpl_1739;
assign Tpl_3808[9] = Tpl_1740;
assign Tpl_3808[10] = Tpl_1741;
assign Tpl_3808[11] = Tpl_1742;
assign Tpl_3808[12] = Tpl_1743;
assign Tpl_3808[13] = Tpl_1744;
assign Tpl_3808[20:14] = Tpl_1745;
assign Tpl_3808[28:21] = Tpl_1746;
assign Tpl_3808[29] = Tpl_1747;
assign Tpl_3808[30] = Tpl_1748;
assign Tpl_3808[31] = Tpl_1749;
assign Tpl_3809[0] = Tpl_1750;
assign Tpl_3809[1] = Tpl_1751;
assign Tpl_3809[2] = Tpl_1752;
assign Tpl_3809[3] = Tpl_1753;
assign Tpl_3809[4] = Tpl_1754;
assign Tpl_3809[7:5] = Tpl_1755;
assign Tpl_3809[8] = Tpl_1756;
assign Tpl_3809[9] = Tpl_1757;
assign Tpl_3809[10] = Tpl_1758;
assign Tpl_3809[31:11] = 21'h000000;
assign Tpl_3810[1:0] = Tpl_1759;
assign Tpl_3810[2] = Tpl_1760;
assign Tpl_3810[3] = Tpl_1761;
assign Tpl_3810[6:4] = Tpl_1762;
assign Tpl_3810[7] = Tpl_1763;
assign Tpl_3810[9:8] = Tpl_1764;
assign Tpl_3810[10] = Tpl_1765;
assign Tpl_3810[11] = Tpl_1766;
assign Tpl_3810[14:12] = Tpl_1767;
assign Tpl_3810[15] = Tpl_1768;
assign Tpl_3810[31:16] = 16'h0000;
assign Tpl_3811[2:0] = Tpl_1769;
assign Tpl_3811[5:3] = Tpl_1770;
assign Tpl_3811[6] = Tpl_1771;
assign Tpl_3811[7] = Tpl_1772;
assign Tpl_3811[10:8] = Tpl_1773;
assign Tpl_3811[13:11] = Tpl_1774;
assign Tpl_3811[14] = Tpl_1775;
assign Tpl_3811[31:15] = 17'h00000;
assign Tpl_3812[0] = Tpl_1776;
assign Tpl_3812[1] = Tpl_1777;
assign Tpl_3812[2] = Tpl_1778;
assign Tpl_3812[5:3] = Tpl_1779;
assign Tpl_3812[6] = Tpl_1780;
assign Tpl_3812[7] = Tpl_1781;
assign Tpl_3812[8] = Tpl_1782;
assign Tpl_3812[9] = Tpl_1783;
assign Tpl_3812[12:10] = Tpl_1784;
assign Tpl_3812[13] = Tpl_1785;
assign Tpl_3812[14] = Tpl_1786;
assign Tpl_3812[31:15] = 17'h00000;
assign Tpl_3813[2:0] = Tpl_1787;
assign Tpl_3813[5:3] = Tpl_1788;
assign Tpl_3813[8:6] = Tpl_1789;
assign Tpl_3813[11:9] = Tpl_1790;
assign Tpl_3813[31:12] = 20'h00000;
assign Tpl_3814[2:0] = Tpl_1791;
assign Tpl_3814[5:3] = Tpl_1792;
assign Tpl_3814[8:6] = Tpl_1793;
assign Tpl_3814[11:9] = Tpl_1794;
assign Tpl_3814[31:12] = 20'h00000;
assign Tpl_3815[5:0] = Tpl_1795;
assign Tpl_3815[6] = Tpl_1796;
assign Tpl_3815[12:7] = Tpl_1797;
assign Tpl_3815[13] = Tpl_1798;
assign Tpl_3815[31:14] = 18'h00000;
assign Tpl_3816[0] = Tpl_1799;
assign Tpl_3816[1] = Tpl_1800;
assign Tpl_3816[2] = Tpl_1801;
assign Tpl_3816[3] = Tpl_1802;
assign Tpl_3816[4] = Tpl_1803;
assign Tpl_3816[5] = Tpl_1804;
assign Tpl_3816[6] = Tpl_1805;
assign Tpl_3816[7] = Tpl_1806;
assign Tpl_3816[31:8] = 24'h000000;
assign Tpl_3817[5:0] = Tpl_1807;
assign Tpl_3817[6] = Tpl_1808;
assign Tpl_3817[12:7] = Tpl_1809;
assign Tpl_3817[13] = Tpl_1810;
assign Tpl_3817[31:14] = 18'h00000;
assign Tpl_3818[2:0] = Tpl_1811;
assign Tpl_3818[3] = Tpl_1812;
assign Tpl_3818[4] = Tpl_1813;
assign Tpl_3818[5] = Tpl_1814;
assign Tpl_3818[7:6] = Tpl_1815;
assign Tpl_3818[10:8] = Tpl_1816;
assign Tpl_3818[11] = Tpl_1817;
assign Tpl_3818[12] = Tpl_1818;
assign Tpl_3818[13] = Tpl_1819;
assign Tpl_3818[31:14] = 18'h00000;
assign Tpl_3819[2:0] = Tpl_1820;
assign Tpl_3819[3] = Tpl_1821;
assign Tpl_3819[4] = Tpl_1822;
assign Tpl_3819[5] = Tpl_1823;
assign Tpl_3819[7:6] = Tpl_1824;
assign Tpl_3819[10:8] = Tpl_1825;
assign Tpl_3819[11] = Tpl_1826;
assign Tpl_3819[12] = Tpl_1827;
assign Tpl_3819[13] = Tpl_1828;
assign Tpl_3819[31:14] = 18'h00000;
assign Tpl_3820[2:0] = Tpl_1829;
assign Tpl_3820[5:3] = Tpl_1830;
assign Tpl_3820[31:6] = 26'h0000000;
assign Tpl_3821[3:0] = Tpl_1831;
assign Tpl_3821[4] = Tpl_1832;
assign Tpl_3821[5] = Tpl_1833;
assign Tpl_3821[6] = Tpl_1834;
assign Tpl_3821[31:7] = 25'h0000000;
assign Tpl_3822[3:0] = Tpl_1835;
assign Tpl_3822[31:4] = 28'h0000000;
assign Tpl_3823[7:0] = Tpl_1836;
assign Tpl_3823[31:8] = 24'h000000;
assign Tpl_3824[1:0] = Tpl_1837;
assign Tpl_3824[2] = Tpl_1838;
assign Tpl_3824[31:3] = 29'h00000000;
assign Tpl_3825[7:0] = Tpl_1839;
assign Tpl_3825[31:8] = 24'h000000;
assign Tpl_3826[7:0] = Tpl_1840;
assign Tpl_3826[31:8] = 24'h000000;
assign Tpl_3827[2:0] = Tpl_1841;
assign Tpl_3827[3] = Tpl_1842;
assign Tpl_3827[4] = Tpl_1843;
assign Tpl_3827[8:5] = Tpl_1844;
assign Tpl_3827[9] = Tpl_1845;
assign Tpl_3827[11:10] = Tpl_1846;
assign Tpl_3827[31:12] = 20'h00000;
assign Tpl_3828[0] = Tpl_1847;
assign Tpl_3828[1] = Tpl_1848;
assign Tpl_3828[2] = Tpl_1849;
assign Tpl_3828[5:3] = Tpl_1850;
assign Tpl_3828[7:6] = Tpl_1851;
assign Tpl_3828[8] = Tpl_1852;
assign Tpl_3828[11:9] = Tpl_1853;
assign Tpl_3828[31:12] = 20'h00000;
assign Tpl_3829[1:0] = Tpl_1854;
assign Tpl_3829[3:2] = Tpl_1855;
assign Tpl_3829[6:4] = Tpl_1856;
assign Tpl_3829[7] = Tpl_1857;
assign Tpl_3829[31:8] = 24'h000000;
assign Tpl_3830[0] = Tpl_1858;
assign Tpl_3830[2:1] = Tpl_1859;
assign Tpl_3830[3] = Tpl_1860;
assign Tpl_3830[4] = Tpl_1861;
assign Tpl_3830[5] = Tpl_1862;
assign Tpl_3830[8:6] = Tpl_1863;
assign Tpl_3830[10:9] = Tpl_1864;
assign Tpl_3830[12:11] = Tpl_1865;
assign Tpl_3830[31:13] = 19'h00000;
assign Tpl_3831[0] = Tpl_1866;
assign Tpl_3831[1] = Tpl_1867;
assign Tpl_3831[2] = Tpl_1868;
assign Tpl_3831[3] = Tpl_1869;
assign Tpl_3831[6:4] = Tpl_1870;
assign Tpl_3831[7] = Tpl_1871;
assign Tpl_3831[8] = Tpl_1872;
assign Tpl_3831[9] = Tpl_1873;
assign Tpl_3831[10] = Tpl_1874;
assign Tpl_3831[31:11] = 21'h000000;
assign Tpl_3832[2:0] = Tpl_1875;
assign Tpl_3832[3] = Tpl_1876;
assign Tpl_3832[4] = Tpl_1877;
assign Tpl_3832[5] = Tpl_1878;
assign Tpl_3832[8:6] = Tpl_1879;
assign Tpl_3832[9] = Tpl_1880;
assign Tpl_3832[10] = Tpl_1881;
assign Tpl_3832[11] = Tpl_1882;
assign Tpl_3832[12] = Tpl_1883;
assign Tpl_3832[31:13] = 19'h00000;
assign Tpl_3833[5:0] = Tpl_1884;
assign Tpl_3833[6] = Tpl_1885;
assign Tpl_3833[7] = Tpl_1886;
assign Tpl_3833[10:8] = Tpl_1887;
assign Tpl_3833[31:11] = 21'h000000;
assign Tpl_3834[0] = Tpl_1888;
assign Tpl_3834[3:1] = Tpl_1889;
assign Tpl_3834[4] = Tpl_1890;
assign Tpl_3834[5] = Tpl_1891;
assign Tpl_3834[9:6] = Tpl_1892;
assign Tpl_3834[10] = Tpl_1893;
assign Tpl_3834[13:11] = Tpl_1894;
assign Tpl_3834[31:14] = 18'h00000;
assign Tpl_3835[0] = Tpl_1895;
assign Tpl_3835[1] = Tpl_1896;
assign Tpl_3835[2] = Tpl_1897;
assign Tpl_3835[5:3] = Tpl_1898;
assign Tpl_3835[7:6] = Tpl_1899;
assign Tpl_3835[8] = Tpl_1900;
assign Tpl_3835[10:9] = Tpl_1901;
assign Tpl_3835[31:11] = 21'h000000;
assign Tpl_3836[1:0] = Tpl_1902;
assign Tpl_3836[2] = Tpl_1903;
assign Tpl_3836[3] = Tpl_1904;
assign Tpl_3836[6:4] = Tpl_1905;
assign Tpl_3836[9:7] = Tpl_1906;
assign Tpl_3836[31:10] = 22'h000000;
assign Tpl_3837[0] = Tpl_1907;
assign Tpl_3837[2:1] = Tpl_1908;
assign Tpl_3837[31:3] = 29'h00000000;
assign Tpl_3838[0] = Tpl_1909;
assign Tpl_3838[1] = Tpl_1910;
assign Tpl_3838[5:2] = Tpl_1911;
assign Tpl_3838[9:6] = Tpl_1912;
assign Tpl_3838[13:10] = Tpl_1913;
assign Tpl_3838[17:14] = Tpl_1914;
assign Tpl_3838[18] = Tpl_1915;
assign Tpl_3838[19] = Tpl_1916;
assign Tpl_3838[20] = Tpl_1917;
assign Tpl_3838[21] = Tpl_1918;
assign Tpl_3838[22] = Tpl_1919;
assign Tpl_3838[23] = Tpl_1920;
assign Tpl_3838[24] = Tpl_1921;
assign Tpl_3838[25] = Tpl_1922;
assign Tpl_3838[26] = Tpl_1923;
assign Tpl_3838[29:27] = Tpl_1924;
assign Tpl_3838[31:30] = 2'h0;
assign Tpl_3839[0] = Tpl_1925;
assign Tpl_3839[1] = Tpl_1926;
assign Tpl_3839[5:2] = Tpl_1927;
assign Tpl_3839[9:6] = Tpl_1928;
assign Tpl_3839[13:10] = Tpl_1929;
assign Tpl_3839[17:14] = Tpl_1930;
assign Tpl_3839[18] = Tpl_1931;
assign Tpl_3839[19] = Tpl_1932;
assign Tpl_3839[20] = Tpl_1933;
assign Tpl_3839[21] = Tpl_1934;
assign Tpl_3839[22] = Tpl_1935;
assign Tpl_3839[23] = Tpl_1936;
assign Tpl_3839[24] = Tpl_1937;
assign Tpl_3839[25] = Tpl_1938;
assign Tpl_3839[26] = Tpl_1939;
assign Tpl_3839[29:27] = Tpl_1940;
assign Tpl_3839[31:30] = 2'h0;
assign Tpl_3840[0] = Tpl_1941;
assign Tpl_3840[1] = Tpl_1942;
assign Tpl_3840[5:2] = Tpl_1943;
assign Tpl_3840[9:6] = Tpl_1944;
assign Tpl_3840[13:10] = Tpl_1945;
assign Tpl_3840[17:14] = Tpl_1946;
assign Tpl_3840[18] = Tpl_1947;
assign Tpl_3840[19] = Tpl_1948;
assign Tpl_3840[20] = Tpl_1949;
assign Tpl_3840[21] = Tpl_1950;
assign Tpl_3840[22] = Tpl_1951;
assign Tpl_3840[23] = Tpl_1952;
assign Tpl_3840[24] = Tpl_1953;
assign Tpl_3840[25] = Tpl_1954;
assign Tpl_3840[26] = Tpl_1955;
assign Tpl_3840[29:27] = Tpl_1956;
assign Tpl_3840[31:30] = 2'h0;
assign Tpl_3841[0] = Tpl_1957;
assign Tpl_3841[1] = Tpl_1958;
assign Tpl_3841[5:2] = Tpl_1959;
assign Tpl_3841[9:6] = Tpl_1960;
assign Tpl_3841[13:10] = Tpl_1961;
assign Tpl_3841[17:14] = Tpl_1962;
assign Tpl_3841[18] = Tpl_1963;
assign Tpl_3841[19] = Tpl_1964;
assign Tpl_3841[20] = Tpl_1965;
assign Tpl_3841[21] = Tpl_1966;
assign Tpl_3841[22] = Tpl_1967;
assign Tpl_3841[23] = Tpl_1968;
assign Tpl_3841[24] = Tpl_1969;
assign Tpl_3841[25] = Tpl_1970;
assign Tpl_3841[26] = Tpl_1971;
assign Tpl_3841[29:27] = Tpl_1972;
assign Tpl_3841[31:30] = 2'h0;
assign Tpl_3842[7:0] = Tpl_1973;
assign Tpl_3842[15:8] = Tpl_1974;
assign Tpl_3842[23:16] = Tpl_1975;
assign Tpl_3842[31:24] = Tpl_1976;
assign Tpl_3843[7:0] = Tpl_1977;
assign Tpl_3843[15:8] = Tpl_1978;
assign Tpl_3843[23:16] = Tpl_1979;
assign Tpl_3843[31:24] = Tpl_1980;
assign Tpl_3844[7:0] = Tpl_1981;
assign Tpl_3844[15:8] = Tpl_1982;
assign Tpl_3844[23:16] = Tpl_1983;
assign Tpl_3844[31:24] = Tpl_1984;
assign Tpl_3845[7:0] = Tpl_1985;
assign Tpl_3845[15:8] = Tpl_1986;
assign Tpl_3845[23:16] = Tpl_1987;
assign Tpl_3845[31:24] = Tpl_1988;
assign Tpl_3846[2:0] = Tpl_1989;
assign Tpl_3846[31:3] = 29'h00000000;
assign Tpl_3847[2:0] = Tpl_1990;
assign Tpl_3847[31:3] = 29'h00000000;
assign Tpl_3848[2:0] = Tpl_1991;
assign Tpl_3848[31:3] = 29'h00000000;
assign Tpl_3849[2:0] = Tpl_1992;
assign Tpl_3849[31:3] = 29'h00000000;
assign Tpl_3850[4:0] = Tpl_1993;
assign Tpl_3850[9:5] = Tpl_1994;
assign Tpl_3850[14:10] = Tpl_1995;
assign Tpl_3850[19:15] = Tpl_1996;
assign Tpl_3850[24:20] = Tpl_1997;
assign Tpl_3850[29:25] = Tpl_1998;
assign Tpl_3850[31:30] = 2'h0;
assign Tpl_3851[4:0] = Tpl_1999;
assign Tpl_3851[9:5] = Tpl_2000;
assign Tpl_3851[14:10] = Tpl_2001;
assign Tpl_3851[19:15] = Tpl_2002;
assign Tpl_3851[24:20] = Tpl_2003;
assign Tpl_3851[31:25] = 7'h00;
assign Tpl_3852[4:0] = Tpl_2004;
assign Tpl_3852[9:5] = Tpl_2005;
assign Tpl_3852[14:10] = Tpl_2006;
assign Tpl_3852[19:15] = Tpl_2007;
assign Tpl_3852[24:20] = Tpl_2008;
assign Tpl_3852[29:25] = Tpl_2009;
assign Tpl_3852[31:30] = 2'h0;
assign Tpl_3853[4:0] = Tpl_2010;
assign Tpl_3853[9:5] = Tpl_2011;
assign Tpl_3853[14:10] = Tpl_2012;
assign Tpl_3853[19:15] = Tpl_2013;
assign Tpl_3853[24:20] = Tpl_2014;
assign Tpl_3853[29:25] = Tpl_2015;
assign Tpl_3853[31:30] = 2'h0;
assign Tpl_3854[4:0] = Tpl_2016;
assign Tpl_3854[9:5] = Tpl_2017;
assign Tpl_3854[14:10] = Tpl_2018;
assign Tpl_3854[19:15] = Tpl_2019;
assign Tpl_3854[24:20] = Tpl_2020;
assign Tpl_3854[31:25] = 7'h00;
assign Tpl_3855[4:0] = Tpl_2021;
assign Tpl_3855[9:5] = Tpl_2022;
assign Tpl_3855[14:10] = Tpl_2023;
assign Tpl_3855[19:15] = Tpl_2024;
assign Tpl_3855[24:20] = Tpl_2025;
assign Tpl_3855[29:25] = Tpl_2026;
assign Tpl_3855[31:30] = 2'h0;
assign Tpl_3856[0] = Tpl_2027;
assign Tpl_3856[4:1] = Tpl_2028;
assign Tpl_3856[31:5] = 27'h0000000;
assign Tpl_3857[1:0] = Tpl_2029;
assign Tpl_3857[2] = Tpl_2030;
assign Tpl_3857[3] = Tpl_2031;
assign Tpl_3857[4] = Tpl_2032;
assign Tpl_3857[5] = Tpl_2033;
assign Tpl_3857[6] = Tpl_2034;
assign Tpl_3857[7] = Tpl_2035;
assign Tpl_3857[8] = Tpl_2036;
assign Tpl_3857[9] = Tpl_2037;
assign Tpl_3857[10] = Tpl_2038;
assign Tpl_3857[11] = Tpl_2039;
assign Tpl_3857[12] = Tpl_2040;
assign Tpl_3857[13] = Tpl_2041;
assign Tpl_3857[14] = Tpl_2042;
assign Tpl_3857[15] = Tpl_2043;
assign Tpl_3857[16] = Tpl_2044;
assign Tpl_3857[17] = Tpl_2045;
assign Tpl_3857[18] = Tpl_2046;
assign Tpl_3857[19] = Tpl_2047;
assign Tpl_3857[20] = Tpl_2048;
assign Tpl_3857[21] = Tpl_2049;
assign Tpl_3857[23:22] = Tpl_2050;
assign Tpl_3857[31:24] = 8'h00;
assign Tpl_3858[4:0] = Tpl_2051;
assign Tpl_3858[5] = Tpl_2052;
assign Tpl_3858[6] = Tpl_2053;
assign Tpl_3858[7] = Tpl_2054;
assign Tpl_3858[15:8] = Tpl_2055;
assign Tpl_3858[21:16] = Tpl_2056;
assign Tpl_3858[31:22] = 10'h000;
assign Tpl_3859[4:0] = Tpl_2057;
assign Tpl_3859[5] = Tpl_2058;
assign Tpl_3859[6] = Tpl_2059;
assign Tpl_3859[7] = Tpl_2060;
assign Tpl_3859[15:8] = Tpl_2061;
assign Tpl_3859[21:16] = Tpl_2062;
assign Tpl_3859[31:22] = 10'h000;
assign Tpl_3860[4:0] = Tpl_2063;
assign Tpl_3860[5] = Tpl_2064;
assign Tpl_3860[6] = Tpl_2065;
assign Tpl_3860[7] = Tpl_2066;
assign Tpl_3860[15:8] = Tpl_2067;
assign Tpl_3860[31:16] = 16'h0000;
assign Tpl_3861[4:0] = Tpl_2068;
assign Tpl_3861[5] = Tpl_2069;
assign Tpl_3861[6] = Tpl_2070;
assign Tpl_3861[7] = Tpl_2071;
assign Tpl_3861[15:8] = Tpl_2072;
assign Tpl_3861[31:16] = 16'h0000;
assign Tpl_3862[4:0] = Tpl_2073;
assign Tpl_3862[5] = Tpl_2074;
assign Tpl_3862[6] = Tpl_2075;
assign Tpl_3862[7] = Tpl_2076;
assign Tpl_3862[15:8] = Tpl_2077;
assign Tpl_3862[31:16] = 16'h0000;
assign Tpl_3863[4:0] = Tpl_2078;
assign Tpl_3863[5] = Tpl_2079;
assign Tpl_3863[6] = Tpl_2080;
assign Tpl_3863[7] = Tpl_2081;
assign Tpl_3863[15:8] = Tpl_2082;
assign Tpl_3863[31:16] = 16'h0000;
assign Tpl_3864[0] = Tpl_2083;
assign Tpl_3864[1] = Tpl_2084;
assign Tpl_3864[7:2] = Tpl_2085;
assign Tpl_3864[13:8] = Tpl_2086;
assign Tpl_3864[20:14] = Tpl_2087;
assign Tpl_3864[31:21] = 11'h000;
assign Tpl_3865[5:0] = Tpl_2088;
assign Tpl_3865[11:6] = Tpl_2089;
assign Tpl_3865[18:12] = Tpl_2090;
assign Tpl_3865[31:19] = 13'h0000;
assign Tpl_3866[3:0] = Tpl_2091;
assign Tpl_3866[20:4] = Tpl_2092;
assign Tpl_3866[31:21] = Tpl_2093;
assign Tpl_3867[0] = Tpl_2094;
assign Tpl_3867[8:1] = Tpl_2095;
assign Tpl_3867[14:9] = Tpl_2096;
assign Tpl_3867[20:15] = Tpl_2097;
assign Tpl_3867[21] = Tpl_2098;
assign Tpl_3867[31:22] = 10'h000;
assign Tpl_3868[0] = Tpl_2099;
assign Tpl_3868[1] = Tpl_2100;
assign Tpl_3868[2] = Tpl_2101;
assign Tpl_3868[3] = Tpl_2102;
assign Tpl_3868[9:4] = Tpl_2103;
assign Tpl_3868[10] = Tpl_2104;
assign Tpl_3868[16:11] = Tpl_2105;
assign Tpl_3868[31:17] = 15'h0000;
assign Tpl_3869[2:0] = Tpl_2106;
assign Tpl_3869[3] = Tpl_2107;
assign Tpl_3869[31:4] = 28'h0000000;
assign Tpl_3870[2:0] = Tpl_2108;
assign Tpl_3870[3] = Tpl_2109;
assign Tpl_3870[31:4] = 28'h0000000;
assign Tpl_3871[1:0] = Tpl_2110;
assign Tpl_3871[31:2] = Tpl_2111;
assign Tpl_3872[2:0] = Tpl_2112;
assign Tpl_3872[3] = Tpl_2113;
assign Tpl_3872[4] = Tpl_2114;
assign Tpl_3872[5] = Tpl_2115;
assign Tpl_3872[8:6] = Tpl_2116;
assign Tpl_3872[16:9] = Tpl_2117;
assign Tpl_3872[17] = Tpl_2118;
assign Tpl_3872[18] = Tpl_2119;
assign Tpl_3872[31:19] = 13'h0000;
assign Tpl_3873[2:0] = Tpl_2120;
assign Tpl_3873[3] = Tpl_2121;
assign Tpl_3873[4] = Tpl_2122;
assign Tpl_3873[5] = Tpl_2123;
assign Tpl_3873[8:6] = Tpl_2124;
assign Tpl_3873[16:9] = Tpl_2125;
assign Tpl_3873[17] = Tpl_2126;
assign Tpl_3873[18] = Tpl_2127;
assign Tpl_3873[31:19] = 13'h0000;
assign Tpl_3874[2:0] = Tpl_2128;
assign Tpl_3874[3] = Tpl_2129;
assign Tpl_3874[4] = Tpl_2130;
assign Tpl_3874[5] = Tpl_2131;
assign Tpl_3874[8:6] = Tpl_2132;
assign Tpl_3874[16:9] = Tpl_2133;
assign Tpl_3874[17] = Tpl_2134;
assign Tpl_3874[18] = Tpl_2135;
assign Tpl_3874[31:19] = 13'h0000;
assign Tpl_3875[2:0] = Tpl_2136;
assign Tpl_3875[3] = Tpl_2137;
assign Tpl_3875[4] = Tpl_2138;
assign Tpl_3875[5] = Tpl_2139;
assign Tpl_3875[8:6] = Tpl_2140;
assign Tpl_3875[16:9] = Tpl_2141;
assign Tpl_3875[17] = Tpl_2142;
assign Tpl_3875[18] = Tpl_2143;
assign Tpl_3875[31:19] = 13'h0000;
assign Tpl_3876[0] = Tpl_2144;
assign Tpl_3876[1] = Tpl_2145;
assign Tpl_3876[2] = Tpl_2146;
assign Tpl_3876[3] = Tpl_2147;
assign Tpl_3876[4] = Tpl_2148;
assign Tpl_3876[5] = Tpl_2149;
assign Tpl_3876[9:6] = Tpl_2150;
assign Tpl_3876[13:10] = Tpl_2151;
assign Tpl_3876[24:14] = Tpl_2152;
assign Tpl_3876[31:25] = 7'h00;
assign Tpl_3877[7:0] = Tpl_2153;
assign Tpl_3877[11:8] = Tpl_2154;
assign Tpl_3877[12] = Tpl_2155;
assign Tpl_3877[15:13] = Tpl_2156;
assign Tpl_3877[23:16] = Tpl_2157;
assign Tpl_3877[24] = Tpl_2158;
assign Tpl_3877[26:25] = Tpl_2159;
assign Tpl_3877[31:27] = 5'h00;
assign Tpl_3878[0] = Tpl_2160;
assign Tpl_3878[6:1] = Tpl_2162;
assign Tpl_3878[7] = Tpl_2164;
assign Tpl_3878[13:8] = Tpl_2166;
assign Tpl_3878[31:14] = 18'h00000;
assign Tpl_3879[6:0] = Tpl_2168;
assign Tpl_3879[13:7] = Tpl_2170;
assign Tpl_3879[20:14] = Tpl_2172;
assign Tpl_3879[27:21] = Tpl_2174;
assign Tpl_3879[31:28] = 4'h0;
assign Tpl_3880[6:0] = Tpl_2176;
assign Tpl_3880[13:7] = Tpl_2178;
assign Tpl_3880[20:14] = Tpl_2180;
assign Tpl_3880[27:21] = Tpl_2182;
assign Tpl_3880[31:28] = 4'h0;
assign Tpl_3881[6:0] = Tpl_2184;
assign Tpl_3881[13:7] = Tpl_2186;
assign Tpl_3881[20:14] = Tpl_2188;
assign Tpl_3881[27:21] = Tpl_2190;
assign Tpl_3881[31:28] = 4'h0;
assign Tpl_3882[6:0] = Tpl_2192;
assign Tpl_3882[13:7] = Tpl_2194;
assign Tpl_3882[20:14] = Tpl_2196;
assign Tpl_3882[27:21] = Tpl_2198;
assign Tpl_3882[31:28] = 4'h0;
assign Tpl_3883[6:0] = Tpl_2200;
assign Tpl_3883[13:7] = Tpl_2202;
assign Tpl_3883[20:14] = Tpl_2204;
assign Tpl_3883[27:21] = Tpl_2206;
assign Tpl_3883[31:28] = 4'h0;
assign Tpl_3884[6:0] = Tpl_2208;
assign Tpl_3884[13:7] = Tpl_2210;
assign Tpl_3884[20:14] = Tpl_2212;
assign Tpl_3884[27:21] = Tpl_2214;
assign Tpl_3884[31:28] = 4'h0;
assign Tpl_3885[6:0] = Tpl_2216;
assign Tpl_3885[13:7] = Tpl_2218;
assign Tpl_3885[20:14] = Tpl_2220;
assign Tpl_3885[27:21] = Tpl_2222;
assign Tpl_3885[31:28] = 4'h0;
assign Tpl_3886[6:0] = Tpl_2224;
assign Tpl_3886[13:7] = Tpl_2226;
assign Tpl_3886[20:14] = Tpl_2228;
assign Tpl_3886[27:21] = Tpl_2230;
assign Tpl_3886[31:28] = 4'h0;
assign Tpl_3887[6:0] = Tpl_2232;
assign Tpl_3887[13:7] = Tpl_2234;
assign Tpl_3887[20:14] = Tpl_2236;
assign Tpl_3887[27:21] = Tpl_2238;
assign Tpl_3887[31:28] = 4'h0;
assign Tpl_3888[6:0] = Tpl_2240;
assign Tpl_3888[13:7] = Tpl_2242;
assign Tpl_3888[20:14] = Tpl_2244;
assign Tpl_3888[27:21] = Tpl_2246;
assign Tpl_3888[31:28] = 4'h0;
assign Tpl_3889[6:0] = Tpl_2248;
assign Tpl_3889[13:7] = Tpl_2249;
assign Tpl_3889[20:14] = Tpl_2250;
assign Tpl_3889[27:21] = Tpl_2251;
assign Tpl_3889[31:28] = 4'h0;
assign Tpl_3890[6:0] = Tpl_2252;
assign Tpl_3890[13:7] = Tpl_2253;
assign Tpl_3890[20:14] = Tpl_2254;
assign Tpl_3890[27:21] = Tpl_2255;
assign Tpl_3890[31:28] = 4'h0;
assign Tpl_3891[6:0] = Tpl_2256;
assign Tpl_3891[13:7] = Tpl_2257;
assign Tpl_3891[20:14] = Tpl_2258;
assign Tpl_3891[27:21] = Tpl_2259;
assign Tpl_3891[31:28] = 4'h0;
assign Tpl_3892[5:0] = Tpl_2260;
assign Tpl_3892[11:6] = Tpl_2262;
assign Tpl_3892[17:12] = Tpl_2264;
assign Tpl_3892[23:18] = Tpl_2266;
assign Tpl_3892[31:24] = 8'h00;
assign Tpl_3893[7:0] = Tpl_2268;
assign Tpl_3893[15:8] = Tpl_2270;
assign Tpl_3893[23:16] = Tpl_2272;
assign Tpl_3893[31:24] = Tpl_2274;
assign Tpl_3894[7:0] = Tpl_2276;
assign Tpl_3894[15:8] = Tpl_2278;
assign Tpl_3894[23:16] = Tpl_2280;
assign Tpl_3894[31:24] = Tpl_2282;
assign Tpl_3895[7:0] = Tpl_2284;
assign Tpl_3895[15:8] = Tpl_2286;
assign Tpl_3895[23:16] = Tpl_2288;
assign Tpl_3895[31:24] = Tpl_2290;
assign Tpl_3896[7:0] = Tpl_2292;
assign Tpl_3896[15:8] = Tpl_2294;
assign Tpl_3896[23:16] = Tpl_2296;
assign Tpl_3896[31:24] = Tpl_2298;
assign Tpl_3897[7:0] = Tpl_2300;
assign Tpl_3897[15:8] = Tpl_2302;
assign Tpl_3897[23:16] = Tpl_2304;
assign Tpl_3897[31:24] = Tpl_2306;
assign Tpl_3898[7:0] = Tpl_2308;
assign Tpl_3898[15:8] = Tpl_2310;
assign Tpl_3898[23:16] = Tpl_2312;
assign Tpl_3898[31:24] = Tpl_2314;
assign Tpl_3899[7:0] = Tpl_2316;
assign Tpl_3899[15:8] = Tpl_2318;
assign Tpl_3899[23:16] = Tpl_2320;
assign Tpl_3899[31:24] = Tpl_2322;
assign Tpl_3900[7:0] = Tpl_2324;
assign Tpl_3900[15:8] = Tpl_2326;
assign Tpl_3900[23:16] = Tpl_2328;
assign Tpl_3900[31:24] = Tpl_2330;
assign Tpl_3901[7:0] = Tpl_2332;
assign Tpl_3901[15:8] = Tpl_2334;
assign Tpl_3901[23:16] = Tpl_2336;
assign Tpl_3901[31:24] = Tpl_2338;
assign Tpl_3902[7:0] = Tpl_2340;
assign Tpl_3902[15:8] = Tpl_2342;
assign Tpl_3902[23:16] = Tpl_2344;
assign Tpl_3902[31:24] = Tpl_2346;
assign Tpl_3903[7:0] = Tpl_2348;
assign Tpl_3903[15:8] = Tpl_2350;
assign Tpl_3903[23:16] = Tpl_2352;
assign Tpl_3903[31:24] = Tpl_2354;
assign Tpl_3904[7:0] = Tpl_2356;
assign Tpl_3904[15:8] = Tpl_2358;
assign Tpl_3904[23:16] = Tpl_2360;
assign Tpl_3904[31:24] = Tpl_2362;
assign Tpl_3905[7:0] = Tpl_2364;
assign Tpl_3905[15:8] = Tpl_2366;
assign Tpl_3905[23:16] = Tpl_2368;
assign Tpl_3905[31:24] = Tpl_2370;
assign Tpl_3906[7:0] = Tpl_2372;
assign Tpl_3906[15:8] = Tpl_2374;
assign Tpl_3906[23:16] = Tpl_2376;
assign Tpl_3906[31:24] = Tpl_2378;
assign Tpl_3907[7:0] = Tpl_2380;
assign Tpl_3907[15:8] = Tpl_2382;
assign Tpl_3907[23:16] = Tpl_2384;
assign Tpl_3907[31:24] = Tpl_2386;
assign Tpl_3908[7:0] = Tpl_2388;
assign Tpl_3908[15:8] = Tpl_2390;
assign Tpl_3908[23:16] = Tpl_2392;
assign Tpl_3908[31:24] = Tpl_2394;
assign Tpl_3909[7:0] = Tpl_2396;
assign Tpl_3909[15:8] = Tpl_2398;
assign Tpl_3909[23:16] = Tpl_2400;
assign Tpl_3909[31:24] = Tpl_2402;
assign Tpl_3910[7:0] = Tpl_2404;
assign Tpl_3910[15:8] = Tpl_2406;
assign Tpl_3910[23:16] = Tpl_2408;
assign Tpl_3910[31:24] = Tpl_2410;
assign Tpl_3911[7:0] = Tpl_2412;
assign Tpl_3911[15:8] = Tpl_2414;
assign Tpl_3911[23:16] = Tpl_2416;
assign Tpl_3911[31:24] = Tpl_2418;
assign Tpl_3912[5:0] = Tpl_2420;
assign Tpl_3912[11:6] = Tpl_2422;
assign Tpl_3912[17:12] = Tpl_2424;
assign Tpl_3912[23:18] = Tpl_2426;
assign Tpl_3912[24] = Tpl_2428;
assign Tpl_3912[31:25] = 7'h00;
assign Tpl_3913[0] = Tpl_2430;
assign Tpl_3913[6:1] = Tpl_2432;
assign Tpl_3913[7] = Tpl_2434;
assign Tpl_3913[13:8] = Tpl_2436;
assign Tpl_3913[31:14] = 18'h00000;
assign Tpl_3914[6:0] = Tpl_2438;
assign Tpl_3914[13:7] = Tpl_2440;
assign Tpl_3914[20:14] = Tpl_2442;
assign Tpl_3914[27:21] = Tpl_2444;
assign Tpl_3914[31:28] = 4'h0;
assign Tpl_3915[6:0] = Tpl_2446;
assign Tpl_3915[13:7] = Tpl_2448;
assign Tpl_3915[20:14] = Tpl_2450;
assign Tpl_3915[27:21] = Tpl_2452;
assign Tpl_3915[31:28] = 4'h0;
assign Tpl_3916[6:0] = Tpl_2454;
assign Tpl_3916[13:7] = Tpl_2456;
assign Tpl_3916[20:14] = Tpl_2458;
assign Tpl_3916[27:21] = Tpl_2460;
assign Tpl_3916[31:28] = 4'h0;
assign Tpl_3917[6:0] = Tpl_2462;
assign Tpl_3917[13:7] = Tpl_2464;
assign Tpl_3917[20:14] = Tpl_2466;
assign Tpl_3917[27:21] = Tpl_2468;
assign Tpl_3917[31:28] = 4'h0;
assign Tpl_3918[6:0] = Tpl_2470;
assign Tpl_3918[13:7] = Tpl_2472;
assign Tpl_3918[20:14] = Tpl_2474;
assign Tpl_3918[27:21] = Tpl_2476;
assign Tpl_3918[31:28] = 4'h0;
assign Tpl_3919[6:0] = Tpl_2478;
assign Tpl_3919[13:7] = Tpl_2480;
assign Tpl_3919[20:14] = Tpl_2482;
assign Tpl_3919[27:21] = Tpl_2484;
assign Tpl_3919[31:28] = 4'h0;
assign Tpl_3920[6:0] = Tpl_2486;
assign Tpl_3920[13:7] = Tpl_2488;
assign Tpl_3920[20:14] = Tpl_2490;
assign Tpl_3920[27:21] = Tpl_2492;
assign Tpl_3920[31:28] = 4'h0;
assign Tpl_3921[6:0] = Tpl_2494;
assign Tpl_3921[13:7] = Tpl_2496;
assign Tpl_3921[20:14] = Tpl_2498;
assign Tpl_3921[27:21] = Tpl_2500;
assign Tpl_3921[31:28] = 4'h0;
assign Tpl_3922[6:0] = Tpl_2502;
assign Tpl_3922[13:7] = Tpl_2504;
assign Tpl_3922[20:14] = Tpl_2506;
assign Tpl_3922[27:21] = Tpl_2508;
assign Tpl_3922[31:28] = 4'h0;
assign Tpl_3923[6:0] = Tpl_2510;
assign Tpl_3923[13:7] = Tpl_2512;
assign Tpl_3923[20:14] = Tpl_2514;
assign Tpl_3923[27:21] = Tpl_2516;
assign Tpl_3923[31:28] = 4'h0;
assign Tpl_3924[6:0] = Tpl_2518;
assign Tpl_3924[13:7] = Tpl_2519;
assign Tpl_3924[20:14] = Tpl_2520;
assign Tpl_3924[27:21] = Tpl_2521;
assign Tpl_3924[31:28] = 4'h0;
assign Tpl_3925[6:0] = Tpl_2522;
assign Tpl_3925[13:7] = Tpl_2523;
assign Tpl_3925[20:14] = Tpl_2524;
assign Tpl_3925[27:21] = Tpl_2525;
assign Tpl_3925[31:28] = 4'h0;
assign Tpl_3926[6:0] = Tpl_2526;
assign Tpl_3926[13:7] = Tpl_2527;
assign Tpl_3926[20:14] = Tpl_2528;
assign Tpl_3926[27:21] = Tpl_2529;
assign Tpl_3926[31:28] = 4'h0;
assign Tpl_3927[5:0] = Tpl_2530;
assign Tpl_3927[11:6] = Tpl_2532;
assign Tpl_3927[17:12] = Tpl_2534;
assign Tpl_3927[23:18] = Tpl_2536;
assign Tpl_3927[31:24] = 8'h00;
assign Tpl_3928[7:0] = Tpl_2538;
assign Tpl_3928[15:8] = Tpl_2540;
assign Tpl_3928[23:16] = Tpl_2542;
assign Tpl_3928[31:24] = Tpl_2544;
assign Tpl_3929[7:0] = Tpl_2546;
assign Tpl_3929[15:8] = Tpl_2548;
assign Tpl_3929[23:16] = Tpl_2550;
assign Tpl_3929[31:24] = Tpl_2552;
assign Tpl_3930[7:0] = Tpl_2554;
assign Tpl_3930[15:8] = Tpl_2556;
assign Tpl_3930[23:16] = Tpl_2558;
assign Tpl_3930[31:24] = Tpl_2560;
assign Tpl_3931[7:0] = Tpl_2562;
assign Tpl_3931[15:8] = Tpl_2564;
assign Tpl_3931[23:16] = Tpl_2566;
assign Tpl_3931[31:24] = Tpl_2568;
assign Tpl_3932[7:0] = Tpl_2570;
assign Tpl_3932[15:8] = Tpl_2572;
assign Tpl_3932[23:16] = Tpl_2574;
assign Tpl_3932[31:24] = Tpl_2576;
assign Tpl_3933[7:0] = Tpl_2578;
assign Tpl_3933[15:8] = Tpl_2580;
assign Tpl_3933[23:16] = Tpl_2582;
assign Tpl_3933[31:24] = Tpl_2584;
assign Tpl_3934[7:0] = Tpl_2586;
assign Tpl_3934[15:8] = Tpl_2588;
assign Tpl_3934[23:16] = Tpl_2590;
assign Tpl_3934[31:24] = Tpl_2592;
assign Tpl_3935[7:0] = Tpl_2594;
assign Tpl_3935[15:8] = Tpl_2596;
assign Tpl_3935[23:16] = Tpl_2598;
assign Tpl_3935[31:24] = Tpl_2600;
assign Tpl_3936[7:0] = Tpl_2602;
assign Tpl_3936[15:8] = Tpl_2604;
assign Tpl_3936[23:16] = Tpl_2606;
assign Tpl_3936[31:24] = Tpl_2608;
assign Tpl_3937[7:0] = Tpl_2610;
assign Tpl_3937[15:8] = Tpl_2612;
assign Tpl_3937[23:16] = Tpl_2614;
assign Tpl_3937[31:24] = Tpl_2616;
assign Tpl_3938[7:0] = Tpl_2618;
assign Tpl_3938[15:8] = Tpl_2620;
assign Tpl_3938[23:16] = Tpl_2622;
assign Tpl_3938[31:24] = Tpl_2624;
assign Tpl_3939[7:0] = Tpl_2626;
assign Tpl_3939[15:8] = Tpl_2628;
assign Tpl_3939[23:16] = Tpl_2630;
assign Tpl_3939[31:24] = Tpl_2632;
assign Tpl_3940[7:0] = Tpl_2634;
assign Tpl_3940[15:8] = Tpl_2636;
assign Tpl_3940[23:16] = Tpl_2638;
assign Tpl_3940[31:24] = Tpl_2640;
assign Tpl_3941[7:0] = Tpl_2642;
assign Tpl_3941[15:8] = Tpl_2644;
assign Tpl_3941[23:16] = Tpl_2646;
assign Tpl_3941[31:24] = Tpl_2648;
assign Tpl_3942[7:0] = Tpl_2650;
assign Tpl_3942[15:8] = Tpl_2652;
assign Tpl_3942[23:16] = Tpl_2654;
assign Tpl_3942[31:24] = Tpl_2656;
assign Tpl_3943[7:0] = Tpl_2658;
assign Tpl_3943[15:8] = Tpl_2660;
assign Tpl_3943[23:16] = Tpl_2662;
assign Tpl_3943[31:24] = Tpl_2664;
assign Tpl_3944[7:0] = Tpl_2666;
assign Tpl_3944[15:8] = Tpl_2668;
assign Tpl_3944[23:16] = Tpl_2670;
assign Tpl_3944[31:24] = Tpl_2672;
assign Tpl_3945[7:0] = Tpl_2674;
assign Tpl_3945[15:8] = Tpl_2676;
assign Tpl_3945[23:16] = Tpl_2678;
assign Tpl_3945[31:24] = Tpl_2680;
assign Tpl_3946[7:0] = Tpl_2682;
assign Tpl_3946[15:8] = Tpl_2684;
assign Tpl_3946[23:16] = Tpl_2686;
assign Tpl_3946[31:24] = Tpl_2688;
assign Tpl_3947[3:0] = Tpl_2690;
assign Tpl_3947[7:4] = Tpl_2692;
assign Tpl_3947[11:8] = Tpl_2694;
assign Tpl_3947[15:12] = Tpl_2696;
assign Tpl_3947[31:16] = Tpl_2698;
assign Tpl_3948[6:0] = Tpl_2699;
assign Tpl_3948[13:7] = Tpl_2700;
assign Tpl_3948[20:14] = Tpl_2701;
assign Tpl_3948[27:21] = Tpl_2702;
assign Tpl_3948[28] = Tpl_2703;
assign Tpl_3948[31:29] = 3'h0;
assign Tpl_3949[19:0] = Tpl_2705;
assign Tpl_3949[31:20] = 12'h000;
assign Tpl_3950[19:0] = Tpl_2706;
assign Tpl_3950[31:20] = 12'h000;
assign Tpl_3951[5:0] = Tpl_2707;
assign Tpl_3951[10:6] = Tpl_2708;
assign Tpl_3951[15:11] = Tpl_2709;
assign Tpl_3951[22:16] = Tpl_2710;
assign Tpl_3951[30:23] = Tpl_2711;
assign Tpl_3951[31] = '0;
assign Tpl_3952[5:0] = Tpl_2712;
assign Tpl_3952[13:6] = Tpl_2713;
assign Tpl_3952[21:14] = Tpl_2714;
assign Tpl_3952[29:22] = Tpl_2715;
assign Tpl_3952[31:30] = 2'h0;
assign Tpl_3953[5:0] = Tpl_2716;
assign Tpl_3953[11:6] = Tpl_2717;
assign Tpl_3953[19:12] = Tpl_2718;
assign Tpl_3953[27:20] = Tpl_2719;
assign Tpl_3953[31:28] = Tpl_2720;
assign Tpl_3954[4:0] = Tpl_2721;
assign Tpl_3954[14:5] = Tpl_2722;
assign Tpl_3954[22:15] = Tpl_2723;
assign Tpl_3954[28:23] = Tpl_2724;
assign Tpl_3954[31:29] = 3'h0;
assign Tpl_3955[27:0] = Tpl_2725;
assign Tpl_3955[31:28] = 4'h0;
assign Tpl_3956[19:0] = Tpl_2726;
assign Tpl_3956[30:20] = Tpl_2727;
assign Tpl_3956[31] = '0;
assign Tpl_3957[7:0] = Tpl_2728;
assign Tpl_3957[15:8] = Tpl_2729;
assign Tpl_3957[21:16] = Tpl_2730;
assign Tpl_3957[28:22] = Tpl_2731;
assign Tpl_3957[31:29] = 3'h0;
assign Tpl_3958[4:0] = Tpl_2732;
assign Tpl_3958[14:5] = Tpl_2733;
assign Tpl_3958[22:15] = Tpl_2734;
assign Tpl_3958[30:23] = Tpl_2735;
assign Tpl_3958[31] = '0;
assign Tpl_3959[10:0] = Tpl_2736;
assign Tpl_3959[24:11] = Tpl_2737;
assign Tpl_3959[26:25] = Tpl_2738;
assign Tpl_3959[31:27] = 5'h00;
assign Tpl_3960[19:0] = Tpl_2739;
assign Tpl_3960[27:20] = Tpl_2740;
assign Tpl_3960[31:28] = 4'h0;
assign Tpl_3961[19:0] = Tpl_2741;
assign Tpl_3961[27:20] = Tpl_2742;
assign Tpl_3961[31:28] = 4'h0;
assign Tpl_3962[7:0] = Tpl_2743;
assign Tpl_3962[15:8] = Tpl_2744;
assign Tpl_3962[23:16] = Tpl_2745;
assign Tpl_3962[31:24] = Tpl_2746;
assign Tpl_3963[9:0] = Tpl_2747;
assign Tpl_3963[15:10] = Tpl_2748;
assign Tpl_3963[31:16] = 16'h0000;
assign Tpl_3964[19:0] = Tpl_2749;
assign Tpl_3964[24:20] = Tpl_2750;
assign Tpl_3964[31:25] = Tpl_2751;
assign Tpl_3965[5:0] = Tpl_2752;
assign Tpl_3965[13:6] = Tpl_2753;
assign Tpl_3965[18:14] = Tpl_2754;
assign Tpl_3965[28:19] = Tpl_2755;
assign Tpl_3965[31:29] = 3'h0;
assign Tpl_3966[5:0] = Tpl_2756;
assign Tpl_3966[10:6] = Tpl_2757;
assign Tpl_3966[16:11] = Tpl_2758;
assign Tpl_3966[30:17] = Tpl_2759;
assign Tpl_3966[31] = '0;
assign Tpl_3967[2:0] = Tpl_2760;
assign Tpl_3967[8:3] = Tpl_2761;
assign Tpl_3967[24:9] = Tpl_2762;
assign Tpl_3967[31:25] = Tpl_2763;
assign Tpl_3968[9:0] = Tpl_2764;
assign Tpl_3968[19:10] = Tpl_2765;
assign Tpl_3968[31:20] = 12'h000;
assign Tpl_3969[9:0] = Tpl_2766;
assign Tpl_3969[19:10] = Tpl_2767;
assign Tpl_3969[31:20] = 12'h000;
assign Tpl_3970[9:0] = Tpl_2768;
assign Tpl_3970[19:10] = Tpl_2769;
assign Tpl_3970[31:20] = 12'h000;
assign Tpl_3971[6:0] = Tpl_2770;
assign Tpl_3971[13:7] = Tpl_2771;
assign Tpl_3971[20:14] = Tpl_2772;
assign Tpl_3971[31:21] = Tpl_2773;
assign Tpl_3972[7:0] = Tpl_2774;
assign Tpl_3972[15:8] = Tpl_2775;
assign Tpl_3972[23:16] = Tpl_2776;
assign Tpl_3972[31:24] = 8'h00;
assign Tpl_3973[11:0] = Tpl_2777;
assign Tpl_3973[21:12] = Tpl_2778;
assign Tpl_3973[31:22] = 10'h000;
assign Tpl_3974[10:0] = Tpl_2779;
assign Tpl_3974[15:11] = Tpl_2780;
assign Tpl_3974[31:16] = 16'h0000;
assign Tpl_3975[4:0] = Tpl_2781;
assign Tpl_3975[10:5] = Tpl_2782;
assign Tpl_3975[15:11] = Tpl_2783;
assign Tpl_3975[19:16] = Tpl_2784;
assign Tpl_3975[31:20] = 12'h000;
assign Tpl_3976[7:0] = Tpl_2785;
assign Tpl_3976[15:8] = Tpl_2786;
assign Tpl_3976[27:16] = Tpl_2787;
assign Tpl_3976[31:28] = 4'h0;
assign Tpl_3977[7:0] = Tpl_2788;
assign Tpl_3977[15:8] = Tpl_2789;
assign Tpl_3977[23:16] = Tpl_2790;
assign Tpl_3977[31:24] = Tpl_2791;
assign Tpl_3978[7:0] = Tpl_2792;
assign Tpl_3978[15:8] = Tpl_2793;
assign Tpl_3978[31:16] = 16'h0000;
assign Tpl_3979[4:0] = Tpl_2794;
assign Tpl_3979[9:5] = Tpl_2795;
assign Tpl_3979[16:10] = Tpl_2796;
assign Tpl_3979[18:17] = Tpl_2797;
assign Tpl_3979[31:19] = 13'h0000;
assign Tpl_3980[4:0] = Tpl_2798;
assign Tpl_3980[14:5] = Tpl_2799;
assign Tpl_3980[18:15] = Tpl_2800;
assign Tpl_3980[24:19] = Tpl_2801;
assign Tpl_3980[30:25] = Tpl_2802;
assign Tpl_3980[31] = '0;
assign Tpl_3981[27:0] = Tpl_2803;
assign Tpl_3981[31:28] = Tpl_2804;
assign Tpl_3982[7:0] = Tpl_2805;
assign Tpl_3982[25:8] = Tpl_2806;
assign Tpl_3982[28:26] = Tpl_2807;
assign Tpl_3982[31:29] = 3'h0;
assign Tpl_3983[6:0] = Tpl_2808;
assign Tpl_3983[16:7] = Tpl_2809;
assign Tpl_3983[30:17] = Tpl_2810;
assign Tpl_3983[31] = '0;
assign Tpl_3984[8:0] = Tpl_2811;
assign Tpl_3984[16:9] = Tpl_2812;
assign Tpl_3984[24:17] = Tpl_2813;
assign Tpl_3984[30:25] = Tpl_2814;
assign Tpl_3984[31] = '0;
assign Tpl_3985[7:0] = Tpl_2815;
assign Tpl_3985[11:8] = Tpl_2816;
assign Tpl_3985[15:12] = Tpl_2817;
assign Tpl_3985[29:16] = Tpl_2818;
assign Tpl_3985[31:30] = 2'h0;
assign Tpl_3986[10:0] = Tpl_2819;
assign Tpl_3986[18:11] = Tpl_2820;
assign Tpl_3986[22:19] = Tpl_2821;
assign Tpl_3986[31:23] = 9'h000;
assign Tpl_3987[0] = Tpl_2822;
assign Tpl_3987[1] = Tpl_2823;
assign Tpl_3987[5:2] = Tpl_2824;
assign Tpl_3987[9:6] = Tpl_2825;
assign Tpl_3987[12:10] = Tpl_2826;
assign Tpl_3987[15:13] = Tpl_2827;
assign Tpl_3987[19:16] = Tpl_2828;
assign Tpl_3987[23:20] = Tpl_2829;
assign Tpl_3987[27:24] = Tpl_2830;
assign Tpl_3987[28] = Tpl_2831;
assign Tpl_3987[31:29] = 3'h0;
assign Tpl_3988[0] = Tpl_2832;
assign Tpl_3988[1] = Tpl_2833;
assign Tpl_3988[5:2] = Tpl_2834;
assign Tpl_3988[9:6] = Tpl_2835;
assign Tpl_3988[12:10] = Tpl_2836;
assign Tpl_3988[15:13] = Tpl_2837;
assign Tpl_3988[19:16] = Tpl_2838;
assign Tpl_3988[23:20] = Tpl_2839;
assign Tpl_3988[27:24] = Tpl_2840;
assign Tpl_3988[28] = Tpl_2841;
assign Tpl_3988[31:29] = 3'h0;
assign Tpl_3989[16:0] = Tpl_2842;
assign Tpl_3989[27:17] = Tpl_2843;
assign Tpl_3989[31:28] = 4'h0;
assign Tpl_3990[16:0] = Tpl_2844;
assign Tpl_3990[27:17] = Tpl_2845;
assign Tpl_3990[31:28] = 4'h0;
assign Tpl_3991[16:0] = Tpl_2846;
assign Tpl_3991[27:17] = Tpl_2847;
assign Tpl_3991[31:28] = 4'h0;
assign Tpl_3992[16:0] = Tpl_2848;
assign Tpl_3992[27:17] = Tpl_2849;
assign Tpl_3992[31:28] = 4'h0;
assign Tpl_3993[31:0] = Tpl_2850;
assign Tpl_3994[31:0] = Tpl_2851;
assign Tpl_3995[31:0] = Tpl_2852;
assign Tpl_3996[31:0] = Tpl_2853;
assign Tpl_3997[31:0] = Tpl_2854;
assign Tpl_3998[31:0] = Tpl_2855;
assign Tpl_3999[31:0] = Tpl_2856;
assign Tpl_4000[31:0] = Tpl_2857;
assign Tpl_4001[31:0] = Tpl_2858;
assign Tpl_4002[31:0] = Tpl_2859;
assign Tpl_4003[31:0] = Tpl_2860;
assign Tpl_4004[31:0] = Tpl_2861;
assign Tpl_4005[31:0] = Tpl_2862;
assign Tpl_4006[31:0] = Tpl_2863;
assign Tpl_4007[31:0] = Tpl_2864;
assign Tpl_4008[31:0] = Tpl_2865;
assign Tpl_4009[31:0] = Tpl_2866;
assign Tpl_4010[31:0] = Tpl_2867;
assign Tpl_4011[31:0] = Tpl_2868;
assign Tpl_4012[31:0] = Tpl_2869;
assign Tpl_4013[31:0] = Tpl_2870;
assign Tpl_4014[31:0] = Tpl_2871;
assign Tpl_4015[31:0] = Tpl_2872;
assign Tpl_4016[31:0] = Tpl_2873;
assign Tpl_4017[31:0] = Tpl_2874;
assign Tpl_4018[31:0] = Tpl_2875;
assign Tpl_4019[31:0] = Tpl_2876;
assign Tpl_4020[31:0] = Tpl_2877;
assign Tpl_4021[31:0] = Tpl_2878;
assign Tpl_4022[31:0] = Tpl_2879;
assign Tpl_4023[31:0] = Tpl_2880;
assign Tpl_4024[31:0] = Tpl_2881;
assign Tpl_4025[1:0] = Tpl_2882;
assign Tpl_4025[5:2] = Tpl_2883;
assign Tpl_4025[31:6] = 26'h0000000;
assign Tpl_4026[1:0] = Tpl_2884;
assign Tpl_4026[5:2] = Tpl_2885;
assign Tpl_4026[9:6] = Tpl_2886;
assign Tpl_4026[31:10] = 22'h000000;
assign Tpl_4027[31:0] = Tpl_2887;
assign Tpl_4028[29:0] = Tpl_2888;
assign Tpl_4028[31:30] = 2'h0;
assign Tpl_4029[1:0] = Tpl_2889;
assign Tpl_4029[5:2] = Tpl_2890;
assign Tpl_4029[9:6] = Tpl_2891;
assign Tpl_4029[31:10] = 22'h000000;
assign Tpl_4030[31:0] = Tpl_2892;
assign Tpl_4031[29:0] = Tpl_2893;
assign Tpl_4031[31:30] = 2'h0;
assign Tpl_4032[15:0] = Tpl_3612;
assign Tpl_4032[31:16] = 16'h0000;
assign Tpl_4033[1:0] = Tpl_3613;
assign Tpl_4033[3:2] = Tpl_3614;
assign Tpl_4033[31:4] = 28'h0000000;
assign Tpl_4034[0] = Tpl_3615;
assign Tpl_4034[1] = Tpl_3616;
assign Tpl_4034[17:2] = Tpl_3617;
assign Tpl_4034[18] = Tpl_3618;
assign Tpl_4034[19] = Tpl_3619;
assign Tpl_4034[20] = Tpl_3620;
assign Tpl_4034[21] = Tpl_3621;
assign Tpl_4034[31:22] = 10'h000;
assign Tpl_4035[0] = Tpl_3622;
assign Tpl_4035[1] = Tpl_3623;
assign Tpl_4035[17:2] = Tpl_3624;
assign Tpl_4035[18] = Tpl_3625;
assign Tpl_4035[19] = Tpl_3626;
assign Tpl_4035[20] = Tpl_3627;
assign Tpl_4035[21] = Tpl_3628;
assign Tpl_4035[31:22] = 10'h000;
assign Tpl_4036[0] = Tpl_3629;
assign Tpl_4036[31:1] = 31'h00000000;
assign Tpl_4037[0] = Tpl_3630;
assign Tpl_4037[31:1] = 31'h00000000;
assign Tpl_4038[0] = Tpl_3631;
assign Tpl_4038[1] = Tpl_3632;
assign Tpl_4038[2] = Tpl_3633;
assign Tpl_4038[3] = Tpl_3634;
assign Tpl_4038[7:4] = Tpl_3635;
assign Tpl_4038[24:8] = Tpl_3636;
assign Tpl_4038[31:25] = 7'h00;
assign Tpl_4039[0] = Tpl_3637;
assign Tpl_4039[1] = Tpl_3638;
assign Tpl_4039[2] = Tpl_3639;
assign Tpl_4039[3] = Tpl_3640;
assign Tpl_4039[7:4] = Tpl_3641;
assign Tpl_4039[24:8] = Tpl_3642;
assign Tpl_4039[31:25] = 7'h00;
assign Tpl_4040[0] = Tpl_3643;
assign Tpl_4040[1] = Tpl_3644;
assign Tpl_4040[2] = Tpl_3645;
assign Tpl_4040[3] = Tpl_3646;
assign Tpl_4040[4] = Tpl_3647;
assign Tpl_4040[5] = Tpl_3648;
assign Tpl_4040[6] = Tpl_3649;
assign Tpl_4040[8:7] = Tpl_3650;
assign Tpl_4040[10:9] = Tpl_3651;
assign Tpl_4040[12:11] = Tpl_3652;
assign Tpl_4040[14:13] = Tpl_3653;
assign Tpl_4040[16:15] = Tpl_3654;
assign Tpl_4040[18:17] = Tpl_3655;
assign Tpl_4040[19] = Tpl_3656;
assign Tpl_4040[20] = Tpl_3657;
assign Tpl_4040[21] = Tpl_3658;
assign Tpl_4040[22] = Tpl_3659;
assign Tpl_4040[23] = Tpl_3660;
assign Tpl_4040[25:24] = Tpl_3661;
assign Tpl_4040[31:26] = 6'h00;
assign Tpl_4041[3:0] = Tpl_3662;
assign Tpl_4041[5:4] = Tpl_3663;
assign Tpl_4041[9:6] = Tpl_3664;
assign Tpl_4041[13:10] = Tpl_3665;
assign Tpl_4041[17:14] = Tpl_3666;
assign Tpl_4041[21:18] = Tpl_3667;
assign Tpl_4041[27:22] = Tpl_3668;
assign Tpl_4041[31:28] = Tpl_3669;
assign Tpl_4042[3:0] = Tpl_3670;
assign Tpl_4042[7:4] = Tpl_3671;
assign Tpl_4042[11:8] = Tpl_3672;
assign Tpl_4042[15:12] = Tpl_3673;
assign Tpl_4042[31:16] = 16'h0000;
assign Tpl_4043[31:0] = Tpl_3674;
assign Tpl_4044[31:0] = Tpl_3675;
assign Tpl_4045[3:0] = Tpl_3676;
assign Tpl_4045[5:4] = Tpl_3677;
assign Tpl_4045[9:6] = Tpl_3678;
assign Tpl_4045[13:10] = Tpl_3679;
assign Tpl_4045[17:14] = Tpl_3680;
assign Tpl_4045[21:18] = Tpl_3681;
assign Tpl_4045[31:22] = 10'h000;
assign Tpl_4046[31:0] = Tpl_3682;
assign Tpl_4047[31:0] = Tpl_3683;
assign Tpl_4048[1:0] = Tpl_3684;
assign Tpl_4048[3:2] = Tpl_3685;
assign Tpl_4048[5:4] = Tpl_3686;
assign Tpl_4048[31:6] = 26'h0000000;
assign Tpl_4049[3:0] = Tpl_3687;
assign Tpl_4049[7:4] = Tpl_3688;
assign Tpl_4049[11:8] = Tpl_3689;
assign Tpl_4049[31:12] = 20'h00000;
assign Tpl_4050[0] = Tpl_3690;
assign Tpl_4050[30:1] = Tpl_3691;
assign Tpl_4050[31] = '0;
assign Tpl_4051[31:0] = Tpl_3692;
assign Tpl_4052[3:0] = Tpl_3693;
assign Tpl_4052[31:4] = 28'h0000000;
assign Tpl_4053[0] = Tpl_3694;
assign Tpl_4053[1] = Tpl_3695;
assign Tpl_4053[5:2] = Tpl_3696;
assign Tpl_4053[9:6] = Tpl_3697;
assign Tpl_4053[31:10] = 22'h000000;
assign Tpl_4054[0] = Tpl_3698;
assign Tpl_4054[8:1] = Tpl_3699;
assign Tpl_4054[31:9] = 23'h000000;
assign Tpl_4055[0] = Tpl_3700;
assign Tpl_4055[8:1] = Tpl_3701;
assign Tpl_4055[31:9] = 23'h000000;
assign Tpl_4056[0] = Tpl_3702;
assign Tpl_4056[8:1] = Tpl_3703;
assign Tpl_4056[31:9] = 23'h000000;
assign Tpl_4057[1:0] = Tpl_3704;
assign Tpl_4057[2] = Tpl_3705;
assign Tpl_4057[3] = Tpl_3706;
assign Tpl_4057[6:4] = Tpl_3707;
assign Tpl_4057[7] = Tpl_3708;
assign Tpl_4057[9:8] = Tpl_3709;
assign Tpl_4057[10] = Tpl_3710;
assign Tpl_4057[11] = Tpl_3711;
assign Tpl_4057[14:12] = Tpl_3712;
assign Tpl_4057[15] = Tpl_3713;
assign Tpl_4057[31:16] = 16'h0000;
assign Tpl_4058[2:0] = Tpl_3714;
assign Tpl_4058[5:3] = Tpl_3715;
assign Tpl_4058[6] = Tpl_3716;
assign Tpl_4058[7] = Tpl_3717;
assign Tpl_4058[10:8] = Tpl_3718;
assign Tpl_4058[13:11] = Tpl_3719;
assign Tpl_4058[14] = Tpl_3720;
assign Tpl_4058[15] = Tpl_3721;
assign Tpl_4058[31:16] = 16'h0000;
assign Tpl_4059[0] = Tpl_3722;
assign Tpl_4059[1] = Tpl_3723;
assign Tpl_4059[2] = Tpl_3724;
assign Tpl_4059[5:3] = Tpl_3725;
assign Tpl_4059[6] = Tpl_3726;
assign Tpl_4059[7] = Tpl_3727;
assign Tpl_4059[8] = Tpl_3728;
assign Tpl_4059[9] = Tpl_3729;
assign Tpl_4059[10] = Tpl_3730;
assign Tpl_4059[13:11] = Tpl_3731;
assign Tpl_4059[14] = Tpl_3732;
assign Tpl_4059[15] = Tpl_3733;
assign Tpl_4059[31:16] = 16'h0000;
assign Tpl_4060[2:0] = Tpl_3734;
assign Tpl_4060[3] = Tpl_3735;
assign Tpl_4060[6:4] = Tpl_3736;
assign Tpl_4060[7] = Tpl_3737;
assign Tpl_4060[10:8] = Tpl_3738;
assign Tpl_4060[11] = Tpl_3739;
assign Tpl_4060[14:12] = Tpl_3740;
assign Tpl_4060[15] = Tpl_3741;
assign Tpl_4060[31:16] = 16'h0000;
assign Tpl_4061[2:0] = Tpl_3742;
assign Tpl_4061[3] = Tpl_3743;
assign Tpl_4061[6:4] = Tpl_3744;
assign Tpl_4061[7] = Tpl_3745;
assign Tpl_4061[10:8] = Tpl_3746;
assign Tpl_4061[11] = Tpl_3747;
assign Tpl_4061[14:12] = Tpl_3748;
assign Tpl_4061[15] = Tpl_3749;
assign Tpl_4061[31:16] = 16'h0000;
assign Tpl_4062[5:0] = Tpl_3750;
assign Tpl_4062[6] = Tpl_3751;
assign Tpl_4062[7] = Tpl_3752;
assign Tpl_4062[13:8] = Tpl_3753;
assign Tpl_4062[14] = Tpl_3754;
assign Tpl_4062[15] = Tpl_3755;
assign Tpl_4062[31:16] = 16'h0000;
assign Tpl_4063[0] = Tpl_3756;
assign Tpl_4063[1] = Tpl_3757;
assign Tpl_4063[2] = Tpl_3758;
assign Tpl_4063[3] = Tpl_3759;
assign Tpl_4063[4] = Tpl_3760;
assign Tpl_4063[5] = Tpl_3761;
assign Tpl_4063[6] = Tpl_3762;
assign Tpl_4063[7] = Tpl_3763;
assign Tpl_4063[31:8] = 24'h000000;
assign Tpl_4064[5:0] = Tpl_3764;
assign Tpl_4064[6] = Tpl_3765;
assign Tpl_4064[7] = Tpl_3766;
assign Tpl_4064[13:8] = Tpl_3767;
assign Tpl_4064[14] = Tpl_3768;
assign Tpl_4064[15] = Tpl_3769;
assign Tpl_4064[31:16] = 16'h0000;
assign Tpl_4065[2:0] = Tpl_3770;
assign Tpl_4065[3] = Tpl_3771;
assign Tpl_4065[4] = Tpl_3772;
assign Tpl_4065[5] = Tpl_3773;
assign Tpl_4065[7:6] = Tpl_3774;
assign Tpl_4065[10:8] = Tpl_3775;
assign Tpl_4065[11] = Tpl_3776;
assign Tpl_4065[12] = Tpl_3777;
assign Tpl_4065[13] = Tpl_3778;
assign Tpl_4065[15:14] = Tpl_3779;
assign Tpl_4065[31:16] = 16'h0000;
assign Tpl_4066[2:0] = Tpl_3780;
assign Tpl_4066[3] = Tpl_3781;
assign Tpl_4066[4] = Tpl_3782;
assign Tpl_4066[5] = Tpl_3783;
assign Tpl_4066[7:6] = Tpl_3784;
assign Tpl_4066[10:8] = Tpl_3785;
assign Tpl_4066[11] = Tpl_3786;
assign Tpl_4066[12] = Tpl_3787;
assign Tpl_4066[13] = Tpl_3788;
assign Tpl_4066[15:14] = Tpl_3789;
assign Tpl_4066[31:16] = 16'h0000;
assign Tpl_4067[31:0] = Tpl_3790;
assign Tpl_4068[31:0] = Tpl_3791;
assign Tpl_4069[31:0] = Tpl_3792;
assign Tpl_4070[31:0] = Tpl_3793;
assign Tpl_4071[31:0] = Tpl_3794;
assign Tpl_4072[31:0] = Tpl_3795;
assign Tpl_4073[31:0] = Tpl_3796;
assign Tpl_4074[31:0] = Tpl_3797;
assign Tpl_4075[31:0] = Tpl_3798;
assign Tpl_4076[31:0] = Tpl_3799;
assign Tpl_4077[31:0] = Tpl_3800;
assign Tpl_4078[31:0] = Tpl_3801;
assign Tpl_4079[31:0] = Tpl_3802;
assign Tpl_4080[31:0] = Tpl_3803;
assign Tpl_4081[31:0] = Tpl_3804;
assign Tpl_4082[31:0] = Tpl_3805;
assign Tpl_4083[0] = Tpl_3806;
assign Tpl_4083[31:1] = 31'h00000000;

always @(*)
begin: READ_DATA_PROC_3581
Tpl_3099 = 0;
case (1'b1)
Tpl_3110: Tpl_3099 = Tpl_3807;
Tpl_3112: Tpl_3099 = Tpl_3808;
Tpl_3114: Tpl_3099 = Tpl_3809;
Tpl_3116: Tpl_3099 = Tpl_3810;
Tpl_3118: Tpl_3099 = Tpl_3811;
Tpl_3120: Tpl_3099 = Tpl_3812;
Tpl_3122: Tpl_3099 = Tpl_3813;
Tpl_3124: Tpl_3099 = Tpl_3814;
Tpl_3126: Tpl_3099 = Tpl_3815;
Tpl_3128: Tpl_3099 = Tpl_3816;
Tpl_3130: Tpl_3099 = Tpl_3817;
Tpl_3132: Tpl_3099 = Tpl_3818;
Tpl_3134: Tpl_3099 = Tpl_3819;
Tpl_3136: Tpl_3099 = Tpl_3820;
Tpl_3138: Tpl_3099 = Tpl_3821;
Tpl_3140: Tpl_3099 = Tpl_3822;
Tpl_3142: Tpl_3099 = Tpl_3823;
Tpl_3144: Tpl_3099 = Tpl_3824;
Tpl_3146: Tpl_3099 = Tpl_3825;
Tpl_3148: Tpl_3099 = Tpl_3826;
Tpl_3150: Tpl_3099 = Tpl_3827;
Tpl_3152: Tpl_3099 = Tpl_3828;
Tpl_3154: Tpl_3099 = Tpl_3829;
Tpl_3156: Tpl_3099 = Tpl_3830;
Tpl_3158: Tpl_3099 = Tpl_3831;
Tpl_3160: Tpl_3099 = Tpl_3832;
Tpl_3162: Tpl_3099 = Tpl_3833;
Tpl_3164: Tpl_3099 = Tpl_3834;
Tpl_3166: Tpl_3099 = Tpl_3835;
Tpl_3168: Tpl_3099 = Tpl_3836;
Tpl_3170: Tpl_3099 = Tpl_3837;
Tpl_3172: Tpl_3099 = Tpl_3838;
Tpl_3174: Tpl_3099 = Tpl_3839;
Tpl_3176: Tpl_3099 = Tpl_3840;
Tpl_3178: Tpl_3099 = Tpl_3841;
Tpl_3180: Tpl_3099 = Tpl_3842;
Tpl_3182: Tpl_3099 = Tpl_3843;
Tpl_3184: Tpl_3099 = Tpl_3844;
Tpl_3186: Tpl_3099 = Tpl_3845;
Tpl_3188: Tpl_3099 = Tpl_3846;
Tpl_3190: Tpl_3099 = Tpl_3847;
Tpl_3192: Tpl_3099 = Tpl_3848;
Tpl_3194: Tpl_3099 = Tpl_3849;
Tpl_3196: Tpl_3099 = Tpl_3850;
Tpl_3198: Tpl_3099 = Tpl_3851;
Tpl_3200: Tpl_3099 = Tpl_3852;
Tpl_3202: Tpl_3099 = Tpl_3853;
Tpl_3204: Tpl_3099 = Tpl_3854;
Tpl_3206: Tpl_3099 = Tpl_3855;
Tpl_3208: Tpl_3099 = Tpl_3856;
Tpl_3210: Tpl_3099 = Tpl_3857;
Tpl_3212: Tpl_3099 = Tpl_3858;
Tpl_3214: Tpl_3099 = Tpl_3859;
Tpl_3216: Tpl_3099 = Tpl_3860;
Tpl_3218: Tpl_3099 = Tpl_3861;
Tpl_3220: Tpl_3099 = Tpl_3862;
Tpl_3222: Tpl_3099 = Tpl_3863;
Tpl_3224: Tpl_3099 = Tpl_3864;
Tpl_3226: Tpl_3099 = Tpl_3865;
Tpl_3228: Tpl_3099 = Tpl_3866;
Tpl_3230: Tpl_3099 = Tpl_3867;
Tpl_3232: Tpl_3099 = Tpl_3868;
Tpl_3234: Tpl_3099 = Tpl_3869;
Tpl_3236: Tpl_3099 = Tpl_3870;
Tpl_3238: Tpl_3099 = Tpl_3871;
Tpl_3240: Tpl_3099 = Tpl_3872;
Tpl_3242: Tpl_3099 = Tpl_3873;
Tpl_3244: Tpl_3099 = Tpl_3874;
Tpl_3246: Tpl_3099 = Tpl_3875;
Tpl_3248: Tpl_3099 = Tpl_3876;
Tpl_3250: Tpl_3099 = Tpl_3877;
Tpl_3252: Tpl_3099 = Tpl_3878;
Tpl_3254: Tpl_3099 = Tpl_3879;
Tpl_3256: Tpl_3099 = Tpl_3880;
Tpl_3258: Tpl_3099 = Tpl_3881;
Tpl_3260: Tpl_3099 = Tpl_3882;
Tpl_3262: Tpl_3099 = Tpl_3883;
Tpl_3264: Tpl_3099 = Tpl_3884;
Tpl_3266: Tpl_3099 = Tpl_3885;
Tpl_3268: Tpl_3099 = Tpl_3886;
Tpl_3270: Tpl_3099 = Tpl_3887;
Tpl_3272: Tpl_3099 = Tpl_3888;
Tpl_3274: Tpl_3099 = Tpl_3889;
Tpl_3276: Tpl_3099 = Tpl_3890;
Tpl_3278: Tpl_3099 = Tpl_3891;
Tpl_3280: Tpl_3099 = Tpl_3892;
Tpl_3282: Tpl_3099 = Tpl_3893;
Tpl_3284: Tpl_3099 = Tpl_3894;
Tpl_3286: Tpl_3099 = Tpl_3895;
Tpl_3288: Tpl_3099 = Tpl_3896;
Tpl_3290: Tpl_3099 = Tpl_3897;
Tpl_3292: Tpl_3099 = Tpl_3898;
Tpl_3294: Tpl_3099 = Tpl_3899;
Tpl_3296: Tpl_3099 = Tpl_3900;
Tpl_3298: Tpl_3099 = Tpl_3901;
Tpl_3300: Tpl_3099 = Tpl_3902;
Tpl_3302: Tpl_3099 = Tpl_3903;
Tpl_3304: Tpl_3099 = Tpl_3904;
Tpl_3306: Tpl_3099 = Tpl_3905;
Tpl_3308: Tpl_3099 = Tpl_3906;
Tpl_3310: Tpl_3099 = Tpl_3907;
Tpl_3312: Tpl_3099 = Tpl_3908;
Tpl_3314: Tpl_3099 = Tpl_3909;
Tpl_3316: Tpl_3099 = Tpl_3910;
Tpl_3318: Tpl_3099 = Tpl_3911;
Tpl_3320: Tpl_3099 = Tpl_3912;
Tpl_3322: Tpl_3099 = Tpl_3913;
Tpl_3324: Tpl_3099 = Tpl_3914;
Tpl_3326: Tpl_3099 = Tpl_3915;
Tpl_3328: Tpl_3099 = Tpl_3916;
Tpl_3330: Tpl_3099 = Tpl_3917;
Tpl_3332: Tpl_3099 = Tpl_3918;
Tpl_3334: Tpl_3099 = Tpl_3919;
Tpl_3336: Tpl_3099 = Tpl_3920;
Tpl_3338: Tpl_3099 = Tpl_3921;
Tpl_3340: Tpl_3099 = Tpl_3922;
Tpl_3342: Tpl_3099 = Tpl_3923;
Tpl_3344: Tpl_3099 = Tpl_3924;
Tpl_3346: Tpl_3099 = Tpl_3925;
Tpl_3348: Tpl_3099 = Tpl_3926;
Tpl_3350: Tpl_3099 = Tpl_3927;
Tpl_3352: Tpl_3099 = Tpl_3928;
Tpl_3354: Tpl_3099 = Tpl_3929;
Tpl_3356: Tpl_3099 = Tpl_3930;
Tpl_3358: Tpl_3099 = Tpl_3931;
Tpl_3360: Tpl_3099 = Tpl_3932;
Tpl_3362: Tpl_3099 = Tpl_3933;
Tpl_3364: Tpl_3099 = Tpl_3934;
Tpl_3366: Tpl_3099 = Tpl_3935;
Tpl_3368: Tpl_3099 = Tpl_3936;
Tpl_3370: Tpl_3099 = Tpl_3937;
Tpl_3372: Tpl_3099 = Tpl_3938;
Tpl_3374: Tpl_3099 = Tpl_3939;
Tpl_3376: Tpl_3099 = Tpl_3940;
Tpl_3378: Tpl_3099 = Tpl_3941;
Tpl_3380: Tpl_3099 = Tpl_3942;
Tpl_3382: Tpl_3099 = Tpl_3943;
Tpl_3384: Tpl_3099 = Tpl_3944;
Tpl_3386: Tpl_3099 = Tpl_3945;
Tpl_3388: Tpl_3099 = Tpl_3946;
Tpl_3390: Tpl_3099 = Tpl_3947;
Tpl_3392: Tpl_3099 = Tpl_3948;
Tpl_3394: Tpl_3099 = Tpl_3949;
Tpl_3396: Tpl_3099 = Tpl_3950;
Tpl_3398: Tpl_3099 = Tpl_3951;
Tpl_3400: Tpl_3099 = Tpl_3952;
Tpl_3402: Tpl_3099 = Tpl_3953;
Tpl_3404: Tpl_3099 = Tpl_3954;
Tpl_3406: Tpl_3099 = Tpl_3955;
Tpl_3408: Tpl_3099 = Tpl_3956;
Tpl_3410: Tpl_3099 = Tpl_3957;
Tpl_3412: Tpl_3099 = Tpl_3958;
Tpl_3414: Tpl_3099 = Tpl_3959;
Tpl_3416: Tpl_3099 = Tpl_3960;
Tpl_3418: Tpl_3099 = Tpl_3961;
Tpl_3420: Tpl_3099 = Tpl_3962;
Tpl_3422: Tpl_3099 = Tpl_3963;
Tpl_3424: Tpl_3099 = Tpl_3964;
Tpl_3426: Tpl_3099 = Tpl_3965;
Tpl_3428: Tpl_3099 = Tpl_3966;
Tpl_3430: Tpl_3099 = Tpl_3967;
Tpl_3432: Tpl_3099 = Tpl_3968;
Tpl_3434: Tpl_3099 = Tpl_3969;
Tpl_3436: Tpl_3099 = Tpl_3970;
Tpl_3438: Tpl_3099 = Tpl_3971;
Tpl_3440: Tpl_3099 = Tpl_3972;
Tpl_3442: Tpl_3099 = Tpl_3973;
Tpl_3444: Tpl_3099 = Tpl_3974;
Tpl_3446: Tpl_3099 = Tpl_3975;
Tpl_3448: Tpl_3099 = Tpl_3976;
Tpl_3450: Tpl_3099 = Tpl_3977;
Tpl_3452: Tpl_3099 = Tpl_3978;
Tpl_3454: Tpl_3099 = Tpl_3979;
Tpl_3456: Tpl_3099 = Tpl_3980;
Tpl_3458: Tpl_3099 = Tpl_3981;
Tpl_3460: Tpl_3099 = Tpl_3982;
Tpl_3462: Tpl_3099 = Tpl_3983;
Tpl_3464: Tpl_3099 = Tpl_3984;
Tpl_3466: Tpl_3099 = Tpl_3985;
Tpl_3468: Tpl_3099 = Tpl_3986;
Tpl_3470: Tpl_3099 = Tpl_3987;
Tpl_3472: Tpl_3099 = Tpl_3988;
Tpl_3474: Tpl_3099 = Tpl_3989;
Tpl_3476: Tpl_3099 = Tpl_3990;
Tpl_3478: Tpl_3099 = Tpl_3991;
Tpl_3480: Tpl_3099 = Tpl_3992;
Tpl_3482: Tpl_3099 = Tpl_3993;
Tpl_3484: Tpl_3099 = Tpl_3994;
Tpl_3486: Tpl_3099 = Tpl_3995;
Tpl_3488: Tpl_3099 = Tpl_3996;
Tpl_3490: Tpl_3099 = Tpl_3997;
Tpl_3492: Tpl_3099 = Tpl_3998;
Tpl_3494: Tpl_3099 = Tpl_3999;
Tpl_3496: Tpl_3099 = Tpl_4000;
Tpl_3498: Tpl_3099 = Tpl_4001;
Tpl_3500: Tpl_3099 = Tpl_4002;
Tpl_3502: Tpl_3099 = Tpl_4003;
Tpl_3504: Tpl_3099 = Tpl_4004;
Tpl_3506: Tpl_3099 = Tpl_4005;
Tpl_3508: Tpl_3099 = Tpl_4006;
Tpl_3510: Tpl_3099 = Tpl_4007;
Tpl_3512: Tpl_3099 = Tpl_4008;
Tpl_3514: Tpl_3099 = Tpl_4009;
Tpl_3516: Tpl_3099 = Tpl_4010;
Tpl_3518: Tpl_3099 = Tpl_4011;
Tpl_3520: Tpl_3099 = Tpl_4012;
Tpl_3522: Tpl_3099 = Tpl_4013;
Tpl_3524: Tpl_3099 = Tpl_4014;
Tpl_3526: Tpl_3099 = Tpl_4015;
Tpl_3528: Tpl_3099 = Tpl_4016;
Tpl_3530: Tpl_3099 = Tpl_4017;
Tpl_3532: Tpl_3099 = Tpl_4018;
Tpl_3534: Tpl_3099 = Tpl_4019;
Tpl_3536: Tpl_3099 = Tpl_4020;
Tpl_3538: Tpl_3099 = Tpl_4021;
Tpl_3540: Tpl_3099 = Tpl_4022;
Tpl_3542: Tpl_3099 = Tpl_4023;
Tpl_3544: Tpl_3099 = Tpl_4024;
Tpl_3546: Tpl_3099 = Tpl_4025;
Tpl_3548: Tpl_3099 = Tpl_4026;
Tpl_3550: Tpl_3099 = Tpl_4027;
Tpl_3552: Tpl_3099 = Tpl_4028;
Tpl_3554: Tpl_3099 = Tpl_4029;
Tpl_3556: Tpl_3099 = Tpl_4030;
Tpl_3558: Tpl_3099 = Tpl_4031;
Tpl_3560: Tpl_3099 = Tpl_4032;
Tpl_3561: Tpl_3099 = Tpl_4033;
Tpl_3562: Tpl_3099 = Tpl_4034;
Tpl_3563: Tpl_3099 = Tpl_4035;
Tpl_3564: Tpl_3099 = Tpl_4036;
Tpl_3565: Tpl_3099 = Tpl_4037;
Tpl_3566: Tpl_3099 = Tpl_4038;
Tpl_3567: Tpl_3099 = Tpl_4039;
Tpl_3568: Tpl_3099 = Tpl_4040;
Tpl_3569: Tpl_3099 = Tpl_4041;
Tpl_3570: Tpl_3099 = Tpl_4042;
Tpl_3571: Tpl_3099 = Tpl_4043;
Tpl_3572: Tpl_3099 = Tpl_4044;
Tpl_3573: Tpl_3099 = Tpl_4045;
Tpl_3574: Tpl_3099 = Tpl_4046;
Tpl_3575: Tpl_3099 = Tpl_4047;
Tpl_3576: Tpl_3099 = Tpl_4048;
Tpl_3577: Tpl_3099 = Tpl_4049;
Tpl_3578: Tpl_3099 = Tpl_4050;
Tpl_3579: Tpl_3099 = Tpl_4051;
Tpl_3580: Tpl_3099 = Tpl_4052;
Tpl_3581: Tpl_3099 = Tpl_4053;
Tpl_3582: Tpl_3099 = Tpl_4054;
Tpl_3583: Tpl_3099 = Tpl_4055;
Tpl_3584: Tpl_3099 = Tpl_4056;
Tpl_3585: Tpl_3099 = Tpl_4057;
Tpl_3586: Tpl_3099 = Tpl_4058;
Tpl_3587: Tpl_3099 = Tpl_4059;
Tpl_3588: Tpl_3099 = Tpl_4060;
Tpl_3589: Tpl_3099 = Tpl_4061;
Tpl_3590: Tpl_3099 = Tpl_4062;
Tpl_3591: Tpl_3099 = Tpl_4063;
Tpl_3592: Tpl_3099 = Tpl_4064;
Tpl_3593: Tpl_3099 = Tpl_4065;
Tpl_3594: Tpl_3099 = Tpl_4066;
Tpl_3595: Tpl_3099 = Tpl_4067;
Tpl_3596: Tpl_3099 = Tpl_4068;
Tpl_3597: Tpl_3099 = Tpl_4069;
Tpl_3598: Tpl_3099 = Tpl_4070;
Tpl_3599: Tpl_3099 = Tpl_4071;
Tpl_3600: Tpl_3099 = Tpl_4072;
Tpl_3601: Tpl_3099 = Tpl_4073;
Tpl_3602: Tpl_3099 = Tpl_4074;
Tpl_3603: Tpl_3099 = Tpl_4075;
Tpl_3604: Tpl_3099 = Tpl_4076;
Tpl_3605: Tpl_3099 = Tpl_4077;
Tpl_3606: Tpl_3099 = Tpl_4078;
Tpl_3607: Tpl_3099 = Tpl_4079;
Tpl_3608: Tpl_3099 = Tpl_4080;
Tpl_3609: Tpl_3099 = Tpl_4081;
Tpl_3610: Tpl_3099 = Tpl_4082;
Tpl_3611: Tpl_3099 = Tpl_4083;
default: Tpl_3099 = 0;
endcase
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin
if ((!Tpl_3092))
begin
Tpl_3095[0] <= 1'b0;
end
else
begin
if (Tpl_3111)
begin
Tpl_3095[0] <= Tpl_3098[(0 + 5)];
end
else
if (Tpl_3094[0])
begin
Tpl_3095[0] <= 1'b0;
end
end
end


always @( posedge Tpl_3091 or negedge Tpl_3092 )
begin
if ((!Tpl_3092))
begin
Tpl_3095[1] <= 1'b0;
end
else
begin
if (Tpl_3111)
begin
Tpl_3095[1] <= Tpl_3098[(1 + 5)];
end
else
if (Tpl_3094[1])
begin
Tpl_3095[1] <= 1'b0;
end
end
end

assign Tpl_3089 = Tpl_3629;
assign Tpl_3090 = Tpl_3630;

always @( posedge Tpl_4085 or negedge Tpl_4086 )
begin: CURR_STATE_PROC_3592
if ((!Tpl_4086))
begin
Tpl_4099 <= 2'd0;
end
else
begin
Tpl_4099 <= Tpl_4100;
end
end


always @(*)
begin: NEXT_STATE_PROC_3595
case (Tpl_4099)
2'd0: begin
if (Tpl_4087)
begin
Tpl_4100 = 2'd1;
end
else
begin
Tpl_4100 = 2'd0;
end
end
2'd1: begin
Tpl_4100 = 2'd2;
end
2'd2: begin
if (Tpl_4090)
begin
if (Tpl_4087)
begin
Tpl_4100 = 2'd1;
end
else
begin
Tpl_4100 = 2'd0;
end
end
else
begin
Tpl_4100 = 2'd2;
end
end
default: Tpl_4100 = 2'd0;
endcase
end


always @( posedge Tpl_4085 or negedge Tpl_4086 )
begin: REG_OUTPUT_PROC_3605
if ((!Tpl_4086))
begin
Tpl_4097 <= 1'b0;
Tpl_4098 <= 12'h000;
Tpl_4091 <= 1'b0;
Tpl_4092 <= 0;
Tpl_4093 <= 2'h0;
Tpl_4089 <= 1'b1;
end
else
begin
case (Tpl_4099)
2'd0: begin
if (Tpl_4087)
begin
Tpl_4097 <= 1'b1;
Tpl_4098 <= Tpl_4088;
Tpl_4089 <= 1'b0;
end
end
2'd1: begin
Tpl_4097 <= 1'b0;
Tpl_4098 <= 12'h000;
Tpl_4089 <= 1'b0;
Tpl_4091 <= 1'b1;
Tpl_4092 <= Tpl_4096;
Tpl_4093 <= Tpl_4095;
end
2'd2: begin
if (Tpl_4090)
begin
Tpl_4091 <= 1'b0;
Tpl_4092 <= 0;
Tpl_4093 <= 2'h0;
if (Tpl_4087)
begin
Tpl_4097 <= 1'b1;
Tpl_4098 <= Tpl_4088;
Tpl_4089 <= 1'b1;
end
else
begin
Tpl_4097 <= 1'b0;
Tpl_4098 <= 12'h000;
Tpl_4089 <= 1'b1;
end
end
end
endcase
end
end


always @( posedge Tpl_4101 or negedge Tpl_4102 )
begin: CURR_STATE_PROC_3615
if ((!Tpl_4102))
Tpl_4119 <= 3'd0;
else
Tpl_4119 <= Tpl_4120;
end


always @(*)
begin: NEXT_STATE_PROC_3616
case (Tpl_4119)
3'd0: begin
if (Tpl_4104)
begin
Tpl_4120 = 3'd1;
end
else
begin
Tpl_4120 = 3'd0;
end
end
3'd1: begin
if (Tpl_4107)
begin
Tpl_4120 = 3'd2;
end
else
begin
Tpl_4120 = 3'd1;
end
end
3'd2: begin
if ((Tpl_4118 == 12'h00c))
begin
if (Tpl_4103)
begin
Tpl_4120 = 3'd4;
end
else
begin
Tpl_4120 = 3'd2;
end
end
else
begin
Tpl_4120 = 3'd3;
end
end
3'd4: begin
if ((|Tpl_4113))
begin
Tpl_4120 = 3'd3;
end
else
begin
Tpl_4120 = 3'd4;
end
end
3'd3: begin
if (Tpl_4110)
begin
if (Tpl_4104)
begin
Tpl_4120 = 3'd1;
end
else
begin
Tpl_4120 = 3'd0;
end
end
else
begin
Tpl_4120 = 3'd3;
end
end
default: Tpl_4120 = 3'd0;
endcase
end


always @( posedge Tpl_4101 or negedge Tpl_4102 )
begin: REG_OUTPUT_PROC_3636
if ((!Tpl_4102))
begin
Tpl_4117 <= 1'b0;
Tpl_4118 <= 12'h000;
Tpl_4116 <= 0;
Tpl_4106 <= 1'b1;
Tpl_4109 <= 1'b0;
Tpl_4111 <= 1'b0;
Tpl_4112 <= 2'h0;
end
else
begin
case (Tpl_4119)
3'd0: begin
if (Tpl_4104)
begin
Tpl_4109 <= 1'b1;
Tpl_4106 <= 1'b0;
Tpl_4118 <= Tpl_4105;
end
end
3'd1: begin
if (Tpl_4107)
begin
Tpl_4109 <= 1'b0;
Tpl_4116 <= Tpl_4108;
Tpl_4117 <= 1'b1;
Tpl_4106 <= 1'b0;
end
else
begin
Tpl_4109 <= 1'b1;
Tpl_4116 <= 0;
Tpl_4117 <= 1'b0;
Tpl_4106 <= 1'b0;
end
end
3'd2: begin
if ((Tpl_4118 == 12'h00c))
begin
if (Tpl_4103)
begin
Tpl_4116 <= 0;
Tpl_4117 <= 1'b0;
Tpl_4118 <= 12'h000;
end
end
else
begin
Tpl_4116 <= 0;
Tpl_4117 <= 1'b0;
Tpl_4118 <= 12'h000;
Tpl_4111 <= 1;
Tpl_4112 <= Tpl_4115;
end
end
3'd4: begin
if ((|Tpl_4113))
begin
Tpl_4111 <= 1;
Tpl_4112 <= (Tpl_4115 | {{1'b0 , (|Tpl_4114)}});
end
end
3'd3: begin
if (Tpl_4110)
begin
Tpl_4111 <= 1'b0;
Tpl_4112 <= 2'h0;
if (Tpl_4104)
begin
Tpl_4106 <= 1'b1;
Tpl_4118 <= Tpl_4105;
Tpl_4109 <= 1'b1;
end
else
begin
Tpl_4106 <= 1'b1;
Tpl_4118 <= 12'h000;
Tpl_4109 <= 1'b0;
end
end
end
endcase
end
end

assign Tpl_5666 = (Tpl_4219 && Tpl_4243);

always @(*)
begin
Tpl_5668 = 0;
Tpl_5669 = 0;
Tpl_5670 = 0;
Tpl_5671 = 0;
case (Tpl_5672)
3'b000: Tpl_5668 = 1'b1;
3'b001: Tpl_5669 = 1'b1;
3'b101: Tpl_5671 = 1'b1;
3'b111: Tpl_5670 = 1'b1;
default: begin
Tpl_5668 = 1'b0;
Tpl_5669 = 1'b0;
Tpl_5671 = 1'b0;
Tpl_5670 = 1'b0;
end
endcase
end

assign Tpl_5667 = (Tpl_5669 ? ((|Tpl_4256[1:0]) ? Tpl_4256[1:0] : 2'b11) : (Tpl_5668 ? ((|Tpl_4208[1:0]) ? Tpl_4208[1:0] : 2'b11) : (Tpl_5670 ? (Tpl_5626 ? ((Tpl_4126[1:0] == 2'b00) ? 2'b00 : ((Tpl_4126[1:0] == 2'b01) ? 2'b11 : 2'b01)) : ((Tpl_4121[1:0] == 2'b00) ? 2'b00 : ((Tpl_4121[1:0] == 2'b01) ? 2'b11 : 2'b01))) : Tpl_4191)));

always @(*)
begin
if ((~Tpl_5668))
begin
Tpl_5665 = 0;
end
else
begin
case (Tpl_4232)
3'b001: Tpl_5665 = 4'd3;
3'b010: Tpl_5665 = 4'd4;
3'b011: Tpl_5665 = 4'd5;
3'b100: Tpl_5665 = 4'd6;
3'b101: Tpl_5665 = 4'd8;
default: Tpl_5665 = 4'h0;
endcase
end
end


always @(*)
begin
Tpl_5627 = 0;
Tpl_5628 = 0;
Tpl_5629 = 0;
Tpl_5630 = 0;
Tpl_5631 = 0;
Tpl_5632 = 0;
Tpl_5633 = 0;
Tpl_5634 = 0;
Tpl_5635 = 0;
Tpl_5636 = 0;
Tpl_5637 = 0;
Tpl_5638 = 0;
Tpl_5639 = 0;
Tpl_5640 = 0;
Tpl_5641 = 0;
Tpl_5642 = 0;
Tpl_5643 = 0;
Tpl_5644 = 0;
Tpl_5645 = 0;
Tpl_5646 = 0;
Tpl_5647 = 0;
Tpl_5650 = 0;
Tpl_5651 = 0;
Tpl_5652 = 0;
Tpl_5653 = 0;
Tpl_5654 = 0;
Tpl_5655 = 0;
Tpl_5658 = 0;
Tpl_5659 = 0;
Tpl_5660 = 0;
Tpl_5661 = 0;
Tpl_5662 = 0;
Tpl_5663 = 0;
Tpl_5664 = 0;
Tpl_5627 = {{6'h00 , Tpl_4203 , Tpl_4204 , Tpl_4205 , Tpl_4206[3:1] , Tpl_4207 , Tpl_4206[0] , Tpl_4208[1:0]}};
Tpl_5628 = {{5'h00 , Tpl_4209 , Tpl_4210 , Tpl_4212[2:0] , Tpl_4211 , 2'h0 , Tpl_4215[1:0] , Tpl_4213[1:0] , Tpl_4214}};
Tpl_5629 = {{5'h00 , Tpl_4219 , 1'h0 , Tpl_4216 , 1'h0 , Tpl_4217 , Tpl_4218 , 3'h0}};
Tpl_5630 = {{5'h00 , Tpl_4227 , Tpl_4226 , Tpl_4225 , Tpl_4224 , Tpl_4223 , Tpl_4222 , Tpl_4220 , Tpl_4221}};
Tpl_5631 = {{5'h00 , Tpl_4236 , Tpl_4235 , Tpl_4234 , Tpl_4233 , Tpl_4232 , 1'h0 , Tpl_4231 , Tpl_4230 , Tpl_4229 , Tpl_4228 , 1'h0}};
Tpl_5632 = {{5'h00 , Tpl_4245 , Tpl_4244 , Tpl_4243 , Tpl_4242 , Tpl_4241 , Tpl_4240 , Tpl_4239 , Tpl_4238 , Tpl_4237}};
Tpl_5633 = {{5'h00 , Tpl_4249 , 2'h0 , Tpl_4248 , Tpl_4247 , Tpl_4246}};
Tpl_5634 = {{5'h00 , Tpl_4250 , Tpl_4251 , Tpl_4252 , Tpl_4253 , Tpl_4254[3:1] , Tpl_4255 , Tpl_4254[0] , Tpl_4256[1:0]}};
Tpl_5635 = {{5'h00 , Tpl_4257 , Tpl_4258 , 1'h0 , Tpl_4260[2] , 1'h0 , Tpl_4259 , Tpl_4260[1] , Tpl_4261[1] , Tpl_4263[1:0] , Tpl_4260[0] , Tpl_4261[0] , Tpl_4262}};
Tpl_5636 = {{7'h00 , Tpl_4264 , 1'h0 , Tpl_4265 , Tpl_4266 , Tpl_4267 , Tpl_4268}};
Tpl_5637 = {{15'h0000 , Tpl_4269 , Tpl_4270}};
Tpl_5658 = {{Tpl_4192 , 2'b00 , Tpl_4191}};
Tpl_5659 = {{Tpl_4196 , Tpl_4195 , 1'd0 , Tpl_4194 , Tpl_4193}};
Tpl_5660 = {{4'd0 , Tpl_4197}};
Tpl_5661 = Tpl_4198;
Tpl_5662 = {{6'd0 , Tpl_4200 , Tpl_4199}};
Tpl_5663 = Tpl_4201;
Tpl_5664 = Tpl_4202;
Tpl_5640 = {{Tpl_4125 , Tpl_4124 , Tpl_4123 , Tpl_4122 , Tpl_4121[1:0]}};
Tpl_5641 = {{Tpl_4130 , Tpl_4129 , Tpl_4128 , Tpl_4127 , Tpl_4126[1:0]}};
Tpl_5642 = {{Tpl_4134 , Tpl_4133 , Tpl_4132 , Tpl_4131}};
Tpl_5643 = {{Tpl_4134 , Tpl_4137 , Tpl_4136 , Tpl_4135}};
Tpl_5644 = {{Tpl_4143 , Tpl_4142 , Tpl_4141 , Tpl_4140 , Tpl_4139 , Tpl_4138}};
Tpl_5645 = {{Tpl_4148 , Tpl_4147 , Tpl_4146 , Tpl_4140 , Tpl_4145 , Tpl_4144}};
Tpl_5646 = {{Tpl_4150 , Tpl_4149}};
Tpl_5647 = {{Tpl_4152 , Tpl_4151}};
Tpl_5648 = {{Tpl_4154 , Tpl_4153}};
Tpl_5649 = {{Tpl_4156 , Tpl_4155}};
Tpl_5650 = {{Tpl_4158 , Tpl_4157}};
Tpl_5651 = {{Tpl_4160 , Tpl_4159}};
Tpl_5638 = {{Tpl_4168 , Tpl_4167 , Tpl_4166 , Tpl_4165 , Tpl_4164 , Tpl_4163 , Tpl_4162 , Tpl_4161}};
Tpl_5652 = {{Tpl_4170 , Tpl_4169}};
Tpl_5653 = {{Tpl_4172 , Tpl_4171}};
Tpl_5654 = {{Tpl_4177 , Tpl_4176 , Tpl_4175 , Tpl_4174 , Tpl_4173}};
Tpl_5655 = {{Tpl_4177 , Tpl_4181 , Tpl_4180 , Tpl_4179 , Tpl_4178}};
Tpl_5656 = {{Tpl_4186 , Tpl_4185 , Tpl_4184 , Tpl_4183 , Tpl_4182}};
Tpl_5657 = {{Tpl_4186 , Tpl_4190 , Tpl_4189 , Tpl_4188 , Tpl_4187}};
end

assign Tpl_5343 = {{Tpl_4319 , Tpl_4303 , Tpl_4287 , Tpl_4271}};
assign Tpl_5344 = {{Tpl_4320 , Tpl_4304 , Tpl_4288 , Tpl_4272}};
assign Tpl_5345 = {{Tpl_4321 , Tpl_4305 , Tpl_4289 , Tpl_4273}};
assign Tpl_5346 = {{Tpl_4322 , Tpl_4306 , Tpl_4290 , Tpl_4274}};
assign Tpl_5347 = {{Tpl_4323 , Tpl_4307 , Tpl_4291 , Tpl_4275}};
assign Tpl_5348 = {{Tpl_4324 , Tpl_4308 , Tpl_4292 , Tpl_4276}};
assign Tpl_5349 = {{Tpl_4325 , Tpl_4309 , Tpl_4293 , Tpl_4277}};
assign Tpl_5350 = {{Tpl_4326 , Tpl_4310 , Tpl_4294 , Tpl_4278}};
assign Tpl_5351 = {{Tpl_4327 , Tpl_4311 , Tpl_4295 , Tpl_4279}};
assign Tpl_5352 = {{Tpl_4328 , Tpl_4312 , Tpl_4296 , Tpl_4280}};
assign Tpl_5353 = {{Tpl_4329 , Tpl_4313 , Tpl_4297 , Tpl_4281}};
assign Tpl_5354 = {{Tpl_4330 , Tpl_4314 , Tpl_4298 , Tpl_4282}};
assign Tpl_5355 = {{Tpl_4331 , Tpl_4315 , Tpl_4299 , Tpl_4283}};
assign Tpl_5356 = {{Tpl_4332 , Tpl_4316 , Tpl_4300 , Tpl_4284}};
assign Tpl_5357 = {{Tpl_4333 , Tpl_4317 , Tpl_4301 , Tpl_4285}};
assign Tpl_5358 = {{Tpl_4334 , Tpl_4318 , Tpl_4302 , Tpl_4286}};
assign Tpl_5359 = {{Tpl_4347 , Tpl_4343 , Tpl_4339 , Tpl_4335}};
assign Tpl_5360 = {{Tpl_4348 , Tpl_4344 , Tpl_4340 , Tpl_4336}};
assign Tpl_5361 = {{Tpl_4349 , Tpl_4345 , Tpl_4341 , Tpl_4337}};
assign Tpl_5362 = {{Tpl_4350 , Tpl_4346 , Tpl_4342 , Tpl_4338}};
assign Tpl_5363 = {{Tpl_4354 , Tpl_4353 , Tpl_4352 , Tpl_4351}};
assign Tpl_5364 = {{Tpl_4388 , Tpl_4387 , Tpl_4386 , Tpl_4385 , Tpl_4384 , Tpl_4383 , Tpl_4382 , Tpl_4381 , Tpl_4380 , Tpl_4379 , Tpl_4378 , Tpl_4377 , Tpl_4376 , Tpl_4375 , Tpl_4374 , Tpl_4373 , Tpl_4372 , Tpl_4371 , Tpl_4370 , Tpl_4369 , Tpl_4368 , Tpl_4367 , Tpl_4366 , Tpl_4365 , Tpl_4364 , Tpl_4363 , Tpl_4362 , Tpl_4361 , Tpl_4360 , Tpl_4359 , Tpl_4358 , Tpl_4357 , Tpl_4356 , Tpl_4355}};
assign Tpl_5365 = {{Tpl_4395 , Tpl_4389}};
assign Tpl_5366 = {{Tpl_4396 , Tpl_4390}};
assign Tpl_5367 = {{Tpl_4397 , Tpl_4391}};
assign Tpl_5368 = {{Tpl_4398 , Tpl_4392}};
assign Tpl_5369 = {{Tpl_4399 , Tpl_4393}};
assign Tpl_5370 = {{Tpl_4400 , Tpl_4394}};
assign Tpl_5371 = {{Tpl_4416 , Tpl_4411 , Tpl_4406 , Tpl_4401}};
assign Tpl_5372 = {{Tpl_4417 , Tpl_4412 , Tpl_4407 , Tpl_4402}};
assign Tpl_5373 = {{Tpl_4418 , Tpl_4413 , Tpl_4408 , Tpl_4403}};
assign Tpl_5374 = {{Tpl_4419 , Tpl_4414 , Tpl_4409 , Tpl_4404}};
assign Tpl_5375 = {{Tpl_4420 , Tpl_4415 , Tpl_4410 , Tpl_4405}};
assign Tpl_5376 = {{Tpl_4423 , Tpl_4421}};
assign Tpl_5377 = {{Tpl_4424 , Tpl_4422}};
assign Tpl_5378 = {{Tpl_4427 , Tpl_4425}};
assign Tpl_5379 = {{Tpl_4428 , Tpl_4426}};
assign Tpl_5380 = Tpl_4429;
assign Tpl_5381 = Tpl_4430;
assign Tpl_5382 = {{Tpl_4455 , Tpl_4447 , Tpl_4439 , Tpl_4431}};
assign Tpl_5383 = {{Tpl_4456 , Tpl_4448 , Tpl_4440 , Tpl_4432}};
assign Tpl_5384 = {{Tpl_4457 , Tpl_4449 , Tpl_4441 , Tpl_4433}};
assign Tpl_5385 = {{Tpl_4458 , Tpl_4450 , Tpl_4442 , Tpl_4434}};
assign Tpl_5386 = {{Tpl_4459 , Tpl_4451 , Tpl_4443 , Tpl_4435}};
assign Tpl_5387 = {{Tpl_4460 , Tpl_4452 , Tpl_4444 , Tpl_4436}};
assign Tpl_5388 = {{Tpl_4461 , Tpl_4453 , Tpl_4445 , Tpl_4437}};
assign Tpl_5389 = {{Tpl_4462 , Tpl_4454 , Tpl_4446 , Tpl_4438}};
assign Tpl_5390 = {{Tpl_4733 , Tpl_4463}};
assign {{Tpl_4734 , Tpl_4464}} = Tpl_5391;
assign Tpl_5392 = {{Tpl_4735 , Tpl_4465}};
assign {{Tpl_4736 , Tpl_4466}} = Tpl_5393;
assign Tpl_5394 = {{Tpl_4737 , Tpl_4467}};
assign {{Tpl_4738 , Tpl_4468}} = Tpl_5395;
assign Tpl_5396 = {{Tpl_4739 , Tpl_4469}};
assign {{Tpl_4740 , Tpl_4470}} = Tpl_5397;
assign Tpl_5398 = {{Tpl_4743 , Tpl_4741 , Tpl_4473 , Tpl_4471}};
assign {{Tpl_4744 , Tpl_4742 , Tpl_4474 , Tpl_4472}} = Tpl_5399;
assign Tpl_5400 = {{Tpl_4819 , Tpl_4817 , Tpl_4815 , Tpl_4813 , Tpl_4811 , Tpl_4809 , Tpl_4807 , Tpl_4805 , Tpl_4803 , Tpl_4801 , Tpl_4799 , Tpl_4797 , Tpl_4795 , Tpl_4793 , Tpl_4791 , Tpl_4789 , Tpl_4787 , Tpl_4785 , Tpl_4783 , Tpl_4781 , Tpl_4779 , Tpl_4777 , Tpl_4775 , Tpl_4773 , Tpl_4771 , Tpl_4769 , Tpl_4767 , Tpl_4765 , Tpl_4763 , Tpl_4761 , Tpl_4759 , Tpl_4757 , Tpl_4755 , Tpl_4753 , Tpl_4751 , Tpl_4749 , Tpl_4747 , Tpl_4745 , Tpl_4549 , Tpl_4547 , Tpl_4545 , Tpl_4543 , Tpl_4541 , Tpl_4539 , Tpl_4537 , Tpl_4535 , Tpl_4533 , Tpl_4531 , Tpl_4529 , Tpl_4527 , Tpl_4525 , Tpl_4523 , Tpl_4521 , Tpl_4519 , Tpl_4517 , Tpl_4515 , Tpl_4513 , Tpl_4511 , Tpl_4509 , Tpl_4507 , Tpl_4505 , Tpl_4503 , Tpl_4501 , Tpl_4499 , Tpl_4497 , Tpl_4495 , Tpl_4493 , Tpl_4491 , Tpl_4489 , Tpl_4487 , Tpl_4485 , Tpl_4483 , Tpl_4481 , Tpl_4479 , Tpl_4477 , Tpl_4475}};
assign {{Tpl_4820 , Tpl_4818 , Tpl_4816 , Tpl_4814 , Tpl_4812 , Tpl_4810 , Tpl_4808 , Tpl_4806 , Tpl_4804 , Tpl_4802 , Tpl_4800 , Tpl_4798 , Tpl_4796 , Tpl_4794 , Tpl_4792 , Tpl_4790 , Tpl_4788 , Tpl_4786 , Tpl_4784 , Tpl_4782 , Tpl_4780 , Tpl_4778 , Tpl_4776 , Tpl_4774 , Tpl_4772 , Tpl_4770 , Tpl_4768 , Tpl_4766 , Tpl_4764 , Tpl_4762 , Tpl_4760 , Tpl_4758 , Tpl_4756 , Tpl_4754 , Tpl_4752 , Tpl_4750 , Tpl_4748 , Tpl_4746 , Tpl_4550 , Tpl_4548 , Tpl_4546 , Tpl_4544 , Tpl_4542 , Tpl_4540 , Tpl_4538 , Tpl_4536 , Tpl_4534 , Tpl_4532 , Tpl_4530 , Tpl_4528 , Tpl_4526 , Tpl_4524 , Tpl_4522 , Tpl_4520 , Tpl_4518 , Tpl_4516 , Tpl_4514 , Tpl_4512 , Tpl_4510 , Tpl_4508 , Tpl_4506 , Tpl_4504 , Tpl_4502 , Tpl_4500 , Tpl_4498 , Tpl_4496 , Tpl_4494 , Tpl_4492 , Tpl_4490 , Tpl_4488 , Tpl_4486 , Tpl_4484 , Tpl_4482 , Tpl_4480 , Tpl_4478 , Tpl_4476}} = Tpl_5401;
assign Tpl_5402 = {{Tpl_4828 , Tpl_4827 , Tpl_4826 , Tpl_4825 , Tpl_4824 , Tpl_4823 , Tpl_4822 , Tpl_4821 , Tpl_4558 , Tpl_4557 , Tpl_4556 , Tpl_4555 , Tpl_4554 , Tpl_4553 , Tpl_4552 , Tpl_4551}};
assign Tpl_5403 = {{Tpl_4830 , Tpl_4829 , Tpl_4560 , Tpl_4559}};
assign Tpl_5404 = {{Tpl_4832 , Tpl_4831 , Tpl_4562 , Tpl_4561}};
assign Tpl_5405 = {{Tpl_4839 , Tpl_4837 , Tpl_4835 , Tpl_4833 , Tpl_4569 , Tpl_4567 , Tpl_4565 , Tpl_4563}};
assign {{Tpl_4840 , Tpl_4838 , Tpl_4836 , Tpl_4834 , Tpl_4570 , Tpl_4568 , Tpl_4566 , Tpl_4564}} = Tpl_5406;
assign Tpl_5407 = {{Tpl_4847 , Tpl_4845 , Tpl_4843 , Tpl_4841 , Tpl_4577 , Tpl_4575 , Tpl_4573 , Tpl_4571}};
assign {{Tpl_4848 , Tpl_4846 , Tpl_4844 , Tpl_4842 , Tpl_4578 , Tpl_4576 , Tpl_4574 , Tpl_4572}} = Tpl_5408;
assign Tpl_5409 = {{Tpl_4911 , Tpl_4909 , Tpl_4907 , Tpl_4905 , Tpl_4903 , Tpl_4901 , Tpl_4899 , Tpl_4897 , Tpl_4895 , Tpl_4893 , Tpl_4891 , Tpl_4889 , Tpl_4887 , Tpl_4885 , Tpl_4883 , Tpl_4881 , Tpl_4879 , Tpl_4877 , Tpl_4875 , Tpl_4873 , Tpl_4871 , Tpl_4869 , Tpl_4867 , Tpl_4865 , Tpl_4863 , Tpl_4861 , Tpl_4859 , Tpl_4857 , Tpl_4855 , Tpl_4853 , Tpl_4851 , Tpl_4849 , Tpl_4641 , Tpl_4639 , Tpl_4637 , Tpl_4635 , Tpl_4633 , Tpl_4631 , Tpl_4629 , Tpl_4627 , Tpl_4625 , Tpl_4623 , Tpl_4621 , Tpl_4619 , Tpl_4617 , Tpl_4615 , Tpl_4613 , Tpl_4611 , Tpl_4609 , Tpl_4607 , Tpl_4605 , Tpl_4603 , Tpl_4601 , Tpl_4599 , Tpl_4597 , Tpl_4595 , Tpl_4593 , Tpl_4591 , Tpl_4589 , Tpl_4587 , Tpl_4585 , Tpl_4583 , Tpl_4581 , Tpl_4579}};
assign {{Tpl_4912 , Tpl_4910 , Tpl_4908 , Tpl_4906 , Tpl_4904 , Tpl_4902 , Tpl_4900 , Tpl_4898 , Tpl_4896 , Tpl_4894 , Tpl_4892 , Tpl_4890 , Tpl_4888 , Tpl_4886 , Tpl_4884 , Tpl_4882 , Tpl_4880 , Tpl_4878 , Tpl_4876 , Tpl_4874 , Tpl_4872 , Tpl_4870 , Tpl_4868 , Tpl_4866 , Tpl_4864 , Tpl_4862 , Tpl_4860 , Tpl_4858 , Tpl_4856 , Tpl_4854 , Tpl_4852 , Tpl_4850 , Tpl_4642 , Tpl_4640 , Tpl_4638 , Tpl_4636 , Tpl_4634 , Tpl_4632 , Tpl_4630 , Tpl_4628 , Tpl_4626 , Tpl_4624 , Tpl_4622 , Tpl_4620 , Tpl_4618 , Tpl_4616 , Tpl_4614 , Tpl_4612 , Tpl_4610 , Tpl_4608 , Tpl_4606 , Tpl_4604 , Tpl_4602 , Tpl_4600 , Tpl_4598 , Tpl_4596 , Tpl_4594 , Tpl_4592 , Tpl_4590 , Tpl_4588 , Tpl_4586 , Tpl_4584 , Tpl_4582 , Tpl_4580}} = Tpl_5410;
assign Tpl_5411 = {{Tpl_4919 , Tpl_4917 , Tpl_4915 , Tpl_4913 , Tpl_4649 , Tpl_4647 , Tpl_4645 , Tpl_4643}};
assign {{Tpl_4920 , Tpl_4918 , Tpl_4916 , Tpl_4914 , Tpl_4650 , Tpl_4648 , Tpl_4646 , Tpl_4644}} = Tpl_5412;
assign Tpl_5413 = {{Tpl_4983 , Tpl_4981 , Tpl_4979 , Tpl_4977 , Tpl_4975 , Tpl_4973 , Tpl_4971 , Tpl_4969 , Tpl_4967 , Tpl_4965 , Tpl_4963 , Tpl_4961 , Tpl_4959 , Tpl_4957 , Tpl_4955 , Tpl_4953 , Tpl_4951 , Tpl_4949 , Tpl_4947 , Tpl_4945 , Tpl_4943 , Tpl_4941 , Tpl_4939 , Tpl_4937 , Tpl_4935 , Tpl_4933 , Tpl_4931 , Tpl_4929 , Tpl_4927 , Tpl_4925 , Tpl_4923 , Tpl_4921 , Tpl_4713 , Tpl_4711 , Tpl_4709 , Tpl_4707 , Tpl_4705 , Tpl_4703 , Tpl_4701 , Tpl_4699 , Tpl_4697 , Tpl_4695 , Tpl_4693 , Tpl_4691 , Tpl_4689 , Tpl_4687 , Tpl_4685 , Tpl_4683 , Tpl_4681 , Tpl_4679 , Tpl_4677 , Tpl_4675 , Tpl_4673 , Tpl_4671 , Tpl_4669 , Tpl_4667 , Tpl_4665 , Tpl_4663 , Tpl_4661 , Tpl_4659 , Tpl_4657 , Tpl_4655 , Tpl_4653 , Tpl_4651}};
assign {{Tpl_4984 , Tpl_4982 , Tpl_4980 , Tpl_4978 , Tpl_4976 , Tpl_4974 , Tpl_4972 , Tpl_4970 , Tpl_4968 , Tpl_4966 , Tpl_4964 , Tpl_4962 , Tpl_4960 , Tpl_4958 , Tpl_4956 , Tpl_4954 , Tpl_4952 , Tpl_4950 , Tpl_4948 , Tpl_4946 , Tpl_4944 , Tpl_4942 , Tpl_4940 , Tpl_4938 , Tpl_4936 , Tpl_4934 , Tpl_4932 , Tpl_4930 , Tpl_4928 , Tpl_4926 , Tpl_4924 , Tpl_4922 , Tpl_4714 , Tpl_4712 , Tpl_4710 , Tpl_4708 , Tpl_4706 , Tpl_4704 , Tpl_4702 , Tpl_4700 , Tpl_4698 , Tpl_4696 , Tpl_4694 , Tpl_4692 , Tpl_4690 , Tpl_4688 , Tpl_4686 , Tpl_4684 , Tpl_4682 , Tpl_4680 , Tpl_4678 , Tpl_4676 , Tpl_4674 , Tpl_4672 , Tpl_4670 , Tpl_4668 , Tpl_4666 , Tpl_4664 , Tpl_4662 , Tpl_4660 , Tpl_4658 , Tpl_4656 , Tpl_4654 , Tpl_4652}} = Tpl_5414;
assign Tpl_5415 = {{Tpl_4991 , Tpl_4989 , Tpl_4987 , Tpl_4985 , Tpl_4721 , Tpl_4719 , Tpl_4717 , Tpl_4715}};
assign {{Tpl_4992 , Tpl_4990 , Tpl_4988 , Tpl_4986 , Tpl_4722 , Tpl_4720 , Tpl_4718 , Tpl_4716}} = Tpl_5416;
assign Tpl_5417 = {{Tpl_4729 , Tpl_4727 , Tpl_4725 , Tpl_4723}};
assign {{Tpl_4730 , Tpl_4728 , Tpl_4726 , Tpl_4724}} = Tpl_5418;
assign Tpl_5419 = Tpl_4731;
assign Tpl_4732 = Tpl_5420;
assign Tpl_5421 = {{Tpl_4997 , Tpl_4993}};
assign {{Tpl_4998 , Tpl_4994}} = Tpl_5422;
assign Tpl_5423 = {{Tpl_4999 , Tpl_4995}};
assign {{Tpl_5000 , Tpl_4996}} = Tpl_5424;
assign Tpl_5425 = Tpl_5001;
assign Tpl_5426 = {{Tpl_5003 , Tpl_5002}};
assign Tpl_5427 = {{Tpl_5005 , Tpl_5004}};
assign Tpl_5428 = Tpl_5006;
assign Tpl_5007 = Tpl_5429;
assign Tpl_5430 = {{({{(2){{1'b0}}}}) , Tpl_5008}};
assign Tpl_5431 = {{({{(3){{1'b0}}}}) , Tpl_5009}};
assign Tpl_5432 = {{({{(3){{1'b0}}}}) , Tpl_5010}};
assign Tpl_5433 = {{({{(1){{1'b0}}}}) , Tpl_5011}};
assign Tpl_5434 = Tpl_5012;
assign Tpl_5435 = {{({{(2){{1'b0}}}}) , Tpl_5013}};
assign Tpl_5436 = Tpl_5014;
assign Tpl_5437 = Tpl_5015;
assign Tpl_5438 = Tpl_5016;
assign Tpl_5439 = {{({{(2){{1'b0}}}}) , Tpl_5017}};
assign Tpl_5440 = {{({{(2){{1'b0}}}}) , Tpl_5018}};
assign Tpl_5441 = Tpl_5019;
assign Tpl_5442 = Tpl_5020;
assign Tpl_5443 = {{({{(4){{1'b0}}}}) , Tpl_5021}};
assign Tpl_5444 = {{({{(3){{1'b0}}}}) , Tpl_5022}};
assign Tpl_5445 = {{({{(4){{1'b0}}}}) , Tpl_5023}};
assign Tpl_5446 = Tpl_5024;
assign Tpl_5447 = {{({{(2){{1'b0}}}}) , Tpl_5025}};
assign Tpl_5448 = Tpl_5026;
assign Tpl_5449 = Tpl_5027;
assign Tpl_5450 = {{({{(9){{1'b0}}}}) , Tpl_5028}};
assign Tpl_5451 = {{({{(12){{1'b0}}}}) , Tpl_5029}};
assign Tpl_5452 = Tpl_5030;
assign Tpl_5453 = {{({{(2){{1'b0}}}}) , Tpl_5031}};
assign Tpl_5454 = {{({{(1){{1'b0}}}}) , Tpl_5032}};
assign Tpl_5455 = {{({{(3){{1'b0}}}}) , Tpl_5033}};
assign Tpl_5456 = {{({{(4){{1'b0}}}}) , Tpl_5034}};
assign Tpl_5457 = Tpl_5035;
assign Tpl_5458 = Tpl_5036;
assign Tpl_5459 = {{({{(9){{1'b0}}}}) , Tpl_5037}};
assign Tpl_5460 = {{({{(6){{1'b0}}}}) , Tpl_5038}};
assign Tpl_5461 = {{({{(6){{1'b0}}}}) , Tpl_5039}};
assign Tpl_5462 = Tpl_5040;
assign Tpl_5463 = Tpl_5041;
assign Tpl_5464 = Tpl_5042;
assign Tpl_5465 = Tpl_5043;
assign Tpl_5466 = Tpl_5044;
assign Tpl_5467 = Tpl_5045;
assign Tpl_5468 = Tpl_5046;
assign Tpl_5469 = Tpl_5047;
assign Tpl_5470 = {{({{(4){{1'b0}}}}) , Tpl_5048}};
assign Tpl_5471 = {{({{(2){{1'b0}}}}) , Tpl_5049}};
assign Tpl_5472 = Tpl_5050;
assign Tpl_5473 = {{({{(3){{1'b0}}}}) , Tpl_5051}};
assign Tpl_5474 = {{({{(1){{1'b0}}}}) , Tpl_5052}};
assign Tpl_5475 = {{({{(2){{1'b0}}}}) , Tpl_5053}};
assign Tpl_5476 = Tpl_5054;
assign Tpl_5477 = {{({{(3){{1'b0}}}}) , Tpl_5055}};
assign Tpl_5478 = {{({{(4){{1'b0}}}}) , Tpl_5056}};
assign Tpl_5479 = {{({{(2){{1'b0}}}}) , Tpl_5057}};
assign Tpl_5480 = {{({{(3){{1'b0}}}}) , Tpl_5058}};
assign Tpl_5481 = {{({{(2){{1'b0}}}}) , Tpl_5059}};
assign Tpl_5482 = {{({{(8){{1'b0}}}}) , Tpl_5060}};
assign Tpl_5483 = {{({{(5){{1'b0}}}}) , Tpl_5061}};
assign Tpl_5484 = {{({{(2){{1'b0}}}}) , Tpl_5062}};
assign Tpl_5485 = {{({{(6){{1'b0}}}}) , Tpl_5063}};
assign Tpl_5486 = {{({{(1){{1'b0}}}}) , Tpl_5064}};
assign Tpl_5487 = Tpl_5065;
assign Tpl_5488 = Tpl_5066;
assign Tpl_5489 = Tpl_5067;
assign Tpl_5490 = Tpl_5068;
assign Tpl_5491 = {{({{(4){{1'b0}}}}) , Tpl_5069}};
assign Tpl_5492 = {{({{(4){{1'b0}}}}) , Tpl_5070}};
assign Tpl_5493 = {{({{(1){{1'b0}}}}) , Tpl_5071}};
assign Tpl_5494 = {{({{(1){{1'b0}}}}) , Tpl_5072}};
assign Tpl_5495 = {{({{(1){{1'b0}}}}) , Tpl_5073}};
assign Tpl_5496 = {{({{(3){{1'b0}}}}) , Tpl_5074}};
assign Tpl_5497 = Tpl_5075;
assign Tpl_5498 = Tpl_5076;
assign Tpl_5499 = Tpl_5077;
assign Tpl_5500 = {{({{(2){{1'b0}}}}) , Tpl_5078}};
assign Tpl_5501 = {{({{(4){{1'b0}}}}) , Tpl_5079}};
assign Tpl_5502 = {{({{(3){{1'b0}}}}) , Tpl_5080}};
assign Tpl_5503 = Tpl_5081;
assign Tpl_5504 = Tpl_5082;
assign Tpl_5505 = {{({{(2){{1'b0}}}}) , Tpl_5083}};
assign Tpl_5506 = {{({{(3){{1'b0}}}}) , Tpl_5084}};
assign Tpl_5507 = {{({{(4){{1'b0}}}}) , Tpl_5085}};
assign Tpl_5508 = Tpl_5086;
assign Tpl_5509 = Tpl_5087;
assign Tpl_5510 = {{({{(2){{1'b0}}}}) , Tpl_5088}};
assign Tpl_5511 = Tpl_5089;
assign Tpl_5512 = Tpl_5090;
assign Tpl_5513 = Tpl_5091;
assign Tpl_5514 = Tpl_5092;
assign Tpl_5515 = Tpl_5093;
assign Tpl_5516 = Tpl_5094;
assign Tpl_5517 = {{({{(3){{1'b0}}}}) , Tpl_5095}};
assign Tpl_5518 = {{({{(3){{1'b0}}}}) , Tpl_5096}};
assign Tpl_5519 = {{({{(1){{1'b0}}}}) , Tpl_5097}};
assign Tpl_5520 = {{({{(6){{1'b0}}}}) , Tpl_5098}};
assign Tpl_5521 = {{({{(3){{1'b0}}}}) , Tpl_5099}};
assign Tpl_5522 = {{({{(12){{1'b0}}}}) , Tpl_5100}};
assign Tpl_5523 = {{({{(4){{1'b0}}}}) , Tpl_5101}};
assign Tpl_5524 = {{({{(2){{1'b0}}}}) , Tpl_5102}};
assign Tpl_5525 = {{({{(2){{1'b0}}}}) , Tpl_5103}};
assign Tpl_5526 = Tpl_5104;
assign Tpl_5527 = {{({{(4){{1'b0}}}}) , Tpl_5105}};
assign Tpl_5528 = Tpl_5106;
assign Tpl_5529 = {{({{(2){{1'b0}}}}) , Tpl_5107}};
assign Tpl_5530 = {{({{(5){{1'b0}}}}) , Tpl_5108}};
assign Tpl_5531 = {{({{(1){{1'b0}}}}) , Tpl_5109}};
assign Tpl_5532 = {{({{(4){{1'b0}}}}) , Tpl_5110}};
assign Tpl_5533 = Tpl_5111;
assign Tpl_5534 = {{({{(5){{1'b0}}}}) , Tpl_5112}};
assign Tpl_5535 = Tpl_5113;
assign Tpl_5536 = Tpl_5114;
assign Tpl_5537 = {{({{(2){{1'b0}}}}) , Tpl_5115}};
assign Tpl_5538 = Tpl_5116;
assign Tpl_5539 = {{({{(4){{1'b0}}}}) , Tpl_5117}};
assign Tpl_5540 = {{({{(4){{1'b0}}}}) , Tpl_5118}};
assign Tpl_5541 = Tpl_5119;
assign Tpl_5542 = {{({{(9){{1'b0}}}}) , Tpl_5120}};
assign Tpl_5543 = Tpl_5121;
assign Tpl_5544 = {{({{(4){{1'b0}}}}) , Tpl_5122}};
assign Tpl_5545 = {{Tpl_5133 , Tpl_5123}};
assign Tpl_5546 = {{Tpl_5134 , Tpl_5124}};
assign Tpl_5547 = {{Tpl_5135 , Tpl_5125}};
assign Tpl_5548 = {{Tpl_5136 , Tpl_5126}};
assign Tpl_5549 = {{Tpl_5137 , Tpl_5127}};
assign Tpl_5550 = {{Tpl_5138 , Tpl_5128}};
assign Tpl_5551 = {{Tpl_5139 , Tpl_5129}};
assign Tpl_5552 = {{Tpl_5140 , Tpl_5130}};
assign Tpl_5553 = {{Tpl_5141 , Tpl_5131}};
assign Tpl_5554 = {{Tpl_5142 , Tpl_5132}};
assign Tpl_5555 = {{Tpl_5145 , Tpl_5143}};
assign Tpl_5556 = {{Tpl_5146 , Tpl_5144}};
assign Tpl_5557 = {{Tpl_5149 , Tpl_5147}};
assign Tpl_5558 = {{Tpl_5150 , Tpl_5148}};
assign Tpl_5559 = {{Tpl_5152 , Tpl_5151}};
assign Tpl_5560 = {{Tpl_5154 , Tpl_5153}};
assign Tpl_5561 = {{Tpl_5156 , Tpl_5155}};
assign Tpl_5562 = {{Tpl_5158 , Tpl_5157}};
assign Tpl_5563 = {{Tpl_5160 , Tpl_5159}};
assign Tpl_5564 = {{Tpl_5162 , Tpl_5161}};
assign Tpl_5565 = {{Tpl_5164 , Tpl_5163}};
assign Tpl_5566 = {{Tpl_5166 , Tpl_5165}};
assign Tpl_5567 = {{Tpl_5168 , Tpl_5167}};
assign Tpl_5568 = {{Tpl_5170 , Tpl_5169}};
assign Tpl_5569 = {{Tpl_5172 , Tpl_5171}};
assign Tpl_5570 = {{Tpl_5174 , Tpl_5173}};
assign Tpl_5571 = {{Tpl_5176 , Tpl_5175}};
assign Tpl_5572 = {{Tpl_5178 , Tpl_5177}};
assign Tpl_5573 = {{Tpl_5180 , Tpl_5179}};
assign Tpl_5574 = {{Tpl_5182 , Tpl_5181}};
assign {{Tpl_5190 , Tpl_5183}} = Tpl_5575;
assign {{Tpl_5191 , Tpl_5184}} = Tpl_5576;
assign {{Tpl_5192 , Tpl_5185}} = Tpl_5577;
assign {{Tpl_5193 , Tpl_5186}} = Tpl_5578;
assign {{Tpl_5194 , Tpl_5187}} = Tpl_5579;
assign {{Tpl_5195 , Tpl_5188}} = Tpl_5580;
assign {{Tpl_5196 , Tpl_5189}} = Tpl_5581;
assign {{Tpl_5198 , Tpl_5197}} = Tpl_5582;
assign {{Tpl_5205 , Tpl_5199}} = Tpl_5583;
assign {{Tpl_5206 , Tpl_5200}} = Tpl_5584;
assign {{Tpl_5207 , Tpl_5201}} = Tpl_5585;
assign {{Tpl_5208 , Tpl_5202}} = Tpl_5586;
assign {{Tpl_5209 , Tpl_5203}} = Tpl_5587;
assign {{Tpl_5210 , Tpl_5204}} = Tpl_5588;
assign {{Tpl_5225 , Tpl_5211}} = Tpl_5589;
assign {{Tpl_5226 , Tpl_5212}} = Tpl_5590;
assign {{Tpl_5227 , Tpl_5213}} = Tpl_5591;
assign {{Tpl_5228 , Tpl_5214}} = Tpl_5592;
assign {{Tpl_5229 , Tpl_5215}} = Tpl_5593;
assign {{Tpl_5230 , Tpl_5216}} = Tpl_5594;
assign Tpl_5217 = Tpl_5595;
assign Tpl_5218 = Tpl_5596;
assign {{Tpl_5221 , Tpl_5219}} = Tpl_5597;
assign {{Tpl_5222 , Tpl_5220}} = Tpl_5598;
assign {{Tpl_5231 , Tpl_5223}} = Tpl_5599;
assign {{Tpl_5232 , Tpl_5224}} = Tpl_5600;
assign Tpl_5233 = Tpl_5601;
assign Tpl_5234 = Tpl_5602;
assign {{Tpl_5237 , Tpl_5235}} = Tpl_5603;
assign {{Tpl_5238 , Tpl_5236}} = Tpl_5604;
assign {{Tpl_5243 , Tpl_5242 , Tpl_5241 , Tpl_5240 , Tpl_5239}} = Tpl_5605;
assign {{Tpl_5248 , Tpl_5247 , Tpl_5246 , Tpl_5245 , Tpl_5244}} = Tpl_5606;
assign {{Tpl_5252 , Tpl_5251 , Tpl_5250 , Tpl_5249}} = Tpl_5607;
assign {{Tpl_5256 , Tpl_5255 , Tpl_5254 , Tpl_5253}} = Tpl_5608;
assign {{Tpl_5262 , Tpl_5261 , Tpl_5260 , Tpl_5259 , Tpl_5258 , Tpl_5257}} = Tpl_5609;
assign {{Tpl_5268 , Tpl_5267 , Tpl_5266 , Tpl_5265 , Tpl_5264 , Tpl_5263}} = Tpl_5610;
assign {{Tpl_5272 , Tpl_5271 , Tpl_5270 , Tpl_5269}} = Tpl_5611;
assign {{Tpl_5276 , Tpl_5275 , Tpl_5274 , Tpl_5273}} = Tpl_5612;
assign {{Tpl_5280 , Tpl_5279 , Tpl_5278 , Tpl_5277}} = Tpl_5613;
assign {{Tpl_5284 , Tpl_5283 , Tpl_5282 , Tpl_5281}} = Tpl_5614;
assign {{Tpl_5287 , Tpl_5286 , Tpl_5285}} = Tpl_5615;
assign {{Tpl_5290 , Tpl_5289 , Tpl_5288}} = Tpl_5616;
assign {{Tpl_5298 , Tpl_5297 , Tpl_5296 , Tpl_5295 , Tpl_5294 , Tpl_5293 , Tpl_5292 , Tpl_5291}} = Tpl_5617;
assign {{Tpl_5301 , Tpl_5300 , Tpl_5299}} = Tpl_5618;
assign {{Tpl_5304 , Tpl_5303 , Tpl_5302}} = Tpl_5619;
assign {{Tpl_5309 , Tpl_5308 , Tpl_5307 , Tpl_5306 , Tpl_5305}} = Tpl_5620;
assign {{Tpl_5314 , Tpl_5313 , Tpl_5312 , Tpl_5311 , Tpl_5310}} = Tpl_5621;
assign {{Tpl_5319 , Tpl_5318 , Tpl_5317 , Tpl_5316 , Tpl_5315}} = Tpl_5622;
assign {{Tpl_5324 , Tpl_5323 , Tpl_5322 , Tpl_5321 , Tpl_5320}} = Tpl_5623;
assign {{Tpl_5340 , Tpl_5339 , Tpl_5338 , Tpl_5337 , Tpl_5336 , Tpl_5335 , Tpl_5334 , Tpl_5333 , Tpl_5332 , Tpl_5331 , Tpl_5330 , Tpl_5329 , Tpl_5328 , Tpl_5327 , Tpl_5326 , Tpl_5325}} = Tpl_5624;
assign Tpl_5625 = {{Tpl_5342 , Tpl_5341}};

endmodule