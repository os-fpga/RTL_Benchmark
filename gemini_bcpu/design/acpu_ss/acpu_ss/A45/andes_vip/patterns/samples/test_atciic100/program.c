// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"

#define DEVICE_ADDR_7bit    0X50
#define READ_DEVICE			I2C_CMD(DEVICE_ADDR_7bit, I2C_RD)
#define WRITE_DEVICE		I2C_CMD(DEVICE_ADDR_7bit, I2C_WR)
#define DEVICE_ADDR_10bit	0x1a7

#define I2C_PAGE_SIZE   0x4
#define I2C_Test1_CNT   0x1
#define I2C_Test2_CNT   0x1
#define I2C_Test3_CNT   0x1

#define MAX_WAIT_CNT	300000

volatile uint32_t i2c_isr_flag = 0;
uint32_t i2c_rdwt = 1;
uint32_t i2c_pagesize = 0;
uint32_t int_cnt = 0;
uint8_t *i2c_databuf;
uint8_t  checking_pid = 0;


void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'I2C Controller' should be configured to run this test.\n");         
        else
                exit(1);
}


void i2c_isr(uint32_t int_no)
{
    	uint32_t int_status = 0;

	(*intr_disable_ptr)(int_no);

	(*intr_clear_ptr)(int_no);

	int_status = DEV_IIC->STATUS;

	DEV_IIC->STATUS = int_status;

	if (i2c_rdwt) { 

		while (!ATCIIC100_TEST_FIELD(DEV_IIC->STATUS, IBST, INTEMPTY) && (int_cnt < i2c_pagesize)) {
			i2c_databuf[int_cnt] = DEV_IIC->DATA;
			int_cnt++;
		}
	}
	else { 

		while (!ATCIIC100_TEST_FIELD(DEV_IIC->STATUS, IBST, INTFULL) && (int_cnt < i2c_pagesize)) {
			DEV_IIC->DATA = i2c_databuf[int_cnt];
			int_cnt++;
		}

		if (int_cnt >= i2c_pagesize)
			ATCIIC100_SET_FIELD(DEV_IIC->INTEN, INTEN, INTENEMPTY, 0);
	}

	if (i2c_isr_flag == 1) {
		exit(0x82);
	}

	i2c_isr_flag |= ATCIIC100_TEST_FIELD(int_status, IBST, INTCMPL);

	(*intr_enable_ptr)(INT_NO_I2C);

	return;

}


void i2c_wait_int()
{
	uint32_t wait_cnt = 0;

	while ((i2c_isr_flag == 0) && (wait_cnt <= MAX_WAIT_CNT)) {
		wait_cnt++;
	}

	if (i2c_isr_flag == 0) {
		exit(0x99);
	}

	i2c_isr_flag = 0;
}


void i2c_read(uint8_t *rdata, uint16_t raddr, uint32_t nbytes)
{
	int_cnt = 0;

	DEV_IIC->CMD = ATCIIC100_FIFO_CLR;

	DEV_IIC->CTRL =
		ATCIIC100_PREPARE(CTL, PHASE_S, 1)		|
		ATCIIC100_PREPARE(CTL, PHASE_ADDR, 1)	|
		ATCIIC100_PREPARE(CTL, PHASE_DATA, 1)	|
		ATCIIC100_PREPARE(CTL, RDWT, I2C_WR)	|
		ATCIIC100_PREPARE(CTL, DATACNT, 2);

	DEV_IIC->INTEN = ATCIIC100_PREPARE(INTEN, INTENCMPL, 1);

	DEV_IIC->DATA = raddr >> 8;
	DEV_IIC->DATA = raddr;

	DEV_IIC->CMD = ATCIIC100_TRANS;

	i2c_wait_int();

	if (!ATCIIC100_TEST_FIELD(DEV_IIC->STATUS, IBST, ACK))
		exit(0x01);



	i2c_databuf = rdata;
	i2c_rdwt = I2C_RD;
	int_cnt = 0;
	i2c_pagesize = nbytes;

	DEV_IIC->CMD = ATCIIC100_FIFO_CLR;

	DEV_IIC->CTRL =
		ATCIIC100_PREPARE(CTL, PHASE_S, 1)		|
		ATCIIC100_PREPARE(CTL, PHASE_ADDR, 1)	|
		ATCIIC100_PREPARE(CTL, PHASE_DATA, 1)	|
		ATCIIC100_PREPARE(CTL, PHASE_P, 1)		|
		ATCIIC100_PREPARE(CTL, RDWT, I2C_RD)	|
		ATCIIC100_PREPARE(CTL, DATACNT, nbytes);

	DEV_IIC->INTEN =
		ATCIIC100_PREPARE(INTEN, INTENCMPL, 1)|
		ATCIIC100_PREPARE(INTEN, INTENFULL, 1);

	DEV_IIC->CMD = ATCIIC100_TRANS;

	i2c_wait_int();


	return;
}


void i2c_write(uint8_t *wdata, uint16_t waddr, uint32_t nbytes)
{

	i2c_databuf = wdata;
	i2c_rdwt = I2C_WR;
	int_cnt = 0;
	i2c_pagesize = nbytes;

	DEV_IIC->CMD = ATCIIC100_FIFO_CLR;


	DEV_IIC->CTRL =
		ATCIIC100_PREPARE(CTL, PHASE_S, 1)		|
		ATCIIC100_PREPARE(CTL, PHASE_ADDR, 1)	|
		ATCIIC100_PREPARE(CTL, PHASE_DATA, 1)	|
		ATCIIC100_PREPARE(CTL, PHASE_P, 1)		|
		ATCIIC100_PREPARE(CTL, RDWT, I2C_WR)	|
		ATCIIC100_PREPARE(CTL, DATACNT, nbytes+2);

	DEV_IIC->DATA = waddr >> 8;
	DEV_IIC->DATA = waddr;

	DEV_IIC->INTEN =
		ATCIIC100_PREPARE(INTEN, INTENCMPL, 1)	|
		ATCIIC100_PREPARE(INTEN, INTENEMPTY, 1);

	DEV_IIC->CMD = ATCIIC100_TRANS;

	i2c_wait_int();

	if (!ATCIIC100_TEST_FIELD(DEV_IIC->STATUS, IBST, ACK))
		exit(0x01);


	return;
}

int main(int argc, char* argv[])
{
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

	uint32_t i, j;
	uint8_t i2c_wbuf[256], i2c_rbuf[256];
	uint32_t tmpsize = 0;
	uint16_t addr;
	uint32_t tpm_rand = 0, tpm_config = 0;
        uint32_t mask;

        checking_pid = 1;
        mask = ATCIIC100_IDREV_ID_MASK;
        if ((DEV_IIC->IDREV & mask) != (ATCIIC100_IDREV_DEFAULT & mask))
	        skip("'I2C Controller' should be configured to run this test.\n");         

        checking_pid = 0;
	DEV_IIC->CMD = ATCIIC100_IIC_RST;
	i2c_isr_flag = 0;

	(*intr_setup_ptr)(INT_NO_I2C, i2c_isr);
	(*intr_enable_ptr)(INT_NO_I2C);

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_14;

	tpm_rand = rand();
	if (tpm_rand & 0x1) {
		tpm_config = 0;
	} else if ((tpm_rand>>1) & 0x1) {
		tpm_config = 1;
	} else {
		tpm_config = 2;
	}
		
	DEV_IIC->TPM = ATCIIC100_PREPARE(TPM, TPM, tpm_config);


	DEV_IIC->SETUP =
		ATCIIC100_PREPARE(SETUP, TSP, 4)		|
		ATCIIC100_PREPARE(SETUP, THDDAT, 0)		|
		ATCIIC100_PREPARE(SETUP, TSCLRATIO, 1)	|
		ATCIIC100_PREPARE(SETUP, TSCLHI, 30)	|
		ATCIIC100_PREPARE(SETUP, DMAEN, 0)		|
		ATCIIC100_PREPARE(SETUP, MASTER, 1)		|
		ATCIIC100_PREPARE(SETUP, ADDRESSING, 0)	|
		ATCIIC100_PREPARE(SETUP, IICEN, 1);

	DEV_IIC->ADDR = DEVICE_ADDR_7bit;


	__asm__ __volatile__ ("test1:\n");

	for (i = 0; i < I2C_Test2_CNT; i++) {

		tmpsize = 100;
		addr = i & 0xffff;

		for (j = 0; j < tmpsize; j++) {
			i2c_wbuf[j] = rand() & 0xff;
		}

		i2c_write(i2c_wbuf, addr, tmpsize);
		DEV_IIC->CMD = ATCIIC100_IIC_RST;
		if (DEV_IIC->STATUS & (ATCIIC100_IBST_ACK_MASK | ATCIIC100_IBST_GENCALL_MASK))
			exit(0x100);
		i2c_read(i2c_rbuf, addr, tmpsize);

		for (j = 0; j < tmpsize; j++) {
			if (i2c_wbuf[j] != i2c_rbuf[j]) {
				exit(0x11 + j);
			}
		}
	}


	DEV_IIC->ADDR = DEVICE_ADDR_10bit;

	DEV_IIC->SETUP =
		ATCIIC100_PREPARE(SETUP, TSP, 4)		|
		ATCIIC100_PREPARE(SETUP, THDDAT, 9)		|
		ATCIIC100_PREPARE(SETUP, TSCLRATIO, 1)	|
		ATCIIC100_PREPARE(SETUP, TSCLHI, 30)	|
		ATCIIC100_PREPARE(SETUP, DMAEN, 0)		|
		ATCIIC100_PREPARE(SETUP, MASTER, 1)		|
		ATCIIC100_PREPARE(SETUP, ADDRESSING, 1)	|
		ATCIIC100_PREPARE(SETUP, IICEN, 1);

	__asm__ __volatile__ ("test2:\n");

	for (i = 0; i < I2C_Test2_CNT; i++) {

		tmpsize = 100;
		addr = i & 0xffff;

		for (j = 0; j < tmpsize; j++) {
			i2c_wbuf[j] = rand() & 0xff;
		}

		i2c_write(i2c_wbuf, addr, tmpsize);
		i2c_read(i2c_rbuf, addr, tmpsize);

		for (j = 0; j < tmpsize; j++) {
			if (i2c_wbuf[j] != i2c_rbuf[j]) {
				exit(0x01);
			}
		}
	}

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_EVENT_15;

	return 0;

}
