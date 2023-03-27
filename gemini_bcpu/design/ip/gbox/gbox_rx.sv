/********************************
 * Module: 	gbox_rx
 * Date:	8/24/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox rx
********************************/
module gbox_rx
#(
   parameter PAR_DWID = 10,
   parameter PAR_TWID =  6
)
(
  input  system_reset_n, 		// Input async system Reset
  input  pll_lock ,  
  input  rx_reset_n,  			// Input sync Reset , core clock domain
  input  rx_sfifo_reset,  		// dpa sync_fifo_dpa fifo reset , core clock domain
  input  [3:0] rate_sel  ,  
  input  dpa_restart,  			// restart DAP , core clock domain
  input  cfg_dif  ,  
  input  cfg_peer_is_on  ,  
  input  cfg_bypass  ,  
  input  [1:0] cfg_ddr_mode  ,  
  input  fast_clk,  			// Input fast Clock
  input  [3:0] fast_phase_clk  ,  
  input  pad_data_in , 		// fast clock domain , from PAD
  input  word_load_en , 		// fast clock domain
  input  core_clk , 
  input  [1:0] dpa_mode  ,  
  input  bitslip_adj ,  		// core clock
  input  [PAR_TWID-1 :0] cfg_dly , //
  input  dly_ld ,  		// core clock
  input  dly_inc ,  		// core clock
  input  dly_adj ,  		// core clock
  input  [5-1:0] peer_data_in , // core clock domain
//****************************
  output logic cdr_clk , 		// fast clock domain
  output logic dpa_lock , 		// fast clock domain
  output logic dpa_error , 		// fast clock domain
  output logic [2:0] dpa_phase , 	// fast clock domain
  output logic [PAR_TWID-1:0] dly_tap , // core clock domain 
  output logic [PAR_DWID-1:0] des_data_out , // quasi core clock domain 
  output logic des_data_valid  // core clock domain 
);
//*****************************************************************************
logic [PAR_TWID-1:0] fast_dly_tap ;
logic dly_data_out ;
//*****************************************************************************
logic [1:0] bypass_data ;
//*****************************************************************************
logic [1:0] cdr_phase_sel ;
logic dpa_first_lock_rise;
//*****************************************************************************
logic a_reset_n;
logic fast_reset_sync_fifo_dpa;
logic cdr_reset_sync_fifo_dpa;
//******************
logic dpa_fifo_dout;
logic dpa_fifo_aemp;
logic dpa_fifo_full;
//******************
logic cdr_dout;
logic bslip_din;
//******************
logic bitslip_done;
logic bitslip_dout;
//******************
logic rx_fast_reset_sync_n;
logic rx_core_reset_sync_n;
logic [PAR_DWID-1:0] des_data_out_a ; 
assign  dpa_phase = {1'b0 , cdr_phase_sel} ; 
//*****************************************************************************
gbox_dly_adj # (
            .PAR_CWID(PAR_TWID)
) u_gbox_dly_adj_rx (
     .system_reset_n(system_reset_n), // Input async system Reset
     .x_reset_n( rx_reset_n),   // tx or rx reset
     .pll_lock(pll_lock),  
     .cfg_dly (cfg_dly) , // 
     .fast_clk (fast_clk),  // Input fast Clock
     .core_clk (core_clk) , // core clock domain
     .dly_ld (dly_ld) , // core clock domain , re-load configuration value
     .dly_inc (dly_inc) , // core clock domain , re-load configuration value
     .dly_adj (dly_adj) , // core clock domain , re-load configuration value
//****************************
     .fast_dly_tap (fast_dly_tap) ,  // core clock domain, final delay tap
     .dly_tap (dly_tap)  // core clock domain, final delay tap
);
//*****************************************************************************
supply1 DVDD ;
supply0 DGND ;
delay_line_64tap  u_delay_tap_rx (
   .DVDD (DVDD) ,            
   .DGND (DGND) ,    
   .in (pad_data_in) ,            
   .sel(fast_dly_tap) ,
//*************************************
   .out(dly_data_out)
);
//*****************************************************************************
gbox_iobp_i u_gbox_iobp_i ( 
     .clk (fast_clk) ,
     .cfg_bypass(cfg_bypass),
     .cfg_ddr_mode(cfg_ddr_mode),
     .din(dly_data_out), // from tap delay
//**************************
     .dout0(bypass_data[0]), // sdr , ddr , direct
     .dout1(bypass_data[1]) // ddr
);
//*****************************************************************************
gbox_cdr4 u_gbox_cdr4 (
  .reset_n(system_reset_n & rx_reset_n),
  .pll_lock(pll_lock), 
  .cfg_bypass(cfg_bypass), 
  .restart(dpa_restart), // core clock domain
  .mode(dpa_mode), // core clock domain, treat as static signal
  .clk(fast_phase_clk), // 4 phases clocks
  .data_in(dly_data_out), // from tap delay
//**************************
  .dpa_first_lock_rise(dpa_first_lock_rise),
  .dpa_lock(dpa_lock),
  .dpa_error(dpa_error),
  .cdr_phase_sel(cdr_phase_sel) // selected phase
);
//*****************************************************************************
//***************** glitchless clock mux---> TO DO move to top level
//*****************************************************************************
phase_sel_1_8 u_phase_clk_mux_cdr( 
 .RESETB(pll_lock), 
 .phin( fast_phase_clk[3:0]) , 
 .s_ph ({1'b0, cdr_phase_sel} ), 
 .o_sel_ph( cdr_clk), 
 .DGND (DGND), 
 .DVDD (DVDD) );

//// always @(*) begin
////   case (cdr_phase_sel)
////      2'b01   : cdr_clk = fast_phase_clk[1] ;
////      2'b10   : cdr_clk = fast_phase_clk[2] ;
////      2'b11   : cdr_clk = fast_phase_clk[3] ;
////      default : cdr_clk = fast_phase_clk[0] ;
////   endcase
//// end
//***************************************************************************** 
//************ fifo phase_clk -->  fast_clk
//*****************************************************************************
assign a_reset_n = system_reset_n && !cfg_bypass && pll_lock && rx_reset_n && !dpa_first_lock_rise;
//*****************************************************************************
reset_sync u_reset_sync_fast_fifo_dpa (
       .rst_n(a_reset_n),
       .clk(fast_clk) ,
       .rst_sync(fast_reset_sync_fifo_dpa)
);

reset_sync u_reset_sync_cdr_fifo_dpa (
       .rst_n(a_reset_n),
       .clk(cdr_clk) ,
       .rst_sync(cdr_reset_sync_fifo_dpa)
);

nds_async_fifo_afe # (
            .DATA_WIDTH(1) ,
            .FIFO_DEPTH(8) 
     ) u_sync_fifo_dpa (
       .w_reset_n(!cdr_reset_sync_fifo_dpa),
       .r_reset_n(!fast_reset_sync_fifo_dpa),
       .w_clk(cdr_clk),
       .r_clk(fast_clk) ,
       .wr(!dpa_fifo_full),
       .wr_data(dly_data_out),
       .rd(!dpa_fifo_aemp),
//****************************
       .rd_data(dpa_fifo_dout),
       .almost_empty(dpa_fifo_aemp),
       .almost_full( ),
       .empty(),
       .full(dpa_fifo_full)
);
//*****************************************************************************
//************ cdr data
//*****************************************************************************
always_ff @(posedge cdr_clk )
   begin
    cdr_dout <= dly_data_out;
   end
//*****************************************************************************
//***************** serial data mux for DPA mode
//*****************************************************************************

always @(*) begin
  case (dpa_mode)
     2'b10   : bslip_din = cdr_dout ; // soft cdr mode
     2'b11   : bslip_din = dpa_fifo_dout ; // dpa mode
     default : bslip_din = dly_data_out ;  // dpa_cdr disabled
  endcase
end

//*****************************************************************************
gbox_slip #(
       .PAR_DWID(PAR_DWID)
) u_gbox_slip (
    .rx_fast_reset_sync_n(rx_fast_reset_sync_n), // synced fast clock reset  for rx
    .rx_core_reset_sync_n(rx_core_reset_sync_n), // synced core clock reset  for rx
    .pll_lock(pll_lock) ,  
    .rate_sel(rate_sel)  ,  
    .fast_clk(fast_clk),  // Input fast Clock
    .data_in(bslip_din) , // fast clock domain
    .core_clk(core_clk) , // core clock domain
    .bitslip_adj(bitslip_adj) , // core clock domain
//****************************
    .bitslip_done(bitslip_done) , // core clock domain
    .bitslip_dout(bitslip_dout)
);

//*****************************************************************************
gbox_des #(
       .PAR_DWID(PAR_DWID)
) u_gbox_des (
       .system_reset_n(system_reset_n), // Input async system Reset
       .pll_lock(pll_lock) ,  
       .rx_reset_n(rx_reset_n),  // Input sync Reset , core clock domain
       .rate_sel(rate_sel)  ,  
       .cfg_bypass(cfg_bypass)  ,  
       .cfg_dif(cfg_dif)  ,  
       .cfg_peer_is_on(cfg_peer_is_on)  ,  
       .fast_clk(fast_clk),  // Input fast Clock
       .data_in (bitslip_dout) , // fast clock domain
       .word_load_en(word_load_en) , // fast clock domain
       .core_clk(core_clk) , 
       .peer_data_in(peer_data_in) , // core clock domain
//****************************
       .rx_fast_reset_sync_n(rx_fast_reset_sync_n) , // fast clock domain
       .rx_core_reset_sync_n(rx_core_reset_sync_n) , // core clock domain
       .des_data_out(des_data_out_a) , // core clock domain 
       .des_data_valid(des_data_valid)  // core clock domain 
);
//*****************************************************************************

assign des_data_out[0] = cfg_bypass ? bypass_data[0] : des_data_out_a[0] ;
assign des_data_out[1] = cfg_bypass ? bypass_data[1] : des_data_out_a[1] ;

assign des_data_out[PAR_DWID-1:2] = des_data_out_a[PAR_DWID-1:2] ;

//*****************************************************************************
endmodule
