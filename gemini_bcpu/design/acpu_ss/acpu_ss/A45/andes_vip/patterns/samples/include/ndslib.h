
#ifndef __NDSLIB_H
#define __NDSLIB_H

#include <inttypes.h>
#include "stddef.h"

extern void exit(int status);
extern void skip(const char *fmt, ...);

extern void heap_init(void *base, unsigned int size);
extern void *malloc(size_t size);
extern void free(void *ptr);
extern void *memalign(unsigned int boundary, unsigned int size);

extern int rand(void);
extern long int lrand(void);
extern void srand(unsigned int seed);
extern void rand_seq(unsigned int* array, unsigned int cnt);

#endif // __NDSLIB_H

