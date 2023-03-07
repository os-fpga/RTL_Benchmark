
#ifndef __NCEPLIC100_H
#define __NCEPLIC100_H

#include <inttypes.h>

typedef struct NCEPLIC100_TARGET_EN_T{
	volatile uint32_t INT_EN[32];		// Target Interrupt enable
} NCEPLIC100_TARGET_EN_S, *NCEPLIC100_TARGET_EN_P;

typedef struct NCEPLIC100_TARGET_ATTR_T {
	volatile uint32_t THRESHOLD;		// Threshold
	volatile uint32_t CLAIM_COMP;		// Claim/Complete
	volatile uint32_t PREEMPT_PRI[8];	// Preemptive Priority stack
	volatile uint32_t RESERVED[1014];
} NCEPLIC100_TARGET_ATTR_S, *NCEPLIC100_TARGET_ATTR_P;

typedef struct NCEPLIC100_REG_T {
	volatile uint32_t FEA_EN;		// Feature Enabled Register
	volatile uint32_t INT_PRI[1023];	// Interrupt Source Priority
	volatile uint32_t INT_PEND[32];		// Interrupt Pending
	volatile uint32_t INT_TRIGTYPE[32];	// Interrupt Trigger Type
	volatile uint32_t CFG1;			// Configuration Register 1
	volatile uint32_t CFG2;			// Configuration Register 2
	volatile uint32_t RESERVED_0x1108[958];
	volatile NCEPLIC100_TARGET_EN_S TARGET_EN[16];		// Target Interrupt Enable
	volatile uint32_t RESERVED_0x2800[521728];
	volatile NCEPLIC100_TARGET_ATTR_S TARGET_ATTR[16];	// Target attribute
} NCEPLIC100_REG_S, *NCEPLIC100_REG_P;


// Feature Enabled Register
#define NCEPLIC100_FEA_EN_PREEMPT_MASK		(BIT_MASK(0, 0))			// Preemptive stack enable
#define NCEPLIC100_FEA_EN_PREEMPT_OFFSET	(0)
#define NCEPLIC100_FEA_EN_PREEMPT_DEFAULT	(0)	
#define NCEPLIC100_FEA_EN_DEFAULT		(NCEPLIC100_DEFAULT(FEA_EN, PREEMPT))

// Configuration Register 1
#define NCEPLIC100_CFG1_NUM_TARGET_MASK		(BIT_MASK(31, 16))			// The number of target
#define NCEPLIC100_CFG1_NUM_TARGET_OFFSET	(16)
#define NCEPLIC100_CFG1_NUM_TARGET_DEFAULT	(1)
#define NCEPLIC100_CFG1_NUM_INT_MASK		(BIT_MASK(15, 0))			// The number of interrupt
#define NCEPLIC100_CFG1_NUM_INT_OFFSET		(0)
#define NCEPLIC100_CFG1_NUM_INT_DEFAULT		(63)
#define NCEPLIC100_CFG1_DEFAULT			(\
						NCEPLIC100_DEFAULT(CFG1, NUM_TARGET) |\
						NCEPLIC100_DEFAULT(CFG1, NUM_INT) \
						)

// Configuration Register 2
#define NCEPLIC100_CFG2_MAX_PRI_MASK		(BIT_MASK(31, 16))			// Maximum priority
#define NCEPLIC100_CFG2_MAX_PRI_OFFSET		(16)
#define NCEPLIC100_CFG2_MAX_PRI_DEFAULT		(3)
#define NCEPLIC100_CFG2_VERSION_MASK		(BIT_MASK(15, 0))			// The version of PLIC
#define NCEPLIC100_CFG2_VERSION_OFFSET		(0)
#define NCEPLIC100_CFG2_VERSION_DEFAULT		(1)
#define NCEPLIC100_CFG2_DEFAULT			(\
						NCEPLIC100_DEFAULT(CFG2, MAX_PRI) |\
						NCEPLIC100_DEFAULT(CFG2, VERSION) \
						)

#endif // __NCEPLIC100_H


