/////////////////////////////////////////////////////////////////////
////                                                             ////
////  USB 1.1 function IP core                                   ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/usb1_funct/////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: usb1_top.v,v 1.1.1.1 2002-09-19 12:07:36 rudi Exp $
//
//  $Date: 2002-09-19 12:07:36 $
//  $Revision: 1.1.1.1 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//
//
//
//
//

`include "usb1_defines.v"

module usb1_top(clk_i, rst_i,

		// USB Misc
		phy_tx_mode, usb_rst, loop,

		// Interrupts
		dropped_frame, misaligned_frame,
		crc16_err,

		// Vendor Features
		v_set_int, v_set_feature, wValue,
		wIndex, vendor_data,

		// USB PHY Interface
		tx_dp, tx_dn, tx_oe,
		rx_d, rx_dp, rx_dn,

		// Endpoint Interface
		ep1_din,  ep1_we, ep1_stat,
		ep2_dout, ep2_re, ep2_stat,
		ep3_din,  ep3_we, ep3_stat,
		ep4_dout, ep4_re, ep4_stat,
		ep5_din,  ep5_we, ep5_stat,

		// Clearing FIFOs
		iso_idle, bulk_idle,
		clr_iso, clr_bulk
		); 		

input		clk_i;
input		rst_i;

input		phy_tx_mode;
output		usb_rst;
input		loop;
output		dropped_frame, misaligned_frame;
output		crc16_err;

output		v_set_int;
output		v_set_feature;
output	[15:0]	wValue;
output	[15:0]	wIndex;
input	[15:0]	vendor_data;

output		tx_dp, tx_dn, tx_oe;
input		rx_d, rx_dp, rx_dn;

// Endpoint Interfaces
input	[7:0]	ep1_din;
input		ep1_we;
output	[3:0]	ep1_stat;

output	[7:0]	ep2_dout;
input		ep2_re;
output	[3:0]	ep2_stat;

input	[7:0]	ep3_din;
input		ep3_we;
output	[3:0]	ep3_stat;

output	[7:0]	ep4_dout;
input		ep4_re;
output	[3:0]	ep4_stat;

input	[7:0]	ep5_din;
input		ep5_we;
output	[3:0]	ep5_stat;

output		iso_idle, bulk_idle;
input		clr_iso, clr_bulk;

///////////////////////////////////////////////////////////////////
//
// Local Wires and Registers
//

// UTMI Interface
wire	[7:0]	DataOut;
wire		TxValid;
wire		TxReady;
wire	[7:0]	DataIn;
wire		RxValid;
wire		RxActive;
wire		RxError;
wire	[1:0]	LineState;

wire	[7:0]	rx_data;
wire		rx_valid, rx_active, rx_err;
wire	[7:0]	tx_data;
wire		tx_valid;
wire		tx_ready;
wire		tx_first;
wire		tx_valid_last;

// Internal Register File Interface
wire	[6:0]	funct_adr;	// This functions address (set by controller)
wire	[31:0]	idin;		// Data Input
wire	[3:0]	ep_sel;		// Endpoint Number Input
wire		crc16_err;	// Set CRC16 error interrupt
wire		int_to_set;	// Set time out interrupt
wire		int_seqerr_set;	// Set PID sequence error interrupt
wire		out_to_small;	// OUT packet was to small for DMA operation
wire	[31:0]	frm_nat;	// Frame Number and Time Register
wire		nse_err;	// No Such Endpoint Error
wire		pid_cs_err;	// PID CS error
wire		crc5_err;	// CRC5 Error

reg	[7:0]	tx_data_st;
wire	[7:0]	rx_data_st;
reg	[13:0]	cfg;

wire	[7:0]	tx_data_st_ep0, tx_data_st_ep1, tx_data_st_ep3, tx_data_st_ep5;

reg		ep_empty;
reg		ep_full;
wire	[7:0]	rx_size;
wire		rx_done;

wire	[7:0]	ep0_din;
wire	[7:0]	ep0_dout;
wire		ep0_re, ep0_we;
wire	[13:0]	ep0_cfg;
wire	[3:0]	ep0_stat;
wire	[7:0]	ep0_size;

wire		ctrl_setup, ctrl_in, ctrl_out;
wire		send_stall;
wire		token_valid;
reg		rst_local;		// internal reset

wire	[7:0]	ep1_din_int;
wire		ep1_we_int;
wire	[3:0]	ep2_stat_int;
wire	[7:0]	ep3_din_int;
wire		ep3_we_int;
wire	[3:0]	ep4_stat_int;
wire	[13:0]	ep1_cfg;
wire	[13:0]	ep2_cfg;
wire	[13:0]	ep3_cfg;
wire	[13:0]	ep4_cfg;
wire	[13:0]	ep5_cfg;
wire		loop;
wire		dropped_frame;
wire		misaligned_frame;
wire		v_set_int;
wire		v_set_feature;
wire	[15:0]	wValue;
wire	[15:0]	wIndex;
reg		iso_idle, bulk_idle;

///////////////////////////////////////////////////////////////////
//
// Misc Logic
//

// Endpoint type and Max transfer size
assign ep0_cfg = `CTRL | ep0_size;
assign ep1_cfg = `ISO  | `IN  | 14'd0256;
assign ep2_cfg = `ISO  | `OUT | 14'd0256;
assign ep3_cfg = `BULK | `IN  | 14'd064;
assign ep4_cfg = `BULK | `OUT | 14'd064;
assign ep5_cfg = `INT  | `IN  | 14'd064;

always @(posedge clk_i)
	rst_local <= #1 rst_i & ~usb_rst;

always @(posedge clk_i)
	iso_idle <= #1 (ep_sel != 4'h1) & (ep_sel != 4'h2);

always @(posedge clk_i)
	bulk_idle <= #1 (ep_sel != 4'h3) & (ep_sel != 4'h4);

///////////////////////////////////////////////////////////////////
//
// Module Instantiations
//

usb_phy phy(
		.clk(		clk_i		),
		.rst(		rst_i		),	// ONLY external reset
		.phy_tx_mode(	phy_tx_mode	),
		.usb_rst(	usb_rst		),

		// Transciever Interface
		.rxd(		rx_d		),
		.rxdp(		rx_dp		),
		.rxdn(		rx_dn		),
		.txdp(		tx_dp		),
		.txdn(		tx_dn		),
		.txoe(		tx_oe		),

		// UTMI Interface
		.DataIn_o(	DataIn		),
		.RxValid_o(	RxValid		),
		.RxActive_o(	RxActive	),
		.RxError_o(	RxError		),
		.DataOut_i(	DataOut		),
		.TxValid_i(	TxValid		),
		.TxReady_o(	TxReady		),
		.LineState_o(	LineState	)
		);

// UTMI Interface
usb1_utmi_if	u0(
		.phy_clk(	clk_i		),
		.rst(		rst_local	),
		.DataOut(	DataOut		),
		.TxValid(	TxValid		),
		.TxReady(	TxReady		),
		.RxValid(	RxValid		),
		.RxActive(	RxActive	),
		.RxError(	RxError		),
		.DataIn(	DataIn		),
		.rx_data(	rx_data		),
		.rx_valid(	rx_valid	),
		.rx_active(	rx_active	),
		.rx_err(	rx_err		),
		.tx_data(	tx_data		),
		.tx_valid(	tx_valid	),
		.tx_valid_last(	tx_valid_last	),
		.tx_ready(	tx_ready	),
		.tx_first(	tx_first	)
		);

// Protocol Layer
usb1_pl  u1(	.clk(			clk_i			),
		.rst(			rst_local		),
		.rx_data(		rx_data			),
		.rx_valid(		rx_valid		),
		.rx_active(		rx_active		),
		.rx_err(		rx_err			),
		.tx_data(		tx_data			),
		.tx_valid(		tx_valid		),
		.tx_valid_last(		tx_valid_last		),
		.tx_ready(		tx_ready		),
		.tx_first(		tx_first		),
		.tx_valid_out(		TxValid			),
		.token_valid(		token_valid		),
		.fa(			funct_adr		),
		.ep_sel(		ep_sel			),
		.int_crc16_set(		crc16_err		),
		.int_to_set(		int_to_set		),
		.int_seqerr_set(	int_seqerr_set		),
		.frm_nat(		frm_nat			),
		.pid_cs_err(		pid_cs_err		),
		.nse_err(		nse_err			),
		.crc5_err(		crc5_err		),
		.rx_size(		rx_size			),
		.rx_done(		rx_done			),
		.ctrl_setup(		ctrl_setup		),
		.ctrl_in(		ctrl_in			),
		.ctrl_out(		ctrl_out		),
		.dropped_frame(		dropped_frame		),
		.misaligned_frame(	misaligned_frame	),
		.csr(			cfg			),
		.tx_data_st(		tx_data_st		),
		.rx_data_st(		rx_data_st		),
		.idma_re(		idma_re			),
		.idma_we(		idma_we			),
		.ep_empty(		ep_empty		),
		.ep_full(		ep_full			),
		.send_stall(		send_stall		)
		);

usb1_ctrl  u4(	.clk(			clk_i			),
		.rst(			rst_local		),

		.ctrl_setup(		ctrl_setup		),
		.ctrl_in(		ctrl_in			),
		.ctrl_out(		ctrl_out		),

		.ep0_din(		ep0_dout		),
		.ep0_dout(		ep0_din			),
		.ep0_re(		ep0_re			),
		.ep0_we(		ep0_we			),
		.ep0_stat(		ep0_stat		),
		.ep0_size(		ep0_size		),

		.send_stall(		send_stall		),
		.frame_no(		frm_nat[26:16]		),
		.funct_adr(		funct_adr 		),
		.configured(					),
		.halt(						),

		.v_set_int(		v_set_int		),
		.v_set_feature(		v_set_feature		),
		.wValue(		wValue			),
		.wIndex(		wIndex			),
		.vendor_data(		vendor_data		)

		);

always @(ep_sel or ep0_cfg or ep1_cfg or ep2_cfg or ep3_cfg or
		ep4_cfg or ep5_cfg)
	case(ep_sel)	// synopsys full_case parallel_case
	   4'h0:	cfg = ep0_cfg;
	   4'h1:	cfg = ep1_cfg;
	   4'h2:	cfg = ep2_cfg;
	   4'h3:	cfg = ep3_cfg;
	   4'h4:	cfg = ep4_cfg;
	   4'h5:	cfg = ep5_cfg;
	endcase

// In endpoints only
always @(posedge clk_i)
	case(ep_sel)	// synopsys full_case parallel_case
	   4'h0:	tx_data_st <= #1 tx_data_st_ep0;
	   4'h1:	tx_data_st <= #1 tx_data_st_ep1;
	   4'h3:	tx_data_st <= #1 tx_data_st_ep3;
	   4'h5:	tx_data_st <= #1 tx_data_st_ep5;
	endcase

// In endpoints only
always @(posedge clk_i)
	case(ep_sel)	// synopsys full_case parallel_case
	   4'h0:	ep_empty <= #1 ep0_stat[3];
	   4'h1:	ep_empty <= #1 ep1_stat[3];
	   4'h3:	ep_empty <= #1 ep3_stat[1];
	   4'h5:	ep_empty <= #1 ep5_stat[1];
	endcase

// OUT endpoints only
always @(ep_sel or ep0_stat or ep1_stat or ep2_stat or ep3_stat or
	ep4_stat or ep5_stat)
	case(ep_sel)	// synopsys full_case parallel_case
	   4'h0:	ep_full = ep0_stat[2];
	   4'h2:	ep_full = ep2_stat[2];
	   4'h4:	ep_full = ep4_stat[0];
	endcase

usb1_ep  #(0,6)
	u10(	.clk(			clk_i			),
		.rst(			rst_local		),
		.clr(			1'b0			),
		.ep_sel(		ep_sel			),
		.usb_dout(		tx_data_st_ep0		),
		.usb_din(		rx_data_st		),
		.usb_we(		idma_we			),
		.usb_re(		idma_re			),
		.ep_din(		ep0_din			),
		.ep_dout(		ep0_dout		),
		.ep_re(			ep0_re			),
		.ep_we(			ep0_we			),
		.ep_stat(		ep0_stat		)
		);

usb1_ep_in  #(1,9,32)
	u11(	.clk(			clk_i			),
		.rst(			rst_local		),
		.clr(			clr_iso			),
		.ep_sel(		ep_sel			),
		.usb_dout(		tx_data_st_ep1		),
		.usb_re(		idma_re			),
		.ep_din(		ep1_din_int		),
		.ep_we(			ep1_we_int		),
		.ep_stat(		ep1_stat		)
		);

`define HAVE_LOOP
// Loopback between endpoint 1&2
`ifdef HAVE_LOOP
assign ep1_din_int = loop ? rx_data_st : ep1_din;
assign ep1_we_int = loop ? (idma_we & (ep_sel == 4'h2)) : ep1_we;
assign   ep2_stat = loop ? ep1_stat : ep2_stat_int;
`else
assign ep1_din_int = ep1_din;
assign ep1_we_int = ep1_we;
assign   ep2_stat = ep2_stat_int;
`endif

usb1_ep_out  #(2,9,32)
	u12(	.clk(			clk_i			),
		.rst(			rst_local		),
		.clr(			clr_iso			),
		.ep_sel(		ep_sel			),
		.usb_din(		rx_data_st		),
		.usb_we(		idma_we			),
		.ep_dout(		ep2_dout		),
		.ep_re(			ep2_re			),
		.ep_stat(		ep2_stat_int		)
		);

usb1_ep_in  #(3,8,2)
	u13(	.clk(			clk_i			),
		.rst(			rst_local		),
		.clr(			clr_bulk		),
		.ep_sel(		ep_sel			),
		.usb_dout(		tx_data_st_ep3		),
		.usb_re(		idma_re			),
		.ep_din(		ep3_din_int		),
		.ep_we(			ep3_we_int		),
		.ep_stat(		ep3_stat		)
		);

// Loopback between endpoint 3&4
`ifdef HAVE_LOOP
assign ep3_din_int = loop ? rx_data_st : ep3_din;
assign ep3_we_int = loop ? (idma_we & (ep_sel == 4'h4)) : ep3_we;
assign   ep4_stat = loop ? ep3_stat : ep4_stat_int;
`else
assign ep3_din_int = ep3_din;
assign ep3_we_int = ep3_we;
assign   ep4_stat = ep4_stat_int;
`endif

usb1_ep_out  #(4,8,2)
	u14(	.clk(			clk_i			),
		.rst(			rst_local		),
		.clr(			clr_bulk		),
		.ep_sel(		ep_sel			),
		.usb_din(		rx_data_st		),
		.usb_we(		idma_we			),
		.ep_dout(		ep4_dout		),
		.ep_re(			ep4_re			),
		.ep_stat(		ep4_stat_int		)
		);

usb1_ep_in  #(5,6)
	u15(	.clk(			clk_i			),
		.rst(			rst_local		),
		.clr(			1'b0			),
		.ep_sel(		ep_sel			),
		.usb_dout(		tx_data_st_ep5		),
		.usb_re(		idma_re			),
		.ep_din(		ep5_din			),
		.ep_we(			ep5_we			),
		.ep_stat(		ep5_stat		)
		);
endmodule

