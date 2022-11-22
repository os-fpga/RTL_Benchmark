/*
 * usb_ft232h.h
 *
 *  Created on: 06 ��� 2016 �.
 *      Author: EDV
 */

#ifndef USB_FT232H_H_
#define USB_FT232H_H_

#include <io.h>

#define USB_FT232H_WRDATA_ADDR		0x0
#define USB_FT232H_RRDATA_ADDR		0x1
#define USB_FT232H_TXSTATUSL_ADDR	0x2
#define USB_FT232H_TXSTATUSH_ADDR	0x3
#define USB_FT232H_RXSTATUSL_ADDR	0x4
#define USB_FT232H_RXSTATUSH_ADDR	0x5

#define USB_FT232H_STATUS_READY_MSK		0x8000
#define USB_FT232H_STATUS_COUNT_MSK		0x7FFF


#define IOWR_USB_FT232H_DATA(base, data)	IOWR_8DIRECT(base, USB_FT232H_WRDATA_ADDR, data)
#define IORD_USB_FT232H_DATA(base)			IORD_8DIRECT(base, USB_FT232H_RDDATA_ADDR)
#define IORD_USB_FT232H_TXSTATUS(base)		(IORD_8DIRECT(base, USB_FT232H_TXSTATUSL_ADDR) | (IORD_8DIRECT(base, USB_FT232H_TXSTATUSH_ADDR) << 8))
#define IORD_USB_FT232H_RXSTATUS(base)		(IORD_8DIRECT(base, USB_FT232H_RXSTATUSL_ADDR) | (IORD_8DIRECT(base, USB_FT232H_RXSTATUSH_ADDR) << 8))
#define IORD_USB_FT232H_TXDATA_COUNT(base)	(IORD_USB_FT232H_TXSTATUS(base) & USB_FT232H_STATUS_COUNT_MSK)
#define IORD_USB_FT232H_RXDATA_COUNT(base)	(IORD_USB_FT232H_RXSTATUS(base) & USB_FT232H_STATUS_COUNT_MSK)


#endif /* USB_FT232H_H_ */