#ifndef __CLUSTER_H__
#define __CLUSTER_H__

#include "general.h"

#ifndef MMSC_CFG_L2CMP_CFG_MASK
# define MMSC_CFG_L2CMP_CFG_MASK	(BIT_MASK(13, 13))
#endif

#ifndef MMSC_CFG_L2C_MASK
# define MMSC_CFG_L2C_MASK	        (BIT_MASK(14, 14))
#endif

#ifndef MMSC_CFG_IOCP_MASK
# define MMSC_CFG_IOCP_MASK	        (BIT_MASK(15, 15))
#endif

#ifndef MMSC_CFG_CORE_PCLUS_MASK
# define MMSC_CFG_CORE_PCLUS_MASK	(BIT_MASK(19, 16))
#endif

int check_cluster_exist(void);
int check_l2c_exist(void);
int check_iocp_exist(void);
int get_core_pclus(void);
void wait_l2c_init(void);
void enter_cache_coherent_mode(unsigned int);
void leave_cache_coherent_mode(unsigned int, unsigned int);
void set_core_i_reset_vector (uint32_t, uint32_t, uint32_t); 
#endif // __CLUSTER_H__
