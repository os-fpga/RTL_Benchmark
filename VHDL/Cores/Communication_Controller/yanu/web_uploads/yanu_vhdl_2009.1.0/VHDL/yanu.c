/* -------------------------------------------------------------------
 *         
 * drivers\serial\imagos_yanu.c
 *
 * Serial port driver for Imagos NIOSII UART - YANU.
 *
 * Copyright (C) 1995       David S. Miller    <davem@caip.rutgers.edu>
 * Copyright (C) 1998       Kenneth Albanowski <kjahds@kjahds.com>
 * Copyright (C) 1998-2000  D. Jeff Dionne     <jeff@lineo.ca>
 * Copyright (C) 1999       Vladimir Gurevich  <vgurevic@cisco.com>
 * Copyright (C) 2006       Imagos S.a.s.      <cristiano.ghirardi@imagos.it>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 *
 *  Imagos NiosII UART a.k.a. yanu (Yet Another NiosII Uart)
 * 
 *  30/10/2006 Cristiano Ghirardi Imagos S.a.s.
 *  21/02/2009 Cristiano Ghirardi Imagos S.a.s.
 *
 ---------------------------------------------------------------------*/


#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/errno.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
//#include <linux/config.h>
#include <linux/major.h>
#include <linux/string.h>
#include <linux/fcntl.h>
#include <linux/mm.h>
#include <linux/console.h>
#include <linux/reboot.h>
#include <linux/keyboard.h>
#include <linux/init.h>
#include <linux/smp_lock.h>
#include <linux/serial.h>
#include <linux/delay.h>
#include <linux/sysctl.h>
#include <linux/ioport.h>
#include <linux/serial_reg.h>
#include <linux/serial_core.h>
#include <linux/serial.h>


#include <asm/io.h>
#include <asm/irq.h>
#include <asm/system.h>
#include <asm/segment.h>
#include <asm/bitops.h>
#include <asm/delay.h>
#include <asm/uaccess.h>

#include "yanu_hw.h"
#include "yanu.h"


#ifdef CONFIG_CONSOLE
/* @cris@ */
extern wait_queue_head_t keypress_wait;
#endif

/* main tty layer struct */
struct tty_driver *yanu_driver;

/* serial subtype definitions */
#define SERIAL_TYPE_NORMAL	1

/* @cris@ ??? number of characters left in xmit buffer before we ask for more */
#define WAKEUP_CHARS 256

/* @cris@ Debugging... DEBUG_INTR is bad to use when one of the zs
 * lines is your console ;(
 */
#undef SERIAL_DEBUG_INTR
#undef SERIAL_DEBUG_OPEN
#undef SERIAL_DEBUG_FLOW

#define RS_ISR_PASS_LIMIT 256

/* print a debug message */
#define yanu_debug(level, msg...)        \
{                                        \
	if (debug_level >= level)        \
		printk(KERN_DEBUG msg);  \
}


/******************************************************
 *   Dear friends I'm a kernel module indeed
 ******************************************************/
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Cristiano Ghirardi");

static int rx_fifo_dly =  0;
static int tx_fifo_thr =  0;
static int debug_level =  0;

module_param(rx_fifo_dly, int, 0);
MODULE_PARM_DESC(rx_fifo_dly, "The RX delay (in bits) i.e. the # of bits in the fifo buffer\n"
                              "after what we trigger an RX interrupt (see documentation)");

module_param(tx_fifo_thr, int, 0);
MODULE_PARM_DESC(rx_fifo_dly, "The RX threshold i.e. the # of chars in the fifo buffer\n"
                              "after what we trigger an RX interrupt (see documentation)");

module_param(debug_level, int, 0);
MODULE_PARM_DESC(debug_level, "The debug level, [0, 4, 8, 16], from min to max");


/***********************************************************
 *  The sysctl interface! Thanks to Alessandro Rubini and his 
 *  article: http://www.linuxjournal.com/article/2365
 ***********************************************************/

/* just an id as you like ;-) */
enum {YANU_TABLE_ID=6969,YANU_TABLE_DLY_ID,YANU_TABLE_THR_ID,YANU_TABLE_DBG_ID};

static int table_rx_dly;
static int table_tx_thr;
static int table_dbg_lev;

static int min_dly = 50; 
static int max_dly = 150; 
static int min_thr = 1; 
static int max_thr = 15; 
static int min_dbg = 0; 
static int max_dbg = 16; 


/* two integer items (files) */
static ctl_table yanu_table[] = {
        {
		.ctl_name = YANU_TABLE_DLY_ID, 
		.procname = "rx_fifo_dly", 
		.data = &table_rx_dly,
		.maxlen = sizeof(int), 
		.mode = 0644, 
		.child = NULL, 
		.proc_handler = &proc_dointvec_minmax,
		.extra1 = &min_dly,
		.extra2 = &max_dly,
	},
        {
		.ctl_name = YANU_TABLE_THR_ID, 
		.procname = "tx_fifo_thr", 
		.data = &table_tx_thr,
		.maxlen = sizeof(int),
		.mode = 0644, 
		.child = NULL, 
		.proc_handler = &proc_dointvec_minmax,
		.extra1 = &min_thr,
		.extra2 = &max_thr,
	},
        {
		.ctl_name = YANU_TABLE_DBG_ID, 
		.procname = "debug_level", 
		.data = &table_dbg_lev,
		.maxlen = sizeof(int), 
		.mode = 0644, 
		.child = NULL, 
		.proc_handler = &proc_dointvec_minmax,
		.extra1 = &min_dbg,
		.extra2 = &max_dbg,
	},
        {.ctl_name = 0}
};

/* a directory */
static ctl_table yanu_dev_table[] = {
	{
		.ctl_name = YANU_TABLE_ID, 
		.procname = "yanu", 
		.data = NULL, 
		.maxlen = 0, 
		.mode = 0555, 
		.child = yanu_table,
	},
	{.ctl_name = 0}
};

/* the parent directory */
static ctl_table yanu_root_table[] = {
	{
		.ctl_name = CTL_DEV, 
		.procname = "dev", 
		.data = NULL, 
		.maxlen = 0, 
		.mode = 0555, 
		.child = yanu_dev_table,
	},
	{.ctl_name = 0}
};

static struct ctl_table_header *yanu_table_header;



/******************************************************
 *                 prototypes 
 ******************************************************/

/******************************************************
 *                  tty operations 
 ******************************************************/
static int yanu_open(struct tty_struct *tty, struct file *filp);
static void yanu_close(struct tty_struct *tty, struct file *filp);
static int yanu_write(struct tty_struct *tty, const unsigned char *buf, int count);
static int yanu_write_room(struct tty_struct *tty);
static int yanu_chars_in_buffer(struct tty_struct *tty);
static void yanu_flush_buffer(struct tty_struct *tty);
static int yanu_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg);
static void yanu_throttle(struct tty_struct *tty);
static void yanu_unthrottle(struct tty_struct *tty);
static void yanu_set_termios(struct tty_struct *tty, struct ktermios *old_termios);
static void yanu_stop(struct tty_struct *tty);
static void yanu_start(struct tty_struct *tty);
void yanu_hangup(struct tty_struct *tty);
static void yanu_set_ldisc(struct tty_struct *tty);

/******************************************************
 *       local and private functions 
 ******************************************************/
static void do_softint(struct work_struct *work);

static void do_serial_hangup(struct work_struct *work);

/* main interrupt routine here the dirty job is done...*/
irqreturn_t yanu_interrupt(int irq, void *dev_id);

/* to tell the truth I don't know if it's really useful */
static inline int serial_paranoia_check(struct YANU_serial *info, char *name, const char *routine);

/* initial port setup (with pretty safe values I hope) */
static int initialize_port(struct YANU_serial * info);

/* port shutdown */
static void finalize_port(struct YANU_serial * info);

/* port setup */
static int setup_port(struct YANU_serial * info);

/* put a single char: used basically in console mode */
static int put_char(char ch, struct YANU_serial *info);

static int block_til_ready(struct tty_struct *tty, struct file * filp, struct YANU_serial *info);
static void show_serial_version(struct YANU_serial *info);
static void set_baud(struct YANU_serial *info);
static int set_baud_prescaler(int baudrate);
static int get_serial_info(struct YANU_serial *info, struct serial_struct * retinfo);
static int set_serial_info(struct YANU_serial *info, struct serial_struct * new_info);
static int get_lsr_info(struct YANU_serial *info, unsigned int *value);
static void send_break(	struct YANU_serial *info, int duration);
/* sleep until timeout csec */
static int sleep_until_timeout(struct YANU_serial *info, unsigned csec);






/*********************************************************************
 *             some internal bricks
 *********************************************************************/

/* sleeps for a specified amount of csecs (1/100 of sec) */
static int sleep_until_timeout(	struct YANU_serial *info, unsigned csec)
{ 
	unsigned timeout;

	DECLARE_WAITQUEUE(wait, current);

	
	add_wait_queue(&(info->sleep_wait), &wait);
	if (!csec)
		csec = YANU_MAX_SLEEP_CSEC;
	
	/* from usec to jiffies */
	timeout = (csec / 100) * HZ;	
	do {
		set_current_state(TASK_INTERRUPTIBLE);
		if (signal_pending(current))
			break;
		timeout = schedule_timeout(timeout);
	} while (timeout);

	
	set_current_state(TASK_RUNNING);
	remove_wait_queue(&(info->sleep_wait), &wait);
	return timeout;
}





/***********************************************************
 * This routine sends a break character out the serial port.
 **********************************************************/
static void send_break(	struct YANU_serial *info, int duration)
{
	yanu_uart_t *uart= (yanu_uart_t *)(info->port);

	/* pull down line, sleep and pull up what a nice guy I am ;-) */
	uart->control |= YANU_CONTROL_FORCEBRK;
	sleep_until_timeout(info, duration);
	uart->control &= ~YANU_CONTROL_FORCEBRK;
}




/*********************************************************************
 *  various operation we define see include/linux/tty_driver.h
 *********************************************************************/
static struct tty_operations yanu_ops = {
	.open = yanu_open,
	.close = yanu_close,
	.write = yanu_write,
	.write_room = yanu_write_room,
	.ioctl = yanu_ioctl,
	.chars_in_buffer = yanu_chars_in_buffer,
	.flush_buffer = yanu_flush_buffer,

	.throttle = yanu_throttle,
	.unthrottle = yanu_unthrottle,
	.set_termios = yanu_set_termios,
	.stop = yanu_stop,
	.start = yanu_start,
	.hangup = yanu_hangup,
	.set_ldisc = yanu_set_ldisc,
};

/*********************************************************************
 *	Configuration table, UARTs to look for at startup.
 *      We initialize port and irq fields
 *      First port is a console...
 *      Our info structure is defined in 
 *********************************************************************/

static struct YANU_serial yanu_info[] = {
	{ 0,0,1,0,0,0,0, (int) (na_uart0),0, (na_uart0_irq) },		/* ttyY0 */


#ifdef na_uart1
	{ 0,0,0,0,0,0,0, (int) (na_uart1),0, (na_uart1_irq) },		/* ttyY1 */
#endif
#ifdef na_uart2
	{ 0,0,0,0,0,0,0, (int) (na_uart2),0, (na_uart2_irq) },		/* ttyY2 */
#endif
#ifdef na_uart3
	{ 0,0,0,0,0,0,0, (int) (na_uart3),0, (na_uart3_irq) },		/* ttyY3 */
#endif
#ifdef na_uart4
	{ 0,0,0,0,0,0,0, (int) (na_uart4),0, (na_uart4_irq) },		/* ttyY4 */
#endif
#ifdef na_uart5
	{ 0,0,0,0,0,0,0, (int) (na_uart5),0, (na_uart5_irq) },		/* ttyY5 */
#endif
#ifdef na_uart6
	{ 0,0,0,0,0,0,0, (int) (na_uart6),0, (na_uart6_irq) },		/* ttyY6 */
#endif
#ifdef na_uart7
	{ 0,0,0,0,0,0,0, (int) (na_uart7),0, (na_uart7_irq) },		/* ttyY7 */
#endif
};
#define	NR_PORTS	(sizeof(yanu_info) / sizeof(struct YANU_serial))

/************************************************************************
 * This function remaps the device address in IO address
 ************************************************************************/
static void yanu_remap(void)
{ 
    int i;
    for(i=0; i<NR_PORTS;i++)
    {
	if(!request_mem_region(yanu_info[i].port_unmap,0x20,"Yanu_serial"))
	    printk("WARNING: can't get memory region for Yanu serial Y%d",i);
	    }	
    for(i=0; i<NR_PORTS;i++)
	yanu_info[i].port = (int) ioremap(yanu_info[i].port_unmap,0x20);
}
/************************************************************************
 * This is used to figure out the divisor speeds and the timeouts
 ************************************************************************/
static int baud_table[] = {
	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
	9600, 19200, 38400, 57600, 115200, 230400, 460800, 500000, 576000, 
        921600, 1000000, 1152000, 1500000, 2000000, 2500000, 3000000, 3500000, 
        4000000, 0
};


/****************************************************************
 *       yanu_init inits the driver
 ****************************************************************/
static int __init yanu_init(void)
{
	int i,flags,is_yanu,rc;
	struct YANU_serial *info = NULL;
	yanu_uart_t *uart;
	char ch;
 
	yanu_remap();

	yanu_debug(8, "yanu: <yanu_init>\n");
	yanu_debug(8, "yanu: ports number: %ld\n", NR_PORTS);
	yanu_debug(16, "yanu: driver initialization\n");
	yanu_debug(16, "yanu: rx_fifo_dly: %d\n", rx_fifo_dly);
	yanu_debug(16, "yanu: tx_fifo_thr: %d\n", tx_fifo_thr);
	yanu_debug(16, "yanu: debug level: %d\n", debug_level);

	/* allocate memory and set "magic" and "num" fields */

	yanu_driver = alloc_tty_driver(NR_PORTS);
	if (!yanu_driver) {
		printk(KERN_ERR "yanu: damn! I couldn't allocate memory for YANU driver\n");
		return -ENOMEM;
	}

	yanu_debug(16, "yanu: successfully called <alloc_tty_driver>\n");

	show_serial_version(yanu_info);

	/* Initialize the tty_driver structure */
	yanu_driver->owner = THIS_MODULE;
	yanu_driver->driver_name = "yanu_tty";
	yanu_driver->name = "ttyY";
	/* actually YANU_MAJOR == TTY_MAJOR (see yanu.h) */
	yanu_driver->major = YANU_MAJOR;
	yanu_driver->minor_start = YANU_MINOR_START;
	yanu_driver->type = TTY_DRIVER_TYPE_SERIAL;
	yanu_driver->subtype = SERIAL_TYPE_NORMAL;
	/* tty_std_termios defined in tty_io.c and declared tty.h */
	yanu_driver->init_termios = tty_std_termios;
	/* custom initialization */
	yanu_driver->init_termios.c_cflag = B115200 | CS8 | CREAD | HUPCL | CLOCAL;
	/* just to be clean remember that line discipline is 0 i.e. N_TTY */
	yanu_driver->flags = TTY_DRIVER_REAL_RAW; //@cris@ | TTY_DRIVER_NO_DEVFS;
	/* register operations */
	tty_set_operations(yanu_driver, &yanu_ops);

	yanu_debug(16, "yanu: operations set on driver\n");

	/* register driver with the tty layer, allocate the major and minor num. */
	if ((rc=tty_register_driver(yanu_driver))) {
		/* free associated memory  */
		put_tty_driver(yanu_driver);
		printk(KERN_ERR "yanu: damn! I can't register YANU serial driver\n");
		return rc;
	}

	yanu_debug(16, "yanu: successfully called <tty_register_driver>\n");

	/* block interrupts */
	local_irq_save(flags);

	/*	Configure all the attached serial ports. */
	for (i = 0, info = yanu_info; (i < NR_PORTS); i++, info++) {
		uart = (yanu_uart_t *)info->port;
		is_yanu = 0;
		while (1) {
			ch = (char)(uart->magic & 0xFF);
			if ((ch != 'y') && (ch != 'Y'))
				break;
			ch = (char)((uart->magic >> 8) & 0xFF);
			if ((ch != 'a') && (ch != 'A'))
				break;
			ch = (char)((uart->magic >> 16) & 0xFF);
			if ((ch != 'n') && (ch != 'N'))
				break;
			ch = (char)((uart->magic >> 24) & 0xFF);
			if ((ch != 'u') && (ch != 'U'))
				break;
			is_yanu = 1;
			break;
		}
		if (!is_yanu)
			break;

		/* register the device 
		tty_register_device(yanu_driver, i, NULL);
		@cris@
		*/
		spin_lock_init(&info->lock);

		info->magic = SERIAL_MAGIC;
		info->tty = NULL;
		info->xmit_buf = NULL;
		info->flags = 0;

		if (rx_fifo_dly > 0)
			info->rx_fifo_dly = rx_fifo_dly;
		else
			info->rx_fifo_dly = YANU_RXFIFO_DLY;
			
		if ((tx_fifo_thr > 0) && (tx_fifo_thr < YANU_FIFO_SIZE))
			info->tx_fifo_thr = tx_fifo_thr;
		else
			info->tx_fifo_thr = YANU_TXFIFO_THR;

		/******************************************************
		 * maximum theoretical baud rate is system clock / 16 *
		 * for instance for 90MHz is 5.6 Mb/sec ~
		 ******************************************************/
		info->baud_base = nasys_clock_freq;
		info->custom_divisor = 16;
		/* standards... */
		info->close_delay = 50;
		info->closing_wait = 3000;
		/* useful? @cris@ */
		info->x_char = 0;
		info->event = 0;
		info->open_count = 0;
		info->blocked_open = 0;

		/* initialize work queues for the default work queue "events/<cpu>" */
		INIT_WORK(&(info->tqueue), do_softint);
		INIT_WORK(&(info->tqueue_hangup), do_serial_hangup);
		/* initialize wait queues  */
		/* wait for to be able to open */
		init_waitqueue_head(&info->open_wait);
		init_waitqueue_head(&info->sleep_wait);
		info->line = i;


	

		printk(KERN_INFO "yanu: %s%d (irq = %d) is an Imagos YANU UART\n", 
		       yanu_driver->name, info->line, info->irq);

		if (request_irq(info->irq, yanu_interrupt, IRQF_DISABLED, YANU_IDENTITY, info)) 
			panic("Unable to attach NIOS serial interrupt\n");

		/*****************************************
		 * Clear the FIFO buffers and disable them
		 * (they will be reenabled in set_baud())
		 * we clean also the status register
		 ******************************************/
		uart->action =  YANU_ACTION_RRRDY | 
			YANU_ACTION_RTRDY | 
			YANU_ACTION_ROE   | 
			YANU_ACTION_RBRK  | 
			YANU_ACTION_RFE   | 
			YANU_ACTION_RPE   | 
			YANU_ACTION_RFE   | 
			YANU_ACTION_RFIFO_CLEAR | 
			YANU_ACTION_TFIFO_CLEAR;

		/*  safe values, I hope... */
		/* no parity */
		/* one stop bit */
		/* hardware handshake disabled */
		/* NO force break off */
		/* 8 bits */
		uart->control = (0x7 << YANU_CONTROL_BITS_POS);
		/* enven parity just to be clean */
		uart->control |= YANU_CONTROL_PAREVEN;
		/* we set threshold for fifo */
		uart->control |= YANU_CONTROL_RDYDLY * info->rx_fifo_dly;
		uart->control |= YANU_CONTROL_TXTHR *  info->tx_fifo_thr;
		
		/* RTS / CTS inversion in Altera: it isn't necessary now */
                /* uart->control |= (YANU_CONTROL_RTS_INV | YANU_CONTROL_CTS_INV); */
                
		set_baud(info);
	}
  
	/* restore interrupts */
	local_irq_restore(flags);
	yanu_debug(16, "yanu: restored interrupts\n");

	if (!is_yanu) {
		printk(KERN_ERR "yanu: detect failed!\n");
		/*
		for (int j=0; j<i; j++)
			tty_unregister_device(yanu_driver, j);
		@cris@*/
		tty_unregister_driver(yanu_driver);
		return -1;
	}
	
	/* sysctl interface */
	/* if (!(yanu_table_header = register_sysctl_table(yanu_root_table,0))) */	
	if (!(yanu_table_header = register_sysctl_table(yanu_root_table)))
		return -ENOMEM;
	
	table_rx_dly = yanu_info->rx_fifo_dly;
	table_tx_thr = yanu_info->tx_fifo_thr;
	table_dbg_lev = debug_level;

	return 0;
}

/****************************************************************
 *      finalize the driver 
 *****************************************************************/
static void __exit yanu_exit(void)
{
	int flags;
	struct YANU_serial *info;
	int i;
	
	yanu_debug(8, "yanu: <yanu_exit>\n");

	printk(KERN_INFO "yanu: driver finalization\n");

	/* block interrupts */
	local_irq_save(flags);

	for (i = 0, info = yanu_info; (i < NR_PORTS); i++, info++) {
		free_irq(info->irq, info);
		// @cris@ tty_unregister_device(yanu_driver, i);
	}

	/* restore interrupts */
	local_irq_restore(flags);

	if (yanu_table_header)
		unregister_sysctl_table(yanu_table_header);

	tty_unregister_driver(yanu_driver);
	
	for(i=0;i<NR_PORTS;i++)
	{  
	    iounmap((void *)yanu_info[i].port);
	    release_mem_region(yanu_info[i].port_unmap,0x020);
	    }
}


/***********************************************************************
 * This routine is called whenever a serial port is opened.  It
 * enables interrupts for a serial port, linking in its S structure into
 * the IRQ chain.   It also performs the serial-specific
 * initialization for the tty structure.
 ***********************************************************************/
static int yanu_open(struct tty_struct *tty, struct file *filp)
{
	struct YANU_serial	*info;
	int retval, line = tty->index;

	yanu_debug(8, "yanu %d: <yanu_open>\n", line);
	yanu_debug(16, "yanu %d: opening port: %d\n", line, line);

	/* too many ?! */
	if (line > yanu_driver->num) {
		printk(KERN_ERR "yanu %d: opening port: %d > lines num: %d!\n",line, line, yanu_driver->num);
		return -ENODEV;
	}

	info = &yanu_info[line];

#ifdef SERIAL_PARANOIA_CHECK
	/* make a paranoid check only if SERIAL_PARANOIA_CHECK is defined */ 
	if (serial_paranoia_check(info, tty->name, "yanu_open"))
		return -ENODEV;
#endif 

	/* block until ready to open the port  
	 * in case the port in presently closing */
	if ((retval=block_til_ready(tty, filp, info)))
		return retval;
	
	/* some needed initializations */
	info->rxi_count = 0;
	info->txi_count = 0;
	info->rxc_count = 0;
	info->txc_count = 0;
	/* we link together info and tty */
	tty->driver_data = info;
	info->tty = tty;
	info->tty->low_latency = 1;

	/* initial (default) setup of the serial port if is the first open */
	if (0 == info->open_count++)
		retval = initialize_port(info);
	else
		retval = 0;

	return retval;
}


/****************************************************************************
 * yanu_close()
 *
 * This routine is called when the serial port gets closed.  First, we
 * wait for the last remaining data to be sent.  Then, we unlink its
 * S structure from the interrupt chain if necessary, and we free
 * that IRQ if nothing is left in the chain.
 *****************************************************************************/
static void yanu_close(struct tty_struct *tty, struct file *filp)
{
	struct YANU_serial * info = (struct YANU_serial *)tty->driver_data;
	unsigned long flags;


#ifdef SERIAL_PARANOIA_CHECK
	if (!info || serial_paranoia_check(info, tty->name, "yanu_close"))
		return;
#endif

	yanu_debug(8 ,"yanu %d: <yanu_close>\n", info->tty->index);
	yanu_debug(16, "yanu %d: closing port %d\n", info->tty->index, tty->index);

	/* 
	 * some useful statistics: just to show how cool is our UART!
	 */
	yanu_debug(1, "yanu %d: tx interrupt count: %d\n", info->tty->index, info->txi_count);
	yanu_debug(1, "yanu %d: tx chars count: %d\n", info->tty->index, info->txc_count);
	yanu_debug(1, "yanu %d: rx interrupt count: %d\n", info->tty->index, info->rxi_count);
	yanu_debug(1, "yanu %d: rx chars count: %d\n", info->tty->index, info->rxc_count);

	local_irq_save(flags);

	/* there are hangup operation on file ?  */
	if (tty_hung_up_p(filp)) {
		local_irq_restore(flags);
		return;
	}

	if ((tty->count == 1) && (info->open_count != 1)) {
		/*
		 * Uh, oh.  tty->count is 1, which means that the tty
		 * structure will be freed.  info->open_count should always
		 * be one in these conditions.  If it's greater than
		 * one, we've got real problems, since it means the
		 * serial port won't be shutdown.
		 */
		printk(KERN_ERR "yanu %d: yanu_close: bad serial port open_count for ttyY%d; tty->count is 1, "
		       "info->open_count is %d\n", info->tty->index, info->line, info->open_count);
		info->open_count = 1;
	}
	if (--info->open_count < 0) {
		printk(KERN_ERR "yanu %d: yanu_close: bad serial port open_count for ttyY%d: %d\n",
		       info->tty->index, info->line, info->open_count);
		info->open_count = 0;
	}
	/* if there are still entities opening the tty we just return */
	if (info->open_count) {
		local_irq_restore(flags);
		return;
	}
	/* we are closing */
	info->flags |= S_CLOSING;
	/*
	 * Now we wait for the transmit buffer to clear; and we notify
	 * the line discipline to only process XON/XOFF characters.
	 */
	tty->closing = 1;
	if (info->closing_wait != S_CLOSING_WAIT_NONE)
		tty_wait_until_sent(tty, msecs_to_jiffies(info->closing_wait));
	/*
	 * At this point we stop accepting input.  To do this, we
	 * disable the receive line status interrupts, and tell the
	 * interrupt driver to stop checking the data ready bit in the
	 * line status register.
	 */
	
	finalize_port(info);
	
	yanu_flush_buffer(tty);

	tty_ldisc_flush(tty);

	tty->closing = 0;
	info->event = 0;
	info->tty = NULL;

	if ((info->blocked_open) && (info->close_delay) )
		msleep_interruptible(info->close_delay);

	info->flags &= ~(S_NORMAL_ACTIVE | S_CLOSING);
	wake_up_interruptible(&info->open_wait);

	local_irq_restore(flags);
}


/****************************************************************************
 * yanu_ioctl()
 *
 * Head routine to manage I/O controls on the serial line: 
 * see man tty_ioctl
 * 
 * 
 *****************************************************************************/
static int yanu_ioctl(struct tty_struct *tty, struct file * file, unsigned int cmd, unsigned long arg)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;
	int error, retval;

	yanu_debug(8 ,"yanu %d: <yanu_ioctl>\n", info->tty->index);

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_ioctl"))
		return -ENODEV;
#endif

	/* @cris@ ??? */
	if ((cmd != TIOCGSERIAL)   && 
	    (cmd != TIOCSSERIAL)   &&
	    (cmd != TIOCSERCONFIG) && 
	    (cmd != TIOCSERGWILD)  &&
	    (cmd != TIOCSERSWILD)  && 
	    (cmd != TIOCSERGSTRUCT)) {
		if (tty->flags & (1 << TTY_IO_ERROR))
			return -EIO;
	}
	
	yanu_debug(16 ,"yanu %d: ioctl issued is: 0x%X\n", info->tty->index, cmd);

	switch (cmd) {
		
		/* SVID version: non-zero arg --> no break */
	case TCSBRK:	
		/* can we change the settings of the terminal ? */
		if ((retval = tty_check_change(tty)))
			return retval;
		/* wait until the buffer is empty... */
		tty_wait_until_sent(tty, 0);
		if (!arg)
			send_break(info, 25);	/* 1/4 second */
		return 0;
		
		/* support for POSIX tcsendbreak() */
	case TCSBRKP:	
		if ((retval = tty_check_change(tty)))
			return retval;
		tty_wait_until_sent(tty, 0);
		send_break(info, arg ? arg*10 : 25);
		return 0;

	/* Get actual serial configuration */
	case TIOCGSERIAL:
		if ((error=verify_area(VERIFY_WRITE, (void *) arg,sizeof(struct serial_struct))))
			return error;
		return get_serial_info(info, (struct serial_struct *) arg);

		/* Set serial configuration */
	case TIOCSSERIAL:
		return set_serial_info(info,(struct serial_struct *) arg);

		/* Get line status register */
	case TIOCSERGETLSR: 
		error = verify_area(VERIFY_WRITE, (void *) arg,
				    sizeof(unsigned int));
		if (error)
			return error;
		else
			return get_lsr_info(info, (unsigned int *) arg);

	case TIOCSERGSTRUCT:
		error = verify_area(VERIFY_WRITE, (void *) arg,
				    sizeof(struct YANU_serial));
		if (error)
			return error;
		copy_to_user((struct YANU_serial *) arg,
			     info, sizeof(struct YANU_serial));
		return 0;

	default:
		return -ENOIOCTLCMD;
	}

	return 0;
}


/***********************************************************************
 * This function is called whenever the user write on the serial port.
 * First we put the bytes in the user buffer and 
 * 
 ***********************************************************************/
static int yanu_write(struct tty_struct *tty, const unsigned char *buf, int count)
{
	int c, total = 0;
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;
	yanu_uart_t *uart= (yanu_uart_t *)(info->port);
	unsigned flags;

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_write"))
		return 0;
#endif

	yanu_debug(8, "yanu %d: <yanu_write>\n", info->tty->index);

	/* no buffer or no tty: something real wrong happened */ 
	if (!tty || !info->xmit_buf)
	{
		printk(KERN_ERR "yanu %d: <yanu_write>, NULL tty or xmit_buf\n", info->tty->index);
		return 0;
	}
	
	local_save_flags(flags);

	while (1) {
		local_irq_disable();

		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1, 
					  SERIAL_XMIT_SIZE - info->xmit_head));

		yanu_debug(16, "yanu %d: chars put in user buffer: %d\n", info->tty->index, c);

		/* buffer full or nothing to transmit */
		if (c <= 0)
			break;

		yanu_debug(16, "yanu %d: first char in user buffer: %d\n", info->tty->index, *buf);

		/* buffer grows on top */
		memcpy(info->xmit_buf + info->xmit_head, buf, c);
		/* new head */
		info->xmit_head = (info->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
		info->xmit_cnt += c;

		local_irq_restore(flags);

		buf += c;
		count -= c;
		total += c;
	}

	/* something to transmit */
	if (info->xmit_cnt && !tty->stopped && !tty->hw_stopped) {
		local_irq_disable();

		/* enable interrupt on transmit ready: enable transmitter */
		uart->control |= YANU_CONTROL_IE_TRDY;

		local_irq_restore(flags);
	}

	local_irq_restore(flags);

	return total;
}








static inline int serial_paranoia_check(struct YANU_serial *info, char *name, const char *routine)
{
#ifdef SERIAL_PARANOIA_CHECK
	static const char *badmagic =
		"Warning: bad magic number for serial struct %s in %s\n";
	static const char *badinfo =
		"Warning: null nios_serial for %s in %s\n";

	if (!info) {
		printk(badinfo, name, routine);
		return 1;
	}
	if (info->magic != SERIAL_MAGIC) {
		printk(badmagic, name, routine);
		return 1;
	}
#endif
	return 0;
}



/*
 * ------------------------------------------------------------
 * yanu_stop() and yanu_start()
 *
 * This routines are called before setting or resetting tty->stopped.
 * They enable or disable transmitter interrupts, as necessary.
 * ------------------------------------------------------------
 */
static void yanu_stop(struct tty_struct *tty)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;
	yanu_uart_t *uart= (yanu_uart_t *)(info->port);
	unsigned long flags;

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_stop"))
		return;
#endif

	local_irq_save(flags);

	uart->control &= ~YANU_CONTROL_IE_TRDY;

	local_irq_restore(flags);
}

/****************************************
 * put a character 
 *****************************************/
static int put_char(char ch, struct YANU_serial *info)
{
	yanu_uart_t *uart= (yanu_uart_t *)(info->port);
	int flags, tx_chars = 0;

	local_irq_save(flags);

	while (1)
	{
		tx_chars = (uart->status>>YANU_TFIFO_CHARS_POS) & ((1<<YANU_TFIFO_CHARS_N)-1);
		if (tx_chars < YANU_TXFIFO_SIZE-1)
			break;
	}

	uart->data = (unsigned char)ch;

	local_irq_restore(flags);
	return 1;
}

static void yanu_start(struct tty_struct *tty)
{

/*

     @cris@
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;
	unsigned long flags;


	np_uart *	uart= (np_uart *)(info->port);

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_start"))
		return;
#endif

	local_irq_save(flags);

	if (info->xmit_cnt && info->xmit_buf && !(uart->np_uartcontrol & np_uartcontrol_itrdy_mask)) {
#ifdef USE_INTS
		uart->np_uartcontrol &= np_uartcontrol_itrdy_mask;
#endif
	}
	local_irq_restore(flags);
*/
}

/* Drop into either the boot monitor or gdb upon receiving a break
 * from keyboard/console input.
*/

/* #ifdef CONFIG_MAGIC_SYSRQ
static void batten_down_hatches(void)
{
   //	 Drop into the debugger 
  //	nios_gdb_breakpoint();
}
#endif // CONFIG_MAGIC_SYSRQ */

static inline void status_handle(struct YANU_serial *info, unsigned short status)
{
	return;
}

/***********************************************************************
            receive chars
************************************************************************/
static inline void receive_chars(struct YANU_serial *info, unsigned status)
{
	struct tty_struct *tty = info->tty;
	yanu_uart_t *uart = (yanu_uart_t *)(info->port);
	int rx_chars;
	unsigned char ch;


	yanu_debug(8, "yanu %d: <receive_chars>\n", tty->index);

	uart->control |= YANU_CONTROL_OUT0;

	/*
	 * chars in the receive buffer ready to collect
	 */
	rx_chars = ((uart->status>>YANU_RFIFO_CHARS_POS) & ((1<<YANU_RFIFO_CHARS_N)-1));

	for (; rx_chars > 0 ; rx_chars--) {
		uart->control |= YANU_CONTROL_OUT1;

		yanu_debug(16, "yanu %d: rx_chars: %d\n", tty->index, rx_chars);
		
		/* Make sure that we do not overflow the buffer 
		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
			yanu_debug(8, "yanu %d: chance to overflow flip buffer!\n", tty->index);
			if (tty->low_latency) {
				spin_unlock(&info->lock);
				tty_flip_buffer_push(tty);
				spin_lock(&info->lock);
			}
		}
		*/

		/* first we pull the char */
		uart->action = YANU_ACTION_RFIFO_PULL;
		/* then we get it (the mask actually isn't necessary but...) */
		ch = uart->data & YANU_DATA_CHAR_MASK;
		info->rxc_count++;
		
		yanu_debug(16, "yanu %d: received char: %d\n", tty->index, ch);

		/* poor flip buffer we need to feed it ;-) */
		tty_insert_flip_char(tty, ch, 0);

		uart->control &= ~YANU_CONTROL_OUT1;
	}

	/* 
	 * please empty the buffer as quickly as you can... 
	 */
	spin_unlock(&info->lock);
	tty_flip_buffer_push(tty);
	spin_lock(&info->lock);
	
	uart->control &= ~YANU_CONTROL_OUT0;

	return;
}

/***********************************************************************
                  transmit chars
************************************************************************/
static inline void transmit_chars(struct YANU_serial *info)
{
	struct tty_struct *tty = info->tty;
	int tx_chars;
	unsigned char ch;
	yanu_uart_t *uart =  (yanu_uart_t *)(info->port);

	yanu_debug(8, "yanu %d: <transmit_chars>\n", tty->index);

	if (info->x_char) {
		/* Send next char */
		uart->data = info->x_char;
		info->x_char = 0;
		return;
	}

	yanu_debug(16, "yanu %d: xmit_cnt: %d\n", tty->index, info->xmit_cnt);

	if((info->xmit_cnt <= 0) || info->tty->stopped) {
		/* That's peculiar... TX ints off @cris@ ??? */
		uart->control &= ~YANU_CONTROL_IE_TRDY;
		return;
	}
	/* we fill-up the transmit buffer 
	 * the characters already in the TX FIFO are in the uart status
	 * so the free space is FIFO_SIZE - status 
	 */
	tx_chars = YANU_TXFIFO_SIZE - ((uart->status>>YANU_TFIFO_CHARS_POS) & ((1<<YANU_TFIFO_CHARS_N)-1));
	if (tx_chars > info->xmit_cnt)
		tx_chars = info->xmit_cnt;

	yanu_debug(16, "yanu %d: chars to transmit: %d\n", tty->index, tx_chars);

	/* Send as many chars as possible filling up the transmit buffer */
	for (; tx_chars > 0 ; tx_chars--) {
		ch = info->xmit_buf[info->xmit_tail++];
		uart->data = ch & YANU_DATA_CHAR_MASK;
		info->txc_count++;

		yanu_debug(16, "yanu %d: character transmitted: %d\n", tty->index, ch);

		info->xmit_tail = info->xmit_tail & (SERIAL_XMIT_SIZE-1);
		info->xmit_cnt--;
	}

	if (info->xmit_cnt < WAKEUP_CHARS)
		schedule_work(&info->tqueue);
	
	if(info->xmit_cnt <= 0) {
		/* All done for now... so disable TX interrupt */
		uart->control &= ~YANU_CONTROL_IE_TRDY;
		wake_up_interruptible(&tty->write_wait);
		return;
	}

	return;
}

/**************************************************************
 * This is the serial driver's generic interrupt routine
 **************************************************************/
irqreturn_t yanu_interrupt(int irq, void *dev_id)
{
	struct YANU_serial * info = (struct YANU_serial *)dev_id;
	yanu_uart_t *uart = (yanu_uart_t *)(info->port);

	yanu_debug(8, "yanu %d: <yanu_interrupt>\n", info->tty->index);
	yanu_debug(16, "yanu %d: interrupt status: 0x%04x\n", info->tty->index, uart->status & 0xFFFF);

	if ((uart->status & YANU_STATUS_RRDY) && (uart->control & YANU_CONTROL_IE_RRDY)) {
		spin_lock(&info->lock);
		receive_chars(info, uart->status);
		spin_unlock(&info->lock);
		info->rxi_count++;
		/* clean RECEIVE-READY flag */
		uart->action =  YANU_ACTION_RRRDY;
	}
	if ((uart->status & YANU_STATUS_TRDY) && (uart->control & YANU_CONTROL_IE_TRDY)) {
		transmit_chars(info);
		info->txi_count++;
		/* clean TRANSMIT-READY flag */
		uart->action =  YANU_ACTION_RTRDY;
	}
	if (uart->status & YANU_STATUS_OE) {
		/* overrun error */
		if (debug_level >= 1)
			printk(KERN_ERR "yanu %d: overrun error!\n", info->tty->index);
		uart->action =  YANU_ACTION_ROE;
	}
	if (uart->status & YANU_STATUS_BRK) {
		/* break detect */
		if (debug_level >= 1)
			printk(KERN_ERR "yanu %d: break detect!\n", info->tty->index);
		uart->action =  YANU_ACTION_RBRK;
	}
	if (uart->status & YANU_STATUS_FE) {
		/* framing error */
		if (debug_level >= 1)
			printk(KERN_ERR "yanu %d: framing error!\n", info->tty->index);
		uart->action =  YANU_ACTION_RFE;
	}
	if (uart->status & YANU_STATUS_PE) {
		/* parity error */
		if (debug_level >= 1)
			printk(KERN_ERR "yanu %d: parity error!\n", info->tty->index);
		uart->action =  YANU_ACTION_RPE;
	}

	return IRQ_HANDLED;
}

static void do_softint(struct work_struct *work)
{
  struct YANU_serial   *info = container_of(work, struct YANU_serial, tqueue);
	struct tty_struct    *tty;
	
	tty = info->tty;
	if (!tty)
		return;
}

/*
 * This routine is called from the scheduler tqueue when the interrupt
 * routine has signalled that a hangup has occurred.  The path of
 * hangup processing is:
 *
 * 	serial interrupt routine -> (scheduler tqueue) ->
 * 	do_serial_hangup() -> tty->hangup() -> yanu_hangup()
 *
 */
static void do_serial_hangup(struct work_struct *work)
{
  struct YANU_serial	*info = container_of(work, struct YANU_serial, tqueue_hangup);
	struct tty_struct	*tty;

	tty = info->tty;
	if (!tty)
		return;

	tty_hangup(tty);
}


/***************************************************
 * hardware port initialization 
 ***************************************************/
static int initialize_port(struct YANU_serial * info)
{
	unsigned long flags;
	yanu_uart_t *uart= (yanu_uart_t *)(info->port);

	yanu_debug(8, "yanu %d: <initialize_port>\n", info->tty->index);

	/* already initialized */
	if (info->flags & S_INITIALIZED)
		return 0;

	/* 
	 * Allocate a full memory page for the transmit buffer 
	 * Pay attention guys: the kernel transmit buffer size is
	 * SERIAL_XMIT_SIZE i.e. PAGE_SIZE as defined in linux/srial.h 
	 */
	if (!(info->xmit_buf = (unsigned char *) __get_free_page(GFP_KERNEL))) {
		return -ENOMEM;
	}

	local_irq_save(flags);

	/* just to report my transmit buffer's size */
	info->xmit_fifo_size = YANU_FIFO_SIZE;
	
	/************************************************************
	 * Clear all flags and the FIFO buffers. 
	 ************************************************************/
	uart->action =  YANU_ACTION_RRRDY | 
	    YANU_ACTION_RTRDY | 
	    YANU_ACTION_ROE   | 
	    YANU_ACTION_RBRK  | 
	    YANU_ACTION_RFE   | 
	    YANU_ACTION_RPE   | 
	    YANU_ACTION_RFE   | 
	    YANU_ACTION_RFIFO_CLEAR | 
	    YANU_ACTION_TFIFO_CLEAR;

	/* The control register has been initialize in yanu_init, now
	   we also enable receive interrupt (only) */
	uart->control |= YANU_CONTROL_IE_RRDY;

	if (table_rx_dly != info->rx_fifo_dly)
	{
		yanu_debug(4, "yanu %d: changing rx_fifo_dly from: %d to: %d \n", 
			   info->tty->index,info->rx_fifo_dly,table_rx_dly);
		info->rx_fifo_dly = table_rx_dly;
		uart->control |= YANU_CONTROL_RDYDLY * info->rx_fifo_dly;
	}

	if (table_tx_thr != info->tx_fifo_thr) {
		yanu_debug(4, "yanu %d: changing tx_fifo_thr from: %d to: %d \n", 
			   info->tty->index,info->tx_fifo_thr,table_tx_thr);
		info->tx_fifo_thr = table_tx_thr;
		uart->control |= YANU_CONTROL_TXTHR *  info->tx_fifo_thr;
	}
	
	if (table_dbg_lev != debug_level) {
		yanu_debug(4, "yanu %d: changing debug_level from: %d to: %d \n", 
			   info->tty->index,debug_level,table_dbg_lev);
		debug_level = table_dbg_lev;
	}

	yanu_debug(16, "yanu %d: control register: 0x%08x\n", info->tty->index, uart->control);

	/* set baudrate register based on the baud rate in info */
	set_baud(info);
     
	/* just to be safe we clean the TTY_IO_ERROR flag */
	if (info->tty)
		clear_bit(TTY_IO_ERROR, &info->tty->flags);
	/* reset the high level transmit buffer*/
	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;

	info->flags |= S_INITIALIZED;

	local_irq_restore(flags);

	yanu_debug(16, "yanu %d: interrupts restored\n", info->tty->index);

	return 0;
}

/*************************************************************************
 * This routine will shutdown a serial port; interrupts are disabled, and
 * DTR is dropped if the hangup on close termio flag is on.
 *************************************************************************/
static void finalize_port(struct YANU_serial * info)
{
	unsigned long	flags;
	yanu_uart_t *uart = (yanu_uart_t *)(info->port);

	yanu_debug(8, "yanu %d: <finalize_port>\n", info->tty->index);
	
	/* disable all interrups */
	uart->control &= ~YANU_CONTROL_IE_RRDY;
	uart->control &= ~YANU_CONTROL_IE_TRDY;
	uart->control &= ~YANU_CONTROL_IE_OE;
	uart->control &= ~YANU_CONTROL_IE_BRK;
	uart->control &= ~YANU_CONTROL_IE_FE;
	uart->control &= ~YANU_CONTROL_IE_PE;

	yanu_debug(16, "yanu %d: control register: 0x%08x\n", info->tty->index, uart->control);

	/* status register cleanup */
	uart->action =  YANU_ACTION_RRRDY | 
	    YANU_ACTION_RTRDY | 
	    YANU_ACTION_ROE   | 
	    YANU_ACTION_RBRK  | 
	    YANU_ACTION_RFE   | 
	    YANU_ACTION_RPE   |
	    YANU_ACTION_RFIFO_CLEAR;

	if (!(info->flags & S_INITIALIZED))
		return;

	local_irq_save(flags);  /* Disable interrupts */

	/* free user buffer */
	if (info->xmit_buf) {
		free_page((unsigned long)info->xmit_buf);
		info->xmit_buf = 0;
	}

	/* @cris@ ??? */
	if (info->tty)
		set_bit(TTY_IO_ERROR, &info->tty->flags);

	info->flags &= ~S_INITIALIZED;

	local_irq_restore(flags);
}



static int setup_port(struct YANU_serial * info)
{
	unsigned long flags;
	yanu_uart_t *uart= (yanu_uart_t *)(info->port);
	printk("setup_port\n");
	yanu_debug(8, "yanu %d: <setup_port>\n", info->tty->index);

	/* save flags and disable interrupts */
	local_irq_save(flags);


	/* only receive interrupt is enabled */
	uart->control = YANU_CONTROL_IE_RRDY;
	/* 8 bits */
	uart->control |= (0x7 << YANU_CONTROL_BITS_POS);
	/* no parity */
	uart->control &= ~YANU_CONTROL_PARENA;
	/* enven parity just to be clean */
	uart->control |= YANU_CONTROL_PAREVEN;
	/* one stop bit */
	uart->control &= ~YANU_CONTROL_STOPS;
	/* hardware handshake enabled */
        //uart->control |= YANU_CONTROL_HHENA;
	/* hardware handshake disabled */
	uart->control &= ~YANU_CONTROL_HHENA;
	/* force break off */
	uart->control &= ~YANU_CONTROL_FORCEBRK;
	/* we set threshold for fifo */
	uart->control |= YANU_CONTROL_RDYDLY * YANU_RXFIFO_DLY;
	uart->control |= YANU_CONTROL_TXTHR *  YANU_TXFIFO_THR;

	yanu_debug(16, "yanu %d: control register: 0x%08x\n", info->tty->index, uart->control);

	/* set baudrate register */
	set_baud(info);
     
	/* @cris@ ??? */
	if (info->tty)
		clear_bit(TTY_IO_ERROR, &info->tty->flags);
	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;

	info->flags |= S_INITIALIZED;

	/* restore the interrupts configuration */
	local_irq_restore(flags);

	return 0;
}



/*********************************************************************
 * This routine is called to set the YANU baud register to match
 * the specified baud rate for a serial port.
 *********************************************************************/
static void set_baud(struct YANU_serial *info)
{
	unsigned cflag;	
	unsigned idx;
	unsigned best_n,best_m;
	yanu_uart_t *uart = (yanu_uart_t *)(info->port);
	
	if (!info->tty || !info->tty->termios)
        	return;
	
	cflag = info->tty->termios->c_cflag;

	/* we find out the index idx in the table baud_table */
	if (cflag & CBAUDEX) {
		idx = ((cflag & CBAUD) & ~CBAUDEX) + B38400;
	}
	else
		idx = cflag & CBAUD;

	yanu_debug(8, "yanu %d: <set_baud>\n", info->tty->index);
	yanu_debug(16, "yanu %d: baud_rate to set: %d\n", info->tty->index, baud_table[idx]);
	
	/* compute best N and M couple in set_baud_prescaler*/	
	uart->baud = set_baud_prescaler(baud_table[idx]); ;
	info->baud = baud_table[idx];

	yanu_debug(16, "yanu %d: baud register: reg: 0x%4p value: 0x%04x (n: %d, m: %d)\n", 
		   info->tty->index, &uart->baud, uart->baud, best_n, best_m);
}

static int set_baud_prescaler(int baudrate)
{
    unsigned best_n, best_m, err;
    const unsigned max_uns = 0xFFFFFFFF;
    int baud_de;
    int n,k;
    
        best_n = YANU_MAX_PRESCALER_N;
	for (n = YANU_MAX_PRESCALER_N; n >= 0; n--) 
		if ((unsigned)nasys_clock_freq / (1 << (n+4)) >= baudrate) 
		{
			best_n = n;
			break;
		}
	for (k=0; ; k++)
		if (baudrate <= (max_uns >> (15+n-k)))
			break;
	
	best_m = (baudrate * (1 << (15+n-k))) / ((unsigned long)nasys_clock_freq >> k);
	
	if (debug_level >= 16)
	{
		for (k=0; ; k++)
			if (best_m <= (max_uns / ((unsigned)nasys_clock_freq >> k)))
				break;
		baud_de = (best_m * ((unsigned)nasys_clock_freq >> k)) / (1 << (15+best_n-k));
		err = abs(baud_de - baudrate);

		yanu_debug(16, "yanu %d: baud M & N computation, baud: %d, err: %d, best_m: %d, best_n: %d\n", 
			   baudrate, baud_de, err, best_m, best_n);
	}
	
	return best_m + best_n * YANU_BAUDE;
}
 
#if 0
/*
 * Fair output driver allows a process to speak.
 @cris@ */
static void yanu_fair_output(void)
{
	int left;		/* Output no more than that */
	unsigned long flags;
	struct YANU_serial *info = &yanu_info;
	char c;

	if (info == 0) return;
	if (info->xmit_buf == 0) return;

	local_irq_save(flags);
	left = info->xmit_cnt;
	while (left != 0) {
		c = info->xmit_buf[info->xmit_tail];
		info->xmit_tail = (info->xmit_tail+1) & (SERIAL_XMIT_SIZE-1);
		info->xmit_cnt--;
		local_irq_restore(flags);

		put_char(c, info);

		local_irq_save(flags);
		left = min(info->xmit_cnt, left-1);
	}

	/* Last character is being transmitted now (hopefully). */
	udelay(5);

	local_irq_restore(flags);
	return;
}
#endif

/*
 * console_print_NIOS is registered for printk.
 *
void console_print_NIOS(const char *p)
{
	char c;

	while((c=*(p++)) != 0) {
		if(c == '\n')
			put_char('\r', yanu_info);
		put_char(c, yanu_info);
	}

	return;
}
*/
 

static void yanu_set_ldisc(struct tty_struct *tty)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;

	yanu_debug(8, "yanu: <yanu_set_ldisc>\n");

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_set_ldisc"))
		return;
#endif

	info->is_cons = (tty->termios->c_line == N_TTY);

	printk("ttyY%d console mode %s\n", info->line, info->is_cons ? "on" : "off");
}

// @cris@ extern void console_printn(const char * b, int count);

/*
 * How many chars in the user transmit buffer?
 */
static int yanu_write_room(struct tty_struct *tty)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;
	int	ret;
	
	yanu_debug(8, "yanu %d: <yanu_write_room>\n", tty->index);
	
#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_write_room"))
		return 0;
#endif
	if ((ret = SERIAL_XMIT_SIZE - info->xmit_cnt - 1) < 0) 
	{
		yanu_debug(1, "yanu %d: (SERIAL_XMIT_SIZE - info->xmit_cnt - 1) < 0, strange!\n", tty->index);
		ret = 0;
	}
	
	return ret;
}


/*************************************************************************
    When we have to know about the chars in the buffer
 *************************************************************************/
static int yanu_chars_in_buffer(struct tty_struct *tty)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;

	yanu_debug(8, "yanu %d: <yanu_chars_in_buffer>\n", tty->index);

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_chars_in_buffer")) 
		return 0;
#endif

	return info->xmit_cnt;
}

static void yanu_flush_buffer(struct tty_struct *tty)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;

	yanu_debug(8, "yanu %d: <yanu_flush_buffer>\n", tty->index);

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_flush_buffer"))
		return;
#endif

	local_irq_disable();
	info->xmit_cnt = info->xmit_head = info->xmit_tail = 0;
	local_irq_enable();
	wake_up_interruptible(&tty->write_wait);
	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
	    tty->ldisc.ops->write_wakeup)
		(tty->ldisc.ops->write_wakeup)(tty);
}

/*
 * ------------------------------------------------------------
 * yanu_throttle()
 *
 * This routine is called by the upper-layer tty layer to signal that
 * incoming characters should be throttled.
 * ------------------------------------------------------------
 */
static void yanu_throttle(struct tty_struct * tty)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;

	yanu_debug(8, "yanu %d: <yanu_throttle>\n", tty->index);

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_throttle"))
		return;
#endif

	if (I_IXOFF(tty))
		info->x_char = STOP_CHAR(tty);

	/* Turn off RTS line (do this atomic) */
}

static void yanu_unthrottle(struct tty_struct * tty)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_unthrottle"))
		return;
#endif

	if (I_IXOFF(tty)) {
		if (info->x_char)
			info->x_char = 0;
		else
			info->x_char = START_CHAR(tty);
	}

	/* Assert RTS line (do this atomic) */
}

/*
 * ------------------------------------------------------------
 * yanu_ioctl() and friends
 * ------------------------------------------------------------
 */

static int get_serial_info(struct YANU_serial * info, struct serial_struct * retinfo)
{
	struct serial_struct tmp;

	if (!retinfo)
		return -EFAULT;
	memset(&tmp, 0, sizeof(tmp));
	tmp.type = info->type;
	tmp.line = info->line;
	tmp.port = info->port;
	tmp.irq = info->irq;
	tmp.flags = info->flags;
	tmp.baud_base = info->baud_base;
	tmp.close_delay = info->close_delay;
	tmp.closing_wait = info->closing_wait;
	tmp.custom_divisor = info->custom_divisor;
	copy_to_user(retinfo,&tmp,sizeof(*retinfo));
	return 0;
}

static int set_serial_info(struct YANU_serial * info, struct serial_struct * new_info)
{
	struct serial_struct new_serial;
	struct YANU_serial old_info;
	int  retval = 0;

	if (!new_info)
		return -EFAULT;

	copy_from_user(&new_serial, new_info, sizeof(new_serial));
	old_info = *info;

	if (!capable(CAP_SYS_ADMIN)) {
		if ((new_serial.baud_base != info->baud_base) ||
		    (new_serial.type != info->type) ||
		    (new_serial.close_delay != info->close_delay) ||
		    ((new_serial.flags & ~S_USR_MASK) !=
		     (info->flags & ~S_USR_MASK)))
			return -EPERM;
		info->flags = ((info->flags & ~S_USR_MASK) |
			       (new_serial.flags & S_USR_MASK));
		info->custom_divisor = new_serial.custom_divisor;
		goto check_and_exit;
	}

	if (info->open_count > 1)
		return -EBUSY;

	/*
	 * OK, past this point, all the error checking has been done.
	 * At this point, we start making changes.....
	 */

	info->baud_base = new_serial.baud_base;
	info->flags = ((info->flags & ~S_FLAGS) |
			(new_serial.flags & S_FLAGS));
	info->type = new_serial.type;
	info->close_delay = new_serial.close_delay;
	info->closing_wait = new_serial.closing_wait;

check_and_exit:
	retval = setup_port(info);
	return retval;
}

/*
 * get_lsr_info - get line status register info
 *
 * Purpose: Let user call ioctl() to get info when the UART physically
 * 	    is emptied.  On bus types like RS485, the transmitter must
 * 	    release the bus after transmitting. This must be done when
 * 	    the transmit shift register is empty, not be done when the
 * 	    transmit holding register is empty.  This functionality
 * 	    allows an RS485 driver to be written in user space.
 */
static int get_lsr_info(struct YANU_serial * info, unsigned int *value)
{
	unsigned char status;

	status = 0;
	put_user(status, value);
	return 0;
}



/*****************************************************************************
 *   this function is called whenever we change the port
 *   properties (for instance with stty)
 *****************************************************************************/
static void yanu_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
{
	struct YANU_serial *info = (struct YANU_serial *)tty->driver_data;
	yanu_uart_t *uart = (yanu_uart_t *)info->port; 
	int oldbaud = info->baud;

	yanu_debug(8, "yanu %d: <set_termios>\n", info->tty->index);

	
	/* change baud rate if we must */
	if ((old_termios->c_cflag & CBAUD) != (tty->termios->c_cflag & CBAUD)) {
		set_baud(info);
		if (info->baud == oldbaud) /* can not change */ {
			tty->termios->c_cflag = old_termios->c_cflag;
			printk(KERN_WARNING "yanu: unable to change baud rate! Why?\n");
			return;
		}
	}
	
	/* change flowcontrol if we must */
	if ((old_termios->c_cflag & CRTSCTS) != (tty->termios->c_cflag & CRTSCTS)) {
		if (tty->termios->c_cflag & CRTSCTS) {
			/* hardware handshake enabled */
			uart->control |= YANU_CONTROL_HHENA;
			yanu_debug(4, "yanu %d: HW flow control enabled\n", info->tty->index);
		}
		else {
			/* hardware handshake disabled */
			uart->control &= ~YANU_CONTROL_HHENA;
			yanu_debug(4, "yanu %d: HW flow control disabled\n", info->tty->index);
		}
	}
	
	/* change parity if we must */
	if ((old_termios->c_cflag & PARENB) != (tty->termios->c_cflag & PARENB)) {
		if (tty->termios->c_cflag & PARENB) {
			/* parity enabled */
			uart->control |= YANU_CONTROL_PARENA;
			yanu_debug(4, "yanu %d: parity enabled\n", info->tty->index);
		}
		else {
			/* parity disabled */
			uart->control &= ~YANU_CONTROL_PARENA;
			yanu_debug(4, "yanu %d: parity disabled\n", info->tty->index);
		}
	}

	/* change parity if we must */
	if ((old_termios->c_cflag & PARODD) != (tty->termios->c_cflag & PARODD)) {
		if (tty->termios->c_cflag & PARODD) {
			/* odd parity */
			uart->control &= ~YANU_CONTROL_PAREVEN;
			yanu_debug(4, "yanu %d: odd parity\n", info->tty->index);
		}
		else {
			/* even parity */
			uart->control |= YANU_CONTROL_PAREVEN;
			yanu_debug(4, "yanu %d: even parity\n", info->tty->index);
		}
	}

	/* change stop bits if we must */
	if ((old_termios->c_cflag & CSTOPB) != (tty->termios->c_cflag & CSTOPB)) {
		if (tty->termios->c_cflag & CSTOPB) {
			/* stow stop bits */
			uart->control |= YANU_CONTROL_STOPS;
			yanu_debug(4, "yanu %d: two stop bits\n", info->tty->index);
		}
		else {
			/* one stop bits */
			uart->control &= ~YANU_CONTROL_STOPS;
			yanu_debug(4, "yanu %d: one stop bits\n", info->tty->index);
		}
	}

	/* change data bits if we must */
	if ((old_termios->c_cflag & CSIZE) != (tty->termios->c_cflag & CSIZE)) {
		if (tty->termios->c_cflag & CS5) {
			/* 5 data bits */
			uart->control |= (0x4 << YANU_CONTROL_BITS_POS);
			yanu_debug(4, "yanu %d: 5 data bits\n", info->tty->index);
		}
		else if (tty->termios->c_cflag & CS6) {
			/* 6 data bits */
			uart->control |= (0x5 << YANU_CONTROL_BITS_POS);
			yanu_debug(4, "yanu %d: 6 data bits\n", info->tty->index);
		}
		else if (tty->termios->c_cflag & CS7) {
			/* 7 data bits */
			uart->control |= (0x6 << YANU_CONTROL_BITS_POS);
			yanu_debug(4, "yanu %d: 7 data bits\n", info->tty->index);
		}
		else if (tty->termios->c_cflag & CS8) {
			/* 8 data bits */
			uart->control |= (0x7 << YANU_CONTROL_BITS_POS);
			yanu_debug(4, "yanu %d: 8 data bits\n", info->tty->index);
		}
	}
}


/*
 * yanu_hangup() --- called by tty_hangup() when a hangup is signaled.
 */
void yanu_hangup(struct tty_struct *tty)
{
	struct YANU_serial * info = (struct YANU_serial *)tty->driver_data;

	yanu_debug(8, "yanu %d: <yanu_hangup>\n", info->tty->index);

#ifdef SERIAL_PARANOIA_CHECK
	if (serial_paranoia_check(info, tty->name, "yanu_hangup"))
		return;
#endif

	yanu_flush_buffer(tty);
	finalize_port(info);
	info->event = 0;
	info->open_count = 0;
	info->flags &= ~S_NORMAL_ACTIVE;
	info->tty = 0;
	wake_up_interruptible(&info->open_wait);
}

/******************************************************************
 * wait until the tty is ready
 ******************************************************************/
static int block_til_ready(struct tty_struct *tty, struct file * filp, struct YANU_serial *info)
{
	DECLARE_WAITQUEUE(wait, current);
	int retval = 0;

	yanu_debug(8, "yanu %d: <block_til_ready>\n", info->tty->index);

	info->blocked_open++;

	/*
	 * If non-blocking mode is set, or the port is not enabled,
	 * then make the check up front and then exit.
	 */
	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
		info->flags |= S_NORMAL_ACTIVE;
		retval = 0;
	}

	if (!info->tty || tty_hung_up_p(filp) || !(info->flags & S_INITIALIZED)) {
#ifdef SERIAL_DO_RESTART
		if (info->flags & S_HUP_NOTIFY)
			retval = -EAGAIN;
		else
			retval = -ERESTARTSYS;
#else
		retval = -EAGAIN;
#endif
	}

	/*
	 * If the device is in the middle of being closed, then block
	 * until it's done, and then try again.
	 */
	add_wait_queue(&info->open_wait, &wait);
	retval = wait_event_interruptible(info->open_wait, !(info->flags & S_CLOSING));
	if (retval) 
	{
#ifdef SERIAL_DO_RESTART
		if (info->flags & S_HUP_NOTIFY)
			retval = -EAGAIN;
		else
			retval = -ERESTARTSYS;
#else
		retval = -EAGAIN;
#endif
	}


	info->blocked_open--;
	remove_wait_queue(&info->open_wait, &wait);

	if (!retval)
		info->flags |= S_NORMAL_ACTIVE;
	
	return retval;
}



/* Finally, routines used to initialize the serial driver. */
static void show_serial_version(struct YANU_serial *info)
{
	yanu_uart_t *uart = (yanu_uart_t *)info->port;
	char ch;
	int a,b,c;

	yanu_debug(8, "yanu %d: <show_serial_version>\n", info->tty->index);

	ch = (char)(uart->magic & 0xFF);
	if (ch == 'y')
		a = 0;
	else
		a = 1;
	ch = (char)((uart->magic >> 8) & 0xFF);
	if (ch == 'a')
		b = 0;
	else
		b = 1;
	c = 1;
	ch = (char)((uart->magic >> 16) & 0xFF);
	if (ch == 'n')
		c += 0;
	else
		c += 1;
	ch = (char)((uart->magic >> 24) & 0xFF);
	if (ch == 'u')
		c += 0;
	else
		c += 2;
		
	printk(KERN_INFO "Imagos YANU, serial driver version: %s\n", YANU_SERIAL_VER);
	printk(KERN_INFO "Imagos YANU, hardware version: %d.%d.%d\n",a, b, c);
}



module_init(yanu_init);
module_exit(yanu_exit);



/**************************************** 
eventually we setup a console with it 
******************************************/
#ifdef CONFIG_YANU_SERIAL_CONSOLE
int yanu_console_setup(struct console *con, char *arg)
{ 
    int baud=115200;
    int parity='n';
    int bits=8;
    int flow='n';
    yanu_uart_t *uart = (yanu_uart_t *)(yanu_info[0].port);
    char *s = arg;
    
    if (arg)
	/*uart_parse_options(arg, &baud, &parity, &bits, &flow);*/
    {
	baud = simple_strtoul(s, NULL, 10);
	while (*s >= '0' && *s <= '9')
		s++;
	if (*s)
		parity = *s++;
	if (*s)
		bits = *s++ - '0';
	if (*s)
		flow = *s;
    }
    /*for now, we only set baud*/
    uart->baud = set_baud_prescaler(baud);
    
    return 0;
}


static struct tty_driver *yanu_console_device(struct console *con, int *index)
{
	*index = con->index;
	return yanu_driver;
}


void yanu_console_write(struct console *con, const char *str, unsigned int count)
{ 
	while (count--) {
		if (*str == '\n')
			put_char('\r', yanu_info+con->index);

		put_char( *str++, yanu_info+con->index);
	}
}


static struct console yanu_console_driver = {
	.name		= "ttyY",
	.write		= yanu_console_write,
	.device		= yanu_console_device,
	.setup		= yanu_console_setup,
	.flags		= CON_PRINTBUFFER | CON_ENABLED,
	.index		= -1,
};


static int __init yanu_console_init(void)
{
    int i;
    
    for(i=0; i<NR_PORTS;i++)
	yanu_info[i].port = (int) ioremap(yanu_info[i].port_unmap,0x20);
  
	register_console(&yanu_console_driver);

	return 0;
}

console_initcall(yanu_console_init);

#endif /* CONFIG_YANU_SERIAL_CONSOLE */
