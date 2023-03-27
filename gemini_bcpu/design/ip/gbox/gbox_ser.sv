/********************************
 * Module: 	gbox_ser
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox serializer
********************************/
module gbox_ser
#(
   parameter PAR_DWID = 10
)
(
  input  system_reset_n, // Input async system Reset
  input  tx_reset_n,  // Input sync Reset , core clock domain
  input  [3:0] rate_sel  ,  
  input  cfg_bypass  ,  
  input  fast_clk,  // Input fast Clock
  input  word_load_en , // fast clock domain
  input  core_clk , 
  input  [PAR_DWID-1:0] data_in , // core clock domain
  input  data_valid , // core clock domain
  input  data_oe , // core clock domain
//****************************
  output logic ser_out , // serial data out
  output logic ser_oe  // serial data out enable
);
//*****************************************************************************

logic a_reset_n;
logic data_valid_d1;
logic [PAR_DWID-1:0] fifo_data_out ;
logic [PAR_DWID-1:0] data_in_d2 ;
logic [PAR_DWID-1:0] data_in_d3 ;
logic [PAR_DWID-1:0] shift_data_in_d2 ;
logic fifo_data_oe;
logic data_oe_d2;
logic data_oe_d3;
logic ser_sfifo_aful;
logic ser_sfifo_emp;
logic ser_sfifo_aful_sync;
logic ser_sfifo_emp_sync;
logic fifo_pop_en;
logic f_word_load_en;

//*****************************************************************************
assign a_reset_n = system_reset_n && !cfg_bypass ;
assign ser_out = data_in_d3[PAR_DWID-1] ; 
assign ser_oe = data_oe_d3 ; 
//*****************************************************************************
//************ staging flop , help timing closure
//*****************************************************************************
nds_sync_fifo_afe # (
            .DATA_WIDTH(PAR_DWID+1) ,
            .FIFO_DEPTH(4) ,
            .ALMOST_FULL_THRESHOLD(2) 
     ) u_rx_ser_sfifo (
    .reset_n(a_reset_n),
    .clk(core_clk),
    .wr(data_valid),
    .wr_data({data_oe, data_in}),
    .rd(ser_sfifo_aful),
//************ 
    .rd_data({fifo_data_oe, fifo_data_out}),
    .almost_empty(),
    .almost_full(ser_sfifo_aful),
    .empty(ser_sfifo_emp),
    .full()
);
//*****************************************************************************

///// always_ff @(posedge core_clk or negedge a_reset_n)
/////  if (~a_reset_n) 
/////    begin
/////     data_valid_d1 <= 1'b0;
/////     data_in_d1 <= 'b0;
/////     data_oe_d1 <= 1'b0;
/////    end
/////  else if (!tx_reset_n)
/////    begin
/////     data_valid_d1 <= 1'b0;
/////     data_in_d1 <= 'b0;
/////     data_oe_d1 <= 1'b0;
/////    end
/////  else 
/////    begin
/////     data_valid_d1 <= data_valid ;
/////     data_in_d1 <= data_in;
/////     data_oe_d1 <= data_oe;
/////    end

//*****************************************************************************
sync_flop u_sync_flop_ser_aful (
  .reset_n (a_reset_n),
  .clk (fast_clk), 
  .din (ser_sfifo_aful), 
//*******************************
  .dout (ser_sfifo_aful_sync) 
);
//*****************************************************************************
sync_flop u_sync_flop_ser_emp (
  .reset_n (a_reset_n),
  .clk (fast_clk), 
  .din (ser_sfifo_emp), 
//*******************************
  .dout (ser_sfifo_emp_sync) 
);
//*****************************************************************************
always_ff @(posedge fast_clk or negedge a_reset_n)
 if (~a_reset_n) 
    fifo_pop_en <= 1'b0;
 else if (ser_sfifo_emp_sync)
    fifo_pop_en <= 1'b0;
 else if (ser_sfifo_aful_sync)
    fifo_pop_en <= 1'b1;

assign f_word_load_en = word_load_en && fifo_pop_en ;
//*****************************************************************************
//************ working stage 
//*****************************************************************************
always_ff @(posedge fast_clk or negedge system_reset_n)
 if (~system_reset_n) 
   begin
    data_in_d2 <= 'b0;
    data_oe_d2 <= 1'b0;
   end
 else if (f_word_load_en)
   begin
    data_in_d2 <= fifo_data_oe;
    data_oe_d2 <= fifo_data_out;
   end
//*****************************************************************************
//************ shifter stage 
//*****************************************************************************
always_ff @(posedge fast_clk or negedge system_reset_n)
 if (~system_reset_n) 
   begin
    data_in_d3 <= 'b0;
    data_oe_d3 <= 1'b0;
   end
 else if (f_word_load_en)
   begin
    data_in_d3 <= shift_data_in_d2;
    data_oe_d3 <= data_oe_d2;
   end
 else 
   begin
    data_in_d3 <= {data_in_d3[PAR_DWID-2:0],1'b0};
    data_oe_d3 <= data_oe_d2;
   end
//*****************************************************************************
//******* only supports PAR_DWID = 5 or 10
//*****************************************************************************
generate 
 if (PAR_DWID == 10) begin
  always @ (*) begin
    case (rate_sel[3:0]) 
      4'd3  : shift_data_in_d2 = {data_in_d2[2:0] , 7'd0} ;
      4'd4  : shift_data_in_d2 = {data_in_d2[3:0] , 6'd0} ;
      4'd5  : shift_data_in_d2 = {data_in_d2[4:0] , 5'd0} ;
      4'd6  : shift_data_in_d2 = {data_in_d2[5:0] , 4'd0} ;
      4'd7  : shift_data_in_d2 = {data_in_d2[6:0] , 3'd0} ;
      4'd8  : shift_data_in_d2 = {data_in_d2[7:0] , 2'd0} ;
      4'd9  : shift_data_in_d2 = {data_in_d2[8:0] , 1'b0} ;
      4'd10 : shift_data_in_d2 = {data_in_d2[9:0]       } ;
	  default : shift_data_in_d2 = 'b0 ;
	endcase 
  end
 end
 else begin // PAR_DWID = 5
  always @ (*) begin
    case (rate_sel[2:0]) 
      3'd3  : shift_data_in_d2 = {data_in_d2[2:0] , 2'd0} ;
      3'd4  : shift_data_in_d2 = {data_in_d2[3:0] , 1'b0} ;
      3'd5  : shift_data_in_d2 = {data_in_d2[4:0]       } ;
	  default : shift_data_in_d2 = 'b0 ;
	endcase 
  end
 end
endgenerate 
//*****************************************************************************
endmodule

