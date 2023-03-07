// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include "ndslib.h"


void rand_seq(unsigned int* array, unsigned int cnt) {
	unsigned int rnd;
	unsigned int tmp;

	while (cnt > 1) {
		rnd = rand() % cnt;
		cnt--;
		tmp = array[cnt];
		array[cnt] = array[rnd];
		array[rnd] = tmp;
	}
}
