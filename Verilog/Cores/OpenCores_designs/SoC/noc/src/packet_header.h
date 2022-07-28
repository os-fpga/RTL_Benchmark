#ifndef PACKET_HEADER_H
#define PACKET_HEADER_H

//Message : [Packet|Packet|Packet|.....]
//Packet  : [Head flit|Body flit|Body flit|....|Tail flit]
//Flit	  : [|Phit|Phit|....]
//|dst_addr|flit_num|src_addr|data|
//
//Null space is "000000000"

#define FLIT_SIZE		16
#define OI_FLIT_SIZE	16
#define FLIT_TYPE(x)	x<<15
#define FLIT_DST(addr)	addr<<14
#define PKT_SIZE(size)	size<<7

//			Switching Table.
//WEST   EAST   SOUTH   NORTH   CORE
//
#define CORE    0
#define WEST    1
#define EAST    2
#define NORTH   3
#define SOUTH   4

#define _HEAD_FLIT	0x00
#define _BODY_FLIT	0x01
#define _TAIL_FLIT	0x02

#define R_FLAG		0x20000

typedef struct HEAD_FLIT{
	//LSB
	unsigned sequence	: 4;		//The sequence of flits.
	unsigned pkt_size	: 3;		//The number of flits. 2^4 = 16 Bytes.
	unsigned dst_addr	: 6;		//Destination address 2^6 = 64 address,so that is 64 tiles.
	unsigned conn_type	: 1;		//'1' is optical interconnects and '0' is electrical interconnects.
	unsigned type		: 2;		//'0' is header flit, '1' is body flit, and '2' is tail flit.
	//MSB
};

typedef struct BODY_FLIT{
	unsigned data		: 14;
	unsigned type		: 2;
};

typedef struct PACKET{
	HEAD_FLIT head;
	unsigned short *data;
};

#endif
