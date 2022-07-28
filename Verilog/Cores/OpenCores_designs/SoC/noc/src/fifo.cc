#include <systemc>
#include <iostream>
#include "fifo.h"
using namespace sc_core;
using namespace std;

void virtual_fifo::receive_fifo(){

	while(true){
		if(x_to_fifo_sel.read() == 1){			//select fifo.
			if(fifo.num_free() > 0){
				fifo.write(data_in.read());
			}
		}
		else if(x_to_fifo_sel.read() == 2){		//select fifo1.
			if(fifo1.num_free() > 0){
				fifo1.write(data_in.read());
			}	
		}
		else if(x_to_fifo_sel.read() == 3){		//select fifo2.
			if(fifo2.num_free() > 0){
				fifo2.write(data_in.read());
			}	
		}
#ifdef FIFO_DEBUG
		if(fifo.num_free() == 0){
			fifo.print(cout);
			cout << endl;
		}
#endif
		wait();
	}
}

void virtual_fifo::transfer_fifo(){
	bool temp;

	while(true){
		if(fifo_to_x_sel.read() == 1){			//select fifo.
			if(fifo.num_free() < FIFO_DEEP){
				temp = fifo.read();
				data_out.write(temp);
			}
		}
		else if(fifo_to_x_sel.read() == 2){		//select fifo1.
			if(fifo1.num_free() < FIFO_DEEP){
				temp = fifo1.read();
				data_out.write(temp);
			}	
		}
		else if(fifo_to_x_sel.read() == 3){		//select fifo1.
			if(fifo2.num_free() < FIFO_DEEP){
				temp = fifo2.read();
				data_out.write(temp);
			}	
		}	
		wait();
	}
}

void virtual_fifo :: full_signal(){
	sc_uint<3>	full_state = 0;
	
	full.write(0x00);

	while(true){
		//full signal.
		if(fifo.num_free() == 0){
			full_state |= 0x01;
			full.write(full_state);
		}
		else if(fifo.num_free() > 0){
			full_state &= ~0x01;
			full.write(full_state);
		}
		if(fifo1.num_free() == 0){
			full_state |= 0x02;
			full.write(full_state);
		}
		else if(fifo1.num_free() > 0){
			full_state &= ~0x02;
			full.write(full_state);
		}
		if(fifo2.num_free() == 0){
			full_state |= 0x04;
			full.write(full_state);
		}
		else if(fifo2.num_free() > 0){
			full_state &= ~0x04;
			full.write(full_state);
		}
#ifdef FIFO_DEBUG
//		cout << "full signal: " << full_state << endl;
#endif
		wait(1,SC_NS);
	}
}

void virtual_fifo :: empty_signal(){
	sc_uint<3> empty_state = 7;
	
	empty.write(0x07);
	
	while(true){
		//empty signal.
		if(fifo.num_free() == FIFO_DEEP){
			empty_state |= 0x01;
			empty.write(empty_state);
		}
		else if(fifo.num_free() < FIFO_DEEP){
			empty_state &= ~0x01;
			empty.write(empty_state);
		}
		if(fifo1.num_free() == FIFO_DEEP){
			empty_state |= 0x02;
			empty.write(empty_state);
		}
		else if(fifo1.num_free() < FIFO_DEEP){
			empty_state &= ~0x02;
			empty.write(empty_state);
		}
		if(fifo2.num_free() == FIFO_DEEP){
			empty_state |= 0x04;
			empty.write(empty_state);
		}
		else if(fifo2.num_free() < FIFO_DEEP){
			empty_state &= ~0x04;
			empty.write(empty_state);
		}
#ifdef FIFO_DEBUG
//		cout << "empty signal: " << empty_state << endl;
#endif
		wait(1,SC_NS);
	}
}
