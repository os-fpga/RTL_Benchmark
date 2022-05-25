
#include <stdio.h>

#include "xil_types.h"
#include "xil_io.h"

#include "xil_lib.h" // xil_malloc, xil_free

#include "eth.h"
#include "arp.h"

// net-if 
net_if_t *ifp;

// ??
void eth_arp_init(net_if_t *ip_net_if)
{
    ifp = ip_net_if;
    // Final
}
// simple arp req-resp logic:
void eth_arp(char *iv_data)
{
    // extract Eth-Type
    char *ethin = iv_data;
    u16 etype = ETH_TYPE_GET(ethin);
    // chk ARP-proto
    if (etype != ntohs(ETH_ARP)) {
        return;
    }
    
    // chk ipkt
    arp_hdr_t *in = (arp_hdr_t *)(iv_data + ETH_HDR_SZ);
    if (in->ar_pro != ARP_IPv4) {
        return;
    }
    if (in->ar_op != ARP_REQ) {
        return;
    }
    if (in->ar_tpa != ifp->ip_addr) {
        return;
    }
    
    // alloc/init opkt
    char *ethout = xil_malloc(ARP_SZ); // <-
    arp_hdr_t *out = (arp_hdr_t *)(ethout + ETH_HDR_SZ);
    if (!ethout) { // xil_malloc-ERR
        return;
    }
    xil_memset(ethout, 0, ARP_SZ);
    
    // fill opkt
    xil_memmove(ethout + ETH_DST_OFST, ethin + ETH_SRC_OFST, 6);
    xil_memmove(ethout + ETH_SRC_OFST, ifp->mac_addr, 6);
    ETH_TYPE_SET(ethout, ntohs(ETH_ARP));
    
    out->ar_hd = ARP_HW_ETH;
    out->ar_pro = ARP_IPv4;
    out->ar_hln = 6;
    out->ar_pln = 4;
    out->ar_op = ARP_RESP;
    
    xil_memmove((char *)out->ar_sha, (char *)ifp->mac_addr, 6);
    out->ar_spa = in->ar_tpa;
    xil_memmove((char *)out->ar_tha, (char *)in->ar_sha, 6);
    out->ar_tpa = in->ar_spa;
    
    // tx
    ifp->net_raw_send(ethout, ETH_HDR_SZ+sizeof(arp_hdr_t));
    
    // Final
    xil_free(ethout); // ->
}
