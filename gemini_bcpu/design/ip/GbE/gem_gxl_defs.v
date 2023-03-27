//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           gem_defs.v
//   Module Name:        N/A
//
//   Release Revision:   r1pxx
//   Release SVN Tag:    gem_detxxxx_r1pxx
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP701x
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description :       This is the verilog defines file that reflects the
//                       selected design configuration
//
//------------------------------------------------------------------------------
  

//  ------------ Main HOST/LINK Interface Configuration Options ----------

// Host Interface Selection
// Select between a DMA or a fixed latency streaming FIFO interface.
// This option selects between a DMA, or a fixed low latency FIFO interface. 
// Comment the following to include an AHB/AXI DMA in the design
//`define gem_ext_fifo_interface


// Additional FIFO Interfaces 1
// Use this option to add a TX/RX FIFO interface, allowing user selection of DMA or 
// FIFO host interface
// This cannot be used with the gem_tx_add_fifo_if feature and the main interface 
// selection must be set to include a packet buffer DMA. This option will then 
// provide an additional physical FIFO interface, with software selecting the 
// interface during initialization (as a static select). Unless the user has a 
// requirement for FIFO interfaces, the recommendation would be to not include this 
// option.
// Leave the following commented if you do not require any additional host 
// interfaces on top of the default
//`define gem_host_if_soft_select


// Additional FIFO Interfaces 2
// Use this option to add an external TX FIFO interface, working in conjunction 
// with the DMA
// This cannot be used with the gem_host_if_soft_select feature and the main 
// interface selection must be set to include a packet buffer DMA. It is possible 
// to select the DMA as the primary interface, but include a secondary TX FIFO 
// interface for specific fixed latency transmit traffic. In this mode, the traffic 
// sent to the TX FIFO interface will be prioritized. Unless the user has a 
// requirement for FIFO interfaces, the recommendation would be to not include this 
// option.
// Leave the following commented if you do not require any additional host 
// interfaces on top of the default
//`define gem_tx_add_fifo_if


// PCS Selection
// Select whether to include the 1000BASE-X/SGMII PCS in the design.
// The GEM includes an optionally integrated physical coding sublayer (PCS) which 
// provides a TBI for connection to a PHY transceiver. It is operational when the 
// PCS interface is selected through the PCS select bit in the network 
// configuration register. Components of the PCS sub-system include a PCS 
// transmitter, 8B/10B encoder, PCS receiver, 8B/10B decoder and auto-negotiation. 
// The PCS may also be configured to operate in SGMII mode which allows the GEM to 
// be used as a building block to support an SGMII interface to an external PHY. 
// Note that for full SGMII support, an external SerDes (not supplied) is also 
// required.
// Comment the following line to include the PCS
`define gem_no_pcs


// PCS Interface Type Selection
// Select whether to use the legacy PCS interface, or a generic 10bit/20bit 
// interface.
// If you have included the PCS, define the interface type. The interface can be 
// configured to be 'legacy' which is the interface defined in the IEEE 802.3 
// Clause 36 specifications, or a generic 10-bit or 20-bit interface. For the 
// generic interface options, the PCS will also contain comma and code group 
// alignment functions.
// Only one of the following defines should be uncommented
//`define gem_pcs_legacy_if
//`define gem_pcs_10b_if
`define gem_pcs_20b_if


// RGMII Interface Selection
// Select whether to replace the standard GMII interface with an RGMII interface.
// RGMII is an optional PHY interface that can be used as an alternative to the 
// GMII with reduced pin count.
// Uncomment the following to replace the GMII interface with an RGMII interface
`define gem_use_rgmii


// RMII Interface Selection
// Select whether to include an RMII interface.
// Including this option will add a software selectable RMII PHY interface, so it 
// becomes an interface in addition to the GMII/RGMII interface. RMII is a 'Reduced 
// MII' interface and therefore supports 10M/100M speeds only. It requires a 50 MHz 
// clock (as opposed to 25 MHz for MII), data is clocked out two bits at a time (vs 
// 4 bits for MII). Data is sampled on the rising edge only.
// Uncomment the following to include a separate RMII port
//`define gem_include_rmii


// Select User I/Os
// Select the number of generic User I/Os.
// The GEM design provides up to 16 inputs and 16 outputs so that the I/O may be 
// read or set under the software control via the APB interface. You may select up 
// to 16 inputs and 16 outputs. Setting to zero will disable user I/O and the 
// address space is defined as reserved. Default is set to 8 for both inputs and 
// outputs 
// Comment the gem_user_io define if no user IO's are required. 
// The width defines the number of user_in's and user_out's added to the design
//`define gem_user_io
`define gem_user_in_width 0
`define gem_user_out_width 0


//  ------------ MAC Configuration Options ----------

// MAC Data Bus Width
// Define the MAC data bus width
// This option sets the MAC bus width. This is not the same as the DMA data bus 
// width. If you are not using the DMA at all, then this will define the FIFO data 
// bus width and a value of 32, 64 or 128 is permitted. If the Packet Buffer DMA 
// mode is selected this parameter should be set to the same value as the 
// dma_bus_width parameter, unless the dma_bus_width is set to 128. If 
// dma_bus_width is set to 128 then this parameter should be set to 64. For Non 
// Packet Buffer DMA operation this parameter should be set to dma_bus_width.
// Set the define to 32, 64 or 128, based on the above guidance
`define gem_emac_bus_width 32


// Internal Loopback
// Select whether to include an option for internal TX to RX loopback.
// Enabling this option will allow software to put the GEM in a TX-RX internal 
// loopback mode. When using internal loopback, tx_clk and rx_clk must be provided 
// using the same loopback reference clock, and n_tx_clk must be provided with the 
// inverted version of the loopback reference clock. An extra output provides 
// indication to the external system clock generator, and a programmable register 
// is provided for software to enable the mode. 
// Uncomment the following for internal loopback
`define gem_int_loopback


// Statistics
// Select whether to include MAC statistics in hardware.
// The MAC includes optional bank of statistics registers, accessible via APB. 
// These are for counting various types of event associated with transmit and 
// receive operation. Along with the status words stored in the receive buffer 
// list, the registers enable software to generate network management statistics 
// compatible with IEEE 802.3 clause 30. They typically reset to zero on a read and 
// stick at all ones when they count to their maximum value. In order to reduce 
// overall design area, the statistics registers may be optionally removed if they 
// are deemed unnecessary for a particular design. All the statistics registers are 
// read only. For test purposes they may be written by setting bit 7 (Write Enable) 
// in the network control register. Setting bit 6 (increment statistics) in the 
// network control register causes all the statistics registers to increment by 
// one, again for test purposes. Once a statistics register has been read, it is 
// automatically cleared. 
// If the following is commented, the GEM stats registers will be included
//`define gem_no_stats


// Snapshot Registers
// Select whether to include MAC statistics in hardware.
// The statistics registers optionally have a snapshot capability which, when 
// exercised, will simultaneously store and clear the current values of all the 
// statistics registers into a snapshot register set in order to allow a consistent 
// set of statistics to be read by the processor. The snapshot is controlled using 
// bit 13 of the network control register. The read snapshot control indicated by 
// bit 14 of the network control register determines whether the processor reads 
// the snapshot registers (logic 1) or the incrementing registers (logic 0). Note, 
// most customers do NOT include snapshot registers due to the increased area 
// requirement.
// If the following is commented, the GEM snapshot registers will be included. This 
// will add around 1000 flip-flips to the design
//`define gem_no_snapshot


// Interrupt Clearing
// This option selects the software clearing type for interrupt status (RCLR or 
// WCLR).
// You can either select to clear the interrupt status register via APB using a 
// write-to-clear method (default), or a read-to-clear.
// If the following define is uncommented, it will cause that the interrupt status 
// register will be cleared on a read. otherwise it will be cleared by writing a 
// '1' to the appropriate bit.
//`define gem_irq_read_clear


// Max Frame Length
// Select the default maximum frame length. Used by Receiver to drop oversized 
// frames.
// The user can define the maximum length frame the GEM should support. The GEM 
// receiver will use this to determine what is an oversized frame and subsequently 
// uses it to determine what should be dropped and captured in the oversized frame 
// statistic. When including a DMA, this should not be set any larger than 16383 
// due to the fact the descriptor writeback only has enough bits to register 16k in 
// the length field. This is only a default value, and can be overwritten by the 
// specific max_frame_length APB programmable register at any time.
// In DMA mode, this should not be set any larger than 16383 due to the fact the 
// descriptor writeback only has enough bits to register 16k in the length field.
`define gem_jumbo_max_length 14'd10240


// Specific Address Filters
// The number of specific source or destination address filters is configurable and 
// can range from zero to 36. It is recommended that a value of at least one is 
// used because spec address 1 is used to synthesize transmitted pause frames.
// The MAC contains a filter block which determines which received frames should be 
// forwarded and eventually written to main memory. Whether a frame is passed 
// depends on what is enabled in the network configuration register, the state of 
// the external matching pins, the contents of the specific address, type and hash 
// registers and the frame's destination address and type field. Most of these are 
// not configurable, but the user has the option to select how many specific 
// address filters to include in the design, from 0 to 36. Each specific address 
// filter can compare against either 6-byte source or destination addresses, and 
// has an optional mask field to allow the user to mask bytes during the comparison 
// process. Each filter requires two 32-bit APB registers. Keeping the number low 
// can save area. A general recommendation would be to include a few filters for 
// future use even if there is no known requirement for them. At least one filter 
// is always recommended as it is used as one of the optional mechanisms to 
// indicate a Wake on Lan (WoL) event. It is also used for specific pause frame 
// recognition if that is required. Setting this define in pbuf DMA mode to a 
// number greater than 4 will remove external address match from receive buffer 
// descriptor entry word 1 and bit 28 of word 1 will be set if there is an address 
// match in specific address register 1 to 8. Bits 27 to 25 then indicate which 
// specific address register matched. The first four filters are located at address 
// offset 0x88 to 0xA4. Filters 5 to 36 are located between address offset 0x300 
// through 0x3fc.
// Set this define between 1 and 36.
`define num_spec_add_filters 8


// External Address Matching
// Define the length of the MAC RX pipeline to allow for increased external address 
// matching time
// This option allows the user to increase the latency of the MAC receiver in order 
// to increase the available time the user has to implement and complete some user 
// defined external address matching logic. It is not recommended that the user 
// changes the default value, especially for configurations that include the DMA - 
// this is due to a limited amount of verification applied and therefore an 
// increased level of risk. Existing users tend to be happy with the default value.
// When using internal address matching and DMA, this must be a minimum of 7. It is 
// recommended to leave this define at 10.
`define gem_rx_pipeline_delay 10


// Priority Flow Control
// Select whether to allow full PFC pause timer capabilities
// PFC frames are supported natively by the controller and can not be configured 
// out. However, a PFC frame has the ability to incorporate 8 different priority 
// fields, with each having a separate pause time field. This option allows you to 
// select whether you want complete control over all 8 pause time fields, or use a 
// common pause time for each of the 8. Most customers are satisfied with the 
// reduced capability and this does reduce overall area.
// Uncomment the following define to include independent pause quantums for each 
// PFC priority.
//`define gem_pfc_multi_quantum


// Priority Queues
// Select the number of priority queues (for DMA packet buffer mode).
// When the DMA is configured in packet buffer mode, the user can select between 1 
// and 16 priority queues. Each queue has an independent list of buffer descriptors 
// pointing to separate data streams.
// Keep the following undefined if only one priority queue is required. Otherwise, 
// define the number of queues
//`define dma_priority_queue1
//`define dma_priority_queue2
//`define dma_priority_queue3
//`define dma_priority_queue4
//`define dma_priority_queue5
//`define dma_priority_queue6
//`define dma_priority_queue7
//`define dma_priority_queue8
//`define dma_priority_queue9
//`define dma_priority_queue10
//`define dma_priority_queue11
//`define dma_priority_queue12
//`define dma_priority_queue13
//`define dma_priority_queue14
//`define dma_priority_queue15


// Packet Inspection and Screeners
// Defines the number of Type1 and Type2 Screeners.
// When priority queues are enabled, every received packet will pass through a 
// programmable packet inspection algorithm which will allocate to that frame a 
// particular queue to route it to. The user interface to the screeners is via two 
// banks of programmable registers, screener type 1 registers and screener type 2 
// registers. Screener type 1 registers allow the user to route received frames 
// based on particular IP and UDP fields extracted from the received frames. 
// Screener Type 2 match registers operate independently and offer additional match 
// capabilities, extending the capabilities into vendor specific protocols. For 
// type 2 screeners, frames are inspected by matching values against the VLAN 
// field, or matching user defined ethertype registers against the received 
// ethertype, or matching user defined compare registers against programmable 
// indexed fields within the frame. Together, the screeners provide a very flexible 
// and user programmable routing method. For full details refer to the userguide. 
// The number of screeners, ethertype and compare registers to include in the 
// design is selected below.
// Set the number of type1 and type2 screeners, number of ethertype registers and 
// number of compare registers. Note you must comment the define if you do not wish 
// to include any screeners/ethertype or compare regs. you will get compilation 
// errors otherwise
//`define num_type1_screeners 8'd0
//`define num_type2_screeners 8'd0
`define num_scr2_ethtype_regs 8'd1
`define num_scr2_compare_regs 8'd1


//  ------------ DMA Configuration Options ----------

// DMA Data Bus Width
// Define the DMA data bus width
// This option sets the DMA data bus width (AXI/AHB). This is not the same as the 
// MAC data bus width and is only relevant if you use the DMA. Valid settings are 
// 32, 64 or 128. Reducing the bus width will save resources. The current bus width 
// can be programmed through the network configuration register but will be forced 
// to a value no greater than the configured width.
// Set this define to 32,64 or 128 based on the above guidance
`define gem_dma_bus_width 32


// Define DMA Version
// Select either 'Packet Buffer' DMA or 'FIFO based' DMA
// The FIFO based DMA is a very legacy DMA that is now no longer recommended for 
// use. It has very low latency, but only supports AHB, requires software overhead 
// and most of the key DMA features as described in the userguide are not available.
//  The Packet Buffer DMA is the recommended mode.
// Uncomment to use the packet buffer based DMA. Comment to use the FIFO DMA. Note 
// almost all customers now use the packet buffer DMA.
`define gem_rx_pkt_buffer
`define gem_tx_pkt_buffer


// AHB or AXI Selection
// Set if an AXI4/3 or AHB interface is required.
// AXI is the recommended interface due to the increased performance capabilities 
// (to which the DMA makes good use of). AXI is only available for the packet 
// buffer based DMA.
// This define is ignored if there is no packet buffer DMA included in the design. 
// Comment to have an AHB interface. Uncomment for AXI.
`define gem_axi


// DMA Address Bus Width
// Define the DMA address bus width (for DMA packet buffer mode)
// This option sets the DMA address bus width (AXI/AHB). Valid settings are 32 or 
// 64 only. Set to 64 only if you require address bus sizes between 33 and 64. 
// Setting to 32 the bus width will minimize resources used. Note the address bus 
// width can also be programmed through an APB register but will be forced to a 
// value no greater than the configured width.
// Set this define to 32 or 64 based on the above guidance
`define gem_dma_addr_width 32


// AXI Outstanding Transactions
// Define the maximum number of AXI outstanding tranactions supported
// If an AXI DMA is selected, the user may choose the level of buffering in the DMA.
//  Buffering is required to improve AXI performance, allow a greater degree of AXI 
// pipelining (where pipelining here refers to the number of AR or AW/W requests 
// issued) before the accompanying R or B response is returned from the AXI fabric).
//  This parameter sets the number of bits used to describe the depth of the AXI 
// pipelining allowed.
//   A value of 1 means the max num outstanding transactions is 2.
//   A value of 4 means the max num outstanding transactions is 16.
//   Note this only defines the MAX number. The actual number used can also be fine 
// tuned using a programmable register in the core. A larger number will increase 
// area, but will potential maximize performance.
// Set the following define between 1 (max number of outstanding transactions is 2) 
// and 4 (max number of outstnading transactions is 16)
`define gem_axi_access_pipeline_bits 4'd4


// TX Descriptor Read Buffer Depth
// Setting the TX Descriptor Read prefetch buffer depth (AXI Only).
// Long TX descriptor read access times can limit overall DMA performance since the 
// DMA cannot issue data transfers until the descriptor for the buffer has been 
// fetched and processed. Once a descriptor is fetched, the DMA can issue multiple 
// data read requests well in advance of the returned data to take advantage of AXI 
// pipelining capabilities. Assuming multiple descriptors are available to the DMA, 
// it can continue to issue pipelined data requests spanning multiple frames and 
// this can significantly improve performance in very high latency systems. To take 
// advantage of this, descriptors need to be made available to the DMA quickly. 
// This parameter sets the number of bits used to describe the depth of the FIFO 
// that is needed to buffer TX descriptor read responses. Minimum value is 1. Max 
// tested value is 4. A higher value improves the ability of the DMA and MAC to 
// maintain maximum performance in high latency systems, but comes at a significant 
// area cost. A value of 1 will be suitable in most cases. If TX descriptor read 
// latencies prove to be limiting Ethernet line performance, consider increasing 
// this. 
// Set the following define between 1 and 4.
`define gem_axi_tx_descr_rd_buff_bits 4'd1


// RX Descriptor Read buffer depth
// Setting the RX Descriptor Read prefetch buffer depth (AXI Only).
// Long RX descriptor read access times can limit overall DMA performance since the 
// DMA cannot issue data transfers until the descriptor for the buffer has been 
// fetched and processed. Once a descriptor is fetched, the DMA can issue multiple 
// data read requests well in advance of the returned data to take advantage of AXI 
// pipelining capabilities. Assuming multiple descriptors are available to the DMA, 
// it can continue to issue pipelined data requests spanning multiple frames and 
// this can significantly improve performance in very high latency systems. To take 
// advantage of this, descriptors need to be made available to the DMA quickly. 
// This parameter sets the number of bits used to describe the depth of the FIFO 
// that is needed to buffer TX descriptor read responses. Minimum value is 1. Max 
// tested value is 4. A higher value improves the ability of the DMA and MAC to 
// maintain maximum performance in high latency systems, but comes at a significant 
// area cost. A value of 1 will be suitable in most cases. If RX descriptor read 
// latencies prove to be limiting Ethernet line performance, consider increasing 
// this. 
// Set the following define between 1 and 4.
`define gem_axi_rx_descr_rd_buff_bits 4'd1


// TX Descriptor Write buffer depth
// Setting the TX Descriptor Read prefetch buffer depth. (AXI Only)
// Long TX descriptor write access times can limit overall DMA performance since 
// without any buffering, it can cause the underlying TX DMA from being blocked 
// from continuing transmission while it waits for the descriptor write to complete.
//  This parameter sets the number of bits used to describe the depth of the FIFO 
// that is needed to buffer TX descriptor write requests. Minimum value is 1 
// (meaning a depth of 2). Max tested value is 4. A higher value improves the 
// ability of the DMA and MAC to maintain maximum performance in high latency 
// systems, but comes at a significant area cost. A value of 1 will be suitable in 
// most cases. If TX descriptor write latencies prove to be limiting Ethernet line 
// performance, consider increasing this. 
// Set the following define between 1 and 4.
`define gem_axi_tx_descr_wr_buff_bits 4'd1


// RX Descriptor Write buffer depth
// Setting the RX Descriptor Read prefetch buffer depth. (AXI Only)
// Long RX descriptor write access times can limit overall DMA performance since 
// without any buffering, it can cause the underlying RX DMA from being blocked 
// from continuing transmission while it waits for the descriptor write to complete.
//  This parameter sets the number of bits used to describe the depth of the FIFO 
// that is needed to buffer RX descriptor write requests. Minimum value is 1 
// (meaning a depth of 2). Max tested value is 4. A higher value improves the 
// ability of the DMA and MAC to maintain maximum performance in high latency 
// systems, but comes at a significant area cost. A value of 1 will be suitable in 
// most cases. If RX descriptor write latencies prove to be limiting Ethernet line 
// performance, consider increasing this. 
// Set the following define between 1 and 4.
`define gem_axi_rx_descr_wr_buff_bits 4'd1


// Choose SRAM type
// Select whether to use SPSRAM or DPSRAM (for DMA packet buffer mode).
// Packet Buffer mode of operation has the option of using a single port SRAM, 
// rather than the default dual port SRAM. If this option is used there are 
// frequency limitations where the AHB/AXI clock must be going 2x faster than the 
// MAC data rate. See Userguide for mor details.
// Uncomment to use SPRAM rather than DPRAM
//`define gem_spram


// Set SRAM data width
// Select SRAM data width (for DMA packet buffer mode).
// Define the size of the RX and TX packet buffer SRAM data width if packet buffer 
// DMA mode is being used. Valid settings are 32, 64 and 128. When using single 
// mode SRAM mode (`gem_spram is set), this MUST be set to 128 (i.e. you need a 
// 128b SRAM for this mode). Otherwise you should set this equal to the DMA data 
// bus width.
// Set the SRAM data width based on the guidance above
`define gem_rx_pbuf_data 32
`define gem_tx_pbuf_data 32


// Set RX SRAM size
// Select SRAM address width (for DMA packet buffer mode).
// Define the size in address bits of the RX packet buffer SRAM for packet buffer 
// DMA mode. Maximum number here is 16 (represents 256kB with a 32 bit dma bus 
// width). To guarantee maximum bandwidth in all modes of operation, the general 
// rule for the RAM is a size equal to twice the anticipated maximum frame size. 
// Having a RAM that is twice the maximum frame size allows one frame to be 
// forwarded while the next frame is being written. The RAM sizes described in the 
// rule are cautious and are not always necessary (for example when partial store 
// and forward mode is enabled). Refer to the 'determining RAM Sizes' section of 
// the integration/user guide for full details.
// Set the required SRAM address width in bits
`define gem_rx_pbuf_addr 9 


// Set TX SRAM size
// Select SRAM address width (for DMA packet buffer mode).
// Define the size in address bits of the TX packet buffer SRAM for packet buffer 
// DMA mode. Maximum number here is 16 (represents 256kB with a 32 bit dma bus 
// width). To guarantee maximum bandwidth in all modes of operation, the general 
// rule for the RAM is a size equal to twice the anticipated maximum frame size. 
// Having a RAM that is twice the maximum frame size allows one frame to be 
// forwarded while the next frame is being written. When priority queues are 
// selected, each priority queue owns an independent reserved area of the SRAM, and 
// the above rule should be met on each queue's SRAM segment. The RAM sizes 
// described in the rule are cautious and are not always necessary (for example 
// when partial store and forward mode is enabled). Refer to the 'determining RAM 
// Sizes' section of the integration/user guide for full details.
// Set the required SRAM address width in bits
`define gem_tx_pbuf_addr 9 


// Priority Queue SRAM Allocation
// Defines the allocation of embedded SRAM space for each queue.
// When priority queues are enabled, the embedded TX SRAM is split between the 
// queues. The allocation of SRAM resources per queue is user configurable. To 
// achieve this, the user defines how many segments to split the SRAM into, and 
// then, via a different option, allocates a number of segments per chosen queue. 
// The number of segments is defined below, and a power of 2 value should be used 
// (eg. a value of 1 means a total of 2 segments, each segment is effectively half 
// the size of the SRAM. A value of 4 would mean 16 segments, each segment holding 
// 1/16 the full SRAM size). Those segments should then be allocated to each of the 
// allocated queues. Again a power of 2 value should be used.
// gem_tx_pbuf_queue_segment_size - Set this to the total number of segments (power 
// of 2 only, i.e. 0 = 1 segment, 1=2 segments etc)
// gem_tx_pbuf_num_segments_q0 - set this to the number of segments allocated to Q0 
// (NOTE you must leave the define commented if you wish to allocate 1 segment, 
// otherwise you will see compile errors). Set to 1 to allocate 2 segments, 
// etc)
// Repeat for all 16 queues 
`define gem_tx_pbuf_queue_segment_size 1
//`define gem_tx_pbuf_num_segments_q0 0
//`define gem_tx_pbuf_num_segments_q1 0
//`define gem_tx_pbuf_num_segments_q2 0
//`define gem_tx_pbuf_num_segments_q3 0
//`define gem_tx_pbuf_num_segments_q4 0
//`define gem_tx_pbuf_num_segments_q5 0
//`define gem_tx_pbuf_num_segments_q6 0
//`define gem_tx_pbuf_num_segments_q7 0
//`define gem_tx_pbuf_num_segments_q8 0
//`define gem_tx_pbuf_num_segments_q9 0
//`define gem_tx_pbuf_num_segments_q10 0
//`define gem_tx_pbuf_num_segments_q11 0
//`define gem_tx_pbuf_num_segments_q12 0
//`define gem_tx_pbuf_num_segments_q13 0
//`define gem_tx_pbuf_num_segments_q14 0
//`define gem_tx_pbuf_num_segments_q15 0


// Partial Store and Forward
// Select whether to include Partial Store and Forward capability
// If partial store and forward mode operation is required then this option should 
// be selected. Partial store and forward mode facilitates lower latency through 
// the packet buffer and also allows frames larger than the buffer size to be 
// supported. Partial store and forward mode needs additional FIFOs and if there is 
// no plan to use partial store and forward mode then by not setting this define 
// there is an area saving of around 2k gates. When included, the user can still 
// select between full store and forward or partial store and forward mode via APB 
// configuration registers. Note that this option is only available when the device 
// is configured for full_duplex operation and when not using multi buffer frames 
// (i.e. when frames are split over multiple DMA buffers).
// Uncomment to include partial store and forward (cut-thru) mode in the DMA
`define gem_pbuf_cutthru


// Receive Side Coalescing - Stateless Offload
// Select whether to include Receive Side Coalescing capability (RSC)
// Receive side coalescing is an advanced TCP/IP offload mechanism to reduce CPU 
// overhead for receive, achieved by coalescing received TCP message segments 
// together into a single large message. This means that when the message is 
// complete the CPU only has to process the single header and act upon the one 
// large data payload thus saving system resources. To utilize this functionality 
// it is expected that for a particular TCP stream, jumbo frames would not be 
// received. The Header Data splitting feature (activated via APB programming) must 
// also be enabled, and priority queuing configuration options must be enabled. 
// Adding this capability to the design does not force you to use the feature - it 
// can still be disabled via software programming, however if this configuration 
// option is selected, the receive buffer offset functionality enabled by bits 
// 15:14 in the network configuration register is not available. Full details are 
// presented in the userguide.
// Uncomment to include RSC capability
//`define gem_pbuf_rsc


// Large Send Offload - Stateless Offload
// Select whether to include Large Send Offload capability (LSO / TSO / UFO)
// Large Send Offload is an advanced TCP/IP offload mechanism to reduce CPU 
// overhead for transmit. Two mechanisms are included - TCP Segmentation Offload 
// (TSO/LSO) and UDP Fragmentation Offload (UFO). CPU overhead is reduced by 
// permitting software to handoff TCP and UDP frames which are larger than the 
// current TCP Maximum Segment Size (MSS) and Ethernet Maximum Frame Size (MFS). 
// Hardware splits the large software supplied frames into smaller frames for 
// transmission and modifies the header fields as required. TCP offload is achieved 
// by creating smaller segments at the TCP level. UDP offload is achieved by 
// performing fragmentation at the IP level. Adding this capability to the design 
// does not force you to use the feature - it can still be disabled via software 
// programming. Full details are presented in the userguide.
// Uncomment to include LSO capability
//`define gem_pbuf_lso


// HPROT Signalling, AHB only
// Define the AHB 'hprot' signalling
// Individual bits assigned as follows:
//          bit  |   set to 1    |    set to 0
//      --------------------------------------
//      hprot[0] |  data access  |  opcode access
//      hprot[1] |  privileged   |  user
//      hprot[2] |  bufferable   |  not bufferable
//      hprot[3] |  cacheable    |  not cacheable
`define gem_hprot_value 4'b0001


// ARPROT/AWPROT signalling, AXI only
// Define the AXI 'prot' signalling
// Individual bits assigned as follows:
//          bit  |   set to 1    |    set to 0
//      --------------------------------------
//      prot[0] |  privileged   |  normal
//      prot[1] |  nonsecure    |  secure
//      prot[2] |  instruction  |  data access
`define gem_axi_prot_value 3'b000 


// AWCACHE signalling, AXI only
// Define the AXI 'awcache' signalling
// Defaulted to Non-cacheable and nonbufferable
`define gem_axi_awcache_value 4'b0000 


// ARCACHE signalling, AXI only
// Define the AXI 'arcache' signalling
// Defaulted to Non-cacheable and nonbufferable
`define gem_axi_arcache_value 4'b0000 


//  ------------ TSN/1588 Configuration Options ----------

// Time Stamp Unit, or TSU
// Select whether to include a 1588 Time Stamp Unit in the design
// The design can contain an optional time stamp unit (TSU). The TSU consists of a 
// timer and registers to capture the time at which PTP event frames cross the 
// message time-stamp point. These are accessible through the APB interface. The 
// inclusion of the TSU is optional. If it is not included, timestamping, including 
// single step timestamping, will not be possible. Note it is required to include 
// this option even if an external TSU is to be used in place of the internal TSU 
// (the external port will not be present otherwise).
// Uncomment the following define to include the TSU in the design
`define gem_tsu


// Time Stamp Unit Clock 
// Select whether to use existing APB clock or a specific TSU clock
// Select whether to use an alternate clock source for the time stamp unit. 
// Timestamp accuracy improves with higher frequencies of tsu_clk. To support 
// single step timestamping, tsu_clk frequency must be greater than 1/8th the 
// frequency of tx_clk or rx_clk.
// Uncomment the following define to have the TSU clocked by an independent tsu_clk.
//  Comment to use pclk as the TSU clock source.
//`define gem_tsu_clk


// Time Stamp Unit Time sourced externally
// Select whether to use route the TSU timer value from an input port.
// Select whether to source the TSU timer value from an input port of the design. 
// This can be sourced from another GEM instance on the SoC.
// Uncomment the following define to allow the TSU time value to be selectable via 
// an internal or external source
//`define gem_ext_tsu_timer


// Credit Based Shaping - TSN, 802.1Qav
// Select whether to include the credit based shaper algorithm
// A credit-based shaping algorithm is available on the two highest priority queues 
// and is defined in 802.1Qav: Forwarding and Queuing Enhancements for 
// Time-Sensitive Streams. This allows traffic on these queues to be limited and to 
// allow other queues to transmit.
// Comment the following define to include CBS functionality in the design
`define gem_exclude_cbs


// Enhanced Scheduled Traffic - TSN, 802.1Qbv
// Select whether to include support for Enhanced Scheduled Traffic
// This feature provides support for 802.1Qbv, which provides a transmission 
// enabling gate for each priority queue. When included, the user will be able to 
// select the timings for the opening and closing phases of each transmission gate, 
// as well as the transmission start time for each queue. You must include the TSU 
// for this feature
// Comment the following define to include QBV functionality in the design
`define gem_exclude_qbv


// Interspersing Express Traffic - TSN, 802.3br
// Select whether to include support for 802.3br
// This feature provides support for 802.3br, Interspersing of Express Frames, a 
// key standard required for TSN. It adds a MAC Merge Sublayer (MMSL) module and a 
// second MAC/DMA instance. The MMSL interfaces two MACs to a single PHY. One MAC 
// is known as the Express MAC (eMAC) and transmits and receives the higher 
// priority traffic. The other MAC is known as the Pre-Emptible MAC (pMAC) and 
// transmits and receives lower priority traffic. The TX interspersing 
// functionality in the MMSL is able to fragment pMAC frames in order to deliver 
// eMAC frames to the PHY with minimal latency. pMAC frames are defragmented by the 
// link partner MMSL before being forwarded to the link partner pMAC. 
// Uncomment the following define to include 802.3br functionality
//`define gem_has_802p3_br


// 802.3br EMAC specific RX SRAM 
// Select SRAM address width (for DMA packet buffer mode).
// Define the size in address bits of the RX packet buffer SRAM for packet buffer 
// DMA mode. Maximum number here is 16 (represents 256kB with a 32 bit dma bus 
// width). To guarantee maximum bandwidth in all modes of operation, the general 
// rule for the RAM is a size equal to twice the anticipated maximum frame size. 
// Having a RAM that is twice the maximum frame size allows one frame to be 
// forwarded while the next frame is being written. The RAM sizes described in the 
// rule are cautious and are not always necessary (for example when partial store 
// and forward mode is enabled). Refer to the 'determining RAM Sizes' section of 
// the integration/user guide for full details.
// Set the required SRAM address width in bits
`define gem_emac_rx_pbuf_addr 11


// 802.3br EMAC specific TX SRAM 
// Select SRAM address width (for DMA packet buffer mode).
// Define the size in address bits of the TX packet buffer SRAM for packet buffer 
// DMA mode. Maximum number here is 16 (represents 256kB with a 32 bit dma bus 
// width). To guarantee maximum bandwidth in all modes of operation, the general 
// rule for the RAM is a size equal to twice the anticipated maximum frame size. 
// Having a RAM that is twice the maximum frame size allows one frame to be 
// forwarded while the next frame is being written. The RAM sizes described in the 
// rule are cautious and are not always necessary (for example when partial store 
// and forward mode is enabled). Refer to the 'determining RAM Sizes' section of 
// the integration/user guide for full details.
// Set the required SRAM address width in bits
`define gem_emac_tx_pbuf_addr 11


// Frame Replication and Elimination for Reliability - TSN, 802.1CB
// Select whether to include support for 802.1CB (Elimination only)
// This standard is one of a number of standards suitable for Time-Sensitive 
// Networking (TSN) that together have the overall goal of providing extremely low 
// packet loss rates and finite, low, and stable end-to-end latencies. TSN supports 
// unicast and multicast Streams of packets that implement a wide range of 
// demanding real-time applications including audio/video studios, industrial 
// processes, and the control of machines and vehicles. The TSN goals are not 
// achieved at the expense of hampering the ability of the network to carry traffic 
// for non-time-critical applications. When gem_no_of_cb_streams is zero or 
// undefined 802.1CB functionality will not be present.
// gem_no_of_cb_streams - Enter the number of CB streams. The min number is 0 (0 
// disables CB functionality) and the max is 16. The number also cannot exceed the 
// number of type 2 screeners defined in this file.
// gem_seq_history_len - Define the sequence history length you require - valid 
// range 1 to 64.
// `define gem_no_of_cb_streams 8'd0
`define gem_seq_history_len 8'd64


//  ------------ Remaining Configuration Options ---------- ----------

// Do not modify this configuration option without contacting Cadence first. It is 
// not relevant to most designs
`define gem_rx_fifo_size 10


// Do not modify this configuration option without contacting Cadence first. It is 
// not relevant to most designs
`define gem_rx_base2_fifo_size 4'b1010


// Do not modify this configuration option without contacting Cadence first. It is 
// not relevant to most designs
`define gem_rx_fifo_cnt_width 4


// Do not modify this configuration option without contacting Cadence first. It is 
// not relevant to most designs
`define gem_tx_fifo_size 10


// Do not modify this configuration option without contacting Cadence first. It is 
// not relevant to most designs
`define gem_tx_base2_fifo_size 4'b1010


// Do not modify this configuration option without contacting Cadence first. It is 
// not relevant to most designs
`define gem_tx_fifo_cnt_width 4


// Revision registers
// Revision register value. Top 4 bits are for fix number. Next 12 bits are Module 
// ID number. Bottom 16 bits are module revision.
`define gem_revision_reg_value 32'h7107010c


// This 32-bit value is formed by two 16-bit registers whose values will be the 
// following constants
`define gem_phy_id_top 16'h7107


`define gem_phy_id_bot 16'h010c


// Set the reset value of default value for dma_bus_width in the network config 
// register
//  2'b00 - 32 bits
//  2'b01 - 64 bits
//  2'b1x - 128 bits
`define gem_dma_bus_width_def 2'b00


// Set the reset value of default value for mdc_clock_div in the network config 
// register
//  3'b000 - divide pclk by 8
//  3'b001 - divide pclk by 16
//  3'b010 - divide pclk by 32
//  3'b011 - divide pclk by 48
//  3'b100 - divide pclk by 64
//  3'b101 - divide pclk by 96
//  3'b110 - divide pclk by 128
//  3'b111 - divide pclk by 224
`define gem_mdc_clock_div 3'b010


// Set the reset value of DMA endianism value in DMA configuration register
//              packet data             management descriptors
//  2'b00 -    little endian               little endian
//  2'b01 -    little endian                  big endian
//  2'b10 -       big endian               little endian
//  2'b11 -       big endian                  big endian
`define gem_endian_swap_def 2'b00


// Set the reset value of default RX DMA packet buffer memory sizes in DMA 
// configuration register
//  2'b11 - use full configured memory size
//  2'b10 - use half of configured memory size
//  2'b01 - use quarter of configured memory size
//  2'b00 - use eighth of configured memory size
`define gem_rx_pbuf_size_def 2'b11


// Set the reset value of default TX DMA packet buffer memory sizes in DMA 
// configuration register
//  1'b1 - use full configured memory size
//  1'b0 - use half of configured memory size
`define gem_tx_pbuf_size_def 1'b1


// Set the reset value of receive buffer length register
// // Define the default receive buffer length (integer value, 8 bits).
//  The value determines the default size of buffer to use in main AHB
//  system memory when writing received data and can be over-written by
//  writing to the DMA configuration register.
//  The value is defined in multiples of 64 bytes. For example:
//  8'd1:  64 bytes
//  8'd2:  128 bytes
//  8'd24: 1536 bytes (1*max length frame/buffer)
//  8'd16: 10240 bytes (1*10K jumbo frame/buffer)
//  8'd255 16320 bytes (maximum value allowed)
//  Note that this value should never be  zero.
`define gem_rx_buffer_length_def 8'd2


