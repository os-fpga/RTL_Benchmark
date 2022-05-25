#ifndef _NET_H_
#define _NET_H_

#ifdef __cplusplus
extern "C"
{
#endif// __cplusplus

#include "xil_types.h"
#include "tri_mode_emac.h" // tmemac_cfg_t, tri_mode_emac_init

/*
#ifndef NULL
#define NULL ((void*)0)
#endif  // NULL
*/

// net-order macros
#define lswap(x) ((((x) & 0xff000000) >> 24) | \
                  (((x) & 0x00ff0000) >>  8) | \
                  (((x) & 0x0000ff00) <<  8) | \
                  (((x) & 0x000000ff) << 24))
#define htonl(l) (lswap(l))
#define ntohl(l) (lswap(l))
#define htons(s) ((((s) >> 8) & 0xff) | \
                  (((s) << 8) & 0xff00))
#define ntohs(s) htons(s)

// mac macros
#define _MAC_ADDR_HIGH(a,b)     ((a & 0xFF) <<  8) | \
                                ((b & 0xFF) <<  0) 
#define _MAC_ADDR_LOW(a,b,c,d)  ((a & 0xFF) << 24) | \
                                ((b & 0xFF) << 16) | \
                                ((c & 0xFF) <<  8) | \
                                ((d & 0xFF) <<  0) 
// ip macro
#define _IP_ADDR(a,b,c,d)       ((a & 0xFF) << 24) | \
                                ((b & 0xFF) << 16) | \
                                ((c & 0xFF) <<  8) | \
                                ((d & 0xFF) <<  0) 

// tbd
typedef struct {
    // eth-tx routine
    int     (*net_raw_send)(char *, int);
    // cfg
    u8      *mac_addr;
    u32     ip_addr;
} net_if_t;

// Ext:
int net_init(tmemac_cfg_t *iv_tmemac_cfg, u32 pkt_tx, u32 pkt_rx);
int net_input(char *buff);

#ifdef __cplusplus
}
#endif// __cplusplus

#endif // _NET_H_