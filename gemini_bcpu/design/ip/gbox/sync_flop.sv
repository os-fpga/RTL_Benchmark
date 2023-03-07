/********************************
 * Module: 	sync_flop
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : pararmeterized domain crossing synchroniser 
********************************/

module sync_flop
#(
   parameter PAR_STAGE = 2
)
(
  reset_n,
  clk, 
  din, 
//*******************************
  dout 
);
//*****************************************************************************
  input  clk;
  input  reset_n;
  input  din;
  output dout;
//*****************************************************************************

logic [PAR_STAGE-1:0]  sync_stages_output;
logic [PAR_STAGE-1:0]  sync_stages_input;

assign sync_stages_input[PAR_STAGE-1:0] = {sync_stages_output[PAR_STAGE-2:0], din};
assign dout = sync_stages_output[PAR_STAGE-1];

always @(posedge clk or negedge reset_n)
  if (!reset_n)
      sync_stages_output <= 'b0 ;
  else       
      sync_stages_output <= sync_stages_input;

//*****************************************************************************
endmodule
