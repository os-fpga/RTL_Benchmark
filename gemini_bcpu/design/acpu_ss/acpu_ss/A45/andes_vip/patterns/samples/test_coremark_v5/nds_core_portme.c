// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <stdio.h>
#include <stdlib.h>
#include "coremark.h"
#if CALLGRIND_RUN
#include <valgrind/callgrind.h>
#endif

#if (MEM_METHOD==MEM_MALLOC)
#include <malloc.h>
void *portable_malloc(size_t size) {
	return malloc(size);
}
void portable_free(void *p) {
	free(p);
}
#else
void *portable_malloc(size_t size) {
	return NULL;
}
void portable_free(void *p) {
	p=NULL;
}
#endif

#if (SEED_METHOD==SEED_VOLATILE)
#if VALIDATION_RUN
	volatile ee_s32 seed1_volatile=0x3415;
	volatile ee_s32 seed2_volatile=0x3415;
	volatile ee_s32 seed3_volatile=0x66;
#endif
#if PERFORMANCE_RUN
	volatile ee_s32 seed1_volatile=0x0;
	volatile ee_s32 seed2_volatile=0x0;
	volatile ee_s32 seed3_volatile=0x66;
#endif
#if PROFILE_RUN
	volatile ee_s32 seed1_volatile=0x8;
	volatile ee_s32 seed2_volatile=0x8;
	volatile ee_s32 seed3_volatile=0x8;
#endif
	volatile ee_s32 seed4_volatile=ITERATIONS;
	volatile ee_s32 seed5_volatile=0;
#endif
#if USE_CLOCK
	#define NSECS_PER_SEC CLOCKS_PER_SEC
	#define EE_TIMER_TICKER_RATE 1000
#ifdef NDS32_SID
	#ifdef NDS32_RTLSIM
		#define CORETIMETYPE unsigned long
	#else  
		#define CORETIMETYPE unsigned long long
	#endif 
#else
#ifdef AG101P_TIMER
    #define CORETIMETYPE unsigned long long
#else    
	#define CORETIMETYPE clock_t 
#endif    
#endif
	#define MYTIMEDIFF(fin,ini) ((fin)-(ini))
	#define TIMER_RES_DIVIDER 1
	#define SAMPLE_TIME_IMPLEMENTATION 1
#elif defined(_MSC_VER)
	#define NSECS_PER_SEC 10000000
	#define EE_TIMER_TICKER_RATE 1000
	#define CORETIMETYPE FILETIME
	#define MYTIMEDIFF(fin,ini) (((*(__int64*)&fin)-(*(__int64*)&ini))/TIMER_RES_DIVIDER)
	#ifndef TIMER_RES_DIVIDER
	#define TIMER_RES_DIVIDER 1000
	#endif
	#define SAMPLE_TIME_IMPLEMENTATION 1
#elif HAS_TIME_H
	#define NSECS_PER_SEC 1000000000
	#define EE_TIMER_TICKER_RATE 1000
#ifdef NDS32_SID
	#define CORETIMETYPE unsigned long long
#else
#ifdef AG101P_TIMER
    #define CORETIMETYPE unsigned long long
#else    
	#define CORETIMETYPE struct timespec 
#endif    
#endif
#ifdef NDS32_SID
	#define MYTIMEDIFF(fin,ini) ((fin)-(ini))
#else
#ifdef AG101P_TIMER
    #define MYTIMEDIFF(fin,ini) ((fin)-(ini))
#else    
	#define MYTIMEDIFF(fin,ini) ((fin.tv_sec-ini.tv_sec)*(NSECS_PER_SEC/TIMER_RES_DIVIDER)+(fin.tv_nsec-ini.tv_nsec)/TIMER_RES_DIVIDER)
#endif    
#endif
	#ifndef TIMER_RES_DIVIDER
	#define TIMER_RES_DIVIDER 1000000
	#endif
	#define SAMPLE_TIME_IMPLEMENTATION 1
#else
	#define SAMPLE_TIME_IMPLEMENTATION 0
#endif
#define EE_TICKS_PER_SEC (NSECS_PER_SEC / TIMER_RES_DIVIDER)

#if SAMPLE_TIME_IMPLEMENTATION

#ifdef NDS32_SID
    static unsigned int pfm_c1[30], pfm_c2[30];
#endif
#ifdef AG101P_TIMER
#define TIMER1_BASE 0x98400000
    volatile unsigned int *timer_counter = (unsigned int*)TIMER1_BASE;
    volatile unsigned int *timer_load = (unsigned int*)(TIMER1_BASE+0x04);
    volatile unsigned int *timer_match1 = (unsigned int*)(TIMER1_BASE+0x08);
    volatile unsigned int *timer_match2 = (unsigned int*)(TIMER1_BASE+0x0c);
    volatile unsigned int *timer_control = (unsigned int*)(TIMER1_BASE+0x30);
    volatile unsigned int *timer_intrState = (unsigned int*)(TIMER1_BASE+0x34);
#endif
static CORETIMETYPE start_time_val, stop_time_val;



void start_time(void) {
#ifdef NDS32_SID
    #ifdef NDS32_RTLSIM
    	start_time_val = time ( (long *) 0);
    #else 
	int value = 65; 
    unsigned int pfm1, pfm2;
    int i;
    for (i=0; i<29; i++) {
        if (i != 11) {
            value = i * 0x410000 + 0x1c7;
            __asm volatile ("mtusr %0, $pfr3" :: "r" (value));
            __asm volatile ("isb");
            __asm volatile ("mfusr %0, $pfr1" : "=r" (pfm1));
            __asm volatile ("isb");
            __asm volatile ("mfusr %0, $pfr2" : "=r" (pfm2));
            __asm volatile ("isb");
            pfm_c1[i] = pfm1;
            pfm_c2[i] = pfm2;
        }

    }
    start_time_val = pfm_c2[0];
    #endif 
#else
#if AG101P_TIMER

    *timer_control = 0;                   
    *timer_intrState = 0;                 
    *timer_counter = 0;          
    *timer_load = 0;                      
    *timer_match1 = 0xffffffff;           
    *timer_match2 = 0xffffffff;           
    *timer_control = 0x201;               
    start_time_val = 0;
#else
	GETMYTIME(&start_time_val );      
#endif    
#endif
#if CALLGRIND_RUN
	CALLGRIND_START_INSTRUMENTATION
#endif
#if MICA
    asm volatile("int3");
#endif
}
void stop_time(void) {
#if CALLGRIND_RUN
	 CALLGRIND_STOP_INSTRUMENTATION 
#endif
#if MICA
    asm volatile("int3");
#endif
#ifdef NDS32_SID
    #ifdef NDS32_RTLSIM
    	stop_time_val = time ( (long *) 0);
    #else  
     unsigned int pfm1, pfm2;
     unsigned int value,i;
     unsigned long long total_cycles, total_instructions;
     for (i=0; i<29; i++) {
         if (i != 11) {
             value = i * 0x410000 + 0x1c7;
             __asm volatile ("mtusr %0, $pfr3" :: "r" (value));
             __asm volatile ("isb");
             __asm volatile ("mfusr %0, $pfr1" : "=r" (pfm1));
             __asm volatile ("isb");
             __asm volatile ("mfusr %0, $pfr2" : "=r" (pfm2));
             __asm volatile ("isb");
             if (i > 1) {
                 pfm_c1[i] = pfm1 - pfm_c1[i];
                 pfm_c2[i] = pfm2 - pfm_c2[i];
                 printf("pfm1_%u %u pfm2_%u %u ", i, pfm_c1[i],i, pfm_c2[i]);
             } else {
                 if (i == 0) {
                     total_cycles = (((unsigned long long)pfm1)*0x100000000L+(unsigned long long)pfm2) -
                         (((unsigned long long)pfm_c1[i])*0x100000000L+(unsigned long long)pfm_c2[i]);
                     printf("total_cycles: %llu ", total_cycles);
                     pfm_c1[i] = pfm1;
                     pfm_c2[i] = pfm2;
                     printf("pfm1 %u %u pfm2 %u %u ",pfm1, pfm2, pfm_c1[i], pfm_c2[i]);
                 } else {
                     total_instructions = (((unsigned long long)pfm1)*0x100000000L+(unsigned long long)pfm2) -
                         (((unsigned long long)pfm_c1[i])*0x100000000L+(unsigned long long)pfm_c2[i]);
                     printf("total_instructions: %llu ", total_instructions);
                 }
             }
         }
     }
     printf("\n");

     stop_time_val = ((((unsigned long long)pfm_c1[0])*0x100000000L+(unsigned long long)pfm_c2[0]));
     printf("start: %llu end: %llu\n",start_time_val,stop_time_val);
     #endif 
#else	 
#if AG101P_TIMER
     stop_time_val   = *timer_counter;
#else
	GETMYTIME(&stop_time_val );      
#endif    
#endif
}
CORE_TICKS get_time(void) {
	CORE_TICKS elapsed=(CORE_TICKS)(MYTIMEDIFF(stop_time_val, start_time_val));
	return elapsed;
}

secs_ret time_in_secs(CORE_TICKS ticks) {
#ifdef NDS32_SID
	secs_ret retval=((secs_ret)ticks) / 1000;
#else
#ifdef AG101P_TIMER
    secs_ret retval=((secs_ret)ticks) / 250000;
#else    
	secs_ret retval=((secs_ret)ticks) / (secs_ret)EE_TICKS_PER_SEC;
#endif    
#endif
	return retval;
}
#else 
#error "Please implement timing functionality in core_portme.c"
#endif 

ee_u32 default_num_contexts=MULTITHREAD;

void portable_init(core_portable *p, int *argc, char *argv[])
{
#if PRINT_ARGS
	int i;
	for (i=0; i<*argc; i++) {
		ee_printf("Arg[%d]=%s\n",i,argv[i]);
	}
#endif
	if (sizeof(ee_ptr_int) != sizeof(ee_u8 *)) {
                ee_printf("ERROR! Please define ee_ptr_int to a type that holds a pointer!\n");

	}
	if (sizeof(ee_u32) != 4) {
		ee_printf("ERROR! Please define ee_u32 to a 32b unsigned type!\n");
	}
#if (MAIN_HAS_NOARGC && (SEED_METHOD==SEED_ARG))
	ee_printf("ERROR! Main has no argc, but SEED_METHOD defined to SEED_ARG!\n");
#endif
	
#if (MULTITHREAD>1) && (SEED_METHOD==SEED_ARG)
	int nargs=*argc,i;
	if ((nargs>1) && (*argv[1]=='M')) {
		default_num_contexts=parseval(argv[1]+1);
		if (default_num_contexts>MULTITHREAD)
			default_num_contexts=MULTITHREAD;
		--nargs;
		for (i=1; i<nargs; i++)
			argv[i]=argv[i+1];
		*argc=nargs;
	}
#endif 
	p->portable_id=1;
}
void portable_fini(core_portable *p)
{
	p->portable_id=0;
}

#if (MULTITHREAD>1)

#if USE_PTHREAD
ee_u8 core_start_parallel(core_results *res) {
	return (ee_u8)pthread_create(&(res->port.thread),NULL,iterate,(void *)res);
}
ee_u8 core_stop_parallel(core_results *res) {
	void *retval;
	return (ee_u8)pthread_join(res->port.thread,&retval);
}
#elif USE_FORK
static int key_id=0;
ee_u8 core_start_parallel(core_results *res) {
	key_t key=4321+key_id;
	key_id++;
	res->port.pid=fork();
	res->port.shmid=shmget(key, 8, IPC_CREAT | 0666);
	if (res->port.shmid<0) {
		ee_printf("ERROR in shmget!\n");
	}
	if (res->port.pid==0) {
		iterate(res);
		res->port.shm=shmat(res->port.shmid, NULL, 0);
		if (res->port.shm == (char *) -1) {
			ee_printf("ERROR in child shmat!\n");
		} else {
			memcpy(res->port.shm,&(res->crc),8);
			shmdt(res->port.shm);
		}
		exit(0);
	}
	return 1;
}
ee_u8 core_stop_parallel(core_results *res) {
	int status;
	pid_t wpid = waitpid(res->port.pid,&status,WUNTRACED);
	if (wpid != res->port.pid) {
		ee_printf("ERROR waiting for child.\n");
		if (errno == ECHILD) ee_printf("errno=No such child %d\n",res->port.pid);
		if (errno == EINTR) ee_printf("errno=Interrupted\n");
		return 0;
	}
	res->port.shm=shmat(res->port.shmid, NULL, 0);
	if (res->port.shm == (char *) -1) {
		ee_printf("ERROR in parent shmat!\n");
		return 0;
	} 
	memcpy(&(res->crc),res->port.shm,8);
	shmdt(res->port.shm);
	return 1;
}
#elif USE_SOCKET
static int key_id=0;
ee_u8 core_start_parallel(core_results *res) {
	int bound, buffer_length=8;
	res->port.sa.sin_family = AF_INET;
	res->port.sa.sin_addr.s_addr = htonl(0x7F000001);
	res->port.sa.sin_port = htons(7654+key_id);
	key_id++;
	res->port.pid=fork();
	if (res->port.pid==0) { 
		iterate(res);
		res->port.sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
		if (-1 == res->port.sock)    {
			ee_printf("Error Creating Socket");
		} else {
			int bytes_sent = sendto(res->port.sock, &(res->crc), buffer_length, 0,(struct sockaddr*)&(res->port.sa), sizeof (struct sockaddr_in));
			if (bytes_sent < 0)
				ee_printf("Error sending packet: %s\n", strerror(errno));
			close(res->port.sock); 
		}
		exit(0);
	} 
	res->port.sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
	bound = bind(res->port.sock,(struct sockaddr*)&(res->port.sa), sizeof(struct sockaddr));
	if (bound < 0)
		ee_printf("bind(): %s\n",strerror(errno));
	return 1;
}
ee_u8 core_stop_parallel(core_results *res) {
	int status;
	int fromlen=sizeof(struct sockaddr);
	int recsize = recvfrom(res->port.sock, &(res->crc), 8, 0, (struct sockaddr*)&(res->port.sa), &fromlen);
	if (recsize < 0) {
		ee_printf("Error in receive: %s\n", strerror(errno));
		return 0;
	}
	pid_t wpid = waitpid(res->port.pid,&status,WUNTRACED);
	if (wpid != res->port.pid) {
		ee_printf("ERROR waiting for child.\n");
		if (errno == ECHILD) ee_printf("errno=No such child %d\n",res->port.pid);
		if (errno == EINTR) ee_printf("errno=Interrupted\n");
		return 0;
	}
	return 1;
}
#else 
#error "Please implement multicore functionality in core_portme.c to use multiple contexts."
#endif 
#endif
