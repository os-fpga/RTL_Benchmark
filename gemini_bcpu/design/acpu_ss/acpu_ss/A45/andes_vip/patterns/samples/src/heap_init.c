// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include "stdint.h"
#include "mm.h"

mm_header_p heap_start = 0;


void heap_init(void *base, unsigned int size) {
	mm_header_p heap_end;

	heap_start = (mm_header_p)(mm_align((uintptr_t)base + MM_HEADER_SIZE, MM_ALIGN_BITS) - MM_HEADER_SIZE);
	heap_end = (mm_header_p)(mm_align_low((uintptr_t)base + size, MM_ALIGN_BITS) - MM_HEADER_SIZE);


	heap_start->prev = 0;
	heap_start->next = heap_end;
	heap_start->len = 0;

	heap_end->prev = heap_start;
	heap_end->next = 0;
	heap_end->len = 0;
}


