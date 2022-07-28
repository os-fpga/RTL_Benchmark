#include <systemc>
#include <iostream>
#include "top.h"
#include "power_model.h"

using namespace sc_core;

double oi_energy = 0;
double ei_energy = 0;
double oi_delay = 0;
double ei_delay = 0;

int sc_main(int argc, char *argv[])
{
	cout << "---------------------------------------------" << endl;
	cout << "ROW: [" << ROW << "], COLUMN: [" << COLUMN << "]"<< endl;
	sc_set_time_resolution(1, SC_NS);

	top noc("noc");

	sc_clock clk("clk",10,SC_NS,0.5);
	sc_trace_file *tf;

	tf = sc_create_vcd_trace_file("noc");
	tf->set_time_unit(1,SC_NS);

	noc.clk(clk.signal());

	sc_trace(tf, noc.clk, "clk");
	sc_trace(tf, noc.reset_n, "reset_n");

	//Signal between tile1 and tile2. 
 	sc_trace(tf, noc.data_in[0], "data_in0");
	sc_trace(tf, noc.data_out[0], "data_out0");
	sc_trace(tf, noc.oi_in[0], "OI_in0");
	sc_trace(tf, noc.oi_out[0], "OI_out0");

	sc_trace(tf, noc.in_full[0],"in_full0");
	sc_trace(tf, noc.out_full[0], "out_full0");
	sc_trace(tf, noc.in_sel[0], "in_sel0");
	sc_trace(tf, noc.out_sel[0], "out_sel0");
	sc_trace(tf, noc.in_write_n[0], "in_write_n0");
	sc_trace(tf, noc.out_write_n[0], "out_write_n0");

	sc_start(5000, SC_NS);
	sc_close_vcd_trace_file(tf);
	Energy_disp();
	return 0;
}
