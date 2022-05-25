//////////////////////////////////////////////////////////////////////////////////
#include <stdlib.h>
#include <stdio.h>

//////////////////////////////////////////////////////////////////////////////////

// AUTODIN II, Ethernet, & FDDI
#define CRC32_POLY 0x04c11db7

// Generating polynomial:
typedef unsigned int uint32_t;
typedef unsigned char u8_t;
const uint32_t ethernet_polynomial_le = 0xedb88320U;
//////////////////////////////////////////////////////////////////////////////////

long crc_ether(char *buf, int len) { // Ethernet FCS, 32bit
    int length; u8_t *data; int foxes;
    length = len;
    data = buf;
    foxes = 1;
    
    unsigned int crc = (foxes) ? 0xffffffff: 0;	/* Initial value. */
    while(--length >= 0) 
      {
	unsigned char current_octet = *data++;
	int bit;
	// printf("%02X, %08X,  inv %08X\n", current_octet, crc, ~crc);

	for (bit = 8; --bit >= 0; current_octet >>= 1) {
	  if ((crc ^ current_octet) & 1) {
	    crc >>= 1;
	    crc ^= ethernet_polynomial_le;
	  } else
	    crc >>= 1;
	}
      }
    return ~crc;
}

/*
The CRC algorithm implementation by C language is as follows: This algorithm is often used as the Ethernet FCS(Frame Check Sequence).

#define CRCPOLY2 0xEDB88320UL  // left-right reversal

static unsigned long crc2(int n, unsigned char c[])
{
	int i, j;
	unsigned long r;

	r = 0xFFFFFFFFUL;
	for (i = 0; i < n; i++) {
		r ^= c[i];
		for (j = 0; j < CHAR_BIT; j++)
			if (r & 1) r = (r >> 1) ^ CRCPOLY2;
			else       r >>= 1;
	}
	return r ^ 0xFFFFFFFFUL;
}
*/
//////////////////////////////////////////////////////////////////////////////////
