/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Discrete Cosine Transform, Parallel implementation         ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2002 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: dct.v,v 1.3 2002-10-31 12:50:03 rherveille Exp $
//
//  $Date: 2002-10-31 12:50:03 $
//  $Revision: 1.3 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.2  2002/10/23 09:06:59  rherveille
//               Improved many files.
//               Fixed some bugs in Run-Length-Encoder.
//               Removed dependency on ud_cnt and ro_cnt.
//               Started (Motion)JPEG hardware encoder project.
//

//synopsys translate_off
//synopsys translate_on



/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Discrete Cosine Transform, cosine table                    ////
////                                                             ////
////  Author: Richard Herveille                                  ////
////          richard@asics.ws                                   ////
////          www.asics.ws                                       ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Richard Herveille                        ////
////                    richard@asics.ws                         ////
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
//  $Id: dct_cos_table.v,v 1.2 2002-10-23 09:06:59 rherveille Exp $
//
//  $Date: 2002-10-23 09:06:59 $
//  $Revision: 1.2 $
//  $Author: rherveille $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $


function [31:0] dct_cos_table;

	//
	// inputs & outputs
	//
	input [2:0] x,y,u,v; // table entry

begin
	//
	// Table definition
	//
	// Function: cos( (2x +1) * u * pi)/16) * cos( (2y +1) * v * pi)/16)
	//
	// select bits:
	// 11:9 - V
	//  8:6 - U
	//  5:3 - Y
	//  2:0 - X

	case ( {v,u} ) // synopsys full_case parallel_case
		6'h00:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h20000000; // = +0.500000
				6'h01: dct_cos_table = 32'h20000000; // = +0.500000
				6'h02: dct_cos_table = 32'h20000000; // = +0.500000
				6'h03: dct_cos_table = 32'h20000000; // = +0.500000
				6'h04: dct_cos_table = 32'h20000000; // = +0.500000
				6'h05: dct_cos_table = 32'h20000000; // = +0.500000
				6'h06: dct_cos_table = 32'h20000000; // = +0.500000
				6'h07: dct_cos_table = 32'h20000000; // = +0.500000
				6'h08: dct_cos_table = 32'h20000000; // = +0.500000
				6'h09: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0a: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0e: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h10: dct_cos_table = 32'h20000000; // = +0.500000
				6'h11: dct_cos_table = 32'h20000000; // = +0.500000
				6'h12: dct_cos_table = 32'h20000000; // = +0.500000
				6'h13: dct_cos_table = 32'h20000000; // = +0.500000
				6'h14: dct_cos_table = 32'h20000000; // = +0.500000
				6'h15: dct_cos_table = 32'h20000000; // = +0.500000
				6'h16: dct_cos_table = 32'h20000000; // = +0.500000
				6'h17: dct_cos_table = 32'h20000000; // = +0.500000
				6'h18: dct_cos_table = 32'h20000000; // = +0.500000
				6'h19: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1a: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1e: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h20: dct_cos_table = 32'h20000000; // = +0.500000
				6'h21: dct_cos_table = 32'h20000000; // = +0.500000
				6'h22: dct_cos_table = 32'h20000000; // = +0.500000
				6'h23: dct_cos_table = 32'h20000000; // = +0.500000
				6'h24: dct_cos_table = 32'h20000000; // = +0.500000
				6'h25: dct_cos_table = 32'h20000000; // = +0.500000
				6'h26: dct_cos_table = 32'h20000000; // = +0.500000
				6'h27: dct_cos_table = 32'h20000000; // = +0.500000
				6'h28: dct_cos_table = 32'h20000000; // = +0.500000
				6'h29: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2a: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2e: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h30: dct_cos_table = 32'h20000000; // = +0.500000
				6'h31: dct_cos_table = 32'h20000000; // = +0.500000
				6'h32: dct_cos_table = 32'h20000000; // = +0.500000
				6'h33: dct_cos_table = 32'h20000000; // = +0.500000
				6'h34: dct_cos_table = 32'h20000000; // = +0.500000
				6'h35: dct_cos_table = 32'h20000000; // = +0.500000
				6'h36: dct_cos_table = 32'h20000000; // = +0.500000
				6'h37: dct_cos_table = 32'h20000000; // = +0.500000
				6'h38: dct_cos_table = 32'h20000000; // = +0.500000
				6'h39: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3a: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3e: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3f: dct_cos_table = 32'h20000000; // = +0.500000
			endcase
		6'h01:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h01: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h02: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h03: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h04: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h05: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h06: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h07: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h08: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h09: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h10: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h11: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h12: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h13: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h14: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h15: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h16: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h17: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h18: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h19: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h20: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h21: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h22: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h23: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h24: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h25: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h26: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h27: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h28: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h29: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h30: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h31: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h32: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h33: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h34: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h35: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h36: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h37: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h38: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h39: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
			endcase
		6'h02:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h01: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h02: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h03: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h04: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h05: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h06: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h07: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h08: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h09: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0f: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h10: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h11: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h12: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h13: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h14: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h15: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h16: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h17: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h18: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h19: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1f: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h20: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h21: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h22: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h23: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h24: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h25: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h26: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h27: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h28: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h29: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2f: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h30: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h31: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h32: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h33: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h34: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h35: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h36: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h37: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h38: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h39: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3f: dct_cos_table = 32'h29cf5d22; // = +0.653281
			endcase
		6'h03:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h01: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h02: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h03: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h04: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h05: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h06: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h07: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h08: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h09: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0c: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0f: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h10: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h11: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h12: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h13: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h14: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h15: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h16: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h17: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h18: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h19: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1c: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1f: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h20: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h21: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h22: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h23: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h24: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h25: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h26: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h27: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h28: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h29: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2c: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2f: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h30: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h31: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h32: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h33: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h34: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h35: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h36: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h37: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h38: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h39: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3c: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3f: dct_cos_table = 32'hda5f3a21; // = -0.587938
			endcase
		6'h04:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h20000000; // = +0.500000
				6'h01: dct_cos_table = 32'he0000000; // = -0.500000
				6'h02: dct_cos_table = 32'he0000000; // = -0.500000
				6'h03: dct_cos_table = 32'h20000000; // = +0.500000
				6'h04: dct_cos_table = 32'h20000000; // = +0.500000
				6'h05: dct_cos_table = 32'he0000000; // = -0.500000
				6'h06: dct_cos_table = 32'he0000000; // = -0.500000
				6'h07: dct_cos_table = 32'h20000000; // = +0.500000
				6'h08: dct_cos_table = 32'h20000000; // = +0.500000
				6'h09: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0e: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h10: dct_cos_table = 32'h20000000; // = +0.500000
				6'h11: dct_cos_table = 32'he0000000; // = -0.500000
				6'h12: dct_cos_table = 32'he0000000; // = -0.500000
				6'h13: dct_cos_table = 32'h20000000; // = +0.500000
				6'h14: dct_cos_table = 32'h20000000; // = +0.500000
				6'h15: dct_cos_table = 32'he0000000; // = -0.500000
				6'h16: dct_cos_table = 32'he0000000; // = -0.500000
				6'h17: dct_cos_table = 32'h20000000; // = +0.500000
				6'h18: dct_cos_table = 32'h20000000; // = +0.500000
				6'h19: dct_cos_table = 32'he0000000; // = -0.500000
				6'h1a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h1b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h1e: dct_cos_table = 32'he0000000; // = -0.500000
				6'h1f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h20: dct_cos_table = 32'h20000000; // = +0.500000
				6'h21: dct_cos_table = 32'he0000000; // = -0.500000
				6'h22: dct_cos_table = 32'he0000000; // = -0.500000
				6'h23: dct_cos_table = 32'h20000000; // = +0.500000
				6'h24: dct_cos_table = 32'h20000000; // = +0.500000
				6'h25: dct_cos_table = 32'he0000000; // = -0.500000
				6'h26: dct_cos_table = 32'he0000000; // = -0.500000
				6'h27: dct_cos_table = 32'h20000000; // = +0.500000
				6'h28: dct_cos_table = 32'h20000000; // = +0.500000
				6'h29: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2e: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h30: dct_cos_table = 32'h20000000; // = +0.500000
				6'h31: dct_cos_table = 32'he0000000; // = -0.500000
				6'h32: dct_cos_table = 32'he0000000; // = -0.500000
				6'h33: dct_cos_table = 32'h20000000; // = +0.500000
				6'h34: dct_cos_table = 32'h20000000; // = +0.500000
				6'h35: dct_cos_table = 32'he0000000; // = -0.500000
				6'h36: dct_cos_table = 32'he0000000; // = -0.500000
				6'h37: dct_cos_table = 32'h20000000; // = +0.500000
				6'h38: dct_cos_table = 32'h20000000; // = +0.500000
				6'h39: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3e: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3f: dct_cos_table = 32'h20000000; // = +0.500000
			endcase
		6'h05:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h01: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h02: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h03: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h04: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h05: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h06: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h07: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h08: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h09: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h10: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h11: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h12: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h13: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h14: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h15: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h16: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h17: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h18: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h19: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h20: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h21: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h22: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h23: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h24: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h25: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h26: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h27: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h28: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h29: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h30: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h31: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h32: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h33: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h34: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h35: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h36: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h37: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h38: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h39: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3f: dct_cos_table = 32'he6db9640; // = -0.392847
			endcase
		6'h06:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h01: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h02: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h03: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h04: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h05: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h06: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h07: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h08: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h09: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0f: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h10: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h11: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h12: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h13: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h14: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h15: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h16: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h17: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h18: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h19: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1f: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h20: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h21: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h22: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h23: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h24: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h25: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h26: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h27: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h28: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h29: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2f: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h30: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h31: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h32: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h33: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h34: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h35: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h36: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h37: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h38: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h39: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3f: dct_cos_table = 32'h11517a7b; // = +0.270598
			endcase
		6'h07:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h01: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h02: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h03: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h04: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h05: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h06: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h07: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h08: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h09: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h10: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h11: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h12: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h13: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h14: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h15: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h16: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h17: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h18: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h19: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h20: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h21: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h22: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h23: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h24: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h25: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h26: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h27: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h28: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h29: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h30: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h31: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h32: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h33: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h34: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h35: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h36: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h37: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h38: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h39: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3f: dct_cos_table = 32'hf72bd511; // = -0.137950
			endcase
		6'h08:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h01: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h02: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h03: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h04: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h05: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h06: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h07: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h08: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h09: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0c: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0d: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0e: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0f: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h10: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h11: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h12: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h13: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h14: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h15: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h16: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h17: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h18: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h19: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1c: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1d: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1f: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h20: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h21: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h22: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h23: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h24: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h25: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h26: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h27: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h28: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h29: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2a: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2e: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h30: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h31: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h32: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h33: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h34: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h35: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h36: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h37: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h38: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h39: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3d: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3e: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
			endcase
		6'h09:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h01: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h02: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h03: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h04: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h05: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h06: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h07: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h08: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h09: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h0a: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h0b: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h0c: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h0d: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h0e: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h0f: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h10: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h11: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h12: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h13: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h14: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h15: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h16: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h17: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h18: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h19: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h1a: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h1b: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h1c: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h1d: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h1e: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h1f: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h20: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h21: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h22: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h23: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h24: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h25: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h26: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h27: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h28: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h29: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h2a: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h2b: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h2c: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h2d: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h2e: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h2f: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h30: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h31: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h32: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h33: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h34: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h35: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h36: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h37: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h38: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h39: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h3a: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h3b: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h3c: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h3d: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h3e: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h3f: dct_cos_table = 32'h3d906bcf; // = +0.961940
			endcase
		6'h0a:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h01: dct_cos_table = 32'h18056948; // = +0.375330
				6'h02: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h03: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h04: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h05: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h06: dct_cos_table = 32'h18056948; // = +0.375330
				6'h07: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h08: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h09: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h0a: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h0b: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h0c: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h0d: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h0e: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h0f: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h10: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h11: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h12: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h13: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h14: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h15: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h16: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h17: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h18: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h19: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h1a: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h1b: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h1c: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h1d: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h1e: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h1f: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h20: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h21: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h22: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h23: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h24: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h25: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h26: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h27: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h28: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h29: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h2a: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h2b: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h2c: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h2d: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h2e: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h2f: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h30: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h31: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h32: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h33: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h34: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h35: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h36: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h37: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h38: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h39: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h3a: dct_cos_table = 32'h18056948; // = +0.375330
				6'h3b: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h3c: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h3d: dct_cos_table = 32'h18056948; // = +0.375330
				6'h3e: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h3f: dct_cos_table = 32'hc6020207; // = -0.906127
			endcase
		6'h0b:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h01: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h02: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h03: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h04: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h05: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h06: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h07: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h08: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h09: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h0a: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h0b: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h0c: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h0d: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h0e: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h0f: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h10: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h11: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h12: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h13: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h14: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h15: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h16: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h17: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h18: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h19: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h1a: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h1b: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h1c: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h1d: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h1e: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h1f: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h20: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h21: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h22: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h23: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h24: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h25: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h26: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h27: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h28: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h29: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h2a: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h2b: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h2c: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h2d: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h2e: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h2f: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h30: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h31: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h32: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h33: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h34: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h35: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h36: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h37: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h38: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h39: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h3a: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h3b: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h3c: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h3d: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h3e: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h3f: dct_cos_table = 32'h34310a35; // = +0.815493
			endcase
		6'h0c:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h01: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h02: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h03: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h04: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h05: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h06: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h07: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h08: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h09: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0a: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0c: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0f: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h10: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h11: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h12: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h13: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h14: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h15: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h16: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h17: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h18: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h19: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1a: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1c: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1e: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1f: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h20: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h21: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h22: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h23: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h24: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h25: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h26: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h27: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h28: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h29: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2d: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h30: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h31: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h32: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h33: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h34: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h35: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h36: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h37: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h38: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h39: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3a: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
			endcase
		6'h0d:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h01: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h02: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h03: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h04: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h05: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h06: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h07: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h08: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h09: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h0a: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h0b: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h0c: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h0d: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h0e: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h0f: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h10: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h11: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h12: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h13: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h14: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h15: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h16: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h17: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h18: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h19: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h1a: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h1b: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h1c: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h1d: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h1e: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h1f: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h20: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h21: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h22: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h23: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h24: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h25: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h26: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h27: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h28: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h29: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h2a: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h2b: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h2c: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h2d: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h2e: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h2f: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h30: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h31: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h32: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h33: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h34: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h35: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h36: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h37: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h38: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h39: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h3a: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h3b: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h3c: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h3d: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h3e: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h3f: dct_cos_table = 32'h22df8fb9; // = +0.544895
			endcase
		6'h0e:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h18056948; // = +0.375330
				6'h01: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h02: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h03: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h04: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h05: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h06: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h07: dct_cos_table = 32'h18056948; // = +0.375330
				6'h08: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h09: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h0a: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h0b: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h0c: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h0d: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h0e: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h0f: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h10: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h11: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h12: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h13: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h14: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h15: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h16: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h17: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h18: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h19: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h1a: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h1b: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h1c: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h1d: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h1e: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h1f: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h20: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h21: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h22: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h23: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h24: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h25: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h26: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h27: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h28: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h29: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h2a: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h2b: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h2c: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h2d: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h2e: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h2f: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h30: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h31: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h32: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h33: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h34: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h35: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h36: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h37: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h38: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h39: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h3a: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h3b: dct_cos_table = 32'h18056948; // = +0.375330
				6'h3c: dct_cos_table = 32'h18056948; // = +0.375330
				6'h3d: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h3e: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h3f: dct_cos_table = 32'he7fa96b8; // = -0.375330
			endcase
		6'h0f:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h01: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h02: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h03: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h04: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h05: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h06: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h07: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h08: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h09: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h0a: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h0b: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h0c: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h0d: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h0e: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h0f: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h10: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h11: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h12: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h13: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h14: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h15: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h16: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h17: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h18: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h19: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h1a: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h1b: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h1c: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h1d: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h1e: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h1f: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h20: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h21: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h22: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h23: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h24: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h25: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h26: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h27: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h28: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h29: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h2a: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h2b: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h2c: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h2d: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h2e: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h2f: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h30: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h31: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h32: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h33: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h34: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h35: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h36: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h37: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h38: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h39: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h3a: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h3b: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h3c: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h3d: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h3e: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h3f: dct_cos_table = 32'h0c3ef153; // = +0.191342
			endcase
		6'h10:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h01: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h02: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h03: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h04: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h05: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h06: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h07: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h08: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h09: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0a: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0b: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0c: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0d: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0f: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h10: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h11: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h12: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h13: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h14: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h15: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h16: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h17: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h18: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h19: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1a: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1d: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1f: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h20: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h21: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h22: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h23: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h24: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h25: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h26: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h27: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h28: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h29: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2e: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2f: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h30: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h31: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h32: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h33: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h34: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h35: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h36: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h37: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h38: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h39: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3b: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3c: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3e: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3f: dct_cos_table = 32'h29cf5d22; // = +0.653281
			endcase
		6'h11:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h01: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h02: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h03: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h04: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h05: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h06: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h07: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h08: dct_cos_table = 32'h18056948; // = +0.375330
				6'h09: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h0a: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h0b: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h0c: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h0d: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h0e: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h0f: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h10: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h11: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h12: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h13: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h14: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h15: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h16: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h17: dct_cos_table = 32'h18056948; // = +0.375330
				6'h18: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h19: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h1a: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h1b: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h1c: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h1d: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h1e: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h1f: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h20: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h21: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h22: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h23: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h24: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h25: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h26: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h27: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h28: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h29: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h2a: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h2b: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h2c: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h2d: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h2e: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h2f: dct_cos_table = 32'h18056948; // = +0.375330
				6'h30: dct_cos_table = 32'h18056948; // = +0.375330
				6'h31: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h32: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h33: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h34: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h35: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h36: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h37: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h38: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h39: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h3a: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h3b: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h3c: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h3d: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h3e: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h3f: dct_cos_table = 32'hc6020207; // = -0.906127
			endcase
		6'h12:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h01: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h02: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h03: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h04: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h05: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h06: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h07: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h08: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h09: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h0a: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h0b: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h0c: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h0d: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h0e: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h0f: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h10: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h11: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h12: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h13: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h14: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h15: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h16: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h17: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h18: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h19: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h1a: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1b: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h1c: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h1d: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1e: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h1f: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h20: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h21: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h22: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h23: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h24: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h25: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h26: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h27: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h28: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h29: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h2a: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h2b: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h2c: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h2d: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h2e: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h2f: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h30: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h31: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h32: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h33: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h34: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h35: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h36: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h37: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h38: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h39: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h3a: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3b: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h3c: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h3d: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3e: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h3f: dct_cos_table = 32'h36a09e66; // = +0.853553
			endcase
		6'h13:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h01: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h02: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h03: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h04: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h05: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h06: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h07: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h08: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h09: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h0a: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h0b: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h0c: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h0d: dct_cos_table = 32'h18056948; // = +0.375330
				6'h0e: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h0f: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h10: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h11: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h12: dct_cos_table = 32'h18056948; // = +0.375330
				6'h13: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h14: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h15: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h16: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h17: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h18: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h19: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h1a: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h1b: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h1c: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h1d: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h1e: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h1f: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h20: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h21: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h22: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h23: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h24: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h25: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h26: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h27: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h28: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h29: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h2a: dct_cos_table = 32'h18056948; // = +0.375330
				6'h2b: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h2c: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h2d: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h2e: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h2f: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h30: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h31: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h32: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h33: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h34: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h35: dct_cos_table = 32'h18056948; // = +0.375330
				6'h36: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h37: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h38: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h39: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h3a: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h3b: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h3c: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h3d: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h3e: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h3f: dct_cos_table = 32'hced62cf7; // = -0.768178
			endcase
		6'h14:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h01: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h02: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h03: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h04: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h05: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h06: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h07: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h08: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h09: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0b: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0c: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0e: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0f: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h10: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h11: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h12: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h13: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h14: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h15: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h16: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h17: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h18: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h19: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1e: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1f: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h20: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h21: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h22: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h23: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h24: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h25: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h26: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h27: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h28: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h29: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2a: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2d: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2f: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h30: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h31: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h32: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h33: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h34: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h35: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h36: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h37: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h38: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h39: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3a: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3b: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3c: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3d: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3f: dct_cos_table = 32'h29cf5d22; // = +0.653281
			endcase
		6'h15:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h01: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h02: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h03: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h04: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h05: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h06: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h07: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h08: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h09: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h0a: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h0b: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h0c: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h0d: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h0e: dct_cos_table = 32'h18056948; // = +0.375330
				6'h0f: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h10: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h11: dct_cos_table = 32'h18056948; // = +0.375330
				6'h12: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h13: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h14: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h15: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h16: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h17: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h18: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h19: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h1a: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h1b: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h1c: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h1d: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h1e: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h1f: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h20: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h21: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h22: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h23: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h24: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h25: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h26: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h27: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h28: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h29: dct_cos_table = 32'h18056948; // = +0.375330
				6'h2a: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h2b: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h2c: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h2d: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h2e: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h2f: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h30: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h31: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h32: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h33: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h34: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h35: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h36: dct_cos_table = 32'h18056948; // = +0.375330
				6'h37: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h38: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h39: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h3a: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h3b: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h3c: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h3d: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h3e: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h3f: dct_cos_table = 32'hdf266bc8; // = -0.513280
			endcase
		6'h16:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h01: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h02: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h03: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h04: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h05: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h06: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h07: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h08: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h09: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h0a: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h0b: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h0c: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h0d: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h0e: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h0f: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h10: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h11: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h12: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h13: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h14: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h15: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h16: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h17: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h18: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h19: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h1a: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h1b: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1c: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1d: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h1e: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h1f: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h20: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h21: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h22: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h23: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h24: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h25: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h26: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h27: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h28: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h29: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h2a: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h2b: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h2c: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h2d: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h2e: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h2f: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h30: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h31: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h32: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h33: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h34: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h35: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h36: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h37: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h38: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h39: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h3a: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h3b: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3c: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3d: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h3e: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h3f: dct_cos_table = 32'h16a09e66; // = +0.353553
			endcase
		6'h17:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h01: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h02: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h03: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h04: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h05: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h06: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h07: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h08: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h09: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h0a: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h0b: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h0c: dct_cos_table = 32'h18056948; // = +0.375330
				6'h0d: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h0e: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h0f: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h10: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h11: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h12: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h13: dct_cos_table = 32'h18056948; // = +0.375330
				6'h14: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h15: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h16: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h17: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h18: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h19: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h1a: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h1b: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h1c: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h1d: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h1e: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h1f: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h20: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h21: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h22: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h23: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h24: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h25: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h26: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h27: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h28: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h29: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h2a: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h2b: dct_cos_table = 32'h18056948; // = +0.375330
				6'h2c: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h2d: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h2e: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h2f: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h30: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h31: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h32: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h33: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h34: dct_cos_table = 32'h18056948; // = +0.375330
				6'h35: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h36: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h37: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h38: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h39: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h3a: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h3b: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h3c: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h3d: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h3e: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h3f: dct_cos_table = 32'hf476f2d6; // = -0.180240
			endcase
		6'h18:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h01: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h02: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h03: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h04: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h05: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h06: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h07: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h08: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h09: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0a: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0e: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h10: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h11: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h12: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h13: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h14: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h15: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h16: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h17: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h18: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h19: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1a: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1e: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h20: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h21: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h22: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h23: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h24: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h25: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h26: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h27: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h28: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h29: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2a: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2b: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2f: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h30: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h31: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h32: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h33: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h34: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h35: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h36: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h37: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h38: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h39: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3a: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3b: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3f: dct_cos_table = 32'hda5f3a21; // = -0.587938
			endcase
		6'h19:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h01: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h02: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h03: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h04: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h05: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h06: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h07: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h08: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h09: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h0a: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h0b: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h0c: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h0d: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h0e: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h0f: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h10: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h11: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h12: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h13: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h14: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h15: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h16: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h17: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h18: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h19: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h1a: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h1b: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h1c: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h1d: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h1e: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h1f: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h20: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h21: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h22: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h23: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h24: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h25: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h26: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h27: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h28: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h29: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h2a: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h2b: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h2c: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h2d: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h2e: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h2f: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h30: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h31: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h32: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h33: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h34: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h35: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h36: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h37: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h38: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h39: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h3a: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h3b: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h3c: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h3d: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h3e: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h3f: dct_cos_table = 32'h34310a35; // = +0.815493
			endcase
		6'h1a:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h01: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h02: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h03: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h04: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h05: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h06: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h07: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h08: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h09: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h0a: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h0b: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h0c: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h0d: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h0e: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h0f: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h10: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h11: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h12: dct_cos_table = 32'h18056948; // = +0.375330
				6'h13: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h14: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h15: dct_cos_table = 32'h18056948; // = +0.375330
				6'h16: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h17: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h18: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h19: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h1a: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h1b: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h1c: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h1d: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h1e: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h1f: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h20: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h21: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h22: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h23: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h24: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h25: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h26: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h27: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h28: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h29: dct_cos_table = 32'h18056948; // = +0.375330
				6'h2a: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h2b: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h2c: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h2d: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h2e: dct_cos_table = 32'h18056948; // = +0.375330
				6'h2f: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h30: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h31: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h32: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h33: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h34: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h35: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h36: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h37: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h38: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h39: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h3a: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h3b: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h3c: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h3d: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h3e: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h3f: dct_cos_table = 32'hced62cf7; // = -0.768178
			endcase
		6'h1b:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h01: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h02: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h03: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h04: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h05: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h06: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h07: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h08: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h09: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h0a: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h0b: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h0c: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h0d: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h0e: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h0f: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h10: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h11: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h12: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h13: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h14: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h15: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h16: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h17: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h18: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h19: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h1a: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h1b: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h1c: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h1d: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h1e: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h1f: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h20: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h21: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h22: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h23: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h24: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h25: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h26: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h27: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h28: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h29: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h2a: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h2b: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h2c: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h2d: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h2e: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h2f: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h30: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h31: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h32: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h33: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h34: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h35: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h36: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h37: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h38: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h39: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h3a: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h3b: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h3c: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h3d: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h3e: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h3f: dct_cos_table = 32'h2c3ef153; // = +0.691342
			endcase
		6'h1c:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h01: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h02: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h03: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h04: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h05: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h06: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h07: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h08: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h09: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0d: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h10: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h11: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h12: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h13: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h14: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h15: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h16: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h17: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h18: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h19: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1d: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h20: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h21: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h22: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h23: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h24: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h25: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h26: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h27: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h28: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h29: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2b: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2d: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2e: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2f: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h30: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h31: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h32: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h33: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h34: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h35: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h36: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h37: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h38: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h39: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3b: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3d: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3e: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3f: dct_cos_table = 32'hda5f3a21; // = -0.587938
			endcase
		6'h1d:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h01: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h02: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h03: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h04: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h05: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h06: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h07: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h08: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h09: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h0a: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h0b: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h0c: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h0d: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h0e: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h0f: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h10: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h11: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h12: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h13: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h14: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h15: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h16: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h17: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h18: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h19: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h1a: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h1b: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h1c: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h1d: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h1e: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h1f: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h20: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h21: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h22: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h23: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h24: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h25: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h26: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h27: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h28: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h29: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h2a: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h2b: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h2c: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h2d: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h2e: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h2f: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h30: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h31: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h32: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h33: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h34: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h35: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h36: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h37: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h38: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h39: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h3a: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h3b: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h3c: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h3d: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h3e: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h3f: dct_cos_table = 32'h1d906bcf; // = +0.461940
			endcase
		6'h1e:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h01: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h02: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h03: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h04: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h05: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h06: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h07: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h08: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h09: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h0a: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h0b: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h0c: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h0d: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h0e: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h0f: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h10: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h11: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h12: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h13: dct_cos_table = 32'h18056948; // = +0.375330
				6'h14: dct_cos_table = 32'h18056948; // = +0.375330
				6'h15: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h16: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h17: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h18: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h19: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h1a: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h1b: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h1c: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h1d: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h1e: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h1f: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h20: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h21: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h22: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h23: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h24: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h25: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h26: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h27: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h28: dct_cos_table = 32'h18056948; // = +0.375330
				6'h29: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h2a: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h2b: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h2c: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h2d: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h2e: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h2f: dct_cos_table = 32'h18056948; // = +0.375330
				6'h30: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h31: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h32: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h33: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h34: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h35: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h36: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h37: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h38: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h39: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h3a: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h3b: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h3c: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h3d: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h3e: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h3f: dct_cos_table = 32'heba2c7e7; // = -0.318190
			endcase
		6'h1f:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h01: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h02: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h03: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h04: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h05: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h06: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h07: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h08: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h09: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h0a: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h0b: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h0c: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h0d: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h0e: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h0f: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h10: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h11: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h12: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h13: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h14: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h15: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h16: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h17: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h18: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h19: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h1a: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h1b: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h1c: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h1d: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h1e: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h1f: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h20: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h21: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h22: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h23: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h24: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h25: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h26: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h27: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h28: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h29: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h2a: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h2b: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h2c: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h2d: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h2e: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h2f: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h30: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h31: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h32: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h33: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h34: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h35: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h36: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h37: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h38: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h39: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h3a: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h3b: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h3c: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h3d: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h3e: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h3f: dct_cos_table = 32'h0a61ad13; // = +0.162212
			endcase
		6'h20:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h20000000; // = +0.500000
				6'h01: dct_cos_table = 32'h20000000; // = +0.500000
				6'h02: dct_cos_table = 32'h20000000; // = +0.500000
				6'h03: dct_cos_table = 32'h20000000; // = +0.500000
				6'h04: dct_cos_table = 32'h20000000; // = +0.500000
				6'h05: dct_cos_table = 32'h20000000; // = +0.500000
				6'h06: dct_cos_table = 32'h20000000; // = +0.500000
				6'h07: dct_cos_table = 32'h20000000; // = +0.500000
				6'h08: dct_cos_table = 32'he0000000; // = -0.500000
				6'h09: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0b: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0c: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0e: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0f: dct_cos_table = 32'he0000000; // = -0.500000
				6'h10: dct_cos_table = 32'he0000000; // = -0.500000
				6'h11: dct_cos_table = 32'he0000000; // = -0.500000
				6'h12: dct_cos_table = 32'he0000000; // = -0.500000
				6'h13: dct_cos_table = 32'he0000000; // = -0.500000
				6'h14: dct_cos_table = 32'he0000000; // = -0.500000
				6'h15: dct_cos_table = 32'he0000000; // = -0.500000
				6'h16: dct_cos_table = 32'he0000000; // = -0.500000
				6'h17: dct_cos_table = 32'he0000000; // = -0.500000
				6'h18: dct_cos_table = 32'h20000000; // = +0.500000
				6'h19: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1a: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1e: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h20: dct_cos_table = 32'h20000000; // = +0.500000
				6'h21: dct_cos_table = 32'h20000000; // = +0.500000
				6'h22: dct_cos_table = 32'h20000000; // = +0.500000
				6'h23: dct_cos_table = 32'h20000000; // = +0.500000
				6'h24: dct_cos_table = 32'h20000000; // = +0.500000
				6'h25: dct_cos_table = 32'h20000000; // = +0.500000
				6'h26: dct_cos_table = 32'h20000000; // = +0.500000
				6'h27: dct_cos_table = 32'h20000000; // = +0.500000
				6'h28: dct_cos_table = 32'he0000000; // = -0.500000
				6'h29: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2b: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2c: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2e: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2f: dct_cos_table = 32'he0000000; // = -0.500000
				6'h30: dct_cos_table = 32'he0000000; // = -0.500000
				6'h31: dct_cos_table = 32'he0000000; // = -0.500000
				6'h32: dct_cos_table = 32'he0000000; // = -0.500000
				6'h33: dct_cos_table = 32'he0000000; // = -0.500000
				6'h34: dct_cos_table = 32'he0000000; // = -0.500000
				6'h35: dct_cos_table = 32'he0000000; // = -0.500000
				6'h36: dct_cos_table = 32'he0000000; // = -0.500000
				6'h37: dct_cos_table = 32'he0000000; // = -0.500000
				6'h38: dct_cos_table = 32'h20000000; // = +0.500000
				6'h39: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3a: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3e: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3f: dct_cos_table = 32'h20000000; // = +0.500000
			endcase
		6'h21:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h01: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h02: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h03: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h04: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h05: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h06: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h07: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h08: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h09: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0a: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0c: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0d: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0e: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0f: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h10: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h11: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h12: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h13: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h14: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h15: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h16: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h17: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h18: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h19: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h20: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h21: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h22: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h23: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h24: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h25: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h26: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h27: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h28: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h29: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2a: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2c: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2d: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2e: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2f: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h30: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h31: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h32: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h33: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h34: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h35: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h36: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h37: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h38: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h39: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3b: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
			endcase
		6'h22:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h01: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h02: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h03: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h04: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h05: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h06: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h07: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h08: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h09: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0a: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0b: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0c: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0d: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0e: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h0f: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h10: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h11: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h12: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h13: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h14: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h15: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h16: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h17: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h18: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h19: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1f: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h20: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h21: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h22: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h23: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h24: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h25: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h26: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h27: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h28: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h29: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2a: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2b: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2c: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2d: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2e: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h2f: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h30: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h31: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h32: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h33: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h34: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h35: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h36: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h37: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h38: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h39: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3f: dct_cos_table = 32'h29cf5d22; // = +0.653281
			endcase
		6'h23:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h01: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h02: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h03: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h04: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h05: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h06: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h07: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h08: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h09: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0a: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0b: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0d: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0e: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0f: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h10: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h11: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h12: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h13: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h14: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h15: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h16: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h17: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h18: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h19: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1c: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1f: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h20: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h21: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h22: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h23: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h24: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h25: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h26: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h27: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h28: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h29: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2a: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2b: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2d: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2e: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2f: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h30: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h31: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h32: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h33: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h34: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h35: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h36: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h37: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h38: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h39: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3c: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3f: dct_cos_table = 32'hda5f3a21; // = -0.587938
			endcase
		6'h24:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h01: dct_cos_table = 32'he0000000; // = -0.500000
				6'h02: dct_cos_table = 32'he0000001; // = -0.500000
				6'h03: dct_cos_table = 32'h20000000; // = +0.500000
				6'h04: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h05: dct_cos_table = 32'he0000000; // = -0.500000
				6'h06: dct_cos_table = 32'he0000001; // = -0.500000
				6'h07: dct_cos_table = 32'h20000000; // = +0.500000
				6'h08: dct_cos_table = 32'he0000000; // = -0.500000
				6'h09: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0a: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h0b: dct_cos_table = 32'he0000000; // = -0.500000
				6'h0c: dct_cos_table = 32'he0000001; // = -0.500000
				6'h0d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h0e: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h0f: dct_cos_table = 32'he0000000; // = -0.500000
				6'h10: dct_cos_table = 32'he0000001; // = -0.500000
				6'h11: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h12: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h13: dct_cos_table = 32'he0000000; // = -0.500000
				6'h14: dct_cos_table = 32'he0000001; // = -0.500000
				6'h15: dct_cos_table = 32'h20000000; // = +0.500000
				6'h16: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h17: dct_cos_table = 32'he0000000; // = -0.500000
				6'h18: dct_cos_table = 32'h20000000; // = +0.500000
				6'h19: dct_cos_table = 32'he0000000; // = -0.500000
				6'h1a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h1b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h1c: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h1d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h1e: dct_cos_table = 32'he0000001; // = -0.500000
				6'h1f: dct_cos_table = 32'h20000000; // = +0.500000
				6'h20: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h21: dct_cos_table = 32'he0000001; // = -0.500000
				6'h22: dct_cos_table = 32'he0000001; // = -0.500000
				6'h23: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h24: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h25: dct_cos_table = 32'he0000000; // = -0.500000
				6'h26: dct_cos_table = 32'he0000001; // = -0.500000
				6'h27: dct_cos_table = 32'h20000000; // = +0.500000
				6'h28: dct_cos_table = 32'he0000000; // = -0.500000
				6'h29: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2a: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2b: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2c: dct_cos_table = 32'he0000000; // = -0.500000
				6'h2d: dct_cos_table = 32'h20000000; // = +0.500000
				6'h2e: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h2f: dct_cos_table = 32'he0000000; // = -0.500000
				6'h30: dct_cos_table = 32'he0000001; // = -0.500000
				6'h31: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h32: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h33: dct_cos_table = 32'he0000001; // = -0.500000
				6'h34: dct_cos_table = 32'he0000001; // = -0.500000
				6'h35: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h36: dct_cos_table = 32'h1fffffff; // = +0.500000
				6'h37: dct_cos_table = 32'he0000000; // = -0.500000
				6'h38: dct_cos_table = 32'h20000000; // = +0.500000
				6'h39: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3a: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3b: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3c: dct_cos_table = 32'h20000000; // = +0.500000
				6'h3d: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3e: dct_cos_table = 32'he0000000; // = -0.500000
				6'h3f: dct_cos_table = 32'h20000000; // = +0.500000
			endcase
		6'h25:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h01: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h02: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h03: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h04: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h05: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h06: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h07: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h08: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h09: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0a: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h0b: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0c: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0d: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h0e: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0f: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h10: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h11: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h12: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h13: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h14: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h15: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h16: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h17: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h18: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h19: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h1b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h1e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h20: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h21: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h22: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h23: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h24: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h25: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h26: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h27: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h28: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h29: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2a: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2b: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2c: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2d: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2e: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2f: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h30: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h31: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h32: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h33: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h34: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h35: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h36: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h37: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h38: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h39: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3f: dct_cos_table = 32'he6db9640; // = -0.392847
			endcase
		6'h26:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h01: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h02: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h03: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h04: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h05: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h06: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h07: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h08: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h09: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0a: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0b: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0c: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h0d: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0e: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0f: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h10: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h11: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h12: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h13: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h14: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h15: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h16: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h17: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h18: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h19: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h1e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h1f: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h20: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h21: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h22: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h23: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h24: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h25: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h26: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h27: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h28: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h29: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2a: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2b: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2c: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h2d: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2e: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2f: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h30: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h31: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h32: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h33: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h34: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h35: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h36: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h37: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h38: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h39: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h3e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h3f: dct_cos_table = 32'h11517a7b; // = +0.270598
			endcase
		6'h27:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h01: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h02: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h03: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h04: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h05: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h06: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h07: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h08: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h09: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0a: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h0b: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0d: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h0e: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0f: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h10: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h11: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h12: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h13: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h14: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h15: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h16: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h17: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h18: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h19: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h1a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h1f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h20: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h21: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h22: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h23: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h24: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h25: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h26: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h27: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h28: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h29: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h2a: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2b: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h2c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h2d: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2e: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h2f: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h30: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h31: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h32: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h33: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h34: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h35: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h36: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h37: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h38: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h39: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h3b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h3c: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h3d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h3e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3f: dct_cos_table = 32'hf72bd511; // = -0.137950
			endcase
		6'h28:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h01: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h02: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h03: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h04: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h05: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h06: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h07: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h08: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h09: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0d: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0e: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h10: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h11: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h12: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h13: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h14: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h15: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h16: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h17: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h18: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h19: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1c: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1d: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1e: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1f: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h20: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h21: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h22: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h23: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h24: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h25: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h26: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h27: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h28: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h29: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2a: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2e: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h30: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h31: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h32: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h33: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h34: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h35: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h36: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h37: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h38: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h39: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3a: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3e: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3f: dct_cos_table = 32'he6db9640; // = -0.392847
			endcase
		6'h29:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h01: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h02: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h03: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h04: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h05: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h06: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h07: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h08: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h09: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h0a: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h0b: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h0c: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h0d: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h0e: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h0f: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h10: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h11: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h12: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h13: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h14: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h15: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h16: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h17: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h18: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h19: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h1a: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h1b: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h1c: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h1d: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h1e: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h1f: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h20: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h21: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h22: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h23: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h24: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h25: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h26: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h27: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h28: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h29: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h2a: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h2b: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h2c: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h2d: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h2e: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h2f: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h30: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h31: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h32: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h33: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h34: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h35: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h36: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h37: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h38: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h39: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h3a: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h3b: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h3c: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h3d: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h3e: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h3f: dct_cos_table = 32'h22df8fb9; // = +0.544895
			endcase
		6'h2a:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h01: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h02: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h03: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h04: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h05: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h06: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h07: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h08: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h09: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h0a: dct_cos_table = 32'h18056948; // = +0.375330
				6'h0b: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h0c: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h0d: dct_cos_table = 32'h18056948; // = +0.375330
				6'h0e: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h0f: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h10: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h11: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h12: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h13: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h14: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h15: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h16: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h17: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h18: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h19: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h1a: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h1b: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h1c: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h1d: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h1e: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h1f: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h20: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h21: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h22: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h23: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h24: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h25: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h26: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h27: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h28: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h29: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h2a: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h2b: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h2c: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h2d: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h2e: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h2f: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h30: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h31: dct_cos_table = 32'h18056948; // = +0.375330
				6'h32: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h33: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h34: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h35: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h36: dct_cos_table = 32'h18056948; // = +0.375330
				6'h37: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h38: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h39: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h3a: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h3b: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h3c: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h3d: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h3e: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h3f: dct_cos_table = 32'hdf266bc8; // = -0.513280
			endcase
		6'h2b:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h01: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h02: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h03: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h04: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h05: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h06: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h07: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h08: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h09: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h0a: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h0b: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h0c: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h0d: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h0e: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h0f: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h10: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h11: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h12: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h13: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h14: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h15: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h16: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h17: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h18: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h19: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h1a: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h1b: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h1c: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h1d: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h1e: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h1f: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h20: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h21: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h22: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h23: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h24: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h25: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h26: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h27: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h28: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h29: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h2a: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h2b: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h2c: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h2d: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h2e: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h2f: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h30: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h31: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h32: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h33: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h34: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h35: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h36: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h37: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h38: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h39: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h3a: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h3b: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h3c: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h3d: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h3e: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h3f: dct_cos_table = 32'h1d906bcf; // = +0.461940
			endcase
		6'h2c:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h01: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h02: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h03: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h04: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h05: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h06: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h07: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h08: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h09: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0a: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h0d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h0f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h10: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h11: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h12: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h13: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h14: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h15: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h16: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h17: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h18: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h19: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1a: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1b: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1c: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h1d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h1f: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h20: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h21: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h22: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h23: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h24: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h25: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h26: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h27: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h28: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h29: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h2d: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h2f: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h30: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h31: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h32: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h33: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h34: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h35: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h36: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h37: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h38: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h39: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h3d: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h3f: dct_cos_table = 32'he6db9640; // = -0.392847
			endcase
		6'h2d:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h01: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h02: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h03: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h04: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h05: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h06: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h07: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h08: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h09: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h0a: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h0b: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h0c: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h0d: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h0e: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h0f: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h10: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h11: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h12: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h13: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h14: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h15: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h16: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h17: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h18: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h19: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h1a: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h1b: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h1c: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h1d: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h1e: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h1f: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h20: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h21: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h22: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h23: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h24: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h25: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h26: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h27: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h28: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h29: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h2a: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h2b: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h2c: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h2d: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h2e: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h2f: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h30: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h31: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h32: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h33: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h34: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h35: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h36: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h37: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h38: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h39: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h3a: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h3b: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h3c: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h3d: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h3e: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h3f: dct_cos_table = 32'h13c10eac; // = +0.308658
			endcase
		6'h2e:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h01: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h02: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h03: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h04: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h05: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h06: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h07: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h08: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h09: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h0a: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h0b: dct_cos_table = 32'h18056948; // = +0.375330
				6'h0c: dct_cos_table = 32'h18056948; // = +0.375330
				6'h0d: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h0e: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h0f: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h10: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h11: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h12: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h13: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h14: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h15: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h16: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h17: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h18: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h19: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h1a: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h1b: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h1c: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h1d: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h1e: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h1f: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h20: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h21: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h22: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h23: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h24: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h25: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h26: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h27: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h28: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h29: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h2a: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h2b: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h2c: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h2d: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h2e: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h2f: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h30: dct_cos_table = 32'h18056948; // = +0.375330
				6'h31: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h32: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h33: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h34: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h35: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h36: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h37: dct_cos_table = 32'h18056948; // = +0.375330
				6'h38: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h39: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h3a: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h3b: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h3c: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h3d: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h3e: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h3f: dct_cos_table = 32'hf264a36a; // = -0.212608
			endcase
		6'h2f:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h01: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h02: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h03: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h04: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h05: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h06: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h07: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h08: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h09: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h0a: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h0b: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h0c: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h0d: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h0e: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h0f: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h10: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h11: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h12: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h13: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h14: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h15: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h16: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h17: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h18: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h19: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h1a: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h1b: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h1c: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h1d: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h1e: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h1f: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h20: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h21: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h22: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h23: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h24: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h25: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h26: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h27: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h28: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h29: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h2a: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h2b: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h2c: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h2d: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h2e: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h2f: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h30: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h31: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h32: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h33: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h34: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h35: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h36: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h37: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h38: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h39: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h3a: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h3b: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h3c: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h3d: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h3e: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h3f: dct_cos_table = 32'h06efcd68; // = +0.108386
			endcase
		6'h30:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h01: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h02: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h03: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h04: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h05: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h06: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h07: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h08: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h09: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0a: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0d: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0f: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h10: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h11: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h12: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h13: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h14: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h15: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h16: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h17: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h18: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h19: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1e: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1f: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h20: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h21: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h22: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h23: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h24: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h25: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h26: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h27: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h28: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h29: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2b: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2c: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2e: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2f: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h30: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h31: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h32: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h33: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h34: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h35: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h36: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h37: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h38: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h39: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3a: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3b: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3c: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3d: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3f: dct_cos_table = 32'h11517a7b; // = +0.270598
			endcase
		6'h31:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h18056948; // = +0.375330
				6'h01: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h02: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h03: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h04: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h05: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h06: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h07: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h08: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h09: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h0a: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h0b: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h0c: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h0d: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h0e: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h0f: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h10: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h11: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h12: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h13: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h14: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h15: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h16: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h17: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h18: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h19: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h1a: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h1b: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h1c: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h1d: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h1e: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h1f: dct_cos_table = 32'h18056948; // = +0.375330
				6'h20: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h21: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h22: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h23: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h24: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h25: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h26: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h27: dct_cos_table = 32'h18056948; // = +0.375330
				6'h28: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h29: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h2a: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h2b: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h2c: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h2d: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h2e: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h2f: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h30: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h31: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h32: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h33: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h34: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h35: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h36: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h37: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h38: dct_cos_table = 32'h18056948; // = +0.375330
				6'h39: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h3a: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h3b: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h3c: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h3d: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h3e: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h3f: dct_cos_table = 32'he7fa96b8; // = -0.375330
			endcase
		6'h32:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h01: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h02: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h03: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h04: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h05: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h06: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h07: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h08: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h09: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h0a: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h0b: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h0c: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h0d: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h0e: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h0f: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h10: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h11: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h12: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h13: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h14: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h15: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h16: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h17: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h18: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h19: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h1a: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h1b: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1c: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1d: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h1e: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h1f: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h20: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h21: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h22: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h23: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h24: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h25: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h26: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h27: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h28: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h29: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h2a: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h2b: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h2c: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h2d: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h2e: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h2f: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h30: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h31: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h32: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h33: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h34: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h35: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h36: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h37: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h38: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h39: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h3a: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h3b: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3c: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3d: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h3e: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h3f: dct_cos_table = 32'h16a09e66; // = +0.353553
			endcase
		6'h33:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h01: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h02: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h03: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h04: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h05: dct_cos_table = 32'h18056948; // = +0.375330
				6'h06: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h07: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h08: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h09: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h0a: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h0b: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h0c: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h0d: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h0e: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h0f: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h10: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h11: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h12: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h13: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h14: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h15: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h16: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h17: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h18: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h19: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h1a: dct_cos_table = 32'h18056948; // = +0.375330
				6'h1b: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h1c: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h1d: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h1e: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h1f: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h20: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h21: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h22: dct_cos_table = 32'h18056948; // = +0.375330
				6'h23: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h24: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h25: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h26: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h27: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h28: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h29: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h2a: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h2b: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h2c: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h2d: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h2e: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h2f: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h30: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h31: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h32: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h33: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h34: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h35: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h36: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h37: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h38: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h39: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h3a: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h3b: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h3c: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h3d: dct_cos_table = 32'h18056948; // = +0.375330
				6'h3e: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h3f: dct_cos_table = 32'heba2c7e7; // = -0.318190
			endcase
		6'h34:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h01: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h02: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h03: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h04: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h05: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h06: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h07: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h08: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h09: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0a: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0b: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0c: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h0d: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0e: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h0f: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h10: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h11: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h12: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h13: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h14: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h15: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h16: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h17: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h18: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h19: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1a: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1b: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1c: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h1d: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1e: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h1f: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h20: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h21: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h22: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h23: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h24: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h25: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h26: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h27: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h28: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h29: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2a: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2b: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2c: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h2d: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2e: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h2f: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h30: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h31: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h32: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h33: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h34: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h35: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h36: dct_cos_table = 32'h29cf5d22; // = +0.653281
				6'h37: dct_cos_table = 32'hd630a2de; // = -0.653281
				6'h38: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h39: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3a: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3b: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3c: dct_cos_table = 32'h11517a7b; // = +0.270598
				6'h3d: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3e: dct_cos_table = 32'heeae8585; // = -0.270598
				6'h3f: dct_cos_table = 32'h11517a7b; // = +0.270598
			endcase
		6'h35:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h01: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h02: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h03: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h04: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h05: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h06: dct_cos_table = 32'h18056948; // = +0.375330
				6'h07: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h08: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h09: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h0a: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h0b: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h0c: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h0d: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h0e: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h0f: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h10: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h11: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h12: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h13: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h14: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h15: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h16: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h17: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h18: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h19: dct_cos_table = 32'h18056948; // = +0.375330
				6'h1a: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h1b: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h1c: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h1d: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h1e: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h1f: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h20: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h21: dct_cos_table = 32'h18056948; // = +0.375330
				6'h22: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h23: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h24: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h25: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h26: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h27: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h28: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h29: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h2a: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h2b: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h2c: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h2d: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h2e: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h2f: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h30: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h31: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h32: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h33: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h34: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h35: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h36: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h37: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h38: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h39: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h3a: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h3b: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h3c: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h3d: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h3e: dct_cos_table = 32'h18056948; // = +0.375330
				6'h3f: dct_cos_table = 32'hf264a36a; // = -0.212608
			endcase
		6'h36:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h01: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h02: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h03: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h04: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h05: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h06: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h07: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h08: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h09: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h0a: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h0b: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h0c: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h0d: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h0e: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h0f: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h10: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h11: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h12: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h13: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h14: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h15: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h16: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h17: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h18: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h19: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1a: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h1b: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h1c: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h1d: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h1e: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h1f: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h20: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h21: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h22: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h23: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h24: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h25: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h26: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h27: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h28: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h29: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h2a: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h2b: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h2c: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h2d: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h2e: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h2f: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h30: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h31: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h32: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h33: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h34: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h35: dct_cos_table = 32'hc95f619a; // = -0.853553
				6'h36: dct_cos_table = 32'h36a09e66; // = +0.853553
				6'h37: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h38: dct_cos_table = 32'h095f6199; // = +0.146447
				6'h39: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3a: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h3b: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h3c: dct_cos_table = 32'hf6a09e67; // = -0.146447
				6'h3d: dct_cos_table = 32'h16a09e66; // = +0.353553
				6'h3e: dct_cos_table = 32'he95f619a; // = -0.353553
				6'h3f: dct_cos_table = 32'h095f6199; // = +0.146447
			endcase
		6'h37:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h01: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h02: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h03: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h04: dct_cos_table = 32'h18056948; // = +0.375330
				6'h05: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h06: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h07: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h08: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h09: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h0a: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h0b: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h0c: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h0d: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h0e: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h0f: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h10: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h11: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h12: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h13: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h14: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h15: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h16: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h17: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h18: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h19: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h1a: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h1b: dct_cos_table = 32'h18056948; // = +0.375330
				6'h1c: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h1d: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h1e: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h1f: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h20: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h21: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h22: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h23: dct_cos_table = 32'h18056948; // = +0.375330
				6'h24: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h25: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h26: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h27: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h28: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h29: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h2a: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h2b: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h2c: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h2d: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h2e: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h2f: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h30: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h31: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h32: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h33: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h34: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h35: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h36: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h37: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h38: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h39: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h3a: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h3b: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h3c: dct_cos_table = 32'h18056948; // = +0.375330
				6'h3d: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h3e: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h3f: dct_cos_table = 32'hfb38ce5a; // = -0.074658
			endcase
		6'h38:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h01: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h02: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h03: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h04: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h05: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h06: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h07: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h08: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h09: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0a: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0d: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0e: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h10: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h11: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h12: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h13: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h14: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h15: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h16: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h17: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h18: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h19: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1a: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1d: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1e: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h20: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h21: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h22: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h23: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h24: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h25: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h26: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h27: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h28: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h29: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2a: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2b: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2d: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2e: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2f: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h30: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h31: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h32: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h33: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h34: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h35: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h36: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h37: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h38: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h39: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3a: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3d: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3e: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3f: dct_cos_table = 32'hf72bd511; // = -0.137950
			endcase
		6'h39:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h01: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h02: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h03: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h04: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h05: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h06: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h07: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h08: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h09: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h0a: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h0b: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h0c: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h0d: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h0e: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h0f: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h10: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h11: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h12: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h13: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h14: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h15: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h16: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h17: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h18: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h19: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h1a: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h1b: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h1c: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h1d: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h1e: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h1f: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h20: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h21: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h22: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h23: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h24: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h25: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h26: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h27: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h28: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h29: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h2a: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h2b: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h2c: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h2d: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h2e: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h2f: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h30: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h31: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h32: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h33: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h34: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h35: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h36: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h37: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h38: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h39: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h3a: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h3b: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h3c: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h3d: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h3e: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h3f: dct_cos_table = 32'h0c3ef153; // = +0.191342
			endcase
		6'h3a:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h01: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h02: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h03: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h04: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h05: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h06: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h07: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h08: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h09: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h0a: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h0b: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h0c: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h0d: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h0e: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h0f: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h10: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h11: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h12: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h13: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h14: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h15: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h16: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h17: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h18: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h19: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h1a: dct_cos_table = 32'h18056948; // = +0.375330
				6'h1b: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h1c: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h1d: dct_cos_table = 32'h18056948; // = +0.375330
				6'h1e: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h1f: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h20: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h21: dct_cos_table = 32'h18056948; // = +0.375330
				6'h22: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h23: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h24: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h25: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h26: dct_cos_table = 32'h18056948; // = +0.375330
				6'h27: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h28: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h29: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h2a: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h2b: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h2c: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h2d: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h2e: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h2f: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h30: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h31: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h32: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h33: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h34: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h35: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h36: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h37: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h38: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h39: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h3a: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h3b: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h3c: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h3d: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h3e: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h3f: dct_cos_table = 32'hf476f2d6; // = -0.180240
			endcase
		6'h3b:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h01: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h02: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h03: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h04: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h05: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h06: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h07: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h08: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h09: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h0a: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h0b: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h0c: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h0d: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h0e: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h0f: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h10: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h11: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h12: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h13: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h14: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h15: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h16: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h17: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h18: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h19: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h1a: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h1b: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h1c: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h1d: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h1e: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h1f: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h20: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h21: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h22: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h23: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h24: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h25: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h26: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h27: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h28: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h29: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h2a: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h2b: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h2c: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h2d: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h2e: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h2f: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h30: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h31: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h32: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h33: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h34: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h35: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h36: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h37: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h38: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h39: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h3a: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h3b: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h3c: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h3d: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h3e: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h3f: dct_cos_table = 32'h0a61ad13; // = +0.162212
			endcase
		6'h3c:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h01: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h02: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h03: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h04: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h05: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h06: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h07: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h08: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h09: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0a: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0b: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0c: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h0d: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0e: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h0f: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h10: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h11: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h12: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h13: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h14: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h15: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h16: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h17: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h18: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h19: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1a: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1b: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1c: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h1d: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1e: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h1f: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h20: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h21: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h22: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h23: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h24: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h25: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h26: dct_cos_table = 32'hd39d5e9e; // = -0.693520
				6'h27: dct_cos_table = 32'h2c62a162; // = +0.693520
				6'h28: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h29: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2a: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2b: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2c: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h2d: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2e: dct_cos_table = 32'h25a0c5df; // = +0.587938
				6'h2f: dct_cos_table = 32'hda5f3a21; // = -0.587938
				6'h30: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h31: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h32: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h33: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h34: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h35: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h36: dct_cos_table = 32'he6db9640; // = -0.392847
				6'h37: dct_cos_table = 32'h192469c0; // = +0.392847
				6'h38: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h39: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3a: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3b: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3c: dct_cos_table = 32'hf72bd511; // = -0.137950
				6'h3d: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3e: dct_cos_table = 32'h08d42aef; // = +0.137950
				6'h3f: dct_cos_table = 32'hf72bd511; // = -0.137950
			endcase
		6'h3d:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h01: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h02: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h03: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h04: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h05: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h06: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h07: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h08: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h09: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h0a: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h0b: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h0c: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h0d: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h0e: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h0f: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h10: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h11: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h12: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h13: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h14: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h15: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h16: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h17: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h18: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h19: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h1a: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h1b: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h1c: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h1d: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h1e: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h1f: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h20: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h21: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h22: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h23: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h24: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h25: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h26: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h27: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h28: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h29: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h2a: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h2b: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h2c: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h2d: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h2e: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h2f: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h30: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h31: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h32: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h33: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h34: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h35: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h36: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h37: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h38: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h39: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h3a: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h3b: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h3c: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h3d: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h3e: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h3f: dct_cos_table = 32'h06efcd68; // = +0.108386
			endcase
		6'h3e:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h01: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h02: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h03: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h04: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h05: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h06: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h07: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h08: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h09: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h0a: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h0b: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h0c: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h0d: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h0e: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h0f: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h10: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h11: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h12: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h13: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h14: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h15: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h16: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h17: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h18: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h19: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h1a: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h1b: dct_cos_table = 32'h18056948; // = +0.375330
				6'h1c: dct_cos_table = 32'h18056948; // = +0.375330
				6'h1d: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h1e: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h1f: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h20: dct_cos_table = 32'h18056948; // = +0.375330
				6'h21: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h22: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h23: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h24: dct_cos_table = 32'he7fa96b8; // = -0.375330
				6'h25: dct_cos_table = 32'h39fdfdf9; // = +0.906127
				6'h26: dct_cos_table = 32'hc6020207; // = -0.906127
				6'h27: dct_cos_table = 32'h18056948; // = +0.375330
				6'h28: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h29: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h2a: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h2b: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h2c: dct_cos_table = 32'h145d3819; // = +0.318190
				6'h2d: dct_cos_table = 32'hced62cf7; // = -0.768178
				6'h2e: dct_cos_table = 32'h3129d309; // = +0.768178
				6'h2f: dct_cos_table = 32'heba2c7e7; // = -0.318190
				6'h30: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h31: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h32: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h33: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h34: dct_cos_table = 32'hf264a36a; // = -0.212608
				6'h35: dct_cos_table = 32'h20d99438; // = +0.513280
				6'h36: dct_cos_table = 32'hdf266bc8; // = -0.513280
				6'h37: dct_cos_table = 32'h0d9b5c96; // = +0.212608
				6'h38: dct_cos_table = 32'hfb38ce5a; // = -0.074658
				6'h39: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h3a: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h3b: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h3c: dct_cos_table = 32'h04c731a6; // = +0.074658
				6'h3d: dct_cos_table = 32'hf476f2d6; // = -0.180240
				6'h3e: dct_cos_table = 32'h0b890d2a; // = +0.180240
				6'h3f: dct_cos_table = 32'hfb38ce5a; // = -0.074658
			endcase
		6'h3f:
			case ( {y,x} )	// synopsys full_case parallel_case
				6'h00: dct_cos_table = 32'h026f9430; // = +0.038060
				6'h01: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h02: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h03: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h04: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h05: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h06: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h07: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h08: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h09: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h0a: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h0b: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h0c: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h0d: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h0e: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h0f: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h10: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h11: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h12: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h13: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h14: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h15: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h16: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h17: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h18: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h19: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h1a: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h1b: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h1c: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h1d: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h1e: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h1f: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h20: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h21: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h22: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h23: dct_cos_table = 32'hc26f9431; // = -0.961940
				6'h24: dct_cos_table = 32'h3d906bcf; // = +0.961940
				6'h25: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h26: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h27: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h28: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h29: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h2a: dct_cos_table = 32'hd3c10ead; // = -0.691342
				6'h2b: dct_cos_table = 32'h34310a35; // = +0.815493
				6'h2c: dct_cos_table = 32'hcbcef5cb; // = -0.815493
				6'h2d: dct_cos_table = 32'h2c3ef153; // = +0.691342
				6'h2e: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h2f: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h30: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h31: dct_cos_table = 32'hec3ef154; // = -0.308658
				6'h32: dct_cos_table = 32'h1d906bcf; // = +0.461940
				6'h33: dct_cos_table = 32'hdd207047; // = -0.544895
				6'h34: dct_cos_table = 32'h22df8fb9; // = +0.544895
				6'h35: dct_cos_table = 32'he26f9431; // = -0.461940
				6'h36: dct_cos_table = 32'h13c10eac; // = +0.308658
				6'h37: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h38: dct_cos_table = 32'hfd906bd0; // = -0.038060
				6'h39: dct_cos_table = 32'h06efcd68; // = +0.108386
				6'h3a: dct_cos_table = 32'hf59e52ed; // = -0.162212
				6'h3b: dct_cos_table = 32'h0c3ef153; // = +0.191342
				6'h3c: dct_cos_table = 32'hf3c10ead; // = -0.191342
				6'h3d: dct_cos_table = 32'h0a61ad13; // = +0.162212
				6'h3e: dct_cos_table = 32'hf9103298; // = -0.108386
				6'h3f: dct_cos_table = 32'h026f9430; // = +0.038060
			endcase
	endcase

end
endfunction




module dct(
	clk,
	ena,
	rst,
	dstrb,
	din,
	dout_00, dout_01, dout_02, dout_03, dout_04, dout_05, dout_06, dout_07,
	dout_10, dout_11, dout_12, dout_13, dout_14, dout_15, dout_16, dout_17,
	dout_20, dout_21, dout_22, dout_23, dout_24, dout_25, dout_26, dout_27,
	dout_30, dout_31, dout_32, dout_33, dout_34, dout_35, dout_36, dout_37,
	dout_40, dout_41, dout_42, dout_43, dout_44, dout_45, dout_46, dout_47,
	dout_50, dout_51, dout_52, dout_53, dout_54, dout_55, dout_56, dout_57,
	dout_60, dout_61, dout_62, dout_63, dout_64, dout_65, dout_66, dout_67,
	dout_70, dout_71, dout_72, dout_73, dout_74, dout_75, dout_76, dout_77,
	douten
);

	//
	// parameters
	//
	// Worst case errors (Din = 64* -128) remain in decimal bit
	// when using 13bit coefficients
	//
	// For ultra-high
	parameter coef_width = 11;
	parameter di_width = 8;
	parameter do_width = 12;

	//
	// inputs & outputs
	//

	input clk;
	input ena;
	input rst;   // active low asynchronous reset

	input dstrb; // data-strobe. Present dstrb 1clk-cycle before data block
	input  [di_width:1] din;
	output [do_width:1]
		dout_00, dout_01, dout_02, dout_03, dout_04, dout_05, dout_06, dout_07,
		dout_10, dout_11, dout_12, dout_13, dout_14, dout_15, dout_16, dout_17,
		dout_20, dout_21, dout_22, dout_23, dout_24, dout_25, dout_26, dout_27,
		dout_30, dout_31, dout_32, dout_33, dout_34, dout_35, dout_36, dout_37,
		dout_40, dout_41, dout_42, dout_43, dout_44, dout_45, dout_46, dout_47,
		dout_50, dout_51, dout_52, dout_53, dout_54, dout_55, dout_56, dout_57,
		dout_60, dout_61, dout_62, dout_63, dout_64, dout_65, dout_66, dout_67,
		dout_70, dout_71, dout_72, dout_73, dout_74, dout_75, dout_76, dout_77;

	output douten; // data-out enable
	reg douten;

	//
	// variables
	//
	reg go, dgo, ddgo, ddcnt, dddcnt;
	reg [di_width:1] ddin;

	//
	// module body
	//

	// generate sample counter
	reg  [5:0] sample_cnt;
	wire       dcnt     = &sample_cnt;

	always @(posedge clk or negedge rst)
	  if (~rst)
	     sample_cnt <= #1 6'h0;
	  else if (ena)
	    if(dstrb)
	      sample_cnt <= #1 6'h0;
	    else if(~dcnt)
	      sample_cnt <= #1 sample_cnt + 6'h1;

	// internal signals
	always @(posedge clk or negedge rst)
	  if (~rst)
	  begin
	      go     <= #1 1'b0;
		  dgo    <= #1 1'b0;
		  ddgo   <= #1 1'b0;
		  ddin   <= #1 0;

	      douten <= #1 1'b0;
	      ddcnt  <= #1 1'b1;
	      dddcnt <= #1 1'b1;
	  end
	  else if (ena)
	  begin
	      go     <= #1 dstrb;
	      dgo    <= #1 go;
	      ddgo   <= #1 dgo;
	      ddin   <= #1 din;

	      ddcnt  <= #1 dcnt;
	      dddcnt <= #1 ddcnt;

	      douten <= #1 ddcnt & ~dddcnt;
	  end

	// Hookup DCT units

	// V = 0
	dctub #(coef_width, di_width, 3'h0)
	dct_block_0 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_00), // (U,V) = (0,0)
		.dout1(dout_01), // (U,V) = (0,1)
		.dout2(dout_02), // (U,V) = (0,2)
		.dout3(dout_03), // (U,V) = (0,3)
		.dout4(dout_04), // (U,V) = (0,4)
		.dout5(dout_05), // (U,V) = (0,5)
		.dout6(dout_06), // (U,V) = (0,6)
		.dout7(dout_07)  // (U,V) = (0,7)
	);

	// V = 1
	dctub #(coef_width, di_width, 3'h1)
	dct_block_1 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_10), // (U,V) = (1,0)
		.dout1(dout_11), // (U,V) = (1,1)
		.dout2(dout_12), // (U,V) = (1,2)
		.dout3(dout_13), // (U,V) = (1,3)
		.dout4(dout_14), // (U,V) = (1,4)
		.dout5(dout_15), // (U,V) = (1,5)
		.dout6(dout_16), // (U,V) = (1,6)
		.dout7(dout_17)  // (U,V) = (1,7)
	);

	// V = 2
	dctub #(coef_width, di_width, 3'h2)
	dct_block_2 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_20), // (U,V) = (2,0)
		.dout1(dout_21), // (U,V) = (2,1)
		.dout2(dout_22), // (U,V) = (2,2)
		.dout3(dout_23), // (U,V) = (2,3)
		.dout4(dout_24), // (U,V) = (2,4)
		.dout5(dout_25), // (U,V) = (2,5)
		.dout6(dout_26), // (U,V) = (2,6)
		.dout7(dout_27)  // (U,V) = (2,7)
	);

	// V = 3
	dctub #(coef_width, di_width, 3'h3)
	dct_block_3 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_30), // (U,V) = (3,0)
		.dout1(dout_31), // (U,V) = (3,1)
		.dout2(dout_32), // (U,V) = (3,2)
		.dout3(dout_33), // (U,V) = (3,3)
		.dout4(dout_34), // (U,V) = (3,4)
		.dout5(dout_35), // (U,V) = (3,5)
		.dout6(dout_36), // (U,V) = (3,6)
		.dout7(dout_37)  // (U,V) = (3,7)
	);

	// V = 4
	dctub #(coef_width, di_width, 3'h4)
	dct_block_4 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_40), // (U,V) = (4,0)
		.dout1(dout_41), // (U,V) = (4,1)
		.dout2(dout_42), // (U,V) = (4,2)
		.dout3(dout_43), // (U,V) = (4,3)
		.dout4(dout_44), // (U,V) = (4,4)
		.dout5(dout_45), // (U,V) = (4,5)
		.dout6(dout_46), // (U,V) = (4,6)
		.dout7(dout_47)  // (U,V) = (4,7)
	);

	// V = 5
	dctub #(coef_width, di_width, 3'h5)
	dct_block_5 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_50), // (U,V) = (5,0)
		.dout1(dout_51), // (U,V) = (5,1)
		.dout2(dout_52), // (U,V) = (5,2)
		.dout3(dout_53), // (U,V) = (5,3)
		.dout4(dout_54), // (U,V) = (5,4)
		.dout5(dout_55), // (U,V) = (5,5)
		.dout6(dout_56), // (U,V) = (5,6)
		.dout7(dout_57)  // (U,V) = (5,7)
	);

	// V = 6
	dctub #(coef_width, di_width, 3'h6)
	dct_block_6 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_60), // (U,V) = (6,0)
		.dout1(dout_61), // (U,V) = (6,1)
		.dout2(dout_62), // (U,V) = (6,2)
		.dout3(dout_63), // (U,V) = (6,3)
		.dout4(dout_64), // (U,V) = (6,4)
		.dout5(dout_65), // (U,V) = (6,5)
		.dout6(dout_66), // (U,V) = (6,6)
		.dout7(dout_67)  // (U,V) = (6,7)
	);

	// V = 7
	dctub #(coef_width, di_width, 3'h7)
	dct_block_7 (
		.clk(clk),
		.ena(ena),
		.ddgo(ddgo),
		.x(sample_cnt[2:0]),
		.y(sample_cnt[5:3]),
		.ddin(ddin),
		.dout0(dout_70), // (U,V) = (7,0)
		.dout1(dout_71), // (U,V) = (7,1)
		.dout2(dout_72), // (U,V) = (7,2)
		.dout3(dout_73), // (U,V) = (7,3)
		.dout4(dout_74), // (U,V) = (7,4)
		.dout5(dout_75), // (U,V) = (7,5)
		.dout6(dout_76), // (U,V) = (7,6)
		.dout7(dout_77)  // (U,V) = (7,7)
	);
endmodule
