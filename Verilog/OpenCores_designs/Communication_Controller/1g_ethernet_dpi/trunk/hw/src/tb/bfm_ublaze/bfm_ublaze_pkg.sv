//////////////////////////////////////////////////////////////////////////////////
// Company:         
// Engineer:        IK
// 
// Create Date:     11:35:01 03/21/2013 
// Design Name:     
// Module Name:     bfm_ublaze_pkg
// Project Name:    
// Target Devices:  
// Tool versions:   
// Description:     
//                  
//                  
// Revision: 
// Revision 0.01 - File Created,
//
//////////////////////////////////////////////////////////////////////////////////

package bfm_ublaze_pkg;
//////////////////////////////////////////////////////////////////////////////////
// 
typedef enum {
    READ,
    WRITE
} trans_t;

typedef struct {
    int addr;
    int be;
    int data; // in-write => in case of {axi-trans == AXI-WRITE} / out-read => in case of {axi-trans == AXI-READ}
} trans_param_t;

typedef struct {
    trans_t trans; // type
    int trans_idx; // idx
    trans_param_t trans_param; // io-param
} mailbox_t;

//////////////////////////////////////////////////////////////////////////////////
endpackage : bfm_ublaze_pkg