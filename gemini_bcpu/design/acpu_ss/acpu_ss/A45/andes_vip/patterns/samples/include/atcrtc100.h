
#ifndef __ATCRTC100_H
#define __ATCRTC100_H

#include <inttypes.h>


typedef struct {
        __I  unsigned int IDREV;                /* 0x00 ID and Revision Register */
        __IO unsigned int RESERVED[3];          /* 0x04 ~ 0x0C Reserved */
        __IO unsigned int CNTR;                 /* 0x10 Counter Register */
        __IO unsigned int ALARM;                /* 0x14 Alarm Register */
        __IO unsigned int CTRL;                 /* 0x18 Control Register */
        __IO unsigned int STATUS;               /* 0x1C Status Register */
        __IO unsigned int TRIM;                 /* 0x20 Status Register */
} ATCRTC100_RegDef;

#define ATCRTC100_IDREV_ID_MASK (BIT_MASK(31, 8))
#define ATCRTC100_IDREV_ID_DEFAULT      (0x03011000)
#define ATCRTC100_CR_EN_HSEC_INT	(0x1 << 7)
#define ATCRTC100_CR_EN_SEC_INT		(0x1 << 6)
#define ATCRTC100_CR_EN_MIN_INT		(0x1 << 5)
#define ATCRTC100_CR_EN_HOUR_INT	(0x1 << 4)
#define ATCRTC100_CR_EN_DAY_INT		(0x1 << 3)
#define ATCRTC100_CR_EN_ALARM_INT	(0x1 << 2)
#define ATCRTC100_CR_EN_ALARM_WAKEUP	(0x1 << 1)
#define ATCRTC100_CR_EN_RTC		0x1

#define ATCRTC100_SR_WR_DONE		(0x1 << 16)
#define ATCRTC100_SR_HSEC_INT		(0x1 << 7)
#define ATCRTC100_SR_SEC_INT		(0x1 << 6)
#define ATCRTC100_SR_MIN_INT		(0x1 << 5)
#define ATCRTC100_SR_HOUR_INT		(0x1 << 4)
#define ATCRTC100_SR_DAY_INT		(0x1 << 3)
#define ATCRTC100_SR_ALARM_INT		(0x1 << 2)

#endif // __ATCRTC100_H
