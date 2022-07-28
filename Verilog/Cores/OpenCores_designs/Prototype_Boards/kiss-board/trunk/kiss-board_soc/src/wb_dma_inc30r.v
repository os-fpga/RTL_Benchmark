/////////////////////////////////////////////////////////////////////
////                                                             ////
////  WISHBONE DMA Primitives                                    ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/wb_dma/    ////
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
//  $Id: wb_dma_inc30r.v,v 1.1.1.1 2006-05-29 13:45:18 fukuchi Exp $
//
//  $Date: 2006-05-29 13:45:18 $
//  $Revision: 1.1.1.1 $
//  $Author: fukuchi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.2  2002/02/01 01:54:45  rudi
//
//               - Minor cleanup
//
//               Revision 1.1  2001/07/29 08:57:02  rudi
//
//
//               1) Changed Directory Structure
//               2) Added restart signal (REST)
//
//               Revision 1.2  2001/06/05 10:22:37  rudi
//
//
//               - Added Support of up to 31 channels
//               - Added support for 2,4 and 8 priority levels
//               - Now can have up to 31 channels
//               - Added many configuration items
//               - Changed reset to async
//
//               Revision 1.1.1.1  2001/03/19 13:11:12  rudi
//               Initial Release
//
//
//

//`define	WDMA_REG_SEL		(wb_addr_i[31:28] == rf_addr)
`define	WDMA_REG_SEL		1'b1


// DO NOT MODIFY BEYOND THIS POINT
// CSR Bits
`define	WDMA_CH_EN		0
`define	WDMA_DST_SEL		1
`define	WDMA_SRC_SEL		2
`define	WDMA_INC_DST		3
`define	WDMA_INC_SRC		4
`define	WDMA_MODE		5
`define	WDMA_ARS		6
`define WDMA_USE_ED		7
`define WDMA_WRB		8
`define	WDMA_STOP		9
`define	WDMA_BUSY		10
`define	WDMA_DONE		11
`define	WDMA_ERR		12
`define WDMA_ED_EOL		20



module wb_dma_inc30r(clk, in, out);
input		clk;
input	[29:0]	in;
output	[29:0]	out;

// INC30_CENTER indicates the center bit of the 30 bit incrementor
// so it can be easily manually optimized for best performance
parameter	INC30_CENTER = 16;

reg	[INC30_CENTER:0]	out_r;

always @(posedge clk)
	out_r <= #1 in[(INC30_CENTER - 1):0] + 1;

assign out[29:INC30_CENTER] = in[29:INC30_CENTER] + out_r[INC30_CENTER];
assign out[(INC30_CENTER - 1):0]  = out_r;

endmodule

