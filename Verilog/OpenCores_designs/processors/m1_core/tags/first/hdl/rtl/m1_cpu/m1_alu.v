/*
 * Simply RISC M1 ALU & Multiplier & Divider
 *
 * Three modules (alu, multiplier, divider) with Alternating Bit Protocol (ABP) interface.
 */

`include "m1_defs.h"

// Combinational ALU with 32-bit operands
module alu(a_i, b_i, func_i, signed_i, result_o, carry_o);

  // I/O Ports
  input[31:0] a_i, b_i;        // Operands
  input[4:0] func_i;           // Function to be performed
  input signed_i;              // Operation is signed
  output[31:0] result_o;       // Result
  output carry_o;              // Carry bit

  // Registers
  reg[31:0] result_o;          // Registered output of result  

  // ALU Logic
  always @(a_i or b_i or func_i or signed_i) begin
    case(func_i)
      `ALU_OP_SLL: result_o = a_i << b_i;
      `ALU_OP_SRL: result_o = a_i >> b_i;
      `ALU_OP_SRA: result_o = {{32{a_i[31]}}, a_i } >> b_i;
      `ALU_OP_ADD: result_o = a_i + b_i;
      `ALU_OP_SUB: result_o = a_i - b_i;
      `ALU_OP_AND: result_o = a_i & b_i;
      `ALU_OP_OR:  result_o = a_i | b_i;
      `ALU_OP_XOR: result_o = a_i ^ b_i;
//      `ALU_OP_NOR: result_o = a_i ~| b_i;
      `ALU_OP_SEQ: result_o = (a_i == b_i) ? 32'b1 : 32'b0;
      `ALU_OP_SNE: result_o = (a_i != b_i) ? 32'b1 : 32'b0;
      `ALU_OP_SLT: if(signed_i) result_o = ({~a_i[31],a_i[30:0]} < {~b_i[31],b_i[30:0]}) ? 32'b1 : 32'b0;
                   else result_o = a_i < b_i;
      `ALU_OP_SLE: if ((a_i[31] == 1'b1) || (a_i == 32'b0)) result_o = 32'b1;   
                   else result_o = 32'b0;                        
      `ALU_OP_SGT: if ((a_i[31] == 1'b0) && (a_i != 32'b0)) result_o = 32'b1;   
                   else result_o = 32'b0;                        
      `ALU_OP_SGE: if(signed_i) result_o = ({~a_i[31],a_i[30:0]} >= {~b_i[31],b_i[30:0]}) ? 32'b1 : 32'b0;
                   else result_o = a_i >= b_i;
    endcase
  end

endmodule

// 32-bit * 32-bit Integer Multiplier (this version is not optimized and always takes 32 cycles)
module multiplier(sys_reset_i, sys_clock_i, a_i, b_i, signed_i, product_o, abp_req_i, abp_ack_o);

  // I/O ports
  input        sys_reset_i;      // System Reset
  input        sys_clock_i;      // System Clock
  input[31:0]  a_i, b_i;         // Operands of multiplication
  input        signed_i;         // If multiplication is signed
  output[63:0] product_o;        // Product of multiplication
  input        abp_req_i;        // ABP Request
  output       abp_ack_o;        // ABP Acknowledgement

  // Registers
  reg[63:0]    a_latched;        // Latched 'a' input
  reg[31:0]    b_latched;        // Latched 'b' input
  reg[63:0]    product_o;        // Registered output of result
  reg[63:0]    product_tmp;      // Temporary result
  reg          abp_ack_o;        // Registered output of ABP Ack
  reg          negative_output;  // If output is negative
  reg[5:0]     count;            // Downward counter (32->0)
  reg          abp_last;         // Level of last ABP request

  // Sequential logic
  always @(posedge sys_clock_i) begin

    // Initialization
    if(sys_reset_i) begin

      product_o = 0;
      abp_ack_o = 0;
      negative_output = 0;
      count = 6'd0;
      abp_last = 0;

    // New request
    end else if(abp_req_i!=abp_last) begin

      abp_last = abp_req_i;     // Latch level of ABP request
      count  = 6'd32;           // Start counter
      product_tmp = 0;          // Initialize result
      a_latched = (!signed_i || !a_i[31]) ? { 32'd0, a_i } : { 32'd0, (~a_i+1'b1) };
      b_latched = (!signed_i || !b_i[31]) ? b_i : (~b_i + 1'b1); 
      negative_output = signed_i && (a_i[31] ^ b_i[31]);
      product_o = (!negative_output) ? product_tmp : (~product_tmp+1);  // Degugging only
        
    // Calculating
    end else if(count>0) begin

      count = count-1;
      if(b_latched[0]==1) product_tmp = product_tmp + a_latched;
      a_latched = a_latched << 1;
      b_latched = b_latched >> 1;
      product_o = (!negative_output) ? product_tmp : (~product_tmp + 1);  // Debugging only

    // Return the result
    end else if(count==0) begin

      abp_ack_o = abp_req_i;    // Return the result
      product_o = (!negative_output) ? product_tmp : (~product_tmp + 1);

    end

  end

endmodule

// 32-bit / 32-bit Integer Divider (this version is not optimized and always takes 32 cycles)
module divider(sys_reset_i, sys_clock_i, a_i, b_i, signed_i, quotient_o, remainder_o, abp_req_i, abp_ack_o);

  // I/O ports
  input        sys_reset_i;      // System Reset
  input        sys_clock_i;      // System Clock
  input[31:0]  a_i, b_i;         // Operands of division
  input        signed_i;         // If division is signed
  output[31:0] quotient_o;       // Quotient of division
  output[31:0] remainder_o;      // Remainder of division
  input        abp_req_i;        // ABP Request
  output       abp_ack_o;        // ABP Acknowledgement

  // Registers
  reg[63:0]    a_latched;        // Latched 'a' input
  reg[63:0]    b_latched;        // Latched 'b' input
  reg[31:0]    quotient_o;       // Registered output of result
  reg[31:0]    quotient_tmp;     // Temporary result
  reg[31:0]    remainder_o;      // Registered output of result
  reg[31:0]    remainder_tmp;    // Temporary result
  reg          abp_ack_o;        // Registered output of ABP Ack
  reg          negative_output;  // If output is negative
  reg[5:0]     count;            // Downward counter (32->0)
  reg          abp_last;         // Level of last ABP request
  reg[63:0]    diff;             // Difference

  // Sequential logic
  always @(posedge sys_clock_i) begin

    // Initialization
    if(sys_reset_i) begin

      quotient_o = 0;
      remainder_o = 0;
      abp_ack_o = 0;
      negative_output = 0;
      count = 6'd0;
      abp_last = 0;

    // New request
    end else if(abp_req_i!=abp_last) begin

      abp_last = abp_req_i;     // Latch level of ABP request
      count  = 6'd32;           // Start counter
      quotient_tmp = 0;         // Initialize result
      remainder_tmp = 0;        // Initialize result
      a_latched = (!signed_i || !a_i[31]) ? { 32'd0, a_i } : { 32'd0, (~a_i + 1'b1) };
      b_latched = (!signed_i || !b_i[31]) ? { 1'b0, b_i, 31'd0 } : { 1'b0, ~b_i + 1'b1, 31'd0 };
      negative_output = signed_i && (a_i[31] ^ b_i[31]);
      quotient_o = (!negative_output) ? quotient_tmp : (~quotient_tmp+1);  // Debugging only
      remainder_o = (!negative_output) ? a_latched[31:0] : (~a_latched[31:0]+1);  // Debugging only
        
    // Calculating
    end else if(count>0) begin

      count = count-1;
      diff = a_latched-b_latched;
      quotient_tmp = quotient_tmp << 1;
      if(!diff[63]) begin
        a_latched = diff;
        quotient_tmp[0] = 1;
      end
      b_latched = b_latched >> 1;
      quotient_o = (!negative_output) ? quotient_tmp : (~quotient_tmp+1);  // Debugging only
      remainder_o = (!negative_output) ? a_latched[31:0] : (~a_latched[31:0]+1);  // Debugging only

    // Return the result
    end else if(count==0) begin

      abp_ack_o = abp_req_i;    // Return the result
      quotient_o = (!negative_output) ? quotient_tmp : (~quotient_tmp+1);
      remainder_o = (!negative_output) ? a_latched[31:0] : (~a_latched[31:0]+1);

    end

  end

endmodule

/*
// Testbench
module testbench;
  reg sys_clock_i, sys_reset_i;
  reg[31:0] a_i,b_i;
  wire[63:0] product_o;
  wire[31:0] quotient_o, remainder_o;
  reg signed_i,abp_req_i_mul,abp_req_i_div;
  wire abp_ack_o_mul,abp_ack_o_div;

  multiplier mul_0(sys_reset_i, sys_clock_i, a_i, b_i, signed_i, product_o, abp_req_i_mul, abp_ack_o_mul);
  divider div_0(sys_reset_i, sys_clock_i, a_i, b_i, signed_i, quotient_o, remainder_o, abp_req_i_div, abp_ack_o_div);

  initial begin

    $dumpfile("trace.vcd");
    $dumpvars();

    sys_clock_i = 0;
    sys_reset_i = 1;
    abp_req_i_mul = 0;
    abp_req_i_div = 0;
    #100
    sys_reset_i = 0;
    #100

    a_i = 17;
    b_i = 3;
    signed_i = 0;
    abp_req_i_mul = !abp_req_i_mul;
    #100
    $display("Try unsigned 17*3: Product is %d", product_o);

    a_i = 20;
    b_i = 4;
    signed_i = 1;
    abp_req_i_div = !abp_req_i_div;
    #100
    $display("Try signed 20/4: Quotient is %d and remainder is %d", quotient_o, remainder_o);

    a_i = -7;
    b_i = 3;
    signed_i = 1;
    abp_req_i_mul = !abp_req_i_mul;
    #100
    $display("Try signed -7*3: Product is %d", product_o);

    a_i = 17;
    b_i = 5;
    signed_i = 0;
    abp_req_i_div = !abp_req_i_div;
    #100
    $display("Try unsigned 17/5: Quotient is %d and remainder is %d", quotient_o, remainder_o);

    $finish();
  end

  always #1 sys_clock_i = !sys_clock_i;

endmodule
*/