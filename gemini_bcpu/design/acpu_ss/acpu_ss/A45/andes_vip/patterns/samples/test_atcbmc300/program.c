// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include <stdio.h>
#include <inttypes.h>

#include "platform.h"
#include "ndslib.h"

typedef struct dev_info_t {
	uintptr_t base;
	uint32_t id;
	char *name;
	struct dev_info_t *next;
} dev_info_s, *dev_info_p;


dev_info_p dev_list_head = 0;
dev_info_p dev_list_tail = 0;


#ifdef AE350_BUS_ENUM_ENABLE
void add_dev(uintptr_t base, uint32_t id, char *name) {

	dev_info_p dev = (dev_info_p)malloc(sizeof(dev_info_s));

	if (!dev) exit(-1);

	dev->base = base;
	dev->id = id;
	dev->name = name;
	dev->next = 0;

	if (dev_list_head == 0) {
		dev_list_head = dev;
		dev_list_tail = dev;
	} else {
		dev_list_tail->next = dev;
		dev_list_tail = dev;
	}
}
#else
#define add_dev(x,y,z) 
#endif

void enum_dev(uintptr_t dev_base) {
	volatile uint32_t *dev_p = (uint32_t *)dev_base;
	uint32_t dev_id;
	uint32_t read_data1, read_data2, write_data;
	uint8_t memory_mode, writable;
	int i;

	if ((uintptr_t)dev_p == SPI1_MEM_BASE) 
		return;
	if ((uintptr_t)dev_p == DTROM_BASE) 
		return;

	write_data = rand();
	*dev_p = write_data;
	read_data1 = *dev_p;
	if (read_data1 != write_data) {
		memory_mode = 0x0;
	} else {
		memory_mode = 0x1;
	}
	write_data = (~write_data);
	*dev_p = write_data;
	read_data2 = *dev_p;
	if (read_data2 != write_data) {
		memory_mode = memory_mode;
	} else {
		memory_mode = memory_mode | 0x2;
	}
	if (read_data1 != read_data2) {
		writable = 0x1;
	} else {
		writable = 0x0;
	}
	dev_id = read_data2;

	if (!writable) {
		if ((dev_id >> 8) == ATCBMC300_VER_ID_DEFAULT) {
			ATCBMC300_RegDef * bmc = (ATCBMC300_RegDef *)dev_base;

			if (dev_base != BMC_BASE) {
				exit(1);
			}
			add_dev(dev_base, dev_id, "ATCBMC");

			for (i = 31; i >= 1; i--) {	
				uintptr_t base_size = bmc->SLV[i];

				if (base_size & 0xff) {
					enum_dev((base_size >> 8) << 8);
				}
			}
		}

		else if ((dev_id >> 8) == ATCBUSDEC200_VER_ID_DEFAULT) {
			ATCBUSDEC200_RegDef * brg = (ATCBUSDEC200_RegDef *)dev_base;

			if (dev_base != AHBDEC_BASE) {
				exit(2);
			}
			add_dev(dev_base, dev_id, "ATCBUSDEC");

			for (i = 0; i < 30; i++) { 
				uint32_t base_size = brg->SLV[i];

				if (base_size & 0xff) {
					enum_dev(dev_base | ((base_size >> 8) << 8));
				}
			}
		}

		else if ((dev_id >> 8) == ATCAPBBRG100_VER_ID_DEFAULT) {
			ATCAPBBRG100_RegDef * brg = (ATCAPBBRG100_RegDef *)dev_base;

			if (dev_base != APBBRG_BASE) {
				exit(2);
			}
			add_dev(dev_base, dev_id, "ATCAPBBRG");

			for (i = 0; i < 31; i++) {
				uint32_t base_size = brg->SLV[i];

				if (base_size & 0xff) {
					enum_dev(dev_base | ((base_size >> 8) << 8));
				}
			}
		}

		else if ((dev_id >> 8) == ATCDMAC300_VER_ID_DEFAULT) {
			if (dev_base != DMAC_BASE) {
				exit(4);
			}
			add_dev(dev_base, dev_id, "ATCDMAC");
		}

		else if ((dev_id >> 8) == ATCSPI200_IDREV_ID_DEFAULT) {
			if ((dev_base != SPI1_BASE) && (dev_base != SPI2_BASE)) {
				exit(5);
			}
			add_dev(dev_base, dev_id, "ATCSPI");
		}

		else if ((dev_id >> 8) == ATCUART100_IDREV_ID_DEFAULT) {
			if ((dev_base != UART1_BASE) && (dev_base != UART2_BASE)) {
				exit(6);
			}
			add_dev(dev_base, dev_id, "ATCUART");
		}

		else if ((dev_id >> 8) == ATCIIC100_IDREV_ID_DEFAULT) {
			if (dev_base != I2C_BASE) {
				exit(7);
			}
			add_dev(dev_base, dev_id, "ATCIIC");
		}

		else if ((dev_id >> 8) == (ATCGPIO100_IDREV_DEFAULT >> 8)) {
			if (dev_base != GPIO_BASE) {
				exit(8);
			}
			add_dev(dev_base, dev_id, "ATCGPIO");
		}

		else if ((dev_id >> 8) == ATCWDT200_IDREV_ID_DEFAULT) {
			if (dev_base != WDT_BASE) {
				exit(9);
			}
			add_dev(dev_base, dev_id, "ATCWDT");
		}

		else if ((dev_id >> 8) == (ATCRTC100_IDREV_ID_DEFAULT >> 8)) {
			if (dev_base != RTC_BASE) {
				exit(10);
			}
			add_dev(dev_base, dev_id, "ATCRTC");
		}

		else if ((dev_id >> 8) == (ATCPIT100_VER_DEFAULT >> 8)) {
			if (dev_base != PIT_BASE) {
				exit(11);
			}
			add_dev(dev_base, dev_id, "ATCPIT");
		}

		else if ((dev_id >> 12) == 0x41453) {
			if (dev_base != SMU_BASE) {
				exit(12);
			}
			add_dev(dev_base, dev_id, "AE");
		}

		else {
			add_dev(dev_base, dev_id, "Unknown");
		}
	}
	else if (memory_mode == 0x3) {
		add_dev(dev_base, 0, "Memory");
	}
}

int main(int argc, char** argv) {
	if ((*(uint32_t *)DEV_BMC & 0xffffff00) != 0x00003000)
		skip("'AXI Bus Matrix' should be configured to run this test.\n");

#ifdef AE350_BUS_ENUM_ENABLE
	dev_info_p dev;
#endif

	enum_dev(BMC_BASE);

#ifdef AE350_BUS_ENUM_ENABLE
	for (dev = dev_list_head; dev; dev = dev->next) {
		if (dev->id == 0x0) {
			printf("@0x%08x: %s\n", dev->base, dev->name);
		} else {
			printf("@0x%08x: ID=0x%08x (%s%03x)\n", dev->base, dev->id, dev->name, (dev->id >> 4) & 0xfff);
		}
	}
#endif
	return 0;
}

