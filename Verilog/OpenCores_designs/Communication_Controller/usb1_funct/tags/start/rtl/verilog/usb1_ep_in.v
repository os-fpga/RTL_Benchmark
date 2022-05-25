/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Endpoint Interface                                         ////
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
//  $Id: usb1_ep_in.v,v 1.1.1.1 2002-09-19 12:07:10 rudi Exp $
//
//  $Date: 2002-09-19 12:07:10 $
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
//

`include "usb1_defines.v"

module usb1_ep_in(clk, rst, clr, ep_sel,
		usb_dout, usb_re,

		// External Endpoint interface
		ep_din, ep_we, ep_stat
		);

parameter	MY_EP_ID = 0;
parameter	aw = 6;
parameter	n = 32;

input		clk, rst, clr;
input	[3:0]	ep_sel;
output	[7:0]	usb_dout;
input		usb_re;

input	[7:0]	ep_din;
input		ep_we;
output	[3:0]	ep_stat;

////////////////////////////////////////////////////////////////////
//
// Local Wires
//

wire	usb_we_t, usb_re_t;

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//

assign usb_re_t = usb_re & (ep_sel == MY_EP_ID);

////////////////////////////////////////////////////////////////////
//
// FIFOs
//

// dw,aw
usb1_fifo #(8,aw,n)
	f1(
	.clk(		clk		),
	.rst(		rst		),
	.clr(		clr		),
	.din(		ep_din		),
	.we(		ep_we		),
	.dout(		usb_dout	),
	.re(		usb_re_t	),
	.full(		ep_stat[0]	),
	.empty(		ep_stat[1]	),
	.full_n(	ep_stat[2]	),
	.empty_n(	ep_stat[3]	)
	);

endmodule
