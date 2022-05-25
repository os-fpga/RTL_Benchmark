
#include "xil_lib.h" 
#include "ip.h"
#include "icmp.h"

// net-if
net_if_t *ifp;

// ??
void eth_ip_init(net_if_t *ip_net_if)
{
    ifp = ip_net_if;
    // Final
}
// simple IP-parser: for {ICMP_PROT} only!!!
void eth_ip(char *iv_data)
{
    
    ip_hdr_t * pip; // the internet header
    u16 ffo; // IP hdr: {flags + fragment_offset}
    
    // 
    pip = ip_head(iv_data);
    
    // !check IP version
    if ( ((pip->ip_ver_ihl & 0xf0) >> 4) != IP_VER) {
        //printf("ip_rcv: bad version number\n");
        return;
    }
    
    // !check IP Header Checksum
    
    // !check our own IP addr / NET IF
    if (pip->ip_dest != ifp->ip_addr) {
        if (pip->ip_dest != 0xFFFFFFFF) { // broadcast for all nets
            //printf("ip_rcv: got pkt not for me; for %x\n", pip->ip_dest);
            return;
        }
    }
    
    // !check TTL
    if (pip->ip_time == 0) { // expired?
        //printf("ip_rcv: bad ttl\n");
        return;
    }
    
    // Test for fragment:
    ffo = htons(pip->ip_flgs_foff);
    if (ffo & IP_FLG_MASK){
        if ((ffo & IP_FLG_DF) == 0){
            //printf("ip_rcv: bad ip-frag\n");
            return;
        }
    }
    
    // !check IHL
    if ((pip->ip_ver_ihl & 0x0F) != IP_LEN) {
        //printf("ip_rcv: bad IHL\n");
        return;
    }
    
    //
    // pass pkt to upper layer
    switch(pip->ip_prot) {
        case ICMP_PROT : { // Internet Control Message Protocol type
            eth_icmp(iv_data);
            break;
        }
        default : { // unsupported type
            //printf("ip_rcv: ip_prot=%x\n", pip->ip_prot);
            break;
        }
    }
    // Final
}