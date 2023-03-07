/********************************
 * Module: 	gbox_bslip
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox bitSlip
********************************/
module gbox_slip
#(
   parameter PAR_DWID = 10
)
(
  input  rx_fast_reset_sync_n, // synced fast clock reset  for rx
  input  rx_core_reset_sync_n, // synced core clock reset  for rx
  input  pll_lock ,  
  input  [3:0] rate_sel  ,  
  input  fast_clk,  // Input fast Clock
  input  data_in , // fast clock domain
  input  core_clk , // core clock domain
  input  bitslip_adj , // core clock domain
//****************************
  output logic bitslip_done , // core clock domain
  output logic bitslip_dout 
);
//*****************************************************************************
logic bitslip_adj_d1;
logic bitslip_adj_sync;
logic bitslip_adj_sync_d1;
logic bitslip_adj_rise;
logic [3:0] bslip_cnt ;
logic [3:0] bslip_cnt_add1 ;
logic [PAR_DWID-1:0] data_shift ;
logic p_bitslip_dout;
//*****************************************************************************
//************ core clock stage 
//*****************************************************************************
always_ff @(posedge core_clk or negedge rx_core_reset_sync_n)
 if (~rx_core_reset_sync_n) 
    bitslip_adj_d1 <= 'b0;
 else 
    bitslip_adj_d1 <= bitslip_adj;
//*****************************************************************************
sync_flop u_sync_flop_bslip (
  .reset_n (rx_fast_reset_sync_n),
  .clk (fast_clk), 
  .din (bitslip_adj_d1), 
//*******************************
  .dout (bitslip_adj_sync) 
);
//*****************************************************************************
always_ff @(posedge fast_clk or negedge rx_fast_reset_sync_n)
 if (~rx_fast_reset_sync_n) 
    bitslip_adj_sync_d1 <= 'b0;
 else 
    bitslip_adj_sync_d1 <= bitslip_adj_sync;

assign bitslip_adj_rise = bitslip_adj_sync && !bitslip_adj_sync_d1 ;
//*****************************************************************************
assign bslip_cnt_add1 = bslip_cnt + 1'b1  ;

always_ff @(posedge fast_clk or negedge rx_fast_reset_sync_n)
 if (~rx_fast_reset_sync_n) 
    bslip_cnt <= 'b0;
 else if (bitslip_adj_rise) begin
   if (bslip_cnt_add1 < rate_sel)
    bslip_cnt <= bslip_cnt + 1'b1 ;
   else
    bslip_cnt <= 'b0 ;
 end

always_ff @(posedge core_clk or negedge rx_core_reset_sync_n)
 if (~rx_core_reset_sync_n) 
    bitslip_done <= 1'b1;
 else if ( !bitslip_adj_d1 && bitslip_adj)
    bitslip_done <= 1'b0;
 else 
    bitslip_done <= 1'b1;
//*****************************************************************************
//************ shifter stage 
//*****************************************************************************
always_ff @(posedge fast_clk or negedge rx_fast_reset_sync_n)
 if (~rx_fast_reset_sync_n) 
    data_shift <= 'b0;
 else 
    data_shift <= {data_shift[PAR_DWID-2:0],data_in};
//*****************************************************************************
//******* only supports PAR_DWID = 5 or 10
//*****************************************************************************
generate 
 if (PAR_DWID == 10) begin
  always @ (*) begin
    case (bslip_cnt[3:0]) 
      4'd1  : p_bitslip_dout = data_shift[1]  ;
      4'd2  : p_bitslip_dout = data_shift[2]  ;
      4'd3  : p_bitslip_dout = data_shift[3]  ;
      4'd4  : p_bitslip_dout = data_shift[4]  ;
      4'd5  : p_bitslip_dout = data_shift[5]  ;
      4'd6  : p_bitslip_dout = data_shift[6]  ;
      4'd7  : p_bitslip_dout = data_shift[7]  ;
      4'd8  : p_bitslip_dout = data_shift[8]  ;
      4'd9  : p_bitslip_dout = data_shift[9]  ;
	  default : p_bitslip_dout = data_shift[0]  ;
	endcase 
  end
 end
 else begin // PAR_DWID = 5
  always @ (*) begin
    case (bslip_cnt[3:0]) 
      4'd1  : p_bitslip_dout = data_shift[1]  ;
      4'd2  : p_bitslip_dout = data_shift[2]  ;
      4'd3  : p_bitslip_dout = data_shift[3]  ;
      4'd4  : p_bitslip_dout = data_shift[4]  ;
	  default : p_bitslip_dout = data_shift[0]  ;
	endcase 
  end
 end
endgenerate 
//*****************************************************************************
//************ final stage 
//*****************************************************************************
always_ff @(posedge fast_clk or negedge rx_fast_reset_sync_n)
 if (~rx_fast_reset_sync_n) 
    bitslip_dout <= 1'b0;
 else 
    bitslip_dout <= p_bitslip_dout;
//*****************************************************************************
endmodule
