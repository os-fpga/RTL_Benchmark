//File name : define.h
//Description :
//
#ifndef DEFINE_H
#define DEFINE_H

#define BUSY		1
#define IDLE		0
#define FULL		1
#define EMPTY		1

#define DELAY		1
#define FIFO_DEEP	16
#define FIFO_STAGE	3

#define FAIL		2
#define SUCCEED		1
#define EIs			0
#define OIs			1

#define REN			0x10000
#define WEN			0x10000

#define FIFO1		0x01
#define FIFO2		0x02
#define FIFO3		0x04


#define	EAST_TO_CORE	0x0001
#define EAST_TO_SOUTH	0x0002
#define EAST_TO_NORTH	0x0004

#define WEST_TO_CORE    0x0008
#define WEST_TO_SOUTH	0x0010
#define WEST_TO_NORTH   0x0020

#define SOUTH_TO_CORE	0x0040
#define	SOUTH_TO_EAST	0x0080
#define	SOUTH_TO_WEST	0x0100

#define NORTH_TO_CORE	0x0200
#define	NORTH_TO_EAST	0x0400
#define	NORTH_TO_WEST	0x0800

#define	CORE_TO_EAST	0x1000
#define	CORE_TO_WEST	0x2000
#define	CORE_TO_SOUTH	0x4000
#define	CORE_TO_NORTH	0x8000

#define PSW1 0x001
#define PSW2 0x002
#define PSW3 0x004
#define PSW4 0x008
#define PSW5 0x010
#define PSW6 0x020
#define PSW7 0x040
#define PSW8 0x080
#define PSW9 0x100
#define PSW10 0x200
#define PSW11 0x400
#define PSW12 0x800

#endif
