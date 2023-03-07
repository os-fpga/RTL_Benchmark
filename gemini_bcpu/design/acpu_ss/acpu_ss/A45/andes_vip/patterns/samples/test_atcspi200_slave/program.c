// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>

#include "ndslib.h"
#include "rand.h"
#include "interrupt.h"

#include "platform.h"

#ifndef DEV_SPI_MASTER
	int main(int argc, char **argv) {
		return 0;
	}
#else

#define MAX_WAIT_CNT	500000
#define TEST_WORDS_MAX	128

#define POLLING_MASTER_BSY() do{\
	int wait_cnt=0;\
	while((++wait_cnt < MAX_WAIT_CNT) && ATCSPI200_TEST_FIELD(((ATCSPI200_RegDef *)DEV_SPI_MASTER)->STATUS, STATUS, SPIACTIVE));\
	if(wait_cnt == MAX_WAIT_CNT) exit(0x9998);}while(0)

#define POLLING_SLAVE_READY() do{\
	int wait_cnt=0;\
	while((++wait_cnt < MAX_WAIT_CNT) && ATCSPI200_TEST_FIELD(((ATCSPI200_RegDef *)DEV_SPI_SLAVE)->SLVST, SLVST, READY));\
	if(wait_cnt == MAX_WAIT_CNT) exit(0x9997);}while(0)

#define CAL_FIFO_SIZE(r, p) do{int i; for(i=0, r=2; i<p; i++) r *= 2;}while(0)


static volatile uint32_t spis_isr_flag = 0;	
static volatile uint32_t spis_st_check = 0;	

static uint32_t data[TEST_WORDS_MAX];
static int m_rxf_size, m_txf_size;	
static int s_rxf_size, s_txf_size;	
static int spi_support_quad, spi_support_dual;
static int s_SLAVE_SP;
static volatile uint32_t m_r_buf[TEST_WORDS_MAX], s_r_buf[TEST_WORDS_MAX];
static volatile uint32_t * volatile m_r_ptr, * volatile m_t_ptr;
static volatile uint32_t * volatile s_r_ptr, * volatile s_t_ptr;
static volatile uint32_t * volatile m_t_ptr_limit, * volatile s_t_ptr_limit;
static int s_rxf_avl, s_txf_cap, m_rxf_avl, m_txf_cap;
uint8_t    checking_pid = 0;

void bus_error_handler(SAVED_CONTEXT * content) {
        if (checking_pid)
	        skip("'SPI1/SPI2 controller' should be configured to run this test.\n");         
        else
                exit(1);
}

void get_hw_config()
{
	uint32_t m_HWCfg, s_HWCfg;

	m_HWCfg = DEV_SPI_MASTER->CONFIG;
	s_HWCfg = DEV_SPI_SLAVE->CONFIG;

	CAL_FIFO_SIZE(m_txf_size, ATCSPI200_GET_FIELD(m_HWCfg, CONFIG, TXFIFOSIZE));
	CAL_FIFO_SIZE(m_rxf_size, ATCSPI200_GET_FIELD(m_HWCfg, CONFIG, RXFIFOSIZE));

	CAL_FIFO_SIZE(s_txf_size, ATCSPI200_GET_FIELD(s_HWCfg, CONFIG, TXFIFOSIZE));
	CAL_FIFO_SIZE(s_rxf_size, ATCSPI200_GET_FIELD(s_HWCfg, CONFIG, RXFIFOSIZE));

	spi_support_dual = ATCSPI200_GET_FIELD(m_HWCfg & s_HWCfg, CONFIG, DUALSPI);
	spi_support_quad = ATCSPI200_GET_FIELD(m_HWCfg & s_HWCfg, CONFIG, QUADSPI);

	s_SLAVE_SP = ATCSPI200_GET_FIELD(s_HWCfg, CONFIG, SLAVE);
}

void spim_isr(uint32_t int_no)
{
	uint32_t IntrSt;
	int i;

	(*intr_disable_ptr)(int_no);

	(*intr_clear_ptr)(int_no);

	IntrSt = DEV_SPI_MASTER->INTRST;

	if (IntrSt & SPI_TXFIFOINT) {
		for (i = 0; i < m_txf_cap; i++) {
			if (m_t_ptr < m_t_ptr_limit)
				DEV_SPI_MASTER->DATA = *(m_t_ptr++);
			else {
				DEV_SPI_MASTER->INTREN &= ~SPI_TXFIFOINT;
				break;
			}
		}
	}
	else if (IntrSt & SPI_RXFIFOINT) {
		for (i = 0; i < m_rxf_avl; i++) {
			*(m_r_ptr++) = DEV_SPI_MASTER->DATA;
		}
	}

	DEV_SPI_MASTER->INTRST = IntrSt;

	(*intr_enable_ptr)(int_no);
}

void spis_isr(uint32_t int_no)
{
	uint32_t IntrSt;
	int i;

	(*intr_disable_ptr)(int_no);

	(*intr_clear_ptr)(int_no);

	IntrSt = DEV_SPI_SLAVE->INTRST;

	if (IntrSt & SPI_TXFIFOINT) {
		for (i = 0; i < s_txf_cap; i++) {
			if (s_t_ptr < s_t_ptr_limit)
				DEV_SPI_SLAVE->DATA = *(s_t_ptr++);
			else {
				DEV_SPI_SLAVE->INTREN &= ~SPI_TXFIFOINT;
				break;
			}
		}
	}
	else if (IntrSt & SPI_RXFIFOINT) {
		for (i = 0; i < s_rxf_avl; i++) {
			*(s_r_ptr++) = DEV_SPI_SLAVE->DATA;
		}
	}

	spis_isr_flag |= IntrSt;


	DEV_SPI_SLAVE->INTRST = IntrSt;

	(*intr_enable_ptr)(int_no);
}

void spis_wait_isr(uint32_t int_type)
{
	int wait_cnt = 0;

	while ((++wait_cnt < MAX_WAIT_CNT) && ((spis_isr_flag & int_type) == 0));

	if (wait_cnt == MAX_WAIT_CNT)
		exit(0x9999);

	spis_isr_flag = 0;
}

void prepare_data()
{
	int i, rand_base, rand_incr;

	for (i = 0, rand_base = rand(), rand_incr = rand(); i < TEST_WORDS_MAX; i++)
		data[i] = rand_base += rand_incr;
}

void read_slv_status()
{
	uint32_t SlvSt;
	int mode;

	SlvSt = ATCSPI200_PREPARE(SLVST, READY, 1) |
		ATCSPI200_PREPARE(SLVST, USR_Status, rand());

	DEV_SPI_SLAVE->SLVST = SlvSt;

	if(DEV_SPI_SLAVE->SLVST != SlvSt)
		exit(0x01);

	for (mode = 0; mode < 3; mode++) {
		if ((mode == 1) && !spi_support_dual)
			continue;
		if ((mode == 2) && !spi_support_quad)
			continue;

		DEV_SPI_MASTER->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, mode) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, (mode == 0)? 0: (mode == 1)? 1:3) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3);
		DEV_SPI_MASTER->CMD = (mode == 0)? SLV_OP_RD_ST:(mode == 1)? SLV_OP_RD_ST2: SLV_OP_RD_ST4;
		POLLING_MASTER_BSY();

		if (DEV_SPI_MASTER->DATA != SlvSt)
			exit(0x11 + mode);
	}
	if (ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->SLVST, SLVST, READY) == 0)
		exit(0x15);

}

void read_data()
{
	int i;
	uint32_t SlvDataCnt;
	int mode;
	int test_size_limit;

	test_size_limit = (s_txf_size > m_rxf_size)? m_rxf_size: s_txf_size;

	for (mode = 0; mode < 3; mode++) {
		if ((mode == 1) && !spi_support_dual)
			continue;
		if ((mode == 2) && !spi_support_quad)
			continue;

		for (i = 0; i < test_size_limit; i++) {
			DEV_SPI_SLAVE->DATA = data[i];
		}

		DEV_SPI_SLAVE->SLVST = ATCSPI200_PREPARE(SLVST, READY, 1);

		POLLING_MASTER_BSY();
		DEV_SPI_MASTER->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, mode) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, (mode==0)?0:(mode==1)?1:3) | 
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, test_size_limit * 4 - 1);
		DEV_SPI_MASTER->CMD = (mode==0)?SLV_OP_RD_DAT:(mode==1)?SLV_OP_RD_DAT2:SLV_OP_RD_DAT4;
		POLLING_MASTER_BSY();


		if (ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->SLVST, SLVST, READY) != 0)
			exit(0x20 + mode * 4);
		SlvDataCnt = DEV_SPI_SLAVE->SLVDATACNT;
		if (ATCSPI200_GET_FIELD(SlvDataCnt, SLVDATACNT, WCNT) != (test_size_limit * 4))
			exit(0x22 + mode * 4);

		for (i = 0; i < test_size_limit; i++)
			if (DEV_SPI_MASTER->DATA != data[i])
				exit(0x23 + mode * 4);
	}
}

void write_data()
{
	int i;
	uint32_t SlvDataCnt;
	int mode, test_size_limit;

	test_size_limit = (s_rxf_size > m_txf_size)?m_txf_size: s_rxf_size;

	for (mode = 0; mode < 3; mode++) {
		if ((mode == 1) && !spi_support_dual)
			continue;
		if ((mode == 2) && !spi_support_quad)
			continue;

		for (i = 0; i < test_size_limit; i++) {
			DEV_SPI_MASTER->DATA = data[i];
		}

		DEV_SPI_SLAVE->SLVST = ATCSPI200_PREPARE(SLVST, READY, 1);

		POLLING_MASTER_BSY();
		DEV_SPI_MASTER->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, mode) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_WR) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, (mode==0)?0:(mode==1)?1:3) | 
			ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, test_size_limit * 4 - 1);
		DEV_SPI_MASTER->CMD = (mode==0)?SLV_OP_WR_DAT:(mode==1)?SLV_OP_WR_DAT2:SLV_OP_WR_DAT4;
		POLLING_MASTER_BSY();

		POLLING_SLAVE_READY();
		SlvDataCnt = DEV_SPI_SLAVE->SLVDATACNT;
		if (ATCSPI200_GET_FIELD(SlvDataCnt, SLVDATACNT, RCNT) != (test_size_limit * 4))
			exit(0x32 + mode * 4);

		for (i = 0; i < test_size_limit; i++)
			if (DEV_SPI_SLAVE->DATA != data[i])
				exit(0x33 + mode * 4);
	}
}

void intr_test()
{
	int i;
	volatile int wait_cnt = 0;
	uint32_t buf;

	DEV_SPI_SLAVE->INTREN = SPI_SLVCMDINT;
	DEV_SPI_MASTER->TRANSCTRL = ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) | ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_WRonly) | ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, 0);
	DEV_SPI_MASTER->DATA = 0;
	DEV_SPI_MASTER->CMD = rand();
	i = 0;
	while ((wait_cnt++ < 5000) && ((spis_isr_flag & SPI_SLVCMDINT) == 0));
	if (wait_cnt >= 5000)
		exit(0xfe);
	if (DEV_SPI_SLAVE->CMD != DEV_SPI_MASTER->CMD)
		exit(0xff);
	POLLING_MASTER_BSY();

	ATCSPI200_SET_FIELD(DEV_SPI_SLAVE->CTRL, CTRL, TXFIFORST, 1);	
	while (ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->CTRL, CTRL, TXFIFORST));
	DEV_SPI_SLAVE->DATA = data[0];
	DEV_SPI_SLAVE->SLVST = ATCSPI200_PREPARE(SLVST, READY, 1);

	DEV_SPI_MASTER->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
		ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3); 
	DEV_SPI_MASTER->CMD = SLV_OP_RD_DAT;
	POLLING_MASTER_BSY();
	if (DEV_SPI_SLAVE->SLVST & ATCSPI200_SLVST_UNDERRUN_MASK)
		exit(0x40);

	DEV_SPI_SLAVE->INTREN = SPI_TXFIFOURINT | SPI_RXFIFOORINT;	
	DEV_SPI_MASTER->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
		ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 3); 
	DEV_SPI_MASTER->CMD = SLV_OP_RD_DAT;
	POLLING_MASTER_BSY();

	spis_wait_isr(SPI_TXFIFOURINT);

	if (DEV_SPI_MASTER->DATA != data[0])	
		exit(0x41);
	if (DEV_SPI_MASTER->DATA != 0); 
	if (ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->SLVDATACNT, SLVDATACNT, WCNT) != 4) 
		exit(0x44);
	if (!ATCSPI200_TEST_FIELD(DEV_SPI_SLAVE->SLVST, SLVST, UNDERRUN))
		exit(0x45);

	ATCSPI200_SET_FIELD(DEV_SPI_MASTER->TRANSCTRL, TRANSCTRL, RDTRANCNT, 2);
	DEV_SPI_MASTER->CMD = SLV_OP_RD_ST;
	POLLING_MASTER_BSY();

	buf = DEV_SPI_MASTER->DATA;

	if (!ATCSPI200_GET_FIELD(buf, SLVST, UNDERRUN))
		exit(0x46);
	DEV_SPI_SLAVE->SLVST = ATCSPI200_SLVST_UNDERRUN_MASK;
	if (ATCSPI200_TEST_FIELD(DEV_SPI_SLAVE->SLVST, SLVST, UNDERRUN))
		exit(0x47);
	if (ATCSPI200_GET_FIELD(buf, SLVST, OVERRUN))
		exit(0x48);


	__asm__ __volatile__ ("RXFOUI_TEST:");
	DEV_SPI_SLAVE->INTREN = SPI_RXFIFOORINT | SPI_TXFIFOURINT | SPI_ENDINT;	
	ATCSPI200_SET_FIELD(DEV_SPI_SLAVE->CTRL, CTRL, RXFIFORST, 1);	

	DEV_SPI_SLAVE->SLVST = ATCSPI200_PREPARE(SLVST, READY, 1);

	DEV_SPI_MASTER->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_WR) |
		ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, (s_rxf_size + 1) * 4); 
	DEV_SPI_MASTER->DATA = data[0];
	DEV_SPI_MASTER->CMD = SLV_OP_WR_DAT;
	for (i = 1; i < s_rxf_size + 3; i++) {
		while (ATCSPI200_TEST_FIELD(DEV_SPI_MASTER->STATUS, STATUS, TXFULL));
		int j;
		for (j = 0; j < 15; j++)
			DEV_SPI_MASTER->RESERVED0[0] = j;
		DEV_SPI_MASTER->DATA = data[i];
	}
	POLLING_MASTER_BSY();

	spis_wait_isr(SPI_RXFIFOORINT | SPI_ENDINT);

	if (ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->SLVDATACNT, SLVDATACNT, RCNT) != (((s_rxf_size + 1) * 4)+1))
		exit(0x4a);

	ATCSPI200_SET_FIELD(DEV_SPI_SLAVE->CTRL, CTRL, RXFIFORST, 1);	

	DEV_SPI_MASTER->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
		ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 2);
	DEV_SPI_MASTER->CMD = SLV_OP_RD_ST;
	POLLING_MASTER_BSY();

	buf = DEV_SPI_MASTER->DATA;

	if (!ATCSPI200_GET_FIELD(buf, SLVST, OVERRUN))
		exit(0x4b);

	DEV_SPI_SLAVE->SLVST = ATCSPI200_SLVST_OVERRUN_MASK;
	if (ATCSPI200_TEST_FIELD(DEV_SPI_SLAVE->SLVST, SLVST, OVERRUN))
		exit(0x4c);

	if (ATCSPI200_GET_FIELD(buf, SLVST, UNDERRUN))
		exit(0x4d);

	__asm__ __volatile__ ("SPIEI_TEST:");

	DEV_SPI_SLAVE->INTREN = SPI_ENDINT | SPI_TXFIFOURINT | SPI_RXFIFOORINT;
	DEV_SPI_MASTER->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_NoneData);
	do {
		buf = rand() & 0xff;
	} while (buf == SLV_OP_RD_ST || buf == SLV_OP_RD_ST2 || buf == SLV_OP_RD_ST4);
	DEV_SPI_MASTER->CMD = buf;
	POLLING_MASTER_BSY();

	spis_wait_isr(SPI_ENDINT);

	if (DEV_SPI_SLAVE->CMD != buf)
		exit(0x50);

	DEV_SPI_MASTER->TRANSCTRL =
		ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
		ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, TRANSMODE_DMY_RD) |
		ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, 0) |
		ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, 2);
	DEV_SPI_MASTER->CMD = SLV_OP_RD_ST;
	POLLING_MASTER_BSY();

	buf = DEV_SPI_MASTER->DATA;

	if (ATCSPI200_GET_FIELD(buf, SLVST, OVERRUN))
		exit(0x51);
	if (ATCSPI200_GET_FIELD(buf, SLVST, UNDERRUN))
		exit(0x52);
}


void tramode_test()
{
	uint32_t m_TRANSMODE, m_DUALQUAD, m_WRTRANCNT, m_DUMMYCNT, m_RDTRANCNT;
	uint32_t s_TRANSMODE;
	int i;

	ATCSPI200_SET_FIELD(DEV_SPI_MASTER->TRANSFMT, TRANSFMT, ADDRLEN, 0);	

	for (m_TRANSMODE = 0; m_TRANSMODE <= TRANSMODE_LAST; m_TRANSMODE++) {
		DEV_SPI_MASTER->INTREN = 0;
		DEV_SPI_SLAVE->INTREN = 0;
		DEV_SPI_SLAVE->CTRL |= ATCSPI200_CTRL_RXFIFORST_MASK | ATCSPI200_CTRL_TXFIFORST_MASK;	
		DEV_SPI_MASTER->CTRL |= ATCSPI200_CTRL_RXFIFORST_MASK | ATCSPI200_CTRL_TXFIFORST_MASK;	
		DEV_SPI_SLAVE->SLVST = ATCSPI200_SLVST_OVERRUN_MASK | ATCSPI200_SLVST_UNDERRUN_MASK;	

		m_DUALQUAD = (m_TRANSMODE == TRANSMODE_WRnRD)? 0: (uint32_t)rand() % 3;
		if ((m_DUALQUAD == 1) && !spi_support_dual)
			m_DUALQUAD = 0;
		if ((m_DUALQUAD == 2) && !spi_support_quad)
			m_DUALQUAD = 0;
		m_WRTRANCNT = ((rand() & (TEST_WORDS_MAX - 1)) + 1) * 4 - 1;
		m_DUMMYCNT = (uint32_t)rand() % 4;
		m_RDTRANCNT = (m_TRANSMODE == TRANSMODE_WRnRD)? m_WRTRANCNT:((rand() & (TEST_WORDS_MAX - 1)) + 1) * 4 - 1;

		m_r_ptr = m_r_buf;
		m_t_ptr = data;
		m_t_ptr_limit = m_t_ptr + (m_WRTRANCNT+1)/4;
		m_rxf_avl = ATCSPI200_GET_FIELD(DEV_SPI_MASTER->CTRL, CTRL, RXTHRES);
		m_txf_cap = m_txf_size - ATCSPI200_GET_FIELD(DEV_SPI_MASTER->CTRL, CTRL, TXTHRES);

		s_r_ptr = s_r_buf;
		s_t_ptr = data;
		s_t_ptr_limit = s_t_ptr + (m_RDTRANCNT+1)/4;
		s_rxf_avl = ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->CTRL, CTRL, RXTHRES);
		s_txf_cap = s_txf_size - ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->CTRL, CTRL, TXTHRES);

		s_TRANSMODE =
			(m_TRANSMODE == TRANSMODE_WRonly	)? TRANSMODE_RDonly:
			(m_TRANSMODE == TRANSMODE_RDonly	)? TRANSMODE_WRonly:
			(m_TRANSMODE == TRANSMODE_WR_RD	)? TRANSMODE_RD_WR:
			(m_TRANSMODE == TRANSMODE_RD_WR	)? TRANSMODE_WR_RD:
			(m_TRANSMODE == TRANSMODE_WR_DMY_RD	)? TRANSMODE_RD_DMY_WR:
			(m_TRANSMODE == TRANSMODE_RD_DMY_WR	)? TRANSMODE_WR_DMY_RD:
			(m_TRANSMODE == TRANSMODE_DMY_WR	)? TRANSMODE_DMY_RD:
			(m_TRANSMODE == TRANSMODE_DMY_RD	)? TRANSMODE_DMY_WR: m_TRANSMODE;

		DEV_SPI_MASTER->INTREN = SPI_TXFIFOINT | SPI_RXFIFOINT;
		DEV_SPI_SLAVE->INTREN = SPI_TXFIFOINT | SPI_RXFIFOINT | SPI_ENDINT | SPI_TXFIFOURINT | SPI_RXFIFOORINT;

		DEV_SPI_MASTER->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDREN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, ADDRFMT, 0) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, m_TRANSMODE) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, m_DUALQUAD) |
			ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, m_WRTRANCNT) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, m_DUMMYCNT) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, m_RDTRANCNT);

		DEV_SPI_SLAVE->TRANSCTRL =
			ATCSPI200_PREPARE(TRANSCTRL, CMDEN, 1) |
			ATCSPI200_PREPARE(TRANSCTRL, TRANSMODE, s_TRANSMODE) |
			ATCSPI200_PREPARE(TRANSCTRL, DUALQUAD, m_DUALQUAD) |
			ATCSPI200_PREPARE(TRANSCTRL, WRTRANCNT, m_RDTRANCNT) |
			ATCSPI200_PREPARE(TRANSCTRL, DUMMYCNT, m_DUMMYCNT) |
			ATCSPI200_PREPARE(TRANSCTRL, RDTRANCNT, m_WRTRANCNT);

		DEV_SPI_MASTER->CMD = 0x01;

		spis_wait_isr(SPI_ENDINT);

		for (i = (ATCSPI200_GET_FIELD(DEV_SPI_MASTER->STATUS, STATUS, RXNUM_LOWER) | (ATCSPI200_GET_FIELD(DEV_SPI_MASTER->STATUS, STATUS, RXNUM_UPPER) << 6)); i > 0; i--)
			*(m_r_ptr++) = DEV_SPI_MASTER->DATA;
		for (i = (ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->STATUS, STATUS, RXNUM_LOWER) | (ATCSPI200_GET_FIELD(DEV_SPI_SLAVE->STATUS, STATUS, RXNUM_UPPER) << 6)); i > 0; i--)
			*(s_r_ptr++) = DEV_SPI_SLAVE->DATA;

		if (ATCSPI200_TEST_FIELD(DEV_SPI_SLAVE->SLVST, SLVST, OVERRUN)) continue;
		if (ATCSPI200_TEST_FIELD(DEV_SPI_SLAVE->SLVST, SLVST, UNDERRUN)) continue;

		if (m_TRANSMODE == TRANSMODE_WRnRD || m_TRANSMODE == TRANSMODE_WRonly || m_TRANSMODE == TRANSMODE_WR_RD ||
				m_TRANSMODE == TRANSMODE_RD_WR || m_TRANSMODE == TRANSMODE_WR_DMY_RD ||
				m_TRANSMODE == TRANSMODE_RD_DMY_WR || m_TRANSMODE == TRANSMODE_DMY_WR) {
			for (i = 0; i < (m_WRTRANCNT + 1)/4; i++)	
				if (s_r_buf[i] != data[i]) {
					exit(0x60 + m_TRANSMODE);
				}
		}

		if (m_TRANSMODE == TRANSMODE_WRnRD || m_TRANSMODE == TRANSMODE_RDonly || m_TRANSMODE == TRANSMODE_WR_RD ||
				m_TRANSMODE == TRANSMODE_RD_WR || m_TRANSMODE == TRANSMODE_WR_DMY_RD ||
				m_TRANSMODE == TRANSMODE_RD_DMY_WR || m_TRANSMODE == TRANSMODE_DMY_RD) {
			for (i = 0; i < (m_RDTRANCNT + 1)/4; i++) {	
				if (m_r_buf[i] != data[i]) {
					exit(0x70 + m_TRANSMODE);
				}
			}
		}
	}

}

int main(int argc, char** argv)
{
	general_exc_handler_tab[GENERAL_EXC_PRECISE_BUS_ERROR] = bus_error_handler;
	general_exc_handler_tab[GENERAL_EXC_IMPRECISE_BUS_ERROR] = bus_error_handler;

        uint32_t mask;

        checking_pid = 1;
        mask = ATCSPI200_IDREV_ID_MASK;
        if (((DEV_SPI_SLAVE->IDREV & mask) != (ATCSPI200_IDREV_DEFAULT & mask)) | ((DEV_SPI_MASTER->IDREV & mask) != (ATCSPI200_IDREV_DEFAULT & mask)))
	        skip("'SPI1/SPI2 controller' should be configured to run this test.\n");         

        checking_pid = 0;

	uint32_t rand_set;

	(*intr_setup_ptr)(INT_NO_SPI_SLAVE, spis_isr);
	(*intr_setup_ptr)(INT_NO_SPI_MASTER, spim_isr);
	(*intr_enable_ptr)(INT_NO_SPI_SLAVE);
	(*intr_enable_ptr)(INT_NO_SPI_MASTER);

	get_hw_config();

	if (!s_SLAVE_SP)
		skip("Macro `ATCSPI200_SLAVE_SUPPORT should be defined in atcspi200_config.vh to enable slave mode support to run this test.\n");

	rand_set = rand();

	DEV_SPI_MASTER->TRANSFMT =
		ATCSPI200_PREPARE(TRANSFMT, ADDRLEN, 0) |
		ATCSPI200_PREPARE(TRANSFMT, DATALEN, 7) |
		ATCSPI200_PREPARE(TRANSFMT, DATAMERGE, 1) |
		ATCSPI200_PREPARE(TRANSFMT, MOSIBIDIR, 0) |
		ATCSPI200_PREPARE(TRANSFMT, LSB, rand_set >> 2) |
		ATCSPI200_PREPARE(TRANSFMT, SLVMODE, 0) |
		ATCSPI200_PREPARE(TRANSFMT, CPOL, rand_set>>1) |
		ATCSPI200_PREPARE(TRANSFMT, CPHA, rand_set);
	DEV_SPI_SLAVE->TRANSFMT =
		ATCSPI200_PREPARE(TRANSFMT, DATALEN, 7) |
		ATCSPI200_PREPARE(TRANSFMT, DATAMERGE, 1) |
		ATCSPI200_PREPARE(TRANSFMT, MOSIBIDIR, 0) |
		ATCSPI200_PREPARE(TRANSFMT, LSB, rand_set >> 2) |
		ATCSPI200_PREPARE(TRANSFMT, SLVMODE, 1) |
		ATCSPI200_PREPARE(TRANSFMT, CPOL, rand_set>>1) |
		ATCSPI200_PREPARE(TRANSFMT, CPHA, rand_set);

	DEV_SPI_MASTER->CTRL =
		ATCSPI200_PREPARE(CTRL, TXTHRES, 1) |
		ATCSPI200_PREPARE(CTRL, RXTHRES, m_rxf_size - 1) |
		ATCSPI200_PREPARE(CTRL, SPIRST, 1);

	DEV_SPI_SLAVE->CTRL =
		ATCSPI200_PREPARE(CTRL, TXTHRES, 2) |
		ATCSPI200_PREPARE(CTRL, RXTHRES, s_rxf_size - 2) |
		ATCSPI200_PREPARE(CTRL, SPIRST, 1);

	DEV_SPI_MASTER->TIMING = ATCSPI200_PREPARE(TIMING, SCLK_DIV, 50);

	prepare_data();

	read_slv_status();

	read_data();

	write_data();

	intr_test();

	tramode_test();

	return 0;
}
#endif
