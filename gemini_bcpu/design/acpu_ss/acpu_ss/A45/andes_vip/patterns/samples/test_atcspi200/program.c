// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>

#include "ndslib.h"
#include "core_v5.h"
#include "rand.h"

#include "platform.h"
#include "spi_flash.h"
#include "interrupt.h"

#define TEST_WORDS_MAX (128U)
#define TEST_BYTES_MAX (TEST_WORDS_MAX * 4)

#define ATCSPI200_WRITE_LIMIT 512

#define ERROR_DEVICE_ID			0x01

static uint32_t   data[TEST_WORDS_MAX];
static uint32_t result[TEST_WORDS_MAX];

static uint32_t dual_support, quad_support, quad_write_support;
uint8_t         checking_pid = 0;

#define MAX_WAIT_CNT 300000

#define POLLING_SPIACTIVE() do{\
	int wait_cnt=0;\
	while((wait_cnt++<MAX_WAIT_CNT) && ATCSPI200_TEST_FIELD(((ATCSPI200_RegDef *)DEV_SPI)->STATUS, STATUS, SPIACTIVE));}while(0)

#define POLLING_RXEMPTY() do{\
	int wait_cnt=0;\
	while((wait_cnt++<MAX_WAIT_CNT) && ATCSPI200_TEST_FIELD(((ATCSPI200_RegDef *)DEV_SPI)->STATUS, STATUS, RXEMPTY));}while(0)

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'SPI1 controller' should be configured to run this test.\n");         
        else
                exit(1);
}

void ecall_handler(SAVED_CONTEXT * context) {
	context->mepc = read_csr(NDS_MEPC) + 4;
	write_csr(NDS_MMISC_CTL, read_csr(NDS_MMISC_CTL) & (~(0x1<<3)));
}


void prepare_data()
{
	uint32_t rand_incr;
	int i;

	for (i = 1, data[0] = rand(), rand_incr = rand(); i < TEST_WORDS_MAX; i++)
		data[i] = data[i-1] + rand_incr;
}

void clean_result(uint32_t *result)
{
	int i;

	for (i = 0; i < TEST_WORDS_MAX; i++)
		result[i] = 0;
}


int check_result(uint32_t *data, uint32_t *result, uint32_t test_bytes)
{
	int i;

	for (i = 0; i < test_bytes; i++) {
		if (((uint8_t *)data)[i] != ((uint8_t *)result)[i]) {
			return 1;
		}
	}

	return 0;
}


void reg_access_rw() {
	uint32_t wrt_base;
	uint32_t device_id;
	uint32_t wr_cnt, rd_cnt;

	wrt_base = rand() & (DEVICE_SIZE - 1)  & ~(DEVICE_PAGE_SIZE - 1);


	__asm__ __volatile__ ("test1:");
	spi_exe_cmd(SPI_CMD_RDID, 0, 2, result, 0, 0);

	device_id = ATCSPI200_TEST_BIT(TRANSFMT, LSB, DEV_SPI->TRANSFMT)? BIT_REVERT_BY_BYTE(DEVICE_ID): DEVICE_ID;

	if (check_result(&device_id, result, 3))
		exit(ERROR_DEVICE_ID);

	__asm__ __volatile__ ("test2:");

	flash_write_enable(); 
	wr_cnt = TEST_WORDS_MAX * 2;
	spi_exe_cmd(SPI_CMD_PP, wrt_base, 0, 0, wr_cnt - 1, data);


	flash_write_enable(); 
	spi_exe_cmd(quad_write_support ? SPI_CMD_4PP : SPI_CMD_PP,
			wrt_base + wr_cnt, 0, 0, wr_cnt - 1, data + wr_cnt/4);

	flash_check_wip();

	__asm__ __volatile__ ("test3:");
	rd_cnt = (rand() & (TEST_WORDS_MAX * 4 - 1)) + 1;

	spi_exe_cmd(SPI_CMD_READ, wrt_base, rd_cnt - 1, result, 0, 0);
	if (check_result(data, result, rd_cnt))
		exit(SPI_CMD_READ);

	__asm__ __volatile__ ("test4:");
	spi_exe_cmd(SPI_CMD_FAST_READ, wrt_base, rd_cnt - 1, result, 0, 0);
	if (check_result(data, result, rd_cnt))
		exit(SPI_CMD_FAST_READ);

	if (dual_support) {
		__asm__ __volatile__ ("test5:");
		spi_exe_cmd(SPI_CMD_2READ, wrt_base, rd_cnt - 1, result, 0, 0);
		if (check_result(data, result, rd_cnt))
			exit(SPI_CMD_2READ);
	}

	if (quad_support) {
		__asm__ __volatile__ ("test6:");
		spi_exe_cmd(SPI_CMD_4READ, wrt_base, rd_cnt - 1, result, 0, 0);
		if (check_result(data, result, rd_cnt))
			exit(SPI_CMD_4READ);
	}

}


void reg_random_access()
{
	uint32_t rd_addr, wrt_base;
	int i;
	uint32_t LSB;
	uint32_t tmp;
	uint32_t wr_cnt, rd_cnt;

	wrt_base = rand() & (DEVICE_SIZE - 1) & ~(DEVICE_PAGE_SIZE -1);
	LSB = ATCSPI200_TEST_BIT(TRANSFMT, LSB, DEV_SPI->TRANSFMT);

	if (quad_support) {
		flash_write_enable();
		tmp = LSB?BIT_REVERT8(FLASH_STATUS_QE_MASK):FLASH_STATUS_QE_MASK;
		spi_exe_cmd(SPI_CMD_WRSR, 0, 0, 0, 0, &tmp);
	}

	flash_block_erase(wrt_base);

	flash_write_enable(); 
	wr_cnt = TEST_WORDS_MAX * 2;
	spi_exe_cmd(SPI_CMD_PP, wrt_base, 0, 0, wr_cnt - 1, data);


	flash_write_enable(); 
	spi_exe_cmd(quad_write_support ? SPI_CMD_4PP : SPI_CMD_PP,
			wrt_base + wr_cnt, 0, 0, wr_cnt - 1, data + wr_cnt/4);


	for (i = 0; i < 16; i++){
		rd_addr = rand() & (TEST_BYTES_MAX - 1) & ~0x3;	

		DEV_SPI->ADDR = LSB?BIT_REVERT24(rd_addr + wrt_base):(rd_addr + wrt_base);
	if (quad_support) {
		DEV_SPI->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, (i == 0)) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 2) |
			ATCSPI200_PREPARE(TRANSCTRL, TOKENEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TOKENVALUE, i != 15) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 1);
		DEV_SPI->CMD = LSB?BIT_REVERT8(SPI_CMD_4READ):SPI_CMD_4READ;
	}
	else if (dual_support) {
		DEV_SPI->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0);
		DEV_SPI->CMD = LSB?BIT_REVERT8(SPI_CMD_2READ):SPI_CMD_2READ;
	}
	else {
		DEV_SPI->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 0) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0);
		DEV_SPI->CMD = LSB?BIT_REVERT8(SPI_CMD_FAST_READ):SPI_CMD_FAST_READ;
	}

		POLLING_RXEMPTY();

		if (DEV_SPI->DATA != data[rd_addr>>2])
			exit(0xffff);
	}

}

int no_cmd_addr_data_test()
{

	int cnt = 0;

	DEV_SPI->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_NoneData);
	DEV_SPI->CMD = 0x01;	

	while((cnt++ < MAX_WAIT_CNT) && ATCSPI200_TEST_FIELD(DEV_SPI->STATUS, STATUS, SPIACTIVE));

	if (cnt >= MAX_WAIT_CNT)
		exit(0x100);

	return 0;
}


void special_ifset() {
	uint32_t wrt_addr;
	int i;

	wrt_addr = rand() & (DEVICE_SIZE -1) & ~0xff;

	flash_block_erase(wrt_addr);

	flash_write_enable();
	POLLING_SPIACTIVE();
	ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, ADDRLEN, 1);
	DEV_SPI->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN,  1) |
		ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_WRonly) |
		ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, 4);
	DEV_SPI->ADDR = wrt_addr >> 8;
	DEV_SPI->DATA = data[0] << 8 | (wrt_addr  & 0xff);
	DEV_SPI->DATA = data[0] >> 24;
	DEV_SPI->CMD = SPI_CMD_PP;

	flash_write_enable();
	POLLING_SPIACTIVE();
	ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, ADDRLEN, 0);
	DEV_SPI->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN,  1) |
		ATCSPI200_PREPARE(TRANSCTRL, ADDREN,  1) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_WRonly) |
		ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, 5);
	DEV_SPI->ADDR = (wrt_addr + 4) >> 16;
	DEV_SPI->DATA = data[1] << 16 |
		((wrt_addr + 4) & 0xff) << 8 | ((wrt_addr + 4) & 0xff00) >> 8;
	DEV_SPI->DATA = data[1] >> 16;
	DEV_SPI->CMD = SPI_CMD_PP;

	POLLING_SPIACTIVE();
	ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, ADDRLEN, 2);
	spi_exe_cmd(SPI_CMD_READ, wrt_addr, 7, result, 0, 0);
	if (result[0] != data[0])
		exit(0x2001);
	if (result[1] != data[1])
		exit(0x2002);

	ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, DATALEN, 15);

	POLLING_SPIACTIVE();
	DEV_SPI->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN,  1) |
		ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_RDonly) |
		ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3);
	DEV_SPI->ADDR = wrt_addr;
	DEV_SPI->CMD = SPI_CMD_READ;
	for (i = 0; i < 4; i++) {
		POLLING_RXEMPTY();
		result[i] = DEV_SPI->DATA;
		if (i % 2 == 0) {
			if (result[i] != (((data[i/2] << 8) & 0xff00) | ((data[i/2] >> 8) & 0xff)))
				exit(0x2003);
		}
		else {
			if (result[i] != (((data[i/2] >> 8) & 0xff00) | ((data[i/2] >> 24)& 0xff)))
				exit(0x2004);
		}
	}

	if (dual_support) {
		ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, ADDRLEN, 1);
		POLLING_SPIACTIVE();
		DEV_SPI->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN,  1) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_WR_RD) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3) |
			ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, 0);
		DEV_SPI->ADDR = wrt_addr >> 8;
		DEV_SPI->DATA = wrt_addr << 8;
		DEV_SPI->CMD = SPI_CMD_2READ;
		for (i = 0; i < 4; i++) {
			POLLING_RXEMPTY();
			result[i] = DEV_SPI->DATA;
			if (i % 2 == 0) {
				if (result[i] != (((data[i/2] << 8) & 0xff00) | ((data[i/2] >> 8) & 0xff)))
					exit(0x2005);
			}
			else {
				if (result[i] != (((data[i/2] >> 8) & 0xff00) | ((data[i/2] >> 24)& 0xff)))
					exit(0x2006);
			}
		}
	}

	if (quad_support) {
		POLLING_SPIACTIVE();
		ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, ADDRLEN, 2);
		DEV_SPI->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN,  1) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TOKENEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 2) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0);
		DEV_SPI->ADDR = wrt_addr;
		DEV_SPI->CMD = SPI_CMD_4READ;
		for (i = 0; i < 4; i++) {
			POLLING_RXEMPTY();
			result[i] = DEV_SPI->DATA;
			if (i % 2 == 0) {
				if (result[i] != (((data[i/2] << 8) & 0xff00) | ((data[i/2] >> 8) & 0xff)))
					exit(0x2005);
			}
			else {
				if (result[i] != (((data[i/2] >> 8) & 0xff00) | ((data[i/2] >> 24)& 0xff)))
					exit(0x2006);
			}
		}
	}
	ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, DATALEN, 7);
	ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, ADDRLEN, 2);
}

int main(int argc, char *argv[])
{
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;
	
	general_exc_handler_tab[TRAP_U_ECALL] = ecall_handler;
	general_exc_handler_tab[TRAP_S_ECALL] = ecall_handler;
	general_exc_handler_tab[TRAP_M_ECALL] = ecall_handler;
	asm volatile("ecall");

	uint32_t rand_set;
	uint32_t HWCfg;
        uint32_t mask;

        checking_pid = 1;
        mask = ATCSPI200_IDREV_ID_MASK;
        if ((DEV_SPI->IDREV & mask) != (ATCSPI200_IDREV_DEFAULT & mask))
	        skip("'SPI1 controller' should be configured to run this test.\n");         

        checking_pid = 0;
	HWCfg = DEV_SPI->CONFIG;
#ifdef DEVICE_SUPPORT_QUAD_WRITE
	quad_write_support = HWCfg & ATCSPI200_CONFIG_QUADSPI_MASK;
#else
	quad_write_support = 0;
#endif
#ifdef DEVICE_SUPPORT_QUAD
	quad_support = HWCfg & ATCSPI200_CONFIG_QUADSPI_MASK;
#else
	quad_support = 0;
#endif
#ifdef DEVICE_SUPPORT_DUAL
	dual_support = HWCfg & ATCSPI200_CONFIG_DUALSPI_MASK;
#else
	dual_support = 0;
#endif


	rand_set = rand();

	DEV_SPI->TRANSFMT =
		ATCSPI200_PREPARE(TRANSFMT, ADDRLEN,	2) |
		ATCSPI200_PREPARE(TRANSFMT, DATALEN,	7) |
		ATCSPI200_PREPARE(TRANSFMT, DATAMERGE,	1) |
		ATCSPI200_PREPARE(TRANSFMT, MOSIBIDIR,	0) |
		ATCSPI200_PREPARE(TRANSFMT, LSB,	rand_set >> 1) |
		ATCSPI200_PREPARE(TRANSFMT, SLVMODE,	0) |
		ATCSPI200_PREPARE(TRANSFMT, CPOL,	rand_set) |
		ATCSPI200_PREPARE(TRANSFMT, CPHA,	rand_set);

	DEV_SPI->CTRL =
		ATCSPI200_PREPARE(CTRL, TXTHRES, 2) |
		ATCSPI200_PREPARE(CTRL, RXTHRES, 2);

	rand_set = rand();
	DEV_SPI->TIMING =
		ATCSPI200_PREPARE(TIMING, CS2SCLK, rand_set) |
		ATCSPI200_PREPARE(TIMING, CSHT, rand_set >> 8) |
#ifdef NDS_FPGA
		ATCSPI200_PREPARE(TIMING, SCLK_DIV, ((rand_set >> 16) & 0xf));
#else
		ATCSPI200_PREPARE(TIMING, SCLK_DIV, ((rand_set >> 16) & 0xf) - 1);
#endif

	prepare_data();
	spi_install_isr();

	if (quad_support) {
		flash_write_enable();
		uint32_t tmp =ATCSPI200_TEST_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, LSB)?0x02:0x40;
		spi_exe_cmd(SPI_CMD_WRSR, 0, 0, 0, 0, &tmp);
	}

	reg_access_rw();

#ifdef DEVICE_SUPPORT_SPECIAL_TOKEN
	reg_random_access();
#endif

	no_cmd_addr_data_test();

	ATCSPI200_SET_FIELD(DEV_SPI->TRANSFMT, TRANSFMT, LSB, 0);

	special_ifset();

	return 0;
}
