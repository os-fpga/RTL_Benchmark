/********************************
 * Module: 	gbox_clk_gen
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 * gearbox clock generator 
 *  Description : generate all the clocks
********************************/
module gbox_clk_gen
(
  input  reset_n,  // Input Async Reset
  input  pll_lock,  // 
  input  fast_clk,  // Input fast Clock
  input  fast_clk_sync_in,  // sync up the counter across lanes
  input  fast_cdr_clk_sync_in,  // sync up the counter across lanes
  input  cdr_clk ,  // Input phase shifted fast Clock
  input  cfg_chan_master,  // sync up the counter across lanes
  input  [3:0]  rate_sel  ,  
  input  cfg_done  ,  
  input  cfg_bypass  ,  
  input  fast_tx_phase_clk, 
//****************************
  output logic phase_diff_clk , // for tx output clock 
  output logic diff_clk , // for tx differential clock, select DDR data output
  output logic core_clk , 
  output logic word_load_en , // fast clock domain
  output logic fast_clk_sync_out , // fast clock domain
  output logic cdr_word_load_en , // fast clock domain
  output logic fast_cdr_clk_sync_out , // fast clock domain
  output logic cdr_core_clk  // cdr fast clock domain
);
//*****************************************************************************

logic [4:0] pll_lock_cnt;
logic [3:0] clk_cnt;
logic     fast_reset_sync;
logic     a_reset_n;
logic     b_reset_n;
logic     fast_reset_sync_n;
logic     cdr_reset_sync;
logic     cdr_reset_sync_n;
logic     all_fast_reset_sync_n;
logic     all_cdr_reset_sync_n;
logic pll_lock_ff ;
logic     b_fast_reset_sync;
logic     b_fast_reset_sync_n;

logic [3:0] rate_sel_minus_1;
logic [3:0] cnt_add_1;
logic cnt_end ;
logic cnt_half ;
logic pre_cnt_end ;
logic [3:0] cdr_clk_cnt;
logic [3:0] cdr_rate_sel_minus_1;
logic [3:0] cdr_cnt_add_1;
logic cdr_cnt_end ;
logic cdr_cnt_half ;
logic cdr_pre_cnt_end ;
//*****************************************************************************
assign a_reset_n = reset_n && !cfg_bypass && cfg_done && pll_lock ;
////assign a_reset_n = reset_n  && cfg_done && pll_lock ;
assign fast_reset_sync_n = !fast_reset_sync ; // for hold time
assign all_fast_reset_sync_n = !fast_reset_sync && pll_lock_ff ; // for hold time
assign cdr_reset_sync_n = !cdr_reset_sync ; // for hold time
assign all_cdr_reset_sync_n = !cdr_reset_sync && pll_lock_ff ; // for hold time

assign b_fast_reset_sync_n = !b_fast_reset_sync ; 
//*****************************************************************************
assign b_reset_n = reset_n && cfg_done ; // no bypass condition for diff_clk
//*****************************************************************************
//************ fast reset 
//*****************************************************************************
reset_sync u_reset_sync_fast_a (
       .rst_n(a_reset_n),
       .clk(fast_clk) ,
       .rst_sync(fast_reset_sync)
);

reset_sync u_reset_sync_fast_b (
       .rst_n(b_reset_n),
       .clk(fast_clk) ,
       .rst_sync(b_fast_reset_sync)
);
//*****************************************************************************
//************ cdr reset
//*****************************************************************************
reset_sync u_reset_sync_cdr (
       .rst_n(a_reset_n),
       .clk(cdr_clk) ,
       .rst_sync(cdr_reset_sync)
);
//*****************************************************************************
//***** detect pll lock stable
//*****************************************************************************
always_ff @(posedge fast_clk or negedge fast_reset_sync_n)
  if (~fast_reset_sync_n) 
    pll_lock_cnt <= 5'd0;
  else if (!pll_lock)
    pll_lock_cnt <= 5'd0 ;
  else if ( !( &pll_lock_cnt) )
    pll_lock_cnt <= pll_lock_cnt + 1'b1 ;
//*****************************************************************************
always_ff @(posedge fast_clk or negedge fast_reset_sync_n)
  if (~fast_reset_sync_n) 
    pll_lock_ff <= 1'b0;
  else 
    pll_lock_ff <= &pll_lock_cnt ;
//*****************************************************************************
//*********** rate clock counter
//*****************************************************************************
always_ff @(posedge fast_clk or negedge fast_reset_sync_n)
  if (~fast_reset_sync_n) 
    rate_sel_minus_1 <= 4'd0;
  else 
    rate_sel_minus_1 <= rate_sel - 1'b1 ;

 assign cnt_end  = clk_cnt == rate_sel_minus_1 ;
 assign cnt_half = clk_cnt == {1'b0,rate_sel[3:1]} ;
 assign cnt_add_1 = clk_cnt + 1'b1 ;
 assign pre_cnt_end  = cnt_add_1 == rate_sel_minus_1 ;

always_ff @(posedge fast_clk or negedge all_fast_reset_sync_n)
  if (~all_fast_reset_sync_n) 
    clk_cnt <= 4'd0;
  else if (cnt_end || fast_clk_sync_in && !cfg_chan_master)
    clk_cnt <= 4'd0 ;
  else 
    clk_cnt <= cnt_add_1 ;

//*****************************************************************************
always_ff @(posedge fast_clk or negedge all_fast_reset_sync_n)
  if (~all_fast_reset_sync_n) 
     core_clk <= 1'b1;
  else if (cnt_half ) 
     core_clk <= 1'b0 ;
  else if (cnt_end || fast_clk_sync_in && !cfg_chan_master) 
     core_clk <= 1'b1 ;
//*****************************************************************************
always_ff @(posedge fast_clk or negedge all_fast_reset_sync_n)
  if (~all_fast_reset_sync_n) 
     fast_clk_sync_out <= 1'b0;
  else 
     fast_clk_sync_out <= pre_cnt_end; // equal to clk_end but flopped

//*****************************************************************************
//*******  core clock domain
//******* in sync with positive edge of core_clk 
//******* to get full core_clk time to populate data to fabric
//*****************************************************************************
always_ff @(posedge fast_clk or negedge all_fast_reset_sync_n)
  if (~all_fast_reset_sync_n) 
     word_load_en <= 1'b0;
  else 
     word_load_en <= cnt_half ; // pre_cnt_end; //  cnt_end || fast_clk_sync_in && !cfg_chan_master; 

//*****************************************************************************
//*******  CDR cdr core clock domain
//*******  in sync with positive edge of core_clk 
//*******  this should be ok for phase 90 degree
//*******  ?????????? is this ok for phase 0 degree , TO DO to do ??????????
//*****************************************************************************
//*********** rate clock counter
//*****************************************************************************
always_ff @(posedge cdr_clk or negedge cdr_reset_sync_n)
  if (~cdr_reset_sync_n) 
    cdr_rate_sel_minus_1 <= 4'd0;
  else 
    cdr_rate_sel_minus_1 <= rate_sel - 1'b1 ;

 assign cdr_cnt_end  = cdr_clk_cnt == cdr_rate_sel_minus_1 ;
 assign cdr_cnt_half = cdr_clk_cnt == {1'b0,rate_sel[3:1]};
 assign cdr_cnt_add_1 = cdr_clk_cnt + 1'b1 ;
 assign cdr_pre_cnt_end  = cdr_cnt_add_1 == cdr_rate_sel_minus_1 ;

always_ff @(posedge cdr_clk or negedge all_cdr_reset_sync_n)
  if (~all_cdr_reset_sync_n) 
    cdr_clk_cnt <= 4'd0;
  else if (cdr_cnt_end || fast_cdr_clk_sync_in && !cfg_chan_master)
    cdr_clk_cnt <= 4'd0 ;
  else 
    cdr_clk_cnt <= cdr_cnt_add_1 ;
//*****************************************************************************
always_ff @(posedge cdr_clk or negedge all_cdr_reset_sync_n)
  if (~all_cdr_reset_sync_n) 
     cdr_core_clk <= 1'b1;
  else if (cdr_cnt_half ) 
     cdr_core_clk <= 1'b0 ;
  else if (cdr_cnt_end || fast_cdr_clk_sync_in && !cfg_chan_master) 
     cdr_core_clk <= 1'b1 ;
//*****************************************************************************
always_ff @(posedge cdr_clk or negedge all_cdr_reset_sync_n)
  if (~all_cdr_reset_sync_n) 
     fast_cdr_clk_sync_out <= 1'b0;
  else 
     fast_cdr_clk_sync_out <= cdr_pre_cnt_end; // equal to clk_end but flopped

always_ff @(posedge cdr_clk or negedge all_cdr_reset_sync_n)
  if (~all_cdr_reset_sync_n) 
     cdr_word_load_en <= 1'b0;
  else 
     cdr_word_load_en <= cdr_cnt_half ; // cdr_cnt_end || fast_cdr_clk_sync_in; && !cfg_chan_master 
//*****************************************************************************
//************* diff_clk is used to select the 2-bit DDR data
//*****************************************************************************
always_ff @(posedge fast_clk or negedge b_fast_reset_sync_n)
  if (~b_fast_reset_sync_n) 
    diff_clk <= 1'b0;
  else 
    diff_clk <= !diff_clk ;

always_ff @(posedge fast_tx_phase_clk or negedge b_fast_reset_sync_n)
  if (~b_fast_reset_sync_n) 
    phase_diff_clk <= 1'b0;
  else 
    phase_diff_clk <= !phase_diff_clk ;
//*****************************************************************************
endmodule
