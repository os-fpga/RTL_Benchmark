/*
 * fifo.h
 *
 *  Created on: Jun 27, 2014
 *      Author: AlexO
 */

#ifndef FIFO_H_
#define FIFO_H_

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE  1
#endif

#define MAKE_FIFO_INSTANCE(FIFO_NAME, FIFO_SIZE, ELEMENT_TYPE, LOCK, UNLOCK)\
\
int		FIFO_NAME##_head = 0;\
int		FIFO_NAME##_tail = 0;\
ELEMENT_TYPE	FIFO_NAME##_fifo[FIFO_SIZE];\
\
static inline int FIFO_NAME##_full()\
{\
	void* ctx = LOCK();\
	int ret_val = (FIFO_NAME##_tail==0 && FIFO_NAME##_head==FIFO_SIZE-1) || (FIFO_NAME##_head==FIFO_NAME##_tail-1);\
	UNLOCK(ctx);\
	return ret_val;\
}\
\
static inline int FIFO_NAME##_empty()\
{\
	void* ctx = LOCK();\
	int ret_val = (FIFO_NAME##_head == FIFO_NAME##_tail);\
	UNLOCK(ctx);\
	return ret_val;\
}\
\
static inline int FIFO_NAME##_put(ELEMENT_TYPE ELM)\
{\
	void* ctx = LOCK();\
	if (!((FIFO_NAME##_tail==0 && FIFO_NAME##_head==FIFO_SIZE-1) || (FIFO_NAME##_head==FIFO_NAME##_tail-1)))\
	{\
		FIFO_NAME##_fifo[FIFO_NAME##_head] = ELM;\
		if (FIFO_NAME##_head==(FIFO_SIZE-1))\
			FIFO_NAME##_head=0; \
		else \
			FIFO_NAME##_head++;\
		UNLOCK(ctx);\
		return TRUE;\
	}\
	UNLOCK(ctx);\
	return FALSE;\
}\
\
static inline int FIFO_NAME##_get(ELEMENT_TYPE* ELM)\
{\
	void* ctx = LOCK();\
	if (!(FIFO_NAME##_head == FIFO_NAME##_tail))\
	{\
		*ELM = FIFO_NAME##_fifo[FIFO_NAME##_tail];\
		if (FIFO_NAME##_tail==(FIFO_SIZE-1))\
			FIFO_NAME##_tail=0; \
		else \
			FIFO_NAME##_tail++;\
		UNLOCK(ctx);\
		return TRUE;\
	}\
	UNLOCK(ctx);\
	return FALSE;\
}\
\
static inline void FIFO_NAME##_clean()\
{\
	void* ctx = LOCK();\
	FIFO_NAME##_head = FIFO_NAME##_tail;\
	UNLOCK(ctx);\
}\



#endif /* FIFO_H_ */
