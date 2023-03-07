#ifndef	__NCEPLDM200_H
#define	__NCEPLDM200_H

#include <inttypes.h>
#include "general.h"


// ======================================================
// NCEPLDM200 register definition
// ======================================================
// NCEPLDM200 registers

typedef struct {
	__I  uint32_t DEBUG_ROM[23];		// (0x00  ~ 0x58 ) Debug ROM
	__IO uint32_t RESERVED0[9];		// (0x5c  ~ 0x7c ) reserved
	__IO uint32_t PROGBUF[16];		// (0x80  ~ 0xbc ) program buffer
	__IO uint32_t DATAREG[12];		// (0xc0  ~ 0xec ) data registers
	__IO uint32_t RESERVED1[4];		// (0xf0  ~ 0xfc ) reserved
	__I  uint32_t ABSPROG[5];		// (0x100 ~ 0x110) abstract program
	__IO uint32_t RESERVED2[3];		// (0x114 ~ 0x11c) reserved
	__IO uint32_t COMMAND;			// (0x120) command register
	__IO uint32_t NOTIFY;			// (0x124) notify register
	__IO uint32_t RESUME;			// (0x128) resume register
	__IO uint32_t EXCEPTION;		// (0x12c) exception register
	__IO uint32_t RESEVED130;		// (0x130) reserved
	__IO uint32_t RESEVED134;		// (0x134) reserved
	__IO uint32_t SERIAL[1];		// (0x138) serial port
	__IO uint32_t RESERVED3[1];		// (0x13c) reserved
	__IO uint32_t HALT_REGION[8];		// (0x140 ~ 0x15c) halt region
	__IO uint32_t CLR_ABSBUSY;		// (0x160) clear absbusy
} NCEPLDM200_RegDef;

#define	NCEPLDM200_PROGBUF_SIZE		(8)
#define NCEPLDM200_DATAREG_COUNT	(4)
#define	NCEPLDM200_ABSPROG_SIZE		(5)
#define NCEPLDM200_SERIAL_COUNT		(0)

#endif // __NCEPLDM200_H
