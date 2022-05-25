/* MTI_DPI */
#ifndef INCLUDED_SIMPLE
#define INCLUDED_SIMPLE

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif

#include "svdpi.h"

//
// main
DPI_LINK_DECL DPI_DLLESPEC
int
main();
//
// axi-direct
DPI_LINK_DECL int
axi_read(
    int iv_addr,
    int iv_be,
    int* ov_data);

DPI_LINK_DECL int
axi_write(
    int iv_addr,
    int iv_be,
    int ov_data);
//
// sw-hdl sync
DPI_LINK_DECL int
ublaze_initial();

DPI_LINK_DECL int
ublaze_final();

DPI_LINK_DECL int
ublaze_wait(
    int iv_value);

/*AXI-wrap*/
DPI_LINK_DECL 
unsigned int axi_read_(int iv_addr, int iv_be);
/*AXI-wrap*/

#endif // INCLUDED_SIMPLE
