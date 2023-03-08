/********************************
 * Module: 	gbox_cdr4
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 * gearbox soft cdr 
 *  Description : uses 4 clocks to recover data and selet the best clock phase --> dynamic DPA
 * 	sample A is captured on clk 0,
 * 	sample B is captured on clk 1,
 * 	sample C is captured on clk 2, 
 * 	sample D is captured on clk 3,
********************************/

module gbox_cdr4
( 
  input reset_n, // system reset
  input pll_lock,
  input cfg_bypass,
  input restart, // core clock domain
  input [1:0] mode, // core clock domain, treat as static signal
  input [3:0] clk, // 4 phases clocks
  input   data_in,
//**************************
  output logic dpa_first_lock_rise,
  output logic dpa_lock,
  output logic dpa_error,
  output logic [1:0] cdr_phase_sel // selected phase
);
//*****************************************************************************
parameter PAR_CNT_WID  = 6 ;
//*****************************************************************************
logic 	a_reset_n ;
logic 	fast_reset_sync_0 ;
logic 	fast_reset_sync_1 ;
logic 	fast_reset_sync_2 ;
logic 	fast_reset_sync_3 ;
logic 	fast_reset_sync_0_n ;
logic 	fast_reset_sync_1_n ;
logic 	fast_reset_sync_2_n ;
logic 	fast_reset_sync_3_n ;

logic 	phase_change_cp ;
logic 	sel_valid ;
logic 	dpa_only_done ;
logic 	restart_rise ;
logic 	soft_cdr ;
logic 	dpa_mode ;
logic 	dpa_cdr_disable ;

reg 		p_a_rise_3 ;
reg 		p_b_rise_3 ;
reg 		p_c_rise_3 ;
reg 		p_d_rise_3 ;
reg 		p_a_fall_3 ;
reg 		p_b_fall_3 ;
reg 		p_c_fall_3 ;
reg 		p_d_fall_3 ;

reg 	[2:0] 	data_a ;
reg 	[2:0] 	data_b ;
reg 	[2:0] 	data_c ;
reg 	[2:0] 	data_d ;
reg 		data_out_a ;
reg 		data_out_b ;
reg 		data_out_c ;
reg 		data_out_d ;
reg 		a_rise_3 ;
reg 		b_rise_3 ;
reg 		c_rise_3 ;
reg 		d_rise_3 ;
reg 		a_fall_3 ;
reg 		b_fall_3 ;
reg 		c_fall_3 ;
reg 		d_fall_3 ;
reg 		sel_a ;
reg 		sel_b ;
reg 		sel_c ;
reg 		sel_d ;
reg 	[1:0] 	cdr_phase_sel_old ;
reg 	[1:0] 	cdr_phase_sel_a ;
reg 		first_lock_done ;
reg 		first_lock_done_d1 ;
reg 		cdr_cnr_eq_1 ;
reg 	[PAR_CNT_WID-1 :0] 	cdr_cnt ;
reg 	[2:0] 	restart_sync ;
reg 	[1:0] 	mode_d1 ;
//*****************************************************************************
assign phase_change_cp = cdr_phase_sel_old != cdr_phase_sel_a ;
assign sel_valid       = (sel_a || sel_b || sel_c ||  sel_d) ;
//*****************************************************************************
assign a_reset_n = reset_n && !cfg_bypass && pll_lock ;
assign fast_reset_sync_0_n = !fast_reset_sync_0 ;
assign fast_reset_sync_1_n = !fast_reset_sync_1 ;
assign fast_reset_sync_2_n = !fast_reset_sync_2 ;
assign fast_reset_sync_3_n = !fast_reset_sync_3 ;
//*****************************************************************************
//************ reset
//*****************************************************************************
reset_sync u_reset_sync_fast_0 (
       .rst_n(a_reset_n),
       .clk(clk[0]) ,
//*********
       .rst_sync(fast_reset_sync_0)
);
//*****************************************************

reset_sync u_reset_sync_fast_1 (
       .rst_n(a_reset_n),
       .clk(clk[1]) ,
//*********
       .rst_sync(fast_reset_sync_1)
);

//*****************************************************
reset_sync u_reset_sync_fast_2 (
       .rst_n(a_reset_n),
       .clk(clk[2]) ,
//*********
       .rst_sync(fast_reset_sync_2)
);
//*****************************************************
reset_sync u_reset_sync_fast_3 (
       .rst_n(a_reset_n),
       .clk(clk[3]) ,
//*********
       .rst_sync(fast_reset_sync_3)
);
//*****************************************************************************
//********** sync up data across 4 phases
//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
  begin
	data_a <= 3'b111 ;
	data_b[2:1] <= 2'b11 ;
	data_c[2] <= 1'b1 ;
	data_out_a <= 1'b1 ;
	data_out_b <= 1'b1 ;
	data_out_c <= 1'b1 ;
	data_out_d <= 1'b1 ;
  end
else
  begin
	data_a <= {data_a[1:0] , data_in } ; 
	data_b[2:1] <= {data_b[1] , data_b[0] } ;
	data_c[2] <= data_c[1] ;
	data_out_a <= data_a[2] ;
	data_out_b <= data_b[2] ;
	data_out_c <= data_c[2] ;
	data_out_d <= data_d[2] ;
  end

always @(posedge clk[1] or negedge fast_reset_sync_1_n)
if (!fast_reset_sync_1_n)
  begin
	data_b[0] <= 1'b1 ;
	data_c[1] <= 1'b1 ;
	data_d[2] <= 1'b1 ;
  end
else
  begin
	data_b[0] <= data_in ; 
	data_c[1] <= data_c[0];
	data_d[2] <= data_d[1];
  end

always @(posedge clk[2] or negedge fast_reset_sync_2_n)
if (!fast_reset_sync_2_n)
  begin
	data_c[0] <= 1'b1 ;
	data_d[1] <= 1'b1 ;
  end
else
  begin
	data_c[0] <= data_in;
	data_d[1] <= data_d[0];
  end

always @(posedge clk[3] or negedge fast_reset_sync_3_n)
if (!fast_reset_sync_3_n)
  begin
	data_d[0] <= 1'b1 ;
  end
else
  begin
	data_d[0] <= data_in;
  end

//*****************************************************************************
//***************** detect edges
//*****************************************************************************
assign p_a_rise_3 = (data_a[1] ^ data_a[2]) &  data_a[1] ;	
assign p_b_rise_3 = (data_b[1] ^ data_b[2]) &  data_b[1] ;	
assign p_c_rise_3 = (data_c[1] ^ data_c[2]) &  data_c[1] ;	
assign p_d_rise_3 = (data_d[1] ^ data_d[2]) &  data_d[1] ;	
assign p_a_fall_3 = (data_a[1] ^ data_a[2]) & ~data_a[1] ;	
assign p_b_fall_3 = (data_b[1] ^ data_b[2]) & ~data_b[1] ;	
assign p_c_fall_3 = (data_c[1] ^ data_c[2]) & ~data_c[1] ;	
assign p_d_fall_3 = (data_d[1] ^ data_d[2]) & ~data_d[1] ;	

always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
  begin
	a_rise_3 <= 1'b0  ; 
	b_rise_3 <= 1'b0  ; 
	c_rise_3 <= 1'b0  ; 
	d_rise_3 <= 1'b0  ; 
	a_fall_3 <= 1'b0  ; 
	b_fall_3 <= 1'b0  ; 
	c_fall_3 <= 1'b0  ; 
	d_fall_3 <= 1'b0  ; 
  end 
else begin
	a_rise_3 <= p_a_rise_3 ;	
	b_rise_3 <= p_b_rise_3 ;	
	c_rise_3 <= p_c_rise_3 ;	
	d_rise_3 <= p_d_rise_3 ;	
	a_fall_3 <= p_a_fall_3 ;	
	b_fall_3 <= p_b_fall_3 ;	
	c_fall_3 <= p_c_fall_3 ;	
	d_fall_3 <= p_d_fall_3 ;	
  end 

//*****************************************************************************
//***************** selection
//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
  begin
	sel_a <= 1'b0  ; 
	sel_b <= 1'b0  ; 
	sel_c <= 1'b0  ; 
	sel_d <= 1'b0  ; 
  end 
else begin
   if ( (a_rise_3 & ~b_rise_3 & ~c_rise_3 & ~d_rise_3 ) | (a_fall_3 & ~b_fall_3 & ~c_fall_3 & ~d_fall_3 ) ) begin
	sel_a <= 1'b0 ;
	sel_b <= 1'b0 ;
	sel_c <= 1'b1 ;
	sel_d <= 1'b0 ;
   end
   else if ( (~a_rise_3 &  b_rise_3 & ~c_rise_3 & ~d_rise_3 ) | (~a_fall_3 &  b_fall_3 & ~c_fall_3 & ~d_fall_3 ) ) begin
	sel_a <= 1'b0 ;
	sel_b <= 1'b0 ;
	sel_c <= 1'b0 ;
	sel_d <= 1'b1 ;
   end
   else if ( ( a_rise_3 & ~b_rise_3 &  c_rise_3 & ~d_rise_3 ) | ( a_fall_3 & ~b_fall_3 &  c_fall_3 & ~d_fall_3 ) ) begin
	sel_a <= 1'b1 ;
	sel_b <= 1'b0 ;
	sel_c <= 1'b0 ;
	sel_d <= 1'b0 ;
   end
   else if ( (~a_rise_3 & ~b_rise_3 & ~c_rise_3 &  d_rise_3 ) | (~a_fall_3 & ~b_fall_3 & ~c_fall_3 &  d_fall_3 ) ) begin
	sel_a <= 1'b0 ;
	sel_b <= 1'b1 ;
	sel_c <= 1'b0 ;
	sel_d <= 1'b0 ;
   end
  end

//*****************************************************************************
//***************** selection
//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
  begin
	cdr_phase_sel_a <= 2'b0  ; 
	cdr_phase_sel_old <= 2'b0  ; 
  end 
else if ( dpa_cdr_disable) 
  begin
	cdr_phase_sel_a <= 2'b0  ; 
	cdr_phase_sel_old <= 2'b0  ; 
  end 
else if (!dpa_only_done) begin
	cdr_phase_sel_a <= sel_a ? 2'b00 : 
	                 sel_b ? 2'b01 :
	                 sel_c ? 2'b10 :
	                 sel_d ? 2'b11 : 2'b11  ;
	cdr_phase_sel_old <= cdr_phase_sel_a  ; 
  end

always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
  begin
	cdr_phase_sel <= 2'b0  ; 
  end 
else if ( dpa_cdr_disable) 
  begin
	cdr_phase_sel <= cdr_phase_sel_a  ; 
  end 
else if (cdr_cnr_eq_1) begin
	cdr_phase_sel <= cdr_phase_sel_a  ; 
  end

assign cdr_cnr_eq_1 = !(|cdr_cnt[PAR_CNT_WID-1 :1]) && cdr_cnt[0] ;
//*****************************************************************************
//***************** first lock after reset
//***************** dpa_mode = 1,  only allow perform DPA align once  after reset
//***************** but you can use restart to restart the DPA align.
//***************** soft_cdr more automatic start align when phase change detected
//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
	first_lock_done <= 1'b0  ; 
else if (restart_rise )
	first_lock_done <= 1'b0  ; 
else if ( !first_lock_done && dpa_lock )
	first_lock_done <= 1'b1  ; 

 assign dpa_only_done = first_lock_done && dpa_mode ; // || dpa_cdr_disable ;// allow change only when dpa_only_done=0

//*****************************************************************************
//********* generate reset signal to sync_fifo after lock
//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
	first_lock_done_d1 <= 1'b0  ; 
else 
	first_lock_done_d1 <= first_lock_done  ; 

assign dpa_first_lock_rise = !first_lock_done_d1 & first_lock_done ;
//*****************************************************************************
//***************** 64 bit count and lock
//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
	cdr_cnt <= {(PAR_CNT_WID){1'b1}}  ; 
else if ((phase_change_cp || !sel_valid ) && !dpa_only_done || restart_rise)
	cdr_cnt <= {(PAR_CNT_WID){1'b1}}   ; 
else if (|cdr_cnt )
	cdr_cnt <= cdr_cnt - 1'b1  ; 

always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
	dpa_lock      <= 1'b0  ; 
else if ((phase_change_cp || !sel_valid ) && !dpa_only_done || (|cdr_cnt) )
	dpa_lock      <= 1'b0  ;  // always 1 for dpa_cdr_disabled
else 
	dpa_lock      <= 1'b1  ; 

always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
	dpa_error      <= 1'b0  ; 
else if (!(|cdr_cnt[PAR_CNT_WID-1 :1]) && cdr_cnt[0] && !sel_valid )
	dpa_error      <= !dpa_cdr_disable  ;  // always 1 for dpa_cdr_disabled
//*****************************************************************************
//***************** cross clock domain and rising edge, can be replaced by nds_sync_l2l
//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
	restart_sync <= 3'b000  ; 
else
	restart_sync <= {restart_sync[1:0] , restart}  ; 

assign restart_rise = restart_sync[1] && !restart_sync[2] && !dpa_cdr_disable && dpa_lock;

//*****************************************************************************
always @(posedge clk[0] or negedge fast_reset_sync_0_n)
if (!fast_reset_sync_0_n)
	mode_d1 <= 2'b00  ; 
else
	mode_d1 <= mode  ; 

assign soft_cdr        = mode_d1 == 2'b10 ;
assign dpa_mode        = mode_d1 == 2'b11 ;
assign dpa_cdr_disable = !mode_d1[1] ;  

//*****************************************************************************
endmodule
