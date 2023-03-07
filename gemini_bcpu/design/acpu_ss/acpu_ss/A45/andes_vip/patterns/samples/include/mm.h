
#ifndef __MM_H__
#define __MM_H__

#ifndef MM_ALIGN_BITS
#define MM_ALIGN_BITS	4
#endif

#define mm_align_low(x, n)	((x) & ~((1 << (n)) - 1))
#define mm_align(x, n)		(((x) + (1 << (n)) - 1) & ~((1 << (n)) - 1))

struct mm_header_t {
	struct mm_header_t *prev;
	struct mm_header_t *next;
	unsigned int len;
	char mem[1];
} __attribute__((__packed__));

typedef struct mm_header_t mm_header_s, *mm_header_p;

#define MM_HEADER_SIZE	(sizeof(mm_header_s) - 1)

extern mm_header_p heap_start;

#endif // __MM_H__
