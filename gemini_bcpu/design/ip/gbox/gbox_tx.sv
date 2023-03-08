/********************************
 * Module: 	gbox_tx
 * Date:	8/24/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox tx
********************************/
module gbox_tx
#(
   parameter PAR_DWID = 10,
   parameter PAR_TWID =  6
)
(
  input  system_reset_n, 		// Input async system Reset
  input  pll_lock ,  
  input  tx_reset_n,  			// Input sync Reset , core clock domain
  input  [3:0] rate_sel  ,  
  input  cfg_bypass  ,  
  input  [1:0] cfg_ddr_mode  ,  
  input  fast_clk,  			// Input fast Clock
  input  [3:0] fast_phase_clk  ,  
  input  word_load_en , 		// fast clock domain
  input  core_clk , 
  input  [PAR_TWID-1 :0] cfg_dly , //
  input  [PAR_DWID-1:0] tx_in ,  // core clock
  input  tx_oe ,  	// core clock
  input  tx_dvalid , // core clock
  input  dly_ld ,  		// core clock
  input  dly_inc ,  	// core clock
  input  dly_adj ,  	// core clock
//****************************
  output logic [PAR_TWID-1:0] dly_tap , // core clock domain 
  output logic tx_ser_out , // fast
  output logic tx_ser_oe  // fast
);
//*****************************************************************************
logic [PAR_TWID-1:0] fast_dly_tap ;
//*****************************************************************************
logic tx_bp_out ;
logic tx_bp_oe ;
//*****************************************************************************
logic tx_ser_out_a ;
logic tx_ser_oe_a;
//*****************************************************************************
logic tx_ser_out_b;
//*****************************************************************************
gbox_dly_adj # (
            .PAR_CWID(PAR_TWID)
) u_gbox_dly_adj_tx (
     .system_reset_n(system_reset_n), // Input async system Reset
     .x_reset_n( tx_reset_n),   // tx or tx reset
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
gbox_iobp_o u_gbox_iobp_o
( 
     .clk (fast_clk) ,
     .cfg_bypass(cfg_bypass),
     .cfg_ddr_mode(cfg_ddr_mode),
     .din(tx_in[1:0]), // from fabric
//**************************
     .dout(tx_bp_out) 
);
//*****************************************************************************
gbox_iobp_oe u_gbox_iobp_oe
( 
     .clk (fast_clk) ,
     .cfg_bypass(cfg_bypass),
     .cfg_ddr_mode(cfg_ddr_mode),
     .din(tx_oe), // from fabric
//**************************
     .dout(tx_bp_oe) 
);
//*****************************************************************************
gbox_ser #(
   .PAR_DWID(PAR_DWID)
) u_gbox_ser (
       .system_reset_n(system_reset_n), // Input async system Reset
       .tx_reset_n(tx_reset_n),  // Input sync Reset , core clock domain
       .rate_sel(rate_sel)  ,  
       .cfg_bypass(cfg_bypass)  ,  
       .fast_clk(fast_clk),  // Input fast Clock
       .word_load_en(word_load_en) , // fast clock domain
       .core_clk(core_clk) , 
       .data_in(tx_in) , // core clock domain
       .data_valid(tx_dvalid) , // core clock domain
       .data_oe(tx_oe) , // core clock domain
//****************************
       .ser_out (tx_ser_out_a) , // serial data out
       .ser_oe (tx_ser_oe_a)  // serial data out enable
);
//*****************************************************************************
assign tx_ser_out_b = cfg_bypass ? tx_bp_out : tx_ser_out_a ;
assign tx_ser_oe = cfg_bypass ? tx_bp_oe : tx_ser_oe_a ;
//*****************************************************************************
supply1 DVDD ;
supply0 DGND ;

delay_line_64tap  u_delay_tap_tx ( 
   .DVDD (DVDD) ,            
   .DGND (DGND) ,            
///   .DVDD (1'b1) ,            
///   .DGND (1'b0) ,            
   .in (tx_ser_out_b) ,            
   .sel(fast_dly_tap) ,
//*************************************
   .out(tx_ser_out)
);

//*****************************************************************************
endmodule
