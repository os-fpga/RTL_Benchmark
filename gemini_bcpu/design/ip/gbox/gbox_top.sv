/********************************
 * Module: 	gbox_top
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox top level
********************************/
//** PAR_X_DWID : gearbox data path width,  value allowed 10 or 5 
//** PAR_TWID : delay tap value, either 32 taps or 64 taps
module gbox_top
#(
   parameter PAR_TX_DWID = 10,
   parameter PAR_RX_DWID = 10,
   parameter PAR_TWID =  6
)
(
  input  system_reset_n, 		// Input async system Reset
  input  pll_lock ,  
  input  [3:0] cfg_rate_sel  ,  
  input  cfg_done  ,  
  input  cfg_dif  ,  
  input  cfg_chan_master  ,  
  input  [1:0] cfg_tx_clk_phase , 
  input  cfg_peer_is_on  ,  
  input  cfg_tx_bypass  ,  
  input  cfg_rx_bypass  ,  
  input  [PAR_TWID-1:0] cfg_tx_dly ,  
  input  [PAR_TWID-1:0] cfg_rx_dly ,  
  input  [1:0] cfg_tx_ddr_mode  ,  
  input  [1:0] cfg_rx_ddr_mode  ,  
  input  fast_clk,  			// Input fast Clock
  input  i2g_rx_in,  			// Input fast Clock
  input  [3:0] fast_phase_clk  ,  
  input  f2g_tx_reset_n,  			// Input sync Reset , core clock domain
  input  f2g_tx_core_clk ,  		// core clock
  input  f2g_tx_dly_ld , 
  input  f2g_tx_dly_adj , 
  input  f2g_tx_dly_inc , 
  input  f2g_tx_oe ,  		// core clock
  input  [PAR_TX_DWID-1:0] f2g_tx_out ,  // core clock
  input  f2g_in_en ,  		// core clock
  input  f2g_tx_dvalid,  			// core clock domain
  input  f2g_rx_reset_n,  			// Input sync Reset , core clock domain
  input  f2g_rx_sfifo_reset,  		// dpa sync_fifo_dpa fifo reset , core clock domain
  input  f2g_rx_dly_ld , 
  input  f2g_rx_dly_adj , 
  input  f2g_rx_dly_inc , 
  input  f2g_rx_bitslip_adj ,  		// core clock
  input  [1:0] f2g_rx_dpa_mode  ,  
  input  f2g_rx_dpa_restart ,  		// core clock
  input  fast_clk_sync_in ,  	// fast clock from adjacent GBOX
  input  fast_cdr_clk_sync_in ,  	// fast clock from adjacent GBOX
  input  [5-1:0] peer_data_in , // core clock domain
//****************************
  output logic fast_clk_sync_out , // fast clock domain to adjacent GBOX
  output logic fast_cdr_clk_sync_out , // fast clock domain to adjacent GBOX
  output logic g2i_tx_out , 		// fast clock
  output logic g2i_tx_oe , 		// fast clock
  output logic g2i_tx_clk , 		// fast clock divided by 2 in DDR mode
  output logic g2i_ie , 		// core clock
  output logic cdr_clk , 		// fast clock domain
  output logic [PAR_TWID-1:0] g2f_tx_dly_tap , 	// core clock domain
  output logic g2f_core_clk , 	// core clock domain , used by both tx and rx if source-synchronous
  output logic g2f_rx_cdr_core_clk , 	// core clock domain , used by only rx if not source-synchronous
  output logic g2f_rx_dpa_lock , 		// fast clock domain
  output logic g2f_rx_dpa_error , 		// fast clock domain
  output logic [2:0] g2f_rx_dpa_phase , 	// fast clock domain
  output logic [PAR_TWID-1:0] g2f_rx_dly_tap , 	// core clock domain
  output logic [PAR_RX_DWID-1:0] g2f_rx_in , // quasi core clock domain 
  output logic g2f_rx_dvalid  // core clock domain 
);
//*****************************************************************************
////logic [1:0] cdr_phase_sel ;
//*****************************************************************************
logic diff_clk;
logic phase_diff_clk;
logic fast_tx_phase_clk;
logic g2f_core_clk_a;
logic word_load_en;
logic cdr_word_load_en;
//******************
//*****************************************************************************
gbox_clk_gen u_gbox_clk_gen
(
       .reset_n(system_reset_n),  // Input Async Reset
       .pll_lock(pll_lock) ,  
       .fast_clk(fast_clk),  // Input fast Clock
       .fast_clk_sync_in(fast_clk_sync_in),  // sync up the counter across lanes
       .fast_cdr_clk_sync_in(fast_cdr_clk_sync_in),  // sync up the counter across lanes
       .cdr_clk(cdr_clk) , // fast clock domain
       .cfg_chan_master(cfg_chan_master),  // sync up the counter across lanes
       .rate_sel(cfg_rate_sel)  ,  
       .cfg_done(cfg_done)  ,  
       .cfg_bypass(cfg_tx_bypass && cfg_rx_bypass)  ,  
       .fast_tx_phase_clk(fast_tx_phase_clk)  ,  
//****************************
       .phase_diff_clk(phase_diff_clk) , // for tx output clock
       .diff_clk(diff_clk) , // for tx differential clock
       .core_clk(g2f_core_clk_a) , 
       .word_load_en( word_load_en), // fast clock domain
       .fast_clk_sync_out (fast_clk_sync_out) , // fast clock domain
       .cdr_word_load_en (cdr_word_load_en) , // fast clock domain
       .fast_cdr_clk_sync_out (fast_cdr_clk_sync_out) , // fast clock domain
       .cdr_core_clk (g2f_rx_cdr_core_clk)  // cdr core clock domain
);
//*****************************************************************************
//********** clock mux , custom design 01 : DDR , 10: SDR , add clock buffer
//*****************************************************************************
//********* in bypass mode , g2i_tx_clk and g2f_core_clk are all fast_clk
//*****************************************************************************
/// assign g2i_tx_clk = !cfg_tx_bypass & cfg_tx_ddr_mode[0] & diff_clk |  
///	             (cfg_tx_bypass | cfg_tx_ddr_mode[1]) & fast_clk ;
 assign g2i_tx_clk = !cfg_tx_bypass & cfg_tx_ddr_mode[0] & phase_diff_clk |  
	             (cfg_tx_bypass | cfg_tx_ddr_mode[1]) & fast_tx_phase_clk ;
 assign g2f_core_clk = cfg_tx_bypass ? fast_clk : g2f_core_clk_a ;
 assign g2i_ie = f2g_in_en ;
//*****************************************************************************
//*************** handle tx_clk phase
//*****************************************************************************
supply0 DGND;
supply1 DVDD;

phase_sel_1_8 u_phase_clk_mux_tx( 
 .RESETB(pll_lock), 
 .phin( fast_phase_clk[3:0]) , 
 .s_ph ({1'b0, cfg_tx_clk_phase} ), 
 .o_sel_ph( fast_tx_phase_clk), 
 .DGND (DGND), 
 .DVDD (DVDD) );

//// assign fast_tx_phase_clk = (cfg_tx_clk_phase == 2'd0) & fast_phase_clk[0] |
////                            (cfg_tx_clk_phase == 2'd1) & fast_phase_clk[1] |
////                            (cfg_tx_clk_phase == 2'd2) & fast_phase_clk[2] |
////                            (cfg_tx_clk_phase == 2'd3) & fast_phase_clk[3] ;
//// 
//*****************************************************************************
gbox_rx #(
       .PAR_DWID(PAR_RX_DWID),
       .PAR_TWID(PAR_TWID)
) u_gbox_rx (
       .system_reset_n(system_reset_n), // Input async system Reset
       .pll_lock(pll_lock) ,  
       .rx_reset_n(f2g_rx_reset_n),  // Input sync Reset , core clock domain
       .rx_sfifo_reset(f2g_rx_sfifo_reset),  // 
       .rate_sel(cfg_rate_sel)  ,  
       .dpa_restart(f2g_rx_dpa_restart)  ,  
       .cfg_dif(cfg_dif)  ,  
       .cfg_peer_is_on(cfg_peer_is_on)  ,  
       .cfg_bypass(cfg_rx_bypass)  ,  
       .cfg_ddr_mode(cfg_rx_ddr_mode)  ,  
       .fast_clk(fast_clk),  // Input fast Clock
       .fast_phase_clk(fast_phase_clk),  // Input fast Clock
       .pad_data_in (i2g_rx_in) , // fast clock domain
       .word_load_en(word_load_en) , // fast clock domain
       .core_clk(g2f_core_clk_a) , 
       .dpa_mode(f2g_rx_dpa_mode) , 
       .bitslip_adj(f2g_rx_bitslip_adj) , 
       .cfg_dly(cfg_rx_dly) , 
       .dly_ld(f2g_rx_dly_ld) , 
       .dly_inc(f2g_rx_dly_inc) , 
       .dly_adj(f2g_rx_dly_adj) , 
       .peer_data_in(peer_data_in) , // core clock domain
//****************************
       .cdr_clk(cdr_clk) , // fast clock domain
       .dpa_lock(g2f_rx_dpa_lock) , // fast clock domain
       .dpa_error(g2f_rx_dpa_error) , // fast clock domain 
       .dpa_phase(g2f_rx_dpa_phase) , // fast clock domain 
       .dly_tap(g2f_rx_dly_tap) , // core clock domain 
       .des_data_out(g2f_rx_in)  ,// quasi core clock domain 
       .des_data_valid(g2f_rx_dvalid)  // core clock domain 
);
//*****************************************************************************
gbox_tx #(
       .PAR_DWID(PAR_TX_DWID),
       .PAR_TWID(PAR_TWID)
) u_gbox_tx (
       .system_reset_n(system_reset_n), // Input async system Reset
       .pll_lock(pll_lock) ,  
       .tx_reset_n(f2g_tx_reset_n),  // Input sync Reset , core clock domain
       .rate_sel(cfg_rate_sel)  ,  
       .cfg_bypass(cfg_tx_bypass)  ,  
       .cfg_ddr_mode(cfg_tx_ddr_mode)  ,  
       .fast_clk(fast_clk),  // Input fast Clock
       .fast_phase_clk(fast_phase_clk),  // Input fast Clock
       .word_load_en(word_load_en) , // fast clock domain
       .core_clk(f2g_tx_core_clk) , // g2f_core_clk_a) , 
       .cfg_dly(cfg_tx_dly) , 
       .tx_in (f2g_tx_out) , // core clock domain
       .tx_oe(f2g_tx_oe) , // core clock
       .tx_dvalid(f2g_tx_dvalid) , // core clock
       .dly_ld(f2g_tx_dly_ld) , 
       .dly_inc(f2g_tx_dly_inc) , 
       .dly_adj(f2g_tx_dly_adj) , 
//****************************
       .dly_tap(g2f_tx_dly_tap) , // core clock domain 
       .tx_ser_out(g2i_tx_out)  ,// fast clock domain 
       .tx_ser_oe(g2i_tx_oe)  // fast clock domain 
);
//*****************************************************************************
endmodule
