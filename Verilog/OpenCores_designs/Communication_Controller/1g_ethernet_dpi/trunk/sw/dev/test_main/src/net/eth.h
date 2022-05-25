#ifndef _ETH_H_
#define _ETH_H_

#ifdef __cplusplus
extern "C"
{
#endif// __cplusplus

#include "xil_types.h"

// ??
#define _packed_struct  __attribute__ ((__packed__))

// eth hdr
struct ethhdr_ {
    u8   e_dst[6]; // ETH_DST_OFST
    u8   e_src[6]; // ETH_SRC_OFST
    u16  e_type;              // ETH_TYPE_OFST
} _packed_struct;
typedef struct ethhdr_ ethhdr_t;

// define Ethernet header size
#define ETH_HDR_SZ (sizeof(ethhdr_t))

// Offset of destination address within Ethernet header
#define ETH_DST_OFST      (0)

// Offset of source address within Ethernet header
#define ETH_SRC_OFST      (6)

// Offset of Ethernet type within Ethernet header
#define ETH_TYPE_OFST     (12)

/* Get Ethernet type from Ethernet header pointed by char * e
 * !!!returned Ethernet type is in host order!!!
 */
#define ETH_TYPE_GET(e)  \
        (((unsigned)(*((e) + ETH_TYPE_OFST)) << 8) + \
         (*((e) + ETH_TYPE_OFST + 1) & 0xff))

/* Set Ethernet type in Ethernet header pointed by char * e to value (type)
 * !!!Ethernet type is value is expected to be in host order!!!
 */
#define ETH_TYPE_SET(e, type) \
        *((e) + ETH_TYPE_OFST) = (unsigned char)(((type) >> 8) & 0xff); \
        *((e) + ETH_TYPE_OFST + 1) = (unsigned char)((type) & 0xff);

// rfc1071 internet checksum
unsigned short cksum(void * ptr, int count);

#ifdef __cplusplus
}
#endif// __cplusplus

#endif   // _ETH_H_
