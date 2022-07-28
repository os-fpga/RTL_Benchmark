/*
 * UART Software Loop Back.
 * Software continously check the Uart Rx Buffer, If the RX Buffer is not zero,
 * Then it read the Rx data and copy the information back to tx fifo
 */

/*---------------------------------------------------------------------------*/

#include <8051.h>

char cErrCnt;
/*---------------------------------------------------------------------------*/

__xdata __at (0x9000) unsigned char uart_reg0;
__xdata __at (0x9001) unsigned char uart_reg1;
__xdata __at (0x9002) unsigned char uart_reg2;
__xdata __at (0x9003) unsigned char uart_reg3;
volatile __xdata __at (0x9004) unsigned char uart_reg4;
__xdata __at (0x9005) unsigned char uart_tdata;
__xdata __at (0x9006) unsigned char uart_rdata;

void main() {
    
    unsigned int cFrameCnt = 0;
    /*** 
     [4:3] = 0 -> No Parity
     [2]   = 1 - 2 Stop 
     [1]   = 1 - Rx Enable
     [0]   = 1 - Tx Enable
    **/
    uart_reg0 = 0x7;
    uart_reg2 = 0x0; // Baud Clock
    uart_reg3 = 0x0; // Baud Clock
    while(1) {
       if((uart_reg4 & 0x2) == 0) { // Check the Rx Fifo  Counter
          // Read the Receive FIFO
          uart_tdata = uart_rdata;
          cFrameCnt  = cFrameCnt+1;
         }
    }
}
