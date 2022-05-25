//////////////////////////////////////////////////////////////////////////////////
// Company:          
// Engineer:        IK
// 
// Create Date:     11:35:01 03/21/2013 
// Design Name:     
// Module Name:     pcap_pkg
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

package pcap_pkg;
//////////////////////////////////////////////////////////////////////////////////
// 
localparam pcap_hdr_sz = 6*4; // 6DW
typedef struct packed {
    bit [31:0] magic_number;   /* magic number */
    bit [15:0] version_major;  /* major version number */
    bit [15:0] version_minor;  /* minor version number */
    bit [31:0] thiszone;       /* GMT to local correction */
    bit [31:0] sigfigs;        /* accuracy of timestamps */
    bit [31:0] snaplen;        /* max length of captured packets, in octets */
    bit [31:0] network;        /* data link type */
} pcap_hdr_t;
typedef union packed {
    pcap_hdr_t pcap_hdr;
    bit [0:pcap_hdr_sz-1] [7:0] data;
    //bit [pcap_hdr_sz-1:0] data;
} u_pcap_hdr_t;
// 
localparam pcaprec_hdr_sz = 4*4; // 4DW
typedef struct packed {
    bit [31:0] ts_sec;         /* timestamp seconds */
    bit [31:0] ts_usec;        /* timestamp microseconds */
    bit [31:0] incl_len;       /* number of octets of packet saved in file */
    bit [31:0] orig_len;       /* actual length of packet */
} pcaprec_hdr_t;
typedef union packed {
    pcaprec_hdr_t pcaprec_hdr;
    bit [0:pcaprec_hdr_sz-1] [7:0] data;
} u_pcaprec_hdr_t;
//////////////////////////////////////////////////////////////////////////////////
endpackage : pcap_pkg