/********************************
 * Module: 	gbox_des
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox de-serializer
********************************/

module gbox_des
#(
   parameter PAR_DWID = 10
)
(
  input  system_reset_n, // Input async system Reset
  input  pll_lock ,  
  input  rx_reset_n,  // Input sync Reset , core clock domain
  input  [3:0] rate_sel  ,  
  input  cfg_bypass  ,  
  input  cfg_dif  ,  
  input  cfg_peer_is_on  ,  
  input  fast_clk,  // Input fast Clock
  input  data_in , // fast clock domain
  input  word_load_en , // fast clock domain
  input  core_clk , 
  input  [5-1:0] peer_data_in , // core clock domain
//****************************
  output  rx_fast_reset_sync_n , // fast clock domain
  output  rx_core_reset_sync_n , // core clock domain
  output logic [PAR_DWID-1:0] des_data_out , // core clock domain 
  output logic  des_data_valid  // core clock domain 
);
//*****************************************************************************
logic a_reset_n;
logic fast_reset_sync_n;
logic core_reset_sync_n;
logic fast_reset_sync;
logic core_reset_sync;
logic f_peer_is_on;
logic [PAR_DWID-1:0] data_in_d1 ;
logic [PAR_DWID-1:0] des_fifo_dout ;
logic des_fifo_full;
logic des_fifo_emp;
//****************************************************************************A
generate 
 if (PAR_DWID == 10) begin
    assign f_peer_is_on      = !cfg_dif && cfg_peer_is_on ;
    assign des_data_out[4:0] = des_fifo_dout[4:0] ;
    assign des_data_out[9:5] = f_peer_is_on ? peer_data_in : des_fifo_dout[9:5] ;
 end
 else begin // PAR_DWID = 5
    assign des_data_out[4:0] = des_fifo_dout[4:0] ;
 end
endgenerate
//*****************************************************************************
assign a_reset_n = system_reset_n && !cfg_bypass && pll_lock &&  rx_reset_n;
assign fast_reset_sync_n = !fast_reset_sync ;
assign rx_fast_reset_sync_n = fast_reset_sync_n ;
assign core_reset_sync_n = !core_reset_sync ;
assign rx_core_reset_sync_n = core_reset_sync_n ;
assign des_data_valid    = !des_fifo_emp ;
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
//************ shifter stage 
//*****************************************************************************
always_ff @(posedge fast_clk or negedge fast_reset_sync_n)
 if (~fast_reset_sync_n) 
   begin
    data_in_d1 <= 'b0;
   end
 else 
   begin
    data_in_d1 <= {data_in_d1[PAR_DWID-2:0],data_in};
   end
//*****************************************************************************
//************ fifo stage , help timing closure
//************ working stage 
//*****************************************************************************
nds_async_fifo_afe # (
            .DATA_WIDTH(PAR_DWID) ,
            .FIFO_DEPTH(8) 
     ) u_des_word_fifo (
       .w_reset_n(fast_reset_sync_n),
       .r_reset_n(core_reset_sync_n),
       .w_clk(fast_clk) ,
       .r_clk(core_clk),
       .wr(word_load_en && !des_fifo_full),
       .wr_data(data_in_d1),
       .rd(!des_fifo_emp),
//****************************
       .rd_data(des_fifo_dout),
       .almost_empty( ),
       .almost_full( ),
       .empty(des_fifo_emp),
       .full(des_fifo_full)
);

//*****************************************************************************
endmodule
