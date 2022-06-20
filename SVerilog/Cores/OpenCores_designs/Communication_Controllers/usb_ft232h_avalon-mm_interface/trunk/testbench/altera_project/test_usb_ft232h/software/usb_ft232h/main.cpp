/*
 * main.cpp
 *
 *  Created on: 14 ����� 2017 �.
 *      Author: EDV
 */

#include <inttypes.h>
#include <stdlib.h>
#include <stdio.h>

#include "system.h"
#include "altera_avalon_dma_regs.h"
#include "altera_avalon_pio_regs.h"

#include "usb_ft232h.h"




const alt_u32 DMA_USB_TX_BASE = DMA_TX_BASE;
const alt_u32 DMA_USB_RX_BASE = DMA_RX_BASE;
const alt_u32 USB_FT232H_BASE = USB_BASE;

const alt_u16 USB_TX_FIFO_SIZE = 2048;
const alt_u16 USB_RX_FIFO_SIZE = 1024;
const alt_u16 BUFFER_SIZE = 2048;
const alt_u16 MIN_TRANSACTION_SIZE = 128;
const alt_u16 TRANSACTION_SIZE = 1024;


enum TestMode {
    TM_READ = 1,
    TM_ECHO
};


uint8_t txBuffer[BUFFER_SIZE];
uint16_t txBufferHead = 0;
uint16_t txFree = 0;
uint8_t rxBuffer[BUFFER_SIZE];
uint16_t rxBufferTail = 0;
uint16_t rxCount = 0;
uint16_t ret = 0;

uint32_t targetSize = 0;

uint32_t receivedSize = 0;
uint32_t sendedSize = 0;

uint16_t bytesRead = 0, bytesWrite = 0;

uint32_t ledDivider = 0;



void init() {
	IOWR_ALTERA_AVALON_DMA_RADDRESS(DMA_USB_RX_BASE, USB_FT232H_RDDATA_ADDR);
	IOWR_ALTERA_AVALON_DMA_WADDRESS(DMA_USB_TX_BASE, USB_FT232H_WRDATA_ADDR);
}


uint16_t getRxDataCount() {
	return IORD_USB_FT232H_RXDATA_COUNT(USB_FT232H_BASE);
//	return IORD_16DIRECT(USB_FT232H_BASE, USB_FT232H_RXSTATUSL_ADDR) & USB_FT232H_STATUS_COUNT_MSK;
}

uint16_t getTxFreeSpace() {
	return (USB_TX_FIFO_SIZE - IORD_USB_FT232H_TXDATA_COUNT(USB_FT232H_BASE));
}

uint8_t readByte() {
	return IORD_USB_FT232H_DATA(USB_FT232H_BASE);
}

void writeByte(uint8_t byte) {
	IOWR_USB_FT232H_DATA(USB_FT232H_BASE, byte);
}

inline
void readData(uint8_t *buffer, uint16_t size)
{
	for (uint16_t i = 0; i < size; ++i) {
		buffer[i] = readByte();
	}
}

inline
uint16_t readDataDMA(void *buffer, uint16_t size) {
	alt_u32 status;
	IOWR_ALTERA_AVALON_DMA_STATUS(DMA_USB_RX_BASE, 0);
	IOWR_ALTERA_AVALON_DMA_CONTROL(DMA_USB_RX_BASE, 0x1E1); //����� ��������� � �����������, � ����� ������, �� ���� ����� �����
	IOWR_ALTERA_AVALON_DMA_WADDRESS(DMA_USB_RX_BASE, reinterpret_cast<uint32_t>(buffer));
	IOWR_ALTERA_AVALON_DMA_LENGTH(DMA_USB_RX_BASE, size);
	IOWR_ALTERA_AVALON_DMA_CONTROL(DMA_USB_RX_BASE, 0x1E9);	// ���������
	do {
		status = IORD_ALTERA_AVALON_DMA_STATUS(DMA_USB_RX_BASE);
	} while (status & ALTERA_AVALON_DMA_STATUS_BUSY_MSK);
	return IORD_ALTERA_AVALON_DMA_LENGTH(DMA_USB_RX_BASE);
}

inline
void writeData(const uint8_t *data, uint16_t size)
{
	for (uint16_t i = 0; i < size; ++i)
		writeByte(data[i]);
}

inline
uint16_t writeDataDMA(void *data, uint16_t size) {
	alt_u32 status;
	IOWR_ALTERA_AVALON_DMA_STATUS(DMA_USB_TX_BASE, 0);
	IOWR_ALTERA_AVALON_DMA_CONTROL(DMA_USB_TX_BASE, 0x2E1); //����� ��������� � �����������, � ����� ������, �� ���� ����� �����
	IOWR_ALTERA_AVALON_DMA_RADDRESS(DMA_USB_TX_BASE, reinterpret_cast<uint32_t>(data));
	IOWR_ALTERA_AVALON_DMA_LENGTH(DMA_USB_TX_BASE, size);
	IOWR_ALTERA_AVALON_DMA_CONTROL(DMA_USB_TX_BASE, 0x2E9);
	do {
		status = IORD_ALTERA_AVALON_DMA_STATUS(DMA_USB_TX_BASE);
	} while (status & ALTERA_AVALON_DMA_STATUS_BUSY_MSK);
	return IORD_ALTERA_AVALON_DMA_LENGTH(DMA_USB_TX_BASE);
}

void transmitMode() {
	puts("Transmit mode");
	while(true) {
		txFree = getTxFreeSpace();
		if(txFree >= TRANSACTION_SIZE) {
			ret = writeDataDMA(&txBuffer[txBufferHead], TRANSACTION_SIZE);
//			writeData(&txBuffer[txBufferHead], TRANSACTION_SIZE);
			txBufferHead += TRANSACTION_SIZE;
			if(txBufferHead >= BUFFER_SIZE) {
				txBufferHead = 0;
			}
		}
	}
}

void echoMode() {
	rxCount = 0;
	receivedSize = 0;
	sendedSize = 0;

	readData(reinterpret_cast<uint8_t *>(&targetSize), 4);
//	printf("Echo mode. %ld\n", targetSize);

	while ((receivedSize < targetSize) || (sendedSize < targetSize)) {
		if (rxCount) {
			txFree = getTxFreeSpace();
			if (txFree >= rxCount) {
//				puts("send");
//				writeData(rxBuffer, rxCount);
				bytesWrite = writeDataDMA(rxBuffer, rxCount);
				if (bytesWrite) {
					puts("Write error");
				}
				sendedSize += rxCount;
				if (sendedSize > targetSize) {
//					printf("Too much tx data. %ld\n", sendedSize - targetSize);
				}
				rxCount = 0;
			}
		}
		else {
			rxCount = getRxDataCount();
			if (rxCount >= TRANSACTION_SIZE) {
//				puts("get");
				rxCount = TRANSACTION_SIZE;
//				readData(rxBuffer, rxCount);
				bytesRead = readDataDMA(rxBuffer, rxCount);
				if (bytesRead) {
					puts("Read error");
				}
				receivedSize += rxCount;
				if (receivedSize > targetSize) {
//					printf("Too much rx data. %ld\n", receivedSize - targetSize);
//					return;
				}
			}
			else {
				rxCount = 0;
			}
		}

		++ledDivider;
		if (ledDivider == 50000) {
			IOWR_ALTERA_AVALON_PIO_DATA(LED_BASE, 0x1);
		}
		else if (ledDivider == 100000) {
			IOWR_ALTERA_AVALON_PIO_DATA(LED_BASE, 0x0);
			ledDivider = 0;
		}
	}
//	printf("Finish. Target size: %ld Received size: %ld Sended size: %ld Rx FIFO status: %ld\n", targetSize, receivedSize, sendedSize, getRxDataCount());
}

int main() {
	init();

	uint8_t byte;

	for(int i=0; i<BUFFER_SIZE; i++) {
		txBuffer[i] = i & 0xFF;
	}

	printf("Hello\n");

	while (true) {
		rxCount = getRxDataCount();
		if (rxCount) {
			byte = readByte();
//			puts("kkd");
			printf("Read %d\n", byte);
			switch (byte) {
			case TM_READ:
				transmitMode();
				break;
			case TM_ECHO:
				echoMode();
				break;
			default:
				break;
			}
		}
	}

	/*while (true) {
		rxCount = getRxDataCount();
		if (rxCount) {
			byte = readByte();
			printf("Read %d\n", byte);
			if (byte)
				break;
		}
	}
	if(--rxCount)
		readDataDMA(rxBuffer, rxCount);
//	byte = WMODE_ECHO;

	switch (byte) {
		case TM_READ:
			transmitMode();
			break;
		case TM_ECHO:
			echoMode();
			break;
		default:
			break;
	}*/

	return 0;
}
