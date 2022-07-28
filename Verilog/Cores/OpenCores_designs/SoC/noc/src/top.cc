/*
 * =====================================================================================
 *
 *       Filename:  tile.cc
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  04/08/2009 10:49:51 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Soontea Kwon (), Kwonst@skku.edu
 *        Company:  Mobile Electronics Lab
 *
 * =====================================================================================
 */
#include "top.h"

void top :: rl_conn(tile *tile_l, tile *tile_r, sc_signal<bool> *fdata_out, 
					sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in, 
					sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n, 
					sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full, 
					sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel, 
					sc_signal<sc_uint<2> > *fin_sel)
{
	tile_l->e_oi_out(*foi_out);
	tile_r->w_oi_in(*foi_out);
	tile_l->e_oi_in(*foi_in);
	tile_r->w_oi_out(*foi_in);

	tile_l->e_data_out(*fdata_out);
	tile_r->w_data_in(*fdata_out);
	tile_l->e_data_in(*fdata_in);
	tile_r->w_data_out(*fdata_in);

	tile_l->e_out_write_n(*fout_write_n); 
	tile_r->w_in_write_n(*fout_write_n);
	tile_l->e_in_write_n(*fin_write_n); 
	tile_r->w_out_write_n(*fin_write_n);

	tile_l->e_out_full(*fout_full);
	tile_r->w_in_full(*fout_full);
	tile_l->e_in_full(*fin_full);
	tile_r->w_out_full(*fin_full);

	tile_l->e_out_sel(*fout_sel);
	tile_r->w_in_sel(*fout_sel);
	tile_l->e_in_sel(*fin_sel);
	tile_r->w_out_sel(*fin_sel);
}

void top :: ud_conn(tile *tile_u, tile *tile_d, sc_signal<bool> *fdata_out, 
					sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in, 
					sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n, 
					sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full, 
					sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel, 
					sc_signal<sc_uint<2> > *fin_sel)
{
	tile_u->s_oi_out(*foi_out);
	tile_d->n_oi_in(*foi_out);
	tile_u->s_oi_in(*foi_in);
	tile_d->n_oi_out(*foi_in);

	tile_u->s_data_out(*fdata_out);
	tile_d->n_data_in(*fdata_out);
	tile_u->s_data_in(*fdata_in);
	tile_d->n_data_out(*fdata_in);

	tile_u->s_out_write_n(*fout_write_n); 
	tile_d->n_in_write_n(*fout_write_n);
	tile_u->s_in_write_n(*fin_write_n); 
	tile_d->n_out_write_n(*fin_write_n);

	tile_u->s_out_full(*fout_full);
	tile_d->n_in_full(*fout_full);
	tile_u->s_in_full(*fin_full);
	tile_d->n_out_full(*fin_full);

	tile_u->s_out_sel(*fout_sel);
	tile_d->n_in_sel(*fout_sel);
	tile_u->s_in_sel(*fin_sel);
	tile_d->n_out_sel(*fin_sel);
}

void top :: north_disable(tile *tile, sc_signal<bool> *fdata_out, 
					sc_signal<bool> *fdata_in, sc_signal<sc_logic> *foi_in, 
					sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n, 
					sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full, 
					sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel, 
					sc_signal<sc_uint<2> > *fin_sel)
{
	tile->n_oi_out(*foi_out);
	tile->n_oi_in(*foi_in);

	tile->n_data_out(*fdata_out);
	tile->n_data_in(*fdata_in);
	tile->n_out_write_n(*fout_write_n);
	tile->n_in_write_n(*fin_write_n);
	tile->n_out_full(*fout_full);
	tile->n_in_full(*fin_full);
	tile->n_out_sel(*fout_sel);
	tile->n_in_sel(*fin_sel);
}

void top ::south_disable(tile *tile,sc_signal<bool> *fdata_out, 
					sc_signal<bool> *fdata_in,  sc_signal<sc_logic> *foi_in, 
					sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n, 
					sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full, 
					sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel, 
					sc_signal<sc_uint<2> > *fin_sel )
{	
	tile->s_oi_out(*foi_out);
	tile->s_oi_in(*foi_in);

	tile->s_data_out(*fdata_out);
	tile->s_data_in(*fdata_in);
	tile->s_out_write_n(*fout_write_n);
	tile->s_in_write_n(*fin_write_n);
	tile->s_out_full(*fout_full);
	tile->s_in_full(*fin_full);
	tile->s_out_sel(*fout_sel);
	tile->s_in_sel(*fin_sel);

}

void top ::east_disable(tile *tile, sc_signal<bool> *fdata_out, 
					sc_signal<bool> *fdata_in,  sc_signal<sc_logic> *foi_in, 
					sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n, 
					sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full, 
					sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel, 
					sc_signal<sc_uint<2> > *fin_sel)
{	
	tile->e_oi_out(*foi_out);
	tile->e_oi_in(*foi_in);

	tile->e_data_out(*fdata_out);
	tile->e_data_in(*fdata_in);
	tile->e_out_write_n(*fout_write_n);
	tile->e_in_write_n(*fin_write_n);
	tile->e_out_full(*fout_full);
	tile->e_in_full(*fin_full);
	tile->e_out_sel(*fout_sel);
	tile->e_in_sel(*fin_sel);
}

void top ::west_disable(tile *tile, sc_signal<bool> *fdata_out, 
					sc_signal<bool> *fdata_in,  sc_signal<sc_logic> *foi_in, 
					sc_signal<sc_logic> *foi_out, sc_signal<bool> *fin_write_n, 
					sc_signal<bool> *fout_write_n, sc_signal<sc_uint<3> > *fout_full, 
					sc_signal<sc_uint<3> > *fin_full, sc_signal<sc_uint<2> > *fout_sel, 
					sc_signal<sc_uint<2> > *fin_sel)
{
	tile->w_oi_out(*foi_out);
	tile->w_oi_in(*foi_in);

	tile->w_data_out(*fdata_out);
	tile->w_data_in(*fdata_in);
	tile->w_out_write_n(*fout_write_n);
	tile->w_in_write_n(*fin_write_n);
	tile->w_out_full(*fout_full);
	tile->w_in_full(*fin_full);
	tile->w_out_sel(*fout_sel);
	tile->w_in_sel(*fin_sel);
}
