#ifndef _ETHER_H_
#define _ETHER_H_


#ifdef __cplusplus
extern "C"
{
#endif// __cplusplus

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

// prep IP-addr for PRINT
#define  PUSH_IPADDR(ip)\
   (unsigned)(ip&0xff),\
   (unsigned)((ip>>8)&0xff),\
   (unsigned)((ip>>16)&0xff),\
   (unsigned)(ip>>24)
// 
#define ETH_PKT_MAC_ADDR_LEN    (6)
#define ETH_PKT_IP_ADDR_LEN     (4)
#define ETH_HDR_LEN             (ETH_PKT_MAC_ADDR_LEN + ETH_PKT_MAC_ADDR_LEN + 2) // ..+ pkt_type
#define ETH_IPv4_HDR_LEN        (20) // -> 20 Bytes
// TU-val
#define ETH_MIN_TU              (60)
#define ETH_MAX_TU              (1500) // Eth MTU
// ETH#
#define ETH_PKT_ARP             ntohs(0x0806)
#define ETH_PKT_IPv4            ntohs(0x0800)
#define ETH_PKT_IPv6            ntohs(0x86dd)
// IPv4#
#define IPv4_ICMP               0x01
#define IPv4_IGMP               0x02
#define IPv4_TCP                0x06
#define IPv4_UDP                0x11
#define IPv4_RDP                0x1B
#define IPv4_IRTP               0x1C
#define IPv4_IPv6Encaps         0x29
#define IPv4_IPv6Route          0x2B
#define IPv4_IPv6Frag           0x2C
#define IPv4_VISA               0x46
#define IPv4_QNX                0x6A
#define IPv4_SMP                0x79
#define IPv4_SCTP               0x84
#define IPv4_UDPLite            0x88




// 
typedef unsigned short u16;
typedef unsigned int ip_addr;
// 
typedef struct {
   char    ip_ver_ihl;    // 4 bit version, 4 bit hdr len in 32bit words 
   char    ip_tos;        // Type of Service,  RFC 2474 -> {DSCP[5:0], ECN[1:0]} 
   u16     ip_len;        // Total packet length including header 
   u16     ip_id;         // ID for fragmentation 
   u16     ip_flgs_foff;  // mask in flags as needed 
   unsigned char    ip_time;       // Time to live (secs) 
   char    ip_prot;       // protocol 
   u16     ip_chksum;     // Header checksum 
   ip_addr ip_src;        // Source Addr 
   ip_addr ip_dest;       // Destination Addr 
} ip_hdr_t;
// 
typedef struct
{
   u16  ud_srcp;    /* source port */
   u16  ud_dstp;    /* dest port */
   u16  ud_len;     /* length of UDP packet */
   u16  ud_cksum;   /* UDP checksum */
} udp_hdr_t;



// tx
void ether_tx(char *ibuff, int ilen);
// rx
int ether_rx_ok(void);
void ether_rx(char *obuff, int *olen);


#ifdef __cplusplus
}
#endif// __cplusplus

#endif // _ETHER_H_
