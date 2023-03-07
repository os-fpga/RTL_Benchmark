// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>

#include "ndslib.h"
#include "interrupt.h"
#include "platform.h"

#include "spi_flash.h"

#define ERROR_BAD_CMD   0x09
#define ERROR_INTR_WAIT 0x100000
#define ERROR_INTR_ISR  0x110000

#define MAX_WAIT_CNT 500000

volatile uint32_t spi_isr_flag = 0;
volatile uint32_t spi_isr_mask = 0;

volatile uint32_t * volatile t_ptr, * volatile r_ptr;
uint32_t	* volatile t_ptr_limit;
int txf_capacity, rxf_avialable;


void spi_wait_intr(uint32_t intr_types) {
	uint32_t wait_cnt = 0;

	while ((++wait_cnt < MAX_WAIT_CNT) && ((spi_isr_flag & intr_types) == 0));

	if (wait_cnt == MAX_WAIT_CNT)
		exit(ERROR_INTR_WAIT | intr_types);

	spi_isr_flag = 0;
}

void spi_isr(uint32_t int_no) {
	(*intr_disable_ptr)(int_no);

	(*intr_clear_ptr)(int_no);


	uint32_t IntrSt = DEV_SPI->INTRST;
	int i;

	if (IntrSt & SPI_ENDINT) {
		DEV_SPI->INTRST = IntrSt;	
		spi_isr_flag = SPI_ENDINT;
	}

	if (IntrSt & SPI_TXFIFOINT) {
		for (i = 0; i < txf_capacity; i++) {
			if(t_ptr < t_ptr_limit)
				DEV_SPI->DATA = *(t_ptr++);
			else {
				DEV_SPI->INTREN = SPI_ENDINT;
				break;
			}
		}
		DEV_SPI->INTRST = SPI_TXFIFOINT;
	}

	if (IntrSt & SPI_RXFIFOINT) {
		for (i = 0; i < rxf_avialable; i++) {
			*(r_ptr++) = DEV_SPI->DATA;
		}
		DEV_SPI->INTRST = SPI_RXFIFOINT;
	}

	(*intr_enable_ptr)(int_no);
}


void spi_exe_cmd(
		uint8_t cmd,
		uint32_t addr,
		uint32_t rcnt, uint32_t *rbuf,
		uint32_t wcnt, uint32_t *wbuf) {

	int wait_cnt = 0;
	int i;
	uint32_t IntrEn;

	while (ATCSPI200_GET_FIELD(DEV_SPI->STATUS, STATUS, SPIACTIVE) && (++wait_cnt < MAX_WAIT_CNT));
	if (wait_cnt == MAX_WAIT_CNT)
		exit(0xffff);

	switch(cmd){
		case SPI_CMD_READ:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_RDonly) |
				ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, rcnt);
			break;
		case SPI_CMD_FAST_READ:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
				ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, rcnt) |
				ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0);
			break;
		case SPI_CMD_2READ:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, rcnt) |
				ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0);
			break;
		case SPI_CMD_4READ:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 2) |
				ATCSPI200_PREPARE(TRANSCTRL, TOKENEN, 1) |  
				ATCSPI200_PREPARE(TRANSCTRL, TOKENVALUE, 0) | 
				ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, rcnt) |
				ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 1);
			break;
		case SPI_CMD_RDID:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_RDonly) |
				ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, rcnt);
			break;
		case SPI_CMD_READ_ID:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_RDonly) |
				ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, rcnt);
			break;
		case SPI_CMD_WREN:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_NoneData);
			break;
		case SPI_CMD_EN4B:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_NoneData);
			break;
		case SPI_CMD_WRDI:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_NoneData);
			break;
		case SPI_CMD_SE:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_NoneData);
			break;
		case SPI_CMD_BE:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_NoneData);
			break;
		case SPI_CMD_PP:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_WRonly) |
				ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, wcnt);
			break;
		case SPI_CMD_4PP:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_WRonly) |
				ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 2) |
				ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, wcnt);
			break;
		case SPI_CMD_RDSR:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_RDonly) |
				ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, rcnt);
			break;
		case SPI_CMD_WRSR:
			DEV_SPI->TRANSCTRL =
				ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
				ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_WRonly) |
				ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, wcnt);
			break;
		default:
			exit(ERROR_BAD_CMD);
	}

	if (cmd == SPI_CMD_READ || cmd == SPI_CMD_FAST_READ || cmd == SPI_CMD_2READ ||
		cmd == SPI_CMD_4READ ||	cmd == SPI_CMD_RDID || cmd == SPI_CMD_READ_ID ||
		cmd == SPI_CMD_RDSR) {
		r_ptr = rbuf;
		IntrEn = SPI_RXFIFOINT;
	}
	if (cmd == SPI_CMD_PP || cmd == SPI_CMD_4PP || cmd == SPI_CMD_WRSR) {
		t_ptr = wbuf;
		if (ATCSPI200_TEST_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, DATAMERGE))
			t_ptr_limit = wbuf + wcnt/4 + 1;
		else
			t_ptr_limit = wbuf + wcnt + 1;
		IntrEn |= SPI_TXFIFOINT;
	}
	DEV_SPI->INTREN = IntrEn | SPI_ENDINT;

	if (ATCSPI200_TEST_BIT(TRANSFMT, LSB, DEV_SPI->TRANSFMT)) {
		DEV_SPI->ADDR = BIT_REVERT24(addr);
		DEV_SPI->CMD = BIT_REVERT8(cmd);
	}
	else {
		DEV_SPI->ADDR = addr;	
		DEV_SPI->CMD = cmd;	
	}

	while (ATCSPI200_GET_FIELD(DEV_SPI->STATUS, STATUS, SPIACTIVE));
	spi_wait_intr(SPI_ENDINT);
	DEV_SPI->INTREN = 0;

	for (i = (ATCSPI200_GET_FIELD(DEV_SPI->STATUS, STATUS, RXNUM_LOWER) | (ATCSPI200_GET_FIELD(DEV_SPI->STATUS, STATUS, RXNUM_UPPER) << 6)); i > 0; i--)
		*(r_ptr++) = DEV_SPI->DATA;

}


void flash_write_enable() {
	spi_exe_cmd(SPI_CMD_WREN, 0, 0, 0, 0, 0);
}

void flash_4b_enable(uint32_t use_cmd) {
	if (use_cmd) {
		spi_exe_cmd(SPI_CMD_EN4B, 0, 0, 0, 0, 0);
	}
	else {
		uint32_t lsb_first = ATCSPI200_TEST_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, LSB);
		uint32_t buf;

		flash_write_enable();
		spi_exe_cmd(SPI_CMD_RDSR, 0, 1, &buf, 0, 0);
		buf |= (lsb_first ? BIT_REVERT8(FLASH_CONFIG_4BYTE_MASK) : FLASH_CONFIG_4BYTE_MASK) << 8;
		spi_exe_cmd(SPI_CMD_WRSR, 0, 0, 0, 1, &buf);
	}
}

void flash_check_wip() {
	uint32_t buf;
	do {
		spi_exe_cmd(SPI_CMD_RDSR, 0, 0, &buf, 0, 0);
	}while (buf & FLASH_STATUS_WIP_MASK);
}

void flash_chip_erase() {
	flash_write_enable();

	spi_exe_cmd(SPI_CMD_CE, 0, 0, 0, 0, 0);

	flash_check_wip();
}

void flash_sector_erase(uint32_t addr) {
	flash_write_enable();

	spi_exe_cmd(SPI_CMD_SE, addr, 0, 0, 0, 0);

	flash_check_wip();
}

void flash_block_erase(uint32_t addr) {
	flash_write_enable();

	spi_exe_cmd(SPI_CMD_BE, addr, 0, 0, 0, 0);

	flash_check_wip();
}

void spi_install_isr() {
	int i;
	int TXFIFOSIZE;


	(*intr_setup_ptr)(INT_NO_SPI, spi_isr);
	(*intr_enable_ptr)(INT_NO_SPI);

	DEV_SPI->INTREN = 0;

	for (i = ATCSPI200_GET_FIELD(DEV_SPI->CONFIG, CONFIG, TXFIFOSIZE), TXFIFOSIZE = 2; i > 0; i--)
		TXFIFOSIZE *= 2;

	txf_capacity = TXFIFOSIZE - ATCSPI200_GET_FIELD(DEV_SPI->CTRL, CTRL, TXTHRES);
	rxf_avialable = ATCSPI200_GET_FIELD(DEV_SPI->CTRL, CTRL, RXTHRES);
}
