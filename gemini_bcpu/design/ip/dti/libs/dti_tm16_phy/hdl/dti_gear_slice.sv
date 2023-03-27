
module dti_gear_slice (dti_mc_clock  ,  dti_phy_clock  ,  dti_mc_clock_180  ,  dti_phy_clock_180  ,  dti_sys_reset_n  ,  clklocken_reg_pom  ,  dti_dram_clock_disable  ,  dfien_reg_pom  ,  mc_phase_lock  ,  dqsleadck  ,  dti_freq_ratio  ,  dqs2ck_en  ,  DTI_WRDATA_EN  ,  DTI_WRDATA  ,  DTI_WRDATA_MASK  ,  DTI_RANK_WR  ,  dti_wrdata_en_ctl  ,  dti_wrdata_ctl  ,  dti_wrdata_mask_ctl  ,  dti_rank_wr_ctl  ,  BYTE_WRDATA_EN  ,  BYTE_WRDATA  ,  BYTE_WRDATA_MASK  ,  BYTE_RANK_WR  ,  DTI_RDDATA_EN  ,  DTI_RDDATA  ,  DTI_RDDATA_MASK  ,  DTI_RDDATA_VALID  ,  DTI_RANK_RD  ,  dti_rddata_en_ctl  ,  dti_rank_rd_ctl  ,  BYTE_RDDATA_EN  ,  BYTE_RDDATA  ,  BYTE_RDDATA_MASK  ,  BYTE_RDDATA_VALID  ,  BYTE_RANK_RD  ,  DTI_CALVL_STB_INT  ,  DTI_CALVL_STB  ,  DTI_RDLVL_LOAD_INT  ,  DTI_RDLVL_LOAD  ,  DTI_WRLVL_LOAD_INT  ,  DTI_WRLVL_STB_INT  ,  DTI_WRLVL_LOAD  ,  DTI_WRLVL_STB  ,  DTI_WDQ_LOAD_INT  ,  DTI_WDQ_LOAD  ,  DTI_VREF_LOAD_INT  ,  DTI_VREF_LOAD);
input   dti_mc_clock ;
input   dti_phy_clock ;
input   dti_mc_clock_180 ;
input   dti_phy_clock_180 ;
input   dti_sys_reset_n ;
input   clklocken_reg_pom ;
input   dti_dram_clock_disable ;
input   dfien_reg_pom ;
output   mc_phase_lock ;
input  [1:0] dqsleadck ;
input  [1:0] dti_freq_ratio ;
input   dqs2ck_en ;
input  [3:0] DTI_WRDATA_EN ;
input  [63:0] DTI_WRDATA ;
input  [7:0] DTI_WRDATA_MASK ;
input  [3:0] DTI_RANK_WR ;
input  [3:0] dti_wrdata_en_ctl ;
input  [63:0] dti_wrdata_ctl ;
input  [7:0] dti_wrdata_mask_ctl ;
input  [3:0] dti_rank_wr_ctl ;
output   BYTE_WRDATA_EN ;
output  [15:0] BYTE_WRDATA ;
output  [1:0] BYTE_WRDATA_MASK ;
output   BYTE_RANK_WR ;
input  [3:0] DTI_RDDATA_EN ;
output  [63:0] DTI_RDDATA ;
output  [7:0] DTI_RDDATA_MASK ;
output  [3:0] DTI_RDDATA_VALID ;
input  [3:0] DTI_RANK_RD ;
input  [3:0] dti_rddata_en_ctl ;
input  [3:0] dti_rank_rd_ctl ;
output   BYTE_RDDATA_EN ;
input  [15:0] BYTE_RDDATA ;
input  [1:0] BYTE_RDDATA_MASK ;
input   BYTE_RDDATA_VALID ;
output   BYTE_RANK_RD ;
input   DTI_CALVL_STB_INT ;
output   DTI_CALVL_STB ;
input   DTI_RDLVL_LOAD_INT ;
output   DTI_RDLVL_LOAD ;
input   DTI_WRLVL_LOAD_INT ;
input   DTI_WRLVL_STB_INT ;
output   DTI_WRLVL_LOAD ;
output   DTI_WRLVL_STB ;
input   DTI_WDQ_LOAD_INT ;
output   DTI_WDQ_LOAD ;
input   DTI_VREF_LOAD_INT ;
output   DTI_VREF_LOAD ;
wire  [1:0] mc_phase ;
wire  [3:0] dti_wrdata_en_tmp ;
wire  [15:0][3:0] dti_wrdata_tmp ;
wire  [1:0][3:0] dti_wrdata_mask_tmp ;
wire  [3:0] dti_rank_wr_tmp ;
wire   dti_wrdata_en_int ;
wire  [15:0] dti_wrdata_int ;
wire  [1:0] dti_wrdata_mask_int ;
wire   dti_rank_wr_int ;
reg   dti_wrdata_en_cld ;
reg  [15:0] dti_wrdata_cld ;
reg  [1:0] dti_wrdata_mask_cld ;
reg   dti_rank_wr_cld ;
wire  [3:0] dti_rddata_en_tmp ;
wire  [3:0] dti_rank_rd_tmp ;
wire   dti_rddata_en_int ;
wire   dti_rank_rd_int ;
wire  [15:0][3:0] dti_rddata_tmp ;
wire  [1:0][3:0] dti_rddata_mask_tmp ;
wire  [3:0] dti_rddata_valid_tmp ;
wire   need_hold_wr ;
reg   need_hold_wr_cld ;
wire   clklocken_reg_pom_int ;
wire   _dti_gear_slice__dti_gear_phase__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_phase__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_phase__dti_sys_reset_n  ;
wire   _dti_gear_slice__dti_gear_phase__clklocken_reg_pom  ;
wire   _dti_gear_slice__dti_gear_phase__dti_dram_clock_disable  ;
reg   _dti_gear_slice__dti_gear_phase__mc_phase_lock  ;
reg  [1:0] _dti_gear_slice__dti_gear_phase__mc_phase  ;
reg   _dti_gear_slice__dti_gear_phase__clklocken_reg_pom_cld  ;
reg   _dti_gear_slice__dti_gear_phase__mc_cnt  ;
reg   _dti_gear_slice__dti_gear_phase__mc_cnt_cld  ;
reg   _dti_gear_slice__dti_gear_phase__mc_cnt_cld_d1  ;
wire   _dti_gear_slice__dti_gear_phase__phase_clr_pulse  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wren__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wren__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wren__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_wren__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_wren__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wren__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wren__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wren__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wren__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_rankwr__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_rankwr__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankwr__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankwr__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rankwr__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rankwr__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask0__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrmask0__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrmask0__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrmask1__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrmask1__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrmask1__data_shift  ;
wire   _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_mc_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_phy_clock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_sys_reset_n  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_phase  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_phase_lock  ;

wire   _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__phy_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__temp_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__data_shift  ;

wire   _dti_gear_slice__dti_gear_mc2phy_rden__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rden__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rden__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_rden__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_rden__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rden__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rden__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rden__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rden__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_rankrd__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_rankrd__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankrd__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rankrd__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rankrd__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rankrd__data_shift  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_valid  ;
wire  [1:0] _dti_gear_slice__dti_gear_phy2mc_rdvld__dti_freq_ratio  ;
wire   _dti_gear_slice__dti_gear_phy2mc_rdvld__clk  ;
wire   _dti_gear_slice__dti_gear_phy2mc_rdvld__valid  ;
wire   _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  ;
wire   _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_clk  ;
wire   _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_clk_180  ;
wire   _dti_gear_slice__dti_gear_phy2mc_rdvld__clk_180  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__valid_ff  ;
reg  [1:0] _dti_gear_slice__dti_gear_phy2mc_rdvld__count  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__enable  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__enable_d1  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__sel_path  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path_d1  ;
reg  [3:0] _dti_gear_slice__dti_gear_phy2mc_rdvld__shift_valid  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__validout  ;
reg   _dti_gear_slice__dti_gear_phy2mc_rdvld__neg_valid  ;
wire   _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_valid_muxout  ;
wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_data_nxt  ;

wire  [1:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dti_freq_ratio  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_data  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_clk  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_clk_180  ;

wire   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__clk_180  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data_ff  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid_ff  ;

reg  [1:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__count  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable_d1  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__sel_path  ;

reg   _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_sel_path  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dataout  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__neg_data  ;

reg  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_valid  ;

wire  [3:0] _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_data_nxt  ;

wire   _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_calvl_stb__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_calvl_stb__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_calvl_stb__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_wdq_load__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wdq_load__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_wdq_load__data_shift  ;
wire   _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_mc_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_phy_clock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_sys_reset_n  ;
wire  [1:0] _dti_gear_slice__dti_gear_mc2phy_vref_load__mc_phase  ;
wire  [3:0] _dti_gear_slice__dti_gear_mc2phy_vref_load__mc_data  ;
wire   _dti_gear_slice__dti_gear_mc2phy_vref_load__mc_phase_lock  ;
wire   _dti_gear_slice__dti_gear_mc2phy_vref_load__phy_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_vref_load__temp_data  ;
reg  [3:0] _dti_gear_slice__dti_gear_mc2phy_vref_load__data_shift  ;

assign clklocken_reg_pom_int = (clklocken_reg_pom & (~dfien_reg_pom));
assign dti_wrdata_tmp = (dfien_reg_pom ? DTI_WRDATA : dti_wrdata_ctl);
assign dti_wrdata_mask_tmp = (dfien_reg_pom ? DTI_WRDATA_MASK : dti_wrdata_mask_ctl);
assign dti_wrdata_en_tmp = (dfien_reg_pom ? DTI_WRDATA_EN : dti_wrdata_en_ctl);
assign dti_rank_wr_tmp = (dfien_reg_pom ? DTI_RANK_WR : dti_rank_wr_ctl);
assign need_hold_wr = (dqs2ck_en & ((((dqsleadck[1] & dti_rank_wr_int) | (dqsleadck[0] & (~dti_rank_wr_int))) | (dqsleadck[1] & dti_rank_wr_cld)) | (dqsleadck[0] & (~dti_rank_wr_cld))));
assign BYTE_WRDATA_EN = (need_hold_wr ? dti_wrdata_en_cld : dti_wrdata_en_int);
assign BYTE_WRDATA = (need_hold_wr_cld ? dti_wrdata_cld : dti_wrdata_int);
assign BYTE_WRDATA_MASK = (need_hold_wr_cld ? dti_wrdata_mask_cld : dti_wrdata_mask_int);
assign BYTE_RANK_WR = (need_hold_wr_cld ? dti_rank_wr_cld : dti_rank_wr_int);
assign dti_rddata_en_tmp = (dfien_reg_pom ? DTI_RDDATA_EN : dti_rddata_en_ctl);
assign dti_rank_rd_tmp = (dfien_reg_pom ? DTI_RANK_RD : dti_rank_rd_ctl);
assign BYTE_RDDATA_EN = dti_rddata_en_int;
assign BYTE_RANK_RD = dti_rank_rd_int;
assign DTI_RDDATA_VALID = dti_rddata_valid_tmp;
assign DTI_RDDATA_MASK = dti_rddata_mask_tmp;
assign DTI_RDDATA = dti_rddata_tmp;

always @( posedge dti_phy_clock or negedge dti_sys_reset_n )
begin
if ((~dti_sys_reset_n))
begin
need_hold_wr_cld <= 0;
dti_wrdata_en_cld <= 0;
dti_wrdata_cld <= 0;
dti_wrdata_mask_cld <= 0;
dti_rank_wr_cld <= 0;
end
else
begin
need_hold_wr_cld <= need_hold_wr;
dti_wrdata_en_cld <= dti_wrdata_en_int;
dti_wrdata_cld <= dti_wrdata_int;
dti_wrdata_mask_cld <= dti_wrdata_mask_int;
dti_rank_wr_cld <= dti_rank_wr_int;
end
end

assign dti_rddata_valid_tmp[3:1] = ({{(3){{dti_rddata_valid_tmp[0]}}}});

assign _dti_gear_slice__dti_gear_phase__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_phase__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_phase__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_phase__clklocken_reg_pom  = clklocken_reg_pom_int;
assign _dti_gear_slice__dti_gear_phase__dti_dram_clock_disable  = dti_dram_clock_disable;
assign mc_phase_lock = _dti_gear_slice__dti_gear_phase__mc_phase_lock ;
assign mc_phase = _dti_gear_slice__dti_gear_phase__mc_phase ;

assign _dti_gear_slice__dti_gear_mc2phy_wren__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wren__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wren__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_wren__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_wren__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_wren__mc_data  = dti_wrdata_en_tmp;
assign dti_wrdata_en_int = _dti_gear_slice__dti_gear_mc2phy_wren__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_rankwr__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_rankwr__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_rankwr__mc_data  = dti_rank_wr_tmp;
assign dti_rank_wr_int = _dti_gear_slice__dti_gear_mc2phy_rankwr__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_data  = dti_wrdata_mask_tmp[0];
assign dti_wrdata_mask_int[0] = _dti_gear_slice__dti_gear_mc2phy_wrmask0__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_data  = dti_wrdata_mask_tmp[1];
assign dti_wrdata_mask_int[1] = _dti_gear_slice__dti_gear_mc2phy_wrmask1__phy_data ;

assign _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[0];

assign dti_wrdata_int[0] = _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[1];

assign dti_wrdata_int[1] = _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[2];

assign dti_wrdata_int[2] = _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[3];

assign dti_wrdata_int[3] = _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[4];

assign dti_wrdata_int[4] = _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[5];

assign dti_wrdata_int[5] = _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[6];

assign dti_wrdata_int[6] = _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[7];

assign dti_wrdata_int[7] = _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[8];

assign dti_wrdata_int[8] = _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[9];

assign dti_wrdata_int[9] = _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[10];

assign dti_wrdata_int[10] = _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[11];

assign dti_wrdata_int[11] = _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[12];

assign dti_wrdata_int[12] = _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[13];

assign dti_wrdata_int[13] = _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[14];

assign dti_wrdata_int[14] = _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_mc_clock  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_phy_clock  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_sys_reset_n  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_phase  = mc_phase;

assign _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_phase_lock  = mc_phase_lock;

assign _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_data  = dti_wrdata_tmp[15];

assign dti_wrdata_int[15] = _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__phy_data ;


assign _dti_gear_slice__dti_gear_mc2phy_rden__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rden__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rden__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_rden__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_rden__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_rden__mc_data  = dti_rddata_en_tmp;
assign dti_rddata_en_int = _dti_gear_slice__dti_gear_mc2phy_rden__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_rankrd__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_rankrd__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_rankrd__mc_data  = dti_rank_rd_tmp;
assign dti_rank_rd_int = _dti_gear_slice__dti_gear_mc2phy_rankrd__phy_data ;

assign _dti_gear_slice__dti_gear_phy2mc_rdvld__dti_freq_ratio  = dti_freq_ratio;
assign dti_rddata_valid_tmp[0] = _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_valid ;
assign _dti_gear_slice__dti_gear_phy2mc_rdvld__valid  = BYTE_RDDATA_VALID;
assign _dti_gear_slice__dti_gear_phy2mc_rdvld__clk  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_clk  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_clk_180  = dti_mc_clock_180;
assign _dti_gear_slice__dti_gear_phy2mc_rdvld__clk_180  = dti_phy_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[0] = _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[0];

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[1] = _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[1];

assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[2] = _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[2];

assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[3] = _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[3];

assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[4] = _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[4];

assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[5] = _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[5];

assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[6] = _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[6];

assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[7] = _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[7];

assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[8] = _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[8];

assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[9] = _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[9];

assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[10] = _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[10];

assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[11] = _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[11];

assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[12] = _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[12];

assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[13] = _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[13];

assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[14] = _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[14];

assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_tmp[15] = _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data  = BYTE_RDDATA[15];

assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_mask_tmp[0] = _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data  = BYTE_RDDATA_MASK[0];

assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dti_freq_ratio  = dti_freq_ratio;

assign dti_rddata_mask_tmp[1] = _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_data ;

assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data  = BYTE_RDDATA_MASK[1];

assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid  = BYTE_RDDATA_VALID;

assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__clk  = dti_phy_clock;

assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  = dti_sys_reset_n;

assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_clk  = dti_mc_clock;

assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_clk_180  = dti_mc_clock_180;

assign _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__clk_180  = dti_phy_clock_180;


assign _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_data  = {{({{(3){{1'b0}}}})  ,  DTI_CALVL_STB_INT}};
assign DTI_CALVL_STB = _dti_gear_slice__dti_gear_mc2phy_calvl_stb__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_data  = {{({{(2){{1'b0}}}})  ,  DTI_RDLVL_LOAD_INT  ,  DTI_RDLVL_LOAD_INT}};
assign DTI_RDLVL_LOAD = _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_data  = {{({{(2){{1'b0}}}})  ,  DTI_WRLVL_LOAD_INT  ,  DTI_WRLVL_LOAD_INT}};
assign DTI_WRLVL_LOAD = _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_data  = {{({{(3){{1'b0}}}})  ,  DTI_WRLVL_STB_INT}};
assign DTI_WRLVL_STB = _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_data  = {{({{(2){{1'b0}}}})  ,  DTI_WDQ_LOAD_INT  ,  DTI_WDQ_LOAD_INT}};
assign DTI_WDQ_LOAD = _dti_gear_slice__dti_gear_mc2phy_wdq_load__phy_data ;

assign _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_mc_clock  = dti_mc_clock;
assign _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_phy_clock  = dti_phy_clock;
assign _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_sys_reset_n  = dti_sys_reset_n;
assign _dti_gear_slice__dti_gear_mc2phy_vref_load__mc_phase  = mc_phase;
assign _dti_gear_slice__dti_gear_mc2phy_vref_load__mc_phase_lock  = mc_phase_lock;
assign _dti_gear_slice__dti_gear_mc2phy_vref_load__mc_data  = {{({{(2){{1'b0}}}})  ,  DTI_VREF_LOAD_INT  ,  DTI_VREF_LOAD_INT}};
assign DTI_VREF_LOAD = _dti_gear_slice__dti_gear_mc2phy_vref_load__phy_data ;
assign _dti_gear_slice__dti_gear_phase__phase_clr_pulse  = (_dti_gear_slice__dti_gear_phase__mc_cnt_cld  ^ _dti_gear_slice__dti_gear_phase__mc_cnt_cld_d1 );

always @( posedge _dti_gear_slice__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_phase__clklocken_reg_pom_cld  <= 1'b0;
end
else
begin
_dti_gear_slice__dti_gear_phase__clklocken_reg_pom_cld  <= _dti_gear_slice__dti_gear_phase__clklocken_reg_pom ;
end
end


always @( posedge _dti_gear_slice__dti_gear_phase__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_phase__mc_cnt  <= 1'b0;
end
else
begin
_dti_gear_slice__dti_gear_phase__mc_cnt  <= (~_dti_gear_slice__dti_gear_phase__mc_cnt );
end
end


always @( posedge _dti_gear_slice__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_phase__mc_cnt_cld  <= 1'b0;
_dti_gear_slice__dti_gear_phase__mc_cnt_cld_d1  <= 1'b0;
end
else
begin
_dti_gear_slice__dti_gear_phase__mc_cnt_cld  <= _dti_gear_slice__dti_gear_phase__mc_cnt ;
_dti_gear_slice__dti_gear_phase__mc_cnt_cld_d1  <= _dti_gear_slice__dti_gear_phase__mc_cnt_cld ;
end
end


always @( posedge _dti_gear_slice__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_phase__mc_phase_lock  <= 1'b0;
end
else
if (((_dti_gear_slice__dti_gear_phase__clklocken_reg_pom  & (~_dti_gear_slice__dti_gear_phase__clklocken_reg_pom_cld )) | _dti_gear_slice__dti_gear_phase__dti_dram_clock_disable ))
begin
_dti_gear_slice__dti_gear_phase__mc_phase_lock  <= 1'b0;
end
else
if ((((_dti_gear_slice__dti_gear_phase__clklocken_reg_pom_cld  | (~_dti_gear_slice__dti_gear_phase__dti_dram_clock_disable )) & (~_dti_gear_slice__dti_gear_phase__mc_phase_lock )) & _dti_gear_slice__dti_gear_phase__phase_clr_pulse ))
begin
_dti_gear_slice__dti_gear_phase__mc_phase_lock  <= 1'b1;
end
end


always @( posedge _dti_gear_slice__dti_gear_phase__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_phase__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_phase__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_phase__mc_phase  <= 2'b00;
end
else
if ((~_dti_gear_slice__dti_gear_phase__mc_phase_lock ))
begin
_dti_gear_slice__dti_gear_phase__mc_phase  <= 2'b00;
end
else
if (_dti_gear_slice__dti_gear_phase__phase_clr_pulse )
begin
_dti_gear_slice__dti_gear_phase__mc_phase  <= 2'b00;
end
else
begin
_dti_gear_slice__dti_gear_phase__mc_phase  <= (_dti_gear_slice__dti_gear_phase__mc_phase  + 2'b01);
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_wren__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wren__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wren__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wren__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wren__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_wren__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_wren__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wren__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wren__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wren__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_wren__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_wren__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_wren__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wren__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_wren__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_wren__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wren__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wren__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_wren__phy_data  = _dti_gear_slice__dti_gear_mc2phy_wren__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rankwr__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rankwr__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rankwr__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_rankwr__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rankwr__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rankwr__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rankwr__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_rankwr__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_rankwr__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_rankwr__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rankwr__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_rankwr__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_rankwr__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rankwr__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rankwr__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_rankwr__phy_data  = _dti_gear_slice__dti_gear_mc2phy_rankwr__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask0__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask0__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrmask0__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask0__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_wrmask0__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_wrmask0__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrmask0__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_wrmask0__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_wrmask0__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask0__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrmask0__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_wrmask0__phy_data  = _dti_gear_slice__dti_gear_mc2phy_wrmask0__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask1__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask1__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrmask1__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask1__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_wrmask1__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_wrmask1__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrmask1__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_wrmask1__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_wrmask1__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrmask1__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrmask1__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_wrmask1__phy_data  = _dti_gear_slice__dti_gear_mc2phy_wrmask1__data_shift [0];

always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_0_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_1_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_2_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_3_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_4_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_5_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_6_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_7_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_8_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_9_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_10_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_11_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_12_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_13_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_14_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_mc_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__temp_data  <= 0;

end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__temp_data  <= _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_phy_clock  or negedge _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_sys_reset_n  )

begin
if ((~_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__dti_sys_reset_n ))

begin
_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__data_shift  <= 0;

end
else
if (_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_phase_lock )

begin
case (_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__mc_phase )

2'd0: _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__temp_data ;

default: _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__data_shift  <= {{1'b0  ,  _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__data_shift [3:1]}};

endcase
end
else
begin
_dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__data_shift  <= _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__temp_data ;

end
end

assign _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__phy_data  = _dti_gear_slice____PROC_GEAR_WRDATA_15_dti_gear_mc2phy_wrdata__data_shift [0];


always @( posedge _dti_gear_slice__dti_gear_mc2phy_rden__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rden__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rden__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rden__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rden__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_rden__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_rden__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rden__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rden__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rden__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_rden__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_rden__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_rden__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rden__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_rden__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_rden__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rden__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rden__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_rden__phy_data  = _dti_gear_slice__dti_gear_mc2phy_rden__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rankrd__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rankrd__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rankrd__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_rankrd__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rankrd__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rankrd__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rankrd__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_rankrd__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_rankrd__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_rankrd__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rankrd__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_rankrd__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_rankrd__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rankrd__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rankrd__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_rankrd__phy_data  = _dti_gear_slice__dti_gear_mc2phy_rankrd__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_phy2mc_rdvld__clk  or negedge _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  )
begin
if ((!_dti_gear_slice__dti_gear_phy2mc_rdvld__rn ))
_dti_gear_slice__dti_gear_phy2mc_rdvld__valid_ff  <= 1'b0;
else
_dti_gear_slice__dti_gear_phy2mc_rdvld__valid_ff  <= _dti_gear_slice__dti_gear_phy2mc_rdvld__valid ;
end


always @( posedge _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_clk_180  or negedge _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  )
begin
if ((!_dti_gear_slice__dti_gear_phy2mc_rdvld__rn ))
begin
_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path  <= 1'b0;
_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path_d1  <= 1'b0;
end
else
begin
_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path  <= _dti_gear_slice__dti_gear_phy2mc_rdvld__sel_path ;
_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path_d1  <= _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path ;
end
end


always @( posedge _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_clk  or negedge _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  )
begin
if ((!_dti_gear_slice__dti_gear_phy2mc_rdvld__rn ))
_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_valid  <= 1'b0;
else
_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_valid  <= ((_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path  ? _dti_gear_slice__dti_gear_phy2mc_rdvld__validout  : _dti_gear_slice__dti_gear_phy2mc_rdvld__neg_valid ) & (_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path  | (~_dti_gear_slice__dti_gear_phy2mc_rdvld__mc_sel_path_d1 )));
end


always @( posedge _dti_gear_slice__dti_gear_phy2mc_rdvld__clk  or negedge _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  )
begin
if ((!_dti_gear_slice__dti_gear_phy2mc_rdvld__rn ))
begin
_dti_gear_slice__dti_gear_phy2mc_rdvld__shift_valid  <= 4'b0000;
_dti_gear_slice__dti_gear_phy2mc_rdvld__validout  <= 1'b0;
_dti_gear_slice__dti_gear_phy2mc_rdvld__count  <= 2'b00;
_dti_gear_slice__dti_gear_phy2mc_rdvld__enable  <= 1'b0;
_dti_gear_slice__dti_gear_phy2mc_rdvld__enable_d1  <= 1'b0;
end
else
begin
_dti_gear_slice__dti_gear_phy2mc_rdvld__shift_valid  <= ((_dti_gear_slice__dti_gear_phy2mc_rdvld__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice__dti_gear_phy2mc_rdvld__valid_ff   ,  _dti_gear_slice__dti_gear_phy2mc_rdvld__shift_valid [3:1]}} : {{_dti_gear_slice__dti_gear_phy2mc_rdvld__valid_ff   ,  _dti_gear_slice__dti_gear_phy2mc_rdvld__shift_valid [1]}});
_dti_gear_slice__dti_gear_phy2mc_rdvld__validout  <= _dti_gear_slice__dti_gear_phy2mc_rdvld__shift_valid [0];
_dti_gear_slice__dti_gear_phy2mc_rdvld__count  <= (_dti_gear_slice__dti_gear_phy2mc_rdvld__valid_ff  ? (_dti_gear_slice__dti_gear_phy2mc_rdvld__count  + 1) : 2'b00);
_dti_gear_slice__dti_gear_phy2mc_rdvld__enable  <= ((_dti_gear_slice__dti_gear_phy2mc_rdvld__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice__dti_gear_phy2mc_rdvld__count [1] & _dti_gear_slice__dti_gear_phy2mc_rdvld__count [0]) : _dti_gear_slice__dti_gear_phy2mc_rdvld__count [0]);
_dti_gear_slice__dti_gear_phy2mc_rdvld__enable_d1  <= _dti_gear_slice__dti_gear_phy2mc_rdvld__enable ;
end
end


always @( posedge _dti_gear_slice__dti_gear_phy2mc_rdvld__clk_180  or negedge _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  )
if ((!_dti_gear_slice__dti_gear_phy2mc_rdvld__rn ))
_dti_gear_slice__dti_gear_phy2mc_rdvld__sel_path  <= 1'b0;
else
_dti_gear_slice__dti_gear_phy2mc_rdvld__sel_path  <= ((_dti_gear_slice__dti_gear_phy2mc_rdvld__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice__dti_gear_phy2mc_rdvld__enable  | _dti_gear_slice__dti_gear_phy2mc_rdvld__enable_d1 ) : _dti_gear_slice__dti_gear_phy2mc_rdvld__enable );


always @( posedge _dti_gear_slice__dti_gear_phy2mc_rdvld__mc_clk_180  or negedge _dti_gear_slice__dti_gear_phy2mc_rdvld__rn  )
begin
if ((!_dti_gear_slice__dti_gear_phy2mc_rdvld__rn ))
_dti_gear_slice__dti_gear_phy2mc_rdvld__neg_valid  <= 1'b0;
else
_dti_gear_slice__dti_gear_phy2mc_rdvld__neg_valid  <= _dti_gear_slice__dti_gear_phy2mc_rdvld__validout ;
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_0_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_1_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_2_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_3_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_4_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_5_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_6_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_7_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_8_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_9_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_10_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_11_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_12_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_13_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_14_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid ;

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data_ff  <= _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dataout  : _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__clk  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dataout  <= (_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable  ? _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__shift_data  : _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dataout );

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__count  <= (_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__count [1] & _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__count [0]) : _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__count [0]);

_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable  | _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__neg_data  <= _dti_gear_slice____PROC_GEAR_RDDATA_15_dti_gear_phy2mc_rddata__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__clk  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid ;

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data_ff  <= _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dataout  : _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__clk  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dataout  <= (_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable  ? _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__shift_data  : _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dataout );

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__count  <= (_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__count [1] & _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__count [0]) : _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__count [0]);

_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable  | _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__neg_data  <= _dti_gear_slice____PROC_GEAR_RDMASK_0_dti_gear_phy2mc_rdmask__dataout ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__clk  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid_ff  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data_ff  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid_ff  <= _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid ;

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data_ff  <= _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_sel_path  <= _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__sel_path ;

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_clk  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_data  <= (_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_sel_path  ? _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dataout  : _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__neg_data );

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__clk  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_data  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_valid  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dataout  <= 4'b0000;

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__count  <= 2'b00;

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable  <= 1'b0;

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable_d1  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_data  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_data [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__data_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_data [1]}});

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_valid  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? {{_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_valid [3:1]}} : {{_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid_ff   ,  _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_valid [1]}});

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dataout  <= (_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable  ? _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__shift_data  : _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dataout );

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__count  <= (_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__valid_ff  ? (_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__count  + 1) : 2'b00);

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__count [1] & _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__count [0]) : _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__count [0]);

_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable_d1  <= _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable ;

end
end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  )

if ((!_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__sel_path  <= 1'b0;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__sel_path  <= ((_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dti_freq_ratio  == 2'b10) ? (_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable  | _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable_d1 ) : _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__enable );

end


always @( posedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__mc_clk_180  or negedge _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn  )

begin
if ((!_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__rn ))

begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__neg_data  <= 4'b0000;

end
else
begin
_dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__neg_data  <= _dti_gear_slice____PROC_GEAR_RDMASK_1_dti_gear_phy2mc_rdmask__dataout ;

end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_calvl_stb__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_calvl_stb__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_calvl_stb__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_calvl_stb__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_calvl_stb__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_calvl_stb__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_calvl_stb__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_calvl_stb__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_calvl_stb__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_calvl_stb__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_calvl_stb__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_calvl_stb__phy_data  = _dti_gear_slice__dti_gear_mc2phy_calvl_stb__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_rdlvl_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__phy_data  = _dti_gear_slice__dti_gear_mc2phy_rdlvl_load__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__phy_data  = _dti_gear_slice__dti_gear_mc2phy_wrlvl_load__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__phy_data  = _dti_gear_slice__dti_gear_mc2phy_wrlvl_stb__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wdq_load__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wdq_load__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_wdq_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_wdq_load__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_wdq_load__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_wdq_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wdq_load__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_wdq_load__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_wdq_load__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_wdq_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_wdq_load__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_wdq_load__phy_data  = _dti_gear_slice__dti_gear_mc2phy_wdq_load__data_shift [0];

always @( posedge _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_mc_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_vref_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_vref_load__temp_data  <= 0;
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_vref_load__temp_data  <= _dti_gear_slice__dti_gear_mc2phy_vref_load__mc_data ;
end
end


always @( posedge _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_phy_clock  or negedge _dti_gear_slice__dti_gear_mc2phy_vref_load__dti_sys_reset_n  )
begin
if ((~_dti_gear_slice__dti_gear_mc2phy_vref_load__dti_sys_reset_n ))
begin
_dti_gear_slice__dti_gear_mc2phy_vref_load__data_shift  <= 0;
end
else
if (_dti_gear_slice__dti_gear_mc2phy_vref_load__mc_phase_lock )
begin
case (_dti_gear_slice__dti_gear_mc2phy_vref_load__mc_phase )
2'd0: _dti_gear_slice__dti_gear_mc2phy_vref_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_vref_load__temp_data ;
default: _dti_gear_slice__dti_gear_mc2phy_vref_load__data_shift  <= {{1'b0  ,  _dti_gear_slice__dti_gear_mc2phy_vref_load__data_shift [3:1]}};
endcase
end
else
begin
_dti_gear_slice__dti_gear_mc2phy_vref_load__data_shift  <= _dti_gear_slice__dti_gear_mc2phy_vref_load__temp_data ;
end
end

assign _dti_gear_slice__dti_gear_mc2phy_vref_load__phy_data  = _dti_gear_slice__dti_gear_mc2phy_vref_load__data_shift [0];

endmodule