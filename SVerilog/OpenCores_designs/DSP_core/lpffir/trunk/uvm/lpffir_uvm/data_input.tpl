agent_name = data_input

number_of_instances = 1

trans_item = input_tx
trans_var  = rand logic [15:0] data;

trans_var  = constraint c_data { 0 <= data; data < 128; }

driver_inc_inside_class = data_input_driver_inc_inside_class.sv  inline
driver_inc_after_class  = data_input_driver_inc_after_class.sv   inline
monitor_inc             = data_input_do_mon.sv                   inline
agent_cover_inc         = data_input_cover_inc.sv                inline

if_port  = logic last;
if_port  = logic valid;
if_port  = logic ready;
if_port  = logic [15:0] data;
if_port  = logic clk;
if_port  = logic reset;
if_clock = clk
if_reset = reset
