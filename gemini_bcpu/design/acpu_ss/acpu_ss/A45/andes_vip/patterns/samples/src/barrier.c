// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


volatile int barrier_arrive_counter __attribute__((section(".sharedata"))) = 0;
volatile int barrier_leave_counter  __attribute__((section(".sharedata"))) = 0;
volatile int barrier_flag           __attribute__((section(".sharedata"))) = 0;
volatile int barrier_lock           __attribute__((section(".sharedata"))) = 0;

static inline int spin_is_locked(void) {
        return (barrier_lock != 0);
}

static inline int spin_trylock(void) {
	int tmp = 1, busy;

	__asm__ __volatile__ (
		"	amoswap.w %0, %2, %1\n"
		"       fence\n"
		: "=r" (busy), "+A" (barrier_lock)
		: "r" (tmp)
		: "memory");

	return !busy;
}

static inline void spin_lock(void) {
	while (1) {
		if (spin_is_locked())
			continue;

		if (spin_trylock())
			break;
	}
}

static inline void spin_unlock(void) {
        __asm__ __volatile__ ("fence");
        barrier_lock = 0;
}

void barrier(unsigned int n) {
        if (n <= 1)
                return;
        spin_lock();
        if (barrier_arrive_counter == 0) {
                spin_unlock();
                while (barrier_leave_counter != 0);
                spin_lock();
                barrier_flag = 0;
        }
        barrier_arrive_counter++;
        if (barrier_arrive_counter == n) {
                barrier_arrive_counter = 0;
                barrier_leave_counter = 0;
                __asm__ __volatile__ ("fence");
                barrier_flag = 1;
        }
        spin_unlock();
        
        while (barrier_flag == 0);
        spin_lock();
        barrier_leave_counter++;
        if (barrier_leave_counter == n)
                barrier_leave_counter = 0;
        spin_unlock();
}
