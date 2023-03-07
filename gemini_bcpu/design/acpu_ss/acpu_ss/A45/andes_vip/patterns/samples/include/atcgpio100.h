#ifndef __ATCGPIO100_H
#define __ATCGPIO100_H

#include <inttypes.h>

typedef struct {
        __I  unsigned int IDREV;                /* 0x00 ID and revision register */
        __IO unsigned int RESERVED0[3];         /* 0x04 ~ 0x0c Reserved */
        __I  unsigned int CFG;                  /* 0x10 Configuration register */
        __IO unsigned int RESERVED1[3];         /* 0x14 ~ 0x1c Reserved */
        __I  unsigned int DATAIN;               /* 0x20 Channel data-in register */
        __IO unsigned int DATAOUT;              /* 0x24 Channel data-out register */
        __IO unsigned int CHANNELDIR;           /* 0x28 Channel direction register */
        __O  unsigned int DOUTCLEAR;            /* 0x2c Channel data-out clear register */
        __O  unsigned int DOUTSET;              /* 0x30 Channel data-out set register */
        __IO unsigned int RESERVED2[3];         /* 0x34 ~ 0x3c Reserved */
        __IO unsigned int PULLEN;               /* 0x40 Pull enable register */
        __IO unsigned int PULLTYPE;             /* 0x44 Pull type register */
        __IO unsigned int RESERVED3[2];         /* 0x48 ~ 0x4c Reserved */
        __IO unsigned int INTREN;               /* 0x50 Interrupt enable register */
        __IO unsigned int INTRMODE0;            /* 0x54 Interrupt mode register (0~7) */
        __IO unsigned int INTRMODE1;            /* 0x58 Interrupt mode register (8~15) */
        __IO unsigned int INTRMODE2;            /* 0x5c Interrupt mode register (16~23) */
        __IO unsigned int INTRMODE3;            /* 0x60 Interrupt mode register (24~31) */
        __IO unsigned int INTRSTATUS;           /* 0x64 Interrupt status register */
        __IO unsigned int RESERVED4[2];         /* 0x68 ~ 0x6c Reserved */
        __IO unsigned int DEBOUNCEEN;           /* 0x70 De-bounce enable register */
        __IO unsigned int DEBOUNCECTRL;         /* 0x74 De-bounce control register */
} ATCGPIO100_RegDef;

#define ATCGPIO100_IDREV_ID_MASK (BIT_MASK(31, 8))
#define ATCGPIO100_IDREV_DEFAULT	0x02031001

#define ATCGPIO100_CFG_PULL_SUPPORT	0x80000000
#define ATCGPIO100_CFG_INTR_SUPPORT	0x40000000
#define ATCGPIO100_CFG_DEBOUNCE_SUPPORT	0x20000000

#define atcgpio100_channel_no(val)	(val & 0x3f)

#define ATCGPIO100_INTR_MODE_HIGH_LEVEL		((uint32_t)0x2)
#define ATCGPIO100_INTR_MODE_LOW_LEVEL		((uint32_t)0x3)
#define ATCGPIO100_INTR_MODE_FALLING_EDGE	((uint32_t)0x5)
#define ATCGPIO100_INTR_MODE_RISING_EDGE	((uint32_t)0x6)
#define ATCGPIO100_INTR_MODE_DUAL_EDGE		((uint32_t)0x7)

#endif // __ATCGPIO100_H
