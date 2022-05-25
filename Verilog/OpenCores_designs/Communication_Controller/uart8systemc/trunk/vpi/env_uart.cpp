#include <iverilog/vpi_user.h>

#include "../systemC/link_sc.h"

int counter;
int counter_reset;

unsigned int new_clock;

#include <stdio.h>
#include <iostream>
#include <dlfcn.h>
#include <random>
#include <vector>
#include<string.h>

unsigned int data_cnt=0;

using namespace std;

vector<unsigned int> data;
vector<unsigned int> parity;


void* lib_handle;

//typedef void (*ThreadSCRun_dl)();
//ThreadSCRun_dl ThreadSC;

Control_SC* (*create)();
void (*destroy)(Control_SC*);

Control_SC* SC_UART;

s_vpi_value v_generate;

s_vpi_value reset;
s_vpi_value rx_value;
s_vpi_value tx_value;

s_vpi_value ready_rx;
s_vpi_value start_tx;
s_vpi_value ready_tx;

#include "run_sim.h"
#include "reset_uart.h"
#include "global_init.h"

void uart_test_suit_register()
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
      tf_data.tfname    = "$reset_uart";
      tf_data.calltf    = reset_uart_calltf;
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
    uart_test_suit_register,
    0
};

