#ifndef __ATFSMC020_H
#define __ATFSMC020_H

// ======================================================
// Include files
// ======================================================
#include <inttypes.h>
#include "general.h"

// ======================================================
// ATFSMC020 register definition
// ======================================================
// ATFSMC020 registers
typedef struct atfsmc020_reg_t {
	volatile uint32_t bank0_cfg;		// (0x00) Configuration register of memorybank 0
	volatile uint32_t bank0_tpr;		// (0x04) Timing parameter register of memory bank 0
	volatile uint32_t bank1_cfg;		// (0x08) Configuration register of memorybank 1
	volatile uint32_t bank1_tpr;		// (0x0c) Timing parameter register of memorybank 1
	volatile uint32_t bank2_cfg;		// (0x10) Configuration register of memorybank 2
	volatile uint32_t bank2_tpr;		// (0x14) Timing parameter register of memorybank 2
	volatile uint32_t bank3_cfg;		// (0x18) Configuration register of memorybank 3
	volatile uint32_t bank3_tpr;		// (0x1c) Timing parameter register of memorybank 3
	volatile uint32_t bank4_cfg;		// (0x20) Configuration register of memorybank 4
	volatile uint32_t bank4_tpr;		// (0x24) Timing parameter register of memorybank 4
	volatile uint32_t bank5_cfg;		// (0x28) Configuration register of memorybank 5
	volatile uint32_t bank5_tpr;		// (0x2c) Timing parameter register of memorybank 5
	volatile uint32_t bank6_cfg;		// (0x30) Configuration register of memorybank 6
	volatile uint32_t bank6_tpr;		// (0x34) Timing parameter register of memorybank 6
	volatile uint32_t bank7_cfg;		// (0x38) Configuration register of memorybank 7
	volatile uint32_t bank7_tpr;		// (0x3c) Timing parameter register of memorybank 7
} ATFSMC020_RegDef;

#define FLASH_SIZE_32K	0xb
#define FALSH_SIZE_64K	0xc
#define FLASH_SIZE_128K	0xd
#define FLASH_SIZE_256K	0xe
#define FALSH_SIZE_512K	0xf
#define FLASH_SIZE_1M	0x0
#define FLASH_SIZE_2M	0x1
#define FLASH_SIZE_4M	0x2
#define FLASH_SIZE_8M	0x3
#define FLASH_SIZE_16M	0x4
#define FLASH_SIZE_32M	0x5
#define FALSH_SIZE_64M	0x6

#endif // __ATFSMC020_H
