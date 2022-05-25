#ifndef _IP_H_
#define _IP_H_

#ifdef __cplusplus
extern "C"
{
#endif// __cplusplus

#include "eth.h"
#include "net.h"

#define     ETH_IP     ntohs(0x0800) // IP type, net endian

// tbd
struct _ip_hdr {
   u8      ip_ver_ihl;    // 4 bit version, 4 bit hdr len in 32bit words 
   u8      ip_tos;        // Type of Service,  RFC 2474 -> {DSCP[5:0], ECN[1:0]} 
   u16     ip_len;        // Total packet length including header 
   u16     ip_id;         // ID for fragmentation 
   u16     ip_flgs_foff;  // mask in flags as needed 
   u8      ip_time;       // Time to live (secs) 
   u8      ip_prot;       // protocol 
   u16     ip_chksum;     // Header checksum 
   u32     ip_src;        // Source Addr 
   u32     ip_dest;       // Destination Addr 
} _packed_struct;
typedef struct _ip_hdr ip_hdr_t;

// Some macros for finding IP offsets in incoming packets
#define  ip_head(p)         (ip_hdr_t *)(p + ETH_HDR_SZ)
#define  ip_hlen(pip)       (((pip)->ip_ver_ihl  &  0x0f) << 2)
#define  ip_data(pip)       ((char *)(pip) +  ip_hlen(pip))

// fragmentation flag bits, for masking into 16bit flags/offset word
#define  IP_FLG_DF   0x4000   // Don't   Fragment (DF) bit 
#define  IP_FLG_MF   0x2000   // More Fragments (MF) bit 
#define  IP_FLG_MASK 0xe000   // for masking out all flags from word

// IPv4 def:
#define  IP_VER   4     // IPv4 -> 4 / RFC#791
#define  IP_LEN   5     // RFC#791 -> 5

// Ext:
void eth_ip_init(net_if_t *ip_net_if);
void eth_ip(char *iv_data);

#ifdef __cplusplus
}
#endif// __cplusplus

#endif   // _IP_H_
