#include <stdio.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netpacket/packet.h>
#include <net/ethernet.h>
#include <netinet/in.h>
#include <string.h>
#include <stdlib.h>
#include <sys/time.h>

#define MAC_ADD_FPGA 0x00,0x00,0x00,0x00,0x00,0x01
#define MAC_ADD_PC   0x00,0x00,0x00,0x00,0x00,0x02

#define num 8

const unsigned char sndhead[]={MAC_ADD_FPGA, MAC_ADD_PC, 0x00, 0x00};
const unsigned char mac_fpga[]={MAC_ADD_FPGA};

void printdata(char* str, unsigned char* buf1, int size);

int main(){
	int error_cnt=0;
	int frame_cnt=1000;
	long int frame_number, fn1=0, fn2=0, fn3=0;

	unsigned int sndlen=14+3+((unsigned int)(148*num/8));
	unsigned int rcvlen=14+3+((unsigned int)(156.25*num/8))+1;
	
	unsigned char sndbuf[sndlen];	//6+6+2+3+8*148
	unsigned char rcvbuf[rcvlen];	//actually is 96 = 6+6+2+3+[4*156.25]+1

	unsigned char* sndlentype = sndbuf + 12;
	unsigned char* sndframenumber = sndbuf + 14;
	unsigned char* snddata = sndbuf + 17;

	unsigned char* rcvlentype = rcvbuf + 12;	
	unsigned char* rcvframenumber = rcvbuf + 14;
	unsigned char* rcvdata = rcvbuf + 17;

	unsigned char* temppoint;

	int mSocketFD;
	struct ifreq ifstruct;
	struct sockaddr_ll sll;
	int retval = 0;

	struct timeval testtime;
	long int usec2, usec1;

	memcpy(sndbuf, sndhead, 14);

	// create
	mSocketFD = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (mSocketFD < 0){
		perror("socket()");
	}

	//struct ifreq ifstruct;
	strcpy(ifstruct.ifr_name, "eth2");
	retval = ioctl(mSocketFD, SIOCGIFINDEX, &ifstruct);
	if(retval == -1){
		perror("RAWSocket::open(): ioctl()");
	}

	//struct sockaddr_ll sll;
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifstruct.ifr_ifindex;

	// bind
	retval = bind(mSocketFD, (struct sockaddr *)&sll, sizeof(sll));
	if(retval == -1)
	{
		perror("RAWSocket::open(): bind()");
	}

	// set recive buffer size
	//int rcvbuflen = BUFFER_SIZE;
	int rcvbuflen = 4000;//442;//221;
	retval = setsockopt(mSocketFD, SOL_SOCKET, SO_RCVBUF, (char *)&rcvbuflen, sizeof(int));
	if (retval == -1)
	{
		perror("RAWSocket::read(): setsockopt()");
	}
	// set send buffer size
	//int sndbuflen = BUFFER_SIZE;
	int sndbuflen = 15000;
	retval = setsockopt(mSocketFD, SOL_SOCKET, SO_SNDBUF, (char *)&sndbuflen, sizeof(int));
	if (retval == -1)
	{
		perror("RAWSocket::read(): setsockopt()");
	}

	frame_number = 0;
	sndframenumber[0] = frame_number;
	sndframenumber[1] = frame_number >> 8;
	sndframenumber[2] = frame_number >> 16;
	
	temppoint=snddata;
	for(int i=0; i< sndlen-17; i++){
		if(frame_number%2==0) 
			*temppoint=0;//((((unsigned char)frame_number)&0x07)<<4)|(((unsigned char)frame_number)&0x07);
		else
			*temppoint= 0xff;
		temppoint++;
	}
	
	retval = send(mSocketFD, sndbuf, sndlen, 0);
	if (retval < 0)
	{
		perror("sendto()");
	}

	while( (frame_cnt>=0)&&( (retval = recv(mSocketFD, (void*)rcvbuf, rcvlen, 0)) >=0) ) {

		//printf("received data length: %d\n", retval);
		
		if (retval < 42){
			perror("recvfrom():");
			break;
		}

		
		fn3 = fn2;	fn2 = fn1;
		fn1 = (long int)(rcvbuf[16]<<16) + (rcvbuf[15]<<8) + rcvbuf[14];
		long int temp;


		frame_number ++;  frame_cnt--;
			sndframenumber[0] = frame_number;
			sndframenumber[1] = frame_number >> 8;
			sndframenumber[2] = frame_number >> 16;

		if (memcmp(mac_fpga, rcvbuf+6, 6) == 0)
		{
			gettimeofday(&testtime, NULL);	
			usec2=usec1;				
			usec1=testtime.tv_usec;

			temp=(usec1+1000000-usec2)%1000000;
			printf("%5ld\t%5ld\t%5ld\t%x", temp, fn2, fn1, fn1&0x07);

			if( fn2+1 != fn1){
				printf("\t%5ld\t*\n",frame_number);	
				error_cnt++;
			}else printf("\t%5ld\n", frame_number);

			printdata(NULL, rcvbuf,rcvlen);

			temppoint=snddata;
			for(int i=0; i< sndlen-17; i++){
				if(frame_number%2==0) 
					*temppoint=0;//((((unsigned char)frame_number)&0x07)<<4)|(((unsigned char)frame_number)&0x07);
				else
					*temppoint= 0xff;
				temppoint++;
			}

			retval = send(mSocketFD, sndbuf, sndlen, 0);
			if (retval < 0) perror("sendto()");
		}
		
	}
	printf("the total number of wrong frames is:%d\n", error_cnt);	
}


void printdata(char* str, unsigned char* buf1, int size)
{
	unsigned char temp=0;
	unsigned int i;
	unsigned char* buf=buf1;
	
	i=0;
	printf("%s:\n",str);
	if(size==0){
		printf("\t\tNot data!\n");
	}else{
		printf("\t\t");
		while((size>0)&&(i<512))
		{
			printf(" %02x",*buf);
			temp++; size--; buf++; i++;
			if(!(temp & 3))
			{
				if(temp==16)
				{
					temp=0;
					printf("\n\t\t");
				}else
					printf(" ");
			}
		}
		printf("\n");
	}
}
	
