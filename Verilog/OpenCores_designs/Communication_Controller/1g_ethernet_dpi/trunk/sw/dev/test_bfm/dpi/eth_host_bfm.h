/* MTI_DPI */
#ifndef INCLUDED_ETH_HOST_BFM
#define INCLUDED_ETH_HOST_BFM

#ifdef __cplusplus
#define DPI_LINK_DECL  extern "C" 
#else
#define DPI_LINK_DECL 
#endif

#include "svdpi.h"

//
// test-bfm / used in hdl-backend for Lin-tap IF
DPI_LINK_DECL DPI_DLLESPEC
int
test_bfm();
//
// BFM ETH READ, from HDL
DPI_LINK_DECL int
eth_frm_read_len(
    int* ov_len);

DPI_LINK_DECL int
eth_frm_read(
    int* ov_data,
    int iv_position);
//
// BFM ETH WRITE, to HDL
DPI_LINK_DECL int
eth_frm_write_len(
    int iv_len);

DPI_LINK_DECL int
eth_frm_write(
    int iv_data,
    int iv_position);
//
// CPP-HDL sync
DPI_LINK_DECL int
host_initial();

DPI_LINK_DECL int
host_delay(
    int iv_data);

DPI_LINK_DECL int
host_final();

#endif // INCLUDED_ETH_HOST_BFM
