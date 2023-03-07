// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>

#include "core_v5.h"
#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"

uint8_t data_size;

uint8_t checking_pid = 0;

extern int check_iocp_exist(void);
extern void enter_cache_coherent_mode(unsigned int);

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
                skip("'DMA Controller' should be configured to run this test.\n");         
        else
                exit(1);
}

void ecall_handler(SAVED_CONTEXT * context) {
	uint32_t run_id = read_csr(NDS_MHARTID);
	if(run_id > 3) {
		skip("Slave port do not integrated to the system!\n");
	}
        if (check_iocp_exist()) {
                enter_cache_coherent_mode(NDS_AE350_RUN_ID);
        }
        context->mepc += 4;
}

static void dmac_isr(uint32_t int_no)
{
	uint32_t	ch_int_status;

	(*intr_disable_ptr)(int_no);

	(*intr_clear_ptr)(int_no);

	ch_int_status = DEV_DMAC->INTSTATUS;
	dmac_tc_flag  = (ch_int_status & ATCDMAC300_CHSTATUS_TC_MASK) >> ATCDMAC300_CHSTATUS_TC_OFFSET;
	dmac_abt_flag = (ch_int_status & ATCDMAC300_CHSTATUS_ABT_MASK) >> ATCDMAC300_CHSTATUS_ABT_OFFSET;
	dmac_err_flag = (ch_int_status & ATCDMAC300_CHSTATUS_ERR_MASK) >> ATCDMAC300_CHSTATUS_ERR_OFFSET;

	DEV_DMAC->INTSTATUS = ch_int_status;

	(*intr_enable_ptr)(int_no);
}

int main (int argc, char** argv) {
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;
        general_exc_handler_tab[TRAP_U_ECALL]                       = ecall_handler;
        general_exc_handler_tab[TRAP_S_ECALL]                       = ecall_handler;
        general_exc_handler_tab[TRAP_M_ECALL]                       = ecall_handler;

        uint32_t	dmac_cfg;
	uint32_t	loop_cnt = 0;
	uint8_t	ch_num, current_ch;
	uintptr_t	ch_src_addr, ch_dst_addr;
	uint32_t	ch_transize;
	uint8_t	ch_src_width, ch_dst_width, ch_src_busif, ch_dst_busif;
	volatile ATCDMAC300_CHANNEL_REG * ch_reg;
	uint8_t	i, j;
	uint32_t	rand_num;
	uint8_t *ch_data_pool;
	uint8_t rserved_width;
	
        asm volatile("ecall");
	
	checking_pid = 1;
	if ((*(uint32_t *)DEV_DMAC & 0xffffff00) != 0x01023000)
		skip("'DMA Controller' should be configured to run this test.\n");
	
	checking_pid = 0;

	if (((DEV_DMAC->IDREV & 0xffffff00) == 0x01023000) && (DEV_DMAC->RESERVED0[0] == 0x080000000)) { 
		data_size  = ATCDMAC110_DATA_SIZE; 
	} else {
		data_size  = ATCDMAC300_DATA_SIZE; 
	}

	for (i = 0; i < ATCDMAC300_MAX_CH_NUM; i++) {
		if (!(ch_setup[i] = (ATCDMAC300_CHANNEL_REG *) malloc(sizeof(ATCDMAC300_CHANNEL_REG)))) exit(-1);
	}


	intr_handler_tab[INT_NO_DMAC] = dmac_isr;
	(*intr_enable_ptr)(INT_NO_DMAC);

	dmac_cfg = DEV_DMAC->CFG;

	DEV_DMAC->CTRL = 0xf;
	ch_num = (dmac_cfg & ATCDMAC300_CFG_CHNUM_MASK);

	__asm__ __volatile__("_init:");
	ch_transize = 0x50;

	ch_src_width = ATCDMAC300_SIZE_BYTE;
	ch_dst_width = ATCDMAC300_SIZE_BYTE;

	if (!(ch_data_pool = (uint8_t *)malloc(0x1000 + (0x200 * ATCDMAC300_MAX_CH_NUM)))) exit(-1);


	ch_src_addr  = (uintptr_t)ch_data_pool + 0x100;
	ch_dst_addr  = (uintptr_t)ch_data_pool + 0x1000;

	ch_src_busif = 0;
	ch_dst_busif = 0;

	__asm__ __volatile__("_channel_setup:");
	ch_reg = (ATCDMAC300_CHANNEL_REG *) &DEV_DMAC->CHANNEL[0];
	for (i = 0 ; i < ch_num; i++) {
		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(10);

		ch_src_addr  = (uintptr_t)ch_data_pool + 0x100 * (i + 1);
		ch_dst_addr  = (uintptr_t)ch_data_pool + 0x1000 + (i * 0x200);
		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;

		rand_num = rand();
		for (j = 0; j < (ch_reg->TRANSIZE<<ch_src_width)>>2; j++) {
			*((uint32_t*)(uintptr_t)(ch_data_pool + 0x100 * (i + 1) + (j<<2))) = rand_num + j;
		}

		ch_reg->CTRL =  (ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) | 
				(ch_src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) | 
				(ch_dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN == 0)) exit(11);

		insert_abort_resume_wait_complete(1 << i, DEV_DMAC, &ch_reg->CTRL);

		data_comparison((uint8_t *)((uintptr_t)ch_src_addr), (uint8_t *)((uintptr_t)ch_dst_addr), ch_transize, ch_src_width, ch_dst_width, 0, 0);

		ch_reg++;
	}

	__asm__ __volatile__("_align_error_setup:");
	ch_src_addr  = (uintptr_t)ch_data_pool + 0x100;
	ch_dst_addr  = (uintptr_t)ch_data_pool + 0x1000;
	ch_reg = (ATCDMAC300_CHANNEL_REG *) &DEV_DMAC->CHANNEL[0];
		ch_src_width = (uint8_t)rand() % (data_size+1);
		ch_dst_width = (uint8_t)rand() % (data_size+1);
		rserved_width = 6;
	for (i = 0 ; i < ch_num; i++) {
		current_ch = 1 << i;
		ch_reg->SRCADDRL = remap_dmac_addrl((ch_src_addr | 0x3) ^ 0x1);
		ch_reg->SRCADDRH = remap_dmac_addrh((ch_src_addr | 0x3) ^ 0x1);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->CTRL =  (ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) | 
				(ATCDMAC300_SIZE_WORD << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(ch_dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(100);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(20);

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr | 0x1);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr | 0x1);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		for (j = 1; j <= 2; j++) {
			ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
					(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
					(j << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				       	(ch_dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				       	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				       	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				       	ATCDMAC300_CH_ENABLE;

			while (dmac_err_flag != current_ch) {
				if (loop_cnt == ATCDMAC300_LOOP_MAX) {
					exit(101 + j - 1);
				}
				loop_cnt++;
			}
			dmac_err_flag = 0;

			if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(21);
		}

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		for (j = 0; j <= 1; j++) {
			ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
					(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
					(j << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				      	(ATCDMAC300_SIZE_2WORD << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				      	ATCDMAC300_CH_ENABLE;

			while (dmac_err_flag != current_ch) {
				if (loop_cnt == ATCDMAC300_LOOP_MAX) {
					exit(103 + j);
				}
				loop_cnt++;
			}
			dmac_err_flag = 0;

			if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(22);
		}

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl((ch_dst_addr | 0x3) ^ 0x1);
		ch_reg->DSTADDRH = remap_dmac_addrh((ch_dst_addr | 0x3) ^ 0x1);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ch_src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(ATCDMAC300_SIZE_WORD << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(105);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(23);

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr | 0x1);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr | 0x1);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		for (j = 1; j <= 2; j++) {
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ch_src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(j << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

			while (dmac_err_flag != current_ch) {
				if (loop_cnt == ATCDMAC300_LOOP_MAX) {
					exit(106 + j - 1);
				}
				loop_cnt++;
			}
			dmac_err_flag = 0;

			if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(24);
		}

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ATCDMAC300_SIZE_HFWORD << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
			      	(ATCDMAC300_SIZE_WORD << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
			      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
			      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
			      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
			      	ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(108);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(25);

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = 0;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ch_src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(ch_dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(109);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(26);

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize | 0x1;
		for (j = 0; j <= 1; j++) {
			ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
					(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
					(j << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				      	(ATCDMAC300_SIZE_WORD << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				      	ATCDMAC300_CH_ENABLE;

			while (dmac_err_flag != current_ch) {
				if (loop_cnt == ATCDMAC300_LOOP_MAX) {
					exit(110 + j);
				}
				loop_cnt++;
			}
			dmac_err_flag = 0;

			if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(27);
		}

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize | 0x1;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ATCDMAC300_SIZE_BYTE << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
			      	(ATCDMAC300_SIZE_HFWORD << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
			      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
			      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
			      	(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
			      	ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(112);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(28);

		ch_reg++;
	}

	__asm__ __volatile__("_reserved_value_setup:");
	ch_reg = (ATCDMAC300_CHANNEL_REG *) &DEV_DMAC->CHANNEL[0];

	for (i = 0 ; i < ch_num; i++) {
		current_ch = 1 << i;
		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(rserved_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(ch_dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(113);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(29);

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ch_src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(rserved_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(114);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(30);

		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ch_src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(ch_dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(3 << ATCDMAC300_CHCTRL_SRCADDR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(115);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(31);
	
		ch_reg->SRCADDRL = remap_dmac_addrl(ch_src_addr);
		ch_reg->SRCADDRH = remap_dmac_addrh(ch_src_addr);
		ch_reg->DSTADDRL = remap_dmac_addrl(ch_dst_addr);
		ch_reg->DSTADDRH = remap_dmac_addrh(ch_dst_addr);
		ch_reg->LLPL = 0;
		ch_reg->LLPH = 0;
		ch_reg->TRANSIZE = ch_transize;
		ch_reg->CTRL = 	(ch_src_busif << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) |
				(ch_dst_busif << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) |
				(ch_src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) |
				(ch_dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) | 
				(3 << ATCDMAC300_CHCTRL_DSTADDR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTABT_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTERR_OFFSET) |
				(ATCDMAC300_UNMASK_INT << ATCDMAC300_CHCTRL_INTTC_OFFSET) |
				ATCDMAC300_CH_ENABLE;

		while (dmac_err_flag != current_ch) {
			if (loop_cnt == ATCDMAC300_LOOP_MAX) {
				exit(116);
			}
			loop_cnt++;
		}
		dmac_err_flag = 0;

		if ((DEV_DMAC->INTSTATUS != 0) | (DEV_DMAC->CHEN != 0)) exit(32);

		ch_reg++;
	}
	

	return 0;
}
