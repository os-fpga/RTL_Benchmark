// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


#include "interrupt.h"

nds_interrupt_handler_p intr_enable_ptr = 0;
nds_interrupt_handler_p intr_disable_ptr = 0;
nds_interrupt_handler_p intr_clear_ptr = 0;
nds_intr_setup_p intr_setup_ptr = 0;
nds_evic_intr_setup_p evic_intr_setup_ptr = 0;

