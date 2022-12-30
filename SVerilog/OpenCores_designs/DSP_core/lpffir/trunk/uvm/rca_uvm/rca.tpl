# Agent
agent_name = rca

# Transaction
trans_item = trans
trans_var = rand logic [15:0] input1;
trans_var = rand logic [15:0] input2;
trans_var = rand logic carryinput;
trans_var = logic carryoutput;
trans_var = logic [15:0] sum;

# Constraint
trans_var  = constraint c_addr_a { 0 <= input1; input1 < 5; }
trans_var  = constraint c_addr_b { 0 <= input2; input2 < 5; }

# UVM Interface
if_port = logic [15:0] a;
if_port = logic [15:0] b;
if_port = logic ci;
if_port = logic co;
if_port = logic [15:0] s;
if_port = logic clk;

# Test Clock
if_clock = clk

# Driver and Monitor pointer
driver_inc = rca_driver_inc.sv inline
monitor_inc = rca_monitor_inc.sv inline