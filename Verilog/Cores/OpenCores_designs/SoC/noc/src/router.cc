/*
 * =====================================================================================
 *
 *       Filename:  router.cc
 *
 *    Description:  router 
 *
 *        Version:  1.0
 *        Created:  03/25/2009 12:42:15 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */
#include "router.h"

char router :: direction_decision(char dst_x, char dst_y, char router_x, char router_y)
{
	if(dst_x < router_x){			//outgoing west.
		return WEST_ADDRESS;
	}
	else if(dst_x > router_x){		//outgoing east.
		return EAST_ADDRESS;
	}
	else{
		if(dst_y > router_y){		//outgoing north.
			return SOUTH_ADDRESS;
		}
		else if(dst_y < router_y){	//outgoing sourth.
			return NORTH_ADDRESS;
		}
		else{						//outgoing core.
			return CORE_ADDRESS;
		}
	}
}

char router :: header_decoder(sc_uint<8> addr){

	HEAD_FLIT *head_flit;
	sc_uint<6>	dst_x, dst_y, router_x, router_y;
	sc_uint<16> temp;
	sc_uint<2>	ch_temp = 0;
	unsigned short temp_s;

	temp = rbuffer[addr].range(15,0);
	temp_s = temp;
	head_flit = (HEAD_FLIT *)&temp_s;

	if(head_flit->type == _HEAD_FLIT){
		//Header flit.
		dst_x = head_flit->dst_addr % x_num;
		dst_y = head_flit->dst_addr / y_num;
		router_x = router_id % x_num;
		router_y = router_id / y_num;
		port[addr].outport = direction_decision(dst_x, dst_y, router_x, router_y);
#ifdef ROUTER_DEC_DEBUG
		cout << "Head flit" << endl;
		cout << "packet dst_y: " << dst_y << ", dst_x: " << dst_x << endl;
		cout << "router x: " << router_x << ", y: " << router_y << endl;

		switch(port[addr].outport){
			case WEST_ADDRESS : cout << "WEST" << endl;
								break;
			case EAST_ADDRESS : cout << "EAST" << endl;
								break;
			case SOUTH_ADDRESS : cout << "SOUTH" << endl;
								 break;
			case NORTH_ADDRESS : cout << "NORTH" << endl;
								 break;
			case CORE_ADDRESS : cout << "CORE" << endl;
								break;
		}
#endif

		for(int i = 0; i < 3; i++){		
			if(!(tbuffer_state & (1 << (port[addr].outport + i)))){
				port[addr].out_ch = i;
				port[addr].set = 1;
				tbuffer_state |= (1 << (port[addr].outport + i));

				if(head_flit->conn_type == EIs){
					return EIs;
				}
				else if(head_flit->conn_type == OIs){
					return OIs;
				}					
			}
		}
	}
	return FAIL;
}

#ifdef ROUTER_DEBUG
void router :: transfer_data(sc_out<bool> *data_out, sc_out<sc_uint<2> > *router_to_fifo_sel, 
							 sc_out<bool> *write_n, sc_in<sc_uint<3> > *full, sc_uint<8> address,
							 char *debug_string, unsigned char debug_en)
#else

void router :: transfer_data(sc_out<bool> *data_out, sc_out<sc_uint<2> > *router_to_fifo_sel, 
							 sc_out<bool> *write_n, sc_in<sc_uint<3> > *full, sc_uint<8> address)
#endif
{
	sc_uint<FIFO_DEEP>      tr_fc;          //fifo deep counter.
	sc_uint<FIFO_DEEP>      buff;
	sc_uint<FIFO_DEEP>      f_ct[3];
	sc_uint<3>              channel = 0;
	sc_uint<3>              sel = 0;
	bool                    stop_flag = 0;
	bool                    temp = 0;
	bool                    ready = 0;

	while(true){
		if(!reset_n.read()){
			stop_flag = 0;
			f_ct[0] = f_ct[1] = f_ct[2] = 0;
		}
		else{
			if(clk.read()){
				write_n->write(true);
				if(((full->read()&0x01) != 0x01) && ((tbuffer[address+0] & WEN) == WEN)){
					sel = 1;
					channel = 0;
					stop_flag = 0;
					f_ct[channel]++;
				}
				else if(((full->read()&0x02) != 0x02)&&((tbuffer[address+1] & WEN) == WEN)){
					sel = 2;
					channel = 1;
					stop_flag = 0;
					f_ct[channel]++;
				}
				else if(((full->read()&0x04) != 0x04)&&((tbuffer[address+2] & WEN) == WEN)){
					sel = 3;
					channel = 2;
					stop_flag = 0;
					f_ct[channel]++;
				}
				else{
					sel = 0x00;
					stop_flag = 1;
				}
				router_to_fifo_sel->write(sel);
				ready = 1;
			}
			else if((ready == 1) && (stop_flag == 0)){
				if(((f_ct[channel] - 1) < FIFO_DEEP)){
					buff = tbuffer[address+channel].range(15,0);
					temp =(bool)((buff >> (f_ct[channel] - 1)) & 0x0001);
					data_out->write(temp);
					write_n->write(false);
					ready = 0;
					EI_POWER;
				}
				if((f_ct[channel]) >= (FIFO_DEEP)){
					f_ct[channel] = 0;
					tbuffer[address+channel] &= ~WEN;
					tbuffer[address+channel] = 0;
					if(tbuffer[address+channel].range(15,14) & _TAIL_FLIT){
#ifdef ROUTER_DEBUG
						cout << "Tail flit" << endl;
#endif
						port[address+channel].set = 0;
						port[address+channel].inport = 0;
						port[address+channel].outport = 0;
						port[address+channel].in_ch = 0;
						port[address+channel].out_ch = 0;
						tbuffer_state &= ~(1 << address + channel);
					}
					EI_POWER;
#ifdef ROUTER_DEBUG
	//			cout << "Router [" << router_id << "] " << debug_string << " output channel: " << channel << endl;
#endif
				}
			}
		}
		wait();
	}
}
#ifdef ROUTER_DEBUG
void router :: receive_data(sc_in<bool> *data_in, sc_out<sc_uint<2> > *fifo_to_router_sel,
							sc_out<bool> *read_n, sc_in<sc_uint<3> > *empty, sc_uint<8> address,
							char *debug_string, unsigned char debug_en)
#else
void router :: receive_data(sc_in<bool> *data_in, sc_out<sc_uint<2> > *fifo_to_router_sel,
							sc_out<bool> *read_n, sc_in<sc_uint<3> > *empty, sc_uint<8> address)
#endif
{
	sc_uint<FIFO_DEEP>  rec_buff = 0;
	sc_uint<FIFO_DEEP>	rec_fc = 0;         //fifo deep counter.
	sc_uint<FIFO_DEEP>  f_ct[3];         //fifo deep counter.
	sc_uint<2>			sel = 0;
	sc_uint<2>			channel = 0;
	bool temp = 0;
	bool ready = 0;

	f_ct[0] = f_ct[1] = f_ct[2] = 0;
	rbuffer[0] = rbuffer[1] = rbuffer[2] = 0;

	read_n->write(true);

	while(true){
		wait();
		if(!reset_n.read())
		{
			rbuffer[0] = rbuffer[1] = rbuffer[2] = 0;
			f_ct[0] = f_ct[1] = f_ct[2] = 0;
			read_n->write(true);
		}
		else{
			if(clk.read()){
				read_n->write(true);
				if(((empty->read()&0x01) != 0x01) && (rbuffer[address+0]&REN) != REN){
					channel = 0;
					sel = 1;
					f_ct[channel]++;
					ready = 1;
				}
				else if(((empty->read()&0x02) != 0x02) && ((rbuffer[address+1]&REN) != REN)){
					channel = 1;
					sel = 2;
					f_ct[channel]++;
					ready = 1;
				}
				else if(((empty->read()&0x04) != 0x04) && ((rbuffer[address+2]&REN) != REN)){
					channel = 2;
					sel = 3;
					f_ct[channel]++;
					ready = 1;
				}
				else{
					ready = 0;
					sel = 0;
				}
				fifo_to_router_sel->write(sel);
			}
			else if(ready == 1){ 
				if((f_ct[channel]) < FIFO_DEEP+1){
					read_n->write(false);
					wait(2,SC_NS);
					temp = data_in->read();
					rbuffer[address+channel] |= (temp << (f_ct[channel]-1));
					ready = 0;
					EI_POWER;
				}
				if((f_ct[channel]) == (FIFO_DEEP)){
					f_ct[channel] = 0;
					rbuffer[address+channel] |= REN;
					EI_POWER;
					EI_DELAY;
#ifdef ROUTER_DEBUG
					if(debug_en == 1){
						unsigned short debug_temp = 0;
						for(int dc = 0; dc <= FIFO_DEEP; dc++){
							debug_temp = rbuffer[address+channel];
							debug_temp = debug_temp >> dc;
							debug_temp &= 0x0001;
							if(dc  == 0){
								cout << "router [" << router_id << "] channel[" 
									<< channel << "] " << debug_string << " receive data: \t";
								cout << debug_temp;
							}
							else if(dc < FIFO_DEEP){
								cout << debug_temp;
							}
						}
						cout << endl;
					}
#endif
				}
			}
		}
	}
}

//CORE
void router :: core_receive_data(){
#ifdef ROUTER_DEBUG
	receive_data(&c_data_in, &c_fifo_to_router_sel, &c_read_n, &c_empty, CORE_ADDRESS,
				 "core",1);
#else
	receive_data(&c_data_in, &c_fifo_to_router_sel, &c_read_n, &c_empty, CORE_ADDRESS);
#endif
}
void router :: core_transfer_data(){
#ifdef ROUTER_DEBUG
	transfer_data(&c_data_out, &c_router_to_fifo_sel, &c_write_n, &c_full, CORE_ADDRESS,
				 "core" , 1);
#else
	transfer_data(&c_data_out, &c_router_to_fifo_sel, &c_write_n, &c_full, CORE_ADDRESS);
#endif
}

//WEST
void router :: west_receive_data(){
#ifdef ROUTER_DEBUG
	receive_data(&w_data_in, &w_fifo_to_router_sel, &w_read_n, &w_empty, WEST_ADDRESS, 
				 "west", 0);
#else
	receive_data(&w_data_in, &w_fifo_to_router_sel, &w_read_n, &w_empty, WEST_ADDRESS);
#endif

}
void router :: west_transfer_data(){
#ifdef ROUTER_DEBUG
	transfer_data(&w_data_out, &w_router_to_fifo_sel, &w_write_n, &w_full, WEST_ADDRESS,
				  "west" , 0);
#else
	transfer_data(&w_data_out, &w_router_to_fifo_sel, &w_write_n, &w_full, WEST_ADDRESS);
#endif
}

//EAST
void router :: east_receive_data(){
#ifdef ROUTER_DEBUG
	receive_data(&e_data_in, &e_fifo_to_router_sel, &e_read_n, &e_empty, EAST_ADDRESS, 
				 "east", 0);
#else
	receive_data(&e_data_in, &e_fifo_to_router_sel, &e_read_n, &e_empty, EAST_ADDRESS);
#endif
}

void router :: east_transfer_data(){
#ifdef ROUTER_DEBUG
	transfer_data(&e_data_out, &e_router_to_fifo_sel, &e_write_n, &e_full, EAST_ADDRESS,
				  "east", 0);
#else
	transfer_data(&e_data_out, &e_router_to_fifo_sel, &e_write_n, &e_full, EAST_ADDRESS);
#endif
}

//NORTH
void router :: north_receive_data(){
#ifdef ROUTER_DEBUG
	receive_data(&n_data_in, &n_fifo_to_router_sel, &n_read_n, &n_empty, NORTH_ADDRESS, 
				 "north", 0);
#else
	receive_data(&n_data_in, &n_fifo_to_router_sel, &n_read_n, &n_empty, NORTH_ADDRESS);
#endif
}

void router :: north_transfer_data(){
#ifdef ROUTER_DEBUG
	transfer_data(&n_data_out, &n_router_to_fifo_sel, &n_write_n, &n_full, NORTH_ADDRESS,
				  "north", 0);
#else
	transfer_data(&n_data_out, &n_router_to_fifo_sel, &n_write_n, &n_full, NORTH_ADDRESS);
#endif
}

//SOUTH
void router :: south_receive_data(){
#ifdef ROUTER_DEBUG
	receive_data(&s_data_in, &s_fifo_to_router_sel, &s_read_n, &s_empty, SOUTH_ADDRESS, 
				 "south", 0);
#else
	receive_data(&s_data_in, &s_fifo_to_router_sel, &s_read_n, &s_empty, SOUTH_ADDRESS);
#endif
}

void router :: south_transfer_data(){
#ifdef ROUTER_DEBUG
	transfer_data(&s_data_out, &s_router_to_fifo_sel, &s_write_n, &s_full, SOUTH_ADDRESS,
				  "south", 0);
#else
	transfer_data(&s_data_out, &s_router_to_fifo_sel, &s_write_n, &s_full, SOUTH_ADDRESS);
#endif
}

void router :: oi_transfer_data()
{
	sc_uint<OI_FLIT_SIZE> temp = 0;
	sc_uint<OI_FLIT_SIZE> tc_count = 0;
	bool tr_bit_temp;
	sc_logic rc_temp = SC_LOGIC_Z;

	while(true){
		if(!reset_n.read()){
			c_oi_out.write(SC_LOGIC_Z);
			tc_count = 0;
		}
		else{
			if((tbuffer[OI_ADDRESS] & WEN) == WEN){
				temp = tbuffer[OI_ADDRESS].range(15,0);
				tr_bit_temp = ((temp >> tc_count) & 0x0001);
				if(tr_bit_temp == 1){
					c_oi_out.write(SC_LOGIC_1);
					tc_count++;
					TRANSMITTER_OI_POWER;
				}
				else if(tr_bit_temp == 0){
					c_oi_out.write(SC_LOGIC_0);
					tc_count++;
					TRANSMITTER_OI_POWER;
				}
				else{
					c_oi_out.write(SC_LOGIC_Z);
				}
				if(tc_count == OI_FLIT_SIZE + 1){
					c_oi_out.write(SC_LOGIC_Z);
#ifdef ROUTER_DEBUG
					short debug_temp = 0;
					for(int dc = 0; dc <= FIFO_DEEP; dc++){
						debug_temp = tbuffer[OI_ADDRESS].range(15,0);
						debug_temp = debug_temp >> dc;
						debug_temp &= 0x0001;
						if(dc  == 0){
							cout << "router [" << router_id << "] OI transfer data: \t";
							cout << debug_temp;
						}
						else if(dc < FIFO_DEEP){
							cout << debug_temp;
						}
					}
					cout << endl;
#endif
					if(tbuffer[OI_ADDRESS].range(15,14) & _TAIL_FLIT){
#ifdef ROUTER_DEBUG
						cout << "OI TR : Tail flit" << endl;
#endif
						port[OI_ADDRESS].set = 0;
						port[OI_ADDRESS].inport = 0;
						port[OI_ADDRESS].outport = 0;
						port[OI_ADDRESS].in_ch = 0;
						port[OI_ADDRESS].out_ch = 0;
						tbuffer_state &= ~(1 << OI_ADDRESS);
					}
					TRANSMITTER_OI_DELAY;
					tc_count = 0;
					tbuffer[OI_ADDRESS] = 0;
				}
			}
		}
		wait();
	}
}

void router :: oi_receive_data()
{
	sc_uint<OI_FLIT_SIZE> temp = 0;
	sc_uint<OI_FLIT_SIZE> oi_count = 0;
	sc_logic rc_temp = SC_LOGIC_Z;

	while(true){
		if(!reset_n.read()){
			oi_count = 0;
			rc_temp = SC_LOGIC_Z;
			temp = 0;
		}
		else{
			if((rbuffer[OI_ADDRESS] & REN) != REN){
				rc_temp = c_oi_in.read();
				if((rc_temp != SC_LOGIC_Z) && (rc_temp != SC_LOGIC_X)){
					if(rc_temp == SC_LOGIC_0){
						oi_count++;
						RECEIVER_OI_ENERGY;
					}
					else if(rc_temp == SC_LOGIC_1){
						temp |= (1 << oi_count);
						oi_count++;
						RECEIVER_OI_ENERGY;
					}
					if(oi_count == OI_FLIT_SIZE){
						rbuffer[OI_ADDRESS] = temp;
						rbuffer[OI_ADDRESS] |= REN;
						RECEIVER_OI_DELAY;
						oi_count = 0;
						temp = 0;
#ifdef ROUTER_DEBUG
						short debug_temp = 0;
						for(int dc = 0; dc <= FIFO_DEEP; dc++){
							debug_temp = rbuffer[OI_ADDRESS];
							debug_temp = debug_temp >> dc;
							debug_temp &= 0x0001;
							if(dc  == 0){
								cout << "router [" << router_id << "] OI receive data: \t";
								cout << debug_temp;
							}
							else if(dc < FIFO_DEEP){
								cout << debug_temp;
							}
						}
						cout << endl;
#endif
					}
				}
			}
		}
		wait();
	}
}

void router :: direction_handle(){
	sc_uint<8> ch = 0;
	char state = 0;

	ch = CORE_ADDRESS;

	while(true){
		if(!reset_n.read()){
			control_state = 0;
		}
		else{
			for(ch = 0; ch < 16; ch++){
				if(rbuffer[ch] & REN){
					if(port[ch].set == 1){
						if(!(tbuffer[port[ch].outport + port[ch].out_ch] & WEN)){
							tbuffer[port[ch].outport + port[ch].out_ch] = rbuffer[ch].range(15,0);
							tbuffer[port[ch].outport + port[ch].out_ch] |= WEN;
							rbuffer[ch] = 0;
							rbuffer[ch] &= ~REN;
						}
					}
					else if(port[ch].set == 0){
						state = header_decoder(ch);
						if(state != FAIL){
							if(!(tbuffer[port[ch].outport + port[ch].out_ch] & WEN)){
								tbuffer[port[ch].outport + port[ch].out_ch] = rbuffer[ch].range(15,0);
								tbuffer[port[ch].outport + port[ch].out_ch] |= WEN;
								rbuffer[ch] &= ~REN;
								if(state == OIs){
									if(ch < 3){
										port[ch].outport = OI_ADDRESS;
										port[ch].out_ch = 0;
										port[ch].set = 1;
									}

									if(port[ch].outport == 0){
										port[15].outport = 0;
										port[15].out_ch = port[ch].out_ch;
										port[ch].set = 0;
										port[15].set = 1;
									}
									optical_sw(ch);
								}
								rbuffer[ch] = 0;
							}
						}
					}
				}
			}
		}
		wait();
	}
}

sc_uint<16> router :: out_direction(sc_uint<8> out_going, sc_uint<16> go_a, sc_uint<16> go_b, 
									sc_uint<16> go_c, sc_uint<16> go_d, sc_uint<16> go_e)
{
	sc_uint<16> out_temp = 0;

	if(out_going == EAST_ADDRESS){
		out_temp = go_a;
	}
	else if(out_going == WEST_ADDRESS){
		out_temp = go_b;
	}
	else if(out_going == NORTH_ADDRESS){
		out_temp = go_c;
	}
	else if(out_going == SOUTH_ADDRESS){
		out_temp = go_d;
	}
	else if(out_going == CORE_ADDRESS){
		out_temp = go_e;
	}
	
	return out_temp;
}

void router :: optical_sw(sc_uint<8> ch)
{
	sc_uint<16> out_temp = 0;
	HEAD_FLIT *head_flit;
	sc_uint<6>	dst_x, dst_y, router_x, router_y;
	sc_uint<16> temp;
	sc_uint<2>	ch_temp = 0;
	unsigned short temp_s;
	sc_uint<8> outgoing = 0;

	temp = rbuffer[ch].range(15,0);
	temp_s = temp;
	head_flit = (HEAD_FLIT *)&temp_s;

	//Header flit.
	dst_x = head_flit->dst_addr % x_num;
	dst_y = head_flit->dst_addr / y_num;
	router_x = router_id % x_num;
	router_y = router_id / y_num;

	outgoing = direction_decision(dst_x, dst_y, router_x, router_y);

	//input buffer number.
	if(ch  < 3){			//in core.
		out_temp = out_direction(outgoing, CORE_TO_EAST, CORE_TO_WEST, CORE_TO_NORTH, CORE_TO_SOUTH, 0);
	}
	else if(ch < 6){		//in west
		out_temp = out_direction(outgoing, 0, 0, WEST_TO_NORTH, WEST_TO_SOUTH, WEST_TO_CORE);
	}
	else if(ch < 9){		//in east
		out_temp = out_direction(outgoing, 0, 0, EAST_TO_NORTH, EAST_TO_SOUTH, EAST_TO_CORE);
	}
	else if(ch < 12){		//in north
		out_temp = out_direction(outgoing, NORTH_TO_EAST, NORTH_TO_WEST, 0, 0, NORTH_TO_CORE);
	}
	else if(ch < 15){		//in south
		out_temp = out_direction(outgoing, SOUTH_TO_EAST, SOUTH_TO_WEST, 0, 0, NORTH_TO_CORE);
	}
	//cout << "sel " << hex << out_temp << endl;
	control_state |= out_temp;
	oi_control.write(control_state);
	//cout << "control signal: " << hex << state_temp << endl;
}
