// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"
#include "core_v5.h"
#include "interrupt.h"
#include "atcdmac300.h"

#define LOOP_BOND 0x1
#define CACHE_LINE_SIZE 64

extern uintptr_t dmac_addr_offset;
uint8_t checking_pid = 0;
ATCDMAC300_CHANNEL_REG * local_ch_setup[8];
uint32_t test = 0, align = 1;
uint32_t ilm_exist = 0, dlm_exist = 0, slvp_exist = 0;
uint32_t ilm_size = 0, dlm_size = 0;
uintptr_t slvp_ilm;
uintptr_t slvp_dlm;

uint32_t datawidth, DW_bit, DW_byte, DW_byte_width;

typedef enum {
    CORE0,
    CORE1,
    CORE2,
    CORE3
} e_core;

typedef enum {
    ILM,
    DLM
} e_lm;

typedef enum {
    FIXED,
    INCR,
    WRAP
} e_burst;

typedef enum {
    INCR_ADDR,
    DECR_ADDR,
    FIXED_ADDR
} e_dmac_addr_ctrl;

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
                skip("'DMA Controller' should be configured to run this test.\n");         
        else
                exit(1);
}

void disable_dcache () {
	volatile long mdcm_cfg = 0, mcache_ctl = 0;

        mdcm_cfg = read_csr(NDS_MDCM_CFG);

	if (((mdcm_cfg >> 6) & 0x7) > 0) {
		mcache_ctl = read_csr(NDS_MCACHE_CTL);
		if (((mcache_ctl >> 1) & 0x1) == 1) {  
			mcache_ctl &= 0xfffffffd;
			write_csr(NDS_MCACHE_CTL, mcache_ctl);
		}
	}
}

uint32_t cvt_len2brst (uint32_t axlen) {
    uint32_t len = axlen +1;
    uint32_t brst_sz = 0;
    while ((len >> 1) > 0) {
        len = len >> 1;
        brst_sz ++;
    }
    if (brst_sz >= 0xb) exit(0x11); 

    return brst_sz;
}

int is_legal_wrap (uint32_t axsize, uint32_t axlen) {
    uint32_t rval=0;
    if (axlen==1) {
        rval = 1;
    } else if (axlen==1) {
        rval = 1;
    } else if (axlen==3) {
        rval = 1;
    } else if (axlen==7) {
        rval = 1;
    } else if (axlen==15) {
        rval = 1;
    } else {
        rval = 0;
    }
    return rval;
}

uint32_t clog2 (uint32_t num) {
    uint32_t log2 = 0;
    while (num>1) {
        log2++;
        num >>= 1;
    }
    return log2;
}

uint32_t chctrl_without_hdshake_int (uint8_t src_width, uint8_t dst_width, uint8_t src_addr_ctrl, uint8_t dst_addr_ctrl, uint32_t axlen) {
	uint32_t	rand_num, ch_ctrl, src_burst;
	uint32_t	ctrl_srcbusif, ctrl_dstbusif, ctrl_pri, ctrl_srcbrst, ctrl_srcwdth, ctrl_dstwdth, ctrl_srcmode, ctrl_dstmode, ctrl_srcaddr, ctrl_dstaddr, ctrl_srcreq, ctrl_dstreq, ctrl_intabt, ctrl_interr, ctrl_inttc, ctrl_chen;

	rand_num = rand();
			ctrl_srcbusif = (0 << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) & ATCDMAC300_CHCTRL_SRCBUSIF_MASK;
			ctrl_dstbusif = (0 << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) & ATCDMAC300_CHCTRL_DSTBUSIF_MASK;
	ctrl_pri = (1 << ATCDMAC300_CHCTRL_PRI_OFFSET) & ATCDMAC300_CHCTRL_PRI_MASK;
	ctrl_srcwdth = (src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) & ATCDMAC300_CHCTRL_SRCWDTH_MASK;
	ctrl_dstwdth = (dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) & ATCDMAC300_CHCTRL_DSTWDTH_MASK;

        src_burst = cvt_len2brst(axlen);
        if ((1 << src_width << src_burst) % (1 << dst_width)) exit(0x22);

	ctrl_srcbrst    = src_burst << ATCDMAC300_CHCTRL_SRCBRST_OFFSET;
	ctrl_srcmode = ATCDMAC300_NORMAL_MODE << ATCDMAC300_CHCTRL_SRCMODE_OFFSET;
	ctrl_dstmode = ATCDMAC300_NORMAL_MODE << ATCDMAC300_CHCTRL_DSTMODE_OFFSET;
	ctrl_srcaddr = src_addr_ctrl << ATCDMAC300_CHCTRL_SRCADDR_OFFSET;
	ctrl_dstaddr = dst_addr_ctrl << ATCDMAC300_CHCTRL_DSTADDR_OFFSET;
	ctrl_srcreq  = rand_num & ATCDMAC300_CHCTRL_SRCREQ_MASK;	
	ctrl_dstreq  = rand_num & ATCDMAC300_CHCTRL_DSTREQ_MASK;	
	ctrl_intabt  = ATCDMAC300_MASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET;
	ctrl_interr  = ATCDMAC300_MASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET;
	ctrl_inttc   = ATCDMAC300_MASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET;
	ctrl_chen    = ATCDMAC300_CH_ENABLE;
	ch_ctrl      = ctrl_srcbusif | ctrl_dstbusif | ctrl_pri | ctrl_srcbrst | ctrl_srcwdth | ctrl_dstwdth | ctrl_srcmode | ctrl_dstmode | ctrl_srcaddr | ctrl_dstaddr | ctrl_srcreq | ctrl_dstreq | ctrl_intabt | ctrl_interr | ctrl_inttc | ctrl_chen;

	return ch_ctrl;
}

void dmac_ch_setup (uint32_t axsize, uint32_t axlen, uintptr_t src_addr, uintptr_t dst_addr, uint32_t burst) {
	uint32_t	rand_num;
	uint32_t	i;
	uint32_t  total_bytes, src_trans_size, dst_trans_size, src_addr_ctrl, dst_addr_ctrl, src_width, dst_width;

	for (i = 0; i < 1; i++) {
                local_ch_setup[i]->TRANSIZE = (axlen+1);

		local_ch_setup[i]->CTRL = 0; 
		
		ATCDMAC300_SET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, SRCWDTH, axsize);
                ATCDMAC300_SET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, DSTWDTH, axsize);

		src_addr_ctrl = ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, SRCADDR);
		dst_addr_ctrl = ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, DSTADDR);
		src_width     = ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, SRCWDTH);
		dst_width     = ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, DSTWDTH);
		src_trans_size = 1 << src_width;
		dst_trans_size = 1 << dst_width;
		total_bytes = local_ch_setup[i]->TRANSIZE * src_trans_size;
                
                if (burst == INCR) {
                    src_addr_ctrl = INCR_ADDR;
                    dst_addr_ctrl = INCR_ADDR;
                } else if (burst == FIXED) {
                    src_addr_ctrl = FIXED_ADDR;
                    dst_addr_ctrl = FIXED_ADDR;
                } else {
                    src_addr_ctrl = INCR_ADDR;
                    dst_addr_ctrl = INCR_ADDR;
                }
                ATCDMAC300_SET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, SRCADDR, src_addr_ctrl);    
                ATCDMAC300_SET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, DSTADDR, dst_addr_ctrl);    
		
                local_ch_setup[i]->SRCADDRL = (uint32_t) src_addr;
		local_ch_setup[i]->SRCADDRH = (uint32_t) (((uint64_t)src_addr) >> 32);

		local_ch_setup[i]->DSTADDRL = (uint32_t) dst_addr;
		local_ch_setup[i]->DSTADDRH = (uint32_t) (((uint64_t)dst_addr) >> 32);
	}
}

void test_trans (uint32_t axsize, uint32_t axlen, uint32_t test, uint32_t lm, uint32_t burst) {
	volatile ATCDMAC300_CHANNEL_REG * ch_reg;
	uint32_t	i, exe_loop;
	uint32_t	dmac_cfg;
	uint8_t	ch_en, ch_mask, ch_valid = 0;
        uint32_t        set_wrap = 0;
        
        set_wrap = (burst==WRAP);
        DEV_SIM_CONTROL->TEMP7 = (set_wrap<<5);
        DEV_SIM_CONTROL->TEMP6 = test;
        DEV_SIM_CONTROL->TEMP4 = (1 << axsize)*(axlen + 1); 
        DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_0; 
	dmac_cfg = DEV_DMAC->CFG;

	DEV_DMAC->CTRL = 0xf;

	ch_mask = (1 << (dmac_cfg & ATCDMAC300_CFG_CHNUM_MASK)) - 1;

	__asm__ __volatile__("_init:");
        
        if (lm == ILM) {
            dmac_ch_setup(axsize, axlen, slvp_ilm, slvp_ilm + CACHE_LINE_SIZE, burst);
        } else {
            dmac_ch_setup(axsize, axlen, slvp_dlm, slvp_dlm + CACHE_LINE_SIZE, burst);
        }

	for (i = 0; i < ATCDMAC300_MAX_CH_NUM; i++) {
		ch_valid |= ((local_ch_setup[i]->TRANSIZE != 0) << i);
	}

	for (exe_loop = 0; exe_loop < LOOP_BOND; exe_loop++) {
		ch_en = 0x1 & ch_mask;
		__asm__ __volatile__("_channel_setup:");
                
                DEV_SIM_CONTROL->TEMP5 = lm;

		ch_reg = (ATCDMAC300_CHANNEL_REG *) &DEV_DMAC->CHANNEL[0];
		for (i = 0; i < 1; i++) {
			if ((ch_en >> i) & 0x1) {
				ch_reg->TRANSIZE  = local_ch_setup[i]->TRANSIZE;
				ch_reg->SRCADDRL = local_ch_setup[i]->SRCADDRL;
				ch_reg->SRCADDRH = local_ch_setup[i]->SRCADDRH;
				ch_reg->DSTADDRL = local_ch_setup[i]->DSTADDRL;
				ch_reg->DSTADDRH = local_ch_setup[i]->DSTADDRH;
				ch_reg->LLPL = 0;
				ch_reg->LLPH = 0;
				ch_reg->CTRL = chctrl_without_hdshake_int(ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, SRCWDTH), ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, DSTWDTH), ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, SRCADDR), ATCDMAC300_GET_FIELD(local_ch_setup[i]->CTRL, CHCTRL, DSTADDR), axlen);
			}
			ch_reg++;
		}

		__asm__ __volatile__("_check_complete:");
		ch_en = ch_en & ch_valid;
		wait_complete_check_status(ch_en, DEV_DMAC); 
                DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_2; 
	}
        DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_1; 
}

void test_bytes (uint32_t total_bytes , uint32_t lm, uint32_t burst) {
    uint32_t axsize = 0;
    uint32_t len = (total_bytes / (1<<axsize));
    uint32_t axlen = len - 1;
    for (int i=0; i<=DW_byte_width; i++) {
        if (burst == WRAP) {
            if (!is_legal_wrap(axsize, axlen)) {
                axsize++;
                len = (total_bytes / (1<<axsize));
                axlen = len - 1;
                if ((1 << axsize) > total_bytes) break;
                continue;
            }
        }
        test_trans(axsize++, axlen, test++, lm, burst);
        len = (total_bytes / (1<<axsize));
        axlen = len - 1;
        if ((1 << axsize) > total_bytes) break;
    }
}

void ecall_handler(SAVED_CONTEXT * context) {
        context->mepc += 4;
        context->mstatus |= MSTATUS_MPP; 
}

void enter_m_mode (void) {
        general_exc_handler_tab[TRAP_U_ECALL] = ecall_handler;
        general_exc_handler_tab[TRAP_S_ECALL] = ecall_handler;
        general_exc_handler_tab[TRAP_M_ECALL] = ecall_handler;
        
        asm volatile ("fence.i");
        asm volatile("ecall");
}

inline static void initialize (void) {
        enter_m_mode();        
        
        uint32_t micm_cfg = read_csr(NDS_MICM_CFG);
        uint32_t ilm_sz = (micm_cfg >> 15) & ((1 << 5) - 1);
        if (ilm_sz > 0) {
            unsigned long long milmb = read_csr(NDS_MILMB);
            ilm_size = (1 << (ilm_sz-1)) << 10;
            ilm_exist = ilm_size > 0;
            milmb = (milmb >> 1 )<< 1; 
            write_csr(NDS_MILMB, milmb);
            slvp_ilm = SLVPORT_BASE;
        }

        uint32_t mdcm_cfg = read_csr(NDS_MDCM_CFG);
        uint32_t dlm_sz = (mdcm_cfg >> 15) & ((1 << 5) - 1);
        if (dlm_sz > 0) {
            unsigned long long mdlmb = read_csr(NDS_MDLMB);
            dlm_size = (1 << (dlm_sz-1)) << 10;
            dlm_exist = dlm_size > 0;
           
            mdlmb = (mdlmb >> 1 )<< 1;
            write_csr(NDS_MDLMB, mdlmb);
            
            uintptr_t dlm_base = (read_csr(NDS_MDLMB) >> 10) << 10;;
            uint32_t run_id = read_csr(NDS_MHARTID);
            slvp_dlm = SLVPORT_DLM_BASE ;
        }

        slvp_exist = (read_csr(NDS_MMSC_CFG) >> 14) & 0x1;
}

int main(int argc, char** argv) {
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

	uint32_t	i;
	for (i = 0; i < ATCDMAC300_MAX_CH_NUM; i++) {
		if (!(local_ch_setup[i] = (ATCDMAC300_CHANNEL_REG *) malloc(sizeof(ATCDMAC300_CHANNEL_REG)))) exit(-1);
	}

	
	checking_pid = 1;
	if ((*(uint32_t *)DEV_DMAC & 0xffffff00) != 0x01023000)
		skip("'DMA Controller' should be configured to run this test.\n");
	
	checking_pid = 0;

        initialize();
        
        if (!ilm_exist && !dlm_exist) {
                skip("The size of either ILM or DLM should be larger than 0 KiB to run this test.\n");
        }

        if (!slvp_exist) {
                skip("'Slave Port Support' should be configured to run this test.\n");
        }

        uint32_t run_id = read_csr(NDS_MHARTID);
        if (run_id == 0) {      
            datawidth = (DEV_DMAC->CFG >> 24) & 0x3;
            DW_bit = 32 * (1 << datawidth);
            DW_byte = DW_bit/8;
            DW_byte_width = clog2(DW_byte);

            uint32_t total_bytes = 0;
            for (int i=0; i < 8; i++ ) {
                total_bytes = 1 << i;
                if (ilm_exist) {
                    test_bytes(total_bytes, ILM, INCR);
                    test_bytes(total_bytes, ILM, FIXED);
                    test_bytes(total_bytes, ILM, WRAP);
                }
                if (dlm_exist) {
                    test_bytes(total_bytes, DLM, INCR);
                    test_bytes(total_bytes, DLM, FIXED);
                    test_bytes(total_bytes, DLM, WRAP);
                }
            }
        }

        DEV_SIM_CONTROL->TEMP7 = 1;

	return 0;
}
