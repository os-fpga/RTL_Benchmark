// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include "core_v5.h"
#include "platform.h"
#include "cluster.h"

#define DC_COHSTA_CHECK_TIMEOUT 1000
int check_cluster_exist(void) {
        uint64_t mmsc_cfg = read_csr(NDS_MMSC_CFG2) >> NDS_MMSC_CFG2_OFFSET; 
        
        return  ((mmsc_cfg & MMSC_CFG_L2CMP_CFG_MASK) != 0x0);
}
    
int check_l2c_exist(void) {
        uint64_t mmsc_cfg = read_csr(NDS_MMSC_CFG2) >> NDS_MMSC_CFG2_OFFSET; 
        
        return  ((mmsc_cfg & MMSC_CFG_L2C_MASK) != 0x0);
}

int check_iocp_exist(void) {
        uint64_t mmsc_cfg = read_csr(NDS_MMSC_CFG2) >> NDS_MMSC_CFG2_OFFSET; 
        
        return  ((mmsc_cfg & MMSC_CFG_IOCP_MASK) != 0x0);
}

int get_core_pclus(void) {
        uint64_t mmsc_cfg = read_csr(NDS_MMSC_CFG2) >> NDS_MMSC_CFG2_OFFSET; 
        
        return  ((mmsc_cfg & MMSC_CFG_CORE_PCLUS_MASK) >> 16);
}

void wait_l2c_init(void) {
        volatile uint64_t l2c_ctl;
        
        do {
                l2c_ctl = DEV_L2C->CTRL;
        } while ((l2c_ctl & L2C_CTRL_INITSTATUS_MASK) != 0x0);
}
        

void enter_cache_coherent_mode(unsigned int primary_hart_id) {
        uint64_t hart_id = read_csr(NDS_MHARTID);
        volatile uint64_t l2c_ctl;

        if (check_l2c_exist()) {
                if (hart_id == primary_hart_id) {
	        	l2c_ctl = DEV_L2C->CTRL;
	        	if ((l2c_ctl & L2C_CTRL_EN_MASK) == 0x0) {
	        	        DEV_L2C->CTRL = l2c_ctl | (0x1 << L2C_CTRL_EN_OFFSET);
                        }
                }
                set_csr(NDS_MCACHE_CTL, MCACHE_CTL_DC_COHEN);
	        while((read_csr(NDS_MCACHE_CTL) & MCACHE_CTL_DC_COHSTA) == 0x0);
                set_csr(NDS_MCACHE_CTL, MCACHE_CTL_DC_EN);
        }
}
void leave_cache_coherent_mode(unsigned int primary_hart_id, unsigned int l2c_close_flag) {
        uint64_t hart_id = read_csr(NDS_MHARTID);
        volatile uint64_t l2c_ctl;

        write_csr(NDS_MCCTLCOMMAND, 0x6 );

        if (check_l2c_exist()) {
                switch(hart_id) {
                        case 1: 
                                DEV_L2C->M1_CCTL_CMD = 0b10010;
                                break;
                        case 2: 
                                DEV_L2C->M2_CCTL_CMD = 0b10010;
                                break;
                        case 3: 
                                DEV_L2C->M3_CCTL_CMD = 0b10010;
                                break;
#ifdef NDS_L2C_CCTL_MAP_V1
                        case 4: 
                                DEV_L2C->M4_CCTL_CMD = 0b10010;
                                break;
                        case 5: 
                                DEV_L2C->M5_CCTL_CMD = 0b10010;
                                break;
                        case 6: 
                                DEV_L2C->M6_CCTL_CMD = 0b10010;
                                break;
                        case 7: 
                                DEV_L2C->M7_CCTL_CMD = 0b10010;
                                break;
#endif 
                        default: 
                                DEV_L2C->M0_CCTL_CMD = 0b10010;
                                break;
                }
#ifdef NDS_L2C_CCTL_MAP_V1
                switch(hart_id) {
                        case 0: 
                                while(DEV_L2C->CCTL_ST != 0x0);
                                break;
                        case 1: 
                                while(DEV_L2C->M1_CCTL_ST != 0x0);
                                break;
                        case 2: 
                                while(DEV_L2C->M2_CCTL_ST != 0x0);
                                break;
                        case 3: 
                                while(DEV_L2C->M3_CCTL_ST != 0x0);
                                break;
                        case 4: 
                                while(DEV_L2C->M4_CCTL_ST != 0x0);
                                break;
                        case 5: 
                                while(DEV_L2C->M5_CCTL_ST != 0x0);
                                break;
                        case 6: 
                                while(DEV_L2C->M6_CCTL_ST != 0x0);
                                break;
                        case 7: 
                                while(DEV_L2C->M7_CCTL_ST != 0x0);
                                break;
                        default: 
                                skip("Number of Hart is not support\n");
                                break;
                }
#else
                while(DEV_L2C->CCTL_ST != 0x0);
#endif 

		clear_csr(NDS_MCACHE_CTL, MCACHE_CTL_DC_EN);
		clear_csr(NDS_MCACHE_CTL, MCACHE_CTL_DC_COHEN);
		while((read_csr(NDS_MCACHE_CTL) & MCACHE_CTL_DC_COHSTA)); 

                if ((hart_id == primary_hart_id) && l2c_close_flag) {
                        do {
                                l2c_ctl = DEV_L2C->CTRL;
                        } while ((l2c_ctl & L2C_CTRL_COHERENT_MODE_MASK) != 0x0);

                        l2c_ctl = DEV_L2C->CTRL;
                        if ((l2c_ctl & L2C_CTRL_EN_MASK) == 0x1) {
                                DEV_L2C->CTRL = l2c_ctl ^ (0x1 << L2C_CTRL_EN_OFFSET);
                        }
                }
        }
}
void set_core_i_reset_vector (uint32_t run_id, uint32_t RESET_VECTOR_LO, uint32_t RESET_VECTOR_HI) {
        __IO uint32_t * SMU_RST_LO_ptr = NULL;
        __IO uint32_t * SMU_RST_HI_ptr = NULL;
        switch(run_id)
        {
                case 0:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART0_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART0_RST_VEC_HI));
                break;
                case 1:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART1_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART1_RST_VEC_HI));
                break;
                case 2:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART2_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART2_RST_VEC_HI));
                break;
                case 3:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART3_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART3_RST_VEC_HI));
                break;
                case 4:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART4_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART4_RST_VEC_HI));
                break;
                case 5:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART5_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART5_RST_VEC_HI));
                break;
                case 6:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART6_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART6_RST_VEC_HI));
                break;
                case 7:
                        SMU_RST_LO_ptr = (__IO uint32_t *)(&(DEV_SMU->HART7_RST_VEC));
                        SMU_RST_HI_ptr = (__IO uint32_t *)(&(DEV_SMU->HART7_RST_VEC_HI));
                break;
                default:
                        skip("Wrong hart number");
                break;
        }
    *SMU_RST_LO_ptr = RESET_VECTOR_LO;
    *SMU_RST_HI_ptr = RESET_VECTOR_HI;
}

