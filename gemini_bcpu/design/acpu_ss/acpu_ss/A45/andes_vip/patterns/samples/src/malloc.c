// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include "stddef.h"
#include "mm.h"


void *malloc(size_t size) {
	mm_header_p current_ptr;
	mm_header_p new_ptr;

	size += MM_HEADER_SIZE;
	size = mm_align(size, MM_ALIGN_BITS);

	current_ptr = heap_start;
	while (1) {
		if ((((char *)current_ptr) + current_ptr->len + size) <= ((char *)current_ptr->next))
			break;

		current_ptr = current_ptr->next;
		if (current_ptr->next == 0)
			return (0);
	}

	if (current_ptr->len == 0) {
		current_ptr->len = size;

		return (&current_ptr->mem);
	}

	new_ptr = (mm_header_p)((char *)current_ptr + current_ptr->len);
	new_ptr->prev = current_ptr;
	new_ptr->next = current_ptr->next;
	new_ptr->len = size;

	current_ptr->next = new_ptr;
	new_ptr->next->prev = new_ptr;

	return (&new_ptr->mem);
}


