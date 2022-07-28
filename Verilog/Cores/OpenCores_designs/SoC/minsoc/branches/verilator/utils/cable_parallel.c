/* cable_parallel.c - Parallel cable drivers (XPC3 and XESS) for the Advanced JTAG Bridge
   Copyright (C) 2001 Marko Mlinar, markom@opencores.org
   Copyright (C) 2004 György Jeney, nog@sdf.lonestar.org
   
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA. */



#include <stdio.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/ppdev.h>
#include <linux/ioctl.h>
#include <linux/parport.h>

#include "cable_common.h"
#include "errcodes.h"


// Common functions used by both cable types
static int cable_parallel_out(uint8_t value);
static int cable_parallel_inout(uint8_t value, uint8_t *inval);


int fd;



/////////////////////////////////////////////////////////////////////////////////
/*-------------------------------------[ Parallel port specific functions ]---*/
///////////////////////////////////////////////////////////////////////////////

int cable_parallel_init()
{
/*
  //#ifndef WIN32
  if (ioperm(base, 3, 1)) {
    fprintf(stderr, "Couldn't get the port at %x\n", base);
    perror("Root privileges are required.\n");
    return APP_ERR_INIT_FAILED;
  }
  printf("Connected to parallel port at %x\n", base);
  printf("Dropping root privileges.\n");
  setreuid(getuid(), getuid());
  //#endif
*/
  int mode = IEEE1284_MODE_COMPAT;
  fd = open("/dev/parport0", O_RDWR | O_NONBLOCK);
  if (fd == -1)
  {
    perror("Not able to acquire the device desriptor\n");
    return APP_ERR_INIT_FAILED;
  }
  if (ioctl(fd, PPCLAIM) == -1)
  {
    perror("Fail to claim the interface for itself.\n");
    return APP_ERR_INIT_FAILED;
  }
  if (ioctl(fd, PPSETMODE, &mode) == -1)
  {
    perror("Setting compatibility mode failed.\n");
    return APP_ERR_INIT_FAILED;
  }

  return APP_ERR_NONE;
}


int cable_parallel_opt(int c, char *str)
{
  switch(c) {
  case 'p':
//    if(!sscanf(str, "%x", &base)) {
//      fprintf(stderr, "p parameter must have a hex number as parameter\n");
      return APP_ERR_BAD_PARAM;
//    }
    break;
  default:
    fprintf(stderr, "Unknown parameter '%c'\n", c);
    return APP_ERR_BAD_PARAM;
  }
  return APP_ERR_NONE;
}

/*-----------------------------------------[ Physical board wait function ]---*/
void cable_parallel_phys_wait()
{
  /* Multiple users have reported poor performance of parallel cables,
   * which has been traced to usleep() sleeping much longer than 
   * microseconds.  The same users have reported error-free functionality
   * and an order of magnitude improvement in upload speed.
   * If you get strange data errors while running, add this sleep back
   * in, or perhaps a busy-wait delay. 
   */ 
  /* usleep(10); */
}

/*----------------------------------------------[ xpc3 specific functions ]---*/
int cable_xpc3_out(uint8_t value)
{
  uint8_t out = 0;

  /* First convert the bits in value byte to the ones that the cable wants */
  if(value & TCLK_BIT)
    out |= 0x02; /* D1 pin 3 */
  if(value & TRST_BIT)
    out |= 0x10; /* Not used */
  if(value & TDI_BIT)
    out |= 0x01; /* D0 pin 2 */
  if(value & TMS_BIT)
    out |= 0x04; /* D2 pin 4 */

  return cable_parallel_out(out);
}

int cable_xpc3_inout(uint8_t value, uint8_t *inval)
{
  uint8_t in;
  int retval;
  uint8_t out = 0;

  /* First convert the bits in value byte to the ones that the cable wants */
  if(value & TCLK_BIT)
    out |= 0x02; /* D1 pin 3 */
  if(value & TRST_BIT)
    out |= 0x10; /* Not used */
  if(value & TDI_BIT)
    out |= 0x01; /* D0 pin 2 */
  if(value & TMS_BIT)
    out |= 0x04; /* D2 pin 4 */

  retval = cable_parallel_inout(out, &in);

  if(in & 0x10) /* S6 pin 13 */
    *inval = 1;
  else
    *inval = 0;

  return retval;
}

/*----------------------------------------------[ xess specific functions ]---*/
int cable_xess_out(uint8_t value)
{
  uint8_t out = 0;

  /* First convert the bits in value byte to the ones that the cable wants */
  if(value & TCLK_BIT)
    out |= 0x04; /* D2 pin 4 */
  if(value & TRST_BIT)
    out |= 0x08; /* D3 pin 5 */
  if(value & TDI_BIT)
    out |= 0x10; /* D4 pin 6 */
  if(value & TMS_BIT)
    out |= 0x20; /* D3 pin 5 */

  return cable_parallel_out(out);
}

uint8_t cable_xess_inout(uint8_t value, uint8_t *inval)
{
  uint8_t in;
  int retval;
  uint8_t out = 0;

  /* First convert the bits in value byte to the ones that the cable wants */
  if(value & TCLK_BIT)
    out |= 0x04; /* D2 pin 4 */
  if(value & TRST_BIT)
    out |= 0x08; /* D3 pin 5 */
  if(value & TDI_BIT)
    out |= 0x10; /* D4 pin 6 */
  if(value & TMS_BIT)
    out |= 0x20; /* D3 pin 5 */

  retval = cable_parallel_inout(out, &in);

  if(in & 0x20) /* S5 pin 12*/
    *inval = 1;
  else
    *inval = 0;

  return retval;
}


/*----------------------------------------------[ common helper functions ]---*/
// 'static' for internal access only

static int cable_parallel_out(uint8_t value)
{
  ioctl(fd, PPWDATA, &value);

  return APP_ERR_NONE;
}

static int cable_parallel_inout(uint8_t value, uint8_t *inval)
{
  ioctl(fd, PPRSTATUS, inval);
  ioctl(fd, PPWDATA, &value);

  return APP_ERR_NONE;
}
