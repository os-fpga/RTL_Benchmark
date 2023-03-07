
#ifndef __GENERAL_H
#define __GENERAL_H

//Data type
typedef enum Bool {
        FALSE,
        TRUE
} BOOL;

typedef enum {
        SUCCESS=0,
        FAIL
} STATUS;

// Register bit operation macro
#define BIT_MASK(bit_h, bit_l) ((uint64_t)((((uint64_t)0x1<<(1+bit_h-bit_l))-(uint64_t)0x1)<<bit_l))


#define SET_BIT(var, bit)			do { var |= (0x1 << (bit)); } while(0) 
#define CLR_BIT(var, bit)			do { var &= (~(0x1 << (bit))); } while(0)

#define SET_FIELD(var, mask, offset, value)	do {\
        						var = ((var) & (~mask)) | (((value) << (offset)) & (mask)); \
        					} while (0)
#define GET_FIELD(var, mask, offset)		(((var) & (mask)) >> (offset))

#define TEST_FIELD(var, mask)			((var) & (mask))

#define EXTRACT_FIELD(value, mask, offset)	(((value) & (mask)) >> (offset))
#define PREPARE_FIELD(value, mask, offset)	(((value) << (offset)) & (mask))

// Variable bit operation macro
#define VAR_TEST_BIT(var, sig)			((var) & (sig))
#define VAR_SET_BIT(var, sig)			((var) = (var) | (sig))
#define VAR_CLR_BIT(var, sig)			((var) = (var) & (~(sig)))

//Registion IO operation macro
#define REG32(a)        (*(volatile uint32_t *)(a))
#define REG16(a)        (*(volatile uint16_t *)(a))
#define REG8(a)         (*(volatile uint8_t *)(a))

#define inb(a)          REG8(a)
#define inhw(a)         REG16(a)
#define inw(a)          REG32(a)

#define outb(a, v)      (REG8(a) = (uint8_t)(v))
#define outhw(a, v)     (REG16(a) = (uint16_t)(v))
#define outw(a, v)      (REG32(a) = (uint32_t)(v))



#endif // __GENERAL_H
