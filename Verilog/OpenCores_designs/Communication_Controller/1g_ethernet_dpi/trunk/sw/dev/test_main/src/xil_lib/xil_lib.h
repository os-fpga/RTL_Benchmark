#ifndef _XIL_LIB_H_
#define _XIL_LIB_H_


// custom funct:
void *xil_memset(void *s, int c, unsigned int count);
void *xil_memmove(void *d, const void *s, unsigned int count);
// libgloss (xil_malloc.c):
#ifndef MSIM
 void *xil_malloc(unsigned int nbytes);
 void xil_free(void *ap);
#else
 #include "stdlib.h"
 #define xil_malloc(x) malloc(x)
 #define xil_free(x) free(x)
#endif // MSIM


#endif   // _XIL_LIB_H_
