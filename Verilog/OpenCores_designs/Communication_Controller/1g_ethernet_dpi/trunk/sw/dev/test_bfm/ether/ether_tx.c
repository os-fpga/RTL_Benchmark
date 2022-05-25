//////////////////////////////////////////////////////////////////////////////////
#include <stdlib.h>
#include <stdio.h>

#include "ether.h" // ETH_PKT_MAC_ADDR_LEN, ..
#include "eth_host_bfm.h" // eth_frm_write_wait, ..

//////////////////////////////////////////////////////////////////////////////////
// IPv4: name+id LIST
typedef struct {
    char id;
    char name[20];
} ipv4_prot_map_t;
const ipv4_prot_map_t ipv4_prot_map[] = {
    {IPv4_ICMP,         "IPv4_ICMP"}, 
    {IPv4_IGMP,         "IPv4_IGMP"}, 
    {IPv4_TCP,          "IPv4_TCP"}, 
    {IPv4_UDP,          "IPv4_UDP"}, 
    {IPv4_RDP,          "IPv4_RDP"}, 
    {IPv4_IRTP,         "IPv4_IRTP"}, 
    {IPv4_IPv6Encaps,   "IPv4_IPv6Encaps"}, 
    {IPv4_IPv6Route,    "IPv4_IPv6Route"}, 
    {IPv4_IPv6Frag,     "IPv4_IPv6Frag"},
    {IPv4_QNX,          "IPv4_QNX"}, 
    {IPv4_SMP,          "IPv4_SMP"}, 
    {IPv4_SCTP,         "IPv4_SCTP"}, 
    {IPv4_UDPLite,      "IPv4_UDPLite"}
};
//////////////////////////////////////////////////////////////////////////////////
// 
extern unsigned short crc_ip(void * ptr, unsigned count);
extern long crc_ether(char *buf, int len);

// 
void ether_tx_raw(char *ibuff, int ilen);
void ether_tx_ipv4(char *ibuff, int ilen);

//////////////////////////////////////////////////////////////////////////////////
//
// Ethernet TX routine
//
void ether_tx(char *ibuff, int ilen)
{
    // 
    unsigned short pkt_type = *((unsigned short *)((ibuff)+ETH_PKT_MAC_ADDR_LEN*2));
    switch(pkt_type) {
        case ETH_PKT_ARP : {
            printf("ether_tx: ETH_PKT_ARP, len=%04x\n", ilen);
            ether_tx_raw(ibuff, ilen);
            break;
        }
        case ETH_PKT_IPv4 : {
            ip_hdr_t *ptr_ipv4_hdr = (ip_hdr_t *)(ibuff+ETH_HDR_LEN);
            int i, prot=0;
            for (i = 0; i < (sizeof(ipv4_prot_map))/(sizeof(ipv4_prot_map_t)); i++) {
                if (ipv4_prot_map[i].id == ptr_ipv4_hdr->ip_prot) {
                    printf("ether_tx: %s, len=%04x\n", ipv4_prot_map[i].name, ilen);
                    prot++;
                }
            }
            if (prot == 0) { // not found in list
                printf("ether_tx: ETH_PKT_IPv4: IP protocol number = %x, len=%04x\n", ptr_ipv4_hdr->ip_prot, ilen);
            }
            
            /*
            switch(ptr_ipv4_hdr->ip_prot) {
                case IPv4_ICMP : {
                    printf("ether_tx: ETH_PKT_IPv4-ICMP, len=%04x\n", ilen);
                    break;
                }
                case IPv4_UDP : {
                    printf("ether_tx: ETH_PKT_IPv4-UDP, len=%04x\n", ilen);
                    break;
                }
                default : {
                    printf("ether_tx: ETH_PKT_IPv4: IP protocol number = %x, len=%04x\n", ptr_ipv4_hdr->ip_prot, ilen);
                    break;
                }
            }
            */
            ether_tx_ipv4(ibuff, ilen);
            break;
        }/*
        case ETH_PKT_IPv6 : {
            printf("ether_tx: ETH_PKT_IPv6, len=%04x\n", ilen);
            ether_tx_raw(ibuff, ilen);
        }*/
        default : {
            /*printf("ether_tx: pkt-type=%04x, len=%04x\n", ntohs(pkt_type), ilen);
            ether_tx_raw(ibuff, ilen);*/
            break;
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////
//
// ARP+others
//
void ether_tx_raw(char *ibuff, int ilen)
{
    int i;
    // apr-len == 42 in case if {apr-len < ETH_MIN_TU} -> we will have rejection inside MAC
    int len_raw = (ilen < ETH_MIN_TU)? ETH_MIN_TU : ilen;
    char *ptr_raw = (char *)calloc(len_raw, sizeof(char)); // <- MEM-alloc
    if (ptr_raw == NULL) { return; }
    for (i = 0; i < ETH_MIN_TU; i++) { *(ptr_raw+i) = 0; }
    // data-copy
    for (i = 0; i < ilen; i++) {
        *(ptr_raw+i) = *(ibuff+i);
    }
    // upld
    for (i = 0; i < len_raw; i++) {
        eth_frm_write(*(ptr_raw+i), i);
    }
    // fcs
    int fcs = crc_ether(ptr_raw, len_raw);
    eth_frm_write(((fcs >>  0) & 0xFF), len_raw+0);
    eth_frm_write(((fcs >>  8) & 0xFF), len_raw+1);
    eth_frm_write(((fcs >> 16) & 0xFF), len_raw+2);
    eth_frm_write(((fcs >> 24) & 0xFF), len_raw+3);
    // len + STA
    eth_frm_write_len(len_raw+4); //+ FCS
    // 
    free(ptr_raw); // -> MEM-free
}
//////////////////////////////////////////////////////////////////////////////////
//
// IPv4-UDP
//
void ether_tx_ipv4(char *ibuff, int ilen)
{
    // check len
    char *ptr_ipv4;
    int i, tx_len;
    
    if (ilen < ETH_MIN_TU){
        ptr_ipv4 = (char *)calloc(ETH_MIN_TU, sizeof(char)); // <- MEM-alloc
        if (ptr_ipv4 == NULL) { return; }
        for (i = 0; i < ETH_MIN_TU; i++) { *(ptr_ipv4+i) = 0; }
        for (i = 0; i < ilen; i++) { *(ptr_ipv4+i) = *(ibuff+i); }
        tx_len = ETH_MIN_TU;
    } else {
        ptr_ipv4 = ibuff;
        tx_len = ilen;
    }
    
    // ipv4-csum
    ip_hdr_t *ptr_ipv4_hdr = (ip_hdr_t *)(ibuff+ETH_HDR_LEN);
    ptr_ipv4_hdr->ip_chksum = 0;
    unsigned short ipv4_xsum = ~crc_ip((char *)ptr_ipv4_hdr, ETH_IPv4_HDR_LEN >> 1);
    ptr_ipv4_hdr->ip_chksum = ipv4_xsum;
    // udp-csum
    udp_hdr_t *ptr_udp_hdr = (udp_hdr_t *)(ibuff+ETH_HDR_LEN+ETH_IPv4_HDR_LEN);
    ptr_udp_hdr->ud_cksum = 0;
    
    // upld
    for (i = 0; i < tx_len; i++) {
        eth_frm_write(*(ptr_ipv4+i), i);
    }
    // fcs
    int fcs = crc_ether(ptr_ipv4, tx_len);
    eth_frm_write(((fcs >>  0) & 0xFF), tx_len+0);
    eth_frm_write(((fcs >>  8) & 0xFF), tx_len+1);
    eth_frm_write(((fcs >> 16) & 0xFF), tx_len+2);
    eth_frm_write(((fcs >> 24) & 0xFF), tx_len+3);
    // len + STA
    eth_frm_write_len(tx_len+4); //+ FCS
    // 
    if (ilen < ETH_MIN_TU){
        free(ptr_ipv4); // -> MEM-free
    }
}
//////////////////////////////////////////////////////////////////////////////////
