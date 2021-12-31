// $Id: c_constants.v 4079 2011-10-22 21:59:12Z dub $

/*
 Copyright (c) 2007-2011, Trustees of The Leland Stanford Junior University
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 Redistributions of source code must retain the above copyright notice, this 
 list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this
 list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//==============================================================================
// global constant definitions
//==============================================================================


//------------------------------------------------------------------------------
// reset handling
//------------------------------------------------------------------------------

// asynchronous reset
`define RESET_TYPE_ASYNC 0

// synchronous reset
`define RESET_TYPE_SYNC  1

`define RESET_TYPE_LAST `RESET_TYPE_SYNC


//------------------------------------------------------------------------------
// arbiter types
//------------------------------------------------------------------------------

// round-robin arbiter
`define ARBITER_TYPE_ROUND_ROBIN 0

// matrix arbiter
`define ARBITER_TYPE_MATRIX      1

// DesignWare first-come, first-serve arbiter
`define ARBITER_TYPE_DW_FCFS     2

`define ARBITER_TYPE_LAST `ARBITER_TYPE_DW_FCFS


//------------------------------------------------------------------------------
// error checker capture more
//------------------------------------------------------------------------------

// disable error reporting
`define ERROR_CAPTURE_MODE_NONE       0
// don't hold errors
`define ERROR_CAPTURE_MODE_NO_HOLD    1

// capture first error only (subsequent errors are blocked)
`define ERROR_CAPTURE_MODE_HOLD_FIRST 2

// capture all errors
`define ERROR_CAPTURE_MODE_HOLD_ALL   3

`define ERROR_CAPTURE_MODE_LAST `ERROR_CAPTURE_MODE_HOLD_ALL


//------------------------------------------------------------------------------
// crossbar implementation variants
//------------------------------------------------------------------------------

// tristate-based
`define CROSSBAR_TYPE_TRISTATE 0

// mux-based
`define CROSSBAR_TYPE_MUX      1

// distributed multiplexers
`define CROSSBAR_TYPE_DIST_MUX 2

`define CROSSBAR_TYPE_LAST `CROSSBAR_TYPE_DIST_MUX


//------------------------------------------------------------------------------
// register file implemetation variants
//------------------------------------------------------------------------------

// 2D array implemented using flipflops
`define REGFILE_TYPE_FF_2D           0

// 1D array of flipflops, read using a combinational mux
`define REGFILE_TYPE_FF_1D_MUX       1

// 1D array of flipflops, read using a tristate mux
`define REGFILE_TYPE_FF_1D_TRISTATE  2

// Synopsys DesignWare implementation using flipflips
`define REGFILE_TYPE_FF_DW           3

// 2D array implemented using flipflops
`define REGFILE_TYPE_LAT_2D          4

// 1D array of flipflops, read using a combinational mux
`define REGFILE_TYPE_LAT_1D_MUX      5

// 1D array of flipflops, read using a tristate mux
`define REGFILE_TYPE_LAT_1D_TRISTATE 6

// Synopsys DesignWare implementation using flipflips
`define REGFILE_TYPE_LAT_DW          7

`define REGFILE_TYPE_LAST `REGFILE_TYPE_LAT_DW


//------------------------------------------------------------------------------
// directions of rotation
//------------------------------------------------------------------------------

`define ROTATE_DIR_LEFT  0
`define ROTATE_DIR_RIGHT 1


//------------------------------------------------------------------------------
// wavefront allocator implementation variants
//------------------------------------------------------------------------------

// variant which uses multiplexers to permute inputs and outputs based on 
// priority
`define WF_ALLOC_TYPE_MUX  0

// variant which replicates the entire allocation logic for the different 
// priorities and selects the result from the appropriate one
`define WF_ALLOC_TYPE_REP  1

// variant implementing a Diagonal Propagation Arbiter as described in Hurt et 
// al, "Design and Implementation of High-Speed Symmetric Crossbar Schedulers"
`define WF_ALLOC_TYPE_DPA  2

// variant which rotates inputs and outputs based on priority
`define WF_ALLOC_TYPE_ROT  3

// variant which uses wraparound (forming a false combinational loop) as 
// described in Dally et al, "Principles and Practices of Interconnection 
// Networks"
`define WF_ALLOC_TYPE_LOOP 4

`define WF_ALLOC_TYPE_LAST `WF_ALLOC_TYPE_LOOP


//------------------------------------------------------------------------------
// binary operators
//------------------------------------------------------------------------------

`define BINARY_OP_AND  0
`define BINARY_OP_NAND 1
`define BINARY_OP_OR   2
`define BINARY_OP_NOR  3
`define BINARY_OP_XOR  4
`define BINARY_OP_XNOR 5

`define BINARY_OP_LAST `BINARY_OP_XNOR
