
#include "simple.h"

/*AXI-wrap*/
unsigned int axi_read_(int iv_addr, int iv_be)
{ int ov_data=-1; axi_read(iv_addr, iv_be, &ov_data); return ov_data; }
