/*---------------------------------------------------------------------
--	Filename:	yanu_hw.h
--
--			
--	Description:
--		YANU low level registers bitmaps 
--              
--	Copyright (c) 2009 by Renato Andreola (Imagos sas)
--
--	This file is part of YANU.
--	YANU is free software: you can redistribute it and/or modify
--	it under the terms of the GNU Lesser General Public License as published by
--	the Free Software Foundation, either version 3 of the License, or
--	(at your option) any later version.
--	YANU is distributed in the hope that it will be useful,
--	but WITHOUT ANY WARRANTY; without even the implied warranty of
--	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	GNU Lesser General Public License for more details.
--
--	You should have received a copy of the GNU Lesser General Public License
--	along with YANU.  If not, see <http://www.gnu.org/licenses/>.
--	
--	Revision	History:
--	Revision	Date      	Author   	Comment
--	--------	----------	---------	-----------
--	1.0     	30/05/2009	Renato Andreola	Initial revision
--	
--------------------------------------------------------
*/

#ifndef _YANU_HW_H_
#define _YANU_HW_H_


/* TX/RX FIFO is 16 byte length */
#define YANU_FIFO_SIZE    (16)
#define YANU_RXFIFO_SIZE  (YANU_FIFO_SIZE)
#define YANU_TXFIFO_SIZE  (YANU_FIFO_SIZE)
#define YANU_RXFIFO_DLY   (11*10)
#define YANU_TXFIFO_THR   (10)

#define YANU_MAX_PRESCALER_N   ((1 << 4) - 1)  /* 15 */
#define YANU_MAX_PRESCALER_M   ((1 << 11) -1)  /* 2047 */
#define YANU_DATA_CHAR_MASK    (0xFF)


/* data register */
#define DATA_OFFSET    (0)          /* data register offset */

/* 
   control register (RW) 32 bit
   hhena            hardware handshake enable (rts/cts) (*1)
   txthr[3..0]      transmit fifo threshold (*3)
   rdydly[7..0]     character ready delay in units of bits (*2)
   stops            number of (tx) stop bits: 0-> insert 1 stop bit, 1-> insert 2 stop bits
   pareven          1-> parity even
   parena           1-> parity enable
   bits[2..0]       number of rx/tx bits per word minus 1
   iepe             interrupt enable (ie) on parity error
   iefe             ie on framing error: false start bit or missing stop bit
   iebrk            ie on break error: a whole word of zeros with a zero parity and a zero stop bit
   ieoe             ie on receiver overrun
   ierrdy           ie on received character ready (*2)
   ietrdy           ie on transmitter ready (*3)
   Notes:
   (*1) Set CTS (output) = NOT rrdy flag. note thet rxrdy flag will be asserted after (probably) the number 
   of character programmed with rdydly[]. Use RTS (input) to mask the transmission of characters.
   (*2) Set rrdy flag after rdydly[] bit times from the reception of the first char.
   In case of a full speed (no extra delays between characters) there will be rdydly[]*8/M bits into rx fifo
   when rrdy will be set; M = 8+1(start)+1+stops+parity.
   (*3) The transmit interrut flag (trdy) is set when the number of chars into the tx fifo is lower or equal than ththr[]
*/
#define YANU_CONTROL_OFFSET    (4)         /* control register offset */
/* interrupt enable */
#define YANU_CONTROL_IE_RRDY   (1<<0)	   /* ie on received character ready enabled */
#define YANU_CONTROL_IE_OE     (1<<1)	   /* ie on rx overrun enabled */
#define YANU_CONTROL_IE_BRK    (1<<2)	   /* ie on break detect enabled  */
#define YANU_CONTROL_IE_FE     (1<<3)	   /* ie on framing error enabled */
#define YANU_CONTROL_IE_PE     (1<<4)	   /* ie on parity error enabled  */
#define YANU_CONTROL_IE_TRDY   (1<<5)	   /* ie interrupt on tranmitter ready enabled */
/* control bits */
#define YANU_CONTROL_BITS_POS  (6)	   /* bits number pos */
#define YANU_CONTROL_BITS      (1<<YANU_CONTROL_BITS_POS) /* number of rx/tx bits per word. 3 bit unsigned integer */
#define YANU_CONTROL_BITS_N    (3)	   /* ... its bit filed length */
#define YANU_CONTROL_PARENA    (1<<9)	   /*  enable parity bit transmission/reception */
#define YANU_CONTROL_PAREVEN   (1<<10)	   /* parity even */
#define YANU_CONTROL_STOPS     (1<<11)	   /* number of stop bits */
#define YANU_CONTROL_HHENA     (1<<12)	   /* Harware Handshake enable... */
#define YANU_CONTROL_FORCEBRK  (1<<13)	   /* if set than txd = active (0) */
/* tuning part */
#define YANU_CONTROL_RDYDLY    (1<<14)	   /* delay from "first" before setting rrdy (in bit) */
#define YANU_CONTROL_RDYDLY_N  (8)	   /* ... its bit filed length */
#define YANU_CONTROL_TXTHR     (1<<22)	   /* tx interrupt threshold: the trdy set if txfifo_chars<= txthr (chars) */
#define YANU_CONTROL_TXTHR_N   (4)	   /* ... its bit field length */
#define YANU_CONTROL_RX_INV    (1<<26)	   /* RX inverted */
#define YANU_CONTROL_TX_INV    (1<<27)	   /* TX inverted */
#define YANU_CONTROL_RTS_INV   (1<<28)	   /* RTS inverted */
#define YANU_CONTROL_CTS_INV   (1<<29)	   /* CTS inverted */
#define YANU_CONTROL_OUT0      (1<<30)	   /* debug output 0 (used to test the hardware) */
#define YANU_CONTROL_OUT1      (1<<31)	   /* debug output 1 (used to test the hardware) */

/*
  yanu baud rate register/prescaler
  
  ---------------------------------------
 | n n n n | m m m m m m m m m m m m m m |
  --------------------------------------- 

 The baud rate is coded using 16 bits and this way:

 baud = cpu_clock_freq / 2^n * m / 2^12 * 1 / 8
 
 The baud rate equation is BR = baudm[]/(2^(15+baude[]))
 baudm[11..0]      baud rate mantissa, 12 bits, unsigned (*1)
 baude[3..0]       baud rate exponent, 4 bits (*1)
*/
#define YANU_BAUD_OFFSET  (8)        /* baud register offset */
#define YANU_BAUDM        (1<<0)     /* baud mantissa lsb */
#define YANU_BAUDM_N      (12)       /* ...its bit filed length */
#define YANU_BAUDE        (1<<12)    /* baud exponent lsb */
#define YANU_BAUDE_N      (4)	/* ...its bit field length */


/* action register (W): used to clear/set interrupt flags, pull data from fifo, clear fifos, etc... 
   rrrdy       writing a 1 to this bit clears RxReaDY flag
   roe         clear overrun error flag
   rbrk        clear break detect error flag
   rfe         clear framing error flag
   rpe         clear parity error flag
   srrdy       writing a 1 to this bit sets RxReaDY flag
   soe         set overrun error flag
   sbrk        set break detect error flag
   sfe         set framing error flag
   spe         set parity error flag
   rfifo_pull  writing a 1 to this bit pulls a data from RX fifo to data register
   rfifo_clear reset to empty the RX fifo
   tfifo_clear reset to empty the txfifo
   rtrdy       reset trdy flag
   strdy       set trdy flag
*/
#define YANU_ACTION_OFFSET   (12)    /* action register... write only */
#define YANU_ACTION_RRRDY    (1<<0)	/* reset rrdy */
#define YANU_ACTION_ROE      (1<<1)	/* reset oe */
#define YANU_ACTION_RBRK     (1<<2)	/* reset brk */
#define YANU_ACTION_RFE      (1<<3)	/* reset fe  */
#define YANU_ACTION_RPE      (1<<4)	/* reset pe  */
#define YANU_ACTION_SRRDY    (1<<5)	/* set rrdy  */
#define YANU_ACTION_SOE      (1<<6)	/* set oe    */
#define YANU_ACTION_SBRK     (1<<7)	/* set brk   */
#define YANU_ACTION_SFE      (1<<8)	/* set fe    */
#define YANU_ACTION_SPE      (1<<9)	/* set pe    */
#define YANU_ACTION_RFIFO_PULL  (1<<10)	/* pull a char from rx fifo we MUST do it before taking a char */
#define YANU_ACTION_RFIFO_CLEAR (1<<11)	/* clear rx fifo */
#define YANU_ACTION_TFIFO_CLEAR (1<<12)	/* clear tx fifo */
#define YANU_ACTION_RTRDY       (1<<13)	/* clear trdy    */
#define YANU_ACTION_STRDY       (1<<14)	/* set trdy      */


/* status register (R) 32 bit hold status flags status, fifos' word counters, etc...
   rrdy   some data are ready to be read from rx fifo
   trdy   some data can be held into tx fifo
   oe     overrun error flag
   brk    break detect flag
   fe     framing error flag
   pe     parity error flag
   rfifo_chars[] number of chars currently held into rx fifo
   tfifo_chars[] number of chars currently held into tx fifo
*/
#define YANU_STATUS_OFFSET   (16)
#define YANU_STATUS_RRDY     (1<<0)	        /* rxrdy flag */
#define YANU_STATUS_TRDY     (1<<1)		/* txrdy flag */
#define YANU_STATUS_OE       (1<<2)		/* rx overrun error */
#define YANU_STATUS_BRK      (1<<3)		/* rx break detect flag */
#define YANU_STATUS_FE       (1<<4)		/* rx framing error flag */
#define YANU_STATUS_PE       (1<<5)		/* rx parity erro flag */
#define YANU_RFIFO_CHARS_POS (6)
#define YANU_RFIFO_CHARS     (1<<RFIFO_CHAR_POS)  /* number of chars into rx fifo */
#define YANU_RFIFO_CHARS_N   (5)		  /* ...its bit field length: 32 chars */
#define YANU_TFIFO_CHARS_POS (11)
#define YANU_TFIFO_CHARS     (1<<TFIFO_CHAR_POS)  /* number of chars into tx fifo */
#define YANU_TFIFO_CHARS_N   (5)		  /* ...its bit field length: 32 chars */

/* YANU data registers definition */ 
typedef volatile struct
{
/* 
   data register (RW) 32 bit, just lsB is used a read from the msB always returns 0.
   A read returns last pulled data from RX fifo a write pushes a data into TX fifo.
*/
	unsigned data;         
/* control register (RW) 32-bit   */
	unsigned control;     
/* baud/prescaler register (RW) 32-bit */
	unsigned baud;    
/* action register (W) 32-bit */
	unsigned action;  
/* status register (R) 32-bit */
	unsigned status;  
/* "magic" register (R) 32-bit */
	unsigned magic;  
} yanu_uart_t;


#endif
