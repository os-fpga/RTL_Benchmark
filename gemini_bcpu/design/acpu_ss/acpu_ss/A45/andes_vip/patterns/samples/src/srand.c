// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include "rand.h"

void srand(unsigned int seed) {
	nds_lfsr_seed = seed;
}


