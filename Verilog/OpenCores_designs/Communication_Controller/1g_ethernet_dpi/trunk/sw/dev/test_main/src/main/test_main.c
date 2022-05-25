/*
 * simple test application
 *
 * UART baud rate == 115200
 *
 */

#include <stdio.h>
#ifndef MSIM
 #include "platform.h"
#else
 #include "xil_printf.h"
#endif // MSIM


#include "xparameters.h" // XPAR_TMEMAC_0_BASEADDR, XPAR_AXIDMA_0_DEVICE_ID, XPAR_BRAM_0_BASEADDR
#include "tri_mode_emac.h" // tmemac_cfg_t

#include "xil_lib.h" // xil_malloc, xil_free

#include "net.h" // net_init, net_input
#include "arp.h"
#include "ip.h"

// CFG:
//  eth pkt
#define ETH_MIN_PKT_LEN 64
#define ETH_MAX_PKT_LEN 1024
//  tri_mode_emac
tmemac_cfg_t tmemac_cfg;

// lightweight version of stdio-GETCHAR / !!!no HDR-file for inbyte.c!!!
char inbyte(void);

// MAIN
int main(void)
{
    // dec vars
    int result;
    
    // init
#ifndef MSIM
    init_platform();
#else
    ublaze_initial(); ublaze_wait(100);
#endif // MSIM
    
    // msg2usr
    xil_printf("Hello from MICROB\n\r");
    // w8
#ifndef MSIM
    inbyte();// w8 4 user
#endif // MSIM
    
    // prep cfg / MAC: {locally administered address}!!!
    tmemac_cfg.base     = XPAR_TMEMAC_0_BASEADDR;
    tmemac_cfg.mac_high = _MAC_ADDR_HIGH(0x02, 0x05);               //       02-05
    tmemac_cfg.mac_low  = _MAC_ADDR_LOW( 0x69, 0x03, 0x04, 0x05);   // 69-03-04-05
    tmemac_cfg.ip_addr  = _IP_ADDR(192,168,43,5);                   // !!!RFC6890: Priv-16 / RFC1918
    
    // net init
    result = net_init(  &tmemac_cfg, 
                        (XPAR_BRAM_0_BASEADDR + 0),
                        (XPAR_BRAM_0_BASEADDR + ETH_MAX_PKT_LEN));
    if (result) {
        xil_printf("ERR: net_init: %x\n\r", result);
        xil_printf("MICROB: exit\n\r");
        return -1;
    }
    
    // rx-buff-malloc
    char *buff = (char *)xil_malloc(ETH_MAX_PKT_LEN);
    if (!buff){
        xil_printf("ERR: xil_malloc\n\r");
        xil_printf("MICROB: exit\n\r");
        return -1;
    }
    
    // proc-loop
    while (1) {
        // proc
        result = net_input(buff);
        // check err
        if (result < 0) {
            xil_printf("ERR: net_input: %x\n\r", result);
            break;
        }
        // check rxd
        if (result) {
            // ARP
            eth_arp(buff);
            // IP-ICMP
            eth_ip(buff);
        }
    }
    // if we are here -> clean+msg2usr
    xil_free(buff);
    xil_printf("MICROB: exit\n\r");
    
    // Final
#ifndef MSIM
    cleanup_platform();
#else
    //ublaze_final();
#endif // MSIM
    return 0;
}
