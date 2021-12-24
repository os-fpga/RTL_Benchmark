/* const.v
 * This file contains all the global defines used by all
 * Verilog modules.
 */
 
`define FLIT_WIDTH      36
`define CREDIT_WIDTH    11
`define TS_WIDTH        10
`define ADDR_WIDTH      8
`define VC_WIDTH        1
`define BW_WIDTH        8
`define LAT_WIDTH       8
`define ADDR_DPID       7:5     // DestPart ID
`define ADDR_NPID       4:0     // Node and port ID
`define F_HEAD          35      // Head flit
`define F_TAIL          34      // Tail flit
`define F_MEASURE       33      // Measurement flit
`define F_FLAGS         35:33
`define F_TS            32:23
`define F_DEST          22:15   // Does not include port ID
`define F_SRC_INJ       14:5
`define F_OPORT         4:2
`define F_OVC           1:0

`define A_WIDTH         11
`define A_DPID          10:7
`define A_NID           6:3     // 4-bit local node ID
`define A_PORTID        2:0
`define A_FQID          6:0     // 4-bit local node ID + 3-bit port ID
`define A_DNID          10:3    // 8-bit global node ID

// Packet descriptor
`define P_SRC           7:0     // 8-bit address
`define P_DEST          15:8
`define P_SIZE          18:16   // 3-bit packet size
`define P_VC            20:19   // 2-bit VC ID
`define P_INJ           30:21   // 10-bit timestamp
`define P_MEASURE       31
`define P_SIZE_WIDTH    4

