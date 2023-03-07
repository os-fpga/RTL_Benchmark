
#include <stdio.h>
#include <stdarg.h>
#include <inttypes.h>

#include "core_v5.h"
#include "platform.h"
#include "ndslib.h"
#include "interrupt.h"

void ProgramSkipUser() {
	skip("'RISC-V Float-Point Extension' should be configured to run this test.\n");
}

void skip(const char *fmt, ...) {
	va_list va;

	va_start(va, fmt);
	vprintf(fmt, va);
	va_end(va);

	DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_SKIPPED;
	while(1);
}

