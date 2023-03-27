
module dti_gear_ctrl (dti_mc_clock  ,  dti_phy_clock  ,  dti_sys_reset_n  ,  clklocken_reg_pom  ,  dti_dram_clock_disable  ,  mc_phase_lock  ,  dfien_reg_pom  ,  DTI_RESET_N  ,  DTI_CKE  ,  DTI_CS  ,  DTI_CA  ,  DTI_CA_L  ,  DTI_BA  ,  DTI_ACT_N  ,  DTI_ODT  ,  DTI_RANK  ,  DTI_RESET_N_CTL  ,  DTI_CKE_CTL  ,  DTI_CS_CTL  ,  DTI_CA_CTL  ,  DTI_CA_L_CTL  ,  DTI_BA_CTL  ,  DTI_ACT_N_CTL  ,  DTI_ODT_CTL  ,  DTI_RANK_CTL  ,  DTI_RESET_N_INT  ,  DTI_CKE_INT  ,  DTI_CS_INT  ,  DTI_CA_INT  ,  DTI_CA_L_INT  ,  DTI_BA_INT  ,  DTI_ACT_N_INT  ,  DTI_ODT_INT  ,  DTI_RANK_INT  ,  DTI_CALVL_LOAD_INT  ,  DTI_CALVL_CAPTURE_INT  ,  DTI_CMDDLY_LOAD_INT  ,  DTI_CALVL_LOAD  ,  DTI_CALVL_CAPTURE  ,  DTI_CMDDLY_LOAD);
input   dti_mc_clock ;
input   dti_phy_clock ;
input   dti_sys_reset_n ;
input   clklocken_reg_pom ;
input   dti_dram_clock_disable ;
output   mc_phase_lock ;
input   dfien_reg_pom ;
input  [3:0] DTI_RESET_N ;
input  [7:0] DTI_CKE ;
input  [7:0] DTI_CS ;
input  [75:0] DTI_CA ;
input  [39:0] DTI_CA_L ;
input  [15:0] DTI_BA ;
input  [3:0] DTI_ACT_N ;
input  [3:0] DTI_ODT ;
input  [3:0] DTI_RANK ;
input  [3:0] DTI_RESET_N_CTL ;
input  [7:0] DTI_CKE_CTL ;
input  [7:0] DTI_CS_CTL ;
input  [75:0] DTI_CA_CTL ;
input  [39:0] DTI_CA_L_CTL ;
input  [15:0] DTI_BA_CTL ;
input  [3:0] DTI_ACT_N_CTL ;
input  [3:0] DTI_ODT_CTL ;
input  [3:0] DTI_RANK_CTL ;
output   DTI_RESET_N_INT ;
output  [1:0] DTI_CKE_INT ;
output  [1:0] DTI_CS_INT ;
output  [18:0] DTI_CA_INT ;
output  [9:0] DTI_CA_L_INT ;
output  [3:0] DTI_BA_INT ;
output   DTI_ACT_N_INT ;
output   DTI_ODT_INT ;
output   DTI_RANK_INT ;
input   DTI_CALVL_LOAD_INT ;
input   DTI_CALVL_CAPTURE_INT ;
input   DTI_CMDDLY_LOAD_INT ;
output   DTI_CALVL_LOAD ;
output   DTI_CALVL_CAPTURE ;
output   DTI_CMDDLY_LOAD ;
wire  [1:0] mc_phase ;
wire   clklocken_reg_pom_int ;
wire  [3:0] dti_reset_n_tmp ;
wire  [1:0][3:0] dti_cke_tmp ;
wire  [1:0][3:0] dti_cs_tmp ;
wire  [18:0][3:0] dti_ca_tmp ;
wire  [9:0][3:0] dti_ca_l_tmp ;
wire  [3:0][3:0] dti_ba_tmp ;
wire  [3:0] dti_act_n_tmp ;
wire  [3:0] dti_odt_tmp ;
wire  [3:0] dti_rank_tmp ;
wire   dti_reset_n_int ;
wire  [1:0] dti_cke_int ;
wire  [1:0] dti_cs_int ;
wire  [18:0] dti_ca_int ;
wire  [9:0] dti_ca_l_int ;
wire  [3:0] dti_ba_int ;
wire   dti_act_n_int ;
wire   dti_odt_int ;
wire   dti_rank_int ;
wire   _dti_gear_ctrl__dti_gear_phase__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_phase__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n  ;
wire   _dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom  ;
wire   _dti_gear_ctrl__dti_gear_phase__dti_dram_clock_disable  ;
reg   _dti_gear_ctrl__dti_gear_phase__mc_phase_lock  ;
reg  [1:0] _dti_gear_ctrl__dti_gear_phase__mc_phase  ;
reg   _dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom_cld  ;
reg   _dti_gear_ctrl__dti_gear_phase__mc_cnt  ;
reg   _dti_gear_ctrl__dti_gear_phase__mc_cnt_cld  ;
reg   _dti_gear_ctrl__dti_gear_phase__mc_cnt_cld_d1  ;
wire   _dti_gear_ctrl__dti_gear_phase__phase_clr_pulse  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_rst__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_rst__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rst__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rst__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_rst__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_rst__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_0__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_0__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_0__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cke_1__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_1__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cke_1__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_0__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_0__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_0__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cs_1__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_1__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cs_1__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_0__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_0__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_0__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_1__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_1__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_1__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_2__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_2__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_2__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_3__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_3__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_3__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_4__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_4__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_4__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_5__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_5__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_5__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_6__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_6__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_6__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_7__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_7__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_7__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_8__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_8__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_8__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_9__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_9__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_9__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_10__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_10__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_10__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_11__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_11__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_11__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_12__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_12__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_12__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_13__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_13__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_13__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_14__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_14__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_14__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_15__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_15__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_15__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_16__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_16__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_16__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_17__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_17__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_17__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_18__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_18__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_18__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_0__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_0__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_0__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_1__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_1__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_1__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_2__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_2__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_2__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_ba_3__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_3__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_ba_3__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_actn__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_actn__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_actn__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_actn__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_actn__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_actn__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_odt__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_odt__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_odt__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_odt__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_odt__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_odt__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_rank__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_rank__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rank__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_rank__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_rank__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_rank__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__data_shift  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_mc_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_phy_clock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_phase  ;
wire  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_data  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_phase_lock  ;
wire   _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__phy_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__temp_data  ;
reg  [3:0] _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__data_shift  ;

assign clklocken_reg_pom_int = (clklocken_reg_pom & (~dfien_reg_pom));
assign DTI_RESET_N_INT = dti_reset_n_int;
assign DTI_CKE_INT = dti_cke_int;
assign DTI_CS_INT = dti_cs_int;
assign DTI_CA_INT = dti_ca_int;
assign DTI_CA_L_INT = dti_ca_l_int;
assign DTI_BA_INT = dti_ba_int;
assign DTI_ACT_N_INT = dti_act_n_int;
assign DTI_ODT_INT = dti_odt_int;
assign DTI_RANK_INT = dti_rank_int;
assign dti_reset_n_tmp = (dfien_reg_pom ? DTI_RESET_N : DTI_RESET_N_CTL);
assign dti_cke_tmp = (dfien_reg_pom ? DTI_CKE : DTI_CKE_CTL);
assign dti_cs_tmp = (dfien_reg_pom ? DTI_CS : DTI_CS_CTL);
assign dti_ca_tmp = (dfien_reg_pom ? DTI_CA : DTI_CA_CTL);
assign dti_ca_l_tmp = (dfien_reg_pom ? DTI_CA_L : DTI_CA_L_CTL);
assign dti_ba_tmp = (dfien_reg_pom ? DTI_BA : DTI_BA_CTL);
assign dti_act_n_tmp = (dfien_reg_pom ? DTI_ACT_N : DTI_ACT_N_CTL);
assign dti_odt_tmp = (dfien_reg_pom ? DTI_ODT : DTI_ODT_CTL);
assign dti_rank_tmp = (dfien_reg_pom ? DTI_RANK : DTI_RANK_CTL);

assign _dti_gear_ctrl__dti_gear_phase__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_phase__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom  = clklocken_reg_pom_int;
assign _dti_gear_ctrl__dti_gear_phase__dti_dram_clock_disable  = dti_dram_clock_disable;
assign mc_phase_lock = _dti_gear_ctrl__dti_gear_phase__mc_phase_lock ;
assign mc_phase = _dti_gear_ctrl__dti_gear_phase__mc_phase ;

assign _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_rst__mc_phase  = mc_phase;
assign _dti_gear_ctrl__dti_gear_mc2phy_rst__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_rst__mc_data  = dti_reset_n_tmp;
assign dti_reset_n_int = _dti_gear_ctrl__dti_gear_mc2phy_rst__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_data  = dti_cke_tmp[0];
assign dti_cke_int[0] = _dti_gear_ctrl__dti_gear_mc2phy_cke_0__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_data  = dti_cke_tmp[1];
assign dti_cke_int[1] = _dti_gear_ctrl__dti_gear_mc2phy_cke_1__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_data  = dti_cs_tmp[0];
assign dti_cs_int[0] = _dti_gear_ctrl__dti_gear_mc2phy_cs_0__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_data  = dti_cs_tmp[1];
assign dti_cs_int[1] = _dti_gear_ctrl__dti_gear_mc2phy_cs_1__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_data  = dti_ca_tmp[0];
assign dti_ca_int[0] = _dti_gear_ctrl__dti_gear_mc2phy_ca_0__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_data  = dti_ca_tmp[1];
assign dti_ca_int[1] = _dti_gear_ctrl__dti_gear_mc2phy_ca_1__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_data  = dti_ca_tmp[2];
assign dti_ca_int[2] = _dti_gear_ctrl__dti_gear_mc2phy_ca_2__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_data  = dti_ca_tmp[3];
assign dti_ca_int[3] = _dti_gear_ctrl__dti_gear_mc2phy_ca_3__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_data  = dti_ca_tmp[4];
assign dti_ca_int[4] = _dti_gear_ctrl__dti_gear_mc2phy_ca_4__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_data  = dti_ca_tmp[5];
assign dti_ca_int[5] = _dti_gear_ctrl__dti_gear_mc2phy_ca_5__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_data  = dti_ca_tmp[6];
assign dti_ca_int[6] = _dti_gear_ctrl__dti_gear_mc2phy_ca_6__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_data  = dti_ca_tmp[7];
assign dti_ca_int[7] = _dti_gear_ctrl__dti_gear_mc2phy_ca_7__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_data  = dti_ca_tmp[8];
assign dti_ca_int[8] = _dti_gear_ctrl__dti_gear_mc2phy_ca_8__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_data  = dti_ca_tmp[9];
assign dti_ca_int[9] = _dti_gear_ctrl__dti_gear_mc2phy_ca_9__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_data  = dti_ca_tmp[10];
assign dti_ca_int[10] = _dti_gear_ctrl__dti_gear_mc2phy_ca_10__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_data  = dti_ca_tmp[11];
assign dti_ca_int[11] = _dti_gear_ctrl__dti_gear_mc2phy_ca_11__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_data  = dti_ca_tmp[12];
assign dti_ca_int[12] = _dti_gear_ctrl__dti_gear_mc2phy_ca_12__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_data  = dti_ca_tmp[13];
assign dti_ca_int[13] = _dti_gear_ctrl__dti_gear_mc2phy_ca_13__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_data  = dti_ca_tmp[14];
assign dti_ca_int[14] = _dti_gear_ctrl__dti_gear_mc2phy_ca_14__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_data  = dti_ca_tmp[15];
assign dti_ca_int[15] = _dti_gear_ctrl__dti_gear_mc2phy_ca_15__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_data  = dti_ca_tmp[16];
assign dti_ca_int[16] = _dti_gear_ctrl__dti_gear_mc2phy_ca_16__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_data  = dti_ca_tmp[17];
assign dti_ca_int[17] = _dti_gear_ctrl__dti_gear_mc2phy_ca_17__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_data  = dti_ca_tmp[18];
assign dti_ca_int[18] = _dti_gear_ctrl__dti_gear_mc2phy_ca_18__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_data  = dti_ca_l_tmp[0];
assign dti_ca_l_int[0] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_data  = dti_ca_l_tmp[1];
assign dti_ca_l_int[1] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_data  = dti_ca_l_tmp[2];
assign dti_ca_l_int[2] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_data  = dti_ca_l_tmp[3];
assign dti_ca_l_int[3] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_data  = dti_ca_l_tmp[4];
assign dti_ca_l_int[4] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_data  = dti_ca_l_tmp[5];
assign dti_ca_l_int[5] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_data  = dti_ca_l_tmp[6];
assign dti_ca_l_int[6] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_data  = dti_ca_l_tmp[7];
assign dti_ca_l_int[7] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_data  = dti_ca_l_tmp[8];
assign dti_ca_l_int[8] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_data  = dti_ca_l_tmp[9];
assign dti_ca_l_int[9] = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_data  = dti_ba_tmp[0];
assign dti_ba_int[0] = _dti_gear_ctrl__dti_gear_mc2phy_ba_0__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_data  = dti_ba_tmp[1];
assign dti_ba_int[1] = _dti_gear_ctrl__dti_gear_mc2phy_ba_1__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_data  = dti_ba_tmp[2];
assign dti_ba_int[2] = _dti_gear_ctrl__dti_gear_mc2phy_ba_2__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_phase  = mc_phase[1:0];
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_data  = dti_ba_tmp[3];
assign dti_ba_int[3] = _dti_gear_ctrl__dti_gear_mc2phy_ba_3__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_actn__mc_phase  = mc_phase;
assign _dti_gear_ctrl__dti_gear_mc2phy_actn__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_actn__mc_data  = dti_act_n_tmp;
assign dti_act_n_int = _dti_gear_ctrl__dti_gear_mc2phy_actn__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_odt__mc_phase  = mc_phase;
assign _dti_gear_ctrl__dti_gear_mc2phy_odt__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_odt__mc_data  = dti_odt_tmp;
assign dti_odt_int = _dti_gear_ctrl__dti_gear_mc2phy_odt__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_rank__mc_phase  = mc_phase;
assign _dti_gear_ctrl__dti_gear_mc2phy_rank__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_rank__mc_data  = dti_rank_tmp;
assign dti_rank_int = _dti_gear_ctrl__dti_gear_mc2phy_rank__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_phase  = mc_phase;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_data  = {{({{(2){{1'b0}}}})  ,  DTI_CALVL_LOAD_INT  ,  DTI_CALVL_LOAD_INT}};
assign DTI_CALVL_LOAD = _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_phase  = mc_phase;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_data  = {{({{(2){{1'b0}}}})  ,  DTI_CALVL_CAPTURE_INT  ,  DTI_CALVL_CAPTURE_INT}};
assign DTI_CALVL_CAPTURE = _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__phy_data ;

assign _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_phase  = mc_phase;
assign _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_data  = {{({{(2){{1'b0}}}})  ,  DTI_CMDDLY_LOAD_INT  ,  DTI_CMDDLY_LOAD_INT}};
assign DTI_CMDDLY_LOAD = _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__phy_data ;
assign _dti_gear_ctrl__dti_gear_phase__phase_clr_pulse  = (_dti_gear_ctrl__dti_gear_phase__mc_cnt_cld  ^ _dti_gear_ctrl__dti_gear_phase__mc_cnt_cld_d1 );

always @( posedge _dti_gear_ctrl__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom_cld  <= 1'b0;
end
else
begin
_dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom_cld  <= _dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_phase__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_phase__mc_cnt  <= 1'b0;
end
else
begin
_dti_gear_ctrl__dti_gear_phase__mc_cnt  <= (~_dti_gear_ctrl__dti_gear_phase__mc_cnt );
end
end


always @( posedge _dti_gear_ctrl__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_phase__mc_cnt_cld  <= 1'b0;
_dti_gear_ctrl__dti_gear_phase__mc_cnt_cld_d1  <= 1'b0;
end
else
begin
_dti_gear_ctrl__dti_gear_phase__mc_cnt_cld  <= _dti_gear_ctrl__dti_gear_phase__mc_cnt ;
_dti_gear_ctrl__dti_gear_phase__mc_cnt_cld_d1  <= _dti_gear_ctrl__dti_gear_phase__mc_cnt_cld ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_phase__mc_phase_lock  <= 1'b0;
end
else
if (((_dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom  & (~_dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom_cld )) | _dti_gear_ctrl__dti_gear_phase__dti_dram_clock_disable ))
begin
_dti_gear_ctrl__dti_gear_phase__mc_phase_lock  <= 1'b0;
end
else
if ((((_dti_gear_ctrl__dti_gear_phase__clklocken_reg_pom_cld  | (~_dti_gear_ctrl__dti_gear_phase__dti_dram_clock_disable )) & (~_dti_gear_ctrl__dti_gear_phase__mc_phase_lock )) & _dti_gear_ctrl__dti_gear_phase__phase_clr_pulse ))
begin
_dti_gear_ctrl__dti_gear_phase__mc_phase_lock  <= 1'b1;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_phase__mc_phase  <= 2'b00;
end
else
if ((~_dti_gear_ctrl__dti_gear_phase__mc_phase_lock ))
begin
_dti_gear_ctrl__dti_gear_phase__mc_phase  <= 2'b00;
end
else
if (_dti_gear_ctrl__dti_gear_phase__phase_clr_pulse )
begin
_dti_gear_ctrl__dti_gear_phase__mc_phase  <= 2'b00;
end
else
begin
_dti_gear_ctrl__dti_gear_phase__mc_phase  <= (_dti_gear_ctrl__dti_gear_phase__mc_phase  + 2'b01);
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_rst__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_rst__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_rst__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_rst__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_rst__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_rst__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_rst__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_rst__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_rst__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_rst__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_rst__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_rst__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_rst__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_rst__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_rst__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_rst__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_rst__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_0__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_0__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cke_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_0__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_cke_0__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_cke_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cke_0__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_cke_0__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_cke_0__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cke_0__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_cke_0__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_cke_0__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_1__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_1__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cke_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_1__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_cke_1__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_cke_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cke_1__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_cke_1__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_cke_1__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cke_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cke_1__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_cke_1__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_cke_1__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_0__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_0__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cs_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_0__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_cs_0__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_cs_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cs_0__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_cs_0__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_cs_0__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cs_0__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_cs_0__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_cs_0__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_1__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_1__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cs_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_1__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_cs_1__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_cs_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cs_1__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_cs_1__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_cs_1__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cs_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cs_1__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_cs_1__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_cs_1__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_0__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_0__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_0__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_0__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_0__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_0__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_0__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_0__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_0__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_0__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_1__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_1__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_1__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_1__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_1__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_1__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_1__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_1__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_1__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_1__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_2__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_2__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_2__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_2__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_2__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_2__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_2__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_2__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_2__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_2__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_2__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_2__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_2__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_3__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_3__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_3__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_3__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_3__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_3__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_3__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_3__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_3__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_3__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_3__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_3__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_3__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_4__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_4__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_4__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_4__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_4__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_4__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_4__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_4__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_4__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_4__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_4__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_4__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_4__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_5__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_5__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_5__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_5__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_5__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_5__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_5__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_5__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_5__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_5__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_5__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_5__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_5__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_6__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_6__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_6__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_6__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_6__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_6__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_6__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_6__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_6__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_6__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_6__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_6__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_6__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_7__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_7__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_7__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_7__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_7__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_7__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_7__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_7__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_7__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_7__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_7__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_7__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_7__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_8__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_8__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_8__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_8__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_8__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_8__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_8__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_8__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_8__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_8__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_8__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_8__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_8__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_9__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_9__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_9__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_9__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_9__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_9__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_9__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_9__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_9__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_9__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_9__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_9__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_9__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_10__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_10__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_10__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_10__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_10__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_10__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_10__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_10__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_10__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_10__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_10__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_10__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_10__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_11__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_11__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_11__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_11__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_11__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_11__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_11__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_11__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_11__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_11__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_11__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_11__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_11__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_12__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_12__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_12__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_12__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_12__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_12__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_12__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_12__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_12__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_12__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_12__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_12__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_12__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_13__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_13__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_13__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_13__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_13__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_13__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_13__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_13__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_13__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_13__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_13__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_13__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_13__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_14__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_14__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_14__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_14__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_14__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_14__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_14__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_14__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_14__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_14__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_14__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_14__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_14__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_15__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_15__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_15__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_15__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_15__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_15__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_15__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_15__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_15__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_15__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_15__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_15__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_15__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_16__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_16__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_16__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_16__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_16__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_16__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_16__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_16__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_16__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_16__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_16__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_16__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_16__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_17__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_17__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_17__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_17__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_17__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_17__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_17__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_17__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_17__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_17__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_17__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_17__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_17__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_18__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_18__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_18__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_18__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_18__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_18__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_18__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_18__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_18__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_18__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_18__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_18__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_18__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_0__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_1__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_2__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_3__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_4__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_5__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_6__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_7__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_8__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ca_l_9__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_0__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_0__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_0__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_0__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ba_0__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ba_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_0__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ba_0__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ba_0__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_0__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_0__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_0__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ba_0__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_1__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_1__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_1__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_1__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ba_1__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ba_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_1__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ba_1__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ba_1__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_1__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_1__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_1__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ba_1__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_2__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_2__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_2__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_2__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ba_2__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ba_2__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_2__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ba_2__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ba_2__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_2__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_2__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_2__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ba_2__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_3__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_3__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_ba_3__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_3__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_ba_3__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_ba_3__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_3__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_ba_3__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_ba_3__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_ba_3__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_ba_3__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_ba_3__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_ba_3__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_actn__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_actn__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_actn__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_actn__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_actn__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_actn__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_actn__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_actn__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_actn__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_actn__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_actn__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_actn__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_actn__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_actn__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_actn__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_actn__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_actn__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_odt__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_odt__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_odt__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_odt__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_odt__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_odt__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_odt__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_odt__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_odt__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_odt__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_odt__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_odt__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_odt__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_odt__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_odt__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_odt__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_odt__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_rank__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_rank__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_rank__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_rank__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_rank__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_rank__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_rank__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_rank__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_rank__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_rank__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_rank__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_rank__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_rank__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_rank__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_rank__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_rank__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_rank__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_load__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_calvl_load__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_calvl_capture__data_shift [0];

always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_mc_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__temp_data  <= 0;
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__temp_data  <= _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_data ;
end
end


always @( posedge _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_phy_clock  or negedge _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__dti_sys_reset_n ))
begin
_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__data_shift  <= 0;
end
else
if (_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_phase_lock )
begin
case (_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__mc_phase )
2'd0: _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__temp_data ;
default: _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__data_shift  <= {{1'b0  ,  _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__data_shift  <= _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__temp_data ;
end
end

assign _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__phy_data  = _dti_gear_ctrl__dti_gear_mc2phy_cmddly_load__data_shift [0];

endmodule