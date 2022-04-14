#VCOM    = /usr/local/bin/vcom 
VCOMOPS = -explicit -check_synthesis -2002 -quiet 
#MAKEFLAGS = --silent
HDL_DIR = ../rtl/vhdl/


##
# avs_aes hdl files
##
CORE_SRC =$(HDL_DIR)/core/mod_sim_exp_pkg.vhd \
		 $(HDL_DIR)/core/adder_block.vhd \
		 $(HDL_DIR)/core/adder_n.vhd \
	 	 $(HDL_DIR)/core/autorun_cntrl.vhd \
		 $(HDL_DIR)/core/cell_1b_adder.vhd \
		 $(HDL_DIR)/core/cell_1b_mux.vhd \
		 $(HDL_DIR)/core/cell_1b.vhd \
		 $(HDL_DIR)/core/counter_sync.vhd \
		 $(HDL_DIR)/core/d_flip_flop.vhd \
		 $(HDL_DIR)/core/fifo_primitive.vhd \
		 $(HDL_DIR)/core/first_stage.vhd \
		 $(HDL_DIR)/core/last_stage.vhd \
		 $(HDL_DIR)/core/modulus_ram.vhd \
		 $(HDL_DIR)/core/mont_ctrl.vhd \
		 $(HDL_DIR)/core/mont_mult_sys_pipeline.vhd \
		 $(HDL_DIR)/core/mod_sim_exp_core.vhd \
		 $(HDL_DIR)/core/operand_dp.vhd \
		 $(HDL_DIR)/core/operand_mem.vhd \
		 $(HDL_DIR)/core/operand_ram.vhd \
		 $(HDL_DIR)/core/operands_sp.vhd \
		 $(HDL_DIR)/core/register_1b.vhd \
		 $(HDL_DIR)/core/register_n.vhd \
		 $(HDL_DIR)/core/standard_cell_block.vhd \
		 $(HDL_DIR)/core/standard_stage.vhd \
		 $(HDL_DIR)/core/stepping_logic.vhd \
		 $(HDL_DIR)/core/systolic_pipeline.vhd \
		 $(HDL_DIR)/core/x_shift_reg.vhd \


##
# Testbench HDL file
##
TB_SRC_DIR = ../bench/vhdl/
TB_SRC =  $(TB_SRC_DIR)mod_sim_exp_core_tb.vhd 

#######################################
all: mod_sim_exp

clean:
	rm -rf *_lib

mod_sim_exp_lib: 
	vlib mod_sim_exp

work_lib:
	vlib work

libs: mod_sim_exp work_lib

mod_sim_exp_com: mod_sim_exp_lib   
	#echo --
	#echo building Modular Exponentiation Core
	#echo --
	vcom $(VCOMOPS) -work mod_sim_exp  $(CORE_SRC)

mod_sim_exp_tb: work_lib
	#echo --
	#echo building Modular Exponentiation Core Testbench
	#echo --
	vcom $(VCOMOPS) -work work $(TB_SRC)

mod_sim_exp: mod_sim_exp_com mod_sim_exp_tb 
	vsim -c -do mod_sim_exp.do -lib work mod_sim_exp_core_tb
