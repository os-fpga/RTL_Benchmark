
#ifndef __INTERRUPT_H
#define __INTERRUPT_H

#include <inttypes.h>
#include "platform.h"
#include "asm-interrupt.h"

//typedef void (*nds_handler_p)(uint32_t intr_no);
typedef void (*nds_interrupt_handler_p)(uint32_t intr_no);
typedef void (*nds_exception_handler_p)(SAVED_CONTEXT *context);
typedef void (*nds_intr_setup_p)(uint32_t intr_no, nds_interrupt_handler_p isr);
typedef void (*nds_evic_intr_setup_p)(uint32_t intr_no, nds_interrupt_handler_p isr, uint32_t trigmode, uint32_t triglevel);

extern nds_interrupt_handler_p        intr_handler_tab[INTERRUPT_NO];
extern nds_interrupt_handler_p         nmi_handler_tab[NMI_NO];
extern nds_exception_handler_p general_exc_handler_tab[GENERAL_EXC_NO];

extern nds_interrupt_handler_p intr_enable_ptr;
extern nds_interrupt_handler_p intr_disable_ptr;
extern nds_interrupt_handler_p intr_clear_ptr;
extern nds_intr_setup_p intr_setup_ptr;
extern nds_evic_intr_setup_p evic_intr_setup_ptr;
// For ldma interruption test
extern nds_interrupt_handler_p intr_enable_gie_ptr;
extern nds_interrupt_handler_p ilm_en_addr_based;
extern nds_interrupt_handler_p set_dma_move_data_to_ext_mem;
extern nds_interrupt_handler_p check_dma_st_ptr; 

#define TM_LEVEL	0
#define TM_EDGE		1

#define TL_HIGH		0
#define TL_RISING	0
#define TL_LOW		1
#define TL_FALLING	1

#endif // __INTERRUPT_H

