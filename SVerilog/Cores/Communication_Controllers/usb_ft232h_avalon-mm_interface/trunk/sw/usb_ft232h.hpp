/*
 * usb_ft232h.h
 *
 *  Created on: 06 ��� 2016 �.
 *      Author: EDV
 */

#ifndef USB_FT232H_H_
#define USB_FT232H_H_

#include <io.h>


const alt_u8 USB_FT232H_WRDATA_ADDR		= 0x0;			//!< Address for write data
const alt_u8 USB_FT232H_RDDATA_ADDR		= 0x1;			//!< Address for read data
const alt_u8 USB_FT232H_TXSTATUSL_ADDR	= 0x2;			//!< Address for low byte of TX FIFO status register
const alt_u8 USB_FT232H_TXSTATUSH_ADDR	= 0x3;			//!< Address for high byte of TX FIFO status register
const alt_u8 USB_FT232H_RXSTATUSL_ADDR	= 0x4;			//!< Address for low byte of RX FIFO status register
const alt_u8 USB_FT232H_RXSTATUSH_ADDR	= 0x5;			//!< Address for high byte of RX FIFO status register

const alt_u16 USB_FT232H_STATUS_READY_MSK		= 0x8000;	//!< Ready bit mask of RX or TX FIFO status register
const alt_u16 USB_FT232H_STATUS_DATA_SIZE_MSK	= 0x7FFF;	//!< Data size mask of RX or TX FIFO status register



/*!
 * \brief Request data of rx FIFO status register
 * \param[in] base Module address
 * \return Rx FIFO status register data.
 */
inline alt_u16 usbFT232HGetRxFifoStatus(alt_u32 base)
{
	return IORD_16DIRECT(base, USB_FT232H_RXSTATUSL_ADDR);
//	return (IORD_8DIRECT(base, USB_FT232H_RXSTATUSL_ADDR) | (IORD_8DIRECT(base, USB_FT232H_RXSTATUSH_ADDR) << 8));
}

/*!
 * \brief Request data of tx FIFO status register
 * \param[in] base Module address
 * \return Tx FIFO status register data.
 */
inline alt_u16 usbFT232HGetTxFifoStatus(alt_u32 base)
{
	return IORD_16DIRECT(base, USB_FT232H_TXSTATUSL_ADDR);
//	return (IORD_8DIRECT(base, USB_FT232H_TXSTATUSL_ADDR) | (IORD_8DIRECT(base, USB_FT232H_TXSTATUSH_ADDR) << 8));
}

/*!
 * \brief Request number of bytes stored in rx FIFO
 * \param[in] base Module address
 * \return Number of bytes stored in rx FIFO
 */
inline alt_u16 usbFT232HGetNumberOfDataInRxFifo(alt_u32 base)
{
	return (usbFT232HGetRxFifoStatus(base) & USB_FT232H_STATUS_DATA_SIZE_MSK);
}

/*!
 * \brief Request number of bytes stored in tx FIFO
 * \param[in] base Module address
 * \return Number of bytes stored in tx FIFO
 */
inline alt_u16 usbFT232HGetNumberOfDataInTxFifo(alt_u32 base)
{
	return (usbFT232HGetTxFifoStatus(base) & USB_FT232H_STATUS_DATA_SIZE_MSK);
}

/*!
 * \brief Write byte to module
 * \param[in] base Module address
 * \param[in] byte Byte for write to the FIFO
 */
inline void usbFT232HWriteByte(alt_u32 base, alt_u8 byte)
{
	IOWR_8DIRECT(base, USB_FT232H_WRDATA_ADDR, byte);
}

/*!
 * \brief Read byte from the FIFO
 * \param[in] base Module address
 * \return Byte read from the FIFO
 */
inline alt_u8 usbFT232HReadByte(alt_u32 base)
{
	return IORD_8DIRECT(base, USB_FT232H_RDDATA_ADDR);
}


#endif /* USB_FT232H_H_ */
