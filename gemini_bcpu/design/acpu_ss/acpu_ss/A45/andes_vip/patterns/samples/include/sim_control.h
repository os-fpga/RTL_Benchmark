
#ifndef __SIM_CONTROL_H
#define __SIM_CONTROL_H

#include <inttypes.h>

typedef struct {
	__IO uint32_t COMMAND;		// (0x00)
	__IO uint8_t DISPLAY;		// (0x04)
	__IO uint8_t RESERVED0[3];	// (0x05 ~ 0x07)
	__IO uint32_t DEBUG;		// (0x08)
	__IO uint32_t RESERVED1;	// (0x0c)
	__IO uint32_t TEMP4;		// (0x10)
	__IO uint32_t TEMP5;		// (0x14)
	__IO uint32_t TEMP6;		// (0x18)
	__IO uint32_t TEMP7;		// (0x1c)
        __IO uint32_t DATA[16]  __attribute__((aligned(0x1000)));      // (0x1000-0x1040)
} SIM_CONTROL_RegDef;

#define SIM_CONTROL_FINISHED	0x01234567
#define SIM_CONTROL_PASSED	0x01234568
#define SIM_CONTROL_FAILED	0x01234569
#define SIM_CONTROL_WARNING	0x01234570
#define SIM_CONTROL_SKIPPED	0x01234571

#define SIM_CONTROL_SIG_START	0xdddd1111
#define SIM_CONTROL_SIG_END	0xddddeeee
#define SIM_CONTROL_EVENT_0	0xeeee0000
#define SIM_CONTROL_EVENT_1	0xeeee0001
#define SIM_CONTROL_EVENT_2	0xeeee0002
#define SIM_CONTROL_EVENT_3	0xeeee0003
#define SIM_CONTROL_EVENT_4	0xeeee0004
#define SIM_CONTROL_EVENT_5	0xeeee0005
#define SIM_CONTROL_EVENT_6	0xeeee0006
#define SIM_CONTROL_EVENT_7	0xeeee0007
#define SIM_CONTROL_EVENT_8	0xeeee0008
#define SIM_CONTROL_EVENT_9	0xeeee0009
#define SIM_CONTROL_EVENT_10	0xeeee000a
#define SIM_CONTROL_EVENT_11	0xeeee000b
#define SIM_CONTROL_EVENT_12	0xeeee000c
#define SIM_CONTROL_EVENT_13	0xeeee000d
#define SIM_CONTROL_EVENT_14	0xeeee000e
#define SIM_CONTROL_EVENT_15	0xeeee000f


#endif // __SIM_CONTROL_H
