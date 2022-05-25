//////////////////////////////////////////////////////////////////////////////////
#include <stdlib.h>
#include <stdio.h>

#include "ether.h" // ETH_PKT_MAC_ADDR_LEN, ..
#include "eth_host_bfm.h" // eth_frm_read_wait, ..

//////////////////////////////////////////////////////////////////////////////////
// PKT-LEN
int pkt_len;
//////////////////////////////////////////////////////////////////////////////////
// 
// Ethernet RX routine
//

int ether_rx_ok(void)
{
    eth_frm_read_len(&pkt_len);
    return(pkt_len != -1);
}

void ether_rx(char *obuff, int *olen) // !!!only after 'ether_rx_ok' + 'obuff' must be pre-allocated
{
    // dec vars
    int i, pkt_data;
    // proc
    *olen = pkt_len;
    for (i = 0; i < pkt_len; i++) {
            eth_frm_read(&pkt_data, i);
            *(obuff+i) = pkt_data;
    }
    // msg2usr
    unsigned short pkt_type = *((unsigned short *)((obuff)+ETH_PKT_MAC_ADDR_LEN*2));
    switch(pkt_type) {
        case ETH_PKT_ARP : {
            printf("ether_rx: ETH_PKT_ARP, len=%04x\n", pkt_len);
            break;
        }
        case ETH_PKT_IPv4 : {
            ip_hdr_t *ptr_ipv4_hdr = (ip_hdr_t *)(obuff+ETH_HDR_LEN);
            switch(ptr_ipv4_hdr->ip_prot) {
                case IPv4_ICMP : {
                    printf("ether_rx: ETH_PKT_IPv4-ICMP, len=%04x\n", pkt_len);
                    break;
                }
                case IPv4_UDP : {
                    printf("ether_rx: ETH_PKT_IPv4-UDP, len=%04x\n", pkt_len);
                    break;
                }
                default : {
                    printf("ether_rx: ETH_PKT_IPv4: IP protocol number = %x, len=%04x\n", ptr_ipv4_hdr->ip_prot, pkt_len);
                    break;
                }
            }
            break;
        }
        default : {
            printf("ether_rx: pkt-type=%04x, len=%04x\n", ntohs(pkt_type), pkt_len);
            break;
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////
