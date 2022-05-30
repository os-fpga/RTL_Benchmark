
#include <stdio.h>
#include <unistd.h>
#include <io.h>

#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_dma.h"
#include "altera_avalon_dma_regs.h"
#include "altera_avalon_sgdma.h"

#include "types.h"


alt_dma_txchan txchan;
alt_dma_rxchan rxchan;
alt_sgdma_dev *rxdma;
alt_sgdma_descriptor rxdesc;
alt_sgdma_descriptor rxdescNext;

volatile int transmit_done = 0;
volatile int receive_done = 0;
volatile uint32_t total_send = 0;
volatile uint32_t total_get = 0;
volatile uint32_t index = 0;

volatile uint8_t ubuff[40000];
volatile uint32_t ubuffCount = 0;
volatile uint32_t ubuffTail = 0;
volatile uint32_t ubuffHead = 0;

volatile alt_u8 dat = 0;
volatile int rxErrors = 0;

enum eState{
	IDLE,
	RECEIVE,
	TRANSMIT
};
volatile eState state = IDLE;


void callback_dma_tx(void* handle) {
	transmit_done++;
	total_send += (int)handle;
	index += (int)handle;
	if(index >= 32768)
		index = 0;
}

void callback_dma_rx(void* handle, void* data) {
	receive_done++;
	total_get += (int)handle;
}

int main(void)
{
	printf("Started...\n");

	uint16_t count = 0;
	uint16_t free = 0;
	int error = 0;

	/*for(int i=0; i<sizeof(ubuff); i++) {
		ubuff[i] = i & 0xFF;
	}*/

	uint8_t txbuff[32768];
	for(int i=0; i<sizeof(txbuff); i++) {
		txbuff[i] = i & 0xFF;
	}

	txchan = alt_dma_txchan_open(USB_DMA_TX_NAME);
	if(txchan == NULL) {
		puts("TXCHAN is NULL");
		return -2;
	} else {
		puts("txchan is OK");
//		IOWR_ALTERA_AVALON_DMA_CONTROL(USB_DMA_TX_BASE, (1<<ALTERA_AVALON_DMA_CONTROL_WCON_OFST));
		alt_dma_txchan_ioctl(txchan, ALT_DMA_TX_ONLY_ON, 0x0);
		alt_dma_txchan_ioctl(txchan, ALT_DMA_SET_MODE_8, NULL);
	}

	/*rxchan = alt_dma_rxchan_open(USB_DMA_RX_NAME);
	if(rxchan == NULL) {
		puts("RXCHAN is NULL");
		return -2;
	} else {
		puts("rxchan is OK");
//		IOWR_ALTERA_AVALON_DMA_CONTROL(USB_DMA_RX_BASE, (1<<ALTERA_AVALON_DMA_CONTROL_RCON_OFST));
		alt_dma_rxchan_ioctl(rxchan, ALT_DMA_RX_ONLY_ON, (void*)0x1);
		alt_dma_rxchan_ioctl(rxchan, ALT_DMA_SET_MODE_8, NULL);
	}*/

	rxdma = alt_avalon_sgdma_open(USB_SGDMA_RX_NAME);
	if(rxdma == NULL) {
		puts("Rx DMA is NULL");
		return - 3;
	} else {
		puts("Rx DMA is OK");
	}

	ubuffHead = 0;
	ubuffTail = 0;
	ubuffCount = 0;

	int divider = 0;
	alt_u8 led = 0;

	while (true)
	{
		divider++;
		if(divider == 100000) {
			if(led & 0x1)
				led = 0x0;
			else
				led = 0x1;
			IOWR_ALTERA_AVALON_PIO_DATA(LED_BASE, led);
			divider = 0;
			printf("%d\/%d tx=%d rx=%d err=%d\n", total_get, total_send, transmit_done, receive_done, rxErrors);
		}

		switch(state) {
		case RECEIVE:
			if((receive_done == 0) && (transmit_done == 0) && (total_send < 524288)) {
//				state = TRANSMIT;
				count = IORD_8DIRECT(FT232H_BASE, 0x2) | (IORD_8DIRECT(FT232H_BASE, 0x3) << 8);
				if(count & (1<<15)) {
					free = 1024 - (count & 0x7FFF);
//					if(free > ubuffCount) free = ubuffCount;
					if(free > (32768-index)) free = 32768-index;
					if(free) {
						/*for(int i=0; i<free; i++)
							IOWR_8DIRECT(FT232H_BASE, 0x0, txbuff[total_send+i]);
						total_send += free;*/

						if(alt_dma_txchan_send(txchan, (void*)&txbuff[index], free, callback_dma_tx, (void*)free) == 0){
							transmit_done--;
//							ubuffCount -= free;
//							ubuffHead += free;
//							state = TRANSMIT;
						}
					}
				}
			}
			state = TRANSMIT;
			break;
		case TRANSMIT:
			if(transmit_done == 0) {
//				printf("get %d send %d count %d\n", ubuffTail, ubuffHead, ubuffCount);
				state = IDLE;
			}
			break;
		default:
			if((receive_done == 0) && (transmit_done == 0)) {
			count = IORD_8DIRECT(FT232H_BASE, 0x4) | (IORD_8DIRECT(FT232H_BASE, 0x5) << 8);
			if(count & (1<<15)) {
				count &= 0x7FFF;
				if(count) {
					alt_avalon_sgdma_construct_mem_to_mem_desc(&rxdesc, &rxdescNext,
							(alt_u32*)0x1, (alt_u32*)&ubuff[ubuffTail], count, 1, 0);
					error = alt_avalon_sgdma_do_sync_transfer(rxdma, &rxdesc);
					if(error == 0x0C) {
						total_get += count;
						for(int i=0; i<count; i++) {
							if(ubuff[i] != dat) {
								rxErrors++;
								dat = ubuff[i];
							} else {
								dat++;
							}
						}
					} else {
						puts("Get data FAILED");
					}

					/*error = alt_dma_rxchan_prepare(rxchan, (void*)&ubuff[ubuffTail], count, callback_dma_rx, (void*)count);
					if(error == 0) {
//						ubuffTail += count;
//						ubuffCount += count;
						receive_done--;
//						state = RECEIVE;
					}*/
				}
			}
			state = RECEIVE;
			}
			break;
		}
	}

	return 0;
}
