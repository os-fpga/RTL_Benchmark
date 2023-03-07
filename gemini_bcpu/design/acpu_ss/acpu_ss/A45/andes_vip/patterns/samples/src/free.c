// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include "mm.h"


void free(void *ptr) {
	mm_header_p current_ptr;
	mm_header_p prev_ptr;

	if (ptr == 0)
		return;

	current_ptr = (mm_header_p)((char *)ptr - MM_HEADER_SIZE);

	if (current_ptr->prev == 0) {
		current_ptr->len = 0;
		return;
	}

	prev_ptr = current_ptr->prev;
	prev_ptr->next = current_ptr->next;
	current_ptr->next->prev = prev_ptr;
}


