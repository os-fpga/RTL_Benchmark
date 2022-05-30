#include <systemc.h>
#include <stdio.h>
#include <vector>
#include <string>
#include <stdlib.h> 
#include <gtkmm.h>
#include <random>
#include <boost/thread.hpp>

using namespace std;
using namespace Gtk;
using namespace boost;

#include "../gladicapi/data_recorder.h"
#include "../gladicapi/data_check.h"

bool EEP_EOP;

unsigned int finish = 0;
bool link_start = false;
bool link_disable = false;
bool auto_start = false;

//systemc and verilog
bool global_reset = false;

//verilog variables
bool verilog_link_start = false;
bool verilog_link_disable = false;
bool verilog_auto_start = false;
int frquency_nano_second = 500;

vector<string> data_col_store;
data_recorder *REC_TX_SPW;
data_check    *COMPARE_SPW;

vector<string> data_col_store0;
data_recorder *REC_TX_SPWSC;
data_check    *COMPARE_SPW_RX;

unsigned long int a = 0;
int clock_systemc   = 2;

//send data systemC

bool start_send_data_verilog  = false;
bool enable_time_code_verilog = false;

bool start_send_data = false;
bool start_tick_data = false;

vector<sc_uint<9> > data_generated_sc;
sc_uint<9> intermediate_systemc;
sc_uint<9> intermediate_sc;
unsigned int data_iteration_sc_aux = 0;
unsigned int data_iteration_sc = 0;

vector<sc_uint<9> > data_generated_verilog;
sc_uint<9> intermediate;
sc_uint<9> intermediate_verilog;

unsigned int data_iteration = 0;
unsigned int data_iteration_vlog = 0;
sc_uint<9> intermediate_data;


void data_rx_sc_o(unsigned int type_char, sc_uint<4> control, sc_uint<4> last_control_sys , sc_uint<10> data , sc_uint<10> timecode_sys);

#include "top_spw.h"

//Data generation
unsigned long int max_data = 255; 

std::random_device rd;
std::uniform_int_distribution<unsigned long int> data_in(0,255);
std::uniform_int_distribution<unsigned long int> nchar(1,max_data);//eop-eep

class sc_TOP_SPW;

SC_MODULE(sc_TOP_SPW)
{

	sc_clock CLOCK;
	sc_signal<bool>  RESET;
	sc_signal<bool> LINK_START;
	sc_signal<bool> LINK_DISABLE;
	sc_signal<bool> AUTO_START;
	sc_signal<sc_uint<4> > FSM_SPW_OUT;
	sc_signal<sc_uint<4> > FSM_TX;

	sc_signal<sc_uint<10> > CLOCK_GEN;
	sc_signal<bool> E_SEND_DATA;


	sc_signal<bool> BUFFER_READY;
	sc_signal<sc_uint<9> > DATARX_FLAG;
	sc_signal<bool> BUFFER_WRITE;

	sc_signal<sc_uint<8> > TIME_OUT;
	sc_signal<bool>	TICK_OUT;
	sc_signal<bool>	CONTROL_FLAG_OUT;

	sc_signal<uint> DOUT;
	sc_signal<uint> SOUT;
	sc_signal<uint>  DIN;
	sc_signal<uint>  SIN;

	sc_TOP DUT;

  	SC_CTOR(sc_TOP_SPW) :CLOCK("CLOCK",20,SC_NS),
			   RESET("RESET"),
			   LINK_DISABLE("LINK_DISABLE"),
			   LINK_START("LINK_START"),
			   AUTO_START("AUTO_START"),
			   FSM_SPW_OUT("FSM_SPW_OUT"),
			   CLOCK_GEN("CLOCK_GEN"),
			   E_SEND_DATA("E_SEND_DATA"),
			   DOUT("DOUT"),
			   SOUT("SOUT"),

			   FSM_TX("FSM_TX"),
			   DIN("DIN"),
			   SIN("SIN"),
			   BUFFER_READY("BUFFER_READY"),
			   DATARX_FLAG("DATARX_FLAG"),
			   BUFFER_WRITE("BUFFER_WRITE"),
			   TIME_OUT("TIME_OUT"),
			   TICK_OUT("TICK_OUT"),
			   CONTROL_FLAG_OUT("CONTROL_FLAG_OUT"),


	DUT("DUT") { 
	DUT.CLOCK(CLOCK);
	DUT.RESET(RESET);
	DUT.LINK_DISABLE(LINK_DISABLE);
	DUT.AUTO_START(AUTO_START);
	DUT.LINK_START(LINK_START);
	DUT.FSM_SPW_OUT(FSM_SPW_OUT);
	DUT.CLOCK_GEN(CLOCK_GEN);
	DUT.E_SEND_DATA(E_SEND_DATA);
	DUT.FSM_TX(FSM_TX);
	DUT.DOUT(DOUT);
	DUT.SOUT(SOUT);

	DUT.DIN(DIN);
	DUT.SIN(SIN);
	DUT.BUFFER_READY(BUFFER_READY);
	DUT.DATARX_FLAG(DATARX_FLAG);
	DUT.BUFFER_WRITE(BUFFER_WRITE);
	DUT.TIME_OUT(TIME_OUT);
	DUT.TICK_OUT(TICK_OUT);
	DUT.CONTROL_FLAG_OUT(CONTROL_FLAG_OUT);

	cout << "SC_CTOR(sc_TOP_SPW)" << endl;
	}

};

Glib::RefPtr<Gtk::Builder> builder;

Gtk::Window *window;

Gtk::Button *BtnFinsihSimulation;
Gtk::Button *BtnLinkEnable;
Gtk::Button *BtnLinkDisable;
Gtk::Button *BtnAutoStart;
Gtk::Button *BtnReset;

Gtk::Button *BtnSpaceWireVerilog;
Gtk::CheckButton *CheckbtnLinkEnable;
Gtk::CheckButton *CheckbtnAutoStart;
Gtk::CheckButton *CheckbtnLinkDisable;

//Execute test
Gtk::Button *BtnSimpleTest;
Gtk::CheckButton *CheckBtnEop;
Gtk::CheckButton *CheckBtnEep;
Gtk::CheckButton *CheckBtnTimeCode;

//Generate data
Gtk::Button *BtnGenerationDataVerilog;
Gtk::CheckButton *CheckBtnEopGenVerilog;
Gtk::CheckButton *CheckBtnEepGenVerilog;
Gtk::CheckButton *CheckBtnTimeCodeGenVerilog;

Gtk::Button *BtnTxFrequency;
Gtk::Entry  *EntryFrequency;

Gtk::Button *BtnChangeFrequencyVerilog;
Gtk::Entry  *EntryFrequencyVerilog;

Gtk::Button *BtnSendDataScTx;
Gtk::Button *BtnTimeCodeScTx;
Gtk::Button *BtnGenerateDataSc;

Gtk::CheckButton *CheckBtnEepGenSystemC;
Gtk::CheckButton *CheckBtnEopGenSystemC;


Gtk::Label *lblStatus;


sc_TOP_SPW *sn_top;

extern "C" Control_SC* create_object()
{
  return new Control_SC;
}

extern "C" void destroy_object( Control_SC* object )
{
  delete object;
}

/*GTKMM CONTROL*/
void on_BtnFinsihSimulation_clicked()
{
	cout<< "End Simulation" <<endl;
 	Gtk::Main::quit();
	finish = 1;
	REC_TX_SPW->endsimulation();
	REC_TX_SPWSC->endsimulation();
}

void on_BtnLinkEnable_clicked()
{
	link_start = !link_start;
}

void on_BtnLinkDisable_clicked()
{
	link_disable = !link_disable;
}

void on_BtnAutoStart_clicked()
{
	auto_start = !auto_start;
}

void on_BtnReset_clicked()
{
	global_reset = !global_reset;
}


void on_BtnSpaceWireVerilog_clicked()
{


	if(!CheckbtnLinkEnable->get_active())
	{
		verilog_link_start = false;
		lblStatus->set_text("LINKENABLE VERILOG IS OFF");
	}

	if(!CheckbtnAutoStart->get_active())
	{
		verilog_auto_start = false;
		lblStatus->set_text("AUTOSTART VERILOG IS OFF");
	}

	if(!CheckbtnLinkDisable->get_active())
	{
		verilog_link_disable = false;
		lblStatus->set_text("AUTOSTART VERILOG IS OFF");
	}

	if(CheckbtnLinkEnable->get_active())
	{
		verilog_link_start = true;
		lblStatus->set_text("LINKENABLE VERILOG IS ON");
	}

	if(CheckbtnAutoStart->get_active())
	{
		verilog_auto_start = true;
		lblStatus->set_text("AUTOSTART VERILOG IS ON");
	}

	if(CheckbtnLinkDisable->get_active())
	{
		verilog_link_disable = true;
		lblStatus->set_text("LINKDISABLE VERILOG IS ON");
	}

}


void on_BtnSimpleTest_clicked()
{

	if(CheckBtnEopGenVerilog->get_active())
	{
		start_send_data_verilog = true;
	}
	else
	{
		start_send_data_verilog = false;
	}

	if(CheckBtnTimeCodeGenVerilog->get_active())
	{
		enable_time_code_verilog = true;
	}
	else
	{
		enable_time_code_verilog = false;
	}

}

void on_BtnGenerationDataVerilog_clicked()
{
	data_generated_verilog.clear();
	data_iteration=0;
	data_iteration_vlog=0;
	if(CheckBtnEopGenVerilog->get_active())
	{
		for(int cnt_max_data = 0; cnt_max_data < max_data;cnt_max_data++)
		{
			if(cnt_max_data >= 0 && cnt_max_data < max_data)
			{
				intermediate_verilog(7,0) = data_in(rd);
				intermediate_verilog(8,8) = 0;

				data_generated_verilog.push_back(intermediate_verilog);
			}
			intermediate_verilog=0;

		}

		intermediate_verilog(8,8) = 1;
		intermediate_verilog(7,0) = 0;

		data_generated_verilog.push_back(intermediate_verilog);
		intermediate_verilog=0;
	}else if(CheckBtnEepGenVerilog->get_active())
	{
		for(unsigned int cnt_max_data = 0; cnt_max_data <= max_data;cnt_max_data++)
		{
			if(cnt_max_data == 0 || cnt_max_data == max_data)
			{
				intermediate_verilog(8,8) = 1;
				intermediate_verilog(7,0) = 1;
			}else if(cnt_max_data > 0 && cnt_max_data < max_data)
			{
				intermediate_verilog(7,0) = data_in(rd);
				intermediate_verilog(8,8) = 0;
			}
			else
			{
				intermediate_verilog(7,0) = data_in(rd);
				intermediate_verilog(8,8) = 0;
			}
			data_generated_verilog.push_back(intermediate_verilog);
			intermediate_verilog=0;
		}
		intermediate_verilog(7,0) = 1;
		intermediate_verilog(8,8) = 1;
		data_generated_verilog[nchar(rd)] = intermediate_verilog;
	}
}

void on_BtnTxFrequency_clicked()
{

	string aux = EntryFrequency->get_text();
	switch(atoi(aux.c_str()))
	{
		case 2:
			sn_top->CLOCK_GEN = 1;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 2MHz");
		break;
		case 10:
			sn_top->CLOCK_GEN = 2;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 10MHz");
		break;
		case 20:
			sn_top->CLOCK_GEN = 4;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 20MHz");
		break;
		case 50:
			sn_top->CLOCK_GEN = 8;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 50MHz");
		break;
		case 100:
			sn_top->CLOCK_GEN = 16;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 100MHz");
		break;
		case 150:
			sn_top->CLOCK_GEN = 32;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 150MHz");
		break;
		case 200:
			sn_top->CLOCK_GEN = 64;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 200MHz");
		break;
		case 201:
			sn_top->CLOCK_GEN = 128;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 201MHz");
		break;
		case 250:
			sn_top->CLOCK_GEN = 256;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 250MHz");
		break;
		case 280:
			sn_top->CLOCK_GEN = 512;
			lblStatus->set_text("TX CLOCK SYSTEMC SET IN 280MHz");
		break;
	}

}

void on_BtnTimeCodeScTx_clicked()
{
	start_tick_data = !start_tick_data;
	if(start_tick_data)
	{lblStatus->set_text("TIME CODE ENABLED ON TX SYSTEMC");}
	else
	{lblStatus->set_text("TIME CODE DISABLED ON TX SYSTEMC");}
}

void on_BtnSendDataScTx_clicked() 
{
	start_send_data = !start_send_data;
	if(start_send_data)
	{lblStatus->set_text("SEND DATA ENABLED TX SYSTEMC");}
	else
	{lblStatus->set_text("SEND DATA DISABLED TX SYSTEMC");}
}

void on_BtnGenerateDataSc_clicked()
{
	data_generated_sc.clear();
	data_iteration_sc_aux=0;
	data_iteration_sc=0;
	if(CheckBtnEopGenSystemC->get_active())
	{
		for(int cnt_max_data = 0; cnt_max_data <= max_data;cnt_max_data++)
		{
			if(cnt_max_data > 0 && cnt_max_data < max_data)
			{
				intermediate_sc(7,0) = data_in(rd);
				intermediate_sc(8,8) = 0;
			}
			data_generated_sc.push_back(intermediate_sc);
		}

		intermediate_sc(8,8) = 1;
		intermediate_sc(7,0) = 0;

		data_generated_sc.push_back(intermediate_verilog);
		intermediate_sc=0;

	}else if(CheckBtnEepGenSystemC->get_active())
	{
		for(unsigned int cnt_max_data = 0; cnt_max_data <= max_data;cnt_max_data++)
		{
			if(cnt_max_data == 0 || cnt_max_data == max_data)
			{
				intermediate_sc(8,8) = 1;
				intermediate_sc(7,0) = 1;
			}else if(cnt_max_data > 0 && cnt_max_data < max_data)
			{
				intermediate_sc(7,0) = data_in(rd);
				intermediate_sc(8,8) = 0;
			}
			data_generated_sc.push_back(intermediate_sc);
		}
		intermediate_sc(7,0) = 1;
		intermediate_sc(8,8) = 1;
		data_generated_sc[nchar(rd)] = intermediate_sc;
	}
}


void on_BtnChangeFrequencyVerilog_clicked()
{
	string aux = EntryFrequencyVerilog->get_text();

	switch(atoi(aux.c_str()))
	{
		case 2:
			frquency_nano_second = 500;
		break;
		case 10:
			frquency_nano_second = 100;
		break;
		case 20:
			frquency_nano_second = 50;
		break;
		case 50:
			frquency_nano_second = 20;
		break;
		case 100:
			frquency_nano_second = 10;
		break;
		case 150:
			frquency_nano_second = 7;
		break;
		case 200:
			frquency_nano_second = 5;
		break;
		case 201:
			frquency_nano_second = 4;
		break;
		case 250:
			frquency_nano_second = 4;
		break;
		case 280:
			frquency_nano_second = 3;
		break;
		default:
			frquency_nano_second = 500;
		break;
	}
	
}

void thread_gtkmm_run()
{
	//GRAPHICAL INTERFACE
	Main Application(true);
	builder = Gtk::Builder::create_from_file("SpaceWrireTestSuit.glade");

	builder->get_widget("SpaceWireTestStress", window);
	builder->get_widget("BtnFinsihSimulation", BtnFinsihSimulation);
	builder->get_widget("BtnLinkEnable", BtnLinkEnable);
	builder->get_widget("BtnLinkDisable", BtnLinkDisable);
	builder->get_widget("BtnAutoStart", BtnAutoStart);
	builder->get_widget("BtnReset", BtnReset);

	builder->get_widget("BtnSpaceWireVerilog", BtnSpaceWireVerilog);
	builder->get_widget("CheckbtnLinkDisable", CheckbtnLinkDisable);
	builder->get_widget("CheckbtnAutoStart", CheckbtnAutoStart);
	builder->get_widget("CheckbtnLinkEnable", CheckbtnLinkEnable);

	builder->get_widget("BtnGenerationDataVerilog", BtnGenerationDataVerilog);
	builder->get_widget("BtnSimpleTest", BtnSimpleTest);
	builder->get_widget("CheckBtnEopGenVerilog", CheckBtnEopGenVerilog);
	builder->get_widget("CheckBtnEepGenVerilog", CheckBtnEepGenVerilog);
	builder->get_widget("CheckBtnTimeCodeGenVerilog", CheckBtnTimeCodeGenVerilog);

	builder->get_widget("BtnChangeFrequencyVerilog", BtnChangeFrequencyVerilog);
	builder->get_widget("EntryFrequencyVerilog", EntryFrequencyVerilog);

	builder->get_widget("BtnTxFrequency", BtnTxFrequency);
	builder->get_widget("EntryFrequency", EntryFrequency);

	builder->get_widget("BtnSendDataScTx", BtnSendDataScTx);
	builder->get_widget("BtnTimeCodeScTx", BtnTimeCodeScTx);
	builder->get_widget("BtnGenerateDataSc", BtnGenerateDataSc);
	builder->get_widget("CheckBtnEepGenSystemC", CheckBtnEepGenSystemC);
	builder->get_widget("CheckBtnEopGenSystemC", CheckBtnEopGenSystemC);

	builder->get_widget("lblStatus",lblStatus);

	BtnFinsihSimulation->signal_clicked().connect(sigc::ptr_fun(&on_BtnFinsihSimulation_clicked));
	BtnLinkEnable->signal_clicked().connect(sigc::ptr_fun(&on_BtnLinkEnable_clicked));
	BtnLinkDisable->signal_clicked().connect(sigc::ptr_fun(&on_BtnLinkDisable_clicked));
	BtnAutoStart->signal_clicked().connect(sigc::ptr_fun(&on_BtnAutoStart_clicked));
	BtnReset->signal_clicked().connect(sigc::ptr_fun(&on_BtnReset_clicked));

	BtnSpaceWireVerilog->signal_clicked().connect(sigc::ptr_fun(&on_BtnSpaceWireVerilog_clicked));

	BtnSimpleTest->signal_clicked().connect(sigc::ptr_fun(&on_BtnSimpleTest_clicked));

	BtnChangeFrequencyVerilog->signal_clicked().connect(sigc::ptr_fun(&on_BtnChangeFrequencyVerilog_clicked));

	BtnGenerationDataVerilog->signal_clicked().connect(sigc::ptr_fun(&on_BtnGenerationDataVerilog_clicked));

	BtnTxFrequency->signal_clicked().connect(sigc::ptr_fun(&on_BtnTxFrequency_clicked));

	BtnSendDataScTx->signal_clicked().connect(sigc::ptr_fun(&on_BtnSendDataScTx_clicked));
	BtnTimeCodeScTx->signal_clicked().connect(sigc::ptr_fun(&on_BtnTimeCodeScTx_clicked));
	BtnGenerateDataSc->signal_clicked().connect(sigc::ptr_fun(&on_BtnGenerateDataSc_clicked));

	window->set_title("GLADIC SPACEWIRE TEST TOOL");

	Application.run(*window);
}

Control_SC::Control_SC()
{
	clock_systemc  = 2;
	sn_top = new sc_TOP_SPW("sc_TOP_SPW");
	boost::thread workerThreadGTKMM(thread_gtkmm_run);

	data_col_store.push_back("CONTROL TYPE");
	data_col_store.push_back("NUMBER GENERATED");
	data_col_store.push_back("NUMBER RECEIVED");
	data_col_store.push_back("COMPARE");
	data_col_store.push_back("TIME STAMP");
	REC_TX_SPW = new data_recorder("test_suit_vlog_sc.html",data_col_store,"test_suit_vlog_sc.html","TX VERILOG 2 RX SYSTEMC");
	REC_TX_SPW->initialize();
	COMPARE_SPW = new data_check();
	data_col_store.clear();

	data_col_store0.push_back("CONTROL TYPE");
	data_col_store0.push_back("NUMBER GENERATED");
	data_col_store0.push_back("NUMBER RECEIVED");
	data_col_store0.push_back("COMPARE");
	data_col_store0.push_back("TIME STAMP");
	REC_TX_SPWSC = new data_recorder("test_suit_sc_vlog.html",data_col_store0,"test_suit_sc_vlog.html","TX SYSTEMC 2 RX VERILOG");
	COMPARE_SPW_RX = new data_check();
	REC_TX_SPWSC->initialize();
	data_col_store0.clear();
}

void Control_SC::init()
{

	sn_top->RESET     = true;

	sn_top->LINK_DISABLE  = false;
	sn_top->LINK_START    = false;
	sn_top->AUTO_START = false;

	sn_top->E_SEND_DATA = false;

	sn_top->CLOCK_GEN = 1;
	frquency_nano_second = 500;
}

void autostart()
{
	if(auto_start)
	{
		sn_top->AUTO_START = true;
		//lblStatus->set_text("AUTOSTART ENABLED ON TX SYSTEMC");
	}
	else
	{
		sn_top->AUTO_START = false;
		//lblStatus->set_text("AUTOSTART DISABLED ON TX SYSTEMC");
	}
}

void linkstart()
{
	if(link_start)
	{
		sn_top->LINK_START = true;
		//lblStatus->set_text("LINKSTART ENABLED ON TX SYSTEMC");
	}
	else
	{
		sn_top->LINK_START = false;
		//lblStatus->set_text("LINKSTART DISABLED ON TX SYSTEMC");
	}
}

void linkdisable()
{
	if(link_disable)
	{
		sn_top->LINK_DISABLE = true;
		//lblStatus->set_text("LINKDISABLE ENABLED ON TX SYSTEMC");
	}
	else
	{
		sn_top->LINK_DISABLE = false;
		//lblStatus->set_text("LINKDISABLE DISABLED ON TX SYSTEMC");
	}
}

void send_data_tx_sc()
{
	if(start_send_data)
	{
		sn_top->E_SEND_DATA = true;
	}
	else
	{
		sn_top->E_SEND_DATA = false;
	}

}

void Control_SC::run_sim()
{

	autostart();
	linkstart();
	linkdisable();
	send_data_tx_sc();

	sc_start(clock_systemc,SC_NS);

}

/*	  END OF SIMULATION      */
void Control_SC::stop_sim()
{
	sc_stop();
}

/*	   RESET HIGH		*/
bool Control_SC::reset_set()
{

	if(global_reset)
	{
		sn_top->RESET = false;
	}else 
	{
		sn_top->RESET = true;
	}

	return sn_top->RESET;
}

unsigned int Control_SC::get_value_dout()
{
	return sn_top->DOUT.read();
}

unsigned int Control_SC::get_value_sout()
{
	return sn_top->SOUT.read();
}

void Control_SC::set_rx_sin(unsigned int strobe)
{
	sn_top->SIN = strobe;
}

void Control_SC::set_rx_din(unsigned int data)
{
	sn_top->DIN = data;
}

unsigned int Control_SC::get_spw_fsm()
{
	return sn_top->FSM_SPW_OUT.read();
}

unsigned int  Control_SC::finish_simulation()
{
	return finish;
}

//verilog variables
bool Control_SC::verilog_linkenable()
{
	return verilog_link_start;
}

bool Control_SC::verilog_autostart()
{
	return verilog_auto_start;
}

bool Control_SC::verilog_linkdisable()
{
	return verilog_link_disable;
}

float Control_SC::verilog_frequency()
{
	return frquency_nano_second;
}

//Test verilog
bool Control_SC::start_tx_test()
{
	return start_send_data_verilog;
}

bool Control_SC::enable_time_code_tx_test()
{
	return enable_time_code_verilog;
}

void Control_SC::end_tx_test()
{
	start_send_data_verilog = enable_time_code_verilog = false;
}

int Control_SC::size_data_test_vlog()
{
	return data_generated_verilog.size();
}

int Control_SC::size_data_test_sc()
{
	return data_generated_sc.size();
}

unsigned int Control_SC::take_data(unsigned int a)
{
	intermediate = data_generated_verilog[a];
	return intermediate(8,0);
}

void Control_SC::data_o(unsigned int data, unsigned int pos)
{
		sc_uint<9> intermediate = data;

		data_col_store0.clear();
		if(data_iteration_sc <= data_generated_sc.size()-1)
		{
			data_col_store0.push_back("DATA");

			intermediate_sc=data_generated_sc[pos];
			data_col_store0.push_back(intermediate_sc.to_string(SC_HEX));

			data_col_store0.push_back(intermediate.to_string(SC_HEX));

			data_col_store0.push_back(" ");
			COMPARE_SPW_RX->compare_test(&data_col_store0);

			data_col_store0.push_back(sc_time_stamp().to_string());
			REC_TX_SPWSC->storedata(data_col_store0);
			data_iteration_sc++;
		}else
		{
			data_iteration_sc = 0;
		}
}


void  Control_SC::data_rx_vlog_loopback_o(unsigned int data, unsigned int pos)
{

	sc_uint<9> intermediate;

	data_col_store.clear();

	data_col_store.push_back("DATA");
	intermediate = data_generated_verilog[pos];
	data_col_store.push_back(intermediate.to_string(SC_HEX));

	intermediate = data;
	data_col_store.push_back(intermediate(8,0).to_string(SC_HEX));
	data_col_store.push_back(" ");
	COMPARE_SPW->compare_test(&data_col_store);

	data_col_store.push_back(sc_time_stamp().to_string());
	REC_TX_SPW->storedata(data_col_store);
}

void data_rx_sc_o(unsigned int type_char, sc_uint<4> control, sc_uint<4> last_control_sys , sc_uint<10> data , sc_uint<10> timecode_sys)
{
	data_col_store.clear();

	switch(type_char)
	{
		case 0:
			data_col_store.push_back("NULL");
			data_col_store.push_back(" - ");
			data_col_store.push_back(last_control_sys(2,0).to_string(SC_HEX) + control(2,0).to_string());
			data_col_store.push_back(" - ");
			data_col_store.push_back(sc_time_stamp().to_string());
			REC_TX_SPW->storedata(data_col_store);	
		break;
		case 1:
			data_col_store.push_back("FCT");
			data_col_store.push_back(" - ");
			data_col_store.push_back(last_control_sys(2,0).to_string(SC_HEX) + control(2,0).to_string());
			data_col_store.push_back(" - ");
			data_col_store.push_back(sc_time_stamp().to_string());
			REC_TX_SPW->storedata(data_col_store);
		break;
		case 2:
			data_col_store.push_back("EOP");
			intermediate_data = data_generated_verilog[data_iteration];
			data_col_store.push_back(intermediate_data.to_string(SC_HEX));
			data_col_store.push_back(last_control_sys(2,0).to_string(SC_HEX) + control(2,0).to_string());
			data_col_store.push_back(" ");
			COMPARE_SPW->compare_test(&data_col_store);
			data_iteration++;
			data_col_store.push_back(sc_time_stamp().to_string());
			REC_TX_SPW->storedata(data_col_store);
		break;
		case 3:
			data_col_store.push_back("EEP");
			intermediate_data = data_generated_verilog[data_iteration];
			data_col_store.push_back(intermediate_data.to_string(SC_HEX));

			data_col_store.push_back(last_control_sys(2,0).to_string(SC_HEX) + control(2,0).to_string());
			data_col_store.push_back(" ");
			COMPARE_SPW->compare_test(&data_col_store);
			data_iteration++;

			data_col_store.push_back(sc_time_stamp().to_string());
			REC_TX_SPW->storedata(data_col_store);
		break;
		case 4:
			data_col_store.push_back("INVALID CONNECTION");
			data_col_store.push_back(" - ");
			data_col_store.push_back(last_control_sys(2,0).to_string(SC_HEX) + control(2,0).to_string());
			data_col_store.push_back(" - ");
			data_col_store.push_back(sc_time_stamp().to_string());
			REC_TX_SPW->storedata(data_col_store);
		break;
		case 5:
			data_col_store.push_back("DATA");
			intermediate_data = data_generated_verilog[data_iteration];
			data_col_store.push_back(intermediate_data.to_string(SC_HEX));

			data_col_store.push_back(data(8,0).to_string(SC_HEX));
			data_col_store.push_back(" ");
			COMPARE_SPW->compare_test(&data_col_store);

			data_col_store.push_back(sc_time_stamp().to_string());
			REC_TX_SPW->storedata(data_col_store);
			data_iteration++;
		break;
		case 6:
			data_col_store.push_back("TIMECODE");
			data_col_store.push_back(" - ");
			data_col_store.push_back(timecode_sys(7,0).to_string());
			data_col_store.push_back(" - ");
			data_col_store.push_back(sc_time_stamp().to_string());
			REC_TX_SPW->storedata(data_col_store);
		break;
	}

}

unsigned int Control_SC::clock_tx()
{
	return sn_top->DUT.CLOCK_TX_OUT.read();
}

