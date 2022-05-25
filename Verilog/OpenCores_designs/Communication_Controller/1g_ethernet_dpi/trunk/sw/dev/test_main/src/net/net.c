
#include <stdio.h>

#include "xil_types.h"
#include "xil_io.h"

#include "xparameters.h" // XPAR_TMEMAC_0_BASEADDR, XPAR_AXIDMA_0_DEVICE_ID, XPAR_BRAM_0_BASEADDR
#include "xaxidma.h" // XAxiDma_LookupConfig, ..

#include "net.h"
#include "arp.h"
#include "ip.h"
#include "icmp.h"

// NET-IF
net_if_t net_if;
u8 mac_addr[8];

// DMA 
XAxiDma AxiDma;
XAxiDma_Config *CfgPtr;

// BUFF
UINTPTR tx_buff;
UINTPTR rx_buff;
int rx_len;

// ??
int mac_raw_send(char *data_i, int data_bytes);    // net_init
void low_level_input(char *buff);             // net_input


// net-stack INIT
int net_init(tmemac_cfg_t *iv_tmemac_cfg, u32 pkt_tx, u32 pkt_rx)
{
    int result;
    
    // DMA init
    CfgPtr = XAxiDma_LookupConfig(XPAR_AXIDMA_0_DEVICE_ID);
    if (!CfgPtr) { return -1; }
    
    result = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
    if (result != XST_SUCCESS) { return -2; }
    
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA); // Disable interrupts, we use polling mode
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE); // ..
    
    tx_buff = (UINTPTR)pkt_tx;
    rx_buff = (UINTPTR)pkt_rx;
    rx_len = 0;

    result = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR)rx_buff, 1024, XAXIDMA_DEVICE_TO_DMA);
    if (result) {
        return -3;
    }
    
    // ETH init
    result = tri_mode_emac_init(iv_tmemac_cfg);
    if (result) {
        return -4;
    }
    
    // NET-IF init
    //  ip
    net_if.ip_addr = htonl(iv_tmemac_cfg->ip_addr);
    //  mac
    mac_addr[0] = ((iv_tmemac_cfg->mac_high) >>  8) & 0xFF;
    mac_addr[1] = ((iv_tmemac_cfg->mac_high) >>  0) & 0xFF;
    mac_addr[2] = ((iv_tmemac_cfg->mac_low ) >> 24) & 0xFF;
    mac_addr[3] = ((iv_tmemac_cfg->mac_low ) >> 16) & 0xFF;
    mac_addr[4] = ((iv_tmemac_cfg->mac_low ) >>  8) & 0xFF;
    mac_addr[5] = ((iv_tmemac_cfg->mac_low ) >>  0) & 0xFF;
    net_if.mac_addr = &mac_addr[0];
    //  raw_send
    net_if.net_raw_send = mac_raw_send;
    
    // ARP
    eth_arp_init(&net_if);
    // IP
    eth_ip_init(&net_if);
    // ICMP
    eth_icmp_init(&net_if);
    
    // Final
    return 0;
}
// poll income-pkt
int net_input(char *buff)
{
    // rx
    low_level_input(buff);
    // prep-len
    int len = rx_len; 
    rx_len = 0;
    // Final
    return len;
}


// tbd
void low_level_input(char *buff)
{
    // dec vars
    int i, result;
    
    // check Dma_Busy
    if (XAxiDma_Busy(&AxiDma, XAXIDMA_DEVICE_TO_DMA)) {
        return;
    }
    
    // if we are here -> check dma-status
    result = XAxiDma_IntrGetIrq(&AxiDma, XAXIDMA_DEVICE_TO_DMA);
    if (result & XAXIDMA_IRQ_ERROR_MASK) {
        rx_len = -1;
        return;
    }
    if (result & XAXIDMA_IRQ_IOC_MASK){
        // if we are here  we have rxd / cp 1st 512B to USER-buff
        u32 *tmp = (u32 *)buff;
        for (i = 0; i < 512/4; i++){
            *tmp = Xil_In32(rx_buff+(i*4));
            tmp++;
        }
        rx_len = 512/4;
    }
    
    // irq-ack
    XAxiDma_IntrAckIrq(&AxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DEVICE_TO_DMA);
    // restart dma
    result = XAxiDma_SimpleTransfer(&AxiDma,(UINTPTR)rx_buff, 1024, XAXIDMA_DEVICE_TO_DMA);
    // Final
    rx_len = (result == XST_SUCCESS)? rx_len : -2;
}
// eth-tx data via {DMA+MAC}
int mac_raw_send(char *data_i, int data_bytes)
{
    // dec vars
    int i, len_dw, len_b;
    u32 *odata_dw, *idata_dw;
    u8  *odata_b,  *idata_b;
    
    // chk
    if ((long)data_i & 0x03) { // DW-align
        xil_printf("ERR: tx-buff addr\n\r");
        return -1;
    }
    // prep
    len_dw = data_bytes / 4;
    len_b  = data_bytes & (4-1);
    // #0 - copy main DW-body
    odata_dw = (u32 *)tx_buff;
    idata_dw = (u32 *)data_i;
    for (i = 0; i < len_dw; i++) {
        Xil_Out32((long)odata_dw, *idata_dw);
        odata_dw++; idata_dw++;
    }
    // #1 - copy BYTE-tail
    if (len_b) { // always DW-aligned
        Xil_Out32((long)odata_dw, *idata_dw);
    }
/*
    odata_b = (u8 *)odata_dw;
    idata_b = (u8 *)idata_dw;
    for (i = 0; i < len_b; i++) {
        Xil_Out8((long)odata_b, *idata_b);
        odata_b++; idata_b++;
    }
*/
    
    // tx
    i = XAxiDma_SimpleTransfer(&AxiDma, tx_buff, data_bytes, XAXIDMA_DMA_TO_DEVICE);
    // Final
    return i;
}