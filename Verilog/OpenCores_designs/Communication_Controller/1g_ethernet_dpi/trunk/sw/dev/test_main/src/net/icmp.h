#ifndef _ICMP_H_
#define _ICMP_H_

#ifdef __cplusplus
extern "C"
{
#endif// __cplusplus

#include "eth.h" // _packed_struct
#include "net.h"


#define  ICMP_ECHO_RESP  0   // ICMP Echo reply
#define  ICMP_ECHO_REQ   8   // ICMP Echo request


#define  ICMP_DU_DATA_VOL 8 // RFC792, page#4: 64 bits of Original Data Datagram 

#define  ICMP_PROT   1     // ICMP Protocol number on IP

// ICMP Echo request/reply header
struct _icmp_hdr { 
   u8   ptype;
   u8   pcode;
   u16  pchksum;
   u16  pid;
   u16  pseq;
} _packed_struct;
typedef struct _icmp_hdr icmp_hdr_t;

// Ext:
void eth_icmp_init(net_if_t *ip_net_if);
void eth_icmp(char *iv_data);

#ifdef __cplusplus
}
#endif// __cplusplus

#endif   // _ICMP_H_
