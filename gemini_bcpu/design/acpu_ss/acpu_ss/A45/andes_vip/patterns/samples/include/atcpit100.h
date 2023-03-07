
#ifndef __ATCPIT100_H
#define __ATCPIT100_H

#include <inttypes.h>


typedef struct {
        __IO uint32_t CTRL;                 /* PIT Channel Control Register */
        __IO uint32_t RELOAD;               /* PIT Channel Reload Register */
        __IO uint32_t COUNTER;              /* PIT Channel Counter Register */
        __IO uint32_t RESERVED[1];
} ATCPIT100_CHANNEL_REG;

typedef struct {
        __I  uint32_t IDREV;                /* 0x00 ID and Revision Register */
        __IO uint32_t RESERVED[3];          /* 0x04 ~ 0x0C Reserved */
        __I  uint32_t CFG;                  /* 0x10 Configuration Register */
        __IO uint32_t INTEN;                /* 0x14 Interrupt Enable Register */
        __IO uint32_t INTST;                /* 0x18 Interrupt Status Register */
        __IO uint32_t CHNEN;                /* 0x1C Channel Enable Register */
        ATCPIT100_CHANNEL_REG   CHANNEL[4];     /* 0x20 ~ 0x50 Channel #n Registers */
} ATCPIT100_RegDef;

#define ATCPIT100_VER_DEFAULT		0x03031001
#define ATCPIT100_VER_ID_MASK		0xffffff00

#define atcpit100_channel_no(val)	(val & 0x7)

#define ATCPIT100_PWM_PARK0		0x0
#define ATCPIT100_PWM_PARK1		(0x1 << 4)

#define ATCPIT100_CLK_EXTCLK		0x0
#define ATCPIT100_CLK_PCLK		(0x1 << 3)

#define ATCPIT100_MODE_TMR32		0x1
#define ATCPIT100_MODE_TMR16		0x2
#define ATCPIT100_MODE_TMR8		0x3
#define ATCPIT100_MODE_PWM		0x4
#define ATCPIT100_MODE_PWM_TMR16	0x6
#define ATCPIT100_MODE_PWM_TMR8		0x7

#endif // __ATCPIT100_H

