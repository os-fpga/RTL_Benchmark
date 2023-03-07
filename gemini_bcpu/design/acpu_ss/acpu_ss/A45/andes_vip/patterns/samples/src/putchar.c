// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <inttypes.h>
#include "platform.h"
#include <sys/stat.h>


int outbyte(int c) {
	if (c == '\r') {
	}
	else if (c == '\n')
		DEV_SIM_CONTROL->COMMAND = SIM_CONTROL_SIG_END;
	else
		DEV_SIM_CONTROL->DISPLAY = (uint8_t)c;

	return (c);
}


int _fstat(int fd, struct stat *buf) {
	return 0;
}


int _write(int fd, const void *buf, int count) {
	if ((fd == 1) || (fd == 2)) {
		char *p = (char *)buf;
		int i;

		for (i = 0; i < count; i++)
			outbyte(*p++);

		return (i);
	}
	else {
		return 0;
	}
}

void nds_write(const unsigned char *buf, int size) {
	int i;
	for (i = 0; i < size; i++)
		outbyte(buf[i]);
}
