agent_name = data_output

number_of_instances = 1

trans_item = output_tx
trans_var  = rand logic [15:0] data;

agent_coverage_enable = no

driver_inc_inside_class = data_output_driver_inc_inside_class.sv  inline
driver_inc_after_class  = data_output_driver_inc_after_class.sv   inline
monitor_inc = data_output_do_mon.sv inline

if_port  = logic last;
if_port  = logic valid;
if_port  = logic ready;
if_port  = logic [15:0] data;
if_port  = logic clk;
if_port  = logic reset;
if_clock = clk
if_reset = reset
