
#include "xil_lib.h" 
#include "ip.h"
#include "icmp.h"

// net-if
net_if_t *ifp;

// ??
void eth_icmp_init(net_if_t *ip_net_if)
{
    ifp = ip_net_if;
    // Final
}
// {ICMP_ECHO_REQ+ICMP_ECHO_RESP} only!!!
void eth_icmp(char *iv_data)
{
    
    // 
    ip_hdr_t *pip = ip_head(iv_data);
    
    // chk ipkt
    icmp_hdr_t *in = (icmp_hdr_t *)(ip_data(pip));
    int len = htons(pip->ip_len) - ip_hlen(pip);
    
    // !check ICMP Header checksum
    
    // pass pkt to proper ICMP routine
    switch(in->ptype) {
        case ICMP_ECHO_REQ : {
            // mac
            xil_memmove(iv_data + ETH_DST_OFST, iv_data + ETH_SRC_OFST, 6);
            xil_memmove(iv_data + ETH_SRC_OFST, ifp->mac_addr, 6);
            // ptype
            in->ptype = ICMP_ECHO_RESP;
            // checksum
            in->pchksum = 0;
            in->pchksum = cksum(in, len);
            // ip-addr
            pip->ip_dest = pip->ip_src;
            pip->ip_src = ifp->ip_addr;
            // 
            ifp->net_raw_send(iv_data, ETH_HDR_SZ+htons(pip->ip_len));
            break;
        }
        default : {
            //printf("eth_icmp: ptype=%x\n", in->ptype);
            break;
        }
    }
    // Final
}