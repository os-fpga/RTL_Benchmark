// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>
#include "rand.h"


uint32_t nds_lfsr_seed = SEED;


uint32_t rand(void) {
	nds_lfsr_seed = (nds_lfsr_seed >> 1) ^ (-(nds_lfsr_seed & 1u) & 0xd0000001u);

	return nds_lfsr_seed;
}

uint64_t lrand(void) {
	return (((uint64_t)rand() << 32) | ((uint64_t)rand()));
}
