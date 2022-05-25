#include <stdio.h>

#include <arpa/inet.h> // sockaddr, ..  / ?? net/if.h
#include <linux/if.h>
#include <linux/if_tun.h>
#include <string.h> // memset, ..

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h> // open, ..

#include <sys/ioctl.h> // ioctl
#include <errno.h> // 

#include <stdlib.h> // system


/* */
#include "eth_host_bfm.h" // DPI-C
#include "ether.h" // ether_tx, ether_rx_ok, ether_rx
/* */


// ??
#define BUFSIZE     2048 // 2KB
// ??
char buffer[BUFSIZE];


// tap-if READ
int cread(int fd, char *buf, int n){
  
  int nread;

  if((nread=read(fd, buf, n))<0){
    perror("Reading data");
    exit(1);
  }
  return nread;
}
// tap-if WRITE
int cwrite(int fd, char *buf, int n){
  
  int nwrite;

  if((nwrite=write(fd, buf, n))<0){
    perror("Writing data");
    exit(1);
  }
  return nwrite;
}

// MAIN
int test_bfm(void)
{   // dec vars
    struct ifreq ifr;
    int tap_fd, err;
    char tap_nm[IFNAMSIZ] = "tap0";
    
    // prep
    memset(&ifr, 0, sizeof(ifr));
    tap_fd = -1;
    
    // open
    tap_fd = open("/dev/net/tun", O_RDWR);
    if( tap_fd < 0 ) {
        printf("ERR0: fd=%x\n", tap_fd);
        return -1;
    }
    // cfg: {tap-if} + {no-packet-info}
    ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
    strncpy(ifr.ifr_name, tap_nm, IFNAMSIZ);    
    err = ioctl(tap_fd, TUNSETIFF, (void *)&ifr); // tun_set_iff: name + flags
    if( err < 0 ) { 
        int errsv = errno;
        printf("ERR1: fd=%x, errsv=%x :  %s\n", tap_fd, errsv, strerror(errsv));
        close(tap_fd);
        return -2;
    }
    // msg2usr
    printf("ifr_name=%s\n", ifr.ifr_name);
    //printf("ifr_flags=%x\n", ifr.ifr_flags);

    // tap_fd == 'O_NONBLOCK'
    int flags = fcntl(tap_fd, F_GETFL, 0);
    fcntl(tap_fd, F_SETFL, flags | O_NONBLOCK);

    // main-loop
    int idx=0;
    while (1) {
        
        int ret;
        fd_set rd_set;
        struct timeval timeout;
        
        timeout.tv_sec=0; // no-wait, just check
        timeout.tv_usec=0;
        FD_ZERO(&rd_set);
        FD_SET(tap_fd, &rd_set);
        
        // HDL-time-consumption!!!
        host_delay(10);
        
        // sw-wait
        ret = select(tap_fd + 1, &rd_set, NULL, NULL, &timeout); // man7.org: if timeout is NULL, select() can block indefinitely...
        if ( ret < 0 ) {
            int errsv = errno;
            if (errsv == EINTR) { // EINTR -> not an ERR in curr situation
                //printf("EINTR\n");
                continue;
            } 
            if (errsv == EAGAIN) { // EAGAIN -> nothing to read
                // printf("EAGAIN\n");
                continue;
            } else { // all others -> ERR-case
                printf("ERR4: fd=%x, errsv=%x :  %s\n", tap_fd, errsv, strerror(errsv));
                close(tap_fd);
                return -5;
            }
        }
        
        // check TAP-RX
        if(FD_ISSET(tap_fd, &rd_set)) {
            int nread = cread(tap_fd, &buffer[0], BUFSIZE);
            //printf("TAP-RD: nread=%03x\n", nread);
            if (nread) {
                ether_tx(&buffer[0], nread);
            } else {
                printf("FD_ISSET: nread=%x\n", nread);
            }
            //if (idx == 32) break;
        }
        
        // check TAP-TX
        if (ether_rx_ok()) {
            int nwrite_0;
            ether_rx(&buffer[0], &nwrite_0);
            int nwrite_1 = cwrite(tap_fd, &buffer[0], nwrite_0);
        }
        
    }
    // end / ;)
    printf("close TAP\n");
    close(tap_fd);
    
    // Final
    return 0;
}
