#ifndef _ARP_H_
#define _ARP_H_

#ifdef __cplusplus
extern "C"
{
#endif// __cplusplus

#include "xil_types.h"
#include "tri_mode_emac.h" // tmemac_cfg_t

#include "eth.h" // _packed_struct
#include "net.h" // net_if_t

// ??
#define ARP_SZ      (64)

// APR-proto definitions / net endian
#define ETH_ARP     htons(0x0806)   // Eth-Protocol-Type
#define ARP_HW_ETH  htons(1)        // arp hardware type for ethernet
#define ARP_IPv4    htons(0x0800)   // IPv4 type
#define ARP_REQ     htons(1)        // byte swapped request opcode
#define ARP_RESP    htons(2)        // byte swapped reply opcode
// tbd
struct arp_hdr_ {
    u16     ar_hd;      /* hardware type */
    u16     ar_pro;     /* protcol type */
    u8      ar_hln;     /* hardware addr length */
    u8      ar_pln;     /* protocol header length */
    u16     ar_op;      /* opcode */
    u8      ar_sha[6];  /* sender hardware address */
    u32     ar_spa;     /* sender protocol address */
    u8      ar_tha[6];  /* target hardware address */
    u32     ar_tpa;     /* target protocol address */
} _packed_struct;
typedef struct arp_hdr_ arp_hdr_t;

// Ext:
void eth_arp_init(net_if_t *ip_net_if);
void eth_arp(char *iv_data);

#ifdef __cplusplus
}
#endif// __cplusplus

#endif   // _ARP_H_
