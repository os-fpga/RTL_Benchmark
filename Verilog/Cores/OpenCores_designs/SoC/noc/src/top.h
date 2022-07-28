/*
 * =====================================================================================
 *
 *       Filename:  fifo_tb.h
 *
 *    Description:  fifo test bench header file
 *
 *        Version:  1.0
 *        Created:  03/25/2009 11:26:55 AM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */
#ifndef TOP_H
#define TOP_H

#include <systemc>
#include "define.h"
#include "tile.h"
#include "reset_cont.h"

using namespace sc_core;
using namespace sc_dt;
using namespace std;

#define ENABLE		24
#define DISABLE		16
#define ROW			4
#define COLUMN		4

class top: public sc_module{
public:
	sc_in<bool>					clk;

	sc_signal<bool>				reset_n;
	
	sc_signal<bool>				data_in[ENABLE]; 
	sc_signal<bool>				data_out[ENABLE]; 
	sc_signal<sc_logic>			oi_in[ENABLE];
	sc_signal<sc_logic>			oi_out[ENABLE];
	sc_signal<sc_uint<3> >		in_full[ENABLE];
	sc_signal<sc_uint<3> >		out_full[ENABLE];
	sc_signal<sc_uint<2> >		in_sel[ENABLE];
	sc_signal<sc_uint<2> >		out_sel[ENABLE];
	sc_signal<bool>				in_write_n[ENABLE];
	sc_signal<bool>				out_write_n[ENABLE];

	sc_signal<bool>				t_data_in[DISABLE]; 
	sc_signal<bool>				t_data_out[DISABLE]; 
	sc_signal<sc_logic>			t_oi_in[DISABLE];
	sc_signal<sc_logic>			t_oi_out[DISABLE];
	sc_signal<sc_uint<3> >		t_in_full[DISABLE];
	sc_signal<sc_uint<3> >		t_out_full[DISABLE];
	sc_signal<sc_uint<2> >		t_in_sel[DISABLE];
	sc_signal<sc_uint<2> >		t_out_sel[DISABLE];
	sc_signal<bool>				t_in_write_n[DISABLE];
	sc_signal<bool>				t_out_write_n[DISABLE];

	tile *tile0;
	tile *tile1;
	tile *tile2;
	tile *tile3;
	tile *tile4;
	tile *tile5;
	tile *tile6;
	tile *tile7;
	tile *tile8;
	tile *tile9;
	tile *tile10;
	tile *tile11;
	tile *tile12;
	tile *tile13;
	tile *tile14;
	tile *tile15;

	reset *reset_sig;

	top(sc_module_name nm):sc_module(nm){
		reset_sig = new reset("reset_sig");
		reset_sig->clk(clk);
		reset_sig->reset_n(reset_n);
	
		tile0 = new tile("tile0",  0, COLUMN, ROW);
		tile1 = new tile("tile1",  1, COLUMN, ROW);
		tile2 = new tile("tile2",  2, COLUMN, ROW);
		tile3 = new tile("tile3",  3, COLUMN, ROW);
		tile4 = new tile("tile4",  4, COLUMN, ROW);
		tile5 = new tile("tile5",  5, COLUMN, ROW);
		tile6 = new tile("tile6",  6, COLUMN, ROW);
		tile7 = new tile("tile7",  7, COLUMN, ROW);
		tile8 = new tile("tile8",  8, COLUMN, ROW); 
		tile9 = new tile("tile9",  9, COLUMN, ROW); 
		tile10 = new tile("tile10",10, COLUMN, ROW); 
		tile11 = new tile("tile11",11, COLUMN, ROW); 
		tile12 = new tile("tile12",12, COLUMN, ROW); 
		tile13 = new tile("tile13",13, COLUMN, ROW); 
		tile14 = new tile("tile14",14, COLUMN, ROW); 
		tile15 = new tile("tile15",15, COLUMN, ROW); 

		tile0->clk(clk);
		tile1->clk(clk);
		tile2->clk(clk);
		tile3->clk(clk);
		tile4->clk(clk);
		tile5->clk(clk);
		tile6->clk(clk);
		tile7->clk(clk);
		tile8->clk(clk);
		tile9->clk(clk);
		tile10->clk(clk);
		tile11->clk(clk);
		tile12->clk(clk);
		tile13->clk(clk);
		tile14->clk(clk);
		tile15->clk(clk);

 		tile0->reset_n(reset_n);
		tile1->reset_n(reset_n);
		tile2->reset_n(reset_n);
		tile3->reset_n(reset_n);
		tile4->reset_n(reset_n);
		tile5->reset_n(reset_n);
		tile6->reset_n(reset_n);
		tile7->reset_n(reset_n);
		tile8->reset_n(reset_n);
		tile9->reset_n(reset_n);
		tile10->reset_n(reset_n);
		tile11->reset_n(reset_n);
		tile12->reset_n(reset_n);
		tile13->reset_n(reset_n);
		tile14->reset_n(reset_n);
		tile15->reset_n(reset_n);
		
		rl_conn(tile0, tile1, &data_out[0], &data_in[0], &oi_in[0], &oi_out[0], &in_write_n[0], 
				&out_write_n[0], &out_full[0], &in_full[0], &out_sel[0], &in_sel[0]);
		rl_conn(tile1, tile2, &data_out[1], &data_in[1], &oi_in[1], &oi_out[1], &in_write_n[1], 
				&out_write_n[1], &out_full[1], &in_full[1], &out_sel[1], &in_sel[1]);
		rl_conn(tile2, tile3, &data_out[2], &data_in[2], &oi_in[2], &oi_out[2], &in_write_n[2], 
				&out_write_n[2], &out_full[2], &in_full[2], &out_sel[2], &in_sel[2]);
		rl_conn(tile4, tile5, &data_out[3], &data_in[3], &oi_in[3], &oi_out[3], &in_write_n[3], 
				&out_write_n[3], &out_full[3], &in_full[3], &out_sel[3], &in_sel[3]);
		rl_conn(tile5, tile6, &data_out[4], &data_in[4], &oi_in[4], &oi_out[4], &in_write_n[4], 
				&out_write_n[4], &out_full[4], &in_full[4], &out_sel[4], &in_sel[4]);
		rl_conn(tile6, tile7, &data_out[5], &data_in[5], &oi_in[5], &oi_out[5], &in_write_n[5], 
				&out_write_n[5], &out_full[5], &in_full[5], &out_sel[5], &in_sel[5]);
		rl_conn(tile8, tile9, &data_out[6], &data_in[6], &oi_in[6], &oi_out[6], &in_write_n[6], 
				&out_write_n[6], &out_full[6], &in_full[6], &out_sel[6], &in_sel[6]);
		rl_conn(tile9, tile10, &data_out[7], &data_in[7], &oi_in[7], &oi_out[7], &in_write_n[7], 
				&out_write_n[7], &out_full[7], &in_full[7], &out_sel[7], &in_sel[7]);
		rl_conn(tile10, tile11, &data_out[8], &data_in[8], &oi_in[8], &oi_out[8], &in_write_n[8], 
				&out_write_n[8], &out_full[8], &in_full[8], &out_sel[8], &in_sel[8]);
		rl_conn(tile12, tile13, &data_out[9], &data_in[9], &oi_in[9], &oi_out[9], &in_write_n[9], 
				&out_write_n[9], &out_full[9], &in_full[9], &out_sel[9], &in_sel[9]);
		rl_conn(tile13,tile14,&data_out[10],&data_in[10],&oi_in[10],&oi_out[10],&in_write_n[10], 
				&out_write_n[10], &out_full[10], &in_full[10], &out_sel[10], &in_sel[10]);
		rl_conn(tile14,tile15,&data_out[11],&data_in[11],&oi_in[11],&oi_out[11],&in_write_n[11], 
				&out_write_n[11], &out_full[11], &in_full[11], &out_sel[11], &in_sel[11]);

		ud_conn(tile0,tile4,&data_out[12],&data_in[12],&oi_in[12],&oi_out[12],&in_write_n[12], 
				&out_write_n[12],&out_full[12],&in_full[12],&out_sel[12],&in_sel[12]);
		ud_conn(tile4,tile8,&data_out[13],&data_in[13],&oi_in[13],&oi_out[13],&in_write_n[13], 
				&out_write_n[13],&out_full[13],&in_full[13],&out_sel[13],&in_sel[13]);
		ud_conn(tile8,tile12,&data_out[14],&data_in[14],&oi_in[14],&oi_out[14],&in_write_n[14], 
				&out_write_n[14],&out_full[14],&in_full[14],&out_sel[14],&in_sel[14]);
		ud_conn(tile1,tile5,&data_out[15],&data_in[15],&oi_in[15],&oi_out[15],&in_write_n[15], 
				&out_write_n[15],&out_full[15],&in_full[15],&out_sel[15],&in_sel[15]);
		ud_conn(tile5,tile9,&data_out[16],&data_in[16],&oi_in[16],&oi_out[16],&in_write_n[16], 
				&out_write_n[16],&out_full[16],&in_full[16],&out_sel[16],&in_sel[16]);
		ud_conn(tile9,tile13,&data_out[17],&data_in[17],&oi_in[17],&oi_out[17],&in_write_n[17], 
				&out_write_n[17],&out_full[17],&in_full[17],&out_sel[17],&in_sel[17]);
		ud_conn(tile2,tile6,&data_out[18],&data_in[18],&oi_in[18],&oi_out[18],&in_write_n[18], 
				&out_write_n[18],&out_full[18],&in_full[18],&out_sel[18],&in_sel[18]);
		ud_conn(tile6,tile10,&data_out[19],&data_in[19],&oi_in[19],&oi_out[19],&in_write_n[19], 
				&out_write_n[19],&out_full[19],&in_full[19],&out_sel[19],&in_sel[19]);
		ud_conn(tile10,tile14,&data_out[20],&data_in[20],&oi_in[20],&oi_out[20],&in_write_n[20], 
				&out_write_n[20],&out_full[20],&in_full[20],&out_sel[20],&in_sel[20]);
		ud_conn(tile3,tile7,&data_out[21],&data_in[21],&oi_in[21],&oi_out[21],&in_write_n[21], 
				&out_write_n[21],&out_full[21],&in_full[21],&out_sel[21],&in_sel[21]);
		ud_conn(tile7,tile11,&data_out[22],&data_in[22],&oi_in[22],&oi_out[22],&in_write_n[22], 
				&out_write_n[22],&out_full[22],&in_full[22],&out_sel[22],&in_sel[22]);
		ud_conn(tile11,tile15,&data_out[23],&data_in[23],&oi_in[23],&oi_out[23],&in_write_n[23], 
				&out_write_n[23],&out_full[23],&in_full[23],&out_sel[23],&in_sel[23]);

		//Disable ports.
		north_disable(tile0, &t_data_out[0], &t_data_in[0], &t_oi_in[0], &t_oi_out[0], 
					  &t_in_write_n[0], &t_out_write_n[0], &t_out_full[0], &t_in_full[0], 
					  &t_out_sel[0], &t_in_sel[0]);
		north_disable(tile1, &t_data_out[1], &t_data_in[1], &t_oi_in[1], &t_oi_out[1],
					  &t_in_write_n[1], &t_out_write_n[1], &t_out_full[1], &t_in_full[1], 
					  &t_out_sel[1], &t_in_sel[1]);
		north_disable(tile2, &t_data_out[2], &t_data_in[2], &t_oi_in[2], &t_oi_out[2],
					  &t_in_write_n[2], &t_out_write_n[2], &t_out_full[2], &t_in_full[2], 
					  &t_out_sel[2], &t_in_sel[2]);
		north_disable(tile3, &t_data_out[12], &t_data_in[12], &t_oi_in[12], &t_oi_out[12],
					  &t_in_write_n[12], &t_out_write_n[12], &t_out_full[12], &t_in_full[12], 
					  &t_out_sel[12], &t_in_sel[12]);

		east_disable(tile3, &t_data_out[3], &t_data_in[3], &t_oi_in[3], &t_oi_out[3],
					 &t_in_write_n[3], &t_out_write_n[3], &t_out_full[3], &t_in_full[3], 
					 &t_out_sel[3], &t_in_sel[3]);
		east_disable(tile7, &t_data_out[4], &t_data_in[4], &t_oi_in[4], &t_oi_out[4], 
					 &t_in_write_n[4], &t_out_write_n[4], &t_out_full[4], &t_in_full[4], 
					 &t_out_sel[4], &t_in_sel[4]);
		east_disable(tile11, &t_data_out[5], &t_data_in[5], &t_oi_in[5], &t_oi_out[5],
					 &t_in_write_n[5], &t_out_write_n[5], &t_out_full[5], &t_in_full[5], 
					 &t_out_sel[5], &t_in_sel[5]);
		east_disable(tile15, &t_data_out[13], &t_data_in[13], &t_oi_in[13], &t_oi_out[13],
					 &t_in_write_n[13], &t_out_write_n[13], &t_out_full[13], &t_in_full[13], 
					 &t_out_sel[13], &t_in_sel[13]);

		south_disable(tile12, &t_data_out[6], &t_data_in[6], &t_oi_in[6], &t_oi_out[6], 
					  &t_in_write_n[6], &t_out_write_n[6], &t_out_full[6], &t_in_full[6], 
					  &t_out_sel[6], &t_in_sel[6]);
		south_disable(tile13, &t_data_out[7], &t_data_in[7], &t_oi_in[7], &t_oi_out[7],
					  &t_in_write_n[7], &t_out_write_n[7], &t_out_full[7], &t_in_full[7], 
					  &t_out_sel[7], &t_in_sel[7]);
		south_disable(tile14, &t_data_out[8], &t_data_in[8], &t_oi_in[8], &t_oi_out[8],
					  &t_in_write_n[8], &t_out_write_n[8], &t_out_full[8], &t_in_full[8], 
					  &t_out_sel[8], &t_in_sel[8]);
		south_disable(tile15, &t_data_out[14], &t_data_in[14], &t_oi_in[14], &t_oi_out[14],
					  &t_in_write_n[14], &t_out_write_n[14], &t_out_full[14], &t_in_full[14], 
					  &t_out_sel[14], &t_in_sel[14]);

		west_disable(tile0, &t_data_out[9], &t_data_in[9], &t_oi_in[9], &t_oi_out[9],
					 &t_in_write_n[9], &t_out_write_n[9], &t_out_full[9], &t_in_full[9], 
					 &t_out_sel[9], &t_in_sel[9]);
		west_disable(tile4, &t_data_out[10], &t_data_in[10], &t_oi_in[10], &t_oi_out[10],
					 &t_in_write_n[10], &t_out_write_n[10], &t_out_full[10], &t_in_full[10], 
					 &t_out_sel[10], &t_in_sel[10]);
		west_disable(tile8, &t_data_out[11], &t_data_in[11], &t_oi_in[11], &t_oi_out[11], 
					 &t_in_write_n[11], &t_out_write_n[11], &t_out_full[11], &t_in_full[11], 
					 &t_out_sel[11], &t_in_sel[11]);
		west_disable(tile12, &t_data_out[15], &t_data_in[15], &t_oi_in[15], &t_oi_out[15], 
					 &t_in_write_n[15], &t_out_write_n[15], &t_out_full[15], &t_in_full[15], 
					 &t_out_sel[15], &t_in_sel[15]);

	}

	void rl_conn(tile *tile_l, tile *tile_r, sc_signal<bool> *fdata_out,
				 sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in,
				 sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n,
				 sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full,
				 sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel,
				 sc_signal<sc_uint<2> > *fin_sel);

	void ud_conn(tile *tile_u, tile *tile_d, sc_signal<bool> *fdata_out,
				 sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in,
				 sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n,
				 sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full,
				 sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel,
				 sc_signal<sc_uint<2> > *fin_sel);
	void north_disable(tile *tile, sc_signal<bool> *fdata_out,
				 sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in,
				 sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n,
				 sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full,
				 sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel,
				 sc_signal<sc_uint<2> > *fin_sel);
	void south_disable(tile *tile, sc_signal<bool> *fdata_out,
				 sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in,
				 sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n,
				 sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full,
				 sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel,
				 sc_signal<sc_uint<2> > *fin_sel);
	void east_disable(tile *tile, sc_signal<bool> *fdata_out,
				 sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in,
				 sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n,
				 sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full,
				 sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel,
				 sc_signal<sc_uint<2> > *fin_sel);
	void west_disable(tile *tile, sc_signal<bool> *fdata_out,
				 sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in,
				 sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n,
				 sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full,
				 sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel,
				 sc_signal<sc_uint<2> > *fin_sel);
};

#endif
