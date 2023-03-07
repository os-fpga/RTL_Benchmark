
#ifndef __RAND_H__
#define __RAND_H__

#include <stdint.h>

#ifndef SEED
#define SEED	0x87654321
#endif

extern uint32_t nds_lfsr_seed;

#endif // __RAND_H__
