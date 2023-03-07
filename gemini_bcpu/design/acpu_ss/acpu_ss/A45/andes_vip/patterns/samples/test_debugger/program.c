// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"

#define PROG_READY_MAGIC_NUM    0x89abcdef

#if defined(AE250_OSCH_PERIOD)
	#define OSCH_MHZ (1000/AE250_OSCH_PERIOD)
#elif defined(AE350_OSCH_PERIOD)
	#define OSCH_MHZ (1000/AE350_OSCH_PERIOD)
#else
	#define OSCH_MHZ (1000/25)
#endif

#ifdef NDS_JTAG_TCK_KHZ
	#define CLK_RATIO (OSCH_MHZ/(NDS_JTAG_TCK_KHZ/1000))
#else
	#define CLK_RATIO (OSCH_MHZ/10)
#endif

#define TIMEOUT_EXTEND (1000/CLK_RATIO)

#ifndef NDS_TIMEOUT_COUNT
#ifdef AE250_JTAG_TWOWIRE
#define NDS_TIMEOUT_COUNT (1200000 * TIMEOUT_EXTEND)
#else	
#ifdef PLATFORM_JTAG_TWOWIRE
#define NDS_TIMEOUT_COUNT (600000 * TIMEOUT_EXTEND)
#else	
#define NDS_TIMEOUT_COUNT (400000 * TIMEOUT_EXTEND)
#endif	
#endif	
#endif	


int main (int argc, char** argv) {

#ifdef PLATFORM_NO_DEBUG_SUPPORT
	skip("'Debug Support' should be configured to run this test.\n");
#endif

        DEV_SIM_CONTROL->TEMP7 = PROG_READY_MAGIC_NUM;

	volatile int	i;

	for (i = 0; i < NDS_TIMEOUT_COUNT; i++)
		;

	exit(10);
	return 1;
}

