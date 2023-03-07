/********************************
 * Module: 	gbox_dly_adj
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox delay tap adjustment
********************************/
module gbox_dly_adj
#(
   parameter PAR_CWID = 5
)
(
  input  system_reset_n, // Input async system Reset
  input  x_reset_n ,   // tx or rx reset
  input  pll_lock ,  
  input  [PAR_CWID-1 :0] cfg_dly , // 
  input  fast_clk,  // Input fast Clock
  input  core_clk , // core clock domain
  input  dly_ld , // core clock domain , re-load configuration value
  input  dly_inc , // core clock domain , re-load configuration value
  input  dly_adj , // core clock domain , re-load configuration value
//****************************
//  output logic dly_adj_done , // not necessary
  output logic [PAR_CWID-1 :0] fast_dly_tap ,  // fast clock domain, final delay tap
  output logic [PAR_CWID-1 :0] dly_tap  // core clock domain, final delay tap
);
//*****************************************************************************
logic a_reset_n;
logic fast_reset_sync;
logic fast_reset_sync_n;
logic core_reset_sync;
logic core_reset_sync_n;
logic dly_ld_d1 , dly_ld_d2;
logic dly_adj_d1 , dly_adj_d2;
logic dly_inc_d1;
logic dly_ld_cp;
logic dly_adj_cp;
logic dly_ld_cp_sync;
logic dly_adj_cp_sync;
logic dly_ld_cp_sync_d1;
logic dly_adj_cp_sync_d1;
logic dly_ld_cp_fall;
logic dly_adj_cp_fall;
//*****************************************************************************
assign a_reset_n = system_reset_n && pll_lock && x_reset_n;
assign fast_reset_sync_n = !fast_reset_sync ;
assign core_reset_sync_n = !core_reset_sync ;
//*****************************************************************************
//************ reset
//*****************************************************************************
reset_sync u_reset_sync_fast (
       .rst_n(a_reset_n),
       .clk(fast_clk) ,
       .rst_sync(fast_reset_sync)
);

reset_sync u_reset_sync_core (
       .rst_n(a_reset_n),
       .clk(core_clk) ,
       .rst_sync(core_reset_sync)
);
//*****************************************************************************
//************ core clock stage 
//*****************************************************************************
always_ff @(posedge core_clk or negedge core_reset_sync_n)
 if (~core_reset_sync_n) begin
    dly_ld_d1  <= 1'b0;
    dly_ld_d2  <= 1'b0;
    dly_adj_d1 <= 1'b0;
    dly_adj_d2 <= 1'b0;
    dly_inc_d1 <= 1'b0;
 end
 else begin
    dly_ld_d1  <= dly_ld;
    dly_ld_d2  <= dly_ld_d1;
    dly_adj_d1 <= dly_adj;
    dly_adj_d2 <= dly_adj_d1;
    dly_inc_d1 <= dly_inc;
 end

assign dly_ld_cp = dly_ld_d1 && !dly_ld_d2 ;
assign dly_adj_cp = dly_adj_d1 && !dly_adj_d2 ;

//*****************************************************************************
//********* delay tap in core clock domain
//*****************************************************************************
always_ff @(posedge core_clk or negedge core_reset_sync_n)
 if (~core_reset_sync_n) 
    dly_tap <= 'b0;
 else if (dly_ld_cp) 
    dly_tap <= cfg_dly ;
 else if (dly_adj_cp &&  dly_inc_d1 && !(&dly_tap)) 
    dly_tap <= dly_tap + 1'b1 ;
 else if (dly_adj_cp && !dly_inc_d1 &&  (|dly_tap))
    dly_tap <= dly_tap - 1'b1 ;

//*****************************************************************************
//********* in fast clock domain
//*****************************************************************************
 sync_flop u_sync_flop_dly_ld (
  .reset_n (fast_reset_sync_n),
  .clk (fast_clk), 
  .din (dly_ld_cp), 
//*******************************
  .dout (dly_ld_cp_sync) 
);
//*****************************************************************************
 sync_flop u_sync_flop_dly_adj (
  .reset_n (fast_reset_sync_n),
  .clk (fast_clk), 
  .din (dly_adj_cp), 
//*******************************
  .dout (dly_adj_cp_sync) 
);

//*****************************************************************************
always_ff @(posedge fast_clk or negedge fast_reset_sync_n)
 if (~fast_reset_sync_n) begin
    dly_ld_cp_sync_d1 <= 1'b0;
    dly_adj_cp_sync_d1 <= 1'b0;
 end
 else begin
    dly_ld_cp_sync_d1 <= dly_ld_cp_sync;
    dly_adj_cp_sync_d1 <= dly_adj_cp_sync;
 end

assign dly_ld_cp_fall  = !dly_ld_cp_sync  && dly_ld_cp_sync_d1 ;
assign dly_adj_cp_fall = !dly_adj_cp_sync && dly_adj_cp_sync_d1 ;

//*****************************************************************************
//********* sync to fast clock domain
//*****************************************************************************
always_ff @(posedge fast_clk or negedge fast_reset_sync_n)
 if (~fast_reset_sync_n) 
    fast_dly_tap <= 'b0;
 else if (dly_ld_cp_fall || dly_adj_cp_fall) 
    fast_dly_tap <= dly_tap ;

//*****************************************************************************
endmodule
