dut_top               = lpffir_axis
nested_config_objects = yes

tb_prepend_to_initial = vcd_dump.sv inline

#Path ignored on EDA Playground
#syosil_scoreboard_src_path = ../../syosil/src

ref_model_input  = reference m_data_input_agent

ref_model_output = reference m_data_output_agent

ref_model_compare_method    = reference iop

ref_model_inc_inside_class  = reference reference_inc_inside_class.sv  inline
ref_model_inc_after_class   = reference reference_inc_after_class.sv   inline

top_default_seq_count = 10

uvm_cmdline = +UVM_VERBOSITY=UVM_HIGH
