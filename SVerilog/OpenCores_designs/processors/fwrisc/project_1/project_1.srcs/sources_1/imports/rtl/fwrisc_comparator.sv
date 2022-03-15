/****************************************************************************
 * fwrisc_comparator.sv
 * 
 * Copyright 2018 Matthew Ballance
 * 
 * Licensed under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in
 * writing, software distributed under the License is
 * distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied.  See
 * the License for the specific language governing
 * permissions and limitations under the License.
 ****************************************************************************/

`include "fwrisc_defines.vh"

/**
 * Module: fwrisc_comparator
 * 
 * TODO: Add module documentation
 */
module fwrisc_comparator(
		input			clock,
		input			reset,
		input[31:0]		in_a,
		input[31:0]		in_b,
		input[1:0]		op,
		output reg		out
		);
	
	always @* begin
		case (op) 
			`COMPARE_EQ: out = (in_a == in_b);
			`COMPARE_LT: out = ($signed(in_a) < $signed(in_b));
			default: /*COMPARE_LTU:*/ out = (in_a < in_b);
		endcase
	end

endmodule


