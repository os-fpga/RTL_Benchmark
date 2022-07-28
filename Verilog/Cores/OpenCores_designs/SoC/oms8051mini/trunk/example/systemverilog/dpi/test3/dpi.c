#include "svdpi.h"
#include <stdio.h>

extern void stepit(int, int);    // Imported from SystemVerilog
void increment(const int I1, int *I2)
{  
  *I2 = I1+1;
  printf("At C: Input: %d Output : %d\n", I1,*I2);
}
