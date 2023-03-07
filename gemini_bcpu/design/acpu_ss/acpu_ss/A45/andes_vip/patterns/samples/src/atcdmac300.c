// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <stdio.h>
#include <string.h>
#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"

extern uintptr_t dmac_addr_offset;

ATCDMAC300_CHANNEL_REG * ch_setup[8];

volatile uint8_t dmac_tc_flag = 0;
volatile uint8_t dmac_abt_flag = 0;
volatile uint8_t dmac_err_flag = 0;

uint32_t remap_dmac_addrl (uintptr_t addr) {
	return (uint32_t)(addr + dmac_addr_offset);
}

uint32_t remap_dmac_addrh (uintptr_t addr) {
	return (uint32_t)((uint64_t)(addr + dmac_addr_offset) >> 32);
}

uintptr_t unmap_dmac_addr (uintptr_t reg_dmac_addr) {
	return (reg_dmac_addr - dmac_addr_offset);
}

uint32_t rand_chctrl_without_hdshake_int (uint8_t src_width, uint8_t dst_width, uint8_t src_addr_ctrl, uint8_t dst_addr_ctrl) {
	uint32_t	rand_num, ch_ctrl, src_burst;
	uint32_t	ctrl_srcbusif, ctrl_dstbusif, ctrl_pri, ctrl_srcbrst, ctrl_srcwdth, ctrl_dstwdth, ctrl_srcmode, ctrl_dstmode, ctrl_srcaddr, ctrl_dstaddr, ctrl_srcreq, ctrl_dstreq, ctrl_intabt, ctrl_interr, ctrl_inttc, ctrl_chen;

	rand_num = rand();
		if (((DEV_DMAC->IDREV & 0xffffff00) == 0x01023000) && (DEV_DMAC->RESERVED0[0] == 0x080000000)) { 
			ctrl_srcbusif = 0;
			ctrl_dstbusif = 0;
		} else {
			ctrl_srcbusif = (rand_num << ATCDMAC300_CHCTRL_SRCBUSIF_OFFSET) & ATCDMAC300_CHCTRL_SRCBUSIF_MASK;
			ctrl_dstbusif = (rand_num << ATCDMAC300_CHCTRL_DSTBUSIF_OFFSET) & ATCDMAC300_CHCTRL_DSTBUSIF_MASK;
		}
	ctrl_pri = rand_num & ATCDMAC300_CHCTRL_PRI_MASK;
	ctrl_srcwdth = (src_width << ATCDMAC300_CHCTRL_SRCWDTH_OFFSET) & ATCDMAC300_CHCTRL_SRCWDTH_MASK;
	ctrl_dstwdth = (dst_width << ATCDMAC300_CHCTRL_DSTWDTH_OFFSET) & ATCDMAC300_CHCTRL_DSTWDTH_MASK;

	do {
		ctrl_srcbrst = rand() & ATCDMAC300_CHCTRL_SRCBRST_MASK;
		src_burst = ctrl_srcbrst >> ATCDMAC300_CHCTRL_SRCBRST_OFFSET;
		if (((DEV_DMAC->IDREV & 0xffffff00) == 0x01023000) && (DEV_DMAC->RESERVED0[0] == 0x80000000)) { 
			src_burst %= 8; 
		} else {
			src_burst %= 11; 
		}
	} while ((1 << src_width << src_burst) % (1 << dst_width));

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

void rand_ch_setup (void) {
	uint8_t *ch_dst_base[ATCDMAC300_MAX_CH_NUM];
	uint8_t *ch_src_base[ATCDMAC300_MAX_CH_NUM];
	uint8_t	ch_tts_ls8b;
	uint32_t	rand_num;
	uint32_t	i, j;
	uint32_t  total_bytes, src_trans_size, dst_trans_size, src_addr_ctrl, dst_addr_ctrl, src_width, dst_width;
	uint8_t dmac300_data_size;

	if (((DEV_DMAC->IDREV & 0xffffff00) == 0x01023000) && (DEV_DMAC->RESERVED0[0] == 0x080000000)) { 
		dmac300_data_size  = ATCDMAC110_DATA_SIZE; 
	} else {
		dmac300_data_size  = ATCDMAC300_DATA_SIZE; 
	}

	for (i = 0; i < ATCDMAC300_MAX_CH_NUM; i++) {
		rand_num = rand();
		if ((rand_num & ATCDMAC300_DATA_POOL_MASK64) == 0x0) {
			ch_setup[i]->TRANSIZE = 0x1; 
		} else {
			ch_setup[i]->TRANSIZE = rand_num & ATCDMAC300_DATA_POOL_MASK64;
		}

		rand_num = rand();
		ch_setup[i]->CTRL = 0; 
		ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, SRCWDTH, rand_num % (dmac300_data_size+1));
		
		ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, SRCADDR, (rand_num >> 4) % ATCDMAC300_CHCTRL_SRCADDR_OPTIONS);
		ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTADDR, (rand_num >> 8) % ATCDMAC300_CHCTRL_DSTADDR_OPTIONS);

		rand_num = rand();
		ch_tts_ls8b = (ch_setup[i]->TRANSIZE << ATCDMAC300_GET_FIELD(ch_setup[i]->CTRL, CHCTRL, SRCWDTH));
		if (TEST_FIELD(ch_tts_ls8b, 0x1) == 0x1) {		
			ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTWDTH, 0);
		}
		else if (TEST_FIELD(ch_tts_ls8b, 0x1) == 0) {	
			ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTWDTH, rand_num % 2);
		}
		else if (TEST_FIELD(ch_tts_ls8b, 0x3) == 0) {	
			ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTWDTH, rand_num % 3);
		}
		else if (TEST_FIELD(ch_tts_ls8b, 0x7) == 0 && dmac300_data_size == 3) {	
			ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTWDTH, rand_num % 4);
		}
		else if (TEST_FIELD(ch_tts_ls8b, 0xf) == 0 && dmac300_data_size == 4) {	
			ATCDMAC300_SET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTWDTH, rand_num % 5);
		}

		src_addr_ctrl = ATCDMAC300_GET_FIELD(ch_setup[i]->CTRL, CHCTRL, SRCADDR);
		dst_addr_ctrl = ATCDMAC300_GET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTADDR);
		src_width     = ATCDMAC300_GET_FIELD(ch_setup[i]->CTRL, CHCTRL, SRCWDTH);
		dst_width     = ATCDMAC300_GET_FIELD(ch_setup[i]->CTRL, CHCTRL, DSTWDTH);
		src_trans_size = 1 << src_width;
		dst_trans_size = 1 << dst_width;
		total_bytes = ch_setup[i]->TRANSIZE * src_trans_size;

		rand_num = rand();
		if (src_addr_ctrl == 0) {      
			if (!(ch_src_base[i] = (uint8_t *)malloc(total_bytes))) exit (-1);
			for (j = 0; j < total_bytes; j++) {
				*(ch_src_base[i] + j) = rand_num + j;
			}	
		}
		else if (src_addr_ctrl == 1) { 
			if (!(ch_src_base[i] = (uint8_t *)malloc(total_bytes))) exit (-1);
			for (j = 0; j < total_bytes; j++) {
				*(ch_src_base[i] + j) = rand_num + j;
			}	
			ch_src_base[i] += total_bytes - src_trans_size;
		}
		else if (src_addr_ctrl == 2) { 
			if (!(ch_src_base[i] = (uint8_t *)malloc(src_trans_size))) exit (-1);
			for (j = 0; j < src_trans_size; j++) {
				*(ch_src_base[i] + j) = rand_num + j;
			}	
		}


		if (dst_addr_ctrl == 0) {      
			if (!(ch_dst_base[i] = (uint8_t *)malloc(total_bytes))) exit (-1);
		}
		else if (dst_addr_ctrl == 1) { 
			if (!(ch_dst_base[i] = (uint8_t *)malloc(total_bytes) + total_bytes - dst_trans_size)) exit (-1);
		}
		else if (dst_addr_ctrl == 2) { 
			if (!(ch_dst_base[i] = (uint8_t *)malloc(dst_trans_size))) exit (-1);
		}

		ch_setup[i]->SRCADDRL = remap_dmac_addrl((uintptr_t)ch_src_base[i]);
		ch_setup[i]->SRCADDRH = remap_dmac_addrh((uintptr_t)ch_src_base[i]);

		ch_setup[i]->DSTADDRL = remap_dmac_addrl((uintptr_t)ch_dst_base[i]);
		ch_setup[i]->DSTADDRH = remap_dmac_addrh((uintptr_t)ch_dst_base[i]);

	}
}

int wait_complete_check_status (uint8_t ch_en, ATCDMAC300_RegDef * dev) {
	volatile uint32_t	ch_int_status;
	uint32_t	loop_cnt = 0;

	while (ch_en & dev->CHEN) {
		if (loop_cnt == ATCDMAC300_LOOP_MAX) {
			exit(101);
		}
		loop_cnt++;
	}

	if (ATCDMAC300_GET_FIELD(dev->INTSTATUS, CHSTATUS, TC) != ch_en) {
		exit(102);
	}
	dev->INTSTATUS = ch_en << ATCDMAC300_CHSTATUS_TC_OFFSET;	

	ch_int_status = dev->INTSTATUS;
	if (ch_en & (ATCDMAC300_GET_FIELD(ch_int_status, CHSTATUS, ABT) | 
		     ATCDMAC300_GET_FIELD(ch_int_status, CHSTATUS, ERR) | 
		     ATCDMAC300_GET_FIELD(ch_int_status, CHSTATUS, TC))) {
		exit(103);
	}

	return 0;
}

void insert_abort_resume_wait_complete(uint8_t ch_en, ATCDMAC300_RegDef * dev, __IO uint32_t *ch_ctrl_reg) {
	uint32_t	loop_cnt = 0;

	dev->CHABORT = ch_en;

	while (dmac_abt_flag != ch_en) {
		if (loop_cnt == ATCDMAC300_LOOP_MAX) {
			exit(125);
		}
		loop_cnt++;
	}

	if ((dev->INTSTATUS != 0) | (dev->CHEN != 0)) exit(13);

	ATCDMAC300_SET_FIELD(*ch_ctrl_reg, CHCTRL, CHEN, 1);

	loop_cnt = 0;
	while (dmac_tc_flag != ch_en) {
		if (loop_cnt == ATCDMAC300_LOOP_MAX) {
			exit(126);
		}
		loop_cnt++;
	}

	if ((dev->INTSTATUS != 0) | (dev->CHEN != 0)) exit(127);
}

void src_seq_data_calculate (uint8_t *src_last_bytes, uint8_t *src_byte_ptr, uint8_t src_width, uint8_t dst_width, uint8_t src_addr_ctrl, uint32_t data_byte_cnt) {
	uint8_t*	src_last_byte_ptr;
	uint32_t	i, j;
	uint32_t	src_trans_size = 1 << src_width;
	uint32_t	dst_trans_size = 1 << dst_width;

	switch (src_addr_ctrl) {
		case ATCDMAC300_ADDR_INC: 		
			src_last_byte_ptr = src_byte_ptr + data_byte_cnt - 1;
			for (i=dst_trans_size-1,j=0; j < dst_trans_size; i--,j++) {
				*(src_last_bytes + j) = *(src_last_byte_ptr - i);
			}
			break;
		case ATCDMAC300_ADDR_DEC:		
			src_last_byte_ptr = src_byte_ptr - data_byte_cnt + src_trans_size;
			for (j = 0; j < dst_trans_size; j++) {
				*(src_last_bytes + j) = *(src_last_byte_ptr + j);
			}
			break;
		case ATCDMAC300_ADDR_FIX:		
			src_last_byte_ptr = src_byte_ptr + src_trans_size - 1;
			for (i=dst_trans_size-1,j=0; j < dst_trans_size; i--,j++) {
				*(src_last_bytes + j) = *(src_last_byte_ptr - (i % src_trans_size));
			}
			break;
		default: 
			exit(121);
	}
}

int data_comparison (uint8_t *src_byte_ptr, uint8_t *dst_byte_ptr, uint32_t ch_transize, uint8_t src_width, uint8_t dst_width, uint8_t src_addr_ctrl, uint8_t dst_addr_ctrl) {
	uint32_t	data_byte_cnt;
	uint8_t*	src_last_bytes = malloc(sizeof(uint32_t) * 4); 
	if (!src_last_bytes) exit (-1);
	uint8_t	src_trans_size, dst_trans_size;
	uint8_t	i, j;
	uint8_t	src_trans_byte_cnt = 1;


	data_byte_cnt = ch_transize << src_width;
	src_trans_size = 1 << src_width;	
	dst_trans_size = 1 << dst_width;	

	if (data_byte_cnt == 0) return 0;

	if (dst_addr_ctrl == ATCDMAC300_ADDR_FIX) { 
		src_seq_data_calculate(src_last_bytes, src_byte_ptr, src_width, dst_width, src_addr_ctrl, data_byte_cnt);

		if (src_addr_ctrl == ATCDMAC300_ADDR_DEC) {
			for (i = 0, j = dst_trans_size - 1; i < dst_trans_size; i++, j--) {
				if (*(dst_byte_ptr + i) != *(src_last_bytes + j)) {
					exit(105);
				}
			}
		}
		else {
			for (i = 0; i < dst_trans_size; i++) {
				if (*(dst_byte_ptr + i) != *(src_last_bytes + i)) {
					exit(105);
				}
			}
		}

		return 0;
	}
	else {							
		if (src_addr_ctrl == ATCDMAC300_ADDR_DEC) {
			src_byte_ptr += (src_trans_size - 1);
		}
		if (dst_addr_ctrl == ATCDMAC300_ADDR_DEC) {
			dst_byte_ptr += (dst_trans_size - 1);
		}
		while (data_byte_cnt) {
			if (*src_byte_ptr != *dst_byte_ptr) {
				exit(0x100 + data_byte_cnt);
			}

			switch (src_addr_ctrl) {
				case ATCDMAC300_ADDR_INC:
					src_byte_ptr++;
					break;
				case ATCDMAC300_ADDR_DEC:
					src_byte_ptr--;
					break;
				default: 
					if (src_trans_byte_cnt < src_trans_size) {
						src_byte_ptr++;
						src_trans_byte_cnt++;
					}
					else if (src_trans_byte_cnt == src_trans_size) {
						src_byte_ptr -= (src_trans_size - 1);
						src_trans_byte_cnt = 1;
					}
					break;
			}

			if (dst_addr_ctrl == ATCDMAC300_ADDR_INC) {
					dst_byte_ptr++;
			}
			else {	
					dst_byte_ptr--;
			}

			data_byte_cnt--;
		}
		return 0;
	}
}

void rand_chain_without_hdshake_int (ATCDMAC300_CHAIN_REG * llp_current, ATCDMAC300_CHAIN_REG * llp_nxt, uint32_t reg_src_addrl, uint32_t reg_src_addrh, uint8_t src_width, uint8_t dst_width, uint32_t ch_transize, uint8_t src_addr_ctrl, uint8_t dst_addr_ctrl) {
	uint8_t *chain_dst_base = NULL;
	uint32_t	total_bytes, dst_trans_size;

	total_bytes = ch_transize << src_width;
	dst_trans_size = 1 << dst_width;

	if (dst_addr_ctrl == 0) {      
		if (!(chain_dst_base = (uint8_t *)malloc(total_bytes))) exit (-1);
	}
	else if (dst_addr_ctrl == 1) { 
		if (!(chain_dst_base = (uint8_t *)malloc(total_bytes) + total_bytes - dst_trans_size)) exit (-1);
	}
	else if (dst_addr_ctrl == 2) { 
		if (!(chain_dst_base = (uint8_t *)malloc(dst_trans_size))) exit (-1);
	}

	llp_current->SRCADDRL	= reg_src_addrl;
	llp_current->SRCADDRH	= reg_src_addrh;
	llp_current->DSTADDRL	= remap_dmac_addrl((uintptr_t)chain_dst_base);
	llp_current->DSTADDRH	= remap_dmac_addrh((uintptr_t)chain_dst_base);
	llp_current->CTRL	= rand_chctrl_without_hdshake_int(src_width, dst_width, src_addr_ctrl, dst_addr_ctrl);
	llp_current->TRANSIZE	= ch_transize;
	if (llp_nxt == 0) {
		llp_current->LLPL	= 0;
		llp_current->LLPH	= 0;
	}
	else {
		llp_current->LLPL	= remap_dmac_addrl((uintptr_t)llp_nxt);
		llp_current->LLPH	= remap_dmac_addrh((uintptr_t)llp_nxt);
	}
}
