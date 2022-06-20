#include <iverilog/vpi_user.h>

#include "../../systemC/link_sc.h"

int counter;
int data_iteration_vlog=0;
int position;

#include <stdio.h>
#include <iostream>
#include <dlfcn.h>
#include <random>
#include <string.h>

using namespace std;

void* lib_handle;

Control_SC* (*create)();
void (*destroy)(Control_SC*);

Control_SC* SC_TOP;

s_vpi_value v_generate;

s_vpi_value reset;
s_vpi_value dout_value;
s_vpi_value sout_value;
s_vpi_value din_value;
s_vpi_value sin_value;
s_vpi_value fsm_value;
s_vpi_value value_to_tx;
s_vpi_value value_to_rx;

s_vpi_value message_value;

s_vpi_value link_enable_value;
s_vpi_value auto_start_value;
s_vpi_value link_disable_value;

#define SEND_DATA  		0
#define WAIT_DATA 		1

#define SEND_TIME_CODE 	0
#define WAIT_500_CYCLES	1

unsigned int state_test;

unsigned int state_test_rx;

unsigned int counter_null;

#include "run_sim.h"
#include "global_init.h"
#include "global_reset.h"

#include "write_tx_spw.h"
#include "receive_rx_spw.h"

void interaction_register()
{
      s_vpi_systf_data tf_data;

      tf_data.type      = vpiSysTask;
      tf_data.sysfunctype = 0;
      tf_data.tfname    = "$run_sim";
      tf_data.calltf    = run_sim_calltf;
      tf_data.compiletf = 0;
      tf_data.sizetf    = 0;
      tf_data.user_data = 0;
      vpi_register_systf(&tf_data);

      tf_data.type      = vpiSysTask;
      tf_data.sysfunctype = 0;
      tf_data.tfname    = "$write_tx_spw";
      tf_data.calltf    = write_tx_spw_calltf;
      tf_data.compiletf = 0;
      tf_data.sizetf    = 0;
      tf_data.user_data = 0;
      vpi_register_systf(&tf_data);

      tf_data.type      = vpiSysTask;
      tf_data.sysfunctype = 0;
      tf_data.tfname    = "$receive_rx_spw";
      tf_data.calltf    = receive_rx_spw_calltf;
      tf_data.compiletf = 0;
      tf_data.sizetf    = 0;
      tf_data.user_data = 0;
      vpi_register_systf(&tf_data);

      tf_data.type      = vpiSysTask;
      tf_data.sysfunctype = 0;
      tf_data.tfname    = "$global_reset";
      tf_data.calltf    = global_reset_calltf;
      tf_data.compiletf = 0;
      tf_data.sizetf    = 0;
      tf_data.user_data = 0;
      vpi_register_systf(&tf_data);

      tf_data.type      = vpiSysTask;
      tf_data.sysfunctype = 0;
      tf_data.tfname    = "$global_init";
      tf_data.calltf    = global_init_calltf;
      tf_data.compiletf = 0;
      tf_data.sizetf    = 0;
      tf_data.user_data = 0;
      vpi_register_systf(&tf_data);
}

void (*vlog_startup_routines[])() = {
    interaction_register,
    0
};

